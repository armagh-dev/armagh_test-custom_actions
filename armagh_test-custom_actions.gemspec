# coding: utf-8
#
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

require_relative 'lib/armagh/custom_actions/constants'

def self.get_build_version(version)
  if ENV['ARMAGH_PRODUCTION_RELEASE']
    version
  else
    revision = `hg identify --num 2>/dev/null`.strip.gsub('+', '-dev')
    if revision.empty?
      "#{version}-dev"
    else
      "#{version}.#{revision}"
    end
  end
rescue
  "#{version}-dev"
end

Gem::Specification.new do |spec|
  spec.name          = 'armagh_test-custom_actions'
  spec.version       = get_build_version Armagh::CustomActions::VERSION
  spec.authors       = ['Noragh Analytics, Inc.']
  spec.email         = []
  spec.summary       = "Armagh custom actions - #{Armagh::CustomActions::NAME}"
  spec.description   = ''
  spec.homepage      = ''
  spec.license       = ''

  spec.files         = Dir.glob('lib/**/*') + %w(README)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'armagh-base-actions', '< 2.0'

  spec.add_development_dependency 'noragh-gem-tasks', '~> 0.1'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'mocha', '~> 1.1'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'test-unit', '~> 3.1'
end
