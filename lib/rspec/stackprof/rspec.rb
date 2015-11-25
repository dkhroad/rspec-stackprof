RSpec.configure do |config|
  
  config.before(:suite) do
    unless ['all', 'each', ''].include?(ENV['RSPEC_STACKPROF'].to_s)
      raise "ENV['RSPEC_STACKPROF'] should be blank, 'all' or 'each', but was '#{ENV['RSPEC_STACKPROF']}'"
    end

    if ENV['RSPEC_STACKPROF'] == 'all'
      StackProf.start RSpec::StackProf.options
    end
  end

  config.after(:suite) do
    if ENV['RSPEC_STACKPROF'] == 'all'
      StackProf.stop 
      StackProf.results
    end
  end

  config.around(:each) do |example|
    if ENV['RSPEC_STACKPROF'] == 'each'
      RSpec::StackProf.configuration.out_file = RSpec::StackProf::filename_for(example)
      StackProf.run(RSpec::StackProf.options) { example.call }
    else
      example.call
    end
  end
end
