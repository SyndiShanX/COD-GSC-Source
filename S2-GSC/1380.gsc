/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1380.gsc
*********************************************/

lib_0564::func_00D5() {
  level.var_0A41["zombie_fireman"] = level.var_0A41["zombie"];
  level.var_0A41["zombie_fireman"]["think"] = ::lib_0564::func_ABAB;
  level.var_0A41["zombie_fireman"]["move_mode"] = ::lib_0564::func_ABA7;
  level.var_0A41["zombie_fireman"]["on_damaged"] = ::lib_0564::func_ABA8;
  level.var_0A41["zombie_fireman"]["on_killed"] = ::lib_0564::func_ABA9;
  level.var_0A41["zombie_fireman"]["ragdoll_overrides"] = ::lib_0564::func_ABAA;
  level.var_0A41["zombie_fireman"]["is_hit_weak_point"] = ::lib_0564::func_ABA6;
  level.var_0A41["zombie_fireman"]["tesla_delayed_dmg"] = ::zombie_fireman_tesla_delayed_dmg;
  var_00 = spawnStruct();
  var_00.var_0A4B = "zombie_fireman";
  var_00.var_0EAE = "zombie_animclass";
  var_00.var_0879 = "zombie_generic";
  var_00.var_5ED2["default look"]["whole_body"] = "zom_fireman_body";
  var_00.var_5ED2["default look"]["heads"] = ["zom_fireman_head"];
  var_00.var_4C12 = 20;
  var_00.var_4C07 = 175000;
  var_00.var_60E2 = 90;
  var_00.var_2F9B = 1;
  var_00.var_907C = "zombie_fireman";
  var_00.var_8302 = 80;
  var_00.var_8303 = 25;
  var_00.parenttype = "zombie_generic";
  var_00.suppressive_fire_speed_multiplier = 0.3;
  lib_0547::func_0A52(var_00, "zombie_fireman");
  level.var_9E16["zombie_fireman"] = ::lib_0564::func_9E17;
  level.var_7A5D["zombie_fireman"] = ::lib_0564::func_3C08;
  lib_0547::func_7BD0("fireman_do_flame", ::lib_0564::func_3BF1, ::lib_0564::func_3D2B, -1);
  level.var_0611["zombie_fireman_flamethrower"] = loadfx("vfx/fire/flamethrower_end_med");
  level.var_0611["zombie_fireman_flamethrower_expensive"] = loadfx("vfx/test/flamethrower_test");
  level.var_0611["zmb_zmb_fire_torso"] = loadfx("vfx/zombie/zmb_zmb_fire_torso");
  level.var_0611["zmb_ground_impact_lrg"] = loadfx("vfx/zombie/zmb_ground_impact_lrg");
  level.var_0611["gasTankExplosion"] = loadfx("vfx/explosion/molotov_cocktail_impact");
  level.var_0611["fireman_sparks"] = loadfx("vfx/weaponimpact/zmb_fireman_metal_impact_1");
  level.var_0611["fireman_explosion"] = loadfx("vfx/explosion/zmb_fireman_explosion");
  level.var_0611["fireman_leak"] = loadfx("vfx/smoke/zmb_fireman_leak");
}

lib_0564::func_3BFB(param_00) {
  if(!isDefined(level.var_3C00)) {
    level.var_3C00 = 1;
  }

  level.var_3BFF = 0;
  level.var_3BFE = 0;
  level.var_66A6 = randomintrange(14, 15);
  level.var_3BED = 0;
  if(!isDefined(level.var_3BF2)) {
    if(isDefined(param_00)) {
      level.var_3BF2 = param_00;
    } else {
      level.var_3BF2 = 0;
    }
  }

  thread lib_0564::func_3C10();
}

lib_0564::func_ABA7() {
  self.var_64C2 = 1 * lib_054D::func_4440();
  if(isDefined(self.var_28D2)) {
    var_00 = isDefined(self.var_5B88) && gettime() - self.var_5B88 > 5000;
    if(var_00) {
      return "sprint";
    }

    return "run";
  }

  var_01 = lib_053C::func_4F88();
  var_02 = undefined;
  if(isDefined(var_01) && var_01.size > 0) {
    var_02 = distancesquared(var_01[0].var_0116, self.var_0116);
  }

  if(isDefined(var_02) && var_02 > -15536) {
    return "run";
  }

  return "walk";
}

