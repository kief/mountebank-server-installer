# encoding: utf-8

title 'mountebank control port'

describe http('http://localhost:2525/imposters') do
  its('status') { should eq 200 }
  its('body') { should match /\"imposters\":/ }
end
