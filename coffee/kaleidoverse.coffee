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
    @colorbox = $.colorbox
      html: Jemplate.process "#{view}.html"
      height: '50%'
      width: '50%'
      closeButton: false


  do_token_login: ->
    $('.errors').html ''
    token = $("input[name$='token']").val() || ''
    login = $("input[name$='login']").val() || ''
    say "1 token: #{token} -- login: #{login}"
    @error "GitHub Auth Token value is required" unless token.match /^\S{40}$/
    @error "GitHub Login Id value is required" unless login.length > 0
    state =
      token: token
      login: login
    $.cookie 'state', state,
      path: '/'

  do_logout: ->
    @colorbox.close()
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

  error: (message)->
    $('.errors').append "<p>Error: #{message}</p>"

window.kaleidoverse = ->
  window.ko = new Kaleidoverse
  ko.run()

# vim: set sw=2 lisp:
