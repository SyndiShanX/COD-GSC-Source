/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2712.gsc
*************************************************/

_id_7599(var_0) {
  return var_0._id_936C != scripts\cp_mp\utility\killstreak_utility::_id_69A7();
}

_id_1155(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self getentitynumber();
  self._id_0F47 = var_2 _id_6887();

  if(isDefined(var_0)) {
    if(_id_89F9(var_0)) {
      _id_116F(var_7);
      thread _id_C4B4(var_7);
    }

    if(_id_8ABE(var_0)) {
      _id_117B(var_7);
      thread _id_C4C2(var_7);
    } else if(_id_8742(var_0)) {
      _id_1156(var_7);
      thread _id_C4A3(var_7);
    } else if(_id_890E(var_0)) {
      _id_1162(var_7);
      thread _id_C4AE(var_7);
    } else if(_id_8899(var_0)) {
      _id_115E(var_7);
      thread _id_C4AA(var_7);
    } else if(_id_8AB7(var_0)) {
      _id_117A(var_7);
      thread _id_C4C1(var_7);
    } else if(_id_87A8(var_0)) {
      _id_1159(var_7);
      thread _id_C4A6(var_7);
    } else if(_id_89CD(var_0)) {
      _id_116E(var_7);
      thread _id_C4B3(var_7);
    } else if(_id_8A7F(var_0)) {
      _id_1173(var_7);
      thread _id_C4B9(var_7);
    } else if(_id_8767(var_0)) {
      _id_1158(var_7);
      thread _id_C4A5(var_7);
    } else if(isdogkillstreak(var_0)) {
      addtodogkillstreaklist(var_7);
      thread removefromdogkillstreaklistondeath(var_7);
    } else {
      _id_1169(var_7);
      thread _id_C4B2(var_7);
    }

    if(_id_88F1(var_0)) {
      self._id_11E4 = 1;
    }
  }

  level._id_0F4C[var_7] = self;
  level._id_0F4C[var_7].streakname = var_0;

  if(var_1 == "Killstreak_Air") {
    self._id_873F = 1;

    if(!isDefined(var_0) || var_0 != "directional_uav") {
      self _meth_86FE("air_killstreak");
    }
  } else {
    self._id_873F = 0;
    self _meth_86FE("killstreak");
  }

  if(level.teambased) {
    self _meth_8706(var_2.team);
  } else {
    self _meth_8706(var_2);
  }

  if(istrue(var_3)) {
    var_8 = undefined;
    var_9 = undefined;

    if(level.teambased) {
      if(scripts\cp_mp\utility\killstreak_utility::_id_8A08(var_0)) {
        foreach(var_11 in level.players) {
          if(var_11.team == self.team && var_11 != self.owner) {
            var_8 = scripts\mp\utility\outline::outlineenableforplayer(self, var_11, "outline_nodepth_cyan", "lowest");
          }

          if(isDefined(var_8)) {
            thread _id_C4FB(var_8, var_6);
          }
        }

        var_9 = 1;
      } else
        var_8 = scripts\mp\utility\outline::_id_ACD2(self, var_2.team, "outline_nodepth_cyan", "lowest");
    } else
      var_8 = scripts\mp\utility\outline::outlineenableforplayer(self, var_2, "outline_nodepth_cyan", "lowest");

    if(!istrue(var_9)) {
      thread _id_C4FB(var_8, var_6);
    }
  }

  if(istrue(var_4)) {
    var_13 = 0;

    if(var_2 scripts\mp\utility\player::_id_8ACE()) {
      var_13 = 1;
    }

    var_14 = undefined;

    if(level.teambased) {
      var_14 = thread _id_078F::_id_D594(1, var_5, 0, 10000, undefined, undefined, 1, var_13);
    } else {
      if(istrue(var_13)) {
        return;
      }
      var_14 = thread _id_078F::_id_D59B(var_2, "hud_icon_head_equipment_friendly", var_5, 1, 10000, undefined, undefined, 1);
    }

    thread _id_C531(var_14, var_6);
  }
}

