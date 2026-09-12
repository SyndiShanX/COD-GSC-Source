/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_dom.gsc
***********************************************/

function setupobjective(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(isDefined(var_0.target)) {
    if(!isDefined(var_0.visuals)) {
      GscBinSkip1(0x45, 0, getEnt(var_0.target, "targetname"));
    }

    var_7 = var_0.visuals;
  } else {
    GscBinSkip1(0x45, 0, spawn("script_model", var_1.origin));
  }

  if(!isDefined(level.flagcapturetime)) {
    level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 10, 0, 30);
  }

  if(isDefined(var_0.objectivekey)) {
    var_8 = var_0.objectivekey;
  } else {
    var_8 = var_1.script_label;
  }

  if(isDefined(var_1.iconname)) {
    var_9 = var_1.iconname;
  } else {
    var_9 = var_2.script_label;
  }

  if(istrue(var_4)) {
    var_10 = getreservedobjid(var_9);
  } else {
    var_10 = undefined;
  }

  if(!isDefined(var_4)) {
    var_4 = "neutral";
  }

  var_11 = scripts\mp\gameobjects::createuseobject(var_4, var_3, var_9, (0, 0, 100), var_10, var_6, var_7, var_8);
  var_11 scripts\mp\gameobjects::allowuse("enemy");
  var_11 scripts\mp\gameobjects::cancontestclaim(1);
  var_11 scripts\mp\gameobjects::setusetime(level.flagcapturetime);

  if(isDefined(level.capturetype)) {
    var_11 scripts\mp\gameobjects::setcapturebehavior(getcapturetype());
  }

  var_11.objectivekey = var_9;
  var_11.iconname = var_10;

  if(!istrue(var_6)) {
    var_11 scripts\mp\gameobjects::setvisibleteam("any", undefined, 1);
    var_11.onuse = &dompoint_onuse;
    var_11.onbeginuse = &dompoint_onusebegin;
    var_11.onuseupdate = &dompoint_onuseupdate;
    var_11.onenduse = &dompoint_onuseend;
    var_11.oncontested = &dompoint_oncontested;
    var_11.onuncontested = &dompoint_onuncontested;
    var_11.onunoccupied = &dompoint_onunoccupied;
    var_11.onpinnedstate = &dompoint_onpinnedstate;
    var_11.onunpinnedstate = &dompoint_onunpinnedstate;
    var_11.stompprogressreward = &dompoint_stompprogressreward;
  }

  var_11.nousebar = 1;
  var_11.id = "domFlag";
  var_11.claimgracetime = level.flagcapturetime * 1000;
  var_11.firstcapture = 1;
  var_11 scripts\mp\gameobjects::pinobjiconontriggertouch();

  if(istrue(level.playinggulagbink)) {
    var_11.ref_136CD = &ref_136CE;
  } else if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "br") {
    var_11.ref_136CD = &ref_136CF;
  }

  var_12 = var_9[0].origin + (0, 0, 32);
  var_13 = var_9[0].origin + (0, 0, -32);
  var_14 = scripts\engine\trace::create_contents(var_8, 1, 1, 1, 0, 1, 1);
  var_15 = [];
  var_16 = scripts\engine\trace::ray_trace(var_12, var_13, var_15, var_14);
  var_17 = checkmapoffsets(var_11);
  var_11.baseeffectpos = var_16["position"] + var_17;
  var_18 = vectortoangles(var_16["normal"]);
  var_19 = checkmapfxangles(var_11, var_18);
  var_11.baseeffectforward = anglesToForward(var_19);
  var_20 = spawn("script_model", var_11.baseeffectpos);
  var_20 setModel("dom_flag_scriptable");
  var_20.angles = generateaxisanglesfromforwardvector(var_11.baseeffectforward, var_20.angles);
  var_11.scriptable = var_20;
  var_11.vfxnamemod = "";
  var_11.noscriptable = 1;

  if(istrue(level.multiteambased)) {
    var_11.noscriptable = 1;
  }

  var_11.flagmodel = spawn("script_model", var_11.baseeffectpos);

  if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "br") {
    var_21 = "decor_halloween_scarecrow";
    var_11.flagmodel.useagents = 1;
  } else {
    var_21 = "military_dom_flag_neutral";
  }

  var_12.flagmodel setModel(var_21);
  var_12.flagmodel.angles = getlivingplayersonteam(var_12);
  var_12.outlineent = var_12.flagmodel;

  if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "br") {
    thread setplayermostwantedextrainfo();
    thread markdistanceoverride();
  }

  initializematchrecording(var_12);

  if(!istrue(var_7)) {
    domflag_setneutral(var_12, undefined, 1);
  }

  return var_12;
}

