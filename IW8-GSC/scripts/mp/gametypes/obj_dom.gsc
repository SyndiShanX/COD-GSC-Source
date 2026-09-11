/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_dom.gsc
***********************************************/

function setupobjective(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var5)) {
    var5 = 1;
  }

  if(isDefined(var0.target)) {
    if(!isDefined(var0.visuals)) {
      GscBinSkip1(0x45, 0, getEnt(var0.target, "targetname"));
    }

    var7 = var0.visuals;
  } else {
    GscBinSkip1(0x45, 0, spawn("script_model", var1.origin));
  }

  if(!isDefined(level.flagcapturetime)) {
    level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 10, 0, 30);
  }

  if(isDefined(var0.objectivekey)) {
    var8 = var0.objectivekey;
  } else {
    var8 = var1.script_label;
  }

  if(isDefined(var1.iconname)) {
    var9 = var1.iconname;
  } else {
    var9 = var2.script_label;
  }

  if(istrue(var4)) {
    var10 = getreservedobjid(var9);
  } else {
    var10 = undefined;
  }

  if(!isDefined(var4)) {
    var4 = "neutral";
  }

  var11 = scripts\mp\gameobjects::createuseobject(var4, var3, var9, (0, 0, 100), var10, var6, var7, var8);
  var11 scripts\mp\gameobjects::allowuse("enemy");
  var11 scripts\mp\gameobjects::cancontestclaim(1);
  var11 scripts\mp\gameobjects::setusetime(level.flagcapturetime);

  if(isDefined(level.capturetype)) {
    var11 scripts\mp\gameobjects::setcapturebehavior(getcapturetype());
  }

  var11.objectivekey = var9;
  var11.iconname = var10;

  if(!istrue(var6)) {
    var11 scripts\mp\gameobjects::setvisibleteam("any", undefined, 1);
    var11.onuse = &dompoint_onuse;
    var11.onbeginuse = &dompoint_onusebegin;
    var11.onuseupdate = &dompoint_onuseupdate;
    var11.onenduse = &dompoint_onuseend;
    var11.oncontested = &dompoint_oncontested;
    var11.onuncontested = &dompoint_onuncontested;
    var11.onunoccupied = &dompoint_onunoccupied;
    var11.onpinnedstate = &dompoint_onpinnedstate;
    var11.onunpinnedstate = &dompoint_onunpinnedstate;
    var11.stompprogressreward = &dompoint_stompprogressreward;
  }

  var11.nousebar = 1;
  var11.id = "domFlag";
  var11.claimgracetime = level.flagcapturetime * 1000;
  var11.firstcapture = 1;
  var11 scripts\mp\gameobjects::pinobjiconontriggertouch();

  if(istrue(level.playinggulagbink)) {
    var11.ref_136cd = &ref_136ce;
  } else if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "br") {
    var11.ref_136cd = &ref_136cf;
  }

  var12 = var9[0].origin + (0, 0, 32);
  var13 = var9[0].origin + (0, 0, -32);
  var14 = scripts\engine\trace::create_contents(var8, 1, 1, 1, 0, 1, 1);
  var15 = [];
  var16 = scripts\engine\trace::ray_trace(var12, var13, var15, var14);
  var17 = checkmapoffsets(var11);
  var11.baseeffectpos = var16["position"] + var17;
  var18 = vectortoangles(var16["normal"]);
  var19 = checkmapfxangles(var11, var18);
  var11.baseeffectforward = anglesToForward(var19);
  var20 = spawn("script_model", var11.baseeffectpos);
  var20 setModel("dom_flag_scriptable");
  var20.angles = generateaxisanglesfromforwardvector(var11.baseeffectforward, var20.angles);
  var11.scriptable = var20;
  var11.vfxnamemod = "";
  var11.noscriptable = 1;

  if(istrue(level.multiteambased)) {
    var11.noscriptable = 1;
  }

  var11.flagmodel = spawn("script_model", var11.baseeffectpos);

  if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "br") {
    var21 = "decor_halloween_scarecrow";
    var11.flagmodel.useagents = 1;
  } else {
    var21 = "military_dom_flag_neutral";
  }

  var12.flagmodel setModel(var21);
  var12.flagmodel.angles = getlivingplayersonteam(var12);
  var12.outlineent = var12.flagmodel;

  if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "br") {
    thread setplayermostwantedextrainfo();
    thread markdistanceoverride();
  }

  initializematchrecording(var12);

  if(!istrue(var7)) {
    domflag_setneutral(var12, undefined, 1);
  }

  return var12;
}

