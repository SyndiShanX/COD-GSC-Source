/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\rangefinder.gsc
***********************************************/

runmprangefinder() {
  precachemodel("mw_scale_soldier");
  precachemodel("mw_test_soldier");
  precachemodel("mw_dist_soldier");
  wait 5.0;

  for(;;) {
    if(getdvarint("scr_rangefinder", 0) == 1) {
      node = createcamnode();
      thread addmodeltoplayer(node);

      while(getdvarint("scr_rangefinder", 0) == 1)
        wait 0.01;

      node delete();
      level notify("rangeFinder_end");
    }

    wait 0.01;
  }
}

createcamnode() {
  cam = spawn("script_origin", level.players[0].origin);
  cam thread monitorplacement();
  cam thread managelink();
  return cam;
}

monitorplacement() {
  level endon("game_ended");
  level endon("rangeFinder_end");
  self.placementmode = "player";

  for(;;) {
    if(getdvarint("scr_rangefinder", 0) == 1) {
      if(level.players[0] useButtonPressed()) {
        self.placementmode = scripts\engine\utility::ter_op(self.placementmode == "player", "stationary", "player");
        level.players[0] notify("changed_placementMode");

        while(level.players[0] useButtonPressed())
          waitframe();
      }
    }

    wait 0.01;
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
    } else
      iprintlnbold("STATIONARY MODE");

    wait 0.01;
  }
}

softlink() {
  level.players[0] endon("changed_placementMode");
  level endon("rangeFinder_end");

  for(;;) {
    self.angles = (0, 90 + level.players[0].angles[1], 0);
    offset = anglesToForward(level.players[0].angles) * 40;
    self.origin = level.players[0].origin - offset;
    wait 0.01;
  }
}

addmodeltoplayer(node) {
  rangefinder = spawn("script_model", node.origin);
  rangefinder.angles = node.angles;
  rangefinder setModel("mw_dist_soldier");
  rangefinder linkTo(node);
  rangefinder thread watchrangefinderend();
}

watchrangefinderend() {
  level waittill("rangeFinder_end");
  self delete();
}