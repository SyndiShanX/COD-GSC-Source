/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_audio_dlc2.gsc
***************************************************/

initdlc2audio() {
  level._zmbvoxlevelspecific = ::initleveldialog;
  level.zmbsoundlengthpath = "mp/sound/soundlength_zm_mp_dlc2.csv";
  level.zmbaudiowave1vo = ::zmbaudiowave1vo;
  level.zmbaudiowavestartvo = ::zmbaudiowavestartvo;
  level.zmbwaveintermissionvo = ::zmbwaveintermissionvo;
  level._audio_custom_response_line = ::zmbcustomresponseline;
  level.zmaudiocustomtrapvo = ::zmaudiocustomtrapvo;
  level thread zoneopenedvo();
  level thread zmbaudiomidroundwavelogic();
  level thread zmbspotzombiesvo();
  level thread zmbaudioacidpoolvo();
}

initleveldialog() {
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "wave1", "dlc2_gameopen", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "wave1b", "dlc2_gameopenb", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "pilot_conv", "wave1_int", "wave1_int", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "pilot_conv", "wave2_int", "wave2_int", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "pilot_conv", "wave3_int", "wave3_int", "global_priority,wave3b_int");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "pilot_conv", "wave3b_int", "wave3b_int", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "pilot_conv", "wave5_int", "wave5_int", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "pilot_conv", "wave5b_int", "wave5b_int", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "to_burgertown", "burgertown", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "to_sewers", "sewers", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "to_voltage", "voltage", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "to_atlas", "atlasfac", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "trap_snipers", "dlc2_sniper", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "trap_gators", "dlc2_gator", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "trap_airstrike", "dlc2_ostrike", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "trap_electric_floor", "dlc2_ftrap", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "trap_ambulance", "dlc2_ambulance", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "toxic_zone", "dlc2_gastrap", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_first_acid", "acid_spot_first", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_acid", "acid_spot", undefined, 10);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_first_spiked", "dlc2_spike1st", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_spiked", "dlc2_spikespot", undefined, 10);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_first_goliath", "goliath_spot_first", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_goliath", "goliath_spot", undefined, 40);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "goliath_shoot", "goliath_shoot", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "acid_pool", "acid_encounter", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_win_first", "success", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_fail_first", "1stfail", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_prewave", "rescue_prewave1", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_prewave_tense", "rescue_pretensewave", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_wave", "rescue_wave", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_wave_tense", "rescue_tensewave", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_win", "rescue_win", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_win_tense", "rescue_tense_win", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_fail", "rescue_fail", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_fail_tense", "rescue_tense_fail", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_remind", "remind_wave", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "rescue_remind_tense", "rescue_tense_remind", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "survivor_callout", "survivor_callout", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "survivor_response", "survivor_response", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "survivor_instruct", "survivor_instruct", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "civilian", "survivor_exit", "survivor_exit", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "kill", "microwave", "dlc2_microgun_kill", undefined, 75);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "kill", "goliath_kill", "goliath_kill", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "kill", "acid_kill", "acid_kill", undefined, 25);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "kill", "acid_pool", "acid_encounter", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "weapon_pickup", "iw5_microwavezm_mp", "dlc2_microgun", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_1", "it_exec_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_2", "it_exec_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_3", "it_exec_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_4", "it_exec_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_5", "it_exec_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_6", "it_exec_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_7", "it_exec_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_8", "it_exec_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_exec_9", "it_exec_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_10", "it_exec_wave_intermission_ctx10", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_guard_1", "guard_exec_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_2", "guard_exec_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_3", "guard_exec_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_guard_4", "guard_exec_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_guard_5", "guard_exec_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_6", "guard_exec_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_7", "guard_exec_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_guard_8", "guard_exec_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_guard_9", "guard_exec_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_guard_10", "guard_exec_wave_intermission_ctx10", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_1", "janitor_exec_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_2", "janitor_exec_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_3", "janitor_exec_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_4", "janitor_exec_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_exec_5", "janitor_exec_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_6", "janitor_exec_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_7", "janitor_exec_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_8", "janitor_exec_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_9", "janitor_exec_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_10", "janitor_exec_wave_intermission_ctx10", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_1", "it_guard_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_2", "it_guard_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_guard_3", "it_guard_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_4", "it_guard_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_5", "it_guard_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_6", "it_guard_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_7", "it_guard_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_8", "it_guard_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_9", "it_guard_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_10", "it_guard_wave_intermission_ctx10", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_1", "it_janitor_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_2", "it_janitor_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_3", "it_janitor_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_4", "it_janitor_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_5", "it_janitor_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_6", "it_janitor_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_7", "it_janitor_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_8", "it_janitor_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_it_9", "it_janitor_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_it_10", "it_janitor_wave_intermission_ctx10", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_1", "guard_janitor_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_2", "guard_janitor_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_3", "guard_janitor_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_4", "guard_janitor_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_5", "guard_janitor_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_6", "guard_janitor_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_guard_7", "guard_janitor_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_8", "guard_janitor_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_9", "guard_janitor_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_10", "guard_janitor_wave_intermission_ctx10", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "gas_warning", "trap", undefined);
  var_0 = spawn("script_model", (0, 0, 0));
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_pilot", "pilot_", var_0, 0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "wave1_int", "wave1_int", "pilot_conv,wave1_int");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "wave3_int", "wave3_int", "pilot_conv,wave3_int");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "wave3b_int", "wave3b_int", "pilot_conv,wave3b_int");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "wave5_int", "wave5_int", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "wave5b_int", "wave5b_int", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_win_first", "success", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_fail_first", "1stfail", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_prewave", "rescue_prewave1", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_prewave_tense", "rescue_pretensewave", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_wave", "rescue_wave", "civilian,rescue_wave");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_wave_tense", "rescue_tensewave", "civilian,rescue_wave_tense");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_win", "rescue_win", "civilian,rescue_win");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_win_tense", "rescue_tense_win", "civilian,rescue_win_tense");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_fail", "rescue_fail", "civilian,rescue_fail");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_fail_tense", "rescue_tense_fail", "civilian,rescue_fail_tense");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_remind", "remind_wave", "civilian,rescue_remind");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot", "global_priority", "rescue_remind_tense", "rescue_tense_remind", "civilian,rescue_remind_tense");
  var_1 = spawn("script_model", (0, 0, 0));
  level.survivorvoent = var_1;
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("survivor1", "survivor_", var_1, 0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("survivor2", "survivor02_", var_1, 0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("survivor3", "survivor03_", var_1, 0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor1", "general", "callout", "callout", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor2", "general", "callout", "callout", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor3", "general", "callout", "callout", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor1", "general", "greet", "greet", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor2", "general", "greet", "greet", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor3", "general", "greet", "greet", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor1", "general", "freakout", "freakout", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor2", "general", "freakout", "freakout", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor3", "general", "freakout", "freakout", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor1", "general", "instruct", "instruct", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor2", "general", "instruct", "instruct", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor3", "general", "instruct", "instruct", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor1", "general", "exit", "exit", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor2", "general", "exit", "exit", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor3", "general", "exit", "exit", undefined);
}

zmbaudiomidroundwavelogic() {
  level.zmlastcivilianchatterplayed = 0;
  level.zmnumcivilianroundsattempted = 0;

  for(;;) {
    level waittill("zombie_wave_started");

    if(level.wavecounter + 1 == level.nextcivilianround) {
      level thread zmbtrackzombiesprecivilianchatter();
    }

    if(level.roundtype == "civilian") {
      level thread zmbcivilianremindervo();
      level thread zmbciviliansurvivorvo();
      level thread zmbcivilianroundfinishedvo();
    }
  }
}

zmbtrackzombiesprecivilianchatter() {
  waitframe();

  while(level.zombie_spawning_active) {
    wait 1;
  }

  var_0 = maps\mp\zombies\zombies_spawn_manager::getnumberofzombies();

  for(;;) {
    if(var_0 <= 10) {
      break;
    }

    var_0 = maps\mp\zombies\zombies_spawn_manager::getnumberofzombies();
    waitframe();
  }

  var_1 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
  var_2 = var_1[0];
  var_3 = "rescue_prewave";

  if(zmbaudioiscivilianroundtense()) {
    var_3 = var_3 + "_tense";
  }

  waittilldonespeaking();

  if(var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", var_3)) {
    var_2 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 12);
    var_4 = randomintrange(0, level.players.size);
    var_5 = level.players[var_4];

    if(var_5 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian", var_3)) {
      var_5 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 12);
    }
  }

  level.zmlastcivilianchatterplayed = level.wavecounter;
  level notify("civilianPreChatterComplete");
}

