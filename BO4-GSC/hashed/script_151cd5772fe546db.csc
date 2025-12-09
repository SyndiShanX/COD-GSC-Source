/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_151cd5772fe546db.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_arcade_timer;

class czm_arcade_timer: cluielem {
  function set_title(localclientnum, value) {
    set_data(localclientnum, "title", value);
  }

  function set_minutes(localclientnum, value) {
    set_data(localclientnum, "minutes", value);
  }

  function set_seconds(localclientnum, value) {
    set_data(localclientnum, "seconds", value);
  }

  function set_showzero(localclientnum, value) {
    set_data(localclientnum, "showzero", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "zm_arcade_timer");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "showzero", 0);
    set_data(localclientnum, "seconds", 0);
    set_data(localclientnum, "minutes", 0);
    set_data(localclientnum, "title", # "");
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_6a2be891, var_f7588fa5, var_563b0bfd, var_6e945820) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("showzero", 1, 1, "int", var_6a2be891);
    cluielem::add_clientfield("seconds", 1, 6, "int", var_f7588fa5);
    cluielem::add_clientfield("minutes", 1, 4, "int", var_563b0bfd);
    cluielem::function_52818084("string", "title", 1);
  }

}

register(uid, var_6a2be891, var_f7588fa5, var_563b0bfd, var_6e945820) {
  elem = new czm_arcade_timer();
  [[elem]] - > setup_clientfields(uid, var_6a2be891, var_f7588fa5, var_563b0bfd, var_6e945820);
  return elem;
}

register_clientside(uid) {
  elem = new czm_arcade_timer();
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

set_showzero(localclientnum, value) {
  [[self]] - > set_showzero(localclientnum, value);
}

set_seconds(localclientnum, value) {
  [[self]] - > set_seconds(localclientnum, value);
}

set_minutes(localclientnum, value) {
  [[self]] - > set_minutes(localclientnum, value);
}

set_title(localclientnum, value) {
  [[self]] - > set_title(localclientnum, value);
}