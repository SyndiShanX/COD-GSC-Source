/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_friendlyfire.gsc
********************************************************/

#include maps\_utility;

main() {
  level.friendlyfire["min_participation"] = -200;
  level.friendlyfire["max_participation"] = 1000;
  level.friendlyfire["enemy_kill_points"] = 250;
  level.friendlyfire["friend_kill_points"] = -650;
  level.friendlyfire["point_loss_interval"] = 1.25;

  level.player.participation = 0;

  level.friendlyFireDisabled = 0;
  level.friendlyFireDisabledForDestructible = 0;
  SetDvarIfUninitialized("friendlyfire_dev_disabled", "0");

  common_scripts\utility::flag_init("friendly_fire_warning");

  thread debug_friendlyfire();
  thread participation_point_flattenOverTime();
}

debug_friendlyfire() {
  SetDvarIfUninitialized("debug_friendlyfire", "0");

  friendly_fire = NewHudElem();
  friendly_fire.alignX = "right";
  friendly_fire.alignY = "middle";
  friendly_fire.x = 620;
  friendly_fire.y = 100;
  friendly_fire.fontScale = 2;
  friendly_fire.alpha = 0;

  for(;;) {
    if(GetDebugDvar("debug_friendlyfire") == "1") {
      friendly_fire.alpha = 1;
    } else {
      friendly_fire.alpha = 0;
    }

    friendly_fire SetValue(level.player.participation);
    wait 0.25;
  }
}
friendly_fire_think(entity) {
  if(!isDefined(entity)) {
    return;
  }
  if(!isDefined(entity.team)) {
    entity.team = "allies";
  }

  if(isDefined(level.no_friendly_fire_penalty)) {
    return;
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
    entity waittill("friendlyfire_notify", damage, attacker, direction, point, method, weaponName);

    if(!isDefined(entity)) {
      return;
    }

    if(!isDefined(attacker)) {
      continue;
    }

    bPlayersDamage = false;

    if(!isDefined(weaponName)) {
      weaponName = entity.damageweapon;
    }

    if(isPlayer(attacker)) {
      bPlayersDamage = true;

      if(isDefined(weaponName) && (weaponName == "none")) {
        bPlayersDamage = false;
      }

      if(attacker isUsingTurret()) {
        bPlayersDamage = true;
      }
    } else
    if((isDefined(attacker.code_classname)) && (attacker.code_classname == "script_vehicle")) {
      owner = attacker GetVehicleOwner();
      if((isDefined(owner)) && (isPlayer(owner))) {
        bPlayersDamage = true;
      }
    }

    if(!bPlayersDamage) {
      continue;
    }
    if(!isDefined(entity.team)) {
      continue;
    }
    same_team = entity.team == level.player.team;

    civilianKilled = undefined;
    if(level.script != "airport") {
      civilianKilled = IsSubStr(entity.classname, "civilian");
    } else {
      civilianKilled = false;
    }

    killed = damage == -1;

    if(!same_team && !civilianKilled) {
      if(killed) {
        level.player.participation += level.friendlyfire["enemy_kill_points"];
        participation_point_cap();
        return;
      }
      continue;
    }

    if(isDefined(entity.no_friendly_fire_penalty)) {
      continue;
    }
    if((method == "MOD_PROJECTILE_SPLASH") && (isDefined(level.no_friendly_fire_splash_damage))) {
      continue;
    }

    if(isDefined(weaponName) && (weaponName == "claymore")) {
      continue;
    }
    if(killed) {
      level.player.participation += level.friendlyfire["friend_kill_points"];
    } else {
      level.player.participation -= damage;
    }

    participation_point_cap();

    if(check_grenade(entity, method) && savecommit_afterGrenade()) {
      if(killed) {
        return;
      } else {
        continue;
      }
    }

    friendly_fire_checkPoints(civilianKilled);
  }
}

friendly_fire_checkPoints(civilianKilled) {
  if((isDefined(level.failOnFriendlyFire)) && (level.failOnFriendlyFire)) {
    level thread missionfail(civilianKilled);
    return;
  }

  if(level.friendlyFireDisabledForDestructible == 1) {
    return;
  }
  if(level.friendlyFireDisabled == 1) {
    return;
  }
  if(level.player.participation <= (level.friendlyfire["min_participation"])) {
    level thread missionfail(civilianKilled);
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
    PrintLn("^3aborting friendly fire because the level just loaded and saved and could cause a autosave grenade loop");
    return true;
  } else
  if((currentTime - level.lastAutoSaveTime) < 4500) {
    PrintLn("^3aborting friendly fire because it could be caused by an autosave grenade loop");
    return true;
  }
  return false;
}

participation_point_cap() {
  if(level.player.participation > level.friendlyfire["max_participation"]) {
    level.player.participation = level.friendlyfire["max_participation"];
  }
  if(level.player.participation < level.friendlyfire["min_participation"]) {
    level.player.participation = level.friendlyfire["min_participation"];
  }
}

participation_point_flattenOverTime() {
  level endon("mission failed");
  for(;;) {
    if(level.player.participation > 0) {
      level.player.participation--;
    } else if(level.player.participation < 0) {
      level.player.participation++;
    }
    wait level.friendlyfire["point_loss_interval"];
  }
}

TurnBackOn() {
  level.friendlyFireDisabled = 0;
}

TurnOff() {
  level.friendlyFireDisabled = 1;
}

missionfail(civilianKilled) {
  if(!isDefined(civilianKilled)) {
    civilianKilled = false;
  }

  if(level.script == "airport") {
    if(civilianKilled) {
      return;
    }
    common_scripts\utility::flag_set("friendly_fire_warning");
    return;
  }

  if(getDvar("friendlyfire_dev_disabled") == "1") {
    return;
  }
  level.player endon("death");
  level endon("mine death");
  level notify("mission failed");
  level notify("friendlyfire_mission_fail");

  waittillframeend;

  SetSavedDvar("hud_missionFailed", 1);

  if(isDefined(level.player.failingMission)) {
    return;
  }
  if(civilianKilled) {}
  setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_CIVILIAN_KILLED");
  else if(isDefined(level.custom_friendly_fire_message)) {
    setDvar("ui_deadquote", level.custom_friendly_fire_message);
  } else if(level.campaign == "british") {}
  setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_BRITISH");
  else if(level.campaign == "russian") {}
  setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_RUSSIAN");
  else {}
  setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");

  if(isDefined(level.custom_friendly_fire_shader)) {
    thread maps\_load::special_death_indicator_hudelement(level.custom_friendly_fire_shader, 64, 64, 0);
  }

  maps\_utility::missionFailedWrapper();
}

notifyDamage(entity) {
  level endon("mission failed");
  entity endon("death");
  for(;;) {
    entity waittill("damage", damage, attacker, direction, point, method, modelName, tagName, partName, dFlags, weaponName);
    entity notify("friendlyfire_notify", damage, attacker, direction, point, method, weaponName);
  }
}

notifyDamageNotDone(entity) {
  level endon("mission failed");
  entity waittill("damage_notdone", damage, attacker, direction, point, method);
  entity notify("friendlyfire_notify", -1, attacker, undefined, undefined, method);
}

notifyDeath(entity) {
  level endon("mission failed");
  entity waittill("death", attacker, method, weaponName);
  entity notify("friendlyfire_notify", -1, attacker, undefined, undefined, method, weaponName);
}

detectFriendlyFireOnEntity(entity) {}