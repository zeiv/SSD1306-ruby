module SSD1306
  class Cursor
    attr_accessor :size, :x_pos, :y_pos

    def initialize
      @size = 1
      @x_pos = 0
      @y_pos = 0
    end

    def increment
      if @x_pos >= (126 - 5*@size)
        newline
      else
        @x_pos += 5*size
      end
    end

    def newline
      @x_pos = 0
      @y_pos += 8*size
    end

    def set_pos(x, y)
      @x_pos = x
      @y_pos = y
    end

    def buffer_index
      page = @y_pos / 8
      index = (page*128) + @x_pos
    end

    def position_in_buffer
      index = buffer_index
      page = @y_pos / 8
      offset = @y_pos % 8
      {index: index, x: @x_pos, page: page, page_offset: offset}
    end
  end
end
