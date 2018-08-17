lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mongoid_localized_presence_validator/version"

Gem::Specification.new do |spec|
  spec.name          = "mongoid_localized_presence_validator"
  spec.version       = MongoidLocalizedPresenceValidator::VERSION
  spec.authors       = ["Tomas Celizna", "Asger Behncke Jacobsen"]
  spec.email         = ["tomas.celizna@gmail.com", "a@asgerbehnckejacobsen.dk"]

  spec.summary       = "Adds logic for localized fields to mongoid's presence validator"
  spec.homepage      = 'https://github.com/tomasc/mongoid_localized_presence_validator'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'mongoid', '~> 7.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'database_cleaner', '>= 1.5.1'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake', '~> 10.0'
end
