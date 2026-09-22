/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zquests\dlc2_trophies_mp_zombie_berlin.gsc
**********************************************************************/

init() {
  level thread maps\mp\_utility::_id_6F74(::set_players_have_fired_shot);
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
  maps\mp\gametypes\zombies::_id_47A8("DLC2_ZM_STADT_DOWN", undefined, 1);
}

complete_berlin_trophy_event_2() {
  maps\mp\gametypes\zombies::_id_47A8("DLC2_ZM_DAS", undefined, 1);
}

complete_berlin_trophy_event_3(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC2_ZM_BALLISTIC", var_0, 1);
}

run_berlin_trophy_event_3() {
  var_0 = level.berlin_melee_weapons;
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, maps\mp\zquests\zmb_secret_challenges_util::monitor_players_using_melee_weapons, ::complete_berlin_trophy_event_3, 14, var_0, "DLC2_ZM_BALLISTIC", maps\mp\zquests\zmb_secret_challenges_util::player_using_valid_weapons_no_mercy);
}

complete_berlin_trophy_event_4(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC2_ZM_WUNDERFUL", var_0, 0);
}

run_berlin_trophy_event_4() {
  var_0 = ["zombie_sizzler"];
  var_1 = ["wunderbuss_zm"];
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, maps\mp\zquests\zmb_secret_challenges_util::monitor_players_zombie_kills, ::complete_berlin_trophy_event_4, 50, [var_0, var_1], "DLC2_ZM_WUNDERFUL", maps\mp\zquests\zmb_secret_challenges_util::player_killed_correct_zombie_type);
}

complete_berlin_trophy_event_5(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC2_ZM_SHOW", undefined, 0);
}

run_berlin_trophy_event_5() {
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(1, maps\mp\zquests\zmb_secret_challenges_util::gekocht_stage_challenge, ::complete_berlin_trophy_event_5, 60, undefined, "DLC2_ZM_SHOW");
}

complete_berlin_trophy_event_6(var_0) {
  if(!common_scripts\utility::_id_562E(level.players_zombies_have_fired_weapon)) {
    maps\mp\gametypes\zombies::_id_47A8("DLC2_ZM_AMMO", undefined, 1);
  }
}

run_berlin_trophy_event_6() {
  _id_054D::_id_7BC6(::watch_fail_berlin_trophy_event_6);
}

fail_berlin_trophy_event_6() {
  _id_054D::_id_2D8D(::watch_fail_berlin_trophy_event_6);
  level.players_zombies_have_fired_weapon = 1;
}

complete_berlin_trophy_event_7(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC2_ZM_PRAYER", undefined, 0);
}

run_berlin_trophy_event_7() {
  maps\mp\zquests\zmb_secret_challenges_util::wait_for_round(20);
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(1, maps\mp\zquests\zmb_secret_challenges_util::monitor_players_survival_in_zone, ::complete_berlin_trophy_event_7, 3, ["zone_church_interior"], "DLC2_ZM_PRAYER");
}

complete_berlin_trophy_event_8(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC2_ZM_MUSEUM", var_0, 0);
}

run_berlin_trophy_event_8() {
  var_0 = ["zone_museum_hall"];
  var_1 = ["zom_dlc2_4_zm"];
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, maps\mp\zquests\zmb_secret_challenges_util::monitor_players_zombie_kills, ::complete_berlin_trophy_event_8, 250, [var_0, var_1], "DLC2_ZM_MUSEUM", [maps\mp\zquests\zmb_secret_challenges_util::player_killed_zombie_in_zones, maps\mp\zquests\zmb_secret_challenges_util::player_using_valid_weapons]);
}

complete_berlin_trophy_event_9(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC2_ZM_DESTROYER", var_0, 0);
}

run_berlin_trophy_event_9() {
  var_0 = ["zombie_generic", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_sizzler"];
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, maps\mp\zquests\zmb_secret_challenges_util::monitor_players_zombie_geistkraft_collections, ::complete_berlin_trophy_event_9, undefined, var_0, "DLC2_ZM_DESTROYER");
}

complete_berlin_trophy_event_10(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC2_ZM_LUMBERJACK", var_0, 0);
}

run_berlin_trophy_event_10() {
  var_0 = ["zombie_heavy"];
  var_1 = ["zom_dlc2_4_zm", "zom_dlc2_1_zm", "zom_dlc2_3_zm", "zom_dlc2_2_zm"];
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, maps\mp\zquests\zmb_secret_challenges_util::monitor_players_zombie_wustling_melee_kills, ::complete_berlin_trophy_event_10, var_1.size, [var_0, var_1], "DLC2_ZM_LUMBERJACK", maps\mp\zquests\zmb_secret_challenges_util::valid_zombie_and_no_duplicate_melee_weapons);
}

watch_fail_berlin_trophy_event_6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = _id_0547::zm_get_weapon_class(var_5);
  var_12 = 1;

  if(_id_0547::_id_5863(var_5)) {
    return;
  }
  if(_id_0547::isvalidequipmentzombies(var_5)) {
    return;
  }
  if(_id_0547::_id_5565(var_11, "weapon_other")) {
    var_12 = 0;
  }

  if(_id_0547::_id_5565(var_11, "other")) {
    var_12 = 0;
  }

  if(issubstr(var_5, "shovel")) {
    var_12 = 0;
  }

  if(maps\mp\zquests\zmb_secret_challenges_util::array_contains_subtring(level.berlin_melee_weapons, var_5)) {
    var_12 = 0;
  }

  if(var_12) {
    fail_berlin_trophy_event_6();
  }
}

set_players_have_fired_shot() {
  var_0 = self;
  var_1 = "wunderbuss";

  while(issubstr(var_1, "wunderbuss")) {
    var_0 waittill("weapon_fired", var_1);
  }

  fail_berlin_trophy_event_6();
}