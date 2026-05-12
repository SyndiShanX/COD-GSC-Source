/****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_shotgun_vo_util.gsc
****************************************************************/

func_00D5() {
  init_converations();
  level.charactergroups = [];
  var_00 = 0;
  var_01 = function_027A("mp/zmCharacterIdTable.csv");
  while(var_00 < var_01) {
    var_02 = tablelookupbyrow("mp/zmCharacterIdTable.csv", var_00, 15);
    if(lib_0547::func_5565(var_02, "feml") || lib_0547::func_5565(var_02, "male")) {
      var_02 = tablelookupbyrow("mp/zmCharacterIdTable.csv", var_00, 16);
    }

    if(!isDefined(var_02)) {
      var_00++;
      continue;
    } else {
      var_00++;
    }

    if(!isDefined(level.charactergroups[var_02])) {
      level.charactergroups[var_02] = [];
    }

    level.charactergroups[var_02] = common_scripts\utility::func_F6F(level.charactergroups[var_02], var_00 - 1);
  }
}

init_converations() {
  maps\mp\zombies\_zombies_audio_dlc2::initwavestories();
  var_00 = [];
  var_00[var_00.size] = ["zmb_dlc3_gbl_dros_nowimnophysicianbutthoseg", 1];
  var_00[var_00.size] = ["zmb_dlc3_gbl_oliv_theyvebeenchargedwithwhat", 1];
  var_00[var_00.size] = ["zmb_dlc3_gbl_jeff_thisisnotcomplicatedpeopl", 1];
  level.extermination_story = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_00, 1, undefined, "zmb_dlc3_gbl_");
}

is_character_present_in_match(param_00) {
  if(!isarray(param_00)) {
    param_00 = [param_00];
  }

  foreach(var_02 in param_00) {
    foreach(var_04 in level.var_744A) {
      if(common_scripts\utility::func_F79(level.charactergroups[var_02], var_04.var_20D8)) {
        return 1;
      }
    }
  }

  return 0;
}

player_is_character_type(param_00) {
  var_01 = self;
  return common_scripts\utility::func_F79(level.charactergroups[param_00], var_01.var_20D8);
}

random_valid_character_player(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in level.var_744A) {
    foreach(var_07, var_06 in param_01) {
      var_02 = common_scripts\utility::func_F6F(var_02, [var_04, param_01[var_07], param_00[var_07]]);
    }
  }

  var_02 = common_scripts\utility::func_F92(var_02);
  foreach(var_0A in var_02) {
    var_04 = var_0A[0];
    var_0B = var_0A[1];
    var_0C = var_0A[2];
    if(var_04 player_is_character_type(var_0C)) {
      var_04 thread lib_0378::func_307E(var_0B, level.var_744A);
      return;
    }
  }
}

all_players_present(param_00) {
  var_01 = 0;
  foreach(var_03 in level.var_744A) {
    var_04 = 0;
    foreach(var_06 in param_00) {
      if(var_03 player_is_character_type(var_06)) {
        var_01++;
      }
    }
  }

  return var_01 == param_00.size;
}

play_global_vo(param_00, param_01, param_02) {
  foreach(var_04 in level.var_744A) {
    var_04 thread player_vo_to_self(param_00, param_01, param_02);
  }
}

player_vo_to_self(param_00, param_01, param_02) {
  var_03 = self;
  if(common_scripts\utility::func_562E(param_02)) {
    if(var_03 player_is_character_type("ride")) {
      if(var_03 issplitscreenplayer()) {
        if(var_03 method_82ED()) {
          var_03 thread lib_0378::func_307E(param_00, level.var_744A);
          return;
        }

        return;
      }

      return;
    }

    if(!isDefined(level.rideau_radio)) {
      level.rideau_radio = spawn("script_origin", (0, 0, -10000));
      level.rideau_radio.var_20D8 = 8;
    }

    if(var_03 issplitscreenplayer()) {
      if(var_03 method_82ED()) {
        var_03.var_71D.pa_vo_on_player = lib_0380::func_6844(param_00, var_03, level.rideau_radio, 0, param_01);
        return;
      }

      return;
    }

    var_03.var_71D.pa_vo_on_player = lib_0380::func_6844(param_00, var_03, level.rideau_radio, 0, param_01);
    return;
  }

  var_03.var_71D.pa_vo_on_player = lib_0380::func_6844(param_00, var_03, var_03, 0, param_01);
}

try_run_conversation(param_00, param_01, param_02, param_03, param_04) {
  if(!maps\mp\zombies\_zombies_audio_dlc2::validate_players_in_story(param_00)) {
    return 0;
  }

  if(!isDefined(level.currentwavestoryindex)) {
    level.currentwavestoryindex = 0;
  }

  level.wavestories.story_playing = 1;
  level.currentwavestoryindex++;
  var_05 = 0;
  level endon("story_timed_out");
  if(isDefined(param_02)) {
    level thread timeout_conversation(param_02);
  }

  foreach(var_07 in param_00.var_5D99) {
    var_08 = var_07.var_90BE;
    var_09 = undefined;
    var_0A = 0;
    var_0B = 0;
    foreach(var_0D in level.var_744A) {
      if(isDefined(var_0D.var_20D8)) {
        var_0E = lib_0378::func_307B(var_0D.var_20D8);
        if(var_0E == var_08) {
          var_09 = var_0D;
          var_0A = 1;
          var_0B = get_speaker_alive(var_0D);
          break;
        }
      }
    }

    var_10 = undefined;
    if(var_0B && isDefined(var_09)) {
      var_11 = gettime();
      var_09 lib_0378::func_307E(var_07.var_BB4, level.var_744A, undefined, param_01);
    } else {
      var_09 lib_0378::func_307E(var_07.var_BB4, level.var_744A, undefined, param_01);
    }

    wait(var_07.post_delay);
  }

  level notify("story_delievered");
  level.wavestories.story_playing = 0;
  return 1;
}

timeout_conversation(param_00) {
  level endon("story_delievered");
  wait(param_00);
  level notify("story_timed_out");
}

get_speaker_alive(param_00) {
  if(lib_0547::func_57E1(param_00)) {
    return 0;
  }

  if(param_00.var_178 == "spectator") {
    return 0;
  }

  return 1;
}