anyplayersspeaking() {
  foreach(var_1 in level.players) {
    if(maps\mp\zombies\_util::is_true(var_1.isspeaking)) {
      return 1;
    }
  }

  return 0;
}

waittilldonespeaking() {
  while(anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isannouncerspeaking()) {
    waitframe();
  }
}

zmbcivilianremindervo() {
  level endon("civilian_spawned");
  wait 30;
  var_0 = "rescue_remind";

  if(zmbaudioiscivilianroundtense()) {
    var_0 = var_0 + "_tense";
  }

  var_1 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
  var_2 = var_1[0];

  if(isDefined(var_2)) {
    var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", var_0);
  }
}

zmbciviliansurvivorvo() {
  level waittill("civilian_spawned", var_0);
  var_0 endon("death");
  var_1 = level.survivorvoent;
  var_1.zmbvoxid = "survivor" + randomintrange(1, 4);
  var_1 linkto(var_0, "tag_origin", (0, 0, 60), (0, 0, 0));
  waitframe();

  if(var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "callout")) {
    var_1 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    var_2 = getclosestplayer(var_1.origin);

    if(var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian", "survivor_callout")) {
      var_2 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    }
  }

  var_3 = 65536;

  while(!var_0 maps\mp\zombies\_civilians::areplayerswithinrange(var_3)) {
    waitframe();
  }

  if(var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "greet")) {
    var_1 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    var_2 = getclosestplayer(var_1.origin);

    if(var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian", "survivor_response")) {
      var_2 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    }
  }

  var_4 = 8000;
  var_5 = 0;

  for(;;) {
    var_6 = var_0 common_scripts\utility::waittill_any_return_no_endon_death("damage", "begin_extraction", "extraction_started");

    if(var_6 == "damage" && gettime() > var_5) {
      var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "freakout");
      var_5 = gettime() + var_4;
    }

    if(var_6 == "begin_extraction") {
      var_2 = getclosestplayer(var_1.origin);

      if(var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian", "survivor_instruct")) {
        var_2 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);

        if(var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "instruct")) {
          var_1 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
        }
      }
    }

    if(var_6 == "extraction_started") {
      var_2 = getclosestplayer(var_1.origin);

      if(var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian", "survivor_exit")) {
        var_2 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);

        if(var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "exit")) {
          var_1 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
        }
      }

      return;
    }
  }
}

