/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_flares.gsc
***********************************************/

function flares_monitor(var_0) {
  self.flaresreservecount = var_0;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
}

function flares_playFX(var_0) {
  var_1 = "tag_origin";

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  playsoundatpos(self gettagorigin(var_1), "ks_apache_flares");
  playFXOnTag(level._effect["vehicle_flares"], self, var_1);
}

function flares_deploy() {
  var_0 = spawn("script_origin", self.origin + (0, 0, -256));
  var_0.angles = self.angles;
  var_0 movegravity((0, 0, -1), 5);
  self.flareslive[self.flareslive.size] = var_0;
  thread flares_deleteaftertime(var_0, 5, 2);
  playsoundatpos(var_0.origin, "ks_ac130_flares");
  return var_0;
}

function flares_deleteaftertime(var_0, var_1, var_2) {
  if(isDefined(var_1) && isDefined(var_2)) {
    var_0 -= var_1;
    wait var_1;

    if(isDefined(var_2)) {
      var_2.flareslive = scripts\engine\utility::array_remove(var_2.flareslive, self);
    }
  }

  wait var_0;
  self delete();
}

function flares_getnumleft(var_0) {
  return var_0.flaresreservecount;
}

function flares_areavailable(var_0) {
  flares_cleanflareslivearray(var_0);
  return var_0.flaresreservecount > 0 || var_0.flareslive.size > 0;
}

function flares_getflarereserve(var_0) {
  flares_reducereserves(var_0);
  thread flares_playFX();
  var_1 = flares_deploy(var_0);
  return var_1;
}

function flares_cleanflareslivearray(var_0) {
  var_0.flareslive = scripts\engine\utility::array_removeundefined(var_0.flareslive);
}

function flares_getflarelive(var_0) {
  flares_cleanflareslivearray(var_0);
  var_1 = undefined;

  if(var_0.flareslive.size > 0) {
    var_1 = var_0.flareslive[var_0.flareslive.size - 1];
  }

  return var_1;
}

function ks_laserguidedmissile_handleincoming() {
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
        thread ks_laserguidedmissile_monitorproximity(level, var_4, var_0, var_0.team);
      }
    }
  }
}

function ks_laserguidedmissile_monitorproximity(var_0, var_1, var_2, var_3) {
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

      var_0 missile_settargetEnt(var_5);
      var_0 notify("missile_pairedWithFlare");
      break;
    }

    waitframe();
  }
}

function flares_handleincomingsam(var_0) {
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

    thread flares_watchsamproximity(level, var_1, var_1.team, var_3);
  }
}

function flares_watchsamproximity(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_2 endon("death");

  for(;;) {
    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = [];

    for(var_6 = 0; var_6 < var_3.size; var_6++) {
      if(isDefined(var_3[var_6])) {
        var_5 = distance(var_3[var_6].origin, var_4);
      }
    }

    var_6 = 0;

    while(var_6 < var_5.size) {
      if(isDefined(var_5[var_6])) {
        if(var_5[var_6] < 4000 && var_2.flaresreservecount > 0) {
          flares_reducereserves(var_2);
          thread flares_playFX();
          var_7 = flares_deploy(var_2);

          for(var_8 = 0; var_8 < var_3.size; var_8++) {
            if(isDefined(var_3[var_8])) {
              var_3[var_8] missile_settargetEnt(var_7);
              var_3[var_8] notify("missile_pairedWithFlare");
            }
          }

          return;
        }
      }

      var_8++;
    }

    waitframe();
  }
}

function flares_handleincomingstinger(var_0, var_1) {
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

    thread flares_watchstingerproximity(var_3, var_2, var_2.team, var_4);
  }
}

function flares_watchstingerproximity(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      flares_reducereserves(var_2);
      thread flares_playFX(var_2);
      var_6 = flares_deploy(var_2);
      self missile_settargetEnt(var_6);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function flares_reducereserves(var_0) {
  var_0.flaresreservecount--;

  if(isDefined(var_0.owner) && isPlayer(var_0.owner)) {
    var_0.owner setclientomnvar("ui_killstreak_flares", var_0.flaresreservecount);
    return;
  }
}

function ks_setup_manual_flares(var_0, var_1, var_2, var_3) {
  self.flaresreservecount = var_0;
  self.flareslive = [];

  if(isDefined(var_2) && isPlayer(self.owner)) {
    self.owner setclientomnvar(var_2, var_0);
  }

  thread ks_manualflares_watchuse(var_1, var_2);
  thread ks_manualflares_handleincoming(var_3);
}

function ks_manualflares_watchuse(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");
  jumpiftrue(isai(self.owner)) LOC_00000041;
  self.owner notifyonplayercommand("manual_flare_popped", var_0);

  while(flares_getnumleft(self)) {
    self.owner waittill("manual_flare_popped");
    var_2 = flares_getflarereserve(self);

    if(isDefined(var_2) && isDefined(self.owner) && !isai(self.owner)) {
      self.owner playlocalsound("ks_ac130_flares");

      if(isDefined(var_1)) {
        self.owner setclientomnvar(var_1, flares_getnumleft(self));
      }
    }
  }
}

function ks_manualflares_handleincoming(var_0) {
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

    if(isDefined(self.owner) && isPlayer(self.owner)) {
      thread ks_watch_death_stop_sound(self.owner, self);

      if(isDefined(var_0)) {
        var_2 = vectorNormalize(var_1[0].origin - self.origin);
        var_3 = vectorNormalize(anglestoright(self.angles));
        var_4 = vectordot(var_2, var_3);
        var_5 = 1;

        if(var_4 > 0) {
          var_5 = 2;
        } else if(var_4 < 0) {
          var_5 = 3;
        }

        self.owner setclientomnvar(var_0, var_5);
      }
    }

    foreach(var_7 in var_1) {
      if(isvalidmissile(var_7)) {
        thread ks_manualflares_monitorproximity(var_7);
      }
    }
  }
}

function ks_manualflares_monitorproximity(var_0) {
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
        var_0 missile_settargetEnt(var_2);
        var_0 notify("missile_pairedWithFlare");

        if(isDefined(self.owner) && isPlayer(self.owner)) {
          self.owner stoplocalsound("missile_incoming");
        }

        break;
      }
    }

    waitframe();
  }
}

function ks_watch_death_stop_sound(var_0, var_1) {
  self endon("disconnect");
  var_0 waittill("death");
  self stoplocalsound(var_1);
}