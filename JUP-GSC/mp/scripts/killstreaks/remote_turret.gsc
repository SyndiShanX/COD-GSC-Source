/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\killstreaks\remote_turret.gsc
****************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\killstreaks\manual_turret;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\mp\utility\script;
#namespace remote_turret;

function autoexec main() {
  registerkillstreakinitfunction(getxhash("remote_turret"), &init);
}

function private init() {
  if(issharedfuncdefined("remote_turret", "init")) {
    [[getsharedfunc("remote_turret", "init")]]();
  }

  if(issharedfuncdefined("remote_turret", "initSentrySettings")) {
    [[getsharedfunc("remote_turret", "initSentrySettings")]]();
  }

  registervisibilityomnvarforkillstreak("remote_turret", "on", 16);

  setdevdvarifuninitialized(@ "hash_c9bd691ce96079ac", 0);
  setdevdvarifuninitialized(@ "hash_e19e5d308effeda3", 1);
}

function function_cf9f8b598647e363(streakinfo, switchresult, weaponobj) {
  if(!istrue(switchresult)) {
    scripts\cp_mp\killstreaks\killstreakdeploy::getridofkillstreakdeployweapon(weaponobj);
  }
}

function tryuseremoteturret(streakname) {
  streakinfo = createstreakinfo(streakname, self);
  return function_c916c5b82db1290(streakinfo);
}

function function_c916c5b82db1290(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(streakinfo.weaponname)) {
    streakinfo.weaponname = "deploy_remote_turret_mp";
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      self.bgivensentry = 0;
      return false;
    }
  }

  if(self isswimming() || istrue(self.isridingvehicle) || self isjumping() || self isinfreefall() || self ishanging() || self isparachuting()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/REMOTE_TURRET_NOT_AVAILABLE");
    }

    return false;
  }

  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  endonnotify = "sentry_placement_failed";
  weaponobj = makeweapon("deploy_remote_turret_mp");

  if(issharedfuncdefined("weapons", "watchForPlacementFireState")) {
    self thread[[getsharedfunc("weapons", "watchForPlacementFireState")]](streakinfo, endonnotify, weaponobj);
  }

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, weaponobj, 1, undefined, undefined, &function_cf9f8b598647e363);

  if(!istrue(deployresult)) {
    self.bgivensentry = 0;
    self notify(endonnotify);
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      self.bgivensentry = 0;
      return false;
    }
  }

  turret = remoteturret_create("remote_turret", streakinfo);

  if(!isDefined(turret)) {
    self.bgivensentry = 0;
    return false;
  }

  marker = remoteturret_watchplacement(turret, streakinfo, 0, 1.25);

  if(!isDefined(marker)) {
    turret delete();
    self.bgivensentry = 0;
    return false;
  }

  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(&remoteturret_empstarted);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(&remoteturret_empcleared);
  turret scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_cc47405c2cd435e);
  turret scripts\cp_mp\equipment\haywire::function_aa823a31304ed981(&function_fe21c57503ab070f);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    turret[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_371131da10a20bb);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    turret[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_958fed8d4d1143fa);
  }

  turret.colmodel callsharedfunc("escort", "registerEscortCollisionCallback", &function_a9d407dcc53c2a3d);
  turret function_a6f142a3e83c312e(self);
  turret function_e68434bdb941ed1e(turret.streakinfo.streakname, self, &"KILLSTREAKS_HINTS/REMOTE_TURRET_USE", 1);
  remoteturret_setplaced(turret, marker);

  if(issharedfuncdefined("remote_turret", "munitionUsed")) {
    self[[getsharedfunc("remote_turret", "munitionUsed")]]();
  }

  thread function_3da5b516d6b9a223(turret);
  self.remoteturretactive = 1;
  self notify("remote_turret_active");
  return true;
}

function function_a6f142a3e83c312e(owner) {
  if(!isDefined(owner) || !isDefined(owner.var_c112b4aeaf6ce9ae)) {
    return;
  }

  if(isDefined(owner.var_c112b4aeaf6ce9ae[self.streakinfo.streakname])) {
    owner.var_c112b4aeaf6ce9ae[self.streakinfo.streakname] delete();
  }
}

function function_3da5b516d6b9a223(turret) {
  self endon("disconnect");
  turret endon("death");

  while(true) {
    waittill_any_3("killstreakActionCalled", "super_started", "assaultDroneCalled");
    val::set("remote_turret", "usability", 0);
    wait 2;
    val::reset("remote_turret", "usability");
  }
}

function remoteturret_watchplacement(turret, streakinfo, ignorecancel, var_290b1442271ab369) {
  self.bgivensentry = 1;
  thread remoteturret_delayplacementinstructions(var_290b1442271ab369);
  marker = undefined;

  if(issharedfuncdefined("remote_turret", "watchForPlayerEnteringLastStand")) {
    self thread[[getsharedfunc("remote_turret", "watchForPlayerEnteringLastStand")]]();
  }

  if(issharedfuncdefined("remote_turret", "getTargetMarker")) {
    marker = self[[getsharedfunc("remote_turret", "getTargetMarker")]](streakinfo, ignorecancel);
  }

  self notify("turret_placement_finished");

  if(!isDefined(marker) || !isDefined(marker.location)) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      killstreak_switchbacklastweapon("deploy_remote_turret_mp");
    }

    return undefined;
  }

  turret thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(self, 1, 1);

  if(self hasweapon("deploy_remote_turret_mp")) {
    thread killstreak_switchbacklastweapon("deploy_remote_turret_mp", 1, 1);
  }

  delayspawntime = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delayspawntime);
  params = spawnStruct();
  params.player = self;
  callback::callback("remote_turret_deployed", params);
  return marker;
}

function remoteturret_delayplacementinstructions(delaytime) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  self setclientomnvar("ui_turret_placement", 1);
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("death");
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("turret_placement_finished");
}

function remoteturret_create(turrettype, streakinfo) {
  config = level.sentrysettings[turrettype];
  turret = spawnturret("misc_turret", self.origin, level.sentrysettings[turrettype].weaponinfo);
  turret.owner = self;
  turret.team = self.team;
  turret.angles = self.angles;
  turret.health = 9999;
  turret.maxhealth = config.maxhealth;
  turret.streakinfo = streakinfo;
  turret.turrettype = turrettype;
  turret.shouldsplash = 1;
  turret.ammocount = config.ammo;
  turret.timeout = config.timeout;
  turret.var_de4dbbca9f355800 = 0;

  if(issharedfuncdefined("remote_turret", "attachXRays")) {
    turret = [[getsharedfunc("remote_turret", "attachXRays")]](turret);
  }

  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    turret.timeout = 9999;
  } else if(isdvardefined(@ "hash_d17291ec1b4e806e")) {
    turret.timeout = getdvarint(@ "hash_d17291ec1b4e806e");
  }

  if(!isDefined(turret.timeout)) {
    turret.timeout = 120;
  }

  turret.maxtimeout = turret.timeout;
  turret.carriedby = self;
  turret remoteturret_setturretmodel("placed");
  turret setturretowner(turret.owner);
  turret setturretteam(turret.team);
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret hide();
  turret setautorotationdelay(0.2);
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 0.1;

  switch (turrettype) {
    case #"hash_ab5712e297cd430e":
    default:
      turret setleftarc(80);
      turret setrightarc(80);
      turret setbottomarc(50);
      turret settoparc(60);
      turret setconvergencetime(0.6, "pitch");
      turret setconvergencetime(0.6, "yaw");
      turret setconvergenceheightpercent(0.65);
      turret setdefaultdroppitch(-89);
      break;
  }

  turret setturretmodechangewait(1);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  killcamforward = anglesToForward(turret.angles);
  killcampos = turret gettagorigin("tag_barrel") + (0, 0, 10);
  killcampos -= killcamforward * 20;
  killcament = spawn("script_model", killcampos);
  killcament linkTo(turret);
  turret.killcament = killcament;
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel("wm_jup_2h_remote_turret_00_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel hide();
  turret.colmodel.turret = turret;
  turret function_9553839f6b149375();
  return turret;
}

