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
require_relative '../../../lib/armagh/custom_support/basic_behavior'

require 'test/unit'
require 'mocha/test_unit'

class TestBasicBehavior < Test::Unit::TestCase

  def setup
    @config_store = []
  end

  def test_params_set

    config = nil
    assert_nothing_raised do
      config = Armagh::CustomSupport::BasicBehavior.create_configuration(
          @config_store,
          'basic_config',
          'basic_behavior' =>
              {
                'times_to_execute' => 10,
                'do_not_execute_flag' => 'all_done',
                'num_docs_to_create_each_run' => 5,
                'times_to_ops_error' => 3,
                'ops_error_message' => 'boom ops',
                'times_to_dev_error' => 4,
                'dev_error_message' => 'boom dev'
              }
      )
    end

    assert_equal 10, config.basic_behavior.times_to_execute
    assert_equal 'all_done', config.basic_behavior.do_not_execute_flag
    assert_equal 5, config.basic_behavior.num_docs_to_create_each_run
    assert_equal 3, config.basic_behavior.times_to_ops_error
    assert_equal 'boom ops', config.basic_behavior.ops_error_message
    assert_equal 4, config.basic_behavior.times_to_dev_error
    assert_equal 'boom dev', config.basic_behavior.dev_error_message
  end

  def test_params_default
    config = nil
    assert_nothing_raised do
      config = Armagh::CustomSupport::BasicBehavior.create_configuration(
          @config_store,
          'basic_config',
          'basic_behavior' => {}
      )
    end

    assert_nil config.basic_behavior.times_to_execute
    assert_equal 'done', config.basic_behavior.do_not_execute_flag
    assert_equal 1, config.basic_behavior.num_docs_to_create_each_run
    assert_equal 0, config.basic_behavior.times_to_ops_error
    assert_equal 'oops', config.basic_behavior.ops_error_message
    assert_equal 0, config.basic_behavior.times_to_dev_error
    assert_equal 'oops', config.basic_behavior.dev_error_message

  end

  def test_generate_document_drafts

    action_state = {}
    config = Armagh::CustomSupport::BasicBehavior.create_configuration(
        @config_store,
        'basic_config',
        'basic_behavior' =>
            {
              'times_to_execute' => 2,
              'do_not_execute_flag' => 'im_done',
              'num_docs_to_create_each_run' => 5,
              'times_to_ops_error' => 1,
              'ops_error_message' => 'boom ops',
              'times_to_dev_error' => 3,
              'dev_error_message' => 'boom dev'
            }
    )

    dummy_class = Class.new
    dummy_class.include Armagh::CustomSupport::BasicBehavior
    dummy_object = dummy_class.new

    dummy_object.expects( :with_locked_action_state ).times(3).yields( action_state)

    generated_drafts = []
    dev_errors = []
    ops_errors = []

    3.times do |i|
      dummy_object.generate_document_drafts( config ) do |draft,dev_error,ops_error|
        generated_drafts << draft
        dev_errors << dev_error
        ops_errors << ops_error
      end
      assert_nil action_state[ 'im_done' ] if i < 1
      assert_true action_state[ 'im_done' ] if i >= 1
    end

    assert_equal 10, generated_drafts.length
    assert_equal 2, dev_errors.compact.length
    assert_equal 'boom dev', dev_errors.compact.first
    assert_equal 1, ops_errors.compact.length
    assert_equal 'boom ops', ops_errors.compact.first
  end
end

