/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\ztutorial.csc
***********************************************/

#namespace ztutorial;

event_handler[gametype_init] main(eventstruct) {
  level._zombie_gamemodeprecache = &onprecachegametype;
  level._zombie_gamemodemain = &onstartgametype;
}

onprecachegametype() {
  println("<dev string:x38>");
}

onstartgametype() {
  println("<dev string:x5b>");
}