function remoteturret_setplaced(turret, marker) {
  bundle = level.streakglobals.streakbundles["remote_turret"];
  config = level.sentrysettings[turret.turrettype];
  turret remoteturret_setturretmodel("placed");

  if(!isDefined(self.placedsentries)) {
    self.placedsentries = [];
  }

  if(!isDefined(self.placedsentries[turret.turrettype])) {
    self.placedsentries[turret.turrettype] = [];
  }

  if(istrue(turret.shouldsplash)) {
    if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, turret.streakinfo.streakname);
    }

    splashname = config.teamsplash;

    if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[getsharedfunc("hud", "teamPlayerCardSplash")]](splashname, self);
    }

    turret.shouldsplash = 0;
  }

  turret show();
  turret dontinterpolate();
  turret.angles = marker.angles;
  turret.carriedby = undefined;

  if(isDefined(marker.moving_platform)) {
    turret.moving_platform = marker.moving_platform;
    turret.moving_platform_offset = marker.moving_platform_offset;
    turret.moving_platform_angles_offset = marker.moving_platform_angles_offset;
  }

  self.bgivensentry = 0;
  turret.origin = marker.location;
  turret setscriptablepartstate("turret_carry_state", "turret_plant");
  turret setscriptablepartstate("lights", "daytime", 0);
  turret.colmodel show();
  turret.colmodel.angles = turret.angles;
  turret.colmodel.origin = turret.origin;
  turret.colmodel linkTo(turret);
  turret.deletefunc = &function_3eccd3cd75317e53;
  turreticon = bundle.minimapicon;

  if(issharedfuncdefined("game", "createObjective")) {
    turret.minimapid = turret.colmodel[[getsharedfunc("game", "createObjective")]](turreticon, turret.team, undefined, 1, 1);
  }

  turretcount = self.placedsentries[turret.turrettype].size;

  if(turretcount + 1 > 1) {
    self.placedsentries[turret.turrettype][0] notify("kill_turret", 0, 0);
  }

  headiconoffset = 70;

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    turret[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](turret.turrettype, "Killstreak_Ground", self, 0, 1, headiconoffset, "carried");
  }

  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeon);
  hinttag = "tag_aim_pivot";
  hintpos = turret gettagorigin(hinttag);

  if(!isDefined(turret.useownerobj)) {
    if(issharedfuncdefined("remote_turret", "createHintObject")) {
      turret.useownerobj = [[getsharedfunc("remote_turret", "createHintObject")]](hintpos, "HINT_BUTTON", undefined, config.ownerusehintstring, undefined, undefined, "show");
    }
  } else {
    hintpos = turret gettagorigin(hinttag);
    turret.useownerobj function_dfb78b3e724ad620(1);
    turret.useownerobj dontinterpolate();
    turret.useownerobj.origin = hintpos;
  }

  turret.useownerobj linkTo(turret, hinttag);

  foreach(guy in level.players) {
    if(guy != turret.owner) {
      turret.useownerobj disableplayeruse(guy);
    }
  }

  turret thread function_691b0d98100b44cd();

  if(issharedfuncdefined("game", "handlemovingplatforms")) {
    data = spawnStruct();
    data.deathoverridecallback = &function_3eccd3cd75317e53;

    if(isDefined(turret.moving_platform)) {
      data.linkparent = turret.moving_platform;
      data.linkoffset = turret.moving_platform_offset;
      data.angleoffset = turret.moving_platform_angles_offset;

      if(isDefined(level.wztrain_info) && scripts\cp_mp\utility\train_utility::is_train_ent(turret.moving_platform)) {
        data.plantedontrain = 1;
      }
    }

    turret thread[[getsharedfunc("game", "handlemovingplatforms")]](data);
  }

  turret scripts\cp_mp\emp_debuff::allow_emp(1);

  if(issharedfuncdefined("game", "registerSentient")) {
    turret[[getsharedfunc("game", "registerSentient")]]("Killstreak_Static", self);
  }

  if(!istrue(turret.owner.ksempd)) {
    turret remoteturret_empupdate();
    turret thread remoteturret_attacktargets(undefined, self);
  }

  turret thread function_1223f321ae6ff9a5();

  turret thread remoteturret_beepsounds();
  function_3650adfd6e0d1fb9(scripts\cp_mp\utility\killstreak_utility::function_13276a05f9b52006("remote_turret"));
  function_ca5bd9a5609d8ba3();
  thread remoteturret_delaydeletemarker(turret, marker);
  thread remoteturret_watchpickup(turret);
  thread remoteturret_disableplayeruseonconnect(turret, turret.useownerobj);

  if(!istrue(turret.owner.ksempd)) {
    thread function_2bd5e2012f429ae3(turret);
  }

  turret thread remoteturret_watchownerdeath(self);

  if(!istrue(turret.damagemonitored)) {
    thread remoteturret_watchdamage(turret);
  }

  thread remoteturret_watchdeath(turret);
  thread remoteturret_watchtimeout(turret);
  thread remoteturret_watchdisown(turret);
  thread remoteturret_watchgameend(turret);
  turret function_13a319439a116d2(self);
  turret.isplaced = 1;
  self.placedsentries[turret.turrettype][turretcount] = turret;
  turret notify("turret_place_successful");
  turret function_ae53424c3a02628d(bundle, turret.origin, self, self.team, turret.timeout);
}

function function_3650adfd6e0d1fb9(killstreakid) {
  assertex(isDefined(killstreakid), "<dev string:x1c>");

  if(killstreakid == 0) {
    self setclientomnvar("ui_killstreak_use_widget", killstreakid);
    self.parkedwidgetid = undefined;
    return;
  }

  self setclientomnvar("ui_killstreak_use_widget", killstreakid);
  self.parkedwidgetid = killstreakid;
}

function function_691b0d98100b44cd() {
  self notify("end_remote_monitor");
  self endon("end_remote_monitor");
  self endon("death");
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  self.useobj enableplayeruse(self.owner);
  self.useobj setuseholdduration(500);
  useobjdisabled = 0;

  while(true) {
    if(istrue(self.owner utility::isusingremote()) && !useobjdisabled && self.owner.usingremote != "remote_turret") {
      self.useobj disableplayeruse(self.owner);
      useobjdisabled = 1;
    } else if(useobjdisabled && !istrue(self.owner utility::isusingremote())) {
      wait 1;
      self.useobj enableplayeruse(self.owner);
      useobjdisabled = 0;
    }

    wait 0.1;
  }
}

function function_2bd5e2012f429ae3(turret) {
  self endon("remote_turret_empd");
  turret endon("remote_turret_death");
  turret endon("remote_turret_ownerDeath");
  turret endon("kill_turret");
  turret endon("carried");
  turret.useobj waittill("trigger", player);

  if(!function_8cf8be1c2f72ddd5()) {
    thread function_2bd5e2012f429ae3(turret);
    return;
  }

  if(istrue(turret.isplaced) && !istrue(turret.owner.ksempd) && !istrue(utility::isusingremote()) && function_8cf8be1c2f72ddd5()) {
    self.deployingremoteturret = 1;
    self disableweaponswitch();

    if(istrue(turret.isbarrelspinning)) {
      turret stopbarrelspin();
      turret.isbarrelspinning = undefined;
    }

    val::set("remote_turret", "allow_movement", 0);
    val::set("remote_turret", "usability", 0);
    val::set("remote_turret", "killstreaks", 0);
    val::set("remote_turret", "supers", 0);
    val::set("remote_turret", "reload", 0);
    val::set("remote_turret", "offhand_weapons", 0);
    val::set("remote_turret", "melee", 0);
    self notify("using_remote");
    turret setscriptablepartstate("turret_mode", "turret_mode_pre_manual");
    turret remoteturret_spindown();
    turret thread remoteturret_burstfirestop();
    turret thread function_13a319439a116d2(self);
    thread function_ca5bd9a5609d8ba3();
    turret setmode("sentry_offline");
    turret notify("enterRemote");
    turret thread function_9cc5ca1b073338ab(self);
    thread function_a920f20104777b97(turret, turret.var_de4dbbca9f355800);

    function_45456bb78fa8eb2d("<dev string:x77>");

    remoteturret_deploytablet(turret);

    function_45456bb78fa8eb2d("<dev string:x93>");

    if(!istrue(turret.var_de4dbbca9f355800)) {
      wait 2;
      turret.var_de4dbbca9f355800 = 1;
    } else {
      wait 1;
    }

    if(getdvarint(@ "hash_81827f5873d8d4c3", 0) == 1) {
      thread function_1f85068748abaa9b(turret);
    }

    function_45456bb78fa8eb2d("<dev string:xb4>");

    thread function_478f159eb6d02ae8(turret);
    self waittill("remoteTurretFadeComplete");
    function_178aa80b91f36bf4();
    turret.var_ce4dc6c1d56eb0a9 = 1;
    self.usingremote = "remote_turret";
    turret notify("remote_enter");

    if(istrue(self.isjuggernaut)) {
      self notify("remote_enter");
    }

    turret setscriptablepartstate("turret_mode", "turret_mode_manual");
    turret setscriptablepartstate("lights", "remoted", 0);
    turret remoteturret_applyoverlay(self);

    if(function_8cf8be1c2f72ddd5()) {
      self remotecontrolturret(turret);
      thread function_dc251dedf977c842(turret);
      val::reset("remote_turret", "allow_movement");
      self.deployingremoteturret = undefined;
      return;
    }

    if(istrue(turret.isplaced)) {
      turret stopbarrelspin();
      turret setmode("sentry");
      turret.var_ce4dc6c1d56eb0a9 = undefined;
      self.usingremote = undefined;
      turret notify("remote_exit");

      if(istrue(self.isjuggernaut)) {
        self notify("remote_exit");
      }

      turret setscriptablepartstate("turret_mode", "turret_mode_sentry");
      turret setscriptablepartstate("lights", "daytime", 0);
      turret function_13a319439a116d2(self);
      turret remoteturret_removeoverlay(self);
      _switchtoweapon(self.primaryweaponobj);
      self enableweaponswitch();
      turret thread remoteturret_attacktargets(undefined, self);
      wait 1;

      if(isDefined(turret.tabletweaponobj)) {
        self takeweapon(turret.tabletweaponobj);
        turret.tabletweaponobj = undefined;
      }

      val::reset("remote_turret", "allow_movement");
      val::reset("remote_turret", "usability");
      val::reset("remote_turret", "killstreaks");
      val::reset("remote_turret", "supers");
      val::reset("remote_turret", "reload");
      val::reset("remote_turret", "offhand_weapons");
      val::reset("remote_turret", "melee");
      self.deployingremoteturret = undefined;
      thread function_2bd5e2012f429ae3(turret);
    }
  }
}

