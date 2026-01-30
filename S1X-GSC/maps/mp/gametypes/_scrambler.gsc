/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_scrambler.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

playerSetHUDEmpScrambled(endTime, textID, type) {
  curTime = GetTime();
  if(curTime > endTime) {
    return;
  }

  if(!isDefined(self.scrambleEvents)) {
    self.scrambleEvents = [];
  }

  self _playerCleanupScrambleEvents();

  event = spawnStruct();
  event.endTime = endTime;
  event.textID = textID;
  event.typeID = _getScrambleTypeIDForString(type);
  event.scrambleID = self _playerGetUniqueScrambleID();
  self.scrambleEvents[self.scrambleEvents.size] = event;

  if(!isDefined(self.scrambleEventCurrent) || isEvent1HighPriority(event, self.scrambleEventCurrent)) {
    self SetClientOmnvar("ui_exo_reboot_end_time", event.endTime);
    self SetClientOmnvar("ui_exo_reboot_text", event.textID);
    self SetClientOmnvar("ui_exo_reboot_type", event.typeID);
    self.scrambleEventCurrent = event;
    self thread _playerMonitorScrambleEvents(event);
  }

  return event.scrambleID;
}

playerSetHUDEmpScrambledOff(scrambleID) {
  if(!isDefined(self.scrambleEvents)) {
    return;
  }

  event = _playerGetScrambleEvent(scrambleID);

  self _playerCleanupScrambleEvents();

  if(isDefined(event)) {
    self.scrambleEvents = array_remove(self.scrambleEvents, event);
    event notify("done");

    if(event == self.scrambleEventCurrent) {
      nextEvent = self _playerGetNextEvent();

      if(isDefined(nextEvent)) {
        self SetClientOmnvar("ui_exo_reboot_end_time", nextEvent.endTime);
        self SetClientOmnvar("ui_exo_reboot_text", nextEvent.textID);
        self SetClientOmnvar("ui_exo_reboot_type", nextEvent.typeID);
        self.scrambleEventCurrent = nextEvent;
      }
    }
  }

  if(self.scrambleEvents.size == 0) {
    self SetClientOmnvar("ui_exo_reboot_end_time", 0);

    self SetClientOmnvar("ui_exo_reboot_type", 0);
    self.scrambleEvents = undefined;
    self.scrambleEventCurrent = undefined;
  }
}

_playerMonitorScrambleEvents(currentEvent) {
  self notify("_waitToStartNextScrambleEvent");
  self endon("_waitToStartNextScrambleEvent");
  level endon("game_ended");
  self endon("disconnect");

  while(isDefined(self.scrambleEventCurrent)) {
    delay = (self.scrambleEventCurrent.endTime - GetTime()) / 1000;

    result = self.scrambleEventCurrent waittill_notify_or_timeout_return("done", delay);

    if(isDefined(result) && result == "timeout") {
      self playerSetHUDEmpScrambledOff(self.scrambleEventCurrent.scrambleID);
    }
  }
}

_getScrambleTypeIDForString(stringID) {
  switch (stringID) {
    case "emp":
      return 1;
    case "systemHack":
      return 2;
    default:
      return 0;
  }
}

_playerCleanupScrambleEvents() {
  if(self.scrambleEvents.size == 0) {
    return;
  }

  events = [];
  curTime = GetTime();

  foreach(event in self.scrambleEvents) {
    if(curTime < event.endTime) {
      events[events.size] = event;
    }
  }

  self.scrambleEvents = events;
}

_playerGetUniqueScrambleID() {
  maxID = 0;

  foreach(event in self.scrambleEvents) {
    if(event.scrambleID >= maxID) {
      maxID = event.scrambleID + 1;
    }
  }

  return maxID;
}

_playerGetScrambleEvent(scrambleID) {
  foreach(event in self.scrambleEvents) {
    if(event.scrambleID == scrambleID) {
      return event;
    }
  }
}

_playerGetNextEvent() {
  if(self.scrambleEvents.size == 0) {
    return;
  }

  nextEvent = self.scrambleEvents[0];

  for(i = 1; i < self.scrambleEvents.size; i++) {
    event = self.scrambleEvents[i];
    if(isEvent1HighPriority(event, nextEvent)) {
      nextEvent = event;
    }
  }

  return nextEvent;
}

isEvent1HighPriority(event1, event2) {
  return ((event1.typeID > event2.typeID) || (event1.typeID == event2.typeID && event1.endTime > event2.endTime));
}

deleteScrambler(scrambler) {
  if(!isDefined(scrambler)) {
    return;
  }

  foreach(player in level.players) {
    if(isDefined(player)) {
      player.inPlayerScrambler = undefined;
    }
  }

  scrambler notify("death");
  scrambler Delete();

  self.deployedScrambler = undefined;
  tempArray = [];

  tempArray = cleanArray(level.scramblers);
  level.scramblers = tempArray;
}

