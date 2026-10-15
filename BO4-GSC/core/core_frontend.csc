/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core\core_frontend.csc
***********************************************/

#include scripts\core\core_frontend_fx;
#include scripts\core\core_frontend_sound;
#include scripts\core_common\util_shared;

#namespace core_frontend;

event_handler[level_init] main(eventstruct) {
  core_frontend_fx::main();
  core_frontend_sound::main();
  util::waitforclient(0);
}