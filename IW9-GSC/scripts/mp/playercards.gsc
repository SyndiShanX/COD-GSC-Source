/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playercards.gsc
***********************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);

    if(!isai(player)) {
      player.playercardpatch = player getplayerdata(level.loadoutsgroup, "squadMembers", "patch");
      player.playercardpatchbacking = player getplayerdata(level.loadoutsgroup, "squadMembers", "patchbacking");
      player.playercardbackground = player getplayerdata(level.loadoutsgroup, "squadMembers", "background");
    }
  }
}