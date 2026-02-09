/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_deltacamp.gsc
*****************************************/

main() {
  if(!isDefined(level._id_4D68)) {
    level._id_4D68 = 1;
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
  maps\_specialops::_id_188B();
  maps\_utility::_id_1F1B(::_id_4D94);
  maps\_utility::_id_1E74("start_assault", ::_id_4D94);
  _id_4D69::main();
  _id_0358::main();
  _id_0359::main();
  maps\so_deltacamp_anim::main();
  maps\_load::main();
  maps\_compass::setupminimap("compass_map_so_deltacamp");
  setsaveddvar("compassmaxrange", "1200");
  thread maps\so_deltacamp_amb::main();
  maps\_audio::_id_1719();
  _id_4D6D();
  maps\_utility::set_vision_set("so_deltacamp", 0);
  _id_4DB6();
  _id_4D6E();
  level._id_1865 = 1;
  thread maps\_specialops::_id_1802(level._id_4D6B, level._id_4D6A);
  thread maps\_specialops::_id_17F3(undefined, 0);
  thread maps\_specialops::_id_17F5("fade_challenge_out", 1);
  thread _id_4DB5();

  if(level._id_4D68 == 2) {
    thread maps\_specialops::_id_17EF(level._id_4D6C, "all_players_reached_end", "any");
  }
}

_id_4D6D() {
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

_id_4D6E() {
  _id_4D8F();
  var_0 = ["target_group_root_v1_02", "target_group_root_v1_03", "target_group_root_v1_04", "target_group_root_v1_05", "target_group_root_v1_06", "target_group_root_v1_07", "target_group_root_v1_08", "target_group_root_v1_09"];
  var_1 = ["target_group_root_v2_01", "target_group_root_v2_02", "target_group_root_v2_03", "target_group_root_v2_04", "target_group_root_v2_05", "target_group_root_v2_06", "target_group_root_v2_07", "target_group_root_v2_08"];

  if(level._id_4D68 == 1) {
    _id_4D6F("v2_only");
    _id_4D6F("v2_coop_only");

    if(!maps\_utility::_id_12C1()) {
      _id_4D6F("v1_coop_only");
    }
    level._id_4D6B = "so_training_deltacamp_start_v1";
    level._id_4D6A = "so_training_deltacamp_complete_v1";
    thread _id_4D95(var_0, var_1);
  } else if(level._id_4D68 == 2) {
    _id_4D6F("v1_only");
    _id_4D6F("v1_coop_only");

    if(!maps\_utility::_id_12C1()) {
      _id_4D6F("v2_coop_only");
    }
    _id_4D72();
    _id_4D73();
    level._id_4D6B = "so_training_deltacamp_start_v2";
    level._id_4D6A = "so_training_deltacamp_complete_v2";
    level._id_4D6C = "trig_level_end_v2";
    thread _id_4D95(var_1, var_0);
  }

  thread _id_4D71();
  thread _id_4D7C();
  thread _id_4D7E();
  thread _id_4D7F();
  thread _id_4D85();
  thread _id_3F71();
  thread _id_004B();
  level._id_16BC = 1;
  level._id_16BD = ::_id_16C2;
  common_scripts\utility::trigger_off("trig_mission_end_slide", "targetname");
}

_id_4D6F(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  common_scripts\utility::array_call(var_1, ::delete);
}

_id_4D70(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);
  common_scripts\utility::trigger_on(var_1, "targetname");
}

_id_4D71() {
  level endon("special_op_terminated");

  if(level._id_4D68 == 1) {
    common_scripts\utility::flag_wait("course_targets_finished");
  } else if(level._id_4D68 == 2) {
    common_scripts\utility::flag_wait("all_players_reached_end");
  }
  common_scripts\utility::flag_set(level._id_4D6A);
  wait 1.0;
  common_scripts\utility::flag_set("fade_challenge_out");
}

_id_4D72() {
  var_0 = getEntArray("door_ent", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_2961)) {
      var_2._id_2961 = var_2._id_2961 * -1;
    }
  }

  foreach(var_2 in var_0) {
    if(var_2 _id_4DBF("door_before", ";")) {
      var_2 _id_4DC0("door_before", "door_after", ";");
      continue;
    }

    if(var_2 _id_4DBF("door_after", ";")) {
      var_2 _id_4DC0("door_after", "door_before", ";");
    }
  }
}

_id_004B() {
  var_0 = getEntArray("destructible_vehicle", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_vehicle::_id_2A12);
}

_id_4D73() {
  if(!maps\_utility::_id_12C1()) {
    level.player thread animscripts\combat_utility::_id_20DE();
  }
  level._id_4D1A = 1;
  level._id_4D34 = "viewhands_player_delta";
  _id_4D78::_id_4CBC();
  level._id_4BC4 = 2.0;
  _id_4D78::_id_4D36(::_id_4D79);
  level._effect["breach_door"] = loadfx("explosions/breach_door_metal");
  level._effect["breach_room"] = loadfx("explosions/breach_room_cheap");
  thread _id_4010();
}

_id_4D79(var_0) {
  if(!isDefined(level._id_4D7A)) {
    level._id_4D7A = 0;
  }
  level._id_4D7A++;

  if(level._id_4D7A == 1) {
    common_scripts\utility::flag_set(level._id_4D6B);
  } else if(level._id_4D7A == 2) {
    common_scripts\utility::flag_set("breach_second_room_started");
  }
}

