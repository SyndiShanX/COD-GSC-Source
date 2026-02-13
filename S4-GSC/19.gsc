/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 19.gsc
*************************************************/

_id_1D94(var_0) {
  return _func_0222("mp/attachmenttable.csv", 4, var_0, 2);
}

init() {
  level._id_CBA3 = 1;
  level._id_CBA5 = 1;
  level._id_9C90 = max(scripts\mp\utility\dvars::_id_6AC8("#x3f9d04b9bab7c46c5", 2), 1);
  level._id_C88E = scripts\mp\utility\dvars::_id_6AC8("#x3f611e9360b26cda3", 15);
  _func_004D("DogsDontAttack");
  _func_004D("Dogs");
  _func_004D("DogsAttack");
  _func_01DB("DogsDontAttack", "Dogs");

  switch (scripts\mp\utility\dvars::_id_6AC8("#x3f8f26f7dde557c04", 0)) {
    case 1:
      level._id_CBA3 = 0;
      break;
    case 2:
      level._id_CBA5 = 0;
      break;
    case 3:
      level._id_CBA3 = 0;
      level._id_CBA5 = 0;
      break;
  }

  _id_2D18();
  _id_2CFD();
  level._effect["emp_stun"] = loadfx("vfx/core/mp/equipment/vfx_emp_grenade");
  level._effect["equipment_explode"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["equipment_sparks"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["glsmoke"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_smoke_gren_ch");
  level._effect["vfx_dismember"] = loadfx("vfx/s4/weapon/_impact/flesh/vfx_imp_flesh_dismember.vfx");
  scripts\mp\utility\entity::_id_B166();
  level._id_10D6F = [];

  if(!isDefined(level._id_10D7D)) {
    level._id_10D7D = ::_id_5075;
  }

  var_0 = 25;
  level._id_E841 = cos(var_0);
  level._id_E843 = 15;
  level._id_E842 = 0.35;
  level._id_E844 = 256;
  level._id_9ED7 = 0.3;
  level._id_BCCB = [];
  level._id_DD14 = [];
  level._id_713A = [];
  level._id_9F55 = [];
  level._id_84FD = [];
  level._id_9EE2 = [];
  _id_0AA3::_id_C28D(::onplayerspawned);
  level thread onplayerconnect();
  scripts\mp\utility\outline::_id_824E();
  _id_7F8D();

  if(getdvarint("#x3155ed9afd83eb598") == 1) {
    level thread _id_CB50();
  }
}

_id_CB50() {
  for(;;) {
    if(isDefined(level.players)) {
      foreach(var_1 in level.players) {
        if(!isDefined(var_1)) {
          continue;
        }
        if(var_1 scripts\mp\utility\perk::_hasperk("specialty_scrap_weapons")) {
          var_2 = var_1 getcurrentweapon();
          var_1 getcurrentweapon();

          if(!isDefined(var_2)) {
            continue;
          }
          if(!isDefined(var_1._id_711D)) {
            var_1._id_711D = spawnStruct();
            var_1._id_711D = spawnStruct();
            var_1._id_711D = spawnStruct();
          }

          if(isDefined(var_1._id_711D._id_0133) && var_1._id_711D._id_0133._id_04F6.basename != "none" && var_1._id_711D._id_0133._id_04F6 != var_2) {
            var_1._id_711D._id_90C6 = var_1._id_711D._id_0133;
            var_1._id_711D._id_0133 = spawnStruct();
          }

          var_1._id_711D._id_0133 = spawnStruct();
          var_1._id_711D._id_0133._id_04F6 = var_2;
          var_1._id_711D._id_0133._id_C85D = var_1 getweaponammoclip(var_2, "right");
          var_1._id_711D._id_0133._id_9196 = var_1 getweaponammoclip(var_2, "left");
          var_1._id_711D._id_0133._id_E868 = var_1 getweaponammostock(var_2);
          continue;
        }

        var_1._id_711D = undefined;
      }
    }

    waitframe();
  }
}

_id_5272(var_0) {
  self _meth_81AE(var_0);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_79B5 = 0;
    scripts\mp\gamelogic::_id_D58D(var_0, 0);
    var_0 thread _id_10BAE();
  }
}

_id_10AAF() {
  self endon("death_or_disconnect");
  self endon("joined_spectators");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    if(!isbot(self)) {
      self setscriptablepartstate("bayoConfig", self._id_AC3D.bayovoice, 1);
    }

    var_0 = self getcurrentweapon();

    if(isDefined(var_0)) {
      _id_4C48(var_0);
    }

    self waittill("weapon_change");
  }
}

_id_4C48(var_0) {
  _id_FC24(var_0, self._id_90CB);
  _id_FD91(var_0);
  updateweaponusetime();
  _id_FCA1(var_0);
  _id_FCA2();
  _id_FD2E(var_0);
  _id_FD8E();
  _id_0A6B::_id_FC4E();
  _id_07CE::_id_FD89();
  scripts\mp\class::_id_C88B(var_0);
  _id_0A6B::_id_FD8A();
}

_id_FD8E() {
  self._id_BC6C = _id_4EAB(self._id_BC6C);
}

_id_FD2E(var_0) {
  if(_id_DFB2(var_0)) {
    childthread _id_DFB0();
  }
}

_id_FC54(var_0) {
  self notify("end_dragBreath");

  if(scripts\mp\utility\weapon::getweapongroup(var_0) == "weapon_shotgun" || var_0 _meth_8624("ammo_incendiary", 1)) {
    if(_id_078C::_id_880F(var_0)) {
      thread _id_078C::_id_8185(var_0);
    }
  }
}

_id_FCA2() {
  var_0 = self getcurrentweapon();

  switch (var_0.basename) {
    default:
      break;
    case "s4_mr_ptango41_mp":
      thread scripts\cp_mp\ptango41::initusage();
      break;
  }

  self notify("end_launcher");

  if(scripts\mp\utility\perk::_hasperk("specialty_fastreload_launchers")) {
    var_1 = weaponclass(var_0.basename) == "rocketlauncher";

    if(var_1 && !istrue(self._id_59BE)) {
      scripts\mp\utility\perk::_id_6FC2("specialty_fastreload");
      self._id_59BE = 1;
    } else if(istrue(self._id_59BE)) {
      scripts\mp\utility\perk::removeperk("specialty_fastreload");
      self._id_59BE = undefined;
    }
  }

  switch (var_0.basename) {
    default:
      break;
    case "s4_mr_ptango41_mp":
      thread scripts\cp_mp\ptango41::usageloop(var_0);
      break;
  }
}

updateweaponusetime() {
  if(isDefined(self._id_90CB)) {
    if(!scripts\mp\utility\weapon::_id_897E(self._id_90CB)) {
      var_0 = self._id_90CB.basename;
      var_1 = _func_00D6(var_0, 0, 3);

      if(var_1 == "iw8" || var_1 == "s4_") {
        var_0 = scripts\mp\utility\weapon::getweaponrootname(self._id_90CB);
      }

      var_2 = _id_06E2::get_time_from_match_start(gettime()) / 1000;

      if(!isDefined(self.currentweaponstarttime)) {
        self.currentweaponstarttime = 0;
      }

      var_3 = var_2 - self.currentweaponstarttime;
      var_4 = spawnStruct();
      var_4._id_04FE = var_0;
      var_4.statname = "timeUsed";
      var_4.incvalue = var_3;
      var_4._id_04CC = _func_02F7(self._id_90CB);
      _id_06E2::_id_4C2A("callback_update_weapon_stats", var_4);
      self.currentweaponstarttime = var_2;
    }
  }
}

_id_FCA1(var_0) {
  var_1 = var_0 _meth_8628();

  if(isnullweapon(var_1)) {
    var_1 = var_0;
  }

  self._id_90CB = var_0;

  if(_id_894F(var_0)) {
    self._id_9021 = var_0;
  }

  if(_id_8813(var_1)) {
    self._id_8FC2 = var_1;
  }

  if(scripts\mp\utility\weapon::_id_8799(var_0)) {
    self._id_8F9F = var_0;
  }
}

_id_FD91(var_0) {
  if(var_0.basename == "none") {
    return;
  } else if(scripts\mp\utility\weapon::_id_8A7D(var_0.basename)) {
    _id_FCCC();
    return;
  } else if(scripts\mp\utility\weapon::_id_88F6(var_0.basename))
    return;
  else if(var_0._id_0241 != "primary" && var_0._id_0241 != "altmode") {
    return;
  }
  _id_FCCC();
}

onplayerspawned() {
  self._id_79B5 = 0;
  scripts\mp\gamelogic::_id_D58D(self, 0);

  if(!isDefined(self._id_F40F)) {
    self._id_F40F = _func_0375();
    self._id_F414 = 0;
    self._id_F413 = 0;
    self._id_F412 = 0;
    self._id_F411 = 0;
    self._id_F410 = 0;
  }

  if(!isDefined(self._id_B1CE)) {
    self._id_B1CE = [];
  }

  if(!isDefined(self._id_B1D0)) {
    self._id_B1D0 = [];
  }

  if(!isDefined(self._id_B1CF)) {
    self._id_B1CF = [];
  }

  if(!isDefined(self._id_B1CC)) {
    self._id_B1CC = [];
  }

  self._id_BC6C = undefined;
  thread _id_10AAF();
  thread _id_10C32();
  thread _id_10B75();
  thread _id_10ADD();
  thread _id_10C00();
  thread _id_10BFD();

  if(!scripts\mp\utility\game::_id_CA4B()) {
    thread _id_10AD3();
  }

  self._id_8FF1 = [];
  self._id_5046 = undefined;
  self._id_F33C = [];
  self._id_9021 = scripts\engine\utility::ter_op(isDefined(self._id_E3A8), self._id_E3A8, _func_0375());
  self._id_90CB = scripts\engine\utility::ter_op(isDefined(self._id_E3A8), self._id_E3A8, _func_0375());
  self._id_8FC2 = scripts\engine\utility::ter_op(isDefined(self._id_E3A8), self._id_E3A8, _func_0375());
  self._id_8F9F = scripts\engine\utility::ter_op(isDefined(self._id_E3A8) && scripts\mp\utility\weapon::_id_8799(self._id_E3A8), self._id_E3A8, _func_0375());
  scripts\mp\gamescore::_id_8142();
  _id_392A();
  thread _id_CA28(self getcurrentweapon());
}

_id_CB3F() {
  self.pers["altStates"] = [];
  var_0 = self._id_034A;

  foreach(var_2 in var_0) {
    if(!_func_0376(self.primaryweaponobj) && var_2 == self.primaryweaponobj || !_func_0376(self.secondaryweaponobj) && var_2 == self.secondaryweaponobj) {
      if(_id_DC12(var_2) && self _meth_8543(var_2, 1)) {
        var_3 = scripts\mp\utility\weapon::_id_6981(var_2);
        self.pers["altStates"][var_3] = 1;
      }
    }
  }
}

_id_CB54() {
  self.pers["toggleScopeStates"] = [];
  var_0 = self._id_034A;

  foreach(var_2 in var_0) {
    if(!_func_0376(self.primaryweaponobj) && var_2 == self.primaryweaponobj || !_func_0376(self.secondaryweaponobj) && var_2 == self.secondaryweaponobj) {
      if(isDefined(var_2._id_0389) && _id_8AA4(var_2._id_0389)) {
        var_3 = scripts\mp\utility\weapon::_id_6981(var_2);
        self.pers["toggleScopeStates"][var_3] = self _meth_813C(var_2);
      }
    }
  }
}

_id_FD69(var_0) {
  var_1 = scripts\mp\utility\weapon::_id_6981(var_0);

  if(isDefined(self.pers["toggleScopeStates"]) && isDefined(self.pers["toggleScopeStates"][var_1])) {
    self _meth_832F(var_0, self.pers["toggleScopeStates"][var_1]);
  }
}

_id_FD15(var_0) {
  if(isDefined(self.pers["altStates"]) && istrue(var_0._id_0216)) {
    var_1 = scripts\mp\utility\weapon::_id_6981(var_0);

    if(isDefined(self.pers["altStates"][var_1]) && self.pers["altStates"][var_1]) {
      var_0 = var_0 getaltweapon();
    }
  }

  return var_0;
}

_id_8AA4(var_0) {
  var_1 = scripts\mp\utility\weapon::_id_1DA5(var_0);

  switch (var_1) {
    case "hybrid3light":
    case "hybrid2light":
    case "hybridlight":
    case "hybrid4":
    case "hybrid3":
    case "hybrid2":
    case "hybrid":
      return 1;
    default:
      return 0;
  }
}

_id_DC12(var_0) {
  if(istrue(var_0._id_0216)) {
    if(_id_DAFF(var_0._id_04B7)) {
      return 1;
    }
  }

  return 0;
}

_id_DAFF(var_0) {
  return _id_876C(var_0);
}

_id_876C(var_0) {
  var_1 = scripts\mp\utility\weapon::_id_1DA5(var_0);

  switch (var_1) {
    case "selectauto":
    case "selectburst":
    case "selectsemi":
      return 1;
    default:
      return 0;
  }
}

_id_876B(var_0) {
  var_1 = scripts\mp\utility\weapon::_id_1DA5(var_0);

  switch (var_1) {
    case "glsnap":
    case "glsemtex":
    case "glincendiary":
    case "glflash":
    case "glconc":
    case "glgas":
    case "glsmoke":
    case "gl":
      return 1;
    default:
      return 0;
  }
}

_id_10DBE(var_0, var_1) {
  if(!_func_0376(var_1)) {
    var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);
    var_3 = scripts\mp\utility\weapon::_id_10DBD(var_2);

    if(isDefined(var_3)) {
      scripts\mp\utility\perk::removeperk(var_3);
    }
  }

  if(!_func_0376(var_0)) {
    var_4 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);
    var_5 = scripts\mp\utility\weapon::_id_10DBD(var_4);

    if(isDefined(var_5)) {
      scripts\mp\utility\perk::_id_6FC2(var_5);
    }
  }
}

_id_10D63(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(!_func_0376(var_1)) {
    var_3 = getweaponattachments(var_1);

    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_5 in var_3) {
        var_6 = scripts\mp\utility\weapon::_id_1DAD(var_5);

        if(!isDefined(var_6)) {
          continue;
        }
        scripts\mp\utility\perk::removeperk(var_6);
      }
    }
  }

  if(!_func_0376(var_0)) {
    var_2 = getweaponattachments(var_0);

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_9 in var_2) {
        var_6 = scripts\mp\utility\weapon::_id_1DAD(var_9);

        if(!isDefined(var_6)) {
          continue;
        }
        scripts\mp\utility\perk::_id_6FC2(var_6);
      }
    }
  }
}

_id_4EAB(var_0) {
  var_1 = self getcurrentweapon();
  _id_10D63(var_1, var_0);
  _id_10DBE(var_1, var_0);
  return var_1;
}

_id_10C2E() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("giveLoadout_start");
  var_0 = undefined;

  for(;;) {
    var_0 = _id_4EAB(var_0);
    self waittill("weapon_change");
  }
}

_id_10BFD() {
  self endon("death_or_disconnect");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(_id_DFB2(var_0)) {
      childthread _id_DFB0();
    }

    self waittill("weapon_change");
  }
}

_id_DFAA(var_0) {
  return scripts\mp\utility\weapon::weaponhasattachment(var_0, "scope") && !issubstr(var_0.basename, "alpha50") && !issubstr(var_0.basename, "mike14");
}

_id_DFB2(var_0) {
  if(isnullweapon(var_0) || !isDefined(var_0._id_0389) || weaponclass(var_0) == "rocketlauncher" || weaponclass(var_0) == "smg") {
    return 0;
  }

  var_1 = scripts\mp\utility\weapon::_id_1DA5(var_0._id_0389);

  switch (var_1) {
    case "vzscope":
    case "scopelight":
    case "scopenorail":
    case "scope":
      return 1;
  }

  return 0;
}

_id_DFB0() {
  self notify("manageSniperGlint");
  self endon("manageSniperGlint");
  self endon("weapon_change");
  waitframe();
  thread _id_DFAF();
  self._id_7037 = 0;

  if(self._id_0133 _meth_8624("gunperk_shrouded")) {
    var_0 = 0.95;
  } else {
    var_0 = 0.5;
  }

  for(;;) {
    if(self playerads() > var_0) {
      if(!self._id_7037) {
        _id_DFAE();
      }
    } else if(self._id_7037)
      _id_DFB1();

    waitframe();
  }
}

_id_DFAF() {
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "weapon_change");

  if(isDefined(self._id_7037) && self._id_7037) {
    _id_DFB1();
    self._id_7037 = undefined;
  }
}

_id_DFAE() {
  var_0 = self _meth_86EB();

  if(self._id_0133 _meth_8624("gunperk_shrouded")) {
    self setscriptablepartstate("sniperGlint", "sniperGlintOn_narrow", 0);
  } else {
    self setscriptablepartstate("sniperGlint", "sniperGlintOn", 0);
  }

  self._id_7037 = 1;
}

_id_DFB1() {
  if(isDefined(self)) {
    self setscriptablepartstate("sniperGlint", "sniperGlintOff", 0);
    self._id_7037 = 0;
  }
}

_id_DFA7(var_0) {
  self endon("weapon_change");
  self._id_DFAB = 0;

  for(;;) {
    if(self playerads() > 0.65 && !self._id_DFAB) {
      thread _id_DFA8(var_0);
    } else if(self playerads() <= 0.65) {
      _id_DFA9();
    }

    waitframe();
  }
}

_id_DFA8(var_0) {
  self notify("sniperBlurReset");
  self endon("sniperBlurReset");
  self._id_DFAB = 1;
  self _meth_82EE(25, 0.1);
  wait 0.1;
  self _meth_82EE(0, _id_6D37(var_0));
}

_id_DFA9() {
  self notify("sniperBlurReset");
  self _meth_82EE(0, 0);
  self._id_DFAB = 0;
}

_id_6D37(var_0) {
  var_1 = 0.3;

  switch (var_0.basename) {
    default:
      break;
  }

  return var_1;
}

_id_10BFB() {
  self endon("death_or_disconnect");
  thread _id_10BFC();

  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

  for(;;) {
    self waittill("got_a_kill", var_0, var_1, var_2);
    var_3 = makeweaponfromstring(var_1);

    if(_id_89F0(var_3)) {
      var_4 = self.pers["recoilReduceKills"] + 1;
      self.pers["recoilReduceKills"] = int(min(var_4, 4));
      self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

      if(var_4 <= 4) {
        _id_E583(self getstance());
      }
    }
  }
}

_id_10BFC() {
  self notify("watchSniperBoltActionKills_onDeath");
  self endon("watchSniperBoltActionKills_onDeath");
  self endon("disconnect");
  self waittill("death");
  self.pers["recoilReduceKills"] = 0;
}

_id_89F0(var_0) {
  if(!isDefined(var_0) || isnullweapon(var_0)) {
    return 0;
  }

  var_1 = 0;

  if(var_0 _meth_8624("l115a3scope", 1) || var_0 _meth_8624("l115a3vzscope", 1) || var_0 _meth_8624("usrscope", 1) || var_0 _meth_8624("usrvzscope", 1)) {
    var_1 = 1;
  }

  return var_1;
}

_id_6CE6() {
  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  return self.pers["recoilReduceKills"] * 3;
}

