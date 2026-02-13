/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1837.gsc
*************************************************/

_id_7F92() {
  _id_D6CC();
}

_id_D221() {
  level._id_60E6 = getdvarint("#x334665aeaed7c0a22", 1);
  setomnvar("cp_difficulty_level", level._id_60E6);
}

_id_64C1() {
  return level._id_60E6;
}

_id_D6CC(var_0) {
  if(!istrue(var_0)) {
    if(isDefined(level._id_60E6)) {
      return;
    }
    level._id_498D[0] = "easy";
    level._id_498D[1] = "normal";
    level._id_498D[2] = "hardened";
    level._id_498D[3] = "veteran";
    level._id_498B["easy"] = &"GAMESKILL_EASY";
    level._id_498B["normal"] = &"GAMESKILL_NORMAL";
    level._id_498B["hardened"] = &"GAMESKILL_HARDENED";
    level._id_498B["veteran"] = &"GAMESKILL_VETERAN";
  }

  anim._id_C9A3 = 0.5;
  anim._id_1098A = 0.8;
  level._id_9E00 = 8;
  level._id_9DFF = 16;
  level._id_498A["playerGrenadeBaseTime"]["easy"] = 40000;
  level._id_498A["playerGrenadeBaseTime"]["normal"] = 35000;
  level._id_498A["playerGrenadeBaseTime"]["hardened"] = 25000;
  level._id_498A["playerGrenadeBaseTime"]["veteran"] = 25000;
  level._id_498A["playerGrenadeRangeTime"]["easy"] = 20000;
  level._id_498A["playerGrenadeRangeTime"]["normal"] = 15000;
  level._id_498A["playerGrenadeRangeTime"]["hardened"] = 10000;
  level._id_498A["playerGrenadeRangeTime"]["veteran"] = 10000;
  level._id_498A["playerDoubleGrenadeTime"]["easy"] = 3600000;
  level._id_498A["playerDoubleGrenadeTime"]["normal"] = 150000;
  level._id_498A["playerDoubleGrenadeTime"]["hardened"] = 90000;
  level._id_498A["playerDoubleGrenadeTime"]["veteran"] = 45000;
  level._id_498A["double_grenades_allowed"]["easy"] = 0;
  level._id_498A["double_grenades_allowed"]["normal"] = 1;
  level._id_498A["double_grenades_allowed"]["hardened"] = 1;
  level._id_498A["double_grenades_allowed"]["veteran"] = 1;
  level._id_498A["threatbias"]["easy"] = 100;
  level._id_498A["threatbias"]["normal"] = 150;
  level._id_498A["threatbias"]["hardened"] = 200;
  level._id_498A["threatbias"]["veteran"] = 400;
  level._id_498A["base_enemy_accuracy"]["easy"] = 0.9;
  level._id_498A["base_enemy_accuracy"]["normal"] = 1.0;
  level._id_498A["base_enemy_accuracy"]["hardened"] = 1.15;
  level._id_498A["base_enemy_accuracy"]["veteran"] = 1.5;
  level._id_498A["accuracyDistScale"]["easy"] = 1.0;
  level._id_498A["accuracyDistScale"]["normal"] = 1.0;
  level._id_498A["accuracyDistScale"]["hardened"] = 0.8;
  level._id_498A["accuracyDistScale"]["veteran"] = 0.5;
  level._id_498A["min_sniper_burst_delay_time"]["easy"] = 3.0;
  level._id_498A["min_sniper_burst_delay_time"]["normal"] = 2.0;
  level._id_498A["min_sniper_burst_delay_time"]["hardened"] = 1.5;
  level._id_498A["min_sniper_burst_delay_time"]["veteran"] = 0.75;
  level._id_498A["sniper_converge_scale"]["easy"] = 1.3;
  level._id_498A["sniper_converge_scale"]["normal"] = 1.1;
  level._id_498A["sniper_converge_scale"]["hardened"] = 0.9;
  level._id_498A["sniper_converge_scale"]["veteran"] = 0.45;
  level._id_498A["sniperAccuDiffScale"]["easy"] = 1.0;
  level._id_498A["sniperAccuDiffScale"]["normal"] = 1.6;
  level._id_498A["sniperAccuDiffScale"]["hardened"] = 1.6;
  level._id_498A["sniperAccuDiffScale"]["veteran"] = 2.5;
  level._id_498A["max_sniper_burst_delay_time"]["easy"] = 4.0;
  level._id_498A["max_sniper_burst_delay_time"]["normal"] = 3.0;
  level._id_498A["max_sniper_burst_delay_time"]["hardened"] = 2.0;
  level._id_498A["max_sniper_burst_delay_time"]["veteran"] = 1.1;
  level._id_498A["pain_test"]["easy"] = _id_06D7::_id_1655;
  level._id_498A["pain_test"]["normal"] = _id_06D7::_id_1655;
  level._id_498A["pain_test"]["hardened"] = _id_06D7::_id_ADDA;
  level._id_498A["pain_test"]["veteran"] = _id_06D7::_id_ADDA;
  level._id_498A["missTimeConstant"]["easy"] = 1.0;
  level._id_498A["missTimeConstant"]["normal"] = 0.05;
  level._id_498A["missTimeConstant"]["hardened"] = 0.03;
  level._id_498A["missTimeConstant"]["veteran"] = 0.02;
  level._id_498A["missTimeDistanceFactor"]["easy"] = 0.0008;
  level._id_498A["missTimeDistanceFactor"]["normal"] = 0.0001;
  level._id_498A["missTimeDistanceFactor"]["hardened"] = 0.00005;
  level._id_498A["missTimeDistanceFactor"]["veteran"] = 0.00003;
  level._id_498A["player_maxFlashBangTime"]["easy"] = 6;
  level._id_498A["player_maxFlashBangTime"]["normal"] = 8;
  level._id_498A["player_maxFlashBangTime"]["hardened"] = 9;
  level._id_498A["player_maxFlashBangTime"]["veteran"] = 10;
  level._id_498A["invulTime_onDamageMin"]["easy"] = 0.35;
  level._id_498A["invulTime_onDamageMin"]["normal"] = 0.3;
  level._id_498A["invulTime_onDamageMin"]["hardened"] = 0.2;
  level._id_498A["invulTime_onDamageMin"]["veteran"] = 0.2;
  level._id_498A["invulTime_onDamageMax"]["easy"] = 0.35;
  level._id_498A["invulTime_onDamageMax"]["normal"] = 0.3;
  level._id_498A["invulTime_onDamageMax"]["hardened"] = 0.2;
  level._id_498A["invulTime_onDamageMax"]["veteran"] = 0.2;
  level._id_498A["invulTime_onDamage"]["easy"] = 0.35;
  level._id_498A["invulTime_onDamage"]["normal"] = 0.3;
  level._id_498A["invulTime_onDamage"]["hardened"] = 0.2;
  level._id_498A["invulTime_onDamage"]["veteran"] = 0.2;
  level._id_498A["invulTime_deathShieldDuration"]["easy"] = 2.0;
  level._id_498A["invulTime_deathShieldDuration"]["normal"] = 1.0;
  level._id_498A["invulTime_deathShieldDuration"]["hardened"] = 0.5;
  level._id_498A["invulTime_deathShieldDuration"]["veteran"] = 0.25;
  level._id_498A["player_deathsDoorDuration"]["easy"] = 4.0;
  level._id_498A["player_deathsDoorDuration"]["normal"] = 4.0;
  level._id_498A["player_deathsDoorDuration"]["hardened"] = 4.0;
  level._id_498A["player_deathsDoorDuration"]["veteran"] = 4.0;
  level._id_498A["player_healthRegenDelayMin"]["easy"] = 2.1;
  level._id_498A["player_healthRegenDelayMin"]["normal"] = 1.85;
  level._id_498A["player_healthRegenDelayMin"]["hardened"] = 2.7;
  level._id_498A["player_healthRegenDelayMin"]["veteran"] = 3.25;
  level._id_498A["player_healthRegenDelayMax"]["easy"] = 4.35;
  level._id_498A["player_healthRegenDelayMax"]["normal"] = 5.0;
  level._id_498A["player_healthRegenDelayMax"]["hardened"] = 6.0;
  level._id_498A["player_healthRegenDelayMax"]["veteran"] = 7.05;
  level._id_498A["player_healthRegenDelay"]["easy"] = 2.5;
  level._id_498A["player_healthRegenDelay"]["normal"] = 3.0;
  level._id_498A["player_healthRegenDelay"]["hardened"] = 4.0;
  level._id_498A["player_healthRegenDelay"]["veteran"] = 5.05;
  level._id_498A["player_healthRegenRateMin"]["easy"] = 1.25;
  level._id_498A["player_healthRegenRateMin"]["normal"] = 0.65;
  level._id_498A["player_healthRegenRateMin"]["hardened"] = 0.25;
  level._id_498A["player_healthRegenRateMin"]["veteran"] = 0.05;
  level._id_498A["player_healthRegenRateMax"]["easy"] = 18.85;
  level._id_498A["player_healthRegenRateMax"]["normal"] = 14.65;
  level._id_498A["player_healthRegenRateMax"]["hardened"] = 10.55;
  level._id_498A["player_healthRegenRateMax"]["veteran"] = 9.2;
  level._id_498A["player_healthRegenRate"]["easy"] = 40;
  level._id_498A["player_healthRegenRate"]["normal"] = 40;
  level._id_498A["player_healthRegenRate"]["hardened"] = 40;
  level._id_498A["player_healthRegenRate"]["veteran"] = 40;
  level._id_498A["player_health"]["easy"] = 355;
  level._id_498A["player_health"]["normal"] = 180;
  level._id_498A["player_health"]["hardened"] = 140;
  level._id_498A["player_health"]["veteran"] = 80;
  level._id_498A["player_diedRecentlyCooldown"]["easy"] = 70;
  level._id_498A["player_diedRecentlyCooldown"]["normal"] = 30;
  level._id_498A["player_diedRecentlyCooldown"]["hardened"] = 0;
  level._id_498A["player_diedRecentlyCooldown"]["veteran"] = 0;
  level._id_902B = 0;
  level._id_B719 = 0.8;
  _id_7FF4();
  _id_FC7C();
  _id_FBFA();
}

