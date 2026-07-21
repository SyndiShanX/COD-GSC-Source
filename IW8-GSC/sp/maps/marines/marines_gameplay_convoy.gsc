/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_gameplay_convoy.gsc
*******************************************************/

convoy_init() {
  scripts\engine\utility::flag_init("intro_skipped");
  scripts\engine\utility::flag_init("flag_clear_griggs_demeanor");
  scripts\engine\utility::flag_init("sledge_left_initial_moving");
  scripts\engine\utility::flag_init("sledge_right_initial_moving");
  scripts\engine\utility::flag_init("a10_flyby_trigger");
  scripts\engine\utility::flag_init("convoy_speed_up");
  scripts\engine\utility::flag_init("marines_advance_group_a");
  scripts\engine\utility::flag_init("play_IED_explosion");
  scripts\engine\utility::flag_init("door_kick_vignette_flag");
  scripts\engine\utility::flag_init("convoy_commence");
  scripts\engine\utility::flag_init("ied_vehicle_commence");
  scripts\engine\utility::flag_init("players_vehicle_commence");
  scripts\engine\utility::flag_init("tripwire_hint_flag");
  scripts\engine\utility::flag_init("tripwire_cleared_flag");
  scripts\engine\utility::flag_init("play_intro_convoy_driveby");
  scripts\engine\utility::flag_init("assault_vehicle_halt");
  scripts\engine\utility::flag_init("ied_vehicle_halt");
  scripts\engine\utility::flag_init("player_vehicle_halt");
  scripts\engine\utility::flag_init("intro_first_stop");
  scripts\engine\utility::flag_init("a10_first_stop_1");
  scripts\engine\utility::flag_init("a10_first_stop_2");
  scripts\engine\utility::flag_init("sledge_complete");
  scripts\engine\utility::flag_init("play_sledge_dialogue");
  scripts\engine\utility::flag_init("intro_cinematic_complete");
  scripts\engine\utility::flag_init("player_is_looking_at_IED");
  scripts\engine\utility::flag_init("wait_for_IED_explosion");
  scripts\engine\utility::flag_init("APC_volume_1_delete");
  scripts\engine\utility::flag_init("APC_volume_2_delete");
  scripts\engine\utility::flag_init("vo_flag_tripwire_approach");
  scripts\engine\utility::flag_init("vo_flag_convoy_rush");
  scripts\engine\utility::flag_init("flag_vo_alex_discovered_tripwires");
  scripts\engine\utility::flag_init("griggs_vo_line_spoken");
}

intro_main() {
  level.player setclienttriggeraudiozone("fade_to_black", 0.05);
  thread intro_helicopter_flyby();
  thread griggs_loadout();
  thread player_slamzoom();
  scripts\sp\maps\marines\marines_utility.gsc::deletables_thread();
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_intro_marine_oorah_dialogue();
  thread scripts\sp\maps\marines\marines_vo.gsc::mus_infil();
  level.player scripts\engine\utility::delaycall(0.15, ::setclienttriggeraudiozone, "fade_to_black_minus_scripted5_music_and_dx", 1.1);
  level.player scripts\engine\utility::delaycall(6.0, ::clearclienttriggeraudiozone, 3.0);
}

intro_start() {
  scripts\engine\sp\utility::set_start_location("start_intro", [level.player]);
  precachemodel("misc_wm_sledgehammer_scaled");
  precachemodel("cp_disco_chainlink_fence");
  scripts\engine\sp\utility::battlechatter_off("axis");
  scripts\engine\sp\utility::battlechatter_off("allies");
  level.griggs = scripts\sp\maps\marines\marines_utility.gsc::setup_named_ai("griggs", "Sgt. Griggs", "start_intro_griggs", undefined, undefined, undefined, "Demon 1-2");
  thread intro_ents_add(level.griggs);
  scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_convoy_journey");
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::disable_retreat_exterior_triggers();
  thread griggs_movement_handler(1);
  thread intro_street_marine_group_a_advance_scene(1);
  thread intro_street_marine_group_b_advance_scene(1);
  thread intro_street_marine_group_c_advance_scene(1);
  thread scripts\sp\maps\marines\marines_manpile_monitor.gsc::manpile_monitor();
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::mh_house_exit_door_blocker_block_path();
  thread vig_sledgebreach(1);
}

intro_catchup() {
  thread griggs_loadout();
  thread scripts\sp\maps\marines\marines_manpile_monitor.gsc::manpile_monitor();
  scripts\sp\maps\marines\marines_utility.gsc::deletables_thread();
  var_0 = getEntArray("hospital_intro", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);

  scripts\engine\utility::flag_set("intro_cinematic_complete");
  thread scripts\sp\maps\marines\marines_utility.gsc::griggs_damage_juggle_monitor();
}

convoy_ambush_main() {
  thread scripts\sp\maps\marines\marines_utility.gsc::transient_waittill("convoy_speed_up", undefined, "marines_parkinglot_geo_tr");
  thread scripts\sp\maps\marines\marines_utility.gsc::transient_waittill("flag_clear_griggs_demeanor", "marines_hospital_geo_tr", ["marines_introhack_geo_tr", "marines_hospital_fake_geo_tr"]);
  thread activate_sledge_lookin_dialogue();
  thread scripts\sp\maps\marines\marines_utility.gsc::add_volumes_to_array();
  thread a10_flyby();
  thread convoy_intro_marine_anim();
  thread convoy_runners();
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::disable_retreat_exterior_triggers();
  thread intro_convoy_vfx();
  thread intro_phone_peek();
  thread intro_roof_peek();
  thread bridge_overseer_handler();
  thread scripts\sp\maps\marines\marines_utility.gsc::player_wander_fail_manager();
  thread scripts\sp\maps\marines\marines_utility.gsc::player_wander_nag_manager();
  thread setup_assault_vehicle();
  thread tripwire_hint();
  thread vig_injuredmarine();
  thread vig_roof_peek();
  thread vig_window_peek_spawner();
  thread overhead_heli_flyby();
  thread convoy_location_dialogue();
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_convoy_viper_arriving_dialogue();
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_intro_nag_manager_1();
  wait 0.5;
  level.starting_marines = getaiarray("allies");

  foreach(var_1 in level.starting_marines) {
    if(isalive(var_1) && isDefined(var_1.asmname)) {
      var_1 scripts\common\utility::demeanor_override("cqb");
      var_1.ignoreplayersuppressionlines = 1;
    }
  }

  scripts\engine\utility::flag_wait("a10_flyby_trigger");
  thread assault_vehicle_spawner();
  thread convoy_movement_handler();
  thread enable_a10_wait_flags();
  thread ied_vehicle_spawner();
  thread player_vehicle_spawner();
  scripts\sp\spawner::killspawner(0);
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_pre_IED");
  scripts\engine\utility::flag_wait("tripwire_hint_flag");
  thread convoy_ambush_explosion();
  thread explosion_monitor();
  thread convoy_vehicle_passenger_handler();
  scripts\engine\utility::flag_wait("play_IED_explosion");
  var_3 = getaiarray("allies");

  foreach(var_1 in var_3) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_1.ignoreplayersuppressionlines = 0;
      var_1.disableplayeradsloscheck = 0;
    }
  }

  setsaveddvar("TLOLRMSL", 0.01);
  level.player scripts\engine\sp\utility::blend_movespeedscale_default(1);
  scripts\sp\player::player_movement_state("default");
  thread street_patch_handler();

  foreach(var_1 in level.starting_marines) {
    if(isDefined(var_1))
      var_1 thread scripts\anim\combat_utility.gsc::flashbangstart(randomfloatrange(0.75, 1.25));

    if(isDefined(var_1))
      var_1 scripts\engine\utility::set_movement_speed(100);
  }

  scripts\engine\utility::flag_set("postfx_ied_explosion");
  wait 1.0;
}

audio_vehicle_print3d_monitor() {
  for(;;) {
    var_0 = getEntArray("script_vehicle", "code_classname");

    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        var_3 = "";

        if(isDefined(var_2.unique_id))
          var_3 = var_3 + (" unique_id: " + var_2.unique_id);

        if(isDefined(var_2.targetname))
          var_3 = var_3 + (" targetname: " + var_2.targetname);

        if(isDefined(var_2.script_noteworthy))
          var_3 = var_3 + (" script_noteworthy: " + var_2.script_noteworthy);

        if(isDefined(var_2.vehicleanimalias))
          var_3 = var_3 + (" animalias: " + var_2.vehicleanimalias);
      }
    }

    waitframe();
  }
}

convoy_ambush_start() {
  scripts\engine\sp\utility::set_start_location("start_convoy_ambush", [level.player]);
  var_0 = getEnt("introTruck", "targetname");
  precachemodel("misc_wm_sledgehammer_scaled");
  precachemodel("cp_disco_chainlink_fence");
  scripts\engine\sp\utility::battlechatter_off("axis");
  scripts\engine\sp\utility::battlechatter_off("allies");
  level.griggs = scripts\sp\maps\marines\marines_utility.gsc::setup_named_ai("griggs", "Sgt. Griggs", "start_convoy_ambush_griggs", undefined, undefined, undefined, "Demon 1-2");
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_convoy_journey");
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::disable_retreat_exterior_triggers();
  thread griggs_movement_handler(0);
  thread intro_street_marine_group_a_advance_scene(0);
  thread intro_street_marine_group_b_advance_scene(0);
  thread intro_street_marine_group_c_advance_scene(0);
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::mh_house_exit_door_blocker_block_path();
  thread vig_sledgebreach(0);
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_convoy_griggs_move_out_dialogue();
  thread scripts\sp\maps\marines\marines_background.gsc::air_vehicles_distant();
  scripts\engine\utility::flag_set("marines_advance_group_a");
  var_0 delete();
  scripts\sp\player::player_movement_state("cqb");
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.9, 0.5);
}

convoy_ambush_catchup() {
  var_0 = getEnt("introTruck", "targetname");
  thread scripts\sp\maps\marines\marines_utility.gsc::add_volumes_to_array();
  thread scripts\sp\maps\marines\marines_utility.gsc::player_wander_fail_manager();
  thread scripts\sp\maps\marines\marines_utility.gsc::player_wander_nag_manager();
  thread street_patch_handler();
  scripts\engine\utility::flag_set("convoy_speed_up");
  var_0 delete();
  setsaveddvar("TLOLRMSL", 0.01);
}

