/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4924f90a6f7dc739.gsc
***********************************************/

init() {
  enabled = _id_029458C0B233BE34::registerquestcategory("domination", 1);

  if(!enabled) {
    return;
  }
  _id_029458C0B233BE34::registertabletinit("domination", ::domtablet_init);
  _id_029458C0B233BE34::registerremovequestinstance("domination", ::domquest_removequestinstance);
  _id_029458C0B233BE34::registerquestlocale("dom_locale");
  _id_029458C0B233BE34::registercreatequestlocale("dom_locale", ::domlocale_createquestlocale);
  _id_029458C0B233BE34::registerremovequestinstance("dom_locale", ::domlocale_removelocaleinstance);
  _id_029458C0B233BE34::registerontimerexpired("domination", ::dom_ontimerexpired);
  setupdom();
  game["dialog"]["mission_dom_accept"] = "mission_mission_dom_accept_secure";
  game["dialog"]["mission_dom_success"] = "mission_mission_dom_success";
}

setupdom() {
  if(isDefined(level.br_domheight)) {
    return;
  }
  level.disableinitplayergameobjects = 0;
  level.br_domheight = 120;
  level.iconneutral = "waypoint_captureneutral_br";
  level.iconcapture = "waypoint_capture_br";
  level.icondefend = "waypoint_defend_br";
  level.icondefending = "waypoint_defending_br";
  level.iconcontested = "waypoint_contested_br";
  level.icontaking = "waypoint_taking_br";
  level.iconlosing = "waypoint_losing_br";
  level.iconovertime = "icon_waypoint_ot";
  _setdomflagiconinfo("icon_waypoint_dom_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_taking_br", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  _setdomflagiconinfo("waypoint_capture_br", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_defend_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  _setdomflagiconinfo("waypoint_defending_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  _setdomflagiconinfo("waypoint_blocking_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 0);
  _setdomflagiconinfo("waypoint_blocked_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 0);
  _setdomflagiconinfo("waypoint_losing_br", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  _setdomflagiconinfo("waypoint_captureneutral_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_contested_br", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  _setdomflagiconinfo("waypoint_dom_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _setdomflagiconinfo("icon_waypoint_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _setdomflagiconinfo("icon_waypoint_ot", "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", 0);
}

_setdomflagiconinfo(name, colors, string, _id_B50E35D9C370899B) {
  level.waypointcolors[name] = colors;
  level.waypointbgtype[name] = 1;
  level.waypointstring[name] = string;
  level.waypointshader[name] = "ui_mp_br_mapmenu_icon_dom_objective";
  level.waypointpulses[name] = _id_B50E35D9C370899B;
}

domquest_removequestinstance() {
  _id_029458C0B233BE34::releaseteamonquest(self.team);
  _id_029458C0B233BE34::uiobjectivehidefromteam(self.team);
  self.subscribedlocale thread domflagupdateiconsframeend();
}

domlocale_removelocaleinstance() {
  foreach(instance in self.subscribedinstances)
  instance thread _id_029458C0B233BE34::removequestinstance();

  deletedomflaggameobject();
  self.domflag = undefined;
}

domtablet_init() {
  _id_354D1457278B342C = getserachparams(self);
  placement = _id_029458C0B233BE34::findquestplacement("domination", _id_354D1457278B342C);

  if(!isDefined(placement))
    return 0;

  self.reservedplacement = placement;
  return 1;
}

domlocale_createquestlocale(placement) {
  if(isDefined(_id_029458C0B233BE34::getquestdata("dom_locale").nextid))
    _id_029458C0B233BE34::getquestdata("dom_locale").nextid++;
  else
    _id_029458C0B233BE34::getquestdata("dom_locale").nextid = 0;

  locale = _id_029458C0B233BE34::createlocaleinstance("dom_locale", "domination", "DomPoint:" + _id_029458C0B233BE34::getquestdata("dom_locale").nextid);

  if(!isDefined(placement)) {
    locale.curorigin = (0, 0, 0);
    locale.enabled = 0;
    return locale;
  }

  _id_1606F84A9B5BD33B = placement.origin;

  if(!(placement.spawnflags & 7)) {}

  radius = _id_029458C0B233BE34::questpointgetradius(placement);
  trigger = spawn("trigger_radius", _id_1606F84A9B5BD33B, 0, int(radius), 500);
  level.setdomscriptablepartstatefunc = ::domflag_setdomscriptablepartstate;
  domflag = _id_27C59002EB613362(trigger);
  domflag.flagmodel setModel("lm_domination_point_01");
  domflag.onuse = ::domflag_onuse;
  domflag.onbeginuse = ::domflag_onbeginuse;
  domflag.onuseupdate = ::domflag_onuseupdate;
  domflag.onenduse = ::domflag_onenduse;
  domflag.usecondition = ::domflag_usecondition;
  domflag.lockupdatingicons = 1;
  domflag.checkuseconditioninthink = 1;
  objective_position(domflag.objidnum, domflag.curorigin + (0, 0, 60));
  level.flagcapturetime = getdvarfloat("dvar_4A3E88DCAF980070", 30);
  domflag.usetime = int(level.flagcapturetime * 1000);
  locale.lastcircletick = -1;
  locale.domflag = domflag;
  locale.curorigin = domflag.curorigin;
  domflag.locale = locale;
  _id_029458C0B233BE34::addquestinstance("dom_locale", locale);
  return locale;
}

takequestitem(pickupent) {
  instance = _id_029458C0B233BE34::createquestinstance("domination", self.team, pickupent.index, pickupent);
  instance _id_029458C0B233BE34::registerteamonquest(self.team, self);
  instance _id_029458C0B233BE34::registercontributingplayers(self);
  instance.team = self.team;
  instance.tablet = pickupent;
  instance.tablet.keepinmap = 1;
  instance.origin = instance.tablet.origin;
  _id_89CAD6E3DA206570 = getdvarint("dvar_2E5871BA3356E734", 240);
  instance _id_029458C0B233BE34::questtimerset(_id_89CAD6E3DA206570, 4);
  _id_988C3FD02BCBD450 = scripts\engine\utility::getStructArray("tablet_spawn", "targetname");
  current_struct = scripts\engine\utility::getclosest(pickupent.origin, _id_988C3FD02BCBD450);
  instance._id_A52C81F5E957AA03 = current_struct;
  instance._id_291CEE6DCDEAA433 = [];
  instance._id_BA39C0BD611CE3F3 = instance;
  instance._id_291CEE6DCDEAA433 = _id_029458C0B233BE34::_id_61816329786A4614(current_struct, "dom_search_region");

  if(isDefined(instance._id_291CEE6DCDEAA433) && instance._id_291CEE6DCDEAA433.size > 0) {
    if(isDefined(instance._id_291CEE6DCDEAA433[0]))
      instance._id_BA39C0BD611CE3F3 = instance._id_291CEE6DCDEAA433[0];
  }

  _id_029458C0B233BE34::_id_AFB3C7102E36A404(instance);
  _id_029458C0B233BE34::_id_5B04CC6859711D68(instance);
  _id_029458C0B233BE34::_id_2247D0E9C5C2A383(instance);
  _id_354D1457278B342C = getserachparams(instance._id_BA39C0BD611CE3F3, instance._id_BA39C0BD611CE3F3.radius);
  locale = instance _id_029458C0B233BE34::requestquestlocale("dom_locale", _id_354D1457278B342C, 1);

  if(!locale.enabled) {
    instance.result = "no_locale";
    instance _id_029458C0B233BE34::releaseteamonquest(self.team);
    return;
  }

  level thread _id_029458C0B233BE34::_id_7BCB36BCE60B1F7A(instance);
  _id_029458C0B233BE34::uiobjectiveshowtoteam("domination", self.team);
  _id_029458C0B233BE34::addquestinstance("domination", instance);
  _id_029458C0B233BE34::startteamcontractchallenge("domination", self, self.team);
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self;
  params.plundervar = _id_029458C0B233BE34::getquestplunderreward("domination", _id_029458C0B233BE34::getquestrewardtier(self.team));
  _id_029458C0B233BE34::displayteamsplash(self.team, "br_domination_quest_start_team", params);
  _id_029458C0B233BE34::displayplayersplash(self, "br_domination_quest_start_tablet_finder", params);
  _id_029458C0B233BE34::displaysquadmessagetoteam(instance.team, self, 6, _id_029458C0B233BE34::getquestindex("domination"));
}

domflagupdateicons() {
  objective_showtoplayersinmask(self.domflag.objidnum);
  objective_removeallfrommask(self.domflag.objidnum);
}

domflagupdateiconsframeend() {
  self endon("removed");
  waittillframeend;
  domflagupdateicons();
}

deletedomflaggameobject() {
  foreach(_id_06D8B9034036E075 in self.domflag.visuals)
  _id_06D8B9034036E075 delete();

  if(isDefined(self.domflag.flagmodel))
    self.domflag.flagmodel delete();

  if(isDefined(self.domflag.scriptable))
    self.domflag.scriptable delete();

  if(isDefined(self.domflag.trigger)) {
    self.domflag.trigger delete();
    self.domflag.trigger = undefined;
  }

  self.domflag thread gameobjectreleaseid_delayed();
  self.domflag notify("deleted");
}

gameobjectreleaseid_delayed() {
  wait 0.1;
  scripts\cp\cp_objectives::freeworldidbyobjid(self.objidnum);
}

domflag_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  if(progress < 1.0 && !level.gameended)
    play_spotrep_capture_sfx(progress, team);

  if(progress > 0.05 && _id_301D62DA1A0738F1 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;
}

domflag_onbeginuse(_id_22282E7D48CA3400) {
  if(!isDefined(self.obj_icon_revealed) || !self.obj_icon_revealed) {
    self.obj_icon_revealed = 1;
    level thread _id_029458C0B233BE34::utilflare_shootflare(self.curorigin, "dom");
    playerteam = scripts\cp\utility::getteamarray(_id_22282E7D48CA3400.team);
    playersinrange = scripts\cp\utility::getplayersinradius(self.curorigin, 7800, undefined, playerteam);
    level notify("quest_send_ai_wave");
    _id_96674628376EABA6 = scripts\cp\utility::getplayersinteam(_id_22282E7D48CA3400.team);

    foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6)
    _id_F0EA4030349A33D5 notify("calloutmarkerping_warzoneKillQuestIcon");
  }
}

domflag_onuse(_id_22282E7D48CA3400) {
  foreach(instance in self.locale.subscribedinstances) {
    if(instance.team == _id_22282E7D48CA3400.team) {
      params = spawnStruct();
      rewardtier = _id_029458C0B233BE34::getquestrewardtier(_id_22282E7D48CA3400.team);
      missionid = _id_029458C0B233BE34::getquestindex("domination");
      _id_11D65784F0B6AFA2 = _id_029458C0B233BE34::getquestrewardgroupindex(_id_029458C0B233BE34::getquestrewardbuildgroupref("domination"));
      params.packedbits = _id_029458C0B233BE34::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);
      _id_029458C0B233BE34::displayteamsplash(instance.team, "br_domination_quest_complete", params);
      _id_029458C0B233BE34::displaysquadmessagetoteam(instance.team, _id_22282E7D48CA3400, 8, missionid);
      instance.rewardorigin = self.flagmodel.origin;
      instance.rewardangles = self.flagmodel.angles;
      instance.result = "success";

      if(isDefined(self.assisttouchlist[instance.team])) {
        _id_59DB5D0F4E3000A7 = getarraykeys(self.assisttouchlist[instance.team]);

        foreach(playerid in _id_59DB5D0F4E3000A7) {
          player = self.assisttouchlist[instance.team][playerid].player;

          if(isDefined(player.owner))
            player = player.owner;

          if(!isPlayer(player)) {
            continue;
          }
          instance _id_029458C0B233BE34::registercontributingplayers(player);
        }
      }

      _id_AEA0A82D2FA64B2C = getdvarint("dvar_A46E0164571F45FE", 1000);
      _id_029458C0B233BE34::_id_0F4FA3A0202D55F8(instance);
      _id_029458C0B233BE34::_id_20739E471AE0C29B(instance.team, _id_AEA0A82D2FA64B2C);
      continue;
    }

    _id_029458C0B233BE34::displayteamsplash(instance.team, "br_domination_quest_failure");
    instance.result = "fail";
  }

  self.locale thread _id_029458C0B233BE34::removequestinstance();
}

domflag_onenduse(team, player, success) {}

play_spotrep_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    _id_C3DDFB0EAA8F761C = "";
    progress = int(floor(progress * 10));
    _id_C3DDFB0EAA8F761C = "mp_dom_capturing_tick_0" + progress;
    self.visuals[0] playsoundtoteam(_id_C3DDFB0EAA8F761C, team);
  }
}

domflag_setdomscriptablepartstate(part, state, _id_BA360E4FF7BE8D96) {
  switch (state) {
    case "contested":
    case "off":
    case "idle":
      return 0;
    default:
      state = "using";

      if(isDefined(_id_BA360E4FF7BE8D96))
        state = state + _id_BA360E4FF7BE8D96;

      self.scriptable setscriptablepartstate(part, state);

      if(part == "pulse")
        self.scriptable setscriptablepartstate("flag", state);

      return 1;
  }
}

domflag_usecondition(player) {
  playerteam = player.team;

  foreach(instance in self.locale.subscribedinstances) {
    if(instance.team == playerteam)
      return 1;
  }

  return 0;
}

dom_ontimerexpired() {
  while(self.subscribedlocale.domflag.numtouching[self.id])
    waitframe();

  _id_029458C0B233BE34::displayteamsplash(self.id, "br_domination_quest_timer_expired");
}

getserachparams(_id_EF66E4DF53A86181, _id_921B9D1AB6394420) {
  _id_354D1457278B342C = spawnStruct();
  _id_354D1457278B342C.searchfunc = "questDomPointsArray";
  _id_354D1457278B342C.searchcircleorigin = (_id_EF66E4DF53A86181.origin[0], _id_EF66E4DF53A86181.origin[1], 0);
  _id_354D1457278B342C.searchradiusmax = 12000;
  _id_354D1457278B342C.searchradiusmin = 0;
  _id_354D1457278B342C.searchradiusidealmax = 8000;
  _id_354D1457278B342C.searchradiusidealmin = 6000;
  _id_354D1457278B342C.questtypes = 7;
  _id_354D1457278B342C.mintime = getdvarfloat("dvar_4A3E88DCAF980070", 30);
  _id_354D1457278B342C.searchforcecirclecenter = 1;
  _id_354D1457278B342C.reservedplacement = _id_EF66E4DF53A86181.reservedplacement;

  if(isDefined(_id_921B9D1AB6394420))
    _id_354D1457278B342C.searchradiusidealmax = _id_921B9D1AB6394420;

  if(gametypeoverridedomsearchparams()) {
    if(_id_354D1457278B342C.searchradiusmax < level.quest_domdistmax)
      _id_354D1457278B342C.searchradiusmax = level.quest_domdistmax;

    _id_354D1457278B342C.searchradiusidealmax = level.quest_domdistmax;
    _id_354D1457278B342C.searchradiusidealmin = level.quest_domdistmin;
  }

  return _id_354D1457278B342C;
}

gametypeoverridedomsearchparams() {
  _id_9254FE14251C6557 = 0;

  if(isDefined(level.quest_domdistmax) && isDefined(level.quest_domdistmin))
    _id_9254FE14251C6557 = 1;

  return _id_9254FE14251C6557;
}

_id_27C59002EB613362(trigger, team, _id_5DDBC1FAED2C56E6, _id_08B9949739F4E0F6, showoncompass) {
  if(isDefined(trigger.target)) {
    if(!isDefined(trigger.visuals))
      visuals[0] = getEnt(trigger.target, "targetname");
    else
      visuals = trigger.visuals;
  } else {
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0].angles = trigger.angles;
  }

  if(!isDefined(level.flagcapturetime))
    level.flagcapturetime = getdvarfloat("flagcapturetime", 20);

  if(isDefined(trigger.objectivekey))
    objectivekey = trigger.objectivekey;
  else
    objectivekey = trigger.script_label;

  if(isDefined(trigger.iconname))
    iconname = trigger.iconname;
  else
    iconname = trigger.script_label;

  if(!isDefined(team))
    team = "neutral";

  _id_08B9949739F4E0F6 = 1;
  domflag = _id_029458C0B233BE34::createuseobject(team, trigger, visuals, (0, 0, 100), -1, _id_08B9949739F4E0F6, showoncompass);
  _id_3C2389BA69E5822B = scripts\cp\cp_objectives::requestworldid("recon_test_1");

  if(_id_3C2389BA69E5822B != -1) {
    objective_icon(_id_3C2389BA69E5822B, "icon_waypoint_objective_general");
    objective_setplayintro(_id_3C2389BA69E5822B, 1);
    objective_sethot(_id_3C2389BA69E5822B, 1);
    objective_position(_id_3C2389BA69E5822B, domflag.curorigin);
    objective_setbackground(_id_3C2389BA69E5822B, 0);
    objective_state(_id_3C2389BA69E5822B, "current");
  }

  domflag.cancontestclaim = 1;
  domflag.usetime = int(level.flagcapturetime * 1000);

  if(isDefined(level.capturetype))
    domflag.capturebehavior = "normal";

  domflag.objectivekey = objectivekey;
  domflag.iconname = iconname;

  if(!istrue(_id_08B9949739F4E0F6)) {
    domflag.onuse = ::dompoint_onuse;
    domflag.onbeginuse = ::dompoint_onusebegin;
    domflag.onuseupdate = ::dompoint_onuseupdate;
    domflag.onenduse = ::dompoint_onuseend;
    domflag.onunoccupied = ::dompoint_onunoccupied;
    domflag.onpinnedstate = ::dompoint_onpinnedstate;
    domflag.onunpinnedstate = ::dompoint_onunpinnedstate;
    domflag.stompprogressreward = ::dompoint_stompprogressreward;
  }

  domflag.nousebar = 1;
  domflag.id = "domFlag";
  domflag.claimgracetime = level.flagcapturetime * 1000;
  domflag.firstcapture = 1;
  domflag.pinobj = 1;
  tracestart = visuals[0].origin + (0, 0, 32);
  _id_8B39E5984DA1FFAF = visuals[0].origin + (0, 0, -32);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
  offset = checkmapoffsets(domflag);
  domflag.baseeffectpos = trace["position"] + offset;
  upangles = vectortoangles(trace["normal"]);
  _id_232BC202587CA413 = checkmapfxangles(domflag, upangles);
  domflag.baseeffectforward = anglesToForward(_id_232BC202587CA413);
  scriptable = spawn("script_model", domflag.baseeffectpos);
  scriptable setModel("dom_flag_scriptable");
  scriptable.angles = generateaxisanglesfromforwardvector(domflag.baseeffectforward, scriptable.angles);
  domflag.scriptable = scriptable;
  domflag.vfxnamemod = "";
  domflag.noscriptable = 1;

  if(istrue(level.multiteambased))
    domflag.noscriptable = 1;

  domflag.flagmodel = spawn("script_model", domflag.baseeffectpos);
  domflag.flagmodel setModel("military_dom_flag_neutral");
  domflag.flagmodel.angles = checkmapflagangles(domflag);
  domflag.outlineent = domflag.flagmodel;
  domflag.objidnum = _id_3C2389BA69E5822B;

  if(!istrue(_id_08B9949739F4E0F6))
    domflag domflag_setneutral();

  return domflag;
}

dompoint_onuse(_id_22282E7D48CA3400) {
  team = _id_22282E7D48CA3400.team;
  _id_8A04AA0E0755E7E3 = self.ownerteam;
  objective_setprogress(self.objidnum, 0);
  objective_setshowprogress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;

  if(istrue(level.flagneutralization)) {
    ownerteam = self.ownerteam;

    if(ownerteam == "neutral")
      dompoint_setcaptured(team, _id_22282E7D48CA3400);
    else {
      thread domflag_setneutral(1);
      level.lastcaptime = gettime();
      thread giveflagassistedcapturepoints(self.touchlist[team]);
      self.neutralized = 1;
    }
  } else
    dompoint_setcaptured(team, _id_22282E7D48CA3400);

  self.firstcapture = 0;
}

giveflagassistedcapturepoints(touchlist) {
  level endon("game_ended");
  _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

  for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
    player = touchlist[_id_59DB5D0F4E3000A7[index]].player;

    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(player.owner))
      player = player.owner;

    if(!isPlayer(player)) {
      continue;
    }
    wait 0.05;
  }
}