_id_888D(var_0) {
  if(var_0 == "radar_mp" || var_0 == "airstrike_mp" || var_0 == "helicopter_mp") {
    return 1;
  }

  if(var_0 == "briefcase_bomb_mp" || var_0 == "s4_bomb_remote_mp" || var_0 == "s4_bomb_remote_holiday_mp" || var_0 == "s4_bomb_remote_vday_mp") {
    return 1;
  }

  return 0;
}

_id_885E(var_0) {
  var_0 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  return 0;
}

_id_8786(var_0) {
  return var_0 == "briefcase_bomb_mp" || var_0 == "briefcase_bomb_defuse_mp" || var_0 == "briefcase_silent_mp" || var_0 == "briefcase_defuse_silent_mp" || var_0 == "s4_bomb_remote_mp" || var_0 == "s4_bomb_remote_silent_mp" || var_0 == "s4_remote_bomb_defuse_mp" || var_0 == "s4_remote_bomb_defuse_silent_mp" || var_0 == "s4_bomb_remote_holiday_mp" || var_0 == "s4_bomb_remote_silent_holiday_mp" || var_0 == "s4_remote_bomb_defuse_holiday_mp" || var_0 == "s4_remote_bomb_defuse_silent_holiday_mp" || var_0 == "s4_remote_bomb_defuse_vday_mp" || var_0 == "s4_bomb_remote_silent_vday_mp" || var_0 == "s4_remote_bomb_defuse_silent_vday_mp" || var_0 == "s4_bomb_remote_vday_mp";
}

_id_5075(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_25A8)) {
    return;
  }
  if(isDefined(self._id_5046)) {
    return;
  }
  if(isDefined(self.reactivecamoweapons)) {
    foreach(var_5 in self.reactivecamoweapons) {
      if(var_5.resetondeath) {
        var_5.stage = 0;
        var_5._id_0267 = 0;
      }
    }
  }

  if(isDefined(var_0) && var_0 == self || var_1 == "MOD_SUICIDE") {
    return;
  }
  var_7 = self._id_8FC2;

  if(isDefined(var_2)) {
    var_7 = var_2;
  }

  if(!isDefined(var_7)) {
    return;
  }
  if(var_7.basename == "none") {
    return;
  }
  if(!self hasweapon(var_7)) {
    return;
  }
  if(isDefined(level._id_60D0) && !self[[level._id_60D0]](var_7)) {
    return;
  }
  var_7 = var_7 _meth_8628();
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;

  if(!_id_080B::_id_8A09(var_7.basename)) {
    if(!self _meth_801D(var_7)) {
      return;
    }
    if(isbot(self) && scripts\mp\utility\game::isbasegametype()) {
      return;
    }
    var_8 = self getweaponammoclip(var_7, "right");
    var_9 = self getweaponammoclip(var_7, "left");

    if(!var_8 && !var_9) {
      return;
    }
    var_10 = self getweaponammostock(var_7);
    var_11 = weaponmaxammo(var_7);

    if(var_10 > var_11) {
      var_10 = var_11;
    }

    var_12 = self dropitem(var_7);

    if(!isDefined(var_12)) {
      return;
    }
    if(istrue(level._id_3985)) {
      var_10 = 0;
    }

    var_12 _meth_81F6(var_8, var_10, var_9);

    if(var_1 != "MOD_EXECUTION") {
      thread scripts\cp_mp\utility\weapon_utility::_id_5076(var_12, var_3, self.angles);
    }
  } else {
    var_12 = self dropitem(var_7);

    if(!isDefined(var_12)) {
      return;
    }
    var_12 _meth_81F6(1, 1, 0);
  }

  var_12 _meth_84D4(160);
  var_12 setuserange(160);
  self._id_5046 = 1;
  var_12.owner = self;
  var_12._id_0481 = "dropped_weapon";
  var_12.objweapon = var_7;
  var_12 thread _id_10BCF();
  var_12 thread _id_4783();
}

_id_5E97(var_0) {
  if(isDefined(level._id_25A8)) {
    return 0;
  }

  if(isDefined(self._id_5046)) {
    return 0;
  }

  var_1 = self._id_8FC2;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(var_1.basename == "none") {
    return 0;
  }

  if(!self hasweapon(var_1)) {
    return -1;
  }

  if(isDefined(level._id_60D0) && !self[[level._id_60D0]](var_1)) {
    return 0;
  }

  var_1 = var_1 _meth_8628();
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  if(!_id_080B::_id_8A09(var_1.basename)) {
    if(!self _meth_801D(var_1)) {
      return 0;
    }

    var_2 = self getweaponammoclip(var_1, "right");
    var_3 = self getweaponammoclip(var_1, "left");

    if(!var_2 && !var_3) {
      return 0;
    }

    var_4 = self getweaponammostock(var_1);
    var_5 = weaponmaxammo(var_1);

    if(var_4 > var_5) {
      var_4 = var_5;
    }

    var_6 = self dropitem(var_1);

    if(!isDefined(var_6)) {
      return 0;
    }

    if(istrue(level._id_3985)) {
      var_4 = 0;
    }

    var_6 _meth_81F6(var_2, var_4, var_3);
  } else {
    var_6 = self dropitem(var_1);

    if(!isDefined(var_6)) {
      return 0;
    }

    var_6 _meth_81F6(1, 1, 0);
  }

  var_6 _meth_84D4(160);
  var_6 setuserange(160);
  var_6.owner = self;
  var_6._id_0481 = "dropped_weapon";
  var_6.objweapon = var_1;
  var_6 thread _id_10BCF();
  var_6 thread _id_4783();
  return 1;
}

_id_488D(var_0, var_1) {
  var_2 = self _meth_8117();

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = self _meth_8115(var_3);

    if(var_4 != var_0) {
      continue;
    }
    var_5 = self _meth_8118(var_3);
    self detach(var_0, var_5);

    if(var_5 != var_1) {
      var_2 = self _meth_8117();

      for(var_3 = 0; var_3 < var_2; var_3++) {
        var_5 = self _meth_8118(var_3);

        if(var_5 != var_1) {
          continue;
        }
        var_0 = self _meth_8115(var_3);
        self detach(var_0, var_5);
        break;
      }
    }

    return 1;
  }

  return 0;
}

_id_4783() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

_id_6AD0() {
  var_0 = self.classname;
  var_1 = _func_00D6(var_0, 7);
  return var_1;
}

_id_10BCF() {
  self endon("death");
  var_0 = _id_6AD0();

  for(;;) {
    self waittill("trigger", var_1, var_2);
    var_3 = undefined;
    var_4 = isDefined(level._id_429C) && isDefined(level._id_429C._id_32D5) && level._id_429C._id_32D5 == var_1;
    var_5 = scripts\mp\utility\game::getgametype() == "cyber" && (isDefined(var_2) || var_4);

    if(var_5) {
      var_6 = var_1 scripts\cp_mp\utility\inventory_utility::_id_69A9();

      if(var_6.size > 2) {
        var_7 = 0;
        var_8 = 0;

        foreach(var_10 in var_6) {
          if(var_10.basename == "iw8_cyberemp_mp") {
            var_7 = 1;
          }

          if(var_10.basename == "s4_knifestab_mp") {
            var_8 = 1;
          }
        }

        var_12 = undefined;

        if(isDefined(var_1._id_034C) && var_1._id_034C != "iw8_cyberemp_mp") {
          var_3 = var_1._id_034C;
          var_12 = var_1.primaryweaponobj;
        } else if(isDefined(var_1._id_03B5) && var_1._id_03B5 != "iw8_cyberemp_mp") {
          var_3 = var_1._id_03B5;
          var_12 = var_1.secondaryweaponobj;
        }

        var_13 = var_6.size;

        if(var_8) {
          var_13--;
        }

        if(!var_7 || var_13 > 3) {
          var_14 = undefined;

          if(var_12.basename != "none") {
            var_14 = var_12;
          }

          var_15 = var_1 _id_5E97(var_14);

          if(var_4) {
            var_1 scripts\common\utility::_id_1593(0);
            var_1 scripts\common\utility::_id_1591(0);
            var_1 scripts\common\utility::_id_158A(0);
            var_1 thread _id_10869(var_15 == 0);
          }

          if(var_15 == 1) {} else if(var_15 == 0) {
            if(var_4) {
              var_1 scripts\common\utility::_id_158A(1);
              var_1 scripts\common\utility::_id_1593(1);
              var_1 scripts\common\utility::_id_1591(1);
            }

            return;
          } else if(var_15 == -1) {}
        }
      } else if(var_4) {
        var_1 scripts\common\utility::_id_1593(0);
        var_1 scripts\common\utility::_id_1591(0);
        var_1 scripts\common\utility::_id_158A(0);
        var_1 thread _id_10869();
      } else if(isDefined(var_2))
        var_3 = var_1._id_8FC2;
      else {
        var_3 = var_1 getcurrentweapon();
      }
    } else if(isDefined(var_2))
      var_3 = var_1._id_8FC2;
    else {
      var_3 = var_1 getcurrentweapon();
    }

    var_16 = var_1 scripts\mp\utility\perk::_hasperk("specialty_scrap_weapons") && getdvarint("#x3155ed9afd83eb598") == 1;
    var_1 thread _id_10BD0(self.objweapon, var_3, var_16);

    if(isDefined(self.reactivecamoindex) && isDefined(var_2)) {
      var_1 reactivecamoinittostage(self.objweapon, self.reactivecamoindex, self.owner);
    }

    if(isDefined(var_2)) {
      var_1 notify("weapon_pickup", self.objweapon);
      var_17 = scripts\mp\utility\weapon::getweaponfullname(var_3) == var_1._id_03B5;
      var_1 _meth_80C9(var_17, self.objweapon);
      var_1._id_90CC = gettime();
      var_1 scripts\mp\utility\stats::_id_7DAE("weaponPickups", 1);
      var_1 thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_000");
      var_1 _id_07BC::createmisceventchallengeevent("weaponPickup", 1);
    }

    var_18 = _id_5BFC(var_1, var_0);

    if(isDefined(var_2) && var_16) {
      var_2 delete();
    }

    if(isDefined(var_2) || var_18) {
      break;
    }
  }

  if(isDefined(var_2)) {
    var_19 = var_2 _id_6AD0();
    var_20 = makeweaponfromstring(var_19);

    if(isDefined(var_1._id_F33C[var_19])) {
      var_2.owner = var_1._id_F33C[var_19];
      var_1._id_F33C[var_19] = undefined;
    }

    var_2.objweapon = var_20;
    var_2._id_0481 = "dropped_weapon";
    var_2 thread _id_10BCF();
  }

  var_1._id_F33C[var_0] = self.owner;
}

_id_10869(var_0) {
  self endon("death_or_disconnect");
  self notify("cancelGiveEmp");
  self endon("cancelGiveEmp");

  while(isDefined(self._id_0133.basename) && self._id_0133.basename == "none") {
    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_cyberemp_mp");

  if(!istrue(var_0)) {
    scripts\common\utility::_id_158A(1);
    scripts\common\utility::_id_1593(1);
    scripts\common\utility::_id_1591(1);
  }
}

_id_10BD0(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  var_3 = self._id_0133;
  var_4 = 0;

  if(var_3 == var_0) {
    var_4 = 1;
  } else {
    for(;;) {
      waitframe();
      var_5 = self._id_0133;

      if(issameweapon(var_3, var_5, 0)) {
        continue;
      }
      if(issameweapon(var_0, var_5, 0)) {
        var_4 = 1;
      } else {
        var_4 = 0;
      }

      break;
    }
  }

  if(var_4) {
    if(var_0.basename == "s4_gw_flima35_mp") {
      _id_0A50::_id_8C85(var_0, var_1);
    }

    thread _id_A6B8();

    if(isDefined(level._id_ABDB)) {
      [[level._id_ABDB]](var_0);
    } else if(var_2) {
      thread _id_FE74(var_0, var_1);
    }
  }
}

_id_FE74(var_0, var_1) {
  if(isDefined(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    var_2 = var_1;
    var_3 = getrandomgraverobberattachment(var_1);

    if(isDefined(var_3)) {
      var_4 = getweaponattachments(var_1);

      foreach(var_7, var_6 in var_4) {
        if(!scripts\mp\utility\weapon::_id_1DB1(var_6, var_3)) {
          var_4[var_7] = undefined;
        }
      }

      var_4 = scripts\engine\utility::_id_1BD1(var_4);
      var_4[var_4.size] = var_3;
      var_2 = var_1 _meth_866B(var_4);
    }

    var_8 = scripts\mp\utility\weapon::getweaponfullname(var_2);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
    self _meth_84A1(var_8);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_8);
    _id_5BFC(self, var_8);
    self setweaponammoclip(var_2, self._id_711D._id_90C6._id_C85D, "right");
    self setweaponammoclip(var_2, self._id_711D._id_90C6._id_9196, "left");
    self setweaponammostock(var_2, self._id_711D._id_90C6._id_E868);
    var_9 = self getweaponslistprimaries();

    foreach(var_11 in var_9) {
      _id_1126(self, var_11, 0.5);
    }

    if(isDefined(var_3)) {
      wait 0.05;
      var_4 = getweaponattachments(var_2);
      var_13 = scripts\engine\utility::_id_1BAB(var_4, var_3);

      if(!isDefined(var_13)) {
        var_13 = 0;
      }

      self setclientomnvar("ui_weapon_pickup", var_13 + 1);
      self playlocalsound("attachment_pickup");
    }
  }
}

getrandomgraverobberattachment(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_3 = getweaponattachments(var_0);
  var_4 = [];

  if(isDefined(var_1) && var_1.size > 0) {
    var_4 = var_1;
  } else {
    var_4 = scripts\mp\utility\weapon::_id_68AC(var_2);
  }

  if(!isDefined(var_4)) {
    return undefined;
  }

  foreach(var_8, var_6 in var_3) {
    var_7 = scripts\mp\utility\weapon::_id_1DA5(var_6);

    if(!scripts\mp\utility\weapon::_id_1D9B(var_0, var_7)) {
      var_3[var_8] = undefined;
      continue;
    }
  }

  var_4 = scripts\engine\utility::_id_1BA2(var_4);
  var_4 = scripts\engine\utility::array_randomize(var_4);

  foreach(var_10 in var_4) {
    if(!_id_887F(var_2, var_10)) {
      continue;
    }
    var_11 = 0;

    foreach(var_6 in var_3) {
      if(scripts\mp\utility\weapon::_id_1DB2(var_6, var_10, var_0) != "") {
        var_11 = 1;
        break;
      }
    }

    if(var_11) {
      continue;
    }
    return var_10;
  }

  return undefined;
}

addattachmenttoweapon(var_0, var_1) {
  var_2 = _func_02F7(var_0);
  var_0 = var_0 _meth_8628();
  var_3 = var_0._id_0071;
  var_4 = [];
  var_5 = [];

  foreach(var_9, var_7 in var_3) {
    var_8 = scripts\mp\utility\weapon::_id_1DA5(var_9);
    var_5[var_5.size] = var_8;
    var_4[var_8] = var_7;
  }

  var_10 = 0;

  if(scripts\engine\utility::array_contains(var_5, var_1)) {
    var_10 = 1;
  } else {
    var_11 = scripts\mp\utility\weapon::_id_1DA9(var_1, var_0);

    if(!var_0 _meth_8629(var_11)) {
      var_10 = 1;
    }
  }

  if(var_10) {
    return undefined;
  }

  var_5 = scripts\mp\utility\weapon::_id_10D65(var_5);
  var_12 = [];

  foreach(var_14, var_9 in var_5) {
    var_12[var_14] = var_4[var_9];
  }

  var_5[var_5.size] = var_1;
  var_12[var_12.size] = 0;
  var_15 = var_0._id_00D2;
  var_16 = [];

  if(isDefined(var_0._id_0409)) {
    var_16[var_16.size] = var_0._id_0409;
  }

  if(isDefined(var_0._id_040A)) {
    var_16[var_16.size] = var_0._id_040A;
  }

  if(isDefined(var_0._id_040B)) {
    var_16[var_16.size] = var_0._id_040B;
  }

  if(isDefined(var_0._id_040C)) {
    var_16[var_16.size] = var_0._id_040C;
  }

  var_17 = scripts\cp_mp\utility\game_utility::isnightmap();
  var_0 = scripts\mp\class::buildweapon(scripts\mp\utility\weapon::getweaponrootname(var_0), var_5, var_15, "none", var_2, var_12, undefined, var_16, var_17);
  return var_0;
}

_id_68BB(var_0) {
  var_1 = var_0 _meth_8625();
  var_2 = weaponclipsize(var_1);
  var_3 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_4 = 125;

  if(var_0._id_0245) {
    var_5 = scripts\mp\utility\weapon::_id_1DA5(var_0._id_04B7);

    switch (var_5) {
      case "glsnap":
      case "glsemtex":
      case "glincendiary":
      case "glflash":
      case "glconc":
      case "glgas":
      case "glsmoke":
      case "gl":
        var_4 = 1;
        break;
      case "ubshtgn":
        var_4 = 999;
        break;
      default:
        var_4 = 0;
        break;
    }
  } else {
    switch (var_0.classname) {
      case "spread":
        switch (var_3) {
          default:
            var_4 = int(min(var_2, 125));
            break;
        }

        break;
      case "sniper":
        switch (var_3) {
          default:
            var_4 = int(min(var_2, 125));
            break;
        }

        break;
      default:
        var_4 = int(min(var_2, 125));
    }
  }

  return var_4;
}

_id_887F(var_0, var_1) {
  if(!scripts\mp\utility\weapon::_id_1D9B(var_0, var_1)) {
    return 0;
  }

  switch (var_1) {
    case "laserRange":
    case "laserbalanced":
    case "akimbo":
      return 0;
  }

  if(issubstr(var_1, "thermal")) {
    return 0;
  }

  if(issubstr(var_1, "burst")) {
    return 0;
  }

  if(_func_00D6(var_1, 0, 3) == "cal") {
    return 0;
  }

  return 1;
}

_id_A6B8() {}

_id_5BFC(var_0, var_1) {
  var_2 = var_0 getweaponslistprimaries();
  var_3 = 1;
  var_4 = 1;
  var_5 = undefined;

  if(isweapon(var_1)) {
    var_5 = getcompleteweaponname(var_1);
  } else {
    var_5 = var_1;
  }

  foreach(var_7 in var_2) {
    if(isDefined(var_0.primaryweaponobj) && var_0.primaryweaponobj == var_7) {
      var_3 = 0;
      continue;
    }

    if(isDefined(var_0.secondaryweaponobj) && var_0.secondaryweaponobj == var_7) {
      var_4 = 0;
    }
  }

  if(var_3) {
    var_0._id_034C = var_5;
    var_0.primaryweaponobj = makeweaponfromstring(var_5);
  } else if(var_4) {
    var_0._id_03B5 = var_5;
    var_0.secondaryweaponobj = makeweaponfromstring(var_5);
  }

  return var_3 || var_4;
}

_id_8B36() {
  var_0 = _id_6AD0();
  var_1 = _func_026C(var_0);

  for(var_2 = 1; var_1 != "none" && var_1 != var_0; var_2++) {
    self _meth_81F6(0, 0, 0, var_2);
    var_1 = _func_026C(var_1);
  }
}

_id_AB94(var_0) {
  if(isDefined(level._id_AB94)) {
    [[level._id_AB94]](var_0);
  } else if(self.owner scripts\mp\utility\perk::_hasperk("specialty_clandestine")) {
    var_0 _id_CBAC(var_0.origin);
  } else {
    _id_CBAA(var_0);
    var_0 scripts\mp\equipment::_id_6FE2();
    var_0 _id_07BC::createmisceventchallengeevent("ammoScavenge");
  }
}

_id_7490(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("scavenger", var_1);

    if(!var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      break;
    }
  }

  var_1 notify("scavenger_pickup");
  _id_AB94(var_1);

  if(!isDefined(var_1.pers["scavengerPickedUp"])) {
    var_1.pers["scavengerPickedUp"] = 0;
  }

  var_1 scripts\mp\utility\stats::_id_7DAE("scavengerPickedUp", 1);

  if(isDefined(self.owner) && self.owner scripts\mp\utility\perk::_hasperk("specialty_scavenger_plus")) {
    var_1 _id_07C4::_id_7B6B("scavenger");
    level thread scripts\mp\battlechatter_mp::_id_F759(var_1, "scavenger");
  }

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  self notify("death");
}

_id_CBAC(var_0) {
  _func_0251(var_0, self, 1300);
}

_id_CBAA(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    _id_1126(var_0, var_3, 1);
  }
}

_id_1126(var_0, var_1, var_2) {
  if(!scripts\mp\utility\weapon::_id_879A(var_1) && !level._id_CBA5) {
    return;
  }
  if(var_1._id_0245) {
    return;
  }
  if(scripts\mp\utility\weapon::getweapongroup(var_1) == "weapon_projectile") {
    return;
  }
  var_3 = var_0 getweaponammostock(var_1);
  var_4 = _id_68BB(var_1);
  var_4 = int(_func_0037(var_2 * var_4));

  if(var_1 _meth_8624("akimbo", 1)) {
    var_4 = var_4 * 1;
  }

  var_0 setweaponammostock(var_1, var_3 + var_4);
}

_id_CBA4() {
  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  self delete();
}

_id_5057(var_0, var_1) {
  self endon("spawned_player");
  level endon("game_ended");

  if(!_id_DB4C(var_0, var_1)) {
    return;
  }
  var_2 = 0;

  if(isDefined(var_1) && var_1 == "MOD_EXECUTION") {
    var_2 = 1.5;
  }

  wait(var_2);

  if(var_2 > 0 && !_id_DB4C(var_0, var_1)) {
    return;
  }
  _id_5058(var_0);
}

_id_5058(var_0) {
  var_1 = self _meth_80C4("s4_scavenger_bag_mp", "j_head");
  scripts\mp\utility\outline::outlineenableforplayer(var_1, var_0, "outline_nodepth_white", "level_script");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 _id_078E::_id_C2B5(2, ::_id_CBA4);
  var_1.owner = var_0;
  var_1.team = var_0.team;
  var_1 thread _id_7490(self);
  var_1 thread _id_CBA7();
  var_1 thread _id_CBA8();

  if(isDefined(level._id_279D) && isDefined(level._id_279D["bots_add_scavenger_bag"])) {
    [[level._id_279D["bots_add_scavenger_bag"]]](var_1);
  }
}

_id_DB4C(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == self) {
    return 0;
  }

  return 1;
}

_id_CBA7() {
  self endon("death");
  level endon("game_ended");
  self.owner scripts\engine\utility::waittill_any_3("death_or_disconnect", "joined_team", "bag_timeout");

  if(isDefined(self)) {
    if(isDefined(self._id_FE90)) {
      self._id_FE90 delete();
    }

    _id_078E::_id_4807();
    self delete();
  }
}

_id_CBA8() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  wait 20;

  if(isDefined(self)) {
    self.owner notify("bag_timeout");
  }
}

_id_CBA9() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var_0 = &"PERKS/HOLD_TO_SCAVENGE";
  self._id_FE90 = _id_07D6::_id_3FF0(self.origin + anglestoup(self.angles) * 1, "HINT_BUTTON", undefined, var_0, undefined, undefined, "show", 200, 160, 100, 160);
  self._id_FE90.owner = self.owner;
  self._id_FE90.team = self.team;
  self._id_FE90 linkto(self);

  foreach(var_2 in level.players) {
    self._id_FE90 disableplayeruse(var_2);
  }

  thread _id_CB9D();
  thread _id_CB9E();

  for(;;) {
    self waittill("pickedUpScavengerBag", var_2);

    if(isPlayer(var_2)) {
      var_2 notify("scavenger_pickup");
      _id_AB94(var_2);

      if(self.owner scripts\mp\utility\perk::_hasperk("specialty_scavenger_plus")) {
        var_2 _id_07C4::_id_7B6B("scavenger");
      }

      if(isDefined(self._id_FE90)) {
        self._id_FE90 delete();
      }

      self notify("death");
    }
  }
}

_id_CB9E() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var_0 = 1;

  while(var_0) {
    wait 0.1;

    foreach(var_2 in level.players) {
      if(!isDefined(self)) {
        var_0 = 0;
        continue;
      }

      if(var_2.team != self.team || var_2 scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
        self._id_FE90 disableplayeruse(var_2);
        continue;
      }

      self._id_FE90 _meth_80E0(var_2);
    }
  }
}

_id_CB9D() {
  self endon("restarting_physics");
  var_0 = self._id_FE90;
  var_1 = undefined;

  if(istrue(level.gameended) && !isDefined(var_0)) {
    return;
  }
  while(isDefined(self)) {
    var_0 waittill("trigger", var_2);
    var_2._id_87A4 = 1;
    var_1 = _id_406D();
    var_1._id_7C8C = "use";
    var_3 = var_1 _id_FE7D(var_2, getdvarfloat("#x3351364c4a55ba591"));

    if(!isDefined(var_2)) {
      return;
    }
    var_2._id_87A4 = 0;

    if(var_3) {
      self notify("pickedUpScavengerBag", var_2);
    }
  }
}

_id_FE7D(var_0, var_1) {
  self._id_4143 = 0;
  self._id_84EF = 1;
  self._id_FEB1 = 0;
  self._id_FEE7 = var_1;
  scripts\mp\movers::_id_CDD8(var_0);
  var_0 scripts\common\utility::_id_158D(0);
  var_2 = _id_FE7F(var_0);

  if(isalive(var_0)) {
    var_0 scripts\common\utility::_id_158D(1);
  }

  if(isDefined(var_0)) {
    scripts\mp\movers::_id_CDE7(var_0);
  }

  if(!isDefined(self)) {
    return 0;
  }

  self._id_84EF = 0;
  self._id_4143 = 0;
  return var_2;
}

_id_FE7F(var_0) {
  var_1 = _id_83DE(var_0);

  if(isDefined(self)) {
    var_0 _id_07D6::_id_FD75(self, 0);
  }

  return istrue(var_1);
}

_id_83DE(var_0) {
  self endon("endUseHoldThink");

  while(var_0 _id_89A3(self)) {
    if(!var_0 scripts\mp\movers::_id_CDE8(self)) {
      return 0;
    }

    self._id_4143 = self._id_4143 + level._id_5F3A * self._id_FEB1;

    if(isDefined(self._id_A8EC)) {
      self._id_FEB1 = 1 * self._id_A8EC;
    } else {
      self._id_FEB1 = 1;
    }

    var_0 _id_07D6::_id_FD75(self, 1);

    if(self._id_4143 >= self._id_FEE7) {
      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    waitframe();
  }

  return 0;
}

_id_406D() {
  var_0 = spawn("script_origin", self.origin);
  var_0._id_4143 = 0;
  var_0._id_FEE7 = 0;
  var_0._id_FEB1 = 3000;
  var_0._id_84EF = 0;
  var_0._id_7C8C = self._id_7C8C;
  var_0 linkto(self);
  var_0 thread _id_479C(self);
  return var_0;
}

_id_479C(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self._id_FE45)) {
    foreach(var_2 in self._id_FE45) {
      var_2 setclientomnvar("ui_securing", 0);
      var_2._id_F913 = undefined;
    }
  }

  self delete();
}

_id_89A3(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\mp\utility\player::isreallyalive(self) && self usebuttonpressed() && !self isonladder() && !self meleebuttonpressed() && var_0._id_4143 < var_0._id_FEE7 && (!isDefined(self._id_F03B) || !self._id_F03B);
}

_id_10D68(var_0) {
  if(scripts\mp\utility\weapon::_id_8798(var_0.basename)) {
    return 0;
  }

  return scripts\mp\utility\weapon::_id_879A(var_0.basename) || scripts\mp\utility\weapon::_id_879C(var_0.basename);
}

_id_D8EE(var_0, var_1, var_2) {
  scripts\mp\gamelogic::_id_D8EE(var_0, var_1, var_2);
}

_id_10C32(var_0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var_1);
    _id_ABDA(var_1);
  }
}

_id_ABDA(var_0) {
  scripts\mp\gamelogic::_id_D58D(self, 1);

  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  var_1 = gettime();

  if(!isDefined(self._id_9042)) {
    self._id_9042 = 0;
  }

  var_2 = gettime() - self._id_9042;
  self._id_9042 = var_1;
  _id_07BF::_id_7D9A(0, 1);

  if(isai(self)) {
    return;
  }
  if(!_id_10D68(var_0)) {
    return;
  }
  thread _id_10B2A(var_0);

  if(!scripts\mp\utility\game::_id_CA4B() && scripts\mp\utility\game::onlinestatsenabled()) {
    var_3 = _id_0804::_id_6C64("combatStats", "totalShots") + 1;
    var_4 = _id_0804::_id_6C64("combatStats", "hits");
    _id_0804::_id_D674(var_3, "combatStats", "totalShots");
    _id_0804::_id_D674(int(var_3 - var_4), "combatStats", "misses");
  }

  var_5 = 1;
  _id_D8EE(var_0, var_5, "shots");
  _id_D8EE(var_0, self._id_79B5, "hits");
  scripts\mp\utility\stats::_id_7DAE("shotsFired", 1);
  self._id_79B5 = 0;

  if(self getweaponammoclip(var_0) == 0 && self getweaponammostock(var_0) == 0) {
    level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_negative");
  }
}

_id_10B2A(var_0) {
  self endon("death_or_disconnect");
  var_1 = getcompleteweaponname(var_0);
  self endon("watchForMiss_" + var_1);
  waitframe();
  self._id_3B88[var_1] = 0;
  _id_07CE::_id_DA61();
}

_id_395D(var_0) {
  self endon("death_or_disconnect");
  var_1 = getcompleteweaponname(var_0);
  self notify("watchForMiss_" + var_1);
}

_id_3519(var_0, var_1) {
  self endon("disconnect");

  if(var_0._id_0245) {
    var_2 = scripts\mp\utility\weapon::_id_6E69(var_0);

    if(scripts\engine\utility::array_contains(var_2, "shotgun") || scripts\engine\utility::array_contains(var_2, "gl") || scripts\engine\utility::array_contains(var_2, "glsmoke") || scripts\engine\utility::array_contains(var_2, "glgas") || scripts\engine\utility::array_contains(var_2, "glconc") || scripts\engine\utility::array_contains(var_2, "glflash") || scripts\engine\utility::array_contains(var_2, "glincendiary") || scripts\engine\utility::array_contains(var_2, "glsemtex") || scripts\engine\utility::array_contains(var_2, "glsnap")) {
      self._id_79B5 = 1;
    }
  }

  if(!_id_10D68(var_0)) {
    return;
  }
  var_3 = self meleebuttonpressed();

  if(var_3 && var_0.basename != "s4_me_knife") {
    return;
  }
  switch (weaponclass(var_0)) {
    case "pistol":
    case "mg":
    case "smg":
    case "rifle":
    case "sniper":
      self._id_79B5++;
      break;
    case "spread":
      self._id_79B5 = 1;
      break;
    default:
      break;
  }

  var_4 = getcompleteweaponname(var_0);

  if(_id_080B::_id_8A09(var_0.basename) || var_0.basename == "s4_me_knife") {
    thread scripts\mp\gamelogic::_id_F13D(var_4, self._id_79B5, "hits");
    self._id_79B5 = 0;
  }

  if(!var_3) {
    _id_07BF::_id_7D9A(1, 1);
  }

  waittillframeend;
  thread _id_395D(var_0);

  if(!isDefined(self._id_8FF1[var_4])) {
    self._id_8FF1[var_4] = 0;
  }

  if(self._id_8FF1[var_4] == gettime()) {
    return;
  }
  self._id_8FF1[var_4] = gettime();

  if(!isDefined(self._id_3B88) || !isDefined(self._id_3B88[var_4])) {
    self._id_3B88[var_4] = 1;
  } else {
    self._id_3B88[var_4]++;
  }

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var_5 = _id_0804::_id_6C64("combatStats", "totalShots");
    var_6 = _id_0804::_id_6C64("combatStats", "hits") + 1;

    if(var_6 <= var_5) {
      _id_0804::_id_D674(var_6, "combatStats", "hits");
      _id_0804::_id_D674(int(var_5 - var_6), "combatStats", "misses");
    }
  }

  thread _id_07BC::_id_ABB1(var_0);
  thread _id_07CE::_id_DA5E();
  var_7 = gettime();
  self._id_8FB6 = var_7;
  var_1._id_90A7 = var_7;
  var_8 = scripts\mp\utility\weapon::getweapongroup(var_0.basename);

  if(var_8 == "weapon_lmg") {
    if(!isDefined(self._id_DA69)) {
      self._id_DA69 = 1;
    } else {
      self._id_DA69++;
    }
  }
}

_id_5FB2(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  var_4 = level._id_5FA5;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(var_4 != 0) {
    return 1;
  }

  if(var_1 == var_0 || isDefined(var_1.owner) && var_1.owner == var_0) {
    return 1;
  }

  var_5 = undefined;

  if(isDefined(var_1.owner)) {
    var_5 = var_1.owner.team;
  } else if(isDefined(var_1.team)) {
    var_5 = var_1.team;
  }

  if(!isDefined(var_5)) {
    return 1;
  }

  if(var_5 != var_0.team) {
    return 1;
  }

  return 0;
}

_id_6D75(var_0, var_1) {
  var_2 = "";
  return var_2;
}

_id_10C02() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("sprint_melee_charge_begin");
    self setscriptablepartstate("bayoCharge", "start", 1);
  }
}

_id_10C01() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("sprint_melee_charge_attack", var_0);
    self setscriptablepartstate("bayoCharge", "attack", 1);
  }
}

_id_10C04() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("sprint_melee_charge_end");
    self setscriptablepartstate("bayoCharge", "stop", 1);
  }
}

_id_10C00() {
  self._id_23A8 = 0;
  self._id_D9D8 = 0;
  thread _id_10C02();
  thread _id_10C01();
  thread _id_10C04();
}

_id_10ADD() {
  self notify("watchEquipmentOnSpawn");
  self endon("watchEquipmentOnSpawn");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");
  _id_4765();
  var_0 = scripts\mp\utility\dvars::_id_6AC8("#x3d2a5eb0d460080ca", 1) && (!scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp") || !_id_34FC());

  if(var_0) {
    _id_4785();
  }

  var_1 = self._id_B1D0.size;
  var_2 = self._id_B1CE.size;
  var_3 = self._id_B1CF.size;
  var_4 = self._id_B1CC.size;
  var_5 = var_1 && var_2 && var_3 && var_4;

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp") && var_5) {
    thread _id_0A6B::_id_5A01(var_2, var_1, var_3, var_4);
  }
}

_id_68A5() {
  var_0 = [];

  if(isDefined(self._id_B1CE)) {
    var_0 = scripts\engine\utility::array_combine(var_0, self._id_B1CE);
  }

  if(isDefined(self._id_B1D0)) {
    var_0 = scripts\engine\utility::array_combine(var_0, self._id_B1D0);
  }

  if(isDefined(self._id_B1CF)) {
    var_0 = scripts\engine\utility::array_combine(var_0, self._id_B1CF);
  }

  if(isDefined(self._id_B1CC)) {
    var_0 = scripts\engine\utility::array_combine(var_0, self._id_B1CC);
  }

  return var_0;
}

_id_C498(var_0) {
  if(isDefined(self._id_B1CE)) {
    self._id_B1CE = scripts\engine\utility::array_remove(self._id_B1CE, var_0);
  }

  if(isDefined(self._id_B1D0)) {
    self._id_B1D0 = scripts\engine\utility::array_remove(self._id_B1D0, var_0);
  }

  if(isDefined(self._id_B1CF)) {
    self._id_B1CF = scripts\engine\utility::array_remove(self._id_B1CF, var_0);
  }

  if(isDefined(self._id_B1CC)) {
    self._id_B1CC = scripts\engine\utility::array_remove(self._id_B1CC, var_0);
  }
}

_id_34FC() {
  var_0 = scripts\engine\utility::array_combine(self._id_B1D0, self._id_B1CE);

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_75A8)) {
      return 1;
    }
  }

  return 0;
}

_id_10B75() {
  self notify("watchGrenadeUsage");
  self endon("watchGrenadeUsage");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    _id_10B71();
  }
}

