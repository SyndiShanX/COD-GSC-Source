/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\crab_boss\crab_boss_asm.gsc
***************************************************/

asminit(var_0, var_1, var_2, var_3) {
  scripts\asm\zombie\zombie::func_13F9A(var_0, var_1, var_2, var_3);
  if(!isDefined(level.crab_boss_arrival_data)) {
    analyzecrabbossmovement();
  }
}

analyzecrabbossmovement() {
  level.crab_boss_arrival_data = [];
  level.crab_boss_move_data = [];
  for(var_0 = 1; var_0 <= 9; var_0++) {
    if(var_0 == 5) {
      continue;
    }

    var_1 = var_0;
    var_2 = scripts\asm\asm::asm_lookupanimfromalias("move_arrival", var_1);
    var_3 = self getsafecircleorigin("move_arrival", var_2);
    var_4 = getmovedelta(var_3, 0, 1);
    level.crab_boss_arrival_data[var_0] = var_4;
    level.crab_boss_arrival_time[var_0] = getanimlength(var_3);
    var_1 = var_0;
    var_2 = scripts\asm\asm::asm_lookupanimfromalias("move_loop", var_1);
    var_3 = self getsafecircleorigin("move_loop", var_2);
    var_4 = getmovedelta(var_3, 0, 1);
    level.crab_boss_move_data[var_0] = var_4;
    level.crab_boss_move_time[var_0] = getanimlength(var_3);
    var_2 = scripts\asm\asm::asm_lookupanimfromalias("move_exit", var_1);
    var_3 = self getsafecircleorigin("move_exit", var_2);
    var_4 = getmovedelta(var_3, 0, 1);
    level.crab_boss_exit_data[var_0] = var_4;
    level.crab_boss_exit_time[var_0] = getanimlength(var_3);
  }
}

isvalidaction(var_0) {
  switch (var_0) {
    case "heal":
    case "move":
    case "toxic_spawn":
    case "smash_interrupted":
    case "beam_interrupted":
    case "submerge_bomb":
    case "submerge_spawn":
    case "turn":
    case "submerge":
    case "emerge":
    case "toxic":
    case "roar":
    case "beam":
    case "taunt":
    case "smash":
    case "pain":
    case "bomb":
    case "spawn":
    case "death":
      return 1;
  }

  return 0;
}

setaction(var_0) {
  self.requested_action = var_0;
}

clearaction() {
  self.requested_action = undefined;
}

shouldplayentranceanim(var_0, var_1, var_2, var_3) {
  return !scripts\engine\utility::istrue(self.shouldabortentranceanim);
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

playbeamanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

stopcrabbossbeam() {
  self notify("stop_beam");
  self.beamtargetpos = undefined;
  self.beamtargetdest = undefined;
}

isbeamdone(var_0, var_1, var_2, var_3) {
  return isanimdone(var_0, var_1, var_2, var_3);
}

launchegg(var_0, var_1, var_2) {
  var_3 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
  if(scripts\engine\utility::istrue(var_2)) {
    scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(var_0, var_1, var_3.egg_sac_spawn_fly_time, 0);
    return;
  }

  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(var_0, var_1, var_3.egg_sac_spawn_fly_time, 1);
}

doroarbomb() {
  foreach(var_1 in level.players) {
    thread doroarbombnearplayer(var_1, self);
    scripts\engine\utility::waitframe();
  }
}

doroarbombnearplayer(var_0, var_1) {
  var_2 = getroarbombloc(var_0, var_1);
  foreach(var_4 in var_2) {
    var_5 = geteggsaclaunchpos();
    var_6 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
    scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(var_5, var_4, var_6.roar_bomb_fly_time, 0);
    scripts\engine\utility::waitframe();
  }
}

getroarbombloc(var_0, var_1) {
  var_2 = [];
  if(players_commit_to_the_run() && level.players.size == 1) {
    var_2[var_2.size] = var_0.origin;
  }

  var_3 = vectortoangles(var_1.origin - var_0.origin);
  var_2[var_2.size] = gettargetbombloc(var_0.origin, var_3, 30 + randomintrange(-5, 5), adjust_roar_bomb_dist(145) + randomintrange(5, 10));
  var_2[var_2.size] = gettargetbombloc(var_0.origin, var_3, -30 + randomintrange(-5, 5), adjust_roar_bomb_dist(145) + randomintrange(5, 10));
  var_2[var_2.size] = gettargetbombloc(var_0.origin, var_3, 0 + randomintrange(-5, 5), adjust_roar_bomb_dist(300) + randomintrange(5, 10));
  return var_2;
}

adjust_roar_bomb_dist(var_0) {
  if(!players_commit_to_the_run()) {
    return 1000;
  }

  var_1 = 35;
  var_2 = 0;
  foreach(var_4 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_4)) {
      continue;
    }

    var_2++;
  }

  return var_0 - var_2 - 1 * var_2;
}

