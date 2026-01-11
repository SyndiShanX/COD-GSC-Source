/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\gameskill.gsc
************************************/

func_95F9() {
  if(!scripts\engine\utility::add_init_script("gameskill", ::func_95F9)) {
    return;
  }

  precacheshader("fullscreen_dirt_bottom_b");
  precacheshader("fullscreen_dirt_bottom");
  precacheshader("fullscreen_dirt_left");
  precacheshader("fullscreen_dirt_right");
  precacheshader("fullscreen_bloodsplat_bottom");
  precacheshader("fullscreen_bloodsplat_left");
  precacheshader("fullscreen_bloodsplat_right");
  precacheshader("vfx_ui_player_pain_overlay");
  precachestring(&"GAME_GET_TO_COVER");
  precachestring(&"GAME_USE_RETRACT_SHIELD");
  precachestring(&"GAME_LAST_STAND_GET_BACK_UP");
  lib_0B5F::func_965A();
  func_F385();
  thread func_14ED();
  func_F848();
  level thread func_13C1A();
}

func_F848(param_00) {
  if(!isDefined(level.script)) {
    level.script = tolower(getdvar("mapname"));
  }

  if(!isDefined(param_00) || param_00 == 0) {
    if(isDefined(level.var_7683)) {
      return;
    }

    if(!isDefined(level.var_4C6B)) {
      level.var_4C6B = ::func_E44D;
    }

    level._meth_83D4 = ::func_61BA;
    level._meth_83D3 = ::func_61BA;
    level.vehicle_canturrettargetpoint = ::func_61BA;
    scripts\sp\utility::func_F305();
    foreach(var_02 in level.players) {
      var_02 scripts\sp\utility::func_65E0("player_has_red_flashing_overlay");
      var_02 scripts\sp\utility::func_65E0("player_is_invulnerable");
      var_02 scripts\sp\utility::func_65E0("player_zero_attacker_accuracy");
      var_02 scripts\sp\utility::func_65E0("player_no_auto_blur");
      var_02 scripts\sp\utility::func_65E0("redflashoverlay_complete");
      var_02 scripts\sp\utility::func_65E0("near_death_vision_enabled");
      var_02 scripts\sp\utility::func_65E1("near_death_vision_enabled");
      var_02.gs = spawnStruct();
      var_02.gs.var_B639 = spawnStruct();
      var_02 func_9723();
      var_02.a = spawnStruct();
      var_02.var_4CF5 = [];
      var_02 scripts\sp\player_stats::func_9768();
      var_02 scripts\sp\utility::func_65E0("global_hint_in_use");
      var_02.pers = [];
      if(!isDefined(var_02.var_28A4)) {
        var_02.var_28A4 = 0;
      }

      var_02.disabledweapon = 0;
      var_02.disabledweaponswitch = 0;
      var_02.disabledusability = 0;
      var_02 _meth_831C("frag");
    }

    level.var_54D3[0] = "easy";
    level.var_54D3[1] = "normal";
    level.var_54D3[2] = "hardened";
    level.var_54D3[3] = "veteran";
    level.var_54D2["easy"] = &"GAMESKILL_EASY";
    level.var_54D2["normal"] = &"GAMESKILL_NORMAL";
    level.var_54D2["hardened"] = &"GAMESKILL_HARDENED";
    level.var_54D2["veteran"] = &"GAMESKILL_VETERAN";
    thread func_7685();
  }

  setdvarifuninitialized("autodifficulty_playerDeathTimer", 0);
  anim.var_E7D4 = 0.5;
  anim.var_1385F = 0.8;
  setdvar("autodifficulty_frac", 0);
  level.var_54D1 = [];
  foreach(var_02 in level.players) {
    var_02 func_9772();
    var_02 thread func_93F7();
  }

  level.var_B6AD = 8;
  level.var_B6AC = 16;
  level.var_54D0["playerGrenadeBaseTime"]["easy"] = -25536;
  level.var_54D0["playerGrenadeBaseTime"]["normal"] = -30536;
  level.var_54D0["playerGrenadeBaseTime"]["hardened"] = 25000;
  level.var_54D0["playerGrenadeBaseTime"]["veteran"] = 25000;
  level.var_54D0["playerGrenadeRangeTime"]["easy"] = 20000;
  level.var_54D0["playerGrenadeRangeTime"]["normal"] = 15000;
  level.var_54D0["playerGrenadeRangeTime"]["hardened"] = 10000;
  level.var_54D0["playerGrenadeRangeTime"]["veteran"] = 10000;
  level.var_54D0["playerDoubleGrenadeTime"]["easy"] = 3600000;
  level.var_54D0["playerDoubleGrenadeTime"]["normal"] = 150000;
  level.var_54D0["playerDoubleGrenadeTime"]["hardened"] = 90000;
  level.var_54D0["playerDoubleGrenadeTime"]["veteran"] = 90000;
  level.var_54D0["double_grenades_allowed"]["easy"] = 0;
  level.var_54D0["double_grenades_allowed"]["normal"] = 1;
  level.var_54D0["double_grenades_allowed"]["hardened"] = 1;
  level.var_54D0["double_grenades_allowed"]["veteran"] = 1;
  level.var_54D0["threatbias"]["easy"] = 100;
  level.var_54D0["threatbias"]["normal"] = 150;
  level.var_54D0["threatbias"]["hardened"] = 200;
  level.var_54D0["threatbias"]["veteran"] = 400;
  level.var_54D0["base_enemy_accuracy"]["easy"] = 0.9;
  level.var_54D0["base_enemy_accuracy"]["normal"] = 1;
  level.var_54D0["base_enemy_accuracy"]["hardened"] = 1.15;
  level.var_54D0["base_enemy_accuracy"]["veteran"] = 1.15;
  level.var_54D0["accuracyDistScale"]["easy"] = 1;
  level.var_54D0["accuracyDistScale"]["normal"] = 1;
  level.var_54D0["accuracyDistScale"]["hardened"] = 0.6;
  level.var_54D0["accuracyDistScale"]["veteran"] = 0.8;
  level.var_54D0["min_sniper_burst_delay_time"]["easy"] = 3;
  level.var_54D0["min_sniper_burst_delay_time"]["normal"] = 2;
  level.var_54D0["min_sniper_burst_delay_time"]["hardened"] = 1.5;
  level.var_54D0["min_sniper_burst_delay_time"]["veteran"] = 1.1;
  level.var_54D0["sniper_converge_scale"]["easy"] = 1.3;
  level.var_54D0["sniper_converge_scale"]["normal"] = 1.1;
  level.var_54D0["sniper_converge_scale"]["hardened"] = 0.9;
  level.var_54D0["sniper_converge_scale"]["veteran"] = 0.7;
  level.var_54D0["sniperAccuDiffScale"]["easy"] = 1;
  level.var_54D0["sniperAccuDiffScale"]["normal"] = 1.6;
  level.var_54D0["sniperAccuDiffScale"]["hardened"] = 1.6;
  level.var_54D0["sniperAccuDiffScale"]["veteran"] = 1.9;
  level.var_54D0["max_sniper_burst_delay_time"]["easy"] = 4;
  level.var_54D0["max_sniper_burst_delay_time"]["normal"] = 3;
  level.var_54D0["max_sniper_burst_delay_time"]["hardened"] = 2;
  level.var_54D0["max_sniper_burst_delay_time"]["veteran"] = 1.5;
  level.var_54D0["c6_TorsoDamageDismemberLimbChance"]["easy"] = 70;
  level.var_54D0["c6_TorsoDamageDismemberLimbChance"]["normal"] = 40;
  level.var_54D0["c6_TorsoDamageDismemberLimbChance"]["hardened"] = 30;
  level.var_54D0["c6_TorsoDamageDismemberLimbChance"]["veteran"] = 20;
  level.var_54D0["pain_test"]["easy"] = ::func_1D5A;
  level.var_54D0["pain_test"]["normal"] = ::func_1D5A;
  level.var_54D0["pain_test"]["hardened"] = ::func_C868;
  level.var_54D0["pain_test"]["veteran"] = ::func_C868;
  level.var_54D0["missTimeConstant"]["easy"] = 1;
  level.var_54D0["missTimeConstant"]["normal"] = 0.05;
  level.var_54D0["missTimeConstant"]["hardened"] = 0;
  level.var_54D0["missTimeConstant"]["veteran"] = 0;
  level.var_54D0["missTimeDistanceFactor"]["easy"] = 0.0008;
  level.var_54D0["missTimeDistanceFactor"]["normal"] = 0.0001;
  level.var_54D0["missTimeDistanceFactor"]["hardened"] = 5E-05;
  level.var_54D0["missTimeDistanceFactor"]["veteran"] = 0;
  level.var_54D0["flashbangedInvulFactor"]["easy"] = 0.25;
  level.var_54D0["flashbangedInvulFactor"]["normal"] = 0;
  level.var_54D0["flashbangedInvulFactor"]["hardened"] = 0;
  level.var_54D0["flashbangedInvulFactor"]["veteran"] = 0;
  level.var_54D0["player_criticalBulletDamageDist"]["easy"] = 0;
  level.var_54D0["player_criticalBulletDamageDist"]["normal"] = 0;
  level.var_54D0["player_criticalBulletDamageDist"]["hardened"] = 0;
  level.var_54D0["player_criticalBulletDamageDist"]["veteran"] = 0;
  level.var_54D0["player_deathInvulnerableTime"]["easy"] = 4000;
  level.var_54D0["player_deathInvulnerableTime"]["normal"] = 2500;
  level.var_54D0["player_deathInvulnerableTime"]["hardened"] = 600;
  level.var_54D0["player_deathInvulnerableTime"]["veteran"] = 100;
  level.var_54D0["invulTime_preShield"]["easy"] = 0.6;
  level.var_54D0["invulTime_preShield"]["normal"] = 0.5;
  level.var_54D0["invulTime_preShield"]["hardened"] = 0.3;
  level.var_54D0["invulTime_preShield"]["veteran"] = 0;
  level.var_54D0["invulTime_onShield"]["easy"] = 1.6;
  level.var_54D0["invulTime_onShield"]["normal"] = 1;
  level.var_54D0["invulTime_onShield"]["hardened"] = 0.5;
  level.var_54D0["invulTime_onShield"]["veteran"] = 0.25;
  level.var_54D0["invulTime_postShield"]["easy"] = 0.5;
  level.var_54D0["invulTime_postShield"]["normal"] = 0.4;
  level.var_54D0["invulTime_postShield"]["hardened"] = 0.3;
  level.var_54D0["invulTime_postShield"]["veteran"] = 0;
  level.var_54D0["playerHealth_RegularRegenDelay"]["easy"] = 4000;
  level.var_54D0["playerHealth_RegularRegenDelay"]["normal"] = 4000;
  level.var_54D0["playerHealth_RegularRegenDelay"]["hardened"] = 3000;
  level.var_54D0["playerHealth_RegularRegenDelay"]["veteran"] = 1200;
  level.var_54D0["regularRegenDelayScalar"] = 1;
  level.var_54D0["worthyDamageRatio"]["easy"] = 0;
  level.var_54D0["worthyDamageRatio"]["normal"] = 0.1;
  level.var_54D0["worthyDamageRatio"]["hardened"] = 0.3;
  level.var_54D0["worthyDamageRatio"]["veteran"] = 0.3;
  level.var_54D0["playerDifficultyHealth"]["easy"] = 475;
  level.var_54D0["playerDifficultyHealth"]["normal"] = 275;
  level.var_54D0["playerDifficultyHealth"]["hardened"] = 165;
  level.var_54D0["playerDifficultyHealth"]["veteran"] = 115;
  level.var_54D0["longRegenTime"]["easy"] = 5000;
  level.var_54D0["longRegenTime"]["normal"] = 5000;
  level.var_54D0["longRegenTime"]["hardened"] = 3200;
  level.var_54D0["longRegenTime"]["veteran"] = 3200;
  level.var_54D0["longRegenTimeScalar"] = 1;
  level.var_54D0["healthOverlayCutoff"]["easy"] = 0.02;
  level.var_54D0["healthOverlayCutoff"]["normal"] = 0.02;
  level.var_54D0["healthOverlayCutoff"]["hardened"] = 0.02;
  level.var_54D0["healthOverlayCutoff"]["veteran"] = 0.02;
  level.var_54D0["health_regenRate"]["easy"] = 0.02;
  level.var_54D0["health_regenRate"]["normal"] = 0.02;
  level.var_54D0["health_regenRate"]["hardened"] = 0.02;
  level.var_54D0["health_regenRate"]["veteran"] = 0.02;
  level.var_54D0["explosivePlantTime"]["easy"] = 10;
  level.var_54D0["explosivePlantTime"]["normal"] = 10;
  level.var_54D0["explosivePlantTime"]["hardened"] = 5;
  level.var_54D0["explosivePlantTime"]["veteran"] = 5;
  level.var_54D0["player_downed_buffer_time"]["normal"] = 2;
  level.var_54D0["player_downed_buffer_time"]["hardened"] = 1.5;
  level.var_54D0["player_downed_buffer_time"]["veteran"] = 0;
  level.var_54D0["c12_RocketTellHoldTime"]["easy"] = 1.5;
  level.var_54D0["c12_RocketTellHoldTime"]["normal"] = 1;
  level.var_54D0["c12_RocketTellHoldTime"]["hardened"] = 0.5;
  level.var_54D0["c12_RocketTellHoldTime"]["veteran"] = 0;
  level.var_54D0["c12_DismemberRecoveryTime"]["easy"] = 9;
  level.var_54D0["c12_DismemberRecoveryTime"]["normal"] = 6;
  level.var_54D0["c12_DismemberRecoveryTime"]["hardened"] = 3;
  level.var_54D0["c12_DismemberRecoveryTime"]["veteran"] = 0;
  level.var_54D0["c12_MinigunStruggleDamage"]["easy"] = 15.5;
  level.var_54D0["c12_MinigunStruggleDamage"]["normal"] = 16;
  level.var_54D0["c12_MinigunStruggleDamage"]["hardened"] = 20;
  level.var_54D0["c12_MinigunStruggleDamage"]["veteran"] = 30;
  level.var_54D0["playerJackalHealth"]["easy"] = 5500;
  level.var_54D0["playerJackalHealth"]["normal"] = 4000;
  level.var_54D0["playerJackalHealth"]["hardened"] = 2400;
  level.var_54D0["playerJackalHealth"]["veteran"] = 1600;
  level.var_54D0["playerJackalBaseAimAssist"]["easy"] = 1.5;
  level.var_54D0["playerJackalBaseAimAssist"]["normal"] = 1;
  level.var_54D0["playerJackalBaseAimAssist"]["hardened"] = 1;
  level.var_54D0["playerJackalBaseAimAssist"]["veteran"] = 1;
  level.var_54D0["playerJackalInvulnerableTime"]["easy"] = 6500;
  level.var_54D0["playerJackalInvulnerableTime"]["normal"] = 4500;
  level.var_54D0["playerJackalInvulnerableTime"]["hardened"] = 2000;
  level.var_54D0["playerJackalInvulnerableTime"]["veteran"] = 500;
  level.var_54D0["playerJackalRegularRegenDelay"]["easy"] = 3000;
  level.var_54D0["playerJackalRegularRegenDelay"]["normal"] = 3000;
  level.var_54D0["playerJackalRegularRegenDelay"]["hardened"] = 1000;
  level.var_54D0["playerJackalRegularRegenDelay"]["veteran"] = 1000;
  level.var_54D0["playerJackalLongRegenDelay"]["easy"] = 4000;
  level.var_54D0["playerJackalLongRegenDelay"]["normal"] = 4000;
  level.var_54D0["playerJackalLongRegenDelay"]["hardened"] = 2000;
  level.var_54D0["playerJackalLongRegenDelay"]["veteran"] = 2000;
  level.var_54D0["playerJackalHealthRegenRate"]["easy"] = 70;
  level.var_54D0["playerJackalHealthRegenRate"]["normal"] = 30;
  level.var_54D0["playerJackalHealthRegenRate"]["hardened"] = 20;
  level.var_54D0["playerJackalHealthRegenRate"]["veteran"] = 10;
  level.var_54D0["playerJackalImpactDamageScale"]["easy"] = 0.5;
  level.var_54D0["playerJackalImpactDamageScale"]["normal"] = 1;
  level.var_54D0["playerJackalImpactDamageScale"]["hardened"] = 1;
  level.var_54D0["playerJackalImpactDamageScale"]["veteran"] = 1.2;
  level.var_54D0["JackalHoverheatRampTime"]["easy"] = 20000;
  level.var_54D0["JackalHoverheatRampTime"]["normal"] = 20000;
  level.var_54D0["JackalHoverheatRampTime"]["hardened"] = 15000;
  level.var_54D0["JackalHoverheatRampTime"]["veteran"] = 10000;
  level.var_54D0["JackalHoverheatMaxEnemies"]["easy"] = 5;
  level.var_54D0["JackalHoverheatMaxEnemies"]["normal"] = 6;
  level.var_54D0["JackalHoverheatMaxEnemies"]["hardened"] = 7;
  level.var_54D0["JackalHoverheatMaxEnemies"]["veteran"] = 8;
  level.var_54D0["JackalAttackercountMaxScalar"]["easy"] = 0.5;
  level.var_54D0["JackalAttackercountMaxScalar"]["normal"] = 0.7;
  level.var_54D0["JackalAttackercountMaxScalar"]["hardened"] = 0.8;
  level.var_54D0["JackalAttackercountMaxScalar"]["veteran"] = 0.9;
  level.var_54D0["JackalAttackercountMax"]["easy"] = 3;
  level.var_54D0["JackalAttackercountMax"]["normal"] = 4;
  level.var_54D0["JackalAttackercountMax"]["hardened"] = 5;
  level.var_54D0["JackalAttackercountMax"]["veteran"] = 5;
  level.var_54D0["JackalAccuracyPerSecond"]["easy"] = 0.2;
  level.var_54D0["JackalAccuracyPerSecond"]["normal"] = 0.3;
  level.var_54D0["JackalAccuracyPerSecond"]["hardened"] = 0.6;
  level.var_54D0["JackalAccuracyPerSecond"]["veteran"] = 0.9;
  level.var_54D0["JackalLockingBoostEscapeScale"]["easy"] = 4;
  level.var_54D0["JackalLockingBoostEscapeScale"]["normal"] = 3;
  level.var_54D0["JackalLockingBoostEscapeScale"]["hardened"] = 2;
  level.var_54D0["JackalLockingBoostEscapeScale"]["veteran"] = 1;
  level.var_54D0["JackalLockedBoostEscapeScale"]["easy"] = 6;
  level.var_54D0["JackalLockedBoostEscapeScale"]["normal"] = 4;
  level.var_54D0["JackalLockedBoostEscapeScale"]["hardened"] = 2;
  level.var_54D0["JackalLockedBoostEscapeScale"]["veteran"] = 1;
  level.var_54D0["JackalLockedTurnEscapeScale"]["easy"] = 2;
  level.var_54D0["JackalLockedTurnEscapeScale"]["normal"] = 1.5;
  level.var_54D0["JackalLockedTurnEscapeScale"]["hardened"] = 1.1;
  level.var_54D0["JackalLockedTurnEscapeScale"]["veteran"] = 1;
  level.var_54D0["JackalTargetAidMinTime"]["easy"] = 2;
  level.var_54D0["JackalTargetAidMinTime"]["normal"] = 2;
  level.var_54D0["JackalTargetAidMinTime"]["hardened"] = 2;
  level.var_54D0["JackalTargetAidMinTime"]["veteran"] = 2;
  level.var_54D0["JackalTargetAidMaxTime"]["easy"] = 3;
  level.var_54D0["JackalTargetAidMaxTime"]["normal"] = 3;
  level.var_54D0["JackalTargetAidMaxTime"]["hardened"] = 3;
  level.var_54D0["JackalTargetAidMaxTime"]["veteran"] = 3;
  level.var_54D0["JackalIncomingMissileSpeedScale"]["easy"] = 0.54;
  level.var_54D0["JackalIncomingMissileSpeedScale"]["normal"] = 1;
  level.var_54D0["JackalIncomingMissileSpeedScale"]["hardened"] = 1.35;
  level.var_54D0["JackalIncomingMissileSpeedScale"]["veteran"] = 1.75;
  level.var_54D0["JackallockonEnemyShowdownAccuracy"]["easy"] = 0.5;
  level.var_54D0["JackallockonEnemyShowdownAccuracy"]["normal"] = 0.75;
  level.var_54D0["JackallockonEnemyShowdownAccuracy"]["hardened"] = 0.9;
  level.var_54D0["JackallockonEnemyShowdownAccuracy"]["veteran"] = 1;
  level.var_54D0["CapShipMiniflakThresholdMin"]["easy"] = -0.85;
  level.var_54D0["CapShipMiniflakThresholdMin"]["normal"] = -0.8;
  level.var_54D0["CapShipMiniflakThresholdMin"]["hardened"] = -0.78;
  level.var_54D0["CapShipMiniflakThresholdMin"]["veteran"] = -0.75;
  level.var_54D0["CapShipMiniflakThresholdMax"]["easy"] = -0.4;
  level.var_54D0["CapShipMiniflakThresholdMax"]["normal"] = -0.35;
  level.var_54D0["CapShipMiniflakThresholdMax"]["hardened"] = -0.34;
  level.var_54D0["CapShipMiniflakThresholdMax"]["veteran"] = -0.33;
  level.var_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["easy"] = -0.75;
  level.var_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["normal"] = -0.7;
  level.var_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["hardened"] = -0.68;
  level.var_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["veteran"] = -0.66;
  level.var_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["easy"] = -0.32;
  level.var_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["normal"] = -0.28;
  level.var_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["hardened"] = -0.27;
  level.var_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["veteran"] = -0.26;
  level.var_54D0["AjaxEngineHealthmod"]["easy"] = 0.8;
  level.var_54D0["AjaxEngineHealthmod"]["normal"] = 1;
  level.var_54D0["AjaxEngineHealthmod"]["hardened"] = 1.2;
  level.var_54D0["AjaxEngineHealthmod"]["veteran"] = 1.4;
  level.var_54D0["CapitalshipTurretHealthmod"]["easy"] = 0.8;
  level.var_54D0["CapitalshipTurretHealthmod"]["normal"] = 1;
  level.var_54D0["CapitalshipTurretHealthmod"]["hardened"] = 1.3;
  level.var_54D0["CapitalshipTurretHealthmod"]["veteran"] = 1.6;
  if(scripts\sp\utility::func_93A6()) {
    level.var_54D0["player_deathInvulnerableTime"]["hardened"] = 1;
    level.var_54D0["worthyDamageRatio"]["hardened"] = 1;
    level.var_54D0["invulTime_preShield"]["hardened"] = 0;
    level.var_54D0["invulTime_onShield"]["hardened"] = 0;
    level.var_54D0["invulTime_postShield"]["hardened"] = 0;
    level.var_54D0["playerDifficultyHealth"]["hardened"] = 190;
    level.var_54D0["playerJackalBaseAimAssist"]["hardened"] = 1.5;
    level.var_54D0["JackalHoverheatMaxEnemies"]["hardened"] = 2;
  }

  level.var_A9D0 = 0;
  level.playermeleedamagemultiplier_dvar = 0.8;
  setsaveddvar("player_meleeDamageMultiplier", level.playermeleedamagemultiplier_dvar);
  if(isDefined(level.var_4C53)) {
    [[level.var_4C53]]();
  }

  updategameskill();
  func_12E5A();
  setdvar("autodifficulty_original_setting", level.var_7683);
}

