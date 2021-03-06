# frozen_string_literal: true

require_relative "lib/dependabot/version"

Gem::Specification.new do |spec|
  spec.authors = ["mo khan"]
  spec.bindir = "exe"
  spec.description = "Definitely not Dependabot"
  spec.email = ["xlgmokha@github.com"]
  spec.executables = ["dependabot"]
  spec.files = Dir.glob([
    "*.gemspec",
    "LICENSE.txt",
    "README.md",
    "exe/*",
    "lib/**/*.erb",
    "lib/**/*.rb",
  ])
  spec.homepage = "https://github.com/dependanot/cli"
  spec.license = "MIT"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.name = "dependanot"
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 3.0.0"
  spec.summary = "Definitely not Dependabot"
  spec.version = Dependabot::VERSION
  spec.add_dependency "bundler", "~> 2.0"
  spec.add_dependency "octokit", "~> 4.0"
  spec.add_dependency "rugged", "~> 1.2"
  spec.add_dependency "spandx", ">= 0.18.3"
  spec.add_dependency "straw", "~> 0.1"
  spec.add_dependency "thor", "~> 1.1"
end
