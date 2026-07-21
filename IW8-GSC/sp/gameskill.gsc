/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\gameskill.gsc
***********************************************/

init_gameskill() {
  if(!scripts\engine\utility::add_init_script("gameskill", ::init_gameskill)) {
    return;
  }
  auto_adjust_init();
  scripts\sp\player::init();
  scripts\common\gameskill::set_early_level();
  setskill();
}

setskill(var_0) {
  if(!istrue(var_0)) {
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
  level.difficultysettings["base_enemy_accuracy"]["easy"] = 1.0;
  level.difficultysettings["base_enemy_accuracy"]["normal"] = 1.0;
  level.difficultysettings["base_enemy_accuracy"]["hardened"] = 1.0;
  level.difficultysettings["base_enemy_accuracy"]["veteran"] = 1.0;
  level.difficultysettings["base_enemy_accuracy"]["realism"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["easy"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["normal"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["hardened"] = 0.6;
  level.difficultysettings["accuracyDistScale"]["veteran"] = 0.1;
  level.difficultysettings["accuracyDistScale"]["realism"] = 0.1;
  level.difficultysettings["min_sniper_burst_delay_time"]["easy"] = 3.0;
  level.difficultysettings["min_sniper_burst_delay_time"]["normal"] = 2.0;
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
  level.difficultysettings["max_sniper_burst_delay_time"]["easy"] = 4.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["normal"] = 3.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["hardened"] = 2.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["veteran"] = 1.5;
  level.difficultysettings["max_sniper_burst_delay_time"]["realism"] = 1.5;
  level.difficultysettings["pain_test"]["easy"] = scripts\common\gameskill::always_pain;
  level.difficultysettings["pain_test"]["normal"] = scripts\common\gameskill::always_pain;
  level.difficultysettings["pain_test"]["hardened"] = scripts\common\gameskill::pain_protection;
  level.difficultysettings["pain_test"]["veteran"] = scripts\common\gameskill::pain_protection;
  level.difficultysettings["pain_test"]["realism"] = scripts\common\gameskill::pain_protection;
  level.difficultysettings["missTimeConstant"]["supereasy"] = 1.2;
  level.difficultysettings["missTimeConstant"]["easy"] = 1.0;
  level.difficultysettings["missTimeConstant"]["normal"] = 0.05;
  level.difficultysettings["missTimeConstant"]["hardened"] = 0;
  level.difficultysettings["missTimeConstant"]["veteran"] = 0;
  level.difficultysettings["missTimeConstant"]["realism"] = 0;
  level.difficultysettings["missTimeDistanceFactor"]["supereasy"] = 0.0009;
  level.difficultysettings["missTimeDistanceFactor"]["easy"] = 0.0008;
  level.difficultysettings["missTimeDistanceFactor"]["normal"] = 0.0001;
  level.difficultysettings["missTimeDistanceFactor"]["hardened"] = 0.00005;
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
  level.difficultysettings["invulTime_deathShieldDuration"]["supereasy"] = 4.0;
  level.difficultysettings["invulTime_deathShieldDuration"]["easy"] = 4.0;
  level.difficultysettings["invulTime_deathShieldDuration"]["normal"] = 1.7;
  level.difficultysettings["invulTime_deathShieldDuration"]["hardened"] = 0.6;
  level.difficultysettings["invulTime_deathShieldDuration"]["veteran"] = 0.25;
  level.difficultysettings["invulTime_deathShieldDuration"]["realism"] = 0.25;
  level.difficultysettings["player_deathsDoorDuration"]["supereasy"] = 3;
  level.difficultysettings["player_deathsDoorDuration"]["easy"] = 3.5;
  level.difficultysettings["player_deathsDoorDuration"]["normal"] = 6.0;
  level.difficultysettings["player_deathsDoorDuration"]["hardened"] = 7.0;
  level.difficultysettings["player_deathsDoorDuration"]["veteran"] = 8.0;
  level.difficultysettings["player_deathsDoorDuration"]["realism"] = 8.0;
  level.difficultysettings["player_healthRegenDelay"]["supereasy"] = 2;
  level.difficultysettings["player_healthRegenDelay"]["easy"] = 2.5;
  level.difficultysettings["player_healthRegenDelay"]["normal"] = 3.0;
  level.difficultysettings["player_healthRegenDelay"]["hardened"] = 4.0;
  level.difficultysettings["player_healthRegenDelay"]["veteran"] = 5.05;
  level.difficultysettings["player_healthRegenDelay"]["realism"] = 5.05;
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
  level.difficultysettings["explosiveDamageMultiplier"]["supereasy"] = 0.5;
  level.difficultysettings["explosiveDamageMultiplier"]["easy"] = 0.75;
  level.difficultysettings["explosiveDamageMultiplier"]["normal"] = 1;
  level.difficultysettings["explosiveDamageMultiplier"]["hardened"] = 1;
  level.difficultysettings["explosiveDamageMultiplier"]["veteran"] = 1;
  level.difficultysettings["explosiveDamageMultiplier"]["realism"] = 1;
  level.difficultysettings["MSRSPQNQKP"]["easy"] = 0.15;
  level.difficultysettings["MSRSPQNQKP"]["normal"] = 0.25;
  level.difficultysettings["MSRSPQNQKP"]["hardened"] = 0.25;
  level.difficultysettings["MSRSPQNQKP"]["veteran"] = 0.25;
  level.difficultysettings["MSRSPQNQKP"]["realism"] = 0.25;
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
  level.lastplayersighted = 0;
  updategameskill();
  updatealldifficulty();
}

updatealldifficulty() {
  setglobaldifficulty();

  foreach(var_1 in level.players)
  var_1 setdifficulty();
}

setdifficulty() {
  auto_adjust_data_reset();
  set_difficulty_from_locked_settings();
}

setglobaldifficulty() {
  anim.pain_test = scripts\common\gameskill::get_difficultysetting_global("pain_test");
  level.explosiveplanttime = scripts\common\gameskill::get_difficultysetting_global("explosivePlantTime");
  anim.min_sniper_burst_delay_time = scripts\common\gameskill::get_difficultysetting_global("min_sniper_burst_delay_time");
  anim.max_sniper_burst_delay_time = scripts\common\gameskill::get_difficultysetting_global("max_sniper_burst_delay_time");
  setsaveddvar("MPMOMLLQSP", scripts\common\gameskill::get_difficultysetting_global("accuracyDistScale"));
  level.playermeleedamagemultiplier_dvar = scripts\common\gameskill::get_difficultysetting_global("MSRSPQNQKP");
  setsaveddvar("MSRSPQNQKP", level.playermeleedamagemultiplier_dvar);
  scripts\sp\mgturret::setdifficulty();

  if(scripts\engine\sp\utility::in_realism_mode()) {
    setomnvar("ui_realism_hud", 1);
    setsaveddvar("MSQKLQNNSN", 0);
    setsaveddvar("MTLLLKROOM", 0);
    setsaveddvar("SMMOTOLTR", 0);
  } else {
    setomnvar("ui_realism_hud", 0);
    setsaveddvar("MSQKLQNNSN", 15000);
    setsaveddvar("MTLLLKROOM", 1);
    setsaveddvar("SMMOTOLTR", 1);
  }
}

updategameskill() {
  foreach(var_1 in level.players)
  var_1.gameskill = var_1 scripts\engine\sp\utility::get_player_gameskill();

  level.gameskill = level.player.gameskill;

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

    if(!isDefined(level.lowestgameskill))
      level.lowestgameskill = level.gameskill;

    if(var_0 != updategameskill()) {
      var_0 = level.gameskill;
      level.lowestgameskill = scripts\engine\utility::ter_op(var_0 < level.lowestgameskill, var_0, level.lowestgameskill);
      updatealldifficulty();
    }

    wait 1;
  }
}

apply_difficulty_settings(var_0) {
  self.gs.diedrecentlycooldown = scripts\common\gameskill::get_difficultysetting_frac("player_diedRecentlyCooldown", var_0);
  self.gs.maxflashbangtime = scripts\common\gameskill::get_difficultysetting_frac("player_maxFlashBangTime", var_0);
  self.gs.invultime_ondamage = scripts\common\gameskill::get_difficultysetting_frac("invulTime_onDamage", var_0);
  self.gs.invultime_deathshieldduration = scripts\common\gameskill::get_difficultysetting_frac("invulTime_deathShieldDuration", var_0);
  self.gs.deathsdoorduration = scripts\common\gameskill::get_difficultysetting_frac("player_deathsDoorDuration", var_0);
  self.gs.healthregendelay = scripts\common\gameskill::get_difficultysetting_frac("player_healthRegenDelay", var_0);
  self.gs.healthregenrate = scripts\common\gameskill::get_difficultysetting_frac("player_healthRegenRate", var_0);
  self.gs.healthfireinvulseconds = scripts\common\gameskill::get_difficultysetting_frac("player_fireInvulSeconds", var_0);
  self.gs.healthfireengulfrate = scripts\common\gameskill::get_difficultysetting_frac("player_fireEngulfRate", var_0);
  self.gs.player_attacker_accuracy = scripts\common\gameskill::get_difficultysetting_frac("base_enemy_accuracy", var_0);
  update_player_attacker_accuracy();
  self.gs.playergrenadebasetime = int(scripts\common\gameskill::get_difficultysetting_frac("playerGrenadeBaseTime", var_0));
  self.gs.playergrenaderangetime = int(scripts\common\gameskill::get_difficultysetting_frac("playerGrenadeRangeTime", var_0));
  self.gs.playerdoublegrenadetime = int(scripts\common\gameskill::get_difficultysetting_frac("playerDoubleGrenadeTime", var_0));
  self.gs.min_sniper_burst_delay_time = scripts\common\gameskill::get_difficultysetting_frac("min_sniper_burst_delay_time", var_0);
  self.gs.max_sniper_burst_delay_time = scripts\common\gameskill::get_difficultysetting_frac("max_sniper_burst_delay_time", var_0);
  self.gs.damagemultiplierhealth = self.maxhealth / scripts\common\gameskill::get_difficultysetting_frac("player_health", var_0);
  self.gs.damagemultiplierexplosive = scripts\common\gameskill::get_difficultysetting_frac("explosiveDamageMultiplier", var_0);

  if(scripts\common\utility::playerarmorenabled()) {
    self.gs.armorratiohealthregenthreshold = scripts\common\gameskill::get_difficultysetting_frac("player_armorRatioHealthRegenThreshold", var_0);
    self.gs.armordamagetohealthratiomin = scripts\common\gameskill::get_difficultysetting_frac("player_armorDamageToHealthRatioMin", var_0);
    self.gs.armordamagetohealthratiomax = scripts\common\gameskill::get_difficultysetting_frac("player_armorDamageToHealthRatioMax", var_0);
    self.gs.damagemultiplierarmor = self.armor.maxamount / scripts\common\gameskill::get_difficultysetting_frac("player_armor", var_0);
  }

  scripts\sp\player::updatedamagemultiplier();
  self.threatbias = int(scripts\common\gameskill::get_difficultysetting_frac("threatbias", var_0));
}

set_difficulty_from_locked_settings() {
  apply_difficulty_settings(1);
  scripts\common\gameskill::apply_difficulty_settings_shared(1);
}

resetskill() {
  waittillframeend;
  setskill(1);
}

update_player_attacker_accuracy() {
  if(scripts\engine\utility::ent_flag("player_zero_attacker_accuracy")) {
    return;
  }
  if(!isDefined(self.scriptedignorerandombulletdamage))
    self.scriptedignorerandombulletdamage = 0;

  if(!isDefined(self.scriptedattackeraccuracy))
    self.scriptedattackeraccuracy = 1;

  self.ignorerandombulletdamage = self.scriptedignorerandombulletdamage;
  self.attackeraccuracy = self.gs.player_attacker_accuracy * self.scriptedattackeraccuracy;
}

auto_adjust_init() {
  setdvarifuninitialized("scr_aa_enabled", 1);
  setdvarifuninitialized("scr_aa_debug", 1);

  if(!getdvarint("scr_aa_enabled")) {
    return;
  }
  level.auto_adjust = spawnStruct();
  level.auto_adjust.data = [];
  level.auto_adjust.playerdead = 0;
  level thread auto_adjust_thread();
}

auto_adjust_data_reset() {
  level.auto_adjust.currenttier = 0;
  level.auto_adjust.currentfrac = 0;
  level.auto_adjust.nextsave_buffer = 60000;
  auto_adjust_data_set("lastdied_time", -1);
  auto_adjust_data_set("loadsave_count", 0);
  auto_adjust_data_set("playerdeath_count", 0);
  auto_adjust_data_set("nextsave_time", gettime() + level.auto_adjust.nextsave_buffer);
  auto_adjust_set_table();
}

auto_adjust_set_table() {
  level.auto_adjust.table = [];

  if(level.gameskill == 2) {
    level.auto_adjust.table[0] = 0;
    level.auto_adjust.table[5] = 0.3;
    level.auto_adjust.table[7] = 0.5;
    level.auto_adjust.table[9] = 0.6;
  } else {
    level.auto_adjust.table[0] = 0;
    level.auto_adjust.table[3] = 0.3;
    level.auto_adjust.table[4] = 0.5;
    level.auto_adjust.table[5] = 0.7;
    level.auto_adjust.table[6] = 0.9;
  }
}

auto_adjust_thread() {
  waitframe();
  var_0 = getbuildversion();

  for(;;) {
    if(!level.auto_adjust.playerdead) {
      var_1 = auto_adjust_data_get("playerdeath_count");
      var_2 = var_1;

      foreach(var_5, var_4 in level.auto_adjust.table) {
        if(var_1 >= var_5) {
          var_2 = var_5;
          continue;
        }
      }

      level.player auto_adjust_difficulty(var_2);
    }

    waitframe();
  }
}

can_auto_adjust(var_0) {
  if(!isDefined(level.auto_adjust.table[var_0]))
    return 0;

  if(level.auto_adjust.table[var_0] == level.auto_adjust.currentfrac)
    return 0;

  return 1;
}

auto_adjust_difficulty(var_0) {
  if(!can_auto_adjust(var_0)) {
    return;
  }
  level.auto_adjust.currentfrac = level.auto_adjust.table[var_0];
  self.gs.invultime_ondamage = auto_adjust_lerp_setting("invulTime_onDamage");
  self.gs.invultime_deathshieldduration = auto_adjust_lerp_setting("invulTime_deathShieldDuration");
  self.gs.deathsdoorduration = auto_adjust_lerp_setting("player_deathsDoorDuration");
  self.gs.healthregendelay = auto_adjust_lerp_setting("player_healthRegenDelay");
  self.gs.healthregenrate = auto_adjust_lerp_setting("player_healthRegenRate");
  self.gs.healthfireinvulseconds = auto_adjust_lerp_setting("player_fireInvulSeconds");
  self.gs.healthfireengulfrate = auto_adjust_lerp_setting("player_fireEngulfRate");
  self.gs.damagemultiplierhealth = self.maxhealth / auto_adjust_lerp_setting("player_health");
  self.gs.damagemultiplierexplosive = auto_adjust_lerp_setting("explosiveDamageMultiplier");
  scripts\sp\player::updatedamagemultiplier();
  self.gs.misstimeconstant = auto_adjust_lerp_setting("missTimeConstant");
  self.gs.misstimedistancefactor = auto_adjust_lerp_setting("missTimeDistanceFactor");
}

auto_adjust_lerp_setting(var_0) {
  var_1 = self.gameskill - 1;
  var_2 = scripts\common\gameskill::get_difficultysetting(var_0, var_1);
  var_3 = scripts\common\gameskill::get_difficultysetting(var_0);
  return scripts\engine\math::lerp(var_3, var_2, level.auto_adjust.currentfrac);
}

auto_adjust_data_add(var_0, var_1) {
  var_2 = getdvarint("scr_aa_" + var_0) + var_1;
  auto_adjust_data_set(var_0, var_2);
}

auto_adjust_data_set(var_0, var_1) {
  setDvar("scr_aa_" + var_0, var_1);
}

auto_adjust_data_get(var_0) {
  return getdvarint("scr_aa_" + var_0);
}

auto_adjust_playerdied() {
  if(!isDefined(level.auto_adjust)) {
    return;
  }
  level.auto_adjust.playerdead = 1;
  var_0 = auto_adjust_data_get("playerdeath_count");

  if(var_0 == 7) {
    return;
  }
  auto_adjust_data_add("playerdeath_count", 1);
}

auto_adjust_save_committed() {
  if(!isDefined(level.auto_adjust)) {
    return;
  }
  var_0 = auto_adjust_data_get("playerdeath_count");

  if(var_0 == 0) {
    return;
  }
  var_1 = auto_adjust_data_get("nextsave_time");

  if(gettime() > var_1)
    auto_adjust_data_set("nextsave_time", gettime() + level.auto_adjust.nextsave_buffer);
  else
    return;

  auto_adjust_data_add("playerdeath_count", -1);
}

auto_adjust_difficult_get() {
  return level.gameskill - level.auto_adjust.currentfrac;
}

auto_adjust_debug() {}

auto_adjust_debug_update(var_0, var_1, var_2) {
  if(!isDefined(level.auto_adjust.debughud))
    level.auto_adjust.debughud = [];

  if(!isDefined(level.auto_adjust.debughud[var_0])) {
    var_3 = newhudelem();
    var_3.x = 10;
    var_3.y = 50 + 10 * level.auto_adjust.debugprintline;
    var_3.fontscale = 0.6;
    var_3.label = var_0;
    var_3.font = "smallfixed";
    var_3.horzalign = "fullscreen";
    var_3.vertalign = "fullscreen";
    var_3.value = -999;
    var_3.sort = 20;

    if(isDefined(var_2)) {
      var_3.val2 = newhudelem();
      var_3.val2.x = var_3.x + 120;
      var_3.val2.y = var_3.y;
      var_3.val2.fontscale = 0.6;
      var_3.val2.font = "smallfixed";
      var_3.val2.label = "|";
      var_3.val2.horzalign = "fullscreen";
      var_3.val2.vertalign = "fullscreen";
      var_3.val2.value = -999;
      var_3.val2.sort = 20;
    }

    level.auto_adjust.debughud[var_0] = var_3;
  } else
    var_3 = level.auto_adjust.debughud[var_0];

  if(var_3.value != var_1) {
    var_3 setvalue(var_1);
    var_3.value = var_1;
  }

  if(isDefined(var_2)) {
    if(var_3.val2.value != var_2) {
      var_3.val2 setvalue(var_2);
      var_3.val2.value = var_2;
    }
  }

  level.auto_adjust.debugprintline++;
}

auto_adjust_debuglite() {
  if(isDefined(level.auto_adjust.debughud)) {
    foreach(var_1 in level.auto_adjust.debughud) {
      if(isDefined(var_1.val2))
        var_1.val2 destroy();

      var_1 destroy();
    }

    level.auto_adjust.debughud = undefined;
  }

  if(!isDefined(level.auto_adjust.debuglitehud)) {
    var_1 = newhudelem();
    var_1.alignx = "right";
    var_1.x = 128;
    var_1.y = 5;
    var_1.fontscale = 0.7;
    var_1.font = "default";
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1.sort = 20;
    level.auto_adjust.debuglitehud = var_1;
  }

  var_3 = "^5" + auto_adjust_data_get("playerdeath_count") + "/" + (level.gameskill - level.auto_adjust.currentfrac);
  level.auto_adjust.debuglitehud settext(var_3);
}