func_F52D(param_00, param_01) {
  level.var_54D0["regularRegenDelayScalar"] = param_00;
  level.var_54D0["longRegenTimeScalar"] = param_01;
}

func_9723() {
  self.gs.var_ECCC = [];
  var_00 = ["bottom", "left", "right"];
  var_01 = ["bloodsplat", "dirt"];
  foreach(var_03 in var_01) {
    foreach(var_05 in var_00) {
      self.gs.var_ECCC[var_03][var_05] = 0;
      self.gs.var_ECCC[var_03 + "_count"][var_05] = 0;
    }
  }
}

func_12E5A() {
  func_F725();
  func_F761();
  for(var_00 = 0; var_00 < level.players.size; var_00++) {
    level.players[var_00] func_F6C3();
  }
}

func_F6C3() {
  func_F355();
}

func_F725() {
  var_00 = ::func_7AAF;
  var_01 = func_7C6D(level.var_7683);
  anim.var_C86F = level.var_54D0["pain_test"][var_01];
  level.var_6A04 = level.var_54D0["explosivePlantTime"][var_01];
  anim.var_B750 = [[var_00]]("min_sniper_burst_delay_time", level.var_7683);
  anim.var_B461 = [[var_00]]("max_sniper_burst_delay_time", level.var_7683);
  setsaveddvar("ai_accuracyDistScale", [[var_00]]("accuracyDistScale", level.var_7683));
  func_F679();
  anim.var_3546 = level.var_54D0["c12_DismemberRecoveryTime"][var_01];
  anim.var_35EC = level.var_54D0["c12_RocketTellHoldTime"][var_01];
  anim.var_35C6 = level.var_54D0["c12_MinigunStruggleDamage"][var_01];
  anim.var_33BB = level.var_54D0["c6_TorsoDamageDismemberLimbChance"][var_01];
  scripts\sp\mgturret::func_F6C3();
}

