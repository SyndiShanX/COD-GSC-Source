/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_dom.gsc
***********************************************/

setupobjective(trigger, team, _id_5DDBC1FAED2C56E6, _id_08B9949739F4E0F6, showoncompass) {
  visuals = undefined;

  if(istrue(level._id_2CF7B819EE66EE8E)) {
    visuals = [];
    visuals[0] = trigger;
  } else if(isDefined(trigger.target)) {
    if(!isDefined(trigger.visuals) || trigger.visuals.size == 0)
      visuals[0] = getEnt(trigger.target, "targetname");
    else
      visuals = trigger.visuals;
  }

  if(!isarray(visuals) || visuals.size == 0) {
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0].angles = trigger.angles;
  }

  if(!isDefined(level.flagcapturetime))
    level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 10, 0, 30);

  if(!isDefined(level._id_E42A415AE1C75964))
    level._id_A09B8D25C0133F7E = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTimeMin", 0, 0, 30);

  if(!isDefined(level._id_FB607D7BF823F6F9))
    level._id_FB607D7BF823F6F9 = level.flagcapturetime * 0.5;

  if(isDefined(trigger.objectivekey))
    objectivekey = trigger.objectivekey;
  else if(isDefined(trigger.script_label))
    objectivekey = trigger.script_label;
  else
    objectivekey = "";

  if(isDefined(trigger.iconname))
    iconname = trigger.iconname;
  else
    iconname = trigger.script_label;

  if(istrue(_id_5DDBC1FAED2C56E6))
    _id_3C2389BA69E5822B = getreservedobjid(objectivekey);
  else
    _id_3C2389BA69E5822B = undefined;

  if(!isDefined(team))
    team = "neutral";

  domflag = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, (0, 0, 100), _id_3C2389BA69E5822B, _id_08B9949739F4E0F6, showoncompass);
  domflag scripts\mp\gameobjects::allowuse("enemy");
  domflag scripts\mp\gameobjects::cancontestclaim(1);
  domflag scripts\mp\gameobjects::setusetime(level.flagcapturetime);

  if(isDefined(level.capturetype))
    domflag scripts\mp\gameobjects::setcapturebehavior(getcapturetype());

  domflag.objectivekey = objectivekey;
  domflag.iconname = iconname;

  if(!istrue(_id_08B9949739F4E0F6)) {
    domflag scripts\mp\gameobjects::setvisibleteam("any", undefined, 1);
    domflag.onuse = ::dompoint_onuse;
    domflag.onbeginuse = ::dompoint_onusebegin;
    domflag.onuseupdate = ::dompoint_onuseupdate;
    domflag.onenduse = ::dompoint_onuseend;
    domflag.oncontested = ::dompoint_oncontested;
    domflag.onuncontested = ::dompoint_onuncontested;
    domflag.onunoccupied = ::dompoint_onunoccupied;
    domflag.onpinnedstate = ::dompoint_onpinnedstate;
    domflag.onunpinnedstate = ::dompoint_onunpinnedstate;
    domflag.stompprogressreward = ::dompoint_stompprogressreward;
  }

  domflag.nousebar = 1;
  domflag.id = "domFlag";
  domflag.claimgracetime = level.flagcapturetime * 1000;
  domflag.firstcapture = 1;
  domflag scripts\mp\gameobjects::pinobjiconontriggertouch();
  domflag._id_823C5A7BF6A0E64A = level._id_3D37CDC4C1238328;
  domflag._id_FB60F3AEC3A62F06 = level._id_0393D50BC6A378DC;

  if(istrue(domflag._id_823C5A7BF6A0E64A)) {
    domflag._id_9ABE4AB71AE5D548 = domflag.usetime - 1;
    domflag._id_D701BF01C81A10B3 = level._id_D701BF01C81A10B3;

    if(isDefined(level._id_CF4070FA327A81A2) && level._id_CF4070FA327A81A2 > 0)
      domflag.decayrate = domflag.usetime * level.framedurationseconds / level._id_CF4070FA327A81A2;
  }

  if(istrue(level._id_DD7AF80C3EB2C1E0))
    domflag._id_5261F4479B04F834 = ::_id_5261F4479B04F834;

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

  if(getdvarint("dvar_33AF98C375B98D29") == 1) {
    _id_C6B7900C1FA0A1B6 = trigger.origin + (0, 0, 20);
    _id_62A39A040C10984C = spawnscriptable("mgl_dom_flag", _id_C6B7900C1FA0A1B6);
    _id_62A39A040C10984C.angles = (90, 0, 0);
    _id_62A39A040C10984C setscriptablepartstate("flag", "idle");
    domflag.vfxnamemod = _id_62A39A040C10984C;
  } else
    domflag.vfxnamemod = "";

  domflag.noscriptable = 1;

  if(istrue(level.multiteambased))
    domflag.noscriptable = 1;

  domflag.flagmodel = spawn("script_model", domflag.baseeffectpos);
  domflag.flagmodel.angles = checkmapflagangles(domflag);

  if(!istrue(domflag._id_FB60F3AEC3A62F06))
    domflag.flagmodel setModel(_id_74EAE52F74672509());

  domflag.outlineent = domflag.flagmodel;
  domflag initializematchrecording();

  if(!istrue(_id_08B9949739F4E0F6))
    domflag domflag_setneutral();

  return domflag;
}

removeobjective(domflag) {
  if(isDefined(domflag.flagmodel))
    domflag.flagmodel delete();

  if(isDefined(domflag.scriptable))
    domflag.scriptable delete();

  domflag scripts\mp\gameobjects::deleteuseobject();
}

