/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\69.gsc
**************************************/

_id_1E8E(var_0) {
  if(!isDefined(level.script)) {
    level.script = tolower(getdvar("mapname"));

  }
  if(!isDefined(var_0) || var_0 == 0) {
    if(isDefined(level.gameskill)) {
      return;
    }
    if(!isDefined(level._id_22DB)) {
      level._id_22DB = ::_id_236A;

    }
    level._id_09B9 = ::_id_236D;
    level._id_09BA = ::_id_236D;
    level._id_09B8 = ::_id_236D;

    if(getdvar("arcademode") == "1") {
      thread maps\_arcademode::main();

    }
    maps\_utility::_id_1DE7();

    foreach(var_2 in level.players) {
      var_2 maps\_utility::_id_1402("player_has_red_flashing_overlay");
      var_2 maps\_utility::_id_1402("player_is_invulnerable");
      var_2 maps\_utility::_id_1402("player_zero_attacker_accuracy");
      var_2 maps\_utility::_id_1402("player_no_auto_blur");
      var_2 maps\_utility::_id_1402("near_death_vision_enabled");
      var_2 maps\_utility::_id_13DC("near_death_vision_enabled");
      var_2._id_20F2 = spawnStruct();
      var_2 _id_22E6();
      var_2.a = spawnStruct();
      var_2._id_215B = [];
      var_2 maps\_player_stats::_id_0A30();
      var_2 maps\_utility::_id_1402("global_hint_in_use");
      var_2.pers = [];

      if(!isDefined(var_2._id_22DC)) {
        var_2._id_22DC = 0;

      }
      var_2.disabledweapon = 0;
      var_2.disabledweaponswitch = 0;
      var_2.disabledusability = 0;
      var_2 setoffhandprimaryclass("frag");
    }

    level._id_22DD[0] = "easy";
    level._id_22DD[1] = "normal";
    level._id_22DD[2] = "hardened";
    level._id_22DD[3] = "veteran";
    level._id_22DE["easy"] = &"GAMESKILL_EASY";
    level._id_22DE["normal"] = &"GAMESKILL_NORMAL";
    level._id_22DE["hardened"] = &"GAMESKILL_HARDENED";
    level._id_22DE["veteran"] = &"GAMESKILL_VETERAN";
    thread _id_22F0();
  }

  setdvarifuninitialized("autodifficulty_playerDeathTimer", 0);
  anim._id_22DF = 0.5;
  anim._id_22E0 = 0.8;
  setdvar("autodifficulty_frac", 0);
  level._id_22E1 = [];

  foreach(var_2 in level.players) {
    var_2 _id_2347();
    var_2 thread _id_2348();
  }

  level._id_22E2 = 8;
  level._id_22E3 = 16;
  level._id_22E4["playerGrenadeBaseTime"]["easy"] = 40000;
  level._id_22E4["playerGrenadeBaseTime"]["normal"] = 35000;
  level._id_22E4["playerGrenadeBaseTime"]["hardened"] = 25000;
  level._id_22E4["playerGrenadeBaseTime"]["veteran"] = 25000;
  level._id_22E4["playerGrenadeRangeTime"]["easy"] = 20000;
  level._id_22E4["playerGrenadeRangeTime"]["normal"] = 15000;
  level._id_22E4["playerGrenadeRangeTime"]["hardened"] = 10000;
  level._id_22E4["playerGrenadeRangeTime"]["veteran"] = 10000;
  level._id_22E4["playerDoubleGrenadeTime"]["easy"] = 3600000;
  level._id_22E4["playerDoubleGrenadeTime"]["normal"] = 150000;
  level._id_22E4["playerDoubleGrenadeTime"]["hardened"] = 90000;
  level._id_22E4["playerDoubleGrenadeTime"]["veteran"] = 90000;
  level._id_22E4["double_grenades_allowed"]["easy"] = 0;
  level._id_22E4["double_grenades_allowed"]["normal"] = 1;
  level._id_22E4["double_grenades_allowed"]["hardened"] = 1;
  level._id_22E4["double_grenades_allowed"]["veteran"] = 1;
  level._id_22E4["threatbias"]["easy"] = 100;
  level._id_22E4["threatbias"]["normal"] = 150;
  level._id_22E4["threatbias"]["hardened"] = 200;
  level._id_22E4["threatbias"]["veteran"] = 400;
  level._id_22E4["base_enemy_accuracy"]["easy"] = 0.9;
  level._id_22E4["base_enemy_accuracy"]["normal"] = 1.0;
  level._id_22E4["base_enemy_accuracy"]["hardened"] = 1.15;
  level._id_22E4["base_enemy_accuracy"]["veteran"] = 1.15;
  level._id_22E4["accuracyDistScale"]["easy"] = 1.0;
  level._id_22E4["accuracyDistScale"]["normal"] = 1.0;
  level._id_22E4["accuracyDistScale"]["hardened"] = 0.6;
  level._id_22E4["accuracyDistScale"]["veteran"] = 0.8;
  level._id_22E4["min_sniper_burst_delay_time"]["easy"] = 3.0;
  level._id_22E4["min_sniper_burst_delay_time"]["normal"] = 2.0;
  level._id_22E4["min_sniper_burst_delay_time"]["hardened"] = 1.5;
  level._id_22E4["min_sniper_burst_delay_time"]["veteran"] = 1.1;
  level._id_22E4["max_sniper_burst_delay_time"]["easy"] = 4.0;
  level._id_22E4["max_sniper_burst_delay_time"]["normal"] = 3.0;
  level._id_22E4["max_sniper_burst_delay_time"]["hardened"] = 2.0;
  level._id_22E4["max_sniper_burst_delay_time"]["veteran"] = 1.5;
  level._id_22E4["dog_health"]["easy"] = 0.25;
  level._id_22E4["dog_health"]["normal"] = 0.75;
  level._id_22E4["dog_health"]["hardened"] = 1.0;
  level._id_22E4["dog_health"]["veteran"] = 1.0;
  level._id_22E4["dog_presstime"]["easy"] = 415;
  level._id_22E4["dog_presstime"]["normal"] = 375;
  level._id_22E4["dog_presstime"]["hardened"] = 250;
  level._id_22E4["dog_presstime"]["veteran"] = 225;
  level._id_22E4["dog_hits_before_kill"]["easy"] = 2;
  level._id_22E4["dog_hits_before_kill"]["normal"] = 1;
  level._id_22E4["dog_hits_before_kill"]["hardened"] = 0;
  level._id_22E4["dog_hits_before_kill"]["veteran"] = 0;
  level._id_22E4["pain_test"]["easy"] = ::_id_230D;
  level._id_22E4["pain_test"]["normal"] = ::_id_230D;
  level._id_22E4["pain_test"]["hardened"] = ::_id_230E;
  level._id_22E4["pain_test"]["veteran"] = ::_id_230E;
  level._id_22E4["missTimeConstant"]["easy"] = 1.0;
  level._id_22E4["missTimeConstant"]["normal"] = 0.05;
  level._id_22E4["missTimeConstant"]["hardened"] = 0;
  level._id_22E4["missTimeConstant"]["veteran"] = 0;
  level._id_22E4["missTimeDistanceFactor"]["easy"] = 0.0008;
  level._id_22E4["missTimeDistanceFactor"]["normal"] = 0.0001;
  level._id_22E4["missTimeDistanceFactor"]["hardened"] = 0.00005;
  level._id_22E4["missTimeDistanceFactor"]["veteran"] = 0;
  level._id_22E4["flashbangedInvulFactor"]["easy"] = 0.25;
  level._id_22E4["flashbangedInvulFactor"]["normal"] = 0;
  level._id_22E4["flashbangedInvulFactor"]["hardened"] = 0;
  level._id_22E4["flashbangedInvulFactor"]["veteran"] = 0;
  level._id_22E4["player_criticalBulletDamageDist"]["easy"] = 0;
  level._id_22E4["player_criticalBulletDamageDist"]["normal"] = 0;
  level._id_22E4["player_criticalBulletDamageDist"]["hardened"] = 0;
  level._id_22E4["player_criticalBulletDamageDist"]["veteran"] = 0;
  level._id_22E4["player_deathInvulnerableTime"]["easy"] = 4000;
  level._id_22E4["player_deathInvulnerableTime"]["normal"] = 2500;
  level._id_22E4["player_deathInvulnerableTime"]["hardened"] = 600;
  level._id_22E4["player_deathInvulnerableTime"]["veteran"] = 100;
  level._id_22E4["invulTime_preShield"]["easy"] = 0.6;
  level._id_22E4["invulTime_preShield"]["normal"] = 0.5;
  level._id_22E4["invulTime_preShield"]["hardened"] = 0.3;
  level._id_22E4["invulTime_preShield"]["veteran"] = 0.0;
  level._id_22E4["invulTime_onShield"]["easy"] = 1.6;
  level._id_22E4["invulTime_onShield"]["normal"] = 1.0;
  level._id_22E4["invulTime_onShield"]["hardened"] = 0.5;
  level._id_22E4["invulTime_onShield"]["veteran"] = 0.25;
  level._id_22E4["invulTime_postShield"]["easy"] = 0.5;
  level._id_22E4["invulTime_postShield"]["normal"] = 0.4;
  level._id_22E4["invulTime_postShield"]["hardened"] = 0.3;
  level._id_22E4["invulTime_postShield"]["veteran"] = 0.0;
  level._id_22E4["playerHealth_RegularRegenDelay"]["easy"] = 4000;
  level._id_22E4["playerHealth_RegularRegenDelay"]["normal"] = 4000;
  level._id_22E4["playerHealth_RegularRegenDelay"]["hardened"] = 3000;
  level._id_22E4["playerHealth_RegularRegenDelay"]["veteran"] = 1200;
  level._id_22E4["worthyDamageRatio"]["easy"] = 0.0;
  level._id_22E4["worthyDamageRatio"]["normal"] = 0.1;
  level._id_22E4["worthyDamageRatio"]["hardened"] = 0.3;
  level._id_22E4["worthyDamageRatio"]["veteran"] = 0.3;
  level._id_22E4["playerDifficultyHealth"]["easy"] = 475;
  level._id_22E4["playerDifficultyHealth"]["normal"] = 275;
  level._id_22E4["playerDifficultyHealth"]["hardened"] = 165;
  level._id_22E4["playerDifficultyHealth"]["veteran"] = 115;
  level._id_22E4["longRegenTime"]["easy"] = 5000;
  level._id_22E4["longRegenTime"]["normal"] = 5000;
  level._id_22E4["longRegenTime"]["hardened"] = 3200;
  level._id_22E4["longRegenTime"]["veteran"] = 3200;
  level._id_22E4["healthOverlayCutoff"]["easy"] = 0.02;
  level._id_22E4["healthOverlayCutoff"]["normal"] = 0.02;
  level._id_22E4["healthOverlayCutoff"]["hardened"] = 0.02;
  level._id_22E4["healthOverlayCutoff"]["veteran"] = 0.02;
  level._id_22E4["health_regenRate"]["easy"] = 0.02;
  level._id_22E4["health_regenRate"]["normal"] = 0.02;
  level._id_22E4["health_regenRate"]["hardened"] = 0.02;
  level._id_22E4["health_regenRate"]["veteran"] = 0.02;
  level._id_22E4["explosivePlantTime"]["easy"] = 10;
  level._id_22E4["explosivePlantTime"]["normal"] = 10;
  level._id_22E4["explosivePlantTime"]["hardened"] = 5;
  level._id_22E4["explosivePlantTime"]["veteran"] = 5;
  level._id_22E4["player_downed_buffer_time"]["normal"] = 2;
  level._id_22E4["player_downed_buffer_time"]["hardened"] = 1.5;
  level._id_22E4["player_downed_buffer_time"]["veteran"] = 0;
  level._id_20C2 = 0;
  setsaveddvar("player_meleeDamageMultiplier", 0.4);

  if(isDefined(level._id_22E5)) {
    [[level._id_22E5]]();

  }
  if(_id_2372()) {
    _id_22E9();

  }
  _id_22EF();
  _id_22EA();
  setdvar("autodifficulty_original_setting", level.gameskill);
}

