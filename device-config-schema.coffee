module.exports = {
  title: "Milight device config schemas"
  MilightRGBWZone: {
    title: "Milight RGBW config"
    type: "object"
    properties:
      ip: 
        description: "Show the mode buttons in the gui"
        type: "string"
        default: "255.255.255.255"
      port:
        description: "Show the preset temperatures in the gui"
        type: "number"
        default: 8899
      zoneId:
        description: "Show the temperature input spinbox in the gui"
        type: "number"
        default: 1   
  }
}