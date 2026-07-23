/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_deltacamp.gsc
*****************************************/

main() {
  if(!isDefined(level.trainer_version)) {
    level.trainer_version = 1;
  }
  precachestring(&"SO_DELTACAMP_OBJ_V1");
  precachestring(&"SO_DELTACAMP_OBJ_V2");
  precachestring(&"SO_DELTACAMP_CIV_COUNT");
  precachestring(&"SO_DELTACAMP_CIVILIAN_HIT");
  precachestring(&"SO_DELTACAMP_AREA_CLEARED");
  precachestring(&"SO_DELTACAMP_SCOREBOARD_FINISH_TIME");
  precachestring(&"SO_DELTACAMP_SCOREBOARD_ENEMIES_HIT");
  precachestring(&"SO_DELTACAMP_SCOREBOARD_CIVS_HIT");
  precachestring(&"SO_DELTACAMP_SCOREBOARD_FINAL_TIME");
  precachestring(&"SO_DELTACAMP_DEAD_QUOTE_ALLY_HURT");
  precachemodel("com_folding_chair");
  maps\_specialops::so_hud_stars_precache();
  maps\_utility::default_start(::start_mission);
  maps\_utility::add_start("start_assault", ::start_mission);
  maps/createart/so_deltacamp_art::main();
  maps/so_deltacamp_fx::main();
  maps/so_deltacamp_precache::main();
  maps\so_deltacamp_anim::main();
  maps\_load::main();
  maps\_compass::setupminimap("compass_map_so_deltacamp");
  setsaveddvar("compassmaxrange", "1200");
  thread maps\so_deltacamp_amb::main();
  maps\_audio::aud_disable_deathsdoor_audio();
  init_level_flags();
  maps\_utility::set_vision_set("so_deltacamp", 0);
  setup_level_hud();
  setup_gameplay();
  level.challenge_time_force_on = 1;
  thread maps\_specialops::enable_challenge_timer(level.challenge_flag_start, level.challenge_flag_complete);
  thread maps\_specialops::fade_challenge_in(undefined, 0);
  thread maps\_specialops::fade_challenge_out("fade_challenge_out", 1);
  thread setup_all_player_hud();

  if(level.trainer_version == 2) {
    thread maps\_specialops::enable_triggered_complete(level.challenge_trig_complete_noteworthy, "all_players_reached_end", "any");
  }
}

init_level_flags() {
  common_scripts\utility::flag_init("course_start_open_gate");
  common_scripts\utility::flag_init("course_targets_finished");
  common_scripts\utility::flag_init("all_players_reached_end");
  common_scripts\utility::flag_init("fade_challenge_out");
  common_scripts\utility::flag_init("so_training_deltacamp_start_v1");
  common_scripts\utility::flag_init("so_training_deltacamp_complete_v1");
  common_scripts\utility::flag_init("trig_level_end_v1");
  common_scripts\utility::flag_init("duck_shoot_targets_pop");
  common_scripts\utility::flag_init("so_training_deltacamp_start_v2");
  common_scripts\utility::flag_init("so_training_deltacamp_complete_v2");
  common_scripts\utility::flag_init("trig_level_end_v2");
  common_scripts\utility::flag_init("breach_second_room_started");
  common_scripts\utility::flag_init("target_group_root_v1_02_popped");
  common_scripts\utility::flag_init("target_group_root_v1_02_cleared");
  common_scripts\utility::flag_init("target_group_root_v1_03_popped");
  common_scripts\utility::flag_init("target_group_root_v1_03_cleared");
  common_scripts\utility::flag_init("target_group_root_v1_04_popped");
  common_scripts\utility::flag_init("target_group_root_v1_04_cleared");
  common_scripts\utility::flag_init("target_group_root_v1_05_popped");
  common_scripts\utility::flag_init("target_group_root_v1_05_cleared");
  common_scripts\utility::flag_init("target_group_root_v1_06_popped");
  common_scripts\utility::flag_init("target_group_root_v1_06_cleared");
  common_scripts\utility::flag_init("target_group_root_v1_07_popped");
  common_scripts\utility::flag_init("target_group_root_v1_07_cleared");
  common_scripts\utility::flag_init("target_group_root_v1_08_popped");
  common_scripts\utility::flag_init("target_group_root_v1_08_cleared");
  common_scripts\utility::flag_init("target_group_root_v1_09_popped");
  common_scripts\utility::flag_init("target_group_root_v1_09_cleared");
  common_scripts\utility::flag_init("target_group_root_v2_01_popped");
  common_scripts\utility::flag_init("target_group_root_v2_01_cleared");
  common_scripts\utility::flag_init("target_group_root_v2_02_popped");
  common_scripts\utility::flag_init("target_group_root_v2_02_cleared");
  common_scripts\utility::flag_init("target_group_root_v2_03_popped");
  common_scripts\utility::flag_init("target_group_root_v2_03_cleared");
  common_scripts\utility::flag_init("target_group_root_v2_04_popped");
  common_scripts\utility::flag_init("target_group_root_v2_04_cleared");
  common_scripts\utility::flag_init("target_group_root_v2_05_popped");
  common_scripts\utility::flag_init("target_group_root_v2_05_cleared");
  common_scripts\utility::flag_init("target_group_root_v2_06_popped");
  common_scripts\utility::flag_init("target_group_root_v2_06_cleared");
  common_scripts\utility::flag_init("target_group_root_v2_07_popped");
  common_scripts\utility::flag_init("target_group_root_v2_07_cleared");
  common_scripts\utility::flag_init("target_group_root_v2_08_popped");
  common_scripts\utility::flag_init("target_group_root_v2_08_cleared");
}

setup_gameplay() {
  init_stat_vars();
  var_0 = ["target_group_root_v1_02", "target_group_root_v1_03", "target_group_root_v1_04", "target_group_root_v1_05", "target_group_root_v1_06", "target_group_root_v1_07", "target_group_root_v1_08", "target_group_root_v1_09"];
  var_1 = ["target_group_root_v2_01", "target_group_root_v2_02", "target_group_root_v2_03", "target_group_root_v2_04", "target_group_root_v2_05", "target_group_root_v2_06", "target_group_root_v2_07", "target_group_root_v2_08"];

  if(level.trainer_version == 1) {
    delete_ents("v2_only");
    delete_ents("v2_coop_only");

    if(!maps\_utility::is_coop()) {
      delete_ents("v1_coop_only");
    }
    level.challenge_flag_start = "so_training_deltacamp_start_v1";
    level.challenge_flag_complete = "so_training_deltacamp_complete_v1";
    thread course_think(var_0, var_1);
  } else if(level.trainer_version == 2) {
    delete_ents("v1_only");
    delete_ents("v1_coop_only");

    if(!maps\_utility::is_coop()) {
      delete_ents("v2_coop_only");
    }
    doors_adjust_for_version_2();
    setup_breach();
    level.challenge_flag_start = "so_training_deltacamp_start_v2";
    level.challenge_flag_complete = "so_training_deltacamp_complete_v2";
    level.challenge_trig_complete_noteworthy = "trig_level_end_v2";
    thread course_think(var_1, var_0);
  }

  thread on_mission_success();
  thread setup_fail_triggers();
  thread objective_think();
  thread setup_dialog();
  thread setup_allies();
  thread setup_players();
  thread _id_004B();
  level.custom_eog_no_defaults = 1;
  level.eog_summary_callback = ::custom_eog_summary;
  common_scripts\utility::trigger_off("trig_mission_end_slide", "targetname");
}

