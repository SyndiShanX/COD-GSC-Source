/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_straub_pa_events.gsc
*********************************************************/

play_straub_story_5() {
  play_a_straub_story(::play_straub_dialog_on_ships_continued_1, "wave_break", "flag_destroyers_quest_complete");
}

play_straub_story_6() {
  play_a_straub_story(::play_straub_dialog_on_ships_continued_2, "wave_break", "flag_destroyers_quest_complete");
}

play_straub_story_7() {
  play_a_straub_story(::play_straub_dialog_on_ships_continued_3, "wave_break", "flag_destroyers_quest_complete");
}

play_straub_dialog_on_radio_transmission_recieved(param_00) {}

play_straub_dialog_on_ships_spawned(param_00) {
  if(common_scripts\utility::func_3C77(param_00)) {}
}

play_straub_dialog_on_ships_continued_1(param_00) {
  if(common_scripts\utility::func_3C77(param_00)) {
    return;
  }

  pa_system_dialogue_all_players("zmb_isla_stra_youhavenoideawhatyouareup");
}

play_straub_dialog_on_ships_continued_2(param_00) {
  if(common_scripts\utility::func_3C77(param_00)) {
    return;
  }

  pa_system_dialogue_all_players("zmb_isla_stra_ilearnedfrommittelburgmyu");
}

play_straub_dialog_on_ships_continued_3(param_00) {
  if(common_scripts\utility::func_3C77(param_00)) {
    return;
  }

  pa_system_dialogue_all_players("zmb_isla_stra_ivebeenstoringmychildrenh");
}

init() {}

play_a_straub_story(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03 common_scripts\utility::func_3799("wait_on_story");
  var_03 common_scripts\utility::func_3799("players_can_talk_again");
  var_03.var_3F02 = param_00;
  var_03.optionalstopper = param_02;
  if(!isDefined(level.zmb_island_staub_stories_queue)) {
    level.zmb_island_staub_stories_queue = [var_03];
    return;
  }

  level.zmb_island_staub_stories_queue = common_scripts\utility::func_F6F(level.zmb_island_staub_stories_queue, var_03);
}

play_next_straub_story() {
  if(isDefined(level.zmb_island_staub_stories_queue) && level.zmb_island_staub_stories_queue.size > 0) {
    if(!maps / mp / zombies / _zombies_audio_dlc1::should_play_a_wave_story(1)) {
      return;
    }

    var_00 = level.zmb_island_staub_stories_queue[0];
    level childthread play_straub_story_internal(var_00);
    var_00 common_scripts\utility::func_379C("wait_on_story");
  }
}

set_all_players_dont_speak(param_00) {
  level notify("new_story_started");
  level endon("new_story_started");
  set_players_can_talk(0);
  common_scripts\utility::func_379C("players_can_talk_again");
  set_players_can_talk(1);
}

set_players_can_talk(param_00) {
  foreach(var_02 in level.players) {
    var_02.var_324E = !param_00;
  }
}

play_straub_story_internal(param_00) {
  level.zmb_island_staub_stories_queue = common_scripts\utility::func_F93(level.zmb_island_staub_stories_queue, param_00);
  level.wavestories.story_playing = 1;
  param_00 thread set_all_players_dont_speak();
  [[param_00.var_3F02]](param_00.optionalstopper);
  param_00 common_scripts\utility::func_379A("players_can_talk_again");
  param_00 common_scripts\utility::func_379A("wait_on_story");
  level.wavestories.story_playing = 0;
}

endon_in_seconds(param_00) {
  wait(param_00);
  common_scripts\utility::func_379A("wait_on_story");
}

