include_recipe 'nvm'

version = 'v0.10.2'
node.set['nvm']['nvm_alias_default_test']['version'] = version

nvm_install version  do
	from_source false
	alias_as_default false
	action :create
end

nvm_alias_default version do
	action :create
end