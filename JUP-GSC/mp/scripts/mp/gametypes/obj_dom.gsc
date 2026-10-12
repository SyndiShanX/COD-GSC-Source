/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_dom.gsc
***********************************************/

#using script_4a6760982b403bad;
#using script_548072087c9fd504;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\cranked;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\siege;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#namespace obj_dom;

function setupobjective(trigger, team, var_5ddbc1faed2c56e6, skipobjid, showoncompass) {
  visuals = undefined;

  if(istrue(level.usestrongholdhills) || getdvarint(@ "t10", 0) > 0) {
    visuals = [];
    visuals[0] = trigger;
    assert(isDefined(trigger));
  } else if(isDefined(trigger.target)) {
    if(!isDefined(trigger.visuals) || trigger.visuals.size == 0) {
      visuals[0] = getEnt(trigger.target, "targetname");
    } else {
      visuals = trigger.visuals;
    }

    assertex(visuals.size > 0, "<dev string:x1c>" + default_to(trigger.target, "<dev string:x58>"));
  }

  if(!isarray(visuals) || visuals.size == 0) {
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0].angles = trigger.angles;
  }

  if(!isDefined(level.flagcapturetime)) {
    level.flagcapturetime = dvarfloatvalue("flagCaptureTime", 10, 0, 30);
  }

  if(!isDefined(level.var_e42a415ae1c75964)) {
    level.flagcapturetimemin = dvarfloatvalue("flagCaptureTimeMin", 0, 0, 30);
  }

  if(!isDefined(level.var_fb607d7bf823f6f9)) {
    level.var_fb607d7bf823f6f9 = level.flagcapturetime * 0.5;
  }

  if(isDefined(trigger.objectivekey)) {
    objectivekey = trigger.objectivekey;
  } else if(isDefined(trigger.script_label)) {
    objectivekey = trigger.script_label;
  } else {
    assertmsg("<dev string:x72>");
    objectivekey = "";
  }

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

  if(!isDefined(team)) {
    team = "neutral";
  }

  domflag = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, (0, 0, 100), reservedobjid, skipobjid, showoncompass);
  domflag scripts\mp\gameobjects::allowuse("enemy");
  domflag scripts\mp\gameobjects::cancontestclaim(1);
  domflag scripts\mp\gameobjects::setusetime(level.flagcapturetime);

  if(isDefined(level.capturetype)) {
    domflag scripts\mp\gameobjects::setcapturebehavior(getcapturetype());
  }

  domflag.objectivekey = objectivekey;
  domflag.iconname = iconname;

  if(!istrue(skipobjid)) {
    domflag scripts\mp\gameobjects::setvisibleteam("any", undefined, 1);
    domflag.onuse = &dompoint_onuse;
    domflag.onbeginuse = &dompoint_onusebegin;
    domflag.onuseupdate = &dompoint_onuseupdate;
    domflag.onenduse = &dompoint_onuseend;
    domflag.oncontested = &dompoint_oncontested;
    domflag.onuncontested = &dompoint_onuncontested;
    domflag.onunoccupied = &dompoint_onunoccupied;
    domflag.onpinnedstate = &dompoint_onpinnedstate;
    domflag.onunpinnedstate = &dompoint_onunpinnedstate;
    domflag.stompprogressreward = &dompoint_stompprogressreward;
  }

  domflag.nousebar = 1;
  domflag.id = "domFlag";
  domflag.claimgracetime = level.flagcapturetime * 1000;
  domflag.firstcapture = 1;
  domflag scripts\mp\gameobjects::pinobjiconontriggertouch();
  domflag.var_823c5a7bf6a0e64a = level.flagreinforcement;
  domflag.var_fb60f3aec3a62f06 = level.flagmodelhidden;

  if(istrue(domflag.var_823c5a7bf6a0e64a)) {
    domflag.reinforcementmax = domflag.usetime - 1;
    domflag.reinforcementstompscalar = level.reinforcementstompscalar;

    if(isDefined(level.flagdecaytime) && level.flagdecaytime > 0) {
      domflag.decayrate = domflag.usetime * level.framedurationseconds / level.flagdecaytime;
    }
  }

  if(istrue(level.var_dd7af80c3eb2c1e0)) {
    domflag.var_5261f4479b04f834 = &function_5261f4479b04f834;
  }

  tracestart = visuals[0].origin + (0, 0, 32);
  traceend = visuals[0].origin + (0, 0, -32);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
  offset = checkmapoffsets(domflag);
  domflag.baseeffectpos = trace["position"] + offset;
  upangles = vectortoangles(trace["normal"]);
  modifiedupangles = checkmapfxangles(domflag, upangles);
  domflag.baseeffectforward = anglesToForward(modifiedupangles);
  scriptable = spawn("script_model", domflag.baseeffectpos);
  scriptable setModel("dom_flag_scriptable");
  scriptable.angles = generateaxisanglesfromforwardvector(domflag.baseeffectforward, scriptable.angles);
  domflag.scriptable = scriptable;

  if(getdvarint(@ "hash_33af98c375b98d29") == 1) {
    var_c6b7900c1fa0a1b6 = trigger.origin + (0, 0, 20);
    vfxscriptable = spawnscriptable("mgl_dom_flag", var_c6b7900c1fa0a1b6);
    vfxscriptable.angles = (90, 0, 0);
    vfxscriptable setscriptablepartstate("flag", "idle");
    domflag.vfxnamemod = vfxscriptable;
  } else {
    domflag.vfxnamemod = "";
  }

  domflag.noscriptable = 1;

  if(istrue(level.multiteambased)) {
    domflag.noscriptable = 1;
  }

  domflag.flagmodel = spawn("script_model", domflag.baseeffectpos);
  domflag.flagmodel.angles = checkmapflagangles(domflag);

  if(!istrue(domflag.var_fb60f3aec3a62f06)) {
    domflag.flagmodel setModel("military_dom_flag_neutral");
  }

  domflag.outlineent = domflag.flagmodel;
  domflag initializematchrecording();

  if(!istrue(skipobjid)) {
    domflag domflag_setneutral();
  }

  return domflag;
}

function removeobjective(domflag) {
  if(isDefined(domflag.flagmodel)) {
    domflag.flagmodel delete();
  }

  if(isDefined(domflag.scriptable)) {
    domflag.scriptable delete();
  }

  domflag scripts\mp\gameobjects::deleteuseobject();
}

function getreservedobjid(objectivekey) {
  if(objectivekey == "_a") {
    reservedid = 0;
  } else if(objectivekey == "_b") {
    reservedid = 1;
  } else if(objectivekey == "_d") {
    reservedid = 3;
  } else if(objectivekey == "_e") {
    reservedid = 4;
  } else {
    reservedid = 2;
  }

  return reservedid;
}

function getcapturetype() {
  capturetype = "normal";

  if(level.capturetype == 2) {
    capturetype = "neutralize";
  } else if(level.capturetype == 3) {
    capturetype = "persistent";
  }

  return capturetype;
}

function checkmapflagangles(domflag) {
  label = domflag.objectivekey;
  angles = (0, 0, 0);

  if(level.mapname == "mp_hardhat") {
    if(label == "_b") {
      angles = (0, 110, 0);
    }
  }

  return angles;
}

function checkmapoffsets(domflag) {
  label = domflag.objectivekey;
  offset = (0, 0, 0);

  switch (level.mapname) {
    case #"hash_9984ffb115f62c1":
      if(label == "_c") {
        offset += (0, 0, 7);
      }

      break;
    case #"hash_9d246a63bb09ce90":
      if(label == "_a") {
        offset += (0, 0, 4.5);
      }

      break;
    case #"hash_dfb794db83208542":
      if(label == "_a") {
        offset += (0, 0, 5);
      }

      if(label == "_c") {
        offset += (0, 0, 1);
      }

      break;
    case #"hash_3e552e81b4a21fff":
      if(label == "_c") {
        offset += (0, 0, -24);
      }

      break;
  }

  return offset;
}

function checkmapfxangles(domflag, upangles) {
  label = domflag.objectivekey;
  angles = upangles;

  switch (level.mapname) {
    case #"hash_9984ffb115f62c1":
      if(label == "_c") {
        angles = (276.5, angles[1], angles[2]);
      }

      break;
    case #"hash_9d246a63bb09ce90":
      if(label == "_a") {
        angles = (273.5, angles[1], angles[2]);
      }

      break;
    case #"hash_dfb794db83208542":
      if(label == "_a") {
        angles = (273.5, 200.5, angles[2]);
      }

      if(label == "_c") {
        angles = (273.5, angles[1], angles[2]);
      }

      break;
    case #"hash_ecbb96ade87e6efa":
      if(isstring(label)) {
        if(label == "_school") {
          angles = (270, 0, 0);
        } else if(label == "_warehouse") {
          angles = (270, 0, 0);
        }
      }

      break;
  }

  return angles;
}

function initializematchrecording() {
  if(isDefined(level.matchrecording_logevent)) {
    assertex(isDefined(level.matchrecording_generateid), "<dev string:xb1>");
    self.logid = [[level.matchrecording_generateid]]();
    flagletter = "A";

    switch (self.objectivekey) {
      case #"hash_fac2c5f6bddd49bd":
        flagletter = "A";
        break;
      case #"hash_fac2c2f6bddd4504":
        flagletter = "B";
        break;
      case #"hash_fac2c3f6bddd4697":
        flagletter = "C";
        break;
      case #"hash_fac2c0f6bddd41de":
        flagletter = "D";
        break;
      case #"hash_fac2c1f6bddd4371":
        flagletter = "E";
        break;
      case #"hash_311010bc01bd3a0f":
        flagletter = "0";
        break;
      case #"hash_31100fbc01bd387c":
        flagletter = "1";
        break;
      case #"hash_311012bc01bd3d35":
        flagletter = "2";
        break;
      case #"hash_311011bc01bd3ba2":
        flagletter = "3";
        break;
      case #"hash_31100cbc01bd33c3":
        flagletter = "4";
        break;
      default:
        assertmsg("<dev string:xe6>" + self.script_label);
        break;
    }

    self.logeventflag = "FLAG_" + flagletter;
  }

  if(scripts\mp\analyticslog::analyticslogenabled()) {
    self.analyticslogid = scripts\mp\analyticslog::getuniqueobjectid();
    self.analyticslogtype = "dom_flag" + self.objectivekey;
  }
}

function domflag_setneutral(keeppulse) {
  self notify("flag_neutral");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral, undefined, undefined, undefined, 1);
  scripts\mp\gameobjects::setownerteam("neutral");

  if(isDefined(level.var_ef1b0e14902b92ae)) {
    self[[level.var_ef1b0e14902b92ae]]();
  }

  thread updateflagstate("idle", istrue(keeppulse));

  if(isDefined(level.matchrecording_logevent) && isDefined(self.logid) && isDefined(self.logeventflag)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), 0);
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "neutral");
}

function dompoint_setcaptured(team, credit_player) {
  scripts\mp\gameobjects::setownerteam(team);

  if(isDefined(level.var_ef1b0e14902b92ae)) {
    self[[level.var_ef1b0e14902b92ae]]();
  }

  if(isDefined(credit_player)) {
    credit_player notify("domFlag_captured");
    self notify("capture", credit_player);
    self notify("assault", credit_player);
  }

  friendlyicon = ter_op(istrue(self.var_823c5a7bf6a0e64a), level.var_a58e0495b821276, level.icondefending);
  scripts\mp\gameobjects::setobjectivestatusicons(friendlyicon, level.iconcapture);

  if(getgametype() == "btm") {
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(self.ownerteam, "flag_defend", "flag_capture");
  }

  self.neutralized = 0;
  thread updateflagstate(team, 0, team);

  if(self.touchlist[team].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  foreach(name in level.teamnamelist) {
    if(isDefined(self.assisttouchlist[name]) && name != team) {
      self.assisttouchlist[name] = [];
    }
  }

  if(isDefined(self.assisttouchlist[team])) {
    players_touching = getarraykeys(self.assisttouchlist[team]);

    foreach(playerid in players_touching) {
      player = self.assisttouchlist[team][playerid].player;
    }
  }

  if(istrue(level.usestrongholdscoring)) {
    ownedflags = getteamflagcount(team);

    if(ownedflags == level.flagsrequiredtoscore) {
      statusdialog("friendly_scoring", team);
      statusdialog("enemy_scoring", getotherteam(team)[0]);
    }
  }

  if(isDefined(credit_player) && (!isagent(credit_player) || scripts\mp\gameobjects::function_21f4c6f630b17fc4(credit_player))) {
    thread function_365a810f08434cab(self.touchlist[team], credit_player, team);
  }

  if(isDefined(level.matchrecording_logevent)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), ter_op(team == "allies", 1, 2));
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + team);
}

