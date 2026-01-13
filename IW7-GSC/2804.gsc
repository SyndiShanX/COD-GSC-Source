/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2804.gsc
**************************************/

init() {
  level.var_10E4E = [];
  level.superweapons = [];
  level.var_1125E = 1.0;
  level.var_11264 = [];
  scripts\mp\bots\bots_supers::func_2EA3();

  if(scripts\mp\utility\game::isanymlgmatch()) {
    var_0 = 24;
    var_1 = 25;
    var_2 = 26;

    if(level.gametype == "sd") {
      var_2 = 2;
    }
  } else {
    var_0 = 4;
    var_1 = 14;
    var_2 = 2;
  }

  var_3 = 1;

  for(;;) {
    var_4 = tablelookupbyrow("mp\supertable.csv", var_3, 0);

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }
    var_5 = spawnStruct();
    level.var_10E4E[var_4] = var_5;
    var_5.id = var_3;
    var_5.ref = var_4;
    var_5.weapon = func_DD68(var_3, 1);
    var_5.cooldown = func_DD68(var_3, var_2, 1);
    var_5.var_EC3E = func_DD68(var_3, 3, 1);
    var_5.var_5F36 = func_DD68(var_3, var_0, 1);
    var_5.var_B473 = func_DD68(var_3, 5, 1);
    var_5.useweapon = func_DD68(var_3, 10);
    var_5.var_130F9 = func_DD68(var_3, 11, 1);
    var_5.var_130FA = func_DD68(var_3, 12, 1);
    var_5.var_BCEF = func_DD68(var_3, 13, 1);
    var_5._meth_8487 = func_DD68(var_3, var_1, 1);
    var_5.var_B474 = func_DD68(var_3, 15, 1);
    var_5.var_12B28 = func_DD68(var_3, 17, 1);
    var_5.archetype = func_DD68(var_3, 16);
    var_5.var_9FF8 = func_DD68(var_3, 18, 1);
    level.var_11264[var_3] = var_4;

    if(!isDefined(level.var_2EFC)) {
      level.var_2EFC[var_5.archetype] = [];
    }

    if(!isDefined(level.var_2EFC[var_5.archetype])) {
      level.var_2EFC[var_5.archetype] = [];
    }

    if(scripts\mp\bots\bots_supers::func_9F8B(var_4)) {
      level.var_2EFC[var_5.archetype][level.var_2EFC[var_5.archetype].size] = var_4;
    }

    if(!isDefined(var_5.weapon)) {
      level.var_10E4E[var_4] = undefined;
    }

    if(!isDefined(var_5.cooldown)) {
      level.var_10E4E[var_4] = undefined;
    }

    if(isDefined(var_5.var_B473)) {
      if(var_5.var_B473 > 0) {
        var_5.var_1616 = var_5.var_5F36 / var_5.var_B473 * 1000.0;
      } else {
        var_5.var_1616 = var_5.var_5F36;
      }
    }

    if(isDefined(var_5.var_B474)) {
      if(var_5.var_B474 > 0) {
        var_5.var_1617 = var_5.var_5F36 / var_5.var_B474 * 1000.0;
      }
    }

    if(isDefined(var_5.useweapon)) {
      func_1831(var_5.useweapon, var_4, var_5);
    }

    if(var_5.weapon == "<default>") {
      var_5.weapon = "super_default_mp";
    }

    if(isDefined(var_5._meth_8487)) {
      var_5._meth_8487 = var_5._meth_8487 * 1000.0;
    } else {
      var_5._meth_8487 = 0.0;
    }

    if(isDefined(var_5.var_12B28)) {
      var_5.var_12B28 = var_5.var_12B28 * 1000.0;
    } else {
      var_5.var_12B28 = 0.0;
    }

    var_3++;
  }

  var_6 = tablelookup("mp\superratetable.csv", 0, level.gametype, 1);

  if(isDefined(var_6) && var_6 != "") {
    level.var_1125E = float(var_6);
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

func_1831(var_0, var_1, var_2) {
  var_0 = scripts\mp\utility\game::getweaponrootname(var_0);
  level.superweapons[var_0] = spawnStruct();
  level.superweapons[var_0].var_11263 = var_1;
  level.superweapons[var_0].staticdata = var_2;
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

func_DF0F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.var_10E4E[var_0];

  if(!isDefined(var_5)) {
    return;
  }
  var_5.var_F71E = var_1;
  var_5.var_12CC4 = var_2;
  var_5.beginusefunc = var_3;
  var_5.var_6398 = var_4;
  var_5.var_9F1D = 1;
}

func_DD68(var_0, var_1, var_2) {
  var_3 = tablelookupbyrow("mp\supertable.csv", var_0, var_1);

  if(var_3 == "") {
    return undefined;
  }

  if(scripts\mp\utility\game::istrue(var_2)) {
    if(issubstr(var_3, ".")) {
      var_3 = float(var_3);
    } else {
      var_3 = int(var_3);
    }
  }

  return var_3;
}

stopridingvehicle(var_0, var_1) {
  clearsuper(var_1);
  var_2 = level.var_10E4E[var_0];

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = spawnStruct();
  self.super = var_3;
  var_3.staticdata = var_2;
  var_3.isinuse = 0;
  var_3.var_461F = undefined;
  var_3.var_461E = undefined;
  var_3.var_130DE = undefined;
  var_3.var_130EF = undefined;
  var_3.var_1CA3 = 1;
  var_3.var_B143 = -1;
  var_3.numkills = 0;
  var_3.var_1391B = 0;
  var_3.canstow = 0;
  var_4 = var_3.staticdata.var_F71E;

  if(isDefined(var_4)) {
    self thread[[var_4]]();
  }

  self setclientomnvar("ui_super_ref", var_0);
  var_5 = 0;
  var_6 = self.pers["superCooldownTime"];

  if(isDefined(var_6)) {
    var_5 = var_6 / 1000.0;
    self.pers["superCooldownTime"] = undefined;
  }

  func_E276(var_5);

  if(func_1125C()) {
    scripts\mp\utility\game::_giveweapon(var_2.weapon);
    var_7 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
    self setweaponammoclip(var_2.weapon, var_7);
    self assignweaponoffhandspecial(var_2.weapon);
  } else
    thread func_13B6D();

  thread func_13A6F();
  thread func_12F32();
  thread func_13A61();
  thread func_110C5();
  thread func_89E8();
  thread func_89F0();
}

clearsuper(var_0) {
  var_1 = getcurrentsuper();

  if(isDefined(var_1) && isDefined(var_1.staticdata)) {
    var_2 = var_1.staticdata.var_12CC4;

    if(isDefined(var_2)) {
      self thread[[var_2]]();
    }
  }

  if(scripts\mp\utility\game::istrue(var_0) && isDefined(var_1)) {
    func_110C4();
  }

  self clearoffhandspecial();

  if(isDefined(var_1)) {
    scripts\mp\utility\game::_takeweapon(var_1.staticdata.weapon);
  }

  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    self getrandomweapon(0);
  }

  self notify("remove_super");
  self.super = undefined;
  self setclientomnvar("ui_super_state", 0);
  self setclientomnvar("ui_super_ref", "none");
}

