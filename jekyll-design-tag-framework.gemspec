# frozen_string_literal: true

require_relative "lib/jekyll-design-tag-framework/version"

Gem::Specification.new do |s|
  s.name = "jekyll-design-tag-framework"
  s.version = Jekyll::DesignTagFramework::VERSION
  s.authors = ["Markus Sosnowski"]
  s.summary = "A collection of Liquid tags for Jekyll themes and sites, to help separating design and content."
  s.license = "AGPL-3.0-only"

  s.homepage = "https://design-tag-framework.github.io/jekyll-design-tag-framework/"

  s.platform = Gem::Platform::RUBY

  s.required_ruby_version = ">= 3.0.0"

  s.files = `git ls-files -z`.split("\x0").select do |file|
    file.match(%r!(^lib/)|LICENSE|README.md!)
  end

  s.require_paths = ["lib"]

  s.add_dependency "jekyll", ">= 4.0", "< 5.0"
  s.add_development_dependency "bundler", "~> 2.6"
  s.add_development_dependency "minitest", "~> 5.0"
  s.add_development_dependency "rubocop-jekyll", "~> 0.14.0"
end
