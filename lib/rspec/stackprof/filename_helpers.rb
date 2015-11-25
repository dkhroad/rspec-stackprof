module RSpec
  class StackProf
    module FilenameHelpers

      def output_dir
        RSpec::StackProf.configuration.out_dir
      end

      def output_file
        RSpec::StackProf.configuration.out_file
      end

      def file_extension
        ext = File.extname(RSpec::StackProf.configuration.out_file)
        return  ".out" if ext.length == 0
        return ext
      end

      def file_basename
        File.basename(RSpec::StackProf.configuration.out_file,".*")
      end

      def file_dirname
        File.dirname(RSpec::StackProf.configuration.out_file)
      end

      def path_for metadata
        if metadata[:parent_example_group]
          File.join(path_for(metadata[:parent_example_group]), metadata[:description])
        else
          metadata[:description]
        end
      end

      def uniqueness 
        "#{Process.pid}_#{Time.now.to_i}"
      end

      def create_missing_dirs
        dirname = File.dirname(File.join(output_dir,output_file))
        FileUtils.mkdir_p(dirname)
      end

      def create_unique_file_name 
        "#{file_basename}_#{uniqueness}#{file_extension}"
      end

      def filename_for example
        require 'pry'
        raise "No example specified" if example.nil? 
        path = path_for(example.metadata[:example_group])
        line_number = example.metadata[:line_number].to_s
        description = example.metadata[:description]
        File.join(
          path,
          description
        ).gsub(/\s+/, '_') + ":" + line_number 
      end
    end
  end
end
