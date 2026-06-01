require 'sinatra'
require 'tempfile'
require 'shellwords'

set :public_folder, 'public'
set :port, 4567

CONVERTERS = {
  image:    ->(inp, out) { system("convert #{inp} #{out}") },
  video:    ->(inp, out) { system("ffmpeg -y -i #{inp} #{out}") },
  audio:    ->(inp, out) { system("ffmpeg -y -i #{inp} #{out}") },
  document: ->(inp, out) { system("pandoc #{inp} -o #{out}") }
}

CATEGORIES = {
  %w[png jpg jpeg gif webp bmp tiff avif] => :image,
  %w[mp4 mkv avi mov webm]               => :video,
  %w[mp3 wav flac ogg aac m4a]           => :audio,
  %w[pdf docx txt html md epub]          => :document
}

def detect_category(ext)
  CATEGORIES.find { |exts, _| exts.include?(ext) }&.last
end

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

post '/convert' do
  file   = params[:file]
  format = params[:format]&.downcase&.strip

  halt 400, 'No file uploaded'  unless file
  halt 400, 'No format specified' unless format

  original  = file[:filename]
  ext       = File.extname(original).delete('.').downcase
  category  = detect_category(ext)

  halt 400, "Unsupported file type: #{ext}" unless category

  converter = CONVERTERS[category]
  halt 400, 'No converter for this category' unless converter

  input_tmp  = Tempfile.new(['konvert_in',  ".#{ext}"])
  output_tmp = Tempfile.new(['konvert_out', ".#{format}"])

  begin
    input_tmp.write(file[:tempfile].read)
    input_tmp.close

    success = converter.call(
      Shellwords.escape(input_tmp.path),
      Shellwords.escape(output_tmp.path)
    )

    halt 500, 'Conversion failed' unless success

    content_type 'application/octet-stream'
    attachment   "#{File.basename(original, '.*')}.#{format}"
    output_tmp.read
  ensure
    input_tmp.unlink  rescue nil
    output_tmp.unlink rescue nil
  end
end