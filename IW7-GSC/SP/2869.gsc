/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2869.gsc
**************************************/

_id_95F9() {
  if(!scripts\engine\utility::add_init_script("gameskill", ::_id_95F9)) {
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
  _id_0B5F::_id_965A();
  _id_F385();
  thread _id_14ED();
  _id_F848();
  level thread _id_13C1A();
}

_id_F848(var_0) {
  if(!isDefined(level.script))
    level.script = tolower(getDvar("mapname"));

  if(!isDefined(var_0) || var_0 == 0) {
    if(isDefined(level._id_7683)) {
      return;
    }
    if(!isDefined(level._id_4C6B))
      level._id_4C6B = ::_id_E44D;

    level._id_83D4 = ::_id_61BA;
    level._id_83D3 = ::_id_61BA;
    level._id_83D9 = ::_id_61BA;
    scripts\sp\utility::_id_F305();

    foreach(var_2 in level.players) {
      var_2 scripts\sp\utility::_id_65E0("player_has_red_flashing_overlay");
      var_2 scripts\sp\utility::_id_65E0("player_is_invulnerable");
      var_2 scripts\sp\utility::_id_65E0("player_zero_attacker_accuracy");
      var_2 scripts\sp\utility::_id_65E0("player_no_auto_blur");
      var_2 scripts\sp\utility::_id_65E0("redflashoverlay_complete");
      var_2 scripts\sp\utility::_id_65E0("near_death_vision_enabled");
      var_2 scripts\sp\utility::_id_65E1("near_death_vision_enabled");
      var_2.gs = spawnStruct();
      var_2.gs._id_B639 = spawnStruct();
      var_2 _id_9723();
      var_2.a = spawnStruct();
      var_2._id_4CF5 = [];
      var_2 scripts\sp\player_stats::_id_9768();
      var_2 scripts\sp\utility::_id_65E0("global_hint_in_use");
      var_2.pers = [];

      if(!isDefined(var_2._id_28A4))
        var_2._id_28A4 = 0;

      var_2.disabledweapon = 0;
      var_2.disabledweaponswitch = 0;
      var_2.disabledusability = 0;
      var_2 _meth_831C("frag");
    }

    level._id_54D3[0] = "easy";
    level._id_54D3[1] = "normal";
    level._id_54D3[2] = "hardened";
    level._id_54D3[3] = "veteran";
    level._id_54D2["easy"] = &"GAMESKILL_EASY";
    level._id_54D2["normal"] = &"GAMESKILL_NORMAL";
    level._id_54D2["hardened"] = &"GAMESKILL_HARDENED";
    level._id_54D2["veteran"] = &"GAMESKILL_VETERAN";
    thread _id_7685();
  }

  setdvarifuninitialized("autodifficulty_playerDeathTimer", 0);
  anim._id_E7D4 = 0.5;
  anim._id_1385F = 0.8;
  setDvar("autodifficulty_frac", 0);
  level._id_54D1 = [];

  foreach(var_2 in level.players) {
    var_2 _id_9772();
    var_2 thread _id_93F7();
  }

  level._id_B6AD = 8;
  level._id_B6AC = 16;
  level._id_54D0["playerGrenadeBaseTime"]["easy"] = 40000;
  level._id_54D0["playerGrenadeBaseTime"]["normal"] = 35000;
  level._id_54D0["playerGrenadeBaseTime"]["hardened"] = 25000;
  level._id_54D0["playerGrenadeBaseTime"]["veteran"] = 25000;
  level._id_54D0["playerGrenadeRangeTime"]["easy"] = 20000;
  level._id_54D0["playerGrenadeRangeTime"]["normal"] = 15000;
  level._id_54D0["playerGrenadeRangeTime"]["hardened"] = 10000;
  level._id_54D0["playerGrenadeRangeTime"]["veteran"] = 10000;
  level._id_54D0["playerDoubleGrenadeTime"]["easy"] = 3600000;
  level._id_54D0["playerDoubleGrenadeTime"]["normal"] = 150000;
  level._id_54D0["playerDoubleGrenadeTime"]["hardened"] = 90000;
  level._id_54D0["playerDoubleGrenadeTime"]["veteran"] = 90000;
  level._id_54D0["double_grenades_allowed"]["easy"] = 0;
  level._id_54D0["double_grenades_allowed"]["normal"] = 1;
  level._id_54D0["double_grenades_allowed"]["hardened"] = 1;
  level._id_54D0["double_grenades_allowed"]["veteran"] = 1;
  level._id_54D0["threatbias"]["easy"] = 100;
  level._id_54D0["threatbias"]["normal"] = 150;
  level._id_54D0["threatbias"]["hardened"] = 200;
  level._id_54D0["threatbias"]["veteran"] = 400;
  level._id_54D0["base_enemy_accuracy"]["easy"] = 0.9;
  level._id_54D0["base_enemy_accuracy"]["normal"] = 1.0;
  level._id_54D0["base_enemy_accuracy"]["hardened"] = 1.15;
  level._id_54D0["base_enemy_accuracy"]["veteran"] = 1.15;
  level._id_54D0["accuracyDistScale"]["easy"] = 1.0;
  level._id_54D0["accuracyDistScale"]["normal"] = 1.0;
  level._id_54D0["accuracyDistScale"]["hardened"] = 0.6;
  level._id_54D0["accuracyDistScale"]["veteran"] = 0.8;
  level._id_54D0["min_sniper_burst_delay_time"]["easy"] = 3.0;
  level._id_54D0["min_sniper_burst_delay_time"]["normal"] = 2.0;
  level._id_54D0["min_sniper_burst_delay_time"]["hardened"] = 1.5;
  level._id_54D0["min_sniper_burst_delay_time"]["veteran"] = 1.1;
  level._id_54D0["sniper_converge_scale"]["easy"] = 1.3;
  level._id_54D0["sniper_converge_scale"]["normal"] = 1.1;
  level._id_54D0["sniper_converge_scale"]["hardened"] = 0.9;
  level._id_54D0["sniper_converge_scale"]["veteran"] = 0.7;
  level._id_54D0["sniperAccuDiffScale"]["easy"] = 1.0;
  level._id_54D0["sniperAccuDiffScale"]["normal"] = 1.6;
  level._id_54D0["sniperAccuDiffScale"]["hardened"] = 1.6;
  level._id_54D0["sniperAccuDiffScale"]["veteran"] = 1.9;
  level._id_54D0["max_sniper_burst_delay_time"]["easy"] = 4.0;
  level._id_54D0["max_sniper_burst_delay_time"]["normal"] = 3.0;
  level._id_54D0["max_sniper_burst_delay_time"]["hardened"] = 2.0;
  level._id_54D0["max_sniper_burst_delay_time"]["veteran"] = 1.5;
  level._id_54D0["c6_TorsoDamageDismemberLimbChance"]["easy"] = 70;
  level._id_54D0["c6_TorsoDamageDismemberLimbChance"]["normal"] = 40;
  level._id_54D0["c6_TorsoDamageDismemberLimbChance"]["hardened"] = 30;
  level._id_54D0["c6_TorsoDamageDismemberLimbChance"]["veteran"] = 20;
  level._id_54D0["pain_test"]["easy"] = ::_id_1D5A;
  level._id_54D0["pain_test"]["normal"] = ::_id_1D5A;
  level._id_54D0["pain_test"]["hardened"] = ::_id_C868;
  level._id_54D0["pain_test"]["veteran"] = ::_id_C868;
  level._id_54D0["missTimeConstant"]["easy"] = 1.0;
  level._id_54D0["missTimeConstant"]["normal"] = 0.05;
  level._id_54D0["missTimeConstant"]["hardened"] = 0;
  level._id_54D0["missTimeConstant"]["veteran"] = 0;
  level._id_54D0["missTimeDistanceFactor"]["easy"] = 0.0008;
  level._id_54D0["missTimeDistanceFactor"]["normal"] = 0.0001;
  level._id_54D0["missTimeDistanceFactor"]["hardened"] = 0.00005;
  level._id_54D0["missTimeDistanceFactor"]["veteran"] = 0;
  level._id_54D0["flashbangedInvulFactor"]["easy"] = 0.25;
  level._id_54D0["flashbangedInvulFactor"]["normal"] = 0;
  level._id_54D0["flashbangedInvulFactor"]["hardened"] = 0;
  level._id_54D0["flashbangedInvulFactor"]["veteran"] = 0;
  level._id_54D0["player_criticalBulletDamageDist"]["easy"] = 0;
  level._id_54D0["player_criticalBulletDamageDist"]["normal"] = 0;
  level._id_54D0["player_criticalBulletDamageDist"]["hardened"] = 0;
  level._id_54D0["player_criticalBulletDamageDist"]["veteran"] = 0;
  level._id_54D0["player_deathInvulnerableTime"]["easy"] = 4000;
  level._id_54D0["player_deathInvulnerableTime"]["normal"] = 2500;
  level._id_54D0["player_deathInvulnerableTime"]["hardened"] = 600;
  level._id_54D0["player_deathInvulnerableTime"]["veteran"] = 100;
  level._id_54D0["invulTime_preShield"]["easy"] = 0.6;
  level._id_54D0["invulTime_preShield"]["normal"] = 0.5;
  level._id_54D0["invulTime_preShield"]["hardened"] = 0.3;
  level._id_54D0["invulTime_preShield"]["veteran"] = 0.0;
  level._id_54D0["invulTime_onShield"]["easy"] = 1.6;
  level._id_54D0["invulTime_onShield"]["normal"] = 1.0;
  level._id_54D0["invulTime_onShield"]["hardened"] = 0.5;
  level._id_54D0["invulTime_onShield"]["veteran"] = 0.25;
  level._id_54D0["invulTime_postShield"]["easy"] = 0.5;
  level._id_54D0["invulTime_postShield"]["normal"] = 0.4;
  level._id_54D0["invulTime_postShield"]["hardened"] = 0.3;
  level._id_54D0["invulTime_postShield"]["veteran"] = 0.0;
  level._id_54D0["playerHealth_RegularRegenDelay"]["easy"] = 4000;
  level._id_54D0["playerHealth_RegularRegenDelay"]["normal"] = 4000;
  level._id_54D0["playerHealth_RegularRegenDelay"]["hardened"] = 3000;
  level._id_54D0["playerHealth_RegularRegenDelay"]["veteran"] = 1200;
  level._id_54D0["regularRegenDelayScalar"] = 1.0;
  level._id_54D0["worthyDamageRatio"]["easy"] = 0.0;
  level._id_54D0["worthyDamageRatio"]["normal"] = 0.1;
  level._id_54D0["worthyDamageRatio"]["hardened"] = 0.3;
  level._id_54D0["worthyDamageRatio"]["veteran"] = 0.3;
  level._id_54D0["playerDifficultyHealth"]["easy"] = 475;
  level._id_54D0["playerDifficultyHealth"]["normal"] = 275;
  level._id_54D0["playerDifficultyHealth"]["hardened"] = 165;
  level._id_54D0["playerDifficultyHealth"]["veteran"] = 115;
  level._id_54D0["longRegenTime"]["easy"] = 5000;
  level._id_54D0["longRegenTime"]["normal"] = 5000;
  level._id_54D0["longRegenTime"]["hardened"] = 3200;
  level._id_54D0["longRegenTime"]["veteran"] = 3200;
  level._id_54D0["longRegenTimeScalar"] = 1.0;
  level._id_54D0["healthOverlayCutoff"]["easy"] = 0.02;
  level._id_54D0["healthOverlayCutoff"]["normal"] = 0.02;
  level._id_54D0["healthOverlayCutoff"]["hardened"] = 0.02;
  level._id_54D0["healthOverlayCutoff"]["veteran"] = 0.02;
  level._id_54D0["health_regenRate"]["easy"] = 0.02;
  level._id_54D0["health_regenRate"]["normal"] = 0.02;
  level._id_54D0["health_regenRate"]["hardened"] = 0.02;
  level._id_54D0["health_regenRate"]["veteran"] = 0.02;
  level._id_54D0["explosivePlantTime"]["easy"] = 10;
  level._id_54D0["explosivePlantTime"]["normal"] = 10;
  level._id_54D0["explosivePlantTime"]["hardened"] = 5;
  level._id_54D0["explosivePlantTime"]["veteran"] = 5;
  level._id_54D0["player_downed_buffer_time"]["normal"] = 2;
  level._id_54D0["player_downed_buffer_time"]["hardened"] = 1.5;
  level._id_54D0["player_downed_buffer_time"]["veteran"] = 0;
  level._id_54D0["c12_RocketTellHoldTime"]["easy"] = 1.5;
  level._id_54D0["c12_RocketTellHoldTime"]["normal"] = 1;
  level._id_54D0["c12_RocketTellHoldTime"]["hardened"] = 0.5;
  level._id_54D0["c12_RocketTellHoldTime"]["veteran"] = 0;
  level._id_54D0["c12_DismemberRecoveryTime"]["easy"] = 9;
  level._id_54D0["c12_DismemberRecoveryTime"]["normal"] = 6;
  level._id_54D0["c12_DismemberRecoveryTime"]["hardened"] = 3;
  level._id_54D0["c12_DismemberRecoveryTime"]["veteran"] = 0;
  level._id_54D0["c12_MinigunStruggleDamage"]["easy"] = 15.5;
  level._id_54D0["c12_MinigunStruggleDamage"]["normal"] = 16;
  level._id_54D0["c12_MinigunStruggleDamage"]["hardened"] = 20;
  level._id_54D0["c12_MinigunStruggleDamage"]["veteran"] = 30;
  level._id_54D0["playerJackalHealth"]["easy"] = 5500;
  level._id_54D0["playerJackalHealth"]["normal"] = 4000;
  level._id_54D0["playerJackalHealth"]["hardened"] = 2400;
  level._id_54D0["playerJackalHealth"]["veteran"] = 1600;
  level._id_54D0["playerJackalBaseAimAssist"]["easy"] = 1.5;
  level._id_54D0["playerJackalBaseAimAssist"]["normal"] = 1.0;
  level._id_54D0["playerJackalBaseAimAssist"]["hardened"] = 1.0;
  level._id_54D0["playerJackalBaseAimAssist"]["veteran"] = 1.0;
  level._id_54D0["playerJackalInvulnerableTime"]["easy"] = 6500;
  level._id_54D0["playerJackalInvulnerableTime"]["normal"] = 4500;
  level._id_54D0["playerJackalInvulnerableTime"]["hardened"] = 2000;
  level._id_54D0["playerJackalInvulnerableTime"]["veteran"] = 500;
  level._id_54D0["playerJackalRegularRegenDelay"]["easy"] = 3000;
  level._id_54D0["playerJackalRegularRegenDelay"]["normal"] = 3000;
  level._id_54D0["playerJackalRegularRegenDelay"]["hardened"] = 1000;
  level._id_54D0["playerJackalRegularRegenDelay"]["veteran"] = 1000;
  level._id_54D0["playerJackalLongRegenDelay"]["easy"] = 4000;
  level._id_54D0["playerJackalLongRegenDelay"]["normal"] = 4000;
  level._id_54D0["playerJackalLongRegenDelay"]["hardened"] = 2000;
  level._id_54D0["playerJackalLongRegenDelay"]["veteran"] = 2000;
  level._id_54D0["playerJackalHealthRegenRate"]["easy"] = 70;
  level._id_54D0["playerJackalHealthRegenRate"]["normal"] = 30;
  level._id_54D0["playerJackalHealthRegenRate"]["hardened"] = 20;
  level._id_54D0["playerJackalHealthRegenRate"]["veteran"] = 10;
  level._id_54D0["playerJackalImpactDamageScale"]["easy"] = 0.5;
  level._id_54D0["playerJackalImpactDamageScale"]["normal"] = 1;
  level._id_54D0["playerJackalImpactDamageScale"]["hardened"] = 1;
  level._id_54D0["playerJackalImpactDamageScale"]["veteran"] = 1.2;
  level._id_54D0["JackalHoverheatRampTime"]["easy"] = 20000;
  level._id_54D0["JackalHoverheatRampTime"]["normal"] = 20000;
  level._id_54D0["JackalHoverheatRampTime"]["hardened"] = 15000;
  level._id_54D0["JackalHoverheatRampTime"]["veteran"] = 10000;
  level._id_54D0["JackalHoverheatMaxEnemies"]["easy"] = 5;
  level._id_54D0["JackalHoverheatMaxEnemies"]["normal"] = 6;
  level._id_54D0["JackalHoverheatMaxEnemies"]["hardened"] = 7;
  level._id_54D0["JackalHoverheatMaxEnemies"]["veteran"] = 8;
  level._id_54D0["JackalAttackercountMaxScalar"]["easy"] = 0.5;
  level._id_54D0["JackalAttackercountMaxScalar"]["normal"] = 0.7;
  level._id_54D0["JackalAttackercountMaxScalar"]["hardened"] = 0.8;
  level._id_54D0["JackalAttackercountMaxScalar"]["veteran"] = 0.9;
  level._id_54D0["JackalAttackercountMax"]["easy"] = 3;
  level._id_54D0["JackalAttackercountMax"]["normal"] = 4;
  level._id_54D0["JackalAttackercountMax"]["hardened"] = 5;
  level._id_54D0["JackalAttackercountMax"]["veteran"] = 5;
  level._id_54D0["JackalAccuracyPerSecond"]["easy"] = 0.2;
  level._id_54D0["JackalAccuracyPerSecond"]["normal"] = 0.3;
  level._id_54D0["JackalAccuracyPerSecond"]["hardened"] = 0.6;
  level._id_54D0["JackalAccuracyPerSecond"]["veteran"] = 0.9;
  level._id_54D0["JackalLockingBoostEscapeScale"]["easy"] = 4;
  level._id_54D0["JackalLockingBoostEscapeScale"]["normal"] = 3;
  level._id_54D0["JackalLockingBoostEscapeScale"]["hardened"] = 2;
  level._id_54D0["JackalLockingBoostEscapeScale"]["veteran"] = 1;
  level._id_54D0["JackalLockedBoostEscapeScale"]["easy"] = 6;
  level._id_54D0["JackalLockedBoostEscapeScale"]["normal"] = 4;
  level._id_54D0["JackalLockedBoostEscapeScale"]["hardened"] = 2;
  level._id_54D0["JackalLockedBoostEscapeScale"]["veteran"] = 1;
  level._id_54D0["JackalLockedTurnEscapeScale"]["easy"] = 2;
  level._id_54D0["JackalLockedTurnEscapeScale"]["normal"] = 1.5;
  level._id_54D0["JackalLockedTurnEscapeScale"]["hardened"] = 1.1;
  level._id_54D0["JackalLockedTurnEscapeScale"]["veteran"] = 1;
  level._id_54D0["JackalTargetAidMinTime"]["easy"] = 2;
  level._id_54D0["JackalTargetAidMinTime"]["normal"] = 2;
  level._id_54D0["JackalTargetAidMinTime"]["hardened"] = 2;
  level._id_54D0["JackalTargetAidMinTime"]["veteran"] = 2;
  level._id_54D0["JackalTargetAidMaxTime"]["easy"] = 3;
  level._id_54D0["JackalTargetAidMaxTime"]["normal"] = 3;
  level._id_54D0["JackalTargetAidMaxTime"]["hardened"] = 3;
  level._id_54D0["JackalTargetAidMaxTime"]["veteran"] = 3;
  level._id_54D0["JackalIncomingMissileSpeedScale"]["easy"] = 0.54;
  level._id_54D0["JackalIncomingMissileSpeedScale"]["normal"] = 1;
  level._id_54D0["JackalIncomingMissileSpeedScale"]["hardened"] = 1.35;
  level._id_54D0["JackalIncomingMissileSpeedScale"]["veteran"] = 1.75;
  level._id_54D0["JackallockonEnemyShowdownAccuracy"]["easy"] = 0.5;
  level._id_54D0["JackallockonEnemyShowdownAccuracy"]["normal"] = 0.75;
  level._id_54D0["JackallockonEnemyShowdownAccuracy"]["hardened"] = 0.9;
  level._id_54D0["JackallockonEnemyShowdownAccuracy"]["veteran"] = 1;
  level._id_54D0["CapShipMiniflakThresholdMin"]["easy"] = -0.85;
  level._id_54D0["CapShipMiniflakThresholdMin"]["normal"] = -0.8;
  level._id_54D0["CapShipMiniflakThresholdMin"]["hardened"] = -0.78;
  level._id_54D0["CapShipMiniflakThresholdMin"]["veteran"] = -0.75;
  level._id_54D0["CapShipMiniflakThresholdMax"]["easy"] = -0.4;
  level._id_54D0["CapShipMiniflakThresholdMax"]["normal"] = -0.35;
  level._id_54D0["CapShipMiniflakThresholdMax"]["hardened"] = -0.34;
  level._id_54D0["CapShipMiniflakThresholdMax"]["veteran"] = -0.33;
  level._id_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["easy"] = -0.75;
  level._id_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["normal"] = -0.7;
  level._id_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["hardened"] = -0.68;
  level._id_54D0["CapShipMiniflakThresholdHyperAggressiveMin"]["veteran"] = -0.66;
  level._id_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["easy"] = -0.32;
  level._id_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["normal"] = -0.28;
  level._id_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["hardened"] = -0.27;
  level._id_54D0["CapShipMiniflakThresholdHyperAggressiveMax"]["veteran"] = -0.26;
  level._id_54D0["AjaxEngineHealthmod"]["easy"] = 0.8;
  level._id_54D0["AjaxEngineHealthmod"]["normal"] = 1;
  level._id_54D0["AjaxEngineHealthmod"]["hardened"] = 1.2;
  level._id_54D0["AjaxEngineHealthmod"]["veteran"] = 1.4;
  level._id_54D0["CapitalshipTurretHealthmod"]["easy"] = 0.8;
  level._id_54D0["CapitalshipTurretHealthmod"]["normal"] = 1;
  level._id_54D0["CapitalshipTurretHealthmod"]["hardened"] = 1.3;
  level._id_54D0["CapitalshipTurretHealthmod"]["veteran"] = 1.6;

  if(scripts\sp\utility::_id_93A6()) {
    level._id_54D0["player_deathInvulnerableTime"]["hardened"] = 1;
    level._id_54D0["worthyDamageRatio"]["hardened"] = 1;
    level._id_54D0["invulTime_preShield"]["hardened"] = 0;
    level._id_54D0["invulTime_onShield"]["hardened"] = 0;
    level._id_54D0["invulTime_postShield"]["hardened"] = 0;
    level._id_54D0["playerDifficultyHealth"]["hardened"] = 190;
    level._id_54D0["playerJackalBaseAimAssist"]["hardened"] = 1.5;
    level._id_54D0["JackalHoverheatMaxEnemies"]["hardened"] = 2;
  }

  level._id_A9D0 = 0;
  level.playermeleedamagemultiplier_dvar = 0.8;
  setsaveddvar("player_meleeDamageMultiplier", level.playermeleedamagemultiplier_dvar);

  if(isDefined(level._id_4C53))
    [[level._id_4C53]]();

  updategameskill();
  _id_12E5A();
  setDvar("autodifficulty_original_setting", level._id_7683);
}

_id_F52D(var_0, var_1) {
  level._id_54D0["regularRegenDelayScalar"] = var_0;
  level._id_54D0["longRegenTimeScalar"] = var_1;
}

_id_9723() {
  self.gs._id_ECCC = [];
  var_0 = ["bottom", "left", "right"];
  var_1 = ["bloodsplat", "dirt"];

  foreach(var_3 in var_1) {
    foreach(var_5 in var_0) {
      self.gs._id_ECCC[var_3][var_5] = 0;
      self.gs._id_ECCC[var_3 + "_count"][var_5] = 0;
    }
  }
}

_id_12E5A() {
  _id_F725();
  _id_F761();

  for(var_0 = 0; var_0 < level.players.size; var_0++)
    level.players[var_0] _id_F6C3();
}

_id_F6C3() {
  _id_F355();
}

_id_F725() {
  var_0 = ::_id_7AAF;
  var_1 = _id_7C6D(level._id_7683);
  anim._id_C86F = level._id_54D0["pain_test"][var_1];
  level._id_6A04 = level._id_54D0["explosivePlantTime"][var_1];
  anim._id_B750 = [[var_0]]("min_sniper_burst_delay_time", level._id_7683);
  anim._id_B461 = [[var_0]]("max_sniper_burst_delay_time", level._id_7683);
  setsaveddvar("ai_accuracyDistScale", [[var_0]]("accuracyDistScale", level._id_7683));
  _id_F679();
  anim._id_3546 = level._id_54D0["c12_DismemberRecoveryTime"][var_1];
  anim._id_35EC = level._id_54D0["c12_RocketTellHoldTime"][var_1];
  anim._id_35C6 = level._id_54D0["c12_MinigunStruggleDamage"][var_1];
  anim._id_33BB = level._id_54D0["c6_TorsoDamageDismemberLimbChance"][var_1];
  scripts\sp\mgturret::_id_F6C3();
}

_id_F761() {
  if(!isDefined(level._id_A48E))
    level._id_A48E = spawnStruct();

  if(scripts\sp\utility::_id_93A6()) {
    var_0 = "veteran";
    level._id_A48E._id_A3FB = level._id_54D0["JackalIncomingMissileSpeedScale"]["hardened"];
  } else {
    var_0 = _id_7C6D(level._id_7683);
    level._id_A48E._id_A3FB = level._id_54D0["JackalIncomingMissileSpeedScale"][var_0];
  }

  level._id_A48E._id_D3BA = level._id_54D0["playerJackalHealth"][var_0];
  level._id_A48E._id_D3BD = level._id_54D0["playerJackalInvulnerableTime"][var_0];
  level._id_A48E._id_D3B9 = level._id_54D0["playerJackalBaseAimAssist"][var_0];
  level._id_A48E._id_D3C0 = level._id_54D0["playerJackalRegularRegenDelay"][var_0];
  level._id_A48E._id_D3BF = level._id_54D0["playerJackalLongRegenDelay"][var_0];
  level._id_A48E._id_D3BB = level._id_54D0["playerJackalHealthRegenRate"][var_0];
  level._id_A48E._id_D3BC = level._id_54D0["playerJackalImpactDamageScale"][var_0];
  level._id_A48E._id_A3F5 = level._id_54D0["JackalHoverheatRampTime"][var_0];
  level._id_A48E._id_A3F4 = level._id_54D0["JackalHoverheatMaxEnemies"][var_0];
  level._id_A48E._id_A3AE = level._id_54D0["JackalAttackercountMaxScalar"][var_0];
  level._id_A48E._id_A3AD = level._id_54D0["JackalAttackercountMax"][var_0];
  level._id_A48E._id_A3A6 = level._id_54D0["JackalAccuracyPerSecond"][var_0];
  level._id_A48E._id_A40A = level._id_54D0["JackalLockingBoostEscapeScale"][var_0];
  level._id_A48E._id_A408 = level._id_54D0["JackalLockedBoostEscapeScale"][var_0];
  level._id_A48E._id_A409 = level._id_54D0["JackalLockedTurnEscapeScale"][var_0];
  level._id_A48E._id_A425 = level._id_54D0["JackalTargetAidMinTime"][var_0];
  level._id_A48E._id_A424 = level._id_54D0["JackalTargetAidMaxTime"][var_0];
  level._id_A48E._id_A40B = level._id_54D0["JackallockonEnemyShowdownAccuracy"][var_0];
  level._id_A48E._id_3A06 = level._id_54D0["CapShipMiniflakThresholdMin"][var_0];
  level._id_A48E._id_3A05 = level._id_54D0["CapShipMiniflakThresholdMax"][var_0];
  level._id_A48E._id_3A04 = level._id_54D0["CapShipMiniflakThresholdHyperAggressiveMin"][var_0];
  level._id_A48E._id_3A03 = level._id_54D0["CapShipMiniflakThresholdHyperAggressiveMax"][var_0];
  level._id_A48E._id_39F9 = level._id_54D0["CapitalshipTurretHealthmod"][var_0];
  level._id_A48E._id_1B13 = level._id_54D0["AjaxEngineHealthmod"][var_0];
  _id_F762();
  level._id_A48E._id_D3BE = level._id_A48E._id_D3BA;
}

_id_F762() {
  if(!isDefined(level._id_D127)) {
    return;
  }
  if(isDefined(level._id_A48E._id_D3BE) && isDefined(level._id_D127._id_B154)) {
    var_0 = level._id_A48E._id_D3BA / level._id_A48E._id_D3BE;
    level._id_D127._id_B154 = level._id_D127._id_B154 * var_0;
  }

  if(isDefined(level._id_D127._id_4C15) && isDefined(level._id_D127._id_4C15._id_105EE))
    setsaveddvar("spaceshipTargetLockAnglesScale", level._id_D127._id_4C15._id_105EE * level._id_A48E._id_D3B9);
  else
    setsaveddvar("spaceshipTargetLockAnglesScale", level._id_A48E._id_D3B9);
}

_id_F679() {
  var_0 = scripts\sp\utility::_id_7E72();
  level.player.gs._id_B63A = 1000;
  level.player.gs._id_B63C = 10;

  if(var_0 == "medium") {
    level.player.gs._id_B63A = 5000;
    level.player.gs._id_B63C = 4;
  } else if(var_0 == "hard") {
    level.player.gs._id_B63A = 1000;
    level.player.gs._id_B63C = 1;
  }
}

updategameskill() {
  foreach(var_1 in level.players)
  var_1._id_7683 = var_1 scripts\sp\utility::_id_7B93();

  level._id_7683 = level.player._id_7683;

  if(isDefined(level._id_72B4))
    level._id_7683 = level._id_72B4;

  return level._id_7683;
}

_id_7685() {
  var_0 = level._id_7683;

  for(;;) {
    if(!isDefined(var_0)) {
      wait 1;
      var_0 = level._id_7683;
      continue;
    }

    if(var_0 != updategameskill()) {
      var_0 = level._id_7683;
      _id_12E5A();
    }

    wait 1;
  }
}

_id_7C6D(var_0) {
  return level._id_54D3[var_0];
}

_id_14F3() {
  return level._id_7683 == getdvarint("autodifficulty_original_setting");
}

_id_20A1(var_0, var_1) {
  self.gs.invultime_preshield = [[var_0]]("invulTime_preShield", var_1);
  self.gs.invultime_onshield = [[var_0]]("invulTime_onShield", var_1);
  self.gs.invultime_postshield = [[var_0]]("invulTime_postShield", var_1);
  self.gs.playerhealth_regularregendelay = [[var_0]]("playerHealth_RegularRegenDelay", var_1) * level._id_54D0["regularRegenDelayScalar"];
  self.gs.worthydamageratio = [[var_0]]("worthyDamageRatio", var_1);
  self.threatbias = int([[var_0]]("threatbias", var_1));
  self.gs.longregentime = [[var_0]]("longRegenTime", var_1) * level._id_54D0["longRegenTimeScalar"];
  self.gs.healthoverlaycutoff = [[var_0]]("healthOverlayCutoff", var_1);
  self.gs._id_DE8D = [[var_0]]("health_regenRate", var_1);
  self.gs._id_CF81 = [[var_0]]("base_enemy_accuracy", var_1);
  _id_12E0B();
  self.gs._id_D396 = int([[var_0]]("playerGrenadeBaseTime", var_1));
  self.gs._id_D397 = int([[var_0]]("playerGrenadeRangeTime", var_1));
  self.gs._id_D382 = int([[var_0]]("playerDoubleGrenadeTime", var_1));
  self.gs._id_B750 = [[var_0]]("min_sniper_burst_delay_time", var_1);
  self.gs._id_B461 = [[var_0]]("max_sniper_burst_delay_time", var_1);
  self.deathinvulnerabletime = int([[var_0]]("player_deathInvulnerableTime", var_1));
  self.criticalbulletdamagedist = int([[var_0]]("player_criticalBulletDamageDist", var_1));
  self.damagemultiplier = 100 / [[var_0]]("playerDifficultyHealth", var_1);
}

_id_12E0B() {
  if(scripts\sp\utility::_id_65DB("player_zero_attacker_accuracy")) {
    return;
  }
  self.ignorerandombulletdamage = self._id_28A4;
  self.attackeraccuracy = self.gs._id_CF81;
}

_id_20A2(var_0, var_1) {
  self.gs._id_B8D7 = [[var_0]]("missTimeConstant", var_1);
  self.gs._id_B8D9 = [[var_0]]("missTimeDistanceFactor", var_1);
  self.gs.double_grenades_allowed = [[var_0]]("double_grenades_allowed", var_1);
}

_id_F355() {
  _id_20A1(::_id_7AB0, 1);
  _id_20A2(::_id_7AAE, 1);
}

_id_7AAE(var_0, var_1) {
  return level._id_54D0[var_0][_id_7C6D(self._id_7683)];
}

_id_7AAD(var_0, var_1) {
  return level._id_54D0[var_0][_id_7C6D(level._id_7683)];
}

_id_786D(var_0, var_1) {
  var_2 = level._id_54D1[var_0];

  for(var_3 = 1; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3]["frac"];
    var_5 = var_2[var_3]["val"];

    if(var_1 <= var_4) {
      var_6 = var_2[var_3 - 1]["frac"];
      var_7 = var_2[var_3 - 1]["val"];
      var_8 = var_4 - var_6;
      var_9 = var_5 - var_7;
      var_10 = var_1 - var_6;
      var_11 = var_10 / var_8;
      return var_7 + var_11 * var_9;
    }
  }

  return var_2[var_2.size - 1]["val"];
}

