/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\dismember.gsc
***********************************************/

initscriptablepart(part) {
  if(!isDefined(self._blackboard.scriptableparts))
    self._blackboard.scriptableparts = [];

  if(!isDefined(self._blackboard.scriptableparts[part])) {
    self._blackboard.scriptableparts[part] = spawnStruct();
    self._blackboard.scriptableparts[part].state = "normal";
  }
}

set_scriptablepartinfo(part, state) {
  if(self._blackboard.scriptableparts[part].state == "dismember") {
    return;
  }
  if(self._blackboard.scriptableparts[part].state != "normal" && state != "dismember")
    self._blackboard.scriptableparts[part].state = self._blackboard.scriptableparts[part].state + "_both";
  else
    self._blackboard.scriptableparts[part].state = state;

  self._blackboard.scriptableparts[part].time = gettime();
}

set_scriptablepartstate(part, state, waittime) {
  self endon("entitydeleted");
  set_scriptablepartinfo(part, state);

  if(isDefined(waittime))
    wait(waittime);

  if(isDefined(self.scriptablecleanup))
    return 1;

  _id_68D9E792FE9DEF4D = self._blackboard.scriptableparts[part].state;

  if(isDefined(anim.dismemberheavyfx[self.unittype])) {
    if(part != "head" && _id_68D9E792FE9DEF4D != "dismember") {
      if(usedismemberfxlite(self.unittype))
        _id_68D9E792FE9DEF4D = _id_68D9E792FE9DEF4D + "_lite";
    }
  }

  self setscriptablepartstate(part, _id_68D9E792FE9DEF4D);
}

setdismemberstatefx(part) {
  _id_BEDC4A2A8EA9768D = part + "_dism_fx";
  state = get_scriptablepartinfo(part);

  if(state == "normal")
    state = "undamaged";
  else if(issubstr(state, "_both"))
    state = "dmg_both";

  if(!isDefined(level.in_vr) && isDefined(anim.dismemberheavyfx[self.unittype])) {
    if(part != "head") {
      if(usedismemberfxlite(self.unittype))
        state = state + "_lite";
    }
  }

  self setscriptablepartstate(_id_BEDC4A2A8EA9768D, state);
}

usedismemberfxlite(type) {
  _id_BFC65A378A6D8EFE = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < anim.dismemberheavyfx[type].size; _id_AC0E594AC96AA3A8++) {
    if(gettime() - anim.dismemberheavyfx[type][_id_AC0E594AC96AA3A8] > 1000) {
      continue;
    }
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = anim.dismemberheavyfx[type][_id_AC0E594AC96AA3A8];
  }

  if(_id_BFC65A378A6D8EFE.size < 0) {
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = gettime();
    anim.dismemberheavyfx[type] = _id_BFC65A378A6D8EFE;
    return 0;
  }

  anim.dismemberheavyfx[type] = _id_BFC65A378A6D8EFE;
  return 1;
}

get_scriptablepartinfo(part) {
  if(!isDefined(self._blackboard.scriptableparts))
    return "normal";

  if(!isDefined(self._blackboard.scriptableparts[part]))
    return "normal";

  return self._blackboard.scriptableparts[part].state;
}

anylegdismembered() {
  if(get_scriptablepartinfo("left_leg") == "dismember" || get_scriptablepartinfo("right_leg") == "dismember")
    return 1;

  return 0;
}

bothlegsdismembered() {
  if(get_scriptablepartinfo("left_leg") == "dismember" && get_scriptablepartinfo("right_leg") == "dismember")
    return 1;

  return 0;
}

anyarmdismembered() {
  if(get_scriptablepartinfo("left_arm") == "dismember" || get_scriptablepartinfo("right_arm") == "dismember")
    return 1;

  return 0;
}

rightarmdismembered() {
  if(get_scriptablepartinfo("right_arm") == "dismember")
    return 1;

  return 0;
}

leftarmdismembered() {
  if(get_scriptablepartinfo("left_arm") == "dismember")
    return 1;

  return 0;
}

botharmsdismembered() {
  if(get_scriptablepartinfo("left_arm") == "dismember" && get_scriptablepartinfo("right_arm") == "dismember")
    return 1;

  return 0;
}