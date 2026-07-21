/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_gameplay_hospital.gsc
*********************************************************/

hospital_init() {
  scripts\engine\utility::flag_init("flag_lobby_advance");
  scripts\engine\utility::flag_init("flag_lobby_entered");
  scripts\engine\utility::flag_init("flag_lobby_secured");
  scripts\engine\utility::flag_init("flag_lobby_exiting");
  scripts\engine\utility::flag_init("flag_groundfloor_hallway_ambush_start");
  scripts\engine\utility::flag_init("flag_groundfloor_initial_autosave");
  scripts\engine\utility::flag_init("flag_groundfloor_cover_mover_spawn");
  scripts\engine\utility::flag_init("flag_groundfloor_start_retreat");
  scripts\engine\utility::flag_init("flag_groundfloor_grenadier_spawn");
  scripts\engine\utility::flag_init("flag_groundfloor_floodspawn_3");
  scripts\engine\utility::flag_init("flag_groundfloor_civ_runby_1");
  scripts\engine\utility::flag_init("flag_groundfloor_floodspawn_1");
  scripts\engine\utility::flag_init("flag_groundfloor_floodspawn_2");
  scripts\engine\utility::flag_init("flag_groundfloor_last_stand_left_encountered");
  scripts\engine\utility::flag_init("flag_groundfloor_last_stand_right_encountered");
  scripts\engine\utility::flag_init("flag_groundfloor_flank_fallback");
  scripts\engine\utility::flag_init("flag_groundfloor_room_1_cleared");
  scripts\engine\utility::flag_init("flag_groundfloor_room_2_cleared");
  scripts\engine\utility::flag_init("flag_stairwell_exit");
  scripts\engine\utility::flag_init("deathflag_hall_gunner_rear_dead");
  scripts\engine\utility::flag_init("flag_groundfloor_blindshooter_retreat");
  scripts\engine\utility::flag_init("flag_groundfloor_allow_push");
  scripts\engine\utility::flag_init("flag_groundfloor_marines_mid");
  scripts\engine\utility::flag_init("flag_groundfloor_stairwell_hint");
  scripts\engine\utility::flag_init("flag_groundfloor_left_flanker_spawn");
  scripts\engine\utility::flag_init("flag_groundfloor_left_flanker_skip");
  scripts\engine\utility::flag_init("flag_lobby_civ_rush");
  scripts\engine\utility::flag_init("flag_lobby_entered_autosave");
  scripts\engine\utility::flag_init("flag_stairwell_reached");
  scripts\engine\utility::flag_init("flag_upperfloor_civtrap_end");
  scripts\engine\utility::flag_init("flag_groundfloor_spawn_bomber");
  scripts\engine\utility::flag_init("flag_hallway_initial_reinforce_arrived");
  scripts\engine\utility::flag_init("flag_groundfloor_tripwire_defused");
  scripts\engine\utility::flag_init("flag_vo_stairwell_exterior");
  scripts\engine\utility::flag_init("flag_vo_stairwell_secure");
  scripts\sp\maps\marines\marines_civilians.gsc::civilians_init();
  scripts\sp\drone_civilian::init();
  precacheanims();
  precachemodel("head_sc_m_arakelyan_civ");
  precachemodel("body_civ_syrkistan_male_2_1");
}

lobby_main() {
  level.player setsoundsubmix("sp_npc_steps_down", 1.0, 1.0);
  thread hospital_exterior_vehicle_monitor();
  thread scripts\sp\analytics::analytics_kleenex_update("End of Murderhole to Breach");
  scripts\sp\maps\marines\marines_utility.gsc::autosave();
  setsaveddvar("TLOLRMSL", 1);
  level.manpile_monitor.ideal = 10;
  level.manpile_monitor.maximum = 16;
  level.manpile_monitor.maximum_weapons = 16;
  level.manpile_monitor.safe_delete_distance = 2000;
  level.manpile_monitor.wait_time = 0.25;
  level.griggs_lobby_cleared_vo_done = 0;
  thread hospital_dof_monitor();
  level.aq_lobby_breach_spawners = getspawnerarray("aq_lobby_breach");
  thread groundfloor_entry_door_handler();
  var_0 = getEnt("retreat_marines_push_to_lobby", "targetname");
  scripts\engine\sp\utility::array_spawn_function_targetname("ally_marine_lobby", scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::setup_support_marines);
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_lobby");
  scripts\engine\utility::array_thread(level.allymarines["all"], scripts\engine\sp\utility::enable_ai_color);
  level notify("stop_following_vehicle");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_lobby_griggs_secure_lobby_dialogue();
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("aq_lobby_initial");

  if(isDefined(var_0))
    scripts\engine\sp\utility::activate_trigger("retreat_marines_push_to_lobby", "targetname");

  level.griggs scripts\engine\utility::delaythread(2, scripts\asm\gesture::ai_request_gesture, "advance");

  foreach(var_3 in getaiarray("allies"))
  var_3.baseaccuracy = 0.5;

  thread lobby_aq_alive_count_monitor();
  thread lobby_aq_door_guard();
  thread lobby_breach_aq_rush();
  thread hall_rush_initial_civilians_handler();
  thread kill_off_lobby_aq();
  scripts\engine\utility::flag_wait("flag_lobby_entered_autosave");
  scripts\engine\sp\utility::autosave_or_timeout(undefined, 5);
  scripts\engine\utility::flag_wait_any("flag_lobby_secured", "flag_lobby_exiting");
  wait 0.5;
}

lobby_breach_aq_rush() {
  var_0 = getEnt("aq_lobby_mid_push_volume", "targetname");
  scripts\engine\utility::flag_wait("flag_lobby_entered");
  thread scripts\sp\maps\marines\marines_gameplay_convoy.gsc::apc_cleanup_handler();
  var_1 = scripts\engine\sp\utility::array_spawn(level.aq_lobby_breach_spawners);
  wait 3;

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_3 cleargoalvolume();
      waitframe();
      var_3 setgoalvolumeauto(var_0);
    }
  }
}

