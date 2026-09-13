/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_53da3333b83b3527.gsc
***********************************************/

init_gameskill() {
  setskill();
}

set_gameskill() {
  level.gameskill = getdvarint("dvar_2CA7440FD32BD772", 1);
}

get_gameskill() {
  return level.gameskill;
}

setskill(reset) {
  if(!istrue(reset)) {
    if(isDefined(level.gameskill)) {
      return;
    }
    level.difficultytype[0] = "easy";
    level.difficultytype[1] = "normal";
    level.difficultytype[2] = "hardened";
    level.difficultytype[3] = "veteran";
    level.difficultystring["easy"] = &"GAMESKILL_EASY";
    level.difficultystring["normal"] = &"GAMESKILL_NORMAL";
    level.difficultystring["hardened"] = &"GAMESKILL_HARDENED";
    level.difficultystring["veteran"] = &"GAMESKILL_VETERAN";
  }

  anim.run_accuracy = 0.5;
  anim.walk_accuracy = 0.8;
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
  level.difficultysettings["playerDoubleGrenadeTime"]["veteran"] = 45000;
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
  level.difficultysettings["base_enemy_accuracy"]["veteran"] = 1.5;
  level.difficultysettings["accuracyDistScale"]["easy"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["normal"] = 1.0;
  level.difficultysettings["accuracyDistScale"]["hardened"] = 0.8;
  level.difficultysettings["accuracyDistScale"]["veteran"] = 0.5;
  level.difficultysettings["min_sniper_burst_delay_time"]["easy"] = 3.0;
  level.difficultysettings["min_sniper_burst_delay_time"]["normal"] = 2.0;
  level.difficultysettings["min_sniper_burst_delay_time"]["hardened"] = 1.5;
  level.difficultysettings["min_sniper_burst_delay_time"]["veteran"] = 0.75;
  level.difficultysettings["sniper_converge_scale"]["easy"] = 1.3;
  level.difficultysettings["sniper_converge_scale"]["normal"] = 1.1;
  level.difficultysettings["sniper_converge_scale"]["hardened"] = 0.9;
  level.difficultysettings["sniper_converge_scale"]["veteran"] = 0.45;
  level.difficultysettings["sniperAccuDiffScale"]["easy"] = 1.0;
  level.difficultysettings["sniperAccuDiffScale"]["normal"] = 1.6;
  level.difficultysettings["sniperAccuDiffScale"]["hardened"] = 1.6;
  level.difficultysettings["sniperAccuDiffScale"]["veteran"] = 2.5;
  level.difficultysettings["max_sniper_burst_delay_time"]["easy"] = 4.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["normal"] = 3.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["hardened"] = 2.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["veteran"] = 1.1;
  level.difficultysettings["pain_test"]["easy"] = scripts\common\gameskill::always_pain;
  level.difficultysettings["pain_test"]["normal"] = scripts\common\gameskill::always_pain;
  level.difficultysettings["pain_test"]["hardened"] = scripts\common\gameskill::pain_protection;
  level.difficultysettings["pain_test"]["veteran"] = scripts\common\gameskill::pain_protection;
  level.difficultysettings["missTimeConstant"]["easy"] = 1.0;
  level.difficultysettings["missTimeConstant"]["normal"] = 0.05;
  level.difficultysettings["missTimeConstant"]["hardened"] = 0.03;
  level.difficultysettings["missTimeConstant"]["veteran"] = 0.02;
  level.difficultysettings["missTimeDistanceFactor"]["easy"] = 0.0008;
  level.difficultysettings["missTimeDistanceFactor"]["normal"] = 0.0001;
  level.difficultysettings["missTimeDistanceFactor"]["hardened"] = 0.00005;
  level.difficultysettings["missTimeDistanceFactor"]["veteran"] = 0.00003;
  level.difficultysettings["player_maxFlashBangTime"]["easy"] = 6;
  level.difficultysettings["player_maxFlashBangTime"]["normal"] = 8;
  level.difficultysettings["player_maxFlashBangTime"]["hardened"] = 9;
  level.difficultysettings["player_maxFlashBangTime"]["veteran"] = 10;
  level.difficultysettings["invulTime_onDamageMin"]["easy"] = 0.35;
  level.difficultysettings["invulTime_onDamageMin"]["normal"] = 0.3;
  level.difficultysettings["invulTime_onDamageMin"]["hardened"] = 0.2;
  level.difficultysettings["invulTime_onDamageMin"]["veteran"] = 0.2;
  level.difficultysettings["invulTime_onDamageMax"]["easy"] = 0.35;
  level.difficultysettings["invulTime_onDamageMax"]["normal"] = 0.3;
  level.difficultysettings["invulTime_onDamageMax"]["hardened"] = 0.2;
  level.difficultysettings["invulTime_onDamageMax"]["veteran"] = 0.2;
  level.difficultysettings["invulTime_onDamage"]["easy"] = 0.35;
  level.difficultysettings["invulTime_onDamage"]["normal"] = 0.3;
  level.difficultysettings["invulTime_onDamage"]["hardened"] = 0.2;
  level.difficultysettings["invulTime_onDamage"]["veteran"] = 0.2;
  level.difficultysettings["invulTime_deathShieldDuration"]["easy"] = 2.0;
  level.difficultysettings["invulTime_deathShieldDuration"]["normal"] = 1.0;
  level.difficultysettings["invulTime_deathShieldDuration"]["hardened"] = 0.5;
  level.difficultysettings["invulTime_deathShieldDuration"]["veteran"] = 0.25;
  level.difficultysettings["player_deathsDoorDuration"]["easy"] = 4.0;
  level.difficultysettings["player_deathsDoorDuration"]["normal"] = 4.0;
  level.difficultysettings["player_deathsDoorDuration"]["hardened"] = 4.0;
  level.difficultysettings["player_deathsDoorDuration"]["veteran"] = 4.0;
  level.difficultysettings["player_healthRegenDelayMin"]["easy"] = 2.1;
  level.difficultysettings["player_healthRegenDelayMin"]["normal"] = 1.85;
  level.difficultysettings["player_healthRegenDelayMin"]["hardened"] = 2.7;
  level.difficultysettings["player_healthRegenDelayMin"]["veteran"] = 3.25;
  level.difficultysettings["player_healthRegenDelayMax"]["easy"] = 4.35;
  level.difficultysettings["player_healthRegenDelayMax"]["normal"] = 5.0;
  level.difficultysettings["player_healthRegenDelayMax"]["hardened"] = 6.0;
  level.difficultysettings["player_healthRegenDelayMax"]["veteran"] = 7.05;
  level.difficultysettings["player_healthRegenDelay"]["easy"] = 2.5;
  level.difficultysettings["player_healthRegenDelay"]["normal"] = 3.0;
  level.difficultysettings["player_healthRegenDelay"]["hardened"] = 4.0;
  level.difficultysettings["player_healthRegenDelay"]["veteran"] = 5.05;
  level.difficultysettings["player_healthRegenRateMin"]["easy"] = 1.25;
  level.difficultysettings["player_healthRegenRateMin"]["normal"] = 0.65;
  level.difficultysettings["player_healthRegenRateMin"]["hardened"] = 0.25;
  level.difficultysettings["player_healthRegenRateMin"]["veteran"] = 0.05;
  level.difficultysettings["player_healthRegenRateMax"]["easy"] = 18.85;
  level.difficultysettings["player_healthRegenRateMax"]["normal"] = 14.65;
  level.difficultysettings["player_healthRegenRateMax"]["hardened"] = 10.55;
  level.difficultysettings["player_healthRegenRateMax"]["veteran"] = 9.2;
  level.difficultysettings["player_healthRegenRate"]["easy"] = 40;
  level.difficultysettings["player_healthRegenRate"]["normal"] = 40;
  level.difficultysettings["player_healthRegenRate"]["hardened"] = 40;
  level.difficultysettings["player_healthRegenRate"]["veteran"] = 40;
  level.difficultysettings["player_health"]["easy"] = 355;
  level.difficultysettings["player_health"]["normal"] = 180;
  level.difficultysettings["player_health"]["hardened"] = 140;
  level.difficultysettings["player_health"]["veteran"] = 80;
  level.difficultysettings["player_diedRecentlyCooldown"]["easy"] = 70;
  level.difficultysettings["player_diedRecentlyCooldown"]["normal"] = 30;
  level.difficultysettings["player_diedRecentlyCooldown"]["hardened"] = 0;
  level.difficultysettings["player_diedRecentlyCooldown"]["veteran"] = 0;
  level.lastplayersighted = 0;
  level.playermeleedamagemultiplier_dvar = 0.8;
  init_mgturretsettings();
  updategameskill();
  updatealldifficulty();
}

updatealldifficulty() {
  setglobaldifficulty();
}

init_mgturretsettings() {
  level.mgturretsettings["easy"]["convergenceTime"] = 2.5;
  level.mgturretsettings["easy"]["suppressionTime"] = 3.0;
  level.mgturretsettings["easy"]["accuracy"] = 0.38;
  level.mgturretsettings["easy"]["aiSpread"] = 2;
  level.mgturretsettings["easy"]["playerSpread"] = 0.5;
  level.mgturretsettings["medium"]["convergenceTime"] = 1.5;
  level.mgturretsettings["medium"]["suppressionTime"] = 3.0;
  level.mgturretsettings["medium"]["accuracy"] = 0.38;
  level.mgturretsettings["medium"]["aiSpread"] = 2;
  level.mgturretsettings["medium"]["playerSpread"] = 0.5;
  level.mgturretsettings["hard"]["convergenceTime"] = 0.8;
  level.mgturretsettings["hard"]["suppressionTime"] = 3.0;
  level.mgturretsettings["hard"]["accuracy"] = 0.38;
  level.mgturretsettings["hard"]["aiSpread"] = 2;
  level.mgturretsettings["hard"]["playerSpread"] = 0.5;
  level.mgturretsettings["veteran"]["convergenceTime"] = 0.8;
  level.mgturretsettings["veteran"]["suppressionTime"] = 3.0;
  level.mgturretsettings["veteran"]["accuracy"] = 0.38;
  level.mgturretsettings["veteran"]["aiSpread"] = 2;
  level.mgturretsettings["veteran"]["playerSpread"] = 0.5;
  level.mgturretsettings["fu"]["convergenceTime"] = 0.4;
  level.mgturretsettings["fu"]["suppressionTime"] = 3.0;
  level.mgturretsettings["fu"]["accuracy"] = 0.38;
  level.mgturretsettings["fu"]["aiSpread"] = 2;
  level.mgturretsettings["fu"]["playerSpread"] = 0.5;
}

setdifficulty() {
  set_difficulty_from_locked_settings();
}

setglobaldifficulty() {
  _id_CDDDA98C04947A50 = scripts\common\gameskill::get_skill_from_index(level.gameskill);
  anim.pain_test = scripts\common\gameskill::get_difficultysetting_global("pain_test");
  _func_4AFDEFC72472A638(scripts\common\gameskill::get_difficultysetting_global("min_sniper_burst_delay_time"));
  _func_5EDDC94E0785D7A2(scripts\common\gameskill::get_difficultysetting_global("max_sniper_burst_delay_time"));
  setsaveddvar("ai_accuracyDistScale", scripts\common\gameskill::get_difficultysetting_global("accuracyDistScale"));
}

updategameskill() {
  if(isDefined(level.forcedgameskill))
    level.gameskill = level.forcedgameskill;
  else
    set_gameskill();

  setglobaldifficulty();
  return level.gameskill;
}

apply_difficulty_settings(_id_64E5D13011016A93) {
  self.gs = spawnStruct();
  _func_2A781949ACE88CA4(scripts\common\gameskill::get_difficultysetting_frac("player_diedRecentlyCooldown", _id_64E5D13011016A93));
  self.gs.maxflashbangtime = scripts\common\gameskill::get_difficultysetting_frac("player_maxFlashBangTime", _id_64E5D13011016A93);
  self.gs.invultime_ondamagemin = scripts\common\gameskill::get_difficultysetting_frac("invulTime_onDamageMin", _id_64E5D13011016A93);
  self.gs.invultime_ondamagemax = scripts\common\gameskill::get_difficultysetting_frac("invulTime_onDamageMax", _id_64E5D13011016A93);
  self.gs.invultime_deathshieldduration = scripts\common\gameskill::get_difficultysetting_frac("invulTime_deathShieldDuration", _id_64E5D13011016A93);
  self.gs.invultime_ondamage = scripts\common\gameskill::get_difficultysetting_frac("invulTime_onDamage", _id_64E5D13011016A93);
  self.gs.deathsdoorduration = scripts\common\gameskill::get_difficultysetting_frac("player_deathsDoorDuration", _id_64E5D13011016A93);
  self.gs.scripteddamagemultiplier = 1;
  self.gs.scripteddeathshielddurationscale = 2;
  self.gs.healthregendelaymin = scripts\common\gameskill::get_difficultysetting_frac("player_healthRegenDelayMin", _id_64E5D13011016A93);
  self.gs.healthregendelaymax = scripts\common\gameskill::get_difficultysetting_frac("player_healthRegenDelayMax", _id_64E5D13011016A93);
  self.gs.healthregendelay = scripts\common\gameskill::get_difficultysetting_frac("player_healthRegenDelay", _id_64E5D13011016A93);
  self.gs.healthregenratemin = scripts\common\gameskill::get_difficultysetting_frac("player_healthRegenRateMin", _id_64E5D13011016A93);
  self.gs.healthregenratemax = scripts\common\gameskill::get_difficultysetting_frac("player_healthRegenRateMax", _id_64E5D13011016A93);
  self.gs.healthregendelay = scripts\common\gameskill::get_difficultysetting_frac("player_healthRegenDelay", _id_64E5D13011016A93);
  self.gs.healthregenrate = scripts\common\gameskill::get_difficultysetting_frac("player_healthRegenRate", _id_64E5D13011016A93);
  self.gs.player_attacker_accuracy = scripts\common\gameskill::get_difficultysetting_frac("base_enemy_accuracy", _id_64E5D13011016A93);
  update_player_attacker_accuracy();
  self.gs.playergrenadebasetime = int(scripts\common\gameskill::get_difficultysetting_frac("playerGrenadeBaseTime", _id_64E5D13011016A93));
  self.gs.playergrenaderangetime = int(scripts\common\gameskill::get_difficultysetting_frac("playerGrenadeRangeTime", _id_64E5D13011016A93));
  self.gs.playerdoublegrenadetime = int(scripts\common\gameskill::get_difficultysetting_frac("playerDoubleGrenadeTime", _id_64E5D13011016A93));
  _func_113DC070D175DAFF(scripts\common\gameskill::get_difficultysetting_frac("min_sniper_burst_delay_time", _id_64E5D13011016A93));
  _func_87E4FF0E078152E9(scripts\common\gameskill::get_difficultysetting_frac("max_sniper_burst_delay_time", _id_64E5D13011016A93));
  _id_04CC77AE3C5E8921 = 1;

  if(level.gameskill == 0)
    _id_04CC77AE3C5E8921 = 2;

  _func_90FAF3F11984372A(scripts\common\gameskill::get_difficultysetting_frac("sniperAccuDiffScale", _id_64E5D13011016A93), _id_04CC77AE3C5E8921, 1);
  self.gs.damagemultiplierhealth = self.maxhealth / scripts\common\gameskill::get_difficultysetting_frac("player_health", _id_64E5D13011016A93);

  if(scripts\common\utility::playerarmorenabled()) {
    self.gs.armorratiohealthregenthreshold = scripts\common\gameskill::get_difficultysetting_frac("player_armorRatioHealthRegenThreshold", _id_64E5D13011016A93);
    self.gs.armordamagetohealthratiomin = scripts\common\gameskill::get_difficultysetting_frac("player_armorDamageToHealthRatioMin", _id_64E5D13011016A93);
    self.gs.armordamagetohealthratiomax = scripts\common\gameskill::get_difficultysetting_frac("player_armorDamageToHealthRatioMax", _id_64E5D13011016A93);
    self.gs.damagemultiplierarmor = self.armor.maxamount / scripts\common\gameskill::get_difficultysetting_frac("player_armor", _id_64E5D13011016A93);
    self.damagemultiplier = self.gs.damagemultiplierarmor;
  } else
    self.damagemultiplier = self.gs.damagemultiplierhealth;

  self.threatbias = int(scripts\common\gameskill::get_difficultysetting_frac("threatbias", _id_64E5D13011016A93));
}

set_difficulty_from_locked_settings() {
  apply_difficulty_settings(1);
  scripts\common\gameskill::apply_difficulty_settings_shared(1);
}

resetskill() {
  waittillframeend;
  setskill(1);
}

wave_difficulty_update(difficulty) {
  if(getdvarint("dvar_94EBDB2E64164D03", -1) != -1)
    difficulty = getdvarint("dvar_94EBDB2E64164D03", -1);

  _id_8C958BDE9A9F8547 = level.difficultytype[difficulty];

  foreach(player in level.players) {
    player.gs.player_attacker_accuracy = level.difficultysettings["base_enemy_accuracy"][_id_8C958BDE9A9F8547];
    player.attackeraccuracy = player.gs.player_attacker_accuracy;
    player.gs.playergrenadebasetime = int(level.difficultysettings["playerGrenadeBaseTime"][_id_8C958BDE9A9F8547]);
    player.gs.playergrenaderangetime = int(level.difficultysettings["playerGrenadeRangeTime"][_id_8C958BDE9A9F8547]);
    player.gs.playerdoublegrenadetime = int(level.difficultysettings["playerDoubleGrenadeTime"][_id_8C958BDE9A9F8547]);
    player._id_DA4B6392C1BEC6A1 = level.difficultysettings["missTimeConstant"][_id_8C958BDE9A9F8547];
    player._id_CEF700ED012E8981 = level.difficultysettings["missTimeDistanceFactor"][_id_8C958BDE9A9F8547];
  }

  _func_38AE83992C7EB8A5(level.difficultysettings["double_grenades_allowed"][_id_8C958BDE9A9F8547]);
  anim.pain_test = level.difficultysettings["pain_test"][_id_8C958BDE9A9F8547];
  _func_4AFDEFC72472A638(level.difficultysettings["min_sniper_burst_delay_time"][_id_8C958BDE9A9F8547]);
  _func_5EDDC94E0785D7A2(level.difficultysettings["max_sniper_burst_delay_time"][_id_8C958BDE9A9F8547]);
  _func_113DC070D175DAFF(level.difficultysettings["min_sniper_burst_delay_time"][_id_8C958BDE9A9F8547]);
  _func_87E4FF0E078152E9(level.difficultysettings["max_sniper_burst_delay_time"][_id_8C958BDE9A9F8547]);
  setsaveddvar("ai_accuracyDistScale", level.difficultysettings["accuracyDistScale"][_id_8C958BDE9A9F8547]);
}

update_player_attacker_accuracy() {
  if(!isDefined(self.baseignorerandombulletdamage))
    self.baseignorerandombulletdamage = 0;

  if(!isDefined(self.scriptedattackeraccuracy))
    self.scriptedattackeraccuracy = 1;

  self.ignorerandombulletdamage = self.baseignorerandombulletdamage;
  self.attackeraccuracy = self.gs.player_attacker_accuracy * self.scriptedattackeraccuracy;
}

get_player_gameskill() {
  return level.gameskill;
}