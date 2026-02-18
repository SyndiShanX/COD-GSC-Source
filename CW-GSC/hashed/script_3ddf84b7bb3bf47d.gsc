/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3ddf84b7bb3bf47d.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#namespace namespace_52c8f34d;

function preinit() {
  if(isDefined(level.var_6b33db60)) {
    return;
  }

  level.var_6b33db60 = 1;
  level clientfield::register("scriptmover", "item_machine_spawn_rob", 1, 1, "int");
}