getclosestplayer(var_0) {
  var_1 = sortbydistance(level.players, var_0, undefined, 1);
  return var_1[0];
}

zmbcivilianroundfinishedvo() {
  var_0 = level common_scripts\utility::waittill_any_return("extraction_failed", "extraction_complete");
  wait 3;
  var_1 = "rescue";

  if(var_0 == "extraction_complete") {
    var_1 = var_1 + "_win";
  } else {
    var_1 = var_1 + "_fail";
  }

  if(level.wavecounter == level.firstcivilianround) {
    var_1 = var_1 + "_first";
    var_2 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
    var_3 = var_2[0];

    if(isDefined(var_3) && var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", var_1)) {
      var_3 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 5);
    }

    var_4 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");

    if(isDefined(var_4) && var_4 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian", var_1)) {
      var_4 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 5);
    }

    var_5 = maps\mp\zombies\_zombies_audio::getanycharacterbyprefixexcept("it");

    if(isDefined(var_5) && var_5 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian", var_1)) {
      var_5 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 5);
    }
  } else {
    if(zmbaudioiscivilianroundtense()) {
      var_1 = var_1 + "_tense";
    }

    var_2 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
    var_3 = var_2[0];

    if(isDefined(var_3)) {
      var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", var_1);
    }
  }

  level.zmnumcivilianroundsattempted++;
}

