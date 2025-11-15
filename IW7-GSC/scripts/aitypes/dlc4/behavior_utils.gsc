/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\behavior_utils.gsc
***************************************************/

pickbetterenemy(param_00, param_01) {
  var_02 = self getpersstat(param_00);
  var_03 = self getpersstat(param_01);
  if(var_02 != var_03) {
    if(var_02) {
      return param_00;
    }

    return param_01;
  }

  var_04 = distancesquared(self.origin, param_00.origin);
  var_05 = distancesquared(self.origin, param_01.origin);
  if(var_04 < var_05) {
    return param_00;
  }

  return param_01;
}

shouldignoreenemy(param_00) {
  if(!isalive(param_00)) {
    return 1;
  }

  if(param_00.ignoreme || isDefined(param_00.triggerportableradarping) && param_00.triggerportableradarping.ignoreme) {
    return 1;
  }

  if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(param_00)) {
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

  var_00 = undefined;
  foreach(var_02 in level.players) {
    if(shouldignoreenemy(var_02)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_02.isfasttravelling)) {
      continue;
    }

    if(!isDefined(var_00)) {
      var_00 = var_02;
      continue;
    }

    var_00 = pickbetterenemy(var_00, var_02);
  }

  if(!isDefined(var_00)) {
    self.myenemy = undefined;
    return undefined;
  }

  if(!isDefined(self.myenemy) || var_00 != self.myenemy) {
    self.myenemy = var_00;
    self.myenemystarttime = gettime();
  }
}

getpredictedenemypos(param_00, param_01) {
  var_02 = param_00 getvelocity();
  var_03 = length2d(var_02);
  var_04 = param_00.origin + var_02 * param_01;
  return var_04;
}

facepoint(param_00) {
  var_01 = scripts\engine\utility::getyawtospot(param_00);
  if(abs(var_01) < 8) {
    var_02 = (self.angles[0], self.angles[1] + var_01, self.angles[2]);
    self orientmode("face angle abs", var_02);
    return;
  }

  self.desiredyaw = var_02;
}