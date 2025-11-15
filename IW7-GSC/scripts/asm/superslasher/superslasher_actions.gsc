/*************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\superslasher\superslasher_actions.gsc
*************************************************************/

superslasher_domeleedamage() {
  var_00 = 60;
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_01 = -28672;
  } else {
    var_01 = 25600;
  }

  var_02 = 72;
  var_03 = 0.707;
  var_04 = 5184;
  var_05 = 0.174;
  var_06 = anglesToForward(self.angles);
  foreach(var_08 in level.players) {
    if(!isalive(var_08)) {
      continue;
    }

    var_09 = var_08.origin - self.origin;
    var_0A = lengthsquared(var_09);
    if(var_0A > var_01) {
      continue;
    }

    if(abs(var_09[2]) > var_02) {
      continue;
    }

    var_0B = (var_09[0], var_09[1], 0);
    var_09 = vectornormalize(var_0B);
    var_0C = vectordot(var_09, var_06);
    if(var_0A < var_04) {
      if(var_0C < var_05) {
        continue;
      }
    } else if(var_0C < var_03) {
      continue;
    }

    scripts\asm\zombie\melee::domeleedamage(var_08, 0.8 * var_08.maxhealth, "MOD_IMPACT");
    var_0D = 20;
    if(!self isonground()) {
      var_0D = var_0D * 0.05;
    }

    var_0E = vectornormalize(var_08.origin + (0, 0, 45) - self.origin);
    var_0F = var_0E * var_0D * 10;
    var_08 setvelocity(var_0F);
  }
}

superslasher_dogroundpoundimpact() {
  self radiusdamage(self.origin, 256, 90, 90, self, "MOD_IMPACT");
  self setscriptablepartstate("groundpound", "on");
}

superslasher_summonminions(param_00) {
  self setscriptablepartstate("summon_minions", "on");
  if(param_00 == "ground") {
    dogenericsummons(self.nextsummonid, param_00, 1.5, undefined);
  } else {
    dowallsummon(self.nextsummonid, param_00);
  }

  self.nextsummonid++;
}

dogenericsummons(param_00, param_01, param_02, param_03) {
  var_04 = [(-4479, 3951, -161), (-4200, 4030, -164), (-4340, 4527, -146), (-4174, 4895, -144), (-4186, 5220, -154), (-4261, 5478, -160), (-4437, 5668, -150), (-4805, 5547, -134), (-4829, 5045, -140), (-5111, 4425, -67), (-4469, 4789, -151), (-4642, 4542, -156)];
  var_05 = [130, 146, 160, 193, 163, 205, 238, 266, 291, 12, 237, 85];
  if(!isDefined(self.spawnwave)) {
    self.spawnwave = 0;
  }

  var_06 = min(self.spawnwave, 10);
  self.spawnwave++;
  var_07 = [];
  for(var_08 = 0; var_08 < var_04.size; var_08++) {
    var_07[var_07.size] = var_08;
  }

  var_09 = scripts\engine\utility::array_randomize(var_07);
  var_0A = var_09.size;
  if(param_01 == "ground") {
    var_0A = 8;
  }

  summontracker_init(param_00, var_0A, param_03);
  if(param_02 <= 0) {
    param_02 = 0.05;
  }
}

dowallsummon(param_00, param_01) {
  thread dowalls(param_00);
  wait(0.1);
  dogenericsummons(param_00, param_01, 0.05, ::wallsummon_allguysdead);
}

summontracker_init(param_00, param_01, param_02) {
  if(!isDefined(self.summontracker)) {
    self.summontracker = [];
  }

  var_03 = spawnStruct();
  var_03.guysremaining = param_01;
  var_03.fnallguysdead = param_02;
  self.summontracker[param_00] = var_03;
}

summontracker_decrement(param_00) {
  if(!isDefined(self)) {
    return;
  }

  var_01 = self.summontracker[param_00];
  var_01.guysremaining--;
  if(var_01.guysremaining == 0) {
    if(isDefined(var_01.fnallguysdead)) {
      self[[var_01.fnallguysdead]](param_00);
    }

    self.summontracker[param_00] = undefined;
  }
}

summoned_waitfordeath(param_00, param_01) {
  param_01 waittill("death");
  summontracker_decrement(param_00);
}

wallsummon_allguysdead(param_00) {
  self notify("wallSummonComplete_" + param_00);
}

dowalls(param_00) {}

