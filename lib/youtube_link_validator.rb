# frozen_string_literal: true

class YoutubeLinkValidator
  YOUTUBE_LINK_REGEX = /^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S*\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})(?:\S+)?$/

  attr_reader :link

  def initialize(link)
    @link = link
  end

  def valid?
    link.present? && link.match?(YOUTUBE_LINK_REGEX)
  end
end