getdomneutralizeomnvarvalue() {
  switch (self.objectivekey) {
    case "_a":
      return 6;
    case "_b":
      return 7;
    case "_c":
      return 8;
    default:
      return 6;
  }
}

dompoint_onusebegin(player) {
  ownerteam = self.ownerteam;
  self.neutralizing = istrue(level.flagneutralization) && ownerteam != "neutral";

  if(self.neutralizing) {
    if(ownerteam != player.team)
      _id_024C76FC549F7FD9 = getdomneutralizeomnvarvalue();
    else
      _id_024C76FC549F7FD9 = 0;
  } else if(ownerteam != player.team)
    _id_024C76FC549F7FD9 = 1;
  else
    _id_024C76FC549F7FD9 = 0;

  player setclientomnvar("ui_objective_pinned_text_param", _id_024C76FC549F7FD9);

  if(!isDefined(self.statusnotifytime))
    self.statusnotifytime = gettime();

  if(!istrue(self.neutralized) && self.statusnotifytime > self.statusnotifytime + 5000) {
    self.didstatusnotify = 0;
    self.statusnotifytime = gettime();
  }

  usetime = scripts\engine\utility::ter_op(istrue(level.flagneutralization) && !self.firstcapture, level.flagcapturetime * 0.5, level.flagcapturetime);
  self.usetime = int(usetime * 1000);

  if(usetime > 0) {
    self.prevownerteam = scripts\cp\utility::getotherteam(player.team)[0];
    updateflagcapturestate(player.team);
  }
}

dompoint_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  ownerteam = self.ownerteam;

  if(progress > 0.05 && _id_301D62DA1A0738F1 && !self.didstatusnotify) {
    if(ownerteam == "neutral") {
      if(level.flagcapturetime > 0.05) {
        if(isDefined(level.objectives) && level.objectives.size == 5 && (self.objectivekey == "_c" || self.objectivekey == "_d") || self.objectivekey == "_b")
          otherteam = scripts\cp\utility::getotherteam(team)[0];
      }
    } else if(level.flagcapturetime > 0.05) {}

    self.didstatusnotify = 1;
  }
}

dompoint_onuseend(team, player, success) {
  if(isPlayer(player))
    player setclientomnvar("ui_objective_pinned_text_param", 0);

  ownerteam = self.ownerteam;

  if(ownerteam == "neutral")
    thread updateflagstate("idle", 0);
  else
    thread updateflagstate(ownerteam, 0);

  if(!success)
    self.neutralized = 0;
}

setdomscriptablepartstate(part, state, _id_BA360E4FF7BE8D96) {
  if(!isDefined(self.scriptable)) {
    return;
  }
  if(isDefined(level.setdomscriptablepartstatefunc)) {
    if([[level.setdomscriptablepartstatefunc]](part, state, _id_BA360E4FF7BE8D96))
      return;
  }

  if(isDefined(_id_BA360E4FF7BE8D96))
    state = state + _id_BA360E4FF7BE8D96;

  self.scriptable setscriptablepartstate(part, state);
}

updateflagcapturestate(state) {
  if(isDefined(self.noscriptable)) {
    return;
  }
  if(scripts\cp\utility::getgametype() != "arm" && scripts\cp\utility::getgametype() != "defcon") {
    if(isDefined(self.scriptable))
      setdomscriptablepartstate("pulse", state, self.vfxnamemod);
  }
}

dompoint_onunoccupied() {
  ownerteam = self.ownerteam;

  if(ownerteam == "neutral")
    _id_029458C0B233BE34::setobjectivestatusicons(level.iconneutral);
  else
    _id_029458C0B233BE34::setobjectivestatusicons(level.icondefend, level.iconcapture);

  self.didstatusnotify = 0;
}

dompoint_onpinnedstate(player) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate)
    _id_029458C0B233BE34::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

dompoint_onunpinnedstate(player) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate)
    _id_029458C0B233BE34::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

dompoint_stompprogressreward(player) {
  _id_029458C0B233BE34::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

checkmapflagangles(domflag) {
  label = domflag.objectivekey;
  angles = (0, 0, 0);

  if(level.mapname == "mp_hardhat") {
    if(label == "_b")
      angles = (0, 110, 0);
  }

  return angles;
}

checkmapoffsets(domflag) {
  label = domflag.objectivekey;
  offset = (0, 0, 0);

  if(level.mapname == "mp_quarry") {
    if(label == "_c")
      offset = offset + (0, 0, 7);
  }

  if(level.mapname == "mp_divide") {
    if(label == "_a")
      offset = offset + (0, 0, 4.5);
  }

  if(level.mapname == "mp_afghan") {
    if(label == "_a")
      offset = offset + (0, 0, 5);

    if(label == "_c")
      offset = offset + (0, 0, 1);
  }

  return offset;
}

checkmapfxangles(domflag, upangles) {
  label = domflag.objectivekey;
  angles = upangles;

  if(level.mapname == "mp_quarry") {
    if(label == "_c")
      angles = (276.5, angles[1], angles[2]);
  }

  if(level.mapname == "mp_divide") {
    if(label == "_a")
      angles = (273.5, angles[1], angles[2]);
  }

  if(level.mapname == "mp_afghan") {
    if(label == "_a")
      angles = (273.5, 200.5, angles[2]);

    if(label == "_c")
      angles = (273.5, angles[1], angles[2]);
  }

  if(level.mapname == "mp_faridah") {
    if(isstring(label)) {
      if(label == "_school")
        angles = (270, 0, 0);
      else if(label == "_warehouse")
        angles = (270, 0, 0);
    }
  }

  return angles;
}

domflag_setneutral(_id_431C28FD393513A5) {
  self notify("flag_neutral");
  _id_029458C0B233BE34::setobjectivestatusicons(level.iconneutral, undefined, undefined, undefined, 1);
  setownerteam("neutral");
  thread updateflagstate("idle", istrue(_id_431C28FD393513A5));

  if(isDefined(level.matchrecording_logevent) && isDefined(self.logid) && isDefined(self.logeventflag))
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), 0);
}

