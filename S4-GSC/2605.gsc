/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2605.gsc
*************************************************/

_id_81DE() {
  _id_81E8();
  level._effect["plane_death"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
  level._effect["airstrike_death_allies"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
  level._effect["airstrike_death_axis"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
  level._id_CC21 = [];
}

_id_B18B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  switch (var_0) {
    case "s2_airstrike":
    case "firebomb":
      level thread _id_B18A(var_0, var_1, var_2, var_3, var_4);
      break;
    case "raid_carepackage":
    case "emergency_carepackage":
    case "zm_carepackage":
    case "carepackage":
      break;
    case "paratroopers":
      break;
    case "paratrooper_insert":
      break;
  }
}

_id_B18A(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_1 endon("airstrike_complete");
  var_1 endon("delete");
  var_1 endon("death");
  var_1 endon("crashing");

  if(isDefined(var_2)) {
    var_2 endon("disconnect");
  }

  var_5 = 0;

  if(isDefined(var_2)) {
    var_5 = var_2 _id_080C::_hasperk("specialty_improvedstreaks");
  }

  var_6 = _id_6A4C(var_0) / 2;
  var_7 = var_1._id_505D + -1 * anglesToForward(var_1.angles) * 2000;
  var_1._id_2626 = spawn("script_model", (0, 0, 0));
  var_1._id_2626 setModel("tag_origin");
  var_1._id_2626 linkto(var_1, "TAG_BOMB_L", (0, 0, 0), (0, 0, 0));
  var_1._id_2627 = spawn("script_model", (0, 0, 0));
  var_1._id_2627 setModel("tag_origin");
  var_1._id_2627 linkto(var_1, "TAG_BOMB_R", (0, 0, 0), (0, 0, 0));
  var_8 = 1;

  if(_id_080C::_id_89D7() && isDefined(var_4) && !level._id_BF5A) {
    var_8 = 0;
  }

  if(var_8) {
    level thread _id_402F(var_1, var_0);
  }

  wait 4;
  var_1 notify("start_bombing");
  var_1._id_AF7A = 1;
  var_9 = 0;
  var_10 = _id_6A4D(var_0);
  var_11 = 0;
  var_12 = 3;
  var_13 = 1;

  while(var_11 <= var_10) {
    var_14 = _id_6925(var_0);
    var_15 = (0, randomint(360), 0);
    var_16 = anglesToForward(var_15) * var_14;
    var_17 = var_1.origin + anglesToForward(var_1.angles) * 2000;
    var_17 = (var_17[0], var_17[1], var_7[2]);
    var_17 = var_17 + var_16;

    if(var_9) {
      var_18 = var_1._id_2626.origin;
    } else {
      var_18 = var_1._id_2627.origin;
    }

    var_9 = !var_9;
    var_19 = _id_080C::_id_994B(_id_6927(var_0, var_2), var_18, var_17, 3.0, var_18[2], var_2);
    var_19.owner = var_1.owner;
    var_19.team = var_1.team;

    if(var_0 == "firebomb") {
      var_19 thread _id_0A2A::_id_3FCD(var_5);

      if(var_12 == 3) {
        var_19 thread _id_080C::_id_8E42();
        var_12 = 1;
      } else if(var_12 < 3)
        var_12++;

      if(var_13 == 1 && var_10 - var_11 < 1) {
        var_19 thread _id_080C::_id_8E43();
        var_13 = 0;
      }
    } else if(var_0 == "s2_airstrike") {
      if(var_12 == 3) {
        var_19 thread _id_080C::_id_8E42();
        var_12 = 1;
      } else if(var_12 < 3)
        var_12++;

      if(var_13 == 1 && var_10 - var_11 < 1) {
        var_19 thread _id_080C::_id_8E43();
        var_13 = 0;
      }
    }

    if(isDefined(var_1.killcament)) {
      var_19 _id_080C::_id_D485(var_1.killcament);
    }

    var_11 = var_11 + 0.1;
    wait 0.1;
  }

  var_1 notify("stop_bombing");
  level._id_13BD = undefined;
}

_id_6927(var_0, var_1) {
  switch (var_0) {
    case "firebomb":
      var_2 = 0;

      if(isDefined(var_1)) {
        var_2 = var_1 _id_080C::_hasperk("specialty_improvedstreaks");
      }

      if(var_2) {
        if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == "axis") {
          return "firebomb_bomb_axis_grenadier_mp";
        } else {
          return "firebomb_bomb_grenadier_mp";
        }
      } else if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == "axis")
        return "firebomb_bomb_axis_mp";
      else {
        return "firebomb_bomb_mp";
      }
    case "s2_airstrike":
      if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == "axis") {
        return "s4_airstrike_bomb_mp";
        return;
      }

      return "s4_airstrike_bomb_mp";
      return;
  }
}

_id_6925(var_0) {
  switch (var_0) {
    case "firebomb":
      return 0;
    case "s2_airstrike":
      return 128;
    default:
      return 0;
  }
}

