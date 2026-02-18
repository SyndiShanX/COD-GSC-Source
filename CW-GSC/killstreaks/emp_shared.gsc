/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\emp_shared.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\emp_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\weaponobjects;
#namespace emp;

function init_shared() {
  if(!isDefined(level.emp_shared)) {
    level.emp_shared = {};
    level.emp_shared.activeplayeremps = [];
    level.emp_shared.activeemps = [];

    foreach(team, _ in level.teams) {
      level.emp_shared.activeemps[team] = 0;
    }

    level.emp_shared.enemyempactivefunc = &enemyempactive;
    level thread emptracker();
    clientfield::register("scriptmover", "emp_turret_init", 1, 1, "int");
    clientfield::register("vehicle", "emp_turret_deploy", 1, 1, "int");
    callback::on_spawned(&onplayerspawned);
    callback::on_connect(&onplayerconnect);
    vehicle::add_main_callback("emp_turret", &initturretvehicle);
    callback::add_callback(#"hash_7c6da2f2c9ef947a", &fx_flesh_hit_neck_fatal);
  }
}

function fx_flesh_hit_neck_fatal(params) {
  foreach(player in params.players) {
    if(player hasactiveemp()) {
      scoregiven = scoreevents::processscoreevent(#"emp_assist", player, undefined, undefined);

      if(isDefined(scoregiven)) {
        player challenges::earnedempassistscore(scoregiven);
        killstreakindex = level.killstreakindices[# "emp"];
        killstreaks::killstreak_assist(player, self, killstreakindex);
      }
    }
  }
}

function initturretvehicle() {
  turretvehicle = self;
  turretvehicle killstreaks::setup_health("emp");
  turretvehicle.damagetaken = 0;
  turretvehicle.health = turretvehicle.maxhealth;
  turretvehicle clientfield::set("enemyvehicle", 1);
  turretvehicle.soundmod = "drone_land";
  turretvehicle.overridevehiclekilled = &onturretdeath;
  target_set(turretvehicle, (0, 0, 36));

  if(isDefined(level.var_389a99a4)) {
    turretvehicle[[level.var_389a99a4]]();
  }
}

function onplayerspawned() {
  self endon(#"disconnect");
  self updateemp();
}

function onplayerconnect() {
  self.entnum = self getentitynumber();
  level.emp_shared.activeplayeremps[self.entnum] = 0;
}

function deployempturret(emp) {
  player = self;
  player endon(#"disconnect", #"joined_team", #"joined_spectators");
  emp endon(#"death");
  emp.vehicle useanimtree("generic");
  emp.vehicle setanim(#"o_turret_emp_core_deploy", 1);
  length = getanimlength(#"o_turret_emp_core_deploy");
  emp.vehicle clientfield::set("emp_turret_deploy", 1);
  wait length * 0.75;
  emp.vehicle thread playempfx();
  emp.vehicle playSound(#"mpl_emp_turret_activate");
  emp.vehicle setanim(#"o_turret_emp_core_spin", 1);
  player thread emp_jamenemies(emp, 0);
  wait length * 0.25;
  emp.vehicle clearanim(#"o_turret_emp_core_deploy", 0);
}

function doneempfx(fxtagorigin) {
  params = getscriptbundle("killstreak_bundle");
  playFX(params.ksexplosionfx, fxtagorigin);
  playsoundatposition(#"mpl_emp_turret_deactivate", fxtagorigin);
}

function playempfx() {
  emp_vehicle = self;
  emp_vehicle playLoopSound(#"mpl_emp_turret_loop_close");
  waitframe(1);
}

function on_timeout() {
  emp = self;

  if(isDefined(emp.vehicle)) {
    fxtagorigin = emp.vehicle gettagorigin("tag_fx");
    doneempfx(fxtagorigin);
  }

  shutdownemp(emp);
}

function oncancelplacement(emp) {
  stopemp(emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid);
}

function onturretdeath(inflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self ondeath(shitloc, psoffsettime);
}

function ondeathafterframeend(attacker, weapon) {
  waittillframeend();

  if(isDefined(self)) {
    self ondeath(attacker, weapon);
  }
}

function ondeath(attacker, weapon) {
  emp_vehicle = self;
  fxtagorigin = self gettagorigin("tag_fx");
  doneempfx(fxtagorigin);

  if(isDefined(level.var_b1ffcff8)) {
    self[[level.var_b1ffcff8]](attacker, weapon);
  }

  shutdownemp(emp_vehicle.parentstruct);
}

function onshutdown(emp) {
  shutdownemp(emp);
}

function shutdownemp(emp) {
  if(!isDefined(emp)) {
    return;
  }

  if(isDefined(emp.already_shutdown)) {
    return;
  }

  emp.already_shutdown = 1;

  if(isDefined(emp.vehicle)) {
    emp.vehicle clientfield::set("emp_turret_deploy", 0);
  }

  stopemp(emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid);

  if(isDefined(emp.othermodel)) {
    emp.othermodel delete();
  }

  if(isDefined(emp.vehicle)) {
    emp.vehicle delete();
  }

  emp delete();
}

function stopemp(currentteam, currentownerentnum, originalteam, killstreakid) {
  stopempeffect(currentteam, currentownerentnum);
  stopemprule(originalteam, killstreakid);
}

function stopempeffect(team, ownerentnum) {
  level.emp_shared.activeemps[team] = 0;
  level.emp_shared.activeplayeremps[ownerentnum] = 0;
  level notify(#"emp_updated");
}

function stopemprule(killstreakoriginalteam, killstreakid) {
  killstreakrules::killstreakstop("emp", killstreakoriginalteam, killstreakid);
}

function hasactiveemp() {
  return level.emp_shared.activeplayeremps[self.entnum];
}

function teamhasactiveemp(team) {
  return level.emp_shared.activeemps[team] > 0;
}

function getenemies() {
  enemies = [];
  combatants = level.players;

  if(sessionmodeiscampaigngame()) {
    combatants = arraycombine(combatants, getactorarray(), 0, 0);
  }

  foreach(combatant in combatants) {
    if(combatant.team === # "spectator") {
      continue;
    }

    if(level.teambased && util::function_fbce7263(combatant.team, self.team) || !level.teambased && combatant != self) {
      if(!isDefined(enemies)) {
        enemies = [];
      } else if(!isarray(enemies)) {
        enemies = array(enemies);
      }

      enemies[enemies.size] = combatant;
    }
  }

  return enemies;
}

function function_d12cde1c() {
  return isDefined(level.emp_shared);
}

function enemyempactive() {
  if(!function_d12cde1c()) {
    return false;
  }

  if(level.teambased) {
    foreach(team, _ in level.teams) {
      if(util::function_fbce7263(team, self.team) && teamhasactiveemp(team)) {
        return true;
      }
    }
  } else {
    enemies = self getenemies();

    foreach(player in enemies) {
      if(player hasactiveemp()) {
        return true;
      }
    }
  }

  return false;
}

function enemyempowner() {
  enemies = self getenemies();

  foreach(player in enemies) {
    if(player hasactiveemp()) {
      return player;
    }
  }

  return undefined;
}

function emp_jamenemies(empent, hacked) {
  level endon(#"game_ended");
  self endon(#"killstreak_hacked");

  if(level.teambased) {
    if(hacked) {
      level.emp_shared.activeemps[empent.originalteam] = 0;
    }

    level.emp_shared.activeemps[self.team] = 1;
  }

  if(hacked) {
    level.emp_shared.activeplayeremps[empent.originalownerentnum] = 0;
  }

  level.emp_shared.activeplayeremps[self.entnum] = 1;
  level notify(#"emp_updated");
  level notify(#"emp_deployed");
  visionsetnaked("flash_grenade", 1.5);
  wait 0.1;
  visionsetnaked("flash_grenade", 0);
  visionsetnaked("default", 5);
  radius = isDefined(level.empkillstreakbundle.ksdamageradius) ? level.empkillstreakbundle.ksdamageradius : 750;
  empkillstreakweapon = getweapon(#"emp");
  empkillstreakweapon.isempkillstreak = 1;
  level destroyotherteamsactivevehicles(self, empkillstreakweapon, radius);
  level destroyotherteamsequipment(self, empkillstreakweapon, radius);
  level weaponobjects::destroy_other_teams_supplemental_watcher_objects(self, empkillstreakweapon, radius);
}

function emptracker() {
  level endon(#"game_ended");

  while(true) {
    level waittill(#"emp_updated");

    foreach(player in level.players) {
      player updateemp();
    }
  }
}

function updateemp() {
  player = self;
  enemy_emp_active = player enemyempactive();
  player setempjammed(enemy_emp_active);
  emped = player isempjammed();
  player clientfield::set_to_player("empd_monitor_distance", emped);

  if(emped) {
    player notify(#"emp_jammed");
  }
}

function destroyotherteamsequipment(attacker, weapon, radius) {
  foreach(team, _ in level.teams) {
    if(!util::function_fbce7263(team, attacker.team)) {
      continue;
    }

    destroyequipment(attacker, team, weapon, radius);
    destroytacticalinsertions(attacker, team, radius);
  }

  destroyequipment(attacker, #"none", weapon, radius);
  destroytacticalinsertions(attacker, #"none", radius);
}

function destroyequipment(attacker, team, weapon, radius) {
  radiussq = radius * radius;

  for(i = 0; i < level.missileentities.size; i++) {
    item = level.missileentities[i];

    if(!isDefined(item)) {
      continue;
    }

    if(distancesquared(item.origin, attacker.origin) > radiussq) {
      continue;
    }

    if(!isDefined(item.weapon)) {
      continue;
    }

    if(!isDefined(item.owner)) {
      continue;
    }

    if(isDefined(team) && util::function_fbce7263(item.owner.team, team)) {
      continue;
    } else if(item.owner == attacker) {
      continue;
    }

    if(!item.weapon.isequipment && !is_true(item.destroyedbyemp)) {
      continue;
    }

    watcher = item.owner weaponobjects::getwatcherforweapon(item.weapon);

    if(!isDefined(watcher)) {
      continue;
    }

    watcher thread weaponobjects::waitanddetonate(item, 0, attacker, weapon);
  }
}

function destroytacticalinsertions(attacker, victimteam, radius) {
  radiussq = radius * radius;

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(!isDefined(player.tacticalinsertion)) {
      continue;
    }

    if(level.teambased && util::function_fbce7263(player.team, victimteam)) {
      continue;
    }

    if(attacker == player) {
      continue;
    }

    if(distancesquared(player.origin, attacker.origin) < radiussq) {
      if(isDefined(level.var_8ee772a3)) {
        player.tacticalinsertion thread[[level.var_8ee772a3]]();
      }
    }
  }
}

function destroyotherteamsactivevehicles(attacker, weapon, radius) {
  foreach(team, _ in level.teams) {
    if(!util::function_fbce7263(team, attacker.team)) {
      continue;
    }

    destroyactivevehicles(attacker, team, weapon, radius);
  }
}

function private destroyactivevehicles(attacker, team, weapon, radius) {
  radiussq = radius * radius;
  targets = target_getarray();
  destroyentities(targets, attacker, team, weapon, radius);
  ai_tanks = getEntArray("talon", "targetname");
  destroyentities(ai_tanks, attacker, team, weapon, radius);
  remotemissiles = getEntArray("remote_missile", "targetname");
  destroyentities(remotemissiles, attacker, team, weapon, radius);
  remotedrone = getEntArray("remote_drone", "targetname");
  destroyentities(remotedrone, attacker, team, weapon, radius);
  script_vehicles = getEntArray("script_vehicle", "classname");

  foreach(vehicle in script_vehicles) {
    if(distancesquared(vehicle.origin, attacker.origin) > radiussq) {
      continue;
    }

    if(isDefined(team) && !util::function_fbce7263(vehicle.team, team) && isvehicle(vehicle)) {
      if(isDefined(vehicle.detonateviaemp) && is_true(weapon.isempkillstreak)) {
        vehicle[[vehicle.detonateviaemp]](attacker, weapon);
      }

      if(isDefined(vehicle.archetype)) {
        if(vehicle.archetype == "turret" || vehicle.archetype == "rcbomb" || vehicle.archetype == "wasp") {
          vehicle dodamage(vehicle.health + 1, vehicle.origin, attacker, attacker, "", "MOD_EXPLOSIVE", 0, weapon);
        }
      }
    }
  }

  planemortars = getEntArray("plane_mortar", "targetname");

  foreach(planemortar in planemortars) {
    if(distance2d(planemortar.origin, attacker.origin) > radius) {
      continue;
    }

    if(isDefined(team) && isDefined(planemortar.team)) {
      if(util::function_fbce7263(planemortar.team, team)) {
        continue;
      }
    } else if(planemortar.owner == attacker) {
      continue;
    }

    planemortar notify(#"emp_deployed", {
      #attacker: attacker
    });
  }

  dronestrikes = getEntArray("drone_strike", "targetname");

  foreach(dronestrike in dronestrikes) {
    if(distance2d(dronestrike.origin, attacker.origin) > radius) {
      continue;
    }

    if(isDefined(team) && isDefined(dronestrike.team)) {
      if(util::function_fbce7263(dronestrike.team, team)) {
        continue;
      }
    } else if(dronestrike.owner == attacker) {
      continue;
    }

    dronestrike notify(#"emp_deployed", {
      #attacker: attacker
    });
  }

  var_eca5110 = getEntArray("guided_artillery_shell", "targetname");

  foreach(shell in var_eca5110) {
    if(distance2d(shell.origin, attacker.origin) > radius) {
      continue;
    }

    if(isDefined(team) && isDefined(shell.team)) {
      if(util::function_fbce7263(shell.team, team)) {
        continue;
      }
    } else if(shell.owner == attacker) {
      continue;
    }

    shell notify(#"emp_deployed", {
      #attacker: attacker
    });
  }

  counteruavs = getEntArray("counteruav", "targetname");

  foreach(counteruav in counteruavs) {
    if(distance2d(counteruav.origin, attacker.origin) > radius) {
      continue;
    }

    if(isDefined(team) && isDefined(counteruav.team)) {
      if(util::function_fbce7263(counteruav.team, team)) {
        continue;
      }
    } else if(counteruav.owner == attacker) {
      continue;
    }

    counteruav notify(#"emp_deployed", {
      #attacker: attacker
    });
  }

  satellites = getEntArray("satellite", "targetname");

  foreach(satellite in satellites) {
    if(distance2d(satellite.origin, attacker.origin) > radius) {
      continue;
    }

    if(isDefined(team) && isDefined(satellite.team)) {
      if(util::function_fbce7263(satellite.team, team)) {
        continue;
      }
    } else if(satellite.owner == attacker) {
      continue;
    }

    satellite notify(#"emp_deployed", {
      #attacker: attacker
    });
  }

  robots = getaiarchetypearray("robot");

  foreach(robot in robots) {
    if(distancesquared(robot.origin, attacker.origin) > radiussq) {
      continue;
    }

    if(robot.allowdeath !== 0 && robot.magic_bullet_shield !== 1 && isDefined(team) && !util::function_fbce7263(robot.team, team)) {
      if(isDefined(attacker) && (!isDefined(robot.owner) || robot.owner util::isenemyplayer(attacker))) {
        scoreevents::processscoreevent(#"destroyed_combat_robot", attacker, robot.owner, weapon);
        luinotifyevent(#"player_callout", 2, #"hash_3b274c8c3c961f3", attacker.entnum);
      }

      robot kill();
    }
  }

  if(isDefined(level.missile_swarm_owner)) {
    if(level.missile_swarm_owner util::isenemyplayer(attacker)) {
      if(distancesquared(level.missile_swarm_owner.origin, attacker.origin) < radiussq) {
        level.missile_swarm_owner notify(#"emp_destroyed_missile_swarm", {
          #attacker: attacker
        });
      }
    }
  }
}

function private destroyentities(entities, attacker, team, weapon, radius) {
  meansofdeath = "MOD_EXPLOSIVE";
  damage = 5000;
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  modelname = "";
  tagname = "";
  partname = "";
  radiussq = radius * radius;

  foreach(entity in entities) {
    if(isDefined(team) && isDefined(entity.team)) {
      if(util::function_fbce7263(entity.team, team)) {
        continue;
      }
    } else if(isDefined(entity.owner) && entity.owner == attacker) {
      continue;
    }

    if(distancesquared(entity.origin, attacker.origin) < radiussq) {
      entity notify(#"damage", {
        #amount: damage, #attacker: attacker, #direction: direction_vec, #position: point, #mod: meansofdeath, #tag_name: tagname, #model_name: modelname, #part_name: partname, #weapon: weapon
      });
    }
  }
}