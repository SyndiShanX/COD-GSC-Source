/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_3b8f43c68572f06.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace revive_hud;

class crevive_hud: cluielem {
  function set_fadetime(localclientnum, value) {
    set_data(localclientnum, "fadeTime", value);
  }

  function set_clientnum(localclientnum, value) {
    set_data(localclientnum, "clientNum", value);
  }

  function set_text(localclientnum, value) {
    set_data(localclientnum, "text", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "revive_hud");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "text", # "");
    set_data(localclientnum, "clientNum", 0);
    set_data(localclientnum, "fadeTime", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, textcallback, var_13af07a1, var_b3fd9949) {
    cluielem::setup_clientfields(uid);
    cluielem::function_52818084("string", "text", 1);
    cluielem::add_clientfield("clientNum", 1, 6, "int", var_13af07a1);
    cluielem::add_clientfield("fadeTime", 1, 5, "int", var_b3fd9949);
  }

}

register(uid, textcallback, var_13af07a1, var_b3fd9949) {
  elem = new crevive_hud();
  [[elem]] - > setup_clientfields(uid, textcallback, var_13af07a1, var_b3fd9949);
  return elem;
}

register_clientside(uid) {
  elem = new crevive_hud();
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

set_text(localclientnum, value) {
  [[self]] - > set_text(localclientnum, value);
}

set_clientnum(localclientnum, value) {
  [[self]] - > set_clientnum(localclientnum, value);
}

set_fadetime(localclientnum, value) {
  [[self]] - > set_fadetime(localclientnum, value);
}