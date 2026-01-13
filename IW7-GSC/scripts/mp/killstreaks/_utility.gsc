/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_utility.gsc
***********************************************/

func_1843(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self getentitynumber();
  self.var_1653 = var_2 func_7D98();
  if(isDefined(var_0)) {
    if(scripts\mp\utility::func_9FBA(var_0)) {
      func_1863(var_5);
      thread func_E121(var_5);
    } else if(scripts\mp\utility::func_9D35(var_0)) {
      func_1844(var_5);
      thread func_E0FE(var_5);
    } else if(scripts\mp\utility::func_9E7F(var_0)) {
      addtolittlebirdlist(var_5);
      thread func_E111(var_5);
    } else if(scripts\mp\utility::func_9E2D(var_0)) {
      func_184E(var_5);
      thread func_E10A(var_5);
    } else if(scripts\mp\utility::func_9F67(var_0)) {
      func_185A(var_5);
      thread func_E118(var_5);
    } else if(scripts\mp\utility::func_9D61(var_0)) {
      func_1847(var_5);
      thread func_E102(var_5);
    } else if(scripts\mp\utility::func_9FB7(var_0)) {
      func_1862(var_5);
      thread func_E120(var_5);
    } else if(scripts\mp\utility::func_9D82(var_0)) {
      func_184A(var_5);
      thread func_E105(var_5);
    } else if(scripts\mp\utility::func_9F0F(var_0)) {
      func_1857(var_5);
      thread func_E115(var_5);
    } else {
      func_1856(var_5);
      thread removefromplayerkillstreaklistondeath(var_5);
    }

    if(scripts\mp\utility::iskillstreakaffectedbyemp(var_0)) {
      self.var_18DD = 1;
    }

    if(scripts\mp\utility::func_9E6A(var_0)) {
      self.var_18DE = 1;
    }
  }

  level.var_1655[var_5] = self;
  level.var_1655[var_5].streakname = var_0;
  if(scripts\mp\utility::istrue(var_3)) {
    var_6 = undefined;
    var_7 = undefined;
    if(level.teambased) {
      if(scripts\mp\utility::func_9F2C(var_0)) {
        foreach(var_9 in level.players) {
          if(var_9.team == self.team && var_9 != self.triggerportableradarping) {
            var_6 = scripts\mp\utility::outlineenableforplayer(self, "cyan", var_9, 0, 0, "lowest");
          }

          if(isDefined(var_6)) {
            thread func_E14B(var_6, var_4);
          }
        }

        var_7 = 1;
      } else {
        var_6 = scripts\mp\utility::outlineenableforteam(self, "cyan", var_2.team, 0, 0, "lowest");
      }
    } else {
      var_6 = scripts\mp\utility::outlineenableforplayer(self, "cyan", var_2, 0, 0, "lowest");
    }

    if(!scripts\mp\utility::istrue(var_7)) {
      thread func_E14B(var_6, var_4);
    }
  }

  if(isDefined(var_1) && var_1 != "") {
    var_0B = getkillstreaknomeleetarget(var_0);
    scripts\mp\sentientpoolmanager::registersentient(var_1, var_2, var_0B, var_4);
  }

  thread scripts\mp\missions::func_A691(var_0);
}

func_7D98() {
  if(!isDefined(self.pers["nextActiveID"])) {
    self.pers["nextActiveID"] = 0;
  }

  var_0 = self.pers["nextActiveID"];
  self.pers["nextActiveID"]++;
  return var_0;
}

func_E14B(var_0, var_1) {
  var_2 = ["death", "carried"];
  if(isDefined(var_1)) {
    var_2 = [var_1];
  }

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);
  scripts\mp\utility::outlinedisable(var_0, self);
}

func_E0FD(var_0) {
  level.var_1655[var_0] = undefined;
}

func_1654(var_0) {
  return isDefined(level.var_1655[var_0]);
}

func_1863(var_0) {
  if(!isDefined(level.uavmodels)) {
    level.uavmodels = [];
  }

  if(level.teambased) {
    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
    return;
  }

  level.uavmodels[self.triggerportableradarping.guid + "_" + gettime()] = self;
}

func_115CF(var_0) {
  if(isDefined(level.uavmodels[level.otherteam[var_0]]) && level.uavmodels[level.otherteam[var_0]].size > 0) {
    foreach(var_2 in level.uavmodels[level.otherteam[var_0]]) {
      if(!isDefined(var_2)) {
        continue;
      }

      if(var_2.uavtype == "counter_uav") {
        return 0;
      }
    }
  }

  if(isDefined(level.uavmodels[var_0]) && level.uavmodels[var_0].size > 0) {
    foreach(var_2 in level.uavmodels[var_0]) {
      if(!isDefined(var_2)) {
        continue;
      }

      if(var_2.uavtype == "uav" || var_2.uavtype == "directional_uav") {
        return 1;
      }
    }
  }

  return 0;
}