getreservedobjid(objectivekey) {
  if(objectivekey == "_a")
    _id_AA530B7C5AEFA0B4 = 0;
  else if(objectivekey == "_b")
    _id_AA530B7C5AEFA0B4 = 1;
  else if(objectivekey == "_d")
    _id_AA530B7C5AEFA0B4 = 3;
  else if(objectivekey == "_e")
    _id_AA530B7C5AEFA0B4 = 4;
  else
    _id_AA530B7C5AEFA0B4 = 2;

  return _id_AA530B7C5AEFA0B4;
}

getcapturetype() {
  capturetype = "normal";

  if(level.capturetype == 2)
    capturetype = "neutralize";
  else if(level.capturetype == 3)
    capturetype = "persistent";

  return capturetype;
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

  switch (level.mapname) {
    case "mp_quarry":
      if(label == "_c")
        offset = offset + (0, 0, 7);

      break;
    case "mp_divide":
      if(label == "_a")
        offset = offset + (0, 0, 4.5);

      break;
    case "mp_afghan":
      if(label == "_a")
        offset = offset + (0, 0, 5);

      if(label == "_c")
        offset = offset + (0, 0, 1);

      break;
    case "mp_wartorn_gw":
      if(label == "_c")
        offset = offset + (0, 0, -24);

      break;
  }

  return offset;
}

checkmapfxangles(domflag, upangles) {
  label = domflag.objectivekey;
  angles = upangles;

  switch (level.mapname) {
    case "mp_quarry":
      if(label == "_c")
        angles = (276.5, angles[1], angles[2]);

      break;
    case "mp_divide":
      if(label == "_a")
        angles = (273.5, angles[1], angles[2]);

      break;
    case "mp_afghan":
      if(label == "_a")
        angles = (273.5, 200.5, angles[2]);

      if(label == "_c")
        angles = (273.5, angles[1], angles[2]);

      break;
    case "mp_faridah":
      if(isstring(label)) {
        if(label == "_school")
          angles = (270, 0, 0);
        else if(label == "_warehouse")
          angles = (270, 0, 0);
      }

      break;
  }

  return angles;
}

initializematchrecording() {
  if(isDefined(level.matchrecording_logevent)) {
    self.logid = [[level.matchrecording_generateid]]();
    _id_E7F2024E573E0BEF = "A";

    switch (self.objectivekey) {
      case "_a":
        _id_E7F2024E573E0BEF = "A";
        break;
      case "_b":
        _id_E7F2024E573E0BEF = "B";
        break;
      case "_c":
        _id_E7F2024E573E0BEF = "C";
        break;
      case "_d":
        _id_E7F2024E573E0BEF = "D";
        break;
      case "_e":
        _id_E7F2024E573E0BEF = "E";
        break;
      case "0":
        _id_E7F2024E573E0BEF = "0";
        break;
      case "1":
        _id_E7F2024E573E0BEF = "1";
        break;
      case "2":
        _id_E7F2024E573E0BEF = "2";
        break;
      case "3":
        _id_E7F2024E573E0BEF = "3";
        break;
      case "4":
        _id_E7F2024E573E0BEF = "4";
        break;
      default:
        break;
    }

    self.logeventflag = "FLAG_" + _id_E7F2024E573E0BEF;
  }

  if(scripts\mp\analyticslog::analyticslogenabled()) {
    self.analyticslogid = scripts\mp\analyticslog::getuniqueobjectid();
    self.analyticslogtype = "dom_flag" + self.objectivekey;
  }
}

domflag_setneutral(_id_431C28FD393513A5) {
  self notify("flag_neutral");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral, undefined, undefined, undefined, 1);
  scripts\mp\gameobjects::setownerteam("neutral");
  thread updateflagstate("idle", istrue(_id_431C28FD393513A5));

  if(isDefined(level.matchrecording_logevent) && isDefined(self.logid) && isDefined(self.logeventflag))
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), 0);

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "neutral");
}

dompoint_setcaptured(team, _id_22282E7D48CA3400) {
  scripts\mp\gameobjects::setownerteam(team);

  if(isDefined(_id_22282E7D48CA3400)) {
    self notify("capture", _id_22282E7D48CA3400);
    self notify("assault", _id_22282E7D48CA3400);
  }

  friendlyicon = scripts\engine\utility::ter_op(istrue(self._id_823C5A7BF6A0E64A), level._id_0A58E0495B821276, level.icondefending);
  scripts\mp\gameobjects::setobjectivestatusicons(friendlyicon, level.iconcapture);

  if(scripts\mp\utility\game::getgametype() == "btm")
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(self.ownerteam, "flag_defend", "flag_capture");

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

      if(!isPlayer(player)) {
        continue;
      }
      player scripts\cp_mp\challenges::oncapture();
    }
  }

  if(istrue(level._id_701CE1283B8E2DB7)) {
    _id_BDE78B1B09AE7F75 = getteamflagcount(team);

    if(_id_BDE78B1B09AE7F75 == level.flagsrequiredtoscore) {
      scripts\mp\utility\dialog::statusdialog("friendly_scoring", team);
      scripts\mp\utility\dialog::statusdialog("enemy_scoring", scripts\mp\utility\game::getotherteam(team)[0]);
    }
  }

  if(isDefined(_id_22282E7D48CA3400) && !isagent(_id_22282E7D48CA3400))
    thread _id_365A810F08434CAB(self.touchlist[team], _id_22282E7D48CA3400, team);

  if(isDefined(level.matchrecording_logevent))
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), scripts\engine\utility::ter_op(team == "allies", 1, 2));

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + team);
}

