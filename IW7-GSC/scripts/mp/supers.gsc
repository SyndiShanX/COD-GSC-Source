/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\supers.gsc
*********************************/

init() {
  level.var_10E4E = [];
  level.superweapons = [];
  level.var_1125E = 1;
  level.var_11264 = [];
  scripts\mp\bots\_bots_supers::func_2EA3();
  if(scripts\mp\utility::isanymlgmatch()) {
    var_00 = 24;
    var_01 = 25;
    var_02 = 26;
    if(level.gametype == "sd") {
      var_02 = 2;
    }
  } else {
    var_00 = 4;
    var_01 = 14;
    var_02 = 2;
  }

  var_03 = 1;
  for(;;) {
    var_04 = tablelookupbyrow("mp\supertable.csv", var_03, 0);
    if(!isDefined(var_04) || var_04 == "") {
      break;
    }

    var_05 = spawnStruct();
    level.var_10E4E[var_04] = var_05;
    var_05.id = var_03;
    var_05.ref = var_04;
    var_05.var_394 = func_DD68(var_03, 1);
    var_05.cooldown = func_DD68(var_03, var_02, 1);
    var_05.var_EC3E = func_DD68(var_03, 3, 1);
    var_05.var_5F36 = func_DD68(var_03, var_00, 1);
    var_05.var_B473 = func_DD68(var_03, 5, 1);
    var_05.useweapon = func_DD68(var_03, 10);
    var_05.var_130F9 = func_DD68(var_03, 11, 1);
    var_05.var_130FA = func_DD68(var_03, 12, 1);
    var_05.var_BCEF = func_DD68(var_03, 13, 1);
    var_05._meth_8487 = func_DD68(var_03, var_01, 1);
    var_05.var_B474 = func_DD68(var_03, 15, 1);
    var_05.var_12B28 = func_DD68(var_03, 17, 1);
    var_05.archetype = func_DD68(var_03, 16);
    var_05.var_9FF8 = func_DD68(var_03, 18, 1);
    level.var_11264[var_03] = var_04;
    if(!isDefined(level.var_2EFC)) {
      level.var_2EFC[var_05.archetype] = [];
    }

    if(!isDefined(level.var_2EFC[var_05.archetype])) {
      level.var_2EFC[var_05.archetype] = [];
    }

    if(scripts\mp\bots\_bots_supers::func_9F8B(var_04)) {
      level.var_2EFC[var_05.archetype][level.var_2EFC[var_05.archetype].size] = var_04;
    }

    if(!isDefined(var_05.var_394)) {
      level.var_10E4E[var_04] = undefined;
    }

    if(!isDefined(var_05.cooldown)) {
      level.var_10E4E[var_04] = undefined;
    }

    if(isDefined(var_05.var_B473)) {
      if(var_05.var_B473 > 0) {
        var_05.var_1616 = var_05.var_5F36 / var_05.var_B473 * 1000;
      } else {
        var_05.var_1616 = var_05.var_5F36;
      }
    }

    if(isDefined(var_05.var_B474)) {
      if(var_05.var_B474 > 0) {
        var_05.var_1617 = var_05.var_5F36 / var_05.var_B474 * 1000;
      }
    }

    if(isDefined(var_05.useweapon)) {
      func_1831(var_05.useweapon, var_04, var_05);
    }

    if(var_05.var_394 == "<default>") {
      var_05.var_394 = "super_default_mp";
    }

    if(isDefined(var_05._meth_8487)) {
      var_05._meth_8487 = var_05._meth_8487 * 1000;
    } else {
      var_05._meth_8487 = 0;
    }

    if(isDefined(var_05.var_12B28)) {
      var_05.var_12B28 = var_05.var_12B28 * 1000;
    } else {
      var_05.var_12B28 = 0;
    }

    var_03++;
  }

  var_06 = tablelookup("mp\superratetable.csv", 0, level.gametype, 1);
  if(isDefined(var_06) && var_06 != "") {
    level.var_1125E = float(var_06);
  }

  func_DF10();
  scripts\mp\supers\super_reaper::func_DD9E();
  scripts\mp\supers\super_armorup::func_218F();
  scripts\mp\supers\super_visionpulse::init();
  scripts\mp\supers\super_supertrophy::func_1127D();
  scripts\mp\equipment\phase_shift::init();
  scripts\mp\teleport::init();
  scripts\mp\equipment\micro_turret::func_B703();
  scripts\mp\equipment\charge_mode::func_3CED();
  scripts\mp\supers\super_blackholegun::init();
  scripts\mp\supers\super_overdrive::func_98AB();
}

func_1831(param_00, param_01, param_02) {
  param_00 = scripts\mp\utility::getweaponrootname(param_00);
  level.superweapons[param_00] = spawnStruct();
  level.superweapons[param_00].var_11263 = param_01;
  level.superweapons[param_00].staticdata = param_02;
}

func_DF10() {
  func_DF0F("super_claw", undefined, undefined, undefined, undefined);
  func_DF0F("super_amplify", undefined, ::func_12C70, ::func_13041, ::func_630A);
  func_DF0F("super_overdrive", ::func_F7CE, ::func_12CFF, undefined, undefined);
  func_DF0F("super_steeldragon", undefined, undefined, undefined, undefined);
  func_DF0F("super_armorup", undefined, undefined, ::func_13044, ::func_630C);
  func_DF0F("super_chargemode", ::func_F68E, ::func_12C8F, ::func_13052, ::func_6313);
  func_DF0F("super_armmgs", undefined, undefined, undefined, undefined);
  func_DF0F("super_reaper", undefined, undefined, ::func_130CA, ::func_637A);
  func_DF0F("super_rewind", ::setrewind, ::unsetrewind, undefined, undefined);
  func_DF0F("super_atomizer", undefined, undefined, undefined, undefined);
  func_DF0F("super_phaseshift", undefined, undefined, ::usephaseshift, ::func_6376);
  func_DF0F("super_teleport", ::func_F87E, ::func_12D44, undefined, undefined);
  func_DF0F("super_blackholegun", undefined, undefined, ::func_1304E, ::func_630F);
  func_DF0F("super_supertrophy", undefined, ::func_12D3F, ::func_130E2, ::func_638F);
  func_DF0F("super_microturret", ::func_F797, ::func_12CEF, ::func_130A4, ::func_6364);
  func_DF0F("super_penetrationrailgun", undefined, undefined, undefined, undefined);
  func_DF0F("super_visionpulse", undefined, undefined, ::func_130F6, undefined);
  func_DF0F("super_invisible", ::func_F75E, ::func_12CDA, ::func_1309A, ::func_635C);
}

func_DF0F(param_00, param_01, param_02, param_03, param_04) {
  var_05 = level.var_10E4E[param_00];
  if(!isDefined(var_05)) {
    return;
  }

  var_05.var_F71E = param_01;
  var_05.var_12CC4 = param_02;
  var_05.beginusefunc = param_03;
  var_05.var_6398 = param_04;
  var_05.var_9F1D = 1;
}

func_DD68(param_00, param_01, param_02) {
  var_03 = tablelookupbyrow("mp\supertable.csv", param_00, param_01);
  if(var_03 == "") {
    return undefined;
  }

  if(scripts\mp\utility::istrue(param_02)) {
    if(issubstr(var_03, ".")) {
      var_03 = float(var_03);
    } else {
      var_03 = int(var_03);
    }
  }

  return var_03;
}

stopridingvehicle(param_00, param_01) {
  clearsuper(param_01);
  var_02 = level.var_10E4E[param_00];
  if(!isDefined(var_02)) {
    return;
  }

  var_03 = spawnStruct();
  self.super = var_03;
  var_03.staticdata = var_02;
  var_03.isinuse = 0;
  var_03.var_461F = undefined;
  var_03.var_461E = undefined;
  var_03.var_130DE = undefined;
  var_03.var_130EF = undefined;
  var_03.var_1CA3 = 1;
  var_03.var_B143 = -1;
  var_03.numkills = 0;
  var_03.var_1391B = 0;
  var_03.canstow = 0;
  var_04 = var_03.staticdata.var_F71E;
  if(isDefined(var_04)) {
    self thread[[var_04]]();
  }

  self setclientomnvar("ui_super_ref", param_00);
  var_05 = 0;
  var_06 = self.pers["superCooldownTime"];
  if(isDefined(var_06)) {
    var_05 = var_06 / 1000;
    self.pers["superCooldownTime"] = undefined;
  }

  func_E276(var_05);
  if(func_1125C()) {
    scripts\mp\utility::_giveweapon(var_02.var_394);
    var_07 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
    self setweaponammoclip(var_02.var_394, var_07);
    self assignweaponoffhandspecial(var_02.var_394);
  } else {
    thread func_13B6D();
  }

  thread func_13A6F();
  thread func_12F32();
  thread func_13A61();
  thread func_110C5();
  thread func_89E8();
  thread func_89F0();
}