_id_E720(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self notify("used");

  if(!isDefined(var_5)) {
    if(isDefined(var_4)) {
      var_5 = var_4;
    } else {
      var_5 = self.pers["team"];
    }
  }

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    var_8 = var_1[var_7];
    var_9 = var_2[var_7];
    var_10 = _id_080C::_id_2D3B(level._id_9AAC + (0, 0, 10000), level._id_9AAC, 0, undefined);
    var_8 = (var_8[0], var_8[1], var_10["position"][2]);

    if(isDefined(var_4)) {
      thread _id_24B3(var_0, var_8, var_9, undefined, var_5, var_3, var_4, var_6);
      continue;
    }

    thread _id_24B3(var_0, var_8, var_9, self, var_5, var_3, undefined, var_6);
  }
}

_id_F2DA(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1) && var_1, 1, 0);
  var_0 setclientomnvar("ui_airspace_crowded_no_control", var_2);
  level._id_13DD = var_1;
}

_id_13E5() {
  self endon("disconnect");
  level endon("game_ended");
  self setclientomnvar("ui_airspace_crowded_air_superiority", 1);

  while(isDefined(level._id_13BD) || isDefined(level._id_32B8)) {
    waitframe();
  }

  self setclientomnvar("ui_airspace_crowded_air_superiority", 0);
}

_id_24B3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level._id_13DD)) {
    while(isDefined(level._id_13DD)) {
      level waittill("begin_airstrike");
    }

    _id_F2DA(var_3, 1);
  }

  _id_F2DA(var_3, 1);
  var_8 = _id_5061(var_1, var_3);

  if(isDefined(level._id_CC1C) && isDefined(level._id_CC1C[var_5])) {
    if(isDefined(var_6)) {
      _id_0A2C::_id_3FFB(var_8, var_2, var_5, var_6);
    } else {
      _id_0A2C::_id_3FFB(var_8, var_2, var_5, var_3.team);
    }
  }

  _id_2FD0(var_0, var_3, var_8, var_2, var_5, var_6, var_4, var_7);
  wait 1.0;
  _id_F2DA(var_3, undefined);

  if(isDefined(var_3)) {
    var_3 notify("begin_airstrike");
  }

  level notify("begin_airstrike");

  if(isDefined(level._id_CC1C) && isDefined(level._id_CC1C[var_5])) {
    thread _id_0A2C::_id_9A2E(var_8, var_5);
  }
}

_id_2FD0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = _id_6C35(var_4);

  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  }

  var_9 = (0, var_3, 0);
  var_10 = _id_6C3C(var_2, var_9, var_8, var_4);
  level thread _id_4E6D(var_0, var_1, var_2, var_10, var_9, var_4, var_5, var_6, var_7);
}

_id_4E6D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  switch (var_5) {
    case "s2_airstrike":
    case "firebomb":
      var_3 = var_3 + -1 * anglesToForward(var_4) * 2000;
      thread _id_E368(var_0, var_1, var_2, var_3, var_4, var_5, 1, var_6);
      break;
    case "raid_carepackage":
    case "emergency_carepackage":
    case "zm_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      thread _id_E368(var_0, var_1, var_2, var_3, var_4, var_5, 1, var_6, var_7, var_8);
      break;
  }
}