delete_ents(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  common_scripts\utility::array_call(var_1, ::delete);
}

on_flag_set_up_slide(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);
  common_scripts\utility::trigger_on(var_1, "targetname");
}

on_mission_success() {
  level endon("special_op_terminated");

  if(level.trainer_version == 1) {
    common_scripts\utility::flag_wait("course_targets_finished");
  } else if(level.trainer_version == 2) {
    common_scripts\utility::flag_wait("all_players_reached_end");
  }
  common_scripts\utility::flag_set(level.challenge_flag_complete);
  wait 1.0;
  common_scripts\utility::flag_set("fade_challenge_out");
}

doors_adjust_for_version_2() {
  var_0 = getEntArray("door_ent", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_goalyaw)) {
      var_2.script_goalyaw = var_2.script_goalyaw * -1;
    }
  }

  foreach(var_2 in var_0) {
    if(var_2 has_script_parameter("door_before", ";")) {
      var_2 replace_script_parameter("door_before", "door_after", ";");
      continue;
    }

    if(var_2 has_script_parameter("door_after", ";")) {
      var_2 replace_script_parameter("door_after", "door_before", ";");
    }
  }
}

_id_004B() {
  var_0 = getEntArray("destructible_vehicle", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_vehicle::godon);
}

setup_breach() {
  if(!maps\_utility::is_coop()) {
    level.player thread animscripts\combat_utility::watchreloading();
  }
  level.breach_no_auto_reload = 1;
  level.slowmo_viewhands = "viewhands_player_delta";
  maps/_slowmo_breach::slowmo_breach_init();
  level.slomobreachduration = 2.0;
  maps/_slowmo_breach::add_breach_func(::on_breach);
  level._effect["breach_door"] = loadfx("explosions/breach_door_metal");
  level._effect["breach_room"] = loadfx("explosions/breach_room_cheap");
  thread breach_think();
}

on_breach(var_0) {
  if(!isDefined(level.so_trainer_breach_count)) {
    level.so_trainer_breach_count = 0;
  }
  level.so_trainer_breach_count++;

  if(level.so_trainer_breach_count == 1) {
    common_scripts\utility::flag_set(level.challenge_flag_start);
  } else if(level.so_trainer_breach_count == 2) {
    common_scripts\utility::flag_set("breach_second_room_started");
  }
}

breach_think() {
  var_0 = common_scripts\utility::getStruct("breach_hint_01", "targetname");
  level.breach_charge01_highlight = spawn("script_model", var_0.origin);
  level.breach_charge01_highlight setModel("mil_frame_charge_obj");
  level.breach_charge01_highlight.angles = var_0.angles;
  level.breach_charge01 = spawn("script_model", var_0.origin);
  level.breach_charge01 setModel("mil_frame_charge");
  level.breach_charge01.angles = var_0.angles;
  var_1 = getEntArray("trigger_use_breach", "classname");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_slowmo_breach) && var_4.script_slowmo_breach == 2) {
      var_2 = var_4;
    }
  }

  var_2 common_scripts\utility::trigger_off();
  level waittill("breaching");
  level.breach_charge01_highlight delete();
  level.breach_charge01 delete();
  common_scripts\utility::flag_wait("target_group_root_v2_03_cleared");
  var_2 common_scripts\utility::trigger_on();
  var_0 = common_scripts\utility::getStruct("breach_hint_02", "targetname");
  level.breach_charge02_highlight = spawn("script_model", var_0.origin);
  level.breach_charge02_highlight setModel("mil_frame_charge_obj");
  level.breach_charge02_highlight.angles = var_0.angles;
  level.breach_charge02 = spawn("script_model", var_0.origin);
  level.breach_charge02 setModel("mil_frame_charge");
  level.breach_charge02.angles = var_0.angles;
  level waittill("breaching");
  level.breach_charge02_highlight delete();
  level.breach_charge02 delete();
}

setup_fail_triggers() {
  level endon("special_op_terminated");
  level endon("missionfailed");
  var_0 = getEntArray("trig_player_left_bridge", "targetname");

  foreach(var_2 in var_0) {}
  var_2 childthread on_trigger_player_left_bridge();
}

on_trigger_player_left_bridge() {
  self waittill("trigger");
  level.challenge_end_time = gettime();
  maps\_specialops::so_force_deadquote("@SO_DELTACAMP_DEAD_QUOTE_PLAYER_LEFT_BRIDGE");
  thread maps\_utility::missionfailedwrapper();
}

objective_think() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  if(level.trainer_version == 1) {
    var_0 = maps\_utility::obj("stay_sharp");
    var_1 = &"SO_DELTACAMP_OBJ_V1";
    var_2 = common_scripts\utility::getStruct("obj_start_pos_v1", "targetname").origin;
  } else if(level.trainer_version == 2) {
    var_0 = maps\_utility::obj("breach_and_clear");
    var_1 = &"SO_DELTACAMP_OBJ_V2";
    var_2 = common_scripts\utility::getStruct("obj_start_pos_v2", "targetname").origin;
  }

  objective_add(var_0, "active", var_1);
  objective_current(var_0);
  objective_position(var_0, var_2);
  common_scripts\utility::flag_wait(level.challenge_flag_start);
  objective_position(var_0, (0, 0, 0));
  common_scripts\utility::flag_wait(level.challenge_flag_complete);
  maps\_utility::objective_complete(var_0);
}

setup_dialog() {
  thread dialog_intro();
  thread dialog_weapons_hidden();
  thread dialog_civilians();
  thread dialog_course();
}

dialog_intro() {
  level endon(level.challenge_flag_start);

  while(!isDefined(level.truck)) {
    wait 0.05;
  }
  level.truck endon("death");
  wait 0.5;
  var_0 = common_scripts\utility::getStruct("truck_speaker", "script_noteworthy");

  if(level.trainer_version == 1) {
    if(!maps\_utility::is_coop()) {
      level.truck maps\_utility::dialogue_queue("so_deltacamp_trk_youreup");
    } else {
      level.truck maps\_utility::dialogue_queue("so_deltacamp_trk_startingarea");
    }
  } else if(level.trainer_version == 2) {
    _id_0084("so_trainer2_trk_breach", var_0);
  }
  wait(randomfloatrange(8.0, 11.0));

  if(!maps\_utility::is_coop()) {
    _id_0084("so_deltacamp_trk_yourgo", var_0);
  } else {
    _id_0084("so_deltacamp_trk_whenever", var_0);
  }
}