_id_6887() {
  if(!isDefined(self.pers["nextActiveID"])) {
    self.pers["nextActiveID"] = 0;
  }

  var_0 = self.pers["nextActiveID"];
  self.pers["nextActiveID"]++;
  return var_0;
}

_id_C4FB(var_0, var_1) {
  var_2 = ["death"];

  if(isDefined(var_1)) {
    var_2[var_2.size] = var_1;
  }

  scripts\engine\utility::_id_10893(var_2);
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

_id_C531(var_0, var_1) {
  var_2 = ["death"];

  if(isDefined(var_1)) {
    var_2[var_2.size] = var_1;
  }

  scripts\engine\utility::_id_10893(var_2);
  _id_078F::_id_D593(var_0);
}

_id_C4A2(var_0) {
  level._id_0F4C[var_0] = undefined;
}

_id_0F4B(var_0) {
  if(!isDefined(level._id_0F4C)) {
    return 0;
  }

  return isDefined(level._id_0F4C[var_0]);
}

_id_116F(var_0) {
  if(!isDefined(level._id_C33F)) {
    level._id_C33F = [];
  }

  level._id_C33F[var_0] = self;
}

_id_C4B4(var_0) {
  self waittill("death");
  level._id_C33F[var_0] = undefined;
}

_id_117B(var_0) {
  if(!isDefined(level._id_F8F8)) {
    level._id_F8F8 = [];
  }

  if(level.teambased) {
    level._id_F8F8[self.team][level._id_F8F8[self.team].size] = self;
  } else {
    level._id_F8F8[self.owner.guid + "_" + gettime()] = self;
  }
}

_id_C4C2(var_0) {
  self waittill("death");

  if(isDefined(self._id_F8FF)) {
    self._id_F8FF delete();
  }

  if(level.teambased) {
    var_1 = self.team;
    level._id_F8F8[var_1] = ::scripts\engine\utility::_id_1BD1(level._id_F8F8[var_1]);
  } else
    level._id_F8F8 = scripts\engine\utility::_id_1BD1(level._id_F8F8);

  if(isDefined(self)) {
    self delete();
  }

  _id_C4A2(var_0);
}

_id_1156(var_0) {
  if(!isDefined(level._id_13DF)) {
    level._id_13DF = [];
  }

  level._id_13DF[var_0] = self;
}

_id_C4A3(var_0) {
  self waittill("death");
  level._id_13DF[var_0] = undefined;
  _id_C4A2(var_0);
}

_id_1162(var_0) {
  if(!isDefined(level._id_9593)) {
    level._id_9593 = [];
  }

  level._id_9593[var_0] = self;
}

_id_C4AE(var_0) {
  self waittill("death");
  level._id_9593[var_0] = undefined;
  _id_C4A2(var_0);
}

_id_115E(var_0) {
  if(!isDefined(level._id_77D9)) {
    level._id_77D9 = [];
  }

  level._id_77D9[var_0] = self;
}

_id_C4A9(var_0) {
  level._id_77D9[var_0] = undefined;
  _id_C4A2(var_0);
}

_id_C4AA(var_0) {
  self waittill("death");
  level._id_77D9[var_0] = undefined;
  _id_C4A2(var_0);
}

_id_117A(var_0) {
  if(!isDefined(level._id_F897)) {
    level._id_F897 = [];
  }

  level._id_F897[var_0] = self;
}

_id_C4C1(var_0) {
  scripts\engine\utility::waittill_any_2("death", "carried");
  level._id_F897[var_0] = undefined;
  _id_C4A2(var_0);
}

_id_1159(var_0) {
  if(!isDefined(level._id_47E6)) {
    level._id_47E6 = [];
  }

  level._id_47E6[var_0] = self;
}

_id_C4A6(var_0) {
  scripts\engine\utility::waittill_any_2("death", "carried");
  level._id_47E6[var_0] = undefined;
  _id_C4A2(var_0);
}

_id_1173(var_0) {
  if(!isDefined(level._id_EB9A)) {
    level._id_EB9A = [];
  }

  level._id_EB9A[var_0] = self;
}

_id_C4B9(var_0) {
  self waittill("death");
  level._id_EB9A[var_0] = undefined;
  _id_C4A2(var_0);
}

_id_1158(var_0) {
  if(!isDefined(level._id_1CE6)) {
    level._id_1CE6 = [];
  }

  level._id_1CE6[var_0] = self;
}

_id_C4A5(var_0) {
  self waittill("death");
  level._id_1CE6[var_0] = undefined;
  _id_C4A2(var_0);
}

_id_116E(var_0) {
  if(!isDefined(level._id_BDA1)) {
    level._id_BDA1 = [];
  }

  level._id_BDA1[var_0] = self;
}

_id_C4B3(var_0) {
  self waittill("death");
  level._id_BDA1[var_0] = undefined;
  _id_C4A2(var_0);
}

_id_1169(var_0) {
  if(!isDefined(level._id_B704)) {
    level._id_B704 = [];
  }

  level._id_B704[var_0] = self;
}

_id_C4B2(var_0) {
  self waittill("death");
  level._id_B704[var_0] = undefined;
  _id_C4A2(var_0);
}

addtodogkillstreaklist(var_0) {
  if(!isDefined(level.dogkillstreaks)) {
    level.dogkillstreaks = [];
  }

  level.dogkillstreaks[var_0] = self;
}

removefromdogkillstreaklistondeath(var_0) {
  self waittill("death");
  level.dogkillstreaks[var_0] = undefined;
  _id_C4A2(var_0);
}

_id_D5D2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self makeuseable();
  self setcursorhint("HINT_NOICON");
  self _meth_84D9("show");
  self sethintstring(var_1);
  self sethintdisplayfov(var_2);
  self setusefov(var_3);
  self _meth_84D4(var_4);
  self setuserange(var_5);
  self _meth_83A1(1);
  level thread _id_19E4(self);

  foreach(var_9 in level.players) {
    if(var_9 == var_0 && !istrue(var_7)) {
      self _meth_80E0(var_9);
      continue;
    }

    self disableplayeruse(var_9);
  }
}

