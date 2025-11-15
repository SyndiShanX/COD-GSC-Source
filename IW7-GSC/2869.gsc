/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2869.gsc
***************************************/

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
  precachestring( & "GAME_GET_TO_COVER");
  precachestring( & "GAME_USE_RETRACT_SHIELD");
  precachestring( & "GAME_LAST_STAND_GET_BACK_UP");
  func_0B5F::func_965A();
  func_F385();
  thread func_14ED();
  func_F848();
  level thread func_13C1A();
}

func_F848(var_00) {
  if(!isDefined(level.script))
    level.script = tolower(getdvar("mapname"));

  if(!isDefined(var_00) || var_00 == 0) {
    if(isDefined(level.func_7683)) {
      return;
    }
    if(!isDefined(level.func_4C6B))
      level.func_4C6B = ::func_E44D;

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
      var_2.gs = spawnStruct();
      var_2.gs.func_B639 = spawnStruct();
      var_02 func_9723();
      var_2.a = spawnStruct();
      var_2.func_4CF5 = [];
      var_02 scripts\sp\player_stats::func_9768();
      var_02 scripts\sp\utility::func_65E0("global_hint_in_use");
      var_2.pers = [];

      if(!isDefined(var_2.func_28A4))
        var_2.func_28A4 = 0;

      var_2.disabledweapon = 0;
      var_2.disabledweaponswitch = 0;
      var_2.disabledusability = 0;
      var_02 _meth_831C("frag");
    }

    level.func_54D3[0] = "easy";
    level.func_54D3[1] = "normal";
    level.func_54D3[2] = "hardened";
    level.func_54D3[3] = "veteran";
    level.func_54D2["easy"] = & "GAMESKILL_EASY";
    level.func_54D2["normal"] = & "GAMESKILL_NORMAL";
    level.func_54D2["hardened"] = & "GAMESKILL_HARDENED";
    level.func_54D2["veteran"] = & "GAMESKILL_VETERAN";
    thread func_7685();
  }

  setdvarifuninitialized("autodifficulty_playerDeathTimer", 0);
  anim.func_E7D4 = 0.5;
  anim.func_1385F = 0.8;
  setdvar("autodifficulty_frac", 0);
  level.func_54D1 = [];

  foreach(var_02 in level.players) {
    var_02 func_9772();
    var_02 thread func_93F7();
  }

  level.func_B6AD = 8;
  level.func_B6AC = 16;
  level.func_54D0["playerGrenadeBaseTime"]["easy"] = 40000;
  level.func_54D0["playerGrenadeBaseTime"]["normal"] = 35000;
  level.func_54D0["playerGrenadeBaseTime"]["hardened"] = 25000;
  level.func_54D0["playerGrenadeBaseTime"]["veteran"] = 25000;
  level.func_54D0["playerGrenadeRangeTime"]["easy"] = 20000;
  level.func_54D0["playerGrenadeRangeTime"]["normal"] = 15000;
  level.func_54D0["playerGrenadeRangeTime"]["hardened"] = 10000;
  level.func_54D0["playerGrenadeRangeTime"]["veteran"] = 10000;
  level.func_54D0["playerDoubleGrenadeTime"]["easy"] = 3600000;
  level.func_54D0["playerDoubleGrenadeTime"]["normal"] = 150000;
  level.func_54D0["playerDoubleGrenadeTime"]["hardened"] = 90000;
  level.func_54D0["playerDoubleGrenadeTime"]["veteran"] = 90000;
  level.func_54D0["double_grenades_allowed"]["easy"] = 0;
  level.func_54D0["double_grenades_allowed"]["normal"] = 1;
  level.func_54D0["double_grenades_allowed"]["hardened"] = 1;
  level.func_54D0["double_grenades_allowed"]["veteran"] = 1;
  level.func_54D0["threatbias"]["easy"] = 100;
  level.func_54D0["threatbias"]["normal"] = 150;
  level.func_54D0["threatbias"]["hardened"] = 200;
  level.func_54D0["threatbias"]["veteran"] = 400;
  level.func_54D0["base_enemy_accuracy"]["easy"] = 0.9;
  level.func_54D0["base_enemy_accuracy"]["normal"] = 1.0;
  level.func_54D0["base_enemy_accuracy"]["hardened"] = 1.15;
  level.func_54D0["base_enemy_accuracy"]["veteran"] = 1.15;
  level.func_54D0["accuracyDistScale"]["easy"] = 1.0;
  level.func_54D0["accuracyDistScale"]["normal"] = 1.0;
  level.func_54D0["accuracyDistScale"]["hardened"] = 0.6;
  level.func_54D0["accuracyDistScale"]["veteran"] = 0.8;
  level.func_54D0["min_sniper_burst_delay_time"]["easy"] = 3.0;
  level.func_54D0["min_sniper_burst_delay_time"]["normal"] = 2.0;
  level.func_54D0["min_sniper_burst_delay_time"]["hardened"] = 1.5;
  level.func_54D0["min_sniper_burst_delay_time"]["veteran"] = 1.1;
  level.func_54D0["sniper_converge_scale"]["easy"] = 1.3;
  level.func_54D0["sniper_converge_scale"]["normal"] = 1.1;
  level.func_54D0["sniper_converge_scale"]["hardened"] = 0.9;
  level.func_54D0["sniper_converge_scale"]["veteran"] = 0.7;
  level.func_54D0["sniperAccuDiffScale"]["easy"] = 1.0;
  level.func_54D0["sniperAccuDiffScale"]["normal"] = 1.6;
  level.func_54D0["sniperAccuDiffScale"]["hardened"] = 1.6;
  level.func_54D0["sniperAccuDiffScale"]["veteran"] = 1.9;
  level.func_54D0["max_sniper_burst_delay_time"]["easy"] = 4.0;
  level.func_54D0["max_sniper_burst_delay_time"]["normal"] = 3.0;
  level.func_54D0["max_sniper_burst_delay_time"]["hardened"] = 2.0;
  level.func_54D0["max_sniper_burst_delay_time"]["veteran"] = 1.5;
  level.func_54D0["c6_TorsoDamageDismemberLimbChance"]["easy"] = 70;
  level.func_54D0["c6_TorsoDamageDismemberLimbChance"]["normal"] = 40;
  level.func_54D0["c6_TorsoDamageDismemberLimbChance"]["hardened"] = 30;
  level.func_54D0["c6_TorsoDamageDismemberLimbChance"]["veteran"] = 20;
  level.func_54D0["pain_test"]["easy"] = ::func_1D5A;
  level.func_54D0["pain_test"]["normal"] = ::func_1D5A;
  level.func_54D0["pain_test"]["hardened"] = ::func_C868;
  level.func_54D0["pain_test"]["veteran"] = ::func_C868;
  level.func_54D0["missTimeConstant"]["easy"] = 1.0;
  level.func_54D0["missTimeConstant"]["normal"] = 0.05;
  level.func_54D0["missTimeConstant"]["hardened"] = 0;
  level.func_54D0["missTimeConstant"]["veteran"] = 0;
  level.func_54D0["missTimeDistanceFactor"]["easy"] = 0.0008;
  level.func_54D0["missTimeDistanceFactor"]["normal"] = 0.0001;
  level.func_54D0["missTimeDistanceFactor"]["hardened"] = 0.00005;
  level.func_54D0["missTimeDistanceFactor"]["veteran"] = 0;
  level.func_54D0["flashbangedInvulFactor"]["easy"] = 0.25;
  level.func_54D0["flashbangedInvulFactor"]["normal"] = 0;
  level.func_54D0["flashbangedInvulFactor"]["hardened"] = 0;
  level.func_54D0["flashbangedInvulFactor"]["veteran"] = 0;
  level.func_54D0["player_criticalBulletDamageDist"]["easy"] = 0;
  level.func_54D0["player_criticalBulletDamageDist"]["normal"] = 0;
  level.func_54D0["player_criticalBulletDamageDist"]["hardened"] = 0;
  level.func_54D0["player_criticalBulletDamageDist"]["veteran"] = 0;
  level.func_54D0["player_deathInvulnerableTime"]["easy"] = 4000;
  level.func_54D0["player_deathInvulnerableTime"]["normal"] = 2500;
  level.func_54D0["player_deathInvulnerableTime"]["hardened"] = 600;
  level.func_54D0["player_deathInvulnerableTime"]["veteran"] = 100;
  level.func_54D0["invulTime_preShield"]["easy"] = 0.6;
  level.func_54D0["invulTime_preShield"]["normal"] = 0.5;
  level.func_54D0["invulTime_preShield"]["hardened"] = 0.3;
  level.func_54D0["invulTime_preShield"]["veteran"] = 0.0;
  level.func_54D0["invulTime_onShield"]["easy"] = 1.6;
  level.func_54D0["invulTime_onShield"]["normal"] = 1.0;
  level.func_54D0["invulTime_onShield"]["hardened"] = 0.5;
  level.func_54D0["invulTime_onShield"]["veteran"] = 0.25;
  level.func_54D0["invulTime_postShield"]["easy"] = 0.5;
  level.func_54D0["invulTime_postShield"]["normal"] = 0.4;
  level.func_54D0["invulTime_postShield"]["hardened"] = 0.3;
  level.func_54D0["invulTime_postShield"]["veteran"] = 0.0;
  level.func_54D0["playerHealth_RegularRegenDelay"]["easy"] = 4000;
  level.func_54D0["playerHealth_RegularRegenDelay"]["normal"] = 4000;
  level.func_54D0["playerHealth_RegularRegenDelay"]["hardened"] = 3000;
  level.func_54D0["playerHealth_RegularRegenDelay"]["veteran"] = 1200;
  level.func_54D0["regularRegenDelayScalar"] = 1.0;
  level.func_54D0["worthyDamageRatio"]["easy"] = 0.0;
  level.func_54D0["worthyDamageRatio"]["normal"] = 0.1;
  level.func_54D0["worthyDamageRatio"]["hardened"] = 0.3;
  level.func_54D0["worthyDamageRatio"]["veteran"] = 0.3;
  level.func_54D0["playerDifficultyHealth"]["easy"] = 475;
  level.func_54D0["playerDifficultyHealth"]["normal"] = 275;
  level.func_54D0["playerDifficultyHealth"]["hardened"] = 165;
  level.func_54D0["playerDifficultyHealth"]["veteran"] = 115;
  level.func_54D0["longRegenTime"]["easy"] = 5000;
  level.func_54D0["longRegenTime"]["normal"] = 5000;
  level.func_54D0["longRegenTime"]["hardened"] = 3200;
  level.func_54D0["longRegenTime"]["veteran"] = 3200;
  level.func_54D0["longRegenTimeScalar"] = 1.0;
  level.func_54D0["healthOverlayCutoff"]["easy"] = 0.02;
  level.func_54D0["healthOverlayCutoff"]["normal"] = 0.02;
  level.func_54D0["healthOverlayCutoff"]["hardened"] = 0.02;
  level.func_54D0["healthOverlayCutoff"]["veteran"] = 0.02;
  level.func_54D0["health_regenRate"]["easy"] = 0.02;
  level.func_54D0["health_regenRate"]["normal"] = 0.02;
  level.func_54D0["health_regenRate"]["hardened"] = 0.02;
  level.func_54D0["health_regenRate"]["veteran"] = 0.02;
  level.func_54D0["explosivePlantTime"]["easy"] = 10;
  level.func_54D0["explosivePlantTime"]["normal"] = 10;
  level.func_54D0["explosivePlantTime"]["hardened"] = 5;
  level.func_54D0["explosivePlantTime"]["veteran"] = 5;
  level.func_54D0["player_downed_buffer_time"]["normal"] = 2;
  level.func_54D0["player_downed_buffer_time"]["hardened"] = 1.5;
  level.func_54D0["player_downed_buffer_time"]["veteran"] = 0;
  level.func_54D0["c12_RocketTellHoldTime"]["easy"] = 1.5;
  level.func_54D0["c12_RocketTellHoldTime"]["normal"] = 1;
  level.func_54D0["c12_RocketTellHoldTime"]["hardened"] = 0.5;
  level.func_54D0["c12_RocketTellHoldTime"]["veteran"] = 0;
  level.func_54D0["c12_DismemberRecoveryTime"]["easy"] = 9;
  level.func_54D0["c12_DismemberRecoveryTime"]["normal"] = 6;
  level.func_54D0["c12_DismemberRecoveryTime"]["hardened"] = 3;
  level.func_54D0["c12_DismemberRecoveryTime"]["veteran"] = 0;
  level.func_54D0["c12_MinigunStruggleDamage"]["easy"] = 15.5;
  level.func_54D0["c12_MinigunStruggleDamage"]["normal"] = 16;
  level.func_54D0["c12_MinigunStruggleDamage"]["hardened"] = 20;
  level.func_54D0["c12_MinigunStruggleDamage"]["veteran"] = 30;
  level.func_54D0["playerJackalHealth"]["easy"] = 5500;
  level.func_54D0["playerJackalHealth"]["normal"] = 4000;
  level.func_54D0["playerJackalHealth"]["hardened"] = 2400;
  level.func_54D0["playerJackalHealth"]["veteran"] = 1600;
  level.func_54D0["playerJackalBaseAimAssist"]["easy"] = 1.5;
  level.func_54D0["playerJackalBaseAimAssist"]["normal"] = 1.0;
  level.func_54D0["playerJackalBaseAimAssist"]["hardened"] = 1.0;
  level.func_54D0["playerJackalBaseAimAssist"]["veteran"] = 1.0;
  level.func_54D0["playerJackalInvulnerableTime"]["easy"] = 6500;
  level.func_54D0["playerJackalInvulnerableTime"]["normal"] = 4500;
  level.func_54D0["playerJackalInvulnerableTime"]["hardened"] = 2000;
  level.func_54D0["playerJackalInvulnerableTime"]["veteran"] = 500;
  level.func_54D0["playerJackalRegularRegenDelay"]["easy"] = 3000;
  level.func_54D0["playerJackalRegularRegenDelay"]["normal"] = 3000;
  level.func_54D0["playerJackalRegularRegenDelay"]["hardened"] = 1000;
  level.func_54D0["playerJackalRegularRegenDelay"]["veteran"] = 1000;
  level.func_54D0["playerJackalLongRegenDelay"]["easy"] = 4000;
  level.func_54D0["playerJackalLongRegenDelay"]["normal"] = 4000;
  level.func_54D0["playerJackalLongRegenDelay"]["hardened"] = 2000;
  level.func_54D0["playerJackalLongRegenDelay"]["veteran"] = 2000;
  level.func_54D0["playerJackalHealthRegenRate"]["easy"] = 70;
  level.func_54D0["playerJackalHealthRegenRate"]["normal"] = 30;
  level.func_54D0["playerJackalHealthRegenRate"]["hardened"] = 20;
  level.func_54D0["playerJackalHealthRegenRate"]["veteran"] = 10;
  level.func_54D0["playerJackalImpactDamageScale"]["easy"] = 0.5;
  level.func_54D0["playerJackalImpactDamageScale"]["normal"] = 1;
  level.func_54D0["playerJackalImpactDamageScale"]["hardened"] = 1;
  level.func_54D0["playerJackalImpactDamageScale"]["veteran"] = 1.2;
  level.func_54D0["JackalHoverheatRampTime"]["easy"] = 20000;
  level.func_54D0["JackalHoverheatRampTime"]["normal"] = 20000;
  level.func_54D0["JackalHoverheatRampTime"]["hardened"] = 15000;
  level.func_54D0["JackalHoverheatRampTime"]["veteran"] = 10000;
  level.func_54D0["JackalHoverheatMaxEnemies"]["easy"] = 5;
  level.func_54D0["JackalHoverheatMaxEnemies"]["normal"] = 6;
  level.func_54D0["JackalHoverheatMaxEnemies"]["hardened"] = 7;
  level.func_54D0["JackalHoverheatMaxEnemies"]["veteran"] = 8;
  level.func_54D0["JackalAttackercountMaxScalar"]["easy"] = 0.5;
  level.func_54D0["JackalAttackercountMaxScalar"]["normal"] = 0.7;
  level.func_54D0["JackalAttackercountMaxScalar"]["hardened"] = 0.8;
  level.func_54D0["JackalAttackercountMaxScalar"]["veteran"] = 0.9;
  level.func_54D0["JackalAttackercountMax"]["easy"] = 3;
  level.func_54D0["JackalAttackercountMax"]["normal"] = 4;
  level.func_54D0["JackalAttackercountMax"]["hardened"] = 5;
  level.func_54D0["JackalAttackercountMax"]["veteran"] = 5;
  level.func_54D0["JackalAccuracyPerSecond"]["easy"] = 0.2;
  level.func_54D0["JackalAccuracyPerSecond"]["normal"] = 0.3;
  level.func_54D0["JackalAccuracyPerSecond"]["hardened"] = 0.6;
  level.func_54D0["JackalAccuracyPerSecond"]["veteran"] = 0.9;
  level.func_54D0["JackalLockingBoostEscapeScale"]["easy"] = 4;
  level.func_54D0["JackalLockingBoostEscapeScale"]["normal"] = 3;
  level.func_54D0["JackalLockingBoostEscapeScale"]["hardened"] = 2;
  level.func_54D0["JackalLockingBoostEscapeScale"]["veteran"] = 1;
  level.func_54D0["JackalLockedBoostEscapeScale"]["easy"] = 6;
  level.func_54D0["JackalLockedBoostEscapeScale"]["normal"] = 4;
  level.func_54D0["JackalLockedBoostEscapeScale"]["hardened"] = 2;
  level.func_54D0["JackalLockedBoostEscapeScale"]["veteran"] = 1;
  level.func_54D0["JackalLockedTurnEscapeScale"]["easy"] = 2;
  level.func_54D0["JackalLockedTurnEscapeScale"]["normal"] = 1.5;
  level.func_54D0["JackalLockedTurnEscapeScale"]["hardened"] = 1.1;
  level.func_54D0["JackalLockedTurnEscapeScale"]["veteran"] = 1;
  level.func_54D0["JackalTargetAidMinTime"]["easy"] = 2;
  level.func_54D0["JackalTargetAidMinTime"]["normal"] = 2;
  level.func_54D0["JackalTargetAidMinTime"]["hardened"] = 2;
  level.func_54D0["JackalTargetAidMinTime"]["veteran"] = 2;
  level.func_54D0["JackalTargetAidMaxTime"]["easy"] = 3;
  level.func_54D0["JackalTargetAidMaxTime"]["normal"] = 3;
  level.func_54D0["JackalTargetAidMaxTime"]["hardened"] = 3;
  level.func_54D0["JackalTargetAidMaxTime"]["veteran"] = 3;
  level.func_54D0["JackalIncomingMissileSpeedScale"]["easy"] = 0.54;
  level.func_54D0["JackalIncomingMissileSpeedScale"]["normal"] = 1;
  level.func_54D0["JackalIncomingMissileSpeedScale"]["hardened"] = 1.35;
  level.func_54D0["JackalIncomingMissileSpeedScale"]["veteran"] = 1.75;
  level.func_54D0["JackallockonEnemyShowdownAccuracy"]["easy"] = 0.5;
  level.func_54D0["JackallockonEnemyShowdownAccuracy"]["normal"] = 0.75;
  level.func_54D0["JackallockonEnemyShowdownAccuracy"]["hardened"] = 0.9;
  level.func_54D0["JackallockonEnemyShowdownAccuracy"]["veteran"] = 1;
  level.func_54D0["CapShipMiniflakThresholdMin"]["easy"] = -0.85;
  level.func_54D0["CapShipMiniflakThresholdMin"]["normal"] = -0.8;
  level.func_54D0["CapShipMiniflakThresholdMin"]["hardened"] = -0.78;
  level.func_54D0["CapShipMiniflakThresholdMin"]["veteran"] = -0.75;
  level.func_54D0["CapShipMiniflakThresholdMax"]["easy"] = -0.4;
  level.func_54D0["CapShipMiniflakThresholdMax"]["normal"] = -0.35;
  level.func_54D0["CapShipMiniflakThresholdMax"]["hardened"] = -0.34;
  level.func_54D0["CapShipMiniflakThresholdMax"]["veteran"] = -0.33;
  level.func_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["easy"] = -0.75;
  level.func_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["normal"] = -0.7;
  level.func_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["hardened"] = -0.68;
  level.func_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["veteran"] = -0.66;
  level.func_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["easy"] = -0.32;
  level.func_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["normal"] = -0.28;
  level.func_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["hardened"] = -0.27;
  level.func_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["veteran"] = -0.26;
  level.func_54D0["AjaxEngineHealthmod"]["easy"] = 0.8;
  level.func_54D0["AjaxEngineHealthmod"]["normal"] = 1;
  level.func_54D0["AjaxEngineHealthmod"]["hardened"] = 1.2;
  level.func_54D0["AjaxEngineHealthmod"]["veteran"] = 1.4;
  level.func_54D0["CapitalshipTurretHealthmod"]["easy"] = 0.8;
  level.func_54D0["CapitalshipTurretHealthmod"]["normal"] = 1;
  level.func_54D0["CapitalshipTurretHealthmod"]["hardened"] = 1.3;
  level.func_54D0["CapitalshipTurretHealthmod"]["veteran"] = 1.6;

  if(scripts\sp\utility::func_93A6()) {
    level.func_54D0["player_deathInvulnerableTime"]["hardened"] = 1;
    level.func_54D0["worthyDamageRatio"]["hardened"] = 1;
    level.func_54D0["invulTime_preShield"]["hardened"] = 0;
    level.func_54D0["invulTime_onShield"]["hardened"] = 0;
    level.func_54D0["invulTime_postShield"]["hardened"] = 0;
    level.func_54D0["playerDifficultyHealth"]["hardened"] = 190;
    level.func_54D0["playerJackalBaseAimAssist"]["hardened"] = 1.5;
    level.func_54D0["JackalHoverheatMaxEnemies"]["hardened"] = 2;
  }

  level.func_A9D0 = 0;
  level.playermeleedamagemultiplier_dvar = 0.8;
  _setsaveddvar("player_meleeDamageMultiplier", level.playermeleedamagemultiplier_dvar);

  if(isDefined(level.func_4C53))
    [[level.func_4C53]]();

  updategameskill();
  func_12E5A();
  setdvar("autodifficulty_original_setting", level.func_7683);
}

