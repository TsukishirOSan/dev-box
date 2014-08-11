require 'spec_helper'

describe package('redis-server') do
  it { should be_installed }
end

describe service('redis') do
  it { should be_enabled }
  it { should be_running }
end

describe port(6379) do
  it { should be_listening }
end

describe package('redis-tools') do
  it { should be_installed }
end
