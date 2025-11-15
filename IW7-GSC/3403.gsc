/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3403.gsc
************************/

devfindhost() {
  var_00 = undefined;
  foreach(var_02 in level.players) {
    if(var_02 ishost()) {
      var_00 = var_02;
      break;
    }
  }

  return var_00;
}