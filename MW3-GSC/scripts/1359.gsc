/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1359.gsc
**************************************/

_id_40AB(var_0, var_1, var_2, var_3) {
  level.weaponinfo[var_0]["type"] = var_2;
  level.weaponinfo[var_0]["clip"] = var_3;
  level.weaponinfo[var_0]["string"] = var_1;
  precachestring(var_1);
}

_id_40AC(var_0) {
  if(!isDefined(level.weaponinfo[var_0])) {
    return 0;

  }
  return 1;
}

_id_40AD(var_0) {
  return level.weaponinfo[var_0]["type"];
}

_id_40AE(var_0) {
  return level.weaponinfo[var_0]["clip"];
}

_id_40AF(var_0) {
  return level.weaponinfo[var_0]["string"];
}

init() {
  precacheshader("hud_bullets_rifle");
  precacheshader("hud_bullets_pistol");
  precacheshader("hud_bullets_sniper");
  precacheshader("hud_bullets_spread");
  precacheshader("hud_bullets_support_front");
  precacheshader("hud_bullets_support_back");
  level._id_40B0 = [];
  level._id_40B0[level._id_40B0.size] = 1.0;
  level._id_40B0[level._id_40B0.size] = 0.996;
  level._id_40B0[level._id_40B0.size] = 0.949;
  level._id_40B0[level._id_40B0.size] = 0.909;
  level._id_40B0[level._id_40B0.size] = 0.87;
  level._id_40B0[level._id_40B0.size] = 0.835;
  level._id_40B0[level._id_40B0.size] = 0.803;
  level._id_40B0[level._id_40B0.size] = 0.776;
  level._id_40B0[level._id_40B0.size] = 0.749;
  level._id_40B0[level._id_40B0.size] = 0.721;
  level._id_40B0[level._id_40B0.size] = 0.698;
  level._id_40B0[level._id_40B0.size] = 0.674;
  level._id_40B0[level._id_40B0.size] = 0.654;
  level._id_40B0[level._id_40B0.size] = 0.635;
  level._id_40B0[level._id_40B0.size] = 0.615;
  level._id_40B0[level._id_40B0.size] = 0.596;
  level._id_40B0[level._id_40B0.size] = 0.58;
  level._id_40B0[level._id_40B0.size] = 0.564;
  level._id_40B0[level._id_40B0.size] = 0.549;
  level._id_40B0[level._id_40B0.size] = 0.537;
  level._id_40B0[level._id_40B0.size] = 0.521;
  level._id_40B0[level._id_40B0.size] = 0.509;
  level._id_40B0[level._id_40B0.size] = 0.498;
  level.weaponinfo = [];
  _id_40AB("ak47", &"WEAPON_AK47_FULLAUTO", "rifle", 30);
  _id_40AB("ak47_semi", &"WEAPON_AK47_SEMIAUTO", "rifle", 30);
  _id_40AB("ak47_grenadier", &"WEAPON_AK47", "rifle", 30);
  _id_40AB("ak74u", &"WEAPON_AK74U_FULLAUTO", "rifle", 30);
  _id_40AB("ak74u_semi", &"WEAPON_AK74U_SEMIAUTO", "rifle", 30);
  _id_40AB("beretta", &"WEAPON_BERETTA", "pistol", 15);
  _id_40AB("g36c", &"WEAPON_G36C", "rifle", 30);
  _id_40AB("m14_scoped", &"WEAPON_M14", "sniper", 10);
  _id_40AB("m16_basic", &"WEAPON_M16A4_FULLAUTO", "rifle", 30);
  _id_40AB("m16_basic_semi", &"WEAPON_M16A4_SEMIAUTO", "rifle", 30);
  _id_40AB("m16_grenadier", &"WEAPON_M16", "rifle", 30);
  _id_40AB("m203", &"WEAPON_M203", "grenade", 1);
  _id_40AB("rpg", &"WEAPON_RPG", "grenade", 5);
  _id_40AB("saw", &"WEAPON_SAW", "support", 100);
  _id_40AB("m4_grunt", &"WEAPON_M4_FULLAUTO", "rifle", 30);
  _id_40AB("m4_grunt_semi", &"WEAPON_M4_SEMIAUTO", "rifle", 30);
  _id_40AB("m4_grenadier", &"WEAPON_M4", "rifle", 30);
  _id_40AB("m40a3", &"WEAPON_M40A3", "sniper", 10);
  _id_40AB("mp5", &"WEAPON_MP5", "smg", 30);
  _id_40AB("mp5_silencer", &"WEAPON_MP5SD", "smg", 30);
  _id_40AB("usp", &"WEAPON_USP", "pistol", 10);
  _id_40AB("at4", &"WEAPON_AT4", "rocketlauncher", 1);
  _id_40AB("dragunov", &"WEAPON_DRAGUNOV", "sniper", 10);
  _id_40AB("g3", &"WEAPON_G3", "rifle", 30);
  _id_40AB("winchester1200", &"WEAPON_WINCHESTER1200", "shotgun", 4);
  _id_40AB("uzi", &"WEAPON_UZI", "smg", 32);
  level.player _id_40B1();
}