_id_7E4A(var_0) {
  return level._id_54D0[var_0][_id_7C6D(self._id_7683)];
}

_id_80D5(var_0, var_1, var_2) {
  return (level._id_54D0[var_0][level._id_54D3[var_1]] * (100 - getdvarint("autodifficulty_frac")) + level._id_54D0[var_0][level._id_54D3[var_2]] * getdvarint("autodifficulty_frac")) * 0.01;
}

_id_7AB0(var_0, var_1) {
  return level._id_54D0[var_0][_id_7C6D(self._id_7683)];
}

_id_7AAF(var_0, var_1) {
  return level._id_54D0[var_0][_id_7C6D(level._id_7683)];
}

_id_1D5A() {
  return 0;
}

_id_C868() {
  if(!_id_C869())
    return 0;

  return randomint(100) > 25;
}

_id_C869() {
  if(!isalive(self.enemy))
    return 0;

  if(!isPlayer(self.enemy))
    return 0;

  if(!isalive(level._id_C870) || level._id_C870.script != "pain")
    level._id_C870 = self;

  if(self == level._id_C870)
    return 0;

  if(self.damageweapon != "none" && weaponisboltaction(self.damageweapon))
    return 0;

  return 1;
}

_id_F288() {
  if(scripts\anim\utility_common::isasniper() && isalive(self.enemy)) {
    _id_F84B();
    return;
  }

  if(isPlayer(self.enemy)) {
    _id_E258();

    if(self.a._id_B8D6 > gettime()) {
      self.accuracy = 0;
      return;
    }
  }

  if(self.script == "move") {
    if(scripts\engine\utility::actor_is3d() && isDefined(self._blackboard._id_AA3D) && (self._blackboard._id_AA3D.type == "Exposed 3D" || self._blackboard._id_AA3D.type == "Path 3D"))
      self.accuracy = self._id_2894;
    else if(scripts\anim\utility::_id_9D9C())
      self.accuracy = anim._id_1385F * self._id_2894;
    else
      self.accuracy = anim._id_E7D4 * self._id_2894;

    return;
  }

  self.accuracy = self._id_2894;

  if(isDefined(self._id_9F15) && isDefined(self._id_DC58))
    self.accuracy = self.accuracy * self._id_DC58;
}

