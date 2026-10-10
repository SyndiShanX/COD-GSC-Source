/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\obj_capture.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_util;
#namespace obj_capture;

function init() {
  settings = spawnStruct();
  settings.pickuptime = 0.5;
  settings.usetextfriendly = &"MP/RETURNING_FLAG";
  settings.usetextenemy = &"MP/GRABBING_FLAG";
  settings.onpickupfn = &onobjectpickup;
  settings.ondropfn = &onobjectdrop;
  settings.onresetfn = &onobjectreset;
  settings.ondelivered = &onobjectdelivered;
  settings.pickupicon = "waypoint_capture_take";
  settings.delivertime = 0.5;
  level.objectivesettings["ctf"] = settings;
}

function createcaptureobjective(objectname, team, settings) {
  if(!isDefined(settings)) {
    settings = level.objectivesettings["ctf"];
  }

  carryobj = createcarryobject(objectname, team, settings);
  goal = creategoal(carryobj.visuals[0].target, carryobj, team, settings);
  carryobj.goal = goal;
}

function createcarryobject(objectname, team, settings) {
  objectvisuals = getEnt(objectname, "targetname");

  if(!isDefined(objectvisuals)) {
    error("No model named " + objectname + " found!");
    return;
  }

  trigger = spawn("trigger_radius", objectvisuals.origin, 0, 96, 120);
  object = scripts\mp\gameobjects::createcarryobject(team, trigger, [objectvisuals], (0, 0, 85));
  object scripts\mp\gameobjects::setteamusetime("friendly", settings.pickuptime);
  object scripts\mp\gameobjects::setteamusetime("enemy", settings.pickuptime);
  object scripts\mp\gameobjects::setteamusetext("enemy", settings.usetextfriendly);
  object scripts\mp\gameobjects::setteamusetext("friendly", settings.usetextenemy);
  object scripts\mp\gameobjects::allowcarry("enemy");
  object scripts\mp\gameobjects::setobjectivestatusicons(settings.pickupicon, settings.pickupicon);
  object scripts\mp\gameobjects::setvisibleteam("enemy");
  object.objidpingfriendly = 1;
  object.allowweapons = 1;
  object.onpickup = settings.onpickupfn;
  object.onpickupfailed = settings.onpickupfailfn;
  object.ondrop = settings.ondropfn;
  object.onreset = settings.onresetfn;
  object.settings = settings;

  if(!isDefined(settings.carrymodel)) {
    settings.carrymodel = objectvisuals.model;
  }

  object setnodeploy(1);
  object setnonstick(1);
  return object;
}

function creategoal(goalname, var_c07321ac837070b6, team, settings) {
  goaltrigger = getEnt(goalname, "targetname");

  if(!isDefined(goaltrigger)) {
    error("No goal trigger named " + goaltrigger + " found!");
    return;
  }

  goal = scripts\mp\gameobjects::createuseobject(team, goaltrigger, [], (0, 0, 85));
  goal scripts\mp\gameobjects::allowuse("enemy");
  goal scripts\mp\gameobjects::setvisibleteam("any");
  goal scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend", "waypoint_blitz_goal");
  goal scripts\mp\gameobjects::setusetime(settings.delivertime);
  goal scripts\mp\gameobjects::setkeyobject(var_c07321ac837070b6);
  goal.onuse = settings.ondelivered;
  goal.settings = settings;
  return goal;
}

function onobjectpickup(player, playervo, defused) {
  if(player.team == scripts\mp\gameobjects::getownerteam()) {
    scripts\mp\gameobjects::returnhome();
    return;
  }

  player attachobjecttocarrier(self.settings.carrymodel);
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_capture_kill", "waypoint_escort");
}

function onobjectdrop(player) {
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_capture_recover", "waypoint_capture_take");
}

function returnaftertime() {
  if(!isDefined(self.settings.returntime)) {
    return;
  }

  self endon("picked_up");
  wait self.settings.returntime;
  scripts\mp\gameobjects::returnhome();
}

function onobjectreset() {}

function onobjectdelivered(player) {
  self.keyobject scripts\mp\gameobjects::allowcarry("none");
  self.keyobject scripts\mp\gameobjects::setvisibleteam("none");
  player detachobjectifcarried();
  scripts\mp\gameobjects::deleteuseobject();
}

function attachobjecttocarrier(objectmodelname) {
  self attach(objectmodelname, "tag_stowed_back3", 1);
  self.carriedobject = objectmodelname;
}

function detachobjectifcarried() {
  if(isDefined(self.carriedobject)) {
    self detach(self.carriedobject, "tag_stowed_back3");
    self.carriedobject = undefined;
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  detachobjectifcarried();
}