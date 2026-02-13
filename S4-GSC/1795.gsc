/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1795.gsc
*************************************************/

_id_C1EF() {
  _id_0737::_id_C266("ammo", ::_id_6348, ::_id_837F, ::_id_16CF, undefined, undefined, undefined, undefined, 1, "v_ui_icons_zombies_minimap_ammocache");
  _id_0737::_id_10C8("ammo", ::ammo_cache_set_hint);
  _id_0737::_id_10C9("ammo", ::ammo_cache_unset_hint);
  _id_0737::addinteractionhinttypecallback("ammo", ::ammo_cache_hint_type);
}

_id_6348(var_0, var_1) {
  return var_1 get_ammo_cache_hint_string();
}

ammo_cache_hint_type(var_0, var_1) {
  return var_1 get_ammo_cache_hint_type();
}

_id_837F(var_0, var_1) {
  if(!var_1 can_give_ammo()) {
    return;
  }
  var_2 = var_1 _id_6418();
  var_3 = "null";

  if(var_1 _id_074E::_id_B4C5(var_2, var_3)) {
    var_1 _id_074E::_id_ED93(var_2, 1, var_3);
    var_4 = var_1 getcurrentweapon();
    var_1 givemaxammo(var_4);
    var_5 = weaponclipsize(var_4);
    var_1 setweaponammoclip(var_4, var_5);
    var_1 playlocalsound("zmb_ui_purchase_accept");
  } else {
    var_1 playlocalsound("zmb_ui_purchase_deny");
    var_1 _id_0720::_id_BEC0("insufficient_funds", 1);
  }
}

_id_16CF(var_0) {}

ammo_cache_set_hint(var_0, var_1) {
  var_1 thread update_ammo_cache_hint();
}

ammo_cache_unset_hint(var_0, var_1) {
  var_1 notify("ammo_cache_unset_hint");
}

update_ammo_cache_hint() {
  self endon("ammo_cache_unset_hint");
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    var_0 = get_ammo_cache_hint_string();
    self._id_8388 sethintstring(var_0);
    var_1 = get_ammo_cache_hint_type();
    self._id_8388 setcursorhint(var_1);
    wait 1.0;
  }
}

get_ammo_cache_hint_type() {
  var_0 = "HINT_NOICON";

  if(!can_give_ammo()) {
    var_0 = "HINT_NOBUTTON";
  }

  return var_0;
}

get_ammo_cache_hint_string() {
  var_0 = _id_6418();
  var_1 = self._id_0133;
  var_2 = _id_0737::_id_6E7B(var_1);
  self._id_8388 _meth_8557(var_0, var_2);

  if(!can_weapon_buy_ammo(var_1)) {
    return &"CP_ZMB_INTERACTIONS/AMMO_INVALID_WEAPON";
  } else if(_id_074E::_id_B4C5(var_0) && can_give_ammo()) {
    return &"CP_ZMB_INTERACTIONS/AMMO_PURCHASE";
  } else if(_id_074E::_id_B4C5(var_0) && !can_give_ammo()) {
    return &"CP_ZMB_INTERACTIONS/AMMO_FULL";
  } else {
    return &"CP_ZMB_INTERACTIONS/AMMO_NEED_MONEY";
  }
}

_id_6418() {
  var_0 = self._id_0133;
  var_1 = scripts\cp\cp_weapon::_id_683D(var_0);

  if(scripts\engine\utility::is_equal(var_0.basename, "s4_ar_tgun_mp")) {
    switch (var_1) {
      case 1:
        return 1000;
      case 2:
        return 5000;
      case 3:
        return 5000;
      case 4:
        return 5000;
      case 5:
        return 5000;
      default:
        return 1000;
    }
  } else {
    switch (var_1) {
      case 1:
        return 250;
      case 2:
        return 1000;
      case 3:
        return 2500;
      case 4:
        return 5000;
      case 5:
        return 10000;
      default:
        return 250;
    }
  }
}

can_give_ammo() {
  var_0 = self._id_0133;

  if(!can_weapon_buy_ammo(var_0)) {
    return 0;
  }

  var_1 = self getweaponammoclip(var_0);
  var_2 = weaponclipsize(var_0);
  var_3 = weaponmaxammo(var_0);
  var_4 = self getweaponammostock(var_0);

  if(!scripts\cp\utility::is_throwable_melee_weapon(var_0) && var_4 < var_3 || var_1 < var_2) {
    return 1;
  }

  return 0;
}

can_weapon_buy_ammo(var_0) {
  if(scripts\cp\utility::_id_8632(var_0) && !scripts\cp\utility::is_throwable_melee_weapon(var_0) || scripts\cp\utility::_id_88F6(var_0)) {
    return 0;
  }

  return 1;
}