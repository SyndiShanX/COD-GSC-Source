/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_sm_amsterdam.gsc
***********************************************/

#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#namespace mp_sm_amsterdam;

function event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");

  if(getdvarint(#"hash_3c861ebd76fd24eb", 0) != 0) {
    level.var_a0b75cfd = 1;
  }
}