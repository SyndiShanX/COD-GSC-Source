/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_gameplay_streets.gsc
********************************************************/

streets_init() {
  scripts\engine\utility::flag_init("murderhole_spawn");
  scripts\engine\utility::flag_init("smoke_grenade_success");
  scripts\engine\utility::flag_init("mg_intro_complete");
  scripts\engine\utility::flag_init("flag_griggs_exit_anim");
  scripts\engine\utility::flag_init("wounded_kill");
  scripts\engine\utility::flag_init("murderhole_end");
  scripts\engine\utility::flag_init("marine_01_reached_IED");
  scripts\engine\utility::flag_init("marine_02_reached_IED");
  scripts\engine\utility::flag_init("marine_03_reached_IED");
  scripts\engine\utility::flag_init("check_if_marines_at_node");
  scripts\engine\utility::flag_init("griggs_at_mg_cover_node");
  scripts\engine\utility::flag_init("checkpoint_jumped_to_MH");
  scripts\engine\utility::flag_init("smoke_timeout");
  scripts\engine\utility::flag_init("IED_to_alley_nag_kill");
  scripts\engine\utility::flag_init("obj_update_to_gate");
  scripts\engine\utility::flag_init("ambush_start");
  scripts\engine\utility::flag_init("ready_to_cross_street");
  scripts\engine\utility::flag_init("right_side_ready_to_cross");
  scripts\engine\utility::flag_init("right_street_save");
  scripts\engine\utility::flag_init("save_building");
  scripts\engine\utility::flag_init("objective_marker_switch");
  scripts\engine\utility::flag_init("enough_enemies_killed");
  scripts\engine\utility::flag_init("technical_spawn");
  scripts\engine\utility::flag_init("rpg_spawned");
  scripts\engine\utility::flag_init("alley_entry_event");
  scripts\engine\utility::flag_init("alley_ai_spawned");
  scripts\engine\utility::flag_init("magicbullet_rpg_guys");
  scripts\engine\utility::flag_init("alley_guys_killed");
  scripts\engine\utility::flag_init("upstairs_guy_killed");
  scripts\engine\utility::flag_init("back_alley_autosave");
  scripts\engine\utility::flag_init("marines_to_alley_building_flag");
  scripts\engine\utility::flag_init("stop_smoke_nag_in_streets");
  scripts\engine\utility::flag_init("guaranteed_smoke_nag_flag");
  scripts\engine\utility::flag_init("nag_temporarily_disabled");
  scripts\engine\utility::flag_init("murderhole_breach_right");
  scripts\engine\utility::flag_init("tripwire_warning");
  scripts\engine\utility::flag_init("kitchen_trigger");
  scripts\engine\utility::flag_init("marine_dont_shoot");
  scripts\engine\utility::flag_init("get_to_mgs");
  scripts\engine\utility::flag_init("murderhole_detached");
  scripts\engine\utility::flag_init("mg_guys_dead");
  scripts\engine\utility::flag_init("marine_ready_to_fight");
  scripts\engine\utility::flag_init("mg_team_alerted");
  scripts\engine\utility::flag_init("player_ready_for_marine");
  scripts\engine\utility::flag_init("stairs_tripwire_approached");
  scripts\engine\utility::flag_init("stairs_tripwire_lookedat");
  scripts\engine\utility::flag_init("stairs_climbing_start");
  scripts\engine\utility::flag_init("stairs_grenade_nag");
  scripts\engine\utility::flag_init("stairs_tripwire_cleared");
  scripts\engine\utility::flag_init("alert_mg");
  scripts\engine\utility::flag_init("look_up_anim_flag");
  scripts\engine\utility::flag_init("final_wave_from_yard");
  scripts\engine\utility::flag_init("final_wave_from_shed");
  scripts\engine\utility::flag_init("final_wave_from_MH");
  scripts\engine\utility::flag_init("kitchen_guy_killed");
  scripts\engine\utility::flag_init("ready_to_breach_MH");
  scripts\engine\utility::flag_init("stairs_climbing_third_floor");
  scripts\engine\utility::flag_init("sun_adjuster_mh_building");
  scripts\engine\utility::flag_init("kill_mg_gunners");
  scripts\engine\utility::flag_init("third_floor_look_up_anim_flag");
  scripts\engine\utility::flag_init("murderhole_breach_save_point");
  scripts\engine\utility::flag_init("smoke_in_kitchen");
  scripts\engine\utility::flag_init("checkpoint_jumped");
  scripts\engine\utility::flag_init("alex_civ_dialogue");
  scripts\engine\utility::flag_init("looked_into_bedroom");
  scripts\engine\utility::flag_init("marine_at_bedroom");
  scripts\engine\utility::flag_init("truck_1_reached");
  scripts\engine\utility::flag_init("truck_2_reached");
  scripts\engine\utility::flag_init("truck_1_destroyed");
  scripts\engine\utility::flag_init("truck_2_destroyed");
  scripts\engine\utility::flag_init("check_truck_status");
  scripts\engine\utility::flag_init("player_entered_mg_room");
  scripts\engine\sp\utility::array_spawn_function_targetname("rooftop_alley_fakeactor_6", ::replace_fake_actors_with_real);
  scripts\engine\sp\utility::array_spawn_function_targetname("background_runners_streets_2", ::replace_fake_actors_with_real);
  level.b_mg_on_player = 0;
  level.b_smoke = 0;
}

murderhole_main() {
  thread scripts\sp\analytics::analytics_kleenex_update("Start Murderhole");
  level.manpile_monitor.maximum = 18;
  level.manpile_monitor.maximum_in_fov = 12;
  level.manpile_monitor.ideal = 14;
  level.manpile_monitor.maximum_weapons = 20;
  thread autosave_after_shellshock();
  thread ied_pinned_marine_handler();
  scripts\sp\spawner::killspawner(1);
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_murderholes", "streets_start_volume");
  thread activate_right_street_trigger();
  thread alley_entry_event();
  thread scripts\sp\maps\marines\marines_utility.gsc::ally_equipment_backpack(level.griggs, "smoke_tall");
  thread cleanup_all_poi();
  thread alley_marine_ignore_handler();
  thread griggs_movement_to_alley();
  thread ied_vignette_handler();
  thread marines_group_a_movement_to_alley();
  thread marines_group_b_movement_to_alley();
  thread murderhole_clean_up_corpses();
  thread squad_to_alley();
  thread track_player_smoke_grenade();
  thread scripts\sp\maps\marines\marines_lighting.gsc::sun_adjustments_murderhole_building();
  thread track_if_player_throw_smokes();
  thread scripts\sp\maps\marines\marines_utility.gsc::leaving_area_dialogue_monitor();
  level.griggs_can_smoke_nag = 1;
  scripts\engine\sp\utility::battlechatter_on("axis");
  scripts\engine\sp\utility::battlechatter_on("allies");
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 scripts\engine\utility::set_movement_speed(190);

      if(isDefined(var_2.asmname))
        var_2 scripts\common\utility::demeanor_override("sprint");
    }
  }

  scripts\engine\utility::flag_wait_any("murderhole_spawn", "marine_01_reached_IED", "marine_02_reached_IED", "marine_03_reached_IED", "griggs_at_mg_cover_node");
  scripts\sp\maps\marines\marines_utility.gsc::autosave();
  thread spawn_murderhole_with_dialogue();
  thread death_hint_watcher_marines_mg_death();
  scripts\engine\utility::flag_wait("obj_update_to_gate");
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 allowedstances("stand", "crouch", "prone");
      var_2 scripts\engine\utility::set_movement_speed(180);
    }
  }

  thread ied_to_alley_nag_handler();
}

murderhole_breach_clear_griggs_smokes() {
  scripts\engine\utility::flag_wait("murderhole_breach_save_point");
  level.griggs.support_equipment = 0;
}

alley_main() {
  thread scripts\sp\maps\marines\marines_utility.gsc::transient_waittill("right_side_ready_to_cross", undefined, ["marines_hospital_script_tr", "marines_hospital_wolf_shared_script_tr"]);
  scripts\engine\utility::flag_wait("murderhole_end");
  scripts\engine\sp\utility::battlechatter_on("axis");
  scripts\engine\sp\utility::battlechatter_on("allies");
  thread alley_smoke_handler();
  thread check_if_throwing_smoke();
  thread alley_track_player_smoke_grenade();
  thread marines_push_to_house_handler();
  thread right_street_autosave();
  thread save_building_autosave();
  thread ready_to_breach_dialogue();
  thread ready_to_breach_poi();
  thread back_alley_autosave();
  thread alley_bldg_door_handler();
  thread mg_entry_callout_handler();
  thread mh_building_door_handler();
  level.autosave_proximity_check = 500;
  level.griggs_initial_smoke_reminder_called = 0;
  var_0 = getspawnerarray("murderhole_inital_wave");
  var_1 = getspawnerarray("alley_initial_wave");
  var_2 = getspawnerarray("AQ_technical_1_enemies");
  var_3 = getspawnerarray("AQ_technical_2_enemies");
  var_4 = getspawnerarray("murderhole_reinforcement_wave");
  var_5 = getEnt("fake_actor_spawner", "targetname");
  var_6 = getEnt("upstairs_guy_trigger", "targetname");
  level.enemy_death_count = 0;
  scripts\engine\sp\utility::array_spawn_function(var_0, ::murderhole_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_1, ::murderhole_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_2, ::murderhole_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_3, ::murderhole_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_4, ::murderhole_enemy_behavior, "set_MH_trigger");
  thread alley_fallback_handler();
  thread cqb_marines_movement_monitor();
  thread cqb_player_movement_monitor();
  thread activate_mh_trigger();
  thread aq_technical_spawners();
  thread disabling_truck_1_node_handler();
  thread disabling_truck_2_node_handler();
  thread final_wave_enemies();
  thread mg_alley_intro_script_shot();
  thread mg_shoot_scriptables();
  thread scripts\sp\maps\marines\marines_utility.gsc::propane_rockets_init();
  thread save_game_after_battlefield();
  thread spawn_rpg_support();
  thread yard_enemy_handler();
  thread upstairs_guy_handler();
  thread alley_push_up_scripted_dialogue();
  thread streets_push_up_nag();
  thread streets_smoke_grenade_nag();
  thread streets_smoke_grenade_guaranteed_nag();
  scripts\engine\utility::flag_wait("right_street_save");
  var_7 = getaiarray("allies");

  foreach(var_9 in var_7) {
    if(isalive(var_9)) {
      var_9 scripts\engine\sp\utility::set_attackeraccuracy(0.2);

      if(isDefined(var_9.asmname))
        var_9 scripts\common\utility::demeanor_override("combat");
    }
  }

  foreach(var_9 in var_7) {
    if(isDefined(var_9) && isDefined(var_9.script_forcecolor) && var_9.script_forcecolor == "p")
      var_9 delete();
  }

  var_13 = getEntArray("ied_rider", "targetname");
  var_14 = getEntArray("player_rider", "targetname");

  foreach(var_9 in var_13) {
    if(isDefined(var_9))
      var_9 delete();
  }

  foreach(var_9 in var_14) {
    if(isDefined(var_9))
      var_9 delete();
  }

  scripts\sp\spawner::killspawner(2);
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_alley", "alley_color");
  scripts\engine\utility::flag_set("alley_ai_spawned");
  scripts\engine\utility::flag_wait("ready_to_cross_street");
  thread murderhole_enemy_counter();
  thread street_cross_handler();
  scripts\engine\utility::flag_wait("right_side_ready_to_cross");
  level notify("turn_off_upstairs_guy");

  if(isDefined(var_5))
    var_5 scripts\engine\utility::trigger_off();

  if(isDefined(var_6))
    var_6 scripts\engine\utility::trigger_off();

  scripts\engine\utility::flag_wait("murderhole_breach_save_point");
}

mh_building_door_handler() {
  level.mh_building_door = scripts\sp\door::get_interactive_door("murderhole_bldg_door");
  level.mh_building_door.lockedforai = 1;
  level.mh_building_door scripts\game\sp\door::remove_door_snake_cam_ability();
  level.mh_building_door.script_max_left_angle = 120;
  level.mh_building_door.script_max_right_angle = 120;
  level.mh_building_door scripts\sp\door::init_max_yaws();
  level.mh_building_door.lockedforai = 1;
  level.mh_building_door thread scripts\sp\utility::door_ai_allowed(0);
  scripts\engine\utility::flag_wait("murderhole_breach_save_point");
  level.mh_building_door thread scripts\sp\utility::door_ai_allowed(1);
}

