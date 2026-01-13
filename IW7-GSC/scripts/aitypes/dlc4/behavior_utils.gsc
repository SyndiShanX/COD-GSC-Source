/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\behavior_utils.gsc
***************************************************/

pickbetterenemy(var_0, var_1) {
  var_2 = self getpersstat(var_0);
  var_3 = self getpersstat(var_1);
  if(var_2 != var_3) {
    if(var_2) {
      return var_0;
    }

    return var_1;
  }

  var_4 = distancesquared(self.origin, var_0.origin);
  var_5 = distancesquared(self.origin, var_1.origin);
  if(var_4 < var_5) {
    return var_0;
  }

  return var_1;
}

shouldignoreenemy(var_0) {
  if(!isalive(var_0)) {
    return 1;
  }

  if(var_0.ignoreme || isDefined(var_0.triggerportableradarping) && var_0.triggerportableradarping.ignoreme) {
    return 1;
  }

  if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_0)) {
    return 1;
  }

  return 0;
}

updateenemy() {
  if(isDefined(self.myenemy) && !shouldignoreenemy(self.myenemy)) {
    if(gettime() - self.myenemystarttime < 3000) {
      return self.myenemy;
    }
  }

  var_0 = undefined;
  foreach(var_2 in level.players) {
    if(shouldignoreenemy(var_2)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.isfasttravelling)) {
      continue;
    }

    if(!isDefined(var_0)) {
      var_0 = var_2;
      continue;
    }

    var_0 = pickbetterenemy(var_0, var_2);
  }

  if(!isDefined(var_0)) {
    self.myenemy = undefined;
    return undefined;
  }

  if(!isDefined(self.myenemy) || var_0 != self.myenemy) {
    self.myenemy = var_0;
    self.myenemystarttime = gettime();
  }
}

getpredictedenemypos(var_0, var_1) {
  var_2 = var_0 getvelocity();
  var_3 = length2d(var_2);
  var_4 = var_0.origin + var_2 * var_1;
  return var_4;
}

facepoint(var_0) {
  var_1 = scripts\engine\utility::getyawtospot(var_0);
  if(abs(var_1) < 8) {
    var_2 = (self.angles[0], self.angles[1] + var_1, self.angles[2]);
    self orientmode("face angle abs", var_2);
    return;
  }

  self.desiredyaw = var_2;
}