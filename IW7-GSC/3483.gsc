/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3483.gsc
***************************************/

flares_monitor(var_00) {
  self.flaresreservecount = var_00;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
}

func_6EAE(var_00) {
  var_01 = "tag_origin";

  if(isDefined(var_00)) {
    var_01 = var_00;
  }

  playLoopSound(self gettagorigin(var_01), "ks_warden_flares");

  for(var_02 = 0; var_02 < 10; var_2++) {
    if(!isDefined(self)) {
      return;
    }
    playFXOnTag(level._effect["vehicle_flares"], self, var_01);
    wait 0.15;
  }
}

func_6EA0() {
  var_00 = spawn("script_origin", self.origin + (0, 0, -256));
  var_0.angles = self.angles;
  var_00 movegravity((0, 0, -1), 5.0);
  self.flareslive[self.flareslive.size] = var_00;
  var_00 thread func_6E9F(5.0, 2.0, self);
  playLoopSound(var_0.origin, "veh_helo_flares_npc");
  return var_00;
}

func_6E9F(var_00, var_01, var_02) {
  if(isDefined(var_01) && isDefined(var_02)) {
    var_00 = var_00 - var_01;
    wait(var_01);

    if(isDefined(var_02)) {
      var_2.flareslive = scripts\engine\utility::array_remove(var_2.flareslive, self);
    }
  }

  wait(var_00);
  self delete();
}

flares_getnumleft(var_00) {
  return var_0.flaresreservecount;
}

flares_areavailable(var_00) {
  flares_cleanflareslivearray(var_00);
  return var_0.flaresreservecount > 0 || var_0.flareslive.size > 0;
}

flares_getflarereserve(var_00) {
  var_0.flaresreservecount--;
  var_00 thread func_6EAE();
  var_01 = var_00 func_6EA0();
  return var_01;
}

flares_cleanflareslivearray(var_00) {
  var_0.flareslive = scripts\engine\utility::array_removeundefined(var_0.flareslive);
}

flares_getflarelive(var_00) {
  flares_cleanflareslivearray(var_00);
  var_01 = undefined;

  if(var_0.flareslive.size > 0) {
    var_01 = var_0.flareslive[var_0.flareslive.size - 1];
  }

  return var_01;
}

ks_laserguidedmissile_handleincoming() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areavailable(self)) {
    level waittill("laserGuidedMissiles_incoming", var_00, var_01, var_02);

    if(!isDefined(var_02) || var_02 != self) {
      continue;
    }
    if(!isarray(var_01)) {
      var_01 = [var_01];
    }

    foreach(var_04 in var_01) {
      if(isvalidmissile(var_04)) {
        level thread ks_laserguidedmissile_monitorproximity(var_04, var_00, var_0.team, var_02);
      }
    }
  }
}

ks_laserguidedmissile_monitorproximity(var_00, var_01, var_02, var_03) {
  var_03 endon("death");
  var_00 endon("death");
  var_00 endon("missile_targetChanged");

  while(flares_areavailable(var_03)) {
    if(!isDefined(var_03) || !isvalidmissile(var_00)) {
      break;
    }
    var_04 = var_03 getpointinbounds(0, 0, 0);

    if(distancesquared(var_0.origin, var_04) < 4000000) {
      var_05 = flares_getflarelive(var_03);

      if(!isDefined(var_05)) {
        var_05 = flares_getflarereserve(var_03);
      }

      var_00 missile_settargetent(var_05);
      var_00 notify("missile_pairedWithFlare");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_6EAA(var_00) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("sam_fired", var_01, var_02, var_03);

    if(!isDefined(var_03) || var_03 != self) {
      continue;
    }
    if(isDefined(var_00)) {
      level thread[[var_00]](var_01, var_1.team, var_03, var_02);
      continue;
    }

    level thread func_6EB1(var_01, var_1.team, var_03, var_02);
  }
}

func_6EB1(var_00, var_01, var_02, var_03) {
  level endon("game_ended");
  var_02 endon("death");

  for(;;) {
    var_04 = var_02 getpointinbounds(0, 0, 0);
    var_05 = [];

    for(var_06 = 0; var_06 < var_3.size; var_6++) {
      if(isDefined(var_3[var_06])) {
        var_5[var_06] = distance(var_3[var_06].origin, var_04);
      }
    }

    for(var_06 = 0; var_06 < var_5.size; var_6++) {
      if(isDefined(var_5[var_06])) {
        if(var_5[var_06] < 4000 && var_2.flaresreservecount > 0) {
          var_2.flaresreservecount--;
          var_02 thread func_6EAE();
          var_07 = var_02 func_6EA0();

          for(var_08 = 0; var_08 < var_3.size; var_8++) {
            if(isDefined(var_3[var_08])) {
              var_3[var_08] missile_settargetent(var_07);
              var_3[var_08] notify("missile_pairedWithFlare");
            }
          }

          return;
        }
      }
    }

    wait 0.05;
  }
}

func_6EAB(var_00, var_01) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("stinger_fired", var_02, var_03, var_04);

    if(!isDefined(var_04) || var_04 != self) {
      continue;
    }
    if(isDefined(var_00)) {
      var_03 thread[[var_00]](var_02, var_2.team, var_04, var_01);
      continue;
    }

    var_03 thread func_6EB2(var_02, var_2.team, var_04, var_01);
  }
}

