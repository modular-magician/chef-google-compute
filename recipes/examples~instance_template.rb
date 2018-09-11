
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

# The following example requires two environment variables to be set:
#   * CRED_PATH - the path to a JSON service_account file
#   * PROJECT - the name of your GCP project.
#
# For convenience you optionally can add these to your ~/.bash_profile (or the
# respective .profile settings) environment:
#
#   export CRED_PATH=/path/to/my/cred.json
#   export PROJECT=/path/to/my/cred.json
#
# The following command will run this example:
#   CRED_PATH=/path/to/my/cred.json \
#   PROJECT='my-test-project'
#     chef-client -z --runlist \
#       "recipe[gcompute::examples~instance_template]"
#
# ________________________

raise "Missing parameter 'CRED_PATH'. Please read docs at #{__FILE__}" \
  unless ENV.key?('CRED_PATH')
raise "Missing parameter 'PROJECT'. Please read docs at #{__FILE__}" \
  unless ENV.key?('PROJECT')

# For more information on the gauth_credential parameters and providers please
# refer to its detailed documentation at:
# https://github.com/GoogleCloudPlatform/chef-google-auth
gauth_credential 'mycred' do
  action :serviceaccount
  path ENV['CRED_PATH'] # e.g. '/path/to/my_account.json'
  scopes [
    'https://www.googleapis.com/auth/compute'
  ]
end

# TODO(nelsonjr): Reactiveate example based on disk once http://b/66871792 is
# resolved.
#gcompute_disk 'os-disk-1' do
#  action :create
#  zone 'us-west1-a'
#  source_image 'projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts'
#  project ENV['PROJECT'] # ex: 'my-test-project'
#  credential 'mycred'
#end

# Google::Functions must be included at runtime to ensure that the
# gcompute_image_family function can be used in gcompute_disk blocks.
::Chef::Resource.send(:include, Google::Functions)

gcompute_network 'mynetwork-test' do
  action :create
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

gcompute_instance_template 'instance-template-test' do
  action :create
  properties(
    machine_type: 'n1-standard-1',
    disks: [
      {
        # Tip: Auto delete will prevent disks from being left behind on
        # deletion.
        auto_delete: true,
        boot: true,
        initialize_params: {
          disk_size_gb: 100,
          source_image:
            gcompute_image_family('ubuntu-1604-lts', 'ubuntu-os-cloud')
        }
      }
    ],
    metadata: {
      'startup-script-url' => 'gs://graphite-playground/bootstrap.sh',
      'cost-center' => '12345'
    },
    network_interfaces: [
      {
        access_configs: {
          name: 'test-config',
          type: 'ONE_TO_ONE_NAT',
        },
        network: 'mynetwork-test'
      }
    ]
  )
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end