lobby_breach_civ_rush() {
  var_0 = getspawnerarray("lobby_breach_victim_spawners");
  scripts\engine\sp\utility::array_spawn_function(var_0, ::hall_rush_civ_behavior, 0, 1);
  level.player_reacted_to_civ = 0;
  scripts\engine\utility::flag_wait("flag_lobby_civ_rush");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\engine\sp\utility::spawn_ai();
    wait(randomfloatrange(0.15, 0.3));
  }

  wait 2;
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_lobby_marine_civ_warning_dialogue();
  scripts\engine\utility::flag_wait("flag_groundfloor_stairwell_hint");
  var_5 = [];
  var_5 = scripts\engine\sp\utility::get_living_ai_array("ai_civ_lobby", "script_noteworthy");
  scripts\engine\utility::array_delete(var_5);
}

lobby_aq_door_guard() {
  level endon("player_rushed_through_lobby");

  for(var_0 = 0; var_0 == 0; var_0 = 1) {
    var_1 = [];

    for(var_1 = scripts\engine\sp\utility::get_living_ai_array("ai_lobby", "script_noteworthy"); var_1.size > 2; var_1 = scripts\engine\sp\utility::get_living_ai_array("ai_lobby", "script_noteworthy"))
      wait 1.0;
  }

  var_2 = scripts\engine\sp\utility::array_spawn_targetname("aq_lobby_door_guards", 1);
}

groundfloor_floodspawn_4_handler() {
  var_0 = getspawner("groundfloor_floodspawner_4_spawner", "targetname");
  var_1 = getspawner("groundfloor_floodspawner_4_reinforce_spawner", "targetname");
  scripts\engine\utility::flag_wait("flag_groundfloor_spawn_bomber");
  wait 3;
  var_2 = var_0 scripts\engine\sp\utility::spawn_ai();

  if(!isalive(level.groundfloor_floodspawner_3_reinforce))
    var_3 = var_1 scripts\engine\sp\utility::spawn_ai();
}

lobby_aq_alive_count_monitor() {
  scripts\engine\utility::flag_wait("flag_lobby_advance");
  wait 1;
  var_0 = [];

  for(var_0 = scripts\engine\sp\utility::get_living_ai_array("ai_lobby", "script_noteworthy"); var_0.size > 0; var_0 = scripts\engine\sp\utility::get_living_ai_array("ai_lobby", "script_noteworthy"))
    wait 0.25;

  scripts\engine\utility::flag_set("flag_lobby_secured");
  thread disable_lobby_color_triggers();
}

groundfloor_main() {
  thread scripts\sp\maps\marines\marines_utility.gsc::transient_waittill("flag_lobby_exiting", "marines_streets_geo_tr", "marines_stairwell_geo_tr");
  thread scripts\sp\maps\marines\marines_utility.gsc::transient_waittill("flag_groundfloor_flank_fallback", ["marines_introhack_geo_tr", "marines_streets_script_tr", "marines_ridge_geo_tr", "marines_parkinglot_geo_tr"], "marines_civambush_geo_tr");
  scripts\sp\maps\marines\marines_utility.gsc::autosave();
  level.manpile_monitor.ideal = 10;
  level.manpile_monitor.maximum = 14;
  level.manpile_monitor.maximum_weapons = 10;
  level.manpile_monitor.safe_delete_distance = 2000;
  level.manpile_monitor.wait_time = 0.5;
  thread allies_push_stairwell_early();
  thread aq_hall_blind_corner_shooter();
  thread aq_hall_cover_move();
  thread aq_hospital_hall_left_flank_ambusher();
  thread aq_hospital_hall_left_side();
  thread aq_hospital_hall_right_side();
  thread aq_hospital_stairwell();
  thread disable_lobby_color_triggers();
  thread friendly_groundfloor_setup();
  thread groundfloor_civ_manager();
  thread groundfloor_extra_marines_handler();
  thread groundfloor_color_advance_manager();
  thread groundfloor_floodspawn_1_handler();
  thread groundfloor_floodspawn_2_handler();
  thread groundfloor_floodspawn_3_handler();
  thread groundfloor_floodspawn_4_handler();
  thread groundfloor_tripwire_defuse_monitor();
  thread hall_rush_gunners();
  thread lobby_dialogue_manager();
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_groundfloor");
  thread scripts\sp\maps\marines\marines_utility.gsc::spawn_corpses("groundfloor_dead_body", "flag_civ_ambush_start");
  thread marine_groundfloor_room_clearing_manager();
  wait 1;

  foreach(var_1 in getaiarray("allies")) {
    if(isalive(var_1)) {
      var_1.baseaccuracy = 0.5;
      var_1.health = 200;

      if(isDefined(var_1.asmname))
        var_1 scripts\common\utility::demeanor_override("combat");
    }
  }

  scripts\engine\utility::flag_wait("flag_groundfloor_initial_autosave");
  scripts\engine\sp\utility::autosave_or_timeout(undefined, 5);
  scripts\engine\utility::flag_wait("flag_groundfloor_flank_fallback");
  thread allies_groundfloor_melee_clear_handler();
  thread containment_groundfloor();
  thread containment_groundfloor_teleport();
  scripts\engine\utility::flag_wait("flag_stairwell_reached");
  thread groundfloor_cleanup();
}

groundfloor_extra_marines_handler() {
  var_0 = [];
  var_1 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("g");

  if(var_1.size > 2) {
    for(var_2 = 2; var_2 < var_1.size; var_2++) {
      var_1[var_2] scripts\sp\maps\marines\marines_utility.gsc::switch_marine_color("g", "c");
      var_0 = scripts\engine\utility::array_add(var_0, var_1[var_2]);
    }
  } else {}

  var_3 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("b");

  if(var_3.size > 2) {
    for(var_2 = 2; var_2 < var_3.size; var_2++) {
      var_3[var_2] scripts\sp\maps\marines\marines_utility.gsc::switch_marine_color("b", "c");
      var_0 = scripts\engine\utility::array_add(var_0, var_3[var_2]);
    }
  } else {}

  scripts\engine\utility::flag_wait("hospital_doors_closed");

  if(var_0.size > 0) {
    foreach(var_5 in var_0) {
      if(isDefined(var_5) && isalive(var_5))
        var_5 delete();
    }
  }
}

allies_groundfloor_melee_clear_handler() {
  foreach(var_1 in getaiarray("allies"))
  var_1.dontmelee = 1;

  scripts\engine\utility::flag_wait("flag_stairwell_exit");

  foreach(var_1 in getaiarray("allies"))
  var_1.dontmelee = 0;
}

