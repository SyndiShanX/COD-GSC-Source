/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_flares.gsc
***********************************************/

function flares_monitor(var0) {
  self.flaresreservecount = var0;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
}

function flares_playFX(var0) {
  var1 = "tag_origin";

  if(isDefined(var0)) {
    var1 = var0;
  }

  playsoundatpos(self gettagorigin(var1), "ks_apache_flares");
  playFXOnTag(level._effect["vehicle_flares"], self, var1);
}

function flares_deploy() {
  var0 = spawn("script_origin", self.origin + (0, 0, -256));
  var0.angles = self.angles;
  var0 movegravity((0, 0, -1), 5);
  self.flareslive[self.flareslive.size] = var0;
  thread flares_deleteaftertime(var0, 5, 2);
  playsoundatpos(var0.origin, "ks_ac130_flares");
  return var0;
}

function flares_deleteaftertime(var0, var1, var2) {
  if(isDefined(var1) && isDefined(var2)) {
    var0 -= var1;
    wait var1;

    if(isDefined(var2)) {
      var2.flareslive = scripts\engine\utility::array_remove(var2.flareslive, self);
    }
  }

  wait var0;
  self delete();
}

function flares_getnumleft(var0) {
  return var0.flaresreservecount;
}

function flares_areavailable(var0) {
  flares_cleanflareslivearray(var0);
  return var0.flaresreservecount > 0 || var0.flareslive.size > 0;
}

function flares_getflarereserve(var0) {
  flares_reducereserves(var0);
  thread flares_playFX();
  var1 = flares_deploy(var0);
  return var1;
}

function flares_cleanflareslivearray(var0) {
  var0.flareslive = scripts\engine\utility::array_removeundefined(var0.flareslive);
}

function flares_getflarelive(var0) {
  flares_cleanflareslivearray(var0);
  var1 = undefined;

  if(var0.flareslive.size > 0) {
    var1 = var0.flareslive[var0.flareslive.size - 1];
  }

  return var1;
}

function ks_laserguidedmissile_handleincoming() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areavailable(self)) {
    level waittill("laserGuidedMissiles_incoming", var0, var1, var2);

    if(!isDefined(var2) || var2 != self) {
      continue;
    }

    if(!isarray(var1)) {
      var1 = [var1];
    }

    foreach(var4 in var1) {
      if(isvalidmissile(var4)) {
        thread ks_laserguidedmissile_monitorproximity(level, var4, var0, var0.team);
      }
    }
  }
}

function ks_laserguidedmissile_monitorproximity(var0, var1, var2, var3) {
  var3 endon("death");
  var0 endon("death");
  var0 endon("missile_targetChanged");

  while(flares_areavailable(var3)) {
    if(!isDefined(var3) || !isvalidmissile(var0)) {
      break;
    }

    var4 = var3 getpointinbounds(0, 0, 0);

    if(distancesquared(var0.origin, var4) < 4000000) {
      var5 = flares_getflarelive(var3);

      if(!isDefined(var5)) {
        var5 = flares_getflarereserve(var3);
      }

      var0 missile_settargetEnt(var5);
      var0 notify("missile_pairedWithFlare");
      break;
    }

    waitframe();
  }
}

function flares_handleincomingsam(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("sam_fired", var1, var2, var3);

    if(!isDefined(var3) || var3 != self) {
      continue;
    }

    if(isDefined(var0)) {
      level thread[[var0]](var1, var1.team, var3, var2);
      continue;
    }

    thread flares_watchsamproximity(level, var1, var1.team, var3);
  }
}

function flares_watchsamproximity(var0, var1, var2, var3) {
  level endon("game_ended");
  var2 endon("death");

  for(;;) {
    var4 = var2 getpointinbounds(0, 0, 0);
    var5 = [];

    for(var6 = 0; var6 < var3.size; var6++) {
      if(isDefined(var3[var6])) {
        var5 = distance(var3[var6].origin, var4);
      }
    }

    var6 = 0;

    while(var6 < var5.size) {
      if(isDefined(var5[var6])) {
        if(var5[var6] < 4000 && var2.flaresreservecount > 0) {
          flares_reducereserves(var2);
          thread flares_playFX();
          var7 = flares_deploy(var2);

          for(var8 = 0; var8 < var3.size; var8++) {
            if(isDefined(var3[var8])) {
              var3[var8] missile_settargetEnt(var7);
              var3[var8] notify("missile_pairedWithFlare");
            }
          }

          return;
        }
      }

      var8++;
    }

    waitframe();
  }
}

