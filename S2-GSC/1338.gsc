/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1338.gsc
*********************************************/

lib_053A::func_00D5() {
  lib_0547::func_7BD0("stunning_burst", ::lib_053A::func_AC63, ::lib_053A::func_AC65, 4.25);
  lib_0547::func_7BD0("mini_stunning_burst", ::mini_stunning_burst_state_run, ::mini_stunning_burst_state_interrupt, 4.24999, ::mini_stunning_burst_state_finish);
  level.var_0611["stunning_burst_aoe"] = loadfx("vfx/zombie/abilities_perks\zmb_blood_stun_burst_aoe");
  level.var_0611["stunning_burst_aoe_mega"] = loadfx("vfx/zombie/abilities_perks\zmb_blood_breathing_room");
  level.var_0611["stunning_burst"] = loadfx("vfx/zombie/abilities_perks\zmb_blood_zmb_stun");
  level.var_0611["stunning_burst_sz"] = loadfx("vfx/zombie/abilities_perks\zmb_moon_zmb_stun");
  level.var_0611["stunning_burst_sustain"] = loadfx("vfx/zombie/abilities_perks\zmb_blood_sustain_zone");
  level.var_0611["stunning_burst_sustain_br"] = loadfx("vfx/zombie/abilities_perks\zmb_blood_sustain_zone_br");
  level.var_0611["zmb_blood_player_heal"] = loadfx("vfx/zombie/abilities_perks\zmb_blood_player_heal");
}

lib_053A::func_3662() {
  if(!common_scripts\utility::func_3798("stunning_burst_active")) {
    common_scripts\utility::func_3799("stunning_burst_active");
  }

  common_scripts\utility::func_379A("stunning_burst_active");
  maps\mp\zombies\_zombies_roles::func_6AB2("role_ability_stunning_burst_zm");
  var_00 = lib_0547::func_408F();
  var_01 = [];
  var_02 = self.var_0116;
  var_03 = 0;
  var_04 = 518400;
  if(common_scripts\utility::func_562E(lib_0547::func_4BA7("specialty_class_breathing_room_zm")) && !common_scripts\utility::func_562E(lib_0547::func_4BA7("specialty_class_sustain_zone_zm"))) {
    playFX(common_scripts\utility::func_44F5("stunning_burst_aoe_mega"), var_02 + (0, 0, var_03));
    lib_0378::func_8D74("aud_stunning_burst_use");
    var_04 = var_04 * 2.25;
  } else if(!common_scripts\utility::func_562E(lib_0547::func_4BA7("specialty_class_breathing_room_zm")) && common_scripts\utility::func_562E(lib_0547::func_4BA7("specialty_class_sustain_zone_zm"))) {
    playFX(common_scripts\utility::func_44F5("stunning_burst_aoe"), var_02 + (0, 0, var_03));
    lib_0378::func_8D74("aud_stunning_burst_use");
    thread sustain_zone_fx(level.var_0611["stunning_burst_sustain"], var_02 + (0, 0, var_03));
    var_04 = var_04 * 0.25;
  } else if(common_scripts\utility::func_562E(lib_0547::func_4BA7("specialty_class_breathing_room_zm")) && common_scripts\utility::func_562E(lib_0547::func_4BA7("specialty_class_sustain_zone_zm"))) {
    playFX(common_scripts\utility::func_44F5("stunning_burst_aoe_mega"), var_02 + (0, 0, var_03));
    lib_0378::func_8D74("aud_stunning_burst_use");
    thread sustain_zone_fx(level.var_0611["stunning_burst_sustain_br"], var_02 + (0, 0, var_03));
  } else {
    playFX(common_scripts\utility::func_44F5("stunning_burst_aoe"), var_02 + (0, 0, var_03));
    lib_0378::func_8D74("aud_stunning_burst_use");
  }

  foreach(var_06 in var_00) {
    if(distancesquared(self.var_0116, var_06.var_0116) < var_04) {
      var_01[var_01.size] = var_06;
    }
  }

  var_01 = function_01AC(var_01, var_02);
  var_08 = 0;
  if(isDefined(level.zmb_events_player_zombie_shellshock_stun)) {
    self thread[[level.zmb_events_player_zombie_shellshock_stun]](var_01.size);
  }

  foreach(var_06 in var_01) {
    thread lib_053A::func_94C0(var_06, var_02, var_08);
    var_08 = var_08 + 0.05;
  }

  var_0B = [];
  foreach(var_0D in level.var_744A) {
    if(var_0D != self && maps\mp\_utility::func_57A0(var_0D)) {
      var_0B[var_0B.size] = var_0D;
    }
  }

  foreach(var_10 in var_0B) {
    if(distancesquared(self.var_0116, var_10.var_0116) < var_04 && abs(self.var_0116[2] - var_10.var_0116[2]) < 90) {
      thread lib_053A::func_0A31(var_10);
    }
  }

  if(lib_0547::func_4BA7("specialty_class_sustain_zone_zm")) {
    thread lib_053A::func_9529(var_04);
  }
}