alley_bldg_door_handler() {
  var_0 = scripts\sp\door::get_interactive_door("alley_bldg_door");
  var_0.script_max_left_angle = 100;
  var_0.script_max_right_angle = 100;
  var_0 scripts\sp\door::init_max_yaws();
}

murderhole_breach_main() {
  setsaveddvar("TLOLRMSL", 1);
  thread scripts\sp\maps\marines\marines_utility.gsc::transient_waittill("get_to_mgs", "marines_hospital_fake_geo_tr", ["marines_hospital_geo_tr", "marines_lobby_geo_tr", "marines_groundfloor_geo_tr"]);
  thread scripts\sp\maps\marines\marines_utility.gsc::propane_rockets_init();
  thread stairs_climb_third_floor_dialogue_handler();
  thread murderhole_1_manager();
  thread scripts\sp\maps\marines\marines_background.gsc::background_outside_murderhouse_allies_cleanup();
  level.autosave_proximity_check = undefined;
  level.manpile_monitor.maximum = 12;
  level.manpile_monitor.ideal = 8;
  level.manpile_monitor.safe_delete_distance = 1000;
  level.manpile_monitor.maximum_weapons = 16;
  scripts\sp\spawner::killspawner(3);
  scripts\sp\spawner::killspawner(5);
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_MH_breach");
  thread mg_double_doors_handler();
  waitframe();
  thread alley_guy_cleanup();
  thread disable_marines_backtrack_color();
  thread marine_disarm_nag();
  thread marine_set_pacifist();
  thread first_floor_lookup_handler();
  thread interior_dof_monitor();
  thread kitchen_ambush();
  thread kitchen_smoke_handler();
  thread kitchen_smoke_monitor();
  thread first_floor_clear_dialogue_handler();
  thread first_floor_stairs_climbing_dialogue_handler();
  thread marine_teleport_handler();
  thread marines_catchup_to_building();
  thread mh_encounter_handler();
  thread save_at_mh_building();
  thread second_floor_lookup_handler();
  thread stair_blocking_marine_handler();
  thread weapon_clip_delete();
  thread mghouse_tripwire_monitor();
  thread deletables_wait_convoy_ambush();
  thread civ_dialogue_handler();
  thread retreat_window_glass_shatter();
  thread mg_breach_no_pistol();
  thread scripts\sp\maps\marines\marines_utility.gsc::spawn_corpses("murderhole_house_dead_mom", "flag_lobby_entered", ::murderhole_house_dead_mom);
  thread stairs_tripwire_approach_call();
  thread murderhole_breach_clear_griggs_smokes();
  scripts\engine\sp\utility::battlechatter_on("axis");
  scripts\engine\sp\utility::battlechatter_off("allies");
  scripts\engine\utility::flag_wait("marine_dont_shoot");
  thread player_bedroom_clear_handler();
  thread marine_bedroom_clear_handler();
  level.manpile_monitor.maximum = 8;
  level.manpile_monitor.ideal = 6;
  level.manpile_monitor.safe_delete_distance = 2000;
  level.manpile_monitor.maximum_weapons = 7;
  thread scripts\sp\maps\marines\marines_gameplay_convoy.gsc::vehicle_cleanup_handler();
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("g");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }

  scripts\engine\utility::flag_wait_any("mg_guys_dead", "flag_retreat_spawn_initial_aq");
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::mh_house_exit_door_blocker_clear_path();
  level notify("cleanup_starting");
  scripts\sp\spawner::killspawner(0);
  scripts\sp\spawner::killspawner(1);
  scripts\sp\spawner::killspawner(2);
  scripts\sp\spawner::killspawner(3);
  scripts\sp\spawner::killspawner(4);
  scripts\sp\spawner::killspawner(5);
  scripts\sp\spawner::killspawner(6);
  scripts\sp\spawner::killspawner(7);
  var_4 = [];
  var_4 = scripts\engine\sp\utility::get_living_ai_array("ally_marine", "script_noteworthy");

  foreach(var_2 in var_4) {
    if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "g")
      var_2 delete();

    if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "p")
      var_2 delete();
  }

  var_4 = [];
  var_4 = scripts\engine\sp\utility::get_living_ai_array("IED_dead_marine", "targetname");
  scripts\engine\utility::array_delete(var_4);
  var_4 = [];
  var_4 = scripts\engine\sp\utility::get_living_ai_array("murderhole_sniped_marine", "targetname");
  scripts\engine\utility::array_delete(var_4);
  scripts\engine\sp\utility::activate_trigger("marines_move_to_retreat", "targetname");
}

murderhole_start() {
  scripts\engine\sp\utility::set_start_location("start_murderhole", [level.player]);
  scripts\engine\utility::flag_set("checkpoint_jumped_to_MH");
  level.griggs = scripts\sp\maps\marines\marines_utility.gsc::setup_named_ai("griggs", "Sgt. Griggs", "start_murderhole_griggs", undefined, undefined, undefined, "Demon 1-2");
  scripts\engine\sp\utility::activate_trigger("streets_start_volume", "targetname");
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::disable_retreat_exterior_triggers();
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::mh_house_exit_door_blocker_block_path();
}

murderhole_catchup() {
  scripts\engine\utility::flag_set("mg_intro_complete");
  scripts\engine\utility::flag_set("murderhole_end");
  scripts\engine\utility::flag_set("right_street_save");
  thread scripts\sp\maps\marines\marines_utility.gsc::leaving_area_dialogue_monitor();
  thread murderhole_clean_up_corpses();
  thread track_if_player_throw_smokes();
  thread scripts\sp\maps\marines\marines_lighting.gsc::sun_adjustments_murderhole_building();
  level.griggs_can_smoke_nag = 1;
  level.griggs.disableplayeradsloscheck = 0;
  level.griggs.ignoreplayersuppressionlines = 0;
}

alley_start() {
  scripts\engine\sp\utility::set_start_location("start_alley", [level.player]);
  var_0 = getspawnerarray("ally_marine_alley");
  thread scripts\sp\maps\marines\marines_utility.gsc::marines_checkpoint_forcespawn_allies(var_0);
  level.mg_damage_owner = getspawner("ghost_actor", "targetname") scripts\engine\sp\utility::spawn_ai();
  level.org = getEnt("org_bullet", "targetname");
  var_1 = scripts\engine\utility::getStructArray("mg_target_1", "targetname");
  level.org thread scripts\sp\maps\marines\marines_utility.gsc::mg_gunner("iw8_ar_akilo47_marines_streets", var_1, scripts\sp\maps\marines\marines_utility.gsc::mg_damage_smoke_nag_streets, undefined, "mg_intro_complete", getEnt("mg_house_mg1_suppression", "targetname"));
  level.griggs = scripts\sp\maps\marines\marines_utility.gsc::setup_named_ai("griggs", "Sgt. Griggs", "start_alley_griggs", undefined, undefined, undefined, "Demon 1-2");
  var_2 = getnode("griggs_start_node", "targetname");
  level.griggs setgoalnode(var_2);
  thread scripts\sp\maps\marines\marines_utility.gsc::ally_equipment_backpack(level.griggs, "smoke_tall");
  thread death_hint_watcher_marines_mg_death();
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::disable_retreat_exterior_triggers();
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::mh_house_exit_door_blocker_block_path();
  thread player_shooting_murderholes_monitor();
}

alley_catchup() {
  level.player.participation = level.friendlyfire["max_participation"];
  scripts\engine\utility::flag_set("flag_underbarrel_grenade_launcher_used");
  scripts\engine\utility::flag_set("right_street_save");
}

murderhole_breach_start() {
  scripts\engine\sp\utility::set_start_location("start_murderhole_breach", [level.player]);
  var_0 = getspawnerarray("ally_marine_MH_breach");
  thread scripts\sp\maps\marines\marines_utility.gsc::marines_checkpoint_forcespawn_allies(var_0);
  level.org = getEnt("org_bullet", "targetname");
  level.org.dummy_target = (-1191, -18, 104);
  thread mh_building_door_handler();
  scripts\engine\sp\utility::activate_trigger("MH_bldg_color", "targetname");
  level.griggs = scripts\sp\maps\marines\marines_utility.gsc::setup_named_ai("griggs", "Sgt. Griggs", "start_murderhole_breach_griggs", undefined, undefined, undefined, "Demon 1-2");
  level.mg_damage_owner = getspawner("ghost_actor", "targetname") scripts\engine\sp\utility::spawn_ai();
  level.org = getEnt("org_bullet", "targetname");
  var_1 = scripts\engine\utility::getStructArray("mg_target_1", "targetname");
  level.org thread scripts\sp\maps\marines\marines_utility.gsc::mg_gunner("iw8_ar_akilo47_marines_streets", var_1, scripts\sp\maps\marines\marines_utility.gsc::mg_damage_smoke_nag_streets, undefined, "mg_intro_complete", getEnt("mg_house_mg1_suppression", "targetname"));
  level.org2 = spawn("script_origin", (564.5, 3521.2, 490));
  level.org2.angles = level.org2.angles + (0, -90, 0);
  var_1 = scripts\engine\utility::getStructArray("mg_target_2", "targetname");
  level.org2 thread scripts\sp\maps\marines\marines_utility.gsc::mg_gunner("iw8_ar_akilo47_marines_streets", var_1, scripts\sp\maps\marines\marines_utility.gsc::mg_damage_smoke_nag_streets, undefined, "mg_intro_complete", getEnt("mg_house_mg2_suppression", "targetname"), undefined, undefined, 120);
  thread scripts\sp\maps\marines\marines_utility.gsc::ally_equipment_backpack(level.griggs, "smoke_tall");
  thread death_hint_watcher_marines_mg_death();
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::disable_retreat_exterior_triggers();
  thread scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::mh_house_exit_door_blocker_block_path();
  thread player_shooting_murderholes_monitor();
}

murderhole_breach_catchup() {
  thread move_stairwell_blocker();
  thread weapon_clip_delete();
  thread deletables_convoy_ambush();
  thread retreat_window_glass_shatter();
  thread scripts\sp\maps\marines\marines_gameplay_convoy.gsc::vehicle_cleanup_handler();
  thread interior_dof_monitor();
  thread mg_double_doors_handler();
  scripts\engine\utility::flag_set("flag_retreat_bombardment_start");
  scripts\engine\utility::flag_set("player_ready_for_marine");
  scripts\engine\utility::flag_set("alex_civ_dialogue");
  scripts\engine\utility::flag_set("mg_team_alerted");
  scripts\engine\utility::flag_set("mg_guys_dead");
  setsaveddvar("TLOLRMSL", 1);
}

retreat_window_glass_shatter() {
  var_0 = getglassarray("retreat_exit_windows");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && !isglassdestroyed(var_2))
      destroyglass(var_2);
  }
}

stairs_climb_third_floor_dialogue_handler() {
  scripts\engine\utility::flag_wait("stairs_climbing_third_floor");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_mhbreach_alex_staircase_dialogue();
}

murderhole_1_manager() {
  scripts\engine\utility::flag_wait("get_to_mgs");
  scripts\sp\maps\marines\marines_utility.gsc::autosave();
  level notify("marines_ceasefire");
  scripts\engine\utility::flag_set("get_to_mgs");
}

track_player_smoke_grenade() {
  self endon("death");
  self endon("smoke_grenade_success");
  var_0 = getEnt("smoke_grenade_volume", "targetname");

  for(;;) {
    level.player waittill("grenade_fire", var_1, var_2);

    if(!isDefined(var_1)) {
      return;
    }
    if(!isDefined(var_2.basename)) {
      return;
    }
    if(var_2.basename == "smoke_tall") {
      var_1 waittill("explode", var_3);

      if(ispointinvolume(var_3, var_0)) {
        scripts\engine\utility::flag_set("smoke_grenade_success");
        thread scripts\sp\maps\marines\marines_vo.gsc::vo_murderhole_alex_throws_smokes_dialogue();
        self notify("smoke_grenade_success");
      } else
        self notify("smoke_grenade_fail");
    }

    wait 1.0;
  }
}

squad_to_alley() {
  scripts\engine\utility::waittill_any("smoke_grenade_success", "smoke_timeout");
  scripts\engine\utility::flag_set("flag_griggs_exit_anim");
  scripts\engine\utility::flag_set("murderhole_spawn");
  scripts\engine\utility::flag_set("obj_update_to_gate");
  scripts\engine\utility::flag_set("smoke_timeout");
}

