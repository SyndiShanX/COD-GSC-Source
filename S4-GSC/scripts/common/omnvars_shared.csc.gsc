/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\common\omnvars_shared\.csc.gsc
*************************************************/

callbackomnvarschanged(var_0, var_1, var_2) {
  if(!isDefined(level.omnvarcallbacks)) {
    return;
  }
  var_3 = var_1;

  for(var_5 = _func_0022(var_3); isDefined(var_5); var_5 = _func_0024(var_3, var_5)) {
    var_4 = var_3[var_5];

    if(isDefined(level.omnvarcallbacks[var_4.name])) {
      omnvarchanged(var_0, var_4.name, var_4._id_0346, var_4._id_0130, var_4._id_0494, var_2);
    }
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
}

omnvarchanged(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.omnvarcallbacks[var_1];

  for(var_8 = _func_0022(var_6); isDefined(var_8); var_8 = _func_0024(var_6, var_8)) {
    var_7 = var_6[var_8];

    if(!isDefined(var_7)) {
      continue;
    }
    level thread[[var_7]](var_0, var_1, var_2, var_3, var_4, var_5);
  }

  __asm_var_clear(2)
  __asm_var_clear(0)
}

registeromnvarcallback(var_0, var_1) {
  if(!isDefined(level.omnvarcallbacks)) {
    level.omnvarcallbacks = [];
  }

  if(!isDefined(level.omnvarcallbacks[var_0])) {
    level.omnvarcallbacks[var_0] = [];
  }

  var_2 = "" + level.omnvarcallbacks[var_0].size;
  level.omnvarcallbacks[var_0][var_2] = var_1;
}

removeomnvarcallback(var_0, var_1) {
  var_2 = level.omnvarcallbacks[var_0];

  for(var_4 = _func_0022(var_2); isDefined(var_4); var_4 = _func_0024(var_2, var_4)) {
    var_3 = var_2[var_4];

    if(isDefined(var_3) && var_3 == var_1) {
      level.omnvarcallbacks[var_0][var_4] = undefined;
      return;
    }
  }

  __asm_var_clear(2)
}