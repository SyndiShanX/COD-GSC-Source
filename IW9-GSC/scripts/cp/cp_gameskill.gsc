/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_gameskill.gsc
***********************************************/

init_gameskill() {
  if(!scripts\engine\utility::flag_exist("gameskill_initialized") || !scripts\engine\utility::flag("gameskill_initialized")) {
    if(level.gametype != "cp_survival")
      _id_14609B809484646E::_id_8ECE37593311858A(::_id_80828FAAD46102E9);

    _id_FFEF4CFD9FEC2E5B();

    if(scripts\engine\utility::flag_exist("gameskill_initialized"))
      scripts\engine\utility::flag_set("gameskill_initialized");
  }
}

_id_FFEF4CFD9FEC2E5B() {
  _id_2A43B7184977894C = 0;
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "") {
    _id_1E3125F502DE5E8A = getdvarint("dvar_A77F3B898C0033F5", 5);

    if(isDefined(game["checkpoint_attempts"]) && isDefined(game["checkpoint_attempts"][checkpoint]) && game["checkpoint_attempts"][checkpoint] > _id_1E3125F502DE5E8A)
      _id_2A43B7184977894C = 1;
  }

  if(scripts\cp\utility::_id_138028CA2B958511()) {
    if(_id_F8448FD91ABB54C8()) {
      _id_2A43B7184977894C = 0;
      _id_2B72A5CF9E5597F9(3 - _id_2A43B7184977894C);
    } else
      _id_2B72A5CF9E5597F9(2 - _id_2A43B7184977894C);
  } else
    _id_2B72A5CF9E5597F9(1 - _id_2A43B7184977894C);

  setskill();
  updategameskill();
}

_id_1FC33D9E5389101F() {
  level._id_54D92EC32DC4C49A = 1;
}

_id_3110AD42148690F0() {
  level._id_54D92EC32DC4C49A = undefined;
}

_id_2B72A5CF9E5597F9(value) {
  if(istrue(level._id_54D92EC32DC4C49A)) {
    return;
  }
  level.forcedgameskill = value;
}

_id_80828FAAD46102E9() {
  self.gameskill = 2;
  set_difficulty_from_locked_settings();
}

set_gameskill() {
  if(_id_F8448FD91ABB54C8())
    level.gameskill = getdvarint("dvar_49A51BE00848D9B8", 2);
  else
    level.gameskill = getdvarint("dvar_49A51BE00848D9B8", 1);

  setomnvar("cp_difficulty_level", level.gameskill);
}

get_gameskill() {
  return level.gameskill;
}

setskill(_id_6C667FC52236587A) {
  if(!istrue(_id_6C667FC52236587A)) {
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
  level.difficultysettings["accuracyDistScale"]["hardened"] = 0.1;
  level.difficultysettings["accuracyDistScale"]["veteran"] = 0.1;
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
  level.difficultysettings["armor_damageScale"]["easy"] = 1;
  level.difficultysettings["armor_damageScale"]["normal"] = 1;
  level.difficultysettings["armor_damageScale"]["hardened"] = 1;
  level.difficultysettings["armor_damageScale"]["veteran"] = 1.3;
  level.lastplayersighted = 0;
  level.playermeleedamagemultiplier_dvar = 0.8;
  init_mgturretsettings();
  updategameskill();
  updatealldifficulty();
}

updatealldifficulty() {
  setglobaldifficulty();

  foreach(player in level.players)
  player setdifficulty();
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
  _id_752E478148412F4A = scripts\common\gameskill::get_difficultysetting_global("accuracyDistScale");

  if(isdedicatedserver())
    setsaveddvar("ai_accuracyDistScale", _id_752E478148412F4A);
  else
    setDvar("ai_accuracyDistScale", _id_752E478148412F4A);
}

updategameskill() {
  if(isDefined(level.forcedgameskill))
    level.gameskill = level.forcedgameskill;
  else
    set_gameskill();

  setglobaldifficulty();
  level thread _id_10815A36E4980E14();
  return level.gameskill;
}

_id_10815A36E4980E14() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("debug_attempts_initialized");
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "") {
    if(isDefined(game["checkpoint_attempts"]) && checkpoint != "" && isDefined(game["checkpoint_attempts"][checkpoint]))
      _id_116171939929AF39::_id_E41A5E1DEE804551(level._id_E6997D1DB0CB5E47, game["checkpoint_attempts"][checkpoint]);
  }

  _id_116171939929AF39::_id_E41A5E1DEE804551(level._id_BCA590EA5961E80E, level.gameskill);
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

