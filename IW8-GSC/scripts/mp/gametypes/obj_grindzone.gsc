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

function setupobjective(var0, var1, var2) {
  var3 = spawn("trigger_radius", var0.origin, 0, 90, 128);
  var3.script_label = var0.script_label;
  var0 = var3;
  GscBinSkip1(0x45, 0, spawn("script_model", var0.origin));
}

function ref_14395(var0) {
  scripts\mp\flags::gameflagwait("prematch_done");
  playFX(level.spawnoffsettacinsertmax["blood_floor_hw"], getgroundposition(var0.trigger.origin, 4) + (0, 0, 2));
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

function getreservedobjid(var0) {
  if(var0 == "a") {
    var1 = 0;
  } else {
    var1 = 1;
  }

  return var1;
}

function setupscriptablevisuals(var0, var1) {
  var2 = var0 + (0, 0, 32);
  var3 = var0 + (0, 0, -32);
  var4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var5 = [];
  var6 = scripts\engine\trace::ray_trace(var2, var3, var5, var4);
  var1.baseeffectpos = var6["position"];
  var7 = vectortoangles(var6["normal"]);
  var1.baseeffectforward = anglesToForward(var7);
  var1.baseeffectpos = player_give_intel_2_ks(var1);
  var8 = spawn("script_model", var1.baseeffectpos);
  var8 setModel("grind_flag_scriptable");
  var8.angles = generateaxisanglesfromforwardvector(var1.baseeffectforward, var8.angles);
  return var8;
}

function player_give_intel_2_ks(var0) {
  var1 = var0.baseeffectpos;

  if(level.mapname == "mp_village2") {
    if(var0.trigger.script_label == "b") {
      var1 = var0.baseeffectpos + (0, 0, 10);
    }
  }

  return var1;
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

function zone_onusebegin(var0) {
  self.didstatusnotify = 0;
  thread scripts\mp\gameobjects::useobjectdecay(var0.team);
}

function zone_onuseupdate(var0, var1, var2, var3) {
  var4 = scripts\mp\gameobjects::getownerteam();

  if(var1 > 0.05 && var2 && !self.didstatusnotify) {
    if(!isagent(var3)) {
      updateflagcapturestate(var0);
    }

    self.didstatusnotify = 1;
    return;
  }
}

function zone_onuseend(var0, var1, var2) {
  var3 = scripts\mp\gameobjects::getownerteam();

  if(var3 == "neutral") {
    setneutralicons();
    updateflagstate("idle", 0);
    return;
  }

  setteamicons();
  updateflagstate(var3, 0);
}

function zone_onuse(var0) {
  var1 = var0.team;
  var2 = scripts\mp\gameobjects::getownerteam();
  var3 = scripts\mp\utility\game::getotherteam(var1)[0];
  var4 = gettime();
  setteamicons();
  updateflagstate(var1, 0);
  scripts\mp\gameobjects::setownerteam(var1);
}

function zone_onunoccupied() {
  setneutralicons();
  setneutral();
}

function zone_oncontested() {
  setcontestedicons();
  updateflagstate("contested", 0);
}

function zone_onuncontested(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();

  if(var0 == "none" || var1 == "neutral") {
    setneutralicons();
  } else {
    setteamicons();
  }

  var2 = scripts\engine\utility::ter_op(var1 == "neutral", "idle", var1);
  updateflagstate(var2, 0);
}

function setcrankedtimerzonecap(var0) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var0.cranked) && var0.cranked) {
    var0 scripts\mp\cranked::setcrankedplayerbombtimer("assist");
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

function updateflagstate(var0, var1) {
  self.scriptable setscriptablepartstate("flag", var0);

  if(!istrue(var1)) {
    self.scriptable setscriptablepartstate("pulse", "off");
    return;
  }
}

function updateflagcapturestate(var0) {
  self.scriptable setscriptablepartstate("pulse", var0);
}