/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\dismember.gsc
***********************************************/

initscriptablepart(var_0) {
  if(!isDefined(self._blackboard.scriptableparts))
    self._blackboard.scriptableparts = [];

  if(!isDefined(self._blackboard.scriptableparts[var_0])) {
    self._blackboard.scriptableparts[var_0] = spawnStruct();
    self._blackboard.scriptableparts[var_0].state = "_encstr_820E07FAE8780B3A4C";
  }
}

set_scriptablepartinfo(var_0, var_1) {
  if(self._blackboard.scriptableparts[var_0].state == "_encstr_96560AC82DB95B2BDA31954E") {
    return;
  }
  if(self._blackboard.scriptableparts[var_0].state != "_encstr_820E07FAE8780B3A4C" && var_1 != "_encstr_96560AC82DB95B2BDA31954E")
    self._blackboard.scriptableparts[var_0].state = self._blackboard.scriptableparts[var_0].state + "_encstr_8ED8063792AF1BA1";
  else
    self._blackboard.scriptableparts[var_0].state = var_1;

  self._blackboard.scriptableparts[var_0].time = gettime();
}

set_scriptablepartstate(var_0, var_1, var_2) {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  set_scriptablepartinfo(var_0, var_1);

  if(isDefined(var_2))
    wait(var_2);

  if(isDefined(self.scriptablecleanup))
    return 1;

  var_3 = self._blackboard.scriptableparts[var_0].state;

  if(isDefined(anim.dismemberheavyfx[self.unittype])) {
    if(var_0 != "_encstr_81CC0586952C91" && var_3 != "_encstr_96560AC82DB95B2BDA31954E") {
      if(usedismemberfxlite(self.unittype))
        var_3 = var_3 + "_encstr_968506D736A5A3AC";
    }
  }

  self setscriptablepartstate(var_0, var_3);
}

setdismemberstatefx(var_0) {
  var_1 = var_0 + "_encstr_AF0609DE2F51A089B1D3A1";
  var_2 = get_scriptablepartinfo(var_0);

  if(var_2 == "_encstr_820E07FAE8780B3A4C")
    var_2 = "_encstr_913B0AB8E07B49D512772799";
  else if(issubstr(var_2, "_encstr_8ED8063792AF1BA1"))
    var_2 = "_encstr_B6F909E2C86F491378B5E0";

  if(!isDefined(level.in_vr) && isDefined(anim.dismemberheavyfx[self.unittype])) {
    if(var_0 != "_encstr_81CC0586952C91") {
      if(usedismemberfxlite(self.unittype))
        var_2 = var_2 + "_encstr_968506D736A5A3AC";
    }
  }

  self setscriptablepartstate(var_1, var_2);
}

usedismemberfxlite(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < anim.dismemberheavyfx[var_0].size; var_2++) {
    if(gettime() - anim.dismemberheavyfx[var_0][var_2] > 1000) {
      continue;
    }
    var_1[var_1.size] = anim.dismemberheavyfx[var_0][var_2];
  }

  if(var_1.size < 0) {
    var_1[var_1.size] = gettime();
    anim.dismemberheavyfx[var_0] = var_1;
    return 0;
  }

  anim.dismemberheavyfx[var_0] = var_1;
  return 1;
}

get_scriptablepartinfo(var_0) {
  if(!isDefined(self._blackboard.scriptableparts))
    return "_encstr_820E07FAE8780B3A4C";

  if(!isDefined(self._blackboard.scriptableparts[var_0]))
    return "_encstr_820E07FAE8780B3A4C";

  return self._blackboard.scriptableparts[var_0].state;
}

anylegdismembered() {
  if(get_scriptablepartinfo("_encstr_A95F091BB2CC8EBEC62BD9") == "_encstr_96560AC82DB95B2BDA31954E" || get_scriptablepartinfo("_encstr_91F40A7AB3E9A3E34790BA92") == "_encstr_96560AC82DB95B2BDA31954E")
    return 1;

  return 0;
}

bothlegsdismembered() {
  if(get_scriptablepartinfo("_encstr_A95F091BB2CC8EBEC62BD9") == "_encstr_96560AC82DB95B2BDA31954E" && get_scriptablepartinfo("_encstr_91F40A7AB3E9A3E34790BA92") == "_encstr_96560AC82DB95B2BDA31954E")
    return 1;

  return 0;
}

anyarmdismembered() {
  if(get_scriptablepartinfo("_encstr_A75F09A1FD03131FFE8BD8") == "_encstr_96560AC82DB95B2BDA31954E" || get_scriptablepartinfo("_encstr_A9F40A4EA5EC0D8EFAC2E4B5") == "_encstr_96560AC82DB95B2BDA31954E")
    return 1;

  return 0;
}

rightarmdismembered() {
  if(get_scriptablepartinfo("_encstr_A9F40A4EA5EC0D8EFAC2E4B5") == "_encstr_96560AC82DB95B2BDA31954E")
    return 1;

  return 0;
}

leftarmdismembered() {
  if(get_scriptablepartinfo("_encstr_A75F09A1FD03131FFE8BD8") == "_encstr_96560AC82DB95B2BDA31954E")
    return 1;

  return 0;
}

botharmsdismembered() {
  if(get_scriptablepartinfo("_encstr_A75F09A1FD03131FFE8BD8") == "_encstr_96560AC82DB95B2BDA31954E" && get_scriptablepartinfo("_encstr_A9F40A4EA5EC0D8EFAC2E4B5") == "_encstr_96560AC82DB95B2BDA31954E")
    return 1;

  return 0;
}