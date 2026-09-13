/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_grindzone.gsc
**************************************************/

init() {
  setuphudelements();
}

setuphudelements() {
  level.iconneutral = "waypoint_bank_";
  level.iconcapture = "waypoint_scoring_foe_";
  level.icondefend = "waypoint_scoring_friend_";
  level.iconenemycontested = "waypoint_contested_";
  level.iconfriendlycontested = "waypoint_contested_";
}

setupobjective(trigger, _id_5DDBC1FAED2C56E6, _id_08B9949739F4E0F6) {
  if(isDefined(trigger.objectivekey))
    objectivekey = trigger.objectivekey;
  else
    objectivekey = trigger.script_label;

  _id_FCFB525DF098DE89 = _id_901C1A55B5A47BE1(trigger, objectivekey);
  _id_25D213B4714288CE = spawn("trigger_radius", _id_FCFB525DF098DE89, 0, 90, 128);
  _id_25D213B4714288CE.script_label = trigger.script_label;
  trigger = _id_25D213B4714288CE;
  visuals[0] = spawn("script_model", _id_FCFB525DF098DE89);
  visuals[0].angles = trigger.angles;

  if(isDefined(trigger.iconname))
    iconname = trigger.iconname;
  else
    iconname = trigger.script_label;

  if(istrue(_id_5DDBC1FAED2C56E6))
    _id_3C2389BA69E5822B = getreservedobjid(objectivekey);
  else
    _id_3C2389BA69E5822B = undefined;

  zone = scripts\mp\gameobjects::createuseobject("neutral", trigger, visuals, (0, 0, 90), _id_5DDBC1FAED2C56E6, _id_08B9949739F4E0F6);
  zone scripts\mp\gameobjects::allowuse("enemy");
  zone scripts\mp\gameobjects::setusetime(level.bankcapturetime);
  zone scripts\mp\gameobjects::cancontestclaim(1);
  zone scripts\mp\gameobjects::mustmaintainclaim(1);
  zone.tagsdeposited = 0;
  zone.disabled = 0;
  zone.objectivekey = objectivekey;
  zone.iconname = iconname;

  if(!istrue(_id_08B9949739F4E0F6)) {
    zone scripts\mp\gameobjects::setvisibleteam("any");
    zone setobjectivecallbacks();
    objective_setlabel(zone.objidnum, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
    zone scripts\engine\utility::delaythread(1.0, ::setneutral);
  }

  return zone;
}

setobjectivecallbacks() {
  self.onbeginuse = ::zone_onusebegin;
  self.onuseupdate = ::zone_onuseupdate;
  self.onenduse = ::zone_onuseend;
  self.onuse = ::zone_onuse;
  self.onunoccupied = ::zone_onunoccupied;
  self.oncontested = ::zone_oncontested;
  self.onuncontested = ::zone_onuncontested;
  self.id = "domFlag";
  scripts\mp\gameobjects::pinobjiconontriggertouch();
  self.claimgracetime = level.bankcapturetime * 1000;
  self.scriptable = setupscriptablevisuals(self.visuals[0].origin, self);
}

getreservedobjid(_id_51CE8D39AFD59B34) {
  if(_id_51CE8D39AFD59B34 == "a")
    _id_AA530B7C5AEFA0B4 = 0;
  else
    _id_AA530B7C5AEFA0B4 = 1;

  return _id_AA530B7C5AEFA0B4;
}

setupscriptablevisuals(_id_EC83CD7530335D3F, zone) {
  tracestart = _id_EC83CD7530335D3F + (0, 0, 32);
  _id_8B39E5984DA1FFAF = _id_EC83CD7530335D3F + (0, 0, -32);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
  zone.baseeffectpos = trace["position"];
  zone.baseeffectpos = fixupscriptableorigin(zone);
  upangles = vectortoangles(trace["normal"]);
  _id_232BC202587CA413 = _id_F7666B5E6CBA796E(zone, upangles);
  zone.baseeffectforward = anglesToForward(_id_232BC202587CA413);
  scriptable = spawn("script_model", zone.baseeffectpos);
  scriptable setModel("grind_flag_scriptable");
  scriptable.angles = generateaxisanglesfromforwardvector(zone.baseeffectforward, scriptable.angles);
  return scriptable;
}

_id_901C1A55B5A47BE1(trigger, objectivekey) {
  origin = trigger.origin;

  switch (level.mapname) {
    case "mp_crossing":
      if(objectivekey == "b")
        origin = origin + (0, 0, -100);

      break;
  }

  return origin;
}

fixupscriptableorigin(zone) {
  origin = zone.baseeffectpos;

  switch (level.mapname) {
    case "mp_village2":
      if(zone.objectivekey == "b")
        origin = origin + (0, 0, 10);

      break;
    case "mp_farm_18":
      if(zone.objectivekey == "b")
        origin = origin + (0, 0, 10);

      break;
  }

  return origin;
}

_id_F7666B5E6CBA796E(zone, upangles) {
  angles = upangles;

  switch (level.mapname) {
    case "mp_farm_18":
      if(zone.objectivekey == "b")
        angles = (270, 0, 0);

      break;
    case "mp_crossing":
      if(zone.objectivekey == "b")
        angles = (275, 90, 0);

      break;
    case "mp_shoothouse2":
      if(zone.objectivekey == "a")
        angles = (270, 0, 0);

      break;
  }

  return angles;
}

activatezone() {
  self.onbeginuse = undefined;
  self.onuseupdate = undefined;
  self.onenduse = undefined;
  self.onuse = undefined;
  self.onunoccupied = undefined;
  self.oncontested = undefined;
  self.onuncontested = undefined;
}

deactivatezone() {
  self.onbeginuse = undefined;
  self.onuseupdate = undefined;
  self.onenduse = undefined;
  self.onuse = undefined;
  self.onunoccupied = undefined;
  self.oncontested = undefined;
  self.onuncontested = undefined;
}

setneutral() {
  scripts\mp\gameobjects::setownerteam("neutral");
  setneutralicons();
  updateflagstate("idle", 0);
}

zone_onusebegin(player) {
  self.didstatusnotify = 0;
  thread scripts\mp\gameobjects::useobjectdecay(player.team);
}

zone_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(progress > 0.05 && _id_301D62DA1A0738F1 && !self.didstatusnotify) {
    if(!isagent(_id_4B22E50E504339FE))
      updateflagcapturestate(team);

    self.didstatusnotify = 1;
  }
}

