/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3533.gsc
************************/

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
    var_00 = self getcurrentweapon();
    if(!isDefined(var_00) || var_00 == "none") {
      continue;
    }

    var_01 = scripts\mp\utility::getweapongroup(var_00);
    if(func_165E(var_00, var_01)) {
      thread func_1671();
      thread func_1670();
      thread func_166C();
      thread func_166D(var_00);
      var_02 = func_166B(var_00, var_01);
      if(isDefined(var_02)) {
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

func_166D(param_00) {
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

func_166A(param_00) {
  self endon("disconnect");
  self endon("stopActiveReload");
  level endon("game_ended");
  self endon("activeReloadEvent");
  self waittill(param_00);
  self notify("activeReloadEvent");
}

func_166B(param_00, param_01) {
  self endon("disconnect");
  self endon("stopActiveReload");
  level endon("game_ended");
  self.var_165F = gettime();
  var_02 = func_1662(param_00, param_01);
  var_03 = var_02["totalTime"];
  var_04 = var_02["hotzoneStart"];
  var_05 = var_02["hotzoneDuration"];
  thread func_1669(var_03, var_04, var_05);
  scripts\engine\utility::waittill_any_timeout_1(var_02["totalTime"] * 0.001, "activeReloadEvent");
  self notify("activeReloadEvent");
  var_06 = gettime() - self.var_165F;
  if(var_06 < var_04 - 0) {
    self setclientomnvar("ui_activereload_result", -1);
    self setclientomnvar("ui_activereload_result_notify", gettime());
    return 1;
  }

  if(var_06 < var_03) {
    if(var_06 <= var_04 + var_05 + 0) {
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

func_1660(param_00, param_01, param_02, param_03) {
  var_04 = gettime() - param_00;
  if(var_04 >= param_01 && var_04 < param_02) {
    return 1;
  }

  return 0;
}

func_165E(param_00, param_01) {
  if(param_01 == "weapon_shotgun") {
    var_02 = scripts\mp\utility::getweaponrootname(param_00);
    return var_02 != "iw6_fp6" && var_02 != "iw6_uts15" && var_02 != "iw7_spas";
  }

  if(scripts\mp\utility::weaponhasattachment(param_01, "akimbo")) {
    return 0;
  }

  if(scripts\mp\utility::isstrstart(param_01, "alt_")) {
    return 0;
  }

  if(scripts\mp\weapons::isknifeonly(param_01) || scripts\mp\weapons::isriotshield(param_01)) {
    return 0;
  }

  return 1;
}

func_1662(param_00, param_01) {
  var_02 = 1;
  if(scripts\mp\utility::_hasperk("specialty_fastreload")) {
    var_02 = 0.5;
  }

  var_03 = undefined;
  if(scripts\mp\utility::isstrstart(param_00, "alt_")) {
    if(scripts\mp\utility::weaponhasattachment(param_00, "gl")) {
      var_03 = func_1665("gl", 1);
    } else if(scripts\mp\utility::weaponhasattachment(param_00, "shotgun")) {
      var_03 = func_1665("shotgun", 1);
    }
  } else {
    var_03 = func_1665(param_00);
  }

  var_04 = 2;
  var_05 = self getweaponammoclip(param_00);
  if(var_05 == 0) {
    var_04 = 4;
  }

  var_06 = [];
  var_07 = var_03[var_04] * var_02;
  var_08 = var_03[var_04 + -1] * var_02;
  var_06["totalTime"] = int(var_07);
  var_06["hotzoneStart"] = int(var_08);
  var_06["hotzoneDuration"] = 250;
  return var_06;
}

func_1669(param_00, param_01, param_02) {
  self endon("disconnect");
  self endon("stopActiveReload");
  level endon("game_ended");
  self endon("activeReloadCanceled");
  self setclientomnvar("ui_activereload_hotzone_start", param_01);
  self setclientomnvar("ui_activereload_hotzone_duration", param_02);
  self setclientomnvar("ui_activereload_total_time", param_00);
  self setclientomnvar("ui_activereload_visible", 1);
  wait(param_00);
  self setclientomnvar("ui_activereload_result", 0);
  self setclientomnvar("ui_activereload_result_notify", gettime());
}

func_1665(param_00) {
  if(param_00 == "none") {
    return;
  }

  var_01 = getweaponbasename(param_00);
  if(isDefined(level.var_1668[var_01])) {
    return level.var_1668[var_01];
  }

  if(!scripts\mp\weapons::isknifeonly(var_01) && !scripts\mp\weapons::isriotshield(var_01)) {
    var_02 = [];
    var_03 = tablelookuprownum("mp\weaponReloadStats.csv", 0, var_01);
    var_04 = 4;
    var_05 = scripts\mp\utility::getweapongroup(var_01);
    if(var_05 == "weapon_pistol") {
      var_04 = 8;
    }

    for(var_06 = 1; var_06 <= var_04; var_06++) {
      var_02[var_06] = int(float(tablelookupbyrow("mp\weaponReloadStats.csv", var_03, var_06)) * 1000);
    }

    level.var_1668[var_01] = var_02;
    return var_02;
  }
}