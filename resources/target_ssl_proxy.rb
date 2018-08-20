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
require 'google/compute/property/backendservice_selflink'
require 'google/compute/property/enum'
require 'google/compute/property/integer'
require 'google/compute/property/sslcertificate_selflink'
require 'google/compute/property/string'
require 'google/compute/property/time'
require 'google/hash_utils'

module Google
  module GCOMPUTE
    # A provider to manage Google Compute Engine resources.
    class TargetSslProxy < Chef::Resource
      resource_name :gcompute_target_ssl_proxy

      property :creation_timestamp,
               Time, coerce: ::Google::Compute::Property::Time.coerce, desired_state: true
      property :description,
               String, coerce: ::Google::Compute::Property::String.coerce, desired_state: true
      property :id,
               Integer, coerce: ::Google::Compute::Property::Integer.coerce, desired_state: true
      property :tsp_label,
               String,
               coerce: ::Google::Compute::Property::String.coerce,
               name_property: true, desired_state: true
      property :proxy_header,
               equal_to: %w[NONE PROXY_V1],
               coerce: ::Google::Compute::Property::Enum.coerce, desired_state: true
      property :service,
               [String, ::Google::Compute::Data::BackendServiceSelfLinkRef],
               coerce: ::Google::Compute::Property::BackendServiceSelfLinkRef.coerce,
               desired_state: true
      # ssl_certificates is Array of Google::Compute::Property::SslCertificateSelfLinkRefArray
      property :ssl_certificates,
               Array,
               coerce: ::Google::Compute::Property::SslCertificateSelfLinkRefArray.coerce,
               desired_state: true

      property :credential, String, desired_state: false, required: true
      property :project, String, desired_state: false, required: true

      # TODO(alexstephen): Check w/ Chef how to not expose this property yet
      # allow the resource to store the @fetched API results for exports usage.
      property :__fetched, Hash, desired_state: false, required: false

      action :create do
        fetch = fetch_resource(@new_resource, self_link(@new_resource), 'compute#targetSslProxy')
        if fetch.nil?
          converge_by "Creating gcompute_target_ssl_proxy[#{new_resource.name}]" do
            # TODO(nelsonjr): Show a list of variables to create
            # TODO(nelsonjr): Determine how to print green like update converge
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            create_req = ::Google::Compute::Network::Post.new(
              collection(@new_resource), fetch_auth(@new_resource),
              'application/json', resource_to_request
            )
            @new_resource.__fetched =
              wait_for_operation create_req.send, @new_resource
          end
        else
          @current_resource = @new_resource.clone
          @current_resource.creation_timestamp =
            ::Google::Compute::Property::Time.api_parse(fetch['creationTimestamp'])
          @current_resource.id = ::Google::Compute::Property::Integer.api_parse(fetch['id'])
          @current_resource.proxy_header =
            ::Google::Compute::Property::Enum.api_parse(fetch['proxyHeader'])
          @current_resource.service =
            ::Google::Compute::Property::BackendServiceSelfLinkRef.api_parse(fetch['service'])
          @current_resource.ssl_certificates =
            ::Google::Compute::Property::SslCertificateSelfLinkRefArray.api_parse(
              fetch['sslCertificates']
            )
          @new_resource.__fetched = fetch

          update
        end
      end

      action :delete do
        fetch = fetch_resource(@new_resource, self_link(@new_resource), 'compute#targetSslProxy')
        unless fetch.nil?
          converge_by "Deleting gcompute_target_ssl_proxy[#{new_resource.name}]" do
            delete_req = ::Google::Compute::Network::Delete.new(
              self_link(@new_resource), fetch_auth(@new_resource)
            )
            wait_for_operation delete_req.send, @new_resource
          end
        end
      end

      # TODO(nelsonjr): Add actions :manage and :modify

      def exports
        {
          self_link: __fetched['selfLink']
        }
      end

      private

      action_class do
        def resource_to_request
          request = {
            kind: 'compute#targetSslProxy',
            description: new_resource.description,
            name: new_resource.tsp_label,
            proxyHeader: new_resource.proxy_header,
            service: new_resource.service,
            sslCertificates: new_resource.ssl_certificates
          }.reject { |_, v| v.nil? }
          request.to_json
        end

        def update
          converge_if_changed do |_vars|
            # TODO(nelsonjr): Determine how to print indented like upd converge
            # TODO(nelsonjr): Check w/ Chef... can we print this in red?
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            if (@current_resource.proxy_header != @new_resource.proxy_header)
              proxy_header_update(@current_resource)
            end
            if (@current_resource.service != @new_resource.service)
              service_update(@current_resource)
            end
            if (@current_resource.ssl_certificates != @new_resource.ssl_certificates)
              ssl_certificates_update(@current_resource)
            end
            return fetch_resource(@new_resource, self_link(@new_resource),
                                  'compute#targetSslProxy')
          end
        end

        def self.fetch_export(resource, type, id, property)
          return if id.nil?
          resource.resources("#{type}[#{id}]").exports[property]
        end

        def self.resource_to_hash(resource)
          {
            project: resource.project,
            name: resource.tsp_label,
            kind: 'compute#targetSslProxy',
            creation_timestamp: resource.creation_timestamp,
            description: resource.description,
            id: resource.id,
            proxy_header: resource.proxy_header,
            service: resource.service,
            ssl_certificates: resource.ssl_certificates
          }.reject { |_, v| v.nil? }
        end

  def proxy_header_update(data)
    ::Google::Compute::Network::Post.new(
      URI.join(
        'https://www.googleapis.com/compute/v1/',
        expand_variables(
          'projects/{{project}}/global/targetSslProxies/{{name}}/setProxyHeader',
          data
        )
      ),
      fetch_auth(@new_resource),
      'application/json',
      {
        proxyHeader: @new_resource.proxy_header
      }.to_json
    ).send
  end

  def service_update(data)
    ::Google::Compute::Network::Post.new(
      URI.join(
        'https://www.googleapis.com/compute/v1/',
        expand_variables(
          'projects/{{project}}/global/targetSslProxies/{{name}}/setBackendService',
          data
        )
      ),
      fetch_auth(@new_resource),
      'application/json',
      {
        service: @new_resource.service
      }.to_json
    ).send
  end

  def ssl_certificates_update(data)
    ::Google::Compute::Network::Post.new(
      URI.join(
        'https://www.googleapis.com/compute/v1/',
        expand_variables(
          'projects/{{project}}/global/targetSslProxies/{{name}}/setSslCertificates',
          data
        )
      ),
      fetch_auth(@new_resource),
      'application/json',
      {
        sslCertificates: @new_resource.ssl_certificates
      }.to_json
    ).send
  end
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
              'projects/{{project}}/global/targetSslProxies',
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
              'projects/{{project}}/global/targetSslProxies/{{name}}',
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

        def expand_variables(template, var_data, extra_data = {})
          self.class.expand_variables(template, var_data, extra_data)
        end

        def fetch_resource(resource, self_link, kind)
          self.class.fetch_resource(resource, self_link, kind)
        end

        def async_op_url(data, extra_data = {})
          URI.join(
            'https://www.googleapis.com/compute/v1/',
            expand_variables(
              'projects/{{project}}/global/operations/{{op_id}}',
              data, extra_data
            )
          )
        end

        def wait_for_operation(response, resource)
          op_result = return_if_object(response, 'compute#operation')
          return if op_result.nil?
          status = ::Google::HashUtils.navigate(op_result, %w[status])
          fetch_resource(
            resource,
            URI.parse(::Google::HashUtils.navigate(wait_for_completion(status,
                                                                       op_result,
                                                                       resource),
                                                   %w[targetLink])),
            'compute#targetSslProxy'
          )
        end

        def wait_for_completion(status, op_result, resource)
          op_id = ::Google::HashUtils.navigate(op_result, %w[name])
          op_uri = async_op_url(resource, op_id: op_id)
          while status != 'DONE'
            debug("Waiting for completion of operation #{op_id}")
            raise_if_errors op_result, %w[error errors], 'message'
            sleep 1.0
            raise "Invalid result '#{status}' on gcompute_target_ssl_proxy." \
              unless %w[PENDING RUNNING DONE].include?(status)
            op_result = fetch_resource(resource, op_uri, 'compute#operation')
            status = ::Google::HashUtils.navigate(op_result, %w[status])
          end
          op_result
        end

        def raise_if_errors(response, err_path, msg_field)
          self.class.raise_if_errors(response, err_path, msg_field)
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
  end
end
