require 'spec_helper'

describe RSpec::StackProf::FilenameHelpers do 
  class DummyClass
    include RSpec::StackProf::FilenameHelpers
  end

  context "#filename_for" do 

    context "invalid args" do 

      it "raises error when no example is provided" do 
        expect {DummyClass.new.filename_for(nil)}.to raise_error(RuntimeError,/No example specified/)
      end

      it "raises error when invalid example is provided " do 
        expect {DummyClass.new.filename_for("some_example")}.to raise_error(NoMethodError,/undefined method/)
      end

    end

    context "valid args" do 
      before do 

      end

      it "returns an expected name" do 

        mdata = {
          example_group: { 
          parent_example_group: nil,
          description: 'some parent group description'
        },
          line_number: 20,
          description: 'some description',
        }
        a_example =  OpenStruct.new(metadata: mdata) 
        expect(DummyClass.new.filename_for(a_example)).to eq("some_parent_group_description/some_description:20")
      end

    end
  end
end
