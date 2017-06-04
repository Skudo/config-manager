# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'config_manager/version'

Gem::Specification.new do |spec|
  spec.name          = 'config-manager'
  spec.version       = ConfigManager::VERSION
  spec.authors       = ['Huy Dinh']
  spec.email         = ['mail@huydinh.eu']

  spec.summary       = 'A command-line tool to manage config files in a central repository.'
  spec.description   = 'A command-line tool to manage config files in a central repository.'
  spec.homepage      = 'https://github.com/Skudo/config-manager'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor', '~> 0.19.4'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.14.1'
end
