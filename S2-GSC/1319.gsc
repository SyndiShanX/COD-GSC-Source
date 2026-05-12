/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1319.gsc
*********************************************/

lib_0527::func_52F7() {
  lib_0527::func_5304();
  level.var_0611["plane_death"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
  level.var_0611["airstrike_death_allies"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
  level.var_0611["airstrike_death_axis"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
  level.var_80BC = [];
}

lib_0527::func_7033(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  switch (param_00) {
    case "firebomb":
    case "airstrike":
      level thread lib_0527::func_7031(param_00, param_01, param_02, param_03, param_04);
      break;

    case "zm_carepackage":
    case "raid_carepackage":
    case "emergency_carepackage":
    case "carepackage":
      level thread lib_0529::func_7032(param_01, param_02, param_00, param_05, param_06);
      break;

    case "paratroopers":
      maps\mp\killstreaks\_paratroopers::func_A6E3(param_01, 50, param_02);
      break;

    case "paratrooper_insert":
      maps\mp\gametypes\_weapons::func_A6E2(param_01, param_02);
      break;
  }
}

lib_0527::func_7031(param_00, param_01, param_02, param_03, param_04) {
  level endon("game_ended");
  param_01 endon("airstrike_complete");
  param_01 endon("delete");
  param_01 endon("death");
  param_01 endon("crashing");
  if(isDefined(param_02)) {
    param_02 endon("disconnect");
  }

  var_05 = 0;
  if(isDefined(param_02)) {
    var_05 = param_02 maps\mp\_utility::func_0649("specialty_improvedstreaks");
  }

  var_06 = lib_0527::func_44E5(param_00) / 2;
  var_07 = param_01.var_34AC + -1 * anglesToForward(param_01.var_001D) * 2000;
  param_01.var_18C9 = spawn("script_model", (0, 0, 0));
  param_01.var_18C9 setModel("tag_origin");
  param_01.var_18C9 linkto(param_01, "TAG_BOMB_L", (0, 0, 0), (0, 0, 0));
  param_01.var_18CA = spawn("script_model", (0, 0, 0));
  param_01.var_18CA setModel("tag_origin");
  param_01.var_18CA linkto(param_01, "TAG_BOMB_R", (0, 0, 0), (0, 0, 0));
  var_08 = 1;
  if(maps\mp\_utility::func_579B() && isDefined(param_04) && !level.var_79A1) {
    var_08 = 0;
  }

  if(var_08) {
    level thread lib_0527::func_281E(param_01, param_00);
  }

  wait(4);
  param_01 notify("start_bombing");
  param_01.var_6F2A = 1;
  var_09 = 0;
  var_0A = lib_0527::func_44E6(param_00);
  var_0B = 0;
  var_0C = 3;
  var_0D = 1;
  while(var_0B <= var_0A) {
    var_0E = lib_0527::func_443B(param_00);
    var_0F = (0, randomint(360), 0);
    var_10 = anglesToForward(var_0F) * var_0E;
    var_11 = param_01.var_0116 + anglesToForward(param_01.var_001D) * 2000;
    var_11 = (var_11[0], var_11[1], var_07[2]);
    var_11 = var_11 + var_10;
    if(var_09) {
      var_12 = param_01.var_18C9.var_0116;
    } else {
      var_12 = param_01.var_18CA.var_0116;
    }

    var_09 = !var_09;
    var_13 = magicartillery(lib_0527::func_443C(param_00, param_02), var_12, var_11, 3, var_12[2], param_02);
    var_13.var_0117 = param_01.var_0117;
    var_13.var_01A7 = param_01.var_01A7;
    if(param_00 == "firebomb") {
      var_13 thread maps\mp\killstreaks\_firebomb::func_27EC(var_05);
      if(var_0C == 3) {
        var_13 thread maps\mp\_snd_common_mp::func_5ABA();
        var_0C = 1;
      } else if(var_0C < 3) {
        var_0C++;
      }

      if(var_0D == 1 && var_0A - var_0B < 1) {
        var_13 thread maps\mp\_snd_common_mp::func_5ABB();
        var_0D = 0;
      }
    } else if(param_00 == "airstrike") {
      if(var_0C == 3) {
        var_13 thread maps\mp\_snd_common_mp::func_5ABA();
        var_0C = 1;
      } else if(var_0C < 3) {
        var_0C++;
      }

      if(var_0D == 1 && var_0A - var_0B < 1) {
        var_13 thread maps\mp\_snd_common_mp::func_5ABB();
        var_0D = 0;
      }
    }

    if(isDefined(param_01.var_5A2C)) {
      var_13 method_8505(param_01.var_5A2C);
    }

    var_0B = var_0B + 0.1;
    wait(0.1);
  }

  param_01 notify("stop_bombing");
  level.var_0B93 = undefined;
}

lib_0527::func_443C(param_00, param_01) {
  switch (param_00) {
    case "firebomb":
      var_02 = 0;
      if(isDefined(param_01)) {
        var_02 = param_01 maps\mp\_utility::func_0649("specialty_improvedstreaks");
      }

      if(var_02) {
        if(isDefined(param_01) && isDefined(param_01.var_01A7) && param_01.var_01A7 == "axis") {
          return "firebomb_bomb_axis_grenadier_mp";
        } else {
          return "firebomb_bomb_grenadier_mp";
        }
      } else if(isDefined(param_01) && isDefined(param_01.var_01A7) && param_01.var_01A7 == "axis") {
        return "firebomb_bomb_axis_mp";
      } else {
        return "firebomb_bomb_mp";
      }

      break;

    case "airstrike":
      if(isDefined(var_02) && isDefined(var_02.var_01A7) && var_02.var_01A7 == "axis") {
        return "airstrike_bomb_axis_mp";
      }
      return "airstrike_bomb_mp";
  }
}

lib_0527::func_443B(param_00) {
  switch (param_00) {
    case "firebomb":
      return 0;

    case "airstrike":
      return 128;

    default:
      return 0;
  }
}

lib_0527::func_9302(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self notify("used");
  if(!isDefined(param_05)) {
    if(isDefined(param_04)) {
      param_05 = param_04;
    } else {
      param_05 = self.var_012C["team"];
    }
  }

  for(var_07 = 0; var_07 < param_01.size; var_07++) {
    var_08 = param_01[var_07];
    var_09 = param_02[var_07];
    var_0A = bulletTrace(level.var_5FEB + (0, 0, 10000), level.var_5FEB, 0, undefined);
    var_08 = (var_08[0], var_08[1], var_0A["position"][2]);
    if(isDefined(param_04)) {
      thread lib_0527::func_1719(param_00, var_08, var_09, undefined, param_05, param_03, param_04, param_06);
      continue;
    }

    thread lib_0527::func_1719(param_00, var_08, var_09, self, param_05, param_03, undefined, param_06);
  }
}

lib_0527::func_1719(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(isDefined(level.var_0B97)) {
    while(isDefined(level.var_0B97)) {
      level waittill("begin_airstrike");
    }

    level.var_0B97 = 1;
  }

  level.var_0B97 = 1;
  var_08 = lib_0527::func_34B0(param_01, param_03);
  if(isDefined(level.var_80B5) && isDefined(level.var_80B5[param_05])) {
    if(isDefined(param_06)) {
      lib_0526::func_280E(var_08, param_02, param_05, param_06);
    } else {
      lib_0526::func_280E(var_08, param_02, param_05, param_03.var_01A7);
    }
  }

  lib_0527::func_1E89(param_00, param_03, var_08, param_02, param_05, param_06, param_04, param_07);
  wait(1);
  level.var_0B97 = undefined;
  if(isDefined(param_03)) {
    param_03 notify("begin_airstrike");
  }

  level notify("begin_airstrike");
  if(isDefined(level.var_80B5) && isDefined(level.var_80B5[param_05])) {
    thread lib_0526::func_5FCB(var_08, param_05);
  }
}

lib_0527::func_1E89(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = lib_0527::func_460F(param_04);
  if(isDefined(param_01)) {
    param_01 endon("disconnect");
  }

  var_09 = (0, param_03, 0);
  var_0A = lib_0527::func_4616(param_02, var_09, var_08, param_04);
  level thread lib_0527::func_32A7(param_00, param_01, param_02, var_0A, var_09, param_04, param_05, param_06, param_07);
}

lib_0527::func_32A7(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  switch (param_05) {
    case "firebomb":
    case "airstrike":
      param_03 = param_03 + -1 * anglesToForward(param_04) * 2000;
      thread lib_0527::func_909F(param_00, param_01, param_02, param_03, param_04, param_05, 1, param_06);
      break;

    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "emergency_carepackage":
    case "carepackage":
    case "paratroopers":
      thread lib_0527::func_909F(param_00, param_01, param_02, param_03, param_04, param_05, 1, param_06, param_07, param_08);
      break;
  }
}

lib_0527::func_909F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_08)) {
    var_0A = param_08;
  } else {
    var_0A = param_08;
  }

  var_0B = lib_0527::func_4615(param_05, param_01, var_0A);
  var_0C = lib_0527::func_460E(param_05, param_01, var_0A);
  var_0D = lib_0527::func_460A(param_05, param_01, var_0A);
  var_0E = spawn("script_model", param_03);
  var_0E.var_001D = param_04;
  if(isDefined(var_0C)) {
    var_0E setModel(var_0C);
    var_0E thread lib_0527::func_39C6(var_0B, 1);
  } else {
    var_0E setModel(var_0B);
  }

  if(isDefined(var_0D)) {
    var_0E lib_0527::func_74CE(param_05, var_0D);
  }

  if(maps\mp\_utility::func_579B() && isDefined(param_07)) {
    var_0E.var_384B = [];
    var_0F = anglesToForward(var_0E.var_001D + (0, 135, 0));
    var_10 = param_03 + var_0F * 1200;
    var_11 = spawn("script_model", var_10);
    var_11.var_001D = param_04;
    var_11 setModel(var_0B);
    var_11.var_01A7 = param_07;
    var_11 lib_0527::func_74CE(param_05, var_0D);
    var_0E.var_384B[var_0E.var_384B.size] = var_11;
    var_0F = anglesToForward(var_0E.var_001D + (0, -135, 0));
    var_10 = param_03 + var_0F * 1200;
    var_11 = spawn("script_model", var_10);
    var_11.var_001D = param_04;
    var_11 setModel(var_0B);
    var_11.var_01A7 = param_07;
    var_11 lib_0527::func_74CE(param_05, var_0D);
    var_0E.var_384B[var_0E.var_384B.size] = var_11;
  }

  var_12 = 1;
  if(maps\mp\_utility::func_585F()) {
    var_12 = 0;
  }

  if(maps\mp\_utility::func_579B() && isDefined(level.var_79C2.var_80B0) && common_scripts\utility::func_562E(level.var_79C2.var_80B0.var_4D10)) {
    var_12 = 0;
  }

  if(isDefined(level.var_0811) && level.var_0811) {
    var_12 = 0;
  }

  if(var_12) {
    var_13 = 1;
    var_14 = 0;
    var_0E.var_620D = spawnplane("script_model", param_03);
    var_0E.var_620D setModel("tag_origin");
    var_15 = param_01;
    if(isDefined(param_07)) {
      var_15 = param_07;
    }

    var_0E.var_620D method_8351(var_15, lib_0527::func_4613(param_05), 20, 20, var_14, var_13, lib_0527::func_4614(param_05));
    var_0E.var_620D method_8449(var_0E, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  var_0E.var_01C8 = param_05;
  lib_0527::func_09E1(var_0E);
  level thread maps\mp\killstreaks\_killstreaks::func_A0DC();
  var_0E setCanDamage(1);
  var_0E setCanRadiusDamage(1);
  var_0E thread maps\mp\gametypes\_damage::func_8676(lib_0527::func_4612(param_05), undefined, ::lib_0527::func_6B9D, ::lib_0527::func_6B9C, 1);
  var_0E thread lib_0527::func_4AB8();
  var_0E.var_6F2A = 0;
  var_0E lib_0527::func_74D3(param_05);
  var_0E.var_5CC6 = param_00;
  if(isDefined(param_07)) {
    var_0E.var_01A7 = param_07;
  } else if(isDefined(param_01)) {
    var_0E.var_0117 = param_01;
    var_0E.var_01A7 = param_01.var_01A7;
  } else {
    var_0E.var_01A7 = "allies";
  }

  var_0E.var_34AC = param_02;
  var_0E.var_5C2F = gettime();
  var_0E thread lib_0527::func_702D(param_05, param_03, param_04);
  if(isDefined(var_0E.var_384B)) {
    foreach(var_11 in var_0E.var_384B) {
      var_11 thread lib_0527::func_702D(param_05, var_11.var_0116, param_04);
    }
  }

  thread lib_0527::func_7033(param_05, var_0E, param_01, param_04, param_07, param_08, param_09);
  var_0E endon("death");
  var_0E endon("crashing");
  var_0E waittill("pathComplete");
  var_0E thread lib_0527::func_2D47(0);
}

lib_0527::func_39C6(param_00, param_01) {
  self endon("death");
  self setmaterialscriptparam(0, 1, param_01);
  wait(param_01);
  self setModel(param_00);
}

lib_0527::func_74CE(param_00, param_01) {
  switch (param_00) {
    case "firebomb":
    case "airstrike":
      self scriptmodelplayanim(param_01);
      break;

    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "emergency_carepackage":
    case "carepackage":
    case "paratroopers":
      self method_8278(param_01);
      break;
  }
}

lib_0527::func_74D3(param_00) {
  switch (param_00) {
    case "fighter_strike":
      lib_0378::func_8D74("ks_fighterstrike_flyby");
      break;

    case "firebomb":
    case "airstrike":
      lib_0378::func_8D74("ks_bombing_run_flyby");
      break;

    case "carepackage":
      lib_0378::func_8D74("ks_carepackage_flyby");
      break;

    case "emergency_carepackage":
      lib_0378::func_8D74("ks_emergency_carepackage");
      break;

    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "paratroopers":
      lib_0378::func_8D74("ks_carepackage_flyby");
      break;
  }
}

lib_0527::func_4612(param_00) {
  switch (param_00) {
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

lib_0527::func_4615(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    var_03 = param_02;
  } else if(isDefined(param_02)) {
    var_03 = param_02.var_01A7;
  } else {
    var_03 = "allies";
  }

  switch (param_00) {
    case "firebomb":
      if(var_03 == "allies") {
        return "ger_bomber_lancaster_vista";
      } else {
        return "ger_bomber_he_177_vista";
      }

      break;

    case "airstrike":
      if(isDefined(var_03) && var_03 == "allies") {
        return "usa_bomber_a20_vista";
      } else {
        return "ger_bomber_he_111_vista_ai";
      }

      break;

    case "raid_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      if(isDefined(var_03) && var_03 == "allies") {
        return "usa_bomber_skytrain_vista";
      } else {
        return "ger_bomber_junkers52_vista";
      }

      break;

    case "zm_carepackage":
      return "usa_bomber_skytrain_vista";

    case "emergency_carepackage":
      if(isDefined(var_03) && var_03 == "allies") {
        return "usa_bomber_commando_vista";
      }
      return "ger_bomber_wiking_vista";
  }
}

lib_0527::func_460E(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    var_03 = param_02;
  } else if(isDefined(param_02)) {
    var_03 = param_02.var_01A7;
  } else {
    var_03 = "allies";
  }

  switch (param_00) {
    case "airstrike":
      if(isDefined(var_03) && var_03 == "allies") {
        return "usa_bomber_a20_vista_fade";
      } else {
        return "ger_bomber_he_111_vista_ai_fade";
      }

      break;

    case "raid_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      if(isDefined(var_03) && var_03 == "allies") {
        return "usa_bomber_skytrain_vista_fade";
      } else {
        return "ger_bomber_junkers52_vista_fade";
      }

      break;

    case "zm_carepackage":
      return "usa_bomber_skytrain_vista_fade";

    case "emergency_carepackage":
      if(isDefined(var_03) && var_03 == "allies") {
        return "usa_bomber_commando_vista_fade";
      }
      return "ger_bomber_wiking_vista_fade";
  }
}

