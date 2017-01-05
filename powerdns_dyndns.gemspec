Gem::Specification.new do |spec|
  spec.name          = 'powerdns_dyndns'
  spec.version       = '0.0.2'
  spec.authors       = ['henning mueller']
  spec.email         = ['mail@nning.io']

  spec.summary       = 'DynDNS (dyn.com DNS update API) server.'
# spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3.13'

  spec.add_runtime_dependency 'powerdns_db_cli', '>= 0', '~> 0.0.6'
  spec.add_runtime_dependency 'rack', '~> 1.5.5'
  spec.add_runtime_dependency 'rack-test', '~> 0.6.3'
  spec.add_runtime_dependency 'sinatra', '~> 1.4.7'
end
