/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\gameskill.gsc
***********************************************/

#using scripts\anim\combat_utility;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\common\gameskill;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\hud_util;
#using scripts\sp\mgturret;
#using scripts\sp\player;
#using scripts\sp\utility;
#namespace gameskill;

function init_gameskill() {
  if(!add_init_script("gameskill", &init_gameskill)) {
    return;
  }

  auto_adjust_init();
  scripts\sp\player::init();
  level.player.gameskill = level.player function_1f031ab8afbe2335();
  function_4170d039e7278e9e(level.player.gameskill);
  set_early_level();
  setskill();
}

function setskill(reset) {
  if(!istrue(reset)) {
    if(isDefined(level.gameskill)) {
      return;
    }

    level.difficultytype[0] = "supereasy";
    level.difficultytype[1] = "easy";
    level.difficultytype[2] = "normal";
    level.difficultytype[3] = "hardened";
    level.difficultytype[4] = "veteran";
    level.difficultytype[5] = "realism";
    level.difficultystring["easy"] = &"GAMESKILL_EASY";
    level.difficultystring["normal"] = &"GAMESKILL_NORMAL";
    level.difficultystring["hardened"] = &"GAMESKILL_HARDENED";
    level.difficultystring["veteran"] = &"GAMESKILL_VETERAN";
    level.difficultystring["realism"] = &"GAMESKILL_REALISM";
    thread gameskill_change_monitor();
  }

  anim.run_accuracy = 0.5;
  anim.walk_accuracy = 0.8;
  level.mg42badplace_mintime = 8;
  level.mg42badplace_maxtime = 16;
  level.difficultysettings["playerGrenadeBaseTime"]["easy"] = 40000;
  level.difficultysettings["playerGrenadeBaseTime"]["normal"] = 35000;
  level.difficultysettings["playerGrenadeBaseTime"]["hardened"] = 25000;
  level.difficultysettings["playerGrenadeBaseTime"]["veteran"] = 25000;
  level.difficultysettings["playerGrenadeBaseTime"]["realism"] = 25000;
  level.difficultysettings["playerGrenadeRangeTime"]["easy"] = 20000;
  level.difficultysettings["playerGrenadeRangeTime"]["normal"] = 15000;
  level.difficultysettings["playerGrenadeRangeTime"]["hardened"] = 10000;
  level.difficultysettings["playerGrenadeRangeTime"]["veteran"] = 10000;
  level.difficultysettings["playerGrenadeRangeTime"]["realism"] = 10000;
  level.difficultysettings["playerDoubleGrenadeTime"]["easy"] = 3600000;
  level.difficultysettings["playerDoubleGrenadeTime"]["normal"] = 150000;
  level.difficultysettings["playerDoubleGrenadeTime"]["hardened"] = 90000;
  level.difficultysettings["playerDoubleGrenadeTime"]["veteran"] = 90000;
  level.difficultysettings["playerDoubleGrenadeTime"]["realism"] = 90000;
  level.difficultysettings["double_grenades_allowed"]["easy"] = 0;
  level.difficultysettings["double_grenades_allowed"]["normal"] = 1;
  level.difficultysettings["double_grenades_allowed"]["hardened"] = 1;
  level.difficultysettings["double_grenades_allowed"]["veteran"] = 1;
  level.difficultysettings["double_grenades_allowed"]["realism"] = 1;
  level.difficultysettings["threatbias"]["easy"] = 100;
  level.difficultysettings["threatbias"]["normal"] = 150;
  level.difficultysettings["threatbias"]["hardened"] = 200;
  level.difficultysettings["threatbias"]["veteran"] = 1400;
  level.difficultysettings["threatbias"]["realism"] = 1400;
  level.difficultysettings["base_enemy_accuracy"]["easy"] = 1;
  level.difficultysettings["base_enemy_accuracy"]["normal"] = 1;
  level.difficultysettings["base_enemy_accuracy"]["hardened"] = 1;
  level.difficultysettings["base_enemy_accuracy"]["veteran"] = 1;
  level.difficultysettings["base_enemy_accuracy"]["realism"] = 1;
  level.difficultysettings["accuracyDistScale"]["easy"] = 1;
  level.difficultysettings["accuracyDistScale"]["normal"] = 1;
  level.difficultysettings["accuracyDistScale"]["hardened"] = 0.6;
  level.difficultysettings["accuracyDistScale"]["veteran"] = 0.1;
  level.difficultysettings["accuracyDistScale"]["realism"] = 0.1;
  level.difficultysettings["min_sniper_burst_delay_time"]["easy"] = 3;
  level.difficultysettings["min_sniper_burst_delay_time"]["normal"] = 2;
  level.difficultysettings["min_sniper_burst_delay_time"]["hardened"] = 1.5;
  level.difficultysettings["min_sniper_burst_delay_time"]["veteran"] = 1.1;
  level.difficultysettings["min_sniper_burst_delay_time"]["realism"] = 1.1;
  level.difficultysettings["sniper_converge_scale"]["easy"] = 1.3;
  level.difficultysettings["sniper_converge_scale"]["normal"] = 1.1;
  level.difficultysettings["sniper_converge_scale"]["hardened"] = 0.9;
  level.difficultysettings["sniper_converge_scale"]["veteran"] = 0.7;
  level.difficultysettings["sniper_converge_scale"]["realism"] = 0.7;
  level.difficultysettings["sniperAccuDiffScale"]["easy"] = 5.6;
  level.difficultysettings["sniperAccuDiffScale"]["normal"] = 5.6;
  level.difficultysettings["sniperAccuDiffScale"]["hardened"] = 5.6;
  level.difficultysettings["sniperAccuDiffScale"]["veteran"] = 5.6;
  level.difficultysettings["sniperAccuDiffScale"]["realism"] = 5.6;
  level.difficultysettings["max_sniper_burst_delay_time"]["easy"] = 4;
  level.difficultysettings["max_sniper_burst_delay_time"]["normal"] = 3;
  level.difficultysettings["max_sniper_burst_delay_time"]["hardened"] = 2;
  level.difficultysettings["max_sniper_burst_delay_time"]["veteran"] = 1.5;
  level.difficultysettings["max_sniper_burst_delay_time"]["realism"] = 1.5;
  level.difficultysettings["pain_test"]["easy"] = &always_pain;
  level.difficultysettings["pain_test"]["normal"] = &always_pain;
  level.difficultysettings["pain_test"]["hardened"] = &scripts\common\gameskill::pain_protection;
  level.difficultysettings["pain_test"]["veteran"] = &scripts\common\gameskill::pain_protection;
  level.difficultysettings["pain_test"]["realism"] = &scripts\common\gameskill::pain_protection;
  level.difficultysettings["missTimeConstant"]["supereasy"] = 1.2;
  level.difficultysettings["missTimeConstant"]["easy"] = 1;
  level.difficultysettings["missTimeConstant"]["normal"] = 0.05;
  level.difficultysettings["missTimeConstant"]["hardened"] = 0;
  level.difficultysettings["missTimeConstant"]["veteran"] = 0;
  level.difficultysettings["missTimeConstant"]["realism"] = 0;
  level.difficultysettings["missTimeDistanceFactor"]["supereasy"] = 0.0009;
  level.difficultysettings["missTimeDistanceFactor"]["easy"] = 0.0008;
  level.difficultysettings["missTimeDistanceFactor"]["normal"] = 0.0001;
  level.difficultysettings["missTimeDistanceFactor"]["hardened"] = 5e-05;
  level.difficultysettings["missTimeDistanceFactor"]["veteran"] = 0;
  level.difficultysettings["missTimeDistanceFactor"]["realism"] = 0;
  level.difficultysettings["player_maxFlashBangTime"]["easy"] = 6;
  level.difficultysettings["player_maxFlashBangTime"]["normal"] = 8;
  level.difficultysettings["player_maxFlashBangTime"]["hardened"] = 9;
  level.difficultysettings["player_maxFlashBangTime"]["veteran"] = 10;
  level.difficultysettings["player_maxFlashBangTime"]["realism"] = 10;
  level.difficultysettings["invulTime_onDamage"]["supereasy"] = 0.5;
  level.difficultysettings["invulTime_onDamage"]["easy"] = 0.35;
  level.difficultysettings["invulTime_onDamage"]["normal"] = 0.3;
  level.difficultysettings["invulTime_onDamage"]["hardened"] = 0.2;
  level.difficultysettings["invulTime_onDamage"]["veteran"] = 0.2;
  level.difficultysettings["invulTime_onDamage"]["realism"] = 0.2;
  level.difficultysettings["invulTime_deathShieldDuration"]["supereasy"] = 4;
  level.difficultysettings["invulTime_deathShieldDuration"]["easy"] = 4;
  level.difficultysettings["invulTime_deathShieldDuration"]["normal"] = 1.7;
  level.difficultysettings["invulTime_deathShieldDuration"]["hardened"] = 0.9;
  level.difficultysettings["invulTime_deathShieldDuration"]["veteran"] = 0.25;
  level.difficultysettings["invulTime_deathShieldDuration"]["realism"] = 0.25;

  if(function_3cb5da19764baa3() == "T10") {
    level.difficultysettings["invulTime_deathShieldDuration"]["normal"] = 3.4;
  }

  level.difficultysettings["player_deathsDoorDuration"]["supereasy"] = 3;
  level.difficultysettings["player_deathsDoorDuration"]["easy"] = 3.5;
  level.difficultysettings["player_deathsDoorDuration"]["normal"] = 6;
  level.difficultysettings["player_deathsDoorDuration"]["hardened"] = 7;
  level.difficultysettings["player_deathsDoorDuration"]["veteran"] = 8;
  level.difficultysettings["player_deathsDoorDuration"]["realism"] = 8;
  level.difficultysettings["player_healthRegenDelay"]["supereasy"] = 2;
  level.difficultysettings["player_healthRegenDelay"]["easy"] = 2.5;
  level.difficultysettings["player_healthRegenDelay"]["normal"] = 3;
  level.difficultysettings["player_healthRegenDelay"]["hardened"] = 4;
  level.difficultysettings["player_healthRegenDelay"]["veteran"] = 5.05;
  level.difficultysettings["player_healthRegenDelay"]["realism"] = 5.05;
  level.difficultysettings["player_swimBreathTime"]["supereasy"] = 25;
  level.difficultysettings["player_swimBreathTime"]["easy"] = 25;
  level.difficultysettings["player_swimBreathTime"]["normal"] = 25;
  level.difficultysettings["player_swimBreathTime"]["hardened"] = 25;
  level.difficultysettings["player_swimBreathTime"]["veteran"] = 25;
  level.difficultysettings["player_swimBreathTime"]["realism"] = 25;
  level.difficultysettings["player_swimSprintBreathTime"]["supereasy"] = 11;
  level.difficultysettings["player_swimSprintBreathTime"]["easy"] = 11;
  level.difficultysettings["player_swimSprintBreathTime"]["normal"] = 11;
  level.difficultysettings["player_swimSprintBreathTime"]["hardened"] = 11;
  level.difficultysettings["player_swimSprintBreathTime"]["veteran"] = 11;
  level.difficultysettings["player_swimSprintBreathTime"]["realism"] = 11;
  level.difficultysettings["player_swimBreathTimeCrit"]["supereasy"] = 6;
  level.difficultysettings["player_swimBreathTimeCrit"]["easy"] = 6;
  level.difficultysettings["player_swimBreathTimeCrit"]["normal"] = 6;
  level.difficultysettings["player_swimBreathTimeCrit"]["hardened"] = 6;
  level.difficultysettings["player_swimBreathTimeCrit"]["veteran"] = 6;
  level.difficultysettings["player_swimBreathTimeCrit"]["realism"] = 6;
  level.difficultysettings["player_swimBreathTimeCritSprint"]["supereasy"] = 3;
  level.difficultysettings["player_swimBreathTimeCritSprint"]["easy"] = 3;
  level.difficultysettings["player_swimBreathTimeCritSprint"]["normal"] = 3;
  level.difficultysettings["player_swimBreathTimeCritSprint"]["hardened"] = 3;
  level.difficultysettings["player_swimBreathTimeCritSprint"]["veteran"] = 3;
  level.difficultysettings["player_swimBreathTimeCritSprint"]["realism"] = 3;
  level.difficultysettings["player_swimBreathFillTime"]["supereasy"] = 2;
  level.difficultysettings["player_swimBreathFillTime"]["easy"] = 2;
  level.difficultysettings["player_swimBreathFillTime"]["normal"] = 2;
  level.difficultysettings["player_swimBreathFillTime"]["hardened"] = 2;
  level.difficultysettings["player_swimBreathFillTime"]["veteran"] = 2;
  level.difficultysettings["player_swimBreathFillTime"]["realism"] = 2;
  level.difficultysettings["player_healthRegenRate"]["supereasy"] = 40;
  level.difficultysettings["player_healthRegenRate"]["easy"] = 40;
  level.difficultysettings["player_healthRegenRate"]["normal"] = 40;
  level.difficultysettings["player_healthRegenRate"]["hardened"] = 40;
  level.difficultysettings["player_healthRegenRate"]["veteran"] = 40;
  level.difficultysettings["player_healthRegenRate"]["realism"] = 40;
  level.difficultysettings["player_fireEngulfRate"]["supereasy"] = 0.3;
  level.difficultysettings["player_fireEngulfRate"]["easy"] = 0.4;
  level.difficultysettings["player_fireEngulfRate"]["normal"] = 0.5;
  level.difficultysettings["player_fireEngulfRate"]["hardened"] = 0.6;
  level.difficultysettings["player_fireEngulfRate"]["veteran"] = 0.6;
  level.difficultysettings["player_fireEngulfRate"]["realism"] = 0.6;
  level.difficultysettings["player_fireInvulSeconds"]["supereasy"] = 2;
  level.difficultysettings["player_fireInvulSeconds"]["easy"] = 2;
  level.difficultysettings["player_fireInvulSeconds"]["normal"] = 2;
  level.difficultysettings["player_fireInvulSeconds"]["hardened"] = 1.75;
  level.difficultysettings["player_fireInvulSeconds"]["veteran"] = 1.5;
  level.difficultysettings["player_fireInvulSeconds"]["realism"] = 1.5;
  level.difficultysettings["player_health"]["supereasy"] = 400;
  level.difficultysettings["player_health"]["easy"] = 355;
  level.difficultysettings["player_health"]["normal"] = 180;
  level.difficultysettings["player_health"]["hardened"] = 120;
  level.difficultysettings["player_health"]["veteran"] = 60;
  level.difficultysettings["player_health"]["realism"] = 60;
  level.difficultysettings["player_flinch"]["supereasy"] = 0.3;
  level.difficultysettings["player_flinch"]["easy"] = 0.5;
  level.difficultysettings["player_flinch"]["normal"] = 1;
  level.difficultysettings["player_flinch"]["hardened"] = 1.1;
  level.difficultysettings["player_flinch"]["veteran"] = 1.7;
  level.difficultysettings["player_flinch"]["realism"] = 1.7;

  if(utility::playerarmorenabled()) {
    level.difficultysettings["player_armor"]["easy"] = 660;
    level.difficultysettings["player_armor"]["normal"] = 550;
    level.difficultysettings["player_armor"]["hardened"] = 410;
    level.difficultysettings["player_armor"]["veteran"] = 330;
    level.difficultysettings["player_armor"]["realism"] = 330;
    level.difficultysettings["player_armorRatioHealthRegenThreshold"]["easy"] = 1;
    level.difficultysettings["player_armorRatioHealthRegenThreshold"]["normal"] = 1;
    level.difficultysettings["player_armorRatioHealthRegenThreshold"]["hardened"] = 1;
    level.difficultysettings["player_armorRatioHealthRegenThreshold"]["veteran"] = 1;
    level.difficultysettings["player_armorRatioHealthRegenThreshold"]["realism"] = 1;
    level.difficultysettings["player_armorDamageToHealthRatioMin"]["easy"] = 0.4;
    level.difficultysettings["player_armorDamageToHealthRatioMin"]["normal"] = 0.4;
    level.difficultysettings["player_armorDamageToHealthRatioMin"]["hardened"] = 0.6;
    level.difficultysettings["player_armorDamageToHealthRatioMin"]["veteran"] = 0.8;
    level.difficultysettings["player_armorDamageToHealthRatioMin"]["realism"] = 0.8;
    level.difficultysettings["player_armorDamageToHealthRatioMax"]["easy"] = 0.4;
    level.difficultysettings["player_armorDamageToHealthRatioMax"]["normal"] = 0.4;
    level.difficultysettings["player_armorDamageToHealthRatioMax"]["hardened"] = 0.6;
    level.difficultysettings["player_armorDamageToHealthRatioMax"]["veteran"] = 0.8;
    level.difficultysettings["player_armorDamageToHealthRatioMax"]["realism"] = 0.8;
  }

  level.difficultysettings["explosiveDamageMultiplier"]["supereasy"] = 0.5;
  level.difficultysettings["explosiveDamageMultiplier"]["easy"] = 0.75;
  level.difficultysettings["explosiveDamageMultiplier"]["normal"] = 1;
  level.difficultysettings["explosiveDamageMultiplier"]["hardened"] = 1;
  level.difficultysettings["explosiveDamageMultiplier"]["veteran"] = 1;
  level.difficultysettings["explosiveDamageMultiplier"]["realism"] = 1;
  level.difficultysettings["player_meleeDamageMultiplier"]["easy"] = 0.15;
  level.difficultysettings["player_meleeDamageMultiplier"]["normal"] = 0.25;
  level.difficultysettings["player_meleeDamageMultiplier"]["hardened"] = 0.25;
  level.difficultysettings["player_meleeDamageMultiplier"]["veteran"] = 0.25;
  level.difficultysettings["player_meleeDamageMultiplier"]["realism"] = 0.25;
  level.difficultysettings["explosivePlantTime"]["easy"] = 10;
  level.difficultysettings["explosivePlantTime"]["normal"] = 10;
  level.difficultysettings["explosivePlantTime"]["hardened"] = 5;
  level.difficultysettings["explosivePlantTime"]["veteran"] = 5;
  level.difficultysettings["explosivePlantTime"]["realism"] = 5;
  level.difficultysettings["player_diedRecentlyCooldown"]["easy"] = 70;
  level.difficultysettings["player_diedRecentlyCooldown"]["normal"] = 30;
  level.difficultysettings["player_diedRecentlyCooldown"]["hardened"] = 0;
  level.difficultysettings["player_diedRecentlyCooldown"]["veteran"] = 0;
  level.difficultysettings["player_diedRecentlyCooldown"]["realism"] = 0;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["supereasy"] = -1;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["easy"] = -1;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["normal"] = -1;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["hardened"] = -1;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["veteran"] = -1;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["realism"] = -1;
  level.lastplayersighted = 0;
  updategameskill();
  updatealldifficulty();
}

