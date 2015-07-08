wifi.setmode(wifi.STATION)
wifi.sta.config("ssid","senhadarede")

function sendData()

conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(conn, payload) print(payload) end)
conn:connect(80,'184.106.153.149') 
conn:send("GET /talkbacks/SEU_ID/commands/execute?api_key=SUACHAVE HTTP/1.1\r\n") 
conn:send("Host: api.thingspeak.com\r\n") 
conn:send("Accept: */*\r\n") 
conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
conn:send("\r\n")

conn:on("receive",function(conn, payload)

    if(string.find(payload,"CMD_LIGAR") ~= nil) then
        print("CMD_LIGAR")
    end

    if(string.find(payload,"CMD_DESLIGAR") ~= nil) then
        print("CMD_DESLIGAR")
    end

    if(string.find(payload,"CMD_OUTRO") ~= nil) then
        print("CMD_OUTRO")
    end
                      
conn:close()
                  end)
conn:on("disconnection", function(conn)
  end)
end


-- timer para atualizar a lista de comandos a cada 5s
tmr.alarm(0, 5000, 1, function() sendData() end )