_id_0084(var_0, var_1) {
  _id_0048();

  if(!isDefined(var_1)) {
    var_1 = maps\_utility::getclosest(level.player.origin, level.speakers);
  }
  level._id_0047 = var_1;
  var_1 playSound(var_0, "speaker_sound_interrupt", 1);
}

_id_0048() {
  if(isDefined(level._id_0047)) {
    level._id_0047 notify("speaker_sound_interrupt");
  }
}

dialog_weapons_hidden() {
  level endon(level.challenge_flag_start);
  common_scripts\utility::array_thread(level.players, ::on_player_weapon_change);
  level waittill("weapon_hidden_collected");
  var_0 = common_scripts\utility::getStruct("speaker_truck", "script_noteworthy");
  _id_0048();
  _id_0084("so_deltacamp_trk_owntoys", var_0);
}

dialog_civilians() {
  level endon(level.challenge_flag_complete);
  level endon("missionfailed");
  level endon("special_op_terminated");
  var_0 = 0;

  for(;;) {
    level waittill("civilian_killed");

    if(common_scripts\utility::flag_exist("breaching_on") && common_scripts\utility::flag("breaching_on")) {
      continue;
    }
    var_0++;

    if(var_0 == 1) {
      _id_0084("so_deltacamp_trk_civilians");
      continue;
    }

    if(var_0 == 2) {
      _id_0084("so_deltacamp_trk_dontshoot");
      return;
    }
  }
}

on_player_weapon_change() {
  level endon(level.challenge_flag_start);
  level endon("weapon_hidden_collected");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(isDefined(var_0) && (var_0 == "ak74u" || var_0 == "usp_no_knife")) {
      level notify("weapon_hidden_collected");
      return;
    }
  }
}

dialog_course() {
  level endon("missionfailed");

  if(level.trainer_version == 1) {
    common_scripts\utility::flag_wait("target_group_root_v1_02_popped");
    _id_0084("so_deltacamp_trk_tangos");
    common_scripts\utility::flag_wait("target_group_root_v1_03_popped");
    _id_0084("so_deltacamp_trk_vehicles");
    common_scripts\utility::flag_wait("target_group_root_v1_03_cleared");
    _id_0084("so_deltacamp_trk_moveup");
    common_scripts\utility::flag_wait("target_group_root_v1_04_popped");
    _id_0084("so_deltacamp_trk_targets");
    common_scripts\utility::flag_wait("target_group_root_v1_04_cleared");
    _id_0084("so_deltacamp_trk_clear");
    common_scripts\utility::flag_wait("target_group_root_v1_05_popped");
    _id_0084("so_deltacamp_trk_knife");
    common_scripts\utility::flag_wait("target_group_root_v1_05_cleared");
    _id_0084("so_deltacamp_trk_upthestairs");
    common_scripts\utility::flag_wait("target_group_root_v1_06_cleared");
    _id_0084("so_deltacamp_trk_allclear");
    common_scripts\utility::flag_wait("target_group_root_v1_07_popped");
    _id_0084("so_deltacamp_trk_dogs");
    common_scripts\utility::flag_wait("target_group_root_v1_08_cleared");
    _id_0084("so_deltacamp_trk_bridgeclear");
    common_scripts\utility::flag_wait("target_group_root_v1_09_cleared");
    wait 0.5;

    if(!isDefined(level.sandman)) {
      return;
    }
    level.sandman endon("death");
    _id_0048();
    level.sandman maps\_utility::dialogue_queue("so_deltacamp_snd_thanks");
    common_scripts\utility::flag_wait(level.challenge_flag_complete);
    var_0 = level.player.so_hud_star_count;
    wait 1.0;
    _id_0048();

    if(var_0 > 1) {
      level.sandman maps\_utility::dialogue_queue("so_deltacamp_snd_nicelydone");
      return;
    }

    level.sandman maps\_utility::dialogue_queue("so_deltacamp_snd_nogood");
    return;
  } else if(level.trainer_version == 2) {
    common_scripts\utility::flag_wait("target_group_root_v2_01_cleared");
    wait 0.5;
    thread _id_0084("so_trainer2_trk_roomclear");
    common_scripts\utility::flag_wait("target_group_root_v2_02_popped");
    thread _id_0084("so_deltacamp_trk_dogs");
    common_scripts\utility::flag_wait("target_group_root_v2_02_cleared");
    thread _id_0084("so_deltacamp_trk_allclear");
    common_scripts\utility::flag_wait("target_group_root_v2_03_popped");
    thread _id_0084("so_trainer2_trk_sniper");
    common_scripts\utility::flag_wait("target_group_root_v2_03_cleared");
    thread _id_0084("so_deltacamp_trk_bridgeclear");
    maps\_utility::trigger_wait_targetname("trig_v2_breach_dialog_02");
    thread _id_0084("so_trainer2_trk_anothercharge");
    common_scripts\utility::flag_wait("target_group_root_v2_04_cleared");
    wait 0.5;
    thread _id_0084("so_trainer2_trk_downstairs");
    common_scripts\utility::flag_wait("target_group_root_v2_05_popped");
    thread _id_0084("so_deltacamp_trk_knife");
    common_scripts\utility::flag_wait("target_group_root_v2_06_popped");
    thread _id_0084("so_deltacamp_trk_tangos");
    common_scripts\utility::flag_wait("target_group_root_v2_06_cleared");
    thread _id_0084("so_deltacamp_trk_moveup");
    common_scripts\utility::flag_wait("target_group_root_v2_07_popped");
    thread _id_0084("so_trainer2_trk_uponbridge");
    common_scripts\utility::flag_wait("target_group_root_v2_08_popped");
    thread _id_0084("so_trainer2_trk_lastgroup");
    common_scripts\utility::flag_wait("target_group_root_v2_08_cleared");
    thread _id_0084("so_deltacamp_trk_sprinttofinish");
    common_scripts\utility::flag_wait(level.challenge_flag_complete);
    var_0 = level.player.so_hud_star_count;
    wait 1.0;

    if(var_0 > 1) {
      thread _id_0084("so_deltacamp_trk_runthecourse");
    } else if(common_scripts\utility::cointoss()) {
      thread _id_0084("so_deltacamp_trk_notgood");
    } else {
      thread _id_0084("so_deltacamp_trk_betterthan");
    }
  }
}