dowall(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("game_ended");
}

dowall_waitfortimeordone(param_00, param_01) {
  self endon("wallSummonComplete_" + param_00);
  wait(param_01);
}

checkwallsummondamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("killWallSummon_" + param_00);
  level endon("game_ended");
  var_07 = 100;
  var_08 = var_07 / 1000;
  var_09 = param_05;
  for(;;) {
    var_09 = var_09 - var_07;
    if(var_09 <= 0) {
      break;
    }

    var_0A = param_05 - var_09 / param_05;
    var_0B = param_01 + param_04 * var_0A * param_03;
    foreach(var_0D in level.players) {
      if(isalive(var_0D) && var_0D getstance() != "prone") {
        var_0E = var_0D.origin - var_0B;
        var_0F = vectordot(var_0E, param_03);
        if(abs(var_0F) < param_06) {
          var_10 = var_0D.origin - var_0F * param_03;
          var_0D dodamage(0.75 * var_0D.maxhealth, var_10, self, self, "MOD_IMPACT");
        }
      }
    }

    wait(var_08);
  }
}

superslasher_domaskchange(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  var_02 = 3;
  param_00 = param_00 % var_02;
  thread domaskfx(param_00);
  wait(3);
  thread domaskattack(param_00, param_01);
}

domaskattack(param_00, param_01) {
  switch (param_00) {
    case 0:
      domaskshockwave(param_01);
      break;

    case 1:
      domaskwires();
      break;

    case 2:
      dosawsharks(param_01);
      break;
  }
}

domaskfx(param_00) {
  self setscriptablepartstate("maskchange_" + param_00, "on");
}

domaskshockwave(param_00) {
  level endon("game_ended");
  var_01 = param_00 == "roof";
  var_02 = self.origin;
  if(var_01) {
    var_02 = (-5092, 4644, -129);
  }

  var_03 = 30;
  var_04 = 5;
  var_05 = 1;
  var_06 = 3;
  playsoundatpos((-6061, 4944, 596), "superslasher_shockwave_wind_build");
  playsoundatpos((-4818, 4858, 13), "superslasher_shockwave_plr_build");
  scripts\engine\utility::exploder(101);
  scripts\engine\utility::exploder(102);
  scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::set_zombie_spawning_parameters("continuous", 999999, 2, 0.05, "shockwave", "skeleton");
  wait(var_06);
  var_07 = thread scripts\engine\utility::play_loopsound_in_space("superslasher_shockwave_plr_lp", (-4818, 4858, 13));
  var_08 = shock_wave_wind_sfx();
  scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::kill_off_existing_zombies();
  var_09 = int(var_03 / var_04);
  var_0A = int(var_04 / var_05);
  for(var_0B = 0; var_0B < var_09; var_0B++) {
    scripts\engine\utility::exploder(100);
    for(var_0C = 0; var_0C < var_0A; var_0C++) {
      foreach(var_0E in level.players) {
        if(playerinanysafearea(var_0E)) {
          continue;
        }

        if(scripts\cp\cp_laststand::player_in_laststand(var_0E)) {
          continue;
        }

        var_0E dodamage(0.3 * var_0E.maxhealth, var_02);
      }

      wait(var_05);
    }
  }

  level thread stop_wind_fire_sfxs(var_08);
  var_07 stoploopsound();
  playsoundatpos((-4818, 4858, 13), "superslasher_shockwave_plr_end");
  self.var_1198.bstoptauntingcontinuously = 1;
  scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::set_zombie_spawning_parameters("continuous", 999999, 0.2, 0.05, "near_player", "generic_zombie");
  if(self.fight_round < 3) {
    level thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::soul_collection_sequence();
  }
}

shock_wave_wind_sfx() {
  var_00 = [];
  var_01 = [];
  var_01[0] = (-4949, 4725, -99);
  var_01[1] = (-4274, 4711, -99);
  var_01[2] = (-5051, 3906, -99);
  var_01[3] = (-4005, 3854, -99);
  var_01[4] = (-4747, 5478, -99);
  var_01[5] = (-4005, 5717, -99);
  var_01[6] = (-4947, 6070, -99);
  var_01[7] = (-4681, 6521, -99);
  var_01[8] = (-3436, 4168, -99);
  var_01[9] = (-3543, 5167, -99);
  var_01[10] = (-4076, 6086, -99);
  foreach(var_03 in var_01) {
    var_04 = scripts\engine\utility::play_loopsound_in_space("superslasher_shockwave_wind_lp", var_03);
    var_00[var_00.size] = var_04;
    var_04 playSound("superslasher_shockwave_wind_start");
  }

  return var_00;
}

