class Atoms.Organism.Session extends Atoms.Organism.Article

  @scaffold "assets/scaffold/session.json"

  STORAGE_KEY = "airphones"

  constructor: ->
    super
    Appnima.key = "NTM3YzRmNGVhMjYxYjVlNDU3MjkwMDVjOjJVOTBFek9aMXZYdnN4VURQdjNLMWFRRmI2UVl4Rkk="

   # Children Bubble Events
  onLogin: (event, dispatcher, hierarchy...) ->
    console.log "onLogin", arguments

  onSignup: (event, dispatcher, hierarchy...) ->
    console.log "onSignup", arguments

  onError: (event, dispatcher, hierarchy...) ->
    console.log "onError", arguments

new Atoms.Organism.Session()
