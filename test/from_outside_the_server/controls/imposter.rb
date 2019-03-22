# encoding: utf-8

title 'mountebank imposter works'

describe http('http://localhost:8080/') do
  its('status') { should eq 200 }
  its('body') { should match /local-kitchen/ }
end