_id_22E6() {
  self._id_20F2._id_22E7 = [];
  var_0 = ["bottom", "left", "right"];
  var_1 = ["bloodsplat", "dirt"];

  foreach(var_3 in var_1) {
    foreach(var_5 in var_0) {
      self._id_20F2._id_22E7[var_3][var_5] = 0;
      self._id_20F2._id_22E7[var_3 + "_count"][var_5] = 0;
    }
  }
}

_id_17DD() {
  setsaveddvar("player_meleeDamageMultiplier", 0.26);
}

_id_17DB() {
  if(!maps\_utility::_id_12DC()) {
    setsaveddvar("player_deathInvulnerableToMelee", "1");
    setsaveddvar("ai_accuracy_attackercountDecrease", "0.6");
  }

  level._id_22E4["playerHealth_RegularRegenDelay"]["normal"] = 2000;
  level._id_22E4["playerHealth_RegularRegenDelay"]["hardened"] = 2000;
  level._id_22E4["playerHealth_RegularRegenDelay"]["veteran"] = 900;

  if(!maps\_utility::_id_12DC()) {
    level._id_22E4["invulTime_onShield"]["normal"] = 2.5;
  } else {
    level._id_22E4["invulTime_onShield"]["normal"] = 1.5;

  }
  level._id_22E4["player_deathInvulnerableTime"]["normal"] = 3000;
  level._id_22E4["player_deathInvulnerableTime"]["hardened"] = 1300;
  level._id_22E4["player_deathInvulnerableTime"]["veteran"] = 800;
  level._id_22E4["longRegenTime"]["normal"] = 4500;
  level._id_22E4["longRegenTime"]["hardened"] = 4500;
  level._id_22E4["longRegenTime"]["veteran"] = 4500;
  level._id_22E4["playerDifficultyHealth"]["normal"] = 350;
  level._id_22E4["playerDifficultyHealth"]["hardened"] = 205;
  level._id_22E4["playerDifficultyHealth"]["veteran"] = 205;

  if(!maps\_utility::_id_12DC()) {
    setsaveddvar("player_meleeDamageMultiplier", 0.5);
  } else {
    setsaveddvar("player_meleeDamageMultiplier", 0.26);
  }
}