func_F761() {
  if(!isDefined(level.var_A48E)) {
    level.var_A48E = spawnStruct();
  }

  if(scripts\sp\utility::func_93A6()) {
    var_00 = "veteran";
    level.var_A48E.var_A3FB = level.var_54D0["JackalIncomingMissileSpeedScale"]["hardened"];
  } else {
    var_00 = func_7C6D(level.var_7683);
    level.var_A48E.var_A3FB = level.var_54D0["JackalIncomingMissileSpeedScale"][var_00];
  }

  level.var_A48E.var_D3BA = level.var_54D0["playerJackalHealth"][var_00];
  level.var_A48E.var_D3BD = level.var_54D0["playerJackalInvulnerableTime"][var_00];
  level.var_A48E.var_D3B9 = level.var_54D0["playerJackalBaseAimAssist"][var_00];
  level.var_A48E.var_D3C0 = level.var_54D0["playerJackalRegularRegenDelay"][var_00];
  level.var_A48E.var_D3BF = level.var_54D0["playerJackalLongRegenDelay"][var_00];
  level.var_A48E.var_D3BB = level.var_54D0["playerJackalHealthRegenRate"][var_00];
  level.var_A48E.var_D3BC = level.var_54D0["playerJackalImpactDamageScale"][var_00];
  level.var_A48E.var_A3F5 = level.var_54D0["JackalHoverheatRampTime"][var_00];
  level.var_A48E.var_A3F4 = level.var_54D0["JackalHoverheatMaxEnemies"][var_00];
  level.var_A48E.var_A3AE = level.var_54D0["JackalAttackercountMaxScalar"][var_00];
  level.var_A48E.var_A3AD = level.var_54D0["JackalAttackercountMax"][var_00];
  level.var_A48E.var_A3A6 = level.var_54D0["JackalAccuracyPerSecond"][var_00];
  level.var_A48E.var_A40A = level.var_54D0["JackalLockingBoostEscapeScale"][var_00];
  level.var_A48E.var_A408 = level.var_54D0["JackalLockedBoostEscapeScale"][var_00];
  level.var_A48E.var_A409 = level.var_54D0["JackalLockedTurnEscapeScale"][var_00];
  level.var_A48E.var_A425 = level.var_54D0["JackalTargetAidMinTime"][var_00];
  level.var_A48E.var_A424 = level.var_54D0["JackalTargetAidMaxTime"][var_00];
  level.var_A48E.var_A40B = level.var_54D0["JackallockonEnemyShowdownAccuracy"][var_00];
  level.var_A48E.var_3A06 = level.var_54D0["CapShipMiniflakThresholdMin"][var_00];
  level.var_A48E.var_3A05 = level.var_54D0["CapShipMiniflakThresholdMax"][var_00];
  level.var_A48E.var_3A04 = level.var_54D0["CapShipMiniflakThresholdHyperAggressiveMin"][var_00];
  level.var_A48E.var_3A03 = level.var_54D0["CapShipMiniflakThresholdHyperAggressiveMax"][var_00];
  level.var_A48E.var_39F9 = level.var_54D0["CapitalshipTurretHealthmod"][var_00];
  level.var_A48E.var_1B13 = level.var_54D0["AjaxEngineHealthmod"][var_00];
  func_F762();
  level.var_A48E.var_D3BE = level.var_A48E.var_D3BA;
}

func_F762() {
  if(!isDefined(level.var_D127)) {
    return;
  }

  if(isDefined(level.var_A48E.var_D3BE) && isDefined(level.var_D127.var_B154)) {
    var_00 = level.var_A48E.var_D3BA / level.var_A48E.var_D3BE;
    level.var_D127.var_B154 = level.var_D127.var_B154 * var_00;
  }

  if(isDefined(level.var_D127.var_4C15) && isDefined(level.var_D127.var_4C15.var_105EE)) {
    setsaveddvar("spaceshipTargetLockAnglesScale", level.var_D127.var_4C15.var_105EE * level.var_A48E.var_D3B9);
    return;
  }

  setsaveddvar("spaceshipTargetLockAnglesScale", level.var_A48E.var_D3B9);
}

func_F679() {
  var_00 = scripts\sp\utility::func_7E72();
  level.player.gs.var_B63A = 1000;
  level.player.gs.var_B63C = 10;
  if(var_00 == "medium") {
    level.player.gs.var_B63A = 5000;
    level.player.gs.var_B63C = 4;
    return;
  }

  if(var_00 == "hard") {
    level.player.gs.var_B63A = 1000;
    level.player.gs.var_B63C = 1;
  }
}

updategameskill() {
  foreach(var_01 in level.players) {
    var_01.var_7683 = var_01 scripts\sp\utility::func_7B93();
  }

  level.var_7683 = level.player.var_7683;
  if(isDefined(level.var_72B4)) {
    level.var_7683 = level.var_72B4;
  }

  return level.var_7683;
}

func_7685() {
  var_00 = level.var_7683;
  for(;;) {
    if(!isDefined(var_00)) {
      wait(1);
      var_00 = level.var_7683;
      continue;
    }

    if(var_00 != updategameskill()) {
      var_00 = level.var_7683;
      func_12E5A();
    }

    wait(1);
  }
}

func_7C6D(param_00) {
  return level.var_54D3[param_00];
}

func_14F3() {
  return level.var_7683 == getdvarint("autodifficulty_original_setting");
}

func_20A1(param_00, param_01) {
  self.gs.invultime_preshield = [[param_00]]("invulTime_preShield", param_01);
  self.gs.invultime_onshield = [[param_00]]("invulTime_onShield", param_01);
  self.gs.invultime_postshield = [[param_00]]("invulTime_postShield", param_01);
  self.gs.playerhealth_regularregendelay = [[param_00]]("playerHealth_RegularRegenDelay", param_01) * level.var_54D0["regularRegenDelayScalar"];
  self.gs.worthydamageratio = [[param_00]]("worthyDamageRatio", param_01);
  self.var_33F = int([[param_00]]("threatbias", param_01));
  self.gs.longregentime = [[param_00]]("longRegenTime", param_01) * level.var_54D0["longRegenTimeScalar"];
  self.gs.healthoverlaycutoff = [[param_00]]("healthOverlayCutoff", param_01);
  self.gs.var_DE8D = [[param_00]]("health_regenRate", param_01);
  self.gs.var_CF81 = [[param_00]]("base_enemy_accuracy", param_01);
  func_12E0B();
  self.gs.var_D396 = int([[param_00]]("playerGrenadeBaseTime", param_01));
  self.gs.var_D397 = int([[param_00]]("playerGrenadeRangeTime", param_01));
  self.gs.var_D382 = int([[param_00]]("playerDoubleGrenadeTime", param_01));
  self.gs.var_B750 = [[param_00]]("min_sniper_burst_delay_time", param_01);
  self.gs.var_B461 = [[param_00]]("max_sniper_burst_delay_time", param_01);
  self.var_E7 = int([[param_00]]("player_deathInvulnerableTime", param_01));
  self.var_C6 = int([[param_00]]("player_criticalBulletDamageDist", param_01));
  self.var_DF = 100 / [[param_00]]("playerDifficultyHealth", param_01);
}

func_12E0B() {
  if(scripts\sp\utility::func_65DB("player_zero_attacker_accuracy")) {
    return;
  }

  self.precachenightvisioncodeassets = self.var_28A4;
  self.var_50 = self.gs.var_CF81;
}

func_20A2(param_00, param_01) {
  self.gs.var_B8D7 = [[param_00]]("missTimeConstant", param_01);
  self.gs.var_B8D9 = [[param_00]]("missTimeDistanceFactor", param_01);
  self.gs.double_grenades_allowed = [[param_00]]("double_grenades_allowed", param_01);
}

func_F355() {
  func_20A1(::func_7AB0, 1);
  func_20A2(::func_7AAE, 1);
}

func_7AAE(param_00, param_01) {
  return level.var_54D0[param_00][func_7C6D(self.var_7683)];
}

func_7AAD(param_00, param_01) {
  return level.var_54D0[param_00][func_7C6D(level.var_7683)];
}

func_786D(param_00, param_01) {
  var_02 = level.var_54D1[param_00];
  var_03 = 1;
  while(var_03 < var_02.size) {
    var_04 = var_02[var_03]["frac"];
    var_05 = var_02[var_03]["val"];
    if(param_01 <= var_04) {
      var_06 = var_02[var_03 - 1]["frac"];
      var_07 = var_02[var_03 - 1]["val"];
      var_08 = var_04 - var_06;
      var_09 = var_05 - var_07;
      var_0A = param_01 - var_06;
      var_0B = var_0A / var_08;
      return var_07 + var_0B * var_09;
    }

    var_09++;
  }

  return var_08[var_08.size - 1]["val"];
}

func_7E4A(param_00) {
  return level.var_54D0[param_00][func_7C6D(self.var_7683)];
}

_meth_80D5(param_00, param_01, param_02) {
  return level.var_54D0[param_00][level.var_54D3[param_01]] * 100 - getdvarint("autodifficulty_frac") + level.var_54D0[param_00][level.var_54D3[param_02]] * getdvarint("autodifficulty_frac") * 0.01;
}

func_7AB0(param_00, param_01) {
  return level.var_54D0[param_00][func_7C6D(self.var_7683)];
}

func_7AAF(param_00, param_01) {
  return level.var_54D0[param_00][func_7C6D(level.var_7683)];
}

func_1D5A() {
  return 0;
}

func_C868() {
  if(!func_C869()) {
    return 0;
  }

  return randomint(100) > 25;
}

func_C869() {
  if(!isalive(self.isnodeoccupied)) {
    return 0;
  }

  if(!isplayer(self.isnodeoccupied)) {
    return 0;
  }

  if(!isalive(level.var_C870) || level.var_C870.script != "pain") {
    level.var_C870 = self;
  }

  if(self == level.var_C870) {
    return 0;
  }

  if(self.var_E2 != "none" && weaponisboltaction(self.var_E2)) {
    return 0;
  }

  return 1;
}

func_F288() {
  if(scripts\anim\utility_common::isasniper() && isalive(self.isnodeoccupied)) {
    func_F84B();
    return;
  }

  if(isplayer(self.isnodeoccupied)) {
    func_E258();
    if(self.a.var_B8D6 > gettime()) {
      self.accuracy = 0;
      return;
    }
  }

  if(self.script == "move") {
    if(scripts\engine\utility::actor_is3d() && isDefined(self.var_1198.var_AA3D) && self.var_1198.var_AA3D.type == "Exposed 3D" || self.var_1198.var_AA3D.type == "Path 3D") {
      self.accuracy = self.var_2894;
    } else if(scripts\anim\utility::func_9D9C()) {
      self.accuracy = level.var_1385F * self.var_2894;
    } else {
      self.accuracy = level.var_E7D4 * self.var_2894;
    }

    return;
  }

  self.accuracy = self.var_2894;
  if(isDefined(self.var_9F15) && isDefined(self.var_DC58)) {
    self.accuracy = self.accuracy * self.var_DC58;
  }
}

func_F84B() {
  if(!isDefined(self.var_103BF)) {
    self.var_103BF = 0;
    self.var_103BA = 0;
  }

  if(!isDefined(self.var_103B2)) {
    self.var_103B2 = 1;
    var_00 = func_7C6D(level.var_7683);
    var_01 = level.var_54D0["sniperAccuDiffScale"][var_00];
    self.var_2894 = self.accuracy * var_01;
  }

  self.var_103BF++;
  var_02 = level.var_7683;
  if(isplayer(self.isnodeoccupied)) {
    var_02 = self.isnodeoccupied.var_7683;
  }

  if(func_10019()) {
    self.accuracy = 0;
    if(var_02 > 0 || self.var_103BF > 1) {
      self.var_A9BA = self.isnodeoccupied;
    }

    return;
  }

  if(self.accuracy <= 10) {
    self.accuracy = 1 + 1 * self.var_103BA * self.var_2894;
  }

  self.var_103BA++;
  if(var_02 < 1 && self.var_103BA == 1) {
    self.var_A9BA = undefined;
  }
}

func_10019() {
  if(isDefined(self.var_BEF8) && self.var_BEF8) {
    return 0;
  }

  if(self.team == "allies") {
    return 0;
  }

  if(isDefined(self.var_A9BA) && self.isnodeoccupied == self.var_A9BA) {
    return 0;
  }

  if(distancesquared(self.origin, self.isnodeoccupied.origin) > 250000) {
    return 0;
  }

  return 1;
}

func_FF07() {
  return 1 + randomfloat(4);
}

func_54C4() {
  self.a.var_B8D8 = 0;
}

func_E242() {
  resetmisstime_code();
}

func_13847() {
  var_00 = 0;
  waittillframeend;
  if(!isalive(self.isnodeoccupied)) {
    return var_00;
  }

  if(!isplayer(self.isnodeoccupied)) {
    return var_00;
  }

  if(self.isnodeoccupied scripts\sp\utility::func_65DB("player_is_invulnerable")) {
    var_00 = 0.3 + randomfloat(0.4);
  }

  return var_00;
}

func_D8EB(param_00, param_01, param_02, param_03) {
  param_03 = param_03 * 20;
  for(var_04 = 0; var_04 < param_03; var_04++) {
    wait(0.05);
  }
}

resetmisstime_code() {
  if(!self gettargetchargepos()) {
    return;
  }

  if(self.var_394 == "none") {
    return;
  }

  if(scripts\anim\utility_common::isasniper()) {
    return;
  }

  if(!scripts\anim\weaponlist::usingautomaticweapon() && !scripts\anim\weaponlist::usingsemiautoweapon()) {
    self.var_B8D6 = 0;
    return;
  }

  if(!isalive(self.isnodeoccupied)) {
    return;
  }

  if(!isplayer(self.isnodeoccupied)) {
    self.accuracy = self.var_2894;
    return;
  }

  var_00 = distance(self.isnodeoccupied.origin, self.origin);
  func_F79C(self.isnodeoccupied.gs.var_B8D7 + var_00 * self.isnodeoccupied.gs.var_B8D9);
}

func_E258() {
  self.a.var_B8D8 = gettime() + 3000;
}

func_F79C(param_00) {
  if(self.a.var_B8D8 > gettime()) {
    return;
  }

  if(param_00 > 0) {
    self.accuracy = 0;
  }

  param_00 = param_00 * 1000;
  self.a.var_B8D6 = gettime() + param_00;
  self.a.var_154C = 1;
}

func_CF4D() {
  self endon("death");
  self notify("playeraim");
  self endon("playeraim");
  for(;;) {
    var_00 = (0, 1, 0);
    if(self.a.var_B8D6 > gettime()) {
      var_00 = (1, 0, 0);
    }

    wait(0.05);
  }
}

func_ECC2(param_00, param_01, param_02) {
  var_03 = randomfloatrange(-15, 15);
  var_04 = randomfloatrange(-15, 15);
  self scaleovertime(0.1, int(2048 * param_01), int(1152 * param_01));
  self.y = 100 + var_04;
  self moveovertime(0.08);
  self.y = 0 + var_04;
  self.x = self.x + var_03;
  if(isDefined(param_02)) {
    return;
  }

  func_ECC1();
}

func_ECC3(param_00, param_01, param_02) {
  var_03 = 1;
  if(param_02) {
    var_03 = -1;
  }

  var_04 = randomfloatrange(-15, 15);
  var_05 = randomfloatrange(-15, 15);
  self scaleovertime(0.1, int(2048 * param_01), int(1152 * param_01));
  self.x = 1000 * var_03 + var_04;
  self moveovertime(0.1);
  self.x = 0 + var_04;
  self.y = self.y + var_05;
  func_ECC1();
}

func_ECC1() {
  self endon("death");
  var_00 = gettime();
  var_01 = 1;
  var_02 = 0.05;
  self.alpha = 0;
  self fadeovertime(var_02);
  self.alpha = 1;
  wait(var_02);
  scripts\sp\utility::func_135AF(var_00, 2);
  self fadeovertime(var_01);
  self.alpha = 0;
  scripts\engine\utility::waittill_notify_or_timeout("screenfx_force_delete", var_01);
  self destroy();
}

func_ECC0() {
  var_00 = 0.2;
  self.alpha = 0.7;
  self fadeovertime(var_00);
  self.alpha = 0;
  wait(var_00);
  self destroy();
}

forcehidegrenadehudwarning(param_00) {
  var_01 = "fullscreen_dirt_" + param_00;
  var_02 = undefined;
  if(param_00 == "bottom") {
    var_02 = "fullscreen_dirt_bottom_b";
  }

  thread func_56C6("dirt", param_00, var_01, var_02, randomfloatrange(0.55, 0.66));
}

func_2BC1(param_00) {
  var_01 = "fullscreen_bloodsplat_" + param_00;
  thread func_56C6("bloodsplat", param_00, var_01, undefined, randomfloatrange(0.45, 0.56));
}

func_56C6(param_00, param_01, param_02, param_03, param_04) {
  if(!isalive(self)) {
    return;
  }

  if(isDefined(self.var_9BA2)) {
    return;
  }

  var_05 = gettime();
  if(self.gs.var_ECCC[param_00][param_01] == var_05) {
    return;
  }

  if(self.gs.var_ECCC[param_00 + "_count"][param_01] == 1) {
    return;
  }

  self.gs.var_ECCC[param_00 + "_count"][param_01]++;
  self.gs.var_ECCC[param_00][param_01] = var_05;
  self endon("death");
  switch (param_01) {
    case "bottom":
      var_06 = int(640);
      var_07 = int(480);
      if(param_00 == "dirt") {
        var_08 = scripts\sp\hud_util::func_48B8(param_02, 1);
        var_08 thread func_ECC2(param_00, param_04, 1);
        var_08 func_ECC0();
      } else {
        var_08 = scripts\sp\hud_util::func_48B8(param_03, 0);
        var_08 func_ECC2(param_00, param_04);
      }

      if(isDefined(param_03)) {
        var_09 = scripts\sp\hud_util::func_48B8(param_03, 0);
        var_09 func_ECC2(param_00, param_04);
      }
      break;

    case "left":
      var_08 = scripts\sp\hud_util::func_48B8(param_02, 0, 1, 1);
      var_08 func_ECC3(param_00, param_04, 1);
      break;

    case "right":
      var_08 = scripts\sp\hud_util::func_48B8(param_02, 0, 1, 1);
      var_08 func_ECC3(param_00, param_04, 0);
      break;

    default:
      break;
  }

  self.gs.var_ECCC[param_00 + "_count"][param_01]--;
}

func_D3A9() {
  var_00 = ::scripts\sp\utility::func_7751;
  var_01 = ::scripts\sp\utility::func_2BC6;
  var_02 = [];
  var_02["MOD_GRENADE"] = var_00;
  var_02["MOD_GRENADE_SPLASH"] = var_00;
  var_02["MOD_PROJECTILE"] = var_00;
  var_02["MOD_PROJECTILE_SPLASH"] = var_00;
  var_02["MOD_EXPLOSIVE"] = var_00;
  var_02["MOD_PISTOL_BULLET"] = var_01;
  var_02["MOD_RIFLE_BULLET"] = var_01;
  var_02["MOD_EXPLOSIVE_BULLET"] = var_01;
  self.var_91F2 = 0;
  for(;;) {
    self waittill("damage", var_03, var_04, var_05, var_06, var_07);
    self.var_91F2 = 1;
    self.var_4D62 = var_06;
    self.damageattacker = var_04;
    var_08 = undefined;
    if(isDefined(self.var_B940)) {
      var_08 = self.var_B940[var_07];
    }

    if(!isDefined(var_08) && isDefined(var_02[var_07])) {
      var_08 = var_02[var_07];
    }

    if(isDefined(var_08)) {
      waittillframeend;
      [
        [var_08]
      ](var_06);
    }
  }
}

func_D0CE() {
  self.var_D0CE = 3;
}

func_D3A6() {
  level.var_1114E["take_cover"] = spawnStruct();
  level.var_1114E["take_cover"].text = &"GAME_GET_TO_COVER";
  level.var_1114E["get_back_up"] = spawnStruct();
  level.var_1114E["get_back_up"].text = &"GAME_LAST_STAND_GET_BACK_UP";
}

playerhealthregen() {
  thread func_8CBA();
  if(scripts\sp\utility::func_93A6()) {
    return;
  }

  var_00 = 1;
  var_01 = 0;
  thread func_D0CE();
  var_02 = 0;
  var_03 = 0;
  thread func_D369(self.maxhealth * 0.35);
  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  var_07 = 1;
  thread func_D3A9();
  self.var_2C42 = 0;
  for(;;) {
    wait(0.05);
    waittillframeend;
    if(self.health == self.maxhealth) {
      if(scripts\sp\utility::func_65DB("player_has_red_flashing_overlay")) {
        func_D259();
      }

      var_07 = 1;
      var_03 = 0;
      var_02 = 0;
      continue;
    }

    if(self.health <= 0) {
      return;
    }

    var_08 = var_02;
    var_09 = self.health / self.maxhealth;
    if(var_09 <= self.gs.healthoverlaycutoff && self.var_D0CE > 1) {
      var_02 = 1;
      if(!var_08) {
        var_05 = gettime();
        if(scripts\sp\utility::func_65DB("near_death_vision_enabled")) {
          thread func_2BDB(3.6, 2);
          thread scripts\sp\audio::func_F334();
          self getweaponfrommerit();
        }

        scripts\sp\utility::func_65E1("player_has_red_flashing_overlay");
        var_03 = 1;
      }
    }

    if(self.var_91F2) {
      var_05 = gettime();
      self.var_91F2 = 0;
    }

    if(self.health / self.maxhealth >= var_00) {
      if(gettime() - var_05 < self.gs.playerhealth_regularregendelay) {
        continue;
      }

      if(var_02) {
        var_06 = var_09;
        if(gettime() > var_05 + self.gs.longregentime) {
          var_06 = var_06 + self.gs.var_DE8D;
        }

        if(var_06 >= 1) {
          func_DE3C();
        }
      } else {
        var_06 = 1;
      }

      if(var_06 > 1) {
        var_06 = 1;
      }

      if(var_06 <= 0) {
        return;
      }

      self setnormalhealth(var_06);
      var_00 = self.health / self.maxhealth;
      continue;
    }

    var_00 = var_07;
    var_0A = self.gs.worthydamageratio;
    if(self.var_51 == 1) {
      var_0A = var_0A * 3;
    }

    var_0B = var_00 - var_09 >= var_0A;
    if(self.health <= 1) {
      self setnormalhealth(2 / self.maxhealth);
      var_0B = 1;
    }

    var_00 = self.health / self.maxhealth;
    self notify("hit_again");
    var_01 = 0;
    var_05 = gettime();
    thread func_2BDB(3, 0.8);
    if(!var_0B) {
      continue;
    }

    if(scripts\sp\utility::func_65DB("player_is_invulnerable")) {
      continue;
    }

    scripts\sp\utility::func_65E1("player_is_invulnerable");
    level notify("player_becoming_invulnerable");
    if(var_03) {
      var_04 = self.gs.invultime_onshield;
      var_03 = 0;
    } else if(var_02) {
      var_04 = self.gs.invultime_postshield;
    } else {
      var_04 = self.gs.invultime_preshield;
    }

    var_07 = self.health / self.maxhealth;
    thread func_D3B1(var_04);
  }
}

func_DE3C() {
  if(!func_11432()) {
    return;
  }

  if(isalive(self)) {
    var_00 = self _meth_8139("takeCoverWarnings");
    if(var_00 > 0) {
      var_00--;
      self _meth_8302("takeCoverWarnings", var_00);
    }
  }
}

func_D3B1(param_00) {
  if(isDefined(self.flashendtime) && self.flashendtime > gettime()) {
    param_00 = param_00 * func_7E4A("flashbangedInvulFactor");
  }

  if(param_00 > 0) {
    if(!isDefined(self.var_C088)) {
      self.var_50 = 0;
    }

    self.precachenightvisioncodeassets = 1;
    wait(param_00);
  }

  func_12E0B();
  scripts\sp\utility::func_65DD("player_is_invulnerable");
}

func_4FE9() {
  if(self.team == "allies") {
    self.var_5A0E = 0.6;
  }

  if(self gettargetchargepos()) {
    if(level.var_7683 >= 2) {
      self.var_5A0E = 0.8;
      return;
    }

    self.var_5A0E = 0.6;
  }
}

grenadeawareness() {
  if(isDefined(self.asmname) && self.asmname == "seeker") {
    self.objective_state_nomessage = 0;
    return;
  }

  if(self.unittype == "c12" || self.unittype == "c8") {
    self.objective_state_nomessage = 0;
    return;
  }

  if(self.team == "allies") {
    self.objective_state_nomessage = 0.9;
    self.objective_string_nomessage = 0.9;
    return;
  }

  if(self gettargetchargepos()) {
    if(level.var_7683 >= 2) {
      if(randomint(100) < 33) {
        self.objective_state_nomessage = 0.2;
      } else {
        self.objective_state_nomessage = 0.5;
      }
    } else if(randomint(100) < 33) {
      self.objective_state_nomessage = 0;
    } else {
      self.objective_state_nomessage = 0.2;
    }

    self.objective_string_nomessage = self.objective_state_nomessage;
  }
}

func_2BDB(param_00, param_01) {
  if(scripts\sp\utility::func_65DB("player_no_auto_blur")) {
    return;
  }

  self notify("blurview_stop");
  self endon("blurview_stop");
  self setblurforplayer(param_00, 0);
  wait(0.05);
  self setblurforplayer(0, param_01);
}

func_D369(param_00) {
  wait(2);
  for(;;) {
    wait(0.2);
    if(self.health <= 0 || getdvarint("cg_useplayerbreathsys")) {
      return;
    }

    var_01 = self.health / self.maxhealth;
    if(var_01 > self.gs.healthoverlaycutoff) {
      continue;
    }

    if(isDefined(self.var_550A) && self.var_550A) {
      continue;
    }

    if(isDefined(level.var_7684)) {
      [
        [level.var_7684]
      ]("breathing_hurt");
    } else {
      self playlocalsound("breathing_hurt");
    }

    var_02 = 0.1;
    if(isDefined(level.player.gs.var_4C82)) {
      var_02 = level.player.gs.var_4C82;
    }

    wait(var_02 + randomfloat(0.8));
  }
}

func_8CBA() {
  self endon("noHealthOverlay");
  var_00 = newclienthudelem(self);
  self.var_8CAE = var_00;
  var_00.x = 0;
  var_00.y = 0;
  var_01 = "vfx_ui_player_pain_overlay";
  var_00 setshader(var_01, 640, 480);
  var_00.ispointonnavmesh3d = 1;
  var_00.alignx = "left";
  var_00.aligny = "top";
  var_00.sort = 1;
  var_00.foreground = 0;
  var_00.horzalign = "fullscreen";
  var_00.vertalign = "fullscreen";
  var_00.alpha = 0;
  var_00.isexplosivedamagemod = 1;
  thread func_8CBB(var_00);
  childthread func_11431(var_00);
  var_02 = 0;
  var_03 = 0.05;
  var_04 = 0.3;
  while(isalive(self)) {
    wait(var_03);
    if(!isalive(self)) {
      break;
    }

    if(scripts\sp\utility::func_93A6()) {
      if(scripts\sp\specialist_MAYBE::func_2C97()) {
        var_02 = 0;
      } else {
        var_04 = 0.1;
        var_05 = 1 - self.health / level.player.maxhealth;
        var_05 = var_05 * 1.5;
        var_06 = var_05 - var_00.alpha;
        var_07 = var_00.alpha + var_06 * var_04;
        var_02 = clamp(var_07, 0, 1);
      }
    } else if(level.player scripts\sp\utility::func_65DB("player_has_red_flashing_overlay")) {
      var_02 = 0;
      level.player scripts\sp\utility::func_65E8("player_has_red_flashing_overlay");
    } else {
      var_05 = 1 - self.health / level.player.maxhealth;
      var_08 = var_05 * var_05 * 1.2;
      var_08 = clamp(var_08, 0, 1);
      if(var_02 > var_08) {
        var_02 = var_02 - var_04 * var_03;
      }

      if(var_02 < var_08) {
        var_02 = var_08;
      }
    }

    if(isDefined(level.player.var_111B8) && level.player.var_111B8) {
      continue;
    }

    var_00.alpha = var_02;
  }
}

func_11431(param_00) {
  self endon("death");
  while(isalive(self)) {
    scripts\sp\utility::func_65E3("player_has_red_flashing_overlay");
    func_11430(param_00);
  }
}

func_16F1(param_00) {
  if(level.console) {
    self.fontscale = 2;
  } else {
    self.fontscale = 1.6;
  }

  self.x = 0;
  self.y = -36;
  self.alignx = "center";
  self.aligny = "bottom";
  self.horzalign = "center";
  self.vertalign = "middle";
  if(!isDefined(self.var_272E)) {
    return;
  }

  self.var_272E.x = 0;
  self.var_272E.y = -40;
  self.var_272E.alignx = "center";
  self.var_272E.aligny = "middle";
  self.var_272E.horzalign = "center";
  self.var_272E.vertalign = "middle";
  if(level.console) {
    self.var_272E setshader("popmenu_bg", 650, 52);
  } else {
    self.var_272E setshader("popmenu_bg", 650, 42);
  }

  self.var_272E.alpha = 0.5;
}

func_1383C() {
  self endon("hit_again");
  self endon("player_downed");
  self waittill("damage");
}

func_52BD(param_00) {
  param_00 endon("being_destroyed");
  func_1383C();
  var_01 = !isalive(self);
  param_00 thread func_52BC(var_01);
}

func_52BE() {
  self endon("being_destroyed");
  scripts\engine\utility::flag_wait("missionfailed");
  thread func_52BC(1);
}

func_52BC(param_00) {
  self notify("being_destroyed");
  self.var_2A88 = 1;
  if(param_00) {
    self fadeovertime(0.5);
    self.alpha = 0;
    wait(0.5);
  }

  self notify("death");
  self destroy();
}

func_B4DA(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(isDefined(param_00.var_2A88)) {
    return 0;
  }

  return 1;
}

func_11432() {
  if(isDefined(level.var_470F)) {
    return 0;
  }

  if(isDefined(self.melee)) {
    return 0;
  }

  if(isDefined(self.vehicle)) {
    return 0;
  }

  return 1;
}

func_8C1D() {
  var_00 = self getweaponslist("offhand");
  foreach(var_02 in var_00) {
    if(issubstr(var_02, "offhandshield")) {
      return 1;
    }
  }

  return 0;
}

func_E34F() {
  return level.player _meth_84D0() > level.player _meth_84CF() * 0.1;
}

func_FF8B() {
  if(scripts\sp\utility::func_93A6()) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(self islinked()) {
    return 0;
  }

  if(self.ignoreme) {
    return 0;
  }

  if(level.var_B8D0) {
    return 0;
  }

  if(!func_11432()) {
    return 0;
  }

  if(self.var_7683 > 1 && !func_B327()) {
    return 0;
  }

  if(scripts\sp\utility::func_65DB("player_retract_shield_active")) {
    return 0;
  }

  var_00 = self _meth_8139("takeCoverWarnings");
  if(var_00 <= 3) {
    return 0;
  }

  return 1;
}

func_FF89() {
  if(scripts\sp\utility::func_93A6()) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(self islinked()) {
    return 0;
  }

  if(self.ignoreme) {
    return 0;
  }

  if(level.var_B8D0) {
    return 0;
  }

  if(!func_11432()) {
    return 0;
  }

  if(self.var_7683 > 1 && !func_B327()) {
    return 0;
  }

  var_00 = self _meth_8139("takeCoverWarnings");
  if(var_00 <= 3) {
    return 0;
  }

  return 1;
}

func_B327() {
  if(!isDefined(level.var_5FB0)) {
    return 1;
  }

  if(isDefined(level.var_5FB0[level.script])) {
    return level.var_5FB0[level.script];
  }

  return 0;
}

maps_with_jackal_arenas() {
  return ["phspace", "moonjackal", "sa_empambush", "sa_wounded", "sa_assassination", "titanjackal", "ja_spacestation", "ja_titan", "ja_wreckage", "ja_asteroid", "ja_mining", "heistspace"];
}

jackal_arena_is_early_in_the_game() {
  if(map_has_jackal_arena() && get_num_jackal_arenas_completed() <= 4) {
    return 1;
  }

  return 0;
}

get_num_jackal_arenas_completed() {
  var_00 = 0;
  foreach(var_02 in maps_with_jackal_arenas()) {
    var_03 = level.player _meth_84C6("missionStateData", var_02);
    if(isDefined(var_03) && var_03 == "complete") {
      var_00++;
    }
  }

  return var_00;
}

map_has_jackal_arena() {
  if(scripts\engine\utility::array_contains(maps_with_jackal_arenas(), level.script)) {
    return 1;
  }

  return 0;
}

func_11430(param_00) {
  self endon("hit_again");
  self endon("damage");
  self endon("death");
  childthread func_DE16(param_00);
  if(level.player scripts\sp\utility::func_7B93() < 2) {
    var_01 = func_7D51();
    var_02 = [[var_01]]();
    var_03 = gettime() + self.gs.longregentime;
    func_4766(1, var_02);
    while(gettime() < var_03 && isalive(self) && scripts\sp\utility::func_65DB("player_has_red_flashing_overlay") && !scripts\sp\utility::func_65DB("player_retract_shield_active")) {
      func_4766(0.9, var_02);
    }

    if(isalive(self)) {
      func_4766(0.65, var_02);
    }

    func_4766(0, var_02);
  }

  scripts\sp\utility::func_65E3("redflashoverlay_complete");
  self notify("take_cover_done");
  self notify("hit_again");
}

func_4766(param_00, param_01) {
  if(getomnvar("ui_gettocover_state") == 0 && param_00 == 0 || param_00 == 5) {
    return;
  }

  if(param_00 == 1) {
    if(param_01) {
      setomnvar("ui_gettocover_state", 1);
    }

    wait(0.7);
    return;
  }

  if(param_00 == 0.9) {
    if(param_01) {
      setomnvar("ui_gettocover_state", 2);
    }

    wait(0.7);
    return;
  }

  if(param_00 == 6.5) {
    if(param_01) {
      setomnvar("ui_gettocover_state", 3);
    }

    wait(0.65);
    return;
  }

  if(param_00 == 0) {
    if(param_01 || getomnvar("ui_gettocover_state") > 0 && getomnvar("ui_gettocover_state") < 4) {
      setomnvar("ui_gettocover_state", 4);
    }

    wait(0.5);
    return;
  }

  if(param_00 == 5) {
    if(param_01 || getomnvar("ui_gettocover_state") > 0 && getomnvar("ui_gettocover_state") < 5) {
      setomnvar("ui_gettocover_state", 5);
    }

    wait(0.5);
    return;
  }
}

func_DE16(param_00) {
  scripts\sp\utility::func_65DD("redflashoverlay_complete");
  var_01 = gettime() + level.player.gs.longregentime;
  func_DE15(param_00, 1, 1);
  while(gettime() < var_01 && isalive(level.player)) {
    func_DE15(param_00, 0.9, 1);
  }

  if(isalive(level.player)) {
    func_DE15(param_00, 0.65, 0.8);
  }

  func_DE15(param_00, 0, 0.6);
  param_00 fadeovertime(0.5);
  param_00.alpha = 0;
  wait(0.5);
  scripts\sp\utility::func_65E3("redflashoverlay_complete");
}

func_DE15(param_00, param_01, param_02) {
  var_03 = 0.8;
  var_04 = 0.5;
  var_05 = var_03 * 0.1;
  var_06 = var_03 * 0.1 + param_01 * 0.2;
  var_07 = var_03 * 0.1 + param_01 * 0.1;
  var_08 = var_03 * 0.3;
  var_09 = var_03 - var_05 - var_06 - var_07 - var_08;
  if(var_09 < 0) {
    var_09 = 0;
  }

  var_0A = 0.8 + param_01 * 0.1;
  var_0B = 0.5 + param_01 * 0.3;
  param_00 fadeovertime(var_05);
  param_00.alpha = param_02 * 1;
  wait(var_05 + var_06);
  param_00 fadeovertime(var_07);
  param_00.alpha = param_02 * var_0A;
  wait(var_07);
  param_00 fadeovertime(var_08);
  param_00.alpha = param_02 * var_0B;
  wait(var_08);
  wait(var_09);
}

func_7D51() {
  var_00 = undefined;
  if(func_8C1D() && func_E34F()) {
    var_00 = ::func_FF8B;
    setomnvar("ui_gettocover_text", "game_use_retract_shield");
  } else {
    var_00 = ::func_FF89;
    setomnvar("ui_gettocover_text", "game_get_to_cover");
  }

  return var_00;
}

func_7A59() {
  if(scripts\sp\utility::func_D15B("hull")) {
    return level.var_A48E.var_D3BA * 1.5;
  }

  return level.var_A48E.var_D3BA;
}

func_D259() {
  scripts\sp\utility::func_65DD("player_has_red_flashing_overlay");
  if(scripts\sp\utility::func_65DB("near_death_vision_enabled")) {
    self _meth_8222();
    thread scripts\sp\audio::func_E2BB();
  }

  self notify("take_cover_done");
}

