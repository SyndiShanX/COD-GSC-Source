/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_infantry_panic_room_anim.gsc
******************************************************/

main() {
  vehicles();
  humans();
}

#using_animtree("generic_human");

humans() {
  level.scr_anim["merrick"]["panic_room"] = % oilrocks_ending_merrick;
  level.scr_anim["hesh"]["panic_room"] = % oilrocks_ending_hesh;
  level.scr_anim["rorke"]["panic_room"] = % oilrocks_ending_rourke;
  level.scr_anim["merrick"]["pre_breach_set"][0] = % cqb_stand_signal_move_up;
  level.scr_anim["hesh"]["pre_breach_set"][0] = % cqb_stand_signal_move_up;
  level.scr_anim["merrick"]["pre_breach_set"][1] = % cqb_stand_idle;
  level.scr_anim["hesh"]["pre_breach_set"][1] = % cqb_stand_idle;
  level.scr_anim["merrick"]["pre_breach_set"][2] = % cqb_stand_twitch;
  level.scr_anim["hesh"]["pre_breach_set"][2] = % cqb_stand_twitch;
  level.scr_anim["keegan"]["pre_breach_set"][0] = % coverstand_hide_idle_wave02;
  var_0 = "keegan";
  var_1 = "dude_door_kick";
  maps\_anim::create_anim_scene(#animtree, var_1, % doorkick_2_cqbrun, var_0);
  maps\_anim::addnotetrack_customfunction(var_0, "kick", ::doors_swingopen, var_1);
  var_1 = "keegan_jumps_out_window";
  maps\_anim::create_anim_scene(#animtree, var_1, % oilrocks_ending_friendly, var_0);
}

doors_swingopen(var_0) {
  thread common_scripts\utility::play_sound_in_space("scn_oilrocks_ending_door_kick", var_0 gettagorigin("J_Ankle_RI"));
  rotate_door_to_struct_ref("kick_door_left");
  rotate_door_to_struct_ref("kick_door_right");
  var_1 = getent("kick_door_clip", "targetname");
  var_1 connectpaths();
  var_1 delete();
  getent("kick_door_clip_player", "targetname") delete();
}

rotate_door_to_struct_ref(var_0) {
  var_1 = getent(var_0, "targetname");
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");
  var_1 rotateto(var_2.angles, 0.5, 0, 0.2);
  var_1 moveto(var_2.origin, 0.5, 0, 0.2);
}

#using_animtree("vehicles");

vehicles() {
  maps\_anim::create_anim_scene(#animtree, "choppers_fly_in", % oilrocks_ending_apache_1, "apache_1");
  maps\_anim::create_anim_scene(#animtree, "choppers_fly_in", % oilrocks_ending_apache_2, "apache_2");
  maps\_anim::create_anim_scene(#animtree, "choppers_fly_in", % oilrocks_ending_silenthawk, "silenthawk");
}