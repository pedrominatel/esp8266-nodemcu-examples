wifi.setmode(wifi.SOFTAP)
wifi.ap.config({ssid="ssid",pwd="senha"})
wifi.ap.setip({ip="192.168.0.1",netmask="255.255.255.0",gateway="192.168.0.1"})

uart.setup(0,9600,8,0,1,0)
sv=net.createServer(net.TCP, 60)
global_c = nil
sv:listen(3000, function(c)
    if global_c~=nil then
        global_c:close()
    end
    global_c=c
    c:on("receive",function(sck,pl)
        uart.write(0,pl)
    end)
end)

uart.on("data",4, function(data)
    if global_c~=nil then
        global_c:send(data)
    end
end, 0)