marine_groundfloor_room_clearing_manager() {
  var_0 = getnode("groundfloor_room_clear_node_1a", "targetname");
  var_1 = getnode("groundfloor_room_clear_node_1b", "targetname");
  var_2 = getnode("groundfloor_room_clear_node_2a", "targetname");
  var_3 = getnode("groundfloor_room_clear_node_2b", "targetname");
  thread scripts\sp\maps\marines\marines_utility.gsc::marine_room_clear_node("flag_groundfloor_room_1_cleared", var_0, var_1);
  thread scripts\sp\maps\marines\marines_utility.gsc::marine_room_clear_node("flag_groundfloor_room_2_cleared", var_2, var_3);
}

aq_hospital_stairwell() {
  var_0 = getspawner("aq_groundfloor_stairwell_top_spawner", "targetname");
  scripts\engine\utility::flag_wait("flag_groundfloor_flank_fallback");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai();
  var_1 scripts\engine\sp\utility::set_goal_radius(32);
  var_1 scripts\engine\sp\utility::set_favoriteenemy(level.player);
  var_1.balwayscoverexposed = 1;
  var_2 = 0;
  scripts\engine\utility::flag_wait("flag_vo_stairwell_exterior");

  while(isDefined(var_1) && isalive(var_1)) {
    if(sighttracepassed(level.player getEye(), var_1 getEye(), 0, level.player)) {
      var_2++;
      wait 0.1;

      if(var_2 > 6) {
        thread scripts\sp\maps\marines\marines_vo.gsc::vo_groundfloor_alex_corner_dialogue();
        break;
      }
    } else
      waitframe();
  }
}

groundfloor_tripwire_defuse_monitor() {
  var_0 = scripts\engine\utility::getStruct("groundfloor_tripwire_struct", "targetname");
  var_1 = scripts\engine\utility::getStruct("groundfloor_tripwire_nav_block_struct", "targetname");
  var_2 = scripts\engine\utility::getStruct("groundfloor_tripwire_nav_clear_struct", "targetname");
  var_3 = getEnt("groundfloor_tripwire_nav_clip", "targetname");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_groundfloor_alex_tripwire_defused_dialogue();
  thread scripts\sp\maps\marines\marines_utility.gsc::marines_tripwire_monitor(var_0, undefined, var_3, undefined, var_2, undefined, "flag_groundfloor_tripwire_defused");
}

aq_hospital_hall_left_flank_ambusher() {
  var_0 = getspawner("aq_hospital_hall_left_flank_spawner", "targetname");
  var_1 = getspawner("groundfloor_floodspawner_1_left_spawner", "targetname");
  var_2 = getEnt("groundfloor_floodspawner_1_left_retreat_volume", "targetname");
  scripts\engine\utility::flag_wait("flag_groundfloor_floodspawn_1");
  var_3 = var_1 scripts\engine\sp\utility::spawn_ai();
  scripts\engine\utility::flag_wait("flag_groundfloor_left_flanker_spawn");

  if(!scripts\engine\utility::flag("flag_groundfloor_left_flanker_skip")) {
    var_4 = var_0 scripts\engine\sp\utility::spawn_ai();
    waitframe();

    while(isalive(var_4))
      waitframe();

    if(isalive(var_3)) {
      var_3 clearentitytarget();
      var_3 cleargoalvolume();
      waitframe();
      var_3 setgoalvolumeauto(var_2);
    }
  }
}

aq_hall_blind_corner_shooter() {
  var_0 = getspawner("aq_hospital_hall_right_corner_spawner", "targetname");
  var_1 = getEnt("groundfloor_hallway_faketarget", "targetname");
  scripts\engine\utility::flag_wait("flag_groundfloor_initial_autosave");
  var_2 = var_0 scripts\engine\sp\utility::spawn_ai();

  if(isalive(var_2)) {
    var_2 setentitytarget(var_1);
    wait 2;
    var_2 clearentitytarget();
  }

  scripts\engine\utility::flag_wait("flag_groundfloor_blindshooter_retreat");
  scripts\engine\sp\utility::autosave_or_timeout(undefined, 5);
}

aq_hall_cover_move() {
  var_0 = getspawner("aq_groundfloor_cover_mover_spawner", "targetname");
  var_1 = getEnt("groundfloor_moving_cover_1", "targetname");
  var_2 = scripts\engine\utility::getStruct("groundfloor_moving_cover_1_struct", "targetname");
  scripts\engine\utility::flag_wait("flag_groundfloor_cover_mover_spawn");
  var_3 = var_0 scripts\engine\sp\utility::spawn_ai();
  var_1 moveTo(var_2.origin, 1);
}

aq_hospital_hall_right_side() {
  var_0 = getspawner("aq_hospital_hall_far_right_spawner", "targetname");
  var_1 = getEnt("floodspawn_2_retreat_info_volume", "targetname");
  scripts\engine\utility::flag_wait("flag_groundfloor_grenadier_spawn");
  var_2 = var_0 scripts\engine\sp\utility::spawn_ai();
}

aq_hospital_hall_left_side() {
  var_0 = getspawner("groundfloor_left_window_reinforce_spawner", "targetname");
  var_1 = getEnt("floodspawn_2_retreat_info_volume", "targetname");
  scripts\engine\utility::flag_wait("flag_groundfloor_cover_mover_spawn");
  var_2 = var_0 scripts\engine\sp\utility::spawn_ai();
}

lobby_dialogue_manager() {
  scripts\engine\utility::flag_wait("flag_lobby_secured");
  scripts\engine\sp\utility::autosave_or_timeout(undefined, 5);
  scripts\sp\maps\marines\marines_vo.gsc::vo_lobby_marines_secured_dialogue();
  wait 20;

  while(!scripts\engine\utility::flag("flag_groundfloor_hallway_ambush_start")) {
    scripts\sp\maps\marines\marines_vo.gsc::vo_lobby_griggs_nag_dialogue();
    wait(randomfloatrange(15, 23));
  }
}

friendly_groundfloor_setup() {
  scripts\engine\sp\utility::activate_trigger("lobby_groundfloor_stackup", "targetname");
  thread right_door_marine_monitor();
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2.baseaccuracy = 0.9;

      if(isDefined(var_2.asmname))
        var_2 scripts\common\utility::demeanor_override("cqb");
    }
  }

  if(isalive(level.griggs)) {
    level.griggs.baseaccuracy = 0.9;

    if(isDefined(level.griggs.asmname))
      level.griggs scripts\common\utility::demeanor_override("combat");
  }

  scripts\engine\utility::flag_wait("flag_groundfloor_marines_mid");
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_groundfloor_mid");
}

