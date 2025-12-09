/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_330e1a53a92b38cc.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace mp_revive_prompt;

class cmp_revive_prompt: cluielem {
  function set_reviveprogress(localclientnum, value) {
    set_data(localclientnum, "reviveProgress", value);
  }

  function set_health(localclientnum, value) {
    set_data(localclientnum, "health", value);
  }

  function set_clientnum(localclientnum, value) {
    set_data(localclientnum, "clientnum", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "mp_revive_prompt");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "clientnum", 0);
    set_data(localclientnum, "health", 0);
    set_data(localclientnum, "reviveProgress", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_13af07a1, healthcallback, var_8dd629e, var_81b4b29) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("clientnum", 1, 6, "int", var_13af07a1);
    cluielem::add_clientfield("health", 1, 5, "float", healthcallback);
    cluielem::add_clientfield("reviveProgress", 1, 5, "float", var_8dd629e);
  }

}

register(uid, var_13af07a1, healthcallback, var_8dd629e, var_81b4b29) {
  elem = new cmp_revive_prompt();
  [[elem]] - > setup_clientfields(uid, var_13af07a1, healthcallback, var_8dd629e, var_81b4b29);
  return elem;
}

register_clientside(uid) {
  elem = new cmp_revive_prompt();
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

set_clientnum(localclientnum, value) {
  [[self]] - > set_clientnum(localclientnum, value);
}

set_health(localclientnum, value) {
  [[self]] - > set_health(localclientnum, value);
}

set_reviveprogress(localclientnum, value) {
  [[self]] - > set_reviveprogress(localclientnum, value);
}