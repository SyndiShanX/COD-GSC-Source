/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\remotemissile.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\killstreaks\remotemissile_shared;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\gametypes\globallogic_audio;

#namespace remotemissile;

autoexec __init__system__() {
  system::register(#"remotemissile", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
  level.var_5951cb24 = &function_5951cb24;
  level.var_dab39bb8 = &function_dab39bb8;
  level.var_feddd85a = &function_feddd85a;
}

function_5951cb24(killstreak_id, team) {
  if(!isDefined(self.currentkillstreakdialog) && isDefined(level.var_cb4eb1d1)) {
    self thread[[level.var_cb4eb1d1]]("callInRemoteMissile", "callInFutzRemoteMissile");
  }
}

function_dab39bb8(rocket) {
  self endon(#"remotemissile_done");
  rocket endon(#"death");
  var_b5e50364 = 0;

  while(!var_b5e50364) {
    enemy = self.owner battlechatter::get_closest_player_enemy(self.origin, 1);

    if(!isDefined(enemy)) {
      return 0;
    }

    eyepoint = enemy getEye();
    relativepos = vectornormalize(self.origin - eyepoint);
    dir = anglesToForward(enemy getplayerangles());
    dotproduct = vectordot(relativepos, dir);

    if(dotproduct > 0 && sighttracepassed(self.origin, eyepoint, 1, enemy, self)) {
      enemy thread battlechatter::play_killstreak_threat("remote_missile");
      var_b5e50364 = 1;
    }

    wait 0.1;
  }
}

function_feddd85a(attacker, weapon) {
  attacker battlechatter::function_dd6a6012("remote_missile", weapon);
}