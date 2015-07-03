#
# Cookbook Name:: nvm
# Provider:: nvm_install
#
# Copyright 2013, HipSnip Limited
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :create do
	from_source_message = new_resource.from_source ? ' from source' : ''
	from_source_arg = new_resource.from_source ? '-s' : ''
  chef_nvm_user = new_resource.user ||= 'root'
  chef_nvm_group = new_resource.group ||= 'root'
  chef_nvm_user_install = new_resource.user_install
  nvm_user_home = new_resource.nvm_user_home
  nvm_base_dir = new_resource.nvm_directory
  if chef_nvm_user_install
    if nvm_user_home
      nvm_base_dir = nvm_user_home
    else
      nvm_base_dir = File.join('/home', chef_nvm_user)
    end
  else
    nvm_base_dir = '/root'
  end

  template '/etc/profile.d/nvm.sh' do
    source 'nvm.sh.erb'
    mode 0755
    cookbook 'nvm'
    variables ({
      :nvm_base_dir => nvm_base_dir
    })
  end

	script "Installing node.js #{new_resource.version}#{from_source_message}, as #{chef_nvm_user}:#{chef_nvm_group} from #{chef_nvm_directory}" do
    interpreter 'bash'
    flags '-l'
    user chef_nvm_user
    group chef_nvm_group
    environment Hash[ 'HOME' => node['nvm']['home'] ]
		code <<-EOH
    export NVM_DIR=#{node['nvm']['directory']}
    echo #{node['nvm']['directory']} > /tmp/chef-nvm-directory.out
    pwd > /tmp/chef-nvm-pwd.out
    echo $HOME - #{from_source_arg} - #{new_resource.version}  > /tmp/chef-nvm.out
      source /etc/profile.d/nvm.sh
			nvm install #{from_source_arg} #{new_resource.version}
		EOH
	end
	# break FC021: Resource condition in provider may not behave as expected
	# silly thing because new_resource.version is dynamic not fixed
	chef_nvm_alias_default new_resource.version do
    user chef_nvm_user
    group chef_nvm_group
		action :create
		only_if { new_resource.alias_as_default }
	end
	new_resource.updated_by_last_action(true)
end
