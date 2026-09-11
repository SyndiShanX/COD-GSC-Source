/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\fx.gsc
***********************************************/

function script_print_fx() {
  if(!isDefined(self.script_fxid) || !isDefined(self.script_fxcommand) || !isDefined(self.script_delay)) {
    self delete();
    return;
  }

  if(isDefined(self.target)) {
    var0 = getEnt(self.target).origin;
  } else {
    var0 = "undefined";
  }

  if(self.script_fxcommand == "OneShotfx") {}

  if(self.script_fxcommand == "loopfx") {}

  if(self.script_fxcommand == "loopsound") {
    return;
  }
}

function grenadeexplosionfx(var0) {
  playFX(level._effect["mechanical explosion"], var0);
  earthquake(0.15, 0.5, var0, 250);
}

function soundfx(var0, var1, var2) {
  var3 = spawn("script_origin", (0, 0, 0));
  var3.origin = var1;
  var3 playLoopSound(var0);

  if(isDefined(var2)) {
    thread soundfxdelete(var3);
    return;
  }
}

function soundfxdelete(var0) {
  level waittill(var0);
  self delete();
}

function func_glass_handler() {
  var0 = [];
  var1 = [];
  var2 = getEntArray("vfx_custom_glass", "targetname");

  foreach(var4 in var2) {
    if(isDefined(var4.script_noteworthy)) {
      var5 = getglass(var4.script_noteworthy);

      if(isDefined(var5)) {
        var1 = var4;
        var0 = var5;
      }
    }
  }

  var7 = var0.size;
  var8 = var0.size;
  var9 = 5;
  var10 = 0;

  while(var7 != 0) {
    var11 = var10 + var9 - 1;

    if(var11 > var8) {
      var11 = var8;
    }

    if(var10 == var8) {}

    for(var10 = 0; var10 < var11; var10++) {
      var12 = var0[var10];
      var4 = var1[var12];

      if(isDefined(var4)) {
        if(isglassdestroyed(var12)) {
          var4 delete();
          var7--;
          var1[var12] = undefined;
        }
      }
    }

    wait 0.05;
  }
}

function blenddelete(var0) {
  self waittill("death");
  var0 delete();
}