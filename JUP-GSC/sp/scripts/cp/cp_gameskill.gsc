/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_gameskill.gsc
***********************************************/

#using scripts\common\gameskill;
#using scripts\common\utility;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_hud_message;
#using scripts\cp\laststand;
#using scripts\cp\spawning;
#using scripts\cp\starts;
#using scripts\cp\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\spawn_event_aggregator;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace cp_gameskill;

function init_gameskill() {
  if(flag("gameskill_initialized")) {
    return;
  }

  if(level.gametype != "cp_survival") {
    auto_adjust_init();
    setskill();
    level.gameskill = getdvarint(@ "g_gameskill", 1);

    if(level.gametype == "dungeons") {
      scripts\cp_mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_16b70bbe9a38c939);
    } else {
      scripts\cp_mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_80828faad46102e9);
    }

    if(flag_exist("gameskill_initialized")) {
      flag_set("gameskill_initialized");
    }
  }
}

function function_ffef4cfd9fec2e5b() {
  auto_adjust_init();
  setskill();
  updategameskill();
}

function function_1fc33d9e5389101f() {
  level.var_54d92ec32dc4c49a = 1;
}

function function_3110ad42148690f0() {
  level.var_54d92ec32dc4c49a = undefined;
}

function function_2b72a5cf9e5597f9(value) {
  if(istrue(level.var_54d92ec32dc4c49a)) {
    return;
  }

  level.forcedgameskill = value;
}

function function_80828faad46102e9() {
  self.gameskill = 2;
  set_difficulty_from_locked_settings();
  function_fd716ba463a7acc0();
}

function function_16b70bbe9a38c939() {
  self.gameskill = get_player_gameskill();
  level.gameskill = self.gameskill;
  setDvar(@ "g_gameskill", self.gameskill);

  if(isDefined(level.start_point) && scripts\cp\starts::is_first_start()) {
    level.lowestgameskill = self.gameskill;
  }

  set_difficulty_from_locked_settings();
  function_fd716ba463a7acc0();
  level thread auto_adjust_thread();
}

function set_gameskill() {
  if(!isDefined(level.gameskill)) {
    level.gameskill = getdvarint(@ "g_gameskill", 1);
  }

  setomnvar("cp_difficulty_level", level.gameskill);
}

function get_gameskill() {
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

    if(var_16e8d6cfc76e1f2a != getdvarint(@ "g_gameskill", 1)) {
      level.player.gameskill = getdvarint(@ "g_gameskill", 1);
      level.gameskill = level.player.gameskill;
      var_16e8d6cfc76e1f2a = level.gameskill;
      level.lowestgameskill = ter_op(var_16e8d6cfc76e1f2a < level.lowestgameskill, var_16e8d6cfc76e1f2a, level.lowestgameskill);
      level.player setprogressiondata("spData", "currentGameskill", var_16e8d6cfc76e1f2a + 1);
      level.player function_fd716ba463a7acc0();
      setglobaldifficulty();
      level.player set_difficulty_from_locked_settings();
    }

    wait 1;
  }
}