_id_FBFA() {
  _id_D577();

  foreach(var_1 in level.players) {
    var_1 _id_D511();
  }
}

_id_7FF4() {
  level._id_9E75["easy"]["convergenceTime"] = 2.5;
  level._id_9E75["easy"]["suppressionTime"] = 3.0;
  level._id_9E75["easy"]["accuracy"] = 0.38;
  level._id_9E75["easy"]["aiSpread"] = 2;
  level._id_9E75["easy"]["playerSpread"] = 0.5;
  level._id_9E75["medium"]["convergenceTime"] = 1.5;
  level._id_9E75["medium"]["suppressionTime"] = 3.0;
  level._id_9E75["medium"]["accuracy"] = 0.38;
  level._id_9E75["medium"]["aiSpread"] = 2;
  level._id_9E75["medium"]["playerSpread"] = 0.5;
  level._id_9E75["hard"]["convergenceTime"] = 0.8;
  level._id_9E75["hard"]["suppressionTime"] = 3.0;
  level._id_9E75["hard"]["accuracy"] = 0.38;
  level._id_9E75["hard"]["aiSpread"] = 2;
  level._id_9E75["hard"]["playerSpread"] = 0.5;
  level._id_9E75["veteran"]["convergenceTime"] = 0.8;
  level._id_9E75["veteran"]["suppressionTime"] = 3.0;
  level._id_9E75["veteran"]["accuracy"] = 0.38;
  level._id_9E75["veteran"]["aiSpread"] = 2;
  level._id_9E75["veteran"]["playerSpread"] = 0.5;
  level._id_9E75["fu"]["convergenceTime"] = 0.4;
  level._id_9E75["fu"]["suppressionTime"] = 3.0;
  level._id_9E75["fu"]["accuracy"] = 0.38;
  level._id_9E75["fu"]["aiSpread"] = 2;
  level._id_9E75["fu"]["playerSpread"] = 0.5;
}

