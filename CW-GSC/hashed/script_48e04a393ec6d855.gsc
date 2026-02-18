/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_48e04a393ec6d855.gsc
***********************************************/

#using scripts\core_common\util_shared;
#namespace namespace_c9c45ed8;

function init() {
  level.doa.dungeons = array({
    #name: "invalid", #var_dd490566: 1, #type: -1
  }, {
    #name: "jungle_1_dungeon1", #locstring: # "hash_3419b70eb1cb87d3", #policy: 0, #type: 0
  }, {
    #name: "jungle_1_dungeon2", #locstring: # "hash_3419b80eb1cb8986", #policy: 0, #type: 1
  }, {
    #name: "jungle_1_dungeon3", #locstring: # "hash_3419b90eb1cb8b39", #policy: 0, #type: 2
  }, {
    #name: "cellar", #locstring: undefined, #policy: 0, #var_dd490566: 1, #type: -1
  }, {
    #name: "jungle_1_dungeon4", #locstring: # "hash_3419ba0eb1cb8cec", #policy: 0, #type: 3
  });
  level.doa.var_dfcf49f8 = 0;

  foreach(dungeon in level.doa.dungeons) {
    if(dungeon.type == -1) {
      continue;
    }

    level.doa.var_dfcf49f8 |= 1 << dungeon.type;
  }

  var_663588d = "<dev string:x38>";

  foreach(dungeon in level.doa.dungeons) {
    if(is_true(dungeon.var_dd490566)) {
      continue;
    }

    name = function_9e72a96(dungeon.name);
    locstr = function_9e72a96(dungeon.locstring);
    cmdline = "<dev string:x4f>" + name + "<dev string:x6a>";
    util::add_devgui(var_663588d + name, cmdline);
  }
}