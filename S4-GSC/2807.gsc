/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2807.gsc
*************************************************/

_id_BB93() {
  _id_0990::_id_C20E("full_ammo", ::_id_710D);

  if(_id_0990::_id_60F3()) {
    _id_0990::_id_1083("full_ammo", "s4_zm_power_up_max_ammo", "ZOMBIE/POWERUP_MAX_AMMO", _id_0990::_id_602D, !1, !1, !1);
    _id_0990::_id_BB18("full_ammo", "zmb_powerup_spawn", "zmb_powerup_lp", "zmb_powerup_grab_plr", "zmb_powerup_grab_npc", "");
  }
}

_id_710D(var_0) {
  if(_id_0990::_id_4C75("full_ammo")) {
    level thread _id_5FF4(self, var_0);
  } else {
    level thread _id_5FF3(self, var_0);
  }

  var_0 thread _id_0990::_id_BB20("full_ammo");
}

_id_5FF4(var_0, var_1) {
  if(isDefined(level._id_34A5)) {
    if([[level._id_34A5]](var_1) == 0) {
      return;
    }
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_0._id_7953)) {
    var_1 _id_0990::_id_BB0F(3);
  }

  var_1._id_2020 = undefined;
  var_1 notify("zmb_max_ammo");
  _id_6EBF(var_1);
  var_1 playsoundtoplayer("zmb_max_ammo", var_1);
}

_id_5FF3(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_6C5C(var_1.team);

  if(isDefined(level._id_0BF7)) {
    var_2 = [[level._id_0BF7]](var_1);
  }

  level notify("zmb_max_ammo_level");

  foreach(var_1 in var_2) {
    if(isDefined(level._id_34A5)) {
      if([[level._id_34A5]](var_1) == 0) {
        continue;
      }
    }

    if(var_1 _meth_8605()) {
      continue;
    }
    if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_0._id_7953)) {
      var_1 _id_0990::_id_BB0F(3);
    }

    var_1._id_2020 = undefined;
    var_1 notify("zmb_max_ammo");
    _id_6EBF(var_1);
  }

  level thread _id_5FF2(var_0, var_1.team);
}

_id_5FF2(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_6C5C(var_1);
}

_id_DA93() {
  return level._id_A385 == 0;
}

_id_6EBF(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(scripts\cp\utility::_id_88F6(var_3.basename)) {
      continue;
    }
    var_0 givemaxammo(var_3);
    var_0 setweaponammoclip(var_3, weaponclipsize(var_3));

    if(scripts\cp\utility::_id_8774(var_3)) {
      var_0 notify("thrown_weapon_cleanup", var_3);
    }
  }
}