_id_10B71() {
  var_0 = scripts\cp_mp\utility\throwing_weapon::_id_108DD();

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.weapon_name)) {
    return;
  }
  _id_D8EE(var_0.weapon_name, 1, "shots");
  var_1 = scripts\mp\equipment::_id_8836(var_0.weapon_name);
  _id_0806::_id_7181(var_1);
  scripts\mp\battlechatter_mp::_id_AAF8(var_0);
  scripts\mp\gamelogic::_id_D58D(self, 1);
  var_0 _meth_8851(3, self.team);

  if(scripts\mp\utility\weapon::_id_8774(var_0.weapon_name)) {
    var_0 thread scripts\cp_mp\utility\throwing_weapon::_id_10B6D(self);
    return;
  }

  var_0 thread scripts\mp\battlechatter_mp::_id_7170();
  var_0._id_E352 = var_0.origin;

  switch (var_0.weapon_name) {
    case "s4_frag_usa_mk2_mp":
      if(var_0._id_F1E0 >= 1) {
        var_0._id_87C1 = 1;
      }

      var_0._id_AC8F = self;
      var_0 thread _id_0814::_id_7143();
      break;
    case "pop_rocket_mp":
      if(var_0._id_F1E0 >= 1) {
        var_0._id_87C1 = 1;
      }

      var_0._id_AC8F = self;
      thread _id_0A20::_id_10FB9(var_0);
      var_0 thread _id_0814::_id_7143(0.6);
      break;
    case "s4_sticky_eng_n74_mp":
    case "s4_semtex_mp":
      thread _id_D098(var_0);
      var_0 thread _id_0814::_id_7143();
      break;
    case "s4_c4_mp":
      thread _id_0A04::_id_2E64(var_0);
      break;
    case "emp_grenade_mp":
      thread _id_0A08::_id_518B(var_0);
      break;
    case "snapshot_grenade_mp":
      thread _id_0A14::_id_DEBE(var_0, 0);
      break;
    case "s4_smoke_usa_m18_mp":
      var_0 thread _id_DE51();
      break;
    case "claymore_mp":
      thread _id_0A05::_id_3823(var_0);
      break;
    case "at_mine_mp":
      thread _id_0A01::_id_1D49(var_0);
      break;
    case "s4_mine_ger_s44_mp":
      thread _id_0A02::_id_1D49(var_0);
      break;
    case "s4_throwing_knife_mp":
      thread _id_09A7::_id_F1A2(var_0);
      break;
    case "s4_throwing_star_mp":
      thread _id_09A8::_id_F1B0(var_0);
      break;
    case "s4_molotov_mp":
      var_0 thread _id_0814::_id_7143();
      thread _id_0A11::_id_A098(var_0);
      break;
    case "s4_thermite_mp":
      thread _id_0A1A::_id_F0FB(var_0);
      break;
    case "tac_ops_spawn_grenade_mp":
      thread _id_0A70::_id_F1CB(var_0);
      break;
    case "tac_ops_supply_pack_grenade_mp":
      thread _id_0A76::_id_F1D2(var_0);
      break;
    case "support_box_mp":
      thread _id_0A17::_id_EB8C(var_0);
      break;
    case "s4_medkit_box_mp":
      thread _id_0A10::_id_9D27(var_0);
      break;
    case "s4_ammo_box_mp":
      thread _id_09FF::_id_1747(var_0);
      break;
    case "s4_equipment_resupply_box_mp":
      thread _id_0A09::_id_5584(var_0);
      break;
    case "s4_steel_bib_crate_mp":
      thread _id_0A16::_id_E829(var_0);
      break;
    case "s4_dead_drop_mp":
      thread _id_0A13::_id_BBE5(var_0);
      break;
    case "s4_decoy_grenade_mp":
      thread _id_0A07::_id_453F(var_0);
      break;
    case "s4_gas_usa_mk5cn_mp":
      thread _id_0A0D::_id_61A6(var_0);
      break;
    case "hb_sensor_mp":
      thread _id_0A0E::_id_75D6(var_0);
      break;
    case "s4_tac_cover_mp":
      thread _id_0A19::_id_ECB9(var_0);
      break;
    case "s4_hand_flare_mp":
      thread _id_0A18::_id_ED08(var_0);
      _id_07BC::createfieldupgradechallengeevent("activate");
      break;
    case "s4_jammer_mp":
      thread _id_0A0F::_id_8B66(var_0);
      break;
    case "s4_field_mic_mp":
      thread _id_0A0A::_id_5A16(var_0);
      break;
    case "s4_trophy_mp":
      thread scripts\mp\equipment\trophy::_id_F69E(var_0);
      break;
    case "s4_steel_bib_mp":
      break;
    case "advanced_supply_drop_marker_mp":
      thread _id_09FD::_id_11D7(var_0);
      break;
    case "deploy_weapondrop_mp":
      thread _id_0A1E::_id_10D7C(var_0);
      break;
    case "s4_frag_gbr_n23_mp":
      if(var_0._id_F1E0 >= 1) {
        var_0._id_87C1 = 1;
      }

      var_0._id_AC8F = self;
      var_0 thread _id_0814::_id_7143();
      break;
    case "s4_frag_gbr_n82_mp":
      if(var_0._id_F1E0 >= 1) {
        var_0._id_87C1 = 1;
      }

      var_0._id_AC8F = self;
      var_0 thread _id_0814::_id_7143();
      break;
    case "s4_bundle_charge_mp":
      if(var_0._id_F1E0 >= 1) {
        var_0._id_87C1 = 1;
      }

      var_0._id_AC8F = self;
      var_0 thread _id_0814::_id_7143();
      break;
    case "s4_frag_ger_m24_mp":
      if(var_0._id_F1E0 >= 1) {
        var_0._id_87C1 = 1;
      }

      var_0._id_AC8F = self;
      var_0 thread _id_0814::_id_7143();
      break;
    case "s4_stun_gbr_n69_mp":
      var_0 thread _id_3B5D();
      break;
    case "s4_smoke_gbr_n77_mp":
      thread _id_0A1F::_id_7154(var_0);
      break;
    case "equip_adrenaline":
      if(scripts\mp\utility\perk::_hasperk("specialty_tactician")) {
        thread _id_0A6B::_id_ED33();
      }

      break;
    default:
      if(isDefined(level._id_AAF9)) {
        [[level._id_AAF9]](var_0.weapon_name, var_0);
      }

      break;
  }
}

_id_3B5D() {
  thread scripts\mp\utility\script::_id_A695("death", "end_explode");
  self endon("end_explode");
  var_0 = self.owner;
  self waittill("explode", var_1);
  thread _id_0A06::_id_AAE3(var_0, var_1);
}

_id_DE51(var_0) {
  thread scripts\mp\utility\script::_id_A695("death", "end_explode");
  self endon("end_explode");

  if(istrue(var_0)) {
    self waittill("missile_stuck", var_5, var_1, var_2, var_3, var_4, var_6);
    thread _id_DE4D(var_5);
    thread scripts\mp\bots\bots::_id_3F6E(var_5);
  } else
    self waittill("explode", var_5);

  thread _id_DE4E(var_5);
  thread _id_D93F(var_5);
  self.owner notify("smoke_grenade_explode", var_5);

  if(isDefined(self.owner)) {
    self.owner thread _id_A13E();
  }
}

_id_D93F(var_0) {
  wait 0.2;
  var_1 = spawn("script_origin", var_0);
  var_1 playLoopSound("smoke_grenade_smoke_lp");
  var_1 _id_078E::_id_C2B6(1);
  wait 5.25;
  wait 0.3;
  var_1 _id_078E::_id_4807();
  var_1 stoploopsound();
  var_1 delete();
}

_id_DE4E(var_0) {
  wait 1;
  thread _id_DE4F(var_0);
  var_1 = scripts\mp\utility\outline::_id_110A(var_0, 330);
  wait 8.25;
  scripts\mp\utility\outline::_id_C4FA(var_1);
}

_id_DE4D(var_0, var_1) {
  playFX(scripts\engine\utility::getfx("glsmoke"), var_0, anglestoup((0, 90, 0)));
}

_id_DE4F(var_0) {
  var_1 = spawnStruct();
  var_1._id_2575 = [];
  _id_DE50(var_1, var_0);

  foreach(var_3 in var_1._id_2575) {
    if(isDefined(var_3) && scripts\mp\utility\player::isreallyalive(var_3)) {
      var_3 scripts\mp\utility\perk::removeperk("specialty_blindeye");
    }
  }
}

_id_DE50(var_0, var_1) {
  level endon("game_ended");
  var_2 = gettime() + 8250.0;
  var_3 = [];

  while(gettime() < var_2) {
    var_3 = scripts\mp\utility\player::_id_6C5F(var_1, 330);

    foreach(var_7, var_5 in var_0._id_2575) {
      if(!isDefined(var_5)) {
        var_0._id_2575[var_7] = undefined;
        continue;
      }

      var_6 = scripts\engine\utility::_id_1BAB(var_3, var_5);

      if(!isDefined(var_6) || !scripts\mp\utility\player::isreallyalive(var_5)) {
        var_5 scripts\mp\utility\perk::removeperk("specialty_blindeye");
        var_0._id_2575[var_7] = undefined;
      }

      if(isDefined(var_6)) {
        var_3[var_6] = undefined;
      }
    }

    foreach(var_9 in var_3) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_9._id_8FF7 = gettime();

      if(isDefined(var_0._id_2575[var_9 getentitynumber()])) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_9) || scripts\mp\utility\entity::_id_8A5A(var_9)) {
        continue;
      }
      var_9 scripts\mp\utility\perk::_id_6FC2("specialty_blindeye");
      var_0._id_2575[var_9 getentitynumber()] = var_9;
    }

    waitframe();
  }
}

_id_A13E() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSmokeActive()");
  self endon("monitorSmokeActive()");
  scripts\mp\utility\print::_id_BD15("smoke grenade activated", self);
  self._id_7533 = 1;
  var_0 = scripts\engine\utility::_id_108A7(9.25, "death");
  self._id_7533 = 0;
  scripts\mp\utility\print::_id_BD15("smoke grenade deactivated", self);
}

_id_96FE(var_0) {
  var_1 = [];
  var_2 = 0;
  var_3 = _id_96FF();

  if(level.teambased) {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_5 in level.characters) {
        if(isDefined(var_5) && isalive(var_5) && (var_5.team != self.team || var_2)) {
          var_1[var_1.size] = var_5;
        }
      }
    }

    if(isDefined(level._id_0F4C)) {
      foreach(var_8 in level._id_0F4C) {
        if(isDefined(var_8) && isDefined(var_8._id_11E4) && (var_8.team != self.team || var_2)) {
          var_1[var_1.size] = var_8;
        }
      }
    }

    if(isDefined(level._id_3E86)) {
      if(isDefined(level._id_3E86._id_0E45)) {
        foreach(var_11 in level._id_3E86._id_0E45) {
          if(isDefined(var_11) && (var_11.team != self.team || var_2)) {
            var_1[var_1.size] = var_11;
          }
        }
      }
    }

    foreach(var_14 in var_3) {
      var_15 = scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC(var_14);

      foreach(var_17 in var_15) {
        if(isDefined(var_17) && (!scripts\cp_mp\vehicles\vehicle::_id_10124(var_17, self) || var_2)) {
          var_1[var_1.size] = var_17;
        }
      }
    }
  } else {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_5 in level.characters) {
        if((!isDefined(var_5) || !isalive(var_5)) && !var_2) {
          continue;
        }
        var_1[var_1.size] = var_5;
      }
    }

    if(isDefined(level._id_0F4C)) {
      foreach(var_8 in level._id_0F4C) {
        if(isDefined(var_8._id_11E4) && (isDefined(var_8.owner) && var_8.owner != self || var_2)) {
          var_1[var_1.size] = var_8;
        }
      }
    }

    if(isDefined(level._id_3E86)) {
      if(isDefined(level._id_3E86._id_0E45)) {
        foreach(var_11 in level._id_3E86._id_0E45) {
          if(var_11.owner != self || var_2) {
            var_1[var_1.size] = var_11;
          }
        }
      }
    }

    foreach(var_14 in var_3) {
      var_15 = scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC(var_14);

      foreach(var_17 in var_15) {
        if(!isDefined(var_17.owner)) {
          var_1[var_1.size] = var_17;
          continue;
        }

        if(var_17.owner != self || var_2) {
          var_1[var_1.size] = var_17;
        }
      }
    }
  }

  return var_1;
}

_id_96FF() {
  return ["apc_russian", "atv", "big_bird", "cargo_truck", "cop_car", "hoopty", "hoopty_truck", "jeep", "large_transport", "light_tank", "little_bird", "medium_transport", "pickup_truck", "tac_rover", "technical", "van", "loot_chopper"];
}

_id_10BAE() {
  self endon("disconnect");

  for(;;) {
    var_0 = _id_108E7();
    _id_FCC9(var_0);
  }
}

_id_FCC9(var_0) {
  var_1 = undefined;
  var_2 = 0;

  switch (var_0.weapon_name) {
    case "gl":
      var_2 = 1;
      break;
    case "glsmoke":
      var_2 = 1;
      var_0 thread _id_DE51(1);
      break;
    case "glgas":
      var_2 = 1;
      thread _id_0A0D::_id_61A6(var_0);
      break;
    case "glflash":
    case "glconc":
      var_2 = 1;
      break;
    case "glincendiary":
      var_2 = 1;
      var_0 thread _id_0814::_id_7143();
      thread _id_0A1A::_id_F0FB(var_0, 1);
      break;
    case "glsemtex":
      var_2 = 1;
      break;
    case "glsnap":
      var_2 = 1;
      thread _id_0A14::_id_DEBE(var_0, var_2);
      break;
    case "s4_la_palpha42_mp":
    case "s4_la_m1bravo_mp":
    case "s4_la_palpha_mp":
      var_1 = self._id_9F76;
      _id_90F4(var_0);
      level notify("launcher_missile_fire", self, var_0);
    default:
      break;
  }

  if(scripts\cp_mp\utility\weapon_utility::_id_8916(var_0.weapon_name) && isDefined(var_1)) {
    var_0._id_9701 = var_1;
    level notify("stinger_fired", self, var_0, var_1);
    thread scripts\cp_mp\utility\weapon_utility::_id_10C14(var_1, var_0);
  }

  if(isPlayer(self)) {
    var_0._id_11B6 = scripts\mp\utility\player::_id_8989();
  }

  if(!var_2 && _id_8844(var_0.weapon_name)) {
    var_3 = 1.0;

    if(_id_8A3D(var_0.weapon_name)) {
      var_3 = 0.65;
    }

    var_0 thread _id_0814::_id_7143(var_3);
  }

  _id_07CE::_id_9F6E(var_0);
}

_id_90F4(var_0) {
  if(isDefined(var_0) && isDefined(self) && isDefined(self.origin)) {
    self radiusdamage(self getEye(), 130, 110, 75, self, "MOD_EXPLOSIVE", var_0.weapon_name);
  }
}

launcherbackblast_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2) || isDefined(var_2.classname) && var_2.classname == "rocket") {
    return var_4;
  }

  if(!isDefined(var_1) || isnullweapon(var_1)) {
    return var_4;
  }

  if(!_func_010F(var_3)) {
    return var_4;
  }

  if(var_1.basename != "s4_la_palpha42_mp" && var_1.basename != "s4_la_palpha_mp" && var_1.basename != "s4_la_m1bravo_mp") {
    return var_4;
  }

  if(isDefined(var_2.classname) && var_2.classname == "player") {
    var_5 = anglesToForward(var_2 getplayerangles()) * -1;
    var_6 = backblastcheckpoints(var_2, var_0, var_5);
    var_7 = 0;

    foreach(var_9 in var_6) {
      if(vectordot(var_9, var_5) > 0.838671) {
        var_7 = 1;
        break;
      }
    }

    if(!var_7) {
      var_4 = 0;
    }
  }

  return var_4;
}

backblastcheckpoints(var_0, var_1, var_2) {
  if(!isPlayer(var_1)) {
    var_3 = vectornormalize(var_1.origin - var_0 getEye());
    return [var_3];
  }

  var_4 = 0;
  var_5 = vectornormalize(var_1 getEye() - var_0 getEye());
  var_6 = vectornormalize(var_1 scripts\mp\utility\player::_id_6D7F() + scripts\engine\utility::ter_op(var_1 getstance() == "prone", anglesToForward(var_1 getplayerangles(1)) * -20, (0, 0, 0)) - var_0 getEye());
  var_3 = vectornormalize(var_1.origin + scripts\engine\utility::ter_op(var_1 getstance() == "prone", anglesToForward(var_1 getplayerangles(1)) * -40, (0, 0, 0)) - var_0 getEye());

  if(var_4) {
    var_7 = (var_5 + var_6) / 2;
    var_8 = (var_3 + var_6) / 2;
    return [var_5, var_6, var_3, var_7, var_8];
  }

  return [var_5, var_6, var_3];
}

_id_8A3D(var_0) {
  return 0;
}

_id_8844(var_0) {
  var_1 = getweaponbasename(var_0);

  switch (var_1) {
    case "ac130_25mm_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
    case "pop_rocket_proj_mp":
      return 0;
  }

  return 1;
}

_id_A28A(var_0) {
  if(!isDefined(var_0._id_90AD) || !isDefined(var_0._id_90AD._id_4850) || var_0._id_90AD._id_4850) {
    self notify("detonateExplosive");
  }
}

_id_A105(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 notify("monitorDisownedEquipment()");
  var_1 endon("monitorDisownedEquipment()");
  var_0 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  var_1 _id_476C();
}

_id_A106(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 endon("mine_planted");
  scripts\engine\utility::_id_10888(var_0, "joined_team", var_0, "joined_spectators", var_0, "disconnect", level, "prematch_cleanup");

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

_id_8985(var_0) {
  return isDefined(level._id_9EE2[var_0 getentitynumber()]) || istrue(var_0._id_B1C9);
}

_id_6B44(var_0) {
  var_1 = 4;

  if(scripts\mp\utility\perk::_hasperk("specialty_extra_planted_equipment")) {
    var_1++;
  }

  return var_1;
}

_id_6B46(var_0) {
  var_1 = 2;

  if(scripts\mp\utility\perk::_hasperk("specialty_extra_planted_equipment")) {
    var_1++;
  }

  return var_1;
}

_id_6B45(var_0) {
  return 1;
}

_id_6B43() {
  return 3;
}

_id_AACF(var_0, var_1, var_2) {
  var_0._id_5562 = var_1;
  var_0._id_476E = var_2;
  var_0._id_B1C9 = 1;
  _id_FCF3(var_0);
  var_3 = var_0 getentitynumber();
  level._id_9EE2[var_3] = var_0;

  if(var_1 != "equip_tac_cover") {
    var_0 _meth_86FE("equipment");

    if(level.teambased) {
      var_0 _meth_8706(self.team);
    } else {
      var_0 _meth_8706(self);
    }
  }

  var_0 notify("mine_planted");
}

_id_FCF3(var_0) {
  var_1 = undefined;
  var_2 = 0;
  var_3 = scripts\mp\equipment::_id_5AEA(var_0._id_5562);

  if(istrue(var_0._id_888A)) {
    var_1 = var_0.owner._id_B1CC;
    var_2 = _id_6B43();
  } else if(istrue(var_0._id_8A74)) {
    var_1 = var_0.owner._id_B1CF;
    var_2 = _id_6B45(var_0._id_5562);
  } else if(isDefined(var_3) && var_3 == "primary" || scripts\mp\equipment::_id_8836(var_0._id_5562)) {
    var_1 = var_0.owner._id_B1CE;
    var_2 = _id_6B44(self);
  } else if(isDefined(var_3) && var_3 == "secondary" || scripts\mp\equipment::_id_883B(var_0._id_5562)) {
    var_1 = var_0.owner._id_B1D0;
    var_2 = _id_6B46(self);
  }

  if(!isDefined(var_1)) {
    var_4 = "isSuper: " + var_0._id_8A74 + ", slot: " + var_3 + ", equipmentRef: " + var_0._id_5562 + ", allowed: " + scripts\mp\equipment::_id_85BF("super");
    scripts\mp\utility\script::_id_47BB(var_4);
  }

  if(var_1.size > 0) {
    if(var_1.size && var_1.size >= var_2) {
      var_5 = var_1[0];
      var_1 = scripts\engine\utility::array_remove(var_1, var_5);
      var_5 _id_476C();
    }
  }

  var_1[var_1.size] = var_0;

  if(istrue(var_0._id_888A)) {
    var_0.owner._id_B1CC = var_1;
  } else if(istrue(var_0._id_8A74)) {
    var_0.owner._id_B1CF = var_1;
  } else if(isDefined(var_3) && var_3 == "primary" || scripts\mp\equipment::_id_8836(var_0._id_5562)) {
    var_0.owner._id_B1CE = var_1;
  } else if(isDefined(var_3) && var_3 == "secondary" || scripts\mp\equipment::_id_883B(var_0._id_5562)) {
    var_0.owner._id_B1D0 = var_1;
  }
}

_id_D657(var_0) {
  var_1 = _id_68A5();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.trigger) && isDefined(var_3.owner)) {
      if(var_0) {
        var_3.trigger _meth_80E0(var_3.owner);
        continue;
      }

      var_3.trigger disableplayeruse(var_3.owner);
    }
  }
}

_id_3882(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level._id_9EE2[var_0] = undefined;
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }

  if(isDefined(var_2)) {
    var_2 delete();
  }
}

_id_555D(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\player_utility::_id_B78C(var_1, var_0)) {
    if(!isDefined(var_2)) {
      return;
    }
    if(scripts\mp\utility\weapon::_id_88F6(var_2.basename)) {
      return;
    }
    var_4 = getcompleteweaponname(var_2);

    if(!isDefined(var_1._id_8FF1[var_4])) {
      var_1._id_8FF1[var_4] = 0;
    }

    if(var_1._id_8FF1[var_4] == gettime()) {
      return;
    }
    var_1._id_8FF1[var_4] = gettime();
    var_1 thread scripts\mp\gamelogic::_id_F13D(var_4, 1, "hits");

    if(scripts\mp\utility\game::onlinestatsenabled()) {
      var_5 = var_1 _id_0804::_id_6C64("combatStats", "totalShots");
      var_6 = var_1 _id_0804::_id_6C64("combatStats", "hits") + 1;

      if(var_6 <= var_5) {
        _id_0804::_id_D674(var_6, "combatStats", "hits");
        _id_0804::_id_D674(int(var_5 - var_6), "combatStats", "misses");
      }
    }

    if(isDefined(var_3) && scripts\engine\utility::_id_8794(var_3) || _id_0A8B::_id_89CC(var_3)) {
      var_1._id_8FB6 = gettime();
      var_7 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);

      if(var_7 == "weapon_lmg") {
        if(!isDefined(var_1._id_DA69)) {
          var_1._id_DA69 = 1;
        } else {
          var_1._id_DA69++;
        }
      }
    }
  }
}

_id_476C() {
  if(!isDefined(self)) {
    return;
  }
  _id_0812::_id_F9A3(self._id_D0CA, self._id_D0CB);
  var_0 = self getentitynumber();
  level._id_9EE2[var_0] = undefined;
  self _meth_86FF("equipment");

  if(isDefined(self._id_476E)) {
    self thread[[self._id_476E]]();
    self notify("deleted_equipment");
  } else {
    var_1 = self.killcament;
    var_2 = self.trigger;
    _id_3882(var_0, var_1, var_2);
    self notify("deleted_equipment");
    self delete();
  }
}

_id_99ED(var_0) {
  self setotherent(self.owner);

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_1 = spawn("script_origin", self.origin + var_0 * anglestoup(self.angles));
  var_1 linkto(self);
  self.trigger = var_1;
  var_1.owner = self;
  thread _id_99EE();
  return var_1;
}

_id_99EE() {
  self endon("makeExplosiveUnusable");
  var_0 = self.trigger;
  _id_10AE4();

  if(isDefined(self)) {
    var_0 = self.trigger;
    self.trigger = undefined;
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_99EB() {
  self notify("makeExplosiveUnusable");
  var_0 = self.trigger;
  self.trigger = undefined;

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_10AE4() {
  var_0 = self.owner;
  var_1 = self.trigger;
  self endon("death");
  var_1 endon("death");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 setcursorhint("HINT_NOICON");
  var_1 scripts\mp\utility\usability::_id_D6C2(var_0);
  var_1 childthread scripts\mp\utility\usability::_id_A6C3(var_0);
  var_1 childthread scripts\mp\utility\usability::_id_A6C2(var_0, self);
  var_1 _id_D549(self.weapon_name);

  for(;;) {
    var_1 waittillmatch("trigger", var_0);

    if(isDefined(self.weapon_name)) {
      var_0 thread _id_0A04::_id_2E5E();
    }

    var_0 playsoundtoplayer("scavenger_pack_pickup", var_0, var_0);
    var_0 notify("scavenged_ammo", self.weapon_name);
    var_2 = scripts\mp\equipment::_id_6A14(makeweapon(self.weapon_name));

    if(isDefined(var_2) && self.owner scripts\mp\equipment::_id_755B(var_2)) {
      self.owner scripts\mp\equipment::incrementequipmentammo(var_2, 1);
    }

    thread _id_476C();
    return;
  }
}

_id_99EF(var_0, var_1) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  var_2 = self.owner;
  var_3 = self.weapon_name;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    self enablemissilehint(1);
  } else {
    self setcursorhint("HINT_NOICON");
  }

  self _meth_84D7(var_0);
  self setuserange(72);
  _id_D549(self.weapon_name);
  scripts\mp\utility\usability::_id_D6C2(var_2);
  childthread scripts\mp\utility\usability::_id_A6C3(var_2);
  childthread scripts\mp\utility\usability::_id_A6C2(var_2, self);

  for(;;) {
    self waittillmatch("trigger", var_2);

    if(istrue(var_2._id_88DF)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
      }

      continue;
    }

    if(isDefined(var_3)) {
      var_2 thread _id_0A04::_id_2E5E();
    }

    var_2 playlocalsound("wpn_grenade_stun_mine_plr_pickup");
    var_2 notify("scavenged_ammo", var_3);
    var_4 = scripts\mp\equipment::_id_6A14(makeweapon(var_3));

    if(isDefined(var_4)) {
      if(self.owner scripts\mp\equipment::_id_755B(var_4)) {
        self.owner scripts\mp\equipment::incrementequipmentammo(var_4, 1);
      } else if(isDefined(level._id_AB3E)) {
        [[level._id_AB3E]](self.owner, var_4);
      }
    }

    if(isDefined(self._id_FE90)) {
      self._id_FE90 delete();
    }

    thread _id_476C();
    return;
  }
}

_id_99EC() {
  self notify("makeExplosiveUnusable");
  self makeunusable();
}

_id_D549(var_0) {
  switch (var_0) {
    case "s4_c4_mp":
      self sethintstring(&"EQUIPMENT_HINTS/PICKUP_C4");
      self _meth_84D4(125);
      self setuserange(125);
      break;
    case "s4_mine_ger_s44_mp":
      self sethintstring(&"EQUIPMENT_HINTS/PICKUP_AT_MINE");
      break;
    case "claymore_mp":
      self sethintstring(&"EQUIPMENT_HINTS/PICKUP_CLAYMORE");
      break;
    case "gas_grenade_mp":
      self sethintstring(&"EQUIPMENT_HINTS/PICKUP_GAS_GRENADE");
      break;
    case "trophy_mp":
      self sethintstring(&"EQUIPMENT_HINTS/PICKUP_TROPHY");
      break;
  }
}

_id_57E8(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_950E = var_0;
  var_2._id_43F7 = ::_id_A28A;
  var_2._id_5338 = "death";

  if(!isDefined(var_1) || !var_1) {
    var_2._id_84FB = scripts\mp\movers::_id_A284;
  }

  thread scripts\mp\movers::_id_7403(var_2);
}

_id_57EC(var_0, var_1, var_2) {
  if(isPlayer(var_0) && var_0 scripts\mp\utility\perk::_hasperk("specialty_delaymine")) {
    var_0 thread _id_07BC::_id_F619();
    var_1 = level._id_46D1;
  }

  wait(var_1);
}

_id_69BB(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_5 = var_1 * var_1;
  var_6 = level.players;

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    if(!isalive(var_6[var_7]) || var_6[var_7].sessionstate != "playing") {
      continue;
    }
    var_8 = _id_0A8B::_id_6438(var_6[var_7]);
    var_9 = distancesquared(var_0, var_8);

    if(var_9 < var_5 && (!var_2 || _id_10D70(var_0, var_8, var_3, var_6[var_7]))) {
      var_4[var_4.size] = _id_0A8B::_id_6437(var_6[var_7], var_8);
    }
  }

  var_10 = getEntArray("grenade", "classname");

  for(var_7 = 0; var_7 < var_10.size; var_7++) {
    var_11 = _id_0A8B::_id_6435(var_10[var_7]);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || _id_10D70(var_0, var_11, var_3, var_10[var_7]))) {
      var_4[var_4.size] = _id_0A8B::_id_6434(var_10[var_7], var_11);
    }
  }

  var_12 = getEntArray("destructible", "targetname");

  for(var_7 = 0; var_7 < var_12.size; var_7++) {
    var_11 = var_12[var_7].origin;
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || _id_10D70(var_0, var_11, var_3, var_12[var_7]))) {
      var_13 = spawnStruct();
      var_13._id_8987 = 0;
      var_13._id_8732 = 0;
      var_13._id_019B = var_12[var_7];
      var_13._id_42EB = var_11;
      var_4[var_4.size] = var_13;
    }
  }

  var_14 = getEntArray("destructable", "targetname");

  for(var_7 = 0; var_7 < var_14.size; var_7++) {
    var_11 = var_14[var_7].origin;
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || _id_10D70(var_0, var_11, var_3, var_14[var_7]))) {
      var_13 = spawnStruct();
      var_13._id_8987 = 0;
      var_13._id_8732 = 1;
      var_13._id_019B = var_14[var_7];
      var_13._id_42EB = var_11;
      var_4[var_4.size] = var_13;
    }
  }

  var_15 = getEntArray("misc_turret", "classname");

  foreach(var_17 in var_15) {
    var_11 = var_17.origin + (0, 0, 32);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || _id_10D70(var_0, var_11, var_3, var_17))) {
      switch (var_17.model) {
        case "vehicle_ugv_talon_gun_mp":
        case "mp_scramble_turret":
        case "mp_sam_turret":
        case "sentry_minigun_weak":
          var_4[var_4.size] = _id_0A8B::_id_6439(var_17, var_11);
          break;
      }
    }
  }

  var_19 = getEntArray("script_model", "classname");

  foreach(var_21 in var_19) {
    if(var_21.model != "projectile_bouncing_betty_grenade" && var_21.model != "ims_scorpion_body") {
      continue;
    }
    var_11 = var_21.origin + (0, 0, 32);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || _id_10D70(var_0, var_11, var_3, var_21))) {
      var_4[var_4.size] = _id_0A8B::_id_6436(var_21, var_11);
    }
  }

  return var_4;
}

_id_10D70(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = var_1 - var_0;

  if(_func_0135(var_5) < var_2 * var_2) {
    return 1;
  }

  var_6 = vectornormalize(var_5);
  var_4 = var_0 + (var_6[0] * var_2, var_6[1] * var_2, var_6[2] * var_2);
  var_7 = scripts\engine\trace::_bullet_trace(var_4, var_1, 0, var_3);

  if(getdvarint("#x3200ef8dba645cbd8") != 0 || getdvarint("#x34bed26f8fa344f08") != 0) {
    thread _id_44EE(var_0, ".dmg");

    if(isDefined(var_3)) {
      thread _id_44EE(var_1, "." + var_3.classname);
    } else {
      thread _id_44EE(var_1, ".undefined");
    }

    if(var_7["fraction"] == 1) {
      thread _id_44DC(var_4, var_1, (1, 1, 1));
    } else {
      thread _id_44DC(var_4, var_7["position"], (1, 0.9, 0.8));
      thread _id_44DC(var_7["position"], var_1, (1, 0.4, 0.3));
    }
  }

  return var_7["fraction"] == 1;
}

_id_42FA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self._id_8987) {
    self._id_4315 = var_5;
    self._id_019B thread[[level._id_2F4C]](var_0, var_1, var_2, 0, var_3, var_4, var_5, var_6, "none", 0);
  } else {
    if(self._id_8732 && (var_4.basename == "artillery_mp" || var_4.basename == "claymore_mp" || var_4.basename == "stealth_bomb_mp")) {
      return;
    }
    self._id_019B notify("damage", var_2, var_1, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, var_4);
  }
}

_id_44DC(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < 600; var_3++) {
    wait 0.05;
  }
}

_id_44BF(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 16;
  }

  var_4 = 360 / var_3;
  var_5 = [];

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_4 * var_6;
    var_8 = cos(var_7) * var_1;
    var_9 = sin(var_7) * var_1;
    var_10 = var_0[0] + var_8;
    var_11 = var_0[1] + var_9;
    var_12 = var_0[2];
    var_5[var_5.size] = (var_10, var_11, var_12);
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_13 = var_5[var_6];

    if(var_6 + 1 >= var_5.size) {
      var_14 = var_5[0];
    } else {
      var_14 = var_5[var_6 + 1];
    }

    thread _id_44DC(var_13, var_14, var_2);
  }
}

_id_44EE(var_0, var_1) {
  for(var_2 = 0; var_2 < 600; var_2++) {
    wait 0.05;
  }
}

_id_ABD9(var_0, var_1, var_2, var_3, var_4) {
  self endon("death_or_disconnect");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  switch (var_1.basename) {
    case "apache_turret_mp":
    case "s4_molotov_mp":
    case "pac_sentry_turret_mp":
    case "thermite_ap_mp":
    case "s4_thermite_mp":
    case "thermite_av_mp":
    case "s4_stun_gbr_n69_mp":
      break;
    case "s4_sticky_eng_n74_mp":
    case "s4_frag_gbr_n82_mp":
    case "s4_frag_gbr_n23_mp":
    case "s4_bundle_charge_mp":
    case "s4_frag_ger_m24_mp":
    case "s4_semtex_mp":
    case "s4_frag_usa_mk2_mp":
    case "s4_c4_mp":
      _id_09C8::_id_0CF9("s4_frag_usa_mk2_mp", "explosion", 0.5);
      break;
    default:
      _id_0814::_id_D9D4(var_2, var_3);
      break;
  }
}

_id_FCA0() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self._id_9021 = scripts\engine\utility::ter_op(isDefined(self._id_E3A8), self._id_E3A8, _func_0375());
  self._id_90CB = scripts\engine\utility::ter_op(isDefined(self._id_E3A8), self._id_E3A8, _func_0375());
  self._id_8FC2 = scripts\engine\utility::ter_op(isDefined(self._id_E3A8), self._id_E3A8, _func_0375());
  self._id_8F9F = scripts\engine\utility::ter_op(isDefined(self._id_E3A8) && scripts\mp\utility\weapon::_id_8799(self._id_E3A8), self._id_E3A8, _func_0375());

  for(;;) {
    self waittill("weapon_change", var_0);
    self._id_90CB = var_0;

    if(_id_894F(var_0)) {
      self._id_9021 = var_0;
    }

    if(_id_8813(var_0)) {
      self._id_8FC2 = var_0;
    }

    if(scripts\mp\utility\weapon::_id_8799(var_0)) {
      self._id_8F9F = var_0;
    }

    if(!isbot(self)) {
      self setscriptablepartstate("bayoConfig", self._id_AC3D.bayovoice, 1);
    }
  }
}

_id_894F(var_0) {
  if(var_0.basename == "none") {
    return 0;
  }

  if(var_0.classname == "turret") {
    return 0;
  }

  if(scripts\mp\utility\weapon::_id_8A7D(var_0.basename)) {
    return 0;
  }

  if(scripts\mp\utility\weapon::_id_88F6(var_0.basename)) {
    return 0;
  }

  if(scripts\mp\utility\weapon::_id_8A54(var_0)) {
    return 0;
  }

  if(var_0._id_0241 != "primary" && var_0._id_0241 != "altmode") {
    return 0;
  }

  return 1;
}

_id_8813(var_0) {
  if(var_0.basename == "none") {
    return 0;
  }

  if(_id_885E(var_0.basename)) {
    return 0;
  }

  if(_id_8786(var_0.basename)) {
    return 0;
  }

  if(scripts\mp\utility\weapon::_id_88F6(var_0.basename)) {
    return 0;
  }

  if(scripts\mp\utility\weapon::_id_8A7D(var_0.basename)) {
    return 0;
  }

  if(var_0._id_0241 != "primary") {
    return 0;
  }

  if(var_0.classname == "turret") {
    return 0;
  }

  if(!scripts\mp\utility\weapon::_id_879A(var_0.basename) && !scripts\mp\utility\weapon::_id_879C(var_0.basename)) {
    return 0;
  }

  return 1;
}

_id_FCCB() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(var_0.basename == "none") {
      continue;
    } else if(scripts\mp\utility\weapon::_id_8A7D(var_0.basename)) {
      _id_FCCC();
      continue;
    } else if(scripts\mp\utility\weapon::_id_88F6(var_0.basename))
      continue;
    else if(var_0.basename == "s4_me_fists_mp_ls") {
      _id_FCCC();
      continue;
    } else if(var_0._id_0241 != "primary" && var_0._id_0241 != "altmode") {
      continue;
    }
    _id_FCCC();
  }
}

_id_6E8D() {
  var_0 = 2.0;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      if(scripts\mp\utility\weapon::_id_8A7D(var_2)) {
        var_3 = scripts\mp\supers::_id_6B69(var_2);
      } else if(scripts\mp\utility\weapon::_id_8876(var_2)) {
        var_3 = _id_6A61(var_2);
      } else {
        var_3 = _id_6E8C(var_2);
      }

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0) {
        var_0 = var_3;
      }
    }
  } else
    var_0 = 0.85;

  var_0 = _id_37FB(var_0);
  return var_0;
}

_id_6E8C(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(!isDefined(var_1) || !isDefined(level._id_10DB0[var_1]) || !isDefined(level._id_10DB0[var_1].speed)) {
    return 1.0;
  }

  return level._id_10DB0[var_1].speed;
}

_id_6A61(var_0) {
  return 0.93;
}

_id_37FB(var_0) {
  return clamp(var_0, 0.0, 1.0);
}

_id_FD7E(var_0) {
  if(isDefined(var_0)) {
    self._id_103D4 = var_0;
  }

  if(isDefined(self._id_AD1D)) {
    var_0 = self._id_AD1D;
  } else if(isDefined(self._id_AD63)) {
    var_0 = self._id_AD63;
    var_1 = scripts\mp\utility\weapon::_id_10D87(self getcurrentweapon());

    if(var_1 == 1) {
      var_0 = self._id_AD66;
    } else if(var_1 == 3) {
      var_0 = self._id_AD64;
    } else if(var_1 == 2) {
      var_0 = self._id_AD65;
    } else if(var_1 == 4) {
      var_0 = self._id_AD67;
    }
  } else if(isDefined(self._id_103D4))
    var_0 = self._id_103D4;
  else {
    var_0 = 1.0;
  }

  var_0 = clamp(var_0, 0.0, 1.0);
  self setviewkickscale(var_0);
}

_id_FCCC() {
  var_0 = undefined;

  if(isDefined(self._id_B7E4)) {
    var_0 = 1.0;
    var_0 = var_0 + self._id_B7E4;
  } else {
    var_0 = _id_6C62(self);

    if(isDefined(self._id_AD6C)) {
      var_0 = self._id_AD6C;
    }

    var_1 = self._id_3582;

    if(isDefined(var_1) && isDefined(var_1._id_E3F9)) {
      var_0 = var_0 + var_1._id_E3F9;
    }

    if(isDefined(self._id_61DA)) {
      var_0 = var_0 + self._id_61DA;
    }

    if(isDefined(self._id_4AAA)) {
      var_0 = var_0 + self._id_4AAA;
    }

    if(isDefined(self._id_E3FB)) {
      var_0 = var_0 + self._id_E3FB;
    }

    if(isDefined(self._id_A0B8)) {
      var_0 = var_0 + self._id_A0B8;
    }
  }

  self._id_10DD9 = var_0;

  if(!isDefined(self._id_3AC4)) {
    self._id_3AC4 = 1;
  }

  var_0 = var_0 + (self._id_A25F - 1.0);
  var_0 = var_0 + (self._id_3AC4 - 1.0);
  var_0 = clamp(var_0, 0.7, 1.4);

  if(isDefined(self._id_D9EA)) {
    var_0 = 1;
    thread monitorshellshock();
  }

  if(isDefined(self._id_59BC)) {
    var_0 = var_0 + self._id_59BC;
  }

  self setmovespeedscale(var_0);
}

