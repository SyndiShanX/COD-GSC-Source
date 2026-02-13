/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2378.gsc
*************************************************/

_id_8276() {}

_id_826B() {
  _id_800A();
}

_id_800A() {
  var_0 = [];
  var_0["nerf_take_more_damage"] = 1.0;
  var_0["nerf_higher_threatbias"] = 0;
  var_0["nerf_smaller_wallet"] = 1.0;
  var_0["nerf_earn_less_money"] = 1.0;
  var_0["nerf_lower_weapon_damage"] = 1.0;
  var_0["nerf_no_class"] = 0;
  var_0["nerf_pistols_only"] = 0;
  var_0["nerf_fragile"] = 1.0;
  var_0["nerf_move_slower"] = 1.0;
  var_0["nerf_no_abilities"] = 0;
  var_0["nerf_min_ammo"] = 1.0;
  var_0["nerf_no_deployables"] = 0;
  self._id_A426 = var_0;
  self._id_0EED = [];
}

_id_A424() {
  for(var_0 = 0; var_0 < 10; var_0++) {
    var_1 = _id_674C(var_0);
    _id_0EC6(var_1);
  }
}

_id_0EC6(var_0) {
  if(_id_8642(var_0)) {
    return;
  }
  if(_id_A423(var_0)) {
    return;
  }
  _id_C200(var_0);
  [[level._id_BBFC[var_0]]]();
}

_id_A423(var_0) {
  return scripts\engine\utility::array_contains(self._id_0EED, var_0);
}

_id_C200(var_0) {
  self._id_0EED[self._id_0EED.size] = var_0;
}

_id_C17A() {
  _id_C179();
  _id_C176();
}

_id_869B() {
  return 1;
}

_id_8642(var_0) {
  return var_0 == "none";
}

_id_65FA() {
  return self._id_0EED.size;
}

_id_018A() {}

_id_7DB4() {
  _id_D299("nerf_take_more_damage", 1.33);
}

_id_7DC1() {
  _id_D299("nerf_higher_threatbias", 500);
}

_id_C179() {
  _id_D299("nerf_smaller_wallet", 0.5);
}

_id_C176() {
  _id_D299("nerf_earn_less_money", 0.75);
}

_id_98C0() {
  _id_D299("nerf_lower_weapon_damage", 0.66);
}

_id_A509() {
  _id_D299("nerf_no_class", 1.0);
}

_id_B134() {
  _id_D299("nerf_pistols_only", 1.0);
}

_id_DDF8() {
  _id_D299("nerf_fragile", 1.5);
}

_id_A1FA() {
  _id_D299("nerf_move_slower", 0.7);
}

_id_A4FF() {
  _id_D299("nerf_no_abilities", 1.0);
}

_id_9E98() {
  _id_D299("nerf_min_ammo", 0.25);
}

_id_A50D() {
  _id_D299("nerf_no_deployables", 1.0);
}

_id_D299(var_0, var_1) {
  self._id_A426[var_0] = var_1;
}

_id_65CF(var_0) {
  return self._id_A426[var_0];
}

_id_674C(var_0) {}

_id_BBF0() {
  return _id_65CF("nerf_take_more_damage");
}

_id_BBF9() {
  return _id_65CF("nerf_higher_threatbias");
}

_id_BBFA() {
  return _id_65CF("nerf_smaller_wallet");
}

_id_BBF2() {
  return _id_65CF("nerf_earn_less_money");
}

_id_BBFB() {
  return _id_65CF("nerf_lower_weapon_damage");
}

_id_BBF5() {
  return _id_65CF("nerf_no_class");
}

_id_BBF7() {
  return _id_65CF("nerf_pistols_only");
}

_id_BBF8() {
  return _id_65CF("nerf_fragile");
}

_id_BBF3() {
  return _id_65CF("nerf_move_slower");
}

_id_BBF4() {
  return _id_65CF("nerf_no_abilities");
}

_id_BBF1() {
  return _id_65CF("nerf_min_ammo");
}

_id_BBF6() {
  return _id_65CF("nerf_no_deployables");
}