/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_vignette_alleys.gsc
*************************************************************************/

function alleys_vig_init() {
  scripts\sp\maps\stpetersburg\stpetersburg_vignette_alleys_anim::main();
  scripts\engine\utility::flag_init("flag_traffic_on");
  scripts\engine\utility::flag_init("flag_traffic_off");
}

function spawn_traffic() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, ["veh_periph_apt_spawner1", "vehicle_skilo_civ_idle_RF", "veh8_civ_lnd_skilo", "veh8_civ_lnd_skilo_black", "veh8_civ_lnd_skilo_green", "veh8_civ_lnd_skilo_grey", "veh8_civ_lnd_skilo_blue", "veh8_civ_lnd_skilo_red"]);
}

function deletedriver(var_0) {
  wait 7;
  var_0 delete();
}