intro_street_marine_group_a_advance_scene(var_0) {
  var_1 = getEnt("purple_initial_lookup_origin", "targetname");
  var_2 = getnode("purple_lookup_starting_node", "targetname");
  var_3 = getnode("purple_lookaround_node", "targetname");
  var_4 = getnode("purple_gesture_node", "targetname");
  var_5 = scripts\engine\utility::getStruct("purple_continue_poi_struct", "targetname");
  var_6 = getnode("intro_middle_purple_node", "targetname");
  var_7 = scripts\engine\utility::getStruct("purple_POI_at_car", "targetname");
  var_8 = [];

  while(var_8.size < 3) {
    var_8 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("p");
    waitframe();
  }

  foreach(var_10 in var_8) {
    if(isDefined(var_10) && isalive(var_10)) {
      if(scripts\engine\utility::is_equal(var_2, var_10.node))
        var_10 thread scripts\common\ai::poi_enable(1, var_7);
    }
  }

  foreach(var_10 in var_8) {
    if(isDefined(var_10) && isalive(var_10)) {
      if(isDefined(var_10.animname) && var_10.animname == "marine01")
        var_10 setgoalnode(var_4);
    }
  }

  scripts\engine\utility::flag_wait("marines_advance_group_a");
  wait 1;

  foreach(var_10 in var_8) {
    if(isDefined(var_10) && isalive(var_10)) {
      if(scripts\engine\utility::is_equal(var_4, var_10.node))
        var_10 scripts\asm\gesture::ai_request_gesture("advance");
    }
  }

  level notify("clear_fake_target");
  var_16 = 0;

  foreach(var_10 in var_8) {
    wait 1.0;
    var_18 = scripts\engine\utility::getStruct("purple_goto_struct_0", "targetname");
    var_19 = scripts\engine\utility::getStruct("purple_poi_struct_0", "targetname");

    if(isDefined(var_10) && isalive(var_10)) {
      if(scripts\engine\utility::is_equal(var_4, var_10.node)) {
        var_10 thread scripts\common\ai::poi_enable(1, var_19);
        var_10 thread scripts\sp\spawner::go_to_node(var_18);
      }
    }
  }

  foreach(var_10 in var_8) {
    var_22 = scripts\engine\utility::getStruct("purple_goto_struct_1", "targetname");
    var_23 = scripts\engine\utility::getStruct("purple_poi_struct_1", "targetname");

    if(isDefined(var_10) && isalive(var_10)) {
      if(scripts\engine\utility::is_equal(var_6, var_10.node)) {
        var_10 thread scripts\common\ai::poi_enable(1, var_23);
        var_10 thread scripts\sp\spawner::go_to_node(var_22);
      }
    }
  }

  foreach(var_10 in var_8) {
    wait 0.5;
    var_26 = scripts\engine\utility::getStruct("purple_goto_struct_2", "targetname");
    var_27 = scripts\engine\utility::getStruct("purple_poi_struct_2", "targetname");

    if(isDefined(var_10) && isalive(var_10)) {
      if(scripts\engine\utility::is_equal(var_2, var_10.node)) {
        var_10 thread scripts\common\ai::poi_enable(0);
        var_10 thread scripts\sp\spawner::go_to_node(var_26);
      }
    }
  }

  var_29 = 0;

  foreach(var_10 in var_8) {
    var_31 = scripts\engine\utility::getStruct("final_purple_poi_" + var_29, "targetname");

    if(isDefined(var_10) && isalive(var_10)) {
      if(scripts\engine\utility::is_equal(var_3, var_10.node))
        var_10 thread scripts\sp\maps\marines\marines_utility.gsc::delay_poi_enable(4, 1, var_5);
      else
        var_10 scripts\asm\shared\utility::toggle_poiauto(1, -20, 50, 10, 20);

      var_29++;
    }
  }
}

intro_street_marine_group_b_advance_scene(var_0) {
  wait 1;
  var_1 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("r");
  var_2 = 0;

  if(var_0) {
    scripts\engine\utility::flag_wait("intro_cinematic_complete");

    foreach(var_4 in var_1) {
      var_4 thread red_marine_lookat_target();
      var_4 thread intro_marine_poi_handler("intro_marine_poi_trigger_", "red_POI_struct_", "red_POI_origin_");
      var_4 thread support_marine_ied_street_stayahead_behavior();
      var_5 = scripts\engine\utility::getStruct("red_goto_struct", "targetname");

      if(isDefined(var_4) && isalive(var_4))
        var_4 thread scripts\sp\spawner::go_to_node(var_5);
    }

    scripts\engine\utility::flag_wait("marines_advance_group_a");
    wait 4;
  }

  foreach(var_4 in var_1) {
    var_8 = scripts\engine\utility::getStruct("red_continue_struct", "targetname");

    if(isDefined(var_4) && isalive(var_4))
      var_4 thread scripts\sp\spawner::go_to_node(var_8);

    wait 0.5;
  }

  scripts\engine\utility::flag_wait("marines_advance_group_b");
  wait 0.5;
  var_10 = scripts\engine\utility::getStruct("red_final_goto_struct", "targetname");

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && isalive(var_4))
      var_4 thread scripts\sp\spawner::go_to_node(var_10);
  }

  scripts\engine\sp\utility::trigger_wait_targetname("convoy_dialogue_trigger");

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && isalive(var_4))
      var_4 thread scripts\common\ai::poi_enable(0);
  }
}

intro_street_marine_group_c_advance_scene(var_0) {
  wait 1;
  var_1 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("y");
  var_2 = 0;

  if(var_0) {
    scripts\engine\utility::flag_wait("intro_cinematic_complete");

    foreach(var_4 in var_1) {
      var_4 thread intro_marine_poi_handler("intro_marine_poi_trigger_", "yellow_POI_struct_", "yellow_POI_origin_");
      var_4 thread support_marine_ied_street_stayahead_behavior();
      var_5 = scripts\engine\utility::getStruct("yellow_goto_struct", "targetname");

      if(isDefined(var_4) && isalive(var_4)) {
        var_4 thread scripts\sp\spawner::go_to_node(var_5);
        var_4 thread yellow_path_makeup();
        var_4 thread yellow_guy_look_up();
      }
    }

    scripts\engine\utility::flag_wait("marines_advance_group_a");
    wait 5;
  }

  foreach(var_4 in var_1) {
    var_8 = scripts\engine\utility::getStruct("yellow_continue_struct", "targetname");

    if(isDefined(var_4) && isalive(var_4))
      var_4 thread scripts\sp\spawner::go_to_node(var_8);

    wait 0.5;
  }

  scripts\engine\utility::flag_wait("marines_advance_group_b");
  wait 0.5;
  var_10 = scripts\engine\utility::getStruct("yellow_final_goto_struct", "targetname");
  wait 1;

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && isalive(var_4))
      var_4 thread scripts\sp\spawner::go_to_node(var_10);
  }
}

intro_marine_poi_handler(var_0, var_1, var_2) {
  self endon("death");
  scripts\engine\utility::flag_wait("intro_cinematic_complete");
  var_3 = 1;

  while(var_3 < 7) {
    var_4 = getEnt(var_0 + var_3, "targetname");
    var_5 = scripts\engine\utility::getStruct(var_1 + var_3, "targetname");
    var_6 = getEnt(var_2 + var_3, "targetname");

    for(;;) {
      if(isDefined(self) && isalive(self)) {
        if(ispointinvolume(self.origin, var_4)) {
          if(isDefined(var_5))
            scripts\common\ai::poi_enable(1, var_5);

          var_3++;
          break;
        }
      }

      waitframe();
    }
  }
}

yellow_path_makeup() {
  var_0 = getnode("marines_r_first_stop", "targetname");
  var_1 = getnode("griggs_goto_node_1", "targetname");
  scripts\engine\utility::flag_wait("intro_first_stop_2");
  wait 2;

  if(!scripts\engine\utility::flag("marines_advance_group_a")) {
    if(isDefined(self))
      self setgoalnode(var_1);
  }
}

griggs_movement_handler(var_0) {
  while(!isDefined(level.griggs))
    waitframe();

  level.griggs scripts\asm\shared\utility::toggle_poiauto(1, 10, 20, 10, 20);

  if(var_0) {
    scripts\engine\utility::flag_wait("flag_clear_griggs_demeanor");
    var_1 = scripts\engine\utility::getStruct("griggs_goto_struct_1", "targetname");
    var_2 = scripts\engine\utility::getStruct("poi_struct_2", "targetname");
    var_3 = scripts\engine\utility::getStruct("poi_struct_1", "targetname");
    level.griggs scripts\asm\gesture::ai_request_gesture("advance");
    level.griggs aisetdesiredspeed(120);
    level.griggs scripts\common\ai::set_gunpose("gun_down");
    level.griggs thread scripts\sp\spawner::go_to_node(var_1);
    wait 3;
    level.griggs thread scripts\common\ai::poi_enable(1, var_3);
    level.griggs thread waitill_path_end_watcher();
    scripts\engine\utility::flag_wait("marines_advance_group_a");
    level.griggs thread griggs_ied_street_stayahead_behavior();
    wait 3.5;
  }

  var_4 = scripts\engine\utility::getStruct("griggs_continue_struct_1", "targetname");
  var_5 = scripts\engine\utility::getStruct("poi_struct_4", "targetname");
  level.griggs thread scripts\common\ai::poi_enable(1, var_5);
  level.griggs thread scripts\sp\spawner::go_to_node(var_4);
  scripts\engine\utility::flag_wait("marines_advance_group_b");

  foreach(var_7 in level.starting_marines)
  var_7 notify("stop_going_to_node");

  waitframe();
  var_9 = scripts\engine\utility::getStruct("griggs_final_struct", "targetname");
  var_10 = getnode("griggs_gesture_node", "targetname");
  var_11 = scripts\engine\utility::getStruct("point_target", "targetname");
  level.griggs thread scripts\sp\spawner::go_to_node(var_9);
  level.griggs.script_radius = "1";
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_convoy_alex_tripwire_callout_dialogue();
  level.griggs waittill("reached_path_end");
  thread tripwire_hint_dialogue();
  scripts\engine\utility::flag_wait("tripwire_hint_flag");
  level.griggs thread scripts\asm\gesture::ai_request_gesture("hold");
}

griggs_ied_street_stayahead_behavior() {
  self endon("death");
  wait 0.5;
  scripts\sp\utility::set_stayahead_values(1, 120, -50, 0.1);
  scripts\sp\utility::set_stayahead_values(2, 110, -150, 0.1);
  scripts\sp\utility::set_stayahead_values(3, 100, -200, 0.1);
  scripts\sp\utility::set_stayahead_values(4, 90, -250, 0.25);
  scripts\sp\utility::enable_stayahead(level.player);
  scripts\engine\utility::flag_wait("play_IED_explosion");
  scripts\sp\utility::disable_stayahead();
}

support_marine_ied_street_stayahead_behavior() {
  self endon("death");
  self aisetdesiredspeed(140);
  scripts\engine\utility::flag_wait("marines_advance_group_a");
  scripts\sp\utility::set_stayahead_values(1, 105, -50, 0.2);
  scripts\sp\utility::set_stayahead_values(2, 95, -150, 0.1);
  scripts\sp\utility::set_stayahead_values(3, 85, -200, 0.1);
  scripts\sp\utility::set_stayahead_values(4, 80, -250, 0.25);
  scripts\sp\utility::enable_stayahead(level.player);
  scripts\engine\utility::flag_wait("play_IED_explosion");
  scripts\sp\utility::disable_stayahead();
}

