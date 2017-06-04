require 'spec_helper'

RSpec.describe ConfigManager::CLI do
  subject { ConfigManager::CLI }

  describe '.start' do
    it 'exists' do
      expect(subject).to respond_to(:start)
    end
  end
end
