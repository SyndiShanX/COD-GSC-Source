/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_50a49d535160be60.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_hint_text;

class czm_hint_text: cluielem {
  function set_text(localclientnum, value) {
    set_data(localclientnum, "text", value);
  }

  function set_state(localclientnum, state_name) {
    if(#"defaultstate" == state_name) {
      set_data(localclientnum, "_state", 0);
      return;
    }
    if(#"visible" == state_name) {
      set_data(localclientnum, "_state", 1);
      return;
    }
    assertmsg("<dev string:x30>");
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "zm_hint_text");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_state(localclientnum, # "defaultstate");
    set_data(localclientnum, "text", # "");
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, textcallback) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("_state", 1, 1, "int");
    cluielem::function_52818084("string", "text", 1);
  }

}

register(uid, textcallback) {
  elem = new czm_hint_text();
  [[elem]] - > setup_clientfields(uid, textcallback);
  return elem;
}

register_clientside(uid) {
  elem = new czm_hint_text();
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

set_text(localclientnum, value) {
  [[self]] - > set_text(localclientnum, value);
}