alley_track_player_smoke_grenade() {
  var_0 = getEnt("alley_smoke_grenade_volume", "targetname");

  for(;;) {
    level.player waittill("grenade_fire", var_1, var_2);

    if(!isDefined(var_1)) {
      return;
    }
    if(!isDefined(var_2.basename)) {
      return;
    }
    if(var_2.basename == "smoke_tall") {
      var_1 waittill("explode", var_3);

      if(ispointinvolume(var_3, var_0))
        self notify("alley_smoke_grenade_success");
      else
        self notify("alley_smoke_grenade_fail");
    }

    wait 1.0;
  }
}

alley_smoke_handler() {
  while(!scripts\engine\utility::flag("murderhole_breach_save_point")) {
    self waittill("alley_smoke_grenade_success");
    scripts\engine\utility::flag_set("set_MH_trigger");
    wait 15;
    scripts\engine\utility::flag_clear("set_MH_trigger");
    waitframe();
  }
}

check_if_throwing_smoke() {
  while(!scripts\engine\utility::flag("murderhole_breach_save_point")) {
    if(!scripts\engine\utility::flag("nag_temporarily_disabled")) {
      level.player waittill("grenade_fire", var_0, var_1);

      if(!isDefined(var_0)) {
        return;
      }
      if(!isDefined(var_1.basename)) {
        return;
      }
      scripts\engine\utility::flag_set("nag_temporarily_disabled");
      wait 15;
      scripts\engine\utility::flag_clear("nag_temporarily_disabled");
    }

    waitframe();
  }
}

marines_catchup_to_building() {
  scripts\engine\utility::flag_wait("kitchen_trigger");
  scripts\engine\utility::flag_set("enough_enemies_killed");

  if(isDefined(level.murderhole_enemies)) {
    foreach(var_1 in level.murderhole_enemies) {
      if(isDefined(var_1))
        var_1 kill();
    }
  }

  scripts\engine\sp\utility::trigger_wait_targetname("right_interior2_color_trigger");
  scripts\sp\maps\marines\marines_utility.gsc::marines_autosave([level.org, level.org2]);
}

mh_encounter_handler() {
  level.mg_guys_final_volume = getEnt("mg_guys_final_volume", "targetname");
  level.balcony_vol_1 = getEnt("balcony_vol_1", "targetname");
  level.mh_hallway_monitor = getEnt("MH_hallway_monitor", "targetname");
  var_0 = scripts\engine\utility::getStruct("civ_corpse_struct", "targetname");
  scripts\engine\utility::flag_wait("marine_dont_shoot");
  thread clean_streets_enemies();
  var_1 = getaiarray("allies");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_forcecolor) && var_3.script_forcecolor == "r")
      level.custom_marine = var_3;
  }

  if(isDefined(level.mg_damage_owner))
    level.mg_damage_owner delete();

  wait 1;
  thread mg_house_gunner_1_init();
  thread mg_house_gunner_2_init();
  thread mg_house_patroller_init();
  thread mg_house_windowguy_init();
}

street_cross_handler() {
  scripts\engine\utility::flag_wait("ready_to_cross_street");
  thread griggs_move_up();
}

smoke_check() {
  return istrue(level.smoke_thrown);
}

smoke_nag() {
  return istrue(level.smoke_nag);
}

grenade_swap_clear() {
  return istrue(level.grenade_swap);
}

spawn_murderhole_with_dialogue() {
  level.mg_damage_owner = getspawner("ghost_actor", "targetname") scripts\engine\sp\utility::spawn_ai();
  level.org = getEnt("org_bullet", "targetname");
  var_0 = scripts\engine\utility::getStructArray("mg_target_1", "targetname");
  level.org thread scripts\sp\maps\marines\marines_utility.gsc::mg_gunner("iw8_ar_akilo47_marines_streets", var_0, scripts\sp\maps\marines\marines_utility.gsc::mg_damage_smoke_nag_streets, scripts\sp\maps\marines\marines_utility.gsc::mg_intro_sequence_streets, "mg_intro_complete", getEnt("mg_house_mg1_suppression", "targetname"));
  thread clean_fake_actors();
  thread marine01_check_if_in_position();
  thread marine03_check_if_in_position();
  thread player_shooting_murderholes_monitor();
  wait 0.5;
  scripts\engine\utility::flag_set("check_if_marines_at_node");
  wait 5.0;
  thread smoke_timeout_handler();

  if(!scripts\engine\utility::flag("flag_griggs_exit_anim"))
    thread smoke_hint_handler();
}

smoke_hint_handler() {
  level endon("flag_griggs_exit_anim");
  wait 2.0;

  if(level.player getammocount(getcompleteweaponname("smoke_tall")) > 0) {
    scripts\engine\sp\utility::display_hint_forced("smoke_hint");
    wait 7.0;
    level.smoke_thrown = 1;
  } else if(level.griggs.support_equipment > 0)
    scripts\engine\sp\utility::display_hint("smoke_nag", 5);
}

mg_house_gunner_1_init() {
  var_0 = getspawner("mg_house_gunner_1_spawner", "targetname");
  level.mg_house_gunner_1 = var_0 scripts\engine\sp\utility::spawn_ai();
  var_1 = scripts\sp\utility::make_weapon("iw8_lm_pkilo");
  level.mg_house_gunner_1 scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
  level.mg_house_gunner_1.no_pistol_switch = 1;
  level.mg_house_gunner_1.sidearm = isundefinedweapon();
  level.mg_house_gunner_1.sidearm = "none";
  level.mg_house_gunner_1 thread mg_team_alert_monitor();
  var_2 = getEnt("mg_house_gunner_1_target", "targetname");
  level.mg_house_gunner_1 mg_guy_shared_behavior(var_2);
}

mg_house_gunner_2_init() {
  var_0 = getspawner("mg_house_gunner_2_spawner", "targetname");
  level.mg_house_gunner_2 = var_0 scripts\engine\sp\utility::spawn_ai();
  var_1 = scripts\sp\utility::make_weapon("iw8_lm_pkilo");
  level.mg_house_gunner_2 scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
  level.mg_house_gunner_2.no_pistol_switch = 1;
  level.mg_house_gunner_2.sidearm = isundefinedweapon();
  level.mg_house_gunner_2.sidearm = "none";
  level.mg_house_gunner_2 thread mg_team_alert_monitor();
  var_2 = getEnt("mg_house_gunner_2_target", "targetname");
  level.mg_house_gunner_2 mg_guy_shared_behavior(var_2);
}

mg_house_patroller_init() {
  var_0 = getspawner("mg_house_patroller_spawner", "targetname");
  level.mg_house_patroller = var_0 scripts\engine\sp\utility::spawn_ai();
  var_1 = scripts\sp\utility::make_weapon("iw8_lm_pkilo");
  level.mg_house_patroller scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
  level.mg_house_patroller.no_pistol_switch = 1;
  level.mg_house_patroller.sidearm = isundefinedweapon();
  level.mg_house_patroller.sidearm = "none";
  level.mg_house_patroller thread mg_team_alert_monitor();
  var_2 = getEnt("mg_house_patroller_target", "targetname");
  level.mg_house_patroller mg_guy_shared_behavior(var_2);
}

mg_house_windowguy_init() {
  var_0 = getspawner("mg_house_windowguy_spawner", "targetname");
  level.mg_house_windowguy = var_0 scripts\engine\sp\utility::spawn_ai();
  var_1 = scripts\sp\utility::make_weapon("iw8_lm_pkilo");
  level.mg_house_windowguy scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
  level.mg_house_windowguy.no_pistol_switch = 1;
  level.mg_house_windowguy.sidearm = isundefinedweapon();
  level.mg_house_windowguy.sidearm = "none";
  level.mg_house_windowguy thread mg_team_alert_monitor(0);
  var_2 = getEnt("mg_house_windowguy_target", "targetname");
  level.mg_house_windowguy mg_guy_shared_behavior(var_2);
}

mg_guy_shared_behavior(var_0) {
  self endon("death");
  level.window_final_vol = getEnt("window_final_vol", "targetname");
  level.gunner1_final_vol = getEnt("gunner1_final_vol", "targetname");
  level.gunner2_final_vol = getEnt("gunner2_final_vol", "targetname");
  level.patroller_final_vol = getEnt("patroller_final_vol", "targetname");
  self setentitytarget(var_0);
  childthread notify_whizby_from_player();
  thread mg_start_shooting_monitor();
  self.baseaccuracy = 1;
  self.ignoreme = 1;
  scripts\engine\utility::flag_wait_any("mg_team_alerted", "alert_mg");
  self.baseaccuracy = 0.75;
  self.ignoreme = 0;
  level notify("mg_ceasefire");

  if(scripts\engine\utility::flag("alert_mg"))
    wait(randomfloatrange(0.5, 1.5));

  if(isalive(self)) {
    self clearentitytarget();
    self getenemyinfo(level.player);

    if(self == level.mg_house_windowguy && isalive(self))
      self setgoalvolumeauto(level.window_final_vol);

    if(self == level.mg_house_gunner_2 && isalive(self))
      self setgoalvolumeauto(level.gunner2_final_vol);

    if(self == level.mg_house_gunner_1 && isalive(self))
      self setgoalvolumeauto(level.gunner1_final_vol);

    if(self == level.mg_house_patroller && isalive(self))
      self setgoalvolumeauto(level.patroller_final_vol);
  }
}

mg_start_shooting_monitor() {
  var_0 = getEnt("MG_shooting_monitor", "targetname");

  while(!scripts\engine\utility::flag("mg_team_alerted")) {
    if(level.player istouching(var_0))
      scripts\engine\sp\utility::disable_dontevershoot();
    else
      scripts\engine\sp\utility::enable_dontevershoot();

    waitframe();
  }

  scripts\engine\sp\utility::disable_dontevershoot();
}

mg_team_destination_handler() {
  scripts\engine\utility::flag_wait("mg_team_alerted");
  wait 0.5;

  if(isalive(level.mg_house_windowguy)) {
    while(isalive(level.mg_house_windowguy)) {
      if(level.player istouching(level.mh_hallway_monitor)) {
        level.mg_house_windowguy cleargoalvolume();
        level.mg_house_windowguy setgoalvolumeauto(level.balcony_vol_1);
      } else {
        level.mg_house_windowguy cleargoalvolume();
        level.mg_house_windowguy setgoalvolumeauto(level.window_final_vol);
      }

      wait 1.0;
    }
  } else {
    while(isalive(level.mg_house_gunner_2)) {
      if(level.player istouching(level.mh_hallway_monitor)) {
        level.mg_house_gunner_2 cleargoalvolume();
        level.mg_house_gunner_2 setgoalvolumeauto(level.balcony_vol_1);
      } else {
        level.mg_house_gunner_2 cleargoalvolume();
        level.mg_house_gunner_2 setgoalvolumeauto(level.gunner2_final_vol);
      }

      wait 1.0;
    }
  }
}

alley_guy_cleanup() {
  var_0 = scripts\engine\sp\utility::get_living_ai("upstairs_guy", "targetname");
  scripts\engine\utility::flag_wait("tripwire_warning");

  if(isDefined(var_0))
    var_0 delete();
}

mg_team_alert_monitor(var_0) {
  scripts\engine\utility::flag_wait("player_ready_for_marine");
  scripts\engine\utility::waittill_any("damage", "pain", "death", "player_spotted", "enemy_visible");
  scripts\engine\utility::flag_set("mg_team_alerted");

  if(isDefined(var_0)) {
    if(var_0)
      self.ignoreme = 1;
    else
      self.ignoreme = 0;
  }
}

marine_set_pacifist() {
  thread marine_mg_dialogue();
  scripts\engine\utility::flag_wait("mg_team_alerted");
  scripts\engine\sp\utility::activate_trigger_with_targetname("marine_to_window");
  thread mg_cleanup();
  scripts\engine\utility::flag_wait("mg_guys_dead");
  var_0 = getEntArray("MH_upstairs_color", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 scripts\engine\utility::trigger_off();
}

notify_whizby_from_player() {
  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(scripts\engine\utility::is_equal(var_0, level.player))
      scripts\engine\utility::flag_set("mg_team_alerted");
  }
}

marine_mg_dialogue() {
  scripts\engine\utility::flag_wait_all("marine_ready_to_fight", "player_ready_for_marine");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_mhbreach_marine_clear_dialogue();
}

