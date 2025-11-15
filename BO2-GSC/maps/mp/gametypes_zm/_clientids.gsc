/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes_zm\_clientids.gsc
***********************************************/

init() {
  level.clientid = 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connecting", player);
    player.clientid = level.clientid;
    level.clientid++;
  }
}