function function_a920f20104777b97(turret, var_de4dbbca9f355800) {
  level endon("game_ended");
  self endon("disconnect");
  hasendedearly = 0;
  result = waittill_any_ents_return(self, "remoteTurret_deployTabletFinished", self, "remote_turret_empd", turret, "remote_turret_death", turret, "kill_turret", turret, "carried");
  hasendedearly = !isDefined(result) || result != "remoteTurret_deployTabletFinished";

  if(!hasendedearly) {
    timeout = istrue(var_de4dbbca9f355800) ? 1 : 2;
    result = waittill_any_ents_or_timeout_return(timeout, self, "remote_turret_empd", turret, "remote_turret_death", turret, "kill_turret", turret, "carried");
    hasendedearly = !isDefined(result) || result != "timeout";
  }

  if(!hasendedearly) {
    self waittill("remoteTurretFadeComplete", issuccess);
    hasendedearly = !issuccess;
  }

  if(hasendedearly) {
    function_45456bb78fa8eb2d("<dev string:xcd>");

    function_178aa80b91f36bf4();
    currentweapon = self getcurrentweapon().basename;

    if(currentweapon == "ks_remote_device_mp") {
      _switchtoweapon(self.primaryweaponobj);
    }

    self enableweaponswitch();

    if(isDefined(turret.tabletweaponobj)) {
      self takeweapon(turret.tabletweaponobj);
      turret.tabletweaponobj = undefined;
    }

    val::reset("remote_turret", "allow_movement");
    val::reset("remote_turret", "usability");
    val::reset("remote_turret", "killstreaks");
    val::reset("remote_turret", "supers");
    val::reset("remote_turret", "reload");
    val::reset("remote_turret", "offhand_weapons");
    val::reset("remote_turret", "melee");
    self.usingremote = undefined;
  }
}

#using_animtree("script_model");

function remoteturret_deploytablet(turret) {
  turret endon("kill_turret");
  turret endon("remote_turret_death");
  weaponobj = makeweapon("ks_remote_device_mp");
  deployanim = % vm_ks_tablet_tap_raise;
  _giveweapon(weaponobj, 0, 0, 1);
  turret.tabletweaponobj = weaponobj;
  switchresult = domonitoredweaponswitch(weaponobj, 0);
  scripts\cp_mp\utility\killstreak_utility::starttabletscreen(turret.streakinfo.streakname, 0);
  function_178aa80b91f36bf4();
  self notify("remoteTurret_deployTabletFinished");
}

function function_478f159eb6d02ae8(turret) {
  level endon("game_ended");
  self endon("disconnect");

  if(_isalive()) {
    turretmodepartstate = turret getscriptablepartstate("turret_mode");

    if(turretmodepartstate == "turret_mode_manual") {
      turret setscriptablepartstate("turret_mode_fade", "turret_mode_manualtosentry_fadestart");
    } else {
      turret setscriptablepartstate("turret_mode_fade", "turret_mode_sentrytomanual_fadestart");
    }

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.3);
    result = waittill_any_ents_or_timeout_return(0.7, self, "remote_turret_empd", turret, "remote_turret_death", self, "death", turret, "kill_turret", turret, "carried");
    issuccess = isDefined(result) && result == "timeout";

    if(!issuccess) {
      turret scripts\common\utility::function_3677f2be30fdd581("turret_mode_fade", "turret_mode_sentrytomanual_fadeinterrupted");
    }

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.3);
    self notify("remoteTurretFadeComplete", issuccess);
  }
}

function function_8cf8be1c2f72ddd5() {
  if(self isswimming() || istrue(self.isridingvehicle) || self isjumping() || self isinfreefall() || self ishanging() || self isparachuting()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/REMOTE_TURRET_NOT_AVAILABLE");
    }

    return false;
  }

  return true;
}

function function_dc251dedf977c842(turret) {
  self endon("remote_turret_empd");
  turret endon("remote_turret_death");
  turret endon("kill_turret");
  turret endon("remote_turret_ownerDeath");
  turret endon("carried");
  childthread function_7317b5e0cedc533d(turret, 0.75);
  self waittill("remoteCamExit");

  if(istrue(turret.isplaced)) {
    turret stopbarrelspin();

    if(getdvarint(@ "hash_8cb86e86af6483b0", 0) == 1) {
      thread function_1f85068748abaa9b(turret);
    }

    thread function_478f159eb6d02ae8(turret);
    self waittill("remoteTurretFadeComplete");
    self remotecontrolturretoff(turret);
    turret setmode("sentry");
    turret.var_ce4dc6c1d56eb0a9 = undefined;
    self.usingremote = undefined;
    turret notify("remote_exit");

    if(istrue(self.isjuggernaut)) {
      self notify("remote_exit");
    }

    turret setscriptablepartstate("turret_mode", "turret_mode_sentry");
    turret setscriptablepartstate("lights", "daytime", 0);
    turret function_13a319439a116d2(self);
    turret remoteturret_removeoverlay(self);
    _switchtoweapon(self.primaryweaponobj);
    self enableweaponswitch();
    turret thread remoteturret_attacktargets(undefined, self);
    wait 1;

    if(isDefined(turret.tabletweaponobj)) {
      self takeweapon(turret.tabletweaponobj);
      turret.tabletweaponobj = undefined;
    }

    val::reset("remote_turret", "allow_movement");
    val::reset("remote_turret", "usability");
    val::reset("remote_turret", "killstreaks");
    val::reset("remote_turret", "supers");
    val::reset("remote_turret", "reload");
    val::reset("remote_turret", "offhand_weapons");
    val::reset("remote_turret", "melee");
    thread function_2bd5e2012f429ae3(turret);
  }
}

function private function_7317b5e0cedc533d(turret, overrideholdtime) {
  if(!isDefined(self) || !isDefined(turret)) {
    return;
  }

  level endon("game_ended");
  self endon("disconnect");
  self endon("end_remote");
  self endon("monitoringExit");
  turret endon("death");

  while(self useButtonPressed()) {
    waitframe();
  }

  holdtime = 0.75;

  if(isDefined(overrideholdtime)) {
    holdtime = overrideholdtime;
  }

  updaterate = level.framedurationseconds;
  timerdirty = 1;

  while(true) {
    timeused = 0;

    if(timerdirty == 1) {
      self setclientomnvar("ui_exit_progress", 0);
      timerdirty = 0;
    }

    while(self useButtonPressed()) {
      if(!self usinggamepad() && !self getuseholdkbmprofile()) {
        self notify("remoteCamExit");
        return;
      }

      timeused += updaterate;
      timerdirty = 1;
      self setclientomnvar("ui_exit_progress", timeused / holdtime);

      if(timeused > holdtime) {
        self notify("remoteCamExit");
        return;
      }

      wait updaterate;
    }

    wait updaterate;
  }
}

function function_fcf0bb8342007af(turret) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("remoteTurretFadeComplete", issuccess);

  if(issuccess) {}
}

