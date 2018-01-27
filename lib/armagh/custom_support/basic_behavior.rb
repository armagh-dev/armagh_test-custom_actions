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

require 'configh'
require 'armagh/actions'

module Armagh
  module CustomSupport
    module BasicBehavior
      include Configh::Configurable

      define_parameter name: 'times_to_execute', description: 'number of times this action will be run unless the action state document is reset', type: 'integer',  required: false, group: 'basic_behavior'
      define_parameter name: 'do_not_execute_flag', description: 'element written to action state when times to execute condition is met', type: 'string', required: false, default: 'done', group: 'basic_behavior'
      define_parameter name: 'num_docs_to_create_each_run', description: 'each invocation, create this many docs', type: 'integer', required: 'true', default: 1, group: 'basic_behavior'
      define_parameter name: 'times_to_ops_error', description: 'TOTAL number of times to generate a doc with an ops error; first N docs have errors', type: 'integer', required: false, default:0, group: 'basic_behavior'
      define_parameter name: 'ops_error_message', description: 'error message to insert', type: 'string', required: false, default: 'oops', group: 'basic_behavior'
      define_parameter name: 'times_to_dev_error', description: 'TOTAL number of times to generate a doc with a dev error; first N docs have errors', type: 'integer', required: false, default:0, group: 'basic_behavior'
      define_parameter name: 'dev_error_message', description: 'error message to insert', type: 'string', required: false, default: 'oops', group: 'basic_behavior'

      def generate_document_drafts( config )

        my_config = config.basic_behavior

        with_locked_action_state do |action_state|

          action_state['run_number'] ||= 1
          action_state['dev_errors_added'] ||= 0
          action_state['ops_errors_added'] ||= 0
          ops_error = nil
          dev_error = nil

          unless my_config.times_to_ops_error&.<= action_state[ 'ops_errors_added' ]
            ops_error = my_config.ops_error_message
            action_state[ 'ops_errors_added' ] += 1
          end

          unless my_config.times_to_dev_error&.<= action_state[ 'dev_errors_added']
            dev_error = my_config.dev_error_message
            action_state[ 'dev_errors_added' ] += 1
          end

          unless action_state[ my_config.do_not_execute_flag ]

            source = Armagh::Documents::Source.new(type: 'url', url: 'http://goodshiplollipop.edu')

            my_config.num_docs_to_create_each_run.times do |iteration|

              draft = nil

              unless dev_error || ops_error
                uuid = SecureRandom.uuid
                draft = {
                    'document_id' => uuid,
                    'title' => "Title #{ action_state['run_number']} #{ iteration }",
                    'metadata' => { 'run_number' => action_state['run_number'], 'iteration' => iteration },
                    'source' => source
                }
              end

              yield draft, dev_error, ops_error
              dev_error = nil
              ops_error = nil
            end
          end

          if my_config.times_to_execute && my_config.times_to_execute == action_state['run_number']
            action_state[ my_config.do_not_execute_flag ] = true
          else
            action_state[ 'run_number' ] += 1
          end
        end
      end
    end
  end
end