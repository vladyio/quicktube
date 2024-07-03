require 'fileutils'

class DlCleanup
  def self.call
    dl_dir = Rails.root.join('public', 'dl')
    FileUtils.rm_rf(dl_dir)

    puts "Removed all files from #{dl_dir}"
  end
end
