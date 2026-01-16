/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\userspawnselection.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace userspawnselection;

autoexec __init__system__() {
  system::register(#"userspawnselection", &__init__, undefined, undefined);
}

__init__() {
  level.next_spawngroup_index = 0;
  level.spawngroups = [];
  level.useteamspecificforwardspawns = getgametypesetting(#"forwardspawnteamspecificspawns");
  callback::on_finalize_initialization(&setupspawngroups);
  setupuimodels();
  setupclientfields();
}

private getdatamodelprefix(id) {
  return "spawngroupStatus." + id + ".";
}

setupclientfields() {
  for(index = 0; index < 20; index++) {
    basename = getdatamodelprefix(index);
    clientfield::register("worlduimodel", basename + "visStatus", 1, 1, "int", undefined, 0, 1);
    clientfield::register("worlduimodel", basename + "useStatus", 1, 1, "int", undefined, 0, 1);
    clientfield::register("worlduimodel", basename + "team", 1, 2, "int", undefined, 0, 1);
  }

  clientfield::register("clientuimodel", "hudItems.showSpawnSelect", 1, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "hudItems.killcamActive", 1, 1, "int", undefined, 0, 0);
  clientfield::register("worlduimodel", "hideautospawnoption", 1, 1, "int", undefined, 0, 0);
}

setupuimodels() {
  for(index = 0; index < 20; index++) {
    spawngroupprefix = getdatamodelprefix(index);
    createuimodel(getglobaluimodel(), spawngroupprefix + "regionName");
    createuimodel(getglobaluimodel(), spawngroupprefix + "origin.x");
    createuimodel(getglobaluimodel(), spawngroupprefix + "origin.y");
    createuimodel(getglobaluimodel(), spawngroupprefix + "origin.z");
    createuimodel(getglobaluimodel(), spawngroupprefix + "team");
  }
}

private setupstaticmodelfieldsforspawngroup(spawngroup) {
  basename = getdatamodelprefix(spawngroup.uiindex);
  namemodel = getuimodel(getglobaluimodel(), basename + "regionName");
  spawngroupname = "";

  if(isDefined(spawngroup.ui_label)) {
    spawngroupname = spawngroup.ui_label;
  }

  setuimodelvalue(namemodel, spawngroupname);
  teammodel = getuimodel(getglobaluimodel(), basename + "team");
  setuimodelvalue(teammodel, spawngroup.script_team);
  xmodel = getuimodel(getglobaluimodel(), basename + "origin.x");
  setuimodelvalue(xmodel, spawngroup.origin[0]);
  ymodel = getuimodel(getglobaluimodel(), basename + "origin.y");
  setuimodelvalue(ymodel, spawngroup.origin[1]);
  zmodel = getuimodel(getglobaluimodel(), basename + "origin.z");
  setuimodelvalue(zmodel, spawngroup.origin[2]);
}

function_bc7ec9a1(spawngroup) {
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

setupspawngroup(spawngroup) {
  spawngroup.uiindex = level.next_spawngroup_index;
  level.next_spawngroup_index++;
  level.spawngroups[spawngroup.uiindex] = spawngroup;
  function_bc7ec9a1(spawngroup);
  setupstaticmodelfieldsforspawngroup(spawngroup);
}

setupspawngroups(localclientnum) {
  spawngroups = struct::get_array("spawn_group_marker", "targetname");

  if(!isDefined(spawngroups)) {
    return;
  }

  spawngroupssorted = array::get_all_closest((0, 0, 0), spawngroups);

  foreach(spawngroup in spawngroupssorted) {
    setupspawngroup(spawngroup);
  }
}