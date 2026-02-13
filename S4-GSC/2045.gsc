/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2045.gsc
*************************************************/

init() {
  level._id_AEA8 = [];
  _id_AEAA();
}

_id_AEAA() {
  if(!isDefined(level._id_AEA8)) {
    level._id_AEA8 = [];
  }

  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/passivetable.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/passivetable.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp/passivetable.csv", var_0, 12);
    var_4 = tablelookupbyrow("mp/passivetable.csv", var_0, 13);
    var_5 = tablelookupbyrow("mp/passivetable.csv", var_0, 14);
    var_6 = spawnStruct();
    var_6.name = var_2;
    var_6._id_10DE7 = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var_0, 8) == "", 0, 1);
    var_6._id_8DEC = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var_0, 9) == "", 0, 1);
    var_6._id_91E7 = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var_0, 10) == "", 0, 1);
    var_6._id_ED2D = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var_0, 11) == "", 0, 1);

    if(var_3 != "") {
      var_6._id_1DAE = var_3;
    }

    if(getDvar("#x3a30c33efc8281eb1") == "zombie") {
      var_7 = tablelookupbyrow("mp/passivetable.csv", var_0, 22);

      if(var_7 != "") {
        var_6._id_1DAE = var_7;
      }
    }

    if(var_4 != "") {
      var_6._id_AFF6 = var_4;
    }

    if(var_5 != "") {
      var_6._id_9DE9 = var_5;
    }

    if(!isDefined(level._id_AEA8[var_2])) {
      level._id_AEA8[var_2] = var_6;
    }

    var_0++;
  }
}

_id_6C18(var_0) {
  if(!isDefined(level._id_AEA8[var_0])) {
    return undefined;
  }

  var_1 = level._id_AEA8[var_0];
  return var_1;
}

_id_6C13(var_0) {
  var_1 = _id_6C18(var_0);

  if(!isDefined(var_1) || !isDefined(var_1._id_1DAE)) {
    return undefined;
  }

  return var_1._id_1DAE;
}

_id_6C16(var_0) {
  var_1 = _id_6C18(var_0);

  if(!isDefined(var_1) || !isDefined(var_1._id_AFF6)) {
    return undefined;
  }

  return var_1._id_AFF6;
}

_id_6C15(var_0) {
  var_1 = _id_6C18(var_0);

  if(!isDefined(var_1) || !isDefined(var_1._id_9DE9)) {
    return undefined;
  }

  return var_1._id_9DE9;
}

_id_6E91() {
  var_0 = [];

  foreach(var_2 in level._id_AEA8) {
    if(var_2._id_10DE7) {
      var_0[var_0.size] = var_2.name;
    }
  }

  return var_0;
}

_id_6AEB() {
  var_0 = [];

  foreach(var_2 in level._id_AEA8) {
    if(var_2._id_8DEC) {
      var_0[var_0.size] = var_2.name;
    }
  }

  return var_0;
}

_id_6AFD() {
  var_0 = [];

  foreach(var_2 in level._id_AEA8) {
    if(var_2._id_91E7) {
      var_0[var_0.size] = var_2.name;
    }
  }

  return var_0;
}

_id_6DB0() {
  var_0 = [];

  foreach(var_2 in level._id_AEA8) {
    if(var_2._id_ED2D) {
      var_0[var_0.size] = var_2.name;
    }
  }

  return var_0;
}