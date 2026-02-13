/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2387.gsc
*************************************************/

main() {
  level._id_C67F = ::_id_C674;
  level._id_BC30 = [];
  level._id_1F49 = 20;
  level._id_414F = 0;
}

_id_C674(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_0 _id_073B::_id_5490(var_0);
  var_0 _id_073B::_id_B8DB();

  if(!isDefined(level._id_B77D)) {
    level._id_B77D = [];
  }

  level._id_B77D = scripts\engine\utility::array_add(level._id_B77D, var_0);
  var_12 = 0;
  var_13 = undefined;

  foreach(var_15 in level.players) {
    if(var_15.sessionstate == "spectator") {
      var_12++;
    }
  }

  if(var_12 == level.players.size - 1) {
    foreach(var_15 in level.players) {
      if(var_15.sessionstate == "spectator") {
        continue;
      }
    }
  }

  foreach(var_15 in level.players) {
    if(!istrue(level._id_5BA7)) {
      level._id_5BA7 = 1;

      foreach(var_15 in level.players) {
        var_15._id_C672 = 0;
        var_15 notify("toggle_respawn_function", 1);
      }
    }
  }

  for(;;) {
    var_23 = var_0 scripts\engine\utility::_id_10898("respawn_player", "auto_respawn", "forced_revive_to_regroup");

    if(isDefined(var_23)) {
      if(istrue(var_0._id_2508)) {
        continue;
      }
      if(istrue(level._id_AF54)) {
        continue;
      }
      level._id_B77D = scripts\engine\utility::array_remove(level._id_B77D, var_0);
      return 1;
    }
  }
}

start_respawn() {
  thread vortex_fx_watcher();

  if(!isDefined(level._id_3BE9._id_0F51)) {
    thread _id_1F1B();
  }
}

_id_1F1B() {
  level endon("game_ended");
  level endon("respawn_used");
  self endon("auto_respawn");
  self endon("disconnect");
  self notify("auto_respawn_timer");
  self endon("auto_respawn_timer");
  var_0 = gettime() + level._id_1F49 * 1000;
  self setclientomnvar("cp_auto_respawn_timer", var_0);
  self setclientomnvar("cp_team_respawn_display", 4);

  for(self._id_414F = level._id_1F49; self._id_414F > 0; self._id_414F--) {
    wait 1;
  }

  self setclientomnvar("cp_auto_respawn_timer", 0);
  self setclientomnvar("cp_team_respawn_display", 0);
  self._id_5E88 = 1;
  self._id_414F = 0;
  self notify("auto_respawn");
}

vortex_fx_watcher() {
  level endon("game_ended");
  level endon("respawn_used");
  self endon("auto_respawn");
  self waittill("begin_vortex_fx");
  self notify("auto_respawn");
}