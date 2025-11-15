/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\rangefinder.gsc
**************************************/

runmprangefinder() {
  precachemodel("mw_rangefinder_soldier");
  wait(5);
  for(;;) {
    if(getdvarint("scr_rangeFinder", 0) == 1) {
      var_00 = createcamnode();
      thread addmodeltoplayer(var_00);
      while(getdvarint("scr_rangeFinder", 0) == 1) {
        wait(0.01);
      }

      var_00 delete();
      level notify("rangeFinder_end");
    }

    wait(0.01);
  }
}

createcamnode() {
  var_00 = spawn("script_origin", level.players[0].origin);
  var_00 thread monitorplacement();
  var_00 thread managelink();
  return var_00;
}

monitorplacement() {
  level endon("game_ended");
  level endon("rangeFinder_end");
  self.placementmode = "player";
  for(;;) {
    if(getdvarint("scr_rangeFinder", 0) == 1) {
      if(level.players[0] usebuttonpressed()) {
        self.placementmode = scripts\engine\utility::ter_op(self.placementmode == "player", "stationary", "player");
        level.players[0] notify("changed_placementMode");
        while(level.players[0] usebuttonpressed()) {
          wait(0.05);
        }
      }
    }

    wait(0.01);
  }
}

managelink() {
  level endon("game_ended");
  level endon("rangeFinder_end");
  thread softlink();
  for(;;) {
    level.players[0] waittill("changed_placementMode");
    if(self.placementmode == "player") {
      iprintlnbold("LINKED MODE");
      thread softlink();
    } else {
      iprintlnbold("STATIONARY MODE");
    }

    wait(0.01);
  }
}

softlink() {
  level.players[0] endon("changed_placementMode");
  level endon("rangeFinder_end");
  for(;;) {
    self.angles = (0, 90 + level.players[0].angles[1], 0);
    var_00 = anglesToForward(level.players[0].angles) * 40 + (0, 0, -10);
    self.origin = level.players[0].origin - var_00;
    wait(0.01);
  }
}

addmodeltoplayer(param_00) {
  var_01 = spawn("script_model", param_00.origin);
  var_01.angles = param_00.angles;
  var_01 setModel("mw_rangefinder_soldier");
  var_01 linkto(param_00);
  var_01 thread watchrangefinderend();
}

watchrangefinderend() {
  level waittill("rangeFinder_end");
  self delete();
}