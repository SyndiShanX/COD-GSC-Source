/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1390.gsc
*********************************************/

lib_056E::func_52A4() {
  lib_0561::func_52A5("attack_dogs", "Attack Dogs", ::lib_056E::func_A1FA, ::lib_056E::func_1F2D, ::lib_056E::func_4423);
  level thread maps\mp\killstreaks\_dog_killstreak::func_00D5();
}

lib_056E::func_1F2D() {
  return 1;
}

lib_056E::func_A1FA() {
  self method_8615("zmb_pickup_general");
  thread maps\mp\killstreaks\_dog_killstreak::func_9E26();
}

lib_056E::func_4423(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "";
  }

  switch (param_00) {
    case "epic":
      return 4;

    case "legendary":
      return 3;

    case "rare":
      return 2;

    case "common":
      return 1;

    default:
      return 0;
  }
}