function removeobjective(var0) {
  if(isDefined(var0.flagmodel)) {
    var0.flagmodel delete();
  }

  if(isDefined(var0.scriptable)) {
    var0.scriptable delete();
  }

  var0 scripts\mp\gameobjects::deleteuseobject();
}

function getreservedobjid(var0) {
  if(var0 == "_a") {
    var1 = 0;
  } else if(var1 == "_b") {
    var1 = 1;
  } else if(var1 == "_d") {
    var1 = 3;
  } else if(var1 == "_e") {
    var1 = 4;
  } else {
    var1 = 2;
  }

  return var1;
}

function getcapturetype() {
  var0 = "normal";

  if(level.capturetype == 2) {
    var0 = "neutralize";
  } else if(level.capturetype == 3) {
    var0 = "persistent";
  }

  return var0;
}

function getlivingplayersonteam(var0) {
  var1 = var0.objectivekey;
  var2 = (0, 0, 0);

  if(level.mapname == "mp_hardhat") {
    if(var1 == "_b") {
      var2 = (0, 110, 0);
    }
  }

  return var2;
}

function checkmapoffsets(var0) {
  var1 = var0.objectivekey;
  var2 = (0, 0, 0);

  if(level.mapname == "mp_quarry") {
    if(var1 == "_c") {
      var2 += (0, 0, 7);
    }
  }

  if(level.mapname == "mp_divide") {
    if(var1 == "_a") {
      var2 += (0, 0, 4.5);
    }
  }

  if(level.mapname == "mp_afghan") {
    if(var1 == "_a") {
      var2 += (0, 0, 5);
    }

    if(var1 == "_c") {
      var2 += (0, 0, 1);
    }
  }

  return var2;
}

function checkmapfxangles(var0, var1) {
  var2 = var0.objectivekey;
  var3 = var1;

  if(level.mapname == "mp_quarry") {
    if(var2 == "_c") {
      var3 = (276.5, var3[1], var3[2]);
    }
  }

  if(level.mapname == "mp_divide") {
    if(var2 == "_a") {
      var3 = (273.5, var3[1], var3[2]);
    }
  }

  if(level.mapname == "mp_afghan") {
    if(var2 == "_a") {
      var3 = (273.5, 200.5, var3[2]);
    }

    if(var2 == "_c") {
      var3 = (273.5, var3[1], var3[2]);
    }
  }

  if(level.mapname == "mp_faridah") {
    if(isstring(var2)) {
      if(var2 == "_school") {
        var3 = (270, 0, 0);
      } else if(var2 == "_warehouse") {
        var3 = (270, 0, 0);
      }
    }
  }

  return var3;
}

function initializematchrecording() {
  if(isDefined(level.matchrecording_logevent)) {
    self.logid = [[level.matchrecording_generateid]]();
    var0 = "A";

    switch (self.objectivekey) {
      case "_a":
        var0 = "A";
        break;
      case "_b":
        var0 = "B";
        break;
      case "_c":
        var0 = "C";
        break;
      case "_d":
        var0 = "D";
        break;
      case "_e":
        var0 = "E";
        break;
      case "0":
        var0 = "0";
        break;
      case "1":
        var0 = "1";
        break;
      case "2":
        var0 = "2";
        break;
      case "3":
        var0 = "3";
        break;
      case "4":
        var0 = "4";
        break;
      default:
        break;
    }

    self.logeventflag = "FLAG_" + var0;
  }

  if(scripts\mp\analyticslog::analyticslogenabled()) {
    self.analyticslogid = scripts\mp\analyticslog::getuniqueobjectid();
    self.analyticslogtype = "dom_flag" + self.objectivekey;
    return;
  }
}

function domflag_setneutral(var0, var1) {
  self notify("flag_neutral");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral, undefined, undefined, undefined, 1);
  scripts\mp\gameobjects::setownerteam("neutral");
  thread updateflagstate("idle", istrue(var0), undefined, var1);

  if(isDefined(level.matchrecording_logevent) && isDefined(self.logid) && isDefined(self.logeventflag)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), 0);
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "neutral");
}

