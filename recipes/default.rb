#
# Cookbook Name:: unbound
# Recipe:: default
#
# Copyright 2013, Hokger Just, Planio GmbH
#
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
#

root_group = value_for_platform(
  "freebsd" => { "default" => "wheel" },
  "default" => "root"
)

package "unbound"

directory "#{node["unbound"]["server"]["directory"]}/conf.d" do
  owner "root"
  group root_group
  mode "0755"
end

template "#{node["unbound"]["server"]["directory"]}/unbound.conf" do
  source "unbound.conf.erb"
  mode 0644
  owner "root"
  group root_group
  variables :server => node["unbound"]["server"],
            :includes => []
  notifies :restart, "service[unbound]"
end

service "unbound" do
  supports "restart" => true
  action [:enable, :start]
end
