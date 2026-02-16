/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_dj.gsc
************************************************/

init_dj_quests() {
  level.played_dj_vos = [];
  level.played_dj_vos[""] = 0;
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 0, ::init_fetch_quest, ::do_fetch_quest, ::complete_fetch_quest, ::debug_beat_fetch_quest);
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 1, ::blank, ::wait_use_pap_portal, ::blank, ::debug_use_pap_portal);
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 2, ::init_first_speaker_defense, ::do_first_speaker_defend, ::blank, ::debug_beat_speaker_defense);
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 3, ::init_second_speaker_defense, ::do_second_speaker_defend, ::blank, ::debug_beat_speaker_defense);
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 4, ::init_third_speaker_defense, ::do_third_speaker_defend, ::complete_all_speaker_defense, ::debug_beat_speaker_defense);
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 5, ::blank, ::wait_one_wave, ::blank, ::debug_beat_wait_one_wave);
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 6, ::init_get_tone_generator, ::get_tone_generator, ::complete_get_tone_generator, ::debug_get_tone_generator);
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 7, ::init_place_tone_generator, ::place_tone_generator, ::complete_place_tone_generator, ::debug_place_tone_generator);
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 8, ::init_match_ufo_tone, ::match_ufo_tone, ::complete_match_ufo_tone, ::debug_match_ufo_tone);
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 9, ::blank, ::ufo_suicide_bomber, ::blank, ::debug_beat_ufo_suicide_bomber);
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 10, ::init_alien_grey_fight, ::alien_grey_fight, ::complete_grey_fight, ::debug_beat_alien_grey_fight);
  scripts\cp\zombies\zombie_quest::register_quest_step("ufo", 11, ::init_ufo_projectile_attack, ::ufo_projectile_attack, ::complete_ufo_projectile_attack, ::debug_beat_ufo_projectile_attack);
}

dj_quest_dialogue_vo() {
  for(;;) {
    if(isDefined(level.played_dj_vos["dj_quest_ufo_partsrecovery_start"])) {
      level thread scripts\cp\cp_vo::try_to_play_vo("quest_dj_intro_1", "zmb_dialogue_vo");
      return;
    }

    wait(1);
  }
}

init_fetch_quest() {
  level.selected_dj_parts = [];
  level.use_dj_door_func = ::fetch_quest_use_dj_door;
  scripts\engine\utility::flag_init("dj_fetch_quest_completed");
  scripts\engine\utility::flag_init("ufo_destroyed");
}

debug_dj_location() {
  for(;;) {
    if(getDvar("scr_dj_location") != "") {
      level thread setup_dj_doors();
      setDvar("scr_dj_location", "");
    }

    wait(1);
  }
}

complete_fetch_quest() {
  if(!scripts\engine\utility::istrue(level.dj_part_1_found)) {
    pick_up_part_1(level.selected_dj_parts[1], level.players[0]);
  }

  if(!scripts\engine\utility::istrue(level.dj_part_2_found)) {
    pick_up_part_2(level.selected_dj_parts[2], level.players[0]);
  }

  if(!scripts\engine\utility::istrue(level.dj_part_3_found)) {
    pick_up_part_3(level.selected_dj_parts[3], level.players[0]);
  }
}

do_fetch_quest() {
  scripts\engine\utility::flag_wait("dj_fetch_quest_completed");
}

debug_beat_fetch_quest() {}

fetch_quest_use_dj_door(var_0, var_1) {
  if(!isDefined(level.first_time_use_door_allparts)) {
    level.first_time_use_door_allparts = 0;
  }

  level thread play_dj_parts_quest_vo(var_1, var_0);
}

play_dj_willard_exchange(var_0) {
  level.pause_nag_vo = 1;
  level.disable_broadcast = 1;
  scripts\cp\maps\cp_zmb\cp_zmb_vo::clear_up_all_vo(var_0);
  scripts\cp\cp_vo::func_C9CB([var_0]);
  level.dj set_dj_state("approach_mic");
  if(randomint(100) >= 50) {
    playsoundatpos(level.dj.origin, "dj_dj_noparts_1");
    wait(scripts\cp\cp_vo::get_sound_length("dj_dj_noparts_1"));
    if(var_0.vo_prefix == "p6_") {
      var_0 playlocalsound("p6_plr_dj_noparts_2");
    } else {
      var_0 playlocalsound("p6_dj_noparts_2");
    }

    wait(scripts\cp\cp_vo::get_sound_length("p6_dj_noparts_2"));
    playsoundatpos(level.dj.origin, "dj_dj_noparts_3");
    wait(scripts\cp\cp_vo::get_sound_length("dj_dj_noparts_3"));
  } else {
    playsoundatpos(level.dj.origin, "dj_dj_quest_success_1");
    wait(scripts\cp\cp_vo::get_sound_length("dj_dj_quest_success_1"));
    if(var_0.vo_prefix == "p6_") {
      var_0 playlocalsound("p6_plr_dj_quest_success_2");
    } else {
      var_0 playlocalsound("p6_dj_quest_success_2");
    }

    wait(scripts\cp\cp_vo::get_sound_length("p6_dj_quest_success_2"));
    playsoundatpos(level.dj.origin, "dj_dj_quest_success_3");
    wait(scripts\cp\cp_vo::get_sound_length("dj_dj_quest_success_3"));
  }

  level.dj set_dj_state("open_window");
  scripts\cp\cp_vo::func_12BE3([var_0]);
  level.pause_nag_vo = 0;
  level.disable_broadcast = undefined;
}

