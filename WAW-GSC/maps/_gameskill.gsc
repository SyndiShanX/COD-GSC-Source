/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_gameskill.gsc
*****************************************************/

#include maps\_utility;
#include animscripts\utility;
#include common_scripts\utility;

setSkill(reset, skill_override) {
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _gameskill.gsc. Function: setSkill()\n");
  }
  if(!isDefined(level.script)) {
    level.script = tolower(getdvar("mapname"));
  }
  if(!isDefined(reset) || reset == false) {
    if(isDefined(level.gameSkill)) {
      if(getdebugdvar("replay_debug") == "1") {
        println("File: _gameskill.gsc. Function: setSkill() - COMPLETE EARLY\n");
      }
      return;
    }
    if(!isDefined(level.custom_player_attacker)) {
      level.custom_player_attacker = ::return_false;
    }
    level.global_damage_func_ads = ::empty_kill_func;
    level.global_damage_func = ::empty_kill_func;
    level.global_kill_func = ::empty_kill_func;
    if(getdvar("arcademode") == "1") {
      thread maps\_arcademode::main();
    }
    set_console_status();
    flag_init("player_has_red_flashing_overlay");
    flag_init("player_is_invulnerable");
    flag_clear("player_has_red_flashing_overlay");
    flag_clear("player_is_invulnerable");
    level.difficultyType[0] = "easy";
    level.difficultyType[1] = "normal";
    level.difficultyType[2] = "hardened";
    level.difficultyType[3] = "veteran";
    level.difficultyString["easy"] = &"GAMESKILL_EASY";
    level.difficultyString["normal"] = &"GAMESKILL_NORMAL";
    level.difficultyString["hardened"] = &"GAMESKILL_HARDENED";
    level.difficultyString["veteran"] = &"GAMESKILL_VETERAN";
    thread playerHealthDebug();
  }
  level.gameSkill = getdvarint("g_gameskill");
  if(isDefined(skill_override)) {
    level.gameSkill = skill_override;
  }
  setdvar("saved_gameskill", level.gameSkill);
  switch (level.gameSkill) {
    case 0:
      setdvar("currentDifficulty", "easy");
      break;
    case 1:
      setdvar("currentDifficulty", "normal");
      break;
    case 2:
      setdvar("currentDifficulty", "hardened");
      break;
    case 3:
      setdvar("currentDifficulty", "veteran");
      break;
  }
  if(getdvar("autodifficulty_playerDeathTimer") == "") {
    setdvar("autodifficulty_playerDeathTimer", 0);
  }
  anim.run_accuracy = 0.5;
  logString("difficulty: " + level.gameSkill);
  setdvar("autodifficulty_frac", 0);
  setdvar("coop_difficulty_scaling", 1);
  level.difficultySettings_stepFunc_percent = [];
  level.difficultySettings_frac_data_points = [];
  level.auto_adjust_threatbias = true;
  setTakeCoverWarnings();
  thread increment_take_cover_warnings_on_death();
  level.mg42badplace_mintime = 8;
  level.mg42badplace_maxtime = 16;
  add_fractional_data_point("playerGrenadeBaseTime", 0.0, 50000);
  add_fractional_data_point("playerGrenadeBaseTime", 0.25, 40000);
  add_fractional_data_point("playerGrenadeBaseTime", 0.75, 25000);
  add_fractional_data_point("playerGrenadeBaseTime", 1.0, 13500);
  level.difficultySettings["playerGrenadeBaseTime"]["hardened"] = 10000;
  level.difficultySettings["playerGrenadeBaseTime"]["veteran"] = 0;
  add_fractional_data_point("playerGrenadeRangeTime", 0.0, 22000);
  add_fractional_data_point("playerGrenadeRangeTime", 0.25, 20000);
  add_fractional_data_point("playerGrenadeRangeTime", 0.75, 15000);
  add_fractional_data_point("playerGrenadeRangeTime", 1.0, 7500);
  level.difficultySettings["playerGrenadeRangeTime"]["hardened"] = 5000;
  level.difficultySettings["playerGrenadeRangeTime"]["veteran"] = 1;
  add_fractional_data_point("playerDoubleGrenadeTime", 0.25, 60 * 60 * 1000);
  add_fractional_data_point("playerDoubleGrenadeTime", 0.75, 120 * 1000);
  add_fractional_data_point("playerDoubleGrenadeTime", 1.0, 20 * 1000);
  level.difficultySettings["playerDoubleGrenadeTime"]["hardened"] = 15 * 1000;
  level.difficultySettings["playerDoubleGrenadeTime"]["veteran"] = 0;
  level.difficultySettings["double_grenades_allowed"]["easy"] = false;
  level.difficultySettings["double_grenades_allowed"]["normal"] = true;
  level.difficultySettings["double_grenades_allowed"]["hardened"] = true;
  level.difficultySettings["double_grenades_allowed"]["veteran"] = true;
  level.difficultySettings_stepFunc_percent["double_grenades_allowed"] = 0.75;
  add_fractional_data_point("player_deathInvulnerableTime", 0.25, 4000);
  add_fractional_data_point("player_deathInvulnerableTime", 0.75, 1700);
  add_fractional_data_point("player_deathInvulnerableTime", 1.0, 850);
  level.difficultySettings["player_deathInvulnerableTime"]["hardened"] = 600;
  level.difficultySettings["player_deathInvulnerableTime"]["veteran"] = 100;
  add_fractional_data_point("threatbias", 0.0, 80);
  add_fractional_data_point("threatbias", 0.25, 100);
  add_fractional_data_point("threatbias", 0.75, 150);
  add_fractional_data_point("threatbias", 1.0, 165);
  level.difficultySettings["threatbias"]["hardened"] = 200;
  level.difficultySettings["threatbias"]["veteran"] = 400;
  add_fractional_data_point("longRegenTime", 1.0, 5000);
  level.difficultySettings["longRegenTime"]["hardened"] = 5000;
  level.difficultySettings["longRegenTime"]["veteran"] = 5000;
  add_fractional_data_point("healthOverlayCutoff", 0.25, 0.01);
  add_fractional_data_point("healthOverlayCutoff", 0.75, 0.2);
  add_fractional_data_point("healthOverlayCutoff", 1.0, 0.25);
  level.difficultySettings["healthOverlayCutoff"]["hardened"] = 0.3;
  level.difficultySettings["healthOverlayCutoff"]["veteran"] = 0.5;
  add_fractional_data_point("base_enemy_accuracy", 0.25, 1);
  add_fractional_data_point("base_enemy_accuracy", 0.75, 1);
  level.difficultySettings["base_enemy_accuracy"]["hardened"] = 1.3;
  level.difficultySettings["base_enemy_accuracy"]["veteran"] = 1.3;
  add_fractional_data_point("accuracyDistScale", 0.25, 1.0);
  add_fractional_data_point("accuracyDistScale", 0.75, 1.0);
  level.difficultySettings["accuracyDistScale"]["hardened"] = 1.0;
  level.difficultySettings["accuracyDistScale"]["veteran"] = 0.5;
  add_fractional_data_point("playerDifficultyHealth", 0.0, 550);
  add_fractional_data_point("playerDifficultyHealth", 0.25, 475);
  add_fractional_data_point("playerDifficultyHealth", 0.75, 310);
  add_fractional_data_point("playerDifficultyHealth", 1.0, 210);
  level.difficultySettings["playerDifficultyHealth"]["hardened"] = 165;
  level.difficultySettings["playerDifficultyHealth"]["veteran"] = 115;
  add_fractional_data_point("min_sniper_burst_delay_time", 0.0, 3.5);
  add_fractional_data_point("min_sniper_burst_delay_time", 0.25, 3.0);
  add_fractional_data_point("min_sniper_burst_delay_time", 0.75, 2.0);
  add_fractional_data_point("min_sniper_burst_delay_time", 1.0, 1.80);
  level.difficultySettings["min_sniper_burst_delay_time"]["hardened"] = 1.5;
  level.difficultySettings["min_sniper_burst_delay_time"]["veteran"] = 1.1;
  add_fractional_data_point("max_sniper_burst_delay_time", 0.0, 4.5);
  add_fractional_data_point("max_sniper_burst_delay_time", 0.25, 4.0);
  add_fractional_data_point("max_sniper_burst_delay_time", 0.75, 3.0);
  add_fractional_data_point("max_sniper_burst_delay_time", 1.0, 2.5);
  level.difficultySettings["max_sniper_burst_delay_time"]["hardened"] = 2.0;
  level.difficultySettings["max_sniper_burst_delay_time"]["veteran"] = 1.5;
  add_fractional_data_point("dog_health", 0.0, 0.2);
  add_fractional_data_point("dog_health", 0.25, 0.25);
  add_fractional_data_point("dog_health", 0.75, 0.75);
  add_fractional_data_point("dog_health", 1.0, 0.8);
  level.difficultySettings["dog_health"]["hardened"] = 1.0;
  level.difficultySettings["dog_health"]["veteran"] = 1.0;
  add_fractional_data_point("dog_presstime", 0.25, 415);
  add_fractional_data_point("dog_presstime", 0.75, 375);
  level.difficultySettings["dog_presstime"]["hardened"] = 250;
  level.difficultySettings["dog_presstime"]["veteran"] = 225;
  level.difficultySettings["dog_hits_before_kill"]["easy"] = 2;
  level.difficultySettings["dog_hits_before_kill"]["normal"] = 1;
  level.difficultySettings["dog_hits_before_kill"]["hardened"] = 0;
  level.difficultySettings["dog_hits_before_kill"]["veteran"] = 0;
  level.difficultySettings_stepFunc_percent["dog_hits_before_kill"] = 0.5;
  level.difficultySettings["pain_test"]["easy"] = ::always_pain;
  level.difficultySettings["pain_test"]["normal"] = ::always_pain;
  level.difficultySettings["pain_test"]["hardened"] = ::pain_protection;
  level.difficultySettings["pain_test"]["veteran"] = ::pain_protection;
  anim.pain_test = level.difficultySettings["pain_test"][get_skill_from_index(level.gameskill)];
  level.difficultySettings["missTimeConstant"]["easy"] = 1.0;
  level.difficultySettings["missTimeConstant"]["normal"] = 0.05;
  level.difficultySettings["missTimeConstant"]["hardened"] = 0;
  level.difficultySettings["missTimeConstant"]["veteran"] = 0;
  level.difficultySettings_stepFunc_percent["missTimeConstant"] = 0.5;
  level.difficultySettings["missTimeDistanceFactor"]["easy"] = 0.8 / 1000;
  level.difficultySettings["missTimeDistanceFactor"]["normal"] = 0.1 / 1000;
  level.difficultySettings["missTimeDistanceFactor"]["hardened"] = 0.05 / 1000;
  level.difficultySettings["missTimeDistanceFactor"]["veteran"] = 0;
  level.difficultySettings_stepFunc_percent["missTimeDistanceFactor"] = 0.5;
  add_fractional_data_point("flashbangedInvulFactor", 0.25, 0.25);
  add_fractional_data_point("flashbangedInvulFactor", 0.75, 0.0);
  level.difficultySettings["flashbangedInvulFactor"]["easy"] = 0.25;
  level.difficultySettings["flashbangedInvulFactor"]["normal"] = 0;
  level.difficultySettings["flashbangedInvulFactor"]["hardened"] = 0;
  level.difficultySettings["flashbangedInvulFactor"]["veteran"] = 0;
  add_fractional_data_point("invulTime_preShield", 0.0, 0.7);
  add_fractional_data_point("invulTime_preShield", 0.25, 0.6);
  add_fractional_data_point("invulTime_preShield", 0.75, 0.35);
  add_fractional_data_point("invulTime_preShield", 1.0, 0.3);
  level.difficultySettings["invulTime_preShield"]["hardened"] = 0.1;
  level.difficultySettings["invulTime_preShield"]["veteran"] = 0.0;
  add_fractional_data_point("invulTime_onShield", 0.0, 1.0);
  add_fractional_data_point("invulTime_onShield", 0.25, 0.8);
  add_fractional_data_point("invulTime_onShield", 0.75, 0.5);
  add_fractional_data_point("invulTime_onShield", 1.0, 0.3);
  level.difficultySettings["invulTime_onShield"]["hardened"] = 0.1;
  level.difficultySettings["invulTime_onShield"]["veteran"] = 0.05;
  add_fractional_data_point("invulTime_postShield", 0.0, 0.6);
  add_fractional_data_point("invulTime_postShield", 0.25, 0.5);
  add_fractional_data_point("invulTime_postShield", 0.75, 0.3);
  add_fractional_data_point("invulTime_postShield", 1.0, 0.2);
  level.difficultySettings["invulTime_postShield"]["hardened"] = 0.1;
  level.difficultySettings["invulTime_postShield"]["veteran"] = 0.0;
  add_fractional_data_point("playerHealth_RegularRegenDelay", 0.0, 3500);
  add_fractional_data_point("playerHealth_RegularRegenDelay", 0.25, 3000);
  add_fractional_data_point("playerHealth_RegularRegenDelay", 0.75, 2400);
  add_fractional_data_point("playerHealth_RegularRegenDelay", 1.0, 1500);
  level.difficultySettings["playerHealth_RegularRegenDelay"]["hardened"] = 1200;
  level.difficultySettings["playerHealth_RegularRegenDelay"]["veteran"] = 1200;
  add_fractional_data_point("worthyDamageRatio", 0.25, 0.0);
  add_fractional_data_point("worthyDamageRatio", 0.75, 0.1);
  level.difficultySettings["worthyDamageRatio"]["hardened"] = 0.1;
  level.difficultySettings["worthyDamageRatio"]["veteran"] = 0.1;
  level.difficultySettings["explosivePlantTime"]["easy"] = 10;
  level.difficultySettings["explosivePlantTime"]["normal"] = 10;
  level.difficultySettings["explosivePlantTime"]["hardened"] = 5;
  level.difficultySettings["explosivePlantTime"]["veteran"] = 5;
  level.explosiveplanttime = level.difficultySettings["explosivePlantTime"][get_skill_from_index(level.gameskill)];
  level.difficultySettings["difficultyBasedAccuracy"]["easy"] = 1;
  level.difficultySettings["difficultyBasedAccuracy"]["normal"] = 1;
  level.difficultySettings["difficultyBasedAccuracy"]["hardened"] = 1;
  level.difficultySettings["difficultyBasedAccuracy"]["veteran"] = 1.25;
  anim.difficultyBasedAccuracy = getRatio("difficultyBasedAccuracy", level.gameskill, level.gameskill);
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["easy"][0] = 1.0;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["easy"][1] = 0.9;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["easy"][2] = 0.8;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["easy"][3] = 0.7;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["normal"][0] = 1.0;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["normal"][1] = 0.9;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["normal"][2] = 0.8;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["normal"][3] = 0.7;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["hardened"][0] = 1.00;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["hardened"][1] = 0.9;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["hardened"][2] = 0.8;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["hardened"][3] = 0.7;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["veteran"][0] = 1.0;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["veteran"][1] = 0.9;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["veteran"][2] = 0.8;
  level.difficultySettings["coopPlayer_deathInvulnerableTime"]["veteran"][3] = 0.7;
  level.difficultySettings["coopPlayerDifficultyHealth"]["easy"][0] = 1.00;
  level.difficultySettings["coopPlayerDifficultyHealth"]["easy"][1] = 0.95;
  level.difficultySettings["coopPlayerDifficultyHealth"]["easy"][2] = 0.8;
  level.difficultySettings["coopPlayerDifficultyHealth"]["easy"][3] = 0.75;
  level.difficultySettings["coopPlayerDifficultyHealth"]["normal"][0] = 1.00;
  level.difficultySettings["coopPlayerDifficultyHealth"]["normal"][1] = 0.9;
  level.difficultySettings["coopPlayerDifficultyHealth"]["normal"][2] = 0.8;
  level.difficultySettings["coopPlayerDifficultyHealth"]["normal"][3] = 0.7;
  level.difficultySettings["coopPlayerDifficultyHealth"]["hardened"][0] = 1.00;
  level.difficultySettings["coopPlayerDifficultyHealth"]["hardened"][1] = 0.85;
  level.difficultySettings["coopPlayerDifficultyHealth"]["hardened"][2] = 0.7;
  level.difficultySettings["coopPlayerDifficultyHealth"]["hardened"][3] = 0.65;
  level.difficultySettings["coopPlayerDifficultyHealth"]["veteran"][0] = 1.00;
  level.difficultySettings["coopPlayerDifficultyHealth"]["veteran"][1] = 0.8;
  level.difficultySettings["coopPlayerDifficultyHealth"]["veteran"][2] = 0.6;
  level.difficultySettings["coopPlayerDifficultyHealth"]["veteran"][3] = 0.5;
  level.difficultySettings["coopEnemyAccuracyScalar"]["easy"][0] = 1;
  level.difficultySettings["coopEnemyAccuracyScalar"]["easy"][1] = 1.1;
  level.difficultySettings["coopEnemyAccuracyScalar"]["easy"][2] = 1.2;
  level.difficultySettings["coopEnemyAccuracyScalar"]["easy"][3] = 1.3;
  level.difficultySettings["coopEnemyAccuracyScalar"]["normal"][0] = 1;
  level.difficultySettings["coopEnemyAccuracyScalar"]["normal"][1] = 1.1;
  level.difficultySettings["coopEnemyAccuracyScalar"]["normal"][2] = 1.3;
  level.difficultySettings["coopEnemyAccuracyScalar"]["normal"][3] = 1.5;
  level.difficultySettings["coopEnemyAccuracyScalar"]["hardened"][0] = 1.0;
  level.difficultySettings["coopEnemyAccuracyScalar"]["hardened"][1] = 1.2;
  level.difficultySettings["coopEnemyAccuracyScalar"]["hardened"][2] = 1.4;
  level.difficultySettings["coopEnemyAccuracyScalar"]["hardened"][3] = 1.6;
  level.difficultySettings["coopEnemyAccuracyScalar"]["veteran"][0] = 1;
  level.difficultySettings["coopEnemyAccuracyScalar"]["veteran"][1] = 1.3;
  level.difficultySettings["coopEnemyAccuracyScalar"]["veteran"][2] = 1.6;
  level.difficultySettings["coopEnemyAccuracyScalar"]["veteran"][3] = 2;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["easy"][0] = 1;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["easy"][1] = 0.9;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["easy"][2] = 0.8;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["easy"][3] = 0.7;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["normal"][0] = 1;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["normal"][1] = 0.8;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["normal"][2] = 0.7;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["normal"][3] = 0.6;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["hardened"][0] = 1;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["hardened"][1] = 0.7;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["hardened"][2] = 0.5;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["hardened"][3] = 0.5;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["veteran"][0] = 1;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["veteran"][1] = 0.7;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["veteran"][2] = 0.5;
  level.difficultySettings["coopFriendlyAccuracyScalar"]["veteran"][3] = 0.4;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["easy"][0] = 1;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["easy"][1] = 1.1;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["easy"][2] = 1.2;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["easy"][3] = 1.3;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["normal"][0] = 1;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["normal"][1] = 2;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["normal"][2] = 3;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["normal"][3] = 4;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["hardened"][0] = 1.0;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["hardened"][1] = 3;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["hardened"][2] = 6;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["hardened"][3] = 9;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["veteran"][0] = 1;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["veteran"][1] = 10;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["veteran"][2] = 20;
  level.difficultySettings["coopFriendlyThreatBiasScalar"]["veteran"][3] = 30;
  level.difficultySettings["lateralAccuracyModifier"]["easy"] = 300;
  level.difficultySettings["lateralAccuracyModifier"]["normal"] = 700;
  level.difficultySettings["lateralAccuracyModifier"]["hardened"] = 1000;
  level.difficultySettings["lateralAccuracyModifier"]["veteran"] = 2500;
  level.lastPlayerSighted = 0;
  difficulty_starting_frac["easy"] = 0.25;
  difficulty_starting_frac["normal"] = 0.75;
  if(level.gameskill <= 1) {
    {
      dif_frac = difficulty_starting_frac[get_skill_from_index(level.gameskill)];
      dif_frac = int(dif_frac * 100);
      setdvar("autodifficulty_frac", dif_frac);
    }
    set_difficulty_from_current_aa_frac();
  } else {
    set_difficulty_from_locked_settings();
  }
  setdvar("autodifficulty_original_setting", level.gameskill);
  setsaveddvar("player_meleeDamageMultiplier", 100 / 250);
  thread coop_enemy_accuracy_scalar_watcher();
  thread coop_friendly_accuracy_scalar_watcher();
  thread coop_player_threat_bias_adjuster();
  thread coop_spawner_count_adjuster();
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _gameskill.gsc. Function: setSkill() - COMPLETE\n");
  }
}

