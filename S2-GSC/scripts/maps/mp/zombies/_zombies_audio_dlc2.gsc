/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_audio_dlc2.gsc
***********************************************************/

initdlc2audio() {
  level._id_0793 = ::initleveldialog;
  level.high_intensity_objectives = [];
}

initleveldialog() {
  level._id_A62B _id_054E::_id_AB1A("player", "ability", "special_camo1", "camouflage", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "ability", "special_camo2", "camouflage2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "ability", "special_mad1", "freefire", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "ability", "special_mad2", "freefire2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "ability", "special_taunt1", "frontline", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "ability", "special_taunt2", "frontline2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "ability", "special_burst1", "shellshock", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "ability", "special_burst2", "shellshock2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "ability", "special_burst3", "shellshock3", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_supplyammo1", "supplyammomod", "thanks");
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_supplyammo2", "supplyammomod2", "thanks");
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_headshot1", "headshotmod", "mod_headshot_reply");
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_headshot2", "headshotmod2", "mod_headshot_reply");
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_serratededge1", "serreatededgemod", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_serratededge2", "serreatededgemod2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_covertexfiltration1", "covertexfilration", "revived");
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_covertexfiltration2", "covertexfilration2", "revived");
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_fieryburst1", "fieryburstmod", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_fieryburst2", "fieryburstmod2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_comeandgetit1", "comeandgetitmod", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_comeandgetit2", "comeandgetitmod2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_teameffort1", "teameffort", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "mod_use", "mod_teameffort2", "teameffort2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "revive_ally1", "modrevived", "revived");
  level._id_A62B _id_054E::_id_AB1A("player", "general", "revive_ally2", "modrevived2", "revived");
  level._id_A62B _id_054E::_id_AB1A("player", "general", "revived1", "modrevived_reply", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "revived2", "modrevived_reply2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "give_money1", "givemoney", undefined, 25);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "give_money2", "givemoney2", undefined, 25);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "weaponreminder", "weaponreminder", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "weaponreminder2", "weaponreminder2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "got_item3", "givemoney_reply", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "got_item4", "givemoney_reply2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "lost_and_found", "lostandfound", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "lost_and_found1", "lostandfound2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "needmoney1", "not_enough_jolt", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "needmoney2", "not_enough_jolt2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "newweapon", "newweapon", undefined, 40);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "newweapon1", "newweapon2", undefined, 40);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "newweapon2", "newweapon3", undefined, 40);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "newpackweapon", "newpackweapon", undefined, 50);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "newpackweapon2", "newpackweapon2", undefined, 50);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "newpackweapon3", "newpackweapon3", undefined, 50);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "newpackweapon4", "teslafired", undefined, 50);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "reloading", "reloading", undefined, 5);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "consumableweapon", "consumableweapon", undefined, 75);
  level._id_A62B _id_054E::_id_AB1A("player", "general", "consumableweapon2", "consumableweapon2", undefined, 75);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "treasurezombieseen1", "treasurezombieseen", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "treasurezombieseen2", "treasurezombieseen2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "treasurezombiemove1", "treasurezombiemove", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "treasurezombiemove2", "treasurezombiemove2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "treasurezombiefail1", "treasurezombiefail", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "treasurezombiefail2", "treasurezombiefail2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "treasurezombiewarn1", "treasurezombiewarn", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "treasurezombiewarn2", "treasurezombiewarn2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "treasurezombiewin1", "treasurezombiewin", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "treasurezombiewin2", "treasurezombiewin2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "bombersee1", "bombersee", undefined, 5);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "bombersee2", "bombersee2", undefined, 5);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "bomberkillshot1", "bomberskillshot", undefined, 25);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "sprintersee1", "sprintersee", undefined, 1);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "followersurpise1", "followersurpise", undefined, 25);
  level._id_A62B _id_054E::_id_AB1A("player", "enemy", "followeranger1", "lookout", undefined, 25);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_first1", "vendingfirsttime", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_first2", "vendingfirsttime2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_shock1", "blitzshock", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_shock2", "blitzshock2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_punch1", "blitzpunch", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_punch2", "blitzpunch2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_revive", "blitzrevive", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_revive1", "blitzrevive2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_reload", "blitzreload", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_reload1", "blitzreload2", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_run", "blitzrun", undefined);
  level._id_A62B _id_054E::_id_AB1A("player", "perk", "perk_damage", "blitzdamage", undefined);
}

