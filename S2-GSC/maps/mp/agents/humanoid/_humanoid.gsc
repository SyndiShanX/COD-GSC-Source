/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\agents\humanoid\_humanoid.gsc
*************************************************/

func_8A27() {
  self.var_11AB = 26 + self.var_014F;
  self.var_60F5 = "normal";
  self.var_60F6 = 50;
  self.var_11B8 = 54;
  self.var_11B9 = -64;
  self.var_29BE = 2250000;
  self.var_00CB = 1;
  self.var_64C2 = 1;
  self.var_672D = 1;
  self.var_9D0D = 1;
  self.var_4013 = 1;
  self.var_173C = 0;
  self.var_173E = 1;
  self.var_99FC = 0;
  self.var_0012 = 1;
  self.var_60E1 = 40;
  self.var_60F0 = 60;
  self.var_60F1 = squared(self.var_60F0);
  lib_0547::func_86C7(self.var_60F0);
  self.var_2BCA = self.var_014F + 1;
  self method_8399(self.var_2BCA);
  self.var_60E5 = 0.5;
  if(!isDefined(self.var_8303)) {
    self.var_8303 = self.var_014F;
  }

  if(!isDefined(self.var_8302)) {
    self.var_8302 = self.var_00BD;
  }
}

func_00D5() {
  self.var_0EAD = spawnStruct();
  self.var_0EAD.var_6AFE = [];
  self.var_0EAD.var_6AFE["idle"] = ::maps\mp\agents\humanoid\_humanoid_idle::func_00F9;
  self.var_0EAD.var_6AFE["move"] = ::maps\mp\agents\humanoid\_humanoid_move::func_00F9;
  self.var_0EAD.var_6AFE["traverse"] = ::maps\mp\agents\humanoid\_humanoid_traverse::func_00F9;
  self.var_0EAD.var_6AFE["melee"] = ::maps\mp\agents\humanoid\_humanoid_melee::func_00F9;
  self.var_0EAD.var_6AFE["scripted"] = ::func_6B9F;
  self.var_0EAD.var_6B2F = [];
  self.var_0EAD.var_6B2F["idle"] = ::maps\mp\agents\humanoid\_humanoid_idle::func_0085;
  self.var_0EAD.var_6B2F["move"] = ::maps\mp\agents\humanoid\_humanoid_move::func_0085;
  self.var_0EAD.var_6B2F["melee"] = ::maps\mp\agents\humanoid\_humanoid_melee::func_0085;
  self.var_0EAD.var_6B2F["traverse"] = ::maps\mp\agents\humanoid\_humanoid_traverse::func_0085;
  self.var_0EAD.var_6B2F["scripted"] = ::func_6BA0;
  self.var_0EAD.var_6ADB = [];
  self.var_0EAD.var_6ADB["move"] = ::maps\mp\agents\humanoid\_humanoid_move::func_6ADB;
  self.var_0BA4 = "idle";
  self.var_0108 = "walk";
  self.var_017D = 100;
  self.var_014F = 15;
  self.var_00BD = 40;
}

func_6B9F() {
  self.var_57C0 = 1;
}

func_6BA0() {
  self.var_01BB = 0;
  self.var_57C0 = undefined;
}

func_8FC9(param_00, param_01, param_02, param_03) {
  self setModel("tag_origin");
  self.var_90DC = "humanoid";
  self.var_6AFF = ::maps\mp\agents\_scripted_agent_anim_util::func_6AFF;
  if(isDefined(param_01) && isDefined(param_02)) {
    var_04 = param_01;
    var_05 = param_02;
  } else {
    self method_856C(15, 60);
    var_06 = [[level.var_4696]]();
    var_04 = var_06.var_0116;
    var_05 = var_06.var_001D;
  }

  maps\mp\agents\_agent_utility::func_08A7();
  self.var_5CC6 = maps\mp\agents\_agent_utility::func_45AE(self.var_0109);
  self.var_90AB = gettime();
  self.var_5BE2 = gettime();
  func_00D5();
  self method_838F(var_04, var_05, param_00, 15, 60, param_03);
  level notify("spawned_agent", self);
  maps\mp\agents\_agent_common::func_83FD(100);
  if(isDefined(param_03)) {
    maps\mp\agents\_agent_utility::func_83FE(param_03.var_01A7, param_03);
  }

  self takeallweapons();
  self method_8537("human");
  self method_8539(1);
  self method_853C(0);
  self method_853E(0);
  self method_853F(0);
  self method_8540(1);
  self method_853D(1);
  self thread[[maps\mp\agents\_agent_utility::func_0A59("think")]]();
}