a10_flyby() {
  var_0 = getEnt("a10_explosion_trigger", "targetname");
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("a10_flyby_trigger");
  var_1 = scripts\engine\utility::getStruct("ambient_explosion_1", "targetname");
  var_2 = scripts\engine\utility::getStruct("ambient_explosion_2", "targetname");
  var_3 = scripts\engine\utility::getStruct("ambient_explosion_3", "targetname");

  if(scripts\engine\utility::flag("a10_flyby_trigger")) {
    var_4 = getEnt("a10_tracer_start", "targetname");
    var_5 = getEntArray(var_4.target, "targetname");
    var_6 = scripts\engine\utility::random(var_5);
    thread scripts\engine\utility::play_sound_in_space("scn_marines_a10_strike", var_2.origin);
    var_4 thread scripts\sp\maps\marines\marines_background.gsc::bg_aa_fire_tracer_fx(var_6);
    scripts\sp\maps\marines\marines_utility.gsc::marine_airstrike_group("convoy_airstrike_group", 0, 0, 0);
    wait 1;
    scripts\engine\utility::exploder("a10_flyby_explosions");
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_convoy_a10_flyby_react_dialogue();
    earthquake(0.5, 1, level.player.origin, 100);
    level.player playRumbleOnEntity("grenade_rumble");
    wait 0.25;
    earthquake(0.5, 1, level.player.origin, 100);
    level.player playRumbleOnEntity("grenade_rumble");
    wait 0.25;
    earthquake(0.5, 1, level.player.origin, 100);
    level.player playRumbleOnEntity("grenade_rumble");
    wait 1.5;
    scripts\engine\utility::flag_clear("a10_flyby_trigger");
  }

  scripts\sp\maps\marines\marines_utility.gsc::autosave();
}

intro_helicopter_flyby() {
  scripts\engine\sp\utility::array_spawn_function_targetname("intro_helicopter", ::intro_helicopter_init);
  scripts\common\vehicle::spawn_vehicles_from_targetname_and_drive("intro_helicopter");
}

intro_helicopter_init() {
  self.mainturret delete();
  scripts\common\vehicle::vehicle_lights_off("running");
}

player_slamzoom() {
  thread scripts\sp\maps\marines\marines_lighting.gsc::flycam_intro_start();
  thread intro_camera_handler();
  thread intro_dialogue_handler();
  thread intro_driver_handler();
  thread intro_farah_handler();
  thread intro_gate_handler();
  thread intro_gateguy_handler();
  thread intro_griggs_handler();
  thread intro_hadir_handler();
  thread intro_marine01_handler();
  thread intro_marine02_handler();
  thread intro_marine03_handler();
  thread intro_truck_handler();
  thread alex_loadout();
  scripts\engine\sp\utility::activate_trigger("city_streets_start", "targetname");
  scripts\sp\maps\marines\marines_utility.gsc::autosave();
}

griggs_loadout() {
  while(!isDefined(level.griggs))
    waitframe();

  var_0 = scripts\sp\utility::make_weapon("iw8_ar_mike4");
  level.griggs scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
  thread scripts\sp\maps\marines\marines_utility.gsc::griggs_damage_juggle_monitor();
}

alex_loadout() {
  scripts\sp\player::player_movement_state("cqb");
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.9, 0);
  level.player takeallweapons();
  var_0[0] = scripts\sp\utility::make_weapon("iw8_ar_mike4", ["acog_west01_irons", "ub_mike203_sp"]);
  var_0[1] = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
  var_1 = var_0[0];
  level.player giveweapon(level.secondaryweapon);
  level.player giveweapon(level.primaryweapon, 0, 0, 0, 1);
  level.player switchtoweaponimmediate(level.primaryweapon);
  level.player scripts\engine\sp\utility::give_offhand("frag", 4);
  level.player scripts\engine\sp\utility::give_offhand("smoke_tall", 4);
  level.player givemaxammo(level.player getweaponslistprimaries()[0]);
  level.player givemaxammo(level.player getweaponslistprimaries()[1]);
  level.sprint_disabled = 0;
  var_2 = getEnt("intro_gate_safe_player_clip", "targetname");
  scripts\engine\utility::flag_wait("intro_cinematic_complete");
  var_3 = getEnt("disable_sprint_at_gate", "targetname");
  thread intro_gate_disable_sprint();
  wait 6;
  var_2 delete();
  level notify("disable_sprint_volume");

  if(isDefined(var_3))
    var_3 scripts\engine\utility::trigger_off();

  if(level.sprint_disabled == 1) {
    level.player scripts\common\utility::allow_sprint(1);
    level.sprint_disabled = undefined;
  }
}

convoy_ambush_explosion() {
  var_0 = scripts\engine\utility::getStruct("convoy_ambush_ied_explosion", "targetname");
  var_1 = "iw8_ges_frag_block";
  var_2 = cos(90);
  var_3 = getEnt("destroyed_apc", "targetname");
  var_4 = getEnt("player_explosion_radius", "targetname");
  scripts\engine\utility::flag_wait_any("wait_for_IED_explosion", "play_IED_explosion");
  scripts\engine\utility::flag_wait_any_timeout(1.5, "player_is_looking_at_IED", "play_IED_explosion");
  scripts\engine\utility::flag_set("play_IED_explosion");
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var_5 = scripts\engine\utility::getStruct("convoy_vehicle_fire", "targetname");
  playFX(level._effect["vfx_car_bomb_fire"], var_5.origin - (0, 0, 100));
  level.assault_vehicle delete();
  var_6 = getaiarray("allies");

  foreach(var_8 in var_6) {
    if(isalive(var_8) && isDefined(var_8.asmname))
      var_8 scripts\common\utility::demeanor_override("combat");
  }

  if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_2)) {
    if(isalive(level.player)) {
      level.player forceplaygestureviewmodel(var_1, undefined, 0.05, 0, 1);
      level.player thread scripts\sp\maps\marines\marines_utility.gsc::disable_weapon_swap(4);
    }
  }

  if(level.player istouching(var_4)) {
    playFX(level._effect["vfx_ied_explosion_no_rocks"], var_0.origin);
    thread sfx_ied_expl(var_0.origin);
    earthquake(1, 1, level.player.origin, 100);
    level.player playRumbleOnEntity("grenade_rumble");
    level.player scripts\sp\utility::do_damage(9999, level.player.origin, undefined, undefined);
  } else {
    playFX(level._effect["vfx_ied_explosion_no_rocks"], var_0.origin);
    thread sfx_ied_expl(var_0.origin);
    earthquake(0.75, 1, level.player.origin, 100);
    level.player playRumbleOnEntity("grenade_rumble");
    level.player shellshock("default", 4);
  }

  wait 1.0;
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_murderhole_griggs_ied_dialogue();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

sfx_ied_expl(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playexplosionsound("claymore_expl_trans", "exp");
  wait 10;
  var_1 delete();
}

convoy_movement_handler() {
  scripts\engine\utility::flag_wait("convoy_speed_up");
  wait 1;
  scripts\engine\utility::flag_set("convoy_commence");
  wait 2;
  scripts\engine\utility::flag_set("ied_vehicle_commence");
  wait 1.5;
  scripts\engine\utility::flag_set("players_vehicle_commence");
}

vig_window_peek_spawner() {
  wait 5;
  var_0 = getEntArray("vig_windowpeek_spawner", "targetname");

  foreach(var_2 in var_0) {
    var_2 scripts\engine\sp\utility::add_spawn_function(::vig_window_peek);
    var_2 scripts\engine\sp\utility::spawn_ai(1);
  }
}

vig_window_peek() {
  scripts\engine\sp\utility::set_allowdeath(1);
  self endon("death");
  self.whichone = randomint(3);

  if(isDefined(scripts\engine\utility::getStruct(scripts\engine\utility::getStruct(self.target, "targetname").target, "targetname").target))
    self.whichone = randomint(2) + 1;

  if(self.whichone == 0)
    self.struct = scripts\engine\utility::getStruct(self.target, "targetname");
  else
    self.struct = scripts\engine\utility::getStruct(scripts\engine\utility::getStruct(self.target, "targetname").target, "targetname");

  self.allparts = getEntArray(self.target, "target");
  self.leftwindow = undefined;
  self.rightwindow = undefined;

  if(isDefined(self.script_parameters))
    self.triggerdistance = float(self.script_parameters);
  else
    self.triggerdistance = 700;

  foreach(var_1 in self.allparts) {
    if(var_1.model == "windowpeek_window_l") {
      self.leftwindow = var_1;
      continue;
    }

    if(var_1.model == "windowpeek_window_r")
      self.rightwindow = var_1;
  }

  self.leftwindow scripts\engine\sp\utility::assign_animtree("LWindow");
  self.rightwindow scripts\engine\sp\utility::assign_animtree("RWindow");
  self.leftwindow.animname = "LWindow";
  self.rightwindow.animname = "RWindow";
  self.animname = "window_civ";

  if(self.whichone == 0)
    self.windowandguy = [self, self.leftwindow];
  else
    self.windowandguy = [self, self.rightwindow];

  while(distance2d(self.struct.origin, level.player.origin) > self.triggerdistance)
    waitframe();

  if(isalive(self))
    self.struct scripts\common\anim::anim_single(self.windowandguy, "windowOpen" + (self.whichone + 1));

  if(isalive(self))
    self.struct thread scripts\common\anim::anim_loop(self.windowandguy, "windowIdle" + (self.whichone + 1), "targeted" + scripts\engine\utility::string(self.target));

  while(isalive(self)) {
    if(distance2d(self.struct.origin, level.player.origin) < 400) {
      break;
    }

    if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, cos(10))) {
      break;
    }

    if(scripts\engine\utility::flag("convoy_speed_up")) {
      break;
    }

    waitframe();
  }

  self.struct notify("targeted" + scripts\engine\utility::string(self.target));

  if(isalive(self))
    self.struct scripts\common\anim::anim_single(self.windowandguy, "windowClose" + (self.whichone + 1));

  self setgoalpos(self.origin);
  wait 3;

  if(isDefined(self))
    self delete();
}

vig_roof_peek() {
  var_0 = getnode("roof_guy_delete_node", "targetname");
  var_1 = scripts\engine\utility::getStruct("roofStruct", "targetname");
  var_2 = 0;
  var_3 = scripts\engine\sp\utility::spawn_targetname("roofGuy", 1);
  var_3 scripts\engine\sp\utility::set_allowdeath(1);
  var_3.animname = "roof_civ";
  var_3 thread detect_bulletwhizby(var_0);
  var_3 endon("whizby");

  if(isalive(var_3))
    var_1 scripts\common\anim::anim_single_solo(var_3, "roofLeanEnter");

  if(isalive(var_3))
    var_1 thread scripts\common\anim::anim_loop_solo(var_3, "roofLeanIdle", "targetedRoof");

  while(!(distance2d(var_1.origin, level.player.origin) < 400 && scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_1.origin, cos(10)))) {
    waitframe();

    if(scripts\engine\utility::flag("a10_flyby_trigger") || scripts\engine\utility::flag("convoy_speed_up")) {
      wait 2;
      break;
    }
  }

  var_1 notify("targetedRoof");

  if(isalive(var_3))
    var_1 scripts\common\anim::anim_single_solo(var_3, "roofLeanExit");

  wait 2;

  if(isDefined(var_3))
    var_3 delete();
}

