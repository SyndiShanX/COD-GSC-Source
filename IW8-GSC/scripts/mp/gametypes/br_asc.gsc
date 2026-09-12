/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_asc.gsc
***********************************************/

function activate_c4_for_pick_up() {}

function activate_laser_trap_parent() {}

function init() {
  if(getdvarint("scr_asc_on", 0) == 0) {
    return;
  }

  while(!isDefined(level.player)) {
    waitframe();
  }

  tarmac_techo_start();
  scripts\mp\gametypes\br_asc_locations::stoppingpower_watchhcrammodrain();

  foreach(var_1 in level.canparachutebecut.canplaycircleclosedialog) {
    var_1.markingcoldblooded = ref_13534(var_1.origin, var_1.angles);
  }
}

function tarmac_techo_start() {
  var_0 = spawnStruct();
  var_0.markintelwithrecondrone = getdvarint("scr_asc_d_r", 250);
  var_0.markingendtime = getdvarint("scr_asc_d_h", 100);
  var_0.markplayeraseliminated = getdvarfloat("scr_asc_dcap_t", 5);
  var_0.canplaycircleclosedialog = [];
  level.canparachutebecut = var_0;
  scripts\engine\scriptable::ref_12F5B("ascbody", &ref_11FD3);
}

function active_neurotoxin_clouds() {}

function ref_11FD3(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 != "closed") {
    ref_12D27(var_3, 0);
    return;
  }
}

function ref_120B5(var_0) {
  var_1 = self;
  var_1 setscriptablepartstate("ascbody", "opening");
}

function gates_puzzle() {
  return true;
}

function active_relic_bang_and_boom() {}

function get_current_armor_ammo(var_0) {
  var_1 = var_0.team;
  scripts\mp\gameobjects::setownerteam(var_1);
  self notify("capture", var_0);
  self notify("assault", var_0);
  ref_120B5(self.scriptable, var_0);
  ref_12D27(var_0, 1);
}

function ref_1307F() {
  self notify("flag_neutral");
  scripts\mp\gameobjects::setownerteam("neutral");

  if(isDefined(level.matchrecording_logevent) && isDefined(self.logid) && isDefined(self.logeventflag)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), 0);
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "neutral");
}

function ref_13534(var_0, var_1) {
  if(!gates_puzzle()) {
    return;
  }

  var_2 = level.canparachutebecut.markintelwithrecondrone;
  var_3 = level.canparachutebecut.markingendtime;
  var_4 = level.canparachutebecut.markplayeraseliminated;
  var_5 = spawn("trigger_radius", var_0, 0, var_2, var_3);
  var_5.angles = var_1;
  GscBinSkip1(0x45, 0, spawn("script_model", var_5.origin));
}

function play_dom_capture_sfx(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_0 = int(floor(var_0 * 10));
    var_2 = "mp_dom_capturing_tick_0" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
    return;
  }
}

function activate_front_trigger_hurt() {}

function ref_11FE1(var_0) {
  var_1 = var_0.team;
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;

  if(istrue(level.flagneutralization)) {
    var_2 = scripts\mp\gameobjects::getownerteam();

    if(var_2 == "neutral" && self.firstcapture == 1) {
      self.firstcapture = 0;
      get_current_armor_ammo(var_0);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);
      return;
    }

    thread ref_1307F(1);
    scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", var_2);
    level.lastcaptime = gettime();
    self.neutralized = 1;
    return;
  }

  if(self.firstcapture == 1) {
    self.firstcapture = 0;
    get_current_armor_ammo(var_0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);
    return;
  }
}

function ref_11FDE(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  self.neutralizing = istrue(level.flagneutralization) && var_1 != "neutral";

  if(self.neutralizing) {
    if(var_1 != var_0.team) {
      var_2 = 6;
    } else {
      var_2 = 0;
    }
  } else if(var_2 != var_2.team) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(self.objidnum, var_2);
  var_2 setclientomnvar("ui_objective_state", var_2);
  var_3 = scripts\engine\utility::ter_op(istrue(level.flagneutralization) && !self.firstcapture, level.canparachutebecut.markplayeraseliminated * 0.5, level.canparachutebecut.markplayeraseliminated);
  scripts\mp\gameobjects::setusetime(var_3);

  if(var_3 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var_2.team)[0];
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
    return;
  }
}

function ref_11FE0(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_1 < 1 && !level.gameended) {
    play_dom_capture_sfx(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && isDefined(self.didstatusnotify) && !self.didstatusnotify) {
    if(var_4 == "neutral") {
      if(level.canparachutebecut.markplayeraseliminated > 0.05) {
        scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var_0);
      }
    } else if(level.canparachutebecut.markplayeraseliminated > 0.05) {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var_4);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var_0);
    }

    self.didstatusnotify = 1;
    return;
  }
}

function ref_11FDF(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  if(!var_2) {
    self.neutralized = 0;
    return;
  }
}

function ref_11FD9() {
  self.hostvictimoverride = gettime();
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

function ref_11FDB(var_0) {
  if(istrue(level.flagneutralization) && !self.firstcapture) {
    scripts\mp\gameobjects::setusetime(level.canparachutebecut.markplayeraseliminated * 0.5);
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
  self.hostvictimoverride = undefined;
}

function ref_11FDC() {}

function ref_11FDA(var_0) {}

function ref_11FDD(var_0) {}

function activate_trap_object() {}

function ref_12D27(var_0, var_1) {
  var_2 = [];

  if(var_1) {
    var_2 = var_0 getweaponslistprimaries();
  }

  foreach(var_4 in var_2) {
    var_0 scripts\mp\gametypes\br_weapons::delay_delete_alerted_icon(var_4);
  }
}

function active_drones() {}

function activate_emp_drone_pick_up() {}