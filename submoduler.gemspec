# frozen_string_literal: true

require_relative 'lib/submoduler/version'

# Main namespace
module Rubyists
  Gem::Specification.new do |spec|
    spec.name = 'submoduler'
    spec.version = Submoduler::VERSION
    spec.authors = ['Tj (bougyman) Vanderpoel']
    spec.email = ['tj@rubyists.com']

    spec.summary = 'Simple gem to help relocate git submodules.'
    spec.description = 'Written specifically to relocate vim plugins.'
    spec.homepage = 'https://github.com/rubyists/submoduler'
    spec.license = 'MIT'
    spec.required_ruby_version = '>= 3.2.0'

    spec.metadata['allowed_push_host'] = 'https://rubygems.org'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['changelog_uri'] = File.join(spec.homepage, 'blob/main/CHANGELOG.md')

    # Specify which files should be added to the gem when it is released.
    # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
    gemspec = File.basename(__FILE__)
    spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
      ls.readlines("\x0", chomp: true).reject do |f|
        (f == gemspec) ||
          f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
      end
    end
    spec.bindir = 'exe'
    spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
    spec.require_paths = ['lib']

    # Uncomment to register a new dependency of your gem
    spec.add_dependency 'git', '~> 1'
    spec.add_dependency 'inifile', '~> 3'

    # For more information and examples about making a new gem, check out our
    # guide at: https://bundler.io/guides/creating_gem.html
    spec.metadata['rubygems_mfa_required'] = 'true'
  end
end
