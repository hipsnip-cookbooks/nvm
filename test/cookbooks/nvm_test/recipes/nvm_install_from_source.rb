node.set['nvm']['install_deps_to_build_from_source'] = true

include_recipe 'nvm'

version = 'v0.10.0'
node.set['nvm']['nvm_install_from_source_test']['version'] = version

nvm_install version  do
	from_source true
	alias_as_default true
	action :create
end