ied_pinned_marine_handler() {
  level.pinned_marine = scripts\engine\sp\utility::spawn_targetname("IED_dead_marine");
  level.pinned_marine.animname = "marine02";
  level.pinned_marine.dropweapon = 0;
  level.pinned_marine.health = 1;
  level.pinned_marine.skipdeathanim = 1;
  level.pinned_marine scripts\engine\sp\utility::set_allowdeath(1);
  level.pinned_marine thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
  level.pinned_marine scripts\common\ai::gun_remove();
  var_0 = scripts\engine\utility::getStruct("ied_scene", "targetname");

  if(isDefined(level.pinned_marine) && isalive(level.pinned_marine))
    var_0 scripts\common\anim::anim_single_solo(level.pinned_marine, "ambush_ied");

  if(isDefined(level.pinned_marine) && isalive(level.pinned_marine))
    var_0 scripts\common\anim::anim_loop_solo(level.pinned_marine, "ambush_ied_idle");
}

ied_vignette_handler() {
  var_0 = scripts\engine\utility::getStruct("griggs_blindfire_struct", "targetname");
  var_1 = getnode("griggs_start_node", "targetname");
  level.griggs.ignoreme = 1;
  scripts\engine\utility::flag_wait("griggs_at_mg_cover_node");
  level.griggs.ignoreme = 0;
  scripts\engine\utility::flag_wait("check_if_marines_at_node");
  wait 1;

  if(!scripts\engine\utility::flag("mg_intro_complete")) {
    if(scripts\engine\utility::is_equal(var_1, level.griggs.node))
      var_0 thread scripts\common\anim::anim_single_solo(level.griggs, "blindfire");
  }
}

autosave_after_shellshock() {
  wait 5.0;
  scripts\sp\maps\marines\marines_utility.gsc::autosave();
}

clean_fake_actors() {
  var_0 = [];
  var_0 = scripts\engine\sp\utility::get_living_ai_array("fake_actor", "script_noteworthy");
  scripts\engine\utility::array_delete(var_0);
}

clean_streets_enemies() {
  var_0 = [];
  var_0 = scripts\engine\sp\utility::get_living_ai_array("MH_enemy", "script_noteworthy");
  scripts\engine\utility::array_delete(var_0);
}

right_street_autosave() {
  scripts\engine\utility::flag_wait("right_street_save");
  level.org2 = spawn("script_origin", (564.5, 3521.2, 490));
  level.org2.angles = level.org2.angles + (0, -90, 0);
  var_0 = scripts\engine\utility::getStructArray("mg_target_2", "targetname");
  level.org2 thread scripts\sp\maps\marines\marines_utility.gsc::mg_gunner("iw8_ar_akilo47_marines_streets", var_0, scripts\sp\maps\marines\marines_utility.gsc::mg_damage_smoke_nag_streets, undefined, "mg_intro_complete", getEnt("mg_house_mg2_suppression", "targetname"), undefined, undefined, 120);

  while(!isDefined(level.org) || !isDefined(level.org2))
    waitframe();

  scripts\sp\maps\marines\marines_utility.gsc::marines_autosave([level.org, level.org2]);
}

smoke_timeout_handler() {
  wait 10;

  if(!scripts\engine\utility::flag("smoke_grenade_success") && !scripts\engine\utility::flag("smoke_timeout"))
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_murderhole_throw_smoke_nag_dialogue();

  wait 7;

  if(!scripts\engine\utility::flag("smoke_grenade_success") && !scripts\engine\utility::flag("smoke_timeout"))
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_murderhole_throw_smoke_nag_dialogue();

  wait 3;
  self notify("smoke_timeout");
}

griggs_move_up() {
  scripts\engine\sp\utility::activate_trigger("griggs_marines_move_up", "targetname");
  scripts\engine\utility::flag_set("check_truck_status");
  scripts\sp\maps\marines\marines_utility.gsc::marines_autosave([level.org, level.org2]);
}

save_building_autosave() {
  scripts\engine\utility::flag_wait("save_building");
  scripts\sp\maps\marines\marines_utility.gsc::marines_autosave([level.org, level.org2]);
}

activate_mh_trigger() {
  while(!scripts\engine\utility::flag("set_MH_trigger") || !scripts\engine\utility::flag("enough_enemies_killed"))
    waitframe();

  scripts\engine\utility::flag_set("stop_smoke_nag_in_streets");
  scripts\engine\utility::flag_set("nag_temporarily_disabled");
  var_0 = getEnt("ally_smoke_origin1", "targetname");
  var_1 = getEnt("ally_smoke_origin2", "targetname");
  var_2 = getEnt("ally_smoke_origin3", "targetname");
  var_3 = getEnt("ally_smoke_destination1", "targetname");
  var_4 = getEnt("ally_smoke_destination2", "targetname");
  var_5 = getEnt("ally_smoke_destination3", "targetname");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_griggs_final_smoke_dialogue();
  magicgrenade("smoke_tall", var_0.origin, var_3.origin, 2.0);
  wait 0.5;
  magicgrenade("smoke_tall", var_1.origin, var_4.origin, 2.0);
  wait 2.5;
  magicgrenade("smoke_tall", var_2.origin, var_5.origin, 2.0);
  wait 0.5;
  scripts\engine\sp\utility::activate_trigger("MH_bldg_color", "targetname");

  if(!scripts\engine\utility::flag("murderhole_breach_save_point")) {
    scripts\sp\spawner::killspawner(3);
    thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_refresh");
  }
}

activate_right_street_trigger() {
  scripts\engine\utility::flag_wait("obj_update_to_gate");
  scripts\engine\utility::flag_set("murderhole_end");
  level.smoke_thrown = 1;

  if(!scripts\engine\utility::flag("smoke_grenade_success"))
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_murderhole_marine_throws_smokes_dialogue();

  var_0 = getEnt("smoke_origin1", "targetname");
  var_1 = getEnt("smoke_origin2", "targetname");
  var_2 = getEnt("smoke_origin3", "targetname");
  var_3 = getEnt("smoke_destination1", "targetname");
  var_4 = getEnt("smoke_destination2", "targetname");
  var_5 = getEnt("smoke_destination3", "targetname");

  if(!scripts\engine\utility::flag("smoke_grenade_success")) {
    magicgrenade("smoke_tall", var_0.origin, var_3.origin, 2.0);
    wait 1.5;
  }

  scripts\engine\sp\utility::activate_trigger("alley_start_trigger", "targetname");
  magicgrenade("smoke_tall", var_0.origin, var_3.origin, 2.0);
  wait 0.5;
  magicgrenade("smoke_tall", var_1.origin, var_4.origin, 2.0);
  wait 0.5;
  magicgrenade("smoke_tall", var_2.origin, var_5.origin, 2.0);
  wait 1.5;
  level.b_smoke = 1;
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_murderhole_griggs_smoke_advance_dialogue();
  wait 9;
  level.b_smoke = 0;
}

player_shooting_murderholes_monitor() {
  level.b_murderhole_suppression_tutorialized = 0;
  getEnt("mg_house_mg1_suppression", "targetname") thread player_shooting_murderhole_monitor();
  getEnt("mg_house_mg2_suppression", "targetname") thread player_shooting_murderhole_monitor();
}

player_shooting_murderhole_monitor() {
  level endon("mg_ceasefire");
  level.i_player_shooting_murderhole_monitor_counter = 0;

  while(!scripts\engine\utility::flag("murderhole_detached")) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player && !level.b_murderhole_suppression_tutorialized && !scripts\engine\utility::flag("murderhole_detached")) {
      wait 1;
      scripts\sp\maps\marines\marines_vo.gsc::vo_murderhole_mg_dontshoot_nag_dialogue();
      level.i_player_shooting_murderhole_monitor_counter++;

      if(level.i_player_shooting_murderhole_monitor_counter % 3 == 0)
        level.i_player_shooting_murderhole_monitor_counter = 0;

      level.b_murderhole_suppression_tutorialized = 1;
      wait 10;
      level.b_murderhole_suppression_tutorialized = 0;
    }
  }
}

murderhole_enemy_behavior(var_0) {
  self endon("death");
  self endon("stop_closing");

  if(!isDefined(level.murderhole_enemies))
    level.murderhole_enemies = [];

  level.murderhole_enemies = scripts\engine\utility::array_add(level.murderhole_enemies, self);
  thread murderhole_enemy_cleanup();
  scripts\engine\sp\utility::set_attackeraccuracy(0.2);

  if(isDefined(self getgoalvolume())) {
    return;
  }
  self setgoalentity(level.player, randomintrange(2500, 10000));
  scripts\engine\sp\utility::set_goalRadius(1500);

  if(!isDefined(var_0)) {
    return;
  }
  scripts\engine\utility::flag_wait(var_0);
  scripts\engine\sp\utility::set_goalRadius(800);

  while(self.goalradius > 100) {
    wait(randomfloatrange(1, 5));
    self.goalradius = self.goalradius - 50;
  }
}

murderhole_enemy_cleanup() {
  self waittill("death");
  level.murderhole_enemies = scripts\engine\utility::array_removedead_or_dying(level.murderhole_enemies);
}

death_hint_watcher_marines_mg_death() {
  level endon("mg_ceasefire");
  level.player waittill("death", var_0);

  if(var_0 == level.mg_damage_owner)
    scripts\sp\player_death::set_custom_death_quote(401);
}

stairs_tripwire_approach_call() {
  scripts\engine\utility::flag_wait("stairs_tripwire_approached");
  thread stairs_tripwire_lookat_monitor();

  while(!scripts\engine\utility::flag("kitchen_guy_killed"))
    wait 0.1;

  wait 3;
  scripts\engine\utility::flag_wait_any("stairs_tripwire_cleared", "stairs_tripwire_lookedat");

  if(!scripts\engine\utility::flag("stairs_tripwire_cleared"))
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_mhbreach_alex_tripwire_dialogue();
}

stairs_tripwire_lookat_monitor() {
  var_0 = scripts\engine\utility::getStruct("stairwell_tripwire_lookat_ref", "targetname");

  while(!scripts\engine\utility::flag("stairs_tripwire_cleared")) {
    if(!sighttracepassed(level.player getEye(), var_0.origin, 0, level.player) || !(distance2d(level.player.origin, var_0.origin) < 300))
      scripts\engine\utility::flag_set("stairs_tripwire_lookedat");
    else
      scripts\engine\utility::flag_clear("stairs_tripwire_lookedat");

    waitframe();
  }
}

marine_disarm_nag() {
  scripts\engine\utility::flag_wait("stairs_grenade_nag");
  wait 10;

  if(!scripts\engine\utility::flag("stairs_tripwire_cleared"))
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_mhbreach_marine_defuse_nag_1_dialogue();

  wait 10;

  if(!scripts\engine\utility::flag("stairs_tripwire_cleared"))
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_mhbreach_marine_defuse_nag_2_dialogue();
}

spawn_rpg_support() {
  var_0 = getspawner("initial_support_enemy_right", "targetname");
  level.right_guy = var_0 scripts\engine\sp\utility::spawn_ai();
  var_1 = getspawner("initial_support_enemy_left", "targetname");
  level.left_guy = var_1 scripts\engine\sp\utility::spawn_ai();
  level.left_guy.ignoreme = 1;
  level.left_guy.ignoreall = 1;
  level.right_guy.ignoreme = 1;
  level.right_guy.ignoreall = 1;
  level.left_guy.baseaccuracy = 1;
  level.right_guy.baseaccuracy = 1;
  var_2 = getnode("rpg_prone_node", "targetname");
  var_3 = getEnt("rpg_vol", "targetname");
  var_4 = getnode("rpg_prone_node_2", "targetname");
  var_5 = getEnt("rpg_vol_2", "targetname");
  scripts\engine\utility::flag_wait("rpg_spawned");
  level.right_guy thread rpg_guys_attack_start(var_3, 0);
  level.left_guy thread rpg_guys_attack_start(var_5, 1.5);
  thread rpg_kill_handler();
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_marine_pinned_down_dialogue();
  var_2 disconnectnode(var_2);
  var_4 disconnectnode(var_4);
  scripts\engine\utility::flag_wait("ready_to_cross_street");

  if(isDefined(level.right_guy) && isalive(level.right_guy))
    level.right_guy.ignoreme = 0;

  if(isDefined(level.left_guy) && isalive(level.left_guy))
    level.left_guy.ignoreme = 0;

  scripts\engine\utility::flag_wait("kitchen_trigger");

  if(isDefined(level.left_guy))
    level.left_guy delete();

  if(isDefined(level.right_guy))
    level.right_guy delete();
}

rpg_guys_attack_start(var_0, var_1) {
  self endon("death");
  wait(var_1);

  if(isDefined(self) && isalive(self)) {
    self cleargoalvolume();
    self setgoalvolumeauto(var_0);
    self.ignoreall = 0;
    self getenemyinfo(level.player);
  }
}

replace_fake_actors_with_real() {
  scripts\engine\utility::waittill_any("goal", "death");
  var_0 = getspawnerarray("real_actor_swap_spawner");
  scripts\engine\sp\utility::array_spawn(var_0);
}