initwavestories() {
  level.wavestories = wavestoriescreate();
  common_scripts\utility::flag_init("radio_message_active");
}

wavestoriescreate() {
  var_0 = spawnStruct();
  var_0.stories = [];
  var_0.story_playing = 0;
  return var_0;
}

addwavestory(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || isDefined(var_0) && var_0.size <= 0) {
    return;
  }
  if(!isDefined(var_3)) {
    var_3 = level._id_071D._id_7501;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_4 = 0;

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
  } else {
    var_4 = level.wavestories.stories.size;
    var_5 = level.wavestories;
  }

  var_5.stories[var_4] = spawnStruct();
  var_5.stories[var_4]._id_7215 = 0;
  var_5.stories[var_4].require_all_present = var_1;
  var_5.stories[var_4]._id_5D99 = [];

  foreach(var_7 in var_0) {
    var_8 = var_5.stories[var_4]._id_5D99.size;
    var_5.stories[var_4]._id_5D99[var_8] = spawnStruct();
    var_9 = _func_36D(var_7[0], var_3);
    var_10 = strtok(var_9, "_");
    var_5.stories[var_4]._id_5D99[var_8]._id_90BE = var_10[0];
    var_5.stories[var_4]._id_5D99[var_8]._id_0BB4 = var_7[0];

    if(isDefined(var_7[1])) {
      var_5.stories[var_4]._id_5D99[var_8].post_delay = var_7[1];
      continue;
    }

    var_5.stories[var_4]._id_5D99[var_8].post_delay = 1;
  }

  return var_5.stories[var_4];
}

play_wave_story(var_0) {
  if(_isarray(var_0)) {
    var_1 = var_0[0];
    var_2 = var_0[1];
    var_3 = var_0[2];
  } else {
    var_1 = -1;
    var_2 = undefined;
    var_3 = undefined;
  }

  if(isDefined(var_2)) {
    try_run_conversation(var_3);
  } else {
    if(var_1 >= 0) {
      playnextwavestory(0, var_1);
      return;
    }

    for(var_4 = 0; var_4 < level.wavestories.stories.size; var_4++) {
      playnextwavestory(0, var_4);
    }
  }
}

playnextwavestory(var_0, var_1, var_2) {
  if(!isDefined(level.currentwavestoryindex)) {
    level.currentwavestoryindex = 0;
  }

  var_3 = level.currentwavestoryindex;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = level.wavestories.stories[var_3];

  if(!isDefined(var_4)) {
    return;
  }
  if(!should_play_a_wave_story()) {
    if(isDefined(var_2)) {
      level thread[[common_scripts\utility::random(var_2)]]();
    }

    return;
  }

  try_run_conversation(var_4);
}

should_play_a_wave_story(var_0) {
  if(level.wavestories.story_playing) {
    return 0;
  }

  if(intense_objective_active(var_0)) {
    return 0;
  }

  if(zombie_wave_maxed()) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(level._id_AC21)) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(var_0)) {
    return 1;
  }

  if(players_already_talking()) {
    return 0;
  }

  return 1;
}

zombie_wave_maxed() {
  return maps\mp\mp_zombie_nest_ee_wave_manipulation::is_zombie_wave_maxed();
}

players_already_talking() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::_id_562E(var_1._id_57DE)) {
      return 1;
    }
  }

  return 0;
}

intense_objective_add(var_0) {
  level.high_intensity_objectives[level.high_intensity_objectives.size] = var_0;
}

intense_objective_active(var_0) {
  var_1 = _id_0557::_id_7837();

  if(common_scripts\utility::_id_562E(var_0)) {
    return 0;
  } else {
    foreach(var_3 in level.high_intensity_objectives) {
      if(issubstr(var_1, var_3)) {
        return 1;
      }
    }
  }

  return 0;
}