_id_22E8() {
  level._id_22E4["player_deathInvulnerableTime"]["normal"] = 2500;
  level._id_22E4["player_deathInvulnerableTime"]["hardened"] = 1200;
  level._id_22E4["player_deathInvulnerableTime"]["veteran"] = 200;
  var_0 = 1.35;
  level._id_22E4["playerDifficultyHealth"]["normal"] = int(275 * var_0);
  level._id_22E4["playerDifficultyHealth"]["hardened"] = int(165 * var_0);
  level._id_22E4["playerDifficultyHealth"]["veteran"] = int(138.0);
}

_id_22E9() {
  level._id_22E4["player_deathInvulnerableTime"]["normal"] = 2500;
  level._id_22E4["player_deathInvulnerableTime"]["hardened"] = 1000;
  var_0 = 1.25;
  level._id_22E4["playerDifficultyHealth"]["normal"] = int(275 * var_0);
  level._id_22E4["playerDifficultyHealth"]["hardened"] = int(165 * var_0);
}

_id_22EA() {
  _id_17D1();

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] _id_17D2();
  }
}

_id_17D2() {
  _id_2305();
}

_id_17D1() {
  var_0 = ::_id_230C;
  var_1 = _id_22F1(level.gameskill);
  anim._id_22EB = [[var_0]]("dog_health", level.gameskill);
  anim._id_0D10 = level._id_22E4["pain_test"][var_1];
  level._id_22EC = level._id_22E4["explosivePlantTime"][var_1];
  anim._id_22ED = [[var_0]]("min_sniper_burst_delay_time", level.gameskill);
  anim._id_22EE = [[var_0]]("max_sniper_burst_delay_time", level.gameskill);
  setsaveddvar("ai_accuracyDistScale", [[var_0]]("accuracyDistScale", level.gameskill));

  if(maps\_utility::_id_1A5C()) {
    level._id_1A65 = level._id_22E4["player_downed_buffer_time"][var_1];

  }
  maps\_mgturret::_id_17D2();
}

_id_22EF() {
  foreach(var_1 in level.players) {
    if(maps\_utility::_id_12DC()) {
      var_1.gameskill = 1;
      continue;
    }

    var_1.gameskill = var_1 maps\_utility::_id_198F();
  }

  level.gameskill = level.player.gameskill;

  if(maps\_utility::_id_12C1() && level._id_1337.gameskill > level.gameskill) {
    level.gameskill = level._id_1337.gameskill;

  }
  level._id_16D1 = level.player.gameskill;

  if(maps\_utility::_id_12C1() && level._id_1337.gameskill < level._id_16D1) {
    level._id_16D1 = level._id_1337.gameskill;

  }
  if(isDefined(level._id_1969)) {
    level.gameskill = level._id_1969;

  }
  return level.gameskill;
}

_id_22F0() {
  var_0 = level.gameskill;

  for(;;) {
    if(!isDefined(var_0)) {
      wait 1;
      var_0 = level.gameskill;
      continue;
    }

    if(var_0 != _id_22EF()) {
      var_0 = level.gameskill;
      _id_22EA();
    }

    wait 1;
  }
}

_id_22F1(var_0) {
  return level._id_22DD[var_0];
}

_id_22F2() {
  if(level.script == "killhouse") {
    return 1;

  }
  return level.gameskill == getdvarint("autodifficulty_original_setting");
}

_id_22F3(var_0, var_1) {
  self._id_20F2._id_22F4 = [[var_0]]("invulTime_preShield", var_1);
  self._id_20F2._id_22F5 = [[var_0]]("invulTime_onShield", var_1);
  self._id_20F2._id_22F6 = [[var_0]]("invulTime_postShield", var_1);
  self._id_20F2.playerhealth_regularregendelay = [[var_0]]("playerHealth_RegularRegenDelay", var_1);
  self._id_20F2._id_22F8 = [[var_0]]("worthyDamageRatio", var_1);
  self.threatbias = int([[var_0]]("threatbias", var_1));
  self._id_20F2._id_22F9 = [[var_0]]("longRegenTime", var_1);
  self._id_20F2.healthoverlaycutoff = [[var_0]]("healthOverlayCutoff", var_1);
  self._id_20F2._id_22FB = [[var_0]]("health_regenRate", var_1);
  self._id_20F2._id_22FC = [[var_0]]("base_enemy_accuracy", var_1);
  _id_22FF();
  self._id_20F2._id_22FD = int([[var_0]]("playerGrenadeBaseTime", var_1));
  self._id_20F2._id_20F3 = int([[var_0]]("playerGrenadeRangeTime", var_1));
  self._id_20F2._id_20F4 = int([[var_0]]("playerDoubleGrenadeTime", var_1));
  self._id_20F2._id_22ED = [[var_0]]("min_sniper_burst_delay_time", var_1);
  self._id_20F2._id_22EE = [[var_0]]("max_sniper_burst_delay_time", var_1);
  self._id_20F2._id_22FE = [[var_0]]("dog_presstime", var_1);
  self.deathinvulnerabletime = int([[var_0]]("player_deathInvulnerableTime", var_1));
  self.criticalbulletdamagedist = int([[var_0]]("player_criticalBulletDamageDist", var_1));
  self.damagemultiplier = 100 / [[var_0]]("playerDifficultyHealth", var_1);
}

_id_22FF() {
  if(maps\_utility::_id_1008("player_zero_attacker_accuracy")) {
    return;
  }
  self.ignorerandombulletdamage = self._id_22DC;
  self.attackeraccuracy = self._id_20F2._id_22FC;
}

_id_2300(var_0, var_1) {
  self._id_20F2._id_2301 = [[var_0]]("missTimeConstant", var_1);
  self._id_20F2._id_2302 = [[var_0]]("missTimeDistanceFactor", var_1);
  self._id_20F2._id_2303 = [[var_0]]("dog_hits_before_kill", var_1);
  self._id_20F2._id_2304 = [[var_0]]("double_grenades_allowed", var_1);
}

_id_2305() {
  _id_22F3(::_id_230B, 1);
  _id_2300(::_id_2306, 1);
}

_id_2306(var_0, var_1) {
  return level._id_22E4[var_0][_id_22F1(self.gameskill)];
}

_id_2307(var_0, var_1) {
  return level._id_22E4[var_0][_id_22F1(level.gameskill)];
}