play_dj_parts_quest_vo(var_0, var_1) {
  level.disable_broadcast = 1;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
  if(isDefined(var_0.vo_prefix)) {
    if(var_0.vo_prefix == "p5_" || var_0.vo_prefix == "p6_") {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("quest_intro", "zmb_comment_vo");
      wait(scripts\cp\cp_vo::get_sound_length(var_0.vo_prefix + "quest_intro") + 3);
    }
  }

  if(get_num_of_dj_quest_parts_collected() == 0) {
    if(randomint(100) > 50) {
      if(var_0.vo_prefix == "p6_") {
        play_dj_willard_exchange(var_0);
      } else if(var_0.vo_prefix == "p5_") {
        playsoundatpos(level.dj.origin, "dj_quest_ufo_partsrecovery_fail");
        wait(scripts\cp\cp_vo::get_sound_length("dj_quest_ufo_partsrecovery_fail"));
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("quest_return_noparts", "zmb_comment_vo");
      }
    } else {
      playsoundatpos(level.dj.origin, "dj_quest_ufo_partsrecovery_fail");
      wait(scripts\cp\cp_vo::get_sound_length(var_0.vo_prefix + "quest_return_noparts"));
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("quest_return_noparts", "zmb_comment_vo");
    }

    level.first_time_use_door_allparts = 1;
  } else if(get_num_of_dj_quest_parts_collected() == 1) {
    if(var_0.vo_prefix == "p6_" || var_0.vo_prefix == "p5_") {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("quest_return_generic", "zmb_comment_vo");
      wait(scripts\cp\cp_vo::get_sound_length(var_0.vo_prefix + "quest_return_generic"));
      playsoundatpos(level.dj.origin, "dj_quest_parts_1");
    }

    level.first_time_use_door_allparts = 1;
  } else if(get_num_of_dj_quest_parts_collected() == 2) {
    if(var_0.vo_prefix == "p6_" || var_0.vo_prefix == "p5_") {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("quest_return_generic", "zmb_comment_vo");
      wait(scripts\cp\cp_vo::get_sound_length(var_0.vo_prefix + "quest_return_generic"));
      playsoundatpos(level.dj.origin, "dj_quest_parts_2");
    }

    level.first_time_use_door_allparts = 1;
  } else if(get_num_of_dj_quest_parts_collected() == 3) {
    scripts\cp\cp_vo::remove_from_nag_vo("nag_return_djpart");
    if(level.first_time_use_door_allparts == 0) {
      playsoundatpos(level.dj.origin, "dj_quest_ufo_parts_before_quest");
    } else {
      playsoundatpos(level.dj.origin, "dj_quest_parts_all");
    }

    scripts\cp\zombies\zombie_analytics::log_frequency_device_crafted_dj(level.wave_num, var_1.name);
    level.use_dj_door_func = undefined;
  }

  level.disable_broadcast = undefined;
  scripts\cp\cp_vo::remove_from_nag_vo("dj_quest_ufo_partsrecovery_start");
  level scripts\cp\cp_vo::add_to_nag_vo("dj_craft_nag", "zmb_dj_vo", 60, 60, 2, 1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

init_part_1() {
  init_dj_quest_part("dj_quest_part_1", "zmb_frequency_device_radio");
}

pick_up_part_1(var_0, var_1) {
  level.dj_part_1_found = 1;
  if(randomint(100) > 50) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_dj", "zmb_comment_vo", "low", 10, 0, 0, 1, 50);
  } else {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_dj_boombox", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  }

  level thread scripts\cp\cp_vo::remove_from_nag_vo("dj_craft_nag", 1);
  pick_up_dj_quest_part(var_0, var_1, 22);
}

init_part_2() {
  init_dj_quest_part("dj_quest_part_2", "zmb_frequency_device_calculator");
}

pick_up_part_2(var_0, var_1) {
  level.dj_part_2_found = 1;
  if(randomint(100) > 50) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_dj", "zmb_comment_vo", "low", 10, 0, 0, 1, 50);
  } else {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_dj_calculator", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  }

  pick_up_dj_quest_part(var_0, var_1, 23);
}

init_part_3() {
  init_dj_quest_part("dj_quest_part_3", "zmb_frequency_device_umbrella_ground");
}

pick_up_part_3(var_0, var_1) {
  level.dj_part_3_found = 1;
  if(randomint(100) > 50) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_dj", "zmb_comment_vo", "low", 10, 0, 0, 1, 50);
  } else {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_dj_umbrella", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  }

  pick_up_dj_quest_part(var_0, var_1, 24);
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dj_quest_ufo_partsrecovery_hint");
}

init_dj_quest_part(var_0, var_1) {
  if(scripts\cp\utility::is_codxp()) {
    return;
  }

  if(!isDefined(level.djpartsareas)) {
    level.djpartsareas = ["area_1", "area_2", "area_3"];
  }

  var_2 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  var_3 = scripts\engine\utility::random(level.djpartsareas);
  var_4 = scripts\engine\utility::array_randomize(var_2);
  var_5 = undefined;
  foreach(var_7 in var_4) {
    if(!isDefined(var_5) && var_3 == var_7.groupname) {
      var_5 = var_7;
      level.djpartsareas = scripts\engine\utility::array_remove(level.djpartsareas, var_7.groupname);
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_7);
  }

  var_9 = scripts\engine\utility::getstruct(var_5.target, "targetname");
  var_10 = spawn("script_model", var_9.origin);
  var_10 setModel(var_1);
  if(isDefined(var_9.angles)) {
    var_10.angles = var_9.angles;
  }

  var_5.part_model = var_10;
  var_5.custom_search_dist = 96;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_5);
  add_to_dj_quest_part_list(var_5);
}

pick_up_dj_quest_part(var_0, var_1, var_2) {
  if(get_num_of_dj_quest_parts_collected() == 3) {
    scripts\engine\utility::flag_set("dj_fetch_quest_completed");
    var_1 thread scripts\cp\cp_vo::add_to_nag_vo("nag_return_djpart", "zmb_comment_vo", 60, 100, 3, 1);
  }

  playFX(level._effect["souvenir_pickup"], var_0.part_model.origin);
  var_1 playlocalsound("part_pickup");
  scripts\cp\zombies\zombie_analytics::log_frequency_device_collected(level.wave_num, var_0.groupname, var_0.part_model.model);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.part_model delete();
  level scripts\cp\utility::set_quest_icon(var_2);
}

get_num_of_dj_quest_parts_collected() {
  var_0 = 0;
  if(scripts\engine\utility::istrue(level.dj_part_1_found)) {
    var_0++;
  }

  if(scripts\engine\utility::istrue(level.dj_part_2_found)) {
    var_0++;
  }

  if(scripts\engine\utility::istrue(level.dj_part_3_found)) {
    var_0++;
  }

  return var_0;
}

add_to_dj_quest_part_list(var_0) {
  level.selected_dj_parts[level.selected_dj_parts.size + 1] = var_0;
}

setup_dj_doors() {
  var_0 = scripts\engine\utility::getStructArray("dj_quest_door", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.selected = 0;
  }

  if(isDefined(level.the_hoff)) {
    return;
  }

  level.selected_dj_door = scripts\engine\utility::random(var_0);
  level.selected_dj_door.selected = 1;
  level thread setup_dj_booth(level.selected_dj_door);
}

choose_new_dj_door() {
  level notify("choose_new_dj_door");
  level endon("choose_new_dj_door");
  if(isDefined(level.the_hoff)) {
    return;
  }

  level.disable_broadcast = 1;
  while(!isDefined(level.dj) || !isDefined(level.dj.current_state) || level.dj.current_state != "idle") {
    wait(1);
  }

  for(;;) {
    if(level.dj.current_state != "close_window") {
      set_dj_state("close_window");
    }

    wait(1);
    if(level.dj.current_state == "close_window") {
      break;
    }
  }

  var_0 = scripts\engine\utility::getStructArray("dj_quest_door", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.selected = 0;
  }

  level.dj waittill("window_closed");
  if(isDefined(level.the_hoff)) {
    return;
  }

  level.selected_dj_door = scripts\engine\utility::random(var_0);
  level.selected_dj_door.selected = 1;
  level thread setup_dj_booth(level.selected_dj_door);
}

wait_use_pap_portal() {
  for(;;) {
    level waittill("wave_start_sound_done");
    if(scripts\engine\utility::flag("pap_portal_used")) {
      break;
    }
  }
}

debug_use_pap_portal() {}

wait_some_wave() {
  level endon("stop_wait_some_wave");
  var_0 = 3;
  var_1 = 0;
  for(;;) {
    level waittill("wave_start_sound_done");
    var_1++;
    if(var_1 >= var_0) {
      break;
    }
  }
}

debug_beat_wait_some_wave() {}

wait_one_wave() {
  level endon("stop_wait_one_wave");
  level waittill("regular_wave_starting");
}

debug_beat_wait_one_wave() {}

init_first_speaker_defense() {
  scripts\engine\utility::flag_init("defend_sequence");
  scripts\engine\utility::flag_init("dj_request_defense_done");
  level.selected_speaker_defense_locations = [];
  level.speaker_defense_length = 60;
  level.use_dj_door_func = ::use_dj_door_to_request_defense;
  level.frequency_device_clip = getent("frequency_device_clip", "targetname");
  level.frequency_device_clip.originalloc = level.frequency_device_clip.origin;
}

use_dj_door_to_request_defense(var_0, var_1) {
  scripts\engine\utility::flag_set("dj_request_defense_done");
  level thread scripts\cp\cp_vo::try_to_play_vo("dj_quest_ufo_speakerdefense_start", "zmb_dj_vo");
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("zm_special_item", 3);
  }
}

use_dj_door_during_speaker_defense(var_0, var_1) {
  playsoundatpos(level.dj.origin, "dj_quest_freq_notready");
}

use_dj_door_after_fail_speaker_defense(var_0, var_1) {
  scripts\engine\utility::flag_set("dj_request_defense_done");
  level.use_dj_door_func = ::use_dj_door_during_speaker_defense;
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("zm_special_item", 3);
  }
}

use_dj_door_to_pick_up_analyzer(var_0, var_1) {}

init_second_speaker_defense() {
  level.use_dj_door_func = ::use_dj_door_to_request_defense;
  level.speaker_defense_length = 90;
}

