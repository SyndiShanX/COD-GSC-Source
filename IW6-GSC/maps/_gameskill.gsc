/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_gameskill.gsc
*****************************************************/

setskill(var_0) {
  if(!isDefined(level.script))
    level.script = tolower(getDvar("mapname"));

  if(!isDefined(var_0) || var_0 == 0) {
    if(isDefined(level.gameskill)) {
      return;
    }
    if(!isDefined(level.custom_player_attacker))
      level.custom_player_attacker = ::return_false;

    level.global_damage_func_ads = ::empty_kill_func;
    level.global_damage_func = ::empty_kill_func;
    level.global_kill_func = ::empty_kill_func;
    maps\_utility::set_console_status();

    foreach(var_2 in level.players) {
      var_2 maps\_utility::ent_flag_init("player_has_red_flashing_overlay");
      var_2 maps\_utility::ent_flag_init("player_is_invulnerable");
      var_2 maps\_utility::ent_flag_init("player_zero_attacker_accuracy");
      var_2 maps\_utility::ent_flag_init("player_no_auto_blur");
      var_2 maps\_utility::ent_flag_init("near_death_vision_enabled");
      var_2 maps\_utility::ent_flag_set("near_death_vision_enabled");
      var_2.gs = spawnStruct();
      var_2 init_screeneffect_vars();
      var_2.a = spawnStruct();
      var_2.damage_functions = [];
      var_2 maps\_player_stats::init_stats();
      var_2 maps\_utility::ent_flag_init("global_hint_in_use");
      var_2.pers = [];

      if(!isDefined(var_2.baseignorerandombulletdamage))
        var_2.baseignorerandombulletdamage = 0;

      var_2.disabledweapon = 0;
      var_2.disabledweaponswitch = 0;
      var_2.disabledusability = 0;
      var_2 setoffhandprimaryclass("frag");
    }

    level.difficultytype[0] = "easy";
    level.difficultytype[1] = "normal";
    level.difficultytype[2] = "hardened";
    level.difficultytype[3] = "veteran";
    level.difficultystring["easy"] = &"GAMESKILL_EASY";
    level.difficultystring["normal"] = &"GAMESKILL_NORMAL";
    level.difficultystring["hardened"] = &"GAMESKILL_HARDENED";
    level.difficultystring["veteran"] = &"GAMESKILL_VETERAN";
    thread gameskill_change_monitor();
  }

  setdvarifuninitialized("autodifficulty_playerDeathTimer", 0);
  anim.run_accuracy = 0.5;
  anim.walk_accuracy = 0.8;
  setDvar("autodifficulty_frac", 0);
  level.difficultysettings_frac_data_points = [];

  foreach(var_2 in level.players) {
    var_2 init_take_cover_warnings();
    var_2 thread increment_take_cover_warnings_on_death();
  }

  level.mg42badplace_mintime = 8;
  level.mg42badplace_maxtime = 16;
  level.difficultysettings["playerGrenadeBaseTime"]["easy"] = 40000;
  level.difficultysettings["playerGrenadeBaseTime"]["normal"] = 35000;
  level.difficultysettings["playerGrenadeBaseTime"]["hardened"] = 25000;
  level.difficultysettings["playerGrenadeBaseTime"]["veteran"] = 25000;
  level.difficultysettings["playerGrenadeRangeTime"]["easy"] = 20000;
  level.difficultysettings["playerGrenadeRangeTime"]["normal"] = 15000;
  level.difficultysettings["playerGrenadeRangeTime"]["hardened"] = 10000;
  level.difficultysettings["playerGrenadeRangeTime"]["veteran"] = 10000;
  level.difficultysettings["playerDoubleGrenadeTime"]["easy"] = 3600000;
  level.difficultysettings["playerDoubleGrenadeTime"]["normal"] = 150000;
  level.difficultysettings["playerDoubleGrenadeTime"]["hardened"] = 90000;
  level.difficultysettings["playerDoubleGrenadeTime"]["veteran"] = 90000;
  level.difficultysettings["double_grenades_allowed"]["easy"] = 0;
  level.difficultysettings["double_grenades_allowed"]["normal"] = 1;
  level.difficultysettings["double_grenades_allowed"]["hardened"] = 1;
  level.difficultysettings["double_grenades_allowed"]["veteran"] = 1;
  level.difficultysettings["threatbias"]["easy"] = 100;
  level.difficultysettings["threatbias"]["normal"] = 150;
  level.difficultysettings["threatbias"]["hardened"] = 200;
  level.difficultysettings["threatbias"]["veteran"] = 400;
  level.difficultysettings["base_enemy_accuracy"]["easy"] = 0.9;
  level.difficultysettings["base_enemy_accuracy"]["normal"] = 1.0;
  level.difficultysettings["base_enemy_accuracy"]["hardened"] = 1.15;
  level.difficultysettings["base_enemy_accuracy"]["veteran"] = 1.15;
  level.difficultysettings["accuracyDistScale"]["easy"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["normal"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["hardened"] = 0.6;
  level.difficultysettings["accuracyDistScale"]["veteran"] = 0.8;
  level.difficultysettings["min_sniper_burst_delay_time"]["easy"] = 3.0;
  level.difficultysettings["min_sniper_burst_delay_time"]["normal"] = 2.0;
  level.difficultysettings["min_sniper_burst_delay_time"]["hardened"] = 1.5;
  level.difficultysettings["min_sniper_burst_delay_time"]["veteran"] = 1.1;
  level.difficultysettings["max_sniper_burst_delay_time"]["easy"] = 4.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["normal"] = 3.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["hardened"] = 2.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["veteran"] = 1.5;
  level.difficultysettings["dog_health"]["easy"] = 0.25;
  level.difficultysettings["dog_health"]["normal"] = 0.75;
  level.difficultysettings["dog_health"]["hardened"] = 1.0;
  level.difficultysettings["dog_health"]["veteran"] = 1.0;
  level.difficultysettings["dog_presstime"]["easy"] = 415;
  level.difficultysettings["dog_presstime"]["normal"] = 375;
  level.difficultysettings["dog_presstime"]["hardened"] = 250;
  level.difficultysettings["dog_presstime"]["veteran"] = 225;
  level.difficultysettings["dog_hits_before_kill"]["easy"] = 2;
  level.difficultysettings["dog_hits_before_kill"]["normal"] = 1;
  level.difficultysettings["dog_hits_before_kill"]["hardened"] = 0;
  level.difficultysettings["dog_hits_before_kill"]["veteran"] = 0;
  level.difficultysettings["pain_test"]["easy"] = ::always_pain;
  level.difficultysettings["pain_test"]["normal"] = ::always_pain;
  level.difficultysettings["pain_test"]["hardened"] = ::pain_protection;
  level.difficultysettings["pain_test"]["veteran"] = ::pain_protection;
  level.difficultysettings["missTimeConstant"]["easy"] = 1.0;
  level.difficultysettings["missTimeConstant"]["normal"] = 0.05;
  level.difficultysettings["missTimeConstant"]["hardened"] = 0;
  level.difficultysettings["missTimeConstant"]["veteran"] = 0;
  level.difficultysettings["missTimeDistanceFactor"]["easy"] = 0.0008;
  level.difficultysettings["missTimeDistanceFactor"]["normal"] = 0.0001;
  level.difficultysettings["missTimeDistanceFactor"]["hardened"] = 0.00005;
  level.difficultysettings["missTimeDistanceFactor"]["veteran"] = 0;
  level.difficultysettings["flashbangedInvulFactor"]["easy"] = 0.25;
  level.difficultysettings["flashbangedInvulFactor"]["normal"] = 0;
  level.difficultysettings["flashbangedInvulFactor"]["hardened"] = 0;
  level.difficultysettings["flashbangedInvulFactor"]["veteran"] = 0;
  level.difficultysettings["player_criticalBulletDamageDist"]["easy"] = 0;
  level.difficultysettings["player_criticalBulletDamageDist"]["normal"] = 0;
  level.difficultysettings["player_criticalBulletDamageDist"]["hardened"] = 0;
  level.difficultysettings["player_criticalBulletDamageDist"]["veteran"] = 0;
  level.difficultysettings["player_deathInvulnerableTime"]["easy"] = 4000;
  level.difficultysettings["player_deathInvulnerableTime"]["normal"] = 2500;
  level.difficultysettings["player_deathInvulnerableTime"]["hardened"] = 600;
  level.difficultysettings["player_deathInvulnerableTime"]["veteran"] = 100;
  level.difficultysettings["invulTime_preShield"]["easy"] = 0.6;
  level.difficultysettings["invulTime_preShield"]["normal"] = 0.5;
  level.difficultysettings["invulTime_preShield"]["hardened"] = 0.3;
  level.difficultysettings["invulTime_preShield"]["veteran"] = 0.0;
  level.difficultysettings["invulTime_onShield"]["easy"] = 1.6;
  level.difficultysettings["invulTime_onShield"]["normal"] = 1.0;
  level.difficultysettings["invulTime_onShield"]["hardened"] = 0.5;
  level.difficultysettings["invulTime_onShield"]["veteran"] = 0.25;
  level.difficultysettings["invulTime_postShield"]["easy"] = 0.5;
  level.difficultysettings["invulTime_postShield"]["normal"] = 0.4;
  level.difficultysettings["invulTime_postShield"]["hardened"] = 0.3;
  level.difficultysettings["invulTime_postShield"]["veteran"] = 0.0;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["easy"] = 4000;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["normal"] = 4000;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["hardened"] = 3000;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["veteran"] = 1200;
  level.difficultysettings["worthyDamageRatio"]["easy"] = 0.0;
  level.difficultysettings["worthyDamageRatio"]["normal"] = 0.1;
  level.difficultysettings["worthyDamageRatio"]["hardened"] = 0.3;
  level.difficultysettings["worthyDamageRatio"]["veteran"] = 0.3;
  level.difficultysettings["playerDifficultyHealth"]["easy"] = 475;
  level.difficultysettings["playerDifficultyHealth"]["normal"] = 275;
  level.difficultysettings["playerDifficultyHealth"]["hardened"] = 165;
  level.difficultysettings["playerDifficultyHealth"]["veteran"] = 115;
  level.difficultysettings["longRegenTime"]["easy"] = 5000;
  level.difficultysettings["longRegenTime"]["normal"] = 5000;
  level.difficultysettings["longRegenTime"]["hardened"] = 3200;
  level.difficultysettings["longRegenTime"]["veteran"] = 3200;
  level.difficultysettings["healthOverlayCutoff"]["easy"] = 0.02;
  level.difficultysettings["healthOverlayCutoff"]["normal"] = 0.02;
  level.difficultysettings["healthOverlayCutoff"]["hardened"] = 0.02;
  level.difficultysettings["healthOverlayCutoff"]["veteran"] = 0.02;
  level.difficultysettings["health_regenRate"]["easy"] = 0.02;
  level.difficultysettings["health_regenRate"]["normal"] = 0.02;
  level.difficultysettings["health_regenRate"]["hardened"] = 0.02;
  level.difficultysettings["health_regenRate"]["veteran"] = 0.02;
  level.difficultysettings["explosivePlantTime"]["easy"] = 10;
  level.difficultysettings["explosivePlantTime"]["normal"] = 10;
  level.difficultysettings["explosivePlantTime"]["hardened"] = 5;
  level.difficultysettings["explosivePlantTime"]["veteran"] = 5;
  level.difficultysettings["player_downed_buffer_time"]["normal"] = 2;
  level.difficultysettings["player_downed_buffer_time"]["hardened"] = 1.5;
  level.difficultysettings["player_downed_buffer_time"]["veteran"] = 0;
  level.lastplayersighted = 0;
  setsaveddvar("player_meleeDamageMultiplier", 0.266667);

  if(isDefined(level.custom_gameskill_func))
    [[level.custom_gameskill_func]]();

  if(coop_with_one_player_downed())
    make_remaining_player_a_little_stronger();

  updategameskill();
  updatealldifficulty();
  setDvar("autodifficulty_original_setting", level.gameskill);
}

init_screeneffect_vars() {
  self.gs.screeneffect = [];
  var_0 = ["bottom", "left", "right"];
  var_1 = ["bloodsplat", "dirt"];

  foreach(var_3 in var_1) {
    foreach(var_5 in var_0) {
      self.gs.screeneffect[var_3][var_5] = 0;
      self.gs.screeneffect[var_3 + "_count"][var_5] = 0;
    }
  }
}

coop_player_in_special_ops_survival() {
  setsaveddvar("player_meleeDamageMultiplier", 0.26);
}

solo_player_in_special_ops() {
  if(!maps\_utility::is_survival()) {
    setsaveddvar("player_deathInvulnerableToMelee", "1");
    setsaveddvar("ai_accuracy_attackercountDecrease", "0.6");
  }

  level.difficultysettings["playerHealth_RegularRegenDelay"]["normal"] = 2000;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["hardened"] = 2000;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["veteran"] = 900;

  if(!maps\_utility::is_survival())
    level.difficultysettings["invulTime_onShield"]["normal"] = 2.5;
  else
    level.difficultysettings["invulTime_onShield"]["normal"] = 1.5;

  level.difficultysettings["player_deathInvulnerableTime"]["normal"] = 3000;
  level.difficultysettings["player_deathInvulnerableTime"]["hardened"] = 1300;
  level.difficultysettings["player_deathInvulnerableTime"]["veteran"] = 800;
  level.difficultysettings["longRegenTime"]["normal"] = 4500;
  level.difficultysettings["longRegenTime"]["hardened"] = 4500;
  level.difficultysettings["longRegenTime"]["veteran"] = 4500;
  level.difficultysettings["playerDifficultyHealth"]["normal"] = 350;
  level.difficultysettings["playerDifficultyHealth"]["hardened"] = 205;
  level.difficultysettings["playerDifficultyHealth"]["veteran"] = 205;

  if(!maps\_utility::is_survival())
    setsaveddvar("player_meleeDamageMultiplier", 0.5);
  else
    setsaveddvar("player_meleeDamageMultiplier", 0.26);
}

solo_player_in_coop_gameskill_settings() {
  level.difficultysettings["player_deathInvulnerableTime"]["normal"] = 2500;
  level.difficultysettings["player_deathInvulnerableTime"]["hardened"] = 1200;
  level.difficultysettings["player_deathInvulnerableTime"]["veteran"] = 200;
  var_0 = 1.35;
  level.difficultysettings["playerDifficultyHealth"]["normal"] = int(275 * var_0);
  level.difficultysettings["playerDifficultyHealth"]["hardened"] = int(165 * var_0);
  level.difficultysettings["playerDifficultyHealth"]["veteran"] = int(138.0);
}

make_remaining_player_a_little_stronger() {
  level.difficultysettings["player_deathInvulnerableTime"]["normal"] = 2500;
  level.difficultysettings["player_deathInvulnerableTime"]["hardened"] = 1000;
  var_0 = 1.25;
  level.difficultysettings["playerDifficultyHealth"]["normal"] = int(275 * var_0);
  level.difficultysettings["playerDifficultyHealth"]["hardened"] = int(165 * var_0);
}

updatealldifficulty() {
  setglobaldifficulty();

  for(var_0 = 0; var_0 < level.players.size; var_0++)
    level.players[var_0] setdifficulty();
}

setdifficulty() {
  set_difficulty_from_locked_settings();
}

setglobaldifficulty() {
  var_0 = ::get_locked_difficulty_val_global;
  var_1 = get_skill_from_index(level.gameskill);
  anim.dog_health = [[var_0]]("dog_health", level.gameskill);
  anim.pain_test = level.difficultysettings["pain_test"][var_1];
  level.explosiveplanttime = level.difficultysettings["explosivePlantTime"][var_1];
  anim.min_sniper_burst_delay_time = [[var_0]]("min_sniper_burst_delay_time", level.gameskill);
  anim.max_sniper_burst_delay_time = [[var_0]]("max_sniper_burst_delay_time", level.gameskill);
  setsaveddvar("ai_accuracyDistScale", [[var_0]]("accuracyDistScale", level.gameskill));

  if(maps\_utility::laststand_enabled())
    level.player_downed_death_buffer_time = level.difficultysettings["player_downed_buffer_time"][var_1];

  maps\_mgturret::setdifficulty();
}

updategameskill() {
  foreach(var_1 in level.players) {
    if(maps\_utility::is_survival()) {
      var_1.gameskill = 1;
      continue;
    }

    var_1.gameskill = var_1 maps\_utility::get_player_gameskill();
  }

  level.gameskill = level.player.gameskill;

  if(maps\_utility::is_coop() && level.player2.gameskill > level.gameskill)
    level.gameskill = level.player2.gameskill;

  level.specops_reward_gameskill = level.player.gameskill;

  if(maps\_utility::is_coop() && level.player2.gameskill < level.specops_reward_gameskill)
    level.specops_reward_gameskill = level.player2.gameskill;

  if(isDefined(level.forcedgameskill))
    level.gameskill = level.forcedgameskill;

  return level.gameskill;
}

gameskill_change_monitor() {
  var_0 = level.gameskill;

  for(;;) {
    if(!isDefined(var_0)) {
      wait 1;
      var_0 = level.gameskill;
      continue;
    }

    if(var_0 != updategameskill()) {
      var_0 = level.gameskill;
      updatealldifficulty();
    }

    wait 1;
  }
}

get_skill_from_index(var_0) {
  return level.difficultytype[var_0];
}

aa_should_start_fresh() {
  return level.gameskill == getdvarint("autodifficulty_original_setting");
}

apply_difficulty_frac_with_func(var_0, var_1) {
  self.gs.invultime_preshield = [[var_0]]("invulTime_preShield", var_1);
  self.gs.invultime_onshield = [[var_0]]("invulTime_onShield", var_1);
  self.gs.invultime_postshield = [[var_0]]("invulTime_postShield", var_1);
  self.gs.playerhealth_regularregendelay = [[var_0]]("playerHealth_RegularRegenDelay", var_1);
  self.gs.worthydamageratio = [[var_0]]("worthyDamageRatio", var_1);
  self.threatbias = int([[var_0]]("threatbias", var_1));
  self.gs.longregentime = [[var_0]]("longRegenTime", var_1);
  self.gs.healthoverlaycutoff = [[var_0]]("healthOverlayCutoff", var_1);
  self.gs.regenrate = [[var_0]]("health_regenRate", var_1);
  self.gs.player_attacker_accuracy = [[var_0]]("base_enemy_accuracy", var_1);
  update_player_attacker_accuracy();
  self.gs.playergrenadebasetime = int([[var_0]]("playerGrenadeBaseTime", var_1));
  self.gs.playergrenaderangetime = int([[var_0]]("playerGrenadeRangeTime", var_1));
  self.gs.playerdoublegrenadetime = int([[var_0]]("playerDoubleGrenadeTime", var_1));
  self.gs.min_sniper_burst_delay_time = [[var_0]]("min_sniper_burst_delay_time", var_1);
  self.gs.max_sniper_burst_delay_time = [[var_0]]("max_sniper_burst_delay_time", var_1);
  self.gs.dog_presstime = [[var_0]]("dog_presstime", var_1);
  self.deathinvulnerabletime = int([[var_0]]("player_deathInvulnerableTime", var_1));
  self.criticalbulletdamagedist = int([[var_0]]("player_criticalBulletDamageDist", var_1));
  self.damagemultiplier = 100 / [[var_0]]("playerDifficultyHealth", var_1);
}

update_player_attacker_accuracy() {
  if(maps\_utility::ent_flag("player_zero_attacker_accuracy")) {
    return;
  }
  self.ignorerandombulletdamage = self.baseignorerandombulletdamage;
  self.attackeraccuracy = self.gs.player_attacker_accuracy;
}

apply_difficulty_step_with_func(var_0, var_1) {
  self.gs.misstimeconstant = [[var_0]]("missTimeConstant", var_1);
  self.gs.misstimedistancefactor = [[var_0]]("missTimeDistanceFactor", var_1);
  self.gs.dog_hits_before_kill = [[var_0]]("dog_hits_before_kill", var_1);
  self.gs.double_grenades_allowed = [[var_0]]("double_grenades_allowed", var_1);
}

set_difficulty_from_locked_settings() {
  apply_difficulty_frac_with_func(::get_locked_difficulty_val_player, 1);
  apply_difficulty_step_with_func(::get_locked_difficulty_step_val_player, 1);
}

get_locked_difficulty_step_val_player(var_0, var_1) {
  return level.difficultysettings[var_0][get_skill_from_index(self.gameskill)];
}

get_locked_difficulty_step_val_global(var_0, var_1) {
  return level.difficultysettings[var_0][get_skill_from_index(level.gameskill)];
}

get_blended_difficulty(var_0, var_1) {
  var_2 = level.difficultysettings_frac_data_points[var_0];

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

getcurrentdifficultysetting(var_0) {
  return level.difficultysettings[var_0][get_skill_from_index(self.gameskill)];
}

getratio(var_0, var_1, var_2) {
  return (level.difficultysettings[var_0][level.difficultytype[var_1]] * (100 - getdvarint("autodifficulty_frac")) + level.difficultysettings[var_0][level.difficultytype[var_2]] * getdvarint("autodifficulty_frac")) * 0.01;
}

get_locked_difficulty_val_player(var_0, var_1) {
  return level.difficultysettings[var_0][get_skill_from_index(self.gameskill)];
}

get_locked_difficulty_val_global(var_0, var_1) {
  return level.difficultysettings[var_0][get_skill_from_index(level.gameskill)];
}

always_pain() {
  return 0;
}

pain_protection() {
  if(!pain_protection_check())
    return 0;

  return randomint(100) > 25;
}

pain_protection_check() {
  if(!isalive(self.enemy))
    return 0;

  if(!isPlayer(self.enemy))
    return 0;

  if(!isalive(level.painai) || level.painai.script != "pain")
    level.painai = self;

  if(self == level.painai)
    return 0;

  if(self.damageweapon != "none" && weaponisboltaction(self.damageweapon))
    return 0;

  return 1;
}

set_accuracy_based_on_situation() {
  if(animscripts\combat_utility::issniper() && isalive(self.enemy)) {
    setsniperaccuracy();
    return;
  }

  if(isPlayer(self.enemy)) {
    resetmissdebouncetime();

    if(self.a.misstime > gettime()) {
      self.accuracy = 0;
      return;
    }
  }

  if(self.script == "move") {
    if(animscripts\utility::iscqbwalkingorfacingenemy())
      self.accuracy = anim.walk_accuracy * self.baseaccuracy;
    else
      self.accuracy = anim.run_accuracy * self.baseaccuracy;

    return;
  }

  self.accuracy = self.baseaccuracy;

  if(isDefined(self.isrambo) && isDefined(self.ramboaccuracymult))
    self.accuracy = self.accuracy * self.ramboaccuracymult;
}

setsniperaccuracy() {
  if(!isDefined(self.snipershotcount)) {
    self.snipershotcount = 0;
    self.sniperhitcount = 0;
  }

  self.snipershotcount++;
  var_0 = level.gameskill;

  if(isPlayer(self.enemy))
    var_0 = self.enemy.gameskill;

  if(shouldforcesnipermissshot()) {
    self.accuracy = 0;

    if(var_0 > 0 || self.snipershotcount > 1)
      self.lastmissedenemy = self.enemy;

    return;
  }

  self.accuracy = (1 + 1 * self.sniperhitcount) * self.baseaccuracy;
  self.sniperhitcount++;

  if(var_0 < 1 && self.sniperhitcount == 1)
    self.lastmissedenemy = undefined;
}

shouldforcesnipermissshot() {
  if(isDefined(self.neverforcesnipermissenemy) && self.neverforcesnipermissenemy)
    return 0;

  if(self.team == "allies")
    return 0;

  if(isDefined(self.lastmissedenemy) && self.enemy == self.lastmissedenemy)
    return 0;

  if(distancesquared(self.origin, self.enemy.origin) > 250000)
    return 0;

  return 1;
}

shotsafterplayerbecomesinvul() {
  return 1 + randomfloat(4);
}

didsomethingotherthanshooting() {
  self.a.misstimedebounce = 0;
}

resetaccuracyandpause() {
  resetmisstime();
}

waittimeifplayerishit() {
  var_0 = 0;
  waittillframeend;

  if(!isalive(self.enemy))
    return var_0;

  if(!isPlayer(self.enemy))
    return var_0;

  if(self.enemy maps\_utility::ent_flag("player_is_invulnerable"))
    var_0 = 0.3 + randomfloat(0.4);

  return var_0;
}

print3d_time(var_0, var_1, var_2, var_3) {
  var_3 = var_3 * 20;

  for(var_4 = 0; var_4 < var_3; var_4++)
    wait 0.05;
}

resetmisstime() {
  if(!self isbadguy()) {
    return;
  }
  if(self.weapon == "none") {
    return;
  }
  if(!animscripts\weaponlist::usingautomaticweapon() && !animscripts\weaponlist::usingsemiautoweapon()) {
    self.misstime = 0;
    return;
  }

  if(!isalive(self.enemy)) {
    return;
  }
  if(!isPlayer(self.enemy)) {
    self.accuracy = self.baseaccuracy;
    return;
  }

  var_0 = distance(self.enemy.origin, self.origin);
  setmisstime(self.enemy.gs.misstimeconstant + var_0 * self.enemy.gs.misstimedistancefactor);
}

resetmissdebouncetime() {
  self.a.misstimedebounce = gettime() + 3000;
}

setmisstime(var_0) {
  if(self.a.misstimedebounce > gettime()) {
    return;
  }
  if(var_0 > 0)
    self.accuracy = 0;

  var_0 = var_0 * 1000;
  self.a.misstime = gettime() + var_0;
  self.a.accuracygrowthmultiplier = 1;
}

player_aim_debug() {
  self endon("death");
  self notify("playeraim");
  self endon("playeraim");

  for(;;) {
    var_0 = (0, 1, 0);

    if(self.a.misstime > gettime())
      var_0 = (1, 0, 0);

    wait 0.05;
  }
}

screen_effect_on_open_bottom(var_0, var_1, var_2) {
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
  screen_effect_fade();
}

screen_effect_on_open_side(var_0, var_1, var_2) {
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
  screen_effect_fade();
}

screen_effect_fade() {
  self endon("death");
  var_0 = gettime();
  var_1 = 1;
  var_2 = 0.05;
  self.alpha = 0;
  self fadeovertime(var_2);
  self.alpha = 1;
  wait(var_2);
  maps\_utility::wait_for_buffer_time_to_pass(var_0, 2);
  self fadeovertime(var_1);
  self.alpha = 0;
  wait(var_1);
  self destroy();
}

screen_detailed_alpha() {
  var_0 = 0.2;
  self.alpha = 0.7;
  self fadeovertime(var_0);
  self.alpha = 0;
  wait(var_0);
  self destroy();
}

grenade_dirt_on_screen(var_0) {
  var_1 = "fullscreen_dirt_" + var_0;
  var_2 = undefined;

  if(var_0 == "bottom")
    var_2 = "fullscreen_dirt_bottom_b";

  thread display_screen_effect("dirt", var_0, var_1, var_2, randomfloatrange(0.55, 0.66));
}

blood_splat_on_screen(var_0) {
  var_1 = "fullscreen_bloodsplat_" + var_0;
  thread display_screen_effect("bloodsplat", var_0, var_1, undefined, randomfloatrange(0.45, 0.56));
}

display_screen_effect(var_0, var_1, var_2, var_3, var_4) {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.is_controlling_uav)) {
    return;
  }
  var_5 = gettime();

  if(self.gs.screeneffect[var_0][var_1] == var_5) {
    return;
  }
  if(self.gs.screeneffect[var_0 + "_count"][var_1] == 1) {
    return;
  }
  self.gs.screeneffect[var_0 + "_count"][var_1]++;
  self.gs.screeneffect[var_0][var_1] = var_5;
  self endon("death");

  switch (var_1) {
    case "bottom":
      var_6 = int(640);
      var_7 = int(480);

      if(var_0 == "dirt") {
        var_8 = maps\_hud_util::create_client_overlay_custom_size(var_2, 1);
        var_8 thread screen_effect_on_open_bottom(var_0, var_4, 1);
        var_8 screen_detailed_alpha();
      } else {
        var_8 = maps\_hud_util::create_client_overlay_custom_size(var_2, 0);
        var_8 screen_effect_on_open_bottom(var_0, var_4);
      }

      if(isDefined(var_3)) {
        var_9 = maps\_hud_util::create_client_overlay_custom_size(var_3, 0);
        var_9 screen_effect_on_open_bottom(var_0, var_4);
      }

      break;
    case "left":
      var_8 = maps\_hud_util::create_client_overlay_custom_size(var_2, 0, 1, 1);
      var_8 screen_effect_on_open_side(var_0, var_4, 1);
      break;
    case "right":
      var_8 = maps\_hud_util::create_client_overlay_custom_size(var_2, 0, 1, 1);
      var_8 screen_effect_on_open_side(var_0, var_4, 0);
      break;
    default:
  }

  self.gs.screeneffect[var_1 + "_count"][var_2]--;
}

playerhurtcheck() {
  var_0 = maps\_utility::dirt_on_screen_from_position;
  var_1 = maps\_utility::bloodsplateffect;
  var_2 = [];
  var_2["MOD_GRENADE"] = var_0;
  var_2["MOD_GRENADE_SPLASH"] = var_0;
  var_2["MOD_PROJECTILE"] = var_0;
  var_2["MOD_PROJECTILE_SPLASH"] = var_0;
  var_2["MOD_EXPLOSIVE"] = var_0;
  var_2["MOD_PISTOL_BULLET"] = var_1;
  var_2["MOD_RIFLE_BULLET"] = var_1;
  var_2["MOD_EXPLOSIVE_BULLET"] = var_1;
  self.hurtagain = 0;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7);
    self.hurtagain = 1;
    self.damagepoint = var_6;
    self.damageattacker = var_4;
    var_8 = undefined;

    if(isDefined(self.mods_override))
      var_8 = self.mods_override[var_7];

    if(!isDefined(var_8) && isDefined(var_2[var_7]))
      var_8 = var_2[var_7];

    if(isDefined(var_8)) {
      waittillframeend;
      [[var_8]](var_6);
    }
  }
}