players_commit_to_the_run() {
  var_0 = 0;
  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    if(var_2.origin[1] > 1200) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

gettargetbombloc(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + (0, var_2, 0);
  var_5 = anglesToForward(var_4);
  return var_0 + var_5 * var_3;
}

playroarloop(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm_mp::func_235F(var_0, var_1, var_2, var_3);
}

playroarend(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
  self notify("roar_done");
}

dospawnsovertime(var_0, var_1) {
  self endon(var_0 + "_finished");
  self endon("stop_spawns_over_time");
  var_2 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
  var_3 = scripts\engine\utility::array_randomize(var_2.egg_sack_launching_tags);
  var_4 = scripts\engine\utility::array_randomize(self.spawnposarray);
  self.numofspawnrequested = self.spawnposarray.size;
  for(var_5 = 0; var_5 < self.numofspawnrequested; var_5++) {
    var_6 = var_5 % var_3.size;
    var_7 = var_5 % var_4.size;
    var_8 = self gettagorigin(var_3[var_6]);
    var_9 = var_4[var_7];
    launchegg(var_8, var_9, var_1);
    wait(randomfloatrange(var_2.spawn_interval_min, var_2.spawn_interval_max));
  }

  self.numofspawnrequested = 0;
}

stopspawnsovertime() {
  self notify("stop_spawns_over_time");
}

func_5AAE() {
  var_0 = ["j_thumb_ri_3", "j_thumb_le_3"];
  foreach(var_2 in var_0) {
    level thread trycrabbosssmashattack(var_2, self);
  }
}

trycrabbosssmashattack(var_0, var_1) {
  var_2 = 300;
  var_3 = 10;
  var_4 = 250;
  var_5 = 0.2;
  var_6 = 300;
  var_7 = 80;
  var_8 = var_1 gettagorigin(var_0);
  var_9 = bulletTrace(var_8, var_8 + (0, 0, var_2 * -1), 0, var_1)["position"];
  var_0A = var_1.angles;
  if(distancesquared(var_8, var_9) > var_2 * var_2) {
    return;
  }

  earthquake(0.5, 3, var_8, 5000);
  for(var_0B = 0; var_0B <= var_3; var_0B++) {
    var_0C = scripts\engine\utility::drop_to_ground(var_1.origin + anglesToForward(var_0A) * var_4 * var_0B, 1000, -3000);
    if(var_0B == 0) {
      playFX(level._effect["claw_trail"], var_0C);
    } else {
      playFX(level._effect["claw_trail_sand"], var_0C);
    }

    earthquake(0.8, 1, var_0C, var_6);
    foreach(var_0E in level.players) {
      if(distancesquared(var_0E.origin, var_0C) < var_6 * var_6) {
        var_0E dodamage(var_7, var_0C);
      }
    }

    wait(var_5);
  }
}

dogas() {
  self endon("stop_gas");
  scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::activate_toxic_patch_and_trigger(level.crab_boss_toxic_attack_index);
}

endgas() {
  self notify("stop_gas");
}

crabbossnotehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "spawn_group":
      break;

    case "start_sonic_beam":
      thread startsonicbeam();
      break;

    case "stop_sonic_beam":
      thread stopsonicbeam();
      break;

    case "roar_launch_bomb":
      thread doroarbomb();
      break;

    case "footstep_right_large":
      thread dorightfootstep(1);
      break;

    case "footstep_right_small":
      thread dorightfootstep(0);
      break;

    case "footstep_left_large":
      thread doleftfootstep(1);
      break;

    case "footstep_left_small":
      thread doleftfootstep(0);
      break;

    case "debris_vfx_1":
      thread dodebrisvfx_1();
      break;

    case "debris_vfx_2":
      thread dodebrisvfx_2();
      break;

    case "debris_vfx_3":
      thread dodebrisvfx_3();
      break;

    case "roar_loop_end":
      self.roar_loops--;
      if(self.roar_loops == 0) {
        self.roar_loops = undefined;
        scripts\asm\asm::asm_fireevent(var_1, "roar_done");
      }
      break;

    case "spawn_start":
      thread dospawnsovertime(var_1);
      break;

    case "spawn_end":
      stopspawnsovertime();
      break;

    case "smash":
      func_5AAE();
      break;

    case "gas_start":
      thread dogas();
      break;

    case "gas_end":
      endgas();
      break;
  }
}

