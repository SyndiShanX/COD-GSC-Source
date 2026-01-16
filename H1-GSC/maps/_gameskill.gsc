/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_gameskill.gsc
********************************/

setskill(var_0) {
  if(!isdefined(level.script))
    level.script = tolower(getdvar("mapname"));

  if(!isdefined(var_0) || var_0 == 0) {
    if(isdefined(level.gameskill)) {
      return;
    }
    if(!isdefined(level.custom_player_attacker))
      level.custom_player_attacker = ::return_false;

    level.global_damage_func_ads = ::empty_kill_func;
    level.global_damage_func = ::empty_kill_func;
    level.global_kill_func = ::empty_kill_func;
    maps\_utility::set_console_status();

    if(getdvar("arcademode") == "1")
      thread maps\_arcademode::main();

    foreach(var_2 in level.players) {
      var_2 maps\_utility::ent_flag_init("player_has_red_flashing_overlay");
      var_2 maps\_utility::ent_flag_init("player_is_invulnerable");
      var_2 maps\_utility::ent_flag_init("player_zero_attacker_accuracy");
      var_2 maps\_utility::ent_flag_init("player_no_auto_blur");
      var_2 maps\_utility::ent_flag_init("near_death_vision_enabled");
      var_2 maps\_utility::ent_flag_clear("near_death_vision_enabled");
      var_2.gs = spawnstruct();
      var_2.a = spawnstruct();
      var_2.damage_functions = [];
      var_2 maps\_player_stats::init_stats();
      var_2 maps\_utility::ent_flag_init("global_hint_in_use");
      var_2.pers = [];

      if(!isdefined(var_2.baseignorerandombulletdamage))
        var_2.baseignorerandombulletdamage = 0;

      var_2.disabledweapon = 0;
      var_2.disabledweaponswitch = 0;
      var_2.disabledusability = 0;
    }

    level.difficultytype[0] = "easy";
    level.difficultytype[1] = "normal";
    level.difficultytype[2] = "hardened";
    level.difficultytype[3] = "veteran";
    level.difficultystring["easy"] = & "GAMESKILL_EASY";
    level.difficultystring["normal"] = & "GAMESKILL_NORMAL";
    level.difficultystring["hardened"] = & "GAMESKILL_HARDENED";
    level.difficultystring["veteran"] = & "GAMESKILL_VETERAN";
    thread gameskill_change_monitor();
  }

  setdvarifuninitialized("autodifficulty_playerDeathTimer", 0);
  anim.run_accuracy = 0.5;
  anim.walk_accuracy = 0.8;
  setdvar("autodifficulty_frac", 0);
  level.difficultysettings_frac_data_points = [];

  foreach(var_2 in level.players) {
    var_2 init_take_cover_warnings();
    var_2 thread increment_take_cover_warnings_on_death();
  }

  level.mg42badplace_mintime = 8;
  level.mg42badplace_maxtime = 16;
  level.difficultysettings["playerGrenadeBaseTime"]["easy"] = 40000;
  level.difficultysettings["playerGrenadeBaseTime"]["normal"] = 25000;
  level.difficultysettings["playerGrenadeBaseTime"]["hardened"] = 10000;
  level.difficultysettings["playerGrenadeBaseTime"]["veteran"] = 0;
  level.difficultysettings["playerGrenadeRangeTime"]["easy"] = 20000;
  level.difficultysettings["playerGrenadeRangeTime"]["normal"] = 15000;
  level.difficultysettings["playerGrenadeRangeTime"]["hardened"] = 5000;
  level.difficultysettings["playerGrenadeRangeTime"]["veteran"] = 1;
  level.difficultysettings["playerDoubleGrenadeTime"]["easy"] = 3600000;
  level.difficultysettings["playerDoubleGrenadeTime"]["normal"] = 120000;
  level.difficultysettings["playerDoubleGrenadeTime"]["hardened"] = 15000;
  level.difficultysettings["playerDoubleGrenadeTime"]["veteran"] = 0;
  level.difficultysettings["double_grenades_allowed"]["easy"] = 0;
  level.difficultysettings["double_grenades_allowed"]["normal"] = 1;
  level.difficultysettings["double_grenades_allowed"]["hardened"] = 1;
  level.difficultysettings["double_grenades_allowed"]["veteran"] = 1;
  level.difficultysettings["threatbias"]["easy"] = 100;
  level.difficultysettings["threatbias"]["normal"] = 150;
  level.difficultysettings["threatbias"]["hardened"] = 200;
  level.difficultysettings["threatbias"]["veteran"] = 400;
  level.difficultysettings["base_enemy_accuracy"]["easy"] = 1.0;
  level.difficultysettings["base_enemy_accuracy"]["normal"] = 1.0;
  level.difficultysettings["base_enemy_accuracy"]["hardened"] = 1.3;
  level.difficultysettings["base_enemy_accuracy"]["veteran"] = 1.3;
  level.difficultysettings["accuracyDistScale"]["easy"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["normal"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["hardened"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["veteran"] = 0.5;
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

  if(getdvar("old_dog_melee_combat") == "1") {
    level.difficultysettings["dog_presstime"]["easy"] = 415;
    level.difficultysettings["dog_presstime"]["normal"] = 375;
    level.difficultysettings["dog_presstime"]["hardened"] = 250;
    level.difficultysettings["dog_presstime"]["veteran"] = 225;
  } else {
    level.difficultysettings["dog_presstime"]["easy"] = 750;
    level.difficultysettings["dog_presstime"]["normal"] = 550;
    level.difficultysettings["dog_presstime"]["hardened"] = 350;
    level.difficultysettings["dog_presstime"]["veteran"] = 250;
  }

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
  level.difficultysettings["player_deathInvulnerableTime"]["normal"] = 1700;
  level.difficultysettings["player_deathInvulnerableTime"]["hardened"] = 600;
  level.difficultysettings["player_deathInvulnerableTime"]["veteran"] = 100;
  level.difficultysettings["invulTime_preShield"]["easy"] = 0.6;
  level.difficultysettings["invulTime_preShield"]["normal"] = 0.35;
  level.difficultysettings["invulTime_preShield"]["hardened"] = 0.1;
  level.difficultysettings["invulTime_preShield"]["veteran"] = 0.0;
  level.difficultysettings["invulTime_onShield"]["easy"] = 0.8;
  level.difficultysettings["invulTime_onShield"]["normal"] = 0.5;
  level.difficultysettings["invulTime_onShield"]["hardened"] = 0.1;
  level.difficultysettings["invulTime_onShield"]["veteran"] = 0.05;
  level.difficultysettings["invulTime_postShield"]["easy"] = 0.5;
  level.difficultysettings["invulTime_postShield"]["normal"] = 0.3;
  level.difficultysettings["invulTime_postShield"]["hardened"] = 0.1;
  level.difficultysettings["invulTime_postShield"]["veteran"] = 0.0;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["easy"] = 3000;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["normal"] = 2000;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["hardened"] = 1200;
  level.difficultysettings["playerHealth_RegularRegenDelay"]["veteran"] = 1200;
  level.difficultysettings["worthyDamageRatio"]["easy"] = 0.0;
  level.difficultysettings["worthyDamageRatio"]["normal"] = 0.1;
  level.difficultysettings["worthyDamageRatio"]["hardened"] = 0.1;
  level.difficultysettings["worthyDamageRatio"]["veteran"] = 0.1;
  level.difficultysettings["playerDifficultyHealth"]["easy"] = 475;
  level.difficultysettings["playerDifficultyHealth"]["normal"] = 275;
  level.difficultysettings["playerDifficultyHealth"]["hardened"] = 165;
  level.difficultysettings["playerDifficultyHealth"]["veteran"] = 115;
  level.difficultysettings["longRegenTime"]["easy"] = 5000;
  level.difficultysettings["longRegenTime"]["normal"] = 5000;
  level.difficultysettings["longRegenTime"]["hardened"] = 5000;
  level.difficultysettings["longRegenTime"]["veteran"] = 5000;
  level.difficultysettings["healthOverlayCutoff"]["easy"] = 0.01;
  level.difficultysettings["healthOverlayCutoff"]["normal"] = 0.2;
  level.difficultysettings["healthOverlayCutoff"]["hardened"] = 0.3;
  level.difficultysettings["healthOverlayCutoff"]["veteran"] = 0.5;
  level.difficultysettings["health_regenRate"]["easy"] = 0.1;
  level.difficultysettings["health_regenRate"]["normal"] = 0.1;
  level.difficultysettings["health_regenRate"]["hardened"] = 0.1;
  level.difficultysettings["health_regenRate"]["veteran"] = 0.1;
  level.difficultysettings["explosivePlantTime"]["easy"] = 10;
  level.difficultysettings["explosivePlantTime"]["normal"] = 10;
  level.difficultysettings["explosivePlantTime"]["hardened"] = 5;
  level.difficultysettings["explosivePlantTime"]["veteran"] = 5;
  level.difficultysettings["player_downed_buffer_time"]["normal"] = 2;
  level.difficultysettings["player_downed_buffer_time"]["hardened"] = 1.5;
  level.difficultysettings["player_downed_buffer_time"]["veteran"] = 0;
  level.lastplayersighted = 0;
  setsaveddvar("player_meleeDamageMultiplier", 0.4);

  if(isdefined(level.custom_gameskill_func))
    [[level.custom_gameskill_func]]();

  updategameskill();
  updatealldifficulty();
  setdvar("autodifficulty_original_setting", level.gameskill);
}

updatealldifficulty() {
  setglobaldifficulty();

  for (var_0 = 0; var_0 < level.players.size; var_0++)
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
  foreach(var_1 in level.players)
  var_1.gameskill = var_1 maps\_utility::get_player_gameskill();

  level.gameskill = level.player.gameskill;
  level.specops_reward_gameskill = level.player.gameskill;

  if(isdefined(level.forcedgameskill))
    level.gameskill = level.forcedgameskill;

  return level.gameskill;
}

gameskill_change_monitor() {
  var_0 = level.gameskill;
  var_1 = 0;

  for (;;) {
    if(!isdefined(var_0)) {
      wait 1;
      var_0 = level.gameskill;
      continue;
    }

    if(!var_1) {
      updatealldifficulty();
      var_1 = 1;
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
  self.attackeraccuracy = self.gs.player_attacker_accuracy;
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

getcurrentdifficultysetting(var_0) {
  return level.difficultysettings[var_0][get_skill_from_index(self.gameskill)];
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

  if(!isplayer(self.enemy))
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

  if(isplayer(self.enemy)) {
    resetmissdebouncetime();

    if(self.a.misstime > gettime()) {
      self.accuracy = 0;
      return;
    }

    if(self.script == "move") {
      self.accuracy = anim.run_accuracy * self.baseaccuracy;
      return;
    }
  } else if(self.script == "move") {
    self.accuracy = anim.run_accuracy * self.baseaccuracy;
    return;
  }

  self.accuracy = self.baseaccuracy;
}

setsniperaccuracy() {
  if(!isdefined(self.snipershotcount)) {
    self.snipershotcount = 0;
    self.sniperhitcount = 0;
  }

  self.snipershotcount++;

  if((!isdefined(self.lastmissedenemy) || self.enemy != self.lastmissedenemy) && distancesquared(self.origin, self.enemy.origin) > 250000) {
    self.accuracy = 0;

    if(level.gameskill > 0 || self.snipershotcount > 1)
      self.lastmissedenemy = self.enemy;

    return;
  }

  self.accuracy = (1 + 1 * self.sniperhitcount) * self.baseaccuracy;
  self.sniperhitcount++;

  if(level.gameskill < 1 && self.sniperhitcount == 1)
    self.lastmissedenemy = undefined;
}

didsomethingotherthanshooting() {
  self.a.misstimedebounce = 0;
}

resetaccuracyandpause() {
  resetmisstime();
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
  if(!isplayer(self.enemy)) {
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

playerhurtcheck() {
  self.hurtagain = 0;

  for (;;) {
    self waittill("damage", var_0, var_1, var_2, var_3);
    self.hurtagain = 1;
    self.damagepoint = var_3;
    self.damageattacker = var_1;
  }
}

player_health_packets() {
  self.player_health_packets = 3;
}

playerhealthregen() {
  thread healthoverlayalt();
  thread healthoverlay();
  thread redhitflash();
  thread bloodsplatter();
  var_0 = 1;
  var_1 = 0;
  thread player_health_packets();
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 1;
  thread playerhurtcheck();
  self.bolthit = 0;

  for (;;) {
    wait 0.05;
    waittillframeend;

    if(self.health == self.maxhealth) {
      thread soundscripts\_audio::restore_after_deathsdoor();

      if(maps\_utility::ent_flag("player_has_red_flashing_overlay"))
        maps\_utility::ent_flag_clear("player_has_red_flashing_overlay");

      var_7 = 1;
      var_3 = 0;
      var_2 = 0;
      continue;
    }

    if(self.health <= 0) {
      return;
    }
    var_8 = 0;
    var_9 = var_2;
    var_10 = self.health / self.maxhealth;

    if(var_10 <= self.gs.healthoverlaycutoff && self.player_health_packets > 1) {
      var_2 = 1;

      if(!var_9) {
        var_5 = gettime();
        var_8 = 1;

        if(getdvarint("cg_altDamageMode") == 0) {
          if(isusinghdr())
            thread blurview(2, 2);
          else
            thread blurview(3.6, 2);
        } else if(isusinghdr())
          thread blurview(40, 0.25);
        else
          thread blurview(7.5, 0.67);

        thread soundscripts\_audio::set_deathsdoor();

        if(maps\_utility::ent_flag("near_death_vision_enabled"))
          self painvisionon();

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
        var_6 = var_10;

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
    var_11 = var_0 - var_10 >= self.gs.worthydamageratio;

    if(self.health <= 1) {
      self setnormalhealth(2 / self.maxhealth);
      var_11 = 1;
    }

    var_0 = self.health / self.maxhealth;
    self notify("hit_again");
    var_1 = 0;
    var_5 = gettime();

    if(var_8 == 0) {
      if(getdvarint("cg_altDamageMode") == 0) {
        if(isusinghdr())
          thread blurview(2, 2);
        else
          thread blurview(3.6, 2);
      } else if(isusinghdr())
        thread blurview(4, 0.67);
      else
        thread blurview(7.5, 0.67);
    }

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
  if(isdefined(self.flashendtime) && self.flashendtime > gettime())
    var_0 = var_0 * getcurrentdifficultysetting("flashbangedInvulFactor");

  if(var_0 > 0) {
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

healthoverlayalt() {
  self endon("noHealthOverlay");
  var_0 = newclienthudelem(self);
  var_0.sourcewidth = 648;
  var_0.sourceheight = 486;
  var_0.scalewidth = 640;
  var_0.scaleheight = 480;

  switch (level.script) {
    case "village_assault":
    case "cargoship":
    case "blackout":
    case "airplane":
      setsaveddvar("cg_altDamageBrightness", 0.1);
      setsaveddvar("cg_altDamageAlpha", ".65");
      setsaveddvar("cg_altDamageFlashColor", ".2 0 0");
      setsaveddvar("cg_bloodThickColor", "100 0 0 150");
      var_1 = "overlay_low_health_alt";
      break;
    case "launchfacility_b":
    case "bog_a":
      setsaveddvar("cg_altDamageBrightness", 0.1);
      setsaveddvar("cg_altDamageAlpha", ".7");
      setsaveddvar("cg_altDamageFlashColor", ".2 0 0");
      setsaveddvar("cg_bloodThickColor", "100 0 0 150");
      var_1 = "overlay_low_health_alt";
      break;
    case "airlift":
      setsaveddvar("cg_altDamageDisableFilmTweak", 1);
      setsaveddvar("cg_bloodThickColor", "100 0 0 150");
      setsaveddvar("cg_altDamageBrightness", 0.1);
      setsaveddvar("cg_altDamageAlpha", ".7");
      setsaveddvar("cg_altDamageFlashColor", ".2 0 0");
      var_1 = "overlay_low_health_alt";
      break;
    case "hunted":
      setsaveddvar("cg_altDamageBrightness", 0.1);
      setsaveddvar("cg_altDamageAlpha", ".5");
      setsaveddvar("cg_altDamageFlashColor", ".2 0 0");
      setsaveddvar("cg_bloodThickColor", "100 0 0 150");
      var_1 = "overlay_low_health_alt";
      break;
    default:
      setsaveddvar("cg_altDamageBrightness", 0);
      setsaveddvar("cg_altDamageAlpha", "1");
      setsaveddvar("cg_altDamageFlashColor", ".125 0 0");
      setsaveddvar("cg_bloodThickColor", "100 0 0 100");
      var_1 = "overlay_low_health";
      break;
  }

  var_0.x = 320;
  var_0.y = 240;
  var_0 setshader(var_1, var_0.scalewidth, var_0.scaleheight);
  var_0.splatter = 1;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  thread healthoverlay_remove(var_0);

  for (;;) {
    var_0 fadeovertime(0.5);
    var_0.alpha = 0;

    if(!isalive(level.player)) {
      break;
    }

    maps\_utility::ent_flag_wait("player_has_red_flashing_overlay");

    if(getdvarint("cg_altDamageMode") == 1) {
      redflashingoverlayalt(var_0);
      continue;
    }

    wait 0.5;
  }
}

healthoverlay() {
  self endon("noHealthOverlay");
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("overlay_low_health", 640, 480);
  var_0.splatter = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  thread healthoverlay_remove(var_0);

  for (;;) {
    var_0 fadeovertime(0.5);
    var_0.alpha = 0;

    if(!isalive(level.player)) {
      break;
    }

    maps\_utility::ent_flag_wait("player_has_red_flashing_overlay");

    if(getdvarint("cg_altDamageMode") == 0) {
      redflashingoverlay(var_0);
      continue;
    }

    wait 0.5;
  }
}

bloodsplatter() {
  self endon("noHealthOverlay");
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("h1_fullscreen_lit_bloodsplat_01", 640, 480);
  var_0.splatter = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 3;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.enablehudlighting = 1;
  var_0.color = (0, 0, 0);
  var_0.alpha = 0;
  thread healthoverlay_remove(var_0);
  var_1 = 0;
  var_2 = 0.28;
  var_3 = 0.05;
  var_4 = 5;

  for (;;) {
    var_5 = clamp(self.health / self.maxhealth, 0, 1);
    var_6 = 1.0 - var_5;

    if(var_1 > var_6)
      var_1 = var_1 - var_2 * var_3;

    if(var_1 < var_6)
      var_1 = var_6;

    var_0.color = (var_1, 0, 0);

    if(var_1 == 0)
      var_0.alpha = 0;
    else
      var_0.alpha = 1;

    wait(var_3);
  }
}

redhitflash() {
  self endon("noHealthOverlay");
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("h1_screen_blood", 640, 480);
  var_0.splatter = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 2;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  thread healthoverlay_remove(var_0);

  for (;;) {
    level.player waittillplayerishitagain();

    if(!isalive(self)) {
      break;
    }

    if(getdvarint("cg_altDamageMode") == 0) {
      thread redhitflashoverlay(var_0);
      continue;
    }

    wait 0.5;
  }

  var_0.alpha = 0;
}

redhitflashoverlay(var_0) {
  self endon("hit_again");
  var_0.alpha = 1;
  wait 0.17;
  var_0 fadeovertime(0.25);
  var_0.alpha = 0;
}

compasshealthoverlay() {
  self endon("noHealthOverlay");
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 35;
  var_0 setshader("overlay_low_health_compass", 336, 168);
  var_0.alignx = "center";
  var_0.aligny = "bottom";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.horzalign = "center";
  var_0.vertalign = "bottom";
  var_0.alpha = 0;

  for (;;) {
    var_0 fadeovertime(0.2);
    var_0.alpha = 0;

    if(!isalive(self)) {
      break;
    }

    self waittill("activate_compass_red_overlay");

    if(!maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
      continue;
    }
    if(getdvar("compass") == "0") {
      wait 0.5;
      continue;
    }

    compassflashingoverlay(var_0);
  }
}

compassflashingoverlay(var_0) {
  self endon("hit_again");
  var_1 = gettime() + self.gs.longregentime;
  var_2 = var_1 + 500;
  var_3 = 0.2;
  var_4 = 0.2;

  while (isalive(self)) {
    var_5 = 1;

    if(gettime() > var_1) {
      var_5 = 1 - (gettime() - var_1) / (var_2 - var_1);

      if(var_5 < 0)
        var_5 = 0;
    }

    var_0 fadeovertime(var_3);
    var_0.alpha = var_5;
    wait(var_3 + var_4);
    var_0 fadeovertime(var_3);
    var_0.alpha = var_5 * 0.8;
    wait(var_3);

    if(var_5 <= 0) {
      break;
    }
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

  if(!isdefined(self.background)) {
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
  var_0 thread destroy_warning_elem_when_hit_again();
  var_0 thread destroy_warning_elem_when_mission_failed();
  var_0 settext(&"GAME_GET_TO_COVER");
  var_0.fontscale = 2;
  var_0.alpha = 1;
  var_0.color = (1, 0.9, 0.9);
  var_0.sort = 1;
  var_0.foreground = 1;
  return var_0;
}

waittillplayerishitagain() {
  self endon("hit_again");
  self waittill("damage");
}

destroy_warning_elem_when_hit_again() {
  self endon("being_destroyed");
  level.player waittillplayerishitagain();
  var_0 = !isalive(level.player);
  thread destroy_warning_elem(var_0);
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
  if(!isdefined(var_0))
    return 0;

  if(isdefined(var_0.beingdestroyed))
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

pulseoverlay(var_0) {
  self endon("hit_again");
  self endon("kill_pulse");
  var_1 = 0.1;
  var_2 = 0.5;
  var_3 = 0.1;
  var_4 = 0.025;
  var_5 = 0.575;
  var_6 = 1;
  var_7 = 0.7;
  var_8 = 0.1;
  var_0.alpha = var_6;
  var_9 = max(var_1, var_4);
  var_9 = var_9 + max(var_3, var_8);
  var_10 = max(var_2, var_5);
  var_10 = var_10 + max(var_3, var_8);
  var_11 = "breathing_heartbeat";
  level.player playsound(var_11);

  for (;;) {
    var_0 scaleovertime(var_2, var_0.sourcewidth, var_0.sourceheight);
    var_0 fadeovertime(var_5);
    var_0.alpha = var_7;
    wait(var_10);
    var_0 scaleovertime(var_1, var_0.scalewidth, var_0.scaleheight);
    var_0 fadeovertime(var_4);
    var_0.alpha = var_6;
    wait(var_9);
    self playlocalsound(var_11);
  }
}

fadefunc(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0.65;
  var_6 = 0.5;
  var_7 = var_5 * 0.2;
  var_8 = var_5 * (0.1 + var_2 * 0.1);
  var_9 = var_5 * (0.05 + var_2 * 0.1);
  var_10 = var_5 * 0.3;
  var_11 = var_5 - var_7 - var_8 - var_9 - var_10;

  if(var_11 < 0)
    var_11 = 0;

  var_12 = 0.5 + var_2 * 0.3;
  var_13 = 1 - (1 - var_12) / 2;
  var_0 fadeovertime(var_7);
  var_0.alpha = var_3 * 1.0;

  if(may_change_cover_warning_alpha(var_1)) {
    if(!var_4) {
      var_1 fadeovertime(var_7);
      var_1.alpha = var_3 * 1.0;
    }
  }

  if(isdefined(var_1))
    var_1 thread fontscaler(1.0, var_7);

  wait(var_7 + var_8);
  var_0 fadeovertime(var_9);
  var_0.alpha = var_3 * var_13;

  if(may_change_cover_warning_alpha(var_1)) {
    if(!var_4) {
      var_1 fadeovertime(var_9);
      var_1.alpha = var_3 * var_13;
    }
  }

  wait(var_9);
  var_0 fadeovertime(var_10);
  var_0.alpha = var_3 * var_12;

  if(may_change_cover_warning_alpha(var_1)) {
    if(!var_4) {
      var_1 fadeovertime(var_10);
      var_1.alpha = var_3 * var_12;
    }
  }

  if(isdefined(var_1))
    var_1 thread fontscaler(0.9, var_10);

  wait(var_10);
  wait(var_11);
}

take_cover_warnings_enabled() {
  if(isdefined(level.cover_warnings_disabled))
    return 0;

  if(isdefined(self.underwater) && self.underwater == 1)
    return 0;

  if(isdefined(self.vehicle))
    return 0;

  return 1;
}

should_show_cover_warning() {
  if(maps\_utility::is_h1_level())
    return 0;

  if(!isalive(self))
    return 0;

  if(self islinked())
    return 0;

  if(self.ignoreme)
    return 0;

  if(!take_cover_warnings_enabled())
    return 0;

  if(self.gameskill > 1)
    return 0;

  if(level.missionfailed)
    return 0;

  if(!maps\_load::map_is_early_in_the_game())
    return 0;

  if(getdvar("limited_mode") == "1")
    return 0;

  var_0 = self getlocalplayerprofiledata("takeCoverWarnings");

  if(var_0 <= 3)
    return 0;

  return 1;
}

redflashingoverlayalt(var_0) {
  self endon("hit_again");
  self notify("activate_compass_red_overlay");
  var_1 = undefined;

  if(should_show_cover_warning())
    var_1 = create_warning_elem();

  var_2 = gettime() + self.gs.longregentime;
  thread pulseoverlay(var_0);
  wait(self.gs.longregentime / 1000.0);

  if(may_change_cover_warning_alpha(var_1)) {
    var_1 fadeovertime(1.0);
    var_1.alpha = 0;
  }

  self notify("kill_pulse");
  var_0 fadeovertime(0.5);
  var_0.alpha = 0;
  maps\_utility::ent_flag_clear("player_has_red_flashing_overlay");

  if(!isdefined(self.disable_breathing_sound) || !self.disable_breathing_sound) {
    var_3 = "breathing_better";

    if(soundexists(var_3))
      self playlocalsound(var_3);
  }

  if(maps\_utility::ent_flag("near_death_vision_enabled"))
    self painvisionoff();
}

redflashingoverlay(var_0) {
  self endon("hit_again");
  self notify("activate_compass_red_overlay");
  var_1 = undefined;

  if(should_show_cover_warning())
    var_1 = create_warning_elem();

  var_2 = gettime() + self.gs.longregentime;
  fadefunc(var_0, var_1, 0.8, 0.7, 0);
  level.player playsound("breathing_heartbeat");

  while (gettime() < var_2 && isalive(self) && maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    fadefunc(var_0, var_1, 0.9, 1, 0);
    var_3 = "breathing_heartbeat";

    if(soundexists(var_3))
      self playlocalsound(var_3);
  }

  if(may_change_cover_warning_alpha(var_1)) {
    var_1 fadeovertime(1.0);
    var_1.alpha = 0;
  }

  fadefunc(var_0, var_1, 0, 0.7, 1);
  var_0 fadeovertime(0.5);
  var_0.alpha = 0;
  maps\_utility::ent_flag_clear("player_has_red_flashing_overlay");

  if(!isdefined(self.disable_breathing_sound) || !self.disable_breathing_sound) {
    var_4 = "breathing_better";

    if(soundexists(var_4))
      self playlocalsound(var_4);
  }

  if(maps\_utility::ent_flag("near_death_vision_enabled"))
    self painvisionoff();
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
  var_0 = level.script == "cargoship" || level.script == "coup";

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
  if(level.gameskill > 1) {
    return;
  }
  var_0 = self getlocalplayerprofiledata("takeCoverWarnings");

  if(var_0 < 10)
    self setlocalplayerprofiledata("takeCoverWarnings", var_0 + 1);
}

aa_init_stats() {
  level.sp_stat_tracking_func = ::auto_adjust_new_zone;
  setdvar("aa_player_kills", "0");
  setdvar("aa_enemy_deaths", "0");
  setdvar("aa_enemy_damage_taken", "0");
  setdvar("aa_player_damage_taken", "0");
  setdvar("aa_player_damage_dealt", "0");
  setdvar("aa_ads_damage_dealt", "0");
  setdvar("aa_time_tracking", "0");
  setdvar("aa_deaths", "0");
  setdvar("player_cheated", 0);
  level.auto_adjust_results = [];
  thread aa_time_tracking();
  thread aa_player_health_tracking();
  thread aa_player_ads_tracking();
  common_scripts\utility::flag_set("auto_adjust_initialized");
  common_scripts\utility::flag_init("aa_main_" + level.script);
  common_scripts\utility::flag_set("aa_main_" + level.script);
}

aa_time_tracking() {
  waittillframeend;

  for (;;)
    wait 0.2;
}

aa_player_ads_tracking() {
  level.player endon("death");
  level.player_ads_time = 0;

  for (;;) {
    if(level.player maps\_utility::isads()) {
      level.player_ads_time = gettime();

      while (level.player maps\_utility::isads())
        wait 0.05;

      continue;
    }

    wait 0.05;
  }
}

aa_player_health_tracking() {
  for (;;) {
    level.player waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    aa_add_event("aa_player_damage_taken", var_0);

    if(!isalive(level.player)) {
      aa_add_event("aa_deaths", 1);
      return;
    }
  }
}

auto_adjust_new_zone(var_0) {
  if(!isdefined(level.auto_adjust_flags))
    level.auto_adjust_flags = [];

  common_scripts\utility::flag_wait("auto_adjust_initialized");
  level.auto_adjust_results[var_0] = [];
  level.auto_adjust_flags[var_0] = 0;
  common_scripts\utility::flag_wait(var_0);

  if(getdvar("aa_zone" + var_0) == "") {
    setdvar("aa_zone" + var_0, "on");
    level.auto_adjust_flags[var_0] = 1;
    aa_update_flags();
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
  auto_adust_zone_complete(var_0);
}

auto_adust_zone_complete(var_0) {
    setdvar("aa_zone" + var_0, "done");
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
    var_24 = var_24 + (level.script + "\" + var_0);
      var_25 = getarraykeys(var_23);

      for (var_26 = 0; var_26 < var_25.size; var_26++)
        var_24 = var_24 + ", " + var_25[var_26] + ": " + var_23[var_25[var_26]];

      logstring(var_24);
    }

    aa_print_vals(var_0, var_1) {
      logstring(var_0 + ": " + var_1[var_0]);
    }

    aa_update_flags() {}

    aa_add_event(var_0, var_1) {
      var_2 = getdvarint(var_0);
      setdvar(var_0, var_2 + var_1);
    }

    aa_add_event_float(var_0, var_1) {
      var_2 = getdvarfloat(var_0);
      setdvar(var_0, var_2 + var_1);
    }

    return_false(var_0) {
      return 0;
    }

    player_attacker(var_0) {
      if([
          [level.custom_player_attacker]
        ](var_0))
        return 1;

      if(isplayer(var_0))
        return 1;

      if(!isdefined(var_0.car_damage_owner_recorder))
        return 0;

      return var_0 player_did_most_damage();
    }

    player_did_most_damage() {
      return self.player_damage * 1.75 > self.non_player_damage;
    }

    empty_kill_func(var_0, var_1, var_2) {}

    auto_adjust_enemy_died(var_0, var_1, var_2, var_3) {
      aa_add_event("aa_enemy_deaths", 1);

      if(!isdefined(var_1)) {
        return;
      }
      if(!player_attacker(var_1)) {
        return;
      }
      [
        [level.global_kill_func]
      ](var_2, self.damagelocation, var_3);
      aa_add_event("aa_player_kills", 1);
    }

    auto_adjust_enemy_death_detection(var_0, var_1, var_2, var_3, var_4, var_5, var_5) {
      if(!isalive(self) || self.delayeddeath) {
        auto_adjust_enemy_died(var_0, var_1, var_4, var_3);
        return;
      }

      if(!player_attacker(var_1)) {
        return;
      }
      aa_player_attacks_enemy_with_ads(var_0, var_4, var_3);
    }

    aa_player_attacks_enemy_with_ads(var_0, var_1, var_2) {
      aa_add_event("aa_player_damage_dealt", var_0);

      if(!level.player maps\_utility::isads()) {
        [
          [level.global_damage_func]
        ](var_1, self.damagelocation, var_2);
        return 0;
      }

      if(!bullet_attack(var_1)) {
        [
          [level.global_damage_func]
        ](var_1, self.damagelocation, var_2);
        return 0;
      }

      [
        [level.global_damage_func_ads]
      ](var_1, self.damagelocation, var_2);
      aa_add_event("aa_ads_damage_dealt", var_0);
      return 1;
    }

    bullet_attack(var_0) {
      if(var_0 == "MOD_PISTOL_BULLET")
        return 1;

      return var_0 == "MOD_RIFLE_BULLET";
    }

    coop_player_in_special_ops_survival() {}

    solo_player_in_special_ops() {}

    solo_player_in_coop_gameskill_settings() {}

    grenade_dirt_on_screen(var_0) {}

    blood_splat_on_screen(var_0) {}

    add_fractional_data_point(var_0, var_1, var_2) {}