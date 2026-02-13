/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2444.gsc
*************************************************/

init() {
  level._effect["aether_shroud_1p_effect"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_aether_shroud_head_1p.vfx");
  level._effect["aether_shroud_3p_head_effect"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_aether_shroud_head_3p.vfx");
  level._effect["aether_shroud_3p_torso_effect"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_aether_shroud_torso_3p.vfx");
  _id_06CB::_id_AA65(::_id_11E3);
  _id_06CB::_id_AA4A(::aether_shroud_on_ai_killed);
}

_id_4BDD() {
  if(istrue(self._id_11E0)) {
    return 0;
  }

  scripts\engine\utility::_id_5474("zm_field_upgrade_in_use");
  var_0 = get_aether_shroud_level();
  var_1 = 5;

  if(var_0 >= 3) {
    var_1 = 8;
  }

  thread _id_11E0(var_1);

  if(var_0 >= 1) {
    thread _id_C312();
  }

  var_2 = self.health / self.maxhealth;

  if(var_2 <= 0.25) {
    _id_06FA::update_achievement_stat("ZM_ESCAPE_ARTIST", "low_health_aether_shroud_uses", 1);
  }

  return 1;
}

get_aether_shroud_level() {
  return self.super_level;
}

_id_11E3() {
  scripts\engine\utility::_id_5473("zm_field_upgrade_in_use");
  self._id_11E0 = undefined;
}

set_aether_shroud() {
  var_0 = get_aether_shroud_level();

  if(var_0 >= 4) {
    var_1 = _id_0766::getcurrentsuper();
    var_1._id_9C5C = 2;
  }
}

_id_11E0(var_0) {
  self endon("disconnect");
  var_1 = get_aether_shroud_level();
  self._id_11E0 = 1;
  self.aethershroudkills = 0;
  scripts\cp\utility::_id_1566(1);

  if(var_1 >= 3) {
    self._id_A25F = 1.5;
    thread _id_073C::_id_FCCC();
  }

  if(var_1 >= 3) {
    self _meth_8577("zombiedefault");
  }

  thread apply_effects();
  self playsoundtoplayer("zmb_fieldup_aethershroud_start", self);
  self setscriptablepartstate("aetherShroud", "active");
  var_2 = scripts\engine\utility::_id_108A8(var_0, "player_downed", "death");

  if(scripts\cp\utility::_id_88B5()) {
    scripts\cp\utility::_id_1566(0);
  }

  if(var_1 >= 3) {
    if(isDefined(level.aether_shroud_speed_scaler_override_func)) {
      self._id_A25F = [[level.aether_shroud_speed_scaler_override_func]](self);
    } else {
      self._id_A25F = 1.0;
    }

    thread _id_073C::_id_FCCC();
  }

  if(var_1 >= 3) {
    self _meth_8577("default");
  }

  thread remove_effects();
  self setscriptablepartstate("aetherShroud", "inactive");
  self playsoundtoplayer("zmb_fieldup_aethershroud_end", self);
  self._id_11E0 = undefined;
  self.aethershroudkills = undefined;
  scripts\engine\utility::_id_5470("zm_field_upgrade_in_use");
}

_id_C312() {
  var_0 = self getcurrentprimaryweapon();
  var_1 = self _meth_8109(var_0);
  var_2 = int(min(var_1, weaponclipsize(var_0)));
  var_3 = var_1 - var_2;

  if(var_3 < 0) {
    var_3 = 0;
    var_2 = var_1;
  }

  self setweaponammoclip(var_0, var_2);
  self setweaponammostock(var_0, var_3);
}

_id_11E2(var_0) {
  var_1 = var_0.attacker get_aether_shroud_level();

  if(var_1 >= 2) {
    return 5;
  }

  return 1;
}

apply_effects() {
  _func_019D(scripts\engine\utility::getfx("aether_shroud_1p_effect"), self, "j_head", self);

  foreach(var_1 in level.players) {
    if(!isDefined(var_1) || var_1 == self) {
      continue;
    }
    waitframe();

    if(!isDefined(var_1)) {
      continue;
    }
    _func_019D(scripts\engine\utility::getfx("aether_shroud_3p_head_effect"), self, "j_head", var_1);
    waitframe();

    if(isDefined(var_1)) {
      _func_019D(scripts\engine\utility::getfx("aether_shroud_3p_torso_effect"), self, "j_spine4", var_1);
    }
  }
}

remove_effects() {
  _func_02D1(scripts\engine\utility::getfx("aether_shroud_1p_effect"), self, "j_head", self);

  foreach(var_1 in level.players) {
    if(!isDefined(var_1) || var_1 == self) {
      continue;
    }
    waitframe();

    if(!isDefined(var_1)) {
      continue;
    }
    _func_02D1(scripts\engine\utility::getfx("aether_shroud_3p_head_effect"), self, "j_head", var_1);
    waitframe();

    if(isDefined(var_1)) {
      _func_02D1(scripts\engine\utility::getfx("aether_shroud_3p_torso_effect"), self, "j_spine4", var_1);
    }
  }
}

aether_shroud_on_ai_killed(var_0) {
  if(!isPlayer(var_0._id_50FF) || !istrue(var_0._id_50FF._id_11E0)) {
    return;
  }
  if(var_0._id_DE2B != "MOD_MELEE") {
    return;
  }
  if(isDefined(var_0._id_FFD4) && _id_06FE::is_zm_normal()) {
    self._id_BF52 = "torso_lower";
    self._id_BF53 = var_0._id_FFD4 * 10000;
  }
}