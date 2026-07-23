/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1359.gsc
**************************************/

registerweaponinfo(var_0, var_1, var_2, var_3) {
  level.weaponinfo[var_0]["type"] = var_2;
  level.weaponinfo[var_0]["clip"] = var_3;
  level.weaponinfo[var_0]["string"] = var_1;
  precachestring(var_1);
}

isweaponregistered(var_0) {
  if(!isDefined(level.weaponinfo[var_0])) {
    return 0;
  }
  return 1;
}

getweaponinfotype(var_0) {
  return level.weaponinfo[var_0]["type"];
}

getweaponinfoclip(var_0) {
  return level.weaponinfo[var_0]["clip"];
}

getweaponinfostring(var_0) {
  return level.weaponinfo[var_0]["string"];
}

init() {
  precacheshader("hud_bullets_rifle");
  precacheshader("hud_bullets_pistol");
  precacheshader("hud_bullets_sniper");
  precacheshader("hud_bullets_spread");
  precacheshader("hud_bullets_support_front");
  precacheshader("hud_bullets_support_back");
  level.bulletalphas = [];
  level.bulletalphas[level.bulletalphas.size] = 1.0;
  level.bulletalphas[level.bulletalphas.size] = 0.996;
  level.bulletalphas[level.bulletalphas.size] = 0.949;
  level.bulletalphas[level.bulletalphas.size] = 0.909;
  level.bulletalphas[level.bulletalphas.size] = 0.87;
  level.bulletalphas[level.bulletalphas.size] = 0.835;
  level.bulletalphas[level.bulletalphas.size] = 0.803;
  level.bulletalphas[level.bulletalphas.size] = 0.776;
  level.bulletalphas[level.bulletalphas.size] = 0.749;
  level.bulletalphas[level.bulletalphas.size] = 0.721;
  level.bulletalphas[level.bulletalphas.size] = 0.698;
  level.bulletalphas[level.bulletalphas.size] = 0.674;
  level.bulletalphas[level.bulletalphas.size] = 0.654;
  level.bulletalphas[level.bulletalphas.size] = 0.635;
  level.bulletalphas[level.bulletalphas.size] = 0.615;
  level.bulletalphas[level.bulletalphas.size] = 0.596;
  level.bulletalphas[level.bulletalphas.size] = 0.58;
  level.bulletalphas[level.bulletalphas.size] = 0.564;
  level.bulletalphas[level.bulletalphas.size] = 0.549;
  level.bulletalphas[level.bulletalphas.size] = 0.537;
  level.bulletalphas[level.bulletalphas.size] = 0.521;
  level.bulletalphas[level.bulletalphas.size] = 0.509;
  level.bulletalphas[level.bulletalphas.size] = 0.498;
  level.weaponinfo = [];
  registerweaponinfo("ak47", &"WEAPON_AK47_FULLAUTO", "rifle", 30);
  registerweaponinfo("ak47_semi", &"WEAPON_AK47_SEMIAUTO", "rifle", 30);
  registerweaponinfo("ak47_grenadier", &"WEAPON_AK47", "rifle", 30);
  registerweaponinfo("ak74u", &"WEAPON_AK74U_FULLAUTO", "rifle", 30);
  registerweaponinfo("ak74u_semi", &"WEAPON_AK74U_SEMIAUTO", "rifle", 30);
  registerweaponinfo("beretta", &"WEAPON_BERETTA", "pistol", 15);
  registerweaponinfo("g36c", &"WEAPON_G36C", "rifle", 30);
  registerweaponinfo("m14_scoped", &"WEAPON_M14", "sniper", 10);
  registerweaponinfo("m16_basic", &"WEAPON_M16A4_FULLAUTO", "rifle", 30);
  registerweaponinfo("m16_basic_semi", &"WEAPON_M16A4_SEMIAUTO", "rifle", 30);
  registerweaponinfo("m16_grenadier", &"WEAPON_M16", "rifle", 30);
  registerweaponinfo("m203", &"WEAPON_M203", "grenade", 1);
  registerweaponinfo("rpg", &"WEAPON_RPG", "grenade", 5);
  registerweaponinfo("saw", &"WEAPON_SAW", "support", 100);
  registerweaponinfo("m4_grunt", &"WEAPON_M4_FULLAUTO", "rifle", 30);
  registerweaponinfo("m4_grunt_semi", &"WEAPON_M4_SEMIAUTO", "rifle", 30);
  registerweaponinfo("m4_grenadier", &"WEAPON_M4", "rifle", 30);
  registerweaponinfo("m40a3", &"WEAPON_M40A3", "sniper", 10);
  registerweaponinfo("mp5", &"WEAPON_MP5", "smg", 30);
  registerweaponinfo("mp5_silencer", &"WEAPON_MP5SD", "smg", 30);
  registerweaponinfo("usp", &"WEAPON_USP", "pistol", 10);
  registerweaponinfo("at4", &"WEAPON_AT4", "rocketlauncher", 1);
  registerweaponinfo("dragunov", &"WEAPON_DRAGUNOV", "sniper", 10);
  registerweaponinfo("g3", &"WEAPON_G3", "rifle", 30);
  registerweaponinfo("winchester1200", &"WEAPON_WINCHESTER1200", "shotgun", 4);
  registerweaponinfo("uzi", &"WEAPON_UZI", "smg", 32);
  level.player initweaponhud();
}

