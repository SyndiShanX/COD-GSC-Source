/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_flares.gsc
*******************************************/

#include common_scripts\utility;

FLARES_POP_SOUND_NPC = "veh_helo_flares_npc";
FLARES_POP_SOUND_PLR = "veh_helo_flares_plr";

flares_monitor(flareCount) {
  self.flaresReserveCount = flareCount;
  self.flaresLive = [];

  self thread ks_laserGuidedMissile_handleIncoming();
}

flares_playFX() {
  for(i = 0; i < 10; i++) {
    if(!isDefined(self)) {
      return;
    }
    playFXOnTag(level._effect["vehicle_flares"], self, "TAG_FLARE");

    wait(0.15);
  }
}

flares_deploy() {
  flare = spawn("script_origin", self.origin + (0, 0, -256));
  flare.angles = self.angles;

  flare MoveGravity((0, 0, -1), 5.0);

  self.flaresLive[self.flaresLive.size] = flare;

  flare thread flares_deleteAfterTime(5.0, 2.0, self);

  playSoundAtPos(flare.origin, FLARES_POP_SOUND_NPC);

  return flare;
}

flares_deleteAfterTime(delayDelete, delayStopTracking, vehicle) {
  AssertEx(!isDefined(delayStopTracking) || delayStopTracking < delayDelete, "flares_deleteAfterTime() delayDelete should never be greater than delayStopTracking.");

  if(isDefined(delayStopTracking) && isDefined(vehicle)) {
    delayDelete -= delayStopTracking;
    wait(delayStopTracking);

    if(isDefined(vehicle)) {
      vehicle.flaresLive = array_remove(vehicle.flaresLive, self);
    }
  }

  wait(delayDelete);

  self Delete();
}

flares_getNumLeft(vehicle) {
  return vehicle.flaresReserveCount;
}

flares_areAvailable(vehicle) {
  flares_cleanFlaresLiveArray(vehicle);
  return vehicle.flaresReserveCount > 0 || vehicle.flaresLive.size > 0;
}

flares_getFlareReserve(vehicle) {
  AssertEx(vehicle.flaresReserveCount > 0, "flares_getFlareReserve() called on vehicle without any flares in reserve.");

  vehicle.flaresReserveCount--;

  vehicle thread flares_playFX();
  flare = vehicle flares_deploy();

  return flare;
}

flares_cleanFlaresLiveArray(vehicle) {
  vehicle.flaresLive = array_removeUndefined(vehicle.flaresLive);
}

flares_getFlareLive(vehicle) {
  flares_cleanFlaresLiveArray(vehicle);

  flare = undefined;
  if(vehicle.flaresLive.size > 0) {
    flare = vehicle.flaresLive[vehicle.flaresLive.size - 1];
  }
  return flare;
}

ks_laserGuidedMissile_handleIncoming() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areAvailable(self)) {
    level waittill("laserGuidedMissiles_incoming", player, missiles, target);

    if(!isDefined(target) || target != self) {
      continue;
    }
    foreach(missile in missiles) {
      if(IsValidMissile(missile)) {
        level thread ks_laserGuidedMissile_monitorProximity(missile, player, player.team, target);
      }
    }
  }
}

ks_laserGuidedMissile_monitorProximity(missile, player, team, target) {
  target endon("death");
  missile endon("death");
  missile endon("missile_targetChanged");

  while(flares_areAvailable(target)) {
    if(!isDefined(target) || !IsValidMissile(missile)) {
      break;
    }

    center = target GetPointInBounds(0, 0, 0);

    if(DistanceSquared(missile.origin, center) < 4000000) {
      flare = flares_getFlareLive(target);
      if(!isDefined(flare)) {
        flare = flares_getFlareReserve(target);
      }

      missile Missile_SetTargetEnt(flare);
      missile notify("missile_pairedWithFlare");

      break;
    }

    waitframe();
  }
}

flares_handleIncomingSAM(functionOverride) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("sam_fired", player, missileGroup, lockTarget);

    if(!isDefined(lockTarget) || (lockTarget != self)) {
      continue;
    }
    if(isDefined(functionOverride)) {
      level thread[[functionOverride]](player, player.team, lockTarget, missileGroup);
    } else {
      level thread flares_watchSAMProximity(player, player.team, lockTarget, missileGroup);
    }
  }
}

