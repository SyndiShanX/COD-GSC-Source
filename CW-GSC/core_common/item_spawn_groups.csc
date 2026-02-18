/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\item_spawn_groups.csc
***********************************************/

#using script_101d8280497ff416;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_world_util;
#using scripts\core_common\struct;
#namespace item_spawn_group;

function setup(localclientnum, seedvalue) {
  if(!item_world_util::use_item_spawns()) {
    return;
  }

  level.var_8c615e33 = [];
  function_1f4464c0(seedvalue);
  println("<dev string:x38>" + seedvalue);
  namespace_65181344::setup_groups();
}