/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_audio_dlc1.gsc
***************************************************/

initdlc1audio() {
  level.var_793 = ::initleveldialog;
}

initleveldialog() {
  level.var_A62B lib_054E::func_AB1A("player", "ability", "special_camo1", "camouflage", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "ability", "special_camo2", "camouflage2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "ability", "special_mad1", "freefire", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "ability", "special_mad2", "freefire2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "ability", "special_taunt1", "frontline", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "ability", "special_taunt2", "frontline2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "ability", "special_burst1", "shellshock", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "ability", "special_burst2", "shellshock2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "ability", "special_burst3", "shellshock3", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_supplyammo1", "supplyammomod", "thanks");
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_supplyammo2", "supplyammomod2", "thanks");
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_headshot1", "headshotmod", "mod_headshot_reply");
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_headshot2", "headshotmod2", "mod_headshot_reply");
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_serratededge1", "serreatededgemod", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_serratededge2", "serreatededgemod2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_covertexfiltration1", "covertexfilration", "revived");
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_covertexfiltration2", "covertexfilration2", "revived");
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_fieryburst1", "fieryburstmod", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_fieryburst2", "fieryburstmod2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_comeandgetit1", "comeandgetitmod", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_comeandgetit2", "comeandgetitmod2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_teameffort1", "teameffort", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "mod_use", "mod_teameffort2", "teameffort2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "general", "revive_ally1", "modrevived", "revived");
  level.var_A62B lib_054E::func_AB1A("player", "general", "revive_ally2", "modrevived2", "revived");
  level.var_A62B lib_054E::func_AB1A("player", "general", "revived1", "modrevived_reply", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "general", "revived2", "modrevived_reply2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "general", "give_money1", "givemoney", undefined, 25);
  level.var_A62B lib_054E::func_AB1A("player", "general", "give_money2", "givemoney2", undefined, 25);
  level.var_A62B lib_054E::func_AB1A("player", "general", "weaponreminder", "weaponreminder", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "general", "weaponreminder2", "weaponreminder2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "general", "got_item3", "givemoney_reply", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "general", "got_item4", "givemoney_reply2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "general", "lost_and_found", "lostandfound", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "general", "lost_and_found1", "lostandfound2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "general", "needmoney1", "not_enough_jolt", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "general", "needmoney2", "not_enough_jolt2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "general", "newweapon", "newweapon", undefined, 40);
  level.var_A62B lib_054E::func_AB1A("player", "general", "newweapon1", "newweapon2", undefined, 40);
  level.var_A62B lib_054E::func_AB1A("player", "general", "newweapon2", "newweapon3", undefined, 40);
  level.var_A62B lib_054E::func_AB1A("player", "general", "newpackweapon", "newpackweapon", undefined, 50);
  level.var_A62B lib_054E::func_AB1A("player", "general", "newpackweapon2", "newpackweapon2", undefined, 50);
  level.var_A62B lib_054E::func_AB1A("player", "general", "newpackweapon3", "newpackweapon3", undefined, 50);
  level.var_A62B lib_054E::func_AB1A("player", "general", "newpackweapon4", "teslafired", undefined, 50);
  level.var_A62B lib_054E::func_AB1A("player", "general", "reloading", "reloading", undefined, 5);
  level.var_A62B lib_054E::func_AB1A("player", "general", "consumableweapon", "consumableweapon", undefined, 75);
  level.var_A62B lib_054E::func_AB1A("player", "general", "consumableweapon2", "consumableweapon2", undefined, 75);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "treasurezombieseen1", "treasurezombieseen", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "treasurezombieseen2", "treasurezombieseen2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "treasurezombiemove1", "treasurezombiemove", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "treasurezombiemove2", "treasurezombiemove2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "treasurezombiefail1", "treasurezombiefail", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "treasurezombiefail2", "treasurezombiefail2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "treasurezombiewarn1", "treasurezombiewarn", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "treasurezombiewarn2", "treasurezombiewarn2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "treasurezombiewin1", "treasurezombiewin", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "treasurezombiewin2", "treasurezombiewin2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "bombersee1", "bombersee", undefined, 5);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "bombersee2", "bombersee2", undefined, 5);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "bomberkillshot1", "bomberskillshot", undefined, 25);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "sprintersee1", "sprintersee", undefined, 1);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "followersurpise1", "followersurpise", undefined, 25);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "followeranger1", "lookout", undefined, 25);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "assassinnearby", "assassinnearby", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "assassinnearby2", "assassinnearby2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "assassinnearby3", "assassinnearby3", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "assassinsee", "assassinsee", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "assassinsee2", "assassinsee2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "assassinsee3", "assassinsee3", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "assassinhides", "assassinhides", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "assassinhides2", "assassinhides2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "assassinhides3", "assassinhides3", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassinsee", "eliteassassinsee", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassinhides", "eliteassassinhides", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassinhides2", "eliteassassinhides2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassinhides3", "eliteassassinhides3", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyfrontline", "enemyfrontline_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyfrontlineshielded", "enemyfrontlineshielded_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyfrontlineshielded2", "enemyfrontlineshielded2_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyfrontlineshielded3", "enemyfrontlineshielded3_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyfrontlineattacked", "enemyfrontlineattacked_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyfrontlineattacked2", "enemyfrontlineattacked2_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyfrontlineattacked3", "enemyfrontlineattacked3_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassinappear", "eliteassassinappear_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassinappear2", "eliteassassinappear2_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassinappear3", "eliteassassinappear3_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyshellshock", "enemyshellshock_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyshellshock2", "enemyshellshock2_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyshellshockfire", "enemyshellshockfire_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyshellshockfire2", "enemyshellshockfire2_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "anothereliteassassin", "anothereliteassassin_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "anothereliteassassin2", "anothereliteassassin2_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyfreefire", "enemyfreefire_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyfreefire2", "enemyfreefire2_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "enemyfreefire3", "enemyfreefire3_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassinfoglifts", "eliteassassinfoglifts", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassindie", "eliteassassindie_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassindieoneleft", "eliteassassindieoneleft_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassindieoneleft3", "eliteassassindieoneleft2_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "enemy", "eliteassassindieoneleft3", "eliteassassindieoneleft3_hi", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_first1", "vendingfirsttime", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_first2", "vendingfirsttime2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_shock1", "blitzshock", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_shock2", "blitzshock2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_punch1", "blitzpunch", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_punch2", "blitzpunch2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_revive", "blitzrevive", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_revive1", "blitzrevive2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_reload", "blitzreload", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_reload1", "blitzreload2", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_run", "blitzrun", undefined);
  level.var_A62B lib_054E::func_AB1A("player", "perk", "perk_damage", "blitzdamage", undefined);
}