right_door_marine_monitor() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_forcecolor) && var_2.script_forcecolor == "b")
      var_2 scripts\common\ai::set_gunpose("disable");

    var_2 thread gunpose_enabler();
  }
}

gunpose_enabler() {
  scripts\engine\utility::flag_wait("flag_groundfloor_hallway_ambush_start");

  if(isDefined(self) && isalive(self))
    scripts\common\ai::set_gunpose("automatic");
}

groundfloor_color_advance_manager() {
  var_0 = getEnt("color_trigger_groundfloor_advance_1a", "targetname");
  var_1 = getEnt("color_trigger_groundfloor_advance_1b", "targetname");
  var_2 = getEnt("color_trigger_groundfloor_advance_2a", "targetname");
  var_3 = getEnt("color_trigger_groundfloor_advance_2b", "targetname");
  var_4 = getEnt("color_trigger_groundfloor_advance_3a", "targetname");
  var_5 = getEnt("color_trigger_groundfloor_advance_3b", "targetname");
  var_0 thread groundfloor_color_handler(var_1);
  var_1 thread groundfloor_color_handler(var_0);
  var_2 thread groundfloor_color_handler(var_3);
  var_3 thread groundfloor_color_handler(var_2);
  var_4 thread groundfloor_color_handler(var_5);
  var_5 thread groundfloor_color_handler(var_4);
}

groundfloor_color_handler(var_0) {
  self endon("deleted");
  self waittill("trigger");

  if(isDefined(var_0))
    var_0 scripts\engine\utility::trigger_off();
}

groundfloor_entry_door_handler() {
  level.groundfloor_entry_door_left = scripts\sp\door::get_interactive_door("groundfloor_entry_door_left");
  level.groundfloor_entry_door_right = scripts\sp\door::get_interactive_door("groundfloor_entry_door_right");
  level.groundfloor_doors = scripts\sp\door::double_doors_init(level.groundfloor_entry_door_right, level.groundfloor_entry_door_left);
  level.groundfloor_entry_door_left scripts\game\sp\door::remove_door_snake_cam_ability();
  level.groundfloor_entry_door_right scripts\game\sp\door::remove_door_snake_cam_ability();
  level.groundfloor_entry_door_left.script_max_left_angle = 120;
  level.groundfloor_entry_door_left.script_max_right_angle = 120;
  level.groundfloor_entry_door_left scripts\sp\door::init_max_yaws();
  level.groundfloor_entry_door_right.script_max_left_angle = 120;
  level.groundfloor_entry_door_right.script_max_right_angle = 120;
  level.groundfloor_entry_door_right scripts\sp\door::init_max_yaws();
  level.groundfloor_entry_door_left.lockedforai = 1;
  level.groundfloor_entry_door_right.lockedforai = 1;
  level.groundfloor_entry_door_left.door_ajar_custom_func = ::groundfloor_entry_doors_door_ajar_custom_func;
  level.groundfloor_entry_door_right.door_ajar_custom_func = ::groundfloor_entry_doors_door_ajar_custom_func;

  while(!isDefined(level.groundfloor_doors))
    waitframe();

  thread groundfloor_door_bash_monitor();
  level.groundfloor_entry_door_left thread groundfloor_glass_hack();
  level.groundfloor_entry_door_right thread groundfloor_glass_hack();
  level.groundfloor_entry_door_right thread scripts\sp\utility::door_ai_allowed(0);
  level.groundfloor_entry_door_left thread scripts\sp\utility::door_ai_allowed(0);
  scripts\engine\utility::flag_wait("flag_groundfloor_hallway_ambush_start");
  level.groundfloor_entry_door_right thread scripts\sp\utility::door_ai_allowed(1);
  level.groundfloor_entry_door_left thread scripts\sp\utility::door_ai_allowed(1);
}

groundfloor_door_bash_monitor() {
  while(!scripts\engine\utility::flag("flag_groundfloor_hallway_ambush_start")) {
    if(level.groundfloor_entry_door_left.bashed == 1 || level.groundfloor_entry_door_right.bashed == 1)
      scripts\engine\utility::flag_set("flag_groundfloor_hallway_ambush_start");

    waitframe();
  }
}

groundfloor_entry_doors_door_ajar_custom_func() {
  thread scripts\sp\utility::door_force_open_fully();
  self notify("ajar");
  scripts\engine\utility::flag_set("flag_groundfloor_hallway_ambush_start");
}

