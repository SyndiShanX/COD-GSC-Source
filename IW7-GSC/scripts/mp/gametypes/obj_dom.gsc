/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_dom.gsc
*********************************************/

func_591D(var_0) {
  var_1 = level.objectives[var_0];
  if(isDefined(var_1.target)) {
    var_2[0] = getent(var_1.target, "targetname");
  } else {
    var_0[0] = spawn("script_model", var_2.origin);
    var_2[0].angles = var_1.angles;
  }

  level.flagcapturetime = scripts\mp\utility::dvarfloatvalue("flagCaptureTime", 10, 0, 30);
  var_3 = scripts\mp\gameobjects::createuseobject("neutral", var_1, var_2, (0, 0, 100));
  var_3 scripts\mp\gameobjects::allowuse("enemy");
  var_3 scripts\mp\gameobjects::cancontestclaim(1);
  var_3 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  var_3 scripts\mp\gameobjects::setusetext(&"MP_SECURING_POSITION");
  var_4 = var_3 scripts\mp\gameobjects::getlabel();
  var_3.label = var_4;
  var_3 scripts\mp\gameobjects::setzonestatusicons(level.icondefend + var_4, level.iconneutral + var_4);
  var_3 scripts\mp\gameobjects::setvisibleteam("any");
  var_3.onuse = ::dompoint_onuse;
  var_3.onbeginuse = ::dompoint_onusebegin;
  var_3.onuseupdate = ::dompoint_onuseupdate;
  var_3.onenduse = ::dompoint_onuseend;
  var_3.oncontested = ::dompoint_oncontested;
  var_3.onuncontested = ::dompoint_onuncontested;
  var_3.nousebar = 1;
  var_3.id = "domFlag";
  var_3.claimgracetime = level.flagcapturetime * 1000;
  var_3.firstcapture = 1;
  var_5 = var_2[0].origin + (0, 0, 32);
  var_6 = var_2[0].origin + (0, 0, -32);
  var_7 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_8 = [];
  var_9 = scripts\common\trace::ray_trace(var_5, var_6, var_8, var_7);
  var_10 = checkmapoffsets(var_3.label);
  var_3.baseeffectpos = var_9["position"] + var_10;
  var_11 = vectortoangles(var_9["normal"]);
  var_12 = checkmapfxangles(var_3.label, var_11);
  var_3.baseeffectforward = anglesToForward(var_12);
  var_13 = spawn("script_model", var_3.baseeffectpos);
  var_13 setModel("dom_flag_scriptable");
  var_13.angles = generateaxisanglesfromforwardvector(var_3.baseeffectforward, var_13.angles);
  var_3.physics_capsulecast = var_13;
  var_3.vfxnamemod = "";
  if(var_3.trigger.fgetarg == 160) {
    var_3.vfxnamemod = "_160";
  } else if(var_3.trigger.fgetarg == 90) {
    var_3.vfxnamemod = "_90";
  }

  var_3 initializematchrecording();
  var_3 scripts\engine\utility::delaythread(1, ::domflag_setneutral);
  return var_3;
}

checkmapoffsets(var_0) {
  var_1 = (0, 0, 0);
  if(level.mapname == "mp_quarry") {
    if(var_0 == "_c") {
      var_1 = var_1 + (0, 0, 7);
    }
  }

  if(level.mapname == "mp_divide") {
    if(var_0 == "_a") {
      var_1 = var_1 + (0, 0, 4.5);
    }
  }

  if(level.mapname == "mp_afghan") {
    if(var_0 == "_a") {
      var_1 = var_1 + (0, 0, 5);
    }

    if(var_0 == "_c") {
      var_1 = var_1 + (0, 0, 1);
    }
  }

  return var_1;
}

checkmapfxangles(var_0, var_1) {
  var_2 = var_1;
  if(level.mapname == "mp_quarry") {
    if(var_0 == "_c") {
      var_2 = (276.5, var_2[1], var_2[2]);
    }
  }

  if(level.mapname == "mp_divide") {
    if(var_0 == "_a") {
      var_2 = (273.5, var_2[1], var_2[2]);
    }
  }

  if(level.mapname == "mp_afghan") {
    if(var_0 == "_a") {
      var_2 = (273.5, 200.5, var_2[2]);
    }

    if(var_0 == "_c") {
      var_2 = (273.5, var_2[1], var_2[2]);
    }
  }

  return var_2;
}

initializematchrecording() {
  if(isDefined(level.matchrecording_logevent)) {
    self.logid = [[level.matchrecording_generateid]]();
    var_0 = "A";
    switch (self.label) {
      case "_a":
        var_0 = "A";
        break;

      case "_b":
        var_0 = "B";
        break;

      case "_c":
        var_0 = "C";
        break;

      default:
        break;
    }

    self.logeventflag = "FLAG_" + var_0;
  }

  if(scripts\mp\analyticslog::analyticslogenabled()) {
    self.analyticslogid = scripts\mp\analyticslog::getuniqueobjectid();
    self.analyticslogtype = "dom_flag" + self.label;
  }
}

domflag_setneutral(var_0) {
  self notify("flag_neutral");
  scripts\mp\gameobjects::setownerteam("neutral");
  scripts\mp\gameobjects::setzonestatusicons(level.iconneutral + self.label);
  updateflagstate("idle", var_0);
  if(isDefined(level.matchrecording_logevent) && isDefined(self.logid) && isDefined(self.logeventflag)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), 0);
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "neutral");
}

dompoint_setcaptured(var_0) {
  scripts\mp\gameobjects::setownerteam(var_0);
  scripts\mp\gameobjects::setzonestatusicons(level.icondefend + self.label, level.iconcapture + self.label);
  self.neutralized = 0;
  updateflagstate(var_0, 0);
  if(isDefined(level.matchrecording_logevent)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), scripts\engine\utility::ter_op(var_0 == "allies", 1, 2));
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + var_0);
}

dompoint_onuse(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  self.capturetime = gettime();
  self.neutralized = 0;
  if(level.flagneutralization) {
    var_3 = scripts\mp\gameobjects::getownerteam();
    if(var_3 == "neutral") {
      dompoint_setcaptured(var_1);
    } else {
      thread domflag_setneutral(1);
      scripts\mp\utility::playsoundonplayers("mp_dom_flag_lost", var_3);
      level.lastcaptime = gettime();
      thread giveflagassistedcapturepoints(self.touchlist[var_1]);
      self.neutralized = 1;
    }
  } else {
    dompoint_setcaptured(var_1);
  }

  if(!self.neutralized) {
    var_4 = 3;
    if(self.label == "_a") {
      var_4 = 1;
    } else if(self.label == "_b") {
      var_4 = 2;
    }

    scripts\mp\utility::setmlgannouncement(19, var_1, var_0 getentitynumber(), var_4);
    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.label, var_0, var_1, var_2, self);
    }

    self.firstcapture = 0;
  }
}

dompoint_onusebegin(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  self.neutralizing = level.flagneutralization && var_1 != "neutral";
  if(!scripts\mp\utility::istrue(self.neutralized)) {
    self.didstatusnotify = 0;
  }

  var_2 = scripts\engine\utility::ter_op(level.flagneutralization, level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(var_2);
  thread scripts\mp\gameobjects::useobjectdecay(var_0.team);
  if(var_2 > 0) {
    self.prevownerteam = level.otherteam[var_0.team];
    updateflagcapturestate(var_0.team);
    scripts\mp\gameobjects::setzonestatusicons(level.iconlosing + self.label, level.icontaking + self.label);
  }
}

dompoint_onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();
  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(var_4 == "neutral") {
      if(level.flagcapturetime > 0.05) {
        scripts\mp\utility::statusdialog("securing" + self.label, var_0);
      }
    } else if(level.flagcapturetime > 0.05) {
      scripts\mp\utility::statusdialog("losing" + self.label, var_4, 1);
      scripts\mp\utility::statusdialog("securing" + self.label, var_0);
    }

    self.didstatusnotify = 1;
  }
}

dompoint_onuseend(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = scripts\mp\gameobjects::getownerteam();
  if(var_3 == "neutral") {
    scripts\mp\gameobjects::setzonestatusicons(level.iconneutral + self.label);
    updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setzonestatusicons(level.icondefend + self.label, level.iconcapture + self.label);
    updateflagstate(var_3, 0);
  }

  if(!var_2) {
    self.neutralized = 0;
  }
}

dompoint_oncontested() {
  scripts\mp\gameobjects::setzonestatusicons(level.iconcontested + self.label);
  updateflagstate("contested", 0);
}

dompoint_onuncontested(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  if(var_0 == "none" || var_1 == "neutral") {
    scripts\mp\gameobjects::setzonestatusicons(level.iconneutral + self.label);
    self.didstatusnotify = 0;
  } else {
    scripts\mp\gameobjects::setzonestatusicons(level.icondefend + self.label, level.iconcapture + self.label);
  }

  var_2 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  updateflagstate(var_2, 0);
}

setcrankedtimerdomflag(var_0) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked) {
    var_0 scripts\mp\utility::setcrankedplayerbombtimer("assist");
  }
}

dompoint_setupflagmodels() {
  game["flagmodels"] = [];
  game["flagmodels"]["neutral"] = "prop_flag_neutral";
  game["flagmodels"]["allies"] = ::scripts\mp\teams::ismeleeing("allies");
  game["flagmodels"]["axis"] = ::scripts\mp\teams::ismeleeing("axis");
}

updateflagstate(var_0, var_1) {
  self.physics_capsulecast setscriptablepartstate("flag", var_0 + self.vfxnamemod);
  if(!scripts\mp\utility::istrue(var_1)) {
    self.physics_capsulecast setscriptablepartstate("pulse", "off");
  }
}

updateflagcapturestate(var_0) {
  self.physics_capsulecast setscriptablepartstate("pulse", var_0 + self.vfxnamemod);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._domflageffect = [];
    var_0._domflagpulseeffect = [];
    var_0 thread ondisconnect();
  }
}

ondisconnect() {
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

giveflagassistedcapturepoints(var_0) {
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

    var_3 thread scripts\mp\awards::givemidmatchaward("mode_dom_neutralized");
    var_3 setclientomnvar("ui_objective_progress", 0.01);
    var_3 setcrankedtimerdomflag(var_3);
    wait(0.05);
  }
}