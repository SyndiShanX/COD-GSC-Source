/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\slasher\slasher_asm.gsc
***********************************************/

slasherinit(var_0, var_1, var_2, var_3) {
  scripts\asm\zombie\zombie::func_13F9A(var_0, var_1, var_2, var_3);
  self.var_71D0 = scripts\mp\agents\slasher\slasher_agent::shouldslasherplaypainanim;
  self setscriptablepartstate("slasher_audio", "normal");
}

isvalidslasheraction(var_0) {
  switch (var_0) {
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

setslasheraction(var_0) {
  self.requested_action = var_0;
}

clearslasheraction() {
  self.requested_action = undefined;
}

issawbladeattackdone(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.requested_action)) {
    return 1;
  }

  if(self.requested_action != "sawblade_attack") {
    return 1;
  }

  return 0;
}

shouldendblock(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.requested_action) || self.requested_action != "block") {
    return 1;
  }

  return 0;
}

shouldshootsawblade(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.requested_action)) {
    return 0;
  }

  if(!scripts\asm\asm_bb::func_291C()) {
    return 0;
  }

  return 1;
}

shouldstopshootingsawblade(var_0, var_1, var_2, var_3) {
  return !shouldshootsawblade(var_0, var_1, var_2, var_3);
}

shouldplayentranceanim(var_0, var_1, var_2, var_3) {
  return 0;
}

playanimandlookatenemy(var_0, var_1, var_2, var_3) {
  thread scripts\asm\zombie\melee::func_6A6A(var_1, scripts\mp\agents\slasher\slasher_agent::getenemy());
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, 1);
}

isanimdone(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::func_232B(var_1, "end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(var_1, "early_end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(var_1, "finish_early")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(var_1, "code_move")) {
    return 1;
  }

  return 0;
}

playtauntanim(var_0, var_1, var_2, var_3) {
  self notify("taunt");
  thread scripts\asm\zombie\melee::func_6A6A(var_1, scripts\mp\agents\slasher\slasher_agent::getenemy());
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

dosummonspawn() {}

dogroundpounddamage(var_0, var_1) {
  if(isDefined(var_0)) {
    self endon(var_0 + "_finished");
  }

  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_2 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  foreach(var_4 in level.players) {
    if(isalive(var_4)) {
      if(distancesquared(self.origin, var_4.origin) < var_2.ground_pound_damage_radius_sq) {
        scripts\asm\zombie\melee::domeleedamage(var_4, self.ground_pound_damage, "MOD_IMPACT");
      }
    }
  }
}

groundpoundnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "groundpound") {
    dogroundpounddamage();
  }
}

playgroundpound(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread dogroundpounddamage(var_1, 0.75);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

summonnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "start_summon_zombies") {
    dosummonspawn();
  }
}

meleenotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = scripts\mp\agents\slasher\slasher_agent::getenemy();
    if(isDefined(var_4)) {
      if(distancesquared(var_4.origin, self.origin) < -25536) {
        self notify("attack_hit", var_4);
        scripts\asm\zombie\melee::domeleedamage(var_4, self.var_B601, "MOD_IMPACT");
      } else {
        self notify("attack_miss", var_4);
      }
    }

    if(!scripts\engine\utility::istrue(self.bmovingmelee)) {
      self notify("stop_melee_face_enemy");
      return;
    }

    return;
  }

  if(var_0 == "spin_attack_damage_begin") {
    thread startspinattackdamage(var_1);
    return;
  }

  if(var_0 == "spin_attack_damage_end") {
    stopspinattackdamage();
    return;
  }
}

shouldstartramanim(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_meleerequested(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  return 0;
}

func_100AD(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_throwgrenaderequested()) {
    return 0;
  }

  return 1;
}

func_2481(var_0, var_1, var_2) {
  self attach(var_1, var_2);
  thread func_5392(var_0, var_1, var_2);
  return var_2;
}

func_5392(var_0, var_1, var_2) {
  self endon("stop grenade check");
  self waittill(var_0 + "_finished");
  if(!isDefined(self)) {
    return;
  }

  self detach(var_1, var_2);
}

grenadethrownotehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "grenade_right":
    case "grenade_left":
      break;

    case "grenade_throw":
      if(scripts\engine\utility::istrue(self.grenade_thrown)) {
        return;
      }

      self.grenade_thrown = 1;
      self notify("stop grenade check");
      var_4 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();
      if(isDefined(var_4)) {
        var_5 = self.setignoremegroup;
        var_6 = self getplayerassets(scripts\mp\agents\slasher\slasher_agent::getslashergrenadehandoffset(), var_5, 0, "min time", "min energy");
        if(isDefined(var_6)) {
          self func_83C2();
          scripts\asm\asm::asm_fireephemeralevent("grenade_throw", "thrown");
        } else if(isDefined(self.enemygrenadepos)) {
          var_6 = self getplayerassets(scripts\mp\agents\slasher\slasher_agent::getslashergrenadehandoffset(), self.enemygrenadepos, 0, "min time", "min energy");
          if(isDefined(var_6)) {
            self func_83C2();
            scripts\asm\asm::asm_fireephemeralevent("grenade_throw", "thrown");
          }
        }
      }
      break;
  }
}

playgrenadethrowanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\mp\agents\slasher\slasher_agent::lookatslasherenemy();
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

grenadethrowterminate(var_0, var_1, var_2) {
  self.grenade_thrown = undefined;
}

shouldabortaction(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    return 0;
  }

  if(!isDefined(self.requested_action)) {
    return 1;
  }

  if(isDefined(var_3)) {
    if(self.requested_action != var_3) {
      return 1;
    }
  }

  return 0;
}

shoulddoaction(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.requested_action)) {
    return 0;
  }

  if(self.requested_action == var_2) {
    return 1;
  }

  return 0;
}

firebladeburst(var_0, var_1, var_2) {
  self endon(var_0 + "_finished");
  var_3 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  var_4 = randomintrange(var_3.min_burst_count, var_3.max_burst_count);
  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = (randomfloatrange(var_3.sawblade_min_offset, var_3.sawblade_max_offset), randomfloatrange(var_3.sawblade_min_offset, var_3.sawblade_max_offset), randomfloatrange(var_3.sawblade_min_offset, var_3.sawblade_max_offset));
    var_7 = magicbullet("iw7_slasher_sawblade_mp", var_1, var_2 + var_6, self);
    var_8 = getdvar("ui_mapname");
    if(var_8 != "cp_final") {
      var_7 thread hide_and_show_blade();
    }

    wait(var_3.sawblade_burst_interval);
  }
}

fireblades(var_0) {
  self endon(var_0 + "_finished");
  wait(0.2);
  var_1 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  for(;;) {
    var_2 = scripts\mp\agents\slasher\slasher_agent::getenemy();
    if(isDefined(var_2) && isDefined(self.setplayerignoreradiusdamage)) {
      var_3 = self gettagorigin("j_wrist_ri");
      var_4 = self.setplayerignoreradiusdamage;
      if(randomint(100) < var_1.sawblade_burst_chance) {
        self notify("attack_shoot", var_2);
        firebladeburst(var_0, var_3, var_4);
      } else {
        var_5 = (randomfloatrange(var_1.sawblade_min_offset, var_1.sawblade_max_offset), randomfloatrange(var_1.sawblade_min_offset, var_1.sawblade_max_offset), randomfloatrange(var_1.sawblade_min_offset, var_1.sawblade_max_offset));
        var_6 = magicbullet("iw7_slasher_sawblade_mp", var_3, var_4 + var_5, self);
        var_7 = getdvar("ui_mapname");
        if(var_7 != "cp_final") {
          var_6 thread hide_and_show_blade();
        }
      }

      var_8 = randomfloatrange(var_1.min_sawblade_fire_interval, var_1.max_sawblade_fire_interval);
      wait(var_8);
      continue;
    }

    wait(0.1);
  }
}

hide_and_show_blade() {
  level endon("game_ended");
  self endon("death");
  foreach(var_1 in level.players) {
    if(!scripts\engine\utility::istrue(var_1.rave_mode)) {
      self hidefromplayer(var_1);
    }
  }
}

shootsawblades(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread fireblades(var_1);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

playanimwithplaybackrate(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = var_3;
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, var_4);
}

playblockanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = vectortoangles(self.damageaccumulator.lastdir * -1);
  var_4 = (0, var_4[1], 0);
  self orientmode("face angle abs", var_4);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_BEA0(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.ent)) {
    var_4 = self._blackboard.shootparams.ent.origin;
  } else if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.pos)) {
    var_4 = self._blackboard.shootparams.pos;
  } else if(isDefined(var_5)) {
    var_4 = var_5.origin;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  var_6 = self.angles[1] - vectortoyaw(var_4 - self.origin);
  var_7 = distancesquared(self.origin, var_4);
  if(var_7 < 65536) {
    var_8 = sqrt(var_7);
    if(var_8 > 3) {
      var_6 = var_6 + asin(-3 / var_8);
    }
  }

  if(abs(angleclamp180(var_6)) > self.var_129AF) {
    return 1;
  }

  return 0;
}

