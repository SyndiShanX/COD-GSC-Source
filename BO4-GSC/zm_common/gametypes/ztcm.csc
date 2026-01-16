/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\ztcm.csc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;

#namespace ztcm;

event_handler[gametype_init] main(eventstruct) {
  level._zombie_gamemodeprecache = &onprecachegametype;
  level._zombie_gamemodemain = &onstartgametype;

  if(!level flag::exists(#"ztcm")) {
    level flag::init(#"ztcm", 1);
  }

  println("<dev string:x38>");
}

onprecachegametype() {
  println("<dev string:x52>");
}

onstartgametype() {
  println("<dev string:x70>");
}