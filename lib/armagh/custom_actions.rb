# Copyright 2016 Noragh Analytics, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either 
# express or implied.
#
# See the License for the specific language governing permissions and
# limitations under the License.
#

## THIS FILE WAS AUTOMATICALLY GENERATED AND SHOULD NOT BE MODIFIED

require 'armagh/actions'

Dir[File.join(__dir__, 'custom_actions', '*.rb')].each { |file| require file }

module Armagh
  module CustomActions
    def self.defined_actions
      actions = []
      constants.each do |name|
        class_name = "Armagh::CustomActions::#{name.to_s}"
        const_obj = const_get(class_name)
        actions << class_name if const_obj.is_a?(Class) && const_obj < Actions::Action
      end
      actions
    end
  end
end