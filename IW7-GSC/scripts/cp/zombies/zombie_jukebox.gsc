/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_jukebox.gsc
*************************************************/

parse_music_genre_table() {
  scripts\engine\utility::flag_init("jukebox_paused");
  level.jukebox_songs = [];
  level.forced_songs = [];
  level.event_songs = ["mus_pa_sp_knightrider", "mus_pa_mw1_80s_cover", "mus_pa_mw2_80s_cover"];
  level.song_skip_time = 0;
  level.next_perk_jingle_time = 0;
  level.songs_played = 0;
  if(isDefined(level.jukebox_table)) {
    var_00 = level.jukebox_table;
  } else {
    var_00 = "cp\zombies\cp_zmb_music_genre.csv";
  }

  var_01 = 0;
  for(;;) {
    var_02 = tablelookupbyrow(var_00, var_01, 1);
    if(var_02 == "") {
      break;
    }

    if(scripts\engine\utility::array_contains(level.event_songs, var_02)) {
      var_01++;
      continue;
    }

    var_03 = tablelookupbyrow(var_00, var_01, 2);
    var_04 = tablelookupbyrow(var_00, var_01, 3);
    var_05 = tablelookupbyrow(var_00, var_01, 4);
    var_06 = tablelookupbyrow(var_00, var_01, 5);
    var_07 = spawnStruct();
    var_07.songname = var_02;
    var_07.djintro = var_04;
    var_07.djoutro = var_05;
    var_07.djgenreintro = var_06;
    var_07.genre = var_03;
    level.jukebox_songs[level.jukebox_songs.size] = var_07;
    var_01++;
  }
}

jukebox_start(param_00, param_01, param_02) {
  level endon("game_ended");
  level endon("add_hidden_song_to_playlist");
  level endon("add_hidden_song_2_to_playlist");
  level endon("force_new_song");
  if(!isDefined(param_01)) {
    level waittill("jukebox_start");
    if(scripts\cp\utility::map_check(0)) {
      var_03 = lookupsoundlength("dj_jingle_intro") / 1000;
    } else {
      var_03 = 0.005;
    }

    wait(var_03);
  }

  if(isDefined(level.jukebox_table)) {
    var_04 = level.jukebox_table;
  } else {
    var_04 = "cp\zombies\cp_zmb_music_genre.csv";
  }

  if(!scripts\engine\utility::istrue(param_02)) {
    var_05 = scripts\engine\utility::array_randomize_objects(level.jukebox_songs);
    if(isDefined(level.current_dj_song)) {
      for(;;) {
        if(var_05[0].songname == level.current_dj_song) {
          var_05 = scripts\engine\utility::array_randomize_objects(level.jukebox_songs);
          continue;
        }

        break;
        wait(0.05);
      }
    }
  } else {
    var_05 = level.jukebox_songs;
  }

  var_06 = spawn("script_origin", param_00);
  level.jukebox_org_struct = var_06;
  var_07 = get_song_struct(var_05, 1, var_06);
  for(;;) {
    if(scripts\engine\utility::flag("jukebox_paused")) {
      scripts\engine\utility::flag_waitopen("jukebox_paused");
    }

    var_08 = var_07.songname;
    level.current_dj_song = var_08;
    var_05 = scripts\engine\utility::array_remove(var_05, var_07);
    var_09 = var_07.djoutro;
    if(var_05.size < 1 && !scripts\engine\utility::istrue(param_02)) {
      var_05 = scripts\engine\utility::array_randomize_objects(level.jukebox_songs);
      if(isDefined(level.current_dj_song)) {
        for(;;) {
          if(var_05[0].songname == level.current_dj_song) {
            var_05 = scripts\engine\utility::array_randomize_objects(level.jukebox_songs);
            continue;
          }

          break;
          wait(0.05);
        }
      }
    }

    var_0A = int(tablelookup(var_04, 1, var_08, 0));
    var_06 playLoopSound(var_08);
    level.songs_played++;
    var_0B = lookupsoundlength(var_08) / 1000;
    if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
      setomnvar("song_playing", var_0A);
    }

    level.song_last_played = var_0A;
    var_06 thread earlyendon(var_06);
    level scripts\engine\utility::waittill_any_timeout_1(var_0B, "skip_song");
    var_06 stoploopsound();
    if(level.songs_played % 4 == 0) {
      if(var_09 != "") {
        var_06 playSound(var_09);
        var_0C = lookupsoundlength(var_09) / 1000;
        level scripts\engine\utility::waittill_any_timeout_1(var_0C);
      }
    }

    var_07 = get_song_struct(var_05, 0, var_06);
    wait(1);
  }
}

