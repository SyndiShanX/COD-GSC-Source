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
    var_00 = getent(self.target).origin;
  } else {
    var_00 = "undefined";
  }

  if(self.script_fxcommand == "OneShotfx") {}

  if(self.script_fxcommand == "loopfx") {}

  if(self.script_fxcommand == "loopsound") {}
}

grenadeexplosionfx(param_00) {
  playFX(level._effect["mechanical explosion"], param_00);
  earthquake(0.15, 0.5, param_00, 250);
}

soundfx(param_00, param_01, param_02) {
  var_03 = spawn("script_origin", (0, 0, 0));
  var_03.origin = param_01;
  var_03 playLoopSound(param_00);
  if(isDefined(param_02)) {
    var_03 thread soundfxdelete(param_02);
  }
}

soundfxdelete(param_00) {
  level waittill(param_00);
  self delete();
}

func_glass_handler() {
  var_00 = [];
  var_01 = [];
  var_02 = getEntArray("vfx_custom_glass", "targetname");
  foreach(var_04 in var_02) {
    if(isDefined(var_04.script_noteworthy)) {
      var_05 = getglass(var_04.script_noteworthy);
      if(isDefined(var_05)) {
        var_01[var_05] = var_04;
        var_00[var_00.size] = var_05;
      }
    }
  }

  var_07 = var_00.size;
  var_08 = var_00.size;
  var_09 = 5;
  var_0A = 0;
  while(var_07 != 0) {
    var_0B = var_0A + var_09 - 1;
    if(var_0B > var_08) {
      var_0B = var_08;
    }

    if(var_0A == var_08) {
      var_0A = 0;
    }

    while(var_0A < var_0B) {
      var_0C = var_00[var_0A];
      var_04 = var_01[var_0C];
      if(isDefined(var_04)) {
        if(isglassdestroyed(var_0C)) {
          var_04 delete();
          var_07--;
          var_01[var_0C] = undefined;
        }
      }

      var_0A++;
    }

    wait(0.05);
  }
}

blenddelete(param_00) {
  self waittill("death");
  param_00 delete();
}