func_E276(var_0) {
  var_1 = getcurrentsuper();
  var_1.var_461E = getsupermaxcooldownmsec();
  var_1.var_461F = 0;
  var_1.var_1CA3 = 1;

  if(isDefined(var_0)) {
    var_1.var_461F = var_1.var_461F + int(var_0 * 1000);
    var_1.var_461F = int(min(var_1.var_461F, var_1.var_461E));
  }

  self setclientomnvar("ui_super_state", 1);
  self setweaponammoclip(var_1.staticdata.weapon, 0);
  func_11257();
}

func_DE3A(var_0) {
  var_1 = getcurrentsuper();
  var_0 = int(var_0);
  var_1.var_461F = var_1.var_461F + var_0;
  func_11257();
}

func_11257() {
  self notify("super_cooldown_altered");
  thread func_12F31();
}

stopshellshock(var_0) {
  var_1 = getcurrentsuper();

  if(!isDefined(var_1) || !isDefined(var_1.staticdata.var_EC3E) || issuperready() || var_1.isinuse) {
    return;
  }
  var_2 = var_0 / 100.0 * level.superpointsmod * var_1.staticdata.var_EC3E * 1000.0;
  func_DE3A(var_2);
  scripts\mp\analyticslog::logevent_reportsuperscore(var_0, gettime());
}

