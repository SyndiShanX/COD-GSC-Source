/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3483.gsc
**************************************/

flares_monitor(var_0) {
  self.flaresreservecount = var_0;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
}

func_6EAE(var_0) {
  var_1 = "tag_origin";

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  playLoopSound(self gettagorigin(var_1), "ks_warden_flares");

  for(var_2 = 0; var_2 < 10; var_2++) {
    if(!isDefined(self)) {
      return;
    }
    playFXOnTag(level._effect["vehicle_flares"], self, var_1);
    wait 0.15;
  }
}

func_6EA0() {
  var_0 = spawn("script_origin", self.origin + (0, 0, -256));
  var_0.angles = self.angles;
  var_0 movegravity((0, 0, -1), 5.0);
  self.flareslive[self.flareslive.size] = var_0;
  var_0 thread func_6E9F(5.0, 2.0, self);
  playLoopSound(var_0.origin, "veh_helo_flares_npc");
  return var_0;
}

func_6E9F(var_0, var_1, var_2) {
  if(isDefined(var_1) && isDefined(var_2)) {
    var_0 = var_0 - var_1;
    wait(var_1);

    if(isDefined(var_2)) {
      var_2.flareslive = scripts\engine\utility::array_remove(var_2.flareslive, self);
    }
  }

  wait(var_0);
  self delete();
}

flares_getnumleft(var_0) {
  return var_0.flaresreservecount;
}

flares_areavailable(var_0) {
  flares_cleanflareslivearray(var_0);
  return var_0.flaresreservecount > 0 || var_0.flareslive.size > 0;
}

flares_getflarereserve(var_0) {
  var_0.flaresreservecount--;
  var_0 thread func_6EAE();
  var_1 = var_0 func_6EA0();
  return var_1;
}

flares_cleanflareslivearray(var_0) {
  var_0.flareslive = scripts\engine\utility::array_removeundefined(var_0.flareslive);
}

flares_getflarelive(var_0) {
  flares_cleanflareslivearray(var_0);
  var_1 = undefined;

  if(var_0.flareslive.size > 0) {
    var_1 = var_0.flareslive[var_0.flareslive.size - 1];
  }

  return var_1;
}

ks_laserguidedmissile_handleincoming() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areavailable(self)) {
    level waittill("laserGuidedMissiles_incoming", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }
    if(!isarray(var_1)) {
      var_1 = [var_1];
    }

    foreach(var_4 in var_1) {
      if(isvalidmissile(var_4)) {
        level thread ks_laserguidedmissile_monitorproximity(var_4, var_0, var_0.team, var_2);
      }
    }
  }
}

ks_laserguidedmissile_monitorproximity(var_0, var_1, var_2, var_3) {
  var_3 endon("death");
  var_0 endon("death");
  var_0 endon("missile_targetChanged");

  while(flares_areavailable(var_3)) {
    if(!isDefined(var_3) || !isvalidmissile(var_0)) {
      break;
    }
    var_4 = var_3 getpointinbounds(0, 0, 0);

    if(distancesquared(var_0.origin, var_4) < 4000000) {
      var_5 = flares_getflarelive(var_3);

      if(!isDefined(var_5)) {
        var_5 = flares_getflarereserve(var_3);
      }

      var_0 missile_settargetent(var_5);
      var_0 notify("missile_pairedWithFlare");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_6EAA(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("sam_fired", var_1, var_2, var_3);

    if(!isDefined(var_3) || var_3 != self) {
      continue;
    }
    if(isDefined(var_0)) {
      level thread[[var_0]](var_1, var_1.team, var_3, var_2);
      continue;
    }

    level thread func_6EB1(var_1, var_1.team, var_3, var_2);
  }
}

func_6EB1(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_2 endon("death");

  for(;;) {
    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = [];

    for(var_6 = 0; var_6 < var_3.size; var_6++) {
      if(isDefined(var_3[var_6])) {
        var_5[var_6] = distance(var_3[var_6].origin, var_4);
      }
    }

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(isDefined(var_5[var_6])) {
        if(var_5[var_6] < 4000 && var_2.flaresreservecount > 0) {
          var_2.flaresreservecount--;
          var_2 thread func_6EAE();
          var_7 = var_2 func_6EA0();

          for(var_8 = 0; var_8 < var_3.size; var_8++) {
            if(isDefined(var_3[var_8])) {
              var_3[var_8] missile_settargetent(var_7);
              var_3[var_8] notify("missile_pairedWithFlare");
            }
          }

          return;
        }
      }
    }

    wait 0.05;
  }
}

func_6EAB(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("stinger_fired", var_2, var_3, var_4);

    if(!isDefined(var_4) || var_4 != self) {
      continue;
    }
    if(isDefined(var_0)) {
      var_3 thread[[var_0]](var_2, var_2.team, var_4, var_1);
      continue;
    }

    var_3 thread func_6EB2(var_2, var_2.team, var_4, var_1);
  }
}

func_6EB2(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }
    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      var_2.flaresreservecount--;
      var_2 thread func_6EAE(var_3);
      var_6 = var_2 func_6EA0();
      self missile_settargetent(var_6);
      self notify("missile_pairedWithFlare");
      return;
    }

    wait 0.05;
  }
}

func_A730(var_0, var_1, var_2, var_3) {
  self.flaresreservecount = var_0;
  self.flareslive = [];

  if(isDefined(var_2)) {
    self.owner setclientomnvar(var_2, var_0);
  }

  thread func_A72F(var_1, var_2);
  thread func_A72D(var_3);
}

func_A72F(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  if(!isai(self.owner)) {
    self.owner notifyonplayercommand("manual_flare_popped", var_0);
  }

  while(flares_getnumleft(self)) {
    self.owner waittill("manual_flare_popped");
    var_2 = flares_getflarereserve(self);

    if(isDefined(var_2) && isDefined(self.owner) && !isai(self.owner)) {
      self.owner playlocalsound("veh_helo_flares_plr");

      if(isDefined(var_1)) {
        self.owner setclientomnvar(var_1, flares_getnumleft(self));
      }
    }
  }
}

func_A72D(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areavailable(self)) {
    self waittill("targeted_by_incoming_missile", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    self.owner playlocalsound("missile_incoming");
    self.owner thread ks_watch_death_stop_sound(self, "missile_incoming");

    if(isDefined(var_0)) {
      var_2 = vectornormalize(var_1[0].origin - self.origin);
      var_3 = vectornormalize(anglestoright(self.angles));
      var_4 = vectordot(var_2, var_3);
      var_5 = 1;

      if(var_4 > 0) {
        var_5 = 2;
      } else if(var_4 < 0) {
        var_5 = 3;
      }

      self.owner setclientomnvar(var_0, var_5);
    }

    foreach(var_7 in var_1) {
      if(isvalidmissile(var_7)) {
        thread func_A72E(var_7);
      }
    }
  }
}

func_A72E(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    if(!isDefined(self) || !isvalidmissile(var_0)) {
      break;
    }
    var_1 = self getpointinbounds(0, 0, 0);

    if(distancesquared(var_0.origin, var_1) < 4000000) {
      var_2 = flares_getflarelive(self);

      if(isDefined(var_2)) {
        var_0 missile_settargetent(var_2);
        var_0 notify("missile_pairedWithFlare");
        self.owner stopolcalsound("missile_incoming");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

ks_watch_death_stop_sound(var_0, var_1) {
  self endon("disconnect");
  var_0 waittill("death");
  self stopolcalsound(var_1);
}