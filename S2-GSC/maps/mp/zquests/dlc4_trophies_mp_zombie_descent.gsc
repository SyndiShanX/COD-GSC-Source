/***************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\dlc4_trophies_mp_zombie_descent.gsc
***************************************************************/

func_00D5() {
  level thread run_shattered_trophy_event_1();
  level thread run_shattered_trophy_event_2();
  level thread run_shattered_trophy_event_3();
  level thread maps\mp\_utility::func_6F74(::run_shattered_trophy_event_4);
  lib_0547::func_7BA9(::run_shattered_trophy_event_9);
}

complete_descent_trophy_event_1(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC4_ZM_DESCENT", param_00, 1);
}

run_shattered_trophy_event_1() {
  common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_firstdoor", "quest_firstdoor_bloodpool"));
  complete_descent_trophy_event_1();
}

complete_descent_trophy_event_2(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC4_ZM_SUPERIOR", undefined, 1);
}

run_shattered_trophy_event_2() {
  while(!common_scripts\utility::func_3C83("flag_descent_pap")) {
    wait 0.05;
  }

  common_scripts\utility::func_3C9F("flag_descent_pap");
  complete_descent_trophy_event_2();
}

complete_descent_trophy_event_3(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC4_ZM_BLOOD", undefined, 1);
}

run_shattered_trophy_event_3() {
  var_00 = ["zombie_fireman", "zombie_king", "zombie_treasurer", "zombie_sizzler"];
  while(!isDefined(level.var_A50) || level.var_A50.size == 0) {
    wait 0.05;
  }

  wait 0.05;
  foreach(var_03, var_02 in level.var_A50) {
    if(common_scripts\utility::func_F79(var_00, var_03)) {
      continue;
    }

    common_scripts\utility::func_3C87(var_03 + "_trophy_event_3");
  }

  foreach(var_03, var_02 in level.var_A50) {
    if(common_scripts\utility::func_F79(var_00, var_03)) {
      continue;
    }

    common_scripts\utility::func_3C9F(var_03 + "_trophy_event_3");
  }

  complete_descent_trophy_event_3();
}

complete_descent_trophy_event_4(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC4_ZM_LONG", param_00, 1);
}

run_shattered_trophy_event_4() {
  var_00 = self;
  wait_for_moon_raven_orb_gap("zone_cave", "zone_bridge");
  complete_descent_trophy_event_4(var_00);
}

complete_descent_trophy_event_5(param_00) {
  param_00.craftedweapons++;
  maps\mp\gametypes\zombies::func_47A8("DLC4_ZM_MOONRAVEN", param_00, 1);
}

complete_descent_trophy_event_6(param_00) {
  param_00.craftedweapons++;
  maps\mp\gametypes\zombies::func_47A8("DLC4_ZM_BLOODRAVEN", param_00, 1);
}

complete_descent_trophy_event_7(param_00) {
  param_00.craftedweapons++;
  maps\mp\gametypes\zombies::func_47A8("DLC4_ZM_DEATHRAVEN", param_00, 1);
}

complete_descent_trophy_event_8(param_00) {
  param_00.craftedweapons++;
  maps\mp\gametypes\zombies::func_47A8("DLC4_ZM_STORMRAVEN", param_00, 1);
}

complete_descent_trophy_event_9(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC4_ZM_WEAPON", param_00, 1);
}

run_shattered_trophy_event_9(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  if(!isDefined(param_01.ravenweapontracker)) {
    param_01.ravenweapontracker = [];
    foreach(var_0B, var_0A in level.ravenweaponmanager) {
      if(issubstr(var_0B, "emp")) {
        continue;
      }

      param_01.ravenweapontracker[var_0B] = 0;
    }
  }

  foreach(var_0D, var_0A in param_01.ravenweapontracker) {
    if(issubstr(param_04, var_0D)) {
      param_01.ravenweapontracker[var_0D]++;
    }
  }

  foreach(var_0D, var_0A in param_01.ravenweapontracker) {
    if(param_01.ravenweapontracker[var_0D] < 100) {
      return;
    }
  }

  complete_descent_trophy_event_9(param_01);
}

complete_descent_trophy_event_10(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC4_ZM_KINGFALL", undefined, 1);
}

wait_for_moon_raven_orb_gap(param_00, param_01) {
  for(;;) {
    self waittill("zmb_moonraven_grenade_gap", var_02, var_03);
    if(!isDefined(var_02) || var_02 != param_00) {
      continue;
    }

    if(!isDefined(var_03) || var_03 != param_01) {
      continue;
    }

    break;
  }
}