sustain_zone_fx(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("DisabledRoleAbility");
  for(;;) {
    playFX(param_00, param_01);
    wait(1);
  }
}

lib_053A::func_2F9E() {
  if(common_scripts\utility::func_3798("stunning_burst_active")) {
    common_scripts\utility::func_3796("stunning_burst_active");
  }
}

lib_053A::func_0A31(param_00) {
  if(lib_0547::func_4BA7("specialty_class_on_your_feet_zm")) {
    if(isPlayer(param_00) && lib_0547::func_577E(param_00)) {
      param_00 lib_0553::func_53E2(self);
      playFX(level.var_0611["zmb_blood_player_heal"], param_00.var_0116, anglesToForward(param_00.var_001D));
      param_00 luinotifyeventextraplayer(&"add_teammate_mod_buffs", 3, "specialty_class_on_your_feet_zm", 1, self);
    }
  }

  if(lib_0547::func_4BA7("specialty_class_bolster_morale_zm")) {
    if(isPlayer(param_00) && param_00 lib_0547::func_73E9() < param_00 lib_0547::playergetmaxarmorcount()) {
      param_00 lib_0547::func_73AC(1);
      param_00 luinotifyeventextraplayer(&"add_teammate_mod_buffs", 3, "specialty_class_bolster_morale_zm", 1, self);
    }
  }
}

lib_053A::func_94C0(param_00, param_01, param_02) {
  if(!isDefined(param_00.var_94B4)) {
    param_00.var_94B4 = [];
  }

  param_00.var_94B4[param_00.var_94B4.size] = self;
  var_03 = param_00 common_scripts\utility::func_A74D("death", param_02);
  if(!isDefined(var_03) || isDefined(var_03) && var_03 != "timeout") {
    return;
  }

  param_00.var_94B4 = common_scripts\utility::func_0F93(param_00.var_94B4, self);
  var_04 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), level.var_A980);
  param_00 dodamage(var_04 * 0.125, param_01, self, self, "MOD_ENERGY", "dot_generic_zm");
  if(!isalive(param_00)) {
    return;
  }

  param_00 lib_053A::func_AC56(self, 1);
  param_00.stunnedbybursttime = gettime();
  var_05 = "stunning_burst";
  param_00 thread play_shock_fx(var_05, "J_Spine4", self, 0.35);
  param_00 lib_0378::func_8D74("aud_stun_zombies_strt");
  param_00 notify("is_tower_battle_distracted");
  if(lib_0547::func_4BA7("specialty_class_fiery_burst_zm")) {
    param_00 setonfire(0.03 * var_04, 1.5, 20, "none", 1, self, "dot_generic_zm");
  }

  param_00 thread lib_0547::func_7D1A("stunning_burst", [param_01, self], undefined, [self, "stunning_burst_active", self, "disconnect", self, "death"]);
  common_scripts\utility::func_A70C(self, "stunning_burst_active", param_00, "death");
  param_00 lib_0378::func_8D74("aud_stun_zombies_end");
  param_00 lib_053A::func_AC56(self, 0);
}

