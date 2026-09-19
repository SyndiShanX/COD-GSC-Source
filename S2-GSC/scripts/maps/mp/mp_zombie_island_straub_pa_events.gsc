/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_straub_pa_events.gsc
*****************************************************************/

play_straub_story_5() {
  play_a_straub_story(::play_straub_dialog_on_ships_continued_1, "wave_break", "flag_destroyers_quest_complete");
}

play_straub_story_6() {
  play_a_straub_story(::play_straub_dialog_on_ships_continued_2, "wave_break", "flag_destroyers_quest_complete");
}

play_straub_story_7() {
  play_a_straub_story(::play_straub_dialog_on_ships_continued_3, "wave_break", "flag_destroyers_quest_complete");
}

play_straub_dialog_on_radio_transmission_recieved(var_0) {}

play_straub_dialog_on_ships_spawned(var_0) {
  if(common_scripts\utility::_id_3C77(var_0))
    return;
}

play_straub_dialog_on_ships_continued_1(var_0) {
  if(common_scripts\utility::_id_3C77(var_0)) {
    return;
  }
  pa_system_dialogue_all_players("zmb_isla_stra_youhavenoideawhatyouareup");
}

play_straub_dialog_on_ships_continued_2(var_0) {
  if(common_scripts\utility::_id_3C77(var_0)) {
    return;
  }
  pa_system_dialogue_all_players("zmb_isla_stra_ilearnedfrommittelburgmyu");
}

play_straub_dialog_on_ships_continued_3(var_0) {
  if(common_scripts\utility::_id_3C77(var_0)) {
    return;
  }
  pa_system_dialogue_all_players("zmb_isla_stra_ivebeenstoringmychildrenh");
}

init() {}

play_a_straub_story(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 common_scripts\utility::_id_3799("wait_on_story");
  var_3 common_scripts\utility::_id_3799("players_can_talk_again");
  var_3._id_3F02 = var_0;
  var_3.optionalstopper = var_2;

  if(!isDefined(level.zmb_island_staub_stories_queue))
    level.zmb_island_staub_stories_queue = [var_3];
  else
    level.zmb_island_staub_stories_queue = common_scripts\utility::_id_0F6F(level.zmb_island_staub_stories_queue, var_3);
}

play_next_straub_story() {
  if(isDefined(level.zmb_island_staub_stories_queue) && level.zmb_island_staub_stories_queue.size > 0) {
    if(!maps\mp\zombies\_zombies_audio_dlc1::should_play_a_wave_story(1)) {
      return;
    }
    var_0 = level.zmb_island_staub_stories_queue[0];
    level childthread play_straub_story_internal(var_0);
    var_0 common_scripts\utility::_id_379C("wait_on_story");
  }
}

set_all_players_dont_speak(var_0) {
  level notify("new_story_started");
  level endon("new_story_started");
  set_players_can_talk(0);
  common_scripts\utility::_id_379C("players_can_talk_again");
  set_players_can_talk(1);
}

set_players_can_talk(var_0) {
  foreach(var_2 in level.players)
  var_2._id_324E = !var_0;
}

play_straub_story_internal(var_0) {
  level.zmb_island_staub_stories_queue = common_scripts\utility::_id_0F93(level.zmb_island_staub_stories_queue, var_0);
  level.wavestories.story_playing = 1;
  var_0 thread set_all_players_dont_speak();
  [[var_0._id_3F02]](var_0.optionalstopper);
  var_0 common_scripts\utility::_id_379A("players_can_talk_again");
  var_0 common_scripts\utility::_id_379A("wait_on_story");
  level.wavestories.story_playing = 0;
}

endon_in_seconds(var_0) {
  wait(var_0);
  common_scripts\utility::_id_379A("wait_on_story");
}

pa_system_dialogue_setup() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.pa_player_speaker_1)) {
      continue;
    }
    var_1.pa_player_speaker_1 = spawn("script_model", var_1.origin);
    var_1.pa_player_speaker_1 setModel("tag_origin");
    var_1.pa_player_speaker_2 = spawn("script_model", var_1.origin);
    var_1.pa_player_speaker_2 setModel("tag_origin");
    var_1 thread pa_system_dialogue_cleanup();
  }
}

pa_system_dialogue_cleanup() {
  var_0 = self;
  var_0 common_scripts\utility::_id_A732("pa_system_cleanup", "disconnect");

  if(isDefined(var_0.pa_player_speaker_1)) {
    var_0.pa_player_speaker_1 delete();
    var_0.pa_player_speaker_1 = undefined;
  }

  if(isDefined(var_0.pa_player_speaker_2)) {
    var_0.pa_player_speaker_2 delete();
    var_0.pa_player_speaker_2 = undefined;
  }
}

pa_system_dialogue_all_players(var_0, var_1) {
  if(!_func_344(var_0)) {
    return;
  }
  pa_system_dialogue_setup();

  for(var_2 = 0; var_2 < level.players.size - 1; var_2++)
    level.players[var_2] thread pa_system_dialogue(var_0, "exterior", var_1);

  level.players[level.players.size - 1] pa_system_dialogue(var_0, "exterior", var_1);
}

pa_system_dialogue(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("disconnect");
  var_3 endon("death");
  var_4 = 0.3;
  var_5 = 1;

  if(isDefined(var_2))
    var_5 = var_2;

  var_6 = common_scripts\utility::_id_46B7("struct_island_loudspeaker", "targetname");
  var_3 childthread pa_system_player_track(var_6);
  waitframe();
  var_7 = var_0;
  var_8 = var_0 + "_echo";
  var_9 = var_0 + "_delay";
  _id_0380::_id_6850(var_3._id_071D.pa_vo_on_player, 0.25);
  var_3._id_071D.pa_vo_on_player = undefined;

  if(isDefined(var_7))
    var_3._id_071D.pa_vo_on_player = _id_0380::_id_6844(var_7, var_3, var_3, 0, 1.0);

  _id_0380::_id_6850(var_3._id_071D._id_6DD9, 0.25);
  var_3._id_071D._id_6DD9 = undefined;

  if(isDefined(var_8))
    var_3._id_071D._id_6DD9 = _id_0380::_id_6840(var_8, var_3, 0, 0.25);

  _id_0380::_id_6850(var_3.pa_player_speaker_1.pa_speaker_1_snd, 0.25);
  var_3.pa_player_speaker_1.pa_speaker_1_snd = _id_0380::_id_6844(var_9, var_3, var_3.pa_player_speaker_1, 0, 0.5);

  if(isDefined(var_3.pa_player_speaker_1.pa_speaker_1_snd))
    var_3.pa_player_speaker_1.pa_speaker_1_snd waittill("death");
  else
    waitframe();

  if(common_scripts\utility::_id_562E(var_5))
    var_3 notify("pa_system_cleanup");
}

pa_system_player_track(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1.pa_player_speaker_1 endon("pa_system_line_done");

  for(;;) {
    var_2 = _func_1AC(var_0, var_1.origin);

    if(isDefined(var_1.pa_player_speaker_1))
      var_1.pa_player_speaker_1.origin = var_2[0].origin;

    if(isDefined(var_1.pa_player_speaker_2))
      var_1.pa_player_speaker_2.origin = var_2[1].origin;

    wait 0.5;
  }
}

ambient_straub_pa_dialog_cleanup() {
  common_scripts\utility::_id_3C9F("flag_destroyers_quest_complete");

  foreach(var_1 in level.players) {
    if(isDefined(var_1.pa_speaker_1_snd))
      var_1 notify("pa_system_cleanup");
  }
}