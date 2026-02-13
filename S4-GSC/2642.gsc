/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2642.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("lmg_streak", ::_id_F790, undefined);
}

_id_F790(var_0) {
  if(getdvarint("#x36878bc1069da9f0d", 1) == 0) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

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

  if(self._id_0133.basename == "s4_la_walpha2_mp") {
    self notify("non_temp_weapon_switch");
    self waittill("warmachine_ended");
  }

  var_1 = makeweapon("s4_mg_streak_mp");
  self giveweapon(var_1);
  var_2 = isDefined(self.pers["mgStreakAmmo"]);
  var_3 = scripts\engine\utility::ter_op(var_2, self.pers["mgStreakAmmo"], weaponclipsize(var_1));
  self setweaponammoclip(var_1, var_3);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_1);

  if(!var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_lmg_streak", var_0.owner);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    }
  } else if(isDefined(var_3) && var_3 <= 25) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "deathmachine_low");
    }
  }

  thread _id_07F8::killstreak_lmg_music();
  self disableweaponpickup();

  if(scripts\cp_mp\utility\killstreak_utility::shoulddisablekillstreakweaponswitch()) {
    self disableweaponswitch();
  }

  thread _id_A154(var_0, var_1);

  while(var_1 != self getcurrentweapon()) {
    if(scripts\mp\utility\game::_id_875D() && self hasweapon(var_1)) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_1);
    }

    waitframe();
  }

  self.streakinfo = var_0;
  thread _id_A151();
  thread _id_10A8C(var_1);
  return 1;
}

_id_A151() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("non_temp_weapon_switch");

  for(;;) {
    var_0 = self getcurrentweapon();
    var_1 = var_0;
    var_2 = self _meth_854D();

    while(var_0 == var_1 || var_0.basename == "none" || var_0 == var_2) {
      var_0 = self getcurrentweapon();
      waitframe();
    }

    self notify("non_temp_weapon_switch");
  }
}

_id_A154(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_2 = scripts\engine\utility::_id_10898("death", "non_temp_weapon_switch", "round_ended");

  if(scripts\cp_mp\utility\killstreak_utility::donttakekillstreakonladderuse(var_2)) {
    thread _id_A154(var_0, var_1);
    return;
  }

  if(isDefined(level._id_8DD3)) {
    level[[level._id_8DD3]](var_0);
  }

  var_3 = self getweaponammoclip(var_1);
  self.pers["mgStreakAmmo"] = ::scripts\engine\utility::ter_op(var_3 == 0, undefined, var_3);

  if(var_3 != 0) {
    scripts\mp\killstreaks\killstreaks::storekillstreak(var_0.streakname);
  }

  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);

  if(var_2 != "round_ended") {
    self enableweaponswitch();
    self enableweaponpickup();
    self takeweapon(var_1);
    self.streakinfo = undefined;
    self notify("deathmachine_ended");
  }
}

_id_10A8C(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("non_temp_weapon_switch");
  self endon("deathmachine_ended");
  var_1 = self getweaponammoclip(var_0);
  var_2 = 0;
  var_3 = 0;

  while(var_1 > 0) {
    waitframe();
    var_1 = self getweaponammoclip(var_0);

    if(var_1 == 25 && !var_2) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
        level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "deathmachine_low");
      }

      var_2 = 1;
      continue;
    }

    if(var_1 == 0 && !var_3) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
        level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "deathmachine_deplete");
      }

      var_3 = 1;
    }
  }
}