function flares_handleincomingstinger(var0, var1) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("stinger_fired", var2, var3, var4);

    if(!isDefined(var4) || var4 != self) {
      continue;
    }

    if(isDefined(var0)) {
      var3 thread[[var0]](var2, var2.team, var4, var1);
      continue;
    }

    thread flares_watchstingerproximity(var3, var2, var2.team, var4);
  }
}

function flares_watchstingerproximity(var0, var1, var2, var3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var2)) {
      break;
    }

    var4 = var2 getpointinbounds(0, 0, 0);
    var5 = distance(self.origin, var4);

    if(var5 < 4000 && var2.flaresreservecount > 0) {
      flares_reducereserves(var2);
      thread flares_playFX(var2);
      var6 = flares_deploy(var2);
      self missile_settargetEnt(var6);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function flares_reducereserves(var0) {
  var0.flaresreservecount--;

  if(isDefined(var0.owner) && isPlayer(var0.owner)) {
    var0.owner setclientomnvar("ui_killstreak_flares", var0.flaresreservecount);
    return;
  }
}

function ks_setup_manual_flares(var0, var1, var2, var3) {
  self.flaresreservecount = var0;
  self.flareslive = [];

  if(isDefined(var2) && isPlayer(self.owner)) {
    self.owner setclientomnvar(var2, var0);
  }

  thread ks_manualflares_watchuse(var1, var2);
  thread ks_manualflares_handleincoming(var3);
}

function ks_manualflares_watchuse(var0, var1) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");
  jumpiftrue(isai(self.owner)) LOC_00000041;
  self.owner notifyonplayercommand("manual_flare_popped", var0);

  while(flares_getnumleft(self)) {
    self.owner waittill("manual_flare_popped");
    var2 = flares_getflarereserve(self);

    if(isDefined(var2) && isDefined(self.owner) && !isai(self.owner)) {
      self.owner playlocalsound("ks_ac130_flares");

      if(isDefined(var1)) {
        self.owner setclientomnvar(var1, flares_getnumleft(self));
      }
    }
  }
}

function ks_manualflares_handleincoming(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areavailable(self)) {
    self waittill("targeted_by_incoming_missile", var1);

    if(!isDefined(var1)) {
      continue;
    }

    if(isDefined(self.owner) && isPlayer(self.owner)) {
      thread ks_watch_death_stop_sound(self.owner, self);

      if(isDefined(var0)) {
        var2 = vectorNormalize(var1[0].origin - self.origin);
        var3 = vectorNormalize(anglestoright(self.angles));
        var4 = vectordot(var2, var3);
        var5 = 1;

        if(var4 > 0) {
          var5 = 2;
        } else if(var4 < 0) {
          var5 = 3;
        }

        self.owner setclientomnvar(var0, var5);
      }
    }

    foreach(var7 in var1) {
      if(isvalidmissile(var7)) {
        thread ks_manualflares_monitorproximity(var7);
      }
    }
  }
}

function ks_manualflares_monitorproximity(var0) {
  self endon("death");
  var0 endon("death");

  for(;;) {
    if(!isDefined(self) || !isvalidmissile(var0)) {
      break;
    }

    var1 = self getpointinbounds(0, 0, 0);

    if(distancesquared(var0.origin, var1) < 4000000) {
      var2 = flares_getflarelive(self);

      if(isDefined(var2)) {
        var0 missile_settargetEnt(var2);
        var0 notify("missile_pairedWithFlare");

        if(isDefined(self.owner) && isPlayer(self.owner)) {
          self.owner stoplocalsound("missile_incoming");
        }

        break;
      }
    }

    waitframe();
  }
}

function ks_watch_death_stop_sound(var0, var1) {
  self endon("disconnect");
  var0 waittill("death");
  self stoplocalsound(var1);
}