init_third_speaker_defense() {
  level.use_dj_door_func = ::use_dj_door_to_request_defense;
  level.speaker_defense_length = 120;
}

do_first_speaker_defend() {
  level thread ufo_light_sequence_pre_defense();
  do_speaker_defense(20);
}

do_second_speaker_defend() {
  do_speaker_defense(22);
}

do_third_speaker_defend() {
  do_speaker_defense(25);
}

do_speaker_defense(var_0) {
  scripts\engine\utility::flag_wait("dj_request_defense_done");
  scripts\engine\utility::flag_set("defend_sequence");
  var_1 = get_speaker_loc(var_0);
  for(;;) {
    var_2 = level scripts\engine\utility::waittill_any_return("speaker_defense_failed", "speaker_defense_completed");
    if(var_2 == "speaker_defense_failed") {
      level thread scripts\cp\cp_vo::try_to_play_vo("dj_quest_ufo_partsrecovery_fail", "zmb_dj_vo", "high", 20, 0, 0, 1);
      scripts\engine\utility::flag_wait("dj_request_defense_done");
      var_1 thread playstaticsoundinarea(var_1);
      var_1 thread managespeakerlocactivation(var_1);
      continue;
    } else {
      level scripts\engine\utility::waittill_multiple("speaker_picked_up", "regular_wave_starting");
      level.use_dj_door_func = undefined;
      break;
    }
  }
}

complete_all_speaker_defense() {
  level.use_dj_door_func = undefined;
  scripts\engine\utility::flag_clear("defend_sequence");
  level thread choose_new_dj_door();
}

ufo_light_sequence_pre_defense() {
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::flashufolights(0);
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::playsequence(["01", "02", "03", "04", "05", "06"], 0);
}

debug_beat_speaker_defense() {}

select_speaker_defense_locations() {
  var_0 = scripts\engine\utility::getStructArray("dj_quest_speaker", "script_noteworthy");
  var_3 = [];
  var_4 = [];
  foreach(var_6 in var_0) {
    if(isDefined(var_6.area_name) && var_6.area_name == "underground_route") {
      var_3[var_3.size] = var_6;
      continue;
    }

    var_4[var_4.size] = var_6;
  }

  for(var_1 = 0; var_1 < 3; var_1++) {
    if(var_1 < 1) {
      var_8 = scripts\engine\utility::random(var_3);
      var_3 = scripts\engine\utility::array_remove(var_3, var_8);
      level.selected_speaker_defense_locations[level.selected_speaker_defense_locations.size] = var_8;
      continue;
    }

    var_9 = scripts\engine\utility::random(var_4);
    var_4 = scripts\engine\utility::array_remove(var_4, var_9);
    level.selected_speaker_defense_locations[level.selected_speaker_defense_locations.size] = var_9;
  }
}

init_get_tone_generator() {
  level.use_dj_door_func = ::use_dj_door_to_get_tone_generator;
  scripts\engine\utility::flag_init("tone_generators_given");
}

get_tone_generator() {
  scripts\engine\utility::flag_wait("tone_generators_given");
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("zm_special_item", 5);
  }
}

complete_get_tone_generator() {
  level.use_dj_door_func = undefined;
  level thread scripts\cp\cp_vo::add_to_nag_vo("dj_quest_ufo_tonegen_hint", "zmb_dj_vo", 60, 15, 2, 1);
}

debug_get_tone_generator() {}

use_dj_door_to_get_tone_generator(var_0, var_1) {
  scripts\engine\utility::flag_set("tone_generators_given");
  level scripts\cp\cp_vo::add_to_nag_vo("dj_quest_ufo_tonegen_nag", "zmb_dj_vo", 60, 60, 2, 1);
  scripts\cp\zombies\zombie_analytics::log_frequency_device_crafted_dj(level.wave_num, var_0.name);
  level thread scripts\cp\cp_vo::add_to_nag_vo("dj_quest_ufo_tonegen_nag", "zmb_dj_vo", 60, 15, 2, 1);
  level.use_dj_door_func = ::use_dj_door_after_getting_tone_generator;
}

use_dj_door_after_getting_tone_generator(var_0, var_1) {}

init_place_tone_generator() {
  scripts\engine\utility::flag_init("all_structs_placed");
  scripts\engine\utility::flag_init("all_center_positions_used");
  level.centerstructstriggered = [];
  activateallmiddleplacementstructs();
}

place_tone_generator() {
  scripts\engine\utility::flag_wait("all_center_positions_used");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dj_quest_ufo_tonegen_nag", 1);
}

complete_place_tone_generator() {
  scripts\engine\utility::flag_set("jukebox_paused");
  level notify("skip_song");
  disableparkpas();
}

debug_place_tone_generator() {}

init_match_ufo_tone() {
  scripts\engine\utility::flag_init("ufo_listening");
  scripts\engine\utility::flag_init("tones_played_successfully");
  scripts\engine\utility::flag_init("ufo_intro_reach_center_portal");
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::start_grey_fight_blocker_vfx();
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::disableportals();
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::setalltonestructstoneutralstate();
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::ufo_intro_fly_to_center_portal();
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::move_grey_fight_clip_down();
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::ufostopwavefromprogressing();
}

match_ufo_tone() {
  var_0 = level.ufo;
  level thread ufo_player_vo();
  scripts\cp\zombies\zombie_analytics::log_tone_sequence_activated(level.wave_num);
  var_0 thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::start_match_tone_sequence();
  scripts\engine\utility::flag_wait("tones_played_successfully");
}

ufo_player_vo() {
  level endon("game_ended");
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("ufo_first");
  wait(4);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_ufo_spawn_action", "zmb_announcer_vo", "highest", 60, 0, 0, 1);
}

complete_match_ufo_tone() {
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::destroyalltonestructs();
  scripts\engine\utility::flag_set("tones_played_successfully");
}

debug_match_ufo_tone() {}

ufo_suicide_bomber() {
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::ufo_suicide_bomber_sequence();
}

debug_beat_ufo_suicide_bomber() {}

init_alien_grey_fight() {}

alien_grey_fight() {
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::start_grey_sequence();
  level waittill("complete_alien_grey_fight");
}

complete_grey_fight() {
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::clear_grey_fight_clips();
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::stop_grey_fight_blocker_vfx();
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::stop_grey_fight_blocker_sfx();
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::drop_alien_fuses();
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::enableportals();
  var_0 = spawn("script_model", level.players[0].origin);
  var_0 setModel("tag_origin");
  var_0.team = "allies";
  level.forced_nuke = 1;
  scripts\cp\loot::process_loot_content(level.players[0], "kill_50", var_0, 0);
  level.wave_num_override = undefined;
  level.spawndelayoverride = undefined;
  wait(5);
  scripts\engine\utility::flag_clear("pause_wave_progression");
  scripts\engine\utility::flag_clear("all_center_positions_used");
  if(level.wave_num == level.ufo_starting_wave) {
    level.current_enemy_deaths = level.savedcurrentdeaths;
    level.max_static_spawned_enemies = level.savemaxspawns;
    level.desired_enemy_deaths_this_wave = level.savedesireddeaths;
    return;
  }

  level.current_enemy_deaths = 0;
  level.max_static_spawned_enemies = scripts\cp\zombies\zombies_spawning::get_max_static_enemies(level.wave_num);
  level.desired_enemy_deaths_this_wave = scripts\cp\zombies\zombies_spawning::get_total_spawned_enemies(level.wave_num);
}

debug_beat_alien_grey_fight() {}

init_ufo_projectile_attack() {
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::activate_spaceland_powernode();
}

ufo_projectile_attack() {
  level thread scripts\cp\cp_vo::try_to_play_vo("dj_quest_ufo_destroy_nag", "zmb_dj_vo", "high", 10, 0, 3, 0);
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::start_slow_projectile_sequence(level.ufo);
  level waittill("ufo_destroyed");
}