waittill_struct_within_fov_2(var_0, var_1) {
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

murderhole_house_dead_mom() {
  scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::setcharmodels("body_civ_syrkistan_female_1_2", "head_sc_f_eghbali_civ", undefined);
}

aq_technical_spawners() {
  var_0 = 0;
  scripts\engine\utility::flag_wait("technical_spawn");
  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname("AQ_technical_2");
  var_1.targetname = "AQ_technical_2";
  var_1 scripts\engine\sp\utility::assign_animtree("alleyTruck");
  var_1.animname = "alleyTruck";
  var_2 = getEnt("patharound_truck_2_clip", "targetname");
  var_3 = scripts\engine\utility::getStruct("technical2Struct", "targetname");
  waitframe();
  var_1 thread scripts\sp\maps\marines\marines_background.gsc::ground_vehicle_sound_handler();
  var_3 thread alleytruckdropoff(var_1, "truckDropOff", 7.5, "truck_2_reached", "truck_2_destroyed", var_2);
  var_1 thread rumble_on_death();
  var_4 = scripts\common\vehicle::spawn_vehicle_from_targetname("AQ_technical_1");
  var_4.targetname = "AQ_technical_1";
  var_4 scripts\engine\sp\utility::assign_animtree("alleyTruck2");
  var_4.animname = "alleyTruck2";
  var_5 = scripts\engine\utility::getStruct("technical1Struct", "targetname");
  waitframe();
  var_4 thread scripts\sp\maps\marines\marines_background.gsc::ground_vehicle_sound_handler();
  var_3 thread alleytruckdropoff(var_4, "truckDropOff", 6, "truck_1_reached", "truck_1_destroyed");
  var_4 thread rumble_on_death();
  wait 1.5;
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_marine_technical_arrive_dialogue();
  scripts\engine\sp\utility::activate_trigger_with_targetname("spawn_murderhole_reinforcement_wave");
  wait 2;

  if(createheadicon(level.player.currentweapon) == "iw8_ar_mike4+back_mike4+front_mike4+hybrid_west02+mag_mike4+rec_mike4+ub_mike203_sp") {
    if(!scripts\engine\utility::flag("flag_underbarrel_grenade_launcher_used")) {
      if(level.player usinggamepad())
        scripts\engine\sp\utility::display_hint("grenade_swap", 15, undefined, level, "underbarrel_grenade_launcher_equipped");
      else
        scripts\engine\sp\utility::display_hint("grenade_swap_kbm", 15, undefined, level, "underbarrel_grenade_launcher_equipped");

      thread scripts\sp\maps\marines\marines_utility.gsc::player_underbarrel_grenade_launcher_equipped_monitor();
      thread wait_and_kill_underbarrel_grenade_launcher_monitors(15);
    } else
      level notify("end_underbarrel_grenade_launcher_monitor");
  } else
    level notify("end_underbarrel_grenade_launcher_monitor");

  scripts\engine\utility::flag_set("rpg_spawned");

  while(level.murderhole_enemies.size >= 10)
    waitframe();

  scripts\engine\utility::flag_set("ready_to_cross_street");
  scripts\engine\utility::flag_wait("flag_lobby_entered");

  if(isDefined(var_4))
    var_4 delete();

  if(isDefined(var_1))
    var_1 delete();
}

alleytruckdropoff(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::getfx("vfx_vehicle_treadfx_dust");

  if(isDefined(var_0)) {
    playFXOnTag(var_6, var_0, "tag_wheel_back_left");
    playFXOnTag(var_6, var_0, "tag_wheel_back_right");
    playFXOnTag(var_6, var_0, "tag_wheel_front_left");
    playFXOnTag(var_6, var_0, "tag_wheel_front_right");
    var_0 thread truck_treadfx_health_hack(var_6);
  }

  if(isDefined(var_0)) {
    var_0 thread aq_technical_unload_watcher();
    thread scripts\common\anim::anim_single_solo(var_0, var_1);
    var_0 setanimrate(var_0 scripts\engine\utility::getanim(var_1), 1.3);
    var_0 thread truck_dead_or_alive_monitor(var_3, var_4);
  }

  wait(var_2 / 1.3);

  if(isDefined(var_5)) {
    var_5 movez(-9999, 0.5, 0.25, 0.25);
    waitframe();
    var_5 connectpaths();
  }

  if(isalive(var_0))
    var_0 stoptreadfx(var_6);

  if(isDefined(var_0))
    var_0 connectpaths();

  wait 0.5;

  if(isDefined(var_0)) {
    var_0 scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 disconnectPaths();
    var_0 scripts\common\vehicle::vehicle_unload();
  }
}

truck_treadfx_health_hack(var_0) {
  self endon("entitydeleted");
  self.health = 99999;
  self.hack_health = 2000;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_5)) {
      if(var_5 == "MOD_GRENADE_SPLASH" || var_5 == "MOD_PROJECTILE_SPLASH")
        var_1 = var_1 * 12;

      if(var_5 == "MOD_GRENADE" || var_5 == "MOD_PROJECTILE")
        var_1 = var_1 * 5;
    }

    self.hack_health = self.hack_health - var_1;

    if(self.hack_health <= 0) {
      stoptreadfx(var_0);
      waitframe();
      self kill();
      break;
    }
  }
}

stoptreadfx(var_0) {
  stopFXOnTag(var_0, self, "tag_wheel_back_left");
  stopFXOnTag(var_0, self, "tag_wheel_back_right");
  stopFXOnTag(var_0, self, "tag_wheel_front_left");
  stopFXOnTag(var_0, self, "tag_wheel_front_right");
}

final_wave_enemies() {
  var_0 = getEnt("final_wave_yard_spawn_trigger", "targetname");
  var_1 = getEnt("final_wave_MH_spawn_trigger", "targetname");
  var_2 = getEnt("final_wave_shed_spawn_trigger", "targetname");
  var_3 = getspawnerarray("murderhole_final_wave_MH");
  var_4 = getspawnerarray("murderhole_final_wave_yard");
  var_5 = getspawnerarray("murderhole_final_wave_shed");
  scripts\engine\sp\utility::array_spawn_function(var_4, ::murderhole_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_3, ::murderhole_enemy_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_5, ::murderhole_enemy_behavior);
  scripts\engine\utility::flag_wait_any("final_wave_from_yard", "final_wave_from_MH", "final_wave_from_shed");
  var_6 = getaiarray("axis");

  if(scripts\engine\utility::flag("final_wave_from_yard")) {
    if(isDefined(var_1))
      var_1 scripts\engine\utility::trigger_off();

    if(isDefined(var_2))
      var_2 scripts\engine\utility::trigger_off();

    if(var_6.size < 16)
      scripts\engine\sp\utility::array_spawn(var_4);
  } else if(scripts\engine\utility::flag("final_wave_from_shed")) {
    if(isDefined(var_1))
      var_1 scripts\engine\utility::trigger_off();

    if(isDefined(var_0))
      var_0 scripts\engine\utility::trigger_off();

    if(var_6.size < 16)
      scripts\engine\sp\utility::array_spawn(var_5);
  } else {
    if(isDefined(var_0))
      var_0 scripts\engine\utility::trigger_off();

    if(isDefined(var_2))
      var_2 scripts\engine\utility::trigger_off();

    if(var_6.size < 16)
      scripts\engine\sp\utility::array_spawn(var_3);
  }
}

aq_technical_unload_watcher() {
  self endon("death");
  scripts\engine\utility::ent_flag_wait("loaded");
  var_0 = self.riders;
  scripts\engine\utility::ent_flag_wait("unloaded");
  var_0 = scripts\engine\utility::array_removedead(var_0);

  foreach(var_2 in var_0)
  var_2 thread murderhole_enemy_behavior();
}

kitchen_ambush() {
  scripts\engine\utility::flag_wait("right_side_ready_to_cross");
  var_0 = getEnt("kitchen_volume", "targetname");
  var_1 = getEnt("target_physics_objects", "targetname");
  var_2 = scripts\engine\utility::getStruct("blindfire_anim_struct", "targetname");
  var_3 = getnode("force_ambush_node", "targetname");
  var_4 = getnode("ambusher_smoke_node", "targetname");
  var_5 = getEnt("kitchen_ambusher_goal_vol", "targetname");
  var_6 = getEnt("right_interior_color_trigger", "targetname");
  level.kitchen_guy = scripts\engine\sp\utility::spawn_targetname("kitchen_ambush_guy", 1);
  var_7 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  level.kitchen_guy scripts\anim\shared.gsc::forceuseweapon(var_7, "primary");
  level.kitchen_guy.sidearm = isundefinedweapon();
  level.kitchen_guy.sidearm = "none";
  level.kitchen_guy.ignoreall = 1;
  level.kitchen_guy scripts\engine\sp\utility::set_allowdeath(1);
  level.kitchen_guy.grenadeawareness = 0;
  var_2 thread scripts\common\anim::anim_first_frame_solo(level.kitchen_guy, "kitchen_ambush");
  scripts\engine\utility::flag_wait("kitchen_trigger");

  if(!scripts\engine\utility::flag("smoke_in_kitchen")) {
    if(isDefined(level.kitchen_guy) && isalive(level.kitchen_guy)) {
      var_2 thread scripts\common\anim::anim_single_solo(level.kitchen_guy, "kitchen_ambush");
      wait 0.5;

      if(isDefined(level.kitchen_guy) && isalive(level.kitchen_guy)) {
        level.kitchen_guy.ignoreall = 0;
        level.kitchen_guy.grenadeawareness = 1;
        level.kitchen_guy setgoalvolumeauto(var_5);
      }
    }
  } else if(isDefined(level.kitchen_guy) && isalive(level.kitchen_guy)) {
    level.kitchen_guy notify("killanimscript");
    level.kitchen_guy.ignoreall = 0;
    level.kitchen_guy.grenadeawareness = 1;
    level.kitchen_guy cleargoalvolume();
    level.kitchen_guy setgoalnode(var_4);
  }

  scripts\engine\utility::flag_wait("kitchen_guy_killed");

  if(isDefined(var_6))
    scripts\engine\sp\utility::activate_trigger_with_targetname("right_interior_color_trigger");

  thread move_stairwell_blocker();
  scripts\sp\maps\marines\marines_utility.gsc::marines_autosave([level.org, level.org2]);
}

move_stairwell_blocker() {
  var_0 = scripts\engine\utility::getStruct("kitchen_guy_blocker_struct", "targetname");
  var_1 = getEnt("kitchen_guy_blocker", "targetname");
  var_1 moveTo(var_0.origin, 0.1);
  waitframe();
  var_1 connectpaths();
}

drop_obstacle_on_death(var_0) {
  var_0 endon("entitydeleted");
  var_0 waittill("death");
  var_1 = (0, 0, 32);
  var_2 = (129, 57, 33);
  var_3 = createnavobstaclebybounds(var_1 + var_0.origin, var_2, var_0.angles);
}

murderhole_enemy_counter() {
  scripts\engine\sp\utility::waittill_dead_or_dying(level.murderhole_enemies, 7, 45);
  scripts\engine\utility::flag_set("enough_enemies_killed");
}

alley_entry_event() {
  scripts\engine\utility::flag_wait("alley_entry_event");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_murderhole_griggs_alley_dialogue();
}

ready_to_breach_dialogue() {
  scripts\engine\utility::flag_wait_any("ready_to_breach_MH", "right_side_ready_to_cross");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_mhbreach_griggs_breach_dialogue();
}

griggs_movement_to_alley() {
  scripts\engine\sp\utility::trigger_wait_targetname("alley_start_trigger");
  var_0 = scripts\engine\utility::getStruct("griggs_goto_alley_node", "targetname");
  var_1 = getnode("alley_final_griggs_node", "targetname");
  wait 0.5;
  level.griggs thread breakout_to_color(var_1);
  level.griggs thread scripts\sp\spawner::go_to_node(var_0);
}

