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

# Add our google/ lib
$LOAD_PATH.unshift ::File.expand_path('../libraries', ::File.dirname(__FILE__))

require 'chef/resource'
require 'google/compute/network/delete'
require 'google/compute/network/get'
require 'google/compute/network/post'
require 'google/compute/network/put'
require 'google/compute/property/boolean'
require 'google/compute/property/enum'
require 'google/compute/property/integer'
require 'google/compute/property/machinetype_deprecated'
require 'google/compute/property/string'
require 'google/compute/property/time'
require 'google/compute/property/zone_name'
require 'google/hash_utils'

module Google
  module GCOMPUTE
    # A provider to manage Google Compute Engine resources.
    # rubocop:disable Metrics/ClassLength
    class MachineType < Chef::Resource
      resource_name :gcompute_machine_type

      property :creation_timestamp,
               Time,
               coerce: ::Google::Compute::Property::Time.coerce,
               desired_state: true
      property :_deprecated,
               [Hash, ::Google::Compute::Data::MachineTypeDepreca],
               coerce: ::Google::Compute::Property::MachineTypeDepreca.coerce,
               desired_state: true
      property :description,
               String,
               coerce: ::Google::Compute::Property::String.coerce,
               desired_state: true
      property :guest_cpus,
               Integer,
               coerce: ::Google::Compute::Property::Integer.coerce,
               desired_state: true
      property :id,
               Integer,
               coerce: ::Google::Compute::Property::Integer.coerce,
               desired_state: true
      property :is_shared_cpu,
               kind_of: [TrueClass, FalseClass],
               coerce: ::Google::Compute::Property::Boolean.coerce,
               desired_state: true
      property :maximum_persistent_disks,
               Integer,
               coerce: ::Google::Compute::Property::Integer.coerce,
               desired_state: true
      property :maximum_persistent_disks_size_gb,
               Integer,
               coerce: ::Google::Compute::Property::Integer.coerce,
               desired_state: true
      property :memory_mb,
               Integer,
               coerce: ::Google::Compute::Property::Integer.coerce,
               desired_state: true
      property :mt_label,
               String,
               coerce: ::Google::Compute::Property::String.coerce,
               name_property: true, desired_state: true
      property :zone,
               [String, ::Google::Compute::Data::ZoneNameRef],
               coerce: ::Google::Compute::Property::ZoneNameRef.coerce,
               desired_state: true

      property :credential, String, desired_state: false, required: true
      property :project, String, desired_state: false, required: true

      # TODO(alexstephen): Check w/ Chef how to not expose this property yet
      # allow the resource to store the @fetched API results for exports usage.
      property :__fetched, Hash, desired_state: false, required: false

      action :create do
        fetch = fetch_resource(@new_resource, self_link(@new_resource),
                               'compute#machineType')
        if fetch.nil?
          converge_by "Creating gcompute_machine_type[#{new_resource.name}]" do
            # TODO(nelsonjr): Show a list of variables to create
            # TODO(nelsonjr): Determine how to print green like update converge
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            create_req = ::Google::Compute::Network::Post.new(
              collection(@new_resource), fetch_auth(@new_resource),
              'application/json', resource_to_request
            )
            @new_resource.__fetched =
              return_if_object create_req.send, 'compute#machineType'
          end
        else
          @current_resource = @new_resource.clone
          @current_resource.creation_timestamp =
            ::Google::Compute::Property::Time.api_parse(
              fetch['creationTimestamp']
            )
          @current_resource._deprecated =
            ::Google::Compute::Property::MachineTypeDepreca.api_parse(
              fetch['deprecated']
            )
          @current_resource.description =
            ::Google::Compute::Property::String.api_parse(
              fetch['description']
            )
          @current_resource.guest_cpus =
            ::Google::Compute::Property::Integer.api_parse(fetch['guestCpus'])
          @current_resource.id =
            ::Google::Compute::Property::Integer.api_parse(fetch['id'])
          @current_resource.is_shared_cpu =
            ::Google::Compute::Property::Boolean.api_parse(
              fetch['isSharedCpu']
            )
          @current_resource.maximum_persistent_disks =
            ::Google::Compute::Property::Integer.api_parse(
              fetch['maximumPersistentDisks']
            )
          @current_resource.maximum_persistent_disks_size_gb =
            ::Google::Compute::Property::Integer.api_parse(
              fetch['maximumPersistentDisksSizeGb']
            )
          @current_resource.memory_mb =
            ::Google::Compute::Property::Integer.api_parse(fetch['memoryMb'])
          @current_resource.mt_label =
            ::Google::Compute::Property::String.api_parse(fetch['name'])
          @new_resource.__fetched = fetch

          update
        end
      end

      action :delete do
        fetch = fetch_resource(@new_resource, self_link(@new_resource),
                               'compute#machineType')
        unless fetch.nil?
          converge_by "Deleting gcompute_machine_type[#{new_resource.name}]" do
            delete_req = ::Google::Compute::Network::Delete.new(
              self_link(@new_resource), fetch_auth(@new_resource)
            )
            return_if_object delete_req.send, 'compute#machineType'
          end
        end
      end

      # TODO(nelsonjr): Add actions :manage and :modify

      def exports
        {
          name: mt_label,
          self_link: __fetched['selfLink']
        }
      end

      private

      action_class do
        def resource_to_request
          request = {
            kind: 'compute#machineType',
            name: new_resource.mt_label
          }.reject { |_, v| v.nil? }
          request.to_json
        end

        def update
          converge_if_changed do |_vars|
            # TODO(nelsonjr): Determine how to print indented like upd converge
            # TODO(nelsonjr): Check w/ Chef... can we print this in red?
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            update_req =
              ::Google::Compute::Network::Put.new(self_link(@new_resource),
                                                  fetch_auth(@new_resource),
                                                  'application/json',
                                                  resource_to_request)
            return_if_object update_req.send, 'compute#machineType'
          end
        end

        def self.fetch_export(resource, type, id, property)
          return if id.nil?
          resource.resources("#{type}[#{id}]").exports[property]
        end

        # rubocop:disable Metrics/MethodLength
        def self.resource_to_hash(resource)
          {
            project: resource.project,
            name: resource.mt_label,
            kind: 'compute#machineType',
            creation_timestamp: resource.creation_timestamp,
            deprecated: resource._deprecated,
            description: resource.description,
            guest_cpus: resource.guest_cpus,
            id: resource.id,
            is_shared_cpu: resource.is_shared_cpu,
            maximum_persistent_disks: resource.maximum_persistent_disks,
            maximum_persistent_disks_size_gb:
              resource.maximum_persistent_disks_size_gb,
            memory_mb: resource.memory_mb,
            zone: resource.zone
          }.reject { |_, v| v.nil? }
        end
        # rubocop:enable Metrics/MethodLength

        # Copied from Chef > Provider > #converge_if_changed
        def compute_changes
          properties = @new_resource.class.state_properties.map(&:name)
          properties = properties.map(&:to_sym)
          if current_resource
            compute_changes_for_existing_resource properties
          else
            compute_changes_for_new_resource properties
          end
        end

        # Collect the list of modified properties
        def compute_changes_for_existing_resource(properties)
          specified_properties = properties.select do |property|
            @new_resource.property_is_set?(property)
          end
          modified = specified_properties.reject do |p|
            @new_resource.send(p) == current_resource.send(p)
          end

          generate_pretty_green_text(modified)
        end

        def generate_pretty_green_text(modified)
          property_size = modified.map(&:size).max
          modified.map! do |p|
            properties_str = if @new_resource.sensitive
                               '(suppressed sensitive property)'
                             else
                               [
                                 @new_resource.send(p).inspect,
                                 "(was #{current_resource.send(p).inspect})"
                               ].join(' ')
                             end
            "  set #{p.to_s.ljust(property_size)} to #{properties_str}"
          end
        end

        # Write down any properties we are setting.
        def compute_changes_for_new_resource(properties)
          property_size = properties.map(&:size).max
          properties.map do |property|
            default = ' (default value)' \
              unless @new_resource.property_is_set?(property)
            next if @new_resource.send(property).nil?
            properties_str = if @new_resource.sensitive
                               '(suppressed sensitive property)'
                             else
                               @new_resource.send(property).inspect
                             end
            ["  set #{property.to_s.ljust(property_size)}",
             "to #{properties_str}#{default}"].join(' ')
          end.compact
        end

        def fetch_auth(resource)
          self.class.fetch_auth(resource)
        end

        def self.fetch_auth(resource)
          resource.resources("gauth_credential[#{resource.credential}]")
                  .authorization
        end

        def fetch_resource(resource, self_link, kind)
          self.class.fetch_resource(resource, self_link, kind)
        end

        def debug(message)
          Chef::Log.debug(message)
        end

        def self.collection(data)
          URI.join(
            'https://www.googleapis.com/compute/v1/',
            expand_variables(
              'projects/{{project}}/zones/{{zone}}/machineTypes',
              data
            )
          )
        end

        def collection(data)
          self.class.collection(data)
        end

        def self.self_link(data)
          URI.join(
            'https://www.googleapis.com/compute/v1/',
            expand_variables(
              'projects/{{project}}/zones/{{zone}}/machineTypes/{{name}}',
              data
            )
          )
        end

        def self_link(data)
          self.class.self_link(data)
        end

        # rubocop:disable Metrics/CyclomaticComplexity
        def self.return_if_object(response, kind)
          raise "Bad response: #{response.body}" \
            if response.is_a?(Net::HTTPBadRequest)
          raise "Bad response: #{response}" \
            unless response.is_a?(Net::HTTPResponse)
          return if response.is_a?(Net::HTTPNotFound)
          return if response.is_a?(Net::HTTPNoContent)
          result = JSON.parse(response.body)
          raise_if_errors result, %w[error errors], 'message'
          raise "Bad response: #{response}" unless response.is_a?(Net::HTTPOK)
          raise "Incorrect result: #{result['kind']} (expected '#{kind}')" \
            unless result['kind'] == kind
          result
        end
        # rubocop:enable Metrics/CyclomaticComplexity

        def return_if_object(response, kind)
          self.class.return_if_object(response, kind)
        end

        def self.extract_variables(template)
          template.scan(/{{[^}]*}}/).map { |v| v.gsub(/{{([^}]*)}}/, '\1') }
                  .map(&:to_sym)
        end

        def self.expand_variables(template, var_data, extra_data = {})
          data = if var_data.class <= Hash
                   var_data.merge(extra_data)
                 else
                   resource_to_hash(var_data).merge(extra_data)
                 end
          extract_variables(template).each do |v|
            unless data.key?(v)
              raise "Missing variable :#{v} in #{data} on #{caller.join("\n")}}"
            end
            template.gsub!(/{{#{v}}}/, CGI.escape(data[v].to_s))
          end
          template
        end

        def self.fetch_resource(resource, self_link, kind)
          get_request = ::Google::Compute::Network::Get.new(
            self_link, fetch_auth(resource)
          )
          return_if_object get_request.send, kind
        end

        def self.raise_if_errors(response, err_path, msg_field)
          errors = ::Google::HashUtils.navigate(response, err_path)
          raise_error(errors, msg_field) unless errors.nil?
        end

        def self.raise_error(errors, msg_field)
          raise IOError, ['Operation failed:',
                          errors.map { |e| e[msg_field] }.join(', ')].join(' ')
        end
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
