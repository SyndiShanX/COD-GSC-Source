/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\playercards.gsc
**************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isai(var_00)) {
      var_00.weaponfiretime = var_00 getplayerdata(level.loadoutsgroup, "squadMembers", "patch");
      var_00.weaponhasthermalscope = var_00 getplayerdata(level.loadoutsgroup, "squadMembers", "patchbacking");
      var_00.weaponfightdist = var_00 getplayerdata(level.loadoutsgroup, "squadMembers", "background");
    }
  }
}