marines_group_a_movement_to_alley() {
  var_0 = scripts\engine\utility::getStruct("cyan_goto_alley_node", "targetname");
  var_1 = getnode("alley_final_red_node_0", "targetname");
  scripts\engine\sp\utility::trigger_wait_targetname("alley_start_trigger");
  level.all_marines = getaiarray("allies");
  wait 1.0;
  var_2 = 0;

  foreach(var_4 in level.all_marines) {
    if(isDefined(var_4)) {
      if(isDefined(var_4.script_forcecolor) && var_4.script_forcecolor == "c") {
        var_5 = getnode("alley_final_cyan_node", "targetname");

        if(isDefined(var_4) && isalive(var_4)) {
          var_4 thread scripts\sp\spawner::go_to_node(var_0);
          var_4 thread breakout_to_color(var_5);
        }
      }
    }
  }

  wait 0.5;
  var_7 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("r");
  var_8 = sortbydistance(var_7, var_0.origin);

  foreach(var_4 in var_8) {
    if(isDefined(var_4) && isalive(var_4)) {
      if(isDefined(var_4.script_forcecolor) && var_4.script_forcecolor == "r") {
        var_10 = getnodesinradius((-6.988, 1388.53, 41.939), 50, 0);
        var_11 = getnodesinradius((-34.988, 1484.53, 41.939), 64, 0);

        if(var_10.size > 0 && var_11.size > 0) {
          var_12 = var_10[0];
          var_13 = var_11[0];
          var_12.script_colorlast = undefined;

          if(isDefined(var_4) && isalive(var_4)) {
            if(var_2 == 0) {
              var_4 setgoalnode(var_12);
              var_4 thread brief_color_disable();
            }

            if(var_2 == 1) {
              var_4 setgoalnode(var_13);
              var_4 thread brief_color_disable();
            }

            wait 1;
          }
        }

        if(var_2 < 1)
          var_2++;
      }
    }
  }
}

marines_group_b_movement_to_alley() {
  var_0 = scripts\engine\utility::getStruct("yellow_goto_alley_node", "targetname");
  scripts\engine\sp\utility::trigger_wait_targetname("alley_start_trigger");
  wait 1.0;
  var_1 = 0;

  foreach(var_3 in level.all_marines) {
    if(isDefined(var_3)) {
      wait 0.25;

      if(isDefined(var_3.script_forcecolor) && var_3.script_forcecolor == "g") {
        var_4 = getnode("alley_final_green_node_" + var_1, "targetname");

        if(isDefined(var_3) && isalive(var_3)) {
          var_5 = scripts\engine\utility::getStruct("green_goto_alley_node_" + var_1, "targetname");
          var_3 thread scripts\sp\spawner::go_to_node(var_5);
          var_3 thread breakout_to_color(var_4);

          if(var_1 < 1)
            var_1++;
        }
      }
    }

    if(isDefined(var_3)) {
      wait 0.25;

      if(isDefined(var_3.script_forcecolor) && var_3.script_forcecolor == "y") {
        var_6 = getnode("alley_final_yellow_node", "targetname");

        if(isDefined(var_3) && isalive(var_3)) {
          var_3 thread scripts\sp\spawner::go_to_node(var_0);
          var_3 thread breakout_to_color(var_6);
        }
      }
    }
  }
}

breakout_to_color(var_0) {
  self endon("reached_path_end");
  scripts\engine\utility::waittill_any("pain", "damage");

  if(isDefined(self) && isalive(self)) {
    if(!scripts\engine\utility::flag("ambush_start"))
      self setgoalnode(var_0);
  }
}

deletables_convoy_ambush() {
  var_0 = getEntArray("deletable_convoy_ambush", "targetname");

  foreach(var_2 in var_0)
  var_2 hide();
}

deletables_wait_convoy_ambush() {
  scripts\engine\sp\utility::trigger_wait_targetname("staircase_up_trigger");
  deletables_convoy_ambush();
}

murderhole_clean_up_corpses() {
  scripts\engine\sp\utility::trigger_wait_targetname("murderhole_lighting_trigger");
  var_0 = getcorpsearray();
  var_1 = getEntArray("murderhole_lighting_watcher", "targetname");
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 2;
  var_8 = 1250;
  var_9 = 2000;

  foreach(var_11 in var_0) {
    if(isDefined(var_11)) {
      var_12 = 0;

      foreach(var_14 in var_1) {
        if(var_11 istouching(var_14)) {
          var_2++;
          var_11 delete();
          var_12 = 1;
          break;
        }
      }

      if(var_12) {
        continue;
      }
      var_16 = distance(level.player.origin, var_11.origin);
      var_4++;
      var_5 = var_5 + var_16;

      if(var_16 > var_9) {
        var_3++;
        var_11 delete();
      } else if(var_16 > var_8) {
        var_6++;

        if(var_6 == var_7) {
          var_3++;
          var_11 delete();
          var_6 = 0;
        }
      }
    }
  }
}

kitchen_magicbullet() {
  var_0 = getEnt("kitchen_ambush_origin", "targetname");
  var_1 = 0;

  while(var_1 <= 10) {
    if(!isDefined(level.kitchen_guy) || !isalive(level.kitchen_guy)) {
      level.kitchen_guy scripts\engine\sp\utility::anim_stopanimScripted();
      var_1 = 10;
    }

    var_2 = distance2d(level.kitchen_guy.origin, level.player.origin) / 10;
    var_3 = distance2d(level.kitchen_guy.origin, level.player.origin) / 10;
    var_4 = distance2d(level.kitchen_guy.origin, level.player.origin) / 10;
    magicbullet("iw8_ar_akilo47", var_0.origin, level.player.origin + (var_2, var_3, var_4));
    var_1 = var_1 + 1;
    wait 0.15;
  }
}

marine_house_color_handler() {
  while(!scripts\engine\utility::flag("ready_to_cross_street"))
    scripts\engine\sp\utility::activate_trigger_with_targetname("first_floor_color_trigger");
}

mg_cleanup() {
  scripts\engine\utility::flag_clear("kill_mg_gunners");
  waitframe();
  scripts\engine\utility::flag_wait("kill_mg_gunners");

  if(isalive(level.mg_house_gunner_1))
    level.mg_house_gunner_1 kill();

  if(isalive(level.mg_house_gunner_2))
    level.mg_house_gunner_2 kill();

  if(isalive(level.mg_house_windowguy))
    level.mg_house_windowguy kill();

  if(isalive(level.mg_house_patroller))
    level.mg_house_patroller kill();
}

yard_enemy_handler() {
  var_0 = getEnt("enemy_at_yard_vol", "targetname");
  var_1 = getEnt("mh_door_volume", "targetname");
  var_2 = getEnt("yard_color_monitor", "targetname");
  var_3 = getEnt("player_monitor_yard", "targetname");
  var_4 = getspawnerarray("yard_initial_enemy");
  scripts\engine\sp\utility::array_spawn_function(var_4, ::murderhole_enemy_behavior);
  scripts\engine\sp\utility::wait_for_targetname_trigger("yard_color_monitor");
  var_5 = getaiarray("axis");

  if(!scripts\engine\utility::flag("final_wave_from_yard") && !scripts\engine\utility::flag("final_wave_from_shed") && var_5.size < 18) {
    var_6 = scripts\engine\sp\utility::array_spawn(var_4);

    while(!scripts\engine\utility::flag("murderhole_breach_right")) {
      if(level.player istouching(var_3)) {
        foreach(var_8 in var_6) {
          if(isDefined(var_8) && isalive(var_8))
            var_8 setgoalvolumeauto(var_0);
        }
      } else {
        foreach(var_8 in var_6) {
          if(isDefined(var_8) && isalive(var_8))
            var_8 setgoalvolumeauto(var_1);
        }
      }

      wait 0.1;
    }
  }
}

cqb_player_movement_monitor() {
  var_0 = getEntArray("MH_player_cqb_monitor", "targetname");

  while(!scripts\engine\utility::flag("mg_team_alerted")) {
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(level.player istouching(var_3))
        var_1 = 1;
    }

    if(var_1 == 1)
      scripts\sp\player::player_movement_state("cqb");

    if(var_1 == 0)
      scripts\sp\player::player_movement_state("default");

    wait 0.1;
  }

  scripts\sp\player::player_movement_state("default");
}

cqb_marines_movement_monitor() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "r")
      var_2 player_stayahead_enemy_behavior();

    if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "c")
      var_2 player_stayahead_enemy_behavior();

    if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "y")
      var_2 player_stayahead_enemy_behavior();
  }

  var_4 = getEntArray("MH_marines_cqb_monitor", "targetname");

  while(!scripts\engine\utility::flag("mg_team_alerted")) {
    var_5 = 0;

    foreach(var_7 in var_4) {
      if(level.player istouching(var_7))
        var_5 = 1;
    }

    if(var_5 == 1) {
      var_0 = getaiarray("allies");

      foreach(var_2 in var_0) {
        if(isalive(var_2)) {
          if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "r" && isDefined(var_2.asmname))
            var_2 scripts\common\utility::demeanor_override("cqb");

          if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "c" && isDefined(var_2.asmname))
            var_2 scripts\common\utility::demeanor_override("cqb");

          if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "y" && isDefined(var_2.asmname))
            var_2 scripts\common\utility::demeanor_override("cqb");
        }
      }
    }

    if(var_5 == 0) {
      var_0 = getaiarray("allies");

      foreach(var_2 in var_0) {
        if(isalive(var_2)) {
          if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "r" && isDefined(var_2.asmname))
            var_2 scripts\common\utility::demeanor_override("combat");

          if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "c" && isDefined(var_2.asmname))
            var_2 scripts\common\utility::demeanor_override("combat");

          if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "y" && isDefined(var_2.asmname))
            var_2 scripts\common\utility::demeanor_override("combat");
        }
      }
    }

    wait 0.1;
  }

  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "r" && isDefined(var_2.asmname))
        var_2 scripts\common\utility::demeanor_override("combat");

      if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "c" && isDefined(var_2.asmname))
        var_2 scripts\common\utility::demeanor_override("combat");

      if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "y" && isDefined(var_2.asmname))
        var_2 scripts\common\utility::demeanor_override("combat");
    }
  }
}

first_floor_lookup_handler() {
  var_0 = getnode("look_up_anim_goal_node", "targetname");
  var_1 = scripts\engine\utility::getStruct("mh_second_floor_poi", "targetname");
  scripts\engine\utility::flag_wait("look_up_anim_flag");
  var_2 = getaiarray("allies");

  foreach(var_4 in var_2) {
    waitframe();

    if(isDefined(var_4.script_forcecolor) && var_4.script_forcecolor == "r") {
      if(scripts\engine\utility::is_equal(var_0, var_4.node)) {
        var_4 scripts\common\ai::poi_enable(1, var_1);
        var_4 thread waittill_color_change("MH_cleanup_trigger");
      }
    }
  }
}

second_floor_lookup_handler() {
  var_0 = getnode("mh_third_floor_node", "targetname");
  var_1 = scripts\engine\utility::getStruct("mh_third_floor_poi", "targetname");
  scripts\engine\utility::flag_wait("third_floor_look_up_anim_flag");
  var_2 = getaiarray("allies");

  foreach(var_4 in var_2) {
    waitframe();

    if(isDefined(var_4.script_forcecolor) && var_4.script_forcecolor == "y") {
      if(scripts\engine\utility::is_equal(var_0, var_4.node)) {
        var_4 scripts\common\ai::poi_enable(1, var_1);
        var_4 thread waittill_color_change("MH_hallway_monitor");
      }
    }
  }
}

waittill_color_change(var_0) {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::trigger_wait_targetname(var_0);
  scripts\common\ai::poi_enable(0);
}

save_at_mh_building() {
  scripts\engine\utility::flag_wait("murderhole_breach_save_point");
  scripts\sp\maps\marines\marines_utility.gsc::marines_autosave([level.org, level.org2]);
}

kill_off_rpg_guy() {
  var_0 = getEnt("magicbullet_rpg_kill", "targetname");
  var_1 = cos(90);

  if(isDefined(self)) {
    while(isalive(self)) {
      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_1))
        magicbullet("iw8_ar_akilo47", var_0.origin, self gettagorigin("j_head"));

      wait 0.25;
    }
  }
}

save_game_after_battlefield() {
  scripts\engine\utility::flag_wait("set_MH_trigger");
  var_0 = getaiarray("axis");

  while(var_0.size > 1) {
    var_0 = getaiarray("axis");
    wait 0.1;
  }

  scripts\sp\maps\marines\marines_utility.gsc::marines_autosave([level.org, level.org2]);
}

mghouse_tripwire_monitor() {
  var_0 = scripts\engine\utility::getStruct("mghouse_tripwire_struct", "targetname");
  var_1 = getEnt("mghouse_tripwire_nav_clip", "targetname");
  var_2 = scripts\engine\utility::getStruct("mghouse_tripwire_nav_clear_struct", "targetname");
  var_3 = scripts\engine\utility::getStruct("mghouse_tripwire_nav_block_struct", "targetname");
  var_4 = 99999;
  var_5 = undefined;
  wait 1;

  foreach(var_7 in level.tripwires.traps) {
    if(isDefined(var_7.origin) && distance2dsquared(var_7.origin, var_0.origin) < var_4) {
      var_4 = distance2dsquared(var_7.origin, var_0.origin);
      var_5 = var_7;
    }

    waitframe();
  }

  var_5.defusehintstruct.cursor_hint_ent sethintdisplayrange(200);
  thread scripts\sp\maps\marines\marines_utility.gsc::marines_tripwire_monitor(var_0, "stairs_tripwire_cleared", var_1, var_3, var_2);
}

