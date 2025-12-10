/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\killstreaks_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\table_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_raps;
#using scripts\shared\weapons\_tacticalinsertion;
#using scripts\shared\weapons\_weaponobjects;
#namespace killstreaks;

function is_killstreak_weapon(weapon) {
  if(weapon == level.weaponnone || weapon.notkillstreak) {
    return false;
  }
  if(weapon.isspecificuse || is_weapon_associated_with_killstreak(weapon)) {
    return true;
  }
  return false;
}

function is_weapon_associated_with_killstreak(weapon) {
  return isDefined(level.killstreakweapons) && isDefined(level.killstreakweapons[weapon]);
}

function switch_to_last_non_killstreak_weapon(immediate, awayfromball) {
  ball = getweapon("ball");
  if(isDefined(ball) && self hasweapon(ball) && (!(isDefined(awayfromball) && awayfromball))) {
    self switchtoweaponimmediate(ball);
    self disableweaponcycling();
    self disableoffhandweapons();
  } else {
    if(isDefined(self.laststand) && self.laststand) {
      if(isDefined(self.laststandpistol) && self hasweapon(self.laststandpistol)) {
        self switchtoweapon(self.laststandpistol);
      }
    } else {
      if(isDefined(self.lastnonkillstreakweapon) && self hasweapon(self.lastnonkillstreakweapon)) {
        if(self.lastnonkillstreakweapon.isheroweapon) {
          if(self.lastnonkillstreakweapon.gadget_heroversion_2_0) {
            if(self.lastnonkillstreakweapon.isgadget && self getammocount(self.lastnonkillstreakweapon) > 0) {
              slot = self gadgetgetslot(self.lastnonkillstreakweapon);
              if(self ability_player::gadget_is_in_use(slot)) {
                return self switchtoweapon(self.lastnonkillstreakweapon);
              }
              return 1;
            }
          } else if(self getammocount(self.lastnonkillstreakweapon) > 0) {
            return self switchtoweapon(self.lastnonkillstreakweapon);
          }
          if(isDefined(awayfromball) && awayfromball && isDefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
            self switchtoweapon(self.lastdroppableweapon);
          } else {
            self switchtoweapon();
          }
          return 1;
        }
        if(isDefined(immediate) && immediate) {
          self switchtoweaponimmediate(self.lastnonkillstreakweapon);
        } else {
          self switchtoweapon(self.lastnonkillstreakweapon);
        }
      } else {
        if(isDefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
          self switchtoweapon(self.lastdroppableweapon);
        } else {
          return 0;
        }
      }
    }
  }
  return 1;
}

function get_killstreak_weapon(killstreak) {
  if(!isDefined(killstreak)) {
    return level.weaponnone;
  }
  assert(isDefined(level.killstreaks[killstreak]));
  return level.killstreaks[killstreak].weapon;
}

function isheldinventorykillstreakweapon(killstreakweapon) {
  switch (killstreakweapon.name) {
    case "inventory_m32":
    case "inventory_minigun": {
      return true;
    }
  }
  return false;
}

function waitfortimecheck(duration, callback, endcondition1, endcondition2, endcondition3) {
  self endon("hacked");
  if(isDefined(endcondition1)) {
    self endon(endcondition1);
  }
  if(isDefined(endcondition2)) {
    self endon(endcondition2);
  }
  if(isDefined(endcondition3)) {
    self endon(endcondition3);
  }
  hostmigration::migrationawarewait(duration);
  self notify("time_check");
  self[[callback]]();
}

function emp_isempd() {
  if(isDefined(level.enemyempactivefunc)) {
    return self[[level.enemyempactivefunc]]();
  }
  return 0;
}

function waittillemp(onempdcallback, arg) {
  self endon("death");
  self endon("delete");
  self waittill("emp_deployed", attacker);
  if(isDefined(onempdcallback)) {
    [[onempdcallback]](attacker, arg);
  }
}

function hasuav(team_or_entnum) {
  return level.activeuavs[team_or_entnum] > 0;
}

function hassatellite(team_or_entnum) {
  return level.activesatellites[team_or_entnum] > 0;
}

function destroyotherteamsequipment(attacker, weapon) {
  foreach(team in level.teams) {
    if(team == attacker.team) {
      continue;
    }
    destroyequipment(attacker, team, weapon);
    destroytacticalinsertions(attacker, team);
  }
  destroyequipment(attacker, "free", weapon);
  destroytacticalinsertions(attacker, "free");
}

function destroyequipment(attacker, team, weapon) {
  for(i = 0; i < level.missileentities.size; i++) {
    item = level.missileentities[i];
    if(!isDefined(item.weapon)) {
      continue;
    }
    if(!isDefined(item.owner)) {
      continue;
    }
    if(isDefined(team) && item.owner.team != team) {
      continue;
    } else if(item.owner == attacker) {
      continue;
    }
    if(!item.weapon.isequipment && (!(isDefined(item.destroyedbyemp) && item.destroyedbyemp))) {
      continue;
    }
    watcher = item.owner weaponobjects::getwatcherforweapon(item.weapon);
    if(!isDefined(watcher)) {
      continue;
    }
    watcher thread weaponobjects::waitanddetonate(item, 0, attacker, weapon);
  }
}

function destroytacticalinsertions(attacker, victimteam) {
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(!isDefined(player.tacticalinsertion)) {
      continue;
    }
    if(level.teambased && player.team != victimteam) {
      continue;
    }
    if(attacker == player) {
      continue;
    }
    player.tacticalinsertion thread tacticalinsertion::fizzle();
  }
}

