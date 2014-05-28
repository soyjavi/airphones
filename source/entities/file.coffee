"use strict"

class Atoms.Entity.File extends Atoms.Class.Entity

  @fields "id", "name", "owner", "path", "size", "type", "created_at",
          "icon"

  parse: ->
    image       : @icon
    info        : "0:00"
    text        : @name
    description : "Unknown artist"