function removeobjective(var_0) {
  if(isDefined(var_0.flagmodel)) {
    var_0.flagmodel delete();
  }

  if(isDefined(var_0.scriptable)) {
    var_0.scriptable delete();
  }

  var_0 scripts\mp\gameobjects::deleteuseobject();
}

function getreservedobjid(var_0) {
  if(var_0 == "_a") {
    var_1 = 0;
  } else if(var_1 == "_b") {
    var_1 = 1;
  } else if(var_1 == "_d") {
    var_1 = 3;
  } else if(var_1 == "_e") {
    var_1 = 4;
  } else {
    var_1 = 2;
  }

  return var_1;
}

function getcapturetype() {
  var_0 = "normal";

  if(level.capturetype == 2) {
    var_0 = "neutralize";
  } else if(level.capturetype == 3) {
    var_0 = "persistent";
  }

  return var_0;
}

function getlivingplayersonteam(var_0) {
  var_1 = var_0.objectivekey;
  var_2 = (0, 0, 0);

  if(level.mapname == "mp_hardhat") {
    if(var_1 == "_b") {
      var_2 = (0, 110, 0);
    }
  }

  return var_2;
}

function checkmapoffsets(var_0) {
  var_1 = var_0.objectivekey;
  var_2 = (0, 0, 0);

  if(level.mapname == "mp_quarry") {
    if(var_1 == "_c") {
      var_2 += (0, 0, 7);
    }
  }

  if(level.mapname == "mp_divide") {
    if(var_1 == "_a") {
      var_2 += (0, 0, 4.5);
    }
  }

  if(level.mapname == "mp_afghan") {
    if(var_1 == "_a") {
      var_2 += (0, 0, 5);
    }

    if(var_1 == "_c") {
      var_2 += (0, 0, 1);
    }
  }

  return var_2;
}

function checkmapfxangles(var_0, var_1) {
  var_2 = var_0.objectivekey;
  var_3 = var_1;

  if(level.mapname == "mp_quarry") {
    if(var_2 == "_c") {
      var_3 = (276.5, var_3[1], var_3[2]);
    }
  }

  if(level.mapname == "mp_divide") {
    if(var_2 == "_a") {
      var_3 = (273.5, var_3[1], var_3[2]);
    }
  }

  if(level.mapname == "mp_afghan") {
    if(var_2 == "_a") {
      var_3 = (273.5, 200.5, var_3[2]);
    }

    if(var_2 == "_c") {
      var_3 = (273.5, var_3[1], var_3[2]);
    }
  }

  if(level.mapname == "mp_faridah") {
    if(isstring(var_2)) {
      if(var_2 == "_school") {
        var_3 = (270, 0, 0);
      } else if(var_2 == "_warehouse") {
        var_3 = (270, 0, 0);
      }
    }
  }

  return var_3;
}

function initializematchrecording() {
  if(isDefined(level.matchrecording_logevent)) {
    self.logid = [[level.matchrecording_generateid]]();
    var_0 = "A";

    switch (self.objectivekey) {
      case "_a":
        var_0 = "A";
        break;
      case "_b":
        var_0 = "B";
        break;
      case "_c":
        var_0 = "C";
        break;
      case "_d":
        var_0 = "D";
        break;
      case "_e":
        var_0 = "E";
        break;
      case "0":
        var_0 = "0";
        break;
      case "1":
        var_0 = "1";
        break;
      case "2":
        var_0 = "2";
        break;
      case "3":
        var_0 = "3";
        break;
      case "4":
        var_0 = "4";
        break;
      default:
        break;
    }

    self.logeventflag = "FLAG_" + var_0;
  }

  if(scripts\mp\analyticslog::analyticslogenabled()) {
    self.analyticslogid = scripts\mp\analyticslog::getuniqueobjectid();
    self.analyticslogtype = "dom_flag" + self.objectivekey;
    return;
  }
}

function domflag_setneutral(var_0, var_1) {
  self notify("flag_neutral");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral, undefined, undefined, undefined, 1);
  scripts\mp\gameobjects::setownerteam("neutral");
  thread updateflagstate("idle", istrue(var_0), undefined, var_1);

  if(isDefined(level.matchrecording_logevent) && isDefined(self.logid) && isDefined(self.logeventflag)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), 0);
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "neutral");
}

