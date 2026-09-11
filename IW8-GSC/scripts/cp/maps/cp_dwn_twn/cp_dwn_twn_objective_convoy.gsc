/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_objective_convoy.gsc
**********************************************************************/

function register_objectives_for_convoy() {
  level.convoy_obj_func = &register_objectives;
  thread wait_for_players_near_obj();
}

function wait_for_players_near_obj() {
  while(!isDefined(level.mission_select)) {
    wait 1;
  }

  level.mission_select endon("mission_selected");
  scripts\engine\utility::flag_init("start_convoy_mission");
  scripts\engine\utility::flag_wait("start_convoy_mission");

  for(;;) {
    if(istrue(level.event_active)) {
      wait 1;
      continue;
    }

    level.event_active = 1;
    thread spawn_convoy_and_drive();
    scripts\engine\utility::flag_wait("event_objective_convoy_1_completed");
    level.event_active = 0;
    return;
  }
}

function spawn_convoy_and_drive(var0) {
  level notify("event_started");
  wait 2;
  level.convoy_speed_override = 12;
  wait 0.1;
  thread first_intro_text();
  thread play_mission_end_vo();
  get_proto_convoy_event();
  wait 0.05;
  level thread scripts\cp\cp_objectives_events::try_start_event(level.convoy_proto_event, "scripts/cp/maps/cp_dwn_twn/cp_dwn_twn_objectives_events.csv", level.convoy_proto_index);
}

function register_objectives() {
  scripts\cp\cp_objectives::registerobjective("event_convoy_start", undefined, &spawn_convoy_and_drive, undefined, undefined);
}

function objective_convoy_init(var0) {
  wait 0.05;
}

function objective_convoy_start(var0) {
  var1 = 99999;
  run_convoy_roaming(var0, var1);
}

function run_convoy_roaming(var0, var1) {
  var2 = get_far_away_startpath();
  var2 = "convoy_start_" + var2;
  var2 = scripts\engine\utility::getStruct(var2, "targetname");
  var3 = get_proto_convoy_type();

  if(getDvar("scr_convoy_override", "") != "") {
    var3 = getDvar("scr_convoy_override", "");
  }

  objective_addteamtomask(var0.objectiveindex, "axis");
  thread play_searching_new_convoy_vo();
  var4 = level.convoy_proto_event;
  var5 = level scripts\cp\cp_convoy_manager::spawn_convoy_from_type(level.convoy_proto_event, var3, var2, var0, var1, var4);
  objective_addalltomask(var0.objectiveindex);
  var5 thread scripts\cp\cp_convoy_manager::set_objective_struct(var0);
  var5 thread scripts\cp\cp_convoy_manager::show_objective_icon(0);
  thread play_new_convoy_vo(var5);
  wait 2;
  var5 thread scripts\cp\cp_convoy_manager::set_roaming(1);
  var5 thread scripts\cp\cp_convoy_manager::set_unload_at_target(0);
  var5 thread scripts\cp\cp_convoy_manager::set_healthdrain_on_lowhealth(50);
  var5 thread scripts\cp\cp_convoy_manager::set_center_hull_invulnerable(1);
  thread wait_till_players_near_center(level);
  var5 thread scripts\cp\cp_convoy_manager::set_attach_objective_icon(1, 220);

  if(var3 == "small-roaming" || var3 == "small-danger-roaming") {
    var5 thread scripts\cp\cp_convoy_manager::attach_smuggler_loot("barrel", 4, 5);
    var5 thread scripts\cp\cp_convoy_manager::keep_smuggler_loot_on_death("barrel", 0, 0);
  } else if(var3 == "medium-roaming") {
    var5 thread scripts\cp\cp_convoy_manager::attach_smuggler_loot("barrel", 8, 8);
    var5 thread scripts\cp\cp_convoy_manager::keep_smuggler_loot_on_death("barrel", 0, 0);
  }

  var9 = var5 scripts\cp\cp_convoy_manager::get_smuggler_loot_amount(1);
  var10 = scripts\cp\cp_convoy_manager_code::get_nitrate_label(var9);
  var5 thread scripts\cp\cp_convoy_manager::show_objective_icon(1, 1);
  var5 thread scripts\cp\cp_convoy_manager::toggle_convoy_wheel_outlines(1);
  thread set_tires_desc(level, var5);
  var5 waittill("convoy_compromised");
  thread play_mark_barrel_vo(level);
  thread play_secure_barrel_vo(level);
  var5 thread scripts\cp\cp_convoy_manager::delay_kill_main_truck(31);
  var5 waittill("convoy_center_death");
  var5 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var5 thread scripts\cp\cp_convoy_manager::set_despawn_distance(3500);
  thread convoy_end_this_event(level, var5);
}

