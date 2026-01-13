/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\crab_brute\crab_brute_asm.gsc
*****************************************************/

asminit(var_0, var_1, var_2, var_3) {
  scripts\asm\zombie\zombie::func_13F9A(var_0, var_1, var_2, var_3);
  self.var_71D0 = ::shouldbruteplaypainanim;
}

shouldbruteplaypainanim() {
  if(isDefined(self.bforceallowpain) && self.bforceallowpain) {
    return 1;
  }

  return scripts\asm\zombie\zombie::func_1004F();
}

isvalidaction(var_0) {
  switch (var_0) {
    case "flash":
    case "summon":
    case "tired":
    case "charge":
    case "burrow":
    case "taunt":
    case "melee_attack":
      return 1;
  }

  return 0;
}

setaction(var_0) {
  self.requested_action = var_0;
  self.current_action = undefined;
}

clearaction() {
  self.requested_action = undefined;
  self.current_action = undefined;
}

shouldplayentranceanim(var_0, var_1, var_2, var_3) {
  return 1;
}

playanimandlookatenemy(var_0, var_1, var_2, var_3) {
  thread scripts\asm\zombie\melee::func_6A6A(var_1, scripts\mp\agents\crab_brute\crab_brute_agent::getenemy());
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

summonnotehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "flash":
      dosummon();
      break;
  }
}

crabbrutenotehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "flash":
      doflash();
      break;

    case "fx_playfxontag, vfx\iw7\levels\cp_town\crog\vfx_brute_burrow_down.vfx, tag_origin":
      thread starting_burrow_sfx(var_1);
      break;

    case "fx_playfxontag, vfx\iw7\levels\cp_town\crog\vfx_brute_flash_build.vfx, j_lure_5":
      thread starting_flash_sfx();
      break;
  }
}

starting_burrow_sfx(var_0) {
  if(var_0 == "burrow_intro") {
    thread scripts\engine\utility::play_sound_in_space("brute_burrow_in_ground", self.origin + (0, 0, 30));
    var_1 = 1;
  }
}

starting_flash_sfx() {
  thread scripts\engine\utility::play_sound_in_space("brute_crog_build_up_to_flash", self.origin + (0, 0, 80));
}

dosummonfromfakecrabboss(var_0) {
  self.spawnposarray = var_0;
  self.numofspawnrequested = self.spawnposarray.size;
  thread scripts\asm\crab_boss\crab_boss_asm::dospawnsovertime("none", 0);
}

dosummon() {
  self setscriptablepartstate("lure_fx", "summon");
  if(isDefined(level.crab_boss)) {
    scripts\cp\zombies\cp_town_spawning::brute_goon_summon();
  }
}

doflash() {
  var_0 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  foreach(var_2 in level.players) {
    if(scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(var_2)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.isfasttravelling)) {
      continue;
    }

    var_3 = distance2dsquared(self.origin, var_2.origin);
    if(var_3 > var_0.flash_radius_sq) {
      continue;
    }

    var_4 = var_2 getplayerangles();
    var_5 = anglesToForward(var_4);
    var_6 = vectornormalize(self.origin - var_2.origin * (1, 1, 0));
    var_7 = vectordot(var_5, var_6);
    if(var_7 < var_0.flash_dot) {
      continue;
    }

    var_8 = scripts\common\trace::create_default_contents(1);
    if(scripts\common\trace::ray_trace_passed(self getEye(), var_2 getEye(), var_2, var_8)) {
      var_2 func_20CA(var_0.flash_duration, var_0.flash_rumble_duration);
    }
  }
}

func_20CA(var_0, var_1) {
  if(!isDefined(self.var_6EC8) || var_0 > self.var_6EC8) {
    self.var_6EC8 = var_0;
  }

  if(!isDefined(self.var_6EDB) || var_1 > self.var_6EDB) {
    self.var_6EDB = var_1;
  }

  wait(0.05);
  if(isDefined(self.var_6EC8)) {
    self shellshock("flashbang_mp", self.var_6EC8);
    self.flashendtime = gettime() + self.var_6EC8 * 1000;
  }

  if(isDefined(self.var_6EDB)) {
    thread func_6EDC(self.var_6EDB);
  }

  self.var_6EC8 = undefined;
  self.var_6EDB = undefined;
}

