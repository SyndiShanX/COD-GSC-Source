/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1280.gsc
*********************************************/

func_533F() {
  lib_0502::func_8671("scorestreak_enabled_uav", 0);
  lib_0502::func_8671("scorestreak_enabled_carepackage", 0);
  lib_0502::func_8671("scorestreak_enabled_counter_uav", 0);
  lib_0502::func_8671("scorestreak_enabled_flamethrower", 1);
  lib_0502::func_8671("scorestreak_enabled_fritzx", 0);
  lib_0502::func_8671("scorestreak_enabled_mortar_strike", 1);
  lib_0502::func_8671("scorestreak_enabled_missile_strike", 0);
  lib_0502::func_8671("scorestreak_enabled_airstrike", 0);
  lib_0502::func_8671("scorestreak_enabled_firebomb", 0);
  lib_0502::func_8671("scorestreak_enabled_emergency_carepackage", 0);
  lib_0502::func_8671("scorestreak_enabled_fighter_strike", 0);
  lib_0502::func_8671("scorestreak_enabled_advanced_uav", 0);
  lib_0502::func_8671("scorestreak_enabled_attack_dogs", 0);
  lib_0502::func_8671("scorestreak_enabled_flak_gun", 0);
  lib_0502::func_8671("scorestreak_enabled_v2_rocket", 0);
  lib_0502::func_8671("scorestreak_enabled_plane_gunner", 0);
  lib_0502::func_8671("scorestreak_enabled_paratroopers", 0);
  lib_0502::func_8671("scorestreak_enabled_molotovs", 1);
  lib_0502::func_8671("scorestreak_enabled_raid_flak", 1);
  lib_0502::func_8671("scorestreak_enabled_raid_fighters", 1);
  lib_0502::func_8671("scorestreak_enabled_raid_superweapon", 1);
  lib_0502::func_8671("scorestreak_enabled_raid_tesla_moon", 1);
  lib_0502::func_8671("scorestreak_enabled_raid_ss_serum_a", 1);
  lib_0502::func_8671("scorestreak_enabled_raid_ss_serum_b", 1);
  lib_0502::func_8671("scorestreak_enabled_raid_ss_serum_c", 1);
  level.var_79C2.var_80B0 = spawnStruct();
  level.var_79C2.var_80B0.var_B98 = 0.333333;
  level.var_79C2.var_80B0.var_624A = 0.333333;
  level.var_79C2.var_80B0.var_4D10 = 1;
  level.var_79C2.var_80B0.var_B9C = ::func_0B9B;
  level.var_79C2.var_80B0.var_3AAF = ::func_3AAE;
  level.var_791C = lib_0501::func_4648("raid_scorestreaks");
  level thread lib_0526::func_52F6();
  level thread lib_0527::func_52F7();
  level thread maps\mp\killstreaks\_v2_missle_strike::func_52F5();
  level thread maps\mp\killstreaks\_missile_strike::func_D5();
  level thread maps\mp\killstreaks\_airstrike::func_D5();
  level thread maps\mp\killstreaks\_mortarstrike::func_D5();
  level thread maps\mp\killstreaks\_fighter_strike::func_D5();
  level thread maps\mp\killstreaks\_flamethrower::func_D5();
  level thread maps\mp\killstreaks\_raid_superweapon::func_D5();
  level thread maps\mp\killstreaks\_raid_ss_serum_a::func_D5();
  level thread maps\mp\killstreaks\_raid_ss_serum_b::func_D5();
  level thread maps\mp\killstreaks\_raid_ss_serum_c::func_D5();
  level thread maps\mp\gametypes\_raid_tesla_gun::func_D5();
  level thread maps\mp\killstreaks\_molotovs::func_D5();
  level thread lib_0517::func_D5();
  if(level.var_15D == "mp_raid_dlc2") {
    level thread maps\mp\gametypes\_raid_tripwire::runtripwirelogic();
    level thread maps\mp\gametypes\_raid_bomber_scorestreaks::init_bomber_killstreaks();
  }

  if(level.var_15D == "mp_raid_dlc3") {
    level thread maps\mp\gametypes\_raid_tripwire::runtripwirelogic();
    level thread maps\mp\gametypes\_raid_incendiary_can::runincendiarycanlogic();
  }

  var_00 = [];
  var_00 = common_scripts\utility::func_F6F(var_00, ["flamethrower", 85, "support", &"MP_FLAMETHROWER_PICKUP"]);
  var_00 = common_scripts\utility::func_F6F(var_00, ["mortar_strike", 85, "support", &"MP_MORTAR_STRIKE_PICKUP"]);
  lib_0529::func_52F4(var_00);
}

