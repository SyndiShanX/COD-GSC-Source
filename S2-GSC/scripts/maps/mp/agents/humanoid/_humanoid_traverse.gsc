/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\humanoid\_humanoid_traverse.gsc
******************************************************************/

main() {
  if(!isDefined(level._id_AC6C) || !isDefined(level._id_AC6C["humanoid"]))
    _id_52C7();

  _id_32B7();
}

_id_4232(var_0) {
  return _func_083(var_0, 0, maps\mp\agents\_scripted_agent_anim_util::_id_446A(var_0));
}

_id_4392(var_0, var_1) {
  if(var_0.type == "Begin 3D")
    var_2 = var_0.origin + (0, 0, -16);
  else {
    var_2 = _func_082(var_0.origin, var_1, 32, 32, 0);

    if(!isDefined(var_2))
      var_2 = var_0.origin;
  }

  return var_2;
}

_id_2CE5(var_0) {
  waitframe();
  var_0 _id_056D::_id_5A86();
}

_id_32B7() {
  var_0 = self _meth_8198();
  var_1 = _id_4392(var_0, self.radius);
  var_2 = self _meth_857F();
  self setOrigin(var_1, 0);
  self.angles = var_0.angles;
  var_3 = level._id_AC6C[self._id_90DC][var_0._id_001E];
  var_4 = self[[maps\mp\agents\_agent_utility::_id_0A59("get_action_params")]]();
  var_5 = maps\mp\agents\_scripted_agent_anim_util::_id_087C(var_3, var_4);

  if(!isDefined(var_5)) {
    _id_2CE5(self);
    return;
  }

  var_7 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_5);
  var_8 = self _meth_83D8(var_5, var_7);
  _id_62AC(var_0, var_8);
  self endon("killanimscript");
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "DoTraverse");
  self _meth_839B("face angle abs", var_0.angles);
  self _meth_839C("anim deltas");
  self _meth_839D("noclip");
  self _meth_839A(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_5, var_7, self._id_9D0D);
  var_9 = _func_065(var_8);
  var_10 = maps\mp\agents\_scripted_agent_anim_util::_id_446A(var_8);
  var_11 = _func_111(var_1, var_0.angles, (0, 0, 0), (0, 0, 0), _func_083(var_8, 0, var_10), (0, 0, 0));
  var_12 = (var_11["origin"][0], var_11["origin"][1], var_2[2]);
  var_13 = _func_082(var_12, self.radius, 32, 32, 0);

  if(!isDefined(var_13))
    var_13 = var_11["origin"];

  self._id_9D07 = vectorNormalize(var_13 - var_1);

  if(_func_066(var_8, "traverse_jump_start")) {
    var_14 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_8, "traverse_jump_start");
    var_15 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_8, "traverse_jump_end");
    wait(var_14 * var_9 / self._id_9D0D);
    var_16 = _func_083(var_8, var_14, var_15)[2];
    var_17 = _func_083(var_8, var_14, var_10)[2];
    var_18 = self.origin[2] + var_17;
    var_19 = var_18 - var_13[2];

    if(_func_0AE(var_16) < 5) {
      self _meth_839A(1, 0);
      var_20 = (var_15 - var_14) * var_9 / self._id_9D0D;
      childthread _id_9D0A(self.origin[2], self.origin[2] + var_16 - var_19, var_20);
      wait(var_20);
      self _meth_839A(1, 1);
    } else {
      var_21 = var_16 - var_19;
      var_22 = var_21 / var_16;
      var_23 = clamp(var_22, 0.4, 4);
      var_24 = _func_0D9(1 / var_23);
      var_25 = self._id_9D0D * var_24;
      self _meth_839A(1, var_23);
      self _meth_85D4(var_25);
      var_20 = (var_15 - var_14) * var_9 / var_25;
      wait(var_20);
      self _meth_839A(1, 1);
      self _meth_85D4(self._id_9D0D);
    }

    var_20 = (var_10 - var_15) * var_9 / self._id_9D0D;
    wait(var_20);
  } else {
    var_20 = var_9 * var_10 / self._id_9D0D;
    wait(var_20);
  }

  var_26 = _func_2E1(self.origin, self);
  var_27 = self _meth_857F();

  if(_func_0E1(var_26, self.origin) > 4 || _func_0AE(var_26[2] - self.origin[2]) > 16) {
    var_28 = _func_082(var_27, self.radius, 32, 32, 1);
    self setOrigin(var_28, 0);
  } else if(_func_0E1(self.origin, var_27) > 96 || _func_0AE(self.origin[2] - var_27[2]) > 16) {
    var_28 = _func_082(_func_2E1(var_27, self), self.radius, 32, 32, 1);
    self setOrigin(var_28, 0);
  }

  self._id_9D0C = gettime();
  self._id_9D0B = max(0.2, (1 - var_10) * var_9 / self._id_9D0D);
  self notify("traverse_end", var_0);
}

