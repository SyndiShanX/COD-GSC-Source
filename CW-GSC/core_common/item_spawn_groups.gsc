/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\item_spawn_groups.gsc
***********************************************/

#using script_340a2e805e35f7a2;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_world_util;
#using scripts\core_common\struct;
#namespace item_spawn_group;

function setup(seedvalue) {
  if(!item_world_util::use_item_spawns()) {
    return;
  }

  function_1f4464c0(seedvalue);
  println("<dev string:x38>" + seedvalue);
  namespace_65181344::setup_groups();
}