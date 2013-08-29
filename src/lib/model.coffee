###!
@author Branko Vukelic <branko@brankovukelic.com>
@license MIT
###

# # Generic SOAP client model
#
# This model hooks the model layer to SOAP service in a generic way. It cannot
# be used as is, since using a SOAP service requires parsing the response.
#
# This model is in UMD format, and will create a `ribcageSoap.Model` global if
# not used with an AMD loader such as RequireJS.

if typeof define isnt 'function' or not define.amd
  @require = (dep) =>
    (() =>
      switch dep
        when 'ribcage' then @ribcage
        when './mixin' then @ribcageSoap.mixin
        else null
    )() or throw new Error "Unmet dependency #{dep}"
  @define = (factory) =>
    @ribcageSoap.Model = factory @require

define (require) ->
  ribcage = require 'ribcage'
  soapMixin = require './mixin'

  # ## `SoapModel`
  #
  # Please see the documentation on `soapMixin` for more information on the API
  # for this model.
  SoapModel = ribcage.models.BaseModel.extend soapMixin

  # Add mixin and model to ribcage object
  ribcage.modelMixins.SoapModel = soapMixin
  ribcage.models.SoapModel = SoapModel
