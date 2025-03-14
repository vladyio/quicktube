# frozen_string_literal: true

class DownloadJob < ApplicationJob
  def perform(link)
    file_path = YoutubeDownload.new(link).call

    ActionCable.server.broadcast "download_#{job_id}", { status: :complete, message: file_path }
  rescue YoutubeDownload::DownloadError, StandardError => e
    Rails.logger.tagged(self.class.name, link).error(e.message)

    ActionCable.server.broadcast "download_#{job_id}", { status: :error, message: e.message }
  end
end
