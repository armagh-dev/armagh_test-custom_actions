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

    class TestChangeIdPublisher < Actions::Publish

      def publish(doc)
        log_info { 'Test Change ID Publish Running' }
        log_info { "Original Document ID: #{doc.document_id}" }

        doc.document_id = 'new_id'

        log_info { "New Document ID: #{doc.document_id}" }

        published_doc = get_existing_published_document(doc)

        if published_doc
          published_content = published_doc.content
          published_metadata = published_doc.metadata
        else
          published_content = {}
          published_metadata = {}
        end

        doc.content.merge! published_content
        doc.metadata.merge! published_metadata

        doc.title = 'The Title'
        doc.copyright = 'Copyright the future'

        sleep 1
      end

    end
  end
end
