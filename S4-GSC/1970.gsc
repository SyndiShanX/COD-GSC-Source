/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1970.gsc
*************************************************/

init() {
  level._id_237F = getdvarint("#x356a851900a3b0319", 1) == 1;
  level._id_E3B0 = [];
  level._id_2459 = [];
  level._id_2430 = [];
  level._id_2430["max_wait_time"] = 1000;

  foreach(var_1 in level._id_EF89) {
    level._id_8A97[var_1] = 0;
    level._id_E3B0[var_1] = [];
    level._id_2430["queued"][var_1] = "none";
  }

  _id_D8AE();
  _id_C240("callout_location", "", 1.0, 1.0, 10, 10, 0, 0);
  _id_C240("last_mag_o", "combat_action_last_mag_o", 0.4, 0.5, 5, 5, 0);
  _id_C240("obj_sitrep_clear_o", "objectives_inform_sitrep_clear_o", 0.4, 1.0, 5, 5, 0, 0);
  _id_C240("ping_concat_east_o", "ping_concat_east_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_concat_high_o", "ping_concat_high_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_concat_low_o", "ping_concat_low_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_concat_north_o", "ping_concat_north_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_concat_northeast_o", "ping_concat_northeast_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_concat_northwest_o", "ping_concat_northwest_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_concat_south_o", "ping_concat_south_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_concat_southeast_o", "ping_concat_southeast_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_concat_southwest_o", "ping_concat_southwest_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_concat_west_o", "ping_concat_west_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_enemy_general_o", "ping_enemy_general_o", 1.0, 1.0, 15, 10, 1, 0, 0);
  _id_C240("ping_enemy_infantry_o", "ping_enemy_infantry_o", 1.0, 1.0, 15, 10, 1, 0, 0);
  _id_C240("ping_enemy_multiple_o", "ping_enemy_multiple_o", 1.0, 1.0, 15, 10, 1, 0, 0);
  _id_C240("ping_vehicle_heavy_o", "ping_vehicle_heavy_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_vehicle_light_o", "ping_vehicle_light_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_fieldupgrade_drone_o", "ping_fieldupgrade_drone_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_airdrop_o", "ping_killstreaks_airdrop_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_carepkg_o", "ping_killstreaks_carepkg_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_cobalt_o", "ping_killstreaks_cobalt_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_gunship_o", "ping_killstreaks_gunship_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_helo_o", "ping_killstreaks_helo_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_juggernaut_o", "ping_killstreaks_juggernaut_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_ravager_o", "ping_killstreaks_ravager_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_recon_o", "ping_killstreaks_recon_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_scrambler_o", "ping_killstreaks_scrambler_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_sentry_o", "ping_killstreaks_sentry_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_shieldturret_enemy_o", "ping_killstreaks_shieldturret_enemy_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_shieldturret_open_o", "ping_killstreaks_shieldturret_open_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_killstreaks_wheelson_o", "ping_killstreaks_wheelson_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_location_following_o", "ping_location_following_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_objective_device_o", "ping_objective_device_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_response_affirm_o", "ping_response_affirm_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_response_copy_o", "ping_response_copy_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_vehicle_bailout_o", "ping_vehicle_bailout_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_vehicle_concat_no_driver_o", "ping_vehicle_concat_no_driver_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_vehicle_concat_no_pilot_o", "ping_vehicle_concat_no_pilot_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_vehicle_driver_o", "ping_vehicle_driver_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_vehicle_gunner_o", "ping_vehicle_gunner_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_vehicle_pilot_o", "ping_vehicle_pilot_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_vehicle_rider_o", "ping_vehicle_rider_o", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("clock_callout", "p12c", 1.0, 1.0, 10, 10, 1, 0);
  _id_C240("player_respawn", "status_player_respawn", 0.3, 0.25, 5, 1, 0, 0);
  _id_C240("player_captured", "status_player_captured", 0.3, 0.25, 5, 1, 0, 0);
  _id_C240("player_low_health", "status_player_low_health", 0.3, 0.25, 5, 5, 0, 0);
  _id_C240("player_last_stand", "status_player_last_stand", 0.3, 1.0, 5, 1, 0, 0);
  _id_C240("player_recover", "status_player_recover", 0.3, 0.5, 5, 5, 0, 0);
  _id_C240("reviving", "status_action_reviving", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("reviving_specific", "status_action_reviving_specific", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("revived", "status_player_revived", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("revived_specific", "status_player_revived_specific", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("player_inventory_full", "status_player_inventory_full", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("player_inventory_betterone", "status_player_inventory_betterone", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("inform_casualty_help", "status_inform_casualty_help", 0.3, 0.25, 5, 5, 0, 0);
  _id_C240("inform_casualty_kia", "status_inform_casualty_kia", 0.3, 0.25, 5, 5, 0, 0);
  _id_C240("inform_last_two", "status_inform_last_two", 0.3, 0.25, 5, 5, 0, 0);
  _id_C240("inform_last_one", "status_inform_last_one", 0.3, 0.5, 5, 5, 0, 0);
  _id_C240("inform_nomanleft_pickup", "status_inform_nomanleft_pickup", 0.3, 0.25, 5, 5, 0, 0);
  _id_C240("inform_nomanleft_defib", "status_inform_nomanleft_defib", 0.3, 0.25, 5, 5, 0, 0);
  _id_C240("inform_on_your_six_o", "status_inform_on_your_six_o", 0.1, 1.0, 5, 10, 1, 0, 0);
  _id_C240("inform_respawn_enabled", "status_inform_respawn_enabled", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("inform_respawn_drop", "status_inform_respawn_drop", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("inform_insertion_jumpmaster", "status_inform_insertion_jumpmaster", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("use_stim", "eshs", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_atmine", "equipment_action_atmine", 0.4, 1.0, 5, 1);
  _id_C240("use_claymore", "equipment_action_claymore", 0.4, 1.0, 5, 1);
  _id_C240("use_decoy", "deo2", 0.4, 1.0, 5, 1);
  _id_C240("drop_ammobox", "usb1", 0.4, 1.0, 5, 1);
  _id_C240("supplybox_resupply", "usb3", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("supplybox_destroy", "usb4", 0.4, 1.0, 5, 1);
  _id_C240("drop_armor", "equipment_action_drop_armor", 0.4, 1.0, 5, 1);
  _id_C240("drop_grenades", "equipment_action_drop_grenades", 0.4, 1.0, 5, 1);
  _id_C240("drop_selfrevive", "equipment_action_drop_selfrevive", 0.4, 1.0, 5, 1);
  _id_C240("use_explosives", "c4q5", 0.4, 1.0, 5, 1);
  _id_C240("use_flash", "flb2", 0.4, 1.0, 5, 1);
  _id_C240("use_gasmask", "equipment_action_gasmask", 0.4, 1.0, 5, 1);
  _id_C240("use_grenade", "qfg2", 0.4, 1.0, 5, 1);
  _id_C240("use_grenade_throwback", "qfg3", 0.4, 1.0, 5, 1);
  _id_C240("use_impact", "qgb2", 0.4, 1.0, 5, 1);
  _id_C240("use_molotov", "qmo2", 0.4, 1.0, 5, 1);
  _id_C240("use_throwknife", "qthk", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_wp", "qwp2", 0.4, 1.0, 5, 1);
  _id_C240("use_stunmine", "stu7", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_satchel", "sat2", 0.4, 1.0, 5, 1);
  _id_C240("use_sticky", "sem3", 0.4, 1.0, 5, 1);
  _id_C240("use_powerup", "equipment_action_powerup", 0.4, 1.0, 5, 1);
  _id_C240("use_radsuit", "equipment_action_radsuit", 0.4, 1.0, 5, 1);
  _id_C240("use_rocket", "equipment_action_rocket", 0.4, 1.0, 5, 1);
  _id_C240("use_smoke", "qsm2", 0.4, 1.0, 5, 1);
  _id_C240("use_stun", "cos2", 0.4, 1.0, 5, 1);
  _id_C240("use_teargas", "qga2", 0.4, 1.0, 5, 1);
  _id_C240("use_thermite", "qth3", 0.4, 1.0, 5, 1);
  _id_C240("use_deadsilence", "equipment_fieldupgrade_deadsilence", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_emp_drone", "equipment_fieldupgrade_empdrone", 0.4, 1.0, 5, 1);
  _id_C240("use_recon_drone", "equipment_fieldupgrade_recon", 0.4, 1.0, 5, 1);
  _id_C240("use_self_revive", "equipment_fieldupgrade_selfrevive", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_tac_insert", "uti1", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("destroy_insert", "uti4", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_cipher", "udd1", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("cipher_recover", "udd2", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("cipher_destroy", "udd4", 0.4, 1.0, 5, 1);
  _id_C240("use_armor", "uar1", 0.4, 1.0, 5, 1, 0, 1);
  _id_C240("armor_broken", "uar2", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("armor_destroy", "uar3", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_goscar", "ugt1", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_fieldmic", "ufm1", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_jammer", "uja1", 0.4, 1.0, 5, 1, 0);
  _id_C240("destroy_jammer", "uja3", 0.4, 1.0, 5, 1);
  _id_C240("use_charge", "usc1", 0.4, 1.0, 5, 1, 0);
  _id_C240("detonate_charge", "usc3", 0.4, 1.0, 5, 1);
  _id_C240("charge_destroy", "usc4", 0.4, 1.0, 5, 1);
  _id_C240("use_tripwire", "utp1", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("fail_tripwire", "utp2", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_turret", "upt1", 0.4, 1.0, 5, 1);
  _id_C240("use_trophy", "equipment_fieldupgrade_trophy", 0.4, 1.0, 5, 1);
  _id_C240("incoming_c4", "c4q4", 0.4, 1.0, 5, 1);
  _id_C240("incoming_flash", "flb1", 0.4, 1.0, 5, 1);
  _id_C240("incoming_gas", "qga1", 0.4, 1.0, 5, 1);
  _id_C240("incoming_generic", "equipment_incoming_generic", 0.4, 1.0, 5, 1);
  _id_C240("incoming_grenade", "qfg1", 0.4, 1.0, 5, 1);
  _id_C240("incoming_impact", "qgb1", 0.4, 1.0, 5, 1);
  _id_C240("incoming_molotov", "qmo1", 0.4, 1.0, 5, 1);
  _id_C240("incoming_rpg", "equipment_incoming_rpg", 0.8, 1.0, 5, 5);
  _id_C240("incoming_stuck", "equipment_incoming_stuck", 0.4, 1.0, 5, 1);
  _id_C240("incoming_stun", "cos1", 0.4, 1.0, 5, 1);
  _id_C240("incoming_thermite", "qth2", 0.4, 1.0, 5, 1);
  _id_C240("stuck_thermite", "qth1", 0.8, 1.0, 5, 1);
  _id_C240("incoming_wp", "qwp1", 0.4, 1.0, 5, 1);
  _id_C240("incoming_smoke", "qsm1", 0.4, 1.0, 5, 1);
  _id_C240("incoming_stunmine", "stu6", 0.4, 1.0, 5, 1);
  _id_C240("incoming_decoy", "deo1", 0.4, 1.0, 5, 1);
  _id_C240("incoming_satchel", "sat1", 0.4, 1.0, 5, 1);
  _id_C240("incoming_sticky", "sem2", 0.4, 1.0, 5, 1);
  _id_C240("stuck_sticky", "sem1", 0.8, 1.0, 5, 1);
  _id_C240("incoming_stim", "s7im", 0.4, 1.0, 5, 1);
  _id_C240("hijack_mic", "uhe2", 0.4, 1.0, 5, 1, 1, 0);
  _id_C240("hijack_jammer", "uhe3", 0.4, 1.0, 5, 1, 1, 0);
  _id_C240("hijack_mine", "uhe4", 0.4, 1.0, 5, 1, 1, 0);
  _id_C240("last_mag", "combat_action_last_mag", 0.4, 0.5, 0, 5, 0, 0);
  _id_C240("last_mag_high", "combat_action_last_mag_concat_highcal", 0.4, 1.0, 0, 5, 0, 0);
  _id_C240("last_mag_launcher", "combat_action_last_mag_concat_launcher", 0.4, 1.0, 0, 5, 0, 0);
  _id_C240("last_mag_mid", "combat_action_last_mag_concat_midcal", 0.4, 1.0, 0, 5, 0, 0);
  _id_C240("last_mag_shotgun", "combat_action_last_mag_concat_shells", 0.4, 1.0, 0, 5, 0, 0);
  _id_C240("last_mag_small", "combat_action_last_mag_concat_smallcal", 0.4, 1.0, 0, 5, 0, 0);
  _id_C240("reload", "combat_action_reloading", 0.1, 1.0, 5, 5);
  _id_C240("check_fire", "combat_inform_check_fire", 1.0, 1.0, 5, 5);
  _id_C240("check_fire_ally", "combat_inform_check_fire_ally", 1.0, 1.0, 5, 5);
  _id_C240("damage", "combat_inform_taking_fire", 0.5, 1.0, 10, 20);
  _id_C240("damage_long", "combat_inform_taking_fire_long", 0.5, 1.0, 10, 20);
  _id_C240("killfirm_bomber", "combat_killfirm_bomber", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_cobalt", "combat_killfirm_cobalt", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_drone", "combat_killfirm_drone", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_gunship", "combat_killfirm_gunship", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_helo", "combat_killfirm_helo", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_infantry", "combat_killfirm_infantry", 0.3, 0.25, 5, 15);
  _id_C240("killfirm_infantry_double", "combat_killfirm_infantry_double", 0.5, 0.5, 5, 15);
  _id_C240("killfirm_infantry_hexa", "combat_killfirm_infantry_hexa", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_infantry_quadra", "combat_killfirm_infantry_quadra", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_juggernaut", "combat_killfirm_juggernaut", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_ravager", "combat_killfirm_ravager", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_scrambler", "combat_killfirm_scrambler", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_sentry", "combat_killfirm_sentry", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_shieldturret", "combat_killfirm_shieldturret", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_sniper", "combat_killfirm_sniper", 0.5, 0.25, 5, 15);
  _id_C240("killfirm_squad", "combat_killfirm_squad", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_uav", "combat_killfirm_uav", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_vehicleheavy", "combat_killfirm_vehicleheavy", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_vehiclelight", "combat_killfirm_vehiclelight", 0.5, 1.0, 5, 15);
  _id_C240("killfirm_wheelson", "combat_killfirm_wheelson", 0.5, 1.0, 5, 15);
  _id_C240("high_alert", "peha", 1.0, 1.0, 10, 10, 0, 0);
  _id_C240("forward_intel", "pefi", 1.0, 1.0, 10, 10, 0, 0);
  _id_C240("tracker", "prkt", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("piercing_vision", "pepv", 1.0, 1.0, 10, 10, 0, 0);
  _id_C240("scavenger", "prks", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("bloody", "pebl", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("intuition", "pein", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("recon", "pere", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("use_intel_callout", "inac", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_deathmachine_callout", "mgac", 0.4, 1.0, 5, 1, 0);
  _id_C240("deathmachine_respawn", "mgrr", 0.4, 1.0, 5, 1, 0);
  _id_C240("deathmachine_low", "mgal", 0.4, 1.0, 5, 1, 0);
  _id_C240("deathmachine_deplete", "mgad", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_recon_callout", "spac", 0.4, 1.0, 5, 1, 0);
  _id_C240("airdrop_acquire", "cpac", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_crecon_callout", "cspa", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_mortar_callout", "mbac", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_mortar_fail", "mbaf", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_gdog_callout", "gdac", 0.4, 1.0, 5, 1, 0);
  _id_C240("gdog_escort", "gdes", 0.4, 1.0, 5, 1, 0);
  _id_C240("gdog_protect", "gdpr", 0.4, 1.0, 5, 1, 0);
  _id_C240("gdog_kill", "gdki", 0.4, 1.0, 10, 10, 0);
  _id_C240("gdog_multikill", "gdmk", 0.4, 1.0, 10, 10, 0);
  _id_C240("gdog_savior", "gdsa", 0.4, 1.0, 5, 1, 0);
  _id_C240("gdog_selfdamage", "gdsd", 0.4, 1.0, 5, 1, 0);
  _id_C240("gdog_allydamage", "gdad", 0.4, 1.0, 5, 1, 0);
  _id_C240("gdog_enmydamage", "gded", 0.4, 1.0, 5, 1, 0);
  _id_C240("gdog_kia", "dogk", 0.4, 1.0, 5, 1, 0);
  _id_C240("gdog_ekia", "edok", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_glidebomb_callout", "gbac", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_airstrike_callout", "srac", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_warmachine_callout", "wmac", 0.4, 1.0, 5, 1, 0);
  _id_C240("warmachine_respawn", "wmrr", 0.4, 1.0, 5, 1, 0);
  _id_C240("warmachine_low", "wmal", 0.4, 1.0, 5, 1, 0);
  _id_C240("warmachine_deplete", "wmad", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_bombrun_callout", "brac", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_flamethrower_callout", "ftac", 0.4, 1.0, 5, 1, 0);
  _id_C240("flamethrower_ekia", "ftki", 0.4, 1.0, 5, 1, 0);
  _id_C240("flamethrower_low", "ftal", 0.4, 1.0, 5, 1, 0);
  _id_C240("flamethrower_deplete", "ftad", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_firebomb_callout", "fbac", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_adog_callout", "adac", 0.4, 1.0, 5, 1, 0);
  _id_C240("adog_kill", "adki", 0.4, 1.0, 10, 10, 0);
  _id_C240("adog_kia", "adkd", 0.4, 1.0, 5, 1, 0);
  _id_C240("adog_time", "adto", 0.4, 1.0, 5, 1, 0);
  _id_C240("adog_ekia", "eadk", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_informants_callout", "liac", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_airsupport_callout", "btac", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_killstreak_nuke", "vwde", 0.4, 1.0, 5, 1, 0);
  _id_C240("killstreak_nuke_ready", "v2ac", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_ptrooper_callout", "ptac", 0.4, 1.0, 5, 1, 0);
  _id_C240("ptrooper_land", "ptla", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_asuperiority_callout", "asac", 0.4, 1.0, 5, 1, 0);
  _id_C240("supplydrop_acquire", "sdpa", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_fighter_callouts", "fpac", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_killstreak_juggernaut_local", "killstreaks_player_juggernaut_use", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_airdrop_callout", "killstreaks_player_airdrop_callout", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_killstreak_scramblerdrone", "killstreaks_scrambler_use", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_killstreak_sentrygun", "killstreaks_sentry_use", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_killstreak_mobileturret", "killstreaks_shieldturret_use", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_killstreak_dronesentry", "killstreaks_wheelson_use", 0.4, 1.0, 5, 1, 0);
  _id_C240("obj_breach", "objectives_inform_breach", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_breach_set", "objectives_inform_breach_set", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_breach_setting", "objectives_inform_breach_setting", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_collect_another", "objectives_inform_collect_another", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_collect_complete", "objectives_inform_collect_complete", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_collect_false", "objectives_inform_collect_false", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_collect_first", "objectives_inform_collect_first", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_collect_generic", "objectives_inform_collect_generic", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_inform_confirm", "objectives_inform_confirm", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_device_disabled", "objectives_inform_device_disabled", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_device_pickup", "objectives_inform_device_pickup", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_device_set", "objectives_inform_device_set", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_device_setting", "objectives_inform_device_setting", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_exfil_nag", "objectives_inform_exfil_nag", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_fulton_hvi", "objectives_inform_fulton_hvi", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_fulton_package", "objectives_inform_fulton_package", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_holding", "objectives_inform_holding", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_hvi_cover", "objectives_inform_hvi_cover", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_hvi_follow", "objectives_inform_hvi_follow", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_hvi_wait", "objectives_inform_hvi_wait", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_interact", "objectives_inform_interact", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_moveout_nag", "objectives_inform_moveout_nag", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_package", "objectives_inform_package", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_secured", "objectives_inform_secured", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_sitrep_10seconds", "objectives_inform_sitrep_10seconds", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_sitrep_30seconds", "objectives_inform_sitrep_30seconds", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_sitrep_60seconds", "objectives_inform_sitrep_60seconds", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_sitrep_circle_in", "objectives_inform_sitrep_circle_in", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_sitrep_circle_mixed", "objectives_inform_sitrep_circle_mixed", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_sitrep_circle_out", "objectives_inform_sitrep_circle_out", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_sitrep_circle_outfar", "objectives_inform_sitrep_circle_outfar", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_sitrep_clear", "objectives_inform_sitrep_clear", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_sitrep_clock_start", "objectives_inform_sitrep_clock_start", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_sitrep_success", "objectives_inform_sitrep_success", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_sitrep_wave_start", "objectives_inform_sitrep_wave_start", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_target_eliminated", "objectives_inform_target_eliminated", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_target_interrogate", "objectives_inform_target_interrogate", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_target_moving", "objectives_inform_target_moving", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_target_visual", "objectives_inform_target_visual", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_visual", "objectives_inform_visual", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("obj_visual_lost", "objectives_inform_visual_lost", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("conv_generic_reply", "convo_generic_reply", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("conv_generic_signoff", "convo_generic_signoff", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("conv_generic_affirm", "convo_generic_affirm", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("conv_direct_start", "convo_direct_start", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("conv_convo_direct_resp", "convo_convo_direct_resp", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("convo_like_start", "convo_like_start", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("convo_like_resp", "convo_like_resp", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("convo_neutral_start", "convo_neutral_start", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("convo_neutral_resp", "convo_neutral_resp", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("convo_dislike_start", "convo_dislike_start", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("convo_dislike_resp", "convo_dislike_resp", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("flavor_revenge", "srvg", 0.4, 0.5, 10, 10, 0);
  _id_C240("flavor_save", "skit", 0.4, 0.5, 10, 10, 0);
  _id_C240("flavor_suppressed", "ersd", 0.4, 1.0, 10, 10, 0);
  _id_C240("flavor_awesome", "flavor_player_awesome", 0.4, 1.0, 5, 10, 0);
  _id_C240("flavor_closecall", "flavor_player_closecall", 0.4, 1.0, 5, 10, 0);
  _id_C240("flavor_surprise", "flavor_player_surprise", 0.4, 0.25, 5, 10, 0);
  _id_C240("flavor_execution", "flavor_player_execution", 1.0, 1.0, 5, 10, 0);
  _id_C240("flavor_headshotlong", "flavor_player_headshotlong", 0.4, 0.5, 5, 10, 0);
  _id_C240("flavor_positive", "flavor_player_positive", 0.4, 1.0, 5, 10, 0);
  _id_C240("flavor_negative", "flavor_player_negative", 0.4, 1.0, 5, 10, 0);
  _id_C240("flavor_shootnearmiss", "flavor_player_shootnearmiss", 0.4, 1.0, 5, 10, 0);
  _id_C240("flavor_neardeathkill", "skij", 0.4, 0.5, 10, 10, 0);
  _id_C240("flavor_goodhit", "flavor_goodhit", 0.4, 1.0, 5, 10, 0);
  _id_C240("flavor_okay", "flavor_okay", 0.4, 1.0, 5, 10, 0);
  _id_C240("flavor_hurryup", "flavor_hurryup", 0.4, 1.0, 5, 10, 0);
  _id_C240("flavor_taunt_point", "flavor_taunt_point", 0.4, 1.0, 5, 10, 0);
  _id_C240("flavor_taunt_wave", "flavor_taunt_wave", 0.4, 1.0, 5, 10, 0);
  _id_C240("flavor_firstblood", "sfkl", 0.5, 1.0, 10, 10, 0, 1);
  _id_C240("flavor_impaired", "skst", 0.5, 1.0, 10, 10, 0, 1);
  _id_C240("flavor_oneshotkill", "skos", 0.5, 0.5, 10, 10, 0, 1);
  _id_C240("flavor_melee", "skml", 1.1, 0.5, 10, 10, 0, 1);
  _id_C240("flavor_pointblank", "spkl", 0.5, 0.5, 10, 10, 0, 1);
  _id_C240("flavor_5streak", "sk05", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("flavor_10streak", "sk10", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("flavor_15streak", "sk15", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("flavor_20streak", "sk20", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("flavor_25streak", "sk25", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("flavor_30streak", "sk30", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("flavor_multi2", "smk2", 0.5, 1.0, 10, 10, 0, 1);
  _id_C240("flavor_multi4", "smk4", 0.5, 1.0, 10, 10, 0, 1);
  _id_C240("flavor_multi6", "smk6", 0.5, 1.0, 10, 10, 0, 1);
  _id_C240("flavor_stuckenemy", "sesx", 0.5, 1.0, 10, 10, 0, 1);
  _id_C240("flavor_comeback", "scbk", 0.5, 1.0, 10, 10, 0, 0);
  _id_C240("flavor_roadkill", "svkl", 0.5, 0.5, 10, 10, 0, 1);
  _id_C240("flavor_blinded", "erbd", 0.5, 1.0, 10, 10, 0, 1);
  _id_C240("flavor_concussed", "ercd", 0.5, 1.0, 10, 10, 0, 1);
  _id_C240("gas_player_cough", "egch", 100, 1.0, 0, 0, 0, 1, undefined, undefined, undefined, 0);
  _id_C240("gas_player_gag", "eggg", 100, 1.0, 0, 0, 0, 1, undefined, undefined, undefined, 0);
  _id_C240("gas_player_exit", "eggp", 110, 1.0, 0, 0, 0, 1, undefined, undefined, undefined, 0);
  _id_C240("gas_player_death", "egdt", 150, 1.0, 0, 0, 0, 1, undefined, undefined, 0, 0);
  _id_C240("effort_blinded", "ebld", 1.0, 1.0, 5, 5, 0, 1);
  _id_C240("effort_concussed", "econ", 0.5, 1.0, 10, 10, 0, 1);
  _id_C240("effort_melee_l", "emel", 1.0, 1.0, 0, 0, 0, 1, undefined, undefined, undefined, 0);
  _id_C240("effort_melee_h", "emeh", 1.0, 1.0, 0, 0, 0, 1, undefined, undefined, undefined, 0);
  _id_C240("effort_punch", "epug", 1.0, 1.0, 1.2, 1.2, 0, 1, undefined, undefined, undefined, 0);
  _id_C240("effort_punched", "eput", 1.0, 1.0, 0, 0, 0, 1, undefined, undefined, undefined, 0);
  _id_C240("effort_throw", "ethr", 0.4, 1.0, 5, 1);
  _id_C240("effort_bludgeoned", "eblu", 150, 1.0, 0, 0, 0, 1, undefined, undefined, 0, 0);
  _id_C240("effort_bullet_pain", "ebpa", 0.5, 0.5, 5, 5, 0, 1, undefined, undefined, undefined, 0);
  _id_C240("effort_bullet_painv", "ebpv", 1.0, 1.0, 5, 5, 0, 1, undefined, undefined, undefined, 0);
  _id_C240("effort_death", "edth", 150, 1.0, 0, 0, 0, 1, undefined, undefined, 0, 0);
  _id_C240("effort_stabbed", "estb", 150, 1.0, 0, 0, 0, 1, undefined, undefined, 0, 0);
  _id_C240("effort_burned", "ebtd", 150, 1.0, 0, 0, 0, 1, undefined, undefined, 0, 0);
  _id_C240("effort_burn_tick", "ebdt", 0.2, 1.0, 3, 3, 0, 1, undefined, undefined, undefined, 0);
  _id_C240("effort_fell", "edfa", 150, 1.0, 0, 0, 0, 1, undefined, undefined, 0, 0);
  _id_C240("effort_exploded", "eexd", 150, 1.0, 0, 0, 0, 1, undefined, undefined, 0, 0);
  _id_C240("effort_death_veh_fl", "evdf", 150, 1.0, 0, 0, 0, 1, undefined, undefined, 0, 0);
  _id_C240("effort_death_veh_hi", "evdh", 150, 1.0, 0, 0, 0, 1, undefined, undefined, 0, 0);
  _id_C240("effort_death_veh_un", "evdu", 150, 1.0, 0, 0, 0, 1, undefined, undefined, 0, 0);
  _id_C240("effort_sprint_wall", "ebtw", 0.5, 1.0, 0, 0, 0, 1, undefined, undefined, undefined, 0);

  if(scripts\mp\utility\game::getgametype() != "infect") {
    _id_C240("ping_aidstation", "ping_aidstation", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_aidstation_carry", "ping_aidstation_carry", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_ambulance", "ping_ambulance", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_gear_lethal", "pgle", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_gear_tactical", "pgta", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_grenade_lethal", "plet", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_grenade_tactical", "ptat", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_ammo_highcal", "paam", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_ammo_launcher", "paam", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_ammo_midcaliber", "paam", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_ammo_shotgun", "paam", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_ammo_smallcal", "paam", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_armor_satchel", "pasa", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_attachments_generic", "piat", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_attachments_optics", "piat", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_bag", "pgba", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_east", "ping_concat_east", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_high", "ping_concat_high", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_level1", "ping_concat_level1", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_level2", "ping_concat_level2", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_level3", "ping_concat_level3", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_level4", "ping_concat_level4", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_level5", "ping_concat_level5", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_low", "ping_concat_low", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_north", "ping_concat_north", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_northeast", "ping_concat_northeast", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_northwest", "ping_concat_northwest", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_south", "ping_concat_south", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_southeast", "ping_concat_southeast", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_southwest", "ping_concat_southwest", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_concat_west", "ping_concat_west", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_container", "pcot", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_dibs", "ping_dibs", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_attacking", "ping_enemy_attacking", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_bomber", "ping_enemy_bomber", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_bunker", "pebu", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_dog", "pegd", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_gate", "pega", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_general", "ping_enemy_general", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_goodkill", "ping_enemy_goodkill", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_goscar", "pegt", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_infantry", "ping_enemy_infantry", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_multiple", "ping_enemy_multiple", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_para", "pepa", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_rpg", "ping_enemy_rpg", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_sniper", "ping_enemy_sniper", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_three", "ping_enemy_three", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_traps", "pegl", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_tacs", "petc", 1.0, 1.0, 5, 5, 0, 0);
    _id_C240("ping_enemy_two", "ping_enemy_two", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_vehicle_heavy", "peve", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_enemy_vehicle_light", "peve", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_fieldupgrade_drone", "ping_fieldupgrade_drone", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_fieldupgrade_supplybox", "ping_fieldupgrade_supplybox", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_fieldupgrade_tacinsert", "ping_fieldupgrade_tacinsert", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_equipment_generic", "pfeg", 1.0, 1.0, 5, 5, 0, 0);
    _id_C240("ping_killstreaks_airdrop", "pkge", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_carepkg", "pkge", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_cobalt", "pkge", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_gunship", "pkge", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_helo", "pkge", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_juggernaut", "pkge", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_ravager", "pkge", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_recon", "pkge", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_scrambler", "pkge", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_sentry", "pkge", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_shieldturret_enemy", "ping_killstreaks_shieldturret_enemy", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_shieldturret_open", "ping_killstreaks_shieldturret_open", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_killstreaks_wheelson", "pegt", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_location_bunker", "pfbu", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_location_destructible", "pdsu", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_location_follow", "plac", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_location_gate", "plga", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_location_generic", "ploc", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_location_gtfo", "ping_location_gtfo", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_location_landing", "ping_location_landing", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_location_landing_suggestion", "ping_location_landing_suggestion", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_location_looted", "ping_location_looted", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_location_regroup", "ping_location_regroup", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_need_armor", "pnrm", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_need_gun", "ping_need_gun", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_need_helmet", "ping_need_helmet", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_need_highcal", "pnam", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_need_launcher", "pnam", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_need_medical", "pnfa", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_need_midcal", "pnam", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_need_shells", "pnam", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_need_smallcal", "pnam", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_objective_general", "pobj", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_objective_bomb", "pobo", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_objective_bomb_site", "pobs", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_objective_control_point", "pocp", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_objective_device", "ping_objective_device", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_objective_flag", "pofa", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_objective_hardpoint", "poha", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_objective_next_hardpoint", "ponh", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_objective_patrol", "popa", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_pickup_armor", "piar", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_pickup_generic", "pite", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_pickup_health", "pifa", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_pickup_riotshield", "pmel", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_plunder_bank", "ping_plunder_bank", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_plunder_cache", "ping_plunder_cache", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_plunder_loot", "ping_plunder_loot", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_plunder_vendor", "ping_plunder_vendor", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_affirm", "ping_response_affirm", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_affirm_item", "piac", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_affirm_dngr", "pdac", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_affirm_engr", "pegk", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_affirm_objv", "poba", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_cancel", "ping_response_cancel", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_copy", "ping_response_copy", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_helpme", "ping_response_helpme", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_leaveme", "ping_response_leaveme", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_revive", "ping_response_revive", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_thanks", "ping_response_thanks", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_response_thanks_specific", "ping_response_thanks_specific", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_vehicle", "pveh", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_vehicle_bailout", "ping_vehicle_bailout", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_vehicle_concat_no_driver", "ping_vehicle_concat_no_driver", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_vehicle_concat_no_pilot", "ping_vehicle_concat_no_pilot", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_vehicle_driver", "ping_vehicle_driver", 1.0, 1.0, 0, 0, 0, 0, 1, 1);
    _id_C240("ping_vehicle_enemy", "peve", 1.0, 1.0, 0, 0, 0, 0, 1, 1);
    _id_C240("ping_vehicle_gunner", "ping_vehicle_gunner", 1.0, 1.0, 0, 0, 0, 0, 1, 1);
    _id_C240("ping_vehicle_heavy", "pcve", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_vehicle_helo", "ping_vehicle_helo", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_vehicle_light", "ping_vehicle_light", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_vehicle_needride", "ping_vehicle_needride", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_vehicle_pilot", "ping_vehicle_pilot", 1.0, 1.0, 0, 0, 0, 0, 1, 1);
    _id_C240("ping_vehicle_rider", "ping_vehicle_rider", 1.0, 1.0, 0, 0, 0, 0, 1, 1);
    _id_C240("ping_weapon_assaultrifle", "pgun", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_weapon_custom", "pgun", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_weapon_dmr", "pgun", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_weapon_launcher", "pgun", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_weapon_lmg", "pgun", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_weapon_melee", "pmel", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_weapon_pistol", "pgun", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_weapon_shotgun", "pgun", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_weapon_smg", "pgun", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("ping_weapon_sniper", "pgun", 1.0, 1.0, 0, 0, 0, 0);
    _id_C240("use_cover", "udc1", 0.4, 1.0, 5, 1);
    _id_C240("destroyed_cover", "udc4", 0.4, 1.0, 5, 1);
    _id_C240("destroyed_c4", "c4q1", 0.4, 1.0, 5, 1);
    _id_C240("destroyed_stunmine", "stu1", 0.4, 1.0, 5, 1);
  }

  level._id_6018 = _id_07B3::_id_580B;
  _id_06C9::_id_2446();
  var_3 = getDvar("#x315af23e89f368200");
  level._id_8A8A = 0;
  _id_0AA3::_id_C28D(::onplayerspawned);
}

_id_C240(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(!isDefined(var_8)) {
    var_8 = 1;
  }

  if(!isDefined(var_9)) {
    var_9 = 0;
  }

  if(!isDefined(var_10)) {
    var_10 = 1;
  }

  if(!isDefined(var_11)) {
    var_11 = 1;
  }

  var_12 = 0;

  if(var_11) {
    if(scripts\mp\utility\game::_id_8A5F() && scripts\mp\utility\game::getgametype() == "br") {
      var_12 = 0;
    } else if(level._id_9C5D <= 12) {
      var_12 = 0;
    } else if(level._id_9C5D > 12 && level._id_9C5D <= 24) {
      var_12 = 5000;
    } else if(level._id_9C5D > 24 && level._id_9C5D <= 40) {
      var_12 = 10000;
    } else {
      var_12 = 15000;
    }
  }

  level._id_2459[var_0] = var_1;
  level._id_2430["priority"][var_0] = var_2;
  level._id_2430["chance"][var_0] = var_3;
  level._id_2430["timeout"][var_0] = var_4 * 1000 + var_12;
  level._id_2430["timeout_player"][var_0] = var_5 * 1000;
  level._id_2430["req_friendly"][var_0] = var_6;
  level._id_2430["play_for_all"][var_0] = var_7;
  level._id_2430["play_to_self"][var_0] = var_8;
  level._id_2430["play_for_squad_only"][var_0] = var_9;
  level._id_2430["requires_alive"][var_0] = var_10;
}

onplayerspawned() {
  self._id_2432 = "none";
  self._id_C0ED = [];
  self._id_2431 = [];

  if(!isDefined(level._id_2430["last_say_time"])) {
    level._id_2430["last_say_time"] = [];
    level._id_2430["last_say_pos"] = [];
  }

  if(level.splitscreen) {
    return;
  }
  if(level._id_8A8A || istrue(level._id_4A81) || scripts\mp\utility\game::isanymlgmatch()) {
    self._id_2429 = 1;
  } else {
    if(!scripts\mp\utility\game::_id_CA4B() || istrue(level._id_2AA3)) {
      thread _id_AB9B();
      thread wallbreaktracking();
      thread meleetracking();

      if(istrue(self._id_10A1F)) {
        level thread _id_F759(self, "inform_on_your_six_o");
        thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_015");
        return;
      }

      return;
    }

    if(scripts\mp\utility\game::getgametype() != "br") {
      self._id_2429 = 1;
    }
  }
}

_id_7BE2() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bc_damage_taken");
  wait 1.5;
  level thread _id_F759(self, "player_low_health");
}

_id_FF55() {
  var_0 = [];
  var_1 = gettime();

  foreach(var_3 in self._id_C0ED) {
    if(var_1 < var_3._id_7D14) {
      var_0[var_0.size] = var_3;
    }
  }

  self._id_C0ED = var_0;
}

_id_111F(var_0) {
  if(!isDefined(self._id_C0ED)) {
    self._id_C0ED = [];
  }

  var_1 = 0;

  foreach(var_3 in self._id_C0ED) {
    if(var_3.attacker == var_0) {
      var_1 = 1;
      var_3._id_F1E8 = gettime();
      var_3._id_7D14 = var_3._id_F1E8 + 2000;
      break;
    }
  }

  if(!var_1) {
    var_3 = spawnStruct();
    var_3._id_F1E8 = gettime();
    var_3.attacker = var_0;
    var_3._id_7D14 = var_3._id_F1E8 + 2000;
    self._id_C0ED[self._id_C0ED.size] = var_3;
  }

  _id_FF55();

  if(self._id_C0ED.size > 1) {
    level thread _id_F759(self, "flavor_negative");
  }
}

_id_90F5(var_0) {
  var_0 endon("death");

  for(;;) {
    var_1 = scripts\common\utility::_id_B7BF(var_0.origin, 500);

    foreach(var_3 in var_1) {
      if(!isDefined(var_3) || !var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(isDefined(var_0.owner) && !var_0.owner scripts\mp\utility\player::isenemy(var_3)) {
        continue;
      }
      level thread _id_F759(var_3, "incoming_rpg");
      return;
    }

    waitframe();
  }
}

_id_8B9F(var_0, var_1) {
  if(!level.teambased) {
    return;
  }
  var_2 = scripts\engine\utility::random(scripts\mp\utility\game::_id_6BE2(var_0));
  var_3 = scripts\mp\utility\player::_id_6C5F(var_1, 360000, var_2);

  if(var_3.size == 0) {
    return;
  } else {
    var_4 = scripts\engine\utility::random(var_3);
    level thread _id_F759(var_4, "incoming_rpg", undefined, 0.5);
  }
}

_id_AAF8(var_0) {
  if(istrue(var_0._id_F170)) {
    level thread _id_F759(self, "use_grenade_throwback");
  } else {
    switch (var_0.weapon_name) {
      case "s4_frag_usa_mk2_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_grenade");
        }

        break;
      case "s4_sticky_eng_n74_mp":
      case "s4_semtex_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_sticky");
        }

        break;
      case "s4_molotov_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_molotov");
        }

        break;
      case "equip_pop_rocket":
        level thread _id_F759(self, "use_rocket");
        break;
      case "s4_thermite_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_thermite");
        }

        break;
      case "s4_c4_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_satchel");
        }

        break;
      case "claymore_mp":
        level thread _id_F759(self, "use_claymore");
        break;
      case "equip_at_mine":
        level thread _id_F759(self, "use_atmine");
        break;
      case "s4_mine_ger_s44_mp":
        level thread _id_F759(self, "use_stunmine");
        break;
      case "flash_grenade_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_flash");
        }

        break;
      case "s4_stun_gbr_n69_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_stun");
        }

        break;
      case "sensor_grenade_mp":
        break;
      case "s4_smoke_usa_m18_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_smoke");
        }

        break;
      case "gas_grenade_mp":
      case "s4_gas_usa_mk5cn_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_teargas");
        }

        break;
      case "s4_decoy_grenade_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_decoy");
        }

        break;
      case "equip_adrenaline":
      case "s4_adrenaline_mp":
        level thread _id_F759(self, "use_stim");
        break;
      case "s4_tac_cover_mp":
      case "deployable_cover_mp":
        level thread _id_F759(self, "use_cover");
        break;
      case "s4_field_mic_mp":
        if(scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_006")) {
          thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_006");
        } else {
          level thread _id_F759(self, "use_fieldmic");
          thread _id_07A9::logevent_votriggered(self, "quiptrigger_006", "none");
        }

        break;
      case "s4_jammer_mp":
        if(scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_006")) {
          thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_006");
        } else {
          level thread _id_F759(self, "use_jammer");
          thread _id_07A9::logevent_votriggered(self, "quiptrigger_006", "none");
        }

        break;
      case "s4_hand_flare_mp":
        if(scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_006")) {
          thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_006");
        } else {
          level thread _id_F759(self, "use_tac_insert");
          thread _id_07A9::logevent_votriggered(self, "quiptrigger_006", "none");
        }

        break;
      case "s4_trophy_mp":
        if(scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_006")) {
          thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_006");
        } else {
          level thread _id_F759(self, "use_trophy");
          thread _id_07A9::logevent_votriggered(self, "quiptrigger_006", "none");
        }

        break;
      case "s4_equipment_resupply_box_mp":
      case "support_box_mp":
        if(scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_006")) {
          thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_006");
        } else {
          level thread _id_F759(self, "drop_ammobox");
          thread _id_07A9::logevent_votriggered(self, "quiptrigger_006", "none");
        }

        break;
      case "s4_frag_gbr_n23_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_grenade");
        }

        break;
      case "s4_frag_ger_m24_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_grenade");
        }

        break;
      case "s4_frag_gbr_n82_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_impact");
        }

        break;
      case "s4_bundle_charge_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_satchel");
        }

        break;
      case "s4_smoke_gbr_n77_mp":
        if(scripts\engine\utility::cointoss()) {
          level thread _id_F759(self, "effort_throw");
        } else {
          level thread _id_F759(self, "use_grenade");
        }

        break;
      case "s4_throwing_knife_mp":
        level thread _id_F759(self, "use_throwknife");
        break;
    }
  }
}

calloutequipment(var_0) {
  var_1 = self;

  switch (var_0) {
    case "s4_frag_usa_mk2_mp":
      level thread _id_F759(var_1, "incoming_grenade");
      break;
    case "s4_stun_gbr_n69_mp":
      level thread _id_F759(var_1, "incoming_stun");
      break;
    case "flash_grenade_mp":
      level thread _id_F759(var_1, "incoming_flash");
      break;
    case "s4_smoke_usa_m18_mp":
      level thread _id_F759(var_1, "incoming_smoke");
      break;
    case "s4_sticky_eng_n74_mp":
    case "s4_semtex_mp":
      level thread _id_F759(var_1, "incoming_sticky");
      break;
    case "s4_molotov_mp":
      level thread _id_F759(var_1, "incoming_molotov");
      break;
    case "equip_pop_rocket":
      level thread _id_F759(var_1, "incoming_generic");
      break;
    case "s4_c4_mp":
      level thread _id_F759(var_1, "incoming_satchel");
      break;
    case "sensor_grenade_mp":
      level thread _id_F759(var_1, "incoming_generic");
      break;
    case "s4_thermite_mp":
      level thread _id_F759(var_1, "incoming_thermite");
      break;
    case "gas_grenade_mp":
    case "s4_gas_usa_mk5cn_mp":
      level thread _id_F759(var_1, "incoming_gas");
      break;
    case "s4_frag_gbr_n82_mp":
      level thread _id_F759(var_1, "incoming_impact");
      break;
    case "s4_frag_ger_m24_mp":
      level thread _id_F759(var_1, "incoming_grenade");
      break;
    case "s4_frag_gbr_n23_mp":
      level thread _id_F759(var_1, "incoming_grenade");
      break;
    case "s4_smoke_gbr_n77_mp":
      level thread _id_F759(var_1, "incoming_grenade");
      break;
    case "s4_mine_ger_s44_mp":
      level thread _id_F759(var_1, "incoming_stunmine");
      break;
    case "s4_decoy_grenade_mp":
      level thread _id_F759(var_1, "incoming_decoy");
      break;
    case "s4_field_mic_mp":
      level thread _id_F759(self, "ping_enemy_tacs");
      break;
    case "s4_jammer_mp":
      level thread _id_F759(self, "ping_enemy_tacs");
      break;
    case "tac_insert_trigger":
    case "s4_hand_flare_mp":
      level thread _id_F759(self, "ping_enemy_tacs");
      break;
    case "s4_equipment_resupply_box":
      level thread _id_F759(self, "ping_enemy_tacs");
      break;
    default:
      if(weaponclass(var_0) == "rocketlauncher") {
        level thread _id_F759(var_1, "incoming_rpg");
      }

      break;
  }
}

_id_7170() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self.weapon_name;

  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "tac_insert_trigger":
    case "s4_field_mic_mp":
    case "s4_jammer_mp":
    case "s4_equipment_resupply_box_mp":
    case "s4_tac_cover_mp":
    case "s4_mine_ger_s44_mp":
    case "s4_hand_flare_mp":
    case "trophy_mp":
    case "deployable_cover_mp":
      return;
  }

  var_1 = self.owner;

  if(!isDefined(var_1)) {
    var_1 = _func_00AF(self);
  }

  if(!isDefined(var_1)) {
    return;
  }
  self endon("death");
  var_2 = 0;

  while(!var_2) {
    var_3 = scripts\common\utility::_id_B7BF(self.origin, 384);

    foreach(var_5 in var_3) {
      if(var_2) {
        return;
      }
      if(!isDefined(var_5) || var_5 scripts\cp_mp\utility\player_utility::_isalive() == 0 || isDefined(self.owner) && self.owner scripts\mp\utility\player::isenemy(var_5) == 0) {
        continue;
      }
      var_6 = distancesquared(self.origin, var_5.origin);

      if(isDefined(var_6) && var_6 < 147456) {
        if(!_func_0202(var_5 getEye(), self.origin, 0, var_5)) {
          continue;
        }
        var_5 calloutequipment(var_0);
        var_2 = 1;
      }

      waitframe();
    }

    waitframe();
  }
}

enemyuseadrenaline() {
  var_0 = 0;
  var_1 = scripts\common\utility::_id_B7BF(self.origin, 384);

  foreach(var_3 in var_1) {
    if(var_0) {
      return;
    }
    if(!isDefined(var_3) || var_3 scripts\cp_mp\utility\player_utility::_isalive() == 0 || isDefined(self) && scripts\mp\utility\player::isenemy(var_3) == 0) {
      continue;
    }
    var_4 = distancesquared(self.origin, var_3.origin);

    if(isDefined(var_4) && var_4 < 147456) {
      if(_func_0202(var_3 getEye(), self.origin, 0, var_3)) {
        level thread _id_F759(var_3, "incoming_stim");
        var_0 = 1;
      }
    }

    waitframe();
  }
}

_id_555B(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.weapon_name)) {
    return;
  }
  if(scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_011")) {
    thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_011");
    return;
  } else
    thread _id_07A9::logevent_votriggered(self, "quiptrigger_011", "none");

  switch (var_0.weapon_name) {
    case "s4_c4_mp":
      level thread _id_F759(self, "destroyed_c4");
      break;
    case "at_mine_mp":
      break;
    case "s4_mine_ger_s44_mp":
      level thread _id_F759(self, "destroyed_stunmine");
      break;
    case "claymore_mp":
      break;
    case "trophy_mp":
      break;
    case "s4_tac_cover_mp":
    case "deployable_cover_mp":
      level thread _id_F759(var_0.owner, "destroyed_cover");
      break;
    case "s4_decoy_grenade_mp":
      break;
    case "gas_grenade_mp":
      break;
    case "sensor_grenade_mp":
      break;
    case "s4_equipment_resupply_box_mp":
    case "support_box_mp":
      level thread _id_F759(self, "supplybox_destroy");
      break;
    case "tac_insert_trigger":
    case "s4_hand_flare_mp":
      level thread _id_F759(self, "destroy_insert");
      break;
    case "s4_jammer_mp":
      level thread _id_F759(self, "destroy_jammer");
      break;
  }
}

_id_B86D(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(var_0 scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_005")) {
    var_0 thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_005");
    return;
  } else
    thread _id_07A9::logevent_votriggered(var_0, "quiptrigger_005", "none");

  switch (var_1) {
    case "gunship":
    case "chopper_gunner":
    case "ball_turret_gunner":
    case "chopper_support":
      level thread _id_F759(var_0, "use_airsupport_callout");
      break;
    case "death_switch":
      level thread _id_F759(var_0, "use_killstreak_deadman");
      break;
    case "pac_sentry":
      level thread _id_F759(var_0, "use_killstreak_dronesentry");
      break;
    case "bradley":
    case "airdrop":
    case "airdrop_multiple":
      level thread _id_F759(var_0, "use_airdrop_callout");
      break;
    case "manual_turret":
      level thread _id_F759(var_0, "use_killstreak_mobileturret");
      break;
    case "sentry_gun":
      level thread _id_F759(var_0, "use_killstreak_sentrygun");
      break;
    case "nuke_select_location":
    case "nuke":
      level thread _id_F759(var_0, "use_killstreak_nuke");
      break;
    case "warmachine":
      level thread _id_F759(var_0, "use_warmachine_callout");
      break;
    case "lmg_streak":
      level thread _id_F759(var_0, "use_deathmachine_callout");
      break;
    case "juggernaut":
      level thread _id_F759(var_0, "use_flamethrower_callout");
      break;
    case "mortar_barrage":
      level thread _id_F759(var_0, "use_mortar_callout");
      break;
    case "cruise_predator":
    case "glide_bomb":
      level thread _id_F759(var_0, "use_glidebomb_callout");
      break;
    case "hover_jet":
    case "precision_airstrike":
      level thread _id_F759(var_0, "use_airstrike_callout");
      break;
    case "toma_strike":
      level thread _id_F759(var_0, "use_bombrun_callout");
      break;
    case "fuel_airstrike":
    case "white_phosphorus":
      level thread _id_F759(var_0, "use_firebomb_callout");
      break;
    case "directional_uav":
      level thread _id_F759(var_0, "use_informants_callout");
      break;
    case "intel":
    case "radar_drone_overwatch":
      level thread _id_F759(var_0, "use_intel_callout");
      break;
    case "uav":
      level thread _id_F759(var_0, "use_recon_callout");
      break;
    case "counter_spy_plane":
      level thread _id_F759(var_0, "use_crecon_callout");
      break;
    case "scrambler_drone_guard":
      level thread _id_F759(var_0, "use_killstreak_scramblerdrone");
      break;
    case "guard_dog":
      level thread _id_F759(var_0, "use_gdog_callout");
      break;
    case "attack_dogs":
      level thread _id_F759(var_0, "use_adog_callout");
      break;
    case "paratroopers":
      level thread _id_F759(var_0, "use_ptrooper_callout");
      break;
  }
}

_id_8DDC(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "ball_turret_gunner":
      break;
    case "chopper_gunner":
      break;
    case "pac_sentry":
      break;
    case "hover_jet":
      break;
    case "bradley":
      break;
    case "manual_turret":
      break;
    case "sentry_gun":
      break;
    case "uav":
      break;
    case "directional_uav":
      break;
    case "scrambler_drone_guard":
      break;
    case "radar_drone_escort":
      break;
  }
}

_id_8DCF(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "pac_sentry") {
    return;
  }
  if(scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_007")) {
    thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_007");
    return;
  } else
    thread _id_07A9::logevent_votriggered(self, "quiptrigger_007", "none");

  switch (var_0) {
    case "ball_turret_gunner":
      level thread _id_F759(self, "killfirm_gunship");
      break;
    case "chopper_gunner":
    case "chopper_support":
      level thread _id_F759(self, "killfirm_helo");
      break;
    case "death_switch":
      level thread _id_F759(self, "killfirm_bomber");
      break;
    case "pac_sentry":
      level thread _id_F759(self, "killfirm_wheelson");
      break;
    case "hover_jet":
      level thread _id_F759(self, "killfirm_ravager");
      break;
    case "juggernaut":
      level thread _id_F759(self, "killfirm_juggernaut");
      break;
    case "bradley":
      level thread _id_F759(self, "killfirm_cobalt");
      break;
    case "manual_turret":
      level thread _id_F759(self, "killfirm_shieldturret");
      break;
    case "sentry_gun":
      level thread _id_F759(self, "killfirm_sentry");
      break;
    case "cruise_predator":
      break;
    case "uav":
      level thread _id_F759(self, "killfirm_uav");
      break;
    case "directional_uav":
      level thread _id_F759(self, "killfirm_uav");
      break;
    case "scrambler_drone_guard":
      level thread _id_F759(self, "killfirm_scrambler");
      break;
    case "radar_drone_escort":
      level thread _id_F759(self, "killfirm_uav");
      break;
  }
}

_id_EBB0() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  var_0 = undefined;

  for(;;) {
    self waittill("begin_firing");
    thread _id_EBC4();
    thread _id_EBC2();
    self waittill("stoppedFiring");
  }
}

_id_EBC2() {
  thread _id_10864();
  self endon("begin_firing");
  self waittill("end_firing");
  wait 0.3;
  self notify("stoppedFiring");
}

_id_10864() {
  self endon("stoppedFiring");
  self waittill("begin_firing");
  thread _id_EBC2();
}

_id_EBC4() {
  self notify("suppressWaiter");
  self endon("suppressWaiter");
  self endon("death_or_disconnect");
  self endon("stoppedFiring");
  wait 1;
}

wallbreaktracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("wall_break");
    level thread _id_F759(self, "effort_sprint_wall");
  }
}

meleetracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("melee_fired");
    var_0 = self getcurrentweapon();

    if(var_0.basename == "s4_me_fists_mp") {
      continue;
    }
    if(isheavymeleeweapon(var_0)) {
      level thread _id_F759(self, "effort_melee_h");
      continue;
    }

    level thread _id_F759(self, "effort_melee_l");
  }
}

isheavymeleeweapon(var_0) {
  return var_0.basename == "s4_me_rindigo_mp";
}

_id_C31B() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();
    var_1 = scripts\mp\utility\weapon::weaponhasattachment(var_0, "akimbo");

    if(var_1) {
      var_2 = self getweaponammoclip(var_0, "right") + self getweaponammoclip(var_0, "left") + self getweaponammostock(var_0);
    } else {
      var_2 = self getweaponammoclip(var_0) + self getweaponammostock(var_0);
    }

    var_3 = istrue(var_0._id_0245) && (weaponclass(var_0) == "grenade" || weaponclass(var_0) == "spread");

    if(var_2 <= weaponclipsize(var_0) || var_1 && var_2 <= weaponclipsize(var_0) * 2) {
      var_4 = scripts\mp\utility\weapon::getweapongroup(var_0);
      var_5 = scripts\mp\utility\weapon::getweaponrootname(var_0) == "s4_ar_stango44" || var_3;

      if(!var_5) {
        var_6 = "last_mag_o";
        var_7 = scripts\mp\utility\game::_id_8A5F() && scripts\mp\utility\game::getgametype() == "br";

        if(var_7) {
          var_6 = "last_mag";
        }

        if(istrue(level _id_F759(self, var_6)) && var_7) {
          switch (var_4) {
            case "weapon_pistol":
            case "weapon_smg":
              level thread _id_F759(self, "last_mag_small");
              break;
            case "weapon_assault":
              level thread _id_F759(self, "last_mag_mid");
              break;
            case "weapon_lmg":
            case "weapon_dmr":
            case "weapon_sniper":
              level thread _id_F759(self, "last_mag_high");
              break;
            case "weapon_shotgun":
              level thread _id_F759(self, "last_mag_shotgun");
              break;
            case "weapon_projectile":
              level thread _id_F759(self, "last_mag_launcher");
              break;
          }
        }
      }

      continue;
    }

    _id_FF55();
    level thread _id_F759(self, "reload");
  }
}

_id_E463() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("sprint_begin");
  }
}

_id_F162(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = vectornormalize((var_1[0], var_1[1], var_0.origin[2]) - var_0.origin);
  var_3 = vectordot(anglesToForward(var_0.angles), var_2);
  var_4 = vectordot(anglestoright(var_0.angles), var_2);
  var_5 = _func_0002(var_3);

  if(var_4 < 0) {
    var_5 = 360 - var_5;
  }

  var_6 = "p12c";

  if(var_5 > 15 && var_5 <= 45) {
    var_6 = "p01c";
  } else if(var_5 > 45 && var_5 <= 75) {
    var_6 = "p02c";
  } else if(var_5 > 75 && var_5 <= 105) {
    var_6 = "p03c";
  } else if(var_5 > 105 && var_5 <= 135) {
    var_6 = "p04c";
  } else if(var_5 > 135 && var_5 <= 165) {
    var_6 = "p05c";
  } else if(var_5 > 165 && var_5 <= 195) {
    var_6 = "p06c";
  } else if(var_5 > 195 && var_5 <= 225) {
    var_6 = "p07c";
  } else if(var_5 > 225 && var_5 <= 255) {
    var_6 = "p08c";
  } else if(var_5 > 255 && var_5 <= 285) {
    var_6 = "p09c";
  } else if(var_5 > 285 && var_5 <= 315) {
    var_6 = "p10c";
  } else if(var_5 > 315 && var_5 <= 345) {
    var_6 = "p11c";
  } else {
    var_6 = "p12c";
  }

  return var_6;
}

_id_F161() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("enemy_sighted");

    if(_func_00BE("ui_prematch_period")) {
      level waittill("prematch_over");
      continue;
    }

    if(_id_CB08("ping_enemy_general_o") || _id_CB08("ping_enemy_infantry_o") || _id_CB08("ping_enemy_multiple_o")) {
      continue;
    }
    if(scripts\mp\utility\perk::_hasperk("specialty_no_battle_chatter") || istrue(self._id_2429)) {
      continue;
    }
    var_0 = self _meth_8177();

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = 0;
    var_2 = 4000000;
    var_3 = self playerads() > 0.7;

    if(var_3) {
      var_2 = 9000000;
    }

    var_4 = self getcurrentweapon() _meth_8624("torch", 1);

    if(var_4) {
      var_2 = var_2 * 2.25;
    }

    var_5 = _id_653D(self.team);
    var_6 = !isDefined(var_5) || var_5 + level._id_2430["timeout"]["callout_location"] < gettime();
    var_7 = 0;
    var_8 = anglesToForward(self.angles);

    foreach(var_10 in var_0) {
      var_11 = vectornormalize(var_10.origin - self.origin);
      var_12 = var_10 scripts\mp\utility\perk::_hasperk("specialty_coldblooded");
      var_13 = vectordot(var_8, var_11) > scripts\engine\utility::ter_op(var_3, scripts\engine\utility::ter_op(var_4, 0.965928, 0.984808), scripts\engine\utility::ter_op(var_4, 0.866025, 0.939692));
      var_14 = distancesquared(self.origin, var_10.origin) < var_2;

      if(!isDefined(var_10) || !scripts\mp\utility\player::isreallyalive(var_10) || var_12 || !var_14 || !var_13) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_10);
        continue;
      }

      if(scripts\mp\utility\game::getgametype() == "arena_evo" && isDefined(var_10)) {
        var_15 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(self.pers["team"]);

        if(!isDefined(var_15)) {
          break;
        }

        if(var_10.pers["team"] != var_15 || scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(var_10.pers["team"])) {
          var_0 = scripts\engine\utility::array_remove(var_0, var_10);
        }
      }
    }

    var_0 = scripts\engine\utility::_id_1BD1(var_0);
    var_1 = var_0.size;

    if(var_1 > 1) {
      var_17 = scripts\mp\utility\entity::_id_68F1(var_0);
      level thread _id_F759(self, "clock_callout", undefined, undefined, var_17);
      continue;
    }

    if(var_1 == 1) {
      level thread _id_F759(self, "clock_callout", undefined, undefined, var_0[0].origin);
      continue;
    }
  }
}