setup_allies() {
  maps\_utility::battlechatter_off("allies");

  if(level.trainer_version == 1) {
    var_0 = getEnt("sandman", "targetname");
    level.sandman = var_0 maps\_utility::spawn_ai(1);
    level.sandman thread on_damage_ally_fail();
    level.sandman thread look_at_players();
    level.sandman.so_no_mission_over_delete = 1;
    level.sandman.allowdeath = 1;
    level.sandman.drawoncompass = 0;
    level.sandman.health = 1;
    level.sandman maps\_utility::gun_remove();
    level.sandman.animname = "generic";
    var_1 = getEnt("ent_sandman_scene", "targetname");
    var_1 thread maps\_anim::anim_loop_solo(level.sandman, "sandman_idle", "end_idle");
  }

  var_0 = getEnt("truck", "targetname");
  level.truck = var_0 maps\_utility::spawn_ai(1);
  level.truck thread on_damage_ally_fail();
  level.truck thread look_at_players();
  level.truck.allowdeath = 1;
  level.truck.drawoncompass = 0;
  level.truck.health = 1;
  level.truck maps\_utility::gun_remove();
  level.truck.animname = "generic";

  if(level.trainer_version == 1) {
    var_2 = common_scripts\utility::getStruct("loc_truck_look_at_v1_start", "targetname");
    var_2 thread maps\_anim::anim_loop_solo(level.truck, "truck_idle", "end_idle");
    level.truck thread update_truck_loc(var_2);
  } else if(level.trainer_version == 2) {
    var_3 = common_scripts\utility::getStruct("loc_truck_look_at_bridge", "targetname");
    var_3 thread maps\_anim::anim_loop_solo(level.truck, "truck_idle", "end_idle");
  }

  var_0 = getEnt("grinch", "targetname");
  level.grinch = var_0 maps\_utility::spawn_ai(1);
  level.grinch thread on_damage_ally_fail();
  level.grinch thread look_at_players();
  level.grinch.allowdeath = 1;
  level.grinch.drawoncompass = 0;
  level.grinch.health = 1;
  level.grinch maps\_utility::gun_remove();
  level.grinch.animname = "generic";
  var_1 = getEnt("ent_grinch_scene", "targetname");
  var_1 thread maps\_anim::anim_loop_solo(level.grinch, "grinch_idle", "end_idle");
  var_4 = spawn("script_model", level.grinch.origin);
  var_4 setModel("com_folding_chair");
  var_4.angles = level.grinch.angles + (0, 0, 0);
  level.grinch thread common_scripts\utility::delete_on_death(var_4);
}

update_truck_loc(var_0) {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("duck_shoot_targets_pop");

  for(;;) {
    var_1 = 1;

    foreach(var_3 in level.players) {
      if(self cansee(var_3)) {
        var_1 = 0;
        break;
      }
    }

    if(var_1 == 1) {
      break;
    }

    wait 0.2;
  }

  var_0 notify("end_idle");
  var_5 = common_scripts\utility::getStruct("loc_truck_look_at_bridge", "targetname");
  var_5 thread maps\_anim::anim_loop_solo(self, "truck_idle", "end_idle");
}

look_at_players() {
  level endon("special_op_terminated");
  var_0 = undefined;

  for(;;) {
    var_1 = maps\_utility::get_closest_player(self.origin);

    if(!isDefined(var_0) || var_0 != var_1) {
      var_0 = var_1;
      self setlookatentity(var_0);
    }

    wait 0.5;
  }
}

on_damage_ally_fail() {
  level endon("special_op_terminated");

  for(;;) {
    common_scripts\utility::waittill_any("damage", "death");
    level.challenge_end_time = gettime();
    maps\_specialops::so_force_deadquote("@SO_DELTACAMP_DEAD_QUOTE_ALLY_HURT");
    thread maps\_utility::missionfailedwrapper();
    break;
  }
}

setup_players() {
  foreach(var_3, var_1 in level.players) {
    var_1 give_max_ammo();

    if(level.trainer_version == 2) {
      var_2 = common_scripts\utility::getStruct("struct_start_pos_player" + (var_3 + 1) + "_v2", "targetname");
      var_1 coop_teleport_player(var_2);
    }
  }
}

setup_player_hud() {
  if(level.trainer_version == 1) {
    maps\_specialops::so_hud_stars_init(level.challenge_flag_start, "course_targets_finished", -1, 40, 28);
  } else if(level.trainer_version == 2) {
    maps\_specialops::so_hud_stars_init(level.challenge_flag_start, "all_players_reached_end", -1, 45, 33);
  }
  thread maps\_specialops::enable_challenge_counter(3, &"SO_DELTACAMP_CIV_COUNT", "ui_civ_count");
}

catch_civilian_hits() {
  level endon("special_op_terminated");

  for(;;) {
    level waittill("civilian_killed", var_0);
    var_0 notify("ui_civ_count", var_0.civs_hit);

    if(level.civs_hit == 1) {
      maps\_specialops::so_hud_stars_remove("veteran");
      continue;
    }

    if(level.civs_hit == 2) {
      maps\_specialops::so_hud_stars_remove("hardened");
    }
  }
}

coop_teleport_player(var_0) {
  self setOrigin(var_0.origin);

  if(isDefined(var_0.angles)) {
    self setplayerangles(var_0.angles);
  }
}

give_max_ammo() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {}
  self givemaxammo(var_2);
}

init_stat_vars() {
  level.civs_hit = 0;

  foreach(var_1 in level.players) {}
  var_1.civs_hit = 0;
}

setup_gates() {
  level.gate_enter_v1 = make_door_from_prefab("gate_enter_v1");
  level.gate_enter_v1.openangles = 80;

  if(level.trainer_version == 1) {
    level.gate_enter_v1 thread door_open("course_start_open_gate", 0);
  } else if(level.trainer_version == 2) {
    level.gate_enter_v1 thread door_open(undefined, 1, 1);
  }
  level.gate_enter_v2 = make_door_from_prefab("gate_enter_v2");
  level.gate_enter_v2.openangles = 80;

  if(level.trainer_version == 1) {
    level.gate_enter_v2 thread door_open("course_targets_finished", 1);
  }
}

start_mission() {
  if(level.trainer_version == 1) {
    maps\_utility::flag_set_delayed("course_start_open_gate", 1.0);
  } else {
    common_scripts\utility::flag_set("course_start_open_gate");
  }
}

course_think(var_0, var_1) {
  if(isDefined(level.challenge_trig_complete_noteworthy)) {
    common_scripts\utility::trigger_off(level.challenge_trig_complete_noteworthy, "script_noteworthy");
  }
  course_delete(var_1);
  course_target_setup(var_0);
  wait 1.0;
  common_scripts\utility::flag_wait(level.challenge_flag_start);

  foreach(var_4, var_3 in level.group_structs) {
    if(isDefined(var_3.trig_required)) {
      var_3.trig_required common_scripts\utility::trigger_on();
      var_3.trig_required waittill("trigger");
    }

    if(isDefined(var_3.script_flag)) {
      common_scripts\utility::flag_wait(var_3.script_flag);
    }
    if(isDefined(var_3.script_delay)) {
      wait(var_3.script_delay);
    }
    common_scripts\utility::flag_set(var_3.targetname + "_popped");
    maps\_utility::array_notify(var_3.doors_before, "open");
    maps\_utility::array_notify(var_3.targets, "pop_up");
    var_3 waittill("all_targets_down");
    common_scripts\utility::flag_set(var_3.targetname + "_cleared");
    maps\_utility::array_notify(var_3.doors_after, "open");
    thread hud_area_cleared();
  }

  common_scripts\utility::flag_set("course_targets_finished");

  if(isDefined(level.challenge_trig_complete_noteworthy)) {
    common_scripts\utility::trigger_on(level.challenge_trig_complete_noteworthy, "script_noteworthy");
  }
}