func_6EDC(var_0) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  var_1 = gettime() + var_0 * 1000;
  while(gettime() < var_1) {
    self playrumbleonentity("damage_heavy");
    wait(0.05);
  }
}

meleenotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
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
    }
  }
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
    if(isDefined(self.current_action) && self.current_action == var_2) {
      return 0;
    }

    self.current_action = var_2;
    return 1;
  }

  return 0;
}

playanimwithplaybackrate(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = var_3;
  if(var_1 == "burrow_loop") {
    thread play_burrow_loop_sfx();
  }

  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, var_4);
}

play_burrow_loop_sfx() {
  if(isDefined(self.burrow_loop_obj)) {
    return;
  }

  var_0 = self gettagorigin("j_lure_5", 1);
  if(isDefined(var_0)) {
    self.burrow_loop_obj = spawn("script_origin", var_0);
    self.burrow_loop_obj linkto(self, "j_lure_5");
    self.burrow_loop_obj playLoopSound("brute_crog_move_underground_lp");
  }
}

playmeleeattack(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(var_1, self.curmeleetarget);
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);
}

choosemeleeattack(var_0, var_1, var_2) {
  var_3 = self.curmeleetarget;
  if(!isDefined(var_3)) {
    var_3 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  }

  var_4 = 0;
  if(isDefined(var_3)) {
    var_4 = length(var_3 getvelocity());
  }

  if(scripts\asm\asm_bb::bb_moverequested() || var_4 > 0) {
    var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "attack_moving");
  } else {
    var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "attack");
  }

  return var_5;
}