zone_onuseend(team, player, success) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    setneutralicons();
    updateflagstate("idle", 0);
  } else {
    setteamicons();
    updateflagstate(ownerteam, 0);
  }
}

zone_onuse(player) {
  _id_8C4EC3E8ADAFD3FF = player.team;
  _id_8A04AA0E0755E7E3 = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(_id_8C4EC3E8ADAFD3FF)[0];
  capturetime = gettime();
  setteamicons();
  updateflagstate(_id_8C4EC3E8ADAFD3FF, 0);
  scripts\mp\gameobjects::setownerteam(_id_8C4EC3E8ADAFD3FF);
}

zone_onunoccupied() {
  setneutralicons();
  setneutral();
}

zone_oncontested() {
  setcontestedicons();
  updateflagstate("contested", 0);
}

zone_onuncontested(lastclaimteam) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(lastclaimteam == "none" || ownerteam == "neutral")
    setneutralicons();
  else
    setteamicons();

  _id_FF99447227B9FBAC = scripts\engine\utility::ter_op(ownerteam == "neutral", "idle", ownerteam);
  updateflagstate(_id_FF99447227B9FBAC, 0);
}

setcrankedtimerzonecap(player) {
  if((scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(player)) && isDefined(player.cranked) && player.cranked)
    player scripts\mp\cranked::setcrankedplayerbombtimer("assist");
}

setneutralicons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
}

setteamicons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

setcontestedicons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconfriendlycontested);
}

updateflagstate(state, _id_431C28FD393513A5) {
  self.scriptable setscriptablepartstate("flag", state);

  if(!istrue(_id_431C28FD393513A5))
    self.scriptable setscriptablepartstate("pulse", "off");
}

updateflagcapturestate(state) {
  self.scriptable setscriptablepartstate("pulse", state);
}