/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spy_util.gsc
*********************************************/

spyclasstostring(param_00) {
  if(!isDefined(param_00)) {
    return "<undefined>";
  }

  switch (param_00) {
    case 0:
      return "civilian";

    case 1:
      return "detective";

    case 2:
      return "traitor";

    case 16777215:
      return "none";

    default:
      return "unknown";
  }
}

spyclasstolocstring(param_00) {
  if(!isDefined(param_00)) {
    return "<undefined>";
  }

  switch (param_00) {
    case 0:
      return &"MP_SPY_CLASS_CIVILIAN";

    case 1:
      return &"MP_SPY_DETECTIVE";

    case 2:
      return &"MP_SPY_CLASS_TRAITOR";

    case 16777215:
      return "none";

    default:
      return "unknown";
  }
}

spyclassfriendlycheck(param_00, param_01) {
  if(param_00 == 0 || param_00 == 1) {
    return param_01 == 0 || param_01 == 1;
  }

  return param_01 == 2;
}