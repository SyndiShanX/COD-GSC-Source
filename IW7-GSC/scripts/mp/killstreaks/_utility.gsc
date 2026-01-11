/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_utility.gsc
***********************************************/

func_1843(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self getentitynumber();
  self.var_1653 = param_02 func_7D98();
  if(isDefined(param_00)) {
    if(scripts\mp\utility::func_9FBA(param_00)) {
      func_1863(var_05);
      thread func_E121(var_05);
    } else if(scripts\mp\utility::func_9D35(param_00)) {
      func_1844(var_05);
      thread func_E0FE(var_05);
    } else if(scripts\mp\utility::func_9E7F(param_00)) {
      addtolittlebirdlist(var_05);
      thread func_E111(var_05);
    } else if(scripts\mp\utility::func_9E2D(param_00)) {
      func_184E(var_05);
      thread func_E10A(var_05);
    } else if(scripts\mp\utility::func_9F67(param_00)) {
      func_185A(var_05);
      thread func_E118(var_05);
    } else if(scripts\mp\utility::func_9D61(param_00)) {
      func_1847(var_05);
      thread func_E102(var_05);
    } else if(scripts\mp\utility::func_9FB7(param_00)) {
      func_1862(var_05);
      thread func_E120(var_05);
    } else if(scripts\mp\utility::func_9D82(param_00)) {
      func_184A(var_05);
      thread func_E105(var_05);
    } else if(scripts\mp\utility::func_9F0F(param_00)) {
      func_1857(var_05);
      thread func_E115(var_05);
    } else {
      func_1856(var_05);
      thread removefromplayerkillstreaklistondeath(var_05);
    }

    if(scripts\mp\utility::iskillstreakaffectedbyemp(param_00)) {
      self.var_18DD = 1;
    }

    if(scripts\mp\utility::func_9E6A(param_00)) {
      self.var_18DE = 1;
    }
  }

  level.var_1655[var_05] = self;
  level.var_1655[var_05].streakname = param_00;
  if(scripts\mp\utility::istrue(param_03)) {
    var_06 = undefined;
    var_07 = undefined;
    if(level.teambased) {
      if(scripts\mp\utility::func_9F2C(param_00)) {
        foreach(var_09 in level.players) {
          if(var_09.team == self.team && var_09 != self.triggerportableradarping) {
            var_06 = scripts\mp\utility::outlineenableforplayer(self, "cyan", var_09, 0, 0, "lowest");
          }

          if(isDefined(var_06)) {
            thread func_E14B(var_06, param_04);
          }
        }

        var_07 = 1;
      } else {
        var_06 = scripts\mp\utility::outlineenableforteam(self, "cyan", param_02.team, 0, 0, "lowest");
      }
    } else {
      var_06 = scripts\mp\utility::outlineenableforplayer(self, "cyan", param_02, 0, 0, "lowest");
    }

    if(!scripts\mp\utility::istrue(var_07)) {
      thread func_E14B(var_06, param_04);
    }
  }

  if(isDefined(param_01) && param_01 != "") {
    var_0B = getkillstreaknomeleetarget(param_00);
    scripts\mp\sentientpoolmanager::registersentient(param_01, param_02, var_0B, param_04);
  }

  thread scripts\mp\missions::func_A691(param_00);
}

func_7D98() {
  if(!isDefined(self.pers["nextActiveID"])) {
    self.pers["nextActiveID"] = 0;
  }

  var_00 = self.pers["nextActiveID"];
  self.pers["nextActiveID"]++;
  return var_00;
}

func_E14B(param_00, param_01) {
  var_02 = ["death", "carried"];
  if(isDefined(param_01)) {
    var_02 = [param_01];
  }

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_02);
  scripts\mp\utility::outlinedisable(param_00, self);
}

func_E0FD(param_00) {
  level.var_1655[param_00] = undefined;
}

func_1654(param_00) {
  return isDefined(level.var_1655[param_00]);
}

func_1863(param_00) {
  if(!isDefined(level.uavmodels)) {
    level.uavmodels = [];
  }

  if(level.teambased) {
    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
    return;
  }

  level.uavmodels[self.triggerportableradarping.guid + "_" + gettime()] = self;
}

