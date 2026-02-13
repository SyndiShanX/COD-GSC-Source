/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2806.gsc
*************************************************/

_id_BB93() {
  _id_0990::_id_C20E("double_points", ::_id_710C);

  if(_id_0990::_id_60F3()) {
    _id_0990::_id_1083("double_points", "s4_zm_power_up_double_points", "ZOMBIE/POWERUP_DOUBLE_POINTS", _id_0990::_id_602D, !1, !1, !1, undefined, "powerup_double_points", "zombie_powerup_double_points_time", "zombie_powerup_double_points_on");
    _id_0990::_id_BB18("double_points", "zmb_powerup_spawn", "zmb_powerup_lp", "zmb_powerup_grab_plr", "zmb_powerup_grab_npc", "zmb_dblpnts_timeout_flash");
  }

  scripts\cp\utility::_id_D458("zombie_point_scalar", 1, 1, 1);
}

_id_710C(var_0) {
  if(_id_0990::_id_4C75("double_points")) {
    level thread _id_4E9A(self, var_0);
  } else {
    level thread _id_4E99(self, var_0);
  }

  var_0 thread _id_0990::_id_BB20("double_points");
}

_id_4E9A(var_0, var_1) {
  var_1 notify("powerup points scaled");
  var_1 endon("powerup points scaled");
  var_1 endon("disconnect");
  var_1 thread _id_0990::_id_DC5C("double_points");

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_0._id_7953)) {
    var_1 _id_0990::_id_BB0F(4);
  }

  var_1 scripts\cp\utility::_id_D459("zombie_point_scalar", 2);
  var_2 = 30;
  level scripts\engine\utility::_id_108F5("end_game", var_2);
  var_1 scripts\cp\utility::_id_D459("zombie_point_scalar", undefined);
}

_id_4E99(var_0, var_1) {
  level notify("powerup points scaled_" + var_1.team);
  level endon("powerup points scaled_" + var_1.team);
  var_2 = var_1.team;
  level thread _id_0990::_id_DC5B(var_2, "double_points");
  var_3 = scripts\cp\utility::_id_6C5C();

  foreach(var_5 in var_3) {
    if(isDefined(var_5) && isPlayer(var_5) && isDefined(var_0._id_7953)) {
      var_5 _id_0990::_id_BB0F(4);
    }
  }

  if(isDefined(level._id_4172) && level._id_4172 == 2) {
    if(isDefined(var_1._id_0CAC)) {
      if(var_1._id_0CAC == 1) {
        level._id_0CAD = 1;
      } else {
        level._id_0CAD = 2;
      }
    }
  }

  scripts\cp\utility::_id_D45A("zombie_point_scalar", var_2, 2);
  var_7 = 30;
  wait(var_7);
  scripts\cp\utility::_id_D45A("zombie_point_scalar", var_2, 1);

  if(isPlayer(var_1)) {
    var_1 playsoundtoteam("zmb_dblpnts_timeout", var_2);
  }

  level._id_0CAD = undefined;
}