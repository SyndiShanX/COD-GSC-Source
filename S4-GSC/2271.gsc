/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2271.gsc
*************************************************/

_id_C576(var_0, var_1, var_2, var_3, var_4) {
  self._id_10328 = spawnStruct();
  self._id_10328.vehicle = var_0;
  self._id_10328._id_36F2 = var_2;
  self._id_10328._id_36F1 = var_3;
  self._id_10328._id_E312 = var_1;
  self._id_10328._id_DDC5 = var_4;
}

_id_10801(var_0) {
  if(isDefined(var_0)) {
    var_1 = scripts\engine\utility::_id_1089A("entervehicle", "death", "long_death", "failedentervehicle", "getin_anim_done");
  } else {
    var_1 = scripts\engine\utility::_id_10899("entervehicle", "death", "long_death", "failedentervehicle");
  }

  if(var_1 != "entervehicle" && var_1 != "getin_anim_done") {
    return 0;
  }

  return 1;
}

_id_107F5() {
  self endon("death");
  self endon("long_death");

  while(isDefined(self._id_10328) || isDefined(self._id_0B67._id_4206) && !istrue(self._id_0B67._id_E6A0) && !istrue(self._id_0B67._id_54D5) && !istrue(self._id_0B67._id_84FC)) {
    waitframe();
  }
}

_id_54E8(var_0, var_1, var_2, var_3) {
  _id_C576(var_0, var_1, var_2, var_3);
  return _id_10801();
}

_id_C577() {
  self._id_579C = 1;
}

_id_10802() {
  self endon("death");
  self endon("long_death");

  while(!istrue(self._id_755E)) {
    waitframe();
  }

  self._id_755E = undefined;
}

_id_5798() {
  _id_C577();
  _id_10802();
}

_id_75C2() {
  return isDefined(self._id_10328) || isDefined(self._id_0B67._id_4206);
}

_id_D8AA() {
  self._id_0B67._id_1033A = 1;
}

_id_5785() {
  if(scripts\common\utility::issp()) {
    return;
  }
  self._id_0B67._id_4206._id_31A5 = 0;
  self._id_0B67._id_4206 thread _id_579B();
}

_id_579B() {
  self endon("death");
  waitframe();
  self._id_31A5 = 1;
}