initwavestories() {
  level.wavestories = wavestoriescreate();
  common_scripts\utility::func_3C87("radio_message_active");
}

wavestoriescreate() {
  var_00 = spawnStruct();
  var_00.stories = [];
  var_00.story_playing = 0;
  return var_00;
}

addwavestory(param_00, param_01, param_02) {
  if(!isDefined(param_00) || isDefined(param_00) && param_00.size <= 0) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_03 = 0;
  if(isDefined(param_02)) {
    var_04 = spawnStruct();
  } else {
    var_04 = level.wavestories.stories.size;
    var_04 = level.wavestories;
  }

  var_04.stories[var_03] = spawnStruct();
  var_04.stories[var_03].var_7215 = 0;
  var_04.stories[var_03].require_all_present = param_01;
  var_04.stories[var_03].var_5D99 = [];
  foreach(var_06 in param_00) {
    var_07 = var_04.stories[var_03].var_5D99.size;
    var_04.stories[var_03].var_5D99[var_07] = spawnStruct();
    var_08 = function_036D(var_06[0], level.var_71D.var_7501);
    var_09 = strtok(var_08, "_");
    var_04.stories[var_03].var_5D99[var_07].var_90BE = var_09[0];
    var_04.stories[var_03].var_5D99[var_07].var_BB4 = var_06[0];
    if(isDefined(var_06[1])) {
      var_04.stories[var_03].var_5D99[var_07].post_delay = var_06[1];
      continue;
    }

    var_04.stories[var_03].var_5D99[var_07].post_delay = 1;
  }

  return var_04.stories[var_03];
}

play_wave_story(param_00) {
  if(isarray(param_00)) {
    var_01 = param_00[0];
    var_02 = param_00[1];
    var_03 = param_00[2];
  } else {
    var_01 = -1;
    var_02 = undefined;
    var_03 = undefined;
  }

  if(isDefined(var_02)) {
    try_run_conversation(var_03);
    return;
  }

  if(var_01 >= 0) {
    playnextwavestory(0, var_01);
    return;
  }

  for(var_04 = 0; var_04 < level.wavestories.stories.size; var_04++) {
    playnextwavestory(0, var_04);
  }
}

playnextwavestory(param_00, param_01, param_02) {
  if(!isDefined(level.currentwavestoryindex)) {
    level.currentwavestoryindex = 0;
  }

  var_03 = level.currentwavestoryindex;
  if(isDefined(param_01)) {
    var_03 = param_01;
  }

  var_04 = level.wavestories.stories[var_03];
  if(!isDefined(var_04)) {
    return;
  }

  if(!should_play_a_wave_story()) {
    if(isDefined(param_02)) {
      level thread[[common_scripts\utility::func_7A33(param_02)]]();
    }

    return;
  }

  try_run_conversation(var_04);
}