function remoteturret_setcarried(turret) {
  turret endon("kill_turret");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
    self notify("switched_from_minigun");

    while(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
      waitframe();
    }
  }

  if(isDefined(turret.moving_platform)) {
    turret.moving_platform = undefined;
    turret.moving_platform_offset = undefined;
    turret.moving_platform_angles_offset = undefined;
    turret unlink();
  }

  turret scripts\cp_mp\emp_debuff::allow_emp(0);

  if(issharedfuncdefined("game", "unregisterSentient")) {
    turret[[getsharedfunc("game", "unregisterSentient")]](turret.sentientpool, turret.sentientpoolindex);
  }

  linkedchildren = turret getlinkedchildren();

  foreach(child in linkedchildren) {
    if(isDefined(child)) {
      child unlink();
    }
  }

  if(isDefined(turret.minimapid)) {
    if(issharedfuncdefined("game", "returnObjectiveID")) {
      [[getsharedfunc("game", "returnObjectiveID")]](turret.minimapid);
    }

    turret.minimapid = undefined;
  }

  turret.colmodel unlink();
  turret.colmodel hide();
  remoteturret_setinactive(turret);
  turret hide();
  function_3650adfd6e0d1fb9(0);
  turret function_a6f142a3e83c312e(self);
  turret.carriedby = self;
  turret notify("carried");
  self playSound("kls_remote_turret_pickup");
  turret setscriptablepartstate("turret_carry_state", "turret_pickup");
  turret function_9cc5ca1b073338ab(self);
  thread function_ca5bd9a5609d8ba3();
  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  turret killstreak_destroydangerzone();
  endonnotify = "sentry_placement_failed";

  if(issharedfuncdefined("weapons", "watchForPlacementFireState")) {
    self thread[[getsharedfunc("weapons", "watchForPlacementFireState")]](turret.streakinfo, endonnotify);
  }

  _giveweapon("deploy_remote_turret_mp");
  switchsuccess = domonitoredweaponswitch("deploy_remote_turret_mp", 1);

  if(!istrue(switchsuccess)) {
    self notify(endonnotify);
    _takeweapon("deploy_remote_turret_mp");
    turret notify("kill_turret", 1, 1);
    return 0;
  }

  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(0);
  marker = remoteturret_watchplacement(turret, turret.streakinfo, 1, 2);
  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);

  if(!isDefined(marker)) {
    return 0;
  }

  turret function_e68434bdb941ed1e(turret.streakinfo.streakname, self, &"KILLSTREAKS_HINTS/REMOTE_TURRET_USE", 1);
  remoteturret_setplaced(turret, marker);
}

function remoteturret_switchbacklastweapon(immediateswitch) {
  if(istrue(immediateswitch)) {
    _switchtoweaponimmediate(self.lastdroppableweaponobj);
  } else {
    _switchtoweapon(self.lastdroppableweaponobj);
  }

  _takeweapon("deploy_remote_turret_mp");
}

function remoteturret_setinactive(turret) {
  turret.isplaced = undefined;
  turret setdefaultdroppitch(30);
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
  turret.useownerobj function_dfb78b3e724ad620(0);
  turret.useownerobj unlink();
}

function remoteturret_delaydeletemarker(turret, marker) {
  turret endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(marker.visual)) {
    marker.visual delete();
  }
}

function remoteturret_disableplayeruseonconnect(turret, useobj) {
  if(isDefined(turret)) {
    turret endon("kill_turret");
    turret endon("carried");
  }

  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    useobj disableplayeruse(player);
  }
}

function remoteturret_watchpickup(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    turret.useownerobj waittill("trigger", player);

    if(player != turret.owner) {
      continue;
    }

    if(istrue(self.ishaywire)) {
      continue;
    }

    if(issharedfuncdefined("remote_turret", "allowPickupOfTurret")) {
      if(!player[[getsharedfunc("remote_turret", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    turret.useownerobj function_dfb78b3e724ad620(0);
    turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
    turret.owner.placedsentries[turret.turrettype] = array_remove(turret.owner.placedsentries[turret.turrettype], turret);
    turret.owner thread remoteturret_setcarried(turret);
    waitframe();
  }
}

function remoteturret_disableplayerpickuponconnect(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    player waittill("spawned_player");
    turret.useownerobj disableplayeruse(player);
  }
}

function remoteturret_watchdismantle(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  foreach(player in level.players) {
    if(level.teambased) {
      if(player.team != self.team) {
        continue;
      }

      continue;
    }

    if(player != self) {}
  }

  thread remoteturret_disableplayerdismantleonconnect(turret);

  while(true) {
    turret.dismantleobj waittill("trigger", player);
    turret notify("kill_turret", 0, 1);
    break;
  }
}

function remoteturret_watchdamage(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  if(issharedfuncdefined("remote_turret", "monitorDamage")) {
    self[[getsharedfunc("remote_turret", "monitorDamage")]](turret);
  }

  turret.damagemonitored = 1;
}

function remoteturret_disableplayerdismantleonconnect(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    player waittill("spawned_player");

    if(level.teambased) {
      if(player.team != self.team) {
        continue;
      }
    }
  }
}

function remoteturret_empstarted(data) {
  if(isDefined(data.attacker)) {
    if(issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[getsharedfunc("player", "doScoreEvent")]]("disabled_sentry_gun");
    }

    if(issharedfuncdefined("remote_turret", "empStarted")) {
      self[[getsharedfunc("remote_turret", "empStarted")]]();
    }
  }

  function_9830ac9a0fbf0d6e();
}

function remoteturret_empcleared(isdeath) {
  if(isdeath) {
    return;
  }

  if(issharedfuncdefined("remote_turret", "empStarted")) {
    self[[getsharedfunc("remote_turret", "empCleared")]]();
  }

  if(isDefined(self.useobj)) {
    self.useobj enableplayeruse(self.useobj.owner);
    self.useobj.activeuseobject = 1;
  }

  if(istrue(self.isplaced)) {
    self setmode("sentry");
    self.owner thread function_2bd5e2012f429ae3(self);
    thread remoteturret_attacktargets(undefined, self.owner);
  }
}

function function_371131da10a20bb(data) {
  if(isDefined(data.attacker)) {
    if(issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[getsharedfunc("player", "doScoreEvent")]]("disabled_sentry_gun", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    }

    if(issharedfuncdefined("remote_turret", "empStarted")) {
      self[[getsharedfunc("remote_turret", "empStarted")]]();
    }
  }

  function_9830ac9a0fbf0d6e();
}

function function_9830ac9a0fbf0d6e() {
  if(isDefined(self.useobj)) {
    self.useobj disableplayeruse(self.useobj.owner);
    self.useobj.activeuseobject = 0;
  }

  self.owner notify("stopSentryFire");
  self.owner notify("remote_turret_empd");

  if(istrue(self.isbarrelspinning)) {
    self stopbarrelspin();
    self.isbarrelspinning = undefined;
  }

  self setmode("sentry_offline");
  self setscriptablepartstate("turret_mode", "turret_mode_sentry");

  if(istrue(self.var_ce4dc6c1d56eb0a9)) {
    self.owner remotecontrolturretoff(self);
    self.var_ce4dc6c1d56eb0a9 = undefined;
    self.owner.usingremote = undefined;
    self notify("remote_exit");

    if(istrue(self.owner.isjuggernaut)) {
      self.owner notify("remote_exit");
    }

    self setscriptablepartstate("lights", "daytime", 0);
    function_9cc5ca1b073338ab(self.owner);
    remoteturret_removeoverlay(self.owner);

    if(isDefined(self.owner)) {
      self.owner _switchtoweapon(self.owner.primaryweaponobj);
      self.owner enableweaponswitch();
      wait 1;

      if(isDefined(self) && isDefined(self.owner)) {
        self.owner val::reset("remote_turret", "usability");
        self.owner val::reset("remote_turret", "killstreaks");
        self.owner val::reset("remote_turret", "supers");
        self.owner val::reset("remote_turret", "reload");
        self.owner val::reset("remote_turret", "offhand_weapons");
        self.owner val::reset("remote_turret", "melee");
      }
    }
  }
}

function function_958fed8d4d1143fa(data) {
  if(issharedfuncdefined("remote_turret", "empStarted")) {
    self[[getsharedfunc("remote_turret", "empCleared")]]();
  }

  if(isDefined(self.useobj)) {
    self.useobj enableplayeruse(self.useobj.owner);
    self.useobj.activeuseobject = 1;
  }

  if(istrue(self.isplaced)) {
    self setmode("sentry");
    self.owner thread function_2bd5e2012f429ae3(self);
    thread remoteturret_attacktargets(undefined, self.owner);
  }
}

function function_a9d407dcc53c2a3d(var_9f1f082eeef5d90b) {
  self.turret notify("kill_turret", 1, 1);
}

function private function_1f85068748abaa9b(turret) {
  level endon("<dev string:xec>");
  self endon("<dev string:xfa>");
  turret endon("<dev string:x108>");
  wait 0.3;
  fakedata = spawnStruct();
  turret function_371131da10a20bb(fakedata);
  wait 4;
  turret function_958fed8d4d1143fa(fakedata);
}

function function_cc47405c2cd435e(data) {
  if(!istrue(self.ishaywire)) {
    self.ishaywire = 1;

    if(isDefined(data.attacker)) {
      if(issharedfuncdefined("remote_turret", "empStarted")) {
        self[[getsharedfunc("remote_turret", "empStarted")]]();
      }
    }

    if(isDefined(self.useobj)) {
      self.useobj disableplayeruse(self.useobj.owner);
      self.useobj.activeuseobject = 0;
    }

    if(isDefined(self.useownerobj)) {
      self.useownerobj hide();
      self.useownerobj.activeuseobject = 0;
    }

    self.owner notify("stopSentryFire");
    self.owner notify("remote_turret_empd");

    if(istrue(self.isbarrelspinning)) {
      self stopbarrelspin();
      self.isbarrelspinning = undefined;
    }

    self setmode("sentry_offline");
    self setscriptablepartstate("turret_mode", "turret_mode_sentry");

    if(istrue(self.var_ce4dc6c1d56eb0a9)) {
      self.owner remotecontrolturretoff(self);
      self.var_ce4dc6c1d56eb0a9 = undefined;
      self.owner.usingremote = undefined;
      self notify("remote_exit");

      if(istrue(self.owner.isjuggernaut)) {
        self.owner notify("remote_exit");
      }

      self setscriptablepartstate("lights", "daytime", 0);
      function_9cc5ca1b073338ab(self.owner);
      remoteturret_removeoverlay(self.owner);
      self.owner _switchtoweapon(self.owner.primaryweaponobj);
      self.owner enableweaponswitch();
      wait 1;
      self.owner val::reset("remote_turret", "usability");
      self.owner val::reset("remote_turret", "killstreaks");
      self.owner val::reset("remote_turret", "supers");
      self.owner val::reset("remote_turret", "reload");
      self.owner val::reset("remote_turret", "offhand_weapons");
      self.owner val::reset("remote_turret", "melee");
    }
  }
}

function function_fe21c57503ab070f(data) {
  if(issharedfuncdefined("remote_turret", "empStarted")) {
    self[[getsharedfunc("remote_turret", "empCleared")]]();
  }

  if(isDefined(self.useobj)) {
    self.useobj enableplayeruse(self.useobj.owner);
    self.useobj.activeuseobject = 1;
  }

  if(isDefined(self.useownerobj)) {
    self.useownerobj show();
    self.useownerobj.activeuseobject = 1;
  }

  if(istrue(self.isplaced)) {
    self setmode("sentry");
    self.owner thread function_2bd5e2012f429ae3(self);
    thread remoteturret_attacktargets(undefined, self.owner);
  }

  self.ishaywire = undefined;
}

function remoteturret_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    return;
  }

  self turretfireenable();
  self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
}

