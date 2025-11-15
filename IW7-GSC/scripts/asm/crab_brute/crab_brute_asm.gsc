/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\crab_brute\crab_brute_asm.gsc
*****************************************************/

asminit(param_00, param_01, param_02, param_03) {
  scripts\asm\zombie\zombie::func_13F9A(param_00, param_01, param_02, param_03);
  self.var_71D0 = ::shouldbruteplaypainanim;
}

shouldbruteplaypainanim() {
  if(isDefined(self.bforceallowpain) && self.bforceallowpain) {
    return 1;
  }

  return scripts\asm\zombie\zombie::func_1004F();
}

isvalidaction(param_00) {
  switch (param_00) {
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

setaction(param_00) {
  self.requested_action = param_00;
  self.current_action = undefined;
}

clearaction() {
  self.requested_action = undefined;
  self.current_action = undefined;
}

shouldplayentranceanim(param_00, param_01, param_02, param_03) {
  return 1;
}

playanimandlookatenemy(param_00, param_01, param_02, param_03) {
  thread scripts\asm\zombie\melee::func_6A6A(param_01, scripts\mp\agents\crab_brute\crab_brute_agent::getenemy());
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

summonnotehandler(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "flash":
      dosummon();
      break;
  }
}

crabbrutenotehandler(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "flash":
      doflash();
      break;

    case "fx_playfxontag, vfx\iw7\levels\cp_town\crog\vfx_brute_burrow_down.vfx, tag_origin":
      thread starting_burrow_sfx(param_01);
      break;

    case "fx_playfxontag, vfx\iw7\levels\cp_town\crog\vfx_brute_flash_build.vfx, j_lure_5":
      thread starting_flash_sfx();
      break;
  }
}

starting_burrow_sfx(param_00) {
  if(param_00 == "burrow_intro") {
    thread scripts\engine\utility::play_sound_in_space("brute_burrow_in_ground", self.origin + (0, 0, 30));
    var_01 = 1;
  }
}

starting_flash_sfx() {
  thread scripts\engine\utility::play_sound_in_space("brute_crog_build_up_to_flash", self.origin + (0, 0, 80));
}

dosummonfromfakecrabboss(param_00) {
  self.spawnposarray = param_00;
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
  var_00 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  foreach(var_02 in level.players) {
    if(scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(var_02)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_02.isfasttravelling)) {
      continue;
    }

    var_03 = distance2dsquared(self.origin, var_02.origin);
    if(var_03 > var_00.flash_radius_sq) {
      continue;
    }

    var_04 = var_02 getplayerangles();
    var_05 = anglesToForward(var_04);
    var_06 = vectornormalize(self.origin - var_02.origin * (1, 1, 0));
    var_07 = vectordot(var_05, var_06);
    if(var_07 < var_00.flash_dot) {
      continue;
    }

    var_08 = scripts\common\trace::create_default_contents(1);
    if(scripts\common\trace::ray_trace_passed(self getEye(), var_02 getEye(), var_02, var_08)) {
      var_02 func_20CA(var_00.flash_duration, var_00.flash_rumble_duration);
    }
  }
}

func_20CA(param_00, param_01) {
  if(!isDefined(self.var_6EC8) || param_00 > self.var_6EC8) {
    self.var_6EC8 = param_00;
  }

  if(!isDefined(self.var_6EDB) || param_01 > self.var_6EDB) {
    self.var_6EDB = param_01;
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

func_6EDC(param_00) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  var_01 = gettime() + param_00 * 1000;
  while(gettime() < var_01) {
    self playrumbleonentity("damage_heavy");
    wait(0.05);
  }
}

meleenotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    var_04 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
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
    }
  }
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
    if(isDefined(self.current_action) && self.current_action == param_02) {
      return 0;
    }

    self.current_action = param_02;
    return 1;
  }

  return 0;
}

playanimwithplaybackrate(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = param_03;
  if(param_01 == "burrow_loop") {
    thread play_burrow_loop_sfx();
  }

  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05, var_04);
}

play_burrow_loop_sfx() {
  if(isDefined(self.burrow_loop_obj)) {
    return;
  }

  var_00 = self gettagorigin("j_lure_5", 1);
  if(isDefined(var_00)) {
    self.burrow_loop_obj = spawn("script_origin", var_00);
    self.burrow_loop_obj linkto(self, "j_lure_5");
    self.burrow_loop_obj playLoopSound("brute_crog_move_underground_lp");
  }
}

playmeleeattack(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(param_01, self.curmeleetarget);
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
}

choosemeleeattack(param_00, param_01, param_02) {
  var_03 = self.curmeleetarget;
  if(!isDefined(var_03)) {
    var_03 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  }

  var_04 = 0;
  if(isDefined(var_03)) {
    var_04 = length(var_03 getvelocity());
  }

  if(scripts\asm\asm_bb::bb_moverequested() || var_04 > 0) {
    var_05 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "attack_moving");
  } else {
    var_05 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "attack");
  }

  return var_05;
}

