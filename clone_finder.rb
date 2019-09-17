require 'digest'
require_relative 'clone'

class CloneFinder
  attr_reader :folder
  attr_accessor :folder_index

  def initialize(folder: Dir.pwd)
    @folder = folder
    @folder_index = {}
  end

  def call
    index_files(folder)
    find_clones.each(&:message)
  end

  private

  def index_files(path)
    Dir.children(path).each do |entry|
      full_path = path + '/' + entry
      File.directory?(full_path) ? index_files(full_path) : calculate_hash(full_path)
    end
  end

  def calculate_hash(full_path)
    md5 = Digest::MD5.hexdigest(File.read(full_path))

    if folder_index[md5].nil?
      folder_index[md5] = [full_path]
    else
      folder_index[md5] << full_path
    end
  end

  def find_clones
    folder_index.map do |hash, locations|
      Clone.new(hash, locations) if locations.count > 1
    end.compact
  end
end
