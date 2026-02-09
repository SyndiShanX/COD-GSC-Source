/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_gameskill.gsc
**************************************/

#include maps\_utility;
#include animscripts\utility;
#include common_scripts\utility;

setSkill(reset, skill_override) {
  if(!isDefined(level.script)) {
    level.script = tolower(getDvar(#"mapname"));
  }
  if(!isDefined(reset) || reset == false) {
    if(isDefined(level.gameSkill)) {
      return;
    }
    if(!isDefined(level.custom_player_attacker)) {
      level.custom_player_attacker = ::return_false;
    }
    level.global_damage_func_ads = ::empty_kill_func;
    level.global_damage_func = ::empty_kill_func;
    level.global_kill_func = ::empty_kill_func;
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
    level thread update_skill_on_change();
  }
  if(!isDefined(level.invulTime_onShield_multiplier)) {
    level.invulTime_onShield_multiplier = 1;
  }
  if(!isDefined(level.player_attacker_accuracy_multiplier)) {
    level.player_attacker_accuracy_multiplier = 1;
  }
  level.gameSkill = GetDvarInt(#"g_gameskill");
  if(isDefined(skill_override)) {
    level.gameSkill = skill_override;
  }
  setDvar("saved_gameskill", level.gameSkill);
  switch (level.gameSkill) {
    case 0:
      setDvar("currentDifficulty", "easy");
      break;
    case 1:
      setDvar("currentDifficulty", "normal");
      break;
    case 2:
      setDvar("currentDifficulty", "hardened");
      break;
    case 3:
      setDvar("currentDifficulty", "veteran");
      break;
  }
  if(getDvar(#"autodifficulty_playerDeathTimer") == "") {
    setDvar("autodifficulty_playerDeathTimer", 0);
  }
  anim.run_accuracy = 0.5;
  logString("difficulty: " + level.gameSkill);
  setDvar("autodifficulty_frac", 0);
  setDvar("coop_difficulty_scaling", 1);
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
      setDvar("autodifficulty_frac", dif_frac);
    }
    set_difficulty_from_current_aa_frac();
  } else {
    set_difficulty_from_locked_settings();
  }
  setDvar("autodifficulty_original_setting", level.gameskill);
  if(getDvar(#"g_gametype") != "vs") {
    setsaveddvar("player_meleeDamageMultiplier", 100 / 250);
  }
  thread coop_enemy_accuracy_scalar_watcher();
  thread coop_friendly_accuracy_scalar_watcher();
  thread coop_player_threat_bias_adjuster();
  thread coop_spawner_count_adjuster();
}
get_skill_from_index(index) {
  return level.difficultyType[index];
}
apply_difficulty_frac_with_func(difficulty_func, current_frac) {
  level.invulTime_preShield = [[difficulty_func]]("invulTime_preShield", current_frac);
  level.invulTime_onShield = [[difficulty_func]]("invulTime_onShield", current_frac) * level.invulTime_onShield_multiplier;
  level.invulTime_postShield = [[difficulty_func]]("invulTime_postShield", current_frac);
  level.playerHealth_RegularRegenDelay = [[difficulty_func]]("playerHealth_RegularRegenDelay", current_frac);
  level.worthyDamageRatio = [[difficulty_func]]("worthyDamageRatio", current_frac);
  if(level.auto_adjust_threatbias) {
    thread apply_threat_bias_to_all_players(difficulty_func, current_frac);
  }
  level.longRegenTime = [[difficulty_func]]("longRegenTime", current_frac);
  level.healthOverlayCutoff = [[difficulty_func]]("healthOverlayCutoff", current_frac);
  anim.player_attacker_accuracy = [[difficulty_func]]("base_enemy_accuracy", current_frac) * level.player_attacker_accuracy_multiplier;
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
  if(getDvar(#"g_gametype") != "vs") {
    setsaveddvar("player_damageMultiplier", 100 / ([[difficulty_func]]("playerDifficultyHealth", current_frac) * coop_healthscalar));
    coop_invuln_remover = getCoopValue("coopPlayer_deathInvulnerableTime", players.size);
    setsaveddvar("player_deathInvulnerableTime", int([[difficulty_func]]("player_deathInvulnerableTime", current_frac) * coop_invuln_remover));
  }
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
  level.auto_adjust_difficulty_frac = GetDvarInt(#"autodifficulty_frac");
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
getCurrentDifficultySetting(msg) {
  return level.difficultySettings[msg][get_skill_from_index(level.gameskill)];
}
getRatio(msg, min, max) {
  return (level.difficultySettings[msg][level.difficultyType[min]] * (100 - GetDvarInt(#"autodifficulty_frac")) + level.difficultySettings[msg][level.difficultyType[max]] * GetDvarInt(#"autodifficulty_frac")) * 0.01;
}
getCoopValue(msg, numplayers) {
  if(numplayers <= 0) {
    numplayers = 1;
  }
  return (level.difficultySettings[msg][getDvar(#"currentDifficulty")][numplayers - 1]);
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
  if(!isPlayer(self.enemy)) {
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
didSomethingOtherThanShooting() {
  self.a.missTimeDebounce = 0;
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
  if(!isPlayer(self.enemy)) {
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
playerHurtcheck() {
  self.hurtAgain = false;
  for(;;) {
    self waittill("damage", amount, attacker, dir, point, mod);
    if(isDefined(attacker) && isPlayer(attacker) && attacker.team == self.team) {
      continue;
    }
    self.hurtAgain = true;
    self.damagePoint = point;
    self.damageAttacker = attacker;
    if(isDefined(mod) && mod == "MOD_BURNED") {
      self setburn(0.5);
      self playSound("chr_burn");
    }
  }
}
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
  if(!isDefined(level.zombiemode) || !level.zombiemode) {
    self thread playerBreathingSound(self.maxhealth * 0.35);
    self thread playerHeartbeatSound(self.maxhealth * 0.75);
    self thread endPlayerBreathingSoundOnDeath();
  }
  invulTime = 0;
  hurtTime = 0;
  newHealth = 0;
  lastinvulratio = 1;
  self thread playerHurtcheck();
  if(!isDefined(self.veryhurt)) {
    self.veryhurt = 0;
  }
  self.boltHit = false;
  if(getDvar(#"scr_playerInvulTimeScale") == "") {
    setDvar("scr_playerInvulTimeScale", 1.0);
  }
  playerInvulTimeScale = GetDvarFloat(#"scr_playerInvulTimeScale");
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
      return;
    }
    wasVeryHurt = veryHurt;
    health_ratio = self.health / self.maxHealth;
    if(health_ratio <= level.healthOverlayCutoff) {
      veryHurt = true;
      if(!wasVeryHurt) {
        hurtTime = gettime();
        self startfadingblur(3.6, 2);
        self player_flag_set("player_has_red_flashing_overlay");
        playerJustGotRedFlashing = true;
      }
    }
    if(self.hurtAgain) {
      hurtTime = gettime();
      self.hurtAgain = false;
    }
    if(health_ratio >= oldratio) {
      if(gettime() - hurttime < level.playerHealth_RegularRegenDelay) {
        continue;
      }
      if(veryHurt) {
        self.veryhurt = 1;
        newHealth = health_ratio;
        if(gettime() > hurtTime + level.longRegenTime) {
          newHealth += regenRate;
        }
        if(newHealth >= 1) {
          reduceTakeCoverWarnings();
        }
      } else {
        newHealth = 1;
        self.veryhurt = 0;
      }
      if(newHealth > 1.0) {
        newHealth = 1.0;
      }
      if(newHealth <= 0) {
        return;
      }
      self setnormalhealth(newHealth);
      oldratio = self.health / self.maxHealth;
      continue;
    }
    invulWorthyHealthDrop = lastinvulRatio - health_ratio > level.worthyDamageRatio;
    if(self.health <= 1) {
      self setnormalhealth(2 / self.maxHealth);
      invulWorthyHealthDrop = true;
    }
    oldratio = self.health / self.maxHealth;
    level notify("hit_again");
    health_add = 0;
    hurtTime = gettime();
    self startfadingblur(3, 0.8);
    if(!invulWorthyHealthDrop || playerInvulTimeScale <= 0.0) {
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
    lastinvulratio = self.health / self.maxHealth;
    self thread playerInvul(invulTime);
  }
}
reduceTakeCoverWarnings() {
  players = get_players();
  if(isDefined(players[0]) && isAlive(players[0])) {
    takeCoverWarnings = GetDvarInt(#"takeCoverWarnings");
    if(takeCoverWarnings > 0) {
      takeCoverWarnings--;
      setDvar("takeCoverWarnings", takeCoverWarnings);
    }
  }
}
playerInvul(timer) {
  if(isDefined(self.flashendtime) && self.flashendtime > gettime()) {
    timer = timer * getCurrentDifficultySetting("flashbangedInvulFactor");
  }
  if(timer > 0) {
    self.attackerAccuracy = 0;
    self.ignoreRandomBulletDamage = true;
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
      } else {
        self.grenadeawareness = 0.5;
      }
    } else {
      if(randomint(100) < 33) {
        self.grenadeawareness = 0;
      } else {
        self.grenadeawareness = 0.2;
      }
    }
  }
}
playerBreathingSound(healthcap) {
  self endon("end_healthregen");
  self endon("disconnect");
  self endon("killed_player");
  if(!isDefined(level.player_pain_vox)) {
    level.player_pain_vox = 0;
  }
  wait(2);
  player = self;
  for(;;) {
    wait(0.2);
    if(player.health <= 0) {
      level.player_pain_vox = 0;
      return;
    }
    if(player.health >= healthcap) {
      player notify("end_heartbeat_loop");
      continue;
    }
    if(level.player_pain_vox == 0) {
      playsoundatposition("chr_breathing_hurt_start", (0, 0, 0));
      level.player_pain_vox = 1;
    } else {
      player playLocalSound("chr_breathing_hurt");
    }
    wait .545;
    wait(0.1 + randomfloat(0.8));
  }
}
playerHeartbeatSound(healthcap) {
  self endon("disconnect");
  self endon("killed_player");
  level thread heartbeat_init();
  self.breathingStopTime = -10000;
  self.hearbeatwait = .46;
  wait(2);
  player = self;
  for(;;) {
    wait .2;
    if(player.health >= healthcap) {
      continue;
    }
    level thread event_heart_beat("stressed", 1);
    level notify("player_pain");
    player waittill("end_heartbeat_loop");
    wait(1.5);
    level thread event_heart_beat("none", 0);
    level.player_pain_vox = 0;
  }
}
heartbeat_init() {
  level.current_heart_waittime = 2;
  level.heart_waittime = 2;
  level.current_breathing_waittime = 4;
  level.breathing_waittime = 4;
  level.emotional_state_system = 0;
}
event_heart_beat(emotion, loudness) {
  level.current_emotion = emotion;
  if(!isDefined(level.last_emotion)) {
    level.last_emotion = "undefined";
  }
  if(level.current_emotion != level.last_emotion) {
    if(level.emotional_state_system == 0) {
      level.emotional_state_system = 1;
      level thread play_heart_beat();
      level thread play_breathing();
    }
    if(!isDefined(loudness) || (loudness == 0)) {
      level.loudness = 0;
    } else {
      level.loudness = loudness;
    }
    switch (emotion) {
      case "sedated":
        level.heart_waittime = 3;
        level.breathing_waittime = 4;
        level.last_emotion = "sedated";
        break;
      case "relaxed":
        level.heart_waittime = 2;
        level.breathing_waittime = 4;
        level.last_emotion = "relaxed";
        break;
      case "stressed":
        level.heart_waittime = 0.5;
        level.breathing_waittime = 2;
        level.last_emotion = "stressed";
        break;
      case "panicked":
        level.heart_waittime = 0.3;
        level.breathing_waittime = 1.5;
        level.last_emotion = "panicked";
        break;
      case "none":
        level.last_emotion = "none";
        level notify("no_more_heartbeat");
        playsoundatposition("vox_breath_scared_stop", (0, 0, 0));
        level.emotional_state_system = 0;
        break;
      default:
        AssertMsg("Not a Valid Emotional State.Please switch with sedated, relaxed, happy, stressed, or none");
    }
    thread heartbeat_state_transitions();
  }
}
heartbeat_state_transitions() {
  while(level.current_heart_waittime > level.heart_waittime) {
    level.current_heart_waittime = level.current_heart_waittime - .10;
    wait(.30);
  }
  while(level.current_heart_waittime < level.heart_waittime) {
    level.current_heart_waittime = level.current_heart_waittime + .05;
    wait(.40);
  }
  level.current_heart_waittime = level.heart_waittime;
}
play_heart_beat() {
  player = getplayers()[0];
  level endon("no_more_heartbeat");
  if(!isDefined(level.heart_wait_counter)) {
    level.heart_wait_counter = 0;
  }
  while(1) {
    while(level.heart_wait_counter < level.current_heart_waittime) {
      wait(0.1);
      level.heart_wait_counter = level.heart_wait_counter + 0.1;
    }
    if(level.loudness == 0) {
      playsoundatposition("chr_heart_beat_ingame", (0, 0, 0));
    } else {
      playsoundatposition("chr_heart_beat_ingame", (0, 0, 0));
    }
    level.heart_wait_counter = 0;
  }
}
play_breathing() {
  level endon("no_more_heartbeat");
  if(!isDefined(level.breathing_wait_counter)) {
    level.breathing_wait_counter = 0;
  }
  for(;;) {
    while(level.breathing_wait_counter < level.current_breathing_waittime) {
      wait(0.1);
      level.breathing_wait_counter = level.breathing_wait_counter + 0.1;
    }
    playsoundatposition("amb_player_breath_cold", (0, 0, 0));
    level.breathing_wait_counter = 0;
  }
}
base_jump_heartbeat_stop() {
  flag_wait("players_jumped");
  level thread event_heart_beat("none", 0);
}
endPlayerBreathingSoundOnDeath() {
  self endon("disconnect");
  self waittill_either("killed_player", "death");
  setclientsysstate("levelNotify", "rfo2", self);
}
old_style_health_overlay() {
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
new_style_health_overlay() {
  overlay = NewClientHudElem(self);
  overlay.x = 0;
  overlay.y = 0;
  if(issplitscreen()) {
    overlay SetShader("overlay_low_health_splat", 640, 480 * 2);
    if(self == level.players[0]) {
      overlay.y -= 120;
    }
  } else {
    overlay SetShader("overlay_low_health_splat", 640, 480);
  }
  overlay.splatter = true;
  overlay.alignX = "left";
  overlay.alignY = "top";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.horzAlign = "fullscreen";
  overlay.vertAlign = "fullscreen";
  overlay.alpha = 0;
  thread healthOverlay_remove(overlay);
  updateTime = 0.05;
  timeToFadeOut = 0.75;
  while(1) {
    wait updateTime;
    if(isDefined(level.disable_damage_overlay_in_vehicle) && level.disable_damage_overlay_in_vehicle) {
      targetDamageAlpha = 0;
    } else {
      targetDamageAlpha = 1.0 - self.health / self.maxHealth;
    }
    if(overlay.alpha < targetDamageAlpha) {
      overlay.alpha = targetDamageAlpha;
    } else if((targetDamageAlpha == 0) && (overlay.alpha != 0)) {
      overlay FadeOverTime(timeToFadeOut);
      overlay.alpha = 0;
      self playSound("chr_breathing_better");
    }
  }
}
healthOverlay() {
  self endon("disconnect");
  self endon("noHealthOverlay");
  if(getDvar(#"zombiemode") == "1") {
    old_style_health_overlay();
  } else {
    new_style_health_overlay();
  }
}
add_hudelm_position_internal(alignY) {
  if(level.console) {
    self.fontScale = 2;
  } else {
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
  } else {
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
  player thread play_hurt_vox();
  return hudelem;
}
play_hurt_vox() {
  if(isDefined(self.veryhurt)) {
    if(self.veryhurt == 0) {
      if(randomintrange(0, 1) == 1) {
        playsoundatposition("chr_breathing_hurt_start", self.origin);
      }
    }
  }
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
  self death_notify_wrapper();
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
  if(!maps\_load_common::map_is_early_in_the_game()) {
    return false;
  }
  if(isSplitScreen() || coopGame()) {
    return false;
  }
  takeCoverWarnings = GetDvarInt(#"takeCoverWarnings");
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
  if(getDvar(#"zombiemode") == "1") {
    overlay fadeOverTime(3.5);
    overlay.alpha = 0;
  } else {
    overlay fadeOverTime(3.5);
    overlay.alpha = 0;
  }
}
setTakeCoverWarnings() {
  isPreGameplayLevel = (level.script == "training" || level.script == "cargoship" || level.script == "coup");
  if(GetDvarInt(#"takeCoverWarnings") == -1 || isPreGameplayLevel) {
    setDvar("takeCoverWarnings", 3 + 6);
  }
}
increment_take_cover_warnings_on_death() {
  if(!isPlayer(self)) {
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
  warnings = GetDvarInt(#"takeCoverWarnings");
  if(warnings < 10) {
    setDvar("takeCoverWarnings", warnings + 1);
  }
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
  } else if(hundreds > 0 || isFloat) {
    hud_debug_add_num(hundreds, offset);
    offset += offsetSize;
    hud_debug_add_num(tens, offset);
    offset += offsetSize;
    hud_debug_add_num(ones, offset);
    offset += offsetSize;
  } else if(tens > 0) {
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
aa_add_event(event, amount) {
  old_amount = getdvarint(event);
  setDvar(event, old_amount + amount);
}
return_false(attacker) {
  return false;
}
player_attacker(attacker) {
  if([[level.custom_player_attacker]](attacker)) {
    return true;
  }
  if(isPlayer(attacker)) {
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
empty_kill_func(type, loc, point, attacker, amount) {}
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
      if("0" == getDvar(#"zombiemode")) {
        player.assists++;
      }
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
      if(!isDefined(level.zombietron_mode)) {
        attacker.headshots++;
      }
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
    if(!isDefined(amount)) {
      continue;
    }
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
  assertex(GetDvarInt(#"aa_player_damage_dealt") > 0);
  if(self.health == self.maxhealth || !isDefined(self.attackers)) {
    self.attackers = [];
    self.attackerData = [];
  }
  if(!isDefined(self.attackerData[player getEntityNumber()])) {
    self.attackers[self.attackers.size] = player;
    self.attackerData[player getEntityNumber()] = false;
  }
  if(!isADS(player)) {
    [[level.global_damage_func]](type, self.damagelocation, point, player, amount);
    return false;
  }
  if(!bullet_attack(type)) {
    [[level.global_damage_func]](type, self.damagelocation, point, player, amount);
    return false;
  }
  [[level.global_damage_func_ads]](type, self.damagelocation, point, player, amount);
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
update_skill_on_change() {
  waittillframeend;
  for(;;) {
    lowest_current_skill = GetDvarInt(#"saved_gameskill");
    gameskill = GetDvarInt(#"g_gameskill");
    if(gameskill < lowest_current_skill) {
      lowest_current_skill = gameskill;
    }
    if(lowest_current_skill < level.gameskill) {
      setSkill(true, lowest_current_skill);
    }
    wait(0.1);
  }
}
coop_enemy_accuracy_scalar_watcher() {
  level waittill("load main complete");
  if(GetDvarInt(#"coop_difficulty_scaling") == 0) {
    return;
  }
  while(1) {
    players = get_players("allies");
    level.coop_enemy_accuracy_scalar = getCoopValue("coopEnemyAccuracyScalar", players.size);
    wait(0.5);
  }
}
coop_friendly_accuracy_scalar_watcher() {
  level waittill("load main complete");
  if(GetDvarInt(#"coop_difficulty_scaling") == 0) {
    return;
  }
  while(1) {
    players = get_players("allies");
    level.coop_friendly_accuracy_scalar = getCoopValue("coopFriendlyAccuracyScalar", players.size);
    wait(0.5);
  }
}
coop_axis_accuracy_scaler() {
  self endon("death");
  if(GetDvarInt(#"coop_difficulty_scaling") == 0) {
    return;
  }
  initialValue = self.baseAccuracy;
  while(1) {
    if(!isDefined(level.coop_enemy_accuracy_scalar)) {
      wait 0.5;
      continue;
    }
    self.baseAccuracy = initialValue * level.coop_enemy_accuracy_scalar;
    wait randomfloatrange(3, 5);
  }
}
coop_allies_accuracy_scaler() {
  self endon("death");
  if(GetDvarInt(#"coop_difficulty_scaling") == 0) {
    return;
  }
  initialValue = self.baseAccuracy;
  while(1) {
    if(!isDefined(level.coop_friendly_accuracy_scalar)) {
      wait 0.5;
      continue;
    }
    self.baseAccuracy = initialValue * level.coop_friendly_accuracy_scalar;
    wait randomfloatrange(3, 5);
  }
}
coop_player_threat_bias_adjuster() {
  while(1) {
    wait 5;
    if(level.auto_adjust_threatbias) {
      players = get_players("allies");
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
  players = get_players("allies");
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