/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\remotemissile.gsc
***********************************************/

#using script_396f7d71538c9677;
#using scripts\core_common\battlechatter;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\remotemissile_shared;
#namespace remotemissile;

function private autoexec __init__system__() {
  system::register(#"remotemissile", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  bundlename = "killstreak_remote_missile";

  if(sessionmodeiswarzonegame()) {
    bundlename += "_wz";
  }

  init_shared(bundlename);
  level.var_5951cb24 = &function_5951cb24;
  level.var_dab39bb8 = &function_dab39bb8;
  level.var_feddd85a = &function_feddd85a;
}

function function_5951cb24(killstreak_id, team) {
  self thread battlechatter::function_fff18afc("callInRemoteMissile", "callInFutzRemoteMissile");
}

function function_dab39bb8(rocket) {
  self endon(#"remotemissile_done");
  rocket endon(#"death");
  self.owner endon(#"death", #"disconnect");
  var_b5e50364 = 0;

  while(!var_b5e50364) {
    if(!isDefined(self.owner)) {
      return;
    }

    enemy = self.owner battlechatter::get_closest_player_enemy(self.origin, 1);

    if(!isDefined(enemy)) {
      return;
    }

    eyepoint = enemy getEye();
    relativepos = vectornormalize(self.origin - eyepoint);
    dir = anglesToForward(enemy getplayerangles());
    dotproduct = vectordot(relativepos, dir);

    if(dotproduct > 0 && sighttracepassed(self.origin, eyepoint, 1, enemy, self)) {
      enemy thread battlechatter::playkillstreakthreat("remote_missile");
      var_b5e50364 = 1;
    }

    wait 0.1;
  }
}

function function_feddd85a(attacker, weapon) {
  weapon battlechatter::function_eebf94f6("remote_missile");
}