/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_4ec1d631174f7283.gsc
***********************************************/

#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_devgui;

#namespace namespace_3b9dec72;

autoexec __init__system__() {
  system::register(#"hash_56850a719f90825a", &__init__, &__main__, undefined);
}

__init__() {
  spawner::add_archetype_spawn_function(#"civilian", &function_e5ba4473);
  assert(isscriptfunctionptr(&function_b4b7cd20));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"ispablo", &function_b4b7cd20);

  zm_devgui::function_c7dd7a17("<dev string:x38>");
  adddebugcommand("<dev string:x43>");
  adddebugcommand("<dev string:x73>");

    level thread function_2165e851();
}

__main__() {}

private function_4d231aa() {
  self endon(#"death");

  while(true) {
    wait 3;
    self setblackboardattribute("_stance", "crouch");
    wait 3;
    self setblackboardattribute("_stance", "stand");
    wait 3;
    self setblackboardattribute("_stance", "swim");
  }
}

private function_e5ba4473() {
  self.goalradius = 15;
  self.pushable = 0;
  self collidewithactors(0);
  self setavoidancemask("avoid none");

  if(self.aitype == "spawner_zm_pablo") {
    self.var_f6f10811 = 1;
  } else {
    if(!isDefined(level.var_8a8728c6)) {
      level.var_8a8728c6 = [];
    }

    level.var_8a8728c6[level.var_8a8728c6.size] = self;

    if(self.aitype == "spawner_zm_samantha") {
      self setblackboardattribute("_stance", "stand");
    } else {
      self setblackboardattribute("_stance", "crouch");
    }
  }

  self thread function_b7f08e2d();

}

function_1c989dc4() {
  if(isDefined(level.var_8a8728c6) && level.var_8a8728c6.size >= 2) {
    samantha = level.var_8a8728c6[0];
    eddie = level.var_8a8728c6[1];
    samantha.pushable = 0;
    eddie.pushable = 0;
    var_e625df22 = anglesToForward(samantha.angles);
    samantha_right = vectorcross((0, 0, 1), var_e625df22) * -1;
    eddie forceteleport(samantha.origin + samantha_right * 25, samantha.angles);
  }
}

private function_b7f08e2d() {
  self endon(#"death");

  while(true) {
    waitframe(1);
    enabled = getdvarint(#"hash_6ba94f3ad6709984", 0);

    if(enabled) {
      end = self getcentroid();
      goalinfo = self function_4794d6a3();

      if(isDefined(goalinfo.goalpos)) {

        sphere(goalinfo.goalpos, 5, (0, 1, 0), 0.5, 0, 8, 1);

      }
    }
  }
}

private function_dca53f1f(player_index) {
  var_9a149315 = (0, 0, 0);

  if(isDefined(level.var_8a8728c6)) {
    samantha = level.var_8a8728c6[0];
    var_b8e7e5da = (-100, -12.5, 0) + (-5, 0, 0) * player_index;
    var_9a149315 = samantha.origin + rotatepointaroundaxis(var_b8e7e5da, (0, 0, 1), samantha.angles[1]);
  }

  return var_9a149315;
}

function_303ab700() {
  players = getplayers();
  player_index = 0;

  if(players.size > 0 && isDefined(level.var_8a8728c6) && isDefined(level.var_8a8728c6[0])) {
    foreach(player in players) {
      if(isDefined(player)) {
        var_16a2c824 = player function_dca53f1f(player_index);
        samantha = level.var_8a8728c6[0];
        println("<dev string:xc0>");
        player.var_fa2d1151 = spawn("script_model", var_16a2c824);
        player.var_fa2d1151.angles = samantha.angles;
        wait 1;

        if(isDefined(player) && isDefined(player.var_fa2d1151)) {
          player dontinterpolate();
          player setorigin(var_16a2c824);
          player setplayerangles(samantha.angles);
          waitframe(1);
          println("<dev string:xe6>" + player.name + "<dev string:x106>");
          function_8e56bb21(player, player.var_fa2d1151, var_16a2c824, samantha.angles);
          wait 1;
        }

        player_index++;
      }
    }

    level.var_41c80f7d = 1;
  }
}

function_8e56bb21(player, script_model, origin, angles) {
  player setorigin(origin);
  player setplayerangles(angles);
  player playerlinktodelta(script_model, undefined, 0, 30, 30, 15, 15);
}

function_10add6a8() {
  level.var_41c80f7d = 0;
}

function_ddbe2dbb(distance) {
  foreach(npc in level.var_8a8728c6) {
    var_a04c5e3b = anglesToForward(npc.angles);
    npc.var_9a149315 = npc.origin + anglesToForward(npc.angles) * distance;
    npc setgoal(npc.var_9a149315);
  }
}

private function_ae4d6b1b() {
  players = getplayers();

  foreach(player in players) {
    player unlink();
  }

  level.var_41c80f7d = 0;
}

private function_2165e851() {
  level endon(#"end_game");

  while(true) {
    waitframe(1);
    players = getplayers();

    if(players.size > 0 && isDefined(level.var_8a8728c6) && isDefined(level.var_41c80f7d) && level.var_41c80f7d) {
      var_2e35e6c1 = 0;

      foreach(player in players) {
        v_movement = player getnormalizedmovement();

        if(v_movement[0] > 0.5) {
          var_2e35e6c1 = 1;
          break;
        }
      }

      foreach(npc in level.var_8a8728c6) {
        if(var_2e35e6c1) {
          var_a04c5e3b = anglesToForward(npc.angles);
          npc.var_9a149315 = npc.origin + anglesToForward(npc.angles) * 100;
          npc setgoal(npc.var_9a149315);
          continue;
        }

        npc setgoal(npc.origin);
      }

      player_index = 0;

      foreach(player in players) {
        if(isDefined(player.var_fa2d1151)) {
          var_9a149315 = player function_dca53f1f(player_index);
          player.var_fa2d1151 moveto(var_9a149315, 0.15);
        }

        player_index++;
      }
    }
  }
}

private function_b4b7cd20(entity) {
  result = 0;

  if(isDefined(entity.var_f6f10811) && entity.var_f6f10811) {
    result = 1;
  }

  return result;
}