_id_2308(var_0, var_1) {
  var_2 = level._id_22E1[var_0];

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

_id_2309(var_0) {
  return level._id_22E4[var_0][_id_22F1(self.gameskill)];
}

_id_230A(var_0, var_1, var_2) {
  return (level._id_22E4[var_0][level._id_22DD[var_1]] * (100 - getdvarint("autodifficulty_frac")) + level._id_22E4[var_0][level._id_22DD[var_2]] * getdvarint("autodifficulty_frac")) * 0.01;
}

_id_230B(var_0, var_1) {
  return level._id_22E4[var_0][_id_22F1(self.gameskill)];
}

_id_230C(var_0, var_1) {
  return level._id_22E4[var_0][_id_22F1(level.gameskill)];
}

_id_230D() {
  return 0;
}

_id_230E() {
  if(!_id_230F()) {
    return 0;

  }
  return randomint(100) > 25;
}

_id_230F() {
  if(!isalive(self.enemy)) {
    return 0;

  }
  if(!isplayer(self.enemy)) {
    return 0;

  }
  if(!isalive(level._id_20D8) || level._id_20D8.script != "pain") {
    level._id_20D8 = self;

  }
  if(self == level._id_20D8) {
    return 0;

  }
  if(self.damageweapon != "none" && weaponisboltaction(self.damageweapon)) {
    return 0;

  }
  return 1;
}

_id_2310() {
  if(animscripts\combat_utility::issniper() && isalive(self.enemy)) {
    _id_2312();
    return;
  }

  if(isplayer(self.enemy)) {
    _id_231A();

    if(self.a._id_19B8 > gettime()) {
      self.accuracy = 0;
      return;
    }
  }

  if(self.script == "move") {
    if(animscripts\utility::_id_10B9()) {
      self.accuracy = anim._id_22E0 * self._id_20AF;
    } else {
      self.accuracy = anim._id_22DF * self._id_20AF;

    }
    return;
  }

  self.accuracy = self._id_20AF;

  if(isDefined(self._id_0F8F) && isDefined(self._id_2311)) {
    self.accuracy = self.accuracy * self._id_2311;
  }
}

_id_2312() {
  if(!isDefined(self._id_0D0A)) {
    self._id_0D0A = 0;
    self._id_0D0B = 0;
  }

  self._id_0D0A++;
  var_0 = level.gameskill;

  if(isplayer(self.enemy)) {
    var_0 = self.enemy.gameskill;

  }
  if(_id_2314()) {
    self.accuracy = 0;

    if(var_0 > 0 || self._id_0D0A > 1) {
      self._id_2313 = self.enemy;

    }
    return;
  }

  self.accuracy = (1 + 1 * self._id_0D0B) * self._id_20AF;
  self._id_0D0B++;

  if(var_0 < 1 && self._id_0D0B == 1) {
    self._id_2313 = undefined;
  }
}

_id_2314() {
  if(isDefined(self._id_2315) && self._id_2315) {
    return 0;

  }
  if(self.team == "allies") {
    return 0;

  }
  if(isDefined(self._id_2313) && self.enemy == self._id_2313) {
    return 0;

  }
  if(distancesquared(self.origin, self.enemy.origin) > 250000) {
    return 0;

  }
  return 1;
}

_id_2316() {
  return 1 + randomfloat(4);
}

_id_0F89() {
  self.a._id_20B0 = 0;
}

_id_2317() {
  _id_0CD8();
}

_id_2318() {
  var_0 = 0;
  waittillframeend;

  if(!isalive(self.enemy)) {
    return var_0;

  }
  if(!isplayer(self.enemy)) {
    return var_0;

  }
  if(self.enemy maps\_utility::_id_1008("player_is_invulnerable")) {
    var_0 = 0.3 + randomfloat(0.4);

  }
  return var_0;
}

_id_2319(var_0, var_1, var_2, var_3) {
  var_3 = var_3 * 20;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    wait 0.05;
  }
}

_id_0CD8() {
  if(!self isbadguy()) {
    return;
  }
  if(self.weapon == "none") {
    return;
  }
  if(!animscripts\weaponlist::_id_0CCA() && !animscripts\weaponlist::_id_0CCB()) {
    self._id_19B8 = 0;
    return;
  }

  if(!isalive(self.enemy)) {
    return;
  }
  if(!isplayer(self.enemy)) {
    self.accuracy = self._id_20AF;
    return;
  }

  var_0 = distance(self.enemy.origin, self.origin);
  _id_231B(self.enemy._id_20F2._id_2301 + var_0 * self.enemy._id_20F2._id_2302);
}

_id_231A() {
  self.a._id_20B0 = gettime() + 3000;
}

_id_231B(var_0) {
  if(self.a._id_20B0 > gettime()) {
    return;
  }
  if(var_0 > 0) {
    self.accuracy = 0;

  }
  var_0 = var_0 * 1000;
  self.a._id_19B8 = gettime() + var_0;
  self.a._id_231C = 1;
}

_id_231D() {
  self endon("death");
  self notify("playeraim");
  self endon("playeraim");

  for(;;) {
    var_0 = (0, 1, 0);

    if(self.a._id_19B8 > gettime()) {
      var_0 = (1, 0, 0);

    }
    wait 0.05;
  }
}

_id_231E(var_0, var_1, var_2) {
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
  _id_2320();
}

_id_231F(var_0, var_1, var_2) {
  var_3 = 1;

  if(var_2) {
    var_3 = -1;

  }
  var_4 = randomfloatrange(-15, 15);
  var_5 = randomfloatrange(-15, 15);
  self scaleovertime(0.1, int(2048 * var_1), int(1152 * var_1));
  self.x = 1000 * var_3 + var_4;
  self moveovertime(0.1);
  self.x = 0 + var_4;
  self.y = self.y + var_5;
  _id_2320();
}

_id_2320() {
  self endon("death");
  var_0 = gettime();
  var_1 = 1;
  var_2 = 0.05;
  self.alpha = 0;
  self fadeovertime(var_2);
  self.alpha = 1;
  wait(var_2);
  maps\_utility::_id_1254(var_0, 2);
  self fadeovertime(var_1);
  self.alpha = 0;
  wait(var_1);
  self destroy();
}

_id_2321() {
  var_0 = 0.2;
  self.alpha = 0.7;
  self fadeovertime(var_0);
  self.alpha = 0;
  wait(var_0);
  self destroy();
}

_id_2322(var_0) {
  var_1 = "fullscreen_dirt_" + var_0;
  var_2 = undefined;

  if(var_0 == "bottom") {
    var_2 = "fullscreen_dirt_bottom_b";

  }
  thread _id_2324("dirt", var_0, var_1, var_2, randomfloatrange(0.55, 0.66));
}

_id_2323(var_0) {
  var_1 = "fullscreen_bloodsplat_" + var_0;
  thread _id_2324("bloodsplat", var_0, var_1, undefined, randomfloatrange(0.45, 0.56));
}

