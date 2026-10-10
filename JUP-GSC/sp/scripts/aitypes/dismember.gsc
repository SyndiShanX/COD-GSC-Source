/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\aitypes\dismember.gsc
***********************************************/

#using scripts\aitypes\bt_util;
#using scripts\aitypes\dismember;
#using scripts\anim\utility_common;
#namespace dismember;

function initscriptablepart(part) {
  if(!isDefined(self._blackboard.scriptableparts)) {
    self._blackboard.scriptableparts = [];
  }

  if(!isDefined(self._blackboard.scriptableparts[part])) {
    self._blackboard.scriptableparts[part] = spawnStruct();
    self._blackboard.scriptableparts[part].state = "normal";
  }
}

function set_scriptablepartinfo(part, state) {
  if(self._blackboard.scriptableparts[part].state == "dismember") {
    return;
  }

  if(self._blackboard.scriptableparts[part].state != "normal" && state != "dismember") {
    self._blackboard.scriptableparts[part].state += "_both";
  } else {
    self._blackboard.scriptableparts[part].state = state;
  }

  self._blackboard.scriptableparts[part].time = gettime();
}

function set_scriptablepartstate(part, state, waittime) {
  self endon("entitydeleted");
  set_scriptablepartinfo(part, state);

  if(isDefined(waittime)) {
    wait waittime;
  }

  if(isDefined(self.scriptablecleanup)) {
    return 1;
  }

  partstate = self._blackboard.scriptableparts[part].state;

  if(isDefined(anim.dismemberheavyfx[self.unittype])) {
    if(part != "head" && partstate != "dismember") {
      if(usedismemberfxlite(self.unittype)) {
        partstate += "_lite";
      }
    }
  }

  self setscriptablepartstate(part, partstate);
}

function setdismemberstatefx(part) {
  fx_part = part + "_dism_fx";
  state = get_scriptablepartinfo(part);

  if(state == "normal") {
    state = "undamaged";
  } else if(issubstr(state, "_both")) {
    state = "dmg_both";
  }

  if(!isDefined(level.in_vr) && isDefined(anim.dismemberheavyfx[self.unittype])) {
    if(part != "head") {
      if(usedismemberfxlite(self.unittype)) {
        state += "_lite";
      }
    }
  }

  self setscriptablepartstate(fx_part, state);
}

function usedismemberfxlite(type) {
  newarray = [];

  for(i = 0; i < anim.dismemberheavyfx[type].size; i++) {
    if(gettime() - anim.dismemberheavyfx[type][i] > 1000) {
      continue;
    }

    newarray[newarray.size] = anim.dismemberheavyfx[type][i];
  }

  if(newarray.size < 0) {
    newarray[newarray.size] = gettime();
    anim.dismemberheavyfx[type] = newarray;
    return false;
  }

  anim.dismemberheavyfx[type] = newarray;
  return true;
}

function get_scriptablepartinfo(part) {
  if(!isDefined(self._blackboard.scriptableparts)) {
    return "normal";
  }

  if(!isDefined(self._blackboard.scriptableparts[part])) {
    return "normal";
  }

  return self._blackboard.scriptableparts[part].state;
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
  if(scripts\aitypes\dismember::get_scriptablepartinfo("left_arm") == "dismember" && scripts\aitypes\dismember::get_scriptablepartinfo("right_arm") == "dismember") {
    return true;
  }

  return false;
}