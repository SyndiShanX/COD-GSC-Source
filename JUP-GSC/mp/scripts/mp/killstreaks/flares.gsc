/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\flares.gsc
************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#namespace flares;

function flares_monitor(flarecount) {
  self.flaresreservecount = flarecount;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
}

function flares_playFX(fxoverride, fxtagoverride) {
  flarestag = "tag_origin";

  if(!isDefined(fxoverride)) {
    fxoverride = "vehicle_flares";
  }

  if(isDefined(fxtagoverride)) {
    flarestag = fxtagoverride;
  }

  playsoundatpos(self gettagorigin(flarestag), "ks_apache_flares");
  playFXOnTag(level._effect[fxoverride], self, flarestag);
}

function flares_deploy() {
  flare = spawn("script_origin", self.origin + (0, 0, -256));
  flare.angles = self.angles;
  flare movegravity((0, 0, -1), 5);
  self.flareslive[self.flareslive.size] = flare;
  flare thread flares_deleteaftertime(5, 2, self);
  return flare;
}

function flares_deleteaftertime(delaydelete, var_66f0721fc5bc2eb5, vehicle) {
  assertex(!isDefined(var_66f0721fc5bc2eb5) || var_66f0721fc5bc2eb5 < delaydelete, "<dev string:x1c>");

  if(isDefined(var_66f0721fc5bc2eb5) && isDefined(vehicle)) {
    delaydelete -= var_66f0721fc5bc2eb5;
    wait var_66f0721fc5bc2eb5;

    if(isDefined(vehicle)) {
      vehicle.flareslive = array_remove(vehicle.flareslive, self);
    }
  }

  wait delaydelete;
  self delete();
}

function flares_getnumleft(vehicle) {
  return vehicle.flaresreservecount;
}

function flares_areavailable(vehicle) {
  flares_cleanflareslivearray(vehicle);
  return vehicle.flaresreservecount > 0 || vehicle.flareslive.size > 0;
}

function flares_getflarereserve(vehicle) {
  assertex(vehicle.flaresreservecount > 0, "<dev string:x74>");
  flares_reducereserves(vehicle);
  vehicle thread flares_playFX();
  flare = vehicle flares_deploy();
  return flare;
}

function flares_cleanflareslivearray(vehicle) {
  vehicle.flareslive = array_removeundefined(vehicle.flareslive);
}

function flares_getflarelive(vehicle) {
  flares_cleanflareslivearray(vehicle);
  flare = undefined;

  if(vehicle.flareslive.size > 0) {
    flare = vehicle.flareslive[vehicle.flareslive.size - 1];
  }

  return flare;
}

function ks_laserguidedmissile_handleincoming() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areavailable(self)) {
    level waittill("laserGuidedMissiles_incoming", player, missiles, target);

    if(!isDefined(target) || target != self) {
      continue;
    }

    if(!isarray(missiles)) {
      missiles = [missiles];
    }

    foreach(missile in missiles) {
      if(isvalidmissile(missile)) {
        level thread ks_laserguidedmissile_monitorproximity(missile, player, player.team, target);
      }
    }
  }
}

function ks_laserguidedmissile_monitorproximity(missile, player, team, target) {
  target endon("death");
  missile endon("death");
  missile endon("missile_targetChanged");

  while(flares_areavailable(target)) {
    if(!isDefined(target) || !isvalidmissile(missile)) {
      break;
    }

    center = target getpointinbounds(0, 0, 0);

    if(distancesquared(missile.origin, center) < 4000000) {
      flare = flares_getflarelive(target);

      if(!isDefined(flare)) {
        flare = flares_getflarereserve(target);
      }

      clearprojectilelockedon(missile);
      missile missile_settargetEnt(flare);
      missile notify("missile_pairedWithFlare");
      break;
    }

    waitframe();
  }
}

function flares_handleincomingsam(functionoverride) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("sam_fired", player, missilegroup, locktarget);

    if(!isDefined(locktarget) || locktarget != self) {
      continue;
    }

    if(isDefined(functionoverride)) {
      level thread[[functionoverride]](player, player.team, locktarget, missilegroup);
      continue;
    }

    level thread flares_watchsamproximity(player, player.team, locktarget, missilegroup);
  }
}

function flares_watchsamproximity(player, missileteam, missiletarget, missilegroup) {
  level endon("game_ended");
  missiletarget endon("death");

  while(true) {
    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = [];

    for(i = 0; i < missilegroup.size; i++) {
      if(isDefined(missilegroup[i])) {
        curdist[i] = distance(missilegroup[i].origin, center);
      }
    }

    for(i = 0; i < curdist.size; i++) {
      if(isDefined(curdist[i])) {
        if(curdist[i] < 4000 && missiletarget.flaresreservecount > 0) {
          flares_reducereserves(missiletarget);
          missiletarget thread flares_playFX();
          newtarget = missiletarget flares_deploy();

          for(j = 0; j < missilegroup.size; j++) {
            if(isDefined(missilegroup[j])) {
              clearprojectilelockedon(missilegroup[j]);
              missilegroup[j] missile_settargetEnt(newtarget);
              missilegroup[j] notify("missile_pairedWithFlare");
            }
          }

          return;
        }
      }
    }

    waitframe();
  }
}

