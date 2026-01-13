/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3403.gsc
************************/

devfindhost() {
  var_0 = undefined;
  foreach(var_2 in level.players) {
    if(var_2 ishost()) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}