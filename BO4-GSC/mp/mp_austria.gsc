/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_austria.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\mp_common\load;

#namespace mp_austria;

event_handler[level_init] main(eventstruct) {
  load::main();
  level.cleandepositpoints = array((4559.63, -24.8538, 605.047), (2901.18, 1641.03, 604.679), (374.35, -695.874, 441.288), (902.805, 655.671, 455.436), (2465.5, 3242.57, 632.493));
  compass::setupminimap("");
}