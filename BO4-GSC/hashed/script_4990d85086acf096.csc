/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_4990d85086acf096.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_location;

class czm_location: cluielem {
  function set_location_name(localclientnum, value) {
    set_data(localclientnum, "location_name", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "zm_location");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "location_name", # "");
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_2bfeb62b) {
    cluielem::setup_clientfields(uid);
    cluielem::function_52818084("string", "location_name", 1);
  }

}

register(uid, var_2bfeb62b) {
  elem = new czm_location();
  [[elem]] - > setup_clientfields(uid, var_2bfeb62b);
  return elem;
}

register_clientside(uid) {
  elem = new czm_location();
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

set_location_name(localclientnum, value) {
  [[self]] - > set_location_name(localclientnum, value);
}