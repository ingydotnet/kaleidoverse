window.Kaleidoverse = class Kaleidoverse
  constructor: ->
    window.say = console.log
    $.cookie.json = true
    @github_owner = 'veradox'
    @github_repo = 'kaleidoverse'

  run: ->
    @state = $.cookie 'state'
    if @state
      @display 'main'
      @github = new Github
        token: @state.token
        auth: "oauth"
    else
      @display 'login'

  display: (view)->
    $('.primary-content').html Jemplate.process "#{view}.html", @state

  lightbox: (view)->
    $.colorbox
      html: Jemplate.process "#{view}.html", @state
      height: '50%'
      width: '50%'
      closeButton: false

  do_token_login: ->
    @clear_errors()
    login = $("input[name$='login']").val() || ''
    token = $("input[name$='token']").val() || ''
    @error "GitHub Login Id value is required" unless login.length > 0
    @error "GitHub Auth Token value is required" unless token.length > 0
    if @errors
      $("button[name$='login']").click @do_token_login
    else
      $.colorbox.close()
      state =
        token: token
        login: login
      $.cookie 'state', state,
        path: '/'
      @run()

  do_logout: ->
    $.removeCookie 'state',
      path: '/'
    @run()

  do_fork: ->
    @repo = @github.getRepo @github_owner @github_repo
    @repo.fork (err)->
      if err
        say err
      else
        alert "You Forked Me!"

  clear_errors: ->
    $('.errors').html ''
    @errors = false

  error: (message)->
    $('.errors').append "<p>Error: #{message}</p>"
    @errors = true

window.kaleidoverse = ->
  window.ko = new Kaleidoverse
  ko.run()

# vim: set sw=2 lisp:
