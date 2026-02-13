/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 7.gsc
*************************************************/

_id_0109(var_0, var_1) {
  corpsemovedcallback(var_0, var_1);
}

_id_0108(var_0, var_1, var_2) {
  corpsesettledcallback(var_0, var_1, var_2);
}

corpsemovedcallback(var_0, var_1) {
  var_2 = _func_00E2("#x315f419eb00e6484f", 0);

  if(var_2 == 0) {
    return;
  }
  if(isDefined(level.bloodtriggers) && isDefined(level.bloodtriggers[var_0]) && isDefined(level.bloodtriggers[var_0][var_1])) {
    level.bloodtriggers[var_0][var_1] notify("death");
    level.bloodtriggers[var_0][var_1] _meth_8001();
    level.bloodtriggers[var_0][var_1] = undefined;
  }
}

corpsesettledcallback(var_0, var_1, var_2) {
  var_3 = _func_00E2("#x315f419eb00e6484f", 0);

  if(var_3 == 0) {
    return;
  }
  var_4 = _func_0045(var_0, var_2, "trigger_radius", 30, 10);
  var_4 thread listentotriggernotify(var_0);

  if(!isDefined(level.bloodtriggers)) {
    level.bloodtriggers = [];
  }

  if(!isDefined(level.bloodtriggers[var_0])) {
    level.bloodtriggers[var_0] = [];
  }

  if(isDefined(level.bloodtriggers[var_0][var_1])) {
    level.bloodtriggers[var_0][var_1] notify("death");
    level.bloodtriggers[var_0][var_1] _meth_8001();
    level.bloodtriggers[var_0][var_1] = undefined;
  }

  level.bloodtriggers[var_0][var_1] = var_4;
}

listentotriggernotify(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(!_func_0095(var_1)) {
      continue;
    }
    _func_00D9(var_0, var_1, self.origin);
  }
}