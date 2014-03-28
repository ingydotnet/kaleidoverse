window.Kaleidoverse = class Kaleidoverse
  constructor: ->
    window.say = console.log
    $.cookie.json = true
    @github_owner = 'veradox'
    @github_repo = 'kaleidoverse'
    @state = $.cookie 'state'

  run: ->
    if @state
      @display 'main',
        'state': @state
      @github = new Github
        token: @state.token
        auth: "oauth"
    else
      @display 'login'

  display: (view, data)->
    $('.primary-content').html Jemplate.process "#{view}.html", data

  lightbox: (view)->
    $.colorbox
      html: Jemplate.process "#{view}.html"
      height: '50%'
      width: '50%'
      closeButton: false


  do_token_login: ->
    @clear()
    login = $("input[name$='login']").val() || ''
    token = $("input[name$='token']").val() || ''
    @error "GitHub Login Id value is required" unless login.length > 0
    @error "GitHub Auth Token value is required" unless token.match /^\S{40}$/
    if @errors
      $("button[name$='login']").click @do_token_login
    else
      $.colorbox.close()
      state =
        token: token
        login: login
      $.cookie 'state', state,
        path: '/'


  do_logout: ->
    $.removeCookie 'state',
      path: '/'
    @state = $.cookie 'state'
    @run()

  do_fork: ->
    @repo = @github.getRepo @github_owner @github_repo
    @repo.fork (err)->
      if err
        say err
      else
        alert "You Forked Me!"

  clear: ->
    $('.errors').html ''
    @errors = false

  error: (message)->
    $('.errors').append "<p>Error: #{message}</p>"
    @errors = true

window.kaleidoverse = ->
  window.ko = new Kaleidoverse
  ko.run()

# vim: set sw=2 lisp:
