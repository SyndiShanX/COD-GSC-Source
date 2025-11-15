/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_gamemode.gsc
**************************************/

shouldSaveOnStartup() {
  gt = getDvar(#"g_gametype");
  switch (gt) {
    case "vs":
      return false;
    default:
      break;
  }
  return true;
}