try_run_conversation(var_0, var_1, var_2, var_3) {
  if(!validate_players_in_story(var_0)) {
    if(common_scripts\utility::_id_562E(var_3)) {
      wait 5.5;
    }

    return 0;
  }

  if(!isDefined(level.currentwavestoryindex)) {
    level.currentwavestoryindex = 0;
  }

  level.wavestories.story_playing = 1;
  level.currentwavestoryindex++;
  var_4 = 0;
  level endon("story_timed_out");
  level endon("story_interrupt");

  if(isDefined(var_2)) {
    level thread timeout_conversation(var_2);
  }

  foreach(var_6 in var_0._id_5D99) {
    var_7 = var_6._id_90BE;
    var_8 = undefined;
    var_9 = 0;
    var_10 = 0;

    foreach(var_12 in level.players) {
      if(isDefined(var_12._id_20D8)) {
        var_13 = _id_0378::_id_307B(var_12._id_20D8);

        if(var_13 == var_7) {
          var_8 = var_12;
          var_9 = 1;
          var_10 = get_speaker_alive(var_12);
          break;
        }
      }
    }

    var_15 = undefined;

    if(var_10 && isDefined(var_8)) {
      var_16 = gettime();
      var_8 _id_0378::_id_307E(var_6._id_0BB4, level.players, undefined, var_1);
    } else if(isDefined(var_8))
      var_8 _id_0378::_id_307E(var_6._id_0BB4, level.players, undefined, var_1);

    wait(var_6.post_delay);
  }

  level notify("story_delievered");
  level.wavestories.story_playing = 0;
  return 1;
}

timeout_conversation(var_0) {
  level endon("story_delievered");
  level endon("story_interrupt");
  wait(var_0);
  level notify("story_timed_out");
  level.wavestories.story_playing = 0;
}

radio_message_all(var_0) {
  foreach(var_2 in level.players) {
    var_2 thread plr_play_radio_message(var_0);
  }
}

plr_play_radio_message(var_0) {
  wait_for_radio_message_done(var_0);
  common_scripts\utility::flag_set("radio_message_active");
}

wait_for_radio_message_done(var_0) {
  level endon("radio_message_active");
  _id_0378::_id_307E(var_0._id_0BB4, self, undefined, 0);
}

get_speaker_alive(var_0) {
  if(_id_0547::_id_57E1(var_0)) {
    return 0;
  }

  if(var_0.sessionstate == "spectator") {
    return 0;
  }

  return 1;
}

validate_players_in_story(var_0) {
  if(common_scripts\utility::_id_562E(var_0.require_all_present)) {
    var_1 = var_0 get_expected_characters();
    var_2 = get_all_alive_player_character_names();

    foreach(var_4 in var_1) {
      if(!common_scripts\utility::_id_0F79(var_2, var_4)) {
        return 0;
      }
    }
  }

  return 1;
}

is_character_present(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(_id_0378::_id_307B(var_3._id_20D8) == var_0) {
      if(common_scripts\utility::_id_562E(var_1) && !get_speaker_alive(var_3)) {
        return 0;
      } else {
        return 1;
      }
    }
  }

  return 0;
}

get_all_alive_player_character_names() {
  var_0 = [];

  foreach(var_2 in level.players) {
    var_3 = "";

    switch (var_2._id_20D8) {
      case 0:
        var_3 = "jeff";
        break;
      case 1:
        var_3 = "dros";
        break;
      case 2:
        var_3 = "mari";
        break;
      case 3:
        var_3 = "oliv";
        break;
      case 28:
      case 12:
      case 11:
      case 10:
      case 4:
        var_3 = "hunt";
        break;
      case 29:
      case 15:
      case 14:
      case 13:
      case 5:
        var_3 = "mount";
        break;
      case 30:
      case 18:
      case 17:
      case 16:
      case 6:
        var_3 = "surv";
        break;
      case 7:
        var_3 = "bata";
        break;
      case 8:
        var_3 = "ride";
        break;
      case 31:
      case 21:
      case 20:
      case 19:
      case 9:
        var_3 = "slay";
        break;
    }

    if(!isDefined(var_3)) {
      var_3 = "custom";
    }

    var_0 = common_scripts\utility::_id_0F6F(var_0, var_3);
  }

  return var_0;
}

get_expected_characters() {
  var_0 = [];

  foreach(var_2 in self._id_5D99) {
    var_0 = common_scripts\utility::_id_0F6F(var_0, var_2._id_90BE);
  }

  return var_0;
}