_id_2324(var_0, var_1, var_2, var_3, var_4) {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self._id_2259)) {
    return;
  }
  var_5 = gettime();

  if(self._id_20F2._id_22E7[var_0][var_1] == var_5) {
    return;
  }
  if(self._id_20F2._id_22E7[var_0 + "_count"][var_1] == 1) {
    return;
  }
  self._id_20F2._id_22E7[var_0 + "_count"][var_1]++;
  self._id_20F2._id_22E7[var_0][var_1] = var_5;
  self endon("death");

  switch (var_1) {
    case "bottom":
      var_6 = int(640);
      var_7 = int(480);

      if(var_0 == "dirt") {
        var_8 = maps\_hud_util::_id_09A8(var_2, 1, var_6, var_7);
        var_8 thread _id_231E(var_0, var_4, 1);
        var_8 _id_2321();
      } else {
        var_8 = maps\_hud_util::_id_09A8(var_2, 0, var_6, var_7);
        var_8 _id_231E(var_0, var_4);
      }

      if(isDefined(var_3)) {
        var_9 = maps\_hud_util::_id_09A8(var_3, 0, var_6, var_7);
        var_9 _id_231E(var_0, var_4);
      }

      break;
    case "left":
      var_8 = maps\_hud_util::_id_09A8(var_2, 0, 1, 1);
      var_8 _id_231F(var_0, var_4, 1);
      break;
    case "right":
      var_8 = maps\_hud_util::_id_09A8(var_2, 0, 1, 1);
      var_8 _id_231F(var_0, var_4, 0);
      break;
    default:
  }

  self._id_20F2._id_22E7[var_1 + "_count"][var_2]--;
}

_id_2325() {
  var_0 = maps\_utility::_id_2326;
  var_1 = maps\_utility::_id_2327;
  var_2 = [];
  var_2["MOD_GRENADE"] = var_0;
  var_2["MOD_GRENADE_SPLASH"] = var_0;
  var_2["MOD_PROJECTILE"] = var_0;
  var_2["MOD_PROJECTILE_SPLASH"] = var_0;
  var_2["MOD_EXPLOSIVE"] = var_0;
  var_2["MOD_PISTOL_BULLET"] = var_1;
  var_2["MOD_RIFLE_BULLET"] = var_1;
  var_2["MOD_EXPLOSIVE_BULLET"] = var_1;
  self._id_2328 = 0;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7);
    self._id_2328 = 1;
    self._id_2329 = var_6;
    self._id_232A = var_4;
    var_8 = undefined;

    if(isDefined(self._id_232B)) {
      var_8 = self._id_232B[var_7];

    }
    if(!isDefined(var_8) && isDefined(var_2[var_7])) {
      var_8 = var_2[var_7];

    }
    if(isDefined(var_8)) {
      waittillframeend;
      [[var_8]](var_6);
    }
  }
}

_id_232C() {
  self._id_232C = 3;
}

_id_1E94() {
  wait 0.05;
  level._id_09A3["take_cover"] = spawnStruct();
  level._id_09A3["take_cover"].text = &"GAME_GET_TO_COVER";
  level._id_09A3["get_back_up"] = spawnStruct();
  level._id_09A3["get_back_up"].text = &"GAME_LAST_STAND_GET_BACK_UP";
}

