/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2049.gsc
*************************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      var_0._id_0333 = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "patch");
      var_0._id_0334 = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "patchbacking");
      var_0._id_0332 = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "background");
    }
  }
}