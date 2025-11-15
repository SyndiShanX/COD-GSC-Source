/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_cairo.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\mp_common\load;

#namespace mp_cairo;

event_handler[level_init] main(eventstruct) {
  load::main();
  level.cleandepositpoints = array((322, -112, 12), (466, -1008, 14), (38, 938, 22), (-1166, 66, 32), (1853, 518, -19));
  compass::setupminimap("");
}