func_3EE4(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

playmovingpainanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata().min_moving_pain_dist) {
    var_04 = func_3EE4(param_00, "pain_generic", param_03);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(param_00, "pain_generic", param_02, var_04, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(param_01, param_02, param_03, var_04);
}

doteleporthack(param_00, param_01, param_02, param_03) {
  var_06 = self _meth_8146();
  self setorigin(var_06, 0);
  var_06 = getgroundposition(var_06, 15);
  self.is_traversing = undefined;
  self notify("traverse_end");
  scripts\asm\asm::asm_setstate("decide_idle", param_03);
}

shouldstopshield(param_00, param_01, param_02, param_03) {
  if(shoulddoshield(param_00, param_01, param_02, param_03)) {
    return 0;
  }

  if(gettime() < self.minshieldstoptime) {
    return 0;
  }

  return 1;
}

shoulddoshield(param_00, param_01, param_02, param_03) {
  return 0;
}

ismyenemyinfrontofme(param_00, param_01) {
  var_02 = vectornormalize(param_00.origin - self.origin * (1, 1, 0));
  var_03 = anglesToForward(self.angles);
  var_04 = vectordot(var_02, var_03);
  if(var_04 > param_01) {
    return 1;
  }

  return 0;
}

shouldmeleeattackhit(param_00, param_01, param_02) {
  if(scripts\mp\agents\zombie\zombie_util::func_9DE0(param_00)) {
    return 1;
  }

  var_03 = distance2dsquared(param_00.origin, self.origin);
  if(var_03 > param_01) {
    return 0;
  }

  if(!ismyenemyinfrontofme(param_00, param_02)) {
    return 0;
  }

  return 1;
}

domeleedamageoncontact(param_00, param_01) {
  self endon(param_00 + "_finished");
  self endon("DoMeleeDamageOnContact_stop");
  var_02 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_03 = 0;
  while(!var_03) {
    foreach(var_05 in level.players) {
      if(scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(var_05)) {
        continue;
      }

      var_06 = distancesquared(self.origin, var_05.origin);
      if(var_06 < var_02.charge_attack_stop_facing_enemy_dist_sq) {
        scripts\asm\zombie\melee::func_1106E();
        self ghostlaunched("code_move");
        self orientmode("face angle abs", self.angles);
      }

      if(shouldmeleeattackhit(var_05, var_02.charge_attack_damage_radius_sq, var_02.charge_attack_damage_dot)) {
        scripts\asm\zombie\melee::func_1106E();
        self ghostlaunched("code_move");
        self orientmode("face angle abs", self.angles);
        scripts\asm\zombie\melee::domeleedamage(var_05, var_02.charge_attack_damage_amt, "MOD_IMPACT");
        clearaction();
        self.bchargehit = 1;
        var_03 = 1;
        break;
      } else {
        var_07 = vectornormalize(var_05.origin - self.origin * (1, 1, 0));
        var_08 = anglesToForward(self.angles);
        var_09 = vectordot(var_07, var_08);
        if(var_09 < var_02.charge_abort_dot) {
          self.bchargehit = 0;
          clearaction();
          var_03 = 1;
          break;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

playchargeloop(param_00, param_01, param_02, param_03) {
  self.bchargehit = undefined;
  if(isDefined(self.curmeleetarget)) {
    thread domeleedamageoncontact(param_01, self.curmeleetarget);
    thread scripts\asm\zombie\melee::func_6A6A(param_01, self.curmeleetarget);
  }

  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

choosechargeoutroanim(param_00, param_01, param_02) {
  var_03 = "charge_miss";
  if(scripts\engine\utility::istrue(self.bchargehit)) {
    var_03 = "charge_hit";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

choosecrabbruteturnanim(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = abs(self.desiredyaw);
  if(self.desiredyaw < 0) {
    if(var_04 < 67.5) {
      var_03 = 9;
    } else if(var_04 < 112.5) {
      var_03 = 6;
    } else if(var_04 < 157.5) {
      var_03 = 3;
    } else {
      var_03 = "2r";
    }
  } else if(self.desiredyaw < 67.5) {
    var_03 = 7;
  } else if(self.desiredyaw < 112.5) {
    var_03 = 4;
  } else if(self.desiredyaw < 157.5) {
    var_03 = 1;
  } else {
    var_03 = "2l";
  }

  self.desiredyaw = undefined;
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

shouldturn(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.desiredyaw)) {
    return 0;
  }

  return 1;
}

shouldcrabbrutestartarrival(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
  if(!isDefined(var_04)) {
    return scripts\asm\zombie\zombie::func_10092(param_00, param_01, param_02, param_03);
  }

  var_05 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  var_06 = distancesquared(self.origin, var_04.origin);
  if(var_06 < var_05.min_dist_to_enemy_to_do_arrival_sq) {
    return 0;
  }

  return scripts\asm\zombie\zombie::func_10092(param_00, param_01, param_02, param_03);
}

playchargeintro(param_00, param_01, param_02, param_03) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_04 = self getposonpath(50);
    if(isDefined(var_04)) {
      var_05 = vectornormalize(var_04 - self.origin) * (1, 1, 0);
      var_06 = vectortoangles(var_05);
      self orientmode("face angle abs", var_06);
    }
  } else if(isDefined(self.curmeleetarget)) {
    var_05 = vectornormalize(self.curmeleetarget.origin - self.origin) * (1, 1, 0);
    var_06 = vectortoangles(var_05);
    self orientmode("face angle abs", var_06);
  }

  return scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

doburrowoutrodamage(param_00) {
  self endon(param_00 + "_finished");
  thread play_burrow_outro_sfx();
  var_01 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
  wait(var_01.burrow_outro_damage_wait_time);
  radiusdamage(self.origin, var_01.burrow_outro_damage_radius, var_01.burrow_outro_max_damage_amt, var_01.burrow_outro_min_damage_amt, self, "MOD_IMPACT");
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

playburrowoutro(param_00, param_01, param_02, param_03) {
  thread doburrowoutrodamage(param_01);
  return playanimandlookatenemy(param_00, param_01, param_02, param_03);
}