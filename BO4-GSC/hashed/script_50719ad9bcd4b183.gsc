/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_50719ad9bcd4b183.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace full_screen_black;

class cfull_screen_black: cluielem {
  var var_57a3d576;

  function set_endalpha(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "endAlpha", value);
  }

  function set_startalpha(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "startAlpha", value);
  }

  function set_fadeovertime(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "fadeOverTime", value);
  }

  function set_blue(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "blue", value);
  }

  function set_green(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "green", value);
  }

  function set_red(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "red", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "full_screen_black", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("red", 1, 3, "float");
    cluielem::add_clientfield("green", 1, 3, "float");
    cluielem::add_clientfield("blue", 1, 3, "float");
    cluielem::add_clientfield("fadeOverTime", 1, 12, "int");
    cluielem::add_clientfield("startAlpha", 1, 5, "float");
    cluielem::add_clientfield("endAlpha", 1, 5, "float");
  }

}

register(uid) {
  elem = new cfull_screen_black();
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

set_red(player, value) {
  [[self]] - > set_red(player, value);
}

set_green(player, value) {
  [[self]] - > set_green(player, value);
}

set_blue(player, value) {
  [[self]] - > set_blue(player, value);
}

set_fadeovertime(player, value) {
  [[self]] - > set_fadeovertime(player, value);
}

set_startalpha(player, value) {
  [[self]] - > set_startalpha(player, value);
}

set_endalpha(player, value) {
  [[self]] - > set_endalpha(player, value);
}