lionvohack(var_0, var_1) {
  switch (var_1) {
    case "wmac":
      var_2 = randomintrange(0, 3);

      if(var_2 == 0) {
        var_1 = "wmrr";
      } else if(var_2 == 1) {
        var_1 = "qp44";
      } else {
        var_1 = "qp55";
      }

      break;
    case "ftad":
    case "mgad":
      var_1 = "wmad";
      break;
    case "utp1":
    case "stu7":
      var_1 = "clay";
      break;
    case "usb1":
      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp51";
      }

      break;
    case "sat1":
      var_1 = "c4q4";
      break;
    case "skit":
      var_2 = randomintrange(0, 3);

      if(var_2 == 0) {
        var_1 = "skit";
      } else if(var_2 == 1) {
        var_1 = "skij";
      } else {
        var_1 = "srvg";
      }

      break;
    case "skos":
      var_2 = randomintrange(0, 3);

      if(var_2 == 0) {
        var_1 = "skos";
      } else if(var_2 == 1) {
        var_1 = "qp03";
      } else {
        var_1 = "qp06";
      }

      break;
    case "srvg":
      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp18";
      }

      break;
    case "spkl":
      var_2 = randomintrange(0, 3);

      if(var_2 == 0) {
        var_1 = "spkl";
      } else if(var_2 == 1) {
        var_1 = "qp12";
      } else {
        var_1 = "qp25";
      }

      break;
    case "scbk":
      if(scripts\engine\utility::cointoss()) {
        var_1 = "skfl";
      }

      break;
    case "brac":
      var_2 = randomintrange(0, 3);

      if(var_2 == 0) {
        var_1 = "brac";
      } else if(var_2 == 1) {
        var_1 = "qp36";
      } else {
        var_1 = "qp41";
      }

      break;
    case "sfkl":
      var_2 = randomintrange(0, 3);

      if(var_2 == 0) {
        var_1 = "sfkl";
      } else if(var_2 == 1) {
        var_1 = "qp10";
      } else {
        var_1 = "qp43";
      }

      break;
    case "skst":
      var_1 = "qp01";

      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp17";
      }

      break;
    case "sesx":
      var_1 = "qp02";

      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp37";
      }

      break;
    case "pepv":
      var_1 = "qp02";

      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp34";
      }

      break;
    case "gded":
      var_1 = "qp04";
      break;
    case "adto":
      var_1 = "qp05";

      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp40";
      }

      break;
    case "skml":
      var_1 = "qp07";

      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp32";
      }

      break;
    case "vwde":
      var_1 = "qp08";

      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp24";
      }

      break;
    case "ftac":
      var_1 = "qp09";
      break;
    case "mbac":
      var_1 = "qp11";
      break;
    case "sk10":
      var_1 = "qp13";
      break;
    case "mgac":
      var_1 = "qp15";

      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp19";
      }

      break;
    case "srac":
      var_1 = "qp16";
      break;
    case "ftki":
      var_1 = "qp20";
      break;
    case "gbac":
      var_1 = "qp21";
      break;
    case "adki":
    case "gdki":
      var_2 = randomintrange(0, 4);

      if(var_2 == 0) {
        var_1 = "qp23";
      } else if(var_2 == 1) {
        var_1 = "qp35";
      } else if(var_2 == 2) {
        var_1 = "qp42";
      } else {
        var_1 = "qp52";
      }

      break;
    case "sk15":
      var_1 = "qp26";
      break;
    case "ercd":
      var_2 = randomintrange(0, 3);

      if(var_2 == 0) {
        var_1 = "qp27";
      } else if(var_2 == 1) {
        var_1 = "qp28";
      } else {
        var_1 = "qp30";
      }

      break;
    case "erbd":
      var_1 = "qp28";

      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp30";
      }

      break;
    case "sk20":
      var_1 = "qp29";
      break;
    case "adkd":
    case "dogk":
      var_1 = "qp31";

      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp33";
      }

      break;
    case "eadk":
      var_1 = "qp38";
      break;
    case "sk25":
      var_1 = "qp39";
      break;
    case "btac":
      var_1 = "qp45";
      break;
    case "smk4":
      var_1 = "qp46";
      break;
    case "ptac":
      var_1 = "qp47";
      break;
    case "smk6":
      var_2 = randomintrange(0, 3);

      if(var_2 == 0) {
        var_1 = "qp48";
      } else if(var_2 == 1) {
        var_1 = "qp57";
      } else {
        var_1 = "qp59";
      }

      break;
    case "sk05":
      var_1 = "qp49";
      break;
    case "sk30":
      var_1 = "qp50";
      break;
    case "sem1":
      if(scripts\engine\utility::cointoss()) {
        var_1 = "qp53";
      }

      break;
    case "adac":
    case "gdac":
      var_1 = "qp54";
      break;
    default:
      break;
  }

  return var_1;
}

