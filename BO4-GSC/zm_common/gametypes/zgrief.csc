/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\zgrief.csc
***********************************************/

#include scripts\core_common\struct;

#namespace zgrief;

event_handler[gametype_init] main(eventstruct) {
  level._zombie_gamemodeprecache = &onprecachegametype;
  level._zombie_gamemodemain = &onstartgametype;
  println("<dev string:x38>");
}

onprecachegametype() {
  println("<dev string:x54>");
}

onstartgametype() {
  println("<dev string:x74>");
}