func_1E8A(param_00, param_01, param_02) {
  if(param_00 == "fighter_strike") {
    thread maps\mp\killstreaks\_fighter_strike::func_1E83(-1, undefined, param_02[0].var_116, param_02[0].var_1D[1], "fighter_strike", param_01);
    return;
  }

  if(param_00 == "mortar_strike") {
    thread maps\mp\killstreaks\_v2_missle_strike::func_9303(-1, [param_02[0].var_116, param_02[1].var_116, param_02[2].var_116], "mortar_strike", 1, param_01);
    return;
  }

  if(param_00 == "missile_strike") {
    thread maps\mp\killstreaks\_v2_missle_strike::func_9303(-1, [param_02[0].var_116], "missile_strike", 1, param_01);
    return;
  }

  if(param_00 == "airstrike") {
    thread maps\mp\killstreaks\_airstrike::func_B9A(-1, "airstrike", undefined, param_01, param_02[0].var_116, param_02[0].var_1D[1]);
    return;
  }
}

func_4678(param_00, param_01, param_02, param_03, param_04) {
  var_05 = level.var_79AE.var_8DB[0][[level.var_79AE.var_8DB[0].var_6940]]();
  var_06 = [];
  foreach(var_08 in level.var_1B69) {
    if(var_08.var_931A == "active") {
      var_06[var_06.size] = var_08.var_9D65;
    }
  }

  var_0A = [];
  while(var_0A.size < param_00) {
    var_0B = undefined;
    if(isDefined(param_04)) {
      var_0C = randomint(param_04.size);
      var_0B = (0, randomfloatrange(param_04[var_0C].var_61BC, param_04[var_0C].var_6076), 0);
    } else {
      var_0B = (0, randomfloat(360), 0);
    }

    var_0D = anglesToForward(var_0B);
    var_0E = var_05.var_116;
    var_0F = getnodesinradiussorted(var_05.var_116, 256, 0);
    if(var_0F.size > 0) {
      var_0E = (var_0E[0], var_0E[1], var_0F[0].var_116[2]);
    }

    var_10 = 0;
    while(!var_10) {
      var_0E = var_0E + var_0D * randomfloat(2000);
      var_11 = getnodesinradiussorted(var_0E, 256, 0);
      if(var_11.size == 0) {
        if(distance2dsquared(var_0E, var_05.var_116) > 1000000) {
          var_10 = 1;
        }
      } else {
        var_12 = 1;
        if(var_12 && distance2dsquared(var_0E, var_05.var_116) > 4000000) {
          foreach(var_14 in var_06) {
            if(var_14 method_858B(var_0E)) {
              var_10 = 1;
              break;
            }
          }
        }
      }

      var_11 = getnodesinradiussorted(var_0E, 256, 0);
      if(var_11.size == 0) {
        var_11 = getnodesinradiussorted(var_0E, 512, 0);
        if(var_11.size == 0) {
          var_11 = getnodesinradiussorted(var_0E, 1024, 0);
        }
      }

      if(var_11.size > 0) {
        var_0E = (var_0E[0], var_0E[1], var_11[0].var_116[2]);
      }
    }

    var_16 = spawnStruct();
    var_16.var_116 = var_0E;
    var_16.var_1D = param_03;
    var_0A[var_0A.size] = var_16;
  }

  return var_0A;
}