monitorshellshock() {
  self endon("death_or_disconnect");
  self endon("monitor_shellshock");
  self notify("monitor_shellshock");
  self waittill("shellshock_updateMoveSpeed");
  _id_FCCC();
}

_id_6C62(var_0) {
  var_1 = 1.0;
  self.weaponlist = self getweaponslistprimaries();

  if(!self.weaponlist.size) {
    var_1 = 0.85;
  } else {
    var_2 = self getcurrentweapon();

    if(!isDefined(var_2)) {
      var_1 = _id_6E8D();
    } else if(scripts\mp\utility\weapon::_id_8A7D(var_2.basename)) {
      var_1 = scripts\mp\supers::_id_6B69(var_2);
    } else if(scripts\mp\utility\weapon::_id_8876(var_2.basename)) {
      var_1 = _id_6A61(var_2);
    } else if(scripts\mp\utility\weapon::_id_88F6(var_2.basename)) {
      var_1 = 0.85;
    } else if(scripts\mp\utility\weapon::_id_8888(var_2.basename)) {
      var_1 = 0.85;
    } else {
      if(var_2._id_0241 != "primary" && var_2._id_0241 != "altmode" || scripts\mp\utility\weapon::_id_8927(var_2)) {
        if(isDefined(self._id_9021)) {
          var_2 = self._id_9021;
        } else {
          var_2 = undefined;
        }
      }

      if(!self hasweapon(var_2)) {
        var_1 = _id_6E8D();
      } else {
        var_1 = _id_6E8C(var_2);
      }
    }
  }

  var_1 = _id_37FB(var_1);
  return var_1;
}

_id_E582() {
  if(!isPlayer(self)) {
    return;
  }
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self notifyonplayercommand("adjustedStance", "+stance");
  self notifyonplayercommand("adjustedStance", "+goStand");

  if(!self _meth_8684() && !isai(self)) {
    self notifyonplayercommand("adjustedStance", "+togglecrouch");
    self notifyonplayercommand("adjustedStance", "toggleprone");
    self notifyonplayercommand("adjustedStance", "+movedown");
    self notifyonplayercommand("adjustedStance", "-movedown");
    self notifyonplayercommand("adjustedStance", "+prone");
    self notifyonplayercommand("adjustedStance", "-prone");
  }

  for(;;) {
    scripts\engine\utility::waittill_any_3("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;
    var_0 = self getstance();
    _id_E583(var_0);
  }
}

_id_E583(var_0) {
  var_1 = self getcurrentprimaryweapon();
  var_2 = 0;

  if(_id_89F0(var_1)) {
    var_2 = _id_6CE6();
  }

  if(var_0 == "prone") {
    var_3 = scripts\mp\utility\weapon::getweapongroup(var_1);

    if(var_3 == "weapon_lmg") {
      scripts\mp\utility\weapon::_id_D69A(0, 0);
      return;
    }

    if(var_3 == "weapon_sniper") {
      if(var_1 _meth_8624("barrelbored", 1)) {
        scripts\mp\utility\weapon::_id_D69A(0, 0 + var_2);
        return;
      }

      scripts\mp\utility\weapon::_id_D69A(0, 0 + var_2);
      return;
      return;
    }

    scripts\mp\utility\weapon::_id_D69A();
    return;
    return;
  } else if(var_0 == "crouch") {
    var_3 = scripts\mp\utility\weapon::getweapongroup(var_1);

    if(var_3 == "weapon_lmg") {
      scripts\mp\utility\weapon::_id_D69A(0, 0);
      return;
    }

    if(var_3 == "weapon_sniper") {
      if(var_1 _meth_8624("barrelbored", 1)) {
        scripts\mp\utility\weapon::_id_D69A(0, 0 + var_2);
        return;
      }

      scripts\mp\utility\weapon::_id_D69A(0, 0 + var_2);
      return;
      return;
    }

    scripts\mp\utility\weapon::_id_D69A();
    return;
    return;
  } else if(var_2 > 0)
    scripts\mp\utility\weapon::_id_D69A(0, var_2);
  else {
    scripts\mp\utility\weapon::_id_D69A();
  }
}

_id_475B() {
  if(isDefined(level._id_7177)) {
    foreach(var_1 in level._id_7177) {
      if(isDefined(var_1) && !istrue(var_1._id_57CE) && !_id_8985(var_1)) {
        var_1 delete();
      }
    }
  }

  if(isDefined(level._id_9F7E)) {
    foreach(var_4 in level._id_9F7E) {
      if(isDefined(var_4) && !istrue(var_4._id_57CE) && !_id_8985(var_4)) {
        var_4 delete();
      }
    }
  }
}

_id_9EDF() {
  return 80;
}

_id_9ED2() {
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;
  var_1 = 1;
  var_2 = "hitequip";
  var_3 = undefined;

  for(;;) {
    self waittill("damage", var_4, var_0, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_3, var_12, var_13, var_14, var_15);
    var_3 = scripts\mp\utility\weapon::_id_9ACB(var_3, var_15);
    var_16 = var_0;

    if(!isPlayer(var_0) && !isagent(var_0)) {
      if(isDefined(var_0.owner) && isPlayer(var_0.owner)) {
        var_16 = var_0.owner;
      }
    }

    if(!isPlayer(var_16) && !isagent(var_16)) {
      continue;
    }
    if(isDefined(var_3) && _func_010C(var_3.basename, "betty_mp")) {
      continue;
    }
    if(!_id_5FB2(self.owner, var_16)) {
      continue;
    }
    if(_id_0A8B::_id_A5A7(var_16, var_3, var_15, var_7)) {
      continue;
    }
    var_17 = scripts\engine\utility::ter_op(_id_0A8B::_id_8866(var_3, var_7) || var_4 >= 80, 2, 1);
    var_1 = var_1 - var_17;
    _id_555D(self.owner, var_16, var_3, var_7);

    if(var_1 <= 0) {
      break;
    } else
      var_16 _id_07C4::_id_FC47(var_2);
  }

  self notify("mine_destroyed");

  if(isDefined(var_7) && (issubstr(var_7, "MOD_GRENADE") || issubstr(var_7, "MOD_EXPLOSIVE"))) {
    self._id_10A0B = 1;
  }

  if(isDefined(var_11) && var_11 &level._id_7CA1) {
    self._id_10A0F = 1;
  }

  if(isDefined(var_11) && var_11 &level._id_7CA3) {
    self._id_10A10 = 1;
  }

  self._id_10A0C = 1;

  if(isDefined(var_16)) {
    self._id_42F2 = var_16;
  }

  if(isDefined(self.killcament)) {
    self.killcament._id_42F2 = var_16;
  }

  if(isPlayer(var_16)) {
    var_16 _id_07C4::_id_FC47(var_2);

    if(var_16 != self.owner && var_16.team != self.owner.team) {
      var_16 scripts\mp\killstreaks\killstreaks::_id_6FEA(self, var_3);
      var_16 scripts\mp\battlechatter_mp::_id_555B(self);
      _id_07BC::_id_555B(var_15, var_0, var_4, var_11, undefined, var_3, undefined, var_16._id_9FFB);
      var_0 thread _id_07BC::createequipmentchallengeevent(var_0, var_3, "destroy_equipment");
    }
  }

  if(level.teambased) {
    if(isDefined(var_16) && isDefined(var_16.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers["team"])) {
      if(var_16.pers["team"] != self.owner.pers["team"]) {
        var_16 notify("destroyed_equipment");
      }
    }
  } else if(isDefined(self.owner) && isDefined(var_16) && var_16 != self.owner)
    var_16 notify("destroyed_equipment");

  _id_07BC::_id_9ED6(self, var_16, var_7);

  if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_16)) && self.weapon_name == "s4_mine_ger_s44_mp") {
    if(isDefined(self.owner) && self.owner._id_B1D0.size > 1) {
      self.owner thread _id_0A8D::_id_9137("sm_destroyed_m");
    } else {
      self.owner thread _id_0A8D::_id_9137("sm_destroyed_s");
    }
  }

  self notify("detonateExplosive", var_16);
}

_id_9EEE() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait(level._id_9EEF + randomfloat(0.4));
  self notify("mine_selfdestruct");
  self notify("detonateExplosive");
}

_id_9EDA() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", var_0);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  var_1 = self._id_3B73;
  var_2 = var_1._id_103C1;

  if(!isDefined(var_2)) {
    var_2 = "tag_fx";
  }

  var_3 = self gettagorigin(var_2);

  if(!isDefined(var_3)) {
    var_3 = self gettagorigin("tag_origin");
  }

  self notify("explode", var_3);
  waitframe();

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self hide();

  if(isDefined(var_1._id_AAE4)) {
    self thread[[var_1._id_AAE4]]();
  }

  if(isDefined(var_1._id_AAE5)) {
    self playSound(var_1._id_AAE5);
  }

  var_4 = scripts\engine\utility::ter_op(isDefined(var_1._id_AAE6), var_1._id_AAE6, level._id_9EC3);
  playFX(var_4, var_3);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_1._id_9ED1), var_1._id_9ED1, level._id_9ED1);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_1._id_9ED0), var_1._id_9ED0, level._id_9ED0);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1._id_9ED3), var_1._id_9ED3, level._id_9ED3);

  if(var_6 > 0) {
    self radiusdamage(self.origin, var_7, var_6, var_5, var_0, "MOD_EXPLOSIVE", self.weapon_name);
  }

  wait 0.2;
  _id_476C();
}

_id_4785() {
  if(isDefined(self._id_B1CE)) {
    foreach(var_1 in self._id_B1CE) {
      if(isDefined(var_1)) {
        var_1 _id_476C();
      }
    }
  }

  self._id_B1CE = [];

  if(isDefined(self._id_B1D0)) {
    foreach(var_1 in self._id_B1D0) {
      if(isDefined(var_1)) {
        var_1 _id_476C();
      }
    }
  }

  self._id_B1D0 = [];
  var_5 = scripts\mp\utility\game::isanymlgmatch();

  if(isDefined(self._id_B1CC)) {
    foreach(var_7, var_1 in self._id_B1CC) {
      if(isDefined(var_1) && (!var_5 || !istrue(var_1._id_8A74))) {
        var_1 _id_476C();
        self._id_B1CC[var_7] = undefined;
      }
    }

    self._id_B1CC = scripts\engine\utility::_id_1BD1(self._id_B1CC);
  }

  if(var_5 && isDefined(self._id_B1CF)) {
    foreach(var_7, var_1 in self._id_B1CF) {
      var_1 _id_476C();
      self._id_B1CF[var_7] = undefined;
    }

    self._id_B1CF = scripts\engine\utility::_id_1BD1(self._id_B1CF);
  }
}

_id_4765() {
  var_0 = scripts\mp\equipment::_id_69A4("primary");

  foreach(var_2 in self._id_B1CE) {
    if(isDefined(var_2)) {
      if(!isDefined(var_2._id_5562) || !isDefined(var_0) || var_2._id_5562 != var_0) {
        var_2 _id_476C();
      }
    }
  }

  var_4 = scripts\mp\equipment::_id_69A4("secondary");

  foreach(var_2 in self._id_B1D0) {
    if(isDefined(var_2)) {
      if(!isDefined(var_2._id_5562) || !isDefined(var_4) || var_2._id_5562 != var_4) {
        var_2 _id_476C();
      }
    }
  }
}

_id_555A(var_0, var_1) {
  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      var_2 = anglesToForward(var_1);
      var_3 = anglestoup(var_1);
      playFX(scripts\engine\utility::getfx("equipment_explode"), var_0, var_2, var_3);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), var_0, var_2, var_3);
    } else {
      playFX(scripts\engine\utility::getfx("equipment_explode"), var_0);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), var_0);
    }

    playsoundatpos(var_0, "mp_killstreak_disappear");
  } else if(isDefined(self)) {
    var_4 = self.origin;
    var_2 = anglesToForward(self.angles);
    var_3 = anglestoup(self.angles);
    playFX(scripts\engine\utility::getfx("equipment_explode"), var_4, var_2, var_3);
    playFX(scripts\engine\utility::getfx("equipment_smoke"), var_4, var_2, var_3);
    self playSound("mp_killstreak_disappear");
  }
}

_id_2CFD() {
  level._id_1DAB = [];
  level._id_1DAC = [];
  level._id_1D93 = [];
  level._id_10D64 = [];
  var_0 = [];
  var_1 = 1;

  for(var_2 = tablelookupbyrow("mp/attachmentmap.csv", var_1, 0); var_2 != ""; var_2 = tablelookupbyrow("mp/attachmentmap.csv", var_1, 0)) {
    var_0[var_0.size] = var_2;
    var_1++;
  }

  var_3 = [];
  var_4 = 1;
  var_5 = tablelookupbyrow("mp/attachmentmap.csv", 0, var_4);

  for(var_6 = scripts\common\utility::iscp(); var_5 != ""; var_5 = tablelookupbyrow("mp/attachmentmap.csv", 0, var_4)) {
    var_7 = scripts\engine\utility::string_starts_with(var_5, "zm");
    var_8 = !var_7 || var_6;

    if(var_8) {
      var_3[var_5] = var_4;
    }

    var_4++;
  }

  level._id_1DA2 = [];

  foreach(var_2 in var_0) {
    foreach(var_13, var_11 in var_3) {
      var_12 = _func_0222("mp/attachmentmap.csv", 0, var_2, var_11);

      if(var_12 == "") {
        continue;
      }
      if(!isDefined(level._id_1DA2[var_2])) {
        level._id_1DA2[var_2] = [];
      }

      level._id_1DA2[var_2][var_13] = var_12;

      if(!isDefined(level._id_1DAB[var_12])) {
        level._id_1DAB[var_12] = var_13;
        continue;
      }

      if(level._id_1DAB[var_12] != var_13) {}
    }
  }

  level.attachmentmap_combooverrides = [];
  var_15 = [];
  var_1 = 1;

  for(var_16 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", var_1, 0); var_16 != ""; var_16 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", var_1, 0)) {
    var_15[var_15.size] = var_16;
    var_1++;
  }

  var_17 = [];
  var_4 = 1;

  for(var_18 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", 0, var_4); var_18 != ""; var_18 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", 0, var_4)) {
    var_17[var_17.size] = var_18;
    var_4++;
  }

  foreach(var_16 in var_15) {
    foreach(var_11, var_18 in var_17) {
      var_21 = _func_0222("mp/attachmentmap_comboOverrides.csv", 0, var_16, var_11 + 1);

      if(var_21 == "") {
        continue;
      }
      if(!isDefined(level.attachmentmap_combooverrides[var_16])) {
        level.attachmentmap_combooverrides[var_16] = [];
      }

      level.attachmentmap_combooverrides[var_16][var_18] = var_21;
    }
  }

  foreach(var_32, var_24 in level._id_10DB0) {
    if(_func_00D6(var_32, 0, 4) == "iw8_") {
      var_25 = _func_00D6(var_32, 4);
    } else {
      var_25 = var_32;
    }

    var_26 = "mp/gunsmith/" + var_25 + "_progression.csv";

    if(!_func_0221(var_26)) {
      continue;
    }
    level._id_10D64[var_32] = [];
    var_1 = 1;
    var_27 = tablelookupbyrow(var_26, var_1, 0);
    var_28 = tablelookupbyrow(var_26, var_1, 1);

    if(_func_00D6(var_32, 0, 4) == "iw8_") {
      var_29 = "loot/iw8_" + var_25 + "_attachment_ids.csv";
    } else {
      var_29 = "loot/" + var_25 + "_attachment_ids.csv";
    }

    while(var_27 != "") {
      if(var_28 != "") {
        var_30 = _func_0222(var_29, 0, var_28, 1);

        if(var_30 != "") {
          level._id_10D64[var_32][var_30] = var_30;
        }
      }

      var_31 = tablelookupbyrow(var_26, var_1, 5);

      if(var_31 != "") {
        var_30 = _func_0222(var_29, 0, var_31, 1);

        if(var_30 != "") {
          level._id_10D64[var_32][var_30] = var_30;
        }
      }

      var_1++;
      var_27 = tablelookupbyrow(var_26, var_1, 0);
      var_28 = tablelookupbyrow(var_26, var_1, 1);
    }
  }

  level._id_1DA0 = [];
  level._id_1D9F = [];
  level._id_1DA1 = [];
  level._id_1DAA = [];
  var_33 = _id_68E3();

  foreach(var_35 in var_33) {
    var_36 = _func_0222("mp/attachmenttable.csv", 4, var_35, 2);
    var_37 = scripts\mp\utility\weapon::_id_1DA5(var_35);

    if(var_36 != "" && isDefined(var_37)) {
      var_38 = level._id_1DA1[var_37];

      if(!isDefined(var_38)) {
        level._id_1DA1[var_37] = var_36;
      } else if(var_36 != var_38) {
        level._id_1DAA[var_35] = var_36;
      }
    }

    var_39 = _func_0222("mp/attachmenttable.csv", 4, var_35, 12);

    if(var_39 != "") {
      level._id_1DA0[var_35] = var_39;
    }

    var_40 = _func_0222("mp/attachmenttable.csv", 4, var_35, 13);

    if(var_40 != "") {
      level._id_1DAC[var_35] = var_40;
      level._id_1D93[var_40] = 1;
    }

    var_41 = _func_0222("mp/attachmenttable.csv", 4, var_35, 9);

    if(var_41 != "") {
      level._id_1D9F[var_35] = var_41;
    }
  }

  level._id_1DA3 = [];
  var_43 = 1;

  for(var_44 = tablelookupbyrow("mp/attachmentcombos.csv", var_43, 0); var_44 != ""; var_44 = tablelookupbyrow("mp/attachmentcombos.csv", var_43, 0)) {
    var_46 = 1;

    for(var_45 = tablelookupbyrow("mp/attachmentcombos.csv", 0, var_46); var_45 != ""; var_45 = tablelookupbyrow("mp/attachmentcombos.csv", 0, var_46)) {
      if(var_43 != var_46) {
        var_47 = tablelookupbyrow("mp/attachmentcombos.csv", var_43, var_46);

        if(!isDefined(level._id_1DA3[var_44])) {
          level._id_1DA3[var_44] = [];
        }

        if(var_47 != "") {
          level._id_1DA3[var_44][var_45] = var_47;
        }
      }

      var_46++;
    }

    var_43++;
  }
}

_id_68E3() {
  var_0 = [];
  var_1 = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = tablelookupbyrow("mp/attachmenttable.csv", var_2, 0);
    var_3 = int(var_3);

    if(var_3 == 0) {
      continue;
    }
    var_4 = _func_0222("mp/attachmenttable.csv", 0, var_3, 4);

    if(var_4 != "") {
      var_0[var_4] = var_4;
    }
  }

  return var_0;
}

