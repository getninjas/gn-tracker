lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'gn/tracker/version'

Gem::Specification.new do |spec|
  spec.authors       = ["GetNinjas"]
  spec.bindir        = "exe"
  spec.email         = ["tech@getninjas.com.br"]
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.homepage      = "http://www.getninjas.com.br"
  spec.license       = "MIT"
  spec.name          = "gn-tracker"
  spec.require_paths = ["lib"]
  spec.summary       = "Gem which encapsulates logstash-logger"
  spec.version       = Gn::Tracker::VERSION

  spec.add_runtime_dependency "logstash-logger"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop-rspec"
end