func_12F32() {
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    var_0 = getcurrentsuper();
    var_1 = 0.0;

    if(var_0.isinuse) {
      var_1 = hudoutlinedisable();
    } else {
      var_2 = var_0.var_461E - var_0.var_461F;
      var_3 = getsupermaxcooldownmsec();
      var_1 = clamp(1.0 - var_2 / var_3, 0.0, 1.0);
    }

    if(!scripts\mp\utility\game::isinkillcam() && isalive(self)) {
      self setclientomnvar("ui_super_progress", var_1);
    }

    self _meth_8400(var_1);
    scripts\engine\utility::waitframe();
  }
}

func_13A61() {
  var_0 = getcurrentsuper();
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    self waittill("spawned_player");

    if(issuperready()) {
      scripts\mp\lightbar::func_1768(2, 1, 1, 1, 0, "super_use_finished");
      self setclientomnvar("ui_super_state", 2);
    }

    givesuperweapon(var_0);
  }
}

func_12F31() {
  self endon("disconnect");
  self endon("super_cooldown_altered");
  self endon("remove_super");
  self endon("game_ended");
  var_0 = getcurrentsuper();
  self notify("super_finished");

  while(issupercharging()) {
    scripts\mp\utility\game::gameflagwait("prematch_done");

    if(scripts\mp\utility\game::istrue(level.hostmigration)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_1 = int(50.0 * level.var_11260 * scripts\engine\utility::ter_op(scripts\mp\utility\game::_hasperk("specialty_overclock"), 1.4, 1.0));
    var_0.var_461F = var_0.var_461F + var_1;
    wait 0.05;
  }

  func_11258();
}

func_110C5() {
  self endon("disconnect");
  self endon("remove_super");
  scripts\mp\utility\game::func_ABF5("game_over");
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
  var_0 = self.team;
  self waittill("joined_team");

  if(self.team != var_0) {
    thread clearsuper(0);
  }
}

func_11258() {
  var_0 = getcurrentsuper();
  self setweaponammoclip(var_0.staticdata.weapon, 1);
  self setclientomnvar("ui_super_state", 2);
  self playlocalsound("mp_super_ready");
  self notify("super_ready");

  if(!var_0.var_1391B) {
    self.pers["supersEarned"]++;
    self notify("super_earned");
  }

  scripts\mp\lightbar::func_1768(2, 1, 1, 1, 0, "super_use_finished_lb");
  var_0.var_B143 = gettime();
  var_0.numkills = 0;
  scripts\mp\analyticslog::logevent_superearned(var_0.var_B143);

  if(isDefined(self.matchdatalifeindex)) {
    scripts\mp\matchdata::logsuperavailableevent(self.matchdatalifeindex, self.origin);
  }
}

func_13A6F() {
  self endon("disconnect");
  self endon("remove_super");

  for(;;) {
    self waittill("special_weapon_fired", var_0);

    if(scripts\mp\utility\game::isreallyalive(self)) {
      if(var_0 != getcurrentsuper().staticdata.weapon) {
        continue;
      }
      var_1 = func_2A79();

      if(!isDefined(var_1) || var_1 == 0) {
        continue;
      }
      self waittill("super_use_finished");
    }
  }
}

func_2A79() {
  self endon("death");
  self endon("disconnect");
  var_0 = getcurrentsuper();
  self notify("super_started");
  self playlocalsound("weap_super_activate_plr");

  if(isDefined(var_0) && !var_0.isinuse) {
    var_1 = 1;

    if(isDefined(var_0.staticdata.useweapon)) {
      if(scripts\mp\utility\game::isinarbitraryup() && superdisabledinarbitraryup(var_0.staticdata.ref)) {
        superdisabledinarbitraryupmessage();
        var_1 = 0;
      } else if(scripts\mp\utility\game::istryingtousekillstreak() && superdisabledduringkillstreak(var_0.staticdata.ref)) {
        superdisabledduringkillstreakmessage();
        var_1 = 0;
      } else
        var_1 = func_1289E(var_0.staticdata.useweapon, var_0.staticdata.var_130F9, var_0.staticdata.var_130FA);
    }

    if(var_1 && (!isDefined(var_0.staticdata.beginusefunc) || scripts\mp\utility\game::istrue(self[[var_0.staticdata.beginusefunc]]()))) {
      var_2 = [];
      var_2[0] = "super_use_finished_lb";
      var_2[1] = "super_switched";
      scripts\mp\lightbar::func_1768(2, 0, 2, 1, 0, var_2);
      var_0.isinuse = 1;
      var_0.var_1CA3 = scripts\engine\utility::ter_op(var_0.staticdata._meth_8487 > 0, 1, 0);
      func_10DF7();

      if(isDefined(self.matchdatalifeindex)) {
        scripts\mp\matchdata::logsuperactivatedevent(self.matchdatalifeindex, self.origin);
      }

      self setclientomnvar("ui_super_state", 3);

      if(getdvarint("com_codcasterEnabled", 0) == 1) {
        self getrandomweapon(1);
      }

      scripts\mp\utility\game::printgameaction("super use started - " + var_0.staticdata.ref, self);
      return 1;
    } else {
      if(isDefined(var_0.staticdata.useweapon) && var_1) {
        thread func_11371();
      }

      self setweaponammoclip(var_0.staticdata.weapon, 1);
    }
  }

  return 0;
}

func_1613(var_0, var_1) {
  var_2 = getcurrentsuper();

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 1.0;
  }

  var_3 = gettime();

  if(var_2.var_12B2C > var_3) {
    var_2.var_12B2C = var_3;
  }

  if(var_0 && isDefined(var_2.staticdata.var_1617)) {
    func_DE3B(var_2.staticdata.var_1617 * var_1);
  } else if(isDefined(var_2.staticdata.var_1616)) {
    func_DE3B(var_2.staticdata.var_1616 * var_1);
  }

  return 1;
}

func_10DF7() {
  var_0 = getcurrentsuper();
  self notify("super_use_started");
  var_0.var_130DE = gettime();
  var_0.var_130EF = _meth_8188() * 1000.0;
  var_0.var_12B2C = gettime() + var_0.staticdata.var_12B28;
  func_112A5();
}

func_DE3B(var_0) {
  var_1 = getcurrentsuper();
  self setclientomnvar("ui_super_flash_progress", hudoutlinedisable());
  var_1.var_130EF = max(var_1.var_130EF - var_0, 0.0);
  var_1.var_1CA3 = 0;
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
  var_0 = getcurrentsuper();

  while(var_0.var_130EF > 0) {
    if(scripts\mp\utility\game::istrue(level.hostmigration)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    scripts\engine\utility::waitframe();
    var_0.var_130EF = var_0.var_130EF - 50;

    if(isbot(self)) {
      if(isDefined(var_0.staticdata.useweapon) && var_0.staticdata.var_9FF8 == 1) {
        var_1 = self getammocount(var_0.staticdata.useweapon);

        if(!isDefined(var_1) || var_1 <= 0) {
          break;
        }
      }
    }
  }

  superusefinished();
}

superusefinished(var_0, var_1, var_2) {
  var_3 = getcurrentsuper();
  var_4 = hudoutlinedisable();
  self notify("super_use_finished_lb");
  var_3.isinuse = 0;
  var_3.canstow = 0;
  var_5 = undefined;

  if(isDefined(var_3.staticdata.var_6398)) {
    if(!isDefined(var_1)) {
      var_1 = 0;
    }

    var_5 = self[[var_3.staticdata.var_6398]](var_1);
  }

  if(shouldreacttonewenemy(var_2) || scripts\mp\utility\game::istrue(var_0) || scripts\mp\utility\game::istrue(var_5)) {
    var_3.var_1391B = 1;
    func_E276(getsupermaxcooldownsec());
  } else if(scripts\mp\utility\game::istrue(var_2)) {
    var_6 = getsupermaxcooldownsec() * var_4;
    var_3.var_1391B = 1;
    func_E276(var_6);
  } else {
    if(var_3.staticdata.ref != "super_chargemode") {
      var_7 = getsubstr(self.loadoutarchetype, 10, self.loadoutarchetype.size);
      scripts\mp\missions::func_D991("ch_" + var_7 + "_super");
      combatrecordsuperuse(var_3.staticdata.ref);
    }

    var_3.var_A986 = gettime();
    var_3.var_1391B = 0;
    func_E276();
  }

  thread func_11371();
  var_8 = var_3.var_130DE - var_3.var_B143;
  scripts\mp\analyticslog::logevent_superended(var_3.staticdata.ref, var_8, 0, var_3.numkills);

  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    self getrandomweapon(0);
  }

  scripts\mp\utility\game::printgameaction("super use ended - " + var_3.staticdata.ref, self);

  if(isDefined(self.matchdatalifeindex)) {
    if(isDefined(var_1)) {
      scripts\mp\matchdata::logsuperexpiredevent(self.matchdatalifeindex, self.origin, 1);
    } else {
      scripts\mp\matchdata::logsuperexpiredevent(self.matchdatalifeindex, self.origin, 0);
    }
  }

  self notify("super_use_finished");
}

