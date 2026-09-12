/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_player_battlechatter.gsc
**************************************************/

function init() {
  level.battlechatterenabled = getdvarint("scr_game_battlechatter_enabled", 1) == 1;
  level.killstreakdeploystartbcfunc = &onkillstreakdeploy;
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
  registerbcsoundtype("ping_enemy_general_o", "ping_enemy_general_o", 1, 1, 15, 10);
  registerbcsoundtype("ping_enemy_infantry_o", "ping_enemy_infantry_o", 1, 1, 15, 10);
  registerbcsoundtype("ping_enemy_multiple_o", "ping_enemy_multiple_o", 1, 1, 15, 10);
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
  registerbcsoundtype("incoming_flash", "equipment_incoming_flashbang", 0.4, 1, 5, 1);
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
  registerbcsoundtype("obj_hvi_pickup", "objectives_inform_pickup_hvi", 0.4, 1, 5, 1, 0, 0);
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
  registerbcsoundtype("flavor_revenge", "flavor_player_revenge", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_save", "flavor_player_save", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_suppressed", "flavor_player_suppressed", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_awesome", "flavor_player_awesome", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_closecall", "flavor_player_closecall", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_surprise", "flavor_player_surprise", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_execution", "flavor_player_execution", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_headshotlong", "flavor_player_headshotlong", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_positive", "flavor_positive", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_negative", "flavor_negative", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_shootnearmiss", "flavor_player_shootnearmiss", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_neardeathkill", "flavor_player_neardeathkill", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_goodhit", "flavor_goodhit", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_okay", "flavor_okay", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_hurryup", "flavor_hurryup", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_taunt_point", "flavor_taunt_point", 0.4, 1, 5, 1, 0);
  registerbcsoundtype("flavor_taunt_wave", "flavor_taunt_wave", 0.4, 1, 5, 1, 0);
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
  registerbcsoundtype("inform_respawn_enabled", "status_inform_respawn_enabled", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("inform_respawn_drop", "status_inform_respawn_drop", 1, 1, 5, 5, 0, 0);
  registerbcsoundtype("inform_insertion_jumpmaster", "status_inform_insertion_jumpmaster", 1, 1, 5, 5, 0, 0);
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
  registerbcsoundtype("ping_vehicle_driver", "ping_vehicle_driver", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("ping_vehicle_gunner", "ping_vehicle_gunner", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("ping_vehicle_heavy", "ping_vehicle_heavy", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("ping_vehicle_helo", "ping_vehicle_helo", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("ping_vehicle_light", "ping_vehicle_light", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("ping_vehicle_needride", "ping_vehicle_needride", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("ping_vehicle_pilot", "ping_vehicle_pilot", 1, 1, 0, 0, 0, 0);
  registerbcsoundtype("ping_vehicle_rider", "ping_vehicle_rider", 1, 1, 0, 0, 0, 0);
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
  scripts\common\bcs_location_trigs::bcs_location_trigs_init();
  var_3 = getDvar("g_gametype");
  level.istactical = 1;

  if(var_3 == "war" || var_3 == "kc" || var_3 == "dom" || var_3 == "cmd" || var_3 == "arm") {
    level.istactical = 0;
  }

  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);

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
    return;
  }
}

function registerbcsoundtype(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  level.bcsounds[var_0] = var_1;
  level.bcinfo["priority"][var_0] = var_2;
  level.bcinfo["chance"][var_0] = var_3;
  level.bcinfo["timeout"][var_0] = var_4 * 1000;
  level.bcinfo["timeout_player"][var_0] = var_5 * 1000;
  level.bcinfo["req_friendly"][var_0] = var_6;
  level.bcinfo["play_for_all"][var_0] = var_7;
  level.bcinfo["play_for_squad_only"][var_0] = var_8;
}

function onplayerspawned() {
  self.bcinfoqueued = "none";
  self.recentattackers = [];
  self.bcinfolastsaytimes = [];

  if(!isDefined(level.bcinfo["last_say_time"])) {
    level.bcinfo["last_say_time"] = [];
    level.bcinfo["last_say_pos"] = [];
  }

  if(!isDefined(level.bcinfo["last_say_time"][self.team])) {
    level.bcinfo["last_say_time"][self.team] = [];
    level.bcinfo["last_say_pos"][self.team] = [];
  }

  if(level.splitscreen) {
    return;
  }

  if(!level.teambased) {
    return;
  }

  if(!runleanthreadmode()) {
    thread reloadtracking();
    thread sprinttracking();
    thread suppressingfiretracking();
    thread threatcallouttracking();
    return;
  }

  self.bcdisabled = 1;
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

function javelinfired(var_0, var_1) {
  if(!level.teambased) {
    return;
  }

  var_2 = scripts\engine\utility::random(scripts\cp\utility::getotherteam(var_0));
  var_3 = scripts\cp\utility::getplayersinradius(var_1, 360000, var_2);

  if(var_3.size == 0) {
    return;
  }

  var_4 = scripts\engine\utility::random(var_3);
  thread trysaylocalsound(level, var_4, "javelin_target", undefined);
}

function onmunitionboxused(var_0) {
  switch (var_0) {
    case "ammo_crate":
      thread trysaylocalsound(level, self);
      break;
    case "armor":
      thread trysaylocalsound(level, self);
      break;
    case "adrenaline":
      thread trysaylocalsound(level, self);
      break;
    case "grenade_crate":
      thread trysaylocalsound(level, self);
      break;
    case "deployable_vest":
      thread trysaylocalsound(level, self);
      break;
  }
}

function ongrenadeuse(var_0) {
  switch (var_0.weapon_name) {
    case "frag_grenade_mp":
      thread trysaylocalsound(level, self);
      break;
    case "semtex_mp":
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

  var_0 = self.weapon_name;

  if(!isDefined(var_0)) {
    return;
  }

  switch (var_0) {
    case "equip_adrenaline":
    case "deployable_cover_mp":
    case "decoy_grenade_mp":
    case "gas_grenade_mp":
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
      if(!isDefined(var_4) || !isalive(var_4) || isDefined(self.owner) && self.owner scripts\cp\utility::isenemy(var_4) == 0) {
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
      thread trysaylocalsound(level, self);
      break;
    case "at_mine_mp":
      thread trysaylocalsound(level, self);
      break;
    case "claymore_mp":
      thread trysaylocalsound(level, self);
      break;
    case "trophy_mp":
      thread trysaylocalsound(level, self);
      break;
    case "deployable_cover_mp":
      thread trysaylocalsound(level, self);
      break;
    case "decoy_grenade_mp":
      thread trysaylocalsound(level, self);
      break;
    case "gas_grenade_mp":
      thread trysaylocalsound(level, self);
      break;
    case "sensor_grenade_mp":
      thread trysaylocalsound(level, self);
      break;
    case "support_box_mp":
      thread trysaylocalsound(level, self);
      break;
  }
}

function onkillstreakdeploy(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  switch (var_1) {
    case "gunship":
      thread trysaylocalsound(level, var_0);
      break;
    case "chopper_gunner":
      thread trysaylocalsound(level, var_0);
      break;
    case "death_switch":
      thread trysaylocalsound(level, var_0);
      break;
    case "pac_sentry":
      thread trysaylocalsound(level, var_0);
      break;
    case "hover_jet":
      thread trysaylocalsound(level, var_0);
      break;
    case "juggernaut":
      thread trysaylocalsound(level, var_0);
      break;
    case "bradley":
      thread trysaylocalsound(level, var_0);
      break;
    case "manual_turret":
      thread trysaylocalsound(level, var_0);
      break;
    case "sentry_gun":
      thread trysaylocalsound(level, var_0);
      break;
    case "toma_strike":
      thread trysaylocalsound(level, var_0);
      break;
    case "cruise_predator":
      thread trysaylocalsound(level, var_0);
      break;
    case "nuke":
      thread trysaylocalsound(level, var_0);
      break;
    case "nuke_select_location":
      thread trysaylocalsound(level, var_0);
      break;
    case "precision_airstrike":
      thread trysaylocalsound(level, var_0);
      break;
    case "fuel_airstrike":
      thread trysaylocalsound(level, var_0);
      break;
    case "directional_uav":
      thread trysaylocalsound(level, var_0);
      break;
    case "airdrop":
      thread trysaylocalsound(level, var_0);
      break;
    case "emergency_airdrop":
      thread trysaylocalsound(level, var_0);
      break;
    case "radar_drone_overwatch":
      thread trysaylocalsound(level, var_0);
      break;
    case "scrambler_drone_guard":
      thread trysaylocalsound(level, var_0);
      break;
    case "uav":
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
      thread trysaylocalsound(level, self);
      break;
    case "chopper_gunner":
      thread trysaylocalsound(level, self);
      break;
    case "pac_sentry":
      thread trysaylocalsound(level, self);
      break;
    case "hover_jet":
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
  thread trysaylocalsound(level, self);
}

function reloadtracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();
    var_1 = self getweaponammoclip(var_0) + self getweaponammostock(var_0);

    if(var_1 <= weaponclipsize(var_0)) {
      var_2 = scripts\cp\cp_weapon::getweapongroup(var_0);
      var_3 = var_2 == "weapon_shotgun" || var_2 == "weapon_projectile" || scripts\cp\utility::getweaponrootname(var_0) == "iw8_sn_kilo98";

      if(!var_3) {
        if(istrue(trysaylocalsound(level, self, "last_mag"))) {
          switch (var_2) {
            case "weapon_smg":
            case "weapon_pistol":
              thread trysaylocalsound(level, self);
              break;
            case "weapon_assault":
              thread trysaylocalsound(level, self);
              break;
            case "weapon_dmr":
            case "weapon_lmg":
            case "weapon_sniper":
              thread trysaylocalsound(level, self);
              break;
            case "weapon_shotgun":
              thread trysaylocalsound(level, self);
              break;
            case "weapon_projectile":
              thread trysaylocalsound(level, self);
              break;
          }
        }
      }

      continue;
    }

    validaterecentattackers();

    if(self.recentattackers.size > 0) {
      thread trysaylocalsound(level, self);
      continue;
    }

    thread trysaylocalsound(level, self);
  }
}

function sprinttracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("sprint_begin");
    thread trysaylocalsound(level, self);
  }
}

function threatcallouttracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("enemy_sighted");

    if(getomnvar("ui_prematch_period")) {
      level waittill("prematch_over");
      continue;
    }

    if(saidtoorecently("callout_location") && saidtoorecently("callout_generic")) {
      continue;
    }

    var_0 = self getsightedplayers();

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
        var_6 = getvalidlocation(var_5, self);
        var_1 = 1;

        if(isDefined(var_6) && !saidtoorecently("callout_location") && friendly_nearby(4840000)) {
          if(scripts\cp\utility::_hasperk("specialty_quieter") || !friendly_nearby(262144)) {
            thread trysaylocalsound(level, self, "callout_location");
            var_3 = 1;
          } else {
            thread trysaylocalsound(level, self, "callout_location");
            var_3 = 1;
          }

          break;
        }
      }
    }

    var_3 = undefined;
    var_5 = undefined;

    if(!var_2 && var_0) {
      thread trysaylocalsound(level, self);
      thread saytoself(level, self, "plr_target_generic", undefined);
    }
  }
}

function dosound(var_0, var_1) {
  var_2 = level.bcsounds[var_0];

  if(isDefined(var_1)) {
    var_2 = "loc_callout_" + var_1;
  }

  var_3 = getintensitysuffix(self);

  if(!isDefined(self.operatorcustomization)) {
    return;
  }

  if(var_0 == "flavor_execution") {
    if(self.operatorcustomization.oic_rewardammo == "none") {
      return;
    }

    var_2 += self.operatorcustomization.oic_rewardammo;
  }

  var_5 = "dx_mpb_" + self.operatorcustomization.voice + "_" + var_2;

  if(getsubstr(var_2, var_2.size - 2, var_2.size) == "_o") {
    var_2 = getsubstr(var_2, 0, var_2.size - 2);
  }

  var_6 = "dx_mpp_" + self.operatorcustomization.voice + "_" + var_2;
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

  if(self issplitscreenplayer()) {
    ref_12455(var_7, var_8, var_0, var_6, var_5);
  } else {
    ref_12453(var_7, var_8, var_0, var_6, var_5);
  }

  if(isDefined(var_1)) {
    location_add_last_callout_time(var_1, self.team);
  }

  var_11 = level.bcinfo["priority"][var_0];
  var_12 = self.team;
  addspeaker(level, self, var_12, var_5, var_0, var_11);
  updatechatter(var_0);
  var_13 = max(var_9, var_10) / 1000;
  thread timehack(var_5, var_13);
  scripts\engine\utility::ref_143a5(var_5, "death_or_disconnect");
  removespeaker(level, self, var_12);
  return 1;
}

function ref_12453(var_0, var_1, var_2, var_3, var_4) {
  if(var_0) {
    if(level.bcinfo["play_for_all"][var_2]) {
      foreach(var_6 in level.teamnamelist) {
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
    } else if(var_1) {
      self playsoundtoteam(var_4, self.team, self);
    } else {
      self playsoundtoteam(var_4, self.team);
    }
  }

  if(var_1) {
    self playsoundtoplayer(var_3, self);
    return;
  }
}

function ref_12455(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self getothersplitscreenplayer();
  var_6 = [var_5];

  if(var_1) {
    GscBinSkip0(0x2e, var_6.size, self);
  }

  if(var_0) {
    if(level.bcinfo["play_for_all"][var_2]) {
      foreach(var_8 in level.teamnamelist) {
        if(var_8 == self.team) {
          var_9 = level.teamdata[self.team]["players"];

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
      var_9 = level.teamdata[self.team]["players"];

      foreach(var_11 in var_9) {
        if(!scripts\engine\utility::array_contains(var_6, var_11)) {
          self playsoundtoplayer(var_4, var_11);
        }
      }
    }
  }

  if(var_1) {
    self playsoundtoplayer(var_3, self);
    return;
  }
}

function dothreatcalloutresponse(var_0, var_1) {
  var_2 = scripts\engine\utility::ref_143ad(var_0, "death_or_disconnect");

  if(isDefined(var_2) && var_2 == var_0) {
    var_3 = self.team;
    var_4 = self.origin;
    wait 0.5;
    var_5 = getfriendlyplayers(var_3, 1);

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
  var_1 = self.pers["team"];
  var_2 = gettime();
  self.bcinfolastsaytimes[var_0] = var_2;
  level.bcinfo["last_say_time"][var_1][var_0] = var_2;
  level.bcinfo["last_say_pos"][var_1][var_0] = self.origin;
  cleanuplastsaytimes(var_2);
}

function cleanuplastsaytimes(var_0) {
  var_1 = self.pers["team"];
  var_2 = [];

  foreach(var_6, var_4 in self.bcinfolastsaytimes) {
    var_5 = level.bcinfo["timeout_player"][var_6] + var_4;

    if(var_0 < var_5) {
      var_2 = var_4;
    }
  }

  self.bcinfolastsaytimes = var_2;
  var_2 = [];
  var_7 = [];

  foreach(var_6, var_4 in level.bcinfo["last_say_time"][var_1]) {
    if(var_0 < var_4 + level.bcinfo["timeout"][var_6]) {
      var_2 = var_4;
      var_7 = level.bcinfo["last_say_pos"][var_1][var_6];
    }
  }

  level.bcinfo["last_say_time"][var_1] = var_2;
  level.bcinfo["last_say_pos"][var_1] = var_7;
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

function location_add_last_callout_time(var_0) {
  anim.locationlastcallouttimes[var_0] = gettime();
}

function location_get_last_callout_time(var_0) {
  if(isDefined(anim.locationlastcallouttimes[var_0])) {
    return anim.locationlastcallouttimes[var_0];
  }

  return undefined;
}

function cancalloutlocation(var_0) {
  foreach(var_2 in var_0.locationaliases) {
    var_3 = getloccalloutalias("loc_callout_" + var_2);
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
  var_1 = "dx_mpb_" + self.operatorcustomization.voice + "_" + var_0 + "_" + getintensitysuffix(self);
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

  var_1 = getfriendlyplayers(self.team, 1);

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

  for(;;) {
    self.pers["selfVOBonusChance"] = self.pers["selfVOBonusChance"] + 0.1;
    wait 3;
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
  var_2 = gettimepassedpercentage();
  var_3 = getbcintensity(var_0);

  if(var_3 > 5000 || var_2 >= 80 || scripts\cp\utility::inovertime()) {
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
    if(!var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    var_5 = max(scripts\engine\utility::distance_2d_squared(var_0.origin, var_4.origin), 1);

    if(scripts\cp\cp_weapon::iscacprimaryweapon(var_1.basename) || scripts\cp\cp_weapon::iscacsecondaryweapon(var_1.basename)) {
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

function battle_tracks_monitorstandingonvehicles() {
  thread trysaylocalsound(level, self, "flavor_execution", undefined);
}

function adddamagetaken(var_0, var_1, var_2) {
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
    thread trysaylocalsound(level, self, "damage_long", undefined);
    return;
  }

  thread trysaylocalsound(level, self, "damage", undefined);
}

function onsixfriendlytracking() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 25;

  for(;;) {
    if(!saidtoorecently("behind_friendly")) {
      var_0 = getfriendlyplayers(self.team, 1);

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

        if(validatelistener(self, var_2)) {
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

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  checkcasualty();
}

function checkcasualty() {
  var_0 = getfriendlyplayers(self.team, 1);

  foreach(var_2 in var_0) {
    if(var_2 == self) {
      continue;
    }

    if(distancesquared(self.origin, var_2.origin) <= 262144) {
      var_3 = anglesToForward(var_2 getplayerangles());

      if(length(var_2.origin - self.origin) > 0) {
        if(scripts\engine\math::anglebetweenvectors(var_3, var_2.origin - self.origin) < 80) {
          thread trysaylocalsound(level, var_2, "casualty", undefined);
          break;
        }
      }
    }
  }

  var_0 = undefined;
  var_2 = undefined;
}

function ref_13bc8(var_0) {
  level.battlechatterenabled = var_0;
}

function trysaylocalsound(var_0, var_1, var_2, var_3) {
  if(!istrue(level.battlechatterenabled)) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(!isPlayer(var_0)) {
    return;
  }

  if(istrue(var_0.bcdisabled)) {
    return;
  }

  if(var_0.team == "spectator") {
    return;
  }

  if(!isDefined(level.bcsounds[var_1])) {
    return;
  }

  if(istrue(var_0.isspeakingbc)) {
    return;
  }

  if(!isDefined(level.bcfrequency)) {
    level.bcfrequency = [];
  }

  if(!isDefined(level.bcfrequency[var_1])) {
    level.bcfrequency[var_1] = 1;
  } else {
    level.bcfrequency[var_1]++;
  }

  if(getdvarint("scr_play_solo_bc", 0) <= 0 && level.bcinfo["req_friendly"][var_1] && !friendly_nearby(var_0, 4840000)) {
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

  if(comparesoundpriorities(var_1, var_0.bcinfoqueued)) {
    var_0.bcinfoqueued = var_1;
  } else {
    return;
  }

  level notify("kill_queued_bc_sound_" + var_0.name);
  thread saylocalsound(var_0, var_4, var_1, var_2);
  return runheliextraction(var_0, var_1, var_2);
}

function runheliextraction(var_0, var_1, var_2) {
  if(!isDefined(var_0.operatorcustomization)) {
    return 0;
  }

  var_4 = level.bcsounds[var_1];

  if(isDefined(var_2)) {
    var_4 = "loc_callout_" + var_2;
  }

  var_5 = getintensitysuffix(var_0);
  var_6 = "dx_mpb_" + var_0.operatorcustomization.voice + "_" + var_4 + "_" + var_5;
  var_7 = "dx_mpp_" + var_0.operatorcustomization.voice + "_" + var_4;
  var_8 = soundexists(var_6);
  var_9 = soundexists(var_7);
  var_10 = 0.4;

  if(getdvarint("loc_language") != 0 && getdvarint("loc_language") != 1) {
    var_10 = 1.4;
  }

  if(istrue(var_8)) {
    return (lookupsoundlength(var_6) / 1000 + var_10);
  } else if(istrue(var_9)) {
    return (lookupsoundlength(var_7) / 1000 + var_10);
  }

  return 0;
}

function saylocalsound(var_0, var_1, var_2, var_3) {
  level endon("kill_queued_bc_sound_" + self.name);
  self endon("death_or_disconnect");
  wait var_0 / 1000;
  jumpiffalse(saidtoorecently(var_1)) LOC_0000002a;
  return;
}

function getbcwaittime(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = 0;
  var_3 = 0;

  if(isDefined(level.bcinfo["last_say_time"]) && isDefined(level.bcinfo["last_say_time"][self.team]) && isDefined(level.bcinfo["last_say_time"][self.team][var_0])) {
    var_2 = level.bcinfo["last_say_time"][self.team][var_0] + level.bcinfo["timeout"][var_0];
    var_3 = distancesquared(level.bcinfo["last_say_pos"][self.team][var_0], self.origin) < 1048576;
  }

  if(!isDefined(self.bcinfolastsaytimes)) {
    onplayerspawned();
  }

  if(!isDefined(self.bcinfolastsaytimes[var_0])) {
    self.bcinfolastsaytimes[var_0] = 0;
  }

  var_4 = self.bcinfolastsaytimes[var_0] + level.bcinfo["timeout_player"][var_0];
  var_5 = gettime() + var_1 * 1000;

  if(var_3) {
    var_6 = max(var_4, max(var_2, var_5));
  } else {
    var_6 = max(var_5, var_6);
  }

  var_7 = var_6 - gettime();
  return var_7;
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
  if(!isDefined(self) || !scripts\cp\utility::isgameplayteam(self.team)) {
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

function runleanthreadmode() {
  return false;
}

function gettimepassedpercentage() {
  return 50;
}

function getteamvoiceinfix(var_0) {
  if(!isDefined(level.teamdata)) {
    level.teamdata = [];
  }

  if(!isDefined(level.teamdata[var_0])) {
    level.teamdata[var_0] = [];
  }

  if(!isDefined(level.teamdata[var_0]["soundInfix"])) {
    level.teamdata[var_0]["soundInfix"] = tablelookup("mp/factionTable.csv", 0, game[var_0], 8);
  }

  return level.teamdata[var_0]["soundInfix"];
}

function getfriendlyplayers(var_0, var_1) {
  var_2 = [];
  jumpiffalse(istrue(var_1)) LOC_00000057;

  foreach(var_4 in scripts\cp\utility::getplayersinteam(var_0)) {
    if(isDefined(var_4) && isalive(var_4) && !isDefined(var_4.fauxdead)) {
      var_2 = var_4;
    }
  }

  goto LOC_00000085;
}

function ref_1274c(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  switch (var_1) {
    case "gunship":
    case "chopper_support":
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
    case "toma_strike":
    case "precision_airstrike":
    case "hover_jet":
    case "fuel_airstrike":
    case "cruise_predator":
      thread trysaylocalsound(level, var_0);
      break;
    case "directional_uav":
    case "uav":
    case "radar_drone_overwatch":
      thread trysaylocalsound(level, var_0);
      break;
    case "scrambler_drone_guard":
      thread trysaylocalsound(level, var_0);
      break;
  }
}