should_play_a_wave_story(param_00) {
  if(level.wavestories.story_playing) {
    return 0;
  }

  if(intense_objective_active(param_00)) {
    return 0;
  }

  if(zombie_wave_maxed()) {
    return 0;
  }

  if(common_scripts\utility::func_562E(level.var_AC21)) {
    return 0;
  }

  if(common_scripts\utility::func_562E(param_00)) {
    return 1;
  }

  if(players_already_talking()) {
    return 0;
  }

  return 1;
}

zombie_wave_maxed() {
  return maps / mp / mp_zombie_nest_ee_wave_manipulation::is_zombie_wave_maxed();
}

players_already_talking() {
  foreach(var_01 in level.players) {
    if(common_scripts\utility::func_562E(var_01.var_57DE)) {
      return 1;
    }
  }

  return 0;
}

intense_objective_active(param_00) {
  var_01 = lib_0557::func_7837();
  var_02 = [];
  if(common_scripts\utility::func_562E(param_00)) {} else {
    var_02[var_02.size] = "Survive the Beach";
    var_02[var_02.size] = "Open Corpse Gate";
    var_02[var_02.size] = "Defend Flak Tower";
    var_02[var_02.size] = "Destroy 2nd Destroyer";
    var_02[var_02.size] = "Final Boss Island";
  }

  foreach(var_04 in var_02) {
    if(issubstr(var_01, var_04)) {
      return 1;
    }
  }

  return 0;
}

try_run_conversation(param_00, param_01, param_02, param_03) {
  if(!validate_players_in_story(param_00)) {
    if(common_scripts\utility::func_562E(param_03)) {
      wait(5.5);
    }

    return 0;
  }

  if(!isDefined(level.currentwavestoryindex)) {
    level.currentwavestoryindex = 0;
  }

  level.wavestories.story_playing = 1;
  level.currentwavestoryindex++;
  var_04 = 0;
  level endon("story_timed_out");
  if(isDefined(param_02)) {
    level thread timeout_conversation(param_02);
  }

  foreach(var_06 in param_00.var_5D99) {
    var_07 = var_06.var_90BE;
    var_08 = undefined;
    var_09 = 0;
    var_0A = 0;
    foreach(var_0C in level.players) {
      if(isDefined(var_0C.var_20D8)) {
        var_0D = lib_0378::func_307B(var_0C.var_20D8);
        if(var_0D == var_07) {
          var_08 = var_0C;
          var_09 = 1;
          var_0A = get_speaker_alive(var_0C);
          break;
        }
      }
    }

    var_0F = undefined;
    if(var_0A && isDefined(var_08)) {
      var_10 = gettime();
      var_08 lib_0378::func_307E(var_06.var_BB4, level.players, undefined, param_01);
    } else {
      var_08 lib_0378::func_307E(var_06.var_BB4, level.players, undefined, param_01);
    }

    wait(var_06.post_delay);
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

radio_message_all(param_00) {
  foreach(var_02 in level.players) {
    var_02 thread plr_play_radio_message(param_00);
  }
}

plr_play_radio_message(param_00) {
  wait_for_radio_message_done(param_00);
  common_scripts\utility::func_3C8F("radio_message_active");
}

wait_for_radio_message_done(param_00) {
  level endon("radio_message_active");
  lib_0378::func_307E(param_00.var_BB4, self, undefined, 0);
}

get_speaker_alive(param_00) {
  if(lib_0547::func_57E1(param_00)) {
    return 0;
  }

  if(param_00.sessionstate == "spectator") {
    return 0;
  }

  return 1;
}

validate_players_in_story(param_00) {
  if(common_scripts\utility::func_562E(param_00.require_all_present)) {
    var_01 = param_00 get_expected_characters();
    var_02 = get_all_alive_player_character_names();
    foreach(var_04 in var_01) {
      if(!common_scripts\utility::func_F79(var_02, var_04)) {
        return 0;
      }
    }
  }

  return 1;
}

get_all_alive_player_character_names() {
  var_00 = [];
  foreach(var_02 in level.players) {
    var_03 = "";
    switch (var_02.var_20D8) {
      case 0:
        var_03 = "jeff";
        break;

      case 1:
        var_03 = "dros";
        break;

      case 2:
        var_03 = "mari";
        break;

      case 3:
        var_03 = "oliv";
        break;
    }

    if(!isDefined(var_03)) {
      var_03 = "custom";
    }

    var_00 = common_scripts\utility::func_F6F(var_00, var_03);
  }

  return var_00;
}

get_expected_characters() {
  var_00 = [];
  foreach(var_02 in self.var_5D99) {
    var_00 = common_scripts\utility::func_F6F(var_00, var_02.var_90BE);
  }

  return var_00;
}