_id_E368(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_8)) {
    var_10 = var_8;
  } else {
    var_10 = var_7;
  }

  var_11 = _id_6C3A(var_5, var_1, var_10);
  var_12 = _id_6C33(var_5, var_1, var_10);
  var_13 = _id_6C2F(var_5, var_1, var_10);
  var_14 = spawn("script_model", var_3);
  var_14.angles = var_4;

  if(isDefined(var_12)) {
    var_14 setModel(var_12);
    var_14 thread _id_58B6(var_11, 1);
  } else
    var_14 setModel(var_11);

  if(isDefined(var_13)) {
    var_14 _id_B8B8(var_5, var_13);
  }

  if(_id_080C::_id_89D7() && isDefined(var_7)) {
    var_14._id_562C = [];
    var_15 = anglesToForward(var_14.angles + (0, 135, 0));
    var_16 = var_3 + var_15 * 1200;
    var_17 = spawn("script_model", var_16);
    var_17.angles = var_4;
    var_17 setModel(var_11);
    var_17.team = var_7;
    var_17 _id_B8B8(var_5, var_13);
    var_14._id_562C[var_14._id_562C.size] = var_17;
    var_15 = anglesToForward(var_14.angles + (0, -135, 0));
    var_16 = var_3 + var_15 * 1200;
    var_17 = spawn("script_model", var_16);
    var_17.angles = var_4;
    var_17 setModel(var_11);
    var_17.team = var_7;
    var_17 _id_B8B8(var_5, var_13);
    var_14._id_562C[var_14._id_562C.size] = var_17;
  }

  var_18 = 1;

  if(_id_080C::_id_8B1D()) {
    var_18 = 0;
  }

  if(_id_080C::_id_89D7() && isDefined(level._id_BF5C._id_CC1A) && _id_080C::_id_86F0(level._id_BF5C._id_CC1A._id_7909)) {
    var_18 = 0;
  }

  var_18 = 0;

  if(var_18) {
    var_19 = 1;
    var_20 = 0;
    var_14._id_9F23 = _id_080C::_id_E289("script_model", var_3);
    var_14._id_9F23 setModel("tag_origin");
    var_21 = var_1;

    if(isDefined(var_7)) {
      var_21 = var_7;
    }

    var_14._id_9F23 _id_080C::_id_D5AC(var_21, _id_6C38(var_5), 20, 20, var_20, var_19, _id_6C39(var_5));
    var_14._id_9F23 _id_080C::_id_9519(var_14, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  var_14._id_04DE = var_5;
  _id_110D(var_14);
  level thread _id_080C::_id_FBF4();
  var_14 setCanDamage(1);
  var_14 _meth_82F2(1);
  var_14 thread _id_080C::_id_D542(_id_6C37(var_5), undefined, ::_id_AB97, ::_id_AB96, 1);
  var_14 thread _id_7431();
  var_14._id_AF7A = 0;
  var_14 _id_B8D1(var_5);
  var_14._id_936C = var_0;

  if(isDefined(var_7)) {
    var_14.team = var_7;
  } else if(isDefined(var_1)) {
    var_14.owner = var_1;
    var_14.team = var_1.team;
  } else
    var_14.team = "allies";

  var_14._id_505D = var_2;
  var_14._id_9102 = gettime();
  var_14 thread _id_B187(var_5, var_3, var_4);

  if(isDefined(var_14._id_562C)) {
    foreach(var_17 in var_14._id_562C) {
      var_17 thread _id_B187(var_5, var_17.origin, var_4);
    }
  }

  thread _id_B18B(var_5, var_14, var_1, var_4, var_7, var_8, var_9);
  var_14 endon("death");
  var_14 endon("crashing");
  var_14 waittill("pathComplete");
  var_14 thread _id_4786(0);
}

_id_58B6(var_0, var_1) {
  self endon("death");
  _id_080C::_id_D6BF(0, 1, var_1);
  wait(var_1);
  self setModel(var_0);
}

_id_B8B8(var_0, var_1) {
  switch (var_0) {
    case "s2_airstrike":
    case "firebomb":
      self _meth_82CB(var_1);
      break;
    case "raid_carepackage":
    case "emergency_carepackage":
    case "zm_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      self _meth_82CC(var_1);
      break;
  }
}

_id_B8D1(var_0) {
  switch (var_0) {
    case "fighter_strike":
      _id_080C::_id_DEF2("ks_fighterstrike_flyby");
      break;
    case "s2_airstrike":
    case "firebomb":
      _id_080C::_id_DEF2("ks_bombing_run_flyby");
      break;
    case "carepackage":
      _id_080C::_id_DEF2("ks_carepackage_flyby");
      break;
    case "emergency_carepackage":
      _id_080C::_id_DEF2("ks_emergency_carepackage");
      break;
    case "raid_carepackage":
    case "zm_carepackage":
    case "paratrooper_insert":
    case "paratroopers":
      _id_080C::_id_DEF2("ks_carepackage_flyby");
      break;
  }
}

_id_6C37(var_0) {
  switch (var_0) {
    case "s2_airstrike":
      return 1000;
    case "firebomb":
      return 1250;
    case "fighter_strike":
      return 200;
    case "raid_carepackage":
    case "zm_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      return 1000;
    case "emergency_carepackage":
      return 1500;
    case "s2_uav":
      return 300;
    case "counter_uav":
      return 300;
    case "advanced_uav":
      return 350;
    case "plane_gunner":
      return 3000;
  }
}

_id_6C3A(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else if(isDefined(var_1)) {
    var_3 = var_1.team;
  } else {
    var_3 = "allies";
  }

  switch (var_0) {
    case "firebomb":
      if(var_3 == "allies") {
        return "ger_bomber_lancaster_vista";
      } else {
        return "ger_bomber_he_177_vista";
      }
    case "s2_airstrike":
      if(isDefined(var_3) && var_3 == "allies") {
        return "usa_bomber_a20_vista";
      } else {
        return "ger_bomber_he_111_vista_ai";
      }
    case "raid_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      if(isDefined(var_3) && var_3 == "allies") {
        return "usa_bomber_skytrain_vista";
      } else {
        return "ger_bomber_junkers52_vista";
      }
    case "zm_carepackage":
      return "usa_bomber_skytrain_vista";
    case "emergency_carepackage":
      if(isDefined(var_3) && var_3 == "allies") {
        return "usa_bomber_commando_vista";
        return;
      }

      return "ger_bomber_wiking_vista";
      return;
  }
}

