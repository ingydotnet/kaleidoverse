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
        token: @state.auth_token
        auth: "oauth"
    else
      @display 'login'

  display: (view, data)->
    $('.primary-content').html Jemplate.process view + '.html', data

  lightbox: (name)->
    $.colorbox({html:"<h1>Welcome #{name}</h1>"})

  do_logout: ->
    $.removeCookie 'state',
      path: '/'
    @run()

  do_fork: ->
    @repo = @github.getRepo @github_owner @github_repo
    @repo.fork (err)->
      if err
        console.log err
      else
        alert "You Forked Me!"


window.kaleidoverse = ->
  window.ko = new Kaleidoverse
  ko.run()

# vim: set sw=2 lisp:
