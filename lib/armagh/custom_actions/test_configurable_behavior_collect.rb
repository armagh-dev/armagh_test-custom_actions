# Copyright 2017 Noragh Analytics, Inc.
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
require_relative '../custom_support/basic_behavior'

module Armagh
  module CustomActions

    class TestConfigurableBehaviorCollect < Actions::Collect
      include Armagh::CustomSupport::BasicBehavior

      def collect
        log_debug { 'Configurable Collect Running' }

        generate_document_drafts( @config ) do |draft, dev_error, ops_error|
          notify_dev( dev_error ) if dev_error
          notify_ops( ops_error ) if ops_error


          if draft
            draft_as_symbols = Hash[ draft.collect{ |k,v| [k.to_sym, v ] } ]
            create( collected: "I am collected content for #{draft['document_id']}", **draft_as_symbols )
          end
        end
      end
    end
  end
end
