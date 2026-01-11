/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_patrol_anims_creepwalk.gsc
********************************************/

main() {
  humans();
  dogs();
}

#using_animtree("generic_human");

humans() {
  level.scr_anim["generic"]["_stealth_patrol_walk_creepwalk"] = % creepwalk_f;
  level.scr_anim["generic"]["patrol_walk_creepwalk"][0] = % creepwalk_f;
  level.scr_anim["generic"]["patrol_walk_creepwalk"][1] = % creepwalk_twitch_a_1;
  level.scr_anim["generic"]["patrol_walk_creepwalk"][2] = % creepwalk_twitch_a_2;
  level.scr_anim["generic"]["patrol_walk_creepwalk"][3] = % creepwalk_twitch_a_3;
  level.scr_anim["generic"]["patrol_walk_creepwalk"][4] = % creepwalk_twitch_a_4;
  level.scr_anim["generic"]["patrol_idle_creepwalk"][0] = % readystand_idle;
  var_0 = [4, 1, 1, 1, 1];
  level.scr_anim["generic"]["patrol_walk_weights_creepwalk"] = common_scripts\utility::get_cumulative_weights(var_0);
  level.scr_anim["generic"]["patrol_stop_creepwalk"] = % creepwalk_2_readystand;
  level.scr_anim["generic"]["patrol_start_creepwalk"] = % readystand_2_creepwalk;
}

dogs() {}

enable_creepwalk() {
  self.script_animation = "creepwalk";

  if(isDefined(self.script_patroller) && self.script_patroller) {
    maps\_patrol::set_patrol_run_anim_array();
  }
}

init_creepwalk_archetype() {
  if(isDefined(anim.archetypes) && maps\_utility::archetype_exists("creepwalk")) {
    return;
  }
  var_0 = [];
  var_0["cover_trans_angles"]["creepwalk"][1] = 45;
  var_0["cover_trans_angles"]["creepwalk"][2] = 0;
  var_0["cover_trans_angles"]["creepwalk"][3] = -45;
  var_0["cover_trans_angles"]["creepwalk"][4] = 90;
  var_0["cover_trans_angles"]["creepwalk"][6] = -90;
  var_0["cover_trans_angles"]["creepwalk"][8] = 180;
  var_0["run"]["straight"] = % creepwalk_f;
  var_0["run"]["move_f"] = % creepwalk_f;
  var_0["walk"]["straight"] = % creepwalk_f;
  var_0["walk"]["move_f"] = % creepwalk_f;
  var_0["run"]["straight_twitch"] = [ % creepwalk_twitch_a_1, % creepwalk_twitch_a_2, % creepwalk_twitch_a_3];
  var_0["flashed"]["flashed"] = [ % creepwalk_flashbang_a, % creepwalk_flashbang_b];
  var_0["run_turn"][2] = [ % creepwalk_turn_90_l, % creepwalk_turn_90_l_aiming];
  var_0["run_turn"][3] = % creepwalk_turn_45_l;
  var_0["run_turn"][5] = % creepwalk_turn_45_r;
  var_0["run_turn"][6] = [ % creepwalk_turn_90_r, % creepwalk_turn_90_r_aiming];
  maps\_utility::register_archetype("creepwalk", var_0);
}