function setdifficultysetting(var_9e60a636d252ed98, difficulty, value) {
  if(!isDefined(difficulty)) {
    foreach(difficulty in level.difficultytype) {
      level.difficultysettings[var_9e60a636d252ed98][difficulty] = value;
    }

    return;
  }

  level.difficultysettings[var_9e60a636d252ed98][difficulty] = value;
}

function updatealldifficulty() {
  setglobaldifficulty();

  foreach(player in level.players) {
    player setdifficulty();
  }
}

function setdifficulty() {
  assert(isPlayer(self));
  assert(isDefined(self.gameskill));
  auto_adjust_data_reset();
  set_difficulty_from_locked_settings();
}

function setglobaldifficulty() {
  anim.pain_test = get_difficultysetting_global("pain_test");
  level.explosiveplanttime = get_difficultysetting_global("explosivePlantTime");
  function_4afdefc72472a638(get_difficultysetting_global("min_sniper_burst_delay_time"));
  function_5eddc94e0785d7a2(get_difficultysetting_global("max_sniper_burst_delay_time"));
  setsaveddvar(@ "ai_accuracydistscale", get_difficultysetting_global("accuracyDistScale"));
  level.playermeleedamagemultiplier_dvar = get_difficultysetting_global("player_meleeDamageMultiplier");
  setsaveddvar(@ "player_meleeDamageMultiplier", level.playermeleedamagemultiplier_dvar);
  scripts\sp\mgturret::setdifficulty();

  if(in_realism_mode()) {
    setomnvar("ui_realism_hud", 1);
    setsaveddvar(@ "g_friendlynamedist", 0);
    setsaveddvar(@ "hash_8a0793d909d5cbd", 0);
    setsaveddvar(@ "hash_5792c3460a6734d4", 0);
    return;
  }

  setomnvar("ui_realism_hud", 0);
  setsaveddvar(@ "g_friendlynamedist", 15000);
  setsaveddvar(@ "hash_8a0793d909d5cbd", 1);
  setsaveddvar(@ "hash_5792c3460a6734d4", 1);
}

