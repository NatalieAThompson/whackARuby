require 'gosu'

class WhackARuby < Gosu::Window
  WINDOW_HEIGHT = 600
  WINDOW_WIDTH = 800
  TEXT_Z = 1.0
  PERSIST = 2000

  def initialize()
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption = 'Whack the Ruby!'
    @js = Gosu::Image.new('js.png')
    @hammer = Gosu::Image.new('hammer.png')
    @x = 200
    @y = 200
    @velocity_x = 5
    @velocity_y = 5
    @visible = 1
    @hit = 0
    @font = Gosu::Font.new(20)
    @start_hit = 0
  end

  def current_time
    Gosu.milliseconds
  end

  def draw()
    if @visible > 0
      @js.draw(@x - @js.width / 2, @y - @js.height / 2)
    end

    @hammer.draw(mouse_x() - @hammer.width / 2, mouse_y() - @hammer.height / 2)

    # When 2 seconds have elapsed since the last hit
      # stop showing the text & reset @start_hit
    # When @start_hit = 0
      # Do nothing
    # When

    if @start_hit != 0 && current_time - @start_hit < PERSIST
      @font.draw_text("Hit!", mouse_x(), mouse_y(), TEXT_Z, 1.0, 1.0, Gosu::Color::YELLOW) # ZOrder::UI as Z
      if current_time > @start_hit + PERSIST
        @start_hit = 0
      end
    end
  end

  def update()
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= -1 if @x + @js.width / 2 > WINDOW_WIDTH || @x - @js.width / 2 < 0
    @velocity_y *= -1 if @y + @js.height / 2 > WINDOW_HEIGHT || @y - @js.height / 2 < 0
    #@visible -= 1
    #@visible = 30 if @visible < -10 && rand < 0.05
    if @hit > 0 && @start_hit.zero?
      @start_hit = current_time
    end
  end

  def button_down(id)
    if (id == Gosu::MsLeft)
      @hit = (Gosu.distance(mouse_x(), mouse_y(), @x, @y) < 50 && @visible >= 0 ? 1 : -1)
    else
      @hit = 0
    end
  end
end

window = WhackARuby.new
window.show