dodebrisvfx_1() {
  playFX(level._effect["food_search_debris"], self gettagorigin("tag_mouth"));
}

dodebrisvfx_2() {
  playFX(level._effect["food_search_debris"], self gettagorigin("tag_mouth"));
}

dodebrisvfx_3() {
  playFX(level._effect["food_search_debris"], self gettagorigin("tag_mouth"));
}

dorightfootstep(var_0) {
  if(scripts\engine\utility::istrue(var_0)) {
    earthquake(0.3, 1, self.origin, 7000);
  }

  var_1 = self gettagorigin("j_ball_ri");
  var_1 = bulletTrace(var_1 + (0, 0, 1000), var_1, 0, self)["position"];
  playFX(level._effect["leg_splashes_heavy"], var_1);
}

doleftfootstep(var_0) {
  if(scripts\engine\utility::istrue(var_0)) {
    earthquake(0.3, 1, self.origin, 7000);
  }

  var_1 = self gettagorigin("j_ball_le");
  var_1 = bulletTrace(var_1 + (0, 0, 1000), var_1, 0, self)["position"];
  playFX(level._effect["leg_splashes_heavy"], var_1);
}

submerge_spawn_notehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "shoot_egg_sac_spawn":
      thread dosubmergespawn_asm(var_1);
      break;
  }
}

toxic_spawn_notehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "gas_start":
      thread dogas();
      break;

    case "gas_end":
      endgas();
      break;
  }
}

submerge_bomb_notehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "shoot_egg_sac_bomb":
      thread dosubmergebomb_asm(var_1);
      break;
  }
}

bomb_notehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "calculate_target_pos":
      thread calculatetargetpos();
      break;

    case "spawn_start":
      thread dospawnsovertime(var_1, 1);
      break;

    case "spawn_end":
      stopspawnsovertime();
      break;
  }
}

calculatetargetpos() {
  var_0 = self.bomb_target.origin;
  var_1 = getbombingradius();
  var_2 = getnumofbombs();
  var_3 = [];
  for(var_4 = 0; var_4 < var_2; var_4++) {
    var_5 = randomfloatrange(var_1 * -1, var_1);
    var_6 = randomfloatrange(var_1 * -1, var_1);
    var_3[var_4] = getclosestpointonnavmesh((var_0[0] + var_5, var_0[1] + var_6, var_0[2]));
  }

  self.spawnposarray = var_3;
}

getbombingradius() {
  var_0 = 100;
  if(isDefined(self.bombing_radius)) {
    return self.bombing_radius;
  }

  return var_0;
}

getnumofbombs() {
  var_0 = 10;
  if(isDefined(self.num_of_bombs)) {
    return self.num_of_bombs;
  }

  return var_0;
}

