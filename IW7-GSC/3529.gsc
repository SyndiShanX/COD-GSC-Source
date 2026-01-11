/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3529.gsc
***************************************/

func_1843(var_00, var_01, var_02, var_03, var_04) {
  var_05 = self getentitynumber();
  self.func_1653 = var_02 func_7D98();

  if(isDefined(var_00)) {
    if(scripts\mp\utility\game::func_9FBA(var_00)) {
      func_1863(var_05);
      thread func_E121(var_05);
    } else if(scripts\mp\utility\game::func_9D35(var_00)) {
      func_1844(var_05);
      thread func_E0FE(var_05);
    } else if(scripts\mp\utility\game::func_9E7F(var_00)) {
      addtolittlebirdlist(var_05);
      thread func_E111(var_05);
    } else if(scripts\mp\utility\game::func_9E2D(var_00)) {
      func_184E(var_05);
      thread func_E10A(var_05);
    } else if(scripts\mp\utility\game::func_9F67(var_00)) {
      func_185A(var_05);
      thread func_E118(var_05);
    } else if(scripts\mp\utility\game::func_9D61(var_00)) {
      func_1847(var_05);
      thread func_E102(var_05);
    } else if(scripts\mp\utility\game::func_9FB7(var_00)) {
      func_1862(var_05);
      thread func_E120(var_05);
    } else if(scripts\mp\utility\game::func_9D82(var_00)) {
      func_184A(var_05);
      thread func_E105(var_05);
    } else if(scripts\mp\utility\game::func_9F0F(var_00)) {
      func_1857(var_05);
      thread func_E115(var_05);
    } else {
      func_1856(var_05);
      thread removefromplayerkillstreaklistondeath(var_05);
    }

    if(scripts\mp\utility\game::func_9E64(var_00))
      self.func_18DD = 1;

    if(scripts\mp\utility\game::func_9E6A(var_00))
      self.func_18DE = 1;
  }

  level.func_1655[var_05] = self;
  level.func_1655[var_05].streakname = var_00;

  if(scripts\mp\utility\game::istrue(var_03)) {
    var_06 = undefined;
    var_07 = undefined;

    if(level.teambased) {
      if(scripts\mp\utility\game::func_9F2C(var_00)) {
        foreach(var_09 in level.players) {
          if(var_9.team == self.team && var_09 != self.owner)
            var_06 = scripts\mp\utility\game::outlineenableforplayer(self, "cyan", var_09, 0, 0, "lowest");

          if(isDefined(var_06))
            thread func_E14B(var_06, var_04);
        }

        var_07 = 1;
      } else
        var_06 = scripts\mp\utility\game::outlineenableforteam(self, "cyan", var_2.team, 0, 0, "lowest");
    } else
      var_06 = scripts\mp\utility\game::outlineenableforplayer(self, "cyan", var_02, 0, 0, "lowest");

    if(!scripts\mp\utility\game::istrue(var_07))
      thread func_E14B(var_06, var_04);
  }

  if(isDefined(var_01) && var_01 != "") {
    var_11 = getkillstreaknomeleetarget(var_00);
    scripts\mp\sentientpoolmanager::registersentient(var_01, var_02, var_11, var_04);
  }

  thread scripts\mp\missions::func_A691(var_00);
}

func_7D98() {
  if(!isDefined(self.pers["nextActiveID"]))
    self.pers["nextActiveID"] = 0;

  var_00 = self.pers["nextActiveID"];
  self.pers["nextActiveID"]++;
  return var_00;
}

func_E14B(var_00, var_01) {
  var_02 = ["death", "carried"];

  if(isDefined(var_01))
    var_02 = [var_01];

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_02);
  scripts\mp\utility\game::outlinedisable(var_00, self);
}

func_E0FD(var_00) {
  level.func_1655[var_00] = undefined;
}

func_1654(var_00) {
  return isDefined(level.func_1655[var_00]);
}

