require 'spec_helper'

describe User do

  it "just try" do
    user = Factory.stub(:user01)
    user.should be_valid
  end

  
end