_id_6C33(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else if(isDefined(var_1)) {
    var_3 = var_1.team;
  } else {
    var_3 = "allies";
  }

  switch (var_0) {
    case "s2_airstrike":
      if(isDefined(var_3) && var_3 == "allies") {
        return "usa_bomber_a20_vista_fade";
      } else {
        return "ger_bomber_he_111_vista_ai_fade";
      }
    case "raid_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      if(isDefined(var_3) && var_3 == "allies") {
        return "usa_bomber_skytrain_vista_fade";
      } else {
        return "ger_bomber_junkers52_vista_fade";
      }
    case "zm_carepackage":
      return "usa_bomber_skytrain_vista_fade";
    case "emergency_carepackage":
      if(isDefined(var_3) && var_3 == "allies") {
        return "usa_bomber_commando_vista_fade";
        return;
      }

      return "ger_bomber_wiking_vista_fade";
      return;
  }
}

_id_6C2F(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else if(isDefined(var_1)) {
    var_3 = var_1.team;
  } else {
    var_3 = "allies";
  }

  switch (var_0) {
    case "firebomb":
      if(var_3 == "allies") {
        return "ks_firebomb_usa";
      } else {
        return "ks_firebomb_ger";
      }
    case "s2_airstrike":
      if(isDefined(var_3) && var_3 == "allies") {
        return "ks_carpetbomb_usa";
      } else {
        return "ks_carpetbomb_ger";
      }
    case "carepackage":
      if(isDefined(var_3) && var_3 == "allies") {
        return "ks_carepackage_usa_animated";
      } else {
        return "ks_carepackage_ger_animated";
      }
    case "raid_carepackage":
      if(game["defenders"] == "allies") {
        return "ks_carepackage_usa_animated";
      } else {
        return "ks_carepackage_ger_animated";
      }
    case "zm_carepackage":
      return "ks_carepackage_ger_animated";
    case "paratrooper_insert":
    case "paratroopers":
      if(isDefined(var_3) && var_3 == "allies") {
        return "ks_paratrooper_usa_animated";
      } else {
        return "ks_paratrooper_ger_animated";
      }
    case "emergency_carepackage":
      if(isDefined(var_3) && var_3 == "allies") {
        return "ks_emergency_airdrop_usa_animated";
        return;
      }

      return "ks_emergency_airdrop_ger_animated";
      return;
  }
}

_id_6C38(var_0) {
  switch (var_0) {
    case "s2_airstrike":
    case "firebomb":
      return "scorestreak_minimap_bombing";
    case "fighter_strike":
      return "scorestreak_minimap_fighter";
    case "plane_gunner":
      return "scorestreak_minimap_fighter";
    case "raid_carepackage":
    case "emergency_carepackage":
    case "zm_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      return "scorestreak_minimap_drop";
  }
}

_id_6C39(var_0) {
  switch (var_0) {
    case "raid_carepackage":
    case "emergency_carepackage":
    case "zm_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      return "aid";
    case "s2_airstrike":
      return "explosive";
    case "firebomb":
      return "fire";
  }
}

_id_DCC5(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;
  var_6 = 0;
  var_7 = 1;
  var_8 = var_0;

  if(isDefined(var_4)) {
    var_8 = var_4;
  }

  if(isDefined(var_1)) {
    var_9 = var_2 * 2;
    var_1 _id_080C::_id_D5AC(var_8, var_3, var_9, var_9, var_7, var_6);
    var_1 _id_080C::_id_D557(100, var_5);
  }
}

_id_6AB0() {
  return 80;
}

_id_AB96(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isDefined(self.owner) && var_0 == self.owner) {
    return -1;
  }

  var_4 = var_3;

  if(var_1 != "killstreak_flak_gun_mp") {
    switch (var_2) {
      case "MOD_EXPLOSIVE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_IMPACT":
      case "MOD_GRENADE":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
        var_4 = var_4 * 0.6;
        break;
      case "MOD_EXPLOSIVE_BULLET":
        var_4 = var_4 * 0.4;
        break;
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
      default:
        if(issubstr(var_1, "fmj")) {
          var_4 = var_4 * 2.0;
        }

        if(isDefined(var_0) && var_0 _id_080C::_hasperk("specialty_superbulletpenetration")) {
          var_4 = var_4 * 2.0;
        }

        if(_id_896A(var_1)) {
          var_4 = var_4 * 0.12;
        }

        var_4 = var_4 * 0.15;
        break;
    }
  }

  return _id_080C::_id_A007(var_0, var_1, var_2, var_4);
}