get_skill_from_index(index) {
  return level.difficultyType[index];
}

aa_should_start_fresh() {
  if(level.script == "killhouse") {
    return true;
  }
  return level.gameskill == getdvarint("autodifficulty_original_setting");
}

apply_difficulty_frac_with_func(difficulty_func, current_frac) {
  level.invulTime_preShield = [[difficulty_func]]("invulTime_preShield", current_frac);
  level.invulTime_onShield = [[difficulty_func]]("invulTime_onShield", current_frac);
  level.invulTime_postShield = [[difficulty_func]]("invulTime_postShield", current_frac);
  level.playerHealth_RegularRegenDelay = [[difficulty_func]]("playerHealth_RegularRegenDelay", current_frac);
  level.worthyDamageRatio = [[difficulty_func]]("worthyDamageRatio", current_frac);
  if(level.auto_adjust_threatbias) {
    thread apply_threat_bias_to_all_players(difficulty_func, current_frac);
  }
  level.longRegenTime = [[difficulty_func]]("longRegenTime", current_frac);
  level.healthOverlayCutoff = [[difficulty_func]]("healthOverlayCutoff", current_frac);
  anim.player_attacker_accuracy = [[difficulty_func]]("base_enemy_accuracy", current_frac);
  level.attackeraccuracy = anim.player_attacker_accuracy;
  anim.playerGrenadeBaseTime = int([[difficulty_func]]("playerGrenadeBaseTime", current_frac));
  anim.playerGrenadeRangeTime = int([[difficulty_func]]("playerGrenadeRangeTime", current_frac));
  anim.playerDoubleGrenadeTime = int([[difficulty_func]]("playerDoubleGrenadeTime", current_frac));
  anim.min_sniper_burst_delay_time = [[difficulty_func]]("min_sniper_burst_delay_time", current_frac);
  anim.max_sniper_burst_delay_time = [[difficulty_func]]("max_sniper_burst_delay_time", current_frac);
  anim.dog_health = [[difficulty_func]]("dog_health", current_frac);
  anim.dog_presstime = [[difficulty_func]]("dog_presstime", current_frac);
  setsaveddvar("ai_accuracyDistScale", [[difficulty_func]]("accuracyDistScale", current_frac));
  thread coop_damage_and_accuracy_scaling(difficulty_func, current_frac);
}

