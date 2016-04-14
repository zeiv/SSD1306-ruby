require "i2c"

require "SSD1306/version"

# Constants
SSD1306_I2C_ADDRESS = 0x3C	# 011110+SA0+RW - 0x3C or 0x3D
SSD1306_SETCONTRAST = 0x81
SSD1306_DISPLAYALLON_RESUME = 0xA4
SSD1306_DISPLAYALLON = 0xA5
SSD1306_NORMALDISPLAY = 0xA6
SSD1306_INVERTDISPLAY = 0xA7
SSD1306_DISPLAYOFF = 0xAE
SSD1306_DISPLAYON = 0xAF
SSD1306_SETDISPLAYOFFSET = 0xD3
SSD1306_SETCOMPINS = 0xDA
SSD1306_SETVCOMDETECT = 0xDB
SSD1306_SETDISPLAYCLOCKDIV = 0xD5
SSD1306_SETPRECHARGE = 0xD9
SSD1306_SETMULTIPLEX = 0xA8
SSD1306_SETLOWCOLUMN = 0x00
SSD1306_SETHIGHCOLUMN = 0x10
SSD1306_SETSTARTLINE = 0x40
SSD1306_MEMORYMODE = 0x20
SSD1306_COLUMNADDR = 0x21
SSD1306_PAGEADDR = 0x22
SSD1306_COMSCANINC = 0xC0
SSD1306_COMSCANDEC = 0xC8
SSD1306_SEGREMAP = 0xA0
SSD1306_CHARGEPUMP = 0x8D
SSD1306_EXTERNALVCC = 0x1
SSD1306_SWITCHCAPVCC = 0x2

# Scrolling constants
SSD1306_ACTIVATE_SCROLL = 0x2F
SSD1306_DEACTIVATE_SCROLL = 0x2E
SSD1306_SET_VERTICAL_SCROLL_AREA = 0xA3
SSD1306_RIGHT_HORIZONTAL_SCROLL = 0x26
SSD1306_LEFT_HORIZONTAL_SCROLL = 0x27
SSD1306_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL = 0x29
SSD1306_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL = 0x2A

class SSD1306
  attr_accessor :protocol, :path, :address, :width, :height

  def initialize(opts = {})
    default_options = {
      protocol: :i2c,
      path: '/dev/i2c-1',
      address: 0x3C,
      width: 128,
      height: 64
    }
    options = default_options.merge(opts)

    # Attributes for attr_accessor
    @protocol = options[:protocol]
    @path = options[:path]
    @address = options[:address]
    @width = options[:width]
    @height = options[:height]

    # Variables needed internally
    @pages = @height / 8
    @buffer = [0]*(@width*@pages)
    if @protocol == :i2c
      @interface = I2C.create(@path)
    elsif @protocol == :spi
      raise "SPI Not Supported Currently"
    else
      raise "Unrecognized protocol"
    end

    self.command SSD1306_DISPLAYON

    # For 128 x 64 display
    if @height == 64
      self.command SSD1306_DISPLAYOFF
      self.command SSD1306_SETDISPLAYCLOCKDIV
      self.command 0x80
      self.command SSD1306_SETMULTIPLEX
      self.command 0x3F
      self.command SSD1306_SETDISPLAYOFFSET
      self.command 0x0
      self.command(SSD1306_SETSTARTLINE | 0x0)
      self.command SSD1306_CHARGEPUMP
      self.command 0x10
      #TODO VCCSTATE?
      self.command SSD1306_MEMORYMODE
      self.command 0x00
      self.command(SSD1306_SEGREMAP | 0x1)
      self.command SSD1306_COMSCANDEC
      self.command SSD1306_SETCOMPINS
      self.command 0x12
      self.command SSD1306_SETCONTRAST
      #TODO EXTERNAL VCC?
      self.command 0x9F
      self.command SSD1306_SETPRECHARGE
      #TODO VCC?
      self.command 0x22
      self.command SSD1306_SETVCOMDETECT
      self.command 0x40
      self.command SSD1306_DISPLAYALLON_RESUME
      self.command SSD1306_NORMALDISPLAY
    end
  end

  def command(c)
    control = 0x00
    @interface.write @address, control, c
  end

  def data(d)
    control = 0x40
    @interface.write @address, control, c
  end

  def display!
    self.command SSD1306_COLUMNADDR
    self.command 0
    self.command(@width - 1)
    self.command SSD1306_PAGEADDR
    self.command 0
    self.command(@pages - 1)
    # Write buffer data
    # TODO: This works for I2C only
    for i in range(0, @buffer.length, 16)
      control = 0x40
      @interface.write control, @buffer[i:i+16]
    end
  end

  #TODO Complete image processing
  def image(image)
    raise "Image functionality not implemented yet"
  end

  def clear
    @buffer = [0]*(@width*@pages)
  end

  def clear!
    self.clear
    self.display
  end

  #TODO Implement Contrast functionality
  def set_contrast(contrast)
    raise "Contrast not yet implemented"
  end

  #TODO Implement Dimming functionality
  def dim(dim)
    raise "Dim not implemented yet"
  end
end
