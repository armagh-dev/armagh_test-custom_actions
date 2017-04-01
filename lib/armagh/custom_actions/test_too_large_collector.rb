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
require_relative 'constants'

module Armagh
  module CustomActions

    class TestTooLargeCollector < Actions::Collect
      def collect
        log_info { 'Too Large Collector Running' }

        source = Armagh::Documents::Source.new(type: 'url', url: 'from test')
        create(collected: 'a' * TOO_LARGE_SIZE, metadata: {}, source: source)
        sleep 2
      end
    end
  end
end
