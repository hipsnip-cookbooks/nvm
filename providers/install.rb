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
  user_install = false
  if new_resource.user && new_resource.user != 'root'
    user_install = true
  end
  chef_nvm_user = new_resource.user ||= 'root'
  chef_nvm_group = new_resource.group ||= 'root'
  #user_install = new_resource.user_install
  user_home = new_resource.user_home
  nvm_base_dir = new_resource.nvm_directory
  if user_install == true
    if user_home
      nvm_base_dir = user_home
    else
      nvm_base_dir = "/home/" + chef_nvm_user
    end
  else
    nvm_base_dir = '/root'
  end

  directory nvm_base_dir + '/.nvm' do
    user chef_nvm_user
    group chef_nvm_group
    action :create
  end

  git nvm_base_dir + '/.nvm' do
    user chef_nvm_user
    group chef_nvm_group
    repository node['nvm']['repository']
    reference node['nvm']['reference']
    action :sync
  end

  template '/etc/profile.d/nvm.sh' do
    source 'nvm.sh.erb'
    mode 0755
    cookbook 'nvm'
    variables ({
      :user_install => user_install,
      :nvm_base_dir => nvm_base_dir
    })
  end

	script "Installing node.js #{new_resource.version}#{from_source_message}, as #{chef_nvm_user}:#{chef_nvm_group} from #{nvm_base_dir}" do
    interpreter 'bash'
    flags '-l'
    user chef_nvm_user
    group chef_nvm_group
    environment Hash[ 'HOME' => nvm_base_dir ]
		code <<-EOH
      export NVM_DIR=#{nvm_base_dir + '/.nvm'}
      source /etc/profile.d/nvm.sh
			nvm install #{from_source_arg} #{new_resource.version}
		EOH
	end
	# break FC021: Resource condition in provider may not behave as expected
	# silly thing because new_resource.version is dynamic not fixed
	nvm_alias_default new_resource.version do
    user chef_nvm_user
    group chef_nvm_group
		action :create
		only_if { new_resource.alias_as_default }
	end
	new_resource.updated_by_last_action(true)
end