lib_0564::func_8A1B() {
  self method_85A1("zombie_fireman");
  self method_839E("agent");
  self.var_11AB = 70 + self.var_014F;
  self.var_60F5 = "large";
  self.var_60F6 = 200;
  self.var_64C2 = 1;
  self.var_672D = 1;
  self.var_9D0D = 1;
  self.var_4013 = 1;
  lib_0547::func_86C8(100);
  lib_0547::func_86C7(self.var_60F0);
  self method_8399(self.var_2BCA);
  self.var_60E4 = 0.25;
  self.var_3CFA = 3;
  self.var_0EAD.var_6AFE["melee"] = ::lib_0564::func_3BFD;
  self.var_01B5 = 1;
  self.var_3CF9 = 1;
  self.var_3CFB = 0;
  var_00 = 0.08722223;
  self method_85E0(1);
  self method_85DE(var_00);
  self.var_2FA4 = 1;
  self.var_3FF1 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_fireman"), level.var_A980) / 3;
  self.var_3FF2 = self.var_3FF1;
  self.var_3FEE = 0;
}

lib_0564::func_ABAB() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  lib_0566::func_ABB5();
  lib_0564::func_8A1B();
  thread lib_0564::func_A112();
  thread lib_0564::func_A113();
  self.var_6816 = 1;
  self.var_55AB = 1;
  self.var_562B = 1;
  self.var_5569 = 1;
  self.var_66EC = 1;
  self.is_flamethrower_immune = 1;
  var_00 = 0.2;
  for(;;) {
    wait(var_00);
    if(!common_scripts\utility::func_562E(self.var_5580) && !common_scripts\utility::func_562E(self.var_5748)) {
      if(lib_053C::func_4F8C()) {
        continue;
      }
    }

    if(common_scripts\utility::func_562E(self.var_5580)) {
      continue;
    }

    if(common_scripts\utility::func_562E(self.var_5748)) {
      continue;
    }

    if(!lib_0547::func_4B2C()) {
      lib_053C::func_4F9A();
      continue;
    }

    if(lib_0564::func_3BEE()) {
      if(lib_0564::func_3BEF()) {
        thread lib_0547::func_7D1A("fireman_do_flame", undefined, var_00);
        continue;
      }

      if(lib_0564::func_3BF0()) {
        if(!isDefined(self.var_5BC1) || distancesquared(self.var_5BC1, self.var_0116) > 256) {
          self.var_60ED = self.var_0108;
        }

        self method_83A1(self.var_28D2);
        continue;
      }
    }

    if(lib_053C::func_4F9B(1)) {
      continue;
    }

    if(lib_053C::func_4F9A()) {
      continue;
    }

    lib_053C::func_0647();
  }
}

lib_0564::func_3BEE() {
  if(self.var_00CA) {
    return 0;
  }

  if(!isDefined(self.var_28D2)) {
    return 0;
  }

  if(self.var_0BA4 == "melee" || maps\mp\agents\_scripted_agent_anim_util::func_57E2()) {
    return 0;
  }

  if(!lib_0547::func_4B2C()) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid::func_A7F8()) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid::func_2EE6()) {
    return 0;
  }

  return 1;
}

lib_0564::func_3BEF() {
  if(!lib_0564::func_3C0F("flame")) {
    return 0;
  }

  var_00 = isDefined(self.var_3CFB) && gettime() - self.var_3CFB <= self.var_3CFA * 1000;
  if(!self.var_3CF9 || var_00) {
    return 0;
  }

  if(self.var_3FEE == 1) {
    return 0;
  }

  return 1;
}

lib_0564::func_3BF0() {
  if(!lib_0564::func_3C0F("melee")) {
    return 0;
  }

  if(isDefined(self.var_60E4) && isDefined(self.var_5BC0)) {
    var_00 = gettime() - self.var_5BC0;
    if(var_00 < self.var_60E4 * 1000) {
      return 0;
    }
  }

  return 1;
}

lib_0564::func_3C0F(param_00) {
  if(!isDefined(self.var_28D2)) {
    return 0;
  }

  if(!maps\mp\_utility::func_57A0(self.var_28D2)) {
    return 0;
  }

  if(self.var_0BA4 == "traverse") {
    return 0;
  }

  if(!maps\mp\agents\humanoid\_humanoid_util::func_56DD(self.var_28D2)) {
    if(!maps\mp\agents\humanoid\_humanoid::func_5859(self.var_28D2.var_0116)) {
      return 0;
    }

    if(param_00 == "flame" && !lib_0564::func_AA4F()) {
      return 0;
    } else if(param_00 == "melee" && !lib_0564::func_AA53()) {
      return 0;
    }
  }

  if(maps\mp\agents\humanoid\_humanoid_melee::func_5753()) {
    return 0;
  }

  return 1;
}

lib_0564::func_AA4F() {
  return distancesquared(self.var_0116, self.var_28D2.var_0116) <= squared(250);
}

lib_0564::func_AA53() {
  return distancesquared(self.var_0116, self.var_28D2.var_0116) <= squared(self.var_60F0);
}

