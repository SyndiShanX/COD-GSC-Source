/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\slasher\slasher_asm.gsc
***********************************************/

slasherinit(param_00, param_01, param_02, param_03) {
  scripts\asm\zombie\zombie::func_13F9A(param_00, param_01, param_02, param_03);
  self.var_71D0 = ::scripts\mp\agents\slasher\slasher_agent::shouldslasherplaypainanim;
  self setscriptablepartstate("slasher_audio", "normal");
}

isvalidslasheraction(param_00) {
  switch (param_00) {
    case "grenade_throw":
    case "melee_spin":
    case "swipe_attack":
    case "block":
    case "ram_attack":
    case "sawblade_attack":
    case "summon":
    case "teleport":
    case "ground_pound":
    case "taunt":
      return 1;
  }

  return 0;
}

setslasheraction(param_00) {
  self.requested_action = param_00;
}

clearslasheraction() {
  self.requested_action = undefined;
}

issawbladeattackdone(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.requested_action)) {
    return 1;
  }

  if(self.requested_action != "sawblade_attack") {
    return 1;
  }

  return 0;
}

shouldendblock(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.requested_action) || self.requested_action != "block") {
    return 1;
  }

  return 0;
}

shouldshootsawblade(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.requested_action)) {
    return 0;
  }

  if(!scripts\asm\asm_bb::func_291C()) {
    return 0;
  }

  return 1;
}

shouldstopshootingsawblade(param_00, param_01, param_02, param_03) {
  return !shouldshootsawblade(param_00, param_01, param_02, param_03);
}

shouldplayentranceanim(param_00, param_01, param_02, param_03) {
  return 0;
}

playanimandlookatenemy(param_00, param_01, param_02, param_03) {
  thread scripts\asm\zombie\melee::func_6A6A(param_01, scripts\mp\agents\slasher\slasher_agent::getenemy());
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, 1);
}

isanimdone(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm::func_232B(param_01, "end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(param_01, "early_end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(param_01, "finish_early")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(param_01, "code_move")) {
    return 1;
  }

  return 0;
}

playtauntanim(param_00, param_01, param_02, param_03) {
  self notify("taunt");
  thread scripts\asm\zombie\melee::func_6A6A(param_01, scripts\mp\agents\slasher\slasher_agent::getenemy());
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

dosummonspawn() {}

dogroundpounddamage(param_00, param_01) {
  if(isDefined(param_00)) {
    self endon(param_00 + "_finished");
  }

  if(isDefined(param_01)) {
    wait(param_01);
  }

  var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  foreach(var_04 in level.players) {
    if(isalive(var_04)) {
      if(distancesquared(self.origin, var_04.origin) < var_02.ground_pound_damage_radius_sq) {
        scripts\asm\zombie\melee::domeleedamage(var_04, self.ground_pound_damage, "MOD_IMPACT");
      }
    }
  }
}

groundpoundnotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "groundpound") {
    dogroundpounddamage();
  }
}

playgroundpound(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread dogroundpounddamage(param_01, 0.75);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

summonnotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "start_summon_zombies") {
    dosummonspawn();
  }
}

meleenotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    var_04 = scripts\mp\agents\slasher\slasher_agent::getenemy();
    if(isDefined(var_04)) {
      if(distancesquared(var_04.origin, self.origin) < -25536) {
        self notify("attack_hit", var_04);
        scripts\asm\zombie\melee::domeleedamage(var_04, self.var_B601, "MOD_IMPACT");
      } else {
        self notify("attack_miss", var_04);
      }
    }

    if(!scripts\engine\utility::istrue(self.bmovingmelee)) {
      self notify("stop_melee_face_enemy");
      return;
    }

    return;
  }

  if(param_00 == "spin_attack_damage_begin") {
    thread startspinattackdamage(param_01);
    return;
  }

  if(param_00 == "spin_attack_damage_end") {
    stopspinattackdamage();
    return;
  }
}

shouldstartramanim(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm_bb::bb_meleerequested(param_00, param_01, param_02, param_03)) {
    return 1;
  }

  return 0;
}

func_100AD(param_00, param_01, param_02, param_03) {
  if(!scripts\asm\asm_bb::bb_throwgrenaderequested()) {
    return 0;
  }

  return 1;
}

func_2481(param_00, param_01, param_02) {
  self attach(param_01, param_02);
  thread func_5392(param_00, param_01, param_02);
  return param_02;
}

func_5392(param_00, param_01, param_02) {
  self endon("stop grenade check");
  self waittill(param_00 + "_finished");
  if(!isDefined(self)) {
    return;
  }

  self detach(param_01, param_02);
}