play_shock_fx(param_00, param_01, param_02, param_03) {
  self notify("play_shock_fx");
  param_02 endon("stunning_burst_active");
  param_02 endon("disconnect");
  self endon("death");
  self endon("play_shock_fx");
  for(;;) {
    var_04 = gettime() / 1000;
    if(isDefined(self.recentshockfxtime) && var_04 - self.recentshockfxtime < param_03) {
      wait(param_03 - var_04 - self.recentshockfxtime);
    }

    playFXOnTag(common_scripts\utility::func_44F5(param_00), self, param_01);
    self.recentshockfxtime = var_04;
    wait(param_03);
  }
}

lib_053A::func_AC56(param_00, param_01, param_02) {
  if(!isDefined(self.var_94BD)) {
    self.var_94BD = [];
  }

  if(common_scripts\utility::func_562E(param_01)) {
    self.var_94BD = common_scripts\utility::func_0F6F(self.var_94BD, param_00);
    if(self.var_94BD.size == 1) {
      self notify("stun_burst");
      return;
    }

    return;
  }

  self.var_94BD = common_scripts\utility::func_0F93(self.var_94BD, param_00);
  if(self.var_94BD.size == 0) {
    self notify("stun_burst_expired");
  }
}

lib_053A::func_AC2A() {
  var_00 = self;
  if(isDefined(var_00.var_94BD) && var_00.var_94BD.size > 0) {
    return 1;
  }

  if(var_00 mini_stunning_burst_affected()) {
    return 1;
  }

  return 0;
}

lib_053A::func_AC2B(param_00) {
  return isDefined(self.var_94BD) && common_scripts\utility::func_0F79(self.var_94BD, param_00);
}

zombiecanbestunknockedback() {
  if(maps\mp\agents\humanoid\_humanoid_util::func_56BC()) {
    return 0;
  }

  if(isDefined(self.stunnedbybursttime) && gettime() > self.stunnedbybursttime + 1000) {
    return 0;
  }

  return 1;
}

zombiestunknockbackanim(param_00, param_01) {
  var_02 = undefined;
  self.var_561D = 1;
  var_03 = maps\mp\agents\humanoid\_humanoid_util::func_29CB(param_00);
  var_04 = angleclamp180(var_03 - self.var_001D[1]);
  if(abs(var_04) < 45) {
    var_02 = "pain_knockback_front";
  } else if(abs(var_04) > 135) {
    var_02 = "pain_knockback_back";
  } else if(var_04 > 0) {
    var_02 = "pain_knockback_right";
  } else {
    var_02 = "pain_knockback_left";
  }

  var_05 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_02);
  var_06 = self method_83DB(var_05);
  var_07 = randomint(var_06);
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", self.var_001D);
  if(isPlayer(param_01) && param_01 lib_0547::func_4BA7("specialty_class_breathing_room_zm")) {
    self method_839A(2, 1);
  }

  if(self.var_0A4B == "zombie_fireman") {
    var_05 = maps\mp\agents\_scripted_agent_anim_util::func_434D("scripted_fire_stun_burst");
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_05, randomint(2), 1, "stun_anim");
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_05, 2, 1, "stun_anim");
    self method_839A(1, 1);
    return;
  }

  if(self.var_0A4B == "zombie_assassin") {
    var_05 = maps\mp\agents\_scripted_agent_anim_util::func_434D("scripted_asn_stun_burst");
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_05, 0, 1, "stun_anim");
    self.assassinmuststopattackingandleave = 1;
    return;
  }

  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_05, var_07, 1, "stun_anim");
  self method_839A(1, 1);
}

zombiecanbestunheld() {
  if(common_scripts\utility::func_0F79(["zombie_fireman", "zombie_assassin"], self.var_0A4B)) {
    return 0;
  }

  return 1;
}

lib_053A::func_AC63(param_00, param_01, param_02) {
  if(common_scripts\utility::func_562E(self.var_57E8)) {
    return;
  }

  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "stunning_burst");
  if(!common_scripts\utility::func_562E(param_02) && zombiecanbestunknockedback()) {
    zombiestunknockbackanim(param_00, param_01);
  }

  if(zombiecanbestunheld()) {
    lib_053A::func_AC62(param_01);
  }

  lib_053A::func_AC64();
}