function dompoint_onuse(credit_player, team) {
  if(!isDefined(team)) {
    team = credit_player.team;
  }

  if(istrue(self.var_823c5a7bf6a0e64a)) {
    if(isDefined(self.ownerteam) && self.ownerteam == team) {
      if(!istrue(self.reinforced)) {
        self.reinforced = 1;

        if(isDefined(self.decayrate) && self.decayrate > 0) {
          thread scripts\mp\gameobjects::useobjectdecay(team);
        }
      }

      self.curprogress = self.reinforcementmax;
      self.teamprogress[self.ownerteam] = self.curprogress;
      return;
    } else {
      scripts\mp\gameobjects::allowuse("any");
    }
  }

  oldteam = scripts\mp\gameobjects::getownerteam();
  self.oldteam = oldteam;
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;

  if(istrue(level.flagneutralization)) {
    ownerteam = scripts\mp\gameobjects::getownerteam();

    if(ownerteam == "neutral") {
      dompoint_setcaptured(team, credit_player);

      if(isDefined(self.var_5261f4479b04f834)) {
        [[self.var_5261f4479b04f834]]();
      }
    } else {
      thread domflag_setneutral(1);
      scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", ownerteam);
      level.lastcaptime = gettime();
      thread giveflagassistedcapturepoints(self.touchlist[team]);
      self.neutralized = 1;
    }
  } else {
    dompoint_setcaptured(team, credit_player);

    if(isDefined(self.var_5261f4479b04f834)) {
      [[self.var_5261f4479b04f834]]();
    }
  }

  if(!self.neutralized && !isDefined(self.var_b2555c1e8ca32569)) {
    announcementextradata = 3;

    if(self.objectivekey == "_a") {
      announcementextradata = 1;
    } else if(self.objectivekey == "_b") {
      announcementextradata = 2;
    } else if(self.objectivekey == "_d") {
      announcementextradata = 4;
    } else if(self.objectivekey == "_e") {
      announcementextradata = 5;
    }

    if(isDefined(credit_player) && !isagent(credit_player)) {
      namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(21, team, credit_player getentitynumber(), announcementextradata);
    }

    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, credit_player, team, oldteam, self);

      if(isDefined(credit_player) && !isagent(credit_player)) {
        announcement = "Flag " + getobjectiveflag() + " Captured";

        if(oldteam == "neutral" || oldteam == "none") {
          logannouncement(credit_player, undefined, announcement, credit_player.origin, "neutral_flag");
        } else {
          logannouncement(credit_player, undefined, announcement, credit_player.origin);
        }
      }
    }
  }

  self.var_b2555c1e8ca32569 = undefined;
  self.firstcapture = 0;
}

