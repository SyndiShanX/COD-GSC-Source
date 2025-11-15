/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\achievement.gsc
**********************************************/

init_player_achievement(param_00) {
  level.include_default_achievements = 1;
  level.cp_zmb_number_of_quest_pieces = 24;
  if(isDefined(level.script)) {
    switch (level.script) {
      case "cp_zmb":
        param_00.achievement_list = ["STICKER_COLLECTOR", "SOUL_KEY", "THE_BIGGER_THEY_ARE", "HOFF_THE_CHARTS", "ROCK_ON", "GET_PACKED", "BATTERIES_NOT_INCLUDED", "I_LOVE_THE_80_S", "INSERT_COIN", "BRAIN_DEAD"];
        break;

      case "cp_rave":
        param_00.achievement_list = ["LOCKSMITH", "SUPER_SLACKER", "STICK_EM", "HALLUCINATION_NATION", "TABLES_TURNED", "RAVE_ON", "RIDE_FOR_YOUR_LIFE", "SCRAPBOOKING", "PUMP_IT_UP", "TOP_CAMPER"];
        break;

      case "cp_disco":
        param_00.achievement_list = ["BOOK_WORM", "COIN_OP", "BEAT_OF_THE_DRUM", "SLICED_AND_DICED", "PEST_CONTROL", "EXTERMINATOR", "SHAOLIN_SKILLS", "MESSAGE_RECEIVED", "SOUL_BROTHER", "SOME_ASSEMBLY_REQUIRED"];
        break;

      case "cp_town":
        param_00.achievement_list = ["SOUL_LESS", "UNPLEASANT_DREAMS", "MISTRESS_OF_DARK", "QUARTER_MUNCHER", "BAIT_AND_SWITCH", "BELLY_OF_BEAST", "MAD_PROTO", "DEAR_DIARY"];
        break;

      case "cp_final":
        param_00.achievement_list = ["BROKEN_RECORD", "CRACKING_SKULLS", "DOUBLE_FEATURE", "EGG_SLAYER", "ENCRYPT_DECRYPT", "FAILED_MAINTENANCE", "FRIENDS_FOREVER", "MESSAGE_SENT", "SUPER_DUPER_COMBO", "THE_END"];
        break;

      default:
        param_00.achievement_list = ["STICKER_COLLECTOR", "SOUL_KEY", "THE_BIGGER_THEY_ARE", "HOFF_THE_CHARTS", "ROCK_ON", "GET_PACKED", "BATTERIES_NOT_INCLUDED", "I_LOVE_THE_80_S", "INSERT_COIN", "BRAIN_DEAD", "LOCKSMITH", "SUPER_SLACKER", "STICK_EM", "HALLUCINATION_NATION", "TABLES_TURNED", "RAVE_ON", "RIDE_FOR_YOUR_LIFE", "SCRAPBOOKING", "PUMP_IT_UP", "TOP_CAMPER", "BOOK_WORM", "COIN_OP", "BEAT_OF_THE_DRUM", "SLICED_AND_DICED", "PEST_CONTROL", "EXTERMINATOR", "SHAOLIN_SKILLS", "MESSAGE_RECEIVED", "SOUL_BROTHER", "SOME_ASSEMBLY_REQUIRED", "SOUL_LESS", "UNPLEASANT_DREAMS", "MISTRESS_OF_DARK", "QUARTER_MUNCHER", "BAIT_AND_SWITCH", "BELLY_OF_BEAST", "MAD_PROTO", "DEAR_DIARY", "BROKEN_RECORD", "CRACKING_SKULLS", "DOUBLE_FEATURE", "EGG_SLAYER", "ENCRYPT_DECRYPT", "FAILED_MAINTENANCE", "FRIENDS_FOREVER", "MESSAGE_SENT", "SUPER_DUPER_COMBO", "THE_END"];
        break;
    }
  }

  if(isDefined(param_00.achievement_registration_func)) {
    [[param_00.achievement_registration_func]]();
  }
}

