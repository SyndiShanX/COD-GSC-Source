/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_jungle2.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\mp\mp_jungle2_scripted;
#include scripts\mp_common\load;

#namespace mp_jungle2;

event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((1820.25, 87.5, 88.25), (2648.75, -1356, 270), (-86.75, -514.5, 264), (438.75, -1640.75, 124), (458.25, 1278.5, 239));
}