function function_aa2dc590a653d06e(owner) {
  self endon("death");

  while(true) {
    if(owner _isalive()) {
      self.ownerdied = undefined;
      break;
    }

    wait 0.1;
  }
}

function remoteturret_watchownerdeath(owner) {
  self endon("death");
  self endon("carried");

  while(true) {
    if(!owner _isalive()) {
      if(!istrue(self.ownerdied)) {
        self notify("remote_turret_ownerDeath");
        self.ownerdied = 1;
        thread function_aa2dc590a653d06e(owner);

        if(istrue(self.var_ce4dc6c1d56eb0a9) && istrue(self.isplaced) || istrue(owner.deployingremoteturret)) {
          owner remotecontrolturretoff(self);
          self setmode("sentry");
          self.var_ce4dc6c1d56eb0a9 = undefined;
          owner.usingremote = undefined;
          self notify("remote_exit");

          if(istrue(self.isjuggernaut)) {
            owner notify("remote_exit");
          }

          self.overheated = 0;
          self setscriptablepartstate("turret_mode", "turret_mode_sentry");
          self setscriptablepartstate("lights", "daytime", 0);
          function_13a319439a116d2(owner);
          remoteturret_removeoverlay(owner);
          owner _switchtoweapon(owner.primaryweaponobj);
          owner enableweaponswitch();
          owner val::reset("remote_turret", "allow_movement");
          owner val::reset("remote_turret", "usability");
          owner val::reset("remote_turret", "killstreaks");
          owner val::reset("remote_turret", "supers");
          owner val::reset("remote_turret", "reload");
          owner val::reset("remote_turret", "offhand_weapons");
          owner val::reset("remote_turret", "melee");
          thread remoteturret_attacktargets(undefined, owner);
        }

        owner thread function_2bd5e2012f429ae3(self);
      }
    }

    wait 0.1;
  }
}