earlyendon(param_00) {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any_3("add_hidden_song_to_playlist", "add_hidden_song_2_to_playlist", "force_new_song");
  param_00 stoploopsound();
  wait(2);
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

force_song(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  level endon("game_ended");
  level endon("add_hidden_song_to_playlist");
  level endon("add_hidden_song_2_to_playlist");
  level notify("force_new_song");
  level endon("force_new_song");
  if(isDefined(param_05)) {
    level.forced_songs[param_05] = param_05;
  }

  var_07 = spawnStruct();
  var_07.songname = param_01;
  var_07.djintro = "";
  var_07.djoutro = "";
  var_07.djgenreintro = "";
  var_07.genre = "music";
  level.jukebox_songs[level.jukebox_songs.size] = var_07;
  if(!isDefined(param_00)) {
    param_00 = (649, 683, 254);
  }

  wait(2.5);
  if(isDefined(param_03)) {}

  if(isDefined(param_02)) {
    scripts\engine\utility::play_sound_in_space(param_02, param_00);
  } else {
    scripts\engine\utility::play_sound_in_space("zmb_jukebox_on", param_00);
  }

  var_08 = spawn("script_origin", param_00);
  var_08 playLoopSound(param_01);
  level.current_dj_song = param_01;
  var_08 thread earlyendon(var_08);
  var_09 = lookupsoundlength(param_01) / 1000;
  scripts\engine\utility::waittill_any_timeout_1(var_09, "skip_song");
  var_08 stoploopsound();
  if(getdvar("ui_mapname") != "cp_disco") {
    level thread scripts\cp\cp_vo::try_to_play_vo("dj_sign_off", "zmb_dj_vo", "high", 20, 1, 0, 1);
    var_0A = lookupsoundlength("dj_sign_off") / 1000;
    wait(var_0A);
  }

  if(scripts\engine\utility::istrue(param_06)) {
    parse_music_genre_table();
  }

  level thread jukebox_start((649, 683, 254), 1);
}

get_song_struct(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  foreach(var_09, var_04 in param_00) {
    var_05 = param_00[var_09].djintro;
    if(param_00[var_09].genre == "perk") {
      if(param_01) {
        continue;
      }

      var_06 = gettime();
      if(var_06 < level.next_perk_jingle_time && var_09 + 1 < param_00.size) {
        continue;
      } else {
        if(isDefined(var_05) && var_05 != "") {
          level thread scripts\cp\cp_vo::try_to_play_vo(var_05, "zmb_dj_vo");
          var_07 = lookupsoundlength(var_05) / 1000;
          wait(var_07);
        }

        level.next_perk_jingle_time = gettime() + 180000;
        return param_00[var_09];
      }

      continue;
    }

    if(isDefined(var_05) && var_05 != "") {
      if(getdvar("ui_mapname") == "cp_disco") {
        var_05 = cp_disco_pam_radio_vo();
        if(var_05 != "nil") {
          while(scripts\engine\utility::istrue(level.pam_playing) || scripts\engine\utility::istrue(level.announcer_vo_playing)) {
            wait(0.1);
          }

          param_02 playLoopSound(var_05);
          if(!isDefined(level.jukebox_playing)) {
            level.jukebox_playing = [];
          }

          if(!isDefined(level.jukebox_playing)) {
            level.jukebox_playing[var_05] = [];
          }

          level.jukebox_playing[var_05] = 1;
          param_02 thread earlyendon(param_02);
          var_08 = lookupsoundlength(var_05) / 1000;
          scripts\engine\utility::waittill_any_timeout_1(var_08, "skip_song");
          level.jukebox_playing[var_05] = 0;
          param_02 stoploopsound();
        }
      } else {
        level thread scripts\cp\cp_vo::try_to_play_vo(var_05, "zmb_dj_vo", "high", 20, 1, 0, 1);
        var_07 = lookupsoundlength(var_05) / 1000;
        wait(var_07);
      }
    }

    return param_00[var_09];
  }
}

cp_disco_pam_radio_vo() {
  var_00 = "nil";
  switch (level.pam_radio_counter) {
    case 1:
      var_00 = "pam_radio_dojo_intro";
      break;

    case 2:
      var_00 = "pam_radio_power";
      break;

    case 3:
      var_00 = "pam_radio_perks";
      break;

    case 4:
      var_00 = "pam_radio_generic";
      break;

    case 5:
      var_00 = "pam_radio_dojo";
      break;

    case 6:
      var_00 = "pam_radio_pap";
      break;

    case 7:
      var_00 = "pam_radio_defeat_ratking_1";
      break;

    case 8:
      var_00 = "pam_radio_defeat_ratking_2";
      break;

    case 11:
      var_00 = "pam_radio_defeat_ratking_3";
      break;

    case 13:
      var_00 = "pam_radio_final_right_ratking";
      break;

    default:
      var_00 = "nil";
      break;
  }

  level.pam_radio_counter = level.pam_radio_counter + 1;
  return var_00;
}