func_115CF(param_00) {
  if(isDefined(level.uavmodels[level.otherteam[param_00]]) && level.uavmodels[level.otherteam[param_00]].size > 0) {
    foreach(var_02 in level.uavmodels[level.otherteam[param_00]]) {
      if(!isDefined(var_02)) {
        continue;
      }

      if(var_02.uavtype == "counter_uav") {
        return 0;
      }
    }
  }

  if(isDefined(level.uavmodels[param_00]) && level.uavmodels[param_00].size > 0) {
    foreach(var_02 in level.uavmodels[param_00]) {
      if(!isDefined(var_02)) {
        continue;
      }

      if(var_02.uavtype == "uav" || var_02.uavtype == "directional_uav") {
        return 1;
      }
    }
  }

  return 0;
}

func_12F51() {
  var_00 = [];
  var_00["allies"] = func_115CF("allies");
  var_00["axis"] = func_115CF("axis");
  foreach(var_02 in level.players) {
    if(!isDefined(var_02.team) || var_02.team == "spectator") {
      var_02 setclientomnvar("ui_show_hardcore_minimap", 0);
      continue;
    }

    var_02 setclientomnvar("ui_show_hardcore_minimap", var_00[var_02.team]);
  }
}

func_E121(param_00) {
  self waittill("death");
  if(isDefined(self.var_12AF5)) {
    self.var_12AF5 delete();
  }

  if(level.teambased) {
    var_01 = self.team;
    level.uavmodels[var_01] = ::scripts\engine\utility::array_removeundefined(level.uavmodels[var_01]);
  } else {
    level.uavmodels = scripts\engine\utility::array_removeundefined(level.uavmodels);
  }

  if(isDefined(self)) {
    self delete();
  }

  func_E0FD(param_00);
}

func_9FB9(param_00) {
  if(!isDefined(level.uavmodels)) {
    return 0;
  }

  if(!isDefined(level.uavmodels[param_00])) {
    return 0;
  }

  return level.uavmodels[param_00].size > 0;
}

func_1844(param_00) {
  if(!isDefined(level.var_1AFC)) {
    level.var_1AFC = [];
  }

  level.var_1AFC[param_00] = self;
}

func_E0FE(param_00) {
  self waittill("death");
  level.var_1AFC[param_00] = undefined;
  func_E0FD(param_00);
}

addtolittlebirdlist(param_00) {
  if(!isDefined(level.littlebirds)) {
    level.littlebirds = [];
  }

  level.littlebirds[param_00] = self;
}

func_E111(param_00) {
  self waittill("death");
  level.littlebirds[param_00] = undefined;
  func_E0FD(param_00);
}

func_184E(param_00) {
  if(!isDefined(level.helis)) {
    level.helis = [];
  }

  level.helis[param_00] = self;
}

func_E10A(param_00) {
  self waittill("death");
  level.helis[param_00] = undefined;
  func_E0FD(param_00);
}

func_185A(param_00) {
  if(!isDefined(level.var_105EA)) {
    level.var_105EA = [];
  }

  level.var_105EA[param_00] = self;
}

func_E118(param_00) {
  self waittill("death");
  level.var_105EA[param_00] = undefined;
  func_E0FD(param_00);
}

func_1847(param_00) {
  if(!isDefined(level.balldrones)) {
    level.balldrones = [];
  }

  level.balldrones[param_00] = self;
}

func_E102(param_00) {
  self waittill("death");
  level.balldrones[param_00] = undefined;
  func_E0FD(param_00);
}

func_1862(param_00) {
  if(!isDefined(level.turrets)) {
    level.turrets = [];
  }

  level.turrets[param_00] = self;
}

func_E120(param_00) {
  scripts\engine\utility::waittill_any_3("death", "carried");
  level.turrets[param_00] = undefined;
  func_E0FD(param_00);
}

func_184A(param_00) {
  if(!isDefined(level.var_5228)) {
    level.var_5228 = [];
  }

  level.var_5228[param_00] = self;
}

func_E105(param_00) {
  scripts\engine\utility::waittill_any_3("death", "carried");
  level.var_5228[param_00] = undefined;
  func_E0FD(param_00);
}