lib_0527::func_460A(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    var_03 = param_02;
  } else if(isDefined(param_02)) {
    var_03 = param_02.var_01A7;
  } else {
    var_03 = "allies";
  }

  switch (param_00) {
    case "firebomb":
      if(var_03 == "allies") {
        return "ks_firebomb_usa";
      } else {
        return "ks_firebomb_ger";
      }

      break;

    case "airstrike":
      if(isDefined(var_03) && var_03 == "allies") {
        return "ks_carpetbomb_usa";
      } else {
        return "ks_carpetbomb_ger";
      }

      break;

    case "carepackage":
      if(isDefined(var_03) && var_03 == "allies") {
        return "ks_carepackage_usa_animated";
      } else {
        return "ks_carepackage_ger_animated";
      }

      break;

    case "raid_carepackage":
      if(game["defenders"] == "allies") {
        return "ks_carepackage_usa_animated";
      } else {
        return "ks_carepackage_ger_animated";
      }

      break;

    case "zm_carepackage":
      return "ks_carepackage_ger_animated";

    case "paratrooper_insert":
    case "paratroopers":
      if(isDefined(var_03) && var_03 == "allies") {
        return "ks_paratrooper_usa_animated";
      } else {
        return "ks_paratrooper_ger_animated";
      }

      break;

    case "emergency_carepackage":
      if(isDefined(var_03) && var_03 == "allies") {
        return "ks_emergency_airdrop_usa_animated";
      }
      return "ks_emergency_airdrop_ger_animated";
  }
}

