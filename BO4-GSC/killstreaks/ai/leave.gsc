/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\ai\leave.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\ai\state;

#namespace ai_leave;

init() {
  ai_state::function_e9b061a8(2, &make_leave, &update_leave, undefined, &update_enemy, &function_4af1ff64, &function_a78474f2);
}

init_leave(var_edc20efd) {
  assert(isDefined(self.ai));
  self.ai.leave = {
    #state: 0, 
    #var_edc20efd: var_edc20efd
  };
}

function_4af1ff64() {
  return self.ai.leave.var_edc20efd;
}

function_a78474f2() {
  return self.origin;
}

update_enemy() {
  if(isDefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy) {
    self.ai.leave.state = 2;
    return;
  }

  if(self.ai.leave.state != 1) {
    self thread make_leave();
  }
}

update_leave() {}

function_e35eee4d() {
  self endon(#"death");
  level endon(#"game_ended");

  while(true) {
    players = getplayers();
    canbeseen = 0;

    foreach(player in players) {
      if(sighttracepassed(self getEye(), player getEye(), 0, undefined)) {
        canbeseen = 1;
        break;
      }
    }

    if(!canbeseen) {
      self delete();
    }

    wait 0.5;
  }
}

make_leave() {
  self endon(#"death");
  self notify(#"make_leave");
  self endon(#"make_leave");
  self callback::callback(#"hash_c3f225c9fa3cb25");
  self.ai.leave.state = 1;

  if(!isDefined(self.exit_spawn)) {
    util::wait_network_frame(2);
    self delete();
  }

  self thread function_e35eee4d();
  self function_d4c687c9();
  self pathmode("move allowed");
  self setgoal(self.exit_spawn.origin, 0, 32);
  self waittilltimeout(10, #"goal");
  waittillframeend();
  self delete();
}

function_233ddd28(origin, team) {
  spawns = level.spawn_start[team];
  closest = undefined;
  closest_dist = 10000000;

  foreach(spawn in spawns) {
    dist = distancesquared(spawn.origin, origin);

    if(dist < closest_dist) {
      closest_dist = dist;
      closest = spawn;
    }
  }

  return closest;
}