
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
#       "recipe[gcompute::examples~network~convert_to_custom]"
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

raise "Missing parameter 'network_id'. Please read docs at #{__FILE__}" \
  unless ENV.key?('network_id')

# The environment variable 'network_id' defines a suffix for a network name when
# using this example. If running from the command line, you can pass this suffix
# in via the command line:
#
# network_id="some_suffix" chef-client -z --runlist \
#   "recipe[gcompute::examples~network~auto]"
puts 'Converting network to Custom'
gcompute_network "mynetwork-#{ENV['network_id']}" do
  action :create
  auto_create_subnetworks false
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end
