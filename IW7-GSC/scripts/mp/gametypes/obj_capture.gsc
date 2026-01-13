/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_capture.gsc
************************************************/

init() {
  var_0 = spawnStruct();
  var_0.pickuptime = 0.5;
  var_0.usetextfriendly = &"MP_RETURNING_FLAG";
  var_0.usetextenemy = &"MP_GRABBING_FLAG";
  var_0.onpickupfn = ::onobjectpickup;
  var_0.ondropfn = ::onobjectdrop;
  var_0.onresetfn = ::onobjectreset;
  var_0.ondelivered = ::onobjectdelivered;
  var_0.pickupicon = "waypoint_capture_take";
  var_0.delivertime = 0.5;
  level.objectivesettings["ctf"] = var_0;
}

createcaptureobjective(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level.objectivesettings["ctf"];
  }

  var_3 = createcarryobject(var_0, var_1, var_2);
  var_4 = creategoal(var_3.visuals[0].target, var_3, var_1, var_2);
  var_3.objective_icon = var_4;
}

createcarryobject(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");
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
  var_5 scripts\mp\gameobjects::set2dicon("enemy", var_2.pickupicon);
  var_5 scripts\mp\gameobjects::set3dicon("enemy", var_2.pickupicon);
  var_5 scripts\mp\gameobjects::setvisibleteam("enemy");
  var_5.objidpingenemy = 1;
  var_5.allowweapons = 1;
  var_5.onpickup = var_2.onpickupfn;
  var_5.onpickupfailed = var_2.onpickupfailfn;
  var_5.ondrop = var_2.ondropfn;
  var_5.onreset = var_2.onresetfn;
  var_5.settings = var_2;
  if(!isDefined(var_2.carrymodel)) {
    var_2.carrymodel = var_3.model;
  }

  var_5 give_player_tickets(1);
  var_5 setnonstick(1);
  return var_5;
}

creategoal(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_0, "targetname");
  if(!isDefined(var_4)) {
    scripts\engine\utility::error("No goal trigger named " + var_4 + " found!");
    return;
  }

  var_5 = scripts\mp\gameobjects::createuseobject(var_2, var_4, [], (0, 0, 85));
  var_5 scripts\mp\gameobjects::allowuse("enemy");
  var_5 scripts\mp\gameobjects::setvisibleteam("any");
  var_5 scripts\mp\gameobjects::set2dicon("friendly", "waypoint_blitz_defend");
  var_5 scripts\mp\gameobjects::set3dicon("friendly", "waypoint_blitz_defend");
  var_5 scripts\mp\gameobjects::set2dicon("enemy", "waypoint_blitz_goal");
  var_5 scripts\mp\gameobjects::set3dicon("enemy", "waypoint_blitz_goal");
  var_5 scripts\mp\gameobjects::setusetime(var_3.delivertime);
  var_5 scripts\mp\gameobjects::setkeyobject(var_1);
  var_5.onuse = var_3.ondelivered;
  var_5.settings = var_3;
  return var_5;
}

onobjectpickup(var_0) {
  if(var_0.team == scripts\mp\gameobjects::getownerteam()) {
    scripts\mp\gameobjects::returnobjectiveid();
    return;
  }

  var_0 attachobjecttocarrier(self.settings.carrymodel);
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_capture_kill");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_capture_kill");
  scripts\mp\gameobjects::set2dicon("enemy", "waypoint_escort");
  scripts\mp\gameobjects::set3dicon("enemy", "waypoint_escort");
}

onobjectdrop(var_0) {
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_capture_recover");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_capture_recover");
  scripts\mp\gameobjects::set2dicon("enemy", "waypoint_capture_take");
  scripts\mp\gameobjects::set3dicon("enemy", "waypoint_capture_take");
}

returnaftertime() {
  if(!isDefined(self.settings.returntime)) {
    return;
  }

  self endon("picked_up");
  wait(self.settings.returntime);
  scripts\mp\gameobjects::returnobjectiveid();
}

onobjectreset() {}

onobjectdelivered(var_0) {
  self.keyobject scripts\mp\gameobjects::allowcarry("none");
  self.keyobject scripts\mp\gameobjects::setvisibleteam("none");
  var_0 detachobjectifcarried();
  scripts\mp\gameobjects::deleteuseobject();
}

attachobjecttocarrier(var_0) {
  self attach(var_0, "j_spine4", 1);
  self.carriedobject = var_0;
}

detachobjectifcarried() {
  if(isDefined(self.carriedobject)) {
    self detach(self.carriedobject, "j_spine4");
    self.carriedobject = undefined;
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  detachobjectifcarried();
}