function dompoint_setcaptured(var0, var1) {
  scripts\mp\gameobjects::setownerteam(var0);
  self notify("capture", var1);
  self notify("assault", var1);

  if(istrue(level.numflagsscoreonkill)) {
    var2 = getteamflagcount(var0);

    if(var2 >= level.numflagsscoreonkill) {
      level.teamscoresonkill[var0] = 1;
    } else {
      level.teamscoresonkill[var0] = 0;
    }
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);

  if(scripts\mp\utility\game::getgametype() == "btm") {
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(self.ownerteam, 15, 14);
  }

  self.neutralized = 0;
  thread updateflagstate(var0, 0, var0);

  if(self.touchlist[var0].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  foreach(var4 in level.teamnamelist) {
    if(isDefined(self.assisttouchlist[var4]) && var4 != var0) {
      self.assisttouchlist[var4] = [];
    }
  }

  if(isDefined(self.assisttouchlist[var0])) {
    var6 = getarraykeys(self.assisttouchlist[var0]);

    foreach(var8 in var6) {
      var9 = self.assisttouchlist[var0][var8].player;

      if(isDefined(var9.owner)) {
        var9 = var9.owner;
      }

      if(!isPlayer(var9)) {
        continue;
      }

      var9 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
    }
  }

  thread giveflagcapturexp(self.touchlist[var0], var1, var0);

  if(isDefined(level.matchrecording_logevent)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), scripts\engine\utility::ter_op(var0 == "allies", 1, 2));
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + var0);
}

function dompoint_onuse(var0) {
  var1 = var0.team;
  var2 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;

  if(istrue(level.flagneutralization)) {
    var3 = scripts\mp\gameobjects::getownerteam();

    if(var3 == "neutral") {
      dompoint_setcaptured(var1, var0);

      if(isDefined(self.ref_136cd)) {
        [[self.ref_136cd]]();
      }
    } else {
      thread domflag_setneutral(1);
      scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", var3);
      level.lastcaptime = gettime();
      thread giveflagassistedcapturepoints(self.touchlist[var1]);
      self.neutralized = 1;
    }
  } else {
    dompoint_setcaptured(var1, var0);

    if(isDefined(self.ref_136cd)) {
      [[self.ref_136cd]]();
    }
  }

  if(!self.neutralized) {
    var4 = 3;

    if(self.objectivekey == "_a") {
      var4 = 1;
    } else if(self.objectivekey == "_b") {
      var4 = 2;
    } else if(self.objectivekey == "_d") {
      var4 = 4;
    } else if(self.objectivekey == "_e") {
      var4 = 5;
    }

    scripts\mp\utility\game::setmlgannouncement(21, var1, var0 getentitynumber(), var4);

    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, var0, var1, var2, self);
      var5 = "Flag " + resetchemicalvalvevalues() + " Captured";

      if(var2 == "neutral" || var2 == "none") {
        scripts\mp\utility\game::ref_119ac(var0, undefined, var5, var0.origin, "neutral_flag");
      } else {
        scripts\mp\utility\game::ref_119ac(var0, undefined, var5, var0.origin);
      }
    }
  }

  self.firstcapture = 0;
}

