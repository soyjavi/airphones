class Atoms.Organism.Main extends Atoms.Organism.Article

  @scaffold "assets/scaffold/main.json"

  @emiter = null

  # Instance methods
  init: (@session) ->
    __.Modal.Loading.show()
    Atoms.Entity.File.destroyAll()
    @emiter = new Appnima.Socket.Emiter @session.id
    @emiter.onConnect (event) =>
      do @fetch
      Atoms.Url.path "main/library"
    @emiter.onError (event) ->
      console.log "emiter.onError"

  fetch: ->
    Appnima.Network.following().then (error, result) =>
      Atoms.Entity.Friend.create profile for profile in result.profiles
      @following = Atoms.Entity.Friend.all()
    Appnima.Storage.dir("/").then (error, result) ->
      Atoms.Entity.File.destroyAll()
      Atoms.Entity.File.create file for file in result.files or []
      __.Modal.Loading.hide()


  # Children bubble events
  onSectionShow: (section) ->
    @current_section = section.attributes.id

  onUploadFile: (event, dispatcher, hierarchy...) ->
    __.Modal.Uploader.show()

  onFileSelect: (atom) ->
    @player.load atom.entity

  onFriendSelect: (atom) ->
    __.Article.Playlist.connectToUser atom.entity
    # Appnima.Network.follow(atom.entity.id).then (error, result) ->
    #   console.log "Appnima.Network.follow", error, result

  onSearchSubmit: (event, search) ->
    Atoms.Entity.Friend.destroyAll()
    Appnima.Network.search(search.value()).then (error, response) ->
      unless error
        Atoms.Entity.Friend.create user for user in response.users

new Atoms.Organism.Main()
