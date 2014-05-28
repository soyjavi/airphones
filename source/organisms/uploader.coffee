"use strict"

class Atoms.Organism.Uploader extends Atoms.Organism.Modal

  @scaffold "assets/scaffold/uploader.json"

  @extends : true

  # Instance events
  show: ->
    super
    @header.progress.value 0.00
    @el.removeClass "uploading"

  # Children Events
  onUpload: (event, atom) ->
    console.log "onUpload"
    @section.form.file.el.trigger "click"

  onCancel: ->
    @hide()
    false

  onFileChange: (event) ->
    event.stopPropagation()
    event.preventDefault()

    file_url = event.target.files[0]
    if file_url?.type?.match /audio.*/
      callbacks =
        progress: (progress) =>
          @header.progress.value progress.position / progress.total * 100
        error: =>
          alert "upload error!!"
        abort: =>
          alert "upload aborted"

      @el.addClass "uploading"
      Appnima.Storage.upload(file_url, "/", callbacks).then (error, file) =>
        Atoms.Entity.File.create file unless error
        @el.removeClass "uploading"
        @hide()
    false


new Atoms.Organism.Uploader()