function dompoint_setcaptured(var_0, var_1) {
  scripts\mp\gameobjects::setownerteam(var_0);
  self notify("capture", var_1);
  self notify("assault", var_1);

  if(istrue(level.numflagsscoreonkill)) {
    var_2 = getteamflagcount(var_0);

    if(var_2 >= level.numflagsscoreonkill) {
      level.teamscoresonkill[var_0] = 1;
    } else {
      level.teamscoresonkill[var_0] = 0;
    }
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);

  if(scripts\mp\utility\game::getgametype() == "btm") {
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(self.ownerteam, 15, 14);
  }

  self.neutralized = 0;
  thread updateflagstate(var_0, 0, var_0);

  if(self.touchlist[var_0].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  foreach(var_4 in level.teamnamelist) {
    if(isDefined(self.assisttouchlist[var_4]) && var_4 != var_0) {
      self.assisttouchlist[var_4] = [];
    }
  }

  if(isDefined(self.assisttouchlist[var_0])) {
    var_6 = getarraykeys(self.assisttouchlist[var_0]);

    foreach(var_8 in var_6) {
      var_9 = self.assisttouchlist[var_0][var_8].player;

      if(isDefined(var_9.owner)) {
        var_9 = var_9.owner;
      }

      if(!isPlayer(var_9)) {
        continue;
      }

      var_9 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
    }
  }

  thread giveflagcapturexp(self.touchlist[var_0], var_1, var_0);

  if(isDefined(level.matchrecording_logevent)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), scripts\engine\utility::ter_op(var_0 == "allies", 1, 2));
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + var_0);
}

function dompoint_onuse(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;

  if(istrue(level.flagneutralization)) {
    var_3 = scripts\mp\gameobjects::getownerteam();

    if(var_3 == "neutral") {
      dompoint_setcaptured(var_1, var_0);

      if(isDefined(self.ref_136CD)) {
        [[self.ref_136CD]]();
      }
    } else {
      thread domflag_setneutral(1);
      scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", var_3);
      level.lastcaptime = gettime();
      thread giveflagassistedcapturepoints(self.touchlist[var_1]);
      self.neutralized = 1;
    }
  } else {
    dompoint_setcaptured(var_1, var_0);

    if(isDefined(self.ref_136CD)) {
      [[self.ref_136CD]]();
    }
  }

  if(!self.neutralized) {
    var_4 = 3;

    if(self.objectivekey == "_a") {
      var_4 = 1;
    } else if(self.objectivekey == "_b") {
      var_4 = 2;
    } else if(self.objectivekey == "_d") {
      var_4 = 4;
    } else if(self.objectivekey == "_e") {
      var_4 = 5;
    }

    scripts\mp\utility\game::setmlgannouncement(21, var_1, var_0 getentitynumber(), var_4);

    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, var_0, var_1, var_2, self);
      var_5 = "Flag " + resetchemicalvalvevalues() + " Captured";

      if(var_2 == "neutral" || var_2 == "none") {
        scripts\mp\utility\game::ref_119AC(var_0, undefined, var_5, var_0.origin, "neutral_flag");
      } else {
        scripts\mp\utility\game::ref_119AC(var_0, undefined, var_5, var_0.origin);
      }
    }
  }

  self.firstcapture = 0;
}

function dompoint_onusebegin(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  self.neutralizing = istrue(level.flagneutralization) && var_1 != "neutral";

  if(self.neutralizing) {
    if(var_1 != var_0.team) {
      var_2 = relic_nuketimer_timerloop();
    } else {
      var_2 = 0;
    }
  } else if(var_2 != var_2.team) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  var_2 setclientomnvar("ui_objective_state", var_2);

  if(!isDefined(self.statusnotifytime)) {
    self.statusnotifytime = gettime();
  }

  if(!istrue(self.neutralized) && self.statusnotifytime > self.statusnotifytime + 5000) {
    self.didstatusnotify = 0;
    self.statusnotifytime = gettime();
  }

  var_3 = scripts\engine\utility::ter_op(istrue(level.flagneutralization) && !self.firstcapture, level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(var_3);

  if(var_3 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var_2.team)[0];
    updateflagcapturestate(var_2.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
  }

  if(istrue(level.hideenemyfobs)) {
    if(var_2.team != var_2) {
      scripts\mp\gameobjects::setvisibleteam("any");
      return;
    }

    return;
  }
}

function dompoint_onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_1 < 1 && !level.gameended && !scripts\mp\utility\game::isanymlgmatch()) {
    play_dom_capture_sfx(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(var_4 == "neutral") {
      if(level.flagcapturetime > 0.05) {
        scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var_0);

        if(isDefined(level.objectives) && level.objectives.size == 5 && (self.objectivekey == "_c" || self.objectivekey == "_d") || self.objectivekey == "_b") {
          var_5 = scripts\mp\utility\game::getotherteam(var_0)[0];
          scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var_5);
        }
      }
    } else if(level.flagcapturetime > 0.05) {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var_4);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var_0);
    }

    self.didstatusnotify = 1;
    return;
  }
}

