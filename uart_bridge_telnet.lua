--telnet.lua
s=net.createServer(net.TCP,1000)
s:listen(23,function(c)
function s_output(str)
if(c~=nil)
then c:send(str)
end
end
node.output(s_output, 0)
c:on("receive",function(c,l)
node.input(l)
end)
c:on("disconnection",function(c)
node.output(nil)
end)
print("Telnet V1.1")
end)