function updategameskill() {
  foreach(player in level.players) {
    player.gameskill = player get_player_gameskill();
  }

  level.gameskill = level.player.gameskill;

  if(isDefined(level.forcedgameskill)) {
    level.gameskill = level.forcedgameskill;
  }

  assert(level.gameskill >= 0 && level.gameskill <= 4);
  return level.gameskill;
}

function gameskill_change_monitor() {
  var_16e8d6cfc76e1f2a = level.gameskill;

  while(true) {
    if(!isDefined(var_16e8d6cfc76e1f2a)) {
      wait 1;
      var_16e8d6cfc76e1f2a = level.gameskill;
      continue;
    }

    if(!isDefined(level.lowestgameskill)) {
      level.lowestgameskill = level.gameskill;
    }

    if(var_16e8d6cfc76e1f2a != updategameskill()) {
      var_16e8d6cfc76e1f2a = level.gameskill;
      level.lowestgameskill = ter_op(var_16e8d6cfc76e1f2a < level.lowestgameskill, var_16e8d6cfc76e1f2a, level.lowestgameskill);
      level.player setplayerprogression("currentGameskill", var_16e8d6cfc76e1f2a + 1);
      updatealldifficulty();
    }

    wait 1;
  }
}

function function_1f031ab8afbe2335() {
  val = self getplayerprogression("currentGameskill");

  if(val == 0) {
    val = 2;
  }

  return val - 1;
}

function apply_difficulty_settings(current_frac) {
  assert(isPlayer(self));
  function_2a781949ace88ca4(get_difficultysetting_frac("player_diedRecentlyCooldown", current_frac));
  self.gs.maxflashbangtime = get_difficultysetting_frac("player_maxFlashBangTime", current_frac);
  self.gs.invultime_ondamage = get_difficultysetting_frac("invulTime_onDamage", current_frac);
  self.gs.invultime_deathshieldduration = get_difficultysetting_frac("invulTime_deathShieldDuration", current_frac);
  self.gs.deathsdoorduration = get_difficultysetting_frac("player_deathsDoorDuration", current_frac);
  self.gs.healthregendelay = get_difficultysetting_frac("player_healthRegenDelay", current_frac);
  self.gs.healthregenrate = get_difficultysetting_frac("player_healthRegenRate", current_frac);
  self.gs.healthfireinvulseconds = get_difficultysetting_frac("player_fireInvulSeconds", current_frac);
  self.gs.healthfireengulfrate = get_difficultysetting_frac("player_fireEngulfRate", current_frac);
  self.gs.swimbreathtime = get_difficultysetting_frac("player_swimBreathTime", current_frac);
  self.gs.swimbreathtimecrit = get_difficultysetting_frac("player_swimBreathTimeCrit", current_frac);
  self.gs.swimbreathtimecritsprint = get_difficultysetting_frac("player_swimBreathTimeCritSprint", current_frac);
  self.gs.swimsprintbreathtime = get_difficultysetting_frac("player_swimSprintBreathTime", current_frac);
  self.gs.swimbreathfilltime = get_difficultysetting_frac("player_swimBreathFillTime", current_frac);
  self.gs.player_attacker_accuracy = get_difficultysetting_frac("base_enemy_accuracy", current_frac);
  update_player_attacker_accuracy();
  self.gs.playergrenadebasetime = int(get_difficultysetting_frac("playerGrenadeBaseTime", current_frac));
  self.gs.playergrenaderangetime = int(get_difficultysetting_frac("playerGrenadeRangeTime", current_frac));
  self.gs.playerdoublegrenadetime = int(get_difficultysetting_frac("playerDoubleGrenadeTime", current_frac));
  function_113dc070d175daff(get_difficultysetting_frac("min_sniper_burst_delay_time", current_frac));
  function_87e4ff0e078152e9(get_difficultysetting_frac("max_sniper_burst_delay_time", current_frac));
  var_4cc77ae3c5e8921 = 1;

  if(level.gameskill == 0) {
    var_4cc77ae3c5e8921 = 2;
  }

  function_90faf3f11984372a(get_difficultysetting_frac("sniperAccuDiffScale", current_frac), var_4cc77ae3c5e8921, 1);
  self.gs.var_d92ad7538613e0c0 = get_difficultysetting_frac("player_flinch", current_frac);
  self.gs.damagemultiplierhealth = self.maxhealth / get_difficultysetting_frac("player_health", current_frac);
  self.gs.damagemultiplierexplosive = get_difficultysetting_frac("explosiveDamageMultiplier", current_frac);

  if(utility::playerarmorenabled()) {
    self.gs.armorratiohealthregenthreshold = get_difficultysetting_frac("player_armorRatioHealthRegenThreshold", current_frac);
    self.gs.armordamagetohealthratiomin = get_difficultysetting_frac("player_armorDamageToHealthRatioMin", current_frac);
    self.gs.armordamagetohealthratiomax = get_difficultysetting_frac("player_armorDamageToHealthRatioMax", current_frac);
    self.gs.damagemultiplierarmor = self.armor.maxamount / get_difficultysetting_frac("player_armor", current_frac);
  }

  self.threatbias = int(get_difficultysetting_frac("threatbias", current_frac));
  level.gameskillmisstimefrombehindoverride = get_difficultysetting("gameskillmisstimefrombehindoverride");
  enemy_ai = getaiarray("axis");
  post_load_precache(&function_e5c95805c0d22077);

  foreach(ai in enemy_ai) {
    ai function_416820d41ec6fff8();
  }

  function_a7f19b92c7f7a6a8();
}

function function_e5c95805c0d22077() {
  add_global_spawn_function("axis", &function_416820d41ec6fff8);
}

function function_416820d41ec6fff8() {
  if(isDefined(level.gameskillmisstimefrombehindoverride)) {
    self.gameskillmisstimefrombehindoverride = level.gameskillmisstimefrombehindoverride;
  }
}

function set_difficulty_from_locked_settings() {
  apply_difficulty_settings(1);
  apply_difficulty_settings_shared(1);
}

function resetskill() {
  waittillframeend();
  setskill(1);
}

function update_player_attacker_accuracy() {
  if(ent_flag("player_zero_attacker_accuracy")) {
    return;
  }

  if(!isDefined(self.scriptedignorerandombulletdamage)) {
    self.scriptedignorerandombulletdamage = 0;
  }

  if(!isDefined(self.scriptedattackeraccuracy)) {
    self.scriptedattackeraccuracy = 1;
  }

  self.ignorerandombulletdamage = self.scriptedignorerandombulletdamage;
  self.attackeraccuracy = self.gs.player_attacker_accuracy * self.scriptedattackeraccuracy;
}

function auto_adjust_init() {
  setdvarifuninitialized(@ "hash_ea3e0064074fd39b", 1);

  if(function_3cb5da19764baa3() == "T10") {
    setdvarifuninitialized(@ "hash_84003ec62f06a169", 0);
  } else {
    setdvarifuninitialized(@ "hash_84003ec62f06a169", 1);
  }

  level.auto_adjust = spawnStruct();
  level.auto_adjust.data = [];
  level.auto_adjust.playerdead = 0;

  if(!getdvarint(@ "hash_ea3e0064074fd39b")) {
    return;
  }

  level thread auto_adjust_thread();
}

function auto_adjust_data_reset() {
  level.auto_adjust.currenttier = 0;
  level.auto_adjust.currentfrac = 0;
  level.auto_adjust.nextsave_buffer = 60000;
  auto_adjust_data_set("lastdied_time", -1);
  auto_adjust_data_set("loadsave_count", 0);
  auto_adjust_data_set("playerdeath_count", 0);
  auto_adjust_data_set("nextsave_time", gettime() + level.auto_adjust.nextsave_buffer);
  auto_adjust_set_table();
}

function auto_adjust_set_table() {
  level.auto_adjust.table = [];

  if(level.gameskill == 2) {
    level.auto_adjust.table[0] = 0;
    level.auto_adjust.table[5] = 0.3;
    level.auto_adjust.table[7] = 0.5;
    level.auto_adjust.table[9] = 0.6;
    return;
  }

  level.auto_adjust.table[0] = 0;
  level.auto_adjust.table[3] = 0.3;
  level.auto_adjust.table[4] = 0.5;
  level.auto_adjust.table[5] = 0.7;
  level.auto_adjust.table[6] = 0.9;
}

function auto_adjust_thread() {
  waitframe();
  version = getbuildversion();

  while(true) {
    if(level.gameskill > 2) {
      if(version != "SHIP") {
        if(getdvarint(@ "hash_84003ec62f06a169") == 1) {
          auto_adjust_debuglite();
        } else if(getdvarint(@ "hash_84003ec62f06a169") > 1) {
          auto_adjust_debug();
        }
      }

      wait 1;
      continue;
    }

    if(!level.auto_adjust.playerdead) {
      deathcount = auto_adjust_data_get("playerdeath_count");
      tabledeathcount = deathcount;

      foreach(index, _ in level.auto_adjust.table) {
        if(deathcount >= index) {
          tabledeathcount = index;
        }
      }

      level.player auto_adjust_difficulty(tabledeathcount);
    }

    if(version != "SHIP") {
      if(getdvarint(@ "hash_84003ec62f06a169") == 1) {
        auto_adjust_debuglite();
      } else if(getdvarint(@ "hash_84003ec62f06a169") > 1) {
        auto_adjust_debug();
      }
    }

    waitframe();
  }
}

