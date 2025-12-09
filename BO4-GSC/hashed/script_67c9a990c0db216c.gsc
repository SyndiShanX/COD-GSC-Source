/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_67c9a990c0db216c.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace full_screen_movie;

class cfull_screen_movie: cluielem {
  var var_57a3d576;

  function function_7d4e5f11(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "skippable", value);
  }

  function set_playoutromovie(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "playOutroMovie", value);
  }

  function set_additive(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "additive", value);
  }

  function set_looping(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "looping", value);
  }

  function set_showblackscreen(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "showBlackScreen", value);
  }

  function set_moviename(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "movieName", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "full_screen_movie", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::function_52818084("moviefile", "movieName", 1);
    cluielem::add_clientfield("showBlackScreen", 1, 1, "int");
    cluielem::add_clientfield("looping", 1, 1, "int");
    cluielem::add_clientfield("additive", 1, 1, "int");
    cluielem::add_clientfield("playOutroMovie", 1, 1, "int");
    cluielem::add_clientfield("skippable", 1, 1, "int");
  }

}

register(uid) {
  elem = new cfull_screen_movie();
  [[elem]] - > setup_clientfields(uid);
  return elem;
}

open(player, persistent = 0) {
  [[self]] - > open(player, persistent);
}

close(player) {
  [[self]] - > close(player);
}

is_open(player) {
  return [[self]] - > function_76692f88(player);
}

set_moviename(player, value) {
  [[self]] - > set_moviename(player, value);
}

set_showblackscreen(player, value) {
  [[self]] - > set_showblackscreen(player, value);
}

set_looping(player, value) {
  [[self]] - > set_looping(player, value);
}

set_additive(player, value) {
  [[self]] - > set_additive(player, value);
}

set_playoutromovie(player, value) {
  [[self]] - > set_playoutromovie(player, value);
}

function_7d4e5f11(player, value) {
  [[self]] - > function_7d4e5f11(player, value);
}