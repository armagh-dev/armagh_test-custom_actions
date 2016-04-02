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

    class TestConsumer < ConsumeAction

      define_output_docspec 'consume_output'

      def consume(doc)
        @logger.any 'Test Consume Running'
        @logger.any "Document ID: #{doc.id}"

        edit('consume_1', 'consume_output') do |edit_doc|
          edit_doc.draft_content['text_1'] = 'text_content_1'
          edit_doc.meta['touched_by'] ||= []
          edit_doc.meta['touched_by'] << 'block_1'
          edit_doc.meta['new'] = 'block_1' if edit_doc.new_document?
        end

        edit('consume_2', 'consume_output') do |edit_doc|
          edit_doc.draft_content['text_2'] = 'text_content_2'
          edit_doc.meta['touched_by'] ||= []
          edit_doc.meta['touched_by'] << 'block_2'
          edit_doc.meta['new'] = 'block_2' if edit_doc.new_document?
        end

        edit('consume_1', 'consume_output') do |edit_doc|
          edit_doc.draft_content['text_3'] = 'text_content_3'
          edit_doc.meta['touched_by'] ||= []
          edit_doc.meta['touched_by'] << 'block_3'
          edit_doc.meta['new'] = 'block_3' if edit_doc.new_document?
        end
        
        sleep 1
      end

    end
  end
end