_id_4010() {
  var_0 = common_scripts\utility::getstruct("breach_hint_01", "targetname");
  level._id_4D74 = spawn("script_model", var_0.origin);
  level._id_4D74 setModel("mil_frame_charge_obj");
  level._id_4D74.angles = var_0.angles;
  level._id_4D75 = spawn("script_model", var_0.origin);
  level._id_4D75 setModel("mil_frame_charge");
  level._id_4D75.angles = var_0.angles;
  var_1 = getEntArray("trigger_use_breach", "classname");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_4CCE) && var_4._id_4CCE == 2) {
      var_2 = var_4;
    }
  }

  var_2 common_scripts\utility::trigger_off();
  level waittill("breaching");
  level._id_4D74 delete();
  level._id_4D75 delete();
  common_scripts\utility::flag_wait("target_group_root_v2_03_cleared");
  var_2 common_scripts\utility::trigger_on();
  var_0 = common_scripts\utility::getstruct("breach_hint_02", "targetname");
  level._id_4D76 = spawn("script_model", var_0.origin);
  level._id_4D76 setModel("mil_frame_charge_obj");
  level._id_4D76.angles = var_0.angles;
  level._id_4D77 = spawn("script_model", var_0.origin);
  level._id_4D77 setModel("mil_frame_charge");
  level._id_4D77.angles = var_0.angles;
  level waittill("breaching");
  level._id_4D76 delete();
  level._id_4D77 delete();
}

_id_4D7C() {
  level endon("special_op_terminated");
  level endon("missionfailed");
  var_0 = getEntArray("trig_player_left_bridge", "targetname");

  foreach(var_2 in var_0) {}
  var_2 childthread _id_4D7D();
}

_id_4D7D() {
  self waittill("trigger");
  level._id_16CE = gettime();
  maps\_specialops::_id_183F("@SO_DELTACAMP_DEAD_QUOTE_PLAYER_LEFT_BRIDGE");
  thread maps\_utility::_id_1826();
}

_id_4D7E() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  if(level._id_4D68 == 1) {
    var_0 = maps\_utility::_id_2816("stay_sharp");
    var_1 = &"SO_DELTACAMP_OBJ_V1";
    var_2 = common_scripts\utility::getstruct("obj_start_pos_v1", "targetname").origin;
  } else if(level._id_4D68 == 2) {
    var_0 = maps\_utility::_id_2816("breach_and_clear");
    var_1 = &"SO_DELTACAMP_OBJ_V2";
    var_2 = common_scripts\utility::getstruct("obj_start_pos_v2", "targetname").origin;
  }

  objective_add(var_0, "active", var_1);
  objective_current(var_0);
  objective_position(var_0, var_2);
  common_scripts\utility::flag_wait(level._id_4D6B);
  objective_position(var_0, (0, 0, 0));
  common_scripts\utility::flag_wait(level._id_4D6A);
  maps\_utility::_id_2727(var_0);
}

_id_4D7F() {
  thread _id_4D80();
  thread _id_4D81();
  thread _id_4D82();
  thread _id_4D84();
}

_id_4D80() {
  level endon(level._id_4D6B);

  while(!isDefined(level._id_45C4)) {
    wait 0.05;
  }
  level._id_45C4 endon("death");
  wait 0.5;
  var_0 = common_scripts\utility::getstruct("truck_speaker", "script_noteworthy");

  if(level._id_4D68 == 1) {
    if(!maps\_utility::_id_12C1()) {
      level._id_45C4 maps\_utility::_id_168C("so_deltacamp_trk_youreup");
    } else {
      level._id_45C4 maps\_utility::_id_168C("so_deltacamp_trk_startingarea");
    }
  } else if(level._id_4D68 == 2) {
    _id_0084("so_trainer2_trk_breach", var_0);
  }
  wait(randomfloatrange(8.0, 11.0));

  if(!maps\_utility::_id_12C1()) {
    _id_0084("so_deltacamp_trk_yourgo", var_0);
  } else {
    _id_0084("so_deltacamp_trk_whenever", var_0);
  }
}

_id_0084(var_0, var_1) {
  _id_0048();

  if(!isDefined(var_1)) {
    var_1 = maps\_utility::_id_0AE9(level.player.origin, level.speakers);
  }
  level._id_0047 = var_1;
  var_1 playSound(var_0, "speaker_sound_interrupt", 1);
}

_id_0048() {
  if(isDefined(level._id_0047)) {
    level._id_0047 notify("speaker_sound_interrupt");
  }
}

_id_4D81() {
  level endon(level._id_4D6B);
  common_scripts\utility::array_thread(level.players, ::_id_4D83);
  level waittill("weapon_hidden_collected");
  var_0 = common_scripts\utility::getstruct("speaker_truck", "script_noteworthy");
  _id_0048();
  _id_0084("so_deltacamp_trk_owntoys", var_0);
}

_id_4D82() {
  level endon(level._id_4D6A);
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

_id_4D83() {
  level endon(level._id_4D6B);
  level endon("weapon_hidden_collected");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(isDefined(var_0) && (var_0 == "ak74u" || var_0 == "usp_no_knife")) {
      level notify("weapon_hidden_collected");
      return;
    }
  }
}

