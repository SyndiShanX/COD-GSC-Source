/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\crab_boss\behaviors.gsc
***************************************************/

initbehaviors(param_00) {
  setupbehaviorstates();
  self.desiredaction = undefined;
  self.lastenemyengagetime = 0;
  self.myenemy = undefined;
  return level.success;
}

setupbehaviorstates() {
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("simple_action", ::simpleaction_begin, ::simpleaction_tick, ::simpleaction_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("boss_movement", ::move_begin, ::move_tick, ::move_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("heal", ::heal_begin, ::heal_tick, ::heal_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("beam", ::beam_begin, ::beam_tick, ::beam_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("roar", ::roar_begin, ::roar_tick, ::roar_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("submerge_spawn", ::submerge_spawn_begin, ::submerge_spawn_tick, ::submerge_spawn_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("spawn", ::spawn_begin, ::spawn_tick, ::spawn_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("bomb", ::bomb_begin, ::bomb_tick, ::bomb_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("submerge_bomb", ::submerge_bomb_begin, ::submerge_bomb_tick, ::submerge_bomb_end);
}

updateeveryframe(param_00) {
  self clearpath();
  self ghostskulls_total_waves(9999999);
  return level.failure;
}

simpleaction_begin(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::setaction(self.simple_action);
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, self.simple_action, self.simple_action);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, self.simple_action);
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_01.simple_action = self.simple_action;
  self.simple_action = undefined;
}

simpleaction_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.success;
}

simpleaction_end(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_02 = var_01.simple_action;
  var_01.simple_action = undefined;
  self notify(var_02 + "_done");
}

dosimpleaction_immediate(param_00, param_01) {
  self.simple_action = param_01;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "simple_action");
}

dosimpleaction(param_00, param_01) {
  self.simple_action = param_01;
  self.nextaction = "simple_action";
}

facepoint(param_00, param_01) {
  var_02 = scripts\engine\utility::getyawtospot(param_01);
  if(abs(var_02) < 16) {
    return 0;
  }

  self.desiredyaw = var_02;
  dosimpleaction_immediate(param_00, "turn");
  return 1;
}

initialmovedone(param_00, param_01) {
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "arrival_wait", "move_arrival", ::arrivalmovedone, undefined, undefined, 1000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "arrival_wait");
  return 1;
}

arrivalmovedone(param_00, param_01) {
  return 0;
}

planscaledrouteto(param_00) {
  var_01 = getdesiredmovedirindex(self.origin, param_00);
  var_02 = level.crab_boss_exit_data[var_01];
  var_03 = level.crab_boss_arrival_data[var_01];
  var_04 = level.crab_boss_move_data[var_01];
  var_05 = length2d(var_04);
  var_06 = distance2d(param_00, self.origin);
  var_07 = length2d(var_02) + length2d(var_03);
  var_08 = var_06 - var_07;
  var_09 = var_08 / var_05;
  var_0A = ceil(var_09);
  if(var_0A - var_09 < 0.5) {
    var_09 = var_0A;
  } else {
    var_09 = floor(var_09);
  }

  var_0B = var_05 * var_09;
  var_0C = var_07 + var_0B;
  self.moveloopscale = var_06 / var_0C;
  self.currentmovedirindex = var_01;
  self.movedircount = var_09;
}

getyawfrompointtospot(param_00, param_01) {
  var_02 = vectortoyaw(param_01 - param_00);
  var_02 = angleclamp180(var_02);
  var_02 = var_02 - self.angles[1];
  var_02 = angleclamp180(var_02);
  return var_02;
}

getdesiredmovedirindex(param_00, param_01) {
  var_02 = getyawfrompointtospot(param_00, param_01);
  var_03 = abs(var_02);
  if(var_03 <= 22.5) {
    return 8;
  }

  if(var_03 >= 157.5) {
    return 2;
  }

  if(var_02 > 0) {
    if(var_02 < 67.5) {
      return 7;
    }

    if(var_02 < 112.5) {
      return 4;
    }

    return 1;
  } else {
    if(var_03 < 67.5) {
      return 9;
    }

    if(var_03 < 112.5) {
      return 6;
    }

    return 2;
  }

  return 8;
}

move_begin(param_00) {
  planscaledrouteto(self.desiredbossmovepos);
  scripts\asm\crab_boss\crab_boss_asm::setaction("move");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "initial_move", "move_loop", ::initialmovedone, undefined, undefined, 6000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "initial_move");
}

move_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.success;
}

move_end(param_00) {
  self.desiredbossmovepos = undefined;
  self.currentmovedirindex = undefined;
  self.movedircount = undefined;
  self notify("move_complete");
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
}

bossmoveto(param_00, param_01) {
  self.desiredbossmovepos = param_01;
  facepoint(param_00, param_01);
  return 1;
}

bomb_begin(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("bomb");
}

bomb_tick(param_00) {
  if(self.numofspawnrequested > 0) {
    return level.running;
  }

  return level.success;
}

bomb_end(param_00) {
  self.spawnposarray = undefined;
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  self notify("bomb_complete");
}

spawn_begin(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("spawn");
}

spawn_tick(param_00) {
  if(self.numofspawnrequested > 0) {
    return level.running;
  }

  return level.success;
}

spawn_end(param_00) {
  self.spawnposarray = undefined;
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  self notify("spawn_complete");
}

submerge_spawn_begin(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("submerge_spawn");
}

submerge_spawn_tick(param_00) {
  if(self.numofspawnrequested > 0) {
    return level.running;
  }

  return level.success;
}

submerge_spawn_end(param_00) {
  self.spawnposarray = undefined;
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  self notify("submerge_spawn_complete");
}

submerge_bomb_begin(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("submerge_bomb");
}

submerge_bomb_tick(param_00) {
  if(self.numofbombrequested > 0) {
    return level.running;
  }

  return level.success;
}

submerge_bomb_end(param_00) {
  self.bombposarray = undefined;
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  self notify("submerge_bomb_complete");
}

heal_begin(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("heal");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "heal", "heal_loop", undefined, undefined, undefined, 3000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "heal");
}

