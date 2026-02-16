/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2057.gsc
*************************************************/

_id_CA51() {
  precachemodel("mw_scale_soldier");
  precachemodel("mw_test_soldier");
  precachemodel("mw_dist_soldier");
  wait 5.0;

  for(;;) {
    if(getdvarint("#x3d0e58bbc7ffcf8ae", 0) == 1) {
      var_0 = _id_3FA4();
      thread _id_10E9(var_0);

      while(getdvarint("#x3d0e58bbc7ffcf8ae", 0) == 1) {
        wait 0.01;
      }

      var_0 delete();
      level notify("rangeFinder_end");
    }

    wait 0.01;
  }
}

_id_3FA4() {
  var_0 = spawn("script_origin", level.players[0].origin);
  var_0 thread _id_A131();
  var_0 thread _id_9A22();
  return var_0;
}

_id_A131() {
  level endon("game_ended");
  level endon("rangeFinder_end");
  self._id_B171 = "player";

  for(;;) {
    if(getdvarint("#x3d0e58bbc7ffcf8ae", 0) == 1) {
      if(level.players[0] useButtonPressed()) {
        self._id_B171 = scripts\engine\utility::ter_op(self._id_B171 == "player", "stationary", "player");
        level.players[0] notify("changed_placementMode");

        while(level.players[0] useButtonPressed()) {
          waitframe();
        }
      }
    }

    wait 0.01;
  }
}

_id_9A22() {
  level endon("game_ended");
  level endon("rangeFinder_end");
  thread _id_DFED();

  for(;;) {
    level.players[0] waittill("changed_placementMode");

    if(self._id_B171 == "player") {
      iprintlnbold("LINKED MODE");
      thread _id_DFED();
    } else
      iprintlnbold("STATIONARY MODE");

    wait 0.01;
  }
}

_id_DFED() {
  level.players[0] endon("changed_placementMode");
  level endon("rangeFinder_end");

  for(;;) {
    self.angles = (0, 90 + level.players[0].angles[1], 0);
    var_0 = anglesToForward(level.players[0].angles) * 40;
    self.origin = level.players[0].origin - var_0;
    wait 0.01;
  }
}

_id_10E9(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("mw_dist_soldier");
  var_1 linkto(var_0);
  var_1 thread _id_10BF0();
}

_id_10BF0() {
  level waittill("rangeFinder_end");
  self delete();
}