convoy_intro_marine_anim() {
  var_0 = scripts\engine\utility::getStruct("intro_convoy_marine_anim_struct", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("convoy_greeter", 1);
  var_1 thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1.animname = "intro_marine";
  var_2 = scripts\engine\utility::getStruct("convoy_scanning_struct_2", "targetname");
  var_3 = scripts\engine\utility::getStruct("marine_runner_path_1", "targetname");

  if(isalive(var_1))
    var_0 thread scripts\common\anim::anim_loop_solo(var_1, "convoy_idle", "convoy_idle_exit");

  scripts\engine\utility::flag_wait("convoy_speed_up");
  scripts\engine\utility::array_thread(level.allymarines["all"], scripts\common\ai::set_gunpose, "ready");
  scripts\engine\utility::array_thread(level.allymarines["all"], scripts\asm\shared\utility::toggle_poiauto, 1);
  level.starting_marines = getaiarray("allies");

  foreach(var_5 in level.starting_marines) {
    if(isalive(var_5) && isDefined(var_5.asmname))
      var_5 scripts\common\utility::demeanor_override("cqb");
  }

  if(isalive(var_1)) {
    var_0 thread scripts\common\anim::anim_single_solo(var_1, "convoy_advance");
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_convoy_marine_convoy_greeter_dialogue();

    if(isDefined(var_1.asmname))
      var_1 scripts\common\utility::demeanor_override("cqb");
  }

  var_0 notify("convoy_idle_exit");

  if(isDefined(var_1) && isalive(var_1)) {
    var_1 thread scripts\common\ai::poi_enable(1, var_2);
    var_1 scripts\sp\spawner::go_to_node(var_3);
  }

  scripts\engine\utility::flag_wait("play_IED_explosion");

  if(isDefined(var_1) && isalive(var_1)) {
    var_1.skipdeathanim = 1;
    var_1.death_anim_no_ragdoll = 1;
    var_1.forcelongdeath = 3;
    var_1 scripts\engine\sp\utility::enable_long_death();
    var_1 asmsetstate(var_1.asmname, "choose_long_death");
    var_1.a.force_num_crawls = 1;
  }

  wait 3;

  if(isDefined(var_1) && isalive(var_1))
    var_1 kill();
}

intro_roof_peek() {
  var_0 = scripts\engine\utility::getStruct("intro_roof_struct", "targetname");
  var_1 = 0;
  var_2 = getnode("peeker_delete_point", "targetname");
  var_3 = scripts\engine\sp\utility::spawn_targetname("intro_roofguy", 1);
  var_3 scripts\engine\sp\utility::set_allowdeath(1);
  var_3.animname = "roof_civ";
  var_3 thread detect_bulletwhizby(var_2);
  var_3 endon("whizby");

  if(isDefined(var_3) && isalive(var_3))
    var_0 scripts\common\anim::anim_single_solo(var_3, "roofLeanEnter");

  if(isDefined(var_3) && isalive(var_3))
    var_0 thread scripts\common\anim::anim_loop_solo(var_3, "roofLeanIdle", "targetedRoof");

  scripts\engine\utility::flag_wait("door_kick_vignette_flag");
  thread enable_intro_wait_flags();
  wait 2;
  var_0 notify("targetedRoof");

  if(isDefined(var_3) && isalive(var_3))
    var_0 scripts\common\anim::anim_single_solo(var_3, "roofLeanExit");

  if(isDefined(var_3) && isalive(var_3))
    var_3 setgoalnode(var_2);

  scripts\engine\utility::flag_wait("a10_flyby_trigger");

  if(isDefined(var_3) && isalive(var_3))
    var_3 delete();
}

detect_bulletwhizby(var_0) {
  self waittill("bulletwhizby");
  self notify("whizby");

  if(isDefined(self) && isalive(self)) {
    self stopanimScripted();
    self setgoalnode(var_0);
  }

  self waittill("goal");
  wait 5;

  if(isDefined(self) && isalive(self))
    self delete();
}

tripwire_hint() {
  level.tripwire_grenade_defused = 0;
  level.tripwire_disabled = 0;
  thread convoy_tripwire_monitor();
  scripts\engine\utility::flag_wait("tripwire_hint_flag");

  if(!scripts\engine\utility::flag("tripwire_cleared_flag"))
    thread show_tripwire_hint();

  scripts\sp\maps\marines\marines_utility.gsc::autosave();
  scripts\engine\utility::flag_wait("tripwire_cleared_flag");
  level.tripwire_disabled = 1;
  scripts\sp\maps\marines\marines_utility.gsc::autosave();
  wait 1;
}

tripwire_hint_dialogue() {
  level endon("stop_checking_tripwires");

  if(level.tripwire_disabled == 0 && !scripts\engine\utility::flag("tripwire_cleared_flag"))
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_convoy_griggs_tripwire_callout_dialogue();
}

convoy_tripwire_monitor() {
  var_0 = scripts\engine\utility::getStruct("convoy_tripwire_struct", "targetname");
  var_1 = getEnt("convoy_tripwire_nav_clip", "targetname");
  var_2 = scripts\engine\utility::getStruct("convoy_tripwire_nav_block_struct", "targetname");
  var_3 = scripts\engine\utility::getStruct("convoy_tripwire_nav_clear_struct", "targetname");
  thread scripts\sp\maps\marines\marines_utility.gsc::marines_tripwire_monitor(var_0, "tripwire_cleared_flag", var_1, var_2, var_3);
}

intro_tripwire_defused_monitor() {
  level endon("stop_checking_tripwires");

  while(!isDefined(self.defusehintstruct))
    waitframe();

  self.defusehintstruct waittill("trigger");
  level.tripwire_grenade_defused = 1;
  level notify("stop_checking_tripwires");
}

tripwire_check() {
  return istrue(level.tripwire_disabled);
}

setup_assault_vehicle() {
  var_0 = getEnt("destroyed_apc", "targetname");
  var_0 hide();
  scripts\engine\utility::flag_wait("play_IED_explosion");
  var_0 show();
}

convoy_runners() {
  var_0 = getspawnerarray("convoy_runner");
  var_1 = scripts\engine\utility::getStruct("convoy_runner_high_POI", "targetname");
  scripts\engine\sp\utility::array_spawn_function_targetname("convoy_runner", ::convoy_runners_handler);
  var_2 = scripts\engine\sp\utility::array_spawn(var_0);
  var_3 = scripts\engine\utility::getStruct("intro_convoy_runner_relaxed_anim_struct", "targetname");
  var_4 = scripts\engine\utility::getStruct("intro_convoy_runner_lookaround_anim_struct", "targetname");

  foreach(var_6 in var_2) {
    if(isDefined(var_6.animname) && var_6.animname == "convoy_runner_lookaround") {
      var_6 thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
      var_6.script_animname = "convoy_runner_lookaround";
      var_6.allowdeath = 1;
      var_6 scripts\common\ai::poi_enable(1, var_1);
      continue;
    }

    if(isDefined(var_6.animname) && var_6.animname == "convoy_runner_relaxed") {
      var_6 thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
      var_6.script_animname = "convoy_runner_relaxed";
      var_6.allowdeath = 1;
      var_6 scripts\asm\shared\utility::toggle_poiauto(1, 10, 20, 10, 20);
    }
  }

  scripts\engine\utility::flag_wait("convoy_speed_up");
  thread marine_pre_ied_disable_pushable_manager();
  scripts\sp\spawner::killspawner(1);
  thread send_griggs_to_ied();
  wait 0.5;

  foreach(var_6 in var_2) {
    if(isalive(var_6) && isDefined(var_6.script_animname) && var_6.script_animname == "convoy_runner_relaxed") {
      var_9 = scripts\engine\utility::getStruct("convoy_runner_path_1", "targetname");
      var_10 = scripts\engine\utility::getStruct("convoy_scanning_struct_1", "targetname");
      var_6 thread scripts\common\ai::poi_enable(1, var_10);
      var_6 thread scripts\sp\spawner::go_to_node(var_9);
    }
  }

  wait 0.5;

  foreach(var_6 in var_2) {
    if(isalive(var_6) && isDefined(var_6.script_animname) && var_6.script_animname == "convoy_runner_lookaround") {
      var_13 = scripts\engine\utility::getStruct("convoy_runner_path_0", "targetname");
      var_14 = scripts\engine\utility::getStruct("convoy_scanning_struct_0", "targetname");
      var_6 thread scripts\common\ai::poi_enable(1, var_14);
      var_6 thread scripts\sp\spawner::go_to_node(var_13);
    }
  }

  scripts\engine\utility::flag_wait("play_IED_explosion");
  var_16 = scripts\engine\utility::getStruct("convoy_ambush_ied_explosion", "targetname");

  foreach(var_6 in var_2) {
    if(isDefined(var_6.script_animname) && var_6.script_animname == "convoy_runner_lookaround") {
      if(isDefined(var_6) && isalive(var_6)) {
        var_6 scripts\engine\sp\utility::set_deathanim("runner_death_right");
        var_6 scripts\sp\utility::do_damage(9999, var_6.origin, undefined, undefined, "MOD_EXPLOSIVE", undefined, var_16.origin);
      }

      continue;
    }

    if(isDefined(var_6) && isalive(var_6)) {
      var_6 scripts\engine\sp\utility::set_deathanim("runner_death_right");
      var_6 scripts\sp\utility::do_damage(9999, var_6.origin, undefined, undefined, "MOD_GRENADE_SPLASH", undefined, var_16.origin);
    }
  }
}

marine_pre_ied_disable_pushable_manager() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      if(var_2 != level.griggs)
        var_2 thread marine_pre_ied_disable_pushable();
    }
  }
}

marine_pre_ied_disable_pushable() {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(self) && isalive(self)) {
    self.dontavoidplayer = 1;
    self.script_pushable = 0;
    self enableavoidance(0);
    self.doavoidanceblocking = 0;
    self.dontchangepushplayer = undefined;
  }

  scripts\engine\utility::flag_wait("play_IED_explosion");

  if(isDefined(self) && isalive(self)) {
    self.dontavoidplayer = 0;
    self.script_pushable = 1;
    self enableavoidance(1);
    self.doavoidanceblocking = 1;
    self.dontchangepushplayer = 1;
  }
}