setownerteam(team) {
  self.ownerteam = team;
  updatetrigger();
  updatecompassicons();

  if(team != "neutral")
    self.prevownerteam = team;
}

updateflagstate(state, _id_431C28FD393513A5, ownerteam) {
  self notify("updateFlagState");
  self endon("updateFlagState");

  if(isDefined(ownerteam)) {
    if(ownerteam == "allies")
      self.flagmodel setModel("military_dom_flag_west");
    else if(ownerteam == "axis")
      self.flagmodel setModel("military_dom_flag_east");
    else
      self.flagmodel setModel("military_dom_flag_neutral");
  }

  if(isDefined(self.noscriptable)) {
    return;
  }
  while(!isDefined(self.scriptable))
    waitframe();

  if(scripts\cp\utility::getgametype() == "defcon") {
    return;
  }
  if(scripts\cp\utility::getgametype() == "arm") {
    return;
  }
  if(isDefined(self.scriptable)) {
    if(state == "off")
      setdomscriptablepartstate("flag", state);
    else
      setdomscriptablepartstate("flag", state, self.vfxnamemod);

    if(!istrue(_id_431C28FD393513A5))
      setdomscriptablepartstate("pulse", "off");
  }
}

getteamflagcount(team) {
  score = 0;

  foreach(objective in level.objectives) {
    if(objective.ownerteam == team)
      score++;
  }

  return score;
}

dompoint_setcaptured(team, _id_22282E7D48CA3400) {
  setownerteam(team);
  self notify("capture", _id_22282E7D48CA3400);
  self notify("assault", _id_22282E7D48CA3400);

  if(istrue(level.numflagsscoreonkill)) {
    _id_FEE716687DD29378 = getteamflagcount(team);

    if(_id_FEE716687DD29378 >= level.numflagsscoreonkill)
      level.teamscoresonkill[team] = 1;
    else
      level.teamscoresonkill[team] = 0;
  }

  _id_029458C0B233BE34::setobjectivestatusicons(level.icondefending, level.iconcapture);
  self.neutralized = 0;
  thread updateflagstate(team, 0, team);

  if(self.touchlist[team].size == 0 && isDefined(self.oldtouchlist))
    self.touchlist = self.oldtouchlist;

  foreach(name in level.teamnamelist) {
    if(isDefined(self.assisttouchlist[name]) && name != team)
      self.assisttouchlist[name] = [];
  }

  if(isDefined(self.assisttouchlist[team])) {
    _id_59DB5D0F4E3000A7 = getarraykeys(self.assisttouchlist[team]);

    foreach(playerid in _id_59DB5D0F4E3000A7) {
      player = self.assisttouchlist[team][playerid].player;

      if(isDefined(player.owner))
        player = player.owner;

      if(!isPlayer(player))
        continue;
    }
  }
}

isfriendlyteam(team) {
  if(self.ownerteam == "any")
    return 1;

  if(self.ownerteam == team)
    return 1;

  if(self.ownerteam == "neutral" && isDefined(self.prevownerteam) && self.prevownerteam == team)
    return 1;

  return 0;
}

getupdateteams(_id_EDD687A0AB26D9F0) {
  _id_23AE7B386046354E = spawnStruct();
  _id_23AE7B386046354E.teams = [];

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    index = _id_23AE7B386046354E.teams.size;
    _id_23AE7B386046354E.teams[index] = spawnStruct();

    if(_id_EDD687A0AB26D9F0 == "any") {
      _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
      _id_23AE7B386046354E.teams[index].showtoteam = 1;
      continue;
    }

    if(_id_EDD687A0AB26D9F0 == "friendly") {
      if(isfriendlyteam(_id_FABF84450735DD93)) {
        _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
        _id_23AE7B386046354E.teams[index].showtoteam = 1;
      } else {
        _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
        _id_23AE7B386046354E.teams[index].showtoteam = 0;
      }

      continue;
    }

    if(_id_EDD687A0AB26D9F0 == "enemy") {
      if(isfriendlyteam(_id_FABF84450735DD93)) {
        _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
        _id_23AE7B386046354E.teams[index].showtoteam = 0;
      } else {
        _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
        _id_23AE7B386046354E.teams[index].showtoteam = 1;
      }

      continue;
    }

    if(_id_EDD687A0AB26D9F0 == "none") {
      _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
      _id_23AE7B386046354E.teams[index].showtoteam = 0;
    }
  }

  return _id_23AE7B386046354E;
}

updatetrigger() {
  if(self.triggertype != "use") {
    return;
  }
  if(self.interactteam == "none") {
    self.trigger.origin = self.trigger.origin - (0, 0, 10000);

    if(isDefined(self.trigger.classname) && self.trigger.classname != "script_model")
      self.trigger setteamfortrigger("none");
  } else if(self.interactteam == "any") {
    self.trigger.origin = self.curorigin;
    self.trigger setteamfortrigger("none");
  } else if(self.interactteam == "friendly") {
    self.trigger.origin = self.curorigin;

    if(scripts\engine\utility::array_contains(level.teamnamelist, self.ownerteam))
      self.trigger setteamfortrigger(self.ownerteam);
    else
      self.trigger.origin = self.trigger.origin - (0, 0, 50000);
  } else if(self.interactteam == "enemy") {
    self.trigger.origin = self.curorigin;

    if(self.ownerteam == "allies")
      self.trigger setteamfortrigger("axis");
    else if(self.ownerteam == "axis")
      self.trigger setteamfortrigger("allies");
    else
      self.trigger setteamfortrigger("none");
  }
}

updatecompassicons(objid, ownerteam) {
  visibleteam = self.visibleteam;

  if(!isDefined(self.visibleteam))
    visibleteam = "none";

  updatecompassicon(visibleteam, objid, ownerteam);
}