func_12F51() {
  var_0 = [];
  var_0["allies"] = func_115CF("allies");
  var_0["axis"] = func_115CF("axis");
  foreach(var_2 in level.players) {
    if(!isDefined(var_2.team) || var_2.team == "spectator") {
      var_2 setclientomnvar("ui_show_hardcore_minimap", 0);
      continue;
    }

    var_2 setclientomnvar("ui_show_hardcore_minimap", var_0[var_2.team]);
  }
}

func_E121(var_0) {
  self waittill("death");
  if(isDefined(self.var_12AF5)) {
    self.var_12AF5 delete();
  }

  if(level.teambased) {
    var_1 = self.team;
    level.uavmodels[var_1] = ::scripts\engine\utility::array_removeundefined(level.uavmodels[var_1]);
  } else {
    level.uavmodels = scripts\engine\utility::array_removeundefined(level.uavmodels);
  }

  if(isDefined(self)) {
    self delete();
  }

  func_E0FD(var_0);
}

func_9FB9(var_0) {
  if(!isDefined(level.uavmodels)) {
    return 0;
  }

  if(!isDefined(level.uavmodels[var_0])) {
    return 0;
  }

  return level.uavmodels[var_0].size > 0;
}

func_1844(var_0) {
  if(!isDefined(level.var_1AFC)) {
    level.var_1AFC = [];
  }

  level.var_1AFC[var_0] = self;
}

func_E0FE(var_0) {
  self waittill("death");
  level.var_1AFC[var_0] = undefined;
  func_E0FD(var_0);
}

addtolittlebirdlist(var_0) {
  if(!isDefined(level.littlebirds)) {
    level.littlebirds = [];
  }

  level.littlebirds[var_0] = self;
}

func_E111(var_0) {
  self waittill("death");
  level.littlebirds[var_0] = undefined;
  func_E0FD(var_0);
}

func_184E(var_0) {
  if(!isDefined(level.helis)) {
    level.helis = [];
  }

  level.helis[var_0] = self;
}

func_E10A(var_0) {
  self waittill("death");
  level.helis[var_0] = undefined;
  func_E0FD(var_0);
}

func_185A(var_0) {
  if(!isDefined(level.var_105EA)) {
    level.var_105EA = [];
  }

  level.var_105EA[var_0] = self;
}

func_E118(var_0) {
  self waittill("death");
  level.var_105EA[var_0] = undefined;
  func_E0FD(var_0);
}

func_1847(var_0) {
  if(!isDefined(level.balldrones)) {
    level.balldrones = [];
  }

  level.balldrones[var_0] = self;
}

func_E102(var_0) {
  self waittill("death");
  level.balldrones[var_0] = undefined;
  func_E0FD(var_0);
}

func_1862(var_0) {
  if(!isDefined(level.turrets)) {
    level.turrets = [];
  }

  level.turrets[var_0] = self;
}

func_E120(var_0) {
  scripts\engine\utility::waittill_any_3("death", "carried");
  level.turrets[var_0] = undefined;
  func_E0FD(var_0);
}

func_184A(var_0) {
  if(!isDefined(level.var_5228)) {
    level.var_5228 = [];
  }

  level.var_5228[var_0] = self;
}

func_E105(var_0) {
  scripts\engine\utility::waittill_any_3("death", "carried");
  level.var_5228[var_0] = undefined;
  func_E0FD(var_0);
}

func_1857(var_0) {
  if(!isDefined(level.var_DA61)) {
    level.var_DA61 = [];
  }

  level.var_DA61[var_0] = self;
}

func_E115(var_0) {
  self waittill("death");
  level.var_DA61[var_0] = undefined;
  func_E0FD(var_0);
}

func_1856(var_0) {
  if(!isDefined(level.var_D3CC)) {
    level.var_D3CC = [];
  }

  level.var_D3CC[var_0] = self;
}

removefromplayerkillstreaklistondeath(var_0) {
  self waittill("death");
  level.var_D3CC[var_0] = undefined;
  func_E0FD(var_0);
}

