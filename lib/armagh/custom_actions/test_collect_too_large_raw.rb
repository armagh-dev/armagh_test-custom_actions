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

module Armagh
  module CustomActions

    class TestCollectTooLargeRaw < Actions::Collect
      def collect
        log_info { 'Test Collect Too Large Raw Running' }
        sleep CustomActions::SLEEP_TIME
        source = Armagh::Documents::Source.new(type: 'url', url: 'from test')
        content = 'abcdefg' * 1_000_000
        create(collected: content, metadata: {}, source: source)
      end
    end
  end
end
