/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2734.gsc
***************************************/

script_print_fx() {
  if(!isDefined(self.script_fxid) || !isDefined(self.script_fxcommand) || !isDefined(self.script_delay)) {
    self delete();
    return;
  }

  if(isDefined(self.target))
    var_00 = getent(self.target).origin;
  else
    var_00 = "undefined";

  if(self.script_fxcommand == "OneShotfx") {}

  if(self.script_fxcommand == "loopfx") {}

  if(self.script_fxcommand == "loopsound")
    return;
}

grenadeexplosionfx(var_00) {
  playFX(level._effect["mechanical explosion"], var_00);
  earthquake(0.15, 0.5, var_00, 250);
}

soundfx(var_00, var_01, var_02) {
  var_03 = spawn("script_origin", (0, 0, 0));
  var_3.origin = var_01;
  var_03 playLoopSound(var_00);

  if(isDefined(var_02))
    var_03 thread soundfxdelete(var_02);
}

soundfxdelete(var_00) {
  level waittill(var_00);
  self delete();
}

func_glass_handler() {
  var_00 = [];
  var_01 = [];
  var_02 = getEntArray("vfx_custom_glass", "targetname");

  foreach(var_04 in var_02) {
    if(isDefined(var_4.script_noteworthy)) {
      var_05 = getglass(var_4.script_noteworthy);

      if(isDefined(var_05)) {
        var_1[var_05] = var_04;
        var_0[var_0.size] = var_05;
      }
    }
  }

  var_07 = var_0.size;
  var_08 = var_0.size;
  var_09 = 5;
  var_10 = 0;

  while(var_07 != 0) {
    var_11 = var_10 + var_09 - 1;

    if(var_11 > var_08)
      var_11 = var_08;

    if(var_10 == var_08)
      var_10 = 0;

    while(var_10 < var_11) {
      var_12 = var_0[var_10];
      var_04 = var_1[var_12];

      if(isDefined(var_04)) {
        if(isglassdestroyed(var_12)) {
          var_04 delete();
          var_7--;
          var_1[var_12] = undefined;
        }
      }

      var_10++;
    }

    wait 0.05;
  }
}

blenddelete(var_00) {
  self waittill("death");
  var_00 delete();
}