/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1319.gsc
**************************************/

_id_52F7() {
  _id_5304();
  level._effect["plane_death"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
  level._effect["airstrike_death_allies"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
  level._effect["airstrike_death_axis"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
  level._id_80BC = [];
}

_id_7033(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  switch (var_0) {
    case "firebomb":
    case "airstrike":
      level thread _id_7031(var_0, var_1, var_2, var_3, var_4);
      break;
    case "zm_carepackage":
    case "raid_carepackage":
    case "emergency_carepackage":
    case "carepackage":
      level thread _id_0529::_id_7032(var_1, var_2, var_0, var_5, var_6);
      break;
    case "paratroopers":
      _id_0523::_id_A6E3(var_1, 50, var_2);
      break;
    case "paratrooper_insert":
      _id_0513::_id_A6E2(var_1, var_2);
      break;
  }
}

_id_7031(var_0, var_1, var_2, var_3, var_4) {
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
    var_5 = var_2 maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  }

  var_6 = _id_44E5(var_0) / 2;
  var_7 = var_1._id_34AC + -1 * anglesToForward(var_1.angles) * 2000;
  var_1._id_18C9 = spawn("script_model", (0, 0, 0));
  var_1._id_18C9 setModel("tag_origin");
  var_1._id_18C9 linkTo(var_1, "TAG_BOMB_L", (0, 0, 0), (0, 0, 0));
  var_1._id_18CA = spawn("script_model", (0, 0, 0));
  var_1._id_18CA setModel("tag_origin");
  var_1._id_18CA linkTo(var_1, "TAG_BOMB_R", (0, 0, 0), (0, 0, 0));
  var_8 = 1;

  if(maps\mp\_utility::_id_579B() && isDefined(var_4) && !level._id_79A1) {
    var_8 = 0;
  }

  if(var_8) {
    level thread _id_281E(var_1, var_0);
  }

  wait 4;
  var_1 notify("start_bombing");
  var_1._id_6F2A = 1;
  var_9 = 0;
  var_10 = _id_44E6(var_0);
  var_11 = 0;
  var_12 = 3;
  var_13 = 1;

  while(var_11 <= var_10) {
    var_14 = _id_443B(var_0);
    var_15 = (0, randomint(360), 0);
    var_16 = anglesToForward(var_15) * var_14;
    var_17 = var_1.origin + anglesToForward(var_1.angles) * 2000;
    var_17 = (var_17[0], var_17[1], var_7[2]);
    var_17 = var_17 + var_16;

    if(var_9) {
      var_18 = var_1._id_18C9.origin;
    } else {
      var_18 = var_1._id_18CA.origin;
    }

    var_9 = !var_9;
    var_19 = _func_1B6(_id_443C(var_0, var_2), var_18, var_17, 3.0, var_18[2], var_2);
    var_19._id_0117 = var_1._id_0117;
    var_19.team = var_1.team;

    if(var_0 == "firebomb") {
      var_19 thread _id_051A::_id_27EC(var_5);

      if(var_12 == 3) {
        var_19 thread _id_048E::_id_5ABA();
        var_12 = 1;
      } else if(var_12 < 3)
        var_12++;

      if(var_13 == 1 && var_10 - var_11 < 1) {
        var_19 thread _id_048E::_id_5ABB();
        var_13 = 0;
      }
    } else if(var_0 == "airstrike") {
      if(var_12 == 3) {
        var_19 thread _id_048E::_id_5ABA();
        var_12 = 1;
      } else if(var_12 < 3)
        var_12++;

      if(var_13 == 1 && var_10 - var_11 < 1) {
        var_19 thread _id_048E::_id_5ABB();
        var_13 = 0;
      }
    }

    if(isDefined(var_1._id_5A2C)) {
      var_19 _meth_8505(var_1._id_5A2C);
    }

    var_11 = var_11 + 0.1;
    wait 0.1;
  }

  var_1 notify("stop_bombing");
  level._id_0B93 = undefined;
}

_id_443C(var_0, var_1) {
  switch (var_0) {
    case "firebomb":
      var_2 = 0;

      if(isDefined(var_1)) {
        var_2 = var_1 maps\mp\_utility::_hasperk("specialty_improvedstreaks");
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
    case "airstrike":
      if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == "axis") {
        return "airstrike_bomb_axis_mp";
        return;
      }

      return "airstrike_bomb_mp";
      return;
  }
}

_id_443B(var_0) {
  switch (var_0) {
    case "firebomb":
      return 0;
    case "airstrike":
      return 128;
    default:
      return 0;
  }
}

_id_9302(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
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
    var_10 = bulletTrace(level._id_5FEB + (0, 0, 10000), level._id_5FEB, 0, undefined);
    var_8 = (var_8[0], var_8[1], var_10["position"][2]);

    if(isDefined(var_4)) {
      thread _id_1719(var_0, var_8, var_9, undefined, var_5, var_3, var_4, var_6);
      continue;
    }

    thread _id_1719(var_0, var_8, var_9, self, var_5, var_3, undefined, var_6);
  }
}

_id_1719(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level._id_0B97)) {
    while(isDefined(level._id_0B97)) {
      level waittill("begin_airstrike");
    }

    level._id_0B97 = 1;
  }

  level._id_0B97 = 1;
  var_8 = _id_34B0(var_1, var_3);

  if(isDefined(level.makeglobalunusable) && isDefined(level.makeglobalunusable[var_5])) {
    if(isDefined(var_6)) {
      _id_0526::_id_280E(var_8, var_2, var_5, var_6);
    } else {
      _id_0526::_id_280E(var_8, var_2, var_5, var_3.team);
    }
  }

  _id_1E89(var_0, var_3, var_8, var_2, var_5, var_6, var_4, var_7);
  wait 1.0;
  level._id_0B97 = undefined;

  if(isDefined(var_3)) {
    var_3 notify("begin_airstrike");
  }

  level notify("begin_airstrike");

  if(isDefined(level.makeglobalunusable) && isDefined(level.makeglobalunusable[var_5])) {
    thread _id_0526::_id_5FCB(var_8, var_5);
  }
}

