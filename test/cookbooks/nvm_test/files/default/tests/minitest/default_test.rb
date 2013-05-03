require File.expand_path('../support/helpers', __FILE__)
require 'net/http'

describe_recipe "nvm_test::default" do
  include Helpers::CookbookTest

  it "should have correctly installed nvm" do
    assert_sh "/bin/bash --login -c 'nvm help' 2>&1"
  end

end