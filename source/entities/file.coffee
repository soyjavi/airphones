"use strict"

class Atoms.Entity.File extends Atoms.Class.Entity

  @fields "id", "name", "owner", "path", "size", "type", "metadata", "created_at",
          "icon"

  parse: ->
    image       : "http://"
    info        : "0:00"
    text        : @metadata?.title or @name
    description : @metadata?.artist?[0] or "Unknown artist"