_id_F84B() {
  if(!isDefined(self._id_103BF)) {
    self._id_103BF = 0;
    self._id_103BA = 0;
  }

  if(!isDefined(self._id_103B2)) {
    self._id_103B2 = 1;
    var_0 = _id_7C6D(level._id_7683);
    var_1 = level._id_54D0["sniperAccuDiffScale"][var_0];
    self._id_2894 = self.accuracy * var_1;
  }

  self._id_103BF++;
  var_2 = level._id_7683;

  if(isPlayer(self.enemy))
    var_2 = self.enemy._id_7683;

  if(_id_10019()) {
    self.accuracy = 0;

    if(var_2 > 0 || self._id_103BF > 1)
      self._id_A9BA = self.enemy;

    return;
  }

  if(self.accuracy <= 10)
    self.accuracy = (1 + 1 * self._id_103BA) * self._id_2894;

  self._id_103BA++;

  if(var_2 < 1 && self._id_103BA == 1)
    self._id_A9BA = undefined;
}

_id_10019() {
  if(isDefined(self._id_BEF8) && self._id_BEF8)
    return 0;

  if(self.team == "allies")
    return 0;

  if(isDefined(self._id_A9BA) && self.enemy == self._id_A9BA)
    return 0;

  if(distancesquared(self.origin, self.enemy.origin) > 250000)
    return 0;

  return 1;
}