_id_4E7C(var_0, var_1, var_2) {
  var_3 = level._id_2459[var_0];

  if(!isDefined(self._id_AC3D) || !isDefined(self._id_AC3D._id_10691)) {
    return;
  }
  if(self._id_AC3D._id_10691 == "olin_lion") {
    var_3 = lionvohack(self._id_AC3D._id_10691, var_3);
  }

  var_4 = self._id_AC3D.voiceprefix;
  var_5 = self._id_AC3D.voiceprefix + "3d";
  var_6 = var_4 + "_" + self._id_AC3D._id_10691 + "_" + var_3;
  var_7 = var_5 + "_" + self._id_AC3D._id_10691 + "_" + var_3;
  var_8 = _func_0205(var_6);
  var_9 = _func_0205(var_7);
  var_10 = 0.0;
  var_11 = 0.0;
  dosounddebugprint(var_8, var_9, var_6, var_7);
  var_12 = splitoperatorvoiceid(self._id_AC3D._id_10691);
  var_13 = [var_4, var_12[0], var_12[1], var_3];
  var_14 = [var_5, var_12[0], var_12[1], var_3];

  if(!scripts\mp\utility\game::_id_98D3()) {
    _id_B369(var_8, var_9, var_0, var_13, var_14, var_2);
  } else if(self _meth_81E2()) {
    _id_B36A(var_8, var_9, var_0, var_13, var_14, var_2);
  } else {
    _id_B368(var_8, var_9, var_0, var_13, var_14, var_2);
  }

  if(isDefined(var_1)) {
    _id_96D0(var_1, self.team);
  }

  var_15 = level._id_2430["priority"][var_0];
  var_16 = self.team;
  level _id_1138(self, var_16, var_7, var_0, var_15);
  _id_FC2A(var_0);
  var_17 = max(var_11, var_10) / 1000;
  thread _id_F211(var_7, var_17);
  scripts\engine\utility::waittill_any_2(var_7, "death_or_disconnect");
  level _id_C529(self, var_16, var_7, 0);
  return 1;
}