clearsuper(param_00) {
  var_01 = getcurrentsuper();
  if(isDefined(var_01) && isDefined(var_01.staticdata)) {
    var_02 = var_01.staticdata.var_12CC4;
    if(isDefined(var_02)) {
      self thread[[var_02]]();
    }
  }

  if(scripts\mp\utility::istrue(param_00) && isDefined(var_01)) {
    func_110C4();
  }

  self clearoffhandspecial();
  if(isDefined(var_01)) {
    scripts\mp\utility::_takeweapon(var_01.staticdata.var_394);
  }

  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    self getrandomweapon(0);
  }

  self notify("remove_super");
  self.super = undefined;
  self setclientomnvar("ui_super_state", 0);
  self setclientomnvar("ui_super_ref", "none");
}

func_E276(param_00) {
  var_01 = getcurrentsuper();
  var_01.var_461E = getsupermaxcooldownmsec();
  var_01.var_461F = 0;
  var_01.var_1CA3 = 1;
  if(isDefined(param_00)) {
    var_01.var_461F = var_01.var_461F + int(param_00 * 1000);
    var_01.var_461F = int(min(var_01.var_461F, var_01.var_461E));
  }

  self setclientomnvar("ui_super_state", 1);
  self setweaponammoclip(var_01.staticdata.var_394, 0);
  func_11257();
}

func_DE3A(param_00) {
  var_01 = getcurrentsuper();
  param_00 = int(param_00);
  var_01.var_461F = var_01.var_461F + param_00;
  func_11257();
}

func_11257() {
  self notify("super_cooldown_altered");
  thread func_12F31();
}

stopshellshock(param_00) {
  var_01 = getcurrentsuper();
  if(!isDefined(var_01) || !isDefined(var_01.staticdata.var_EC3E) || issuperready() || var_01.isinuse) {
    return;
  }

  var_02 = param_00 / 100 * level.superpointsmod * var_01.staticdata.var_EC3E * 1000;
  func_DE3A(var_02);
  scripts\mp\analyticslog::logevent_reportsuperscore(param_00, gettime());
}

func_12F32() {
  self endon("disconnect");
  self endon("remove_super");
  for(;;) {
    var_00 = getcurrentsuper();
    var_01 = 0;
    if(var_00.isinuse) {
      var_01 = hudoutlinedisable();
    } else {
      var_02 = var_00.var_461E - var_00.var_461F;
      var_03 = getsupermaxcooldownmsec();
      var_01 = clamp(1 - var_02 / var_03, 0, 1);
    }

    if(!scripts\mp\utility::isinkillcam() && isalive(self)) {
      self setclientomnvar("ui_super_progress", var_01);
    }

    self _meth_8400(var_01);
    scripts\engine\utility::waitframe();
  }
}

func_13A61() {
  var_00 = getcurrentsuper();
  self endon("disconnect");
  self endon("remove_super");
  for(;;) {
    self waittill("spawned_player");
    if(issuperready()) {
      scripts\mp\lightbar::func_1768(2, 1, 1, 1, 0, "super_use_finished");
      self setclientomnvar("ui_super_state", 2);
    }

    givesuperweapon(var_00);
  }
}

