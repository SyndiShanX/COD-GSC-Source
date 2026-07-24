/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2571.gsc
**************************************/

_id_98C9(var_0) {
  if(!isDefined(self._blackboard.scriptableparts)) {
    self._blackboard.scriptableparts = [];
  }

  if(!isDefined(self._blackboard.scriptableparts[var_0])) {
    self._blackboard.scriptableparts[var_0] = spawnStruct();
    self._blackboard.scriptableparts[var_0].state = "normal";
  }
}

_id_F591(var_0, var_1) {
  if(self._blackboard.scriptableparts[var_0].state == "dismember") {
    return;
  }
  if(self._blackboard.scriptableparts[var_0].state != "normal" && var_1 != "dismember") {
    self._blackboard.scriptableparts[var_0].state = self._blackboard.scriptableparts[var_0].state + "_both";
  } else {
    self._blackboard.scriptableparts[var_0].state = var_1;
  }

  self._blackboard.scriptableparts[var_0].time = gettime();
}

_id_F592(var_0, var_1, var_2) {
  self endon("entitydeleted");
  _id_F591(var_0, var_1);

  if(isDefined(var_2)) {
    wait(var_2);
  }

  if(isDefined(self._id_EF39)) {
    return 1;
  }

  var_3 = self._blackboard.scriptableparts[var_0].state;

  if(isDefined(anim._id_5667[self.unittype])) {
    if(var_0 != "head" && var_3 != "dismember") {
      if(_id_13077(self.unittype)) {
        var_3 = var_3 + "_lite";
      }
    }
  }

  self setscriptablepartstate(var_0, var_3);
}

_id_F6C9(var_0) {
  var_1 = var_0 + "_dism_fx";
  var_2 = _id_7C35(var_0);

  if(var_2 == "normal") {
    var_2 = "undamaged";
  } else if(issubstr(var_2, "_both")) {
    var_2 = "dmg_both";
  }

  if(!isDefined(level._id_93A9) && isDefined(anim._id_5667[self.unittype])) {
    if(var_0 != "head") {
      if(_id_13077(self.unittype)) {
        var_2 = var_2 + "_lite";
      }
    }
  }

  self setscriptablepartstate(var_1, var_2);
}

_id_13077(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < anim._id_5667[var_0].size; var_2++) {
    if(gettime() - anim._id_5667[var_0][var_2] > 1000) {
      continue;
    }
    var_1[var_1.size] = anim._id_5667[var_0][var_2];
  }

  if(var_1.size < 0) {
    var_1[var_1.size] = gettime();
    anim._id_5667[var_0] = var_1;
    return 0;
  }

  anim._id_5667[var_0] = var_1;
  return 1;
}

_id_7C35(var_0) {
  if(!isDefined(self._blackboard.scriptableparts)) {
    return "normal";
  }

  if(!isDefined(self._blackboard.scriptableparts[var_0])) {
    return "normal";
  }

  return self._blackboard.scriptableparts[var_0].state;
}

_id_2040() {
  if(_id_7C35("left_leg") == "dismember" || _id_7C35("right_leg") == "dismember") {
    return 1;
  }

  return 0;
}

_id_2EE2() {
  if(_id_7C35("left_leg") == "dismember" && _id_7C35("right_leg") == "dismember") {
    return 1;
  }

  return 0;
}

_id_203F() {
  if(_id_7C35("left_arm") == "dismember" || _id_7C35("right_arm") == "dismember") {
    return 1;
  }

  return 0;
}

_id_E52D() {
  if(_id_7C35("right_arm") == "dismember") {
    return 1;
  }

  return 0;
}

_id_AB53() {
  if(_id_7C35("left_arm") == "dismember") {
    return 1;
  }

  return 0;
}

_id_2EE1() {
  if(_id_7C35("left_arm") == "dismember" && _id_7C35("right_arm") == "dismember") {
    return 1;
  }

  return 0;
}