-- jammer

term.clear()
term.setCursorPos(1,2)
term.write("Scanning 1- for open frequencies...")

sides = {'front','back','left','right','top','bottom'}

for i=1,#sides do
	if (peripheral.getType(sides[i]) == "modem" and peripheral.call(sides[i], 'isWireless')) do
		modem = peripheral.wrap(sides[i])
		break
	end
end

function signalJam() do
	for i=1,65535 do
		modem.open(i)
		modem.transmit(i,i,"-Static-")
		modem.close(i)
	end
end

if (modem) do
	while true do
		signalJam()
		sleep(10)
	end
else do
	term.write("No wireless modem found... Exiting.")
end