lib_0527::func_4613(param_00) {
  switch (param_00) {
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

lib_0527::func_4614(param_00) {
  switch (param_00) {
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

lib_0527::func_8C0A(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 1;
  var_06 = 0;
  var_07 = 1;
  var_08 = param_00;
  if(isDefined(param_04)) {
    var_08 = param_04;
  }

  if(isDefined(param_01)) {
    var_09 = param_02 * 2;
    param_01 method_8351(var_08, param_03, var_09, var_09, var_07, var_06);
    param_01 method_8352(100, var_05);
  }
}

lib_0527::func_4516() {
  return 80;
}

lib_0527::func_6B9C(param_00, param_01, param_02, param_03) {
  if(isDefined(param_00) && isDefined(self.var_0117) && param_00 == self.var_0117) {
    return -1;
  }

  var_04 = param_03;
  if(param_01 != "killstreak_flak_gun_mp") {
    switch (param_02) {
      case "MOD_IMPACT":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_EXPLOSIVE":
        var_04 = var_04 * 0.6;
        break;

      case "MOD_EXPLOSIVE_BULLET":
        var_04 = var_04 * 0.4;
        break;

      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
      default:
        if(issubstr(param_01, "fmj")) {
          var_04 = var_04 * 2;
        }

        if(isDefined(param_00) && param_00 maps\mp\_utility::func_0649("specialty_superbulletpenetration")) {
          var_04 = var_04 * 2;
        }

        if(lib_0527::func_576A(param_01)) {
          var_04 = var_04 * 0.12;
        }

        var_04 = var_04 * 0.15;
        break;
    }
  }

  return maps\mp\gametypes\_damage::func_62A6(param_00, param_01, param_02, var_04);
}

lib_0527::func_576A(param_00) {
  foreach(var_02 in level.var_80BC) {
    if(issubstr(param_00, var_02)) {
      return 1;
    }
  }

  return 0;
}

lib_0527::func_4ACE() {
  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("launcher_missile_fire", var_00, var_01);
    var_01[0] thread lib_0527::func_9147(self, var_00);
    thread lib_0527::func_5C27(var_01[0], var_00);
  }
}

lib_0527::func_9147(param_00, param_01) {
  var_02 = vectornormalize(param_00.var_0116 - param_01.var_0116);
  var_03 = 15;
  var_04 = anglesToForward(param_01 getangles());
  if(vectordot(var_02, var_04) >= cos(var_03)) {
    self setstablemissile(1);
  }
}

lib_0527::func_5C27(param_00, param_01) {
  self endon("death");
  param_00 endon("death");
  var_02 = lib_0527::func_4611(self.var_01C8);
  for(;;) {
    var_03 = self.var_0116;
    if(self.var_01C8 == "fighter_strike") {
      var_03 = self gettagorigin("TAG_BLOOD");
    }

    var_04 = distancesquared(param_00.var_0116, var_03);
    if(var_04 < var_02) {
      thread lib_0527::func_5C26(param_00, param_01);
    }

    wait 0.05;
  }
}

lib_0527::func_5C26(param_00, param_01) {
  self dodamage(2200, self.var_0116, param_01, param_00, "MOD_PROJECTILE", param_00.var_A9E0);
  param_00 method_81D6();
}

lib_0527::func_2818() {
  self.var_11C7 = 1000;
  self.var_11C5 = 1000;
  self.var_11C9 = missilecreateattractorent(self, self.var_11C7, self.var_11C5);
}

lib_0527::func_2DD3() {
  if(isDefined(self.var_11C9)) {
    missiledeleteattractor(self.var_11C9);
  }
}

lib_0527::func_4611(param_00) {
  switch (param_00) {
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

lib_0527::func_2D47(param_00) {
  level endon("game_ended");
  level.var_0B93 = undefined;
  self notify("airstrike_complete");
  lib_0527::func_7CEE(self);
  if(isDefined(self.var_620D)) {
    self.var_620D delete();
  }

  if(isDefined(self.var_620E)) {
    self.var_620E delete();
  }

  if(isDefined(self)) {
    if(isDefined(self.var_18C9)) {
      self.var_18C9 delete();
    }

    if(isDefined(self.var_18CA)) {
      self.var_18CA delete();
    }

    if(isDefined(self.var_384B)) {
      foreach(var_02 in self.var_384B) {
        var_02 delete();
      }
    }

    self delete();
  }
}

lib_0527::func_6B9D(param_00, param_01, param_02, param_03) {
  thread lib_0527::func_272D();
  var_04 = undefined;
  if(self.var_01C8 == "carepackage" || self.var_01C8 == "emergency_carepackage" || self.var_01C8 == "raid_carepackage" || self.var_01C8 == "zm_carepackage") {
    var_04 = "cpkg_destroyed";
  }

  maps\mp\gametypes\_damage::func_6B4B(param_00, param_01, param_02, param_03, lib_0527::func_460B(self.var_01C8), var_04, lib_0527::func_460D(self.var_01C8), 1);
}

lib_0527::func_272D() {
  self notify("crashing");
  self.var_272A = 1;
  switch (self.var_01C8) {
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

lib_0527::func_4AB8(param_00) {
  level endon("game_ended");
  self endon("delete");
  common_scripts\utility::func_A732("death", "crashing");
  if(isDefined(self)) {
    var_01 = anglesToForward(self.var_001D);
    playFX(lib_0527::func_460C(self.var_01C8, self.var_01A7), self.var_0116, var_01);
    lib_0380::func_2889("ks_plane_destruct_explode", undefined, self.var_0116);
    if(self.var_01C8 == "airstrike") {
      level notify("aud_carpet_bomb_killed");
    }
  }

  lib_0527::func_2D47(1);
}

lib_0527::func_460B(param_00) {
  switch (param_00) {
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

lib_0527::func_460D(param_00) {
  switch (param_00) {
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

lib_0527::func_460C(param_00, param_01) {
  switch (param_00) {
    case "firebomb":
      if(param_01 == "allies") {
        return common_scripts\utility::func_44F5("plane_death");
      } else {
        return common_scripts\utility::func_44F5("plane_death");
      }

      break;

    case "airstrike":
      if(isDefined(param_01) && param_01 == "allies") {
        return common_scripts\utility::func_44F5("airstrike_death_allies");
      } else {
        return common_scripts\utility::func_44F5("airstrike_death_axis");
      }

      break;

    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "carepackage":
    case "paratroopers":
      if(isDefined(param_01) && param_01 == "allies") {
        return common_scripts\utility::func_44F5("plane_death");
      } else {
        return common_scripts\utility::func_44F5("plane_death");
      }

      break;

    case "emergency_carepackage":
      if(isDefined(param_01) && param_01 == "allies") {
        return common_scripts\utility::func_44F5("plane_death");
      } else {
        return common_scripts\utility::func_44F5("plane_death");
      }

      break;

    default:
      return common_scripts\utility::func_44F5("plane_death");
  }
}

lib_0527::func_702D(param_00, param_01, param_02) {
  switch (param_00) {
    case "firebomb":
    case "airstrike":
      lib_0527::func_0EA1(param_00, param_01, param_02, 1);
      break;

    case "zm_carepackage":
    case "raid_carepackage":
    case "paratrooper_insert":
    case "emergency_carepackage":
    case "carepackage":
    case "paratroopers":
      lib_0527::func_0EA1(param_00, param_01, param_02, 0);
      break;
  }
}

lib_0527::func_0EA1(param_00, param_01, param_02, param_03) {
  self endon("airstrike_complete");
  var_04 = lib_0527::func_44E5(param_00);
  var_05 = lib_0527::func_44E6(param_00);
  var_06 = 6400;
  var_07 = 12800;
  if(param_00 == "zm_carepackage") {
    var_06 = 4000;
    var_07 = 8000;
  }

  var_08 = var_06 + var_04 + var_07;
  var_09 = 4 + var_05 + 8;
  if(param_00 == "zm_carepackage") {
    var_09 = 2 + var_05 + 4;
  }

  thread lib_0527::func_703B();
  self.var_933D = "flying_in";
  if(1 && isDefined(self.var_620D)) {
    self.var_620D method_8352(4000, 1);
  }

  if(1 && isDefined(self.var_620E)) {
    self.var_620E method_8352(4000, 1);
  }

  if(isDefined(param_03) && param_03) {
    var_0A = param_01 + anglesToForward(param_02) * var_08;
    self moveto(var_0A, var_09);
  }

  var_0B = 4;
  if(param_00 == "zm_carepackage") {
    var_0B = 2;
  }

  wait(var_0B);
  self.var_933D = "strike";
  wait(var_05);
  self.var_933D = "flying_out";
  if(1 && isDefined(self.var_620D)) {
    self.var_620D method_8352(4000, 0);
  }

  if(1 && isDefined(self.var_620E)) {
    self.var_620E method_8352(4000, 0);
  }

  var_0C = 7;
  if(param_00 == "zm_carepackage") {
    var_0C = 3;
  }

  wait(var_0C);
  var_0D = undefined;
  if(!isDefined(self.var_0117)) {
    var_0D = self.var_01A7;
  }

  var_0E = lib_0527::func_460E(param_00, self.var_0117, var_0D);
  if(isDefined(var_0E)) {
    self setModel(var_0E);
    self setmaterialscriptparam(1, 0, 1);
  }

  wait(1);
  self notify("pathComplete");
}

lib_0527::func_703B() {
  self endon("airstrike_complete");
  self endon("pathComplete");
  for(;;) {
    level waittill("host_migration_begin");
    self scriptmodelpauseanim(1);
    level waittill("host_migration_end");
    self scriptmodelpauseanim(0);
  }
}

lib_0527::func_7041() {
  self endon("airstrike_complete");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("airstrike_engine"), self, "tag_engine_right");
  playFXOnTag(common_scripts\utility::func_44F5("airstrike_engine"), self, "tag_engine_left");
  playFXOnTag(common_scripts\utility::func_44F5("airstrike_wingtip"), self, "tag_right_wingtip");
  playFXOnTag(common_scripts\utility::func_44F5("airstrike_wingtip"), self, "tag_left_wingtip");
}

lib_0527::func_281E(param_00, param_01) {
  var_02 = spawn("script_model", (0, 0, 0));
  var_02 setscriptmoverkillcam("script_entity");
  var_02 method_80B1();
  var_03 = 4 + lib_0527::func_44E6(param_01) + 8;
  var_02 thread lib_0527::func_2D3B(var_03);
  var_04 = anglestoaxis((35, -45, 0))["forward"];
  var_02 linkto(param_00, "tag_origin", var_04 * -1 * 1000, (35, -45, 0));
  param_00.var_5A2C = var_02;
}

lib_0527::func_2D3B(param_00) {
  self endon("death");
  wait(param_00);
  self delete();
}

lib_0527::func_4409() {
  if(isDefined(level.var_0B92)) {
    return level.var_0B92;
  }

  var_00 = common_scripts\utility::func_44BD("warbird_anchor", "targetname");
  if(!isDefined(var_00)) {
    var_00 = spawnStruct();
    var_00.var_0116 = (0, 0, 0);
    var_00.var_01A5 = "warbird_anchor";
  }

  if(!isDefined(var_00.var_0165)) {
    var_00.var_0165 = 3500;
  }

  level.var_0B92 = var_00.var_0116[2] + 3000;
  return level.var_0B92;
}

lib_0527::func_460F(param_00) {
  var_01 = 0;
  if(isDefined(level.var_0B99) && isDefined(level.var_0B99.var_906E)) {
    var_01 = level.var_0B99.var_906E;
  }

  var_02 = 0;
  if(maps\mp\_utility::func_4571() == "mp_gibraltar_02") {
    var_02 = 1000;
  }

  if(maps\mp\_utility::func_4571() == "mp_wolfslair" || maps\mp\_utility::func_4571() == "mp_wolfslair_free" || maps\mp\_utility::func_4571() == "mp_wolfslair2") {
    var_02 = 1000;
  }

  if(maps\mp\_utility::func_4571() == "mp_sandbox_01") {
    var_02 = -1500;
  }

  if(maps\mp\_utility::func_4571() == "mp_airship" && param_00 == "carepackage" || param_00 == "emergency_carepackage") {
    var_02 = 1000;
  }

  var_03 = lib_0527::func_4409();
  return var_03 + var_01 + var_02;
}

lib_0527::func_4404(param_00, param_01, param_02) {
  var_03 = anglestoright(param_01);
  param_02.var_92F5 = param_00;
  param_02.var_92F6 = param_00 + var_03 * -1 * 600;
  param_02.var_92F7 = param_00 + var_03 * 600;
  param_02.var_92F8 = param_00 + var_03 * 1200;
  param_02.var_92F9 = param_00 + var_03 * -1200;
}

lib_0527::func_4616(param_00, param_01, param_02, param_03) {
  var_04 = 6400;
  if(param_03 == "zm_carepackage") {
    var_04 = 4000;
  }

  var_05 = lib_0527::func_44E5(param_03);
  var_06 = var_05 / 2 + var_04;
  var_07 = param_00 + anglesToForward(param_01) * -1 * var_06;
  var_07 = var_07 * (1, 1, 0);
  var_07 = var_07 + (0, 0, param_02);
  return var_07;
}

lib_0527::func_44E5(param_00) {
  switch (param_00) {
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

lib_0527::func_44E6(param_00) {
  switch (param_00) {
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

lib_0527::func_34B0(param_00, param_01) {
  var_02 = param_00;
  var_03 = var_02 + (0, 0, -1000000);
  var_04 = bulletTrace(var_02, var_03, 0, param_01);
  for(var_05 = var_04["entity"]; isDefined(var_05) && isDefined(var_05.var_01C8); var_05 = var_04["entity"]) {
    wait 0.05;
    var_02 = var_04["position"];
    var_04 = bulletTrace(var_02, var_03, 0, var_05);
  }

  return var_04["position"];
}

lib_0527::func_34AD(param_00, param_01) {
  var_02 = lib_0527::func_34AF(param_00, param_01);
  if(var_02) {
    var_03 = 1;
  } else {
    var_03 = -1;
  }

  var_04 = common_scripts\utility::func_3D5D(param_00.var_0116);
  var_05 = var_04 + anglesToForward(common_scripts\utility::func_3D5C(param_00.var_001D)) * var_03 * 100000;
  var_06 = pointonsegmentnearesttopoint(var_04, var_05, param_01);
  var_07 = distance(var_04, var_06);
  return var_07;
}

lib_0527::func_34AE(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 3000;
  }

  var_03 = lib_0527::func_34AF(param_00, param_01);
  if(var_03) {
    var_04 = 1;
  } else {
    var_04 = -1;
  }

  var_05 = common_scripts\utility::func_3D5D(param_00.var_0116);
  var_06 = var_05 + anglesToForward(common_scripts\utility::func_3D5C(param_00.var_001D)) * var_04 * 100000;
  var_07 = pointonsegmentnearesttopoint(var_05, var_06, param_01);
  var_08 = distance(var_05, var_07);
  if(var_08 <= param_02) {
    return 1;
  }

  return 0;
}

lib_0527::func_34AF(param_00, param_01) {
  var_02 = anglesToForward(common_scripts\utility::func_3D5C(param_00.var_001D));
  var_03 = vectornormalize(common_scripts\utility::func_3D5D(param_01) - param_00.var_0116);
  var_04 = vectordot(var_02, var_03);
  if(var_04 > 0) {
    return 1;
  }

  return 0;
}

lib_0527::func_A6E4(param_00, param_01, param_02) {
  param_00 endon("airstrike_complete");
  if(isDefined(param_02)) {
    param_02 endon("disconnect");
    param_02 endon("joined_team");
  }

  while(!lib_0527::func_34AE(param_00, param_00.var_34AC, param_01)) {
    wait 0.05;
  }
}

lib_0527::func_9E35(param_00, param_01) {
  if(maps\mp\_utility::func_5668()) {
    return 0;
  }

  if(isDefined(level.var_0B93) || isDefined(level.var_2000)) {
    self iclientprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  level.var_0B93 = 1;
  maps\mp\_matchdata::func_5E9A(param_01, level.var_5FEB);
  switch (param_01) {
    case "airstrike":
      thread maps\mp\killstreaks\_airstrike::func_0B9A(param_00, param_01, self);
      break;
  }

  return 1;
}

lib_0527::func_9E3A(param_00, param_01) {
  if(maps\mp\_utility::func_5668()) {
    return 0;
  }

  if(isDefined(level.var_0B93) || isDefined(level.var_2000)) {
    self iclientprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_02 = lib_0527::func_83BA(param_00, param_01);
  if(!isDefined(var_02) || !var_02) {
    return 0;
  }

  return 1;
}

lib_0527::func_83BA(param_00, param_01) {
  self endon("stop_location_selection");
  if(!isDefined(level.var_5FF0)) {
    level.var_5FF0 = 1024;
  }

  var_02 = level.var_5FF0 / 6.46875;
  if(level.var_910F) {
    var_02 = var_02 * 1.5;
  }

  var_03 = 1;
  self setclientomnvar("ui_map_location_num_planes", 1);
  self setclientomnvar("ui_map_location_height", lib_0527::func_460F(param_01));
  maps\mp\_utility::func_05D4(param_01, "map_artillery_selector", var_03, var_02, 0.5);
  thread lib_0527::func_A68F();
  var_04 = undefined;
  var_05 = undefined;
  var_06 = 0;
  while(!var_06 && !maps\mp\_utility::func_5668(0)) {
    self waittill("confirm_location", var_07, var_08);
    if(!var_03) {
      var_08 = 0;
    }

    if(lib_0527::func_A272(var_07, var_08, self, param_01)) {
      var_04 = var_07;
      var_05 = var_08;
      self setclientomnvar("ui_map_location_use_carepackages", 0);
      self setclientomnvar("ui_map_location_num_planes", 0);
      self setclientomnvar("ui_map_location_height", 0);
      break;
    } else {
      thread lib_0527::func_8BEE();
    }
  }

  self setblurforplayer(0, 0.3);
  self notify("location_selection_complete");
  lib_0378::func_8D74("ks_bombing_run_location_selected");
  self setclientomnvar("ui_map_location_blocked", 0);
  if(maps\mp\_utility::func_5668()) {
    return 0;
  }

  if(isDefined(level.var_0B93) || isDefined(level.var_2000)) {
    self iclientprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  level.var_0B93 = 1;
  maps\mp\_matchdata::func_5E9A(param_01, var_04);
  thread lib_0527::func_9302(param_00, [var_04], [var_05], param_01);
  return 1;
}

lib_0527::func_8BEE() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self endon("stop_location_selection");
  self notify("airstrikeShowBlockedHUD");
  self endon("airstrikeShowBlockedHUD");
  self setclientomnvar("ui_map_location_blocked", 1);
  wait(1.5);
  self setclientomnvar("ui_map_location_blocked", 0);
}

lib_0527::func_A68F() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self waittill("stop_location_selection");
  self setblurforplayer(0, 0.3);
  self setclientomnvar("ui_map_location_blocked", 0);
  if(maps\mp\gametypes\_hostmigration::func_A782() > 0) {
    self switchtoweapon(common_scripts\utility::func_4550());
  }

  level.var_0B93 = undefined;
}

lib_0527::func_A272(param_00, param_01, param_02, param_03) {
  var_04 = lib_0527::func_460F(param_03);
  var_05 = 1;
  return bombingruntracepassed(param_00, var_04, param_01, var_05);
}

lib_0527::func_4570() {
  switch (maps\mp\_utility::func_4571()) {
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

lib_0527::func_5304() {
  level.var_7043 = [];
}

lib_0527::func_09E1(param_00) {
  level.var_7043[level.var_7043.size] = param_00;
}

lib_0527::func_7CEE(param_00) {
  level.var_7043 = common_scripts\utility::func_0F93(level.var_7043, param_00);
}