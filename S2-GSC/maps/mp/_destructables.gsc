/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_destructables.gsc
*********************************************/

func_00D5() {
  var_00 = getEntArray("destructable", "targetname");
  if(getDvar("scr_destructables") == "0") {
    for(var_01 = 0; var_01 < var_00.size; var_01++) {
      var_00[var_01] delete();
    }

    return;
  }

  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_00[var_01] thread func_2DE1();
  }
}

func_2DE1() {
  var_00 = 40;
  var_01 = 0;
  if(isDefined(self.var_80F8)) {
    var_00 = self.var_80F8;
  }

  if(isDefined(self.var_82B7)) {
    var_01 = self.var_82B7;
  }

  if(isDefined(self.var_8162)) {
    var_02 = strtok(self.var_8162, " ");
    for(var_03 = 0; var_03 < var_02.size; var_03++) {
      func_17D7(var_02[var_03]);
    }
  }

  if(isDefined(self.var_81BB)) {
    self.var_3F2F = loadfx(self.var_81BB);
  }

  var_04 = 0;
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_05, var_06);
    if(var_05 >= var_01) {
      var_04 = var_04 + var_05;
      if(var_04 >= var_00) {
        thread func_2DE0();
        return;
      }
    }
  }
}

func_2DE0() {
  var_00 = self;
  if(isDefined(self.var_8162)) {
    var_01 = strtok(self.var_8162, " ");
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      func_A017(var_01[var_02]);
    }
  }

  if(isDefined(var_00.var_3F2F)) {
    playFX(var_00.var_3F2F, var_00.var_0116 + (0, 0, 6));
  }

  var_00 delete();
}

func_17D7(param_00) {}

func_17E0(param_00, param_01) {}

func_A017(param_00) {}

func_A018(param_00, param_01) {}