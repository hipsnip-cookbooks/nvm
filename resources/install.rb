actions :create
default_action :create

attribute :version, :kind_of => String, :name_attribute => true
attribute :from_source, :kind_of => [TrueClass, FalseClass], :default => false
attribute :default_to, :kind_of => [TrueClass, FalseClass], :default => false