func_81DE() {
  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;
  if(isDefined(self._blackboard.shootparams)) {
    if(isDefined(self._blackboard.shootparams.ent)) {
      var_1 = self._blackboard.shootparams.ent;
    } else if(isDefined(self._blackboard.shootparams.pos)) {
      var_2 = self._blackboard.shootparams.pos;
    }
  }

  var_3 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(isDefined(var_3)) {
    if(!isDefined(var_1) && !isDefined(var_2)) {
      var_1 = var_3;
    }
  }

  if(isDefined(var_1) && !issentient(var_1)) {
    var_0 = 1.5;
  }

  var_4 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var_0, var_1, var_2);
  return var_4;
}

func_3F0A(var_0, var_1, var_2) {
  var_3 = func_81DE();
  if(var_3 < 0) {
    var_4 = "right";
  } else {
    var_4 = "left";
  }

  var_3 = abs(var_3);
  var_5 = 0;
  if(var_3 > 157.5) {
    var_5 = 180;
  } else if(var_3 > 112.5) {
    var_5 = 135;
  } else if(var_3 > 67.5) {
    var_5 = 90;
  } else {
    var_5 = 45;
  }

  var_6 = var_4 + "_" + var_5;
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_6);
  var_8 = self func_8101(var_1, var_7);
  return var_7;
}

func_D56A(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self.vehicle_getspawnerarray;
  self orientmode("face angle abs", self.angles);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);
  if(!isDefined(var_5) && isDefined(self.vehicle_getspawnerarray)) {
    self clearpath();
  }

  scripts\asm\asm_mp::func_237F("face current");
  scripts\asm\asm_mp::func_237E("code_move");
}

doramattackdamage(var_0) {
  var_0 endon("death");
  if(scripts\engine\utility::istrue(self.bramattackdamageoccured)) {
    return;
  }

  var_1 = vectornormalize(self getvelocity());
  var_2 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self.bramattackdamageoccured = 1;
  var_0 func_84DC(var_1, var_2.ram_attack_push);
  wait(0.2);
  var_3 = int(var_2.ram_attack_damage / 100 * var_0.maxhealth);
  scripts\asm\zombie\melee::domeleedamage(var_0, var_3, "MOD_IMPACT");
}

ramattacknotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    if(isDefined(self.curmeleetarget)) {
      var_4 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
      var_5 = distancesquared(self.origin, self.curmeleetarget.origin);
      if(var_5 < var_4.ram_attack_melee_dist_sq && scripts\asm\zombie\melee::isenemyinfrontofme(self.curmeleetarget, var_4.ram_attack_dot)) {
        thread doramattackdamage(self.curmeleetarget);
        return;
      }
    }
  }
}

handleramattackprocessing(var_0, var_1, var_2) {
  self endon(var_0 + "_finished");
  if(!isDefined(var_1)) {
    return;
  }

  self setscriptablepartstate("slasher_audio", "charge");
  var_3 = 1;
  var_4 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  self notify("attack_charge");
  for(;;) {
    var_5 = distance2dsquared(self.origin, var_1.origin);
    if(var_3 && var_5 > var_4.ram_attack_go_straight_radius_sq) {
      var_6 = var_1 getvelocity();
      var_7 = var_1.origin + var_6 * 0.15;
      var_8 = var_7 - self.origin;
      var_8 = (var_8[0], var_8[1], 0);
      var_8 = vectornormalize(var_8);
      self orientmode("face angle abs", vectortoangles(var_8));
    } else if(var_3) {
      var_3 = 0;
    }

    if(var_2 && var_5 < var_4.ram_attack_collision_dist_sq) {
      if(scripts\asm\zombie\melee::isenemyinfrontofme(var_1, var_4.ram_attack_dot)) {
        thread doramattackdamage(var_1);
        break;
      }
    }

    scripts\engine\utility::waitframe();
    if(!isDefined(var_1) || !isalive(var_1)) {
      break;
    }
  }

  self setscriptablepartstate("slasher_audio", "normal");
}

playramattackanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread handleramattackprocessing(var_1, self.curmeleetarget, 0);
  playanimwithplaybackrate(var_0, var_1, var_2, var_3);
  self setscriptablepartstate("slasher_audio", "normal");
}

