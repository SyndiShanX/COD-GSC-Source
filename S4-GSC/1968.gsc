/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1968.gsc
*************************************************/

_id_7EF6() {
  if(!isDefined(level._id_1E7E)) {
    level._id_1E7E = spawnStruct();
  }

  _id_8095();
  level._id_AB5B = ::_id_AB5B;
}

_id_AB5B() {
  _id_19C2("default");
}

_id_8095() {
  _id_1010("default", "generic", 0.15, 0.9, 2);
}

_id_1010(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  _id_86A6(var_1);
  var_5["roomtype"] = var_1;
  var_5["wetlevel"] = var_2;
  var_5["drylevel"] = var_3;
  var_5["fadetime"] = var_4;
  level._id_1E7E._id_C7B5[var_0] = var_5;
}

_id_86A6(var_0) {}

_id_19C2(var_0) {
  if(!isDefined(level._id_1E7E._id_C7B5[var_0])) {
    var_1 = level._id_1E7E._id_C7B5["default"];
  } else {
    var_1 = level._id_1E7E._id_C7B5[var_0];
  }
}