/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_capture.gsc
************************************************/

function init() {
  var0 = spawnStruct();
  var0.pickuptime = 0.5;
  var0.usetextfriendly = &"MP/RETURNING_FLAG";
  var0.usetextenemy = &"MP/GRABBING_FLAG";
  var0.onpickupfn = &onobjectpickup;
  var0.ondropfn = &onobjectdrop;
  var0.onresetfn = &onobjectreset;
  var0.ondelivered = &onobjectdelivered;
  var0.pickupicon = "waypoint_capture_take";
  var0.delivertime = 0.5;
  level.objectivesettings["ctf"] = var0;
}

function createcaptureobjective(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = level.objectivesettings["ctf"];
  }

  var3 = createcarryobject(var0, var1, var2);
  var4 = creategoal(var3.visuals[0].target, var3, var1, var2);
  var3.goal = var4;
}

function createcarryobject(var0, var1, var2) {
  var3 = getEnt(var0, "targetname");

  if(!isDefined(var3)) {
    scripts\engine\utility::error("No model named " + var0 + " found!");
    return;
  }

  var4 = spawn("trigger_radius", var3.origin, 0, 96, 120);
  var5 = scripts\mp\gameobjects::createcarryobject(var1, var4, [var3], (0, 0, 85));
  var5 scripts\mp\gameobjects::setteamusetime("friendly", var2.pickuptime);
  var5 scripts\mp\gameobjects::setteamusetime("enemy", var2.pickuptime);
  var5 scripts\mp\gameobjects::setteamusetext("enemy", var2.usetextfriendly);
  var5 scripts\mp\gameobjects::setteamusetext("friendly", var2.usetextenemy);
  var5 scripts\mp\gameobjects::allowcarry("enemy");
  var5 scripts\mp\gameobjects::setobjectivestatusicons(var2.pickupicon, var2.pickupicon);
  var5 scripts\mp\gameobjects::setvisibleteam("enemy");
  var5.objidpingfriendly = 1;
  var5.allowweapons = 1;
  var5.onpickup = var2.onpickupfn;
  var5.onpickupfailed = var2.onpickupfailfn;
  var5.ondrop = var2.ondropfn;
  var5.onreset = var2.onresetfn;
  var5.settings = var2;

  if(!isDefined(var2.carrymodel)) {
    var2.carrymodel = var3.model;
  }

  var5 setnodeploy(1);
  var5 setnonstick(1);
  return var5;
}

function creategoal(var0, var1, var2, var3) {
  var4 = getEnt(var0, "targetname");

  if(!isDefined(var4)) {
    scripts\engine\utility::error("No goal trigger named " + var4 + " found!");
    return;
  }

  var5 = scripts\mp\gameobjects::createuseobject(var2, var4, [], (0, 0, 85));
  var5 scripts\mp\gameobjects::allowuse("enemy");
  var5 scripts\mp\gameobjects::setvisibleteam("any");
  var5 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend", "waypoint_blitz_goal");
  var5 scripts\mp\gameobjects::setusetime(var3.delivertime);
  var5 scripts\mp\gameobjects::setkeyobject(var1);
  var5.onuse = var3.ondelivered;
  var5.settings = var3;
  return var5;
}

function onobjectpickup(var0, var1, var2) {
  if(var0.team == scripts\mp\gameobjects::getownerteam()) {
    scripts\mp\gameobjects::returnhome();
    return;
  }

  attachobjecttocarrier(var0, self.settings.carrymodel);
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_capture_kill", "waypoint_escort");
}

function onobjectdrop(var0) {
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

function onobjectdelivered(var0) {
  self.keyobject scripts\mp\gameobjects::allowcarry("none");
  self.keyobject scripts\mp\gameobjects::setvisibleteam("none");
  detachobjectifcarried(var0);
  scripts\mp\gameobjects::deleteuseobject();
}

function attachobjecttocarrier(var0) {
  self attach(var0, "tag_stowed_back3", 1);
  self.carriedobject = var0;
}

function detachobjectifcarried() {
  if(isDefined(self.carriedobject)) {
    self detach(self.carriedobject, "tag_stowed_back3");
    self.carriedobject = undefined;
    return;
  }
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  detachobjectifcarried();
}