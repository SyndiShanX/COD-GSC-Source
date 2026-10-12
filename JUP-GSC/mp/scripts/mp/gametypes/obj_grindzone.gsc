/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_grindzone.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\cranked;
#using scripts\mp\gameobjects;
#using scripts\mp\utility\game;
#namespace obj_grindzone;

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

function setupobjective(trigger, var_5ddbc1faed2c56e6, skipobjid) {
  if(isDefined(trigger.objectivekey)) {
    objectivekey = trigger.objectivekey;
  } else {
    objectivekey = trigger.script_label;
  }

  triggerorigin = fixuptriggerorigin(trigger, objectivekey);
  clonetrigger = spawn("trigger_radius", triggerorigin, 0, 90, 128);
  clonetrigger.script_label = trigger.script_label;
  trigger = clonetrigger;
  visuals[0] = spawn("script_model", triggerorigin);
  visuals[0].angles = trigger.angles;

  if(isDefined(trigger.iconname)) {
    iconname = trigger.iconname;
  } else {
    iconname = trigger.script_label;
  }

  if(istrue(var_5ddbc1faed2c56e6)) {
    reservedobjid = getreservedobjid(objectivekey);
  } else {
    reservedobjid = undefined;
  }

  zone = scripts\mp\gameobjects::createuseobject("neutral", trigger, visuals, (0, 0, 90), var_5ddbc1faed2c56e6, skipobjid);
  zone scripts\mp\gameobjects::allowuse("enemy");
  zone scripts\mp\gameobjects::setusetime(level.bankcapturetime);
  zone scripts\mp\gameobjects::cancontestclaim(1);
  zone scripts\mp\gameobjects::mustmaintainclaim(1);
  zone.tagsdeposited = 0;
  zone.disabled = 0;
  zone.objectivekey = objectivekey;
  zone.iconname = iconname;

  if(!istrue(skipobjid)) {
    zone scripts\mp\gameobjects::setvisibleteam("any");
    zone setobjectivecallbacks();
    objective_setlabel(zone.objidnum, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
    zone delaythread(1, &setneutral);
  }

  return zone;
}

function setobjectivecallbacks() {
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

function getreservedobjid(scriptlabel) {
  if(scriptlabel == "a") {
    reservedid = 0;
  } else {
    reservedid = 1;
  }

  return reservedid;
}

function setupscriptablevisuals(visorigin, zone) {
  tracestart = visorigin + (0, 0, 32);
  traceend = visorigin + (0, 0, -32);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
  zone.baseeffectpos = trace["position"];
  zone.baseeffectpos = fixupscriptableorigin(zone);
  upangles = vectortoangles(trace["normal"]);
  modifiedupangles = function_f7666b5e6cba796e(zone, upangles);
  zone.baseeffectforward = anglesToForward(modifiedupangles);
  scriptable = spawn("script_model", zone.baseeffectpos);
  scriptable setModel("grind_flag_scriptable");
  scriptable.angles = generateaxisanglesfromforwardvector(zone.baseeffectforward, scriptable.angles);
  return scriptable;
}

function fixuptriggerorigin(trigger, objectivekey) {
  origin = trigger.origin;

  switch (level.mapname) {
    case #"hash_52f1fb3b7304621d":
      if(objectivekey == "b") {
        origin += (0, 0, -100);
      }

      break;
  }

  return origin;
}

function fixupscriptableorigin(zone) {
  origin = zone.baseeffectpos;

  switch (level.mapname) {
    case #"hash_a62df42a13dad323":
      if(zone.objectivekey == "b") {
        origin += (0, 0, 10);
      }

      break;
    case #"hash_81b84d832a53ee33":
      if(zone.objectivekey == "b") {
        origin += (0, 0, 10);
      }

      break;
  }

  return origin;
}

function function_f7666b5e6cba796e(zone, upangles) {
  angles = upangles;

  switch (level.mapname) {
    case #"hash_81b84d832a53ee33":
      if(zone.objectivekey == "b") {
        angles = (270, 0, 0);
      }

      break;
    case #"hash_52f1fb3b7304621d":
      if(zone.objectivekey == "b") {
        angles = (275, 90, 0);
      }

      break;
    case #"hash_b0aeb2ff7f22592":
      if(zone.objectivekey == "a") {
        angles = (270, 0, 0);
      }

      break;
  }

  return angles;
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

function zone_onusebegin(player) {
  self.didstatusnotify = 0;
  thread scripts\mp\gameobjects::useobjectdecay(player.team);
}

function zone_onuseupdate(team, progress, change, capplayer) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(progress > 0.05 && change && !self.didstatusnotify) {
    if(!isagent(capplayer)) {
      updateflagcapturestate(team);
    }

    self.didstatusnotify = 1;
  }
}

function zone_onuseend(team, player, success) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    setneutralicons();
    updateflagstate("idle", 0);
    return;
  }

  setteamicons();
  updateflagstate(ownerteam, 0);
}

function zone_onuse(player) {
  capture_team = player.team;
  oldteam = scripts\mp\gameobjects::getownerteam();
  otherteam = getotherteam(capture_team)[0];
  capturetime = gettime();
  setteamicons();
  updateflagstate(capture_team, 0);
  scripts\mp\gameobjects::setownerteam(capture_team);
}

function zone_onunoccupied() {
  setneutralicons();
  setneutral();
}

function zone_oncontested() {
  setcontestedicons();
  updateflagstate("contested", 0);
}

function zone_onuncontested(lastclaimteam) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(lastclaimteam == "none" || ownerteam == "neutral") {
    setneutralicons();
  } else {
    setteamicons();
  }

  flagstate = ter_op(ownerteam == "neutral", "idle", ownerteam);
  updateflagstate(flagstate, 0);
}

function setcrankedtimerzonecap(player) {
  if((function_f698bfd3efa33302() || function_e9f3a160bbefe208(player)) && isDefined(player.cranked) && player.cranked) {
    player scripts\mp\cranked::setcrankedplayerbombtimer("assist");
  }
}

function setneutralicons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
}

function setteamicons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function setcontestedicons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconfriendlycontested);
}

function updateflagstate(state, keeppulse) {
  self.scriptable setscriptablepartstate("flag", state);

  if(!istrue(keeppulse)) {
    self.scriptable setscriptablepartstate("pulse", "off");
  }
}

function updateflagcapturestate(state) {
  self.scriptable setscriptablepartstate("pulse", state);
}