disable_marines_backtrack_color() {
  scripts\engine\utility::flag_wait("player_ready_for_marine");
  var_0 = getEntArray("mh_color_triggers", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 scripts\engine\utility::trigger_off();

  scripts\sp\spawner::killspawner(6);
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_MH_2nd_floor");
}

kitchen_smoke_handler() {
  self endon("death");
  self endon("kitchen_smoke_grenade_success");
  var_0 = getEnt("kitchen_smoke_volume", "targetname");

  for(;;) {
    level.player waittill("grenade_fire", var_1, var_2);

    if(!isDefined(var_1)) {
      return;
    }
    if(!isDefined(var_2.basename)) {
      return;
    }
    if(var_2.basename == "smoke_tall") {
      var_1 waittill("explode", var_3);

      if(ispointinvolume(var_3, var_0))
        self notify("kitchen_smoke_grenade_success");
      else
        self notify("kitchen_smoke_grenade_fail");
    }

    wait 1.0;
  }
}

kitchen_smoke_monitor() {
  self waittill("kitchen_smoke_grenade_success");
  scripts\engine\utility::flag_set("smoke_in_kitchen");
}

mg_shoot_scriptables() {
  var_0 = getEntArray("MG_damage_trigger", "targetname");

  foreach(var_2 in var_0)
  var_2 thread scripted_shot_monitor();

  scripts\engine\utility::flag_wait("mg_guys_dead");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 scripts\engine\utility::trigger_off();
  }
}

scripted_shot_monitor() {
  level endon("cleanup_starting");
  self waittill("trigger");
  scripted_shot();
}

scripted_shot() {
  var_0 = getEntArray(self.target, "targetname");
  var_1 = 0;

  while(var_1 < 5) {
    magicbullet("iw8_ar_akilo47_marines_streets", level.org.origin, var_0[0].origin);
    var_1++;
    wait 0.1;
  }
}

mg_alley_intro_script_shot() {
  var_0 = getEnt("alley_script_shot_target", "targetname");
  scripts\engine\sp\utility::trigger_wait_targetname("alley_MG_damage_trigger");

  for(var_1 = 0; var_1 < 15; var_1++) {
    magicbullet("iw8_ar_akilo47_marines_streets", level.org.origin, var_0.origin + (-5 * var_1, 0, 0));
    wait 0.1;
  }
}

player_stayahead_enemy_behavior() {
  self endon("death");
  scripts\sp\utility::set_stayahead_values(1, 120, 50, 0.1);
  scripts\sp\utility::set_stayahead_values(2, 130, 150, 0.1);
  scripts\sp\utility::set_stayahead_values(3, 140, 200, 0.1);
  scripts\sp\utility::set_stayahead_values(4, 160, 250, 0.25);
}

marine_teleport_handler() {
  var_0 = getEnt("marine_teleport_check_trigger", "targetname");
  scripts\engine\utility::flag_wait("stairs_grenade_nag");
  var_1 = 0;
  var_2 = getaiarray("allies");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_forcecolor) && var_4.script_forcecolor == "r") {
      if(!var_4 istouching(var_0)) {
        if(var_1 <= 1) {
          var_5 = scripts\engine\utility::getStruct("marine_teleport_destination_r_" + var_1, "targetname");

          if(isDefined(var_4)) {
            var_4 teleport(var_5.origin);
            var_1++;
          }
        }
      }
    }

    if(isDefined(var_4.script_forcecolor) && var_4.script_forcecolor == "c") {
      if(!var_4 istouching(var_0)) {
        var_6 = scripts\engine\utility::getStruct("marine_teleport_destination_c", "targetname");

        if(isDefined(var_4))
          var_4 teleport(var_6.origin);
      }
    }

    if(isDefined(var_4.script_forcecolor) && var_4.script_forcecolor == "y") {
      if(!var_4 istouching(var_0)) {
        var_7 = scripts\engine\utility::getStruct("marine_teleport_destination_y", "targetname");

        if(isDefined(var_4))
          var_4 teleport(var_7.origin);
      }
    }
  }
}

marine01_check_if_in_position() {
  var_0 = scripts\engine\utility::getStruct("marine_01_anim_struct", "targetname");
  var_1 = getaiarray("allies");
  var_2 = getnode("mg_react_node_01", "targetname");
  var_3 = getnode("marine01_react_post_node", "targetname");
  var_4 = scripts\engine\utility::getStruct("IED_red_POI", "targetname");
  scripts\engine\utility::flag_wait("check_if_marines_at_node");
  wait 0.25;

  foreach(var_6 in var_1) {
    if(isDefined(var_6)) {
      if(isDefined(var_6.script_forcecolor) && var_6.script_forcecolor == "c") {
        if(scripts\engine\utility::flag("marine_01_reached_IED")) {
          var_6.animname = "react_marine_01";
          waitframe();

          if(isDefined(var_6)) {
            var_6 thread scripts\common\ai::poi_enable(1, var_4);
            var_6 scripts\engine\sp\utility::set_goal_radius(64);
            var_6 setgoalnode(var_3);
            var_6 scripts\engine\sp\utility::set_allowdeath(1);
            var_6 allowedstances("crouch");
            var_0 scripts\common\anim::anim_single_solo(var_6, "mg_react");
          }

          continue;
        }

        if(isDefined(var_6))
          var_6 thread scripts\common\ai::poi_enable(1, var_4);
      }
    }
  }
}

marine02_check_if_in_position() {
  var_0 = getaiarray("allies");
  var_1 = getnode("mg_react_node_02", "targetname");
  var_2 = scripts\engine\utility::getStruct("IED_yellow_POI", "targetname");
  scripts\engine\utility::flag_wait("check_if_marines_at_node");
  wait 0.5;

  foreach(var_4 in var_0) {
    if(isDefined(var_4)) {
      if(isDefined(var_4.script_forcecolor) && var_4.script_forcecolor == "y") {
        if(scripts\engine\utility::flag("marine_02_reached_IED")) {
          var_4.animname = "react_marine_02";
          waitframe();

          if(isDefined(var_4))
            var_4 thread scripts\common\ai::poi_enable(1, var_2);

          continue;
        }

        if(isDefined(var_4))
          var_4 thread scripts\common\ai::poi_enable(1, var_2);
      }
    }
  }
}

marine03_check_if_in_position() {
  var_0 = scripts\engine\utility::getStruct("marine_03_anim_struct", "targetname");
  var_1 = getaiarray("allies");
  var_2 = getnode("mg_react_node_03", "targetname");
  var_3 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("r");
  var_4 = scripts\engine\utility::getStruct("IED_red_POI", "targetname");
  scripts\engine\utility::flag_wait("check_if_marines_at_node");
  var_5 = sortbydistance(var_3, var_2.origin);
  var_6 = 0;
  wait 0.5;

  foreach(var_8 in var_5) {
    if(isDefined(var_8)) {
      var_8.script_index = var_6;

      if(scripts\engine\utility::is_equal(var_2, var_8.node) && scripts\engine\utility::flag("marine_03_reached_IED")) {
        var_8.animname = "react_marine_03";
        waitframe();

        if(isDefined(var_8)) {
          var_8 thread scripts\common\ai::poi_enable(1, var_4);
          var_8 scripts\engine\sp\utility::set_allowdeath(1);
        }
      } else if(!scripts\engine\utility::flag("marine_03_reached_IED")) {
        waitframe();

        if(isDefined(var_8)) {
          if(var_8.script_index == 1)
            var_8 thread scripts\common\ai::poi_enable(1, var_4);
        }
      }

      var_6++;
    }
  }
}

interior_dof_monitor() {
  var_0 = getEntArray("MH_interior_DOF_volume", "targetname");

  while(!scripts\engine\utility::flag("flag_lobby_entered")) {
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(level.player istouching(var_3))
        var_1 = 1;
    }

    if(var_1 == 1)
      scripts\engine\utility::flag_set("murderhole_dof_On");

    if(var_1 == 0)
      scripts\engine\utility::flag_clear("murderhole_dof_On");

    wait 0.2;
  }
}

cleanup_all_poi() {
  scripts\engine\sp\utility::trigger_wait_targetname("alley_start_trigger");
  var_0 = getaiarray("allies");

  if(!scripts\engine\utility::flag("checkpoint_jumped_to_MH")) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2) && isalive(var_2))
        var_2 scripts\common\ai::poi_enable(0);
    }
  }
}

mg_breach_no_pistol() {
  scripts\engine\utility::flag_wait("player_ready_for_marine");

  foreach(var_1 in getaiarray("allies"))
  var_1.no_pistol_switch = 1;

  scripts\engine\utility::flag_wait_any("mg_guys_dead", "flag_retreat_spawn_initial_aq");

  foreach(var_1 in getaiarray("allies"))
  var_1.no_pistol_switch = 0;
}

stair_blocking_marine_handler() {
  var_0 = getEnt("second_floor_marine_teleport_check", "targetname");
  var_1 = getEnt("marines_blocker_clip", "targetname");
  var_2 = getspawner("stair_blocker_ai", "targetname");
  var_1 movez(9999, 0.5, 0.25, 0.25);
  scripts\engine\utility::flag_wait("player_ready_for_marine");
  scripts\engine\utility::flag_set("looked_into_bedroom");
  scripts\engine\utility::flag_clear("flag_retreat_exiting_mg_house");
  var_3 = var_2 scripts\engine\sp\utility::spawn_ai();
  var_3 thread stair_blocker_ai_handler();
  var_3 thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
  var_1 movez(-9999, 0.5, 0.25, 0.25);

  if(!scripts\engine\utility::flag("checkpoint_jumped")) {
    level.b_smoke = 1;
    var_4 = 0;
    var_5 = getaiarray("allies");

    foreach(var_7 in var_5) {
      if(isDefined(var_7) && isDefined(var_7.script_forcecolor) && var_7.script_forcecolor == "r") {
        if(!var_7 istouching(var_0)) {
          if(var_4 <= 1) {
            var_8 = scripts\engine\utility::getStruct("second_flr_marine_teleport_destination_r_" + var_4, "targetname");

            if(isDefined(var_7)) {
              var_7 teleport(var_8.origin);
              var_4++;
            }
          }
        }
      }

      if(isDefined(var_7) && isDefined(var_7.script_forcecolor) && var_7.script_forcecolor == "c") {
        if(!var_7 istouching(var_0)) {
          var_9 = scripts\engine\utility::getStruct("second_flr_marine_teleport_destination_c", "targetname");

          if(isDefined(var_7))
            var_7 teleport(var_9.origin);
        }
      }

      if(isDefined(var_7) && isDefined(var_7.script_forcecolor) && var_7.script_forcecolor == "y") {
        if(!var_7 istouching(var_0)) {
          var_10 = scripts\engine\utility::getStruct("second_flr_marine_teleport_destination_y", "targetname");

          if(isDefined(var_7))
            var_7 teleport(var_10.origin);
        }
      }
    }
  }

  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  var_1 delete();
}

stair_blocker_ai_handler() {
  if(isDefined(self)) {
    self.friend_kill_points = -100000;
    self.grenadeawareness = 0;
    self.script_pushable = 0;
    self.dontavoidplayer = 1;
    self.dontchangepushplayer = 0;
    self pushplayer(1);
  }

  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");

  if(isDefined(self))
    self delete();
}

rpg_kill_handler() {
  scripts\engine\utility::flag_wait("magicbullet_rpg_guys");
  level.right_guy thread kill_off_rpg_guy();
  wait 0.5;
  level.left_guy thread kill_off_rpg_guy();
}

civ_dialogue_handler() {
  scripts\engine\utility::flag_wait("alex_civ_dialogue");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_mhbreach_alex_civ_down_dialogue();
}

alley_push_up_scripted_dialogue() {
  scripts\engine\utility::flag_wait("rpg_spawned");

  if(level.player getammocount(getcompleteweaponname("smoke_tall")) > 0 || level.griggs.support_equipment > 0)
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_scripted_push_up_dialogue();
}

