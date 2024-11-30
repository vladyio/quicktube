# frozen_string_literal: true

class DownloadController < ApplicationController
  def index
    link = params[:link]

    if YoutubeLinkValidator.new(link).valid?
      jid = DownloadJob.perform_async(link)

      render json: { jid: }
    else
      render json: { jid: nil, message: "Invalid or unsupported YouTube link" }, status: :unprocessable_entity
    end
  end

  def show
    filename = params[:filename]
    file_path = Rails.root.join("public", "dl", filename).realdirpath

    Rails.logger.tagged("DL").info("Downloading: #{filename}, path: #{file_path}")

    if FilePathValidator.new(file_path).valid?
      Rails.logger.tagged("DL").info("File found, sending for download")
      send_file file_path, disposition: "attachment"
    else
      Rails.logger.tagged("DL").warn("File not found: #{filename}")
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end
end
