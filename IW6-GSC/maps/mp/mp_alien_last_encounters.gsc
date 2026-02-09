/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_last_encounters.gsc
************************************************/

do_gas_station_blocker() {
  var_0 = gettime();
  wait 2;
  var_1 = ["last_gdf_ancestorpassing"];
  thread maps\mp\mp_alien_last::play_last_vignette_vo(var_1);
  var_2 = (-3332.5, 3723.5, 509.4);
  wait 1.0;
  level.ancestor_shield_up_override = 10;
  var_3 = common_scripts\utility::getstruct("ancestor_gas_station", "targetname");
  var_4 = maps\mp\agents\alien\alien_ancestor\_alien_ancestor::addancestoragent("axis", var_3.origin, level.players[0].angles);
  level thread gas_station_ancestor_logic(var_4);
  level thread gas_station_blocker_ancestor_leave(var_4);
  wait 1;
  level waittill("drill_detonated");
  level.ancestor_shield_up_override = undefined;
  common_scripts\utility::flag_set("outpost_gas_station_done");
  maps\mp\alien\_achievement_dlc4::update_progression_achievements("outpost_gas_station_done");
  give_blocker_awards();
}

gas_station_ancestor_logic(var_0) {
  var_0 endon("death");
  var_0 endon("ancestor_destroyed");
  var_1 = "traverse_down";
  var_2 = "traverse";
  var_3 = "end";
  var_4 = 0;
  wait 0.25;
  var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_jump_down_node");
  var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_play_traversal(var_0.angles, "traverse_down");
  var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("gas_station_attack_spot");
  var_0 maps\mp\alien\_utility::disable_alien_scripted();

  if(var_0 maps\mp\alien\_utility::ent_flag_exist("activate_shield_health_check"))
    var_0 maps\mp\alien\_utility::ent_flag_set("activate_shield_health_check");
}

gas_station_blocker_ancestor_leave(var_0) {
  var_0 endon("death");
  var_0 endon("ancestor_destroyed");
  level waittill("drill_detonated");
  var_1 = 1;

  while(var_1) {
    var_1 = 0;

    foreach(var_3 in level.players) {
      if(var_3.origin[0] < -750 && var_3.origin[1] > 400)
        var_1 = 1;
    }

    wait 0.25;
  }

  var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_gas_station_retreat_node");
  wait 0.1;

  if(isDefined(var_0) && isalive(var_0)) {
    var_0.killed_by_script = 1;
    remove_ancestor_healthbar(var_0);
    var_0 suicide();
    var_5 = undefined;
  }
}

gas_station_blocker_ai_func(var_0, var_1) {
  level endon("drill_detonated");
  var_2 = var_1 + 1;

  for(;;) {
    level waittill("dlc_vo_notify", var_3, var_4);

    if(var_3 == "last_vo" && var_4 == "conduit_halfway") {
      var_2 = gettime();
      break;
    }
  }

  setthreatbias("drill", "ancestors", 10000);
  setthreatbias("players", "ancestors", 10);
}

encounter_end_conduit_number_vo() {
  level endon("game_ended");
  var_0 = ["last_gdf_2conduitsup"];

  switch (level.num_conduit_completed) {
    case 1:
      level thread conduit_encounter_end_vo_1();
      break;
    case 2:
      level thread conduit_encounter_end_vo_2();
      break;
    case 3:
      level thread conduit_encounter_end_vo_3();
      break;
    case 4:
      level thread conduit_encounter_end_vo_4();
      break;
    case 5:
      level thread conduit_encounter_end_vo_5();
      break;
    case 6:
      level thread play_get_back_base_nag_vo();
      level thread conduit_encounter_end_vo_6();
      break;
    default:
      return;
  }
}

