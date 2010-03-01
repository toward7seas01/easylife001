require "spec_helper"

describe Blog do
  before do
    @blog = Factory.stub(:blog01) 
  end

  it "should be in current initial stats" do
    @blog.should be_valid
    @blog.user.should be_valid
  end


  context "测试category" do
    context "在stub的情况下" do
      it "should not hava a category" do
        @blog.categories.should == []
      end

      it "should raise a error" do
        blog = mock_model(Blog).as_null_object
        blog.should be_valid
        lambda { blog.categories.should == [] }.should raise_error
      end
    end

  end


end
