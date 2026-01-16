/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\emp_shared.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\killstreaks\emp_shared;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\weapons\weaponobjects;

#namespace emp;

init_shared() {
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
    callback::add_callback(#"hash_425352b435722271", &fx_flesh_hit_neck_fatal);
  }
}

fx_flesh_hit_neck_fatal(params) {
  foreach(player in params.players) {
    if(player hasactiveemp()) {
      scoregiven = scoreevents::processscoreevent(#"emp_assist", player, undefined, undefined);

      if(isDefined(scoregiven)) {
        player challenges::earnedempassistscore(scoregiven);
        killstreakindex = level.killstreakindices[#"emp"];
        killstreaks::killstreak_assist(player, self, killstreakindex);
      }
    }
  }
}

initturretvehicle() {
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

onplayerspawned() {
  self endon(#"disconnect");
  self updateemp();
}

onplayerconnect() {
  self.entnum = self getentitynumber();
  level.emp_shared.activeplayeremps[self.entnum] = 0;
}

deployempturret(emp) {
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

doneempfx(fxtagorigin) {
  playFX(#"killstreaks/fx_emp_exp_death", fxtagorigin);
  playsoundatposition(#"mpl_emp_turret_deactivate", fxtagorigin);
}

playempfx() {
  emp_vehicle = self;
  emp_vehicle playLoopSound(#"mpl_emp_turret_loop_close");
  waitframe(1);
}

on_timeout() {
  emp = self;

  if(isDefined(emp.vehicle)) {
    fxtagorigin = emp.vehicle gettagorigin("tag_fx");
    doneempfx(fxtagorigin);
  }

  shutdownemp(emp);
}

oncancelplacement(emp) {
  stopemp(emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid);
}

onturretdeath(inflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self ondeath(attacker, weapon);
}

ondeathafterframeend(attacker, weapon) {
  waittillframeend();

  if(isDefined(self)) {
    self ondeath(attacker, weapon);
  }
}

ondeath(attacker, weapon) {
  emp_vehicle = self;
  fxtagorigin = self gettagorigin("tag_fx");
  doneempfx(fxtagorigin);

  if(isDefined(level.var_b1ffcff8)) {
    self[[level.var_b1ffcff8]](attacker, weapon);
  }

  shutdownemp(emp_vehicle.parentstruct);
}

onshutdown(emp) {
  shutdownemp(emp);
}

shutdownemp(emp) {
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

stopemp(currentteam, currentownerentnum, originalteam, killstreakid) {
  stopempeffect(currentteam, currentownerentnum);
  stopemprule(originalteam, killstreakid);
}

stopempeffect(team, ownerentnum) {
  level.emp_shared.activeemps[team] = 0;
  level.emp_shared.activeplayeremps[ownerentnum] = 0;
  level notify(#"emp_updated");
}

stopemprule(killstreakoriginalteam, killstreakid) {
  killstreakrules::killstreakstop("emp", killstreakoriginalteam, killstreakid);
}

hasactiveemp() {
  return level.emp_shared.activeplayeremps[self.entnum];
}

teamhasactiveemp(team) {
  return level.emp_shared.activeemps[team] > 0;
}

getenemies() {
  enemies = [];
  combatants = level.players;

  if(sessionmodeiscampaigngame()) {
    combatants = arraycombine(combatants, getactorarray(), 0, 0);
  }

  foreach(combatant in combatants) {
    if(combatant.team === #"spectator") {
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

function_d12cde1c() {
  return isDefined(level.emp_shared);
}

enemyempactive() {
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

enemyempowner() {
  enemies = self getenemies();

  foreach(player in enemies) {
    if(player hasactiveemp()) {
      return player;
    }
  }

  return undefined;
}

emp_jamenemies(empent, hacked) {
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
  level killstreaks::destroyotherteamsactivevehicles(self, empkillstreakweapon, radius);
  level killstreaks::destroyotherteamsequipment(self, empkillstreakweapon, radius);
  level weaponobjects::destroy_other_teams_supplemental_watcher_objects(self, empkillstreakweapon, radius);
}

emptracker() {
  level endon(#"game_ended");

  while(true) {
    level waittill(#"emp_updated");

    foreach(player in level.players) {
      player updateemp();
    }
  }
}

updateemp() {
  player = self;
  enemy_emp_active = player enemyempactive();
  player setempjammed(enemy_emp_active);
  emped = player isempjammed();
  player clientfield::set_to_player("empd_monitor_distance", emped);

  if(emped) {
    player notify(#"emp_jammed");
  }
}