/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core\core_frontend.gsc
***********************************************/

#using scripts\core\core_frontend_fx;
#using scripts\core\core_frontend_sound;
#namespace core_frontend;

function event_handler[level_init] main(eventstruct) {
  precache();
  setmapcenter((0, 0, 0));
  core_frontend_fx::main();
  core_frontend_sound::main();
  world.playerroles = undefined;
  world.var_8c7b4214 = undefined;
}

function precache() {}