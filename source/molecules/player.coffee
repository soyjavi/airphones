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

  @events: ["play", "pause", "end"]

  @default:
    children: [
      "Atom.Audio":
        id       : "audio"
        preload  : true
        events   : ["load", "error", "downloading", "play", "timing", "pause", "stop", "end"]
    ,
      "Atom.Figure": id: "figure",  url: "http://2.bp.blogspot.com/-kKxIdYfgMv0/TV97Glu1stI/AAAAAAAABKU/7a8eIhrL0t8/s1600/Bob_Dylan_-_The_Times_They_are_a-Changin.jpg"
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
          "Atom.Button": icon: ICON.PAUSE, callbacks: ["onPlay"]
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
      # @figure.url = "http://2.bp.blogspot.com/-kKxIdYfgMv0/TV97Glu1stI/AAAAAAAABKU/7a8eIhrL0t8/s1600/Bob_Dylan_-_The_Times_They_are_a-Changin.jpg"
      @progress.value 0.00
      @audio.src "#{Appnima.host.storage}/stream/#{file.id}"
      @title.el.html file.name
      @artist.el.html "Unknown..."
      @options.children[0].attributes.icon = ICON.PAUSE
      @options.children[0].refresh()
    else
      do @__autoHide

    console.log file.updateAttributes name: new Date()
    @el.addClass "active"

  hide: ->
    @el.removeClass "active"
    do @__autoHide

  # Children Events
  onAudioLoad: (event) ->
    @progress.value 0.00
    @audio.play()
    @audio.volume 50.00
    __.Article.Main.emiter?.send
      action: "src"
      src   : "#{Appnima.host.storage}/stream/#{@file.id}"

  onAudioTiming: (event) ->
    @progress.value (@audio.time() * 100) / @audio.duration()

  onAudioPause: (event) ->
    console.log "onAudioPause"
    __.Article.Main.emiter?.send
      action: "pause"
      time  : @audio.time()

  onAudioPlay: (event) ->
    console.log "onAudioPlay"
    __.Article.Main.emiter?.send
      action: "play"
      time  : @audio.time()

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

  # Private
  __autoHide: ->
    setTimeout (=> @hide()) , 5000