_id_896A(var_0) {
  foreach(var_2 in level._id_CC21) {
    if(issubstr(var_0, var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_745A() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("launcher_missile_fire", var_0, var_1);
    var_1 thread _id_E4EC(self, var_0);
    thread _id_90F7(var_1, var_0);
  }
}

_id_E4EC(var_0, var_1) {
  var_2 = vectornormalize(var_0.origin - var_1.origin);
  var_3 = 15;
  var_4 = anglesToForward(var_1 getplayerangles());

  if(vectordot(var_2, var_4) >= cos(var_3)) {
    self _meth_8382(1);
  }
}

_id_90F7(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_2 = 90000;

  for(;;) {
    var_3 = self.origin;
    var_4 = distancesquared(var_0.origin, var_3);

    if(var_4 < var_2) {
      thread _id_90F6(var_0, var_1);
    }

    wait 0.05;
  }
}

_id_90F6(var_0, var_1) {
  self dodamage(2200, self.origin, var_1, var_0, "MOD_PROJECTILE", var_0.weapon_name);
  var_0 detonate();
}

_id_4013() {
  self._id_1E2B = 1000;
  self._id_1E2A = 1000;
  self._id_1E2E = _func_014B(self, self._id_1E2B, self._id_1E2A);
}

_id_485A() {
  if(isDefined(self._id_1E2E)) {
    _func_014F(self._id_1E2E);
  }
}

_id_6C36(var_0) {
  switch (var_0) {
    case "fighter_strike":
      return 10000;
    case "advanced_uav":
    case "plane_gunner":
    case "raid_carepackage":
    case "s2_airstrike":
    case "emergency_carepackage":
    case "zm_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "s2_uav":
    case "firebomb":
    case "paratroopers":
    case "counter_uav":
    default:
      return 22500;
  }
}

_id_4786(var_0) {
  level endon("game_ended");
  level._id_13BD = undefined;
  self notify("airstrike_complete");
  _id_C502(self);

  if(isDefined(self._id_9F23)) {
    self._id_9F23 delete();
  }

  if(isDefined(self._id_9F24)) {
    self._id_9F24 delete();
  }

  if(isDefined(self)) {
    if(isDefined(self._id_2626)) {
      self._id_2626 delete();
    }

    if(isDefined(self._id_2627)) {
      self._id_2627 delete();
    }

    if(isDefined(self._id_562C)) {
      foreach(var_2 in self._id_562C) {
        var_2 delete();
      }
    }

    self delete();
  }
}

_id_AB97(var_0, var_1, var_2, var_3) {
  thread _id_3E6C();
  var_4 = undefined;

  if(self._id_04DE == "carepackage" || self._id_04DE == "emergency_carepackage" || self._id_04DE == "raid_carepackage" || self._id_04DE == "zm_carepackage") {
    var_4 = "cpkg_destroyed";
  }

  _id_080C::_id_AB18(var_0, var_1, var_2, var_3, _id_6C30(self._id_04DE), var_4, _id_6C32(self._id_04DE), 1);
}

_id_3E6C() {
  self notify("crashing");
  self._id_3E66 = 1;

  switch (self._id_04DE) {
    case "fighter_strike":
    case "plane_gunner":
    case "raid_carepackage":
    case "s2_airstrike":
    case "emergency_carepackage":
    case "zm_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "firebomb":
    case "paratroopers":
      break;
  }
}

_id_7431(var_0) {
  level endon("game_ended");
  self endon("delete");
  scripts\engine\utility::_id_108C5("death", "crashing");

  if(isDefined(self)) {
    var_1 = anglesToForward(self.angles);
    playFX(_id_6C31(self._id_04DE, self.team), self.origin, var_1);
    _id_080C::_id_40F4("ks_plane_destruct_explode", undefined, self.origin);

    if(self._id_04DE == "s2_airstrike") {
      level notify("aud_carpet_bomb_killed");
    }
  }

  _id_4786(1);
}

_id_6C30(var_0) {
  switch (var_0) {
    case "s2_airstrike":
      return "airstrike_destroyed";
    case "firebomb":
      return "fire_bombing_run_destroyed";
    case "raid_carepackage":
    case "zm_carepackage":
    case "carepackage":
      return "carepackage_plane_destroyed";
    case "emergency_carepackage":
      return "emergency_carepackage_plane_destroyed";
    case "paratrooper_insert":
    case "paratroopers":
      return "paratroopers_plane_destroyed";
  }
}

_id_6C32(var_0) {
  switch (var_0) {
    case "s2_airstrike":
      return "callout_destroyed_airstrike";
    case "firebomb":
      return "callout_destroyed_firebomb";
    case "raid_carepackage":
    case "zm_carepackage":
    case "carepackage":
      return "callout_destroyed_carepackage";
    case "emergency_carepackage":
      return "callout_destroyed_emergency_carepackage";
    case "paratrooper_insert":
    case "paratroopers":
      return "callout_destroyed_paratroopers_plane";
  }
}

_id_6C31(var_0, var_1) {
  switch (var_0) {
    case "firebomb":
      if(var_1 == "allies") {
        return scripts\engine\utility::getfx("plane_death");
      } else {
        return scripts\engine\utility::getfx("plane_death");
      }
    case "s2_airstrike":
      if(isDefined(var_1) && var_1 == "allies") {
        return scripts\engine\utility::getfx("airstrike_death_allies");
      } else {
        return scripts\engine\utility::getfx("airstrike_death_axis");
      }
    case "raid_carepackage":
    case "zm_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      if(isDefined(var_1) && var_1 == "allies") {
        return scripts\engine\utility::getfx("plane_death");
      } else {
        return scripts\engine\utility::getfx("plane_death");
      }
    case "emergency_carepackage":
      if(isDefined(var_1) && var_1 == "allies") {
        return scripts\engine\utility::getfx("plane_death");
      } else {
        return scripts\engine\utility::getfx("plane_death");
      }
    default:
      return scripts\engine\utility::getfx("plane_death");
  }
}

_id_B187(var_0, var_1, var_2) {
  switch (var_0) {
    case "s2_airstrike":
    case "firebomb":
      _id_1881(var_0, var_1, var_2, 1);
      break;
    case "raid_carepackage":
    case "emergency_carepackage":
    case "zm_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      _id_1881(var_0, var_1, var_2, 0);
      break;
  }
}

_id_1881(var_0, var_1, var_2, var_3) {
  self endon("airstrike_complete");
  var_4 = _id_6A4C(var_0);
  var_5 = _id_6A4D(var_0);
  var_6 = 6400;
  var_7 = 12800;

  if(var_0 == "zm_carepackage") {
    var_6 = 4000;
    var_7 = 8000;
  }

  var_8 = var_6 + var_4 + var_7;
  var_9 = 4 + var_5 + 8;

  if(var_0 == "zm_carepackage") {
    var_9 = 2 + var_5 + 4;
  }

  thread _id_B18C();
  self._id_E774 = "flying_in";

  if(1 && isDefined(self._id_9F23)) {
    self._id_9F23 _id_080C::_id_D557(4000, 1);
  }

  if(1 && isDefined(self._id_9F24)) {
    self._id_9F24 _id_080C::_id_D557(4000, 1);
  }

  if(isDefined(var_3) && var_3) {
    var_10 = var_1 + anglesToForward(var_2) * var_8;
    self moveto(var_10, var_9);
  }

  var_11 = 4;

  if(var_0 == "zm_carepackage") {
    var_11 = 2;
  }

  wait(var_11);
  self._id_E774 = "strike";
  wait(var_5);
  self._id_E774 = "flying_out";

  if(1 && isDefined(self._id_9F23)) {
    self._id_9F23 _id_080C::_id_D557(4000, 0);
  }

  if(1 && isDefined(self._id_9F24)) {
    self._id_9F24 _id_080C::_id_D557(4000, 0);
  }

  var_12 = 7;

  if(var_0 == "zm_carepackage") {
    var_12 = 3;
  }

  wait(var_12);
  var_13 = undefined;

  if(!isDefined(self.owner)) {
    var_13 = self.team;
  }

  var_14 = _id_6C33(var_0, self.owner, var_13);

  if(isDefined(var_14)) {
    self setModel(var_14);
    _id_080C::_id_D6BF(1, 0, 1);
  }

  wait 1;
  self notify("pathComplete");
}

_id_B18C() {
  self endon("airstrike_complete");
  self endon("pathComplete");

  for(;;) {
    level waittill("host_migration_begin");
    self _meth_8642(1);
    level waittill("host_migration_end");
    self _meth_8642(0);
  }
}

_id_B190() {
  self endon("airstrike_complete");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("airstrike_engine"), self, "tag_engine_right");
  playFXOnTag(scripts\engine\utility::getfx("airstrike_engine"), self, "tag_engine_left");
  playFXOnTag(scripts\engine\utility::getfx("airstrike_wingtip"), self, "tag_right_wingtip");
  playFXOnTag(scripts\engine\utility::getfx("airstrike_wingtip"), self, "tag_left_wingtip");
}