dompoint_onuse(_id_22282E7D48CA3400, team) {
  if(!isDefined(team))
    team = _id_22282E7D48CA3400.team;

  if(istrue(self._id_823C5A7BF6A0E64A)) {
    if(isDefined(self.ownerteam) && self.ownerteam == team) {
      if(!istrue(self._id_11D80259A066AB76)) {
        self._id_11D80259A066AB76 = 1;

        if(isDefined(self.decayrate) && self.decayrate > 0)
          thread scripts\mp\gameobjects::useobjectdecay(team);
      }

      self.curprogress = self._id_9ABE4AB71AE5D548;
      self.teamprogress[self.ownerteam] = self.curprogress;
      return;
    } else
      scripts\mp\gameobjects::allowuse("any");
  }

  _id_8A04AA0E0755E7E3 = scripts\mp\gameobjects::getownerteam();
  self._id_8A04AA0E0755E7E3 = _id_8A04AA0E0755E7E3;
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;

  if(istrue(level.flagneutralization)) {
    ownerteam = scripts\mp\gameobjects::getownerteam();

    if(ownerteam == "neutral") {
      dompoint_setcaptured(team, _id_22282E7D48CA3400);

      if(isDefined(self._id_5261F4479B04F834))
        [[self._id_5261F4479B04F834]]();
    } else {
      thread domflag_setneutral(1);
      scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", ownerteam);
      level.lastcaptime = gettime();
      thread giveflagassistedcapturepoints(self.touchlist[team]);
      self.neutralized = 1;
    }
  } else {
    dompoint_setcaptured(team, _id_22282E7D48CA3400);

    if(isDefined(self._id_5261F4479B04F834))
      [[self._id_5261F4479B04F834]]();
  }

  if(!self.neutralized && !isDefined(self._id_B2555C1E8CA32569)) {
    _id_87FB87A85BBC8FB4 = 3;

    if(self.objectivekey == "_a")
      _id_87FB87A85BBC8FB4 = 1;
    else if(self.objectivekey == "_b")
      _id_87FB87A85BBC8FB4 = 2;
    else if(self.objectivekey == "_d")
      _id_87FB87A85BBC8FB4 = 4;
    else if(self.objectivekey == "_e")
      _id_87FB87A85BBC8FB4 = 5;

    if(isDefined(_id_22282E7D48CA3400) && !isagent(_id_22282E7D48CA3400))
      _id_548072087C9FD504::_id_7D42D3F8DD68280C(21, team, _id_22282E7D48CA3400 getentitynumber(), _id_87FB87A85BBC8FB4);

    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, _id_22282E7D48CA3400, team, _id_8A04AA0E0755E7E3, self);

      if(isDefined(_id_22282E7D48CA3400) && !isagent(_id_22282E7D48CA3400)) {
        announcement = "Flag " + getobjectiveflag() + " Captured";

        if(_id_8A04AA0E0755E7E3 == "neutral" || _id_8A04AA0E0755E7E3 == "none")
          scripts\mp\utility\game::logannouncement(_id_22282E7D48CA3400, undefined, announcement, _id_22282E7D48CA3400.origin, "neutral_flag");
        else
          scripts\mp\utility\game::logannouncement(_id_22282E7D48CA3400, undefined, announcement, _id_22282E7D48CA3400.origin);
      }
    }
  }

  self._id_B2555C1E8CA32569 = undefined;
  self.firstcapture = 0;
}

dompoint_onusebegin(player) {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  player.isonobjective = 1;
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

  if(isPlayer(player))
    player setclientomnvar("ui_objective_pinned_text_param", _id_024C76FC549F7FD9);

  if(!isDefined(self.statusnotifytime))
    self.statusnotifytime = gettime();

  if(!istrue(self.neutralized) && self.statusnotifytime > self.statusnotifytime + 5000) {
    self.didstatusnotify = 0;
    self.statusnotifytime = gettime();
  }

  usetime = level.flagcapturetime;

  if(istrue(level.flagneutralization) && !self.firstcapture) {
    usetime = level._id_FB607D7BF823F6F9;
    scripts\mp\gameobjects::setusetime(usetime, 1);
  } else if(isDefined(self._id_3B3185F4D42EE4E6)) {
    usetime = self._id_3B3185F4D42EE4E6;
    scripts\mp\gameobjects::setusetime(self._id_3B3185F4D42EE4E6);
  }

  if(usetime > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(player.team)[0];
    updateflagcapturestate(player.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
  }

  if(istrue(level.hideenemyfobs)) {
    if(player.team != ownerteam)
      scripts\mp\gameobjects::setvisibleteam("any");
  }
}

dompoint_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  scripts\mp\objidpoolmanager::_id_9B1A086F348520B0(self.objidnum, team);
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(!istrue(self.stalemate) && !istrue(self._id_3BA42E8C18B42C71) && progress < 1.0 && !level.gameended && !scripts\mp\utility\game::isanymlgmatch())
    play_dom_capture_sfx(progress, team);

  if(isDefined(level._id_DA41C55843E26237) && level._id_DA41C55843E26237) {
    _id_4A021F1EDE7E0C69 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_DA41C55843E26237; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(self._id_AE9B09D28693B763))
        self._id_AE9B09D28693B763 = 0;

      _id_56BEE12D8B5FEB15 = (_id_AC0E594AC96AA3A8 + 1) / 3;

      if(progress >= _id_56BEE12D8B5FEB15 && self._id_AE9B09D28693B763 <= _id_AC0E594AC96AA3A8) {
        self._id_AE9B09D28693B763 = _id_AC0E594AC96AA3A8 + 1;
        _id_4A021F1EDE7E0C69 = 1;
      }
    }

    if(_id_4A021F1EDE7E0C69) {
      foreach(struct in self.touchlist[team]) {
        player = struct.player;

        if(self._id_AE9B09D28693B763 != level._id_DA41C55843E26237) {
          player thread scripts\mp\rank::scoreeventpopup("stat_08A403758F1D2485");
          player setclientomnvar("ui_segment_captured", self._id_AE9B09D28693B763);
        }

        player scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(8, 1);
      }

      if(isDefined(self._id_916E4C007C6B8BA1))
        self[[self._id_916E4C007C6B8BA1]](team, _id_4B22E50E504339FE, self._id_AE9B09D28693B763);

      if(self._id_AE9B09D28693B763 != level._id_DA41C55843E26237) {
        _id_AAAB07C97E1F0BA7 = 2;

        if(self.objectivekey == "_a")
          _id_AAAB07C97E1F0BA7 = 1;

        _id_548072087C9FD504::_id_7D42D3F8DD68280C(23, team, _id_4B22E50E504339FE getentitynumber(), _id_AAAB07C97E1F0BA7);
      }

      _id_7E2C53B0BCF117D9 = spawnStruct();
      _id_7E2C53B0BCF117D9._id_239B4B5FA4BCF6C6 = self;
      _id_7E2C53B0BCF117D9._id_22282E7D48CA3400 = _id_4B22E50E504339FE;
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_objective_state_changed", _id_7E2C53B0BCF117D9);
    }
  }

  if(progress > 0 && _id_301D62DA1A0738F1 && !self.didstatusnotify) {
    if(isDefined(self.objectivekey) || !istrue(level._id_25E8B4AFE5E06169)) {
      if(ownerteam == "neutral") {
        if(level.flagcapturetime > 0.05) {
          scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, team);
          _id_FE12933325AEFAC7 = isDefined(level.objectives) && level.objectives.size == 3 && !istrue(level.ingraceperiod);
          _id_1A26705E7134A49E = isDefined(level.objectives) && level.objectives.size == 5 && (self.objectivekey == "_b" || self.objectivekey == "_c" || self.objectivekey == "_d");

          if(_id_FE12933325AEFAC7 || _id_1A26705E7134A49E) {
            otherteam = scripts\mp\utility\game::getotherteam(team)[0];
            scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, otherteam);
          }
        }
      } else if(level.flagcapturetime > 0.05 && (!istrue(self._id_823C5A7BF6A0E64A) || team != ownerteam)) {
        scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, ownerteam);
        scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, team);
      }
    }

    self.didstatusnotify = 1;
  }
}

dompoint_onuseend(team, player, success) {
  if(isPlayer(player))
    player setclientomnvar("ui_objective_pinned_text_param", 0);

  if(isDefined(player))
    player.isonobjective = 0;

  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    thread updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    thread updateflagstate(ownerteam, 0);
  }

  if(!success)
    self.neutralized = 0;
}

dompoint_oncontested() {
  self.contestedtime = gettime();
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread updateflagstate("contested", 0);
  scripts\mp\objidpoolmanager::_id_9B1A086F348520B0(self.objidnum, "neutral");
}

dompoint_onuncontested(lastclaimteam) {
  if(istrue(level.flagneutralization) && !self.firstcapture)
    scripts\mp\gameobjects::setusetime(level.flagcapturetime * 0.5);

  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    if(lastclaimteam != "none")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, lastclaimteam);
    else if(isDefined(self.lastprogressteam))
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, self.lastprogressteam);
  } else
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(ownerteam)[0]);

  if(lastclaimteam == "none" || ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else if(scripts\mp\utility\game::getgametype() == "control" && ownerteam != "neutral") {
    if(ownerteam != lastclaimteam)
      scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.icontaking);
    else
      scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  contestedtime = (gettime() - self.contestedtime) * 0.001;
  message = "Flag " + getobjectiveflag() + " Contested";
  scripts\mp\utility\game::logannouncement(undefined, undefined, message, self.trigger.origin, contestedtime + " seconds");
  self.contestedtime = undefined;
  _id_FF99447227B9FBAC = scripts\engine\utility::ter_op(ownerteam == "neutral", "idle", ownerteam);
  thread updateflagstate(_id_FF99447227B9FBAC, 0);
  scripts\mp\objidpoolmanager::_id_9B1A086F348520B0(self.objidnum, "neutral");
}

play_dom_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    progress = int(floor(progress * 10));
    soundalias = "mp_dom_capturing_tick_0" + progress;
    self.visuals[0] playsoundtoteam(soundalias, team);

    if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2()) {
      if(progress == 2) {
        soundalias = "iw9_dom_scarecrow_laugh_01";
        self.visuals[0] playsoundtoteam(soundalias, team);
      } else if(progress == 6) {
        soundalias = "iw9_dom_scarecrow_laugh_02";
        self.visuals[0] playsoundtoteam(soundalias, team);
      }
    }

    self.lastsfxplayedtime = gettime();
  }
}

dompoint_onunoccupied() {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral")
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  self.didstatusnotify = 0;
  scripts\mp\objidpoolmanager::_id_9B1A086F348520B0(self.objidnum, "neutral");
}

dompoint_onpinnedstate(player) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.lastprogressteam] > 0 && self.teamprogress[self.claimteam] == 0) {
      scripts\mp\gameobjects::setobjectivestatusicons(level._id_88E61386EF037AAF, level.iconcapture);

      if(player.team == self.ownerteam)
        scripts\mp\objidpoolmanager::_id_8F7A55BDA12EBB21(&"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", player);
    } else {
      friendlyicon = scripts\engine\utility::ter_op(istrue(self._id_823C5A7BF6A0E64A), level._id_0A58E0495B821276, level.icondefending);
      scripts\mp\gameobjects::setobjectivestatusicons(friendlyicon, level.iconcapture);

      if(player.team == self.ownerteam)
        scripts\mp\objidpoolmanager::_id_8F7A55BDA12EBB21(&"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player);
    }
  }
}

dompoint_onunpinnedstate(player) {
  if(!self.stalemate) {
    if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] || isDefined(player.team) && !self.numtouching[player.team])
      scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }
}

_id_3DC46DF97466E4D3(team) {
  if(istrue(self._id_823C5A7BF6A0E64A)) {
    if(isDefined(self.ownerteam) && self.ownerteam != "neutral" && team != self.ownerteam) {
      self._id_11D80259A066AB76 = 0;
      self notify("useObjectDecay");
    }
  }
}

dompoint_stompprogressreward(player) {
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F648E4847B740818");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
  scripts\mp\objidpoolmanager::_id_8F7A55BDA12EBB21(&"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player);
}

setcrankedtimerdomflag(player) {
  if((scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(player)) && isDefined(player.cranked) && player.cranked)
    player scripts\mp\cranked::setcrankedplayerbombtimer("assist");
}

_id_5261F4479B04F834() {
  _id_869E9FD0CDBD405A = 20;
  _id_12F59CD9E8D7E077 = 600;
  origin = self.flagmodel.origin;
  _id_16C9AD20A2797135 = origin + (0, 0, _id_869E9FD0CDBD405A);
  _id_812238F6F1F6728C = origin + (0, 0, _id_12F59CD9E8D7E077);
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  ignoreents = level.players;
  ignoreents[ignoreents.size] = self.flagmodel;
  trace = scripts\engine\trace::ray_trace(_id_16C9AD20A2797135, _id_812238F6F1F6728C, ignoreents, contentoverride, 0);

  if(isPlayer(trace["entity"]))
    trace["entity"] = undefined;

  if(isDefined(trace["entity"]) && isDefined(trace["entity"].code_classname) && trace["entity"].code_classname == "script_vehicle") {
    ignoreents[ignoreents.size] = trace["entity"];
    trace = scripts\engine\trace::ray_trace(_id_16C9AD20A2797135, _id_812238F6F1F6728C, ignoreents, contentoverride, 0);
  }

  if(trace["fraction"] != 1) {
    _id_869E9FD0CDBD405A = 4000;
    _id_12F59CD9E8D7E077 = 20;
    origin = self.flagmodel.origin;
    _id_16C9AD20A2797135 = origin + (0, 0, _id_869E9FD0CDBD405A);
    _id_812238F6F1F6728C = origin + (0, 0, _id_12F59CD9E8D7E077);
    contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
    ignoreents = [];
    ignoreents = level.players;
    ignoreents[ignoreents.size] = self.flagmodel;
    trace = scripts\engine\trace::ray_trace(_id_16C9AD20A2797135, _id_812238F6F1F6728C, ignoreents, contentoverride, 0);

    if(isPlayer(trace["entity"]))
      trace["entity"] = undefined;

    if(isDefined(trace["entity"]) && isDefined(trace["entity"].code_classname) && trace["entity"].code_classname == "script_vehicle") {
      ignoreents[ignoreents.size] = trace["entity"];
      trace = scripts\engine\trace::ray_trace(_id_16C9AD20A2797135, _id_812238F6F1F6728C, ignoreents, contentoverride, 0);
    }

    if(trace["fraction"] != 1) {
      playFX(level._id_B6E1C0B3C715B0DF["gos_fireworks"], trace["position"]);
      playFX(level._id_B6E1C0B3C715B0DF["gos_fireworks"], trace["position"], anglesToForward(self.flagmodel.angles) + (-10, -10, 0));
      playFX(level._id_B6E1C0B3C715B0DF["gos_fireworks"], trace["position"], anglesToForward(self.flagmodel.angles) + (10, 10, 0));
      level thread _id_0FD32F08E72B657F::_id_2C3362A9F434FD8D(trace["position"]);
    }
  } else {
    playFX(level._id_B6E1C0B3C715B0DF["gos_fireworks"], origin);
    playFX(level._id_B6E1C0B3C715B0DF["gos_fireworks"], origin, anglesToForward(self.flagmodel.angles) + (-10, -10, 0));
    playFX(level._id_B6E1C0B3C715B0DF["gos_fireworks"], origin, anglesToForward(self.flagmodel.angles) + (10, 10, 0));
    level thread _id_0FD32F08E72B657F::_id_2C3362A9F434FD8D(origin);
  }
}

dompoint_setupflagmodels() {
  game["flagmodels"] = [];
  game["flagmodels"]["neutral"] = "prop_flag_neutral";
}

updateflagstate(state, _id_431C28FD393513A5, ownerteam) {
  self notify("updateFlagState");
  self endon("updateFlagState");

  if(isDefined(ownerteam) && !istrue(self._id_FB60F3AEC3A62F06)) {
    if(getdvarint("dvar_33AF98C375B98D29") == 1) {
      if(ownerteam == "allies") {
        self.flagmodel setModel(_id_0CFEE0E9DDE10B08());
        self.vfxnamemod setscriptablepartstate("flag", "allies");
      } else if(ownerteam == "axis") {
        self.flagmodel setModel(_id_4D38B08CD23BE40D());
        self.vfxnamemod setscriptablepartstate("flag", "axis");
      } else {
        self.flagmodel setModel(_id_74EAE52F74672509());
        self.vfxnamemod setscriptablepartstate("flag", "idle");
      }
    } else if(ownerteam == "allies")
      self.flagmodel setModel(_id_0CFEE0E9DDE10B08());
    else if(ownerteam == "axis")
      self.flagmodel setModel(_id_4D38B08CD23BE40D());
    else
      self.flagmodel setModel(_id_74EAE52F74672509());
  }

  if(isDefined(self.noscriptable)) {
    return;
  }
  while(!isDefined(self.scriptable))
    waitframe();

  if(scripts\mp\utility\game::getgametype() == "defcon") {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "risk") {
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
  if(scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "conflict" && scripts\mp\utility\game::getgametype() != "risk" && scripts\mp\utility\game::getgametype() != "defcon") {
    if(isDefined(self.scriptable))
      setdomscriptablepartstate("pulse", state, self.vfxnamemod);
  }
}

ondisconnect() {
  self waittill("disconnect");

  foreach(effect in self._domflageffect) {
    if(isDefined(effect))
      effect delete();
  }

  foreach(_id_25449D53B65E2377 in self._domflagpulseeffect) {
    if(isDefined(_id_25449D53B65E2377))
      _id_25449D53B65E2377 delete();
  }
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
    if(istrue(level.flagneutralization))
      player thread scripts\mp\rank::scoreeventpopup("stat_8FA9BCF9EAAC78FA");
    else
      player thread scripts\mp\rank::scoreeventpopup("stat_F4CD65EB4AA3FD61");

    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_52BBD83ACF4ACB07");
    player setcrankedtimerdomflag(player);
    wait 0.05;
  }
}

_id_365A810F08434CAB(touchlist, _id_22282E7D48CA3400, team) {
  level endon("game_ended");
  _id_0666D6B1872868D7 = _id_22282E7D48CA3400;

  if(isDefined(_id_0666D6B1872868D7.owner))
    _id_0666D6B1872868D7 = _id_0666D6B1872868D7.owner;

  level.lastcaptime = gettime();
  level.playholdtwovo = 1;

  if(isPlayer(_id_0666D6B1872868D7)) {
    if(scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "rush" || scripts\mp\utility\game::getgametype() == "risk")
      level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition", _id_0666D6B1872868D7);
    else
      level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition" + self.objectivekey, _id_0666D6B1872868D7);

    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = _id_0666D6B1872868D7;
    _id_7E2C53B0BCF117D9.eventname = "capture";
    _id_7E2C53B0BCF117D9.position = _id_0666D6B1872868D7.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  }

  if(self.firstcapture == 1)
    _id_EF569CF5D2F71E64 = 1;
  else
    _id_EF569CF5D2F71E64 = 0;

  if(isDefined(touchlist)) {
    _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

    for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
      player = touchlist[_id_59DB5D0F4E3000A7[index]].player;

      if(isDefined(player.owner))
        player = player.owner;

      if(!isPlayer(player)) {
        continue;
      }
      player setcapturestats();
      givecaptureawards(player, _id_EF569CF5D2F71E64, 0);
      setcrankedtimerdomflag(player);
      scripts\mp\objidpoolmanager::_id_8F7A55BDA12EBB21(&"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player);
      wait 0.05;
    }

    if(isDefined(self.assisttouchlist)) {
      if(self.assisttouchlist[team].size > 0) {
        _id_9EB80458EF362367 = getarraykeys(self.assisttouchlist[team]);

        foreach(id in _id_59DB5D0F4E3000A7) {
          foreach(_id_2C6D54A195121E5F in _id_9EB80458EF362367) {
            if(_id_2C6D54A195121E5F == id)
              self.assisttouchlist[team][_id_2C6D54A195121E5F] = undefined;
          }
        }
      }

      if(self.assisttouchlist[team].size > 0)
        thread giveflagcaptureassistxp(team, _id_EF569CF5D2F71E64);
    }
  }
}

giveflagcaptureassistxp(team, _id_EF569CF5D2F71E64) {
  level endon("game_ended");
  _id_9EB80458EF362367 = getarraykeys(self.assisttouchlist[team]);

  if(_id_9EB80458EF362367.size > 0) {
    for(index = 0; index < _id_9EB80458EF362367.size; index++) {
      player = self.assisttouchlist[team][_id_9EB80458EF362367[index]].player;

      if(isDefined(player.owner))
        player = player.owner;

      if(!isPlayer(player)) {
        continue;
      }
      player setcapturestats();
      givecaptureawards(player, _id_EF569CF5D2F71E64, 1);
      setcrankedtimerdomflag(player);
      self.assisttouchlist[team][_id_9EB80458EF362367[index]] = undefined;
      wait 0.05;
    }
  }
}

givecaptureawards(player, _id_EF569CF5D2F71E64, _id_C9DB681C20FEFFE2) {
  _id_460513A84DF1C3A4 = 0;
  _id_534BE0691DDBB3BA = "stat_0000000000000000";

  if(_id_C9DB681C20FEFFE2) {
    player thread scripts\mp\rank::scoreeventpopup("stat_971A82E17E683215");
    _id_534BE0691DDBB3BA = "stat_7A10D07E9CC5745B";
  } else if(_id_EF569CF5D2F71E64) {
    _id_F0FDD3926C21BFE1 = scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "risk" || scripts\mp\utility\game::getgametype() == "gwai";
    _id_6A7760FE689E9225 = !_id_F0FDD3926C21BFE1 && self.objectivekey == "_b" || _id_F0FDD3926C21BFE1 && self.objectivekey == "_c";
    _id_33C298715A11A534 = _id_F0FDD3926C21BFE1 && (self.objectivekey == "_b" || self.objectivekey == "_d");

    if(_id_6A7760FE689E9225) {
      if(_id_F0FDD3926C21BFE1) {
        player thread scripts\mp\rank::scoreeventpopup("stat_6768F55428D37201");
        _id_534BE0691DDBB3BA = "stat_87F6A8171E213A70";
      } else {
        player thread scripts\mp\rank::scoreeventpopup("stat_42F35AF3197F7EAC");
        _id_534BE0691DDBB3BA = "stat_6CD3785899A62D4A";
      }
    } else if(_id_33C298715A11A534) {
      player thread scripts\mp\rank::scoreeventpopup("stat_6768F55428D37201");
      _id_534BE0691DDBB3BA = "stat_2824DB5042D26E38";
    } else if(_id_F0FDD3926C21BFE1) {
      player thread scripts\mp\rank::scoreeventpopup("stat_6768F55428D37201");
      _id_534BE0691DDBB3BA = "stat_58727F626AA03B19";
    } else {
      player thread scripts\mp\rank::scoreeventpopup("stat_6768F55428D37201");
      _id_534BE0691DDBB3BA = "stat_A6E3B07F24A55E2B";
    }
  } else if(istrue(level.flagneutralization)) {
    player thread scripts\mp\rank::scoreeventpopup("stat_F4CD65EB4AA3FD61");
    _id_534BE0691DDBB3BA = "stat_A500EA17E54288A0";
  } else {
    player thread scripts\mp\rank::scoreeventpopup("stat_F4CD65EB4AA3FD61");
    _id_534BE0691DDBB3BA = "stat_5A7B15A24E10A93B";
  }

  player thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_534BE0691DDBB3BA);

  if(_id_460513A84DF1C3A4)
    player scripts\mp\killstreaks\killstreaks::givestreakpoints("stat_F4CD65EB4AA3FD61", 1, 0);
}

setcapturestats() {
  scripts\mp\utility\stats::incpersstat("captures", 1);

  if(isDefined(self.pers["captures"])) {
    scripts\mp\persistence::statsetchild("round", "captures", self.pers["captures"]);

    if(scripts\mp\utility\game::getgametype() != "arena")
      scripts\mp\utility\stats::setextrascore0(self.pers["captures"]);
  }
}

precap(_id_0DC617B1666471F3) {
  storecenterflag(_id_0DC617B1666471F3);
  _id_3B7E9E038A6DFEDA = [];
  _id_3B7E9E038A6DFEDA[_id_3B7E9E038A6DFEDA.size] = level.centerflag;

  if(game["switchedsides"]) {
    level.closestalliesflag = getunownedflagneareststart("axis", level.centerflag);
    _id_3B7E9E038A6DFEDA[_id_3B7E9E038A6DFEDA.size] = level.closestalliesflag;
    level.closestaxisflag = getunownedflagneareststart("allies", _id_3B7E9E038A6DFEDA);
  } else {
    level.closestalliesflag = getunownedflagneareststart("allies", level.centerflag);
    _id_3B7E9E038A6DFEDA[_id_3B7E9E038A6DFEDA.size] = level.closestalliesflag;
    level.closestaxisflag = getunownedflagneareststart("axis", _id_3B7E9E038A6DFEDA);
  }

  level.closestalliesflag setflagcaptured("allies", "neutral", undefined, 1);
  level.closestaxisflag setflagcaptured("axis", "neutral", undefined, 1);
}