dosounddebugprint(var_0, var_1, var_2, var_3) {
  if(!var_1) {} else
    var_4 = _func_0142(var_3);

  if(!var_0) {
    return;
  }
  var_5 = _func_0142(var_2);
  return;
}

_id_B368(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_1) {
    if(level._id_2430["play_for_all"][var_2]) {
      foreach(var_7 in level._id_EF89) {
        if(var_7 == self.team) {
          if(var_0 || !level._id_2430["play_to_self"][var_2]) {
            doplaysoundtoteam(var_4, var_7, self);
          } else {
            doplaysoundtoteam(var_4, var_7);
          }

          continue;
        }

        if(scripts\mp\utility\game::getgametype() == "arena_evo" && var_7 != scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(self.pers["team"])) {
          continue;
        }
        doplaysoundtoteam(var_4, var_7);
      }
    } else if(level._id_2430["play_for_squad_only"][var_2] && isDefined(level._id_E48E)) {
      if(isDefined(self.team) && isDefined(self._id_E496) && isDefined(level._id_E48E[self.team][self._id_E496])) {
        var_9 = level._id_E48E[self.team][self._id_E496].players;

        foreach(var_11 in var_9) {
          if(istrue(var_11._id_7262)) {
            continue;
          }
          if(var_11 == self) {
            if(!istrue(var_0 && level._id_2430["play_to_self"][var_2])) {
              doplaysoundtoplayer(var_4, self);
            }

            continue;
          }

          if(var_2 == "clock_callout" && isDefined(var_5)) {
            var_12 = _id_F162(var_11, var_5);
            var_4[var_4.size - 1] = var_12;
          }

          var_11 doplaysoundtoplayer(var_4, var_11);
        }
      }
    } else if(var_0 || !level._id_2430["play_to_self"][var_2])
      doplaysoundtoteam(var_4, self.team, self);
    else {
      doplaysoundtoteam(var_4, self.team);
    }
  }

  if(var_0 && level._id_2430["play_to_self"][var_2]) {
    doplaysoundtoplayer(var_3, self);
  }
}