_id_4D84() {
  level endon("missionfailed");

  if(level._id_4D68 == 1) {
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

    if(!isDefined(level._id_45C0)) {
      return;
    }
    level._id_45C0 endon("death");
    _id_0048();
    level._id_45C0 maps\_utility::_id_168C("so_deltacamp_snd_thanks");
    common_scripts\utility::flag_wait(level._id_4D6A);
    var_0 = level.player._id_1890;
    wait 1.0;
    _id_0048();

    if(var_0 > 1) {
      level._id_45C0 maps\_utility::_id_168C("so_deltacamp_snd_nicelydone");
      return;
    }

    level._id_45C0 maps\_utility::_id_168C("so_deltacamp_snd_nogood");
    return;
  } else if(level._id_4D68 == 2) {
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
    maps\_utility::_id_262C("trig_v2_breach_dialog_02");
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
    common_scripts\utility::flag_wait(level._id_4D6A);
    var_0 = level.player._id_1890;
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

_id_4D85() {
  maps\_utility::_id_265A("allies");

  if(level._id_4D68 == 1) {
    var_0 = getent("sandman", "targetname");
    level._id_45C0 = var_0 maps\_utility::_id_166F(1);
    level._id_45C0 thread _id_4D89();
    level._id_45C0 thread _id_4D88();
    level._id_45C0._id_1901 = 1;
    level._id_45C0.allowdeath = 1;
    level._id_45C0.drawoncompass = 0;
    level._id_45C0.health = 1;
    level._id_45C0 maps\_utility::_id_24F5();
    level._id_45C0._id_1032 = "generic";
    var_1 = getent("ent_sandman_scene", "targetname");
    var_1 thread maps\_anim::_id_124E(level._id_45C0, "sandman_idle", "end_idle");
  }

  var_0 = getent("truck", "targetname");
  level._id_45C4 = var_0 maps\_utility::_id_166F(1);
  level._id_45C4 thread _id_4D89();
  level._id_45C4 thread _id_4D88();
  level._id_45C4.allowdeath = 1;
  level._id_45C4.drawoncompass = 0;
  level._id_45C4.health = 1;
  level._id_45C4 maps\_utility::_id_24F5();
  level._id_45C4._id_1032 = "generic";

  if(level._id_4D68 == 1) {
    var_2 = common_scripts\utility::getstruct("loc_truck_look_at_v1_start", "targetname");
    var_2 thread maps\_anim::_id_124E(level._id_45C4, "truck_idle", "end_idle");
    level._id_45C4 thread _id_4D87(var_2);
  } else if(level._id_4D68 == 2) {
    var_3 = common_scripts\utility::getstruct("loc_truck_look_at_bridge", "targetname");
    var_3 thread maps\_anim::_id_124E(level._id_45C4, "truck_idle", "end_idle");
  }

  var_0 = getent("grinch", "targetname");
  level._id_4D86 = var_0 maps\_utility::_id_166F(1);
  level._id_4D86 thread _id_4D89();
  level._id_4D86 thread _id_4D88();
  level._id_4D86.allowdeath = 1;
  level._id_4D86.drawoncompass = 0;
  level._id_4D86.health = 1;
  level._id_4D86 maps\_utility::_id_24F5();
  level._id_4D86._id_1032 = "generic";
  var_1 = getent("ent_grinch_scene", "targetname");
  var_1 thread maps\_anim::_id_124E(level._id_4D86, "grinch_idle", "end_idle");
  var_4 = spawn("script_model", level._id_4D86.origin);
  var_4 setModel("com_folding_chair");
  var_4.angles = level._id_4D86.angles + (0, 0, 0);
  level._id_4D86 thread common_scripts\utility::delete_on_death(var_4);
}

_id_4D87(var_0) {
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
  var_5 = common_scripts\utility::getstruct("loc_truck_look_at_bridge", "targetname");
  var_5 thread maps\_anim::_id_124E(self, "truck_idle", "end_idle");
}

_id_4D88() {
  level endon("special_op_terminated");
  var_0 = undefined;

  for(;;) {
    var_1 = maps\_utility::_id_2608(self.origin);

    if(!isDefined(var_0) || var_0 != var_1) {
      var_0 = var_1;
      self setlookatentity(var_0);
    }

    wait 0.5;
  }
}

_id_4D89() {
  level endon("special_op_terminated");

  for(;;) {
    common_scripts\utility::waittill_any("damage", "death");
    level._id_16CE = gettime();
    maps\_specialops::_id_183F("@SO_DELTACAMP_DEAD_QUOTE_ALLY_HURT");
    thread maps\_utility::_id_1826();
    break;
  }
}

_id_3F71() {
  foreach(var_3, var_1 in level.players) {
    var_1 _id_4D8E();

    if(level._id_4D68 == 2) {
      var_2 = common_scripts\utility::getstruct("struct_start_pos_player" + (var_3 + 1) + "_v2", "targetname");
      var_1 _id_4D8D(var_2);
    }
  }
}

_id_4D8A() {
  if(level._id_4D68 == 1) {
    maps\_specialops::_id_188C(level._id_4D6B, "course_targets_finished", -1, 40, 28);
  } else if(level._id_4D68 == 2) {
    maps\_specialops::_id_188C(level._id_4D6B, "all_players_reached_end", -1, 45, 33);
  }
  thread maps\_specialops::_id_1808(3, &"SO_DELTACAMP_CIV_COUNT", "ui_civ_count");
}

_id_4D8B() {
  level endon("special_op_terminated");

  for(;;) {
    level waittill("civilian_killed", var_0);
    var_0 notify("ui_civ_count", var_0._id_4D8C);

    if(level._id_4D8C == 1) {
      maps\_specialops::_id_1891("veteran");
      continue;
    }

    if(level._id_4D8C == 2) {
      maps\_specialops::_id_1891("hardened");
    }
  }
}

_id_4D8D(var_0) {
  self setorigin(var_0.origin);

  if(isDefined(var_0.angles)) {
    self setplayerangles(var_0.angles);
  }
}

_id_4D8E() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {}
  self givemaxammo(var_2);
}

_id_4D8F() {
  level._id_4D8C = 0;

  foreach(var_1 in level.players) {}
  var_1._id_4D8C = 0;
}

_id_4D90() {
  level._id_4D91 = _id_4DC1("gate_enter_v1");
  level._id_4D91._id_4D92 = 80;

  if(level._id_4D68 == 1) {
    level._id_4D91 thread _id_4042("course_start_open_gate", 0);
  } else if(level._id_4D68 == 2) {
    level._id_4D91 thread _id_4042(undefined, 1, 1);
  }
  level._id_4D93 = _id_4DC1("gate_enter_v2");
  level._id_4D93._id_4D92 = 80;

  if(level._id_4D68 == 1) {
    level._id_4D93 thread _id_4042("course_targets_finished", 1);
  }
}

_id_4D94() {
  if(level._id_4D68 == 1) {
    maps\_utility::_id_25EE("course_start_open_gate", 1.0);
  } else {
    common_scripts\utility::flag_set("course_start_open_gate");
  }
}

_id_4D95(var_0, var_1) {
  if(isDefined(level._id_4D6C)) {
    common_scripts\utility::trigger_off(level._id_4D6C, "script_noteworthy");
  }
  _id_4DA1(var_1);
  _id_4D9A(var_0);
  wait 1.0;
  common_scripts\utility::flag_wait(level._id_4D6B);

  foreach(var_4, var_3 in level._id_4D96) {
    if(isDefined(var_3._id_4D97)) {
      var_3._id_4D97 common_scripts\utility::trigger_on();
      var_3._id_4D97 waittill("trigger");
    }

    if(isDefined(var_3._id_1692)) {
      common_scripts\utility::flag_wait(var_3._id_1692);
    }
    if(isDefined(var_3.script_delay)) {
      wait(var_3.script_delay);
    }
    common_scripts\utility::flag_set(var_3.targetname + "_popped");
    maps\_utility::_id_1F09(var_3._id_4D98, "open");
    maps\_utility::_id_1F09(var_3.targets, "pop_up");
    var_3 waittill("all_targets_down");
    common_scripts\utility::flag_set(var_3.targetname + "_cleared");
    maps\_utility::_id_1F09(var_3._id_4D99, "open");
    thread _id_4DBA();
  }

  common_scripts\utility::flag_set("course_targets_finished");

  if(isDefined(level._id_4D6C)) {
    common_scripts\utility::trigger_on(level._id_4D6C, "script_noteworthy");
  }
}

_id_4D9A(var_0) {
  level._id_4D9B = getEntArray("target_rail_start_point", "targetname");
  level._id_4D9C = getEntArray("target_rail_path_start_point", "targetname");
  level.speakers = getEntArray("speakers", "targetname");
  level._id_4D96 = [];
  level._id_4D9D = getEntArray("melee_clip", "targetname");
  common_scripts\utility::array_thread(level._id_4D9D, maps\_utility::_id_27C5);

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::get_target_ent(var_2);
    level._id_4D96[level._id_4D96.size] = var_3;
  }

  foreach(var_3 in level._id_4D96) {
    var_3._id_4D98 = [];
    var_3._id_4D99 = [];
    var_3.targets = [];
    var_3._id_4D9E = [];
    var_3._id_4D9F = [];
    var_3._id_4DA0 = 0;
    var_6 = var_3 common_scripts\utility::get_linked_ents();

    foreach(var_8 in var_6) {
      if(!isDefined(var_8.code_classname)) {
        continue;
      }
      if(var_8.code_classname == "script_brushmodel") {
        if(!maps\_utility::_id_12C1() && var_8 _id_4DBF("coop_only", ";")) {
          var_8 _id_4DA2();
          continue;
        }

        if(isDefined(var_8.script_noteworthy) && issubstr(var_8.script_noteworthy, "target_")) {
          if(var_8.script_noteworthy == "target_enemy") {
            var_3._id_4D9F[var_3._id_4D9F.size] = var_8;
          } else if(var_8.script_noteworthy == "target_friendly") {
            var_3._id_4D9E[var_3._id_4D9E.size] = var_8;
          } else {
            continue;
          }
          var_8 thread _id_4DA3(var_3, strtok(var_8.script_noteworthy, "_")[1]);
          var_3.targets[var_3.targets.size] = var_8;

          if(var_8 _id_4DBF("invisible", ";")) {
            _id_0049(var_8);
          }
          continue;
        }

        if(var_8 _id_4DBF("door", ";")) {
          if(var_8 _id_4DBF("door_before", ";")) {
            var_3._id_4D98[var_3._id_4D98.size] = var_8;
          } else if(var_8 _id_4DBF("door_after", ";")) {
            var_3._id_4D99[var_3._id_4D99.size] = var_8;
          } else {
            continue;
          }
          var_8 thread _id_4DB4();
        }
      }

      if(var_8.code_classname == "script_model") {
        if(var_8 _id_4DBF("door", ";")) {
          if(var_8 _id_4DBF("door_before", ";")) {
            var_3._id_4D98[var_3._id_4D98.size] = var_8;
          } else if(var_8 _id_4DBF("door_after", ";")) {
            var_3._id_4D99[var_3._id_4D99.size] = var_8;
          } else {
            continue;
          }
          var_8 thread _id_4DB4();
        }
      }

      if(var_8.code_classname == "trigger_multiple" && isDefined(var_8.classname)) {
        if(var_8.classname == "trigger_multiple_flag_set" && isDefined(var_8._id_1692) && common_scripts\utility::flag_exist(var_8._id_1692)) {
          var_3._id_1692 = var_8._id_1692;
          continue;
        } else if(var_8.classname == "trigger_multiple") {
          var_3._id_4D97 = var_8;
          var_3._id_4D97 common_scripts\utility::trigger_off();
          continue;
        }
      }
    }
  }
}