func_12F31() {
  self endon("disconnect");
  self endon("super_cooldown_altered");
  self endon("remove_super");
  self endon("game_ended");
  var_00 = getcurrentsuper();
  self notify("super_finished");
  while(issupercharging()) {
    scripts\mp\utility::gameflagwait("prematch_done");
    if(scripts\mp\utility::istrue(level.hostmigration)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_01 = int(50 * level.var_11260 * scripts\engine\utility::ter_op(scripts\mp\utility::_hasperk("specialty_overclock"), 1.4, 1));
    var_00.var_461F = var_00.var_461F + var_01;
    wait(0.05);
  }

  func_11258();
}

func_110C5() {
  self endon("disconnect");
  self endon("remove_super");
  scripts\mp\utility::func_ABF5("game_over");
  func_110C4();
}

func_89E8() {
  self endon("disconnect");
  self endon("remove_super");
  self waittill("joined_spectators");
  thread clearsuper(1);
}

func_89F0() {
  self endon("disconnect");
  self endon("remove_super");
  var_00 = self.team;
  self waittill("joined_team");
  if(self.team != var_00) {
    thread clearsuper(0);
  }
}

func_11258() {
  var_00 = getcurrentsuper();
  self setweaponammoclip(var_00.staticdata.var_394, 1);
  self setclientomnvar("ui_super_state", 2);
  self playlocalsound("mp_super_ready");
  self notify("super_ready");
  if(!var_00.var_1391B) {
    self.pers["supersEarned"]++;
    self notify("super_earned");
  }

  scripts\mp\lightbar::func_1768(2, 1, 1, 1, 0, "super_use_finished_lb");
  var_00.var_B143 = gettime();
  var_00.numkills = 0;
  scripts\mp\analyticslog::logevent_superearned(var_00.var_B143);
  if(isDefined(self.matchdatalifeindex)) {
    scripts\mp\matchdata::logsuperavailableevent(self.matchdatalifeindex, self.origin);
  }
}

func_13A6F() {
  self endon("disconnect");
  self endon("remove_super");
  for(;;) {
    self waittill("special_weapon_fired", var_00);
    if(scripts\mp\utility::isreallyalive(self)) {
      if(var_00 != getcurrentsuper().staticdata.var_394) {
        continue;
      }

      var_01 = func_2A79();
      if(!isDefined(var_01) || var_01 == 0) {
        continue;
      }

      self waittill("super_use_finished");
    }
  }
}

func_2A79() {
  self endon("death");
  self endon("disconnect");
  var_00 = getcurrentsuper();
  self notify("super_started");
  self playlocalsound("weap_super_activate_plr");
  if(isDefined(var_00) && !var_00.isinuse) {
    var_01 = 1;
    if(isDefined(var_00.staticdata.useweapon)) {
      if(scripts\mp\utility::isinarbitraryup() && superdisabledinarbitraryup(var_00.staticdata.ref)) {
        superdisabledinarbitraryupmessage();
        var_01 = 0;
      } else if(scripts\mp\utility::istryingtousekillstreak() && superdisabledduringkillstreak(var_00.staticdata.ref)) {
        superdisabledduringkillstreakmessage();
        var_01 = 0;
      } else {
        var_01 = func_1289E(var_00.staticdata.useweapon, var_00.staticdata.var_130F9, var_00.staticdata.var_130FA);
      }
    }

    if(var_01 && !isDefined(var_00.staticdata.beginusefunc) || scripts\mp\utility::istrue(self[[var_00.staticdata.beginusefunc]]())) {
      var_02 = [];
      var_02[0] = "super_use_finished_lb";
      var_02[1] = "super_switched";
      scripts\mp\lightbar::func_1768(2, 0, 2, 1, 0, var_02);
      var_00.isinuse = 1;
      var_00.var_1CA3 = scripts\engine\utility::ter_op(var_00.staticdata._meth_8487 > 0, 1, 0);
      func_10DF7();
      if(isDefined(self.matchdatalifeindex)) {
        scripts\mp\matchdata::logsuperactivatedevent(self.matchdatalifeindex, self.origin);
      }

      self setclientomnvar("ui_super_state", 3);
      if(getdvarint("com_codcasterEnabled", 0) == 1) {
        self getrandomweapon(1);
      }

      scripts\mp\utility::printgameaction("super use started - " + var_00.staticdata.ref, self);
      return 1;
    } else {
      if(isDefined(var_01.staticdata.useweapon) && var_02) {
        thread func_11371();
      }

      self setweaponammoclip(var_01.staticdata.var_394, 1);
    }
  }

  return 0;
}

func_1613(param_00, param_01) {
  var_02 = getcurrentsuper();
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  var_03 = gettime();
  if(var_02.var_12B2C > var_03) {
    var_02.var_12B2C = var_03;
  }

  if(param_00 && isDefined(var_02.staticdata.var_1617)) {
    func_DE3B(var_02.staticdata.var_1617 * param_01);
  } else if(isDefined(var_02.staticdata.var_1616)) {
    func_DE3B(var_02.staticdata.var_1616 * param_01);
  }

  return 1;
}

func_10DF7() {
  var_00 = getcurrentsuper();
  self notify("super_use_started");
  var_00.var_130DE = gettime();
  var_00.var_130EF = _meth_8188() * 1000;
  var_00.var_12B2C = gettime() + var_00.staticdata.var_12B28;
  func_112A5();
}

func_DE3B(param_00) {
  var_01 = getcurrentsuper();
  self setclientomnvar("ui_super_flash_progress", hudoutlinedisable());
  var_01.var_130EF = max(var_01.var_130EF - param_00, 0);
  var_01.var_1CA3 = 0;
  func_112A5();
}

func_112A5() {
  self notify("super_use_duration_updated");
  thread func_13B71();
}

func_13B71() {
  self endon("disconnect");
  self endon("super_use_duration_updated");
  self endon("super_use_finished");
  self endon("remove_super");
  var_00 = getcurrentsuper();
  while(var_00.var_130EF > 0) {
    if(scripts\mp\utility::istrue(level.hostmigration)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    scripts\engine\utility::waitframe();
    var_00.var_130EF = var_00.var_130EF - 50;
    if(isbot(self)) {
      if(isDefined(var_00.staticdata.useweapon) && var_00.staticdata.var_9FF8 == 1) {
        var_01 = self getrunningforwardpainanim(var_00.staticdata.useweapon);
        if(!isDefined(var_01) || var_01 <= 0) {
          break;
        }
      }
    }
  }

  superusefinished();
}

superusefinished(param_00, param_01, param_02) {
  var_03 = getcurrentsuper();
  var_04 = hudoutlinedisable();
  self notify("super_use_finished_lb");
  var_03.isinuse = 0;
  var_03.canstow = 0;
  var_05 = undefined;
  if(isDefined(var_03.staticdata.var_6398)) {
    if(!isDefined(param_01)) {
      param_01 = 0;
    }

    var_05 = self[[var_03.staticdata.var_6398]](param_01);
  }

  if(shouldreacttonewenemy(param_02) || scripts\mp\utility::istrue(param_00) || scripts\mp\utility::istrue(var_05)) {
    var_03.var_1391B = 1;
    func_E276(getsupermaxcooldownsec());
  } else if(scripts\mp\utility::istrue(param_02)) {
    var_06 = getsupermaxcooldownsec() * var_04;
    var_03.var_1391B = 1;
    func_E276(var_06);
  } else {
    if(var_03.staticdata.ref != "super_chargemode") {
      var_07 = getsubstr(self.loadoutarchetype, 10, self.loadoutarchetype.size);
      scripts\mp\missions::func_D991("ch_" + var_07 + "_super");
      combatrecordsuperuse(var_03.staticdata.ref);
    }

    var_03.var_A986 = gettime();
    var_03.var_1391B = 0;
    func_E276();
  }

  thread func_11371();
  var_08 = var_03.var_130DE - var_03.var_B143;
  scripts\mp\analyticslog::logevent_superended(var_03.staticdata.ref, var_08, 0, var_03.numkills);
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    self getrandomweapon(0);
  }

  scripts\mp\utility::printgameaction("super use ended - " + var_03.staticdata.ref, self);
  if(isDefined(self.matchdatalifeindex)) {
    if(isDefined(param_01)) {
      scripts\mp\matchdata::logsuperexpiredevent(self.matchdatalifeindex, self.origin, 1);
    } else {
      scripts\mp\matchdata::logsuperexpiredevent(self.matchdatalifeindex, self.origin, 0);
    }
  }

  self notify("super_use_finished");
}

refundsuper() {
  var_00 = getcurrentsuper();
  if(isDefined(var_00)) {
    if(var_00.isinuse) {
      superusefinished(1);
      return;
    }

    func_DE3A(getsupermaxcooldownmsec());
  }
}

handledeath() {
  self endon("disconnect");
  if(!issuperinuse()) {
    return;
  }

  superusefinished(undefined, 1);
}

func_BA37(param_00) {
  self endon("disconnect");
  self endon("death");
  self endon("super_use_finished");
  self endon("remove_super");
  for(;;) {
    self waittill("weapon_fired", var_01);
    var_02 = scripts\mp\weapons::isaltmodeweapon(var_01);
    var_01 = scripts\mp\utility::func_E0CF(var_01);
    if(var_01 == param_00) {
      func_1613(var_02);
    }
  }
}

func_1289E(param_00, param_01, param_02) {
  self endon("disconnect");
  self endon("death");
  scripts\mp\utility::_giveweapon(param_00);
  self setweaponammoclip(param_00, param_01);
  self setweaponammostock(param_00, param_02);
  var_03 = scripts\mp\utility::func_11383(param_00, isbot(self));
  if(var_03) {
    thread func_B2F7(param_00);
    thread func_BA37(param_00);
    return 1;
  }

  scripts\mp\utility::func_1529(param_00);
  return 0;
}

func_B2F7(param_00) {
  self endon("disconnect");
  self endon("death");
  self endon("super_use_finished");
  var_01 = getcurrentsuper();
  var_01.useweaponswapped = undefined;
  var_02 = 0;
  for(;;) {
    var_03 = self getcurrentweapon();
    if(!var_01.canstow && var_03 != "iw7_fistslethal_mp" && var_03 != "iw7_fistsperk_mp" && var_03 != param_00) {
      if(var_03 == "iw7_uplinkball_mp" || var_03 == "iw7_tdefball_mp") {
        var_02 = 1;
      }

      break;
    }

    scripts\engine\utility::waitframe();
  }

  if(issuperinuse()) {
    var_01.useweaponswapped = 1;
    superusefinished(undefined, undefined, var_02);
  }
}

func_11371() {
  self endon("death");
  var_00 = getcurrentsuper();
  var_01 = var_00.staticdata.useweapon;
  if(!isDefined(var_01)) {
    return;
  }

  if(scripts\mp\utility::isreliablyswitchingtoweapon(var_01)) {
    scripts\mp\utility::func_1529(var_01);
    return;
  }

  self notify("super_switched");
  scripts\mp\utility::forcethirdpersonwhenfollowing(var_01);
}

func_110C4() {
  var_00 = getcurrentsuper();
  if(!isDefined(var_00)) {
    return;
  }

  if(issupercharging()) {
    self.pers["superCooldownTime"] = getcurrentsuper().var_461F;
    return;
  }

  if(issuperready()) {
    self.pers["superCooldownTime"] = getcurrentsuper().var_461E;
    return;
  }

  if(issuperinuse()) {
    self.pers["superCooldownTime"] = ::scripts\engine\utility::ter_op(shouldreacttonewenemy(), getcurrentsuper().var_461E, 0);
    return;
  }

  self.pers["superCooldownTime"] = 0;
}

hudoutlinedisable() {
  var_00 = getcurrentsuper();
  var_01 = gettime();
  var_02 = var_00.var_12B2C - var_00.var_130DE;
  var_03 = _meth_8188() * 1000 - var_02;
  var_04 = clamp(var_00.var_130EF / var_03, 0, 1);
  return var_04;
}

getsupermaxcooldownsec() {
  var_00 = getcurrentsuper().staticdata.cooldown * level.var_1125E;
  return scripts\engine\utility::ter_op(getdvarint("scr_super_short_cooldown") != 0, 1, var_00);
}

getsupermaxcooldownmsec() {
  return int(getsupermaxcooldownsec() * 1000);
}

_meth_8188() {
  return getcurrentsuper().staticdata.var_5F36;
}

issuperready() {
  var_00 = getcurrentsuper();
  if(!isDefined(var_00) || var_00.isinuse) {
    return 0;
  }

  return var_00.var_461F >= var_00.var_461E;
}

issuperinuse() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isinuse;
}