dobeamattackposition(var_0, var_1) {
  self endon(var_0 + "_finished");
  self endon("stop_beam");
  var_2 = 2;
  var_3 = 200;
  var_4 = 80;
  self.setplayerignoreradiusdamage = var_1;
  var_5 = var_2 * 20;
  playFX(level._effect["crab_boss_beam_impact_buildup"], var_1);
  var_6 = self gettagorigin("tag_laser");
  level thread crab_boss_lure_beam_sfx(var_6, var_1);
  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_8 = self gettagorigin("tag_laser");
    playfxbetweenpoints(level._effect["crab_boss_beam_attack"], var_8, vectortoangles(var_1 - var_8), var_1);
    scripts\engine\utility::waitframe();
  }

  level notify("stop_lure_beam_sfx");
  playFX(level._effect["crab_boss_beam_impact"], var_1);
  earthquake(0.7, 1, var_1, var_3);
  foreach(var_0A in level.players) {
    if(distancesquared(var_0A.origin, var_1) < var_3 * var_3) {
      var_0A dodamage(var_4, var_1);
    }
  }
}

crab_boss_lure_beam_sfx(var_0, var_1) {
  var_2 = var_1 - var_0;
  var_3 = var_1 + var_2 * 0.3333333;
  var_4 = var_1 + var_2 * 0.6666667;
  var_5 = var_1 + var_2 * 0.5;
  level thread scripts\engine\utility::play_sound_in_space("town_weap_beam_fire_npc_start", var_0);
  level.boss_beam_lure_loop_sfx = scripts\engine\utility::play_loopsound_in_space("town_weap_beam_fire_npc_loop", var_0);
  level.boss_beam_lure_loop_sfx_1 = scripts\engine\utility::play_loopsound_in_space("town_weap_beam_fire_npc_loop", var_5);
  level.boss_beam_lure_loop_sfx_2 = scripts\engine\utility::play_loopsound_in_space("town_weap_apex_beam_fire_npc_loop", var_1);
  level waittill("stop_lure_beam_sfx");
  level thread scripts\engine\utility::play_sound_in_space("town_weap_beam_fire_npc_end", var_0);
  level scripts\engine\utility::play_sound_in_space("town_frag_grenade_explode", var_1);
  wait(0.15);
  level.boss_beam_lure_loop_sfx stoploopsound();
  level.boss_beam_lure_loop_sfx delete();
  level.boss_beam_lure_loop_sfx_1 stoploopsound();
  level.boss_beam_lure_loop_sfx_1 delete();
  level.boss_beam_lure_loop_sfx_2 stoploopsound();
  level.boss_beam_lure_loop_sfx_2 delete();
}

beam_notehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "beam_start":
      thread dobeamattackposition(var_1, self.beamattacktarget.origin);
      break;

    case "beam_end":
      stopcrabbossbeam();
      break;

    case "show_weak_spot":
      thread showweakspot();
      break;

    case "hide_weak_spot":
      thread hideweakspot();
      break;

    case "interruptable_start":
      self.binterruptable = 1;
      break;

    case "interruptable_end":
      self.binterruptable = undefined;
      break;

    case "start_beam_fx":
      if(!scripts\engine\utility::istrue(self.bbeamfxstarted)) {
        var_4 = self gettagorigin("tag_laser");
        thread scripts\engine\utility::play_sound_in_space("boss_crog_lure_build_up", var_4);
        playFXOnTag(scripts\engine\utility::getfx("boss_crab_beam_start_fx"), self, "tag_laser");
        self.bbeamfxstarted = 1;
      }
      break;

    case "stop_beam_fx":
      self.bbeamfxstarted = undefined;
      stopFXOnTag(scripts\engine\utility::getfx("boss_crab_beam_start_fx"), self, "tag_laser");
      break;
  }
}

smash_notehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "show_weak_spot":
      thread showweakspot();
      break;

    case "hide_weak_spot":
      thread hideweakspot();
      break;

    case "interruptable_start":
      self.binterruptable = 1;
      break;

    case "interruptable_end":
      self.binterruptable = undefined;
      break;

    case "smash":
      thread func_5AAE();
      break;
  }
}