_id_4DA1(var_0) {
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
        if(var_9 _id_4DBF("door", ";")) {
          continue;
        }
      }

      if(var_9.code_classname == "script_model") {
        if(var_9 _id_4DBF("door", ";")) {
          continue;
        }
      }

      var_9 delete();
    }
  }
}

_id_0049(var_0) {
  var_0 maps\_utility::_id_27C5();
  var_0._id_035A maps\_utility::_id_27C5();
}

_id_004A(var_0) {
  var_0 maps\_utility::_id_27C6();
  var_0._id_035A maps\_utility::_id_27C6();
}

_id_4DA2() {
  var_0 = [];
  var_0[var_0.size] = self;
  var_1 = getEntArray(self.target, "targetname");

  foreach(var_3 in var_1) {
    if(var_3.classname == "script_origin") {
      var_0[var_0.size] = getent(var_3.target, "targetname");
    }
    var_0[var_0.size] = var_3;
  }

  common_scripts\utility::array_call(var_0, ::delete);
}

_id_4DA3(var_0, var_1) {
  self._id_4DA4 = undefined;
  var_2 = getEntArray(self.target, "targetname");

  foreach(var_4 in var_2) {
    if(var_4.classname == "script_origin") {
      self._id_4DA5 = var_4;
      continue;
    } else if(var_4.classname == "script_model") {
      self._id_035A = var_4;
      continue;
    }
  }

  self linkto(self._id_4DA5);
  var_6 = getent(self._id_4DA5.target, "targetname");
  var_6 hide();
  var_6 notsolid();
  var_6 linkto(self);
  self._id_035A linkto(self._id_4DA5);

  if(_id_4DBF("reverse", ";")) {
    self._id_4DA5 rotatepitch(90, 0.25);
  } else if(_id_4DBF("sideways_right", ";")) {
    self._id_4DA5 rotateyaw(-180, 0.35);
  } else if(_id_4DBF("sideways_left", ";")) {
    self._id_4DA5 rotateyaw(180, 0.35);
  } else if(_id_4DBF("vertical", ";")) {
    self._id_4DA5 moveto(self._id_4DA5.origin - (0, 0, 36), 0.25);
  } else {
    self._id_4DA5 rotatepitch(-90, 0.25);
  }
  if(_id_4DBF("use_rail", ";")) {
    self._id_4DA6 = undefined;
    self._id_4DA7 = undefined;
    self._id_4DA8 = undefined;
    self._id_4DA7 = maps\_utility::_id_0AE9(self._id_4DA5.origin, level._id_4D9B, 10);
    self._id_4DA8 = getent(self._id_4DA7.target, "targetname");
    self._id_4DA6 = [];
    self._id_4DA6[0] = self._id_4DA7;
    self._id_4DA6[1] = self._id_4DA8;

    foreach(var_8 in self._id_4DA6) {}

    _id_4DB3();
  }

  if(_id_4DBF("use_rail_path", ";")) {
    self._id_4DA9 = [];
    var_10 = maps\_utility::_id_0AE9(self._id_4DA5.origin, level._id_4D9C, 10);

    while(isDefined(var_10)) {
      self._id_4DA9[self._id_4DA9.size] = var_10;

      if(isDefined(var_10.target)) {
        var_10 = var_10 common_scripts\utility::get_target_ent();
        continue;
      }

      var_10 = undefined;
    }
  }

  for(;;) {
    self waittill("pop_up");

    if(_id_4DBF("breach", ";")) {
      level._id_4BB1++;
    }
    if(isDefined(self.script_delay)) {
      wait(self.script_delay);
    }
    _id_4DAC();

    if(_id_4DBF("invisible", ";")) {
      _id_004A(self);
    }
    if(_id_4DBF("melee", ";")) {
      var_11 = maps\_utility::_id_0AE9(self.origin, level._id_4D9D, 120);
      self._id_4DA4 = 1;
      self._id_4DAA = var_11;
      self._id_4DAA maps\_utility::_id_27C6();
    }

    var_12 = 0.25;

    if(!_id_4DBF("breach", ";")) {
      wait(randomfloatrange(0, 0.2));
    } else {
      var_12 = 0.05;
    }
    self solid();
    self playSound("target_up_metal");
    self._id_035A setCanDamage(1);

    if(_id_4DBF("dog_bark", ";")) {
      thread _id_4DAE();
    }
    if(var_1 != "friendly") {
      var_6 enableaimassist();
    }
    if(_id_4DBF("reverse", ";")) {
      self._id_4DA5 rotatepitch(-90, var_12);
    } else if(_id_4DBF("sideways_right", ";")) {
      self._id_4DA5 rotateyaw(180, var_12);
    } else if(_id_4DBF("sideways_left", ";")) {
      self._id_4DA5 rotateyaw(-180, var_12);
    } else if(_id_4DBF("vertical", ";")) {
      self._id_4DA5 moveto(self._id_4DA5.origin + (0, 0, 36), var_12);
    } else {
      self._id_4DA5 rotatepitch(90, var_12);
    }
    wait(var_12);

    if(isDefined(self._id_4DA7)) {
      thread _id_4DAD();
    } else if(isDefined(self._id_4DA9) && self._id_4DA9.size) {
      thread _id_4DAF();
    }
    for(;;) {
      self._id_035A waittill("damage", var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22);

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
        if(isDefined(self._id_4DA4)) {
          if(var_17 != "MOD_MELEE") {
            continue;
          }
        }

        self playSound("target_metal_hit");

        if(var_1 == "friendly") {
          thread _id_4DBB();
          var_23 = maps\_utility::_id_0AE9(var_14.origin, level.speakers);
          var_23 playSound("target_mistake_buzzer");
          var_14._id_4D8C++;
          level._id_4D8C++;
          level notify("civilian_killed", var_14);
        } else {
          var_14 maps\_player_stats::_id_0A34(self, var_17, var_22);
          var_14 notify("ui_kill_count", var_14.stats["kills"]);
          level notify("target_killed");

          if(_id_4DBF("breach", ";")) {
            level._id_4BB1--;
          }
          var_0._id_4DA0++;

          if(var_0._id_4DA0 >= var_0._id_4D9F.size) {
            var_0 notify("all_targets_down");
          }
        }

        if(var_17 == "MOD_GRENADE_SPLASH") {
          self notify("hit_with_grenade");
        }
        break;
      }
    }

    if(isDefined(self._id_4DA4)) {
      self._id_4DAA maps\_utility::_id_27C5();
    }
    self notify("hit");
    self notify("target_going_back_down");
    self.health = 1000;
    var_6 disableaimassist();
    self notsolid();

    if(isDefined(self._id_4DA5._id_4DAB)) {
      self._id_4DA5.origin = self._id_4DA5._id_4DAB;
    }
    if(_id_4DBF("reverse", ";")) {
      self._id_4DA5 rotatepitch(90, 0.25);
    } else if(_id_4DBF("sideways_right", ";")) {
      self._id_4DA5 rotateyaw(-180, 0.35);
    } else if(_id_4DBF("sideways_left", ";")) {
      self._id_4DA5 rotateyaw(180, 0.35);
    } else if(_id_4DBF("vertical", ";")) {
      self._id_4DA5 moveto(self._id_4DA5.origin - (0, 0, 36), 0.25);
    } else {
      self._id_4DA5 rotatepitch(-90, 0.25);
    }
    self._id_035A setCanDamage(0);
    wait 0.25;
  }
}