conduit_encounter_end_vo_1() {
  var_0 = ["last_gdf_fivetogo", "last_gdf_ancestorwarlords"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
}

conduit_encounter_end_vo_2() {
  level thread play_get_moving_to_conduit_nag_vo();
  var_0 = ["last_gdf_experimentalweapon", "last_gdf_powersource"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
}

conduit_encounter_end_vo_3() {
  var_0 = ["last_gdf_nosignofcross", "last_arc_playingyoufor"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
}

conduit_encounter_end_vo_4() {
  var_0 = ["last_gdf_last2generators", "last_arc_alljustpuppets", "last_gdf_notarcher"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
}

conduit_encounter_end_vo_5() {
  var_0 = ["last_gdf_windowabouttoclose"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
}

conduit_encounter_end_vo_6() {
  var_0 = ["last_gdf_runningoutof", "last_crs_wonthaveto", "last_gdf_whatgame", "last_arc_makebelieve"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
}

play_get_moving_to_conduit_nag_vo() {
  level endon("game_ended");
  level endon("stop_post_hive_vo");
  level endon("drill_planted");
  var_0 = 90;
  var_1 = 30;
  wait(var_0);
  var_2 = ["last_gdf_2conduitsup"];

  for(;;) {
    maps\mp\mp_alien_last::play_last_vignette_vo(var_2);
    wait(var_1);
    var_1 = var_1 + 10;
  }
}

play_get_back_base_nag_vo() {
  level endon("game_ended");
  level endon("stop_post_hive_vo");
  level endon("drill_planted");
  var_0 = 90;
  var_1 = 30;
  wait(var_0);
  var_2 = [];

  for(var_3 = ["last_gdf_attackingthebase", "last_gdf_returntobase"]; !common_scripts\utility::flag("start_cross_vignette"); var_1 = var_1 + 10) {
    var_4 = common_scripts\utility::random(var_3);
    var_2 = [var_4];
    maps\mp\mp_alien_last::play_last_vignette_vo(var_2);
    wait(var_1);
  }
}

do_garage_blocker() {
  level.ancestor_shield_up_override = 10;
  var_0 = common_scripts\utility::getstruct("ancestor_parking_1", "targetname");
  var_1 = maps\mp\agents\alien\alien_ancestor\_alien_ancestor::addancestoragent("axis", var_0.origin, level.players[0].angles);
  wait 0.5;
  var_2 = getnode("ancestor_garage_start_01", "targetname");

  if(level.current_hive_name == "conduit_parking_1")
    var_2 = getnode("ancestor_garage_start_02", "targetname");

  var_1 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::assign_path_node(var_2);
  wait 1.0;

  if(isalive(var_1) && var_1 maps\mp\alien\_utility::ent_flag_exist("activate_shield_health_check"))
    var_1 maps\mp\alien\_utility::ent_flag_set("activate_shield_health_check");

  var_3 = ["last_gdf_spottedanancestor"];
  thread maps\mp\mp_alien_last::play_last_vignette_vo(var_3);
  level thread ancestor_attack_conduits(var_1);
  level thread ancestor_run_away(var_1, var_0);
  level waittill("drill_detonated");
  level.ancestor_shield_up_override = undefined;
  common_scripts\utility::flag_set("outpost_garage_done");
  maps\mp\alien\_achievement_dlc4::update_progression_achievements("outpost_garage_done");
  give_blocker_awards();
}

ancestor_attack_conduits(var_0) {
  level endon("drill_detonated");
  var_0 endon("death");
  wait 15;
  var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();

  if(level.current_hive_name == "conduit_parking_1")
    var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_garage_attack_02");
  else
    var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_garage_attack_01");

  wait 0.1;
  var_1 = level.current_encounter_info.conduit;

  for(;;) {
    var_0 thread maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::force_blast_attack(var_1.origin);
    var_0 maps\mp\alien\_utility::disable_alien_scripted();
    wait 15;
    var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  }
}

ancestor_run_away(var_0, var_1) {
  var_0 endon("death");
  level waittill("drill_detonated");

  if(isDefined(var_0) && isalive(var_0)) {
    var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
    var_2 = getnode("ancestor_retreat_node", "targetname");

    if(isDefined(var_2))
      var_0 maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_retreat_node");
  }

  common_scripts\utility::waitframe();

  if(isDefined(var_0) && isalive(var_0)) {
    var_0.killed_by_script = 1;
    remove_ancestor_healthbar(var_0);
    var_0 suicide();
    var_1 = undefined;
  }
}

do_rooftops_blocker() {
  level waittill("drill_detonated");
  common_scripts\utility::flag_set("outpost_rooftops_done");
  maps\mp\alien\_achievement_dlc4::update_progression_achievements("outpost_rooftops_done");
  give_blocker_awards();
}

give_blocker_awards() {
  foreach(var_1 in level.players)
  var_1 maps\mp\alien\_persistence::try_award_bonus_pool_token();
}

spawn_proto_ancestor() {
  var_0 = getent("temp_spawn_ancestor", "targetname");
  var_0 waittill("trigger");
  setDvar("scr_debug_ancestor_spawn", 1);
}

jump_to_gas_station() {}

jump_to_parking() {}

jump_to_rooftop() {}

remove_ancestor_healthbar(var_0) {
  if(isDefined(var_0.entityheadicons)) {
    foreach(var_2 in var_0.entityheadicons) {
      if(!isDefined(var_2)) {
        continue;
      }
      var_2 destroy();
    }
  }
}