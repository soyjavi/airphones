"use strict"

class Atoms.Entity.Friend extends Atoms.Class.Entity

  @fields "id", "username", "name", "mail", "avatar"

  parse: ->
    style       : "online"
    image       : @avatar
    text        : @username
    description : @name
