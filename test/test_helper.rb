require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'SSD1306'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
