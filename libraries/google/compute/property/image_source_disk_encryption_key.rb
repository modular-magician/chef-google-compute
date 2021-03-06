# Copyright 2017 Google Inc.
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
#     This file is automatically generated by chef-codegen and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

module Google
  module Compute
    module Data
      # A class to manage data for source_disk_encryption_key for image.
      class ImagSourDiskEncrKey
        include Comparable

        attr_reader :raw_key
        attr_reader :sha256

        def to_json(_arg = nil)
          {
            'rawKey' => raw_key,
            'sha256' => sha256
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            raw_key: raw_key.to_s,
            sha256: sha256.to_s
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? ImagSourDiskEncrKey
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? ImagSourDiskEncrKey
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
            { self: raw_key, other: other.raw_key },
            { self: sha256, other: other.sha256 }
          ]
        end
      end

      # Manages a ImagSourDiskEncrKey nested object
      # Data is coming from the GCP API
      class ImagSourDiskEncrKeyApi < ImagSourDiskEncrKey
        def initialize(args)
          @raw_key = Google::Compute::Property::String.api_parse(args['rawKey'])
          @sha256 = Google::Compute::Property::String.api_parse(args['sha256'])
        end
      end

      # Manages a ImagSourDiskEncrKey nested object
      # Data is coming from the Chef catalog
      class ImagSourDiskEncrKeyCatalog < ImagSourDiskEncrKey
        def initialize(args)
          @raw_key =
            Google::Compute::Property::String.catalog_parse(args[:raw_key])
          @sha256 =
            Google::Compute::Property::String.catalog_parse(args[:sha256])
        end
      end
    end

    module Property
      # A class to manage input to source_disk_encryption_key for image.
      class ImagSourDiskEncrKey
        def self.coerce
          lambda do |x|
            ::Google::Compute::Property::ImagSourDiskEncrKey.catalog_parse(x)
          end
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return value if value.is_a? Data::ImagSourDiskEncrKey
          Data::ImagSourDiskEncrKeyCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return value if value.is_a? Data::ImagSourDiskEncrKey
          Data::ImagSourDiskEncrKeyApi.new(value)
        end
      end
    end
  end
end
