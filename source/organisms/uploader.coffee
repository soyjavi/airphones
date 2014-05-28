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
          percent = progress.position / progress.total * 100
          console.error progress, percent
          console.log @header.progress
          @header.progress.value percent
        error: ->
          alert "upload error!!"
        abort: ->
          alert "upload aborted"

      console.log file_url
      @el.addClass "uploading"
      Appnima.Storage.upload(file_url, "/", callbacks).then (error, result) ->
        console.log "storage/upload", error, result
        @el.removeClass "uploading"
        @hide()
    false


new Atoms.Organism.Uploader()