function remoteturret_watchdeath(turret) {
  turret endon("carried");
  turret waittill("kill_turret", skipshutdown, wasdestroyed);
  turret notify("remote_turret_death");
  turret notify("death");
  waitframe();
  self.remoteturretactive = undefined;

  if(istrue(turret.var_ce4dc6c1d56eb0a9)) {
    turret remoteturret_removeoverlay(self);
    self remotecontrolturretoff(turret);
    turret.var_ce4dc6c1d56eb0a9 = undefined;
    self.usingremote = undefined;
    turret notify("remote_exit");

    if(istrue(self.isjuggernaut)) {
      self notify("remote_exit");
    }

    turret.overheated = 0;
    turret setscriptablepartstate("turret_mode", "turret_mode_sentry");
    turret setscriptablepartstate("lights", "daytime", 0);

    if(isDefined(self)) {
      _switchtoweapon(self.primaryweaponobj);
    }
  }

  if(isDefined(self)) {
    self enableweaponswitch();
    val::reset("remote_turret", "allow_movement");
    val::reset("remote_turret", "usability");
    val::reset("remote_turret", "killstreaks");
    val::reset("remote_turret", "supers");
    val::reset("remote_turret", "reload");
    val::reset("remote_turret", "offhand_weapons");
    val::reset("remote_turret", "melee");
    self.placedsentries[turret.turrettype] = array_remove(self.placedsentries[turret.turrettype], turret);
    remoteturret_setinactive(turret);
    turret thread function_9cc5ca1b073338ab(self);
    function_3650adfd6e0d1fb9(0);

    if(issharedfuncdefined("player", "printGameAction")) {
      self[[getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", self);
    }

    turret.streakinfo.expiredbydeath = istrue(wasdestroyed);
    scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(turret.streakinfo);
  }

  if(istrue(wasdestroyed)) {
    playkillstreakteamleaderdialog(turret.streakinfo.streakname, turret.streakinfo.streakname + "_teamleader_destroyed");
  }

  turret remoteturret_setturretmodel("destroyed");
  turret setturretowner(undefined);

  if(!istrue(skipshutdown)) {
    turret setscriptablepartstate("shutdown", "on");
    turret setscriptablepartstate("turret_carry_state", "off");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    turret setscriptablepartstate("explode", "regular");
  } else {
    turret setscriptablepartstate("explode", "violent");
  }

  level callback::callback("killstreak_finish_use", {
    #streakinfo: turret.streakinfo
  });

  if(isDefined(turret.damagemonitored)) {
    turret.damagemonitored = undefined;
  }

  if(isDefined(turret.killcament)) {
    turret.killcament delete();
  }

  if(isDefined(turret.useownerobj)) {
    turret.useownerobj delete();
  }

  if(isDefined(turret.useotherobj)) {
    turret.useotherobj delete();
  }

  if(isDefined(turret.colmodel)) {
    turret.colmodel delete();
  }

  if(isDefined(turret.minimapid)) {
    if(issharedfuncdefined("game", "returnObjectiveID")) {
      [[getsharedfunc("game", "returnObjectiveID")]](turret.minimapid);
    }

    turret.minimapid = undefined;
  }

  wait 0.2;
  turret delete();
}

function function_3eccd3cd75317e53(data) {
  self notify("kill_turret", 1, 1);
}

function remoteturret_delayscriptabledelete() {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

function remoteturret_watchtimeout(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(turret.timeout > 0) {
    if(istrue(turret.isbarrelspinning)) {
      turret stopbarrelspin();
      turret.isbarrelspinning = undefined;
    }

    timeoutpercentage = int(100 * turret.timeout / turret.maxtimeout);
    self setclientomnvar("ui_killstreak_countdown", timeoutpercentage);
    turret.timeout -= 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  playkillstreakteamleaderdialog(turret.streakinfo.streakname, turret.streakinfo.streakname + "_teamleader_timeout");
  turret notify("kill_turret", 0, 0);
}

function remoteturret_watchdisown(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  waittill_any_3("disconnect", "joined_team", "joined_spectators");
  turret notify("kill_turret", 0, 0);
}

function remoteturret_watchgameend(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  level waittill("game_ended");
  turret notify("kill_turret", 0, 0);
}

function remoteturret_setturretmodel(type) {
  turretmodel = undefined;

  if(type == "placed") {
    turretmodel = level.sentrysettings[self.turrettype].modelbaseground;
  } else {
    turretmodel = level.sentrysettings[self.turrettype].modeldestroyedground;
  }

  modeltype = getdvarint(@ "hash_e19e5d308effeda3", 1);

  if(!modeltype) {
    turretmodel = "<dev string:x111>";
  }

  assertex(isDefined(turretmodel), "<dev string:x12f>");
  self setModel(turretmodel);
}

function remoteturret_attacktargets(configoverride, player) {
  self.owner endon("<dev string:x177>");

  self endon("kill_turret");
  self endon("carried");
  self endon("enterRemote");
  self.owner endon("stopSentryFire");
  level endon("game_ended");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread turret_heatmonitor();
  thread turret_coolmonitor();

  while(true) {
    self waittill("turretstatechange");

    if(self isfiringturret()) {
      player thread function_57bec1aaf3404bf6();
      thread function_f38fae4f6dd4b035(player);
      thread remoteturret_burstfirestart(configoverride);
      continue;
    }

    self.heatlevel = 0;
    remoteturret_spindown();
    thread remoteturret_burstfirestop();
    thread function_13a319439a116d2(player);
    player thread function_ca5bd9a5609d8ba3();
    self setscriptablepartstate("turret_target_found", "off");
  }
}

function function_1223f321ae6ff9a5(configoverride) {
  self endon("<dev string:x191>");
  self endon("<dev string:x1a0>");
  level endon("<dev string:xec>");
  self.turrettarget = spawn("<dev string:x1ab>", self gettagorigin("<dev string:x1bb>") + anglesToForward(self gettagangles("<dev string:x1bb>") * 300));
  self.turrettarget.targeton = 0;
  self.turrettarget dontinterpolate();
  self.turrettarget thread function_8ffe5560e2df8a72(self);
  self.turrettarget thread function_818d215a79eecafe(self);
  turretconfig = undefined;

  if(isDefined(configoverride)) {
    turretconfig = configoverride;
  } else {
    turretconfig = level.sentrysettings[self.turrettype];
  }

  sentrymode = turretconfig.sentrymodeon;
  manualmode = "<dev string:x1c8>";
  turretmode = sentrymode;
  notifyon = 0;

  while(true) {
    if(getdvarint(@ "hash_c9bd691ce96079ac", 0) == 1) {
      if(!istrue(notifyon)) {
        self.owner notifyonplayercommand("<dev string:x177>", "<dev string:x1d9>");
        notifyon = 1;
      }

      self.owner waittill("<dev string:x177>");

      if(turretmode != manualmode) {
        self setmode(manualmode);
        turretmode = manualmode;
        starttrace = self.owner getvieworigin();
        endtrace = starttrace + anglesToForward(self.owner getplayerangles()) * 50000;
        trace = scripts\engine\trace::ray_trace(starttrace, endtrace, self.owner);
        endpos = undefined;

        if(isDefined(trace["<dev string:x1e9>"]) && trace["<dev string:x1e9>"] != "<dev string:x1f4>") {
          endpos = trace["<dev string:x204>"];
        }

        if(isDefined(endpos)) {
          thread function_ee5cbfd60227d0b8(endpos);
        }
      } else {
        function_c151e4a17d929b78();
        turretmode = sentrymode;
        self setmode(turretmode);
        thread remoteturret_attacktargets();
      }

      continue;
    }

    notifyon = 0;

    if(turretmode != sentrymode) {
      self.owner notifyonplayercommandremove("<dev string:x177>", "<dev string:x1d9>");
      function_c151e4a17d929b78();
      turretmode = sentrymode;
      self setmode(turretmode);
      thread remoteturret_attacktargets();
    }

    waitframe();
  }
}

function function_ee5cbfd60227d0b8(firepos) {
  self.owner endon("<dev string:x210>");
  self.owner endon("<dev string:x177>");
  self endon("<dev string:x191>");
  self endon("<dev string:x1a0>");
  level endon("<dev string:xec>");
  thread remoteturret_burstfirestop();
  self.turrettarget.origin = firepos;
  self settargetentity(self.turrettarget);
  self.turrettarget.targeton = 1;
  starttag = "<dev string:x226>";

  if(self.streakinfo.streakname == "<dev string:x23a>") {
    starttag = "<dev string:x248>";
  }

  endtag = "<dev string:x1bb>";
  wait 1;

  while(true) {
    var_30c9c9336ef2caaf = self gettagorigin(starttag);
    var_831cc1b8f4225351 = self gettagangles(starttag);
    thread drawsphere(var_30c9c9336ef2caaf, 2, 1, (0, 1, 1));
    thread drawline(var_30c9c9336ef2caaf, var_30c9c9336ef2caaf + anglesToForward(var_831cc1b8f4225351) * 1800, 1, (0, 1, 1));
    flashtagorigin = self gettagorigin(endtag);
    flashtagangles = self gettagangles(endtag);
    thread drawsphere(flashtagorigin, 2, 1, (1, 1, 0));
    thread drawline(flashtagorigin, flashtagorigin + anglesToForward(flashtagangles) * 1800, 1, (1, 1, 0));
    remoteturret_burstfirestart(undefined, undefined, 1);
    wait 1;
  }
}

function function_c151e4a17d929b78() {
  self cleartargetentity();
  thread remoteturret_burstfirestop();
  self.turrettarget.targeton = 0;
  self.owner notify("<dev string:x210>");
}

function function_8ffe5560e2df8a72(turret) {
  turret endon("<dev string:x191>");
  turret endon("<dev string:x1a0>");
  self endon("<dev string:x108>");
  level endon("<dev string:xec>");

  while(true) {
    if(istrue(self.targeton)) {
      sphere(self.origin, 20, (1, 1, 0), 0, 1);
    }

    waitframe();
  }
}

function function_818d215a79eecafe(turret) {
  turret endon("<dev string:x191>");
  turret endon("<dev string:x1a0>");
  self endon("<dev string:x108>");
  level endon("<dev string:xec>");
  turret waittill("<dev string:x108>");
  self delete();
}

function remoteturret_targetlocksound() {
  self endon("death");
  self setscriptablepartstate("turret_target_found", "target_found");
}

function remoteturret_spinup(configoverride) {
  if(!istrue(self.isbarrelspinning)) {
    self startbarrelspin();
    self.isbarrelspinning = 1;
  }

  while(self.momentum < configoverride.spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }

  thread remoteturret_targetlocksound();
}

function remoteturret_spindown() {
  self.momentum = 0;

  if(istrue(self.isbarrelspinning)) {
    self stopbarrelspin();
    self.isbarrelspinning = undefined;
  }
}

function remoteturret_burstfirestart(configoverride, maxroundsoverride, var_7a4f7bd11952e7bc) {
  self endon("death");
  self endon("kill_turret");
  self endon("carried");
  self endon("enterRemote");
  self endon("stop_shooting");
  self.owner endon("stopSentryFire");
  level endon("game_ended");
  turretconfig = undefined;

  if(isDefined(configoverride)) {
    turretconfig = configoverride;
  } else {
    turretconfig = level.sentrysettings[self.turrettype];
  }

  remoteturret_spinup(turretconfig);
  firetime = weaponfiretime(turretconfig.weaponinfo);
  minshots = turretconfig.burstmin;
  maxshots = turretconfig.burstmax;
  minpause = turretconfig.pausemin;
  maxpause = turretconfig.pausemax;
  lockstrength = turretconfig.lockstrength;

  while(true) {
    numshots = randomintrange(minshots, maxshots + 1);

    if(isDefined(maxroundsoverride)) {
      numshots = maxroundsoverride;
    }

    for(i = 0; i < numshots; i++) {
      self shootturret("tag_flash", lockstrength);
      self.streakinfo.shots_fired++;
      wait firetime;
    }

    if(istrue(var_7a4f7bd11952e7bc)) {
      break;
    }

    wait randomfloatrange(minpause, maxpause);
  }
}

function remoteturret_burstfirestop() {
  self notify("stop_shooting");
}

function function_7bd876f944b5caf3() {
  self endon("death");
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");

  while(true) {
    if(istrue(self.overheated)) {} else if(self.heatlevel > 0) {}

    wait 0.1;
  }
}

function turret_heatmonitor() {
  self.owner endon("<dev string:x177>");

  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  overheattime = level.sentrysettings[self.turrettype].overheattime;

  if(!isDefined(self.heatlevel)) {
    self.heatlevel = 0;
  }

  while(true) {
    if(self.heatlevel > overheattime) {
      self.overheated = 1;

      while(self.heatlevel) {
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    wait 0.05;
  }
}

function playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(getfx("sentry_overheat_mp"), self, "tag_flash");
    wait level.sentrysettings[self.turrettype].fxtime;
  }
}

function turret_coolmonitor() {
  self.owner endon("<dev string:x177>");

  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.heatlevel)) {
      self.heatlevel = 0;
    }

    if(self.heatlevel > 0) {
      if(isDefined(self.cooldownwaittime) && self.cooldownwaittime <= 0) {
        self.heatlevel = max(0, self.heatlevel - 0.05);
      } else {
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
      }
    }

    wait 0.05;
  }
}

function remoteturret_beepsounds() {
  self endon("death");
  self endon("carried");
  self endon("kill_turret");
  level endon("game_ended");

  while(true) {
    wait 3;

    if(self isfiringturret()) {
      waitframe();
      continue;
    }
  }
}

function function_1baea357653599af() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("entering");
  entmask = createentitytypemask(["etype_player", "etype_ai"]);

  while(true) {
    targetarray = getentitiesinradiusfrompartitiongrid(self.origin, 1575, entmask);

    foreach(ent in targetarray) {
      if(!isDefined(ent)) {
        continue;
      }

      if(isPlayer(ent) || isbot(ent)) {
        if(issharedfuncdefined("player", "isReallyAlive")) {
          if(![[getsharedfunc("player", "isReallyAlive")]](ent)) {
            continue;
          }
        }
      }

      if(isagent(ent) && !isalive(ent)) {
        continue;
      }

      if(level.teambased) {
        if(isDefined(ent.team) && ent.team == self.ownerteam) {
          continue;
        }
      } else if(ent == self.owner) {
        continue;
      }

      if(scripts\cp_mp\emp_debuff::is_empd()) {
        continue;
      }

      targetinfo = function_a8c3018671379cee(ent);

      if(!targetinfo.isinrange || !targetinfo.isvisible || !targetinfo.isindetectrange || !targetinfo.var_9ae205c4c40af967) {
        continue;
      }

      if(self.owner function_d326d254331ad16b(ent)) {
        continue;
      }

      if(istrue(self.markingtarget)) {
        continue;
      }

      params = function_1a5c1f370962e7bc(self.cameratype);
      function_b25c3111cbbcee44(ent, 3, "super_tac_camera");
    }
  }
}

