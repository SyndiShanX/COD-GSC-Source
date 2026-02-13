/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2315.gsc
*************************************************/

_id_D8C2() {
  if(isDefined(self._id_109BB)) {
    return;
  }
  self._id_91A8 = 32;
  self.height = 32;
  self.specialbreakcondition = 0;
  self.fwddotcenter = 0.66;

  switch (self._id_039B) {
    case "dest32x120a":
      self._id_109BB = self.origin + anglestoright(self.angles) * self._id_91A8 * 1.8 + anglestoup(self.angles) * self.height;
      break;
    case "dest32x120b":
      self._id_109BB = self.origin + anglestoright(self.angles) * self._id_91A8 + anglestoup(self.angles) * self.height;
      break;
    case "dest32x120c":
      self._id_109BB = self.origin + anglestoup(self.angles) * self.height;
      break;
    case "dest32x120d":
      self._id_109BB = self.origin + anglestoleft(self.angles) * self._id_91A8 * 0.8 + anglestoup(self.angles) * self.height;
      break;
    case "dest32x120a2":
      self.height = 75;
      self._id_109BB = self.origin + anglestoright(self.angles) * self._id_91A8 * 1.8 + anglestoup(self.angles) * self.height;
      break;
    case "dest32x120b2":
      self.height = 75;
      self._id_109BB = self.origin + anglestoright(self.angles) * self._id_91A8 + anglestoup(self.angles) * self.height;
      break;
    case "dest32x120c2":
      self.height = 64;
      self._id_109BB = self.origin + anglestoup(self.angles) * self.height;
      break;
    case "dest32x120d2":
      self.height = 75;
      self._id_109BB = self.origin + anglestoleft(self.angles) * self._id_91A8 * 0.8 + anglestoup(self.angles) * self.height;
      break;
    case "dest64x120a":
      self._id_91A8 = 64;
      self._id_109BB = self.origin + anglestoright(self.angles) * self._id_91A8 * 0.7 + anglestoup(self.angles) * self.height;
      break;
    case "dest64x120b":
      self._id_91A8 = 64;
      self._id_109BB = self.origin + anglestoleft(self.angles) * self._id_91A8 * 0.2 + anglestoup(self.angles) * self.height;
      break;
    case "dest64x120a2":
      self._id_91A8 = 64;
      self.height = 90;
      self._id_109BB = self.origin + anglestoright(self.angles) * self._id_91A8 * 0.7 + anglestoup(self.angles) * self.height;
      break;
    case "dest64x120b2":
      self._id_91A8 = 64;
      self.height = 90;
      self._id_109BB = self.origin + anglestoleft(self.angles) * self._id_91A8 * 0.2 + anglestoup(self.angles) * self.height;
      break;
    case "dest64x64a":
      self._id_91A8 = 64;
      self._id_109BB = self.origin + anglesToForward(self.angles) * self._id_91A8 * 0.5 + anglestoup(self.angles) * self.height;
      self.specialbreakcondition = 1;
      break;
    case "dest64x64b":
      self._id_91A8 = 64;
      self._id_109BB = self.origin - anglesToForward(self.angles) * self._id_91A8 * 0.5 + anglestoup(self.angles) * self.height;
      self.specialbreakcondition = 1;
      break;
    case "dest64x64a2":
      self._id_91A8 = 64;
      self.height = 90;
      self._id_109BB = self.origin + anglesToForward(self.angles) * self._id_91A8 * 0.5 + anglestoup(self.angles) * self.height;
      self.specialbreakcondition = 1;
      break;
    case "dest64x64b2":
      self._id_91A8 = 64;
      self.height = 90;
      self._id_109BB = self.origin - anglesToForward(self.angles) * self._id_91A8 * 0.5 + anglestoup(self.angles) * self.height;
      self.specialbreakcondition = 1;
      break;
    case "s4_jpn_fence_staked_128x48":
      self._id_91A8 = 48;
      self.height = 48;
      self._id_109BB = self.origin - anglesToForward(self.angles) * self._id_91A8 * 0.5 + anglestoup(self.angles) * self.height;
      self.specialbreakcondition = 1;
      self.fwddotcenter = 0.4;
      break;
    case "s4_jpn_fence_staked_32x48":
      self._id_91A8 = 48;
      self.height = 48;
      self._id_109BB = self.origin - anglesToForward(self.angles) * self._id_91A8 * 0.5 + anglestoup(self.angles) * self.height;
      self.specialbreakcondition = 1;
      self.fwddotcenter = 0.4;
      break;
    case "s4_window_slats_56x80":
    case "s4_window_slats_single_wide":
    case "s4_window_slats_36x36":
    case "s4_window_slats_48x72":
      self.specialbreakcondition = 1;
      self._id_109BB = self.origin;
      break;
    case "default":
      self._id_109BB = self.origin;
      break;
  }
}