lib_0564::func_56EE() {
  var_00 = self.var_0116 + (0, 0, self.var_60E1);
  var_01 = self.var_28D2.var_0116 + (0, 0, self.var_60E1);
  var_02 = physicstrace(var_00, var_01);
  return distancesquared(var_02, var_01) > 1;
}

lib_0564::func_3BF1() {
  self endon("death");
  self endon("flame_interrupt");
  if(!isDefined(self.var_28D2)) {
    return;
  }

  self.var_28D2 endon("disconnect");
  var_00 = maps\mp\agents\humanoid\_humanoid::func_457E(self.var_28D2);
  if(lib_0564::func_56EE()) {
    return maps\mp\agents\humanoid\_humanoid_melee::func_60E7();
  }

  var_01 = 0;
  var_02 = undefined;
  if(var_00.var_A266 && self.var_3CF9) {
    var_03 = maps\mp\agents\humanoid\_humanoid_util::func_1F51(self.var_0116, var_00.var_0116);
    if(var_03) {
      var_01 = 1;
      var_02 = var_00.var_0116;
    } else {
      var_04 = bullettracepassed(self.var_0116 + (0, 0, 32), self.var_28D2.var_0116 + (0, 0, 32), 0, undefined);
      if(var_04) {
        var_01 = 1;
        var_02 = self.var_0116;
      }
    }
  }

  if(!var_02) {
    return;
  }

  self.var_3CFB = gettime();
  lib_0564::func_3C01(self.var_28D2, var_03);
}

lib_0564::func_3BFD() {
  self endon("death");
  self endon("killanimscript");
  self.var_28D2 endon("disconnect");
  var_00 = maps\mp\agents\humanoid\_humanoid::func_457E(self.var_28D2);
  if(maps\mp\agents\humanoid\_humanoid_melee::func_5753()) {
    return maps\mp\agents\humanoid\_humanoid_melee::func_60E7();
  }

  if(var_00.var_A266 && !lib_0564::func_AA53()) {
    maps\mp\agents\humanoid\_humanoid_melee::func_60E7();
    return;
  }

  lib_0564::func_3C02(self.var_28D2, var_00.var_0116);
}

lib_0564::func_3C02(param_00, param_01) {
  self endon("death");
  var_02 = "attack_stand";
  var_03 = 0;
  if(isDefined(self.var_60ED)) {
    var_02 = "attack_" + self.var_60ED;
    var_03 = 1;
    self.var_60ED = undefined;
  }

  var_04 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_02);
  var_05 = 0;
  var_06 = 1;
  self.var_5BBE = undefined;
  self.var_5BBF = undefined;
  var_07 = randomint(self method_83DB(var_04));
  var_08 = self method_83D8(var_04, var_07);
  var_09 = getanimlength(var_08);
  var_0A = getnotetracktimes(var_08, "attack");
  var_0B = getnotetracktimes(var_08, "end");
  var_0A = common_scripts\utility::func_0F73(var_0A, var_0B);
  var_0C = lib_0564::func_4511(var_09, var_06, var_0A, undefined);
  self method_839D("gravity");
  if(var_03) {
    self scragentsetorientmode("face enemy");
  } else {
    self scragentsetorientmode("face angle abs", (0, vectortoyaw(param_00.var_0116 - self.var_0116), 0));
  }

  self method_839C("anim deltas");
  maps\mp\agents\_scripted_agent_anim_util::func_8415(var_04, var_07, var_06);
  thread lib_0564::func_3C0E(var_04, var_09);
  var_0D = undefined;
  self method_839A(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "DoAttack");
  childthread lib_0564::func_A137(param_00, var_08, var_09, var_06, var_0A);
  wait(var_0C);
  self notify("cancel_updatelerppos");
  self method_839C("anim deltas");
  self method_839A(1, 1);
  self.var_5BC1 = self.var_0116;
  var_0E = var_09 / var_06 - var_0C;
  if(var_0E > 0) {
    maps\mp\agents\_scripted_agent_anim_util::func_A79F("attack_anim", "end", var_0E);
  }

  self notify("cancel_updatelerppos");
  self method_839C("anim deltas");
  self method_839A(1, 1);
}

