/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\104.gsc
**************************************/

_id_1477() {
  level._id_1456._id_1478 = spawnStruct();
  level._id_1456._id_1478._id_1479 = spawnStruct();
  level._id_1456._id_1478._id_1479._id_147A = _id_148A();
  level._id_1456._id_1478._id_1479.prev = _id_148A();
  level._id_1456._id_1478._id_147C = spawnStruct();
  level._id_1456._id_1478._id_147C._id_147A = _id_148A();
  level._id_1456._id_1478._id_147C.prev = _id_148A();
}

_id_147D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1.0;

  if(isDefined(var_1)) {
    var_5 = max(var_1, 0);
  }
  var_6 = 1.0;

  if(isDefined(var_4)) {
    var_6 = max(var_4, 0);
  }
  _id_1489(level._id_1456._id_1478._id_147C.prev, level._id_1456._id_1478._id_147C._id_147A.name, level._id_1456._id_1478._id_147C._id_147A._id_147F, level._id_1456._id_1478._id_147C._id_147A._id_147E);
  _id_1489(level._id_1456._id_1478._id_147C._id_147A, var_0, var_6, var_5);
  ambientplay(var_0, var_5, var_6);
}

_id_1480(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1.0;

  if(isDefined(var_1)) {
    var_5 = max(var_1, 0);
  }
  var_6 = 1.0;

  if(isDefined(var_2)) {
    var_6 = var_2;
  }
  var_7 = 1.0;

  if(isDefined(var_3)) {
    var_7 = max(var_3, 0);
  }
  _id_1489(level._id_1456._id_1478._id_1479.prev, level._id_1456._id_1478._id_1479._id_147A.name, level._id_1456._id_1478._id_1479._id_147A._id_147F, level._id_1456._id_1478._id_1479._id_147A._id_147E);
  _id_1489(level._id_1456._id_1478._id_1479._id_147A, var_0, var_7, var_5);

  if(isDefined(var_4)) {
    musicstop(var_6, var_4);
    musicplay(var_0, var_5, var_7, 0);
  } else {
    musicplay(var_0, var_5, var_7);
  }
}

_id_1481(var_0, var_1) {
  if(var_0 != "none") {
    var_2 = 1.0;

    if(isDefined(var_1)) {
      var_2 = max(var_1, 0);
    }
    if(level._id_1456._id_1478._id_147C._id_147A.name == var_0) {
      level._id_1456._id_1478._id_147C._id_147A = level._id_1456._id_1478._id_147C.prev;
      _id_148B(level._id_1456._id_1478._id_147C.prev);
    } else if(level._id_1456._id_1478._id_147C.prev.name == var_0) {
      _id_148B(level._id_1456._id_1478._id_147C.prev);
    }
    ambientstop(var_2, var_0);
  }
}

_id_1482(var_0, var_1) {
  var_2 = 1.0;

  if(isDefined(var_1)) {
    var_2 = max(var_1, 0);
  }
  if(level._id_1456._id_1478._id_1479._id_147A.name == var_0) {
    level._id_1456._id_1478._id_1479._id_147A = level._id_1456._id_1478._id_1479.prev;
    _id_148B(level._id_1456._id_1478._id_1479.prev);
  } else if(level._id_1456._id_1478._id_147C.prev.name == var_0) {
    _id_148B(level._id_1456._id_1478._id_1479.prev);
  }
  musicstop(var_2, var_0);
}

_id_1483(var_0) {
  var_1 = 1.0;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  ambientstop(var_1);
}

_id_1484(var_0) {
  var_1 = 1.0;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  _id_148B(level._id_1456._id_1478._id_1479._id_147A);
  _id_148B(level._id_1456._id_1478._id_1479.prev);
  musicstop(var_1);
}

_id_1485(var_0) {
  var_1 = 0.009;

  if(var_0.size == 1) {
    _id_1489(level._id_1456._id_1478._id_147C._id_147A, var_0[0]._id_1486, var_0[0]._id_147F, var_0[0]._id_147E);
  } else if(var_0.size == 2) {
    _id_1489(level._id_1456._id_1478._id_147C.prev, var_0[0]._id_1486, var_0[0]._id_147F, var_0[0]._id_147E);
    _id_1489(level._id_1456._id_1478._id_147C._id_147A, var_0[1]._id_1486, var_0[1]._id_147F, var_0[1]._id_147E);
  }

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_0[var_6]._id_1486;
    var_8 = max(var_0[var_6]._id_147F, 0);
    var_9 = clamp(var_0[var_6]._id_147E, 0, 1);

    if(var_7 != "none") {
      if(var_8 < var_1) {
        ambientstop(var_9, var_7);
        continue;
      }

      ambientplay(var_7, var_9, var_8, 0);
    }
  }
}

_id_1487() {
  return level._id_1456._id_1478._id_147C._id_147A.name;
}

_id_1488() {
  return level._id_1456._id_1478._id_1479._id_147A.name;
}

_id_1489(var_0, var_1, var_2, var_3) {
  var_0.name = var_1;
  var_0._id_147F = var_2;
  var_0._id_147E = var_3;
}

_id_148A() {
  var_0 = spawnStruct();
  var_0.name = "";
  var_0._id_147F = 0.0;
  var_0._id_147E = 0.0;
  return var_0;
}

_id_148B(var_0) {
  var_0.name = "";
  var_0._id_147F = 0.0;
  var_0._id_147E = 0.0;
}