vig_sledgebreach(var_0) {
  var_1 = [getspawner("leftStackSpawner03", "targetname"), getspawner("introSledgeSpawner", "targetname"), getspawner("rightStackSpawner01", "targetname"), getspawner("rightStackSpawner02", "targetname")];
  var_2 = [];
  var_3 = getnode("introDoorBreachMarine_01", "targetname");
  var_4 = getnode("introDoorBreachMarine_02", "targetname");
  var_5 = getnode("introDoorBreachMarine_03", "targetname");
  var_6 = getnode("introDoorBreachMarine_04", "targetname");
  var_7 = scripts\engine\utility::getStruct("sledge01_post_struct", "targetname");
  var_8 = scripts\engine\utility::getStruct("sledge02_post_struct", "targetname");
  var_9 = scripts\engine\utility::getStruct("sledge03_post_struct", "targetname");
  var_10 = scripts\engine\utility::getStruct("sledge04_post_struct", "targetname");

  for(var_11 = 0; var_11 < var_1.size; var_11++) {
    var_2[var_11] = scripts\engine\utility::getStruct(var_1[var_11].targetname, "target");
    waitframe();
  }

  var_12 = getEnt("sledgeDoor", "targetname");
  var_13 = scripts\engine\utility::getStruct("sledge_door_struct", "targetname");
  var_14 = getEnt("sledge_door_struct_sfx_source", "targetname");
  var_12 scripts\engine\sp\utility::assign_animtree("sledgeDoor");
  var_12.animname = "sledgeDoor";
  level.introdoorbreachmarines = [];

  for(var_11 = 0; var_11 < var_1.size; var_11++) {
    level.introdoorbreachmarines[var_11] = var_1[var_11] scripts\engine\sp\utility::spawn_ai(1);
    level.introdoorbreachmarines[var_11].allowdeath = 1;
    level.introdoorbreachmarines[var_11].friend_kill_points = -100000;
    level.introdoorbreachmarines[var_11] thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
    level.introdoorbreachmarines[var_11].animname = "introDoorBreachMarine_0" + (var_11 + 1);
    waitframe();
  }

  if(isDefined(level.introdoorbreachmarines[1]) && isalive(level.introdoorbreachmarines[1]))
    level.introdoorbreachmarines[1] attach("misc_wm_sledgehammer_scaled", "tag_accessory_right");

  scripts\common\anim::addnotetrack_customfunction("introDoorBreachMarine_02", "stow_sledge", ::intro_sledge_put_away, "sledgeBreach");

  foreach(var_16 in level.introdoorbreachmarines) {
    if(isDefined(var_16) && isalive(var_16))
      var_16.script_pushable = 0;
  }

  for(var_11 = 0; var_11 < var_2.size; var_11++) {
    if(isDefined(level.introdoorbreachmarines[var_11]) && isalive(level.introdoorbreachmarines[var_11]))
      var_2[var_11] thread scripts\common\anim::anim_loop_solo(level.introdoorbreachmarines[var_11], "sledgeDoorPreBreach", "moveIn");
  }

  if(var_0)
    scripts\engine\sp\utility::wait_for_targetname_trigger("vig_arrest_trigger");

  thread scripts\sp\maps\marines\marines_vo.gsc::vo_convoy_sledgehammer_dialogue();
  wait 2;

  foreach(var_19 in var_2)
  var_19 notify("moveIn");

  if(isDefined(level.introdoorbreachmarines[1]) && isalive(level.introdoorbreachmarines[1]))
    var_13 thread scripts\common\anim::anim_single_solo(var_12, "sledgeBreach");

  if(isDefined(level.introdoorbreachmarines[1]) && isalive(level.introdoorbreachmarines[1])) {
    var_2[1] thread scripts\common\anim::anim_single_solo(level.introdoorbreachmarines[1], "sledgeBreach");
    var_14 thread scripts\engine\sp\utility::play_sound_on_tag("scn_zd30_door1_breach_sledge_door", undefined);
    wait 0.75;

    if(isDefined(level.introdoorbreachmarines[1]) && isalive(level.introdoorbreachmarines[1]))
      thread scripts\engine\utility::exploder("hammer_breach");
  }

  wait 0.5;

  if(isDefined(level.introdoorbreachmarines[1]) && isalive(level.introdoorbreachmarines[1])) {
    if(isDefined(level.introdoorbreachmarines[2]) && isalive(level.introdoorbreachmarines[2])) {
      level.introdoorbreachmarines[2] thread sledge_marine_advancing("sledge_right_initial_moving");
      level.introdoorbreachmarines[2] thread sledge_marine_cowabunga_advance();
      level.introdoorbreachmarines[2] scripts\engine\utility::set_movement_speed(80);
      level.introdoorbreachmarines[2] thread color_arrive_handler(var_5, var_9);
    }
  }

  scripts\engine\utility::flag_wait("sledge_right_initial_moving");

  if(isDefined(level.introdoorbreachmarines[1]) && isalive(level.introdoorbreachmarines[1])) {
    if(isDefined(level.introdoorbreachmarines[3]) && isalive(level.introdoorbreachmarines[3])) {
      level.introdoorbreachmarines[3] scripts\engine\utility::set_movement_speed(80);
      level.introdoorbreachmarines[3] thread sledge_marine_cowabunga_advance();
      level.introdoorbreachmarines[3] thread color_arrive_handler(var_6, var_10);
    }

    if(isDefined(level.introdoorbreachmarines[3]) && isalive(level.introdoorbreachmarines[3])) {
      level.introdoorbreachmarines[1] thread sledge_marine_advancing("sledge_left_initial_moving");
      level.introdoorbreachmarines[1] scripts\engine\utility::set_movement_speed(80);
      level.introdoorbreachmarines[1] thread sledge_marine_cowabunga_advance(0);
      level.introdoorbreachmarines[1] thread color_arrive_handler(var_4, var_8);
    }
  }

  scripts\engine\utility::flag_wait("sledge_left_initial_moving");

  if(isDefined(level.introdoorbreachmarines[1]) && isalive(level.introdoorbreachmarines[1])) {
    if(isDefined(level.introdoorbreachmarines[0]) && isalive(level.introdoorbreachmarines[0])) {
      level.introdoorbreachmarines[0] scripts\engine\utility::set_movement_speed(80);
      level.introdoorbreachmarines[0] thread sledge_marine_cowabunga_advance();
      level.introdoorbreachmarines[0] thread color_arrive_handler(var_3, var_7);
    }
  }

  scripts\engine\utility::flag_wait("play_IED_explosion");
  level notify("sledgeDoorPostBreach_end");

  foreach(var_19 in [var_7, var_8, var_9, var_10])
  var_19 notify("sledgeDoorPostBreach_end");

  wait 5;

  foreach(var_16 in level.introdoorbreachmarines) {
    if(isDefined(var_16) && isalive(var_16))
      var_16 delete();
  }
}

sledge_marine_advancing(var_0) {
  self endon("death");
  self endon("entitydeleted");
  var_1 = 30;
  var_2 = self.origin;

  while(isalive(self) && !scripts\engine\utility::flag(var_0)) {
    if(distance2d(var_2, self.origin) > var_1)
      scripts\engine\utility::flag_set(var_0);
    else {}

    waitframe();
  }
}

sledge_marine_cowabunga_advance(var_0) {
  if(isDefined(self) && isalive(self)) {
    if(!isDefined(var_0))
      self stopanimScripted();
    else if(isDefined(var_0) && var_0 == 0) {
      wait 1.75;
      self stopanimScripted();
    }

    self.cautiousnavigation = 1;
    self.goalradius = 32;
    self.dontavoidplayer = 1;
    self.disablebulletwhizbyreaction = 1;
    self.script_pushable = 0;
    self enableavoidance(0);
    self.doavoidanceblocking = 0;
    self.dontchangepushplayer = undefined;
    scripts\common\ai::set_gunpose("ready", 1);

    if(isDefined(self.animname) && self.animname != "introDoorBreachMarine_01" && self.animname != "introDoorBreachMarine_04")
      scripts\asm\shared\utility::toggle_poiauto(1, 10, 20, 10, 20);
  }

  wait 5;

  if(isDefined(self) && isalive(self)) {
    self.dontavoidplayer = 0;
    self.disablebulletwhizbyreaction = 0;
    self.script_pushable = 1;
    self enableavoidance(1);
    self.doavoidanceblocking = 1;
    self.dontchangepushplayer = 1;
  }
}

color_arrive_handler(var_0, var_1) {
  level endon("sledgeDoorPostBreach_end");
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(self.animname)) {
    if(self.animname == "introDoorBreachMarine_01") {
      scripts\common\ai::set_gunpose("ads", 1);
      var_2 = scripts\engine\utility::getStruct("mar_sledge_l_turnA_struct", "targetname");
      var_2 scripts\sp\anim::anim_reach_solo(self, "sledgeDoorBreachA");
      var_2 scripts\common\anim::anim_single_solo_run(self, "sledgeDoorBreachA");
    } else if(self.animname == "introDoorBreachMarine_04") {
      var_2 = scripts\engine\utility::getStruct("mar_sledge_r_turnB_struct", "targetname");
      var_2 scripts\sp\anim::anim_reach_solo(self, "sledgeDoorBreachB");
      var_2 scripts\common\anim::anim_single_solo_run(self, "sledgeDoorBreachB");
    }
  }

  scripts\engine\sp\utility::set_goal_node(var_0);
  scripts\engine\sp\utility::set_goal_radius(16);
  scripts\sp\maps\marines\marines_utility.gsc::color_node_arrive(var_0);

  if(isDefined(self.animname) && self.animname == "introDoorBreachMarine_01") {
    var_3 = getEnt("sledge_player_clip", "targetname");
    var_3 delete();
    scripts\engine\utility::flag_set("sledge_complete");
    scripts\common\anim::anim_single_solo(self, "sledgeDoorBreachC");
    thread scripts\common\anim::anim_loop_solo(self, "sledgeDoorPostBreachAlt", "sledgeDoorPostBreach_end");
  } else
    var_1 thread scripts\common\anim::anim_loop_solo(self, "sledgeDoorPostBreach", "sledgeDoorPostBreach_end");

  if(var_1.targetname == "sledge03_post_struct") {
    wait 0.5;
    scripts\common\ai::gun_remove();
  }
}

vig_injuredmarine() {
  var_0 = scripts\engine\utility::getStruct("injuredMarineDragStruct", "targetname");
  var_1 = scripts\engine\utility::getStruct("injuredMarineDragStruct2", "targetname");
  level.draggingmarine = scripts\engine\sp\utility::spawn_targetname("introInjuredDragger", 1);
  level.draggedmarine = scripts\engine\sp\utility::spawn_targetname("introInjuredDragged", 1);
  level.draggingmarine thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
  level.draggedmarine thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
  level.draggingmarine.animname = "draggingMarine";
  level.draggedmarine.animname = "draggedMarine";
  var_2 = [level.draggingmarine, level.draggedmarine];
  scripts\engine\utility::flag_wait("dragMarine");
  scripts\engine\utility::exploder("flash_bang_body_drag");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_3 == 0) {
      var_2[var_3] thread dragtoidle(var_1);
      continue;
    }

    var_2[var_3] thread dragtoidle(var_0);
  }

  scripts\engine\utility::flag_wait("right_street_save");

  foreach(var_5 in var_2) {
    if(isDefined(var_5))
      var_5 delete();
  }
}

