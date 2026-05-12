/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\agents\humanoid\_humanoid_traverse.gsc
**********************************************************/

func_00F9() {
  if(!isDefined(level.var_AC6C) || !isDefined(level.var_AC6C["humanoid"])) {
    func_52C7();
  }

  func_32B7();
}

func_4232(param_00) {
  return getmovedelta(param_00, 0, maps\mp\agents\_scripted_agent_anim_util::func_446A(param_00));
}

func_4392(param_00, param_01) {
  if(param_00.var_01B9 == "Begin 3D") {
    var_02 = param_00.var_0116 + (0, 0, -16);
  } else {
    var_02 = getgroundposition(param_01.var_0116, var_02, 32, 32, 0);
    if(!isDefined(var_02)) {
      var_02 = param_00.var_0116;
    }
  }

  return var_02;
}

func_2CE5(param_00) {
  wait 0.05;
  param_00 lib_056D::func_5A86();
}

func_32B7() {
  var_00 = self method_8198();
  var_01 = func_4392(var_00, self.var_014F);
  var_02 = self method_857F();
  self setorigin(var_01, 0);
  self.var_001D = var_00.var_001D;
  var_03 = level.var_AC6C[self.var_90DC][var_00.var_001E];
  var_04 = self[[maps\mp\agents\_agent_utility::func_0A59("get_action_params")]]();
  var_05 = maps\mp\agents\_scripted_agent_anim_util::func_087C(var_03, var_04);
  if(!isDefined(var_05)) {
    func_2CE5(self);
    return;
  }

  var_07 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_05);
  var_08 = self method_83D8(var_05, var_07);
  func_62AC(var_00, var_08);
  self endon("killanimscript");
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "DoTraverse");
  self scragentsetorientmode("face angle abs", var_00.var_001D);
  self method_839C("anim deltas");
  self method_839D("noclip");
  self method_839A(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::func_8415(var_05, var_07, self.var_9D0D);
  var_09 = getanimlength(var_08);
  var_0A = maps\mp\agents\_scripted_agent_anim_util::func_446A(var_08);
  var_0B = transformmove(var_01, var_00.var_001D, (0, 0, 0), (0, 0, 0), getmovedelta(var_08, 0, var_0A), (0, 0, 0));
  var_0C = (var_0B["origin"][0], var_0B["origin"][1], var_02[2]);
  var_0D = getgroundposition(var_0C, self.var_014F, 32, 32, 0);
  if(!isDefined(var_0D)) {
    var_0D = var_0B["origin"];
  }

  self.var_9D07 = vectornormalize(var_0D - var_01);
  if(animhasnotetrack(var_08, "traverse_jump_start")) {
    var_0E = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_08, "traverse_jump_start");
    var_0F = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_08, "traverse_jump_end");
    wait(var_0E * var_09 / self.var_9D0D);
    var_10 = getmovedelta(var_08, var_0E, var_0F)[2];
    var_11 = getmovedelta(var_08, var_0E, var_0A)[2];
    var_12 = self.var_0116[2] + var_11;
    var_13 = var_12 - var_0D[2];
    if(abs(var_10) < 5) {
      self method_839A(1, 0);
      var_14 = var_0F - var_0E * var_09 / self.var_9D0D;
      childthread func_9D0A(self.var_0116[2], self.var_0116[2] + var_10 - var_13, var_14);
      wait(var_14);
      self method_839A(1, 1);
    } else {
      var_15 = var_10 - var_13;
      var_16 = var_15 / var_10;
      var_17 = clamp(var_16, 0.4, 4);
      var_18 = sqrt(1 / var_17);
      var_19 = self.var_9D0D * var_18;
      self method_839A(1, var_17);
      self method_85D4(var_19);
      var_14 = var_0F - var_0E * var_09 / var_19;
      wait(var_14);
      self method_839A(1, 1);
      self method_85D4(self.var_9D0D);
    }

    var_14 = var_0A - var_0F * var_09 / self.var_9D0D;
    wait(var_14);
  } else {
    var_14 = var_0F * var_10 / self.var_9D0D;
    wait(var_13);
  }

  var_1A = getclosestpointonnavmesh(self.var_0116, self);
  var_1B = self method_857F();
  if(distance2d(var_1A, self.var_0116) > 4 || abs(var_1A[2] - self.var_0116[2]) > 16) {
    var_1C = getgroundposition(var_1B, self.var_014F, 32, 32, 1);
    self setorigin(var_1C, 0);
  } else if(distance2d(self.var_0116, var_1B) > 96 || abs(self.var_0116[2] - var_1B[2]) > 16) {
    var_1C = getgroundposition(getclosestpointonnavmesh(var_1B, self), self.var_014F, 32, 32, 1);
    self setorigin(var_1C, 0);
  }

  self.var_9D0C = gettime();
  self.var_9D0B = max(0.2, 1 - var_0F * var_0E / self.var_9D0D);
  self notify("traverse_end", var_07);
}