updatecompassicon(_id_EDD687A0AB26D9F0, objid, ownerteam) {
  _id_00DCA4604F39117A = _id_EDD687A0AB26D9F0 == "any";
  _id_C0D426FB0DA57CF2 = _id_EDD687A0AB26D9F0 == "none";

  if(_id_00DCA4604F39117A || _id_C0D426FB0DA57CF2)
    _id_23AE7B386046354E = level.teamnamelist;
  else {
    _id_B66CFD2561F4565B = getupdateteams(_id_EDD687A0AB26D9F0);
    _id_23AE7B386046354E = _id_B66CFD2561F4565B.teams;
  }

  _id_01341915118CC82B = 0;

  for(index = 0; index < _id_23AE7B386046354E.size; index++) {
    _id_840037EE5DD73309 = _id_23AE7B386046354E[index];

    if(_id_00DCA4604F39117A || _id_C0D426FB0DA57CF2)
      _id_5C5D470BD64763F8 = _id_840037EE5DD73309;
    else
      _id_5C5D470BD64763F8 = _id_840037EE5DD73309.team;

    if(!_id_C0D426FB0DA57CF2 && !_id_00DCA4604F39117A && !scripts\cp\utility::isgameplayteam(_id_5C5D470BD64763F8)) {
      continue;
    }
    _id_58498FC5D5879BA1 = !_id_C0D426FB0DA57CF2 && (_id_00DCA4604F39117A || _id_840037EE5DD73309.showtoteam);

    if(!isDefined(objid))
      objid = self.objidnum;

    if(objid != -1) {
      if(!istrue(self.visibilitymanuallycontrolled)) {
        if(!isDefined(self.compassicons["friendly"]) || !_id_58498FC5D5879BA1)
          continue;
        else {}

        if(!isDefined(self.compassicons["enemy"]) || !_id_58498FC5D5879BA1)
          continue;
        else {}
      }

      if(!_id_01341915118CC82B) {
        icon = "icon_waypoint_dom_a";
        _id_91DBC914C620CCB0 = "neutral";
        _id_91DBC914C620CCB0 = "neutral";
        _id_B068858B9EB29701 = "neutral";
        _id_B068858B9EB29701 = scripts\engine\utility::ter_op(isDefined(_id_B068858B9EB29701), _id_B068858B9EB29701, "neutral");
        _id_A5250821FB1BEA6A = 0;
        _id_05FA71E8FED5161B = getobjectivestate(_id_91DBC914C620CCB0, _id_B068858B9EB29701);

        if(_id_05FA71E8FED5161B == "contest")
          _id_A5250821FB1BEA6A = 1;

        if(_id_A5250821FB1BEA6A) {
          objective_setprogressteam(objid, undefined);
          objective_sethot(objid, 1);
        } else
          objective_sethot(objid, 0);

        if(isDefined(ownerteam))
          self.ownerteam = ownerteam;

        _id_A041BEA72BA46E04 = "GET";
        _id_BA5C3A2B11FFF3F5 = "KILL";

        if(_id_05FA71E8FED5161B == "neutral" || !isDefined(self.ownerteam)) {
          if(isDefined(self.claimteam) && self.claimteam != "none") {
            scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, self.claimteam);
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objid, _id_A041BEA72BA46E04);
            scripts\mp\objidpoolmanager::update_objective_setenemylabel(objid, _id_BA5C3A2B11FFF3F5);
          } else {
            scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, undefined);
            scripts\mp\objidpoolmanager::update_objective_setneutrallabel(objid, _id_A041BEA72BA46E04);
          }
        } else if(_id_05FA71E8FED5161B == "claimed") {
          if(self.ownerteam != "neutral")
            scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, self.ownerteam);
          else
            scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, undefined);

          scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objid, _id_A041BEA72BA46E04);
          scripts\mp\objidpoolmanager::update_objective_setenemylabel(objid, _id_BA5C3A2B11FFF3F5);
        } else if(_id_05FA71E8FED5161B == "contest") {
          if(self.cancontestclaim && self.stalemate != self.wasstalemate || self.cancontestclaim && istrue(self.majoritycapprogress) && self.majoritycapprogress != self.wasmajoritycapprogress)
            objective_setlabel(objid, _id_A041BEA72BA46E04);
          else {
            if(!scripts\cp\utility::isgameplayteam(self.claimteam)) {
              continue;
            }
            scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, self.claimteam);
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objid, _id_A041BEA72BA46E04);
            scripts\mp\objidpoolmanager::update_objective_setenemylabel(objid, _id_BA5C3A2B11FFF3F5);
          }
        }

        objective_setbackground(objid, 0);

        if(isDefined(self.objiconent))
          scripts\mp\objidpoolmanager::update_objective_onentity(objid, self.objiconent);

        _id_01341915118CC82B = 1;
      }
    }
  }
}

getobjectivestate(_id_91DBC914C620CCB0, _id_B068858B9EB29701) {
  if(_id_91DBC914C620CCB0 == "contest" || _id_B068858B9EB29701 == "contest")
    return "contest";
  else if(_id_91DBC914C620CCB0 == "neutral" || _id_B068858B9EB29701 == "neutral")
    return "neutral";
  else
    return "claimed";
}