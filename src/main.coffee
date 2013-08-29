# # Ribcage-SOAP main module
#
# This module provides access to all three Ribcage-SOAP modules.
#
# This module serves as a namespace creator when not used with an AMD loader.
# Please make sure it is loaded before other modules.

if typeof define isnt 'function' and not define.amd
  @define = () ->
    @ribcageSoap or= {}

define (require) ->
  soapMixin = require './lib/mixin'
  SoapModel = require './lib/model'
  SoapCollection = require './lib/collection'

  mixin: soapMixin
  Model: SoapModel
  Collection: SoapCollection
