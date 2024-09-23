# frozen_string_literal: true

class YoutubeLinkValidator
  YOUTUBE_LINK_REGEX = %r{
    ^(https?:\/\/)?
    (www\.)?
    (youtube\.com|youtu\.be|m\.youtube\.com|music\.youtube\.com|gaming\.youtube\.com)
    \/(watch\?v=|embed\/|v\/|.+\?v=)?([a-zA-Z0-9_-]{11})
    (&.*)?$
  }x

  attr_reader :link

  def initialize(link)
    @link = link
  end

  def valid?
    link.present? && link.match?(YOUTUBE_LINK_REGEX)
  end
end