_id_D511() {
  _id_D1D0();
}

_id_D577() {
  var_0 = _id_06D7::_id_675A(level._id_60E6);
  anim._id_ADDF = _id_06D7::_id_644E("pain_test");
  anim._id_9EA6 = _id_06D7::_id_644E("min_sniper_burst_delay_time");
  anim._id_9C34 = _id_06D7::_id_644E("max_sniper_burst_delay_time");
  setsaveddvar("#x3ca4118fd2695b5a8", _id_06D7::_id_644E("accuracyDistScale"));
}

_id_FC7C() {
  if(isDefined(level._id_5E92)) {
    level._id_60E6 = level._id_5E92;
  } else {
    _id_D221();
  }

  _id_D577();
  return level._id_60E6;
}

_id_19B5(var_0) {
  self._id_7235 = spawnStruct();
  self._id_7235._id_4985 = _id_06D7::_id_644D("player_diedRecentlyCooldown", var_0);
  self._id_7235._id_9C70 = _id_06D7::_id_644D("player_maxFlashBangTime", var_0);
  self._id_7235._id_8535 = _id_06D7::_id_644D("invulTime_onDamageMin", var_0);
  self._id_7235._id_8534 = _id_06D7::_id_644D("invulTime_onDamageMax", var_0);
  self._id_7235._id_8532 = _id_06D7::_id_644D("invulTime_deathShieldDuration", var_0);
  self._id_7235._id_8533 = _id_06D7::_id_644D("invulTime_onDamage", var_0);
  self._id_7235._id_4404 = _id_06D7::_id_644D("player_deathsDoorDuration", var_0);
  self._id_7235._id_CF6D = 1;
  self._id_7235._id_CF6E = 2;
  self._id_7235._id_7646 = _id_06D7::_id_644D("player_healthRegenDelayMin", var_0);
  self._id_7235._id_7645 = _id_06D7::_id_644D("player_healthRegenDelayMax", var_0);
  self._id_7235._id_7644 = _id_06D7::_id_644D("player_healthRegenDelay", var_0);
  self._id_7235._id_764C = _id_06D7::_id_644D("player_healthRegenRateMin", var_0);
  self._id_7235._id_764B = _id_06D7::_id_644D("player_healthRegenRateMax", var_0);
  self._id_7235._id_7644 = _id_06D7::_id_644D("player_healthRegenDelay", var_0);
  self._id_7235._id_764A = _id_06D7::_id_644D("player_healthRegenRate", var_0);
  self._id_7235._id_B3B4 = _id_06D7::_id_644D("base_enemy_accuracy", var_0);
  _id_FBAA();
  self._id_7235._id_B6C1 = int(_id_06D7::_id_644D("playerGrenadeBaseTime", var_0));
  self._id_7235._id_B6C2 = int(_id_06D7::_id_644D("playerGrenadeRangeTime", var_0));
  self._id_7235._id_B69A = int(_id_06D7::_id_644D("playerDoubleGrenadeTime", var_0));
  self._id_7235._id_9EA6 = _id_06D7::_id_644D("min_sniper_burst_delay_time", var_0);
  self._id_7235._id_9C34 = _id_06D7::_id_644D("max_sniper_burst_delay_time", var_0);
  self._id_7235._id_4314 = self.maxhealth / _id_06D7::_id_644D("player_health", var_0);

  if(scripts\common\utility::_id_B65F()) {
    self._id_7235._id_1B65 = _id_06D7::_id_644D("player_armorRatioHealthRegenThreshold", var_0);
    self._id_7235._id_1B4F = _id_06D7::_id_644D("player_armorDamageToHealthRatioMin", var_0);
    self._id_7235._id_1B4E = _id_06D7::_id_644D("player_armorDamageToHealthRatioMax", var_0);
    self._id_7235._id_4312 = self._id_1B26._id_9C54 / _id_06D7::_id_644D("player_armor", var_0);
    self._id_014A = self._id_7235._id_4312;
  } else
    self._id_014A = self._id_7235._id_4314;

  self._id_048A = int(_id_06D7::_id_644D("threatbias", var_0));
}

