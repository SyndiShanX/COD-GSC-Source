/*****************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\fx.gsc
*****************************/

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

  if(self.script_fxcommand == "loopsound") {}
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

func_glass_handler() {
  var_0 = [];
  var_1 = [];
  var_2 = getEntArray("vfx_custom_glass", "targetname");
  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy)) {
      var_5 = getglass(var_4.script_noteworthy);
      if(isDefined(var_5)) {
        var_1[var_5] = var_4;
        var_0[var_0.size] = var_5;
      }
    }
  }

  var_7 = var_0.size;
  var_8 = var_0.size;
  var_9 = 5;
  var_0A = 0;
  while(var_7 != 0) {
    var_0B = var_0A + var_9 - 1;
    if(var_0B > var_8) {
      var_0B = var_8;
    }

    if(var_0A == var_8) {
      var_0A = 0;
    }

    while(var_0A < var_0B) {
      var_0C = var_0[var_0A];
      var_4 = var_1[var_0C];
      if(isDefined(var_4)) {
        if(isglassdestroyed(var_0C)) {
          var_4 delete();
          var_7--;
          var_1[var_0C] = undefined;
        }
      }

      var_0A++;
    }

    wait(0.05);
  }
}

blenddelete(var_0) {
  self waittill("death");
  var_0 delete();
}