stop_wind_fire_sfxs(param_00) {
  foreach(var_02 in param_00) {
    var_02 thread stop_wind_fire_sfx(var_02);
  }
}

stop_wind_fire_sfx(param_00) {
  param_00 playSound("superslasher_shockwave_wind_end");
  wait(0.5);
  param_00 stoploopsound();
  wait(4);
  param_00 delete();
}

playerinanysafearea(param_00) {
  var_01 = [(-4542, 3598, -175), (-4490, 4148, -158), (-3587, 4597, -145), (-4303, 5204, -148), (-4422, 6003, -146)];
  var_02 = [-25536, -25536, -25536, -21436, -25536];
  for(var_03 = 0; var_03 < var_01.size; var_03++) {
    if(distance2dsquared(var_01[var_03], param_00.origin) <= var_02[var_03]) {
      var_04 = getEntArray("superslasher_shockwave_safe_area", "targetname");
      foreach(var_06 in var_04) {
        if(ispointinvolume(var_01[var_03], var_06)) {
          param_00.super_slasher_shockwave_safe_area = var_06;
          return 1;
        }
      }
    }
  }

  return 0;
}

domaskwires() {
  level endon("game_ended");
  level endon("stop_wire_attack");
  self.var_1198.bwired = 1;
  if(!isDefined(level.superslasher.fight_round)) {
    return;
  }

  if(level.superslasher.fight_round == 1) {
    return;
  }

  var_00 = 1;
  if(level.superslasher.fight_round == 2) {
    var_00 = level.players.size;
  } else {
    var_00 = 4;
  }

  for(var_01 = 1; var_01 <= var_00; var_01++) {
    scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::activate_super_slasher_barrier(var_01);
  }
}

stopwireattack() {
  level notify("stop_wire_attack");
  self.var_1198.bwired = undefined;
}

dogroundjumpattackfx(param_00) {
  level endon("game_ended");
  var_01 = allocattackent();
  var_01 setattackentorigin(param_00);
  var_01 setscriptablepartstate("attack", "jumptarget");
  self.jumpattackent = var_01;
}

groundjumpattackfxcleanup() {
  if(isDefined(self.jumpattackent)) {
    self.jumpattackent setscriptablepartstate("attack", "off");
    freeattackent(self.jumpattackent);
    self.jumpattackent = undefined;
  }
}

superslasher_dosummonedsawblades() {
  var_00 = spawnStruct();
  var_00.areanynavvolumesloaded = (-5225, 5716, 20);
  var_00.var_6378 = (-4087, 3870, -160);
  var_00.totaltime = 5000;
  var_00.fgetarg = 48;
  var_00.bvertical = 1;
  thread superslasher_dosawblade(var_00);
  var_00 = spawnStruct();
  var_00.areanynavvolumesloaded = (-5687, 3968, 57);
  var_00.var_6378 = (-3717, 5209, -203);
  var_00.totaltime = 5000;
  var_00.fgetarg = 48;
  var_00.bvertical = 1;
  thread superslasher_dosawblade(var_00);
}

superslasher_dosawfan() {
  var_00 = 12;
  var_01 = 360 / var_00;
  var_02 = 1500;
  for(var_03 = 0; var_03 < var_00; var_03++) {
    var_04 = rotatevector((1, 0, 0), (0, var_01 * var_03, 0));
    var_05 = spawnStruct();
    var_05.areanynavvolumesloaded = self.origin + var_04 * 40 + (0, 0, 48);
    var_05.var_6378 = var_05.areanynavvolumesloaded + var_04 * var_02;
    var_05.totaltime = 3000;
    var_05.fgetarg = 48;
    var_05.bvertical = 0;
    thread superslasher_dosawblade(var_05);
    if(var_03 % 4 == 0) {
      wait(0.05);
    }
  }
}

superslasher_dosawblade(param_00) {
  magicbullet("zmb_superslasher_sawblade", param_00.areanynavvolumesloaded, param_00.var_6378, self);
}