func_F774(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self makeusable();
  self setcursorhint("HINT_NOICON");
  self _meth_84A9("show");
  self sethintstring(var_1);
  self _meth_84A6(var_2);
  self setusefov(var_3);
  self _meth_84A4(var_4);
  self setuserange(var_5);
  self setusepriority(var_6);
  level thread func_20D8(self);
  foreach(var_8 in level.players) {
    if(var_8 == var_0) {
      self enableplayeruse(var_8);
      continue;
    }

    self disableplayeruse(var_8);
  }
}

func_20D8(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_1);
    var_0 disableplayeruse(var_1);
  }
}

func_20CF(var_0, var_1) {
  var_2 = self.team;
  var_3 = self.triggerportableradarping;
  var_4 = undefined;
  var_5 = undefined;
  if(!scripts\mp\utility::isreallyalive(var_0) || var_0.team == "spectator") {
    return;
  }

  if(var_0 == var_3) {
    var_4 = "cyan";
  } else if(var_0 != var_3) {
    if((level.teambased && var_0.team != var_2) || !level.teambased) {
      var_4 = "orange";
      var_5 = 1;
    } else {
      return;
    }
  }

  if(isDefined(var_4)) {
    if(scripts\mp\utility::istrue(var_5)) {
      if(var_0 scripts\mp\utility::_hasperk("specialty_noplayertarget")) {
        return;
      }
    }

    var_6 = scripts\mp\utility::outlineenableforplayer(var_0, var_4, self.triggerportableradarping, 1, 1, "killstreak");
    thread func_13ADD(var_6, var_0, var_1);
    thread func_13ADE(var_6, var_0, var_1);
  }
}

func_13ADD(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("death");
  level endon("game_ended");
  self waittill(var_2);
  scripts\mp\utility::outlinedisable(var_0, var_1);
}

func_13ADE(var_0, var_1, var_2) {
  self endon(var_2);
  level endon("game_ended");
  var_1 scripts\engine\utility::waittill_any_3("death", "disconnect");
  scripts\mp\utility::outlinedisable(var_0, var_1);
}

getmodifiedantikillstreakdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_3 = scripts\mp\damage::handleshotgundamage(var_1, var_2, var_3);
  var_3 = scripts\mp\damage::handleapdamage(var_1, var_2, var_3, var_0);
  var_9 = scripts\mp\weapons::isaltmodeweapon(var_1);
  var_0A = 0;
  if(scripts\mp\utility::istrue(var_9)) {
    var_0B = scripts\mp\utility::getweaponattachmentsbasenames(var_1);
    foreach(var_0D in var_0B) {
      if(var_0D == "gl") {
        var_0A = 1;
        break;
      }
    }
  }

  var_0F = undefined;
  var_10 = scripts\mp\utility::getweaponbasedsmokegrenadecount(var_1);
  if(var_2 != "MOD_MELEE") {
    switch (var_10) {
      case "iw7_lockon_mp":
      case "kineticpulse_emp_mp":
      case "super_trophy_mp":
        self.largeprojectiledamage = 1;
        var_0F = var_5;
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
        var_0F = var_6;
        break;

      case "iw7_tacburst_mpl":
      case "iw7_tacburst_mp":
        if(scripts\mp\utility::istrue(var_0A)) {
          self.largeprojectiledamage = 1;
          var_0F = var_6;
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
        var_0F = var_7;
        break;

      case "iw7_mp28_mpl":
      case "iw7_arclassic_mp":
        if(scripts\mp\utility::istrue(var_0A)) {
          self.largeprojectiledamage = 0;
          var_0F = var_7;
        }
        break;
    }
  } else if(var_2 == "MOD_MELEE") {
    switch (var_10) {
      case "iw7_minigun_c8_mp":
      case "iw7_chargeshot_c8_mp":
      case "iw7_c8offhandshield_mp":
        var_3 = 350;
        break;
    }
  }

  if(isDefined(var_8)) {
    self.largeprojectiledamage = var_8;
  }

  if(isDefined(var_0F) && isDefined(var_2) && var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_EXPLOSIVE_BULLET" || var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH" || var_2 == "MOD_GRENADE") {
    var_3 = ceil(var_4 / var_0F);
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0.triggerportableradarping)) {
      var_0 = var_0.triggerportableradarping;
    }

    if(var_0 == self.triggerportableradarping) {
      var_3 = ceil(var_3 / 2);
    }
  }

  return int(var_3);
}

isexplosiveantikillstreakweapon(var_0) {
  var_1 = 0;
  var_2 = scripts\mp\weapons::isaltmodeweapon(var_0);
  var_3 = 0;
  if(scripts\mp\utility::istrue(var_2)) {
    var_4 = scripts\mp\utility::getweaponattachmentsbasenames(var_0);
    foreach(var_6 in var_4) {
      if(var_6 == "gl") {
        var_3 = 1;
        break;
      }
    }
  }

  var_8 = scripts\mp\utility::getweaponbasedsmokegrenadecount(var_0);
  switch (var_8) {
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
      var_1 = 1;
      break;

    case "iw7_arclassic_mp":
      if(scripts\mp\utility::istrue(var_3)) {
        var_1 = 1;
      }
      break;
  }

  return var_1;
}

