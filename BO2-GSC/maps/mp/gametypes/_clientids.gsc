/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_clientids.gsc
********************************************/

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