_id_B369(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(var_0 || !level._id_2430["play_to_self"][var_2]) {
    var_6[var_6.size] = self;

    if(self _meth_81E2()) {
      var_7 = self _meth_81E4();
      var_6[var_6.size] = var_7;
    }
  }

  if(var_1) {
    if(level._id_2430["play_for_all"][var_2]) {
      foreach(var_9 in level._id_EF89) {
        var_10 = level._id_EF6A[var_9]["players"];

        foreach(var_12 in var_10) {
          if(var_12 _meth_81E2()) {
            var_7 = var_12 _meth_81E4();

            if(!scripts\engine\utility::array_contains(var_6, var_12) && !scripts\engine\utility::array_contains(var_6, var_7)) {
              var_6[var_6.size] = var_12;
            }
          }

          if(scripts\mp\utility\game::getgametype() == "arena_evo" && var_9 != scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(self.pers["team"])) {
            if(!scripts\engine\utility::array_contains(var_6, var_12)) {
              var_6[var_6.size] = var_12;
            }
          }

          if(!scripts\engine\utility::array_contains(var_6, var_12)) {
            doplaysoundtoplayer(var_4, var_12);
          }
        }
      }
    } else {
      var_10 = level._id_EF6A[self.team]["players"];

      foreach(var_12 in var_10) {
        if(var_12 _meth_81E2()) {
          var_7 = var_12 _meth_81E4();

          if(!scripts\engine\utility::array_contains(var_6, var_12) && !scripts\engine\utility::array_contains(var_6, var_7)) {
            var_6[var_6.size] = var_12;
          }
        }

        if(istrue(var_12._id_7262) && !scripts\engine\utility::array_contains(var_6, var_12)) {
          var_6[var_6.size] = var_12;
        }
      }

      foreach(var_12 in var_10) {
        if(!scripts\engine\utility::array_contains(var_6, var_12)) {
          if(var_2 == "clock_callout" && isDefined(var_5)) {
            var_18 = _id_F162(var_12, var_5);
            var_4[var_4.size - 1] = var_18;
          }

          doplaysoundtoplayer(var_4, var_12);
        }
      }
    }
  }

  if(var_0 && level._id_2430["play_to_self"][var_2]) {
    doplaysoundtoplayer(var_3, self);
  }
}

