/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_2ce51015ac079c14.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace player_insertion_choice;

class cplayer_insertion_choice: cluielem {
  function set_state(localclientnum, state_name) {
    if(#"defaultstate" == state_name) {
      set_data(localclientnum, "_state", 0);
      return;
    }
    if(#"groundvehicle" == state_name) {
      set_data(localclientnum, "_state", 1);
      return;
    }
    if(#"halojump" == state_name) {
      set_data(localclientnum, "_state", 2);
      return;
    }
    if(#"heli" == state_name) {
      set_data(localclientnum, "_state", 3);
      return;
    }
    assertmsg("<dev string:x30>");
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "player_insertion_choice");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_state(localclientnum, # "defaultstate");
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("_state", 1, 2, "int");
  }

}

register(uid) {
  elem = new cplayer_insertion_choice();
  [[elem]] - > setup_clientfields(uid);
  return elem;
}

register_clientside(uid) {
  elem = new cplayer_insertion_choice();
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