grenadethrownotehandler(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "grenade_right":
    case "grenade_left":
      break;

    case "grenade_throw":
      if(scripts\engine\utility::istrue(self.grenade_thrown)) {
        return;
      }

      self.grenade_thrown = 1;
      self notify("stop grenade check");
      var_04 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();
      if(isDefined(var_04)) {
        var_05 = self.setignoremegroup;
        var_06 = self getplayerassets(scripts\mp\agents\slasher\slasher_agent::getslashergrenadehandoffset(), var_05, 0, "min time", "min energy");
        if(isDefined(var_06)) {
          self _meth_83C2();
          scripts\asm\asm::asm_fireephemeralevent("grenade_throw", "thrown");
        } else if(isDefined(self.enemygrenadepos)) {
          var_06 = self getplayerassets(scripts\mp\agents\slasher\slasher_agent::getslashergrenadehandoffset(), self.enemygrenadepos, 0, "min time", "min energy");
          if(isDefined(var_06)) {
            self _meth_83C2();
            scripts\asm\asm::asm_fireephemeralevent("grenade_throw", "thrown");
          }
        }
      }
      break;
  }
}

playgrenadethrowanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  scripts\mp\agents\slasher\slasher_agent::lookatslasherenemy();
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

grenadethrowterminate(param_00, param_01, param_02) {
  self.grenade_thrown = undefined;
}

shouldabortaction(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    return 0;
  }

  if(!isDefined(self.requested_action)) {
    return 1;
  }

  if(isDefined(param_03)) {
    if(self.requested_action != param_03) {
      return 1;
    }
  }

  return 0;
}

shoulddoaction(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.requested_action)) {
    return 0;
  }

  if(self.requested_action == param_02) {
    return 1;
  }

  return 0;
}

firebladeburst(param_00, param_01, param_02) {
  self endon(param_00 + "_finished");
  var_03 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_04 = randomintrange(var_03.min_burst_count, var_03.max_burst_count);
  for(var_05 = 0; var_05 < var_04; var_05++) {
    var_06 = (randomfloatrange(var_03.sawblade_min_offset, var_03.sawblade_max_offset), randomfloatrange(var_03.sawblade_min_offset, var_03.sawblade_max_offset), randomfloatrange(var_03.sawblade_min_offset, var_03.sawblade_max_offset));
    var_07 = magicbullet("iw7_slasher_sawblade_mp", param_01, param_02 + var_06, self);
    var_08 = getdvar("ui_mapname");
    if(var_08 != "cp_final") {
      var_07 thread hide_and_show_blade();
    }

    wait(var_03.sawblade_burst_interval);
  }
}

fireblades(param_00) {
  self endon(param_00 + "_finished");
  wait(0.2);
  var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  for(;;) {
    var_02 = scripts\mp\agents\slasher\slasher_agent::getenemy();
    if(isDefined(var_02) && isDefined(self.setplayerignoreradiusdamage)) {
      var_03 = self gettagorigin("j_wrist_ri");
      var_04 = self.setplayerignoreradiusdamage;
      if(randomint(100) < var_01.sawblade_burst_chance) {
        self notify("attack_shoot", var_02);
        firebladeburst(param_00, var_03, var_04);
      } else {
        var_05 = (randomfloatrange(var_01.sawblade_min_offset, var_01.sawblade_max_offset), randomfloatrange(var_01.sawblade_min_offset, var_01.sawblade_max_offset), randomfloatrange(var_01.sawblade_min_offset, var_01.sawblade_max_offset));
        var_06 = magicbullet("iw7_slasher_sawblade_mp", var_03, var_04 + var_05, self);
        var_07 = getdvar("ui_mapname");
        if(var_07 != "cp_final") {
          var_06 thread hide_and_show_blade();
        }
      }

      var_08 = randomfloatrange(var_01.min_sawblade_fire_interval, var_01.max_sawblade_fire_interval);
      wait(var_08);
      continue;
    }

    wait(0.1);
  }
}

hide_and_show_blade() {
  level endon("game_ended");
  self endon("death");
  foreach(var_01 in level.players) {
    if(!scripts\engine\utility::istrue(var_01.rave_mode)) {
      self hidefromplayer(var_01);
    }
  }
}

shootsawblades(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread fireblades(param_01);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

playanimwithplaybackrate(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = param_03;
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05, var_04);
}

playblockanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = vectortoangles(self.damageaccumulator.lastdir * -1);
  var_04 = (0, var_04[1], 0);
  self orientmode("face angle abs", var_04);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_BEA0(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  var_05 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.ent)) {
    var_04 = self.var_1198.shootparams.ent.origin;
  } else if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.pos)) {
    var_04 = self.var_1198.shootparams.pos;
  } else if(isDefined(var_05)) {
    var_04 = var_05.origin;
  }

  if(!isDefined(var_04)) {
    return 0;
  }

  var_06 = self.angles[1] - vectortoyaw(var_04 - self.origin);
  var_07 = distancesquared(self.origin, var_04);
  if(var_07 < 65536) {
    var_08 = sqrt(var_07);
    if(var_08 > 3) {
      var_06 = var_06 + asin(-3 / var_08);
    }
  }

  if(abs(angleclamp180(var_06)) > self.var_129AF) {
    return 1;
  }

  return 0;
}

