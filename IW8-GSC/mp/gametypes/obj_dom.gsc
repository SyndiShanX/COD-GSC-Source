/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\obj_dom.gsc
***********************************************/

setupobjective(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_5))
    var_5 = 1;

  if(isDefined(var_0.target)) {
    if(!isDefined(var_0.visuals))
      var_7[0] = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else
      var_7 = var_0.visuals;
  } else {
    var_7[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_7[0].angles = var_0.angles;
  }

  if(!isDefined(level.flagcapturetime))
    level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_AFBB1099B1B0D91AC2C1E8579C598AD25BCA", 10, 0, 30);

  if(isDefined(var_0.objectivekey))
    var_8 = var_0.objectivekey;
  else
    var_8 = var_0.script_label;

  if(isDefined(var_0.iconname))
    var_9 = var_0.iconname;
  else
    var_9 = var_0.script_label;

  if(istrue(var_2))
    var_10 = getreservedobjid(var_8);
  else
    var_10 = undefined;

  if(!isDefined(var_1))
    var_1 = "_encstr_A7A408B9CA5D1D4E2C63";

  var_11 = scripts\mp\gameobjects::createuseobject(var_1, var_0, var_7, (0, 0, 100), var_10, var_3, var_4, var_6);
  var_11 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  var_11 scripts\mp\gameobjects::cancontestclaim(1);
  var_11 scripts\mp\gameobjects::setusetime(level.flagcapturetime);

  if(isDefined(level.capturetype))
    var_11 scripts\mp\gameobjects::setcapturebehavior(getcapturetype());

  var_11.objectivekey = var_8;
  var_11.iconname = var_9;

  if(!istrue(var_3)) {
    var_11 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC", undefined, 1);
    var_11.onuse = ::dompoint_onuse;
    var_11.onbeginuse = ::dompoint_onusebegin;
    var_11.onuseupdate = ::dompoint_onuseupdate;
    var_11.onenduse = ::dompoint_onuseend;
    var_11.oncontested = ::dompoint_oncontested;
    var_11.onuncontested = ::dompoint_onuncontested;
    var_11.onunoccupied = ::dompoint_onunoccupied;
    var_11.onpinnedstate = ::dompoint_onpinnedstate;
    var_11.onunpinnedstate = ::dompoint_onunpinnedstate;
    var_11.stompprogressreward = ::dompoint_stompprogressreward;
  }

  var_11.nousebar = 1;
  var_11.id = "_encstr_87D9083A6F628DDB5F1F";
  var_11.claimgracetime = level.flagcapturetime * 1000;
  var_11.firstcapture = 1;
  var_11 scripts\mp\gameobjects::pinobjiconontriggertouch();

  if(istrue(level.playinggulagbink))
    var_11._id_136CD = ::_id_136CE;
  else if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    var_11._id_136CD = ::_id_136CF;

  var_12 = var_7[0].origin + (0, 0, 32);
  var_13 = var_7[0].origin + (0, 0, -32);
  var_14 = scripts\engine\trace::create_contents(var_5, 1, 1, 1, 0, 1, 1);
  var_15 = [];
  var_16 = scripts\engine\trace::ray_trace(var_12, var_13, var_15, var_14);
  var_17 = checkmapoffsets(var_11);
  var_11.baseeffectpos = var_16["_encstr_BD260953AA97E3F014279D"] + var_17;
  var_18 = vectortoangles(var_16["_encstr_820E07FAE8780B3A4C"]);
  var_19 = checkmapfxangles(var_11, var_18);
  var_11.baseeffectforward = anglesToForward(var_19);
  var_20 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_11.baseeffectpos);
  var_20 setModel("_encstr_8B501446DED6F5CC361676BEB96C4E5AE08EB031B159");
  var_20.angles = generateaxisanglesfromforwardvector(var_11.baseeffectforward, var_20.angles);
  var_11.scriptable = var_20;
  var_11.vfxnamemod = "_encstr_B40101";
  var_11.noscriptable = 1;

  if(istrue(level.multiteambased))
    var_11.noscriptable = 1;

  var_11.flagmodel = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_11.baseeffectpos);

  if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    var_21 = "_encstr_AFD41A34359BC76B019B6F1992B0E8B7C5E81957C6B02E25CF5E7B4B";
    var_11.flagmodel.useagents = 1;
  } else
    var_21 = "_encstr_887E1AD64BB1A51D0B2797F519BDD6EB66B1B09DF5B9CAD5D139C2C6";

  var_11.flagmodel setModel(var_21);
  var_11.flagmodel.angles = getlivingplayersonteam(var_11);
  var_11.outlineent = var_11.flagmodel;

  if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    var_11 thread setplayermostwantedextrainfo();
    var_11 thread markdistanceoverride();
  }

  var_11 initializematchrecording();

  if(!istrue(var_3))
    var_11 domflag_setneutral(undefined, 1);

  return var_11;
}

removeobjective(var_0) {
  if(isDefined(var_0.flagmodel))
    var_0.flagmodel delete();

  if(isDefined(var_0.scriptable))
    var_0.scriptable delete();

  var_0 scripts\mp\gameobjects::deleteuseobject();
}

getreservedobjid(var_0) {
  if(var_0 == "_encstr_B20703DFCF")
    var_1 = 0;
  else if(var_0 == "_encstr_B40703E96D")
    var_1 = 1;
  else if(var_0 == "_encstr_A2070318DC")
    var_1 = 3;
  else if(var_0 == "_encstr_950703EBCA")
    var_1 = 4;
  else
    var_1 = 2;

  return var_1;
}

getcapturetype() {
  var_0 = "_encstr_820E07FAE8780B3A4C";

  if(level.capturetype == 2)
    var_0 = "_encstr_A10F0BD0F2FB41E337D40BFAB5";
  else if(level.capturetype == 3)
    var_0 = "_encstr_92FC0B5BB01A6B73D09459526B";

  return var_0;
}

getlivingplayersonteam(var_0) {
  var_1 = var_0.objectivekey;
  var_2 = (0, 0, 0);

  if(level.mapname == "_encstr_992B0BABB3814370F29F80B983") {
    if(var_1 == "_encstr_B40703E96D")
      var_2 = (0, 110, 0);
  }

  return var_2;
}

