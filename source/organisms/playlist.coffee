class Atoms.Organism.Playlist extends Atoms.Organism.Article

  @scaffold "assets/scaffold/playlist.json"

  @listener = null

  # Instance methods
  user: (entity) ->
    do @render unless @el
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
      console.log "@listener.onMessage", message, message.content, message.created_at
      # if message.content.action is "src"
      #   @test.earphones.src message.content.src
      # if message.content.action is "play"
      #   @test.earphones.play()
      #   @test.earphones.time message.content.time
      # if message.content.action is "pause"
      #   @test.earphones.pause()
      #   @test.earphones.time message.content.time


  # Children Events
  onBack: (event) ->
    @listener.disconnect?()
    Atoms.Url.back()
    false

new Atoms.Organism.Playlist()
