# Copyright 2018 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

require 'google/compute/property/array'
module Google
  module Compute
    module Data
      # A class to manage data for host_rules for url_map.
      class UrlMapHostRules
        include Comparable

        attr_reader :description
        attr_reader :hosts
        attr_reader :path_matcher

        def to_json(_arg = nil)
          {
            'description' => description,
            'hosts' => hosts,
            'pathMatcher' => path_matcher
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            description: description.to_s,
            hosts: hosts.to_s,
            path_matcher: path_matcher.to_s
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? UrlMapHostRules
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? UrlMapHostRules
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            result = compare[:self] <=> compare[:other]
            return result unless result.zero?
          end
          0
        end

        def inspect
          to_json
        end

        private

        def compare_fields(other)
          [
            { self: description, other: other.description },
            { self: hosts, other: other.hosts },
            { self: path_matcher, other: other.path_matcher }
          ]
        end
      end

      # Manages a UrlMapHostRules nested object
      # Data is coming from the GCP API
      class UrlMapHostRulesApi < UrlMapHostRules
        def initialize(args)
          @description =
            Google::Compute::Property::String.api_parse(args['description'])
          @hosts =
            Google::Compute::Property::StringArray.api_parse(args['hosts'])
          @path_matcher =
            Google::Compute::Property::String.api_parse(args['pathMatcher'])
        end
      end

      # Manages a UrlMapHostRules nested object
      # Data is coming from the Chef catalog
      class UrlMapHostRulesCatalog < UrlMapHostRules
        def initialize(args)
          @description =
            Google::Compute::Property::String.catalog_parse(args[:description])
          @hosts =
            Google::Compute::Property::StringArray.catalog_parse(args[:hosts])
          @path_matcher =
            Google::Compute::Property::String.catalog_parse(args[:path_matcher])
        end
      end
    end

    module Property
      # A class to manage input to host_rules for url_map.
      class UrlMapHostRules
        def self.coerce
          lambda do |x|
            ::Google::Compute::Property::UrlMapHostRules.catalog_parse(x)
          end
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return value if value.is_a? Data::UrlMapHostRules
          Data::UrlMapHostRulesCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return value if value.is_a? Data::UrlMapHostRules
          Data::UrlMapHostRulesApi.new(value)
        end
      end

      # A Chef property that holds an integer
      class UrlMapHostRulesArray < Google::Compute::Property::Array
        def self.coerce
          lambda do |x|
            ::Google::Compute::Property::UrlMapHostRulesArray.catalog_parse(x)
          end
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return UrlMapHostRules.catalog_parse(value) \
            unless value.is_a?(::Array)
          value.map { |v| UrlMapHostRules.catalog_parse(v) }
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return UrlMapHostRules.api_parse(value) \
            unless value.is_a?(::Array)
          value.map { |v| UrlMapHostRules.api_parse(v) }
        end
      end
    end
  end
end
