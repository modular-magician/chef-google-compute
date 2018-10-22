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
      # A class to manage data for AdvertisedIpRanges for router.
      class RouterAdvertisedipranges
        include Comparable

        attr_reader :range
        attr_reader :description

        def to_json(_arg = nil)
          {
            'range' => range,
            'description' => description
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            range: range.to_s,
            description: description.to_s
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? RouterAdvertisedipranges
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? RouterAdvertisedipranges
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
            { self: range, other: other.range },
            { self: description, other: other.description }
          ]
        end
      end

      # Manages a RouterAdvertisedipranges nested object
      # Data is coming from the GCP API
      class RouterAdvertisediprangesApi < RouterAdvertisedipranges
        def initialize(args)
          @range = Google::Compute::Property::String.api_parse(args['range'])
          @description = Google::Compute::Property::String.api_parse(args['description'])
        end
      end

      # Manages a RouterAdvertisedipranges nested object
      # Data is coming from the Chef catalog
      class RouterAdvertisediprangesCatalog < RouterAdvertisedipranges
        def initialize(args)
          @range = Google::Compute::Property::String.catalog_parse(args[:range])
          @description = Google::Compute::Property::String.catalog_parse(args[:description])
        end
      end
    end

    module Property
      # A class to manage input to AdvertisedIpRanges for router.
      class RouterAdvertisedipranges
        def self.coerce
          ->(x) { ::Google::Compute::Property::RouterAdvertisedipranges.catalog_parse(x) }
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return value if value.is_a? Data::RouterAdvertisedipranges
          Data::RouterAdvertisediprangesCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return value if value.is_a? Data::RouterAdvertisedipranges
          Data::RouterAdvertisediprangesApi.new(value)
        end
      end

      # A Chef property that holds an integer
      class RouterAdvertisediprangesArray < Google::Compute::Property::Array
        def self.coerce
          ->(x) { ::Google::Compute::Property::RouterAdvertisediprangesArray.catalog_parse(x) }
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return RouterAdvertisedipranges.catalog_parse(value) \
            unless value.is_a?(::Array)
          value.map { |v| RouterAdvertisedipranges.catalog_parse(v) }
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return RouterAdvertisedipranges.api_parse(value) \
            unless value.is_a?(::Array)
          value.map { |v| RouterAdvertisedipranges.api_parse(v) }
        end
      end
    end
  end
end
