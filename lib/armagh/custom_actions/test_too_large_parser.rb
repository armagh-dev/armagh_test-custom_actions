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

    class TestTooLargeParser < Actions::Parse
      define_output_docspec 'too_large_parser_output'
      
      def parse(doc)
        @logger.any 'Too Large Parser Running'

        edit('parse_123', 'too_large_parser_output') do |edit_doc|
          edit_doc.draft_content['test_content'] = 'This should not be saved'
          edit_doc.draft_content['too_big'] = 'a' * 100_000_000
        end
        sleep 1
      end
    end
  end
end
