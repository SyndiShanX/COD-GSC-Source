/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_icebreaker.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\mp\mp_icebreaker_scripted;
#include scripts\mp\mp_icebreaker_water;
#include scripts\mp_common\load;

#namespace mp_icebreaker;

event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((-5496, 1162, 31), (-3125, 480, 203), (-3672, 3056, -16.5), (-3784, -560, 127), (-5176, 2736, 12.75));
}