_id_B36A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self _meth_81E4();
  var_7 = [var_6];

  if(var_0 || !level._id_2430["play_to_self"][var_2]) {
    var_7[var_7.size] = self;
  }

  if(var_1) {
    if(level._id_2430["play_for_all"][var_2]) {
      foreach(var_9 in level._id_EF89) {
        if(var_9 == self.team) {
          var_10 = level._id_EF6A[self.team]["players"];

          foreach(var_12 in var_10) {
            if(!scripts\engine\utility::array_contains(var_7, var_12)) {
              doplaysoundtoplayer(var_4, var_12);
            }
          }

          continue;
        }

        if(scripts\mp\utility\game::getgametype() == "arena_evo" && var_9 != scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(self.pers["team"])) {
          continue;
        }
        doplaysoundtoteam(var_4, var_9);
      }
    } else {
      var_10 = level._id_EF6A[self.team]["players"];

      foreach(var_12 in var_10) {
        if(!scripts\engine\utility::array_contains(var_7, var_12)) {
          if(var_2 == "clock_callout" && isDefined(var_5)) {
            var_16 = _id_F162(var_12, var_5);
            var_4[var_4.size - 1] = var_16;
          }

          doplaysoundtoplayer(var_4, var_12);
        }
      }
    }
  }

  if(var_0 && level._id_2430["play_to_self"][var_2]) {
    doplaysoundtoplayer(var_3, self);
  }
}

_id_8DA0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");
  var_7 = 0.0;

  if(var_4) {
    var_7 = _func_0142(var_3) / 1000;
  }

  if(var_6) {
    var_7 = max(var_7, _func_0142(var_5) / 1000);
  }

  var_8 = scripts\engine\utility::_id_108F7("death", var_7);

  if(isDefined(var_8) && var_8 == "timeout") {
    return;
  }
  if(level._id_2430["play_for_all"][var_1]) {
    foreach(var_10 in level._id_EF89) {
      if(var_10 == var_0) {
        if(var_2) {
          doplaysoundtoteam("iw8_mp_kill_bc_radio", var_10);
        } else {
          doplaysoundtoteam("iw8_mp_kill_bc", var_10);
        }

        continue;
      }

      doplaysoundtoteam("iw8_mp_kill_bc", var_10);
    }
  } else if(var_2)
    doplaysoundtoteam("iw8_mp_kill_bc_radio", var_0);
  else {
    doplaysoundtoteam("iw8_mp_kill_bc", var_0);
  }

  if(var_6) {
    doplaysoundtoplayer("iw8_mp_kill_bc", self);
  }
}

_id_4E85(var_0, var_1) {
  var_2 = scripts\engine\utility::_id_10897(var_0, "death_or_disconnect");

  if(isDefined(var_2) && var_2 == var_0) {
    var_3 = self.team;
    var_4 = self.origin;
    wait 0.5;
    var_5 = scripts\mp\utility\teams::_id_6A59(var_3, 1);

    foreach(var_7 in var_5) {
      if(!isDefined(var_7)) {
        continue;
      }
      if(var_7 == self) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_7)) {
        continue;
      }
      if(var_7.team != var_3) {
        continue;
      }
      if(isagent(var_7)) {
        continue;
      }
      if(self._id_AC3D._id_10691 != var_7._id_AC3D._id_10691 && distancesquared(var_4, var_7.origin) <= 262144 && !_id_8A4A(var_7)) {
        var_8 = _id_6AC1(var_7);
        var_9 = var_7._id_AC3D.voiceprefix + "3d" + var_7._id_AC3D._id_10691 + "_loc_" + var_1 + "_echo";

        if(_func_0205(var_9) && scripts\engine\utility::cointoss()) {
          var_10 = var_9;
        } else {
          var_10 = undefined;
        }

        if(isDefined(var_10)) {
          var_7 thread _id_4E7C(var_10, 0, 1);
        }

        break;
      }
    }
  }
}

_id_F211(var_0, var_1) {
  self endon("death_or_disconnect");
  wait(var_1);
  self notify(var_0);
}

_id_8A4A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1000;
  }

  var_2 = var_1 * var_1;

  if(isDefined(var_0) && isDefined(var_0.team) && var_0.team != "spectator") {
    for(var_3 = 0; var_3 < level._id_E3B0[var_0.team].size; var_3++) {
      var_4 = level._id_E3B0[var_0.team][var_3]["player"];

      if(var_4 == var_0) {
        return 1;
      }

      if(!isDefined(var_4)) {
        continue;
      }
      if(distancesquared(var_4.origin, var_0.origin) < var_2) {
        return 1;
      }
    }
  }

  return 0;
}

_id_1138(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level._id_E3B0[var_1].size;
  level._id_E3B0[var_1][var_5] = [];
  level._id_E3B0[var_1][var_5]["player"] = var_0;
  level._id_E3B0[var_1][var_5]["sound_alias"] = var_2;
  level._id_E3B0[var_1][var_5]["sound_type"] = var_3;
  level._id_E3B0[var_1][var_5]["priority"] = var_4;
}

_id_C529(var_0, var_1, var_2, var_3) {
  var_4 = [];

  for(var_5 = 0; var_5 < level._id_E3B0[var_1].size; var_5++) {
    if(istrue(var_3)) {
      if(isDefined(var_0) && isDefined(level._id_E3B0[var_1][var_5]["player"]) && level._id_E3B0[var_1][var_5]["player"] == var_0) {
        continue;
      }
    } else if(isDefined(var_0) && isDefined(level._id_E3B0[var_1][var_5]["player"]) && level._id_E3B0[var_1][var_5]["player"] == var_0) {
      if(isDefined(var_2) && isDefined(level._id_E3B0[var_1][var_5]["sound_alias"]) && level._id_E3B0[var_1][var_5]["sound_alias"] == var_2) {
        continue;
      }
    }

    var_4[var_4.size] = level._id_E3B0[var_1][var_5];
  }

  level._id_E3B0[var_1] = var_4;
}

_id_4A81(var_0) {
  var_0._id_2429 = 1;
}

_id_523A(var_0) {
  var_0._id_2429 = undefined;
}

_id_FC2A(var_0) {
  var_1 = gettime();
  self._id_2431[var_0] = var_1;

  if(!isDefined(level._id_2430["last_say_time"][var_0])) {
    level._id_2430["last_say_time"][var_0] = [];
  }

  if(!isDefined(level._id_2430["last_say_pos"][var_0])) {
    level._id_2430["last_say_pos"][var_0] = [];
  }

  level._id_2430["last_say_time"][var_0][self._id_AC3D._id_10691] = var_1;
  level._id_2430["last_say_pos"][var_0][self._id_AC3D._id_10691] = self.origin;
  _id_388D(var_1);
}

_id_388D(var_0) {
  var_1 = [];

  foreach(var_5, var_3 in self._id_2431) {
    var_4 = level._id_2430["timeout_player"][var_5] + var_3;

    if(var_0 < var_4) {
      var_1[var_5] = var_3;
    }
  }

  self._id_2431 = var_1;
  var_1 = [];
  var_6 = [];

  foreach(var_5, var_8 in level._id_2430["last_say_time"]) {
    var_1[var_5] = [];
    var_6[var_5] = [];

    foreach(var_10, var_3 in var_8) {
      if(var_0 < var_3 + level._id_2430["timeout"][var_5]) {
        var_1[var_5][var_10] = var_3;
        var_6[var_5][var_10] = level._id_2430["last_say_pos"][var_5][var_10];
      }
    }
  }

  level._id_2430["last_say_time"] = var_1;
  level._id_2430["last_say_pos"] = var_6;
}

_id_6E2F(var_0) {
  var_1 = _id_6335();
  var_1 = scripts\engine\utility::array_randomize(var_1);

  if(var_1.size) {
    foreach(var_3 in var_1) {
      if(!_id_96D1(var_3) && var_0 _id_3150(var_3)) {
        return var_3;
      }
    }

    foreach(var_3 in var_1) {
      if(!_id_96D2(var_3) && var_0 _id_3150(var_3)) {
        return var_3;
      }
    }
  }

  return undefined;
}