heal_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.success;
}

heal_end(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
}

roar_begin(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("roar");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "roar", "roar_loop", undefined, undefined, undefined, 3000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "roar");
}

roar_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.success;
}

roar_end(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
}

beam_begin(param_00) {
  self.setplayerignoreradiusdamage = self.beamattacktarget.origin;
  scripts\aitypes\dlc3\bt_state_api::wait_state_setup(param_00, 750, ::beam_waitdone);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "wait");
}

beam_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  return level.success;
}

beam_end(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  self.setplayerignoreradiusdamage = undefined;
  self notify("beam_done");
  self.beamfollowtargetstartpos = undefined;
  self.beamfollowtarget = undefined;
  self.beamtargetpos = undefined;
  self.beamattacktarget = undefined;
}

beam_waitdone(param_00) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("beam");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "beaming", "beam", ::beam_attackdone);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "beaming");
  return 1;
}

beam_attackdone(param_00, param_01) {
  if(isDefined(self.requested_action) && self.requested_action == "beam_interrupted") {
    scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "beam_interrupted", "beam_interrupted", ::beaminterrupted_attackdone);
    scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "beam_interrupted");
  }

  return 1;
}

beaminterrupted_attackdone(param_00, param_01) {
  return 0;
}

dotaunt(param_00) {
  dosimpleaction(param_00, "taunt");
  return 1;
}

beamattackposition(param_00, param_01) {
  self.beamattacktarget = param_01;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "beam");
}

dodeath(param_00) {
  dosimpleaction(param_00, "death");
  return 1;
}

dospawnattack(param_00) {
  dosimpleaction(param_00, "spawn");
  return 1;
}

dobombattack(param_00) {
  dosimpleaction(param_00, "bomb");
  return 1;
}

dosmashattack(param_00) {
  dosimpleaction(param_00, "smash");
  return 1;
}

dosmashinterrupted() {
  dosimpleaction_immediate(0, "smash_interrupted");
  return 1;
}

dobeaminterrupted() {
  scripts\asm\crab_boss\crab_boss_asm::setaction("beam_interrupted");
}

dogasattack(param_00) {
  self.spawnposarray = getspawnposarray(getnumofgasspawn());
  self.numofspawnrequested = self.spawnposarray.size;
  dosimpleaction(param_00, "toxic");
  return 1;
}

dosubmerge(param_00) {
  dosimpleaction(param_00, "submerge");
  return 1;
}

getnumofgasspawn() {
  var_00 = 23 - level.spawned_enemies.size;
  var_01 = 23;
  return min(var_00, var_01);
}

getspawnposarray(param_00) {
  var_01 = [];
  var_02 = scripts\engine\utility::getstructarray("death_wall_spawner", "targetname");
  var_02 = scripts\engine\utility::array_randomize(var_02);
  for(var_03 = 0; var_03 < param_00; var_03++) {
    var_04 = spawnStruct();
    var_05 = var_02[var_03 % var_02.size];
    var_04.origin = getclosestpointonnavmesh(var_05.origin);
    var_04.angles = var_05.angles;
    var_01[var_03] = var_04;
  }

  return var_01;
}

doheal(param_00) {
  dosimpleaction(param_00, "heal");
  return 1;
}

oncrabbrutesummon(param_00) {
  self.spawnposarray = param_00;
  self.numofspawnrequested = self.spawnposarray.size;
  if(scripts\asm\asm::asm_isinstate("submerge_loop")) {
    self.nextaction = "submerge_spawn";
    return;
  }

  self.nextaction = "spawn";
}

dosubmergespawn() {
  self.spawnposarray = scripts\cp\maps\cp_town\cp_town_crab_boss_escort::calculate_egg_sac_spawn_pos();
  self.numofspawnrequested = self.spawnposarray.size;
  self.nextaction = "submerge_spawn";
  return 1;
}

