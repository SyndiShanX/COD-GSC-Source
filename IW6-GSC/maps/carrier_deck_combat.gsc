/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_deck_combat.gsc
****************************************/

deck_combat_pre_load() {
  common_scripts\utility::flag_init("fire_missile");
  common_scripts\utility::flag_init("deck_combat_finished");
  common_scripts\utility::flag_init("raise_front_elevator");
  common_scripts\utility::flag_init("front_elevator_raised");
  common_scripts\utility::flag_init("lower_balcony_kill_trigger");
  common_scripts\utility::flag_init("door_missile_launch");
  common_scripts\utility::flag_init("combat_kick");
  common_scripts\utility::flag_init("trigger_ally_death");
  common_scripts\utility::flag_init("elevator_up_ding_ding");
  common_scripts\utility::flag_init("jet_launch1_anim_kick");
  common_scripts\utility::flag_init("jet_spawn_flyover");
  common_scripts\utility::flag_init("jet_launch2_anim_exit");
  common_scripts\utility::flag_init("run_guys_dropoff2");
  common_scripts\utility::flag_init("island_doorshut_player");
  common_scripts\utility::flag_init("island_doorshut_hesh");
  common_scripts\utility::flag_init("door_closed");
  common_scripts\utility::flag_init("hallway_door_close");
  common_scripts\utility::flag_init("fire_on");
  common_scripts\utility::flag_init("fire_on2");
  common_scripts\utility::flag_init("combat_1_kick");
  common_scripts\utility::flag_init("warning_1");
  common_scripts\utility::flag_init("warning_2");
  common_scripts\utility::flag_init("warning_1_rear");
  common_scripts\utility::flag_init("warning_2_rear");
  common_scripts\utility::flag_init("death_time");
  common_scripts\utility::flag_init("death_time_rear");
  common_scripts\utility::flag_init("background_jet_shot");
  common_scripts\utility::flag_init("backfill_heli_death");
  common_scripts\utility::flag_init("final_wave_heli_death");
  common_scripts\utility::flag_init("final_wave_kick");
  common_scripts\utility::flag_init("lead_left_heli_kick");
  common_scripts\utility::flag_init("dc_wave1_allies_advance_1");
  common_scripts\utility::flag_init("dc_wave1_allies_advance_2");
  common_scripts\utility::flag_init("dc_wave1_allies_advance_3");
  common_scripts\utility::flag_init("wave1_heli1_unloaded");
  common_scripts\utility::flag_init("wave1_heli2_unloaded");
  common_scripts\utility::flag_init("dc_wave2_start");
  common_scripts\utility::flag_init("wave2_heli1_unloaded");
  common_scripts\utility::flag_init("wave2_heli2_unloaded");
  common_scripts\utility::flag_init("wave3_heli1_unloaded");
  common_scripts\utility::flag_init("wave3_heli2_unloaded");
  precacheshader("waypoint_ammo_friendly");
  precachestring(&"CARRIER_FAIL_FAR_AWAY");
  precacheitem("panzerfaust3_straight");
  precachemodel("crr_boeing_c17_vista");
  thread maps\carrier_code::check_trigger_flagset("dc_ally_move_1");
  thread maps\carrier_code::check_trigger_flagset("dc_ally_move_2");
  thread maps\carrier_code::check_trigger_flagset("dc_ally_move_3");
  var_0 = getEntArray("kill_triggers", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, maps\_utility::hide_entity);
  var_1 = getent("dc_island_door_clip", "targetname");
  var_1 maps\_utility::hide_entity();
  var_2 = getent("jav_crate", "targetname");
  var_3 = getent("jav_crate_clip", "targetname");
  var_2 maps\_utility::hide_entity();
  var_3 maps\_utility::hide_entity();
  level.sparrow_left = common_scripts\utility::getstruct("dc1_sparrow_left", "targetname");
  level.sparrow_right = common_scripts\utility::getstruct("dc1_sparrow_right", "targetname");
}