course_target_setup(var_0) {
  level.target_rail_start_points = getEntArray("target_rail_start_point", "targetname");
  level.target_rail_path_start_points = getEntArray("target_rail_path_start_point", "targetname");
  level.speakers = getEntArray("speakers", "targetname");
  level.group_structs = [];
  level.melee_clips = getEntArray("melee_clip", "targetname");
  common_scripts\utility::array_thread(level.melee_clips, maps\_utility::hide_entity);

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::get_target_ent(var_2);
    level.group_structs[level.group_structs.size] = var_3;
  }

  foreach(var_3 in level.group_structs) {
    var_3.doors_before = [];
    var_3.doors_after = [];
    var_3.targets = [];
    var_3.targets_friendly = [];
    var_3.targets_enemy = [];
    var_3.targets_enemy_killed = 0;
    var_6 = var_3 common_scripts\utility::get_linked_ents();

    foreach(var_8 in var_6) {
      if(!isDefined(var_8.code_classname)) {
        continue;
      }
      if(var_8.code_classname == "script_brushmodel") {
        if(!maps\_utility::is_coop() && var_8 has_script_parameter("coop_only", ";")) {
          var_8 target_delete();
          continue;
        }

        if(isDefined(var_8.script_noteworthy) && issubstr(var_8.script_noteworthy, "target_")) {
          if(var_8.script_noteworthy == "target_enemy") {
            var_3.targets_enemy[var_3.targets_enemy.size] = var_8;
          } else if(var_8.script_noteworthy == "target_friendly") {
            var_3.targets_friendly[var_3.targets_friendly.size] = var_8;
          } else {
            continue;
          }
          var_8 thread target_think(var_3, strtok(var_8.script_noteworthy, "_")[1]);
          var_3.targets[var_3.targets.size] = var_8;

          if(var_8 has_script_parameter("invisible", ";")) {
            _id_0049(var_8);
          }
          continue;
        }

        if(var_8 has_script_parameter("door", ";")) {
          if(var_8 has_script_parameter("door_before", ";")) {
            var_3.doors_before[var_3.doors_before.size] = var_8;
          } else if(var_8 has_script_parameter("door_after", ";")) {
            var_3.doors_after[var_3.doors_after.size] = var_8;
          } else {
            continue;
          }
          var_8 thread door_think();
        }
      }

      if(var_8.code_classname == "script_model") {
        if(var_8 has_script_parameter("door", ";")) {
          if(var_8 has_script_parameter("door_before", ";")) {
            var_3.doors_before[var_3.doors_before.size] = var_8;
          } else if(var_8 has_script_parameter("door_after", ";")) {
            var_3.doors_after[var_3.doors_after.size] = var_8;
          } else {
            continue;
          }
          var_8 thread door_think();
        }
      }

      if(var_8.code_classname == "trigger_multiple" && isDefined(var_8.classname)) {
        if(var_8.classname == "trigger_multiple_flag_set" && isDefined(var_8.script_flag) && common_scripts\utility::flag_exist(var_8.script_flag)) {
          var_3.script_flag = var_8.script_flag;
          continue;
        } else if(var_8.classname == "trigger_multiple") {
          var_3.trig_required = var_8;
          var_3.trig_required common_scripts\utility::trigger_off();
          continue;
        }
      }
    }
  }
}

course_delete(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = common_scripts\utility::get_target_ent(var_3);
    var_1[var_1.size] = var_4;
  }

  foreach(var_4 in var_1) {
    var_7 = var_4 common_scripts\utility::get_linked_ents();

    foreach(var_9 in var_7) {
      if(!isDefined(var_9.code_classname)) {
        continue;
      }
      if(var_9.code_classname == "script_brushmodel") {
        if(var_9 has_script_parameter("door", ";")) {
          continue;
        }
      }

      if(var_9.code_classname == "script_model") {
        if(var_9 has_script_parameter("door", ";")) {
          continue;
        }
      }

      var_9 delete();
    }
  }
}

_id_0049(var_0) {
  var_0 maps\_utility::hide_entity();
  var_0.target_model maps\_utility::hide_entity();
}

_id_004A(var_0) {
  var_0 maps\_utility::show_entity();
  var_0.target_model maps\_utility::show_entity();
}

target_delete() {
  var_0 = [];
  var_0[var_0.size] = self;
  var_1 = getEntArray(self.target, "targetname");

  foreach(var_3 in var_1) {
    if(var_3.classname == "script_origin") {
      var_0[var_0.size] = getEnt(var_3.target, "targetname");
    }
    var_0[var_0.size] = var_3;
  }

  common_scripts\utility::array_call(var_0, ::delete);
}