_id_402F(var_0, var_1) {
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 _meth_8375("airstrike");
  var_2 _id_080C::_id_D4E1();
  var_3 = 4 + _id_6A4D(var_1) + 8;
  var_2 thread _id_4772(var_3);
  var_4 = anglestoaxis((35, -45, 0))["forward"];
  var_2 linkto(var_0, "tag_origin", var_4 * -1 * 1000, (35, -45, 0));
  var_0.killcament = var_2;
}

_id_4772(var_0) {
  self endon("death");
  wait(var_0);
  self delete();
}

_id_689B() {
  if(isDefined(level._id_13B6)) {
    return level._id_13B6;
  }

  var_0 = scripts\engine\utility::_id_6A02("warbird_anchor", "targetname");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = (0, 0, 0);
    var_0._id_0481 = "warbird_anchor";
  }

  if(!isDefined(var_0._id_039B)) {
    var_0._id_039B = 3500;
  }

  level._id_13B6 = var_0.origin[2] + 3000;
  return level._id_13B6;
}

_id_6C35(var_0) {
  var_1 = 0;

  if(isDefined(level._id_13E1) && isDefined(level._id_13E1._id_E2F9)) {
    var_1 = level._id_13E1._id_E2F9;
  }

  var_2 = 0;

  if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_gibraltar_02") {
    var_2 = 1000;
  }

  if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_wolfslair" || scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_wolfslair_free" || scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_wolfslair2") {
    var_2 = 1000;
  }

  if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_sandbox_01") {
    var_2 = -1500;
  }

  if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_airship" && (var_0 == "carepackage" || var_0 == "emergency_carepackage")) {
    var_2 = 1000;
  }

  var_3 = _id_689B();
  return var_3 + var_1 + var_2;
}