function dompoint_onusebegin(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  self.neutralizing = istrue(level.flagneutralization) && var1 != "neutral";

  if(self.neutralizing) {
    if(var1 != var0.team) {
      var2 = relic_nuketimer_timerloop();
    } else {
      var2 = 0;
    }
  } else if(var2 != var2.team) {
    var2 = 1;
  } else {
    var2 = 0;
  }

  var2 setclientomnvar("ui_objective_state", var2);

  if(!isDefined(self.statusnotifytime)) {
    self.statusnotifytime = gettime();
  }

  if(!istrue(self.neutralized) && self.statusnotifytime > self.statusnotifytime + 5000) {
    self.didstatusnotify = 0;
    self.statusnotifytime = gettime();
  }

  var3 = scripts\engine\utility::ter_op(istrue(level.flagneutralization) && !self.firstcapture, level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(var3);

  if(var3 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var2.team)[0];
    updateflagcapturestate(var2.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
  }

  if(istrue(level.hideenemyfobs)) {
    if(var2.team != var2) {
      scripts\mp\gameobjects::setvisibleteam("any");
      return;
    }

    return;
  }
}

function dompoint_onuseupdate(var0, var1, var2, var3) {
  var4 = scripts\mp\gameobjects::getownerteam();

  if(var1 < 1 && !level.gameended && !scripts\mp\utility\game::isanymlgmatch()) {
    play_dom_capture_sfx(var1, var0);
  }

  if(var1 > 0.05 && var2 && !self.didstatusnotify) {
    if(var4 == "neutral") {
      if(level.flagcapturetime > 0.05) {
        scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var0);

        if(isDefined(level.objectives) && level.objectives.size == 5 && (self.objectivekey == "_c" || self.objectivekey == "_d") || self.objectivekey == "_b") {
          var5 = scripts\mp\utility\game::getotherteam(var0)[0];
          scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var5);
        }
      }
    } else if(level.flagcapturetime > 0.05) {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var4);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var0);
    }

    self.didstatusnotify = 1;
    return;
  }
}

function dompoint_onuseend(var0, var1, var2) {
  if(isPlayer(var1)) {
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_dom_securing = undefined;
  }

  var3 = scripts\mp\gameobjects::getownerteam();

  if(var3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    thread updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    thread updateflagstate(var3, 0);
  }

  if(!var2) {
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

function dompoint_onuncontested(var0) {
  if(istrue(level.flagneutralization) && !self.firstcapture) {
    scripts\mp\gameobjects::setusetime(level.flagcapturetime * 0.5);
  }

  var1 = scripts\mp\gameobjects::getownerteam();

  if(var1 == "neutral") {
    if(var0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var0);
    } else if(isDefined(self.lastprogressteam)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, self.lastprogressteam);
    }
  } else {
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(var1)[0]);
  }

  if(var0 == "none" || var1 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  var2 = (gettime() - self.hostvictimoverride) * 0.001;
  var3 = "Flag " + resetchemicalvalvevalues() + " Contested";
  scripts\mp\utility\game::ref_119ac(undefined, undefined, var3, undefined, var2 + " seconds");
  self.hostvictimoverride = undefined;
  var4 = scripts\engine\utility::ter_op(var1 == "neutral", "idle", var1);
  thread updateflagstate(var4, 0);
}

function play_dom_capture_sfx(var0, var1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var2 = "";
    var0 = int(floor(var0 * 10));
    var2 = "mp_dom_capturing_tick_0" + var0;
    self.visuals[0] playsoundtoteam(var2, var1);
    return;
  }
}

function dompoint_onunoccupied() {
  var0 = scripts\mp\gameobjects::getownerteam();

  if(var0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  self.didstatusnotify = 0;
}

function dompoint_onpinnedstate(var0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
    return;
  }
}

function dompoint_onunpinnedstate(var0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    return;
  }
}

function dompoint_stompprogressreward(var0) {
  var0 thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

function setcrankedtimerdomflag(var0) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var0.cranked) && var0.cranked) {
    var0 scripts\mp\cranked::setcrankedplayerbombtimer("assist");
    return;
  }
}

function ref_136ce() {
  var0 = 20;
  var1 = 600;
  var2 = self.flagmodel.origin;
  var3 = var2 + (0, 0, var0);
  var4 = var2 + (0, 0, var1);
  var5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var6 = [];
  var6 = level.players;
  GscBinSkip0(0x2e, var6.size, self.flagmodel);
}

function ref_136cf() {
  if(isDefined(self.spawnpoint_clearspawnpoint)) {
    return;
  }

  self.spawnpoint_clearspawnpoint = 1;
  var0 = 20;
  var1 = 600;

  if(level.mapname == "mp_shipment") {
    var1 = 400;
  }

  var2 = self.flagmodel.origin;
  var3 = var2 + (0, 0, var0);
  var4 = var2 + (0, 0, var1);
  var5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var6 = [];
  var6 = level.players;
  GscBinSkip0(0x2e, var6.size, self.flagmodel);
}

