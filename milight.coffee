# #Plugin template

# This is an plugin template and mini tutorial for creating pimatic plugins. It will explain the 
# basics of how the plugin system works and how a plugin should look like.

# ##The plugin code

# Your plugin must export a single function, that takes one argument and returns a instance of
# your plugin class. The parameter is an envirement object containing all pimatic related functions
# and classes. See the [startup.coffee](http://sweetpi.de/pimatic/docs/startup.html) for details.
module.exports = (env) ->

  # ###require modules included in pimatic
  # To require modules that are included in pimatic use `env.require`. For available packages take 
  # a look at the dependencies section in pimatics package.json

  # Require the  bluebird promise library
  Promise = env.require 'bluebird'

  # Require the [cassert library](https://github.com/rhoot/cassert).
  assert = env.require 'cassert'

  MilightLib = require 'milight'

  # Include you own depencies with nodes global require function:
  #  
  #     someThing = require 'someThing'
  #  

  # ###MilightPlugin class
  # Create a class that extends the Plugin class and implements the following functions:
  class MilightPlugin extends env.plugins.Plugin

    # ####init()
    # The `init` function is called by the framework to ask your plugin to initialise.
    #  
    # #####params:
    #  * `app` is the [express] instance the framework is using.
    #  * `framework` the framework itself
    #  * `config` the properties the user specified as config for your plugin in the `plugins` 
    #     section of the config.json file 
    #     
    # 
    init: (app, @framework, @config) =>
      env.logger.info("Milight plugin started")

      deviceConfigDef = require("./device-config-schema")

      @framework.deviceManager.registerDeviceClass("MilightRGBWZone", {
        configDef: deviceConfigDef.MilightRGBWZone, 
        createCallback: (config) => new MilightRGBWZone(config)
      })

  class MilightRGBWZone extends env.devices.DimmerActuator

    constructor: (@config) ->
      @name = @config.name
      @id = @config.id
      @ip = @config.ip
      @port = @config.port
      @zoneId = @config.zoneId
      milightLib = new MilightLib
        host: @ip
        port: @port
      @currZone = milightLib.zone @zoneId

      super()

    changeDimlevelTo: (dimlevel) ->
      # change dim
      if dimlevel > 0
        @currZone.brightness dimlevel, (err) -> 
          env.logger.debug "set dim to #{dimlevel}"
      else
        @currZone.off (err) ->
          env.logger.debug "turned off"

#    turnOn: -> @currZone.on

#    turnOff: -> @currZone.off

    changeStateTo: (state) ->
      if state
        @currZone.on
      else
        @currZone.off

  # ###Finally
  # Create a instance of my plugin
  milightPlugin = new MilightPlugin
  # and return it to the framework.
  return milightPlugin