_meth_81DE() {
  var_00 = 0.25;
  var_01 = undefined;
  var_02 = undefined;
  if(isDefined(self.var_1198.shootparams)) {
    if(isDefined(self.var_1198.shootparams.ent)) {
      var_01 = self.var_1198.shootparams.ent;
    } else if(isDefined(self.var_1198.shootparams.pos)) {
      var_02 = self.var_1198.shootparams.pos;
    }
  }

  var_03 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(isDefined(var_03)) {
    if(!isDefined(var_01) && !isDefined(var_02)) {
      var_01 = var_03;
    }
  }

  if(isDefined(var_01) && !issentient(var_01)) {
    var_00 = 1.5;
  }

  var_04 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var_00, var_01, var_02);
  return var_04;
}

func_3F0A(param_00, param_01, param_02) {
  var_03 = _meth_81DE();
  if(var_03 < 0) {
    var_04 = "right";
  } else {
    var_04 = "left";
  }

  var_03 = abs(var_03);
  var_05 = 0;
  if(var_03 > 157.5) {
    var_05 = 180;
  } else if(var_03 > 112.5) {
    var_05 = 135;
  } else if(var_03 > 67.5) {
    var_05 = 90;
  } else {
    var_05 = 45;
  }

  var_06 = var_04 + "_" + var_05;
  var_07 = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_06);
  var_08 = self _meth_8101(param_01, var_07);
  return var_07;
}

func_D56A(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = self.vehicle_getspawnerarray;
  self orientmode("face angle abs", self.angles);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
  if(!isDefined(var_05) && isDefined(self.vehicle_getspawnerarray)) {
    self clearpath();
  }

  scripts\asm\asm_mp::func_237F("face current");
  scripts\asm\asm_mp::func_237E("code_move");
}

doramattackdamage(param_00) {
  param_00 endon("death");
  if(scripts\engine\utility::istrue(self.bramattackdamageoccured)) {
    return;
  }

  var_01 = vectornormalize(self getvelocity());
  var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.bramattackdamageoccured = 1;
  param_00 _meth_84DC(var_01, var_02.ram_attack_push);
  wait(0.2);
  var_03 = int(var_02.ram_attack_damage / 100 * param_00.maxhealth);
  scripts\asm\zombie\melee::domeleedamage(param_00, var_03, "MOD_IMPACT");
}

ramattacknotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    if(isDefined(self.curmeleetarget)) {
      var_04 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
      var_05 = distancesquared(self.origin, self.curmeleetarget.origin);
      if(var_05 < var_04.ram_attack_melee_dist_sq && scripts\asm\zombie\melee::isenemyinfrontofme(self.curmeleetarget, var_04.ram_attack_dot)) {
        thread doramattackdamage(self.curmeleetarget);
        return;
      }
    }
  }
}

handleramattackprocessing(param_00, param_01, param_02) {
  self endon(param_00 + "_finished");
  if(!isDefined(param_01)) {
    return;
  }

  self setscriptablepartstate("slasher_audio", "charge");
  var_03 = 1;
  var_04 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self notify("attack_charge");
  for(;;) {
    var_05 = distance2dsquared(self.origin, param_01.origin);
    if(var_03 && var_05 > var_04.ram_attack_go_straight_radius_sq) {
      var_06 = param_01 getvelocity();
      var_07 = param_01.origin + var_06 * 0.15;
      var_08 = var_07 - self.origin;
      var_08 = (var_08[0], var_08[1], 0);
      var_08 = vectornormalize(var_08);
      self orientmode("face angle abs", vectortoangles(var_08));
    } else if(var_03) {
      var_03 = 0;
    }

    if(param_02 && var_05 < var_04.ram_attack_collision_dist_sq) {
      if(scripts\asm\zombie\melee::isenemyinfrontofme(param_01, var_04.ram_attack_dot)) {
        thread doramattackdamage(param_01);
        break;
      }
    }

    scripts\engine\utility::waitframe();
    if(!isDefined(param_01) || !isalive(param_01)) {
      break;
    }
  }

  self setscriptablepartstate("slasher_audio", "normal");
}

playramattackanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread handleramattackprocessing(param_01, self.curmeleetarget, 0);
  playanimwithplaybackrate(param_00, param_01, param_02, param_03);
  self setscriptablepartstate("slasher_audio", "normal");
}