function setplayermostwantedextrainfo() {
  scripts\mp\flags::gameflagwait("prematch_done");
  var0 = 4000;
  var1 = 20;
  var2 = self.flagmodel.origin;
  var3 = var2 + (0, 0, var0);
  var4 = var2 + (0, 0, var1);
  var5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var6 = [];
  var6 = level.players;
  GscBinSkip0(0x2e, var6.size, self.flagmodel);
}

function dompoint_setupflagmodels() {
  game["flagmodels"] = [];
  game["flagmodels"]["neutral"] = "prop_flag_neutral";
}

function updateflagstate(var0, var1, var2, var3) {
  self notify("updateFlagState");
  self endon("updateFlagState");

  if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "br") {
    if(istrue(var3)) {
      self.flagmodel.angles += (90, 0, 0);
    } else if(isDefined(var2) && self.firstcapture && scripts\mp\utility\game::getgametype() != "arena") {
      thread ref_12ed1();
    } else if(isDefined(var2)) {
      playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], self.flagmodel.origin + (0, 0, 60));
    }
  } else if(isDefined(var2)) {
    if(var2 == "allies") {
      self.flagmodel setModel("military_dom_flag_west");
    } else if(var2 == "axis") {
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
    if(var0 == "off") {
      setdomscriptablepartstate("flag", var0);
    } else {
      setdomscriptablepartstate("flag", var0, self.vfxnamemod);
    }

    if(!istrue(var1)) {
      setdomscriptablepartstate("pulse", "off");
      return;
    }

    return;
  }
}

function setdomscriptablepartstate(var0, var1, var2) {
  if(!isDefined(self.scriptable)) {
    return;
  }

  if(isDefined(level.setdomscriptablepartstatefunc)) {
    if([[level.setdomscriptablepartstatefunc]](var0, var1, var2)) {
      return;
    }
  }

  if(isDefined(var2)) {
    var1 += var2;
  }

  self.scriptable setscriptablepartstate(var0, var1);
}

function updateflagcapturestate(var0) {
  if(isDefined(self.noscriptable)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "defcon") {
    if(isDefined(self.scriptable)) {
      setdomscriptablepartstate("pulse", var0, self.vfxnamemod);
      return;
    }

    return;
  }
}

function ondisconnect() {
  self waittill("disconnect");

  foreach(var1 in self._domflageffect) {
    if(isDefined(var1)) {
      var1 delete();
    }
  }

  foreach(var4 in self._domflagpulseeffect) {
    if(isDefined(var4)) {
      var4 delete();
    }
  }
}

function giveflagassistedcapturepoints(var0) {
  level endon("game_ended");
  var1 = getarraykeys(var0);

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var0[var1[var2]].player;

    if(!isDefined(var3)) {
      continue;
    }

    if(isDefined(var3.owner)) {
      var3 = var3.owner;
    }

    if(!isPlayer(var3)) {
      continue;
    }

    if(istrue(level.flagneutralization)) {
      var3 thread scripts\mp\rank::scoreeventpopup("neutralized");
    } else {
      var3 thread scripts\mp\rank::scoreeventpopup("capture");
    }

    var3 thread scripts\mp\awards::givemidmatchaward("mode_dom_neutralized");
    setcrankedtimerdomflag(var3, var3);
    wait 0.05;
  }
}

function giveflagcapturexp(var0, var1, var2) {
  level endon("game_ended");
  var3 = var1;

  if(isDefined(var3.owner)) {
    var3 = var3.owner;
  }

  level.lastcaptime = gettime();
  level.playholdtwovo = 1;

  if(isPlayer(var3)) {
    if(scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "rush") {
      level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition", var3);
    } else {
      level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition" + self.objectivekey, var3);
    }

    var3 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var3.origin);
  }

  if(self.firstcapture == 1) {
    var4 = 1;
  } else {
    var4 = 0;
  }

  if(isDefined(var1)) {
    var5 = getarraykeys(var1);

    for(var6 = 0; var6 < var5.size; var6++) {
      var7 = var1[var5[var6]].player;

      if(isDefined(var7.owner)) {
        var7 = var7.owner;
      }

      if(!isPlayer(var7)) {
        continue;
      }

      setcapturestats(var7);
      givecaptureawards(var7, var4, 0);
      setcrankedtimerdomflag(var7);
      wait 0.05;
    }

    if(isDefined(self.assisttouchlist)) {
      if(self.assisttouchlist[var3].size > 0) {
        var8 = getarraykeys(self.assisttouchlist[var3]);

        foreach(var10 in var5) {
          foreach(var12 in var8) {
            if(var12 == var10) {
              self.assisttouchlist[var3][var12] = undefined;
            }
          }
        }
      }

      if(self.assisttouchlist[var3].size > 0) {
        thread giveflagcaptureassistxp(var3, var4);
        return;
      }

      return;
    }

    return;
  }
}

