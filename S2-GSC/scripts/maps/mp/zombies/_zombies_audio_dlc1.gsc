/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_audio_dlc1.gsc
***********************************************************/

initdlc1audio() {
  level._id_0793 = ::initleveldialog;
}

initleveldialog() {
  level.vox _id_054E::zmbvoxadd("player", "ability", "special_camo1", "camouflage", undefined);
  level.vox _id_054E::zmbvoxadd("player", "ability", "special_camo2", "camouflage2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "ability", "special_mad1", "freefire", undefined);
  level.vox _id_054E::zmbvoxadd("player", "ability", "special_mad2", "freefire2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "ability", "special_taunt1", "frontline", undefined);
  level.vox _id_054E::zmbvoxadd("player", "ability", "special_taunt2", "frontline2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "ability", "special_burst1", "shellshock", undefined);
  level.vox _id_054E::zmbvoxadd("player", "ability", "special_burst2", "shellshock2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "ability", "special_burst3", "shellshock3", undefined);
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_supplyammo1", "supplyammomod", "thanks");
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_supplyammo2", "supplyammomod2", "thanks");
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_headshot1", "headshotmod", "mod_headshot_reply");
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_headshot2", "headshotmod2", "mod_headshot_reply");
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_serratededge1", "serreatededgemod", undefined);
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_serratededge2", "serreatededgemod2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_covertexfiltration1", "covertexfilration", "revived");
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_covertexfiltration2", "covertexfilration2", "revived");
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_fieryburst1", "fieryburstmod", undefined);
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_fieryburst2", "fieryburstmod2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_comeandgetit1", "comeandgetitmod", undefined);
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_comeandgetit2", "comeandgetitmod2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_teameffort1", "teameffort", undefined);
  level.vox _id_054E::zmbvoxadd("player", "mod_use", "mod_teameffort2", "teameffort2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "general", "revive_ally1", "modrevived", "revived");
  level.vox _id_054E::zmbvoxadd("player", "general", "revive_ally2", "modrevived2", "revived");
  level.vox _id_054E::zmbvoxadd("player", "general", "revived1", "modrevived_reply", undefined);
  level.vox _id_054E::zmbvoxadd("player", "general", "revived2", "modrevived_reply2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "general", "give_money1", "givemoney", undefined, 25);
  level.vox _id_054E::zmbvoxadd("player", "general", "give_money2", "givemoney2", undefined, 25);
  level.vox _id_054E::zmbvoxadd("player", "general", "weaponreminder", "weaponreminder", undefined);
  level.vox _id_054E::zmbvoxadd("player", "general", "weaponreminder2", "weaponreminder2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "general", "got_item3", "givemoney_reply", undefined);
  level.vox _id_054E::zmbvoxadd("player", "general", "got_item4", "givemoney_reply2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "general", "lost_and_found", "lostandfound", undefined);
  level.vox _id_054E::zmbvoxadd("player", "general", "lost_and_found1", "lostandfound2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "general", "needmoney1", "not_enough_jolt", undefined);
  level.vox _id_054E::zmbvoxadd("player", "general", "needmoney2", "not_enough_jolt2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "general", "newweapon", "newweapon", undefined, 40);
  level.vox _id_054E::zmbvoxadd("player", "general", "newweapon1", "newweapon2", undefined, 40);
  level.vox _id_054E::zmbvoxadd("player", "general", "newweapon2", "newweapon3", undefined, 40);
  level.vox _id_054E::zmbvoxadd("player", "general", "newpackweapon", "newpackweapon", undefined, 50);
  level.vox _id_054E::zmbvoxadd("player", "general", "newpackweapon2", "newpackweapon2", undefined, 50);
  level.vox _id_054E::zmbvoxadd("player", "general", "newpackweapon3", "newpackweapon3", undefined, 50);
  level.vox _id_054E::zmbvoxadd("player", "general", "newpackweapon4", "teslafired", undefined, 50);
  level.vox _id_054E::zmbvoxadd("player", "general", "reloading", "reloading", undefined, 5);
  level.vox _id_054E::zmbvoxadd("player", "general", "consumableweapon", "consumableweapon", undefined, 75);
  level.vox _id_054E::zmbvoxadd("player", "general", "consumableweapon2", "consumableweapon2", undefined, 75);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "treasurezombieseen1", "treasurezombieseen", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "treasurezombieseen2", "treasurezombieseen2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "treasurezombiemove1", "treasurezombiemove", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "treasurezombiemove2", "treasurezombiemove2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "treasurezombiefail1", "treasurezombiefail", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "treasurezombiefail2", "treasurezombiefail2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "treasurezombiewarn1", "treasurezombiewarn", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "treasurezombiewarn2", "treasurezombiewarn2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "treasurezombiewin1", "treasurezombiewin", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "treasurezombiewin2", "treasurezombiewin2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "bombersee1", "bombersee", undefined, 5);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "bombersee2", "bombersee2", undefined, 5);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "bomberkillshot1", "bomberskillshot", undefined, 25);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "sprintersee1", "sprintersee", undefined, 1);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "followersurpise1", "followersurpise", undefined, 25);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "followeranger1", "lookout", undefined, 25);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "assassinnearby", "assassinnearby", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "assassinnearby2", "assassinnearby2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "assassinnearby3", "assassinnearby3", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "assassinsee", "assassinsee", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "assassinsee2", "assassinsee2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "assassinsee3", "assassinsee3", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "assassinhides", "assassinhides", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "assassinhides2", "assassinhides2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "assassinhides3", "assassinhides3", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassinsee", "eliteassassinsee", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassinhides", "eliteassassinhides", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassinhides2", "eliteassassinhides2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassinhides3", "eliteassassinhides3", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyfrontline", "enemyfrontline_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyfrontlineshielded", "enemyfrontlineshielded_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyfrontlineshielded2", "enemyfrontlineshielded2_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyfrontlineshielded3", "enemyfrontlineshielded3_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyfrontlineattacked", "enemyfrontlineattacked_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyfrontlineattacked2", "enemyfrontlineattacked2_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyfrontlineattacked3", "enemyfrontlineattacked3_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassinappear", "eliteassassinappear_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassinappear2", "eliteassassinappear2_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassinappear3", "eliteassassinappear3_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyshellshock", "enemyshellshock_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyshellshock2", "enemyshellshock2_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyshellshockfire", "enemyshellshockfire_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyshellshockfire2", "enemyshellshockfire2_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "anothereliteassassin", "anothereliteassassin_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "anothereliteassassin2", "anothereliteassassin2_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyfreefire", "enemyfreefire_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyfreefire2", "enemyfreefire2_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "enemyfreefire3", "enemyfreefire3_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassinfoglifts", "eliteassassinfoglifts", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassindie", "eliteassassindie_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassindieoneleft", "eliteassassindieoneleft_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassindieoneleft3", "eliteassassindieoneleft2_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "enemy", "eliteassassindieoneleft3", "eliteassassindieoneleft3_hi", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_first1", "vendingfirsttime", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_first2", "vendingfirsttime2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_shock1", "blitzshock", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_shock2", "blitzshock2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_punch1", "blitzpunch", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_punch2", "blitzpunch2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_revive", "blitzrevive", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_revive1", "blitzrevive2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_reload", "blitzreload", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_reload1", "blitzreload2", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_run", "blitzrun", undefined);
  level.vox _id_054E::zmbvoxadd("player", "perk", "perk_damage", "blitzdamage", undefined);
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

addwavestory(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0) && var_0.size <= 0) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_3 = 0;

  if(isDefined(var_2)) {
    var_4 = spawnStruct();
  } else {
    var_3 = level.wavestories.stories.size;
    var_4 = level.wavestories;
  }

  var_4.stories[var_3] = spawnStruct();
  var_4.stories[var_3]._id_7215 = 0;
  var_4.stories[var_3].require_all_present = var_1;
  var_4.stories[var_3].lines = [];

  foreach(var_6 in var_0) {
    var_7 = var_4.stories[var_3].lines.size;
    var_4.stories[var_3].lines[var_7] = spawnStruct();
    var_8 = _func_36D(var_6[0], level._id_071D._id_7501);
    var_9 = strtok(var_8, "_");
    var_4.stories[var_3].lines[var_7].speaker = var_9[0];
    var_4.stories[var_3].lines[var_7]._id_0BB4 = var_6[0];

    if(isDefined(var_6[1])) {
      var_4.stories[var_3].lines[var_7].post_delay = var_6[1];
      continue;
    }

    var_4.stories[var_3].lines[var_7].post_delay = 1;
  }

  return var_4.stories[var_3];
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
    if(common_scripts\utility::_id_562E(var_1.isspeaking)) {
      return 1;
    }
  }

  return 0;
}

intense_objective_active(var_0) {
  var_1 = _id_0557::_id_7837();
  var_2 = [];

  if(common_scripts\utility::_id_562E(var_0)) {} else {
    var_2[var_2.size] = "Survive the Beach";
    var_2[var_2.size] = "Open Corpse Gate";
    var_2[var_2.size] = "Defend Flak Tower";
    var_2[var_2.size] = "Destroy 2nd Destroyer";
    var_2[var_2.size] = "Final Boss Island";
  }

  foreach(var_4 in var_2) {
    if(issubstr(var_1, var_4)) {
      return 1;
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

  if(isDefined(var_2)) {
    level thread timeout_conversation(var_2);
  }

  foreach(var_6 in var_0.lines) {
    var_7 = var_6.speaker;
    var_8 = undefined;
    var_9 = 0;
    var_10 = 0;

    foreach(var_12 in level.players) {
      if(isDefined(var_12.characterindex)) {
        var_13 = _id_0378::_id_307B(var_12.characterindex);

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
    } else
      var_8 _id_0378::_id_307E(var_6._id_0BB4, level.players, undefined, var_1);

    wait(var_6.post_delay);
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

get_all_alive_player_character_names() {
  var_0 = [];

  foreach(var_2 in level.players) {
    var_3 = "";

    switch (var_2.characterindex) {
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

  foreach(var_2 in self.lines) {
    var_0 = common_scripts\utility::_id_0F6F(var_0, var_2.speaker);
  }

  return var_0;
}