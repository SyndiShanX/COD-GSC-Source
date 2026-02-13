/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1872.gsc
*************************************************/

init() {
  level._id_237F = getdvarint("#x356a851900a3b0319", 1) == 1;
  level._id_8DCE = ::_id_AB14;
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
  _id_C240("ping_enemy_general_o", "ping_enemy_general_o", 1.0, 1.0, 15, 10);
  _id_C240("ping_enemy_infantry_o", "ping_enemy_infantry_o", 1.0, 1.0, 15, 10);
  _id_C240("ping_enemy_multiple_o", "ping_enemy_multiple_o", 1.0, 1.0, 15, 10);
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
  _id_C240("use_stim", "equipment_action_adrenaline", 0.4, 1.0, 5, 1);
  _id_C240("use_atmine", "equipment_action_atmine", 0.4, 1.0, 5, 1);
  _id_C240("use_claymore", "equipment_action_claymore", 0.4, 1.0, 5, 1);
  _id_C240("use_decoy", "equipment_action_decoy", 0.4, 1.0, 5, 1);
  _id_C240("drop_ammobox", "equipment_action_drop_ammobox", 0.4, 1.0, 5, 1);
  _id_C240("drop_armor", "equipment_action_drop_armor", 0.4, 1.0, 5, 1);
  _id_C240("drop_grenades", "equipment_action_drop_grenades", 0.4, 1.0, 5, 1);
  _id_C240("drop_selfrevive", "equipment_action_drop_selfrevive", 0.4, 1.0, 5, 1);
  _id_C240("use_explosives", "equipment_action_explosives", 0.4, 1.0, 5, 1);
  _id_C240("use_flash", "equipment_action_flashbang", 0.4, 1.0, 5, 1);
  _id_C240("use_gasmask", "equipment_action_gasmask", 0.4, 1.0, 5, 1);
  _id_C240("use_grenade", "equipment_action_grenade", 0.4, 1.0, 5, 1);
  _id_C240("use_grenade_throwback", "equipment_action_grenade_throwback", 0.4, 1.0, 5, 1);
  _id_C240("use_molotov", "equipment_action_molotov", 0.4, 1.0, 5, 1);
  _id_C240("use_powerup", "equipment_action_powerup", 0.4, 1.0, 5, 1);
  _id_C240("use_radsuit", "equipment_action_radsuit", 0.4, 1.0, 5, 1);
  _id_C240("use_rocket", "equipment_action_rocket", 0.4, 1.0, 5, 1);
  _id_C240("use_smoke", "equipment_action_smoke", 0.4, 1.0, 5, 1);
  _id_C240("use_stun", "equipment_action_stun", 0.4, 1.0, 5, 1);
  _id_C240("use_teargas", "equipment_action_teargas", 0.4, 1.0, 5, 1);
  _id_C240("use_thermite", "equipment_action_thermite", 0.4, 1.0, 5, 1);
  _id_C240("use_deadsilence", "equipment_fieldupgrade_deadsilence", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_emp_drone", "equipment_fieldupgrade_empdrone", 0.4, 1.0, 5, 1);
  _id_C240("use_recon_drone", "equipment_fieldupgrade_recon", 0.4, 1.0, 5, 1);
  _id_C240("use_self_revive", "equipment_fieldupgrade_selfrevive", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_tac_insert", "equipment_fieldupgrade_tacinsert", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_trophy", "equipment_fieldupgrade_trophy", 0.4, 1.0, 5, 1);
  _id_C240("incoming_c4", "equipment_incoming_c4", 0.4, 1.0, 5, 1);
  _id_C240("incoming_flash", "equipment_incoming_flashbang", 0.4, 1.0, 5, 1);
  _id_C240("incoming_gas", "equipment_incoming_gas", 0.4, 1.0, 5, 1);
  _id_C240("incoming_generic", "equipment_incoming_generic", 0.4, 1.0, 5, 1);
  _id_C240("incoming_grenade", "equipment_incoming_generic", 0.4, 1.0, 5, 1);
  _id_C240("incoming_molotov", "equipment_incoming_molotov", 0.4, 1.0, 5, 1);
  _id_C240("incoming_rpg", "equipment_incoming_rpg", 0.8, 1.0, 5, 5);
  _id_C240("incoming_stuck", "equipment_incoming_stuck", 0.4, 1.0, 5, 1);
  _id_C240("incoming_stun", "equipment_incoming_stun", 0.4, 1.0, 5, 1);
  _id_C240("incoming_thermite", "equipment_incoming_thermite", 0.4, 1.0, 5, 1);
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
  _id_C240("use_killstreak_juggernaut_local", "killstreaks_player_juggernaut_use", 0.4, 1.0, 5, 1, 0, 0);
  _id_C240("use_airstrike_callout", "killstreaks_player_airstrike_callout", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_airsupport_callout", "killstreaks_player_airsupport_callout", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_airdrop_callout", "killstreaks_player_airdrop_callout", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_recon_callout", "killstreaks_player_recon_callout", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_killstreak_nuke", "killstreaks_nuke_use", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_killstreak_scramblerdrone", "killstreaks_scrambler_use", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_killstreak_sentrygun", "killstreaks_sentry_use", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_killstreak_mobileturret", "killstreaks_shieldturret_use", 0.4, 1.0, 5, 1, 0);
  _id_C240("use_killstreak_dronesentry", "killstreaks_wheelson_use", 0.4, 1.0, 5, 1, 0);
  _id_C240("deathmachine_low", "mgal", 0.4, 1.0, 5, 1, 0);
  _id_C240("deathmachine_deplete", "mgad", 0.4, 1.0, 5, 1, 0);
  _id_C240("warmachine_low", "wmal", 0.4, 1.0, 5, 1, 0);
  _id_C240("warmachine_deplete", "wmad", 0.4, 1.0, 5, 1, 0);
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
  _id_C240("obj_hvi_pickup", "objectives_inform_pickup_hvi", 0.4, 1.0, 5, 1, 0, 0);
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
  _id_C240("flavor_revenge", "flavor_player_revenge", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_save", "flavor_player_save", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_suppressed", "flavor_player_suppressed", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_awesome", "flavor_player_awesome", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_closecall", "flavor_player_closecall", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_surprise", "flavor_player_surprise", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_execution", "flavor_player_execution", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_headshotlong", "flavor_player_headshotlong", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_positive", "flavor_positive", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_negative", "flavor_negative", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_shootnearmiss", "flavor_player_shootnearmiss", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_neardeathkill", "flavor_player_neardeathkill", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_goodhit", "flavor_goodhit", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_okay", "flavor_okay", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_hurryup", "flavor_hurryup", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_taunt_point", "flavor_taunt_point", 0.4, 1.0, 5, 1, 0);
  _id_C240("flavor_taunt_wave", "flavor_taunt_wave", 0.4, 1.0, 5, 1, 0);
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
  _id_C240("inform_respawn_enabled", "status_inform_respawn_enabled", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("inform_respawn_drop", "status_inform_respawn_drop", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("inform_insertion_jumpmaster", "status_inform_insertion_jumpmaster", 1.0, 1.0, 5, 5, 0, 0);
  _id_C240("ping_aidstation", "ping_aidstation", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_aidstation_carry", "ping_aidstation_carry", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_ambulance", "ping_ambulance", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_grenade_lethal", "ping_ammo_grenadelethal", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_grenade_tactical", "ping_ammo_grenadetactical", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_ammo_highcal", "ping_ammo_highcal", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_ammo_launcher", "ping_ammo_launcher", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_ammo_midcaliber", "ping_ammo_midcaliber", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_ammo_shotgun", "ping_ammo_shotgun", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_ammo_smallcal", "ping_ammo_smallcal", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_attachments_generic", "ping_attachments_generic", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_attachments_optics", "ping_attachments_optics", 1.0, 1.0, 0, 0, 0, 0);
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
  _id_C240("ping_dibs", "ping_dibs", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_attacking", "ping_enemy_attacking", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_bomber", "ping_enemy_bomber", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_general", "ping_enemy_general", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_goodkill", "ping_enemy_goodkill", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_infantry", "ping_enemy_infantry", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_multiple", "ping_enemy_multiple", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_rpg", "ping_enemy_rpg", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_sniper", "ping_enemy_sniper", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_three", "ping_enemy_three", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_traps", "ping_enemy_traps", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_two", "ping_enemy_two", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_vehicle_heavy", "ping_enemy_vehicle_heavy", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_enemy_vehicle_light", "ping_enemy_vehicle_light", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_fieldupgrade_drone", "ping_fieldupgrade_drone", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_fieldupgrade_supplybox", "ping_fieldupgrade_supplybox", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_fieldupgrade_tacinsert", "ping_fieldupgrade_tacinsert", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_airdrop", "ping_killstreaks_airdrop", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_carepkg", "ping_killstreaks_carepkg", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_cobalt", "ping_killstreaks_cobalt", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_gunship", "ping_killstreaks_gunship", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_helo", "ping_killstreaks_helo", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_juggernaut", "ping_killstreaks_juggernaut", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_ravager", "ping_killstreaks_ravager", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_recon", "ping_killstreaks_recon", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_scrambler", "ping_killstreaks_scrambler", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_sentry", "ping_killstreaks_sentry", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_shieldturret_enemy", "ping_killstreaks_shieldturret_enemy", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_shieldturret_open", "ping_killstreaks_shieldturret_open", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_killstreaks_wheelson", "ping_killstreaks_wheelson", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_location_follow", "ping_location_follow", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_location_generic", "ping_location_generic", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_location_gtfo", "ping_location_gtfo", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_location_landing", "ping_location_landing", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_location_landing_suggestion", "ping_location_landing_suggestion", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_location_looted", "ping_location_looted", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_location_regroup", "ping_location_regroup", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_need_armor", "ping_need_armor", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_need_gun", "ping_need_gun", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_need_helmet", "ping_need_helmet", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_need_highcal", "ping_need_highcal", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_need_launcher", "ping_need_launcher", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_need_medical", "ping_need_medical", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_need_midcal", "ping_need_midcal", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_need_shells", "ping_need_shells", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_need_smallcal", "ping_need_smallcal", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_objective_device", "ping_objective_device", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_pickup_armor", "ping_pickup_armor", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_pickup_generic", "ping_pickup_generic", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_pickup_health", "ping_pickup_health", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_pickup_riotshield", "ping_pickup_riotshield", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_plunder_bank", "ping_plunder_bank", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_plunder_cache", "ping_plunder_cache", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_plunder_loot", "ping_plunder_loot", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_plunder_vendor", "ping_plunder_vendor", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_response_affirm", "ping_response_affirm", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_response_cancel", "ping_response_cancel", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_response_copy", "ping_response_copy", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_response_helpme", "ping_response_helpme", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_response_leaveme", "ping_response_leaveme", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_response_revive", "ping_response_revive", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_response_thanks", "ping_response_thanks", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_response_thanks_specific", "ping_response_thanks_specific", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_vehicle_bailout", "ping_vehicle_bailout", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_vehicle_concat_no_driver", "ping_vehicle_concat_no_driver", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_vehicle_concat_no_pilot", "ping_vehicle_concat_no_pilot", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_vehicle_driver", "ping_vehicle_driver", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_vehicle_gunner", "ping_vehicle_gunner", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_vehicle_heavy", "ping_vehicle_heavy", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_vehicle_helo", "ping_vehicle_helo", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_vehicle_light", "ping_vehicle_light", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_vehicle_needride", "ping_vehicle_needride", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_vehicle_pilot", "ping_vehicle_pilot", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_vehicle_rider", "ping_vehicle_rider", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_weapon_assaultrifle", "ping_weapon_assaultrifle", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_weapon_custom", "ping_weapon_custom", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_weapon_dmr", "ping_weapon_dmr", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_weapon_launcher", "ping_weapon_launcher", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_weapon_lmg", "ping_weapon_lmg", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_weapon_melee", "ping_weapon_melee", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_weapon_pistol", "ping_weapon_pistol", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_weapon_shotgun", "ping_weapon_shotgun", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_weapon_smg", "ping_weapon_smg", 1.0, 1.0, 0, 0, 0, 0);
  _id_C240("ping_weapon_sniper", "ping_weapon_sniper", 1.0, 1.0, 0, 0, 0, 0);
  _id_06C9::_id_2446();
  var_3 = getDvar("#x315af23e89f368200");
  level._id_8A89 = 1;

  if(var_3 == "war" || var_3 == "kc" || var_3 == "dom" || var_3 == "cmd" || var_3 == "arm") {
    level._id_8A89 = 0;
  }

  _id_0961::_id_C28D(::onplayerspawned);

  if(!isDefined(game["allies"])) {
    game["allies"] = "SAS";
  }

  if(!isDefined(game["axis"])) {
    game["axis"] = "RUSF";
  }

  if(!isDefined(game["team_three"])) {
    game["team_three"] = "USMC";
  }

  if(!isDefined(game["team_four"])) {
    game["team_four"] = "SABF";
  }

  if(!isDefined(game["team_five"])) {
    game["team_five"] = "SAS";
  }

  if(!isDefined(game["team_six"])) {
    game["team_six"] = "RUSF";
  }
}

_id_C240(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  level._id_2459[var_0] = var_1;
  level._id_2430["priority"][var_0] = var_2;
  level._id_2430["chance"][var_0] = var_3;
  level._id_2430["timeout"][var_0] = var_4 * 1000;
  level._id_2430["timeout_player"][var_0] = var_5 * 1000;
  level._id_2430["req_friendly"][var_0] = var_6;
  level._id_2430["play_for_all"][var_0] = var_7;
  level._id_2430["play_for_squad_only"][var_0] = var_8;
}

onplayerspawned() {
  self._id_2432 = "none";
  self._id_C0ED = [];
  self._id_2431 = [];

  if(!isDefined(level._id_2430["last_say_time"])) {
    level._id_2430["last_say_time"] = [];
    level._id_2430["last_say_pos"] = [];
  }

  if(!isDefined(level._id_2430["last_say_time"][self.team])) {
    level._id_2430["last_say_time"][self.team] = [];
    level._id_2430["last_say_pos"][self.team] = [];
  }

  if(level.splitscreen) {
    return;
  }
  if(!level.teambased) {
    return;
  }
  if(!_id_CA4B()) {
    thread _id_C31B();
    thread _id_E463();
    thread _id_EBB0();
    thread _id_F161();
  } else
    self._id_2429 = 1;
}

_id_7BE2() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bc_damage_taken");
  wait 1.5;
  level thread _id_F759(self, "hurt_badly");
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
    level thread _id_F759(self, "multiple_attackers");
  }
}

_id_8B9F(var_0, var_1) {
  if(!level.teambased) {
    return;
  }
  var_2 = scripts\engine\utility::random(scripts\cp\utility::_id_6BE2(var_0));
  var_3 = scripts\cp\utility::_id_6C5F(var_1, 360000, var_2);

  if(var_3.size == 0) {
    return;
  } else {
    var_4 = scripts\engine\utility::random(var_3);
    level thread _id_F759(var_4, "javelin_target", undefined, 0.5);
  }
}

_id_AB3D(var_0) {
  switch (var_0) {
    case "ammo_crate":
      level thread _id_F759(self, "drop_ammobox");
      break;
    case "armor":
      level thread _id_F759(self, "drop_armor");
      break;
    case "adrenaline":
      level thread _id_F759(self, "drop_selfrevive");
      break;
    case "grenade_crate":
      level thread _id_F759(self, "drop_grenades");
      break;
    case "deployable_vest":
      level thread _id_F759(self, "use_radsuit");
      break;
  }
}

_id_AAF8(var_0) {
  switch (var_0.weapon_name) {
    case "frag_grenade_mp":
      level thread _id_F759(self, "use_grenade");
      break;
    case "semtex_mp":
      level thread _id_F759(self, "use_grenade");
      break;
    case "molotov_mp":
      level thread _id_F759(self, "use_molotov");
      break;
    case "equip_pop_rocket":
      level thread _id_F759(self, "use_rocket");
      break;
    case "thermite_mp":
      level thread _id_F759(self, "use_thermite");
      break;
    case "c4_mp_p":
      level thread _id_F759(self, "use_explosives");
      break;
    case "claymore_mp":
      level thread _id_F759(self, "use_claymore");
      break;
    case "equip_at_mine":
      level thread _id_F759(self, "use_atmine");
      break;
    case "flash_grenade_mp":
      level thread _id_F759(self, "use_flash");
      break;
    case "concussion_grenade_mp":
      level thread _id_F759(self, "use_stun");
      break;
    case "sensor_grenade_mp":
      break;
    case "smoke_grenade_mp":
      level thread _id_F759(self, "use_smoke");
      break;
    case "gas_grenade_mp":
      level thread _id_F759(self, "use_teargas");
      break;
    case "decoy_grenade_mp":
      level thread _id_F759(self, "use_decoy");
      break;
    case "equip_adrenaline":
      level thread _id_F759(self, "use_stim");
      break;
    case "deployable_cover_mp":
      break;
    case "trophy_mp":
      level thread _id_F759(self, "use_trophy");
      break;
    case "support_box_mp":
      level thread _id_F759(self, "drop_ammobox");
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
    case "deployable_cover_mp":
    case "decoy_grenade_mp":
    case "gas_grenade_mp":
    case "equip_adrenaline":
    case "trophy_mp":
    case "thermite_mp":
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

  for(;;) {
    var_2 = scripts\common\utility::_id_B7BF(self.origin, 384);

    foreach(var_4 in var_2) {
      if(!isDefined(var_4) || !isalive(var_4) || isDefined(self.owner) && self.owner scripts\cp\utility::isenemy(var_4) == 0) {
        continue;
      }
      var_5 = distancesquared(self.origin, var_4.origin);

      if(isDefined(var_5) && var_5 < 384) {
        if(!_func_0202(var_4 getEye(), self.origin, 0, var_4)) {
          continue;
        }
        switch (var_0) {
          case "frag_grenade_mp":
            level thread _id_F759(var_4, "incoming_grenade");
            break;
          case "concussion_grenade_mp":
            level thread _id_F759(var_4, "incoming_stun");
            break;
          case "flash_grenade_mp":
            level thread _id_F759(var_4, "incoming_flash");
            break;
          case "smoke_grenade_mp":
            level thread _id_F759(var_4, "incoming_generic");
            break;
          case "semtex_mp":
            level thread _id_F759(var_4, "incoming_grenade");
            break;
          case "molotov_mp":
            level thread _id_F759(var_4, "incoming_molotov");
            break;
          case "equip_pop_rocket":
            level thread _id_F759(var_4, "incoming_generic");
            break;
          case "c4_mp_p":
            level thread _id_F759(var_4, "incoming_c4");
            break;
          case "sensor_grenade_mp":
            level thread _id_F759(var_4, "incoming_generic");
            break;
          case "thermite_mp":
            level thread _id_F759(var_4, "incoming_thermite");
            break;
          case "gas_grenade_mp":
            level thread _id_F759(var_4, "incoming_gas");
            break;
          default:
            if(weaponclass(self.weapon_name) == "rocketlauncher") {
              level thread _id_F759(var_4, "incoming_rpg");
            }

            break;
        }
      }

      waitframe();
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
  switch (var_0.weapon_name) {
    case "c4_mp_p":
      level thread _id_F759(self, "destroyed_c4");
      break;
    case "at_mine_mp":
      level thread _id_F759(self, "destroyed_atmine");
      break;
    case "claymore_mp":
      level thread _id_F759(self, "destroyed_claymore");
      break;
    case "trophy_mp":
      level thread _id_F759(self, "destroyed_trophy");
      break;
    case "deployable_cover_mp":
      level thread _id_F759(self, "destroyed_cover");
      break;
    case "decoy_grenade_mp":
      level thread _id_F759(self, "destroyed_decoy");
      break;
    case "gas_grenade_mp":
      level thread _id_F759(self, "destroyed_teargas");
      break;
    case "sensor_grenade_mp":
      level thread _id_F759(self, "destroyed_snapshot");
      break;
    case "support_box_mp":
      level thread _id_F759(self, "destroyed_supportbox");
      break;
  }
}

_id_AB14(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "gunship":
      level thread _id_F759(var_0, "use_airsupport_callout");
      break;
    case "chopper_gunner":
      level thread _id_F759(var_0, "use_airsupport_callout");
      break;
    case "death_switch":
      level thread _id_F759(var_0, "use_killstreak_deadman");
      break;
    case "pac_sentry":
      level thread _id_F759(var_0, "use_killstreak_dronesentry");
      break;
    case "hover_jet":
      level thread _id_F759(var_0, "use_airstrike_callout");
      break;
    case "juggernaut":
      level thread _id_F759(var_0, "use_airdrop_callout");
      break;
    case "bradley":
      level thread _id_F759(var_0, "use_killstreak_lighttank");
      break;
    case "manual_turret":
      level thread _id_F759(var_0, "use_killstreak_mobileturret");
      break;
    case "sentry_gun":
      level thread _id_F759(var_0, "use_killstreak_sentrygun");
      break;
    case "toma_strike":
      level thread _id_F759(var_0, "use_airstrike_callout");
      break;
    case "cruise_predator":
      level thread _id_F759(var_0, "use_airstrike_callout");
      break;
    case "nuke":
      level thread _id_F759(var_0, "use_killstreak_nuke");
      break;
    case "nuke_select_location":
      level thread _id_F759(var_0, "use_killstreak_nuke");
      break;
    case "precision_airstrike":
      level thread _id_F759(var_0, "use_airstrike_callout");
      break;
    case "fuel_airstrike":
      level thread _id_F759(var_0, "use_airstrike_callout");
      break;
    case "directional_uav":
      level thread _id_F759(var_0, "use_recon_callout");
      break;
    case "airdrop":
      level thread _id_F759(var_0, "use_airdrop_callout");
      break;
    case "emergency_airdrop":
      level thread _id_F759(var_0, "use_airdrop_callout");
      break;
    case "radar_drone_overwatch":
      level thread _id_F759(var_0, "use_recon_callout");
      break;
    case "scrambler_drone_guard":
      level thread _id_F759(var_0, "use_killstreak_scramblerdrone");
      break;
    case "uav":
      level thread _id_F759(var_0, "use_recon_callout");
      break;
  }
}

_id_8DDC(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "gunship":
      level thread _id_F759(self, "lockon_killstreak_ac130");
      break;
    case "chopper_gunner":
      level thread _id_F759(self, "lockon_killstreak_choppergunner");
      break;
    case "pac_sentry":
      level thread _id_F759(self, "lockon_killstreak_dronesentry");
      break;
    case "hover_jet":
      level thread _id_F759(self, "lockon_killstreak_harrier");
      break;
    case "bradley":
      level thread _id_F759(self, "lockon_killstreak_lighttank");
      break;
    case "manual_turret":
      level thread _id_F759(self, "lockon_killstreak_mobileturret");
      break;
    case "sentry_gun":
      level thread _id_F759(self, "lockon_killstreak_sentrygun");
      break;
    case "uav":
      level thread _id_F759(self, "lockon_killstreak_uav");
      break;
    case "directional_uav":
      level thread _id_F759(self, "lockon_killstreak_advuav");
      break;
    case "scrambler_drone_guard":
      level thread _id_F759(self, "lockon_killstreak_scramblerdrone");
      break;
    case "radar_drone_escort":
      level thread _id_F759(self, "lockon_killstreak_radardrone");
      break;
  }
}

_id_8DCF(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "gunship":
      level thread _id_F759(self, "killfirm_gunship");
      break;
    case "chopper_support":
    case "chopper_gunner":
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
  level thread _id_F759(self, "suppressing_fire");
}

_id_C31B() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();
    var_1 = self getweaponammoclip(var_0) + self getweaponammostock(var_0);

    if(var_1 <= weaponclipsize(var_0)) {
      var_2 = scripts\cp\cp_weapon::getweapongroup(var_0);
      var_3 = var_2 == "weapon_shotgun" || var_2 == "weapon_projectile" || scripts\cp\utility::getweaponrootname(var_0) == "s4_ar_stango44";

      if(!var_3) {
        if(istrue(level _id_F759(self, "last_mag"))) {
          switch (var_2) {
            case "weapon_smg":
            case "weapon_pistol":
              level thread _id_F759(self, "last_mag_small");
              break;
            case "weapon_assault":
              level thread _id_F759(self, "last_mag_mid");
              break;
            case "weapon_dmr":
            case "weapon_lmg":
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

    if(self._id_C0ED.size > 0) {
      level thread _id_F759(self, "flavor_negative");
      continue;
    }

    level thread _id_F759(self, "reload");
  }
}

_id_E463() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("sprint_begin");
    level thread _id_F759(self, "moving");
  }
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

    if(_id_CB08("callout_location") && _id_CB08("callout_generic")) {
      continue;
    }
    var_0 = self _meth_8177();

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = 0;
    var_2 = 4000000;

    if(self playerads() > 0.7) {
      var_2 = 6250000;
    }

    var_3 = 0;

    foreach(var_5 in var_0) {
      if(isDefined(var_5) && var_5 scripts\cp_mp\utility\player_utility::_isalive() && !var_5 scripts\cp\utility::_hasperk("specialty_coldblooded") && distancesquared(self.origin, var_5.origin) < var_2) {
        var_6 = var_5 _id_6E2F(self);
        var_1 = 1;

        if(isDefined(var_6) && !_id_CB08("callout_location") && _id_5F94(4840000)) {
          if(scripts\cp\utility::_hasperk("specialty_quieter") || !_id_5F94(262144)) {
            level thread _id_F759(self, "callout_location", var_6._id_96D6[0]);
            var_3 = 1;
          } else {
            level thread _id_F759(self, "callout_location", var_6._id_96D6[0]);
            var_3 = 1;
          }

          break;
        }
      }
    }

    if(!var_3 && var_1) {
      level thread _id_F759(self, "callout_generic");
      level thread _id_CB70(self, "plr_target_generic", undefined, 0.75);
    }
  }
}

_id_4E7C(var_0, var_1) {
  var_2 = level._id_2459[var_0];

  if(isDefined(var_1)) {
    var_2 = "loc_callout_" + var_1;
  }

  var_3 = _id_6AC1(self);

  if(!isDefined(self._id_AC3D)) {
    return;
  }
  if(var_0 == "flavor_execution") {
    if(self._id_AC3D._id_5704 == "none") {
      return;
    }
    var_2 = var_2 + self._id_AC3D._id_5704;
  }

  var_5 = "dx_mpb_" + self._id_AC3D._id_10691 + "_" + var_2;

  if(_func_00D6(var_2, var_2.size - 2, var_2.size) == "_o") {
    var_2 = _func_00D6(var_2, 0, var_2.size - 2);
  }

  var_6 = "dx_mpp_" + self._id_AC3D._id_10691 + "_" + var_2;
  var_7 = _func_0205(var_5);
  var_8 = _func_0205(var_6);
  var_9 = 0.0;
  var_10 = 0.0;

  if(!var_7) {} else
    var_9 = _func_0142(var_5);

  if(!var_8) {} else
    var_10 = _func_0142(var_6);

  if(self _meth_81E2()) {
    _id_B36A(var_7, var_8, var_0, var_6, var_5);
  } else {
    _id_B368(var_7, var_8, var_0, var_6, var_5);
  }

  if(isDefined(var_1)) {
    _id_96D0(var_1, self.team);
  }

  var_11 = level._id_2430["priority"][var_0];
  var_12 = self.team;
  level _id_1138(self, var_12, var_5, var_0, var_11);
  _id_FC2A(var_0);
  var_13 = max(var_9, var_10) / 1000;
  thread _id_F211(var_5, var_13);
  scripts\engine\utility::waittill_any_2(var_5, "death_or_disconnect");
  level _id_C529(self, var_12);
  return 1;
}

_id_B368(var_0, var_1, var_2, var_3, var_4) {
  if(var_0) {
    if(level._id_2430["play_for_all"][var_2]) {
      foreach(var_6 in level._id_EF89) {
        if(var_6 == self.team) {
          if(var_1) {
            self playsoundtoteam(var_4, var_6, self);
          } else {
            self playsoundtoteam(var_4, var_6);
          }

          continue;
        }

        self playsoundtoteam(var_4, var_6);
      }
    } else if(var_1)
      self playsoundtoteam(var_4, self.team, self);
    else {
      self playsoundtoteam(var_4, self.team);
    }
  }

  if(var_1) {
    self playsoundtoplayer(var_3, self);
  }
}

_id_B36A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self _meth_81E4();
  var_6 = [var_5];

  if(var_1) {
    var_6[var_6.size] = self;
  }

  if(var_0) {
    if(level._id_2430["play_for_all"][var_2]) {
      foreach(var_8 in level._id_EF89) {
        if(var_8 == self.team) {
          var_9 = level._id_EF6A[self.team]["players"];

          foreach(var_11 in var_9) {
            if(!scripts\engine\utility::array_contains(var_6, var_11)) {
              self playsoundtoplayer(var_4, var_11);
            }
          }

          continue;
        }

        self playsoundtoteam(var_4, var_8);
      }
    } else {
      var_9 = level._id_EF6A[self.team]["players"];

      foreach(var_11 in var_9) {
        if(!scripts\engine\utility::array_contains(var_6, var_11)) {
          self playsoundtoplayer(var_4, var_11);
        }
      }
    }
  }

  if(var_1) {
    self playsoundtoplayer(var_3, self);
  }
}

_id_4E85(var_0, var_1) {
  var_2 = scripts\engine\utility::_id_10897(var_0, "death_or_disconnect");

  if(isDefined(var_2) && var_2 == var_0) {
    var_3 = self.team;
    var_4 = self.origin;
    wait 0.5;
    var_5 = _id_6A59(var_3, 1);

    foreach(var_7 in var_5) {
      if(!isDefined(var_7)) {
        continue;
      }
      if(var_7 == self) {
        continue;
      }
      if(!var_7 scripts\cp_mp\utility\player_utility::_isalive()) {
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
        var_9 = "dx_mpb_" + var_7._id_AC3D._id_10691 + "_loc_" + var_1 + "_echo";

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

_id_C529(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level._id_E3B0[var_1].size; var_3++) {
    if(isDefined(var_0) && isDefined(level._id_E3B0[var_1][var_3]["player"]) && level._id_E3B0[var_1][var_3]["player"] == var_0) {
      continue;
    }
    var_2[var_2.size] = level._id_E3B0[var_1][var_3];
  }

  level._id_E3B0[var_1] = var_2;
}

_id_4A81(var_0) {
  var_0._id_2429 = 1;
}

_id_523A(var_0) {
  var_0._id_2429 = undefined;
}

_id_FC2A(var_0) {
  var_1 = self.pers["team"];
  var_2 = gettime();
  self._id_2431[var_0] = var_2;
  level._id_2430["last_say_time"][var_1][var_0] = var_2;
  level._id_2430["last_say_pos"][var_1][var_0] = self.origin;
  _id_388D(var_2);
}

_id_388D(var_0) {
  var_1 = self.pers["team"];
  var_2 = [];

  foreach(var_6, var_4 in self._id_2431) {
    var_5 = level._id_2430["timeout_player"][var_6] + var_4;

    if(var_0 < var_5) {
      var_2[var_6] = var_4;
    }
  }

  self._id_2431 = var_2;
  var_2 = [];
  var_7 = [];

  foreach(var_6, var_4 in level._id_2430["last_say_time"][var_1]) {
    if(var_0 < var_4 + level._id_2430["timeout"][var_6]) {
      var_2[var_6] = var_4;
      var_7[var_6] = level._id_2430["last_say_pos"][var_1][var_6];
    }
  }

  level._id_2430["last_say_time"][var_1] = var_2;
  level._id_2430["last_say_pos"][var_1] = var_7;
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

_id_96D0(var_0) {
  anim._id_96D9[var_0] = gettime();
}

_id_96D3(var_0) {
  if(isDefined(anim._id_96D9[var_0])) {
    return anim._id_96D9[var_0];
  }

  return undefined;
}

_id_3150(var_0) {
  foreach(var_2 in var_0._id_96D6) {
    var_3 = _id_6B1E("loc_callout_" + var_2);
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
  var_1 = "dx_mpb_" + self._id_AC3D._id_10691 + "_" + var_0 + "_" + _id_6AC1(self);
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

  var_1 = _id_6A59(self.team, 1);

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
  if(isagent(var_0) || !isPlayer(var_0)) {
    return;
  }
  if(istrue(var_0._id_2429)) {
    return;
  }
  var_4 = _id_6AC1(var_0);
  var_5 = "";

  if(isDefined(var_0._id_AC3D) && isDefined(var_0._id_AC3D._id_10691) && isDefined(var_1)) {
    var_5 = "dx_mpb_" + var_0._id_AC3D._id_10691 + "_" + var_1;
  }

  if(!isDefined(var_1) || !_func_0205(var_5)) {
    if(!isDefined(var_2)) {
      return;
    }
    var_1 = var_2;
    var_5 = "dx_mpb_" + var_0._id_AC3D._id_10691 + "_" + var_1;

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

  for(;;) {
    self.pers["selfVOBonusChance"] = self.pers["selfVOBonusChance"] + 0.1;
    wait 3.0;
  }
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
  var_2 = "dx_mpb_" + self._id_AC3D._id_10691 + "_" + var_0;
  self.pers["selfVOBonusChance"] = 0;
  self._id_BED2 = "none";
  var_3 = _func_0142(var_2) / 1000;
  self._id_903E = gettime();
  thread _id_B867(var_3);
  thread _id_FD22(var_0);
  self playsoundtoplayer(var_2, self);
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
  var_2 = _id_6DE7();
  var_3 = var_0 _id_6907();

  if(var_3 > 5000 || var_2 >= 80 || scripts\cp\utility::_id_82D1()) {
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
    if(!var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    var_5 = max(scripts\engine\utility::_id_4B8C(var_0.origin, var_4.origin), 1.0);

    if(scripts\cp\cp_weapon::_id_879A(var_1.basename) || scripts\cp\cp_weapon::_id_879C(var_1.basename)) {
      var_6 = 0;
      var_7 = scripts\cp\cp_weapon::getweapongroup(var_1.basename);

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
      if(scripts\cp\utility::weaponhasattachment(var_1, "silencer")) {
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

_id_10AE() {
  level thread _id_F759(self, "flavor_execution", undefined, 0.75);
}

_id_10A3(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_1) && isDefined(var_0)) {
    var_4 = scripts\cp\cp_weapon::getweapongroup(var_1);

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
  wait 25;

  for(;;) {
    if(!_id_CB08("behind_friendly")) {
      var_0 = _id_6A59(self.team, 1);

      foreach(var_2 in var_0) {
        if(var_2 == self) {
          continue;
        }
        if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        if(!scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        if(_id_FF4A(self, var_2)) {
          break;
        }
      }
    }

    wait 0.15;
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

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_34E9();
}

_id_34E9() {
  var_0 = _id_6A59(self.team, 1);

  foreach(var_2 in var_0) {
    if(var_2 == self) {
      continue;
    }
    if(distancesquared(self.origin, var_2.origin) <= 262144) {
      var_3 = anglesToForward(var_2 getplayerangles());

      if(length(var_2.origin - self.origin) > 0) {
        if(scripts\engine\math::_id_178B(var_3, var_2.origin - self.origin) < 80) {
          level thread _id_F759(var_2, "casualty", undefined, 0.75);
          break;
        }
      }
    }
  }
}

_id_F2DF(var_0) {
  level._id_237F = var_0;
}

_id_F759(var_0, var_1, var_2, var_3) {
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
  if(var_0.team == "spectator") {
    return;
  }
  if(!isDefined(level._id_2459[var_1])) {
    return;
  }
  if(istrue(var_0._id_8A4C)) {
    return;
  }
  if(!isDefined(level._id_242B)) {
    level._id_242B = [];
  }

  if(!isDefined(level._id_242B[var_1])) {
    level._id_242B[var_1] = 1;
  } else {
    level._id_242B[var_1]++;
  }

  if(getdvarint("#x3cdf950789b627743", 0) <= 0 && level._id_2430["req_friendly"][var_1] && !var_0 _id_5F94(4840000)) {
    return;
  }
  if(randomfloat(1) > level._id_2430["chance"][var_1]) {
    return;
  }
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = var_0 _id_6909(var_1, var_3);

  if(var_4 > level._id_2430["max_wait_time"] + var_3 * 1000) {
    return;
  }
  if(_id_3B02(var_1, var_0._id_2432)) {
    var_0._id_2432 = var_1;
  } else {
    return;
  }

  level notify("kill_queued_bc_sound_" + var_0.name);
  var_0 thread _id_CB6E(var_4, var_1, var_2, var_3);
  return _id_6E49(var_0, var_1, var_2);
}

_id_6E49(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_AC3D)) {
    return 0;
  }

  var_4 = level._id_2459[var_1];

  if(isDefined(var_2)) {
    var_4 = "loc_callout_" + var_2;
  }

  var_5 = _id_6AC1(var_0);
  var_6 = "dx_mpb_" + var_0._id_AC3D._id_10691 + "_" + var_4 + "_" + var_5;
  var_7 = "dx_mpp_" + var_0._id_AC3D._id_10691 + "_" + var_4;
  var_8 = _func_0205(var_6);
  var_9 = _func_0205(var_7);
  var_10 = 0.4;

  if(getdvarint("#x3ad67579137c951a9") != 0 && getdvarint("#x3ad67579137c951a9") != 1) {
    var_10 = 1.4;
  }

  if(istrue(var_8)) {
    return _func_0142(var_6) / 1000 + var_10;
  } else if(istrue(var_9)) {
    return _func_0142(var_7) / 1000 + var_10;
  }

  return 0;
}

_id_CB6E(var_0, var_1, var_2, var_3) {
  level endon("kill_queued_bc_sound_" + self.name);
  self endon("death_or_disconnect");
  wait(var_0 / 1000);

  if(_id_CB08(var_1)) {
    return;
  }
  while(var_0 <= level._id_2430["max_wait_time"] + var_3 * 1000) {
    var_4 = _id_6D61(self, level._id_2430["priority"][var_1]);

    if(isDefined(var_4["higher"])) {
      var_5 = gettime();
      var_4["higher"]["player"] scripts\engine\utility::waittill_any_3(var_4["higher"]["sound_alias"], "death", "disconnect");
      waitframe();
      var_0 = var_0 + (gettime() - var_5);
      continue;
    }

    var_6 = var_4["lower"];

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(isDefined(var_6[var_7]["player"])) {
        var_6[var_7]["player"] notify(var_6[var_7]["sound_alias"] + "_interrupt");

        if(_func_0205(var_6[var_7]["sound_alias"])) {
          var_6[var_7]["player"] _meth_83EF(var_6[var_7]["sound_alias"]);
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
    thread _id_4E7C(var_1, var_2);
  }
}

_id_6909(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = 0;
  var_3 = 0;

  if(isDefined(level._id_2430["last_say_time"]) && isDefined(level._id_2430["last_say_time"][self.team]) && isDefined(level._id_2430["last_say_time"][self.team][var_0])) {
    var_2 = level._id_2430["last_say_time"][self.team][var_0] + level._id_2430["timeout"][var_0];
    var_3 = distancesquared(level._id_2430["last_say_pos"][self.team][var_0], self.origin) < 1048576;
  }

  if(!isDefined(self._id_2431)) {
    onplayerspawned();
  }

  if(!isDefined(self._id_2431[var_0])) {
    self._id_2431[var_0] = 0;
  }

  var_4 = self._id_2431[var_0] + level._id_2430["timeout_player"][var_0];
  var_5 = gettime() + var_1 * 1000;

  if(var_3) {
    var_6 = max(var_4, max(var_2, var_5));
  } else {
    var_6 = max(var_4, var_5);
  }

  var_7 = var_6 - gettime();
  return var_7;
}

_id_6D61(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1000;
  }

  var_3 = var_2 * var_2;
  var_4 = [];
  var_4["lower"] = [];

  if(isDefined(var_0) && isDefined(var_0.team) && var_0.team != "spectator") {
    for(var_5 = 0; var_5 < level._id_E3B0[var_0.team].size; var_5++) {
      var_6 = level._id_E3B0[var_0.team][var_5];
      var_7 = var_6["player"];
      var_8 = var_6["priority"];

      if(!isDefined(var_7)) {
        continue;
      }
      if(distancesquared(var_7.origin, var_0.origin) < var_3) {
        if(isDefined(var_8)) {
          if(var_8 > var_1 || var_8 == var_1 && scripts\engine\utility::cointoss()) {
            var_4["higher"] = var_6;
            return var_4;
          } else
            var_4["lower"][var_4["lower"].size] = var_6;
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
  if(!isDefined(self) || !scripts\cp\utility::_id_8878(self.team)) {
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

_id_CA4B() {
  return 0;
}

_id_6DE7() {
  return 50;
}

_id_6DDF(var_0) {
  if(!isDefined(level._id_EF6A)) {
    level._id_EF6A = [];
  }

  if(!isDefined(level._id_EF6A[var_0])) {
    level._id_EF6A[var_0] = [];
  }

  if(!isDefined(level._id_EF6A[var_0]["soundInfix"])) {
    level._id_EF6A[var_0]["soundInfix"] = _func_0222("mp/factionTable.csv", 0, game[var_0], 8);
  }

  return level._id_EF6A[var_0]["soundInfix"];
}

_id_6A59(var_0, var_1) {
  var_2 = [];

  if(istrue(var_1)) {
    foreach(var_4 in scripts\cp\utility::_id_6C61(var_0)) {
      if(isDefined(var_4) && isalive(var_4) && !isDefined(var_4._id_59E0)) {
        var_2[var_2.size] = var_4;
      }
    }
  } else {
    foreach(var_4 in scripts\cp\utility::_id_6C61(var_0)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_B86D(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "chopper_support":
    case "chopper_gunner":
    case "gunship":
      level thread _id_F759(var_0, "use_airsupport_callout");
      break;
    case "death_switch":
      level thread _id_F759(var_0, "use_killstreak_deadman");
      break;
    case "pac_sentry":
      level thread _id_F759(var_0, "use_killstreak_dronesentry");
      break;
    case "airdrop_multiple":
    case "airdrop":
    case "bradley":
    case "juggernaut":
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
    case "white_phosphorus":
    case "fuel_airstrike":
    case "precision_airstrike":
    case "cruise_predator":
    case "toma_strike":
    case "hover_jet":
      level thread _id_F759(var_0, "use_airstrike_callout");
      break;
    case "uav":
    case "radar_drone_overwatch":
    case "directional_uav":
      level thread _id_F759(var_0, "use_recon_callout");
      break;
    case "scrambler_drone_guard":
      level thread _id_F759(var_0, "use_killstreak_scramblerdrone");
      break;
  }
}