_id_4DAC() {
  var_0 = self.origin;
  var_1 = undefined;

  if(_id_4DBF("melee", ";")) {
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

_id_4DAD() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0.angles = self._id_4DA5.angles;
  var_0.origin = self._id_4DA5.origin;
  self._id_4DA5 thread _id_4DB2(var_0);
  var_0 endon("deleted_because_player_was_too_close");
  var_0 endon("death");

  foreach(var_2 in level.players) {}
  var_0 thread _id_4DB1(var_2);

  thread _id_4DB0(var_0);
  var_4 = common_scripts\utility::ter_op(isDefined(self._id_2AFE), self._id_2AFE, 1);
  var_5 = distance(self._id_4DA6[0].origin, self._id_4DA6[1].origin);
  var_6 = var_5 / (12.0 * var_4);

  for(;;) {
    var_0 moveto(self._id_4DA8.origin, var_6);
    wait(var_6);
    var_0 moveto(self._id_4DA7.origin, var_6);
    wait(var_6);
  }
}

_id_4DAE() {
  level endon("special_op_terminated");
  self endon("target_going_back_down");

  for(;;) {
    self playSound("anml_dog_bark", "bark_done");
    self waittill("bark_done");
    wait(randomfloatrange(0.1, 0.5));
  }
}

_id_4DAF() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0.angles = self._id_4DA5.angles;
  var_0.origin = self._id_4DA5.origin;

  if(_id_4DBF("bounce", ";")) {
    self._id_4DA5 thread _id_4DB2(var_0, 8, 2.0);
  } else {
    self._id_4DA5 thread _id_4DB2(var_0, 0, 0.0);
  }
  var_0 endon("deleted_because_player_was_too_close");
  var_0 endon("death");

  foreach(var_2 in level.players) {}
  var_0 thread _id_4DB1(var_2);

  thread _id_4DB0(var_0);

  for(var_4 = 0; var_4 < self._id_4DA9.size - 1; var_4++) {
    var_5 = common_scripts\utility::ter_op(isDefined(self._id_2AFE), self._id_2AFE, 1);
    var_6 = distance(self._id_4DA9[var_4].origin, self._id_4DA9[var_4 + 1].origin);
    var_7 = var_6 / (12.0 * var_5);
    var_0 moveto(self._id_4DA9[var_4 + 1].origin, var_7);
    wait(var_7);
  }

  var_0 delete();
}

