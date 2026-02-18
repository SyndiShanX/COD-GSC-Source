/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\ztutorial.csc
***********************************************/

#namespace ztutorial;

function event_handler[gametype_init] main(eventstruct) {
  level._zombie_gamemodeprecache = &onprecachegametype;
  level._zombie_gamemodemain = &onstartgametype;
}

function onprecachegametype() {
  println("<dev string:x38>");
}

function onstartgametype() {
  println("<dev string:x5c>");
}