func_F52D(var_00, var_01) {
  level.func_54D0["regularRegenDelayScalar"] = var_00;
  level.func_54D0["longRegenTimeScalar"] = var_01;
}

func_9723() {
  self.gs.func_ECCC = [];
  var_00 = ["bottom", "left", "right"];
  var_01 = ["bloodsplat", "dirt"];

  foreach(var_03 in var_01) {
    foreach(var_05 in var_00) {
      self.gs.func_ECCC[var_03][var_05] = 0;
      self.gs.func_ECCC[var_03 + "_count"][var_05] = 0;
    }
  }
}

func_12E5A() {
  func_F725();
  func_F761();

  for(var_00 = 0; var_00 < level.players.size; var_0++)
    level.players[var_00] func_F6C3();
}

func_F6C3() {
  func_F355();
}

func_F725() {
  var_00 = ::func_7AAF;
  var_01 = func_7C6D(level.func_7683);
  anim.func_C86F = level.func_54D0["pain_test"][var_01];
  level.func_6A04 = level.func_54D0["explosivePlantTime"][var_01];
  anim.func_B750 = [
    [var_00]
  ]("min_sniper_burst_delay_time", level.func_7683);
  anim.func_B461 = [
    [var_00]
  ]("max_sniper_burst_delay_time", level.func_7683);
  _setsaveddvar("ai_accuracyDistScale", [
    [var_00]
  ]("accuracyDistScale", level.func_7683));
  func_F679();
  anim.func_3546 = level.func_54D0["c12_DismemberRecoveryTime"][var_01];
  anim.func_35EC = level.func_54D0["c12_RocketTellHoldTime"][var_01];
  anim.func_35C6 = level.func_54D0["c12_MinigunStruggleDamage"][var_01];
  anim.func_33BB = level.func_54D0["c6_TorsoDamageDismemberLimbChance"][var_01];
  scripts\sp\mgturret::func_F6C3();
}

