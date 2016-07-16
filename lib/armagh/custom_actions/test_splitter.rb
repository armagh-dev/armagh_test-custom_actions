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
    class TestSplitter < Actions::Split
      define_output_docspec 'split_output'

      def split(doc)
        log_info { 'Test Split Running' }
        log_info { "Document ID: #{doc.document_id}" }

        edit('split_1', 'split_output') do |edit_doc|
          edit_doc.content['text_1'] = 'text_content_1'
          edit_doc.metadata['touched_by'] ||= []
          edit_doc.metadata['touched_by'] << 'block_1'
          edit_doc.metadata['new'] = 'block_1' if edit_doc.new_document?
        end

        edit('split_2', 'split_output') do |edit_doc|
          edit_doc.content['text_2'] = 'text_content_2'
          edit_doc.metadata['touched_by'] ||= []
          edit_doc.metadata['touched_by'] << 'block_2'
          edit_doc.metadata['new'] = 'block_2' if edit_doc.new_document?
        end

        edit('split_1', 'split_output') do |edit_doc|
          edit_doc.content['text_3'] = 'text_content_3'
          edit_doc.metadata['touched_by'] ||= []
          edit_doc.metadata['touched_by'] << 'block_3'
          edit_doc.metadata['new'] = 'block_3' if edit_doc.new_document?
        end

        sleep 1
      end
    end
  end
end
