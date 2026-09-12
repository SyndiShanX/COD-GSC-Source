/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58226.gsc
***********************************************/

function ref_12F67(var_0, var_1, var_2) {
  var_3 = getentitylessscriptablearrayinradius(undefined, undefined, var_0, var_1, "door");

  if(isDefined(var_2)) {
    var_4 = [];

    foreach(var_6 in var_3) {
      var_7 = var_6.origin[2] - var_0[2];

      if(var_7 <= var_2) {
        var_4 = var_6;
      }
    }

    var_3 = var_4;
  }

  return var_3;
}

function ref_12F66(var_0) {
  self notify("scriptable_door_freeze_open");
  self endon("scriptable_door_freeze_open");
  var_1 = undefined;
  var_2 = undefined;

  if(istrue(var_0)) {
    var_1 = "bash_left_90";
    var_2 = self.heli_intro + (0, 90, 0);
    goto LOC_00000058;
  }

  var_1 = "bash_right_90";
  var_2 = self.heli_intro + (0, -90, 0);

  while(anglesdelta(self.angles, var_2) > 1) {
    var_3 = self getscriptablepartstate("door");

    if(var_3 != var_1) {
      self setscriptablepartstate("door", var_1, 0);
    }

    wait 0.05;
  }

  self setscriptablepartstate("door", "ajar", 0);
  self scriptabledoorfreeze(1);
}

function ref_12F68(var_0) {
  if(self == var_0) {
    return false;
  }

  var_1 = self.heli_intro_vo_done;
  var_2 = var_0.heli_intro_vo_done;
  var_3 = distancesquared(var_1, var_2);

  if(var_3 > 5) {
    return false;
  }

  return true;
}

function matchslopekey(var_0, var_1) {
  var_2 = !var_0;
  var_3 = scripts\common\input_allow::allow_input_internal("door_frozen", var_2, var_1);

  if(isDefined(var_3)) {
    self scriptabledoorfreeze(!var_3);
    return;
  }
}

function matching_correct_bomb_wire_pair() {
  return scripts\common\input_allow::is_input_allowed_internal("door_frozen");
}