checkmapoffsets(var_0) {
  var_1 = var_0.objectivekey;
  var_2 = (0, 0, 0);

  if(level.mapname == "_encstr_91B90AB6E0D78B5D589327E5") {
    if(var_1 == "_encstr_B6070359BA")
      var_2 = var_2 + (0, 0, 7);
  }

  if(level.mapname == "_encstr_96C70AB7F9A03CC33324F4EA") {
    if(var_1 == "_encstr_B20703DFCF")
      var_2 = var_2 + (0, 0, 4.5);
  }

  if(level.mapname == "_encstr_BEDB0A7D1F973A56D978C7F3") {
    if(var_1 == "_encstr_B20703DFCF")
      var_2 = var_2 + (0, 0, 5);

    if(var_1 == "_encstr_B6070359BA")
      var_2 = var_2 + (0, 0, 1);
  }

  return var_2;
}

checkmapfxangles(var_0, var_1) {
  var_2 = var_0.objectivekey;
  var_3 = var_1;

  if(level.mapname == "_encstr_91B90AB6E0D78B5D589327E5") {
    if(var_2 == "_encstr_B6070359BA")
      var_3 = (276.5, var_3[1], var_3[2]);
  }

  if(level.mapname == "_encstr_96C70AB7F9A03CC33324F4EA") {
    if(var_2 == "_encstr_B20703DFCF")
      var_3 = (273.5, var_3[1], var_3[2]);
  }

  if(level.mapname == "_encstr_BEDB0A7D1F973A56D978C7F3") {
    if(var_2 == "_encstr_B20703DFCF")
      var_3 = (273.5, 200.5, var_3[2]);

    if(var_2 == "_encstr_B6070359BA")
      var_3 = (273.5, var_3[1], var_3[2]);
  }

  if(level.mapname == "_encstr_86C80BFFA9E82221A818377E10") {
    if(isstring(var_2)) {
      if(var_2 == "_encstr_B24B085FB84940DAEF01")
        var_3 = (270, 0, 0);
      else if(var_2 == "_encstr_BA400B4FB421C35FD180A3DBC8")
        var_3 = (270, 0, 0);
    }
  }

  return var_3;
}

initializematchrecording() {
  if(isDefined(level.matchrecording_logevent)) {
    self.logid = [[level.matchrecording_generateid]]();
    var_0 = "_encstr_994C0238";

    switch (self.objectivekey) {
      case "_encstr_B20703DFCF":
        var_0 = "_encstr_994C0238";
        break;
      case "_encstr_B40703E96D":
        var_0 = "_encstr_8B4C0248";
        break;
      case "_encstr_B6070359BA":
        var_0 = "_encstr_834C02D0";
        break;
      case "_encstr_A2070318DC":
        var_0 = "_encstr_A14C02D5";
        break;
      case "_encstr_950703EBCA":
        var_0 = "_encstr_934C02A2";
        break;
      case "_encstr_934C0218":
        var_0 = "_encstr_934C0218";
        break;
      case "_encstr_A34C02BB":
        var_0 = "_encstr_A34C02BB";
        break;
      case "_encstr_A74C0222":
        var_0 = "_encstr_A74C0222";
        break;
      case "_encstr_A14C023B":
        var_0 = "_encstr_A14C023B";
        break;
      case "_encstr_AC4C024A":
        var_0 = "_encstr_AC4C024A";
        break;
      default:
        break;
    }

    self.logeventflag = "_encstr_8EA906B574660980" + var_0;
  }

  if(scripts\mp\analyticslog::analyticslogenabled()) {
    self.analyticslogid = scripts\mp\analyticslog::getuniqueobjectid();
    self.analyticslogtype = "_encstr_9A2409C87BD6F5CC1B2C76" + self.objectivekey;
  }
}

domflag_setneutral(var_0, var_1) {
  self notify("_encstr_BA4A0DE659885FF7B839CBE3E30773");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral, undefined, undefined, undefined, 1);
  scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
  thread updateflagstate("_encstr_A7C5056BD931D1", istrue(var_0), undefined, var_1);

  if(isDefined(level.matchrecording_logevent) && isDefined(self.logid) && isDefined(self.logeventflag))
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), 0);

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "_encstr_A7A408B9CA5D1D4E2C63");
}

dompoint_setcaptured(var_0, var_1) {
  scripts\mp\gameobjects::setownerteam(var_0);
  self notify("_encstr_95EB0866891B23FB85B3", var_1);
  self notify("_encstr_AB3508737F830710ACDB", var_1);

  if(istrue(level.numflagsscoreonkill)) {
    var_2 = getteamflagcount(var_0);

    if(var_2 >= level.numflagsscoreonkill)
      level.teamscoresonkill[var_0] = 1;
    else
      level.teamscoresonkill[var_0] = 0;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5")
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(self.ownerteam, 15, 14);

  self.neutralized = 0;
  thread updateflagstate(var_0, 0, var_0);

  if(self.touchlist[var_0].size == 0 && isDefined(self.oldtouchlist))
    self.touchlist = self.oldtouchlist;

  foreach(var_4 in level.teamnamelist) {
    if(isDefined(self.assisttouchlist[var_4]) && var_4 != var_0)
      self.assisttouchlist[var_4] = [];
  }

  if(isDefined(self.assisttouchlist[var_0])) {
    var_6 = getarraykeys(self.assisttouchlist[var_0]);

    foreach(var_8 in var_6) {
      var_9 = self.assisttouchlist[var_0][var_8].player;

      if(isDefined(var_9.owner))
        var_9 = var_9.owner;

      if(!isPlayer(var_9)) {
        continue;
      }
      var_9 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
    }
  }

  thread giveflagcapturexp(self.touchlist[var_0], var_1, var_0);

  if(isDefined(level.matchrecording_logevent))
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), scripts\engine\utility::ter_op(var_0 == "_encstr_9A8507BA4040188D08", 1, 2));

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "_encstr_AD260A8AFAF7FBA3658762C6" + var_0);
}

