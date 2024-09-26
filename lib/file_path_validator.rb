# frozen_string_literal: true

class FilePathValidator
  attr_reader :file_path, :base_path

  DEFAULT_BASE_PATH = "public/dl"

  def initialize(file_path)
    @file_path = file_path
    @base_path = ENV.fetch("PATHS", DEFAULT_BASE_PATH)
  end

  def valid?
    file_path.to_s.start_with?(base_path.to_s) && Pathname.new(file_path).exist?
  end
end
