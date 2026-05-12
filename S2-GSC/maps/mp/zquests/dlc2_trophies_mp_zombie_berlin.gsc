/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\dlc2_trophies_mp_zombie_berlin.gsc
**************************************************************/

func_00D5() {
  level thread maps\mp\_utility::func_6F74(::set_players_have_fired_shot);
  level thread run_berlin_trophy_event_3();
  level thread run_berlin_trophy_event_4();
  level thread run_berlin_trophy_event_5();
  level thread run_berlin_trophy_event_6();
  level thread run_berlin_trophy_event_7();
  level thread run_berlin_trophy_event_8();
  level thread run_berlin_trophy_event_9();
  level thread run_berlin_trophy_event_10();
}

complete_berlin_trophy_event_1() {
  maps\mp\gametypes\zombies::func_47A8("DLC2_ZM_STADT_DOWN", undefined, 1);
}

complete_berlin_trophy_event_2() {
  maps\mp\gametypes\zombies::func_47A8("DLC2_ZM_DAS", undefined, 1);
}

complete_berlin_trophy_event_3(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC2_ZM_BALLISTIC", param_00, 1);
}

run_berlin_trophy_event_3() {
  var_00 = level.berlin_melee_weapons;
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, ::maps\mp\zquests\zmb_secret_challenges_util::monitor_players_using_melee_weapons, ::complete_berlin_trophy_event_3, 14, var_00, "DLC2_ZM_BALLISTIC", ::maps\mp\zquests\zmb_secret_challenges_util::player_using_valid_weapons_no_mercy);
}

complete_berlin_trophy_event_4(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC2_ZM_WUNDERFUL", param_00, 0);
}

run_berlin_trophy_event_4() {
  var_00 = ["zombie_sizzler"];
  var_01 = ["wunderbuss_zm"];
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, ::maps\mp\zquests\zmb_secret_challenges_util::monitor_players_zombie_kills, ::complete_berlin_trophy_event_4, 50, [var_00, var_01], "DLC2_ZM_WUNDERFUL", ::maps\mp\zquests\zmb_secret_challenges_util::player_killed_correct_zombie_type);
}

complete_berlin_trophy_event_5(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC2_ZM_SHOW", undefined, 0);
}

run_berlin_trophy_event_5() {
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(1, ::maps\mp\zquests\zmb_secret_challenges_util::gekocht_stage_challenge, ::complete_berlin_trophy_event_5, 60, undefined, "DLC2_ZM_SHOW");
}

complete_berlin_trophy_event_6(param_00) {
  if(!common_scripts\utility::func_562E(level.players_zombies_have_fired_weapon)) {
    maps\mp\gametypes\zombies::func_47A8("DLC2_ZM_AMMO", undefined, 1);
  }
}

run_berlin_trophy_event_6() {
  lib_054D::func_7BC6(::watch_fail_berlin_trophy_event_6);
}

fail_berlin_trophy_event_6() {
  lib_054D::func_2D8D(::watch_fail_berlin_trophy_event_6);
  level.players_zombies_have_fired_weapon = 1;
}

complete_berlin_trophy_event_7(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC2_ZM_PRAYER", undefined, 0);
}

run_berlin_trophy_event_7() {
  maps\mp\zquests\zmb_secret_challenges_util::wait_for_round(20);
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(1, ::maps\mp\zquests\zmb_secret_challenges_util::monitor_players_survival_in_zone, ::complete_berlin_trophy_event_7, 3, ["zone_church_interior"], "DLC2_ZM_PRAYER");
}

complete_berlin_trophy_event_8(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC2_ZM_MUSEUM", param_00, 0);
}

run_berlin_trophy_event_8() {
  var_00 = ["zone_museum_hall"];
  var_01 = ["zom_dlc2_4_zm"];
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, ::maps\mp\zquests\zmb_secret_challenges_util::monitor_players_zombie_kills, ::complete_berlin_trophy_event_8, 250, [var_00, var_01], "DLC2_ZM_MUSEUM", [::maps\mp\zquests\zmb_secret_challenges_util::player_killed_zombie_in_zones, ::maps\mp\zquests\zmb_secret_challenges_util::player_using_valid_weapons]);
}

complete_berlin_trophy_event_9(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC2_ZM_DESTROYER", param_00, 0);
}

run_berlin_trophy_event_9() {
  var_00 = ["zombie_generic", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_sizzler"];
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, ::maps\mp\zquests\zmb_secret_challenges_util::monitor_players_zombie_geistkraft_collections, ::complete_berlin_trophy_event_9, undefined, var_00, "DLC2_ZM_DESTROYER");
}

complete_berlin_trophy_event_10(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC2_ZM_LUMBERJACK", param_00, 0);
}

run_berlin_trophy_event_10() {
  var_00 = ["zombie_heavy"];
  var_01 = ["zom_dlc2_4_zm", "zom_dlc2_1_zm", "zom_dlc2_3_zm", "zom_dlc2_2_zm"];
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, ::maps\mp\zquests\zmb_secret_challenges_util::monitor_players_zombie_wustling_melee_kills, ::complete_berlin_trophy_event_10, var_01.size, [var_00, var_01], "DLC2_ZM_LUMBERJACK", ::maps\mp\zquests\zmb_secret_challenges_util::valid_zombie_and_no_duplicate_melee_weapons);
}

watch_fail_berlin_trophy_event_6(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = lib_0547::zm_get_weapon_class(param_05);
  var_0C = 1;
  if(lib_0547::func_5863(param_05)) {
    return;
  }

  if(lib_0547::isvalidequipmentzombies(param_05)) {
    return;
  }

  if(lib_0547::func_5565(var_0B, "weapon_other")) {
    var_0C = 0;
  }

  if(lib_0547::func_5565(var_0B, "other")) {
    var_0C = 0;
  }

  if(issubstr(param_05, "shovel")) {
    var_0C = 0;
  }

  if(maps\mp\zquests\zmb_secret_challenges_util::array_contains_subtring(level.berlin_melee_weapons, param_05)) {
    var_0C = 0;
  }

  if(var_0C) {
    fail_berlin_trophy_event_6();
  }
}

set_players_have_fired_shot() {
  var_00 = self;
  var_01 = "wunderbuss";
  while(issubstr(var_01, "wunderbuss")) {
    var_00 waittill("weapon_fired", var_01);
  }

  fail_berlin_trophy_event_6();
}