storecenterflag(_id_0DC617B1666471F3) {
  _id_253879C7BDCE626A = undefined;

  foreach(flag in level.objectives) {
    if(istrue(_id_0DC617B1666471F3)) {
      if(flag.objectivekey == "_c")
        level.centerflag = flag;
    }

    if(flag.objectivekey == "_b")
      level.centerflag = flag;
  }
}

setflagcaptured(team, _id_8A04AA0E0755E7E3, _id_22282E7D48CA3400, _id_230445C943C9459A) {
  scripts\mp\gameobjects::setownerteam(team);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
  thread updateflagstate(team, 0, team);
  self.capturetime = gettime();
  gametype = scripts\mp\utility\game::getgametype();

  if(gametype == "siege")
    _id_6B62860A8ACD5C43::watchflagenduse(team);

  if(!isDefined(_id_230445C943C9459A)) {
    if(_id_8A04AA0E0755E7E3 != "neutral") {
      _id_BDE78B1B09AE7F75 = getteamflagcount(team);

      if(_id_BDE78B1B09AE7F75 == 2) {
        scripts\mp\utility\dialog::statusdialog("friendly_captured_2", team);
        scripts\mp\utility\dialog::statusdialog("enemy_captured_2", _id_8A04AA0E0755E7E3);
      } else {
        scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, team);
        scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, _id_8A04AA0E0755E7E3);
      }

      level.lastcaptime = gettime();
    }

    if(gametype == "siege")
      _id_6B62860A8ACD5C43::teamrespawn(team, _id_22282E7D48CA3400);

    self.firstcapture = 0;
  }

  if(istrue(self._id_823C5A7BF6A0E64A))
    scripts\mp\gameobjects::allowuse("any");
}

getteamflagcount(team, _id_0EA084D6BB059D6B) {
  score = 0;

  foreach(objective in level.objectives) {
    if(istrue(_id_0EA084D6BB059D6B)) {
      if(objective.stalemate || objective.captureblocked || objective.claimteam != "none" && objective.claimteam != team)
        continue;
    }

    if(objective.ownerteam == team)
      score++;
  }

  return score;
}

isflagexcluded(_id_4DDC8D75E113B606, _id_3EF5EF008F24BF47) {
  _id_80BF6212193E8983 = 0;

  if(isarray(_id_3EF5EF008F24BF47)) {
    foreach(flag in _id_3EF5EF008F24BF47) {
      if(_id_4DDC8D75E113B606 == flag) {
        _id_80BF6212193E8983 = 1;
        break;
      }
    }
  } else if(_id_4DDC8D75E113B606 == _id_3EF5EF008F24BF47)
    _id_80BF6212193E8983 = 1;

  return _id_80BF6212193E8983;
}