zmbaudioiscivilianroundtense() {
  return level.zmnumcivilianroundsattempted > 4;
}

zmbaudiowave1vo() {
  if(level.players.size == 1 && maps\mp\zombies\_util::get_player_index(level.players[0]) != maps\mp\zombies\_zombies_audio::getcharacterindexbyprefix("it")) {
    level.players[0] maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "intro");
  } else {
    var_0 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");

    if(isDefined(var_0) && var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "wave1")) {
      level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 5);
    }

    if(level.players.size == 1) {
      return;
    }
    var_0 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("exec");

    if(isDefined(var_0) && var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "wave1")) {
      level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 5);
    }

    var_0 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("guard");

    if(isDefined(var_0) && var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "wave1")) {
      level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 5);
    }

    var_0 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");

    if(isDefined(var_0) && var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "wave1b")) {
      level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 5);
    }

    var_0 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("janitor");

    if(isDefined(var_0) && var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "wave1")) {
      level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 5);
    }
  }
}

zmbaudiowavestartvo(var_0) {
  if(!var_0 && (level.wavecounter == 5 || level.wavecounter == 10 || level.wavecounter == 20 || level.wavecounter == 35 || level.wavecounter == 50)) {
    var_1 = randomintrange(0, level.players.size);
    level.players[var_1] maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "round_" + level.wavecounter);
    var_0 = 1;
  }

  return var_0;
}

zmbwaveintermissionvo(var_0) {
  var_1 = var_0;

  if(level.wavecounter == 1) {
    var_2 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
    var_3 = var_2[0];
    var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", "wave1_int");
    var_1 = 1;
  } else if(level.wavecounter == 2) {
    level thread maps\mp\zombies\_zombies_audio::playwavenumintrodialog("wave2_int", 2, 0, 1, 3, "pilot_conv");
    var_1 = 1;
  } else if(level.wavecounter == 3) {
    var_2 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
    var_3 = var_2[0];
    var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", "wave3_int");
    var_1 = 1;
  } else if(level.wavecounter == 5) {
    var_2 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
    var_3 = var_2[0];

    if(var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", "wave5_int")) {
      var_3 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    }

    var_4 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("janitor");

    if(isDefined(var_4) && var_4 maps\mp\zombies\_zombies_audio::create_and_play_dialog("pilot_conv", "wave5_int")) {
      var_4 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    }

    waittilldonespeaking();

    if(var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", "wave5b_int")) {
      var_3 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    }

    var_5 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");

    if(isDefined(var_5) && var_5 maps\mp\zombies\_zombies_audio::create_and_play_dialog("pilot_conv", "wave5b_int")) {
      var_5 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    }

    var_1 = 1;
  } else if(level.wavecounter + 1 == level.nextcivilianround) {
    level thread zmplaycivilianmissionstartvo();
  }

  return var_1;
}

zmplaycivilianmissionstartvo() {
  if(level.zmlastcivilianchatterplayed < level.wavecounter) {
    level waittill("civilianPreChatterComplete");
  }

  var_0 = "rescue_wave";

  if(zmbaudioiscivilianroundtense()) {
    var_0 = var_0 + "tense";
  }

  var_1 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
  var_2 = var_1[0];
  var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", var_0);
}

