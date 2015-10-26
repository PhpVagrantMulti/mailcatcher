#/bin/bash

##
# run_mailcatcher.sh
# Starts the mailcatcher application
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

mailcatcher -f --smtp-ip 127.0.0.1 --smtp-port 1025 --http-ip 192.168.33.10 --http-port 8080
