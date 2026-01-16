/*****************************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_dlc1\behaviors.gsc
*****************************************************/

checkscripteddlc1(var_0) {
  return lib_0C2B::func_3E48(var_0);
}

chaseenemydlc1(var_0) {
  scripts\asm\asm_bb::bb_setisincombat(1);

  if(self.ignoreall) {
    self.curmeleetarget = undefined;
    return anim.failure;
  }

  if(isDefined(self.hastraversed) && self.hastraversed) {
    self.noturnanims = 0;
  }

  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(isDefined(self.enemy.is_fast_traveling) || isDefined(self.enemy.is_off_grid)) {
    self.curmeleetarget = undefined;
    return anim.failure;
  }

  if(isDefined(self.enemy.killing_time)) {
    self.curmeleetarget = undefined;
    return anim.failure;
  }

  var_1 = undefined;

  if(isDefined(self.var_571B) && scripts\mp\agents\zombie\zombie_util::func_100AB()) {
    var_1 = self.var_571B;
  } else if(isDefined(self.attackent)) {
    var_1 = self.attackent;
  } else if(isDefined(self.enemy) && !scripts\mp\agents\zombie\zombie_util::shouldignoreent(self.enemy)) {
    var_1 = self.enemy;
  }

  if(!isDefined(var_1)) {
    if(isDefined(self.curmeleetarget)) {
      self.var_2AB8 = 1;
    }

    self.curmeleetarget = undefined;
    return anim.failure;
  }

  var_3 = self.var_252B + self.radius * 2;
  var_4 = var_3 * var_3;
  var_5 = self.var_252B;
  var_6 = var_5 * var_5;
  self.curmeleetarget = var_1;
  var_7 = scripts\mp\agents\zombie\zombie_util::func_7FAA(var_1);
  var_8 = var_7.var_656D;
  var_9 = distancesquared(var_7.origin, self.origin);
  var_10 = distancesquared(var_8, self.origin);
  var_11 = self.var_2AB8;

  if(var_10 < squared(self.radius) && distancesquared(var_8, var_7.origin) > squared(self.radius)) {
    var_11 = 1;
    self notify("attack_anim", "end");
  }

  if(!var_11 && var_10 > var_4 && var_9 > var_6) {
    var_11 = 1;
  }

  if(var_7.var_1312B) {
    if(!var_11 && var_10 <= var_4 && var_9 > squared(self.defaultgoalradius)) {
      var_11 = 1;
    }

    self scragentsetgoalradius(self.defaultgoalradius);
  } else if(!scripts\mp\agents\zombie\zombie_util::func_8C39(var_1, self.var_B640)) {
    self scragentsetgoalradius(self.defaultgoalradius);
    var_11 = 1;
  } else {
    self scragentsetgoalradius(var_3);

    if(var_10 <= var_4) {
      var_7.origin = self.origin;
      var_11 = 1;
    }
  }

  if(var_11) {
    var_2 = getclosestpointonnavmesh(var_7.origin);

    if(distancesquared(var_2, var_7.origin) > 10000) {
      return anim.failure;
    }

    self scragentsetgoalpos(var_2);
  }

  return anim.success;
}

seekenemydlc1(var_0) {
  if(isDefined(self.dontseekenemies)) {
    return anim.failure;
  }

  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.ignoreme || isDefined(var_3.owner) && var_3.owner.ignoreme) {
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
    var_7 = distancesquared(var_5[0].origin, self.origin);

    if(var_7 < var_6 * var_6) {
      var_6 = 16;
    }

    var_8 = var_6 * var_6;

    if(self.var_2AB8 || distancesquared(self ghosthide(), var_5[0].origin) > var_8) {
      var_9 = isDefined(var_5[0].zipline);
      var_10 = var_5[0].origin;

      if(var_9) {
        var_10 = var_5[0].zipline.traversal_end;
      }

      var_11 = getclosestpointonnavmesh(var_10, self);

      if(!var_9 && distancesquared(var_11, var_5[0].origin) > var_8) {
        return anim.failure;
      }

      self scragentsetgoalpos(var_11);
      self.var_2AB8 = 0;
    }

    scripts\asm\asm_bb::bb_setisincombat(1);
    return anim.success;
  }

  return anim.failure;
}