function can_auto_adjust(deathcount) {
  if(!isDefined(level.auto_adjust.table[deathcount])) {
    return false;
  }

  if(level.auto_adjust.table[deathcount] == level.auto_adjust.currentfrac) {
    return false;
  }

  return true;
}

function auto_adjust_difficulty(deathcount) {
  if(!can_auto_adjust(deathcount)) {
    return;
  }

  level.auto_adjust.currentfrac = level.auto_adjust.table[deathcount];
  self.gs.invultime_ondamage = auto_adjust_lerp_setting("invulTime_onDamage");
  self.gs.invultime_deathshieldduration = auto_adjust_lerp_setting("invulTime_deathShieldDuration");
  self.gs.deathsdoorduration = auto_adjust_lerp_setting("player_deathsDoorDuration");
  self.gs.healthregendelay = auto_adjust_lerp_setting("player_healthRegenDelay");
  self.gs.healthregenrate = auto_adjust_lerp_setting("player_healthRegenRate");
  self.gs.healthfireinvulseconds = auto_adjust_lerp_setting("player_fireInvulSeconds");
  self.gs.healthfireengulfrate = auto_adjust_lerp_setting("player_fireEngulfRate");
  self.gs.swimbreathtime = auto_adjust_lerp_setting("player_swimBreathTime");
  self.gs.swimbreathtimecrit = auto_adjust_lerp_setting("player_swimBreathTimeCrit");
  self.gs.swimbreathtimecritsprint = auto_adjust_lerp_setting("player_swimBreathTimeCritSprint");
  self.gs.swimsprintbreathtime = auto_adjust_lerp_setting("player_swimSprintBreathTime");
  self.gs.swimbreathfilltime = auto_adjust_lerp_setting("player_swimBreathFillTime");
  self.gs.var_d92ad7538613e0c0 = auto_adjust_lerp_setting("player_flinch");
  self.gs.damagemultiplierhealth = self.maxhealth / auto_adjust_lerp_setting("player_health");
  self.gs.damagemultiplierexplosive = auto_adjust_lerp_setting("explosiveDamageMultiplier");
  self.var_da4b6392c1bec6a1 = auto_adjust_lerp_setting("missTimeConstant");
  self.var_cef700ed012e8981 = auto_adjust_lerp_setting("missTimeDistanceFactor");
  function_a7f19b92c7f7a6a8();
}

function function_a7f19b92c7f7a6a8() {
  scripts\sp\player::updateviewkickscale();
  scripts\sp\player::updatedamagemultiplier();
  scripts\common\swim_common::function_aa183ca1083d279();
}

function auto_adjust_lerp_setting(setting) {
  var_b0e75118d3c9dde8 = self.gameskill - 1;
  var_be6da4f53631a129 = get_difficultysetting(setting, var_b0e75118d3c9dde8);
  var_d58d8bffb394c16b = get_difficultysetting(setting);
  return math::lerp(var_d58d8bffb394c16b, var_be6da4f53631a129, level.auto_adjust.currentfrac);
}

function auto_adjust_data_add(name, add) {
  val = getdvarint(hashcat(@ "hash_82f854ba4d98181e", name)) + add;
  auto_adjust_data_set(name, val);
}

function auto_adjust_data_set(name, val) {
  setDvar(hashcat(@ "hash_82f854ba4d98181e", name), val);
}

function auto_adjust_data_get(name) {
  return getdvarint(hashcat(@ "hash_82f854ba4d98181e", name));
}

function auto_adjust_playerdied() {
  if(!isDefined(level.auto_adjust)) {
    return;
  }

  level.auto_adjust.playerdead = 1;
  count = auto_adjust_data_get("playerdeath_count");

  if(count == 7) {
    return;
  }

  auto_adjust_data_add("playerdeath_count", 1);
}

function auto_adjust_save_committed() {
  if(!isDefined(level.auto_adjust)) {
    return;
  }

  count = auto_adjust_data_get("playerdeath_count");

  if(count == 0) {
    return;
  }

  nextsave_time = auto_adjust_data_get("nextsave_time");

  if(gettime() > nextsave_time) {
    auto_adjust_data_set("nextsave_time", gettime() + level.auto_adjust.nextsave_buffer);
  } else {
    return;
  }

  auto_adjust_data_add("playerdeath_count", -1);
}

function auto_adjust_difficult_get() {
  return level.gameskill - level.auto_adjust.currentfrac;
}