lib_053A::func_AC62(param_00) {
  if(isPlayer(param_00) && !param_00 common_scripts\utility::func_3794("stunning_burst_active")) {
    return;
  }

  param_00 endon("stunning_burst_active");
  var_01 = undefined;
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D("stun_hold");
  var_03 = self method_83DB(var_02);
  for(;;) {
    if(self.var_0A4B == "zombie_exploder") {
      if(common_scripts\utility::func_562E(self.var_392C)) {
        var_01 = 0;
      } else {
        var_01 = 1;
      }
    }

    if(isDefined(var_01)) {
      var_04 = var_01;
    } else {
      var_04 = randomint(var_03);
    }

    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.var_001D);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_04, 1, "stun_anim");
  }
}

lib_053A::func_AC64() {
  self.var_561D = 0;
  self notify("stunning_burst_end");
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "stunning_burst");
}

lib_053A::func_AC65(param_00, param_01, param_02) {
  lib_053A::func_AC64();
  thread zombiestunstaterestart(param_00, param_01);
}

zombiestunstaterestart(param_00, param_01) {
  self endon("death");
  param_01 endon("disconnect");
  param_01 endon("death");
  param_01 endon("stunning_burst_active");
  thread lib_0547::func_7D1A("stunning_burst", [param_00, param_01, 1], undefined, [param_01, "stunning_burst_active", param_01, "disconnect", param_01, "death"]);
}

lib_053A::func_62A6(param_00) {
  var_01 = 1;
  if(lib_053A::func_AC2A() && isDefined(self.var_94BD)) {
    foreach(var_03 in self.var_94BD) {
      var_04 = 1;
      if(isPlayer(var_03) && var_03 lib_0547::func_4BA7("specialty_class_exploit_weakness_zm") && !common_scripts\utility::func_562E(self.shortstun)) {
        var_04 = 3;
      }

      if(var_04 > var_01) {
        var_01 = var_04;
      }
    }
  }

  param_00 = param_00 * var_01;
  return param_00;
}

lib_053A::func_9529(param_00) {
  var_01 = self getEye();
  var_02 = self getorigin();
  if(lib_0547::func_4BA7("specialty_class_breathing_room_zm")) {
    var_03 = "stunning_burst_sustain_br";
  } else {
    var_03 = "stunning_burst_sustain";
  }

  var_04 = spawnfx(common_scripts\utility::func_44F5(var_03), var_02);
  triggerfx(var_04);
  thread lib_053A::func_952A(var_01, param_00);
  common_scripts\utility::func_A70C(self, "disconnect", self, "stunning_burst_active");
  var_04 delete();
  self notify("sustain_zone_complete");
}

lib_053A::func_4B9B(param_00) {
  return isDefined(param_00.var_94B4) && common_scripts\utility::func_0F79(param_00.var_94B4, self);
}

lib_053A::func_952A(param_00, param_01) {
  self endon("sustain_zone_complete");
  for(;;) {
    var_02 = lib_0547::func_408F();
    var_03 = 0;
    foreach(var_05 in var_02) {
      if(isalive(var_05) && !lib_053A::func_4B9B(var_05) && !var_05 lib_053A::func_AC2B(self)) {
        if(distancesquared(param_00, var_05.var_0116) < param_01) {
          thread lib_053A::func_94C0(var_05, param_00, var_03);
          var_03 = var_03 + 0.05;
        }
      }
    }

    wait(0.3);
  }
}

mini_stunning_burst_execute(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!isDefined(param_02)) {
    param_02 = 480;
  }

  if(!isDefined(param_03)) {
    param_03 = 5;
  }

  if(!isDefined(param_04)) {
    param_04 = 4;
  }

  var_08 = lib_0547::func_408F();
  var_09 = function_01AC(lib_0547::func_408F(), param_00, param_02);
  var_0A = 0;
  foreach(var_0C in var_09) {
    if(isDefined(param_05) && var_0C == param_05) {
      continue;
    }

    if(lib_0547::func_5565(var_0C.var_0A4B, param_06)) {
      continue;
    }

    var_0D = spawnStruct();
    var_0D.var_0116 = param_00;
    var_0D.var_1180 = param_01;
    var_0D.durationsecs = param_03;
    level thread mini_stunning_burst_stun_zombie(var_0C, var_0D, param_04, param_07, var_0A);
    var_0A = var_0A + 0.05;
  }
}