function dompoint_onusebegin(player) {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  player.isonobjective = 1;
  self.neutralizing = istrue(level.flagneutralization) && ownerteam != "neutral";

  if(self.neutralizing) {
    if(ownerteam != player.team) {
      objectivestate = getdomneutralizeomnvarvalue();
    } else {
      objectivestate = 0;
    }
  } else if(ownerteam != player.team) {
    objectivestate = 1;
  } else {
    objectivestate = 0;
  }

  if(isPlayer(player)) {
    player setclientomnvar("ui_objective_pinned_text_param", objectivestate);
  }

  if(!isDefined(self.statusnotifytime)) {
    self.statusnotifytime = gettime();
  }

  if(!istrue(self.neutralized) && self.statusnotifytime > self.statusnotifytime + 5000) {
    self.didstatusnotify = 0;
    self.statusnotifytime = gettime();
  }

  usetime = level.flagcapturetime;

  if(istrue(level.flagneutralization) && !self.firstcapture) {
    usetime = level.var_fb607d7bf823f6f9;
    scripts\mp\gameobjects::setusetime(usetime, 1);
  } else if(isDefined(self.prevusetime)) {
    usetime = self.prevusetime;
    scripts\mp\gameobjects::setusetime(self.prevusetime);
  }

  if(getdvarint(@ "hash_4753586a2ac8718f", 0) == 1) {
    self.useratemultiplier = player getclientomnvar("ui_voxel_head_size");
  }

  if(usetime > 0) {
    self.prevownerteam = getotherteam(player.team)[0];
    updateflagcapturestate(player.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
  }

  if(istrue(level.hideenemyfobs)) {
    if(player.team != ownerteam) {
      scripts\mp\gameobjects::setvisibleteam("any");
    }
  }
}

function dompoint_onuseupdate(team, progress, change, capplayer) {
  scripts\mp\objidpoolmanager::function_9b1a086f348520b0(self.objidnum, team);
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(!istrue(self.stalemate) && !istrue(self.capblocked) && progress < 1 && !level.gameended && !isanymlgmatch()) {
    play_dom_capture_sfx(progress, team);
  }

  if(isDefined(level.capturesegments) && level.capturesegments) {
    var_4a021f1ede7e0c69 = 0;

    for(i = 0; i < level.capturesegments; i++) {
      if(!isDefined(self.segmentupdate)) {
        self.segmentupdate = 0;
      }

      segmentprogress = (i + 1) / 3;

      if(progress >= segmentprogress && self.segmentupdate <= i) {
        self.segmentupdate = i + 1;
        var_4a021f1ede7e0c69 = 1;
      }
    }

    if(var_4a021f1ede7e0c69) {
      foreach(struct in self.touchlist[team]) {
        player = struct.player;

        if(self.segmentupdate != level.capturesegments) {
          player thread scripts\mp\rank::scoreeventpopup(#"segment_captured");
          player notify("segment_captured");

          if(scripts\mp\gameobjects::function_21f4c6f630b17fc4(player)) {
            player.owner setclientomnvar("ui_segment_captured", self.segmentupdate);
          } else {
            player setclientomnvar("ui_segment_captured", self.segmentupdate);
          }
        }

        player scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(8, 1);
      }

      if(isDefined(self.var_916e4c007c6b8ba1)) {
        self[[self.var_916e4c007c6b8ba1]](team, capplayer, self.segmentupdate);
      }

      if(self.segmentupdate != level.capturesegments) {
        segmentid = 2;

        if(self.objectivekey == "_a") {
          segmentid = 1;
        }

        namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(23, team, capplayer getentitynumber(), segmentid);
      }

      var_7e2c53b0bcf117d9 = spawnStruct();
      var_7e2c53b0bcf117d9.objective_entity = self;
      var_7e2c53b0bcf117d9.credit_player = capplayer;
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_objective_state_changed", var_7e2c53b0bcf117d9);
    }
  }

  if(progress > 0 && change && !self.didstatusnotify) {
    if(isDefined(self.objectivekey) || !istrue(level.var_25e8b4afe5e06169)) {
      if(ownerteam == "neutral") {
        if(level.flagcapturetime > 0.05) {
          statusdialog("securing" + self.objectivekey, team);
          var_fe12933325aefac7 = isDefined(level.objectives) && level.objectives.size == 3 && !istrue(level.ingraceperiod);
          var_1a26705e7134a49e = isDefined(level.objectives) && level.objectives.size == 5 && (self.objectivekey == "_b" || self.objectivekey == "_c" || self.objectivekey == "_d");

          if(var_fe12933325aefac7 || var_1a26705e7134a49e) {
            otherteam = getotherteam(team)[0];
            statusdialog("losing" + self.objectivekey, otherteam);
          }
        }
      } else if(level.flagcapturetime > 0.05 && (!istrue(self.var_823c5a7bf6a0e64a) || team != ownerteam)) {
        statusdialog("losing" + self.objectivekey, ownerteam);
        statusdialog("securing" + self.objectivekey, team);
      }
    }

    self.didstatusnotify = 1;
  }
}

function dompoint_onuseend(team, player, success) {
  if(isPlayer(player)) {
    player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  if(isDefined(player)) {
    player.isonobjective = 0;
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    thread updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    thread updateflagstate(ownerteam, 0);
  }

  if(!success) {
    self.neutralized = 0;
  }
}

function dompoint_oncontested() {
  self.contestedtime = gettime();
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread updateflagstate("contested", 0);
  thread function_da1f3979f22bb288(self.trigger.origin, "jup_shared_zone_contested", 3);
  scripts\mp\objidpoolmanager::function_9b1a086f348520b0(self.objidnum, "neutral");
}

function dompoint_onuncontested(lastclaimteam) {
  if(istrue(level.flagneutralization) && !self.firstcapture) {
    scripts\mp\gameobjects::setusetime(level.flagcapturetime * 0.5);
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    if(lastclaimteam != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, lastclaimteam);
    } else if(isDefined(self.lastprogressteam)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, self.lastprogressteam);
    }
  } else {
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, getotherteam(ownerteam)[0]);
  }

  if(lastclaimteam == "none" || ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else if(getbasegametype() == "control" && ownerteam != "neutral") {
    if(ownerteam != lastclaimteam) {
      scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.icontaking);
    } else {
      scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
    }
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  contestedtime = (gettime() - self.contestedtime) * 0.001;
  message = "Flag " + getobjectiveflag() + " Contested";
  logannouncement(undefined, undefined, message, self.trigger.origin, contestedtime + " seconds");
  self.contestedtime = undefined;
  flagstate = ter_op(ownerteam == "neutral", "idle", ownerteam);
  thread updateflagstate(flagstate, 0);
  thread function_82b6a3e1bcda539b(self.trigger.origin, "jup_shared_zone_uncontested", 3);
  scripts\mp\objidpoolmanager::function_9b1a086f348520b0(self.objidnum, "neutral");
}

function play_dom_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_c3ddfb0eaa8f761c = "";
    progress = int(floor(progress * 10));
    var_c3ddfb0eaa8f761c = "mp_dom_capturing_tick_0" + progress;
    self.visuals[0] playsoundtoteam(var_c3ddfb0eaa8f761c, team);
  }
}

function dompoint_onunoccupied() {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  self.didstatusnotify = 0;
  scripts\mp\objidpoolmanager::function_9b1a086f348520b0(self.objidnum, "neutral");
}

function dompoint_onpinnedstate(player) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.lastprogressteam] > 0 && self.teamprogress[self.claimteam] == 0) {
      scripts\mp\gameobjects::setobjectivestatusicons(level.iconclearing, level.iconcapture);

      if(player.team == self.ownerteam) {
        scripts\mp\objidpoolmanager::function_8f7a55bda12ebb21(&"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", player);
      }

      return;
    }

    friendlyicon = ter_op(istrue(self.var_823c5a7bf6a0e64a), level.var_a58e0495b821276, level.icondefending);
    scripts\mp\gameobjects::setobjectivestatusicons(friendlyicon, level.iconcapture);

    if(player.team == self.ownerteam) {
      scripts\mp\objidpoolmanager::function_8f7a55bda12ebb21(&"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player);
    }
  }
}

function dompoint_onunpinnedstate(player) {
  if(!self.stalemate) {
    if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] || isDefined(player.team) && !self.numtouching[player.team]) {
      scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    }
  }
}

function function_3dc46df97466e4d3(team) {
  if(istrue(self.var_823c5a7bf6a0e64a)) {
    if(isDefined(self.ownerteam) && self.ownerteam != "neutral" && team != self.ownerteam) {
      self.reinforced = 0;
      self notify("useObjectDecay");
    }
  }
}

