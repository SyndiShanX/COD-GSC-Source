/************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_zombies_shotgun_vo_util.gsc
************************************************************************/

init() {
  init_converations();
  level.charactergroups = [];
  var_0 = 0;
  var_1 = _tablegetrowcount("mp/zmCharacterIdTable.csv");

  while(var_0 < var_1) {
    var_2 = _tablelookupbyrow("mp/zmCharacterIdTable.csv", var_0, 15);

    if(_id_0547::_id_5565(var_2, "feml") || _id_0547::_id_5565(var_2, "male"))
      var_2 = _tablelookupbyrow("mp/zmCharacterIdTable.csv", var_0, 16);

    if(!isDefined(var_2)) {
      var_0++;
      continue;
    } else
      var_0++;

    if(!isDefined(level.charactergroups[var_2]))
      level.charactergroups[var_2] = [];

    level.charactergroups[var_2] = common_scripts\utility::_id_0F6F(level.charactergroups[var_2], var_0 - 1);
  }
}

init_converations() {
  maps\mp\zombies\_zombies_audio_dlc2::initwavestories();
  var_0 = [];
  var_0[var_0.size] = ["zmb_dlc3_gbl_dros_nowimnophysicianbutthoseg", 1.0];
  var_0[var_0.size] = ["zmb_dlc3_gbl_oliv_theyvebeenchargedwithwhat", 1.0];
  var_0[var_0.size] = ["zmb_dlc3_gbl_jeff_thisisnotcomplicatedpeopl", 1.0];
  level.extermination_story = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_0, 1, undefined, "zmb_dlc3_gbl_");
}

is_character_present_in_match(var_0) {
  if(!_isarray(var_0))
    var_0 = [var_0];

  foreach(var_2 in var_0) {
    foreach(var_4 in level.players) {
      if(common_scripts\utility::_id_0F79(level.charactergroups[var_2], var_4._id_20D8))
        return 1;
    }
  }

  return 0;
}

player_is_character_type(var_0) {
  var_1 = self;
  return common_scripts\utility::_id_0F79(level.charactergroups[var_0], var_1._id_20D8);
}

random_valid_character_player(var_0, var_1) {
  var_2 = [];

  foreach(var_8, var_4 in level.players) {
    foreach(var_7, var_6 in var_1)
    var_2 = common_scripts\utility::_id_0F6F(var_2, [var_4, var_1[var_7], var_0[var_7]]);
  }

  var_2 = common_scripts\utility::array_randomize(var_2);

  foreach(var_10 in var_2) {
    var_4 = var_10[0];
    var_11 = var_10[1];
    var_12 = var_10[2];

    if(var_4 player_is_character_type(var_12)) {
      var_4 thread _id_0378::_id_307E(var_11, level.players);
      return;
    }
  }
}

all_players_present(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(var_3 player_is_character_type(var_6))
        var_1++;
    }
  }

  return var_1 == var_0.size;
}

play_global_vo(var_0, var_1, var_2) {
  foreach(var_4 in level.players)
  var_4 thread player_vo_to_self(var_0, var_1, var_2);
}

player_vo_to_self(var_0, var_1, var_2) {
  var_3 = self;

  if(common_scripts\utility::_id_562E(var_2)) {
    if(var_3 player_is_character_type("ride")) {
      if(var_3 issplitscreenplayer()) {
        if(var_3 issplitscreenplayerprimary())
          var_3 thread _id_0378::_id_307E(var_0, level.players);
        else {}
      }
    } else {
      if(!isDefined(level.rideau_radio)) {
        level.rideau_radio = spawn("script_origin", (0, 0, -10000));
        level.rideau_radio._id_20D8 = 8;
      }

      if(var_3 issplitscreenplayer()) {
        if(var_3 issplitscreenplayerprimary())
          var_3._id_071D.pa_vo_on_player = _id_0380::_id_6844(var_0, var_3, level.rideau_radio, 0, var_1);
        else {}
      } else
        var_3._id_071D.pa_vo_on_player = _id_0380::_id_6844(var_0, var_3, level.rideau_radio, 0, var_1);
    }
  } else
    var_3._id_071D.pa_vo_on_player = _id_0380::_id_6844(var_0, var_3, var_3, 0, var_1);
}

try_run_conversation(var_0, var_1, var_2, var_3, var_4) {
  if(!maps\mp\zombies\_zombies_audio_dlc2::validate_players_in_story(var_0))
    return 0;

  if(!isDefined(level.currentwavestoryindex))
    level.currentwavestoryindex = 0;

  level.wavestories.story_playing = 1;
  level.currentwavestoryindex++;
  var_5 = 0;
  level endon("story_timed_out");

  if(isDefined(var_2))
    level thread timeout_conversation(var_2);

  foreach(var_7 in var_0._id_5D99) {
    var_8 = var_7._id_90BE;
    var_9 = undefined;
    var_10 = 0;
    var_11 = 0;

    foreach(var_13 in level.players) {
      if(isDefined(var_13._id_20D8)) {
        var_14 = _id_0378::_id_307B(var_13._id_20D8);

        if(var_14 == var_8) {
          var_9 = var_13;
          var_10 = 1;
          var_11 = get_speaker_alive(var_13);
          break;
        }
      }
    }

    var_16 = undefined;

    if(var_11 && isDefined(var_9)) {
      var_17 = gettime();
      var_9 _id_0378::_id_307E(var_7._id_0BB4, level.players, undefined, var_1);
    } else
      var_9 _id_0378::_id_307E(var_7._id_0BB4, level.players, undefined, var_1);

    wait(var_7.post_delay);
  }

  level notify("story_delievered");
  level.wavestories.story_playing = 0;
  return 1;
}

timeout_conversation(var_0) {
  level endon("story_delievered");
  wait(var_0);
  level notify("story_timed_out");
}

get_speaker_alive(var_0) {
  if(_id_0547::_id_57E1(var_0))
    return 0;

  if(var_0.sessionstate == "spectator")
    return 0;

  return 1;
}