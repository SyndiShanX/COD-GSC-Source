/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\ambush_lighting.gsc
********************************/

main() {
  precacheshellshock("ambush_stunned");
  init_level_lighting_flags();
  thread setup_dof_presets();
  thread set_level_lighting_values();
  thread handle_aarea_takeover_lighting_init();
  thread handle_takeover_fade();
  thread handle_ambush_lighting_setup();
  thread handle_ambush_briefing_done_lighting();
  thread handle_ambush_tower_blackout_lighting();
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  var_0 = getent("day_skydome", "targetname");
  var_0 hide();
}

handle_aarea_takeover_lighting_init() {
  common_scripts\utility::flag_wait("aa_takeover");
  maps\_utility::set_vision_set("ambush_start", 0);
  maps\_utility::vision_set_fog_changes("ambush_start", 0);
  level.player setclutforplayer("clut_ambush_start", 1.0);
  level.player maps\_utility::set_light_set_player("ambush_start");
}

handle_takeover_fade() {
  common_scripts\utility::flag_wait("takeover_fade");
  var_0 = create_overlay_element("black", 0);
  var_0 fadeovertime(2);
  var_0.alpha = 1;
  common_scripts\utility::flag_wait("takeover_fade_begin_fade_in");
  var_0 fadeovertime(4);
  var_0.alpha = 0;
  common_scripts\utility::flag_wait("takeover_fade_done");
  var_0 destroy();
}

handle_ambush_lighting_setup() {
  common_scripts\utility::flag_wait("ambush_init");
}

handle_ambush_briefing_done_lighting() {
  common_scripts\utility::flag_wait("takeover_finalized_done");
  setup_daytime_lights();
}

handle_ambush_tower_blackout_lighting() {
  common_scripts\utility::flag_wait("player_tower_hits_ground");
  var_0 = create_overlay_element("black", 1);

  if(getdvarint("use_old_tower_fall_cinematic_fx") == 1)
    thread handle_tower_fall_cinematic_fx_preh1();
  else
    thread handle_tower_fall_cinematic_fx();

  common_scripts\utility::flag_wait("ambush_tower_blackout_come_to");
  var_0 fadeovertime(3);
  var_0.alpha = 0;
  common_scripts\utility::flag_wait("ambush_recovered");
  var_0 destroy();
}

handle_tower_fall_cinematic_fx_preh1() {
  level.player shellshock("ambush_stunned", 20);
}

handle_tower_fall_cinematic_fx() {
  maps\_cinematography::dyndof("main") maps\_cinematography::dyndof_values(1.8, 8, 5, 1);
  thread maps\_cinematography::dyndof_system_start(1);
  var_0 = maps\_cinematography::cinematic_sequence("tower_fall_recovery");
  var_0 maps\_cinematography::cinseq_key("blur_in") maps\_cinematography::cinseq_key_time(3) maps\_cinematography::cinseq_key_dyndof_values("main", 4, 60, 4, 2);
  var_0 maps\_cinematography::cinseq_key("focus_zak_son") maps\_cinematography::cinseq_key_time(4) maps\_cinematography::cinseq_key_dyndof_ref_ent("main", level.badguy) maps\_cinematography::cinseq_key_dyndof_values("main", 1.6, -1, 3, 2);
  var_0 maps\_cinematography::cinseq_key("slight_blur_out_1") maps\_cinematography::cinseq_key_time(7.5) maps\_cinematography::cinseq_key_dyndof_values("main", 0.6, 30, 5, 1);
  var_0 maps\_cinematography::cinseq_key("focus_zak_son_2") maps\_cinematography::cinseq_key_time(7.8) maps\_cinematography::cinseq_key_dyndof_values("main", 1.8, -1, 3, 1);
  var_0 maps\_cinematography::cinseq_key("blur_back_out") maps\_cinematography::cinseq_key_time(9.2) maps\_cinematography::cinseq_key_dyndof_values("main", 0.4, 1, 20, 5);
  var_0 maps\_cinematography::cinseq_key("focus_zak_son_3") maps\_cinematography::cinseq_key_time(9.7) maps\_cinematography::cinseq_key_dyndof_values("main", 1.8, -1, 5, 1);
  var_0 maps\_cinematography::cinseq_key("slight_blur_out_2") maps\_cinematography::cinseq_key_time(13) maps\_cinematography::cinseq_key_dyndof_values("main", 0.6, 30, 5, 1);
  var_0 maps\_cinematography::cinseq_key("focus_zak_son_4") maps\_cinematography::cinseq_key_time(13.2) maps\_cinematography::cinseq_key_dyndof_values("main", 1.8, -1, 3, 1);
  var_0 maps\_cinematography::cinseq_key("focus_normal") maps\_cinematography::cinseq_key_time(16) maps\_cinematography::cinseq_key_dyndof_values("main", 12, 800, 2, 0.7) maps\_cinematography::cinseq_key_dyndof_ref_ent("main", undefined);
  common_scripts\utility::flag_wait("ambush_tower_blackout_come_to");
  var_0 maps\_cinematography::cinseq_start_sequence();
  maps\_cinematography::dyndof_system_end();
}

handle_village_start_lighting() {
  common_scripts\utility::flag_wait("aa_hunt");
  setculldist(0);
}

setup_village_start_lighting() {
  setup_daytime_lights();
}

setup_morpheus_start_lighting() {
  setup_daytime_lights();
}

setup_apartment_start_lighting() {
  setup_daytime_lights();
}

create_overlay_element(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 0;
  var_2.y = 0;
  var_2 setshader(var_0, 640, 480);
  var_2.alignx = "left";
  var_2.aligny = "top";
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_2.alpha = var_1;
  var_2.foreground = 1;
  var_2.sort = 2;
  return var_2;
}

setup_daytime_lights() {
  maps\_utility::set_vision_set("ambush", 0);
  maps\_utility::vision_set_fog_changes("ambush", 0);
  level.player setclutforplayer("clut_ambush_chase01", 1.0);
  level.player maps\_utility::set_light_set_player("ambush");
  var_0 = getent("dawn_skydome", "targetname");
  var_1 = getent("day_skydome", "targetname");
  var_0 delete();
  var_1 show();
  var_2 = getentarray("bright_fixtures", "targetname");

  foreach(var_4 in var_2)
  var_4 delete();

  var_6 = getentarray("bright_lights", "targetname");

  foreach(var_8 in var_6)
  var_8 setlightintensity(1);
}