_id_FF07() {
  return 1 + randomfloat(4);
}

_id_54C4() {
  self.a._id_B8D8 = 0;
}

_id_E242() {
  resetmisstime_code();
}

_id_13847() {
  var_0 = 0;
  waittillframeend;

  if(!isalive(self.enemy))
    return var_0;

  if(!isPlayer(self.enemy))
    return var_0;

  if(self.enemy scripts\sp\utility::_id_65DB("player_is_invulnerable"))
    var_0 = 0.3 + randomfloat(0.4);

  return var_0;
}

_id_D8EB(var_0, var_1, var_2, var_3) {
  var_3 = var_3 * 20;

  for(var_4 = 0; var_4 < var_3; var_4++)
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
    self._id_B8D6 = 0;
    return;
  }

  if(!isalive(self.enemy)) {
    return;
  }
  if(!isPlayer(self.enemy)) {
    self.accuracy = self._id_2894;
    return;
  }

  var_0 = distance(self.enemy.origin, self.origin);
  _id_F79C(self.enemy.gs._id_B8D7 + var_0 * self.enemy.gs._id_B8D9);
}

_id_E258() {
  self.a._id_B8D8 = gettime() + 3000;
}

_id_F79C(var_0) {
  if(self.a._id_B8D8 > gettime()) {
    return;
  }
  if(var_0 > 0)
    self.accuracy = 0;

  var_0 = var_0 * 1000;
  self.a._id_B8D6 = gettime() + var_0;
  self.a._id_154C = 1;
}

_id_CF4D() {
  self endon("death");
  self notify("playeraim");
  self endon("playeraim");

  for(;;) {
    var_0 = (0, 1, 0);

    if(self.a._id_B8D6 > gettime())
      var_0 = (1, 0, 0);

    wait 0.05;
  }
}

_id_ECC2(var_0, var_1, var_2) {
  var_3 = randomfloatrange(-15, 15);
  var_4 = randomfloatrange(-15, 15);
  self scaleovertime(0.1, int(2048 * var_1), int(1152 * var_1));
  self.y = 100 + var_4;
  self moveovertime(0.08);
  self.y = 0 + var_4;
  self.x = self.x + var_3;

  if(isDefined(var_2)) {
    return;
  }
  _id_ECC1();
}

_id_ECC3(var_0, var_1, var_2) {
  var_3 = 1;

  if(var_2)
    var_3 = -1;

  var_4 = randomfloatrange(-15, 15);
  var_5 = randomfloatrange(-15, 15);
  self scaleovertime(0.1, int(2048 * var_1), int(1152 * var_1));
  self.x = 1000 * var_3 + var_4;
  self moveovertime(0.1);
  self.x = 0 + var_4;
  self.y = self.y + var_5;
  _id_ECC1();
}