issupercharging() {
  return !issuperready() && !issuperinuse();
}

getcurrentsuper() {
  return self.super;
}

getcurrentsuperref() {
  var_00 = getcurrentsuper();
  if(!isDefined(var_00)) {
    return undefined;
  }

  return var_00.staticdata.ref;
}

shouldreacttonewenemy(param_00) {
  var_01 = getcurrentsuper();
  var_02 = var_01.staticdata._meth_8487;
  var_03 = gettime() - var_01.var_130DE;
  if(var_03 >= var_02) {
    return 0;
  }

  if(var_01.numkills > 0) {
    return 0;
  }

  if(scripts\mp\utility::istrue(var_01.useweaponswapped) && !scripts\mp\utility::istrue(param_00)) {
    if(var_01.staticdata.useweapon == "iw7_reaperblade_mp") {
      return 0;
    }
  }

  return var_01.var_1CA3;
}

func_11759() {
  iprintlnbold("Super FIRST activate");
  thread func_11758();
  return 1;
}

func_11758() {
  self endon("disconnect");
  self endon("death");
  self endon("super_use_finished");
  self notifyonplayercommand("testsuper_fired", "+frag");
  for(;;) {
    self waittill("testsuper_fired");
    iprintlnbold("activate");
    func_1613();
  }
}