dompoint_onuse(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;

  if(istrue(level.flagneutralization)) {
    var_3 = scripts\mp\gameobjects::getownerteam();

    if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
      dompoint_setcaptured(var_1, var_0);

      if(isDefined(self._id_136CD))
        [[self._id_136CD]]();
    } else {
      thread domflag_setneutral(1);
      scripts\mp\utility\sound::playsoundonplayers("_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", var_3);
      level.lastcaptime = gettime();
      thread giveflagassistedcapturepoints(self.touchlist[var_1]);
      self.neutralized = 1;
    }
  } else {
    dompoint_setcaptured(var_1, var_0);

    if(isDefined(self._id_136CD))
      [[self._id_136CD]]();
  }

  if(!self.neutralized) {
    var_4 = 3;

    if(self.objectivekey == "_encstr_B20703DFCF")
      var_4 = 1;
    else if(self.objectivekey == "_encstr_B40703E96D")
      var_4 = 2;
    else if(self.objectivekey == "_encstr_A2070318DC")
      var_4 = 4;
    else if(self.objectivekey == "_encstr_950703EBCA")
      var_4 = 5;

    scripts\mp\utility\game::setmlgannouncement(21, var_1, var_0 getentitynumber(), var_4);

    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("_encstr_ABED0902389B228718185C", self.objectivekey, var_0, var_1, var_2, self);
      var_5 = "_encstr_B6A906918DB0CE01" + resetchemicalvalvevalues() + "_encstr_96E10AEF3082190B2B93F768";

      if(var_2 == "_encstr_A7A408B9CA5D1D4E2C63" || var_2 == "_encstr_8BBA05185F8B99")
        scripts\mp\utility\game::_id_119AC(var_0, undefined, var_5, var_0.origin, "_encstr_879D0D556160BCE30F61CF337927FA");
      else
        scripts\mp\utility\game::_id_119AC(var_0, undefined, var_5, var_0.origin);
    }
  }

  self.firstcapture = 0;
}

dompoint_onusebegin(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  self.neutralizing = istrue(level.flagneutralization) && var_1 != "_encstr_A7A408B9CA5D1D4E2C63";

  if(self.neutralizing) {
    if(var_1 != var_0.team)
      var_2 = relic_nuketimer_timerloop();
    else
      var_2 = 0;
  } else if(var_1 != var_0.team)
    var_2 = 1;
  else
    var_2 = 0;

  var_0 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", var_2);

  if(!isDefined(self.statusnotifytime))
    self.statusnotifytime = gettime();

  if(!istrue(self.neutralized) && self.statusnotifytime > self.statusnotifytime + 5000) {
    self.didstatusnotify = 0;
    self.statusnotifytime = gettime();
  }

  var_3 = scripts\engine\utility::ter_op(istrue(level.flagneutralization) && !self.firstcapture, level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(var_3);

  if(var_3 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var_0.team)[0];
    updateflagcapturestate(var_0.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
  }

  if(istrue(level.hideenemyfobs)) {
    if(var_0.team != var_1)
      scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  }
}

dompoint_onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_1 < 1.0 && !level.gameended && !scripts\mp\utility\game::isanymlgmatch())
    play_dom_capture_sfx(var_1, var_0);

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(var_4 == "_encstr_A7A408B9CA5D1D4E2C63") {
      if(level.flagcapturetime > 0.05) {
        scripts\mp\utility\dialog::statusdialog("_encstr_823109E62B1BAB27D2B93B" + self.objectivekey, var_0);

        if(isDefined(level.objectives) && level.objectives.size == 5 && (self.objectivekey == "_encstr_B6070359BA" || self.objectivekey == "_encstr_A2070318DC") || self.objectivekey == "_encstr_B40703E96D") {
          var_5 = scripts\mp\utility\game::getotherteam(var_0)[0];
          scripts\mp\utility\dialog::statusdialog("_encstr_8267076C10DBE8B6E0" + self.objectivekey, var_5);
        }
      }
    } else if(level.flagcapturetime > 0.05) {
      scripts\mp\utility\dialog::statusdialog("_encstr_8267076C10DBE8B6E0" + self.objectivekey, var_4);
      scripts\mp\utility\dialog::statusdialog("_encstr_823109E62B1BAB27D2B93B" + self.objectivekey, var_0);
    }

    self.didstatusnotify = 1;
  }
}

dompoint_onuseend(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    var_1 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    thread updateflagstate("_encstr_A7C5056BD931D1", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    thread updateflagstate(var_3, 0);
  }

  if(!var_2)
    self.neutralized = 0;
}

dompoint_oncontested() {
  self.hostvictimoverride = gettime();
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread updateflagstate("_encstr_B85C0AD87B9B8E95CD8E2B46", 0);
}

dompoint_onuncontested(var_0) {
  if(istrue(level.flagneutralization) && !self.firstcapture)
    scripts\mp\gameobjects::setusetime(level.flagcapturetime * 0.5);

  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_1 == "_encstr_A7A408B9CA5D1D4E2C63") {
    if(var_0 != "_encstr_8BBA05185F8B99")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
    else if(isDefined(self.lastprogressteam))
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, self.lastprogressteam);
  } else
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(var_1)[0]);

  if(var_0 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  var_2 = (gettime() - self.hostvictimoverride) * 0.001;
  var_3 = "_encstr_B6A906918DB0CE01" + resetchemicalvalvevalues() + "_encstr_835E0B91866F9AA19213835F22";
  scripts\mp\utility\game::_id_119AC(undefined, undefined, var_3, undefined, var_2 + "_encstr_8B6909873A3DC1109D8AA6");
  self.hostvictimoverride = undefined;
  var_4 = scripts\engine\utility::ter_op(var_1 == "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A7C5056BD931D1", var_1);
  thread updateflagstate(var_4, 0);
}

play_dom_capture_sfx(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "_encstr_B40101";
    var_0 = int(floor(var_0 * 10));
    var_2 = "_encstr_856B180A5867CF6F6068A3D9972B4F12537312A1E0E3C6A71EC7" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
  }
}