_id_40B1() {
  if(!isDefined(self._id_40B2)) {
    self._id_40B2 = [];

  }
  if(!isDefined(self._id_40B2[0])) {
    self._id_40B2[0] = maps\_hud_util::createicon(undefined, 24, 96);
    self._id_40B2[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
    self._id_40B2[0].sort = 10;
  }

  if(!isDefined(self._id_40B2[1])) {
    self._id_40B2[1] = maps\_hud_util::createicon(undefined, 24, 96);
    self._id_40B2[1] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
    self._id_40B2[1].color = (0.7, 0.7, 0.7);
    self._id_40B2[1].sort = 9;
  }

  if(!isDefined(self._id_40B2[2])) {
    self._id_40B2[2] = maps\_hud_util::createicon(undefined, 24, 96);
    self._id_40B2[2] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
    self._id_40B2[2].sort = 10;
  }

  if(!isDefined(self._id_40B2[3])) {
    self._id_40B2[3] = maps\_hud_util::createicon(undefined, 24, 96);
    self._id_40B2[3] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
    self._id_40B2[3].color = (0.7, 0.7, 0.7);
    self._id_40B2[3].sort = 9;
  }

  if(!isDefined(self._id_40B2[4])) {
    self._id_40B2[4] = maps\_hud_util::createicon(undefined, 24, 96);
    self._id_40B2[4] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
    self._id_40B2[4].sort = 10;
  }

  thread _id_40B3();
}

_id_40B3() {
  self endon("death");
  var_0 = -1;
  var_1 = "";
  var_2 = "";

  for(;;) {
    var_3 = self getcurrentweapon();

    if(_id_40AC(var_3)) {
      var_4 = _id_40AD(var_3);
      var_5 = self getweaponammoclip(self getcurrentweapon());

      if(var_3 != var_1 && var_4 != var_2) {
        _id_40B4(var_4);
        var_1 = var_3;
        var_2 = var_4;
        var_0 = -1;
      }

      if(var_5 != var_0) {
        _id_40B6(var_3, var_5);
        var_0 = var_5;
      }
    }

    wait 0.05;
  }
}

_id_40B4(var_0) {
  self.pers["weaponType"] = var_0;

  if(!isDefined(self._id_40B2)) {
    return;
  }
  for(var_1 = 0; var_1 < self._id_40B2.size; var_1++) {
    self._id_40B2[var_1].alpha = 0;

  }
  switch (var_0) {
    case "pistol":
      self._id_40B2[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
      self._id_40B2[0] maps\_hud_util::seticonshader("hud_bullets_pistol");
      self._id_40B2[0].alpha = 1;
      break;
    case "smg":
      self._id_40B2[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
      self._id_40B2[0] maps\_hud_util::seticonshader("hud_bullets_rifle");
      self._id_40B2[1] maps\_hud_util::seticonshader("hud_bullets_rifle");
      self._id_40B2[1] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -4, -50);
      self._id_40B2[0].alpha = 1;
      self._id_40B2[1].alpha = 1;
      break;
    case "rifle":
      self._id_40B2[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
      self._id_40B2[0] maps\_hud_util::seticonshader("hud_bullets_rifle");
      self._id_40B2[1] maps\_hud_util::seticonshader("hud_bullets_rifle");
      self._id_40B2[1] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -4, -50);
      self._id_40B2[0].alpha = 1;
      self._id_40B2[1].alpha = 1;
      break;
    case "sniper":
      self._id_40B2[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
      self._id_40B2[0] maps\_hud_util::seticonshader("hud_bullets_sniper");
      self._id_40B2[0].alpha = 1;
      break;
    case "spread":
      self._id_40B2[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
      self._id_40B2[0] maps\_hud_util::seticonshader("hud_bullets_spread");
      self._id_40B2[0].alpha = 1;
      break;
    case "support":
      var_2 = 0;

      for(var_1 = 0; var_1 < 5; var_1++) {
        self._id_40B2[var_1] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6 + var_2, -70);
        self._id_40B2[var_1].alpha = 1;

        if(var_1 % 2) {
          self._id_40B2[var_1] maps\_hud_util::seticonshader("hud_bullets_support_back");
        } else {
          self._id_40B2[var_1] maps\_hud_util::seticonshader("hud_bullets_support_front");

        }
        var_2 = var_2 - 14;
      }

      break;
  }
}

_id_40B5() {
  return self.pers["weaponType"];
}

_id_40B6(var_0, var_1) {
  if(!isDefined(self._id_40B2)) {
    return;
  }
  switch (_id_40B5()) {
    case "pistol":
      var_2 = 15 - _id_40AE(var_0);
      var_3 = _id_40AE(var_0) - var_1;
      self._id_40B2[0].alpha = level._id_40B0[var_2 + var_3];
      break;
    case "rifle":
      var_3 = _id_40AE(var_0) - var_1;
      var_4 = int(var_3 / 2);
      var_4 = var_4 + var_3 % 2;
      var_5 = int(var_3 / 2);
      self._id_40B2[0].alpha = level._id_40B0[var_4];
      self._id_40B2[1].alpha = level._id_40B0[var_5];
      break;
    case "smg":
      var_3 = _id_40AE(var_0) - var_1;
      var_4 = int(var_3 / 2);
      var_4 = var_4 + var_3 % 2;
      var_5 = int(var_3 / 2);
      self._id_40B2[0].alpha = level._id_40B0[var_4];
      self._id_40B2[1].alpha = level._id_40B0[var_5];
      break;
    case "sniper":
      var_2 = 15 - _id_40AE(var_0);
      var_3 = _id_40AE(var_0) - var_1;
      self._id_40B2[0].alpha = level._id_40B0[var_2 + var_3];
      break;
    case "spread":
      var_2 = 15 - _id_40AE(var_0);
      var_3 = _id_40AE(var_0) - var_1;
      self._id_40B2[0].alpha = level._id_40B0[var_2 + var_3];
      break;
    case "support":
      var_2 = 100 - _id_40AE(var_0);
      var_3 = _id_40AE(var_0) - var_1;
      var_3 = var_2 + var_3;
      var_6 = 20;

      for(var_7 = 4; var_7 >= 0; var_7--) {
        if(var_3 > var_6) {
          self._id_40B2[var_7].alpha = 0;
        } else if(var_6 - var_3 <= 20) {
          self._id_40B2[var_7].alpha = level._id_40B0[var_3 - (var_6 - 20)];
        } else {
          self._id_40B2[var_7].alpha = 1;

        }
        var_6 = var_6 + 20;
      }

      break;
  }
}