/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_flares.gsc
**********************************************/

flares_monitor(param_00) {
  self.flaresreservecount = param_00;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
}

func_6EAE(param_00) {
  var_01 = "tag_origin";
  if(isDefined(param_00)) {
    var_01 = param_00;
  }

  playsoundatpos(self gettagorigin(var_01), "ks_warden_flares");
  for(var_02 = 0; var_02 < 10; var_02++) {
    if(!isDefined(self)) {
      return;
    }

    playFXOnTag(level._effect["vehicle_flares"], self, var_01);
    wait(0.15);
  }
}

func_6EA0() {
  var_00 = spawn("script_origin", self.origin + (0, 0, -256));
  var_00.angles = self.angles;
  var_00 movegravity((0, 0, -1), 5);
  self.flareslive[self.flareslive.size] = var_00;
  var_00 thread func_6E9F(5, 2, self);
  playsoundatpos(var_00.origin, "veh_helo_flares_npc");
  return var_00;
}

func_6E9F(param_00, param_01, param_02) {
  if(isDefined(param_01) && isDefined(param_02)) {
    param_00 = param_00 - param_01;
    wait(param_01);
    if(isDefined(param_02)) {
      param_02.flareslive = scripts\engine\utility::array_remove(param_02.flareslive, self);
    }
  }

  wait(param_00);
  self delete();
}

flares_getnumleft(param_00) {
  return param_00.flaresreservecount;
}

flares_areavailable(param_00) {
  flares_cleanflareslivearray(param_00);
  return param_00.flaresreservecount > 0 || param_00.flareslive.size > 0;
}

flares_getflarereserve(param_00) {
  param_00.flaresreservecount--;
  param_00 thread func_6EAE();
  var_01 = param_00 func_6EA0();
  return var_01;
}

flares_cleanflareslivearray(param_00) {
  param_00.flareslive = scripts\engine\utility::array_removeundefined(param_00.flareslive);
}

flares_getflarelive(param_00) {
  flares_cleanflareslivearray(param_00);
  var_01 = undefined;
  if(param_00.flareslive.size > 0) {
    var_01 = param_00.flareslive[param_00.flareslive.size - 1];
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
        level thread ks_laserguidedmissile_monitorproximity(var_04, var_00, var_00.team, var_02);
      }
    }
  }
}

