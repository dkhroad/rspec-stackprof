require 'spec_helper'

describe RSpec::StackProf do
  it 'has a version number' do
    expect(RSpec::StackProf::VERSION).not_to be nil
  end

  it 'returns valid options hash' do
    expect(RSpec::StackProf.options).to include({
      out_dir: 'tmp',
      out_file: 'stackprof.out'
    })

    expect(RSpec::StackProf.options[:out]).to match(%r{tmp/stackprof_\d{5}_\d{10}.out})
  end

end
