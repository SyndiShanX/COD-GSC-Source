/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\playercards.gsc
*********************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    if(!isai(var_0)) {
      var_0.weaponfiretime = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "patch");
      var_0.weaponhasthermalscope = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "patchbacking");
      var_0.weaponfightdist = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "background");
    }
  }
}