groundfloor_glass_hack() {
  scripts\engine\utility::waittill_any("ajar", "bashed", "open_completely");
  var_0 = getEntArray("clip", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 connectpaths();
}

groundfloor_civ_manager() {
  var_0 = getspawner("groundfloor_civ_bed_1_spawner", "targetname");
  var_1 = getspawner("groundfloor_civ_bed_2_spawner", "targetname");
  var_2 = getspawner("groundfloor_civ_bed_3_spawner", "targetname");
  var_3 = scripts\engine\utility::getStruct("groundfloor_civ_bed_1_struct", "targetname");
  var_4 = scripts\engine\utility::getStruct("groundfloor_civ_bed_2_struct", "targetname");
  var_5 = scripts\engine\utility::getStruct("groundfloor_civ_bed_3_struct", "targetname");
  var_6 = getspawner("groundfloor_civ_run_1_spawner", "targetname");
  var_6 scripts\engine\sp\utility::add_spawn_function(::hall_rush_civ_behavior, 0, 0);
  var_0 scripts\engine\sp\utility::add_spawn_function(::make_allied);
  var_1 scripts\engine\sp\utility::add_spawn_function(::fail_mission_if_killed);
  scripts\sp\maps\marines\marines_gameplay_civ_ambush.gsc::bed_civ_init(var_0, var_3, 0, 0, 0, 0, "body_civ_syrkistan_male_2_1", "head_sc_m_arakelyan_civ");
  scripts\sp\maps\marines\marines_gameplay_civ_ambush.gsc::bed_civ_init(var_1, var_4, 0, 1, 0, 1);
  var_7 = scripts\sp\maps\marines\marines_gameplay_civ_ambush.gsc::bed_civ_init(var_2, var_5, 0, 0, 0, 1);
  var_7 thread skip_friendly_fire_nag_on_death_bed_civ();
  thread groundfloor_last_stand_manager();
  scripts\engine\utility::flag_wait_any("deathflag_hall_gunner_rear_dead", "flag_groundfloor_civ_runby_1");
  var_8 = var_6 scripts\engine\sp\utility::spawn_ai();
  var_8 thread skip_friendly_fire_nag_on_death_rush_civ();
  scripts\engine\utility::flag_wait("flag_civ_ambush_start");
  var_9 = [];
  var_9 = scripts\engine\sp\utility::get_living_ai_array("ai_civ_groundfloor", "script_noteworthy");

  foreach(var_11 in var_9) {
    if(isDefined(var_11.magic_bullet_shield))
      var_11 scripts\common\ai::stop_magic_bullet_shield();

    var_11 delete();
  }
}

skip_friendly_fire_nag_on_death_bed_civ() {
  self endon("entitydeleted");
  self waittill("damage", var_0, var_1);

  if(var_1 == level.player)
    level.skip_next_friendly_fire_nag = 1;
}

skip_friendly_fire_nag_on_death_rush_civ() {
  self endon("entitydeleted");
  self waittill("death", var_0);

  if(var_0 == level.player)
    level.skip_next_friendly_fire_nag = 1;
}

groundfloor_last_stand_manager() {
  var_0 = getspawner("groundfloor_last_stand_left_spawner", "targetname");
  var_1 = getspawner("groundfloor_last_stand_right_spawner", "targetname");
  var_0 scripts\engine\sp\utility::add_spawn_function(::groundfloor_last_stand_handler, "flag_groundfloor_last_stand_left_encountered", "flag_groundfloor_last_stand_right_encountered");
  var_1 scripts\engine\sp\utility::add_spawn_function(::groundfloor_last_stand_handler, "flag_groundfloor_last_stand_right_encountered", "flag_groundfloor_last_stand_left_encountered");
  scripts\engine\utility::flag_wait("flag_groundfloor_floodspawn_2");
  var_2 = var_0 scripts\engine\sp\utility::spawn_ai();
  var_3 = var_1 scripts\engine\sp\utility::spawn_ai();
}

groundfloor_last_stand_handler(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self.health = 50;
  self.forcelongdeath = 4;
  self.noragdoll = 1;
  scripts\engine\sp\utility::enable_long_death();
  thread groundfloor_last_stand_ignoreme_monitor(var_0);
  self linkTo(spawn("script_origin", self.origin));
  self asmsetstate(self.asmname, "choose_long_death");
  self.desiredtimeofdeath = gettime() + 1000000;
  scripts\engine\utility::flag_wait(var_1);

  if(isDefined(self) && isalive(self))
    self kill();
}

groundfloor_last_stand_ignoreme_monitor(var_0) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(self) && isalive(self))
    self.ignoreme = 1;

  scripts\engine\utility::flag_wait(var_0);
  wait 3;

  if(isDefined(self) && isalive(self))
    self.ignoreme = 0;
}

make_allied() {
  level.groundfloor_bed_civ_hack_ally = self;
  scripts\engine\utility::flag_wait("flag_groundfloor_floodspawn_1");
  self.ignoreme = 0;
  self setthreatbiasgroup("groundfloor_civ_bias");
  setthreatbias("groundfloor_aq_bias", "groundfloor_civ_bias", 120);
  scripts\engine\utility::ent_flag_wait("play_dead");
  self.team = "neutral";
  self.ignoreme = 1;
  self waittill("entitydeleted");
  level.groundfloor_bed_civ_hack_ally = undefined;
}

fail_mission_if_killed() {
  self.friend_kill_points = -10000;
  self waittill("damage", var_0, var_1);

  if(var_1 == level.player) {
    level.friendlyfire["civilians_killed"] = level.friendlyfire["civilians_killed"] + 1;
    level thread scripts\sp\friendlyfire::missionfail(1);
  }
}

groundfloor_civ_run_2_early_death() {
  var_0 = scripts\engine\sp\utility::spawn_ai();
  wait 2;

  if(isalive(var_0))
    var_0 kill();
}

hall_rush_initial_civilians_handler() {
  scripts\engine\utility::flag_wait_any("flag_lobby_exiting", "flag_lobby_secured");
  thread hall_rush_initial_civilians_spawn();
}

hall_rush_initial_civilians_spawn() {
  var_0 = getspawnerarray("lobby_hallway_initial_civ_spawners");
  scripts\engine\sp\utility::array_spawn_function(var_0, ::hall_rush_civ_behavior, 0, 1);
  waitframe();
  var_1 = scripts\engine\sp\utility::array_spawn(var_0);
}

hall_rush_gunners() {
  var_0 = getspawnerarray("lobby_hallway_victim_spawners");
  scripts\engine\sp\utility::array_spawn_function(var_0, ::hall_rush_civ_behavior, 1, 0);
  scripts\engine\utility::flag_wait("flag_groundfloor_hallway_ambush_start");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_groundfloor_civilian_screams_dialogue();
  thread hall_rush_crutch_civs_handler();
  thread hall_rush_gunner_target_handler();
  thread red_marine_cleanup();
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_groundfloor_griggs_hallway_ambush_dialogue();

  foreach(var_2 in var_0) {
    var_2 scripts\engine\sp\utility::spawn_ai();
    wait(randomfloatrange(0.75, 1.5));
  }

  wait 3;
  var_4 = [];
  var_4 = scripts\engine\sp\utility::get_living_ai_array("ai_groundfloor_hallway_1", "script_noteworthy");

  foreach(var_2 in var_4) {
    if(isalive(var_2))
      var_2.team = "allies";
  }
}

hall_rush_crutch_civs_handler() {
  var_0 = scripts\engine\utility::getStruct("civ_crutches_struct", "targetname");
  var_1 = getEnt("prop_crutch", "targetname");
  var_1.animname = "crutch";
  var_1 scripts\engine\sp\utility::assign_animtree("crutch");
  waitframe();
  var_2 = scripts\engine\sp\utility::spawn_targetname("civ_crutch_spawner", 1);
  var_3 = scripts\engine\sp\utility::spawn_targetname("civ_crutch_helper_spawner", 1);
  var_2 scripts\engine\utility::delaycall(3, ::visiblenotsolid);
  var_3 scripts\engine\utility::delaycall(3, ::visiblenotsolid);
  var_2.animname = "civ_crutch";
  var_3.animname = "civ_crutch_helper";
  var_4 = [var_2, var_3, var_1];
  level thread scripts\sp\friendlyfire::friendly_fire_think(var_2);
  level thread scripts\sp\friendlyfire::friendly_fire_think(var_3);
  thread hall_rush_crutch_magic_bullet();
  var_0 anim_then_last_frame_and_kill(var_4, "crutch_runaway");
}

