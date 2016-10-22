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

    class TestDivider < Actions::Divide

      define_output_docspec 'output', 'Document that was divided'

      def divide(doc)
        content = File.read(doc.collected_file)

        log_info { 'Test Divider Running' }
        sleep 1
        create(content.gsub("\n", '-'), {'divide' => true})
      end

    end
  end
end
