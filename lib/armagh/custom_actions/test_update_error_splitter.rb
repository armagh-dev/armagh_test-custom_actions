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

    class TestUpdateErrorSplitter < Actions::Split
      def split(doc)
        log_info { 'Update Error Splitter Running' }

        sleep CustomActions::SLEEP_TIME

        edit('update_id') do |edit_doc|
          edit_doc.content['update'] = 'This should not be saved'
          raise 'Failure'
        end
      end
    end
  end
end