zoneopenedvo() {
  level thread _waitandplayzonevo("sewer_to_burgertown", undefined, "to_burgertown");
  level thread _waitandplayzonevo("gas_station_to_sewer", "atlas_to_sewer", "to_sewers");
  level thread _waitandplayzonevo("warehouse_to_gas_station", "gas_station_to_sewer", "to_voltage");
  level thread _waitandplayzonevo("warehouse_to_atlas", "atlas_to_sewer", "to_atlas");
}

_waitandplayzonevo(var_0, var_1, var_2) {
  var_3 = level common_scripts\utility::waittill_any_return_parms(var_0, var_1);
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = maps\mp\zombies\_zombies_audio_announcer::getannouncer();
  var_6 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 3);
  wait 0.5;

  if(isDefined(var_5)) {
    var_5 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", var_2);
  }
}

zmbcustomresponseline(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "pilot_conv") {
    level thread setup_pilot_conversation_response_line(var_0, var_2, var_3);
  } else if(var_2 == "an_conv" || var_2 == "civilian") {
    level thread maps\mp\zombies\_zombies_audio::setup_announcer_conversation_response_line(var_0, var_2, var_3);
  } else {
    level thread maps\mp\zombies\_zombies_audio::setup_response_line(var_0, var_1, var_2, var_3, var_4);
  }
}

setup_pilot_conversation_response_line(var_0, var_1, var_2) {
  var_3 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
  var_4 = var_3[0];
  var_5 = level.vox.speaker[var_0.zmbvoxid].response[var_1][var_2];
  var_6 = strtok(var_5, ",");

  if(var_6.size == 2) {
    var_1 = var_6[0];
    var_2 = var_6[1];
    var_4 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_1, var_2);
  } else if(var_6.size == 1) {
    var_2 = var_6[0];
    var_7 = common_scripts\utility::array_randomize(level.players);

    foreach(var_0 in var_7) {
      var_9 = var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_1, var_2, "");

      if(var_9) {
        break;
      }
    }
  }
}

zmaudiocustomtrapvo(var_0, var_1) {
  wait 1;

  if(!isDefined(var_0.script_noteworthy) || !isDefined(var_1)) {
    return;
  }
  var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", var_0.script_noteworthy);
}

zmaudiotoxiczonesvo(var_0) {
  var_1 = common_scripts\utility::array_randomize(level.players);

  foreach(var_3 in var_0) {
    foreach(var_5 in var_1) {
      if(maps\mp\zombies\_zombies_zone_manager::isplayerinzone(var_3)) {
        var_5 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "toxic_zone");
        return;
      }
    }
  }
}

zmbspotzombiesvo() {
  level thread zmbspotzombie("spiked");
  level thread zmbspotzombie("acid");
  level thread zmbhandlegoliath();
}

zmbhandlegoliath() {
  level.zmbaudioplayedfirstspotmeleegoliath = 0;

  for(;;) {
    level waittill("onZombieMeleeGoliathSpawn", var_0);
    level thread zmbspotgoliath(var_0);
  }
}

zmbspotgoliath(var_0) {
  var_0 endon("death");
  var_1 = 1;
  level thread notifyongoliathdamaged(var_0, "waittillPlayerSpotsGoliathReturn", "damage");
  level thread notifyonplayerclosetogoliath(var_0, "waittillPlayerSpotsGoliathReturn", "close");

  for(;;) {
    var_0 waittill("waittillPlayerSpotsGoliathReturn", var_2, var_3);

    if(!isDefined(var_2)) {
      continue;
    }
    if(!level.zmbaudioplayedfirstspotmeleegoliath) {
      if(var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "spot_first_goliath")) {
        var_1 = 0;
        level.zmbaudioplayedfirstspotmeleegoliath = 1;
      }
    } else if(var_1) {
      var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "spot_goliath");
      var_1 = 0;
    } else if(var_3 == "damage" && var_0.health <= var_0.maxhealth / 2) {
      if(var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "goliath_shoot")) {
        return;
      }
    }

    waitframe();
    level thread notifyongoliathdamaged(var_0, "waittillPlayerSpotsGoliathReturn", "damage");
  }
}

