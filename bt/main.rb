
module BT
  class Main
    include_package 'org.eclipse.swt'
    include_package 'org.eclipse.swt.layout'
    include_package 'org.eclipse.swt.graphics'
    include_package 'org.eclipse.swt.widgets'

    attr_reader :display, :shell
    def initialize
      @display = Display.new
      @shell = Shell.new display
    end

    def prepare
      Display.app_name = 'BT'

      shell.setSize(450, 200)

      layout = RowLayout.new
      layout.wrap = true

      shell.layout = layout
      shell.text = 'BT in JRuby'
      stop_scroll = false

      b = Button.new(shell, SWT::PUSH)
      b.add_selection_listener do |event|
        if stop_scroll
          puts 'starting'
          stop_scroll = false
          b.text = 'Stop scroll'
        else
          puts 'stopping'
          stop_scroll = true
          b.text = 'start scroll'
        end
      end
      b.text = 'stop scroll'

      label = Label.new(shell, SWT::CENTER)
      image = Image.new(display, File.expand_path('./jruby.png'))
      label.image = image

      Thread.new do
        loop do
          while stop_scroll do
            sleep 0.5
          end

          # Execute the movement in the display thread
          display.sync_exec do
            p = Point.new(label.location.x, label.location.y + 2)
            label.location = p
          end
          sleep 1
        end
      end

      shell.pack
      shell.open
    end

    def run
      prepare

      until shell.is_disposed do
        unless display.read_and_dispatch
          display.sleep
        end
      end

      shutdown
    end

    def shutdown
      display.dispose
    end
  end
end