complete_ufo_projectile_attack() {
  scripts\engine\utility::flag_set("ufo_quest_finished");
  level thread wait_drop_soul_key();
  scripts\engine\utility::flag_clear("jukebox_paused");
  enableparkpas();
}

wait_drop_soul_key() {
  level endon("game_ended");
  if(scripts\cp\maps\cp_zmb\cp_zmb_ufo::any_player_is_willard()) {
    if(scripts\engine\utility::flag_exist("pause_spawn_after_UFO_destroyed")) {
      scripts\engine\utility::flag_waitopen("pause_spawn_after_UFO_destroyed");
    }
  }

  scripts\cp\maps\cp_zmb\cp_zmb_ufo::drop_soul_key();
}

debug_beat_ufo_projectile_attack() {}

use_dj_door(var_0, var_1) {
  if(var_0.selected == 1) {
    if(level.dj.current_state == "mic_loop") {
      var_1 playlocalsound("dj_deny");
      return;
    }

    if(isDefined(level.use_dj_door_func)) {
      [[level.use_dj_door_func]](var_0, var_1);
      var_1 playlocalsound("dj_turn_in");
      return;
    }

    default_dj_interactions(var_0, var_1);
    return;
  }

  var_1 playlocalsound("dj_deny");
}

default_dj_interactions(var_0, var_1) {
  if(isDefined(level.song_skip_time) && gettime() >= level.song_skip_time || level.song_skip_time == 0) {
    level notify("skip_song");
    level.song_skip_time = gettime() + 30000;
    var_1 playlocalsound("dj_turn_in");
    var_2 = scripts\engine\utility::random(["dj_newtrack_request"]);
    playsoundatpos(level.dj.origin, var_2);
    return;
  }

  var_2 playlocalsound("dj_turn_in");
  var_2 = scripts\engine\utility::random(["dj_newtrack_cooldown"]);
  playsoundatpos(level.dj.origin, var_2);
}

disable_dj_broadcast_for_time(var_0) {
  level.disable_broadcast = 1;
  wait(var_0);
  level.disable_broadcast = undefined;
}

get_speaker_loc(var_0) {
  if(level.selected_speaker_defense_locations.size == 0) {
    select_speaker_defense_locations();
  }

  var_1 = scripts\engine\utility::random(level.selected_speaker_defense_locations);
  level.selected_speaker_defense_locations = scripts\engine\utility::array_remove(level.selected_speaker_defense_locations, var_1);
  var_1 thread playstaticsoundinarea(var_1);
  var_1 thread managespeakerlocactivation(var_1);
  var_1.wave_num_override = var_0;
  return var_1;
}

dj_arcade_purchase_hint_func(var_0, var_1) {
  return &"CP_QUEST_WOR_PART";
}

dj_speaker_mid_hint_func(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.placed)) {
    return &"CP_QUEST_WOR_USE_TONE_EQUIP";
  }

  return &"CP_QUEST_WOR_PLACE_PART";
}

dj_door_hintstring(var_0, var_1) {
  if(var_0.selected) {
    return &"CP_ZMB_INTERACTIONS_TALK_TO_DJ";
  }

  return &"CP_ZMB_INTERACTIONS_DJ_NOT_HERE";
}

init_dj_speaker() {
  var_0 = scripts\engine\utility::getStructArray("dj_quest_speaker", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = scripts\cp\cp_interaction::get_area_for_power(var_2);
    if(isDefined(var_3)) {
      var_2.area_name = var_3;
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    var_2.custom_search_dist = 128;
  }
}

playstaticsoundinarea(var_0) {
  level endon("speaker_defense_completed");
  level endon("speaker_defense_started");
  level endon("speaker_defense_failed");
  var_0 endon("death");
  for(;;) {
    if(!scripts\engine\utility::flag("dj_request_defense_done")) {
      scripts\engine\utility::flag_wait("dj_request_defense_done");
    }

    if(scripts\engine\utility::istrue(level.spawn_event_running)) {
      level waittill("regular_wave_starting");
    }

    var_1 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, undefined, 4, 96);
    foreach(var_3 in var_1) {
      var_3 setclientomnvar("ui_hud_shake", 1);
      var_3 playrumbleonentity("artillery_rumble");
    }

    playsoundatpos(var_0.origin, "tone_placement_close");
    wait(randomfloatrange(0.5, 2));
  }
}

managespeakerlocactivation(var_0) {
  var_0 notify("speaker_loc_manager");
  var_0 endon("speaker_loc_manager");
  level endon("speaker_defense_started");
  if(scripts\engine\utility::istrue(level.spawn_event_running)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  } else {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  }

  for(;;) {
    var_1 = level scripts\engine\utility::waittill_any_return("event_wave_starting", "regular_wave_starting");
    if(var_1 == "event_wave_starting") {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
      continue;
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  }
}

waitforallplayerstriggered(var_0) {
  var_0 notify("waiting_for_all_structs_used");
  var_0 endon("waiting_for_all_structs_used");
  if(!scripts\engine\utility::array_contains(level.centerstructstriggered, var_0)) {
    level.centerstructstriggered[level.centerstructstriggered.size] = var_0;
  }

  if(level.centerstructstriggered.size == level.players.size) {
    scripts\engine\utility::flag_set("all_center_positions_used");
  }

  wait(1);
  if(scripts\engine\utility::array_contains(level.centerstructstriggered, var_0)) {
    level.centerstructstriggered = scripts\engine\utility::array_remove(level.centerstructstriggered, var_0);
  }
}

disableparkpas() {
  disablepaspeaker("starting_area");
  disablepaspeaker("cosmic_way");
  disablepaspeaker("kepler");
  disablepaspeaker("triton");
  disablepaspeaker("astrocade");
  disablepaspeaker("journey");
}

enableparkpas() {
  enablepaspeaker("starting_area");
  enablepaspeaker("cosmic_way");
  enablepaspeaker("kepler");
  enablepaspeaker("triton");
  enablepaspeaker("astrocade");
  enablepaspeaker("journey");
}

speaker_defend_hint_func(var_0, var_1) {
  return level.interaction_hintstrings[var_0.script_noteworthy];
}

start_defense_sequence(var_0, var_1) {
  var_2 = var_1 can_place_speaker(var_0);
  if(!isDefined(var_2)) {
    return 0;
  }

  set_up_defense_sequence_zombie_model();
  notify_objective();
  disable_speaker_loc_interaction(var_0);
  set_defense_sequence_active_flag();
  level thread keep_park_workers_from_despawning();
  level thread scripts\cp\cp_vo::try_to_play_vo("dj_sign_off", "zmb_dj_vo", "medium", 3, 0, 0, 1);
  set_up_and_start_speaker(var_0, var_2);
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("zm_special_item", 0);
  }

  level.use_dj_door_func = ::use_dj_door_during_speaker_defense;
  level thread stopwavefromprogressing(var_0);
  thread startspeakereventspawning(var_0);
}

can_place_speaker(var_0) {
  var_1 = self canplayerplacesentry(1, 24);
  if(self isonground() && var_1["result"] && abs(var_0.origin[2] - self.origin[2]) < 24) {
    return var_1;
  }

  return undefined;
}

keep_park_workers_from_despawning() {
  level endon("speaker_defense_failed");
  level endon("speaker_defense_completed");
  while(scripts\engine\utility::flag("defense_sequence_active")) {
    level waittill("agent_spawned", var_0);
    var_0.dont_cleanup = 1;
  }
}

turn_despawn_back_on() {
  foreach(var_1 in level.spawned_enemies) {
    var_1.dont_cleanup = undefined;
  }
}

speaker_hint_func(var_0, var_1) {
  return level.interaction_hintstrings[var_0.script_noteworthy];
}