function function_a8c3018671379cee(target) {
  info = spawnStruct();
  info.isvisible = function_a13b737dd0cea460(target);
  info.var_9ae205c4c40af967 = function_f232be2b19471805(target);
  info.isinrange = remoteturret_isinmarkingrange(target);
  info.isindetectrange = remoteturret_isindetectrange(target);

  if(isDefined(self.pilot)) {}

  return info;
}

function private remoteturret_istargetinreticle(scantarget, scanfov, var_5e43b44751d01b1a) {
  if(!isDefined(scantarget)) {
    return 0;
  }

  inreticle = 0;
  targetorigin = scantarget.origin;
  scanpoints = [targetorigin];
  var_c3d9e0b30c6f14a4 = distancesquared(self getvieworigin(), scantarget.origin);
  isusingextrapoints = 0;

  if(var_c3d9e0b30c6f14a4 <= 2) {
    var_5e43b44751d01b1a *= getdvarfloat(@ "hash_20c9852b3129de04", 2.5);
    isusingextrapoints = 1;
  }

  if(isPlayer(scantarget)) {
    istargethanging = scantarget ishanging();
    headpos = scantarget scripts\cp_mp\utility\player_utility::getstancetop();
    centerpos = scantarget scripts\cp_mp\utility\player_utility::getstancecenter();
    scanpoints = [headpos, centerpos];

    if(!istargethanging) {
      scanpoints = array_add(scanpoints, targetorigin);
    }

    if(isusingextrapoints) {
      var_102502c44898b35c = (headpos + centerpos) / 2;
      extrapoints = [var_102502c44898b35c];

      if(!istargethanging) {
        var_264b006395220d6 = (centerpos + targetorigin) / 2;
        extrapoints = array_add(extrapoints, var_264b006395220d6);
      }

      scanpoints = array_combine(scanpoints, extrapoints);
    }
  } else if(isagent(scantarget)) {
    centerpos = scantarget scripts\cp_mp\utility\player_utility::getstancecenter();
    headpos = scantarget scripts\cp_mp\utility\player_utility::getstancetop();
    scanpoints = [targetorigin + (0, 0, 1), centerpos, headpos];

    if(isusingextrapoints) {
      var_264b006395220d6 = (centerpos + targetorigin) / 2;
      var_102502c44898b35c = (headpos + centerpos) / 2;
      extrapoints = [var_264b006395220d6, var_102502c44898b35c];
      scanpoints = array_combine(scanpoints, extrapoints);
    }
  }

  foreach(point in scanpoints) {
    if(self worldpointinreticle_circle(point, scanfov, var_5e43b44751d01b1a)) {
      inreticle = 1;
      break;
    }
  }

  return inreticle;
}

function remoteturret_isinmarkingrange(target) {
  if(!isDefined(target)) {
    return false;
  }

  params = function_1a5c1f370962e7bc(self.cameratype);
  detectrangesq = 2480625;

  if(istrue(self.isunderwater) || istrue(target isswimmingunderwater())) {
    detectrangesq = 619369;
  }

  return distancesquared(self.origin, target.origin) < detectrangesq;
}

function remoteturret_isindetectrange(target) {
  if(!isDefined(target)) {
    return false;
  }

  params = function_1a5c1f370962e7bc(self.cameratype);
  detectrangesq = 2480625;

  if(istrue(self.isunderwater) || istrue(target isswimmingunderwater())) {
    detectrangesq = 619369;
  }

  return distancesquared(self.origin, target.origin) < detectrangesq;
}

