/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_grindzone.gsc
**************************************************/

function init() {
  setuphudelements();
}

function setuphudelements() {
  level.iconneutral = "waypoint_bank_";
  level.iconcapture = "waypoint_scoring_foe_";
  level.icondefend = "waypoint_scoring_friend_";
  level.iconenemycontested = "waypoint_contested_";
  level.iconfriendlycontested = "waypoint_contested_";
}

function setupobjective(var_0, var_1, var_2) {
  var_3 = spawn("trigger_radius", var_0.origin, 0, 90, 128);
  var_3.script_label = var_0.script_label;
  var_0 = var_3;
  GscBinSkip1(0x45, 0, spawn("script_model", var_0.origin));
}

function ref_14395(var_0) {
  scripts\mp\flags::gameflagwait("prematch_done");
  playFX(level.spawnoffsettacinsertmax["blood_floor_hw"], getgroundposition(var_0.trigger.origin, 4) + (0, 0, 2));
}

function ref_1317d() {
  self.onbeginuse = &zone_onusebegin;
  self.onuseupdate = &zone_onuseupdate;
  self.onenduse = &zone_onuseend;
  self.onuse = &zone_onuse;
  self.onunoccupied = &zone_onunoccupied;
  self.oncontested = &zone_oncontested;
  self.onuncontested = &zone_onuncontested;
  self.id = "domFlag";
  scripts\mp\gameobjects::pinobjiconontriggertouch();
  self.claimgracetime = level.bankcapturetime * 1000;
  self.scriptable = setupscriptablevisuals(self.visuals[0].origin, self);
}

function getreservedobjid(var_0) {
  if(var_0 == "a") {
    var_1 = 0;
  } else {
    var_1 = 1;
  }

  return var_1;
}

function setupscriptablevisuals(var_0, var_1) {
  var_2 = var_0 + (0, 0, 32);
  var_3 = var_0 + (0, 0, -32);
  var_4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_5 = [];
  var_6 = scripts\engine\trace::ray_trace(var_2, var_3, var_5, var_4);
  var_1.baseeffectpos = var_6["position"];
  var_7 = vectortoangles(var_6["normal"]);
  var_1.baseeffectforward = anglesToForward(var_7);
  var_1.baseeffectpos = player_give_intel_2_ks(var_1);
  var_8 = spawn("script_model", var_1.baseeffectpos);
  var_8 setModel("grind_flag_scriptable");
  var_8.angles = generateaxisanglesfromforwardvector(var_1.baseeffectforward, var_8.angles);
  return var_8;
}

function player_give_intel_2_ks(var_0) {
  var_1 = var_0.baseeffectpos;

  if(level.mapname == "mp_village2") {
    if(var_0.trigger.script_label == "b") {
      var_1 = var_0.baseeffectpos + (0, 0, 10);
    }
  }

  return var_1;
}

function activatezone() {
  self.onbeginuse = undefined;
  self.onuseupdate = undefined;
  self.onenduse = undefined;
  self.onuse = undefined;
  self.onunoccupied = undefined;
  self.oncontested = undefined;
  self.onuncontested = undefined;
}

function deactivatezone() {
  self.onbeginuse = undefined;
  self.onuseupdate = undefined;
  self.onenduse = undefined;
  self.onuse = undefined;
  self.onunoccupied = undefined;
  self.oncontested = undefined;
  self.onuncontested = undefined;
}

function setneutral() {
  scripts\mp\gameobjects::setownerteam("neutral");
  setneutralicons();
  updateflagstate("idle", 0);
}

function zone_onusebegin(var_0) {
  self.didstatusnotify = 0;
  thread scripts\mp\gameobjects::useobjectdecay(var_0.team);
}

function zone_onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(!isagent(var_3)) {
      updateflagcapturestate(var_0);
    }

    self.didstatusnotify = 1;
    return;
  }
}

function zone_onuseend(var_0, var_1, var_2) {
  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "neutral") {
    setneutralicons();
    updateflagstate("idle", 0);
    return;
  }

  setteamicons();
  updateflagstate(var_3, 0);
}

function zone_onuse(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = scripts\mp\utility\game::getotherteam(var_1)[0];
  var_4 = gettime();
  setteamicons();
  updateflagstate(var_1, 0);
  scripts\mp\gameobjects::setownerteam(var_1);
}

function zone_onunoccupied() {
  setneutralicons();
  setneutral();
}

function zone_oncontested() {
  setcontestedicons();
  updateflagstate("contested", 0);
}

function zone_onuncontested(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "none" || var_1 == "neutral") {
    setneutralicons();
  } else {
    setteamicons();
  }

  var_2 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  updateflagstate(var_2, 0);
}

function setcrankedtimerzonecap(var_0) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked) {
    var_0 scripts\mp\cranked::setcrankedplayerbombtimer("assist");
    return;
  }
}

function setneutralicons() {
  if(!isDefined(level.tacopssublevel)) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    return;
  }
}

function setteamicons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function setcontestedicons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconfriendlycontested);
}

function updateflagstate(var_0, var_1) {
  self.scriptable setscriptablepartstate("flag", var_0);

  if(!istrue(var_1)) {
    self.scriptable setscriptablepartstate("pulse", "off");
    return;
  }
}

function updateflagcapturestate(var_0) {
  self.scriptable setscriptablepartstate("pulse", var_0);
}