mini_stunning_burst_stun_zombie(param_00, param_01, param_02, param_03, param_04) {
  param_00 endon("death");
  wait(param_04);
  if(isDefined(param_03)) {
    param_00 thread[[param_03]]();
  }

  var_05 = 0.125 * maps\mp\gametypes\zombies::func_1E59();
  var_06 = param_01.var_0116;
  var_07 = param_01.var_1180;
  param_00 dodamage(var_05, var_06, var_07, var_07, "MOD_ENERGY", "dot_generic_zm");
  if(common_scripts\utility::func_562E(param_00.var_57E8)) {
    return;
  }

  param_00 thread lib_0547::func_7D1A("mini_stunning_burst", [param_01], param_02);
}

mini_stunning_burst_state_run_manage_fx() {
  var_00 = self;
  var_00 endon("death");
  var_00 endon("flag_mini_burst");
  var_01 = common_scripts\utility::func_44F5("stunning_burst");
  for(;;) {
    playFXOnTag(var_01, var_00, "J_Spine4");
    wait(0.35);
  }
}

mini_stunning_burst_state_run_manage_aud() {
  var_00 = self;
  var_00 lib_0378::func_8D74("aud_stun_zombies_strt");
  var_00 common_scripts\utility::func_A732("flag_mini_burst", "death");
  var_00 lib_0378::func_8D74("aud_stun_zombies_end");
}

mini_stunning_burst_state_run_hold(param_00) {
  var_01 = self;
  var_02 = var_01 maps\mp\agents\_scripted_agent_anim_util::func_434D("stun_hold");
  if(!isDefined(var_02)) {
    return;
  }

  var_03 = var_01 method_83DB(var_02);
  var_04 = gettime();
  for(;;) {
    var_05 = gettime() - var_04 / 1000;
    if(var_05 > param_00) {
      break;
    }

    var_06 = randomint(var_03);
    if(var_01.var_0A4B == "zombie_exploder") {
      var_06 = common_scripts\utility::func_98E7(common_scripts\utility::func_562E(var_01.var_392C), 0, 1);
    }

    var_01 method_839C("anim deltas");
    var_01 scragentsetorientmode("face angle abs", var_01.var_001D);
    var_01 maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_06, 1, "stun_anim");
  }
}

mini_stunning_burst_state_run(param_00) {
  var_01 = self;
  var_01 scragentsetscripted(1);
  var_01 maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "mini_stunning_burst");
  var_02 = param_00.var_0116;
  var_03 = param_00.var_1180;
  var_04 = param_00.durationsecs;
  if(!var_01 common_scripts\utility::func_3798("flag_mini_burst")) {
    var_01 common_scripts\utility::func_3799("flag_mini_burst");
  }

  var_01 common_scripts\utility::func_379A("flag_mini_burst");
  var_01 thread mini_stunning_burst_state_run_manage_fx();
  var_01 thread mini_stunning_burst_state_run_manage_aud();
  if(var_01 zombiecanbestunknockedback()) {
    var_01 zombiestunknockbackanim(var_02, var_03);
  }

  if(var_01 zombiecanbestunheld()) {
    var_01 mini_stunning_burst_state_run_hold(var_04);
  }
}

mini_stunning_burst_state_interrupt(param_00) {}

mini_stunning_burst_state_finish(param_00) {
  var_01 = self;
  var_01.var_561D = 0;
  var_01 common_scripts\utility::func_3796("flag_mini_burst");
  var_01 scragentsetscripted(0);
  var_01 maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "mini_stunning_burst");
}

mini_stunning_burst_affected() {
  var_00 = self;
  var_01 = var_00 common_scripts\utility::func_3798("flag_mini_burst") && var_00 common_scripts\utility::func_3794("flag_mini_burst");
  return var_01;
}