/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2809.gsc
*************************************************/

_id_BB93() {
  _id_0990::_id_C20E("insta_kill", ::_id_7110);

  if(_id_0990::_id_60F3()) {
    _id_0990::_id_1083("insta_kill", "s4_zm_power_up_insta_kill", "ZOMBIE/POWERUP_INSTA_KILL", _id_0990::_id_602D, !1, !1, !1, undefined, "powerup_instant_kill", "zombie_powerup_insta_kill_time", "zombie_powerup_insta_kill_on");
    _id_0990::_id_BB18("insta_kill", "zmb_powerup_spawn", "zmb_powerup_lp", "zmb_powerup_grab_plr", "zmb_powerup_grab_npc", "zmb_timeout_flash");
  }
}

_id_7110(var_0) {
  if(_id_0990::_id_4C75("insta_kill")) {
    level thread _id_82F7(self, var_0);
  } else {
    level thread _id_82F5(self, var_0);
  }

  var_0 thread _id_0990::_id_BB20("insta_kill");
}

_id_82F7(var_0, var_1) {
  var_1 notify("powerup instakill");
  var_1 endon("powerup instakill");
  var_1 endon("disconnect");
  var_2 = 30;
  var_1 thread _id_0990::_id_DC5C("insta_kill");

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_0._id_7953)) {
    var_1 _id_0990::_id_BB0F(1);
  }

  var_1 scripts\cp\utility::_id_D459("zombie_insta_kill", 1);
  level scripts\engine\utility::_id_108F5("end_game", var_2);
  var_1 scripts\cp\utility::_id_D459("zombie_insta_kill", 0);
  var_1 notify("insta_kill_over");
}

_id_82F5(var_0, var_1) {
  level notify("powerup instakill_" + var_1.team);
  level endon("powerup instakill_" + var_1.team);

  if(isDefined(level._id_82F6)) {
    level thread[[level._id_82F6]](var_0, var_1);
    return;
  }

  var_2 = var_1.team;
  level thread _id_0990::_id_DC5B(var_2, "insta_kill");
  var_3 = scripts\cp\utility::_id_6C5C();

  foreach(var_5 in var_3) {
    if(isDefined(var_5) && isPlayer(var_5) && isDefined(var_0._id_7953)) {
      var_5 _id_0990::_id_BB0F(1);
    }
  }

  scripts\cp\utility::_id_D45A("zombie_insta_kill", var_2, 1);
  var_7 = 30;
  wait(var_7);
  scripts\cp\utility::_id_D45A("zombie_insta_kill", var_2, 0);
  var_3 = scripts\cp\utility::_id_6C5C(var_2);

  if(var_3.size > 0 && isDefined(var_3[0])) {
    var_3[0] playsoundtoteam("zmb_timeout", var_2);
  }

  for(var_8 = 0; var_8 < var_3.size; var_8++) {
    if(isDefined(var_3[var_8])) {
      var_3[var_8] notify("insta_kill_over");
    }
  }
}