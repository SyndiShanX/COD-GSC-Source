/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2580.gsc
**************************************/

_id_98C5(var_0) {
  self._id_10264 = 1;
  setupdestructibledoors();
  return anim.success;
}

setupdestructibledoors() {
  if(isDefined(self._id_2AB4)) {
    thread _id_4D5E();
  }

  if(isDefined(self._id_2AB5)) {
    thread _id_5670();
  }
}

_id_4D5E() {
  self endon("death");
  self endon("terminate_ai_threads");
  var_0 = 0;

  for(;;) {
    self waittill("damage_part_died", var_1);

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];
      var_4 = var_2 < 3;
      _id_C924(var_3, var_4);
      var_1[var_2] = undefined;
    }

    var_1 = undefined;
  }
}

_id_C924(var_0, var_1) {
  var_2 = var_0._id_004E;
  self hidepart(var_0.partname);
  var_3 = anglestoup(self gettagangles(var_0.partname));
}

_id_5670() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("dismemberment_part_died", var_0);

    foreach(var_2 in var_0) {
      _id_5673(var_2);
    }

    var_0 = undefined;
  }
}

_id_5673(var_0) {
  switch (var_0.partname) {
    case "right_arm":
      return;
  }

  self._blackboard._id_5663 = 1;
  scripts\asm\asm_bb::bb_dismemberedpart(var_0.partname);
  self _meth_8189(var_0._id_0332);
}