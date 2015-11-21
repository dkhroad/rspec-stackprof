require 'fileutils'
require 'stackprof'
require 'rspec/core'
require 'rspec-prof/filename_helpers'

module RSpec
class StackProf 
  extend FilenameHelpers

  @printer_class = RubyProf::GraphHtmlPrinter

  class << self
    attr_accessor :configuration

    def profile filename
      profiler = new.start
      yield
    ensure
      profiler.save_to filename
    end
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def start
    return if @profiling
    @profiling = true
    RubyProf.start
    self
  end

  def stop
    return unless @profiling
    @profiling = false
    @result = RubyProf.stop
  end

  def profiling?
    @profiling
  end

  def result
    @result
  end

  def save_to filename
    stop
    FileUtils.mkdir_p File.dirname(filename)
    File.open(filename, "w") do |f|
      printer = RSpecProf.printer_class.new(result)
      printer.print f
    end
  end

  class Configuration 
    attr_accessor :flamegraph
    def initialize 
      @flamegraph = false
    end
  end
end
end
