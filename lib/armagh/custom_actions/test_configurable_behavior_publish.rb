# Copyright 2018 Noragh Analytics, Inc.
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

require 'armagh/actions'
require 'configh'

require_relative '../custom_support/basic_behavior'

module Armagh
  module CustomActions

    class TestConfigurableBehaviorPublish < Actions::Publish
      include Configh::Configurable
      include Armagh::CustomSupport::BasicBehavior

      define_group_validation_callback group: 'basic_behavior',
                                       callback_class: TestConfigurableBehaviorPublish,
                                       callback_method: :produce_only_one

      def TestConfigurableBehaviorPublish.produce_only_one( config )
        error = nil
        unless config.basic_behavior.num_docs_to_create_each_run == 1
          error = "Publish actions can only produce 1 document per execution"
        end
        error
      end

      def publish(doc)
        log_debug { 'Test Configurable Publish Running' }

        generate_document_drafts(@config) do |draft, dev_error, ops_error|
          notify_dev(dev_error) if dev_error
          notify_ops(ops_error) if ops_error

          if draft
            draft.each do |k,v|
              doc.send( "#{k.to_sym}=", v) unless k.to_sym == :source
            end
          end
        end
      end
    end
  end
end
