/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_64914218f744517b.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace cp_skip_scene_menu;

class ccp_skip_scene_menu: cluielem {
  function set_sceneskipendtime(localclientnum, value) {
    set_data(localclientnum, "sceneSkipEndTime", value);
  }

  function set_votedtoskip(localclientnum, value) {
    set_data(localclientnum, "votedToSkip", value);
  }

  function set_hostisskipping(localclientnum, value) {
    set_data(localclientnum, "hostIsSkipping", value);
  }

  function set_showskipbutton(localclientnum, value) {
    set_data(localclientnum, "showSkipButton", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "cp_skip_scene_menu");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "showSkipButton", 0);
    set_data(localclientnum, "hostIsSkipping", 0);
    set_data(localclientnum, "votedToSkip", 0);
    set_data(localclientnum, "sceneSkipEndTime", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_68837b6a, var_97bafd93, var_4fed2538, var_911972bb) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("showSkipButton", 1, 2, "int", var_68837b6a);
    cluielem::add_clientfield("hostIsSkipping", 1, 1, "int", var_97bafd93);
    cluielem::add_clientfield("votedToSkip", 1, 1, "int", var_4fed2538);
    cluielem::add_clientfield("sceneSkipEndTime", 1, 3, "int", var_911972bb);
  }

}

register(uid, var_68837b6a, var_97bafd93, var_4fed2538, var_911972bb) {
  elem = new ccp_skip_scene_menu();
  [[elem]] - > setup_clientfields(uid, var_68837b6a, var_97bafd93, var_4fed2538, var_911972bb);
  return elem;
}

register_clientside(uid) {
  elem = new ccp_skip_scene_menu();
  [[elem]] - > register_clientside(uid);
  return elem;
}

open(player) {
  [[self]] - > open(player);
}

close(player) {
  [[self]] - > close(player);
}

is_open(localclientnum) {
  return [[self]] - > is_open(localclientnum);
}

set_showskipbutton(localclientnum, value) {
  [[self]] - > set_showskipbutton(localclientnum, value);
}

set_hostisskipping(localclientnum, value) {
  [[self]] - > set_hostisskipping(localclientnum, value);
}

set_votedtoskip(localclientnum, value) {
  [[self]] - > set_votedtoskip(localclientnum, value);
}

set_sceneskipendtime(localclientnum, value) {
  [[self]] - > set_sceneskipendtime(localclientnum, value);
}