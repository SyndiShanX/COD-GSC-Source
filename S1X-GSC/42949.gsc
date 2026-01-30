/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42949.gsc
**************************************/

playerprocesstaggedassist(var_0) {
  if(level.teambased && isDefined(var_0)) {
    thread maps\mp\_events::processassistevent(var_0);
  }
}