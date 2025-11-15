/************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\cp_disco_challenges.gsc
************************************************************/

register_default_challenges() {
  scripts\engine\utility::flag_init("pause_challenges");
  scripts\cp\zombies\solo_challenges::register_challenge("tiger_1_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("crane_1_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("snake_1_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("dragon_1_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("tiger_2_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("crane_2_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("snake_2_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("dragon_2_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("tiger_3_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("crane_3_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("snake_3_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("dragon_3_challenge", undefined, 0, ::challenge_success, undefined, ::activate_challenge, ::empty, undefined, ::update_disco_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("challenge_failed", undefined, 0, undefined, undefined, ::scripts\cp\zombies\solo_challenges::default_resetsuccess, ::scripts\cp\zombies\solo_challenges::default_resetsuccess, undefined, undefined);
  scripts\cp\zombies\solo_challenges::register_challenge("challenge_success", undefined, 0, undefined, undefined, ::scripts\cp\zombies\solo_challenges::default_resetsuccess, ::scripts\cp\zombies\solo_challenges::default_resetsuccess, undefined, undefined);
}

activate_challenge(param_00) {
  param_00 scripts\cp\zombies\solo_challenges::default_resetsuccess();
  param_00.current_challenge.current_progress = param_00.kung_fu_progression.challenge_progress[param_00.kung_fu_progression.active_discipline];
  param_00 scripts\cp\zombies\solo_challenges::update_challenge_progress(param_00.current_challenge.current_progress, param_00.current_challenge.objective_icon);
}

update_disco_challenge(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.current_challenge.current_progress = self.current_challenge.current_progress + param_00;
  if(self.current_challenge.current_progress >= self.current_challenge.objective_icon) {
    self.current_challenge.success = 1;
  }

  scripts\cp\zombies\solo_challenges::update_challenge_progress(self.current_challenge.current_progress, self.current_challenge.objective_icon);
  if(self.current_challenge.success) {
    self notify("current_challenge_ended");
    scripts\cp\zombies\solo_challenges::deactivate_current_challenge(self);
    self.current_player_challenge = undefined;
    return;
  }

  if(scripts\engine\utility::istrue(param_01)) {
    self notify("current_challenge_ended");
    self.current_challenge.success = 0;
    scripts\cp\zombies\solo_challenges::deactivate_current_challenge(self);
    self.current_player_challenge = undefined;
  }
}

chi_challenge_activate(param_00) {
  param_00 endon("disconnect");
  wait(0.1);
  var_01 = param_00.kung_fu_progression.active_discipline;
  var_02 = param_00.kung_fu_progression.disciplines_levels[param_00.kung_fu_progression.active_discipline];
  if(isDefined(param_00.current_player_challenge)) {
    if(issubstr(param_00.current_player_challenge, var_01)) {
      return;
    }
  }

  if(var_02 < 3) {
    param_00 thread chi_challenge_start(var_01 + "_" + var_02 + 1 + "_challenge");
  }
}

chi_challenge_start(param_00) {
  scripts\cp\zombies\solo_challenges::activate_new_challenge(param_00, self);
}

challenge_success(param_00) {
  scripts\cp\maps\cp_disco\kung_fu_mode::update_player_abilities(param_00, param_00.kung_fu_progression.active_discipline);
  var_01 = 0;
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("challenge_success_chi", "zmb_comment_vo", "low", 10, 0, 0, 1, 100);
  var_02 = param_00.kung_fu_progression.disciplines_levels[param_00.kung_fu_progression.active_discipline];
  switch (param_00.kung_fu_progression.active_discipline) {
    case "snake":
      if(var_02 == 1) {
        var_01 = 1;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_snake_1", "pam_dialogue_vo");
      } else if(var_02 == 2) {
        var_01 = 2;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_snake_2", "pam_dialogue_vo");
      } else if(var_02 == 3) {
        var_01 = 3;
        param_00.chi_master_snake = 1;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_snake_3", "pam_dialogue_vo");
        param_00 scripts\cp\cp_merits::processmerit("mt_dlc2_chi_master");
      }
      break;

    case "dragon":
      if(var_02 == 1) {
        var_01 = 10;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_dragon_1", "pam_dialogue_vo");
      } else if(var_02 == 2) {
        var_01 = 11;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_dragon_2", "pam_dialogue_vo");
      } else if(var_02 == 3) {
        var_01 = 12;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_dragon_3", "pam_dialogue_vo");
        param_00.chi_master_dragon = 1;
        param_00 scripts\cp\cp_merits::processmerit("mt_dlc2_chi_master");
      }
      break;

    case "crane":
      if(var_02 == 1) {
        var_01 = 7;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_crane_1", "pam_dialogue_vo");
      } else if(var_02 == 2) {
        var_01 = 8;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_crane_2", "pam_dialogue_vo");
      } else if(var_02 == 3) {
        var_01 = 9;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_crane_3", "pam_dialogue_vo");
        param_00.chi_master_crane = 1;
        param_00 scripts\cp\cp_merits::processmerit("mt_dlc2_chi_master");
      }
      break;

    case "tiger":
      if(var_02 == 1) {
        var_01 = 4;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_tiger_1", "pam_dialogue_vo");
      } else if(var_02 == 2) {
        var_01 = 5;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_tiger_2", "pam_dialogue_vo");
      } else if(var_02 == 3) {
        var_01 = 6;
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_tiger_3", "pam_dialogue_vo");
        param_00.chi_master_tiger = 1;
        param_00 scripts\cp\cp_merits::processmerit("mt_dlc2_chi_master");
      }
      break;
  }

  param_00 setclientomnvarbit("zm_challenges_completed", var_01, 1);
  if(scripts\engine\utility::istrue(param_00.chi_master_tiger) && scripts\engine\utility::istrue(param_00.chi_master_dragon) && scripts\engine\utility::istrue(param_00.chi_master_snake) && scripts\engine\utility::istrue(param_00.chi_master_crane)) {
    param_00 scripts\cp\zombies\achievement::update_achievement("SHAOLIN_SKILLS", 1);
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_all_max", "pam_dialogue_vo");
  }

  param_00.kung_fu_progression.challenge_progress[param_00.kung_fu_progression.active_discipline] = 0;
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

empty(param_00) {}

challenge_scalar_func(param_00) {
  var_01 = get_scalar_from_table(param_00);
  return var_01;
}

get_scalar_from_table(param_00) {
  var_01 = level.zombie_challenge_table;
  var_02 = 0;
  var_03 = 1;
  var_04 = 99;
  var_05 = 1;
  var_06 = 9;
  for(var_07 = var_03; var_07 <= var_04; var_07++) {
    var_08 = tablelookup(var_01, var_02, var_07, var_05);
    if(var_08 == "") {
      return undefined;
    }

    if(var_08 != param_00) {
      continue;
    }

    var_09 = tablelookup(var_01, var_02, var_07, var_06);
    if(isDefined(var_09)) {
      var_09 = strtok(var_09, " ");
      if(var_09.size > 0) {
        return int(var_09[0]);
      }
    }
  }
}

default_playerdamage_challenge_func(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(level.current_challenge)) {
    return 0;
  }

  if(scripts\engine\utility::flag("pause_challenges")) {
    return 0;
  }

  return 1;
}

default_death_challenge_func(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = param_01;
  if(isDefined(param_01.playerowner) && param_01.playerowner scripts\cp\utility::is_valid_player(1)) {
    var_09 = param_01.playerowner;
  }

  if(!isDefined(var_09.current_player_challenge) || !isDefined(var_09.kung_fu_progression.active_discipline)) {
    return 0;
  }

  if(!isDefined(param_04)) {
    return 0;
  }

  var_0A = var_09.kung_fu_progression.active_discipline;
  var_0B = var_09.kung_fu_progression.disciplines_levels[var_09.kung_fu_progression.active_discipline];
  switch (var_0B) {
    case 0:
      if(!issubstr(param_04, "fists_zm_")) {
        return 0;
      }
      break;

    case 1:
      if(param_04 != "iw7_shuriken_" + var_0A + "_proj" && param_04 != "iw7_shuriken_zm_" + var_0A) {
        return 0;
      }
      break;

    case 2:
      if(param_04 == "none" && !isplayer(param_01)) {
        break;
      }

      if(var_0A == "tiger" && param_03 == "MOD_EXPLOSIVE" && param_04 == "none") {
        break;
      }

      if(!issubstr(param_04, "fists_zm_") || param_03 != "MOD_UNKNOWN") {
        return 0;
      }
      break;

    case 3:
      if(param_04 != "power_repulsor") {
        return 0;
      }
      break;
  }

  var_09.kung_fu_progression.challenge_progress[var_09.kung_fu_progression.active_discipline]++;
  var_09 thread scripts\cp\zombies\solo_challenges::update_challenge(var_0A + "_" + var_0B + 1 + "_challenge", 1);
  return 0;
}