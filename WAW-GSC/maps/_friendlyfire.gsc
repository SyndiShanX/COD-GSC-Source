/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_friendlyfire.gsc
**************************************/

#include maps\_utility;

main() {
  if(getdebugdvar("replay_debug") == "1")
    println("File: _friendlyfire.gsc. Function: main()\n");

  level.friendlyfire["min_participation"] = -1600;
  level.friendlyfire["max_participation"] = 1000;
  level.friendlyfire["enemy_kill_points"] = 250;
  level.friendlyfire["friend_kill_points"] = -600;
  level.friendlyfire["point_loss_interval"] = .75;

  setDvar("friendlyfire_enabled", "1");

  if(coopGame()) {
    setDvar("friendlyfire_enabled", "0");
  }

  level.friendlyFireDisabled = 0;

  if(getdebugdvar("replay_debug") == "1")
    println("File: _friendlyfire.gsc. Function: main() - COMPLETE\n");
}
player_init() {
  self.participation = 0;
  self thread debug_friendlyfire();
  self thread participation_point_flattenovertime();
}
debug_friendlyfire() {
  if(getdebugdvar("replay_debug") == "1")
    println("File: _friendlyfire.gsc. Function: debug_friendlyfire()\n");

  self endon("disconnect");

  if(getDvar("debug_friendlyfire") == "") {
    setDvar("debug_friendlyfire", "0");
  }

  friendly_fire = NewHudElem();
  friendly_fire.alignX = "right";
  friendly_fire.alignY = "middle";
  friendly_fire.x = 620;
  friendly_fire.y = 100;
  friendly_fire.fontScale = 2;
  friendly_fire.alpha = 0;

  for(;;) {
    if(getdebugdvar("replay_debug") == "1")
      println("File: _friendlyfire.gsc. Function: debug_friendlyfire() - INNER LOOP START\n");

    if(getDvar("debug_friendlyfire") == "1") {
      friendly_fire.alpha = 1;
    } else {
      friendly_fire.alpha = 0;
    }

    friendly_fire Setvalue(self.participation);

    if(getdebugdvar("replay_debug") == "1")
      println("File: _friendlyfire.gsc. Function: debug_friendlyfire() - INNER LOOP WAIT\n");

    wait(0.25);

    if(getdebugdvar("replay_debug") == "1")
      println("File: _friendlyfire.gsc. Function: debug_friendlyfire() - INNER LOOP STOP\n");
  }

  if(getdebugdvar("replay_debug") == "1")
    println("File: _friendlyfire.gsc. Function: debug_friendlyfire() - COMPLLETE\n");
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

    if(damage < 1) {
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

    bPlayersDamage = false;

    if(isPlayer(attacker)) {
      bPlayersDamage = true;
    } else if((isDefined(attacker.classname)) && (attacker.classname == "script_vehicle")) {
      owner = attacker GetVehicleowner();

      if(isDefined(owner) && isPlayer(owner)) {
        bPlayersDamage = true;

        attacker = owner;
      }
    }

    if(!bPlayersDamage) {
      continue;
    }

    same_team = entity.team == attacker.team;
    killed = damage == -1;

    if(!same_team) {
      if(killed) {
        attacker.participation += level.friendlyfire["enemy_kill_points"];
        attacker participation_point_cap();
      } else {}

      return;
    } else {
      arcademode_assignpoints("arcademode_friendies_damage", attacker);

      if(killed) {
    } else {}
    }

    if(isDefined(entity.no_friendly_fire_penalty)) {
      continue;
    }

    if(killed) {
      attacker.participation += level.friendlyfire["friend_kill_points"];
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
  if(getDvar("friendlyfire_enabled") != "1") {
    if(!maps\_collectibles::has_collectible("collectible_hardcore")) {
      return;
    }
  }

  self endon("death");
  level endon("mine death");
  level notify("mission failed");

  if(level.campaign == "british") {
    setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_BRITISH");
  } else if(level.campaign == "russian") {
    setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_RUSSIAN");
  } else {
    setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
  }

  if(isDefined(level.custom_friendly_fire_shader))
    thread maps\_load::special_death_indicator_hudelement(level.custom_friendly_fire_shader, 64, 64, 0);

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