function dompoint_onuseend(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    thread updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    thread updateflagstate(var_3, 0);
  }

  if(!var_2) {
    self.neutralized = 0;
    return;
  }
}

function dompoint_oncontested() {
  self.hostvictimoverride = gettime();
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread updateflagstate("contested", 0);
}

function dompoint_onuncontested(var_0) {
  if(istrue(level.flagneutralization) && !self.firstcapture) {
    scripts\mp\gameobjects::setusetime(level.flagcapturetime * 0.5);
  }

  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_1 == "neutral") {
    if(var_0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
    } else if(isDefined(self.lastprogressteam)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, self.lastprogressteam);
    }
  } else {
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(var_1)[0]);
  }

  if(var_0 == "none" || var_1 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  var_2 = (gettime() - self.hostvictimoverride) * 0.001;
  var_3 = "Flag " + resetchemicalvalvevalues() + " Contested";
  scripts\mp\utility\game::ref_119AC(undefined, undefined, var_3, undefined, var_2 + " seconds");
  self.hostvictimoverride = undefined;
  var_4 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  thread updateflagstate(var_4, 0);
}

function play_dom_capture_sfx(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "";
    var_0 = int(floor(var_0 * 10));
    var_2 = "mp_dom_capturing_tick_0" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
    return;
  }
}

function dompoint_onunoccupied() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  self.didstatusnotify = 0;
}

function dompoint_onpinnedstate(var_0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
    return;
  }
}

function dompoint_onunpinnedstate(var_0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    return;
  }
}

function dompoint_stompprogressreward(var_0) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

function setcrankedtimerdomflag(var_0) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked) {
    var_0 scripts\mp\cranked::setcrankedplayerbombtimer("assist");
    return;
  }
}

function ref_136CE() {
  var_0 = 20;
  var_1 = 600;
  var_2 = self.flagmodel.origin;
  var_3 = var_2 + (0, 0, var_0);
  var_4 = var_2 + (0, 0, var_1);
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var_6 = [];
  var_6 = level.players;
  GscBinSkip0(0x2e, var_6.size, self.flagmodel);
}

function ref_136CF() {
  if(isDefined(self.spawnpoint_clearspawnpoint)) {
    return;
  }

  self.spawnpoint_clearspawnpoint = 1;
  var_0 = 20;
  var_1 = 600;

  if(level.mapname == "mp_shipment") {
    var_1 = 400;
  }

  var_2 = self.flagmodel.origin;
  var_3 = var_2 + (0, 0, var_0);
  var_4 = var_2 + (0, 0, var_1);
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var_6 = [];
  var_6 = level.players;
  GscBinSkip0(0x2e, var_6.size, self.flagmodel);
}

function setplayermostwantedextrainfo() {
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = 4000;
  var_1 = 20;
  var_2 = self.flagmodel.origin;
  var_3 = var_2 + (0, 0, var_0);
  var_4 = var_2 + (0, 0, var_1);
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var_6 = [];
  var_6 = level.players;
  GscBinSkip0(0x2e, var_6.size, self.flagmodel);
}

function dompoint_setupflagmodels() {
  game["flagmodels"] = [];
  game["flagmodels"]["neutral"] = "prop_flag_neutral";
}

function updateflagstate(var_0, var_1, var_2, var_3) {
  self notify("updateFlagState");
  self endon("updateFlagState");

  if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "br") {
    if(istrue(var_3)) {
      self.flagmodel.angles += (90, 0, 0);
    } else if(isDefined(var_2) && self.firstcapture && scripts\mp\utility\game::getgametype() != "arena") {
      thread ref_12ED1();
    } else if(isDefined(var_2)) {
      playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], self.flagmodel.origin + (0, 0, 60));
    }
  } else if(isDefined(var_2)) {
    if(var_2 == "allies") {
      self.flagmodel setModel("military_dom_flag_west");
    } else if(var_2 == "axis") {
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

  if(scripts\mp\utility\game::getgametype() == "defcon") {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "arm") {
    return;
  }

  if(isDefined(self.scriptable)) {
    if(var_0 == "off") {
      setdomscriptablepartstate("flag", var_0);
    } else {
      setdomscriptablepartstate("flag", var_0, self.vfxnamemod);
    }

    if(!istrue(var_1)) {
      setdomscriptablepartstate("pulse", "off");
      return;
    }

    return;
  }
}

function setdomscriptablepartstate(var_0, var_1, var_2) {
  if(!isDefined(self.scriptable)) {
    return;
  }

  if(isDefined(level.setdomscriptablepartstatefunc)) {
    if([[level.setdomscriptablepartstatefunc]](var_0, var_1, var_2)) {
      return;
    }
  }

  if(isDefined(var_2)) {
    var_1 += var_2;
  }

  self.scriptable setscriptablepartstate(var_0, var_1);
}

function updateflagcapturestate(var_0) {
  if(isDefined(self.noscriptable)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "defcon") {
    if(isDefined(self.scriptable)) {
      setdomscriptablepartstate("pulse", var_0, self.vfxnamemod);
      return;
    }

    return;
  }
}

function ondisconnect() {
  self waittill("disconnect");

  foreach(var_1 in self._domflageffect) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }

  foreach(var_4 in self._domflagpulseeffect) {
    if(isDefined(var_4)) {
      var_4 delete();
    }
  }
}

function giveflagassistedcapturepoints(var_0) {
  level endon("game_ended");
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_0[var_1[var_2]].player;

    if(!isDefined(var_3)) {
      continue;
    }

    if(isDefined(var_3.owner)) {
      var_3 = var_3.owner;
    }

    if(!isPlayer(var_3)) {
      continue;
    }

    if(istrue(level.flagneutralization)) {
      var_3 thread scripts\mp\rank::scoreeventpopup("neutralized");
    } else {
      var_3 thread scripts\mp\rank::scoreeventpopup("capture");
    }

    var_3 thread scripts\mp\awards::givemidmatchaward("mode_dom_neutralized");
    setcrankedtimerdomflag(var_3, var_3);
    wait 0.05;
  }
}

function giveflagcapturexp(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = var_1;

  if(isDefined(var_3.owner)) {
    var_3 = var_3.owner;
  }

  level.lastcaptime = gettime();
  level.playholdtwovo = 1;

  if(isPlayer(var_3)) {
    if(scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "rush") {
      level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition", var_3);
    } else {
      level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition" + self.objectivekey, var_3);
    }

    var_3 thread scripts\common\utility::ref_13E0A(level.ref_11B29, "capture", var_3.origin);
  }

  if(self.firstcapture == 1) {
    var_4 = 1;
  } else {
    var_4 = 0;
  }

  if(isDefined(var_1)) {
    var_5 = getarraykeys(var_1);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_7 = var_1[var_5[var_6]].player;

      if(isDefined(var_7.owner)) {
        var_7 = var_7.owner;
      }

      if(!isPlayer(var_7)) {
        continue;
      }

      setcapturestats(var_7);
      givecaptureawards(var_7, var_4, 0);
      setcrankedtimerdomflag(var_7);
      wait 0.05;
    }

    if(isDefined(self.assisttouchlist)) {
      if(self.assisttouchlist[var_3].size > 0) {
        var_8 = getarraykeys(self.assisttouchlist[var_3]);

        foreach(var_10 in var_5) {
          foreach(var_12 in var_8) {
            if(var_12 == var_10) {
              self.assisttouchlist[var_3][var_12] = undefined;
            }
          }
        }
      }

      if(self.assisttouchlist[var_3].size > 0) {
        thread giveflagcaptureassistxp(var_3, var_4);
        return;
      }

      return;
    }

    return;
  }
}

