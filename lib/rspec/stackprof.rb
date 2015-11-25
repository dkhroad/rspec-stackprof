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
      create_missing_dirs
      file=create_unique_file_name 
      dirname = File.dirname(File.join(output_dir,output_file))
      {out: File.join(dirname,file)}.merge(configuration.to_h)
    end
  end
end