function reset_convoy_soon() {
  level waittill("new_convoy");
  thread spawn_convoy_and_drive();
}

function convoy_end_this_event(var0, var1) {
  level scripts\cp\cp_objectives_events::stop_event(var1);
  level notify("new_convoy");
}

function get_far_away_startpath() {
  var0 = scripts\engine\utility::getStruct("convoy_start_west1", "targetname");
  var1 = scripts\engine\utility::getStruct("convoy_start_east1", "targetname");
  var2 = scripts\engine\utility::getStruct("convoy_start_south1", "targetname");
  var3 = [];
  GscBinSkip0(0x2e, var3.size, var0);
}

function set_tires_desc(var0, var1) {
  var2 = 0;

  for(;;) {
    var3 = undefined;
    var4 = undefined;

    if(var2 == 0) {
      var3 = &"CP_CONVOYS/TIRES_0";
      var4 = "event_convoy_tires_0";
    } else if(var2 == 1) {
      var3 = &"CP_CONVOYS/TIRES_1";
      var4 = "event_convoy_tires_1";
    } else if(var2 == 2) {
      var3 = &"CP_CONVOYS/TIRES_2";
      var4 = "event_convoy_tires_2";
    } else if(var2 >= 3) {
      var3 = &"CP_CONVOYS/TIRES_3";
      var4 = "event_convoy_tires_3";
    }

    objective_setdescription(var1.objectiveindex, var3);
    scripts\cp\utility::objective_update(var4);

    if(var2 >= 3) {
      break;
    }

    var0 waittill("vehicle_lost_wheel");
    var2 += 1;
  }

  wait 1.5;
  var0 thread scripts\cp\cp_convoy_manager::compromise_center_truck();
  var4 = "event_convoy_nitrate";
  objective_setdescription(var1.objectiveindex, &"CP_CONVOYS/EXTRACT_NITRATE");
  scripts\cp\utility::objective_update(var4, 30, 29, 15);
}

function spawn_4player_car(var0) {
  scripts\cp\maps\cp_br_syrk\vehicle_travel::init();
  scripts\cp\maps\cp_br_syrk\cp_br_syrk_humvee::load_vfx();
  setDvar("cg_thirdPersonCarRange", 450);
  setDvar("cg_thirdPersonCarForward", 20);
  setDvar("cg_thirdPersonCarUp", 150);
  var1 = undefined;

  if(!isDefined(var1)) {
    var2 = scripts\engine\utility::getStruct("convoy_start_west1", "targetname");
    var1 = scripts\cp\utility::getcloseststruct(var2.origin, "humvee_spawner");
  }

  if(isDefined(var1)) {
    var3 = scripts\cp\maps\cp_br_syrk\vehicle_travel::get_humvee_info(var1);
    level thread scripts\cp\maps\cp_br_syrk\vehicle_travel::deploy_vehicle(var1, var3);
    return;
  }
}

function spawn_map_technicals() {
  var0 = scripts\engine\utility::getStructArray("convoy_technical_spawner", "targetname");
  level thread scripts\cp\vehicles\technical_cp::technical_cp_createfromstructs(var0, 3);
}

function get_proto_convoy_type() {
  if(!isDefined(level.convoy_proto_type)) {
    level.convoy_proto_type = 1;
  }

  if(level.convoy_proto_type == 1) {
    level.convoy_proto_type = 2;
    return "small-roaming";
  }

  if(level.convoy_proto_type == 2) {
    level.convoy_proto_type = 3;
    return "medium-roaming";
  }

  if(level.convoy_proto_type == 3) {
    level.convoy_proto_type = 1;
    return "small-danger-roaming";
  }
}

function get_proto_convoy_event() {
  if(!isDefined(level.convoy_proto_event)) {
    level.convoy_proto_event = "objective_convoy_1";
    level.convoy_proto_index = "1";
    return;
  }

  if(level.convoy_proto_event == "objective_convoy_1") {
    level.convoy_proto_event = "objective_convoy_2";
    level.convoy_proto_index = "2";
    return;
  }

  if(level.convoy_proto_event == "objective_convoy_2") {
    level.convoy_proto_event = "objective_convoy_3";
    level.convoy_proto_index = "3";
    return;
  }

  if(level.convoy_proto_event == "objective_convoy_3") {
    level.convoy_proto_event = "objective_convoy_1";
    level.convoy_proto_index = "1";
    return;
  }
}

function wait_till_players_near_center(var0) {
  var1 = 1680;
  var2 = var1 * var1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var0.main_truck.origin, var2)) {
      break;
    }

    wait 0.1;
  }

  thread play_shoot_tires_vo();
}

function play_vo_delay(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(var4)) {
    wait var4;
  }

  if(isDefined(var0)) {
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var0, "allies", var3, var5, var6);
  }

  if(isDefined(var1)) {
    wait var1;
  }

  if(isDefined(var2)) {
    level thread scripts\cp\utility::cp_add_dialogue_line(var2);
    return;
  }
}

