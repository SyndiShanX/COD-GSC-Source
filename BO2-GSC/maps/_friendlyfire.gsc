/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_friendlyfire.gsc
**************************************/

#include maps\_utility;
#include maps\_load_common;

main() {
  level.friendlyfire["min_participation"] = -1600;
  level.friendlyfire["max_participation"] = 1000;
  level.friendlyfire["enemy_kill_points"] = 250;
  level.friendlyfire["friend_kill_points"] = -600;
  level.friendlyfire["civ_kill_points"] = -900;
  level.friendlyfire["point_loss_interval"] = 0.75;
  setdvar("friendlyfire_enabled", "1");
  level.friendlyfire_override_attacker_entity = ::default_override_attacker_entity;

  if(coopgame())
    setdvar("friendlyfire_enabled", "0");

  if(!isDefined(level.friendlyfiredisabled))
    level.friendlyfiredisabled = 0;
}

default_override_attacker_entity(entity, damage, attacker, direction, point, method) {
  return undefined;
}

player_init() {
  self.participation = 0;
  self thread debug_friendlyfire();
  self thread participation_point_flattenovertime();
}

debug_friendlyfire() {
  self endon("disconnect");

  if(getdvar(#"_id_02C7E46E") == "")
    setdvar("debug_friendlyfire", "0");

  friendly_fire = newdebughudelem();
  friendly_fire.alignx = "right";
  friendly_fire.aligny = "middle";
  friendly_fire.x = 620;
  friendly_fire.y = 100;
  friendly_fire.fontscale = 2;
  friendly_fire.alpha = 0;

  for(;;) {
    if(getdvar(#"_id_02C7E46E") == "1")
      friendly_fire.alpha = 1;
    else
      friendly_fire.alpha = 0;

    friendly_fire setvalue(self.participation);
    wait 0.25;
  }

}

friendly_fire_callback(entity, damage, attacker, method) {
  if(!isDefined(entity)) {
    return;
  }
  if(!isDefined(entity.team))
    entity.team = "allies";

  if(!isDefined(entity)) {
    return;
  }
  if(entity.health <= 0) {
    return;
  }
  if(level.friendlyfiredisabled) {
    return;
  }
  if(isDefined(entity.nofriendlyfire) && entity.nofriendlyfire) {
    return;
  }
  if(!isDefined(attacker)) {
    return;
  }
  bplayersdamage = 0;

  if(isplayer(attacker))
    bplayersdamage = 1;
  else if(isDefined(attacker.classname) && attacker.classname == "script_vehicle") {
    owner = attacker getvehicleowner();

    if(isDefined(owner)) {
      if(isplayer(owner)) {
        if(!isDefined(owner.friendlyfire_attacker_not_vehicle_owner)) {
          bplayersdamage = 1;
          attacker = owner;
        }
      }
    }
  }

  if(!bplayersdamage) {
    return;
  }
  same_team = entity.team == attacker.team;

  if(attacker.team == "allies") {
    if(entity.team == "neutral" && !(isDefined(level.ignoreneutralfriendlyfire) && level.ignoreneutralfriendlyfire))
      same_team = 1;
  }

  if(entity.team != "neutral" || entity.team == "neutral" && !(isDefined(level.ignoreneutralfriendlyfire) && level.ignoreneutralfriendlyfire))
    attacker.last_hit_team = entity.team;

  killed = damage == -1;

  if(!same_team) {
    if(killed) {
      attacker.participation = attacker.participation + level.friendlyfire["enemy_kill_points"];
      attacker participation_point_cap();
    } else {
    }

    return;
  } else if(killed) {
  } else {
  }

  if(isDefined(entity.no_friendly_fire_penalty)) {
    return;
  }
  if(killed) {
    if(entity.team == "neutral") {
      level notify("player_killed_civ");

      if(attacker.participation <= 0)
        attacker.participation = attacker.participation + level.friendlyfire["min_participation"];
      else
        attacker.participation = attacker.participation + level.friendlyfire["civ_kill_points"];
    } else if(isDefined(entity) && isDefined(entity.ff_kill_penalty))
      attacker.participation = attacker.participation + entity.ff_kill_penalty;
    else
      attacker.participation = attacker.participation + level.friendlyfire["friend_kill_points"];
  } else
    attacker.participation = attacker.participation - damage;

  attacker participation_point_cap();

  if(check_grenade(entity, method) && savecommit_aftergrenade()) {
    if(killed)
      return;
    else
      return;
  }

  attacker friendly_fire_checkpoints();
}

friendly_fire_think(entity) {
  level endon("mission failed");
  entity endon("no_friendly_fire");

  if(!isDefined(entity)) {
    return;
  }
  if(!isDefined(entity.team))
    entity.team = "allies";

  for(;;) {
    if(!isDefined(entity)) {
      return;
    }
    entity waittill("damage", damage, attacker, undefined, undefined, method);

    if(level.friendlyfiredisabled) {
      continue;
    }
    if(!isDefined(entity)) {
      return;
    }
    if(isDefined(entity.nofriendlyfire) && entity.nofriendlyfire == 1) {
      continue;
    }
    if(!isDefined(attacker)) {
      continue;
    }
    bplayersdamage = 0;

    if(isplayer(attacker))
      bplayersdamage = 1;
    else if(isDefined(attacker.classname) && attacker.classname == "script_vehicle") {
      owner = attacker getvehicleowner();

      if(isDefined(owner)) {
        if(isplayer(owner)) {
          if(!isDefined(owner.friendlyfire_attacker_not_vehicle_owner)) {
            bplayersdamage = 1;
            attacker = owner;
          }
        }
      }
    }

    if(!bplayersdamage) {
      continue;
    }
    same_team = entity.team == attacker.team;

    if(attacker.team == "allies") {
      if(entity.team == "neutral" && !(isDefined(level.ignoreneutralfriendlyfire) && level.ignoreneutralfriendlyfire))
        same_team = 1;
    }

    if(entity.team != "neutral" || entity.team == "neutral" && !(isDefined(level.ignoreneutralfriendlyfire) && level.ignoreneutralfriendlyfire))
      attacker.last_hit_team = entity.team;

    killed = damage >= entity.health;

    if(!same_team) {
      if(killed) {
        attacker.participation = attacker.participation + level.friendlyfire["enemy_kill_points"];
        attacker participation_point_cap();
      }

      return;
    }

    if(isDefined(entity.no_friendly_fire_penalty)) {
      continue;
    }
    if(killed) {
      if(entity.team == "neutral") {
        level notify("player_killed_civ");

        if(attacker.participation <= 0)
          attacker.participation = attacker.participation + level.friendlyfire["min_participation"];
        else
          attacker.participation = attacker.participation + level.friendlyfire["civ_kill_points"];
      } else if(isDefined(entity) && isDefined(entity.ff_kill_penalty))
        attacker.participation = attacker.participation + entity.ff_kill_penalty;
      else
        attacker.participation = attacker.participation + level.friendlyfire["friend_kill_points"];
    } else
      attacker.participation = attacker.participation - damage;

    attacker participation_point_cap();

    if(check_grenade(entity, method) && savecommit_aftergrenade()) {
      if(killed)
        return;
      else
        continue;
    }

    attacker friendly_fire_checkpoints();
  }
}

friendly_fire_checkpoints() {
  if(self.participation <= level.friendlyfire["min_participation"])
    self thread missionfail();
}

check_grenade(entity, method) {
  if(!isDefined(entity))
    return 0;

  wasgrenade = 0;

  if(isDefined(entity.damageweapon) && entity.damageweapon == "none")
    wasgrenade = 1;

  if(isDefined(method) && method == "MOD_GRENADE_SPLASH")
    wasgrenade = 1;

  return wasgrenade;
}

savecommit_aftergrenade() {
  currenttime = gettime();

  if(currenttime < 4500) {
    println("^3aborting friendly fire because the level just loaded and saved and could cause a autosave grenade loop");

    return true;
  } else if(currenttime - level.lastautosavetime < 4500) {
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

  if(self.participation > level.friendlyfire["max_participation"])
    self.participation = level.friendlyfire["max_participation"];

  if(self.participation < level.friendlyfire["min_participation"])
    self.participation = level.friendlyfire["min_participation"];
}

participation_point_flattenovertime() {
  level endon("mission failed");
  level endon("friendly_fire_terminate");
  self endon("disconnect");

  for(;;) {
    if(self.participation > 0)
      self.participation--;
    else if(self.participation < 0)
      self.participation++;

    wait(level.friendlyfire["point_loss_interval"]);
  }
}

turnbackon() {
  level.friendlyfiredisabled = 0;
}

turnoff() {
  level.friendlyfiredisabled = 1;
}

missionfail() {
  self endon("death");
  level endon("mine death");
  level notify("mission failed");

  if(isDefined(self.last_hit_team) && self.last_hit_team == "neutral")
    setdvar("ui_deadquote", & "SCRIPT_MISSIONFAIL_KILLTEAM_NEUTRAL");
  else if(level.campaign == "british")
    setdvar("ui_deadquote", & "SCRIPT_MISSIONFAIL_KILLTEAM_BRITISH");
  else if(level.campaign == "russian")
    setdvar("ui_deadquote", & "SCRIPT_MISSIONFAIL_KILLTEAM_RUSSIAN");
  else
    setdvar("ui_deadquote", & "SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");

  if(isDefined(level.custom_friendly_fire_shader))
    thread maps\_load_common::special_death_indicator_hudelement(level.custom_friendly_fire_shader, 64, 64, 0);

  logstring("failed mission: Friendly fire");
  maps\_utility::missionfailedwrapper();
}

notifydamage(entity) {
  level endon("mission failed");
  entity endon("death");

  for(;;) {
    entity waittill("damage", damage, attacker, undefined, undefined, method);
    entity notify("friendlyfire_notify", damage, attacker, undefined, undefined, method);
  }
}

notifydamagenotdone(entity) {
  level endon("mission failed");
  entity waittill("damage_notdone", damage, attacker, undefined, undefined, method);
  entity notify("friendlyfire_notify", -1, attacker, undefined, undefined, method);
}

notifydeath(entity) {
  level endon("mission failed");
  entity waittill("death", attacker, method);
  entity notify("friendlyfire_notify", -1, attacker, undefined, undefined, method);
}