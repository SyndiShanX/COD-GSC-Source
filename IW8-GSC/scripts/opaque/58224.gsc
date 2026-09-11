/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58224.gsc
***********************************************/

function friendlyfire_allowed() {
  var_0 = spawnStruct();
  var_0.ref_1393d = [];
  return var_0;
}

function friendlystatusdirty(var_0, var_1) {
  var_3 = spawnStruct();
  var_3.target = var_1;
  var_3.friendly_hvi_vehicle_extra_riders_intro_scene = var_0;
  self.ref_1393d = scripts\engine\utility::array_removeundefined(self.ref_1393d);
  self.ref_1393d[self.ref_1393d.size] = var_3;
}

function front_struct(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in self.ref_1393d) {
    if(var_4.friendly_hvi_vehicle_extra_riders_intro_scene == var_0) {
      if(var_4.target == var_1) {
        self.ref_1393d[var_5] = undefined;
        return;
      }
    }
  }
}

function from(var_0, var_1, var_2, var_3) {
  foreach(var_5 in self.ref_1393d) {
    if(!isDefined(var_5.target)) {
      self.ref_1393d[var_6] = undefined;
    }
  }

  var_7 = self.ref_1393d;

  if(isDefined(var_3)) {
    foreach(var_5 in var_7) {
      var_5.target[[var_5.friendly_hvi_vehicle_extra_riders_intro_scene]](var_0, var_1, var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_5 in var_7) {
      var_5.target[[var_5.friendly_hvi_vehicle_extra_riders_intro_scene]](var_0, var_1, var_2);
    }

    return;
  }

  if(isDefined(var_1)) {
    foreach(var_5 in var_7) {
      var_5.target[[var_5.friendly_hvi_vehicle_extra_riders_intro_scene]](var_0, var_1);
    }

    return;
  }

  if(isDefined(var_0)) {
    foreach(var_5 in var_7) {
      var_5.target[[var_5.friendly_hvi_vehicle_extra_riders_intro_scene]](var_0);
    }

    return;
  }

  foreach(var_5 in var_7) {
    var_5.target[[var_5.friendly_hvi_vehicle_extra_riders_intro_scene]]();
  }
}