lib_0564::func_3C01(param_00, param_01) {
  self.var_5580 = 1;
  self scragentsetscripted(1);
  self endon("killanimscript");
  self endon("death");
  var_02 = common_scripts\utility::func_7A33(["s2_fireman_attack_flamethrower_stand", "s2_fireman_attack_flamethrower_walk"]);
  var_03 = 1;
  var_04 = 1;
  self.var_5BBE = undefined;
  self.var_5BBF = undefined;
  var_05 = randomint(self method_83DB(var_02));
  var_06 = self method_83D8(var_02, var_05);
  var_07 = getanimlength(var_06);
  self method_839D("gravity");
  if(var_03) {
    self scragentsetorientmode("face enemy");
  } else {
    self scragentsetorientmode("face angle abs", (0, vectortoyaw(param_00.var_0116 - self.var_0116), 0));
  }

  self method_839C("anim deltas");
  maps\mp\agents\_scripted_agent_anim_util::func_8415(var_02, var_05, var_04);
  lib_0564::func_3D2A();
}

lib_0564::func_3C0E(param_00, param_01) {
  maps\mp\_utility::func_A6D1(param_01, "killanimscript");
  self.var_5BC0 = gettime();
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "DoAttack");
}

lib_0564::func_4511(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02) || param_02.size == 0) {
    return param_03;
  }

  var_04 = param_00 / param_01 * param_02[0];
  if(isDefined(param_03) && param_03 < var_04) {
    return param_03;
  }

  return var_04;
}

lib_0564::func_A136(param_00, param_01, param_02, param_03) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  param_00 endon("disconnect");
  param_00 endon("death");
  var_04 = self.var_0116;
  var_05 = param_01;
  var_06 = 0.05;
  for(;;) {
    wait(var_06);
    var_05 = var_05 - var_06;
    if(var_05 <= 0) {
      break;
    }

    var_07 = maps\mp\agents\humanoid\_humanoid_melee::func_4707(param_00, param_02);
    if(!isDefined(var_07)) {
      break;
    }

    if(isDefined(param_03)) {
      var_08 = param_03;
      var_09 = var_07 - var_04;
      if(lengthsquared(var_09) > var_08 * var_08) {
        var_07 = var_04 + vectornormalize(var_09) * var_08;
      }
    }

    self scragentsetorientmode("face enemy");
    self method_83A4(self.var_0116, var_07, var_05);
  }
}

lib_0564::func_3D2A() {
  self endon("death");
  self method_839A(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "DoFiremanFlameAttack");
  lib_0378::func_8D74("flamethrower_start", "tag_flamethrower_fx");
  thread lib_0564::func_3D29();
  var_00 = gettime();
  self.var_7ACF = 0;
  while(gettime() - var_00 < 2000) {
    var_01 = common_scripts\utility::func_0F73(lib_0547::func_408F(), level.var_744A);
    foreach(var_09 in var_01) {
      wait 0.05;
      if(!isalive(self) || !isalive(var_09)) {
        continue;
      }

      if(lib_0564::func_5625(var_09)) {
        if(var_09.var_01A7 == self.var_01A7) {
          if(var_09.var_0A4B != "zombie_fireman") {
            var_09 setonfire(0, 10, 1, "none", 1);
            var_09 dodamage(5, var_09 getEye(), undefined, undefined, "MOD_ENERGY");
            var_0A = 10;
            var_09 lib_0378::func_8D74("zombie_ignite", var_0A);
          }

          continue;
        }

        var_0B = 1;
        if(should_longburn(var_09)) {
          var_0B = 5;
        }

        if(var_0B == 1) {
          do_fireman_player_unit_damage(var_09);
        } else {
          thread prolonged_damage(var_09, var_0B);
        }
      }
    }

    wait 0.05;
  }

  thread lib_0564::func_3D31();
}

should_longburn(param_00) {
  return (common_scripts\utility::func_562E(self.isuberfireman) || common_scripts\utility::func_562E(self.isfireassassin)) && !common_scripts\utility::func_562E(param_00.islongburning);
}

do_fireman_player_unit_damage(param_00) {
  param_00 dodamage(15, param_00 getEye(), self, undefined, "MOD_ENERGY");
  if(!isDefined(self.var_7ACF)) {
    self.var_7ACF = 0;
  }

  self.var_7ACF = self.var_7ACF + 15;
}

prolonged_damage(param_00, param_01) {
  self endon("death");
  param_00 endon("disconnect");
  param_00.islongburning = 1;
  for(var_02 = 0; var_02 < param_01; var_02++) {
    do_fireman_player_unit_damage(param_00);
    wait(0.7);
  }

  param_00.islongburning = 0;
}

lib_0564::func_3D29() {
  var_00 = spawn("script_model", self gettagorigin("tag_flamethrower_fx") + (600, 0, 0));
  var_00 setModel("tag_origin");
  var_00 linkto(self, "tag_flamethrower_fx");
  var_01 = launchbeam("zmb_brenner_flamethrower_beam", self, "tag_flamethrower_fx", var_00, "tag_origin");
  self waittill("cancel_updatelerppos");
  var_01 delete();
  var_00 delete();
}