_id_4DB0(var_0) {
  var_0 endon("death");
  self waittill("target_going_back_down");
  var_0 delete();
}

_id_4DB1(var_0) {
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

_id_4DB2(var_0, var_1, var_2) {
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

    self._id_4DAB = var_0.origin;
    self.origin = var_0.origin + (0, 0, var_5);
  }
}

_id_4DB3() {
  if(self._id_4DA6[0] _id_4DBF("force_start_here", ";")) {
    self._id_4DA7 = self._id_4DA6[0];
    self._id_4DA8 = self._id_4DA6[1];
  } else if(self._id_4DA6[1] _id_4DBF("force_start_here", ";")) {
    self._id_4DA7 = self._id_4DA6[1];
    self._id_4DA8 = self._id_4DA6[0];
  } else if(common_scripts\utility::cointoss()) {
    self._id_4DA7 = self._id_4DA6[0];
    self._id_4DA8 = self._id_4DA6[1];
  } else {
    self._id_4DA7 = self._id_4DA6[1];
    self._id_4DA8 = self._id_4DA6[0];
  }

  self._id_4DA5 moveto(self._id_4DA7.origin, 0.1);
}

_id_4DB4() {
  var_0 = -90;

  if(isDefined(self._id_2961)) {
    var_0 = self._id_2961;
  }
  self waittill("open");
  self rotateyaw(var_0, 0.5, 0.2, 0.1);
}