func_1857(param_00) {
  if(!isDefined(level.var_DA61)) {
    level.var_DA61 = [];
  }

  level.var_DA61[param_00] = self;
}

func_E115(param_00) {
  self waittill("death");
  level.var_DA61[param_00] = undefined;
  func_E0FD(param_00);
}

func_1856(param_00) {
  if(!isDefined(level.var_D3CC)) {
    level.var_D3CC = [];
  }

  level.var_D3CC[param_00] = self;
}

removefromplayerkillstreaklistondeath(param_00) {
  self waittill("death");
  level.var_D3CC[param_00] = undefined;
  func_E0FD(param_00);
}

func_F774(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self makeusable();
  self setcursorhint("HINT_NOICON");
  self _meth_84A9("show");
  self sethintstring(param_01);
  self _meth_84A6(param_02);
  self setusefov(param_03);
  self _meth_84A4(param_04);
  self setuserange(param_05);
  self setusepriority(param_06);
  level thread func_20D8(self);
  foreach(var_08 in level.players) {
    if(var_08 == param_00) {
      self enableplayeruse(var_08);
      continue;
    }

    self disableplayeruse(var_08);
  }
}

func_20D8(param_00) {
  param_00 endon("death");
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_01);
    param_00 disableplayeruse(var_01);
  }
}

func_20CF(param_00, param_01) {
  var_02 = self.team;
  var_03 = self.triggerportableradarping;
  var_04 = undefined;
  var_05 = undefined;
  if(!scripts\mp\utility::isreallyalive(param_00) || param_00.team == "spectator") {
    return;
  }

  if(param_00 == var_03) {
    var_04 = "cyan";
  } else if(param_00 != var_03) {
    if((level.teambased && param_00.team != var_02) || !level.teambased) {
      var_04 = "orange";
      var_05 = 1;
    } else {
      return;
    }
  }

  if(isDefined(var_04)) {
    if(scripts\mp\utility::istrue(var_05)) {
      if(param_00 scripts\mp\utility::_hasperk("specialty_noplayertarget")) {
        return;
      }
    }

    var_06 = scripts\mp\utility::outlineenableforplayer(param_00, var_04, self.triggerportableradarping, 1, 1, "killstreak");
    thread func_13ADD(var_06, param_00, param_01);
    thread func_13ADE(var_06, param_00, param_01);
  }
}

func_13ADD(param_00, param_01, param_02) {
  param_01 endon("disconnect");
  param_01 endon("death");
  level endon("game_ended");
  self waittill(param_02);
  scripts\mp\utility::outlinedisable(param_00, param_01);
}

func_13ADE(param_00, param_01, param_02) {
  self endon(param_02);
  level endon("game_ended");
  param_01 scripts\engine\utility::waittill_any_3("death", "disconnect");
  scripts\mp\utility::outlinedisable(param_00, param_01);
}

getmodifiedantikillstreakdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  param_03 = scripts\mp\damage::handleshotgundamage(param_01, param_02, param_03);
  param_03 = scripts\mp\damage::handleapdamage(param_01, param_02, param_03, param_00);
  var_09 = scripts\mp\weapons::isaltmodeweapon(param_01);
  var_0A = 0;
  if(scripts\mp\utility::istrue(var_09)) {
    var_0B = scripts\mp\utility::getweaponattachmentsbasenames(param_01);
    foreach(var_0D in var_0B) {
      if(var_0D == "gl") {
        var_0A = 1;
        break;
      }
    }
  }

  var_0F = undefined;
  var_10 = scripts\mp\utility::getweaponbasedsmokegrenadecount(param_01);
  if(param_02 != "MOD_MELEE") {
    switch (var_10) {
      case "iw7_lockon_mp":
      case "kineticpulse_emp_mp":
      case "super_trophy_mp":
        self.largeprojectiledamage = 1;
        var_0F = param_05;
        break;

      case "iw7_venomx_mp":
      case "iw7_glprox_mp":
      case "switch_blade_child_mp":
      case "iw7_chargeshot_mp":
      case "thorproj_tracking_mp":
      case "thorproj_zoomed_mp":
      case "drone_hive_projectile_mp":
      case "emp_grenade_mp":
        self.largeprojectiledamage = 1;
        var_0F = param_06;
        break;

      case "iw7_tacburst_mpl":
      case "iw7_tacburst_mp":
        if(scripts\mp\utility::istrue(var_0A)) {
          self.largeprojectiledamage = 1;
          var_0F = param_06;
        }
        break;

      case "sentry_shock_missile_mp":
      case "jackal_cannon_mp":
      case "shockproj_mp":
      case "artillery_mp":
      case "bombproj_mp":
      case "iw7_chargeshot_c8_mp":
      case "power_exploding_drone_mp":
      case "wristrocket_mp":
      case "c4_mp":
        self.largeprojectiledamage = 0;
        var_0F = param_07;
        break;

      case "iw7_mp28_mpl":
      case "iw7_arclassic_mp":
        if(scripts\mp\utility::istrue(var_0A)) {
          self.largeprojectiledamage = 0;
          var_0F = param_07;
        }
        break;
    }
  } else if(param_02 == "MOD_MELEE") {
    switch (var_10) {
      case "iw7_minigun_c8_mp":
      case "iw7_chargeshot_c8_mp":
      case "iw7_c8offhandshield_mp":
        param_03 = 350;
        break;
    }
  }

  if(isDefined(param_08)) {
    self.largeprojectiledamage = param_08;
  }

  if(isDefined(var_0F) && isDefined(param_02) && param_02 == "MOD_EXPLOSIVE" || param_02 == "MOD_EXPLOSIVE_BULLET" || param_02 == "MOD_PROJECTILE" || param_02 == "MOD_PROJECTILE_SPLASH" || param_02 == "MOD_GRENADE") {
    param_03 = ceil(param_04 / var_0F);
  }

  if(isDefined(param_00)) {
    if(isDefined(param_00.triggerportableradarping)) {
      param_00 = param_00.triggerportableradarping;
    }

    if(param_00 == self.triggerportableradarping) {
      param_03 = ceil(param_03 / 2);
    }
  }

  return int(param_03);
}

isexplosiveantikillstreakweapon(param_00) {
  var_01 = 0;
  var_02 = scripts\mp\weapons::isaltmodeweapon(param_00);
  var_03 = 0;
  if(scripts\mp\utility::istrue(var_02)) {
    var_04 = scripts\mp\utility::getweaponattachmentsbasenames(param_00);
    foreach(var_06 in var_04) {
      if(var_06 == "gl") {
        var_03 = 1;
        break;
      }
    }
  }

  var_08 = scripts\mp\utility::getweaponbasedsmokegrenadecount(param_00);
  switch (var_08) {
    case "sentry_shock_missile_mp":
    case "jackal_cannon_mp":
    case "shockproj_mp":
    case "iw7_venomx_mp":
    case "iw7_glprox_mp":
    case "switch_blade_child_mp":
    case "iw7_chargeshot_mp":
    case "iw7_lockon_mp":
    case "thorproj_tracking_mp":
    case "thorproj_zoomed_mp":
    case "drone_hive_projectile_mp":
    case "artillery_mp":
    case "bombproj_mp":
    case "iw7_chargeshot_c8_mp":
    case "kineticpulse_emp_mp":
    case "super_trophy_mp":
    case "emp_grenade_mp":
    case "power_exploding_drone_mp":
    case "wristrocket_mp":
    case "c4_mp":
      var_01 = 1;
      break;

    case "iw7_arclassic_mp":
      if(scripts\mp\utility::istrue(var_03)) {
        var_01 = 1;
      }
      break;
  }

  return var_01;
}

func_C1D3(param_00) {
  return isDefined(param_00) && param_00 == self.triggerportableradarping;
}

dodamagetokillstreak(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = (0, 0, 0);
  var_08 = (0, 0, 0);
  var_09 = (0, 0, 0);
  var_0A = (0, 0, 0);
  var_0B = "";
  var_0C = "";
  var_0D = "";
  var_0E = undefined;
  if(isDefined(param_03)) {
    if(level.teambased) {
      if(!scripts\mp\utility::func_9FE7(param_01, param_03, self)) {
        return;
      }
    } else if(!scripts\mp\utility::func_9FD8(param_01, param_03, self)) {
      return;
    }
  }

  if(isagent(self)) {
    self dodamage(param_00, param_04, param_01, param_02, param_05, param_06);
    return;
  }

  self notify("damage", param_00, param_01, var_07, var_08, param_05, var_0B, var_0C, var_0D, var_0E, param_06, param_04, var_09, var_0A, param_02);
}

