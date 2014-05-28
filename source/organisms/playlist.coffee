class Atoms.Organism.Playlist extends Atoms.Organism.Article

  @scaffold "assets/scaffold/playlist.json"

  @listener = null

  constructor: ->
    super
    do @render

  # Instance methods
  connectToUser: (entity) ->
    console.log entity
    @header.title.el.html entity.username
    Atoms.Url.path "playlist/user"

    @listener = new Appnima.Socket.Listener entity.id
    @listener.onConnect (event) =>
      console.log "@listener.onConnect", event
    @listener.onDisconnect (event) =>
      console.log "@listener.onDisconnect", event
    @listener.onError (event) ->
      console.log "@listener.onError", event
    @listener.onMessage (message) =>
      action = message?.content?.action
      if action is "load"
        @file = message.content.file
        @user.airphones.src "#{Appnima.host.storage}/stream/#{@file.id}"
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

  onFormChange: (event, form) ->
    console.log form.value()

  onAudioLoad: (event) ->
    console.log "onAudioLoad"
    @user.time.progress.value 0.00
    @user.airphones.play()
    @user.airphones.volume 0.00

  onAudioTiming: (event) ->
    @user.time.progress.value (@user.airphones.time() * 100) / @user.airphones.duration()

new Atoms.Organism.Playlist()
