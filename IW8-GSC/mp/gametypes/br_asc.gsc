/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_asc.gsc
***********************************************/

activate_c4_for_pick_up() {}

activate_laser_trap_parent() {}

init() {
  if(getdvarint("_encstr_8BE10BBF076BA63716E63F3066", 0) == 0) {
    return;
  }
  while(!isDefined(level.player))
    waitframe();

  tarmac_techo_start();
  _encstr_A7E62A1878601FF3B5FA46335F8850594197FD688F982EADB250393238599F2252FE61AB520738BEF05A7FFB::stoppingpower_watchhcrammodrain();

  foreach(var_1 in level.canparachutebecut.canplaycircleclosedialog)
  var_1.markingcoldblooded = _id_13534(var_1.origin, var_1.angles);
}

tarmac_techo_start() {
  var_0 = spawnStruct();
  var_0.markintelwithrecondrone = getdvarint("_encstr_A30A0CC74FF0485EB06AB065474B", 250);
  var_0.markingendtime = getdvarint("_encstr_850A0CF7FF0EC151B049C90FE640", 100);
  var_0.markplayeraseliminated = getdvarfloat("_encstr_861A0F9B8D397DB0E6C6EBC8B1C2837DA3", 5);
  var_0.canplaycircleclosedialog = [];
  level.canparachutebecut = var_0;
  scripts\engine\scriptable::_id_12F5B("_encstr_AB890858E66C4CF68C97", ::_id_11FD3);
}

active_neurotoxin_clouds() {}

_id_11FD3(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 != "_encstr_A350079E35DACF8944")
    _id_12D27(var_3, 0);
}

_id_120B5(var_0) {
  var_1 = self;
  var_1 setscriptablepartstate("_encstr_AB890858E66C4CF68C97", "_encstr_93CF08C7684F60BBB372");
}

gates_puzzle() {
  return 1;
}

active_relic_bang_and_boom() {}

get_current_armor_ammo(var_0) {
  var_1 = var_0.team;
  scripts\mp\gameobjects::setownerteam(var_1);
  self notify("_encstr_95EB0866891B23FB85B3", var_0);
  self notify("_encstr_AB3508737F830710ACDB", var_0);
  self.scriptable _id_120B5(var_0);
  _id_12D27(var_0, 1);
}

_id_1307F() {
  self notify("_encstr_BA4A0DE659885FF7B839CBE3E30773");
  scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");

  if(isDefined(level.matchrecording_logevent) && isDefined(self.logid) && isDefined(self.logeventflag))
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), 0);

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "_encstr_A7A408B9CA5D1D4E2C63");
}

_id_13534(var_0, var_1) {
  if(!gates_puzzle()) {
    return;
  }
  var_2 = level.canparachutebecut.markintelwithrecondrone;
  var_3 = level.canparachutebecut.markingendtime;
  var_4 = level.canparachutebecut.markplayeraseliminated;
  var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, var_2, var_3);
  var_5.angles = var_1;
  var_6[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin);
  var_6[0].angles = var_5.angles;
  var_7 = "_encstr_A7A408B9CA5D1D4E2C63";
  var_8 = scripts\mp\gameobjects::createuseobject(var_7, var_5, var_6, undefined, undefined, undefined, 0);
  var_8 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  var_8 scripts\mp\gameobjects::cancontestclaim(1);
  var_8 scripts\mp\gameobjects::setusetime(var_4);
  var_8 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC", undefined, 1);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_8.objidnum);
  var_8.id = "_encstr_87D9083A6F628DDB5F1F";
  var_8.pinobj = 0;
  var_8.lockupdatingicons = 0;
  var_8.claimgracetime = var_4 * 1000;
  var_8.firstcapture = 1;
  var_8.scriptable = easepower("_encstr_97930CA5128950EEDFB94B73C2EB", var_0, var_1);
  var_8.vfxnamemod = "_encstr_B40101";
  var_8.noscriptable = 0;
  var_8.onuse = ::_id_11FE1;
  var_8.onbeginuse = ::_id_11FDE;
  var_8.onuseupdate = ::_id_11FE0;
  var_8.onenduse = ::_id_11FDF;
  var_8.oncontested = ::_id_11FD9;
  var_8.onuncontested = ::_id_11FDB;
  var_8.onunoccupied = ::_id_11FDC;
  var_8.onpinnedstate = ::_id_11FDA;
  var_8.onunpinnedstate = ::_id_11FDD;
  return var_8;
}

