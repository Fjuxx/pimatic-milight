pimatic-milgiht
=======================
This is a plugin for the Migliht 4 zone wifi controller

###Adding plugin

```json
{
	"plugin" : "milight"
}
```

###Adding Device (1 zone)

```json
{
	"id": "milightzone1",
    "class": "MilightRGBWZone",
    "name": "Milight Zone 1",
    "ip": "192.168.1.xxx",
    "port": 8899,
    "zoneId": 1
}
```
ip: the IP/HOST of the wifi box. Reccommended to set static.
port: port on the Wifi box. (default 8899, or older: 5000)
zoneId: 1 - 4 (for the zone)

###To be tested
- Multiple wifi boxes.
- broadcast
- zone 0 (all)

####TODO:
- Add color wheel
- hold last data
- switch auto between color and white
- Broadcast support

###Idea's

if you have any idea's for this plugin please let me know!