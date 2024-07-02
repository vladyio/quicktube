# frozen_string_literal: true

class DownloadChannel < ApplicationCable::Channel
  def subscribed
    stream_from "download_#{params[:jid]}"
  end
end