dompoint_onunoccupied() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  self.didstatusnotify = 0;
}

dompoint_onpinnedstate(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

dompoint_onunpinnedstate(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && !self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

dompoint_stompprogressreward(var_0) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8E84100AE82D2133A3508787FD6923F77DB0");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

setcrankedtimerdomflag(var_0) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked)
    var_0 scripts\mp\cranked::setcrankedplayerbombtimer("_encstr_A1BD075837DCD29B47");
}

_id_136CE() {
  var_0 = 20;
  var_1 = 600;
  var_2 = self.flagmodel.origin;
  var_3 = var_2 + (0, 0, var_0);
  var_4 = var_2 + (0, 0, var_1);
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var_6 = [];
  var_6 = level.players;
  var_6[var_6.size] = self.flagmodel;
  var_7 = scripts\engine\trace::ray_trace(var_3, var_4, var_6, var_5, 0);

  if(isPlayer(var_7["_encstr_850E077B0BF30318B9"]))
    var_7["_encstr_850E077B0BF30318B9"] = undefined;

  if(isDefined(var_7["_encstr_850E077B0BF30318B9"]) && isDefined(var_7["_encstr_850E077B0BF30318B9"].code_classname) && var_7["_encstr_850E077B0BF30318B9"].code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    var_6[var_6.size] = var_7["_encstr_850E077B0BF30318B9"];
    var_7 = scripts\engine\trace::ray_trace(var_3, var_4, var_6, var_5, 0);
  }

  if(var_7["_encstr_A53009A25003666B9818C6"] != 1) {
    var_0 = 4000;
    var_1 = 20;
    var_2 = self.flagmodel.origin;
    var_3 = var_2 + (0, 0, var_0);
    var_4 = var_2 + (0, 0, var_1);
    var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
    var_6 = [];
    var_6 = level.players;
    var_6[var_6.size] = self.flagmodel;
    var_7 = scripts\engine\trace::ray_trace(var_3, var_4, var_6, var_5, 0);

    if(isPlayer(var_7["_encstr_850E077B0BF30318B9"]))
      var_7["_encstr_850E077B0BF30318B9"] = undefined;

    if(isDefined(var_7["_encstr_850E077B0BF30318B9"]) && isDefined(var_7["_encstr_850E077B0BF30318B9"].code_classname) && var_7["_encstr_850E077B0BF30318B9"].code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      var_6[var_6.size] = var_7["_encstr_850E077B0BF30318B9"];
      var_7 = scripts\engine\trace::ray_trace(var_3, var_4, var_6, var_5, 0);
    }

    if(var_7["_encstr_A53009A25003666B9818C6"] != 1) {
      playFX(level.select_stairway_spawners["_encstr_BDBA0E76F6CDF5CC96C9ACDDED4EB59B"], var_7["_encstr_BD260953AA97E3F014279D"]);
      playFX(level.select_stairway_spawners["_encstr_BDBA0E76F6CDF5CC96C9ACDDED4EB59B"], var_7["_encstr_BD260953AA97E3F014279D"], anglesToForward(self.flagmodel.angles) + (-10, -10, 0));
      playFX(level.select_stairway_spawners["_encstr_BDBA0E76F6CDF5CC96C9ACDDED4EB59B"], var_7["_encstr_BD260953AA97E3F014279D"], anglesToForward(self.flagmodel.angles) + (10, 10, 0));
      level thread _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::_id_14397(var_7["_encstr_BD260953AA97E3F014279D"]);
    }
  } else {
    playFX(level.select_stairway_spawners["_encstr_BDBA0E76F6CDF5CC96C9ACDDED4EB59B"], var_2);
    playFX(level.select_stairway_spawners["_encstr_BDBA0E76F6CDF5CC96C9ACDDED4EB59B"], var_2, anglesToForward(self.flagmodel.angles) + (-10, -10, 0));
    playFX(level.select_stairway_spawners["_encstr_BDBA0E76F6CDF5CC96C9ACDDED4EB59B"], var_2, anglesToForward(self.flagmodel.angles) + (10, 10, 0));
    level thread _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::_id_14397(var_2);
  }
}

_id_136CF() {
  if(isDefined(self.spawnpoint_clearspawnpoint))
    return;
  else {
    self.spawnpoint_clearspawnpoint = 1;
    var_0 = 20;
    var_1 = 600;

    if(level.mapname == "_encstr_A2200CDA13D6CBC897E1A0EBAA93")
      var_1 = 400;

    var_2 = self.flagmodel.origin;
    var_3 = var_2 + (0, 0, var_0);
    var_4 = var_2 + (0, 0, var_1);
    var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
    var_6 = [];
    var_6 = level.players;
    var_6[var_6.size] = self.flagmodel;
    var_7 = scripts\engine\trace::ray_trace(var_3, var_4, var_6, var_5, 0);

    if(isPlayer(var_7["_encstr_850E077B0BF30318B9"]))
      var_7["_encstr_850E077B0BF30318B9"] = undefined;

    if(isDefined(var_7["_encstr_850E077B0BF30318B9"]) && isDefined(var_7["_encstr_850E077B0BF30318B9"].code_classname) && var_7["_encstr_850E077B0BF30318B9"].code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      var_6[var_6.size] = var_7["_encstr_850E077B0BF30318B9"];
      var_7 = scripts\engine\trace::ray_trace(var_3, var_4, var_6, var_5, 0);
    }

    if(var_7["_encstr_A53009A25003666B9818C6"] != 1)
      playFX(level.spawnoffsettacinsertmax["_encstr_85170EB291A2077991B9F3B7F597C8E3"], var_7["_encstr_BD260953AA97E3F014279D"] - (0, 0, 5), (-180, -180, 0), (-180, -180, -180));

    playFX(level.spawnoffsettacinsertmax["_encstr_B8A50F48057D083AF8E073F74820B7A3D0"], self.flagmodel.origin + (0, 0, 2));
    var_0 = 4000;
    var_1 = 20;
    var_2 = self.flagmodel.origin;
    var_3 = var_2 + (0, 0, var_0);
    var_4 = var_2 + (0, 0, var_1);
    var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
    var_6 = [];
    var_6 = level.players;
    var_6[var_6.size] = self.flagmodel;
    var_7 = scripts\engine\trace::ray_trace(var_3, var_4, var_6, var_5, 0);

    if(isPlayer(var_7["_encstr_850E077B0BF30318B9"]))
      var_7["_encstr_850E077B0BF30318B9"] = undefined;

    if(isDefined(var_7["_encstr_850E077B0BF30318B9"]) && isDefined(var_7["_encstr_850E077B0BF30318B9"].code_classname) && var_7["_encstr_850E077B0BF30318B9"].code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      var_6[var_6.size] = var_7["_encstr_850E077B0BF30318B9"];
      var_7 = scripts\engine\trace::ray_trace(var_3, var_4, var_6, var_5, 0);
    }

    if(var_7["_encstr_A53009A25003666B9818C6"] != 1)
      playFX(level.spawnoffsettacinsertmax["_encstr_B2190CC4C21D6EAF99C697D743DD"], var_7["_encstr_BD260953AA97E3F014279D"] + (0, 0, 50));
    else
      playFX(level.spawnoffsettacinsertmax["_encstr_B2190CC4C21D6EAF99C697D743DD"], self.flagmodel.origin + (0, 0, 50));
  }
}

setplayermostwantedextrainfo() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = 4000;
  var_1 = 20;
  var_2 = self.flagmodel.origin;
  var_3 = var_2 + (0, 0, var_0);
  var_4 = var_2 + (0, 0, var_1);
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var_6 = [];
  var_6 = level.players;
  var_6[var_6.size] = self.flagmodel;
  var_7 = scripts\engine\trace::ray_trace(var_3, var_4, var_6, var_5, 0);

  if(isPlayer(var_7["_encstr_850E077B0BF30318B9"]))
    var_7["_encstr_850E077B0BF30318B9"] = undefined;

  if(isDefined(var_7["_encstr_850E077B0BF30318B9"]) && isDefined(var_7["_encstr_850E077B0BF30318B9"].code_classname) && var_7["_encstr_850E077B0BF30318B9"].code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    var_6[var_6.size] = var_7["_encstr_850E077B0BF30318B9"];
    var_7 = scripts\engine\trace::ray_trace(var_3, var_4, var_6, var_5, 0);
  }

  if(var_7["_encstr_A53009A25003666B9818C6"] != 1)
    playFX(level.spawnoffsettacinsertmax["_encstr_8C08081ABBD8A2FFB363"], var_7["_encstr_BD260953AA97E3F014279D"]);
  else
    playFX(level.spawnoffsettacinsertmax["_encstr_8C08081ABBD8A2FFB363"], self.flagmodel.origin + (0, 0, 200));
}

dompoint_setupflagmodels() {
  game["_encstr_AFA40BA9301751A81D779A83DA"] = [];
  game["_encstr_AFA40BA9301751A81D779A83DA"]["_encstr_A7A408B9CA5D1D4E2C63"] = "_encstr_8BFA128B6BD08309FEA84F3F61F02B4BF84E3729";
}

updateflagstate(var_0, var_1, var_2, var_3) {
  self notify("_encstr_97C9101BAADCB08592D3091B7FD9CD086447");
  self endon("_encstr_97C9101BAADCB08592D3091B7FD9CD086447");

  if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    if(istrue(var_3))
      self.flagmodel.angles = self.flagmodel.angles + (90, 0, 0);
    else if(isDefined(var_2) && self.firstcapture && scripts\mp\utility\game::getgametype() != "_encstr_A9B606B0C956B916")
      self.flagmodel thread _id_12ED1();
    else if(isDefined(var_2))
      playFX(level.spawnoffsettacinsertmax["_encstr_8C930DA4C67A4BFBF8F7C0C00F0E13"], self.flagmodel.origin + (0, 0, 60));
  } else if(isDefined(var_2)) {
    if(var_2 == "_encstr_9A8507BA4040188D08")
      self.flagmodel setModel("_encstr_B6051709E47A6B3BD163686103E7D0CF024DF784F163CB83AC");
    else if(var_2 == "_encstr_8E8405EA382B2A")
      self.flagmodel setModel("_encstr_9770176B2DB14B3AB0C92FEB19EDB6AF9936C29DFAB216DC47");
    else
      self.flagmodel setModel("_encstr_887E1AD64BB1A51D0B2797F519BDD6EB66B1B09DF5B9CAD5D139C2C6");
  }

  if(isDefined(self.noscriptable)) {
    return;
  }
  while(!isDefined(self.scriptable))
    waitframe();

  if(scripts\mp\utility\game::getgametype() == "_encstr_A10C0780F23F6F400B") {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") {
    return;
  }
  if(isDefined(self.scriptable)) {
    if(var_0 == "_encstr_BA19049F4B2D")
      setdomscriptablepartstate("_encstr_8F7905C4EDE23F", var_0);
    else
      setdomscriptablepartstate("_encstr_8F7905C4EDE23F", var_0, self.vfxnamemod);

    if(!istrue(var_1))
      setdomscriptablepartstate("_encstr_8A0C06B1E08832D3", "_encstr_BA19049F4B2D");
  }
}

setdomscriptablepartstate(var_0, var_1, var_2) {
  if(!isDefined(self.scriptable)) {
    return;
  }
  if(isDefined(level.setdomscriptablepartstatefunc)) {
    if([[level.setdomscriptablepartstatefunc]](var_0, var_1, var_2))
      return;
  }

  if(isDefined(var_2))
    var_1 = var_1 + var_2;

  self.scriptable setscriptablepartstate(var_0, var_1);
}

updateflagcapturestate(var_0) {
  if(isDefined(self.noscriptable)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() != "_encstr_B81904B04E6B" && scripts\mp\utility\game::getgametype() != "_encstr_A10C0780F23F6F400B") {
    if(isDefined(self.scriptable))
      setdomscriptablepartstate("_encstr_8A0C06B1E08832D3", var_0, self.vfxnamemod);
  }
}

