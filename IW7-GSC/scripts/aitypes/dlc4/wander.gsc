/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\wander.gsc
*******************************************/

findrandomnavpoint(param_00, param_01) {
  if(!isDefined(param_00) || !isDefined(param_01)) {
    param_00 = 300;
    param_01 = 1200;
  }

  var_02 = anglesToForward(self.angles);
  var_03 = anglestoright(self.angles);
  var_04 = var_03 * -1;
  var_05 = var_02 * -1;
  var_06 = [];
  var_06[0] = var_02;
  var_06[1] = var_03;
  var_06[2] = var_04;
  var_06[3] = var_05;
  var_06 = scripts\engine\utility::array_randomize(var_06);
  var_07 = param_00 * 2;
  foreach(var_09 in var_06) {
    var_0A = self.origin + var_09 * var_07;
    var_0A = getclosestpointonnavmesh(var_0A);
    var_0B = getrandomnavpoint(var_0A, param_00);
    if(!isDefined(var_0B)) {
      continue;
    }

    var_0C = distancesquared(var_0B, self.origin);
    if(var_0C > param_00 * param_00) {
      return var_0B;
    }
  }

  return undefined;
}

wander_begin(param_00) {
  self.var_3135.instancedata[param_00] = spawnStruct();
  self clearpath();
  var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(isDefined(var_01.wander_goal_radius)) {
    self.var_3135.instancedata[param_00].wandergoalradiussq = var_01.wander_goal_radius * var_01.wander_goal_radius;
    return;
  }

  self.var_3135.instancedata[param_00].wandergoalradiussq = 4096;
}

wander_tick(param_00) {
  var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(isDefined(var_01)) {
    return level.success;
  }

  var_02 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(param_00);
  if(isDefined(self.vehicle_getspawnerarray) && distancesquared(self.vehicle_getspawnerarray, self.origin) > var_02.wandergoalradiussq) {
    return level.running;
  }

  if(!isDefined(var_02.var_13845)) {
    var_03 = scripts\asm\dlc4\dlc4_asm::gettunedata();
    var_02.var_13845 = gettime() + randomintrange(var_03.wander_min_wait_time_ms, var_03.wander_max_wait_time_ms);
    return level.running;
  } else if(gettime() < var_03.var_13845) {
    return level.running;
  }

  var_04 = findrandomnavpoint();
  if(!isDefined(var_04)) {
    var_03.var_13845 = gettime() + 150;
    return level.running;
  }

  var_03.var_13845 = undefined;
  self ghostskulls_complete_status(var_04);
  return level.running;
}

wander_end(param_00) {
  self.var_3135.instancedata[param_00] = undefined;
}