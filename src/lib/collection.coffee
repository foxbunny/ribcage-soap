###!
@author Branko Vukelic <branko@brankovukelic.com>
@license MIT
###

# # Soap collection
#
# This module implements a soap-based collection. Since making Soap requests
# per model can be expensive in some cases, this collection will make a SOAP
# request and instantiate appropriate models.
#
# This module is in UMD format and will export `ribcgeSoap.Collection` global
# if not used with an AMD loader such as RequireJS.

if typeof define isnt 'function' or not define.amd
  @require = (dep) =>
    (() =>
      switch dep
        when 'ribcage' then @Ribcage
        when './mixin' then @ribcageSoap.mixin
        else null
    )() or throw new Error "Unmet dependency #{dep}"
  @define = (factory) =>
    @ribcageSoap.Collection = factory @require

# This module depends on `ribcage-soap.mixin` module and Ribcage

define (require) ->
  ribcage = require 'ribcage'
  soapMixin = require './mixin'

  # ## `SoapCollection`
  #
  # Please see the documentation on `soapMixin` for more information on the API
  # for this collection.
  SoapCollection = ribcage.collections.BaseCollection.extend soapMixin

  # Add the mixin and collection to ribcage object
  ribcage.collectionMixins.SoapCollection = soapMixin
  ribcage.collections.SoapCollection = SoapCollection
