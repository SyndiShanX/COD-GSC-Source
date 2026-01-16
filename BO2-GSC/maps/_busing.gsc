/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_busing.gsc
**************************************/

#include maps\_utility;

businit() {
  assert(level.clientscripts);
  level.busstate = "";
  registerclientsys("busCmd");
}

setbusstate(state) {
  if(level.busstate != state)
    setclientsysstate("busCmd", state);

  level.busstate = state;
}