monitorScramblerUse() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("grenade_fire", grenade, weapName);
    if(weapname == "scrambler" || weapname == "scrambler_mp") {
      if(!IsAlive(self)) {
        grenade delete();
        return;
      }

      grenade Hide();
      grenade waittill("missile_stuck");
      distanceZ = 40;

      if(distanceZ * distanceZ < DistanceSquared(grenade.origin, self.origin)) {
        secTrace = bulletTrace(self.origin, self.origin - (0, 0, distanceZ), false, self);

        if(secTrace["fraction"] == 1) {
          grenade delete();
          self SetWeaponAmmoStock("scrambler_mp", self GetWeaponAmmoStock("scrambler_mp") + 1);
          continue;
        }

        grenade.origin = secTrace["position"];
      }

      grenade Show();

      if(isDefined(self.deployedScrambler)) {
        deleteScrambler(self.deployedScrambler);
      }

      GroundPosition = grenade.origin;

      scrambler = spawn("script_model", GroundPosition);
      scrambler.health = 100;
      scrambler.team = self.team;
      scrambler.owner = self;

      scrambler setCanDamage(true);

      scrambler makeScrambler(self);
      scrambler make_entity_sentient_mp(self.team, true);
      scrambler scramblerSetup(self);
      scrambler thread maps\mp\gametypes\_weapons::createBombSquadModel("weapon_jammer_bombsquad", "tag_origin", self);

      level.scramblers[level.scramblers.size] = scrambler;
      self.deployedScrambler = scrambler;

      self.changingWeapon = undefined;

      wait(0.05);
      if(isDefined(grenade)) {
        grenade Delete();
      }
    }
  }
}

scramblerSetup(owner) {
  self setModel("weapon_jammer");

  if(level.teamBased) {
    self maps\mp\_entityheadIcons::setTeamHeadIcon(self.team, (0, 0, 20));
  } else {
    self maps\mp\_entityheadicons::setPlayerHeadIcon(owner, (0, 0, 20));
  }

  self thread scramblerDamageListener(owner);
  self thread scramblerUseListener(owner);
  owner thread scramblerWatchOwner(self);
  self thread scramblerBeepSounds();
  self thread notUsableForJoiningPlayers(owner);
}

scramblerWatchOwner(scrambler) {
  scrambler endon("death");
  level endon("game_ended");

  self waittill_any("disconnect", "joined_team", "joined_spectators", "death");

  level thread deleteScrambler(scrambler);
}

scramblerBeepSounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait(3.0);
    self playSound("scrambler_beep");
  }
}

scramblerDamageListener(owner) {
  self endon("death");

  self.health = 999999;
  self.maxHealth = 100;
  self.damageTaken = 0;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags, weapon);

    if(!maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker)) {
      continue;
    }

    if(isDefined(weapon)) {
      shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

      switch (shortWeapon) {
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
        case "stun_grenade_mp":
        case "stun_grenade_var_mp":
        case "smoke_grenade_mp":
        case "smoke_grenade_var_mp":
          continue;
      }
    }

    if(!isDefined(self)) {
      return;
    }

    if(isMeleeMOD(type)) {
      self.damageTaken += self.maxHealth;
    }

    if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
      self.wasDamagedFromBulletPenetration = true;
    }

    self.wasDamaged = true;

    self.damageTaken += damage;

    if(isPlayer(attacker)) {
      attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("scrambler");
    }

    if(self.damageTaken >= self.maxHealth) {
      if(isDefined(owner) && attacker != owner) {
        attacker notify("destroyed_explosive");
      }

      self playSound("sentry_explode");
      self.deathEffect = playFX(getfx("equipment_explode"), self.origin);
      self FreeEntitySentient();
      attacker thread deleteScrambler(self);
    }
  }
}

scramblerUseListener(owner) {
  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");

  self setCursorHint("HINT_NOICON");
  self setHintString(&"MP_PATCH_PICKUP_SCRAMBLER");
  self setSelfUsable(owner);

  for(;;) {
    self waittill("trigger", owner);

    ammoStock = owner GetWeaponAmmoStock("scrambler_mp");

    if(ammoStock < WeaponMaxAmmo("scrambler_mp")) {
      owner playLocalSound("scavenger_pack_pickup");

      owner SetWeaponAmmoStock("scrambler_mp", ammoStock + 1);

      owner thread deleteScrambler(self);
    }
  }
}

scramblerProximityTracker() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  level endon("game_ended");

  self.scramProxyActive = false;

  scramblerProximity = 512;

  for(;;) {
    wait(0.05);

    self.scramProxyActive = false;
    foreach(scrambler in level.scramblers) {
      if(!isDefined(scrambler)) {
        continue;
      }

      if(!isReallyAlive(self)) {
        continue;
      }

      scramDistance = DistanceSquared(scrambler.origin, self.origin);

      if((level.teambased && scrambler.team != self.team) ||
        (!level.teambased && isDefined(scrambler.owner) && scrambler.owner != self)) {
        if(scramDistance < scramblerProximity * scramblerProximity) {
          self.inPlayerScrambler = scrambler.owner;
        } else {
          self.inPlayerScrambler = undefined;
        }

        continue;
      }

      if(scramDistance < scramblerProximity * scramblerProximity) {
        self.scramProxyActive = true;
        break;
      }
    }

    if(self.scramProxyActive) {
      if(!self _hasPerk("specialty_blindeye")) {
        self givePerk("specialty_blindeye", false);
        self.scramProxyPerk = true;
      }
    } else {
      if(isDefined(self.scramProxyPerk) && self.scramProxyPerk) {
        self.scramProxyPerk = false;
      }
    }
  }

}