player_health_packets() {
  self.player_health_packets = 3;
}

playerhealthregeninit() {
  wait 0.05;
  level.strings["take_cover"] = spawnStruct();
  level.strings["take_cover"].text = &"GAME_GET_TO_COVER";
  level.strings["get_back_up"] = spawnStruct();
  level.strings["get_back_up"].text = &"GAME_LAST_STAND_GET_BACK_UP";
}

playerhealthregen() {
  thread healthoverlay();
  var_0 = 1;
  var_1 = 0;
  thread player_health_packets();
  var_2 = 0;
  var_3 = 0;
  thread playerbreathingsound(self.maxhealth * 0.35);
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 1;
  thread playerhurtcheck();
  self.bolthit = 0;

  for(;;) {
    wait 0.05;
    waittillframeend;

    if(maps\_utility::laststand_enabled()) {
      if(isDefined(level.laststand_player_func))
        self thread[[level.laststand_player_func]]();
    }

    if(self.health == self.maxhealth) {
      if(maps\_utility::ent_flag("player_has_red_flashing_overlay"))
        player_recovers_from_red_flashing();

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

    if(var_9 <= self.gs.healthoverlaycutoff && self.player_health_packets > 1) {
      var_2 = 1;

      if(!var_8) {
        var_5 = gettime();

        if(maps\_utility::ent_flag("near_death_vision_enabled")) {
          thread blurview(3.6, 2);
          thread maps\_audio::set_deathsdoor();
          self painvisionon();
        }

        maps\_utility::ent_flag_set("player_has_red_flashing_overlay");
        var_3 = 1;
      }
    }

    if(self.hurtagain) {
      var_5 = gettime();
      self.hurtagain = 0;
    }

    if(self.health / self.maxhealth >= var_0) {
      if(gettime() - var_5 < self.gs.playerhealth_regularregendelay) {
        continue;
      }
      if(var_2) {
        var_6 = var_9;

        if(gettime() > var_5 + self.gs.longregentime)
          var_6 = var_6 + self.gs.regenrate;

        if(var_6 >= 1)
          reducetakecoverwarnings();
      } else
        var_6 = 1;

      if(var_6 > 1.0)
        var_6 = 1.0;

      if(var_6 <= 0) {
        return;
      }
      self setnormalhealth(var_6);
      var_0 = self.health / self.maxhealth;
      continue;
    }

    var_0 = var_7;
    var_10 = self.gs.worthydamageratio;

    if(self.attackercount == 1)
      var_10 = var_10 * 3;

    var_11 = var_0 - var_9 >= var_10;

    if(self.health <= 1) {
      self setnormalhealth(2 / self.maxhealth);
      var_11 = 1;
    }

    var_0 = self.health / self.maxhealth;
    self notify("hit_again");
    var_1 = 0;
    var_5 = gettime();
    thread blurview(3, 0.8);

    if(!var_11) {
      continue;
    }
    if(maps\_utility::ent_flag("player_is_invulnerable")) {
      continue;
    }
    maps\_utility::ent_flag_set("player_is_invulnerable");
    level notify("player_becoming_invulnerable");

    if(var_3) {
      var_4 = self.gs.invultime_onshield;
      var_3 = 0;
    } else if(var_2)
      var_4 = self.gs.invultime_postshield;
    else
      var_4 = self.gs.invultime_preshield;

    var_7 = self.health / self.maxhealth;
    thread playerinvul(var_4);
  }
}

reducetakecoverwarnings() {
  if(!take_cover_warnings_enabled()) {
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

playerinvul(var_0) {
  if(isDefined(self.flashendtime) && self.flashendtime > gettime())
    var_0 = var_0 * getcurrentdifficultysetting("flashbangedInvulFactor");

  if(var_0 > 0) {
    if(!isDefined(self.noplayerinvul))
      self.attackeraccuracy = 0;

    self.ignorerandombulletdamage = 1;
    wait(var_0);
  }

  update_player_attacker_accuracy();
  maps\_utility::ent_flag_clear("player_is_invulnerable");
}

default_door_node_flashbang_frequency() {
  if(self.team == "allies")
    self.doorflashchance = 0.6;

  if(self isbadguy()) {
    if(level.gameskill >= 2)
      self.doorflashchance = 0.8;
    else
      self.doorflashchance = 0.6;
  }
}

grenadeawareness() {
  if(self.team == "allies") {
    self.grenadeawareness = 0.9;
    return;
  }

  if(self isbadguy()) {
    if(level.gameskill >= 2) {
      if(randomint(100) < 33)
        self.grenadeawareness = 0.2;
      else
        self.grenadeawareness = 0.5;
    } else if(randomint(100) < 33)
      self.grenadeawareness = 0;
    else
      self.grenadeawareness = 0.2;
  }
}

blurview(var_0, var_1) {
  if(maps\_utility::ent_flag("player_no_auto_blur")) {
    return;
  }
  self notify("blurview_stop");
  self endon("blurview_stop");
  self setblurforplayer(var_0, 0);
  wait 0.05;
  self setblurforplayer(0, var_1);
}

playerbreathingsound(var_0) {
  wait 2;

  for(;;) {
    wait 0.2;

    if(self.health <= 0) {
      return;
    }
    var_1 = self.health / self.maxhealth;

    if(var_1 > self.gs.healthoverlaycutoff) {
      continue;
    }
    if(isDefined(self.disable_breathing_sound) && self.disable_breathing_sound) {
      continue;
    }
    if(isDefined(level.gameskill_breath_func))
      [[level.gameskill_breath_func]]("breathing_hurt");
    else
      self playlocalsound("breathing_hurt");

    var_2 = 0.1;

    if(isDefined(level.player.gs.custombreathingtime))
      var_2 = level.player.gs.custombreathingtime;

    wait(var_2 + randomfloat(0.8));
  }
}

healthoverlay() {
  self endon("noHealthOverlay");
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;

  if(issplitscreen()) {
    var_0 setshader("vfx_blood_screen_overlay", 640, 960);

    if(self == level.players[0])
      var_0.y = var_0.y - 120;
  } else
    var_0 setshader("vfx_blood_screen_overlay", 640, 480);

  var_0.splatter = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.enablehudlighting = 1;
  thread healthoverlay_remove(var_0);
  thread take_cover_warning_loop();
  var_1 = 0.0;
  var_2 = 0.05;

  for(var_3 = 0.3; isalive(self); var_0.alpha = var_1) {
    wait(var_2);
    var_4 = 1.0 - self.health / self.maxhealth;
    var_5 = var_4 * var_4 * 1.2;
    var_5 = clamp(var_5, 0, 1);

    if(var_1 > var_5)
      var_1 = var_1 - var_3 * var_2;

    if(var_1 < var_5)
      var_1 = var_5;
  }
}

take_cover_warning_loop() {
  while(isalive(self)) {
    maps\_utility::ent_flag_wait("player_has_red_flashing_overlay");
    take_cover_warning();
  }
}

add_hudelm_position_internal(var_0) {
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

  if(!isDefined(self.background)) {
    return;
  }
  self.background.x = 0;
  self.background.y = -40;
  self.background.alignx = "center";
  self.background.aligny = "middle";
  self.background.horzalign = "center";
  self.background.vertalign = "middle";

  if(level.console)
    self.background setshader("popmenu_bg", 650, 52);
  else
    self.background setshader("popmenu_bg", 650, 42);

  self.background.alpha = 0.5;
}

create_warning_elem() {
  var_0 = newclienthudelem(self);
  var_0 add_hudelm_position_internal();
  thread destroy_warning_elem_when_hit_again(var_0);
  var_0 thread destroy_warning_elem_when_mission_failed();

  if(maps\_utility::is_player_down(self))
    var_0 settext(level.strings["get_back_up"].text);
  else
    var_0 settext(level.strings["take_cover"].text);

  var_0.fontscale = 2;
  var_0.alpha = 1;
  var_0.color = (1, 0.9, 0.9);
  var_0.sort = 1;
  var_0.foreground = 1;
  return var_0;
}

waittillplayerishitagain() {
  self endon("hit_again");
  self endon("player_downed");
  self waittill("damage");
}

destroy_warning_elem_when_hit_again(var_0) {
  var_0 endon("being_destroyed");
  waittillplayerishitagain();
  var_1 = !isalive(self);
  var_0 thread destroy_warning_elem(var_1);
}

destroy_warning_elem_when_mission_failed() {
  self endon("being_destroyed");
  common_scripts\utility::flag_wait("missionfailed");
  thread destroy_warning_elem(1);
}

destroy_warning_elem(var_0) {
  self notify("being_destroyed");
  self.beingdestroyed = 1;

  if(var_0) {
    self fadeovertime(0.5);
    self.alpha = 0;
    wait 0.5;
  }

  self notify("death");
  self destroy();
}

may_change_cover_warning_alpha(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_0.beingdestroyed))
    return 0;

  return 1;
}

fontscaler(var_0, var_1) {
  self endon("death");
  var_0 = var_0 * 2;
  var_2 = var_0 - self.fontscale;
  self changefontscaleovertime(var_1);
  self.fontscale = self.fontscale + var_2;
}

fadefunc(var_0, var_1, var_2, var_3) {
  var_4 = 0.8;
  var_5 = 0.5;
  var_6 = var_4 * 0.1;
  var_7 = var_4 * (0.1 + var_1 * 0.2);
  var_8 = var_4 * (0.1 + var_1 * 0.1);
  var_9 = var_4 * 0.3;
  var_10 = var_4 - var_6 - var_7 - var_8 - var_9;

  if(var_10 < 0)
    var_10 = 0;

  var_11 = 0.8 + var_1 * 0.1;
  var_12 = 0.5 + var_1 * 0.3;

  if(may_change_cover_warning_alpha(var_0)) {
    if(!var_3) {
      var_0 fadeovertime(var_6);
      var_0.alpha = var_2 * 1.0;
    }
  }

  if(isDefined(var_0))
    var_0 thread fontscaler(1.0, var_6);

  wait(var_6 + var_7);

  if(may_change_cover_warning_alpha(var_0)) {
    if(!var_3) {
      var_0 fadeovertime(var_8);
      var_0.alpha = var_2 * var_11;
    }
  }

  wait(var_8);

  if(may_change_cover_warning_alpha(var_0)) {
    if(!var_3) {
      var_0 fadeovertime(var_9);
      var_0.alpha = var_2 * var_12;
    }
  }

  if(isDefined(var_0))
    var_0 thread fontscaler(0.9, var_9);

  wait(var_9);
  wait(var_10);
}

take_cover_warnings_enabled() {
  if(isDefined(level.cover_warnings_disabled))
    return 0;

  if(isDefined(self.vehicle))
    return 0;

  return 1;
}

should_show_cover_warning() {
  if(!isalive(self))
    return 0;

  if(self islinked())
    return 0;

  if(self.ignoreme)
    return 0;

  if(level.missionfailed)
    return 0;

  if(!take_cover_warnings_enabled())
    return 0;

  if(self.gameskill > 0 && !maps\_load::map_is_early_in_the_game())
    return 0;

  var_0 = self getlocalplayerprofiledata("takeCoverWarnings");

  if(var_0 <= 3)
    return 0;

  return 1;
}

take_cover_warning() {
  self endon("hit_again");
  self endon("damage");
  var_0 = undefined;

  if(should_show_cover_warning())
    var_0 = create_warning_elem();

  var_1 = gettime() + self.gs.longregentime;
  fadefunc(var_0, 1, 1, 0);

  while(gettime() < var_1 && isalive(self) && maps\_utility::ent_flag("player_has_red_flashing_overlay"))
    fadefunc(var_0, 0.9, 1, 0);

  if(isalive(self))
    fadefunc(var_0, 0.65, 0.8, 0);

  if(may_change_cover_warning_alpha(var_0)) {
    var_0 fadeovertime(1.0);
    var_0.alpha = 0;
  }

  fadefunc(var_0, 0, 0.6, 1);
  wait 0.5;
  self notify("take_cover_done");
  self notify("hit_again");
}

player_recovers_from_red_flashing() {
  maps\_utility::ent_flag_clear("player_has_red_flashing_overlay");

  if(maps\_utility::ent_flag("near_death_vision_enabled")) {
    self painvisionoff();
    thread maps\_audio::restore_after_deathsdoor();
  }

  if(!isDefined(self.disable_breathing_sound) || !self.disable_breathing_sound) {
    if(isDefined(level.gameskill_breath_func))
      [[level.gameskill_breath_func]]("breathing_better");
    else
      self playlocalsound("breathing_better");
  }

  self notify("take_cover_done");
}

healthoverlay_remove(var_0) {
  self waittill("noHealthOverlay");
  var_0 destroy();
}

resetskill() {
  waittillframeend;
  setskill(1);
}

init_take_cover_warnings() {
  var_0 = isDefined(level.ispregameplaylevel) && level.ispregameplaylevel;

  if(self getlocalplayerprofiledata("takeCoverWarnings") == -1 || var_0)
    self setlocalplayerprofiledata("takeCoverWarnings", 9);
}

increment_take_cover_warnings_on_death() {
  self notify("new_cover_on_death_thread");
  self endon("new_cover_on_death_thread");
  self waittill("death");

  if(!maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    return;
  }
  if(!take_cover_warnings_enabled()) {
    return;
  }
  var_0 = self getlocalplayerprofiledata("takeCoverWarnings");

  if(var_0 < 10)
    self setlocalplayerprofiledata("takeCoverWarnings", var_0 + 1);
}

auto_adjust_difficulty_player_positioner() {
  var_0 = self.origin;
  wait 5;

  if(autospot_is_close_to_player(var_0))
    level.autoadjust_playerspots[level.autoadjust_playerspots.size] = var_0;
}

autospot_is_close_to_player(var_0) {
  return distancesquared(self.origin, var_0) < 19600;
}

auto_adjust_difficulty_player_movement_check() {
  level.autoadjust_playerspots = [];
  level.player.movedrecently = 1;
  wait 1;

  for(;;) {
    level.player thread auto_adjust_difficulty_player_positioner();
    level.player.movedrecently = 1;
    var_0 = [];
    var_1 = level.autoadjust_playerspots.size - 5;

    if(var_1 < 0)
      var_1 = 0;

    for(var_2 = var_1; var_2 < level.autoadjust_playerspots.size; var_2++) {
      if(!level.player autospot_is_close_to_player(level.autoadjust_playerspots[var_2])) {
        continue;
      }
      var_0[var_0.size] = level.autoadjust_playerspots[var_2];
      level.player.movedrecently = 0;
    }

    level.autoadjust_playerspots = var_0;
    wait 1;
  }
}

auto_adjust_difficulty_track_player_death() {
  level.player waittill("death");
  var_0 = getdvarint("autodifficulty_playerDeathTimer");
  var_0 = var_0 - 60;
  setDvar("autodifficulty_playerDeathTimer", var_0);
}

auto_adjust_difficulty_track_player_shots() {
  var_0 = gettime();

  for(;;) {
    if(level.player attackbuttonpressed())
      var_0 = gettime();

    level.timebetweenshots = gettime() - var_0;
    wait 0.05;
  }
}

hud_debug_add_frac(var_0, var_1) {
  hud_debug_add_display(var_0, var_1 * 100, 1);
}

hud_debug_add(var_0, var_1) {
  hud_debug_add_display(var_0, var_1, 0);
}

hud_debug_clear() {
  level.hudnum = 0;

  if(isDefined(level.huddebugnum)) {
    for(var_0 = 0; var_0 < level.huddebugnum.size; var_0++)
      level.huddebugnum[var_0] destroy();
  }

  level.huddebugnum = [];
}

hud_debug_add_message(var_0) {
  if(!isDefined(level.hudmsgshare))
    level.hudmsgshare = [];

  if(!isDefined(level.hudmsgshare[var_0])) {
    var_1 = newhudelem();
    var_1.x = level.debugleft;
    var_1.y = level.debugheight + level.hudnum * 15;
    var_1.foreground = 1;
    var_1.sort = 100;
    var_1.alpha = 1.0;
    var_1.alignx = "left";
    var_1.horzalign = "left";
    var_1.fontscale = 1.0;
    var_1 settext(var_0);
    level.hudmsgshare[var_0] = 1;
  }
}

hud_debug_add_display(var_0, var_1, var_2) {
  hud_debug_add_message(var_0);
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
    hud_debug_add_num(var_4, var_8);
    var_8 = var_8 + var_9;
    hud_debug_add_num(var_5, var_8);
    var_8 = var_8 + var_9;
    hud_debug_add_num(var_6, var_8);
    var_8 = var_8 + var_9;
    hud_debug_add_num(var_7, var_8);
    var_8 = var_8 + var_9;
  } else if(var_5 > 0 || var_2) {
    hud_debug_add_num(var_5, var_8);
    var_8 = var_8 + var_9;
    hud_debug_add_num(var_6, var_8);
    var_8 = var_8 + var_9;
    hud_debug_add_num(var_7, var_8);
    var_8 = var_8 + var_9;
  } else if(var_6 > 0) {
    hud_debug_add_num(var_6, var_8);
    var_8 = var_8 + var_9;
    hud_debug_add_num(var_7, var_8);
    var_8 = var_8 + var_9;
  } else {
    hud_debug_add_num(var_7, var_8);
    var_8 = var_8 + var_9;
  }

  if(var_2) {
    var_10 = newhudelem();
    var_10.x = 204.5;
    var_10.y = level.debugheight + level.hudnum * 15;
    var_10.foreground = 1;
    var_10.sort = 100;
    var_10.alpha = 1.0;
    var_10.alignx = "left";
    var_10.horzalign = "left";
    var_10.fontscale = 1.0;
    var_10 settext(".");
    level.huddebugnum[level.huddebugnum.size] = var_10;
  }

  if(var_3) {
    var_11 = newhudelem();
    var_11.x = 195.5;
    var_11.y = level.debugheight + level.hudnum * 15;
    var_11.foreground = 1;
    var_11.sort = 100;
    var_11.alpha = 1.0;
    var_11.alignx = "left";
    var_11.horzalign = "left";
    var_11.fontscale = 1.0;
    var_11 settext(" - ");
    level.huddebugnum[level.hudnum] = var_11;
  }

  level.hudnum++;
}

