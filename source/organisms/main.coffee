class Atoms.Organism.Main extends Atoms.Organism.Article

  @scaffold "assets/scaffold/main.json"

  render: ->
    super
    console.log Appnima.token

  # Instance methods
  fetchLibrary: ->
    Atoms.Entity.File.destroyAll()
    @player.test
      url: "http://designmodo.com/demo/audioplayer/media/demo.mp3"
      name: "Test song"


    Appnima.Storage.dir("/").then (error, result) ->
      Atoms.Entity.File.create file for file in result.files or []

  # Children bubble events
  onUploadFile: (event, dispatcher, hierarchy...) ->
    # Your code...

  onFile: (atom) ->
    @player.load atom.entity

new Atoms.Organism.Main()
