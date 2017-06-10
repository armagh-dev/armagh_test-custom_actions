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

    class TestConsumeReceivesRaw < Actions::Consume

      define_output_docspec 'output', 'Output of the consumer'

      def consume(doc)
        log_info { 'Test Consume Receives Raw Running' }
        log_info { "consume: raw=#{doc.raw}" }

        edit('consumed', 'output') do |edit_doc|
          edit_doc.metadata['meta'] = 'consumed meta'
        end

        sleep CustomActions::SLEEP_TIME
      end
    end
  end
end