playerhealthregen() {
  thread _id_2334();
  var_0 = 1;
  var_1 = 0;
  thread _id_232C();
  var_2 = 0;
  var_3 = 0;
  thread _id_2333(self.maxhealth * 0.35);
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 1;
  thread _id_2325();
  self._id_232E = 0;

  for(;;) {
    wait 0.05;
    waittillframeend;

    if(maps\_utility::_id_1A5C()) {
      thread maps\_laststand::_id_1A5B();

    }
    if(self.health == self.maxhealth) {
      if(maps\_utility::_id_1008("player_has_red_flashing_overlay")) {
        _id_2345();

      }
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

    if(var_9 <= self._id_20F2.healthoverlaycutoff && self._id_232C > 1) {
      var_2 = 1;

      if(!var_8) {
        var_5 = gettime();

        if(maps\_utility::_id_1008("near_death_vision_enabled")) {
          thread _id_2332(3.6, 2);
          thread maps\_audio::_id_171E();
          self painvisionon();
        }

        maps\_utility::_id_13DC("player_has_red_flashing_overlay");
        var_3 = 1;
      }
    }

    if(self._id_2328) {
      var_5 = gettime();
      self._id_2328 = 0;
    }

    if(self.health / self.maxhealth >= var_0) {
      if(gettime() - var_5 < self._id_20F2.playerhealth_regularregendelay) {
        continue;
      }
      if(var_2) {
        var_6 = var_9;

        if(gettime() > var_5 + self._id_20F2._id_22F9) {
          var_6 = var_6 + self._id_20F2._id_22FB;

        }
        if(var_6 >= 1) {
          _id_232F();
        }
      } else {
        var_6 = 1;

      }
      if(var_6 > 1.0) {
        var_6 = 1.0;

      }
      if(var_6 <= 0) {
        return;
      }
      self setnormalhealth(var_6);
      var_0 = self.health / self.maxhealth;
      continue;
    }

    var_0 = var_7;
    var_10 = self._id_20F2._id_22F8;

    if(self.attackercount == 1) {
      var_10 = var_10 * 3;

    }
    var_11 = var_0 - var_9 >= var_10;

    if(self.health <= 1) {
      self setnormalhealth(2 / self.maxhealth);
      var_11 = 1;
    }

    var_0 = self.health / self.maxhealth;
    self notify("hit_again");
    var_1 = 0;
    var_5 = gettime();
    thread _id_2332(3, 0.8);

    if(!var_11) {
      continue;
    }
    if(maps\_utility::_id_1008("player_is_invulnerable")) {
      continue;
    }
    maps\_utility::_id_13DC("player_is_invulnerable");
    level notify("player_becoming_invulnerable");

    if(var_3) {
      var_4 = self._id_20F2._id_22F5;
      var_3 = 0;
    } else if(var_2) {
      var_4 = self._id_20F2._id_22F6;
    } else {
      var_4 = self._id_20F2._id_22F4;

    }
    var_7 = self.health / self.maxhealth;
    thread _id_2330(var_4);
  }
}

_id_232F() {
  if(!_id_2341()) {
    return;
  }
  if(isalive(self)) {
    var_0 = self getlocalplayerprofiledata("takeCoverWarnings");

    if(var_0 > 0) {
      var_0--;
      self setlocalplayerprofiledata("takeCoverWarnings", var_0);
    }
  }
}

_id_2330(var_0) {
  if(isDefined(self.flashendtime) && self.flashendtime > gettime()) {
    var_0 = var_0 * _id_2309("flashbangedInvulFactor");

  }
  if(var_0 > 0) {
    if(!isDefined(self._id_2331)) {
      self.attackeraccuracy = 0;

    }
    self.ignorerandombulletdamage = 1;
    wait(var_0);
  }

  _id_22FF();
  maps\_utility::_id_13DE("player_is_invulnerable");
}

_id_216D() {
  if(self.team == "allies") {
    self._id_10A3 = 0.6;

  }
  if(self isbadguy()) {
    if(level.gameskill >= 2) {
      self._id_10A3 = 0.8;
    } else {
      self._id_10A3 = 0.6;
    }
  }
}

grenadeawareness() {
  if(self.team == "allies") {
    self.grenadeawareness = 0.9;
    return;
  }

  if(self isbadguy()) {
    if(level.gameskill >= 2) {
      if(randomint(100) < 33) {
        self.grenadeawareness = 0.2;
      } else {
        self.grenadeawareness = 0.5;
      }
    } else if(randomint(100) < 33) {
      self.grenadeawareness = 0;
    } else {
      self.grenadeawareness = 0.2;
    }
  }
}

_id_2332(var_0, var_1) {
  if(maps\_utility::_id_1008("player_no_auto_blur")) {
    return;
  }
  self notify("blurview_stop");
  self endon("blurview_stop");
  self setblurforplayer(var_0, 0);
  wait 0.05;
  self setblurforplayer(0, var_1);
}

_id_2333(var_0) {
  wait 2;

  for(;;) {
    wait 0.2;

    if(self.health <= 0) {
      return;
    }
    var_1 = self.health / self.maxhealth;

    if(var_1 > self._id_20F2.healthoverlaycutoff) {
      continue;
    }
    if(isDefined(self._id_1718) && self._id_1718) {
      continue;
    }
    self playlocalsound("breathing_hurt");
    wait(0.1 + randomfloat(0.8));
  }
}

_id_2334() {
  self endon("noHealthOverlay");
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;

  if(issplitscreen()) {
    var_0 setshader("splatter_alt_sp", 640, 960);

    if(self == level.players[0]) {
      var_0.y = var_0.y - 120;
    }
  } else {
    var_0 setshader("splatter_alt_sp", 640, 480);

  }
  var_0.splatter = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  thread _id_2346(var_0);
  thread _id_2335();
  var_1 = 0.0;
  var_2 = 0.05;

  for(var_3 = 0.3; isalive(self); var_0.alpha = var_1) {
    wait(var_2);
    var_4 = 1.0 - self.health / self.maxhealth;
    var_5 = var_4 * var_4 * 1.2;
    var_5 = clamp(var_5, 0, 1);

    if(var_1 > var_5) {
      var_1 = var_1 - var_3 * var_2;

    }
    if(var_1 < var_5) {
      var_1 = var_5;
    }
  }
}

_id_2335() {
  while(isalive(self)) {
    maps\_utility::_id_1654("player_has_red_flashing_overlay");
    _id_2344();
  }
}

_id_2336(var_0) {
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

  if(!isDefined(self._id_2337)) {
    return;
  }
  self._id_2337.x = 0;
  self._id_2337.y = -40;
  self._id_2337.alignx = "center";
  self._id_2337.aligny = "middle";
  self._id_2337.horzalign = "center";
  self._id_2337.vertalign = "middle";

  if(level.console) {
    self._id_2337 setshader("popmenu_bg", 650, 52);
  } else {
    self._id_2337 setshader("popmenu_bg", 650, 42);

  }
  self._id_2337.alpha = 0.5;
}

_id_2338() {
  var_0 = newclienthudelem(self);
  var_0 _id_2336();
  thread _id_233A(var_0);
  var_0 thread _id_233B();

  if(maps\_utility::_id_1A43(self)) {
    var_0 settext(level._id_09A3["get_back_up"].text);
  } else {
    var_0 settext(level._id_09A3["take_cover"].text);

  }
  var_0.fontscale = 2;
  var_0.alpha = 1;
  var_0.color = (1, 0.9, 0.9);
  var_0.sort = 1;
  var_0.foreground = 1;
  return var_0;
}

_id_2339() {
  self endon("hit_again");
  self endon("player_downed");
  self waittill("damage");
}

_id_233A(var_0) {
  var_0 endon("being_destroyed");
  _id_2339();
  var_1 = !isalive(self);
  var_0 thread _id_233C(var_1);
}

_id_233B() {
  self endon("being_destroyed");
  common_scripts\utility::flag_wait("missionfailed");
  thread _id_233C(1);
}

_id_233C(var_0) {
  self notify("being_destroyed");
  self._id_233D = 1;

  if(var_0) {
    self fadeovertime(0.5);
    self.alpha = 0;
    wait 0.5;
  }

  self notify("death");
  self destroy();
}

_id_233E(var_0) {
  if(!isDefined(var_0)) {
    return 0;

  }
  if(isDefined(var_0._id_233D)) {
    return 0;

  }
  return 1;
}

_id_233F(var_0, var_1) {
  self endon("death");
  var_0 = var_0 * 2;
  var_2 = var_0 - self.fontscale;
  self changefontscaleovertime(var_1);
  self.fontscale = self.fontscale + var_2;
}

_id_2340(var_0, var_1, var_2, var_3) {
  var_4 = 0.8;
  var_5 = 0.5;
  var_6 = var_4 * 0.1;
  var_7 = var_4 * (0.1 + var_1 * 0.2);
  var_8 = var_4 * (0.1 + var_1 * 0.1);
  var_9 = var_4 * 0.3;
  var_10 = var_4 - var_6 - var_7 - var_8 - var_9;

  if(var_10 < 0) {
    var_10 = 0;

  }
  var_11 = 0.8 + var_1 * 0.1;
  var_12 = 0.5 + var_1 * 0.3;

  if(_id_233E(var_0)) {
    if(!var_3) {
      var_0 fadeovertime(var_6);
      var_0.alpha = var_2 * 1.0;
    }
  }

  if(isDefined(var_0)) {
    var_0 thread _id_233F(1.0, var_6);

  }
  wait(var_6 + var_7);

  if(_id_233E(var_0)) {
    if(!var_3) {
      var_0 fadeovertime(var_8);
      var_0.alpha = var_2 * var_11;
    }
  }

  wait(var_8);

  if(_id_233E(var_0)) {
    if(!var_3) {
      var_0 fadeovertime(var_9);
      var_0.alpha = var_2 * var_12;
    }
  }

  if(isDefined(var_0)) {
    var_0 thread _id_233F(0.9, var_9);

  }
  wait(var_9);
  wait(var_10);
}

_id_2341() {
  if(isDefined(level._id_2342)) {
    return 0;

  }
  if(isDefined(self.vehicle)) {
    return 0;

  }
  return 1;
}

_id_2343() {
  if(!isalive(self)) {
    return 0;

  }
  if(self islinked()) {
    return 0;

  }
  if(self.ignoreme) {
    return 0;

  }
  if(level._id_16C9) {
    return 0;

  }
  if(!_id_2341()) {
    return 0;

  }
  if(self.gameskill > 1 && !maps\_load::_id_1EED()) {
    return 0;

  }
  var_0 = self getlocalplayerprofiledata("takeCoverWarnings");

  if(var_0 <= 3) {
    return 0;

  }
  return 1;
}

_id_2344() {
  self endon("hit_again");
  self endon("damage");
  var_0 = undefined;

  if(_id_2343()) {
    var_0 = _id_2338();

  }
  var_1 = gettime() + self._id_20F2._id_22F9;
  _id_2340(var_0, 1, 1, 0);

  while(gettime() < var_1 && isalive(self) && maps\_utility::_id_1008("player_has_red_flashing_overlay")) {
    _id_2340(var_0, 0.9, 1, 0);

  }
  if(isalive(self)) {
    _id_2340(var_0, 0.65, 0.8, 0);

  }
  if(_id_233E(var_0)) {
    var_0 fadeovertime(1.0);
    var_0.alpha = 0;
  }

  _id_2340(var_0, 0, 0.6, 1);
  wait 0.5;
  self notify("take_cover_done");
  self notify("hit_again");
}

_id_2345() {
  maps\_utility::_id_13DE("player_has_red_flashing_overlay");

  if(maps\_utility::_id_1008("near_death_vision_enabled")) {
    self painvisionoff();
    thread maps\_audio::_id_171A();
  }

  if(!isDefined(self._id_1718) || !self._id_1718) {
    self playlocalsound("breathing_better");

  }
  self notify("take_cover_done");
}

_id_2346(var_0) {
  self waittill("noHealthOverlay");
  var_0 destroy();
}

_id_1A66() {
  waittillframeend;
  _id_1E8E(1);
}

_id_2347() {
  var_0 = level.script == "sp_intro" || level.script == "ny_manhattan";

  if(self getlocalplayerprofiledata("takeCoverWarnings") == -1 || var_0) {
    self setlocalplayerprofiledata("takeCoverWarnings", 9);
  }
}

_id_2348() {
  self notify("new_cover_on_death_thread");
  self endon("new_cover_on_death_thread");
  self waittill("death");

  if(!maps\_utility::_id_1008("player_has_red_flashing_overlay")) {
    return;
  }
  if(!_id_2341()) {
    return;
  }
  var_0 = self getlocalplayerprofiledata("takeCoverWarnings");

  if(var_0 < 10) {
    self setlocalplayerprofiledata("takeCoverWarnings", var_0 + 1);
  }
}

_id_2349() {
  var_0 = self.origin;
  wait 5;

  if(_id_234B(var_0)) {
    level._id_234A[level._id_234A.size] = var_0;
  }
}

_id_234B(var_0) {
  return distancesquared(self.origin, var_0) < 19600;
}

_id_234C() {
  level._id_234A = [];
  level.player._id_234D = 1;
  wait 1;

  for(;;) {
    level.player thread _id_2349();
    level.player._id_234D = 1;
    var_0 = [];
    var_1 = level._id_234A.size - 5;

    if(var_1 < 0) {
      var_1 = 0;

    }
    for(var_2 = var_1; var_2 < level._id_234A.size; var_2++) {
      if(!level.player _id_234B(level._id_234A[var_2])) {
        continue;
      }
      var_0[var_0.size] = level._id_234A[var_2];
      level.player._id_234D = 0;
    }

    level._id_234A = var_0;
    wait 1;
  }
}

_id_234E() {
  level.player waittill("death");
  var_0 = getdvarint("autodifficulty_playerDeathTimer");
  var_0 = var_0 - 60;
  setdvar("autodifficulty_playerDeathTimer", var_0);
}

_id_234F() {
  var_0 = gettime();

  for(;;) {
    if(level.player attackbuttonpressed()) {
      var_0 = gettime();

    }
    level._id_2350 = gettime() - var_0;
    wait 0.05;
  }
}

_id_2351(var_0, var_1) {
  _id_235A(var_0, var_1 * 100, 1);
}

_id_2352(var_0, var_1) {
  _id_235A(var_0, var_1, 0);
}

_id_2353() {
  level._id_2354 = 0;

  if(isDefined(level._id_2355)) {
    for(var_0 = 0; var_0 < level._id_2355.size; var_0++) {
      level._id_2355[var_0] destroy();
    }
  }

  level._id_2355 = [];
}

_id_2356(var_0) {
  if(!isDefined(level._id_2357)) {
    level._id_2357 = [];

  }
  if(!isDefined(level._id_2357[var_0])) {
    var_1 = newhudelem();
    var_1.x = level._id_2358;
    var_1.y = level._id_2359 + level._id_2354 * 15;
    var_1.foreground = 1;
    var_1.sort = 100;
    var_1.alpha = 1.0;
    var_1.alignx = "left";
    var_1.horzalign = "left";
    var_1.fontscale = 1.0;
    var_1 settext(var_0);
    level._id_2357[var_0] = 1;
  }
}

_id_235A(var_0, var_1, var_2) {
  _id_2356(var_0);
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
    _id_235C(var_4, var_8);
    var_8 = var_8 + var_9;
    _id_235C(var_5, var_8);
    var_8 = var_8 + var_9;
    _id_235C(var_6, var_8);
    var_8 = var_8 + var_9;
    _id_235C(var_7, var_8);
    var_8 = var_8 + var_9;
  } else if(var_5 > 0 || var_2) {
    _id_235C(var_5, var_8);
    var_8 = var_8 + var_9;
    _id_235C(var_6, var_8);
    var_8 = var_8 + var_9;
    _id_235C(var_7, var_8);
    var_8 = var_8 + var_9;
  } else if(var_6 > 0) {
    _id_235C(var_6, var_8);
    var_8 = var_8 + var_9;
    _id_235C(var_7, var_8);
    var_8 = var_8 + var_9;
  } else {
    _id_235C(var_7, var_8);
    var_8 = var_8 + var_9;
  }

  if(var_2) {
    var_10 = newhudelem();
    var_10.x = 204.5;
    var_10.y = level._id_2359 + level._id_2354 * 15;
    var_10.foreground = 1;
    var_10.sort = 100;
    var_10.alpha = 1.0;
    var_10.alignx = "left";
    var_10.horzalign = "left";
    var_10.fontscale = 1.0;
    var_10 settext(".");
    level._id_2355[level._id_2355.size] = var_10;
  }

  if(var_3) {
    var_11 = newhudelem();
    var_11.x = 195.5;
    var_11.y = level._id_2359 + level._id_2354 * 15;
    var_11.foreground = 1;
    var_11.sort = 100;
    var_11.alpha = 1.0;
    var_11.alignx = "left";
    var_11.horzalign = "left";
    var_11.fontscale = 1.0;
    var_11 settext(" - ");
    level._id_2355[level._id_2354] = var_11;
  }

  level._id_2354++;
}