setup_deck_combat() {
  level.start_point = "deck_combat";
  maps\carrier_code::setup_common(1);
  maps\carrier_code::spawn_allies();
  maps\_utility::set_team_bcvoice("allies", "delta");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::flavorbursts_on("allies");
  thread maps\carrier::obj_flight_deck();
  thread maps\carrier_audio::aud_check("deck_combat");
  var_0 = getent("water_wake_intro", "targetname");
  var_0 delete();
  var_1 = getent("hallway_door", "targetname");
  var_1 rotateto((0, -90, 0), 0.5);
  var_2 = getent("hallway_door_clip", "targetname");
  var_2 movez(120, 0.5);
  var_3 = getent("hallway_door_open_clip", "targetname");
  var_3 delete();
  common_scripts\utility::flag_set("exterior_effects_off");
  wait 0.25;
  var_2 disconnectpaths();
}

catchup_deck_combat() {
  common_scripts\utility::flag_set("exterior_effects_on");
  thread taxing_jet_anim_catchup();
  var_0 = getent("dc_island_door_clip", "targetname");
  var_0 maps\_utility::show_entity();
  thread medbay_cleanup();
  var_1 = getEntArray("deck_combat_respawn_triggers", "targetname");
  maps\_utility::array_delete(var_1);
}

begin_deck_combat() {
  thread maps\carrier_code::phalanx_gun_fire("crr_phalanx_01");
  thread maps\carrier_code::phalanx_gun_fire("crr_phalanx_02");
  thread maps\carrier_code::phalanx_gun_fire("crr_phalanx_03");
  thread maps\carrier_code::phalanx_gun_fire("crr_phalanx_04");
  thread maps\carrier_code::phalanx_gun_fire("crr_phalanx_05");
  thread maps\carrier_audio::aud_deck_transition_zone();
  thread medbay_cleanup();
  thread jet_blast_shields();
  badplace_brush("badplace_rear_elevator", -1, level.rear_elevator_vol, "axis");
  thread maps\carrier_deck_transition::setup_taxing_osprey();
  var_0 = getent("blast_shield1_clip", "targetname");
  var_0 maps\_utility::show_entity();
  var_1 = getent("blast_shield2_clip", "targetname");
  var_1 maps\_utility::show_entity();
  var_2 = getent("heli_elevator_fake", "script_noteworthy");
  var_2 maps\_utility::show_entity();
  thread setup_static_osprey();
  var_3 = getent("deck_combat_door", "targetname");
  var_4 = getent("dc_island_door_clip", "targetname");
  var_4 maps\_utility::show_entity();
  var_4 linkto(var_3);
  var_4 connectpaths();
  var_3 rotateto(var_3.angles - (0, 100, 0), 0.01);
  thread kill_trigger_setup();
  var_5 = getent("front_kill_volume", "targetname");
  var_6 = getent("rear_kill_volume", "targetname");
  var_5 thread kill_trigger("warning_1");
  var_6 thread kill_trigger("warning_1_rear");
  thread combat_ally_spawn();
  thread deck_combat_nag_vo();
  common_scripts\utility::flag_wait("combat_1_kick");
  common_scripts\utility::flag_set("obj_flight_deck_complete");
  thread maps\carrier::obj_clear_deck();
  thread deck_combat_vo();
  thread run_deck_combat_background();
  thread run_deck_combat();
  common_scripts\utility::flag_wait("deck_combat_finished");
  maps\_utility::activate_trigger_with_noteworthy("stop_deck_combat_respawns");
  var_7 = getEntArray("deck_combat_respawn_triggers", "targetname");
  maps\_utility::array_delete(var_7);

  if(!common_scripts\utility::flag("warning_1_rear") && !common_scripts\utility::flag("warning_1"))
    thread maps\_utility::autosave_tactical();
}

medbay_cleanup() {
  var_0 = getEntArray("ally_intro", "script_noteworthy");
  maps\_utility::array_delete(var_0);
}

jet_blast_shields() {
  var_0 = getent("blast_shield1", "targetname");
  var_0 rotateto((0, 0, 0), 0.05);
  var_1 = getent("blast_shield2", "targetname");
  var_1 rotateto((0, 0, 0), 0.05);
  var_2 = getent("blast_shield3", "targetname");
  var_2 rotateto((0, 0, 0), 0.05);
  var_3 = getent("blast_shield4", "targetname");
  var_3 rotateto((0, 0, 0), 0.05);
  var_4 = getent("blast_shield5", "targetname");
  var_4 rotateto((0, 0, 0), 0.05);
  var_5 = getent("blast_shield6", "targetname");
  var_5 rotateto((0, 0, 0), 0.05);
}