function giveflagcaptureassistxp(var0, var1) {
  level endon("game_ended");
  var2 = getarraykeys(self.assisttouchlist[var0]);

  if(var2.size > 0) {
    for(var3 = 0; var3 < var2.size; var3++) {
      var4 = self.assisttouchlist[var0][var2[var3]].player;

      if(isDefined(var4.owner)) {
        var4 = var4.owner;
      }

      if(!isPlayer(var4)) {
        continue;
      }

      setcapturestats(var4);
      givecaptureawards(var4, var1, 1);
      setcrankedtimerdomflag(var4);
      self.assisttouchlist[var0][var2[var3]] = undefined;
      wait 0.05;
    }

    return;
  }
}

function givecaptureawards(var0, var1, var2) {
  var3 = 0;
  var4 = "";

  if(var2) {
    var0 thread scripts\mp\rank::scoreeventpopup("capture_assist");
    var4 = "mode_dom_secure_assist";
  } else if(var1) {
    var5 = scripts\mp\utility\game::getgametype() == "arm";
    var6 = !var5 && self.objectivekey == "_b" || var5 && self.objectivekey == "_c";
    var7 = var5 && (self.objectivekey == "_b" || self.objectivekey == "_d");

    if(var6) {
      if(var5) {
        var0 thread scripts\mp\rank::scoreeventpopup("neutral_capture");
        var4 = "mode_arm_secure_mid";
      } else {
        var0 thread scripts\mp\rank::scoreeventpopup("neutral_b_capture");
        var4 = "mode_dom_secure_b";
      }
    } else if(var7) {
      var0 thread scripts\mp\rank::scoreeventpopup("neutral_capture");
      var4 = "mode_arm_secure_outer_mid";
    } else if(var5) {
      var0 thread scripts\mp\rank::scoreeventpopup("neutral_capture");
      var4 = "mode_arm_secure_outer";
    } else {
      var0 thread scripts\mp\rank::scoreeventpopup("neutral_capture");
      var4 = "mode_dom_secure_neutral";
    }
  } else if(istrue(level.flagneutralization)) {
    var0 thread scripts\mp\rank::scoreeventpopup("capture");
    var4 = "mode_dom_neutralized_cap";
  } else {
    var0 thread scripts\mp\rank::scoreeventpopup("capture");
    var4 = "mode_dom_secure";
  }

  var0 thread scripts\mp\awards::givemidmatchaward(var4);

  if(var3) {
    var0 scripts\mp\killstreaks\killstreaks::givestreakpoints("capture", 1, 0);
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

function precap(var0) {
  storecenterflag(var0);
  var1 = [];
  GscBinSkip0(0x2e, var1.size, level.centerflag);
}

function storecenterflag(var0) {
  var1 = undefined;

  foreach(var3 in level.objectives) {
    if(istrue(var0)) {
      if(var3.objectivekey == "_c") {
        level.centerflag = var3;
      }
    }

    if(var3.objectivekey == "_b") {
      level.centerflag = var3;
    }
  }
}

function setflagcaptured(var0, var1, var2, var3) {
  scripts\mp\gameobjects::setownerteam(var0);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
  thread updateflagstate(var0, 0, var0);
  self.capturetime = gettime();
  var4 = scripts\mp\utility\game::getgametype();

  if(var4 == "siege") {
    scripts\mp\gametypes\siege::watchflagenduse(var0);
  }

  if(!isDefined(var3)) {
    if(var1 != "neutral") {
      var5 = getteamflagcount(var0);

      if(var5 == 2) {
        scripts\mp\utility\dialog::statusdialog("friendly_captured_2", var0);
        scripts\mp\utility\dialog::statusdialog("enemy_captured_2", var1);
      } else {
        scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, var0);
        scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, var1);
      }

      level.lastcaptime = gettime();
    }

    if(var4 == "siege") {
      scripts\mp\gametypes\siege::teamrespawn(var0, var2);
    }

    self.firstcapture = 0;
    return;
  }
}