function giveflagcaptureassistxp(var_0, var_1) {
  level endon("game_ended");
  var_2 = getarraykeys(self.assisttouchlist[var_0]);

  if(var_2.size > 0) {
    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = self.assisttouchlist[var_0][var_2[var_3]].player;

      if(isDefined(var_4.owner)) {
        var_4 = var_4.owner;
      }

      if(!isPlayer(var_4)) {
        continue;
      }

      setcapturestats(var_4);
      givecaptureawards(var_4, var_1, 1);
      setcrankedtimerdomflag(var_4);
      self.assisttouchlist[var_0][var_2[var_3]] = undefined;
      wait 0.05;
    }

    return;
  }
}

function givecaptureawards(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = "";

  if(var_2) {
    var_0 thread scripts\mp\rank::scoreeventpopup("capture_assist");
    var_4 = "mode_dom_secure_assist";
  } else if(var_1) {
    var_5 = scripts\mp\utility\game::getgametype() == "arm";
    var_6 = !var_5 && self.objectivekey == "_b" || var_5 && self.objectivekey == "_c";
    var_7 = var_5 && (self.objectivekey == "_b" || self.objectivekey == "_d");

    if(var_6) {
      if(var_5) {
        var_0 thread scripts\mp\rank::scoreeventpopup("neutral_capture");
        var_4 = "mode_arm_secure_mid";
      } else {
        var_0 thread scripts\mp\rank::scoreeventpopup("neutral_b_capture");
        var_4 = "mode_dom_secure_b";
      }
    } else if(var_7) {
      var_0 thread scripts\mp\rank::scoreeventpopup("neutral_capture");
      var_4 = "mode_arm_secure_outer_mid";
    } else if(var_5) {
      var_0 thread scripts\mp\rank::scoreeventpopup("neutral_capture");
      var_4 = "mode_arm_secure_outer";
    } else {
      var_0 thread scripts\mp\rank::scoreeventpopup("neutral_capture");
      var_4 = "mode_dom_secure_neutral";
    }
  } else if(istrue(level.flagneutralization)) {
    var_0 thread scripts\mp\rank::scoreeventpopup("capture");
    var_4 = "mode_dom_neutralized_cap";
  } else {
    var_0 thread scripts\mp\rank::scoreeventpopup("capture");
    var_4 = "mode_dom_secure";
  }

  var_0 thread scripts\mp\awards::givemidmatchaward(var_4);

  if(var_3) {
    var_0 scripts\mp\killstreaks\killstreaks::givestreakpoints("capture", 1, 0);
    return;
  }
}

function setcapturestats() {
  scripts\mp\utility\stats::incpersstat("captures", 1);

  if(isDefined(self.pers["captures"])) {
    scripts\mp\persistence::statsetchild("round", "captures", self.pers["captures"]);

    if(scripts\mp\utility\game::getgametype() != "arena") {
      scripts\mp\utility\stats::setextrascore0(self.pers["captures"]);
      return;
    }

    return;
  }
}

function precap(var_0) {
  storecenterflag(var_0);
  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, level.centerflag);
}

function storecenterflag(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.objectives) {
    if(istrue(var_0)) {
      if(var_3.objectivekey == "_c") {
        level.centerflag = var_3;
      }
    }

    if(var_3.objectivekey == "_b") {
      level.centerflag = var_3;
    }
  }
}

function setflagcaptured(var_0, var_1, var_2, var_3) {
  scripts\mp\gameobjects::setownerteam(var_0);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
  thread updateflagstate(var_0, 0, var_0);
  self.capturetime = gettime();
  var_4 = scripts\mp\utility\game::getgametype();

  if(var_4 == "siege") {
    scripts\mp\gametypes\siege::watchflagenduse(var_0);
  }

  if(!isDefined(var_3)) {
    if(var_1 != "neutral") {
      var_5 = getteamflagcount(var_0);

      if(var_5 == 2) {
        scripts\mp\utility\dialog::statusdialog("friendly_captured_2", var_0);
        scripts\mp\utility\dialog::statusdialog("enemy_captured_2", var_1);
      } else {
        scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, var_0);
        scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, var_1);
      }

      level.lastcaptime = gettime();
    }

    if(var_4 == "siege") {
      scripts\mp\gametypes\siege::teamrespawn(var_0, var_2);
    }

    self.firstcapture = 0;
    return;
  }
}

function getteamflagcount(var_0) {
  var_1 = 0;

  foreach(var_3 in level.objectives) {
    if(var_3.ownerteam == var_0) {
      var_1++;
    }
  }

  return var_1;
}