_id_ECC1() {
  self endon("death");
  var_0 = gettime();
  var_1 = 1;
  var_2 = 0.05;
  self.alpha = 0;
  self fadeovertime(var_2);
  self.alpha = 1;
  wait(var_2);
  scripts\sp\utility::_id_135AF(var_0, 2);
  self fadeovertime(var_1);
  self.alpha = 0;
  scripts\engine\utility::waittill_notify_or_timeout("screenfx_force_delete", var_1);
  self destroy();
}

_id_ECC0() {
  var_0 = 0.2;
  self.alpha = 0.7;
  self fadeovertime(var_0);
  self.alpha = 0;
  wait(var_0);
  self destroy();
}

_id_8587(var_0) {
  var_1 = "fullscreen_dirt_" + var_0;
  var_2 = undefined;

  if(var_0 == "bottom")
    var_2 = "fullscreen_dirt_bottom_b";

  thread _id_56C6("dirt", var_0, var_1, var_2, randomfloatrange(0.55, 0.66));
}

_id_2BC1(var_0) {
  var_1 = "fullscreen_bloodsplat_" + var_0;
  thread _id_56C6("bloodsplat", var_0, var_1, undefined, randomfloatrange(0.45, 0.56));
}

_id_56C6(var_0, var_1, var_2, var_3, var_4) {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self._id_9BA2)) {
    return;
  }
  var_5 = gettime();

  if(self.gs._id_ECCC[var_0][var_1] == var_5) {
    return;
  }
  if(self.gs._id_ECCC[var_0 + "_count"][var_1] == 1) {
    return;
  }
  self.gs._id_ECCC[var_0 + "_count"][var_1]++;
  self.gs._id_ECCC[var_0][var_1] = var_5;
  self endon("death");

  switch (var_1) {
    case "bottom":
      var_6 = int(640);
      var_7 = int(480);

      if(var_0 == "dirt") {
        var_8 = scripts\sp\hud_util::_id_48B8(var_2, 1);
        var_8 thread _id_ECC2(var_0, var_4, 1);
        var_8 _id_ECC0();
      } else {
        var_8 = scripts\sp\hud_util::_id_48B8(var_2, 0);
        var_8 _id_ECC2(var_0, var_4);
      }

      if(isDefined(var_3)) {
        var_9 = scripts\sp\hud_util::_id_48B8(var_3, 0);
        var_9 _id_ECC2(var_0, var_4);
      }

      break;
    case "left":
      var_8 = scripts\sp\hud_util::_id_48B8(var_2, 0, 1, 1);
      var_8 _id_ECC3(var_0, var_4, 1);
      break;
    case "right":
      var_8 = scripts\sp\hud_util::_id_48B8(var_2, 0, 1, 1);
      var_8 _id_ECC3(var_0, var_4, 0);
      break;
    default:
  }

  self.gs._id_ECCC[var_1 + "_count"][var_2]--;
}

_id_D3A9() {
  var_0 = scripts\sp\utility::_id_7751;
  var_1 = scripts\sp\utility::_id_2BC6;
  var_2 = [];
  var_2["MOD_GRENADE"] = var_0;
  var_2["MOD_GRENADE_SPLASH"] = var_0;
  var_2["MOD_PROJECTILE"] = var_0;
  var_2["MOD_PROJECTILE_SPLASH"] = var_0;
  var_2["MOD_EXPLOSIVE"] = var_0;
  var_2["MOD_PISTOL_BULLET"] = var_1;
  var_2["MOD_RIFLE_BULLET"] = var_1;
  var_2["MOD_EXPLOSIVE_BULLET"] = var_1;
  self._id_91F2 = 0;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7);
    self._id_91F2 = 1;
    self._id_4D62 = var_6;
    self.damageattacker = var_4;
    var_8 = undefined;

    if(isDefined(self._id_B940))
      var_8 = self._id_B940[var_7];

    if(!isDefined(var_8) && isDefined(var_2[var_7]))
      var_8 = var_2[var_7];

    if(isDefined(var_8)) {
      waittillframeend;
      [[var_8]](var_6);
    }
  }
}

_id_D0CE() {
  self._id_D0CE = 3;
}

_id_D3A6() {
  level._id_1114E["take_cover"] = spawnStruct();
  level._id_1114E["take_cover"].text = &"GAME_GET_TO_COVER";
  level._id_1114E["get_back_up"] = spawnStruct();
  level._id_1114E["get_back_up"].text = &"GAME_LAST_STAND_GET_BACK_UP";
}

playerhealthregen() {
  thread _id_8CBA();

  if(scripts\sp\utility::_id_93A6()) {
    return;
  }
  var_0 = 1;
  var_1 = 0;
  thread _id_D0CE();
  var_2 = 0;
  var_3 = 0;
  thread _id_D369(self.maxhealth * 0.35);
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 1;
  thread _id_D3A9();
  self._id_2C42 = 0;

  for(;;) {
    wait 0.05;
    waittillframeend;

    if(self.health == self.maxhealth) {
      if(scripts\sp\utility::_id_65DB("player_has_red_flashing_overlay"))
        _id_D259();

      var_7 = 1;
      var_3 = 0;
      var_2 = 0;
      continue;
    }

    if(self.health <= 0) {
      return;
    }
    var_8 = var_2;
    var_9 = self.health / self.maxhealth;

    if(var_9 <= self.gs.healthoverlaycutoff && self._id_D0CE > 1) {
      var_2 = 1;

      if(!var_8) {
        var_5 = gettime();

        if(scripts\sp\utility::_id_65DB("near_death_vision_enabled")) {
          thread _id_2BDB(3.6, 2);
          thread _id_0B0B::_id_F334();
          self _meth_8223();
        }

        scripts\sp\utility::_id_65E1("player_has_red_flashing_overlay");
        var_3 = 1;
      }
    }

    if(self._id_91F2) {
      var_5 = gettime();
      self._id_91F2 = 0;
    }

    if(self.health / self.maxhealth >= var_0) {
      if(gettime() - var_5 < self.gs.playerhealth_regularregendelay) {
        continue;
      }
      if(var_2) {
        var_6 = var_9;

        if(gettime() > var_5 + self.gs.longregentime)
          var_6 = var_6 + self.gs._id_DE8D;

        if(var_6 >= 1)
          _id_DE3C();
      } else
        var_6 = 1;

      if(var_6 > 1.0)
        var_6 = 1.0;

      if(var_6 <= 0) {
        return;
      }
      self _meth_8319(var_6);
      var_0 = self.health / self.maxhealth;
      continue;
    }

    var_0 = var_7;
    var_10 = self.gs.worthydamageratio;

    if(self.attackercount == 1)
      var_10 = var_10 * 3;

    var_11 = var_0 - var_9 >= var_10;

    if(self.health <= 1) {
      self _meth_8319(2 / self.maxhealth);
      var_11 = 1;
    }

    var_0 = self.health / self.maxhealth;
    self notify("hit_again");
    var_1 = 0;
    var_5 = gettime();
    thread _id_2BDB(3, 0.8);

    if(!var_11) {
      continue;
    }
    if(scripts\sp\utility::_id_65DB("player_is_invulnerable")) {
      continue;
    }
    scripts\sp\utility::_id_65E1("player_is_invulnerable");
    level notify("player_becoming_invulnerable");

    if(var_3) {
      var_4 = self.gs.invultime_onshield;
      var_3 = 0;
    } else if(var_2)
      var_4 = self.gs.invultime_postshield;
    else
      var_4 = self.gs.invultime_preshield;

    var_7 = self.health / self.maxhealth;
    thread _id_D3B1(var_4);
  }
}

_id_DE3C() {
  if(!_id_11432()) {
    return;
  }
  if(isalive(self)) {
    var_0 = self _meth_8139("takeCoverWarnings");

    if(var_0 > 0) {
      var_0--;
      self _meth_8302("takeCoverWarnings", var_0);
    }
  }
}

_id_D3B1(var_0) {
  if(isDefined(self.flashendtime) && self.flashendtime > gettime())
    var_0 = var_0 * _id_7E4A("flashbangedInvulFactor");

  if(var_0 > 0) {
    if(!isDefined(self._id_C088))
      self.attackeraccuracy = 0;

    self.ignorerandombulletdamage = 1;
    wait(var_0);
  }

  _id_12E0B();
  scripts\sp\utility::_id_65DD("player_is_invulnerable");
}