_id_688D(var_0, var_1, var_2) {
  var_3 = anglestoright(var_1);
  var_2._id_E70F = var_0;
  var_2._id_E710 = var_0 + var_3 * -1 * 600;
  var_2._id_E711 = var_0 + var_3 * 600;
  var_2._id_E712 = var_0 + var_3 * 1200;
  var_2._id_E713 = var_0 + var_3 * -1200;
}

_id_6C3C(var_0, var_1, var_2, var_3) {
  var_4 = 6400;

  if(var_3 == "zm_carepackage") {
    var_4 = 4000;
  }

  var_5 = _id_6A4C(var_3);
  var_6 = var_5 / 2 + var_4;
  var_7 = var_0 + anglesToForward(var_1) * (-1 * var_6);
  var_7 = var_7 * (1, 1, 0);
  var_7 = var_7 + (0, 0, var_2);
  return var_7;
}

_id_6A4C(var_0) {
  switch (var_0) {
    case "air_superiority":
      return 6000;
    case "raid_carepackage":
    case "emergency_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "firebomb":
    case "paratroopers":
      return 2500;
    case "zm_carepackage":
      return 1500;
  }
}

_id_6A4D(var_0) {
  switch (var_0) {
    case "raid_carepackage":
    case "emergency_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "firebomb":
    case "paratroopers":
      return 1.5625;
    case "s2_airstrike":
      return 3.75;
    case "zm_carepackage":
      return 0.75;
  }
}

_id_5061(var_0, var_1) {
  var_2 = var_0;
  var_3 = var_2 + (0, 0, -1000000.0);
  var_4 = _id_080C::_id_2D3B(var_2, var_3, 0, var_1);

  for(var_5 = var_4["entity"]; isDefined(var_5) && isDefined(var_5._id_04DE); var_5 = var_4["entity"]) {
    waitframe();
    var_2 = var_4["position"];
    var_4 = _id_080C::_id_2D3B(var_2, var_3, 0, var_5);
  }

  return var_4["position"];
}

_id_505E(var_0, var_1) {
  var_2 = _id_5060(var_0, var_1);

  if(var_2) {
    var_3 = 1;
  } else {
    var_3 = -1;
  }

  var_4 = scripts\engine\utility::_id_5CDA(var_0.origin);
  var_5 = var_4 + anglesToForward(scripts\engine\utility::_id_5CD9(var_0.angles)) * (var_3 * 100000);
  var_6 = _func_01A4(var_4, var_5, var_1);
  var_7 = distance(var_4, var_6);
  return var_7;
}

_id_505F(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 3000;
  }

  var_3 = _id_5060(var_0, var_1);

  if(var_3) {
    var_4 = 1;
  } else {
    var_4 = -1;
  }

  var_5 = scripts\engine\utility::_id_5CDA(var_0.origin);
  var_6 = var_5 + anglesToForward(scripts\engine\utility::_id_5CD9(var_0.angles)) * (var_4 * 100000);
  var_7 = _func_01A4(var_5, var_6, var_1);
  var_8 = distance(var_5, var_7);

  if(var_8 <= var_2) {
    return 1;
  } else {
    return 0;
  }
}

_id_5060(var_0, var_1) {
  var_2 = anglesToForward(scripts\engine\utility::_id_5CD9(var_0.angles));
  var_3 = vectornormalize(scripts\engine\utility::_id_5CDA(var_1) - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0) {
    return 1;
  } else {
    return 0;
  }
}

_id_1083C(var_0, var_1, var_2) {
  var_0 endon("airstrike_complete");

  if(isDefined(var_2)) {
    var_2 endon("disconnect");
    var_2 endon("joined_team");
  }

  while(!_id_505F(var_0, var_0._id_505D, var_1)) {
    waitframe();
  }
}

