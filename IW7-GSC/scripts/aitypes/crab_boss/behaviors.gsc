/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\aitypes\crab_boss\behaviors.gsc
***************************************************/

initbehaviors(var_0) {
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

updateeveryframe(var_0) {
  self clearpath();
  self ghostskulls_total_waves(9999999);
  return level.failure;
}

simpleaction_begin(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::setaction(self.simple_action);
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, self.simple_action, self.simple_action);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, self.simple_action);
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_1.simple_action = self.simple_action;
  self.simple_action = undefined;
}

simpleaction_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

simpleaction_end(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_2 = var_1.simple_action;
  var_1.simple_action = undefined;
  self notify(var_2 + "_done");
}

dosimpleaction_immediate(var_0, var_1) {
  self.simple_action = var_1;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "simple_action");
}

dosimpleaction(var_0, var_1) {
  self.simple_action = var_1;
  self.nextaction = "simple_action";
}

facepoint(var_0, var_1) {
  var_2 = scripts\engine\utility::getyawtospot(var_1);
  if(abs(var_2) < 16) {
    return 0;
  }

  self.desiredyaw = var_2;
  dosimpleaction_immediate(var_0, "turn");
  return 1;
}

initialmovedone(var_0, var_1) {
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "arrival_wait", "move_arrival", ::arrivalmovedone, undefined, undefined, 1000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "arrival_wait");
  return 1;
}

arrivalmovedone(var_0, var_1) {
  return 0;
}

planscaledrouteto(var_0) {
  var_1 = getdesiredmovedirindex(self.origin, var_0);
  var_2 = level.crab_boss_exit_data[var_1];
  var_3 = level.crab_boss_arrival_data[var_1];
  var_4 = level.crab_boss_move_data[var_1];
  var_5 = length2d(var_4);
  var_6 = distance2d(var_0, self.origin);
  var_7 = length2d(var_2) + length2d(var_3);
  var_8 = var_6 - var_7;
  var_9 = var_8 / var_5;
  var_0A = ceil(var_9);
  if(var_0A - var_9 < 0.5) {
    var_9 = var_0A;
  } else {
    var_9 = floor(var_9);
  }

  var_0B = var_5 * var_9;
  var_0C = var_7 + var_0B;
  self.moveloopscale = var_6 / var_0C;
  self.currentmovedirindex = var_1;
  self.movedircount = var_9;
}

getyawfrompointtospot(var_0, var_1) {
  var_2 = vectortoyaw(var_1 - var_0);
  var_2 = angleclamp180(var_2);
  var_2 = var_2 - self.angles[1];
  var_2 = angleclamp180(var_2);
  return var_2;
}

getdesiredmovedirindex(var_0, var_1) {
  var_2 = getyawfrompointtospot(var_0, var_1);
  var_3 = abs(var_2);
  if(var_3 <= 22.5) {
    return 8;
  }

  if(var_3 >= 157.5) {
    return 2;
  }

  if(var_2 > 0) {
    if(var_2 < 67.5) {
      return 7;
    }

    if(var_2 < 112.5) {
      return 4;
    }

    return 1;
  } else {
    if(var_3 < 67.5) {
      return 9;
    }

    if(var_3 < 112.5) {
      return 6;
    }

    return 2;
  }

  return 8;
}

move_begin(var_0) {
  planscaledrouteto(self.desiredbossmovepos);
  scripts\asm\crab_boss\crab_boss_asm::setaction("move");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "initial_move", "move_loop", ::initialmovedone, undefined, undefined, 6000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "initial_move");
}

move_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

move_end(var_0) {
  self.desiredbossmovepos = undefined;
  self.currentmovedirindex = undefined;
  self.movedircount = undefined;
  self notify("move_complete");
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
}

bossmoveto(var_0, var_1) {
  self.desiredbossmovepos = var_1;
  facepoint(var_0, var_1);
  return 1;
}

bomb_begin(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("bomb");
}

bomb_tick(var_0) {
  if(self.numofspawnrequested > 0) {
    return level.running;
  }

  return level.success;
}

bomb_end(var_0) {
  self.spawnposarray = undefined;
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  self notify("bomb_complete");
}

spawn_begin(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("spawn");
}

spawn_tick(var_0) {
  if(self.numofspawnrequested > 0) {
    return level.running;
  }

  return level.success;
}

