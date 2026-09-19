/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\766.gsc
**************************************/

_id_8CCC(var_0, var_1) {
  return 1;
}

_id_8CCB(var_0, var_1) {
  return (gettime() - var_1) * 0.001 >= var_0;
}

_id_8CC0(var_0) {
  if(isDefined(level._id_9321))
    return level._id_9321[var_0];
}

_id_8CBE(var_0) {
  var_1 = spawnStruct();
  var_1._id_9320 = var_0;
  var_1._id_9328 = [];
  level._id_9321[var_0] = var_1;
  return var_1;
}

_id_8CBB(var_0) {
  var_1 = spawnStruct();
  var_1._id_9322 = var_0;
  var_1._id_9C6B = [];
  self._id_9328[var_0] = var_1;
}

_id_8CBC(var_0, var_1, var_2, var_3) {
  var_4 = _id_071C(var_0);
  var_4._id_9C6B[var_4._id_9C6B.size] = [var_1, var_2, var_3];
}

_id_8CB9(var_0, var_1, var_2) {
  var_3 = _id_071C(var_0);
  var_3._id_37B2 = var_1;
  var_3._id_37B3 = var_2;
}

_id_8CBD(var_0, var_1, var_2) {
  var_3 = _id_071C(var_0);
  var_3._id_A0A7 = var_1;
  var_3._id_A0A8 = var_2;
}

_id_8CBA(var_0, var_1, var_2) {
  var_3 = _id_071C(var_0);
  var_3._id_38E9 = var_1;
  var_3._id_38EA = var_2;
}

_id_071C(var_0) {
  var_1 = self._id_9328[var_0];
  return var_1;
}

_id_071B(var_0, var_1, var_2) {
  foreach(var_8, var_4 in var_1._id_9C6B) {
    var_5 = var_4[0];
    var_6 = var_4[1];
    var_7 = var_4[2];

    if(self[[var_6]](var_7, var_2))
      return var_5;
  }

  return undefined;
}

_id_8CBF(var_0, var_1) {
  if(isDefined(var_1))
    self endon("death");

  var_2 = _id_8CC0(var_0);
  self._id_28CD = getfirstarraykey(var_2._id_9328);
  var_3 = var_2._id_9328[self._id_28CD];
  var_4 = gettime();

  if(isDefined(var_3._id_37B2))
    self[[var_3._id_37B2]](var_3._id_37B3);

  for(;;) {
    var_5 = _id_071B(var_2, var_3, var_4);

    if(isDefined(var_5)) {
      self notify("sm_state_change");

      if(isDefined(var_3._id_38E9))
        self[[var_3._id_38E9]](var_3._id_38EA);

      if(var_5 == "") {
        return;
      }
      self._id_28CD = var_5;
      var_3 = var_2._id_9328[var_5];
      var_4 = gettime();

      if(isDefined(var_3._id_37B2))
        self[[var_3._id_37B2]](var_3._id_37B3);

      continue;
    }

    if(isDefined(var_3._id_A0A7))
      self[[var_3._id_A0A7]](var_3._id_A0A8, var_4);

    waitframe();
  }
}