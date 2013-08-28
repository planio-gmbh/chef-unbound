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

template "unbound.conf" do
  path "#{node["unbound"]["server"]["directory"]}/unbound.conf"
  source "unbound.conf.erb"
  mode 0644
  owner "root"
  group root_group
  variables :server => node["unbound"]["server"],
            :includes => []
end

check_config = "\"#{node["unbound"]["bindir"]}/unbound-checkconf\" \"#{node["unbound"]["server"]["directory"]}/unbound.conf\""
case node["unbound"]["init_style"]
when "init"
  service "unbound" do
    supports "restart" => true
    action [:enable, :start]
    subscribes :restart, "template[unbound.conf]"

    start_command "#{check_config} && /etc/init.d/unbound start"
    reload_command "#{check_config} && /etc/init.d/unbound reload"
    restart_command "#{check_config} && /etc/init.d/unbound restart"
  end
when "runit"
  service "unbound_init" do
    service_name "unbound"
    pattern "unbound"
    action [:stop, :disable]
  end

  include_recipe "runit"
  runit_service "unbound" do
    default_logger true
    subscribes :restart, "template[unbound.conf]"

    reload_command "#{check_config} && #{node['runit']['sv_bin']} restart #{node['runit']['service_dir']}/unbound"
    restart_command "#{check_config} && #{node['runit']['sv_bin']} restart #{node['runit']['service_dir']}/unbound"
    action [:enable, :start]
  end
end