deck_combat_vo() {
  maps\_utility::set_team_bcvoice("allies", "delta");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
  wait 3.5;
  maps\_utility::smart_radio_dialogue("carrier_mrk_tangosondeck");
  wait 1.7;
  maps\_utility::smart_radio_dialogue("carrier_hqr_f18sareinthe");
  common_scripts\utility::flag_wait("dc_wave1_allies_advance_2");
  wait 4;
  maps\_utility::smart_radio_dialogue("carrier_hsh_ospreycomingupon");
  wait 1.5;
  maps\_utility::smart_radio_dialogue("carrier_hqr_multiplerunnersportside");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("carrier_hp1_ihavevisualsbreaking");
  wait 4;
  maps\_utility::smart_radio_dialogue("carrier_hqr_10morebogeyswithin");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("carrier_hp1_negativenagativeairspace");
  wait 6;
  maps\_utility::smart_radio_dialogue("carrier_hqr_secondarytargetsat");
}

deck_combat_nag_vo() {
  level endon("deck_transition");
  level endon("door_closed");
  common_scripts\utility::flag_wait("combat_1_kick");
  var_0 = getent("nag_leave_island", "targetname");

  for(;;) {
    wait 8;

    if(level.player istouching(var_0))
      maps\_utility::smart_radio_dialogue("carrier_hsh_comeonadam");

    wait 8;

    if(level.player istouching(var_0))
      maps\_utility::smart_radio_dialogue("carrier_hsh_loganthisway");
  }
}

run_deck_combat_background() {
  thread handle_front_elevator();
  thread handle_jet_takeoff();
  thread island_drone_anim_helper();
  thread island_drone_anim_wounded();
  thread missile_towerbuzz();
  thread walkout_jet_attack();
  thread hallway_door_shut();
  thread island_door_shut();
  thread maps\carrier_deck_transition::trans_talker();
  thread handle_jet_taxi();
  wait 0.5;
}

#using_animtree("generic_human");

handle_front_elevator() {
  thread front_elevator_jet_anim();
  thread maps\carrier_audio::aud_deck_tugger();
  var_0 = getEntArray("anim_tugger", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);
  var_1 = [];
  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_0) {
    if(var_5.script_noteworthy == "item") {
      var_1 = var_5;
      continue;
    }

    if(var_5.script_noteworthy == "clip") {
      var_2 = var_5;
      continue;
    }

    var_3 = var_5;
  }

  var_2 linkto(var_1);
  var_3 delete();
  var_1.animname = "tugger";
  var_1 maps\_anim::setanimtree();
  var_7 = common_scripts\utility::getstruct("redshirt_forklift_stopper_ref", "targetname");
  var_8 = [];
  var_8[0] = maps\_utility::spawn_targetname("tugger_director");
  var_8[0].animname = "director";
  var_8[0] maps\_utility::gun_remove();
  var_8[0].damageshield = 1;
  var_8[0].ignoreme = 1;
  var_8[1] = maps\_utility::spawn_targetname("tugger_inspector1");
  var_8[1].animname = "inspector1";
  var_8[1] maps\_utility::gun_remove();
  var_8[1].damageshield = 1;
  var_8[1].ignoreme = 1;
  var_8[2] = maps\_utility::spawn_targetname("tugger_inspector2");
  var_8[2].animname = "inspector2";
  var_8[2] maps\_utility::gun_remove();
  var_8[2].damageshield = 1;
  var_8[2].ignoreme = 1;
  var_8[3] = maps\_utility::spawn_targetname("jet_pilot");
  var_8[3].animname = "pilot";
  var_8[3] maps\_utility::gun_remove();
  var_8[3].damageshield = 1;
  var_8[3].ignoreme = 1;
  var_7 thread maps\_anim::anim_single(var_8, "tugger_scene_enter");
  var_7 thread maps\_anim::anim_single_solo(var_1, "tugger_scene_enter");
  wait 7.8;
  var_9 = getent("elevator_jet_kill", "targetname");
  var_9 thread elevator_jet_kill();
  var_1 waittillmatch("single anim", "end");
  var_9 notify("end_kill");
  common_scripts\utility::array_remove(var_8, var_8[3]);

  if(isalive(var_8[0])) {
    var_8[0].target = "tugger_director_paths";
    var_8[0].runanim = maps\_utility::getgenericanim("unarmed_run");
    var_8[0].idleanim = % unarmed_cowercrouch_idle;
    var_8[0].goalradius = 16;
    wait 0.15;
    var_8[0] thread maps\_drone::drone_move();
    var_8[0] thread maps\carrier_code::safe_delete_drone(1500);
  }

  if(isalive(var_8[1])) {
    var_8[1].target = "tugger_inspector1_paths";
    var_8[1].runanim = maps\_utility::getgenericanim("unarmed_run");
    var_8[1].idleanim = % unarmed_cowercrouch_idle;
    var_8[1].goalradius = 16;
    var_8[1] thread maps\_drone::drone_move();
    var_8[1] thread maps\carrier_code::safe_delete_drone(1500);
  }

  if(isalive(var_8[2])) {
    var_8[2].target = "tugger_inspector2_paths";
    var_8[2].runanim = maps\_utility::getgenericanim("unarmed_run");
    var_8[2].idleanim = % unarmed_cowercrouch_idle;
    var_8[2].goalradius = 16;
    wait 0.25;
    var_8[2] thread maps\_drone::drone_move();
    var_8[2] thread maps\carrier_code::safe_delete_drone(1500);
  }

  common_scripts\utility::flag_wait("deck_combat_finished");

  if(isalive(var_8[3]))
    var_8[3] delete();
}