_id_4FE9() {
  if(self.team == "allies")
    self._id_5A0E = 0.6;

  if(self isbadguy()) {
    if(level._id_7683 >= 2)
      self._id_5A0E = 0.8;
    else
      self._id_5A0E = 0.6;
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
    if(level._id_7683 >= 2) {
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

_id_2BDB(var_0, var_1) {
  if(scripts\sp\utility::_id_65DB("player_no_auto_blur")) {
    return;
  }
  self notify("blurview_stop");
  self endon("blurview_stop");
  self setblurforplayer(var_0, 0);
  wait 0.05;
  self setblurforplayer(0, var_1);
}

_id_D369(var_0) {
  wait 2;

  for(;;) {
    wait 0.2;

    if(self.health <= 0 || getdvarint("cg_useplayerbreathsys")) {
      return;
    }
    var_1 = self.health / self.maxhealth;

    if(var_1 > self.gs.healthoverlaycutoff) {
      continue;
    }
    if(isDefined(self._id_550A) && self._id_550A) {
      continue;
    }
    if(isDefined(level._id_7684))
      [[level._id_7684]]("breathing_hurt");
    else
      self playlocalsound("breathing_hurt");

    var_2 = 0.1;

    if(isDefined(level.player.gs._id_4C82))
      var_2 = level.player.gs._id_4C82;

    wait(var_2 + randomfloat(0.8));
  }
}

_id_8CBA() {
  self endon("noHealthOverlay");
  var_0 = newclienthudelem(self);
  self._id_8CAE = var_0;
  var_0.x = 0;
  var_0.y = 0;
  var_1 = "vfx_ui_player_pain_overlay";
  var_0 setshader(var_1, 640, 480);
  var_0._id_02B4 = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.enablehudlighting = 1;
  thread _id_8CBB(var_0);
  childthread _id_11431(var_0);
  var_2 = 0.0;
  var_3 = 0.05;
  var_4 = 0.3;

  while(isalive(self)) {
    wait(var_3);

    if(!isalive(self)) {
      break;
    }

    if(scripts\sp\utility::_id_93A6()) {
      if(scripts\sp\specialist_MAYBE::_id_2C97())
        var_2 = 0;
      else {
        var_4 = 0.1;
        var_5 = 1.0 - self.health / level.player.maxhealth;
        var_5 = var_5 * 1.5;
        var_6 = var_5 - var_0.alpha;
        var_7 = var_0.alpha + var_6 * var_4;
        var_2 = clamp(var_7, 0, 1);
      }
    } else if(level.player scripts\sp\utility::_id_65DB("player_has_red_flashing_overlay")) {
      var_2 = 0;
      level.player scripts\sp\utility::_id_65E8("player_has_red_flashing_overlay");
    } else {
      var_5 = 1.0 - self.health / level.player.maxhealth;
      var_8 = var_5 * var_5 * 1.2;
      var_8 = clamp(var_8, 0, 1);

      if(var_2 > var_8)
        var_2 = var_2 - var_4 * var_3;

      if(var_2 < var_8)
        var_2 = var_8;
    }

    if(isDefined(level.player._id_111B8) && level.player._id_111B8) {
      continue;
    }
    var_0.alpha = var_2;
  }
}

_id_11431(var_0) {
  self endon("death");

  while(isalive(self)) {
    scripts\sp\utility::_id_65E3("player_has_red_flashing_overlay");
    _id_11430(var_0);
  }
}

_id_16F1(var_0) {
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

  if(!isDefined(self._id_272E)) {
    return;
  }
  self._id_272E.x = 0;
  self._id_272E.y = -40;
  self._id_272E.alignx = "center";
  self._id_272E.aligny = "middle";
  self._id_272E.horzalign = "center";
  self._id_272E.vertalign = "middle";

  if(level.console)
    self._id_272E setshader("popmenu_bg", 650, 52);
  else
    self._id_272E setshader("popmenu_bg", 650, 42);

  self._id_272E.alpha = 0.5;
}

_id_1383C() {
  self endon("hit_again");
  self endon("player_downed");
  self waittill("damage");
}

_id_52BD(var_0) {
  var_0 endon("being_destroyed");
  _id_1383C();
  var_1 = !isalive(self);
  var_0 thread _id_52BC(var_1);
}

_id_52BE() {
  self endon("being_destroyed");
  scripts\engine\utility::flag_wait("missionfailed");
  thread _id_52BC(1);
}

_id_52BC(var_0) {
  self notify("being_destroyed");
  self._id_2A88 = 1;

  if(var_0) {
    self fadeovertime(0.5);
    self.alpha = 0;
    wait 0.5;
  }

  self notify("death");
  self destroy();
}

_id_B4DA(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_0._id_2A88))
    return 0;

  return 1;
}

_id_11432() {
  if(isDefined(level._id_470F))
    return 0;

  if(isDefined(self.melee))
    return 0;

  if(isDefined(self.vehicle))
    return 0;

  return 1;
}

_id_8C1D() {
  var_0 = self getweaponslist("offhand");

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "offhandshield"))
      return 1;
  }

  return 0;
}

_id_E34F() {
  return level.player _meth_84D0() > level.player _meth_84CF() * 0.1;
}

_id_FF8B() {
  if(scripts\sp\utility::_id_93A6())
    return 0;

  if(!isalive(self))
    return 0;

  if(self islinked())
    return 0;

  if(self.ignoreme)
    return 0;

  if(level._id_B8D0)
    return 0;

  if(!_id_11432())
    return 0;

  if(self._id_7683 > 1 && !_id_B327())
    return 0;

  if(scripts\sp\utility::_id_65DB("player_retract_shield_active"))
    return 0;

  var_0 = self _meth_8139("takeCoverWarnings");

  if(var_0 <= 3)
    return 0;

  return 1;
}

_id_FF89() {
  if(scripts\sp\utility::_id_93A6())
    return 0;

  if(!isalive(self))
    return 0;

  if(self islinked())
    return 0;

  if(self.ignoreme)
    return 0;

  if(level._id_B8D0)
    return 0;

  if(!_id_11432())
    return 0;

  if(self._id_7683 > 1 && !_id_B327())
    return 0;

  var_0 = self _meth_8139("takeCoverWarnings");

  if(var_0 <= 3)
    return 0;

  return 1;
}

_id_B327() {
  if(!isDefined(level._id_5FB0))
    return 1;

  if(isDefined(level._id_5FB0[level.script]))
    return level._id_5FB0[level.script];
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
  var_0 = 0;

  foreach(var_2 in maps_with_jackal_arenas()) {
    var_3 = level.player _meth_84C6("missionStateData", var_2);

    if(isDefined(var_3) && var_3 == "complete")
      var_0++;
  }

  return var_0;
}

map_has_jackal_arena() {
  if(scripts\engine\utility::array_contains(maps_with_jackal_arenas(), level.script))
    return 1;
  else
    return 0;
}

_id_11430(var_0) {
  self endon("hit_again");
  self endon("damage");
  self endon("death");
  childthread _id_DE16(var_0);

  if(level.player scripts\sp\utility::_id_7B93() < 2) {
    var_1 = _id_7D51();
    var_2 = [[var_1]]();
    var_3 = gettime() + self.gs.longregentime;
    _id_4766(1, var_2);

    while(gettime() < var_3 && isalive(self) && scripts\sp\utility::_id_65DB("player_has_red_flashing_overlay") && !scripts\sp\utility::_id_65DB("player_retract_shield_active"))
      _id_4766(0.9, var_2);

    if(isalive(self))
      _id_4766(0.65, var_2);

    _id_4766(0, var_2);
  }

  scripts\sp\utility::_id_65E3("redflashoverlay_complete");
  self notify("take_cover_done");
  self notify("hit_again");
}

_id_4766(var_0, var_1) {
  if(getomnvar("ui_gettocover_state") == 0 && (var_0 == 0 || var_0 == 5)) {
    return;
  }
  if(var_0 == 1) {
    if(var_1)
      setomnvar("ui_gettocover_state", 1);

    wait 0.7;
  } else if(var_0 == 0.9) {
    if(var_1)
      setomnvar("ui_gettocover_state", 2);

    wait 0.7;
  } else if(var_0 == 6.5) {
    if(var_1)
      setomnvar("ui_gettocover_state", 3);

    wait 0.65;
  } else if(var_0 == 0) {
    if(var_1 || getomnvar("ui_gettocover_state") > 0 && getomnvar("ui_gettocover_state") < 4)
      setomnvar("ui_gettocover_state", 4);

    wait 0.5;
  } else if(var_0 == 5) {
    if(var_1 || getomnvar("ui_gettocover_state") > 0 && getomnvar("ui_gettocover_state") < 5)
      setomnvar("ui_gettocover_state", 5);

    wait 0.5;
  }
}

_id_DE16(var_0) {
  scripts\sp\utility::_id_65DD("redflashoverlay_complete");
  var_1 = gettime() + level.player.gs.longregentime;
  _id_DE15(var_0, 1, 1);

  while(gettime() < var_1 && isalive(level.player))
    _id_DE15(var_0, 0.9, 1);

  if(isalive(level.player))
    _id_DE15(var_0, 0.65, 0.8);

  _id_DE15(var_0, 0, 0.6);
  var_0 fadeovertime(0.5);
  var_0.alpha = 0;
  wait 0.5;
  scripts\sp\utility::_id_65E3("redflashoverlay_complete");
}

_id_DE15(var_0, var_1, var_2) {
  var_3 = 0.8;
  var_4 = 0.5;
  var_5 = var_3 * 0.1;
  var_6 = var_3 * (0.1 + var_1 * 0.2);
  var_7 = var_3 * (0.1 + var_1 * 0.1);
  var_8 = var_3 * 0.3;
  var_9 = var_3 - var_5 - var_6 - var_7 - var_8;

  if(var_9 < 0)
    var_9 = 0;

  var_10 = 0.8 + var_1 * 0.1;
  var_11 = 0.5 + var_1 * 0.3;
  var_0 fadeovertime(var_5);
  var_0.alpha = var_2 * 1.0;
  wait(var_5 + var_6);
  var_0 fadeovertime(var_7);
  var_0.alpha = var_2 * var_10;
  wait(var_7);
  var_0 fadeovertime(var_8);
  var_0.alpha = var_2 * var_11;
  wait(var_8);
  wait(var_9);
}

_id_7D51() {
  var_0 = undefined;

  if(_id_8C1D() && _id_E34F()) {
    var_0 = ::_id_FF8B;
    setomnvar("ui_gettocover_text", "game_use_retract_shield");
  } else {
    var_0 = ::_id_FF89;
    setomnvar("ui_gettocover_text", "game_get_to_cover");
  }

  return var_0;
}

_id_7A59() {
  if(scripts\sp\utility::_id_D15B("hull"))
    return level._id_A48E._id_D3BA * 1.5;
  else
    return level._id_A48E._id_D3BA;
}

_id_D259() {
  scripts\sp\utility::_id_65DD("player_has_red_flashing_overlay");

  if(scripts\sp\utility::_id_65DB("near_death_vision_enabled")) {
    self _meth_8222();
    thread _id_0B0B::_id_E2BB();
  }

  self notify("take_cover_done");
}

_id_8CBB(var_0) {
  self waittill("noHealthOverlay");
  var_0 destroy();
}

_id_E26C() {
  waittillframeend;
  _id_F848(1);
}

_id_9772() {
  var_0 = isDefined(level._id_9F0B) && level._id_9F0B;

  if(self _meth_8139("takeCoverWarnings") == -1 || var_0)
    self _meth_8302("takeCoverWarnings", 9);
}

