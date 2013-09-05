###!
@author Branko Vukelic <branko@brankovukelic.com>
@license MIT
###

# # Soap mixin
#
# This module implements a generic model/collection mixin which overrides the
# `#sync()` method to provide SOAP capability.
#
# With customization, you can perform an infinite number of different SOAP
# requests depending on the circumstances, so you are not limited to a
# one-to-one mapping between CRUD and SOAP methods.
#
# The actual SOAP requests are made by jquery.soap plugin which is required
# for this model to function correctly. If you keep the default
# implementation, all response data is converted to JSON by jquery.xml2json
# plugin.
#
# This module is in UMD format and creates `ribcageSoap.mixin` global if
# not used with an AMD loader such as RequireJS.

if typeof define isnt 'function' or not define.amd
  @require = (dep) =>
    (() =>
      switch dep
        when 'jquery' then @jQuery
        when 'underscore' then @_
        when 'jquery.soap' then @jQuery.soap
        when 'jquery.xml2json' then @jQuery.xml2json
        else null
    )() or throw new Error "Unmet dependency #{dep}"
  @define = (factory) =>
    @ribcageSoap.mixin = factory @require

# This module depends on jQuery, Underscore, and jQuery.soap and
# jQuery.xml2json plugins.
define (require) ->
  $ = require 'jquery'
  _ = require 'underscore'
  require 'jquery.soap'
  require 'jquery.xml2json'

  # ## `baseUrl`
  #
  # You must override this property to set the base URL of the SOAP
  # endpoints. You can also override the property right on the model's
  # prototype to have to changed globally for all your SOAP models.
  #
  # By default, it's 'http://example.com'.
  baseUrl: 'http://example.com'

  # ## `namespace`
  #
  # Change this property to set the napespace for your SOAP requests. Again,
  # you can change this on the model's prototype if needed.
  #
  # By default, it's 'http://example.com'.
  namespace: 'http://example.com'

  # ## `debug`
  #
  # Whether to log request information. This value is relayed to jquery.soap
  # as is.
  #
  # Default is `false`.
  debug: false

  # ## `appendMethod`
  #
  # Whether to build the URL of an endpoint by appending the SOAP method name
  # to the base URL. This value is relayed to jquery.soap as is.
  #
  # Default is `false`.
  appendMethod: false

  # ## `soap12`
  #
  # Whether to use SOAP v1.2. This setting is relayed to jquery.soap as is.
  #
  # Default is `false`.
  soap12: false

  # ## `soapCreateMethod`
  #
  # A string property that represents the method name for the model's create
  # method.
  #
  # By default, it's 'Create'.
  soapCreateMethod: 'Create'

  # ## `soapReadMethod`
  #
  # A string property that represents the method name for the model's read
  # method.
  #
  # By default, it's 'Read'
  soapReadMethod: 'Read'

  # ## `soapUpdateMethod`
  #
  # A string property that represents the method name for the model's update
  # method.
  #
  # By default, it's 'Update'
  soapUpdateMethod: 'Update'

  # ## `soapDeleteMethod`
  #
  # A string property that represents the method name for the model's delete
  # method.
  #
  # By default, it's 'Delete'
  soapDeleteMethod: 'Delete'

  # ## `getSoapCreateMethod()`
  #
  # This method returns the name of the SOAP method used for model's create
  # method.
  #
  # Overload if you wish to set the method name at runtime
  getSoapCreateMethod: () ->
    @soapCreateMethod

  # ## `getSoapReadMethod()`
  #
  # This method returns the name of the SOAP method used for model's read
  # method.
  #
  # Overload if you wish to set the method name at runtime
  getSoapReadMethod: () ->
    @soapReadMethod

  # ## `getSoapUpdateMethod()`
  #
  # This method returns the name of the SOAP method used for model's update
  # method.
  #
  # Overload if you wish to set the method name at runtime
  getSoapUpdateMethod: () ->
    @soapUpdateMethod

  # ## `getSoapDeleteMethod()`
  #
  # This method returns the name of the SOAP method used for model's delete
  # method.
  #
  # Overload if you wish to set the method name at runtime
  getSoapDeleteMethod: () ->
    @soapDeleteMethod

  # ## `soapCreateTemplate(data)`
  #
  # The template used for model's create method.
  #
  # This property should be a function that accepts the model data as an
  # object, and returns either an object, or a string that will be used as
  # `param` argument in the jquery.soap call.
  #
  # By default, this property is `null`, and that will trigger an exception
  # during `#sync()` call.
  soapCreateTemplate: null

  # ## `soapReadTemplate(data)`
  #
  # The template used for model's read method.
  #
  # This property should be a function that accepts the model data as an
  # object, and returns either an object, or a string that will be used as
  # `param` argument in the jquery.soap call.
  #
  # By default, this property is `null`, and that will trigger an exception
  # during `#sync()` call.
  soapReadTemplate: null

  # ## `soapUpdateTemplate(data)`
  #
  # The template used for model's update method.
  #
  # This property should be a function that accepts the model data as an
  # object, and returns either an object, or a string that will be used as
  # `param` argument in the jquery.soap call.
  #
  # By default, this property is `null`, and that will trigger an exception
  # during `#sync()` call.
  soapUpdateTemplate: null

  # ## `soapDeleteTemplate(data)`
  #
  # The template used for model's delete method.
  #
  # This property should be a function that accepts the model data as an
  # object, and returns either an object, or a string that will be used as
  # `param` argument in the jquery.soap call.
  #
  # By default, this property is `null`, and that will trigger an exception
  # during `#sync()` call.
  soapDeleteTemplate: null

  # ## `soapCreate(model)`
  #
  # Prepares jquery.soap settings for model's create method. The default
  # implementation calls the `#getSoapCreateMethod()` and
  # `#soapCreateTemplate()`, adding them to return value's `method` and
  # `params` keys respectively.
  #
  # If the `model` argument is not passed, it will use `this`.
  soapCreate: (model=null) ->
    method: @getSoapCreateMethod()
    params: @soapCreateTemplate (model or this).toJSON()

  # ## `soapRead(model)`
  #
  # Prepares jquery.soap settings for model's read method. The default
  # implementation calls the `#getSoapReadMethod()` and
  # `#soapReadTemplate()`, adding them to return value's `method` and
  # `params` keys respectively.
  #
  # If the `model` argument is not passed, it will use `this`.
  soapRead: (model=null) ->
    method: @getSoapReadMethod()
    params: @soapReadTemplate (model or this).toJSON()

  # ## `soapUpdate(model)`
  #
  # Prepares jquery.soap settings for model's update method. The default
  # implementation calls the `#getSoapUpdateMethod()` and
  # `#soapUpdateTemplate()`, adding them to return value's `method` and
  # `params` keys respectively.
  #
  # If the `model` argument is not passed, it will use `this`.
  soapUpdate: (model=null) ->
    method: @getSoapUpdateMethod()
    params: @soapUpdateTemplate (model or this).toJSON()

  # ## `soapDelete(model)`
  #
  # Prepares jquery.soap settings for model's delete method. The default
  # implementation calls the `#getSoapDeleteMethod()` and
  # `#soapDeleteTemplate()`, adding them to return value's `method` and
  # `params` keys respectively.
  #
  # If the `model` argument is not passed, it will use `this`.
  soapDelete: (model=null) ->
    method: @getSoapDeleteMethod()
    params: @soapDeleteTemplate (model or this).toJSON()

  # ## `getUrl(method, action)`
  #
  # Returns the full URL of the SOAP request. Note that this URL is used as
  # the base when `#appendMethod` is set to `true`, so there is no need to
  # append the method to the URL here if you wish to use that option.
  #
  # The default implementation returns the value of the `#baseUrl` property.
  getUrl: (method, action) ->
    @baseUrl

  # ## `getSoapActionName(method, soapMethod)`
  #
  # Returns the action name used in 'SOAPAction' HTTP header.
  #
  # The `method` argument is the model's CRUD method name, and the
  # `soapMethod` is the SOAP method name.
  #
  # Default implementation returns the concatenation of `#namespace` and
  # `soapMethod`.
  getSoapActionName: (method, soapMethod) ->
    "#{@namespace}#{soapMethod}"

  # ## `sync(method, model, [options])`
  #
  # Performs the soap call using jquery.soap. You generally shouldn't need to
  # override this method.
  sync: (method, model, options={}) ->
    # Capitalized method name
    capMethod = "#{method[0].toUpperCase()}#{method.slice 1}"

    # Add the method to options so it can be relayed to `#parse()`
    options.crudMethod = capMethod

    # Alias the method
    fn = this["soap#{capMethod}"]

    # Prepare parameters by calling the request handler
    params = fn.call this, model # use .call since it's a dangling method

    # Send out the request using jquery.soap
    $.soap _.extend params, options, {
      enableLogging: @debug
      url: @getUrl(method, params.method)
      appendMethodToURL: @appendMethod
      namespaceURL: @namespace
      SOAPAction: @getSoapActionName(method, params.method)
      soap12: @soap12
    }

  # ## `convertCreateResponse(json)`
  #
  # Process the response JSON data and return an object. The return value is
  # returned untouched by the `#parse()` method.
  #
  # Default implementation simply throws an exception. You must override this
  # method, or `#convertResponse()`, or `#parse()` method.
  convertCreateResponse: (json) ->
    throw new Error 'convertCreateResponse method is not implemented'

  # ## `convertReadResponse(json)`
  #
  # Process the response JSON data and return an object. The return value is
  # returned untouched by the `#parse()` method.
  #
  # Default implementation simply throws an exception. You must override this
  # method, or `#convertResponse()`, or `#parse()` method.
  convertReadResponse: (json) ->
    throw new Error 'convertReadResponse method is not implemented'

  # ## `convertUpdateResponse(json)`
  #
  # Process the response JSON data and return an object. The return value is
  # returned untouched by the `#parse()` method.
  #
  # Default implementation simply throws an exception. You must override this
  # method, or `#convertResponse()`, or `#parse()` method.
  convertUpdateResponse: (json) ->
    throw new Error 'convertUpdateResponse method is not implemented'

  # ## `convertDeleteResponse(json)`
  #
  # Process the response JSON data and return an object. The return value is
  # returned untouched by the `#parse()` method.
  #
  # Default implementation simply throws an exception. You must override this
  # method, or `#convertResponse()`, or `#parse()` method.
  convertDeleteResponse: (json) ->
    throw new Error 'convertDeleteResponse method is not implemented'

  # ## `isDeleted(model)`
  #
  # Rads the modle properties and returns `true` if the model can be considered
  # deleted.
  #
  # This method is called in a success callback during SOAP request. Because
  # SOAP is an RPC, a successful AJAX request does not equate successful
  # deletion of a model. Therefore, this method can be overloaded to check the
  # model data after deletion.
  #
  # You can set metadata that help you determine the status of the model using
  # the `#convertDeleteResponse()` call.
  #
  # Returning `false` from this method will prevent the triggering of 'destroy'
  # event on the model, and will cause the success callback to not be called.
  isDeleted: (model) ->
    return true

  # ## convertResponse(json, options)`
  #
  # This gets passed JSON data created in the `#parse()` method. The return
  # value of this method is returned from `#parse()` directly. If you are not
  # happy with JSON, consider overriding the `#parse()` method instead.
  #
  # The `options` argument contains the options originally passed to `sync`.
  # Note that the name of the method is added to the original request options
  # as `crudMethod` key, should you need to access it to change the way your
  # data is converted.
  #
  # By default, this method will delegate to one of the `#convertXResponse()`
  # methods depending on the CRUD method.
  convertResponse: (json, options) ->
    this["convert#{options.crudMethod}Response"](json)

  # ## `parse(response, options)`
  #
  # The `#parse()` method is overridden to convert the response to JSON and
  # pass its `Body` property to the `#convertResponse()` method. You you want
  # to change the way response is converted to an object, you should override
  # this method.
  parse: (response, options) ->
    @convertResponse response.toJSON().Body, options

  # ## `destroy([options])`
  #
  # Rewires `#destroy()` call to behave more like `#fetch()`.
  destroy: (options={}) ->
    options = _.clone options  # shallow copy
    options.parse or= true

    options.deleted or= @isDeleted

    # Wrap the success callback
    success = options.success
    options.success = (resp) =>
      return false if not options.deleted @set @parse(resp, options), options
      success(this, resp, options) if success
      this.trigger 'destroy', this, @collection, options

    # Wrap the error callback
    error = options.error
    options.error = (resp) =>
      error(this, resp, options) if error
      this.trigger 'error', this, resp, options

    @sync 'delete', this, options
