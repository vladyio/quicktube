# frozen_string_literal: true

class YoutubeDownload
  attr_reader :link, :max_filesize, :retries, :paths

  class DownloadError < StandardError
    VIDEO_UNAVAILABLE = "Video unavailable"

    def initialize(message)
      @original_message = message
    end

    def message
      if @original_message.match?(VIDEO_UNAVAILABLE)
        VIDEO_UNAVAILABLE
      else
        @original_message
      end
    end
  end

  DEFAULT_CONFIG = {
    max_filesize: '1G',
    retries: 5,
    paths: 'public/dl'
  }.freeze

  def initialize(link)
    @link = link
    @max_filesize = ENV.fetch('MAX_FILESIZE', DEFAULT_CONFIG[:max_filesize])
    @retries = ENV.fetch('RETRIES', DEFAULT_CONFIG[:retries])
    @paths = ENV.fetch('PATHS', DEFAULT_CONFIG[:paths])
  end

  def call
    Rails.logger.info "[YT] Download has been started"

    command = "yt-dlp #{link} \
    --max-filesize #{max_filesize} \
    --no-playlist \
    --retries #{retries} \
    --windows-filenames \
    --extract-audio \
    --audio-format mp3 \
    --no-keep-video \
    --paths #{paths} \
    --print after_move:filepath"

    Rails.logger.info "[YT] YT-DLP: #{command}"

    stdout, stderr, status = Open3.capture3(command)

    if status.success?
      Rails.logger.info "[YT] YT-DLP: Success"

      relative_path = Pathname.new(stdout.strip).relative_path_from(Rails.root.join('public'))

      Rails.logger.info "[YT] Download has been finished (#{relative_path})"

      relative_path
    else
      Rails.logger.error "[YT] Download failed: #{stderr.strip}"
      raise DownloadError, stderr.strip
    end
  end
end