apply_threat_bias_to_all_players(difficulty_func, current_frac) {
  while(!isDefined(level.flag) || !isDefined(level.flag["all_players_connected"])) {
    wait 0.05;
    continue;
  }
  flag_wait("all_players_connected");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].threatbias = int([[difficulty_func]]("threatbias", current_frac));
  }
}

coop_damage_and_accuracy_scaling(difficulty_func, current_frac) {
  while(!isDefined(level.flag)) {
    wait 0.05;
  }
  while(!isDefined(level.flag["all_players_spawned"])) {
    wait 0.05;
  }
  flag_wait("all_players_spawned");
  players = get_players();
  coop_healthscalar = getCoopValue("coopPlayerDifficultyHealth", players.size);
  if(maps\_collectibles::has_collectible("collectible_sticksstones")) {
    coop_healthscalar *= 2;
  }
  setsaveddvar("player_damageMultiplier", 100 / ([[difficulty_func]]("playerDifficultyHealth", current_frac) * coop_healthscalar));
  coop_invuln_remover = getCoopValue("coopPlayer_deathInvulnerableTime", players.size);
  setsaveddvar("player_deathInvulnerableTime", int([[difficulty_func]]("player_deathInvulnerableTime", current_frac) * coop_invuln_remover));
}

apply_difficulty_step_with_func(difficulty_func, current_frac) {
  anim.missTimeConstant = [[difficulty_func]]("missTimeConstant", current_frac);
  anim.missTimeDistanceFactor = [[difficulty_func]]("missTimeDistanceFactor", current_frac);
  anim.dog_hits_before_kill = [[difficulty_func]]("dog_hits_before_kill", current_frac);
  anim.double_grenades_allowed = [[difficulty_func]]("double_grenades_allowed", current_frac);
}

set_difficulty_from_locked_settings() {
  apply_difficulty_frac_with_func(::get_locked_difficulty_val, 1);
  apply_difficulty_step_with_func(::get_locked_difficulty_step_val, 1);
}

set_difficulty_from_current_aa_frac() {
  level.auto_adjust_difficulty_frac = getdvarint("autodifficulty_frac");
  current_frac = level.auto_adjust_difficulty_frac * 0.01;
  assert(level.auto_adjust_difficulty_frac >= 0);
  assert(level.auto_adjust_difficulty_frac <= 100);
  apply_difficulty_frac_with_func(::get_blended_difficulty, current_frac);
  apply_difficulty_step_with_func(::get_stepped_difficulty, current_frac);
}

get_stepped_difficulty(system, current_frac) {
  if(current_frac >= level.difficultySettings_stepFunc_percent[system]) {
    return level.difficultySettings[system]["normal"];
  }
  return level.difficultySettings[system]["easy"];
}

get_locked_difficulty_step_val(system, ignored) {
  return level.difficultySettings[system][get_skill_from_index(level.gameskill)];
}

get_blended_difficulty(system, current_frac) {
  difficulty_array = level.difficultySettings_frac_data_points[system];
  for(i = 1; i < difficulty_array.size; i++) {
    high_frac = difficulty_array[i]["frac"];
    high_val = difficulty_array[i]["val"];
    if(current_frac <= high_frac) {
      low_frac = difficulty_array[i - 1]["frac"];
      low_val = difficulty_array[i - 1]["val"];
      frac_range = high_frac - low_frac;
      val_range = high_val - low_val;
      base_frac = current_frac - low_frac;
      result_frac = base_frac / frac_range;
      return low_val + result_frac * val_range;
    }
  }
  assertex(difficulty_array.size == 1, "Shouldnt be multiple data points if we're here.");
  return difficulty_array[0]["val"];
}

is_double_grenades_allowed() {
  return level.auto_adjust_difficulty_frac > 0.75;
}

getCurrentDifficultySetting(msg) {
  return level.difficultySettings[msg][get_skill_from_index(level.gameskill)];
}

getRatio(msg, min, max) {
  return (level.difficultySettings[msg][level.difficultyType[min]] * (100 - getdvarint("autodifficulty_frac")) + level.difficultySettings[msg][level.difficultyType[max]] * getdvarint("autodifficulty_frac")) * 0.01;
}

getCoopValue(msg, numplayers) {
  if(numplayers <= 0) {
    numplayers = 1;
  }
  value = (level.difficultySettings[msg][getdvar("currentDifficulty")][numplayers - 1]);
  return (level.difficultySettings[msg][getdvar("currentDifficulty")][numplayers - 1]);
}

get_locked_difficulty_val(msg, ignored) {
  return level.difficultySettings[msg][level.difficultyType[level.gameskill]];
}

always_pain() {
  return false;
}

pain_protection() {
  if(!pain_protection_check()) {
    return false;
  }
  return (randomint(100) > 25);
}

pain_protection_check() {
  if(!isalive(self.enemy)) {
    return false;
  }
  if(!IsPlayer(self.enemy)) {
    return false;
  }
  if(!isalive(level.painAI) || level.painAI.a.script != "pain") {
    level.painAI = self;
  }
  if(self == level.painAI) {
    return false;
  }
  if(self.damageWeapon != "none" && weaponIsBoltAction(self.damageWeapon)) {
    return false;
  }
  return true;
}

playerHealthDebug() {
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _gameskill.gsc. Function: playerHealthDebug()\n");
  }
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _gameskill.gsc. Function: playerHealthDebug() - WAIT FINISHED\n");
  }
  if(getdvar("scr_health_debug") == "") {
    setdvar("scr_health_debug", "0");
  }
  waittillframeend;
  while(1) {
    if(getdebugdvar("replay_debug") == "1") {
      println("File: _gameskill.gsc. Function: playerHealthDebug() - INNER LOOP START\n");
    }
    while(1) {
      if(getdebugdvar("replay_debug") == "1") {
        println("File: _gameskill.gsc. Function: playerHealthDebug() - INNER INNER LOOP 1 START\n");
      }
      if(getdebugdvar("scr_health_debug") != "0") {
        break;
      }
      wait .5;
      if(getdebugdvar("replay_debug") == "1") {
        println("File: _gameskill.gsc. Function: playerHealthDebug() - INNER INNER LOOP 1 STOP\n");
      }
    }
    thread printHealthDebug();
    while(1) {
      if(getdebugdvar("replay_debug") == "1") {
        println("File: _gameskill.gsc. Function: playerHealthDebug() - INNER INNER LOOP 2 START\n");
      }
      if(getdebugdvar("scr_health_debug") == "0") {
        break;
      }
      wait .5;
      if(getdebugdvar("replay_debug") == "1") {
        println("File: _gameskill.gsc. Function: playerHealthDebug() - INNER INNER LOOP 2 STOP\n");
      }
    }
    level notify("stop_printing_grenade_timers");
    destroyHealthDebug();
    if(getdebugdvar("replay_debug") == "1") {
      println("File: _gameskill.gsc. Function: playerHealthDebug() - INNER LOOP STOP\n");
    }
  }
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _gameskill.gsc. Function: playerHealthDebug() - COMPLETE\n");
  }
}

printHealthDebug() {
  level notify("stop_printing_health_bars");
  level endon("stop_printing_health_bars");
  x = 40;
  y = 40;
  level.healthBarHudElems = [];
  level.healthBarKeys[0] = "Health";
  level.healthBarKeys[1] = "No Hit Time";
  level.healthBarKeys[2] = "No Die Time";
  if(!isDefined(level.playerInvulTimeEnd)) {
    level.playerInvulTimeEnd = 0;
  }
  if(!isDefined(level.player_deathInvulnerableTimeout)) {
    level.player_deathInvulnerableTimeout = 0;
  }
  for(i = 0; i < level.healthBarKeys.size; i++) {
    key = level.healthBarKeys[i];
    textelem = newHudElem();
    textelem.x = x;
    textelem.y = y;
    textelem.alignX = "left";
    textelem.alignY = "top";
    textelem.horzAlign = "fullscreen";
    textelem.vertAlign = "fullscreen";
    textelem setText(key);
    bar = newHudElem();
    bar.x = x + 80;
    bar.y = y + 2;
    bar.alignX = "left";
    bar.alignY = "top";
    bar.horzAlign = "fullscreen";
    bar.vertAlign = "fullscreen";
    bar setshader("black", 1, 8);
    textelem.bar = bar;
    textelem.key = key;
    y += 10;
    level.healthBarHudElems[key] = textelem;
  }
  while(1) {
    wait .05;
    players = get_players();
    for(i = 0; i < level.healthBarKeys.size && players.size > 0; i++) {
      key = level.healthBarKeys[i];
      player = players[0];
      width = 0;
      if(i == 0) {
        width = player.health / player.maxhealth * 300;
      }
      else if(i == 1) {
        width = (level.playerInvulTimeEnd - gettime()) / 1000 * 40;
      }
      else if(i == 2) {
        width = (level.player_deathInvulnerableTimeout - gettime()) / 1000 * 40;
      }
      width = int(max(width, 1));
      bar = level.healthBarHudElems[key].bar;
      bar setShader("black", width, 8);
    }
  }
}

destroyHealthDebug() {
  if(!isDefined(level.healthBarHudElems)) {
    return;
  }
  for(i = 0; i < level.healthBarKeys.size; i++) {
    level.healthBarHudElems[level.healthBarKeys[i]].bar destroy();
    level.healthBarHudElems[level.healthBarKeys[i]] destroy();
  }
}

axisAccuracyControl() {
  self endon("long_death");
  self endon("death");
  self coop_axis_accuracy_scaler();
}
alliesAccuracyControl() {
  self endon("long_death");
  self endon("death");
  self coop_allies_accuracy_scaler();
}

set_accuracy_based_on_situation() {
  if(self animscripts\combat_utility::isSniper() && isAlive(self.enemy)) {
    self setSniperAccuracy();
    return;
  }
  if(isPlayer(self.enemy)) {
    resetMissDebounceTime();
    if(self.a.missTime > gettime()) {
      self.accuracy = 0;
      return;
    }
    if(self.a.script == "move") {
      self.accuracy = anim.run_accuracy * self.baseAccuracy;
      return;
    }
  } else {
    if(self.a.script == "move") {
      self.accuracy = anim.run_accuracy * self.baseAccuracy;
      return;
    }
  }
  self.accuracy = self.baseAccuracy;
}

setSniperAccuracy() {
  if(!isDefined(self.sniperShotCount)) {
    self.sniperShotCount = 0;
    self.sniperHitCount = 0;
  }
  self.sniperShotCount++;
  if((!isDefined(self.lastMissedEnemy) || self.enemy != self.lastMissedEnemy) && distanceSquared(self.origin, self.enemy.origin) > 500 * 500) {
    self.accuracy = 0;
    if(level.gameSkill > 0 || self.sniperShotCount > 1) {
      self.lastMissedEnemy = self.enemy;
    }
    return;
  }
  self.accuracy = (1 + 1 * self.sniperHitCount) * self.baseAccuracy;
  self.sniperHitCount++;
  if(level.gameSkill < 1 && self.sniperHitCount == 1) {
    self.lastMissedEnemy = undefined;
  }
}

shotsAfterPlayerBecomesInvul() {
  return (1 + randomfloat(4));
}

didSomethingOtherThanShooting() {
  self.a.missTimeDebounce = 0;
}

resetAccuracyAndPause() {
  self resetMissTime();
}

waitTimeIfPlayerIsHit() {
  waittime = 0;
  waittillframeend;
  if(!isalive(self.enemy)) {
    return waittime;
  }
  if(!IsPlayer(self.enemy)) {
    return waittime;
  }
  if(self player_flag("player_is_invulnerable") && !self.a.nonstopFire) {
    waittime = (0.3 + randomfloat(0.4));
  }
  return waittime;
}

print3d_time(org, text, color, timer) {
  timer *= 20;
  for(i = 0; i < timer; i++) {
    print3d(org, text, color);
    wait(0.05);
  }
}

resetMissTime() {
  if(self.team != "axis") {
    return;
  }
  if(self.weapon == "none") {
    return;
  }
  if(self usingBoltActionWeapon()) {
    self.missTime = 0;
    return;
  }
  if(!self animscripts\weaponList::usingAutomaticWeapon() && !self animscripts\weaponList::usingSemiAutoWeapon()) {
    self.missTime = 0;
    return;
  }
  self.a.nonstopFire = false;
  if(!isalive(self.enemy)) {
    return;
  }
  if(!IsPlayer(self.enemy)) {
    self.accuracy = self.baseAccuracy;
    return;
  }
  dist = distance(self.enemy.origin, self.origin);
  self setMissTime(anim.missTimeConstant + dist * anim.missTimeDistanceFactor);
}

resetMissDebounceTime() {
  self.a.missTimeDebounce = gettime() + 3000;
}

setMissTime(howLong) {
  assertex(self.team == "axis", "Non axis tried to set misstime");
  if(self.a.missTimeDebounce > gettime()) {
    return;
  }
  if(howLong > 0) {
    self.accuracy = 0;
  }
  howLong *= 1000;
  self.a.missTime = gettime() + howLong;
  self.a.accuracyGrowthMultiplier = 1;
}

player_aim_debug() {
  self endon("death");
  self endon("disconnect");
  self notify("playeraim");
  self endon("playeraim");
  for(;;) {
    color = (0, 1, 0);
    if(self.a.misstime > gettime()) {
      color = (1, 0, 0);
    }
    print3d(self.origin + (0, 0, 32), self.finalaccuracy, color);
    wait(0.05);
  }
}

playerHurtcheck() {
  self.hurtAgain = false;
  for(;;) {
    self waittill("damage", amount, attacker, dir, point, mod);
    self.hurtAgain = true;
    self.damagePoint = point;
    self.damageAttacker = attacker;
    if(isDefined(mod) && mod == "MOD_BURNED") {
      self setburn(0.5);
    }
  }
}

player_health_packets() {}

playerHealthRegen() {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(self.flag)) {
    self.flag = [];
    self.flags_lock = [];
  }
  if(!isDefined(self.flag["player_has_red_flashing_overlay"])) {
    self player_flag_init("player_has_red_flashing_overlay");
    self player_flag_init("player_is_invulnerable");
  }
  self player_flag_clear("player_has_red_flashing_overlay");
  self player_flag_clear("player_is_invulnerable");
  self thread increment_take_cover_warnings_on_death();
  self setTakeCoverWarnings();
  self thread healthOverlay();
  oldratio = 1;
  health_add = 0;
  regenRate = 0.1;
  veryHurt = false;
  playerJustGotRedFlashing = false;
  level.hurtTime = -10000;
  self thread playerBreathingSound(self.maxHealth * 0.35);
  invulTime = 0;
  hurtTime = 0;
  newHealth = 0;
  lastinvulratio = 1;
  self thread playerHurtcheck();
  self.boltHit = false;
  if(getdvar("scr_playerInvulTimeScale") == "") {
    setdvar("scr_playerInvulTimeScale", 1.0);
  }
  playerInvulTimeScale = getdvarfloat("scr_playerInvulTimeScale");
  if(maps\_collectibles::has_collectible("collectible_vampire")) {
    regenRate = 0.0;
  }
  for(;;) {
    wait(0.05);
    waittillframeend;
    if(self.health == self.maxHealth) {
      if(self player_flag("player_has_red_flashing_overlay")) {
        player_flag_clear("player_has_red_flashing_overlay");
        level notify("take_cover_done");
      }
      lastinvulratio = 1;
      playerJustGotRedFlashing = false;
      veryHurt = false;
      continue;
    }
    if(self.health <= 0) {
      showHitLog();
      return;
    }
    wasVeryHurt = veryHurt;
    ratio = self.health / self.maxHealth;
    if(ratio <= level.healthOverlayCutoff) {
      veryHurt = true;
      if(!wasVeryHurt) {
        hurtTime = gettime();
        level.hurtTime = hurtTime;
        self startfadingblur(3.6, 2);
        self player_flag_set("player_has_red_flashing_overlay");
        playerJustGotRedFlashing = true;
      }
    }
    if(self.hurtAgain) {
      hurtTime = gettime();
      self.hurtAgain = false;
    }
    if(self.health / self.maxHealth >= oldratio) {
      if(gettime() - hurttime < level.playerHealth_RegularRegenDelay) {
        continue;
      }
      if(veryHurt) {
        newHealth = ratio;
        if(gettime() > hurtTime + level.longRegenTime) {
          newHealth += regenRate;
        }
        if(newHealth >= 1) {
          reduceTakeCoverWarnings();
        }
      } else
        newHealth = 1;
      if(newHealth > 1.0) {
        newHealth = 1.0;
      }
      if(newHealth <= 0) {
        return;
      }
      if(newHealth > self.health / self.maxHealth) {
        logRegen(newHealth);
      }
      if(!maps\_collectibles::has_collectible("collectible_vampire")) {
        self setnormalhealth(newHealth);
      }
      oldRatio = self.health / self.maxHealth;
      continue;
    }
    oldratio = lastinvulRatio;
    invulWorthyHealthDrop = oldratio - ratio > level.worthyDamageRatio;
    if(self.health <= 1 && !maps\_collectibles::has_collectible("collectible_vampire")) {
      self setnormalhealth(2 / self.maxHealth);
      invulWorthyHealthDrop = true;
      if(!isDefined(level.player_deathInvulnerableTimeout)) {
        level.player_deathInvulnerableTimeout = 0;
      }
      if(level.player_deathInvulnerableTimeout < gettime()) {
        level.player_deathInvulnerableTimeout = gettime() + getdvarint("player_deathInvulnerableTime");
      }
    }
    oldRatio = self.health / self.maxHealth;
    if(maps\_collectibles::has_collectible("collectible_vampire")) {
      if(self player_flag("vampire_damage")) {
        self player_flag_clear("vampire_damage");
        continue;
      }
    }
    level notify("hit_again");
    health_add = 0;
    hurtTime = gettime();
    level.hurtTime = hurtTime;
    self startfadingblur(3, 0.8);
    if(!invulWorthyHealthDrop || playerInvulTimeScale <= 0.0) {
      logHit(self.health, 0);
      continue;
    }
    if(self player_flag("player_is_invulnerable")) {
      continue;
    }
    self player_flag_set("player_is_invulnerable");
    level notify("player_becoming_invulnerable");
    if(playerJustGotRedFlashing) {
      invulTime = level.invulTime_onShield;
      playerJustGotRedFlashing = false;
    } else if(veryHurt) {
      invulTime = level.invulTime_postShield;
    } else {
      invulTime = level.invulTime_preShield;
    }
    invulTime *= playerInvulTimeScale;
    logHit(self.health, invulTime);
    lastinvulratio = self.health / self.maxHealth;
    self thread playerInvul(invulTime);
  }
}

reduceTakeCoverWarnings() {
  players = get_players();
  if(isDefined(players[0]) && isAlive(players[0])) {
    takeCoverWarnings = getdvarint("takeCoverWarnings");
    if(takeCoverWarnings > 0) {
      takeCoverWarnings--;
      setdvar("takeCoverWarnings", takeCoverWarnings);
      DebugTakeCoverWarnings();
    }
  }
}

DebugTakeCoverWarnings() {
  if(getdvar("scr_debugtakecover") == "") {
    setdvar("scr_debugtakecover", "0");
  }
  if(getdebugdvar("scr_debugtakecover") == "1") {
    iprintln("Warnings remaining: ", getdebugdvarint("takeCoverWarnings") - 3);
  }
}

logHit(newhealth, invulTime) {}
logRegen(newhealth) {}
showHitLog() {}
playerInvul(timer) {
  if(isDefined(self.flashendtime) && self.flashendtime > gettime()) {
    timer = timer * getCurrentDifficultySetting("flashbangedInvulFactor");
  }
  if(timer > 0) {
    self.attackerAccuracy = 0;
    self.ignoreRandomBulletDamage = true;
    level.playerInvulTimeEnd = gettime() + timer * 1000;
    wait(timer);
  }
  self.attackerAccuracy = anim.player_attacker_accuracy;
  self.ignoreRandomBulletDamage = false;
  self player_flag_clear("player_is_invulnerable");
}
grenadeAwareness() {
  if(self.team == "allies") {
    self.grenadeawareness = 0.9;
    return;
  }
  if(self.team == "axis") {
    if(level.gameSkill >= 2) {
      if(randomint(100) < 33) {
        self.grenadeawareness = 0.2;
      }
      else {
        self.grenadeawareness = 0.5;
      }
    } else {
      if(randomint(100) < 33) {
        self.grenadeawareness = 0;
      }
      else {
        self.grenadeawareness = 0.2;
      }
    }
  }
}

playerBreathingSound(healthcap) {
  self endon("disconnect");
  sound_on = false;
  wait(2);
  for(;;) {
    wait(0.2);
    if(!isDefined(self)) {
      return;
    }
    if(self.health <= 0) {
      return;
    }
    ratio = self.health / self.maxHealth;
    if(ratio > level.healthOverlayCutoff) {
      if(sound_on) {
        setclientsysstate("levelNotify", "rfo2", self);
        sound_on = false;
      }
      continue;
    }
    if(!sound_on) {
      sound_on = true;
      setclientsysstate("levelNotify", "rfo1", self);
    }
  }
}

healthOverlay() {
  self endon("disconnect");
  self endon("noHealthOverlay");
  self endon("death");
  self endon("disconnect");
  overlay = newClientHudElem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("overlay_low_health", 640, 480);
  overlay.alignX = "left";
  overlay.alignY = "top";
  overlay.horzAlign = "fullscreen";
  overlay.vertAlign = "fullscreen";
  overlay.alpha = 0;
  wait(0.05);
  level.strings["take_cover"] = spawnStruct();
  level.strings["take_cover"].text = &"GAME_GET_TO_COVER";
  self thread healthOverlay_remove(overlay);
  pulseTime = 0.8;
  for(;;) {
    overlay fadeOverTime(0.5);
    overlay.alpha = 0;
    self player_flag_wait("player_has_red_flashing_overlay");
    self redFlashingOverlay(overlay);
  }
}

compassHealthOverlay() {
  self endon("noHealthOverlay");
  overlay = newHudElem();
  overlay.x = 0;
  overlay.y = 35;
  overlay setshader("overlay_low_health_compass", 336, 168);
  overlay.alignX = "center";
  overlay.alignY = "bottom";
  overlay.horzAlign = "center";
  overlay.vertAlign = "bottom";
  overlay.alpha = 0;
  for(;;) {
    overlay fadeOverTime(0.2);
    overlay.alpha = 0;
    if(!isAlive(self)) {
      break;
    }
    self player_flag_wait("player_has_red_flashing_overlay");
    if(getdvar("compass") == "0") {
      wait .5;
    }
    else {
      self compassFlashingOverlay(overlay);
    }
  }
}

compassFlashingOverlay(overlay) {
  level endon("hit_again");
  self endon("damage");
  fullAlphaTime = gettime() + level.longRegenTime;
  zeroAlphaTime = fullAlphaTime + 500;
  fadeTime = .2;
  fadeFullInterval = .2;
  while(isalive(self)) {
    alpha = 1;
    if(gettime() > fullAlphaTime) {
      alpha = 1 - ((gettime() - fullAlphaTime) / (zeroAlphaTime - fullAlphaTime));
      if(alpha < 0) {
        alpha = 0;
      }
    }
    overlay fadeOverTime(fadeTime);
    overlay.alpha = alpha;
    wait fadeTime + fadeFullInterval;
    overlay fadeOverTime(fadeTime);
    overlay.alpha = alpha * .8;
    wait fadeTime;
    if(alpha <= 0) {
      break;
    }
  }
}

add_hudelm_position_internal(alignY) {
  if(level.console) {
    self.fontScale = 2;
  }
  else {
    self.fontScale = 1.6;
  }
  self.x = 0;
  self.y = -36;
  self.alignX = "center";
  self.alignY = "bottom";
  self.horzAlign = "center";
  self.vertAlign = "middle";
  if(!isDefined(self.background)) {
    return;
  }
  self.background.x = 0;
  self.background.y = -40;
  self.background.alignX = "center";
  self.background.alignY = "middle";
  self.background.horzAlign = "center";
  self.background.vertAlign = "middle";
  if(level.console) {
    self.background setshader("popmenu_bg", 650, 52);
  }
  else {
    self.background setshader("popmenu_bg", 650, 42);
  }
  self.background.alpha = .5;
}

create_warning_elem(ender, player) {
  level.hudelm_unpause_ender = ender;
  level notify("hud_elem_interupt");
  hudelem = newHudElem();
  hudelem add_hudelm_position_internal();
  hudelem thread destroy_warning_elem_when_hit_again(player);
  hudelem thread destroy_warning_elem_when_mission_failed(player);
  hudelem setText(&"GAME_GET_TO_COVER");
  hudelem.fontscale = 2;
  hudelem.alpha = 1;
  hudelem.color = (1, 0.9, 0.9);
  return hudelem;
}

waitTillPlayerIsHitAgain() {
  level endon("hit_again");
  self waittill("damage");
}

destroy_warning_elem_when_hit_again(player) {
  self endon("being_destroyed");
  player waitTillPlayerIsHitAgain();
  fadeout = (!isalive(player));
  self thread destroy_warning_elem(fadeout);
}

destroy_warning_elem_when_mission_failed(player) {
  self endon("being_destroyed");
  flag_wait("missionfailed");
  player thread destroy_warning_elem(true);
}

destroy_warning_elem(fadeout) {
  self notify("being_destroyed");
  self.beingDestroyed = true;
  if(fadeout) {
    self fadeOverTime(0.5);
    self.alpha = 0;
    wait 0.5;
  }
  self notify("death");
  self destroy();
}

mayChangeCoverWarningAlpha(coverWarning) {
  if(!isDefined(coverWarning)) {
    return false;
  }
  if(isDefined(coverWarning.beingDestroyed)) {
    return false;
  }
  return true;
}

fontScaler(scale, timer) {
  self endon("death");
  scale *= 2;
  dif = scale - self.fontscale;
  self changeFontScaleOverTime(timer);
  self.fontscale += dif;
}

fadeFunc(overlay, coverWarning, severity, mult, hud_scaleOnly) {
  pulseTime = 0.8;
  scaleMin = 0.5;
  fadeInTime = pulseTime * 0.1;
  stayFullTime = pulseTime * (.1 + severity * .2);
  fadeOutHalfTime = pulseTime * (0.1 + severity * .1);
  fadeOutFullTime = pulseTime * 0.3;
  remainingTime = pulseTime - fadeInTime - stayFullTime - fadeOutHalfTime - fadeOutFullTime;
  assert(remainingTime >= -.001);
  if(remainingTime < 0) {
    remainingTime = 0;
  }
  halfAlpha = 0.8 + severity * 0.1;
  leastAlpha = 0.5 + severity * 0.3;
  overlay fadeOverTime(fadeInTime);
  overlay.alpha = mult * 1.0;
  if(mayChangeCoverWarningAlpha(coverWarning)) {
    if(!hud_scaleOnly) {
      coverWarning fadeOverTime(fadeInTime);
      coverWarning.alpha = mult * 1.0;
    }
  }
  if(isDefined(coverWarning)) {
    coverWarning thread fontScaler(1.0, fadeInTime);
  }
  wait fadeInTime + stayFullTime;
  overlay fadeOverTime(fadeOutHalfTime);
  overlay.alpha = mult * halfAlpha;
  if(mayChangeCoverWarningAlpha(coverWarning)) {
    if(!hud_scaleOnly) {
      coverWarning fadeOverTime(fadeOutHalfTime);
      coverWarning.alpha = mult * halfAlpha;
    }
  }
  wait fadeOutHalfTime;
  overlay fadeOverTime(fadeOutFullTime);
  overlay.alpha = mult * leastAlpha;
  if(mayChangeCoverWarningAlpha(coverWarning)) {
    if(!hud_scaleOnly) {
      coverWarning fadeOverTime(fadeOutFullTime);
      coverWarning.alpha = mult * leastAlpha;
    }
  }
  if(isDefined(coverWarning)) {
    coverWarning thread fontScaler(0.9, fadeOutFullTime);
  }
  wait fadeOutFullTime;
  wait remainingTime;
}