func_1863(var_00) {
  if(!isDefined(level.uavmodels))
    level.uavmodels = [];

  if(level.teambased)
    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
  else
    level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

func_115CF(var_00) {
  if(isDefined(level.uavmodels[level.otherteam[var_00]]) && level.uavmodels[level.otherteam[var_00]].size > 0) {
    foreach(var_02 in level.uavmodels[level.otherteam[var_00]]) {
      if(!isDefined(var_02)) {
        continue;
      }
      if(var_2.uavtype == "counter_uav")
        return 0;
    }
  }

  if(isDefined(level.uavmodels[var_00]) && level.uavmodels[var_00].size > 0) {
    foreach(var_02 in level.uavmodels[var_00]) {
      if(!isDefined(var_02)) {
        continue;
      }
      if(var_2.uavtype == "uav" || var_2.uavtype == "directional_uav")
        return 1;
    }
  }

  return 0;
}

func_12F51() {
  var_00 = [];
  var_0["allies"] = func_115CF("allies");
  var_0["axis"] = func_115CF("axis");

  foreach(var_02 in level.players) {
    if(!isDefined(var_2.team) || var_2.team == "spectator") {
      var_02 setclientomnvar("ui_show_hardcore_minimap", 0);
      continue;
    }

    var_02 setclientomnvar("ui_show_hardcore_minimap", var_0[var_2.team]);
  }
}

func_E121(var_00) {
  self waittill("death");

  if(isDefined(self.func_12AF5))
    self.func_12AF5 delete();

  if(level.teambased) {
    var_01 = self.team;
    level.uavmodels[var_01] = ::scripts\engine\utility::array_removeundefined(level.uavmodels[var_01]);
  } else
    level.uavmodels = scripts\engine\utility::array_removeundefined(level.uavmodels);

  if(isDefined(self))
    self delete();

  func_E0FD(var_00);
}

func_9FB9(var_00) {
  if(!isDefined(level.uavmodels))
    return 0;

  if(!isDefined(level.uavmodels[var_00]))
    return 0;

  return level.uavmodels[var_00].size > 0;
}

func_1844(var_00) {
  if(!isDefined(level.func_1AFC))
    level.func_1AFC = [];

  level.func_1AFC[var_00] = self;
}

func_E0FE(var_00) {
  self waittill("death");
  level.func_1AFC[var_00] = undefined;
  func_E0FD(var_00);
}

addtolittlebirdlist(var_00) {
  if(!isDefined(level.littlebirds))
    level.littlebirds = [];

  level.littlebirds[var_00] = self;
}

func_E111(var_00) {
  self waittill("death");
  level.littlebirds[var_00] = undefined;
  func_E0FD(var_00);
}

func_184E(var_00) {
  if(!isDefined(level.helis))
    level.helis = [];

  level.helis[var_00] = self;
}

func_E10A(var_00) {
  self waittill("death");
  level.helis[var_00] = undefined;
  func_E0FD(var_00);
}

func_185A(var_00) {
  if(!isDefined(level.func_105EA))
    level.func_105EA = [];

  level.func_105EA[var_00] = self;
}

func_E118(var_00) {
  self waittill("death");
  level.func_105EA[var_00] = undefined;
  func_E0FD(var_00);
}

func_1847(var_00) {
  if(!isDefined(level.balldrones))
    level.balldrones = [];

  level.balldrones[var_00] = self;
}

func_E102(var_00) {
  self waittill("death");
  level.balldrones[var_00] = undefined;
  func_E0FD(var_00);
}

func_1862(var_00) {
  if(!isDefined(level.turrets))
    level.turrets = [];

  level.turrets[var_00] = self;
}

func_E120(var_00) {
  scripts\engine\utility::waittill_any("death", "carried");
  level.turrets[var_00] = undefined;
  func_E0FD(var_00);
}

func_184A(var_00) {
  if(!isDefined(level.func_5228))
    level.func_5228 = [];

  level.func_5228[var_00] = self;
}

func_E105(var_00) {
  scripts\engine\utility::waittill_any("death", "carried");
  level.func_5228[var_00] = undefined;
  func_E0FD(var_00);
}

func_1857(var_00) {
  if(!isDefined(level.func_DA61))
    level.func_DA61 = [];

  level.func_DA61[var_00] = self;
}

func_E115(var_00) {
  self waittill("death");
  level.func_DA61[var_00] = undefined;
  func_E0FD(var_00);
}

func_1856(var_00) {
  if(!isDefined(level.func_D3CC))
    level.func_D3CC = [];

  level.func_D3CC[var_00] = self;
}

removefromplayerkillstreaklistondeath(var_00) {
  self waittill("death");
  level.func_D3CC[var_00] = undefined;
  func_E0FD(var_00);
}

func_F774(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self makeusable();
  self setcursorhint("HINT_NOICON");
  self _meth_84A9("show");
  self sethintstring(var_01);
  self _meth_84A6(var_02);
  self setusefov(var_03);
  self _meth_84A4(var_04);
  self setuserange(var_05);
  self setusepriority(var_06);
  level thread func_20D8(self);

  foreach(var_08 in level.players) {
    if(var_08 == var_00) {
      self enableplayeruse(var_08);
      continue;
    }

    self disableplayeruse(var_08);
  }
}

func_20D8(var_00) {
  var_00 endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_01);
    var_00 disableplayeruse(var_01);
  }
}

