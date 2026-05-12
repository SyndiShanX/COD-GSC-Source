/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_audio_dlc2.gsc
***************************************************/

initdlc2audio() {
  level.var_793 = ::initleveldialog;
  level.high_intensity_objectives = [];
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

addwavestory(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00) || isDefined(param_00) && param_00.size <= 0) {
    return;
  }

  if(!isDefined(param_03)) {
    param_03 = level.var_71D.var_7501;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_04 = 0;
  if(isDefined(param_02)) {
    var_05 = spawnStruct();
  } else {
    var_05 = level.wavestories.stories.size;
    var_05 = level.wavestories;
  }

  var_05.stories[var_04] = spawnStruct();
  var_05.stories[var_04].var_7215 = 0;
  var_05.stories[var_04].require_all_present = param_01;
  var_05.stories[var_04].var_5D99 = [];
  foreach(var_07 in param_00) {
    var_08 = var_05.stories[var_04].var_5D99.size;
    var_05.stories[var_04].var_5D99[var_08] = spawnStruct();
    var_09 = function_036D(var_07[0], param_03);
    var_0A = strtok(var_09, "_");
    var_05.stories[var_04].var_5D99[var_08].var_90BE = var_0A[0];
    var_05.stories[var_04].var_5D99[var_08].var_BB4 = var_07[0];
    if(isDefined(var_07[1])) {
      var_05.stories[var_04].var_5D99[var_08].post_delay = var_07[1];
      continue;
    }

    var_05.stories[var_04].var_5D99[var_08].post_delay = 1;
  }

  return var_05.stories[var_04];
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
  return maps\mp\mp_zombie_nest_ee_wave_manipulation::is_zombie_wave_maxed();
}

players_already_talking() {
  foreach(var_01 in level.var_744A) {
    if(common_scripts\utility::func_562E(var_01.var_57DE)) {
      return 1;
    }
  }

  return 0;
}

intense_objective_add(param_00) {
  level.high_intensity_objectives[level.high_intensity_objectives.size] = param_00;
}

intense_objective_active(param_00) {
  var_01 = lib_0557::func_7837();
  if(common_scripts\utility::func_562E(param_00)) {
    return 0;
  } else {
    foreach(var_03 in level.high_intensity_objectives) {
      if(issubstr(var_01, var_03)) {
        return 1;
      }
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
  level endon("story_interrupt");
  if(isDefined(param_02)) {
    level thread timeout_conversation(param_02);
  }

  foreach(var_06 in param_00.var_5D99) {
    var_07 = var_06.var_90BE;
    var_08 = undefined;
    var_09 = 0;
    var_0A = 0;
    foreach(var_0C in level.var_744A) {
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
      var_08 lib_0378::func_307E(var_06.var_BB4, level.var_744A, undefined, param_01);
    } else if(isDefined(var_08)) {
      var_08 lib_0378::func_307E(var_06.var_BB4, level.var_744A, undefined, param_01);
    }

    wait(var_06.post_delay);
  }

  level notify("story_delievered");
  level.wavestories.story_playing = 0;
  return 1;
}

timeout_conversation(param_00) {
  level endon("story_delievered");
  level endon("story_interrupt");
  wait(param_00);
  level notify("story_timed_out");
  level.wavestories.story_playing = 0;
}

radio_message_all(param_00) {
  foreach(var_02 in level.var_744A) {
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

  if(param_00.var_178 == "spectator") {
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

is_character_present(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    if(lib_0378::func_307B(var_03.var_20D8) == param_00) {
      if(common_scripts\utility::func_562E(param_01) && !get_speaker_alive(var_03)) {
        return 0;
      } else {
        return 1;
      }
    }
  }

  return 0;
}

get_all_alive_player_character_names() {
  var_00 = [];
  foreach(var_02 in level.var_744A) {
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

      case 28:
      case 12:
      case 11:
      case 10:
      case 4:
        var_03 = "hunt";
        break;

      case 29:
      case 15:
      case 14:
      case 13:
      case 5:
        var_03 = "mount";
        break;

      case 30:
      case 18:
      case 17:
      case 16:
      case 6:
        var_03 = "surv";
        break;

      case 7:
        var_03 = "bata";
        break;

      case 8:
        var_03 = "ride";
        break;

      case 31:
      case 21:
      case 20:
      case 19:
      case 9:
        var_03 = "slay";
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