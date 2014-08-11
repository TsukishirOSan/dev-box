require 'spec_helper'

describe package('redis') do
  it { should be_installed }
end

describe service('redis') do
  it { should be_enabled }
  it { should be_running }
end

describe port(6379) do
  it { shuld be_listening }
end