elevator_jet_kill() {
  self endon("end_kill");
  level.player endon("death");

  for(;;) {
    if(level.player istouching(self))
      level.player kill();

    wait 0.05;
  }
}

front_elevator_jet_anim() {
  var_0 = common_scripts\utility::getstruct("redshirt_forklift_stopper_ref", "targetname");
  var_1 = maps\carrier_code::setup_jet_and_clip("front_elevator_jet");
  var_1.animname = "elevator_jet";
  var_1 maps\_anim::setanimtree();
  var_0 maps\_anim::anim_single_solo(var_1, "elevator_jet_scene_enter");
}

handle_jet_takeoff() {
  thread maps\carrier_code::carrier_life_jet_takeoff_guys("jet_handler1", "launch1_handler1", "jet_launch1_handler1_paths", "jet_takeoff1_exit", 0.8, 8);
  thread maps\carrier_code::carrier_life_jet_takeoff_guys("jet_handler2", "launch1_handler2", "jet_launch1_handler2_paths", "jet_takeoff1_exit", 0.9, 8);
  thread maps\carrier_code::carrier_life_jet_takeoff_guys("jet_shooter1", "launch1_shooter1", "jet_launch1_shooter1_paths", "jet_takeoff1_exit", 1, 8);
  thread jet_takeoff1();
  thread maps\carrier_code::carrier_life_jet_takeoff_guys("jet_handler1", "launch2_handler1", "jet_launch2_handler1_paths", "jet_takeoff2_exit", 0.7, 12.5);
  thread maps\carrier_code::carrier_life_jet_takeoff_guys("jet_handler2", "launch2_handler2", "jet_launch2_handler2_paths", "jet_takeoff2_exit", 0.9, 12.5);
  thread maps\carrier_code::carrier_life_jet_takeoff_guys("jet_shooter1", "launch2_shooter1", "jet_launch2_shooter1_paths", "jet_takeoff2_exit", 1, 12.5);
  thread jet_takeoff2();
}

jet_takeoff1() {
  thread maps\carrier_audio::aud_deck_jet_catapult_01();
  maps\carrier_code::carrier_life_jet_takeoff_jet("anim_jet_launcher1", "jet_launcher1", "jet_takeoff1_exit", 8);
}

jet_takeoff2() {
  thread maps\carrier_audio::aud_deck_jet_catapult_02();
  maps\carrier_code::carrier_life_jet_takeoff_jet("anim_jet_launcher2", "jet_launcher2", "jet_takeoff2_exit", 12.5);
}