lib_0564::func_3D31() {
  self endon("death");
  self.var_5580 = 0;
  self.var_3CFB = gettime();
  self scragentsetscripted(0);
  self notify("cancel_updatelerppos");
  self method_839C("anim deltas");
  self method_839A(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "DoFiremanFlameAttack");
  self.var_5BC1 = self.var_0116;
  self.var_5B9B = self.var_0116;
  self.var_3CF9 = 0;
  lib_0378::func_8D74("flamethrower_stop", "tag_flamethrower_fx");
}

lib_0564::func_3D2B() {
  lib_0564::func_3D31();
}

lib_0564::func_5625(param_00) {
  var_01 = 250;
  var_02 = squared(var_01 + 100);
  var_03 = squared(50);
  var_04 = self getEye();
  var_05 = self getangles();
  var_06 = anglesToForward(var_05);
  var_07 = var_04 + var_06 * 50;
  var_08 = var_07 + var_06 * var_01;
  if(distance2dsquared(self.var_0116, param_00.var_0116) > var_02) {
    return 0;
  }

  var_09 = param_00.var_0116 - var_04 * (1, 1, 0);
  if(vectordot(var_09, var_06 * (1, 1, 0)) < 0.866) {
    return 0;
  }

  var_0A = lib_0564::func_7540(param_00 getEye(), var_07, var_08);
  var_0B = lib_0564::func_7540(param_00 gettagorigin("J_Spine4"), var_07, var_08);
  var_0C = min(var_0A, var_0B);
  if(var_0C > var_03) {
    return 0;
  }

  return 1;
}

lib_0564::func_7540(param_00, param_01, param_02) {
  var_03 = lengthsquared(param_02 - param_01);
  if(var_03 == 0) {
    return lengthsquared(param_01 - param_00);
  }

  var_04 = vectordot(param_00 - param_01, param_02 - param_01) / var_03;
  if(var_04 < 0) {
    return lengthsquared(param_00 - param_01);
  } else if(var_04 > 1) {
    return lengthsquared(param_00 - param_02);
  }

  var_05 = param_01 + var_04 * param_02 - param_01;
  var_06 = lengthsquared(param_00 - var_05);
  return var_06;
}

lib_0564::func_A137(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  level endon("game_ended");
  if(param_04.size == 0) {
    return;
  }

  if(common_scripts\utility::func_627D(param_04.size, 2) != 0) {}

  var_05 = param_02 / param_03 * param_04[0];
  var_06 = param_02 / param_03 * param_04[1];
  var_07 = 0;
  var_08 = 0.05;
  self.var_4DE5 = [];
  wait(var_05);
  var_09 = var_06 - var_05;
  while(var_07 <= var_09) {
    wait(var_08);
    var_07 = var_07 + var_08;
    lib_0564::func_21CD(param_00);
  }
}

lib_0564::func_21CD(param_00) {
  var_01 = self gettagorigin("TAG_WEAPON_LEFT");
  var_02 = var_01 - self.var_0116 * (1, 1, 0);
  var_03 = length(var_02);
  foreach(var_05 in level.var_6E97) {
    if(!isDefined(var_05)) {
      continue;
    }

    if(lib_0547::func_577E(var_05)) {
      continue;
    }

    if(isalliedsentient(var_05, self)) {
      continue;
    }

    lib_0564::func_21CE(var_05, var_01, var_02, var_03, self.var_60E2);
  }

  if(isDefined(param_00) && isDefined(param_00.var_56ED) && param_00.var_56ED) {
    lib_0564::func_21CE(param_00, var_01, var_02, var_03, param_00.var_00FB / 2);
  }
}

lib_0564::func_21CE(param_00, param_01, param_02, param_03, param_04) {
  if(common_scripts\utility::func_0F79(self.var_4DE5, param_00)) {
    return;
  }

  if(!lib_0564::func_21CC(param_00, param_01[2])) {
    return;
  }

  var_05 = param_00.var_0116 - self.var_0116 * (1, 1, 0);
  var_06 = length(var_05);
  if(var_06 > param_03 + 40) {
    return;
  }

  if(vectordot(var_05, param_02) < 0.707) {
    return;
  }

  self notify("attack_hit", param_00, self.var_0116);
  maps\mp\agents\humanoid\_humanoid_melee::func_3210(param_00, param_04, "MOD_IMPACT");
  self.var_4DE5[self.var_4DE5.size] = param_00;
}

lib_0564::func_21CC(param_00, param_01) {
  var_02 = self.var_0116[2] + 80;
  var_03 = max(var_02, param_01);
  var_04 = self.var_0116[2];
  var_05 = param_00 getEye()[2];
  var_06 = param_00.var_0116[2];
  if(var_05 >= var_04 && var_05 <= var_03) {
    return 1;
  }

  if(var_06 >= var_04 && var_06 <= var_03) {
    return 1;
  }

  return 0;
}

