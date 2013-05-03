include_recipe 'nvm'

version = 'v0.10.5'
node.set['nvm']['nvm_install_test']['version'] = version

nvm_install version  do
	from_source false
	alias_as_default true
	action :create
end