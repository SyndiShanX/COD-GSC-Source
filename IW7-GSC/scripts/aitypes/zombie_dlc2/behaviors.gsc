/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_dlc2\behaviors.gsc
*****************************************************/

checkscripteddlc2(var_0) {
  return lib_0C2B::func_3E48(var_0);
}

chaseenemydlc2(var_0) {
  scripts\asm\asm_bb::bb_setisincombat(1);
  if(self.precacheleaderboards) {
    self.curmeleetarget = undefined;
    return level.failure;
  }

  if(isDefined(self.hastraversed) && self.hastraversed) {
    self.noturnanims = 0;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  if(isDefined(self.isnodeoccupied.is_fast_traveling) || isDefined(self.isnodeoccupied.is_off_grid)) {
    self.curmeleetarget = undefined;
    return level.failure;
  }

  if(isDefined(self.isnodeoccupied.killing_time)) {
    self.curmeleetarget = undefined;
    return level.failure;
  }

  var_1 = undefined;
  if(isDefined(self.var_571B) && scripts\mp\agents\zombie\zombie_util::func_100AB()) {
    var_1 = self.var_571B;
  } else if(isDefined(self.attackent)) {
    var_1 = self.attackent;
  } else if(isDefined(self.isnodeoccupied) && !scripts\mp\agents\zombie\zombie_util::shouldignoreent(self.isnodeoccupied)) {
    var_1 = self.isnodeoccupied;
  }

  if(!isDefined(var_1)) {
    if(isDefined(self.curmeleetarget)) {
      self.var_2AB8 = 1;
    }

    self.curmeleetarget = undefined;
    return level.failure;
  }

  var_3 = self.var_252B + self.fgetarg * 2;
  var_4 = var_3 * var_3;
  var_5 = self.var_252B;
  var_6 = var_5 * var_5;
  self.curmeleetarget = var_1;
  var_7 = scripts\mp\agents\zombie\zombie_util::func_7FAA(var_1);
  var_8 = var_7.var_656D;
  var_9 = distancesquared(var_7.origin, self.origin);
  var_0A = distancesquared(var_8, self.origin);
  var_0B = self.var_2AB8;
  if(var_0A < squared(self.fgetarg) && distancesquared(var_8, var_7.origin) > squared(self.fgetarg)) {
    var_0B = 1;
    self notify("attack_anim", "end");
  }

  if(!var_0B && var_0A > var_4 && var_9 > var_6) {
    var_0B = 1;
  }

  if(var_7.var_1312B) {
    if(!var_0B && var_0A <= var_4 && var_9 > squared(self.defaultgoalradius)) {
      var_0B = 1;
    }

    self ghostskulls_total_waves(self.defaultgoalradius);
  } else if(!scripts\mp\agents\zombie\zombie_util::func_8C39(var_1, self.var_B640)) {
    self ghostskulls_total_waves(self.defaultgoalradius);
    var_0B = 1;
  } else {
    self ghostskulls_total_waves(var_3);
    if(var_0A <= var_4) {
      var_7.origin = self.origin;
      var_0B = 1;
    }
  }

  if(var_0B) {
    var_2 = getclosestpointonnavmesh(var_7.origin);
    if(distancesquared(var_2, var_7.origin) > 10000) {
      return level.failure;
    }

    self ghostskulls_complete_status(var_2);
  }

  return level.success;
}

seekenemydlc2(var_0) {
  if(isDefined(self.dontseekenemies)) {
    return level.failure;
  }

  var_1 = [];
  foreach(var_3 in level.players) {
    if(var_3.ignoreme || isDefined(var_3.triggerportableradarping) && var_3.triggerportableradarping.ignoreme) {
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_3)) {
      continue;
    }

    if(!isalive(var_3)) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  var_5 = undefined;
  if(var_1.size > 0) {
    var_5 = sortbydistance(var_1, self.origin);
  }

  if(isDefined(var_5) && var_5.size > 0) {
    var_6 = 300;
    if(self.agent_type == "skater") {
      var_6 = 32;
    }

    var_7 = distancesquared(var_5[0].origin, self.origin);
    if(var_7 < var_6 * var_6) {
      var_6 = 16;
    }

    var_8 = var_6 * var_6;
    if(self.var_2AB8 || distancesquared(self ghosthide(), var_5[0].origin) > var_8) {
      var_9 = var_5[0].origin;
      if(isDefined(var_5[0].zipline)) {
        var_9 = var_5[0].zipline.traversal_end;
      }

      var_0A = getclosestpointonnavmesh(var_9, self);
      if(distancesquared(var_0A, var_5[0].origin) > var_8) {
        return level.failure;
      }

      self ghostskulls_complete_status(var_0A);
      self.var_2AB8 = 0;
    }

    scripts\asm\asm_bb::bb_setisincombat(1);
    return level.success;
  }

  return level.failure;
}