func_62AC(param_00, param_01) {
  var_02 = 5000;
  var_03 = 4;
  var_04 = "freetraversal";
  var_05 = getanimlength(param_01);
  var_06 = var_05 * 1000;
  var_02 = int(var_06);
  if(animhasnotetrack(param_01, var_04)) {
    var_07 = maps\mp\agents\_scripted_agent_anim_util::func_45B9(param_01, var_04);
    var_02 = int(var_07 * var_06);
  }

  var_08 = var_02 / 1000;
  param_00.var_54F5 = 1;
  param_00.var_98C3 = undefined;
  param_00.var_A228 = self;
  nodesetscriptblocked(param_00, 1);
  self method_85ED(var_03, var_02);
  thread func_8322(param_00, var_08);
}

func_8322(param_00, param_01) {
  wait(param_01);
  param_00.var_54F5 = 0;
  param_00.var_98C3 = undefined;
  param_00.var_A228 = undefined;
  if(!lib_0547::func_562C(param_00)) {
    nodesetscriptblocked(param_00, 0);
  }
}

func_9D0A(param_00, param_01, param_02) {
  var_03 = gettime();
  for(;;) {
    var_04 = gettime() - var_03 / 1000;
    var_05 = var_04 / param_02;
    if(var_05 > 1) {
      break;
    }

    var_06 = lerp(param_00, param_01, var_05);
    self setorigin((self.var_0116[0], self.var_0116[1], var_06), 0);
    wait 0.05;
  }
}

func_0085() {
  self method_839A(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "Traverse end_script");
  lib_0547::func_84CB();
  self.var_9D07 = undefined;
}