function getteamflagcount(var0) {
  var1 = 0;

  foreach(var3 in level.objectives) {
    if(var3.ownerteam == var0) {
      var1++;
    }
  }

  return var1;
}

function isflagexcluded(var0, var1) {
  var2 = 0;

  if(isarray(var1)) {
    foreach(var4 in var1) {
      if(var0 == var4) {
        var2 = 1;
        break;
      }
    }
  } else if(var0 == var1) {
    var2 = 1;
  }

  return var2;
}

function getunownedflagneareststart(var0, var1) {
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;

  foreach(var6 in level.objectives) {
    if(var6 scripts\mp\gameobjects::getownerteam() != "neutral") {
      continue;
    }

    var7 = distancesquared(var6.trigger.origin, level.startpos[var0]);

    if(isDefined(var1)) {
      if(!isflagexcluded(var6, var1) && (!isDefined(var2) || var7 < var3)) {
        var3 = var7;
        var2 = var6;
      }

      continue;
    }

    if(!isDefined(var2) || var7 < var3) {
      var3 = var7;
      var2 = var6;
    }
  }

  return var2;
}

function awardgenericmedals(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = 0;
  var11 = 0;
  var12 = 0;
  var13 = self;
  var14 = var13.origin;
  var15 = var1.origin;
  var16 = 0;

  if(!isDefined(var1.team) || !isDefined(var13.team)) {
    return;
  }

  if(isDefined(var0)) {
    var15 = var0.origin;
    var16 = var0 == var1;

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      if(istrue(var0.useagents)) {
        return;
      }
    }
  }

  foreach(var18 in level.objectives) {
    if(istrue(var18.trigger.trigger_off)) {
      continue;
    }

    var19 = var18 scripts\mp\gameobjects::getownerteam();
    var20 = var1 istouching(var18.trigger);
    var21 = var13 istouching(var18.trigger);

    if(var20 && var1.team != var19) {
      var1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
      var18 notify("assault", var1);
      var11 = 1;
    }

    if(var19 == "neutral") {
      if(var20 || var21) {
        if(var18.claimteam == var13.team) {
          if(!var11) {
            var11 = 1;
            var1 thread scripts\mp\rank::scoreeventpopup("assault");
            var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
            var18 notify("assault", var1);
            thread scripts\common\utility::ref_13e0a(level.ref_11b26, var9, "assaulting");
            continue;
          }
        } else if(var18.claimteam == var1.team) {
          if(!var12) {
            var12 = 1;
            var1 thread scripts\mp\rank::scoreeventpopup("defend");
            var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
            var18 notify("defend", var1);
            var1 scripts\mp\utility\stats::incpersstat("defends", 1);
            var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
            var1 scripts\mp\utility\stats::setextrascore1(var1.pers["defends"]);
            thread scripts\common\utility::ref_13e0a(level.ref_11b26, var9, "defending");
            continue;
          }
        }
      }

      continue;
    }

    if(var19 != var1.team) {
      if(!var11) {
        var22 = distsquaredcheck(var18.trigger, var15, var14);

        if(var22) {
          var11 = 1;
          var1 thread scripts\mp\rank::scoreeventpopup("assault");
          var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
          var18 notify("assault", var1);
          thread scripts\common\utility::ref_13e0a(level.ref_11b26, var9, "assaulting");
          continue;
        }
      }

      continue;
    }

    if(!var12) {
      var23 = distsquaredcheck(var18.trigger, var15, var14);

      if(var23) {
        var12 = 1;
        var1 thread scripts\mp\rank::scoreeventpopup("defend");
        var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        var18 notify("defend", var1);
        var1 scripts\mp\utility\stats::incpersstat("defends", 1);
        var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
        var1 scripts\mp\utility\stats::setextrascore1(var1.pers["defends"]);
        thread scripts\common\utility::ref_13e0a(level.ref_11b26, var9, "defending");
      }
    }
  }
}