dosubmergespawn_asm(var_0) {
  var_1 = geteggsaclaunchpos();
  var_2 = self.spawnposarray[self.numofspawnrequested - 1];
  var_3 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(var_1, var_2, var_3.egg_sac_spawn_fly_time, 1, vectortoangles(var_2 - var_1 * (1, 1, 0)));
  self.numofspawnrequested--;
}

dosubmergebomb_asm(var_0) {
  if(self.numofbombrequested <= 0) {
    return;
  }

  var_1 = geteggsaclaunchpos();
  var_2 = 0;
  if(isDefined(self.submergebombspawnindex) && scripts\engine\utility::array_contains(self.submergebombspawnindex, self.numofbombrequested)) {
    var_2 = 1;
  }

  thread launchonebomb(var_1, var_2);
}

dotoxicspawn_asm(var_0) {
  var_1 = geteggsaclaunchpos();
  thread launchtoxicspawn(var_1);
}

showweakspot() {
  if(isDefined(self.crab_boss_weak_spot)) {
    self.crab_boss_weak_spot show();
    self.crab_boss_weak_vfx setscriptablepartstate("weak_spot", "on");
  }
}

hideweakspot() {
  if(scripts\engine\utility::istrue(self.reveal_weak_spot)) {
    return;
  }

  if(isDefined(self.crab_boss_weak_spot)) {
    self.crab_boss_weak_spot hide();
    self.crab_boss_weak_vfx setscriptablepartstate("weak_spot", "off");
  }
}

launchtoxicspawn(var_0) {
  if(self.numofspawnrequested == 0) {
    return;
  }

  var_1 = self.spawnposarray[self.numofspawnrequested - 1 % self.spawnposarray.size];
  var_2 = var_1.origin;
  var_3 = var_1.angles;
  var_4 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(var_0, var_2, var_4.egg_sac_toxic_spawn_fly_time, 1, var_3);
  self.numofspawnrequested--;
}

launchonebomb(var_0, var_1) {
  var_2 = self.bombposarray[self.numofbombrequested - 1];
  var_3 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(var_0, var_2, var_3.egg_sac_bomb_fly_time, var_1);
  self.numofbombrequested--;
}

geteggsaclaunchpos() {
  if(!isDefined(self.eggsaclaunchtagcounter)) {
    self.eggsaclaunchtagcounter = 0;
  }

  var_0 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
  var_1 = var_0.egg_sack_launching_tags;
  var_2 = var_1[self.eggsaclaunchtagcounter % var_1.size];
  self.eggsaclaunchtagcounter++;
  return self gettagorigin(var_2);
}

shouldabortaction(var_0, var_1, var_2, var_3) {
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

playanimwithplaybackrate(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = var_3;
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, var_4);
}

chooseidleanim(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(self.blookatplayer)) {
    return 0;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "idle");
}

choosecrabbossturnanim(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = abs(self.desiredyaw);
  if(self.desiredyaw < 0) {
    if(var_4 < 67.5) {
      var_3 = 9;
    } else {
      var_3 = 6;
    }
  } else if(var_4 < 67.5) {
    var_3 = 7;
  } else {
    var_3 = 4;
  }

  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  var_6 = self getsafecircleorigin(var_1, var_5);
  var_7 = getangledelta(var_6, 0, 1);
  self.additionalyaw = self.desiredyaw - var_7;
  self.desiredyaw = undefined;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

shouldturn(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.desiredyaw)) {
    return 0;
  }

  return 1;
}

handleadditionalyaw(var_0, var_1) {
  self endon(var_0 + "_finished");
  var_2 = self.additionalyaw / var_1;
  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = self.angles[1];
    var_4 = var_4 + var_2;
    var_5 = (self.angles[0], var_4, self.angles[2]);
    self orientmode("face angle abs", var_5);
    scripts\engine\utility::waitframe();
  }

  self.additionalyaw = undefined;
}

playcrabbossturnanim(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self getsafecircleorigin(var_1, var_4);
  var_6 = getanimlength(var_5);
  if(isDefined(self.additionalyaw)) {
    thread handleadditionalyaw(var_1, ceil(var_6 * 20));
  }

  return scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, 1);
}

