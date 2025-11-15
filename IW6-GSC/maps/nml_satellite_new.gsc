/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nml_satellite_new.gsc
**************************************/

satellite_paths() {
  maps\nml_util::team_unset_colors(128);
  maps\nml_util::hero_paths("sat_pos_1");
  level.baker waittill("path_end_reached");
  maps\nml_util::volume_waittill_no_axis("sat_area_1_volume");
  maps\nml_util::hero_paths("sat_pos_2");
}

flush_sat_camp_1(var_0, var_1) {
  var_2 = common_scripts\utility::get_target_ent("dog_jump_sat_camp_1");
  var_2 maps\_anim::anim_generic_reach(self, "german_shepherd_run_jump_window_40");
  level notify("dog_flush_started");
  maps\_utility::disable_pain();
  var_2 maps\_anim::anim_generic(self, "german_shepherd_run_jump_window_40");
  self setgoalpos(self.origin);
  thread maps\_utility::play_sound_on_entity("anml_dog_bark");
  thread maps\_anim::anim_generic_loop(self, "cairo_growl_loop");
  flush_church_proc(var_0);
  level notify("dog_flush_done");
}

flush_church_proc(var_0) {
  var_0.done_flushing = 1;
  thread open_front_door();
  wait 2;
}

open_front_door() {
  var_0 = maps\_utility::get_living_ai("camp_1_guy_fall", "script_noteworthy");
  var_1 = maps\_utility::get_living_ai("camp_1_guy_shoot", "script_noteworthy");
  var_2 = common_scripts\utility::getstruct("camp_1_guy_fall", "script_noteworthy");
  var_3 = common_scripts\utility::getstruct("camp_1_guy_shoot", "script_noteworthy");
  var_1.goalradius = 16;
  var_1 thread maps\_utility::play_sound_on_entity("SP_0_stealth_alert");
  var_0 setgoalpos(var_2.origin);
  var_1 setgoalpos(var_3.origin);
  var_0.ignoreme = 1;
  var_1.ignoreme = 1;
  var_0.ignoreall = 1;
  var_1.ignoreall = 1;
  wait 0.1;
  var_3 thread maps\_anim::anim_generic_reach(var_1, var_3.animation);
  var_2 maps\_anim::anim_generic_reach(var_0, var_2.animation);
  var_4 = common_scripts\utility::get_target_ent("sat_camp_door_front");
  var_4 rotateyaw(120, 0.35);
  var_4 connectpaths();
  var_4 = common_scripts\utility::get_target_ent("sat_camp_door_back");
  var_4 rotateyaw(-120, 0.15);
  var_4 connectpaths();
  thread common_scripts\utility::play_sound_in_space("wood_door_kick", var_4.origin);
  thread guy_do_animation(var_0, var_2);
  thread guy_do_animation(var_1, var_3);
  level.dog notify("stop_loop");
}

guy_do_animation(var_0, var_1) {
  var_0 endon("death");
  var_1 maps\_anim::anim_generic(var_0, var_1.animation);
  var_0.ignoreme = 0;
  var_0.ignoreall = 0;
  var_0 setgoalentity(level.player);
}