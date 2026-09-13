/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\flares.gsc
***********************************************/

flares_monitor(_id_F7324548B947A802) {
  self.flaresreservecount = _id_F7324548B947A802;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
}

flares_playFX(_id_74DA9C68920FF387, _id_5991F0E5DA9F9BD5) {
  _id_0023E275144756D0 = "tag_origin";

  if(!isDefined(_id_74DA9C68920FF387))
    _id_74DA9C68920FF387 = "vehicle_flares";

  if(isDefined(_id_5991F0E5DA9F9BD5))
    _id_0023E275144756D0 = _id_5991F0E5DA9F9BD5;

  playsoundatpos(self gettagorigin(_id_0023E275144756D0), "ks_apache_flares");
  playFXOnTag(level._effect[_id_74DA9C68920FF387], self, _id_0023E275144756D0);
}

flares_deploy() {
  flare = spawn("script_origin", self.origin + (0, 0, -256));
  flare.angles = self.angles;
  flare movegravity((0, 0, -1), 5.0);
  self.flareslive[self.flareslive.size] = flare;
  flare thread flares_deleteaftertime(5.0, 2.0, self);
  return flare;
}

flares_deleteaftertime(_id_C80C23CECBCF334F, _id_66F0721FC5BC2EB5, vehicle) {
  if(isDefined(_id_66F0721FC5BC2EB5) && isDefined(vehicle)) {
    _id_C80C23CECBCF334F = _id_C80C23CECBCF334F - _id_66F0721FC5BC2EB5;
    wait(_id_66F0721FC5BC2EB5);

    if(isDefined(vehicle))
      vehicle.flareslive = scripts\engine\utility::array_remove(vehicle.flareslive, self);
  }

  wait(_id_C80C23CECBCF334F);
  self delete();
}

flares_getnumleft(vehicle) {
  return vehicle.flaresreservecount;
}

flares_areavailable(vehicle) {
  flares_cleanflareslivearray(vehicle);
  return vehicle.flaresreservecount > 0 || vehicle.flareslive.size > 0;
}

flares_getflarereserve(vehicle) {
  flares_reducereserves(vehicle);
  vehicle thread flares_playFX();
  flare = vehicle flares_deploy();
  return flare;
}

flares_cleanflareslivearray(vehicle) {
  vehicle.flareslive = scripts\engine\utility::array_removeundefined(vehicle.flareslive);
}

flares_getflarelive(vehicle) {
  flares_cleanflareslivearray(vehicle);
  flare = undefined;

  if(vehicle.flareslive.size > 0)
    flare = vehicle.flareslive[vehicle.flareslive.size - 1];

  return flare;
}

ks_laserguidedmissile_handleincoming() {
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
    if(!isarray(missiles))
      missiles = [missiles];

    foreach(missile in missiles) {
      if(isvalidmissile(missile))
        level thread ks_laserguidedmissile_monitorproximity(missile, player, player.team, target);
    }
  }
}

ks_laserguidedmissile_monitorproximity(missile, player, team, target) {
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

      if(!isDefined(flare))
        flare = flares_getflarereserve(target);

      scripts\cp_mp\utility\weapon_utility::clearprojectilelockedon(missile);
      missile missile_settargetEnt(flare);
      missile notify("missile_pairedWithFlare");
      break;
    }

    waitframe();
  }
}

flares_handleincomingsam(_id_CA4DC074041B22CD) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("sam_fired", player, _id_A512AA80EA6BF396, _id_D1636A91C31CF68F);

    if(!isDefined(_id_D1636A91C31CF68F) || _id_D1636A91C31CF68F != self) {
      continue;
    }
    if(isDefined(_id_CA4DC074041B22CD)) {
      level thread[[_id_CA4DC074041B22CD]](player, player.team, _id_D1636A91C31CF68F, _id_A512AA80EA6BF396);
      continue;
    }

    level thread flares_watchsamproximity(player, player.team, _id_D1636A91C31CF68F, _id_A512AA80EA6BF396);
  }
}

flares_watchsamproximity(player, _id_82FD3EE8FBACE30E, _id_6D87867F43E1D612, _id_A512AA80EA6BF396) {
  level endon("game_ended");
  _id_6D87867F43E1D612 endon("death");

  for(;;) {
    center = _id_6D87867F43E1D612 getpointinbounds(0, 0, 0);
    _id_6B40B4C28ABE0A05 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A512AA80EA6BF396.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(_id_A512AA80EA6BF396[_id_AC0E594AC96AA3A8]))
        _id_6B40B4C28ABE0A05[_id_AC0E594AC96AA3A8] = distance(_id_A512AA80EA6BF396[_id_AC0E594AC96AA3A8].origin, center);
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6B40B4C28ABE0A05.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(_id_6B40B4C28ABE0A05[_id_AC0E594AC96AA3A8])) {
        if(_id_6B40B4C28ABE0A05[_id_AC0E594AC96AA3A8] < 4000 && _id_6D87867F43E1D612.flaresreservecount > 0) {
          flares_reducereserves(_id_6D87867F43E1D612);
          _id_6D87867F43E1D612 thread flares_playFX();
          newtarget = _id_6D87867F43E1D612 flares_deploy();

          for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_A512AA80EA6BF396.size; _id_AC0E5C4AC96AAA41++) {
            if(isDefined(_id_A512AA80EA6BF396[_id_AC0E5C4AC96AAA41])) {
              scripts\cp_mp\utility\weapon_utility::clearprojectilelockedon(_id_A512AA80EA6BF396[_id_AC0E5C4AC96AAA41]);
              _id_A512AA80EA6BF396[_id_AC0E5C4AC96AAA41] missile_settargetEnt(newtarget);
              _id_A512AA80EA6BF396[_id_AC0E5C4AC96AAA41] notify("missile_pairedWithFlare");
            }
          }

          return;
        }
      }
    }

    waitframe();
  }
}

