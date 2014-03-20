window.Kaleidoverse = class Kaleidoverse
  constructor: ->
    $.cookie.json = true

  run: ->
    login = $.cookie 'login'
    if login
      @display_main login
    else
      @display_login()

  display_main: (login)->
    data =
      'login': login
    $('.primary-content').html Jemplate.process 'main.html', data

  display_login: ->
    $('.primary-content').html Jemplate.process 'login.html'

  do_login: ->
    token = $("input[name$='token']").val()
    if token
      login =
        auth_token: token
      $.cookie 'login', login, { path: '/' }
      @run()

  do_logout: ->
    $.removeCookie 'login', { path: '/' }
    @run()

window.kaleidoverse = ->
  window.ko = new Kaleidoverse
  ko.run()

# vim: set sw=2 lisp:
