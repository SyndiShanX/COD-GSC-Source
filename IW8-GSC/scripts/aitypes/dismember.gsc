/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\dismember.gsc
***********************************************/

function initscriptablepart(var0) {
  if(!isDefined(self._blackboard.scriptableparts)) {
    self._blackboard.scriptableparts = [];
  }

  if(!isDefined(self._blackboard.scriptableparts[var0])) {
    self._blackboard.scriptableparts[var0] = spawnStruct();
    self._blackboard.scriptableparts[var0].state = "normal";
    return;
  }
}

function set_scriptablepartinfo(var0, var1) {
  if(self._blackboard.scriptableparts[var0].state == "dismember") {
    return;
  }

  if(self._blackboard.scriptableparts[var0].state != "normal" && var1 != "dismember") {
    self._blackboard.scriptableparts[var0].state += "_both";
  } else {
    self._blackboard.scriptableparts[var0].state = var1;
  }

  self._blackboard.scriptableparts[var0].time = gettime();
}

function set_scriptablepartstate(var0, var1, var2) {
  self endon("entitydeleted");
  set_scriptablepartinfo(var0, var1);

  if(isDefined(var2)) {
    wait var2;
  }

  if(isDefined(self.scriptablecleanup)) {
    return 1;
  }

  var3 = self._blackboard.scriptableparts[var0].state;

  if(isDefined(anim.dismemberheavyfx[self.unittype])) {
    if(var0 != "head" && var3 != "dismember") {
      if(usedismemberfxlite(self.unittype)) {
        var3 += "_lite";
      }
    }
  }

  self setscriptablepartstate(var0, var3);
}

function setdismemberstatefx(var0) {
  var1 = var0 + "_dism_fx";
  var2 = get_scriptablepartinfo(var0);

  if(var2 == "normal") {
    var2 = "undamaged";
  } else if(issubstr(var2, "_both")) {
    var2 = "dmg_both";
  }

  if(!isDefined(level.in_vr) && isDefined(anim.dismemberheavyfx[self.unittype])) {
    if(var0 != "head") {
      if(usedismemberfxlite(self.unittype)) {
        var2 += "_lite";
      }
    }
  }

  self setscriptablepartstate(var1, var2);
}

function usedismemberfxlite(var0) {
  var1 = [];

  for(var2 = 0; var2 < anim.dismemberheavyfx[var0].size; var2++) {
    if(gettime() - anim.dismemberheavyfx[var0][var2] > 1000) {
      continue;
    }

    var1 = anim.dismemberheavyfx[var0][var2];
  }

  if(var1.size < 0) {
    var1 = gettime();
    anim.dismemberheavyfx[var0] = var1;
    return false;
  }

  anim.dismemberheavyfx[var0] = var1;
  return true;
}

function get_scriptablepartinfo(var0) {
  if(!isDefined(self._blackboard.scriptableparts)) {
    return "normal";
  }

  if(!isDefined(self._blackboard.scriptableparts[var0])) {
    return "normal";
  }

  return self._blackboard.scriptableparts[var0].state;
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