_id_19E4(var_0) {
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_1);
    var_0 disableplayeruse(var_1);
  }
}

_id_19DA(var_0, var_1) {
  var_2 = self.team;
  var_3 = self.owner;
  var_4 = undefined;
  var_5 = undefined;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive() || var_0.team == "spectator" || var_0.team == "follower") {
    return;
  }
  if(var_0 == var_3) {
    var_4 = "outlinefill_depth_cyan";
  } else if(var_0 != var_3) {
    if(level.teambased && var_0.team != var_2 || !level.teambased) {
      var_4 = "outlinefill_depth_orange";
      var_5 = 1;
    } else
      return;
  }

  if(isDefined(var_4)) {
    if(istrue(var_5)) {
      if(var_0 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
        return;
      }
    }

    var_6 = scripts\mp\utility\outline::outlineenableforplayer(var_0, self.owner, var_4, "killstreak");
    thread _id_10BBF(var_6, var_0, var_1);
    thread _id_10BC0(var_6, var_0, var_1);
  }
}

_id_10BBF(var_0, var_1, var_2) {
  var_1 endon("death_or_disconnect");
  level endon("game_ended");
  self waittill(var_2);
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
}

_id_10BC0(var_0, var_1, var_2) {
  self endon(var_2);
  level endon("game_ended");
  var_1 waittill("death_or_disconnect");
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
}

