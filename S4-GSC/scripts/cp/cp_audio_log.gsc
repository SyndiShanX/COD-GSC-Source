/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\cp_audio_log.gsc
*************************************************/

_id_C1EF() {
  set_interactions_not_drop_to_ground_when_init("zm_audio_log");
  _id_0737::_id_C266("zm_audio_log", ::get_audio_log_hint_func, ::interaction_play_audio_log, ::audio_log_init);
  _id_0737::addinteractionhinttypecallback("zm_audio_log", ::get_audio_log_hint_type);
  var_0 = tablelookupgetnumrows("cp/cp_audio_log_events.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = spawnStruct();
    var_2._id_144B = [];
    var_3 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 0);
    var_2.audio_type = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 1);

    if(scripts\engine\utility::is_equal(level.mapname, "cp_zod")) {
      var_2.season_to_play = 1;
      var_4 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 2);
      var_5 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 3);
      var_6 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 4);
      var_2._id_144B[0] = get_alias_list(var_4, var_5, var_6, 0);
      var_4 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 5);
      var_5 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 6);
      var_6 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 7);
      var_2._id_144B[1] = get_alias_list(var_4, var_5, var_6, 0);
    } else if(scripts\engine\utility::is_equal(level.mapname, "cp_zm_skorpion")) {
      var_2.season_to_play = 2;
      var_4 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 8);
      var_5 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 9);
      var_6 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 10);
      var_2._id_144B[2] = get_alias_list(var_4, var_5, var_6, 1);
    } else if(scripts\engine\utility::is_equal(level.mapname, "cp_sumpf")) {
      var_2.season_to_play = 3;
      var_4 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 11);
      var_5 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 12);
      var_6 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 13);
      var_2._id_144B[3] = get_alias_list(var_4, var_5, var_6, 1);
    } else if(scripts\engine\utility::is_equal(level.mapname, "cp_zm_oasis")) {
      var_2.season_to_play = 4;
      var_4 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 14);
      var_5 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 15);
      var_6 = tablelookupbyrow("cp/cp_audio_log_events.csv", var_1, 16);
      var_2._id_144B[4] = get_alias_list(var_4, var_5, var_6, 1);
    }

    level.audio_logs[var_3] = var_2;
  }
}

get_alias_list(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(isDefined(var_0) && var_0 != "" && isDefined(var_1) && var_1 != "") {
    var_1 = int(var_1);

    for(var_5 = var_3; var_5 < var_1 + var_3; var_5++) {
      var_6 = var_0;

      if(var_5 < 10) {
        var_6 = var_6 + "0";
      }

      var_6 = var_6 + scripts\engine\utility::_id_EA52(var_5);
      var_4 = scripts\engine\utility::array_add(var_4, var_6);
    }
  } else if(isDefined(var_2) && var_2 != "")
    var_4 = strtok(var_2, ";");

  return var_4;
}

audio_log_init(var_0) {
  foreach(var_2 in var_0) {
    var_2._id_722E = "locOverride";
  }
}

get_audio_log_hint_type(var_0, var_1) {
  if(istrue(level.playing_audio_log)) {
    return "HINT_NOBUTTON";
  } else {
    return "HINT_NOICON";
  }
}

get_audio_log_hint_func(var_0, var_1) {
  if(istrue(level.playing_audio_log)) {
    return "";
  } else {
    return &"CP_ZMB_INTERACTIONS/AUDIO_LOG_HINT";
  }
}

interaction_play_audio_log(var_0, var_1) {
  self endon("players_dead");
  self endon("game_ended");
  level endon("objective_ended");
  level endon("portal_activated");

  if(istrue(level.playing_audio_log)) {
    return;
  }
  var_2 = level.audio_logs[var_0._id_CE18];
  var_3 = var_0._id_EEE8[0];
  thread watch_audio_log_cutoff(var_2, var_3);
  level.playing_audio_log = 1;

  switch (var_2.audio_type) {
    case "aether":
      var_3 playSound("zmb_audiolog_aether_start");
      var_3 playLoopSound("zmb_audiolog_aether_lp");
      break;
    case "radio":
      var_3 playSound("zmb_audiolog_radio_start");
      var_3 playLoopSound("zmb_audiolog_radio_lp");
      break;
  }

  foreach(var_5 in var_2._id_144B[var_2.season_to_play]) {
    var_3 playSound(var_5);
    wait(_id_0720::get_dialogue_length(var_5));
  }

  level notify("audio_log_finished");
}

watch_audio_log_cutoff(var_0, var_1) {
  self endon("players_dead");
  self endon("game_ended");
  level scripts\engine\utility::waittill_any_3("objective_ended", "portal_activated", "audio_log_finished");
  cleanup_audio_log(var_0, var_1);
}

cleanup_audio_log(var_0, var_1) {
  switch (var_0.audio_type) {
    case "aether":
      var_1 stoploopsound("zmb_audiolog_aether_lp");
      var_1 playSound("zmb_audiolog_aether_stop");
      break;
    case "radio":
      var_1 stoploopsound("zmb_audiolog_radio_lp");
      var_1 playSound("zmb_audiolog_radio_stop");
      break;
  }

  level notify("audio_log_finished");

  if(scripts\engine\utility::is_equal(level.mapname, "cp_zod")) {
    var_0.season_to_play--;

    if(var_0.season_to_play < 0) {
      var_0.season_to_play = 1;
    }
  }

  level.playing_audio_log = 0;
}

set_interactions_not_drop_to_ground_when_init(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    var_3._id_722E = "locOverride";
  }
}