playramattackloop(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread handleramattackprocessing(param_01, self.curmeleetarget, 1);
  playanimwithplaybackrate(param_00, param_01, param_02, param_03);
}

playmeleeattack(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(param_01, self.curmeleetarget);
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
}

playmeleespinattack(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(param_01, self.curmeleetarget);
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
}

startspinattackdamage(param_00) {
  self endon(param_00 + "_finished");
  self endon("StopSpinAttackDamage");
  var_01 = [];
  var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  for(;;) {
    var_03 = self gettagangles("tag_eye");
    var_03 = (0, var_03[1], 0);
    var_04 = anglesToForward(var_03);
    foreach(var_06 in level.players) {
      if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_06)) {
        continue;
      }

      if(!isalive(var_06)) {
        continue;
      }

      var_07 = distance2dsquared(var_06.origin, self.origin);
      if(var_07 > var_02.slasher_spin_damage_range_sq) {
        continue;
      }

      var_08 = var_01[var_06 getentitynumber()];
      if(isDefined(var_08)) {
        if(gettime() - var_08 < 250) {
          continue;
        }
      }

      var_09 = abs(var_06.origin[2] - self.origin[2]);
      if(var_09 > 64) {
        continue;
      }

      var_0A = var_06.origin - self.origin * (1, 1, 0);
      var_0B = vectornormalize(var_0A);
      var_0C = vectordot(var_0B, var_04);
      if(var_0C < 0.966) {
        continue;
      }

      var_01[var_06 getentitynumber()] = gettime();
      scripts\asm\zombie\melee::domeleedamage(var_06, var_02.slasher_spin_damage_amt, "MOD_IMPACT");
    }

    scripts\engine\utility::waitframe();
  }
}

stopspinattackdamage() {
  self notify("StopSpinAttackDamage");
}

slasherplaysharpturnanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  scripts\asm\asm::func_237B(1.5);
  lib_0F3B::func_D514(param_00, param_01, param_02, param_03);
  scripts\asm\asm::func_237B(1);
}

slashershouldstartarrival(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(isDefined(var_04)) {
    var_05 = distancesquared(self.origin, var_04.origin);
    if(var_05 < 65536) {
      return 0;
    }
  }

  return scripts\asm\zombie\zombie::func_10092(param_00, param_01, param_02, param_03);
}

choosemeleeattack(param_00, param_01, param_02) {
  if(scripts\asm\asm_bb::bb_moverequested()) {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "attack_moving");
  } else {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "attack");
  }

  return var_03;
}

func_3EE4(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

playmovingpainanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\slasher\slasher_tunedata::gettunedata().min_moving_pain_dist) {
    var_04 = func_3EE4(param_00, "pain_generic", param_03);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(param_00, "pain_generic", param_02, var_04, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(param_01, param_02, param_03, var_04);
}

playteleportout(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  self setscriptablepartstate("teleport", "hide");
  if(soundexists("slasher_teleport_in")) {
    play_teleport_sound_to_players("slasher_teleport_in");
  }

  wait(0.1);
  self hide();
  self setorigin(self.teleportpos, 0);
  if(isDefined(var_05)) {
    self.angles = vectortoangles(var_05.origin - self.origin);
  }

  self.teleportpos = undefined;
  self ghostskulls_complete_status(self.origin);
  self clearpath();
  thread showmelater();
  if(!scripts\engine\utility::istrue(self.btraversalteleport)) {
    scripts\mp\agents\slasher\slasher_agent::lookatslasherenemy();
  }

  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, 1.5);
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    self.is_traversing = undefined;
    self.btraversalteleport = undefined;
    self notify("traverse_end");
    scripts\asm\asm::asm_setstate("decide_idle", param_03);
  }
}

showmelater() {
  wait(0.1);
  if(soundexists("slasher_teleport_out")) {
    play_teleport_sound_to_players("slasher_teleport_out");
  }

  self setscriptablepartstate("teleport", "show");
  self show();
}

play_teleport_sound_to_players(param_00) {
  foreach(var_02 in level.players) {
    if(!self isethereal() || scripts\engine\utility::istrue(var_02.rave_mode)) {
      self playsoundtoplayer(param_00, var_02);
    }
  }
}

ontraversalteleport(param_00, param_01, param_02, param_03) {
  self.teleportpos = self _meth_8146();
  self.btraversalteleport = 1;
  return 1;
}

ram_attack_anim_terminate(param_00, param_01, param_02) {
  self setscriptablepartstate("slasher_audio", "normal");
}

ram_attack_start_terminate(param_00, param_01, param_02) {
  self setscriptablepartstate("slasher_audio", "normal");
}

ram_attack_loop_terminate(param_00, param_01, param_02) {
  self setscriptablepartstate("slasher_audio", "normal");
}