function distsquaredcheck(var0, var1, var2) {
  var3 = distancesquared(var0.origin, var1);
  var4 = distancesquared(var0.origin, var2);

  if(var3 < 105625 || var4 < 105625) {
    if(!isDefined(var0.modifieddefendcheck)) {
      return 1;
    }

    if(var1[2] - var0.origin[2] < 100 || var2[2] - var0.origin[2] < 100) {
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

function ref_12ed1() {
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
  thread ref_144f0();

  for(;;) {
    self.trigger waittill("trigger", var0);

    if(isPlayer(var0)) {
      if(!isDefined(self.ref_1376a)) {
        self.ref_1376a = var0;
        thread ref_144f8(self.flagmodel, var0);
      }
    }

    wait 0.25;
  }
}

function ref_144f8(var0, var1) {
  level endon("game_ended");
  self notify("new_stalker_target");
  self endon("new_stalker_target");

  while(isDefined(self.ref_1376a)) {
    if(!ref_140d6(var0, var1)) {
      self.ref_1376a = undefined;
      self.ref_13769 = 0;
      self.paddedquadgridcenterpoints = undefined;
      self.buildloadoutindices = undefined;
      self.ref_12ac7 = undefined;
      self.flagmodel rotateTo((0, self.flagmodel.angles[1], self.flagmodel.angles[2]), 0.2, 0.1, 0.1);
    } else if(isDefined(self.ref_1376a) && scripts\mp\utility\player::isreallyalive(self.ref_1376a)) {
      if(self.flagmodel.ismoving) {} else {
        self.flagmodel.fwd = anglesToForward(self.flagmodel.angles);
        var2 = self.ref_1376a.origin;
        var3 = self.flagmodel.origin;
        var4 = vectorNormalize(var2 - var3);
        var5 = vectortoangles(var4);
        self.flagmodel rotateTo((0, var5[1], var5[2]), 0.2, 0.1, 0.1);
        self.flagmodel.ismoving = 1;
      }
    }

    wait 0.25;
    self.flagmodel.ismoving = 0;
  }
}

function ref_144f0() {
  self.flagmodel setCanDamage(1);
  self.ref_13769 = 0;

  for(;;) {
    self.flagmodel waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);

    if(isDefined(var1) && isDefined(self.ref_1376a) && self.ref_1376a == var1) {
      self.ref_13769 += var0;
    }

    if(isDefined(self.ref_13769)) {
      if(self.ref_13769 > 100 && !isDefined(self.paddedquadgridcenterpoints)) {
        self.paddedquadgridcenterpoints = 1;
      }

      if(self.ref_13769 > 200 && !isDefined(self.buildloadoutindices)) {
        self.buildloadoutindices = 1;
        playFX(level.spawnoffsettacinsertmax["vanish_hw_en"], self.flagmodel.origin + (0, 0, 80));
      }

      if(self.ref_13769 > 300 && !isDefined(self.ref_12ac7)) {
        self.ref_12ac7 = 1;
        thread ref_12ccd(var1);
      }
    }

    wait 0.25;
  }
}

function ref_12ccd(var0) {
  self.flagmodel moveTo(self.flagmodel.origin + (0, 0, 50), 0.2, 0.1, 0.1);
  wait 0.25;
  self.flagmodel moveTo(self.flagmodel.startorigin, 0.1, 0.05, 0.05);
  wait 0.2;
  self.flagmodel playSound("mp_dom_scarecrow_hw_explo");
  var1 = self.flagmodel.origin + (0, 0, 32);
  playFX(level._effect["cranked_explode"], var1);

  if(isDefined(var0)) {
    var0 dodamage(100, self.flagmodel.origin + (0, 0, 50), var0, self.flagmodel, "MOD_EXPLOSIVE", undefined, "head");
  }

  self.ref_13769 = 0;
  self.paddedquadgridcenterpoints = undefined;
  self.buildloadoutindices = undefined;
  self.ref_12ac7 = undefined;
}

function round_robin_spawners() {
  var0 = self getplayerangles();
  var1 = anglesToForward(var0);
  return var1;
}

function ref_140d6(var0, var1) {
  var2 = 0.05;
  var3 = round_mortars_logic(var1);
  var4 = rocket_fuel_x2(var0);
  var5 = distancesquared(var4, var3);

  if(var5 > 90000) {
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