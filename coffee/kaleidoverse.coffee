window.Kaleidoverse = class Kaleidoverse
  constructor: ->
    $.cookie.json = true
    @github_owner = 'veradox'
    @github_repo = 'kaleidoverse'
    window.say = console.log

  run: ->
    login = $.cookie 'login'
    if login
      @display 'main',
        'login': login
      @github = new Github
        token: login.auth_token
        auth: "oauth"
    else
      if $.url().param('code')
        @finish_login()
      else
        @display 'login'

  display: (view, data)->
    $('.primary-content').html Jemplate.process view + '.html', data

  do_login: ->
    window.location =
      'https://github.com/login/oauth/authorize?' +
      'client_id=fdb1df3dcaddfef441ee;' +
      'redirect_uri=https://veradox.github.io/kaleidoverse;' +
      'state=unguessable_string'
    url
    window.location =

  finish_login: ->
    
#     token = $("input[name$='token']").val()
#     if token
#       login =
#         auth_token: token
#       $.cookie 'login', login,
#         path: '/'
#       @run()

  do_logout: ->
    $.removeCookie 'login',
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
