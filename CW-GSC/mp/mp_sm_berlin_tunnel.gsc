/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_sm_berlin_tunnel.gsc
***********************************************/

#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#namespace mp_sm_berlin_tunnel;

function event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
  setDvar(#"hash_7b06b8037c26b99b", 147);
}