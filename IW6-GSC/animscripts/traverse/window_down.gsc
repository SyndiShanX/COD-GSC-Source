/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\window_down.gsc
************************************************/

#using_animtree("generic_human");

main() {
  var_0 = % windowclimb_fall;
  var_1 = % windowclimb_land;
  var_2 = 35;
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("noclip");
  var_3 = self getnegotiationstartnode();
  self orientmode("face angle", var_3.angles[1]);
  var_4 = var_3.traverse_height - var_3.origin[2];
  self setflaggedanimknoballrestart("traverse", var_0, % body, 1, 0.15, 1);
  thread animscripts\notetracks::donotetracksforever("traverse", "stop_traverse_notetracks");
  wait 1.5;
  var_5 = (0, var_3.angles[1], 0);
  var_6 = anglesToForward(var_5);
  var_6 = var_6 * 85;
  var_7 = bulletTrace(var_3.origin + var_6, var_3.origin + var_6 + (0, 0, -500), 0, undefined);
  var_8 = var_7["position"][2];
  var_9 = var_3.origin[2] - var_8;
  var_10 = 0;

  for(var_11 = 0; var_11 < level.window_down_height.size; var_11++) {
    if(var_9 < level.window_down_height[var_11]) {
      continue;
    }
    var_10 = var_9 - level.window_down_height[var_11];
  }

  thread animscripts\traverse\shared::teleportthread(var_10 * -1);
  var_12 = self.origin[2];
  var_13 = 0;
  level.traversefall = [];

  for(;;) {
    var_13 = var_12 - self.origin[2];

    if(self.origin[2] - var_13 < var_8) {
      break;
    }

    var_12 = self.origin[2];
    wait 0.05;
  }

  if(isDefined(self.groundtype)) {
    self playSound("Land_" + self.groundtype);
  }

  self notify("stop_traverse_notetracks");
  self setflaggedanimknoballrestart("traverse", var_1, % body, 1, 0.15, 1);
  self traversemode("gravity");
  animscripts\shared::donotetracks("traverse");
}

printer(var_0) {
  level notify("print_this_" + var_0);
  level endon("print_this_" + var_0);

  for(;;) {
    wait 0.05;
  }
}

showline(var_0, var_1) {
  for(;;) {
    wait 0.05;
  }
}

printerdebugger(var_0, var_1) {
  level notify("prrint_this_" + var_1);
  level endon("prrint_this_" + var_1);

  for(;;) {
    wait 0.05;
  }
}