func_2EE6() {
  if(isDefined(self.var_5BBF) && isDefined(self.var_5BBE) && distance2dsquared(self.var_28D2.var_0116, self.var_5BBF) < 4 && distancesquared(self.var_0116, self.var_5BBE) < 2500) {
    return 1;
  }

  return 0;
}

func_2EE5() {
  if(isDefined(self.var_5BBC) && isDefined(self.var_5BBB) && distance2dsquared(self.var_28D2.var_0116, self.var_5BBC) < 4 && distancesquared(self.var_0116, self.var_5BBB) < 2500) {
    return 1;
  }

  return 0;
}

func_5859(param_00) {
  var_01 = 0;
  var_02 = param_00[2] - self.var_0116[2];
  var_01 = var_02 <= self.var_11B8 && var_02 >= self.var_11B9;
  if(!var_01 && isPlayer(self.var_28D2) && common_scripts\utility::func_562E(self.var_28D2.var_571F)) {
    if(length(self getvelocity()) < 5) {
      var_01 = var_02 <= self.var_11B8 * 2 && var_02 >= self.var_11B9;
    }
  }

  return var_01;
}

func_A7F8() {
  if(maps\mp\agents\humanoid\_humanoid_util::func_56DD(self.var_28D2)) {
    return 0;
  }

  return !func_5859(self.var_28D2.var_0116) && distance2dsquared(self.var_0116, self.var_28D2.var_0116) < maps\mp\agents\humanoid\_humanoid_util::func_4581() * 0.75 * 0.75;
}

func_7AC0(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = self.var_28D2;
  }

  if(!isDefined(param_01)) {
    return 0;
  }

  if(!maps\mp\_utility::func_57A0(param_01)) {
    return 0;
  }

  if(self.var_0BA4 == "traverse") {
    return 0;
  }

  if(!maps\mp\agents\humanoid\_humanoid_util::func_56DD(param_01)) {
    if(!func_5859(param_01.var_0116)) {
      return 0;
    }

    if(param_00 == "normal" && !maps\mp\agents\humanoid\_humanoid_util::func_AA51(param_01)) {
      return 0;
    } else if(param_00 == "base" && !maps\mp\agents\humanoid\_humanoid_util::func_AA52(param_01)) {
      return 0;
    }
  }

  if(maps\mp\agents\humanoid\_humanoid_melee::func_5753(param_01)) {
    return 0;
  }

  return 1;
}

func_457E(param_00) {
  if(!isDefined(self.var_60E0)) {
    self.var_60E0 = spawnStruct();
  }

  if(maps\mp\agents\humanoid\_humanoid_util::func_56DE(param_00) && !maps\mp\agents\humanoid\_humanoid_util::func_4B59()) {
    maps\mp\agents\humanoid\_humanoid_util::func_1E52();
  }

  var_01 = maps\mp\agents\humanoid\_humanoid_util::func_45DC(param_00);
  self.var_60E0.var_3771 = var_01;
  var_02 = maps\mp\agents\humanoid\_humanoid_util::func_4583(param_00, var_01);
  if(isDefined(var_02)) {
    self.var_60E0.var_A266 = 1;
    self.var_60E0.var_0116 = var_02;
  } else {
    self.var_60E0.var_A266 = 0;
    self.var_60E0.var_0116 = var_01;
    if(isDefined(self.var_3043)) {
      if(!isDefined(maps\mp\agents\humanoid\_humanoid_util::func_34AB(self.var_60E0.var_0116, 15, 55))) {
        if(!isDefined(self.var_7A40)) {
          self.var_7A40 = [];
          for(var_03 = 0; var_03 < maps\mp\agents\humanoid\_humanoid_util::func_45C6(); var_03++) {
            self.var_7A40[self.var_7A40.size] = var_03;
          }

          self.var_7A40 = common_scripts\utility::func_0F92(self.var_7A40);
        }

        foreach(var_05 in self.var_7A40) {
          var_06 = param_00 maps\mp\agents\humanoid\_humanoid_util::func_4582(self.var_60F5);
          var_07 = var_06[var_05];
          if(isDefined(var_07.var_0116)) {
            self.var_60E0.var_0116 = var_07.var_0116;
            break;
          }
        }
      }
    }
  }

  return self.var_60E0;
}

func_A909() {
  self notify("watchFavoriteEnemyDeath");
  self endon("watchFavoriteEnemyDeath");
  self endon("death");
  self endon("disconnect");
  self.var_0094 common_scripts\utility::func_A71A(5, "death", "disconnect");
  maps\mp\agents\humanoid\_humanoid_util::func_867E(undefined);
}

