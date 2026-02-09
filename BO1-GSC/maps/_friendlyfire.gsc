/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_friendlyfire.gsc
**************************************/

#include maps\_utility;

main() {
  level.friendlyfire["min_participation"] = -1600;
  level.friendlyfire["max_participation"] = 1000;
  level.friendlyfire["enemy_kill_points"] = 250;
  level.friendlyfire["friend_kill_points"] = -600;
  level.friendlyfire["civ_kill_points"] = -900;
  level.friendlyfire["point_loss_interval"] = .75;
  setDvar("friendlyfire_enabled", "1");
  level.friendlyfire_override_attacker_entity = ::default_override_attacker_entity;
  if(coopGame()) {
    setDvar("friendlyfire_enabled", "0");
  }
  level.friendlyFireDisabled = 0;
}
default_override_attacker_entity(entity, damage, attacker, direction, point, method) {
  return (undefined);
}
player_init() {
  self.participation = 0;
  self thread debug_friendlyfire();
  self thread participation_point_flattenovertime();
}
debug_friendlyfire() {
  self endon("disconnect");
}
friendly_fire_think(entity) {
  if(!isDefined(entity)) {
    return;
  }
  if(!isDefined(entity.team)) {
    entity.team = "allies";
  }
  level endon("mission failed");
  level thread notifyDamage(entity);
  level thread notifyDamageNotDone(entity);
  level thread notifyDeath(entity);
  for(;;) {
    if(!isDefined(entity)) {
      return;
    }
    if(entity.health <= 0) {
      return;
    }
    entity waittill("friendlyfire_notify", damage, attacker, direction, point, method);
    if(level.friendlyFireDisabled) {
      continue;
    }
    if(!isDefined(entity)) {
      return;
    }
    if((isDefined(entity.NoFriendlyfire)) && (entity.NoFriendlyfire == true)) {
      continue;
    }
    if(!isDefined(attacker)) {
      continue;
    }
    override = [[level.friendlyfire_override_attacker_entity]](entity, damage, attacker, direction, point, method);
    if(isDefined(override)) {
      attacker = override;
    }
    bPlayersDamage = false;
    if(isPlayer(attacker)) {
      bPlayersDamage = true;
    } else if((isDefined(attacker.classname)) && (attacker.classname == "script_vehicle")) {
      owner = attacker GetVehicleowner();
      if(isDefined(owner)) {
        if(isPlayer(owner)) {
          if(!isDefined(owner.friendlyfire_attacker_not_vehicle_owner)) {
            bPlayersDamage = true;
            attacker = owner;
          }
        }
      }
    }
    if(!bPlayersDamage) {
      continue;
    }
    same_team = entity.team == attacker.team;
    if(attacker.team == "allies") {
      if(entity.team == "neutral") {
        same_team = true;
      }
    }
    attacker.last_hit_team = entity.team;
    killed = damage == -1;
    if(!same_team) {
      if(killed) {
        attacker.participation += level.friendlyfire["enemy_kill_points"];
        attacker participation_point_cap();
      } else {}
      return;
    } else {
      arcademode_assignpoints("arcademode_friendies_damage", attacker);
      if(killed) {} else {}
    }
    if(isDefined(entity.no_friendly_fire_penalty)) {
      continue;
    }
    if(killed) {
      if(entity.team == "neutral") {
        if(attacker.participation <= 0) {
          attacker.participation += level.friendlyfire["min_participation"];
        } else {
          attacker.participation += level.friendlyfire["civ_kill_points"];
        }
      } else {
        attacker.participation += level.friendlyfire["friend_kill_points"];
      }
    } else {
      attacker.participation -= damage;
    }
    attacker participation_point_cap();
    if(check_grenade(entity, method) && savecommit_afterGrenade()) {
      if(killed) {
        return;
      } else {
        continue;
      }
    }
    attacker friendly_fire_checkpoints();
  }
}
friendly_fire_checkpoints() {
  if(self.participation <= level.friendlyfire["min_participation"]) {
    self thread missionfail();
  }
}
check_grenade(entity, method) {
  if(!isDefined(entity)) {
    return false;
  }
  wasGrenade = false;
  if((isDefined(entity.damageweapon)) && (entity.damageweapon == "none")) {
    wasGrenade = true;
  }
  if((isDefined(method)) && (method == "MOD_GRENADE_SPLASH")) {
    wasGrenade = true;
  }
  return wasGrenade;
}
savecommit_afterGrenade() {
  currentTime = GetTime();
  if(currentTime < 4500) {
    println("^3aborting friendly fire because the level just loaded and saved and could cause a autosave grenade loop");
    return true;
  } else if((currentTime - level.lastAutoSaveTime) < 4500) {
    println("^3aborting friendly fire because it could be caused by an autosave grenade loop");
    return true;
  }
  return false;
}
participation_point_cap() {
  if(!isDefined(self.participation)) {
    assertmsg("self.participation is not defined!");
    return;
  }
  if(self.participation > level.friendlyfire["max_participation"]) {
    self.participation = level.friendlyfire["max_participation"];
  }
  if(self.participation < level.friendlyfire["min_participation"]) {
    self.participation = level.friendlyfire["min_participation"];
  }
}
participation_point_flattenOverTime() {
  level endon("mission failed");
  level endon("friendly_fire_terminate");
  self endon("disconnect");
  for(;;) {
    if(self.participation > 0) {
      self.participation--;
    } else if(self.participation < 0) {
      self.participation++;
    }
    wait(level.friendlyfire["point_loss_interval"]);
  }
}
TurnBackOn() {
  level.friendlyFireDisabled = 0;
}
TurnOff() {
  level.friendlyFireDisabled = 1;
}
missionfail() {
  self endon("death");
  level endon("mine death");
  level notify("mission failed");
  if(isDefined(self.last_hit_team) && self.last_hit_team == "neutral") {
    setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_NEUTRAL");
  } else {
    if(level.campaign == "british") {
      setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_BRITISH");
    } else if(level.campaign == "russian") {
      setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_RUSSIAN");
    } else {
      setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
    }
  }
  if(isDefined(level.custom_friendly_fire_shader)) {
    thread maps\_load_common::special_death_indicator_hudelement(level.custom_friendly_fire_shader, 64, 64, 0);
  }
  logString("failed mission: Friendly fire");
  maps\_utility::missionFailedWrapper();
}
notifyDamage(entity) {
  level endon("mission failed");
  entity endon("death");
  for(;;) {
    entity waittill("damage", damage, attacker, direction, point, method);
    entity notify("friendlyfire_notify", damage, attacker, direction, point, method);
  }
}
notifyDamageNotDone(entity) {
  level endon("mission failed");
  entity waittill("damage_notdone", damage, attacker, direction, point, method);
  entity notify("friendlyfire_notify", -1, attacker, undefined, undefined, method);
}
notifyDeath(entity) {
  level endon("mission failed");
  entity waittill("death", attacker, method);
  entity notify("friendlyfire_notify", -1, attacker, undefined, undefined, method);
}