lib_0564::func_A112() {
  self endon("death");
  level endon("game_ended");
  var_00 = 0.05;
  for(;;) {
    wait(var_00);
    if(!isDefined(self.var_5B9B) || !isDefined(self.var_28D2)) {
      continue;
    }

    var_01 = maps\mp\agents\humanoid\_humanoid::func_457E(self.var_28D2);
    if(!isDefined(var_01.var_0116)) {
      continue;
    }

    var_02 = length(var_01.var_0116 - self.var_5B9B);
    if(var_02 < 100) {
      continue;
    }

    self.var_3CF9 = 1;
  }
}

lib_0564::func_A113() {
  self endon("death");
  level endon("game_ended");
  var_00 = 0.05;
  for(;;) {
    wait(var_00);
    var_01 = undefined;
    var_02 = -1;
    var_03 = [];
    foreach(var_05 in level.var_6E97) {
      wait 0.05;
      var_06 = lib_0564::func_1E49(var_05);
      if(var_06 < 0) {
        continue;
      }

      var_03[var_03.size] = var_05;
    }

    self.var_9992 = var_03;
  }
}

lib_0564::func_1E49(param_00) {
  var_01 = 0;
  var_02[0] = ::lib_0564::func_388D;
  var_02[1] = ::lib_0564::func_388B;
  var_02[2] = ::lib_0564::func_3889;
  var_02[3] = ::lib_0564::func_388A;
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = self[[var_02[var_03]]](param_00);
    if(var_04 < 0) {
      return -1;
    }

    var_01 = var_01 + var_04;
  }

  return var_01 / var_02.size;
}

lib_0564::func_388D(param_00) {
  if(!isDefined(param_00) || !isalive(param_00)) {
    return -1;
  }

  if(isDefined(param_00.var_00CE) && param_00.var_00CE == 1) {
    return -1;
  }

  if(param_00 method_8541()) {
    return -1;
  }

  if(isalliedsentient(param_00, self)) {
    return -1;
  }

  if(lib_0547::func_8B95(param_00)) {
    return -1;
  }

  if(lib_0547::func_577D(param_00)) {
    return -1;
  }

  return 1;
}

lib_0564::func_3889(param_00) {
  if(!param_00 method_83B8() && distance2dsquared(self.var_0116, param_00.var_0116) < 250000) {
    return -1;
  }

  return 1;
}

lib_0564::func_388C(param_00) {
  var_01 = length(param_00.var_0116 - self.var_0116);
  var_02 = max(1 - var_01 / 1500, 0);
  return var_02;
}

lib_0564::func_388A(param_00) {
  if(lib_0564::func_9B84(self getEye() + (0, 0, 45), param_00, undefined)) {
    return 1;
  }

  return -1;
}

lib_0564::func_9B84(param_00, param_01, param_02) {
  var_03 = bulletTrace(param_00, param_01 getEye(), 0, undefined, 0, 0, 0, 0, 0);
  return var_03["fraction"] == 1;
}

lib_0564::func_388B(param_00) {
  if(!isDefined(self.var_28D2)) {
    return 1;
  }

  if(self.var_28D2 == param_00 && lengthsquared(param_00.var_0116 - self.var_0116) < squared(250)) {
    return -1;
  }

  return 1;
}

lib_0564::func_9E17(param_00, param_01, param_02, param_03) {
  if(gettime() - param_00.var_9A18 >= 50) {
    param_00.var_0116 = maps\mp\agents\humanoid\_humanoid_util::func_60F4(param_01, param_00.var_686A, param_02);
    param_00.var_0116 = maps\mp\agents\humanoid\_humanoid_util::func_34AB(param_00.var_0116, 15, 55);
    param_00.var_9A18 = gettime();
    if(isDefined(param_00.var_0116)) {
      var_04 = self.var_60E1;
      var_05 = param_00.var_0116 + (0, 0, var_04);
      var_06 = param_01 + (0, 0, var_04);
      var_07 = physicstrace(var_05, var_06);
      if(distancesquared(var_07, var_06) > 1) {
        param_00.var_0116 = undefined;
        return;
      }
    }
  }
}

