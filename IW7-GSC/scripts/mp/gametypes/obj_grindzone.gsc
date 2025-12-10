/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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

setupobjective(param_00) {
  var_01 = level.objectives[param_00];
  if(isDefined(var_01.target)) {
    var_02[0] = getent(var_01.target, "targetname");
  } else {
    param_00[0] = spawn("script_model", var_02.origin);
    var_02[0].angles = var_01.angles;
  }

  var_03 = spawn("trigger_radius", var_01.origin, 0, 90, 128);
  var_03.script_label = var_01.script_label;
  var_01 = var_03;
  var_04 = scripts\mp\gameobjects::createuseobject("neutral", var_01, var_02, (0, 0, 90));
  var_04 scripts\mp\gameobjects::allowuse("enemy");
  var_04 scripts\mp\gameobjects::setusetime(level.bankcapturetime);
  var_04 scripts\mp\gameobjects::setvisibleteam("any");
  var_04 scripts\mp\gameobjects::cancontestclaim(1);
  var_04 scripts\mp\gameobjects::mustmaintainclaim(1);
  var_04 scripts\mp\gameobjects::setusetext(&"MP_SECURING_POSITION");
  var_05 = var_04 scripts\mp\gameobjects::getlabel();
  var_04.label = var_05;
  var_04.onbeginuse = ::zone_onusebegin;
  var_04.onuseupdate = ::zone_onuseupdate;
  var_04.onenduse = ::zone_onuseend;
  var_04.onuse = ::zone_onuse;
  var_04.onunoccupied = ::zone_onunoccupied;
  var_04.oncontested = ::zone_oncontested;
  var_04.onuncontested = ::zone_onuncontested;
  var_04.id = "domFlag";
  var_04.claimgracetime = level.bankcapturetime * 1000;
  var_06 = var_02[0].origin + (0, 0, 32);
  var_07 = var_02[0].origin + (0, 0, -32);
  var_08 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_09 = [];
  var_0A = scripts\common\trace::ray_trace(var_06, var_07, var_09, var_08);
  var_04.baseeffectpos = var_0A["position"];
  var_0B = vectortoangles(var_0A["normal"]);
  var_04.baseeffectforward = anglesToForward(var_0B);
  var_0C = spawn("script_model", var_04.baseeffectpos);
  var_0C setModel("grind_flag_scriptable");
  var_0C.angles = generateaxisanglesfromforwardvector(var_04.baseeffectforward, var_0C.angles);
  var_04.physics_capsulecast = var_0C;
  var_04 scripts\engine\utility::delaythread(1, ::setneutral);
  return var_04;
}

setneutral() {
  scripts\mp\gameobjects::setownerteam("neutral");
  setneutralicons();
  updateflagstate("idle", 0);
}

zone_onusebegin(param_00) {
  self.didstatusnotify = 0;
  thread scripts\mp\gameobjects::useobjectdecay(param_00.team);
}

zone_onuseupdate(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\gameobjects::getownerteam();
  if(param_01 > 0.05 && param_02 && !self.didstatusnotify) {
    if(!isagent(param_03)) {
      updateflagcapturestate(param_00);
    }

    self.didstatusnotify = 1;
  }
}

zone_onuseend(param_00, param_01, param_02) {
  var_03 = scripts\mp\gameobjects::getownerteam();
  if(var_03 == "neutral") {
    setneutralicons();
    updateflagstate("idle", 0);
    return;
  }

  setteamicons();
  updateflagstate(var_03, 0);
}

zone_onuse(param_00) {
  var_01 = param_00.team;
  var_02 = scripts\mp\gameobjects::getownerteam();
  var_03 = scripts\mp\utility::getotherteam(var_01);
  var_04 = gettime();
  setteamicons();
  updateflagstate(var_01, 0);
  scripts\mp\gameobjects::setownerteam(var_01);
}

zone_onunoccupied() {
  setneutralicons();
  setneutral();
}

zone_oncontested() {
  setcontestedicons();
  updateflagstate("contested", 0);
}

zone_onuncontested(param_00) {
  var_01 = scripts\mp\gameobjects::getownerteam();
  if(param_00 == "none" || var_01 == "neutral") {
    setneutralicons();
  } else {
    setteamicons();
  }

  var_02 = scripts\engine\utility::ter_op(var_01 == "neutral", "idle", var_01);
  updateflagstate(var_02, 0);
}

setcrankedtimerzonecap(param_00) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(param_00.cranked) && param_00.cranked) {
    param_00 scripts\mp\utility::setcrankedplayerbombtimer("assist");
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

updateflagstate(param_00, param_01) {
  self.physics_capsulecast setscriptablepartstate("flag", param_00);
  if(!scripts\mp\utility::istrue(param_01)) {
    self.physics_capsulecast setscriptablepartstate("pulse", "off");
  }
}

updateflagcapturestate(param_00) {
  self.physics_capsulecast setscriptablepartstate("pulse", param_00);
}