dosubmergebomb() {
  self.bombposarray = scripts\cp\maps\cp_town\cp_town_crab_boss_escort::calculate_egg_sac_bomb_pos();
  self.numofbombrequested = self.bombposarray.size;
  self.submergebombspawnindex = getsubmergebombspawnindex();
  self.nextaction = "submerge_bomb";
  return 1;
}

getsubmergebombspawnindex() {
  var_00 = 4;
  var_01 = var_00;
  if(isDefined(level.crab_boss_num_submerge_spawn)) {
    var_01 = level.crab_boss_num_submerge_spawn;
  }

  var_02 = scripts\cp\maps\cp_town\cp_town_crab_boss_fight::get_num_alive_agent_of_type("crab_mini");
  var_03 = max(0, var_01 - var_02);
  var_04 = scripts\engine\utility::array_randomize([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]);
  var_05 = [];
  for(var_06 = 0; var_06 < var_03; var_06++) {
    var_05[var_06] = var_04[var_06];
  }

  return var_05;
}

doemerge() {
  dosimpleaction(0, "emerge");
  return 1;
}

dodeathrayspawn(param_00) {
  self.spawnposarray = getdeathrayspawnpos(param_00);
  self.numofspawnrequested = self.spawnposarray.size;
  dosimpleaction(0, "toxic_spawn");
  return 1;
}

getdeathrayspawnpos(param_00) {
  var_01 = 100;
  var_02 = 8;
  var_03 = 8;
  var_04 = [];
  var_05 = scripts\cp\maps\cp_town\cp_town_crab_boss_fight::get_num_alive_agent_of_type("crab_mini");
  var_06 = max(0, var_02 - var_05);
  var_06 = min(var_06, var_03);
  var_07 = vectornormalize(param_00.origin - level.crab_boss.origin);
  for(var_08 = 0; var_08 < var_06; var_08++) {
    var_09 = randomfloatrange(var_01 * -1, var_01);
    var_0A = randomfloatrange(var_01 * -1, var_01);
    var_0B = vectortoangles(var_07);
    var_0C = spawnStruct();
    var_0C.origin = (param_00.origin[0] + var_09, param_00.origin[1] + var_0A, param_00.origin[2]);
    var_0C.angles = var_0B;
    var_04[var_04.size] = var_0C;
  }

  return var_04;
}

dotoxicspawn() {
  self.spawnposarray = gettoxicspawnpos(self);
  self.numofspawnrequested = self.spawnposarray.size;
  dosimpleaction(0, "toxic_spawn");
  return 1;
}

gettoxicspawnpos(param_00) {
  var_01 = 350;
  var_02 = 4;
  var_03 = 150;
  var_04 = var_02 + level.players.size;
  var_05 = [];
  var_06 = [];
  foreach(var_08 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_08)) {
      continue;
    }

    var_06[var_06.size] = var_08;
  }

  if(var_06.size == 0) {
    var_0A = (2826, 1244, -91);
    var_0B = spawnStruct();
    var_0B.origin = var_0A;
    var_0B.angles = vectortoangles(vectornormalize(var_0A - param_00.origin));
    var_05[var_05.size] = var_0B;
  } else {
    for(var_0C = 1; var_0C <= var_04; var_0C++) {
      var_08 = scripts\engine\utility::random(var_06);
      var_0D = vectornormalize(var_08.origin - param_00.origin);
      var_0E = scripts\engine\utility::drop_to_ground(var_08.origin + var_0D * -1 * var_01, 50, -2000);
      var_0F = randomfloatrange(var_03 * -1, var_03);
      var_10 = randomfloatrange(var_03 * -1, var_03);
      var_0E = var_0E + (var_0F, var_10, 0);
      var_0E = getclosestpointonnavmesh(var_0E);
      var_11 = vectortoangles(var_0D);
      var_0B = spawnStruct();
      var_0B.origin = var_0E;
      var_0B.angles = var_11;
      var_05[var_05.size] = var_0B;
    }
  }

  return var_05;
}

startroarattack(param_00) {
  self.roar_loops = param_00;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(0, "roar");
  return 1;
}

endroarattack() {
  scripts\asm\asm::asm_fireevent("roar_done");
  return 1;
}

dopain(param_00) {
  self.painalias = param_00;
  dosimpleaction(0, "pain");
}

interruptcurrentstate() {
  if(!scripts\engine\utility::istrue(self.binterruptable)) {
    return;
  }

  var_00 = scripts\asm\asm::asm_getcurrentstate("crab_boss");
  switch (var_00) {
    case "beam":
      dobeaminterrupted();
      break;

    case "smash":
      dosmashinterrupted();
      break;
  }
}

decideaction(param_00) {
  if(isDefined(self.desiredaction)) {
    return level.success;
  }

  if(!isDefined(self.nextaction) && isDefined(self.desiredbossmovepos)) {
    self.nextaction = "boss_movement";
  }

  if(isDefined(self.nextaction)) {
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, self.nextaction);
    self.nextaction = undefined;
    return level.success;
  }

  return level.failure;
}