_id_2D18() {
  level._id_10DB0 = [];
  level._id_10D98 = [];
  var_0 = tablelookupgetnumrows("mp/statstable.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("mp/statstable.csv", var_1, 0);
    var_2 = int(var_2);

    if(var_2 == 0) {
      continue;
    }
    var_3 = _func_0222("mp/statstable.csv", 0, var_2, 4);

    if(var_3 != "") {
      level._id_10DB0[var_3] = spawnStruct();
      var_4 = _func_0222("mp/statstable.csv", 0, var_2, 0);

      if(var_4 != "") {
        level._id_10DB0[var_3]._id_A76E = var_4;
      }

      var_5 = _func_0222("mp/statstable.csv", 0, var_2, 1);

      if(var_5 != "") {
        level._id_10DB0[var_3]._id_71F4 = var_5;
        var_6 = _func_0222("mp/statstable.csv", 0, var_2, 41);

        if(var_6 != "") {
          var_7 = int(var_6);

          if(var_7 > -1) {
            if(!isDefined(level._id_10D98[var_5])) {
              level._id_10D98[var_5] = [];
            }

            level._id_10D98[var_5][level._id_10D98[var_5].size] = var_3;
          } else
            level._id_10DB0[var_3]._id_F91D = 1;
        }
      }

      var_8 = _func_0222("mp/statstable.csv", 0, var_2, 5);

      if(var_8 != "") {
        level._id_10DB0[var_3]._id_1CED = var_8;
      }

      var_9 = _func_0222("mp/statstable.csv", 0, var_2, 44);

      if(var_9 != "") {
        level._id_10DB0[var_3]._id_AFA5 = var_9;
      }

      var_10 = _func_0222("mp/statstable.csv", 0, var_2, 9);
      var_11 = _id_AE6C(var_10);

      if(isDefined(var_11)) {
        level._id_10DB0[var_3]._id_1D7B = var_11;
      }

      var_12 = _func_0222("mp/statstable.csv", 0, var_2, 8);

      if(var_12 != "") {
        var_12 = float(var_12);
        level._id_10DB0[var_3].speed = var_12;
      }

      var_13 = _func_0222("mp/statstable.csv", 0, var_2, 61);

      if(var_13 != "") {
        if(var_13 == "1") {
          level._id_10DB0[var_3]._id_8B15 = 1;
        } else {
          level._id_10DB0[var_3]._id_8B15 = 0;
        }
      } else
        level._id_10DB0[var_3]._id_8B15 = 0;
    }
  }

  level._id_10DAC = [];
  var_14 = -1;

  for(;;) {
    var_14++;
    var_15 = tablelookupbyrow("loot/weapon_ids.csv", var_14, 0);

    if(var_15 == "") {
      break;
    }

    var_3 = tablelookupbyrow("loot/weapon_ids.csv", var_14, 1);
    var_16 = tablelookupbyrow("loot/weapon_ids.csv", var_14, 9);
    var_17 = scripts\mp\utility\weapon::_id_6E93(var_3);
    var_18 = _func_0222(var_17, 1, var_16, 0);

    if(var_18 == "") {
      continue;
    }
    var_19 = var_3 + "|" + var_18;
    level._id_10DAC[var_19] = spawnStruct();
    level._id_10DAC[var_19]._id_04CC = int(var_18);
    var_20 = _func_0222(var_17, 1, var_16, 3);

    if(var_20 != "") {
      level._id_10DAC[var_19]._id_1CEE = var_20;
    }

    var_21 = _func_0222("loot/weapon_ids.csv", 9, var_16, 5);
    level._id_10DAC[var_19]._id_8912 = int(var_18) != 0 && int(var_21) == 99;
    var_22 = _func_0222(var_17, 1, var_16, 4);
    var_11 = _id_AE6C(var_22);

    if(isDefined(var_11)) {
      if(isDefined(level._id_10DB0[var_3]) && isDefined(level._id_10DB0[var_3]._id_1D7B)) {
        var_11 = scripts\engine\utility::_id_1B9E(var_11, level._id_10DB0[var_3]._id_1D7B);
      }

      level._id_10DAC[var_19]._id_1D7B = var_11;
    }

    var_23 = [];

    for(var_24 = 5; var_24 <= 15; var_24++) {
      var_25 = _func_0222(var_17, 1, var_16, var_24);

      if(var_25 != "") {
        var_26 = strtok(var_25, "|");

        if(var_26.size == 2) {
          var_23[var_26[0]] = int(var_26[1]);
        } else {
          var_23[var_26[0]] = 0;
        }
      }
    }

    if(var_23.size > 0) {
      level._id_10DAC[var_19]._id_1D78 = var_23;
    }

    var_27 = _func_0222(var_17, 1, var_16, 16);

    if(var_27 != "") {
      var_28 = [];
      var_29 = strtok(var_27, " ");

      foreach(var_31 in var_29) {
        var_32 = strtok(var_31, "|");

        if(var_32.size != 2) {
          continue;
        }
        var_28[var_32[0]] = int(var_32[1]);
      }

      if(var_28.size > 0) {
        level._id_10DAC[var_19]._id_1D86 = var_28;
      }
    }
  }
}

_id_AE6C(var_0) {
  if(var_0 != "") {
    var_1 = strtok(var_0, " ");
    var_2 = [];

    foreach(var_4 in var_1) {
      var_5 = strtok(var_4, "|");

      if(getdvarint("#x3ae126b167405781f", 1) == 0) {
        if(scripts\engine\utility::string_starts_with(var_5[0], "select")) {
          continue;
        }
      }

      if(var_5.size == 2) {
        var_2[var_5[0]] = int(var_5[1]);
        continue;
      }

      var_2[var_5[0]] = 0;
    }

    return var_2;
  }

  return undefined;
}

_id_717C(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    var_0._id_EA8F = var_1;
    var_1._id_EA8D = var_0;
    var_1._id_EA8E = var_0.owner;
  } else if(level.teambased && isDefined(var_1.team) && var_1.team == self.team)
    var_0._id_8A69 = "friendly";
  else {
    var_3 = undefined;
    var_4 = "incoming_stuck";

    switch (var_0.weapon_name) {
      case "s4_sticky_eng_n74_mp":
      case "s4_semtex_mp":
        var_3 = "sticky_stuck";
        var_4 = "stuck_sticky";
        break;
      case "s4_molotov_mp":
        var_3 = "molotov_stuck";
        var_4 = "flavor_surprise";
        break;
      case "s4_thermite_mp":
        var_3 = "thermite_attacker_stuck";
        var_4 = "stuck_thermite";
        break;
    }

    var_0._id_8A69 = "enemy";
    var_0._id_EA8F = var_1;
    var_1._id_EA8D = var_0;
    var_1._id_EA8E = var_0.owner;
    self notify("grenade_stuck_enemy");
    level thread scripts\mp\battlechatter_mp::_id_F759(var_1, var_4);
    level thread scripts\mp\battlechatter_mp::_id_F759(var_0.owner, "flavor_stuckenemy");

    if(!istrue(var_2)) {
      _id_717D(var_3, var_1);
    }
  }
}

_id_717D(var_0, var_1) {
  var_2 = self;

  if(isPlayer(var_1) && isDefined(var_0)) {
    if(isDefined(var_2.owner)) {
      var_2 = var_2.owner;
    }

    var_2 scripts\mp\hud_message::showsplash(var_0);
  }

  var_2 thread _id_07B1::_id_6FB9("explosive_stick");
}

_id_ACD8(var_0) {}

_id_AD01(var_0, var_1) {
  if(level.teambased) {
    thread _id_AD03(var_0, var_1);
  } else {
    thread _id_AD02(var_0, var_1);
  }
}

_id_AD03(var_0, var_1) {
  var_2 = scripts\mp\utility\outline::_id_ACD2(var_0, var_1.team, "outline_nodepth_cyan", "killstreak");
  var_0 waittill("death");
  scripts\mp\utility\outline::outlinedisable(var_2, var_0);
}

_id_AD02(var_0, var_1) {
  var_2 = scripts\mp\utility\outline::outlineenableforplayer(var_0, var_1, "outline_nodepth_cyan", "killstreak");
  var_0 waittill("death");
  scripts\mp\utility\outline::outlinedisable(var_2, var_0);
}

_id_7166() {
  return istrue(self._id_7166);
}

_id_7165() {
  self._id_7166 = !isnullweapon(self getheldoffhand());
}

_id_F3BF(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
  var_3 = scripts\engine\trace::_id_C051(var_0, var_1, level.players, var_2, undefined, 1);
  return var_3;
}

_id_7D5F(var_0, var_1) {
  var_2 = var_0 + var_1 * 4096;
  return var_2;
}

_id_7D5B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_1 endon("death_or_disconnect");

  if(!isDefined(var_1._id_25CA)) {
    return;
  }
  playFX(scripts\engine\utility::getfx("penetration_railgun_impact"), var_4);
  var_9 = _id_7D5F(var_4, var_5);
  var_10 = _id_F3BF(var_4, var_9);
  var_9 = var_10["position"] - var_5 * 12;
  var_11 = length(var_9 - var_4);
  var_12 = var_11 / 1000;
  var_12 = max(var_12, 0.05);

  if(var_10["hittype"] != "hittype_world") {
    var_12 = 0;
  }

  var_13 = var_12 > 0.05;

  if(isDefined(var_1)) {
    var_1._id_25CA startragdoll();
  }

  waitframe();

  if(var_13) {
    var_14 = var_5;
    var_15 = anglestoup(var_0.angles);
    var_16 = _func_025B(var_14, var_15);
    var_17 = scripts\engine\utility::spawn_tag_origin(var_4, _func_0017(var_14, var_16, var_15));
    var_17 moveto(var_9, var_12);
    var_18 = _func_0212(var_1._id_25CA, var_6, var_7, var_8);
    var_18.origin = var_17.origin;
    var_18.angles = var_17.angles;
    var_18 linkto(var_17);

    if(var_12 > 1) {
      thread _id_7D5D(var_18, 1);
    }

    thread _id_7D5C(var_1, var_17, var_12 + 0.25);
    var_17 thread _id_7D5E(var_9, var_12);
  }
}

_id_7D5D(var_0, var_1) {
  wait(var_1);

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_7D5E(var_0, var_1) {
  wait(clamp(var_1 - 0.05, 0.05, 20));
  playFX(scripts\engine\utility::getfx("vfx_penetration_railgun_impact"), var_0);
}

_id_7D5C(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 scripts\engine\utility::_id_108A7(var_2, "death_or_disconnect");
  }

  var_1 delete();
}

_id_00F5(var_0, var_1) {
  return [1.0, 1.0];
}

_id_D675() {
  if(!isDefined(self._id_8A6C)) {
    self._id_8A6C = 1;
  } else {
    self._id_8A6C++;
  }

  thread playstunvo();
}

playstunvo() {
  self endon("death");
  self endon("disconnect");
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "effort_concussed");
  wait(_func_0142(self._id_AC3D.voiceprefix + self._id_AC3D._id_10691 + "_econ", 1) / 1000);
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_concussed");
}

_id_D679() {
  if(isDefined(self._id_8A6C) && self._id_8A6C > 0) {
    self._id_8A6C--;
  }
}

_id_8A6C() {
  return isDefined(self._id_4427) && isDefined(self._id_4427["s4_stun_gbr_n69_mp"]);
}

_id_D65A() {
  if(!isDefined(self._id_8780)) {
    self._id_8780 = 1;
  } else {
    self._id_8780++;
  }

  thread playblindedvo();
}

playblindedvo() {
  self endon("death");
  self endon("disconnect");
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "effort_blinded");
  wait(_func_0142(self._id_AC3D.voiceprefix + self._id_AC3D._id_10691 + "_ebld", 1) / 1000);
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_blinded");
}

_id_D678() {
  self._id_8780--;
}

_id_8780() {
  return isDefined(self._id_4427) && isDefined(self._id_4427["flash_grenade_mp"]);
}

_id_8781(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = "flash_grenade_mp";
  var_2 = var_0 getentitynumber();

  if(isDefined(self._id_4427) && isDefined(self._id_4427[var_1]) && isDefined(self._id_4427[var_1][var_2])) {
    return 1;
  }

  return 0;
}

_id_8A6D(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = "s4_stun_gbr_n69_mp";
  var_2 = var_0 getentitynumber();

  if(isDefined(self._id_4427) && isDefined(self._id_4427[var_1]) && isDefined(self._id_4427[var_1][var_2])) {
    return 1;
  }

  return 0;
}

_id_8A6E() {
  return _id_8780() || _id_8A6C();
}

_id_3879(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait(var_0);
  _id_D679();
}

_id_19F4() {
  self endon("death_or_disconnect");
  wait 0.1;

  if(isDefined(self) && isPlayer(self) && !isbot(self)) {
    self playlocalsound("sonic_shotgun_debuff");
    self _meth_867F("sonic_shotgun_impact");
  }
}

_id_10B8C() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("weapon_switch_invalid", var_0);
    var_1 = self getcurrentweapon();

    if(var_1._id_0241 == "item" || var_1._id_0241 == "exclusive") {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self._id_8FC2);
    }
  }
}

_id_10D9E(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_2 = getweaponattachments(var_0);

  foreach(var_4 in var_2) {
    var_5 = _id_1D94(var_4);

    if(var_5 == "rail") {
      var_6 = scripts\mp\utility\weapon::_id_1DA5(var_4);

      if(scripts\mp\utility\weapon::_id_1D9B(var_1, var_6)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_10AD3() {
  self endon("disconnect");
  self notify("watchDropWeapons");
  self endon("watchDropWeapons");

  for(;;) {
    self waittill("weapon_dropped", var_0, var_1);

    if(isDefined(var_0) && isDefined(var_1)) {
      if(!scripts\mp\utility\weapon::_id_8929(var_1) && !scripts\mp\utility\weapon::_id_8927(var_1) && !scripts\mp\utility\weapon::_id_88F9(var_1)) {
        if(var_0 _meth_846D() > 0) {
          var_0 physics_registerforcollisioncallback();
          var_0 thread _id_10D7A();
        }
      } else if(scripts\mp\utility\weapon::_id_8929(var_1) && !scripts\mp\utility\weapon::_id_8927(var_1) && !scripts\mp\utility\weapon::_id_88F9(var_1)) {
        if(var_0 _meth_846D() > 0) {
          var_0 physics_registerforcollisioncallback();
          var_0 thread _id_10D7A();
        }
      }

      reactivecamodropweapon(var_0, var_1);
    }
  }
}

_id_10D7A() {
  self endon("death");
  self endon("timeout");
  thread _id_10D7B(2);
  self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  if(isDefined(self.classname) && _func_00D6(self.classname, 0, 6) == "weapon") {
    var_8 = _func_02CA(var_3);
    var_9 = _func_00D6(var_8["name"], 9);

    if(var_9 == "user_terrain1") {
      var_9 = "user_terrain_1";
    }

    switch (_func_00D6(self.classname, 0, 12)) {
      case "weapon_s4_me":
        if(_func_00D6(self.classname, 0, 18) == "weapon_s4_me_knife") {
          self _meth_8281("wpn_drop_knife", var_9);
        } else if(_func_00D6(self.classname, 0, 20) == "weapon_s4_me_rindigo") {
          self _meth_8281("wpn_drop_ar", var_9);
        } else {
          self _meth_8281("wpn_drop_ar", var_9);
        }

        break;
      case "weapon_s4_ar":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon._id_0295) && self.objweapon._id_0295 == "polymer") {
            self _meth_8281("wpn_drop_med_poly", var_9);
          } else {
            self _meth_8281("wpn_drop_ar", var_9);
          }
        } else
          self _meth_8281("wpn_drop_ar", var_9);

        break;
      case "weapon_s4_sm":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon._id_0295) && self.objweapon._id_0295 == "polymer") {
            self _meth_8281("wpn_drop_small_poly", var_9);
          } else {
            self _meth_8281("wpn_drop_smg", var_9);
          }
        } else
          self _meth_8281("wpn_drop_smg", var_9);

        break;
      case "weapon_s4_mg":
        self _meth_8281("wpn_drop_lmg", var_9);
        break;
      case "weapon_s4_sh":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon._id_0295) && self.objweapon._id_0295 == "polymer") {
            self _meth_8281("wpn_drop_med_poly", var_9);
          } else {
            self _meth_8281("wpn_drop_sn", var_9);
          }
        } else
          self _meth_8281("wpn_drop_sn", var_9);

        break;
      case "weapon_s4_mr":
        self _meth_8281("wpn_drop_sn", var_9);
        break;
      case "weapon_s4_pi":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon._id_0295) && self.objweapon._id_0295 == "polymer") {
            self _meth_8281("wpn_drop_pistol_poly", var_9);
          } else {
            self _meth_8281("wpn_drop_pistol", var_9);
          }
        } else
          self _meth_8281("wpn_drop_pistol", var_9);

        break;
      case "weapon_s4_la":
        self _meth_8281("wpn_drop_launcher", var_9);
        break;
      default:
        self _meth_8281("wpn_drop_ar", var_9);
        break;
    }
  }
}

_id_10D7B(var_0) {
  wait(var_0);
  self notify("timeout");
}

_id_1FD7(var_0) {
  level endon("game_ended");
  var_1 = var_0 _meth_8150();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_3.weapon_name;
    var_5 = var_3.owner;
    var_6 = var_3.origin;

    if(isDefined(var_4) && scripts\mp\utility\weapon::_id_8774(var_4)) {
      var_3 _id_C2F0(var_4, var_5);
    }
  }
}

_id_C2F0(var_0, var_1) {
  self unlink();
  var_2 = scripts\mp\utility\weapon::_id_6E6A(var_0);
  var_3 = _func_00D6(var_0, var_2.size);
  var_4 = var_1 scripts\mp\utility\weapon::_id_0C48(var_2, self.origin, (0, 0, 0), 100, 1, self);
  var_4 setentityowner(var_1);
  var_4 thread scripts\cp_mp\utility\throwing_weapon::_id_10B6D(var_1, self.weapon_name);
}

_id_2F26(var_0, var_1, var_2, var_3) {
  _id_FD8F(var_0, var_1, var_2, var_3);
  var_4 = self._id_10D6A;

  if(isDefined(var_4)) {
    foreach(var_6 in var_4._id_2F52) {
      self[[var_6]](var_0, var_1);
    }

    foreach(var_6 in var_4._id_AAD1) {
      self[[var_6]](var_0, var_1);
    }

    var_4._id_AAD1 = [];
  }
}

_id_FD8F(var_0, var_1, var_2, var_3) {
  if((var_1.basename == "none" || var_1.basename == "alt_none") && isDefined(self._id_8FC1)) {
    if(var_1 == "alt_none") {
      var_3 = 1;
    } else {
      var_3 = 0;
    }

    var_1 = self._id_8FC1;
  }

  _id_3996(var_1, var_3);
  _id_CA7D(var_0, var_2);
}

_id_CA7D(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_1) && var_1 == 1) {
    var_2 = "alt_" + scripts\mp\utility\weapon::_id_6E6A(var_0);
  } else {
    var_2 = scripts\mp\utility\weapon::_id_6E6A(var_0);
  }
}

_id_3996(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_1) && var_1 == 1) {
    var_2 = "alt_" + scripts\mp\utility\weapon::_id_6E6A(var_0);
  } else {
    var_2 = scripts\mp\utility\weapon::_id_6E6A(var_0);
  }

  switch (var_2) {
    case "s4_la_walpha2_mp":
      break;
    default:
      break;
  }
}