hall_rush_crutch_magic_bullet() {
  var_0 = scripts\engine\utility::getStruct("crutch_magic_bullet_spawn_ref", "targetname");
  var_1 = scripts\engine\utility::getStructArray("crutch_magic_bullet_target", "targetname");
  scripts\engine\utility::flag_wait_or_timeout("flag_groundfloor_initial_autosave", 1.85);

  foreach(var_3 in var_1) {
    magicbullet("iw8_ar_akilo47", var_0.origin, var_3.origin);
    wait 0.1;
  }
}

anim_then_last_frame_and_kill(var_0, var_1) {
  scripts\common\anim::anim_single(var_0, var_1);

  foreach(var_3 in var_0) {
    thread scripts\common\anim::anim_last_frame_solo(var_3, var_1);

    if(isai(var_3)) {
      var_3.forceragdollimmediate = 1;
      var_3 scripts\engine\sp\utility::anim_stopanimScripted();
      var_3 scripts\engine\sp\utility::set_allowdeath(1);
      var_3 scripts\engine\sp\utility::die();
    }
  }
}

hall_rush_civ_behavior(var_0, var_1) {
  self endon("death");
  self.animname = "generic";
  self.disablebulletwhizbyreaction = 1;
  self.disablearrivals = 1;
  self.dontmelee = 1;
  self.health = 1;
  self.ignoreall = 1;
  self.ignoresuppression = 1;
  self.pacifist = 1;
  scripts\engine\sp\utility::set_allowdeath(1);
  scripts\engine\sp\utility::set_goal_radius(48);
  scripts\asm\asm_bb::bb_civilianrequestspeed(200);
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  self enableavoidance(0);
  self.dontavoidplayer = 0;
  thread groundfloor_friendly_fire_penalty_manager();
  var_2 = scripts\engine\utility::getStruct(self.target, "targetname");

  if(var_0 == 1) {
    self.ignoreme = 1;
    self.team = "neutral";
  }

  self.goalanims = ["civ_cctv_cover_left_crouch_hide_idle01", "civ_cctv_cover_right_crouch_hide_idle01", "civ_cctv_exposed_crouch_hide_idle01", "civ_stl_cover_left_crouch_hide_idle01", "civ_stl_cover_right_crouch_hide_idle01", "civ_stl_exposed_crouch_hide_idle01", "civ_cctv_cover_left_crouch_hide_idle02", "civ_cctv_cover_right_crouch_hide_idle02", "civ_cctv_exposed_crouch_hide_idle02", "civ_stl_cover_left_crouch_hide_idle02", "civ_stl_cover_right_crouch_hide_idle02", "civ_stl_exposed_crouch_hide_idle02", "civ_cctv_cover_left_crouch_hide_idle03", "civ_cctv_cover_right_crouch_hide_idle03", "civ_cctv_exposed_crouch_hide_idle03", "civ_stl_cover_left_crouch_hide_idle03", "civ_stl_cover_right_crouch_hide_idle03", "civ_stl_exposed_crouch_hide_idle03"];

  if(var_1 == 0) {
    self waittill("goal");

    if(isDefined(var_2.target)) {
      var_2 = getnode(var_2.target, "targetname");
      self setgoalnode(var_2);
      scripts\sp\maps\marines\marines_utility.gsc::color_node_arrive(var_2);
      thread scripts\common\anim::anim_loop_solo(self, scripts\engine\utility::random(self.goalanims), "end_anim");
    } else
      thread scripts\common\anim::anim_loop_solo(self, "hm_grnd_civ_react02_idle05", "end_anim");
  }
}

hall_rush_gunner_target_handler() {
  var_0 = getspawner("aq_hospital_hall_gunner_spawner", "targetname");
  var_1 = scripts\engine\utility::getStruct("corner_ambush_org", "targetname");
  var_2 = getEnt("ambusher_runto_info_volume", "targetname");
  thread hall_rush_support();
  wait 0.9;
  var_3 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_3.animname = "aq_ambusher";
  var_3 scripts\engine\sp\utility::set_allowdeath(1);
  var_3.ignoreme = 1;
  var_1 scripts\common\anim::anim_single_solo(var_3, "hallway_ambush", undefined, 3.0);

  if(isDefined(var_3) && isalive(var_3))
    var_3.ignoreme = 0;
}

hall_rush_gunner_immunity_timeout() {
  scripts\common\ai::magic_bullet_shield();
  wait 1.5;
  scripts\common\ai::stop_magic_bullet_shield();
}

hall_rush_support() {
  var_0 = getspawner("aq_hospital_hall_gunner_rear_spawner", "targetname");
  var_1 = getspawner("aq_hallway_initial_reinforce_spawner", "targetname");
  var_0 scripts\engine\sp\utility::add_spawn_function(::groundfloor_rear_gunner_handler);
  var_2 = getEnt("aq_corner_cover_volume", "targetname");
  var_3 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  wait 3;
  var_4 = var_1 scripts\engine\sp\utility::spawn_ai();
  scripts\engine\utility::flag_wait("flag_hallway_initial_reinforce_arrived");

  if(isalive(var_4)) {
    var_4 clearentitytarget();
    var_4 cleargoalvolume();
    waitframe();
    var_4 setgoalvolumeauto(var_2);
  }
}

groundfloor_rear_gunner_handler() {
  self setthreatbiasgroup("groundfloor_aq_bias");
}

groundfloor_floodspawn_1_handler() {
  var_0 = getspawnerarray("groundfloor_floodspawner_1_spawners");
  scripts\engine\utility::flag_wait("flag_groundfloor_floodspawn_1");
  scripts\engine\sp\utility::array_spawn(var_0);
}

groundfloor_floodspawn_2_handler() {
  var_0 = getspawnerarray("groundfloor_floodspawner_2_spawners");
  var_1 = getEnt("floodspawn_2_retreat_info_volume", "targetname");
  scripts\engine\utility::flag_wait("flag_groundfloor_floodspawn_2");
  wait 3;
  var_2 = scripts\engine\sp\utility::array_spawn(var_0);
  scripts\engine\utility::flag_wait("flag_groundfloor_start_retreat");
  thread groundfloor_floodspawn_3_reinforce();
  thread groundfloor_floodspawn_3_reinforce_flank();
}