_id_D1D0() {
  _id_19B5(1);
  _id_06D7::_id_19B6(1);
}

_id_C640() {
  waittillframeend;
  _id_D6CC(1);
}

_id_10C94(var_0) {
  if(getdvarint("#x3a67cf48b25f377f1", -1) != -1) {
    var_0 = getdvarint("#x3a67cf48b25f377f1", -1);
  }

  var_1 = level._id_498D[var_0];

  foreach(var_3 in level.players) {
    var_3._id_7235._id_B3B4 = level._id_498A["base_enemy_accuracy"][var_1];
    var_3._id_0074 = var_3._id_7235._id_B3B4;
    var_3._id_7235._id_B6C1 = int(level._id_498A["playerGrenadeBaseTime"][var_1]);
    var_3._id_7235._id_B6C2 = int(level._id_498A["playerGrenadeRangeTime"][var_1]);
    var_3._id_7235._id_B69A = int(level._id_498A["playerDoubleGrenadeTime"][var_1]);
    var_3._id_7235._id_9EA6 = level._id_498A["min_sniper_burst_delay_time"][var_1];
    var_3._id_7235._id_9C34 = level._id_498A["max_sniper_burst_delay_time"][var_1];
    var_3._id_01F2 = level._id_498A["missTimeConstant"][var_1];
    var_3.gameskilmisstimedistancefactor = level._id_498A["missTimeDistanceFactor"][var_1];
    var_3._id_7235._id_4E95 = level._id_498A["double_grenades_allowed"][var_1];
  }

  anim._id_ADDF = level._id_498A["pain_test"][var_1];
  anim._id_9EA6 = level._id_498A["min_sniper_burst_delay_time"][var_1];
  anim._id_9C34 = level._id_498A["max_sniper_burst_delay_time"][var_1];
  setsaveddvar("#x3ca4118fd2695b5a8", level._id_498A["accuracyDistScale"][var_1]);
}

_id_FBAA() {
  if(!isDefined(self._id_22BF)) {
    self._id_22BF = 0;
  }

  self._id_022F = self._id_22BF;
  self._id_0074 = self._id_7235._id_B3B4;
}

_id_6674() {
  return level._id_60E6;
}