_id_B665() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    if(!isDefined(self)) {
      continue;
    }
    if(!isalive(self)) {
      continue;
    }
    playerbashmonitorcoresp();
    waitframe();
  }
}

playerbashmonitorcoresp() {
  if(isplayerdashing()) {
    var_0 = _func_03C0("destructiblewall", "targetname", self getEye(), 175);

    foreach(var_2 in var_0) {
      var_2 _id_D8C2();
      var_3 = var_2 _meth_8575("main_part", 1);

      if(isDefined(var_3) && var_3 == "no_more_collmap") {
        continue;
      }
      var_4 = destructiblewalliswithinrange2d(var_2, 48);

      if(!var_4) {
        continue;
      }
      var_5 = _id_884B(var_2);

      if(!var_5) {
        continue;
      }
      var_6 = destructiblewalliswithinrange3d(var_2, 60);

      if(var_6) {
        var_2 _id_43A6(self);
        var_7 = gettime();

        if(isDefined(level._id_6016["createGameTypeChallenegeEvent"]) && !isDefined(self.lastdestroyedwalltime) || isDefined(self.lastdestroyedwalltime) && self.lastdestroyedwalltime != var_7) {
          scripts\engine\utility::_id_CD61("createGameTypeChallenegeEvent", "destroyWall");
        }

        self.lastdestroyedwalltime = gettime();
      }
    }
  }
}

_id_884B(var_0) {
  var_1 = undefined;
  var_2 = vectornormalize(var_0._id_109BB - self getEye());
  var_3 = scripts\engine\utility::_id_5CDB(anglesToForward(self.angles));
  var_4 = vectordot(var_3, scripts\engine\utility::_id_5CDB(var_2));

  if(var_0.specialbreakcondition) {
    var_1 = vectordot(var_3, scripts\engine\utility::_id_5CDB(anglestoright(var_0.angles)));
  } else {
    var_1 = vectordot(var_3, scripts\engine\utility::_id_5CDB(anglesToForward(var_0.angles)));
  }

  return var_4 > 0.66 && abs(var_1) > 0.75;
}

isplayerdashing() {
  if(!isalive(self)) {
    return 0;
  }

  var_0 = self getvelocity();
  var_1 = length(var_0);

  if(var_1 > 200 && (self _meth_86CF() || self issprintsliding())) {
    return 1;
  } else if(self _meth_846A() && var_1 > 250) {
    return 1;
  }

  return 0;
}

destructiblewalliswithinrange2d(var_0, var_1) {
  var_2 = distance2dsquared(self.origin, var_0._id_109BB);
  var_3 = var_1 * var_1;
  return var_2 < var_3;
}

destructiblewalliswithinrange3d(var_0, var_1) {
  var_2 = self.origin + (0, 0, self _meth_8172());
  var_3 = distancesquared(var_2, var_0._id_109BB);
  var_4 = var_1 * var_1;
  return var_3 < var_4;
}

_id_43A6(var_0) {
  var_0 playrumbleonentity("heavy_2s");
  var_0 earthquakeforplayer(0.65, 0.6, var_0.origin, 200);
  self setscriptablepartstate("main_part", "no_more_collmap");
  var_0 notify("wall_break");
  level notify("wall_broken");
}