func_F761() {
  if(!isDefined(level.func_A48E))
    level.func_A48E = spawnStruct();

  if(scripts\sp\utility::func_93A6()) {
    var_00 = "veteran";
    level.func_A48E.func_A3FB = level.func_54D0["JackalIncomingMissileSpeedScale"]["hardened"];
  } else {
    var_00 = func_7C6D(level.func_7683);
    level.func_A48E.func_A3FB = level.func_54D0["JackalIncomingMissileSpeedScale"][var_00];
  }

  level.func_A48E.func_D3BA = level.func_54D0["playerJackalHealth"][var_00];
  level.func_A48E.func_D3BD = level.func_54D0["playerJackalInvulnerableTime"][var_00];
  level.func_A48E.func_D3B9 = level.func_54D0["playerJackalBaseAimAssist"][var_00];
  level.func_A48E.func_D3C0 = level.func_54D0["playerJackalRegularRegenDelay"][var_00];
  level.func_A48E.func_D3BF = level.func_54D0["playerJackalLongRegenDelay"][var_00];
  level.func_A48E.func_D3BB = level.func_54D0["playerJackalHealthRegenRate"][var_00];
  level.func_A48E.func_D3BC = level.func_54D0["playerJackalImpactDamageScale"][var_00];
  level.func_A48E.func_A3F5 = level.func_54D0["JackalHoverheatRampTime"][var_00];
  level.func_A48E.func_A3F4 = level.func_54D0["JackalHoverheatMaxEnemies"][var_00];
  level.func_A48E.func_A3AE = level.func_54D0["JackalAttackercountMaxScalar"][var_00];
  level.func_A48E.func_A3AD = level.func_54D0["JackalAttackercountMax"][var_00];
  level.func_A48E.func_A3A6 = level.func_54D0["JackalAccuracyPerSecond"][var_00];
  level.func_A48E.func_A40A = level.func_54D0["JackalLockingBoostEscapeScale"][var_00];
  level.func_A48E.func_A408 = level.func_54D0["JackalLockedBoostEscapeScale"][var_00];
  level.func_A48E.func_A409 = level.func_54D0["JackalLockedTurnEscapeScale"][var_00];
  level.func_A48E.func_A425 = level.func_54D0["JackalTargetAidMinTime"][var_00];
  level.func_A48E.func_A424 = level.func_54D0["JackalTargetAidMaxTime"][var_00];
  level.func_A48E.func_A40B = level.func_54D0["JackallockonEnemyShowdownAccuracy"][var_00];
  level.func_A48E.func_3A06 = level.func_54D0["CapShipMiniflakThresholdMin"][var_00];
  level.func_A48E.func_3A05 = level.func_54D0["CapShipMiniflakThresholdMax"][var_00];
  level.func_A48E.func_3A04 = level.func_54D0["CapShipMiniflakThresholdHyperAggressiveMin"][var_00];
  level.func_A48E.func_3A03 = level.func_54D0["CapShipMiniflakThresholdHyperAggressiveMax"][var_00];
  level.func_A48E.func_39F9 = level.func_54D0["CapitalshipTurretHealthmod"][var_00];
  level.func_A48E.func_1B13 = level.func_54D0["AjaxEngineHealthmod"][var_00];
  func_F762();
  level.func_A48E.func_D3BE = level.func_A48E.func_D3BA;
}

func_F762() {
  if(!isDefined(level.func_D127)) {
    return;
  }
  if(isDefined(level.func_A48E.func_D3BE) && isDefined(level.func_D127.func_B154)) {
    var_00 = level.func_A48E.func_D3BA / level.func_A48E.func_D3BE;
    level.func_D127.func_B154 = level.func_D127.func_B154 * var_00;
  }

  if(isDefined(level.func_D127.func_4C15) && isDefined(level.func_D127.func_4C15.func_105EE))
    _setsaveddvar("spaceshipTargetLockAnglesScale", level.func_D127.func_4C15.func_105EE * level.func_A48E.func_D3B9);
  else
    _setsaveddvar("spaceshipTargetLockAnglesScale", level.func_A48E.func_D3B9);
}

func_F679() {
  var_00 = scripts\sp\utility::func_7E72();
  level.player.gs.func_B63A = 1000;
  level.player.gs.func_B63C = 10;

  if(var_00 == "medium") {
    level.player.gs.func_B63A = 5000;
    level.player.gs.func_B63C = 4;
  } else if(var_00 == "hard") {
    level.player.gs.func_B63A = 1000;
    level.player.gs.func_B63C = 1;
  }
}

