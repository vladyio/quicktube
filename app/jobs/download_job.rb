# frozen_string_literal: true

class DownloadJob
  include Sidekiq::Job

  def perform(link)
    file_path = YoutubeDownload.new(link).call

    ActionCable.server.broadcast "download_#{jid}", { status: :complete, message: file_path }
  rescue YoutubeDownload::DownloadError, StandardError => e
    Rails.logger.error "[YoutubeDownload (#{link})] #{e.message}"

    ActionCable.server.broadcast "download_#{jid}", { status: :error, message: e.message }
  end
end