func_FAE4(param_00, param_01) {
  if(isDefined(level.var_C7B3)) {
    foreach(var_03 in level.var_C7B3) {
      thread func_139B5(var_03, param_00, param_01);
    }
  }
}

func_139B5(param_00, param_01, param_02) {
  var_03 = self.triggerportableradarping;
  var_03 endon("disconnect");
  var_04 = self;
  if(scripts\mp\utility::func_9EF0(self)) {
    var_04 = var_03;
  }

  var_04 endon(param_01);
  level endon("game_ended");
  for(;;) {
    param_00 waittill("trigger", var_05);
    if(var_05 != self) {
      continue;
    }

    if(scripts\mp\utility::func_9EF0(self) && getplayerkillstreakcombatmode(self) == "NONE") {
      continue;
    }

    if(scripts\mp\utility::func_9FAE(var_05)) {
      continue;
    }

    if(scripts\mp\utility::istouchingboundsnullify(var_05)) {
      continue;
    }

    var_05 thread func_13B85(param_01);
    var_05 thread func_13B84(param_00, param_01, param_02);
  }
}

func_13B85(param_00) {
  var_01 = undefined;
  if(isDefined(self.triggerportableradarping)) {
    var_01 = self.triggerportableradarping;
  }

  var_02 = self;
  if(scripts\mp\utility::func_9EF0(self)) {
    var_02 = var_01;
  }

  var_02 waittill(param_00);
  if(isDefined(var_01)) {
    var_01 setclientomnvar("ui_out_of_bounds_countdown", 0);
    var_01 _meth_859E("", 0);
  }

  if(isDefined(self)) {
    self.var_1D44 = undefined;
  }
}

func_13B84(param_00, param_01, param_02) {
  var_03 = self.triggerportableradarping;
  var_03 endon("disconnect");
  var_04 = self;
  if(scripts\mp\utility::func_9EF0(self)) {
    var_04 = var_03;
  }

  var_04 endon(param_01);
  level endon("game_ended");
  if(!isDefined(self.lastboundstimelimit)) {
    self.lastboundstimelimit = scripts\mp\utility::func_7F9B();
  }

  var_05 = gettime() + int(self.lastboundstimelimit * 1000);
  self.var_1D44 = 1;
  var_06 = var_03;
  if(scripts\mp\utility::func_9EF0(self)) {
    var_06 = self;
  }

  if(!scripts\mp\utility::func_9EF0(self) || scripts\mp\utility::func_9EF0(self) && getplayerkillstreakcombatmode(self) == "MANUAL") {
    var_03 setclientomnvar("ui_out_of_bounds_countdown", var_05);
    var_06 _meth_859E("mp_out_of_bounds");
  }

  var_07 = 0;
  var_08 = self.lastboundstimelimit;
  while(self istouching(param_00)) {
    if(var_08 <= 0) {
      var_07 = 1;
      break;
    }

    scripts\engine\utility::waitframe();
    var_08 = var_08 - 0.05;
  }

  var_03 setclientomnvar("ui_out_of_bounds_countdown", 0);
  var_06 _meth_859E("");
  if(isDefined(self)) {
    self.var_1D44 = undefined;
  }

  if(scripts\mp\utility::istrue(var_07)) {
    self.lastboundstimelimit = undefined;
    if(scripts\mp\utility::func_9EF0(self)) {
      var_04 notify(param_01, 0);
      return;
    }

    var_04 notify(param_01, self.origin);
    return;
  }

  self.lastboundstimelimit = var_08;
  thread watchtimelimitcooldown();
}

watchtimelimitcooldown() {
  self endon("death");
  self notify("start_time_limit_cooldown");
  self endon("start_time_limit_cooldown");
  var_00 = scripts\mp\utility::getmaxoutofboundscooldown();
  while(var_00 > 0) {
    scripts\engine\utility::waitframe();
    var_00 = var_00 - 0.05;
  }

  self.lastboundstimelimit = undefined;
}