function isflagexcluded(var_0, var_1) {
  var_2 = 0;

  if(isarray(var_1)) {
    foreach(var_4 in var_1) {
      if(var_0 == var_4) {
        var_2 = 1;
        break;
      }
    }
  } else if(var_0 == var_1) {
    var_2 = 1;
  }

  return var_2;
}

function getunownedflagneareststart(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level.objectives) {
    if(var_6 scripts\mp\gameobjects::getownerteam() != "neutral") {
      continue;
    }

    var_7 = distancesquared(var_6.trigger.origin, level.startpos[var_0]);

    if(isDefined(var_1)) {
      if(!isflagexcluded(var_6, var_1) && (!isDefined(var_2) || var_7 < var_3)) {
        var_3 = var_7;
        var_2 = var_6;
      }

      continue;
    }

    if(!isDefined(var_2) || var_7 < var_3) {
      var_3 = var_7;
      var_2 = var_6;
    }
  }

  return var_2;
}

function awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = self;
  var_14 = var_13.origin;
  var_15 = var_1.origin;
  var_16 = 0;

  if(!isDefined(var_1.team) || !isDefined(var_13.team)) {
    return;
  }

  if(isDefined(var_0)) {
    var_15 = var_0.origin;
    var_16 = var_0 == var_1;

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      if(istrue(var_0.useagents)) {
        return;
      }
    }
  }

  foreach(var_18 in level.objectives) {
    if(istrue(var_18.trigger.trigger_off)) {
      continue;
    }

    var_19 = var_18 scripts\mp\gameobjects::getownerteam();
    var_20 = var_1 istouching(var_18.trigger);
    var_21 = var_13 istouching(var_18.trigger);

    if(var_20 && var_1.team != var_19) {
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
      var_18 notify("assault", var_1);
      var_11 = 1;
    }

    if(var_19 == "neutral") {
      if(var_20 || var_21) {
        if(var_18.claimteam == var_13.team) {
          if(!var_11) {
            var_11 = 1;
            var_1 thread scripts\mp\rank::scoreeventpopup("assault");
            var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
            var_18 notify("assault", var_1);
            thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_9, "assaulting");
            continue;
          }
        } else if(var_18.claimteam == var_1.team) {
          if(!var_12) {
            var_12 = 1;
            var_1 thread scripts\mp\rank::scoreeventpopup("defend");
            var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
            var_18 notify("defend", var_1);
            var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
            var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
            var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["defends"]);
            thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_9, "defending");
            continue;
          }
        }
      }

      continue;
    }

    if(var_19 != var_1.team) {
      if(!var_11) {
        var_22 = distsquaredcheck(var_18.trigger, var_15, var_14);

        if(var_22) {
          var_11 = 1;
          var_1 thread scripts\mp\rank::scoreeventpopup("assault");
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
          var_18 notify("assault", var_1);
          thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_9, "assaulting");
          continue;
        }
      }

      continue;
    }

    if(!var_12) {
      var_23 = distsquaredcheck(var_18.trigger, var_15, var_14);

      if(var_23) {
        var_12 = 1;
        var_1 thread scripts\mp\rank::scoreeventpopup("defend");
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        var_18 notify("defend", var_1);
        var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
        var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
        var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["defends"]);
        thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_9, "defending");
      }
    }
  }
}

function distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0.origin, var_1);
  var_4 = distancesquared(var_0.origin, var_2);

  if(var_3 < 105625 || var_4 < 105625) {
    if(!isDefined(var_0.modifieddefendcheck)) {
      return 1;
    }

    if(var_1[2] - var_0.origin[2] < 100 || var_2[2] - var_0.origin[2] < 100) {
      return 1;
    }

    return 0;
  }

  return 0;
}

function relic_nuketimer_timerloop() {
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

function resetchemicalvalvevalues() {
  if(!isDefined(self.objectivekey)) {
    return "";
  }

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

function ref_12ED1() {
  self rotateTo(self.angles - (135, 0, 0), 0.5, 0.25, 0.25);
  self playSound("mp_dom_scarecrow_hw");
  wait 0.55;
  playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], self.origin + (0, 0, 60));
  self rotateTo(self.angles + (80, 0, 0), 0.2, 0.1, 0.1);
  wait 0.25;
  self rotateTo(self.angles - (60, 0, 0), 0.2, 0.1, 0.1);
  wait 0.25;
  self rotateTo(self.angles + (40, 0, 0), 0.2, 0.1, 0.1);
  wait 0.25;
  self rotateTo(self.angles - (15, 0, 0), 0.2, 0.1, 0.1);
  wait 0.25;
  self notify("start_stalker");
}