ondisconnect() {
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  foreach(var_1 in self._domflageffect) {
    if(isDefined(var_1))
      var_1 delete();
  }

  foreach(var_4 in self._domflagpulseeffect) {
    if(isDefined(var_4))
      var_4 delete();
  }
}

giveflagassistedcapturepoints(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_0[var_1[var_2]].player;

    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3.owner))
      var_3 = var_3.owner;

    if(!isPlayer(var_3)) {
      continue;
    }
    if(istrue(level.flagneutralization))
      var_3 thread scripts\mp\rank::scoreeventpopup("_encstr_87F90C9BCABA8EE40BB14B3D2B91");
    else
      var_3 thread scripts\mp\rank::scoreeventpopup("_encstr_95EB0866891B23FB85B3");

    var_3 thread scripts\mp\awards::givemidmatchaward("_encstr_A13A15AFFA4B1AB7B09DF8681EB7254BEBAFA8A3D2D8E2");
    var_3 setcrankedtimerdomflag(var_3);
    wait 0.05;
  }
}

giveflagcapturexp(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = var_1;

  if(isDefined(var_3.owner))
    var_3 = var_3.owner;

  level.lastcaptime = gettime();
  level.playholdtwovo = 1;

  if(isPlayer(var_3)) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_9719046E3182" || scripts\mp\utility\game::getgametype() == "_encstr_A61F054B28EBE0")
      level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_B6C51896FF899237F3C017BF50E9E5BB6385DA0D5E2B4B49D838", var_3);
    else
      level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_B6C51896FF899237F3C017BF50E9E5BB6385DA0D5E2B4B49D838" + self.objectivekey, var_3);

    var_3 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_95EB0866891B23FB85B3", var_3.origin);
  }

  if(self.firstcapture == 1)
    var_4 = 1;
  else
    var_4 = 0;

  if(isDefined(var_0)) {
    var_5 = getarraykeys(var_0);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_7 = var_0[var_5[var_6]].player;

      if(isDefined(var_7.owner))
        var_7 = var_7.owner;

      if(!isPlayer(var_7)) {
        continue;
      }
      var_7 setcapturestats();
      givecaptureawards(var_7, var_4, 0);
      setcrankedtimerdomflag(var_7);
      wait 0.05;
    }

    if(isDefined(self.assisttouchlist)) {
      if(self.assisttouchlist[var_2].size > 0) {
        var_8 = getarraykeys(self.assisttouchlist[var_2]);

        foreach(var_10 in var_5) {
          foreach(var_12 in var_8) {
            if(var_12 == var_10)
              self.assisttouchlist[var_2][var_12] = undefined;
          }
        }
      }

      if(self.assisttouchlist[var_2].size > 0)
        thread giveflagcaptureassistxp(var_2, var_4);
    }
  }
}

giveflagcaptureassistxp(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = getarraykeys(self.assisttouchlist[var_0]);

  if(var_2.size > 0) {
    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = self.assisttouchlist[var_0][var_2[var_3]].player;

      if(isDefined(var_4.owner))
        var_4 = var_4.owner;

      if(!isPlayer(var_4)) {
        continue;
      }
      var_4 setcapturestats();
      givecaptureawards(var_4, var_1, 1);
      setcrankedtimerdomflag(var_4);
      self.assisttouchlist[var_0][var_2[var_3]] = undefined;
      wait 0.05;
    }
  }
}

givecaptureawards(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = "_encstr_B40101";

  if(var_2) {
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_96E10F4E1293111B5BCF794043AB0C0FFB");
    var_4 = "_encstr_A57E172DC0B12ADF09F027E73801DB93356D39A6B6C7A23BD3";
  } else if(var_1) {
    var_5 = scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B";
    var_6 = !var_5 && self.objectivekey == "_encstr_B40703E96D" || var_5 && self.objectivekey == "_encstr_B6070359BA";
    var_7 = var_5 && (self.objectivekey == "_encstr_B40703E96D" || self.objectivekey == "_encstr_A2070318DC");

    if(var_6) {
      if(var_5) {
        var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_A154109BCA5D1D9C0B63D76C2C83E85D9356");
        var_4 = "_encstr_9617146A508D5711C035B5BF0FD826DF2E89C1927855";
      } else {
        var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_8CF312E80FED1B759A9DD046B9529B4334E7B038");
        var_4 = "_encstr_A958125B7B91ACD723F6B5F5CDCAD8AB93B2D726";
      }
    } else if(var_7) {
      var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_A154109BCA5D1D9C0B63D76C2C83E85D9356");
      var_4 = "_encstr_91501A421FBB7599A98B1A07F8373BFB2DC898B70345414ECFE058B2";
    } else if(var_5) {
      var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_A154109BCA5D1D9C0B63D76C2C83E85D9356");
      var_4 = "_encstr_B46216FA50E17F5F312E7D574659678335E8415238693793";
    } else {
      var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_A154109BCA5D1D9C0B63D76C2C83E85D9356");
      var_4 = "_encstr_887F18D67B9195D723F6D6F5DC9536AE2795AFB956D5E8C98536";
    }
  } else if(istrue(level.flagneutralization)) {
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_95EB0866891B23FB85B3");
    var_4 = "_encstr_821719ADED8CB27D32DBADAFB9565D8E9C0BB1A5F4CA32AF36C21C";
  } else {
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_95EB0866891B23FB85B3");
    var_4 = "_encstr_83A2106BF6C8B2EB237B6BD7CDCAB1ABE42B";
  }

  var_0 thread scripts\mp\awards::givemidmatchaward(var_4);

  if(var_3)
    var_0 scripts\mp\killstreaks\killstreaks::givestreakpoints("_encstr_95EB0866891B23FB85B3", 1, 0);
}

setcapturestats() {
  scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);

  if(isDefined(self.pers["_encstr_81CF0936850ED1D54EACCD"])) {
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", self.pers["_encstr_81CF0936850ED1D54EACCD"]);

    if(scripts\mp\utility\game::getgametype() != "_encstr_A9B606B0C956B916")
      scripts\mp\utility\stats::setextrascore0(self.pers["_encstr_81CF0936850ED1D54EACCD"]);
  }
}

