/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3407.gsc
**************************************/

parse_music_genre_table() {
  scripts\engine\utility::flag_init("jukebox_paused");
  level.jukebox_songs = [];
  level.forced_songs = [];
  level.event_songs = ["mus_pa_sp_knightrider", "mus_pa_mw1_80s_cover", "mus_pa_mw2_80s_cover"];
  level.song_skip_time = 0;
  level.next_perk_jingle_time = 0;
  level.songs_played = 0;

  if(isDefined(level.jukebox_table)) {
    var_0 = level.jukebox_table;
  } else {
    var_0 = "cp\zombies\cp_zmb_music_genre.csv";
  }

  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 1);

    if(var_2 == "") {
      break;
    }
    if(scripts\engine\utility::array_contains(level.event_songs, var_2)) {
      var_1++;
      continue;
    }

    var_3 = tablelookupbyrow(var_0, var_1, 2);
    var_4 = tablelookupbyrow(var_0, var_1, 3);
    var_5 = tablelookupbyrow(var_0, var_1, 4);
    var_6 = tablelookupbyrow(var_0, var_1, 5);
    var_7 = spawnStruct();
    var_7.songname = var_2;
    var_7.djintro = var_4;
    var_7.djoutro = var_5;
    var_7.djgenreintro = var_6;
    var_7.genre = var_3;
    level.jukebox_songs[level.jukebox_songs.size] = var_7;
    var_1++;
  }
}

jukebox_start(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("add_hidden_song_to_playlist");
  level endon("add_hidden_song_2_to_playlist");
  level endon("force_new_song");

  if(!isDefined(var_1)) {
    level waittill("jukebox_start");

    if(scripts\cp\utility::map_check(0)) {
      var_3 = lookupsoundlength("dj_jingle_intro") / 1000;
    } else {
      var_3 = 0.005;
    }

    wait(var_3);
  }

  if(isDefined(level.jukebox_table)) {
    var_4 = level.jukebox_table;
  } else {
    var_4 = "cp\zombies\cp_zmb_music_genre.csv";
  }

  if(!scripts\engine\utility::is_true(var_2)) {
    var_5 = scripts\engine\utility::array_randomize_objects(level.jukebox_songs);

    if(isDefined(level.current_dj_song)) {
      for(;;) {
        if(var_5[0].songname == level.current_dj_song) {
          var_5 = scripts\engine\utility::array_randomize_objects(level.jukebox_songs);
        } else {
          break;
        }

        wait 0.05;
      }
    }
  } else {
    var_5 = level.jukebox_songs;
  }

  var_6 = spawn("script_origin", var_0);
  level.jukebox_org_struct = var_6;
  var_7 = get_song_struct(var_5, 1, var_6);

  for(;;) {
    if(scripts\engine\utility::flag("jukebox_paused")) {
      scripts\engine\utility::flag_waitopen("jukebox_paused");
    }

    var_8 = var_7.songname;
    level.current_dj_song = var_8;
    var_5 = scripts\engine\utility::array_remove(var_5, var_7);
    var_9 = var_7.djoutro;

    if(var_5.size < 1 && !scripts\engine\utility::is_true(var_2)) {
      var_5 = scripts\engine\utility::array_randomize_objects(level.jukebox_songs);

      if(isDefined(level.current_dj_song)) {
        for(;;) {
          if(var_5[0].songname == level.current_dj_song) {
            var_5 = scripts\engine\utility::array_randomize_objects(level.jukebox_songs);
          } else {
            break;
          }

          wait 0.05;
        }
      }
    }

    var_10 = int(tablelookup(var_4, 1, var_8, 0));
    var_6 playLoopSound(var_8);
    level.songs_played++;
    var_11 = lookupsoundlength(var_8) / 1000;
    setomnvar("song_playing", var_10);
    level.song_last_played = var_10;
    var_6 thread earlyendon(var_6);
    level scripts\engine\utility::waittill_any_timeout(var_11, "skip_song");
    var_6 stoploopsound();

    if(level.songs_played % 4 == 0) {
      if(var_9 != "") {
        var_6 playSound(var_9);
        var_12 = lookupsoundlength(var_9) / 1000;
        level scripts\engine\utility::waittill_any_timeout(var_12);
      }
    }

    var_7 = get_song_struct(var_5, 0, var_6);
    wait 1.0;
  }
}

