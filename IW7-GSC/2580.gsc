/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2580.gsc
*********************************************/

func_98C5(var_0) {
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
  var_0 = 0;
  for(;;) {
    self waittill("damage_part_died", var_1);
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];
      var_4 = var_2 < 3;
      func_C924(var_3, var_4);
      var_1[var_2] = undefined;
    }

    var_1 = undefined;
  }
}

func_C924(var_0, var_1) {
  var_2 = var_0.var_4E;
  self hidepart(var_0.updategamerprofileall);
  var_3 = anglestoup(self gettagangles(var_0.updategamerprofileall));
}

func_5670() {
  self endon("death");
  self endon("terminate_ai_threads");
  for(;;) {
    self waittill("dismemberment_part_died", var_0);
    foreach(var_2 in var_0) {
      func_5673(var_2);
    }

    var_0 = undefined;
  }
}

func_5673(var_0) {
  switch (var_0.updategamerprofileall) {
    case "right_arm":
      break;
  }

  self._blackboard.var_5663 = 1;
  scripts\asm\asm_bb::bb_dismemberedpart(var_0.updategamerprofileall);
  self _meth_8189(var_0.var_332);
}