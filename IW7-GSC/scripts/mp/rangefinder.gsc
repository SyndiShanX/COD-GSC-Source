/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\rangefinder.gsc
*********************************************/

runmprangefinder() {
  precachemodel("mw_rangefinder_soldier");
  wait(5);
  for(;;) {
    if(getdvarint("scr_rangeFinder", 0) == 1) {
      var_0 = createcamnode();
      thread addmodeltoplayer(var_0);
      while(getdvarint("scr_rangeFinder", 0) == 1) {
        wait(0.01);
      }

      var_0 delete();
      level notify("rangeFinder_end");
    }

    wait(0.01);
  }
}

createcamnode() {
  var_0 = spawn("script_origin", level.players[0].origin);
  var_0 thread monitorplacement();
  var_0 thread managelink();
  return var_0;
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
    var_0 = anglesToForward(level.players[0].angles) * 40 + (0, 0, -10);
    self.origin = level.players[0].origin - var_0;
    wait(0.01);
  }
}

addmodeltoplayer(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("mw_rangefinder_soldier");
  var_1 linkto(var_0);
  var_1 thread watchrangefinderend();
}

watchrangefinderend() {
  level waittill("rangeFinder_end");
  self delete();
}