updategameskill() {
  foreach(var_01 in level.players)
  var_1.func_7683 = var_01 scripts\sp\utility::func_7B93();

  level.func_7683 = level.player.func_7683;

  if(isDefined(level.func_72B4))
    level.func_7683 = level.func_72B4;

  return level.func_7683;
}

func_7685() {
  var_00 = level.func_7683;

  for(;;) {
    if(!isDefined(var_00)) {
      wait 1;
      var_00 = level.func_7683;
      continue;
    }

    if(var_00 != updategameskill()) {
      var_00 = level.func_7683;
      func_12E5A();
    }

    wait 1;
  }
}

func_7C6D(var_00) {
  return level.func_54D3[var_00];
}

func_14F3() {
  return level.func_7683 == getdvarint("autodifficulty_original_setting");
}

func_20A1(var_00, var_01) {
  self.gs.invultime_preshield = [
    [var_00]
  ]("invulTime_preShield", var_01);
  self.gs.invultime_onshield = [
    [var_00]
  ]("invulTime_onShield", var_01);
  self.gs.invultime_postshield = [
    [var_00]
  ]("invulTime_postShield", var_01);
  self.gs.playerhealth_regularregendelay = [
    [var_00]
  ]("playerHealth_RegularRegenDelay", var_01) * level.func_54D0["regularRegenDelayScalar"];
  self.gs.worthydamageratio = [
    [var_00]
  ]("worthyDamageRatio", var_01);
  self.threatbias = int([
    [var_00]
  ]("threatbias", var_01));
  self.gs.longregentime = [
    [var_00]
  ]("longRegenTime", var_01) * level.func_54D0["longRegenTimeScalar"];
  self.gs.healthoverlaycutoff = [
    [var_00]
  ]("healthOverlayCutoff", var_01);
  self.gs.func_DE8D = [
    [var_00]
  ]("health_regenRate", var_01);
  self.gs.func_CF81 = [
    [var_00]
  ]("base_enemy_accuracy", var_01);
  func_12E0B();
  self.gs.func_D396 = int([
    [var_00]
  ]("playerGrenadeBaseTime", var_01));
  self.gs.func_D397 = int([
    [var_00]
  ]("playerGrenadeRangeTime", var_01));
  self.gs.func_D382 = int([
    [var_00]
  ]("playerDoubleGrenadeTime", var_01));
  self.gs.func_B750 = [
    [var_00]
  ]("min_sniper_burst_delay_time", var_01);
  self.gs.func_B461 = [
    [var_00]
  ]("max_sniper_burst_delay_time", var_01);
  self.deathinvulnerabletime = int([
    [var_00]
  ]("player_deathInvulnerableTime", var_01));
  self.criticalbulletdamagedist = int([
    [var_00]
  ]("player_criticalBulletDamageDist", var_01));
  self.damagemultiplier = 100 / [
    [var_00]
  ]("playerDifficultyHealth", var_01);
}

func_12E0B() {
  if(scripts\sp\utility::func_65DB("player_zero_attacker_accuracy")) {
    return;
  }
  self.ignorerandombulletdamage = self.func_28A4;
  self.attackeraccuracy = self.gs.func_CF81;
}

func_20A2(var_00, var_01) {
  self.gs.func_B8D7 = [
    [var_00]
  ]("missTimeConstant", var_01);
  self.gs.func_B8D9 = [
    [var_00]
  ]("missTimeDistanceFactor", var_01);
  self.gs.double_grenades_allowed = [
    [var_00]
  ]("double_grenades_allowed", var_01);
}

func_F355() {
  func_20A1(::func_7AB0, 1);
  func_20A2(::func_7AAE, 1);
}

func_7AAE(var_00, var_01) {
  return level.func_54D0[var_00][func_7C6D(self.func_7683)];
}

func_7AAD(var_00, var_01) {
  return level.func_54D0[var_00][func_7C6D(level.func_7683)];
}

func_786D(var_00, var_01) {
  var_02 = level.func_54D1[var_00];

  for(var_03 = 1; var_03 < var_2.size; var_3++) {
    var_04 = var_2[var_03]["frac"];
    var_05 = var_2[var_03]["val"];

    if(var_01 <= var_04) {
      var_06 = var_2[var_03 - 1]["frac"];
      var_07 = var_2[var_03 - 1]["val"];
      var_08 = var_04 - var_06;
      var_09 = var_05 - var_07;
      var_10 = var_01 - var_06;
      var_11 = var_10 / var_08;
      return var_07 + var_11 * var_09;
    }
  }

  return var_2[var_2.size - 1]["val"];
}

func_7E4A(var_00) {
  return level.func_54D0[var_00][func_7C6D(self.func_7683)];
}

_meth_80D5(var_00, var_01, var_02) {
  return (level.func_54D0[var_00][level.func_54D3[var_01]] * (100 - getdvarint("autodifficulty_frac")) + level.func_54D0[var_00][level.func_54D3[var_02]] * getdvarint("autodifficulty_frac")) * 0.01;
}

func_7AB0(var_00, var_01) {
  return level.func_54D0[var_00][func_7C6D(self.func_7683)];
}

func_7AAF(var_00, var_01) {
  return level.func_54D0[var_00][func_7C6D(level.func_7683)];
}

func_1D5A() {
  return 0;
}

func_C868() {
  if(!func_C869())
    return 0;

  return randomint(100) > 25;
}

func_C869() {
  if(!isalive(self.enemy))
    return 0;

  if(!isplayer(self.enemy))
    return 0;

  if(!isalive(level.func_C870) || level.func_C870.script != "pain")
    level.func_C870 = self;

  if(self == level.func_C870)
    return 0;

  if(self.damageweapon != "none" && weaponisboltaction(self.damageweapon))
    return 0;

  return 1;
}

func_F288() {
  if(scripts\anim\utility_common::isasniper() && isalive(self.enemy)) {
    func_F84B();
    return;
  }

  if(isplayer(self.enemy)) {
    func_E258();

    if(self.a.func_B8D6 > gettime()) {
      self.accuracy = 0;
      return;
    }
  }

  if(self.script == "move") {
    if(scripts\engine\utility::actor_is3d() && isDefined(self.var_1198.func_AA3D) && (self.var_1198.func_AA3D.type == "Exposed 3D" || self.var_1198.func_AA3D.type == "Path 3D"))
      self.accuracy = self.func_2894;
    else if(scripts\anim\utility::func_9D9C())
      self.accuracy = anim.func_1385F * self.func_2894;
    else
      self.accuracy = anim.func_E7D4 * self.func_2894;

    return;
  }

  self.accuracy = self.func_2894;

  if(isDefined(self.func_9F15) && isDefined(self.func_DC58))
    self.accuracy = self.accuracy * self.func_DC58;
}

func_F84B() {
  if(!isDefined(self.func_103BF)) {
    self.func_103BF = 0;
    self.func_103BA = 0;
  }

  if(!isDefined(self.func_103B2)) {
    self.func_103B2 = 1;
    var_00 = func_7C6D(level.func_7683);
    var_01 = level.func_54D0["sniperAccuDiffScale"][var_00];
    self.func_2894 = self.accuracy * var_01;
  }

  self.func_103BF++;
  var_02 = level.func_7683;

  if(isplayer(self.enemy))
    var_02 = self.enemy.func_7683;

  if(func_10019()) {
    self.accuracy = 0;

    if(var_02 > 0 || self.func_103BF > 1)
      self.func_A9BA = self.enemy;

    return;
  }

  if(self.accuracy <= 10)
    self.accuracy = (1 + 1 * self.func_103BA) * self.func_2894;

  self.func_103BA++;

  if(var_02 < 1 && self.func_103BA == 1)
    self.func_A9BA = undefined;
}

func_10019() {
  if(isDefined(self.func_BEF8) && self.func_BEF8)
    return 0;

  if(self.team == "allies")
    return 0;

  if(isDefined(self.func_A9BA) && self.enemy == self.func_A9BA)
    return 0;

  if(distancesquared(self.origin, self.enemy.origin) > 250000)
    return 0;

  return 1;
}

func_FF07() {
  return 1 + randomfloat(4);
}

func_54C4() {
  self.a.func_B8D8 = 0;
}

func_E242() {
  resetmisstime_code();
}

func_13847() {
  var_00 = 0;
  waittillframeend;

  if(!isalive(self.enemy))
    return var_00;

  if(!isplayer(self.enemy))
    return var_00;

  if(self.enemy scripts\sp\utility::func_65DB("player_is_invulnerable"))
    var_00 = 0.3 + randomfloat(0.4);

  return var_00;
}

func_D8EB(var_00, var_01, var_02, var_03) {
  var_03 = var_03 * 20;

  for(var_04 = 0; var_04 < var_03; var_4++)
    wait 0.05;
}

resetmisstime_code() {
  if(!self isbadguy()) {
    return;
  }
  if(self.weapon == "none") {
    return;
  }
  if(scripts\anim\utility_common::isasniper()) {
    return;
  }
  if(!scripts\anim\weaponlist::usingautomaticweapon() && !scripts\anim\weaponlist::usingsemiautoweapon()) {
    self.func_B8D6 = 0;
    return;
  }

  if(!isalive(self.enemy)) {
    return;
  }
  if(!isplayer(self.enemy)) {
    self.accuracy = self.func_2894;
    return;
  }

  var_00 = distance(self.enemy.origin, self.origin);
  func_F79C(self.enemy.gs.func_B8D7 + var_00 * self.enemy.gs.func_B8D9);
}

func_E258() {
  self.a.func_B8D8 = gettime() + 3000;
}