func_3EE4(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

playmovingpainanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata().min_moving_pain_dist) {
    var_4 = func_3EE4(var_0, "pain_generic", var_3);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(var_0, "pain_generic", var_2, var_4, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(var_1, var_2, var_3, var_4);
}

doteleporthack(var_0, var_1, var_2, var_3) {
  var_6 = self _meth_8146();
  self setorigin(var_6, 0);
  var_6 = getgroundposition(var_6, 15);
  self.is_traversing = undefined;
  self notify("traverse_end");
  scripts\asm\asm::asm_setstate("decide_idle", var_3);
}

shouldstopshield(var_0, var_1, var_2, var_3) {
  if(shoulddoshield(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  if(gettime() < self.minshieldstoptime) {
    return 0;
  }

  return 1;
}

shoulddoshield(var_0, var_1, var_2, var_3) {
  return 0;
}

ismyenemyinfrontofme(var_0, var_1) {
  var_2 = vectornormalize(var_0.origin - self.origin * (1, 1, 0));
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_2, var_3);
  if(var_4 > var_1) {
    return 1;
  }

  return 0;
}

shouldmeleeattackhit(var_0, var_1, var_2) {
  if(scripts\mp\agents\zombie\zombie_util::func_9DE0(var_0)) {
    return 1;
  }

  var_3 = distance2dsquared(var_0.origin, self.origin);
  if(var_3 > var_1) {
    return 0;
  }

  if(!ismyenemyinfrontofme(var_0, var_2)) {
    return 0;
  }

  return 1;
}

domeleedamageoncontact(var_0, var_1) {
  self endon(var_0 + "_finished");
  self endon("DoMeleeDamageOnContact_stop");
  var_2 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_3 = 0;
  while(!var_3) {
    foreach(var_5 in level.players) {
      if(scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(var_5)) {
        continue;
      }

      var_6 = distancesquared(self.origin, var_5.origin);
      if(var_6 < var_2.charge_attack_stop_facing_enemy_dist_sq) {
        scripts\asm\zombie\melee::func_1106E();
        self ghostlaunched("code_move");
        self orientmode("face angle abs", self.angles);
      }

      if(shouldmeleeattackhit(var_5, var_2.charge_attack_damage_radius_sq, var_2.charge_attack_damage_dot)) {
        scripts\asm\zombie\melee::func_1106E();
        self ghostlaunched("code_move");
        self orientmode("face angle abs", self.angles);
        scripts\asm\zombie\melee::domeleedamage(var_5, var_2.charge_attack_damage_amt, "MOD_IMPACT");
        clearaction();
        self.bchargehit = 1;
        var_3 = 1;
        break;
      } else {
        var_7 = vectornormalize(var_5.origin - self.origin * (1, 1, 0));
        var_8 = anglesToForward(self.angles);
        var_9 = vectordot(var_7, var_8);
        if(var_9 < var_2.charge_abort_dot) {
          self.bchargehit = 0;
          clearaction();
          var_3 = 1;
          break;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

playchargeloop(var_0, var_1, var_2, var_3) {
  self.bchargehit = undefined;
  if(isDefined(self.curmeleetarget)) {
    thread domeleedamageoncontact(var_1, self.curmeleetarget);
    thread scripts\asm\zombie\melee::func_6A6A(var_1, self.curmeleetarget);
  }

  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

choosechargeoutroanim(var_0, var_1, var_2) {
  var_3 = "charge_miss";
  if(scripts\engine\utility::istrue(self.bchargehit)) {
    var_3 = "charge_hit";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

choosecrabbruteturnanim(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = abs(self.desiredyaw);
  if(self.desiredyaw < 0) {
    if(var_4 < 67.5) {
      var_3 = 9;
    } else if(var_4 < 112.5) {
      var_3 = 6;
    } else if(var_4 < 157.5) {
      var_3 = 3;
    } else {
      var_3 = "2r";
    }
  } else if(self.desiredyaw < 67.5) {
    var_3 = 7;
  } else if(self.desiredyaw < 112.5) {
    var_3 = 4;
  } else if(self.desiredyaw < 157.5) {
    var_3 = 1;
  } else {
    var_3 = "2l";
  }

  self.desiredyaw = undefined;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

shouldturn(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.desiredyaw)) {
    return 0;
  }

  return 1;
}

shouldcrabbrutestartarrival(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_4)) {
    return scripts\asm\zombie\zombie::func_10092(var_0, var_1, var_2, var_3);
  }

  var_5 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_6 = distancesquared(self.origin, var_4.origin);
  if(var_6 < var_5.min_dist_to_enemy_to_do_arrival_sq) {
    return 0;
  }

  return scripts\asm\zombie\zombie::func_10092(var_0, var_1, var_2, var_3);
}

playchargeintro(var_0, var_1, var_2, var_3) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_4 = self getposonpath(50);
    if(isDefined(var_4)) {
      var_5 = vectornormalize(var_4 - self.origin) * (1, 1, 0);
      var_6 = vectortoangles(var_5);
      self orientmode("face angle abs", var_6);
    }
  } else if(isDefined(self.curmeleetarget)) {
    var_5 = vectornormalize(self.curmeleetarget.origin - self.origin) * (1, 1, 0);
    var_6 = vectortoangles(var_5);
    self orientmode("face angle abs", var_6);
  }

  return scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

doburrowoutrodamage(var_0) {
  self endon(var_0 + "_finished");
  thread play_burrow_outro_sfx();
  var_1 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  wait(var_1.burrow_outro_damage_wait_time);
  radiusdamage(self.origin, var_1.burrow_outro_damage_radius, var_1.burrow_outro_max_damage_amt, var_1.burrow_outro_min_damage_amt, self, "MOD_IMPACT");
}

play_burrow_outro_sfx() {
  if(isDefined(self.burrow_loop_obj)) {
    thread stop_burrow_loop();
  }

  thread scripts\engine\utility::play_sound_in_space("brute_burrow_out_of_ground", self.origin + (0, 0, 30));
}

stop_burrow_loop() {
  self.burrow_loop_obj stopsounds();
  wait(0.1);
  if(isDefined(self.burrow_loop_obj)) {
    self.burrow_loop_obj delete();
  }
}

playburrowoutro(var_0, var_1, var_2, var_3) {
  thread doburrowoutrodamage(var_1);
  return playanimandlookatenemy(var_0, var_1, var_2, var_3);
}