target_think(var_0, var_1) {
  self.meleeonly = undefined;
  var_2 = getEntArray(self.target, "targetname");

  foreach(var_4 in var_2) {
    if(var_4.classname == "script_origin") {
      self.orgent = var_4;
      continue;
    } else if(var_4.classname == "script_model") {
      self.target_model = var_4;
      continue;
    }
  }

  self linkTo(self.orgent);
  var_6 = getEnt(self.orgent.target, "targetname");
  var_6 hide();
  var_6 notsolid();
  var_6 linkTo(self);
  self.target_model linkTo(self.orgent);

  if(has_script_parameter("reverse", ";")) {
    self.orgent rotatepitch(90, 0.25);
  } else if(has_script_parameter("sideways_right", ";")) {
    self.orgent rotateYaw(-180, 0.35);
  } else if(has_script_parameter("sideways_left", ";")) {
    self.orgent rotateYaw(180, 0.35);
  } else if(has_script_parameter("vertical", ";")) {
    self.orgent moveTo(self.orgent.origin - (0, 0, 36), 0.25);
  } else {
    self.orgent rotatepitch(-90, 0.25);
  }
  if(has_script_parameter("use_rail", ";")) {
    self.lateralmovementorgs = undefined;
    self.lateralstartposition = undefined;
    self.lateralendposition = undefined;
    self.lateralstartposition = maps\_utility::getclosest(self.orgent.origin, level.target_rail_start_points, 10);
    self.lateralendposition = getEnt(self.lateralstartposition.target, "targetname");
    self.lateralmovementorgs = [];
    self.lateralmovementorgs[0] = self.lateralstartposition;
    self.lateralmovementorgs[1] = self.lateralendposition;

    foreach(var_8 in self.lateralmovementorgs) {}

    target_lateral_reset_start_pos();
  }

  if(has_script_parameter("use_rail_path", ";")) {
    self.move_orgs = [];
    var_10 = maps\_utility::getclosest(self.orgent.origin, level.target_rail_path_start_points, 10);

    while(isDefined(var_10)) {
      self.move_orgs[self.move_orgs.size] = var_10;

      if(isDefined(var_10.target)) {
        var_10 = var_10 common_scripts\utility::get_target_ent();
        continue;
      }

      var_10 = undefined;
    }
  }

  for(;;) {
    self waittill("pop_up");

    if(has_script_parameter("breach", ";")) {
      level.breachenemies_active++;
    }
    if(isDefined(self.script_delay)) {
      wait(self.script_delay);
    }
    so_player_tooclose_wait();

    if(has_script_parameter("invisible", ";")) {
      _id_004A(self);
    }
    if(has_script_parameter("melee", ";")) {
      var_11 = maps\_utility::getclosest(self.origin, level.melee_clips, 120);
      self.meleeonly = 1;
      self.melee_clip = var_11;
      self.melee_clip maps\_utility::show_entity();
    }

    var_12 = 0.25;

    if(!has_script_parameter("breach", ";")) {
      wait(randomfloatrange(0, 0.2));
    } else {
      var_12 = 0.05;
    }
    self solid();
    self playSound("target_up_metal");
    self.target_model setCanDamage(1);

    if(has_script_parameter("dog_bark", ";")) {
      thread target_play_dog_bark();
    }
    if(var_1 != "friendly") {
      var_6 enableaimassist();
    }
    if(has_script_parameter("reverse", ";")) {
      self.orgent rotatepitch(-90, var_12);
    } else if(has_script_parameter("sideways_right", ";")) {
      self.orgent rotateYaw(180, var_12);
    } else if(has_script_parameter("sideways_left", ";")) {
      self.orgent rotateYaw(-180, var_12);
    } else if(has_script_parameter("vertical", ";")) {
      self.orgent moveTo(self.orgent.origin + (0, 0, 36), var_12);
    } else {
      self.orgent rotatepitch(90, var_12);
    }
    wait(var_12);

    if(isDefined(self.lateralstartposition)) {
      thread target_lateral_movement();
    } else if(isDefined(self.move_orgs) && self.move_orgs.size) {
      thread target_path_movement();
    }
    for(;;) {
      self.target_model waittill("damage", var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22);

      if(!isDefined(var_14)) {
        continue;
      }
      if(!isDefined(var_17)) {
        continue;
      }
      if(var_17 == "MOD_IMPACT") {
        continue;
      }
      if(isPlayer(var_14)) {
        if(isDefined(self.meleeonly)) {
          if(var_17 != "MOD_MELEE") {
            continue;
          }
        }

        self playSound("target_metal_hit");

        if(var_1 == "friendly") {
          thread hud_civilian_hit();
          var_23 = maps\_utility::getclosest(var_14.origin, level.speakers);
          var_23 playSound("target_mistake_buzzer");
          var_14.civs_hit++;
          level.civs_hit++;
          level notify("civilian_killed", var_14);
        } else {
          var_14 maps\_player_stats::register_kill(self, var_17, var_22);
          var_14 notify("ui_kill_count", var_14.stats["kills"]);
          level notify("target_killed");

          if(has_script_parameter("breach", ";")) {
            level.breachenemies_active--;
          }
          var_0.targets_enemy_killed++;

          if(var_0.targets_enemy_killed >= var_0.targets_enemy.size) {
            var_0 notify("all_targets_down");
          }
        }

        if(var_17 == "MOD_GRENADE_SPLASH") {
          self notify("hit_with_grenade");
        }
        break;
      }
    }

    if(isDefined(self.meleeonly)) {
      self.melee_clip maps\_utility::hide_entity();
    }
    self notify("hit");
    self notify("target_going_back_down");
    self.health = 1000;
    var_6 disableaimassist();
    self notsolid();

    if(isDefined(self.orgent.drop_origin)) {
      self.orgent.origin = self.orgent.drop_origin;
    }
    if(has_script_parameter("reverse", ";")) {
      self.orgent rotatepitch(90, 0.25);
    } else if(has_script_parameter("sideways_right", ";")) {
      self.orgent rotateYaw(-180, 0.35);
    } else if(has_script_parameter("sideways_left", ";")) {
      self.orgent rotateYaw(180, 0.35);
    } else if(has_script_parameter("vertical", ";")) {
      self.orgent moveTo(self.orgent.origin - (0, 0, 36), 0.25);
    } else {
      self.orgent rotatepitch(-90, 0.25);
    }
    self.target_model setCanDamage(0);
    wait 0.25;
  }
}

so_player_tooclose_wait() {
  var_0 = self.origin;
  var_1 = undefined;

  if(has_script_parameter("melee", ";")) {
    var_0 = (-5723, 2547, -49);
    var_1 = 2520;
  }

  for(;;) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      var_5 = 3136;

      if(length(var_4 getvelocity()) > 200) {
        var_5 = 16384;
      }
      if(distancesquared(var_4.origin, var_0) < var_5) {
        var_2 = 1;

        if(isDefined(var_1) && var_4.origin[1] < var_1) {
          var_2 = 0;
        }
      }
    }

    if(!var_2) {
      return;
    }
    wait 0.05;
  }
}

target_lateral_movement() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0.angles = self.orgent.angles;
  var_0.origin = self.orgent.origin;
  self.orgent thread target_move_with_dummy(var_0);
  var_0 endon("deleted_because_player_was_too_close");
  var_0 endon("death");

  foreach(var_2 in level.players) {}
  var_0 thread delete_when_player_too_close(var_2);

  thread dummy_delete_when_target_goes_back_down(var_0);
  var_4 = common_scripts\utility::ter_op(isDefined(self.script_speed), self.script_speed, 1);
  var_5 = distance(self.lateralmovementorgs[0].origin, self.lateralmovementorgs[1].origin);
  var_6 = var_5 / (12.0 * var_4);

  for(;;) {
    var_0 moveTo(self.lateralendposition.origin, var_6);
    wait(var_6);
    var_0 moveTo(self.lateralstartposition.origin, var_6);
    wait(var_6);
  }
}

target_play_dog_bark() {
  level endon("special_op_terminated");
  self endon("target_going_back_down");

  for(;;) {
    self playSound("anml_dog_bark", "bark_done");
    self waittill("bark_done");
    wait(randomfloatrange(0.1, 0.5));
  }
}

