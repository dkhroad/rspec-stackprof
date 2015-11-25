# RSpec::StackProf

Provides a convenient way to profile your specs using [stackprof](https://github.com/tmm1/stackprof) gem by
integrating stackprof gem with your RSpec setup.

Specs can be profiled at suite level or indvidually.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-stackprof'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-stackprof

## Usage

Profiling can be enabled by setting environment variable `RSPEC_STACKPROF` while running `rspec` command.
1. To profile the whole test suite, set `RSPEC_STACKPROF` variable to `all` while running the command to 
invoke `rspec`.

  Example:

  ```
  RSPEC_STACKPROF=all rspec ...
  ```
  
  profiled output is stored in `./tmp/stackprof_<pid>_<timestamp>.out`. 

2. To profile each test individually, set `RSPEC_STACKPROF` environment variable to `each`

  Example:

  ```
  RSPEC_STACKPROF=each rspec ..
  ```
  profiled output is stored individually for each rspec example. A unique filename is constructed 
  by examining spec metadata. A sub directory is created for each 'describe' and 'context' block  

  For example, given a spec like:

  ```
     describe "main context" do 
       ..
       context "primary context" do 
       .. 
         it "does something" do 
         end
       end 
     end
  ```
  The profiled data will be stored at the following path:
  ```
  ./tmp/main_context/primary_context/does_something.<pid>.<timestamp>.out
  ```

### Configuration

You can configure following parameters for this gem.

* out_dir 

  directory location where profile data will be stored. When using `RSPEC_STACKPROF=each` option,
  subdirectories will be created under this dir

* out_file

  filename where profile results is stored when using `RSPEC_STACKPROF=all` option.


In addition, you can configure all Stackprof parameters (`mode`, `interval`, 'agregate`, `raw`) as well. 

Add a file `spec/support/rspec_stackprof.rb` and add/change configuration parameters. For example:

``` 
RSpec::StackProf.configure do |config|
  config.out_dir = '/tmp/profiles'
  config.mode = :wall 
  config.interval = 500
end
```
See [stackprof](https://github.com/tmm1/stackprof) readme to learn about stackprof usage.

### Generating Flamegraphs

Set the option `raw` to true

```
RSpec::StackProf.configure do |config|
  config.raw = true
end 
```

After profiling, run the following stackprof commands:

```
stackprof --stackcollapse tmp/stackprof.out > tmp/stackprof_collapsed.out
stackprof-flamegraph.pl tmp/stackprof_collapsed.out > tmp/stackprof_collapsed.svg
```

Open the svg file in a browser to view the visual representation of your profiled data. 
Flamegraphs are extremely useful. If you are unfamiliar with flamegraphs, checkout [Brendan Gregg's site](http://www.brendangregg.com/flamegraphs.html) to learn more about flamegraphs 


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rspec-stackprof. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