handle_jet_taxi() {
  var_0 = common_scripts\utility::getstruct("jet_tugger_ref", "targetname");
  var_1 = [];
  var_1[3] = maps\carrier_code::setup_jet_and_clip("odin_jet_1");
  var_1[0] = maps\_utility::spawn_targetname("taxing_tugger_driver");
  var_1[0].animname = "tugger_kill_driver";
  var_1[0].diequietly = 1;
  var_1[0].skipdeathanim = 1;
  var_1[0].allowdeath = 0;
  var_1[0] setCanDamage(0);
  var_1[0].damageshield = 1;
  var_1[0] maps\_utility::gun_remove();
  var_1[0] thread maps\_utility::magic_bullet_shield(1);
  var_2 = getEntArray("large_tugger2", "targetname");
  var_3 = [];
  var_4 = [];
  var_5 = [];

  foreach(var_7 in var_2) {
    if(var_7.script_noteworthy == "item") {
      var_1[2] = var_7;
      continue;
    }

    if(var_7.script_noteworthy == "clip") {
      var_4 = var_7;
      continue;
    }

    var_5 = var_7;
  }

  var_4 linkto(var_1[2]);
  var_5 linkto(var_1[2]);
  var_1[2].animname = "taxing_tugger";
  var_1[2] maps\_anim::setanimtree();
  var_1[3].animname = "taxing_jet";
  var_1[3] maps\_anim::setanimtree();
  common_scripts\utility::waitframe();
  var_0 maps\_anim::anim_first_frame(var_1, "taxing_tugger_kill");
  common_scripts\utility::flag_wait_or_timeout("island_doorshut_player", 7);
  var_0 thread maps\_anim::anim_single(var_1, "taxing_tugger_kill");
  wait 0.2;
  maps\_anim::anim_set_rate(var_1, "taxing_tugger_kill", 0.85);
  wait 5;

  if(isalive(var_1[0])) {
    var_1[0] setlookattext("", &"");
    var_1[0].name = "";
  }

  common_scripts\utility::flag_wait("defend_zodiac_osprey_turn");

  if(isalive(var_1[0]))
    var_1[0] delete();
}

taxing_jet_anim_catchup() {
  var_0 = common_scripts\utility::getstruct("jet_tugger_ref", "targetname");
  var_1 = getEntArray("large_tugger2", "targetname");
  var_2 = [];
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_1) {
    if(var_6.script_noteworthy == "item") {
      var_2 = var_6;
      continue;
    }

    if(var_6.script_noteworthy == "clip") {
      var_3 = var_6;
      continue;
    }

    var_4 = var_6;
  }

  var_3 linkto(var_2);
  var_4 linkto(var_2);
  var_2.animname = "taxing_tugger";
  var_2 maps\_anim::setanimtree();
  var_8 = maps\carrier_code::setup_jet_and_clip("odin_jet_1");
  var_8.animname = "taxing_jet";
  var_8 maps\_anim::setanimtree();
  common_scripts\utility::waitframe();
  var_9 = [var_8, var_2];
  var_0 thread maps\_anim::anim_single(var_9, "taxing_tugger_kill");
  var_0 maps\_anim::anim_set_rate(var_9, "taxing_tugger_kill", 100);
  var_9[0] waittillmatch("single anim", "end");
}

hallway_door_shut() {
  common_scripts\utility::flag_wait("hallway_door_close");

  if(level.start_point != "deck_combat") {
    var_0 = getent("hallway_door", "targetname");
    var_0 rotateto((0, -90, 0), 0.5);
    var_1 = getent("hallway_door_clip", "targetname");
    var_1 movez(120, 0.5);
    var_2 = getent("hallway_door_open_clip", "targetname");
    var_2 delete();
    wait 0.25;
    var_1 disconnectpaths();
  }
}

island_door_shut() {
  common_scripts\utility::flag_wait("island_doorshut_player");
  common_scripts\utility::flag_wait("island_doorshut_hesh");

  if(!common_scripts\utility::flag("warning_1_rear") && !common_scripts\utility::flag("warning_1"))
    thread maps\_utility::autosave_tactical();

  var_0 = getent("deck_combat_door", "targetname");
  var_0 rotateto(var_0.angles - (0, -100, 0), 0.5);
  var_1 = getent("dc_island_door_clip", "targetname");
  var_1 maps\_utility::show_entity();
  thread maps\carrier_audio::aud_hatch_close();
  common_scripts\utility::flag_set("door_closed");
}

