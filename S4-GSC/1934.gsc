/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1934.gsc
*************************************************/

init() {
  level._id_5487 = 0;
  level._id_5486 = getdvarint("#x3dd952e21305f12f9", 200);
  level._id_2C96 = [];
}

_id_C2B6(var_0) {
  self._id_5489 = var_0;
  level._id_5487 = level._id_5487 + var_0;
  _id_FC1B();
}

_id_4807() {
  if(isDefined(self._id_5489) && !isDefined(self._id_4800)) {
    level._id_5487 = level._id_5487 - self._id_5489;
    self._id_4800 = 1;
    self._id_5489 = undefined;

    if(level._id_5487 < 0) {
      level._id_5487 = 0;
    }
  }

  if(isDefined(self._id_548A)) {
    level._id_2C96 = scripts\engine\utility::array_remove(level._id_2C96, self);
    self._id_548A = undefined;
  }
}

_id_C2B5(var_0, var_1) {
  self._id_5489 = var_0;
  self._id_548A = var_1;
  level._id_5487 = level._id_5487 + var_0;
  level._id_2C96[level._id_2C96.size] = self;
  _id_FC1B();
}

_id_FC1B() {
  if(level._id_5487 > level._id_5486) {
    if(isDefined(level._id_2C96[0])) {
      level._id_5487 = level._id_5487 - level._id_2C96[0]._id_5489;
      self[[level._id_2C96[0]._id_548A]]();
    } else {}

    level._id_2C96 = scripts\engine\utility::_id_1BD4(level._id_2C96, 0, 1);
  }
}