func_20CF(var_00, var_01) {
  var_02 = self.team;
  var_03 = self.owner;
  var_04 = undefined;
  var_05 = undefined;

  if(!scripts\mp\utility\game::isreallyalive(var_00) || var_0.team == "spectator") {
    return;
  }
  if(var_00 == var_03)
    var_04 = "cyan";
  else if(var_00 != var_03) {
    if(level.teambased && var_0.team != var_02 || !level.teambased) {
      var_04 = "orange";
      var_05 = 1;
    } else
      return;
  }

  if(isDefined(var_04)) {
    if(scripts\mp\utility\game::istrue(var_05)) {
      if(var_00 scripts\mp\utility\game::_hasperk("specialty_noplayertarget"))
        return;
    }

    var_06 = scripts\mp\utility\game::outlineenableforplayer(var_00, var_04, self.owner, 1, 1, "killstreak");
    thread func_13ADD(var_06, var_00, var_01);
    thread func_13ADE(var_06, var_00, var_01);
  }
}

func_13ADD(var_00, var_01, var_02) {
  var_01 endon("disconnect");
  var_01 endon("death");
  level endon("game_ended");
  self waittill(var_02);
  scripts\mp\utility\game::outlinedisable(var_00, var_01);
}

func_13ADE(var_00, var_01, var_02) {
  self endon(var_02);
  level endon("game_ended");
  var_01 scripts\engine\utility::waittill_any("death", "disconnect");
  scripts\mp\utility\game::outlinedisable(var_00, var_01);
}

getmodifiedantikillstreakdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  var_03 = scripts\mp\damage::handleshotgundamage(var_01, var_02, var_03);
  var_03 = scripts\mp\damage::handleapdamage(var_01, var_02, var_03, var_00);
  var_09 = scripts\mp\weapons::isaltmodeweapon(var_01);
  var_10 = 0;

  if(scripts\mp\utility\game::istrue(var_09)) {
    var_11 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_01);

    foreach(var_13 in var_11) {
      if(var_13 == "gl") {
        var_10 = 1;
        break;
      }
    }
  }

  var_15 = undefined;
  var_16 = scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_01);

  if(var_02 != "MOD_MELEE") {
    switch (var_16) {
      case "iw7_lockon_mp":
      case "kineticpulse_emp_mp":
      case "super_trophy_mp":
        self.largeprojectiledamage = 1;
        var_15 = var_05;
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
        var_15 = var_06;
        break;
      case "iw7_tacburst_mpl":
      case "iw7_tacburst_mp":
        if(scripts\mp\utility\game::istrue(var_10)) {
          self.largeprojectiledamage = 1;
          var_15 = var_06;
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
        var_15 = var_07;
        break;
      case "iw7_mp28_mpl":
      case "iw7_arclassic_mp":
        if(scripts\mp\utility\game::istrue(var_10)) {
          self.largeprojectiledamage = 0;
          var_15 = var_07;
        }

        break;
    }
  } else if(var_02 == "MOD_MELEE") {
    switch (var_16) {
      case "iw7_minigun_c8_mp":
      case "iw7_chargeshot_c8_mp":
      case "iw7_c8offhandshield_mp":
        var_03 = 350;
        break;
    }
  }

  if(isDefined(var_08))
    self.largeprojectiledamage = var_08;

  if(isDefined(var_15) && isDefined(var_02) && (var_02 == "MOD_EXPLOSIVE" || var_02 == "MOD_EXPLOSIVE_BULLET" || var_02 == "MOD_PROJECTILE" || var_02 == "MOD_PROJECTILE_SPLASH" || var_02 == "MOD_GRENADE"))
    var_03 = ceil(var_04 / var_15);

  if(isDefined(var_00)) {
    if(isDefined(var_0.owner))
      var_00 = var_0.owner;

    if(var_00 == self.owner)
      var_03 = ceil(var_03 / 2);
  }

  return int(var_03);
}

isexplosiveantikillstreakweapon(var_00) {
  var_01 = 0;
  var_02 = scripts\mp\weapons::isaltmodeweapon(var_00);
  var_03 = 0;

  if(scripts\mp\utility\game::istrue(var_02)) {
    var_04 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_00);

    foreach(var_06 in var_04) {
      if(var_06 == "gl") {
        var_03 = 1;
        break;
      }
    }
  }

  var_08 = scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_00);

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
      if(scripts\mp\utility\game::istrue(var_03))
        var_01 = 1;

      break;
  }

  return var_01;
}

