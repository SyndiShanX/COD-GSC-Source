/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_capture.gsc
************************************************/

init() {
  var_00 = spawnStruct();
  var_00.pickuptime = 0.5;
  var_00.usetextfriendly = & "MP_RETURNING_FLAG";
  var_00.usetextenemy = & "MP_GRABBING_FLAG";
  var_00.onpickupfn = ::onobjectpickup;
  var_00.ondropfn = ::onobjectdrop;
  var_00.onresetfn = ::onobjectreset;
  var_00.ondelivered = ::onobjectdelivered;
  var_00.pickupicon = "waypoint_capture_take";
  var_00.delivertime = 0.5;
  level.objectivesettings["ctf"] = var_00;
}

createcaptureobjective(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = level.objectivesettings["ctf"];
  }

  var_03 = createcarryobject(param_00, param_01, param_02);
  var_04 = creategoal(var_03.visuals[0].target, var_03, param_01, param_02);
  var_03.objective_icon = var_04;
}

createcarryobject(param_00, param_01, param_02) {
  var_03 = getent(param_00, "targetname");
  if(!isDefined(var_03)) {
    scripts\engine\utility::error("No model named " + param_00 + " found!");
    return;
  }

  var_04 = spawn("trigger_radius", var_03.origin, 0, 96, 120);
  var_05 = scripts\mp\gameobjects::createcarryobject(param_01, var_04, [var_03], (0, 0, 85));
  var_05 scripts\mp\gameobjects::setteamusetime("friendly", param_02.pickuptime);
  var_05 scripts\mp\gameobjects::setteamusetime("enemy", param_02.pickuptime);
  var_05 scripts\mp\gameobjects::setteamusetext("enemy", param_02.usetextfriendly);
  var_05 scripts\mp\gameobjects::setteamusetext("friendly", param_02.usetextenemy);
  var_05 scripts\mp\gameobjects::allowcarry("enemy");
  var_05 scripts\mp\gameobjects::set2dicon("enemy", param_02.pickupicon);
  var_05 scripts\mp\gameobjects::set3dicon("enemy", param_02.pickupicon);
  var_05 scripts\mp\gameobjects::setvisibleteam("enemy");
  var_05.objidpingenemy = 1;
  var_05.allowweapons = 1;
  var_05.onpickup = param_02.onpickupfn;
  var_05.onpickupfailed = param_02.onpickupfailfn;
  var_05.ondrop = param_02.ondropfn;
  var_05.onreset = param_02.onresetfn;
  var_05.settings = param_02;
  if(!isDefined(param_02.carrymodel)) {
    param_02.carrymodel = var_03.model;
  }

  var_05 give_player_tickets(1);
  var_05 setnonstick(1);
  return var_05;
}

creategoal(param_00, param_01, param_02, param_03) {
  var_04 = getent(param_00, "targetname");
  if(!isDefined(var_04)) {
    scripts\engine\utility::error("No goal trigger named " + var_04 + " found!");
    return;
  }

  var_05 = scripts\mp\gameobjects::createuseobject(param_02, var_04, [], (0, 0, 85));
  var_05 scripts\mp\gameobjects::allowuse("enemy");
  var_05 scripts\mp\gameobjects::setvisibleteam("any");
  var_05 scripts\mp\gameobjects::set2dicon("friendly", "waypoint_blitz_defend");
  var_05 scripts\mp\gameobjects::set3dicon("friendly", "waypoint_blitz_defend");
  var_05 scripts\mp\gameobjects::set2dicon("enemy", "waypoint_blitz_goal");
  var_05 scripts\mp\gameobjects::set3dicon("enemy", "waypoint_blitz_goal");
  var_05 scripts\mp\gameobjects::setusetime(param_03.delivertime);
  var_05 scripts\mp\gameobjects::setkeyobject(param_01);
  var_05.onuse = param_03.ondelivered;
  var_05.settings = param_03;
  return var_05;
}

onobjectpickup(param_00) {
  if(param_00.team == scripts\mp\gameobjects::getownerteam()) {
    scripts\mp\gameobjects::returnobjectiveid();
    return;
  }

  param_00 attachobjecttocarrier(self.settings.carrymodel);
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_capture_kill");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_capture_kill");
  scripts\mp\gameobjects::set2dicon("enemy", "waypoint_escort");
  scripts\mp\gameobjects::set3dicon("enemy", "waypoint_escort");
}

onobjectdrop(param_00) {
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

onobjectdelivered(param_00) {
  self.keyobject scripts\mp\gameobjects::allowcarry("none");
  self.keyobject scripts\mp\gameobjects::setvisibleteam("none");
  param_00 detachobjectifcarried();
  scripts\mp\gameobjects::deleteuseobject();
}

attachobjecttocarrier(param_00) {
  self attach(param_00, "j_spine4", 1);
  self.carriedobject = param_00;
}

detachobjectifcarried() {
  if(isDefined(self.carriedobject)) {
    self detach(self.carriedobject, "j_spine4");
    self.carriedobject = undefined;
  }
}

onplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  detachobjectifcarried();
}