hud_debug_add_string(var_0, var_1) {
  hud_debug_add_message(var_0);
  hud_debug_add_second_string(var_1, 0);
  level.hudnum++;
}

hud_debug_add_num(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 200 + var_1 * 0.65;
  var_2.y = level.debugheight + level.hudnum * 15;
  var_2.foreground = 1;
  var_2.sort = 100;
  var_2.alpha = 1.0;
  var_2.alignx = "left";
  var_2.horzalign = "left";
  var_2.fontscale = 1.0;
  var_2 settext(var_0 + "");
  level.huddebugnum[level.huddebugnum.size] = var_2;
}

hud_debug_add_second_string(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 200 + var_1 * 0.65;
  var_2.y = level.debugheight + level.hudnum * 15;
  var_2.foreground = 1;
  var_2.sort = 100;
  var_2.alpha = 1.0;
  var_2.alignx = "left";
  var_2.horzalign = "left";
  var_2.fontscale = 1.0;
  var_2 settext(var_0);
  level.huddebugnum[level.huddebugnum.size] = var_2;
}

aa_init_stats() {
  level.sp_stat_tracking_func = ::auto_adjust_new_zone;
  setDvar("aa_player_kills", "0");
  setDvar("aa_enemy_deaths", "0");
  setDvar("aa_enemy_damage_taken", "0");
  setDvar("aa_player_damage_taken", "0");
  setDvar("aa_player_damage_dealt", "0");
  setDvar("aa_ads_damage_dealt", "0");
  setDvar("aa_time_tracking", "0");
  setDvar("aa_deaths", "0");
  setDvar("player_cheated", 0);
  level.auto_adjust_results = [];
  thread aa_time_tracking();
  thread aa_player_health_tracking();
  thread aa_player_ads_tracking();
  common_scripts\utility::flag_set("auto_adjust_initialized");
  common_scripts\utility::flag_init("aa_main_" + level.script);
  common_scripts\utility::flag_set("aa_main_" + level.script);
}