lib_0564::func_ABA9(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = "unknown kill method";
  if(isDefined(param_01)) {
    var_09 = common_scripts\utility::func_98E7(isPlayer(param_01), param_01.var_0109, "") + " killed fireman";
    var_0A = lib_0541::func_5E60("head");
    lib_0541::func_65D0(self.var_6250 | var_0A, 1, 1, (0, 0, 1), 0);
  }

  var_0B = self gettagorigin("j_head");
  level notify("fireman_killed");
  if(common_scripts\utility::func_562E(level.var_3BF2)) {
    level thread lib_057E::func_8FA7(var_0B, var_09);
  }

  lib_054D::func_6BD4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

lib_0564::func_3C10() {
  level waittill("zombie_wave_started");
  for(;;) {
    while(level.var_A980 < level.var_66A6) {
      level waittill("zombie_wave_started");
    }

    if(level.var_7F2A == "zombie_dog") {
      level.var_66A6++;
    } else if(level.var_3C00) {
      lib_0564::func_3C13();
    }

    level waittill("zombie_wave_ended");
  }
}

lib_0564::func_3C13() {
  var_00 = lib_0564::func_3C12();
  wait(5);
  while(var_00 > 0) {
    lib_0564::func_3C14();
    var_02 = lib_0564::func_3C11(1);
    if(isDefined(var_02)) {
      var_00--;
    }

    if(var_00 > 0) {
      wait(randomfloatrange(5, 10));
    }
  }

  var_03 = 5;
  var_04 = 7;
  if(isDefined(level.fireman_round_min)) {
    var_03 = level.fireman_round_min;
  }

  if(isDefined(level.fireman_round_max)) {
    var_04 = level.fireman_round_max;
  }

  if(var_03 == var_04) {
    level.var_66A6 = level.var_A980 + var_03;
  } else {
    level.var_66A6 = level.var_A980 + randomintrange(var_03, var_04);
  }

  level.var_3BFE++;
}

lib_0564::func_3C14() {
  lib_056D::func_A78F();
}

lib_0564::func_3C12() {
  level.var_3BFF++;
  if(level.var_744A.size == 1) {
    return 1;
  }

  if(level.var_3BFF == 1 || level.var_3BFF == 2) {
    return 1;
  }

  if(level.var_3BFF == 3 || level.var_3BFF == 4) {
    return 2;
  }

  return 3;
}

lib_0564::func_3C11(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = lib_054D::func_4696("zombie_fireman", 1, 0);
  }

  if(!isDefined(param_01)) {
    return undefined;
  }

  var_03 = 0;
  if(lib_0547::func_5565(param_01.var_0165, "zombie_sky_spawner") || lib_0547::func_5565(param_01.var_8109, "scripted_fire_spawn_drop")) {
    var_03 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  var_04 = 1;
  var_05 = lib_054D::func_90BA("zombie_fireman", param_01, "fireman", param_02, var_04, 0, undefined, 0);
  if(!isDefined(var_05)) {
    return undefined;
  }

  if(var_03) {
    var_05 thread lib_0564::func_3C0D(param_01.var_0116);
  }

  var_05.var_00BC = lib_0564::func_3C04(var_05.var_00BC);
  if(var_05.var_00BC < var_05.var_00FB) {
    var_05.var_00FB = var_05.var_00BC;
  }

  level notify("spawned_fireman");
  if(isDefined(var_05)) {
    var_05.var_0C29 = 0;
    var_05 thread lib_0564::func_3C06();
  }

  if(!common_scripts\utility::func_562E(param_00)) {
    level.var_66A6 = level.var_A980 + randomintrange(5, 7);
  }

  return var_05;
}

lib_0564::func_3C0D(param_00) {
  self endon("death");
  var_01 = 2304;
  var_02 = 10000;
  var_03 = 9216;
  var_04 = 2250000;
  maps\mp\agents\_scripted_agent_anim_util::func_A79F("scripted_anim", "land", 2);
  playFX(level.var_0611["zmb_ground_impact_lrg"], param_00 + (0, 0, -12));
  var_05 = lib_0547::func_408F();
  foreach(var_07 in var_05) {
    if(var_07 == self) {
      continue;
    }

    var_08 = distancesquared(var_07.var_0116, param_00);
    if(var_08 <= var_02) {
      if(var_07.var_0A4B == "zombie_generic" || var_07.var_0A4B == "zombie_berserker") {
        var_07 suicide();
      }
    }
  }

  foreach(var_0B in level.var_744A) {
    var_08 = distancesquared(var_0B.var_0116, param_00);
    if(var_08 <= var_01) {
      var_0B dodamage(100, param_00, self, self);
    }

    var_0C = var_04 - var_08 / var_04;
    if(var_0C <= 0 || var_0C >= 1) {
      return;
    }

    var_0D = var_0C * 0.15;
    earthquake(var_0D, 0.1, param_00, 1500);
    var_0B playrumbleonentity("damage_heavy");
  }
}

lib_0564::func_3C06() {
  level.var_3BED++;
  thread lib_0564::func_3C05();
  self waittill("death");
  thread lib_0564::func_3C07();
  level.var_3BED--;
  level notify("fireman_total_update");
}

lib_0564::func_3C05() {
  self waittill("actor_corpse", var_00);
  wait(60);
  if(isDefined(var_00)) {
    var_00 delete();
  }
}

lib_0564::func_3C07() {}

lib_0564::func_3C04(param_00) {
  var_01 = 1;
  switch (level.var_744A.size) {
    case 1:
    case 0:
      var_01 = 1;
      break;

    case 2:
      var_01 = 1.5;
      break;

    case 3:
      var_01 = 2;
      break;

    case 4:
      var_01 = 2.5;
      break;
  }

  return lib_0564::func_3C03(param_00, 175000, var_01);
}

lib_0564::func_3C03(param_00, param_01, param_02) {
  if(param_00 >= param_01 * param_02) {
    param_00 = int(param_01 * param_02);
  }

  return param_00;
}

lib_0564::func_3C08() {
  var_00 = [];
  foreach(var_02 in level.var_AC4F) {
    var_03 = 0;
    if(isDefined(var_02.var_8260)) {
      var_04 = strtok(var_02.var_8260, " ,");
      foreach(var_06 in var_04) {
        if(var_06 == "zombie_fireman") {
          var_03 = 1;
        }
      }
    }

    if(level.var_AC80.var_ACB3[var_02.var_AC8A].var_556E && var_03) {
      var_00[var_00.size] = var_02;
    }
  }

  return common_scripts\utility::func_7A33(var_00);
}

lib_0564::func_ABAA() {
  return 0.28;
}

lib_0564::func_ABA8(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isDefined(level.zmb_boss_damage_reduction_func)) {
    param_02 = [[level.zmb_boss_damage_reduction_func]](param_05, param_02, param_04);
  }

  if(param_0A == "j_backpack" && self.var_3FEE == 0 && isalive(self)) {
    self.var_3FF1 = self.var_3FF1 - param_02;
    if(!common_scripts\utility::func_562E(self.godtank)) {
      param_02 = 1;
      thread lib_0564::func_3FF3(param_06);
    }

    if(!common_scripts\utility::func_562E(self.godtank) && self.var_3FF1 <= 0) {
      thread lib_0564::func_3FEF(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
    }
  }

  if(param_0A != "j_backpack" && self.var_3FEE == 0 && !issubstr(param_05, "fliegerfaust") && !issubstr(param_05, "tesla") && !issubstr(param_05, "razergun") && param_05 != "bazooka_zm" && param_05 != "panzerschreck_zm" && param_05 != "raven_sword_zm") {
    param_02 = param_02 * 0.5;
  }

  if(param_0A == "j_backpack" && self.var_3FEE == 1) {
    param_02 = 0;
    if(!isDefined(self.lastsparkfxtime) || self.lastsparkfxtime != gettime()) {
      playFX(common_scripts\utility::func_44F5("fireman_sparks"), param_06);
      self.lastsparkfxtime = gettime();
    }
  }

  lib_054D::func_6BD1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

lib_0564::func_3FEF(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  waittillframeend;
  if(isalive(self)) {
    lib_0380::func_2889("zmb_fireman_gas_tank_destroyed", undefined, self.var_0116);
    self.var_3FEE = 1;
    thread lib_0564::func_3FF0(param_06);
    self setonfire(0.01 * self.var_00FB, 1.5, 20, "none", 1, self, param_05);
    self dodamage(self.var_3FF2, self.var_0116, param_01, param_00, "MOD_EXPLOSIVE", param_05);
    if(isDefined(level.zmb_events_player_destoyed_brenner_gas_tank)) {
      param_01 thread[[level.zmb_events_player_destoyed_brenner_gas_tank]]();
    }
  }
}

lib_0564::func_3FF3(param_00) {
  if(randomint(100) >= 80) {
    playFXOnTag(common_scripts\utility::func_44F5("fireman_leak"), self, "TAG_STOWED_BACK");
  }
}

lib_0564::func_3FF0(param_00) {
  playFXOnTag(common_scripts\utility::func_44F5("fireman_explosion"), self, "TAG_STOWED_BACK");
}

lib_0564::func_ABA6(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!common_scripts\utility::func_562E(self.var_3FEE) && param_09 == "j_backpack") {
    return 1;
  }

  return lib_054D::func_5714(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

zombie_fireman_tesla_delayed_dmg(param_00, param_01, param_02) {
  if(common_scripts\utility::func_562E(param_01)) {
    param_00 = maps\mp\gametypes\zombies::func_1E59();
  }

  if(isDefined(param_02)) {
    param_00 = param_02;
  }

  return param_00;
}