_id_6B66(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_3 = _id_07C3::_id_7492(var_1, var_2, var_3);
  var_3 = _id_07C3::_id_741D(var_1, var_2, var_3, var_0);
  var_10 = var_1._id_874C;
  var_11 = 0;

  if(istrue(var_10)) {
    var_12 = scripts\mp\utility\weapon::_id_6E69(var_1);

    foreach(var_14 in var_12) {
      if(var_14 == "gl") {
        var_11 = 1;
        break;
      }
    }
  }

  var_16 = undefined;

  if(var_2 != "MOD_MELEE") {
    switch (var_1.basename) {
      case "cruise_proj_mp":
      case "s4_v2_mp":
        self._id_8EE2 = 1;
        self._id_8D8F = 1;
        var_16 = 1;
        break;
      case "emp_drone_non_player_mp":
      case "hover_jet_proj_mp":
      case "emp_drone_non_player_direct_mp":
      case "bradley_tow_proj_ks_mp":
      case "apache_proj_mp":
      case "s4_airstrike_bomb_mp":
      case "fuelstrike_proj_mp":
      case "ac130_105mm_mp":
      case "at_mine_mp":
      case "s4_mine_ger_s44_mp":
      case "bradley_tow_proj_mp":
        self._id_8EE2 = 1;
        var_16 = var_5;
        break;
      case "s4_ks_mortar_mp":
      case "ac130_40mm_mp":
      case "apc_rus_mp":
      case "lighttank_tur_mp":
      case "lighttank_tur_ks_mp":
      case "s4_firebombing_run_mp":
      case "s4_ks_ord_ger_mp":
      case "technical_mp":
      case "tac_rover_mp":
      case "little_bird_mp":
      case "large_transport_mp":
      case "atv_mp":
      case "s4_tank_tur_mp":
      case "s4_tank_mp":
      case "pickup_truck_mp":
      case "big_bird_mp":
      case "cop_car_mp":
      case "van_mp":
      case "cargo_truck_mp":
      case "med_transport_mp":
      case "hoopty_mp":
      case "lighttank_mp":
      case "hoopty_truck_mp":
      case "emp_grenade_mp":
        self._id_8EE2 = 1;
        var_16 = var_6;
        break;
      case "s4_strafing_run_mp":
      case "s4_ks_tw_ball_turret_gunner_mp":
      case "ac130_25mm_mp":
      case "s4_sticky_eng_n74_mp":
      case "pac_sentry_turret_mp":
      case "s4_frag_gbr_n82_mp":
      case "at_mine_ap_mp":
      case "s4_frag_gbr_n23_mp":
      case "s4_bundle_charge_mp":
      case "s4_frag_ger_m24_mp":
      case "thermite_av_mp":
      case "thermite_bolt_mp":
      case "s4_semtex_mp":
      case "s4_frag_usa_mk2_mp":
      case "claymore_mp":
      case "s4_c4_mp":
        self._id_8EE2 = 0;
        var_16 = var_7;
        break;
    }
  } else {
    self._id_8EE2 = 0;
    var_16 = var_8;
  }

  if(isDefined(var_9)) {
    self._id_8EE2 = var_9;
  }

  if(isDefined(var_16) && isDefined(var_2) && (var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_EXPLOSIVE_BULLET" || var_2 == "MOD_FIRE" || var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH" || var_2 == "MOD_GRENADE" || var_2 == "MOD_GRENADE_SPLASH" || var_2 == "MOD_MELEE")) {
    var_3 = _func_0037(var_4 / var_16);
  }

  var_17 = 0;

  if(isDefined(var_0) && isDefined(self.owner) && !var_17) {
    if(isDefined(var_0.owner)) {
      var_0 = var_0.owner;
    }

    if(var_0 == self.owner && !istrue(self._id_8D8F)) {
      var_3 = _func_0037(var_3 / 2);
    }
  }

  return int(var_3);
}

