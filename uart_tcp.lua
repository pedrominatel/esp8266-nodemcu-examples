-- Create UART <-> TCP Server
s=net.createServer(net.TCP,180)
s:listen(telnetport,function(c)
function s_output(str)
  if(c~=nil) then c:send(str) end
end
uart.on("data",s_output,0)
c:on("receive",function(c,l)
  uart.write(0,l)
  end)
end)
