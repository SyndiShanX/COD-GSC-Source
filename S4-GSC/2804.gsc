/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2804.gsc
*************************************************/

_id_BB93() {
  _id_0990::_id_C20E("armor_repair", ::_id_7109);

  if(_id_0990::_id_60F3()) {
    _id_0990::_id_1083("armor_repair", "s4_zm_power_up_armor_vest_01", "ZOMBIE/POWERUP_ARMOR_REPAIR", ::func_should_drop_armor, !1, !1, !1);
    _id_0990::_id_BB18("armor_repair", "zmb_powerup_spawn", "zmb_powerup_lp", "zmb_powerup_grab_plr", "zmb_powerup_grab_npc", "");
  }
}

func_should_drop_armor() {
  foreach(var_1 in level.players) {
    if(var_1._id_1B3D > 0) {
      return 1;
    }
  }

  return 0;
}

_id_7109(var_0) {
  foreach(var_2 in scripts\cp\utility::_id_6C5C()) {
    if(isPlayer(var_2)) {
      var_2 _id_0990::_id_BB0F(8);

      if(isDefined(var_2._id_1B3D) && var_2._id_1B3D > 0) {
        _id_0707::_id_6ECA(var_2, var_2._id_1B3D);
      }
    }
  }

  var_0 thread _id_0990::_id_BB20("armor");
}