flares_watchSAMProximity(player, missileTeam, missileTarget, missileGroup) {
  level endon("game_ended");
  missileTarget endon("death");

  while(true) {
    center = missileTarget GetPointInBounds(0, 0, 0);

    curDist = [];
    for(i = 0; i < missileGroup.size; i++) {
      if(isDefined(missileGroup[i])) {
        curDist[i] = distance(missileGroup[i].origin, center);
      }
    }

    for(i = 0; i < curDist.size; i++) {
      if(isDefined(curDist[i])) {
        if(curDist[i] < 4000 && missileTarget.flaresReserveCount > 0) {
          missileTarget.flaresReserveCount--;

          missileTarget thread flares_playFX();
          newTarget = missileTarget flares_deploy();
          for(j = 0; j < missileGroup.size; j++) {
            if(isDefined(missileGroup[j])) {
              missileGroup[j] Missile_SetTargetEnt(newTarget);
              missileGroup[j] notify("missile_pairedWithFlare");
            }
          }
          return;
        }
      }
    }
    wait(0.05);
  }
}

flares_handleIncomingStinger(functionOverride) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("stinger_fired", player, missile, lockTarget);

    if(!isDefined(lockTarget) || (lockTarget != self)) {
      continue;
    }
    if(isDefined(functionOverride)) {
      missile thread[[functionOverride]](player, player.team, lockTarget);
    } else {
      missile thread flares_watchStingerProximity(player, player.team, lockTarget);
    }
  }
}

flares_watchStingerProximity(player, missileTeam, missileTarget) {
  self endon("death");

  while(true) {
    if(!isDefined(missileTarget)) {
      break;
    }

    center = missileTarget GetPointInBounds(0, 0, 0);

    curDist = distance(self.origin, center);

    if(curDist < 4000 && missileTarget.flaresReserveCount > 0) {
      missileTarget.flaresReserveCount--;

      missileTarget thread flares_playFX();
      newTarget = missileTarget flares_deploy();
      self Missile_SetTargetEnt(newTarget);
      self notify("missile_pairedWithFlare");
      return;
    }
    wait(0.05);
  }
}

ks_setup_manual_flares(num_flares, button_action, flares_omnvar_name, incoming_omnvar_name) {
  self.flaresReserveCount = num_flares;
  self.flaresLive = [];

  if(isDefined(flares_omnvar_name)) {
    self.owner SetClientOmnvar(flares_omnvar_name, num_flares);
  }

  self thread ks_manualFlares_watchUse(button_action, flares_omnvar_name);
  self thread ks_manualFlares_handleIncoming(incoming_omnvar_name);
}

ks_manualFlares_watchUse(button_action, omnvar_name) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  if(!IsAI(self.owner)) {
    self.owner NotifyOnPlayerCommand("manual_flare_popped", button_action);
  }

  while(flares_getNumLeft(self)) {
    self.owner waittill("manual_flare_popped");

    flare = flares_getFlareReserve(self);
    if(isDefined(flare) && isDefined(self.owner) && !IsAI(self.owner)) {
      self.owner PlayLocalSound(FLARES_POP_SOUND_PLR);
      if(isDefined(omnvar_name)) {
        self.owner SetClientOmnvar(omnvar_name, self flares_getNumLeft(self));
      }
    }
  }
}

ks_manualFlares_handleIncoming(omnvar_name) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areAvailable(self)) {
    self waittill("targeted_by_incoming_missile", missiles);

    if(!isDefined(missiles)) {
      continue;
    }
    self.owner PlayLocalSound("missile_incoming");
    self.owner thread ks_watch_death_stop_sound(self, "missile_incoming");

    if(isDefined(omnvar_name)) {
      vec_to_target = VectorNormalize(missiles[0].origin - self.origin);
      vec_to_right = VectorNormalize(AnglesToRight(self.angles));
      vec_dot = VectorDot(vec_to_target, vec_to_right);
      dir_index = 1;
      if(vec_dot > 0) {
        dir_index = 2;
      } else if(vec_dot < 0) {
        dir_index = 3;
      }
      self.owner SetClientOmnvar(omnvar_name, dir_index);
    }

    foreach(missile in missiles) {
      if(IsValidMissile(missile)) {
        self thread ks_manualFlares_monitorProximity(missile);
      }
    }
  }
}

ks_manualFlares_monitorProximity(missile) {
  self endon("death");
  missile endon("death");

  while(true) {
    if(!isDefined(self) || !IsValidMissile(missile)) {
      break;
    }

    center = self GetPointInBounds(0, 0, 0);

    if(DistanceSquared(missile.origin, center) < 4000000) {
      flare = flares_getFlareLive(self);
      if(isDefined(flare)) {
        missile Missile_SetTargetEnt(flare);
        missile notify("missile_pairedWithFlare");
        self.owner StopLocalSound("missile_incoming");
        break;
      }
    }

    waitframe();
  }
}

ks_watch_death_stop_sound(vehicle, sound) {
  self endon("disconnect");

  vehicle waittill("death");
  self StopLocalSound(sound);
}