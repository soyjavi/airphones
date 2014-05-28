class Atoms.Organism.Playlist extends Atoms.Organism.Article

  @scaffold "assets/scaffold/playlist.json"

  @listener = null

  constructor: ->
    super
    do @render

  # Instance methods
  connectToUser: (entity) ->
    console.log entity
    # @header.title.el.html entity.username
    Atoms.Url.path "playlist/user"

    @listener = new Appnima.Socket.Listener entity.id
    @listener.onConnect (event) =>
      console.log "@listener.onConnect", event
    @listener.onDisconnect (event) =>
      console.log "@listener.onDisconnect", event
    @listener.onError (event) ->
      console.log "@listener.onError", event
    @listener.onMessage (message) =>
      console.log "@listener.onMessage", message, message.content, message.created_at
      action = message?.content?.action
      if action is "src"
        @user.airphones.src message.content.src
      if action is "play"
        @user.airphones.play()
        @user.airphones.time message.content.time
      if action is "pause"
        @user.airphones.pause()
        @user.airphones.time message.content.time


  # Children Events
  onBack: (event) ->
    @listener.disconnect?()
    Atoms.Url.back()
    false

  onAudioLoad: (event) ->
    console.log "onAudioLoad"
    # @progress.value 0.00
    # @user.earphones.play()
    # @user.earphones.volume 50.00
    # __.Article.Main.emiter?.send
    #   action: "src"
    #   src   : "#{Appnima.host.storage}/stream/#{@file.id}"

  onAudioTiming: (event) ->
    console.log @user.time.progress
    # @user.time.progress.value (@user.earphones.time() * 100) / @user.earphones.duration()

new Atoms.Organism.Playlist()
