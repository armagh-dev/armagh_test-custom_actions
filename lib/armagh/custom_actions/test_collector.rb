# Copyright 2016 Noragh Analytics, Inc.
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

    class TestCollector < Actions::Collect
      define_output_docspec 'collected_document'
      define_output_docspec 'split_collected_document'

      def collect
        @logger.any 'Test Collect Running'
        sleep 1
        create('123_collected', 'collected content', {}, 'collected_document')
        create('123_collected_to_split', "content\nfor\nsplitting", {}, 'split_collected_document')
      end
    end
  end
end