playramattackloop(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread handleramattackprocessing(var_1, self.curmeleetarget, 1);
  playanimwithplaybackrate(var_0, var_1, var_2, var_3);
}

playmeleeattack(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(var_1, self.curmeleetarget);
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);
}

playmeleespinattack(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(var_1, self.curmeleetarget);
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);
}

startspinattackdamage(var_0) {
  self endon(var_0 + "_finished");
  self endon("StopSpinAttackDamage");
  var_1 = [];
  var_2 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
  for(;;) {
    var_3 = self gettagangles("tag_eye");
    var_3 = (0, var_3[1], 0);
    var_4 = anglesToForward(var_3);
    foreach(var_6 in level.players) {
      if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_6)) {
        continue;
      }

      if(!isalive(var_6)) {
        continue;
      }

      var_7 = distance2dsquared(var_6.origin, self.origin);
      if(var_7 > var_2.slasher_spin_damage_range_sq) {
        continue;
      }

      var_8 = var_1[var_6 getentitynumber()];
      if(isDefined(var_8)) {
        if(gettime() - var_8 < 250) {
          continue;
        }
      }

      var_9 = abs(var_6.origin[2] - self.origin[2]);
      if(var_9 > 64) {
        continue;
      }

      var_0A = var_6.origin - self.origin * (1, 1, 0);
      var_0B = vectornormalize(var_0A);
      var_0C = vectordot(var_0B, var_4);
      if(var_0C < 0.966) {
        continue;
      }

      var_1[var_6 getentitynumber()] = gettime();
      scripts\asm\zombie\melee::domeleedamage(var_6, var_2.slasher_spin_damage_amt, "MOD_IMPACT");
    }

    scripts\engine\utility::waitframe();
  }
}

stopspinattackdamage() {
  self notify("StopSpinAttackDamage");
}

slasherplaysharpturnanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm::func_237B(1.5);
  lib_0F3B::func_D514(var_0, var_1, var_2, var_3);
  scripts\asm\asm::func_237B(1);
}

slashershouldstartarrival(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  if(isDefined(var_4)) {
    var_5 = distancesquared(self.origin, var_4.origin);
    if(var_5 < 65536) {
      return 0;
    }
  }

  return scripts\asm\zombie\zombie::func_10092(var_0, var_1, var_2, var_3);
}

choosemeleeattack(var_0, var_1, var_2) {
  if(scripts\asm\asm_bb::bb_moverequested()) {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "attack_moving");
  } else {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "attack");
  }

  return var_3;
}

func_3EE4(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

playmovingpainanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\slasher\slasher_tunedata::gettunedata().min_moving_pain_dist) {
    var_4 = func_3EE4(var_0, "pain_generic", var_3);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(var_0, "pain_generic", var_2, var_4, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(var_1, var_2, var_3, var_4);
}

playteleportout(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = scripts\mp\agents\slasher\slasher_agent::getenemy();
  self setscriptablepartstate("teleport", "hide");
  if(soundexists("slasher_teleport_in")) {
    play_teleport_sound_to_players("slasher_teleport_in");
  }

  wait(0.1);
  self hide();
  self setorigin(self.teleportpos, 0);
  if(isDefined(var_5)) {
    self.angles = vectortoangles(var_5.origin - self.origin);
  }

  self.teleportpos = undefined;
  self ghostskulls_complete_status(self.origin);
  self clearpath();
  thread showmelater();
  if(!scripts\engine\utility::istrue(self.btraversalteleport)) {
    scripts\mp\agents\slasher\slasher_agent::lookatslasherenemy();
  }

  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, 1.5);
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    self.is_traversing = undefined;
    self.btraversalteleport = undefined;
    self notify("traverse_end");
    scripts\asm\asm::asm_setstate("decide_idle", var_3);
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

play_teleport_sound_to_players(var_0) {
  foreach(var_2 in level.players) {
    if(!self isethereal() || scripts\engine\utility::istrue(var_2.rave_mode)) {
      self playsoundtoplayer(var_0, var_2);
    }
  }
}

ontraversalteleport(var_0, var_1, var_2, var_3) {
  self.teleportpos = self func_8146();
  self.btraversalteleport = 1;
  return 1;
}

ram_attack_anim_terminate(var_0, var_1, var_2) {
  self setscriptablepartstate("slasher_audio", "normal");
}

ram_attack_start_terminate(var_0, var_1, var_2) {
  self setscriptablepartstate("slasher_audio", "normal");
}

ram_attack_loop_terminate(var_0, var_1, var_2) {
  self setscriptablepartstate("slasher_audio", "normal");
}