_id_62AC(var_0, var_1) {
  var_2 = 5000;
  var_3 = 4;
  var_4 = "freetraversal";
  var_5 = _func_065(var_1);
  var_6 = var_5 * 1000;
  var_2 = int(var_6);

  if(_func_066(var_1, var_4)) {
    var_7 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_1, var_4);
    var_2 = int(var_7 * var_6);
  }

  var_8 = var_2 / 1000;
  var_0._id_54F5 = 1;
  var_0._id_98C3 = undefined;
  var_0._id_A228 = self;
  _func_329(var_0, 1);
  self _meth_85ED(var_3, var_2);
  thread _id_8322(var_0, var_8);
}

_id_8322(var_0, var_1) {
  wait(var_1);
  var_0._id_54F5 = 0;
  var_0._id_98C3 = undefined;
  var_0._id_A228 = undefined;

  if(!_id_0547::_id_562C(var_0))
    _func_329(var_0, 0);
}

_id_9D0A(var_0, var_1, var_2) {
  var_3 = gettime();

  for(;;) {
    var_4 = (gettime() - var_3) / 1000.0;
    var_5 = var_4 / var_2;

    if(var_5 > 1.0) {
      break;
    }

    var_6 = _func_2CA(var_0, var_1, var_5);
    self setOrigin((self.origin[0], self.origin[1], var_6), 0);
    waitframe();
  }
}

_id_0085() {
  self _meth_839A(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "Traverse end_script");
  _id_0547::_id_84CB();
  self._id_9D07 = undefined;
}