func_C1D3(var_00) {
  return isDefined(var_00) && var_00 == self.owner;
}

dodamagetokillstreak(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = (0, 0, 0);
  var_08 = (0, 0, 0);
  var_09 = (0, 0, 0);
  var_10 = (0, 0, 0);
  var_11 = "";
  var_12 = "";
  var_13 = "";
  var_14 = undefined;

  if(isDefined(var_03)) {
    if(level.teambased) {
      if(!scripts\mp\utility\game::func_9FE7(var_01, var_03, self))
        return;
    } else if(!scripts\mp\utility\game::func_9FD8(var_01, var_03, self))
      return;
  }

  if(isagent(self))
    self getrandomarmkillstreak(var_00, var_04, var_01, var_02, var_05, var_06);
  else
    self notify("damage", var_00, var_01, var_07, var_08, var_05, var_11, var_12, var_13, var_14, var_06, var_04, var_09, var_10, var_02);
}

func_FAE4(var_00, var_01) {
  if(isDefined(level.func_C7B3)) {
    foreach(var_03 in level.func_C7B3) {
      thread func_139B5(var_03, var_00, var_01);
    }
  }
}

func_139B5(var_00, var_01, var_02) {
  var_03 = self.owner;
  var_03 endon("disconnect");
  var_04 = self;

  if(scripts\mp\utility\game::func_9EF0(self))
    var_04 = var_03;

  var_04 endon(var_01);
  level endon("game_ended");

  for(;;) {
    var_00 waittill("trigger", var_05);

    if(var_05 != self) {
      continue;
    }
    if(scripts\mp\utility\game::func_9EF0(self) && getplayerkillstreakcombatmode(self) == "NONE") {
      continue;
    }
    if(scripts\mp\utility\game::func_9FAE(var_05)) {
      continue;
    }
    if(scripts\mp\utility\game::istouchingboundsnullify(var_05)) {
      continue;
    }
    var_05 thread func_13B85(var_01);
    var_05 thread func_13B84(var_00, var_01, var_02);
  }
}

func_13B85(var_00) {
  var_01 = undefined;

  if(isDefined(self.owner))
    var_01 = self.owner;

  var_02 = self;

  if(scripts\mp\utility\game::func_9EF0(self))
    var_02 = var_01;

  var_02 waittill(var_00);

  if(isDefined(var_01)) {
    var_01 setclientomnvar("ui_out_of_bounds_countdown", 0);
    var_01 _meth_859E("", 0);
  }

  if(isDefined(self))
    self.func_1D44 = undefined;
}

func_13B84(var_00, var_01, var_02) {
  var_03 = self.owner;
  var_03 endon("disconnect");
  var_04 = self;

  if(scripts\mp\utility\game::func_9EF0(self))
    var_04 = var_03;

  var_04 endon(var_01);
  level endon("game_ended");

  if(!isDefined(self.lastboundstimelimit))
    self.lastboundstimelimit = scripts\mp\utility\game::func_7F9B();

  var_05 = gettime() + int(self.lastboundstimelimit * 1000);
  self.func_1D44 = 1;
  var_06 = var_03;

  if(scripts\mp\utility\game::func_9EF0(self))
    var_06 = self;

  if(!scripts\mp\utility\game::func_9EF0(self) || scripts\mp\utility\game::func_9EF0(self) && getplayerkillstreakcombatmode(self) == "MANUAL") {
    var_03 setclientomnvar("ui_out_of_bounds_countdown", var_05);
    var_06 _meth_859E("mp_out_of_bounds");
  }

  var_07 = 0;

  for(var_08 = self.lastboundstimelimit; self istouching(var_00); var_08 = var_08 - 0.05) {
    if(var_08 <= 0) {
      var_07 = 1;
      break;
    }

    scripts\engine\utility::waitframe();
  }

  var_03 setclientomnvar("ui_out_of_bounds_countdown", 0);
  var_06 _meth_859E("");

  if(isDefined(self))
    self.func_1D44 = undefined;

  if(scripts\mp\utility\game::istrue(var_07)) {
    self.lastboundstimelimit = undefined;

    if(scripts\mp\utility\game::func_9EF0(self))
      var_04 notify(var_01, 0);
    else
      var_04 notify(var_01, self.origin);
  } else {
    self.lastboundstimelimit = var_08;
    thread watchtimelimitcooldown();
  }
}