groundfloor_floodspawn_3_handler() {
  var_0 = getspawnerarray("groundfloor_floodspawner_3_spawners");
  scripts\engine\utility::flag_wait("flag_groundfloor_floodspawn_3");
  scripts\engine\sp\utility::flood_spawn(var_0);
}

allies_push_stairwell_early() {
  var_0 = getEnt("color_trigger_groundfloor_final", "targetname");
  scripts\engine\utility::flag_wait("flag_groundfloor_allow_push");
  thread scripts\sp\maps\marines\marines_utility.gsc::spawn_corpses("stairwell_dead_body", "flag_civ_ambush_end");
  thread scripts\sp\maps\marines\marines_utility.gsc::stairwell_corpses_cleanup();
  wait 3;
  var_1 = getaiarray("axis");
  var_2 = 0;
  var_2 = var_1.size - 1;

  if(var_2 < 1)
    scripts\engine\sp\utility::waittill_dead_or_dying(getaiarray("axis"));
  else
    scripts\engine\sp\utility::waittill_dead_or_dying(getaiarray("axis"), var_2);

  if(isDefined(var_0))
    scripts\engine\sp\utility::activate_trigger("color_trigger_groundfloor_final", "targetname");

  var_1 = 0;
  var_1 = getaiarray("axis");
  waitframe();

  while(var_1.size > 0) {
    var_1 = getaiarray("axis");
    wait 1;
  }
}

groundfloor_floodspawn_3_reinforce() {
  var_0 = getspawner("groundfloor_floodspawner_3_reinforce_spawner", "targetname");
  var_1 = [];
  var_2 = 0;

  while(var_2 < 3) {
    if(scripts\engine\utility::flag("flag_groundfloor_start_retreat")) {
      var_1 = scripts\engine\sp\utility::get_living_ai_array("groundfloor_floodspawner_2_spawners", "targetname");

      if(var_1.size < 2) {
        level.groundfloor_floodspawner_3_reinforce = var_0 scripts\engine\sp\utility::spawn_ai();
        wait 5;
        break;
      }
    } else {
      var_2++;
      wait 1;
    }

    waitframe();
  }
}

groundfloor_floodspawn_3_reinforce_flank() {
  var_0 = getspawnerarray("groundfloor_floodspawner_3_reinforce_flank_spawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0);
}

groundfloor_cleanup() {
  scripts\engine\utility::flag_wait("flag_stairwell_exit");
  scripts\sp\spawner::killspawner(100);
  var_0 = [];
  var_0 = scripts\engine\sp\utility::get_living_ai_array("ai_aq_groundfloor", "script_noteworthy");
  scripts\engine\utility::array_delete(var_0);
  scripts\engine\utility::flag_wait("flag_griggs_corner_gate");
  var_1 = [];
  var_1 = scripts\engine\sp\utility::get_living_ai_array("ai_aq_stairwell", "script_noteworthy");
  scripts\engine\utility::array_delete(var_1);
}

lobby_start() {
  var_0 = getEnt("retreat_marines_advance_to_lobby_1", "targetname");
  var_1 = getEnt("retreat_marines_advance_to_lobby_2", "targetname");
  scripts\engine\sp\utility::set_start_location("start_lobby", [level.player]);
  level.griggs = scripts\sp\maps\marines\marines_utility.gsc::setup_named_ai("griggs", "Sgt. Griggs", "start_lobby_griggs", undefined, undefined, undefined, "Demon 1-2");
  var_2 = getspawnerarray("ally_marine_lobby");
  thread scripts\sp\maps\marines\marines_utility.gsc::marines_checkpoint_forcespawn_allies(var_2);
  thread scripts\sp\maps\marines\marines_utility.gsc::ally_equipment_backpack(level.griggs, "smoke_tall");
  thread groundfloor_entry_door_handler();
  scripts\sp\maps\marines\marines_lighting.gsc::sun_adjustments_hospital_force("lighting_hospital", -3);
  var_3 = getEnt("retreat_assault_vehicle_destroyed_clip", "targetname");
  level.retreat_assault_vehicle = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("retreat_assault_vehicle", "Dirt Diggler", "retreat_assault_vehicle_end_node", 0, 0, 0);
  level.retreat_support_apc_1 = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("retreat_support_apc_1", "Goosetickler", "retreat_apc_1_lobby_start_node", 0, 0);
  level.retreat_support_apc_2 = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("retreat_support_apc_2", "Normandy", "retreat_apc_2_lobby_start_node", 1, 0);
  level.retreat_support_apc_1.dontdisconnectpaths = 1;
  level.retreat_support_apc_2.dontdisconnectpaths = 1;
  level.retreat_support_apc_1.script_badplace = 1;
  level.retreat_support_apc_2.script_badplace = 1;
  thread scripts\common\vehicle_paths::gopath(level.retreat_support_apc_1);
  thread scripts\common\vehicle_paths::gopath(level.retreat_support_apc_2);
  var_3.origin = level.retreat_assault_vehicle.origin + (-4, 0, 70);
  var_3.angles = level.retreat_assault_vehicle.angles + (0, -104, 0);
  level.retreat_assault_vehicle scripts\sp\utility::do_damage(9999, level.retreat_assault_vehicle.origin);

  if(isDefined(var_0))
    var_0 scripts\engine\utility::trigger_off();

  if(isDefined(var_1))
    var_1 scripts\engine\utility::trigger_off();

  scripts\engine\sp\utility::activate_trigger("marines_stack_on_first_door_trigger", "targetname");
}

lobby_catchup() {
  scripts\engine\utility::flag_set("flag_lobby_exiting");
  setsaveddvar("TLOLRMSL", 1);
  thread hospital_dof_monitor();
  thread scripts\sp\maps\marines\marines_gameplay_convoy.gsc::apc_cleanup_handler();
  level.griggs_lobby_cleared_vo_done = 1;
}

groundfloor_start() {
  scripts\engine\sp\utility::set_start_location("start_groundfloor", [level.player]);
  level.griggs = scripts\sp\maps\marines\marines_utility.gsc::setup_named_ai("griggs", "Sgt. Griggs", "start_groundfloor_griggs", undefined, undefined, undefined, "Demon 1-2");
  var_0 = getspawnerarray("ally_marine_groundfloor");
  thread scripts\sp\maps\marines\marines_utility.gsc::marines_checkpoint_forcespawn_allies(var_0);
  thread scripts\sp\maps\marines\marines_utility.gsc::ally_equipment_backpack(level.griggs, "smoke_tall");
  thread groundfloor_entry_door_handler();
  thread disable_lobby_color_triggers();
  thread hall_rush_initial_civilians_spawn();
  scripts\sp\maps\marines\marines_lighting.gsc::sun_adjustments_hospital_force("lighting_hospital", -1);
  var_1 = getEnt("retreat_assault_vehicle_destroyed_clip", "targetname");
  level.retreat_assault_vehicle = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("retreat_assault_vehicle", "Dirt Diggler", "retreat_assault_vehicle_end_node", 0, 0, 0);
  level.retreat_support_apc_1 = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("retreat_support_apc_1", "Goosetickler", "retreat_apc_1_groundfloor_start_node", 0, 0);
  level.retreat_support_apc_2 = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("retreat_support_apc_2", "Stormin Norman", "retreat_apc_2_groundfloor_start_node", 0, 0);
  level.retreat_support_apc_1.dontdisconnectpaths = 1;
  level.retreat_support_apc_2.dontdisconnectpaths = 1;
  level.retreat_support_apc_1.script_badplace = 1;
  level.retreat_support_apc_2.script_badplace = 1;
  var_1.origin = level.retreat_assault_vehicle.origin + (-4, 0, 70);
  var_1.angles = level.retreat_assault_vehicle.angles + (0, -104, 0);
  level.retreat_assault_vehicle scripts\sp\utility::do_damage(9999, level.retreat_assault_vehicle.origin);
}

hospital_exterior_vehicle_monitor() {
  scripts\engine\utility::flag_wait("flag_groundfloor_hallway_ambush_start");

  if(isDefined(level.retreat_support_apc_1))
    level.retreat_support_apc_1 delete();

  scripts\engine\utility::flag_wait("flag_groundfloor_flank_fallback");

  if(isDefined(level.retreat_support_apc_2))
    level.retreat_support_apc_2 delete();

  if(!isDefined(level.retreat_assault_vehicle)) {
    var_0 = getEntArray("script_model", "classname");

    foreach(var_2 in var_0) {
      if(var_2.model == "veh8_mil_lnd_bromeo_static_dst")
        level.retreat_assault_vehicle = var_2;
    }
  }

  if(isDefined(level.retreat_assault_vehicle))
    level.retreat_assault_vehicle delete();
}

disable_lobby_color_triggers() {
  var_0 = getEntArray("lobby_color_trigger_to_disable", "targetname");
  waitframe();

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 scripts\engine\utility::trigger_off();
  }
}