function destroyotherteamsactivevehicles(attacker, weapon) {
  foreach(team in level.teams) {
    if(team == attacker.team) {
      continue;
    }
    destroyactivevehicles(attacker, team, weapon);
  }
  destroyneutralgameplayvehicles(attacker, weapon);
}

function destroyneutralgameplayvehicles(attacker, weapon) {
  script_vehicles = getEntArray("script_vehicle", "classname");
  foreach(vehicle in script_vehicles) {
    if(isvehicle(vehicle) && (!isDefined(vehicle.team) || vehicle.team == "neutral")) {
      if(isDefined(vehicle.detonateviaemp) && (isDefined(weapon.isempkillstreak) && weapon.isempkillstreak)) {
        vehicle[[vehicle.detonateviaemp]](attacker, weapon);
      }
      if(isDefined(vehicle.archetype)) {
        if(vehicle.archetype == "siegebot") {
          vehicle dodamage(vehicle.health + 1, vehicle.origin, attacker, attacker, "", "MOD_EXPLOSIVE", 0, weapon);
        }
      }
    }
  }
}

function destroyactivevehicles(attacker, team, weapon) {
  targets = target_getarray();
  destroyentities(targets, attacker, team, weapon);
  ai_tanks = getEntArray("talon", "targetname");
  destroyentities(ai_tanks, attacker, team, weapon);
  remotemissiles = getEntArray("remote_missile", "targetname");
  destroyentities(remotemissiles, attacker, team, weapon);
  remotedrone = getEntArray("remote_drone", "targetname");
  destroyentities(remotedrone, attacker, team, weapon);
  script_vehicles = getEntArray("script_vehicle", "classname");
  foreach(vehicle in script_vehicles) {
    if(isDefined(team) && vehicle.team == team && isvehicle(vehicle)) {
      if(isDefined(vehicle.detonateviaemp) && (isDefined(weapon.isempkillstreak) && weapon.isempkillstreak)) {
        vehicle[[vehicle.detonateviaemp]](attacker, weapon);
      }
      if(isDefined(vehicle.archetype)) {
        if(vehicle.archetype == "raps") {
          vehicle raps::detonate(attacker);
          continue;
        }
        if(vehicle.archetype == "turret" || vehicle.archetype == "rcbomb" || vehicle.archetype == "wasp" || vehicle.archetype == "siegebot") {
          vehicle dodamage(vehicle.health + 1, vehicle.origin, attacker, attacker, "", "MOD_EXPLOSIVE", 0, weapon);
        }
      }
    }
  }
  planemortars = getEntArray("plane_mortar", "targetname");
  foreach(planemortar in planemortars) {
    if(isDefined(team) && isDefined(planemortar.team)) {
      if(planemortar.team != team) {
        continue;
      }
    } else if(planemortar.owner == attacker) {
      continue;
    }
    planemortar notify("emp_deployed", attacker);
  }
  dronestrikes = getEntArray("drone_strike", "targetname");
  foreach(dronestrike in dronestrikes) {
    if(isDefined(team) && isDefined(dronestrike.team)) {
      if(dronestrike.team != team) {
        continue;
      }
    } else if(dronestrike.owner == attacker) {
      continue;
    }
    dronestrike notify("emp_deployed", attacker);
  }
  counteruavs = getEntArray("counteruav", "targetname");
  foreach(counteruav in counteruavs) {
    if(isDefined(team) && isDefined(counteruav.team)) {
      if(counteruav.team != team) {
        continue;
      }
    } else if(counteruav.owner == attacker) {
      continue;
    }
    counteruav notify("emp_deployed", attacker);
  }
  satellites = getEntArray("satellite", "targetname");
  foreach(satellite in satellites) {
    if(isDefined(team) && isDefined(satellite.team)) {
      if(satellite.team != team) {
        continue;
      }
    } else if(satellite.owner == attacker) {
      continue;
    }
    satellite notify("emp_deployed", attacker);
  }
  robots = getaiarchetypearray("robot");
  foreach(robot in robots) {
    if(robot.allowdeath !== 0 && robot.magic_bullet_shield !== 1 && isDefined(team) && robot.team == team) {
      if(isDefined(attacker) && (!isDefined(robot.owner) || robot.owner util::isenemyplayer(attacker))) {
        scoreevents::processscoreevent("destroyed_combat_robot", attacker, robot.owner, weapon);
        luinotifyevent(&"player_callout", 2, &"KILLSTREAK_DESTROYED_COMBAT_ROBOT", attacker.entnum);
      }
      robot kill();
    }
  }
  if(isDefined(level.missile_swarm_owner)) {
    if(level.missile_swarm_owner util::isenemyplayer(attacker)) {
      level.missile_swarm_owner notify("emp_destroyed_missile_swarm", attacker);
    }
  }
}

function destroyentities(entities, attacker, team, weapon) {
  meansofdeath = "MOD_EXPLOSIVE";
  damage = 5000;
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  modelname = "";
  tagname = "";
  partname = "";
  foreach(entity in entities) {
    if(isDefined(team) && isDefined(entity.team)) {
      if(entity.team != team) {
        continue;
      }
    } else if(isDefined(entity.owner) && entity.owner == attacker) {
      continue;
    }
    entity notify("damage", damage, attacker, direction_vec, point, meansofdeath, tagname, modelname, partname, weapon);
  }
}