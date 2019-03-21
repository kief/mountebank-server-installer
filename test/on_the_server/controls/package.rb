# encoding: utf-8

title 'mountebank package'

describe package('mountebank') do
  it { should be_installed }
end

# describe service('mountebank') do
#   it { should be_installed }
#   it { should be_enabled }
#   it { should be_running }
# end

describe bash('ps -elf') do
  its('stdout') { should match /mountebank/ }
end

describe processes(/mountebank/) do
  its('list.length') { should be >0 }
end

