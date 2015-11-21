module Rspec
  class Stackprof
    module FilenameHelpers
      @output_dir = "profiles"
      @file_extension = "dump"

      class << self
        attr_accessor :output_dir
        attr_accessor :file_extension
      end

      def output_dir
        RSpec::Stackprof::FilenameHelpers.output_dir
      end

      def file_extension
        RSpec::Stackprof::FilenameHelpers.file_extension
      end

      def path_for metadata
        if metadata[:parent_example_group]
          File.join(path_for(metadata[:parent_example_group]), metadata[:description])
        else
          metadata[:description]
        end
      end

      def filename_for example
        path = path_for(example.metadata[:example_group])
        line_number = example.metadata[:line_number].to_s
        description = example.metadata[:description]
        File.join(
          output_dir,
          path,
          description
        ).gsub(/\s+/, '-') + ":" + line_number + ".#{file_extension}"
      end
    end
  end
end