func_0B9B(param_00) {
  thread lib_04F3::func_79CB("mp_war_ks_air_raid_siren", (-12288, -4096, 1024));
  maps\mp\gametypes\_hostmigration::func_A6F5(param_00);
  thread lib_04F3::func_79CB("mp_war_ks_air_raid_siren", level.var_5FEB + (4096, 8192, 1024));
}

func_3AAE(param_00) {
  param_00 endon("death");
  param_00 endon("delete");
  param_00 endon("deathOrTimeout");
  param_00 endon("leavingPlayspace");
  param_00 endon("startPullUp");
  lib_0502::func_8671("scr_fighter_fire_rate", "0.10");
  lib_0502::func_8671("scr_fighter_burst_min", "0.50");
  lib_0502::func_8671("scr_fighter_burst_max", "2.00");
  lib_0502::func_8671("scr_fighter_pause_min", "0.25");
  lib_0502::func_8671("scr_fighter_pause_max", "0.80");
  var_01 = max(0.05, getdvarfloat("scr_fighter_fire_rate"));
  var_02 = getdvarfloat("scr_fighter_burst_min");
  var_03 = getdvarfloat("scr_fighter_burst_max");
  var_04 = getdvarfloat("scr_fighter_pause_min");
  var_05 = getdvarfloat("scr_fighter_pause_max");
  var_06 = param_00.var_1D + (4, 0, 0);
  for(;;) {
    var_07 = int(1000 * randomfloatrange(var_02, var_03));
    var_08 = randomfloatrange(var_04, var_05);
    while(var_07 > 0) {
      param_00.var_1D = var_06;
      param_00.var_1EB5.var_1D = var_06;
      maps\mp\killstreaks\_fighter_strike::func_3AAB(param_00, undefined);
      wait(var_01);
      var_06 = var_06 - (0.25, 0, 0);
      var_09 = int(1000 * var_01);
      var_07 = var_07 - var_09;
    }

    wait(var_08);
  }
}

func_5A6C(param_00, param_01) {
  if(!isDefined(level.var_79C2.var_5A5D)) {
    level.var_79C2.var_5A5D = [];
  }

  level.var_79C2.var_5A5D[param_00] = param_01;
}

