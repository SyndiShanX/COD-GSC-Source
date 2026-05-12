/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\dlc2_secrets_mp_zombie_berlin.gsc
*************************************************************/

init_dlc2_secrets_mp_zombie_berlin() {
  level thread lib_0547::solo_challenge_safety_think();
  level.add_zombie_type_to_geistkraft_challenge = ::maps\mp\zquests\zmb_secret_challenges_util::add_zombie_type_to_geistkraft_challenge;
  level.trap_kill_trackers = [];
  level.callbackplayerdamagesecondaryhandling = ::maps\mp\zquests\zmb_secret_challenges_util::report_player_damaged;
  lib_0565::zombiegearchallengeregister("surgeon_set", [::surgeon_set_0, ::surgeon_set_1, ::surgeon_set_2, ::surgeon_set_3, ::surgeon_set_4], "surgeon_set_kill");
  lib_0565::zombiegearchallengeregister("rebel_set", [::rebel_set_0, ::rebel_set_1, ::rebel_set_2, ::rebel_set_3, ::rebel_set_4], "rebel_set_kill");
  lib_0565::zombiegearchallengeregister("super_soldier_set", [::super_soldier_set_0, ::super_soldier_set_1, ::super_soldier_set_2, ::super_soldier_set_3, ::super_soldier_set_4], "super_soldier_set_kill");
}

surgeon_set_0() {
  level waittill("drop_dlc2_char_a_0");
  return 1;
}

surgeon_set_1() {
  level waittill("drop_dlc2_char_a_1");
  return 1;
}

surgeon_set_2() {
  level waittill("drop_dlc2_char_a_2");
  return 1;
}

surgeon_set_3() {
  var_00 = spawnStruct();
  var_00.var_4800 = 25;
  var_00.trophyflag = "surgeon_set_3";
  var_00.var_6E5C = ["all_players_in_common_zone"];
  var_00.var_6E55 = ::maps\mp\zquests\zmb_secret_challenges_util::players_using_berlin_melee_weapons;
  var_00.param2 = ["zone_underbelly_start", "zone_club_interior", "zone_church_interior", "zone_museum_hall"];
  var_00.requiresteamwork = 1;
  maps\mp\zquests\zmb_secret_challenges_util::monitor_players_survival_in_zone(var_00);
  return 1;
}

surgeon_set_4() {
  var_00 = 75;
  var_01 = ["trap_zm_mp", "trap_bomber_prop", "trap_cage_blitz", "trap_tank"];
  level.trap_kill_trackers["surgeon_set_4"] = spawnStruct();
  level.trap_kill_trackers["surgeon_set_4"].trap_progress_tracker = [];
  level.trap_kill_trackers["surgeon_set_4"].valid_weapons = var_01;
  maps\mp\zquests\zmb_secret_challenges_util::register_zombie_killed_response(::maps\mp\zquests\zmb_secret_challenges_util::return_trap_name, ::maps\mp\zquests\zmb_secret_challenges_util::add_zombie_kill_to_trap_kill_array, undefined, "surgeon_set_4", var_01);
  maps\mp\zquests\zmb_secret_challenges_util::register_on_player_down_func(::maps\mp\zquests\zmb_secret_challenges_util::reset_trap_kill_array, "surgeon_set_4");
  foreach(var_03 in var_01) {
    level.trap_kill_trackers["surgeon_set_4"].trap_progress_tracker[var_03] = spawnStruct();
    level.trap_kill_trackers["surgeon_set_4"].trap_progress_tracker[var_03].var_109 = var_03;
    level.trap_kill_trackers["surgeon_set_4"].trap_progress_tracker[var_03].var_5C = 0;
  }

  while(!maps\mp\zquests\zmb_secret_challenges_util::all_traps_full(level.trap_kill_trackers["surgeon_set_4"], var_00)) {
    wait(0.5);
  }

  return 1;
}

rebel_set_0() {
  var_00 = "rebel_set_kill0";
  level endon(var_00);
  level thread maps\mp\zquests\zmb_secret_challenges_util::register_on_player_down_func(::maps\mp\zquests\zmb_secret_challenges_util::kill_hidden_challenge, var_00);
  common_scripts\utility::func_3C9F("berlin_cinematic_done");
  return 1;
}

