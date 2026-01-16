/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\wander.gsc
***********************************************/

findrandomnavpoint(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    var_0 = 300;
    var_1 = 1200;
  }

  var_2 = anglesToForward(self.angles);
  var_3 = anglestoright(self.angles);
  var_4 = var_3 * -1;
  var_5 = var_2 * -1;
  var_6 = [];
  var_6[0] = var_2;
  var_6[1] = var_3;
  var_6[2] = var_4;
  var_6[3] = var_5;
  var_6 = scripts\engine\utility::array_randomize(var_6);
  var_7 = var_0 * 2;

  foreach(var_9 in var_6) {
    var_10 = self.origin + var_9 * var_7;
    var_10 = getclosestpointonnavmesh(var_10);
    var_11 = getrandomnavpoint(var_10, var_0);

    if(!isDefined(var_11)) {
      continue;
    }
    var_12 = distancesquared(var_11, self.origin);

    if(var_12 > var_0 * var_0) {
      return var_11;
    }
  }

  return undefined;
}

wander_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self clearpath();
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();

  if(isDefined(var_1.wander_goal_radius)) {
    self.bt.instancedata[var_0].wandergoalradiussq = var_1.wander_goal_radius * var_1.wander_goal_radius;
  } else {
    self.bt.instancedata[var_0].wandergoalradiussq = 4096;
  }
}

wander_tick(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::getenemy();

  if(isDefined(var_1)) {
    return anim.success;
  }

  var_2 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(var_0);

  if(isDefined(self.pathgoalpos) && distancesquared(self.pathgoalpos, self.origin) > var_2.wandergoalradiussq) {
    return anim.running;
  }

  if(!isDefined(var_2.var_13845)) {
    var_3 = scripts\asm\dlc4\dlc4_asm::gettunedata();
    var_2.var_13845 = gettime() + randomintrange(var_3.wander_min_wait_time_ms, var_3.wander_max_wait_time_ms);
    return anim.running;
  } else if(gettime() < var_2.var_13845) {
    return anim.running;
  }

  var_4 = findrandomnavpoint();

  if(!isDefined(var_4)) {
    var_2.var_13845 = gettime() + 150;
    return anim.running;
  }

  var_2.var_13845 = undefined;
  self scragentsetgoalpos(var_4);
  return anim.running;
}

wander_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
}