_id_8841(var_0) {
  var_1 = 0;
  var_2 = 0;

  if(_func_0121(var_0)) {
    var_2 = issubstr(var_0, "alt_");
  } else if(isweapon(var_0)) {
    var_2 = var_0._id_0245;
  }

  var_3 = 0;

  if(istrue(var_2)) {
    var_4 = scripts\mp\utility\weapon::_id_6E69(var_0);

    foreach(var_6 in var_4) {
      if(var_6 == "gl") {
        var_3 = 1;
        break;
      }
    }
  }

  var_8 = scripts\mp\utility\weapon::_id_6E6A(var_0);

  switch (var_8) {
    case "s4_strafing_run_mp":
    case "power_exploding_drone_mp":
    case "jackal_cannon_mp":
    case "sentry_shock_missile_mp":
    case "switch_blade_child_mp":
    case "drone_hive_projectile_mp":
    case "kineticpulse_emp_mp":
    case "pop_rocket_mp":
    case "super_trophy_mp":
    case "emp_grenade_mp":
    case "s4_c4_mp":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_A74A(var_0) {
  return isDefined(var_0) && var_0 == self.owner;
}

_id_4C56(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = (0, 0, 0);
  var_8 = (0, 0, 0);
  var_9 = (0, 0, 0);
  var_10 = (0, 0, 0);
  var_11 = "";
  var_12 = "";
  var_13 = "";
  var_14 = undefined;

  if(isDefined(var_3) && getdvarint("#x3e0ef8627be45090a", 0) == 0) {
    if(level.teambased) {
      if(!scripts\mp\utility\entity::_id_8AEE(var_1, var_3, self)) {
        return;
      }
    } else if(!scripts\mp\utility\entity::_id_8AE5(var_1, var_3, self))
      return;
  }

  if(isagent(self)) {
    self dodamage(var_0, var_4, var_1, var_2, var_5, var_6);
  } else if(scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
    self dodamage(var_0, var_4, var_1, var_2, var_5, var_6);
  } else {
    var_15 = makeweaponfromstring(var_6);
    self notify("damage", var_0, var_1, var_7, var_8, var_5, var_11, var_12, var_13, var_14, var_15, var_4, var_9, var_10, var_2);
  }
}

_id_B38B(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_2 = scripts\engine\utility::getfx("dlight_large");

  if(istrue(self._id_873D)) {
    var_2 = scripts\engine\utility::getfx("dlight_small");
  }

  self._id_6088 = spawn("script_model", self.origin);
  self._id_6088 setModel("tag_origin");
  self._id_6088 linkto(self, "tag_origin", var_0, var_1);
  self._id_6088 thread _id_477C(self);
  wait 0.1;
  playFXOnTag(var_2, self._id_6088, "tag_origin");
}

_id_477C(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

_id_8734(var_0) {
  switch (var_0) {
    case "jackal":
    case "sentry_shock":
      return 1;
  }

  return 0;
}

_id_6C54(var_0) {
  var_1 = "NONE";

  if(isDefined(var_0.owner) && isDefined(var_0.owner._id_41BC)) {
    var_1 = var_0.owner._id_41BC;
  }

  return var_1;
}

_id_10C0E(var_0) {
  var_0 endon("disconnect");
  self endon("explode");

  for(;;) {
    var_0 waittill("destroyed_by_trophy", var_1, var_2, var_3, var_4, var_5);

    if(var_3 != self.weapon_name) {
      continue;
    }
    var_0 _id_07C4::_id_FC47("");
    break;
  }
}

_id_10B82(var_0, var_1, var_2) {
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

  if(isDefined(self.streakname) && scripts\cp_mp\utility\killstreak_utility::_id_8A08(self.streakname)) {
    self.owner setclientomnvar("ui_killstreak_countdown", var_7);
  }

  self[[var_2]](var_5);
}

_id_6A00(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_0 scripts\mp\utility\player::isenemy(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_0B66(var_0, var_1, var_2, var_3) {
  self _meth_8026(var_1, var_2, 0, var_3);
  self._id_D069 = 1;
  self _meth_82EE(10.3, 0.3);
  thread _id_5346("cancel_location");
  thread _id_5346("death");
  thread _id_5346("disconnect");
  thread _id_5346("used");
  thread _id_5346("weapon_change");
  self endon("stop_location_selection");
  thread _id_5347();

  if(isDefined(var_0) && self.team != "spectator" && self.team != "follower") {
    if(isDefined(self._id_EA11)) {
      self._id_EA11 destroy();
    }

    if(self _meth_81E2()) {
      self._id_EA11 = scripts\mp\hud_util::createfontstring("default", 1.3);
      self._id_EA11 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -98);
    } else {
      self._id_EA11 = scripts\mp\hud_util::createfontstring("default", 1.6);
      self._id_EA11 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -190);
    }
  }
}

_id_E914(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "generic";
  }

  if(!var_0) {
    self _meth_82EE(0, 0.3);
    self _meth_80E7();
    self._id_D069 = undefined;

    if(isDefined(self._id_EA11)) {
      self._id_EA11 destroy();
    }
  }

  self notify("stop_location_selection", var_1);
}

_id_5346(var_0) {
  self endon("stop_location_selection");
  self waittill(var_0);
  thread _id_E914(var_0 == "disconnect", var_0);
}

_id_5347() {
  self endon("stop_location_selection");
  level waittill("game_ended");
  thread _id_E914(0, "end_game");
}

_id_EA16(var_0) {
  var_1 = scripts\mp\killstreaks\killstreaks::_id_2EC5(var_0);
  var_2 = scripts\mp\killstreaks\killstreaks::_id_6B91();
  var_3 = scripts\mp\killstreaks\killstreaks::_id_2EC5(var_2);
  return var_1 < var_3;
}

_id_E9FE(var_0, var_1) {
  var_2 = 0;
  var_3 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(var_0, var_0 + (0, 0, 10000), var_1, var_3)) {
    var_2 = 1;
  }

  return var_2;
}

_id_FF5A(var_0, var_1) {
  if((!self isonground() || self _meth_8498()) && scripts\cp_mp\utility\killstreak_utility::_id_8A08(var_0)) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(isDefined(self._id_D069)) {
    return 0;
  }

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return 0;
  }

  if(self _meth_86C8() || self _meth_86C9()) {
    return 0;
  }

  if(scripts\mp\utility\game::_id_873C()) {
    if(_id_8865(var_0)) {
      if(!(isDefined(var_1) && var_1)) {
        scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE_WHEN_AA");
      }

      return 0;
    }
  }

  if(self _meth_81F4() && (scripts\cp_mp\utility\killstreak_utility::_id_8A08(var_0) || _id_87A8(var_0) || _id_8AB7(var_0))) {
    if(!(isDefined(var_1) && var_1)) {
      scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE_USING_TURRET");
    }

    return 0;
  }

  if(!scripts\common\utility::_id_871C()) {
    return 0;
  }

  if(isDefined(level._id_37BB) && _id_8865(var_0)) {
    if(!(isDefined(var_1) && var_1)) {}

    return 0;
  }

  if(isDefined(var_0) && var_0 == "sentry_shock" && _id_07AD::_id_88B6()) {
    if(!(isDefined(var_1) && var_1)) {
      scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    }

    return 0;
  }

  return 1;
}

