/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\destructables.gsc
****************************************/

init() {
  var_00 = getEntArray("destructable", "targetname");
  if(getdvar("scr_destructables") == "0") {
    for(var_01 = 0; var_01 < var_00.size; var_01++) {
      var_00[var_01] delete();
    }

    return;
  }

  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_00[var_01] thread destructable_think();
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
    for(var_03 = 0; var_03 < var_02.size; var_03++) {
      blockarea(var_02[var_03]);
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
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      unblockarea(var_01[var_02]);
    }
  }

  if(isDefined(var_00.fx)) {
    playFX(var_00.fx, var_00.origin + (0, 0, 6));
  }

  var_00 delete();
}

blockarea(param_00) {}

func_2BAD(param_00, param_01) {}

unblockarea(param_00) {}

func_12B82(param_00, param_01) {}