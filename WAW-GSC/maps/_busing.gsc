/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_busing.gsc
*****************************************************/

#include maps\_utility;

busInit() {
  assert(level.clientscripts);
  level.busState = "";
  registerClientSys("busCmd");
}

setBusState(state) {
  if(level.busState != state) {
    setClientSysState("busCmd", state);
  }
  level.busState = state;
}