func_A69F(param_00, param_01) {
  if(!isDefined(param_00.passives)) {
    return 0;
  }

  foreach(var_03 in param_00.passives) {
    if(var_03 == param_01) {
      return 1;
    }
  }

  return 0;
}

getfirstprimaryweapon() {
  var_00 = self getweaponslistprimaries();
  return var_00[0];
}

func_CF1D(param_00, param_01) {
  self endon("death");
  if(!isDefined(level._effect["dlight_large"])) {
    level._effect["dlight_large"] = loadfx("vfx\iw7\_requests\mp\vfx_killstreak_dlight");
  }

  if(!isDefined(level._effect["dlight_small"])) {
    level._effect["dlight_small"] = loadfx("vfx\iw7\_requests\mp\vfx_killstreak_dlight_small");
  }

  if(!isDefined(param_00)) {
    param_00 = (0, 0, 0);
  }

  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  var_02 = scripts\engine\utility::getfx("dlight_large");
  if(scripts\mp\utility::istrue(self.isairdrop)) {
    var_02 = scripts\engine\utility::getfx("dlight_small");
  }

  self.var_7625 = spawn("script_model", self.origin);
  self.var_7625 setModel("tag_origin");
  self.var_7625 linkto(self, "tag_origin", param_00, param_01);
  self.var_7625 thread deleteonparentdeath(self);
  wait(0.1);
  playFXOnTag(var_02, self.var_7625, "tag_origin");
}

deleteonparentdeath(param_00) {
  self endon("death");
  param_00 waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

func_9D28(param_00) {
  switch (param_00) {
    case "ball_drone_backup":
    case "jackal":
    case "remote_c8":
    case "sentry_shock":
      return 1;
  }

  return 0;
}

getplayerkillstreakcombatmode(param_00) {
  var_01 = "NONE";
  if(isDefined(param_00.triggerportableradarping) && isDefined(param_00.triggerportableradarping.var_4BE1)) {
    var_01 = param_00.triggerportableradarping.var_4BE1;
  }

  return var_01;
}

watchsupertrophynotify(param_00) {
  param_00 endon("disconnect");
  self endon("explode");
  for(;;) {
    param_00 waittill("destroyed_by_trophy", var_01, var_02, var_03, var_04, var_05);
    if(var_03 != self.weapon_name) {
      continue;
    }

    param_00 scripts\mp\damagefeedback::updatedamagefeedback("");
    break;
  }
}

getkillstreaknomeleetarget(param_00) {
  var_01 = 0;
  switch (param_00) {
    case "venom":
      var_01 = 1;
      break;
  }

  return var_01;
}

watchhostmigrationlifetime(param_00, param_01, param_02) {
  if(param_00 != "death") {
    self endon("death");
  }

  self endon(param_00);
  level endon("game_ended");
  var_03 = gettime() + int(param_01 * 1000);
  level waittill("host_migration_begin");
  self notify("host_migration_lifetime_update");
  var_04 = gettime();
  var_05 = var_03 - var_04;
  level waittill("host_migration_end");
  var_06 = gettime();
  var_07 = var_06 + var_05;
  var_05 = var_05 / 1000;
  if(isDefined(self.var_DCFC) && getplayerkillstreakcombatmode(self.var_DCFC) == "MANUAL") {
    self.var_DCFC setclientomnvar("ui_remote_c8_countdown", var_07);
  } else if(isDefined(self.streakname) && scripts\mp\utility::func_9F2C(self.streakname)) {
    self.triggerportableradarping setclientomnvar("ui_killstreak_countdown", var_07);
  }

  self[[param_02]](var_05);
}

func_7E92(param_00) {
  var_01 = [];
  foreach(var_03 in level.players) {
    if(param_00 scripts\mp\utility::isenemy(var_03)) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

manualmissilecantracktarget(param_00) {
  var_01 = 1;
  if(!isDefined(param_00) || !scripts\mp\utility::isreallyalive(param_00)) {
    var_01 = 0;
  }

  if(param_00 isinphase() || scripts\mp\utility::istrue(param_00.var_9D8B) || param_00 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
    var_01 = 0;
  }

  return var_01;
}