pa_system_dialogue_setup() {
  foreach(var_01 in level.players) {
    if(isDefined(var_01.pa_player_speaker_1)) {
      continue;
    }

    var_01.pa_player_speaker_1 = spawn("script_model", var_01.origin);
    var_01.pa_player_speaker_1 setModel("tag_origin");
    var_01.pa_player_speaker_2 = spawn("script_model", var_01.origin);
    var_01.pa_player_speaker_2 setModel("tag_origin");
    var_01 thread pa_system_dialogue_cleanup();
  }
}

pa_system_dialogue_cleanup() {
  var_00 = self;
  var_00 common_scripts\utility::func_A732("pa_system_cleanup", "disconnect");
  if(isDefined(var_00.pa_player_speaker_1)) {
    var_00.pa_player_speaker_1 delete();
    var_00.pa_player_speaker_1 = undefined;
  }

  if(isDefined(var_00.pa_player_speaker_2)) {
    var_00.pa_player_speaker_2 delete();
    var_00.pa_player_speaker_2 = undefined;
  }
}

pa_system_dialogue_all_players(param_00, param_01) {
  if(!function_0344(param_00)) {
    return;
  }

  pa_system_dialogue_setup();
  for(var_02 = 0; var_02 < level.players.size - 1; var_02++) {
    level.players[var_02] thread pa_system_dialogue(param_00, "exterior", param_01);
  }

  level.players[level.players.size - 1] pa_system_dialogue(param_00, "exterior", param_01);
}

pa_system_dialogue(param_00, param_01, param_02) {
  var_03 = self;
  var_03 endon("disconnect");
  var_03 endon("death");
  var_04 = 0.3;
  var_05 = 1;
  if(isDefined(param_02)) {
    var_05 = param_02;
  }

  var_06 = common_scripts\utility::func_46B7("struct_island_loudspeaker", "targetname");
  var_03 childthread pa_system_player_track(var_06);
  wait 0.05;
  var_07 = param_00;
  var_08 = param_00 + "_echo";
  var_09 = param_00 + "_delay";
  lib_0380::func_6850(var_03.var_71D.pa_vo_on_player, 0.25);
  var_03.var_71D.pa_vo_on_player = undefined;
  if(isDefined(var_07)) {
    var_03.var_71D.pa_vo_on_player = lib_0380::func_6844(var_07, var_03, var_03, 0, 1);
  }

  lib_0380::func_6850(var_03.var_71D.var_6DD9, 0.25);
  var_03.var_71D.var_6DD9 = undefined;
  if(isDefined(var_08)) {
    var_03.var_71D.var_6DD9 = lib_0380::func_6840(var_08, var_03, 0, 0.25);
  }

  lib_0380::func_6850(var_03.pa_player_speaker_1.pa_speaker_1_snd, 0.25);
  var_03.pa_player_speaker_1.pa_speaker_1_snd = lib_0380::func_6844(var_09, var_03, var_03.pa_player_speaker_1, 0, 0.5);
  if(isDefined(var_03.pa_player_speaker_1.pa_speaker_1_snd)) {
    var_03.pa_player_speaker_1.pa_speaker_1_snd waittill("death");
  } else {
    wait 0.05;
  }

  if(common_scripts\utility::func_562E(var_05)) {
    var_03 notify("pa_system_cleanup");
  }
}

pa_system_player_track(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_01.pa_player_speaker_1 endon("pa_system_line_done");
  for(;;) {
    var_02 = function_01AC(param_00, var_01.origin);
    if(isDefined(var_01.pa_player_speaker_1)) {
      var_01.pa_player_speaker_1.origin = var_02[0].origin;
    }

    if(isDefined(var_01.pa_player_speaker_2)) {
      var_01.pa_player_speaker_2.origin = var_02[1].origin;
    }

    wait(0.5);
  }
}

ambient_straub_pa_dialog_cleanup() {
  common_scripts\utility::func_3C9F("flag_destroyers_quest_complete");
  foreach(var_01 in level.players) {
    if(isDefined(var_01.pa_speaker_1_snd)) {
      var_01 notify("pa_system_cleanup");
    }
  }
}