dragtoidle(var_0) {
  var_1 = 0.412;
  var_0 thread scripts\common\anim::anim_single_solo(self, "injuredMarineDrag");
  waitframe();
  self setanimtime(scripts\engine\utility::getanim_from_animname("injuredMarineDrag", self.animname), var_1);
  wait(getanimlength(scripts\engine\utility::getanim_from_animname("injuredMarineDrag", self.animname)) * (1 - var_1));
  var_0 thread scripts\common\anim::anim_loop_solo(self, "injuredMarineDragIdle");
}

intro_sledge_put_away(var_0) {
  var_0 detach("misc_wm_sledgehammer_scaled", "tag_accessory_right");
  var_0 attach("misc_wm_sledgehammer_scaled", "tag_stowed_back");
}

intro_convoy_vfx() {
  level endon("intro_skipped");
  scripts\engine\utility::flag_wait("play_intro_convoy_driveby");
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("intro_vehicle_1");
  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("intro_vehicle_2");
  var_2 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("intro_vehicle_3");
  var_3 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("intro_vehicle_4");
  var_4 = [var_0, var_1, var_2, var_3];
  var_5 = scripts\engine\utility::getfx("vfx_vehicle_treadfx_dust");

  foreach(var_7 in var_4) {
    playFXOnTag(var_5, var_7, "tag_wheel_back_left");
    playFXOnTag(var_5, var_7, "tag_wheel_back_right");
    playFXOnTag(var_5, var_7, "tag_wheel_front_left");
    playFXOnTag(var_5, var_7, "tag_wheel_front_right");
  }
}

waitill_path_end_watcher() {
  self waittill("reached_path_end");
  scripts\common\ai::poi_enable(0);
}

clear_target_entity() {
  level waittill("clear_fake_target");
  self clearentitytarget();
}

yellow_guy_look_up() {
  var_0 = getnode("yellow_lookup_node", "targetname");
  var_1 = getEnt("yellow_initial_lookup_origin", "targetname");
  var_2 = scripts\engine\utility::getStruct("yellow_scan_struct", "targetname");
  var_3 = 0;
  var_4 = getEnt("intro_marine_poi_trigger_6", "targetname");
  var_5 = 0;

  while(var_3 == 0) {
    if(isDefined(self) && isalive(self)) {
      if(scripts\engine\utility::is_equal(var_0, self.node)) {
        self waittill("goal");
        thread scripts\common\ai::poi_enable(0);
        var_3 = 1;
      }
    }

    waitframe();
  }

  if(isDefined(self) && isalive(self)) {
    scripts\engine\sp\utility::enable_dontevershoot();
    self setentitytarget(var_1);
  }

  while(var_5 == 0) {
    if(isDefined(self) && isalive(self)) {
      if(ispointinvolume(self.origin, var_4)) {
        if(isDefined(self)) {
          scripts\common\ai::poi_enable(0);
          self clearentitytarget();
          var_5 = 1;
        }
      }
    }

    waitframe();
  }
}

red_marine_lookat_target() {
  var_0 = getnode("red_lookup_node", "targetname");
  var_1 = 0;
  var_2 = getEnt("intro_marine_poi_trigger_6", "targetname");
  var_3 = 0;

  while(var_1 == 0) {
    if(isDefined(self) && isalive(self)) {
      if(scripts\engine\utility::is_equal(var_0, self.node)) {
        self waittill("goal");
        scripts\asm\shared\utility::toggle_poiauto(1, 10, 20, 10, 20);
        var_1 = 1;
      }
    }

    waitframe();
  }

  while(var_3 == 0) {
    if(isDefined(self) && isalive(self)) {
      if(ispointinvolume(self.origin, var_2)) {
        scripts\common\ai::poi_enable(0);
        self clearentitytarget();
        var_3 = 1;
      }
    }

    waitframe();
  }
}

convoy_runners_handler() {
  if(isalive(self) && isDefined(self.asmname))
    scripts\common\utility::demeanor_override("cqb");
}

assault_vehicle_spawner() {
  level.assault_vehicle = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("assault_vehicle", "Viper 3-5", "convoy_journey_assault_vehicle_start", 1, 0);
  level.assault_vehicle.targetname = "assault_vehicle";
  level.assault_vehicle.dontdisconnectpaths = 1;
  level.assault_vehicle.script_badplace = 1;
  level.assault_vehicle scripts\common\vehicle_code::vehicle_remove_badplace();
  var_0 = getEnt("bradley_ref_ent", "targetname");
  var_0 linkTo(level.assault_vehicle);
  thread apc_player_detector_monitor();
  thread apc_player_detector_volume_handler();
  level.assault_vehicle thread scripts\sp\maps\marines\marines_background.gsc::ground_vehicle_sound_handler();
  var_1 = scripts\engine\utility::getfx("vfx_vehicle_treadfx_dust");
  level.assault_vehicle.godmode = 1;
  level.assault_vehicle vehicle_setspeed(5.5, 2, 1);
  playFXOnTag(var_1, level.assault_vehicle, "tag_wheel_back_left");
  playFXOnTag(var_1, level.assault_vehicle, "tag_wheel_back_right");
  playFXOnTag(var_1, level.assault_vehicle, "tag_wheel_front_left");
  playFXOnTag(var_1, level.assault_vehicle, "tag_wheel_front_right");
  scripts\engine\utility::flag_wait("assault_vehicle_halt");
  killfxontag(var_1, level.assault_vehicle, "tag_wheel_back_left");
  killfxontag(var_1, level.assault_vehicle, "tag_wheel_back_right");
  killfxontag(var_1, level.assault_vehicle, "tag_wheel_front_left");
  killfxontag(var_1, level.assault_vehicle, "tag_wheel_front_right");
  scripts\engine\utility::flag_wait("convoy_commence");
  playFXOnTag(var_1, level.assault_vehicle, "tag_wheel_back_left");
  playFXOnTag(var_1, level.assault_vehicle, "tag_wheel_back_right");
  playFXOnTag(var_1, level.assault_vehicle, "tag_wheel_front_left");
  playFXOnTag(var_1, level.assault_vehicle, "tag_wheel_front_right");
}

bradley_ref_sphere() {
  while(!scripts\engine\utility::flag("play_IED_explosion"))
    waitframe();
}

convoy_player_awareness(var_0) {
  level endon("play_IED_explosion");
  var_1 = spawn("script_origin", level.player.origin);
  var_2 = spawn("script_origin", self.origin + anglesToForward(self.angles) * 70 + anglestoright(self.angles) * 70);
  var_3 = spawn("script_origin", self.origin + anglesToForward(self.angles) * 70 + anglestoright(self.angles) * 70);
  var_4 = spawn("script_origin", self.origin + anglesToForward(self.angles) * 140 - anglestoright(self.angles) * 70);
  waitframe();
  var_2.angles = self.angles;
  var_2 linkTo(self);
  var_4 linkTo(var_3);
  var_3.origin = var_2.origin;
  self.stopped_by_player = 0;

  if(isDefined(var_0))
    self.stopped_by_leader = 0;

  for(;;) {
    var_1.origin = level.player.origin;
    var_3.origin = var_2.origin;
    var_1 linkTo(var_3);
    var_3.angles = (0, 0, 0);
    var_5 = var_1.origin[0];
    var_6 = var_1.origin[1];

    if(isDefined(var_0)) {
      if(var_0.stopped_by_player == 1) {
        self vehicle_setspeedimmediate(0);
        self.stopped_by_leader = 1;
      } else if(self.stopped_by_leader == 1) {
        self vehicle_setspeed(4, 1, 0.5);
        self.stopped_by_leader = 0;
      }
    }

    if(var_3.origin[0] < var_5 && var_5 < var_4.origin[0] && var_3.origin[1] < var_6 && var_6 < var_4.origin[1]) {
      self vehicle_setspeedimmediate(0);
      self.stopped_by_player = 1;
    } else if(self.stopped_by_player == 1) {
      self vehicle_setspeed(4, 1, 0.5);
      self.stopped_by_player = 0;
    }

    var_1 unlink();
    waitframe();
  }
}

ied_vehicle_spawner() {
  level.ied_vehicle = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("ied_vehicle", "Viper 3-4", "convoy_journey_ied_vehicle_start", 1, 0);
  level.ied_vehicle.targetname = "ied_vehicle";
  level.ied_vehicle.script_badplace = 1;
  level.ied_vehicle scripts\common\vehicle_code::vehicle_remove_badplace();
  var_0 = getEnt("ied_vehicle_clip", "targetname");
  var_0 linkTo(level.ied_vehicle);
  level.ied_vehicle thread scripts\sp\maps\marines\marines_background.gsc::ground_vehicle_sound_handler();
  var_1 = scripts\engine\utility::getfx("vfx_vehicle_treadfx_dust");
  playFXOnTag(var_1, level.ied_vehicle, "tag_wheel_back_left");
  playFXOnTag(var_1, level.ied_vehicle, "tag_wheel_back_right");
  playFXOnTag(var_1, level.ied_vehicle, "tag_wheel_front_left");
  playFXOnTag(var_1, level.ied_vehicle, "tag_wheel_front_right");
  waitframe();
  scripts\engine\utility::flag_wait("ied_vehicle_halt");
  killfxontag(var_1, level.ied_vehicle, "tag_wheel_back_left");
  killfxontag(var_1, level.ied_vehicle, "tag_wheel_back_right");
  killfxontag(var_1, level.ied_vehicle, "tag_wheel_front_left");
  killfxontag(var_1, level.ied_vehicle, "tag_wheel_front_right");
  waitframe();
  scripts\engine\utility::flag_wait("ied_vehicle_commence");
  playFXOnTag(var_1, level.ied_vehicle, "tag_wheel_back_left");
  playFXOnTag(var_1, level.ied_vehicle, "tag_wheel_back_right");
  playFXOnTag(var_1, level.ied_vehicle, "tag_wheel_front_left");
  playFXOnTag(var_1, level.ied_vehicle, "tag_wheel_front_right");
  waitframe();
  scripts\engine\utility::flag_wait("postfx_ied_explosion");
  killfxontag(var_1, level.ied_vehicle, "tag_wheel_back_left");
  killfxontag(var_1, level.ied_vehicle, "tag_wheel_back_right");
  killfxontag(var_1, level.ied_vehicle, "tag_wheel_front_left");
  killfxontag(var_1, level.ied_vehicle, "tag_wheel_front_right");
  wait 1.0;
  level.ied_vehicle vehicle_setspeed(2.5, 5, 500);
  waitframe();
  var_0 disconnectPaths();
}

