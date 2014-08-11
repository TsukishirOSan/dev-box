require 'spec_helper'

describe 'PostgreSQL' do
  [
    'postgresql-9.3',
    'postgresql-client-9.3',
    'postgresql-contrib-9.3',
    'postgresql-server-dev-9.3'
  ].each do |name|
    describe package(name) do
      it { should be_installed }
    end
  end

  describe service('postgresql') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(5432) do
    it { should be_listening }
  end
end
