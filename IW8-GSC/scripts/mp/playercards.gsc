/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playercards.gsc
***********************************************/

function init() {
  thread onplayerconnect();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      var_0.playercardpatch = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "patch");
      var_0.playercardpatchbacking = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "patchbacking");
      var_0.playercardbackground = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "background");
    }
  }
}