RSpec.configure do |config|
  config.before(:suite) do
    unless ['all', 'each', ''].include?(ENV['RSPEC_PROFILE'].to_s)
      raise "ENV['RSPEC_PROFILE'] should be blank, 'all' or 'each', but was '#{ENV['RSPEC_PROFILE']}'"
    end

    if ENV['RSPEC_PROFILE'] == 'all'
      @profiler = RSpecProf.new.start
    end
  end

  config.after(:suite) do
    if ENV['RSPEC_PROFILE'] == 'all'
      @profiler.save_to  "profiles/all.html"
    end
  end

  config.around(:each) do |example|
    if ENV['RSPEC_PROFILE'] == 'each'
      RSpecProf.profile(RSpecProf.filename_for(example)) { example.call }
    else
      example.call
    end
  end
end
