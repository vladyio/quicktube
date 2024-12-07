# frozen_string_literal: true

class FilePathValidator
  attr_reader :file_path, :base_path

  DEFAULT_BASE_PATH = "public/dl"
  ALLOWED_EXTENSION = ".mp3"

  def initialize(file_path)
    @file_path = file_path
    @base_path = ENV.fetch("PATHS", DEFAULT_BASE_PATH)
  end

  def valid?
    starts_with_base_path? && ends_with_allowed_extension? && file_exists?
  end

  private

  def starts_with_base_path?
    file_path.to_s.start_with?(base_path.to_s)
  end

  def ends_with_allowed_extension?
    file_path.to_s.end_with?(".mp3")
  end

  def file_exists?
    Pathname.new(file_path).exist?
  end
end