refundsuper() {
  var_0 = getcurrentsuper();

  if(isDefined(var_0)) {
    if(var_0.isinuse) {
      superusefinished(1);
    } else {
      func_DE3A(getsupermaxcooldownmsec());
    }
  }
}

handledeath() {
  self endon("disconnect");

  if(!issuperinuse()) {
    return;
  }
  superusefinished(undefined, 1);
}

func_BA37(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("super_use_finished");
  self endon("remove_super");

  for(;;) {
    self waittill("weapon_fired", var_1);
    var_2 = scripts\mp\weapons::isaltmodeweapon(var_1);
    var_1 = scripts\mp\utility\game::func_E0CF(var_1);

    if(var_1 == var_0) {
      func_1613(var_2);
    }
  }
}

func_1289E(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("death");
  scripts\mp\utility\game::_giveweapon(var_0);
  self setweaponammoclip(var_0, var_1);
  self setweaponammostock(var_0, var_2);
  var_3 = scripts\mp\utility\game::func_11383(var_0, isbot(self));

  if(var_3) {
    thread func_B2F7(var_0);
    thread func_BA37(var_0);
    return 1;
  }

  scripts\mp\utility\game::func_1529(var_0);
  return 0;
}

func_B2F7(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("super_use_finished");
  var_1 = getcurrentsuper();
  var_1.useweaponswapped = undefined;
  var_2 = 0;

  for(;;) {
    var_3 = self getcurrentweapon();

    if(!var_1.canstow && var_3 != "iw7_fistslethal_mp" && var_3 != "iw7_fistsperk_mp" && var_3 != var_0) {
      if(var_3 == "iw7_uplinkball_mp" || var_3 == "iw7_tdefball_mp") {
        var_2 = 1;
      }

      break;
    }

    scripts\engine\utility::waitframe();
  }

  if(issuperinuse()) {
    var_1.useweaponswapped = 1;
    superusefinished(undefined, undefined, var_2);
  }
}

func_11371() {
  self endon("death");
  var_0 = getcurrentsuper();
  var_1 = var_0.staticdata.useweapon;

  if(!isDefined(var_1)) {
    return;
  }
  if(scripts\mp\utility\game::isreliablyswitchingtoweapon(var_1)) {
    scripts\mp\utility\game::func_1529(var_1);
    return;
  }

  self notify("super_switched");
  scripts\mp\utility\game::forcethirdpersonwhenfollowing(var_1);
}

func_110C4() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return;
  }
  if(issupercharging()) {
    self.pers["superCooldownTime"] = getcurrentsuper().var_461F;
  } else if(issuperready()) {
    self.pers["superCooldownTime"] = getcurrentsuper().var_461E;
  } else if(issuperinuse()) {
    self.pers["superCooldownTime"] = scripts\engine\utility::ter_op(shouldreacttonewenemy(), getcurrentsuper().var_461E, 0);
  } else {
    self.pers["superCooldownTime"] = 0;
  }
}

hudoutlinedisable() {
  var_0 = getcurrentsuper();
  var_1 = gettime();
  var_2 = var_0.var_12B2C - var_0.var_130DE;
  var_3 = _meth_8188() * 1000.0 - var_2;
  var_4 = clamp(var_0.var_130EF / var_3, 0.0, 1.0);
  return var_4;
}

getsupermaxcooldownsec() {
  var_0 = getcurrentsuper().staticdata.cooldown * level.var_1125E;
  return scripts\engine\utility::ter_op(getdvarint("scr_super_short_cooldown") != 0, 1, var_0);
}

getsupermaxcooldownmsec() {
  return int(getsupermaxcooldownsec() * 1000);
}

_meth_8188() {
  return getcurrentsuper().staticdata.var_5F36;
}

issuperready() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0) || var_0.isinuse) {
    return 0;
  }

  return var_0.var_461F >= var_0.var_461E;
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
  var_0 = getcurrentsuper();

  if(!isDefined(var_0)) {
    return undefined;
  }

  return var_0.staticdata.ref;
}