_id_6335() {
  var_0 = anim._id_2447;
  var_1 = self _meth_813D(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_96D6)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_96D1(var_0) {
  var_1 = _id_96D3(var_0._id_96D6[0]);

  if(!isDefined(var_1)) {
    return 0;
  }

  return 1;
}

_id_96D2(var_0) {
  var_1 = _id_96D3(var_0._id_96D6[0]);

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = var_1 + 25000;

  if(gettime() < var_2) {
    return 1;
  }

  return 0;
}

_id_96D0(var_0, var_1) {
  var_2 = gettime();
  anim._id_96D9[var_0] = var_2;

  if(!isDefined(level._id_9009)) {
    level._id_9009 = [];
  }

  level._id_9009[var_1] = var_2;
}

_id_96D3(var_0) {
  if(isDefined(anim._id_96D9[var_0])) {
    return anim._id_96D9[var_0];
  }

  return undefined;
}

_id_653D(var_0) {
  if(isDefined(level._id_9009) && isDefined(level._id_9009[var_0])) {
    return level._id_9009[var_0];
  }

  return undefined;
}

_id_3150(var_0) {
  foreach(var_2 in var_0._id_96D6) {
    var_3 = _id_6B1E(var_2);
    var_4 = _func_0205(var_3);

    if(var_4) {
      return var_4;
    }
  }

  return 0;
}

_id_3169(var_0) {
  var_1 = var_0._id_96D6;

  foreach(var_3 in var_1) {
    if(_id_879F(var_3, self)) {
      return 1;
    }
  }

  return 0;
}

_id_6947(var_0) {
  var_1 = undefined;
  var_2 = self._id_96D6;

  foreach(var_4 in var_2) {
    if(_id_87A0(var_4, var_0) && !isDefined(self._id_BE90)) {
      var_1 = var_4;
      break;
    }

    if(_id_87A1(var_4)) {
      var_1 = var_4;
    }
  }

  return var_1;
}

_id_87A1(var_0) {
  return issubstr(var_0, "_report");
}

_id_879F(var_0, var_1) {
  var_2 = var_1 _id_6B1E("concat_loc_" + var_0);

  if(_func_0205(var_2)) {
    return 1;
  }

  return 0;
}

_id_87A0(var_0, var_1) {
  if(issubstr(var_0, "_qa") && _func_0205(var_0)) {
    return 1;
  }

  var_2 = var_1 _id_6C92(var_0, 0);

  if(_func_0205(var_2)) {
    return 1;
  }

  return 0;
}

_id_6B1E(var_0) {
  var_1 = "dx_mpo_" + scripts\engine\utility::ter_op(self.team == "allies", "usop", "ruop") + "_loc_enemy_" + var_0;
  return var_1;
}

_id_6C92(var_0, var_1) {
  var_2 = _id_6B1E(var_0);
  var_2 = var_2 + ("_qa" + var_1);
  return var_2;
}

_id_235D() {
  return 0;
}

_id_235E() {
  return 0;
}

_id_2370(var_0, var_1) {}

_id_2371(var_0) {}

_id_2362(var_0, var_1) {}

_id_689F(var_0) {}

_id_2372(var_0, var_1, var_2) {}

_id_5F94(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 262144;
  }

  var_1 = scripts\mp\utility\teams::_id_6A59(self.team, 1);

  foreach(var_3 in var_1) {
    if(var_3 != self && distancesquared(var_3.origin, self.origin) <= var_0) {
      return 1;
    }
  }

  return 0;
}

_id_D8AE() {
  level._id_D08E = [];
  level._id_D08E["plr_killfirm_c6"] = "kill_rig";
  level._id_D08E["plr_killfirm_ftl"] = "kill_rig";
  level._id_D08E["plr_killfirm_ghost"] = "kill_rig";
  level._id_D08E["plr_killfirm_merc"] = "kill_rig";
  level._id_D08E["plr_killfirm_stryker"] = "kill_rig";
  level._id_D08E["plr_killfirm_warfighter"] = "kill_rig";
  level._id_D08E["plr_killfirm_generic"] = "kill_gen";
  level._id_D08E["plr_killfirm_amf"] = "kill_amf";
  level._id_D08E["plr_killfirm_headshot"] = "kill_headshot";
  level._id_D08E["plr_killfirm_grenade"] = "kill_grenade";
  level._id_D08E["plr_killfirm_rival"] = "kill_rival";
  level._id_D08E["plr_killfirm_semtex"] = "kill_semtex";
  level._id_D08E["plr_killfirm_multi"] = "kill_multi";
  level._id_D08E["plr_killfirm_twofer"] = "kill_twofer";
  level._id_D08E["plr_killfirm_threefer"] = "kill_threefer";
  level._id_D08E["plr_killfirm_killstreak"] = "kill_ss";
  level._id_D08E["plr_killstreak_destroy"] = "kill_other_ss";
  level._id_D08E["plr_killstreak_target"] = "targeted_by_ss";
  level._id_D08E["plr_hit_back"] = "dmg_back";
  level._id_D08E["plr_damaged_light"] = "dmg_light";
  level._id_D08E["plr_damaged_heavy"] = "dmg_heavy";
  level._id_D08E["plr_damaged_emp"] = "dmg_emp";
  level._id_D08E["plr_healing"] = "healing";
  level._id_D08E["plr_kd_high"] = "kd_high";
  level._id_D08E["plr_firefight"] = "firefight";
  level._id_D08E["plr_target_generic"] = "enemy_sighted";
  level._id_D08E["plr_perk_super"] = "super_activate";
  level._id_D08E["plr_perk_trophy"] = "super_activate";
  level._id_D08E["plr_perk_turret"] = "super_activate";
  level._id_D08E["plr_perk_amplify"] = "super_activate";
  level._id_D08E["plr_perk_overdrive"] = "super_activate";
  level._id_D08E["plr_perk_ftl"] = "super_activate";
  level._id_D08E["plr_perk_pulse"] = "super_activate";
  level._id_D08E["plr_perk_rewind"] = "super_activate";
  level._id_D08E["plr_perk_super_kill"] = "super_kill";
  level._id_D08E["plr_perk_trophy_block"] = "super_kill";
  level._id_D08E["plr_perk_turret_kill"] = "super_kill";
  level._id_D08E["plr_killfirm_shift"] = "super_kill";
  level._id_D08E["plr_perk_railgun"] = "super_kill";
  level._id_D08E["plr_perk_stealth"] = "super_kill";
  level._id_D08E["plr_perk_armor"] = "super_kill";
  level._id_D08E["plr_perk_charge"] = "super_kill";
  level._id_D08E["plr_perk_dragon"] = "super_kill";
  level._id_D08E["plr_perk_pound"] = "super_kill";
  level._id_D08E["plr_perk_reaper"] = "super_kill";
  level._id_D08D = [];
  _id_D6C3("kill_rig", 15, 0.3, 0.25);
  _id_D6C3("kill_gen", 30, 0.1, 0.25);
  _id_D6C3("kill_amf", 15, 0.5, 0.5);
  _id_D6C3("kill_headshot", 15, 0.7, 0.25);
  _id_D6C3("kill_grenade", 15, 0.5, 0.25);
  _id_D6C3("kill_rival", 15, 0.7, 0.25);
  _id_D6C3("kill_semtex", 15, 0.5, 0.25);
  _id_D6C3("kill_multi", 20, 0.6, 0.25);
  _id_D6C3("kill_twofer", 10, 0.7, 0.75);
  _id_D6C3("kill_threefer", 10, 0.8, 0.75);
  _id_D6C3("kill_ss", 10, 0.5, 0.2);
  _id_D6C3("kill_other_ss", 10, 0.7, 0.75);
  _id_D6C3("targeted_by_ss", 10, 0.4, 0.33);
  _id_D6C3("dmg_back", 20, 0.5, 0.5);
  _id_D6C3("dmg_light", 20, 0.4, 0.1);
  _id_D6C3("dmg_heavy", 20, 0.5, 0.2);
  _id_D6C3("healing", 10, 0.3, 0.1);
  _id_D6C3("kd_high", 20, 0.7, 0.8);
  _id_D6C3("enemy_sighted", 20, 0.2, 0.25);
  _id_D6C3("firefight", 10, 0.4, 0.33);
  _id_D6C3("super_activate", 10, 1.0, 1.0);
  _id_D6C3("super_kill", 10, 0.9, 0.66);
}

_id_D6C3(var_0, var_1, var_2, var_3) {
  level._id_D08D[var_0]["timeout"] = var_1;
  level._id_D08D[var_0]["priority"] = var_2;
  level._id_D08D[var_0]["chance"] = var_3;
}

_id_CB70(var_0, var_1, var_2, var_3) {
  if(1) {
    return;
  }
  if(isagent(var_0) || !isPlayer(var_0)) {
    return;
  }
  if(istrue(var_0._id_2429)) {
    return;
  }
  var_4 = _id_6AC1(var_0);
  var_5 = "";

  if(isDefined(var_0._id_AC3D) && isDefined(var_0._id_AC3D._id_10691) && isDefined(var_1)) {
    var_5 = var_0._id_AC3D.voiceprefix + "3d" + var_0._id_AC3D._id_10691 + "_" + var_1;
  }

  if(!isDefined(var_1) || !_func_0205(var_5)) {
    if(!isDefined(var_2)) {
      return;
    }
    var_1 = var_2;
    var_5 = var_0._id_AC3D.voiceprefix + "3d" + var_0._id_AC3D._id_10691 + "_" + var_1;

    if(!_func_0205(var_5)) {
      return;
    }
  }

  if(!isDefined(var_0._id_D08C)) {
    var_0._id_D08C = [];
    var_0._id_B866 = 0;
    var_0._id_BED2 = "none";
  }

  if(isDefined(var_0._id_D08C[level._id_D08E[var_1]]) && var_0._id_D08C[level._id_D08E[var_1]] > 0) {
    return;
  }
  if(!isDefined(var_0.pers["selfVOBonusChance"])) {
    var_0 thread _id_FD21();
  }

  if(randomfloat(1.0) > level._id_D08D[level._id_D08E[var_1]]["chance"] + var_0.pers["selfVOBonusChance"]) {
    return;
  }
  var_0 thread _id_F75C(var_1, var_3);
}

_id_FD21() {
  self endon("disconnect");
  level endon("game_ended");
  self.pers["selfVOBonusChance"] = 0;

  if(!scripts\mp\utility\game::_id_CA4B()) {
    for(;;) {
      self.pers["selfVOBonusChance"] = self.pers["selfVOBonusChance"] + 0.1;
      wait 3.0;
    }
  } else if(scripts\mp\utility\game::getgametype() == "br")
    self.pers["selfVOBonusChance"] = 0.25;
}

_id_F75C(var_0, var_1) {
  self endon("death_or_disconnect");

  if(self._id_BED2 == var_0) {
    return;
  }
  if(self._id_BED2 == "none" || level._id_D08D[level._id_D08E[self._id_BED2]]["priority"] < level._id_D08D[level._id_D08E[var_0]]["priority"] || level._id_D08D[level._id_D08E[self._id_BED2]]["priority"] == level._id_D08D[level._id_D08E[var_0]]["priority"] && scripts\engine\utility::cointoss()) {
    self._id_BED2 = var_0;
  } else {
    return;
  }

  self notify("addToSelfVOQueue");
  self endon("addToSelfVOQueue");
  self._id_D08B = 1;

  if(isDefined(var_1)) {
    thread _id_D08A(var_1);
  }

  var_2 = _id_6C8E(var_0);
  var_3 = gettime();

  while(self._id_B866 || !self._id_D08B || var_2 > gettime()) {
    if(gettime() > var_3 + 2000) {
      self._id_BED2 = "none";
      return;
    }

    wait 0.05;
  }

  waitframe();
  thread _id_B8D3(var_0);
}

_id_6C8E(var_0) {
  if(!isDefined(self._id_903E)) {
    self._id_903E = 0;
  }

  return self._id_903E + 2000 + 10000 * (1.0 - level._id_D08D[level._id_D08E[var_0]]["priority"]);
}

_id_D08A(var_0) {
  self endon("death_or_disconnect");
  self endon("addToSelfVOQueue");
  self._id_D08B = 0;
  wait(var_0);
  self._id_D08B = 1;
}

_id_B8D3(var_0) {
  self endon("death_or_disconnect");
  var_1 = _id_6AC1(self);
  var_2 = self._id_AC3D.voiceprefix + "3d" + self._id_AC3D._id_10691 + "_" + var_0;
  self.pers["selfVOBonusChance"] = 0;
  self._id_BED2 = "none";
  var_3 = _func_0142(var_2) / 1000;
  self._id_903E = gettime();
  thread _id_B867(var_3);
  thread _id_FD22(var_0);
  doplaysoundtoplayer(var_2, self);
}

_id_B867(var_0) {
  self endon("disconnect");
  self._id_B866 = 1;
  wait(var_0);
  self._id_B866 = 0;
}

_id_FD22(var_0) {
  self endon("disconnect");
  self._id_D08C[level._id_D08E[var_0]] = gettime();
  wait(level._id_D08D[level._id_D08E[var_0]]["timeout"]);
  self._id_D08C[level._id_D08E[var_0]] = 0;
}

_id_6AC1(var_0) {
  var_2 = scripts\mp\utility\game::_id_6DE7();
  var_3 = var_0 _id_6907();

  if(var_3 > 5000 || var_2 >= 80 || scripts\mp\utility\game::_id_82D1()) {
    return "high";
  } else {
    return "mid";
  }
}

_id_115F(var_0, var_1, var_2) {
  if(!isDefined(self._id_2380)) {
    self._id_2380 = [];
  }

  var_3 = spawnStruct();
  var_3._id_F1E8 = gettime();
  var_3._id_04CB = var_1;
  var_3._id_7D14 = var_3._id_F1E8 + var_2 * 1000;
  self._id_2380[self._id_2380.size] = var_3;
}

_id_6907() {
  if(!isDefined(self._id_2380)) {
    return 0;
  }

  var_0 = [];
  var_1 = 0;
  var_2 = gettime();

  foreach(var_4 in self._id_2380) {
    if(var_2 < var_4._id_7D14) {
      var_1 = var_1 + var_4._id_04CB;
      var_0[var_0.size] = var_4;
    }
  }

  self._id_2380 = var_0;
  self._id_023B = var_1;
  return var_1;
}

