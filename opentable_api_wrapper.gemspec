# frozen_string_literal: true

require_relative 'lib/opentable_api_wrapper/version'

Gem::Specification.new do |spec|
  spec.name = 'opentable_api_wrapper'
  spec.version = OpentableApiWrapper::VERSION
  spec.authors = ['AlejandroFernandesAntunes']
  spec.email = ['aantunes70@hotmail.com']

  spec.summary = 'OpenTable API Wrapper'
  spec.description = 'OpenTable API Wrapper'
  spec.homepage = 'https://github.com/AlejandroFernandesAntunes/opentable_api_wrapper.git'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/AlejandroFernandesAntunes/opentable_api_wrapper.git'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'activerecord'
  spec.add_dependency 'activerecord-import'
  spec.add_dependency 'geocoder'
  spec.add_dependency 'httparty'
  spec.add_dependency 'sidekiq'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
