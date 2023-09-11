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

  spec.add_development_dependency 'bundler', '~> 2.4.10'
  spec.add_development_dependency 'rake', '~> 13.0.6'
  spec.add_development_dependency 'rspec', '~> 3.12.0'
  spec.add_development_dependency 'sqlite3', '~> 1.6.4'
  spec.add_development_dependency 'puma', '~> 6.3', '>= 6.3.1'

  spec.add_runtime_dependency 'powerdns_db_cli', '>= 0', '~> 0.0.9'
  spec.add_runtime_dependency 'rack', '~> 2.2.4'
  spec.add_runtime_dependency 'rack-test', '~> 2.1.0'
  spec.add_runtime_dependency 'sinatra', '~> 3.1.0'

  spec.required_ruby_version = "~> 3.2"
end