_id_F794(var_0, var_1) {
  if(scripts\mp\utility\game::_id_873C()) {
    return 0;
  }

  if(isDefined(level._id_13BD) || isDefined(level._id_32B8)) {
    scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  level._id_13BD = 1;
  thread _id_13E5();
  _id_080C::_id_97A4(var_1, level._id_9AAC);

  switch (var_1) {
    case "air_superiority":
      thread _id_0A2F::_id_13E2(var_0, var_1, self);
      break;
  }

  return 1;
}

_id_F7A1(var_0, var_1) {
  if(scripts\mp\utility\game::_id_873C()) {
    return 0;
  }

  if(isDefined(level._id_13BD) || isDefined(level._id_32B8)) {
    scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_2 = _id_D075(var_0, var_1);

  if(!isDefined(var_2) || !var_2) {
    return 0;
  }

  return 1;
}

_id_D075(var_0, var_1) {
  self endon("stop_location_selection");

  if(!isDefined(level._id_9AC7)) {
    level._id_9AC7 = 1024;
  }

  var_2 = level._id_9AC7 / 6.46875;

  if(level.splitscreen) {
    var_2 = var_2 * 1.5;
  }

  var_3 = 1;
  self setclientomnvar("ui_map_location_num_planes", 1);
  self setclientomnvar("ui_map_location_height", _id_6C35(var_1));
  _id_080C::_id_0B66(var_1, "map_artillery_selector", var_3, var_2, 0.5);
  thread _id_107F1();
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 0;

  while(!var_6 && !scripts\mp\utility\game::_id_873C(0)) {
    self waittill("confirm_location", var_7, var_8);

    if(!var_3) {
      var_8 = 0;
    }

    if(_id_FF48(var_7, var_8, self, var_1)) {
      var_4 = var_7;
      var_5 = var_8;
      self setclientomnvar("ui_map_location_use_carepackages", 0);
      self setclientomnvar("ui_map_location_num_planes", 0);
      self setclientomnvar("ui_map_location_height", 0);
      break;
    } else
      thread _id_DC8B();
  }

  self _meth_82EE(0, 0.3);
  self notify("location_selection_complete");
  _id_080C::_id_DEF2("ks_bombing_run_location_selected");
  self setclientomnvar("ui_map_location_blocked", 0);

  if(scripts\mp\utility\game::_id_873C()) {
    return 0;
  }

  if(isDefined(level._id_13BD) || isDefined(level._id_32B8)) {
    scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  level._id_13BD = 1;
  thread _id_13E5();
  _id_080C::_id_97A4(var_1, var_4);
  thread _id_E720(var_0, [var_4], [var_5], var_1);
  return 1;
}

_id_DC8B() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self endon("stop_location_selection");
  self notify("airstrikeShowBlockedHUD");
  self endon("airstrikeShowBlockedHUD");
  self setclientomnvar("ui_map_location_blocked", 1);
  wait 1.5;
  self setclientomnvar("ui_map_location_blocked", 0);
}

_id_107F1() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self waittill("stop_location_selection");
  self _meth_82EE(0, 0.3);
  self setclientomnvar("ui_map_location_blocked", 0);

  if(scripts\mp\hostmigration::waittillhostmigrationdone() > 0) {
    self switchtoweapon(_id_080C::_id_6AF9());
  }

  level._id_13BD = undefined;
}

_id_FF48(var_0, var_1, var_2, var_3) {
  var_4 = _id_6C35(var_3);
  var_5 = 1;
  return _id_080C::_id_265F(var_0, var_4, var_1, var_5);
}

_id_6B2C() {
  switch (scripts\cp_mp\utility\game_utility::_id_6B2D()) {
    case "mp_battleship_2":
      return 90;
    case "mp_canon_farm":
      return 90;
    case "mp_carentan_s2_winter":
    case "mp_carentan_s2":
      return 0;
    case "mp_d_day":
      return 90;
    case "mp_flak_tower":
      return 90;
    case "mp_forest_01":
      return 15;
    case "mp_france_village":
      return 90;
    case "mp_gibraltar_02":
      return 25;
    case "mp_london":
      return 90;
    case "mp_paris_s2":
      return 90;
    case "mp_ruins_aachen":
      return 90;
    case "mp_wolfslair2":
    case "mp_wolfslair_free":
    case "mp_wolfslair":
      return 0;
    case "mp_scorstreak_training":
      return 90;
    case "mp_raid_d_day":
      return 0;
    case "mp_prague":
      return 0;
    case "mp_v2_rocket_02":
      return 90;
    case "mp_egypt_02":
      return 0;
    case "mp_dunkirk":
      return 90;
    case "mp_stalingrad":
      return 0;
    case "mp_monte_cassino_v2":
    case "mp_market_garden":
      return 90;
    case "mp_airship":
      return 270;
    case "mp_sandbox_01":
      return 0;
    default:
      return 90;
  }
}

_id_81E8() {
  level._id_B192 = [];
}

_id_110D(var_0) {
  level._id_B192[level._id_B192.size] = var_0;
}

_id_C502(var_0) {
  level._id_B192 = scripts\engine\utility::array_remove(level._id_B192, var_0);
}