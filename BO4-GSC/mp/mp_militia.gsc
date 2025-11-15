/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_militia.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\mp\mp_militia_fx;
#include scripts\mp\mp_militia_scripted;
#include scripts\mp\mp_militia_sound;
#include scripts\mp_common\load;
#include scripts\mp_common\util;

#namespace mp_militia;

event_handler[level_init] main(eventstruct) {
  mp_militia_fx::main();
  mp_militia_sound::main();
  load::main();
  level.cleandepositpoints = array((0, 0, -122), (2344, -64, 9.5), (-1464, -2040, 157), (-940, 488, 4), (186.5, -1688, 65));
  compass::setupminimap("");
}