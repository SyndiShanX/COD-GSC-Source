/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2048.gsc
*************************************************/

init() {
  var_0 = spawnStruct();
  level._id_0E8B = var_0;
  var_0._id_0E8E = [];
  var_0._id_0E8F = [];
  _id_1085("usability", scripts\common\utility::_id_158A);
  _id_1085("weapon", scripts\common\utility::_id_158D);
  _id_1085("weapon_switch", scripts\common\utility::_id_1593);
  _id_1085("offhand_weapons", scripts\common\utility::_id_1562);
  _id_1085("offhand_primary_weapons", scripts\common\utility::_id_155E);
  _id_1085("offhand_secondary_weapons", scripts\common\utility::_id_155F);
  _id_1085("killstreaks", scripts\common\utility::_id_154F);
  _id_1085("supers", scripts\common\utility::_id_1587);
  _id_1085("gesture", scripts\mp\utility\player::_id_1543);
  _id_1085("ads", scripts\common\utility::_id_151F);
  _id_1085("reload", scripts\common\utility::_id_1575);
  _id_1085("autoreload", scripts\common\utility::_id_1525);
  _id_1085("allow_movement", scripts\common\utility::_id_1559);
  _id_1085("allow_jump", scripts\common\utility::_id_154E);
  _id_1085("sprint", scripts\common\utility::_id_1581);
  _id_1085("crouch", scripts\common\utility::_id_1530);
  _id_1085("prone", scripts\common\utility::_id_1570);
  _id_1085("stand", scripts\common\utility::_id_1582);
  _id_1085("fire", scripts\common\utility::_id_153E);
  _id_1085("slide", scripts\common\utility::_id_157F);
  _id_1085("melee", scripts\common\utility::_id_1554);
  _id_1085("shellshock", scripts\common\utility::_id_157E);
  _id_1085("cp_munitions", scripts\common\utility::_id_152E);
  _id_1085("nvg", scripts\common\utility::_id_155D);
}

_id_1085(var_0, var_1) {
  level._id_0E8B._id_0E8E[var_0] = var_1;
}

_id_687E(var_0) {
  return level._id_0E8B._id_0E8E[var_0];
}

_id_C23B(var_0, var_1) {
  level._id_0E8B._id_0E8F[var_0] = var_1;
}

_id_1596(var_0, var_1) {
  foreach(var_3 in level._id_0E8B._id_0E8F[var_0]) {
    var_4 = _id_687E(var_3);
    [[var_4]](var_1, var_0);
  }
}