/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_ee_poster.gsc
***********************************************/

#include script_cb32d07c95e5628;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\wz_common\wz_ai_utils;

#namespace wz_ee_poster;

autoexec __init__system__() {
  system::register(#"wz_ee_poster", &__init__, undefined, undefined);
}

autoexec __init() {
  level.var_5805dc3b = isDefined(getgametypesetting(#"hash_5f842714fa80e5a9")) ? getgametypesetting(#"hash_5f842714fa80e5a9") : 0;
}

__init__() {
  hidemiscmodels("poster_damaged");
}

private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  if(level.inprematchperiod || !level.var_5805dc3b) {
    return;
  }

  poster_trigger = getent("poster_ee_trigger", "targetname");

  if(!isDefined(poster_trigger)) {
    return;
  }

  if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self) && isDefined(eventstruct) && isDefined(eventstruct.weapon) && isDefined(poster_trigger)) {
    if(isDefined(eventstruct.projectile)) {
      projectile = eventstruct.projectile;
      player_dist = distance(poster_trigger.origin, self.origin);

      if(player_dist < 5000) {
        projectile thread function_3383b382(self, poster_trigger);
      }
    }
  }
}

function_3383b382(player, poster_trigger) {
  if(!isDefined(player) || !isDefined(self) || !isDefined(poster_trigger)) {
    return;
  }

  level endon(#"game_ended");
  self endon(#"stationary");
  player endon(#"death");
  poster_trigger endon(#"death");
  var_bd332bd5 = 0;
  projectile_velocity = self getvelocity();

  if(!isDefined(projectile_velocity)) {
    return;
  }

  while(isDefined(self) && !var_bd332bd5 && abs(projectile_velocity[0]) > 0 && abs(projectile_velocity[1]) > 0) {
    projectile_velocity = self getvelocity();

    if(self istouching(poster_trigger)) {
      if(isDefined(poster_trigger.target)) {
        var_b721e8a9 = poster_trigger.target;
      }

      var_bd332bd5 = 1;
      break;
    }

    waitframe(1);
  }

  if(var_bd332bd5) {
    hidemiscmodels("poster_pristine");
    showmiscmodels("poster_damaged");
    playsoundatposition(#"hash_102a20c25b442146", poster_trigger.origin);

    if(isDefined(var_b721e8a9)) {
      poster_trigger function_79c8b708(var_b721e8a9);
    }

    poster_trigger delete();
  }
}

function_79c8b708(var_b721e8a9) {
  if(!isDefined(var_b721e8a9)) {
    return;
  }

  spawn_point = struct::get(var_b721e8a9, "targetname");

  if(isDefined(spawn_point)) {
    a_items = spawn_point namespace_65181344::function_fd87c780(#"zombie_poster_ee_list", 5);

    foreach(item in a_items) {
      if(isDefined(item)) {
        item thread function_7a1e21a9(spawn_point.origin);
      }

      waitframe(randomintrange(1, 3));
    }
  }
}

function_7a1e21a9(v_loc) {
  self endon(#"death");
  self.origin = v_loc;
  self.angles += (0, randomint(360), 0);
  trace = bulletTrace(v_loc + (0, 0, 40), v_loc + (0, 0, -150), 0, undefined);

  if(trace[#"fraction"] < 1) {
    v_loc = trace[#"position"];
  }

  time = self wz_ai_utils::fake_physicslaunch(v_loc, 100);
  wait time;

  if(isDefined(self)) {
    self.origin = v_loc;
  }
}