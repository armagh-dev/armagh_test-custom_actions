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

module Armagh
  module CustomActions

    class TestTemplate < Actions::Consume

      define_parameter name: 'template',
                       description: 'The template.',
                       type: 'string',
                       required: false,
                       group: 'tacball_consume',
                       options: Actions.available_templates

      def consume(doc)
        sleep CustomActions::SLEEP_TIME
      end

    end
  end
end