func_F79C(var_00) {
  if(self.a.func_B8D8 > gettime()) {
    return;
  }
  if(var_00 > 0)
    self.accuracy = 0;

  var_00 = var_00 * 1000;
  self.a.func_B8D6 = gettime() + var_00;
  self.a.func_154C = 1;
}

func_CF4D() {
  self endon("death");
  self notify("playeraim");
  self endon("playeraim");

  for(;;) {
    var_00 = (0, 1, 0);

    if(self.a.func_B8D6 > gettime())
      var_00 = (1, 0, 0);

    wait 0.05;
  }
}

func_ECC2(var_00, var_01, var_02) {
  var_03 = randomfloatrange(-15, 15);
  var_04 = randomfloatrange(-15, 15);
  self scaleovertime(0.1, int(2048 * var_01), int(1152 * var_01));
  self.y = 100 + var_04;
  self moveovertime(0.08);
  self.y = 0 + var_04;
  self.x = self.x + var_03;

  if(isDefined(var_02)) {
    return;
  }
  func_ECC1();
}

func_ECC3(var_00, var_01, var_02) {
  var_03 = 1;

  if(var_02)
    var_03 = -1;

  var_04 = randomfloatrange(-15, 15);
  var_05 = randomfloatrange(-15, 15);
  self scaleovertime(0.1, int(2048 * var_01), int(1152 * var_01));
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

forcehidegrenadehudwarning(var_00) {
  var_01 = "fullscreen_dirt_" + var_00;
  var_02 = undefined;

  if(var_00 == "bottom")
    var_02 = "fullscreen_dirt_bottom_b";

  thread func_56C6("dirt", var_00, var_01, var_02, randomfloatrange(0.55, 0.66));
}

func_2BC1(var_00) {
  var_01 = "fullscreen_bloodsplat_" + var_00;
  thread func_56C6("bloodsplat", var_00, var_01, undefined, randomfloatrange(0.45, 0.56));
}

func_56C6(var_00, var_01, var_02, var_03, var_04) {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.func_9BA2)) {
    return;
  }
  var_05 = gettime();

  if(self.gs.func_ECCC[var_00][var_01] == var_05) {
    return;
  }
  if(self.gs.func_ECCC[var_00 + "_count"][var_01] == 1) {
    return;
  }
  self.gs.func_ECCC[var_00 + "_count"][var_01]++;
  self.gs.func_ECCC[var_00][var_01] = var_05;
  self endon("death");

  switch (var_01) {
    case "bottom":
      var_06 = int(640);
      var_07 = int(480);

      if(var_00 == "dirt") {
        var_08 = scripts\sp\hud_util::func_48B8(var_02, 1);
        var_08 thread func_ECC2(var_00, var_04, 1);
        var_08 func_ECC0();
      } else {
        var_08 = scripts\sp\hud_util::func_48B8(var_02, 0);
        var_08 func_ECC2(var_00, var_04);
      }

      if(isDefined(var_03)) {
        var_09 = scripts\sp\hud_util::func_48B8(var_03, 0);
        var_09 func_ECC2(var_00, var_04);
      }

      break;
    case "left":
      var_08 = scripts\sp\hud_util::func_48B8(var_02, 0, 1, 1);
      var_08 func_ECC3(var_00, var_04, 1);
      break;
    case "right":
      var_08 = scripts\sp\hud_util::func_48B8(var_02, 0, 1, 1);
      var_08 func_ECC3(var_00, var_04, 0);
      break;
    default:
  }

  self.gs.func_ECCC[var_01 + "_count"][var_02]--;
}

func_D3A9() {
  var_00 = scripts\sp\utility::func_7751;
  var_01 = scripts\sp\utility::func_2BC6;
  var_02 = [];
  var_2["MOD_GRENADE"] = var_00;
  var_2["MOD_GRENADE_SPLASH"] = var_00;
  var_2["MOD_PROJECTILE"] = var_00;
  var_2["MOD_PROJECTILE_SPLASH"] = var_00;
  var_2["MOD_EXPLOSIVE"] = var_00;
  var_2["MOD_PISTOL_BULLET"] = var_01;
  var_2["MOD_RIFLE_BULLET"] = var_01;
  var_2["MOD_EXPLOSIVE_BULLET"] = var_01;
  self.func_91F2 = 0;

  for(;;) {
    self waittill("damage", var_03, var_04, var_05, var_06, var_07);
    self.func_91F2 = 1;
    self.func_4D62 = var_06;
    self.damageattacker = var_04;
    var_08 = undefined;

    if(isDefined(self.func_B940))
      var_08 = self.func_B940[var_07];

    if(!isDefined(var_08) && isDefined(var_2[var_07]))
      var_08 = var_2[var_07];

    if(isDefined(var_08)) {
      waittillframeend;
      [
        [var_08]
      ](var_06);
    }
  }
}

func_D0CE() {
  self.func_D0CE = 3;
}

func_D3A6() {
  level.func_1114E["take_cover"] = spawnStruct();
  level.func_1114E["take_cover"].text = & "GAME_GET_TO_COVER";
  level.func_1114E["get_back_up"] = spawnStruct();
  level.func_1114E["get_back_up"].text = & "GAME_LAST_STAND_GET_BACK_UP";
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
  self.func_2C42 = 0;

  for(;;) {
    wait 0.05;
    waittillframeend;

    if(self.health == self.maxhealth) {
      if(scripts\sp\utility::func_65DB("player_has_red_flashing_overlay"))
        func_D259();

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

    if(var_09 <= self.gs.healthoverlaycutoff && self.func_D0CE > 1) {
      var_02 = 1;

      if(!var_08) {
        var_05 = gettime();

        if(scripts\sp\utility::func_65DB("near_death_vision_enabled")) {
          thread func_2BDB(3.6, 2);
          thread func_0B0B::func_F334();
          self getweaponfrommerit();
        }

        scripts\sp\utility::func_65E1("player_has_red_flashing_overlay");
        var_03 = 1;
      }
    }

    if(self.func_91F2) {
      var_05 = gettime();
      self.func_91F2 = 0;
    }

    if(self.health / self.maxhealth >= var_00) {
      if(gettime() - var_05 < self.gs.playerhealth_regularregendelay) {
        continue;
      }
      if(var_02) {
        var_06 = var_09;

        if(gettime() > var_05 + self.gs.longregentime)
          var_06 = var_06 + self.gs.func_DE8D;

        if(var_06 >= 1)
          func_DE3C();
      } else
        var_06 = 1;

      if(var_06 > 1.0)
        var_06 = 1.0;

      if(var_06 <= 0) {
        return;
      }
      self give_player_wall_bought_power(var_06);
      var_00 = self.health / self.maxhealth;
      continue;
    }

    var_00 = var_07;
    var_10 = self.gs.worthydamageratio;

    if(self.attackercount == 1)
      var_10 = var_10 * 3;

    var_11 = var_00 - var_09 >= var_10;

    if(self.health <= 1) {
      self give_player_wall_bought_power(2 / self.maxhealth);
      var_11 = 1;
    }

    var_00 = self.health / self.maxhealth;
    self notify("hit_again");
    var_01 = 0;
    var_05 = gettime();
    thread func_2BDB(3, 0.8);

    if(!var_11) {
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
    } else if(var_02)
      var_04 = self.gs.invultime_postshield;
    else
      var_04 = self.gs.invultime_preshield;

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
      var_0--;
      self _meth_8302("takeCoverWarnings", var_00);
    }
  }
}

func_D3B1(var_00) {
  if(isDefined(self.flashendtime) && self.flashendtime > gettime())
    var_00 = var_00 * func_7E4A("flashbangedInvulFactor");

  if(var_00 > 0) {
    if(!isDefined(self.func_C088))
      self.attackeraccuracy = 0;

    self.ignorerandombulletdamage = 1;
    wait(var_00);
  }

  func_12E0B();
  scripts\sp\utility::func_65DD("player_is_invulnerable");
}

func_4FE9() {
  if(self.team == "allies")
    self.func_5A0E = 0.6;

  if(self isbadguy()) {
    if(level.func_7683 >= 2)
      self.func_5A0E = 0.8;
    else
      self.func_5A0E = 0.6;
  }
}

grenadeawareness() {
  if(isDefined(self.asmname) && self.asmname == "seeker") {
    self.grenadeawareness = 0.0;
    return;
  }

  if(self.unittype == "c12" || self.unittype == "c8") {
    self.grenadeawareness = 0.0;
    return;
  }

  if(self.team == "allies") {
    self.grenadeawareness = 0.9;
    self.grenadereturnthrowchance = 0.9;
    return;
  }

  if(self isbadguy()) {
    if(level.func_7683 >= 2) {
      if(randomint(100) < 33)
        self.grenadeawareness = 0.2;
      else
        self.grenadeawareness = 0.5;
    } else if(randomint(100) < 33)
      self.grenadeawareness = 0;
    else
      self.grenadeawareness = 0.2;

    self.grenadereturnthrowchance = self.grenadeawareness;
  }
}

func_2BDB(var_00, var_01) {
  if(scripts\sp\utility::func_65DB("player_no_auto_blur")) {
    return;
  }
  self notify("blurview_stop");
  self endon("blurview_stop");
  self setblurforplayer(var_00, 0);
  wait 0.05;
  self setblurforplayer(0, var_01);
}

func_D369(var_00) {
  wait 2;

  for(;;) {
    wait 0.2;

    if(self.health <= 0 || getdvarint("cg_useplayerbreathsys")) {
      return;
    }
    var_01 = self.health / self.maxhealth;

    if(var_01 > self.gs.healthoverlaycutoff) {
      continue;
    }
    if(isDefined(self.func_550A) && self.func_550A) {
      continue;
    }
    if(isDefined(level.func_7684))
      [[level.func_7684]]("breathing_hurt");
    else
      self playlocalsound("breathing_hurt");

    var_02 = 0.1;

    if(isDefined(level.player.gs.func_4C82))
      var_02 = level.player.gs.func_4C82;

    wait(var_02 + randomfloat(0.8));
  }
}

func_8CBA() {
  self endon("noHealthOverlay");
  var_00 = newclienthudelem(self);
  self.func_8CAE = var_00;
  var_0.x = 0;
  var_0.y = 0;
  var_01 = "vfx_ui_player_pain_overlay";
  var_00 setshader(var_01, 640, 480);
  var_0.func_02B4 = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.enablehudlighting = 1;
  thread func_8CBB(var_00);
  childthread func_11431(var_00);
  var_02 = 0.0;
  var_03 = 0.05;
  var_04 = 0.3;

  while(isalive(self)) {
    wait(var_03);

    if(!isalive(self)) {
      break;
    }
    if(scripts\sp\utility::func_93A6()) {
      if(scripts\sp\specialist_MAYBE::func_2C97())
        var_02 = 0;
      else {
        var_04 = 0.1;
        var_05 = 1.0 - self.health / level.player.maxhealth;
        var_05 = var_05 * 1.5;
        var_06 = var_05 - var_0.alpha;
        var_07 = var_0.alpha + var_06 * var_04;
        var_02 = clamp(var_07, 0, 1);
      }
    } else if(level.player scripts\sp\utility::func_65DB("player_has_red_flashing_overlay")) {
      var_02 = 0;
      level.player scripts\sp\utility::func_65E8("player_has_red_flashing_overlay");
    } else {
      var_05 = 1.0 - self.health / level.player.maxhealth;
      var_08 = var_05 * var_05 * 1.2;
      var_08 = clamp(var_08, 0, 1);

      if(var_02 > var_08)
        var_02 = var_02 - var_04 * var_03;

      if(var_02 < var_08)
        var_02 = var_08;
    }

    if(isDefined(level.player.func_111B8) && level.player.func_111B8) {
      continue;
    }
    var_0.alpha = var_02;
  }
}

func_11431(var_00) {
  self endon("death");

  while(isalive(self)) {
    scripts\sp\utility::func_65E3("player_has_red_flashing_overlay");
    func_11430(var_00);
  }
}

func_16F1(var_00) {
  if(level.console)
    self.fontscale = 2;
  else
    self.fontscale = 1.6;

  self.x = 0;
  self.y = -36;
  self.alignx = "center";
  self.aligny = "bottom";
  self.horzalign = "center";
  self.vertalign = "middle";

  if(!isDefined(self.func_272E)) {
    return;
  }
  self.func_272E.x = 0;
  self.func_272E.y = -40;
  self.func_272E.alignx = "center";
  self.func_272E.aligny = "middle";
  self.func_272E.horzalign = "center";
  self.func_272E.vertalign = "middle";

  if(level.console)
    self.func_272E setshader("popmenu_bg", 650, 52);
  else
    self.func_272E setshader("popmenu_bg", 650, 42);

  self.func_272E.alpha = 0.5;
}

func_1383C() {
  self endon("hit_again");
  self endon("player_downed");
  self waittill("damage");
}

func_52BD(var_00) {
  var_00 endon("being_destroyed");
  func_1383C();
  var_01 = !isalive(self);
  var_00 thread func_52BC(var_01);
}

func_52BE() {
  self endon("being_destroyed");
  scripts\engine\utility::flag_wait("missionfailed");
  thread func_52BC(1);
}

func_52BC(var_00) {
  self notify("being_destroyed");
  self.func_2A88 = 1;

  if(var_00) {
    self fadeovertime(0.5);
    self.alpha = 0;
    wait 0.5;
  }

  self notify("death");
  self destroy();
}

func_B4DA(var_00) {
  if(!isDefined(var_00))
    return 0;

  if(isDefined(var_0.func_2A88))
    return 0;

  return 1;
}

func_11432() {
  if(isDefined(level.func_470F))
    return 0;

  if(isDefined(self.melee))
    return 0;

  if(isDefined(self.vehicle))
    return 0;

  return 1;
}

func_8C1D() {
  var_00 = self getweaponslist("offhand");

  foreach(var_02 in var_00) {
    if(issubstr(var_02, "offhandshield"))
      return 1;
  }

  return 0;
}

func_E34F() {
  return level.player _meth_84D0() > level.player _meth_84CF() * 0.1;
}

func_FF8B() {
  if(scripts\sp\utility::func_93A6())
    return 0;

  if(!isalive(self))
    return 0;

  if(self getteamflagcount())
    return 0;

  if(self.ignoreme)
    return 0;

  if(level.func_B8D0)
    return 0;

  if(!func_11432())
    return 0;

  if(self.func_7683 > 1 && !func_B327())
    return 0;

  if(scripts\sp\utility::func_65DB("player_retract_shield_active"))
    return 0;

  var_00 = self _meth_8139("takeCoverWarnings");

  if(var_00 <= 3)
    return 0;

  return 1;
}

func_FF89() {
  if(scripts\sp\utility::func_93A6())
    return 0;

  if(!isalive(self))
    return 0;

  if(self getteamflagcount())
    return 0;

  if(self.ignoreme)
    return 0;

  if(level.func_B8D0)
    return 0;

  if(!func_11432())
    return 0;

  if(self.func_7683 > 1 && !func_B327())
    return 0;

  var_00 = self _meth_8139("takeCoverWarnings");

  if(var_00 <= 3)
    return 0;

  return 1;
}

func_B327() {
  if(!isDefined(level.func_5FB0))
    return 1;

  if(isDefined(level.func_5FB0[level.script]))
    return level.func_5FB0[level.script];
  else
    return 0;
}

maps_with_jackal_arenas() {
  return ["phspace", "moonjackal", "sa_empambush", "sa_wounded", "sa_assassination", "titanjackal", "ja_spacestation", "ja_titan", "ja_wreckage", "ja_asteroid", "ja_mining", "heistspace"];
}

jackal_arena_is_early_in_the_game() {
  if(map_has_jackal_arena() && get_num_jackal_arenas_completed() <= 4)
    return 1;
  else
    return 0;
}

get_num_jackal_arenas_completed() {
  var_00 = 0;

  foreach(var_02 in maps_with_jackal_arenas()) {
    var_03 = level.player _meth_84C6("missionStateData", var_02);

    if(isDefined(var_03) && var_03 == "complete")
      var_0++;
  }

  return var_00;
}

map_has_jackal_arena() {
  if(scripts\engine\utility::array_contains(maps_with_jackal_arenas(), level.script))
    return 1;
  else
    return 0;
}

func_11430(var_00) {
  self endon("hit_again");
  self endon("damage");
  self endon("death");
  childthread func_DE16(var_00);

  if(level.player scripts\sp\utility::func_7B93() < 2) {
    var_01 = func_7D51();
    var_02 = [[var_01]]();
    var_03 = gettime() + self.gs.longregentime;
    func_4766(1, var_02);

    while(gettime() < var_03 && isalive(self) && scripts\sp\utility::func_65DB("player_has_red_flashing_overlay") && !scripts\sp\utility::func_65DB("player_retract_shield_active"))
      func_4766(0.9, var_02);

    if(isalive(self))
      func_4766(0.65, var_02);

    func_4766(0, var_02);
  }

  scripts\sp\utility::func_65E3("redflashoverlay_complete");
  self notify("take_cover_done");
  self notify("hit_again");
}

func_4766(var_00, var_01) {
  if(getomnvar("ui_gettocover_state") == 0 && (var_00 == 0 || var_00 == 5)) {
    return;
  }
  if(var_00 == 1) {
    if(var_01)
      setomnvar("ui_gettocover_state", 1);

    wait 0.7;
  } else if(var_00 == 0.9) {
    if(var_01)
      setomnvar("ui_gettocover_state", 2);

    wait 0.7;
  } else if(var_00 == 6.5) {
    if(var_01)
      setomnvar("ui_gettocover_state", 3);

    wait 0.65;
  } else if(var_00 == 0) {
    if(var_01 || getomnvar("ui_gettocover_state") > 0 && getomnvar("ui_gettocover_state") < 4)
      setomnvar("ui_gettocover_state", 4);

    wait 0.5;
  } else if(var_00 == 5) {
    if(var_01 || getomnvar("ui_gettocover_state") > 0 && getomnvar("ui_gettocover_state") < 5)
      setomnvar("ui_gettocover_state", 5);

    wait 0.5;
  }
}

func_DE16(var_00) {
  scripts\sp\utility::func_65DD("redflashoverlay_complete");
  var_01 = gettime() + level.player.gs.longregentime;
  func_DE15(var_00, 1, 1);

  while(gettime() < var_01 && isalive(level.player))
    func_DE15(var_00, 0.9, 1);

  if(isalive(level.player))
    func_DE15(var_00, 0.65, 0.8);

  func_DE15(var_00, 0, 0.6);
  var_00 fadeovertime(0.5);
  var_0.alpha = 0;
  wait 0.5;
  scripts\sp\utility::func_65E3("redflashoverlay_complete");
}

