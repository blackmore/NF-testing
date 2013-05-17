require 'socket'
require './config'

# connects to newfor server
streamSock = TCPSocket.new( SERVER_IP, PORT )

puts "connecting..."
sleep 1

puts "pushing"

BLOCK.each do |sub|
  streamSock.send(sub, 0)
  sleep SPEED
end

puts "closing"
streamSock.close