_id_FC24(var_0, var_1) {
  if(weaphasreactivecamo(var_1)) {
    _id_392A();
  }

  _id_CA28(var_0);
}

_id_CA28(var_0) {
  if(!getdvarint("#x3b1d87d8e0b53e10", 1)) {
    return;
  }
  if(weaphasreactivecamo(var_0)) {
    thread reactivecamo(var_0);
    thread devreactivecamo(var_0);
  } else
    self setscriptablepartstate("activeCamo", "no_stage");

  var_1 = _func_00ED(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "camo84":
      thread _id_25AA();
      break;
  }
}

_id_392A() {
  self notify("endReactiveCamoThread");
  self setscriptablepartstate("activeCamo", "no_stage");
}

reactivecamoresetwhenprematchdone() {
  _id_07D1::_id_60C2("prematch_done");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && isDefined(var_1.reactivecamoweapons)) {
      foreach(var_3 in var_1.reactivecamoweapons) {
        var_3._id_0267 = 0;

        if(var_3.stage > 0) {
          reactivecamosetstage(var_3, 0, 0);
        }
      }
    }
  }
}

reactivecamosetstage(var_0, var_1, var_2) {
  var_0.stage = var_1;

  if(var_2 == 1) {
    self setscriptablepartstate("activeCamo", "stage" + var_0.stage);
  } else {
    self setscriptablepartstate("activeCamo", "init_stage" + var_0.stage);
  }
}

reactivecamoinittostage(var_0, var_1, var_2) {
  var_3 = reactivecamosetup(var_0);
  var_4 = self.reactivecamoweapons[var_3];

  if(var_2 != self) {
    var_4.laststage = var_4.stage;
    var_4.lastkills = var_4._id_0267;
    thread reactivecamowatchdeath(var_4);
  }

  reactivecamosetstage(var_4, var_1, 0);
}

reactivecamoresetweapon(var_0) {
  var_0.stage = var_0.laststage;
  var_0._id_0267 = var_0.lastkills;
}

reactivecamodropweapon(var_0, var_1) {
  if(!weaphasreactivecamo(var_1)) {
    return;
  }
  cachereactivecamostageonweaponitem(var_0, var_1);

  if(isDefined(var_0.owner) && var_0.owner != self) {
    var_2 = weapongetreactivecamolookup(var_1);

    if(isDefined(self.reactivecamoweapons)) {
      var_3 = self.reactivecamoweapons[var_2];

      if(isDefined(var_3) && isDefined(var_3.lastkills) && isDefined(var_3.laststage)) {
        reactivecamoresetweapon(var_3, var_1);
      }
    }
  }
}

reactivecamowatchdeath(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  self waittill("death");

  if(self hasweapon(var_1)) {
    reactivecamoresetweapon(var_0);
  }

  if(isDefined(self.reactivecamoweapons)) {
    foreach(var_0 in self.reactivecamoweapons) {
      if(var_0.resetondeath) {
        var_0.stage = 0;
        var_0._id_0267 = 0;
      }
    }
  }
}

reactivecamowatchgesturenotetracks(var_0) {
  self endon("disconnect");
  self.reactivecamocurprocgestures = [];

  if(!isDefined(level.reactivecamoexcludedgestures)) {
    level.reactivecamoexcludedgestures = [];
  }

  scripts\engine\utility::array_add(self.handledreactivecamontweapons, var_0);

  for(;;) {
    if(!self hasweapon(var_0)) {
      scripts\engine\utility::array_remove(self.handledreactivecamontweapons, var_0);
      return;
    }

    if(!self _meth_84B7() && !self _meth_887C() || var_0 != self getcurrentweapon()) {
      waitframe();
      continue;
    }

    if(self _meth_84B7()) {
      var_1 = self _meth_84AE();

      foreach(var_3 in var_1) {
        if(scripts\engine\utility::array_contains(self.reactivecamocurprocgestures, var_3) || scripts\engine\utility::array_contains(level.reactivecamoexcludedgestures, var_3)) {
          waitframe();
          continue;
        }

        var_4 = self _meth_8879(var_3, "rac_");

        if(var_4.size > 0) {
          var_5 = self _meth_887A(var_3);
          var_6 = self _meth_8495(var_3);

          if(var_5 > var_6 * 0.75) {
            waitframe();
            continue;
          }

          thread end_watcher_gesture(var_3);
          thread reactivecamonotetrackwatcher(var_4, var_0, var_5, var_6, var_3);
          continue;
        }

        level.reactivecamoexcludedgestures = scripts\engine\utility::array_add(level.reactivecamoexcludedgestures, var_3);
      }
    } else if(self _meth_887C()) {
      if(scripts\engine\utility::array_contains(self.reactivecamocurprocgestures, var_0.basename) || scripts\engine\utility::array_contains(level.reactivecamoexcludedgestures, var_0.basename)) {
        waitframe();
        continue;
      }

      var_4 = self _meth_887F("rac_");

      if(var_4.size > 0) {
        var_8 = self _meth_887D();
        var_9 = self _meth_887E();

        if(var_8 > var_9 * 0.75) {
          waitframe();
          continue;
        }

        thread end_watcher_inspect(var_0.basename);
        thread reactivecamonotetrackwatcher(var_4, var_0, var_8, var_9, var_0.basename);
      } else
        level.reactivecamoexcludedgestures = scripts\engine\utility::array_add(level.reactivecamoexcludedgestures, var_0.basename);
    }

    waitframe();
  }
}

end_watcher_gesture(var_0) {
  while(self _meth_84B7(var_0)) {
    waitframe();
  }

  self notify("cancel_reactive_watcher");
  self.reactivecamocurprocgestures = scripts\engine\utility::array_remove(self.reactivecamocurprocgestures, var_0);
}

end_watcher_inspect(var_0) {
  while(self _meth_887C()) {
    waitframe();
  }

  self notify("cancel_reactive_watcher");
  self.reactivecamocurprocgestures = scripts\engine\utility::array_remove(self.reactivecamocurprocgestures, var_0);
}

reactivecamonotetrackcomparefunc(var_0, var_1) {
  return var_0._id_110F4 < var_1._id_110F4;
}

reactivecamonotetrackwatcher(var_0, var_1, var_2, var_3, var_4) {
  self endon("cancel_reactive_watcher");
  self.reactivecamocurprocgestures = scripts\engine\utility::array_add(self.reactivecamocurprocgestures, var_4);
  var_0 = scripts\engine\utility::_id_1BD6(var_0, ::reactivecamonotetrackcomparefunc);
  var_5 = 0.0;

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_0[var_6];

    if(var_7._id_110F4 * var_3 < var_2) {
      reactivecamoprocessnotetrack(var_7.name, var_1);
      continue;
    }

    break;
  }

  var_5 = var_2;

  for(var_8 = var_6; var_8 < var_0.size; var_8++) {
    var_9 = var_0[var_8]._id_110F4 * var_3;
    wait(var_9 - var_5);
    var_5 = var_9;
    reactivecamoprocessnotetrack(var_0[var_8].name, var_1);
  }

  wait(var_3 - var_5);
  self.reactivecamocurprocgestures = scripts\engine\utility::array_remove(self.reactivecamocurprocgestures, var_4);
}

reactivecamoprocessnotetrack(var_0, var_1) {
  var_2 = getreactivecamostagecount(var_1);
  var_3 = getreactivecamostage(var_1);
  var_4 = 0;
  var_0 = _func_00D6(var_0, 4);
  var_5 = strtok(var_0, ",");

  if(var_5[0] == "increment") {
    if(var_5.size > 1 && var_5[1] == "cyclical") {
      var_3 = (var_3 + 1) % var_2;
      var_4 = 2;
    } else {
      var_3 = int(min(var_3 + 1, var_2 - 1));
      var_4 = 1;
    }
  } else if(var_5[0] == "set" && var_5.size > 1) {
    var_3 = int(var_5[1]);
    var_3 = int(clamp(var_3, 0, var_2));
    var_4 = 2;
  }

  var_6 = 0;

  if(var_5.size > var_4) {
    var_6 = int(var_5[var_4]) == 1;
  }

  setreactivecamostage(var_1, var_3, var_6);
}

reactivecamosetup(var_0) {
  var_1 = weapongetreactivecamolookup(var_0);

  if(!isDefined(self.reactivecamoweapons)) {
    self.reactivecamoweapons = [];
  }

  if(!isDefined(self.reactivecamoweapons[var_1])) {
    self.reactivecamoweapons[var_1] = spawnStruct();
    self.reactivecamoweapons[var_1]._id_0267 = 0;
    self.reactivecamoweapons[var_1].stage = 0;
    self.reactivecamoweapons[var_1].owner = self;
    self.reactivecamoweapons[var_1].resetondeath = var_0 _meth_8888();
  }

  return var_1;
}

cachereactivecamostageonweaponitem(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(weaphasreactivecamo(var_1)) {
    var_2 = getreactivecamostage(var_1);

    if(var_2 >= 0) {
      var_0.reactivecamoindex = var_2;

      if(!isDefined(var_0.owner)) {
        var_0.owner = self;
      }
    }
  }
}

getreactivecamostage(var_0) {
  if(!isDefined(var_0) || !isDefined(self.reactivecamoweapons)) {
    return -1;
  }

  var_1 = weapongetreactivecamolookup(var_0);

  if(!isDefined(self.reactivecamoweapons[var_1])) {
    return -1;
  }

  return self.reactivecamoweapons[var_1].stage;
}

setreactivecamostage(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_3 = reactivecamosetup(var_0);
  var_4 = self.reactivecamoweapons[var_3];
  reactivecamosetstage(var_4, var_1, var_2);
}

getreactivecamostagecount(var_0) {
  var_1 = var_0 _meth_8876();
  return var_1.size;
}

reactivecamo(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("endReactiveCamoThread");

  if(!isDefined(level.reactivecamoprematchthreadstarted) && !_id_07D1::_id_60BE("prematch_done")) {
    level.reactivecamoprematchthreadstarted = 1;
    level thread reactivecamoresetwhenprematchdone();
  }

  var_1 = reactivecamosetup(var_0);

  if(!isDefined(self.handledreactivecamontweapons)) {
    self.handledreactivecamontweapons = [];
  }

  if(!scripts\engine\utility::array_contains(self.handledreactivecamontweapons, var_0)) {
    thread reactivecamowatchgesturenotetracks(var_0);
  }

  var_2 = self.reactivecamoweapons[var_1];
  reactivecamosetstage(var_2, var_2.stage, 0);
  var_3 = var_0 _meth_8876();
  var_4 = int(var_3.size - 1);

  for(;;) {
    scripts\engine\utility::_id_108C5("got_a_kill", "scr_advancereactivecamo");
    var_5 = int(var_3[int(min(var_2.stage + 1, var_4))]);
    var_2._id_0267++;

    if(var_2._id_0267 == var_5) {
      reactivecamosetstage(var_2, var_2.stage + 1, 1);

      if(!self isswitchingweapon()) {}
    }
  }
}

devreactivecamo(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("endReactiveCamoThread");

  if(!isDefined(level.reactivecamoprematchthreadstarted) && !_id_07D1::_id_60BE("prematch_done")) {
    level.reactivecamoprematchthreadstarted = 1;
    level thread reactivecamoresetwhenprematchdone();
  }

  var_1 = reactivecamosetup(var_0);

  for(;;) {
    self waittill("scr_resetreactivecamo");
    var_2 = self.reactivecamoweapons[var_1];
    var_2._id_0267 = 0;
    var_2.stage = 0;
    reactivecamosetstage(var_2, var_2.stage, 0);
  }
}

_id_25AA() {
  self endon("death_or_disconnect");
  self endon("blood_camo_84");

  if(isDefined(self._id_25AE)) {
    self setscriptablepartstate("camo_84", self._id_25AE + "_kills");
  } else {
    self._id_25AE = 0;
  }

  while(self._id_25AE < 13) {
    self waittill("kill_event_buffered");
    self._id_25AE = self._id_25AE + 1;
    self setscriptablepartstate("camo_84", self._id_25AE + "_kills");
  }
}

weapongetreactivecamolookup(var_0) {
  return var_0.basename + "_v" + var_0._id_04CC;
}

weaphasreactivecamo(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_04CC)) {
    return 0;
  }

  return var_0 _meth_8875();
  return 0;
}

_id_6885() {
  return scripts\engine\utility::_id_1BC1(level._id_9EE2);
}

_id_7F8D() {
  level._id_6885 = ::_id_6885;
}

_id_4C7D(var_0) {
  return var_0._id_0245 && !issubstr(var_0._id_04B7, "gl") && issubstr(var_0._id_04B7, "shotgun");
}

_id_7168(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0._id_10D0C)) {
    var_0._id_10D0C = var_1;
  }

  if(!isDefined(var_0.weapon_name)) {
    var_0.weapon_name = var_1.basename;
  }

  if(!isDefined(var_0.owner)) {
    var_0.owner = self;
  }

  if(!isDefined(var_0.team)) {
    var_0.team = self.team;
  }

  if(!isDefined(var_0._id_F1DF)) {
    var_0._id_F1DF = var_2;
  }

  if(!isDefined(var_0._id_F1E0) && isDefined(var_0._id_F1DF)) {
    var_0._id_F1E0 = scripts\common\utility::_id_C94D(4 * var_2);
  }

  var_4 = scripts\mp\equipment::_id_6A14(var_1);

  if(isDefined(var_4)) {
    var_0._id_5562 = var_4;
    var_0._id_8835 = 1;

    if(var_4 == "equip_smoke") {
      var_0.owner scripts\mp\utility\stats::_id_7DAE("smokesUsed", 1);
    }
  }

  var_0._id_F170 = isDefined(var_3);
}

_id_108E7() {
  self waittill("missile_fire", var_0, var_1);

  if(isDefined(var_0)) {
    if(!isDefined(var_0.weapon_name)) {
      if(var_1._id_0245) {
        var_0.weapon_name = scripts\mp\utility\weapon::_id_68B4(var_1);
      } else {
        var_0.weapon_name = var_1.basename;
      }
    }

    if(!isDefined(var_0.owner)) {
      var_0.owner = self;
    }

    if(!isDefined(var_0.team)) {
      var_0.team = self.team;
    }
  }

  return var_0;
}

_id_523B(var_0, var_1) {
  if(!isDefined(self._id_2D82)) {
    self._id_2D82 = [];
  }

  if(!isDefined(var_1)) {
    var_1 = "active";
  }

  if(!istrue(var_0)) {
    thread _id_523D();
  }

  self._id_2D82[_id_6935(var_1)] = var_1;
  thread _id_E686();
}

_id_6935(var_0) {
  switch (var_0) {
    case "nuke_active":
      return 3;
    case "wp_active":
      return 2;
    case "active":
      return 1;
    default:
      return 0;
  }
}

_id_6AA1(var_0) {
  var_1 = 3;

  for(var_2 = undefined; var_1 >= 0; var_1--) {
    if(isDefined(var_0[var_1])) {
      var_2 = var_0[var_1];
      break;
    }
  }

  return var_2;
}

_id_523D() {
  if(!isDefined(self._id_2D94)) {
    self._id_2D94 = 0;
  }

  if(!isDefined(self._id_2D93)) {
    self._id_2D93 = spawn("script_origin", self.origin);
    self._id_2D93 linkto(self);
    self._id_2D93 _id_078E::_id_C2B6(1);
    wait 0.05;
  }

  if(self._id_2D94 == 0) {
    self._id_2D93 playLoopSound("weap_molotov_fire_enemy_burn");
    self._id_2D94 = 1;
  }
}

_id_523C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "active";
  }

  var_2 = "endon_burnfxForTime_" + var_1;
  self notify(var_2);
  self endon("disconnect");
  self endon("clearBurnFX");
  self endon(var_2);
  thread _id_523B(0, var_1);
  wait(var_0);
  thread _id_4A84(0, var_1);
}

_id_4A84(var_0, var_1) {
  if(isDefined(var_1)) {
    if(self._id_2D82[_id_6935(var_1)] == var_1) {
      self._id_2D82[_id_6935(var_1)] = undefined;
    }
  } else
    self._id_2D82 = [];

  if(self._id_2D82.size > 0) {
    thread _id_E686();
  } else {
    thread _id_E8FE();

    if(!istrue(var_0)) {
      thread _id_49E3();
    }
  }
}

_id_49E3() {
  if(!isDefined(self._id_2D94)) {
    self._id_2D94 = 0;
  }

  wait 0.5;

  if(self._id_2D94 == 1) {
    if(isDefined(self._id_2D93)) {
      self._id_2D93 _id_078E::_id_4807();
      wait 0.15;

      if(isDefined(self._id_2D93)) {
        self._id_2D93 stoploopsound("weap_molotov_fire_enemy_burn");
        self._id_2D93 delete();
      }
    }

    self._id_2D94 = 0;
  }
}

_id_EBC6(var_0) {
  if(!isDefined(self._id_2D83)) {
    self._id_2D84 = 0;
  }

  if(var_0) {
    self._id_2D83++;
  } else {
    self._id_2D83--;
  }
}

_id_3927() {
  self notify("clearBurnFX");
  thread _id_E8FE();
  self._id_2D83 = undefined;
  self._id_2D81 = undefined;
  self._id_2D82 = undefined;
}

_id_E686() {
  self notify("stopBurnFX");
  self endon("disconnect");
  self endon("stopBurnFX");
  var_0 = _id_6AA1(self._id_2D82);

  for(;;) {
    var_1 = isDefined(self._id_2D83) && self._id_2D83 > 0;
    var_2 = isDefined(self._id_2D81);

    if(var_1 && var_2) {
      self setscriptablepartstate("burning", "neutral");
      _id_07C3::_id_47FD("burning");
      self._id_2D81 = undefined;
    } else if(!var_1 && !var_2 || var_0 != self._id_2D81) {
      self setscriptablepartstate("burning", var_0);
      self._id_2D81 = var_0;

      if(!var_2) {
        _id_07C3::_id_5466("burning", ::_id_2D7F);
      }
    }

    waitframe();
  }
}

_id_E8FE() {
  self notify("stopBurnFX");

  if(isDefined(self._id_2D81)) {
    self setscriptablepartstate("burning", "neutral");
    _id_07C3::_id_47FD("burning");
    self._id_2D81 = undefined;
  }
}

_id_2D7F(var_0) {
  if(self._id_2D81 == "fs_active") {
    var_0 setscriptablepartstate("burning", "fs_death", 0);
  } else {
    var_0 setscriptablepartstate("burning", "flareUp", 0);
  }
}

_id_D098(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_1);

  if(isPlayer(var_1)) {
    thread _id_717C(var_0, var_1);
    thread _id_D097(var_0, var_1);
  }
}

_id_D097(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("end_explode");
  var_1 endon("disconnect");
  var_1 endon("death");
  var_0 thread scripts\mp\utility\script::_id_A695("death", "end_explode");
  var_0 waittill("explode", var_2);
  thread _id_D096(var_1, var_2);
}

_id_D096(var_0, var_1) {
  var_0 _id_09BF::_id_5ECC();
  var_0 dodamage(var_0.maxhealth, var_1, self, undefined, "MOD_EXPLOSIVE", makeweapon("s4_sticky_eng_n74_mp"));
  var_0 _id_09BF::_id_5ECD();
}