func_C1D3(var_0) {
  return isDefined(var_0) && var_0 == self.triggerportableradarping;
}

dodamagetokillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = (0, 0, 0);
  var_8 = (0, 0, 0);
  var_9 = (0, 0, 0);
  var_0A = (0, 0, 0);
  var_0B = "";
  var_0C = "";
  var_0D = "";
  var_0E = undefined;
  if(isDefined(var_3)) {
    if(level.teambased) {
      if(!scripts\mp\utility::func_9FE7(var_1, var_3, self)) {
        return;
      }
    } else if(!scripts\mp\utility::func_9FD8(var_1, var_3, self)) {
      return;
    }
  }

  if(isagent(self)) {
    self dodamage(var_0, var_4, var_1, var_2, var_5, var_6);
    return;
  }

  self notify("damage", var_0, var_1, var_7, var_8, var_5, var_0B, var_0C, var_0D, var_0E, var_6, var_4, var_9, var_0A, var_2);
}

func_FAE4(var_0, var_1) {
  if(isDefined(level.var_C7B3)) {
    foreach(var_3 in level.var_C7B3) {
      thread func_139B5(var_3, var_0, var_1);
    }
  }
}

func_139B5(var_0, var_1, var_2) {
  var_3 = self.triggerportableradarping;
  var_3 endon("disconnect");
  var_4 = self;
  if(scripts\mp\utility::func_9EF0(self)) {
    var_4 = var_3;
  }

  var_4 endon(var_1);
  level endon("game_ended");
  for(;;) {
    var_0 waittill("trigger", var_5);
    if(var_5 != self) {
      continue;
    }

    if(scripts\mp\utility::func_9EF0(self) && getplayerkillstreakcombatmode(self) == "NONE") {
      continue;
    }

    if(scripts\mp\utility::func_9FAE(var_5)) {
      continue;
    }

    if(scripts\mp\utility::istouchingboundsnullify(var_5)) {
      continue;
    }

    var_5 thread func_13B85(var_1);
    var_5 thread func_13B84(var_0, var_1, var_2);
  }
}

func_13B85(var_0) {
  var_1 = undefined;
  if(isDefined(self.triggerportableradarping)) {
    var_1 = self.triggerportableradarping;
  }

  var_2 = self;
  if(scripts\mp\utility::func_9EF0(self)) {
    var_2 = var_1;
  }

  var_2 waittill(var_0);
  if(isDefined(var_1)) {
    var_1 setclientomnvar("ui_out_of_bounds_countdown", 0);
    var_1 _meth_859E("", 0);
  }

  if(isDefined(self)) {
    self.var_1D44 = undefined;
  }
}

func_13B84(var_0, var_1, var_2) {
  var_3 = self.triggerportableradarping;
  var_3 endon("disconnect");
  var_4 = self;
  if(scripts\mp\utility::func_9EF0(self)) {
    var_4 = var_3;
  }

  var_4 endon(var_1);
  level endon("game_ended");
  if(!isDefined(self.lastboundstimelimit)) {
    self.lastboundstimelimit = scripts\mp\utility::func_7F9B();
  }

  var_5 = gettime() + int(self.lastboundstimelimit * 1000);
  self.var_1D44 = 1;
  var_6 = var_3;
  if(scripts\mp\utility::func_9EF0(self)) {
    var_6 = self;
  }

  if(!scripts\mp\utility::func_9EF0(self) || scripts\mp\utility::func_9EF0(self) && getplayerkillstreakcombatmode(self) == "MANUAL") {
    var_3 setclientomnvar("ui_out_of_bounds_countdown", var_5);
    var_6 _meth_859E("mp_out_of_bounds");
  }

  var_7 = 0;
  var_8 = self.lastboundstimelimit;
  while(self istouching(var_0)) {
    if(var_8 <= 0) {
      var_7 = 1;
      break;
    }

    scripts\engine\utility::waitframe();
    var_8 = var_8 - 0.05;
  }

  var_3 setclientomnvar("ui_out_of_bounds_countdown", 0);
  var_6 _meth_859E("");
  if(isDefined(self)) {
    self.var_1D44 = undefined;
  }

  if(scripts\mp\utility::istrue(var_7)) {
    self.lastboundstimelimit = undefined;
    if(scripts\mp\utility::func_9EF0(self)) {
      var_4 notify(var_1, 0);
      return;
    }

    var_4 notify(var_1, self.origin);
    return;
  }

  self.lastboundstimelimit = var_8;
  thread watchtimelimitcooldown();
}