func_32B0(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  if(maps\mp\agents\_scripted_agent_anim_util::func_57E2()) {
    return;
  }

  if(maps\mp\agents\humanoid\_humanoid_util::func_56BC()) {
    return;
  }

  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "DoStopHitReaction");
  self.var_5381 = 1;
  var_07 = "pain_stand";
  if(isDefined(param_01) && param_01 == "head") {
    var_07 = "pain_stand_head";
  }

  if(isDefined(self.var_6CC4)) {
    var_07 = self.var_6CC4;
  }

  var_08 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_07);
  var_09 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_08);
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.var_001D);
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_08, var_09, self.var_672D, "pain_anim");
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "DoStopHitReaction");
  self.var_5381 = undefined;
  self scragentsetscripted(0);
}

func_45FB(param_00, param_01) {
  var_02 = lib_0547::func_4584(param_00, param_01);
  var_03 = var_02[0];
  var_04 = var_02[1];
  if(!isDefined(var_03)) {
    return undefined;
  }

  if(isDefined(var_04) && issubstr(var_04, "shovel")) {
    var_04 = "shovel_zm";
  }

  return level.var_6DF9[var_03][var_04];
}

func_8B9D(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isDefined(param_04) || param_04 != "MOD_MELEE") {
    return 0;
  }

  if(!isPlayer(param_01)) {
    return 0;
  }

  if(lib_0547::func_6720()) {
    return 0;
  }

  if(!lib_0547::func_4B2C()) {
    return 0;
  }

  if(isalive(param_01.var_6DFA) && param_01.var_6DFA != self) {
    return 0;
  }

  if(!self method_864D(param_01)) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid_util::func_56BC()) {
    return 0;
  }

  if(maps\mp\agents\_scripted_agent_anim_util::func_57E2()) {
    return 0;
  }

  if(param_02 >= self.var_00BC) {
    return 0;
  }

  var_0A = func_45FB(param_05, param_01);
  if(!isDefined(var_0A)) {
    return 0;
  }

  var_0B = self.var_0116 - param_01.var_0116;
  var_0C = anglesToForward(self.var_001D);
  if(vectordot(var_0B, var_0C) > 0.866) {
    return 0;
  }

  if(!isDefined(var_0A["hit_zombie_action"])) {
    return 0;
  }

  var_0D = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_0A["hit_zombie_action"], undefined, 1);
  if(!isDefined(var_0D)) {
    return 0;
  }

  return 1;
}

func_3298(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  self endon("death");
  var_0A = param_01;
  var_0A.var_6DFA = self;
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "DoMeleeHitReaction");
  self.var_5381 = 1;
  var_0B = 0.2;
  param_09 = param_09 - 1;
  if(param_09 < 0) {
    param_09 = 0;
  }

  var_0C = param_09 * 0.001;
  var_0C = var_0C - var_0B;
  var_0D = func_45FB(param_05, param_01);
  var_0E = var_0D["hit_zombie_action"];
  var_0F = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_0E);
  var_10 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_0F);
  var_11 = self method_83D8(var_0F, var_10);
  var_12 = getanimlength(var_11);
  var_13 = 1;
  var_14 = max(0, maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_11, "melee_hit", 0.1) * var_12 / var_13 - var_0C);
  var_15 = max(0, maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_11, "melee_stop_pairing", 0.2) * var_12 / var_13 - var_0C);
  self notify("helmet_pop", max(0, maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_11, "helmet_pop", 0.2) * var_12 / var_13 - var_0C));
  if(isDefined(var_0D["hit_zombie_snd"])) {
    var_16 = spawnStruct();
    var_16.var_721C = param_01;
    var_16.var_ABE6 = self.var_0116;
    var_16.var_4DCF = param_08;
    var_16.var_60B8 = param_04;
    var_16.var_01D0 = param_05;
    var_16.delaysec = var_14;
    lib_0378::func_8D74(var_0D["hit_zombie_snd"], var_16);
  }

  thread func_6DFD(var_0A, var_0D["hit_worldmodel_anim"], var_0C, var_14, var_15, var_0D);
  maps\mp\agents\_scripted_agent_anim_util::func_8415(var_0F, var_10, var_13, var_0C);
  var_17 = var_12 / var_13 - var_0C;
  var_18 = 0.2;
  var_19 = var_0D["hit_zombie_blend_duration"];
  if(isDefined(var_19)) {
    var_18 = var_19;
  }

  var_1A = var_17 - var_18;
  if(var_1A > 0) {
    wait(var_1A);
  }

  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "DoMeleeHitReaction");
  self.var_5381 = undefined;
  self scragentsetscripted(0);
  if(isDefined(var_0A)) {
    var_0A.var_6DFA = undefined;
  }
}

