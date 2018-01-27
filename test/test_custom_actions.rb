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

require 'test/unit'
require 'mocha/test_unit'

# DO NOT MODIFY THIS FILE

require_relative '../lib/armagh/custom_actions'

class TestCustomActions < Test::Unit::TestCase
  def setup
  end

  def teardown
  end

  def test_name
    assert_not_empty(Armagh::CustomActions::NAME, 'No NAME defined for CustomActions')
  end

  def test_version
    assert_not_empty(Armagh::CustomActions::VERSION, 'No VERSION defined for CustomActions')
  end

  def test_defined_actions
    assert_not_empty(Armagh::Actions.defined_actions, 'No available custom actions or dividers were discovered')
  end
end