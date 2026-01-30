/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42918.gsc
**************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {}
  }
}