# frozen_string_literal: true

class YoutubeDownload
  attr_reader :link, :max_filesize, :retries, :paths

  class DownloadError < StandardError; end

  DEFAULT_CONFIG = {
    max_filesize: "1G",
    retries: 5,
    paths: "public/dl"
  }.freeze

  def initialize(link)
    @link = strip_query_params(link)
    @max_filesize = ENV.fetch("MAX_FILESIZE", DEFAULT_CONFIG[:max_filesize])
    @retries = ENV.fetch("RETRIES", DEFAULT_CONFIG[:retries])
    @paths = ENV.fetch("PATHS", DEFAULT_CONFIG[:paths])
  end

  def call
    Rails.logger.tagged("YT").info("Download has been started")

    command = build_command
    Rails.logger.tagged("YT").info("YT-DLP: #{command}")

    stdout, stderr, status = execute_command(command)

    if status.success?
      process_successful_download(stdout)
    else
      handle_download_failure(stderr)
    end
  end

  private

  def build_command
    [
      "yt-dlp #{link}",
      "--max-filesize #{max_filesize}",
      "--no-playlist",
      "--retries #{retries}",
      "--windows-filenames",
      "--extract-audio",
      "--audio-format mp3",
      "--no-keep-video",
      "--paths #{paths}",
      "--print after_move:filepath",
      "--restrict-filenames"
    ].join(" ")
  end

  def execute_command(command)
    Open3.capture3(command)
  end

  def process_successful_download(stdout)
    Rails.logger.tagged("YT").info "YT-DLP: Success"
    relative_path = calculate_relative_path(stdout)
    Rails.logger.tagged("YT").info "Download has been finished (#{relative_path})"
    relative_path
  end

  def calculate_relative_path(stdout)
    Pathname.new(stdout.strip).relative_path_from(Rails.root.join("public"))
  end

  def handle_download_failure(stderr)
    Rails.logger.tagged("YT").error "Download failed: #{stderr.strip}"
    raise DownloadError, stderr.strip
  end

  def strip_query_params(link)
    link.gsub(/&.*$/, "")
  end
end