spawn_end(var_0) {
  self.spawnposarray = undefined;
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  self notify("spawn_complete");
}

submerge_spawn_begin(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("submerge_spawn");
}

submerge_spawn_tick(var_0) {
  if(self.numofspawnrequested > 0) {
    return level.running;
  }

  return level.success;
}

submerge_spawn_end(var_0) {
  self.spawnposarray = undefined;
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  self notify("submerge_spawn_complete");
}

submerge_bomb_begin(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("submerge_bomb");
}

submerge_bomb_tick(var_0) {
  if(self.numofbombrequested > 0) {
    return level.running;
  }

  return level.success;
}

submerge_bomb_end(var_0) {
  self.bombposarray = undefined;
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  self notify("submerge_bomb_complete");
}

heal_begin(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("heal");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "heal", "heal_loop", undefined, undefined, undefined, 3000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "heal");
}

heal_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

heal_end(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
}

roar_begin(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("roar");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "roar", "roar_loop", undefined, undefined, undefined, 3000);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "roar");
}

roar_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

roar_end(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
}

beam_begin(var_0) {
  self.setplayerignoreradiusdamage = self.beamattacktarget.origin;
  scripts\aitypes\dlc3\bt_state_api::wait_state_setup(var_0, 750, ::beam_waitdone);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "wait");
}

beam_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  return level.success;
}

beam_end(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::clearaction();
  self.setplayerignoreradiusdamage = undefined;
  self notify("beam_done");
  self.beamfollowtargetstartpos = undefined;
  self.beamfollowtarget = undefined;
  self.beamtargetpos = undefined;
  self.beamattacktarget = undefined;
}

beam_waitdone(var_0) {
  scripts\asm\crab_boss\crab_boss_asm::setaction("beam");
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "beaming", "beam", ::beam_attackdone);
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "beaming");
  return 1;
}

beam_attackdone(var_0, var_1) {
  if(isDefined(self.requested_action) && self.requested_action == "beam_interrupted") {
    scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "beam_interrupted", "beam_interrupted", ::beaminterrupted_attackdone);
    scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "beam_interrupted");
  }

  return 1;
}

beaminterrupted_attackdone(var_0, var_1) {
  return 0;
}

dotaunt(var_0) {
  dosimpleaction(var_0, "taunt");
  return 1;
}

beamattackposition(var_0, var_1) {
  self.beamattacktarget = var_1;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "beam");
}

dodeath(var_0) {
  dosimpleaction(var_0, "death");
  return 1;
}

dospawnattack(var_0) {
  dosimpleaction(var_0, "spawn");
  return 1;
}

dobombattack(var_0) {
  dosimpleaction(var_0, "bomb");
  return 1;
}

dosmashattack(var_0) {
  dosimpleaction(var_0, "smash");
  return 1;
}

dosmashinterrupted() {
  dosimpleaction_immediate(0, "smash_interrupted");
  return 1;
}

dobeaminterrupted() {
  scripts\asm\crab_boss\crab_boss_asm::setaction("beam_interrupted");
}

dogasattack(var_0) {
  self.spawnposarray = getspawnposarray(getnumofgasspawn());
  self.numofspawnrequested = self.spawnposarray.size;
  dosimpleaction(var_0, "toxic");
  return 1;
}

dosubmerge(var_0) {
  dosimpleaction(var_0, "submerge");
  return 1;
}

getnumofgasspawn() {
  var_0 = 23 - level.spawned_enemies.size;
  var_1 = 23;
  return min(var_0, var_1);
}

getspawnposarray(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getstructarray("death_wall_spawner", "targetname");
  var_2 = scripts\engine\utility::array_randomize(var_2);
  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_4 = spawnStruct();
    var_5 = var_2[var_3 % var_2.size];
    var_4.origin = getclosestpointonnavmesh(var_5.origin);
    var_4.angles = var_5.angles;
    var_1[var_3] = var_4;
  }

  return var_1;
}

doheal(var_0) {
  dosimpleaction(var_0, "heal");
  return 1;
}

oncrabbrutesummon(var_0) {
  self.spawnposarray = var_0;
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
  var_0 = 4;
  var_1 = var_0;
  if(isDefined(level.crab_boss_num_submerge_spawn)) {
    var_1 = level.crab_boss_num_submerge_spawn;
  }

  var_2 = scripts\cp\maps\cp_town\cp_town_crab_boss_fight::get_num_alive_agent_of_type("crab_mini");
  var_3 = max(0, var_1 - var_2);
  var_4 = scripts\engine\utility::array_randomize([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]);
  var_5 = [];
  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_5[var_6] = var_4[var_6];
  }

  return var_5;
}