superslasher_dothrownsaw() {
  var_00 = self gettagorigin("j_wrist_ri");
  if(isDefined(self.var_1198.throwsawtarget)) {
    var_01 = self.var_1198.throwsawtarget.origin + (0, 0, 48);
  } else {
    var_01 = self.var_1198.throwsawbackuptargetpos + (0, 0, 48);
  }

  var_02 = vectornormalize(var_01 - var_00);
  var_03 = vectortoyaw(var_02);
  var_04 = angleclamp180(var_03 - self.angles[1]);
  if(var_04 >= 45 || var_04 <= -45) {
    var_01 = self.origin + anglesToForward(self.angles) * 768;
    var_02 = vectornormalize(var_01 - var_00);
  }
}

superslasher_dostompattack(param_00) {
  level endon("game_ended");
  var_01 = 48;
  var_02 = 0.2;
  var_03 = 1024;
  if(isDefined(param_00)) {
    var_03 = param_00;
  }

  var_04 = int(var_03 / var_01 * 2);
  var_05 = var_03 - var_01 * 2 / var_04 - 1;
  var_06 = anglesToForward(self.angles);
  var_07 = 50 + var_01;
  var_08 = self.origin + var_06 * var_07;
  for(var_09 = 0; var_09 < var_04; var_09++) {
    var_0A = var_08 + var_09 * var_05 * var_06;
    thread dosticks(var_0A, var_01, 1000);
    wait(var_02);
  }
}

dosticks(param_00, param_01, param_02) {
  level endon("game_ended");
  var_0F = allocattackent();
  var_0F setattackentorigin(param_00);
  var_0F setscriptablepartstate("attack", "punjisticks");
  wait(param_02 / 1000);
  if(isDefined(var_0F)) {
    var_0F setscriptablepartstate("attack", "off");
    freeattackent(var_0F);
  }
}

dostickdamage(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  var_04 = param_02 * param_02;
  var_05 = 90;
  while(param_03 > 0) {
    foreach(var_07 in level.players) {
      if(isalive(var_07)) {
        if(distance2dsquared(var_07.origin, param_01) < var_04) {
          var_07 dodamage(0.9 * var_07.maxhealth, param_01, param_00, param_00, "MOD_IMPACT");
        }
      }
    }

    param_03 = param_03 - 50;
    wait(0.05);
  }
}

dosawsharks(param_00) {
  var_01 = level.players.size + 1;
  var_02 = self.origin;
  if(param_00 == "roof") {
    var_02 = (-4862, 4788, -138);
  }

  self.sawsharks = [];
  var_03 = spawnStruct();
  var_03.perplayer = [];
  foreach(var_05 in level.players) {
    var_03.perplayer[var_05 getentitynumber()] = 0;
  }

  var_07 = (90, 0, 0);
  var_08 = -25536;
  for(var_09 = 0; var_09 < var_01; var_09++) {
    var_0A = var_09 * 360 / var_01;
    var_0B = self.origin + rotatevector(var_07, (0, var_0A, 0));
    var_0C = spawnsawshark(var_0B);
    self.sawsharks[self.sawsharks.size] = var_0C;
    if(param_00 == "roof") {
      thread dosawshark_followtarget(var_0C, var_03, undefined, var_02 + rotatevector(var_07, (0, var_0A, 0)), var_08);
    } else {
      thread dosawshark_followowner(var_0C, var_03, var_0A, var_08);
    }

    scripts\engine\utility::waitframe();
  }
}

spawnsawshark(param_00) {
  var_01 = spawn("script_model", param_00);
  var_01 setModel("tag_origin");
  var_01 thread delayplayingsawsharkvfx(var_01);
  var_01 playSound("superslasher_ground_saw_deploy_lr");
  var_01 playLoopSound("superslasher_ground_saw_deploy_lp");
  return var_01;
}

delayplayingsawsharkvfx(param_00) {
  param_00 endon("death");
  param_00 rotateroll(90, 0.05);
  wait(0.2);
  playFXOnTag(level._effect["super_slasher_saw_shark_spark"], param_00, "tag_origin");
}

killallsharks(param_00) {
  if(isDefined(param_00.sawsharks)) {
    foreach(var_02 in param_00.sawsharks) {
      if(isDefined(var_02)) {
        deletesawshark(var_02);
      }
    }
  }
}

deletesawshark(param_00) {
  playFX(level._effect["super_slasher_saw_shark_hit"], param_00.origin);
  playsoundatpos(param_00.origin, "superslasher_ground_saw_explode");
  param_00 delete();
}