getunownedflagneareststart(team, _id_3EF5EF008F24BF47) {
  _id_3C7588416D5EB213 = undefined;
  _id_A52892DFFB2F5A53 = undefined;
  _id_579DA7B2997DEC60 = undefined;

  foreach(flag in level.objectives) {
    if(flag scripts\mp\gameobjects::getownerteam() != "neutral") {
      continue;
    }
    distsq = distancesquared(flag.trigger.origin, level.startpos[team]);

    if(isDefined(_id_3EF5EF008F24BF47)) {
      if(!isflagexcluded(flag, _id_3EF5EF008F24BF47) && (!isDefined(_id_3C7588416D5EB213) || distsq < _id_A52892DFFB2F5A53)) {
        _id_A52892DFFB2F5A53 = distsq;
        _id_3C7588416D5EB213 = flag;
      }

      continue;
    }

    if(!isDefined(_id_3C7588416D5EB213) || distsq < _id_A52892DFFB2F5A53) {
      _id_A52892DFFB2F5A53 = distsq;
      _id_3C7588416D5EB213 = flag;
    }
  }

  return _id_3C7588416D5EB213;
}

awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(isagent(attacker)) {
    return;
  }
  if(!isDefined(attacker) || !isDefined(self)) {
    return;
  }
  if(!isDefined(attacker.team) || !isDefined(self.team)) {
    return;
  }
  if(!attacker scripts\cp_mp\utility\player_utility::isenemy(self)) {
    return;
  }
  _id_9FF9376383F4BC58 = 0;
  _id_8363BEB01B537D3E = 0;
  _id_88F4967A49A22ED7 = 0;
  victim = self;
  _id_F7DED1FDB02A123D = victim.origin;
  _id_86C1C8628B1D55F8 = attacker.origin;

  if(isDefined(einflictor))
    _id_86C1C8628B1D55F8 = einflictor.origin;

  foreach(flag in level.objectives) {
    if(!isDefined(flag.trigger) || istrue(flag.trigger.trigger_off)) {
      continue;
    }
    ownerteam = flag scripts\mp\gameobjects::getownerteam();
    _id_31E1574AABDEFEAB = attacker istouching(flag.trigger);
    _id_FD534BAA79DD395C = victim istouching(flag.trigger);

    if(_id_31E1574AABDEFEAB && attacker.team != ownerteam) {
      attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_470103FDE6A5E1AE");
      flag notify("assault", attacker);
      _id_8363BEB01B537D3E = 1;
    }

    if(ownerteam == "neutral") {
      if(_id_31E1574AABDEFEAB || _id_FD534BAA79DD395C) {
        if(flag.claimteam == victim.team) {
          if(!_id_8363BEB01B537D3E) {
            _id_8363BEB01B537D3E = 1;
            attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
            attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
            flag notify("assault", attacker);
            thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "assaulting");
            continue;
          }
        } else if(flag.claimteam == attacker.team) {
          if(!_id_88F4967A49A22ED7) {
            _id_88F4967A49A22ED7 = 1;
            attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
            attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
            flag notify("defend", attacker);
            attacker scripts\mp\utility\stats::incpersstat("defends", 1);
            attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
            attacker scripts\mp\utility\stats::setextrascore1(attacker.pers["defends"]);
            thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "defending");
            continue;
          }
        }
      }
    } else if(ownerteam != attacker.team) {
      if(!_id_8363BEB01B537D3E) {
        _id_A3A2CE8B8E74EBEF = _id_31E1574AABDEFEAB || distsquaredcheck(flag.trigger, _id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D);

        if(_id_A3A2CE8B8E74EBEF) {
          _id_8363BEB01B537D3E = 1;
          attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
          attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
          flag notify("assault", attacker);
          thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "assaulting");
          continue;
        }
      }
    } else if(!_id_88F4967A49A22ED7) {
      _id_F6A091229A5E7B04 = _id_FD534BAA79DD395C || distsquaredcheck(flag.trigger, _id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D);

      if(_id_F6A091229A5E7B04) {
        _id_88F4967A49A22ED7 = 1;
        attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
        flag notify("defend", attacker);
        attacker scripts\mp\utility\stats::incpersstat("defends", 1);
        attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
        attacker scripts\mp\utility\stats::setextrascore1(attacker.pers["defends"]);
        thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "defending");
        continue;
      }
    }
  }
}

distsquaredcheck(trigger, _id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D) {
  _id_9AE8B00A8E8F64FA = distancesquared(trigger.origin, _id_86C1C8628B1D55F8);
  _id_1881A89C6F1E8775 = distancesquared(trigger.origin, _id_F7DED1FDB02A123D);
  _id_0261168EF0C9F4F3 = scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "risk";
  _id_F6C2AAD81E18E09D = scripts\engine\utility::ter_op(_id_0261168EF0C9F4F3, 422500, 105625);

  if(_id_9AE8B00A8E8F64FA < _id_F6C2AAD81E18E09D || _id_1881A89C6F1E8775 < _id_F6C2AAD81E18E09D) {
    if(!isDefined(trigger.modifieddefendcheck))
      return 1;
    else if(_id_86C1C8628B1D55F8[2] - trigger.origin[2] < 100 || _id_F7DED1FDB02A123D[2] - trigger.origin[2] < 100)
      return 1;
    else
      return 0;
  } else
    return 0;
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

getobjectiveflag() {
  switch (self.objectivekey) {
    case "_a":
      return "A";
    case "_b":
      return "B";
    case "_c":
      return "C";
    case "_d":
      return "D";
    case "_e":
      return "E";
    default:
      return "";
  }
}

_id_0CFEE0E9DDE10B08() {
  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
    return "decor_halloween_scarecrow_pumpkin";

  return "military_dom_flag_west";
}

_id_4D38B08CD23BE40D() {
  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
    return "decor_halloween_scarecrow_pumpkin";

  return "military_dom_flag_east";
}

_id_74EAE52F74672509() {
  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
    return "decor_halloween_scarecrow_pumpkin";

  return "military_dom_flag_neutral";
}