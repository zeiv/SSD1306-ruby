# SSD1306

This is a library for the SSD1306 OLED Display written in Ruby.  It was inspired by Adafruit's libraries written in Python and C.  Much of the original logic was simply ported from their Python library, but in addition this Ruby library provides additional functionality such as `print` and `println` helpers.  The library also features simple image parsing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'SSD1306'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install SSD1306

## Usage

Using the library is simple.  To start with, require the library and initialize the display:

```ruby
require 'SSD1306'
disp = SSD1306::Display.new
```

The default options are suitable for the Raspberry Pi and a 128x64 display.  These can be overridden by specifying values like so:

```ruby
disp = SSD1306::Display.new(protocol: :i2c, path: '/dev/i2c-1', address: 0x3C, width: 128, height: 64)
```

Writing text on the display is simple:

```ruby
disp.println "This is my IP Address:"
disp.println "" # The same as disp.print "\n"
disp.font_size = 2
disp.println ip_address
disp.display!
```

You can also display monochrome images:

```ruby
include Magick  # RMagick is a dependency
image = Image.read("path/to/my/image.png").first # Image.read returns an array

disp.image(image) # Pass in an RMagick image object
disp.display!
```

The display can also be easily cleared:

```ruby
disp.clear
disp.display!

# Or more simply:
disp.clear!
```

Check out the source code for additional information.

## To-do

* Currently only 1, 2, and 4 work as font sizes. In the meantime, to use other fonts or font sizes, I recommend using RMagick's `annotate` feature and passing in an image.
* Implement SPI.  Only I2C is currently supported. (For v1.0)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec SSD1306` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zeiv/SSD1306-ruby.

## Acknowledgements

This library is inspired by the Adafruit SSD1306 Python library, available here: https://github.com/adafruit/Adafruit_Python_SSD1306

## License

Copyright (c) 2016 Xavier Bick under the MIT License.  See the LICENSE file for details.