player_vehicle_spawner() {
  level.player_vehicle = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("player_vehicle", "Viper 3-3", "convoy_journey_player_vehicle_start", 1, 0);
  level.player_vehicle.targetname = "player_vehicle";
  level.player_vehicle.dontdisconnectpaths = 1;
  level.player_vehicle.script_badplace = 1;
  level.player_vehicle scripts\common\vehicle_code::vehicle_remove_badplace();
  level.player_vehicle thread scripts\sp\maps\marines\marines_background.gsc::ground_vehicle_sound_handler();

  while(!isDefined(level.ied_vehicle))
    waitframe();

  var_0 = getEnt("player_vehicle_clip", "targetname");
  var_0 linkTo(level.player_vehicle);
  var_1 = scripts\engine\utility::getfx("vfx_vehicle_treadfx_dust");
  playFXOnTag(var_1, level.player_vehicle, "tag_wheel_back_left");
  playFXOnTag(var_1, level.player_vehicle, "tag_wheel_back_right");
  playFXOnTag(var_1, level.player_vehicle, "tag_wheel_front_left");
  playFXOnTag(var_1, level.player_vehicle, "tag_wheel_front_right");
  waitframe();
  scripts\engine\utility::flag_wait("player_vehicle_halt");
  killfxontag(var_1, level.player_vehicle, "tag_wheel_back_left");
  killfxontag(var_1, level.player_vehicle, "tag_wheel_back_right");
  killfxontag(var_1, level.player_vehicle, "tag_wheel_front_left");
  killfxontag(var_1, level.player_vehicle, "tag_wheel_front_right");
  waitframe();
  scripts\engine\utility::flag_wait("players_vehicle_commence");
  playFXOnTag(var_1, level.player_vehicle, "tag_wheel_back_left");
  playFXOnTag(var_1, level.player_vehicle, "tag_wheel_back_right");
  playFXOnTag(var_1, level.player_vehicle, "tag_wheel_front_left");
  playFXOnTag(var_1, level.player_vehicle, "tag_wheel_front_right");
  waitframe();
  scripts\engine\utility::flag_wait("postfx_ied_explosion");
  killfxontag(var_1, level.player_vehicle, "tag_wheel_back_left");
  killfxontag(var_1, level.player_vehicle, "tag_wheel_back_right");
  killfxontag(var_1, level.player_vehicle, "tag_wheel_front_left");
  killfxontag(var_1, level.player_vehicle, "tag_wheel_front_right");
  wait 2;
  level.player_vehicle vehicle_setspeed(2.5, 5, 500);
  waitframe();
  var_0 disconnectPaths();
}

show_tripwire_hint() {
  wait 3;

  if(!scripts\engine\utility::flag("tripwire_cleared_flag") && level.tripwire_disabled == 0) {
    scripts\engine\sp\utility::display_hint("tripwire_hint");
    wait 7.0;
    level.tripwire_disabled = 1;
  }
}

bridge_overseer_handler() {
  var_0 = getspawner("bridge_overseer", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai();
  var_1 thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
  var_2 = scripts\engine\utility::getStruct("bridge_POI", "targetname");
  waitframe();
  var_1 thread scripts\common\ai::poi_enable(1, var_2);
  scripts\engine\utility::flag_wait("play_IED_explosion");
  var_1 delete();
}

intro_phone_peek() {
  var_0 = scripts\engine\utility::getStruct("intro_cellphone_struct", "targetname");
  var_1 = 0;
  var_2 = getnode("phone_delete_point", "targetname");
  var_3 = scripts\engine\sp\utility::spawn_targetname("intro_phoneguy", 1);
  var_3 scripts\engine\sp\utility::set_allowdeath(1);
  var_3.animname = "phone_civ" + randomint(2);
  var_3 thread detect_bulletwhizby(var_2);
  var_3 endon("whizby");

  if(isDefined(var_3) && isalive(var_3))
    var_0 scripts\common\anim::anim_single_solo(var_3, "phoneEnter");

  if(isDefined(var_3) && isalive(var_3))
    var_0 thread scripts\common\anim::anim_loop_solo(var_3, "phoneIdle", "targetedRoof");

  scripts\engine\utility::flag_wait("door_kick_vignette_flag");
  wait(randomint(3) + 1);
  var_0 notify("targetedRoof");

  if(isDefined(var_3) && isalive(var_3))
    var_0 scripts\common\anim::anim_single_solo(var_3, "phoneExit");

  if(isDefined(var_3) && isalive(var_3))
    var_3 setgoalnode(var_2);

  scripts\engine\utility::flag_wait_any("a10_flyby_trigger", "convoy_speed_up");

  if(isDefined(var_3) && isalive(var_3))
    var_3 delete();
}

enable_intro_wait_flags() {
  wait 1;
  scripts\engine\utility::flag_set("intro_first_stop_1");
  wait 1;
  scripts\engine\utility::flag_set("intro_first_stop_2");
}

enable_a10_wait_flags() {
  wait 1;
  scripts\engine\utility::flag_set("a10_first_stop_1");
  wait 1;
  scripts\engine\utility::flag_set("a10_first_stop_2");
}

intro_camera_handler() {
  scripts\sp\hud_util::start_overlay();
  scripts\engine\utility::delaythread(0.5, scripts\sp\hud_util::fade_in, 0.01);
  hidecinematicletterboxing(0.01, 0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  thread intro_fake_player_handler();
  scripts\sp\maps\marines\marines_utility.gsc::put_player_into_rig(level.player.rig, 0.25, 0, 0, 0, 0);
  level.player.rig hide();
  level.player lerpfovscalefactor(0, 0);
  level.player lerpfov(35, 0.1);
  scripts\common\anim::addnotetrack_customfunction("player_rig", "zoomout_start", ::fovshift, "introSequence");
  thread bars_out();
  thread intro_skip_monitor();
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var_0 = scripts\engine\utility::getStruct("introStruct", "targetname");
  var_0 scripts\common\anim::anim_single_solo(level.player.rig, "introSequence");
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  scripts\engine\utility::flag_set("intro_cinematic_complete");
  scripts\sp\utility::userskip_stop();
  scripts\sp\maps\marines\marines_utility.gsc::autosave();
}

bars_out() {
  level endon("intro_skipped");
  wait 37.1;
  getrandomnodedestination(1.8, 0);
}

fovshift(var_0) {
  level.player lerpfov(65, 35);
}

intro_fake_player_handler() {
  level endon("intro_skipped");
  level.fake_player = scripts\engine\sp\utility::spawn_targetname("intro_fake_player", 1);
  level.fake_player.name = "Alex";
  level.fake_player.animname = "fake_player";
  level.fake_player.script_friendname = "Alex";
  level.fake_player scripts\anim\shared.gsc::forceuseweapon(level.primaryweapon, "primary");
  level.fake_player visiblenotsolid();
  var_0 = scripts\engine\utility::getStruct("introStruct_fakePlayer", "targetname");
  var_0 scripts\common\anim::anim_single_solo(level.fake_player, "MAR_intro_010_dropoff_alex");
  level.fake_player delete();
}

intro_griggs_handler() {
  var_0 = scripts\engine\utility::getStruct("introStruct_griggs", "targetname");
  level.griggs.animname = "griggs";
  level.griggs scripts\engine\sp\utility::name_hide();
  var_0 thread scripts\common\anim::anim_single_solo_run(level.griggs, "introSequence");
  scripts\engine\utility::flag_wait("intro_cinematic_complete");
  level.griggs scripts\engine\sp\utility::name_show();
}

intro_farah_handler() {
  level.farah = scripts\engine\sp\utility::spawn_targetname("intro_farah", 1);
  level.farah.script_parameters = "Farah";
  level.farah.name = "Farah";
  level.farah.script_friendname = "Farah";
  var_0 = scripts\engine\utility::getStruct("introStruct_farah", "targetname");
  level.farah.animname = "farah";
  level.farah.friend_kill_points = -100000;
  level.farah scripts\engine\sp\utility::name_hide();
  thread intro_ents_add(level.farah);
  var_0 scripts\common\anim::anim_single_solo(level.farah, "introSequence");
  scripts\engine\utility::flag_wait("intro_cinematic_complete");
  level.farah scripts\engine\sp\utility::name_show();

  if(isDefined(level.farah))
    level.farah delete();
}

intro_hadir_handler() {
  level.hadir = scripts\engine\sp\utility::spawn_targetname("intro_hadir", 1);
  level.hadir.script_parameters = "Hadir";
  level.hadir.name = "Hadir";
  level.hadir.script_friendname = "Hadir";
  var_0 = scripts\engine\utility::getStruct("introStruct_hadir", "targetname");
  level.hadir.animname = "hadir";
  level.hadir.friend_kill_points = -100000;
  level.hadir scripts\engine\sp\utility::name_hide();
  thread intro_ents_add(level.hadir);
  var_0 scripts\common\anim::anim_single_solo(level.hadir, "introSequence");
  scripts\engine\utility::flag_wait("intro_cinematic_complete");
  level.hadir scripts\engine\sp\utility::name_show();

  if(isDefined(level.hadir))
    level.hadir delete();
}

intro_driver_handler() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("intro_driver", 1);
  var_1 = scripts\engine\utility::getStruct("introStruct_driver", "targetname");
  var_0.animname = "driver";
  var_0.friend_kill_points = -100000;
  var_0 scripts\engine\sp\utility::name_hide();
  thread intro_ents_add(var_0);
  var_1 scripts\common\anim::anim_single_solo(var_0, "introSequence");
  scripts\engine\utility::flag_wait("intro_cinematic_complete");
  var_0 scripts\engine\sp\utility::name_show();

  if(isDefined(var_0))
    var_0 delete();
}

intro_truck_handler() {
  var_0 = getEnt("introTruck", "targetname");
  var_1 = scripts\engine\utility::getStruct("introStruct_truck", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("introTruck");
  var_0.animname = "introTruck";
  thread intro_ents_add(var_0);
  var_0 thread intro_truck_treadfx_handler(39.5);
  var_1 scripts\common\anim::anim_single_solo(var_0, "introSequence");
  var_0 notify("stop_treadfx");
  waitframe();
  var_0 delete();
}

intro_truck_treadfx_handler(var_0) {
  level scripts\sp\maps\marines\marines_utility.gsc::waittill_or_timeout("intro_skipped", var_0);
  var_1 = scripts\engine\utility::getfx("vfx_vehicle_treadfx_dust");
  playFXOnTag(var_1, self, "tag_wheel_back_left");
  playFXOnTag(var_1, self, "tag_wheel_back_right");
  playFXOnTag(var_1, self, "tag_wheel_front_left");
  playFXOnTag(var_1, self, "tag_wheel_front_right");
  self waittill("stop_treadfx");
  stopFXOnTag(var_1, self, "tag_wheel_back_left");
  stopFXOnTag(var_1, self, "tag_wheel_back_right");
  stopFXOnTag(var_1, self, "tag_wheel_front_left");
  stopFXOnTag(var_1, self, "tag_wheel_front_right");
}

intro_marine01_handler() {
  level endon("intro_skipped");
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_1 = getEntArray("ally_marine_convoy_journey", "targetname");

    foreach(var_3 in var_1) {
      if(isDefined(var_3.animname) && var_3.animname == "marine05") {
        var_0 = var_3;
        thread intro_ents_add(var_0);
      }
    }

    waitframe();
  }

  var_5 = scripts\engine\utility::getStruct("introStruct_marine01", "targetname");
  var_0.animname = "marine05";
  var_5 scripts\common\anim::anim_single_solo_run(var_0, "introSequence");
}

intro_marine02_handler() {
  level endon("intro_skipped");
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_1 = getEntArray("ally_marine_convoy_journey", "targetname");

    foreach(var_3 in var_1) {
      if(isDefined(var_3.animname) && var_3.animname == "marine06") {
        var_0 = var_3;
        thread intro_ents_add(var_0);
      }
    }

    waitframe();
  }

  var_5 = scripts\engine\utility::getStruct("introStruct_marine02", "targetname");
  var_0.animname = "marine06";
  var_5 scripts\common\anim::anim_single_solo_run(var_0, "introSequence");
}

