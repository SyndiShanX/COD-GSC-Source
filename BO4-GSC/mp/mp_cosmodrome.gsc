/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_cosmodrome.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\mp_common\load;

#namespace mp_cosmodrome;

event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
}