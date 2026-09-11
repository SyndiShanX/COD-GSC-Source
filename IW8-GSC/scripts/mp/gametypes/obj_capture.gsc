/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_capture.gsc
************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.pickuptime = 0.5;
  var_0.usetextfriendly = &"MP/RETURNING_FLAG";
  var_0.usetextenemy = &"MP/GRABBING_FLAG";
  var_0.onpickupfn = &onobjectpickup;
  var_0.ondropfn = &onobjectdrop;
  var_0.onresetfn = &onobjectreset;
  var_0.ondelivered = &onobjectdelivered;
  var_0.pickupicon = "waypoint_capture_take";
  var_0.delivertime = 0.5;
  level.objectivesettings["ctf"] = var_0;
}

function createcaptureobjective(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level.objectivesettings["ctf"];
  }

  var_3 = createcarryobject(var_0, var_1, var_2);
  var_4 = creategoal(var_3.visuals[0].target, var_3, var_1, var_2);
  var_3.goal = var_4;
}

function createcarryobject(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "targetname");

  if(!isDefined(var_3)) {
    scripts\engine\utility::error("No model named " + var_0 + " found!");
    return;
  }

  var_4 = spawn("trigger_radius", var_3.origin, 0, 96, 120);
  var_5 = scripts\mp\gameobjects::createcarryobject(var_1, var_4, [var_3], (0, 0, 85));
  var_5 scripts\mp\gameobjects::setteamusetime("friendly", var_2.pickuptime);
  var_5 scripts\mp\gameobjects::setteamusetime("enemy", var_2.pickuptime);
  var_5 scripts\mp\gameobjects::setteamusetext("enemy", var_2.usetextfriendly);
  var_5 scripts\mp\gameobjects::setteamusetext("friendly", var_2.usetextenemy);
  var_5 scripts\mp\gameobjects::allowcarry("enemy");
  var_5 scripts\mp\gameobjects::setobjectivestatusicons(var_2.pickupicon, var_2.pickupicon);
  var_5 scripts\mp\gameobjects::setvisibleteam("enemy");
  var_5.objidpingfriendly = 1;
  var_5.allowweapons = 1;
  var_5.onpickup = var_2.onpickupfn;
  var_5.onpickupfailed = var_2.onpickupfailfn;
  var_5.ondrop = var_2.ondropfn;
  var_5.onreset = var_2.onresetfn;
  var_5.settings = var_2;

  if(!isDefined(var_2.carrymodel)) {
    var_2.carrymodel = var_3.model;
  }

  var_5 setnodeploy(1);
  var_5 setnonstick(1);
  return var_5;
}

function creategoal(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "targetname");

  if(!isDefined(var_4)) {
    scripts\engine\utility::error("No goal trigger named " + var_4 + " found!");
    return;
  }

  var_5 = scripts\mp\gameobjects::createuseobject(var_2, var_4, [], (0, 0, 85));
  var_5 scripts\mp\gameobjects::allowuse("enemy");
  var_5 scripts\mp\gameobjects::setvisibleteam("any");
  var_5 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend", "waypoint_blitz_goal");
  var_5 scripts\mp\gameobjects::setusetime(var_3.delivertime);
  var_5 scripts\mp\gameobjects::setkeyobject(var_1);
  var_5.onuse = var_3.ondelivered;
  var_5.settings = var_3;
  return var_5;
}

function onobjectpickup(var_0, var_1, var_2) {
  if(var_0.team == scripts\mp\gameobjects::getownerteam()) {
    scripts\mp\gameobjects::returnhome();
    return;
  }

  attachobjecttocarrier(var_0, self.settings.carrymodel);
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_capture_kill", "waypoint_escort");
}

function onobjectdrop(var_0) {
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

function onobjectdelivered(var_0) {
  self.keyobject scripts\mp\gameobjects::allowcarry("none");
  self.keyobject scripts\mp\gameobjects::setvisibleteam("none");
  detachobjectifcarried(var_0);
  scripts\mp\gameobjects::deleteuseobject();
}

function attachobjecttocarrier(var_0) {
  self attach(var_0, "tag_stowed_back3", 1);
  self.carriedobject = var_0;
}

function detachobjectifcarried() {
  if(isDefined(self.carriedobject)) {
    self detach(self.carriedobject, "tag_stowed_back3");
    self.carriedobject = undefined;
    return;
  }
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  detachobjectifcarried();
}