/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5dfa1fb6b030bdcb.gsc
*************************************************/

#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace namespace_cf4ab64c2f83d096;

function function_8d0bcd24e525ca55() {
  level.var_4b646b4bf1c0cd01 = spawnStruct();
  level.var_4b646b4bf1c0cd01.waypoints = [];
  function_bceadb844cbe69ca();
}

function private function_bceadb844cbe69ca() {
  add_fx("ftue_objectives_waypoint_fx", "vfx/misc/vfx_ftue_ring_01");
}

function function_e5524fb8509827bf(objectiveposition, labeltext, icon, zoffset, owner, showwaypoint) {
  if(!isDefined(objectiveposition)) {
    objectiveposition = (0, 0, 0);
  }

  waypointdata = spawnStruct();
  waypointdata.showwaypoint = istrue(showwaypoint);
  waypointdata.position = objectiveposition;
  waypointdata.owner = owner;
  objectiveid = function_15379e7d5a0b111a(labeltext, icon, zoffset, undefined, owner, waypointdata);
  objective_position(objectiveid, objectiveposition);
  return objectiveid;
}

function function_70e0de6281199e7(objectivetarget, labeltext, icon, zoffset, owner, showwaypoint) {
  waypointdata = spawnStruct();
  waypointdata.showwaypoint = istrue(showwaypoint);
  waypointdata.position = objectivetarget.origin;
  waypointdata.owner = owner;
  team = undefined;

  if(isPlayer(objectivetarget)) {
    team = objectivetarget.team;
  }

  objectiveid = function_15379e7d5a0b111a(labeltext, icon, zoffset, team, owner, waypointdata);
  objective_onentity(objectiveid, objectivetarget);
  objectivetarget.objectiveid = objectiveid;
  return objectiveid;
}

function private function_15379e7d5a0b111a(labeltext, icon, zoffset, team, owner, waypointdata) {
  objectiveid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(objectiveid, "current");
  objective_icon(objectiveid, icon);
  objective_setminimapiconsize(objectiveid, "icon_regular");
  objective_setbackground(objectiveid, 1);
  objective_setshowdistance(objectiveid, !isDefined(team));
  objective_setfadedisabled(objectiveid, 1);

  if(isDefined(labeltext)) {
    objective_setlabel(objectiveid, labeltext);
  }

  objective_setzoffset(objectiveid, zoffset);
  objective_setwidget(objectiveid, "mobileftueobjective");

  if(isDefined(team)) {
    objective_setownerteam(objectiveid, team);
    objective_addalltomask(objectiveid);
  }

  if(isDefined(owner)) {
    objective_removeallfrommask(objectiveid);
    objective_addclienttomask(objectiveid, owner);
    objective_showtoplayersinmask(objectiveid);
    owner thread function_127d9ad4836a083d(objectiveid);
  }

  if(istrue(waypointdata.showwaypoint)) {
    function_f36e91aa37d197c3(objectiveid, waypointdata);
  }

  return objectiveid;
}

function private function_f36e91aa37d197c3(objectiveid, waypointdata) {
  assertex(isDefined(waypointdata.owner), "<dev string:x1c>");
  waypoint = spawnfxforclient(getfx("ftue_objectives_waypoint_fx"), waypointdata.position, waypointdata.owner);
  triggerfx(waypoint);
  level.var_4b646b4bf1c0cd01.waypoints[objectiveid] = waypoint;
}

function function_b30874d13004d4c5(objectivetarget) {
  function_4d03b9ef456d0972(objectivetarget.objectiveid);
}

function function_4d03b9ef456d0972(objectiveid) {
  level notify("ftue_objective_removed_" + objectiveid);
  scripts\mp\objidpoolmanager::returnobjectiveid(objectiveid);
  function_b93e49439785c073(objectiveid);
}

function private function_b93e49439785c073(objectiveid) {
  if(!isDefined(level.var_4b646b4bf1c0cd01.waypoints[objectiveid])) {
    return;
  }

  level.var_4b646b4bf1c0cd01.waypoints[objectiveid] delete();
}

function private function_127d9ad4836a083d(objectiveid) {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  level endon("ftue_objective_removed_" + objectiveid);
  player waittill_any_return_2("currentContextualTipCompleted", "currentContextualTipAborted");
  scripts\mp\objidpoolmanager::returnobjectiveid(objectiveid);
  function_b93e49439785c073(objectiveid);
}