func_130EA() {
  return func_11759();
}

func_130CA() {
  return scripts\mp\supers\super_reaper::func_DD9D();
}

func_637A(param_00) {
  scripts\mp\supers\super_reaper::func_DD97();
}

func_1304E() {
  return scripts\mp\supers\super_blackholegun::beginuse();
}

func_630F(param_00) {
  scripts\mp\supers\super_blackholegun::stopuse();
}

func_13044() {
  return scripts\mp\supers\super_armorup::func_2197();
}

func_630C(param_00) {
  scripts\mp\supers\super_armorup::func_218E(param_00);
}

func_13041() {
  return scripts\mp\supers\super_amplify::func_12F9B();
}

func_630A(param_00) {
  scripts\mp\supers\super_amplify::end();
}

func_12C70() {
  scripts\mp\supers\super_amplify::unset();
}

func_F7CE() {
  scripts\mp\supers\super_overdrive::func_F7CE();
}

func_12CFF() {
  scripts\mp\supers\super_overdrive::func_12CFF();
}

func_1308A() {
  return scripts\mp\supers\super_gravwave::_meth_8541();
}

func_6332() {
  scripts\mp\supers\super_gravwave::_meth_853F();
}

func_130F6() {
  return scripts\mp\supers\super_visionpulse::func_12F9B();
}

func_1303A() {
  return scripts\mp\supers\super_antiair::func_14F9();
}

func_6308() {
  scripts\mp\supers\super_antiair::func_14F7();
}

func_130A3() {
  return scripts\mp\supers\super_megaboost::func_B554();
}

func_6361() {
  scripts\mp\supers\super_megaboost::func_B552();
}

func_F75E() {}

func_12CDA() {
  scripts\mp\equipment\cloak::end(undefined, 1);
}

