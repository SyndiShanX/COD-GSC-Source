/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_50dc2248b1a1cde.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_towers_challenges_hud;

class czm_towers_challenges_hud: cluielem {
  function set_required_goal(localclientnum, value) {
    set_data(localclientnum, "required_goal", value);
  }

  function set_challenge_text(localclientnum, value) {
    set_data(localclientnum, "challenge_text", value);
  }

  function set_progress(localclientnum, value) {
    set_data(localclientnum, "progress", value);
  }

  function set_state(localclientnum, state_name) {
    if(#"defaultstate" == state_name) {
      set_data(localclientnum, "_state", 0);
      return;
    }
    if(#"hidden" == state_name) {
      set_data(localclientnum, "_state", 1);
      return;
    }
    assertmsg("<dev string:x30>");
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "zm_towers_challenges_hud");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_state(localclientnum, # "defaultstate");
    set_data(localclientnum, "progress", 0);
    set_data(localclientnum, "challenge_text", # "");
    set_data(localclientnum, "required_goal", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, progresscallback, var_bbd72b6b, var_d2a439c1) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("_state", 1, 1, "int");
    cluielem::add_clientfield("progress", 1, 7, "int", progresscallback);
    cluielem::function_52818084("string", "challenge_text", 1);
    cluielem::add_clientfield("required_goal", 1, 7, "int", var_d2a439c1);
  }

}

register(uid, progresscallback, var_bbd72b6b, var_d2a439c1) {
  elem = new czm_towers_challenges_hud();
  [[elem]] - > setup_clientfields(uid, progresscallback, var_bbd72b6b, var_d2a439c1);
  return elem;
}

register_clientside(uid) {
  elem = new czm_towers_challenges_hud();
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

set_state(localclientnum, state_name) {
  [[self]] - > set_state(localclientnum, state_name);
}

set_progress(localclientnum, value) {
  [[self]] - > set_progress(localclientnum, value);
}

set_challenge_text(localclientnum, value) {
  [[self]] - > set_challenge_text(localclientnum, value);
}

set_required_goal(localclientnum, value) {
  [[self]] - > set_required_goal(localclientnum, value);
}