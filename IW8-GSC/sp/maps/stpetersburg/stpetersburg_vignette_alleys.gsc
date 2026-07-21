/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_vignette_alleys.gsc
*****************************************************************/

alleys_vig_init() {
  scripts\sp\maps\stpetersburg\stpetersburg_vignette_alleys_anim.gsc::main();
  scripts\engine\utility::flag_init("flag_traffic_on");
  scripts\engine\utility::flag_init("flag_traffic_off");
}

spawn_traffic() {
  var_0 = [];
  var_0[0] = ["veh_periph_apt_spawner1", "vehicle_skilo_civ_idle_RF", "veh8_civ_lnd_skilo", "veh8_civ_lnd_skilo_black", "veh8_civ_lnd_skilo_green", "veh8_civ_lnd_skilo_grey", "veh8_civ_lnd_skilo_blue", "veh8_civ_lnd_skilo_red"];
  var_0[1] = ["veh_periph_apt_spawner2", "vehicle_ralfa_civ_idle_RF", "veh8_civ_lnd_ralfa", "veh8_civ_lnd_ralfa_grey", "veh8_civ_lnd_ralfa_brown", "veh8_civ_lnd_ralfa_blue", "veh8_civ_lnd_ralfa_red"];
  var_0[2] = ["veh_periph_apt_spawner3", "vehicle_victor40_civ_idle_RF", "veh8_civ_lnd_victor40", "veh8_civ_lnd_victor40_black", "veh8_civ_lnd_victor40_brown", "veh8_civ_lnd_victor40_blue", "veh8_civ_lnd_victor40_silver", "veh8_civ_lnd_victor40_red"];
  var_0[3] = ["veh_periph_apt_spawner4", "vehicle_audi_civ_idle_RF", "veh8_civ_lnd_secho", "veh8_civ_lnd_secho_black", "veh8_civ_lnd_secho_blue", "veh8_civ_lnd_secho_grey", "veh8_civ_lnd_secho_red", "veh8_civ_lnd_secho_green"];
  var_0[4] = ["veh_periph_apt_spawner5", "vehicle_decho_civ_idle_RF", "veh8_civ_lnd_decho_black", "veh8_civ_lnd_decho", "veh8_civ_lnd_decho_silver", "veh8_civ_lnd_decho_blue", "veh8_civ_lnd_decho_green", "veh8_civ_lnd_decho_tan", "veh8_civ_lnd_decho_brown"];
  var_1 = getspawnerarray("civ_veh_periph_apt_spawner");
  var_2 = getvehiclenodearray("veh_periph_apt_start", "targetname");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::periph_vehicle_loop_new("flag_apartment_enforcer_stairs_vignette", var_0, var_1, var_2);
}

deletedriver(var_0) {
  wait 7;
  var_0 delete();
}