playcrabbossemergeanim(var_0, var_1, var_2, var_3) {
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2);
  self notify("emerge_complete");
}

healme(var_0) {
  self.bhealing = 1;
  wait(var_0);
  self.bhealing = undefined;
}

loophealanim(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
  thread healme(var_4.heal_duration);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

isdonehealing(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::istrue(self.bhealing)) {
    return 1;
  }

  return 0;
}

choosecrabbossmoveanim(var_0, var_1, var_2) {
  var_3 = self.currentmovedirindex;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

playmovearrival(var_0, var_1, var_2, var_3) {
  if(isDefined(self.desiredbossmovepos)) {
    var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
    var_5 = self getsafecircleorigin(var_1, var_4);
    thread applyallmotiontowards(var_1, self.desiredbossmovepos, var_5, self.moveloopscale);
  }

  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

applyallmotiontowards(var_0, var_1, var_2, var_3) {
  self endon(var_0 + "_finished");
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = 0;
  var_5 = getanimlength(var_2);
  while(var_4 < var_5) {
    var_6 = var_4 / var_5;
    var_7 = var_4 + 0.05 / var_5;
    if(var_7 > 1) {
      var_4 = 0;
      var_6 = 0;
      var_7 = var_6 + 0.05;
    }

    var_8 = getmovedelta(var_2, var_6, var_7);
    var_9 = length2d(var_8) * var_3;
    var_0A = vectornormalize(var_1 - self.origin);
    var_0B = self.origin + var_0A * var_9;
    self setorigin(var_0B, 0);
    wait(0.05);
    var_4 = var_4 + 0.05;
  }
}

playmoveexit(var_0, var_1, var_2, var_3) {
  if(isDefined(self.desiredbossmovepos)) {
    var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
    var_5 = self getsafecircleorigin(var_1, var_4);
    thread applyallmotiontowards(var_1, self.desiredbossmovepos, var_5, self.moveloopscale);
  }

  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

loopcrabbossmoveanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(isDefined(self.desiredbossmovepos)) {
    var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
    var_5 = self getsafecircleorigin(var_1, var_4);
    thread applyallmotiontowards(var_1, self.desiredbossmovepos, var_5, self.moveloopscale);
  }

  var_6 = self.movedircount;
  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_8 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
    self setanimstate(var_1, var_8);
    scripts\mp\agents\_scriptedagents::func_1384C(var_1, "end", var_1, var_8, ::crabbossnotehandler);
  }

  clearaction();
}

choosecrabbossarrivalanim(var_0, var_1, var_2) {
  var_3 = self.currentmovedirindex;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_3EE4(var_0, var_1, var_2) {
  if(!isDefined(self.painalias)) {
    var_3 = self getanimentrycount(var_1);
    return randomint(var_3);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_2, self.painalias);
}

choosesmashanim(var_0, var_1, var_2) {
  var_3 = self getanimentrycount(var_1);
  var_4 = randomint(var_3);
  self.smashanimindex = var_4;
  return var_4;
}

choosesmashinterruptedanim(var_0, var_1, var_2) {
  var_3 = self.smashanimindex;
  self.smashanimindex = undefined;
  return var_3;
}

toxicspawn_notehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "spawn_group":
      thread dogroupspawn();
      break;
  }
}

dogroupspawn() {
  var_0 = self.numofspawnrequested;
  for(var_1 = 1; var_1 <= var_0; var_1++) {
    var_2 = geteggsaclaunchpos();
    thread launchtoxicspawn(var_2);
    scripts\engine\utility::waitframe();
  }
}

startsonicbeam() {
  level thread scripts\cp\maps\cp_town\cp_town_crab_boss_sonic_ring::activate_sonic_ring(self);
}

stopsonicbeam() {}

choosetauntanim(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(level.crab_boss_random_taunt_anim)) {
    return lib_0F3C::func_3E96(var_0, var_1);
  }

  return lib_0F3C::func_3E96(var_0, var_1, "taunt");
}