/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2580.gsc
************************/

func_98C5(param_00) {
  self.var_10264 = 1;
  setupdestructibledoors();
  return level.success;
}

setupdestructibledoors() {
  if(isDefined(self.var_2AB4)) {
    thread func_4D5E();
  }

  if(isDefined(self.var_2AB5)) {
    thread func_5670();
  }
}

func_4D5E() {
  self endon("death");
  self endon("terminate_ai_threads");
  var_00 = 0;
  for(;;) {
    self waittill("damage_part_died", var_01);
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      var_03 = var_01[var_02];
      var_04 = var_02 < 3;
      func_C924(var_03, var_04);
      var_01[var_02] = undefined;
    }

    var_01 = undefined;
  }
}

func_C924(param_00, param_01) {
  var_02 = param_00.var_4E;
  self hidepart(param_00.updategamerprofileall);
  var_03 = anglestoup(self gettagangles(param_00.updategamerprofileall));
}

func_5670() {
  self endon("death");
  self endon("terminate_ai_threads");
  for(;;) {
    self waittill("dismemberment_part_died", var_00);
    foreach(var_02 in var_00) {
      func_5673(var_02);
    }

    var_00 = undefined;
  }
}

func_5673(param_00) {
  switch (param_00.updategamerprofileall) {
    case "right_arm":
      break;
  }

  self.var_1198.var_5663 = 1;
  scripts\asm\asm_bb::bb_dismemberedpart(param_00.updategamerprofileall);
  self _meth_8189(param_00.var_332);
}