function vo_length(var0) {
  var1 = lookupsoundlength(var0);
  var1 /= 1000;
  return var1;
}

function first_intro_text() {
  level endon("stop_intro_vo");

  if(!isDefined(level.convoy_proto_text)) {
    level.convoy_proto_text = 1;
  } else {
    return;
  }

  thread spawn_map_technicals();
  wait 4;
  thread play_intro_texts();
  thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_brief_10", undefined);
  wait vo_length("dx_cps_ovl_convoy_roam_brief_10");
  wait 0.2;
  thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_brief_20", undefined);
  wait vo_length("dx_cps_ovl_convoy_roam_brief_20");
  wait 0.2;
  thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_brief_30", undefined);
  wait vo_length("dx_cps_ovl_convoy_roam_brief_30");
  wait 0.2;
}

function play_intro_texts() {
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_CONVOYS/DIALOG_INTRO_01");
  wait vo_length("dx_cps_ovl_convoy_roam_brief_10");
  wait 0.2;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_CONVOYS/DIALOG_INTRO_02");
  wait vo_length("dx_cps_ovl_convoy_roam_brief_20") / 2;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_CONVOYS/DIALOG_INTRO_03");
  wait vo_length("dx_cps_ovl_convoy_roam_brief_20") / 2;
  wait 0.2;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_CONVOYS/DIALOG_INTRO_04");
}

function play_shoot_tires_vo() {
  level notify("stop_intro_vo");

  if(scripts\engine\utility::cointoss()) {
    thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_tires_shooting_10", undefined);
    return;
  }

  thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_tires_shooting_20", undefined);
}

function play_searching_new_convoy_vo() {
  if(isDefined(level.vo_skipped_first_location)) {
    thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_scanning_failure_10", undefined);
    return;
  }
}

function play_new_convoy_vo(var0) {
  if(!isDefined(level.vo_skipped_first_location)) {
    level.vo_skipped_first_location = 1;
    return;
  }

  foreach(var2 in level.players) {
    var3 = "dx_cps_ovl_convoy_roam_new_10";
    var4 = &"";
    var5 = scripts\cp\cp_battlechatter::getdirectioncompass(var2.origin, var0.main_truck.origin);

    switch (var5) {
      case "northeast":
      case "northwest":
      case "north":
        var3 = "dx_cps_ovl_convoy_roam_new_north_10";
        var4 = &"CP_CONVOYS/DIALOG_LOCATED_N";
        break;
      case "east":
        var3 = "dx_cps_ovl_convoy_roam_new_east_10";
        var4 = &"CP_CONVOYS/DIALOG_LOCATED_E";
        break;
      case "southeast":
      case "south":
      case "southwest":
        var3 = "dx_cps_ovl_convoy_roam_new_south_10";
        var4 = &"CP_CONVOYS/DIALOG_LOCATED_S";
        break;
      case "west":
        var3 = "dx_cps_ovl_convoy_roam_new_west_10";
        var4 = &"CP_CONVOYS/DIALOG_LOCATED_W";
        break;
      default:
        break;
    }

    level thread scripts\cp\cp_vo::try_to_play_vo_for_one_player(var3, var2);
    level thread scripts\cp\utility::cp_add_dialogue_line(var4);
  }
}

function play_mark_barrel_vo(var0) {
  level endon("game_ended");
  thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_loot_dropped_10", undefined);
  wait vo_length("dx_cps_ovl_convoy_roam_loot_dropped_10");
  wait 0.1;
  thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_scanning_barrels_40", undefined);
  wait 7;
  thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_scanning_barrels_10", undefined);
  wait 7;
  thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_scanning_barrels_20", undefined);
}

function play_secure_barrel_vo(var0) {
  level endon("game_ended");
  level endon("new_convoy_spawned");

  if(!isDefined(level.vo_collect_id)) {
    level.vo_collect_id = 1;
  }

  level waittill("convoy_loot_marked");

  if(isent(var0.main_truck)) {
    var0 waittill("convoy_center_death");
  }

  wait 2;

  if(level.vo_collect_id == 1) {
    level.vo_collect_id = 2;
    thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_scanning_complete_10", undefined);
    return;
  }

  if(level.vo_collect_id == 2) {
    level.vo_collect_id = 1;
    thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_scanning_complete_20", undefined);
    return;
  }
}

function play_mission_end_vo() {
  level endon("game_ended");

  if(istrue(level.vo_mission_end)) {
    return;
  }

  level.vo_mission_end = 1;
  level waittill("convoy_mission_complete");
  thread play_vo_delay(level, "dx_cps_ovl_convoy_roam_mission_complete_10", undefined);
}