func_1309A() {
  return scripts\mp\equipment\cloak::func_12F9B();
}

func_635C(param_00) {
  scripts\mp\equipment\cloak::end(param_00);
}

func_130E2() {
  return scripts\mp\supers\super_supertrophy::func_11297();
}

func_638F(param_00) {
  return scripts\mp\supers\super_supertrophy::func_11276(param_00);
}

func_12D3F(param_00) {
  scripts\mp\supers\super_supertrophy::func_11296(param_00);
}

usephaseshift() {
  return scripts\mp\equipment\phase_shift::func_E88D();
}

func_6376(param_00) {
  scripts\mp\equipment\phase_shift::func_E154(param_00);
}

func_F797() {
  scripts\mp\equipment\micro_turret::func_B70A();
}

func_12CEF() {
  scripts\mp\equipment\micro_turret::func_B718();
}

func_130A4() {
  scripts\mp\equipment\micro_turret::microturret_use();
  return 1;
}

func_6364(param_00) {
  return scripts\mp\equipment\micro_turret::func_B6F9(param_00);
}

func_F68E() {
  scripts\mp\equipment\charge_mode::func_3D0E();
}

func_12C8F() {
  scripts\mp\equipment\charge_mode::func_3D19();
}

func_13052() {
  return scripts\mp\equipment\charge_mode::func_3D1A();
}

func_6313(param_00) {
  scripts\mp\equipment\charge_mode::func_3CDD(param_00);
}

setrewind() {
  scripts\mp\equipment\rewind::setrewind();
}

unsetrewind() {
  scripts\mp\equipment\rewind::unsetrewind();
}

func_F87E() {
  thread scripts\mp\teleport::func_F87E();
}

func_12D44() {
  thread scripts\mp\teleport::func_12D44();
}

func_1309C() {
  thread scripts\mp\equipment\kinetic_pulse::kineticpulse_use();
  return 1;
}

_meth_8189(param_00) {
  param_00 = scripts\mp\utility::getweaponrootname(param_00);
  if(!isDefined(level.superweapons[param_00])) {
    return undefined;
  }

  return level.superweapons[param_00].var_11263;
}

func_7F0D(param_00) {
  param_00 = scripts\mp\utility::getweaponrootname(param_00);
  if(isDefined(level.superweapons[param_00])) {
    return level.superweapons[param_00].staticdata.id;
  }

  var_01 = undefined;
  switch (param_00) {
    case "micro_turret_gun_mp":
      var_01 = "super_microturret";
      break;

    case "chargemode_mp":
      var_01 = "super_chargemode";
      break;
  }

  if(isDefined(var_01)) {
    var_02 = level.var_10E4E[var_01];
    if(isDefined(var_02)) {
      return var_02.id;
    }
  }

  return undefined;
}

_meth_8186(param_00) {
  if(!isDefined(param_00) || !isDefined(level.var_10E4E[param_00]) || param_00 == "none") {
    return 0;
  }

  return level.var_10E4E[param_00].id;
}

func_7FD0(param_00) {
  param_00 = scripts\mp\utility::getweaponrootname(param_00);
  if(!isDefined(level.superweapons[param_00])) {
    return undefined;
  }

  return level.superweapons[param_00].staticdata.var_BCEF;
}

getrootsuperref(param_00) {
  return getsubstr(param_00, 6);
}

allowsuperweaponstow() {
  var_00 = getcurrentsuper();
  if(!isDefined(var_00) || !var_00.isinuse) {
    return;
  }

  var_00.canstow = 1;
}

unstowsuperweapon() {
  var_00 = getcurrentsuper();
  if(!isDefined(var_00) || !var_00.canstow) {
    return;
  }

  if(!var_00.isinuse || !isDefined(var_00.staticdata.useweapon)) {
    var_00.canstow = 0;
    return;
  }

  scripts\mp\utility::func_11383(var_00.staticdata.useweapon);
  var_00.canstow = 0;
}

modifysuperequipmentdamage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  if(isDefined(self.triggerportableradarping) && isDefined(param_00) && param_00 == self.triggerportableradarping) {
    var_05 = int(ceil(param_03 * 0.5));
  }

  return var_05;
}

func_13B6B() {
  level endon("super_delay_end");
  level endon("round_end");
  level endon("game_ended");
  level waittill("prematch_over");
  if(scripts\mp\utility::isanymlgmatch()) {
    level.var_1125A = 0;
  } else {
    level.var_1125A = getdvarfloat("scr_superDelay", 0);
  }

  if(level.var_1125A == 0) {
    level.var_1125D = scripts\mp\utility::gettimepassed();
    level.var_1125B = level.var_1125D;
    level notify("super_delay_end");
  }

  level.var_1125D = scripts\mp\utility::gettimepassed();
  level.var_1125B = level.var_1125D + level.var_1125A * 1000;
  level notify("super_delay_start");
  while(scripts\mp\utility::gettimepassed() < level.var_1125B) {
    scripts\engine\utility::waitframe();
  }

  level notify("super_delay_end");
}