groundfloor_catchup() {
  scripts\engine\utility::flag_set("flag_groundfloor_hallway_ambush_start");
  scripts\engine\utility::flag_set("hospital_doors_closed");
  thread containment_groundfloor();
}

#using_animtree("generic_human");

precacheanims() {
  level.scr_animtree["generic"] = #animtree;
  level.scr_anim["generic"]["wounded_idle_a"][0] = % hc_wounded_a;
  level.scr_anim["generic"]["estate_pool_idle"][0] = % est_cy_052_interrogation_knees_hostage_idle_pool;
  level.scr_anim["generic"]["bomber_idle_2"][0] = % reb_stl_alert_idle_react_loop01;
}

red_marine_cleanup() {
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("r");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

hospital_dof_monitor() {
  var_0 = getEntArray("hospital_DOF_volume", "targetname");

  for(;;) {
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(level.player istouching(var_3))
        var_1 = 1;
    }

    if(var_1 == 1)
      scripts\engine\utility::flag_set("hospital_dof_on");

    if(var_1 == 0)
      scripts\engine\utility::flag_clear("hospital_dof_on");

    wait 0.2;
  }
}

containment_groundfloor() {
  if(!isDefined(level.groundfloor_entry_door_left))
    level.groundfloor_entry_door_left = scripts\sp\door::get_interactive_door("groundfloor_entry_door_left");

  if(!isDefined(level.groundfloor_entry_door_right))
    level.groundfloor_entry_door_right = scripts\sp\door::get_interactive_door("groundfloor_entry_door_right");

  waitframe();
  scripts\engine\utility::flag_set("hospital_doors_closed");
  level.groundfloor_entry_door_left scripts\sp\door::reset_door();
  level.groundfloor_entry_door_right scripts\sp\door::reset_door();
  level.groundfloor_entry_door_left scripts\sp\door::remove_open_ability();
  level.groundfloor_entry_door_right scripts\sp\door::remove_open_ability();
  level.groundfloor_entry_door_left.lockedforai = 1;
  level.groundfloor_entry_door_right.lockedforai = 1;
  delete_waste_groundfloor();
}

delete_waste_groundfloor() {
  var_0 = getEntArray("deletable_hospital_lobby", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
    waitframe();
  }
}

containment_groundfloor_teleport() {
  var_0 = getEnt("containment_groundfloor_teleport_volume", "targetname");
  wait 1.0;
  var_1 = getaiarray("allies");
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && isalive(var_4)) {
      if(!var_4 istouching(var_0)) {
        if(var_2 <= 1) {
          var_5 = scripts\engine\utility::getStruct("containment_groundfloor_teleport_destination_" + var_2, "targetname");

          if(isDefined(var_4) && isalive(var_4)) {
            var_4 teleport(var_5.origin);
            var_2++;
          }
        }
      }
    }
  }
}

kill_off_lobby_aq() {
  scripts\engine\utility::flag_wait("flag_lobby_exiting");
  level notify("player_rushed_through_lobby");
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0)
  var_2.baseaccuracy = 1;

  var_4 = getaiarray("axis");

  foreach(var_6 in var_4)
  var_6 thread lobby_aq_make_vulnerable();
}

lobby_aq_make_vulnerable() {
  self waittill("damage", var_0, var_1);

  if(var_1 != level.player && isDefined(self) && isalive(self))
    self kill();
}

groundfloor_friendly_fire_penalty_manager() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    if(self.origin[1] < level.player.origin[1]) {
      break;
    }

    waitframe();
  }

  self.friend_kill_points = -10000;
}