_id_52C7() {
  if(!isDefined(level._id_AC6C))
    level._id_AC6C = [];

  if(!isDefined(level._id_AC6C["humanoid"]))
    level._id_AC6C["humanoid"] = [];

  if(!isDefined(level._id_AC6C["zombie_boss_village"]))
    level._id_AC6C["zombie_boss_village"] = [];

  level._id_AC6C["humanoid"]["jump_across_100"] = "traverse_jump_across_100";
  level._id_AC6C["humanoid"]["jump_across_196"] = "traverse_jump_across_196";
  level._id_AC6C["humanoid"]["jump_down_40"] = "traverse_jump_down_40";
  level._id_AC6C["humanoid"]["jump_down_80"] = "traverse_jump_down_slow";
  level._id_AC6C["humanoid"]["jump_down_fast"] = "traverse_jump_down_fast";
  level._id_AC6C["humanoid"]["jump_down_fast_256"] = "traverse_jump_down_fast_256";
  level._id_AC6C["humanoid"]["jump_down_slow"] = "traverse_jump_down_slow";
  level._id_AC6C["humanoid"]["jump_down_wall_crack"] = "traverse_jump_down_wall_crack";
  level._id_AC6C["humanoid"]["jump_up_40"] = "traverse_step_up_40";
  level._id_AC6C["humanoid"]["jump_up_80"] = "traverse_jump_up_80";
  level._id_AC6C["humanoid"]["nonboost_jump_up_120"] = "traverse_jump_up_120";
  level._id_AC6C["humanoid"]["spawn_closet_door"] = "traverse_spawn_closet_door";
  level._id_AC6C["humanoid"]["spawn_closet_high_window"] = "traverse_spawn_closet_high_window";
  level._id_AC6C["humanoid"]["spawn_closet_vault"] = "traverse_spawn_closet_vault";
  level._id_AC6C["humanoid"]["spawn_closet_window_left"] = "traverse_spawn_closet_window_left";
  level._id_AC6C["humanoid"]["spawn_closet_window_middle"] = "traverse_spawn_closet_window_middle";
  level._id_AC6C["humanoid"]["spawn_closet_window_right"] = "traverse_spawn_closet_window_right";
  level._id_AC6C["humanoid"]["spawn_floorgrate_up"] = "traverse_spawn_floorgrate_up";
  level._id_AC6C["humanoid"]["step_up_40"] = "traverse_step_up_40";
  level._id_AC6C["humanoid"]["step_over_40"] = "traverse_step_over_40";
  level._id_AC6C["humanoid"]["wall_384_over_32"] = "traverse_wall_384_over_32";
  level._id_AC6C["humanoid"]["wall_384_over_64"] = "traverse_wall_384_over_64";
  level._id_AC6C["humanoid"]["wall_climb_up_128_over_32"] = "traverse_wall_climb_up_128_over_32";
  level._id_AC6C["humanoid"]["wall_over_40"] = "traverse_mantle_over_40";
  level._id_AC6C["humanoid"]["window_over_40"] = "traverse_step_over_40";
  level._id_AC6C["humanoid"]["window_over_36"] = "traverse_window_over_36";
  level._id_AC6C["humanoid"]["door_run_right"] = "traverse_door_run_right";
  level._id_AC6C["humanoid"]["door_walk_left"] = "traverse_door_walk_left";
  level._id_AC6C["humanoid"]["door_fall_walk_left"] = "traverse_door_fall_walk_left";
  level._id_AC6C["humanoid"]["door_fall_walk_right"] = "traverse_door_fall_walk_right";
  level._id_AC6C["humanoid"]["climb_up_fire"] = "traverse_climb_up_fire";
  level._id_AC6C["humanoid"]["climb_up_fire_204"] = "traverse_climb_up_fire_204";
  level._id_AC6C["humanoid"]["climb_up_water"] = "traverse_climb_up_water";
  level._id_AC6C["humanoid"]["spawn_grate_left"] = "spawn_crawl_left";
  level._id_AC6C["humanoid"]["spawn_grate_right"] = "spawn_crawl_right";
  level._id_AC6C["humanoid"]["spawn_grate_forward"] = "spawn_crawl_forward";
  level._id_AC6C["humanoid"]["fall_down_236_middle"] = "traverse_fall_down_236_middle";
  level._id_AC6C["humanoid"]["fall_down_236_left"] = "traverse_fall_down_236_left";
  level._id_AC6C["humanoid"]["fall_down_236_right"] = "traverse_fall_down_236_right";
  level._id_AC6C["humanoid"]["fireman_intro_up"] = "scripted_fire_intro_climb_up";
  level._id_AC6C["humanoid"]["fireman_intro_down"] = "scripted_fire_intro_climb_down";
  level._id_AC6C["humanoid"]["box_scare_v1"] = "traverse_box_scare_v1";
  level._id_AC6C["humanoid"]["box_scare_v3"] = "traverse_box_scare_v3";
  level._id_AC6C["zombie_boss_village"]["s2_brute_walk_up_stairs"] = "brute_up_stairs";
  level._id_AC6C["zombie_boss_village"]["s2_brute_walk_down_stairs"] = "brute_down_stairs";
  level._id_AC6C["zombie_boss_village"]["brute_boss_village_exit_traversal"] = "brute_boss_village_mantle";
  level._id_AC6C["humanoid"]["crawl_down_300"] = "traverse_crawl_down_300";
  level._id_AC6C["humanoid"]["crawl_down_256"] = "traverse_crawl_down_256";
  level._id_AC6C["humanoid"]["crawl_down_120"] = "traverse_crawl_down_120";
  level._id_AC6C["humanoid"]["crawl_up_300"] = "traverse_crawl_up_300";
  level._id_AC6C["humanoid"]["crawl_up_256"] = "traverse_crawl_up_256";
  level._id_AC6C["humanoid"]["asn_crawl_exit"] = "traverse_asn_crawl_exit";
  level._id_AC6C["humanoid"]["low_wall_enter"] = "traverse_low_wall_enter";
  level._id_AC6C["humanoid"]["over_40"] = "traverse_over_40";
  level._id_AC6C["humanoid"]["wall_jumpup_112"] = "traverse_wall_jump_up_112_over_32_dlc";
  level._id_AC6C["humanoid"]["wall_climb_up_128_over_32_dlc"] = "traverse_wall_climb_up_128_over_32_dlc";
  level._id_AC6C["humanoid"]["wall_climb_up_128_over_48_dlc3"] = "traverse_wall_climb_up_128_over_32";
  level._id_AC6C["humanoid"]["bunker_jump_130_l"] = "traverse_bunker_jump_130_l";
  level._id_AC6C["humanoid"]["bunker_jump_130_r"] = "traverse_bunker_jump_130_r";
  level._id_AC6C["humanoid"]["jump_down_256_f_64"] = "traverse_jump_down_256_f_64_dlc";
  level._id_AC6C["humanoid"]["wall_drop_130"] = "traverse_jump_down_130_f_32_dlc";
  level._id_AC6C["humanoid"]["bunker_jump_300_l"] = "traverse_bunker_jump_300_l";
  level._id_AC6C["humanoid"]["bob_down_40"] = "traverse_bob_down_40";
  level._id_AC6C["humanoid"]["bob_over_40"] = "traverse_bob_over_40";
  level._id_AC6C["humanoid"]["bob_up_40"] = "traverse_bob_up_40";
  level._id_AC6C["humanoid"]["sizzler_over_40"] = "traverse_sizzler_over_40";
  level._id_AC6C["humanoid"]["sizzler_up_40"] = "traverse_sizzler_up_40";
  level._id_AC6C["humanoid"]["sizzler_down_40"] = "traverse_sizzler_down_40";
  level._id_AC6C["humanoid"]["grd_intro_down"] = "scripted_grd_intro_down";
  level._id_AC6C["humanoid"]["cpe_ceiling_drop"] = "spawn_drop_dlc4";
}