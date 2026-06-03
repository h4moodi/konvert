# Konvert

A privacy-first, local-only file conversion application.

## Overview

Konvert allows you to easily convert between various image, video, audio, and document formats directly on your machine. With a sleek, modern user interface, it ensures your data remains secure and never leaves your computer.

## Features

- **Local & Private:** Conversions happen entirely on your own hardware using robust local open-source tools. No data is uploaded to the web.
- **Supported Formats:**
  - **🖼️ Images:** png, jpg, jpeg, gif, webp, bmp, tiff, avif
  - **🎬 Video:** mp4, mkv, avi, mov, webm
  - **🎵 Audio:** mp3, wav, flac, ogg, aac, m4a
  - **📄 Documents:** pdf, docx, txt, html, md, epub
- **Desktop Ready:** Built to be packaged as a lightweight native desktop application using Tauri.
- **Modern UI:** Crafted with Tailwind CSS, featuring intuitive drag-and-drop support and a built-in dark/light mode toggle.

## Prerequisites

Konvert relies on the following command-line tools for its conversion engine. Ensure they are installed and available in your system's `PATH`:

- **[ImageMagick](https://imagemagick.org/)** (`convert`) - For image conversions.
- **[FFmpeg](https://ffmpeg.org/)** (`ffmpeg`) - For audio and video conversions.
- **[Pandoc](https://pandoc.org/)** (`pandoc`) - For document conversions.

You will also need:
- **[Ruby](https://www.ruby-lang.org/)** - To run the Sinatra backend server.
- **[Rust](https://www.rust-lang.org/)** & **Cargo** - For packaging the app using Tauri.

## Setup & Running

1. **Install Ruby dependencies:**
   ```bash
   gem install sinatra
   ```

2. **Start the local server:**
   ```bash
   ruby app.rb
   ```
   The Sinatra backend will start on `http://localhost:4567`. You can visit this URL in your web browser to use the app.

3. **Desktop Application (Tauri):**
   Navigate to the `src-tauri` directory and use standard Tauri commands (e.g., `cargo tauri dev` or `npm run tauri dev` if a package.json is configured) to run or build the native desktop wrapper.

## License
MIT