_id_F0E6(var_0, var_1) {
  var_2 = scripts\common\utility::_id_B7C7(var_0.origin, 4000);

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\player::isreallyalive(var_4)) {
      continue;
    }
    var_5 = max(scripts\engine\utility::_id_4B8C(var_0.origin, var_4.origin), 1.0);

    if(scripts\mp\utility\weapon::_id_879A(var_1.basename) || scripts\mp\utility\weapon::_id_879C(var_1.basename)) {
      var_6 = 0;
      var_7 = scripts\mp\utility\weapon::getweapongroup(var_1.basename);

      switch (var_7) {
        case "weapon_smg":
          var_6 = 50;
          break;
        case "weapon_assault":
          var_6 = 60;
          break;
        case "weapon_sniper":
          var_6 = 90;
          break;
        case "weapon_dmr":
          var_6 = 70;
          break;
        case "weapon_lmg":
          var_6 = 80;
          break;
        case "weapon_shotgun":
          var_6 = 80;
          break;
        case "weapon_projectile":
          var_6 = 70;
          break;
        case "weapon_pistol":
          var_6 = 40;
          break;
        case "weapon_machine_pistol":
          var_6 = 50;
          break;
        default:
          break;
      }

      if(var_6 == 0) {
        continue;
      }
      if(scripts\mp\utility\weapon::weaponhasattachment(var_1, "silencer")) {
        var_6 = var_6 * 0.25;
      }

      if(var_5 < 10000) {
        var_8 = 5.0;
      } else if(var_5 < 250000) {
        var_8 = 3.0;
      } else if(var_5 < 1000000) {
        var_8 = 2.0;
      } else if(var_5 < 4000000) {
        var_8 = 0.5;
      } else if(var_5 < 9000000) {
        var_8 = 0.25;
      } else {
        var_8 = 0.1;
      }

      var_9 = 1.0 - var_5 / 16000000;
      var_8 = var_8 * var_9;
      var_6 = var_6 * var_8;
      var_4 _id_115F("weaponFired", int(var_6), 3.0);
    }
  }
}

_id_10A3(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_1) && isDefined(var_0)) {
    var_4 = scripts\mp\utility\weapon::getweapongroup(var_1);

    if(var_4 == "weapon_sniper" || var_4 == "weapon_dmr") {
      if(distance2d(self.origin, var_0.origin) > 2250000) {
        var_3 = 1;
      }
    }
  }

  if(var_3) {
    level thread _id_F759(self, "damage_long", undefined, 0.75);
  } else {
    level thread _id_F759(self, "damage", undefined, 0.75);
  }
}

_id_AB9B() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\game::_id_98D3()) {
    return;
  }
  _id_07D1::_id_60C2("prematch_done");
  wait 5;

  for(;;) {
    if(!_id_CB08("inform_on_your_six_o") && !scripts\mp\s4_quips_mp::quippedtoorecently(scripts\mp\s4_quips_mp::getquipid("quiptrigger_015"))) {
      var_0 = scripts\mp\utility\teams::_id_6A59(self.team, 1);

      foreach(var_2 in var_0) {
        if(var_2 == self) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(var_2)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(self)) {
          continue;
        }
        if(_id_FF4A(self, var_2)) {
          if(var_2 _meth_8743() == self _meth_8743()) {
            thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_015");
          } else {
            level thread _id_F759(self, "inform_on_your_six_o");
          }

          break;
        }
      }
    }

    wait 3;
  }
}

_id_FF4A(var_0, var_1) {
  var_2 = 0.05;
  var_3 = var_1 _id_6B12();
  var_4 = var_0 _id_6D62();
  var_5 = distancesquared(var_4, var_3);

  if(var_5 > 90000) {
    return 0;
  }

  var_6 = var_1 _id_6B11();
  var_7 = vectornormalize(var_4 - var_3);
  var_8 = vectordot(var_6, var_7);

  if(var_8 < var_2) {
    var_9 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
    var_10 = physics_createcontents(var_9);
    var_11 = scripts\engine\trace::ray_trace(var_4, var_3, var_0, var_10);

    if(isDefined(var_11["entity"]) && isPlayer(var_11["entity"]) || var_11["fraction"] > 0.8) {
      return 1;
    }
  }

  return 0;
}

_id_6D62() {
  return self getEye();
}

_id_6B12() {
  return self getEye();
}

_id_6B11() {
  return anglesToForward(self getplayerangles());
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

_id_34E9() {
  var_0 = scripts\mp\utility\teams::_id_6A59(self.team, 1);

  foreach(var_2 in var_0) {
    if(var_2 == self) {
      continue;
    }
    if(distancesquared(self.origin, var_2.origin) <= 262144) {
      var_3 = anglesToForward(var_2 getplayerangles());

      if(length(var_2.origin - self.origin) > 0) {
        if(scripts\engine\math::_id_178B(var_3, var_2.origin - self.origin) < 80) {
          break;
        }
      }
    }
  }
}

_id_6D3D() {}

_id_F759(var_0, var_1, var_2, var_3, var_4) {
  if(!istrue(level._id_237F)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  if(istrue(var_0._id_2429)) {
    return;
  }
  if(!isDefined(var_0._id_2431)) {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(var_0) && level._id_2430["requires_alive"][var_1]) {
    return;
  }
  if(var_0.team == "spectator") {
    return;
  }
  if(var_0.team == "follower") {
    return;
  }
  if(!isDefined(level._id_2459[var_1])) {
    return;
  }
  if(istrue(var_0._id_8A4C)) {
    return;
  }
  if(var_0 scripts\mp\utility\player::_id_8ACE()) {
    return;
  }
  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_no_battle_chatter")) {
    return;
  }
  if(var_1 == "inform_last_one") {
    switch (var_0._id_AC3D._id_10691) {
      case "ukft1":
      case "ruft1":
        return;
    }
  }

  if(level._id_2430["req_friendly"][var_1] && !var_0 _id_5F94(1000000) && !istrue(level._id_2AA3) && scripts\mp\utility\game::getgametype() != "dm") {
    return;
  }
  if(randomfloat(1) > level._id_2430["chance"][var_1]) {
    return;
  }
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_5 = var_0 _id_6909(var_1, var_3);

  if(var_5 > level._id_2430["max_wait_time"] + var_3 * 1000) {
    return;
  }
  if(_id_3B02(var_1, var_0._id_2432)) {
    var_0._id_2432 = var_1;
  } else {
    return;
  }

  level notify("kill_queued_bc_sound_" + var_0.name);
  return var_0 _id_CB6E(var_5, var_1, var_2, var_3, var_4);
}

_id_CB6E(var_0, var_1, var_2, var_3, var_4) {
  level endon("kill_queued_bc_sound_" + self.name);
  self endon("death_or_disconnect");
  wait(var_0 / 1000);

  if(_id_CB08(var_1)) {
    return;
  }
  while(var_0 <= level._id_2430["max_wait_time"] + var_3 * 1000) {
    var_5 = _id_6D61(self, level._id_2430["priority"][var_1]);

    if(isDefined(var_5["higher"])) {
      var_6 = gettime();
      var_5["higher"]["player"] scripts\engine\utility::waittill_any_3(var_5["higher"]["sound_alias"], "death", "disconnect");
      waitframe();
      var_0 = var_0 + (gettime() - var_6);
      continue;
    }

    var_7 = var_5["lower"];

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(isDefined(var_7[var_8]["player"])) {
        var_7[var_8]["player"] notify(var_7[var_8]["sound_alias"] + "_interrupt");

        if(_func_0205(var_7[var_8]["sound_alias"])) {
          var_7[var_8]["player"] _meth_83EF(var_7[var_8]["sound_alias"]);
        }
      }
    }

    break;
  }

  if(var_0 > level._id_2430["max_wait_time"] + var_3 * 1000) {
    self._id_2432 = "none";
    return;
  } else {
    self._id_2432 = "none";
    return thread _id_4E7C(var_1, var_2, var_4);
  }
}

_id_6909(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = 0;
  var_3 = 0;

  if(isDefined(level._id_2430["last_say_time"]) && isDefined(level._id_2430["last_say_time"][var_0])) {
    if(var_0 == "ping_enemy_general_o" || var_0 == "ping_enemy_infantry_o" || var_0 == "ping_enemy_multiple_o") {
      var_4 = [];
      var_4[var_4.size] = "ping_enemy_general_o";
      var_4[var_4.size] = "ping_enemy_infantry_o";
      var_4[var_4.size] = "ping_enemy_multiple_o";

      foreach(var_6 in var_4) {
        if(!isDefined(level._id_2430["last_say_pos"][var_6])) {
          continue;
        }
        foreach(var_10, var_8 in level._id_2430["last_say_pos"][var_6]) {
          if(distancesquared(var_8, self.origin) < 4000000) {
            var_9 = level._id_2430["last_say_time"][var_6][var_10] + level._id_2430["timeout"][var_6];

            if(var_9 > var_2) {
              var_2 = var_9;
            }

            var_3 = 1;
          }
        }

        if(var_3) {
          break;
        }
      }
    } else if(var_0 == "inform_on_your_six_o") {
      foreach(var_10, var_8 in level._id_2430["last_say_pos"][var_0]) {
        if(distancesquared(var_8, self.origin) < 2250000) {
          var_9 = level._id_2430["last_say_time"][var_0][var_10] + level._id_2430["timeout"][var_0];

          if(var_9 > var_2) {
            var_2 = var_9;
          }

          var_3 = 1;
        }
      }
    } else if(isDefined(level._id_2430["last_say_pos"][var_0][self._id_AC3D._id_10691])) {
      var_2 = level._id_2430["last_say_time"][var_0][self._id_AC3D._id_10691] + level._id_2430["timeout"][var_0];
      var_3 = distancesquared(level._id_2430["last_say_pos"][var_0][self._id_AC3D._id_10691], self.origin) < 1048576;
    }
  }

  if(!isDefined(self._id_2431[var_0])) {
    self._id_2431[var_0] = 0;
  }

  var_13 = self._id_2431[var_0] + level._id_2430["timeout_player"][var_0];
  var_14 = gettime() + var_1 * 1000;

  if(var_3) {
    var_15 = max(var_13, max(var_2, var_14));
  } else {
    var_15 = max(var_13, var_14);
  }

  var_16 = var_15 - gettime();
  return var_16;
}

_id_6D61(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1000;
  }

  var_3 = var_2 * var_2;
  var_4 = [];
  var_4["lower"] = [];

  if(isDefined(var_0) && isDefined(var_0.team) && var_0.team != "spectator") {
    foreach(var_6 in level._id_E3B0[var_0.team]) {
      var_7 = var_6;
      var_8 = var_7["player"];
      var_9 = var_7["priority"];

      if(!isDefined(var_8)) {
        continue;
      }
      if(distancesquared(var_8.origin, var_0.origin) < var_3) {
        if(isDefined(var_9)) {
          if(var_9 > var_1 || var_9 == var_1 && scripts\engine\utility::cointoss()) {
            var_4["higher"] = var_7;
            return var_4;
          } else
            var_4["lower"][var_4["lower"].size] = var_7;
        }
      }
    }
  }

  return var_4;
}

_id_3B02(var_0, var_1) {
  var_2 = var_1 == "none";

  if(var_2) {
    return var_2;
  }

  var_3 = level._id_2430["priority"][var_1] < level._id_2430["priority"][var_0];
  var_4 = level._id_2430["priority"][var_1] == level._id_2430["priority"][var_0] && scripts\engine\utility::cointoss();
  return var_3 || var_4;
}

_id_CB08(var_0, var_1) {
  if(!isDefined(self) || !scripts\mp\utility\teams::_id_8878(self.team)) {
    return 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = _id_6909(var_0, var_1);

  if(var_2 > level._id_2430["max_wait_time"] + var_1 * 1000) {
    return 1;
  } else {
    return 0;
  }
}

doplaysoundtoplayer(var_0, var_1, var_2) {
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = var_0[2];
  var_6 = var_0[3];
  self _meth_8854("battlechatter", var_3, var_4, var_5, var_6, var_1, var_2);
}

doplaysoundtoteam(var_0, var_1, var_2, var_3) {
  var_4 = var_0[0];
  var_5 = var_0[1];
  var_6 = var_0[2];
  var_7 = var_0[3];

  if(isDefined(var_3) && isDefined(var_2)) {
    self _meth_8855("battlechatter", var_4, var_5, var_6, var_7, var_1, var_2, var_3);
  } else if(isDefined(var_2)) {
    self _meth_8855("battlechatter", var_4, var_5, var_6, var_7, var_1, var_2);
  } else {
    self _meth_8855("battlechatter", var_4, var_5, var_6, var_7, var_1);
  }
}

splitoperatorvoiceid(var_0) {
  var_1 = [];
  var_2 = "";

  if(!isDefined(var_0)) {
    return var_1;
  }

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(var_4 == "_") {
      var_1[var_1.size] = var_2;
      var_2 = "";
      continue;
    }

    if(var_3 == var_0.size - 1) {
      var_2 = var_2 + var_4;
      var_1[var_1.size] = var_2;
      continue;
    }

    var_2 = var_2 + var_4;
  }

  return var_1;
}

concataliassubstrs(var_0) {
  var_1 = "";

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_1 + var_0[var_2];

    if(var_2 < var_0.size - 1) {
      var_1 = var_1 + "_";
    }
  }

  return var_1;
}