/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\dismember.gsc
***********************************************/

function initscriptablepart(var_0) {
  if(!isDefined(self._blackboard.scriptableparts)) {
    self._blackboard.scriptableparts = [];
  }

  if(!isDefined(self._blackboard.scriptableparts[var_0])) {
    self._blackboard.scriptableparts[var_0] = spawnStruct();
    self._blackboard.scriptableparts[var_0].state = "normal";
    return;
  }
}

function set_scriptablepartinfo(var_0, var_1) {
  if(self._blackboard.scriptableparts[var_0].state == "dismember") {
    return;
  }

  if(self._blackboard.scriptableparts[var_0].state != "normal" && var_1 != "dismember") {
    self._blackboard.scriptableparts[var_0].state += "_both";
  } else {
    self._blackboard.scriptableparts[var_0].state = var_1;
  }

  self._blackboard.scriptableparts[var_0].time = gettime();
}

function set_scriptablepartstate(var_0, var_1, var_2) {
  self endon("entitydeleted");
  set_scriptablepartinfo(var_0, var_1);

  if(isDefined(var_2)) {
    wait var_2;
  }

  if(isDefined(self.scriptablecleanup)) {
    return 1;
  }

  var_3 = self._blackboard.scriptableparts[var_0].state;

  if(isDefined(anim.dismemberheavyfx[self.unittype])) {
    if(var_0 != "head" && var_3 != "dismember") {
      if(usedismemberfxlite(self.unittype)) {
        var_3 += "_lite";
      }
    }
  }

  self setscriptablepartstate(var_0, var_3);
}

function setdismemberstatefx(var_0) {
  var_1 = var_0 + "_dism_fx";
  var_2 = get_scriptablepartinfo(var_0);

  if(var_2 == "normal") {
    var_2 = "undamaged";
  } else if(issubstr(var_2, "_both")) {
    var_2 = "dmg_both";
  }

  if(!isDefined(level.in_vr) && isDefined(anim.dismemberheavyfx[self.unittype])) {
    if(var_0 != "head") {
      if(usedismemberfxlite(self.unittype)) {
        var_2 += "_lite";
      }
    }
  }

  self setscriptablepartstate(var_1, var_2);
}

function usedismemberfxlite(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < anim.dismemberheavyfx[var_0].size; var_2++) {
    if(gettime() - anim.dismemberheavyfx[var_0][var_2] > 1000) {
      continue;
    }

    var_1 = anim.dismemberheavyfx[var_0][var_2];
  }

  if(var_1.size < 0) {
    var_1 = gettime();
    anim.dismemberheavyfx[var_0] = var_1;
    return false;
  }

  anim.dismemberheavyfx[var_0] = var_1;
  return true;
}

function get_scriptablepartinfo(var_0) {
  if(!isDefined(self._blackboard.scriptableparts)) {
    return "normal";
  }

  if(!isDefined(self._blackboard.scriptableparts[var_0])) {
    return "normal";
  }

  return self._blackboard.scriptableparts[var_0].state;
}

function anylegdismembered() {
  if(get_scriptablepartinfo("left_leg") == "dismember" || get_scriptablepartinfo("right_leg") == "dismember") {
    return true;
  }

  return false;
}

function bothlegsdismembered() {
  if(get_scriptablepartinfo("left_leg") == "dismember" && get_scriptablepartinfo("right_leg") == "dismember") {
    return true;
  }

  return false;
}

function anyarmdismembered() {
  if(get_scriptablepartinfo("left_arm") == "dismember" || get_scriptablepartinfo("right_arm") == "dismember") {
    return true;
  }

  return false;
}

function rightarmdismembered() {
  if(get_scriptablepartinfo("right_arm") == "dismember") {
    return true;
  }

  return false;
}

function leftarmdismembered() {
  if(get_scriptablepartinfo("left_arm") == "dismember") {
    return true;
  }

  return false;
}

function botharmsdismembered() {
  if(get_scriptablepartinfo("left_arm") == "dismember" && get_scriptablepartinfo("right_arm") == "dismember") {
    return true;
  }

  return false;
}