/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_gamemode.gsc
**************************************/

shouldsaveonstartup() {
  gt = getdvar(#"g_gametype");

  switch (gt) {
    case "vs":
      return false;
    default:
      break;
  }

  return true;
}