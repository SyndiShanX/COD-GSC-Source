/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3533.gsc
*********************************************/

func_1664() {
  if(!isDefined(level.var_1668)) {
    level.var_1668 = [];
  }

  thread func_1672();
  thread func_166F();
}

func_166F() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  func_1665(self.primaryweapon);
  func_1665(self.secondaryweapon);
}

func_1667() {
  self notify("stopActiveReload");
  func_165D();
}

func_1672() {
  self endon("disconnect");
  self endon("stopActiveReload");
  level endon("game_ended");
  self notify("activeReloadWatch");
  self endon("activeReloadWatch");
  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();
    if(!isDefined(var_0) || var_0 == "none") {
      continue;
    }

    var_1 = scripts\mp\utility::getweapongroup(var_0);
    if(func_165E(var_0, var_1)) {
      thread func_1671();
      thread func_1670();
      thread func_166C();
      thread func_166D(var_0);
      var_2 = func_166B(var_0, var_1);
      if(isDefined(var_2)) {
        thread func_50DB();
      } else {
        func_1661();
      }
    }
  }
}

func_1671() {
  func_166A("weapon_switch_started");
}

func_166C() {
  func_166A("melee_fired");
}

func_166E() {
  func_166A("reload");
}

func_1670() {
  func_166A("sprint_begin");
}

func_166D(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("reload_start");
  wait(0.333);
  if(!isai(self)) {
    self notifyonplayercommand("activeReloadInput", "+usereload");
    self notifyonplayercommand("activeReloadInput", "+activate");
  }

  func_166A("activeReloadInput");
}

func_166A(var_0) {
  self endon("disconnect");
  self endon("stopActiveReload");
  level endon("game_ended");
  self endon("activeReloadEvent");
  self waittill(var_0);
  self notify("activeReloadEvent");
}

func_166B(var_0, var_1) {
  self endon("disconnect");
  self endon("stopActiveReload");
  level endon("game_ended");
  self.var_165F = gettime();
  var_2 = func_1662(var_0, var_1);
  var_3 = var_2["totalTime"];
  var_4 = var_2["hotzoneStart"];
  var_5 = var_2["hotzoneDuration"];
  thread func_1669(var_3, var_4, var_5);
  scripts\engine\utility::waittill_any_timeout(var_2["totalTime"] * 0.001, "activeReloadEvent");
  self notify("activeReloadEvent");
  var_6 = gettime() - self.var_165F;
  if(var_6 < var_4 - 0) {
    self setclientomnvar("ui_activereload_result", -1);
    self setclientomnvar("ui_activereload_result_notify", gettime());
    return 1;
  }

  if(var_6 < var_3) {
    if(var_6 <= var_4 + var_5 + 0) {
      thread func_165B();
    } else {
      self setclientomnvar("ui_activereload_result", 0);
      self setclientomnvar("ui_activereload_result_notify", gettime());
    }

    return 1;
  }
}

func_165C() {
  if(!isDefined(self.var_1666) || self.var_1666 == 0) {
    scripts\mp\utility::giveperk("specialty_regenfaster");
    self.var_1666 = 1;
  }
}

func_165D() {
  if(isDefined(self.var_1666) && self.var_1666) {
    scripts\mp\utility::removeperk("specialty_regenfaster");
    self.var_1666 = undefined;
  }
}

func_165B() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self notify("activeReloadGivePerk");
  self endon("activeReloadGivePerk");
  self playlocalsound("scavenger_pack_pickup");
  func_165C();
  scripts\mp\powers::power_modifycooldownrate(2);
  self setclientomnvar("ui_activereload_result", 1);
  self setclientomnvar("ui_activereload_result_notify", gettime());
  wait(5);
  func_165D();
  scripts\mp\powers::power_modifycooldownrate(1);
}

func_1661() {
  if(!isai(self)) {
    self notifyonplayercommand("", "+usereload");
    self notifyonplayercommand("", "+activate");
  }

  self setclientomnvar("ui_activereload_visible", 0);
}

func_50DB() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("reload_start");
  wait(0.5);
  func_1661();
}

func_1660(var_0, var_1, var_2, var_3) {
  var_4 = gettime() - var_0;
  if(var_4 >= var_1 && var_4 < var_2) {
    return 1;
  }

  return 0;
}

func_165E(var_0, var_1) {
  if(var_1 == "weapon_shotgun") {
    var_2 = scripts\mp\utility::getweaponrootname(var_0);
    return var_2 != "iw6_fp6" && var_2 != "iw6_uts15" && var_2 != "iw7_spas";
  }

  if(scripts\mp\utility::weaponhasattachment(var_1, "akimbo")) {
    return 0;
  }

  if(scripts\mp\utility::isstrstart(var_1, "alt_")) {
    return 0;
  }

  if(scripts\mp\weapons::isknifeonly(var_1) || scripts\mp\weapons::isriotshield(var_1)) {
    return 0;
  }

  return 1;
}

func_1662(var_0, var_1) {
  var_2 = 1;
  if(scripts\mp\utility::_hasperk("specialty_fastreload")) {
    var_2 = 0.5;
  }

  var_3 = undefined;
  if(scripts\mp\utility::isstrstart(var_0, "alt_")) {
    if(scripts\mp\utility::weaponhasattachment(var_0, "gl")) {
      var_3 = func_1665("gl", 1);
    } else if(scripts\mp\utility::weaponhasattachment(var_0, "shotgun")) {
      var_3 = func_1665("shotgun", 1);
    }
  } else {
    var_3 = func_1665(var_0);
  }

  var_4 = 2;
  var_5 = self getweaponammoclip(var_0);
  if(var_5 == 0) {
    var_4 = 4;
  }

  var_6 = [];
  var_7 = var_3[var_4] * var_2;
  var_8 = var_3[var_4 + -1] * var_2;
  var_6["totalTime"] = int(var_7);
  var_6["hotzoneStart"] = int(var_8);
  var_6["hotzoneDuration"] = 250;
  return var_6;
}

func_1669(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("stopActiveReload");
  level endon("game_ended");
  self endon("activeReloadCanceled");
  self setclientomnvar("ui_activereload_hotzone_start", var_1);
  self setclientomnvar("ui_activereload_hotzone_duration", var_2);
  self setclientomnvar("ui_activereload_total_time", var_0);
  self setclientomnvar("ui_activereload_visible", 1);
  wait(var_0);
  self setclientomnvar("ui_activereload_result", 0);
  self setclientomnvar("ui_activereload_result_notify", gettime());
}

func_1665(var_0) {
  if(var_0 == "none") {
    return;
  }

  var_1 = getweaponbasename(var_0);
  if(isDefined(level.var_1668[var_1])) {
    return level.var_1668[var_1];
  }

  if(!scripts\mp\weapons::isknifeonly(var_1) && !scripts\mp\weapons::isriotshield(var_1)) {
    var_2 = [];
    var_3 = tablelookuprownum("mp\weaponReloadStats.csv", 0, var_1);
    var_4 = 4;
    var_5 = scripts\mp\utility::getweapongroup(var_1);
    if(var_5 == "weapon_pistol") {
      var_4 = 8;
    }

    for(var_6 = 1; var_6 <= var_4; var_6++) {
      var_2[var_6] = int(float(tablelookupbyrow("mp\weaponReloadStats.csv", var_3, var_6)) * 1000);
    }

    level.var_1668[var_1] = var_2;
    return var_2;
  }
}