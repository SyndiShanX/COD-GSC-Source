/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\gameskill.gsc
***********************************************/

#using scripts\anim\utility_common;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace gameskill;

function get_skill_from_index(index) {
  if(utility::issp() || utility::iscp()) {
    index += 1;
  }

  return level.difficultytype[index];
}

function apply_difficulty_settings_shared(current_frac) {
  assert(isPlayer(self));
  self.var_da4b6392c1bec6a1 = get_difficultysetting_frac("missTimeConstant", current_frac);
  self.var_cef700ed012e8981 = get_difficultysetting_frac("missTimeDistanceFactor", current_frac);
  function_38ae83992c7eb8a5(get_difficultysetting("double_grenades_allowed"));
}

function get_difficultysetting_frac(setting, frac) {
  return get_difficultysetting(setting) * frac;
}

function get_difficultysetting(setting, gameskill) {
  if(!isDefined(gameskill)) {
    gameskill = self.gameskill;
  }

  return level.difficultysettings[setting][get_skill_from_index(gameskill)];
}

function get_difficultysetting_global(setting) {
  return level.difficultysettings[setting][get_skill_from_index(level.gameskill)];
}

function always_pain() {
  return false;
}

function pain_protection() {
  if(!pain_protection_check()) {
    return false;
  }

  return randomint(100) > 25;
}

function pain_protection_check() {
  if(!isalive(self.enemy)) {
    return false;
  }

  if(!isPlayer(self.enemy)) {
    return false;
  }

  if(!isalive(level.painai) || level.painai.script != "pain") {
    level.painai = self;
  }

  if(self == level.painai) {
    return false;
  }

  objweapon = self.damageweapon;

  if(!isnullweapon(objweapon) && objweapon.isbolt) {
    return false;
  }

  return true;
}

function set_accuracy_based_on_situation() {
  if(self function_e8ca4080d02a0bb4() && isalive(self.enemy)) {
    self function_73ef2fe03a776cd7();
    return;
  }

  if(isPlayer(self.enemy)) {
    resetmissdebouncetime();

    if(self.misstime > gettime()) {
      self.accuracy = 0;
      return;
    }
  }

  self.accuracy = self.baseaccuracy;

  if(isDefined(self.isrambo) && isDefined(self.ramboaccuracymult)) {
    self.accuracy *= self.ramboaccuracymult;
  }
}

function didsomethingotherthanshooting() {
  self.misstimedebounce = 0;
}

function resetmissdebouncetime() {
  self.misstimedebounce = gettime() + 3000;
}

function default_door_node_flashbang_frequency() {
  if(self.team == "allies") {
    self.doorflashchance = 0.6;
  }

  if(self isbadguy()) {
    if(level.gameskill >= 2) {
      self.doorflashchance = 0.8;
      return;
    }

    self.doorflashchance = 0.6;
  }
}

function grenadeawareness() {
  if(self.team == "allies") {
    self.grenadeawareness = 0.9;
    self.grenadereturnthrowchance = 0.9;
    return;
  }

  if(self isbadguy()) {
    self.grenadeawareness = 1;
    self.grenadereturnthrowchance = 0.2;
  }
}

function map_is_early_in_the_game() {
  if(!isDefined(level.early_level)) {
    print("<dev string:x1c>");

    return 1;
  }

  if(isDefined(level.early_level[level.script])) {
    return level.early_level[level.script];
  }

  return 0;
}

function set_early_level() {
  level.early_level = [];
}