func_DE15(var_00, var_01, var_02) {
  var_03 = 0.8;
  var_04 = 0.5;
  var_05 = var_03 * 0.1;
  var_06 = var_03 * (0.1 + var_01 * 0.2);
  var_07 = var_03 * (0.1 + var_01 * 0.1);
  var_08 = var_03 * 0.3;
  var_09 = var_03 - var_05 - var_06 - var_07 - var_08;

  if(var_09 < 0)
    var_09 = 0;

  var_10 = 0.8 + var_01 * 0.1;
  var_11 = 0.5 + var_01 * 0.3;
  var_00 fadeovertime(var_05);
  var_0.alpha = var_02 * 1.0;
  wait(var_05 + var_06);
  var_00 fadeovertime(var_07);
  var_0.alpha = var_02 * var_10;
  wait(var_07);
  var_00 fadeovertime(var_08);
  var_0.alpha = var_02 * var_11;
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
  if(scripts\sp\utility::func_D15B("hull"))
    return level.func_A48E.func_D3BA * 1.5;
  else
    return level.func_A48E.func_D3BA;
}

func_D259() {
  scripts\sp\utility::func_65DD("player_has_red_flashing_overlay");

  if(scripts\sp\utility::func_65DB("near_death_vision_enabled")) {
    self _meth_8222();
    thread func_0B0B::func_E2BB();
  }

  self notify("take_cover_done");
}

func_8CBB(var_00) {
  self waittill("noHealthOverlay");
  var_00 destroy();
}

func_E26C() {
  waittillframeend;
  func_F848(1);
}

func_9772() {
  var_00 = isDefined(level.func_9F0B) && level.func_9F0B;

  if(self _meth_8139("takeCoverWarnings") == -1 || var_00)
    self _meth_8302("takeCoverWarnings", 9);
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

  if(var_00 < 10)
    self _meth_8302("takeCoverWarnings", var_00 + 1);
}

func_2624() {
  var_00 = self.origin;
  wait 5;

  if(func_2693(var_00))
    level.func_2641[level.func_2641.size] = var_00;
}

func_2693(var_00) {
  return distancesquared(self.origin, var_00) < 19600;
}

func_2623() {
  level.func_2641 = [];
  level.player.func_BCB6 = 1;
  wait 1;

  for(;;) {
    level.player thread func_2624();
    level.player.func_BCB6 = 1;
    var_00 = [];
    var_01 = level.func_2641.size - 5;

    if(var_01 < 0)
      var_01 = 0;

    for(var_02 = var_01; var_02 < level.func_2641.size; var_2++) {
      if(!level.player func_2693(level.func_2641[var_02])) {
        continue;
      }
      var_0[var_0.size] = level.func_2641[var_02];
      level.player.func_BCB6 = 0;
    }

    level.func_2641 = var_00;
    wait 1;
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
    if(level.player attackbuttonpressed())
      var_00 = gettime();

    level.func_118E5 = gettime() - var_00;
    wait 0.05;
  }
}

func_9138(var_00, var_01) {
  func_9137(var_00, var_01 * 100, 1);
}

func_9136(var_00, var_01) {
  func_9137(var_00, var_01, 0);
}

func_913D() {
  level.func_9184 = 0;

  if(isDefined(level.func_9177)) {
    for(var_00 = 0; var_00 < level.func_9177.size; var_0++)
      level.func_9177[var_00] destroy();
  }

  level.func_9177 = [];
}

func_9139(var_00) {
  if(!isDefined(level.func_9183))
    level.func_9183 = [];

  if(!isDefined(level.func_9183[var_00])) {
    var_01 = newhudelem();
    var_1.x = level.func_4F47;
    var_1.y = level.func_4F45 + level.func_9184 * 15;
    var_1.foreground = 1;
    var_1.sort = 100;
    var_1.alpha = 1.0;
    var_1.alignx = "left";
    var_1.horzalign = "left";
    var_1.fontscale = 1.0;
    var_01 give_zap_perk(var_00);
    level.func_9183[var_00] = 1;
  }
}

