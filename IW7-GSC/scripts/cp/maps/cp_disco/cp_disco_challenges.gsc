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

activate_challenge(var_0) {
  var_0 scripts\cp\zombies\solo_challenges::default_resetsuccess();
  var_0.current_challenge.current_progress = var_0.kung_fu_progression.challenge_progress[var_0.kung_fu_progression.active_discipline];
  var_0 scripts\cp\zombies\solo_challenges::update_challenge_progress(var_0.current_challenge.current_progress, var_0.current_challenge.objective_icon);
}

update_disco_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.current_challenge.current_progress = self.current_challenge.current_progress + var_0;
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

  if(scripts\engine\utility::istrue(var_1)) {
    self notify("current_challenge_ended");
    self.current_challenge.success = 0;
    scripts\cp\zombies\solo_challenges::deactivate_current_challenge(self);
    self.current_player_challenge = undefined;
  }
}

chi_challenge_activate(var_0) {
  var_0 endon("disconnect");
  wait(0.1);
  var_1 = var_0.kung_fu_progression.active_discipline;
  var_2 = var_0.kung_fu_progression.disciplines_levels[var_0.kung_fu_progression.active_discipline];
  if(isDefined(var_0.current_player_challenge)) {
    if(issubstr(var_0.current_player_challenge, var_1)) {
      return;
    }
  }

  if(var_2 < 3) {
    var_0 thread chi_challenge_start(var_1 + "_" + var_2 + 1 + "_challenge");
  }
}

chi_challenge_start(var_0) {
  scripts\cp\zombies\solo_challenges::activate_new_challenge(var_0, self);
}

challenge_success(var_0) {
  scripts\cp\maps\cp_disco\kung_fu_mode::update_player_abilities(var_0, var_0.kung_fu_progression.active_discipline);
  var_1 = 0;
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("challenge_success_chi", "zmb_comment_vo", "low", 10, 0, 0, 1, 100);
  var_2 = var_0.kung_fu_progression.disciplines_levels[var_0.kung_fu_progression.active_discipline];
  switch (var_0.kung_fu_progression.active_discipline) {
    case "snake":
      if(var_2 == 1) {
        var_1 = 1;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_snake_1", "pam_dialogue_vo");
      } else if(var_2 == 2) {
        var_1 = 2;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_snake_2", "pam_dialogue_vo");
      } else if(var_2 == 3) {
        var_1 = 3;
        var_0.chi_master_snake = 1;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_snake_3", "pam_dialogue_vo");
        var_0 scripts\cp\cp_merits::processmerit("mt_dlc2_chi_master");
      }
      break;

    case "dragon":
      if(var_2 == 1) {
        var_1 = 10;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_dragon_1", "pam_dialogue_vo");
      } else if(var_2 == 2) {
        var_1 = 11;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_dragon_2", "pam_dialogue_vo");
      } else if(var_2 == 3) {
        var_1 = 12;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_dragon_3", "pam_dialogue_vo");
        var_0.chi_master_dragon = 1;
        var_0 scripts\cp\cp_merits::processmerit("mt_dlc2_chi_master");
      }
      break;

    case "crane":
      if(var_2 == 1) {
        var_1 = 7;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_crane_1", "pam_dialogue_vo");
      } else if(var_2 == 2) {
        var_1 = 8;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_crane_2", "pam_dialogue_vo");
      } else if(var_2 == 3) {
        var_1 = 9;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_crane_3", "pam_dialogue_vo");
        var_0.chi_master_crane = 1;
        var_0 scripts\cp\cp_merits::processmerit("mt_dlc2_chi_master");
      }
      break;

    case "tiger":
      if(var_2 == 1) {
        var_1 = 4;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_tiger_1", "pam_dialogue_vo");
      } else if(var_2 == 2) {
        var_1 = 5;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_tiger_2", "pam_dialogue_vo");
      } else if(var_2 == 3) {
        var_1 = 6;
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_tiger_3", "pam_dialogue_vo");
        var_0.chi_master_tiger = 1;
        var_0 scripts\cp\cp_merits::processmerit("mt_dlc2_chi_master");
      }
      break;
  }

  var_0 setclientomnvarbit("zm_challenges_completed", var_1, 1);
  if(scripts\engine\utility::istrue(var_0.chi_master_tiger) && scripts\engine\utility::istrue(var_0.chi_master_dragon) && scripts\engine\utility::istrue(var_0.chi_master_snake) && scripts\engine\utility::istrue(var_0.chi_master_crane)) {
    var_0 scripts\cp\zombies\achievement::update_achievement("SHAOLIN_SKILLS", 1);
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("pam_rank_all_max", "pam_dialogue_vo");
  }

  var_0.kung_fu_progression.challenge_progress[var_0.kung_fu_progression.active_discipline] = 0;
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

empty(var_0) {}

challenge_scalar_func(var_0) {
  var_1 = get_scalar_from_table(var_0);
  return var_1;
}

get_scalar_from_table(var_0) {
  var_1 = level.zombie_challenge_table;
  var_2 = 0;
  var_3 = 1;
  var_4 = 99;
  var_5 = 1;
  var_6 = 9;
  for(var_7 = var_3; var_7 <= var_4; var_7++) {
    var_8 = tablelookup(var_1, var_2, var_7, var_5);
    if(var_8 == "") {
      return undefined;
    }

    if(var_8 != var_0) {
      continue;
    }

    var_9 = tablelookup(var_1, var_2, var_7, var_6);
    if(isDefined(var_9)) {
      var_9 = strtok(var_9, " ");
      if(var_9.size > 0) {
        return int(var_9[0]);
      }
    }
  }
}

default_playerdamage_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.current_challenge)) {
    return 0;
  }

  if(scripts\engine\utility::flag("pause_challenges")) {
    return 0;
  }

  return 1;
}

default_death_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_1;
  if(isDefined(var_1.playerowner) && var_1.playerowner scripts\cp\utility::is_valid_player(1)) {
    var_9 = var_1.playerowner;
  }

  if(!isDefined(var_9.current_player_challenge) || !isDefined(var_9.kung_fu_progression.active_discipline)) {
    return 0;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  var_0A = var_9.kung_fu_progression.active_discipline;
  var_0B = var_9.kung_fu_progression.disciplines_levels[var_9.kung_fu_progression.active_discipline];
  switch (var_0B) {
    case 0:
      if(!issubstr(var_4, "fists_zm_")) {
        return 0;
      }
      break;

    case 1:
      if(var_4 != "iw7_shuriken_" + var_0A + "_proj" && var_4 != "iw7_shuriken_zm_" + var_0A) {
        return 0;
      }
      break;

    case 2:
      if(var_4 == "none" && !isplayer(var_1)) {
        break;
      }

      if(var_0A == "tiger" && var_3 == "MOD_EXPLOSIVE" && var_4 == "none") {
        break;
      }

      if(!issubstr(var_4, "fists_zm_") || var_3 != "MOD_UNKNOWN") {
        return 0;
      }
      break;

    case 3:
      if(var_4 != "power_repulsor") {
        return 0;
      }
      break;
  }

  var_9.kung_fu_progression.challenge_progress[var_9.kung_fu_progression.active_discipline]++;
  var_9 thread scripts\cp\zombies\solo_challenges::update_challenge(var_0A + "_" + var_0B + 1 + "_challenge", 1);
  return 0;
}