doemerge() {
  dosimpleaction(0, "emerge");
  return 1;
}

dodeathrayspawn(var_0) {
  self.spawnposarray = getdeathrayspawnpos(var_0);
  self.numofspawnrequested = self.spawnposarray.size;
  dosimpleaction(0, "toxic_spawn");
  return 1;
}

getdeathrayspawnpos(var_0) {
  var_1 = 100;
  var_2 = 8;
  var_3 = 8;
  var_4 = [];
  var_5 = scripts\cp\maps\cp_town\cp_town_crab_boss_fight::get_num_alive_agent_of_type("crab_mini");
  var_6 = max(0, var_2 - var_5);
  var_6 = min(var_6, var_3);
  var_7 = vectornormalize(var_0.origin - level.crab_boss.origin);
  for(var_8 = 0; var_8 < var_6; var_8++) {
    var_9 = randomfloatrange(var_1 * -1, var_1);
    var_0A = randomfloatrange(var_1 * -1, var_1);
    var_0B = vectortoangles(var_7);
    var_0C = spawnStruct();
    var_0C.origin = (var_0.origin[0] + var_9, var_0.origin[1] + var_0A, var_0.origin[2]);
    var_0C.angles = var_0B;
    var_4[var_4.size] = var_0C;
  }

  return var_4;
}

dotoxicspawn() {
  self.spawnposarray = gettoxicspawnpos(self);
  self.numofspawnrequested = self.spawnposarray.size;
  dosimpleaction(0, "toxic_spawn");
  return 1;
}

gettoxicspawnpos(var_0) {
  var_1 = 350;
  var_2 = 4;
  var_3 = 150;
  var_4 = var_2 + level.players.size;
  var_5 = [];
  var_6 = [];
  foreach(var_8 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_8)) {
      continue;
    }

    var_6[var_6.size] = var_8;
  }

  if(var_6.size == 0) {
    var_0A = (2826, 1244, -91);
    var_0B = spawnStruct();
    var_0B.origin = var_0A;
    var_0B.angles = vectortoangles(vectornormalize(var_0A - var_0.origin));
    var_5[var_5.size] = var_0B;
  } else {
    for(var_0C = 1; var_0C <= var_4; var_0C++) {
      var_8 = scripts\engine\utility::random(var_6);
      var_0D = vectornormalize(var_8.origin - var_0.origin);
      var_0E = scripts\engine\utility::drop_to_ground(var_8.origin + var_0D * -1 * var_1, 50, -2000);
      var_0F = randomfloatrange(var_3 * -1, var_3);
      var_10 = randomfloatrange(var_3 * -1, var_3);
      var_0E = var_0E + (var_0F, var_10, 0);
      var_0E = getclosestpointonnavmesh(var_0E);
      var_11 = vectortoangles(var_0D);
      var_0B = spawnStruct();
      var_0B.origin = var_0E;
      var_0B.angles = var_11;
      var_5[var_5.size] = var_0B;
    }
  }

  return var_5;
}

startroarattack(var_0) {
  self.roar_loops = var_0;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(0, "roar");
  return 1;
}

endroarattack() {
  scripts\asm\asm::asm_fireevent("roar_done");
  return 1;
}

dopain(var_0) {
  self.painalias = var_0;
  dosimpleaction(0, "pain");
}

interruptcurrentstate() {
  if(!scripts\engine\utility::istrue(self.binterruptable)) {
    return;
  }

  var_0 = scripts\asm\asm::asm_getcurrentstate("crab_boss");
  switch (var_0) {
    case "beam":
      dobeaminterrupted();
      break;

    case "smash":
      dosmashinterrupted();
      break;
  }
}

decideaction(var_0) {
  if(isDefined(self.desiredaction)) {
    return level.success;
  }

  if(!isDefined(self.nextaction) && isDefined(self.desiredbossmovepos)) {
    self.nextaction = "boss_movement";
  }

  if(isDefined(self.nextaction)) {
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, self.nextaction);
    self.nextaction = undefined;
    return level.success;
  }

  return level.failure;
}