notifyongoliathdamaged(var_0, var_1, var_2) {
  var_0 endon(var_1);
  var_0 endon("death");

  for(;;) {
    var_0 waittill("damage", var_3, var_4);
    var_0 notify(var_1, var_4, var_2);
  }
}

notifyonplayerclosetogoliath(var_0, var_1, var_2) {
  var_0 endon(var_1);
  var_0 endon("death");

  for(;;) {
    var_3 = getplayerclosetozombie(var_0);

    if(isDefined(var_3)) {
      var_0 notify(var_1, var_3, var_2);
      return;
    }

    waitframe();
  }
}

zmbspotzombie(var_0) {
  level thread notifyonround(7, "end_spot_zombie_round_7");
  level endon("end_spot_zombie_round_7");
  var_1 = 1;

  for(;;) {
    var_2 = waittillplayerspotszombiereturn(var_0);

    if(!isDefined(var_2)) {
      continue;
    }
    if(!var_1) {
      if(var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "spot_first_" + var_0)) {
        var_1 = 1;
        wait 15;
      } else {
        wait 1;
      }

      continue;
    } else {
      var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "spot_" + var_0);
    }

    wait 15;
  }
}

notifyonround(var_0, var_1) {
  for(;;) {
    level waittill("zombie_wave_started");

    if(level.wavecounter >= var_0) {
      level notify(var_1);
      return;
    }
  }
}

waittillplayerspotszombiereturn(var_0) {
  level thread notifyonzombiemutatordamaged(var_0, "waittillPlayerSpotsZombieReturn_" + var_0);
  level thread notifyonplayerclosetozombiemutator(var_0, "waittillPlayerSpotsZombieReturn_" + var_0);
  level waittill("waittillPlayerSpotsZombieReturn_" + var_0, var_1);
  return var_1;
}

notifyonzombiemutatordamaged(var_0, var_1) {
  level endon(var_1);
  level endon("end_spot_zombie_round_7");

  for(;;) {
    level waittill("zombie_damaged", var_2, var_3);

    if(!isDefined(var_3) || !isDefined(var_2) || !var_2 maps\mp\zombies\_util::checkactivemutator(var_0)) {
      continue;
    }
    level notify(var_1, var_3);
    return;
  }
}

notifyonplayerclosetozombiemutator(var_0, var_1) {
  level endon(var_1);
  level endon("end_spot_zombie_round_7");

  for(;;) {
    var_2 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

    foreach(var_4 in var_2) {
      if(var_4.team == level.playerteam || !var_4 maps\mp\zombies\_util::checkactivemutator(var_0)) {
        continue;
      }
      var_5 = getplayerclosetozombie(var_4);

      if(isDefined(var_5)) {
        level notify(var_1, var_5);
        return;
      }
    }

    waitframe();
  }
}

getplayerclosetozombie(var_0) {
  var_1 = 90000;

  foreach(var_3 in level.players) {
    var_4 = distancesquared(var_3.origin, var_0.origin);

    if(var_4 <= var_1) {
      return var_3;
    }
  }
}

zmbaudioacidpoolvo() {
  for(;;) {
    if(level.nextgen) {
      level waittill("acid_zone_created", var_0);
      var_1 = getclosestplayer(var_0.origin);
    } else {
      level waittill("acid_zone_created", var_2);
      var_1 = getclosestplayer(var_2);
    }

    if(var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "acid_pool")) {
      level waittill("zombie_wave_started");

      if(level.wavecounter > 6) {
        return;
      }
    }
  }
}