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

    class TestCollectSetsID < Actions::Collect

      def collect
        log_info { 'Test Collect Sets ID Running' }
        sleep CustomActions::SLEEP_TIME
        source = Armagh::Documents::Source.new(type: 'url', url: 'from test')
        create(collected: 'collected content', metadata: {}, source: source, document_id: 'collected_id')
      end
    end
  end
end
