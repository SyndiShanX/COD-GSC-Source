/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\battlechatter_mp.gsc
***********************************************/

function init() {
  level.battlechatterenabled = getdvarint("scr_game_battlechatter_enabled", 1) == 1;
  level.speakers = [];
  level.bcsounds = [];
  level.bcinfo = [];
  level.bcinfo["max_wait_time"] = 1000;

  foreach(var_1 in level.teamnamelist) {
    level.isteamspeaking[var_1] = 0;
    level.speakers[var_1] = [];
    level.bcinfo["queued"][var_1] = "none";
  }

  setupselfvo();
  registerbcsoundtype("callout_location", "", 1, 1, 10, 10, 0, 0);
  registerbcsoundtype("last_mag_o", "combat_action_last_mag_o", 0.4, 0.5, 5, 5, 0);
  registerbcsoundtype("obj_sitrep_clear_o", "objectives_inform_sitrep_clear_o", 0.4, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_concat_east_o", "ping_concat_east_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_concat_high_o", "ping_concat_high_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_concat_low_o", "ping_concat_low_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_concat_north_o", "ping_concat_north_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_concat_northeast_o", "ping_concat_northeast_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_concat_northwest_o", "ping_concat_northwest_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_concat_south_o", "ping_concat_south_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_concat_southeast_o", "ping_concat_southeast_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_concat_southwest_o", "ping_concat_southwest_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_concat_west_o", "ping_concat_west_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_enemy_general_o", "ping_enemy_general_o", 1, 1, 15, 10, 1, 0, 0);
  registerbcsoundtype("ping_enemy_infantry_o", "ping_enemy_infantry_o", 1, 1, 15, 10, 1, 0, 0);
  registerbcsoundtype("ping_enemy_multiple_o", "ping_enemy_multiple_o", 1, 1, 15, 10, 1, 0, 0);
  registerbcsoundtype("ping_vehicle_heavy_o", "ping_vehicle_heavy_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_vehicle_light_o", "ping_vehicle_light_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_fieldupgrade_drone_o", "ping_fieldupgrade_drone_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_airdrop_o", "ping_killstreaks_airdrop_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_carepkg_o", "ping_killstreaks_carepkg_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_cobalt_o", "ping_killstreaks_cobalt_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_gunship_o", "ping_killstreaks_gunship_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_helo_o", "ping_killstreaks_helo_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_juggernaut_o", "ping_killstreaks_juggernaut_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_ravager_o", "ping_killstreaks_ravager_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_recon_o", "ping_killstreaks_recon_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_scrambler_o", "ping_killstreaks_scrambler_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_sentry_o", "ping_killstreaks_sentry_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_shieldturret_enemy_o", "ping_killstreaks_shieldturret_enemy_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_shieldturret_open_o", "ping_killstreaks_shieldturret_open_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_killstreaks_wheelson_o", "ping_killstreaks_wheelson_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_location_following_o", "ping_location_following_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_objective_device_o", "ping_objective_device_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_response_affirm_o", "ping_response_affirm_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_response_copy_o", "ping_response_copy_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_vehicle_bailout_o", "ping_vehicle_bailout_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_vehicle_concat_no_driver_o", "ping_vehicle_concat_no_driver_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_vehicle_concat_no_pilot_o", "ping_vehicle_concat_no_pilot_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_vehicle_driver_o", "ping_vehicle_driver_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_vehicle_gunner_o", "ping_vehicle_gunner_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_vehicle_pilot_o", "ping_vehicle_pilot_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("ping_vehicle_rider_o", "ping_vehicle_rider_o", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("player_respawn", "status_player_respawn", 0.3, 0.25, 5, 1, 0, 0);
  registerbcsoundtype("player_captured", "status_player_captured", 0.3, 0.25, 5, 1, 0, 0);
  registerbcsoundtype("player_low_health", "status_player_low_health", 0.3, 0.25, 5, 5, 0, 0);
  registerbcsoundtype("player_last_stand", "status_player_last_stand", 0.3, 1, 5, 1, 0, 0);
  registerbcsoundtype("player_recover", "status_player_recover", 0.3, 0.5, 5, 5, 0, 0);
  registerbcsoundtype("reviving", "status_action_reviving", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("reviving_specific", "status_action_reviving_specific", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("revived", "status_player_revived", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("revived_specific", "status_player_revived_specific", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("player_inventory_full", "status_player_inventory_full", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("player_inventory_betterone", "status_player_inventory_betterone", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("inform_casualty_help", "status_inform_casualty_help", 0.3, 0.25, 5, 5, 0, 0);
  registerbcsoundtype("inform_casualty_kia", "status_inform_casualty_kia", 0.3, 0.25, 5, 5, 0, 0);
  registerbcsoundtype("inform_last_two", "status_inform_last_two", 0.3, 0.25, 5, 5, 0, 0);
  registerbcsoundtype("inform_last_one", "status_inform_last_one", 0.3, 0.5, 5, 5, 0, 0);
  registerbcsoundtype("inform_nomanleft_pickup", "status_inform_nomanleft_pickup", 0.3, 0.25, 5, 5, 0, 0);
  registerbcsoundtype("inform_nomanleft_defib", "status_inform_nomanleft_defib", 0.3, 0.25, 5, 5, 0, 0);
  registerbcsoundtype("inform_on_your_six_o", "status_inform_on_your_six_o", 0.1, 1, 5, 10, 1, 0, 0);
  registerbcsoundtype("inform_respawn_enabled", "status_inform_respawn_enabled", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("inform_respawn_drop", "status_inform_respawn_drop", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("inform_insertion_jumpmaster", "status_inform_insertion_jumpmaster", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("use_stim", "equipment_action_adrenaline", 0.4, 1, 5, 1);
  registerbcsoundtype("use_atmine", "equipment_action_atmine", 0.4, 1, 5, 1);
  registerbcsoundtype("use_claymore", "equipment_action_claymore", 0.4, 1, 5, 1);
  registerbcsoundtype("use_decoy", "equipment_action_decoy", 0.4, 1, 5, 1);
  registerbcsoundtype("drop_ammobox", "equipment_action_drop_ammobox", 0.4, 1, 5, 1);
  registerbcsoundtype("drop_armor", "equipment_action_drop_armor", 0.4, 1, 5, 1);
  registerbcsoundtype("drop_grenades", "equipment_action_drop_grenades", 0.4, 1, 5, 1);
  registerbcsoundtype("drop_selfrevive", "equipment_action_drop_selfrevive", 0.4, 1, 5, 1);
  registerbcsoundtype("use_explosives", "equipment_action_explosives", 0.4, 1, 5, 1);
  registerbcsoundtype("use_flash", "equipment_action_flashbang", 0.4, 1, 5, 1);
  registerbcsoundtype("use_gasmask", "equipment_action_gasmask", 0.4, 1, 5, 1);
  registerbcsoundtype("use_grenade", "equipment_action_grenade", 0.4, 1, 5, 1);
  registerbcsoundtype("use_grenade_throwback", "equipment_action_grenade_throwback", 0.4, 1, 5, 1);
  registerbcsoundtype("use_molotov", "equipment_action_molotov", 0.4, 1, 5, 1);
  registerbcsoundtype("use_powerup", "equipment_action_powerup", 0.4, 1, 5, 1);
  registerbcsoundtype("use_radsuit", "equipment_action_radsuit", 0.4, 1, 5, 1);
  registerbcsoundtype("use_rocket", "equipment_action_rocket", 0.4, 1, 5, 1);
  registerbcsoundtype("use_smoke", "equipment_action_smoke", 0.4, 1, 5, 1);
  registerbcsoundtype("use_stun", "equipment_action_stun", 0.4, 1, 5, 1);
  registerbcsoundtype("use_teargas", "equipment_action_teargas", 0.4, 1, 5, 1);
  registerbcsoundtype("use_thermite", "equipment_action_thermite", 0.4, 1, 5, 1);
  registerbcsoundtype("use_deadsilence", "equipment_fieldupgrade_deadsilence", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("use_emp_drone", "equipment_fieldupgrade_empdrone", 0.4, 1, 5, 1);
  registerbcsoundtype("use_recon_drone", "equipment_fieldupgrade_recon", 0.4, 1, 5, 1);
  registerbcsoundtype("use_self_revive", "equipment_fieldupgrade_selfrevive", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("use_tac_insert", "equipment_fieldupgrade_tacinsert", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("use_trophy", "equipment_fieldupgrade_trophy", 0.4, 1, 5, 1);
  registerbcsoundtype("incoming_c4", "equipment_incoming_c4", 0.4, 1, 5, 1);
  registerbcsoundtype("incoming_flash", "equipment_incoming_flash", 0.4, 1, 5, 1);
  registerbcsoundtype("incoming_gas", "equipment_incoming_gas", 0.4, 1, 5, 1);
  registerbcsoundtype("incoming_generic", "equipment_incoming_generic", 0.4, 1, 5, 1);
  registerbcsoundtype("incoming_grenade", "equipment_incoming_generic", 0.4, 1, 5, 1);
  registerbcsoundtype("incoming_molotov", "equipment_incoming_molotov", 0.4, 1, 5, 1);
  registerbcsoundtype("incoming_rpg", "equipment_incoming_rpg", 0.8, 1, 5, 5);
  registerbcsoundtype("incoming_stuck", "equipment_incoming_stuck", 0.4, 1, 5, 1);
  registerbcsoundtype("incoming_stun", "equipment_incoming_stun", 0.4, 1, 5, 1);
  registerbcsoundtype("incoming_thermite", "equipment_incoming_thermite", 0.4, 1, 5, 1);
  registerbcsoundtype("last_mag", "combat_action_last_mag", 0.4, 0.5, 0, 5, 0, 0);
  registerbcsoundtype("last_mag_high", "combat_action_last_mag_concat_highcal", 0.4, 1, 0, 5, 0, 0);
  registerbcsoundtype("last_mag_launcher", "combat_action_last_mag_concat_launcher", 0.4, 1, 0, 5, 0, 0);
  registerbcsoundtype("last_mag_mid", "combat_action_last_mag_concat_midcal", 0.4, 1, 0, 5, 0, 0);
  registerbcsoundtype("last_mag_shotgun", "combat_action_last_mag_concat_shells", 0.4, 1, 0, 5, 0, 0);
  registerbcsoundtype("last_mag_small", "combat_action_last_mag_concat_smallcal", 0.4, 1, 0, 5, 0, 0);
  registerbcsoundtype("reload", "combat_action_reloading", 0.1, 1, 5, 5);
  registerbcsoundtype("check_fire", "combat_inform_check_fire", 1, 1, 5, 5);
  registerbcsoundtype("check_fire_ally", "combat_inform_check_fire_ally", 1, 1, 5, 5);
  registerbcsoundtype("damage", "combat_inform_taking_fire", 0.5, 1, 10, 20);
  registerbcsoundtype("damage_long", "combat_inform_taking_fire_long", 0.5, 1, 10, 20);
  registerbcsoundtype("killfirm_bomber", "combat_killfirm_bomber", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_cobalt", "combat_killfirm_cobalt", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_drone", "combat_killfirm_drone", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_gunship", "combat_killfirm_gunship", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_helo", "combat_killfirm_helo", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_infantry", "combat_killfirm_infantry", 0.3, 0.25, 5, 15);
  registerbcsoundtype("killfirm_infantry_double", "combat_killfirm_infantry_double", 0.5, 0.5, 5, 15);
  registerbcsoundtype("killfirm_infantry_hexa", "combat_killfirm_infantry_hexa", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_infantry_quadra", "combat_killfirm_infantry_quadra", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_juggernaut", "combat_killfirm_juggernaut", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_ravager", "combat_killfirm_ravager", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_scrambler", "combat_killfirm_scrambler", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_sentry", "combat_killfirm_sentry", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_shieldturret", "combat_killfirm_shieldturret", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_sniper", "combat_killfirm_sniper", 0.5, 0.25, 5, 15);
  registerbcsoundtype("killfirm_squad", "combat_killfirm_squad", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_uav", "combat_killfirm_uav", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_vehicleheavy", "combat_killfirm_vehicleheavy", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_vehiclelight", "combat_killfirm_vehiclelight", 0.5, 1, 5, 15);
  registerbcsoundtype("killfirm_wheelson", "combat_killfirm_wheelson", 0.5, 1, 5, 15);
  registerbcsoundtype("use_killstreak_juggernaut_local", "killstreaks_player_juggernaut_use", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("use_airstrike_callout", "killstreaks_player_airstrike_callout", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("use_airsupport_callout", "killstreaks_player_airsupport_callout", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("use_airdrop_callout", "killstreaks_player_airdrop_callout", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("use_recon_callout", "killstreaks_player_recon_callout", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("use_killstreak_nuke", "killstreaks_nuke_use", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("use_killstreak_scramblerdrone", "killstreaks_scrambler_use", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("use_killstreak_sentrygun", "killstreaks_sentry_use", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("use_killstreak_mobileturret", "killstreaks_shieldturret_use", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("use_killstreak_dronesentry", "killstreaks_wheelson_use", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("obj_breach", "objectives_inform_breach", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_breach_set", "objectives_inform_breach_set", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_breach_setting", "objectives_inform_breach_setting", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_collect_another", "objectives_inform_collect_another", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_collect_complete", "objectives_inform_collect_complete", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_collect_false", "objectives_inform_collect_false", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_collect_first", "objectives_inform_collect_first", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_collect_generic", "objectives_inform_collect_generic", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_inform_confirm", "objectives_inform_confirm", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_device_disabled", "objectives_inform_device_disabled", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_device_pickup", "objectives_inform_device_pickup", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_device_set", "objectives_inform_device_set", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_device_setting", "objectives_inform_device_setting", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_exfil_nag", "objectives_inform_exfil_nag", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_fulton_hvi", "objectives_inform_fulton_hvi", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_fulton_package", "objectives_inform_fulton_package", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_holding", "objectives_inform_holding", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_hvi_cover", "objectives_inform_hvi_cover", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_hvi_follow", "objectives_inform_hvi_follow", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_hvi_wait", "objectives_inform_hvi_wait", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_interact", "objectives_inform_interact", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_moveout_nag", "objectives_inform_moveout_nag", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_package", "objectives_inform_package", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_secured", "objectives_inform_secured", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_sitrep_10seconds", "objectives_inform_sitrep_10seconds", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_sitrep_30seconds", "objectives_inform_sitrep_30seconds", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_sitrep_60seconds", "objectives_inform_sitrep_60seconds", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_sitrep_circle_in", "objectives_inform_sitrep_circle_in", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_sitrep_circle_mixed", "objectives_inform_sitrep_circle_mixed", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_sitrep_circle_out", "objectives_inform_sitrep_circle_out", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_sitrep_circle_outfar", "objectives_inform_sitrep_circle_outfar", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_sitrep_clear", "objectives_inform_sitrep_clear", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_sitrep_clock_start", "objectives_inform_sitrep_clock_start", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_sitrep_success", "objectives_inform_sitrep_success", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_sitrep_wave_start", "objectives_inform_sitrep_wave_start", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_target_eliminated", "objectives_inform_target_eliminated", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_target_interrogate", "objectives_inform_target_interrogate", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_target_moving", "objectives_inform_target_moving", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_target_visual", "objectives_inform_target_visual", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_visual", "objectives_inform_visual", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("obj_visual_lost", "objectives_inform_visual_lost", 0.4, 1, 5, 1, 0, 0);
  registerbcsoundtype("conv_generic_reply", "convo_generic_reply", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("conv_generic_signoff", "convo_generic_signoff", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("conv_generic_affirm", "convo_generic_affirm", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("conv_direct_start", "convo_direct_start", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("conv_convo_direct_resp", "convo_convo_direct_resp", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("convo_like_start", "convo_like_start", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("convo_like_resp", "convo_like_resp", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("convo_neutral_start", "convo_neutral_start", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("convo_neutral_resp", "convo_neutral_resp", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("convo_dislike_start", "convo_dislike_start", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("convo_dislike_resp", "convo_dislike_resp", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("flavor_revenge", "flavor_player_revenge", 0.4, 0.5, 5, 10, 0);
  registerbcsoundtype("flavor_save", "flavor_player_save", 0.4, 0.5, 5, 10, 0);
  registerbcsoundtype("flavor_suppressed", "flavor_player_suppressed", 0.4, 1, 5, 10, 0);
  registerbcsoundtype("flavor_awesome", "flavor_player_awesome", 0.4, 1, 5, 10, 0);
  registerbcsoundtype("flavor_closecall", "flavor_player_closecall", 0.4, 1, 5, 10, 0);
  registerbcsoundtype("flavor_surprise", "flavor_player_surprise", 0.4, 0.25, 5, 10, 0);
  registerbcsoundtype("flavor_execution", "flavor_player_execution", 1, 1, 5, 10, 0);
  registerbcsoundtype("flavor_s4_quip", "quip", 1, 1, 5, 10, 0);
  registerbcsoundtype("flavor_headshotlong", "flavor_player_headshotlong", 0.4, 0.5, 5, 10, 0);
  registerbcsoundtype("flavor_positive", "flavor_player_positive", 0.4, 1, 5, 10, 0);
  registerbcsoundtype("flavor_negative", "flavor_player_negative", 0.4, 1, 5, 10, 0);
  registerbcsoundtype("flavor_shootnearmiss", "flavor_player_shootnearmiss", 0.4, 1, 5, 10, 0);
  registerbcsoundtype("flavor_neardeathkill", "flavor_player_neardeathkill", 0.4, 0.25, 5, 10, 0);
  registerbcsoundtype("flavor_goodhit", "flavor_goodhit", 0.4, 1, 5, 10, 0);
  registerbcsoundtype("flavor_okay", "flavor_okay", 0.4, 1, 5, 10, 0);
  registerbcsoundtype("flavor_hurryup", "flavor_hurryup", 0.4, 1, 5, 10, 0);
  registerbcsoundtype("flavor_taunt_point", "flavor_taunt_point", 0.4, 1, 5, 10, 0);
  registerbcsoundtype("flavor_taunt_wave", "flavor_taunt_wave", 0.4, 1, 5, 10, 0);
  ref_12b0f();
  registerbcsoundtype("ges_mtx_t9_taunt_all", "mtx_gst_taunt_all", 1, 1, 3, 5, 0);

  if(!scripts\mp\utility\game::unset_relic_landlocked()) {
    registerbcsoundtype("ping_aidstation", "ping_aidstation", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_aidstation_carry", "ping_aidstation_carry", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_ambulance", "ping_ambulance", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_grenade_lethal", "ping_ammo_grenadelethal", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_grenade_tactical", "ping_ammo_grenadetactical", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_ammo_highcal", "ping_ammo_highcal", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_ammo_launcher", "ping_ammo_launcher", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_ammo_midcaliber", "ping_ammo_midcaliber", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_ammo_shotgun", "ping_ammo_shotgun", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_ammo_smallcal", "ping_ammo_smallcal", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_attachments_generic", "ping_attachments_generic", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_attachments_optics", "ping_attachments_optics", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_east", "ping_concat_east", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_high", "ping_concat_high", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_level1", "ping_concat_level1", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_level2", "ping_concat_level2", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_level3", "ping_concat_level3", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_level4", "ping_concat_level4", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_level5", "ping_concat_level5", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_low", "ping_concat_low", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_north", "ping_concat_north", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_northeast", "ping_concat_northeast", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_northwest", "ping_concat_northwest", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_south", "ping_concat_south", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_southeast", "ping_concat_southeast", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_southwest", "ping_concat_southwest", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_concat_west", "ping_concat_west", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_dibs", "ping_dibs", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_attacking", "ping_enemy_attacking", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_bomber", "ping_enemy_bomber", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_general", "ping_enemy_general", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_goodkill", "ping_enemy_goodkill", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_infantry", "ping_enemy_infantry", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_multiple", "ping_enemy_multiple", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_rpg", "ping_enemy_rpg", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_sniper", "ping_enemy_sniper", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_three", "ping_enemy_three", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_traps", "ping_enemy_traps", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_two", "ping_enemy_two", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_vehicle_heavy", "ping_enemy_vehicle_heavy", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_enemy_vehicle_light", "ping_enemy_vehicle_light", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_fieldupgrade_drone", "ping_fieldupgrade_drone", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_fieldupgrade_supplybox", "ping_fieldupgrade_supplybox", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_fieldupgrade_tacinsert", "ping_fieldupgrade_tacinsert", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_airdrop", "ping_killstreaks_airdrop", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_carepkg", "ping_killstreaks_carepkg", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_cobalt", "ping_killstreaks_cobalt", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_gunship", "ping_killstreaks_gunship", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_helo", "ping_killstreaks_helo", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_juggernaut", "ping_killstreaks_juggernaut", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_ravager", "ping_killstreaks_ravager", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_recon", "ping_killstreaks_recon", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_scrambler", "ping_killstreaks_scrambler", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_sentry", "ping_killstreaks_sentry", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_shieldturret_enemy", "ping_killstreaks_shieldturret_enemy", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_shieldturret_open", "ping_killstreaks_shieldturret_open", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_killstreaks_wheelson", "ping_killstreaks_wheelson", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_location_follow", "ping_location_follow", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_location_generic", "ping_location_generic", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_location_gtfo", "ping_location_gtfo", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_location_landing", "ping_location_landing", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_location_landing_suggestion", "ping_location_landing_suggestion", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_location_looted", "ping_location_looted", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_location_regroup", "ping_location_regroup", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_need_armor", "ping_need_armor", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_need_gun", "ping_need_gun", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_need_helmet", "ping_need_helmet", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_need_highcal", "ping_need_highcal", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_need_launcher", "ping_need_launcher", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_need_medical", "ping_need_medical", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_need_midcal", "ping_need_midcal", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_need_shells", "ping_need_shells", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_need_smallcal", "ping_need_smallcal", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_objective_device", "ping_objective_device", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_pickup_armor", "ping_pickup_armor", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_pickup_generic", "ping_pickup_generic", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_pickup_health", "ping_pickup_health", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_pickup_riotshield", "ping_pickup_riotshield", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_plunder_bank", "ping_plunder_bank", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_plunder_cache", "ping_plunder_cache", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_plunder_loot", "ping_plunder_loot", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_plunder_vendor", "ping_plunder_vendor", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_response_affirm", "ping_response_affirm", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_response_cancel", "ping_response_cancel", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_response_copy", "ping_response_copy", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_response_helpme", "ping_response_helpme", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_response_leaveme", "ping_response_leaveme", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_response_revive", "ping_response_revive", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_response_thanks", "ping_response_thanks", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_response_thanks_specific", "ping_response_thanks_specific", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_vehicle_bailout", "ping_vehicle_bailout", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_vehicle_concat_no_driver", "ping_vehicle_concat_no_driver", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_vehicle_concat_no_pilot", "ping_vehicle_concat_no_pilot", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_vehicle_driver", "ping_vehicle_driver", 1, 1, 0, 0, 0, 0, 1, 1, "ping_vehicle_driver_o");
    registerbcsoundtype("ping_vehicle_gunner", "ping_vehicle_gunner", 1, 1, 0, 0, 0, 0, 1, 1, "ping_vehicle_gunner_o");
    registerbcsoundtype("ping_vehicle_heavy", "ping_vehicle_heavy", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_vehicle_helo", "ping_vehicle_helo", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_vehicle_light", "ping_vehicle_light", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_vehicle_needride", "ping_vehicle_needride", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_vehicle_pilot", "ping_vehicle_pilot", 1, 1, 0, 0, 0, 0, 1, 1, "ping_vehicle_pilot_o");
    registerbcsoundtype("ping_vehicle_rider", "ping_vehicle_rider", 1, 1, 0, 0, 0, 0, 1, 1, "ping_vehicle_rider");
    registerbcsoundtype("ping_weapon_assaultrifle", "ping_weapon_assaultrifle", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_weapon_custom", "ping_weapon_custom", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_weapon_dmr", "ping_weapon_dmr", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_weapon_launcher", "ping_weapon_launcher", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_weapon_lmg", "ping_weapon_lmg", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_weapon_melee", "ping_weapon_melee", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_weapon_pistol", "ping_weapon_pistol", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_weapon_shotgun", "ping_weapon_shotgun", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_weapon_smg", "ping_weapon_smg", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_weapon_sniper", "ping_weapon_sniper", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_initial_contract_scavenger", "ping_initial_contract_scavenger", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_initial_contract_bounty", "ping_initial_contract_bounty", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_initial_contract_recon", "ping_initial_contract_recon", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_initial_contract_supplyrun", "ping_initial_contract_supplyrun", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_initial_contract_mostwanted", "ping_initial_contract_mostwanted", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_initial_contract_ctrabandextract", "ping_initial_contract_ctrabandextract", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_initial_contract_generic", "ping_initial_contract_generic", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_affirm_contract_scavenger", "ping_affirm_contract_scavenger", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_affirm_contract_bounty", "ping_affirm_contract_bounty", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_affirm_contract_recon", "ping_affirm_contract_recon", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_affirm_contract_supplyrun", "ping_affirm_contract_supplyrun", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_affirm_contract_mostwanted", "ping_affirm_contract_mostwanted", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_affirm_contract_ctrabandextract", "ping_affirm_contract_ctrabandextract", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_affirm_contract_generic", "ping_affirm_contract_generic", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_plunder_bank_confirm", "ping_plunder_bank_confirm", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_plunder_vendor_confirm", "ping_plunder_vendor_confirm", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_vehicle_cash_deposit_helo", "ping_vehicle_cash_deposit_helo", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_gasmask", "ping_gasmask", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_gasmask_confirm", "ping_gasmask_confirm", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_cash_deposit_balloon", "ping_cash_deposit_balloon", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_cash_deposit_confirm", "ping_cash_deposit_confirm", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_generic_ping_response", "ping_generic_ping_response", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_loot_accesscard", "ping_loot_accesscard", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_vehicle_confirm", "ping_vehicle_confirm", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_pickup_fieldupgrade", "ping_pickup_fieldupgrade", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_objective_contract", "ping_objective_contract", 1, 1, 0, 0, 0, 0);
    registerbcsoundtype("ping_objective_contract_o", "ping_objective_contract_o", 1, 1, 0, 0, 0, 0);
  }

  level.func_bcs_location_trigs = &scripts\mp\battlechatter_trigs::extra_location_trigger_mapping;

  if(!isDefined(anim.bcs_locations)) {
    scripts\common\bcs_location_trigs::bcs_location_trigs_init();
  }

  var_3 = getDvar("NKTMKRMSKR");
  level.v_start_pos = 0;

  if(var_3 == "sd" || var_3 == "cyber" || var_3 == "arena") {
    level.v_start_pos = 1;
  }

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
}

function registerbcsoundtype(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
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

  level.bcsounds[var_0] = var_1;
  level.bcinfo["priority"][var_0] = var_2;
  level.bcinfo["chance"][var_0] = var_3;
  level.bcinfo["timeout"][var_0] = var_4 * 1000;
  level.bcinfo["timeout_player"][var_0] = var_5 * 1000;
  level.bcinfo["req_friendly"][var_0] = var_6;
  level.bcinfo["play_for_all"][var_0] = var_7;
  level.bcinfo["play_to_self"][var_0] = var_8;
  level.bcinfo["play_for_squad_only"][var_0] = var_9;
  level.bcinfo["additional_local_vo"][var_0] = var_10;
}

function ref_12b0f() {
  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/gesturetable.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/gesturetable.csv", var_0, 15);

    if(isDefined(var_2) && var_2 != "") {
      registerbcsoundtype(var_2, var_2, 1, 1, 3, 5, 0);
    }
  }
}

function onplayerspawned() {
  self.bcinfoqueued = "none";
  self.clear_hint_objective = 0;
  self.recentattackers = [];
  self.bcinfolastsaytimes = [];

  if(!isDefined(level.bcinfo["last_say_time"])) {
    level.bcinfo["last_say_time"] = [];
    level.bcinfo["last_say_pos"] = [];
  }

  if(level.splitscreen) {
    return;
  }

  if(!level.teambased || level.v_start_pos || istrue(level.disablebattlechatter) || scripts\mp\utility\game::isanymlgmatch()) {
    self.bcdisabled = 1;
    return;
  }

  if(!scripts\mp\utility\game::runleanthreadmode() || istrue(level.delete_race)) {
    thread reloadtracking();
    thread threatcallouttracking();
    thread onsixfriendlytracking();

    if(istrue(self.ref_1443d)) {
      thread trysaylocalsound(level, self);
      return;
    }

    return;
  }

  if(scripts\mp\utility\game::getgametype() != "br") {
    self.bcdisabled = 1;
    return;
  }
}

function hurtbadlywait() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bc_damage_taken");
  wait 1.5;
  thread trysaylocalsound(level, self);
}

function validaterecentattackers() {
  var_0 = [];
  var_1 = gettime();

  foreach(var_3 in self.recentattackers) {
    if(var_1 < var_3.ignoreaftertime) {
      var_0 = var_3;
    }
  }

  self.recentattackers = var_0;
}

function addrecentattacker(var_0) {
  if(!isDefined(self.recentattackers)) {
    self.recentattackers = [];
  }

  var_1 = 0;

  foreach(var_3 in self.recentattackers) {
    if(var_3.attacker == var_0) {
      var_1 = 1;
      var_3.time = gettime();
      var_3.ignoreaftertime = var_3.time + 2000;
      break;
    }
  }

  if(!var_1) {
    var_3 = spawnStruct();
    var_3.time = gettime();
    var_3.attacker = var_0;
    var_3.ignoreaftertime = var_3.time + 2000;
    self.recentattackers[self.recentattackers.size] = var_3;
  }

  validaterecentattackers();

  if(self.recentattackers.size > 1) {
    thread trysaylocalsound(level, self);
    return;
  }
}

function watchbrsquadleaderdisconnect(var_0) {
  var_0 endon("death");

  for(;;) {
    var_1 = scripts\common\utility::playersinsphere(var_0.origin, 500);

    foreach(var_3 in var_1) {
      if(!isDefined(var_3) || !var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(isDefined(var_0.owner) && !var_0.owner scripts\mp\utility\player::isenemy(var_3)) {
        continue;
      }

      thread trysaylocalsound(level, var_3);
      return;
    }

    waitframe();
  }
}

function javelinfired(var_0, var_1) {
  if(!level.teambased) {
    return;
  }

  var_2 = scripts\engine\utility::random(scripts\mp\utility\game::getotherteam(var_0));
  var_3 = scripts\mp\utility\player::getplayersinradius(var_1, 360000, var_2);

  if(var_3.size == 0) {
    return;
  }

  var_4 = scripts\engine\utility::random(var_3);
  thread trysaylocalsound(level, var_4, "incoming_rpg", undefined);
}

function ongrenadeuse(var_0) {
  switch (var_0.weapon_name) {
    case "frag_grenade_mp":
      thread trysaylocalsound(level, self);
      break;
    case "semtex_mp":
      thread trysaylocalsound(level, self);
      break;
    case "snapshot_grenade_mp":
      thread trysaylocalsound(level, self);
      break;
    case "molotov_mp":
      thread trysaylocalsound(level, self);
      break;
    case "equip_pop_rocket":
      thread trysaylocalsound(level, self);
      break;
    case "thermite_mp":
      thread trysaylocalsound(level, self);
      break;
    case "c4_mp_p":
      thread trysaylocalsound(level, self);
      break;
    case "claymore_mp":
      thread trysaylocalsound(level, self);
      break;
    case "at_mine_mp":
    case "equip_at_mine":
      thread trysaylocalsound(level, self);
      break;
    case "flash_grenade_mp":
      thread trysaylocalsound(level, self);
      break;
    case "concussion_grenade_mp":
      thread trysaylocalsound(level, self);
      break;
    case "sensor_grenade_mp":
      break;
    case "smoke_grenade_mp":
      thread trysaylocalsound(level, self);
      break;
    case "gas_grenade_mp":
    case "gas_mp":
      thread trysaylocalsound(level, self);
      break;
    case "decoy_grenade_mp":
      thread trysaylocalsound(level, self);
      break;
    case "equip_adrenaline":
      thread trysaylocalsound(level, self);
      break;
    case "deployable_cover_mp":
      break;
    case "trophy_mp":
      thread trysaylocalsound(level, self);
      break;
    case "support_box_mp":
      thread trysaylocalsound(level, self);
      break;
  }
}

function grenadeproximitytracking() {
  if(!isDefined(self)) {
    return;
  }

  if(scripts\mp\utility\game::updatex1stashhud()) {
    return;
  }

  var_0 = self.weapon_name;

  if(!isDefined(var_0)) {
    return;
  }

  switch (var_0) {
    case "equip_adrenaline":
    case "gas_grenade_mp":
    case "decoy_grenade_mp":
    case "deployable_cover_mp":
    case "trophy_mp":
    case "thermite_mp":
      return;
  }

  var_1 = self.owner;

  if(!isDefined(var_1)) {
    var_1 = getmissileowner(self);
  }

  if(!isDefined(var_1)) {
    return;
  }

  self endon("death");

  for(;;) {
    var_2 = scripts\common\utility::playersinsphere(self.origin, 384);

    foreach(var_4 in var_2) {
      if(!isDefined(var_4) || var_4 scripts\cp_mp\utility\player_utility::_isalive() == 0 || isDefined(self.owner) && self.owner scripts\mp\utility\player::isenemy(var_4) == 0) {
        continue;
      }

      var_5 = distancesquared(self.origin, var_4.origin);

      if(isDefined(var_5) && var_5 < 384) {
        if(!sighttracepassed(var_4 getEye(), self.origin, 0, var_4)) {
          continue;
        }

        switch (var_0) {
          case "frag_grenade_mp":
            thread trysaylocalsound(level, var_4);
            break;
          case "concussion_grenade_mp":
            thread trysaylocalsound(level, var_4);
            break;
          case "flash_grenade_mp":
            thread trysaylocalsound(level, var_4);
            break;
          case "smoke_grenade_mp":
            thread trysaylocalsound(level, var_4);
            break;
          case "semtex_mp":
            thread trysaylocalsound(level, var_4);
            break;
          case "molotov_mp":
            thread trysaylocalsound(level, var_4);
            break;
          case "equip_pop_rocket":
            thread trysaylocalsound(level, var_4);
            break;
          case "c4_mp_p":
            thread trysaylocalsound(level, var_4);
            break;
          case "sensor_grenade_mp":
            thread trysaylocalsound(level, var_4);
            break;
          case "thermite_mp":
            thread trysaylocalsound(level, var_4);
            break;
          case "gas_grenade_mp":
            thread trysaylocalsound(level, var_4);
            break;
          default:
            if(weaponclass(self.weapon_name) == "rocketlauncher") {
              thread trysaylocalsound(level, var_4);
            }

            break;
        }
      }

      waitframe();
    }

    waitframe();
  }
}

function equipmentdestroyed(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_0.weapon_name)) {
    return;
  }

  switch (var_0.weapon_name) {
    case "c4_mp_p":
      break;
    case "at_mine_mp":
      break;
    case "claymore_mp":
      break;
    case "trophy_mp":
      break;
    case "deployable_cover_mp":
      break;
    case "decoy_grenade_mp":
      break;
    case "gas_grenade_mp":
      break;
    case "sensor_grenade_mp":
      break;
    case "support_box_mp":
      break;
  }
}

function ref_1274c(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  switch (var_1) {
    case "chopper_support":
    case "gunship":
    case "chopper_gunner":
      thread trysaylocalsound(level, var_0);
      break;
    case "death_switch":
      thread trysaylocalsound(level, var_0);
      break;
    case "pac_sentry":
      thread trysaylocalsound(level, var_0);
      break;
    case "airdrop_multiple":
    case "airdrop":
    case "bradley":
    case "juggernaut":
      thread trysaylocalsound(level, var_0);
      break;
    case "manual_turret":
      thread trysaylocalsound(level, var_0);
      break;
    case "sentry_gun":
      thread trysaylocalsound(level, var_0);
      break;
    case "nuke_select_location":
    case "nuke":
      thread trysaylocalsound(level, var_0);
      break;
    case "white_phosphorus":
    case "hover_jet":
    case "fuel_airstrike":
    case "toma_strike":
    case "precision_airstrike":
    case "cruise_predator":
      thread trysaylocalsound(level, var_0);
      break;
    case "directional_uav":
    case "radar_drone_overwatch":
    case "uav":
      thread trysaylocalsound(level, var_0);
      break;
    case "scrambler_drone_guard":
      thread trysaylocalsound(level, var_0);
      break;
  }
}

function killstreaklockedon(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  switch (var_0) {
    case "gunship":
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

function killstreakdestroyed(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  switch (var_0) {
    case "gunship":
      thread trysaylocalsound(level, self);
      break;
    case "chopper_support":
    case "chopper_gunner":
      thread trysaylocalsound(level, self);
      break;
    case "death_switch":
      thread trysaylocalsound(level, self);
      break;
    case "pac_sentry":
      thread trysaylocalsound(level, self);
      break;
    case "hover_jet":
      thread trysaylocalsound(level, self);
      break;
    case "juggernaut":
      thread trysaylocalsound(level, self);
      break;
    case "bradley":
      thread trysaylocalsound(level, self);
      break;
    case "manual_turret":
      thread trysaylocalsound(level, self);
      break;
    case "sentry_gun":
      thread trysaylocalsound(level, self);
      break;
    case "cruise_predator":
      break;
    case "uav":
      thread trysaylocalsound(level, self);
      break;
    case "directional_uav":
      thread trysaylocalsound(level, self);
      break;
    case "scrambler_drone_guard":
      thread trysaylocalsound(level, self);
      break;
    case "radar_drone_escort":
      thread trysaylocalsound(level, self);
      break;
  }
}

function suppressingfiretracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  var_0 = undefined;

  if(scripts\mp\utility\game::updatex1stashhud()) {
    return;
  }

  for(;;) {
    self waittill("begin_firing");
    thread suppresswaiter();
    thread suppresstimeout();
    self waittill("stoppedFiring");
  }
}

function suppresstimeout() {
  thread waitsuppresstimeout();
  self endon("begin_firing");
  self waittill("end_firing");
  wait 0.3;
  self notify("stoppedFiring");
}

function waitsuppresstimeout() {
  self endon("stoppedFiring");
  self waittill("begin_firing");
  thread suppresstimeout();
}

function suppresswaiter() {
  self notify("suppressWaiter");
  self endon("suppressWaiter");
  self endon("death_or_disconnect");
  self endon("stoppedFiring");
  wait 1;
}

function reloadtracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  jumpiffalse(scripts\mp\utility\game::updatex1stashhud()) LOC_00000017;
  return;
}

function sprinttracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("sprint_begin");
  }
}

function threatcallouttracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  jumpiffalse(scripts\mp\utility\game::updatex1stashhud()) LOC_00000017;
  return;
}

function dosound(var_0, var_1) {
  if(!isDefined(self.operatorcustomization)) {
    return;
  }

  var_2 = level.bcsounds[var_0];

  if(isDefined(var_1)) {
    var_2 = "loc_callout_" + var_1;
  }

  var_3 = getintensitysuffix(self);

  if(var_0 == "flavor_execution" || var_0 == "flavor_s4_quip") {
    if(isDefined(self.operatorcustomization.oicvariantid) && self.operatorcustomization.oicvariantid != "") {
      var_2 = self.operatorcustomization.oicvariantid;
    } else {
      var_4 = self.operatorcustomization.oic_rewardammo;

      if(var_4 == "none" || var_4 == "") {
        return;
      }

      var_2 += var_4;
    }
  }

  var_5 = "dx_mpb_" + self.operatorcustomization.voice + "_" + var_2;

  if(getsubstr(var_2, var_2.size - 2, var_2.size) == "_o") {
    var_2 = getsubstr(var_2, 0, var_2.size - 2);
  }

  var_6 = "dx_mpp_" + self.operatorcustomization.voice + "_" + var_2;

  if("dx_mpp_stry_mtx_execute_howd_you_think" == var_6) {
    var_6 = "dx_mpp_stry_mtx_execute_howd_you_think_hash";
  }

  var_7 = soundexists(var_5);
  var_8 = soundexists(var_6);
  var_9 = 0;
  var_10 = 0;

  if(!var_7) {} else {
    var_9 = lookupsoundlength(var_5);
  }

  if(!var_8) {} else {
    var_10 = lookupsoundlength(var_6);
  }

  if(!scripts\mp\utility\game::lpcfeaturegated()) {
    ref_12454(var_7, var_8, var_0, var_6, var_5);
  } else if(self issplitscreenplayer()) {
    ref_12455(var_7, var_8, var_0, var_6, var_5);
  } else {
    ref_12453(var_7, var_8, var_0, var_6, var_5);
  }

  if(isDefined(level.bcinfo["additional_local_vo"][var_0]) && isDefined(self.squadindex)) {
    var_11 = "dx_mpb_" + self.operatorcustomization.voice + "_" + level.bcinfo["additional_local_vo"][var_0];

    if(soundexists(var_11)) {
      var_12 = level.bcinfo["additional_local_vo"][var_0];
      var_13 = level.squaddata[self.team][self.squadindex].players;

      if(!scripts\mp\utility\game::lpcfeaturegated()) {
        ref_12454(1, 1, var_12, undefined, var_11, var_13);
      } else if(self issplitscreenplayer()) {
        ref_12455(1, 1, var_12, undefined, var_11, var_13);
      } else {
        ref_12453(1, 1, var_12, undefined, var_11, var_13);
      }
    }
  }

  if(isDefined(var_1)) {
    location_add_last_callout_time(var_1, self.team);
  }

  var_14 = level.bcinfo["priority"][var_0];
  var_15 = self.team;
  addspeaker(level, self, var_15, var_5, var_0, var_14);
  updatechatter(var_0);
  var_16 = max(var_9, var_10) / 1000;
  thread timehack(var_5, var_16);
  scripts\engine\utility::ref_143a5(var_5, "death_or_disconnect");
  removespeaker(level, self, var_15);
  return 1;
}

function ref_12453(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = [];
  }

  if(var_0) {
    if(level.bcinfo["play_for_all"][var_2]) {
      if(var_1 || !level.bcinfo["play_to_self"][var_2]) {
        self playSound(var_4, self, self);
      } else {
        self playSound(var_4, undefined, self);
      }
    } else if(level.bcinfo["play_for_squad_only"][var_2] && isDefined(level.squaddata)) {
      if(isDefined(self.team) && isDefined(self.squadindex) && isDefined(level.squaddata[self.team][self.squadindex])) {
        var_6 = level.squaddata[self.team][self.squadindex].players;

        foreach(var_8 in var_6) {
          if(scripts\engine\utility::array_contains(var_5, var_8)) {
            continue;
          }

          if(var_8 == self) {
            if(!istrue(var_1 && level.bcinfo["play_to_self"][var_2])) {
              self playsoundtoplayer(var_4, self);
            }

            continue;
          }

          var_8 playsoundtoplayer(var_4, var_8);
        }
      }
    } else if(var_5.size > 0) {
      var_10 = level.teamdata[self.team]["players"];

      foreach(var_8 in var_10) {
        if(var_8 == self && (var_1 || !level.bcinfo["play_to_self"][var_2])) {
          continue;
        }

        if(scripts\engine\utility::array_contains(var_5, var_8)) {
          continue;
        }

        self playsoundtoplayer(var_4, var_8);
      }
    } else if(var_1 || !level.bcinfo["play_to_self"][var_2]) {
      self playsoundtoteam(var_4, self.team, self, self);
    } else {
      self playsoundtoteam(var_4, self.team, undefined, self);
    }
  }

  if(var_1 && isDefined(var_3) && level.bcinfo["play_to_self"][var_2]) {
    self playsoundtoplayer(var_3, self, self);
    return;
  }
}

function ref_12454(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = [];
  }

  if(var_1 || !level.bcinfo["play_to_self"][var_2]) {
    GscBinSkip0(0x2e, var_5.size, self);
  }

  if(var_0) {
    if(level.bcinfo["play_for_all"][var_2]) {
      foreach(var_8 in level.teamnamelist) {
        var_9 = level.teamdata[var_8]["players"];

        foreach(var_11 in var_9) {
          if(var_11 issplitscreenplayer()) {
            var_6 = var_11 getothersplitscreenplayer();

            if(!scripts\engine\utility::array_contains(var_5, var_11) && !scripts\engine\utility::array_contains(var_5, var_6)) {
              var_5 = var_11;
            }
          }
        }

        foreach(var_11 in var_9) {
          if(!scripts\engine\utility::array_contains(var_5, var_11)) {
            self playsoundtoplayer(var_4, var_11, self);
          }
        }
      }
    } else {
      var_9 = level.teamdata[self.team]["players"];

      foreach(var_11 in var_9) {
        if(var_11 issplitscreenplayer()) {
          var_6 = var_11 getothersplitscreenplayer();

          if(!scripts\engine\utility::array_contains(var_11, var_11) && !scripts\engine\utility::array_contains(var_11, var_6)) {
            var_11 = var_11;
          }
        }
      }

      foreach(var_11 in var_9) {
        if(!scripts\engine\utility::array_contains(var_11, var_11)) {
          self playsoundtoplayer(var_9, var_11, self);
        }
      }
    }
  }

  if(var_3 && isDefined(var_5) && level.bcinfo["play_to_self"][var_4]) {
    self playsoundtoplayer(var_5, self, self);
    return;
  }
}

function ref_12455(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self getothersplitscreenplayer();

  if(!isDefined(var_5)) {
    var_5 = [];
  }

  var_5 = [var_6];

  if(var_1 || !level.bcinfo["play_to_self"][var_2]) {
    var_5 = self;
  }

  if(var_0) {
    if(level.bcinfo["play_for_all"][var_2]) {
      foreach(var_8 in level.teamnamelist) {
        if(var_8 == self.team) {
          var_9 = level.teamdata[self.team]["players"];

          foreach(var_11 in var_9) {
            if(!scripts\engine\utility::array_contains(var_5, var_11)) {
              self playsoundtoplayer(var_4, var_11, self);
            }
          }

          continue;
        }

        self playsoundtoteam(var_4, var_8, undefined, self);
      }
    } else {
      var_9 = level.teamdata[self.team]["players"];

      foreach(var_11 in var_9) {
        if(!scripts\engine\utility::array_contains(var_5, var_11)) {
          self playsoundtoplayer(var_4, var_11, self);
        }
      }
    }
  }

  if(var_1 && isDefined(var_3) && level.bcinfo["play_to_self"][var_2]) {
    self playsoundtoplayer(var_3, self, self);
    return;
  }
}

function killsoundondeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");
  var_7 = 0;

  if(var_4) {
    var_7 = lookupsoundlength(var_3) / 1000;
  }

  if(var_6) {
    var_7 = max(var_7, lookupsoundlength(var_5) / 1000);
  }

  var_8 = scripts\engine\utility::waittill_notify_or_timeout_return("death", var_7);

  if(isDefined(var_8) && var_8 == "timeout") {
    return;
  }

  if(level.bcinfo["play_for_all"][var_1]) {
    foreach(var_10 in level.teamnamelist) {
      if(var_10 == var_0) {
        if(var_2) {
          self playsoundtoteam("iw8_mp_kill_bc_radio", var_10);
        } else {
          self playsoundtoteam("iw8_mp_kill_bc", var_10);
        }

        continue;
      }

      self playsoundtoteam("iw8_mp_kill_bc", var_10);
    }
  } else if(var_2) {
    self playsoundtoteam("iw8_mp_kill_bc_radio", var_0);
  } else {
    self playsoundtoteam("iw8_mp_kill_bc", var_0);
  }

  if(var_6) {
    self playsoundtoplayer("iw8_mp_kill_bc", self);
    return;
  }
}

function dothreatcalloutresponse(var_0, var_1) {
  var_2 = scripts\engine\utility::ref_143ad(var_0, "death_or_disconnect");

  if(isDefined(var_2) && var_2 == var_0) {
    var_3 = self.team;
    var_4 = self.origin;
    wait 0.5;
    var_5 = scripts\mp\utility\teams::getfriendlyplayers(var_3, 1);

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

      if(self.operatorcustomization.voice != var_7.operatorcustomization.voice && distancesquared(var_4, var_7.origin) <= 262144 && !isspeakerinrange(var_7)) {
        var_8 = getintensitysuffix(var_7);
        var_9 = "dx_mpb_" + var_7.operatorcustomization.voice + "_loc_" + var_1 + "_echo";

        if(soundexists(var_9) && scripts\engine\utility::cointoss()) {
          var_10 = var_9;
        } else {
          var_10 = undefined;
        }

        if(isDefined(var_10)) {
          thread dosound(var_11, var_10, 0);
        }

        break;
      }
    }

    var_7 = undefined;
    var_8 = undefined;
    return;
  }
}

function timehack(var_0, var_1) {
  self endon("death_or_disconnect");
  wait var_1;
  self notify(var_0);
}

function isspeakerinrange(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1000;
  }

  var_2 = var_1 * var_1;

  if(isDefined(var_0) && isDefined(var_0.team) && var_0.team != "spectator") {
    for(var_3 = 0; var_3 < level.speakers[var_0.team].size; var_3++) {
      var_4 = level.speakers[var_0.team][var_3]["player"];

      if(var_4 == var_0) {
        return true;
      }

      if(!isDefined(var_4)) {
        continue;
      }

      if(distancesquared(var_4.origin, var_0.origin) < var_2) {
        return true;
      }
    }
  }

  return false;
}

function addspeaker(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.speakers[var_1].size;
  level.speakers[var_1][var_5] = [];
  level.speakers[var_1][var_5]["player"] = var_0;
  level.speakers[var_1][var_5]["sound_alias"] = var_2;
  level.speakers[var_1][var_5]["sound_type"] = var_3;
  level.speakers[var_1][var_5]["priority"] = var_4;
}

function removespeaker(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.speakers[var_1].size; var_3++) {
    if(isDefined(var_0) && isDefined(level.speakers[var_1][var_3]["player"]) && level.speakers[var_1][var_3]["player"] == var_0) {
      continue;
    }

    var_2 = level.speakers[var_1][var_3];
  }

  level.speakers[var_1] = var_2;
}

function disablebattlechatter(var_0) {
  var_0.bcdisabled = 1;
}

function enablebattlechatter(var_0) {
  var_0.bcdisabled = undefined;
}

function updatechatter(var_0) {
  var_1 = gettime();
  self.bcinfolastsaytimes[var_0] = var_1;

  if(!isDefined(level.bcinfo["last_say_time"][var_0])) {
    level.bcinfo["last_say_time"][var_0] = [];
  }

  if(!isDefined(level.bcinfo["last_say_pos"][var_0])) {
    level.bcinfo["last_say_pos"][var_0] = [];
  }

  level.bcinfo["last_say_time"][var_0][self.operatorcustomization.voice] = var_1;
  level.bcinfo["last_say_pos"][var_0][self.operatorcustomization.voice] = self.origin;
  cleanuplastsaytimes(var_1);
}

function cleanuplastsaytimes(var_0) {
  var_1 = [];

  foreach(var_5, var_3 in self.bcinfolastsaytimes) {
    var_4 = level.bcinfo["timeout_player"][var_5] + var_3;

    if(var_0 < var_4) {
      var_1 = var_3;
    }
  }

  self.bcinfolastsaytimes = var_1;
  var_1 = [];
  var_6 = [];

  foreach(var_5, var_8 in level.bcinfo["last_say_time"]) {
    var_1 = [];
    var_6 = [];

    foreach(var_10, var_3 in var_8) {
      if(var_0 < var_3 + level.bcinfo["timeout"][var_5]) {
        var_1[var_10] = var_3;
        var_6[var_10] = level.bcinfo["last_say_pos"][var_5][var_10];
      }
    }
  }

  level.bcinfo["last_say_time"] = var_1;
  level.bcinfo["last_say_pos"] = var_6;
}

function getvalidlocation(var_0) {
  var_1 = get_all_my_locations();
  var_1 = scripts\engine\utility::array_randomize(var_1);

  if(var_1.size) {
    foreach(var_3 in var_1) {
      if(!location_called_out_ever(var_3) && cancalloutlocation(var_0, var_3)) {
        return var_3;
      }
    }

    foreach(var_3 in var_1) {
      if(!location_called_out_recently(var_3) && cancalloutlocation(var_0, var_3)) {
        return var_3;
      }
    }
  }

  return undefined;
}

function get_all_my_locations() {
  var_0 = anim.bcs_locations;
  var_1 = self getistouchingentities(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.locationaliases)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function location_called_out_ever(var_0) {
  var_1 = location_get_last_callout_time(var_0.locationaliases[0]);

  if(!isDefined(var_1)) {
    return false;
  }

  return true;
}

function location_called_out_recently(var_0) {
  var_1 = location_get_last_callout_time(var_0.locationaliases[0]);

  if(!isDefined(var_1)) {
    return false;
  }

  var_2 = var_1 + 25000;

  if(gettime() < var_2) {
    return true;
  }

  return false;
}

function location_add_last_callout_time(var_0, var_1) {
  var_2 = gettime();
  anim.locationlastcallouttimes[var_0] = var_2;

  if(!isDefined(level.wake_everyone_up)) {
    level.wake_everyone_up = [];
  }

  level.wake_everyone_up[var_1] = var_2;
}

function location_get_last_callout_time(var_0) {
  if(isDefined(anim.locationlastcallouttimes[var_0])) {
    return anim.locationlastcallouttimes[var_0];
  }

  return undefined;
}

function punchcard_use_think(var_0) {
  if(isDefined(level.wake_everyone_up) && isDefined(level.wake_everyone_up[var_0])) {
    return level.wake_everyone_up[var_0];
  }

  return undefined;
}

function cancalloutlocation(var_0) {
  foreach(var_2 in var_0.locationaliases) {
    var_3 = getloccalloutalias(var_2);
    var_4 = soundexists(var_3);

    if(var_4) {
      return var_4;
    }
  }

  return 0;
}

function canconcat(var_0) {
  var_1 = var_0.locationaliases;

  foreach(var_3 in var_1) {
    if(iscallouttypeconcat(var_3, self)) {
      return true;
    }
  }

  return false;
}

function getcannedresponse(var_0) {
  var_1 = undefined;
  var_2 = self.locationaliases;

  foreach(var_4 in var_2) {
    if(iscallouttypeqa(var_4, var_0) && !isDefined(self.qafinished)) {
      var_1 = var_4;
      break;
    }

    if(iscallouttypereport(var_4)) {
      var_1 = var_4;
    }
  }

  return var_1;
}

function iscallouttypereport(var_0) {
  return issubstr(var_0, "_report");
}

function iscallouttypeconcat(var_0, var_1) {
  var_2 = getloccalloutalias(var_1, "concat_loc_" + var_0);

  if(soundexists(var_2)) {
    return true;
  }

  return false;
}

function iscallouttypeqa(var_0, var_1) {
  if(issubstr(var_0, "_qa") && soundexists(var_0)) {
    return true;
  }

  var_2 = getqacalloutalias(var_1, var_0, 0);

  if(soundexists(var_2)) {
    return true;
  }

  return false;
}

function getloccalloutalias(var_0) {
  var_1 = "dx_mpo_" + scripts\engine\utility::ter_op(self.team == "allies", "usop", "ruop") + "_loc_enemy_" + var_0;
  return var_1;
}

function getqacalloutalias(var_0, var_1) {
  var_2 = getloccalloutalias(var_0);
  var_2 += "_qa" + var_1;
  return var_2;
}

function battlechatter_canprint() {
  return false;
}

function battlechatter_canprintdump() {
  return false;
}

function battlechatter_print(var_0, var_1) {}

function battlechatter_printdump(var_0) {}

function battlechatter_debugprint(var_0, var_1) {}

function getaliastypefromsoundalias(var_0) {}

function battlechatter_printdumpline(var_0, var_1, var_2) {}

function friendly_nearby(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 262144;
  }

  var_1 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

  foreach(var_3 in var_1) {
    if(var_3 != self && distancesquared(var_3.origin, self.origin) <= var_0) {
      return true;
    }
  }

  return false;
}

function setupselfvo() {
  level.selfvomap = [];
  level.selfvomap["plr_killfirm_c6"] = "kill_rig";
  level.selfvomap["plr_killfirm_ftl"] = "kill_rig";
  level.selfvomap["plr_killfirm_ghost"] = "kill_rig";
  level.selfvomap["plr_killfirm_merc"] = "kill_rig";
  level.selfvomap["plr_killfirm_stryker"] = "kill_rig";
  level.selfvomap["plr_killfirm_warfighter"] = "kill_rig";
  level.selfvomap["plr_killfirm_generic"] = "kill_gen";
  level.selfvomap["plr_killfirm_amf"] = "kill_amf";
  level.selfvomap["plr_killfirm_headshot"] = "kill_headshot";
  level.selfvomap["plr_killfirm_grenade"] = "kill_grenade";
  level.selfvomap["plr_killfirm_rival"] = "kill_rival";
  level.selfvomap["plr_killfirm_semtex"] = "kill_semtex";
  level.selfvomap["plr_killfirm_multi"] = "kill_multi";
  level.selfvomap["plr_killfirm_twofer"] = "kill_twofer";
  level.selfvomap["plr_killfirm_threefer"] = "kill_threefer";
  level.selfvomap["plr_killfirm_killstreak"] = "kill_ss";
  level.selfvomap["plr_killstreak_destroy"] = "kill_other_ss";
  level.selfvomap["plr_killstreak_target"] = "targeted_by_ss";
  level.selfvomap["plr_hit_back"] = "dmg_back";
  level.selfvomap["plr_damaged_light"] = "dmg_light";
  level.selfvomap["plr_damaged_heavy"] = "dmg_heavy";
  level.selfvomap["plr_damaged_emp"] = "dmg_emp";
  level.selfvomap["plr_healing"] = "healing";
  level.selfvomap["plr_kd_high"] = "kd_high";
  level.selfvomap["plr_firefight"] = "firefight";
  level.selfvomap["plr_target_generic"] = "enemy_sighted";
  level.selfvomap["plr_perk_super"] = "super_activate";
  level.selfvomap["plr_perk_trophy"] = "super_activate";
  level.selfvomap["plr_perk_turret"] = "super_activate";
  level.selfvomap["plr_perk_amplify"] = "super_activate";
  level.selfvomap["plr_perk_overdrive"] = "super_activate";
  level.selfvomap["plr_perk_ftl"] = "super_activate";
  level.selfvomap["plr_perk_pulse"] = "super_activate";
  level.selfvomap["plr_perk_rewind"] = "super_activate";
  level.selfvomap["plr_perk_super_kill"] = "super_kill";
  level.selfvomap["plr_perk_trophy_block"] = "super_kill";
  level.selfvomap["plr_perk_turret_kill"] = "super_kill";
  level.selfvomap["plr_killfirm_shift"] = "super_kill";
  level.selfvomap["plr_perk_railgun"] = "super_kill";
  level.selfvomap["plr_perk_stealth"] = "super_kill";
  level.selfvomap["plr_perk_armor"] = "super_kill";
  level.selfvomap["plr_perk_charge"] = "super_kill";
  level.selfvomap["plr_perk_dragon"] = "super_kill";
  level.selfvomap["plr_perk_pound"] = "super_kill";
  level.selfvomap["plr_perk_reaper"] = "super_kill";
  level.selfvoinfo = [];
  setselfvoinfo("kill_rig", 15, 0.3, 0.25);
  setselfvoinfo("kill_gen", 30, 0.1, 0.25);
  setselfvoinfo("kill_amf", 15, 0.5, 0.5);
  setselfvoinfo("kill_headshot", 15, 0.7, 0.25);
  setselfvoinfo("kill_grenade", 15, 0.5, 0.25);
  setselfvoinfo("kill_rival", 15, 0.7, 0.25);
  setselfvoinfo("kill_semtex", 15, 0.5, 0.25);
  setselfvoinfo("kill_multi", 20, 0.6, 0.25);
  setselfvoinfo("kill_twofer", 10, 0.7, 0.75);
  setselfvoinfo("kill_threefer", 10, 0.8, 0.75);
  setselfvoinfo("kill_ss", 10, 0.5, 0.2);
  setselfvoinfo("kill_other_ss", 10, 0.7, 0.75);
  setselfvoinfo("targeted_by_ss", 10, 0.4, 0.33);
  setselfvoinfo("dmg_back", 20, 0.5, 0.5);
  setselfvoinfo("dmg_light", 20, 0.4, 0.1);
  setselfvoinfo("dmg_heavy", 20, 0.5, 0.2);
  setselfvoinfo("healing", 10, 0.3, 0.1);
  setselfvoinfo("kd_high", 20, 0.7, 0.8);
  setselfvoinfo("enemy_sighted", 20, 0.2, 0.25);
  setselfvoinfo("firefight", 10, 0.4, 0.33);
  setselfvoinfo("super_activate", 10, 1, 1);
  setselfvoinfo("super_kill", 10, 0.9, 0.66);
}

function setselfvoinfo(var_0, var_1, var_2, var_3) {
  level.selfvoinfo[var_0]["timeout"] = var_1;
  level.selfvoinfo[var_0]["priority"] = var_2;
  level.selfvoinfo[var_0]["chance"] = var_3;
}

function saytoself(var_0, var_1, var_2, var_3) {
  if(true) {
    return;
  }

  if(isagent(var_0) || !isPlayer(var_0)) {
    return;
  }

  if(istrue(var_0.bcdisabled)) {
    return;
  }

  var_4 = getintensitysuffix(var_0);
  var_5 = "";

  if(isDefined(var_0.operatorcustomization) && isDefined(var_0.operatorcustomization.voice) && isDefined(var_1)) {
    var_5 = "dx_mpb_" + var_0.operatorcustomization.voice + "_" + var_1;
  }

  if(!isDefined(var_1) || !soundexists(var_5)) {
    if(!isDefined(var_2)) {
      return;
    }

    var_1 = var_2;
    var_5 = "dx_mpb_" + var_0.operatorcustomization.voice + "_" + var_1;

    if(!soundexists(var_5)) {
      return;
    }
  }

  if(!isDefined(var_0.selfvohistory)) {
    var_0.selfvohistory = [];
    var_0.playingselfvo = 0;
    var_0.queuedvo = "none";
  }

  if(isDefined(var_0.selfvohistory[level.selfvomap[var_1]]) && var_0.selfvohistory[level.selfvomap[var_1]] > 0) {
    return;
  }

  if(!isDefined(var_0.pers["selfVOBonusChance"])) {
    thread updateselfvobonuschance();
  }

  if(randomfloat(1) > level.selfvoinfo[level.selfvomap[var_1]]["chance"] + var_0.pers["selfVOBonusChance"]) {
    return;
  }

  thread trysetqueuedselfvo(var_0, var_1);
}

function updateselfvobonuschance() {
  self endon("disconnect");
  level endon("game_ended");
  self.pers["selfVOBonusChance"] = 0;

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    for(;;) {
      self.pers["selfVOBonusChance"] = self.pers["selfVOBonusChance"] + 0.1;
      wait 3;
    }

    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    self.pers["selfVOBonusChance"] = 0.25;
    return;
  }
}

function trysetqueuedselfvo(var_0, var_1) {
  self endon("death_or_disconnect");

  if(self.queuedvo == var_0) {
    return;
  }

  if(self.queuedvo == "none" || level.selfvoinfo[level.selfvomap[self.queuedvo]]["priority"] < level.selfvoinfo[level.selfvomap[var_0]]["priority"] || level.selfvoinfo[level.selfvomap[self.queuedvo]]["priority"] == level.selfvoinfo[level.selfvomap[var_0]]["priority"] && scripts\engine\utility::cointoss()) {
    self.queuedvo = var_0;
  } else {
    return;
  }

  self notify("addToSelfVOQueue");
  self endon("addToSelfVOQueue");
  self.selfvodelaycomplete = 1;

  if(isDefined(var_1)) {
    thread selfvodelay(var_1);
  }

  var_2 = getprioritywaittime(var_0);
  var_3 = gettime();

  while(self.playingselfvo || !self.selfvodelaycomplete || var_2 > gettime()) {
    if(gettime() > var_3 + 2000) {
      self.queuedvo = "none";
      return;
    }

    wait 0.05;
  }

  waitframe();
  thread playselfvo(var_0);
}

function getprioritywaittime(var_0) {
  if(!isDefined(self.lastselfvotime)) {
    self.lastselfvotime = 0;
  }

  return self.lastselfvotime + 2000 + 10000 * (1 - level.selfvoinfo[level.selfvomap[var_0]]["priority"]);
}

function selfvodelay(var_0) {
  self endon("death_or_disconnect");
  self endon("addToSelfVOQueue");
  self.selfvodelaycomplete = 0;
  wait var_0;
  self.selfvodelaycomplete = 1;
}

function playselfvo(var_0) {
  self endon("death_or_disconnect");
  var_1 = getintensitysuffix(self);
  var_2 = "dx_mpb_" + self.operatorcustomization.voice + "_" + var_0;
  self.pers["selfVOBonusChance"] = 0;
  self.queuedvo = "none";
  var_3 = lookupsoundlength(var_2) / 1000;
  self.lastselfvotime = gettime();
  thread playingselfvotracking(var_3);
  thread updateselfvohistory(var_0);
  self playsoundtoplayer(var_2, self);
}

function playingselfvotracking(var_0) {
  self endon("disconnect");
  self.playingselfvo = 1;
  wait var_0;
  self.playingselfvo = 0;
}

function updateselfvohistory(var_0) {
  self endon("disconnect");
  self.selfvohistory[level.selfvomap[var_0]] = gettime();
  wait level.selfvoinfo[level.selfvomap[var_0]]["timeout"];
  self.selfvohistory[level.selfvomap[var_0]] = 0;
}

function getintensitysuffix(var_0) {
  var_2 = scripts\mp\utility\game::gettimepassedpercentage();
  var_3 = getbcintensity(var_0);

  if(var_3 > 5000 || var_2 >= 80 || scripts\mp\utility\game::inovertime()) {
    return "high";
  }

  return "mid";
}

function addtointensitybuffer(var_0, var_1, var_2) {
  if(!isDefined(self.battlechatterintensitybuffer)) {
    self.battlechatterintensitybuffer = [];
  }

  var_3 = spawnStruct();
  var_3.time = gettime();
  var_3.value = var_1;
  var_3.ignoreaftertime = var_3.time + var_2 * 1000;
  self.battlechatterintensitybuffer[self.battlechatterintensitybuffer.size] = var_3;
}

function getbcintensity() {
  if(!isDefined(self.battlechatterintensitybuffer)) {
    return 0;
  }

  var_0 = [];
  var_1 = 0;
  var_2 = gettime();

  foreach(var_4 in self.battlechatterintensitybuffer) {
    if(var_2 < var_4.ignoreaftertime) {
      var_1 += var_4.value;
      var_0 = var_4;
    }
  }

  self.battlechatterintensitybuffer = var_0;
  self.intensity = var_1;
  return var_1;
}

function testweaponfiredtolisteners(var_0, var_1) {
  var_2 = scripts\common\utility::playersnear(var_0.origin, 4000);

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\player::isreallyalive(var_4)) {
      continue;
    }

    var_5 = max(scripts\engine\utility::distance_2d_squared(var_0.origin, var_4.origin), 1);

    if(scripts\mp\utility\weapon::iscacprimaryweapon(var_1.basename) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_1.basename)) {
      var_6 = 0;
      var_7 = scripts\mp\utility\weapon::getweapongroup(var_1.basename);

      switch (var_7) {
        case "weapon_smg":
          var_6 = 50;
          break;
        case "weapon_assault":
        case "weapon_tactical":
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
        var_6 *= 0.25;
      }

      if(var_5 < 10000) {
        var_8 = 5;
      } else if(var_6 < 250000) {
        var_8 = 3;
      } else if(var_7 < 1000000) {
        var_8 = 2;
      } else if(var_10 < 4000000) {
        var_8 = 0.5;
      } else if(var_8 < 9000000) {
        var_8 = 0.25;
      } else {
        var_8 = 0.1;
      }

      var_9 = 1 - var_8 / 16000000;
      var_8 *= var_9;
      var_8 *= var_8;
      addtointensitybuffer(var_8, "weaponFired", int(var_8), 3);
    }
  }

  var_8 = undefined;
}

function adddamagetaken(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::updatex1stashhud()) {
    return;
  }

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
    thread trysaylocalsound(level, self, "damage_long", undefined);
    return;
  }

  thread trysaylocalsound(level, self, "damage", undefined);
}

function onsixfriendlytracking() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\game::lpcfeaturegated()) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  wait 5;

  for(;;) {
    if(!saidtoorecently("inform_on_your_six_o")) {
      var_0 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

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

        if(validatelistener(self, var_2)) {
          thread trysaylocalsound(level, self);
          break;
        }
      }
    }

    wait 0.15;
  }
}

function validatelistener(var_0, var_1) {
  var_2 = 0.05;
  var_3 = getlistenerorigin(var_1);
  var_4 = getspeakerorigin(var_0);
  var_5 = distancesquared(var_4, var_3);

  if(var_5 > 90000) {
    return false;
  }

  var_6 = getlistenerdirection(var_1);
  var_7 = vectorNormalize(var_4 - var_3);
  var_8 = vectordot(var_6, var_7);

  if(var_8 < var_2) {
    var_9 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
    var_10 = physics_createcontents(var_9);
    var_11 = scripts\engine\trace::ray_trace(var_4, var_3, var_0, var_10);

    if(isDefined(var_11["entity"]) && isPlayer(var_11["entity"]) || var_11["fraction"] > 0.8) {
      return true;
    }
  }

  return false;
}

function getspeakerorigin() {
  return self getEye();
}

function getlistenerorigin() {
  return self getEye();
}

function getlistenerdirection() {
  return anglesToForward(self getplayerangles());
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

function checkcasualty() {
  var_0 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

  foreach(var_2 in var_0) {
    if(var_2 == self) {
      continue;
    }

    if(distancesquared(self.origin, var_2.origin) <= 262144) {
      var_3 = anglesToForward(var_2 getplayerangles());

      if(length(var_2.origin - self.origin) > 0) {
        if(scripts\engine\math::anglebetweenvectors(var_3, var_2.origin - self.origin) < 80) {
          break;
        }
      }
    }
  }

  var_0 = undefined;
  var_2 = undefined;
}

function getsoundlength() {}

function trysaylocalsound(var_0, var_1, var_2, var_3) {
  if(!istrue(level.battlechatterenabled)) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(istrue(var_0.bcdisabled) && var_1 != "flavor_execution" && var_1 != "flavor_s4_quip") {
    return;
  }

  if(var_0 scripts\mp\gametypes\br_public::ref_125ec()) {
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return;
  }

  if(var_0.team == "spectator") {
    return;
  }

  if(var_0.team == "follower") {
    return;
  }

  if(!isDefined(level.bcsounds[var_1])) {
    return;
  }

  if(!isDefined(var_0.bcinfolastsaytimes)) {
    return;
  }

  if(istrue(var_0.isspeakingbc)) {
    return;
  }

  if(var_0 scripts\mp\utility\player::isusingremote()) {
    return;
  }

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_no_battle_chatter")) {
    return;
  }

  if(var_1 == "inform_last_one") {
    switch (var_0.operatorcustomization.voice) {
      case "ukft1":
      case "ruft1":
        return;
    }
  }

  if(level.bcinfo["req_friendly"][var_1] && !friendly_nearby(var_0, 4840000) && !istrue(level.delete_race)) {
    return;
  }

  if(randomfloat(1) > level.bcinfo["chance"][var_1]) {
    return;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = getbcwaittime(var_0, var_1, var_3);

  if(var_4 > level.bcinfo["max_wait_time"] + var_3 * 1000) {
    return;
  }

  if(gettime() > var_0.clear_hint_objective + level.bcinfo["max_wait_time"] + var_3 * 1000) {
    var_0.bcinfoqueued = "none";
    var_0.clear_hint_objective = 0;
  }

  if(comparesoundpriorities(var_1, var_0.bcinfoqueued)) {
    var_0.bcinfoqueued = var_1;
    var_0.clear_hint_objective = gettime();
  } else {
    return;
  }

  level notify("kill_queued_bc_sound_" + var_0.name);
  return saylocalsound(var_0, var_4, var_1, var_2, var_3);
}

function saylocalsound(var_0, var_1, var_2, var_3) {
  level endon("kill_queued_bc_sound_" + self.name);
  self endon("death_or_disconnect");
  self endon("stop_battlechatter");
  wait var_0 / 1000;
  jumpiffalse(saidtoorecently(var_1)) LOC_00000031;
  return;
}

function getbcwaittime(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = 0;
  var_3 = 0;

  if(isDefined(level.bcinfo["last_say_time"]) && isDefined(level.bcinfo["last_say_time"][var_0])) {
    if(var_0 == "ping_enemy_general_o" || var_0 == "ping_enemy_infantry_o" || var_0 == "ping_enemy_multiple_o") {
      var_4 = [];
      GscBinSkip0(0x2e, var_4.size, "ping_enemy_general_o");
    }

    if(var_1 == "inform_on_your_six_o") {
      foreach(var_8 in level.bcinfo["last_say_pos"][var_1]) {
        if(distancesquared(var_8, self.origin) < 2250000) {
          var_9 = level.bcinfo["last_say_time"][var_1][var_10] + level.bcinfo["timeout"][var_1];

          if(var_9 > var_3) {
            var_3 = var_9;
          }

          var_4 = 1;
        }
      }
    } else if(isDefined(self.operatorcustomization)) {
      var_13 = level.bcinfo["last_say_pos"][var_1][self.operatorcustomization.voice];

      if(isDefined(var_13)) {
        var_3 = level.bcinfo["last_say_time"][var_1][self.operatorcustomization.voice] + level.bcinfo["timeout"][var_1];
        var_4 = distancesquared(var_13, self.origin) < 1048576;
      }
    }
  }

  if(!isDefined(self.bcinfolastsaytimes[var_1])) {
    self.bcinfolastsaytimes[var_1] = 0;
  }

  var_14 = self.bcinfolastsaytimes[var_1] + level.bcinfo["timeout_player"][var_1];
  var_15 = gettime() + var_2 * 1000;

  if(var_4) {
    var_16 = max(var_14, max(var_3, var_15));
  } else {
    var_16 = max(var_15, var_16);
  }

  var_17 = var_16 - gettime();
  return var_17;
}

function getspeakerinfo(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1000;
  }

  var_3 = var_2 * var_2;
  var_4 = [];
  GscBinSkip0(0x2e, "lower", []);
}

function comparesoundpriorities(var_0, var_1) {
  var_2 = var_1 == "none";

  if(var_2) {
    return var_2;
  }

  var_3 = level.bcinfo["priority"][var_1] < level.bcinfo["priority"][var_0];
  var_4 = level.bcinfo["priority"][var_1] == level.bcinfo["priority"][var_0] && scripts\engine\utility::cointoss();
  return var_3 || var_4;
}

function saidtoorecently(var_0, var_1) {
  if(!isDefined(self) || !scripts\mp\utility\teams::isgameplayteam(self.team)) {
    return 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = getbcwaittime(var_0, var_1);

  if(var_2 > level.bcinfo["max_wait_time"] + var_1 * 1000) {
    return 1;
  }

  return 0;
}