func_8CBB(param_00) {
  self waittill("noHealthOverlay");
  param_00 destroy();
}

func_E26C() {
  waittillframeend;
  func_F848(1);
}

func_9772() {
  var_00 = isDefined(level.var_9F0B) && level.var_9F0B;
  if(self _meth_8139("takeCoverWarnings") == -1 || var_00) {
    self _meth_8302("takeCoverWarnings", 9);
  }
}

func_93F7() {
  self notify("new_cover_on_death_thread");
  self endon("new_cover_on_death_thread");
  self waittill("death");
  if(!scripts\sp\utility::func_65DB("player_has_red_flashing_overlay")) {
    return;
  }

  if(!func_11432()) {
    return;
  }

  var_00 = self _meth_8139("takeCoverWarnings");
  if(var_00 < 10) {
    self _meth_8302("takeCoverWarnings", var_00 + 1);
  }
}

func_2624() {
  var_00 = self.origin;
  wait(5);
  if(func_2693(var_00)) {
    level.var_2641[level.var_2641.size] = var_00;
  }
}

func_2693(param_00) {
  return distancesquared(self.origin, param_00) < 19600;
}

func_2623() {
  level.var_2641 = [];
  level.player.var_BCB6 = 1;
  wait(1);
  for(;;) {
    level.player thread func_2624();
    level.player.var_BCB6 = 1;
    var_00 = [];
    var_01 = level.var_2641.size - 5;
    if(var_01 < 0) {
      var_01 = 0;
    }

    for(var_02 = var_01; var_02 < level.var_2641.size; var_02++) {
      if(!level.player func_2693(level.var_2641[var_02])) {
        continue;
      }

      var_00[var_00.size] = level.var_2641[var_02];
      level.player.var_BCB6 = 0;
    }

    level.var_2641 = var_00;
    wait(1);
  }
}

func_2625() {
  level.player waittill("death");
  var_00 = getdvarint("autodifficulty_playerDeathTimer");
  var_00 = var_00 - 60;
  setdvar("autodifficulty_playerDeathTimer", var_00);
}

func_2626() {
  var_00 = gettime();
  for(;;) {
    if(level.player attackbuttonpressed()) {
      var_00 = gettime();
    }

    level.var_118E5 = gettime() - var_00;
    wait(0.05);
  }
}

func_9138(param_00, param_01) {
  func_9137(param_00, param_01 * 100, 1);
}

func_9136(param_00, param_01) {
  func_9137(param_00, param_01, 0);
}

func_913D() {
  level.var_9184 = 0;
  if(isDefined(level.var_9177)) {
    for(var_00 = 0; var_00 < level.var_9177.size; var_00++) {
      level.var_9177[var_00] destroy();
    }
  }

  level.var_9177 = [];
}

func_9139(param_00) {
  if(!isDefined(level.var_9183)) {
    level.var_9183 = [];
  }

  if(!isDefined(level.var_9183[param_00])) {
    var_01 = newhudelem();
    var_01.x = level.var_4F47;
    var_01.y = level.var_4F45 + level.var_9184 * 15;
    var_01.foreground = 1;
    var_01.sort = 100;
    var_01.alpha = 1;
    var_01.alignx = "left";
    var_01.horzalign = "left";
    var_01.fontscale = 1;
    var_01 settext(param_00);
    level.var_9183[param_00] = 1;
  }
}

func_9137(param_00, param_01, param_02) {
  func_9139(param_00);
  param_01 = int(param_01);
  var_03 = 0;
  if(param_01 < 0) {
    var_03 = 1;
    param_01 = param_01 * -1;
  }

  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  while(param_01 >= 10000) {
    param_01 = param_01 - 10000;
  }

  while(param_01 >= 1000) {
    param_01 = param_01 - 1000;
    var_04++;
  }

  while(param_01 >= 100) {
    param_01 = param_01 - 100;
    var_05++;
  }

  while(param_01 >= 10) {
    param_01 = param_01 - 10;
    var_06++;
  }

  while(param_01 >= 1) {
    param_01 = param_01 - 1;
    var_07++;
  }

  var_08 = 0;
  var_09 = 10;
  if(var_04 > 0) {
    func_913A(var_04, var_08);
    var_08 = var_08 + var_09;
    func_913A(var_05, var_08);
    var_08 = var_08 + var_09;
    func_913A(var_06, var_08);
    var_08 = var_08 + var_09;
    func_913A(var_07, var_08);
    var_08 = var_08 + var_09;
  } else if(var_05 > 0 || param_02) {
    func_913A(var_05, var_08);
    var_08 = var_08 + var_09;
    func_913A(var_06, var_08);
    var_08 = var_08 + var_09;
    func_913A(var_07, var_08);
    var_08 = var_08 + var_09;
  } else if(var_06 > 0) {
    func_913A(var_06, var_08);
    var_08 = var_08 + var_09;
    func_913A(var_07, var_08);
    var_08 = var_08 + var_09;
  } else {
    func_913A(var_07, var_08);
    var_08 = var_08 + var_09;
  }

  if(param_02) {
    var_0A = newhudelem();
    var_0A.x = 204.5;
    var_0A.y = level.var_4F45 + level.var_9184 * 15;
    var_0A.foreground = 1;
    var_0A.sort = 100;
    var_0A.alpha = 1;
    var_0A.alignx = "left";
    var_0A.horzalign = "left";
    var_0A.fontscale = 1;
    var_0A settext(".");
    level.var_9177[level.var_9177.size] = var_0A;
  }

  if(var_03) {
    var_0B = newhudelem();
    var_0B.x = 195.5;
    var_0B.y = level.var_4F45 + level.var_9184 * 15;
    var_0B.foreground = 1;
    var_0B.sort = 100;
    var_0B.alpha = 1;
    var_0B.alignx = "left";
    var_0B.horzalign = "left";
    var_0B.fontscale = 1;
    var_0B settext(" - ");
    level.var_9177[level.var_9184] = var_0B;
  }

  level.var_9184++;
}

func_913C(param_00, param_01) {
  func_9139(param_00);
  func_913B(param_01, 0);
  level.var_9184++;
}

func_913A(param_00, param_01) {
  var_02 = newhudelem();
  var_02.x = 200 + param_01 * 0.65;
  var_02.y = level.var_4F45 + level.var_9184 * 15;
  var_02.foreground = 1;
  var_02.sort = 100;
  var_02.alpha = 1;
  var_02.alignx = "left";
  var_02.horzalign = "left";
  var_02.fontscale = 1;
  var_02 settext(param_00 + "");
  level.var_9177[level.var_9177.size] = var_02;
}

func_913B(param_00, param_01) {
  var_02 = newhudelem();
  var_02.x = 200 + param_01 * 0.65;
  var_02.y = level.var_4F45 + level.var_9184 * 15;
  var_02.foreground = 1;
  var_02.sort = 100;
  var_02.alpha = 1;
  var_02.alignx = "left";
  var_02.horzalign = "left";
  var_02.fontscale = 1;
  var_02 settext(param_00);
  level.var_9177[level.var_9177.size] = var_02;
}

func_14ED() {
  scripts\engine\utility::add_func_ref_MAYBE("sp_stat_tracking_func", ::func_262A);
  setdvar("aa_player_kills", "0");
  setdvar("aa_enemy_deaths", "0");
  setdvar("aa_enemy_damage_taken", "0");
  setdvar("aa_player_damage_taken", "0");
  setdvar("aa_player_damage_dealt", "0");
  setdvar("aa_ads_damage_dealt", "0");
  setdvar("aa_time_tracking", "0");
  setdvar("aa_deaths", "0");
  setdvar("player_cheated", 0);
  level.var_262B = [];
  thread func_14F4();
  thread func_14F1();
  thread func_14EF();
  scripts\engine\utility::flag_set("auto_adjust_initialized");
  scripts\engine\utility::flag_init("aa_main_" + level.script);
  scripts\engine\utility::flag_set("aa_main_" + level.script);
}

func_4423(param_00) {
  var_01 = getkeybinding(param_00);
  if(var_01["count"] <= 0) {
    return 0;
  }

  for(var_02 = 1; var_02 < var_01["count"] + 1; var_02++) {
    if(self buttonpressed(var_01["key" + var_02])) {
      return 1;
    }
  }

  return 0;
}

func_14F4() {
  waittillframeend;
  wait(0.2);
}

func_14EF() {
  level.player endon("death");
  level.var_CF4B = 0;
  for(;;) {
    if(level.player scripts\sp\utility::func_9D27()) {
      level.var_CF4B = gettime();
      while(level.player scripts\sp\utility::func_9D27()) {
        wait(0.05);
      }

      continue;
    }

    wait(0.05);
  }
}

func_14F1() {
  for(;;) {
    level.player waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06);
    func_14DB("aa_player_damage_taken", var_00);
    if(!isalive(level.player)) {
      func_14DB("aa_deaths", 1);
      return;
    }
  }
}

func_262A(param_00) {
  if(!isDefined(level.var_2629)) {
    level.var_2629 = [];
  }

  scripts\engine\utility::flag_wait("auto_adjust_initialized");
  level.var_262B[param_00] = [];
  level.var_2629[param_00] = 0;
  scripts\engine\utility::flag_wait(param_00);
  if(getdvar("aa_zone" + param_00) == "") {
    setdvar("aa_zone" + param_00, "on");
    level.var_2629[param_00] = 1;
    func_14F5();
    setdvar("start_time" + param_00, getdvar("aa_time_tracking"));
    setdvar("starting_player_kills" + param_00, getdvar("aa_player_kills"));
    setdvar("starting_deaths" + param_00, getdvar("aa_deaths"));
    setdvar("starting_ads_damage_dealt" + param_00, getdvar("aa_ads_damage_dealt"));
    setdvar("starting_player_damage_dealt" + param_00, getdvar("aa_player_damage_dealt"));
    setdvar("starting_player_damage_taken" + param_00, getdvar("aa_player_damage_taken"));
    setdvar("starting_enemy_damage_taken" + param_00, getdvar("aa_enemy_damage_taken"));
    setdvar("starting_enemy_deaths" + param_00, getdvar("aa_enemy_deaths"));
  } else if(getdvar("aa_zone" + param_00) == "done") {
    return;
  }

  scripts\engine\utility::flag_waitopen(param_00);
  func_262C(param_00);
}

