/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_flashgrenades.gsc
***************************************************/

#include maps\mp\_utility;

main() {
  PreCacheShellShock("flashbang_mp");
}

startMonitoringFlash() {
  self thread monitorFlash();
}

stopMonitoringFlash(disconnected) {
  self notify("stop_monitoring_flash");
}

flashRumbleLoop(duration) {
  self endon("stop_monitoring_flash");

  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");

  goalTime = getTime() + duration * 1000;

  while(getTime() < goalTime) {
    self PlayRumbleOnEntity("damage_heavy");
    wait(0.05);
  }
}

monitorFlash() {
  self endon("disconnect");

  self notify("monitorFlash");
  self endon("monitorFlash");

  self.flashEndTime = 0;

  durationMultiplier = 2.5;

  while(1) {
    self waittill("flashbang", origin, percent_distance, percent_angle, attacker, teamName, extraDuration);

    if(!IsAlive(self)) {
      break;
    }

    if(isDefined(self.usingRemote)) {
      continue;
    }

    if(!isDefined(extraDuration)) {
      extraDuration = 0;
    }

    hurtattacker = false;
    hurtvictim = true;

    if(percent_angle < 0.25) {
      percent_angle = 0.25;
    } else if(percent_angle > 0.8) {
      percent_angle = 1;
    }

    duration = percent_distance * percent_angle * durationMultiplier;
    duration += extraDuration;

    if(isDefined(self.stunScaler)) {
      duration = duration * self.stunScaler;
    }

    if(duration < 0.25) {
      continue;
    }

    rumbleduration = undefined;
    if(duration > 2) {
      rumbleduration = 0.75;
    } else {
      rumbleduration = 0.25;
    }

    assert(isDefined(self.team));
    if(level.teamBased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team && attacker != self) {
      if(level.friendlyfire == 0) {
        continue;
      } else if(level.friendlyfire == 1) {} else if(level.friendlyfire == 2) {
        duration = duration * .5;
        rumbleduration = rumbleduration * .5;
        hurtvictim = false;
        hurtattacker = true;
      } else if(level.friendlyfire == 3) {
        duration = duration * .5;
        rumbleduration = rumbleduration * .5;
        hurtattacker = true;
      }
    } else if(isDefined(attacker)) {
      if(attacker != self) {
        attacker maps\mp\gametypes\_missions::processChallenge("ch_indecentexposure");
      }
    }

    if(hurtvictim && isDefined(self)) {
      self thread applyFlash(duration, rumbleduration);

      if(isDefined(attacker) && attacker != self) {
        attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback("flash");

        victim = self;
        if(isPlayer(attacker) && attacker IsItemUnlocked("specialty_paint") && attacker _hasPerk("specialty_paint")) {
          if(!victim maps\mp\perks\_perkfunctions::isPainted()) {
            attacker maps\mp\gametypes\_missions::processChallenge("ch_paint_pro");
          }

          victim thread maps\mp\perks\_perkfunctions::setPainted(attacker);
        }
      }
    }
    if(hurtattacker && isDefined(attacker)) {
      attacker thread applyFlash(duration, rumbleduration);
    }
  }
}

applyFlash(duration, rumbleduration) {
  if(!isDefined(self.flashDuration) || duration > self.flashDuration) {
    self.flashDuration = duration;
  }
  if(!isDefined(self.flashRumbleDuration) || rumbleduration > self.flashRumbleDuration) {
    self.flashRumbleDuration = rumbleduration;
  }

  wait .05;

  if(isDefined(self.flashDuration)) {
    self shellshock("flashbang_mp", self.flashDuration);
    self.flashEndTime = getTime() + (self.flashDuration * 1000);
    self thread light_set_override_for_player("flashed", 0.1, 0.1, (self.flashDuration - 0.1));
  }
  if(isDefined(self.flashRumbleDuration)) {
    self thread flashRumbleLoop(self.flashRumbleDuration);
  }

  self.flashDuration = undefined;
  self.flashRumbleDuration = undefined;
}

isFlashbanged() {
  return isDefined(self.flashEndTime) && gettime() < self.flashEndTime;
}