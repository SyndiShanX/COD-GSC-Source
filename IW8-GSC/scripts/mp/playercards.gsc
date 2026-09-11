/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playercards.gsc
***********************************************/

function init() {
  thread onplayerconnect();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);

    if(!isai(var0)) {
      var0.playercardpatch = var0 getplayerdata(level.loadoutsgroup, "squadMembers", "patch");
      var0.playercardpatchbacking = var0 getplayerdata(level.loadoutsgroup, "squadMembers", "patchbacking");
      var0.playercardbackground = var0 getplayerdata(level.loadoutsgroup, "squadMembers", "background");
    }
  }
}