watchtimelimitcooldown() {
  self endon("death");
  self notify("start_time_limit_cooldown");
  self endon("start_time_limit_cooldown");

  for(var_00 = scripts\mp\utility\game::getmaxoutofboundscooldown(); var_00 > 0; var_00 = var_00 - 0.05)
    scripts\engine\utility::waitframe();

  self.lastboundstimelimit = undefined;
}

func_A69F(var_00, var_01) {
  if(!isDefined(var_0.passives))
    return 0;

  foreach(var_03 in var_0.passives) {
    if(var_03 == var_01)
      return 1;
  }

  return 0;
}

getfirstprimaryweapon() {
  var_00 = self getweaponslistprimaries();
  return var_0[0];
}

func_CF1D(var_00, var_01) {
  self endon("death");

  if(!isDefined(level._effect["dlight_large"]))
    level._effect["dlight_large"] = loadfx("vfx\iw7\_requests\mp\vfx_killstreak_dlight");

  if(!isDefined(level._effect["dlight_small"]))
    level._effect["dlight_small"] = loadfx("vfx\iw7\_requests\mp\vfx_killstreak_dlight_small");

  if(!isDefined(var_00))
    var_00 = (0, 0, 0);

  if(!isDefined(var_01))
    var_01 = (0, 0, 0);

  var_02 = scripts\engine\utility::getfx("dlight_large");

  if(scripts\mp\utility\game::istrue(self.isairdrop))
    var_02 = scripts\engine\utility::getfx("dlight_small");

  self.func_7625 = spawn("script_model", self.origin);
  self.func_7625 setModel("tag_origin");
  self.func_7625 linkto(self, "tag_origin", var_00, var_01);
  self.func_7625 thread deleteonparentdeath(self);
  wait 0.1;
  playFXOnTag(var_02, self.func_7625, "tag_origin");
}

deleteonparentdeath(var_00) {
  self endon("death");
  var_00 waittill("death");

  if(isDefined(self))
    self delete();
}

func_9D28(var_00) {
  switch (var_00) {
    case "ball_drone_backup":
    case "jackal":
    case "remote_c8":
    case "sentry_shock":
      return 1;
  }

  return 0;
}

getplayerkillstreakcombatmode(var_00) {
  var_01 = "NONE";

  if(isDefined(var_0.owner) && isDefined(var_0.owner.func_4BE1))
    var_01 = var_0.owner.func_4BE1;

  return var_01;
}

watchsupertrophynotify(var_00) {
  var_00 endon("disconnect");
  self endon("explode");

  for(;;) {
    var_00 waittill("destroyed_by_trophy", var_01, var_02, var_03, var_04, var_05);

    if(var_03 != self.weapon_name) {
      continue;
    }
    var_00 scripts\mp\damagefeedback::updatedamagefeedback("");
    break;
  }
}

getkillstreaknomeleetarget(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "venom":
      var_01 = 1;
      break;
  }

  return var_01;
}

watchhostmigrationlifetime(var_00, var_01, var_02) {
  if(var_00 != "death")
    self endon("death");

  self endon(var_00);
  level endon("game_ended");
  var_03 = gettime() + int(var_01 * 1000);
  level waittill("host_migration_begin");
  self notify("host_migration_lifetime_update");
  var_04 = gettime();
  var_05 = var_03 - var_04;
  level waittill("host_migration_end");
  var_06 = gettime();
  var_07 = var_06 + var_05;
  var_05 = var_05 / 1000;

  if(isDefined(self.func_DCFC) && getplayerkillstreakcombatmode(self.func_DCFC) == "MANUAL")
    self.func_DCFC setclientomnvar("ui_remote_c8_countdown", var_07);
  else if(isDefined(self.streakname) && scripts\mp\utility\game::func_9F2C(self.streakname))
    self.owner setclientomnvar("ui_killstreak_countdown", var_07);

  self[[var_02]](var_05);
}

func_7E92(var_00) {
  var_01 = [];

  foreach(var_03 in level.players) {
    if(var_00 scripts\mp\utility\game::isenemy(var_03))
      var_1[var_1.size] = var_03;
  }

  return var_01;
}

manualmissilecantracktarget(var_00) {
  var_01 = 1;

  if(!isDefined(var_00) || !scripts\mp\utility\game::isreallyalive(var_00))
    var_01 = 0;

  if(var_00 isinphase() || scripts\mp\utility\game::istrue(var_0.func_9D8B) || var_00 scripts\mp\utility\game::_hasperk("specialty_noscopeoutline"))
    var_01 = 0;

  return var_01;
}