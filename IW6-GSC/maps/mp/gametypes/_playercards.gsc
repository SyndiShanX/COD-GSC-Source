/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_playercards.gsc
**********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

init() {
  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    if(!IsAI(player)) {
      player.playerCardPatch = player GetCaCPlayerData("patch");
      player.playerCardPatchBacking = player GetCaCPlayerData("patchbacking");
      player.playerCardBackground = player GetCaCPlayerData("background");
    }
  }
}