flares_handleincomingstinger(_id_CA4DC074041B22CD, _id_CF2F5E8DE06279B3) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  if(!isDefined(self.flareslive))
    self.flareslive = [];

  for(;;) {
    level waittill("stinger_fired", player, missile, _id_D1636A91C31CF68F);

    if(!isDefined(_id_D1636A91C31CF68F) || _id_D1636A91C31CF68F != self) {
      continue;
    }
    if(isDefined(_id_CA4DC074041B22CD)) {
      missile thread[[_id_CA4DC074041B22CD]](player, player.team, _id_D1636A91C31CF68F, _id_CF2F5E8DE06279B3);
      continue;
    }

    missile thread flares_watchstingerproximity(player, player.team, _id_D1636A91C31CF68F, _id_CF2F5E8DE06279B3);
  }
}

flares_watchstingerproximity(player, _id_82FD3EE8FBACE30E, _id_6D87867F43E1D612, _id_5991F0E5DA9F9BD5) {
  self endon("death");

  for(;;) {
    if(!isDefined(_id_6D87867F43E1D612)) {
      break;
    }

    center = _id_6D87867F43E1D612 getpointinbounds(0, 0, 0);
    _id_6B40B4C28ABE0A05 = distance(self.origin, center);

    if(_id_6B40B4C28ABE0A05 < 4000 && _id_6D87867F43E1D612.flaresreservecount > 0) {
      flares_reducereserves(_id_6D87867F43E1D612);
      _id_6D87867F43E1D612 thread flares_playFX(undefined, _id_5991F0E5DA9F9BD5);
      newtarget = _id_6D87867F43E1D612 flares_deploy();
      scripts\cp_mp\utility\weapon_utility::clearprojectilelockedon(self);
      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

flares_reducereserves(_id_A8FF4810541BA06E) {
  _id_A8FF4810541BA06E.flaresreservecount--;

  if(isDefined(_id_A8FF4810541BA06E.owner) && isPlayer(_id_A8FF4810541BA06E.owner))
    _id_A8FF4810541BA06E.owner setclientomnvar("ui_killstreak_flares", _id_A8FF4810541BA06E.flaresreservecount);
}

ks_setup_manual_flares(_id_057B8AFE291AB835, _id_5DEA64FFD0EE3F24, _id_B1B8F942E50D3620, _id_1EC886F1B7540EAD) {
  self.flaresreservecount = _id_057B8AFE291AB835;
  self.flareslive = [];

  if(isDefined(_id_B1B8F942E50D3620))
    self.owner setclientomnvar(_id_B1B8F942E50D3620, _id_057B8AFE291AB835);

  thread ks_manualflares_watchuse(_id_5DEA64FFD0EE3F24, _id_B1B8F942E50D3620);
  thread ks_manualflares_handleincoming(_id_1EC886F1B7540EAD);
}

ks_manualflares_watchuse(_id_5DEA64FFD0EE3F24, _id_C10415B6394096CC) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  if(!isai(self.owner))
    self.owner notifyonplayercommand("manual_flare_popped", _id_5DEA64FFD0EE3F24);

  while(flares_getnumleft(self)) {
    self.owner waittill("manual_flare_popped");
    flare = flares_getflarereserve(self);

    if(isDefined(flare) && isDefined(self.owner) && !isai(self.owner)) {
      self.owner playlocalsound("ks_ac130_flares");

      if(isDefined(_id_C10415B6394096CC))
        self.owner setclientomnvar(_id_C10415B6394096CC, flares_getnumleft(self));
    }
  }
}

ks_manualflares_handleincoming(_id_C10415B6394096CC) {
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

    if(isDefined(_id_C10415B6394096CC)) {
      _id_53B34AADF7B8E731 = vectorNormalize(missiles[0].origin - self.origin);
      _id_F2FD2FF92F5325BA = vectorNormalize(anglestoright(self.angles));
      _id_97E748918661CE39 = vectordot(_id_53B34AADF7B8E731, _id_F2FD2FF92F5325BA);
      _id_ECE37F0D164606D3 = 1;

      if(_id_97E748918661CE39 > 0)
        _id_ECE37F0D164606D3 = 2;
      else if(_id_97E748918661CE39 < 0)
        _id_ECE37F0D164606D3 = 3;

      self.owner setclientomnvar(_id_C10415B6394096CC, _id_ECE37F0D164606D3);
    }

    foreach(missile in missiles) {
      if(isvalidmissile(missile))
        thread ks_manualflares_monitorproximity(missile);
    }
  }
}

ks_manualflares_monitorproximity(missile) {
  self endon("death");
  missile endon("death");

  for(;;) {
    if(!isDefined(self) || !isvalidmissile(missile)) {
      break;
    }

    center = self getpointinbounds(0, 0, 0);

    if(distancesquared(missile.origin, center) < 4000000) {
      flare = flares_getflarelive(self);

      if(isDefined(flare)) {
        scripts\cp_mp\utility\weapon_utility::clearprojectilelockedon(missile);
        missile missile_settargetEnt(flare);
        missile notify("missile_pairedWithFlare");
        self.owner stoplocalsound("missile_incoming");
        break;
      }
    }

    waitframe();
  }
}

ks_watch_death_stop_sound(vehicle, sound) {
  self endon("disconnect");
  vehicle waittill("death");
  self stoplocalsound(sound);
}