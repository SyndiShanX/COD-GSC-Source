/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_sm_vault.gsc
***********************************************/

#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#namespace mp_sm_vault;

function event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
}