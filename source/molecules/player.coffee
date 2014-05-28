"use strict"

ICON =
  PLAY    : "ios7-play-outline"
  PAUSE   : "ios7-pause-outline"
  PREVIOUS: "ios7-skipbackward-outline"
  NEXT    : "ios7-skipforward-outline"


class Atoms.Molecule.Player extends Atoms.Molecule.Navigation

  @extends  : true

  @template : "<div></div>"

  @available: ["Atom.Audio", "Atom.Heading", "Atom.Figure", "Atom.Label", "Atom.Progress", "Molecule.Navigation"]
  # @base     : "Player"

  @events: ["play", "pause", "end"]

  @default:
    children: [
      "Atom.Audio":
        id       : "audio"
        preload  : true
        events   : ["load", "error", "downloading", "play", "timing", "pause", "stop", "end"]
    ,
      "Atom.Figure": id: "figure"
    ,
      "Atom.Heading": id: "title"
    ,
      "Atom.Label": id: "artist"
    ,
      "Atom.Progress": id: "progress"
    ,
      "Molecule.Navigation":
        id: "options"
        children: [
          "Atom.Button": icon: ICON.PREVIOUS, callbacks: ["onPrevious"]
        ,
          "Atom.Button": icon: ICON.PAUSE, callbacks: ["onPlay"]
        ,
          "Atom.Button": icon: ICON.NEXT, callbacks: ["onNext"]
        ]
    ]


  load: (file) ->
    if file.id isnt @file?.id
      if @file
        @file.icon = null
        @file.save()
      # @file.updateAttributes icon: null if @file
      @file = file.updateAttributes icon: "http://"

      file.save()

      # @figure.url = "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fts2.mm.bing.net%2Fth%3Fid%3DHN.608042548929695561%26pid%3D15.1&f=1"
      @audio.src "http://api.appnima.com/storage/stream/#{file.id}"
      @title.el.html file.name
      @artist.el.html "Unknown..."
      @options.children[0].attributes.icon = ICON.PAUSE
      @options.children[0].refresh()

    console.log file.updateAttributes name: new Date()
    @el.addClass "active"

  test: (file) ->
    @audio.src file.url
    @title.el.html file.name
    @artist.el.html "Unknown..."
    @options.children[0].attributes.icon = ICON.PAUSE
    @options.children[0].refresh()
    @el.addClass "active"


  hide: ->
    @el.removeClass "active"

  # Children Events
  onAudioLoad: (event) ->
    @progress.value 0.00
    @audio.play()
    @audio.volume 0
    # setTimeout =>
    #   @hide()
    # , 5000

  onAudioTiming: (event) ->
    @progress.value (@audio.time() * 100) / @audio.duration()

  onAudioPause: (event) ->
    console.log "onAudioPause"

  onAudioPlay: (event) ->
    console.log "onAudioPlay"

  onAudioEnd: (event) ->
    console.log "onAudioEnd"
    @bubble "end", event

  onPlay: (event, atom) ->
    if atom.attributes.icon is ICON.PLAY
      atom.attributes.icon = ICON.PAUSE
      @audio.play()
    else
      atom.attributes.icon = ICON.PLAY
      @audio.pause()

    atom.refresh()

  onPause: ->
    console.log "onPause"
    @audio.pause()