island_drone_anim_helper() {
  var_0 = 1.5;
  var_1 = common_scripts\utility::getstruct("island_wounded_ref", "targetname");
  var_2 = getent("redshirt_island_idle", "targetname");
  var_3 = var_2 maps\_utility::spawn_ai(1, 0);
  var_3.animname = "generic";
  var_3 maps\_utility::gun_remove();
  var_4 = getanimlength(%hijack_tarmac_drag_from_engine_agent1);
  var_5 = var_0 / var_4;
  var_1 thread maps\_anim::anim_single_solo(var_3, "island_drag1");
  var_3 notify("stop_sequencing_notetracks");
  common_scripts\utility::waitframe();
  var_3 setanimtime(%hijack_tarmac_drag_from_engine_agent1, var_5);
  wait 10;
  var_1 thread maps\_anim::anim_loop_solo(var_3, "island_drag1_loop");
  common_scripts\utility::flag_wait("door_closed");

  if(isalive(var_3))
    var_3 delete();
}

island_drone_anim_wounded() {
  var_0 = 1.5;
  var_1 = common_scripts\utility::getstruct("island_wounded_ref", "targetname");
  var_2 = getent("redshirt_island_idle2", "targetname");
  var_3 = var_2 maps\_utility::spawn_ai(1, 0);
  var_3.animname = "generic";
  var_3 maps\_utility::gun_remove();
  var_4 = getanimlength(%hijack_tarmac_drag_from_engine_agent2);
  var_5 = var_0 / var_4;
  var_1 thread maps\_anim::anim_single_solo(var_3, "island_drag2");
  var_3 notify("stop_sequencing_notetracks");
  common_scripts\utility::waitframe();
  var_3 setanimtime(%hijack_tarmac_drag_from_engine_agent2, var_5);
  wait 10;
  var_1 thread maps\_anim::anim_loop_solo(var_3, "island_drag2_loop");
  common_scripts\utility::flag_wait("door_closed");

  if(isalive(var_3))
    var_3 delete();
}

missile_towerbuzz() {
  common_scripts\utility::flag_wait("door_missile_launch");
  level.player setmovespeedscale(1);
  level.player allowsprint(1);
  var_0 = getent("jet_missile_launch1_struct", "targetname");
  var_1 = getent("jet_missile_launch1_struct_endpoint", "targetname");
  magicbullet("panzerfaust3_straight", var_0.origin, var_1.origin);
  var_2 = getent("jet_missile_launch3_struct", "targetname");
  var_3 = getent("jet_missile_launch3_struct_endpoint", "targetname");
  magicbullet("panzerfaust3_straight", var_2.origin, var_3.origin);
}

run_deck_combat() {
  maps\_utility::array_spawn_function_noteworthy("wave1_dropoff_guys2", ::dc_shotgun_seek);
  maps\_utility::array_spawn_function_noteworthy("wave2_dropoff_guys1", ::dc_shotgun_seek);
  maps\_utility::array_spawn_function_noteworthy("final_wave_guys2", ::dc_shotgun_seek);
  thread starting_combat_encounter();
  thread deck_combat_wave1();
  thread deck_combat_wave1_flank();
  thread deck_combat_wave1_helis();
  var_0 = getent("rear_elevator_clip", "targetname");
  var_0 delete();
  common_scripts\utility::flag_wait("dc_wave2_start");
  thread deck_combat_wave2_helis();
  thread deck_combat_wave2_ambient_jets();
  thread deck_combat_wave3();
  thread deck_combat_wave3_helis();
  wait 1;
}

starting_combat_encounter() {
  var_0 = maps\_utility::spawn_targetname("instant_dead_ally");
  var_0 maps\_utility::magic_bullet_shield();
  common_scripts\utility::flag_wait("jet_spawn_flyover");
  wait 0.5;
  var_0 maps\_utility::stop_magic_bullet_shield();
  var_0 thread maps\ss_util::fake_death_bullet();
}

combat_ally_spawn() {
  var_0 = maps\_utility::array_spawn_targetname("deck_combat_allies", 1);

  foreach(var_2 in var_0) {
    var_2.ignoreme = 1;
    var_2.ignoreall = 1;
    var_2 thread maps\_utility::replace_on_death();
  }

  common_scripts\utility::flag_wait("jet_launch1_anim_kick");

  foreach(var_2 in var_0) {
    var_2.ignoreme = 0;
    var_2.ignoreall = 0;
    var_2 thread maps\_utility::replace_on_death();
  }
}