func_6DFD(param_00, param_01, param_02, param_03, param_04, param_05) {
  wait(0);
  var_06 = spawn("script_model", param_00.var_0116 + anglesToForward(param_00.var_001D) * 1);
  var_06 setModel(param_00.var_0106);
  var_06.var_001D = param_00.var_001D;
  var_06 method_805C();
  var_07 = undefined;
  var_06 scriptmodelplayanim(param_01, "actually play this anim please", max(0, param_02));
  var_08 = 0;
  var_09 = param_05["invalid_pair_distance"];
  if(isDefined(var_09)) {
    if(distance(self.var_0116, param_00.var_0116) > var_09) {
      lib_0542::set_zombie_too_far_for_pairing(param_00);
      var_08 = 1;
    }
  }

  if(!var_08) {
    self method_855A(param_03, param_03, var_06, "tag_sync", "tag_origin");
  } else {
    self.var_001D = (0, vectortoyaw(param_00.var_0116 - self.var_0116), 0);
  }

  var_0A = 0;
  while(var_0A < param_04) {
    var_0B = param_02 + var_0A;
    var_06 scriptmodelplayanim(param_01, "actually play this anim please", max(0, var_0B));
    wait 0.05;
    var_0A = var_0A + 0.05;
  }

  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.var_001D);
  var_06 delete();
}

func_60EA(param_00, param_01, param_02) {
  var_03 = (32, 0, 0);
  self endon("MeleeHitReactionAlignZombie_stop");
  var_04 = 0;
  while(var_04 < param_02) {
    var_05 = param_00 localtoworldcoords(var_03);
    var_06 = combineangles(param_00.var_001D, (0, 180, 0));
    var_07 = 1;
    var_08 = vectorlerp(self.var_0116, var_05, var_07);
    var_09 = angleslerp(self.var_001D, var_06, var_07);
    self setorigin(var_08, 0);
    self scragentsetorientmode("face angle abs", var_09);
    wait 0.05;
    var_04 = var_04 + 0.05;
  }
}

func_6ADB(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  self.var_99FC = gettime();
  self.var_99FB = param_09;
  if(isDefined(self.var_0117)) {
    self.var_29BC = vectornormalize(self.var_0116 - self.var_0117.var_0116);
  }

  if(func_8B9D(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09)) {
    thread func_3298(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
    return;
  }

  if(func_8B9F(param_02, param_05, param_04, param_08)) {
    thread func_32B0(maps\mp\agents\humanoid\_humanoid_util::func_29CB(param_06, param_07), param_08, param_05, param_04, param_02, param_00, param_01);
    return;
  }

  if(isDefined(self.var_0EAD.var_6ADB[self.var_0BA4])) {
    self[[self.var_0EAD.var_6ADB[self.var_0BA4]]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
    return;
  }
}

func_8B9F(param_00, param_01, param_02, param_03) {
  if(self.var_0A4B == "zombie_heavy" || self.var_0A4B == "zombie_fireman") {
    return 0;
  }

  if(lib_0547::func_6720()) {
    return 0;
  }

  if(isDefined(param_01) && param_01 == "trap_zm_mp" || param_01 == "zombie_water_trap_mp") {
    return 0;
  }

  if(maps\mp\agents\_scripted_agent_anim_util::func_57E2()) {
    return 0;
  }

  if(self.var_0BA4 == "traverse") {
    return 0;
  }

  if(isDefined(self.var_6CC4)) {
    return 1;
  }

  if(!lib_0547::func_4B2C()) {
    return 0;
  }

  if(isDefined(param_03) && param_03 == "head" && param_02 != "MOD_MELEE" && !isDefined(self.var_5BA7) || gettime() - self.var_5BA7 > 10000) {
    self.var_5BA7 = gettime();
    return 1;
  }

  if(!lib_054D::func_8B9C()) {
    return 0;
  }

  if(isDefined(param_01) && function_01AA(param_01) == "sniper") {
    return 1;
  }

  if(isDefined(param_02) && isexplosivedamagemod(param_02) && param_00 >= 10) {
    return 1;
  }

  if(isDefined(param_01) && param_01 == "concussion_grenade_mp") {
    return 1;
  }

  if(isDefined(self.var_8BA0) && [[self.var_8BA0]]()) {
    return 1;
  }

  return 0;
}

func_6394() {
  self endon("death");
  for(;;) {
    self waittill("flashbang", var_00, var_01, var_02, var_03, var_04, var_05);
    if(isDefined(var_03) && var_03 == self.var_0117) {
      continue;
    }

    if(!maps\mp\agents\_scripted_agent_anim_util::func_57E2()) {
      func_6B3B();
    }
  }
}

func_6B3B(param_00, param_01, param_02, param_03, param_04, param_05) {
  func_32B0(self.var_001D[1] + 180);
}