_id_235B(var_0, var_1) {
  _id_2356(var_0);
  _id_235D(var_1, 0);
  level._id_2354++;
}

_id_235C(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 200 + var_1 * 0.65;
  var_2.y = level._id_2359 + level._id_2354 * 15;
  var_2.foreground = 1;
  var_2.sort = 100;
  var_2.alpha = 1.0;
  var_2.alignx = "left";
  var_2.horzalign = "left";
  var_2.fontscale = 1.0;
  var_2 settext(var_0 + "");
  level._id_2355[level._id_2355.size] = var_2;
}

_id_235D(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 200 + var_1 * 0.65;
  var_2.y = level._id_2359 + level._id_2354 * 15;
  var_2.foreground = 1;
  var_2.sort = 100;
  var_2.alpha = 1.0;
  var_2.alignx = "left";
  var_2.horzalign = "left";
  var_2.fontscale = 1.0;
  var_2 settext(var_0);
  level._id_2355[level._id_2355.size] = var_2;
}

_id_1E7E() {
  level.sp_stat_tracking_func = ::_id_2364;
  setdvar("aa_player_kills", "0");
  setdvar("aa_enemy_deaths", "0");
  setdvar("aa_enemy_damage_taken", "0");
  setdvar("aa_player_damage_taken", "0");
  setdvar("aa_player_damage_dealt", "0");
  setdvar("aa_ads_damage_dealt", "0");
  setdvar("aa_time_tracking", "0");
  setdvar("aa_deaths", "0");
  setdvar("player_cheated", 0);
  level._id_235E = [];
  thread _id_2360();
  thread _id_2363();
  thread _id_2361();
  common_scripts\utility::flag_set("auto_adjust_initialized");
  common_scripts\utility::flag_init("aa_main_" + level.script);
  common_scripts\utility::flag_set("aa_main_" + level.script);
}