_id_1E89(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = _id_460F(var_4);

  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  }

  var_9 = (0, var_3, 0);
  var_10 = _id_4616(var_2, var_9, var_8, var_4);
  level thread _id_32A7(var_0, var_1, var_2, var_10, var_9, var_4, var_5, var_6, var_7);
}

_id_32A7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  switch (var_5) {
    case "firebomb":
    case "airstrike":
      var_3 = var_3 + -1 * anglesToForward(var_4) * 2000;
      thread _id_909F(var_0, var_1, var_2, var_3, var_4, var_5, 1, var_6);
      break;
    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "emergency_carepackage":
    case "carepackage":
    case "paratroopers":
      thread _id_909F(var_0, var_1, var_2, var_3, var_4, var_5, 1, var_6, var_7, var_8);
      break;
  }
}

_id_909F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_8)) {
    var_10 = var_8;
  } else {
    var_10 = var_7;
  }

  var_11 = _id_4615(var_5, var_1, var_10);
  var_12 = _id_460E(var_5, var_1, var_10);
  var_13 = _id_460A(var_5, var_1, var_10);
  var_14 = spawn("script_model", var_3);
  var_14.angles = var_4;

  if(isDefined(var_12)) {
    var_14 setModel(var_12);
    var_14 thread _id_39C6(var_11, 1);
  } else
    var_14 setModel(var_11);

  if(isDefined(var_13)) {
    var_14 _id_74CE(var_5, var_13);
  }

  if(maps\mp\_utility::_id_579B() && isDefined(var_7)) {
    var_14._id_384B = [];
    var_15 = anglesToForward(var_14.angles + (0, 135, 0));
    var_16 = var_3 + var_15 * 1200;
    var_17 = spawn("script_model", var_16);
    var_17.angles = var_4;
    var_17 setModel(var_11);
    var_17.team = var_7;
    var_17 _id_74CE(var_5, var_13);
    var_14._id_384B[var_14._id_384B.size] = var_17;
    var_15 = anglesToForward(var_14.angles + (0, -135, 0));
    var_16 = var_3 + var_15 * 1200;
    var_17 = spawn("script_model", var_16);
    var_17.angles = var_4;
    var_17 setModel(var_11);
    var_17.team = var_7;
    var_17 _id_74CE(var_5, var_13);
    var_14._id_384B[var_14._id_384B.size] = var_17;
  }

  var_18 = 1;

  if(maps\mp\_utility::_id_585F()) {
    var_18 = 0;
  }

  if(maps\mp\_utility::_id_579B() && isDefined(level._id_79C2.setcontents) && common_scripts\utility::_id_562E(level._id_79C2.setcontents._id_4D10)) {
    var_18 = 0;
  }

  if(isDefined(level._id_0811) && level._id_0811) {
    var_18 = 0;
  }

  if(var_18) {
    var_19 = 1;
    var_20 = 0;
    var_14._id_620D = _func_190("script_model", var_3);
    var_14._id_620D setModel("tag_origin");
    var_21 = var_1;

    if(isDefined(var_7)) {
      var_21 = var_7;
    }

    var_14._id_620D _meth_8351(var_21, _id_4613(var_5), 20, 20, var_20, var_19, _id_4614(var_5));
    var_14._id_620D linktosynchronizedparent(var_14, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  var_14._id_01C8 = var_5;
  _id_09E1(var_14);
  level thread _id_051E::_id_A0DC();
  var_14 setCanDamage(1);
  var_14 setCanRadiusDamage(1);
  var_14 thread maps\mp\gametypes\_damage::_id_8676(_id_4612(var_5), undefined, ::_id_6B9D, ::_id_6B9C, 1);
  var_14 thread _id_4AB8();
  var_14._id_6F2A = 0;
  var_14 _id_74D3(var_5);
  var_14._id_5CC6 = var_0;

  if(isDefined(var_7)) {
    var_14.team = var_7;
  } else if(isDefined(var_1)) {
    var_14._id_0117 = var_1;
    var_14.team = var_1.team;
  } else
    var_14.team = "allies";

  var_14._id_34AC = var_2;
  var_14._id_5C2F = gettime();
  var_14 thread _id_702D(var_5, var_3, var_4);

  if(isDefined(var_14._id_384B)) {
    foreach(var_17 in var_14._id_384B) {
      var_17 thread _id_702D(var_5, var_17.origin, var_4);
    }
  }

  thread _id_7033(var_5, var_14, var_1, var_4, var_7, var_8, var_9);
  var_14 endon("death");
  var_14 endon("crashing");
  var_14 waittill("pathComplete");
  var_14 thread _id_2D47(0);
}

_id_39C6(var_0, var_1) {
  self endon("death");
  self _meth_8450(0, 1, var_1);
  wait(var_1);
  self setModel(var_0);
}

_id_74CE(var_0, var_1) {
  switch (var_0) {
    case "firebomb":
    case "airstrike":
      self scriptmodelplayanim(var_1);
      break;
    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "emergency_carepackage":
    case "carepackage":
    case "paratroopers":
      self scriptmodelplayanimdeltamotion(var_1);
      break;
  }
}

_id_74D3(var_0) {
  switch (var_0) {
    case "fighter_strike":
      _id_0378::_id_8D74("ks_fighterstrike_flyby");
      break;
    case "firebomb":
    case "airstrike":
      _id_0378::_id_8D74("ks_bombing_run_flyby");
      break;
    case "carepackage":
      _id_0378::_id_8D74("ks_carepackage_flyby");
      break;
    case "emergency_carepackage":
      _id_0378::_id_8D74("ks_emergency_carepackage");
      break;
    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "paratroopers":
      _id_0378::_id_8D74("ks_carepackage_flyby");
      break;
  }
}

_id_4612(var_0) {
  switch (var_0) {
    case "airstrike":
      return 1000;
    case "firebomb":
      return 1250;
    case "fighter_strike":
      return 200;
    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      return 1000;
    case "emergency_carepackage":
      return 1500;
    case "uav":
      return 300;
    case "counter_uav":
      return 300;
    case "advanced_uav":
      return 350;
    case "plane_gunner":
      return 3000;
  }
}

_id_4615(var_0, var_1, var_2) {
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
    case "airstrike":
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

_id_460E(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else if(isDefined(var_1)) {
    var_3 = var_1.team;
  } else {
    var_3 = "allies";
  }

  switch (var_0) {
    case "airstrike":
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

_id_460A(var_0, var_1, var_2) {
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
    case "airstrike":
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

_id_4613(var_0) {
  switch (var_0) {
    case "firebomb":
    case "airstrike":
      return "scorestreak_minimap_bombing";
    case "fighter_strike":
      return "scorestreak_minimap_fighter";
    case "plane_gunner":
      return "scorestreak_minimap_fighter";
    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "emergency_carepackage":
    case "carepackage":
    case "paratroopers":
      return "scorestreak_minimap_drop";
  }
}

_id_4614(var_0) {
  switch (var_0) {
    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "emergency_carepackage":
    case "carepackage":
    case "paratroopers":
      return "aid";
    case "airstrike":
      return "explosive";
    case "firebomb":
      return "fire";
  }
}

_id_8C0A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;
  var_6 = 0;
  var_7 = 1;
  var_8 = var_0;

  if(isDefined(var_4)) {
    var_8 = var_4;
  }

  if(isDefined(var_1)) {
    var_9 = var_2 * 2;
    var_1 _meth_8351(var_8, var_3, var_9, var_9, var_7, var_6);
    var_1 _meth_8352(100, var_5);
  }
}

_id_4516() {
  return 80;
}

_id_6B9C(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isDefined(self._id_0117) && var_0 == self._id_0117) {
    return -1;
  }

  var_4 = var_3;

  if(var_1 != "killstreak_flak_gun_mp") {
    switch (var_2) {
      case "MOD_IMPACT":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_EXPLOSIVE":
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

        if(isDefined(var_0) && var_0 maps\mp\_utility::_hasperk("specialty_superbulletpenetration")) {
          var_4 = var_4 * 2.0;
        }

        if(_id_576A(var_1)) {
          var_4 = var_4 * 0.12;
        }

        var_4 = var_4 * 0.15;
        break;
    }
  }

  return maps\mp\gametypes\_damage::_id_62A6(var_0, var_1, var_2, var_4);
}

_id_576A(var_0) {
  foreach(var_2 in level._id_80BC) {
    if(issubstr(var_0, var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_4ACE() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("launcher_missile_fire", var_0, var_1);
    var_1[0] thread _id_9147(self, var_0);
    thread _id_5C27(var_1[0], var_0);
  }
}

_id_9147(var_0, var_1) {
  var_2 = vectorNormalize(var_0.origin - var_1.origin);
  var_3 = 15;
  var_4 = anglesToForward(var_1 getplayerangles());

  if(vectordot(var_2, var_4) >= _cos(var_3)) {
    self setstablemissile(1);
  }
}

_id_5C27(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_2 = _id_4611(self._id_01C8);

  for(;;) {
    var_3 = self.origin;

    if(self._id_01C8 == "fighter_strike") {
      var_3 = self gettagorigin("TAG_BLOOD");
    }

    var_4 = distancesquared(var_0.origin, var_3);

    if(var_4 < var_2) {
      thread _id_5C26(var_0, var_1);
    }

    waitframe();
  }
}

_id_5C26(var_0, var_1) {
  self dodamage(2200, self.origin, var_1, var_0, "MOD_PROJECTILE", var_0._id_A9E0);
  var_0 detonate();
}

_id_2818() {
  self._id_11C7 = 1000;
  self._id_11C5 = 1000;
  self._id_11C9 = _missile_createattractorent(self, self._id_11C7, self._id_11C5);
}

_id_2DD3() {
  if(isDefined(self._id_11C9)) {
    _missile_deleteattractor(self._id_11C9);
  }
}

_id_4611(var_0) {
  switch (var_0) {
    case "fighter_strike":
      return 10000;
    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "advanced_uav":
    case "emergency_carepackage":
    case "carepackage":
    case "counter_uav":
    case "uav":
    case "paratroopers":
    case "plane_gunner":
    case "firebomb":
    case "airstrike":
    default:
      return 22500;
  }
}

_id_2D47(var_0) {
  level endon("game_ended");
  level._id_0B93 = undefined;
  self notify("airstrike_complete");
  _id_7CEE(self);

  if(isDefined(self._id_620D)) {
    self._id_620D delete();
  }

  if(isDefined(self._id_620E)) {
    self._id_620E delete();
  }

  if(isDefined(self)) {
    if(isDefined(self._id_18C9)) {
      self._id_18C9 delete();
    }

    if(isDefined(self._id_18CA)) {
      self._id_18CA delete();
    }

    if(isDefined(self._id_384B)) {
      foreach(var_2 in self._id_384B) {
        var_2 delete();
      }
    }

    self delete();
  }
}

_id_6B9D(var_0, var_1, var_2, var_3) {
  thread _id_272D();
  var_4 = undefined;

  if(self._id_01C8 == "carepackage" || self._id_01C8 == "emergency_carepackage" || self._id_01C8 == "raid_carepackage" || self._id_01C8 == "zm_carepackage") {
    var_4 = "cpkg_destroyed";
  }

  maps\mp\gametypes\_damage::_id_6B4B(var_0, var_1, var_2, var_3, _id_460B(self._id_01C8), var_4, _id_460D(self._id_01C8), 1);
}

_id_272D() {
  self notify("crashing");
  self._id_272A = 1;

  switch (self._id_01C8) {
    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "emergency_carepackage":
    case "carepackage":
    case "paratroopers":
    case "plane_gunner":
    case "fighter_strike":
    case "firebomb":
    case "airstrike":
      break;
  }
}

_id_4AB8(var_0) {
  level endon("game_ended");
  self endon("delete");
  common_scripts\utility::_id_A732("death", "crashing");

  if(isDefined(self)) {
    var_1 = anglesToForward(self.angles);
    playFX(_id_460C(self._id_01C8, self.team), self.origin, var_1);
    _id_0380::_id_2889("ks_plane_destruct_explode", undefined, self.origin);

    if(self._id_01C8 == "airstrike") {
      level notify("aud_carpet_bomb_killed");
    }
  }

  _id_2D47(1);
}

_id_460B(var_0) {
  switch (var_0) {
    case "airstrike":
      return "airstrike_destroyed";
    case "firebomb":
      return "fire_bombing_run_destroyed";
    case "zm_carepackage":
    case "raid_carepackage":
    case "carepackage":
      return "carepackage_plane_destroyed";
    case "emergency_carepackage":
      return "emergency_carepackage_plane_destroyed";
    case "paratrooper_insert":
    case "paratroopers":
      return "paratroopers_plane_destroyed";
  }
}

_id_460D(var_0) {
  switch (var_0) {
    case "airstrike":
      return "callout_destroyed_airstrike";
    case "firebomb":
      return "callout_destroyed_firebomb";
    case "zm_carepackage":
    case "raid_carepackage":
    case "carepackage":
      return "callout_destroyed_carepackage";
    case "emergency_carepackage":
      return "callout_destroyed_emergency_carepackage";
    case "paratrooper_insert":
    case "paratroopers":
      return "callout_destroyed_paratroopers_plane";
  }
}

_id_460C(var_0, var_1) {
  switch (var_0) {
    case "firebomb":
      if(var_1 == "allies") {
        return common_scripts\utility::_id_44F5("plane_death");
      } else {
        return common_scripts\utility::_id_44F5("plane_death");
      }
    case "airstrike":
      if(isDefined(var_1) && var_1 == "allies") {
        return common_scripts\utility::_id_44F5("airstrike_death_allies");
      } else {
        return common_scripts\utility::_id_44F5("airstrike_death_axis");
      }
    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      if(isDefined(var_1) && var_1 == "allies") {
        return common_scripts\utility::_id_44F5("plane_death");
      } else {
        return common_scripts\utility::_id_44F5("plane_death");
      }
    case "emergency_carepackage":
      if(isDefined(var_1) && var_1 == "allies") {
        return common_scripts\utility::_id_44F5("plane_death");
      } else {
        return common_scripts\utility::_id_44F5("plane_death");
      }
    default:
      return common_scripts\utility::_id_44F5("plane_death");
  }
}

_id_702D(var_0, var_1, var_2) {
  switch (var_0) {
    case "firebomb":
    case "airstrike":
      _id_0EA1(var_0, var_1, var_2, 1);
      break;
    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "emergency_carepackage":
    case "carepackage":
    case "paratroopers":
      _id_0EA1(var_0, var_1, var_2, 0);
      break;
  }
}

_id_0EA1(var_0, var_1, var_2, var_3) {
  self endon("airstrike_complete");
  var_4 = _id_44E5(var_0);
  var_5 = _id_44E6(var_0);
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

  thread _id_703B();
  self._id_933D = "flying_in";

  if(1 && isDefined(self._id_620D)) {
    self._id_620D _meth_8352(4000, 1);
  }

  if(1 && isDefined(self._id_620E)) {
    self._id_620E _meth_8352(4000, 1);
  }

  if(isDefined(var_3) && var_3) {
    var_10 = var_1 + anglesToForward(var_2) * var_8;
    self moveTo(var_10, var_9);
  }

  var_11 = 4;

  if(var_0 == "zm_carepackage") {
    var_11 = 2;
  }

  wait(var_11);
  self._id_933D = "strike";
  wait(var_5);
  self._id_933D = "flying_out";

  if(1 && isDefined(self._id_620D)) {
    self._id_620D _meth_8352(4000, 0);
  }

  if(1 && isDefined(self._id_620E)) {
    self._id_620E _meth_8352(4000, 0);
  }

  var_12 = 7;

  if(var_0 == "zm_carepackage") {
    var_12 = 3;
  }

  wait(var_12);
  var_13 = undefined;

  if(!isDefined(self._id_0117)) {
    var_13 = self.team;
  }

  var_14 = _id_460E(var_0, self._id_0117, var_13);

  if(isDefined(var_14)) {
    self setModel(var_14);
    self _meth_8450(1, 0, 1);
  }

  wait 1;
  self notify("pathComplete");
}

_id_703B() {
  self endon("airstrike_complete");
  self endon("pathComplete");

  for(;;) {
    level waittill("host_migration_begin");
    self setshadowrendering(1);
    level waittill("host_migration_end");
    self setshadowrendering(0);
  }
}

_id_7041() {
  self endon("airstrike_complete");
  waitframe();
  _playFXOnTag(common_scripts\utility::_id_44F5("airstrike_engine"), self, "tag_engine_right");
  _playFXOnTag(common_scripts\utility::_id_44F5("airstrike_engine"), self, "tag_engine_left");
  _playFXOnTag(common_scripts\utility::_id_44F5("airstrike_wingtip"), self, "tag_right_wingtip");
  _playFXOnTag(common_scripts\utility::_id_44F5("airstrike_wingtip"), self, "tag_left_wingtip");
}

_id_281E(var_0, var_1) {
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setscriptmoverkillcam("script_entity");
  var_2 _meth_80B1();
  var_3 = 4 + _id_44E6(var_1) + 8;
  var_2 thread _id_2D3B(var_3);
  var_4 = _anglestoaxis((35, -45, 0))["forward"];
  var_2 linkTo(var_0, "tag_origin", var_4 * -1 * 1000, (35, -45, 0));
  var_0._id_5A2C = var_2;
}

_id_2D3B(var_0) {
  self endon("death");
  wait(var_0);
  self delete();
}

_id_4409() {
  if(isDefined(level._id_0B92)) {
    return level._id_0B92;
  }

  var_0 = common_scripts\utility::_id_44BD("warbird_anchor", "targetname");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = (0, 0, 0);
    var_0.targetname = "warbird_anchor";
  }

  if(!isDefined(var_0._id_0165)) {
    var_0._id_0165 = 3500;
  }

  level._id_0B92 = var_0.origin[2] + 3000;
  return level._id_0B92;
}

_id_460F(var_0) {
  var_1 = 0;

  if(isDefined(level._id_0B99) && isDefined(level._id_0B99._id_906E)) {
    var_1 = level._id_0B99._id_906E;
  }

  var_2 = 0;

  if(maps\mp\_utility::_id_4571() == "mp_gibraltar_02") {
    var_2 = 1000;
  }

  if(maps\mp\_utility::_id_4571() == "mp_wolfslair" || maps\mp\_utility::_id_4571() == "mp_wolfslair_free" || maps\mp\_utility::_id_4571() == "mp_wolfslair2") {
    var_2 = 1000;
  }

  if(maps\mp\_utility::_id_4571() == "mp_sandbox_01") {
    var_2 = -1500;
  }

  if(maps\mp\_utility::_id_4571() == "mp_airship" && (var_0 == "carepackage" || var_0 == "emergency_carepackage")) {
    var_2 = 1000;
  }

  var_3 = _id_4409();
  return var_3 + var_1 + var_2;
}

_id_4404(var_0, var_1, var_2) {
  var_3 = anglestoright(var_1);
  var_2._id_92F5 = var_0;
  var_2._id_92F6 = var_0 + var_3 * -1 * 600;
  var_2._id_92F7 = var_0 + var_3 * 600;
  var_2._id_92F8 = var_0 + var_3 * 1200;
  var_2._id_92F9 = var_0 + var_3 * -1200;
}

_id_4616(var_0, var_1, var_2, var_3) {
  var_4 = 6400;

  if(var_3 == "zm_carepackage") {
    var_4 = 4000;
  }

  var_5 = _id_44E5(var_3);
  var_6 = var_5 / 2 + var_4;
  var_7 = var_0 + anglesToForward(var_1) * (-1 * var_6);
  var_7 = var_7 * (1, 1, 0);
  var_7 = var_7 + (0, 0, var_2);
  return var_7;
}

_id_44E5(var_0) {
  switch (var_0) {
    case "airstrike":
      return 6000;
    case "raid_carepackage":
    case "paratrooper_insert":
    case "emergency_carepackage":
    case "carepackage":
    case "paratroopers":
    case "firebomb":
      return 2500;
    case "zm_carepackage":
      return 1500;
  }
}

_id_44E6(var_0) {
  switch (var_0) {
    case "raid_carepackage":
    case "paratrooper_insert":
    case "emergency_carepackage":
    case "carepackage":
    case "paratroopers":
    case "firebomb":
      return 1.5625;
    case "airstrike":
      return 3.75;
    case "zm_carepackage":
      return 0.75;
  }
}

_id_34B0(var_0, var_1) {
  var_2 = var_0;
  var_3 = var_2 + (0, 0, -1000000.0);
  var_4 = bulletTrace(var_2, var_3, 0, var_1);

  for(var_5 = var_4["entity"]; isDefined(var_5) && isDefined(var_5._id_01C8); var_5 = var_4["entity"]) {
    waitframe();
    var_2 = var_4["position"];
    var_4 = bulletTrace(var_2, var_3, 0, var_5);
  }

  return var_4["position"];
}

_id_34AD(var_0, var_1) {
  var_2 = _id_34AF(var_0, var_1);

  if(var_2) {
    var_3 = 1;
  } else {
    var_3 = -1;
  }

  var_4 = common_scripts\utility::_id_3D5D(var_0.origin);
  var_5 = var_4 + anglesToForward(common_scripts\utility::_id_3D5C(var_0.angles)) * (var_3 * 100000);
  var_6 = _pointonsegmentnearesttopoint(var_4, var_5, var_1);
  var_7 = distance(var_4, var_6);
  return var_7;
}

_id_34AE(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 3000;
  }

  var_3 = _id_34AF(var_0, var_1);

  if(var_3) {
    var_4 = 1;
  } else {
    var_4 = -1;
  }

  var_5 = common_scripts\utility::_id_3D5D(var_0.origin);
  var_6 = var_5 + anglesToForward(common_scripts\utility::_id_3D5C(var_0.angles)) * (var_4 * 100000);
  var_7 = _pointonsegmentnearesttopoint(var_5, var_6, var_1);
  var_8 = distance(var_5, var_7);

  if(var_8 <= var_2) {
    return 1;
  } else {
    return 0;
  }
}

_id_34AF(var_0, var_1) {
  var_2 = anglesToForward(common_scripts\utility::_id_3D5C(var_0.angles));
  var_3 = vectorNormalize(common_scripts\utility::_id_3D5D(var_1) - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0) {
    return 1;
  } else {
    return 0;
  }
}

_id_A6E4(var_0, var_1, var_2) {
  var_0 endon("airstrike_complete");

  if(isDefined(var_2)) {
    var_2 endon("disconnect");
    var_2 endon("joined_team");
  }

  while(!_id_34AE(var_0, var_0._id_34AC, var_1)) {
    waitframe();
  }
}

_id_9E35(var_0, var_1) {
  if(maps\mp\_utility::_id_5668()) {
    return 0;
  }

  if(isDefined(level._id_0B93) || isDefined(level._id_2000)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  level._id_0B93 = 1;
  _id_0485::_id_5E9A(var_1, level._id_5FEB);

  switch (var_1) {
    case "airstrike":
      thread _id_0515::_id_0B9A(var_0, var_1, self);
      break;
  }

  return 1;
}

_id_9E3A(var_0, var_1) {
  if(maps\mp\_utility::_id_5668()) {
    return 0;
  }

  if(isDefined(level._id_0B93) || isDefined(level._id_2000)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_2 = vehicle_setvelocity(var_0, var_1);

  if(!isDefined(var_2) || !var_2) {
    return 0;
  }

  return 1;
}

vehicle_setvelocity(var_0, var_1) {
  self endon("stop_location_selection");

  if(!isDefined(level._id_5FF0)) {
    level._id_5FF0 = 1024;
  }

  var_2 = level._id_5FF0 / 6.46875;

  if(level.splitscreen) {
    var_2 = var_2 * 1.5;
  }

  var_3 = 1;
  self setclientomnvar("ui_map_location_num_planes", 1);
  self setclientomnvar("ui_map_location_height", _id_460F(var_1));
  maps\mp\_utility::_id_05D4(var_1, "map_artillery_selector", var_3, var_2, 0.5);
  thread _id_A68F();
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 0;

  while(!var_6 && !maps\mp\_utility::_id_5668(0)) {
    self waittill("confirm_location", var_7, var_8);

    if(!var_3) {
      var_8 = 0;
    }

    if(_id_A272(var_7, var_8, self, var_1)) {
      var_4 = var_7;
      var_5 = var_8;
      self setclientomnvar("ui_map_location_use_carepackages", 0);
      self setclientomnvar("ui_map_location_num_planes", 0);
      self setclientomnvar("ui_map_location_height", 0);
      break;
    } else
      thread _id_8BEE();
  }

  self setblurforplayer(0, 0.3);
  self notify("location_selection_complete");
  _id_0378::_id_8D74("ks_bombing_run_location_selected");
  self setclientomnvar("ui_map_location_blocked", 0);

  if(maps\mp\_utility::_id_5668()) {
    return 0;
  }

  if(isDefined(level._id_0B93) || isDefined(level._id_2000)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  level._id_0B93 = 1;
  _id_0485::_id_5E9A(var_1, var_4);
  thread _id_9302(var_0, [var_4], [var_5], var_1);
  return 1;
}

_id_8BEE() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self endon("stop_location_selection");
  self notify("airstrikeShowBlockedHUD");
  self endon("airstrikeShowBlockedHUD");
  self setclientomnvar("ui_map_location_blocked", 1);
  wait 1.5;
  self setclientomnvar("ui_map_location_blocked", 0);
}

_id_A68F() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self waittill("stop_location_selection");
  self setblurforplayer(0, 0.3);
  self setclientomnvar("ui_map_location_blocked", 0);

  if(maps\mp\gametypes\_hostmigration::_id_A782() > 0) {
    self switchtoweapon(common_scripts\utility::_id_4550());
  }

  level._id_0B93 = undefined;
}

_id_A272(var_0, var_1, var_2, var_3) {
  var_4 = _id_460F(var_3);
  var_5 = 1;
  return _bombingruntracepassed(var_0, var_4, var_1, var_5);
}

_id_4570() {
  switch (maps\mp\_utility::_id_4571()) {
    case "mp_battleship_2":
      return 90;
    case "mp_canon_farm":
      return 90;
    case "mp_carentan_s2":
    case "mp_carentan_s2_winter":
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

_id_5304() {
  level._id_7043 = [];
}

_id_09E1(var_0) {
  level._id_7043[level._id_7043.size] = var_0;
}

_id_7CEE(var_0) {
  level._id_7043 = common_scripts\utility::_id_0F93(level._id_7043, var_0);
}