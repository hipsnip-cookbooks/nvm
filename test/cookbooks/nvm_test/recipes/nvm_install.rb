include_recipe 'nvm'

nvm_install 'v0.8.13' do
	from_source false
	default_to true
	action :create
end