target_path_movement() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0.angles = self.orgent.angles;
  var_0.origin = self.orgent.origin;

  if(has_script_parameter("bounce", ";")) {
    self.orgent thread target_move_with_dummy(var_0, 8, 2.0);
  } else {
    self.orgent thread target_move_with_dummy(var_0, 0, 0.0);
  }
  var_0 endon("deleted_because_player_was_too_close");
  var_0 endon("death");

  foreach(var_2 in level.players) {}
  var_0 thread delete_when_player_too_close(var_2);

  thread dummy_delete_when_target_goes_back_down(var_0);

  for(var_4 = 0; var_4 < self.move_orgs.size - 1; var_4++) {
    var_5 = common_scripts\utility::ter_op(isDefined(self.script_speed), self.script_speed, 1);
    var_6 = distance(self.move_orgs[var_4].origin, self.move_orgs[var_4 + 1].origin);
    var_7 = var_6 / (12.0 * var_5);
    var_0 moveTo(self.move_orgs[var_4 + 1].origin, var_7);
    wait(var_7);
  }

  var_0 delete();
}

dummy_delete_when_target_goes_back_down(var_0) {
  var_0 endon("death");
  self waittill("target_going_back_down");
  var_0 delete();
}

delete_when_player_too_close(var_0) {
  self endon("death");
  var_1 = 128;
  var_2 = var_1 * var_1;

  for(;;) {
    wait 0.05;

    if(distancesquared(var_0.origin, self.origin) < var_2) {
      break;
    }
  }

  self notify("deleted_because_player_was_too_close");
  self delete();
}

target_move_with_dummy(var_0, var_1, var_2) {
  var_0 endon("death");
  var_3 = 1;
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_1) && isDefined(var_2)) {
    var_6 = 12.0 * var_2;
    var_4 = var_6 / 20.0;
  } else {
    var_1 = 0.0;
  }
  for(;;) {
    wait 0.05;

    if(var_3) {
      var_5 = var_5 + var_4;

      if(var_5 > var_1) {
        var_5 = var_1;
        var_3 = 0;
      }
    } else {
      var_5 = var_5 - var_4;

      if(var_5 < 0.0) {
        var_5 = 0.0;
        var_3 = 1;
      }
    }

    self.drop_origin = var_0.origin;
    self.origin = var_0.origin + (0, 0, var_5);
  }
}

target_lateral_reset_start_pos() {
  if(self.lateralmovementorgs[0] has_script_parameter("force_start_here", ";")) {
    self.lateralstartposition = self.lateralmovementorgs[0];
    self.lateralendposition = self.lateralmovementorgs[1];
  } else if(self.lateralmovementorgs[1] has_script_parameter("force_start_here", ";")) {
    self.lateralstartposition = self.lateralmovementorgs[1];
    self.lateralendposition = self.lateralmovementorgs[0];
  } else if(common_scripts\utility::cointoss()) {
    self.lateralstartposition = self.lateralmovementorgs[0];
    self.lateralendposition = self.lateralmovementorgs[1];
  } else {
    self.lateralstartposition = self.lateralmovementorgs[1];
    self.lateralendposition = self.lateralmovementorgs[0];
  }

  self.orgent moveTo(self.lateralstartposition.origin, 0.1);
}

door_think() {
  var_0 = -90;

  if(isDefined(self.script_goalyaw)) {
    var_0 = self.script_goalyaw;
  }
  self waittill("open");
  self rotateYaw(var_0, 0.5, 0.2, 0.1);
}

setup_all_player_hud() {
  foreach(var_1 in level.players) {}
  var_1 setup_player_hud();

  thread catch_civilian_hits();
}

setup_level_hud() {
  level.splash_count = 0;
  level.splash_counted = 1;
}

msg_splash(var_0) {
  level.splash_count++;
  var_1 = level.splash_count;

  if(level.splash_count - level.splash_counted > 0) {
    level waittill("pre_display_splash" + var_1);
  }
  if(common_scripts\utility::flag("special_op_terminated")) {
    return;
  }
  if(var_0 == "civilian_hit") {
    var_2 = &"SO_DELTACAMP_CIVILIAN_HIT";
  } else {
    level thread common_scripts\utility::play_sound_in_space("emt_airhorn_area_clear", level.player.origin + (0, 0, 40));
    var_2 = &"SO_DELTACAMP_AREA_CLEARED";
  }

  var_3 = maps\_specialops::so_create_hud_item(2, 0, var_2);
  var_3.alignx = "center";
  var_3.horzalign = "center";
  var_3.fontscale = 2;

  if(var_0 == "civilian_hit") {
    var_3 maps\_specialops::set_hud_red();
  } else {
    var_3 maps\_specialops::set_hud_yellow();
  }
  wait 0.2;
  var_4 = 1;
  var_3 fadeovertime(var_4);
  var_3.alpha = 0;
  var_3 changefontscaleovertime(var_4);
  var_3.fontscale = 0.5;
  wait(var_4 * 0.75);
  level notify("pre_display_splash" + (var_1 + 1));
  level.splash_counted++;
  wait(var_4 * 0.25);
  var_3 destroy();
}

hud_area_cleared() {
  wait 0.05;
  msg_splash("area_cleared");
}

hud_civilian_hit() {
  msg_splash("civilian_hit");
}