function flares_handleincomingstinger(functionoverride, fxlocoverride) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  if(!isDefined(self.flareslive)) {
    self.flareslive = [];
  }

  for(;;) {
    level waittill("stinger_fired", player, missile, locktarget);

    if(!isDefined(locktarget) || locktarget != self) {
      continue;
    }

    if(isDefined(functionoverride)) {
      missile thread[[functionoverride]](player, player.team, locktarget, fxlocoverride);
      continue;
    }

    missile thread flares_watchstingerproximity(player, player.team, locktarget, fxlocoverride);
  }
}

function flares_watchstingerproximity(player, missileteam, missiletarget, fxtagoverride) {
  self endon("death");

  while(true) {
    if(!isDefined(missiletarget)) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < 4000 && missiletarget.flaresreservecount > 0) {
      flares_reducereserves(missiletarget);
      missiletarget thread flares_playFX(undefined, fxtagoverride);
      newtarget = missiletarget flares_deploy();
      clearprojectilelockedon(self);
      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function flares_reducereserves(flaresholder) {
  flaresholder.flaresreservecount--;

  if(isDefined(flaresholder.owner)) {
    flaresholder.owner setclientomnvar("ui_killstreak_flares", flaresholder.flaresreservecount);
  }
}

function ks_setup_manual_flares(num_flares, button_action, var_b1b8f942e50d3620, var_1ec886f1b7540ead) {
  self.flaresreservecount = num_flares;
  self.flareslive = [];

  if(isDefined(var_b1b8f942e50d3620)) {
    self.owner setclientomnvar(var_b1b8f942e50d3620, num_flares);
  }

  thread ks_manualflares_watchuse(button_action, var_b1b8f942e50d3620);
  thread ks_manualflares_handleincoming(var_1ec886f1b7540ead);
}

function ks_manualflares_watchuse(button_action, var_c10415b6394096cc) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  if(!isai(self.owner)) {
    self.owner notifyonplayercommand("manual_flare_popped", button_action);
  }

  while(flares_getnumleft(self)) {
    self.owner waittill("manual_flare_popped");
    flare = flares_getflarereserve(self);

    if(isDefined(flare) && isDefined(self.owner) && !isai(self.owner)) {
      self.owner playlocalsound("ks_ac130_flares");

      if(isDefined(var_c10415b6394096cc)) {
        self.owner setclientomnvar(var_c10415b6394096cc, flares_getnumleft(self));
      }
    }
  }
}

function ks_manualflares_handleincoming(var_c10415b6394096cc) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areavailable(self)) {
    self waittill("targeted_by_incoming_missile", missiles);

    if(!isDefined(missiles)) {
      continue;
    }

    self.owner thread ks_watch_death_stop_sound(self, "missile_incoming");

    if(isDefined(var_c10415b6394096cc)) {
      var_53b34aadf7b8e731 = vectorNormalize(missiles[0].origin - self.origin);
      var_f2fd2ff92f5325ba = vectorNormalize(anglestoright(self.angles));
      vec_dot = vectordot(var_53b34aadf7b8e731, var_f2fd2ff92f5325ba);
      dir_index = 1;

      if(vec_dot > 0) {
        dir_index = 2;
      } else if(vec_dot < 0) {
        dir_index = 3;
      }

      self.owner setclientomnvar(var_c10415b6394096cc, dir_index);
    }

    foreach(missile in missiles) {
      if(isvalidmissile(missile)) {
        thread ks_manualflares_monitorproximity(missile);
      }
    }
  }
}

function ks_manualflares_monitorproximity(missile) {
  self endon("death");
  missile endon("death");

  while(true) {
    if(!isDefined(self) || !isvalidmissile(missile)) {
      break;
    }

    center = self getpointinbounds(0, 0, 0);

    if(distancesquared(missile.origin, center) < 4000000) {
      flare = flares_getflarelive(self);

      if(isDefined(flare)) {
        clearprojectilelockedon(missile);
        missile missile_settargetEnt(flare);
        missile notify("missile_pairedWithFlare");
        self.owner stoplocalsound("missile_incoming");
        break;
      }
    }

    waitframe();
  }
}

function ks_watch_death_stop_sound(vehicle, sound) {
  self endon("disconnect");
  vehicle waittill("death");
  self stoplocalsound(sound);
}