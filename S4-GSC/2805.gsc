/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2805.gsc
*************************************************/

_id_BB93() {
  _id_0990::_id_C20E("bonus_points_team", ::_id_710A);

  if(_id_0990::_id_60F3()) {
    _id_0990::_id_1083("bonus_points_team", "s4_zm_zombie_money_icon", "ZOMBIE/POWERUP_BONUS_POINTS", _id_0990::_id_602D, !1, !1, !1);
    _id_0990::_id_BB18("bonus_points_team", "zmb_powerup_spawn", "zmb_powerup_lp", "zmb_powerup_grab_plr", "zmb_powerup_grab_npc", "");
  }
}

_id_710A(var_0) {
  level thread _id_269C(self, var_0);
  var_0 thread _id_0990::_id_BB20("bonus");
}

_id_269C(var_0, var_1) {
  foreach(var_3 in scripts\cp\utility::_id_6C5C()) {
    if(isDefined(var_3) && isPlayer(var_3) && isDefined(var_0._id_7953)) {
      var_3 _id_0990::_id_BB0F(6);
    }

    var_3 thread _id_0752::_id_7003("bonus_points_powerup");
  }
}