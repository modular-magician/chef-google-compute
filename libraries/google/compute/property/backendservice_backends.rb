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
      # A class to manage data for Backends for backend_service.
      class BackendServiceBackend
        include Comparable

        attr_reader :balancing_mode
        attr_reader :capacity_scaler
        attr_reader :description
        attr_reader :group
        attr_reader :max_connections
        attr_reader :max_connections_per_instance
        attr_reader :max_rate
        attr_reader :max_rate_per_instance
        attr_reader :max_utilization

        def to_json(_arg = nil)
          {
            'balancingMode' => balancing_mode,
            'capacityScaler' => capacity_scaler,
            'description' => description,
            'group' => group,
            'maxConnections' => max_connections,
            'maxConnectionsPerInstance' => max_connections_per_instance,
            'maxRate' => max_rate,
            'maxRatePerInstance' => max_rate_per_instance,
            'maxUtilization' => max_utilization
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            balancing_mode: balancing_mode.to_s,
            capacity_scaler: capacity_scaler.to_s,
            description: description.to_s,
            group: group.to_s,
            max_connections: max_connections.to_s,
            max_connections_per_instance: max_connections_per_instance.to_s,
            max_rate: max_rate.to_s,
            max_rate_per_instance: max_rate_per_instance.to_s,
            max_utilization: max_utilization.to_s
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? BackendServiceBackend
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? BackendServiceBackend
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
            { self: balancing_mode, other: other.balancing_mode },
            { self: capacity_scaler, other: other.capacity_scaler },
            { self: description, other: other.description },
            { self: group, other: other.group },
            { self: max_connections, other: other.max_connections },
            { self: max_connections_per_instance, other: other.max_connections_per_instance },
            { self: max_rate, other: other.max_rate },
            { self: max_rate_per_instance, other: other.max_rate_per_instance },
            { self: max_utilization, other: other.max_utilization }
          ]
        end
      end

      # Manages a BackendServiceBackend nested object
      # Data is coming from the GCP API
      class BackendServiceBackendApi < BackendServiceBackend
        # rubocop:disable Metrics/MethodLength
        def initialize(args)
          @balancing_mode =
            Google::Compute::Property::BalancingModeEnum.api_parse(args['balancingMode'])
          @capacity_scaler = Google::Compute::Property::Double.api_parse(args['capacityScaler'])
          @description = Google::Compute::Property::String.api_parse(args['description'])
          @group = Google::Compute::Property::InstGrouSelfLinkRef.api_parse(args['group'])
          @max_connections = Google::Compute::Property::Integer.api_parse(args['maxConnections'])
          @max_connections_per_instance =
            Google::Compute::Property::Integer.api_parse(args['maxConnectionsPerInstance'])
          @max_rate = Google::Compute::Property::Integer.api_parse(args['maxRate'])
          @max_rate_per_instance =
            Google::Compute::Property::Double.api_parse(args['maxRatePerInstance'])
          @max_utilization = Google::Compute::Property::Double.api_parse(args['maxUtilization'])
        end
        # rubocop:enable Metrics/MethodLength
      end

      # Manages a BackendServiceBackend nested object
      # Data is coming from the Chef catalog
      class BackendServiceBackendCatalog < BackendServiceBackend
        # rubocop:disable Metrics/MethodLength
        def initialize(args)
          @balancing_mode =
            Google::Compute::Property::BalancingModeEnum.catalog_parse(args[:balancing_mode])
          @capacity_scaler = Google::Compute::Property::Double.catalog_parse(args[:capacity_scaler])
          @description = Google::Compute::Property::String.catalog_parse(args[:description])
          @group = Google::Compute::Property::InstGrouSelfLinkRef.catalog_parse(args[:group])
          @max_connections =
            Google::Compute::Property::Integer.catalog_parse(args[:max_connections])
          @max_connections_per_instance =
            Google::Compute::Property::Integer.catalog_parse(args[:max_connections_per_instance])
          @max_rate = Google::Compute::Property::Integer.catalog_parse(args[:max_rate])
          @max_rate_per_instance =
            Google::Compute::Property::Double.catalog_parse(args[:max_rate_per_instance])
          @max_utilization = Google::Compute::Property::Double.catalog_parse(args[:max_utilization])
        end
        # rubocop:enable Metrics/MethodLength
      end
    end

    module Property
      # A class to manage input to Backends for backend_service.
      class BackendServiceBackend
        def self.coerce
          ->(x) { ::Google::Compute::Property::BackendServiceBackend.catalog_parse(x) }
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return value if value.is_a? Data::BackendServiceBackend
          Data::BackendServiceBackendCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return value if value.is_a? Data::BackendServiceBackend
          Data::BackendServiceBackendApi.new(value)
        end
      end

      # A Chef property that holds an integer
      class BackendServiceBackendArray < Google::Compute::Property::Array
        def self.coerce
          ->(x) { ::Google::Compute::Property::BackendServiceBackendArray.catalog_parse(x) }
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return BackendServiceBackend.catalog_parse(value) \
            unless value.is_a?(::Array)
          value.map { |v| BackendServiceBackend.catalog_parse(v) }
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return BackendServiceBackend.api_parse(value) \
            unless value.is_a?(::Array)
          value.map { |v| BackendServiceBackend.api_parse(v) }
        end
      end
    end
  end
end
