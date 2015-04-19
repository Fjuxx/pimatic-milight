testmilight = require 'milight'

@light = new testmilight
	host: "192.168.178.221"
	port: 8899

console.log @light
@zone1 = @light.zone 1
console.log @zone1
@zone1.off (err) ->
	console.log 'hoi'
	console.log err