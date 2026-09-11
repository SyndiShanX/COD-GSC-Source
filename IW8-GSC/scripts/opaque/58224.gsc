/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58224.gsc
***********************************************/

function friendlyfire_allowed() {
  var0 = spawnStruct();
  var0.ref_1393d = [];
  return var0;
}

function friendlystatusdirty(var0, var1) {
  var3 = spawnStruct();
  var3.target = var1;
  var3.friendly_hvi_vehicle_extra_riders_intro_scene = var0;
  self.ref_1393d = scripts\engine\utility::array_removeundefined(self.ref_1393d);
  self.ref_1393d[self.ref_1393d.size] = var3;
}

function front_struct(var0, var1) {
  var2 = 0;

  foreach(var4 in self.ref_1393d) {
    if(var4.friendly_hvi_vehicle_extra_riders_intro_scene == var0) {
      if(var4.target == var1) {
        self.ref_1393d[var5] = undefined;
        return;
      }
    }
  }
}

function from(var0, var1, var2, var3) {
  foreach(var5 in self.ref_1393d) {
    if(!isDefined(var5.target)) {
      self.ref_1393d[var6] = undefined;
    }
  }

  var7 = self.ref_1393d;

  if(isDefined(var3)) {
    foreach(var5 in var7) {
      var5.target[[var5.friendly_hvi_vehicle_extra_riders_intro_scene]](var0, var1, var2, var3);
    }

    return;
  }

  if(isDefined(var2)) {
    foreach(var5 in var7) {
      var5.target[[var5.friendly_hvi_vehicle_extra_riders_intro_scene]](var0, var1, var2);
    }

    return;
  }

  if(isDefined(var1)) {
    foreach(var5 in var7) {
      var5.target[[var5.friendly_hvi_vehicle_extra_riders_intro_scene]](var0, var1);
    }

    return;
  }

  if(isDefined(var0)) {
    foreach(var5 in var7) {
      var5.target[[var5.friendly_hvi_vehicle_extra_riders_intro_scene]](var0);
    }

    return;
  }

  foreach(var5 in var7) {
    var5.target[[var5.friendly_hvi_vehicle_extra_riders_intro_scene]]();
  }
}