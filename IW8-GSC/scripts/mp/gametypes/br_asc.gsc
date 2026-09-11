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

  foreach(var1 in level.canparachutebecut.canplaycircleclosedialog) {
    var1.markingcoldblooded = ref_13534(var1.origin, var1.angles);
  }
}

function tarmac_techo_start() {
  var0 = spawnStruct();
  var0.markintelwithrecondrone = getdvarint("scr_asc_d_r", 250);
  var0.markingendtime = getdvarint("scr_asc_d_h", 100);
  var0.markplayeraseliminated = getdvarfloat("scr_asc_dcap_t", 5);
  var0.canplaycircleclosedialog = [];
  level.canparachutebecut = var0;
  scripts\engine\scriptable::ref_12f5b("ascbody", &ref_11fd3);
}

function active_neurotoxin_clouds() {}

function ref_11fd3(var0, var1, var2, var3, var4) {
  if(var2 != "closed") {
    ref_12d27(var3, 0);
    return;
  }
}

function ref_120b5(var0) {
  var1 = self;
  var1 setscriptablepartstate("ascbody", "opening");
}

function gates_puzzle() {
  return true;
}

function active_relic_bang_and_boom() {}

function get_current_armor_ammo(var0) {
  var1 = var0.team;
  scripts\mp\gameobjects::setownerteam(var1);
  self notify("capture", var0);
  self notify("assault", var0);
  ref_120b5(self.scriptable, var0);
  ref_12d27(var0, 1);
}

function ref_1307f() {
  self notify("flag_neutral");
  scripts\mp\gameobjects::setownerteam("neutral");

  if(isDefined(level.matchrecording_logevent) && isDefined(self.logid) && isDefined(self.logeventflag)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), 0);
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "neutral");
}

function ref_13534(var0, var1) {
  if(!gates_puzzle()) {
    return;
  }

  var2 = level.canparachutebecut.markintelwithrecondrone;
  var3 = level.canparachutebecut.markingendtime;
  var4 = level.canparachutebecut.markplayeraseliminated;
  var5 = spawn("trigger_radius", var0, 0, var2, var3);
  var5.angles = var1;
  GscBinSkip1(0x45, 0, spawn("script_model", var5.origin));
}

function play_dom_capture_sfx(var0, var1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var0 = int(floor(var0 * 10));
    var2 = "mp_dom_capturing_tick_0" + var0;
    self.visuals[0] playsoundtoteam(var2, var1);
    return;
  }
}

function activate_front_trigger_hurt() {}

function ref_11fe1(var0) {
  var1 = var0.team;
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;

  if(istrue(level.flagneutralization)) {
    var2 = scripts\mp\gameobjects::getownerteam();

    if(var2 == "neutral" && self.firstcapture == 1) {
      self.firstcapture = 0;
      get_current_armor_ammo(var0);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);
      return;
    }

    thread ref_1307f(1);
    scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", var2);
    level.lastcaptime = gettime();
    self.neutralized = 1;
    return;
  }

  if(self.firstcapture == 1) {
    self.firstcapture = 0;
    get_current_armor_ammo(var0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);
    return;
  }
}

function ref_11fde(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  self.neutralizing = istrue(level.flagneutralization) && var1 != "neutral";

  if(self.neutralizing) {
    if(var1 != var0.team) {
      var2 = 6;
    } else {
      var2 = 0;
    }
  } else if(var2 != var2.team) {
    var2 = 1;
  } else {
    var2 = 0;
  }

  scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(self.objidnum, var2);
  var2 setclientomnvar("ui_objective_state", var2);
  var3 = scripts\engine\utility::ter_op(istrue(level.flagneutralization) && !self.firstcapture, level.canparachutebecut.markplayeraseliminated * 0.5, level.canparachutebecut.markplayeraseliminated);
  scripts\mp\gameobjects::setusetime(var3);

  if(var3 > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var2.team)[0];
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
    return;
  }
}

function ref_11fe0(var0, var1, var2, var3) {
  var4 = scripts\mp\gameobjects::getownerteam();

  if(var1 < 1 && !level.gameended) {
    play_dom_capture_sfx(var1, var0);
  }

  if(var1 > 0.05 && var2 && isDefined(self.didstatusnotify) && !self.didstatusnotify) {
    if(var4 == "neutral") {
      if(level.canparachutebecut.markplayeraseliminated > 0.05) {
        scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var0);
      }
    } else if(level.canparachutebecut.markplayeraseliminated > 0.05) {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var4);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var0);
    }

    self.didstatusnotify = 1;
    return;
  }
}

function ref_11fdf(var0, var1, var2) {
  if(isPlayer(var1)) {
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_dom_securing = undefined;
  }

  var3 = scripts\mp\gameobjects::getownerteam();

  if(var3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  if(!var2) {
    self.neutralized = 0;
    return;
  }
}

function ref_11fd9() {
  self.hostvictimoverride = gettime();
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

function ref_11fdb(var0) {
  if(istrue(level.flagneutralization) && !self.firstcapture) {
    scripts\mp\gameobjects::setusetime(level.canparachutebecut.markplayeraseliminated * 0.5);
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
  self.hostvictimoverride = undefined;
}

function ref_11fdc() {}

function ref_11fda(var0) {}

function ref_11fdd(var0) {}

function activate_trap_object() {}

function ref_12d27(var0, var1) {
  var2 = [];

  if(var1) {
    var2 = var0 getweaponslistprimaries();
  }

  foreach(var4 in var2) {
    var0 scripts\mp\gametypes\br_weapons::delay_delete_alerted_icon(var4);
  }
}

function active_drones() {}

function activate_emp_drone_pick_up() {}