watchtimelimitcooldown() {
  self endon("death");
  self notify("start_time_limit_cooldown");
  self endon("start_time_limit_cooldown");
  var_0 = scripts\mp\utility::getmaxoutofboundscooldown();
  while(var_0 > 0) {
    scripts\engine\utility::waitframe();
    var_0 = var_0 - 0.05;
  }

  self.lastboundstimelimit = undefined;
}

func_A69F(var_0, var_1) {
  if(!isDefined(var_0.passives)) {
    return 0;
  }

  foreach(var_3 in var_0.passives) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

getfirstprimaryweapon() {
  var_0 = self getweaponslistprimaries();
  return var_0[0];
}

func_CF1D(var_0, var_1) {
  self endon("death");
  if(!isDefined(level._effect["dlight_large"])) {
    level._effect["dlight_large"] = loadfx("vfx\iw7\_requests\mp\vfx_killstreak_dlight");
  }

  if(!isDefined(level._effect["dlight_small"])) {
    level._effect["dlight_small"] = loadfx("vfx\iw7\_requests\mp\vfx_killstreak_dlight_small");
  }

  if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_2 = scripts\engine\utility::getfx("dlight_large");
  if(scripts\mp\utility::istrue(self.isairdrop)) {
    var_2 = scripts\engine\utility::getfx("dlight_small");
  }

  self.var_7625 = spawn("script_model", self.origin);
  self.var_7625 setModel("tag_origin");
  self.var_7625 linkto(self, "tag_origin", var_0, var_1);
  self.var_7625 thread deleteonparentdeath(self);
  wait(0.1);
  playFXOnTag(var_2, self.var_7625, "tag_origin");
}

deleteonparentdeath(var_0) {
  self endon("death");
  var_0 waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

func_9D28(var_0) {
  switch (var_0) {
    case "ball_drone_backup":
    case "jackal":
    case "remote_c8":
    case "sentry_shock":
      return 1;
  }

  return 0;
}

getplayerkillstreakcombatmode(var_0) {
  var_1 = "NONE";
  if(isDefined(var_0.triggerportableradarping) && isDefined(var_0.triggerportableradarping.var_4BE1)) {
    var_1 = var_0.triggerportableradarping.var_4BE1;
  }

  return var_1;
}

watchsupertrophynotify(var_0) {
  var_0 endon("disconnect");
  self endon("explode");
  for(;;) {
    var_0 waittill("destroyed_by_trophy", var_1, var_2, var_3, var_4, var_5);
    if(var_3 != self.weapon_name) {
      continue;
    }

    var_0 scripts\mp\damagefeedback::updatedamagefeedback("");
    break;
  }
}

getkillstreaknomeleetarget(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "venom":
      var_1 = 1;
      break;
  }

  return var_1;
}

watchhostmigrationlifetime(var_0, var_1, var_2) {
  if(var_0 != "death") {
    self endon("death");
  }

  self endon(var_0);
  level endon("game_ended");
  var_3 = gettime() + int(var_1 * 1000);
  level waittill("host_migration_begin");
  self notify("host_migration_lifetime_update");
  var_4 = gettime();
  var_5 = var_3 - var_4;
  level waittill("host_migration_end");
  var_6 = gettime();
  var_7 = var_6 + var_5;
  var_5 = var_5 / 1000;
  if(isDefined(self.var_DCFC) && getplayerkillstreakcombatmode(self.var_DCFC) == "MANUAL") {
    self.var_DCFC setclientomnvar("ui_remote_c8_countdown", var_7);
  } else if(isDefined(self.streakname) && scripts\mp\utility::func_9F2C(self.streakname)) {
    self.triggerportableradarping setclientomnvar("ui_killstreak_countdown", var_7);
  }

  self[[var_2]](var_5);
}

func_7E92(var_0) {
  var_1 = [];
  foreach(var_3 in level.players) {
    if(var_0 scripts\mp\utility::isenemy(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

manualmissilecantracktarget(var_0) {
  var_1 = 1;
  if(!isDefined(var_0) || !scripts\mp\utility::isreallyalive(var_0)) {
    var_1 = 0;
  }

  if(var_0 isinphase() || scripts\mp\utility::istrue(var_0.var_9D8B) || var_0 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
    var_1 = 0;
  }

  return var_1;
}