function function_a13b737dd0cea460(target) {
  if(!isDefined(target)) {
    return 0;
  }

  icansee = 0;
  tracecontents = physics_createcontents(["physicscontents_itemclip", "physicscontents_item", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_ainosight"]);
  camorigin = undefined;

  if(isDefined(self.pilot)) {
    camorigin = self.pilot getvieworigin();
  } else {
    camorigin = self.origin;
  }

  defaultorigin = target.origin;
  tracepoints = [defaultorigin];

  if(isPlayer(target)) {
    headpos = (0, 0, 0);

    if(issharedfuncdefined("player", "isReallyAlive")) {
      headpos = target[[getsharedfunc("player", "getStanceTop")]]();
    }

    centerpos = (0, 0, 0);

    if(issharedfuncdefined("player", "isReallyAlive")) {
      centerpos = target[[getsharedfunc("player", "getStanceCenter")]]();
    }

    tracepoints = [headpos, centerpos, defaultorigin];
  } else if(isagent(target)) {
    tracepoints = [defaultorigin + (0, 0, 1)];
  }

  ignorelist = [self, target];
  vehicle = target getvehicle();

  if(isDefined(vehicle)) {
    ignorelist[ignorelist.size] = vehicle;
    vehiclechildren = vehicle getlinkedchildren(1);

    foreach(child in vehiclechildren) {
      ignorelist[ignorelist.size] = vehicle;
    }
  }

  icansee = 0;

  for(i = 0; i < tracepoints.size; i++) {
    trace = scripts\engine\trace::ray_trace(camorigin, tracepoints[i], ignorelist, tracecontents, 1);

    if(trace["hittype"] == "hittype_none") {
      icansee = 1;
      break;
    }
  }

  return icansee;
}

function function_f232be2b19471805(target) {
  if(!isDefined(target)) {
    return 0;
  }

  camangles = self gettagangles("tag_player");
  var_51743d62f4cf524e = self gettagorigin("tag_player");

  if(isDefined(self.pilot)) {
    camangles = self.pilot getplayerangles();
    var_51743d62f4cf524e = self.pilot getvieworigin();
  }

  camfwdvec = anglesToForward(camangles);
  defaultorigin = target.origin;
  headpos = (0, 0, 0);

  if(issharedfuncdefined("player", "isReallyAlive")) {
    headpos = target[[getsharedfunc("player", "getStanceTop")]]();
  }

  centerpos = (0, 0, 0);

  if(issharedfuncdefined("player", "isReallyAlive")) {
    centerpos = target[[getsharedfunc("player", "getStanceCenter")]]();
  }

  tracepoints = [headpos, centerpos, defaultorigin];
  var_9ae205c4c40af967 = 0;

  foreach(point in tracepoints) {
    cam2targetvec = point - var_51743d62f4cf524e;
    dotangle = scripts\engine\math::anglebetweenvectors(camfwdvec, cam2targetvec);
    var_878f0eb51ab6a646 = scripts\engine\math::anglebetweenvectors(camfwdvec, (0, 0, 1));
    var_cea5805c08f245d2 = scripts\engine\math::anglebetweenvectors(cam2targetvec, (0, 0, 1));

    if(isDefined(self.pilot)) {
      var_e077f4a68ed9a464 = distancesquared(var_51743d62f4cf524e, point);

      if(var_e077f4a68ed9a464 > 10) {
        if(abs(abs(var_878f0eb51ab6a646) - abs(var_cea5805c08f245d2)) > getdvarfloat(@ "hash_77f60c1216fca977", 19)) {
          return var_9ae205c4c40af967;
        }
      }
    }

    if(dotangle <= getdvarfloat(@ "hash_a20d9fbeab627f6", 31)) {
      var_9ae205c4c40af967 = 1;
    }
  }

  return var_9ae205c4c40af967;
}

function private function_d326d254331ad16b(target) {
  if(!isDefined(target)) {
    return false;
  }

  markcluster = function_bcc24554453f6d67(self);

  if(!isDefined(markcluster)) {
    return false;
  }

  markdata = markcluster[target getentitynumber()];

  if(!isDefined(markdata)) {
    return false;
  }

  return istrue(markdata.reconmarked);
}

function function_bcc24554453f6d67(player) {
  if(!isDefined(player)) {
    return;
  }

  if(level.teambased) {
    if(!isDefined(level.teammarkedents) || !isDefined(level.teammarkedents[player.team])) {
      return;
    }

    if(shouldmodesetsquads()) {
      if(isDefined(level.teammarkedents[player.team][player.sessionsquadid])) {
        return level.teammarkedents[player.team][player.sessionsquadid];
      } else {
        return;
      }
    } else {
      return level.teammarkedents[player.team];
    }

    return;
  }

  return player.markedents;
}

function function_1a5c1f370962e7bc(cameratype) {
  params = level.var_bb0266f422d9afa3[cameratype];
  assertex(isDefined(params), "<dev string:x25e>" + cameratype);
  return params;
}

function private function_b25c3111cbbcee44(target, sensorduration, supername) {
  sensordata = function_cb0d2df7f050aa8e(target);

  if(!isDefined(sensordata)) {
    return;
  }

  self playsoundtoplayer("ui_camera_proximity_alert", self.owner, self);
  function_487185d4893d5f85(supername);
  self.owner thread function_e793fcf03710f124(self, self.ownerindex, 2, undefined, 3.25);
  thread function_2a98f46d2b757869(sensordata, sensorduration, supername);
}

function private function_cb0d2df7f050aa8e(target) {
  if(!isDefined(self.var_dae7e92e87a31e4)) {
    self.var_dae7e92e87a31e4 = [];
  }

  if(isDefined(self.var_dae7e92e87a31e4[target getentitynumber()])) {
    return;
  }

  sensordata = spawnStruct();
  sensordata.target = target;
  sensordata.entnum = target getentitynumber();
  self.var_dae7e92e87a31e4[target getentitynumber()] = sensordata;
  return sensordata;
}

function private function_487185d4893d5f85(supername) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }

    function_768370d8be2da2d2(player, undefined, supername);
  }
}

function function_9553839f6b149375() {
  params = function_1a5c1f370962e7bc("tacCam");
  self.headiconbox = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "jup_hud_icon_killstreaks_remote_turret", 5, 1, 1000, 100, undefined, 1);
  self.headiconfaction = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, undefined, 1);
  self.headiconalert = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "icon_ping_warning", 5, 1, 1000, 100, undefined, 1);
  function_487185d4893d5f85("tacCam");
}

function function_768370d8be2da2d2(player, unset, supername) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.owner)) {
    return;
  }

  if(!isDefined(player)) {
    return;
  }

  idbox = self.headiconbox;

  if(!isDefined(idbox)) {
    return;
  }

  idfaction = self.headiconfaction;

  if(!isDefined(idfaction)) {
    return;
  }

  idalert = self.headiconalert;

  if(!isDefined(idalert)) {
    return;
  }

  isfriendly = scripts\cp_mp\utility\player_utility::isfriendly(self.owner.team, player);
  usingcamerasuper = function_10aa38d58090b230(player, supername);

  if(isfriendly) {
    if(istrue(unset)) {
      function_58672d602d2120d3(player);
      return;
    }

    if(function_9b936bec0466b8b5()) {
      function_f38fae4f6dd4b035(player);
      return;
    }

    if(usingcamerasuper) {
      if(istrue(player.isusingcamera)) {
        function_9cc5ca1b073338ab(player);
        return;
      }

      function_13a319439a116d2(player);
      return;
    } else {
      function_58672d602d2120d3(player);
    }

    return;
  }

  function_9cc5ca1b073338ab(player);
}

function private function_10aa38d58090b230(player, supername) {
  if(isDefined(player.super) && player.super.staticdata.ref == supername) {
    return 1;
  }

  return 0;
}

function private function_9b936bec0466b8b5() {
  if(!isDefined(self.var_dae7e92e87a31e4)) {
    return false;
  }

  if(self.var_dae7e92e87a31e4.size > 0) {
    return true;
  }

  return false;
}

function private function_f38fae4f6dd4b035(player) {
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headiconalert, player);
}

function private function_9cc5ca1b073338ab(player) {
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconalert, player);
}

function private function_13a319439a116d2(player) {
  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconalert, player);
}

function private function_58672d602d2120d3(player) {
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconalert, player);
}

function function_e793fcf03710f124(camera, index, status, forcestate, var_be632e8c9259a360) {
  if(!isDefined(self.var_2d5baa13a621c5eb)) {
    self.var_2d5baa13a621c5eb = [];
  }

  struct = spawnStruct();
  struct.camera = camera;
  struct.index = index;
  struct.status = status;
  struct.forcestate = istrue(forcestate);
  struct.var_be632e8c9259a360 = ter_op(isDefined(var_be632e8c9259a360), var_be632e8c9259a360, 0);
  self.var_2d5baa13a621c5eb[self.var_2d5baa13a621c5eb.size] = struct;
  thread function_d094908c5788a3e9();
}

function function_d094908c5788a3e9() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("tacticalCamera_allCamerasRemoved");
  self notify("sentryTurret_statusQueue");
  self endon("sentryTurret_statusQueue");

  if(istrue(level.gameended) || !isDefined(self)) {
    return;
  }

  while(isDefined(self.var_2d5baa13a621c5eb) && self.var_2d5baa13a621c5eb.size > 0) {
    waitframe();
    struct = array_get_first_item(self.var_2d5baa13a621c5eb);
    self notify("personal_camera_status_updated", struct.camera, struct.index, struct.status, struct.forcestate, struct.var_be632e8c9259a360);
    self.var_2d5baa13a621c5eb = array_remove(self.var_2d5baa13a621c5eb, struct);
  }
}

function private function_2a98f46d2b757869(sensordata, sensorduration, supername) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  wait sensorduration;
  function_d27569772a3ad7d7(sensordata);
  function_487185d4893d5f85(supername);
}

function private function_d27569772a3ad7d7(sensordata) {
  if(isDefined(self.var_dae7e92e87a31e4[sensordata.entnum])) {
    self.var_dae7e92e87a31e4[sensordata.entnum] = undefined;
  }
}

function function_57bec1aaf3404bf6() {
  self setclientomnvar("ui_remote_turret_status", 2);
}

function function_ca5bd9a5609d8ba3() {
  self setclientomnvar("ui_remote_turret_status", 1);
}

function remoteturret_applyoverlay(player) {
  player _setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
  player setclientomnvar("ui_killstreak_health", 0);
}

function remoteturret_removeoverlay(player) {
  player _setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
}

function function_45456bb78fa8eb2d(printmsg) {
  if(getdvarint(@ "hash_2da6e96d161f55bc", 0) == 1) {
    print("<dev string:x290>" + printmsg);
  }
}

# /