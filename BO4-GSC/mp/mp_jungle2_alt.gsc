/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_jungle2_alt.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\mp_common\load;

#namespace mp_jungle2_alt;

event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
}