precap(var_0) {
  storecenterflag(var_0);
  var_1 = [];
  var_1[var_1.size] = level.centerflag;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    level.closestalliesflag = getunownedflagneareststart("_encstr_8E8405EA382B2A", level.centerflag);
    var_1[var_1.size] = level.closestalliesflag;
    level.closestaxisflag = getunownedflagneareststart("_encstr_9A8507BA4040188D08", var_1);
  } else {
    level.closestalliesflag = getunownedflagneareststart("_encstr_9A8507BA4040188D08", level.centerflag);
    var_1[var_1.size] = level.closestalliesflag;
    level.closestaxisflag = getunownedflagneareststart("_encstr_8E8405EA382B2A", var_1);
  }

  level.closestalliesflag setflagcaptured("_encstr_9A8507BA4040188D08", "_encstr_A7A408B9CA5D1D4E2C63", undefined, 1);
  level.closestaxisflag setflagcaptured("_encstr_8E8405EA382B2A", "_encstr_A7A408B9CA5D1D4E2C63", undefined, 1);
}

storecenterflag(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.objectives) {
    if(istrue(var_0)) {
      if(var_3.objectivekey == "_encstr_B6070359BA")
        level.centerflag = var_3;
    }

    if(var_3.objectivekey == "_encstr_B40703E96D")
      level.centerflag = var_3;
  }
}

setflagcaptured(var_0, var_1, var_2, var_3) {
  scripts\mp\gameobjects::setownerteam(var_0);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
  thread updateflagstate(var_0, 0, var_0);
  self.capturetime = gettime();
  var_4 = scripts\mp\utility\game::getgametype();

  if(var_4 == "_encstr_A54F06D32A2F0498")
    _encstr_B2161FB9C627B4C18EE6E5B6E0793BB0B6B28E5E382BCDBCDCD2CA76598BB3B98D::watchflagenduse(var_0);

  if(!isDefined(var_3)) {
    if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63") {
      var_5 = getteamflagcount(var_0);

      if(var_5 == 2) {
        scripts\mp\utility\dialog::statusdialog("_encstr_8A7C145C8D088D7088502087026ED7C3F7D34AC14722", var_0);
        scripts\mp\utility\dialog::statusdialog("_encstr_966911714585885B197F3BE1DB43262B5C9113", var_1);
      } else {
        scripts\mp\utility\dialog::statusdialog("_encstr_AAE70838F27E43E327DC" + self.objectivekey, var_0);
        scripts\mp\utility\dialog::statusdialog("_encstr_86AD05B1F6B9A3" + self.objectivekey, var_1);
      }

      level.lastcaptime = gettime();
    }

    if(var_4 == "_encstr_A54F06D32A2F0498")
      _encstr_B2161FB9C627B4C18EE6E5B6E0793BB0B6B28E5E382BCDBCDCD2CA76598BB3B98D::teamrespawn(var_0, var_2);

    self.firstcapture = 0;
  }
}

getteamflagcount(var_0) {
  var_1 = 0;

  foreach(var_3 in level.objectives) {
    if(var_3.ownerteam == var_0)
      var_1++;
  }

  return var_1;
}

isflagexcluded(var_0, var_1) {
  var_2 = 0;

  if(isarray(var_1)) {
    foreach(var_4 in var_1) {
      if(var_0 == var_4) {
        var_2 = 1;
        break;
      }
    }
  } else if(var_0 == var_1)
    var_2 = 1;

  return var_2;
}

getunownedflagneareststart(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level.objectives) {
    if(var_6 scripts\mp\gameobjects::getownerteam() != "_encstr_A7A408B9CA5D1D4E2C63") {
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

awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
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
      if(istrue(var_0.useagents))
        return;
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
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8DFD0D67E0E384A31D4DD1D4A3F9EA");
      var_18 notify("_encstr_AB3508737F830710ACDB", var_1);
      var_11 = 1;
    }

    if(var_19 == "_encstr_A7A408B9CA5D1D4E2C63") {
      if(var_20 || var_21) {
        if(var_18.claimteam == var_13.team) {
          if(!var_11) {
            var_11 = 1;
            var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_AB3508737F830710ACDB");
            var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
            var_18 notify("_encstr_AB3508737F830710ACDB", var_1);
            thread scripts\common\utility::_id_13E0A(level._id_11B26, var_9, "_encstr_9AD10BF61657A2CD30606F6BE0");
            continue;
          }
        } else if(var_18.claimteam == var_1.team) {
          if(!var_12) {
            var_12 = 1;
            var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
            var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
            var_18 notify("_encstr_A20C07ABF304625E08", var_1);
            var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
            var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
            var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
            thread scripts\common\utility::_id_13E0A(level._id_11B26, var_9, "_encstr_ABA70A195633CADC324BDC76");
            continue;
          }
        }
      }
    } else if(var_19 != var_1.team) {
      if(!var_11) {
        var_22 = distsquaredcheck(var_18.trigger, var_15, var_14);

        if(var_22) {
          var_11 = 1;
          var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_AB3508737F830710ACDB");
          var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
          var_18 notify("_encstr_AB3508737F830710ACDB", var_1);
          thread scripts\common\utility::_id_13E0A(level._id_11B26, var_9, "_encstr_9AD10BF61657A2CD30606F6BE0");
          continue;
        }
      }
    } else if(!var_12) {
      var_23 = distsquaredcheck(var_18.trigger, var_15, var_14);

      if(var_23) {
        var_12 = 1;
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
        var_18 notify("_encstr_A20C07ABF304625E08", var_1);
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
        var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
        var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
        thread scripts\common\utility::_id_13E0A(level._id_11B26, var_9, "_encstr_ABA70A195633CADC324BDC76");
        continue;
      }
    }
  }
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0.origin, var_1);
  var_4 = distancesquared(var_0.origin, var_2);

  if(var_3 < 105625 || var_4 < 105625) {
    if(!isDefined(var_0.modifieddefendcheck))
      return 1;
    else if(var_1[2] - var_0.origin[2] < 100 || var_2[2] - var_0.origin[2] < 100)
      return 1;
    else
      return 0;
  } else
    return 0;
}

