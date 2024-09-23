# frozen_string_literal: true

class DownloadController < ApplicationController
  def index
    link = params[:link]

    if YoutubeLinkValidator.new(link).valid?
      jid = DownloadJob.perform_async(link)

      render json: { jid: }
    else
      render json: { jid: nil }, status: :unprocessable_entity
    end
  end

  def show
    filename = params[:filename]
    file_path = Rails.root.join('public', 'dl', filename)

    Rails.logger.info("[DL] Downloading: #{filename}, path: #{file_path}")

    if Pathname.new(file_path).exist?
      Rails.logger.info("[DL] File found, sending for download")
      send_file file_path, disposition: 'attachment'
    else
      Rails.logger.warn("[DL] File not found: #{filename}")
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end
end
