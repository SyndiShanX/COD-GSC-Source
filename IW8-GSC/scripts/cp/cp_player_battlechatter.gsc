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

  foreach(var1 in level.teamnamelist) {
    level.isteamspeaking[var1] = 0;
    level.speakers[var1] = [];
    level.bcinfo["queued"][var1] = "none";
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
  var3 = getDvar("NKTMKRMSKR");
  level.istactical = 1;

  if(var3 == "war" || var3 == "kc" || var3 == "dom" || var3 == "cmd" || var3 == "arm") {
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

function registerbcsoundtype(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(!isDefined(var6)) {
    var6 = 1;
  }

  if(!isDefined(var7)) {
    var7 = 1;
  }

  if(!isDefined(var8)) {
    var8 = 0;
  }

  level.bcsounds[var0] = var1;
  level.bcinfo["priority"][var0] = var2;
  level.bcinfo["chance"][var0] = var3;
  level.bcinfo["timeout"][var0] = var4 * 1000;
  level.bcinfo["timeout_player"][var0] = var5 * 1000;
  level.bcinfo["req_friendly"][var0] = var6;
  level.bcinfo["play_for_all"][var0] = var7;
  level.bcinfo["play_for_squad_only"][var0] = var8;
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
  var0 = [];
  var1 = gettime();

  foreach(var3 in self.recentattackers) {
    if(var1 < var3.ignoreaftertime) {
      var0 = var3;
    }
  }

  self.recentattackers = var0;
}

function addrecentattacker(var0) {
  if(!isDefined(self.recentattackers)) {
    self.recentattackers = [];
  }

  var1 = 0;

  foreach(var3 in self.recentattackers) {
    if(var3.attacker == var0) {
      var1 = 1;
      var3.time = gettime();
      var3.ignoreaftertime = var3.time + 2000;
      break;
    }
  }

  if(!var1) {
    var3 = spawnStruct();
    var3.time = gettime();
    var3.attacker = var0;
    var3.ignoreaftertime = var3.time + 2000;
    self.recentattackers[self.recentattackers.size] = var3;
  }

  validaterecentattackers();

  if(self.recentattackers.size > 1) {
    thread trysaylocalsound(level, self);
    return;
  }
}

function javelinfired(var0, var1) {
  if(!level.teambased) {
    return;
  }

  var2 = scripts\engine\utility::random(scripts\cp\utility::getotherteam(var0));
  var3 = scripts\cp\utility::getplayersinradius(var1, 360000, var2);

  if(var3.size == 0) {
    return;
  }

  var4 = scripts\engine\utility::random(var3);
  thread trysaylocalsound(level, var4, "javelin_target", undefined);
}

function onmunitionboxused(var0) {
  switch (var0) {
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

function ongrenadeuse(var0) {
  switch (var0.weapon_name) {
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

  var0 = self.weapon_name;

  if(!isDefined(var0)) {
    return;
  }

  switch (var0) {
    case "equip_adrenaline":
    case "deployable_cover_mp":
    case "decoy_grenade_mp":
    case "gas_grenade_mp":
    case "trophy_mp":
    case "thermite_mp":
      return;
  }

  var1 = self.owner;

  if(!isDefined(var1)) {
    var1 = getmissileowner(self);
  }

  if(!isDefined(var1)) {
    return;
  }

  self endon("death");

  for(;;) {
    var2 = scripts\common\utility::playersinsphere(self.origin, 384);

    foreach(var4 in var2) {
      if(!isDefined(var4) || !isalive(var4) || isDefined(self.owner) && self.owner scripts\cp\utility::isenemy(var4) == 0) {
        continue;
      }

      var5 = distancesquared(self.origin, var4.origin);

      if(isDefined(var5) && var5 < 384) {
        if(!sighttracepassed(var4 getEye(), self.origin, 0, var4)) {
          continue;
        }

        switch (var0) {
          case "frag_grenade_mp":
            thread trysaylocalsound(level, var4);
            break;
          case "concussion_grenade_mp":
            thread trysaylocalsound(level, var4);
            break;
          case "flash_grenade_mp":
            thread trysaylocalsound(level, var4);
            break;
          case "smoke_grenade_mp":
            thread trysaylocalsound(level, var4);
            break;
          case "semtex_mp":
            thread trysaylocalsound(level, var4);
            break;
          case "molotov_mp":
            thread trysaylocalsound(level, var4);
            break;
          case "equip_pop_rocket":
            thread trysaylocalsound(level, var4);
            break;
          case "c4_mp_p":
            thread trysaylocalsound(level, var4);
            break;
          case "sensor_grenade_mp":
            thread trysaylocalsound(level, var4);
            break;
          case "thermite_mp":
            thread trysaylocalsound(level, var4);
            break;
          case "gas_grenade_mp":
            thread trysaylocalsound(level, var4);
            break;
          default:
            if(weaponclass(self.weapon_name) == "rocketlauncher") {
              thread trysaylocalsound(level, var4);
            }

            break;
        }
      }

      waitframe();
    }

    waitframe();
  }
}

function equipmentdestroyed(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var0.weapon_name)) {
    return;
  }

  switch (var0.weapon_name) {
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

function onkillstreakdeploy(var0, var1) {
  if(!isDefined(var1)) {
    return;
  }

  switch (var1) {
    case "gunship":
      thread trysaylocalsound(level, var0);
      break;
    case "chopper_gunner":
      thread trysaylocalsound(level, var0);
      break;
    case "death_switch":
      thread trysaylocalsound(level, var0);
      break;
    case "pac_sentry":
      thread trysaylocalsound(level, var0);
      break;
    case "hover_jet":
      thread trysaylocalsound(level, var0);
      break;
    case "juggernaut":
      thread trysaylocalsound(level, var0);
      break;
    case "bradley":
      thread trysaylocalsound(level, var0);
      break;
    case "manual_turret":
      thread trysaylocalsound(level, var0);
      break;
    case "sentry_gun":
      thread trysaylocalsound(level, var0);
      break;
    case "toma_strike":
      thread trysaylocalsound(level, var0);
      break;
    case "cruise_predator":
      thread trysaylocalsound(level, var0);
      break;
    case "nuke":
      thread trysaylocalsound(level, var0);
      break;
    case "nuke_select_location":
      thread trysaylocalsound(level, var0);
      break;
    case "precision_airstrike":
      thread trysaylocalsound(level, var0);
      break;
    case "fuel_airstrike":
      thread trysaylocalsound(level, var0);
      break;
    case "directional_uav":
      thread trysaylocalsound(level, var0);
      break;
    case "airdrop":
      thread trysaylocalsound(level, var0);
      break;
    case "emergency_airdrop":
      thread trysaylocalsound(level, var0);
      break;
    case "radar_drone_overwatch":
      thread trysaylocalsound(level, var0);
      break;
    case "scrambler_drone_guard":
      thread trysaylocalsound(level, var0);
      break;
    case "uav":
      thread trysaylocalsound(level, var0);
      break;
  }
}

function killstreaklockedon(var0) {
  if(!isDefined(var0)) {
    return;
  }

  switch (var0) {
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

function killstreakdestroyed(var0) {
  if(!isDefined(var0)) {
    return;
  }

  switch (var0) {
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
  var0 = undefined;

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
    var0 = self getcurrentweapon();
    var1 = self getweaponammoclip(var0) + self getweaponammostock(var0);

    if(var1 <= weaponclipsize(var0)) {
      var2 = scripts\cp\cp_weapon::getweapongroup(var0);
      var3 = var2 == "weapon_shotgun" || var2 == "weapon_projectile" || scripts\cp\utility::getweaponrootname(var0) == "iw8_sn_kilo98";

      if(!var3) {
        if(istrue(trysaylocalsound(level, self, "last_mag"))) {
          switch (var2) {
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

    var0 = self getsightedplayers();

    if(!isDefined(var0)) {
      continue;
    }

    var1 = 0;
    var2 = 4000000;

    if(self playerads() > 0.7) {
      var2 = 6250000;
    }

    var3 = 0;

    foreach(var5 in var0) {
      if(isDefined(var5) && var5 scripts\cp_mp\utility\player_utility::_isalive() && !var5 scripts\cp\utility::_hasperk("specialty_coldblooded") && distancesquared(self.origin, var5.origin) < var2) {
        var6 = getvalidlocation(var5, self);
        var1 = 1;

        if(isDefined(var6) && !saidtoorecently("callout_location") && friendly_nearby(4840000)) {
          if(scripts\cp\utility::_hasperk("specialty_quieter") || !friendly_nearby(262144)) {
            thread trysaylocalsound(level, self, "callout_location");
            var3 = 1;
          } else {
            thread trysaylocalsound(level, self, "callout_location");
            var3 = 1;
          }

          break;
        }
      }
    }

    var3 = undefined;
    var5 = undefined;

    if(!var2 && var0) {
      thread trysaylocalsound(level, self);
      thread saytoself(level, self, "plr_target_generic", undefined);
    }
  }
}

function dosound(var0, var1) {
  var2 = level.bcsounds[var0];

  if(isDefined(var1)) {
    var2 = "loc_callout_" + var1;
  }

  var3 = getintensitysuffix(self);

  if(!isDefined(self.operatorcustomization)) {
    return;
  }

  if(var0 == "flavor_execution") {
    if(self.operatorcustomization.oic_rewardammo == "none") {
      return;
    }

    var2 += self.operatorcustomization.oic_rewardammo;
  }

  var5 = "dx_mpb_" + self.operatorcustomization.voice + "_" + var2;

  if(getsubstr(var2, var2.size - 2, var2.size) == "_o") {
    var2 = getsubstr(var2, 0, var2.size - 2);
  }

  var6 = "dx_mpp_" + self.operatorcustomization.voice + "_" + var2;
  var7 = soundexists(var5);
  var8 = soundexists(var6);
  var9 = 0;
  var10 = 0;

  if(!var7) {} else {
    var9 = lookupsoundlength(var5);
  }

  if(!var8) {} else {
    var10 = lookupsoundlength(var6);
  }

  if(self issplitscreenplayer()) {
    ref_12455(var7, var8, var0, var6, var5);
  } else {
    ref_12453(var7, var8, var0, var6, var5);
  }

  if(isDefined(var1)) {
    location_add_last_callout_time(var1, self.team);
  }

  var11 = level.bcinfo["priority"][var0];
  var12 = self.team;
  addspeaker(level, self, var12, var5, var0, var11);
  updatechatter(var0);
  var13 = max(var9, var10) / 1000;
  thread timehack(var5, var13);
  scripts\engine\utility::ref_143a5(var5, "death_or_disconnect");
  removespeaker(level, self, var12);
  return 1;
}

function ref_12453(var0, var1, var2, var3, var4) {
  if(var0) {
    if(level.bcinfo["play_for_all"][var2]) {
      foreach(var6 in level.teamnamelist) {
        if(var6 == self.team) {
          if(var1) {
            self playsoundtoteam(var4, var6, self);
          } else {
            self playsoundtoteam(var4, var6);
          }

          continue;
        }

        self playsoundtoteam(var4, var6);
      }
    } else if(var1) {
      self playsoundtoteam(var4, self.team, self);
    } else {
      self playsoundtoteam(var4, self.team);
    }
  }

  if(var1) {
    self playsoundtoplayer(var3, self);
    return;
  }
}

function ref_12455(var0, var1, var2, var3, var4) {
  var5 = self getothersplitscreenplayer();
  var6 = [var5];

  if(var1) {
    GscBinSkip0(0x2e, var6.size, self);
  }

  if(var0) {
    if(level.bcinfo["play_for_all"][var2]) {
      foreach(var8 in level.teamnamelist) {
        if(var8 == self.team) {
          var9 = level.teamdata[self.team]["players"];

          foreach(var11 in var9) {
            if(!scripts\engine\utility::array_contains(var6, var11)) {
              self playsoundtoplayer(var4, var11);
            }
          }

          continue;
        }

        self playsoundtoteam(var4, var8);
      }
    } else {
      var9 = level.teamdata[self.team]["players"];

      foreach(var11 in var9) {
        if(!scripts\engine\utility::array_contains(var6, var11)) {
          self playsoundtoplayer(var4, var11);
        }
      }
    }
  }

  if(var1) {
    self playsoundtoplayer(var3, self);
    return;
  }
}

function dothreatcalloutresponse(var0, var1) {
  var2 = scripts\engine\utility::ref_143ad(var0, "death_or_disconnect");

  if(isDefined(var2) && var2 == var0) {
    var3 = self.team;
    var4 = self.origin;
    wait 0.5;
    var5 = getfriendlyplayers(var3, 1);

    foreach(var7 in var5) {
      if(!isDefined(var7)) {
        continue;
      }

      if(var7 == self) {
        continue;
      }

      if(!var7 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(var7.team != var3) {
        continue;
      }

      if(isagent(var7)) {
        continue;
      }

      if(self.operatorcustomization.voice != var7.operatorcustomization.voice && distancesquared(var4, var7.origin) <= 262144 && !isspeakerinrange(var7)) {
        var8 = getintensitysuffix(var7);
        var9 = "dx_mpb_" + var7.operatorcustomization.voice + "_loc_" + var1 + "_echo";

        if(soundexists(var9) && scripts\engine\utility::cointoss()) {
          var10 = var9;
        } else {
          var10 = undefined;
        }

        if(isDefined(var10)) {
          thread dosound(var11, var10, 0);
        }

        break;
      }
    }

    var7 = undefined;
    var8 = undefined;
    return;
  }
}

function timehack(var0, var1) {
  self endon("death_or_disconnect");
  wait var1;
  self notify(var0);
}

function isspeakerinrange(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1000;
  }

  var2 = var1 * var1;

  if(isDefined(var0) && isDefined(var0.team) && var0.team != "spectator") {
    for(var3 = 0; var3 < level.speakers[var0.team].size; var3++) {
      var4 = level.speakers[var0.team][var3]["player"];

      if(var4 == var0) {
        return true;
      }

      if(!isDefined(var4)) {
        continue;
      }

      if(distancesquared(var4.origin, var0.origin) < var2) {
        return true;
      }
    }
  }

  return false;
}

function addspeaker(var0, var1, var2, var3, var4) {
  var5 = level.speakers[var1].size;
  level.speakers[var1][var5] = [];
  level.speakers[var1][var5]["player"] = var0;
  level.speakers[var1][var5]["sound_alias"] = var2;
  level.speakers[var1][var5]["sound_type"] = var3;
  level.speakers[var1][var5]["priority"] = var4;
}

function removespeaker(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < level.speakers[var1].size; var3++) {
    if(isDefined(var0) && isDefined(level.speakers[var1][var3]["player"]) && level.speakers[var1][var3]["player"] == var0) {
      continue;
    }

    var2 = level.speakers[var1][var3];
  }

  level.speakers[var1] = var2;
}

function disablebattlechatter(var0) {
  var0.bcdisabled = 1;
}

function enablebattlechatter(var0) {
  var0.bcdisabled = undefined;
}

function updatechatter(var0) {
  var1 = self.pers["team"];
  var2 = gettime();
  self.bcinfolastsaytimes[var0] = var2;
  level.bcinfo["last_say_time"][var1][var0] = var2;
  level.bcinfo["last_say_pos"][var1][var0] = self.origin;
  cleanuplastsaytimes(var2);
}

function cleanuplastsaytimes(var0) {
  var1 = self.pers["team"];
  var2 = [];

  foreach(var6, var4 in self.bcinfolastsaytimes) {
    var5 = level.bcinfo["timeout_player"][var6] + var4;

    if(var0 < var5) {
      var2 = var4;
    }
  }

  self.bcinfolastsaytimes = var2;
  var2 = [];
  var7 = [];

  foreach(var6, var4 in level.bcinfo["last_say_time"][var1]) {
    if(var0 < var4 + level.bcinfo["timeout"][var6]) {
      var2 = var4;
      var7 = level.bcinfo["last_say_pos"][var1][var6];
    }
  }

  level.bcinfo["last_say_time"][var1] = var2;
  level.bcinfo["last_say_pos"][var1] = var7;
}

function getvalidlocation(var0) {
  var1 = get_all_my_locations();
  var1 = scripts\engine\utility::array_randomize(var1);

  if(var1.size) {
    foreach(var3 in var1) {
      if(!location_called_out_ever(var3) && cancalloutlocation(var0, var3)) {
        return var3;
      }
    }

    foreach(var3 in var1) {
      if(!location_called_out_recently(var3) && cancalloutlocation(var0, var3)) {
        return var3;
      }
    }
  }

  return undefined;
}

function get_all_my_locations() {
  var0 = anim.bcs_locations;
  var1 = self getistouchingentities(var0);
  var2 = [];

  foreach(var4 in var1) {
    if(isDefined(var4.locationaliases)) {
      var2 = var4;
    }
  }

  return var2;
}

function location_called_out_ever(var0) {
  var1 = location_get_last_callout_time(var0.locationaliases[0]);

  if(!isDefined(var1)) {
    return false;
  }

  return true;
}

function location_called_out_recently(var0) {
  var1 = location_get_last_callout_time(var0.locationaliases[0]);

  if(!isDefined(var1)) {
    return false;
  }

  var2 = var1 + 25000;

  if(gettime() < var2) {
    return true;
  }

  return false;
}

function location_add_last_callout_time(var0) {
  anim.locationlastcallouttimes[var0] = gettime();
}

function location_get_last_callout_time(var0) {
  if(isDefined(anim.locationlastcallouttimes[var0])) {
    return anim.locationlastcallouttimes[var0];
  }

  return undefined;
}

function cancalloutlocation(var0) {
  foreach(var2 in var0.locationaliases) {
    var3 = getloccalloutalias("loc_callout_" + var2);
    var4 = soundexists(var3);

    if(var4) {
      return var4;
    }
  }

  return 0;
}

function canconcat(var0) {
  var1 = var0.locationaliases;

  foreach(var3 in var1) {
    if(iscallouttypeconcat(var3, self)) {
      return true;
    }
  }

  return false;
}

function getcannedresponse(var0) {
  var1 = undefined;
  var2 = self.locationaliases;

  foreach(var4 in var2) {
    if(iscallouttypeqa(var4, var0) && !isDefined(self.qafinished)) {
      var1 = var4;
      break;
    }

    if(iscallouttypereport(var4)) {
      var1 = var4;
    }
  }

  return var1;
}

function iscallouttypereport(var0) {
  return issubstr(var0, "_report");
}

function iscallouttypeconcat(var0, var1) {
  var2 = getloccalloutalias(var1, "concat_loc_" + var0);

  if(soundexists(var2)) {
    return true;
  }

  return false;
}

function iscallouttypeqa(var0, var1) {
  if(issubstr(var0, "_qa") && soundexists(var0)) {
    return true;
  }

  var2 = getqacalloutalias(var1, var0, 0);

  if(soundexists(var2)) {
    return true;
  }

  return false;
}

function getloccalloutalias(var0) {
  var1 = "dx_mpb_" + self.operatorcustomization.voice + "_" + var0 + "_" + getintensitysuffix(self);
  return var1;
}

function getqacalloutalias(var0, var1) {
  var2 = getloccalloutalias(var0);
  var2 += "_qa" + var1;
  return var2;
}

function battlechatter_canprint() {
  return false;
}

function battlechatter_canprintdump() {
  return false;
}

function battlechatter_print(var0, var1) {}

function battlechatter_printdump(var0) {}

function battlechatter_debugprint(var0, var1) {}

function getaliastypefromsoundalias(var0) {}

function battlechatter_printdumpline(var0, var1, var2) {}

function friendly_nearby(var0) {
  if(!isDefined(var0)) {
    var0 = 262144;
  }

  var1 = getfriendlyplayers(self.team, 1);

  foreach(var3 in var1) {
    if(var3 != self && distancesquared(var3.origin, self.origin) <= var0) {
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

function setselfvoinfo(var0, var1, var2, var3) {
  level.selfvoinfo[var0]["timeout"] = var1;
  level.selfvoinfo[var0]["priority"] = var2;
  level.selfvoinfo[var0]["chance"] = var3;
}

function saytoself(var0, var1, var2, var3) {
  if(isagent(var0) || !isPlayer(var0)) {
    return;
  }

  if(istrue(var0.bcdisabled)) {
    return;
  }

  var4 = getintensitysuffix(var0);
  var5 = "";

  if(isDefined(var0.operatorcustomization) && isDefined(var0.operatorcustomization.voice) && isDefined(var1)) {
    var5 = "dx_mpb_" + var0.operatorcustomization.voice + "_" + var1;
  }

  if(!isDefined(var1) || !soundexists(var5)) {
    if(!isDefined(var2)) {
      return;
    }

    var1 = var2;
    var5 = "dx_mpb_" + var0.operatorcustomization.voice + "_" + var1;

    if(!soundexists(var5)) {
      return;
    }
  }

  if(!isDefined(var0.selfvohistory)) {
    var0.selfvohistory = [];
    var0.playingselfvo = 0;
    var0.queuedvo = "none";
  }

  if(isDefined(var0.selfvohistory[level.selfvomap[var1]]) && var0.selfvohistory[level.selfvomap[var1]] > 0) {
    return;
  }

  if(!isDefined(var0.pers["selfVOBonusChance"])) {
    thread updateselfvobonuschance();
  }

  if(randomfloat(1) > level.selfvoinfo[level.selfvomap[var1]]["chance"] + var0.pers["selfVOBonusChance"]) {
    return;
  }

  thread trysetqueuedselfvo(var0, var1);
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

function trysetqueuedselfvo(var0, var1) {
  self endon("death_or_disconnect");

  if(self.queuedvo == var0) {
    return;
  }

  if(self.queuedvo == "none" || level.selfvoinfo[level.selfvomap[self.queuedvo]]["priority"] < level.selfvoinfo[level.selfvomap[var0]]["priority"] || level.selfvoinfo[level.selfvomap[self.queuedvo]]["priority"] == level.selfvoinfo[level.selfvomap[var0]]["priority"] && scripts\engine\utility::cointoss()) {
    self.queuedvo = var0;
  } else {
    return;
  }

  self notify("addToSelfVOQueue");
  self endon("addToSelfVOQueue");
  self.selfvodelaycomplete = 1;

  if(isDefined(var1)) {
    thread selfvodelay(var1);
  }

  var2 = getprioritywaittime(var0);
  var3 = gettime();

  while(self.playingselfvo || !self.selfvodelaycomplete || var2 > gettime()) {
    if(gettime() > var3 + 2000) {
      self.queuedvo = "none";
      return;
    }

    wait 0.05;
  }

  waitframe();
  thread playselfvo(var0);
}

function getprioritywaittime(var0) {
  if(!isDefined(self.lastselfvotime)) {
    self.lastselfvotime = 0;
  }

  return self.lastselfvotime + 2000 + 10000 * (1 - level.selfvoinfo[level.selfvomap[var0]]["priority"]);
}

function selfvodelay(var0) {
  self endon("death_or_disconnect");
  self endon("addToSelfVOQueue");
  self.selfvodelaycomplete = 0;
  wait var0;
  self.selfvodelaycomplete = 1;
}

function playselfvo(var0) {
  self endon("death_or_disconnect");
  var1 = getintensitysuffix(self);
  var2 = "dx_mpb_" + self.operatorcustomization.voice + "_" + var0;
  self.pers["selfVOBonusChance"] = 0;
  self.queuedvo = "none";
  var3 = lookupsoundlength(var2) / 1000;
  self.lastselfvotime = gettime();
  thread playingselfvotracking(var3);
  thread updateselfvohistory(var0);
  self playsoundtoplayer(var2, self);
}

function playingselfvotracking(var0) {
  self endon("disconnect");
  self.playingselfvo = 1;
  wait var0;
  self.playingselfvo = 0;
}

function updateselfvohistory(var0) {
  self endon("disconnect");
  self.selfvohistory[level.selfvomap[var0]] = gettime();
  wait level.selfvoinfo[level.selfvomap[var0]]["timeout"];
  self.selfvohistory[level.selfvomap[var0]] = 0;
}

function getintensitysuffix(var0) {
  var2 = gettimepassedpercentage();
  var3 = getbcintensity(var0);

  if(var3 > 5000 || var2 >= 80 || scripts\cp\utility::inovertime()) {
    return "high";
  }

  return "mid";
}

function addtointensitybuffer(var0, var1, var2) {
  if(!isDefined(self.battlechatterintensitybuffer)) {
    self.battlechatterintensitybuffer = [];
  }

  var3 = spawnStruct();
  var3.time = gettime();
  var3.value = var1;
  var3.ignoreaftertime = var3.time + var2 * 1000;
  self.battlechatterintensitybuffer[self.battlechatterintensitybuffer.size] = var3;
}

function getbcintensity() {
  if(!isDefined(self.battlechatterintensitybuffer)) {
    return 0;
  }

  var0 = [];
  var1 = 0;
  var2 = gettime();

  foreach(var4 in self.battlechatterintensitybuffer) {
    if(var2 < var4.ignoreaftertime) {
      var1 += var4.value;
      var0 = var4;
    }
  }

  self.battlechatterintensitybuffer = var0;
  self.intensity = var1;
  return var1;
}

function testweaponfiredtolisteners(var0, var1) {
  var2 = scripts\common\utility::playersnear(var0.origin, 4000);

  foreach(var4 in var2) {
    if(!var4 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    var5 = max(scripts\engine\utility::distance_2d_squared(var0.origin, var4.origin), 1);

    if(scripts\cp\cp_weapon::iscacprimaryweapon(var1.basename) || scripts\cp\cp_weapon::iscacsecondaryweapon(var1.basename)) {
      var6 = 0;
      var7 = scripts\cp\cp_weapon::getweapongroup(var1.basename);

      switch (var7) {
        case "weapon_smg":
          var6 = 50;
          break;
        case "weapon_assault":
          var6 = 60;
          break;
        case "weapon_sniper":
          var6 = 90;
          break;
        case "weapon_dmr":
          var6 = 70;
          break;
        case "weapon_lmg":
          var6 = 80;
          break;
        case "weapon_shotgun":
          var6 = 80;
          break;
        case "weapon_projectile":
          var6 = 70;
          break;
        case "weapon_pistol":
          var6 = 40;
          break;
        case "weapon_machine_pistol":
          var6 = 50;
          break;
        default:
          break;
      }

      if(var6 == 0) {
        continue;
      }

      if(scripts\cp\utility::weaponhasattachment(var1, "silencer")) {
        var6 *= 0.25;
      }

      if(var5 < 10000) {
        var8 = 5;
      } else if(var6 < 250000) {
        var8 = 3;
      } else if(var7 < 1000000) {
        var8 = 2;
      } else if(var10 < 4000000) {
        var8 = 0.5;
      } else if(var8 < 9000000) {
        var8 = 0.25;
      } else {
        var8 = 0.1;
      }

      var9 = 1 - var8 / 16000000;
      var8 *= var9;
      var8 *= var8;
      addtointensitybuffer(var8, "weaponFired", int(var8), 3);
    }
  }

  var8 = undefined;
}

function battle_tracks_monitorstandingonvehicles() {
  thread trysaylocalsound(level, self, "flavor_execution", undefined);
}

function adddamagetaken(var0, var1, var2) {
  var3 = 0;

  if(isDefined(var1) && isDefined(var0)) {
    var4 = scripts\cp\cp_weapon::getweapongroup(var1);

    if(var4 == "weapon_sniper" || var4 == "weapon_dmr") {
      if(distance2d(self.origin, var0.origin) > 2250000) {
        var3 = 1;
      }
    }
  }

  if(var3) {
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
      var0 = getfriendlyplayers(self.team, 1);

      foreach(var2 in var0) {
        if(var2 == self) {
          continue;
        }

        if(!var2 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }

        if(!scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }

        if(validatelistener(self, var2)) {
          break;
        }
      }
    }

    wait 0.15;
  }
}

function validatelistener(var0, var1) {
  var2 = 0.05;
  var3 = getlistenerorigin(var1);
  var4 = getspeakerorigin(var0);
  var5 = distancesquared(var4, var3);

  if(var5 > 90000) {
    return false;
  }

  var6 = getlistenerdirection(var1);
  var7 = vectorNormalize(var4 - var3);
  var8 = vectordot(var6, var7);

  if(var8 < var2) {
    var9 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
    var10 = physics_createcontents(var9);
    var11 = scripts\engine\trace::ray_trace(var4, var3, var0, var10);

    if(isDefined(var11["entity"]) && isPlayer(var11["entity"]) || var11["fraction"] > 0.8) {
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

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  checkcasualty();
}

function checkcasualty() {
  var0 = getfriendlyplayers(self.team, 1);

  foreach(var2 in var0) {
    if(var2 == self) {
      continue;
    }

    if(distancesquared(self.origin, var2.origin) <= 262144) {
      var3 = anglesToForward(var2 getplayerangles());

      if(length(var2.origin - self.origin) > 0) {
        if(scripts\engine\math::anglebetweenvectors(var3, var2.origin - self.origin) < 80) {
          thread trysaylocalsound(level, var2, "casualty", undefined);
          break;
        }
      }
    }
  }

  var0 = undefined;
  var2 = undefined;
}

function ref_13bc8(var0) {
  level.battlechatterenabled = var0;
}

function trysaylocalsound(var0, var1, var2, var3) {
  if(!istrue(level.battlechatterenabled)) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(!isPlayer(var0)) {
    return;
  }

  if(istrue(var0.bcdisabled)) {
    return;
  }

  if(var0.team == "spectator") {
    return;
  }

  if(!isDefined(level.bcsounds[var1])) {
    return;
  }

  if(istrue(var0.isspeakingbc)) {
    return;
  }

  if(!isDefined(level.bcfrequency)) {
    level.bcfrequency = [];
  }

  if(!isDefined(level.bcfrequency[var1])) {
    level.bcfrequency[var1] = 1;
  } else {
    level.bcfrequency[var1]++;
  }

  if(getdvarint("scr_play_solo_bc", 0) <= 0 && level.bcinfo["req_friendly"][var1] && !friendly_nearby(var0, 4840000)) {
    return;
  }

  if(randomfloat(1) > level.bcinfo["chance"][var1]) {
    return;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var4 = getbcwaittime(var0, var1, var3);

  if(var4 > level.bcinfo["max_wait_time"] + var3 * 1000) {
    return;
  }

  if(comparesoundpriorities(var1, var0.bcinfoqueued)) {
    var0.bcinfoqueued = var1;
  } else {
    return;
  }

  level notify("kill_queued_bc_sound_" + var0.name);
  thread saylocalsound(var0, var4, var1, var2);
  return runheliextraction(var0, var1, var2);
}

function runheliextraction(var0, var1, var2) {
  if(!isDefined(var0.operatorcustomization)) {
    return 0;
  }

  var4 = level.bcsounds[var1];

  if(isDefined(var2)) {
    var4 = "loc_callout_" + var2;
  }

  var5 = getintensitysuffix(var0);
  var6 = "dx_mpb_" + var0.operatorcustomization.voice + "_" + var4 + "_" + var5;
  var7 = "dx_mpp_" + var0.operatorcustomization.voice + "_" + var4;
  var8 = soundexists(var6);
  var9 = soundexists(var7);
  var10 = 0.4;

  if(getdvarint("PMKLQQKSO") != 0 && getdvarint("PMKLQQKSO") != 1) {
    var10 = 1.4;
  }

  if(istrue(var8)) {
    return (lookupsoundlength(var6) / 1000 + var10);
  } else if(istrue(var9)) {
    return (lookupsoundlength(var7) / 1000 + var10);
  }

  return 0;
}

function saylocalsound(var0, var1, var2, var3) {
  level endon("kill_queued_bc_sound_" + self.name);
  self endon("death_or_disconnect");
  wait var0 / 1000;
  jumpiffalse(saidtoorecently(var1)) LOC_0000002a;
  return;
}

function getbcwaittime(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = 0;
  var3 = 0;

  if(isDefined(level.bcinfo["last_say_time"]) && isDefined(level.bcinfo["last_say_time"][self.team]) && isDefined(level.bcinfo["last_say_time"][self.team][var0])) {
    var2 = level.bcinfo["last_say_time"][self.team][var0] + level.bcinfo["timeout"][var0];
    var3 = distancesquared(level.bcinfo["last_say_pos"][self.team][var0], self.origin) < 1048576;
  }

  if(!isDefined(self.bcinfolastsaytimes)) {
    onplayerspawned();
  }

  if(!isDefined(self.bcinfolastsaytimes[var0])) {
    self.bcinfolastsaytimes[var0] = 0;
  }

  var4 = self.bcinfolastsaytimes[var0] + level.bcinfo["timeout_player"][var0];
  var5 = gettime() + var1 * 1000;

  if(var3) {
    var6 = max(var4, max(var2, var5));
  } else {
    var6 = max(var5, var6);
  }

  var7 = var6 - gettime();
  return var7;
}

function getspeakerinfo(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1000;
  }

  var3 = var2 * var2;
  var4 = [];
  GscBinSkip0(0x2e, "lower", []);
}

function comparesoundpriorities(var0, var1) {
  var2 = var1 == "none";

  if(var2) {
    return var2;
  }

  var3 = level.bcinfo["priority"][var1] < level.bcinfo["priority"][var0];
  var4 = level.bcinfo["priority"][var1] == level.bcinfo["priority"][var0] && scripts\engine\utility::cointoss();
  return var3 || var4;
}

function saidtoorecently(var0, var1) {
  if(!isDefined(self) || !scripts\cp\utility::isgameplayteam(self.team)) {
    return 1;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = getbcwaittime(var0, var1);

  if(var2 > level.bcinfo["max_wait_time"] + var1 * 1000) {
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

function getteamvoiceinfix(var0) {
  if(!isDefined(level.teamdata)) {
    level.teamdata = [];
  }

  if(!isDefined(level.teamdata[var0])) {
    level.teamdata[var0] = [];
  }

  if(!isDefined(level.teamdata[var0]["soundInfix"])) {
    level.teamdata[var0]["soundInfix"] = tablelookup("mp/factionTable.csv", 0, game[var0], 8);
  }

  return level.teamdata[var0]["soundInfix"];
}

function getfriendlyplayers(var0, var1) {
  var2 = [];
  jumpiffalse(istrue(var1)) LOC_00000057;

  foreach(var4 in scripts\cp\utility::getplayersinteam(var0)) {
    if(isDefined(var4) && isalive(var4) && !isDefined(var4.fauxdead)) {
      var2 = var4;
    }
  }

  goto LOC_00000085;
}

function ref_1274c(var0, var1) {
  if(!isDefined(var1)) {
    return;
  }

  switch (var1) {
    case "gunship":
    case "chopper_support":
    case "chopper_gunner":
      thread trysaylocalsound(level, var0);
      break;
    case "death_switch":
      thread trysaylocalsound(level, var0);
      break;
    case "pac_sentry":
      thread trysaylocalsound(level, var0);
      break;
    case "airdrop_multiple":
    case "airdrop":
    case "bradley":
    case "juggernaut":
      thread trysaylocalsound(level, var0);
      break;
    case "manual_turret":
      thread trysaylocalsound(level, var0);
      break;
    case "sentry_gun":
      thread trysaylocalsound(level, var0);
      break;
    case "nuke_select_location":
    case "nuke":
      thread trysaylocalsound(level, var0);
      break;
    case "white_phosphorus":
    case "toma_strike":
    case "precision_airstrike":
    case "hover_jet":
    case "fuel_airstrike":
    case "cruise_predator":
      thread trysaylocalsound(level, var0);
      break;
    case "directional_uav":
    case "uav":
    case "radar_drone_overwatch":
      thread trysaylocalsound(level, var0);
      break;
    case "scrambler_drone_guard":
      thread trysaylocalsound(level, var0);
      break;
  }
}