stopwavefromprogressing(var_0) {
  var_1 = level.cop_spawn_percent;
  var_2 = level.current_enemy_deaths;
  var_3 = level.max_static_spawned_enemies;
  var_4 = level.desired_enemy_deaths_this_wave;
  var_5 = level.wave_num;
  while(level.current_enemy_deaths == level.desired_enemy_deaths_this_wave) {
    wait(0.05);
  }

  level.current_enemy_deaths = 0;
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    level.max_static_spawned_enemies = 16;
  } else {
    level.max_static_spawned_enemies = 24;
  }

  level.desired_enemy_deaths_this_wave = 24;
  level.special_event = 1;
  scripts\engine\utility::flag_set("pause_wave_progression");
  var_6 = level scripts\engine\utility::waittill_any_return("speaker_defense_failed", "speaker_defense_completed");
  if(var_6 == "speaker_defense_completed") {
    level.force_drop_loot_item = "ammo_max";
  }

  var_7 = spawn("script_model", level.players[0].origin);
  var_7 setModel("tag_origin");
  var_7.team = "allies";
  level.forced_nuke = 1;
  scripts\cp\loot::process_loot_content(level.players[0], "kill_50", var_7, 0);
  level.spawndelayoverride = undefined;
  level.wave_num_override = undefined;
  level.special_event = undefined;
  turn_despawn_back_on();
  wait(2);
  if(var_6 == "speaker_defense_failed") {
    scripts\engine\utility::flag_set("force_spawn_boss");
  }

  wait(3);
  scripts\engine\utility::flag_clear("pause_wave_progression");
  if(level.wave_num == var_5) {
    level.current_enemy_deaths = var_2;
    level.max_static_spawned_enemies = var_3;
    level.desired_enemy_deaths_this_wave = var_4;
    return;
  }

  level.current_enemy_deaths = 0;
  level.max_static_spawned_enemies = scripts\cp\zombies\zombies_spawning::get_max_static_enemies(level.wave_num);
  level.desired_enemy_deaths_this_wave = scripts\cp\zombies\zombies_spawning::get_total_spawned_enemies(level.wave_num);
}

startspeakereventspawning(var_0) {
  var_1 = level.active_spawn_volumes;
  var_2 = undefined;
  var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, undefined, 4, 1000);
  foreach(var_6 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    var_6 thread adjustmovespeed(var_6);
  }

  foreach(var_9 in var_1) {
    if(ispointinvolume(var_0.origin, var_9)) {
      var_2 = var_9;
      foreach(var_11 in var_3) {
        var_11 thread sendzombietospeaker(var_11, var_2);
      }

      break;
    }
  }

  if(isDefined(var_2.spawners)) {
    var_14 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2.spawners, undefined, 100, 400);
    foreach(var_10 in var_14) {
      var_10 scripts\cp\zombies\zombies_spawning::make_spawner_inactive();
    }
  }

  foreach(var_13 in var_1) {
    if(var_13 == var_2) {
      continue;
    }

    var_13 scripts\cp\zombies\zombies_spawning::make_volume_inactive();
  }

  level scripts\engine\utility::waittill_any_return("speaker_defense_failed", "speaker_defense_completed");
  foreach(var_16 in var_1) {
    var_16 scripts\cp\zombies\zombies_spawning::make_volume_active();
  }
}

sendzombietospeaker(var_0, var_1) {
  var_2 = 250000;
  var_0 endon("death");
  level endon("speaker_defense_failed");
  level endon("speaker_defense_completed");
  while(!isDefined(level.current_speaker)) {
    wait(0.05);
  }

  var_0.scripted_mode = 1;
  var_0.precacheleaderboards = 1;
  var_0 give_mp_super_weapon(level.frequency_device_clip.origin);
  for(;;) {
    if(distance(var_0.origin, level.current_speaker.origin) < 750) {
      break;
    }

    wait(0.5);
  }

  var_0.scripted_mode = 0;
  var_0.precacheleaderboards = 0;
}

notify_objective() {
  level notify("speaker_defense_started");
}

disable_speaker_loc_interaction(var_0) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

set_defense_sequence_active_flag() {
  if(!scripts\engine\utility::flag_exist("defense_sequence_active")) {
    scripts\engine\utility::flag_init("defense_sequence_active");
  }

  scripts\engine\utility::flag_set("defense_sequence_active");
  level.defense_sequence_duration = gettime();
}

set_up_and_start_speaker(var_0, var_1) {
  var_2 = var_1["origin"];
  if(isDefined(var_0.wave_num_override)) {
    level.wave_num_override = var_0.wave_num_override;
  }

  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    level.spawndelayoverride = 0.7;
  } else {
    level.spawndelayoverride = 0.35;
  }

  var_2 = var_2 + (0, 0, 0.5);
  var_3 = spawn("script_model", var_2);
  var_3 setModel("zmb_frequency_device");
  var_3 notsolid();
  if(isDefined(var_0.angles)) {
    var_3.angles = var_0.angles;
    level.frequency_device_clip.angles = var_0.angles;
  } else {
    var_3.angles = (0, 0, 0);
    level.frequency_device_clip.angles = (0, 0, 0);
  }

  level.frequency_device_clip dontinterpolate();
  level.frequency_device_clip.origin = var_3.origin + (0, 0, 48);
  level.frequency_device_clip.special_case_ignore = 1;
  level.frequency_device_clip makeentitysentient("allies", 0);
  level.frequency_device_clip.navrepulsor = createnavrepulsor("speaker_nav_repulsor", 0, var_3.origin, 72, 1);
  var_3 thread damage_monitor(var_3, level.frequency_device_clip);
  level thread destroyspeakerifonlyoneplayer(var_3);
  var_3 thread assign_zombie_attacker_logic(var_3, level.frequency_device_clip);
  var_3 thread quest_timer(var_3, var_0);
  level.current_speaker = var_3;
  var_3.hit_point_left = 10;
  level.fake_players = scripts\engine\utility::add_to_array(level.fake_players, level.frequency_device_clip);
}

destroyspeakerifonlyoneplayer(var_0) {
  level endon("speaker_defense_completed");
  level endon("speaker_defense_failed");
  level waittill("destroy_speaker");
  level thread defense_sequence_fail(var_0);
}

adjustmovespeed(var_0, var_1) {
  var_0 endon("death");
  if(isDefined(var_0.agent_type) && var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_grey" || var_0.agent_type == "zombie_ghost") {
    return;
  }

  if(scripts\engine\utility::istrue(var_0.is_suicide_bomber)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1)) {
    wait(0.5);
  }

  var_0.synctransients = "sprint";
  var_0 scripts\asm\asm_bb::bb_requestmovetype("sprint");
}

get_speaker_icon_shader(var_0) {
  var_1 = 0;
  var_1 = var_0.hit_point_left / 10;
  setomnvar("zm_speaker_defense_health", var_1);
}

damage_monitor(var_0, var_1) {
  level endon("speaker_defense_completed");
  level endon("destroy_speaker");
  var_0 endon("death");
  var_1 setCanDamage(1);
  var_1.health = 9999999;
  var_0.nextdamagetime = 0;
  for(;;) {
    var_1 waittill("damage", var_2, var_3);
    if(isDefined(var_3) && isDefined(var_3.team) && var_3.team == "allies") {
      continue;
    }

    if(!var_3 scripts\cp\utility::is_zombie_agent()) {
      continue;
    }

    if(!isDefined(var_3.agent_type) || isDefined(var_3.agent_type) && var_3.agent_type != "zombie_brute") {
      if(!isDefined(var_3.attackent)) {
        var_3.attackent = var_1;
        var_3 thread removelockedonflagonspeakerdeath(var_3, var_0);
      }
    }

    playFX(level._effect["vfx_zb_thu_sparks"], var_0.origin + (0, 0, 32));
    var_3 notify("speaker_attacked");
    foreach(var_5 in level.players) {
      var_5 thread scripts\cp\cp_vo::try_to_play_vo("quest_ufo_defend_speakers", "zmb_comment_vo");
    }

    var_7 = gettime();
    if(var_7 >= var_0.nextdamagetime) {
      var_0.nextdamagetime = var_7 + 1000;
      var_0.hit_point_left--;
    }

    if(var_0.hit_point_left == 0) {
      break;
    }

    var_0.icon_shader = get_speaker_icon_shader(var_0);
  }

  defense_sequence_fail(var_0);
}

