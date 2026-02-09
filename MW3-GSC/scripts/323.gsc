/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\323.gsc
**************************************/

script_print_fx() {
  if(!isDefined(self.script_fxid) || !isDefined(self.script_fxcommand) || !isDefined(self.script_delay)) {
    self delete();
    return;
  }

  if(isDefined(self.target)) {
    var_0 = getent(self.target).origin;
  } else {
    var_0 = "undefined";
  }
  if(self.script_fxcommand == "OneShotfx") {}

  if(self.script_fxcommand == "loopfx") {}

  if(self.script_fxcommand == "loopsound") {
    return;
  }
}

script_playFX(var_0, var_1, var_2) {
  if(!var_0) {
    return;
  }
  if(isDefined(var_2)) {
    playFX(var_0, var_1, var_2);
  } else {
    playFX(var_0, var_1);
  }
}

script_playFXOnTag(var_0, var_1, var_2) {
  if(!var_0) {
    return;
  }
  playFXOnTag(var_0, var_1, var_2);
}

grenadeexplosionfx(var_0) {
  playFX(level._effect["mechanical explosion"], var_0);
  earthquake(0.15, 0.5, var_0, 250);
}

soundfx(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3.origin = var_1;
  var_3 playLoopSound(var_0);

  if(isDefined(var_2)) {
    var_3 thread soundfxdelete(var_2);
  }
}

soundfxdelete(var_0) {
  level waittill(var_0);
  self delete();
}

_id_1E51(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3.origin = var_2;
  var_3 thread _id_1E52(var_0, var_1);
}

_id_1E52(var_0, var_1) {
  self endon("death");
  var_2 = spawn("sound_blend", (0, 0, 0));
  var_2.origin = self.origin;
  thread blenddelete(var_2);
  var_3 = spawn("sound_blend", (0, 0, 0));
  var_3.origin = self.origin;
  thread blenddelete(var_3);
  var_2 setsoundblend(var_1 + "_null", var_1, 0);
  var_3 setsoundblend(var_0 + "_null", var_0, 1);
  var_4 = "hard";
  var_5 = undefined;

  for(;;) {
    level waittill("rain_change", var_6, var_5);
    var_5 = var_5 * 20;

    if(var_6 == "hard") {
      if(var_4 == "none") {
        var_5 = var_5 * 0.5;

        for(var_7 = 0; var_7 < var_5; var_7++) {
          var_2 setsoundblend(var_1 + "_null", var_1, var_7 / var_5);
          wait 0.05;
        }

        var_4 = "light";
      }

      if(var_4 == "light") {
        for(var_7 = 0; var_7 < var_5; var_7++) {
          var_2 setsoundblend(var_1 + "_null", var_1, 1 - var_7 / var_5);
          var_3 setsoundblend(var_0 + "_null", var_0, var_7 / var_5);
          wait 0.05;
        }
      }
    }

    if(var_6 == "none") {
      if(var_4 == "hard") {
        var_5 = var_5 * 0.5;

        for(var_7 = 0; var_7 < var_5; var_7++) {
          var_2 setsoundblend(var_1 + "_null", var_1, var_7 / var_5);
          var_3 setsoundblend(var_0 + "_null", var_0, 1 - var_7 / var_5);
          wait 0.05;
        }

        var_4 = "light";
      }

      if(var_4 == "light") {
        for(var_7 = 0; var_7 < var_5; var_7++) {
          var_2 setsoundblend(var_1 + "_null", var_1, 1 - var_7 / var_5);
          wait 0.05;
        }
      }
    }

    if(var_6 == "light") {
      if(var_4 == "none") {
        for(var_7 = 0; var_7 < var_5; var_7++) {
          var_2 setsoundblend(var_1 + "_null", var_1, var_7 / var_5);
          wait 0.05;
        }
      }

      if(var_4 == "hard") {
        for(var_7 = 0; var_7 < var_5; var_7++) {
          var_2 setsoundblend(var_1 + "_null", var_1, var_7 / var_5);
          var_3 setsoundblend(var_0 + "_null", var_0, 1 - var_7 / var_5);
          wait 0.05;
        }
      }
    }

    var_4 = var_6;
  }
}

blenddelete(var_0) {
  self waittill("death");
  var_0 delete();
}

_id_1E54(var_0) {
  var_1 = 3;

  if(isDefined(var_0._id_1662)) {
    var_1 = var_0._id_1662;
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      var_2 setwatersheeting(1, var_1);
      wait(var_1 * 0.2);
    }
  }
}