_id_8992(var_0) {
  if(!isDefined(var_0._id_0F56)) {
    return 0;
  }

  switch (var_0._id_0F56) {
    default:
      return 0;
  }
}

_id_87A8(var_0) {
  switch (var_0) {
    default:
      return 0;
  }
}

_id_89F9(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "pac_sentry":
    case "cruise_predator":
    case "radar_drone_recon":
    case "chopper_gunner":
    case "ball_turret_gunner":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_8ABE(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "uav":
    case "directional_uav":
    case "counter_uav":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_8742(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "multi_airstrike":
    case "hover_jet":
    case "fuel_airstrike":
    case "toma_strike":
    case "precision_airstrike":
    case "ball_turret_gunner":
    case "white_phosphorus":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_890E(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "airdrop":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_8899(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "chopper_gunner":
    case "chopper_support":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_8777(var_0) {
  var_1 = 0;
  return var_1;
}

_id_8AB7(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "manual_turret":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_89CD(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "cruise_predator":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_8A7F(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "scrambler_drone_escort":
    case "scrambler_drone_guard":
    case "radar_drone_recon":
    case "radar_drone_overwatch":
    case "radar_drone_escort":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_8767(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "pac_sentry":
      var_1 = 1;
      break;
  }

  return var_1;
}

isdogkillstreak(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "guard_dog":
    case "attack_dogs":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_87A5(var_0) {
  return isDefined(var_0) && isDefined(var_0._id_7C8C) && var_0._id_7C8C == "care_package";
}

_id_88DF() {
  return istrue(self._id_88DF);
}

_id_89FB(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "ks_remote_map_mp":
    case "ks_remote_hack_mp":
    case "ks_remote_device_mp":
    case "ks_remote_gunship_mp":
    case "ks_remote_bomber_mp":
    case "ks_remote_nuke_mp":
    case "ks_remote_drone_mp":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_88F1(var_0) {
  switch (var_0) {
    case "cruise_predator":
    case "directional_uav":
      return 0;
    default:
      return 1;
  }
}

_id_8865(var_0) {
  switch (var_0) {
    case "airdrop_sentry_minigun":
    case "helicopter":
    case "drone_hive":
    case "heli_pilot":
    case "air_superiority":
    case "gunship":
    case "paratroopers":
    case "airdrop_assault":
    case "cruise_predator":
    case "counter_spy_plane":
    case "uav":
    case "airdrop":
    case "airdrop_multiple":
    case "toma_strike":
    case "precision_airstrike":
    case "ball_turret_gunner":
    case "white_phosphorus":
      return 1;
    default:
      return 0;
  }
}

_id_6AE3(var_0) {
  return level._id_8DD5._id_EA18._id_EC74[var_0]["index"];
}

_id_6AE5(var_0) {
  var_1 = "kills";

  if(scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak") && var_0 != "nuke") {
    var_1 = "scoreCost";
  } else if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
    var_1 = "supportCost";
  }

  return level._id_8DD5._id_EA18._id_EC74[var_0][var_1];
}

_id_6AE1(var_0) {
  return level._id_8DD5._id_EA18._id_EC74[var_0]["enemyUseDialog"];
}

_id_6ADC(var_0) {
  var_1 = _id_6ADD(var_0);

  if(var_1 != "") {
    return var_1;
  }

  var_2 = strtok(var_0, "_");

  foreach(var_4 in var_2) {
    if(var_1 == "") {
      var_1 = var_4;
      continue;
    }

    var_1 = var_1 + var_4;
  }

  return var_1;
}

_id_6ADD(var_0) {
  var_1 = "";

  switch (var_0) {
    case "scrambler_drone":
      var_1 = "scrambler";
      break;
    case "cruise_predator":
      var_1 = "predator";
      break;
    case "toma_strike":
      var_1 = "clusterstrike";
      break;
    case "precision_airstrike":
      var_1 = "a10strike";
      break;
  }

  return var_1;
}

_id_6AE9(var_0) {
  return level._id_8DD5._id_EA18._id_EC74[var_0]["overheadIcon"];
}

currentactivevehiclecount(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = var_0;

  if(isDefined(level._id_77D9)) {
    var_1 = var_1 + level._id_77D9.size;
  }

  if(isDefined(level._id_9593)) {
    var_1 = var_1 + level._id_9593.size;
  }

  if(isDefined(level._id_F906)) {
    var_1 = var_1 + level._id_F906.size;
  }

  if(isDefined(level._id_2AD5) && isDefined(level._id_2AD5._id_1032B)) {
    var_1 = var_1 + level._id_2AD5.size;
  }

  if(isDefined(level._id_EB9A)) {
    var_1 = var_1 + level._id_EB9A.size;
  }

  if(isDefined(level._id_1CE6)) {
    var_1 = var_1 + level._id_1CE6.size;
  }

  return var_1;
}

maxvehiclesallowed() {
  return 8;
}

_id_59E1() {
  return level._id_59E1;
}

_id_7DEF(var_0) {
  if(!isDefined(var_0)) {
    level._id_59E1++;
  } else {
    level._id_59E1 = level._id_59E1 + var_0;
  }
}

_id_455A(var_0) {
  if(!isDefined(var_0)) {
    level._id_59E1--;
  } else {
    level._id_59E1 = level._id_59E1 - var_0;
  }

  if(level._id_59E1 < 0) {
    level._id_59E1 = 0;
  }
}

_id_8769(var_0) {
  switch (var_0) {
    case "drone_hive":
    case "uav":
    case "directional_uav":
      return 1;
    default:
      return 0;
  }
}

_id_8A00(var_0) {
  switch (var_0) {
    case "sam_turret":
    case "deployable_vest":
    case "aa_launcher":
    case "recon_agent":
    case "deployable_ammo":
    case "uav_3dping":
      return 1;
    default:
      return 0;
  }
}

_id_8A81(var_0) {
  switch (var_0) {
    default:
      return 0;
  }
}

_id_8A52(var_0) {
  switch (var_0) {
    default:
      return 0;
  }
}

_id_6A98() {
  return (0, 0, 5000);
}

_id_6A99() {
  return (0, 0, 2500);
}

_id_893E(var_0) {
  var_1 = 0;
  return var_1;
}

_id_87C0() {
  var_0 = 0;

  if(isDefined(self._id_B75E) && isalive(self._id_B75E)) {
    var_0 = 1;
  }

  return var_0;
}

_id_8D9E(var_0) {
  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    return 0;
  }

  return !scripts\mp\utility\weapon::_id_88F6(var_0.basename) && !_id_0A9F::_id_894A(var_0);
}

_id_88E9(var_0) {
  return _id_6AE3(var_0) != -1;
}

_id_689A() {
  if(isDefined(level._id_3E85)) {
    return level._id_3E85._id_3E9B;
  }

  return [];
}

_id_6BAE() {
  if(isDefined(level._id_3E85)) {
    return level._id_3E85._id_3E9B.size;
  }

  return 0;
}

_id_1DD8() {
  if(!isDefined(self)) {
    return 0;
  }

  if(isDefined(level._id_731C) && self == level._id_731C) {
    return 1;
  }

  if(isDefined(level._id_3643) && isDefined(level._id_3643._id_72B3) && self == level._id_3643._id_72B3) {
    return 1;
  }

  if(isDefined(self._id_FEFE) && self._id_FEFE) {
    return 1;
  }

  return 0;
}

_id_8DB7(var_0, var_1, var_2, var_3, var_4) {
  self._id_1031E = var_0;
  self._id_CC16 = var_1;
  self._id_1068F = var_2;
  self._id_106B4 = var_3;
  self._id_484B = var_4;
  self _meth_86FE("killstreak");

  if(level.teambased) {
    self _meth_8706(self.team);
  } else {
    self _meth_8706(self.owner);
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10037(self);
  _id_0AAF::_id_6817(var_0, 1);
}

_id_8DC3() {
  if(!istrue(level._id_8E4C)) {
    level._id_8E4C = 1;
    level._id_8E51 = ::_id_8DB9;
    level._id_8E50 = ::_id_8DB8;
    level._id_8E4E = ::_id_8DB1;
  }
}

_id_8DB9(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;

  if(!istrue(self._id_8D8F)) {
    if(isDefined(var_2) && isDefined(self.owner) && var_2 == self.owner) {
      var_1 = int(_func_0037(var_1 * 0.5));
    }

    var_0.damage = var_1;
  }

  var_3 = 1;
  var_4 = self._id_8E51;

  if(isDefined(var_4)) {
    var_3 = self[[var_4]](var_0);
  }

  return var_3;
}

_id_8DB8(var_0) {
  scripts\mp\killstreaks\killstreaks::_id_8DD6(var_0.attacker, var_0.objweapon, self, var_0._id_9CD6, var_0.damage);
  var_1 = 1;
  var_2 = self._id_8E50;

  if(isDefined(var_2)) {
    var_1 = self[[var_2]](var_0);
  }

  return var_1;
}

_id_8DB1(var_0) {
  _id_07C3::_id_AB18(self.streakname, var_0.attacker, var_0.objweapon, var_0._id_9CD6, var_0.damage, self._id_CC16, self._id_1068F, self._id_484B);
  var_1 = 1;
  var_2 = self._id_8E4E;

  if(isDefined(var_2)) {
    var_1 = self[[var_2]](var_0);
  }

  return var_1;
}

_id_8DC1(var_0, var_1) {
  _id_8DC3();
  _id_0AAF::_id_D35F(var_0, level._id_8E51);
  self._id_8E51 = var_1;
}

_id_8DC0(var_0, var_1) {
  _id_8DC3();
  _id_0AAF::_id_D35C(var_0, level._id_8E50);
  self._id_8E50 = var_1;
}

_id_8DBF(var_0, var_1) {
  _id_8DC3();
  _id_0AAF::_id_D1AC(var_0, level._id_8E4E);
  self._id_8E4E = var_1;
}

_id_6AE7(var_0) {
  var_1 = var_0.basename;

  if(isDefined(level._id_8DEE[var_1])) {
    return level._id_8DEE[var_1];
  }

  return undefined;
}