set_difficulty_from_locked_settings(override) {
  if(isDefined(override)) {
    apply_difficulty_settings(override);
    scripts\common\gameskill::apply_difficulty_settings_shared(override);
  } else {
    apply_difficulty_settings(1);
    scripts\common\gameskill::apply_difficulty_settings_shared(1);
  }
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

  if(isdedicatedserver())
    setsaveddvar("ai_accuracyDistScale", level.difficultysettings["accuracyDistScale"][_id_8C958BDE9A9F8547]);
  else
    setDvar("ai_accuracyDistScale", level.difficultysettings["accuracyDistScale"][_id_8C958BDE9A9F8547]);
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

_id_C3CBEC9961784870(damage) {
  _id_B79930868F410231 = level.difficultysettings["armor_damageScale"][scripts\common\gameskill::get_skill_from_index(level.gameskill)];
  damage = damage * _id_B79930868F410231;
  _id_787585D4E82E1E58 = int(min(self.armorhealth, damage));
  return _id_787585D4E82E1E58;
}

_id_E22F3955AB0D2E8D() {
  return _id_F8448FD91ABB54C8() && istrue(level._id_3A0F2224B2310445);
}

_id_F8448FD91ABB54C8() {
  if(!scripts\cp\utility::_id_138028CA2B958511())
    return 0;

  if(!isDefined(level._id_DF73B19D71E8BC58))
    level._id_DF73B19D71E8BC58 = getdvarint("dvar_4ADAF899568A9E92", 0);

  return level._id_DF73B19D71E8BC58;
}

_id_31B2BF3FE796B1B2() {
  if(!_id_F8448FD91ABB54C8() || !scripts\cp\utility::_id_138028CA2B958511()) {
    return;
  }
  level._id_E8F60267621FDA8D = ::_id_C3CBEC9961784870;
  _id_D160A5B092271ADA();
  level thread _id_CBD65FA4A48CC872();
  level thread _id_0AFB7E332AEE4BF2::_id_2767AAACD3DFC97A();
}

_id_D160A5B092271ADA() {
  level.forced_aitype_armored = 1;
  _id_18A73A64992DD07D::add_global_spawn_function("axis", ::_id_CFC318CBB1F61AF1);
}

_id_AAABB684E4369086() {
  level.forced_aitype_armored = undefined;
  _id_18A73A64992DD07D::remove_global_spawn_function("axis", ::_id_CFC318CBB1F61AF1);
}

_id_CFC318CBB1F61AF1() {
  if(_id_18A73A64992DD07D::is_juggernaut_aitype()) {
    return;
  }
  tier = "tier1";
  aitype = self.aitype;

  if(issubstr(aitype, "_t1_")) {
    tier = "tier2";

    if(isDefined(self.headmodel))
      self detach(self.headmodel);

    self attach("head_sp_opforce_al_qatala_tier_2_1_1", "", 1);
    self.headmodel = "head_sp_opforce_al_qatala_tier_2_1_1";
    _id_371B4C2AB5861E62::_id_DC016A9146E5FBD5(self);
  } else if(issubstr(aitype, "_t2_")) {
    tier = "tier3";

    if(isDefined(self.headmodel))
      self detach(self.headmodel);

    self attach("head_sp_opforce_al_qatala_tier_3_1", "", 1);
    self.headmodel = "head_sp_opforce_al_qatala_tier_3_1";
    _id_371B4C2AB5861E62::_id_DC01699146E5F9A2(self);
  } else if(issubstr(aitype, "_t3_")) {
    tier = "tier3";

    if(isDefined(self.headmodel))
      self detach(self.headmodel);

    self attach("head_sp_opforce_al_qatala_tier_3_1", "", 1);
    self.headmodel = "head_sp_opforce_al_qatala_tier_3_1";
    _id_371B4C2AB5861E62::_id_DC01699146E5F9A2(self);
  }
}

_id_3898E5F82C5C37DF(_id_5220029D5E272DC8, _id_32A62A6C0B501CBE) {
  if(istrue(_id_5220029D5E272DC8)) {
    _id_1F2A9DD7318BB8F9 = 98;
    level._id_CBA4F601411EDEF5 = 1;

    if(!isDefined(level._id_C53B399B59B83A64))
      level._id_C53B399B59B83A64 = getdvarint("dvar_BA489EED001F6CAD", 540);

    _id_D32605EB65369628 = level._id_C53B399B59B83A64;

    if(!istrue(level._id_77F52E0CCB8547EB)) {
      setomnvar("cp_objective_sub_4_index", _id_1F2A9DD7318BB8F9);
      setomnvar("cp_countdown_timer_alpha", 4);
      setomnvar("cp_countdown_timer", level._id_C53B399B59B83A64 * 1000);
    }
  } else {
    _id_1F2A9DD7318BB8F9 = scripts\engine\utility::ter_op(isDefined(_id_32A62A6C0B501CBE), _id_32A62A6C0B501CBE, 99);
    level._id_CBA4F601411EDEF5 = 0;

    if(!isDefined(level._id_F63478BCA59E2670))
      level._id_F63478BCA59E2670 = getdvarint("dvar_AAE8E9A472853241", 3);

    if(!isDefined(level._id_A80E6D45222F9A47))
      level._id_A80E6D45222F9A47 = level._id_F63478BCA59E2670;

    _id_D32605EB65369628 = level._id_A80E6D45222F9A47;

    if(!istrue(level._id_77F52E0CCB8547EB)) {
      setomnvar("cp_objective_sub_4_index", _id_1F2A9DD7318BB8F9);
      setomnvar("cp_objective_sub_count_4", int(_id_D32605EB65369628));
    }
  }
}

_id_E63A845C77F9AA8A() {
  level endon("game_ended");
  level endon("stop_party_wipe_monitor");
  level._id_DCEF748352FC962D = 1;

  for(;;) {
    if(istrue(level._id_1BA46ECF09B8E08C)) {
      wait 1;
      continue;
    }

    _id_FC40A742A65A2DC5 = 0;

    foreach(player in level.players) {
      if(isDefined(player.dogtag))
        _id_FC40A742A65A2DC5++;
    }

    if(_id_FC40A742A65A2DC5 > 0) {
      if(!istrue(level._id_77F52E0CCB8547EB))
        thread _id_6C3415FC06B0DB95(&"COOP_GAME_PLAY/SINGLE_DEATH_WIPE_TIME_STARTED", &"COOP_GAME_PLAY/SINGLE_DEATH_WIPE_SQUAD", 90);
    } else if(istrue(level._id_77F52E0CCB8547EB) && !istrue(level._id_C7A0EAF3BC52A259)) {
      if(_id_F8448FD91ABB54C8()) {
        thread _id_06660798718EE459(0);
        _id_D32605EB65369628 = level._id_A80E6D45222F9A47;
        setomnvar("cp_objective_sub_count_4", int(_id_D32605EB65369628));
      } else
        thread _id_06660798718EE459(1);
    }

    wait 1;
  }
}

_id_CBD65FA4A48CC872() {
  level endon("game_ended");
  level endon("stop_party_wipe_monitor");

  for(;;) {
    if(istrue(level._id_1BA46ECF09B8E08C) || !isDefined(level._id_A80E6D45222F9A47)) {
      wait 1;
      continue;
    }

    _id_FC40A742A65A2DC5 = 0;

    foreach(player in level.players) {
      if(!_id_DC6FD5E481FA370A(player))
        _id_FC40A742A65A2DC5++;
    }

    if(istrue(level._id_5C966A6569A6F4B5)) {
      if(istrue(level._id_EC0BAA43406DE34A) && !istrue(level._id_77F52E0CCB8547EB))
        thread _id_6C3415FC06B0DB95(&"COOP_GAME_PLAY/HARDMODE_OXYMASK_DEPLETED", &"COOP_GAME_PLAY/HARDMODE_OXYMASK_GAMEOVER");
    } else if(level._id_A80E6D45222F9A47 > 0) {
      if(istrue(level._id_77F52E0CCB8547EB)) {
        if(istrue(_id_FC40A742A65A2DC5 <= 0))
          _id_06660798718EE459();
      }
    } else if(_id_FC40A742A65A2DC5 > 0 && level._id_A80E6D45222F9A47 <= 0) {
      if(!istrue(level._id_C7A0EAF3BC52A259)) {
        level notify("single_party_wipe_timer");
        level._id_C7A0EAF3BC52A259 = 1;
      }

      if(!istrue(level._id_77F52E0CCB8547EB))
        thread _id_6C3415FC06B0DB95();
    }

    wait 1;
  }
}

_id_6C3415FC06B0DB95(_id_8834C3090C1D10B3, _id_5A67C9D0186C1589, timer_override) {
  level endon("game_ended");
  level endon("hardmode_stop_party_wipe_timer");
  level notify("single_party_wipe_timer");
  level endon("single_party_wipe_timer");

  if(!isDefined(timer_override))
    _id_2CDACD5098D286D3 = 20;
  else
    _id_2CDACD5098D286D3 = timer_override;

  if(istrue(level._id_77F52E0CCB8547EB)) {
    return;
  }
  level._id_77F52E0CCB8547EB = 1;
  level notify("hardModeWipeTimerActive");
  waitframe();

  if(!isDefined(_id_8834C3090C1D10B3))
    _id_8834C3090C1D10B3 = &"COOP_GAME_PLAY/HARDMODE_WIPE_TIME_STARTED";

  if(!isDefined(_id_5A67C9D0186C1589))
    _id_5A67C9D0186C1589 = &"COOP_GAME_PLAY/HARDMODE_WIPE_INFO";

  level._id_88FD0DA9196867BD = getomnvar("cp_countdown_timer_alpha");
  level._id_A212C5B82814375A = getomnvar("cp_countdown_timer");
  level._id_24BE3AA5D7BF4883 = gettime();
  setomnvar("cp_countdown_timer_alpha", 5);
  setomnvar("cp_countdown_timer", gettime() + _id_2CDACD5098D286D3 * 1000);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(_id_8834C3090C1D10B3, "allies", 10);
  _id_EA6AE587890F64DD = gettime() + _id_2CDACD5098D286D3 * 1000;

  while(gettime() < _id_EA6AE587890F64DD)
    wait 1;

  scripts\cp\cp_hud_message::teamhudtutorialmessage(_id_5A67C9D0186C1589, "allies", 4);
  wait 3;
  level notify("stop_party_wipe_monitor");
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

_id_06660798718EE459(_id_1395F8A358756E37) {
  level._id_77F52E0CCB8547EB = 0;
  level._id_C7A0EAF3BC52A259 = 0;
  level notify("hardmode_stop_party_wipe_timer");
  level._id_CA6BF37F89442C78 = 1;

  if(!istrue(_id_1395F8A358756E37))
    _id_3898E5F82C5C37DF(istrue(level._id_CBA4F601411EDEF5));

  wait 1;

  if(isDefined(level._id_88FD0DA9196867BD)) {
    setomnvar("cp_countdown_timer_alpha", level._id_88FD0DA9196867BD);
    level._id_88FD0DA9196867BD = undefined;

    if(isDefined(level._id_A212C5B82814375A)) {
      setomnvar("cp_countdown_timer", level._id_A212C5B82814375A);
      level._id_A212C5B82814375A = undefined;
    }
  } else
    setomnvar("cp_countdown_timer_alpha", 0);

  level._id_CA6BF37F89442C78 = undefined;
}

_id_DC6FD5E481FA370A(player) {
  return isalive(player) && !istrue(player.inlaststand) || istrue(player.respawn_in_progress);
}

_id_0127B010126B6A90() {
  level._id_1BA46ECF09B8E08C = 1;
}

_id_77E524F19EB4608F() {
  level._id_1BA46ECF09B8E08C = undefined;
}