rebel_set_1() {
  var_00 = "rebel_set_kill1";
  level endon(var_00);
  level thread maps\mp\zquests\zmb_secret_challenges_util::register_on_player_dmg_func(::maps\mp\zquests\zmb_secret_challenges_util::kill_hidden_challenge, var_00, ::maps\mp\zquests\zmb_secret_challenges_util::agent_is_zombie);
  maps\mp\zquests\zmb_secret_challenges_util::wait_for_round(30);
  return 1;
}

rebel_set_2() {
  var_00 = "rebel_set_kill2";
  level endon(var_00);
  level childthread maps\mp\zquests\zmb_secret_challenges_util::register_on_flag_set_func(::maps\mp\zquests\zmb_secret_challenges_util::kill_hidden_challenge, var_00, ["underbelly_to_underbelly_rubble", "underbelly_to_underbelly_intact"]);
  maps\mp\zquests\zmb_secret_challenges_util::wait_for_round(20);
  return 1;
}

rebel_set_3() {
  var_00 = self;
  var_01 = "rebel_set_kill3";
  level endon(var_01);
  level childthread maps\mp\zquests\zmb_secret_challenges_util::register_on_notify_set_func(::maps\mp\zquests\zmb_secret_challenges_util::kill_hidden_challenge, var_01, [level, "special_ability_used", var_00, level.zmb_events_purchase_notify + "_" + "perk_machine", level, level.zmb_events_consumables_notify]);
  maps\mp\zquests\zmb_secret_challenges_util::wait_for_round(30);
  return 1;
}

rebel_set_4() {
  var_00 = self;
  var_00 endon("disconnect");
  level.zmb_teamwork_required_challenges["rebel_set_4"] = 1;
  var_01 = var_00 maps\mp\zquests\zmb_secret_challenges_util::wait_for_required_zombie_kills(10, "rebel_set_4", [::maps\mp\zquests\zmb_secret_challenges_util::player_using_sniper_weapons], ["zombie_sizzler"], undefined, "rebel_set_4", ::maps\mp\zquests\zmb_secret_challenges_util::clear_player_zombie_progress_on_sizzler_no_headshot);
  return 1;
}

super_soldier_set_0() {
  var_00 = "super_soldier_set_kill0";
  level endon(var_00);
  level childthread maps\mp\zquests\zmb_secret_challenges_util::register_on_minute_reached_func(::maps\mp\zquests\zmb_secret_challenges_util::kill_hidden_challenge, var_00, 25);
  maps\mp\zquests\zmb_secret_challenges_util::wait_for_round(20);
  return 1;
}

super_soldier_set_1() {
  var_00 = "super_soldier_set_kill1";
  level endon(var_00);
  level childthread maps\mp\zquests\zmb_secret_challenges_util::register_on_minute_reached_func(::maps\mp\zquests\zmb_secret_challenges_util::kill_hidden_challenge, var_00, 35);
  common_scripts\utility::func_3C9F("berlin_cinematic_done");
  return 1;
}

super_soldier_set_2() {
  var_00 = self;
  var_01 = "super_soldier_set_kill2";
  level endon(var_01);
  level childthread maps\mp\zquests\zmb_secret_challenges_util::register_on_notify_set_func(::maps\mp\zquests\zmb_secret_challenges_util::kill_hidden_challenge, var_01, [var_00, level.zmb_events_purchase_notify + "_" + "perk_machine"]);
  common_scripts\utility::func_3C9F("berlin_cinematic_done");
  return 1;
}

super_soldier_set_3() {
  var_00 = spawnStruct();
  var_00.var_4800 = 15;
  var_00.trophyflag = "super_soldier_set_3";
  var_00.requiresteamwork = 1;
  childthread maps\mp\zquests\zmb_secret_challenges_util::reset_progress_when_off_stage("super_soldier_set_3");
  maps\mp\zquests\zmb_secret_challenges_util::monitor_players_survival_in_zone(var_00);
  return 1;
}

super_soldier_set_4() {
  var_00 = self;
  var_01 = "super_soldier_set_kill4";
  level endon(var_01);
  level childthread maps\mp\zquests\zmb_secret_challenges_util::register_on_minute_reached_func(::maps\mp\zquests\zmb_secret_challenges_util::kill_hidden_challenge, var_01, 8);
  maps\mp\zquests\zmb_secret_challenges_util::register_zombie_killed_response(::maps\mp\zquests\zmb_secret_challenges_util::enforce_zombie_headshots, undefined, ::maps\mp\zquests\zmb_secret_challenges_util::kill_hidden_challenge, "super_soldier_set_kill4");
  maps\mp\zquests\zmb_secret_challenges_util::wait_for_round(3);
  return 1;
}