shouldShowCoverWarning() {
  if(isDefined(level.enable_cover_warning)) {
    return level.enable_cover_warning;
  }
  if(!isAlive(self)) {
    return false;
  }
  if(level.gameskill > 1) {
    return false;
  }
  if(level.missionfailed) {
    return false;
  }
  if(!maps\_load::map_is_early_in_the_game()) {
    return false;
  }
  if(isSplitScreen() || coopGame()) {
    return false;
  }
  takeCoverWarnings = getdvarint("takeCoverWarnings");
  if(takeCoverWarnings <= 3) {
    return false;
  }
  return true;
}

redFlashingOverlay(overlay) {
  self endon("hit_again");
  self endon("damage");
  self endon("death");
  self endon("disconnect");
  coverWarning = undefined;
  if(self shouldShowCoverWarning()) {
    coverWarning = create_warning_elem("take_cover_done", self);
  }
  stopFlashingBadlyTime = gettime() + level.longRegenTime;
  fadeFunc(overlay, coverWarning, 1, 1, false);
  while(gettime() < stopFlashingBadlyTime && isalive(self)) {
    fadeFunc(overlay, coverWarning, .9, 1, false);
  }
  if(isalive(self)) {
    fadeFunc(overlay, coverWarning, .65, 0.8, false);
  }
  if(mayChangeCoverWarningAlpha(coverWarning)) {
    coverWarning fadeOverTime(1.0);
    coverWarning.alpha = 0;
  }
  fadeFunc(overlay, coverWarning, 0, 0.6, true);
  overlay fadeOverTime(0.5);
  overlay.alpha = 0;
  self player_flag_clear("player_has_red_flashing_overlay");
  setclientsysstate("levelNotify", "rfo3", self);
  wait(0.5);
  self notify("take_cover_done");
  self notify("hit_again");
}

healthOverlay_remove(overlay) {
  self endon("disconnect");
  self waittill_any("noHealthOverlay", "death");
  overlay fadeOverTime(3.5);
  overlay.alpha = 0;
}

resetSkill() {
  setskill(true);
}

setTakeCoverWarnings() {
  isPreGameplayLevel = (level.script == "training" || level.script == "cargoship" || level.script == "coup");
  if(getdvarint("takeCoverWarnings") == -1 || isPreGameplayLevel) {
    setdvar("takeCoverWarnings", 3 + 6);
  }
  DebugTakeCoverWarnings();
}

increment_take_cover_warnings_on_death() {
  if(!IsPlayer(self)) {
    return;
  }
  level notify("new_cover_on_death_thread");
  level endon("new_cover_on_death_thread");
  self waittill("death");
  if(!(self player_flag("player_has_red_flashing_overlay"))) {
    return;
  }
  if(level.gameSkill > 1) {
    return;
  }
  warnings = getdvarint("takeCoverWarnings");
  if(warnings < 10) {
    setdvar("takeCoverWarnings", warnings + 1);
  }
  DebugTakeCoverWarnings();
}

hud_debug_add(msg, num) {
  hud_debug_add_display(msg, num, false);
}

hud_debug_add_message(msg) {
  if(!isDefined(level.hudMsgShare)) {
    level.hudMsgShare = [];
  }
  if(!isDefined(level.hudMsgShare[msg])) {
    hud = newHudElem();
    hud.x = level.debugLeft;
    hud.y = level.debugHeight + level.hudNum * 15;
    hud.foreground = 1;
    hud.sort = 100;
    hud.alpha = 1.0;
    hud.alignX = "left";
    hud.horzAlign = "left";
    hud.fontScale = 1.0;
    hud setText(msg);
    level.hudMsgShare[msg] = true;
  }
}

hud_debug_add_display(msg, num, isfloat) {
  hud_debug_add_message(msg);
  num = int(num);
  negative = false;
  if(num < 0) {
    negative = true;
    num *= -1;
  }
  thousands = 0;
  hundreds = 0;
  tens = 0;
  ones = 0;
  while(num >= 10000) {
    num -= 10000;
  }
  while(num >= 1000) {
    num -= 1000;
    thousands++;
  }
  while(num >= 100) {
    num -= 100;
    hundreds++;
  }
  while(num >= 10) {
    num -= 10;
    tens++;
  }
  while(num >= 1) {
    num -= 1;
    ones++;
  }
  offset = 0;
  offsetSize = 10;
  if(thousands > 0) {
    hud_debug_add_num(thousands, offset);
    offset += offsetSize;
    hud_debug_add_num(hundreds, offset);
    offset += offsetSize;
    hud_debug_add_num(tens, offset);
    offset += offsetSize;
    hud_debug_add_num(ones, offset);
    offset += offsetSize;
  } else
  if(hundreds > 0 || isFloat) {
    hud_debug_add_num(hundreds, offset);
    offset += offsetSize;
    hud_debug_add_num(tens, offset);
    offset += offsetSize;
    hud_debug_add_num(ones, offset);
    offset += offsetSize;
  } else
  if(tens > 0) {
    hud_debug_add_num(tens, offset);
    offset += offsetSize;
    hud_debug_add_num(ones, offset);
    offset += offsetSize;
  } else {
    hud_debug_add_num(ones, offset);
    offset += offsetSize;
  }
  if(isFloat) {
    decimalHud = newHudElem();
    decimalHud.x = 204.5;
    decimalHud.y = level.debugHeight + level.hudNum * 15;
    decimalHud.foreground = 1;
    decimalHud.sort = 100;
    decimalHud.alpha = 1.0;
    decimalHud.alignX = "left";
    decimalHud.horzAlign = "left";
    decimalHud.fontScale = 1.0;
    decimalHud setText(".");
    level.hudDebugNum[level.hudDebugNum.size] = decimalHud;
  }
  if(negative) {
    negativeHud = newHudElem();
    negativeHud.x = 195.5;
    negativeHud.y = level.debugHeight + level.hudNum * 15;
    negativeHud.foreground = 1;
    negativeHud.sort = 100;
    negativeHud.alpha = 1.0;
    negativeHud.alignX = "left";
    negativeHud.horzAlign = "left";
    negativeHud.fontScale = 1.0;
    negativeHud setText(" - ");
    level.hudDebugNum[level.hudNum] = negativeHud;
  }
  level.hudNum++;
}

hud_debug_add_string(msg, msg2) {
  hud_debug_add_message(msg);
  hud_debug_add_second_string(msg2, 0);
  level.hudNum++;
}

hud_debug_add_num(num, offset) {
  hud = newHudElem();
  hud.x = 200 + offset * 0.65;
  hud.y = level.debugHeight + level.hudNum * 15;
  hud.foreground = 1;
  hud.sort = 100;
  hud.alpha = 1.0;
  hud.alignX = "left";
  hud.horzAlign = "left";
  hud.fontScale = 1.0;
  hud setText(num + "");
  level.hudDebugNum[level.hudDebugNum.size] = hud;
}

hud_debug_add_second_string(num, offset) {
  hud = newHudElem();
  hud.x = 200 + offset * 0.65;
  hud.y = level.debugHeight + level.hudNum * 15;
  hud.foreground = 1;
  hud.sort = 100;
  hud.alpha = 1.0;
  hud.alignX = "left";
  hud.horzAlign = "left";
  hud.fontScale = 1.0;
  hud setText(num);
  level.hudDebugNum[level.hudDebugNum.size] = hud;
}

aa_init_stats() {}

command_used(cmd) {
  binding = getKeyBinding(cmd);
  if(binding["count"] <= 0) {
    return false;
  }
  return false;
}

aa_add_event(event, amount) {
  old_amount = getdvarint(event);
  setdvar(event, old_amount + amount);
}

aa_add_event_float(event, amount) {
  old_amount = getdvarfloat(event);
  setdvar(event, old_amount + amount);
}

return_false(attacker) {
  return false;
}

player_attacker(attacker) {
  if([[level.custom_player_attacker]](attacker)) {
    return true;
  }
  if(IsPlayer(attacker)) {
    return true;
  }
  if(!isDefined(attacker.car_damage_owner_recorder)) {
    return false;
  }
  return attacker player_did_most_damage();
}

