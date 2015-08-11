--!!!!nodemcu_512k_20150106
--Init.lua
PORT=7777
pin=3
gpio.mode(pin, gpio.INPUT)
tmr.alarm(1,5000, 1, function()
if wifi.ap.getip()~=nil  then
	if gpio.read(pin)==1 then
	tmr.stop(1) print("WIFI_UDP_RS232 V1.1 06.01.2015")
	else
	tmr.stop(1) print("Telnet V1.1") dofile("telnet.lua")
end end end)
uart.setup( 0,9600, 8, 0, 1, 0 )
srv=net.createServer(net.UDP)
srv:on("receive", function(srv, pl) tmr.wdclr() uart.write(0,pl) end)
srv:listen(PORT) uart.on("data",0,function(data)srv:send(data)end, 0)
