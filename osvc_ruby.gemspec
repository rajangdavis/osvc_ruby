# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'osvc_ruby/version'

Gem::Specification.new do |spec|
    spec.name          = "osvc_ruby"
    spec.version       = OSvCRuby::VERSION
    spec.authors       = ["Rajan Davis"]
    spec.email         = ["rajangdavis@gmail.com"]
    spec.summary       = %q{Making the best of opensource and enterprise technology}
    spec.description   = %q{An unofficial Ruby ORM on top of the Oracle Cloud Services (fka RightNow Technologies) REST API}
    spec.homepage      = %q{https://github.com/rajangdavis/osvc_ruby}
    spec.license       = "MIT"

    spec.files         = `git ls-files -z`.split("\x0")
    spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
    spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
    spec.require_paths = ["lib"]

    spec.add_development_dependency "simplecov"   
    spec.add_development_dependency "codeclimate-test-reporter", '~> 1.0', '>= 1.0.0'   
    spec.add_development_dependency "bundler"
    spec.add_development_dependency "rake", "~> 10.0"
    spec.add_development_dependency 'rspec', '~> 3.2', '>= 3.2.0'
    spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.3'
    spec.add_development_dependency "webmock"
end