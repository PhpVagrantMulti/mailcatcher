##
# default.rb
# Installs and configures mailcatcher on the development vm
# Cookbook Name:: mailcatcher
# Recipe:: default
# AUTHORS::   Seth Griffin <griffinseth@yahoo.com>
# Copyright:: Copyright 2015 Authors
# License::   GPLv3
#
# This file is part of PhpVagrantMulti.
# PhpVagrantMulti is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# PhpVagrantMulti is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with PhpVagrantMulti.  If not, see <http://www.gnu.org/licenses/>.
##

%w{libsqlite3-dev ruby1.9.1-dev}.each do |pkg|
    package pkg do
        action :install
    end
end

gem_package "mailcatcher" do
    action :install
end

cookbook_file '/home/vagrant/run_mailcatcher.sh' do
  source 'run_mailcatcher.sh'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
end

file "/etc/php5/mods-available/sendmail_override.conf" do
    owner 'root'
    group 'root'
    mode  '0444'
    content "sendmail_path = /usr/bin/env catchmail --smtp-ip 127.0.0.1 --smtp-port 1025 -f www-data@vagrant-trusty64"
end

execute "enable_sendmail_override_apache" do
    not_if { File.exists?("/etc/php5/apache2/conf.d/20-sendmail-override.ini") }
    command "sudo ln -s /etc/php5/mods-available/sendmail_override.conf /etc/php5/apache2/conf.d/20-sendmail-override.ini"
    action :run
end

execute "enable_sendmail_override_cli" do
    not_if { File.exists?("/etc/php5/cli/conf.d/20-sendmail-override.ini") }
    command "sudo ln -s /etc/php5/mods-available/sendmail_override.conf /etc/php5/cli/conf.d/20-sendmail-override.ini"
    action :run
    notifies :restart, "service[apache2]", :immediately
end