updatesawsharkposandangles(param_00, param_01, param_02) {
  var_03 = 90;
  param_00.origin = param_01;
  param_00.angles = (param_02[0], param_02[1], var_03);
}

getclosesttargetableplayerwithinwithlos(param_00, param_01, param_02) {
  var_03 = getclosestpointonnavmesh(param_01);
  var_04 = undefined;
  var_05 = param_02 * param_02;
  foreach(var_07 in level.players) {
    if(!isalive(var_07)) {
      continue;
    }

    if(param_00.perplayer[var_07 getentitynumber()] >= 2) {
      continue;
    }

    var_08 = distance2dsquared(var_07.origin, param_01);
    if(var_08 < var_05) {
      var_09 = getclosestpointonnavmesh(var_07.origin);
      if(navisstraightlinereachable(var_03, var_09)) {
        var_05 = var_08;
        var_04 = var_07;
      }
    }
  }

  return var_04;
}

dosawshark_followowner(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  self endon("death");
  self endon("kill_sharks");
  var_04 = (80, 0, -3);
  var_05 = undefined;
  var_06 = undefined;
  while(param_03 > 0) {
    var_06 = self.origin + rotatevector(var_04, (0, param_02, 0));
    var_05 = getclosesttargetableplayerwithinwithlos(param_01, var_06, 512);
    if(isDefined(var_05)) {
      break;
    }

    updatesawsharkposandangles(param_00, var_06, self.angles);
    param_03 = param_03 - 50;
    wait(0.05);
  }

  if(isDefined(var_05) && param_03 > 0) {
    thread dosawshark_followtarget(param_00, param_01, var_05, var_06, param_03);
    return;
  }

  deletesawshark(param_00);
}

dosawshark_followtarget(param_00, param_01, param_02, param_03, param_04) {
  level endon("game_ended");
  param_00 endon("death");
  var_05 = param_03;
  var_06 = undefined;
  var_07 = 8;
  var_08 = 4;
  var_09 = 32;
  if(isDefined(param_02)) {
    var_06 = vectortoyaw(param_02.origin - var_05);
    var_0A = param_02 getentitynumber();
    if(isDefined(param_01.perplayer[var_0A])) {
      param_01.perplayer[var_0A]++;
    }
  }

  var_0B = scripts\common\trace::create_default_contents(1);
  while(param_04 > 0) {
    if(!isDefined(param_02) || !isalive(param_02)) {
      param_02 = getclosesttargetableplayerwithinwithlos(param_01, var_05, 512);
      if(isDefined(param_02)) {
        var_06 = vectortoyaw(param_02.origin - var_05);
        param_01.perplayer[param_02 getentitynumber()]++;
      }
    }

    if(isDefined(param_02)) {
      var_0C = param_02.origin - var_05;
      var_0D = vectortoyaw(var_0C);
      var_0E = angleclamp180(var_0D - var_06);
      var_0E = clamp(var_0E, -1 * var_08, var_08);
      var_06 = angleclamp180(var_06 + var_0E);
      var_0F = var_05 + rotatevector((var_07, 0, 0), (0, var_06, 0));
      if(navisstraightlinereachable(var_05, var_0F)) {
        var_10 = scripts\common\trace::ray_trace(var_0F + (0, 0, 24), var_0F - (0, 0, 24), undefined, var_0B);
        var_05 = var_10["position"];
        if(distance2dsquared(var_05, param_02.origin) < var_09 * var_09) {
          param_02 dodamage(0.8 * param_02.maxhealth, var_05, self, self, "MOD_IMPACT");
          break;
        }
      } else {
        break;
      }

      updatesawsharkposandangles(param_01, vectortoangles(param_00.origin - param_01));
    }

    param_04 = param_04 - 50;
    wait(0.05);
  }

  deletesawshark(param_00);
}

allocattackent() {
  if(!isDefined(self.attackents)) {
    self.attackents = [];
  }

  var_00 = undefined;
  foreach(var_02 in self.attackents) {
    if(!var_02.binuse) {
      var_00 = var_02;
      break;
    }
  }

  if(!isDefined(var_00)) {
    var_00 = spawn("script_model", self.origin);
    var_00 setModel("superslasher_attack_origin");
    self.attackents[self.attackents.size] = var_00;
  }

  var_00.binuse = 1;
  return var_00;
}

setattackentorigin(param_00) {
  self.origin = param_00;
  self dontinterpolate();
}

freeattackent(param_00) {
  param_00.binuse = 0;
}