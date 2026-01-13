/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_grindzone.gsc
**************************************************/

init() {
  setuphudelements();
}

setuphudelements() {
  level.iconneutral3d = "waypoint_bank";
  level.iconneutral2d = "waypoint_bank";
  level.iconcapture3d = "waypoint_scoring_foe";
  level.iconcapture2d = "waypoint_scoring_foe";
  level.icondefend3d = "waypoint_scoring_friend";
  level.icondefend2d = "waypoint_scoring_friend";
  level.iconenemycontested3d = "waypoint_contested";
  level.iconenemycontested2d = "waypoint_contested";
  level.iconfriendlycontested2d = "waypoint_contested";
  level.iconfriendlycontested3d = "waypoint_contested";
}

setupobjective(var_0) {
  var_1 = level.objectives[var_0];
  if(isDefined(var_1.target)) {
    var_2[0] = getent(var_1.target, "targetname");
  } else {
    var_0[0] = spawn("script_model", var_2.origin);
    var_2[0].angles = var_1.angles;
  }

  var_3 = spawn("trigger_radius", var_1.origin, 0, 90, 128);
  var_3.script_label = var_1.script_label;
  var_1 = var_3;
  var_4 = scripts\mp\gameobjects::createuseobject("neutral", var_1, var_2, (0, 0, 90));
  var_4 scripts\mp\gameobjects::allowuse("enemy");
  var_4 scripts\mp\gameobjects::setusetime(level.bankcapturetime);
  var_4 scripts\mp\gameobjects::setvisibleteam("any");
  var_4 scripts\mp\gameobjects::cancontestclaim(1);
  var_4 scripts\mp\gameobjects::mustmaintainclaim(1);
  var_4 scripts\mp\gameobjects::setusetext(&"MP_SECURING_POSITION");
  var_5 = var_4 scripts\mp\gameobjects::getlabel();
  var_4.label = var_5;
  var_4.onbeginuse = ::zone_onusebegin;
  var_4.onuseupdate = ::zone_onuseupdate;
  var_4.onenduse = ::zone_onuseend;
  var_4.onuse = ::zone_onuse;
  var_4.onunoccupied = ::zone_onunoccupied;
  var_4.oncontested = ::zone_oncontested;
  var_4.onuncontested = ::zone_onuncontested;
  var_4.id = "domFlag";
  var_4.claimgracetime = level.bankcapturetime * 1000;
  var_6 = var_2[0].origin + (0, 0, 32);
  var_7 = var_2[0].origin + (0, 0, -32);
  var_8 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_9 = [];
  var_0A = scripts\common\trace::ray_trace(var_6, var_7, var_9, var_8);
  var_4.baseeffectpos = var_0A["position"];
  var_0B = vectortoangles(var_0A["normal"]);
  var_4.baseeffectforward = anglesToForward(var_0B);
  var_0C = spawn("script_model", var_4.baseeffectpos);
  var_0C setModel("grind_flag_scriptable");
  var_0C.angles = generateaxisanglesfromforwardvector(var_4.baseeffectforward, var_0C.angles);
  var_4.physics_capsulecast = var_0C;
  var_4 scripts\engine\utility::delaythread(1, ::setneutral);
  return var_4;
}

setneutral() {
  scripts\mp\gameobjects::setownerteam("neutral");
  setneutralicons();
  updateflagstate("idle", 0);
}

zone_onusebegin(var_0) {
  self.didstatusnotify = 0;
  thread scripts\mp\gameobjects::useobjectdecay(var_0.team);
}

zone_onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();
  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(!isagent(var_3)) {
      updateflagcapturestate(var_0);
    }

    self.didstatusnotify = 1;
  }
}

zone_onuseend(var_0, var_1, var_2) {
  var_3 = scripts\mp\gameobjects::getownerteam();
  if(var_3 == "neutral") {
    setneutralicons();
    updateflagstate("idle", 0);
    return;
  }

  setteamicons();
  updateflagstate(var_3, 0);
}

zone_onuse(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = scripts\mp\utility::getotherteam(var_1);
  var_4 = gettime();
  setteamicons();
  updateflagstate(var_1, 0);
  scripts\mp\gameobjects::setownerteam(var_1);
}

zone_onunoccupied() {
  setneutralicons();
  setneutral();
}

zone_oncontested() {
  setcontestedicons();
  updateflagstate("contested", 0);
}

zone_onuncontested(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  if(var_0 == "none" || var_1 == "neutral") {
    setneutralicons();
  } else {
    setteamicons();
  }

  var_2 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  updateflagstate(var_2, 0);
}

setcrankedtimerzonecap(var_0) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked) {
    var_0 scripts\mp\utility::setcrankedplayerbombtimer("assist");
  }
}

setneutralicons() {
  scripts\mp\gameobjects::set2dicon("friendly", level.iconneutral2d + self.label);
  scripts\mp\gameobjects::set3dicon("friendly", level.iconneutral3d + self.label);
  scripts\mp\gameobjects::set2dicon("enemy", level.iconneutral2d + self.label);
  scripts\mp\gameobjects::set3dicon("enemy", level.iconneutral3d + self.label);
}

setteamicons() {
  scripts\mp\gameobjects::set2dicon("friendly", level.icondefend2d + self.label);
  scripts\mp\gameobjects::set3dicon("friendly", level.icondefend3d + self.label);
  scripts\mp\gameobjects::set2dicon("enemy", level.iconcapture2d + self.label);
  scripts\mp\gameobjects::set3dicon("enemy", level.iconcapture3d + self.label);
}

setcontestedicons() {
  scripts\mp\gameobjects::set2dicon("friendly", level.iconfriendlycontested2d + self.label);
  scripts\mp\gameobjects::set3dicon("friendly", level.iconfriendlycontested3d + self.label);
  scripts\mp\gameobjects::set2dicon("enemy", level.iconenemycontested2d + self.label);
  scripts\mp\gameobjects::set3dicon("enemy", level.iconenemycontested3d + self.label);
}

updateflagstate(var_0, var_1) {
  self.physics_capsulecast setscriptablepartstate("flag", var_0);
  if(!scripts\mp\utility::istrue(var_1)) {
    self.physics_capsulecast setscriptablepartstate("pulse", "off");
  }
}

updateflagcapturestate(var_0) {
  self.physics_capsulecast setscriptablepartstate("pulse", var_0);
}