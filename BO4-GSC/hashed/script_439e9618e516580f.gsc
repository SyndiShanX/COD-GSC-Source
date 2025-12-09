/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_439e9618e516580f.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace cp_skip_scene_menu;

class ccp_skip_scene_menu: cluielem {
  var var_57a3d576;

  function set_sceneskipendtime(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "sceneSkipEndTime", value);
  }

  function set_votedtoskip(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "votedToSkip", value);
  }

  function set_hostisskipping(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "hostIsSkipping", value);
  }

  function set_showskipbutton(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "showSkipButton", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "cp_skip_scene_menu", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("showSkipButton", 1, 2, "int");
    cluielem::add_clientfield("hostIsSkipping", 1, 1, "int");
    cluielem::add_clientfield("votedToSkip", 1, 1, "int");
    cluielem::add_clientfield("sceneSkipEndTime", 1, 3, "int");
  }

}

register(uid) {
  elem = new ccp_skip_scene_menu();
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

set_showskipbutton(player, value) {
  [[self]] - > set_showskipbutton(player, value);
}

set_hostisskipping(player, value) {
  [[self]] - > set_hostisskipping(player, value);
}

set_votedtoskip(player, value) {
  [[self]] - > set_votedtoskip(player, value);
}

set_sceneskipendtime(player, value) {
  [[self]] - > set_sceneskipendtime(player, value);
}