func_52C7() {
  if(!isDefined(level.var_AC6C)) {
    level.var_AC6C = [];
  }

  if(!isDefined(level.var_AC6C["humanoid"])) {
    level.var_AC6C["humanoid"] = [];
  }

  if(!isDefined(level.var_AC6C["zombie_boss_village"])) {
    level.var_AC6C["zombie_boss_village"] = [];
  }

  level.var_AC6C["humanoid"]["jump_across_100"] = "traverse_jump_across_100";
  level.var_AC6C["humanoid"]["jump_across_196"] = "traverse_jump_across_196";
  level.var_AC6C["humanoid"]["jump_down_40"] = "traverse_jump_down_40";
  level.var_AC6C["humanoid"]["jump_down_80"] = "traverse_jump_down_slow";
  level.var_AC6C["humanoid"]["jump_down_fast"] = "traverse_jump_down_fast";
  level.var_AC6C["humanoid"]["jump_down_fast_256"] = "traverse_jump_down_fast_256";
  level.var_AC6C["humanoid"]["jump_down_slow"] = "traverse_jump_down_slow";
  level.var_AC6C["humanoid"]["jump_down_wall_crack"] = "traverse_jump_down_wall_crack";
  level.var_AC6C["humanoid"]["jump_up_40"] = "traverse_step_up_40";
  level.var_AC6C["humanoid"]["jump_up_80"] = "traverse_jump_up_80";
  level.var_AC6C["humanoid"]["nonboost_jump_up_120"] = "traverse_jump_up_120";
  level.var_AC6C["humanoid"]["spawn_closet_door"] = "traverse_spawn_closet_door";
  level.var_AC6C["humanoid"]["spawn_closet_high_window"] = "traverse_spawn_closet_high_window";
  level.var_AC6C["humanoid"]["spawn_closet_vault"] = "traverse_spawn_closet_vault";
  level.var_AC6C["humanoid"]["spawn_closet_window_left"] = "traverse_spawn_closet_window_left";
  level.var_AC6C["humanoid"]["spawn_closet_window_middle"] = "traverse_spawn_closet_window_middle";
  level.var_AC6C["humanoid"]["spawn_closet_window_right"] = "traverse_spawn_closet_window_right";
  level.var_AC6C["humanoid"]["spawn_floorgrate_up"] = "traverse_spawn_floorgrate_up";
  level.var_AC6C["humanoid"]["step_up_40"] = "traverse_step_up_40";
  level.var_AC6C["humanoid"]["step_over_40"] = "traverse_step_over_40";
  level.var_AC6C["humanoid"]["wall_384_over_32"] = "traverse_wall_384_over_32";
  level.var_AC6C["humanoid"]["wall_384_over_64"] = "traverse_wall_384_over_64";
  level.var_AC6C["humanoid"]["wall_climb_up_128_over_32"] = "traverse_wall_climb_up_128_over_32";
  level.var_AC6C["humanoid"]["wall_over_40"] = "traverse_mantle_over_40";
  level.var_AC6C["humanoid"]["window_over_40"] = "traverse_step_over_40";
  level.var_AC6C["humanoid"]["window_over_36"] = "traverse_window_over_36";
  level.var_AC6C["humanoid"]["door_run_right"] = "traverse_door_run_right";
  level.var_AC6C["humanoid"]["door_walk_left"] = "traverse_door_walk_left";
  level.var_AC6C["humanoid"]["door_fall_walk_left"] = "traverse_door_fall_walk_left";
  level.var_AC6C["humanoid"]["door_fall_walk_right"] = "traverse_door_fall_walk_right";
  level.var_AC6C["humanoid"]["climb_up_fire"] = "traverse_climb_up_fire";
  level.var_AC6C["humanoid"]["climb_up_fire_204"] = "traverse_climb_up_fire_204";
  level.var_AC6C["humanoid"]["climb_up_water"] = "traverse_climb_up_water";
  level.var_AC6C["humanoid"]["spawn_grate_left"] = "spawn_crawl_left";
  level.var_AC6C["humanoid"]["spawn_grate_right"] = "spawn_crawl_right";
  level.var_AC6C["humanoid"]["spawn_grate_forward"] = "spawn_crawl_forward";
  level.var_AC6C["humanoid"]["fall_down_236_middle"] = "traverse_fall_down_236_middle";
  level.var_AC6C["humanoid"]["fall_down_236_left"] = "traverse_fall_down_236_left";
  level.var_AC6C["humanoid"]["fall_down_236_right"] = "traverse_fall_down_236_right";
  level.var_AC6C["humanoid"]["fireman_intro_up"] = "scripted_fire_intro_climb_up";
  level.var_AC6C["humanoid"]["fireman_intro_down"] = "scripted_fire_intro_climb_down";
  level.var_AC6C["humanoid"]["box_scare_v1"] = "traverse_box_scare_v1";
  level.var_AC6C["humanoid"]["box_scare_v3"] = "traverse_box_scare_v3";
  level.var_AC6C["zombie_boss_village"]["s2_brute_walk_up_stairs"] = "brute_up_stairs";
  level.var_AC6C["zombie_boss_village"]["s2_brute_walk_down_stairs"] = "brute_down_stairs";
  level.var_AC6C["zombie_boss_village"]["brute_boss_village_exit_traversal"] = "brute_boss_village_mantle";
  level.var_AC6C["humanoid"]["crawl_down_300"] = "traverse_crawl_down_300";
  level.var_AC6C["humanoid"]["crawl_down_256"] = "traverse_crawl_down_256";
  level.var_AC6C["humanoid"]["crawl_down_120"] = "traverse_crawl_down_120";
  level.var_AC6C["humanoid"]["crawl_up_300"] = "traverse_crawl_up_300";
  level.var_AC6C["humanoid"]["crawl_up_256"] = "traverse_crawl_up_256";
  level.var_AC6C["humanoid"]["asn_crawl_exit"] = "traverse_asn_crawl_exit";
  level.var_AC6C["humanoid"]["low_wall_enter"] = "traverse_low_wall_enter";
  level.var_AC6C["humanoid"]["over_40"] = "traverse_over_40";
  level.var_AC6C["humanoid"]["wall_jumpup_112"] = "traverse_wall_jump_up_112_over_32_dlc";
  level.var_AC6C["humanoid"]["wall_climb_up_128_over_32_dlc"] = "traverse_wall_climb_up_128_over_32_dlc";
  level.var_AC6C["humanoid"]["wall_climb_up_128_over_48_dlc3"] = "traverse_wall_climb_up_128_over_32";
  level.var_AC6C["humanoid"]["bunker_jump_130_l"] = "traverse_bunker_jump_130_l";
  level.var_AC6C["humanoid"]["bunker_jump_130_r"] = "traverse_bunker_jump_130_r";
  level.var_AC6C["humanoid"]["jump_down_256_f_64"] = "traverse_jump_down_256_f_64_dlc";
  level.var_AC6C["humanoid"]["wall_drop_130"] = "traverse_jump_down_130_f_32_dlc";
  level.var_AC6C["humanoid"]["bunker_jump_300_l"] = "traverse_bunker_jump_300_l";
  level.var_AC6C["humanoid"]["bob_down_40"] = "traverse_bob_down_40";
  level.var_AC6C["humanoid"]["bob_over_40"] = "traverse_bob_over_40";
  level.var_AC6C["humanoid"]["bob_up_40"] = "traverse_bob_up_40";
  level.var_AC6C["humanoid"]["sizzler_over_40"] = "traverse_sizzler_over_40";
  level.var_AC6C["humanoid"]["sizzler_up_40"] = "traverse_sizzler_up_40";
  level.var_AC6C["humanoid"]["sizzler_down_40"] = "traverse_sizzler_down_40";
  level.var_AC6C["humanoid"]["grd_intro_down"] = "scripted_grd_intro_down";
  level.var_AC6C["humanoid"]["cpe_ceiling_drop"] = "spawn_drop_dlc4";
}