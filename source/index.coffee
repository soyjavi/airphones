Atoms.$ ->

  Appnima.host.socket = "http://socket.appnima.com:3000"

  session = Appnima.User.session()
  if session
    __.Article.Main.fetchLibrary()
    Atoms.Url.path "main/library"
  else
    Atoms.Url.path "session/appnima"


window.Airphones = do ->


  _proxy = (type, method, parameters = {}, background = false) ->
    promise = new Hope.Promise()
    unless background then do __.Modal.Loading.show

    token = Appnima.token or null

    $$.ajax
      url         : "http://#{method}"
      type        : type
      data        : parameters
      contentType : "application/x-www-form-urlencoded"
      dataType    : 'json'
      headers     : "Authorization": token
      success: (response, xhr) ->
        unless background then do __.Modal.Loading.hide
        promise.done null, response
      error: (xhr, error) =>
        unless background then do __.Modal.Loading.hide
        error = code: error.status, message: error.response
        console.error "Atoms.Ide.proxy [ERROR #{error.code}]: #{error.message}"
        promise.done error, null
    promise

  proxy     : _proxy