function dompoint_stompprogressreward(player) {
  if(scripts\mp\gameobjects::function_21f4c6f630b17fc4(player)) {
    player.owner thread scripts\mp\utility\points::doscoreevent(#"hash_5fe7a371a8ce26a3");
  } else {
    player thread scripts\mp\utility\points::doscoreevent(#"hash_f648e4847b740818");
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
  scripts\mp\objidpoolmanager::function_8f7a55bda12ebb21(&"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player);
  var_e10dc7dbd1fa932 = ter_op(scripts\mp\gameobjects::function_21f4c6f630b17fc4(player) && isDefined(player.owner), player.owner, player);
  var_e10dc7dbd1fa932 playlocalsound("jup_shared_zone_defended");
}

function setcrankedtimerdomflag(player) {
  if((function_f698bfd3efa33302() || function_e9f3a160bbefe208(player)) && isDefined(player.cranked) && player.cranked) {
    player scripts\mp\cranked::setcrankedplayerbombtimer("assist");
  }
}

function function_5261f4479b04f834() {
  tstartoffset = 20;
  var_12f59cd9e8d7e077 = 600;
  origin = self.flagmodel.origin;
  tstart = origin + (0, 0, tstartoffset);
  tend = origin + (0, 0, var_12f59cd9e8d7e077);
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  ignoreents = level.players;
  ignoreents[ignoreents.size] = self.flagmodel;
  trace = scripts\engine\trace::ray_trace(tstart, tend, ignoreents, contentoverride, 0);

  if(isPlayer(trace["entity"])) {
    trace["entity"] = undefined;
  }

  if(isDefined(trace["entity"]) && isDefined(trace["entity"].code_classname) && trace["entity"].code_classname == "script_vehicle") {
    ignoreents[ignoreents.size] = trace["entity"];
    trace = scripts\engine\trace::ray_trace(tstart, tend, ignoreents, contentoverride, 0);
  }

  if(trace["fraction"] != 1) {
    tstartoffset = 4000;
    var_12f59cd9e8d7e077 = 20;
    origin = self.flagmodel.origin;
    tstart = origin + (0, 0, tstartoffset);
    tend = origin + (0, 0, var_12f59cd9e8d7e077);
    contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
    ignoreents = [];
    ignoreents = level.players;
    ignoreents[ignoreents.size] = self.flagmodel;
    trace = scripts\engine\trace::ray_trace(tstart, tend, ignoreents, contentoverride, 0);

    if(isPlayer(trace["entity"])) {
      trace["entity"] = undefined;
    }

    if(isDefined(trace["entity"]) && isDefined(trace["entity"].code_classname) && trace["entity"].code_classname == "script_vehicle") {
      ignoreents[ignoreents.size] = trace["entity"];
      trace = scripts\engine\trace::ray_trace(tstart, tend, ignoreents, contentoverride, 0);
    }

    if(trace["fraction"] != 1) {
      playFX(level.var_b6e1c0b3c715b0df["gos_fireworks"], trace["position"]);
      playFX(level.var_b6e1c0b3c715b0df["gos_fireworks"], trace["position"], anglesToForward(self.flagmodel.angles) + (-10, -10, 0));
      playFX(level.var_b6e1c0b3c715b0df["gos_fireworks"], trace["position"], anglesToForward(self.flagmodel.angles) + (10, 10, 0));
      level thread scripts\mp\gametypes\common::function_2c3362a9f434fd8d(trace["position"]);
    }

    return;
  }

  playFX(level.var_b6e1c0b3c715b0df["gos_fireworks"], origin);
  playFX(level.var_b6e1c0b3c715b0df["gos_fireworks"], origin, anglesToForward(self.flagmodel.angles) + (-10, -10, 0));
  playFX(level.var_b6e1c0b3c715b0df["gos_fireworks"], origin, anglesToForward(self.flagmodel.angles) + (10, 10, 0));
  level thread scripts\mp\gametypes\common::function_2c3362a9f434fd8d(origin);
}

function dompoint_setupflagmodels() {
  game["flagmodels"] = [];
  game["flagmodels"]["neutral"] = "prop_flag_neutral";
}

function updateflagstate(state, keeppulse, ownerteam) {
  self notify("updateFlagState");
  self endon("updateFlagState");

  if(isDefined(ownerteam) && !istrue(self.var_fb60f3aec3a62f06)) {
    if(getdvarint(@ "hash_33af98c375b98d29") == 1) {
      if(ownerteam == "allies") {
        self.flagmodel setModel("military_dom_flag_west");
        self.vfxnamemod setscriptablepartstate("flag", "allies");
      } else if(ownerteam == "axis") {
        self.flagmodel setModel("military_dom_flag_east");
        self.vfxnamemod setscriptablepartstate("flag", "axis");
      } else {
        self.flagmodel setModel("military_dom_flag_neutral");
        self.vfxnamemod setscriptablepartstate("flag", "idle");
      }
    } else if(ownerteam == "allies") {
      self.flagmodel setModel("military_dom_flag_west");
    } else if(ownerteam == "axis") {
      self.flagmodel setModel("military_dom_flag_east");
    } else {
      self.flagmodel setModel("military_dom_flag_neutral");
    }
  }

  if(isDefined(self.noscriptable)) {
    return;
  }

  while(!isDefined(self.scriptable)) {
    waitframe();
  }

  if(getgametype() == "defcon") {
    return;
  }

  if(getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "risk") {
    return;
  }

  if(isDefined(self.scriptable)) {
    if(state == "off") {
      setdomscriptablepartstate("flag", state);
    } else {
      setdomscriptablepartstate("flag", state, self.vfxnamemod);
    }

    if(!istrue(keeppulse)) {
      setdomscriptablepartstate("pulse", "off");
    }
  }
}

function setdomscriptablepartstate(part, state, statemod) {
  if(!isDefined(self.scriptable)) {
    return;
  }

  if(isDefined(level.setdomscriptablepartstatefunc)) {
    if([[level.setdomscriptablepartstatefunc]](part, state, statemod)) {
      return;
    }
  }

  if(isDefined(statemod)) {
    state += statemod;
  }

  self.scriptable setscriptablepartstate(part, state);
}

function updateflagcapturestate(state) {
  if(isDefined(self.noscriptable)) {
    return;
  }

  if(getgametype() != "arm" && getgametype() != "conflict" && getgametype() != "risk" && getgametype() != "defcon") {
    if(isDefined(self.scriptable)) {
      setdomscriptablepartstate("pulse", state, self.vfxnamemod);
    }
  }
}

function ondisconnect() {
  self waittill("disconnect");

  foreach(effect in self._domflageffect) {
    if(isDefined(effect)) {
      effect delete();
    }
  }

  foreach(pulseeffect in self._domflagpulseeffect) {
    if(isDefined(pulseeffect)) {
      pulseeffect delete();
    }
  }
}

function giveflagassistedcapturepoints(touchlist) {
  level endon("game_ended");
  players_touching = getarraykeys(touchlist);

  for(index = 0; index < players_touching.size; index++) {
    player = touchlist[players_touching[index]].player;
    var_1ae6a1bf1853354a = touchlist[players_touching[index]].player;

    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(player.owner)) {
      player = player.owner;
    }

    if(!isPlayer(player)) {
      continue;
    }

    if(istrue(level.flagneutralization)) {
      if(scripts\mp\gameobjects::function_21f4c6f630b17fc4(var_1ae6a1bf1853354a)) {
        player thread scripts\mp\rank::scoreeventpopup(#"hash_b88e45e7e5722885");
      } else {
        player thread scripts\mp\rank::scoreeventpopup(#"neutralized");
      }
    } else if(scripts\mp\gameobjects::function_21f4c6f630b17fc4(var_1ae6a1bf1853354a)) {
      player thread scripts\mp\rank::scoreeventpopup(#"capture_capture_bot");
    } else {
      player thread scripts\mp\rank::scoreeventpopup(#"capture");
    }

    if(scripts\mp\gameobjects::function_21f4c6f630b17fc4(var_1ae6a1bf1853354a)) {
      player thread scripts\mp\utility\points::doscoreevent(#"hash_dc7a8a01b9b6aa24");
    } else {
      player thread scripts\mp\utility\points::doscoreevent(#"hash_52bbd83acf4acb07");
    }

    player setcrankedtimerdomflag(player);
    wait 0.05;
  }
}

function function_365a810f08434cab(touchlist, credit_player, team) {
  level endon("game_ended");
  first_player = credit_player;

  if(isDefined(first_player.owner)) {
    first_player = first_player.owner;
  }

  level.lastcaptime = gettime();
  level.playholdtwovo = 1;

  if(isPlayer(first_player)) {
    if(getgametype() == "cmd" || getgametype() == "rush" || getgametype() == "risk") {
      level thread teamplayercardsplash("callout_securedposition", first_player);
    } else {
      level thread teamplayercardsplash("callout_securedposition" + self.objectivekey, first_player);
    }

    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = first_player;
    var_7e2c53b0bcf117d9.eventname = "capture";
    var_7e2c53b0bcf117d9.position = first_player.origin;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
  }

  if(self.firstcapture == 1) {
    isneutral = 1;
  } else {
    isneutral = 0;
  }

  if(isDefined(touchlist)) {
    players_touching = getarraykeys(touchlist);

    for(index = 0; index < players_touching.size; index++) {
      player = touchlist[players_touching[index]].player;
      var_8a11b26acefd3594 = 0;

      if(isDefined(player.owner)) {
        if(scripts\mp\gameobjects::function_21f4c6f630b17fc4(player)) {
          var_8a11b26acefd3594 = 1;
        }

        player = player.owner;
      }

      if(!isPlayer(player)) {
        continue;
      }

      player setcapturestats();
      givecaptureawards(player, isneutral, 0, var_8a11b26acefd3594);
      setcrankedtimerdomflag(player);
      scripts\mp\objidpoolmanager::function_8f7a55bda12ebb21(&"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player);
      wait 0.05;
    }

    if(isDefined(self.assisttouchlist)) {
      if(self.assisttouchlist[team].size > 0) {
        var_9eb80458ef362367 = getarraykeys(self.assisttouchlist[team]);

        foreach(id in players_touching) {
          foreach(assistid in var_9eb80458ef362367) {
            if(assistid == id) {
              self.assisttouchlist[team][assistid] = undefined;
            }
          }
        }
      }

      if(self.assisttouchlist[team].size > 0) {
        thread giveflagcaptureassistxp(team, isneutral);
      }
    }
  }
}

function giveflagcaptureassistxp(team, isneutral) {
  level endon("game_ended");
  var_9eb80458ef362367 = getarraykeys(self.assisttouchlist[team]);

  if(var_9eb80458ef362367.size > 0) {
    for(index = 0; index < var_9eb80458ef362367.size; index++) {
      var_6c7881393d098340 = self.assisttouchlist[team][var_9eb80458ef362367[index]];
      var_8a11b26acefd3594 = var_6c7881393d098340.var_d96989d14549fd76;

      if(var_8a11b26acefd3594) {
        if(isDefined(var_6c7881393d098340.owner)) {
          player = var_6c7881393d098340.owner;
        } else {
          player = undefined;
        }
      } else {
        player = var_6c7881393d098340.player;
      }

      if(isDefined(player)) {
        player setcapturestats();
        givecaptureawards(player, isneutral, 1, var_8a11b26acefd3594);
        setcrankedtimerdomflag(player);
      }

      self.assisttouchlist[team][var_9eb80458ef362367[index]] = undefined;
      wait 0.05;
    }
  }
}

function givecaptureawards(player, isneutral, isassist, var_9cb84269bb4959b6) {
  givestreakpoint = 0;
  awardtype = #"";

  if(isassist) {
    if(var_9cb84269bb4959b6) {
      awardtype = #"hash_70c24ce7e0579e7a";
    } else {
      player thread scripts\mp\rank::scoreeventpopup(#"capture_assist");
      awardtype = #"hash_7a10d07e9cc5745b";
    }

    scripts\cp_mp\challenges::function_90d26b6dc5331196(player);
  } else if(isneutral) {
    isarm = getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "risk" || getgametype() == "gwai";
    ismidpoint = !isarm && self.objectivekey == "_b" || isarm && self.objectivekey == "_c";
    var_33c298715a11a534 = isarm && (self.objectivekey == "_b" || self.objectivekey == "_d");

    if(ismidpoint) {
      if(isarm) {
        if(var_9cb84269bb4959b6) {
          awardtype = #"hash_199fb097e6e3a35e";
        } else {
          player thread scripts\mp\rank::scoreeventpopup(#"neutral_capture");
          awardtype = #"hash_87f6a8171e213a70";
        }
      } else if(var_9cb84269bb4959b6) {
        awardtype = #"hash_906df18504d76aaf";
      } else {
        player thread scripts\mp\rank::scoreeventpopup(#"hash_42f35af3197f7eac", self.objectivekey);
        awardtype = #"mode_dom_secure_b";
      }
    } else if(var_33c298715a11a534) {
      if(var_9cb84269bb4959b6) {
        awardtype = #"hash_199fb097e6e3a35e";
      } else {
        player thread scripts\mp\rank::scoreeventpopup(#"neutral_capture");
        awardtype = #"hash_2824db5042d26e38";
      }
    } else if(isarm) {
      if(var_9cb84269bb4959b6) {
        awardtype = #"hash_199fb097e6e3a35e";
      } else {
        player thread scripts\mp\rank::scoreeventpopup(#"neutral_capture");
        awardtype = #"hash_58727f626aa03b19";
      }
    } else if(var_9cb84269bb4959b6) {
      awardtype = #"hash_199fb097e6e3a35e";
    } else {
      player thread scripts\mp\rank::scoreeventpopup(#"neutral_capture", self.objectivekey);
      awardtype = #"hash_a6e3b07f24a55e2b";
    }
  } else if(istrue(level.flagneutralization)) {
    if(var_9cb84269bb4959b6) {
      awardtype = #"capture_capture_bot";
    } else {
      player thread scripts\mp\rank::scoreeventpopup(#"capture");
      awardtype = #"hash_a500ea17e54288a0";
    }
  } else if(var_9cb84269bb4959b6) {
    awardtype = #"capture_capture_bot";
  } else {
    player thread scripts\mp\rank::scoreeventpopup(#"capture", self.objectivekey);
    awardtype = #"mode_dom_secure";
  }

  player thread scripts\mp\utility\points::doscoreevent(awardtype);

  if(givestreakpoint) {
    player scripts\mp\killstreaks\killstreaks::givestreakpoints(#"capture", 1, 0);
  }
}

function setcapturestats() {
  incpersstat("captures", 1);

  if(isDefined(self.pers["captures"])) {
    scripts\mp\persistence::statsetchild("round", "captures", self.pers["captures"]);

    if(getgametype() != "arena") {
      setextrascore0(self.pers["captures"]);
    }
  }
}

function precap(var_dc617b1666471f3) {
  storecenterflag(var_dc617b1666471f3);
  excludedflags = [];
  excludedflags[excludedflags.size] = level.centerflag;

  if(game["switchedsides"]) {
    level.closestalliesflag = getunownedflagneareststart("axis", level.centerflag);
    excludedflags[excludedflags.size] = level.closestalliesflag;
    level.closestaxisflag = getunownedflagneareststart("allies", excludedflags);
  } else {
    level.closestalliesflag = getunownedflagneareststart("allies", level.centerflag);
    excludedflags[excludedflags.size] = level.closestalliesflag;
    level.closestaxisflag = getunownedflagneareststart("axis", excludedflags);
  }

  level.closestalliesflag setflagcaptured("allies", "neutral", undefined, 1);
  level.closestaxisflag setflagcaptured("axis", "neutral", undefined, 1);
}

function storecenterflag(var_dc617b1666471f3) {
  var_253879c7bdce626a = undefined;

  foreach(flag in level.objectives) {
    if(istrue(var_dc617b1666471f3)) {
      if(flag.objectivekey == "_c") {
        level.centerflag = flag;
      }
    }

    if(flag.objectivekey == "_b") {
      level.centerflag = flag;
    }
  }
}

function setflagcaptured(team, oldteam, credit_player, var_230445c943c9459a) {
  scripts\mp\gameobjects::setownerteam(team);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);

  if(isDefined(level.var_ef1b0e14902b92ae)) {
    self[[level.var_ef1b0e14902b92ae]]();
  }

  thread updateflagstate(team, 0, team);
  self.capturetime = gettime();
  gametype = getgametype();

  if(gametype == "siege") {
    scripts\mp\gametypes\siege::watchflagenduse(team);
  }

  if(!isDefined(var_230445c943c9459a)) {
    if(oldteam != "neutral") {
      ownedflags = getteamflagcount(team);

      if(ownedflags == 2) {
        statusdialog("friendly_captured_2", team);
        statusdialog("enemy_captured_2", oldteam);
      } else {
        statusdialog("secured" + self.objectivekey, team);
        statusdialog("lost" + self.objectivekey, oldteam);
      }

      level.lastcaptime = gettime();
    }

    if(gametype == "siege") {
      scripts\mp\gametypes\siege::teamrespawn(team, credit_player);
    }

    self.firstcapture = 0;
  }

  if(istrue(self.var_823c5a7bf6a0e64a)) {
    scripts\mp\gameobjects::allowuse("any");
  }
}

function getteamflagcount(team, var_ea084d6bb059d6b) {
  score = 0;

  foreach(objective in level.objectives) {
    if(istrue(var_ea084d6bb059d6b)) {
      if(objective.stalemate || objective.captureblocked || objective.claimteam != "none" && objective.claimteam != team) {
        continue;
      }
    }

    if(objective.ownerteam == team) {
      score++;
    }
  }

  return score;
}

function isflagexcluded(var_4ddc8d75e113b606, excludeflag) {
  excluded = 0;

  if(isarray(excludeflag)) {
    foreach(flag in excludeflag) {
      if(var_4ddc8d75e113b606 == flag) {
        excluded = 1;
        break;
      }
    }
  } else if(var_4ddc8d75e113b606 == excludeflag) {
    excluded = 1;
  }

  return excluded;
}

function getunownedflagneareststart(team, excludeflag) {
  best = undefined;
  bestdistsq = undefined;
  flagobj = undefined;

  foreach(flag in level.objectives) {
    if(flag scripts\mp\gameobjects::getownerteam() != "neutral") {
      continue;
    }

    distsq = distancesquared(flag.trigger.origin, level.startpos[team]);

    if(isDefined(excludeflag)) {
      if(!isflagexcluded(flag, excludeflag) && (!isDefined(best) || distsq < bestdistsq)) {
        bestdistsq = distsq;
        best = flag;
      }

      continue;
    }

    if(!isDefined(best) || distsq < bestdistsq) {
      bestdistsq = distsq;
      best = flag;
    }
  }

  return best;
}

function awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
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

  var_9ff9376383f4bc58 = 0;
  var_8363beb01b537d3e = 0;
  awardeddefend = 0;
  victim = self;
  victimpos = victim.origin;
  attackerpos = attacker.origin;

  if(isDefined(einflictor)) {
    attackerpos = einflictor.origin;
  }

  foreach(flag in level.objectives) {
    if(!isDefined(flag.trigger) || istrue(flag.trigger.trigger_off)) {
      continue;
    }

    ownerteam = flag scripts\mp\gameobjects::getownerteam();
    attackertouching = attacker istouching(flag.trigger);
    victimtouching = victim istouching(flag.trigger);
    sitekey = flag.objectivekey;

    if(attackertouching && attacker.team != ownerteam) {
      attacker thread function_e3e3e81453fd788b(#"capture_kill");
      flag notify("assault", attacker);
      var_8363beb01b537d3e = 1;
    }

    if(ownerteam == "neutral") {
      if(attackertouching || victimtouching) {
        if(flag.claimteam == victim.team) {
          if(!var_8363beb01b537d3e) {
            var_8363beb01b537d3e = 1;
            attacker thread scripts\mp\rank::scoreeventpopup(#"assault");
            attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
            flag notify("assault", attacker);
            thread utility::trycall(level.matchdata_logattackerkillevent, killid, "assaulting");
            continue;
          }
        } else if(flag.claimteam == attacker.team) {
          if(!awardeddefend) {
            awardeddefend = 1;
            attacker thread scripts\mp\rank::scoreeventpopup(#"defend", sitekey);
            attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, {
              #extraparam: sitekey
            });
            flag notify("defend", attacker);
            attacker incpersstat("defends", 1);
            attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
            attacker setextrascore1(attacker.pers["defends"]);
            thread utility::trycall(level.matchdata_logattackerkillevent, killid, "defending");
            continue;
          }
        }
      }

      continue;
    }

    if(ownerteam != attacker.team) {
      if(!var_8363beb01b537d3e) {
        var_a3a2ce8b8e74ebef = attackertouching || distsquaredcheck(flag.trigger, attackerpos, victimpos);

        if(var_a3a2ce8b8e74ebef) {
          var_8363beb01b537d3e = 1;
          attacker thread scripts\mp\rank::scoreeventpopup(#"assault");
          attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
          flag notify("assault", attacker);
          thread utility::trycall(level.matchdata_logattackerkillevent, killid, "assaulting");
          continue;
        }
      }

      continue;
    }

    if(!awardeddefend) {
      givedefend = victimtouching || distsquaredcheck(flag.trigger, attackerpos, victimpos);

      if(givedefend) {
        awardeddefend = 1;
        attacker thread scripts\mp\rank::scoreeventpopup(#"defend", sitekey);
        attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, {
          #extraparam: sitekey
        });
        flag notify("defend", attacker);
        attacker incpersstat("defends", 1);
        attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
        attacker setextrascore1(attacker.pers["defends"]);
        thread utility::trycall(level.matchdata_logattackerkillevent, killid, "defending");
      }
    }
  }
}

function distsquaredcheck(trigger, attackerpos, victimpos) {
  var_9ae8b00a8e8f64fa = distancesquared(trigger.origin, attackerpos);
  var_1881a89c6f1e8775 = distancesquared(trigger.origin, victimpos);
  var_261168ef0c9f4f3 = getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "risk";
  var_f6c2aad81e18e09d = ter_op(var_261168ef0c9f4f3, 422500, 105625);

  if(var_9ae8b00a8e8f64fa < var_f6c2aad81e18e09d || var_1881a89c6f1e8775 < var_f6c2aad81e18e09d) {
    if(!isDefined(trigger.modifieddefendcheck)) {
      return 1;
    } else if(attackerpos[2] - trigger.origin[2] < 100 || victimpos[2] - trigger.origin[2] < 100) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 0;
}

function getdomneutralizeomnvarvalue() {
  switch (self.objectivekey) {
    case #"hash_fac2c5f6bddd49bd":
      return 6;
    case #"hash_fac2c2f6bddd4504":
      return 7;
    case #"hash_fac2c3f6bddd4697":
      return 8;
    default:
      return 6;
  }
}

function getobjectiveflag() {
  switch (self.objectivekey) {
    case #"hash_fac2c5f6bddd49bd":
      return "A";
    case #"hash_fac2c2f6bddd4504":
      return "B";
    case #"hash_fac2c3f6bddd4697":
      return "C";
    case #"hash_fac2c0f6bddd41de":
      return "D";
    case #"hash_fac2c1f6bddd4371":
      return "E";
    default:
      return "";
  }
}

function function_da1f3979f22bb288(posorigin, alias, timer) {
  if(!isDefined(self.var_4efd1a215d3e63d6)) {
    playsoundatpos(posorigin, alias);
    self.var_4efd1a215d3e63d6 = 1;
    wait timer;
    self.var_4efd1a215d3e63d6 = undefined;
    return;
  }

  return;
}

function function_82b6a3e1bcda539b(posorigin, alias, timer) {
  if(!isDefined(self.var_e264252f7f1f6def)) {
    playsoundatpos(posorigin, alias);
    self.var_e264252f7f1f6def = 1;
    wait timer;
    self.var_e264252f7f1f6def = undefined;
    return;
  }

  return;
}