func_83B1(param_00, param_01, param_02, param_03) {
  var_04 = ["airstrike", "attack_dogs", "carepackage", "flak_gun", "flamethrower", "fighter_strike", "firebomb", "fritzx", "missile_strike", "molotovs", "mortar_strike", "paratroopers", "plane_gunner", "uav", "v2_rocket"];
  if(!isDefined(level.var_79C2.var_5A5D)) {
    return "no_killstreak_available";
  }

  if(!isDefined(level.var_79C2.var_5A5D[param_00])) {
    return "no_killstreak_available";
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(isarray(level.var_79C2.var_5A5D[param_00])) {
    var_05 = level.var_79C2.var_5A5D[param_00].size - 1;
    if(!isDefined(param_01)) {
      param_01 = 1;
    }

    var_06 = int(exp(min(1, param_01) * var_05));
    if(isDefined(param_02) && param_02 == 1) {
      var_06 = int(max(0, min(var_05, var_06 + randomint(5) - 2)));
    }

    var_07 = level.var_79C2.var_5A5D[param_00][var_06];
    if(param_03 == 1 && level.var_79C2.var_5A5D[param_00].size > 1) {
      level.var_79C2.var_5A5D[param_00] = func_0F99(level.var_79C2.var_5A5D[param_00], var_07);
    }
  } else {
    var_07 = level.var_79C2.var_5A5D[param_01];
  }

  if(common_scripts\utility::func_F79(var_04, var_07) == 0) {
    return "no_killstreak_available";
  }

  return var_07;
}

func_0F99(param_00, param_01) {
  var_02 = 0;
  var_03 = [];
  foreach(var_05 in param_00) {
    if(var_05 != param_01 || var_02 == 1) {
      var_03[var_03.size] = var_05;
    }

    if(var_05 == param_01) {
      var_02 = 1;
    }
  }

  return var_03;
}

func_1E85(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02) || !common_scripts\utility::func_F79(level.var_696E, param_02)) {
    iprintlnbold("attempting to call in air drop for non existent objective");
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_03)) {
    param_03 = "flamethrower";
  }

  if(!level.var_791C) {
    return;
  }

  if(isDefined(param_01)) {
    if(!function_030D(param_01)) {
      param_01 = 0;
    }

    wait(param_01);
  }

  var_04 = func_444B(param_00, param_02);
  if(!isDefined(var_04)) {
    return;
  }

  var_05 = undefined;
  var_06 = common_scripts\utility::func_F92(level.var_744A);
  foreach(var_08 in var_06) {
    if(var_08.var_1A7 != param_00) {
      continue;
    }

    var_05 = var_08;
    break;
  }

  if(!isDefined(var_05)) {
    return;
  }

  var_0A = lib_0527::func_4570();
  var_05 thread lib_0527::func_9302(var_05.var_5CC6, [var_04], [var_0A], "carepackage", undefined, lib_0502::func_7979(param_00), param_03);
  var_0B = level common_scripts\utility::func_A74D("airdropInbound", 20);
  if(isDefined(var_0B) && var_0B == "timeout") {
    return;
  }

  if(param_00 == game["attackers"]) {
    thread lib_0506::func_A618("attacker_airdrop");
  } else {
    thread lib_0506::func_A618("defender_airdrop");
  }

  thread maps\mp\_utility::func_9863("raids_airdrop_incoming", var_05, param_00);
}

func_444B(param_00, param_01) {
  var_02 = undefined;
  if(isDefined(level.var_79C2.var_693B[param_01].var_B7F) && level.var_79C2.var_693B[param_01].var_B7F.size > 0) {
    var_03["none"] = [];
    var_03[game["attackers"]] = [];
    var_03[game["defenders"]] = [];
    foreach(var_05 in level.var_79C2.var_693B[param_01].var_B7F) {
      if(isDefined(var_05.var_8260) && var_05.var_8260 == "attackers") {
        var_03[game["attackers"]][var_03[game["attackers"]].size] = var_05;
        continue;
      }

      if(isDefined(var_05.var_8260) && var_05.var_8260 == "defenders") {
        var_03[game["defenders"]][var_03[game["defenders"]].size] = var_05;
        continue;
      }

      var_03["none"][var_03["none"].size] = var_05;
    }

    if(!var_03[param_00].size) {
      return var_03["none"][randomint(var_03["none"].size)].var_116;
    } else {
      return var_03[param_00][randomint(var_03[param_00].size)].var_116;
    }
  }

  return undefined;
}

func_9917(param_00, param_01) {
  var_02 = lib_050D::func_44F9(param_00);
  var_03 = [];
  var_04 = getgamespawnpointactivelabel(param_00);
  foreach(var_06 in var_02) {
    if(var_06.var_1A5 == var_04 && var_06.var_9849 == param_00 && var_06.var_6C97) {
      var_07 = lib_0527::func_4570();
      param_01 lib_0527::func_9302(param_01, [var_06.var_116], [var_07], "raid_carepackage", undefined, lib_0502::func_7979(param_00));
    }
  }
}

func_2AAD(param_00, param_01) {
  self endon("disconnect");
  level endon("game_ended");
  for(var_02 = 1; var_02; var_02 = 0) {
    if(!maps\mp\_utility::func_57A0(param_00)) {
      wait(1);
      continue;
    }

    param_00 maps\mp\killstreaks\_killstreaks::func_478D(param_01, 0, 0, param_00);
    param_00 thread maps\mp\gametypes\_hud_message::func_9102(param_01);
  }
}