player_did_most_damage() {
  return self.player_damage * 1.75 > self.non_player_damage;
}

empty_kill_func(type, loc, point, attacker) {}
auto_adjust_enemy_died(ai, amount, attacker, type, point) {
  aa_add_event("aa_enemy_deaths", 1);
  if(!isDefined(attacker)) {
    return;
  }
  if(isDefined(ai) && isDefined(ai.attackers)) {
    for(j = 0; j < ai.attackers.size; j++) {
      player = ai.attackers[j];
      if(!isDefined(player)) {
        continue;
      }
      if(player == attacker) {
        continue;
      }
      maps\_challenges_coop::doMissionCallback("playerAssist", player);
      player.assists++;
      arcademode_assignpoints("arcademode_score_assist", player);
    }
    ai.attackers = [];
    ai.attackerData = [];
  }
  if(!player_attacker(attacker)) {
    return;
  }
  if(arcadeMode()) {
    if(isDefined(ai)) {
      ai.anglesOnDeath = ai.angles;
      if(isDefined(attacker)) {
        attacker.anglesOnKill = attacker getPlayerAngles();
      }
    }
    if(attacker.arcademode_bonus["lastKillTime"] == gettime()) {
      attacker.arcademode_bonus["uberKillingMachineStreak"]++;
    } else {
      attacker.arcademode_bonus["uberKillingMachineStreak"] = 1;
    }
    attacker.arcademode_bonus["lastKillTime"] = gettime();
  }
  attacker.kills++;
  damage_location = undefined;
  if(isDefined(ai)) {
    damage_location = ai.damagelocation;
    if(damage_location == "head" || damage_location == "helmet") {
      attacker.headshots++;
    }
  }
  if(arcadeMode()) {
    [[level.global_kill_func]](type, damage_location, point, attacker, ai, attacker.arcademode_bonus["uberKillingMachineStreak"]);
  } else {
    [[level.global_kill_func]](type, damage_location, point, attacker);
  }
  aa_add_event("aa_player_kills", 1);
}

auto_adjust_enemy_death_detection() {
  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, point, type);
    aa_add_event("aa_enemy_damage_taken", amount);
    if(!isalive(self) || self.delayeddeath) {
      level auto_adjust_enemy_died(self, amount, attacker, type, point);
      return;
    }
    if(!player_attacker(attacker)) {
      continue;
    }
    self aa_player_attacks_enemy_with_ads(attacker, amount, type, point);
    if(!isDefined(self) || !isalive(self)) {
      attacker.kills++;
      return;
    }
  }
}

aa_player_attacks_enemy_with_ads(player, amount, type, point) {
  aa_add_event("aa_player_damage_dealt", amount);
  assertex(getdvarint("aa_player_damage_dealt") > 0);
  if(self.health == self.maxhealth || !isDefined(self.attackers)) {
    self.attackers = [];
    self.attackerData = [];
  }
  if(!isDefined(self.attackerData[player getEntityNumber()])) {
    self.attackers[self.attackers.size] = player;
    self.attackerData[player getEntityNumber()] = false;
  }
  if(!isADS(player)) {
    [[level.global_damage_func]](type, self.damagelocation, point, player);
    return false;
  }
  if(!bullet_attack(type)) {
    [[level.global_damage_func]](type, self.damagelocation, point, player);
    return false;
  }
  [[level.global_damage_func_ads]](type, self.damagelocation, point, player);
  aa_add_event("aa_ads_damage_dealt", amount);
  return true;
}

bullet_attack(type) {
  if(type == "MOD_PISTOL_BULLET") {
    return true;
  }
  return type == "MOD_RIFLE_BULLET";
}

add_fractional_data_point(name, frac, val) {
  if(!isDefined(level.difficultySettings_frac_data_points[name])) {
    level.difficultySettings_frac_data_points[name] = [];
  }
  array = [];
  array["frac"] = frac;
  array["val"] = val;
  assertex(frac >= 0, "Tried to set a difficulty data point less than 0.");
  assertex(frac <= 1, "Tried to set a difficulty data point greater than 1.");
  level.difficultySettings_frac_data_points[name][level.difficultySettings_frac_data_points[name].size] = array;
}

coop_enemy_accuracy_scalar_watcher() {
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _gameskill.gsc. Function: coop_enemy_accuracy_scalar_watcher()\n");
  }
  level waittill("load main complete");
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _gameskill.gsc. Function: coop_enemy_accuracy_scalar_watcher() - LOAD MAIN COMPLETE\n");
  }
  if(getdvarint("coop_difficulty_scaling") == 0) {
    return;
  }
  while(1) {
    if(getdebugdvar("replay_debug") == "1") {
      println("File: _gameskill.gsc. Function: coop_enemy_accuracy_scalar_watcher() - INNER LOOP START\n");
    }
    players = get_players();
    level.coop_enemy_accuracy_scalar = getCoopValue("coopEnemyAccuracyScalar", players.size);
    wait(0.5);
    if(getdebugdvar("replay_debug") == "1") {
      println("File: _gameskill.gsc. Function: coop_enemy_accuracy_scalar_watcher() - INNER LOOP STOP\n");
    }
  }
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _gameskill.gsc. Function: coop_enemy_accuracy_scalar_watcher() - COMPLETE\n");
  }
}

coop_friendly_accuracy_scalar_watcher() {
  level waittill("load main complete");
  if(getdvarint("coop_difficulty_scaling") == 0) {
    return;
  }
  while(1) {
    players = get_players();
    level.coop_friendly_accuracy_scalar = getCoopValue("coopFriendlyAccuracyScalar", players.size);
    wait(0.5);
  }
}

coop_axis_accuracy_scaler() {
  self endon("death");
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _gameskill.gsc. Function: coop_axis_accuracy_scaler()\n");
  }
  if(getdvarint("coop_difficulty_scaling") == 0) {
    return;
  }
  while(1) {
    if(!isDefined(level.coop_enemy_accuracy_scalar)) {
      wait 0.5;
      continue;
    }
    if(!isDefined(self.script_accuracy)) {
      self.baseaccuracy = 1 * level.coop_enemy_accuracy_scalar;
    } else {
      return;
    }
    wait randomfloatrange(3, 5);
  }
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _gameskill.gsc. Function: coop_axis_accuracy_scaler() - COMPLETE\n");
  }
}

coop_allies_accuracy_scaler() {
  self endon("death");
  if(getdvarint("coop_difficulty_scaling") == 0) {
    return;
  }
  while(1) {
    if(!isDefined(level.coop_friendly_accuracy_scalar)) {
      wait 0.5;
      continue;
    }
    if(!isDefined(self.script_accuracy)) {
      self.baseaccuracy = 1 * level.coop_friendly_accuracy_scalar;
    } else {
      return;
    }
    wait randomfloatrange(3, 5);
  }
}

coop_player_threat_bias_adjuster() {
  while(1) {
    wait 5;
    if(isDefined(level.script) && level.script == "ber3b") {
      return;
    }
    if(level.auto_adjust_threatbias) {
      players = get_players();
      for(i = 0; i < players.size; i++) {
        enable_auto_adjust_threatbias(players[i]);
      }
    }
  }
}

coop_spawner_count_adjuster() {
  while(!isDefined(level.flag) || !isDefined(level.flag["all_players_connected"])) {
    wait 0.05;
    continue;
  }
  flag_wait("all_players_connected");
  spawners = GetSpawnerArray();
  players = get_players();
  for(i = 0; i < spawners.size; i++) {
    if(isDefined(spawners[i].targetname)) {
      possible_trig = getEntArray(spawners[i].targetname, "target");
      if(isDefined(possible_trig[0])) {
        if(isDefined(possible_trig[0].targetname)) {
          if(possible_trig[0].targetname == "flood_spawner") {
            spawners[i] coop_set_spawner_adjustment_values(players.size);
          }
        }
      }
    }
  }
}

coop_set_spawner_adjustment_values(player_count) {
  if(!isDefined(self.count)) {
    return;
  }
  if(isDefined(self.script_count_lock) && self.script_count_lock) {
    return;
  }
  if(player_count <= 1) {
    return;
  } else if(player_count == 2) {
    self.count = self.count + int(self.count * 0.75);
  } else if(player_count == 3) {
    self.count = self.count + int(self.count * 1.5);
  } else if(player_count == 4) {
    self.count = self.count + int(self.count * 2.5);
  } else {
    println("You've performed magic, sir.");
  }
}