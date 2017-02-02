require "codeclimate-test-reporter"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'SSD1306'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