removelockedonflagonspeakerdeath(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_1 scripts\engine\utility::waittill_any("death", "speaker_defense_completed");
  var_0.attackent = undefined;
}

quest_timer(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_2 = spawn("script_model", var_0.origin + (0, 0, 32));
  setomnvar("zm_speaker_defense_target", var_2);
  setomnvar("zm_speaker_defense_timer", level.speaker_defense_length);
  setomnvar("zm_speaker_defense_health", 1);
  speaker_icon_timer(var_2, var_1);
  defense_sequence_success(var_0);
  exit_defense_sequence(var_0);
}

speaker_icon_timer(var_0, var_1) {
  level endon("complete_defense");
  var_0 playLoopSound("speaker_defense_tone_scrubbing");
  var_2 = level.speaker_defense_length;
  thread turn_off_timer(var_2, var_0);
  var_3 = var_2;
  while(var_3 > 0) {
    var_4 = level scripts\engine\utility::waittill_notify_or_timeout_return("debug_beat_speaker_defense", 1);
    if(isDefined(var_4) && var_4 == "timeout") {
      var_3 = var_3 - 1;
      setomnvar("zm_speaker_defense_timer", var_3);
      continue;
    }

    setomnvar("zm_speaker_defense_timer", 0);
    return;
  }
}

turn_off_timer(var_0, var_1) {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any_timeout(var_0, "complete_defense", "speaker_defense_failed");
  playsoundatpos(var_1.origin, "speaker_defense_tone_scrubbing_end");
  var_1 stoploopsound();
  setomnvar("zm_speaker_defense_timer", 0);
  setomnvar("zm_speaker_defense_health", 0);
  setomnvar("zm_speaker_defense_target", undefined);
  var_1 delete();
}

exit_defense_sequence(var_0) {
  scripts\engine\utility::flag_clear("defense_sequence_active");
  level.defense_sequence_duration = gettime() - level.defense_sequence_duration;
  scripts\cp\zombies\zombie_analytics::log_speaker_defence_sequence_ends(level.wave_num, var_0.origin, level.defense_sequence_duration, var_0.health);
  setomnvar("zm_ui_timer", 0);
  var_0 waittill("trigger", var_1);
  var_1 playlocalsound("part_pickup");
  level.use_dj_door_func = undefined;
  level.has_speaker = 1;
  level notify("speaker_picked_up");
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("zm_special_item", 3);
  }

  var_0 makeunusable();
  if(isDefined(level.frequency_device_clip.navrepulsor)) {
    destroynavrepulsor(level.frequency_device_clip.navrepulsor);
  }

  var_0 delete();
}

createstructinmiddle() {
  level.ufotones = scripts\engine\utility::array_randomize(["speaker_tone_playback_01", "speaker_tone_playback_02", "speaker_tone_playback_03", "speaker_tone_playback_04"]);
  level.djcenterstructs = [];
  level.alldjcenterstructs = [];
  var_0 = [(300, 663, 60), (660, 335, 60), (985, 665, 60), (647, 792, 116)];
  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::drop_to_ground(var_2, 32, -300) + (0, 0, 48);
    var_4 = spawnStruct("script_origin", var_3);
    var_4.origin = var_3;
    var_4.script_noteworthy = "dj_quest_speaker_mid";
    var_4.disabled = 1;
    var_4.requires_power = 0;
    var_4.powered_on = 0;
    var_4.script_parameters = "default";
    var_4.var_336 = "interaction";
    var_4.name = "center_speaker_locs";
    var_4.custom_search_dist = 96;
    level.alldjcenterstructs[level.alldjcenterstructs.size] = var_4;
    level.djcenterstructs[level.djcenterstructs.size] = var_4;
  }
}

assign_zombie_attacker_logic(var_0, var_1) {
  var_0 endon("death");
  level.num_of_active_zombie_attacker = 0;
  direct_existing_zombies_to_attack_speaker(var_1);
  for(;;) {
    level waittill("agent_spawned", var_2);
    if(isDefined(var_2.agent_type) && var_2.agent_type == "zombie_brute") {
      continue;
    }

    var_2 thread adjustmovespeed(var_2, 1);
    if(level.num_of_active_zombie_attacker < 3) {
      if(isDefined(var_2.species) && var_2.species == "zombie" && !scripts\engine\utility::istrue(var_2.active_speaker_attacker)) {
        attack_speaker(var_2, var_1);
      }
    }
  }
}

attack_speaker(var_0, var_1) {
  var_0.loadstartpointtransients = var_1;
  var_0.active_speaker_attacker = 1;
  level.num_of_active_zombie_attacker++;
  var_0 thread death_monitor(var_0, var_1);
}

attack_monitor(var_0, var_1) {
  var_1 endon("death");
  var_0 endon("death");
  var_0 waittill("speaker_attacked");
  var_0.loadstartpointtransients = scripts\engine\utility::getclosest(var_0.origin, level.players);
  var_0.active_speaker_attacker = undefined;
  level.num_of_active_zombie_attacker--;
  wait(3);
  get_new_zombie_to_attack_speaker(var_1, var_0);
}

death_monitor(var_0, var_1) {
  var_1 endon("death");
  var_0 waittill("death");
  wait(3);
  level.num_of_active_zombie_attacker--;
  get_new_zombie_to_attack_speaker(var_1);
}

direct_existing_zombies_to_attack_speaker(var_0, var_1) {
  foreach(var_3 in level.characters) {
    if(isDefined(var_1) && var_3 == var_1) {
      continue;
    }

    if(isDefined(var_3.agent_type) && var_3.agent_type == "zombie_brute") {
      continue;
    }

    if(isDefined(var_3.species) && var_3.species == "zombie" && !scripts\engine\utility::istrue(var_3.active_speaker_attacker)) {
      attack_speaker(var_3, var_0);
      if(level.num_of_active_zombie_attacker >= 3) {
        break;
      }
    }
  }
}

get_new_zombie_to_attack_speaker(var_0, var_1) {
  foreach(var_3 in level.characters) {
    if(isDefined(var_1) && var_3 == var_1) {
      continue;
    }

    if(isDefined(var_3.agent_type) && var_3.agent_type == "zombie_brute") {
      continue;
    }

    if(isDefined(var_3.species) && var_3.species == "zombie" && !scripts\engine\utility::istrue(var_3.active_speaker_attacker)) {
      attack_speaker(var_3, var_0);
      if(level.num_of_active_zombie_attacker >= 3) {
        break;
      }
    }
  }
}

clear_goal_icon_on(var_0) {
  var_0.icon_entity delete();
  foreach(var_2 in var_0.goal_head_icon) {
    if(isDefined(var_2)) {
      var_2 destroy();
      var_2 scripts\cp\zombies\zombie_afterlife_arcade::remove_from_icons_to_hide_in_afterlife(var_2.owner, var_2);
    }
  }
}

playspeakerdefencefailsound() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  self endon("play_vo_speaker_defence");
  var_0 = scripts\engine\utility::getStructArray("dj_quest_door", "script_noteworthy");
  for(;;) {
    level.dj waittill("state_changed", var_1);
    if(var_1 == "close_window") {
      wait(5);
      self playlocalsound("dj_quest_ufo_speakerdefense_fail");
      self notify("play_vo_speaker_defence");
    }

    scripts\engine\utility::waitframe();
  }
}

