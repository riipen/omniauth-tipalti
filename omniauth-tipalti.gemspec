# frozen_string_literal: true

require_relative "lib/omniauth/tipalti/version"

Gem::Specification.new do |spec|
  spec.name = "omniauth-tipalti"
  spec.version = Omniauth::Tipalti::VERSION
  spec.authors = ["Jordan Ell"]
  spec.email = ["me@jordanell.com"]

  spec.summary = "OmniAuth Oauth2 strategy for Tipalti."
  spec.description = <<~HEREDOC
    OmniAuth Oauth2 strategy for Tipalti allowing you to#{" "}
    connect to a specific Tipalti instance.
  HEREDOC
  spec.homepage = "https://github.com/riipen/omniauth-tipalti"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/riipen/omniauth-tipalti"
  spec.metadata["changelog_uri"] = "https://github.com/riipen/omniauth-tipalti/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth", "~> 2.0"
  spec.add_dependency "omniauth-oauth2", "~> 1.8"
  spec.metadata["rubygems_mfa_required"] = "true"
end