shouldreacttonewenemy(var_0) {
  var_1 = getcurrentsuper();
  var_2 = var_1.staticdata._meth_8487;
  var_3 = gettime() - var_1.var_130DE;

  if(var_3 >= var_2) {
    return 0;
  }

  if(var_1.numkills > 0) {
    return 0;
  }

  if(scripts\mp\utility\game::istrue(var_1.useweaponswapped) && !scripts\mp\utility\game::istrue(var_0)) {
    if(var_1.staticdata.useweapon == "iw7_reaperblade_mp") {
      return 0;
    }
  }

  return var_1.var_1CA3;
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

func_637A(var_0) {
  scripts\mp\supers\super_reaper::func_DD97();
}

func_1304E() {
  return scripts\mp\supers\super_blackholegun::beginuse();
}

func_630F(var_0) {
  scripts\mp\supers\super_blackholegun::stopuse();
}

func_13044() {
  return scripts\mp\supers\super_armorup::func_2197();
}

func_630C(var_0) {
  scripts\mp\supers\super_armorup::func_218E(var_0);
}

func_13041() {
  return scripts\mp\supers\super_amplify::func_12F9B();
}

func_630A(var_0) {
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

func_635C(var_0) {
  scripts\mp\equipment\cloak::end(var_0);
}

func_130E2() {
  return scripts\mp\supers\super_supertrophy::func_11297();
}

func_638F(var_0) {
  return scripts\mp\supers\super_supertrophy::func_11276(var_0);
}

func_12D3F(var_0) {
  scripts\mp\supers\super_supertrophy::func_11296(var_0);
}

usephaseshift() {
  return scripts\mp\equipment\phase_shift::func_E88D();
}

func_6376(var_0) {
  scripts\mp\equipment\phase_shift::func_E154(var_0);
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

func_6364(var_0) {
  return scripts\mp\equipment\micro_turret::func_B6F9(var_0);
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

func_6313(var_0) {
  scripts\mp\equipment\charge_mode::func_3CDD(var_0);
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

_meth_8189(var_0) {
  var_0 = scripts\mp\utility\game::getweaponrootname(var_0);

  if(!isDefined(level.superweapons[var_0])) {
    return undefined;
  }

  return level.superweapons[var_0].var_11263;
}

func_7F0D(var_0) {
  var_0 = scripts\mp\utility\game::getweaponrootname(var_0);

  if(isDefined(level.superweapons[var_0])) {
    return level.superweapons[var_0].staticdata.id;
  }

  var_1 = undefined;

  switch (var_0) {
    case "micro_turret_gun_mp":
      var_1 = "super_microturret";
      break;
    case "chargemode_mp":
      var_1 = "super_chargemode";
      break;
  }

  if(isDefined(var_1)) {
    var_2 = level.var_10E4E[var_1];

    if(isDefined(var_2)) {
      return var_2.id;
    }
  }

  return undefined;
}

_meth_8186(var_0) {
  if(!isDefined(var_0) || !isDefined(level.var_10E4E[var_0]) || var_0 == "none") {
    return 0;
  }

  return level.var_10E4E[var_0].id;
}

func_7FD0(var_0) {
  var_0 = scripts\mp\utility\game::getweaponrootname(var_0);

  if(!isDefined(level.superweapons[var_0])) {
    return undefined;
  }

  return level.superweapons[var_0].staticdata.var_BCEF;
}

getrootsuperref(var_0) {
  return getsubstr(var_0, 6);
}

allowsuperweaponstow() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0) || !var_0.isinuse) {
    return;
  }
  var_0.canstow = 1;
}

unstowsuperweapon() {
  var_0 = getcurrentsuper();

  if(!isDefined(var_0) || !var_0.canstow) {
    return;
  }
  if(!var_0.isinuse || !isDefined(var_0.staticdata.useweapon)) {
    var_0.canstow = 0;
    return;
  }

  scripts\mp\utility\game::func_11383(var_0.staticdata.useweapon);
  var_0.canstow = 0;
}

modifysuperequipmentdamage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;

  if(isDefined(self.owner) && isDefined(var_0) && var_0 == self.owner) {
    var_5 = int(ceil(var_3 * 0.5));
  }

  return var_5;
}

func_13B6B() {
  level endon("super_delay_end");
  level endon("round_end");
  level endon("game_ended");
  level waittill("prematch_over");

  if(scripts\mp\utility\game::isanymlgmatch()) {
    level.var_1125A = 0;
  } else {
    level.var_1125A = getdvarfloat("scr_superDelay", 0);
  }

  if(level.var_1125A == 0) {
    level.var_1125D = scripts\mp\utility\game::gettimepassed();
    level.var_1125B = level.var_1125D;
    level notify("super_delay_end");
  }

  level.var_1125D = scripts\mp\utility\game::gettimepassed();
  level.var_1125B = level.var_1125D + level.var_1125A * 1000;
  level notify("super_delay_start");

  while(scripts\mp\utility\game::gettimepassed() < level.var_1125B) {
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
  var_0 = getcurrentsuper().staticdata.weapon;
  var_1 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
  scripts\mp\utility\game::_giveweapon(var_0);
  self setweaponammoclip(var_0, var_1);
  self assignweaponoffhandspecial(var_0);
  scripts\mp\utility\game::_takeweapon("super_delay_mp");
}

func_13B6E() {
  level endon("super_delay_end");

  if(!scripts\mp\utility\game::istrue(scripts\mp\utility\game::gameflag("prematch_done"))) {
    level waittill("super_delay_start");
  }

  for(;;) {
    self waittill("special_weapon_fired", var_0);

    if(var_0 != "super_delay_mp") {
      continue;
    }
    self setweaponammoclip("super_delay_mp", 1);

    if(issuperready()) {
      var_1 = (level.var_1125B - scripts\mp\utility\game::gettimepassed()) / 1000;
      var_1 = int(max(0, ceil(var_1)));
      scripts\mp\hud_message::showerrormessage("MP_SUPERS_UNAVAILABLE_FOR_N", var_1);
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
  scripts\mp\utility\game::_takeweapon("super_delay_mp");
}

stoprumble() {
  scripts\mp\utility\game::_giveweapon("super_delay_mp");
  self setweaponammoclip("super_delay_mp", 1);
  self assignweaponoffhandspecial("super_delay_mp");
}

cancelsuperdelay() {
  level.var_1125A = 0;
  level.var_1125D = scripts\mp\utility\game::gettimepassed();
  level.var_1125B = level.var_1125D;
  level notify("super_delay_end");
}

func_1125C() {
  if(isDefined(level.var_1125A) && level.var_1125A == 0) {
    return 1;
  }

  return isDefined(level.var_1125B) && scripts\mp\utility\game::gettimepassed() > level.var_1125B;
}

givesuperweapon(var_0) {
  if(func_1125C()) {
    if(!self hasweapon(var_0.staticdata.weapon)) {
      var_1 = scripts\engine\utility::ter_op(issuperready(), 1, 0);
      scripts\mp\utility\game::_giveweapon(var_0.staticdata.weapon);
      self setweaponammoclip(var_0.staticdata.weapon, var_1);
      self assignweaponoffhandspecial(var_0.staticdata.weapon);
    }
  } else
    stoprumble();
}

watchobjuse(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("obj_drain_end");
  self endon("ball_dropped");

  if(level.gametype == "sd" || level.gametype == "sr" || level.gametype == "dd") {
    if(scripts\mp\utility\game::istrue(var_1)) {
      self waittill("super_obj_drain");
    }
  } else if(!isDefined(self.carryobject))
    self waittill("obj_picked_up");
  else {
    wait 0.05;
  }

  while(issuperinuse()) {
    func_DE3B(var_0);
    wait 0.05;
  }
}

combatrecordsuperuse(var_0) {
  if(!scripts\mp\utility\game::canrecordcombatrecordstats()) {
    return;
  }
  var_1 = self getrankedplayerdata("mp", "superStats", var_0, "uses");
  self setrankedplayerdata("mp", "superStats", var_0, "uses", var_1 + 1);
}

combatrecordsuperkill(var_0) {
  if(!scripts\mp\utility\game::canrecordcombatrecordstats()) {
    return;
  }
  var_1 = self getrankedplayerdata("mp", "superStats", var_0, "kills");
  self setrankedplayerdata("mp", "superStats", var_0, "kills", var_1 + 1);
}

superdisabledinarbitraryup(var_0) {
  if(var_0 == "super_microturret" || var_0 == "super_supertrophy") {
    return 1;
  }

  return 0;
}

superdisabledinarbitraryupmessage() {
  scripts\mp\hud_message::showerrormessage("MP_SUPERS_UNAVAILABLE_ARB_UP");
}

superdisabledduringkillstreak(var_0) {
  switch (var_0) {
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