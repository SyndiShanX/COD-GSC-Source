/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core\core_frontend.gsc
***********************************************/

#include scripts\core\core_frontend_fx;
#include scripts\core\core_frontend_sound;

#namespace core_frontend;

event_handler[level_init] main(eventstruct) {
  precache();
  setmapcenter((0, 0, 0));
  core_frontend_fx::main();
  core_frontend_sound::main();
  world.playerroles = undefined;
  world.var_8c7b4214 = undefined;
}

function