defense_sequence_fail(var_0) {
  scripts\engine\utility::flag_clear("dj_request_defense_done");
  level.frequency_device_clip freeentitysentient();
  level.frequency_device_clip dontinterpolate();
  level.frequency_device_clip.origin = level.frequency_device_clip.originalloc;
  foreach(var_2 in level.players) {
    var_2 thread playspeakerdefencefailsound();
    var_2 setclientomnvar("zm_special_item", 2);
  }

  level notify("speaker_defense_failed");
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::play_fail_sound();
  scripts\engine\utility::flag_clear("defense_sequence_active");
  clear_defense_sequence_zombie_model();
  setomnvar("zm_ui_timer", 0);
  if(isDefined(level.current_speaker)) {
    level.current_speaker = undefined;
  }

  var_0 makeunusable();
  if(isDefined(level.frequency_device_clip.navrepulsor)) {
    destroynavrepulsor(level.frequency_device_clip.navrepulsor);
  }

  level.use_dj_door_func = ::use_dj_door_after_fail_speaker_defense;
  level thread choose_new_dj_door();
  level.fake_players = scripts\engine\utility::array_remove(level.fake_players, level.frequency_device_clip);
  var_0 delete();
}

defense_sequence_success(var_0) {
  level.frequency_device_clip dontinterpolate();
  level.frequency_device_clip.origin = level.frequency_device_clip.originalloc;
  var_1 = scripts\engine\utility::getStructArray("dj_quest_door", "script_noteworthy");
  level.use_dj_door_func = ::use_dj_door_to_pick_up_analyzer;
  clear_defense_sequence_zombie_model();
  level.frequency_device_clip freeentitysentient();
  var_2 = &"CP_QUEST_WOR_PART";
  var_0 sethintstring(var_2);
  var_0 makeusable();
  if(isDefined(level.current_speaker)) {
    level.current_speaker = undefined;
  }

  foreach(var_4 in level.players) {
    var_4 scripts\cp\cp_persistence::give_player_xp(250, 1);
    var_0 notify("speaker_defense_completed");
    level notify("speaker_defense_completed");
  }

  level.fake_players = scripts\engine\utility::array_remove(level.fake_players, level.frequency_device_clip);
}

activateallmiddleplacementstructs() {
  foreach(var_1 in level.alldjcenterstructs) {
    var_1.disabled = undefined;
    if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_1)) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
    }
  }
}

deactivateallmiddleplacementstructs() {
  foreach(var_1 in level.alldjcenterstructs) {
    var_1.disabled = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
  }
}

activatemiddleplacementstructs() {
  foreach(var_1 in level.djcenterstructs) {
    var_1.disabled = undefined;
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  }
}

deactivatemiddleplacementstructs() {
  foreach(var_1 in level.djcenterstructs) {
    var_1.disabled = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
  }
}

waitforplayertrigger(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.placed)) {
    if(isDefined(level.spawn_event_running) && level.spawn_event_running) {
      play_tone(var_0, var_1, 0);
      return;
    }

    if(scripts\engine\utility::flag("all_structs_placed")) {
      play_tone(var_0, var_1, 1);
      return;
    }

    play_tone(var_0, var_1, 0);
    return;
  }

  place_tone_generator_on(var_0);
}

place_tone_generator_on(var_0) {
  var_0.placed = 1;
  var_1 = spawn("script_model", var_0.origin);
  var_1.origin = scripts\engine\utility::drop_to_ground(var_0.origin, 32, -400);
  var_1.angles = (270, 0, -90);
  var_1 setModel("zmb_tone_speaker");
  var_0.model = var_1;
  var_0.model setscriptablepartstate("tone", "neutral");
  var_0.tone = level.ufotones[level.djcenterstructs.size - 1];
  level.djcenterstructs = scripts\engine\utility::array_remove(level.djcenterstructs, var_0);
  playsoundatpos(var_1.origin, "sentry_gun_plant");
  if(level.djcenterstructs.size == 0) {
    scripts\engine\utility::flag_set("all_structs_placed");
    foreach(var_3 in level.players) {
      var_3 setclientomnvar("zm_special_item", 4);
    }
  }
}

play_tone(var_0, var_1, var_2) {
  playsoundatpos(var_0.origin, var_0.tone);
  var_3 = strtok(var_0.tone, "_");
  var_1 thread scripts\cp\zombies\zombies_pillage::gesture_activate("ges_devil_horns_zm", undefined, 0, 0.5);
  level notify("tone_played", var_3[3], var_0);
  if(scripts\engine\utility::istrue(var_2)) {
    level thread waitforallplayerstriggered(var_0);
  }
}

set_up_defense_sequence_zombie_model() {
  level.generic_zombie_model_override_list = ["zombie_male_park_worker", "zombie_male_park_worker_a", "zombie_male_park_worker_b", "zombie_male_park_worker_c"];
}

clear_defense_sequence_zombie_model() {
  level.generic_zombie_model_override_list = undefined;
}

blank() {}

setup_dj_booth(var_0) {
  if(!isDefined(level.dj)) {
    level scripts\engine\utility::waittill_any("power_on", "moon power_on");
    level.active_dj_spot = scripts\engine\utility::getstruct(var_0.target, "targetname");
    level.active_dj_door = scripts\engine\utility::getclosest(level.active_dj_spot.origin, getEntArray("dj_doors", "targetname"));
    level.vo_functions["zmb_dj_vo"] = ::dj_broadcast_vo_handler;
    spawn_dj();
    level thread dj_state_manager(level.dj);
    set_dj_state("open_window");
    return;
  }

  if(!isDefined(level.disable_broadcast)) {
    set_dj_state("close_window");
    level.dj waittill("window_closed");
    return;
  }

  level.active_dj_spot = scripts\engine\utility::getstruct(var_0.target, "targetname");
  level.active_dj_door = scripts\engine\utility::getclosest(level.active_dj_spot.origin, getEntArray("dj_doors", "targetname"));
  set_dj_state("open_window");
}

dj_broadcast_vo_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level.disable_broadcast)) {
    return;
  }

  if(!isDefined(level.dj.current_state)) {
    return;
  }

  while(scripts\cp\cp_vo::is_vo_system_busy() && !isDefined(level.dj_trying_to_broadcast)) {
    wait(0.1);
  }

  if(scripts\engine\utility::istrue(var_4)) {
    level.dj notify("end_dj_broadcast_handler");
    level.dj_trying_to_broadcast = undefined;
    foreach(var_8 in level.players) {
      var_8 scripts\cp\cp_vo::set_vo_system_playing(0);
      var_8.vo_system_playing_vo = 0;
    }

    level get_dj_into_idle();
  }

  if(isDefined(level.dj_trying_to_broadcast)) {
    return;
  }

  level.dj endon("end_dj_broadcast_handler");
  level.dj_trying_to_broadcast = 1;
  scripts\cp\cp_vo::set_vo_system_busy(1);
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  level.dj thread endon_different_state_changed("approach_mic");
  level.dj thread dj_endon_timeout(30);
  level.dj set_dj_state("approach_mic");
  play_dj_broadcast_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  level.dj_trying_to_broadcast = undefined;
  scripts\cp\cp_vo::set_vo_system_busy(0);
  foreach(var_8 in level.players) {
    var_8 scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  set_dj_state("exit_mic");
  level.dj notify("finished_dj_broadcast");
  level.dj_broadcasting = undefined;
}

play_dj_broadcast_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.dj endon("end_dj_broadcast_early");
  if(level.dj.current_state != "at_mic") {
    level.dj waittill("at_mic");
  }

  level.dj_broadcasting = 1;
  var_7 = scripts\cp\cp_vo::create_vo_data(var_0, var_3, var_5, var_6);
  foreach(var_9 in level.players) {
    if(!isDefined(var_9)) {
      continue;
    }

    if(var_9 issplitscreenplayer() && !var_9 issplitscreenplayerprimary()) {
      continue;
    }

    var_9 thread scripts\cp\cp_vo::play_vo_system(var_7);
  }

  level.played_dj_vos[var_0] = 1;
  wait(scripts\cp\cp_vo::get_sound_length(var_0));
}