relic_nuketimer_timerloop() {
  switch (self.objectivekey) {
    case "_encstr_B20703DFCF":
      return 6;
    case "_encstr_B40703E96D":
      return 7;
    case "_encstr_B6070359BA":
      return 8;
    default:
      return 6;
  }
}

resetchemicalvalvevalues() {
  if(!isDefined(self.objectivekey))
    return "_encstr_B40101";

  switch (self.objectivekey) {
    case "_encstr_B20703DFCF":
      return "_encstr_994C0238";
    case "_encstr_B40703E96D":
      return "_encstr_8B4C0248";
    case "_encstr_B6070359BA":
      return "_encstr_834C02D0";
    case "_encstr_A2070318DC":
      return "_encstr_A14C02D5";
    case "_encstr_950703EBCA":
      return "_encstr_934C02A2";
    default:
      return "_encstr_B40101";
  }
}

_id_12ED1() {
  self rotateTo(self.angles - (135, 0, 0), 0.5, 0.25, 0.25);
  self playSound("_encstr_BD8F1485E75FA2874009378F0B5B451ADDF08BB14367");
  wait 0.55;
  playFX(level.spawnoffsettacinsertmax["_encstr_8C930DA4C67A4BFBF8F7C0C00F0E13"], self.origin + (0, 0, 60));
  self rotateTo(self.angles + (80, 0, 0), 0.2, 0.1, 0.1);
  wait 0.25;
  self rotateTo(self.angles - (60, 0, 0), 0.2, 0.1, 0.1);
  wait 0.25;
  self rotateTo(self.angles + (40, 0, 0), 0.2, 0.1, 0.1);
  wait 0.25;
  self rotateTo(self.angles - (15, 0, 0), 0.2, 0.1, 0.1);
  wait 0.25;
  self notify("_encstr_8D430EAF58BF22EB1F4A6003C0DB6553");
}

markdistanceoverride() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.flagmodel.startorigin = self.flagmodel.origin;
  self.flagmodel waittill("_encstr_8D430EAF58BF22EB1F4A6003C0DB6553");
  self.flagmodel.fwd = anglesToForward(self.flagmodel.angles);
  self.flagmodel.ismoving = 0;
  thread _id_144F0();

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isPlayer(var_0)) {
      if(!isDefined(self._id_1376A)) {
        self._id_1376A = var_0;
        thread _id_144F8(self.flagmodel, var_0);
      }
    }

    wait 0.25;
  }
}

_id_144F8(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8CE813B995EEEBDCA31636B5B293F58E58C9EC2BA3");
  self endon("_encstr_8CE813B995EEEBDCA31636B5B293F58E58C9EC2BA3");

  while(isDefined(self._id_1376A)) {
    if(!_id_140D6(var_0, var_1)) {
      self._id_1376A = undefined;
      self._id_13769 = 0;
      self.paddedquadgridcenterpoints = undefined;
      self.buildloadoutindices = undefined;
      self._id_12AC7 = undefined;
      self.flagmodel rotateTo((0, self.flagmodel.angles[1], self.flagmodel.angles[2]), 0.2, 0.1, 0.1);
    } else if(isDefined(self._id_1376A) && scripts\mp\utility\player::isreallyalive(self._id_1376A)) {
      if(self.flagmodel.ismoving) {} else {
        self.flagmodel.fwd = anglesToForward(self.flagmodel.angles);
        var_2 = self._id_1376A.origin;
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

_id_144F0() {
  self.flagmodel setCanDamage(1);
  self._id_13769 = 0;

  for(;;) {
    self.flagmodel waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(isDefined(var_1) && isDefined(self._id_1376A) && self._id_1376A == var_1)
      self._id_13769 = self._id_13769 + var_0;

    if(isDefined(self._id_13769)) {
      if(self._id_13769 > 100 && !isDefined(self.paddedquadgridcenterpoints))
        self.paddedquadgridcenterpoints = 1;

      if(self._id_13769 > 200 && !isDefined(self.buildloadoutindices)) {
        self.buildloadoutindices = 1;
        playFX(level.spawnoffsettacinsertmax["_encstr_81930D73E6AE887E4AAF090F97A2C8"], self.flagmodel.origin + (0, 0, 80));
      }

      if(self._id_13769 > 300 && !isDefined(self._id_12AC7)) {
        self._id_12AC7 = 1;
        thread _id_12CCD(var_1);
      }
    }

    wait 0.25;
  }
}

_id_12CCD(var_0) {
  self.flagmodel moveTo(self.flagmodel.origin + (0, 0, 50), 0.2, 0.1, 0.1);
  wait 0.25;
  self.flagmodel moveTo(self.flagmodel.startorigin, 0.1, 0.05, 0.05);
  wait 0.2;
  self.flagmodel playSound("_encstr_A14A1AF05B2765281517A7FF51BA30BECB020B3E426F30A0681091EF");
  var_1 = self.flagmodel.origin + (0, 0, 32);
  playFX(level._effect["_encstr_8EF3100682106612B5B58F5F28607CB76B38"], var_1);

  if(isDefined(var_0))
    var_0 dodamage(100, self.flagmodel.origin + (0, 0, 50), var_0, self.flagmodel, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", undefined, "_encstr_81CC0586952C91");

  self._id_13769 = 0;
  self.paddedquadgridcenterpoints = undefined;
  self.buildloadoutindices = undefined;
  self._id_12AC7 = undefined;
}

round_robin_spawners() {
  var_0 = self getplayerangles();
  var_1 = anglesToForward(var_0);
  return var_1;
}

_id_140D6(var_0, var_1) {
  var_2 = 0.05;
  var_3 = var_1 round_mortars_logic();
  var_4 = var_0 rocket_fuel_x2();
  var_5 = distancesquared(var_4, var_3);

  if(var_5 > 90000)
    return 0;
  else
    return 1;

  return 0;
}

rocket_fuel_x2() {
  return self.origin;
}

round_mortars_logic() {
  return self.origin;
}