func_9137(var_00, var_01, var_02) {
  func_9139(var_00);
  var_01 = int(var_01);
  var_03 = 0;

  if(var_01 < 0) {
    var_03 = 1;
    var_01 = var_01 * -1;
  }

  var_04 = 0;
  var_05 = 0;
  var_06 = 0;

  for(var_07 = 0; var_01 >= 10000; var_01 = var_01 - 10000) {}

  while(var_01 >= 1000) {
    var_01 = var_01 - 1000;
    var_4++;
  }

  while(var_01 >= 100) {
    var_01 = var_01 - 100;
    var_5++;
  }

  while(var_01 >= 10) {
    var_01 = var_01 - 10;
    var_6++;
  }

  while(var_01 >= 1) {
    var_01 = var_01 - 1;
    var_7++;
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
  } else if(var_05 > 0 || var_02) {
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

  if(var_02) {
    var_10 = newhudelem();
    var_10.x = 204.5;
    var_10.y = level.func_4F45 + level.func_9184 * 15;
    var_10.foreground = 1;
    var_10.sort = 100;
    var_10.alpha = 1.0;
    var_10.alignx = "left";
    var_10.horzalign = "left";
    var_10.fontscale = 1.0;
    var_10 give_zap_perk(".");
    level.func_9177[level.func_9177.size] = var_10;
  }

  if(var_03) {
    var_11 = newhudelem();
    var_11.x = 195.5;
    var_11.y = level.func_4F45 + level.func_9184 * 15;
    var_11.foreground = 1;
    var_11.sort = 100;
    var_11.alpha = 1.0;
    var_11.alignx = "left";
    var_11.horzalign = "left";
    var_11.fontscale = 1.0;
    var_11 give_zap_perk(" - ");
    level.func_9177[level.func_9184] = var_11;
  }

  level.func_9184++;
}

func_913C(var_00, var_01) {
  func_9139(var_00);
  func_913B(var_01, 0);
  level.func_9184++;
}

func_913A(var_00, var_01) {
  var_02 = newhudelem();
  var_2.x = 200 + var_01 * 0.65;
  var_2.y = level.func_4F45 + level.func_9184 * 15;
  var_2.foreground = 1;
  var_2.sort = 100;
  var_2.alpha = 1.0;
  var_2.alignx = "left";
  var_2.horzalign = "left";
  var_2.fontscale = 1.0;
  var_02 give_zap_perk(var_00 + "");
  level.func_9177[level.func_9177.size] = var_02;
}

func_913B(var_00, var_01) {
  var_02 = newhudelem();
  var_2.x = 200 + var_01 * 0.65;
  var_2.y = level.func_4F45 + level.func_9184 * 15;
  var_2.foreground = 1;
  var_2.sort = 100;
  var_2.alpha = 1.0;
  var_2.alignx = "left";
  var_2.horzalign = "left";
  var_2.fontscale = 1.0;
  var_02 give_zap_perk(var_00);
  level.func_9177[level.func_9177.size] = var_02;
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
  level.func_262B = [];
  thread func_14F4();
  thread func_14F1();
  thread func_14EF();
  scripts\engine\utility::flag_set("auto_adjust_initialized");
  scripts\engine\utility::flag_init("aa_main_" + level.script);
  scripts\engine\utility::flag_set("aa_main_" + level.script);
}

func_4423(var_00) {
  var_01 = _getkeybinding(var_00);

  if(var_1["count"] <= 0)
    return 0;

  for(var_02 = 1; var_02 < var_1["count"] + 1; var_2++) {
    if(self buttonpressed(var_1["key" + var_02]))
      return 1;
  }

  return 0;
}

func_14F4() {
  waittillframeend;

  for(;;)
    wait 0.2;
}

func_14EF() {
  level.player endon("death");
  level.func_CF4B = 0;

  for(;;) {
    if(level.player scripts\sp\utility::func_9D27()) {
      level.func_CF4B = gettime();

      while(level.player scripts\sp\utility::func_9D27())
        wait 0.05;

      continue;
    }

    wait 0.05;
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

func_262A(var_00) {
  if(!isDefined(level.func_2629))
    level.func_2629 = [];

  scripts\engine\utility::flag_wait("auto_adjust_initialized");
  level.func_262B[var_00] = [];
  level.func_2629[var_00] = 0;
  scripts\engine\utility::flag_wait(var_00);

  if(getdvar("aa_zone" + var_00) == "") {
    setdvar("aa_zone" + var_00, "on");
    level.func_2629[var_00] = 1;
    func_14F5();
    setdvar("start_time" + var_00, getdvar("aa_time_tracking"));
    setdvar("starting_player_kills" + var_00, getdvar("aa_player_kills"));
    setdvar("starting_deaths" + var_00, getdvar("aa_deaths"));
    setdvar("starting_ads_damage_dealt" + var_00, getdvar("aa_ads_damage_dealt"));
    setdvar("starting_player_damage_dealt" + var_00, getdvar("aa_player_damage_dealt"));
    setdvar("starting_player_damage_taken" + var_00, getdvar("aa_player_damage_taken"));
    setdvar("starting_enemy_damage_taken" + var_00, getdvar("aa_enemy_damage_taken"));
    setdvar("starting_enemy_deaths" + var_00, getdvar("aa_enemy_deaths"));
  } else if(getdvar("aa_zone" + var_00) == "done") {
    return;
  }
  scripts\engine\utility::flag_waitopen(var_00);
  func_262C(var_00);
}

func_262C(var_00) {
    setdvar("aa_zone" + var_00, "done");
    var_01 = getdvarfloat("start_time" + var_00);
    var_02 = getdvarint("starting_player_kills" + var_00);
    var_03 = getdvarint("aa_enemy_deaths" + var_00);
    var_04 = getdvarint("aa_enemy_damage_taken" + var_00);
    var_05 = getdvarint("aa_player_damage_taken" + var_00);
    var_06 = getdvarint("aa_player_damage_dealt" + var_00);
    var_07 = getdvarint("aa_ads_damage_dealt" + var_00);
    var_08 = getdvarint("aa_deaths" + var_00);
    level.func_2629[var_00] = 0;
    func_14F5();
    var_09 = getdvarfloat("aa_time_tracking") - var_01;
    var_10 = getdvarint("aa_player_kills") - var_02;
    var_11 = getdvarint("aa_enemy_deaths") - var_03;
    var_12 = 0;

    if(var_11 > 0) {
      var_12 = var_10 / var_11;
      var_12 = var_12 * 100;
      var_12 = int(var_12);
    }

    var_13 = getdvarint("aa_enemy_damage_taken") - var_04;
    var_14 = getdvarint("aa_player_damage_dealt") - var_06;
    var_15 = 0;
    var_16 = 0;

    if(var_13 > 0 && var_09 > 0) {
      var_15 = var_14 / var_13;
      var_15 = var_15 * 100;
      var_15 = int(var_15);
      var_16 = var_14 / var_09;
      var_16 = var_16 * 60;
      var_16 = int(var_16);
    }

    var_17 = getdvarint("aa_ads_damage_dealt") - var_07;
    var_18 = 0;

    if(var_14 > 0) {
      var_18 = var_17 / var_14;
      var_18 = var_18 * 100;
      var_18 = int(var_18);
    }

    var_19 = getdvarint("aa_player_damage_taken") - var_05;
    var_20 = 0;

    if(var_09 > 0)
      var_20 = var_19 / var_09;

    var_21 = var_20 * 60;
    var_21 = int(var_21);
    var_22 = getdvarint("aa_deaths") - var_08;
    var_23 = [];
    var_23["player_damage_taken_per_minute"] = var_21;
    var_23["player_damage_dealt_per_minute"] = var_16;
    var_23["minutes"] = var_09 / 60;
    var_23["deaths"] = var_22;
    var_23["gameskill"] = level.func_7683;
    level.func_262B[var_00] = var_23;
    var_24 = "Completed AA sequence: ";
    var_24 = var_24 + (level.script + "\" + var_00);
      var_25 = getarraykeys(var_23);

      for(var_26 = 0; var_26 < var_25.size; var_26++)
        var_24 = var_24 + ", " + var_25[var_26] + ": " + var_23[var_25[var_26]];

      logstring(var_24);
    }

    func_14F2(var_00, var_01) {
      logstring(var_00 + ": " + var_1[var_00]);
    }

    func_14F5() {}

    func_14DB(var_00, var_01) {
      var_02 = getdvarint(var_00);
      setdvar(var_00, var_02 + var_01);
    }

    func_14DC(var_00, var_01) {
      var_02 = getdvarfloat(var_00);
      setdvar(var_00, var_02 + var_01);
    }

    func_E44D(var_00) {
      return 0;
    }

    func_CF80(var_00) {
      if([
          [level.func_4C6B]
        ](var_00))
        return 1;

      if(isplayer(var_00))
        return 1;

      if(!isDefined(var_0.func_3A49))
        return 0;

      return var_00 func_D021();
    }

    func_D021() {
      return self.func_CFED * 1.75 > self.func_C078;
    }

    func_61BA(var_00, var_01, var_02) {}

    func_2628(var_00, var_01, var_02, var_03) {
      func_14DB("aa_enemy_deaths", 1);

      if(!isDefined(var_01)) {
        return;
      }
      if(!func_CF80(var_01)) {
        return;
      }
      [
        [level.vehicle_canturrettargetpoint]
      ](var_02, self.damagelocation, var_03);
      func_14DB("aa_player_kills", 1);
    }

    func_2627(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
      if(!isalive(self) || self.delayeddeath) {
        func_2628(var_00, var_01, var_04, var_03);
        return;
      }

      if(!func_CF80(var_01)) {
        return;
      }
      func_14F0(var_00, var_04, var_03);
    }

    func_14F0(var_00, var_01, var_02) {
      func_14DB("aa_player_damage_dealt", var_00);

      if(!level.player scripts\sp\utility::func_9D27()) {
        [
          [level._meth_83D3]
        ](var_01, self.damagelocation, var_02);
        return 0;
      }

      if(!func_3234(var_01)) {
        [
          [level._meth_83D3]
        ](var_01, self.damagelocation, var_02);
        return 0;
      }

      [
        [level._meth_83D4]
      ](var_01, self.damagelocation, var_02);
      func_14DB("aa_ads_damage_dealt", var_00);
      return 1;
    }

    func_3234(var_00) {
      if(var_00 == "MOD_PISTOL_BULLET")
        return 1;

      return var_00 == "MOD_RIFLE_BULLET";
    }

    func_16D9(var_00, var_01, var_02) {
      if(!isDefined(level.func_54D1[var_00]))
        level.func_54D1[var_00] = [];

      var_03 = [];
      var_3["frac"] = var_01;
      var_3["val"] = var_02;
      level.func_54D1[var_00][level.func_54D1[var_00].size] = var_03;
    }

    func_F385() {
      level.func_5FB0 = [];
      level.func_5FB0["europa"] = 1;
      level.func_5FB0["phparade"] = 1;
      level.func_5FB0["phstreets"] = 1;
      level.func_5FB0["phspace"] = 1;
      level.func_5FB0["shipcrib_moon"] = 1;
      level.func_5FB0["moon_port"] = 1;
      level.func_5FB0["moonjackal"] = 1;
      level.func_5FB0["sa_moon"] = 1;
    }

    func_E080() {
      level notify("screenfx_force_delete");
      level.player notify("noHealthOverlay");
      level.player.func_550A = 1;
      level.player func_D259();
      level.player.func_550A = 0;
    }

    func_13062() {
      return level.func_13062;
    }

    func_1305F() {
      return level.func_1305F;
    }

    func_1305E() {
      return level.func_1305E;
    }

    func_13069() {
      return level.func_13069;
    }

    func_12855(var_00) {
      level.player endon("weapon_change");
      wait 10;

      if(scripts\engine\utility::flag("disable_weapon_help")) {
        return;
      }
      if(!level.player _meth_843C()) {
        return;
      }
      if(level.player getteamflagcount()) {
        return;
      }
      if(scripts\engine\utility::player_is_in_jackal()) {
        return;
      }
      if(scripts\sp\utility::func_65DF("_stealth_enabled") && scripts\sp\utility::func_65DB("_stealth_enabled")) {
        return;
      }
      if(isDefined(level.func_4B80) && level.func_4B80) {
        return;
      }
      if(isDefined(self.melee)) {
        return;
      }
      if(level.script == "phstreets" || level.script == "europa") {
        return;
      }
      if(isDefined(level.player.func_9E1C) && level.player.func_9E1C) {
        return;
      }
      scripts\sp\utility::func_56BE(var_00, 6);
    }

    func_13C1A() {
      level endon("stop_weapon_help");
      scripts\engine\utility::flag_init("disable_weapon_help");
      scripts\sp\utility::func_16EB("alt_m8", & "WEAPON_HELP_M8_AR_DPAD", ::func_13062);
      scripts\sp\utility::func_16EB("alt_fmg", & "WEAPON_HELP_FMG_AKIMBO_DPAD", ::func_1305F);
      scripts\sp\utility::func_16EB("alt_erad", & "WEAPON_HELP_ERAD_SHOTGUN_DPAD", ::func_1305E);
      scripts\sp\utility::func_16EB("alt_ripper", & "WEAPON_HELP_RIPPER_SMG_DPAD", ::func_13069);
      wait 30;
      var_00 = scripts\sp\endmission::func_7F6B(level.script);

      if(!isDefined(var_00)) {
        return;
      }
      if(scripts\sp\endmission::getitemslot(var_00))
        return;
      else if(scripts\sp\endmission::getitemdroporiginandangles(var_00))
        return;
      else if(scripts\sp\utility::func_93A6())
        return;
      else if(level.func_7683 >= 2 && !func_B327()) {
        return;
      }
      level.func_13062 = 1;
      level.func_1305F = 1;
      level.func_1305E = 1;
      level.func_13069 = 1;
      var_01 = level.player _meth_84C6("hintAltM8");
      var_02 = level.player _meth_84C6("hintAltFMG");
      var_03 = level.player _meth_84C6("hintAltERAD");
      var_04 = level.player _meth_84C6("hintAltRipper");

      if(isDefined(var_01))
        level.func_13062 = var_01;

      if(isDefined(var_02))
        level.func_1305F = var_02;

      if(isDefined(var_03))
        level.func_1305E = var_03;

      if(isDefined(var_04))
        level.func_13069 = var_04;

      var_05 = 0;

      if(level.func_13062)
        var_5++;

      if(level.func_1305F)
        var_5++;

      if(level.func_1305E)
        var_5++;

      if(level.func_13069)
        var_5++;

      wait 300;

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
              if(!level.func_13062) {
                level.player _meth_84C7("hintAltM8", 1);
                level.func_13062 = 1;
                var_5++;
              }
            } else
              var_09 = "alt_m8";

            break;
          case "iw7_fmg":
            if(var_07) {
              if(!level.func_1305F) {
                level.player _meth_84C7("hintAltFMG", 1);
                level.func_1305F = 1;
                var_5++;
              }
            } else
              var_09 = "alt_fmg";

            break;
          case "iw7_erad":
            if(var_07) {
              if(!level.func_1305E) {
                level.player _meth_84C7("hintAltERAD", 1);
                level.func_1305E = 1;
                var_5++;
              }
            } else
              var_09 = "alt_erad";

            break;
          case "iw7_ripper":
            if(var_07) {
              if(!level.func_13069) {
                level.player _meth_84C7("hintAltRipper", 1);
                level.func_13069 = 1;
                var_5++;
              }
            } else
              var_09 = "alt_ripper";

            break;
          default:
            continue;
        }

        if(var_09 != "")
          thread func_12855(var_09);
      }
    }