deck_combat_wave1() {
  level.hesh maps\_utility::set_ignoresuppression(1);
  var_0 = maps\_utility::array_spawn_targetname("starting_combat_guys", 1);
  var_1 = maps\_utility::array_spawn_targetname("starting_combat_guys_rear", 1);
  thread maps\carrier_deck_transition::carried_grape();
  thread maps\carrier_deck_transition::carrier_grape();
  thread maps\carrier_deck_transition::taxing_osprey_cart_drone_anims();
  common_scripts\utility::waitframe();
  thread maps\carrier_code::ai_array_killcount_flag_set(var_0, int(var_0.size - 2), "dc_wave1_allies_advance_1");
  common_scripts\utility::flag_wait("wave1_heli1_unloaded");
  var_2 = maps\_utility::get_living_ai_array("wave1_dropoff_guys1", "script_noteworthy");
  var_3 = common_scripts\utility::array_combine(var_1, var_2);
  thread maps\carrier_code::ai_array_killcount_flag_set(var_3, int(var_3.size - 3), "dc_wave1_allies_advance_2");
  common_scripts\utility::flag_wait("dc_wave1_allies_advance_1");
  var_4 = maps\_utility::array_spawn_targetname("starting_combat_guys_left", 1);
  thread maps\carrier_code::retreat_from_vol_to_vol("dc_wave1_front_vol", "dc_wave1_front_retreat_vol", 0.15, 0.5);
  common_scripts\utility::flag_wait("dc_wave1_allies_advance_2");
  thread maps\carrier_code::retreat_from_vol_to_vol("dc_wave1_rear_vol", "dc_wave1_rear_retreat_vol", 0.25, 0.6);
  thread maps\carrier_deck_transition::bring_up_osprey();
  var_5 = getent("wave1_enemy_count_check", "targetname");
  var_6 = var_5 maps\_utility::get_ai_touching_volume("axis");
  thread maps\carrier_code::ai_array_killcount_flag_set(var_6, var_6.size - 6, "dc_wave2_start");
  common_scripts\utility::flag_wait("dc_wave2_start");
  thread maps\carrier_code::retreat_from_vol_to_vol("wave1_enemy_count_check", "dc_wave2_vol", 0.5, 1.25);
  wait 2;
  var_7 = getent("dc_ally_move_2", "targetname");

  if(isDefined(var_7))
    var_7 delete();

  maps\_utility::activate_trigger_with_targetname("dc_ally_move_3");
}

deck_combat_wave1_flank() {
  common_scripts\utility::flag_wait_either("player_taking_flank", "dc_wave1_allies_advance_2");

  if(common_scripts\utility::flag("player_taking_flank")) {
    maps\_utility::array_spawn_function_targetname("deck_combat_left_reinforcement", ::dc_shotgun_seek);
    var_0 = maps\_utility::array_spawn_targetname("deck_combat_left_reinforcement", 1);
  } else {
    var_1 = getent("player_flank_trigger", "targetname");
    var_1 delete();
  }
}

deck_combat_wave1_helis() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("wave1_heli1");
  var_0 thread heli_unload_flag_set("wave1_heli1_unloaded");
  var_0 thread heli_damage_check();
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("wave1_heli2");
  var_1 thread heli_unload_flag_set("wave1_heli2_unloaded");
  var_1 thread heli_damage_check();
  var_2 = [var_0, var_1];
  var_2 thread heli_array_setup();
}

heli_damage_check() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4);
  var_5 = 0;
}

dc_shotgun_seek() {
  if(issubstr(self.model, "shotgun"))
    maps\_utility::player_seek_enable();
}

deck_combat_wave2_helis() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("wave2_heli1");
  var_0 thread heli_unload_flag_set("wave2_heli1_unloaded");
  var_0 thread heli_damage_check();
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("wave2_heli2");
  var_1 thread heli_unload_flag_set("wave2_heli2_unloaded");
  var_1 thread heli_damage_check();
  var_2 = [var_0, var_1];
  var_2 thread heli_array_setup();
  common_scripts\utility::flag_wait("wave2_heli1_unloaded");
  maps\_utility::smart_radio_dialogue("carrier_hsh_enemieslandingonthe");
}

