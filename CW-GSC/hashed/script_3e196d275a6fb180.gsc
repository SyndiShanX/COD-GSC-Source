/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3e196d275a6fb180.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_7d712f77ab8d0c16;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;
#using scripts\core_common\util_shared;
#namespace spawning;

function function_f210e027() {
  level.spawnentitytypes = [];
  array::add(level.spawnentitytypes, {
    #team: "all", #entityname: "mp_t8_spawn_point", #spawntype: 1, #group_index: 0
  });

  if(level.gametype === # "dom") {
    array::add(level.spawnentitytypes, {
      #team: # "allies", #entityname: "mp_t8_spawn_point", #spawntype: 1, #group_index: 1
    });
    array::add(level.spawnentitytypes, {
      #team: # "axis", #entityname: "mp_t8_spawn_point", #spawntype: 1, #group_index: 2
    });
  }

  array::add(level.spawnentitytypes, {
    #team: # "allies", #entityname: "mp_t8_spawn_point_allies", #spawntype: 1, #group_index: 1
  });
  array::add(level.spawnentitytypes, {
    #team: # "axis", #entityname: "mp_t8_spawn_point_axis", #spawntype: 1, #group_index: 2
  });
  array::add(level.spawnentitytypes, {
    #team: # "axis", #entityname: "mp_tdm_spawn_axis_start", #spawntype: 0, #group_index: 2, #isstartspawn: 1
  });
  array::add(level.spawnentitytypes, {
    #team: # "allies", #entityname: "mp_tdm_spawn_allies_start", #spawntype: 0, #group_index: 1, #isstartspawn: 1
  });
  array::add(level.spawnentitytypes, {
    #team: # "axis", #entityname: "mp_tdm_spawn", #spawntype: 0, #group_index: 0, #isstartspawn: 0
  });
}

function function_361ca7c0(var_a824fb90) {
  if(function_5abfedf7("auto_normal")) {
    return;
  }

  rawspawns = struct::get_array(var_a824fb90.entityname, "targetname");

  foreach(spawn in rawspawns) {
    spawn.group_index = var_a824fb90.group_index;
    spawn.tdm = 1;
    spawn._human_were = isDefined(var_a824fb90.isstartspawn) ? var_a824fb90.isstartspawn : 0;
  }

  function_beae80f9(rawspawns);
}

function function_ce9f81ee(var_4a1d0f50) {
  if(function_5abfedf7("auto_normal")) {
    return;
  }

  rawspawns = struct::get_array(var_4a1d0f50.entityname, "targetname");

  foreach(spawn in rawspawns) {
    spawn.group_index = var_4a1d0f50.group_index;
  }

  function_beae80f9(rawspawns);
}

function function_100e84f() {
  if(!isDefined(level.spawnentitytypes)) {
    level.spawnentitytypes = [];
  }

  foreach(spawnentitytype in level.spawnentitytypes) {
    switch (spawnentitytype.spawntype) {
      case 0:
        function_361ca7c0(spawnentitytype);
        break;
      case 1:
        function_ce9f81ee(spawnentitytype);
        break;
      default:
        break;
    }
  }
}

function function_d400d613(targetname, typesarray) {
  returnarray = [];
  rawspawns = struct::get_array(targetname, "targetname");
  rawspawns = function_b404fc61(rawspawns);

  foreach(spawn in rawspawns) {
    foreach(supportedspawntype in typesarray) {
      if(!function_82ca1565(spawn, supportedspawntype)) {
        continue;
      }

      if(oob::chr_party(spawn.origin) && territory::is_inside(spawn.origin)) {
        break;
      }

      if(!isDefined(returnarray[supportedspawntype])) {
        returnarray[supportedspawntype] = [];
      }

      if(!isDefined(returnarray[supportedspawntype])) {
        returnarray[supportedspawntype] = [];
      } else if(!isarray(returnarray[supportedspawntype])) {
        returnarray[supportedspawntype] = array(returnarray[supportedspawntype]);
      }

      returnarray[supportedspawntype][returnarray[supportedspawntype].size] = spawn;
    }
  }

  return returnarray;
}