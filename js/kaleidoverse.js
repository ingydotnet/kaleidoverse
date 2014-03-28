// Generated by CoffeeScript 1.6.3
(function() {
  var Kaleidoverse;

  window.Kaleidoverse = Kaleidoverse = (function() {
    function Kaleidoverse() {
      window.say = console.log;
      $.cookie.json = true;
      this.github_owner = 'veradox';
      this.github_repo = 'kaleidoverse';
      this.state = $.cookie('state');
    }

    Kaleidoverse.prototype.run = function() {
      if (this.state) {
        this.display('main', {
          'state': this.state
        });
        return this.github = new Github({
          token: this.state.token,
          auth: "oauth"
        });
      } else {
        return this.display('login');
      }
    };

    Kaleidoverse.prototype.display = function(view, data) {
      return $('.primary-content').html(Jemplate.process("" + view + ".html", data));
    };

    Kaleidoverse.prototype.lightbox = function(view) {
      return this.colorbox = $.colorbox({
        html: Jemplate.process("" + view + ".html"),
        height: '50%',
        width: '50%',
        closeButton: false
      });
    };

    Kaleidoverse.prototype.do_login = function() {
      var login, state, token;
      $('.errors').html('');
      token = $("input[name$='token']").val();
      login = $("input[name$='login']").val();
      say("token: " + token + " -- login: " + login);
      if (!token.match(/^\S{40}$/)) {
        this.error("GitHub Auth Token value is required");
      }
      if (!(login.length > 0)) {
        this.error("GitHub Login Id value is required");
      }
      state = {
        token: token,
        login: login
      };
      return $.cookie('state', state, {
        path: '/'
      });
    };

    Kaleidoverse.prototype.do_logout = function() {
      this.colorbox.close();
      $.removeCookie('state', {
        path: '/'
      });
      return this.run();
    };

    Kaleidoverse.prototype.do_fork = function() {
      this.repo = this.github.getRepo(this.github_owner(this.github_repo));
      return this.repo.fork(function(err) {
        if (err) {
          return say(err);
        } else {
          return alert("You Forked Me!");
        }
      });
    };

    Kaleidoverse.prototype.error = function(message) {
      return $('.errors').append("<p>Error: " + message + "</p>");
    };

    return Kaleidoverse;

  })();

  window.kaleidoverse = function() {
    window.ko = new Kaleidoverse;
    return ko.run();
  };

}).call(this);