play_dom_capture_sfx(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_0 = int(floor(var_0 * 10));
    var_2 = "_encstr_856B180A5867CF6F6068A3D9972B4F12537312A1E0E3C6A71EC7" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
  }
}

activate_front_trigger_hurt() {}

_id_11FE1(var_0) {
  var_1 = var_0.team;
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;

  if(istrue(level.flagneutralization)) {
    var_2 = scripts\mp\gameobjects::getownerteam();

    if(var_2 == "_encstr_A7A408B9CA5D1D4E2C63" && self.firstcapture == 1) {
      self.firstcapture = 0;
      get_current_armor_ammo(var_0);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);
      return;
    }

    thread _id_1307F(1);
    scripts\mp\utility\sound::playsoundonplayers("_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", var_2);
    level.lastcaptime = gettime();
    self.neutralized = 1;
    return;
  } else if(self.firstcapture == 1) {
    self.firstcapture = 0;
    get_current_armor_ammo(var_0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);
  }
}

_id_11FDE(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  self.neutralizing = istrue(level.flagneutralization) && var_1 != "_encstr_A7A408B9CA5D1D4E2C63";

  if(self.neutralizing) {
    if(var_1 != var_0.team)
      var_2 = 6;
    else
      var_2 = 0;
  } else if(var_1 != var_0.team)
    var_2 = 1;
  else
    var_2 = 0;

  scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(self.objidnum, var_0);
  var_0 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", var_2);
  var_3 = scripts\engine\utility::ter_op(istrue(level.flagneutralization) && !self.firstcapture, level.canparachutebecut.markplayeraseliminated * 0.5, level.canparachutebecut.markplayeraseliminated);
  scripts\mp\gameobjects::setusetime(var_3);

  if(var_3 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var_0.team)[0];
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
  }
}

_id_11FE0(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_1 < 1.0 && !level.gameended)
    play_dom_capture_sfx(var_1, var_0);

  if(var_1 > 0.05 && var_2 && isDefined(self.didstatusnotify) && !self.didstatusnotify) {
    if(var_4 == "_encstr_A7A408B9CA5D1D4E2C63") {
      if(level.canparachutebecut.markplayeraseliminated > 0.05)
        scripts\mp\utility\dialog::statusdialog("_encstr_823109E62B1BAB27D2B93B" + self.objectivekey, var_0);
    } else if(level.canparachutebecut.markplayeraseliminated > 0.05) {
      scripts\mp\utility\dialog::statusdialog("_encstr_8267076C10DBE8B6E0" + self.objectivekey, var_4);
      scripts\mp\utility\dialog::statusdialog("_encstr_823109E62B1BAB27D2B93B" + self.objectivekey, var_0);
    }

    self.didstatusnotify = 1;
  }
}

_id_11FDF(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    var_1 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63")
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  if(!var_2)
    self.neutralized = 0;
}

_id_11FD9() {
  self.hostvictimoverride = gettime();
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

_id_11FDB(var_0) {
  if(istrue(level.flagneutralization) && !self.firstcapture)
    scripts\mp\gameobjects::setusetime(level.canparachutebecut.markplayeraseliminated * 0.5);

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
  self.hostvictimoverride = undefined;
}

_id_11FDC() {}

_id_11FDA(var_0) {}

_id_11FDD(var_0) {}

activate_trap_object() {}

_id_12D27(var_0, var_1) {
  var_2 = [];

  if(var_1)
    var_2 = var_0 getweaponslistprimaries();

  foreach(var_4 in var_2)
  var_0 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::delay_delete_alerted_icon(var_4);
}

active_drones() {}

activate_emp_drone_pick_up() {}