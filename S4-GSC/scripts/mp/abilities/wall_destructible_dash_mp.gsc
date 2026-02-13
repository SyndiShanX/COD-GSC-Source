/**************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\abilities\wall_destructible_dash_mp.gsc
**************************************************************/

playerbashmonitorcoremp() {
  if(isplayerdashingmp()) {
    var_0 = _func_03C0("destructiblewall", "targetname", self getEye(), 175);

    foreach(var_2 in var_0) {
      var_2 _id_090B::_id_D8C2();
      var_3 = var_2 _meth_8575("main_part", 1);

      if(isDefined(var_3) && var_3 == "no_more_collmap") {
        continue;
      }
      var_4 = _id_090B::destructiblewalliswithinrange2d(var_2, 48);

      if(!var_4) {
        continue;
      }
      var_5 = isfacingwallmp(var_2);

      if(!var_5) {
        continue;
      }
      var_6 = _id_090B::destructiblewalliswithinrange3d(var_2, 60);

      if(var_6) {
        var_2 dealdamagemp(self);
        var_7 = gettime();

        if(isDefined(level._id_6016["createGameTypeChallenegeEvent"]) && !isDefined(self.lastdestroyedwalltime) || isDefined(self.lastdestroyedwalltime) && self.lastdestroyedwalltime != var_7) {
          scripts\engine\utility::_id_CD61("createGameTypeChallenegeEvent", "destroyWall");
        }

        self.lastdestroyedwalltime = gettime();
      }
    }
  }
}

isfacingwallmp(var_0) {
  var_1 = undefined;
  var_2 = vectornormalize(var_0._id_109BB - self getEye());
  var_3 = scripts\engine\utility::_id_5CDB(anglesToForward(self.angles));
  var_4 = vectordot(var_3, scripts\engine\utility::_id_5CDB(var_2));

  if(var_0.specialbreakcondition) {
    var_1 = vectordot(var_3, scripts\engine\utility::_id_5CDB(anglestoright(var_0.angles)));
  } else {
    var_1 = vectordot(var_3, scripts\engine\utility::_id_5CDB(anglesToForward(var_0.angles)));
  }

  return var_4 > var_0.fwddotcenter && abs(var_1) > 0.75;
}

isplayerdashingmp() {
  if(!isalive(self)) {
    return 0;
  }

  var_0 = self getvelocity();
  var_1 = length(var_0);

  if(var_1 > 200 && (self _meth_86CF() || self issprintsliding() || self issprinting())) {
    return 1;
  } else if(self _meth_846A() && var_1 > 250) {
    return 1;
  }

  return 0;
}

dealdamagemp(var_0) {
  var_0 playrumbleonentity("heavy_2s");
  var_0 earthquakeforplayer(0.65, 0.6, var_0.origin, 200);
  self setscriptablepartstate("main_part", "no_more_collmap");
  var_0 notify("wall_break");
  level notify("wall_broken");
}