/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_243ea03c7a285692.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace revive_hud;

class crevive_hud: cluielem {
  var var_57a3d576;

  function set_fadetime(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "fadeTime", value);
  }

  function set_clientnum(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "clientNum", value);
  }

  function set_text(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "text", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "revive_hud", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::function_52818084("string", "text", 1);
    cluielem::add_clientfield("clientNum", 1, 6, "int");
    cluielem::add_clientfield("fadeTime", 1, 5, "int");
  }

}

register(uid) {
  elem = new crevive_hud();
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

set_text(player, value) {
  [[self]] - > set_text(player, value);
}

set_clientnum(player, value) {
  [[self]] - > set_clientnum(player, value);
}

set_fadetime(player, value) {
  [[self]] - > set_fadetime(player, value);
}