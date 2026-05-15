/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_patrol_anims_gundown.gsc
******************************************/

main() {
  humans();
  dogs();
}

#using_animtree("generic_human");

humans() {
  level.scr_anim["generic"]["_stealth_patrol_walk_gundown"] = % patrol_bored_gundown_walk1;
  level.scr_anim["generic"]["_stealth_look_around_gundown"][0] = % patrol_bored_gundown_alerted_1;
  level.scr_anim["generic"]["_stealth_look_around_gundown"][1] = % patrol_bored_gundown_alerted_2;
  level.scr_anim["generic"]["patrol_walk_gundown"][0] = % patrol_bored_gundown_walk1;
  level.scr_anim["generic"]["patrol_walk_gundown"][1] = % patrol_bored_gundown_walk2;
  level.scr_anim["generic"]["patrol_walk_gundown"][2] = % patrol_bored_gundown_walk3;
  var_0 = [3, 1, 1];
  level.scr_anim["generic"]["patrol_walk_weights_gundown"] = common_scripts\utility::get_cumulative_weights(var_0);
  level.scr_anim["generic"]["patrol_idle_gundown"][0] = % patrol_bored_gundown_idle;
  level.scr_anim["generic"]["patrol_stop_gundown"] = % patrol_bored_gundown_walk2idle;
  level.scr_anim["generic"]["patrol_start_gundown"] = % patrol_bored_gundown_idle2walk;
}

dogs() {}

enable_gundown() {
  self.script_animation = "gundown";

  if(isDefined(self.script_patroller) && self.script_patroller) {
    maps\_patrol::set_patrol_run_anim_array();
  }
}