deck_combat_wave3() {
  common_scripts\utility::flag_wait("wave2_heli2_unloaded");
  var_0 = getent("final_enemy_vol", "targetname");
  var_1 = var_0 maps\_utility::get_ai_touching_volume("axis");
}

deck_combat_wave3_helis() {
  common_scripts\utility::flag_wait("wave2_heli1_unloaded");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("wave3_heli1");
  var_0 thread heli_unload_flag_set("wave3_heli1_unloaded");
  var_0 thread heli_damage_check();
  maps\_utility::activate_trigger_with_targetname("hesh_final_move");
  level.hesh maps\_utility::set_ignoresuppression(1);
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("wave3_heli2");
  var_1 thread heli_unload_flag_set("wave3_heli2_unloaded");
  var_1 thread heli_damage_check();
  var_2 = [var_0, var_1];
  var_2 thread heli_array_setup();
  common_scripts\utility::flag_wait("wave3_heli2_unloaded");
  common_scripts\utility::flag_set("deck_combat_finished");
}

walkout_jet_attack() {
  common_scripts\utility::flag_wait("jet_spawn_flyover");
  thread maps\carrier_audio::aud_play_deck_reveal_music();
  thread maps\carrier_audio::aud_play_jets_zoomby();
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("jet_dogfighters_flyby");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("wave1_heli_death");
  var_1 kill();
}

deck_combat_wave2_ambient_jets() {
  common_scripts\utility::flag_wait("wave2_heli2_unloaded");
  thread maps\carrier_audio::aud_wave2_ambient_jets();
  maps\_vehicle::spawn_vehicle_from_targetname_and_drive("low_flyby_enemy");
  maps\_vehicle::spawn_vehicle_from_targetname_and_drive("low_flyby_ally");
}

deck_combat_wave3_ambient_jets() {
  common_scripts\utility::flag_wait("wave3_heli2_unloaded");
  wait 8;
  thread maps\carrier_audio::aud_wave3_ambient_jets();
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("jet_dogfighter_enemy");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("jet_dogfighter_ally");
  common_scripts\utility::flag_wait("dogfight_death");
  playFX(level._effect["vfx_missile_death_air"], var_0.origin);
}

kill_trigger_setup() {
  var_0 = getEntArray("kill_triggers", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);
  common_scripts\utility::flag_wait("defend_zodiac");
  common_scripts\utility::array_thread(var_0, maps\_utility::hide_entity);
}

kill_trigger(var_0) {
  level endon("defend_zodiac");

  for(;;) {
    common_scripts\utility::flag_wait(var_0);
    maps\_utility::smart_radio_dialogue("carrier_hsh_regrouponme");

    if(level.player istouching(self)) {
      wait 3;
      maps\_utility::smart_radio_dialogue("carrier_hsh_moveyourasslogan");

      if(level.player istouching(self)) {
        wait 3;
        maps\_utility::smart_radio_dialogue("carrier_hsh_logangetoverhere");

        if(level.player istouching(self)) {
          wait 2;
          setDvar("ui_deadquote", &"CARRIER_FAIL_FAR_AWAY");
          maps\_utility::missionfailedwrapper();
        }
      }
    }

    common_scripts\utility::flag_clear(var_0);
    wait 0.05;
  }
}

heli_array_setup() {
  foreach(var_1 in self) {
    var_1.path_gobbler = 1;

    if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "kill_engine_sound")
      var_1 vehicle_turnengineoff();

    var_1 waittill("unloaded");
    var_2 = [var_1];
    maps\_utility::ai_delete_when_out_of_sight(var_2, 15000);
  }
}

heli_unload_flag_set(var_0) {
  common_scripts\utility::waittill_any("unloaded", "death");
  common_scripts\utility::flag_set(var_0);
}

setup_static_osprey() {
  var_0 = getent("heli_elevator_fake", "script_noteworthy");
  var_1 = getent("taxing_osprey_clip", "targetname");
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1 linkto(var_0, "tag_body", (-75, 0, -125), (0, 0, 0));
  level.elevator_osprey_clip = var_1;
}