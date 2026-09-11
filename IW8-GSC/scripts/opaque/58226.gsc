/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58226.gsc
***********************************************/

function ref_12f67(var0, var1, var2) {
  var3 = getentitylessscriptablearrayinradius(undefined, undefined, var0, var1, "door");

  if(isDefined(var2)) {
    var4 = [];

    foreach(var6 in var3) {
      var7 = var6.origin[2] - var0[2];

      if(var7 <= var2) {
        var4 = var6;
      }
    }

    var3 = var4;
  }

  return var3;
}

function ref_12f66(var0) {
  self notify("scriptable_door_freeze_open");
  self endon("scriptable_door_freeze_open");
  var1 = undefined;
  var2 = undefined;

  if(istrue(var0)) {
    var1 = "bash_left_90";
    var2 = self.heli_intro + (0, 90, 0);
    goto LOC_00000058;
  }

  var1 = "bash_right_90";
  var2 = self.heli_intro + (0, -90, 0);

  while(anglesdelta(self.angles, var2) > 1) {
    var3 = self getscriptablepartstate("door");

    if(var3 != var1) {
      self setscriptablepartstate("door", var1, 0);
    }

    wait 0.05;
  }

  self setscriptablepartstate("door", "ajar", 0);
  self scriptabledoorfreeze(1);
}

function ref_12f68(var0) {
  if(self == var0) {
    return false;
  }

  var1 = self.heli_intro_vo_done;
  var2 = var0.heli_intro_vo_done;
  var3 = distancesquared(var1, var2);

  if(var3 > 5) {
    return false;
  }

  return true;
}

function matchslopekey(var0, var1) {
  var2 = !var0;
  var3 = scripts\common\input_allow::allow_input_internal("door_frozen", var2, var1);

  if(isDefined(var3)) {
    self scriptabledoorfreeze(!var3);
    return;
  }
}

function matching_correct_bomb_wire_pair() {
  return scripts\common\input_allow::is_input_allowed_internal("door_frozen");
}