require "arduino_firmata"

arduino = ArduinoFirmata.connect


loop do
  system "stty raw -echo"
  char = STDIN.read_nonblock(1) rescue nil
  system "stty -raw echo"

  if /a/i =~ char
    demo_relay
  end
end

def demo_relay
  arduino.digital_write 2, true
  sleep 4

  arduino.digital_write 2, false
  sleep 4
end