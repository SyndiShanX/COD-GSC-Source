/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\playerhealth.gsc
***********************************************/

#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\cp_mp\playerhealth;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\equipment\adrenaline;
#using scripts\mp\equipment\battlerage;
#using scripts\mp\supers\laststand_heal;
#using scripts\mp\tweakables;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#namespace playerhealth;

function init() {
  healthregendelay = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_healthregentime"), @ "scr_player_healthregentime");
  scripts\mp\tweakables::settweakablevalue("player", "healthregentime", healthregendelay);
  scripts\mp\tweakables::settweakablelastvalue("player", "healthregentime", healthregendelay);
  level.healthregendelay = scripts\mp\tweakables::gettweakablevalue("player", "healthregentime");
  level.healthregendisabled = level.healthregendelay <= 0;
  level.playerhealth_regularregendelay = level.healthregendelay;
  level.var_562530bdb8e83b66 = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_deathsDoorEnterPct"), @ "hash_e4f93d764d11874d");
  level.var_fdd1af3c4c6cbe86 = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_deathsDoorExitPct"), @ "hash_b84edc242cc61abf");

  if(!isDefined(level.var_be39d6b46044f344)) {
    level.var_be39d6b46044f344 = 40;
  }

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
}

function onplayerspawned() {
  thread scripts\cp_mp\playerhealth::manageplayerregen();
  self visionsetthermalforplayer(game["thermal_vision"]);
  scripts\common\damage_effects::function_9bc46d4b8891a740();
}

function onfullhealth(starthealth, var_823ca369fafd4a36, var_7f86cf029bef696d) {
  amounthealed = self.health - starthealth;

  if(var_7f86cf029bef696d) {
    scripts\mp\damage::combatrecordtacticalstat("equip_adrenaline", amounthealed);
    scripts\mp\utility\stats::incpersstat("stimDamageHealed", amounthealed);
    scripts\mp\analyticslog::logevent_playerhealed(self, amounthealed, self);
  } else if(!isai(self)) {
    scripts\mp\analyticslog::logevent_playerregen(self, amounthealed);
  }

  if(isDefined(self.pers["damageHealed"])) {
    amounthealed = self.health - starthealth;
    scripts\mp\utility\stats::incpersstat("damageHealed", amounthealed);
  }

  if(var_823ca369fafd4a36) {
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_status_player_recover");
  }
}

function getgametypehealthperframe() {
  if(function_244067e915c0eabe()) {
    var_881fb15f4d296741 = level.playermaxhealth / 150;
  } else {
    var_881fb15f4d296741 = 1;
  }

  healthperframe = level.var_be39d6b46044f344 * 0.05 * var_881fb15f4d296741;

  if(getdvarint(@ "scr_override_health_regen_per_sec", 0) > 0) {
    var_fbb0e274527f2097 = getdvarint(@ "scr_override_health_regen_per_sec", 0);
    healthperframe = var_fbb0e274527f2097 * 0.05 * var_881fb15f4d296741;
  }

  if(istrue(self.var_808d06ddfc93a4e4) && getdvarint(@ "hash_dc1416e8c8672f24", 0)) {
    var_194458c6687c5a07 = scripts\mp\equipment\battlerage::function_7fa9c564c245f4e3() * 0.05 * var_881fb15f4d296741;
    healthperframe = max(var_194458c6687c5a07, healthperframe);
  }

  if(istrue(self.adrenalinepoweractive)) {
    var_194458c6687c5a07 = scripts\mp\equipment\adrenaline::gethealthpersec() * 0.05 * var_881fb15f4d296741;
    healthperframe = max(var_194458c6687c5a07, healthperframe);
  } else if(istrue(self.laststandhealisactive)) {
    var_194458c6687c5a07 = scripts\mp\supers\laststand_heal::laststandheal_gethealthperframe();
    healthperframe = max(var_194458c6687c5a07, healthperframe);
  } else if(_hasperk("specialty_regenfaster")) {
    healthperframe *= level.regenfasterhealthmod;
  }

  if(isDefined(level.regenhealthaddfunc)) {
    healthperframe = [[level.regenhealthaddfunc]](healthperframe);
  }

  return healthperframe;
}