# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'SSD1306/version'

Gem::Specification.new do |spec|
  spec.name          = "SSD1306"
  spec.version       = SSD1306::VERSION
  spec.authors       = ["Xavier Bick", "Jacob Killelea"]
  spec.email         = ["fxb9500@gmail.com", "Jkillelea@protonmail.ch"]
  spec.license       = 'MIT'

  spec.summary       = %q{A library for the SSD1306 OLED Display}
  spec.description   = %q{Use this library to interface to an SSD1306 OLED via I2C or SPI.  It was developed with the Raspberry Pi in mind, but should work on any device with I2C or SPI.}
  spec.homepage      = "https://github.com/zeiv/SSD1306-ruby"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_runtime_dependency "i2c", ">= 0.4.0"
end
