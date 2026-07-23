/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\window_down.gsc
************************************************/

#using_animtree("generic_human");

main() {
  var_0 = % windowclimb_fall;
  var_1 = % windowclimb_land;
  var_2 = 35;
  self._id_247C = "crouch";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self traversemode("noclip");
  var_3 = self getnegotiationstartnode();
  self orientmode("face angle", var_3.angles[1]);
  var_4 = var_3._id_1EFA - var_3.origin[2];
  self setflaggedanimknoballrestart("traverse", var_0, %body, 1, 0.15, 1);
  thread animscripts\notetracks::_id_239E("traverse", "stop_traverse_notetracks");
  wait 1.5;
  var_5 = (0, var_3.angles[1], 0);
  var_6 = anglesToForward(var_5);
  var_6 = var_6 * 85;
  var_7 = bulletTrace(var_3.origin + var_6, var_3.origin + var_6 + (0, 0, -500), 0, undefined);
  var_8 = var_7["position"][2];
  var_9 = var_3.origin[2] - var_8;
  var_10 = 0;

  for(var_11 = 0; var_11 < level._id_20C4.size; var_11++) {
    if(var_9 < level._id_20C4[var_11]) {
      continue;
    }
    var_10 = var_9 - level._id_20C4[var_11];
  }

  thread animscripts\traverse\shared::_id_3FE7(var_10 * -1);
  var_12 = self.origin[2];
  var_13 = 0;
  level._id_3FFF = [];

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
  self setflaggedanimknoballrestart("traverse", var_1, %body, 1, 0.15, 1);
  self traversemode("gravity");
  animscripts\shared::_id_0C51("traverse");
}

_id_4000(var_0) {
  level notify("print_this_" + var_0);
  level endon("print_this_" + var_0);

  for(;;) {
    wait 0.05;
  }
}

_id_4001(var_0, var_1) {
  for(;;) {
    wait 0.05;
  }
}

_id_4002(var_0, var_1) {
  level notify("prrint_this_" + var_1);
  level endon("prrint_this_" + var_1);

  for(;;) {
    wait 0.05;
  }
}