custom_eog_summary() {
  var_0 = level.challenge_end_time - level.challenge_start_time;
  var_1 = maps\_utility::convert_to_time_string(var_0 / 1000, 1);
  var_2 = 50000;
  var_3 = int(max(var_2 - var_0, 0));
  var_4 = int(var_3 / var_2 * 8000);
  var_5 = 0;

  foreach(var_7 in level.players) {}
  var_5 = var_5 + 100 * var_7.stats["kills"];

  var_9 = level.civs_hit * -500;
  var_10 = int(max(var_4 + var_5 + var_9, 0));

  foreach(var_7 in level.players) {
    var_7.forcedgameskill = var_7.so_hud_star_count;

    if(level.trainer_version == 2) {
      if(var_1 == "0:33.0" && var_7.forcedgameskill < 3) {
        var_1 = "0:33.1";
      }
    }

    var_12 = var_7.stats["kills"];
    var_13 = var_7.civs_hit;

    if(maps\_utility::is_coop()) {
      var_14 = maps\_utility::get_other_player(var_7).stats["kills"];
      var_15 = maps\_utility::get_other_player(var_7).civs_hit;

      if(isDefined(level.missionfailed) && level.missionfailed == 1) {
        setDvar("ui_hide_hint", 0);
        var_7 maps\_utility::add_custom_eog_summary_line("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_PERFORMANCE_PARTNER");
        var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_FINISH_TIME", var_1, var_1);
        var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_ENEMIES_HIT", var_12, var_14);
        var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_CIVS_HIT", var_13, var_15);
      } else {
        setDvar("ui_hide_hint", 1);
        var_7 maps\_utility::add_custom_eog_summary_line("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_PERFORMANCE_PARTNER", "@SPECIAL_OPS_UI_SCORE");
        var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_FINISH_TIME", var_1, var_1, var_4);
        var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_ENEMIES_HIT", var_12, var_14, var_5);
        var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_CIVS_HIT", var_13, var_15, var_9);
        var_7 maps\_utility::add_custom_eog_summary_line_blank();

        if(!var_7 completed_all_difficulties()) {
          var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_MEDAL_NEXT_TIME", var_7 get_next_medal_time_string());

          if(!issplitscreen()) {
            var_7 maps\_utility::add_custom_eog_summary_line_blank();
          }
        }

        var_7 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_TEAM_SCORE", var_10);
      }
    } else if(isDefined(level.missionfailed) && level.missionfailed == 1) {
      setDvar("ui_hide_hint", 0);
      var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_FINISH_TIME", var_1);
      var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_ENEMIES_HIT", var_12);
      var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_CIVS_HIT", var_13);
    } else {
      setDvar("ui_hide_hint", 1);
      var_7 maps\_utility::add_custom_eog_summary_line("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_UI_SCORE");
      var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_FINISH_TIME", var_1, var_4);
      var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_ENEMIES_HIT", var_12, var_5);
      var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_CIVS_HIT", var_13, var_9);
      var_7 maps\_utility::add_custom_eog_summary_line_blank();

      if(!var_7 completed_all_difficulties()) {
        var_7 maps\_utility::add_custom_eog_summary_line("@SO_DELTACAMP_SCOREBOARD_MEDAL_NEXT_TIME", var_7 get_next_medal_time_string());

        if(!issplitscreen()) {
          var_7 maps\_utility::add_custom_eog_summary_line_blank();
        }
      }

      var_7 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_SCORE_FINAL", var_10);
    }

    if(!isDefined(level.missionfailed) || level.missionfailed == 0) {
      var_7 maps\_specialops::override_summary_time(var_0);
      var_7 maps\_specialops::override_summary_score(var_10);
    }
  }
}

completed_all_difficulties() {
  var_0 = maps\_specialops::get_previously_completed_difficulty();

  if(isDefined(self.forcedgameskill)) {
    var_0 = int(max(var_0, self.forcedgameskill + 1));
  }
  return var_0 == 4;
}

get_next_medal_time_string() {
  var_0 = get_next_medal();
  var_1 = 0;

  if(level.trainer_version == 1) {
    switch (var_0) {
      case 2:
        var_1 = 40;
        break;
      case 3:
        var_1 = 28;
        break;
      default:
        var_1 = 28;
        break;
    }
  } else if(level.trainer_version == 2) {
    switch (var_0) {
      case 2:
        var_1 = 45;
        break;
      case 3:
        var_1 = 33;
        break;
      default:
        var_1 = 33;
        break;
    }
  }

  return maps\_utility::convert_to_time_string(var_1, 1);
}

get_next_medal() {
  var_0 = maps\_specialops::get_previously_completed_difficulty();

  if(isDefined(self.forcedgameskill)) {
    var_0 = int(max(var_0, self.forcedgameskill + 1));
  }
  return var_0;
}

has_script_parameter(var_0, var_1) {
  if(!isDefined(self) || !isDefined(self.script_parameters)) {
    return 0;
  }
  var_2 = strtok(self.script_parameters, var_1);
  return maps\_utility::array_contains(var_2, var_0);
}

replace_script_parameter(var_0, var_1, var_2) {
  if(!isDefined(self) || !isDefined(self.script_parameters)) {
    return 0;
  }
  var_3 = strtok(self.script_parameters, var_2);
  var_4 = "";

  foreach(var_6 in var_3) {
    if(var_4 != "") {
      var_4 = var_4 + var_2;
    }
    if(var_6 == var_0) {
      var_4 = var_4 + var_1;
      continue;
    }

    var_4 = var_4 + var_6;
  }

  self.script_parameters = var_4;
}

make_door_from_prefab(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_2 = undefined;
  var_3 = [];
  var_4 = [];
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in var_1) {
    if(var_8.code_classname == "script_brushmodel") {
      var_4[var_4.size] = var_8;

      if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == "blocker") {
        var_6 = var_8;
      }
      continue;
    }

    if(var_8.code_classname == "script_origin") {
      var_2 = var_8;
      continue;
    }

    if(var_8.code_classname == "script_model") {
      var_3[var_3.size] = var_8;
      continue;
    }

    if(var_8.code_classname == "trigger_radius") {
      var_5 = var_8;
      continue;
    }
  }

  foreach(var_11 in var_3) {}
  var_11 linkTo(var_2);

  foreach(var_14 in var_4) {}
  var_14 linkTo(var_2);

  var_16 = var_2;
  var_16.brushes = var_4;

  if(isDefined(var_6)) {
    var_6 unlink();
    var_16.blocker = var_6;
  }

  if(isDefined(var_5)) {
    var_16.trigger = var_5;
  }
  return var_16;
}

door_open(var_0, var_1, var_2) {
  if(isDefined(self.moving)) {
    while(isDefined(self.moving)) {
      wait 0.05;
    }
  }

  self.moving = 1;
  var_3 = 90;

  if(isDefined(self.openangles)) {
    var_3 = self.openangles;
  }
  if(isDefined(var_0)) {
    common_scripts\utility::flag_wait(var_0);
  }
  var_4 = 4;

  if(isDefined(var_1)) {
    var_4 = 1.5;
    self rotateTo(self.angles + (0, var_3, 0), 1.5, 0.25, 0.25);
  } else {
    self rotateTo(self.angles + (0, var_3, 0), 4, 1.5, 1.5);
  }
  if(isDefined(self.blocker)) {
    self.blocker maps\_utility::hide_entity();
  }
  if(!isDefined(var_2) || var_2 == 0) {
    thread maps\_utility::play_sound_on_entity("scn_training_fence_open");
  }
  common_scripts\utility::array_call(self.brushes, ::notsolid);
  wait(var_4);
  self.moving = undefined;
}

door_close(var_0, var_1) {
  if(isDefined(self.moving)) {
    while(isDefined(self.moving)) {
      wait 0.05;
    }
  }

  self.moving = 1;
  var_2 = -90;

  if(isDefined(self.closeangles)) {
    var_2 = self.closeangles;
  }
  if(isDefined(var_0)) {
    common_scripts\utility::flag_wait(var_0);
  }
  var_3 = 2;

  if(isDefined(var_1)) {
    var_3 = 1;
    self rotateTo(self.angles + (0, var_2, 0), 1, 0.25, 0.25);
  } else {
    self rotateTo(self.angles + (0, var_2, 0), 2, 0.5, 0.5);
  }
  if(isDefined(self.blocker)) {
    self.blocker maps\_utility::show_entity();
  }
  thread maps\_utility::play_sound_on_entity("scn_training_fence_close");
  common_scripts\utility::array_call(self.brushes, ::solid);
  wait(var_3);
  self.moving = undefined;
}