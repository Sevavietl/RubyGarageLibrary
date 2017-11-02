# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "Library"
  spec.version       = '1.0'
  spec.authors       = ["Sevavietl"]
  spec.email         = ["sevavietl@gmail.com"]
  spec.summary       = %q{Short summary of your project}
  spec.description   = %q{Longer description of your project.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = ['lib/library.rb']
  spec.executables   = ['bin/library']
  spec.test_files    = ['tests/test_library.rb']
  spec.require_paths = ["lib"]
end
