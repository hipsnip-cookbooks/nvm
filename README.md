# nvm

Chef cookbook for setting up NVM from [creationix's github repository](https://github.com/creationix/nvm).

[![Build Status](https://travis-ci.org/hipsnip-cookbooks/nvm.png?branch=master)](https://travis-ci.org/hipsnip-cookbooks/nvm) [![Dependency Status](https://gemnasium.com/hipsnip-cookbooks/nvm.png)](https://gemnasium.com/hipsnip-cookbooks/nvm)

## Requirements

Built to run on Linux distributions. Tested on Ubuntu 12.04.
Depends on the `git` cookbook.

## Usage


For more usage examples, have a look to the recipes in `test/cookbooks/nvm_test/recipes/`.

## Attributes

## Cookbook development

You will need to do a couple of things to be up to speed to hack on this cookbook.
Everything is explained [here](https://github.com/hipsnip-cookbooks/cookbook-development) have a look.

## Test

    bundle exec rake cookbook:full_test

## Licence

Author: Rémy Loubradou

Copyright 2013 HipSnip Limited

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