func_6EB2(var_00, var_01, var_02, var_03) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_02)) {
      break;
    }
    var_04 = var_02 getpointinbounds(0, 0, 0);
    var_05 = distance(self.origin, var_04);

    if(var_05 < 4000 && var_2.flaresreservecount > 0) {
      var_2.flaresreservecount--;
      var_02 thread func_6EAE(var_03);
      var_06 = var_02 func_6EA0();
      self missile_settargetent(var_06);
      self notify("missile_pairedWithFlare");
      return;
    }

    wait 0.05;
  }
}

func_A730(var_00, var_01, var_02, var_03) {
  self.flaresreservecount = var_00;
  self.flareslive = [];

  if(isDefined(var_02)) {
    self.owner setclientomnvar(var_02, var_00);
  }

  thread func_A72F(var_01, var_02);
  thread func_A72D(var_03);
}

func_A72F(var_00, var_01) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  if(!isai(self.owner)) {
    self.owner notifyonplayercommand("manual_flare_popped", var_00);
  }

  while(flares_getnumleft(self)) {
    self.owner waittill("manual_flare_popped");
    var_02 = flares_getflarereserve(self);

    if(isDefined(var_02) && isDefined(self.owner) && !isai(self.owner)) {
      self.owner playlocalsound("veh_helo_flares_plr");

      if(isDefined(var_01)) {
        self.owner setclientomnvar(var_01, flares_getnumleft(self));
      }
    }
  }
}

func_A72D(var_00) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areavailable(self)) {
    self waittill("targeted_by_incoming_missile", var_01);

    if(!isDefined(var_01)) {
      continue;
    }
    self.owner playlocalsound("missile_incoming");
    self.owner thread ks_watch_death_stop_sound(self, "missile_incoming");

    if(isDefined(var_00)) {
      var_02 = vectornormalize(var_1[0].origin - self.origin);
      var_03 = vectornormalize(anglestoright(self.angles));
      var_04 = vectordot(var_02, var_03);
      var_05 = 1;

      if(var_04 > 0) {
        var_05 = 2;
      }
      else if(var_04 < 0) {
        var_05 = 3;
      }

      self.owner setclientomnvar(var_00, var_05);
    }

    foreach(var_07 in var_01) {
      if(isvalidmissile(var_07)) {
        thread func_A72E(var_07);
      }
    }
  }
}

func_A72E(var_00) {
  self endon("death");
  var_00 endon("death");

  for(;;) {
    if(!isDefined(self) || !isvalidmissile(var_00)) {
      break;
    }
    var_01 = self getpointinbounds(0, 0, 0);

    if(distancesquared(var_0.origin, var_01) < 4000000) {
      var_02 = flares_getflarelive(self);

      if(isDefined(var_02)) {
        var_00 missile_settargetent(var_02);
        var_00 notify("missile_pairedWithFlare");
        self.owner stopolcalsound("missile_incoming");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

ks_watch_death_stop_sound(var_00, var_01) {
  self endon("disconnect");
  var_00 waittill("death");
  self stopolcalsound(var_01);
}