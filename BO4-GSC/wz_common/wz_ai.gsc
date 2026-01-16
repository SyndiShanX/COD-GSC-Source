/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_ai.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_drop;

#namespace wz_ai;

autoexec __init__system__() {
  system::register(#"wz_ai", &__init__, undefined, undefined);
}

private __init__() {
  clientfield::register("vehicle", "enable_on_radar", 1, 1, "int");
  clientfield::register("actor", "enable_on_radar", 1, 1, "int");
}

ai_init() {
  function_41822a58();
}

function_41822a58() {
  if(getdvarint(#"hash_20cd968623dbb8ef", 0)) {
    patrolspawns = struct::get_array("wz_patrol_loc", "targetname");

    foreach(spot in patrolspawns) {
      level thread function_afce0cdb(spot);
    }
  }
}

function_afce0cdb(spawn_loc) {
  level endon(#"game_ended");

  if(!ispointonnavmesh(spawn_loc.origin)) {
    return;
  }

  parms = strtok(spawn_loc.script_parameters, ";");
  assert(parms.size == 5);
  zone = spawnStruct();

  if(!isDefined(zone)) {
    return;
  }

  zone.name = parms[0];
  zone.volume = getent(zone.name, "targetname");
  zone.mins = zone.volume.origin + zone.volume.mins;
  zone.maxs = zone.volume.origin + zone.volume.maxs;
  zone.var_c6328f73 = int(parms[1]);
  zone.is_vehicle = int(parms[2]);
  zone.fovcosine = cos(int(parms[4]));
  zone.goalradius = isDefined(spawn_loc.radius) ? spawn_loc.radius : 4096;
  zone.maxsightdistsqrd = int(parms[3]) * int(parms[3]);
  zone.type = spawn_loc.script_noteworthy;
  zone thread function_77a4c7ab();
  patroller = undefined;

  while(true) {
    if(zone.var_c6328f73 < 1) {
      return;
    }

    while(!(isDefined(zone.is_occupied) && zone.is_occupied)) {
      wait randomintrange(2, 6);
    }

    if(!isDefined(patroller)) {
      if(isDefined(zone.is_vehicle) && zone.is_vehicle) {
        patroller = spawnvehicle(spawn_loc.script_noteworthy, spawn_loc.origin, (0, 0, 0), "wz_patrol_veh_ai");
      } else {
        patroller = spawnactor(spawn_loc.script_noteworthy, spawn_loc.origin, (0, 0, 0), "wz_patrol_ai");
      }

      if(isDefined(patroller)) {
        patroller clientfield::set("enable_on_radar", 1);
        patroller.goalradius = zone.goalradius;
        patroller.maxsightdistsqrd = zone.maxsightdistsqrd;
        patroller.fovcosine = zone.fovcosine;
        patroller.zone = zone;

        if(patroller.archetype === #"amws") {
          patroller.scan_turret = 1;
          patroller.var_9b4a5686 = 1;
          patroller.var_a8c60b0e = 1;
        }

        if(isDefined(spawn_loc.target)) {
          node = getnode(spawn_loc.target, "targetname");

          if(isDefined(node)) {
            patroller thread function_f8e46115(node, patroller.goalradius);
          } else {
            patroller setgoal(patroller.origin);
          }
        } else {
          patroller setgoal(patroller.origin);
        }

        patroller thread function_b25a6169();
        patroller thread function_7820dead();
        zone thread function_9fc23101(patroller);
        zone thread function_af46682(patroller);
      }
    }

    while(isDefined(zone.is_occupied) && zone.is_occupied) {
      wait randomintrange(2, 6);
    }

    if(isDefined(patroller)) {
      patroller delete();
    }
  }
}

function_f7c5e2f0(point, mins, maxs) {
  return point[0] >= mins[0] && point[0] <= maxs[0] && point[1] >= mins[1] && point[1] <= maxs[1] && point[2] >= mins[2] && point[2] <= maxs[2];
}

function_77a4c7ab() {
  level endon(#"game_ended");
  self.is_occupied = 0;

  while(true) {
    self.is_occupied = 0;

    foreach(player in getplayers()) {
      if(!isDefined(player) || !isalive(player)) {
        continue;
      }

      istouching = player istouching(self.volume);

      if(istouching) {
        self.is_occupied = 1;
        break;
      }
    }

    wait randomfloatrange(2, 4);
  }
}

function_c5fad73b(type) {
  items = [];

  switch (type) {
    case #"hash_33ccea7be2e5f439":
      break;
    default:
      break;
  }

  return items;
}

function_9fc23101(patroller) {
  type = patroller.type;
  waitresult = patroller waittill(#"death");
  attacker = waitresult.attacker;

  if(isDefined(attacker) && attacker != patroller) {
    self.var_c6328f73--;
  }
}

function_ff88da82(origin, angles, items) {
  if(!items.size) {
    return;
  }
}

function_f8e46115(node, oldgoalradius) {
  self endon(#"death");
  level endon(#"game_ended");
  self notify("488af40167c3a4a7");
  self endon("488af40167c3a4a7");

  if(isDefined(self.enemy)) {
    self.goalradius = oldgoalradius;
    wait randomintrange(3, 6);
    self thread function_f8e46115(node, oldgoalradius);
    return;
  }

  if(!isDefined(node)) {
    self setgoal(self.origin);
    self.goalradius = oldgoalradius;
    return;
  } else {
    if(isDefined(node.radius)) {
      self.goalradius = node.radius;
    } else {
      self.goalradius = 512;
    }

    self setgoal(node);
  }

  if(isDefined(self.scan_turret) && self.scan_turret) {
    self turretsettargetangles(0, (0, self.angles[1], 0));
  }

  isatgoal = 0;

  while(!isatgoal) {
    goalinfo = self function_4794d6a3();
    isatgoal = isDefined(goalinfo.isatgoal) && goalinfo.isatgoal || self isapproachinggoal() && isDefined(self.overridegoalpos);
    wait 1;
  }

  if(isDefined(node.target)) {
    self thread function_f8e46115(getnode(node.target, "targetname"), oldgoalradius);
  }
}

function_7820dead() {
  self endon(#"death");
  level endon(#"game_ended");
  self notify("27ad2aca1861b8c8");
  self endon("27ad2aca1861b8c8");
  waitresult = self waittill(#"damage");

  if(isDefined(waitresult.attacker) && isplayer(waitresult.attacker)) {
    self.favoriteenemy = waitresult.attacker;
    wait 5;
    self.favoriteenemy = undefined;
  }

  self thread function_7820dead();
}

function_b25a6169() {
  self endon(#"death");
  level endon(#"game_ended");
  self notify("7c5dbe7edcfd4795");
  self endon("7c5dbe7edcfd4795");
  goalradius = self.goalradius;
  misscount = 5;

  while(true) {
    if(isDefined(self.enemy)) {
      self.goalradius = 1024;

      if(!self cansee(self.enemy)) {
        misscount--;

        if(misscount < 1) {
          self clearenemy();
          misscount = 5;
        }
      } else {
        self setgoal(self.enemy.origin);
      }
    } else {
      self.goalradius = goalradius;

      if(isDefined(self.scan_turret) && self.scan_turret) {
        if(randomint(100) > 50) {
          self turretsettargetangles(0, (0, self.angles[1], 0));
        } else {
          self turretsettargetangles(0, (0, randomint(360), 0));
        }
      }
    }

    wait randomintrange(3, 6);
  }
}

function_af46682(patroller) {
  level endon(#"game_ended", #"hash_12a8f2c59a67e4fc");
  patroller endon(#"death");

  while(!isDefined(level.deathcircle)) {
    wait 1;
  }

  while(isDefined(patroller)) {
    distsq = distance2dsquared(patroller.origin, level.deathcircle.origin);

    if(distsq > level.deathcircle.radius * level.deathcircle.radius) {
      patroller dodamage(patroller.health, patroller.origin, level.deathcircle);
      self.var_c6328f73 = 0;
    }

    wait randomint(10);
  }
}