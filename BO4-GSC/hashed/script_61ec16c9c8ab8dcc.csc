/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_61ec16c9c8ab8dcc.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace lower_message;

class clower_message: cluielem {
  function set_countdowntimeseconds(localclientnum, value) {
    set_data(localclientnum, "countdownTimeSeconds", value);
  }

  function set_message(localclientnum, value) {
    set_data(localclientnum, "message", value);
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
    if(#"hash_45bfcb1cd8c9b50a" == state_name) {
      set_data(localclientnum, "_state", 2);
      return;
    }
    assertmsg("<dev string:x30>");
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "lower_message");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_state(localclientnum, # "defaultstate");
    set_data(localclientnum, "message", # "");
    set_data(localclientnum, "countdownTimeSeconds", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_524f4343, var_a46e67bd) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("_state", 1, 2, "int");
    cluielem::function_52818084("string", "message", 1);
    cluielem::add_clientfield("countdownTimeSeconds", 1, 5, "int", var_a46e67bd);
  }

}

register(uid, var_524f4343, var_a46e67bd) {
  elem = new clower_message();
  [[elem]] - > setup_clientfields(uid, var_524f4343, var_a46e67bd);
  return elem;
}

register_clientside(uid) {
  elem = new clower_message();
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

set_message(localclientnum, value) {
  [[self]] - > set_message(localclientnum, value);
}

set_countdowntimeseconds(localclientnum, value) {
  [[self]] - > set_countdowntimeseconds(localclientnum, value);
}