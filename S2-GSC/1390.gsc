/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1390.gsc
*********************************************/

func_52A4() {
  lib_0561::func_52A5("attack_dogs", "Attack Dogs", ::func_A1FA, ::func_1F2D, ::func_4423);
  level thread maps\mp\killstreaks\_dog_killstreak::init();
}

func_1F2D() {
  return 1;
}

func_A1FA() {
  self playlocalsound("zmb_pickup_general");
  thread maps\mp\killstreaks\_dog_killstreak::func_9E26();
}

func_4423(param_00) {
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