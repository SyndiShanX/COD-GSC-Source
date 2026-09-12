/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_playercards.gsc
**********************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isai(var_00)) {}
  }
}