streets_push_up_nag() {
  scripts\engine\utility::flag_wait("rpg_spawned");

  while(!scripts\engine\utility::flag("stop_smoke_nag_in_streets") && !scripts\engine\utility::flag("enough_enemies_killed")) {
    wait 20;

    if(level.griggs_can_smoke_nag == 1 && !scripts\engine\utility::flag("stop_smoke_nag_in_streets") && !scripts\engine\utility::flag("enough_enemies_killed"))
      thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_push_up_nag_dialogue();

    waitframe();
  }
}

streets_smoke_grenade_nag() {
  scripts\engine\utility::flag_wait("enough_enemies_killed");
  wait 5;

  while(!scripts\engine\utility::flag("stop_smoke_nag_in_streets")) {
    if(level.griggs_can_smoke_nag == 1 && !scripts\engine\utility::flag("nag_temporarily_disabled")) {
      if(level.player getammocount(getcompleteweaponname("smoke_tall")) > 0) {
        level.smoke_thrown = 0;
        thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_throw_smoke_nag_dialogue();
        scripts\engine\sp\utility::display_hint_forced("smoke_hint");
        wait 7.0;
        level.smoke_thrown = 1;
      } else if(level.griggs.support_equipment > 0) {
        thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_throw_smoke_nag_dialogue();
        scripts\engine\sp\utility::display_hint("smoke_nag", 5);
      } else
        thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_push_up_nag_dialogue();

      wait 18;
      continue;
    }

    waitframe();
  }

  waitframe();
}

streets_smoke_grenade_guaranteed_nag() {
  scripts\engine\utility::flag_wait("guaranteed_smoke_nag_flag");

  if(level.griggs_can_smoke_nag == 1 && !scripts\engine\utility::flag("set_MH_trigger") && !scripts\engine\utility::flag("nag_temporarily_disabled")) {
    level.smoke_thrown = 0;

    if(level.player getammocount(getcompleteweaponname("smoke_tall")) > 0) {
      thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_throw_smoke_nag_dialogue();
      scripts\engine\sp\utility::display_hint("smoke_hint");
      wait 7.0;
      level.smoke_thrown = 1;
    } else if(level.griggs.support_equipment > 0) {
      scripts\engine\sp\utility::display_hint("smoke_nag", 5);
      thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_throw_smoke_nag_dialogue();
    }
  }
}

track_if_player_throw_smokes() {
  level.smoke_thrown_in_streets = 0;

  for(;;) {
    level.player waittill("grenade_fire", var_0, var_1);

    if(var_1.basename == "smoke_tall")
      level.smoke_thrown = 1;
  }
}

alley_marine_ignore_handler() {
  scripts\engine\sp\utility::trigger_wait_targetname("alley_start_trigger");
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2))
      var_2 thread alley_ignore_player_enable();
  }

  scripts\engine\utility::flag_wait("right_street_save");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2))
      var_2 thread alley_ignore_player_clear();
  }
}

alley_ignore_player_enable() {
  self.dontavoidplayer = 1;
  self.disablebulletwhizbyreaction = 1;
  self.script_pushable = 0;
  self enableavoidance(0);
  self.doavoidanceblocking = 0;
  self.dontchangepushplayer = undefined;
  self pushplayer(1);
}

alley_ignore_player_clear() {
  self.dontavoidplayer = 0;
  self.disablebulletwhizbyreaction = 0;
  self.script_pushable = 1;
  self enableavoidance(1);
  self.doavoidanceblocking = 1;
  self.dontchangepushplayer = 1;
  self pushplayer(0);
}

upstairs_guy_handler() {
  level endon("turn_off_upstairs_guy");
  scripts\engine\sp\utility::trigger_wait_targetname("upstairs_guy_trigger");
  var_0 = getspawner("upstairs_guy", "targetname") scripts\engine\sp\utility::spawn_ai();

  if(isDefined(var_0))
    var_0.ignoreall = 1;

  scripts\engine\sp\utility::trigger_wait_targetname("upstairs_guy_aware");

  if(isDefined(var_0))
    var_0.ignoreall = 0;
}

mg_doors_bashed_monitor(var_0, var_1) {
  level endon("mg_team_alerted");
  var_0 thread mg_door_bashed_monitor();
  var_1 thread mg_door_bashed_monitor();
  level waittill("mg_doors_bashed");
  scripts\engine\utility::flag_set("mg_team_alerted");
}

mg_door_bashed_monitor() {
  level endon("mg_doors_bashed");
  level endon("mg_team_alerted");
  self waittill("bashed");
  level notify("mg_doors_bashed");
}

back_alley_autosave() {
  scripts\engine\utility::flag_wait("back_alley_autosave");
  scripts\sp\maps\marines\marines_utility.gsc::marines_autosave([level.org, level.org2]);
}

alley_fallback_handler() {
  var_0 = getEnt("alley_fallback", "targetname");
  scripts\engine\utility::flag_wait_or_timeout("ambush_start", 30);
  var_1 = scripts\engine\sp\utility::get_living_ai_array("alley_initial_wave", "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3))
      var_3 setgoalvolumeauto(var_0);
  }
}

player_bedroom_clear_handler() {
  var_0 = scripts\engine\utility::getStruct("bedroom_fov_struct", "targetname");
  var_1 = cos(15);
  var_2 = getEnt("bedroom_look_monitor", "targetname");

  while(!scripts\engine\utility::flag("looked_into_bedroom")) {
    if(level.player istouching(var_2)) {
      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_1)) {
        if(!scripts\engine\utility::flag("marine_at_bedroom")) {
          thread scripts\sp\maps\marines\marines_vo.gsc::vo_mhbreach_alex_bedroom_clear_dialogue();
          scripts\engine\utility::flag_set("looked_into_bedroom");
        }
      }
    }

    wait 0.5;
  }
}

marine_bedroom_clear_handler() {
  scripts\engine\utility::flag_wait("marine_at_bedroom");

  if(!scripts\engine\utility::flag("looked_into_bedroom"))
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_mhbreach_marine_bedroom_clear_dialogue();
}

wait_and_kill_underbarrel_grenade_launcher_monitors(var_0) {
  wait(var_0);
  level notify("underbarrel_grenade_launcher_equipped");
  level notify("end_underbarrel_grenade_launcher_monitor");
}

ready_to_breach_poi() {
  var_0 = scripts\engine\utility::getStruct("breach_POI_struct", "targetname");
  scripts\engine\utility::flag_wait("ready_to_breach_MH");
  var_1 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("r");

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3))
      var_3 scripts\common\ai::poi_enable(1, var_0);
  }

  var_5 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("y");

  foreach(var_3 in var_5) {
    if(isDefined(var_3) && isalive(var_3))
      var_3 scripts\common\ai::poi_enable(1, var_0);
  }

  scripts\engine\utility::flag_wait("murderhole_breach_save_point");
  var_1 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("r");

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3))
      var_3 scripts\common\ai::poi_enable(0);
  }

  var_5 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("y");

  foreach(var_3 in var_5) {
    if(isDefined(var_3) && isalive(var_3))
      var_3 scripts\common\ai::poi_enable(0);
  }
}

truck_dead_or_alive_monitor(var_0, var_1) {
  var_2 = "truckDropOff";
  var_3 = getanimlength(scripts\engine\utility::getanim(var_2)) - 1;
  wait(var_3);

  if(isDefined(self) && isalive(self))
    scripts\engine\utility::flag_set(var_0);
  else
    scripts\engine\utility::flag_set(var_1);
}

disabling_truck_1_node_handler() {
  var_0 = getEnt("truck_1_clip", "targetname");
  var_0 movez(-9999, 0.5, 0.25, 0.25);
  waitframe();
  var_0 connectpaths();
  scripts\engine\utility::flag_wait("check_truck_status");
  scripts\engine\utility::flag_wait_any("truck_1_reached", "truck_1_destroyed");

  if(scripts\engine\utility::flag("truck_1_reached"))
    scripts\engine\sp\utility::activate_trigger("truck_1_reached_point", "targetname");
  else
    scripts\engine\sp\utility::activate_trigger("truck_1_no_reached_point", "targetname");
}

disabling_truck_2_node_handler() {
  var_0 = getEnt("truck_2_clip", "targetname");
  var_1 = getnode("truck_2_node_0", "targetname");
  var_2 = getnode("truck_2_node_1", "targetname");
  var_3 = getnode("truck_2_node_2", "targetname");
  var_0 movez(-9999, 0.5, 0.25, 0.25);
  waitframe();
  var_0 connectpaths();
  var_1 disconnectnode();
  var_2 disconnectnode();
  var_3 disconnectnode();
  scripts\engine\utility::flag_wait("truck_2_reached");
  var_1 connectnode();
  var_2 connectnode();
  var_3 connectnode();
}

weapon_clip_delete() {
  var_0 = getEntArray("MH_weapon_clip", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();
}

marines_push_to_house_handler() {
  scripts\engine\utility::flag_wait("marines_to_alley_building_flag");
  scripts\engine\sp\utility::activate_trigger("marines_to_alley_building_color_trigger", "targetname");
}

rumble_on_death() {
  self endon("entitydeleted");
  self waittill("death");

  if(distance2d(self.origin, level.player.origin) < 1000) {
    playworldsound("frag_grenade_expl_trans", self.origin);
    earthquake(0.35, 1, level.player.origin, 100);
    level.player playRumbleOnEntity("grenade_rumble");
  } else {
    playworldsound("frag_grenade_expl_trans", self.origin);
    earthquake(0.2, 1, level.player.origin, 100);
    level.player playRumbleOnEntity("grenade_rumble");
  }
}

first_floor_clear_dialogue_handler() {
  scripts\engine\utility::flag_wait_all("stairs_tripwire_approached", "kitchen_guy_killed");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_mhbreach_alex_kitchen_clear_dialogue();
}

first_floor_stairs_climbing_dialogue_handler() {
  scripts\engine\utility::flag_wait_all("stairs_climbing_start", "stairs_tripwire_cleared");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_mhbreach_alex_stairs_climbing_dialogue();
}

mg_entry_callout_handler() {
  var_0 = getEnt("mg_house_gunner_2_target", "targetname");
  var_1 = getEntArray("mg_initial_callout_volume", "targetname");
  var_2 = 0;
  var_3 = cos(20);

  while(!scripts\engine\utility::flag("magicbullet_rpg_guys") && var_2 == 0) {
    foreach(var_5 in var_1) {
      if(level.player istouching(var_5)) {
        if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_3) && var_2 == 0) {
          thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_mg_initial_callout_dialogue();
          var_2 = 1;
        }
      }
    }

    waitframe();
  }
}

mg_double_doors_handler() {
  level.mg_door_left = scripts\sp\door::get_interactive_door("mg_door_left");
  level.mg_door_right = scripts\sp\door::get_interactive_door("mg_door_right");
  level.mg_doors = scripts\sp\door::double_doors_init(level.mg_door_right, level.mg_door_left);
  thread mg_doors_bashed_monitor(level.mg_door_left, level.mg_door_right);
  level.mg_door_left scripts\game\sp\door::remove_door_snake_cam_ability();
  level.mg_door_right scripts\game\sp\door::remove_door_snake_cam_ability();
  level.mg_door_left.script_max_left_angle = 120;
  level.mg_door_left.script_max_right_angle = 120;
  level.mg_door_left scripts\sp\door::init_max_yaws();
  level.mg_door_right.script_max_left_angle = 120;
  level.mg_door_right.script_max_right_angle = 120;
  level.mg_door_right scripts\sp\door::init_max_yaws();
  level.mg_door_left thread scripts\sp\utility::door_ai_allowed(0);
  level.mg_door_right thread scripts\sp\utility::door_ai_allowed(0);
  scripts\engine\utility::flag_wait("mg_team_alerted");
  level.mg_door_left thread scripts\sp\utility::door_ai_allowed(1);
  level.mg_door_right thread scripts\sp\utility::door_ai_allowed(1);
}

ied_to_alley_nag_handler() {
  wait 12;

  while(!scripts\engine\utility::flag("IED_to_alley_nag_kill")) {
    if(level.playerinnagvolume == 0 && level.return_to_mission_nagged == 0) {
      thread scripts\sp\maps\marines\marines_vo.gsc::vo_marines_leaving_area_nag();
      level.return_to_mission_nagged = 1;
      wait(randomfloatrange(9, 10));
      level.return_to_mission_nagged = 0;
    }

    waitframe();
  }
}

brief_color_disable() {
  if(isDefined(self) && isalive(self))
    scripts\engine\sp\utility::disable_ai_color();

  scripts\engine\sp\utility::trigger_wait_targetname("marines_to_alley_building_color_trigger");

  if(isDefined(self) && isalive(self))
    scripts\engine\sp\utility::set_force_color("r");
}