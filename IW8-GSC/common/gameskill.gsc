/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\gameskill.gsc
***********************************************/

get_skill_from_index(var_0) {
  if(scripts\common\utility::issp())
    var_0 = var_0 + 1;

  return level.difficultytype[var_0];
}

apply_difficulty_settings_shared(var_0) {
  self.gs.misstimeconstant = get_difficultysetting_frac("_encstr_879611A3DF4BC621E1D539F57DDE20FDC25B19", var_0);
  self.gs.misstimedistancefactor = get_difficultysetting_frac("_encstr_9B9517AD2D379BA2A5D6CA11A5CDA32CCDB1ACC80B368EDB27", var_0);
  self.gs.double_grenades_allowed = get_difficultysetting_frac("_encstr_8EA718295277AEF8CFCF47651DF56865DF0BC631CA4B5068E7CC", var_0);
}

get_difficultysetting_frac(var_0, var_1) {
  return get_difficultysetting(var_0) * var_1;
}

get_difficultysetting(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self.gameskill;

  return level.difficultysettings[var_0][get_skill_from_index(var_1)];
}

get_difficultysetting_global(var_0) {
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

  if(!isalive(level.painai) || level.painai.script != "_encstr_B60D055B0E3128")
    level.painai = self;

  if(self == level.painai)
    return 0;

  var_0 = self.damageweapon;

  if(!nullweapon(var_0) && var_0.isbolt)
    return 0;

  return 1;
}

set_accuracy_based_on_situation() {
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper() && isalive(self.enemy)) {
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

  if(isDefined(self.script) && self.script == "_encstr_ACA20538F84D39") {
    if(scripts\engine\utility::actor_is3d() && isDefined(self._blackboard.lastusednode) && (self._blackboard.lastusednode.type == "_encstr_87820B3588934FE3ED137AEA7B" || self._blackboard.lastusednode.type == "_encstr_926B08AB070DD449229D"))
      self.accuracy = self.baseaccuracy;
    else if(_encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::iscqbwalkingorfacingenemy())
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

  if(!isDefined(self.sniperaccuracyset)) {
    self.sniperaccuracyset = 1;
    var_0 = get_skill_from_index(level.gameskill);
    var_1 = level.difficultysettings["_encstr_8394146BC55002B71E05020AEB6DFFFF4027F3C169E8"][var_0];
    self.baseaccuracy = self.accuracy * var_1;
  }

  self.snipershotcount++;
  var_2 = level.gameskill;

  if(isPlayer(self.enemy))
    var_2 = self.enemy.gameskill;

  if(shouldforcesnipermissshot()) {
    self.accuracy = 0;

    if(var_2 > 0 || self.snipershotcount > 1)
      self.lastmissedenemy = self.enemy;

    return;
  }

  if(self.accuracy <= 10)
    self.accuracy = (1 + 1 * self.sniperhitcount) * self.baseaccuracy;

  self.sniperhitcount++;

  if(var_2 < 1 && self.sniperhitcount == 1)
    self.lastmissedenemy = undefined;
}

shouldforcesnipermissshot() {
  if(isDefined(self.neverforcesnipermissenemy) && self.neverforcesnipermissenemy)
    return 0;

  if(self.team == "_encstr_9A8507BA4040188D08")
    return 0;

  if(isDefined(self.lastmissedenemy) && self.enemy == self.lastmissedenemy)
    return 0;

  if(distancesquared(self.origin, self.enemy.origin) > 250000)
    return 0;

  return 1;
}

didsomethingotherthanshooting() {
  self.a.misstimedebounce = 0;
}

resetmisstime() {
  if(!self isbadguy()) {
    return;
  }
  if(nullweapon(self.weapon)) {
    return;
  }
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper()) {
    return;
  }
  if(istrue(self.loadout_giveweaponobj)) {
    return;
  }
  if(!_encstr_8B451CFBA1F677CA7807C791254855A69C99525388403BC42821CE9FF730::usingautomaticweapon() && !_encstr_8B451CFBA1F677CA7807C791254855A69C99525388403BC42821CE9FF730::usingsemiautoweapon()) {
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

default_door_node_flashbang_frequency() {
  if(self.team == "_encstr_9A8507BA4040188D08")
    self.doorflashchance = 0.6;

  if(self isbadguy()) {
    if(level.gameskill >= 2)
      self.doorflashchance = 0.8;
    else
      self.doorflashchance = 0.6;
  }
}

grenadeawareness() {
  if(self.team == "_encstr_9A8507BA4040188D08") {
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