earlyendon(var_0) {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any("add_hidden_song_to_playlist", "add_hidden_song_2_to_playlist", "force_new_song");
  var_0 stoploopsound();
  wait 2.0;

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

force_song(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("game_ended");
  level endon("add_hidden_song_to_playlist");
  level endon("add_hidden_song_2_to_playlist");
  level notify("force_new_song");
  level endon("force_new_song");

  if(isDefined(var_5)) {
    level.forced_songs[var_5] = var_5;
  }

  var_7 = spawnStruct();
  var_7.songname = var_1;
  var_7.djintro = "";
  var_7.djoutro = "";
  var_7.djgenreintro = "";
  var_7.genre = "music";
  level.jukebox_songs[level.jukebox_songs.size] = var_7;

  if(!isDefined(var_0)) {
    var_0 = (649, 683, 254);
  }

  wait 2.5;

  if(isDefined(var_3)) {}

  if(isDefined(var_2)) {
    scripts\engine\utility::play_sound_in_space(var_2, var_0);
  } else {
    scripts\engine\utility::play_sound_in_space("zmb_jukebox_on", var_0);
  }

  var_8 = spawn("script_origin", var_0);
  var_8 playLoopSound(var_1);
  level.current_dj_song = var_1;
  var_8 thread earlyendon(var_8);
  var_9 = lookupsoundlength(var_1) / 1000;
  scripts\engine\utility::waittill_any_timeout(var_9, "skip_song");
  var_8 stoploopsound();

  if(getdvar("ui_mapname") != "cp_disco") {
    level thread scripts\cp\cp_vo::try_to_play_vo("dj_sign_off", "zmb_dj_vo", "high", 20, 1, 0, 1);
    var_10 = lookupsoundlength("dj_sign_off") / 1000;
    wait(var_10);
  }

  if(scripts\engine\utility::is_true(var_6)) {
    parse_music_genre_table();
  }

  level thread jukebox_start((649, 683, 254), 1);
}

get_song_struct(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_9, var_4 in var_0) {
    var_5 = var_0[var_9].djintro;

    if(var_0[var_9].genre == "perk") {
      if(var_1) {
        continue;
      }
      var_6 = gettime();

      if(var_6 < level.next_perk_jingle_time && var_9 + 1 < var_0.size) {
        continue;
      } else {
        if(isDefined(var_5) && var_5 != "") {
          level thread scripts\cp\cp_vo::try_to_play_vo(var_5, "zmb_dj_vo");
          var_7 = lookupsoundlength(var_5) / 1000;
          wait(var_7);
        }

        level.next_perk_jingle_time = gettime() + 180000;
        return var_0[var_9];
      }
    } else {
      if(isDefined(var_5) && var_5 != "") {
        if(getdvar("ui_mapname") == "cp_disco") {
          var_5 = cp_disco_pam_radio_vo();

          if(var_5 != "nil") {
            while(scripts\engine\utility::is_true(level.pam_playing) || scripts\engine\utility::is_true(level.announcer_vo_playing)) {
              wait 0.1;
            }

            var_2 playLoopSound(var_5);

            if(!isDefined(level.jukebox_playing)) {
              level.jukebox_playing = [];
            }

            if(!isDefined(level.jukebox_playing)) {
              level.jukebox_playing[var_5] = [];
            }

            level.jukebox_playing[var_5] = 1;
            var_2 thread earlyendon(var_2);
            var_8 = lookupsoundlength(var_5) / 1000;
            scripts\engine\utility::waittill_any_timeout(var_8, "skip_song");
            level.jukebox_playing[var_5] = 0;
            var_2 stoploopsound();
          }
        } else {
          level thread scripts\cp\cp_vo::try_to_play_vo(var_5, "zmb_dj_vo", "high", 20, 1, 0, 1);
          var_7 = lookupsoundlength(var_5) / 1000;
          wait(var_7);
        }
      }

      return var_0[var_9];
    }
  }
}

cp_disco_pam_radio_vo() {
  var_0 = "nil";

  switch (level.pam_radio_counter) {
    case 1:
      var_0 = "pam_radio_dojo_intro";
      break;
    case 2:
      var_0 = "pam_radio_power";
      break;
    case 3:
      var_0 = "pam_radio_perks";
      break;
    case 4:
      var_0 = "pam_radio_generic";
      break;
    case 5:
      var_0 = "pam_radio_dojo";
      break;
    case 6:
      var_0 = "pam_radio_pap";
      break;
    case 7:
      var_0 = "pam_radio_defeat_ratking_1";
      break;
    case 8:
      var_0 = "pam_radio_defeat_ratking_2";
      break;
    case 11:
      var_0 = "pam_radio_defeat_ratking_3";
      break;
    case 13:
      var_0 = "pam_radio_final_right_ratking";
      break;
    default:
      var_0 = "nil";
      break;
  }

  level.pam_radio_counter = level.pam_radio_counter + 1;
  return var_0;
}