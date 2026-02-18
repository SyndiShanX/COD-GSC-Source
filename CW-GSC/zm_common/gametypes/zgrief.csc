/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\zgrief.csc
***********************************************/

#using scripts\core_common\struct;
#namespace zgrief;

function event_handler[gametype_init] main(eventstruct) {
  level._zombie_gamemodeprecache = &onprecachegametype;
  level._zombie_gamemodemain = &onstartgametype;
  println("<dev string:x38>");
}

function onprecachegametype() {
  println("<dev string:x55>");
}

function onstartgametype() {
  println("<dev string:x76>");
}