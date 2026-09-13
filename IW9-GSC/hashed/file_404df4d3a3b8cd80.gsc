/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_404df4d3a3b8cd80.gsc
***********************************************/

init() {
  enabled = _id_3ACF1C0EBAF602F2::registerquestcategory("domination", 1);

  if(!enabled) {
    return;
  }
  _id_3ACF1C0EBAF602F2::registertabletinit("domination", ::domtablet_init);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("domination", ::domquest_removequestinstance);
  _id_3ACF1C0EBAF602F2::registerquestlocale("dom_locale");
  _id_3ACF1C0EBAF602F2::registercreatequestlocale("dom_locale", ::domlocale_createquestlocale);
  _id_3ACF1C0EBAF602F2::registercheckiflocaleisavailable("dom_locale", ::domlocale_checkiflocaleisavailable);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("dom_locale", ::domlocale_removelocaleinstance);
  _id_3ACF1C0EBAF602F2::registerquestcircletick("dom_locale", ::domlocale_circletick);
  _id_3ACF1C0EBAF602F2::registeronentergulag("dom_locale", ::domlocale_onentergulag);
  _id_3ACF1C0EBAF602F2::registeronrespawn("dom_locale", ::domlocale_onrespawn);
  _id_3ACF1C0EBAF602F2::getquestdata("dom_locale").nextid = 0;
  _id_3ACF1C0EBAF602F2::questtimerinit("domination", 1);
  _id_3ACF1C0EBAF602F2::registerontimerexpired("domination", ::dom_ontimerexpired);
  setupdom();
  game["dialog"]["mission_dom_accept"] = "mission_mission_dom_accept_secure";
  game["dialog"]["mission_dom_success"] = "mission_mission_dom_success";
}

domquest_removequestinstance() {
  _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
  _id_3ACF1C0EBAF602F2::uiobjectivehidefromteam(self.team);
  self.subscribedlocale thread domflagupdateiconsframeend();
}

domlocale_removelocaleinstance() {
  foreach(instance in self.subscribedinstances)
  instance thread _id_3ACF1C0EBAF602F2::removequestinstance();

  deletedomflaggameobject();
  self.domflag = undefined;
}

domtablet_init() {
  _id_354D1457278B342C = getserachparams(self);
  placement = _id_3ACF1C0EBAF602F2::findquestplacement("domination", _id_354D1457278B342C);

  if(!isDefined(placement))
    return 0;

  disablelootspawnpoint(placement.index);
  self.reservedplacement = placement;
  return 1;
}

domlocale_createquestlocale(placement) {
  _id_3ACF1C0EBAF602F2::getquestdata("dom_locale").nextid++;
  locale = _id_3ACF1C0EBAF602F2::createlocaleinstance("dom_locale", "domination", "DomPoint:" + _id_3ACF1C0EBAF602F2::getquestdata("dom_locale").nextid);

  if(!isDefined(placement)) {
    locale.curorigin = (0, 0, 0);
    locale.enabled = 0;
    return locale;
  }

  _id_1606F84A9B5BD33B = placement.origin;

  if(!(placement.spawnflags & 7)) {}

  radius = _id_3ACF1C0EBAF602F2::questpointgetradius(placement);
  trigger = spawn("trigger_radius", _id_1606F84A9B5BD33B, 0, int(radius), int(level.br_domheight));
  trigger.script_label = "_a";
  trigger.iconname = "";
  level.setdomscriptablepartstatefunc = ::domflag_setdomscriptablepartstate;
  domflag = _id_6663215F917210AE::setupobjective(trigger);
  domflag.flagmodel setModel("lm_domination_point_01");
  domflag.onuse = ::domflag_onuse;
  domflag.onbeginuse = ::domflag_onbeginuse;
  domflag.onuseupdate = ::domflag_onuseupdate;
  domflag.onenduse = ::domflag_onenduse;
  domflag.usecondition = ::domflag_usecondition;
  domflag.lockupdatingicons = 1;
  domflag.checkuseconditioninthink = 1;
  scripts\mp\objidpoolmanager::update_objective_position(domflag.objidnum, domflag.curorigin + (0, 0, 60));
  level.flagcapturetime = getdvarfloat("dvar_4A3E88DCAF980070", 30);
  domflag scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  locale.lastcircletick = -1;
  locale.domflag = domflag;
  locale.curorigin = domflag.curorigin;
  domflag.locale = locale;
  _id_3ACF1C0EBAF602F2::addquestinstance("dom_locale", locale);
  locale.radius = radius;

  if(scripts\mp\utility\game::getsubgametype() == "champion")
    locale.objectiveiconid = domflag.objidnum;

  return locale;
}

domlocale_checkiflocaleisavailable(_id_354D1457278B342C) {
  _id_35BD652A4CECD8DE = getdvarfloat("dvar_EE1694279DFA8A83", 0.2);
  _id_8FF36C8AE7DEAABD = getdvarfloat("dvar_8107A36DB56C04B5", 4);
  _id_A9837ECE374457A2 = 0;

  if(isDefined(self.domflag.curprogress))
    _id_A9837ECE374457A2 = self.domflag.curprogress / self.domflag.usetime;

  if(_id_A9837ECE374457A2 > _id_35BD652A4CECD8DE)
    return 0;

  if(self.subscribedinstances.size >= _id_8FF36C8AE7DEAABD)
    return 0;

  return 1;
}

domlocale_circletick(_id_819EDACDACB810E4, _id_E86632D645C137D0) {
  if(!isDefined(self.domflag)) {
    return;
  }
  currenttime = gettime();

  if(self.lastcircletick == currenttime) {
    return;
  }
  self.lastcircletick = currenttime;
  dist = distance2d(self.curorigin, _id_819EDACDACB810E4);

  if(dist > _id_E86632D645C137D0) {
    foreach(instance in self.subscribedinstances) {
      _id_3ACF1C0EBAF602F2::displayteamsplash(instance.team, "br_domination_quest_circle_failure");
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_obj_circle_fail", instance.team, 1);
      instance.result = "circle";
    }

    _id_3ACF1C0EBAF602F2::removequestinstance();
  }
}

domlocale_onentergulag(player) {
  domflag_hideiconfromplayer(player);
}

domlocale_onrespawn(player) {
  if(scripts\mp\utility\game::getsubgametype() != "champion" && player.team == self.subscribedinstances[0].team)
    domflag_showicontoplayer(player);
}

takequestitem(pickupent) {
  instance = _id_3ACF1C0EBAF602F2::createquestinstance("domination", self.team, pickupent.index, pickupent);
  instance _id_3ACF1C0EBAF602F2::registerteamonquest(self.team, self);
  instance _id_3ACF1C0EBAF602F2::registercontributingplayers(self);
  instance.team = self.team;
  instance.tablet = pickupent;
  _id_89CAD6E3DA206570 = getdvarint("dvar_2E5871BA3356E734", 240);
  instance _id_3ACF1C0EBAF602F2::questtimerset(_id_89CAD6E3DA206570, 4);
  _id_354D1457278B342C = getserachparams(pickupent);
  locale = instance _id_3ACF1C0EBAF602F2::requestquestlocale("dom_locale", _id_354D1457278B342C, 1);

  if(!locale.enabled) {
    instance.result = "no_locale";
    instance _id_3ACF1C0EBAF602F2::releaseteamonquest(self.team);
    return;
  }

  locale domflagupdateicons();

  if(scripts\mp\utility\game::getsubgametype() == "champion")
    level notify("quest_objective_updated_" + self.team, locale);

  _id_3ACF1C0EBAF602F2::uiobjectiveshowtoteam("domination", self.team);
  _id_3ACF1C0EBAF602F2::addquestinstance("domination", instance);
  _id_3ACF1C0EBAF602F2::startteamcontractchallenge("domination", self, self.team);
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self;
  params.plundervar = _id_3ACF1C0EBAF602F2::getquestplunderreward("domination", _id_3ACF1C0EBAF602F2::getquestrewardtier(self.team));
  _id_3ACF1C0EBAF602F2::displayteamsplash(self.team, "br_domination_quest_start_team", params);
  _id_3ACF1C0EBAF602F2::displayplayersplash(self, "br_domination_quest_start_tablet_finder", params);
  _id_3ACF1C0EBAF602F2::giveteampoints(self.team, "stat_67EB4B642067882A");
  _id_3ACF1C0EBAF602F2::displaysquadmessagetoteam(instance.team, self, 6, _id_3ACF1C0EBAF602F2::getquestindex("domination"));
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_dom_accept", instance.team, 1);
}

domflagupdateicons() {
  objective_showtoplayersinmask(self.domflag.objidnum);
  objective_removeallfrommask(self.domflag.objidnum);

  foreach(instance in self.subscribedinstances) {
    foreach(player in scripts\mp\utility\teams::getteamdata(instance.team, "players")) {
      if(!player _id_2CEDCC356F1B9FC8::isplayeringulag())
        objective_addclienttomask(self.domflag.objidnum, player);
    }
  }
}

domflag_hideiconfromplayer(player) {
  objective_removeclientfrommask(self.domflag.objidnum, player);
}

domflag_showicontoplayer(player) {
  objective_addclienttomask(self.domflag.objidnum, player);
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
  scripts\mp\gameobjects::releaseid();
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
  level.waypointshader[name] = "ui_mp_mobile_contract_dom_icon";
  level.waypointpulses[name] = _id_B50E35D9C370899B;
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
    level thread _id_3ACF1C0EBAF602F2::utilflare_shootflare(self.curorigin, "dom");
    playerteam = scripts\mp\utility\player::getteamarray(_id_22282E7D48CA3400.team);
    playersinrange = scripts\mp\utility\player::getplayersinradius(self.curorigin, 7800, undefined, playerteam);

    foreach(player in playersinrange) {
      if(isDefined(player) && isalive(player))
        _id_3ACF1C0EBAF602F2::displayplayersplash(player, "br_domination_quest_alert");
    }

    _id_96674628376EABA6 = scripts\mp\utility\teams::getfriendlyplayers(_id_22282E7D48CA3400.team, 0);

    foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6)
    _id_F0EA4030349A33D5 notify("calloutmarkerping_warzoneKillQuestIcon");
  }
}

domflag_onuse(_id_22282E7D48CA3400) {
  foreach(instance in self.locale.subscribedinstances) {
    if(instance.team == _id_22282E7D48CA3400.team) {
      params = spawnStruct();
      rewardtier = _id_3ACF1C0EBAF602F2::getquestrewardtier(_id_22282E7D48CA3400.team);
      missionid = _id_3ACF1C0EBAF602F2::getquestindex("domination");
      _id_11D65784F0B6AFA2 = _id_3ACF1C0EBAF602F2::getquestrewardgroupindex(_id_3ACF1C0EBAF602F2::getquestrewardbuildgroupref("domination"));
      params.packedbits = _id_3ACF1C0EBAF602F2::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);
      _id_3ACF1C0EBAF602F2::displayteamsplash(instance.team, "br_domination_quest_complete", params);
      _id_3ACF1C0EBAF602F2::displaysquadmessagetoteam(instance.team, _id_22282E7D48CA3400, 8, missionid);
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_dom_success", instance.team, 1, 1);
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
          instance _id_3ACF1C0EBAF602F2::registercontributingplayers(player);
        }
      }

      if(isDefined(level._id_52781BE0B4E8A959))
        level[[level._id_52781BE0B4E8A959]](_id_22282E7D48CA3400.team);

      continue;
    }

    _id_3ACF1C0EBAF602F2::displayteamsplash(instance.team, "br_domination_quest_failure");
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", instance.team, 1);
    instance.result = "fail";
  }

  self.locale thread _id_3ACF1C0EBAF602F2::removequestinstance();
}

domflag_onenduse(team, player, success) {
  _id_6663215F917210AE::dompoint_onuseend(team, player, success);
}

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
    case "idle":
    case "off":
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

  _id_3ACF1C0EBAF602F2::displayteamsplash(self.id, "br_domination_quest_timer_expired");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", self.team, 1);
}

getserachparams(tablet) {
  _id_354D1457278B342C = spawnStruct();
  _id_354D1457278B342C.searchfunc = "questPointsArray";
  _id_354D1457278B342C.searchcircleorigin = (tablet.origin[0], tablet.origin[1], 0);
  _id_354D1457278B342C.searchradiusmax = 12000;
  _id_354D1457278B342C.searchradiusmin = 0;
  _id_354D1457278B342C.searchradiusidealmax = 8000;
  _id_354D1457278B342C.searchradiusidealmin = 6000;
  _id_354D1457278B342C.questtypes = 7;
  _id_354D1457278B342C.mintime = getdvarfloat("dvar_4A3E88DCAF980070", 30);
  _id_354D1457278B342C.searchforcecirclecenter = 1;
  _id_354D1457278B342C.reservedplacement = tablet.reservedplacement;

  if(gametypeoverridedomsearchparams() && isDefined(level.quest_domdistmax) && isDefined(level.quest_domdistmin)) {
    if(_id_354D1457278B342C.searchradiusmax < level.quest_domdistmax)
      _id_354D1457278B342C.searchradiusmax = level.quest_domdistmax;

    _id_354D1457278B342C.searchradiusidealmax = level.quest_domdistmax;
    _id_354D1457278B342C.searchradiusidealmin = level.quest_domdistmin;
  }

  return _id_354D1457278B342C;
}

gametypeoverridedomsearchparams() {
  _id_9254FE14251C6557 = 0;
  gametype = scripts\mp\utility\game::getsubgametype();

  switch (gametype) {
    case "vanilla":
    case "mini_mgl":
    case "mini":
    case "risk":
    case "plunder":
      _id_9254FE14251C6557 = 1;
      break;
  }

  return _id_9254FE14251C6557;
}