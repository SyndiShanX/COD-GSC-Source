/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_jumpscares.gsc
***************************************************/

init() {
  thread manage_possums();
}

manage_possums() {
  level endon("game_ended");
  wait(1);
  var_03 = common_scripts\utility::func_46B7("feign_death_struct", "targetname");
  foreach(var_05 in var_03) {
    var_05 initialize_feign_death();
    var_05.scare_zone = lib_055A::getzoneclosesttopoint(var_05.var_186.origin, 0);
  }

  var_07 = gettime();
  wait_for_cycle();
  for(;;) {
    var_08 = undefined;
    foreach(var_0A in common_scripts\utility::func_F92(var_03)) {
      var_0B = var_0A.scare_zone;
      var_0C = lib_055A::func_4626(var_0B, 1);
      if(var_0C.size == 0 && common_scripts\utility::func_562E(level.var_AC80.var_ACB3[var_0B].var_556E)) {
        var_08 = var_0A;
        break;
      }
    }

    if(isDefined(var_08)) {
      var_0E = level.var_A980 + randomintrange(2, 5);
      wait_for_jscare_complete(var_08);
      while(level.var_A980 < var_0E) {
        wait(0.125);
      }
    } else {}

    var_0F = gettime();
    var_10 = var_0F - var_07 / 1000;
    var_11 = clamp(180 - var_10, 5, 180);
    wait_for_cycle(var_11);
  }
}

wait_for_jscare_complete(param_00) {
  if(isDefined(param_00)) {
    var_01 = gettime();
    param_00 reset_feign_death();
    var_02 = spawn("script_model", param_00.var_186.origin);
    param_00 thread do_feign_death(var_02);
    var_03 = 90;
    var_04 = var_02 common_scripts\utility::func_A71A(var_03, "do_jumpscare", "jscare_zombie_unfrozen");
    if(var_04 != "do_jumpscare") {
      var_05 = lib_055A::func_4626(param_00.scare_zone, 0);
      while(var_05.size != 0 && var_04 != "do_jumpscare") {
        var_04 = var_02 common_scripts\utility::func_A71A(1, "do_jumpscare");
        var_05 = lib_055A::func_4626(param_00.scare_zone, 0);
      }

      if(var_04 != "do_jumpscare") {
        param_00 notify("end_possum");
        var_02 notify("end_possum");
        var_02 delete();
        return;
      }
    }
  }
}

wait_for_cycle(param_00) {
  var_01 = 0;
  var_02 = 5;
  if(!isDefined(param_00)) {
    param_00 = 180;
  }

  while(var_01 < param_00) {
    wait(var_02);
    var_01 = var_01 + var_02;
  }
}

initialize_feign_death() {
  var_00 = [];
  var_00["s2_zom_core_feign_death_scare_idle_v1"] = % s2_zom_core_feign_death_scare_idle_v1;
  var_00["s2_zom_core_feign_death_scare_idle_v2"] = % s2_zom_core_feign_death_scare_idle_v2;
  var_00["s2_zom_core_feign_death_scare_idle_v3"] = % s2_zom_core_feign_death_scare_idle_v3;
  var_00["s2_zom_core_feign_death_scare_idle_v4"] = % s2_zom_core_feign_death_scare_idle_v4;
  var_01 = [];
  var_01["s2_zom_core_feign_death_scare_v1"] = % s2_zom_core_feign_death_scare_v1;
  var_01["s2_zom_core_feign_death_scare_v2"] = % s2_zom_core_feign_death_scare_v2;
  var_01["s2_zom_core_feign_death_scare_v3"] = % s2_zom_core_feign_death_scare_v3;
  var_01["s2_zom_core_feign_death_scare_v4"] = % s2_zom_core_feign_death_scare_v4;
  var_02 = common_scripts\utility::func_44BE(self.target, "targetname");
  foreach(var_04 in var_02) {
    switch (var_04.script_noteworthy) {
      case "zombie_spawner":
        self.var_186 = var_04;
        break;

      case "feign_death_trigger":
        self.var_9D65 = var_04;
        break;
    }
  }

  self.var_5049 = var_00;
  self.scare_anims = var_01;
  reset_feign_death();
}

reset_feign_death() {
  var_00 = randomintrange(1, 5);
  self.anim_sel = var_00;
  if(isDefined(self.var_81E1)) {
    self.anim_sel = self.var_81E1;
  }
}

do_feign_death(param_00) {
  self endon("end_possum");
  var_01 = "scripted_feign_death_scare_" + self.anim_sel;
  param_00 childthread execute_ground_scare(self, var_01);
  wait_for_player_close();
  param_00 notify("do_jumpscare");
}

wait_for_player_close() {
  self endon("end_possum");
  for(;;) {
    foreach(var_01 in level.players) {
      if(distance(var_01.origin, self.var_186.origin) > 220) {
        continue;
      }

      if(!sighttracepassed(var_01 getEye(), self.var_186.origin + (0, 0, 8), 0, undefined)) {
        continue;
      }

      return;
    }

    wait 0.05;
  }
}

execute_ground_scare(param_00, param_01) {
  var_02 = lib_054D::func_90BA("zombie_generic", param_00.var_186, "jumpscare", 0, 1, 1, "possum");
  var_02.var_6816 = 1;
  var_02 execute_frozen_state(param_00.var_186, self, param_01);
  if(isDefined(self)) {
    self notify("jscare_zombie_unfrozen");
  }
}

execute_frozen_state(param_00, param_01, param_02) {
  self endon("death");
  var_03 = param_02;
  var_04 = maps / mp / agents / _scripted_agent_anim_util::func_434D(var_03);
  var_05 = self method_83DB(var_04);
  var_06 = randomint(var_05);
  self scragentsetscripted(1);
  maps / mp / agents / _scripted_agent_anim_util::func_8732(1, var_03);
  maps\mp\_utility::func_2CED(0.5, ::setpossumgoal);
  self scragentsetorientmode("face angle abs", self.angles);
  self method_839C("anim deltas");
  self.frozen = 1;
  thread maps / mp / agents / _scripted_agent_anim_util::func_71FA(var_04, var_06, 0, "scripted_anim", undefined, undefined, 0);
  var_07 = 90;
  common_scripts\utility::func_A70D(var_07, param_01, "do_jumpscare");
  param_01 notify("do_jumpscare");
  lib_0378::func_8D74("js_corpse_becomes_zombie");
  self.frozen = 0;
  self notify("scripted_anim", "end");
  childthread setfacingenemy();
  maps / mp / agents / _scripted_agent_anim_util::func_71FA(var_04, var_06, 1, "scripted_anim");
  maps / mp / agents / _scripted_agent_anim_util::func_8732(0, var_03);
  self scragentsetscripted(0);
}

setfacingenemy() {
  wait(0.25);
  self scragentsetorientmode("face enemy");
}

setpossumgoal() {
  self method_8395(self.origin);
}