ks_laserguidedmissile_monitorproximity(param_00, param_01, param_02, param_03) {
  param_03 endon("death");
  param_00 endon("death");
  param_00 endon("missile_targetChanged");
  while(flares_areavailable(param_03)) {
    if(!isDefined(param_03) || !isvalidmissile(param_00)) {
      break;
    }

    var_04 = param_03 getpointinbounds(0, 0, 0);
    if(distancesquared(param_00.origin, var_04) < 4000000) {
      var_05 = flares_getflarelive(param_03);
      if(!isDefined(var_05)) {
        var_05 = flares_getflarereserve(param_03);
      }

      param_00 missile_settargetent(var_05);
      param_00 notify("missile_pairedWithFlare");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_6EAA(param_00) {
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

    if(isDefined(param_00)) {
      level thread[[param_00]](var_01, var_01.team, var_03, var_02);
      continue;
    }

    level thread func_6EB1(var_01, var_01.team, var_03, var_02);
  }
}

func_6EB1(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  param_02 endon("death");
  for(;;) {
    var_04 = param_02 getpointinbounds(0, 0, 0);
    var_05 = [];
    for(var_06 = 0; var_06 < param_03.size; var_06++) {
      if(isDefined(param_03[var_06])) {
        var_05[var_06] = distance(param_03[var_06].origin, var_04);
      }
    }

    var_06 = 0;
    while(var_06 < var_05.size) {
      if(isDefined(var_05[var_06])) {
        if(var_05[var_06] < 4000 && param_02.flaresreservecount > 0) {
          param_02.flaresreservecount--;
          param_02 thread func_6EAE();
          var_07 = param_02 func_6EA0();
          for(var_08 = 0; var_08 < param_03.size; var_08++) {
            if(isDefined(param_03[var_08])) {
              param_03[var_08] missile_settargetent(var_07);
              param_03[var_08] notify("missile_pairedWithFlare");
            }
          }

          return;
        }
      }

      var_08++;
    }

    wait(0.05);
  }
}

func_6EAB(param_00, param_01) {
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

    if(isDefined(param_00)) {
      var_03 thread[[param_00]](var_02, var_02.team, var_04, param_01);
      continue;
    }

    var_03 thread func_6EB2(var_02, var_02.team, var_04, param_01);
  }
}

func_6EB2(param_00, param_01, param_02, param_03) {
  self endon("death");
  for(;;) {
    if(!isDefined(param_02)) {
      break;
    }

    var_04 = param_02 getpointinbounds(0, 0, 0);
    var_05 = distance(self.origin, var_04);
    if(var_05 < 4000 && param_02.flaresreservecount > 0) {
      param_02.flaresreservecount--;
      param_02 thread func_6EAE(param_03);
      var_06 = param_02 func_6EA0();
      self missile_settargetent(var_06);
      self notify("missile_pairedWithFlare");
      return;
    }

    wait(0.05);
  }
}

func_A730(param_00, param_01, param_02, param_03) {
  self.flaresreservecount = param_00;
  self.flareslive = [];
  if(isDefined(param_02)) {
    self.triggerportableradarping setclientomnvar(param_02, param_00);
  }

  thread func_A72F(param_01, param_02);
  thread func_A72D(param_03);
}

func_A72F(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");
  if(!isai(self.triggerportableradarping)) {
    self.triggerportableradarping notifyonplayercommand("manual_flare_popped", param_00);
  }

  while(flares_getnumleft(self)) {
    self.triggerportableradarping waittill("manual_flare_popped");
    var_02 = flares_getflarereserve(self);
    if(isDefined(var_02) && isDefined(self.triggerportableradarping) && !isai(self.triggerportableradarping)) {
      self.triggerportableradarping playlocalsound("veh_helo_flares_plr");
      if(isDefined(param_01)) {
        self.triggerportableradarping setclientomnvar(param_01, flares_getnumleft(self));
      }
    }
  }
}

func_A72D(param_00) {
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

    self.triggerportableradarping playlocalsound("missile_incoming");
    self.triggerportableradarping thread ks_watch_death_stop_sound(self, "missile_incoming");
    if(isDefined(param_00)) {
      var_02 = vectornormalize(var_01[0].origin - self.origin);
      var_03 = vectornormalize(anglestoright(self.angles));
      var_04 = vectordot(var_02, var_03);
      var_05 = 1;
      if(var_04 > 0) {
        var_05 = 2;
      } else if(var_04 < 0) {
        var_05 = 3;
      }

      self.triggerportableradarping setclientomnvar(param_00, var_05);
    }

    foreach(var_07 in var_01) {
      if(isvalidmissile(var_07)) {
        thread func_A72E(var_07);
      }
    }
  }
}

func_A72E(param_00) {
  self endon("death");
  param_00 endon("death");
  for(;;) {
    if(!isDefined(self) || !isvalidmissile(param_00)) {
      break;
    }

    var_01 = self getpointinbounds(0, 0, 0);
    if(distancesquared(param_00.origin, var_01) < 4000000) {
      var_02 = flares_getflarelive(self);
      if(isDefined(var_02)) {
        param_00 missile_settargetent(var_02);
        param_00 notify("missile_pairedWithFlare");
        self.triggerportableradarping stoplocalsound("missile_incoming");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

ks_watch_death_stop_sound(param_00, param_01) {
  self endon("disconnect");
  param_00 waittill("death");
  self stoplocalsound(param_01);
}