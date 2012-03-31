require 'colorize'

String::MODES[:bold] = 1
String.send(:define_method, :bold) do
  self.colorize(:mode => :bold)
end