_id_4DB5() {
  foreach(var_1 in level.players) {}
  var_1 _id_4D8A();

  thread _id_4D8B();
}

_id_4DB6() {
  level._id_4DB7 = 0;
  level._id_4DB8 = 1;
}

_id_4DB9(var_0) {
  level._id_4DB7++;
  var_1 = level._id_4DB7;

  if(level._id_4DB7 - level._id_4DB8 > 0) {
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

  var_3 = maps\_specialops::_id_16B6(2, 0, var_2);
  var_3.alignx = "center";
  var_3.horzalign = "center";
  var_3.fontscale = 2;

  if(var_0 == "civilian_hit") {
    var_3 maps\_specialops::_id_16AC();
  } else {
    var_3 maps\_specialops::_id_185F();
  }
  wait 0.2;
  var_4 = 1;
  var_3 fadeovertime(var_4);
  var_3.alpha = 0;
  var_3 changefontscaleovertime(var_4);
  var_3.fontscale = 0.5;
  wait(var_4 * 0.75);
  level notify("pre_display_splash" + (var_1 + 1));
  level._id_4DB8++;
  wait(var_4 * 0.25);
  var_3 destroy();
}

_id_4DBA() {
  wait 0.05;
  _id_4DB9("area_cleared");
}

_id_4DBB() {
  _id_4DB9("civilian_hit");
}

_id_16C2() {
  var_0 = level._id_16CE - level._id_16CF;
  var_1 = maps\_utility::_id_16D0(var_0 / 1000, 1);
  var_2 = 50000;
  var_3 = int(max(var_2 - var_0, 0));
  var_4 = int(var_3 / var_2 * 8000);
  var_5 = 0;

  foreach(var_7 in level.players) {}
  var_5 = var_5 + 100 * var_7.stats["kills"];

  var_9 = level._id_4D8C * -500;
  var_10 = int(max(var_4 + var_5 + var_9, 0));

  foreach(var_7 in level.players) {
    var_7._id_1969 = var_7._id_1890;

    if(level._id_4D68 == 2) {
      if(var_1 == "0:33.0" && var_7._id_1969 < 3) {
        var_1 = "0:33.1";
      }
    }

    var_12 = var_7.stats["kills"];
    var_13 = var_7._id_4D8C;

    if(maps\_utility::_id_12C1()) {
      var_14 = maps\_utility::_id_133A(var_7).stats["kills"];
      var_15 = maps\_utility::_id_133A(var_7)._id_4D8C;

      if(isDefined(level._id_16C9) && level._id_16C9 == 1) {
        setDvar("ui_hide_hint", 0);
        var_7 maps\_utility::_id_16C7("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_PERFORMANCE_PARTNER");
        var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_FINISH_TIME", var_1, var_1);
        var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_ENEMIES_HIT", var_12, var_14);
        var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_CIVS_HIT", var_13, var_15);
      } else {
        setDvar("ui_hide_hint", 1);
        var_7 maps\_utility::_id_16C7("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_PERFORMANCE_PARTNER", "@SPECIAL_OPS_UI_SCORE");
        var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_FINISH_TIME", var_1, var_1, var_4);
        var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_ENEMIES_HIT", var_12, var_14, var_5);
        var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_CIVS_HIT", var_13, var_15, var_9);
        var_7 maps\_utility::_id_16C8();

        if(!var_7 _id_4DBC()) {
          var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_MEDAL_NEXT_TIME", var_7 _id_4DBD());

          if(!issplitscreen()) {
            var_7 maps\_utility::_id_16C8();
          }
        }

        var_7 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_TEAM_SCORE", var_10);
      }
    } else if(isDefined(level._id_16C9) && level._id_16C9 == 1) {
      setDvar("ui_hide_hint", 0);
      var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_FINISH_TIME", var_1);
      var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_ENEMIES_HIT", var_12);
      var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_CIVS_HIT", var_13);
    } else {
      setDvar("ui_hide_hint", 1);
      var_7 maps\_utility::_id_16C7("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_UI_SCORE");
      var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_FINISH_TIME", var_1, var_4);
      var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_ENEMIES_HIT", var_12, var_5);
      var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_CIVS_HIT", var_13, var_9);
      var_7 maps\_utility::_id_16C8();

      if(!var_7 _id_4DBC()) {
        var_7 maps\_utility::_id_16C7("@SO_DELTACAMP_SCOREBOARD_MEDAL_NEXT_TIME", var_7 _id_4DBD());

        if(!issplitscreen()) {
          var_7 maps\_utility::_id_16C8();
        }
      }

      var_7 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_SCORE_FINAL", var_10);
    }

    if(!isDefined(level._id_16C9) || level._id_16C9 == 0) {
      var_7 maps\_specialops::_id_17FB(var_0);
      var_7 maps\_specialops::_id_17FE(var_10);
    }
  }
}

_id_4DBC() {
  var_0 = maps\_specialops::_id_1888();

  if(isDefined(self._id_1969)) {
    var_0 = int(max(var_0, self._id_1969 + 1));
  }
  return var_0 == 4;
}

_id_4DBD() {
  var_0 = _id_4DBE();
  var_1 = 0;

  if(level._id_4D68 == 1) {
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
  } else if(level._id_4D68 == 2) {
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

  return maps\_utility::_id_16D0(var_1, 1);
}

_id_4DBE() {
  var_0 = maps\_specialops::_id_1888();

  if(isDefined(self._id_1969)) {
    var_0 = int(max(var_0, self._id_1969 + 1));
  }
  return var_0;
}

_id_4DBF(var_0, var_1) {
  if(!isDefined(self) || !isDefined(self._id_164F)) {
    return 0;
  }
  var_2 = strtok(self._id_164F, var_1);
  return maps\_utility::_id_0AD1(var_2, var_0);
}

_id_4DC0(var_0, var_1, var_2) {
  if(!isDefined(self) || !isDefined(self._id_164F)) {
    return 0;
  }
  var_3 = strtok(self._id_164F, var_2);
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

  self._id_164F = var_4;
}

_id_4DC1(var_0) {
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
  var_11 linkto(var_2);

  foreach(var_14 in var_4) {}
  var_14 linkto(var_2);

  var_16 = var_2;
  var_16._id_4DC2 = var_4;

  if(isDefined(var_6)) {
    var_6 unlink();
    var_16._id_4DC3 = var_6;
  }

  if(isDefined(var_5)) {
    var_16.trigger = var_5;
  }
  return var_16;
}

_id_4042(var_0, var_1, var_2) {
  if(isDefined(self._id_288A)) {
    while(isDefined(self._id_288A)) {
      wait 0.05;
    }
  }

  self._id_288A = 1;
  var_3 = 90;

  if(isDefined(self._id_4D92)) {
    var_3 = self._id_4D92;
  }
  if(isDefined(var_0)) {
    common_scripts\utility::flag_wait(var_0);
  }
  var_4 = 4;

  if(isDefined(var_1)) {
    var_4 = 1.5;
    self rotateto(self.angles + (0, var_3, 0), 1.5, 0.25, 0.25);
  } else {
    self rotateto(self.angles + (0, var_3, 0), 4, 1.5, 1.5);
  }
  if(isDefined(self._id_4DC3)) {
    self._id_4DC3 maps\_utility::_id_27C5();
  }
  if(!isDefined(var_2) || var_2 == 0) {
    thread maps\_utility::play_sound_on_entity("scn_training_fence_open");
  }
  common_scripts\utility::array_call(self._id_4DC2, ::notsolid);
  wait(var_4);
  self._id_288A = undefined;
}

_id_4DC4(var_0, var_1) {
  if(isDefined(self._id_288A)) {
    while(isDefined(self._id_288A)) {
      wait 0.05;
    }
  }

  self._id_288A = 1;
  var_2 = -90;

  if(isDefined(self._id_4DC5)) {
    var_2 = self._id_4DC5;
  }
  if(isDefined(var_0)) {
    common_scripts\utility::flag_wait(var_0);
  }
  var_3 = 2;

  if(isDefined(var_1)) {
    var_3 = 1;
    self rotateto(self.angles + (0, var_2, 0), 1, 0.25, 0.25);
  } else {
    self rotateto(self.angles + (0, var_2, 0), 2, 0.5, 0.5);
  }
  if(isDefined(self._id_4DC3)) {
    self._id_4DC3 maps\_utility::_id_27C6();
  }
  thread maps\_utility::play_sound_on_entity("scn_training_fence_close");
  common_scripts\utility::array_call(self._id_4DC2, ::solid);
  wait(var_3);
  self._id_288A = undefined;
}