initweaponhud() {
  if(!isDefined(self.hud_bullets)) {
    self.hud_bullets = [];
  }
  if(!isDefined(self.hud_bullets[0])) {
    self.hud_bullets[0] = maps\_hud_util::createicon(undefined, 24, 96);
    self.hud_bullets[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
    self.hud_bullets[0].sort = 10;
  }

  if(!isDefined(self.hud_bullets[1])) {
    self.hud_bullets[1] = maps\_hud_util::createicon(undefined, 24, 96);
    self.hud_bullets[1] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
    self.hud_bullets[1].color = (0.7, 0.7, 0.7);
    self.hud_bullets[1].sort = 9;
  }

  if(!isDefined(self.hud_bullets[2])) {
    self.hud_bullets[2] = maps\_hud_util::createicon(undefined, 24, 96);
    self.hud_bullets[2] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
    self.hud_bullets[2].sort = 10;
  }

  if(!isDefined(self.hud_bullets[3])) {
    self.hud_bullets[3] = maps\_hud_util::createicon(undefined, 24, 96);
    self.hud_bullets[3] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
    self.hud_bullets[3].color = (0.7, 0.7, 0.7);
    self.hud_bullets[3].sort = 9;
  }

  if(!isDefined(self.hud_bullets[4])) {
    self.hud_bullets[4] = maps\_hud_util::createicon(undefined, 24, 96);
    self.hud_bullets[4] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
    self.hud_bullets[4].sort = 10;
  }

  thread updatebullethudthink();
}

updatebullethudthink() {
  self endon("death");
  var_0 = -1;
  var_1 = "";
  var_2 = "";

  for(;;) {
    var_3 = self getcurrentweapon();

    if(isweaponregistered(var_3)) {
      var_4 = getweaponinfotype(var_3);
      var_5 = self getweaponammoclip(self getcurrentweapon());

      if(var_3 != var_1 && var_4 != var_2) {
        sethudweapontype(var_4);
        var_1 = var_3;
        var_2 = var_4;
        var_0 = -1;
      }

      if(var_5 != var_0) {
        updatehudweaponammo(var_3, var_5);
        var_0 = var_5;
      }
    }

    wait 0.05;
  }
}

sethudweapontype(var_0) {
  self.pers["weaponType"] = var_0;

  if(!isDefined(self.hud_bullets)) {
    return;
  }
  for(var_1 = 0; var_1 < self.hud_bullets.size; var_1++) {
    self.hud_bullets[var_1].alpha = 0;
  }
  switch (var_0) {
    case "pistol":
      self.hud_bullets[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
      self.hud_bullets[0] maps\_hud_util::seticonshader("hud_bullets_pistol");
      self.hud_bullets[0].alpha = 1;
      break;
    case "smg":
      self.hud_bullets[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
      self.hud_bullets[0] maps\_hud_util::seticonshader("hud_bullets_rifle");
      self.hud_bullets[1] maps\_hud_util::seticonshader("hud_bullets_rifle");
      self.hud_bullets[1] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -4, -50);
      self.hud_bullets[0].alpha = 1;
      self.hud_bullets[1].alpha = 1;
      break;
    case "rifle":
      self.hud_bullets[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
      self.hud_bullets[0] maps\_hud_util::seticonshader("hud_bullets_rifle");
      self.hud_bullets[1] maps\_hud_util::seticonshader("hud_bullets_rifle");
      self.hud_bullets[1] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -4, -50);
      self.hud_bullets[0].alpha = 1;
      self.hud_bullets[1].alpha = 1;
      break;
    case "sniper":
      self.hud_bullets[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
      self.hud_bullets[0] maps\_hud_util::seticonshader("hud_bullets_sniper");
      self.hud_bullets[0].alpha = 1;
      break;
    case "spread":
      self.hud_bullets[0] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6, -47);
      self.hud_bullets[0] maps\_hud_util::seticonshader("hud_bullets_spread");
      self.hud_bullets[0].alpha = 1;
      break;
    case "support":
      var_2 = 0;

      for(var_1 = 0; var_1 < 5; var_1++) {
        self.hud_bullets[var_1] maps\_hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -6 + var_2, -70);
        self.hud_bullets[var_1].alpha = 1;

        if(var_1 % 2) {
          self.hud_bullets[var_1] maps\_hud_util::seticonshader("hud_bullets_support_back");
        } else {
          self.hud_bullets[var_1] maps\_hud_util::seticonshader("hud_bullets_support_front");
        }
        var_2 = var_2 - 14;
      }

      break;
  }
}

gethudweapontype() {
  return self.pers["weaponType"];
}

updatehudweaponammo(var_0, var_1) {
  if(!isDefined(self.hud_bullets)) {
    return;
  }
  switch (gethudweapontype()) {
    case "pistol":
      var_2 = 15 - getweaponinfoclip(var_0);
      var_3 = getweaponinfoclip(var_0) - var_1;
      self.hud_bullets[0].alpha = level.bulletalphas[var_2 + var_3];
      break;
    case "rifle":
      var_3 = getweaponinfoclip(var_0) - var_1;
      var_4 = int(var_3 / 2);
      var_4 = var_4 + var_3 % 2;
      var_5 = int(var_3 / 2);
      self.hud_bullets[0].alpha = level.bulletalphas[var_4];
      self.hud_bullets[1].alpha = level.bulletalphas[var_5];
      break;
    case "smg":
      var_3 = getweaponinfoclip(var_0) - var_1;
      var_4 = int(var_3 / 2);
      var_4 = var_4 + var_3 % 2;
      var_5 = int(var_3 / 2);
      self.hud_bullets[0].alpha = level.bulletalphas[var_4];
      self.hud_bullets[1].alpha = level.bulletalphas[var_5];
      break;
    case "sniper":
      var_2 = 15 - getweaponinfoclip(var_0);
      var_3 = getweaponinfoclip(var_0) - var_1;
      self.hud_bullets[0].alpha = level.bulletalphas[var_2 + var_3];
      break;
    case "spread":
      var_2 = 15 - getweaponinfoclip(var_0);
      var_3 = getweaponinfoclip(var_0) - var_1;
      self.hud_bullets[0].alpha = level.bulletalphas[var_2 + var_3];
      break;
    case "support":
      var_2 = 100 - getweaponinfoclip(var_0);
      var_3 = getweaponinfoclip(var_0) - var_1;
      var_3 = var_2 + var_3;
      var_6 = 20;

      for(var_7 = 4; var_7 >= 0; var_7--) {
        if(var_3 > var_6) {
          self.hud_bullets[var_7].alpha = 0;
        } else if(var_6 - var_3 <= 20) {
          self.hud_bullets[var_7].alpha = level.bulletalphas[var_3 - (var_6 - 20)];
        } else {
          self.hud_bullets[var_7].alpha = 1;
        }
        var_6 = var_6 + 20;
      }

      break;
  }
}