func_13B6D() {
  self endon("remove_super");
  self endon("disconnect");
  level endon("round_end");
  level endon("game_ended");
  stoprumble();
  thread func_411B();
  func_13B6E();
  var_00 = getcurrentsuper().staticdata.var_394;
  var_01 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
  scripts\mp\utility::_giveweapon(var_00);
  self setweaponammoclip(var_00, var_01);
  self assignweaponoffhandspecial(var_00);
  scripts\mp\utility::_takeweapon("super_delay_mp");
}

func_13B6E() {
  level endon("super_delay_end");
  if(!scripts\mp\utility::istrue(scripts\mp\utility::gameflag("prematch_done"))) {
    level waittill("super_delay_start");
  }

  for(;;) {
    self waittill("special_weapon_fired", var_00);
    if(var_00 != "super_delay_mp") {
      continue;
    }

    self setweaponammoclip("super_delay_mp", 1);
    if(issuperready()) {
      var_01 = level.var_1125B - scripts\mp\utility::gettimepassed() / 1000;
      var_01 = int(max(0, ceil(var_01)));
      scripts\mp\hud_message::showerrormessage("MP_SUPERS_UNAVAILABLE_FOR_N", var_01);
    }
  }
}

func_411B() {
  self endon("disconnect");
  level endon("round_end");
  level endon("game_ended");
  level endon("super_delay_end");
  self notify("watchSuperDelayWeaponCleanup");
  self endon("watchSuperDelayWeaponCleanup");
  self waittill("remove_super");
  scripts\mp\utility::_takeweapon("super_delay_mp");
}

stoprumble() {
  scripts\mp\utility::_giveweapon("super_delay_mp");
  self setweaponammoclip("super_delay_mp", 1);
  self assignweaponoffhandspecial("super_delay_mp");
}

cancelsuperdelay() {
  level.var_1125A = 0;
  level.var_1125D = scripts\mp\utility::gettimepassed();
  level.var_1125B = level.var_1125D;
  level notify("super_delay_end");
}

func_1125C() {
  if(isDefined(level.var_1125A) && level.var_1125A == 0) {
    return 1;
  }

  return isDefined(level.var_1125B) && scripts\mp\utility::gettimepassed() > level.var_1125B;
}

givesuperweapon(param_00) {
  if(func_1125C()) {
    if(!self hasweapon(param_00.staticdata.var_394)) {
      var_01 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
      scripts\mp\utility::_giveweapon(param_00.staticdata.var_394);
      self setweaponammoclip(param_00.staticdata.var_394, var_01);
      self assignweaponoffhandspecial(param_00.staticdata.var_394);
      return;
    }

    return;
  }

  stoprumble();
}

watchobjuse(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("obj_drain_end");
  self endon("ball_dropped");
  if(level.gametype == "sd" || level.gametype == "sr" || level.gametype == "dd") {
    if(scripts\mp\utility::istrue(param_01)) {
      self waittill("super_obj_drain");
    }
  } else if(!isDefined(self.carryobject)) {
    self waittill("obj_picked_up");
  } else {
    wait(0.05);
  }

  while(issuperinuse()) {
    func_DE3B(param_00);
    wait(0.05);
  }
}

combatrecordsuperuse(param_00) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_01 = self getplayerdata("mp", "superStats", param_00, "uses");
  self setplayerdata("mp", "superStats", param_00, "uses", var_01 + 1);
}

combatrecordsuperkill(param_00) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_01 = self getplayerdata("mp", "superStats", param_00, "kills");
  self setplayerdata("mp", "superStats", param_00, "kills", var_01 + 1);
}

superdisabledinarbitraryup(param_00) {
  if(param_00 == "super_microturret" || param_00 == "super_supertrophy") {
    return 1;
  }

  return 0;
}

superdisabledinarbitraryupmessage() {
  scripts\mp\hud_message::showerrormessage("MP_SUPERS_UNAVAILABLE_ARB_UP");
}

superdisabledduringkillstreak(param_00) {
  switch (param_00) {
    case "super_visionpulse":
    case "super_invisible":
    case "super_armorup":
    case "super_amplify":
      return 0;

    default:
      return 1;
  }
}

superdisabledduringkillstreakmessage() {
  scripts\mp\hud_message::showerrormessage("MP_SUPERS_UNAVAILABLE_ARB_UP");
}