_id_93F7() {
  self notify("new_cover_on_death_thread");
  self endon("new_cover_on_death_thread");
  self waittill("death");

  if(!scripts\sp\utility::_id_65DB("player_has_red_flashing_overlay")) {
    return;
  }
  if(!_id_11432()) {
    return;
  }
  var_0 = self _meth_8139("takeCoverWarnings");

  if(var_0 < 10)
    self _meth_8302("takeCoverWarnings", var_0 + 1);
}

_id_2624() {
  var_0 = self.origin;
  wait 5;

  if(_id_2693(var_0))
    level._id_2641[level._id_2641.size] = var_0;
}

_id_2693(var_0) {
  return distancesquared(self.origin, var_0) < 19600;
}

_id_2623() {
  level._id_2641 = [];
  level.player._id_BCB6 = 1;
  wait 1;

  for(;;) {
    level.player thread _id_2624();
    level.player._id_BCB6 = 1;
    var_0 = [];
    var_1 = level._id_2641.size - 5;

    if(var_1 < 0)
      var_1 = 0;

    for(var_2 = var_1; var_2 < level._id_2641.size; var_2++) {
      if(!level.player _id_2693(level._id_2641[var_2])) {
        continue;
      }
      var_0[var_0.size] = level._id_2641[var_2];
      level.player._id_BCB6 = 0;
    }

    level._id_2641 = var_0;
    wait 1;
  }
}

_id_2625() {
  level.player waittill("death");
  var_0 = getdvarint("autodifficulty_playerDeathTimer");
  var_0 = var_0 - 60;
  setDvar("autodifficulty_playerDeathTimer", var_0);
}

_id_2626() {
  var_0 = gettime();

  for(;;) {
    if(level.player attackButtonPressed())
      var_0 = gettime();

    level._id_118E5 = gettime() - var_0;
    wait 0.05;
  }
}

_id_9138(var_0, var_1) {
  _id_9137(var_0, var_1 * 100, 1);
}

_id_9136(var_0, var_1) {
  _id_9137(var_0, var_1, 0);
}

_id_913D() {
  level._id_9184 = 0;

  if(isDefined(level._id_9177)) {
    for(var_0 = 0; var_0 < level._id_9177.size; var_0++)
      level._id_9177[var_0] destroy();
  }

  level._id_9177 = [];
}

_id_9139(var_0) {
  if(!isDefined(level._id_9183))
    level._id_9183 = [];

  if(!isDefined(level._id_9183[var_0])) {
    var_1 = newhudelem();
    var_1.x = level._id_4F47;
    var_1.y = level._id_4F45 + level._id_9184 * 15;
    var_1.foreground = 1;
    var_1.sort = 100;
    var_1.alpha = 1.0;
    var_1.alignx = "left";
    var_1.horzalign = "left";
    var_1.fontscale = 1.0;
    var_1 settext(var_0);
    level._id_9183[var_0] = 1;
  }
}

_id_9137(var_0, var_1, var_2) {
  _id_9139(var_0);
  var_1 = int(var_1);
  var_3 = 0;

  if(var_1 < 0) {
    var_3 = 1;
    var_1 = var_1 * -1;
  }

  var_4 = 0;
  var_5 = 0;
  var_6 = 0;

  for(var_7 = 0; var_1 >= 10000; var_1 = var_1 - 10000) {}

  while(var_1 >= 1000) {
    var_1 = var_1 - 1000;
    var_4++;
  }

  while(var_1 >= 100) {
    var_1 = var_1 - 100;
    var_5++;
  }

  while(var_1 >= 10) {
    var_1 = var_1 - 10;
    var_6++;
  }

  while(var_1 >= 1) {
    var_1 = var_1 - 1;
    var_7++;
  }

  var_8 = 0;
  var_9 = 10;

  if(var_4 > 0) {
    _id_913A(var_4, var_8);
    var_8 = var_8 + var_9;
    _id_913A(var_5, var_8);
    var_8 = var_8 + var_9;
    _id_913A(var_6, var_8);
    var_8 = var_8 + var_9;
    _id_913A(var_7, var_8);
    var_8 = var_8 + var_9;
  } else if(var_5 > 0 || var_2) {
    _id_913A(var_5, var_8);
    var_8 = var_8 + var_9;
    _id_913A(var_6, var_8);
    var_8 = var_8 + var_9;
    _id_913A(var_7, var_8);
    var_8 = var_8 + var_9;
  } else if(var_6 > 0) {
    _id_913A(var_6, var_8);
    var_8 = var_8 + var_9;
    _id_913A(var_7, var_8);
    var_8 = var_8 + var_9;
  } else {
    _id_913A(var_7, var_8);
    var_8 = var_8 + var_9;
  }

  if(var_2) {
    var_10 = newhudelem();
    var_10.x = 204.5;
    var_10.y = level._id_4F45 + level._id_9184 * 15;
    var_10.foreground = 1;
    var_10.sort = 100;
    var_10.alpha = 1.0;
    var_10.alignx = "left";
    var_10.horzalign = "left";
    var_10.fontscale = 1.0;
    var_10 settext(".");
    level._id_9177[level._id_9177.size] = var_10;
  }

  if(var_3) {
    var_11 = newhudelem();
    var_11.x = 195.5;
    var_11.y = level._id_4F45 + level._id_9184 * 15;
    var_11.foreground = 1;
    var_11.sort = 100;
    var_11.alpha = 1.0;
    var_11.alignx = "left";
    var_11.horzalign = "left";
    var_11.fontscale = 1.0;
    var_11 settext(" - ");
    level._id_9177[level._id_9184] = var_11;
  }

  level._id_9184++;
}

_id_913C(var_0, var_1) {
  _id_9139(var_0);
  _id_913B(var_1, 0);
  level._id_9184++;
}

_id_913A(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 200 + var_1 * 0.65;
  var_2.y = level._id_4F45 + level._id_9184 * 15;
  var_2.foreground = 1;
  var_2.sort = 100;
  var_2.alpha = 1.0;
  var_2.alignx = "left";
  var_2.horzalign = "left";
  var_2.fontscale = 1.0;
  var_2 settext(var_0 + "");
  level._id_9177[level._id_9177.size] = var_2;
}

_id_913B(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 200 + var_1 * 0.65;
  var_2.y = level._id_4F45 + level._id_9184 * 15;
  var_2.foreground = 1;
  var_2.sort = 100;
  var_2.alpha = 1.0;
  var_2.alignx = "left";
  var_2.horzalign = "left";
  var_2.fontscale = 1.0;
  var_2 settext(var_0);
  level._id_9177[level._id_9177.size] = var_2;
}

_id_14ED() {
  scripts\engine\utility::add_func_ref_MAYBE("sp_stat_tracking_func", ::_id_262A);
  setDvar("aa_player_kills", "0");
  setDvar("aa_enemy_deaths", "0");
  setDvar("aa_enemy_damage_taken", "0");
  setDvar("aa_player_damage_taken", "0");
  setDvar("aa_player_damage_dealt", "0");
  setDvar("aa_ads_damage_dealt", "0");
  setDvar("aa_time_tracking", "0");
  setDvar("aa_deaths", "0");
  setDvar("player_cheated", 0);
  level._id_262B = [];
  thread _id_14F4();
  thread _id_14F1();
  thread _id_14EF();
  scripts\engine\utility::flag_set("auto_adjust_initialized");
  scripts\engine\utility::flag_init("aa_main_" + level.script);
  scripts\engine\utility::flag_set("aa_main_" + level.script);
}

_id_4423(var_0) {
  var_1 = getkeybinding(var_0);

  if(var_1["count"] <= 0)
    return 0;

  for(var_2 = 1; var_2 < var_1["count"] + 1; var_2++) {
    if(self buttonPressed(var_1["key" + var_2]))
      return 1;
  }

  return 0;
}

_id_14F4() {
  waittillframeend;

  for(;;)
    wait 0.2;
}

_id_14EF() {
  level.player endon("death");
  level._id_CF4B = 0;

  for(;;) {
    if(level.player scripts\sp\utility::_id_9D27()) {
      level._id_CF4B = gettime();

      while(level.player scripts\sp\utility::_id_9D27())
        wait 0.05;

      continue;
    }

    wait 0.05;
  }
}

_id_14F1() {
  for(;;) {
    level.player waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    _id_14DB("aa_player_damage_taken", var_0);

    if(!isalive(level.player)) {
      _id_14DB("aa_deaths", 1);
      return;
    }
  }
}

_id_262A(var_0) {
  if(!isDefined(level._id_2629))
    level._id_2629 = [];

  scripts\engine\utility::flag_wait("auto_adjust_initialized");
  level._id_262B[var_0] = [];
  level._id_2629[var_0] = 0;
  scripts\engine\utility::flag_wait(var_0);

  if(getDvar("aa_zone" + var_0) == "") {
    setDvar("aa_zone" + var_0, "on");
    level._id_2629[var_0] = 1;
    _id_14F5();
    setDvar("start_time" + var_0, getDvar("aa_time_tracking"));
    setDvar("starting_player_kills" + var_0, getDvar("aa_player_kills"));
    setDvar("starting_deaths" + var_0, getDvar("aa_deaths"));
    setDvar("starting_ads_damage_dealt" + var_0, getDvar("aa_ads_damage_dealt"));
    setDvar("starting_player_damage_dealt" + var_0, getDvar("aa_player_damage_dealt"));
    setDvar("starting_player_damage_taken" + var_0, getDvar("aa_player_damage_taken"));
    setDvar("starting_enemy_damage_taken" + var_0, getDvar("aa_enemy_damage_taken"));
    setDvar("starting_enemy_deaths" + var_0, getDvar("aa_enemy_deaths"));
  } else if(getDvar("aa_zone" + var_0) == "done") {
    return;
  }
  scripts\engine\utility::flag_waitopen(var_0);
  _id_262C(var_0);
}

