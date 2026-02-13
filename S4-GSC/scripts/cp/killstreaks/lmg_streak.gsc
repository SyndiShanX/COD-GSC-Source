/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\lmg_streak.gsc
*************************************************/

init_lmg_streak() {
  scripts\cp\cp_killstreaks::register_killstreak("lmg_streak", ::try_use_lmg_streak, undefined, ::remove_lmg_streak, "s4_mg_streak_mp");
}

lmg_streak_available(var_0) {
  if(isDefined(var_0) && isDefined(var_0.additionalparams) && isDefined(var_0.additionalparams.ammocount)) {
    self.pers["lmgStreakAmmo"] = var_0.additionalparams.ammocount;
  }
}

remove_lmg_streak(var_0) {
  var_1 = spawnStruct();
  var_2 = self getcurrentweapon();

  if(var_2.basename == "s4_mg_streak_mp") {
    var_3 = self getweaponammoclip(var_2);
    var_1.ammocount = scripts\engine\utility::ter_op(var_3 == 0, undefined, var_3);
    self takeweapon(var_2);
  } else {
    if(isDefined(var_0.additionalparams.ammocount)) {
      var_3 = var_0.additionalparams.ammocount;
      var_1.ammocount = scripts\engine\utility::ter_op(var_3 == 0, undefined, var_3);
    }

    if(isDefined(var_0._id_04F6) && self hasweapon(var_0._id_04F6)) {
      self takeweapon(var_0._id_04F6);
    }
  }

  self notify("lmg_streak_ended");
  return var_1;
}

try_use_lmg_streak(var_0) {
  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  self.previousweaponbeforekillstreak = self getcurrentweapon();
  var_1 = ["zm_lmg_streak"];
  var_2 = makeweapon("s4_mg_streak_mp", var_1);
  self giveweapon(var_2);
  self._id_E9FF.streak._id_04F6 = var_2;
  var_3 = 0;

  if(istrue(var_0.additionalparams._id_5BD9)) {
    var_3 = weaponclipsize(var_2);
    var_0.additionalparams._id_5BD9 = undefined;
  } else if(isDefined(var_0.additionalparams) && isDefined(var_0.additionalparams.ammocount))
    var_3 = var_0.additionalparams.ammocount;
  else if(isDefined(self.pers["lmgStreakAmmo"])) {
    var_3 = self.pers["lmgStreakAmmo"];
  } else {
    var_3 = weaponclipsize(var_2);
  }

  self setweaponammoclip(var_2, var_3);
  self setweaponammostock(var_2, 0);
  var_0.additionalparams.ammocount = var_3;
  self switchtoweapon(var_2);
  self disableweaponpickup();

  if(isDefined(var_3) && var_3 <= 25) {
    _id_0720::_id_BEC0("deathmachine_low");
  } else {
    _id_0720::_id_BEC0("deathmachine_activate");
  }

  thread monitor_weapon_use(var_0, var_2);

  while(var_2 != self getcurrentweapon()) {
    waitframe();
  }

  thread monitor_weapon_swap();
  self setclientomnvar("ui_pap_current_level", 1);

  if(!istrue(watch_ammo(var_2))) {
    return 0;
  }

  return 1;
}

monitor_weapon_swap() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("non_temp_weapon_switch");
  self endon("lmg_streak_ended");

  for(;;) {
    var_0 = self getcurrentweapon();
    var_1 = var_0;

    while(var_0 == var_1 || var_0.basename == "none") {
      var_0 = self getcurrentweapon();
      waitframe();
    }

    self notify("non_temp_weapon_switch");
  }
}

monitor_weapon_use(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("lmg_streak_ended");
  thread monitor_fire(var_0, var_1);
  var_2 = scripts\engine\utility::_id_10898("death", "non_temp_weapon_switch", "round_ended");

  if(scripts\engine\utility::is_equal(var_2, "non_temp_weapon_switch") && self isonladder()) {
    monitor_weapon_use(var_0, var_1);
    return;
  }

  if(isDefined(level._id_8DD3)) {
    level[[level._id_8DD3]](var_0);
  }

  var_3 = self getweaponammoclip(var_1);
  var_0.additionalparams.ammocount = scripts\engine\utility::ter_op(var_3 == 0, undefined, var_3);

  if(var_2 != "round_ended") {
    self enableweaponswitch();
    self enableweaponpickup();
    self takeweapon(var_1);
    self notify("lmg_streak_ended");
  }
}

monitor_fire(var_0, var_1) {
  self endon("death");
  self endon("non_temp_weapon_switch");
  self endon("round_ended");
  self notify("lmg_streak_monitor_fire");
  self endon("lmg_streak_monitor_fire");
  self endon("lmg_streak_ended");

  for(;;) {
    self waittill("grenade_fire", var_2);
    var_3 = self getcurrentweapon();

    if(var_3 != var_1) {
      continue;
    }
    if(isDefined(var_2)) {
      var_2.streakinfo = var_0;
    }
  }
}

watch_ammo(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("non_temp_weapon_switch");
  self endon("lmg_streak_ended");
  var_1 = self getweaponammoclip(var_0);
  var_2 = 0;
  var_3 = 0;

  while(var_1 > 0) {
    waitframe();
    var_1 = self getweaponammoclip(var_0);

    if(var_1 == 25 && !var_2) {
      _id_0720::_id_BEC0("deathmachine_low");
      var_2 = 1;
      continue;
    }

    if(var_1 == 0 && !var_3) {
      _id_0720::_id_BEC0("deathmachine_deplete");
      var_3 = 1;
    }
  }

  self switchtoweapon(self._id_034C);
  return 1;
}