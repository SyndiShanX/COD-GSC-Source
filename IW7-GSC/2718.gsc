/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2718.gsc
***************************************/

init() {
  var_00 = getEntArray("destructable", "targetname");

  if(getdvar("scr_destructables") == "0") {
    for(var_01 = 0; var_01 < var_0.size; var_1++) {
      var_0[var_01] delete();
    }
  } else {
    for(var_01 = 0; var_01 < var_0.size; var_1++) {
      var_0[var_01] thread destructable_think();
    }
  }
}

destructable_think() {
  var_00 = 40;
  var_01 = 0;

  if(isDefined(self.script_accumulate)) {
    var_00 = self.script_accumulate;
  }

  if(isDefined(self.script_threshold)) {
    var_01 = self.script_threshold;
  }

  if(isDefined(self.script_destructable_area)) {
    var_02 = strtok(self.script_destructable_area, " ");

    for(var_03 = 0; var_03 < var_2.size; var_3++) {
      blockarea(var_2[var_03]);
    }
  }

  if(isDefined(self.script_fxid)) {
    self.fx = loadfx(self.script_fxid);
  }

  var_04 = 0;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_05, var_06);

    if(var_05 >= var_01) {
      var_04 = var_04 + var_05;

      if(var_04 >= var_00) {
        thread destructable_destruct();
        return;
      }
    }
  }
}

destructable_destruct() {
  var_00 = self;

  if(isDefined(self.script_destructable_area)) {
    var_01 = strtok(self.script_destructable_area, " ");

    for(var_02 = 0; var_02 < var_1.size; var_2++) {
      unblockarea(var_1[var_02]);
    }
  }

  if(isDefined(var_0.fx)) {
    playFX(var_0.fx, var_0.origin + (0, 0, 6));
  }

  var_00 delete();
}

blockarea(var_00) {}

func_2BAD(var_00, var_01) {}

unblockarea(var_00) {}

func_12B82(var_00, var_01) {}