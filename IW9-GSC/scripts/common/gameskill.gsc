/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\gameskill.gsc
***********************************************/

get_skill_from_index(index) {
  if(scripts\common\utility::issp())
    index = index + 1;

  return level.difficultytype[index];
}

apply_difficulty_settings_shared(_id_64E5D13011016A93) {
  self._id_DA4B6392C1BEC6A1 = get_difficultysetting_frac("missTimeConstant", _id_64E5D13011016A93);
  self._id_CEF700ED012E8981 = get_difficultysetting_frac("missTimeDistanceFactor", _id_64E5D13011016A93);
  _func_38AE83992C7EB8A5(get_difficultysetting("double_grenades_allowed"));
}

get_difficultysetting_frac(_id_8C958BDE9A9F8547, frac) {
  return get_difficultysetting(_id_8C958BDE9A9F8547) * frac;
}

get_difficultysetting(_id_8C958BDE9A9F8547, gameskill) {
  if(!isDefined(gameskill))
    gameskill = self.gameskill;

  return level.difficultysettings[_id_8C958BDE9A9F8547][get_skill_from_index(gameskill)];
}

get_difficultysetting_global(_id_8C958BDE9A9F8547) {
  return level.difficultysettings[_id_8C958BDE9A9F8547][get_skill_from_index(level.gameskill)];
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

  objweapon = self.damageweapon;

  if(!isnullweapon(objweapon) && objweapon.isbolt)
    return 0;

  return 1;
}

set_accuracy_based_on_situation() {
  if(self _meth_E8CA4080D02A0BB4() && isalive(self.enemy)) {
    self _meth_73EF2FE03A776CD7();
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

  if(isDefined(self.isrambo) && isDefined(self.ramboaccuracymult))
    self.accuracy = self.accuracy * self.ramboaccuracymult;
}

didsomethingotherthanshooting() {
  self.misstimedebounce = 0;
}

resetmissdebouncetime() {
  self.misstimedebounce = gettime() + 3000;
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
    self.grenadereturnthrowchance = 0.9;
    return;
  }

  if(self isbadguy()) {
    self.grenadeawareness = 1;
    self.grenadereturnthrowchance = 0.2;
  }
}

map_is_early_in_the_game() {
  if(!isDefined(level.early_level))
    return 1;

  if(isDefined(level.early_level[level.script]))
    return level.early_level[level.script];

  return 0;
}

set_early_level() {
  level.early_level = [];
}