intro_gate_handler() {
  level endon("intro_skipped");
  var_0 = getEnt("introGate", "targetname");
  var_1 = scripts\engine\utility::getStruct("introStruct_gate", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("introGate");
  var_0.animname = "introGate";
  thread intro_ents_add(var_0);
  var_1 scripts\common\anim::anim_single_solo(var_0, "introSequence");
}

intro_gateguy_handler() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("intro_gateGuy", 1);
  var_0.friend_kill_points = -100000;
  var_0 thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
  var_1 = scripts\engine\utility::getStruct("introStruct_gateGuy", "targetname");
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  var_0.animname = "gateGuy";
  thread intro_ents_add(var_0);
  var_1 scripts\common\anim::anim_single_solo(var_0, "introSequence");
  scripts\engine\utility::flag_wait("convoy_speed_up");

  if(isDefined(var_0))
    var_0 delete();
}

intro_marine03_handler() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("intro_marine_03", 1);
  thread intro_ents_add(var_0);
  var_0.friend_kill_points = -100000;
  var_1 = scripts\engine\utility::getStruct("introStruct_marine03", "targetname");
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  var_0.animname = "marine03";
  var_0 scripts\engine\sp\utility::name_hide();
  var_1 scripts\common\anim::anim_single_solo_run(var_0, "introSequence");
  var_0 scripts\engine\sp\utility::name_show();
  var_0 thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
  scripts\engine\utility::flag_wait("convoy_speed_up");

  if(isDefined(var_0))
    var_0 delete();
}

send_griggs_to_ied() {
  wait 3;
  scripts\engine\sp\utility::activate_trigger("griggs_move_to_IED", "targetname");
}

activate_sledge_lookin_dialogue() {
  var_0 = getEnt("sledge_lookat_trigger", "targetname");
  scripts\engine\utility::flag_wait("sledge_complete");
  wait 1;
  waittill_struct_in_fov("sledge_lookat_struct", "sledge_lookat_trigger");

  if(!scripts\engine\utility::flag("play_IED_explosion"))
    scripts\engine\utility::flag_set("play_sledge_dialogue");
}

waittill_struct_in_fov(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = getEnt(var_1, "targetname");
  var_4 = cos(15);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, var_4) && level.player istouching(var_3)) {
      break;
    } else
      waitframe();
  }
}

marines_movement_to_ied() {
  scripts\engine\utility::flag_wait("convoy_speed_up");
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 thread marine_demeanor_control();
  }

  wait 5;
  scripts\engine\sp\utility::activate_trigger_with_targetname("yellow_to_IED");
  wait 5;
  scripts\engine\sp\utility::activate_trigger_with_targetname("red_to_IED");
}

marine_demeanor_control() {
  if(isalive(self) && isDefined(self.asmname))
    scripts\common\utility::demeanor_override("cqb");
}

street_patch_handler() {
  var_0 = getEntArray("undamaged_patch", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();
}

intro_dialogue_handler() {
  level endon("intro_skipped");
  wait 25;
  scripts\engine\utility::flag_set("play_intro_convoy_driveby");
}

overhead_heli_flyby() {
  var_0 = 99999;
  var_1 = undefined;
  var_2 = scripts\engine\utility::getStruct("point_target", "targetname");
  wait 1;

  foreach(var_4 in level.tripwires.traps) {
    if(isDefined(var_4.origin) && distance2dsquared(var_4.origin, var_2.origin) < var_0) {
      var_0 = distance2dsquared(var_4.origin, var_2.origin);
      var_1 = var_4;
    }

    waitframe();
  }

  var_6 = var_1 scripts\engine\utility::waittill_any_return("tripwire_defused", "tripwire_detonated");

  if(var_6 == "tripwire_defused") {
    scripts\engine\sp\utility::activate_trigger("helis_defuse_tripwire", "targetname");
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_convoy_tutorial_tripwire_disabled_dialogue();
  } else if(var_6 == "tripwire_detonated")
    scripts\engine\sp\utility::activate_trigger("helis_detonate_tripwire", "targetname");
}

convoy_location_dialogue() {
  scripts\engine\sp\utility::trigger_wait_targetname("convoy_dialogue_trigger");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_convoy_griggs_convoy_approach_dialogue();
}

vehicle_cleanup_handler() {
  if(isDefined(level.player_vehicle))
    level.player_vehicle delete();

  if(isDefined(level.ied_vehicle))
    level.ied_vehicle delete();
}

apc_cleanup_handler() {
  var_0 = getEnt("destroyed_apc", "targetname");

  if(isDefined(var_0))
    var_0 delete();
}

intro_skip_monitor() {
  level.intro_ents = [];
  var_0 = scripts\sp\utility::userskip_wait();

  if(var_0) {
    level notify("intro_skipped");
    scripts\sp\hud_util::fade_out(0);
    var_1 = scripts\engine\utility::getStruct("introStruct", "targetname");
    level.player.rig scripts\engine\sp\utility::anim_stopanimScripted();
    var_1 scripts\common\anim::anim_last_frame_solo(level.player.rig, "introSequence");

    foreach(var_3 in level.intro_ents) {
      var_4 = 39.5 / getanimlength(level.scr_anim[var_3.animname]["introSequence"]);

      if(var_4 >= 1.0)
        var_4 = 0.99;

      var_3 setanimtime(var_3 scripts\engine\utility::getanim("introSequence"), var_4);
    }

    if(isDefined(level.fake_player)) {
      level.fake_player scripts\engine\sp\utility::anim_stopanimScripted();
      level.fake_player delete();
    }

    getrandomnodedestination(0, 0);
    level.player lerpfov(65, 0.05);
    level.player lerpfovscalefactor(1, 0);
    scripts\engine\utility::delaythread(0.05, scripts\sp\hud_util::fade_in, 0.05);
    scripts\engine\utility::flag_set("flag_clear_griggs_demeanor");
    scripts\engine\utility::flag_set("intro_skipped");
  }

  waitframe();
  level.player scripts\common\utility::allow_cinematic_motion(1);
  scripts\sp\maps\marines\marines_utility.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  level.player disablephysicaldepthoffieldscripting();
  scripts\engine\sp\utility::motion_blur_disable(0.5);
}

intro_ents_add(var_0) {
  while(!isDefined(level.intro_ents))
    waitframe();

  level.intro_ents = scripts\engine\utility::array_add(level.intro_ents, var_0);
}

control_marine_movement_at_ied() {
  scripts\engine\utility::flag_wait("convoy_speed_up");
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("r");
  var_1 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("c");
  var_2 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("g");
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in var_0) {
    var_7 = scripts\engine\utility::getStruct("red_marine_convoy_intro_path_" + var_3, "targetname");

    if(isDefined(var_6) && isalive(var_6)) {
      var_6 thread scripts\sp\spawner::go_to_node(var_7);

      if(var_3 < 1)
        var_3++;
    }
  }

  foreach(var_6 in var_2) {
    var_10 = scripts\engine\utility::getStruct("green_marine_convoy_intro_path_" + var_4, "targetname");

    if(isDefined(var_6) && isalive(var_6)) {
      var_6 scripts\engine\utility::set_movement_speed(80);
      var_6 thread scripts\sp\spawner::go_to_node(var_10);

      if(var_4 < 1)
        var_4++;
    }
  }

  foreach(var_6 in var_1) {
    var_13 = scripts\engine\utility::getStruct("cyan_marine_convoy_intro_path", "targetname");

    if(isDefined(var_6) && isalive(var_6)) {
      var_6 scripts\engine\utility::set_movement_speed(80);
      var_6 thread scripts\sp\spawner::go_to_node(var_13);
    }
  }
}

explosion_monitor() {
  var_0 = scripts\engine\utility::getStruct("convoy_ambush_ied_explosion", "targetname");
  var_1 = cos(60);
  scripts\engine\utility::flag_wait("wait_for_IED_explosion");

  while(!scripts\engine\utility::flag("postfx_ied_explosion")) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_1))
      scripts\engine\utility::flag_set("player_is_looking_at_IED");

    wait 0.5;
  }
}

convoy_vehicle_passenger_handler() {
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("c");
  var_1 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("g");
  var_2 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("r");

  foreach(var_4 in var_0) {
    if(isDefined(var_4) && isalive(var_4))
      level.ied_vehicle scripts\common\vehicle_aianim::guy_enter(var_4);
  }

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && isalive(var_4))
      level.player_vehicle scripts\common\vehicle_aianim::guy_enter(var_4);
  }

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && isalive(var_4)) {
      if(distance2d(var_4.origin, level.ied_vehicle.origin) < 700)
        level.ied_vehicle scripts\common\vehicle_aianim::guy_enter(var_4);
    }
  }

  scripts\engine\utility::flag_wait("postfx_ied_explosion");
  wait 1;
  level.ied_vehicle scripts\common\vehicle::vehicle_unload();
  wait 3;
  level.player_vehicle scripts\common\vehicle::vehicle_unload();
}

apc_player_detector_monitor() {
  var_0 = getEnt("APC_front_monitor_1", "targetname");
  var_1 = getEnt("APC_front_monitor_2", "targetname");
  var_2 = 1;

  while(!scripts\engine\utility::flag("play_IED_explosion") && var_2 == 1) {
    if(isDefined(var_0) && level.player istouching(var_0) || isDefined(var_1) && level.player istouching(var_1)) {
      thread scripts\sp\maps\marines\marines_vo.gsc::vo_convoy_griggs_ahead_nag_dialogue();
      var_2 = 0;
    }

    waitframe();
  }
}

apc_player_detector_volume_handler() {
  var_0 = getEnt("APC_front_monitor_1", "targetname");
  var_1 = getEnt("APC_front_monitor_2", "targetname");
  scripts\engine\utility::flag_wait("APC_volume_1_delete");
  var_0 delete();
  scripts\engine\utility::flag_wait("APC_volume_2_delete");
  var_1 delete();
}

intro_gate_disable_sprint() {
  level endon("disable_sprint_volume");
  scripts\engine\sp\utility::trigger_wait_targetname("disable_sprint_at_gate");
  level.player scripts\common\utility::allow_sprint(0);
  level.sprint_disabled = 1;
}