command_used(var_0) {
  var_1 = getkeybinding(var_0);

  if(var_1["count"] <= 0)
    return 0;

  for(var_2 = 1; var_2 < var_1["count"] + 1; var_2++) {
    if(self buttonpressed(var_1["key" + var_2]))
      return 1;
  }

  return 0;
}

aa_time_tracking() {
  waittillframeend;

  for(;;)
    wait 0.2;
}

aa_player_ads_tracking() {
  level.player endon("death");
  level.player_ads_time = 0;

  for(;;) {
    if(level.player maps\_utility::isads()) {
      level.player_ads_time = gettime();

      while(level.player maps\_utility::isads())
        wait 0.05;

      continue;
    }

    wait 0.05;
  }
}

aa_player_health_tracking() {
  for(;;) {
    level.player waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    aa_add_event("aa_player_damage_taken", var_0);

    if(!isalive(level.player)) {
      aa_add_event("aa_deaths", 1);
      return;
    }
  }
}

auto_adjust_new_zone(var_0) {
  if(!isDefined(level.auto_adjust_flags))
    level.auto_adjust_flags = [];

  common_scripts\utility::flag_wait("auto_adjust_initialized");
  level.auto_adjust_results[var_0] = [];
  level.auto_adjust_flags[var_0] = 0;
  common_scripts\utility::flag_wait(var_0);

  if(getDvar("aa_zone" + var_0) == "") {
    setDvar("aa_zone" + var_0, "on");
    level.auto_adjust_flags[var_0] = 1;
    aa_update_flags();
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
  common_scripts\utility::flag_waitopen(var_0);
  auto_adust_zone_complete(var_0);
}

auto_adust_zone_complete(var_0) {
  setDvar("aa_zone" + var_0, "done");
  var_1 = getdvarfloat("start_time" + var_0);
  var_2 = getdvarint("starting_player_kills" + var_0);
  var_3 = getdvarint("aa_enemy_deaths" + var_0);
  var_4 = getdvarint("aa_enemy_damage_taken" + var_0);
  var_5 = getdvarint("aa_player_damage_taken" + var_0);
  var_6 = getdvarint("aa_player_damage_dealt" + var_0);
  var_7 = getdvarint("aa_ads_damage_dealt" + var_0);
  var_8 = getdvarint("aa_deaths" + var_0);
  level.auto_adjust_flags[var_0] = 0;
  aa_update_flags();
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
  var_23["gameskill"] = level.gameskill;
  level.auto_adjust_results[var_0] = var_23;
  var_24 = "Completed AA sequence: ";
  var_24 = var_24 + (level.script + "/" + var_0);
  var_25 = getarraykeys(var_23);

  for(var_26 = 0; var_26 < var_25.size; var_26++)
    var_24 = var_24 + ", " + var_25[var_26] + ": " + var_23[var_25[var_26]];

  logstring(var_24);
}

aa_print_vals(var_0, var_1) {
  logstring(var_0 + ": " + var_1[var_0]);
}

aa_update_flags() {}

aa_add_event(var_0, var_1) {
  var_2 = getdvarint(var_0);
  setDvar(var_0, var_2 + var_1);
}

aa_add_event_float(var_0, var_1) {
  var_2 = getdvarfloat(var_0);
  setDvar(var_0, var_2 + var_1);
}

return_false(var_0) {
  return 0;
}

player_attacker(var_0) {
  if([[level.custom_player_attacker]](var_0))
    return 1;

  if(isPlayer(var_0))
    return 1;

  if(!isDefined(var_0.car_damage_owner_recorder))
    return 0;

  return var_0 player_did_most_damage();
}

player_did_most_damage() {
  return self.player_damage * 1.75 > self.non_player_damage;
}

empty_kill_func(var_0, var_1, var_2) {}

auto_adjust_enemy_died(var_0, var_1, var_2, var_3) {
  aa_add_event("aa_enemy_deaths", 1);

  if(!isDefined(var_1)) {
    return;
  }
  if(!player_attacker(var_1)) {
    return;
  }
  [[level.global_kill_func]](var_2, self.damagelocation, var_3);
  aa_add_event("aa_player_kills", 1);
}

auto_adjust_enemy_death_detection(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isalive(self) || self.delayeddeath) {
    auto_adjust_enemy_died(var_1, var_2, var_5, var_4);
    return;
  }

  if(!player_attacker(var_2)) {
    return;
  }
  aa_player_attacks_enemy_with_ads(var_1, var_5, var_4);
}

