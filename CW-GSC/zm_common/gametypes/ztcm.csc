/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\ztcm.csc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#namespace ztcm;

function event_handler[gametype_init] main(eventstruct) {
  level._zombie_gamemodeprecache = &onprecachegametype;
  level._zombie_gamemodemain = &onstartgametype;

  if(!level flag::exists(#"ztcm")) {
    level flag::init(#"ztcm", 1);
  }

  println("<dev string:x38>");
}

function onprecachegametype() {
  println("<dev string:x53>");
}

function onstartgametype() {
  println("<dev string:x72>");
}