require_relative 'clone_finder'

path, *params = ARGV
CloneFinder.new(folder: path).call