_id_235F(var_0) {
  var_1 = getkeybinding(var_0);

  if(var_1["count"] <= 0) {
    return 0;

  }
  for(var_2 = 1; var_2 < var_1["count"] + 1; var_2++) {
    if(self buttonpressed(var_1["key" + var_2])) {
      return 1;
    }
  }

  return 0;
}

_id_2360() {
  waittillframeend;

  for(;;) {
    wait 0.2;
  }
}

_id_2361() {
  level.player endon("death");
  level._id_2362 = 0;

  for(;;) {
    if(level.player maps\_utility::_id_167C()) {
      level._id_2362 = gettime();

      while(level.player maps\_utility::_id_167C()) {
        wait 0.05;

      }
      continue;
    }

    wait 0.05;
  }
}

_id_2363() {
  for(;;) {
    level.player waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    _id_2368("aa_player_damage_taken", var_0);

    if(!isalive(level.player)) {
      _id_2368("aa_deaths", 1);
      return;
    }
  }
}

_id_2364(var_0) {
  if(!isDefined(level._id_2365)) {
    level._id_2365 = [];

  }
  common_scripts\utility::flag_wait("auto_adjust_initialized");
  level._id_235E[var_0] = [];
  level._id_2365[var_0] = 0;
  common_scripts\utility::flag_wait(var_0);

  if(getdvar("aa_zone" + var_0) == "") {
    setdvar("aa_zone" + var_0, "on");
    level._id_2365[var_0] = 1;
    _id_2367();
    setdvar("start_time" + var_0, getdvar("aa_time_tracking"));
    setdvar("starting_player_kills" + var_0, getdvar("aa_player_kills"));
    setdvar("starting_deaths" + var_0, getdvar("aa_deaths"));
    setdvar("starting_ads_damage_dealt" + var_0, getdvar("aa_ads_damage_dealt"));
    setdvar("starting_player_damage_dealt" + var_0, getdvar("aa_player_damage_dealt"));
    setdvar("starting_player_damage_taken" + var_0, getdvar("aa_player_damage_taken"));
    setdvar("starting_enemy_damage_taken" + var_0, getdvar("aa_enemy_damage_taken"));
    setdvar("starting_enemy_deaths" + var_0, getdvar("aa_enemy_deaths"));
  } else if(getdvar("aa_zone" + var_0) == "done") {
    return;
  }
  common_scripts\utility::flag_waitopen(var_0);
  _id_195B(var_0);
}

_id_195B(var_0) {
  setdvar("aa_zone" + var_0, "done");
  var_1 = getdvarfloat("start_time" + var_0);
  var_2 = getdvarint("starting_player_kills" + var_0);
  var_3 = getdvarint("aa_enemy_deaths" + var_0);
  var_4 = getdvarint("aa_enemy_damage_taken" + var_0);
  var_5 = getdvarint("aa_player_damage_taken" + var_0);
  var_6 = getdvarint("aa_player_damage_dealt" + var_0);
  var_7 = getdvarint("aa_ads_damage_dealt" + var_0);
  var_8 = getdvarint("aa_deaths" + var_0);
  level._id_2365[var_0] = 0;
  _id_2367();
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

  if(var_9 > 0) {
    var_20 = var_19 / var_9;

  }
  var_21 = var_20 * 60;
  var_21 = int(var_21);
  var_22 = getdvarint("aa_deaths") - var_8;
  var_23 = [];
  var_23["player_damage_taken_per_minute"] = var_21;
  var_23["player_damage_dealt_per_minute"] = var_16;
  var_23["minutes"] = var_9 / 60;
  var_23["deaths"] = var_22;
  var_23["gameskill"] = level.gameskill;
  level._id_235E[var_0] = var_23;
  var_24 = "Completed AA sequence: ";
  var_24 = var_24 + (level.script + "/" + var_0);
  var_25 = getarraykeys(var_23);

  for(var_26 = 0; var_26 < var_25.size; var_26++) {
    var_24 = var_24 + ", " + var_25[var_26] + ": " + var_23[var_25[var_26]];

  }
  logstring(var_24);
}

_id_2366(var_0, var_1) {
  logstring(var_0 + ": " + var_1[var_0]);
}

_id_2367() {}

_id_2368(var_0, var_1) {
  var_2 = getdvarint(var_0);
  setdvar(var_0, var_2 + var_1);
}

_id_2369(var_0, var_1) {
  var_2 = getdvarfloat(var_0);
  setdvar(var_0, var_2 + var_1);
}

_id_236A(var_0) {
  return 0;
}

_id_236B(var_0) {
  if([[level._id_22DB]](var_0)) {
    return 1;

  }
  if(isplayer(var_0)) {
    return 1;

  }
  if(!isDefined(var_0.car_damage_owner_recorder)) {
    return 0;

  }
  return var_0 _id_236C();
}

_id_236C() {
  return self.player_damage * 1.75 > self.non_player_damage;
}

_id_236D(var_0, var_1, var_2) {}

_id_236E(var_0, var_1, var_2, var_3) {
  _id_2368("aa_enemy_deaths", 1);

  if(!isDefined(var_1)) {
    return;
  }
  if(!_id_236B(var_1)) {
    return;
  }
  [[level._id_09B8]](var_2, self.damagelocation, var_3);
  _id_2368("aa_player_kills", 1);
}

_id_2162(var_0, var_1, var_2, var_3, var_4, var_5, var_5) {
  if(!isalive(self) || self.delayeddeath) {
    _id_236E(var_0, var_1, var_4, var_3);
    return;
  }

  if(!_id_236B(var_1)) {
    return;
  }
  _id_236F(var_0, var_4, var_3);
}

_id_236F(var_0, var_1, var_2) {
  _id_2368("aa_player_damage_dealt", var_0);

  if(!level.player maps\_utility::_id_167C()) {
    [[level._id_09BA]](var_1, self.damagelocation, var_2);
    return 0;
  }

  if(!_id_2370(var_1)) {
    [[level._id_09BA]](var_1, self.damagelocation, var_2);
    return 0;
  }

  [[level._id_09B9]](var_1, self.damagelocation, var_2);
  _id_2368("aa_ads_damage_dealt", var_0);
  return 1;
}

_id_2370(var_0) {
  if(var_0 == "MOD_PISTOL_BULLET") {
    return 1;

  }
  return var_0 == "MOD_RIFLE_BULLET";
}

_id_2371(var_0, var_1, var_2) {
  if(!isDefined(level._id_22E1[var_0])) {
    level._id_22E1[var_0] = [];

  }
  var_3 = [];
  var_3["frac"] = var_1;
  var_3["val"] = var_2;
  level._id_22E1[var_0][level._id_22E1[var_0].size] = var_3;
}

_id_2372() {
  return maps\_utility::_id_12C1() && maps\_utility::_id_1A6A().size == 1;
}