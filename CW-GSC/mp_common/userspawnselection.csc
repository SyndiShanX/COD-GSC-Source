/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\userspawnselection.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace userspawnselection;

function private autoexec __init__system__() {
  system::register(#"userspawnselection", &preinit, undefined, &setupspawngroups, undefined);
}

function private preinit() {
  level.next_spawngroup_index = 0;
  level.spawngroups = [];
  level.useteamspecificforwardspawns = getgametypesetting(#"forwardspawnteamspecificspawns");
  setupclientfields();
}

function setupclientfields() {
  for(index = 0; index < 20; index++) {
    basename = "spawngroupStatus_" + index + "_";
    clientfield::function_5b7d846d(basename + "visStatus", #"hash_5e10ae8c08eeb04b", [hash(isDefined(index) ? "" + index : ""), #"visstatus"], 1, 1, "int", undefined, 0, 1);
    clientfield::function_5b7d846d(basename + "useStatus", #"hash_5e10ae8c08eeb04b", [hash(isDefined(index) ? "" + index : ""), #"usestatus"], 1, 1, "int", undefined, 0, 1);
    clientfield::function_5b7d846d(basename + "team", #"hash_5e10ae8c08eeb04b", [hash(isDefined(index) ? "" + index : ""), #"team"], 1, 2, "int", undefined, 0, 1);
  }

  clientfield::register_clientuimodel("hudItems.showSpawnSelect", #"hud_items", #"showspawnselect", 1, 1, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.killcamActive", #"hud_items", #"killcamactive", 1, 1, "int", undefined, 0, 0);
  clientfield::function_5b7d846d("hideautospawnoption", #"hash_5e10ae8c08eeb04b", #"hideautospawnoption", 1, 1, "int", undefined, 0, 0);
}

function private setupstaticmodelfieldsforspawngroup(spawngroup) {
  basemodel = getuimodel(function_5f72e972(#"hash_5e10ae8c08eeb04b"), isDefined(spawngroup.uiindex) ? "" + spawngroup.uiindex : "");
  spawngroupname = "";

  if(isDefined(spawngroup.ui_label)) {
    spawngroupname = spawngroup.ui_label;
  }

  setuimodelvalue(getuimodel(basemodel, "regionName"), spawngroupname);
  setuimodelvalue(getuimodel(basemodel, "team"), spawngroup.script_team);
  var_1de19812 = getuimodel(basemodel, "origin");
  setuimodelvalue(getuimodel(var_1de19812, "x"), spawngroup.origin[0]);
  setuimodelvalue(getuimodel(var_1de19812, "y"), spawngroup.origin[1]);
  setuimodelvalue(getuimodel(var_1de19812, "z"), spawngroup.origin[2]);
}

function function_bc7ec9a1(spawngroup) {
  spawns = struct::get_array(spawngroup.target, "groupname");
  var_164af2a6 = 0;
  var_98dd92c = 0;
  var_fbc43d99 = 0;
  var_4f210458 = 0;

  foreach(spawn in spawns) {
    var_164af2a6 += spawn.origin.x;
    var_98dd92c += spawn.origin.y;
    var_fbc43d99 += spawn.origin.z;
  }

  return var_98dd92c;
}

function setupspawngroup(spawngroup) {
  spawngroup.uiindex = level.next_spawngroup_index;
  level.next_spawngroup_index++;
  level.spawngroups[spawngroup.uiindex] = spawngroup;
  function_bc7ec9a1(spawngroup);
  setupstaticmodelfieldsforspawngroup(spawngroup);
}

function setupspawngroups(localclientnum) {
  spawngroups = struct::get_array("spawn_group_marker", "targetname");

  if(!isDefined(spawngroups)) {
    return;
  }

  spawngroupssorted = array::get_all_closest((0, 0, 0), spawngroups);

  foreach(spawngroup in spawngroupssorted) {
    setupspawngroup(spawngroup);
  }
}