func_262C(param_00) {
  setdvar("aa_zone" + param_00, "done");
  var_01 = getdvarfloat("start_time" + param_00);
  var_02 = getdvarint("starting_player_kills" + param_00);
  var_03 = getdvarint("aa_enemy_deaths" + param_00);
  var_04 = getdvarint("aa_enemy_damage_taken" + param_00);
  var_05 = getdvarint("aa_player_damage_taken" + param_00);
  var_06 = getdvarint("aa_player_damage_dealt" + param_00);
  var_07 = getdvarint("aa_ads_damage_dealt" + param_00);
  var_08 = getdvarint("aa_deaths" + param_00);
  level.var_2629[param_00] = 0;
  func_14F5();
  var_09 = getdvarfloat("aa_time_tracking") - var_01;
  var_0A = getdvarint("aa_player_kills") - var_02;
  var_0B = getdvarint("aa_enemy_deaths") - var_03;
  var_0C = 0;
  if(var_0B > 0) {
    var_0C = var_0A / var_0B;
    var_0C = var_0C * 100;
    var_0C = int(var_0C);
  }

  var_0D = getdvarint("aa_enemy_damage_taken") - var_04;
  var_0E = getdvarint("aa_player_damage_dealt") - var_06;
  var_0F = 0;
  var_10 = 0;
  if(var_0D > 0 && var_09 > 0) {
    var_0F = var_0E / var_0D;
    var_0F = var_0F * 100;
    var_0F = int(var_0F);
    var_10 = var_0E / var_09;
    var_10 = var_10 * 60;
    var_10 = int(var_10);
  }

  var_11 = getdvarint("aa_ads_damage_dealt") - var_07;
  var_12 = 0;
  if(var_0E > 0) {
    var_12 = var_11 / var_0E;
    var_12 = var_12 * 100;
    var_12 = int(var_12);
  }

  var_13 = getdvarint("aa_player_damage_taken") - var_05;
  var_14 = 0;
  if(var_09 > 0) {
    var_14 = var_13 / var_09;
  }

  var_15 = var_14 * 60;
  var_15 = int(var_15);
  var_16 = getdvarint("aa_deaths") - var_08;
  var_17 = [];
  var_17["player_damage_taken_per_minute"] = var_15;
  var_17["player_damage_dealt_per_minute"] = var_10;
  var_17["minutes"] = var_09 / 60;
  var_17["deaths"] = var_16;
  var_17["gameskill"] = level.var_7683;
  level.var_262B[param_00] = var_17;
  var_18 = "Completed AA sequence: ";
  var_18 = var_18 + level.script + "\" + param_00;
  var_19 = getarraykeys(var_17);
  for(var_1A = 0; var_1A < var_19.size; var_1A++) {
    var_18 = var_18 + ", " + var_19[var_1A] + ": " + var_17[var_19[var_1A]];
  }

  logstring(var_18);
}

func_14F2(param_00, param_01) {
  logstring(param_00 + ": " + param_01[param_00]);
}

func_14F5() {}

func_14DB(param_00, param_01) {
  var_02 = getdvarint(param_00);
  setdvar(param_00, var_02 + param_01);
}

func_14DC(param_00, param_01) {
  var_02 = getdvarfloat(param_00);
  setdvar(param_00, var_02 + param_01);
}

func_E44D(param_00) {
  return 0;
}

func_CF80(param_00) {
  if([[level.var_4C6B]](param_00)) {
    return 1;
  }

  if(isplayer(param_00)) {
    return 1;
  }

  if(!isDefined(param_00.var_3A49)) {
    return 0;
  }

  return param_00 func_D021();
}

func_D021() {
  return self.var_CFED * 1.75 > self.var_C078;
}

func_61BA(param_00, param_01, param_02) {}

func_2628(param_00, param_01, param_02, param_03) {
  func_14DB("aa_enemy_deaths", 1);
  if(!isDefined(param_01)) {
    return;
  }

  if(!func_CF80(param_01)) {
    return;
  }

  [[level.vehicle_canturrettargetpoint]](param_02, self.var_DD, param_03);
  func_14DB("aa_player_kills", 1);
}

func_2627(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isalive(self) || self.var_EB) {
    func_2628(param_00, param_01, param_04, param_03);
    return;
  }

  if(!func_CF80(param_01)) {
    return;
  }

  func_14F0(param_00, param_04, param_03);
}

func_14F0(param_00, param_01, param_02) {
  func_14DB("aa_player_damage_dealt", param_00);
  if(!level.player scripts\sp\utility::func_9D27()) {
    [[level._meth_83D3]](param_01, self.var_DD, param_02);
    return 0;
  }

  if(!func_3234(param_01)) {
    [[level._meth_83D3]](param_01, self.var_DD, param_02);
    return 0;
  }

  [[level._meth_83D4]](param_01, self.var_DD, param_02);
  func_14DB("aa_ads_damage_dealt", param_00);
  return 1;
}

func_3234(param_00) {
  if(param_00 == "MOD_PISTOL_BULLET") {
    return 1;
  }

  return param_00 == "MOD_RIFLE_BULLET";
}

func_16D9(param_00, param_01, param_02) {
  if(!isDefined(level.var_54D1[param_00])) {
    level.var_54D1[param_00] = [];
  }

  var_03 = [];
  var_03["frac"] = param_01;
  var_03["val"] = param_02;
  level.var_54D1[param_00][level.var_54D1[param_00].size] = var_03;
}

func_F385() {
  level.var_5FB0 = [];
  level.var_5FB0["europa"] = 1;
  level.var_5FB0["phparade"] = 1;
  level.var_5FB0["phstreets"] = 1;
  level.var_5FB0["phspace"] = 1;
  level.var_5FB0["shipcrib_moon"] = 1;
  level.var_5FB0["moon_port"] = 1;
  level.var_5FB0["moonjackal"] = 1;
  level.var_5FB0["sa_moon"] = 1;
}

func_E080() {
  level notify("screenfx_force_delete");
  level.player notify("noHealthOverlay");
  level.player.var_550A = 1;
  level.player func_D259();
  level.player.var_550A = 0;
}

func_13062() {
  return level.var_13062;
}

func_1305F() {
  return level.var_1305F;
}

func_1305E() {
  return level.var_1305E;
}

func_13069() {
  return level.var_13069;
}

func_12855(param_00) {
  level.player endon("weapon_change");
  wait(10);
  if(scripts\engine\utility::flag("disable_weapon_help")) {
    return;
  }

  if(!level.player _meth_843C()) {
    return;
  }

  if(level.player islinked()) {
    return;
  }

  if(scripts\engine\utility::player_is_in_jackal()) {
    return;
  }

  if(scripts\sp\utility::func_65DF("_stealth_enabled") && scripts\sp\utility::func_65DB("_stealth_enabled")) {
    return;
  }

  if(isDefined(level.var_4B80) && level.var_4B80) {
    return;
  }

  if(isDefined(self.melee)) {
    return;
  }

  if(level.script == "phstreets" || level.script == "europa") {
    return;
  }

  if(isDefined(level.player.var_9E1C) && level.player.var_9E1C) {
    return;
  }

  scripts\sp\utility::func_56BE(param_00, 6);
}

func_13C1A() {
  level endon("stop_weapon_help");
  scripts\engine\utility::flag_init("disable_weapon_help");
  scripts\sp\utility::func_16EB("alt_m8", &"WEAPON_HELP_M8_AR_DPAD", ::func_13062);
  scripts\sp\utility::func_16EB("alt_fmg", &"WEAPON_HELP_FMG_AKIMBO_DPAD", ::func_1305F);
  scripts\sp\utility::func_16EB("alt_erad", &"WEAPON_HELP_ERAD_SHOTGUN_DPAD", ::func_1305E);
  scripts\sp\utility::func_16EB("alt_ripper", &"WEAPON_HELP_RIPPER_SMG_DPAD", ::func_13069);
  wait(30);
  var_00 = scripts\sp\endmission::func_7F6B(level.script);
  if(!isDefined(var_00)) {
    return;
  }

  if(scripts\sp\endmission::getitemslot(var_00)) {
    return;
  } else if(scripts\sp\endmission::getitemdroporiginandangles(var_00)) {
    return;
  } else if(scripts\sp\utility::func_93A6()) {
    return;
  } else if(level.var_7683 >= 2 && !func_B327()) {
    return;
  }

  level.var_13062 = 1;
  level.var_1305F = 1;
  level.var_1305E = 1;
  level.var_13069 = 1;
  var_01 = level.player _meth_84C6("hintAltM8");
  var_02 = level.player _meth_84C6("hintAltFMG");
  var_03 = level.player _meth_84C6("hintAltERAD");
  var_04 = level.player _meth_84C6("hintAltRipper");
  if(isDefined(var_01)) {
    level.var_13062 = var_01;
  }

  if(isDefined(var_02)) {
    level.var_1305F = var_02;
  }

  if(isDefined(var_03)) {
    level.var_1305E = var_03;
  }

  if(isDefined(var_04)) {
    level.var_13069 = var_04;
  }

  var_05 = 0;
  if(level.var_13062) {
    var_05++;
  }

  if(level.var_1305F) {
    var_05++;
  }

  if(level.var_1305E) {
    var_05++;
  }

  if(level.var_13069) {
    var_05++;
  }

  wait(300);
  for(;;) {
    if(var_05 >= 3) {
      return;
    }

    level.player waittill("weapon_change", var_06);
    var_07 = level.player _meth_8519(var_06, 1);
    var_08 = getweaponbasename(var_06);
    var_09 = "";
    switch (var_08) {
      case "iw7_m8":
        if(var_07) {
          if(!level.var_13062) {
            level.player _meth_84C7("hintAltM8", 1);
            level.var_13062 = 1;
            var_05++;
          }
        } else {
          var_09 = "alt_m8";
        }
        break;

      case "iw7_fmg":
        if(var_07) {
          if(!level.var_1305F) {
            level.player _meth_84C7("hintAltFMG", 1);
            level.var_1305F = 1;
            var_05++;
          }
        } else {
          var_09 = "alt_fmg";
        }
        break;

      case "iw7_erad":
        if(var_07) {
          if(!level.var_1305E) {
            level.player _meth_84C7("hintAltERAD", 1);
            level.var_1305E = 1;
            var_05++;
          }
        } else {
          var_09 = "alt_erad";
        }
        break;

      case "iw7_ripper":
        if(var_07) {
          if(!level.var_13069) {
            level.player _meth_84C7("hintAltRipper", 1);
            level.var_13069 = 1;
            var_05++;
          }
        } else {
          var_09 = "alt_ripper";
        }
        break;

      default:
        break;
    }

    if(var_09 != "") {
      thread func_12855(var_09);
    }
  }
}