require File.expand_path('../support/helpers', __FILE__)

describe_recipe "nvm_test::nvm_install" do
  include Helpers::CookbookTest

  it "should have correctly installed nvm" do
    assert_sh "/bin/bash --login -c 'nvm help' 2>&1"
  end

  it "should have installed node" do
  	assert_sh "/bin/bash --login -c 'node -v' 2>&1"
  end

  it "should have installed the given node.js version" do
  	stdout = `/bin/bash --login -c 'node -v'`
  	stdout = stdout.sub(/\n/,'')
  	assert_equal(node['nvm']['nvm_alias_default_test']['version'],stdout)
  end

end