get_dj_into_idle() {
  level.dj endon("end_dj_broadcast_handler");
  switch (level.dj.current_state) {
    case "open_window":
      set_dj_state("idle");
      break;

    case "approach_mic":
      while(level.dj.current_state != "mic_loop") {
        wait(0.1);
      }

      break;

    case "mic_loop":
      set_dj_state("exit_mic");
      break;

    case "exit_mic":
      break;
  }

  while(level.dj.current_state != "idle") {
    wait(0.1);
  }
}

endon_different_state_changed(var_0) {
  level.dj endon("finished_dj_broadcast");
  level.dj waittill("state_changed", var_1);
  if(var_0 != var_1) {
    level.dj notify("end_dj_broadcast_early");
  }
}

dj_endon_timeout(var_0) {
  level.dj endon("finished_dj_broadcast");
  level.dj endon("at_mic");
  wait(var_0);
  level.dj notify("end_dj_broadcast_early");
}

spawn_dj() {
  level.dj = spawn("script_model", level.active_dj_spot.origin);
  level.dj.angles = level.active_dj_spot.angles;
  level.dj setModel("fullbody_zmb_hero_dj");
  level.dj_states = [];
  level.dj_states["open_window"] = ::dj_open_window;
  level.dj_states["close_window"] = ::dj_close_window;
  level.dj_states["idle"] = ::dj_idle;
  level.dj_states["vo"] = ::dj_say_vo;
  level.dj_states["approach_mic"] = ::dj_approach_mic;
  level.dj_states["exit_mic"] = ::dj_exit_mic;
  level.dj_states["mic_loop"] = ::dj_mic_loop;
}

dj_state_manager(var_0) {
  level endon("stop_dj_manager");
  for(;;) {
    if(!isDefined(level.dj.desired_state)) {
      wait(0.05);
    }

    level.dj notify("state_changed", level.dj.desired_state);
    switch (level.dj.desired_state) {
      case "open_window":
        [[level.dj_states["open_window"]]]();
        set_dj_state("idle");
        break;

      case "dance":
      case "exit_mic":
      case "mic_loop":
      case "close_window":
      case "approach_mic":
      case "idle":
        [[level.dj_states[level.dj.desired_state]]]();
        break;
    }

    wait(0.05);
  }
}

set_dj_state(var_0) {
  level.dj.desired_state = var_0;
}

dj_interrupt_test() {
  var_0 = 1;
  for(;;) {
    level thread scripts\cp\cp_vo::try_to_play_vo("dj_fateandfort_replenish_nag", "zmb_dj_vo", "high", 20, 1, 0, 1);
    wait(2);
  }
}

dj_open_window() {
  level.dj.current_state = "open_window";
  turn_on_sign();
  var_0 = getanimlength(%iw7_cp_zom_hoff_dj_window_open);
  level.dj scriptmodelplayanimdeltamotionfrompos("IW7_cp_zom_hoff_dj_window_open", level.active_dj_spot.origin, level.active_dj_spot.angles);
  level.active_dj_door movez(29, 0.75);
  wait(var_0 - 0.15);
}

dj_close_window() {
  level.dj.current_state = "close_window";
  turn_off_sign();
  var_0 = getanimlength(%iw7_cp_zom_hoff_dj_window_close);
  level.dj scriptmodelplayanimdeltamotionfrompos("IW7_cp_zom_hoff_dj_window_close", level.active_dj_spot.origin, level.active_dj_spot.angles);
  wait(2.25);
  level.active_dj_door movez(-29, 0.75);
  wait(var_0);
  level.dj notify("window_closed");
}

dj_idle() {
  level.dj.current_state = "idle";
  var_0 = scripts\engine\utility::random([%iw7_cp_zom_hoff_dj_desk_01, %iw7_cp_zom_hoff_dj_desk_02, %iw7_cp_zom_hoff_dj_desk_03, %iw7_cp_zom_hoff_dj_desk_04, %iw7_cp_zom_hoff_dj_desk_05, %iw7_cp_zom_hoff_dj_desk_06]);
  var_1 = % iw7_cp_zom_hoff_dj_idle_01;
  var_2 = var_1;
  if(randomint(100) > 80) {
    var_2 = var_0;
  }

  var_3 = getanimlength(var_2);
  level.dj scriptmodelplayanimdeltamotionfrompos(var_2, level.active_dj_spot.origin, level.active_dj_spot.angles);
  wait(var_3 - 0.1);
}

dj_approach_mic() {
  level.dj.current_state = "approach_mic";
  var_0 = getanimlength(%iw7_cp_zom_hoff_dj_vo_06_enter);
  level.dj scriptmodelplayanimdeltamotionfrompos("IW7_cp_zom_hoff_dj_vo_06_enter", level.active_dj_spot.origin, level.active_dj_spot.angles);
  wait(var_0);
  level.dj notify("at_mic");
  set_dj_state("mic_loop");
}

dj_exit_mic() {
  level.dj.current_state = "exit_mic";
  var_0 = getanimlength(%iw7_cp_zom_hoff_dj_vo_06_exit);
  level.dj scriptmodelplayanimdeltamotionfrompos("IW7_cp_zom_hoff_dj_vo_06_exit", level.active_dj_spot.origin, level.active_dj_spot.angles);
  wait(var_0);
  set_dj_state("idle");
}

dj_mic_loop() {
  level.dj.current_state = "mic_loop";
  var_0 = [%iw7_cp_zom_hoff_dj_vo_06, %iw7_cp_zom_hoff_dj_vo_05, %iw7_cp_zom_hoff_dj_vo_04, %iw7_cp_zom_hoff_dj_vo_03, %iw7_cp_zom_hoff_dj_vo_02, %iw7_cp_zom_hoff_dj_vo_01];
  var_1 = ["IW7_cp_zom_hoff_dj_vo_05", "IW7_cp_zom_hoff_dj_vo_04", "IW7_cp_zom_hoff_dj_vo_03", "IW7_cp_zom_hoff_dj_vo_02", "IW7_cp_zom_hoff_dj_vo_01", "IW7_cp_zom_hoff_dj_vo_06"];
  var_2 = scripts\engine\utility::random(var_1);
  var_3 = undefined;
  switch (var_2) {
    case "IW7_cp_zom_hoff_dj_vo_06":
      var_3 = % iw7_cp_zom_hoff_dj_vo_06;
      break;

    case "IW7_cp_zom_hoff_dj_vo_05":
      var_3 = % iw7_cp_zom_hoff_dj_vo_05;
      break;

    case "IW7_cp_zom_hoff_dj_vo_04":
      var_3 = % iw7_cp_zom_hoff_dj_vo_04;
      break;

    case "IW7_cp_zom_hoff_dj_vo_03":
      var_3 = % iw7_cp_zom_hoff_dj_vo_03;
      break;

    case "IW7_cp_zom_hoff_dj_vo_02":
      var_3 = % iw7_cp_zom_hoff_dj_vo_02;
      break;

    case "IW7_cp_zom_hoff_dj_vo_01":
      var_3 = % iw7_cp_zom_hoff_dj_vo_01;
      break;
  }

  var_4 = getanimlength(var_3);
  level.dj scriptmodelplayanimdeltamotionfrompos(var_2, level.active_dj_spot.origin, level.active_dj_spot.angles);
  wait(var_4);
}

dj_say_vo() {}

turn_on_sign(var_0) {
  var_1 = scripts\engine\utility::getclosest(level.active_dj_door.origin, getEntArray("cosmic_tunes", "targetname"));
  var_1 setscriptablepartstate("sign", "on");
}

turn_off_sign(var_0) {
  var_1 = scripts\engine\utility::getclosest(level.active_dj_door.origin, getEntArray("cosmic_tunes", "targetname"));
  var_1 setscriptablepartstate("sign", "off");
}