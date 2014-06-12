#
# Author:: Hoat Le <hoatlevan@gmail.com>
# Cookbook Name:: teracy-dev
# Recipe:: git-config
# Description: Configures global git
#
# Copyright 2013, Teracy, Inc.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:

#     1. Redistributions of source code must retain the above copyright notice,
#        this list of conditions and the following disclaimer.

#     2. Redistributions in binary form must reproduce the above copyright
#        notice, this list of conditions and the following disclaimer in the
#        documentation and/or other materials provided with the distribution.

#     3. Neither the name of Teracy, Inc. nor the names of its contributors may be used
#        to endorse or promote products derived from this software without
#        specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# JUST change the attribute version below to change the git version, No more work here
node.override['git']['version'] = '2.0.0'
node.override['git']['url'] = "https://www.kernel.org/pub/software/scm/git/git-#{node['git']['version']}.tar.gz"

include_recipe 'git::source'

template '/home/vagrant/.gitconfig' do
    source 'gitconfig.erb'
    owner 'vagrant'
    group 'vagrant'
    mode '0664'
end

template '/home/vagrant/.gitmessage.txt' do
    source 'gitmessage.erb'
    owner 'vagrant'
    group 'vagrant'
    mode '0664'
    only_if { node['teracy-dev']['git']['commit']['template'] }
end
