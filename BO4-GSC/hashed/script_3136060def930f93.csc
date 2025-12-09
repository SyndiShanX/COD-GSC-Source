/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_3136060def930f93.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_towers_pap_hud;

class czm_towers_pap_hud: cluielem {
  function set_odin_acquired(localclientnum, value) {
    set_data(localclientnum, "odin_acquired", value);
  }

  function set_zeus_acquired(localclientnum, value) {
    set_data(localclientnum, "zeus_acquired", value);
  }

  function set_ra_acquired(localclientnum, value) {
    set_data(localclientnum, "ra_acquired", value);
  }

  function set_danu_acquired(localclientnum, value) {
    set_data(localclientnum, "danu_acquired", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "zm_towers_pap_hud");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "danu_acquired", 0);
    set_data(localclientnum, "ra_acquired", 0);
    set_data(localclientnum, "zeus_acquired", 0);
    set_data(localclientnum, "odin_acquired", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_2d85e973, var_54a997b0, var_fae757c4, var_588b07d5) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("danu_acquired", 1, 1, "int", var_2d85e973);
    cluielem::add_clientfield("ra_acquired", 1, 1, "int", var_54a997b0);
    cluielem::add_clientfield("zeus_acquired", 1, 1, "int", var_fae757c4);
    cluielem::add_clientfield("odin_acquired", 1, 1, "int", var_588b07d5);
  }

}

register(uid, var_2d85e973, var_54a997b0, var_fae757c4, var_588b07d5) {
  elem = new czm_towers_pap_hud();
  [[elem]] - > setup_clientfields(uid, var_2d85e973, var_54a997b0, var_fae757c4, var_588b07d5);
  return elem;
}

register_clientside(uid) {
  elem = new czm_towers_pap_hud();
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

set_danu_acquired(localclientnum, value) {
  [[self]] - > set_danu_acquired(localclientnum, value);
}

set_ra_acquired(localclientnum, value) {
  [[self]] - > set_ra_acquired(localclientnum, value);
}

set_zeus_acquired(localclientnum, value) {
  [[self]] - > set_zeus_acquired(localclientnum, value);
}

set_odin_acquired(localclientnum, value) {
  [[self]] - > set_odin_acquired(localclientnum, value);
}