/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2808.gsc
*************************************************/

_id_BB93() {
  _id_0990::_id_C20E("hero_weapon_power", ::_id_787D);

  if(_id_0990::_id_60F3()) {
    _id_0990::_id_1083("hero_weapon_power", "s4_zm_power_up_full_power", "ZOMBIE/POWERUP_HERO_WEAPON_POWER", ::func_should_drop_hero_weapon, !1, !1, !1);
    _id_0990::_id_BB18("hero_weapon_power", "zmb_powerup_spawn", "zmb_powerup_lp", "zmb_powerup_grab_plr", "zmb_powerup_grab_npc", "");
  }
}

func_should_drop_hero_weapon() {
  if(istrue(level.b_field_upgrade_used)) {
    return 1;
  }

  return 0;
}

_id_787D(var_0) {
  foreach(var_2 in scripts\cp\utility::_id_6C5C()) {
    if(isPlayer(var_2) && isDefined(self._id_7953)) {
      var_2 _id_0990::_id_BB0F(7);
    }

    var_3 = var_2 _id_0766::getcurrentsuper();

    if(!isalive(var_2) || !isDefined(var_3)) {
      continue;
    }
    if(scripts\engine\utility::is_equal(var_3._id_340D + 1, var_3._id_9C5C)) {
      var_2 _id_0766::_id_D6F8(var_2 _id_0766::_id_6DA3(), 0, 1);
      continue;
    }

    if(var_3._id_340D + 1 < var_3._id_9C5C) {
      var_3._id_340D = int(min(var_3._id_340D + 1, var_3._id_9C5C));
      var_2 setclientomnvar("ui_super_charges", var_3._id_340D);
      var_2 setweaponammoclip(var_3._id_E76B._id_04F6, var_3._id_340D);
    }
  }

  var_0 thread _id_0990::_id_BB20("full_power");
}