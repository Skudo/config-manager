require 'spec_helper'

RSpec.describe ConfigManager do
  it 'has a version number' do
    expect(ConfigManager::VERSION).not_to be nil
  end
end
