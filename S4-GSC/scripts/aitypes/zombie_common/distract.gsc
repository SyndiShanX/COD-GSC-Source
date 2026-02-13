/******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_common\distract.gsc
******************************************************/

add_distraction(var_0, var_1) {
  if(!isDefined(level.aidistractions)) {
    level.aidistractions = [];
  }

  level.aidistractions = scripts\engine\utility::array_add(level.aidistractions, var_0);
  var_0.distractedzombies = [];
  var_0.distractionpositions = [];
  var_0.distractcategories = var_1;
  var_2 = _func_02AA(var_0.origin, 150, 64);

  if(isDefined(var_2)) {
    var_3 = _func_02AB(var_0.origin);
    var_4 = 256;

    foreach(var_6 in var_2) {
      if(distance2dsquared(self.origin, var_6) < var_4) {
        continue;
      }
      var_7 = !_func_02A6(var_3, var_6);

      if(var_7) {
        var_0.distractedzombies = scripts\engine\utility::array_add(var_0.distractedzombies, undefined);
        var_0.distractionpositions = scripts\engine\utility::array_add(var_0.distractionpositions, var_6);
      }
    }

    var_0.distractionpositions = scripts\engine\utility::_id_E026(var_0.distractionpositions, var_3);
  }
}

remove_distraction(var_0) {
  if(!isDefined(level.aidistractions)) {
    return;
  }
  level.aidistractions = scripts\engine\utility::array_remove(level.aidistractions, var_0);
}

_id_4BA7(var_0) {
  if(!istrue(self._id_86F2)) {
    var_1 = _find_distraction();

    if(isDefined(var_1)) {
      if(!isDefined(self.lastdistraction) || self.lastdistraction != var_1) {
        self.lastdistraction = var_1;
        self.lastdistractionpos = self _meth_86F8(_get_distracton_position(var_1));
      }

      var_2 = self.lastdistractionpos;

      if(isDefined(var_2)) {
        self _meth_84BC(0, var_2);
        var_3 = distancesquared(self.origin, var_2);

        if(var_3 <= 256) {
          self _meth_8251("face point", var_1.origin);
        }

        _set_distraction_effect(var_1);
        self.is_distracted = 1;
        return anim._id_CA5F;
      }
    }
  }

  self.is_distracted = 0;
  self.lastdistraction = undefined;
  self.lastdistractionpos = undefined;
  return anim._id_58E3;
}

_find_distraction() {
  if(!isDefined(level.aidistractions)) {
    return undefined;
  }

  var_0 = [];

  foreach(var_2 in level.aidistractions) {
    if(isDefined(var_2)) {
      if(!isDefined(var_2.distractcategories) || scripts\engine\utility::array_contains(var_2.distractcategories, self.zm_ai_category)) {
        var_0 = scripts\engine\utility::array_add(var_0, var_2);
      }
    }
  }

  return scripts\engine\utility::_id_6969(self.origin, var_0, 750);
}

_get_distracton_position(var_0) {
  var_1 = undefined;

  foreach(var_5, var_3 in var_0.distractionpositions) {
    var_4 = var_0.distractedzombies[var_5];

    if(!isDefined(var_4)) {
      var_1 = scripts\cp\utility::_id_459B(var_1, var_5);
      continue;
    }

    if(var_4 == self) {
      return var_3;
    }
  }

  if(isDefined(var_1)) {
    var_0.distractedzombies[var_1] = self;
    return var_0.distractionpositions[var_1];
  }

  return var_0.origin;
}

_set_distraction_effect(var_0) {
  if(isDefined(var_0.weapon_name) && var_0.weapon_name == "s4_decoy_grenade_zm") {
    _id_072A::addplayereffects("decoy", self, var_0.owner, 5);
  }
}