function markdistanceoverride() {
  level endon("game_ended");
  self.flagmodel.startorigin = self.flagmodel.origin;
  self.flagmodel waittill("start_stalker");
  self.flagmodel.fwd = anglesToForward(self.flagmodel.angles);
  self.flagmodel.ismoving = 0;
  thread ref_144F0();

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      if(!isDefined(self.ref_1376A)) {
        self.ref_1376A = var_0;
        thread ref_144F8(self.flagmodel, var_0);
      }
    }

    wait 0.25;
  }
}

function ref_144F8(var_0, var_1) {
  level endon("game_ended");
  self notify("new_stalker_target");
  self endon("new_stalker_target");

  while(isDefined(self.ref_1376A)) {
    if(!ref_140D6(var_0, var_1)) {
      self.ref_1376A = undefined;
      self.ref_13769 = 0;
      self.paddedquadgridcenterpoints = undefined;
      self.buildloadoutindices = undefined;
      self.ref_12AC7 = undefined;
      self.flagmodel rotateTo((0, self.flagmodel.angles[1], self.flagmodel.angles[2]), 0.2, 0.1, 0.1);
    } else if(isDefined(self.ref_1376A) && scripts\mp\utility\player::isreallyalive(self.ref_1376A)) {
      if(self.flagmodel.ismoving) {} else {
        self.flagmodel.fwd = anglesToForward(self.flagmodel.angles);
        var_2 = self.ref_1376A.origin;
        var_3 = self.flagmodel.origin;
        var_4 = vectorNormalize(var_2 - var_3);
        var_5 = vectortoangles(var_4);
        self.flagmodel rotateTo((0, var_5[1], var_5[2]), 0.2, 0.1, 0.1);
        self.flagmodel.ismoving = 1;
      }
    }

    wait 0.25;
    self.flagmodel.ismoving = 0;
  }
}

function ref_144F0() {
  self.flagmodel setCanDamage(1);
  self.ref_13769 = 0;

  for(;;) {
    self.flagmodel waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(isDefined(var_1) && isDefined(self.ref_1376A) && self.ref_1376A == var_1) {
      self.ref_13769 += var_0;
    }

    if(isDefined(self.ref_13769)) {
      if(self.ref_13769 > 100 && !isDefined(self.paddedquadgridcenterpoints)) {
        self.paddedquadgridcenterpoints = 1;
      }

      if(self.ref_13769 > 200 && !isDefined(self.buildloadoutindices)) {
        self.buildloadoutindices = 1;
        playFX(level.spawnoffsettacinsertmax["vanish_hw_en"], self.flagmodel.origin + (0, 0, 80));
      }

      if(self.ref_13769 > 300 && !isDefined(self.ref_12AC7)) {
        self.ref_12AC7 = 1;
        thread ref_12CCD(var_1);
      }
    }

    wait 0.25;
  }
}

function ref_12CCD(var_0) {
  self.flagmodel moveTo(self.flagmodel.origin + (0, 0, 50), 0.2, 0.1, 0.1);
  wait 0.25;
  self.flagmodel moveTo(self.flagmodel.startorigin, 0.1, 0.05, 0.05);
  wait 0.2;
  self.flagmodel playSound("mp_dom_scarecrow_hw_explo");
  var_1 = self.flagmodel.origin + (0, 0, 32);
  playFX(level._effect["cranked_explode"], var_1);

  if(isDefined(var_0)) {
    var_0 dodamage(100, self.flagmodel.origin + (0, 0, 50), var_0, self.flagmodel, "MOD_EXPLOSIVE", undefined, "head");
  }

  self.ref_13769 = 0;
  self.paddedquadgridcenterpoints = undefined;
  self.buildloadoutindices = undefined;
  self.ref_12AC7 = undefined;
}

function round_robin_spawners() {
  var_0 = self getplayerangles();
  var_1 = anglesToForward(var_0);
  return var_1;
}

function ref_140D6(var_0, var_1) {
  var_2 = 0.05;
  var_3 = round_mortars_logic(var_1);
  var_4 = rocket_fuel_x2(var_0);
  var_5 = distancesquared(var_4, var_3);

  if(var_5 > 90000) {
    return false;
  } else {
    return true;
  }

  return false;
}

function rocket_fuel_x2() {
  return self.origin;
}

function round_mortars_logic() {
  return self.origin;
}