function auto_adjust_debug() {
  if(isDefined(level.auto_adjust.debuglitehud)) {
    level.auto_adjust.debuglitehud destroy();
  }

  level.auto_adjust.debugprintline = 0;

  if(level.gameskill == 3) {
    auto_adjust_debug_update("<dev string:x1c>", -1);
  } else {
    auto_adjust_debug_update("<dev string:x1c>", auto_adjust_data_get("<dev string:x34>"));
  }

  auto_adjust_debug_update("<dev string:x46>", level.gameskill);
  auto_adjust_debug_update("<dev string:x5e>", auto_adjust_difficult_get());
  level.auto_adjust.debugprintline++;
  auto_adjust_debug_update("<dev string:x76>", level.player.gs.healthregendelay, level.player get_difficultysetting("<dev string:x8e>"));
  auto_adjust_debug_update("<dev string:xa6>", level.player.gs.healthregenrate, level.player get_difficultysetting("<dev string:xbe>"));
  auto_adjust_debug_update("<dev string:xd5>", level.player.gs.healthfireinvulseconds, level.player get_difficultysetting("<dev string:xed>"));
  auto_adjust_debug_update("<dev string:x105>", level.player.gs.healthfireengulfrate, level.player get_difficultysetting("<dev string:x11d>"));
  auto_adjust_debug_update("<dev string:x133>", level.player.gs.swimbreathtime, level.player get_difficultysetting("<dev string:x14d>"));
  auto_adjust_debug_update("<dev string:x163>", level.player.gs.swimbreathtimecrit, level.player get_difficultysetting("<dev string:x17f>"));
  auto_adjust_debug_update("<dev string:x199>", level.player.gs.swimbreathfilltime, level.player get_difficultysetting("<dev string:x1b4>"));
  auto_adjust_debug_update("<dev string:x1ce>", level.player.gs.invultime_ondamage, level.player get_difficultysetting("<dev string:x1e6>"));
  auto_adjust_debug_update("<dev string:x1f9>", level.player.gs.invultime_deathshieldduration, level.player get_difficultysetting("<dev string:x211>"));
  auto_adjust_debug_update("<dev string:x22f>", level.player.gs.deathsdoorduration, level.player get_difficultysetting("<dev string:x247>"));
  auto_adjust_debug_update("<dev string:x261>", level.player.gs.damagemultiplierhealth, level.player.maxhealth / level.player get_difficultysetting("<dev string:x279>"));
  auto_adjust_debug_update("<dev string:x287>", level.player.gs.damagemultiplierexplosive, level.player get_difficultysetting("<dev string:x29f>"));
  auto_adjust_debug_update("<dev string:x2b9>", level.player.var_da4b6392c1bec6a1, level.player get_difficultysetting("<dev string:x2d1>"));
  auto_adjust_debug_update("<dev string:x2e2>", level.player.var_cef700ed012e8981, level.player get_difficultysetting("<dev string:x2fa>"));
}

function auto_adjust_debug_update(msg, val, val2) {
  if(!isDefined(level.auto_adjust.debughud)) {
    level.auto_adjust.debughud = [];
  }

  if(!isDefined(level.auto_adjust.debughud[msg])) {
    hud = newhudelem();
    hud.x = 10;
    hud.y = 50 + 10 * level.auto_adjust.debugprintline;
    hud.fontscale = 0.6;
    hud.label = msg;
    hud.font = "smallfixed";
    hud.horzalign = "fullscreen";
    hud.vertalign = "fullscreen";
    hud.value = -999;
    hud.sort = 20;

    if(isDefined(val2)) {
      hud.val2 = newhudelem();
      hud.val2.x = hud.x + 120;
      hud.val2.y = hud.y;
      hud.val2.fontscale = 0.6;
      hud.val2.font = "smallfixed";
      hud.val2.label = "|";
      hud.val2.horzalign = "fullscreen";
      hud.val2.vertalign = "fullscreen";
      hud.val2.value = -999;
      hud.val2.sort = 20;
    }

    level.auto_adjust.debughud[msg] = hud;
  } else {
    hud = level.auto_adjust.debughud[msg];
  }

  if(hud.value != val) {
    hud setvalue(val);
    hud.value = val;
  }

  if(isDefined(val2)) {
    if(hud.val2.value != val2) {
      hud.val2 setvalue(val2);
      hud.val2.value = val2;
    }
  }

  level.auto_adjust.debugprintline++;
}

function auto_adjust_debuglite() {
  if(isDefined(level.auto_adjust.debughud)) {
    foreach(hud in level.auto_adjust.debughud) {
      if(isDefined(hud.val2)) {
        hud.val2 destroy();
      }

      hud destroy();
    }

    level.auto_adjust.debughud = undefined;
  }

  if(!isDefined(level.auto_adjust.debuglitehud)) {
    hud = newhudelem();
    hud.alignx = "right";
    hud.x = 128;
    hud.y = 5;
    hud.fontscale = 0.7;
    hud.font = "default";
    hud.horzalign = "fullscreen";
    hud.vertalign = "fullscreen";
    hud.sort = 20;
    level.auto_adjust.debuglitehud = hud;
  }

  if(isDefined(level.gameskill) && isDefined(level.auto_adjust.currentfrac)) {
    str = "^5" + auto_adjust_data_get("playerdeath_count") + "/" + level.gameskill - level.auto_adjust.currentfrac;
  }

  if(isDefined(str)) {
    level.auto_adjust.debuglitehud settext(str);
  }
}