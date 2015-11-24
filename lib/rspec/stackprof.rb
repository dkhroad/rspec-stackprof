require "rspec/stackprof/version"
require 'ostruct'
require 'fileutils'
require 'stackprof'
require 'rspec/stackprof/filename_helpers'
require 'rspec/stackprof/rspec.rb'

module RSpec
  class StackProf 
    extend FilenameHelpers

    class << self
      attr_accessor :configuration
    end

    def self.configuration 
      @configuration ||=  ::OpenStruct.new(
        out_dir: 'tmp',
        out_file: 'stackprof.out',
      )
    end

    def self.configure
      yield(configuration)
    end

    def self.options 
      create_dir_if_missing configuration.out_dir
      file=create_unique_file_name 
      {out: File.join(configuration.out_dir,file)}.merge(configuration.to_h)
    end
  end
end