aa_player_attacks_enemy_with_ads(var_0, var_1, var_2) {
  aa_add_event("aa_player_damage_dealt", var_0);

  if(!level.player maps\_utility::isads()) {
    [[level.global_damage_func]](var_1, self.damagelocation, var_2);
    return 0;
  }

  if(!bullet_attack(var_1)) {
    [[level.global_damage_func]](var_1, self.damagelocation, var_2);
    return 0;
  }

  [[level.global_damage_func_ads]](var_1, self.damagelocation, var_2);
  aa_add_event("aa_ads_damage_dealt", var_0);
  return 1;
}

bullet_attack(var_0) {
  if(var_0 == "MOD_PISTOL_BULLET")
    return 1;

  return var_0 == "MOD_RIFLE_BULLET";
}

add_fractional_data_point(var_0, var_1, var_2) {
  if(!isDefined(level.difficultysettings_frac_data_points[var_0]))
    level.difficultysettings_frac_data_points[var_0] = [];

  var_3 = [];
  var_3["frac"] = var_1;
  var_3["val"] = var_2;
  level.difficultysettings_frac_data_points[var_0][level.difficultysettings_frac_data_points[var_0].size] = var_3;
}

coop_with_one_player_downed() {
  return maps\_utility::is_coop() && maps\_utility::get_players_healthy().size == 1;
}