register_default_achievements() {
  register_achievement("STICKER_COLLECTOR", 24, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("SOUL_KEY", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("THE_BIGGER_THEY_ARE", 5, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("HOFF_THE_CHARTS", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("ROCK_ON", 1, ::default_init, ::default_should_update, ::at_least_goal);
  register_achievement("GET_PACKED", 1, ::default_init, ::default_should_update, ::at_least_goal);
  register_achievement("BATTERIES_NOT_INCLUDED", 1, ::default_init, ::default_should_update, ::at_least_goal);
  register_achievement("I_LOVE_THE_80_S", 2, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("INSERT_COIN", 20, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("BRAIN_DEAD", 30, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("LOCKSMITH", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("SUPER_SLACKER", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("STICK_EM", 100, ::default_init, ::default_should_update, ::at_least_goal);
  register_achievement("HALLUCINATION_NATION", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("TABLES_TURNED", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("RAVE_ON", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("RIDE_FOR_YOUR_LIFE", 4, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("SCRAPBOOKING", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("PUMP_IT_UP", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("TOP_CAMPER", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("BOOK_WORM", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("COIN_OP", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("BEAT_OF_THE_DRUM", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("SLICED_AND_DICED", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("PEST_CONTROL", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("EXTERMINATOR", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("SHAOLIN_SKILLS", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("MESSAGE_RECEIVED", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("SOUL_BROTHER", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("SOME_ASSEMBLY_REQUIRED", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("SOUL_LESS", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("UNPLEASANT_DREAMS", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("MISTRESS_OF_DARK", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("QUARTER_MUNCHER", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("BAIT_AND_SWITCH", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("BELLY_OF_BEAST", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("MAD_PROTO", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("DEAR_DIARY", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("BROKEN_RECORD", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("CRACKING_SKULLS", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("DOUBLE_FEATURE", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("EGG_SLAYER", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("ENCRYPT_DECRYPT", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("FAILED_MAINTENANCE", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("FRIENDS_FOREVER", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("MESSAGE_SENT", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("SUPER_DUPER_COMBO", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("THE_END", 1, ::default_init, ::default_should_update, ::equal_to_goal);
}

register_achievement(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnStruct();
  var_05[[param_02]](param_01, param_03, param_04);
  self.achievement_list[param_00] = var_05;
}

default_init(param_00, param_01, param_02) {
  self.progress = 0;
  self.objective_icon = param_00;
  self.should_update_func = param_01;
  self.is_goal_reached_func = param_02;
  self.achievement_completed = 0;
}

update_achievement_arcade(param_00, param_01, param_02) {
  if(level.arcade_games_progress.size <= 0 || !scripts\engine\utility::array_contains(level.arcade_games_progress, param_01)) {
    param_00 update_achievement_braindead(param_00, 1, param_02);
    return;
  }

  level.arcade_games_progress = scripts\engine\utility::array_remove(level.arcade_games_progress, param_01);
  foreach(param_00 in level.players) {
    param_00 update_achievement("INSERT_COIN", 1);
  }

  param_00 update_achievement_braindead(param_00, 1, param_02);
}

update_achievement_braindead(param_00, param_01, param_02) {
  if(!isDefined(param_00.number_of_games_played)) {
    param_00.number_of_games_played = 1;
  } else {
    param_00.number_of_games_played++;
  }

  if(param_00.number_of_games_played >= 30 && param_02 >= 10) {
    param_00 update_achievement("BRAIN_DEAD", 30);
  }
}

default_should_update(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  return 1;
}

update_progress(param_00) {
  self.progress = self.progress + param_00;
}

at_least_goal() {
  return self.progress >= self.objective_icon;
}

equal_to_goal() {
  return self.progress == self.objective_icon;
}

is_completed() {
  return self.achievement_completed;
}

mark_completed() {
  self.achievement_completed = 1;
}

is_valid_achievement(param_00) {
  return isDefined(param_00);
}

update_achievement(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(scripts\cp\utility::is_codxp()) {
    return;
  }

  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    return;
  }

  var_0C = self.achievement_list[param_00];
  if(!is_valid_achievement(var_0C)) {
    return;
  }

  if(var_0C is_completed()) {
    return;
  }

  if(scripts\engine\utility::istrue(level.entered_thru_card)) {
    return;
  }

  if(var_0C[[var_0C.should_update_func]](param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B)) {
    var_0C update_progress(param_01);
    if(var_0C[[var_0C.is_goal_reached_func]]()) {
      self giveachievement(param_00);
      var_0C mark_completed();
    }
  }
}

update_achievement_all_players(param_00, param_01) {
  foreach(var_03 in level.players) {
    var_03 update_achievement(param_00, param_01);
  }
}