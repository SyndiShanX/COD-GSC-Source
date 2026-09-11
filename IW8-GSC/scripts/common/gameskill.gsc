/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\gameskill.gsc
***********************************************/

function get_skill_from_index(var0) {
  if(scripts\common\utility::issp()) {
    var0 += 1;
  }

  return level.difficultytype[var0];
}

function apply_difficulty_settings_shared(var0) {
  self.gs.misstimeconstant = get_difficultysetting_frac("missTimeConstant", var0);
  self.gs.misstimedistancefactor = get_difficultysetting_frac("missTimeDistanceFactor", var0);
  self.gs.double_grenades_allowed = get_difficultysetting_frac("double_grenades_allowed", var0);
}

function get_difficultysetting_frac(var0, var1) {
  return get_difficultysetting(var0) * var1;
}

function get_difficultysetting(var0, var1) {
  if(!isDefined(var1)) {
    var1 = self.gameskill;
  }

  return level.difficultysettings[var0][get_skill_from_index(var1)];
}

function get_difficultysetting_global(var0) {
  return level.difficultysettings[var0][get_skill_from_index(level.gameskill)];
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

  var0 = self.damageweapon;

  if(!nullweapon(var0) && var0.isbolt) {
    return false;
  }

  return true;
}

function set_accuracy_based_on_situation() {
  if(scripts\anim\utility_common::isasniper() && isalive(self.enemy)) {
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

  if(isDefined(self.script) && self.script == "move") {
    if(scripts\engine\utility::actor_is3d() && isDefined(self._blackboard.lastusednode) && (self._blackboard.lastusednode.type == "Exposed 3D" || self._blackboard.lastusednode.type == "Path 3D")) {
      self.accuracy = self.baseaccuracy;
      return;
    }

    if(scripts\anim\utility::iscqbwalkingorfacingenemy()) {
      self.accuracy = anim.walk_accuracy * self.baseaccuracy;
      return;
    }

    self.accuracy = anim.run_accuracy * self.baseaccuracy;
    return;
  }

  self.accuracy = self.baseaccuracy;

  if(isDefined(self.isrambo) && isDefined(self.ramboaccuracymult)) {
    self.accuracy *= self.ramboaccuracymult;
    return;
  }
}

function setsniperaccuracy() {
  if(!isDefined(self.snipershotcount)) {
    self.snipershotcount = 0;
    self.sniperhitcount = 0;
  }

  if(!isDefined(self.sniperaccuracyset)) {
    self.sniperaccuracyset = 1;
    var0 = get_skill_from_index(level.gameskill);
    var1 = level.difficultysettings["sniperAccuDiffScale"][var0];
    self.baseaccuracy = self.accuracy * var1;
  }

  self.snipershotcount++;
  var2 = level.gameskill;

  if(isPlayer(self.enemy)) {
    var2 = self.enemy.gameskill;
  }

  if(shouldforcesnipermissshot()) {
    self.accuracy = 0;

    if(var2 > 0 || self.snipershotcount > 1) {
      self.lastmissedenemy = self.enemy;
    }

    return;
  }

  if(self.accuracy <= 10) {
    self.accuracy = (1 + 1 * self.sniperhitcount) * self.baseaccuracy;
  }

  self.sniperhitcount++;

  if(var2 < 1 && self.sniperhitcount == 1) {
    self.lastmissedenemy = undefined;
    return;
  }
}

function shouldforcesnipermissshot() {
  if(isDefined(self.neverforcesnipermissenemy) && self.neverforcesnipermissenemy) {
    return false;
  }

  if(self.team == "allies") {
    return false;
  }

  if(isDefined(self.lastmissedenemy) && self.enemy == self.lastmissedenemy) {
    return false;
  }

  if(distancesquared(self.origin, self.enemy.origin) > 250000) {
    return false;
  }

  return true;
}

function didsomethingotherthanshooting() {
  self.a.misstimedebounce = 0;
}

function resetmisstime() {
  if(!self isbadguy()) {
    return;
  }

  if(nullweapon(self.weapon)) {
    return;
  }

  if(scripts\anim\utility_common::isasniper()) {
    return;
  }

  if(istrue(self.loadout_giveweaponobj)) {
    return;
  }

  if(!scripts\anim\weaponlist::usingautomaticweapon() && !scripts\anim\weaponlist::usingsemiautoweapon()) {
    self.a.misstime = 0;
    return;
  }

  if(!isalive(self.enemy)) {
    return;
  }

  if(!isPlayer(self.enemy)) {
    self.accuracy = self.baseaccuracy;
    return;
  }

  var0 = distance(self.enemy.origin, self.origin);
  setmisstime(self.enemy.gs.misstimeconstant + var0 * self.enemy.gs.misstimedistancefactor);
}

function resetmissdebouncetime() {
  self.a.misstimedebounce = gettime() + 3000;
}

function setmisstime(var0) {
  if(self.a.misstimedebounce > gettime()) {
    return;
  }

  if(var0 > 0) {
    self.accuracy = 0;
  }

  var0 *= 1000;
  self.a.misstime = gettime() + var0;
  self.a.accuracygrowthmultiplier = 1;
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
    return;
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
    return;
  }
}

function map_is_early_in_the_game() {
  if(!isDefined(level.early_level)) {
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