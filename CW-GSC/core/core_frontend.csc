/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core\core_frontend.csc
***********************************************/

#using scripts\core\core_frontend_fx;
#using scripts\core\core_frontend_sound;
#using scripts\core_common\util_shared;
#namespace core_frontend;

function event_handler[level_init] main(eventstruct) {
  core_frontend_fx::main();
  core_frontend_sound::main();
  setDvar(#"hash_59cffccc9729732f", -40);
  setDvar(#"hash_7633a587d5705d08", 0);
  setDvar(#"hash_3fe46a1700f8faf6", 0);
  setDvar(#"hash_2846dae927ae532d", 0);
  setDvar(#"hash_62e47f24921bf7ce", 0);
  util::waitforclient(0);
}