_id_262C(var_0) {
  setDvar("aa_zone" + var_0, "done");
  var_1 = getdvarfloat("start_time" + var_0);
  var_2 = getdvarint("starting_player_kills" + var_0);
  var_3 = getdvarint("aa_enemy_deaths" + var_0);
  var_4 = getdvarint("aa_enemy_damage_taken" + var_0);
  var_5 = getdvarint("aa_player_damage_taken" + var_0);
  var_6 = getdvarint("aa_player_damage_dealt" + var_0);
  var_7 = getdvarint("aa_ads_damage_dealt" + var_0);
  var_8 = getdvarint("aa_deaths" + var_0);
  level._id_2629[var_0] = 0;
  _id_14F5();
  var_9 = getdvarfloat("aa_time_tracking") - var_1;
  var_10 = getdvarint("aa_player_kills") - var_2;
  var_11 = getdvarint("aa_enemy_deaths") - var_3;
  var_12 = 0;

  if(var_11 > 0) {
    var_12 = var_10 / var_11;
    var_12 = var_12 * 100;
    var_12 = int(var_12);
  }

  var_13 = getdvarint("aa_enemy_damage_taken") - var_4;
  var_14 = getdvarint("aa_player_damage_dealt") - var_6;
  var_15 = 0;
  var_16 = 0;

  if(var_13 > 0 && var_9 > 0) {
    var_15 = var_14 / var_13;
    var_15 = var_15 * 100;
    var_15 = int(var_15);
    var_16 = var_14 / var_9;
    var_16 = var_16 * 60;
    var_16 = int(var_16);
  }

  var_17 = getdvarint("aa_ads_damage_dealt") - var_7;
  var_18 = 0;

  if(var_14 > 0) {
    var_18 = var_17 / var_14;
    var_18 = var_18 * 100;
    var_18 = int(var_18);
  }

  var_19 = getdvarint("aa_player_damage_taken") - var_5;
  var_20 = 0;

  if(var_9 > 0)
    var_20 = var_19 / var_9;

  var_21 = var_20 * 60;
  var_21 = int(var_21);
  var_22 = getdvarint("aa_deaths") - var_8;
  var_23 = [];
  var_23["player_damage_taken_per_minute"] = var_21;
  var_23["player_damage_dealt_per_minute"] = var_16;
  var_23["minutes"] = var_9 / 60;
  var_23["deaths"] = var_22;
  var_23["gameskill"] = level._id_7683;
  level._id_262B[var_0] = var_23;
  var_24 = "Completed AA sequence: ";
  var_24 = var_24 + (level.script + "/" + var_0);
  var_25 = getarraykeys(var_23);

  for(var_26 = 0; var_26 < var_25.size; var_26++)
    var_24 = var_24 + ", " + var_25[var_26] + ": " + var_23[var_25[var_26]];

  logstring(var_24);
}

_id_14F2(var_0, var_1) {
  logstring(var_0 + ": " + var_1[var_0]);
}

_id_14F5() {}

_id_14DB(var_0, var_1) {
  var_2 = getdvarint(var_0);
  setDvar(var_0, var_2 + var_1);
}

_id_14DC(var_0, var_1) {
  var_2 = getdvarfloat(var_0);
  setDvar(var_0, var_2 + var_1);
}

_id_E44D(var_0) {
  return 0;
}

_id_CF80(var_0) {
  if([[level._id_4C6B]](var_0))
    return 1;

  if(isPlayer(var_0))
    return 1;

  if(!isDefined(var_0._id_3A49))
    return 0;

  return var_0 _id_D021();
}

_id_D021() {
  return self._id_CFED * 1.75 > self._id_C078;
}

_id_61BA(var_0, var_1, var_2) {}

_id_2628(var_0, var_1, var_2, var_3) {
  _id_14DB("aa_enemy_deaths", 1);

  if(!isDefined(var_1)) {
    return;
  }
  if(!_id_CF80(var_1)) {
    return;
  }
  [[level._id_83D9]](var_2, self.damagelocation, var_3);
  _id_14DB("aa_player_kills", 1);
}

_id_2627(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isalive(self) || self.delayeddeath) {
    _id_2628(var_0, var_1, var_4, var_3);
    return;
  }

  if(!_id_CF80(var_1)) {
    return;
  }
  _id_14F0(var_0, var_4, var_3);
}

_id_14F0(var_0, var_1, var_2) {
  _id_14DB("aa_player_damage_dealt", var_0);

  if(!level.player scripts\sp\utility::_id_9D27()) {
    [[level._id_83D3]](var_1, self.damagelocation, var_2);
    return 0;
  }

  if(!_id_3234(var_1)) {
    [[level._id_83D3]](var_1, self.damagelocation, var_2);
    return 0;
  }

  [[level._id_83D4]](var_1, self.damagelocation, var_2);
  _id_14DB("aa_ads_damage_dealt", var_0);
  return 1;
}

_id_3234(var_0) {
  if(var_0 == "MOD_PISTOL_BULLET")
    return 1;

  return var_0 == "MOD_RIFLE_BULLET";
}

_id_16D9(var_0, var_1, var_2) {
  if(!isDefined(level._id_54D1[var_0]))
    level._id_54D1[var_0] = [];

  var_3 = [];
  var_3["frac"] = var_1;
  var_3["val"] = var_2;
  level._id_54D1[var_0][level._id_54D1[var_0].size] = var_3;
}

_id_F385() {
  level._id_5FB0 = [];
  level._id_5FB0["europa"] = 1;
  level._id_5FB0["phparade"] = 1;
  level._id_5FB0["phstreets"] = 1;
  level._id_5FB0["phspace"] = 1;
  level._id_5FB0["shipcrib_moon"] = 1;
  level._id_5FB0["moon_port"] = 1;
  level._id_5FB0["moonjackal"] = 1;
  level._id_5FB0["sa_moon"] = 1;
}

_id_E080() {
  level notify("screenfx_force_delete");
  level.player notify("noHealthOverlay");
  level.player._id_550A = 1;
  level.player _id_D259();
  level.player._id_550A = 0;
}

_id_13062() {
  return level._id_13062;
}

_id_1305F() {
  return level._id_1305F;
}

_id_1305E() {
  return level._id_1305E;
}

_id_13069() {
  return level._id_13069;
}

_id_12855(var_0) {
  level.player endon("weapon_change");
  wait 10;

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
  if(scripts\sp\utility::_id_65DF("_stealth_enabled") && scripts\sp\utility::_id_65DB("_stealth_enabled")) {
    return;
  }
  if(isDefined(level._id_4B80) && level._id_4B80) {
    return;
  }
  if(isDefined(self.melee)) {
    return;
  }
  if(level.script == "phstreets" || level.script == "europa") {
    return;
  }
  if(isDefined(level.player._id_9E1C) && level.player._id_9E1C) {
    return;
  }
  scripts\sp\utility::_id_56BE(var_0, 6);
}

_id_13C1A() {
  level endon("stop_weapon_help");
  scripts\engine\utility::flag_init("disable_weapon_help");
  scripts\sp\utility::_id_16EB("alt_m8", &"WEAPON_HELP_M8_AR_DPAD", ::_id_13062);
  scripts\sp\utility::_id_16EB("alt_fmg", &"WEAPON_HELP_FMG_AKIMBO_DPAD", ::_id_1305F);
  scripts\sp\utility::_id_16EB("alt_erad", &"WEAPON_HELP_ERAD_SHOTGUN_DPAD", ::_id_1305E);
  scripts\sp\utility::_id_16EB("alt_ripper", &"WEAPON_HELP_RIPPER_SMG_DPAD", ::_id_13069);
  wait 30;
  var_0 = scripts\sp\endmission::_id_7F6B(level.script);

  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\sp\endmission::getitemslot(var_0))
    return;
  else if(scripts\sp\endmission::getitemdroporiginandangles(var_0))
    return;
  else if(scripts\sp\utility::_id_93A6())
    return;
  else if(level._id_7683 >= 2 && !_id_B327()) {
    return;
  }
  level._id_13062 = 1;
  level._id_1305F = 1;
  level._id_1305E = 1;
  level._id_13069 = 1;
  var_1 = level.player _meth_84C6("hintAltM8");
  var_2 = level.player _meth_84C6("hintAltFMG");
  var_3 = level.player _meth_84C6("hintAltERAD");
  var_4 = level.player _meth_84C6("hintAltRipper");

  if(isDefined(var_1))
    level._id_13062 = var_1;

  if(isDefined(var_2))
    level._id_1305F = var_2;

  if(isDefined(var_3))
    level._id_1305E = var_3;

  if(isDefined(var_4))
    level._id_13069 = var_4;

  var_5 = 0;

  if(level._id_13062)
    var_5++;

  if(level._id_1305F)
    var_5++;

  if(level._id_1305E)
    var_5++;

  if(level._id_13069)
    var_5++;

  wait 300;

  for(;;) {
    if(var_5 >= 3) {
      return;
    }
    level.player waittill("weapon_change", var_6);
    var_7 = level.player _meth_8519(var_6, 1);
    var_8 = getweaponbasename(var_6);
    var_9 = "";

    switch (var_8) {
      case "iw7_m8":
        if(var_7) {
          if(!level._id_13062) {
            level.player _meth_84C7("hintAltM8", 1);
            level._id_13062 = 1;
            var_5++;
          }
        } else
          var_9 = "alt_m8";

        break;
      case "iw7_fmg":
        if(var_7) {
          if(!level._id_1305F) {
            level.player _meth_84C7("hintAltFMG", 1);
            level._id_1305F = 1;
            var_5++;
          }
        } else
          var_9 = "alt_fmg";

        break;
      case "iw7_erad":
        if(var_7) {
          if(!level._id_1305E) {
            level.player _meth_84C7("hintAltERAD", 1);
            level._id_1305E = 1;
            var_5++;
          }
        } else
          var_9 = "alt_erad";

        break;
      case "iw7_ripper":
        if(var_7) {
          if(!level._id_13069) {
            level.player _meth_84C7("hintAltRipper", 1);
            level._id_13069 = 1;
            var_5++;
          }
        } else
          var_9 = "alt_ripper";

        break;
      default:
        continue;
    }

    if(var_9 != "")
      thread _id_12855(var_9);
  }
}