/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_so_rts_precache.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  precacheshader("compassping_enemydirectional");
  precacheshader("waypoint_defend");
  precacheshader("waypoint_defend_a");
  precacheshader("waypoint_defend_b");
  precacheshader("waypoint_defend_c");
  precacheshader("waypoint_defend_d");
  precacheshader("waypoint_capture_a");
  precacheshader("waypoint_capture_b");
  precacheshader("waypoint_capture_c");
  precacheshader("waypoint_capture_d");
  precacheshader("waypoint_destroy_a");
  precacheshader("waypoint_destroy_b");
  precacheshader("waypoint_destroy_c");
  precacheshader("waypoint_destroy_d");
  precacheshader("waypoint_secure");
  precacheshader("waypoint_extract");
  precachestring(&"rts_add_friendly_ai");
  precachestring(&"rts_add_friendly_human");
  precachestring(&"rts_add_poi");
  precachestring(&"rts_del_poi");
  precachestring(&"rts_add_squad");
  precachestring(&"rts_remove_squad");
  precachestring(&"rts_captured_poi");
  precachestring(&"rts_deselect");
  precachestring(&"rts_deselect_enemy");
  precachestring(&"rts_deselect_poi");
  precachestring(&"rts_deselect_squad");
  precachestring(&"rts_highlight");
  precachestring(&"rts_hud_visibility");
  precachestring(&"rts_move_squad_marker");
  precachestring(&"rts_protect_poi");
  precachestring(&"rts_defend_poi");
  precachestring(&"rts_guard_poi");
  precachestring(&"rts_update_pos_poi");
  precachestring(&"rts_remove_ai");
  precachestring(&"rts_secure_poi");
  precachestring(&"rts_search_poi");
  precachestring(&"rts_rescue_poi");
  precachestring(&"rts_destroy_poi");
  precachestring(&"rts_hide_poi");
  precachestring(&"rts_unhide_poi");
  precachestring(&"rts_pulse_poi");
  precachestring(&"rts_toggle_minimap");
  precachestring(&"rts_update_hint_text");
  precachestring(&"rts_toggle_button_prompts");
  precachestring(&"rts_update_remaining_count");
  precachestring(&"rts_select_squad");
  precachestring(&"rts_squad_start_attack");
  precachestring(&"rts_squad_start_attack_poi");
  precachestring(&"rts_squad_stop_attack");
  precachestring(&"rts_target");
  precachestring(&"rts_target_enemy");
  precachestring(&"rts_target_poi");
  precachestring(&"rts_time_left");
  precachestring(&"rts_update_health");
  precachestring(&"rts_poi_prog");
  precachestring(&"rts_airstrike_avail_in");
  precachestring(&"rts_predator_hud");
  precachestring(&"rts_highlight_squad");
  precachestring(&"hud_hide_shadesHud");
  precachestring(&"hud_show_shadesHud");
  precachestring(&"rts_menu_mission_failed");
  precachestring(&"rts_restart_mission");
  precachestring(&"rts_update_hint_text");
  precachestring(&"rts_tutorial_complete");
  precachestring(&"rts_success");
  precachestring(&"rts_failed");
  precachestring(&"rts_hide_result");
  precachestring(&"SO_RTS_MISSION_TIME_REMAINING_CAPS");
  precachestring(&"SO_RTS_OBJ3D_DESTROY");
  precachestring(&"SO_RTS_OBJ3D_PROTECT");
  precachemenu("rts_action");
  level._effect["claymore_laser"] = loadfx("weapon/claymore/fx_claymore_laser");
  level._effect["claymore_explode"] = loadfx("explosions/fx_grenadeexp_dirt");
  level._effect["claymore_gib"] = loadfx("explosions/fx_exp_death_gib");

  if(!isDefined(level.skip_weapon_precache))
    precache_weapons();
}

precache_weapons() {
  precacheitem("metalstorm_mms_rts");
  precacheitem("frag_grenade_future_sp");
  precacheitem("sticky_grenade_future_sp");
  precachemodel("weapon_claymore");
  precacheitem("frag_grenade_sp");
  precacheitem("willy_pete_sp");
  precacheitem("flash_grenade_sp");
  precacheitem("emp_grenade_sp");
  precacheitem("sticky_grenade_future_ai_sp");
  precacheitem("tazer_knuckles_sp");
}