function setskill(should_reset) {
  if(!istrue(should_reset)) {
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
  level.difficultysettings["playerDoubleGrenadeTime"]["veteran"] = 45000;
  level.difficultysettings["playerDoubleGrenadeTime"]["realism"] = 45000;
  level.difficultysettings["double_grenades_allowed"]["easy"] = 0;
  level.difficultysettings["double_grenades_allowed"]["normal"] = 1;
  level.difficultysettings["double_grenades_allowed"]["hardened"] = 1;
  level.difficultysettings["double_grenades_allowed"]["veteran"] = 1;
  level.difficultysettings["double_grenades_allowed"]["realism"] = 1;
  level.difficultysettings["threatbias"]["easy"] = 100;
  level.difficultysettings["threatbias"]["normal"] = 150;
  level.difficultysettings["threatbias"]["hardened"] = 200;
  level.difficultysettings["threatbias"]["veteran"] = 400;
  level.difficultysettings["threatbias"]["realism"] = 400;
  level.difficultysettings["base_enemy_accuracy"]["easy"] = 0.9;
  level.difficultysettings["base_enemy_accuracy"]["normal"] = 1;
  level.difficultysettings["base_enemy_accuracy"]["hardened"] = 1.15;
  level.difficultysettings["base_enemy_accuracy"]["veteran"] = 1.5;
  level.difficultysettings["base_enemy_accuracy"]["realism"] = 1.5;
  level.difficultysettings["accuracyDistScale"]["easy"] = 1;
  level.difficultysettings["accuracyDistScale"]["normal"] = 1;
  level.difficultysettings["accuracyDistScale"]["hardened"] = 0.1;
  level.difficultysettings["accuracyDistScale"]["veteran"] = 0.1;
  level.difficultysettings["accuracyDistScale"]["realism"] = 0.1;
  level.difficultysettings["min_sniper_burst_delay_time"]["easy"] = 3;
  level.difficultysettings["min_sniper_burst_delay_time"]["normal"] = 2;
  level.difficultysettings["min_sniper_burst_delay_time"]["hardened"] = 1.5;
  level.difficultysettings["min_sniper_burst_delay_time"]["veteran"] = 0.75;
  level.difficultysettings["min_sniper_burst_delay_time"]["realism"] = 0.75;
  level.difficultysettings["forced_sniper_misses"]["supereasy"] = 2;
  level.difficultysettings["forced_sniper_misses"]["easy"] = 2;
  level.difficultysettings["forced_sniper_misses"]["normal"] = 1;
  level.difficultysettings["forced_sniper_misses"]["hardened"] = 1;
  level.difficultysettings["forced_sniper_misses"]["veteran"] = 1;
  level.difficultysettings["forced_sniper_misses"]["realism"] = 1;
  level.difficultysettings["sniper_converge_scale"]["easy"] = 1.3;
  level.difficultysettings["sniper_converge_scale"]["normal"] = 1.1;
  level.difficultysettings["sniper_converge_scale"]["hardened"] = 0.9;
  level.difficultysettings["sniper_converge_scale"]["veteran"] = 0.45;
  level.difficultysettings["sniper_converge_scale"]["realism"] = 0.45;
  level.difficultysettings["sniperAccuDiffScale"]["supereasy"] = 0.8;
  level.difficultysettings["sniperAccuDiffScale"]["easy"] = 1;
  level.difficultysettings["sniperAccuDiffScale"]["normal"] = 1.6;
  level.difficultysettings["sniperAccuDiffScale"]["hardened"] = 1.6;
  level.difficultysettings["sniperAccuDiffScale"]["veteran"] = 2.5;
  level.difficultysettings["sniperAccuDiffScale"]["realism"] = 2.5;
  level.difficultysettings["max_sniper_burst_delay_time"]["easy"] = 4;
  level.difficultysettings["max_sniper_burst_delay_time"]["normal"] = 3;
  level.difficultysettings["max_sniper_burst_delay_time"]["hardened"] = 2;
  level.difficultysettings["max_sniper_burst_delay_time"]["veteran"] = 1.1;
  level.difficultysettings["max_sniper_burst_delay_time"]["realism"] = 1.1;
  level.difficultysettings["pain_test"]["easy"] = &always_pain;
  level.difficultysettings["pain_test"]["normal"] = &always_pain;
  level.difficultysettings["pain_test"]["hardened"] = &scripts\common\gameskill::pain_protection;
  level.difficultysettings["pain_test"]["veteran"] = &scripts\common\gameskill::pain_protection;
  level.difficultysettings["pain_test"]["realism"] = &scripts\common\gameskill::pain_protection;
  level.difficultysettings["missTimeConstant"]["supereasy"] = 1.2;
  level.difficultysettings["missTimeConstant"]["easy"] = 1;
  level.difficultysettings["missTimeConstant"]["normal"] = 0.05;
  level.difficultysettings["missTimeConstant"]["hardened"] = 0.03;
  level.difficultysettings["missTimeConstant"]["veteran"] = 0.02;
  level.difficultysettings["missTimeConstant"]["realism"] = 0.02;
  level.difficultysettings["missTimeDistanceFactor"]["supereasy"] = 0.0009;
  level.difficultysettings["missTimeDistanceFactor"]["easy"] = 0.0008;
  level.difficultysettings["missTimeDistanceFactor"]["normal"] = 0.0001;
  level.difficultysettings["missTimeDistanceFactor"]["hardened"] = 5e-05;
  level.difficultysettings["missTimeDistanceFactor"]["veteran"] = 3e-05;
  level.difficultysettings["missTimeDistanceFactor"]["realism"] = 3e-05;
  level.difficultysettings["player_maxFlashBangTime"]["easy"] = 6;
  level.difficultysettings["player_maxFlashBangTime"]["normal"] = 8;
  level.difficultysettings["player_maxFlashBangTime"]["hardened"] = 9;
  level.difficultysettings["player_maxFlashBangTime"]["veteran"] = 10;
  level.difficultysettings["player_maxFlashBangTime"]["realism"] = 10;
  level.difficultysettings["invulTime_onDamageMin"]["supereasy"] = 0.4;
  level.difficultysettings["invulTime_onDamageMin"]["easy"] = 0.35;
  level.difficultysettings["invulTime_onDamageMin"]["normal"] = 0.3;
  level.difficultysettings["invulTime_onDamageMin"]["hardened"] = 0.2;
  level.difficultysettings["invulTime_onDamageMin"]["veteran"] = 0.2;
  level.difficultysettings["invulTime_onDamageMin"]["realism"] = 0.2;
  level.difficultysettings["invulTime_onDamageMax"]["supereasy"] = 0.4;
  level.difficultysettings["invulTime_onDamageMax"]["easy"] = 0.35;
  level.difficultysettings["invulTime_onDamageMax"]["normal"] = 0.3;
  level.difficultysettings["invulTime_onDamageMax"]["hardened"] = 0.2;
  level.difficultysettings["invulTime_onDamageMax"]["veteran"] = 0.2;
  level.difficultysettings["invulTime_onDamageMax"]["realism"] = 0.2;
  level.difficultysettings["invulTime_onDamage"]["supereasy"] = 0.5;
  level.difficultysettings["invulTime_onDamage"]["easy"] = 0.35;
  level.difficultysettings["invulTime_onDamage"]["normal"] = 0.3;
  level.difficultysettings["invulTime_onDamage"]["hardened"] = 0.2;
  level.difficultysettings["invulTime_onDamage"]["veteran"] = 0.2;
  level.difficultysettings["invulTime_onDamage"]["realism"] = 0.2;
  level.difficultysettings["invulTime_deathShieldDuration"]["supereasy"] = 2;
  level.difficultysettings["invulTime_deathShieldDuration"]["easy"] = 2;
  level.difficultysettings["invulTime_deathShieldDuration"]["normal"] = 1;
  level.difficultysettings["invulTime_deathShieldDuration"]["hardened"] = 0.5;
  level.difficultysettings["invulTime_deathShieldDuration"]["veteran"] = 0.25;
  level.difficultysettings["invulTime_deathShieldDuration"]["realism"] = 0.25;
  level.difficultysettings["player_deathsDoorDuration"]["supereasy"] = 4;
  level.difficultysettings["player_deathsDoorDuration"]["easy"] = 4;
  level.difficultysettings["player_deathsDoorDuration"]["normal"] = 4;
  level.difficultysettings["player_deathsDoorDuration"]["hardened"] = 4;
  level.difficultysettings["player_deathsDoorDuration"]["veteran"] = 4;
  level.difficultysettings["player_deathsDoorDuration"]["realism"] = 4;
  level.difficultysettings["player_healthRegenDelay"]["supereasy"] = 3;
  level.difficultysettings["player_healthRegenDelay"]["easy"] = 4;
  level.difficultysettings["player_healthRegenDelay"]["normal"] = 6;
  level.difficultysettings["player_healthRegenDelay"]["hardened"] = 6;
  level.difficultysettings["player_healthRegenDelay"]["veteran"] = 6;
  level.difficultysettings["player_healthRegenDelay"]["realism"] = 6;
  level.difficultysettings["player_healthRegenRate"]["supereasy"] = 40;
  level.difficultysettings["player_healthRegenRate"]["easy"] = 40;
  level.difficultysettings["player_healthRegenRate"]["normal"] = 40;
  level.difficultysettings["player_healthRegenRate"]["hardened"] = 40;
  level.difficultysettings["player_healthRegenRate"]["veteran"] = 40;
  level.difficultysettings["player_healthRegenRate"]["realism"] = 40;
  level.difficultysettings["player_health"]["supereasy"] = 425;
  level.difficultysettings["player_health"]["easy"] = 355;
  level.difficultysettings["player_health"]["normal"] = 180;
  level.difficultysettings["player_health"]["hardened"] = 140;
  level.difficultysettings["player_health"]["veteran"] = 80;
  level.difficultysettings["player_health"]["realism"] = 80;
  level.difficultysettings["player_diedRecentlyCooldown"]["easy"] = 70;
  level.difficultysettings["player_diedRecentlyCooldown"]["normal"] = 30;
  level.difficultysettings["player_diedRecentlyCooldown"]["hardened"] = 0;
  level.difficultysettings["player_diedRecentlyCooldown"]["veteran"] = 0;
  level.difficultysettings["player_diedRecentlyCooldown"]["realism"] = 0;
  level.difficultysettings["armor_damageScale"]["supereasy"] = 0.8;
  level.difficultysettings["armor_damageScale"]["easy"] = 1;
  level.difficultysettings["armor_damageScale"]["normal"] = 1;
  level.difficultysettings["armor_damageScale"]["hardened"] = 1;
  level.difficultysettings["armor_damageScale"]["veteran"] = 1.3;
  level.difficultysettings["armor_damageScale"]["realism"] = 1.3;
  level.difficultysettings["explosiveDamageMultiplier"]["supereasy"] = 0.5;
  level.difficultysettings["explosiveDamageMultiplier"]["easy"] = 0.75;
  level.difficultysettings["explosiveDamageMultiplier"]["normal"] = 1;
  level.difficultysettings["explosiveDamageMultiplier"]["hardened"] = 2;
  level.difficultysettings["explosiveDamageMultiplier"]["veteran"] = 2;
  level.difficultysettings["explosiveDamageMultiplier"]["realism"] = 2;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["supereasy"] = 2;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["easy"] = 1.5;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["normal"] = 1;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["hardened"] = -1;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["veteran"] = -1;
  level.difficultysettings["gameskillmisstimefrombehindoverride"]["realism"] = -1;
  level.lastplayersighted = 0;
  level.playermeleedamagemultiplier_dvar = 0.8;
  init_mgturretsettings();
  updategameskill();
  function_ef95bb7d1c3bdafa();
}

function init_mgturretsettings() {
  level.mgturretsettings["easy"]["convergenceTime"] = 2.5;
  level.mgturretsettings["easy"]["suppressionTime"] = 3;
  level.mgturretsettings["easy"]["accuracy"] = 0.38;
  level.mgturretsettings["easy"]["aiSpread"] = 2;
  level.mgturretsettings["easy"]["playerSpread"] = 0.5;
  level.mgturretsettings["medium"]["convergenceTime"] = 1.5;
  level.mgturretsettings["medium"]["suppressionTime"] = 3;
  level.mgturretsettings["medium"]["accuracy"] = 0.38;
  level.mgturretsettings["medium"]["aiSpread"] = 2;
  level.mgturretsettings["medium"]["playerSpread"] = 0.5;
  level.mgturretsettings["hard"]["convergenceTime"] = 0.8;
  level.mgturretsettings["hard"]["suppressionTime"] = 3;
  level.mgturretsettings["hard"]["accuracy"] = 0.38;
  level.mgturretsettings["hard"]["aiSpread"] = 2;
  level.mgturretsettings["hard"]["playerSpread"] = 0.5;
  level.mgturretsettings["veteran"]["convergenceTime"] = 0.8;
  level.mgturretsettings["veteran"]["suppressionTime"] = 3;
  level.mgturretsettings["veteran"]["accuracy"] = 0.38;
  level.mgturretsettings["veteran"]["aiSpread"] = 2;
  level.mgturretsettings["veteran"]["playerSpread"] = 0.5;
  level.mgturretsettings["fu"]["convergenceTime"] = 0.4;
  level.mgturretsettings["fu"]["suppressionTime"] = 3;
  level.mgturretsettings["fu"]["accuracy"] = 0.38;
  level.mgturretsettings["fu"]["aiSpread"] = 2;
  level.mgturretsettings["fu"]["playerSpread"] = 0.5;
}

function setdifficulty() {
  assert(isPlayer(self));
  assert(isDefined(self.gameskill));
  function_fd716ba463a7acc0();
  set_difficulty_from_locked_settings();
}

function setglobaldifficulty() {
  current_skill = get_skill_from_index(level.gameskill);
  anim.pain_test = get_difficultysetting_global("pain_test");
  function_4afdefc72472a638(get_difficultysetting_global("min_sniper_burst_delay_time"));
  function_5eddc94e0785d7a2(get_difficultysetting_global("max_sniper_burst_delay_time"));
  var_752e478148412f4a = get_difficultysetting_global("accuracyDistScale");

  if(isdedicatedserver()) {
    setsaveddvar(@ "ai_accuracydistscale", var_752e478148412f4a);
    return;
  }

  setDvar(@ "ai_accuracydistscale", var_752e478148412f4a);
}

function updategameskill() {
  if(isDefined(level.forcedgameskill)) {
    level.gameskill = level.forcedgameskill;
  } else {
    set_gameskill();
  }

  setglobaldifficulty();
  return level.gameskill;
}

function apply_difficulty_settings(current_frac) {
  assert(isPlayer(self));

  if(!isDefined(self.gs)) {
    self.gs = spawnStruct();
  }

  function_2a781949ace88ca4(get_difficultysetting_frac("player_diedRecentlyCooldown", current_frac));
  self.gs.maxflashbangtime = get_difficultysetting_frac("player_maxFlashBangTime", current_frac);
  self.gs.invultime_ondamagemin = get_difficultysetting_frac("invulTime_onDamageMin", current_frac);
  self.gs.invultime_ondamagemax = get_difficultysetting_frac("invulTime_onDamageMax", current_frac);
  self.gs.invultime_deathshieldduration = get_difficultysetting_frac("invulTime_deathShieldDuration", current_frac);
  self.gs.invultime_ondamage = get_difficultysetting_frac("invulTime_onDamage", current_frac);
  self.gs.deathsdoorduration = get_difficultysetting_frac("player_deathsDoorDuration", current_frac);
  self.gs.scripteddamagemultiplier = 1;
  self.gs.scripteddeathshielddurationscale = 1;
  self.gs.healthregendelay = get_difficultysetting_frac("player_healthRegenDelay", current_frac);
  self.gs.healthregenrate = get_difficultysetting_frac("player_healthRegenRate", current_frac);
  self.gs.player_attacker_accuracy = get_difficultysetting_frac("base_enemy_accuracy", current_frac);
  update_player_attacker_accuracy();
  self.gs.playergrenadebasetime = int(get_difficultysetting_frac("playerGrenadeBaseTime", current_frac));
  self.gs.playergrenaderangetime = int(get_difficultysetting_frac("playerGrenadeRangeTime", current_frac));
  self.gs.playerdoublegrenadetime = int(get_difficultysetting_frac("playerDoubleGrenadeTime", current_frac));
  function_113dc070d175daff(get_difficultysetting_frac("min_sniper_burst_delay_time", current_frac));
  function_87e4ff0e078152e9(get_difficultysetting_frac("max_sniper_burst_delay_time", current_frac));
  forced_sniper_misses = int(get_difficultysetting_frac("forced_sniper_misses", current_frac));
  function_90faf3f11984372a(get_difficultysetting_frac("sniperAccuDiffScale", current_frac), forced_sniper_misses, 1);
  self.gs.damagemultiplierhealth = self.maxhealth / get_difficultysetting_frac("player_health", current_frac);
  self.gs.damagemultiplierexplosive = get_difficultysetting_frac("explosiveDamageMultiplier", current_frac);
  self.damagemultiplier = self.gs.damagemultiplierhealth;
  self.threatbias = int(get_difficultysetting_frac("threatbias", current_frac));
  level.gameskillmisstimefrombehindoverride = get_difficultysetting("gameskillmisstimefrombehindoverride");
  enemy_ai = getaiarray("axis");

  foreach(ai in enemy_ai) {
    ai.gameskillmisstimefrombehindoverride = level.gameskillmisstimefrombehindoverride;
  }
}

function set_difficulty_from_locked_settings(override) {
  if(isDefined(override)) {
    apply_difficulty_settings(override);
    apply_difficulty_settings_shared(override);
    return;
  }

  apply_difficulty_settings(1);
  apply_difficulty_settings_shared(1);
}

function resetskill() {
  waittillframeend();
  setskill(1);
}

function wave_difficulty_update(difficulty) {
  if(getdvarint(@ "hash_94ebdb2e64164d03", -1) != -1) {
    difficulty = getdvarint(@ "hash_94ebdb2e64164d03", -1);
  }

  setting = level.difficultytype[difficulty];

  foreach(player in level.players) {
    player.gs.player_attacker_accuracy = level.difficultysettings["base_enemy_accuracy"][setting];
    player.attackeraccuracy = player.gs.player_attacker_accuracy;
    player.gs.playergrenadebasetime = int(level.difficultysettings["playerGrenadeBaseTime"][setting]);
    player.gs.playergrenaderangetime = int(level.difficultysettings["playerGrenadeRangeTime"][setting]);
    player.gs.playerdoublegrenadetime = int(level.difficultysettings["playerDoubleGrenadeTime"][setting]);
    player.var_da4b6392c1bec6a1 = level.difficultysettings["missTimeConstant"][setting];
    player.var_cef700ed012e8981 = level.difficultysettings["missTimeDistanceFactor"][setting];
  }

  function_38ae83992c7eb8a5(level.difficultysettings["double_grenades_allowed"][setting]);
  anim.pain_test = level.difficultysettings["pain_test"][setting];
  function_4afdefc72472a638(level.difficultysettings["min_sniper_burst_delay_time"][setting]);
  function_5eddc94e0785d7a2(level.difficultysettings["max_sniper_burst_delay_time"][setting]);
  function_113dc070d175daff(level.difficultysettings["min_sniper_burst_delay_time"][setting]);
  function_87e4ff0e078152e9(level.difficultysettings["max_sniper_burst_delay_time"][setting]);

  if(isdedicatedserver()) {
    setsaveddvar(@ "ai_accuracydistscale", level.difficultysettings["accuracyDistScale"][setting]);
    return;
  }

  setDvar(@ "ai_accuracydistscale", level.difficultysettings["accuracyDistScale"][setting]);
}

function update_player_attacker_accuracy() {
  if(!isDefined(self.baseignorerandombulletdamage)) {
    self.baseignorerandombulletdamage = 0;
  }

  if(!isDefined(self.scriptedattackeraccuracy)) {
    self.scriptedattackeraccuracy = 1;
  }

  self.ignorerandombulletdamage = self.baseignorerandombulletdamage;
  self.attackeraccuracy = self.gs.player_attacker_accuracy * self.scriptedattackeraccuracy;
}

function get_player_gameskill() {
  val = self getprogressiondata("spData", "currentGameskill");

  if(val == 0) {
    val = 2;
  }

  return val - 1;
}

function function_c3cbec9961784870(damage) {
  scalar = level.difficultysettings["armor_damageScale"][scripts\common\gameskill::get_skill_from_index(level.gameskill)];
  damage *= scalar;
  damageabsorbed = int(min(self.armorhealth, damage));
  return damageabsorbed;
}

function function_e22f3955ab0d2e8d() {
  return function_f8448fd91abb54c8() && istrue(level.var_3a0f2224b2310445);
}

function function_f8448fd91abb54c8() {
  if(!scripts\cp\utility::function_138028ca2b958511()) {
    return 0;
  }

  if(!isDefined(level.var_df73b19d71e8bc58)) {
    level.var_df73b19d71e8bc58 = getdvarint(@ "hash_4adaf899568a9e92", 0);
  }

  return level.var_df73b19d71e8bc58;
}

function function_31b2bf3fe796b1b2() {
  if(!function_f8448fd91abb54c8() || !scripts\cp\utility::function_138028ca2b958511()) {
    return;
  }

  level.var_e8f60267621fda8d = &function_c3cbec9961784870;
  function_d160a5b092271ada();
  level thread function_cbd65fa4a48cc872();
  level thread scripts\cp\laststand::function_2767aaacd3dfc97a();
}

function function_d160a5b092271ada() {
  level.forced_aitype_armored = 1;
  scripts\cp\spawning::add_global_spawn_function("axis", &function_cfc318cbb1f61af1);
}

function function_aaabb684e4369086() {
  level.forced_aitype_armored = undefined;
  scripts\cp\spawning::remove_global_spawn_function("axis", &function_cfc318cbb1f61af1);
}

function function_cfc318cbb1f61af1() {
  if(scripts\cp\spawning::is_juggernaut_aitype()) {
    return;
  }

  tier = "tier1";
  aitype = self.aitype;

  if(issubstr(aitype, "_t1_")) {
    tier = "tier2";

    if(isDefined(self.headmodel)) {
      self detach(self.headmodel);
    }

    self attach("head_sp_opforce_al_qatala_tier_2_1_1", "", 1);
    self.headmodel = "head_sp_opforce_al_qatala_tier_2_1_1";
    scripts\cp_mp\agents\agent_utils::overridetier2(self);
    return;
  }

  if(issubstr(aitype, "_t2_")) {
    tier = "tier3";

    if(isDefined(self.headmodel)) {
      self detach(self.headmodel);
    }

    self attach("head_sp_opforce_al_qatala_tier_3_1", "", 1);
    self.headmodel = "head_sp_opforce_al_qatala_tier_3_1";
    scripts\cp_mp\agents\agent_utils::overridetier3(self);
    return;
  }

  if(issubstr(aitype, "_t3_")) {
    tier = "tier3";

    if(isDefined(self.headmodel)) {
      self detach(self.headmodel);
    }

    self attach("head_sp_opforce_al_qatala_tier_3_1", "", 1);
    self.headmodel = "head_sp_opforce_al_qatala_tier_3_1";
    scripts\cp_mp\agents\agent_utils::overridetier3(self);
  }
}

function function_3898e5f82c5c37df(var_5220029d5e272dc8, var_32a62a6c0b501cbe) {
  if(istrue(var_5220029d5e272dc8)) {
    var_1f2a9dd7318bb8f9 = 98;
    level.var_cba4f601411edef5 = 1;

    if(!isDefined(level.var_c53b399b59b83a64)) {
      level.var_c53b399b59b83a64 = getdvarint(@ "hash_ba489eed001f6cad", 540);
    }

    var_d32605eb65369628 = level.var_c53b399b59b83a64;

    if(!istrue(level.var_77f52e0ccb8547eb)) {
      setomnvar("cp_objective_sub_4_index", var_1f2a9dd7318bb8f9);
      setomnvar("cp_countdown_timer_alpha", 4);
      setomnvar("cp_countdown_timer", level.var_c53b399b59b83a64 * 1000);
    }

    return;
  }

  var_1f2a9dd7318bb8f9 = ter_op(isDefined(var_32a62a6c0b501cbe), var_32a62a6c0b501cbe, 99);
  level.var_cba4f601411edef5 = 0;

  if(!isDefined(level.var_f63478bca59e2670)) {
    level.var_f63478bca59e2670 = getdvarint(@ "hash_aae8e9a472853241", 3);
  }

  if(!isDefined(level.var_a80e6d45222f9a47)) {
    level.var_a80e6d45222f9a47 = level.var_f63478bca59e2670;
  }

  var_d32605eb65369628 = level.var_a80e6d45222f9a47;

  if(!istrue(level.var_77f52e0ccb8547eb)) {
    setomnvar("cp_objective_sub_4_index", var_1f2a9dd7318bb8f9);
    setomnvar("cp_objective_sub_count_4", int(var_d32605eb65369628));
  }
}

function function_e63a845c77f9aa8a() {
  level endon("game_ended");
  level endon("stop_party_wipe_monitor");

  while(true) {
    if(istrue(level.var_1ba46ecf09b8e08c)) {
      wait 1;
      continue;
    }

    var_fc40a742a65a2dc5 = 0;

    foreach(player in level.players) {
      if(isDefined(player.dogtag)) {
        var_fc40a742a65a2dc5++;
      }
    }

    if(var_fc40a742a65a2dc5 > 0) {
      if(!istrue(level.var_77f52e0ccb8547eb)) {
        thread function_6c3415fc06b0db95(&"COOP_GAME_PLAY/SINGLE_DEATH_WIPE_TIME_STARTED", &"COOP_GAME_PLAY/SINGLE_DEATH_WIPE_SQUAD", 90);
      }
    } else if(istrue(level.var_77f52e0ccb8547eb) && !istrue(level.var_c7a0eaf3bc52a259)) {
      if(function_f8448fd91abb54c8()) {
        thread hardmode_stop_party_wipe_timer(0);
        var_d32605eb65369628 = level.var_a80e6d45222f9a47;
        setomnvar("cp_objective_sub_count_4", int(var_d32605eb65369628));
      } else {
        thread hardmode_stop_party_wipe_timer(1);
      }
    }

    wait 1;
  }
}

function function_cbd65fa4a48cc872() {
  level endon("game_ended");
  level endon("stop_party_wipe_monitor");

  while(true) {
    if(istrue(level.var_1ba46ecf09b8e08c) || !isDefined(level.var_a80e6d45222f9a47)) {
      wait 1;
      continue;
    }

    var_fc40a742a65a2dc5 = 0;

    foreach(player in level.players) {
      if(!function_dc6fd5e481fa370a(player)) {
        var_fc40a742a65a2dc5++;
      }
    }

    if(istrue(level.var_5c966a6569a6f4b5)) {
      if(istrue(level.var_ec0baa43406de34a) && !istrue(level.var_77f52e0ccb8547eb)) {
        thread scripts\cp\cp_gameskill::function_6c3415fc06b0db95(&"COOP_GAME_PLAY/HARDMODE_OXYMASK_DEPLETED", &"COOP_GAME_PLAY/HARDMODE_OXYMASK_GAMEOVER");
      }
    } else if(level.var_a80e6d45222f9a47 > 0) {
      if(istrue(level.var_77f52e0ccb8547eb)) {
        if(istrue(var_fc40a742a65a2dc5 <= 0)) {
          hardmode_stop_party_wipe_timer();
        }
      }
    } else if(var_fc40a742a65a2dc5 > 0 && level.var_a80e6d45222f9a47 <= 0) {
      if(!istrue(level.var_c7a0eaf3bc52a259)) {
        level notify("single_party_wipe_timer");
        level.var_c7a0eaf3bc52a259 = 1;
      }

      if(!istrue(level.var_77f52e0ccb8547eb)) {
        thread function_6c3415fc06b0db95();
      }
    }

    wait 1;
  }
}

function function_6c3415fc06b0db95(warning_message, gameover_message, timer_override) {
  level endon("game_ended");
  level endon("hardmode_stop_party_wipe_timer");
  level notify("single_party_wipe_timer");
  level endon("single_party_wipe_timer");

  if(!isDefined(timer_override)) {
    var_2cdacd5098d286d3 = 20;
  } else {
    var_2cdacd5098d286d3 = timer_override;
  }

  if(istrue(level.var_77f52e0ccb8547eb)) {
    return;
  }

  level.var_77f52e0ccb8547eb = 1;
  waitframe();

  if(!isDefined(warning_message)) {
    warning_message = &"COOP_GAME_PLAY/HARDMODE_WIPE_TIME_STARTED";
  }

  if(!isDefined(gameover_message)) {
    gameover_message = &"COOP_GAME_PLAY/HARDMODE_WIPE_INFO";
  }

  level.var_88fd0da9196867bd = getomnvar("cp_countdown_timer_alpha");
  level.var_a212c5b82814375a = getomnvar("cp_countdown_timer");
  level.var_24be3aa5d7bf4883 = gettime();
  setomnvar("cp_countdown_timer_alpha", 5);
  setomnvar("cp_countdown_timer", gettime() + var_2cdacd5098d286d3 * 1000);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(warning_message, "allies", 10);
  var_ea6ae587890f64dd = gettime() + var_2cdacd5098d286d3 * 1000;

  while(gettime() < var_ea6ae587890f64dd) {
    wait 1;
  }

  scripts\cp\cp_hud_message::teamhudtutorialmessage(gameover_message, "allies", 4);
  wait 3;
  level notify("stop_party_wipe_monitor");
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function hardmode_stop_party_wipe_timer(var_1395f8a358756e37) {
  level.var_77f52e0ccb8547eb = 0;
  level.var_c7a0eaf3bc52a259 = 0;
  level notify("hardmode_stop_party_wipe_timer");

  if(!istrue(var_1395f8a358756e37)) {
    scripts\cp\cp_gameskill::function_3898e5f82c5c37df(istrue(level.var_cba4f601411edef5));
  }

  wait 1;

  if(isDefined(level.var_88fd0da9196867bd)) {
    setomnvar("cp_countdown_timer_alpha", level.var_88fd0da9196867bd);
    level.var_88fd0da9196867bd = undefined;

    if(isDefined(level.var_a212c5b82814375a)) {
      setomnvar("cp_countdown_timer", level.var_a212c5b82814375a);
      level.var_a212c5b82814375a = undefined;
    }

    return;
  }

  setomnvar("cp_countdown_timer_alpha", 0);
}

function function_dc6fd5e481fa370a(player) {
  return isalive(player) && !istrue(player.inlaststand) || istrue(player.respawn_in_progress);
}

function function_127b010126b6a90() {
  level.var_1ba46ecf09b8e08c = 1;
}

function function_77e524f19eb4608f() {
  level.var_1ba46ecf09b8e08c = undefined;
}

function auto_adjust_init() {
  setdvarifuninitialized(@ "hash_ea3e0064074fd39b", 1);
  setdvarifuninitialized(@ "hash_84003ec62f06a169", 1);

  if(!getdvarint(@ "hash_ea3e0064074fd39b")) {
    return;
  }

  if(!isDefined(level.var_4109d33f0329c17)) {
    level.var_4109d33f0329c17 = spawnStruct();
    level.var_4109d33f0329c17.data = [];
    level.var_4109d33f0329c17.playerdead = 0;
  }

  function_3046c3ce55bbdedd();
  flag_set("aa_init_completed");
}

function function_fd716ba463a7acc0(force_reset) {
  if(!function_67c8c7a52f39fcdc()) {
    return;
  }

  self.gs.var_3bc5f2b69266d1fc = -1;

  if(!istrue(self.pers["restarted"]) || istrue(force_reset)) {
    auto_adjust_data_set("playerdeath_count", 0);
  }
}

function function_71ec52011ff77954() {
  level endon("game_ended");
  flag_wait("aa_init_completed");
  level.var_4109d33f0329c17.currentfrac = 0;
  level.player function_fd716ba463a7acc0(1);
}

function function_ef95bb7d1c3bdafa() {
  if(!function_67c8c7a52f39fcdc()) {
    return;
  }

  level.var_4109d33f0329c17.currentfrac = 0;
  auto_adjust_set_table();
}

function auto_adjust_set_table() {
  level.var_4109d33f0329c17.table = [];

  if(level.gameskill == 2) {
    level.var_4109d33f0329c17.table[0] = 0;
    level.var_4109d33f0329c17.table[3] = 0.3;
    level.var_4109d33f0329c17.table[5] = 0.5;
    level.var_4109d33f0329c17.table[7] = 0.6;
    return;
  }

  level.var_4109d33f0329c17.table[0] = 0;
  level.var_4109d33f0329c17.table[1] = 0.3;
  level.var_4109d33f0329c17.table[2] = 0.5;
  level.var_4109d33f0329c17.table[4] = 0.7;
  level.var_4109d33f0329c17.table[5] = 0.9;
}

function function_3046c3ce55bbdedd() {
  level.var_4109d33f0329c17.var_4c50a3e356158482 = gettime() + 600000;
}

function function_67c8c7a52f39fcdc() {
  return isDefined(level.var_4109d33f0329c17);
}

function auto_adjust_thread() {
  if(!function_67c8c7a52f39fcdc()) {
    return;
  }

  if(istrue(level.var_4109d33f0329c17.var_6fca325989f1e3ce)) {
    return;
  }

  level.var_4109d33f0329c17.var_6fca325989f1e3ce = 1;
  version = getbuildversion();

  while(true) {
    if(level.gameskill > 2) {
      if(version != "SHIP") {
        if(getdvarint(@ "hash_84003ec62f06a169") == 1) {
          foreach(player in level.players) {
            player auto_adjust_debuglite();
          }
        } else if(getdvarint(@ "hash_84003ec62f06a169") > 1) {
          foreach(player in level.players) {
            player auto_adjust_debug();
          }
        }
      }

      wait 1;
      continue;
    }

    if(level.players.size == 0) {
      wait 0.2;
      continue;
    }

    if(gettime() >= level.var_4109d33f0329c17.var_4c50a3e356158482) {
      function_3046c3ce55bbdedd();

      foreach(player in level.players) {
        if(isalive(player)) {
          player function_4e8f424b3ccc0d72();
        }
      }
    }

    var_c5d870a3537e5331 = -1;

    foreach(player in level.players) {
      if(!isalive(player)) {
        continue;
      }

      if(!isDefined(player.gs)) {
        continue;
      }

      playerdeaths = player auto_adjust_data_get("playerdeath_count");

      if(playerdeaths > var_c5d870a3537e5331) {
        var_c5d870a3537e5331 = playerdeaths;
      }
    }

    foreach(index, _ in level.var_4109d33f0329c17.table) {
      if(var_c5d870a3537e5331 >= index) {
        tabledeathcount = index;
      }
    }

    foreach(player in level.players) {
      player function_e96291a58418af14(tabledeathcount);
    }

    if(version != "SHIP") {
      if(getdvarint(@ "hash_84003ec62f06a169") == 1) {
        foreach(player in level.players) {
          player auto_adjust_debuglite();
        }
      } else if(getdvarint(@ "hash_84003ec62f06a169") > 1) {
        foreach(player in level.players) {
          player auto_adjust_debug();
        }
      }
    }

    level waittill_notify_or_timeout("auto_adjust_update_now", 1);
  }
}

function can_auto_adjust(deathcount) {
  if(!isDefined(self.gs)) {
    return false;
  }

  if(!isDefined(level.var_4109d33f0329c17.table[deathcount])) {
    return false;
  }

  if(self.gs.var_3bc5f2b69266d1fc == level.var_4109d33f0329c17.table[deathcount]) {
    return false;
  }

  return true;
}

function function_e96291a58418af14(deathcount) {
  if(!can_auto_adjust(deathcount)) {
    return;
  }

  level.var_4109d33f0329c17.currentfrac = level.var_4109d33f0329c17.table[deathcount];
  self.gs.var_3bc5f2b69266d1fc = level.var_4109d33f0329c17.currentfrac;
  self.gs.invultime_deathshieldduration = auto_adjust_lerp_setting("invulTime_deathShieldDuration");
  self.gs.deathsdoorduration = auto_adjust_lerp_setting("player_deathsDoorDuration");
  self.gs.healthregendelay = auto_adjust_lerp_setting("player_healthRegenDelay");
  self.gs.healthregenrate = auto_adjust_lerp_setting("player_healthRegenRate");
  self.gs.damagemultiplierhealth = self.maxhealth / auto_adjust_lerp_setting("player_health");
  self.gs.damagemultiplierexplosive = auto_adjust_lerp_setting("explosiveDamageMultiplier");
  forced_sniper_misses = int(auto_adjust_lerp_setting("forced_sniper_misses"));
  var_4c879478ceb0acf = auto_adjust_lerp_setting("sniperAccuDiffScale");
  function_90faf3f11984372a(var_4c879478ceb0acf, forced_sniper_misses, 1);
  self.damagemultiplier = self.gs.damagemultiplierhealth;
  self.var_da4b6392c1bec6a1 = auto_adjust_lerp_setting("missTimeConstant");
  self.var_cef700ed012e8981 = auto_adjust_lerp_setting("missTimeDistanceFactor");
  function_a7f19b92c7f7a6a8();
}

function function_a7f19b92c7f7a6a8() {}

function auto_adjust_lerp_setting(setting) {
  var_b0e75118d3c9dde8 = self.gameskill - 1;
  var_be6da4f53631a129 = get_difficultysetting(setting, var_b0e75118d3c9dde8);
  var_d58d8bffb394c16b = get_difficultysetting(setting);
  var_eeb5fcd04f1822ec = math::lerp(var_d58d8bffb394c16b, var_be6da4f53631a129, level.var_4109d33f0329c17.currentfrac);
  return var_eeb5fcd04f1822ec;
}

function auto_adjust_data_add(name, add) {
  self.pers["aa"][name] = self.pers["aa"][name] + add;
}

function auto_adjust_data_set(name, val) {
  self.pers["aa"][name] = val;
}

function auto_adjust_data_get(name) {
  return self.pers["aa"][name];
}

function auto_adjust_playerdied() {
  if(!isDefined(level.var_4109d33f0329c17)) {
    return;
  }

  count = auto_adjust_data_get("playerdeath_count");

  if(count == 7) {
    return;
  }

  auto_adjust_data_add("playerdeath_count", 1);
  level notify("auto_adjust_update_now");
}

function function_4e8f424b3ccc0d72() {
  count = auto_adjust_data_get("playerdeath_count");

  if(count == 0) {
    return;
  }

  auto_adjust_data_add("playerdeath_count", -1);
  level notify("auto_adjust_update_now");
}

function auto_adjust_difficult_get() {
  return level.gameskill - level.var_4109d33f0329c17.currentfrac;
}

function auto_adjust_debug() {
  if(!isDefined(self.gs)) {
    return;
  }

  if(!self ishost()) {
    return;
  }

  level.var_4109d33f0329c17.debugprintline = 0;

  if(level.gameskill == 3) {
    function_c1c25d5aa7d1dde0("<dev string:x1c>", -1);
  } else {
    function_c1c25d5aa7d1dde0("<dev string:x1c>", auto_adjust_data_get("<dev string:x34>"));
  }

  function_c1c25d5aa7d1dde0("<dev string:x46>", level.gameskill);
  function_c1c25d5aa7d1dde0("<dev string:x5e>", auto_adjust_difficult_get());
  level.var_4109d33f0329c17.debugprintline++;
  function_c1c25d5aa7d1dde0("<dev string:x76>", self.gs.healthregendelay, get_difficultysetting("<dev string:x8e>"));
  function_c1c25d5aa7d1dde0("<dev string:xa6>", self.gs.healthregenrate, get_difficultysetting("<dev string:xbe>"));
  function_c1c25d5aa7d1dde0("<dev string:xd5>", self.gs.invultime_deathshieldduration, get_difficultysetting("<dev string:xed>"));
  function_c1c25d5aa7d1dde0("<dev string:x10b>", self.gs.deathsdoorduration, get_difficultysetting("<dev string:x123>"));
  function_c1c25d5aa7d1dde0("<dev string:x13d>", self.gs.damagemultiplierhealth, self.maxhealth / get_difficultysetting("<dev string:x155>"));
  function_c1c25d5aa7d1dde0("<dev string:x163>", self.gs.damagemultiplierexplosive, get_difficultysetting("<dev string:x17b>"));
  function_c1c25d5aa7d1dde0("<dev string:x195>", self.var_da4b6392c1bec6a1, get_difficultysetting("<dev string:x1ad>"));
  function_c1c25d5aa7d1dde0("<dev string:x1be>", self.var_cef700ed012e8981, get_difficultysetting("<dev string:x1d6>"));
}

function function_c1c25d5aa7d1dde0(msg, val, val2) {
  if(isDefined(level.var_4109d33f0329c17.var_a4b630c331b246a6)) {
    foreach(hud in level.var_4109d33f0329c17.var_a4b630c331b246a6) {
      hud destroy();
    }

    level.var_4109d33f0329c17.var_a4b630c331b246a6 = [];
  }

  if(!isDefined(val2)) {
    val2 = "<dev string:x1ed>";
  }

  msg = msg + val + "<dev string:x1ee>" + val2;
  printtoscreen2d(10, 700 + 14 * level.var_4109d33f0329c17.debugprintline, msg, (1, 1, 1), 1, 20);
  level.var_4109d33f0329c17.debugprintline++;
}

function auto_adjust_debuglite() {
  if(!self ishost()) {
    return;
  }

  if(!isDefined(level.var_4109d33f0329c17.var_a4b630c331b246a6)) {
    level.var_4109d33f0329c17.var_a4b630c331b246a6 = [];
    hud = newhudelem();
    hud.alignx = "right";
    hud.x = 134;
    hud.y = 2;
    hud.fontscale = 0.7;
    hud.font = "default";
    hud.horzalign = "fullscreen";
    hud.vertalign = "fullscreen";
    hud.sort = 20;
    hud.color = (0, 1, 1);
    hud settext("HUD");
    level.var_4109d33f0329c17.var_a4b630c331b246a6[0] = hud;
    var_fb1188ca74cb9f28 = newhudelem();
    var_fb1188ca74cb9f28.alignx = "left";
    var_fb1188ca74cb9f28.x = 138;
    var_fb1188ca74cb9f28.y = 2;
    var_fb1188ca74cb9f28.fontscale = 0.7;
    var_fb1188ca74cb9f28.font = "default";
    var_fb1188ca74cb9f28.horzalign = "fullscreen";
    var_fb1188ca74cb9f28.vertalign = "fullscreen";
    var_fb1188ca74cb9f28.color = (0, 1, 1);
    var_fb1188ca74cb9f28.sort = 20;
    level.var_4109d33f0329c17.var_a4b630c331b246a6[2] = var_fb1188ca74cb9f28;
  }

  var_8e21e6f1f4ff85bd = level.var_4109d33f0329c17.var_a4b630c331b246a6[0];
  var_bba1a15604a90f82 = level.var_4109d33f0329c17.var_a4b630c331b246a6[2];
  var_8e21e6f1f4ff85bd setvalue(auto_adjust_data_get("playerdeath_count"));
  var_bba1a15604a90f82 setvalue(level.gameskill - level.var_4109d33f0329c17.currentfrac);
}