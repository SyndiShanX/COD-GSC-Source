/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\killstreaks\remote_turret.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\killstreaks\manual_turret;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace remote_turret;

function autoexec main() {
  killstreak_shared::registerkillstreakinitfunction(getxhash("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd"), &init);
}

function private init() {
  if(utility::issharedfuncdefined(#"remote_turret", #"init")) {
    [[utility::getsharedfunc(#"remote_turret", #"init")]]();
  }

  if(utility::issharedfuncdefined(#"remote_turret", #"initsentrysettings")) {
    [[utility::getsharedfunc(#"remote_turret", #"initsentrysettings")]]();
  }

  killstreak_utility::registervisibilityomnvarforkillstreak("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xb8\"", 16);

  setdevdvarifuninitialized(@ "hash_c9bd691ce96079ac", 0);
  setdevdvarifuninitialized(@ "hash_e19e5d308effeda3", 1);
}

function function_61ee2656359c99e6(streakinfo, switchresult, weaponobj) {
  if(!istrue(switchresult)) {
    killstreakdeploy::getridofkillstreakdeployweapon(weaponobj);
  }
}

function tryuseremoteturret(streakname) {
  streakinfo = killstreak_utility::createstreakinfo(streakname, self);
  return function_ddeff3c3d1d9e09d(streakinfo);
}

function function_ddeff3c3d1d9e09d(streakinfo) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  if(!isDefined(streakinfo.weaponname)) {
    streakinfo.weaponname = "\xf60\x1a\xe1\xa8^i}sX\xaf *\xfa1\xe7P\xefe\x86\x16B\xfe";
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      self.bgivensentry = 0;
      return false;
    }
  }

  weapon_utility::saveweaponstates();
  endonnotify = "%_#\xff\xab\xf3\x04d$\xa6\x12\xd2\x0f\x98\xefU\xc7\x7f\xd4\xceZr\xf6";
  weaponobj = makeweapon("\xf60\x1a\xe1\xa8^i}sX\xaf *\xfa1\xe7P\xefe\x86\x16B\xfe");

  if(utility::issharedfuncdefined(#"weapons", #"watchforplacementfirestate")) {
    self thread[[utility::getsharedfunc(#"weapons", #"watchforplacementfirestate")]](streakinfo, endonnotify, weaponobj);
  }

  deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, weaponobj, 1, undefined, undefined, &function_61ee2656359c99e6);

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

  turret = remoteturret_create("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", streakinfo);

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

  turret emp_debuff::set_start_emp_callback(&remoteturret_empstarted);
  turret emp_debuff::set_clear_emp_callback(&remoteturret_empcleared);

  if(istrue(level.var_7b4bb0dc04a04f9a)) {
    turret.ksempapplycallback = &function_23627b606a0e4a96;
  }

  if(istrue(level.var_7b4bb0dc04a04f9a)) {
    turret.ksempclearcallback = &function_8f902c79295c9943;
  }

  remoteturret_setplaced(turret, marker);

  if(utility::issharedfuncdefined(#"remote_turret", #"munitionused")) {
    self[[utility::getsharedfunc(#"remote_turret", #"munitionused")]]();
  }

  thread function_f27c5be4748f4832(turret);
  self.remoteturretactive = 1;
  return true;
}

function function_3f0c0252a31bb1af(owner) {
  if(!isDefined(owner) || !isDefined(owner.var_70a0dbd8b500a3c7)) {
    return;
  }

  if(isDefined(owner.var_70a0dbd8b500a3c7[self.streakinfo.streakname])) {
    owner.var_70a0dbd8b500a3c7[self.streakinfo.streakname] delete();
  }
}

function function_f27c5be4748f4832(turret) {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  turret endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    utility::waittill_any("W\xeb\x96\x98\xb8\xbb\x92\x06rn\xe8\x99N\xbd\xf2?\x94Y\xdd\xc01\xa2", "\xbc\x1b\x8e\x1d@\x06\xd9\x91\xffx\x9e\xc2\xd3", "\x97u\xb7\xe5\xd4\xa3(\xe2\xf4\x12\x9e\xe3\xe32\xcc\x99}5");
    val::set("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "`\x16\xae\xa2\xe4t\x187\xe7", 0);
    wait 2;
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "`\x16\xae\xa2\xe4t\x187\xe7");
  }
}

function remoteturret_watchplacement(turret, streakinfo, ignorecancel, var_f1eb3aefbe2f2c0c) {
  self.bgivensentry = 1;
  thread remoteturret_delayplacementinstructions(var_f1eb3aefbe2f2c0c);
  marker = undefined;

  if(utility::issharedfuncdefined(#"remote_turret", #"watchforplayerenteringlaststand")) {
    self thread[[utility::getsharedfunc(#"remote_turret", #"watchforplayerenteringlaststand")]]();
  }

  if(utility::issharedfuncdefined(#"remote_turret", #"gettargetmarker")) {
    marker = self[[utility::getsharedfunc(#"remote_turret", #"gettargetmarker")]](streakinfo, ignorecancel);
  }

  self notify("\xdf[\xffV\xb39C\xbc\xe8\x83h\xb0\xdfZ;\xd4\xe1l`\xf0~\x97\xaa\x1e%");

  if(!(isDefined(marker) && isDefined(marker.location))) {
    if(player_utility::_isalive()) {
      killstreak_utility::killstreak_switchbacklastweapon("\xf60\x1a\xe1\xa8^i}sX\xaf *\xfa1\xe7P\xefe\x86\x16B\xfe");
    }

    return undefined;
  }

  turret thread manual_turret::manualturret_disablefire(self, 1, 1);

  if(self hasweapon("\xf60\x1a\xe1\xa8^i}sX\xaf *\xfa1\xe7P\xefe\x86\x16B\xfe")) {
    thread killstreak_utility::killstreak_switchbacklastweapon("\xf60\x1a\xe1\xa8^i}sX\xaf *\xfa1\xe7P\xefe\x86\x16B\xfe", 1, 1);
  }

  delayspawntime = 0.85;
  hostmigration::hostmigration_waitlongdurationwithpause(delayspawntime);
  params = spawnStruct();
  params.player = self;
  callback::callback("r\xac\xad\xf6GV\xaf:\xd59\xc9\xb2:\xbe\x91\xac\x83\xc6\xde^\xcad", params);
  return marker;
}

function remoteturret_delayplacementinstructions(delaytime) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\xdf[\xffV\xb39C\xbc\xe8\x83h\xb0\xdfZ;\xd4\xe1l`\xf0~\x97\xaa\x1e%");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  self setclientomnvar("4g\xa2)W\xb7O\x8e\x1e3T\\\xd0\xaa\x13?\xfc\x9b|", 1);
  thread manual_turret::manualturret_clearplacementinstructions("\x1e\xfd\xd1\xa2\a");
  thread manual_turret::manualturret_clearplacementinstructions("\xdf[\xffV\xb39C\xbc\xe8\x83h\xb0\xdfZ;\xd4\xe1l`\xf0~\x97\xaa\x1e%");
}

function remoteturret_create(turrettype, streakinfo) {
  config = level.sentrysettings[turrettype];
  turret = spawnturret("?\x96%o2\x88V\xd4\x98\a\xdc", self.origin, level.sentrysettings[turrettype].weaponinfo);
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
  turret.var_6e232adf75ffe7b9 = 0;

  if(utility::issharedfuncdefined(#"remote_turret", #"attachxrays")) {
    turret = [[utility::getsharedfunc(#"remote_turret", #"attachxrays")]](turret);
  }

  var_4d832f406c4efa72 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_4d832f406c4efa72) {
    turret.timeout = 9999;
  } else if(isdvardefined(@ "hash_d17291ec1b4e806e")) {
    turret.timeout = getdvarint(@ "hash_d17291ec1b4e806e");
  }

  if(!isDefined(turret.timeout)) {
    turret.timeout = 120;
  }

  turret.maxtimeout = turret.timeout;
  turret.carriedby = self;
  turret remoteturret_setturretmodel("& 7\xf7r\x8f3");
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
      turret setconvergencetime(0.6, "\x84K\x8f\xddK");
      turret setconvergencetime(0.6, "\xf6\x9d\xfc");
      turret setconvergenceheightpercent(0.65);
      turret setdefaultdroppitch(-89);
      break;
  }

  turret setturretmodechangewait(1);
  turret emp_debuff::allow_emp(0);
  killcamforward = anglesToForward(turret.angles);
  killcampos = turret gettagorigin("4\xfc\xa51\xc7\xf6\tc\bP") + (0, 0, 10);
  killcampos -= killcamforward * 20;
  killcament = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", killcampos);
  killcament linkTo(turret);
  turret.killcament = killcament;
  turret.colmodel = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel("R\x15\x9es\xdd\x18\xddJ.\xf85\xb8\xc2#u\xa8\x0end\x16\x81W\xfc\x1f\x9c\xd0\xe7D\xaa,\xa0iA\x9dk\xd3R");
  turret.colmodel dontinterpolate();
  turret.colmodel hide();
  turret function_30ca9f4456ec9394();
  turret function_3f0c0252a31bb1af(self);
  turret.var_3885669a0c1159d0 = [];
  return turret;
}

function function_83cec24489b6954c(var_cfd71ffcbe8030fd, var_ee0e2ce4e8574966, shouldstack) {
  self.var_3885669a0c1159d0[self.var_3885669a0c1159d0.size] = var_cfd71ffcbe8030fd;

  if(shouldstack) {
    self function_123f5617298001a0(self.var_3885669a0c1159d0.size * var_ee0e2ce4e8574966);
    return;
  }

  self function_123f5617298001a0(var_ee0e2ce4e8574966);
}

function function_159a1356ef00f249(var_cfd71ffcbe8030fd, var_ee0e2ce4e8574966, shouldstack) {
  if(arraycontains(self.var_3885669a0c1159d0, var_cfd71ffcbe8030fd)) {
    self.var_3885669a0c1159d0 = arrayremove(self.var_3885669a0c1159d0, var_cfd71ffcbe8030fd);

    if(self.var_3885669a0c1159d0.size <= 0) {
      self function_123f5617298001a0(1);
      return;
    }

    if(shouldstack) {
      self function_123f5617298001a0(self.var_3885669a0c1159d0.size * var_ee0e2ce4e8574966);
    }
  }
}

function remoteturret_setplaced(turret, marker) {
  bundle = level.streakglobals.streakbundles["\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd"];
  config = level.sentrysettings[turret.turrettype];
  turret remoteturret_setturretmodel("& 7\xf7r\x8f3");

  if(!isDefined(self.placedsentries)) {
    self.placedsentries = [];
  }

  if(!isDefined(self.placedsentries[turret.turrettype])) {
    self.placedsentries[turret.turrettype] = [];
  }

  if(istrue(turret.shouldsplash)) {
    if(utility::issharedfuncdefined(#"sound", #"playkillstreakdeploydialog")) {
      self[[utility::getsharedfunc(#"sound", #"playkillstreakdeploydialog")]](turret.streakinfo.streakname);
    }

    splashname = config.teamsplash;

    if(utility::issharedfuncdefined(#"hud", #"teamplayercardsplash")) {
      level thread[[utility::getsharedfunc(#"hud", #"teamplayercardsplash")]](splashname, self);
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
  turret setscriptablepartstate("WX\xaa\th\r\x87.\xbfR\xa5\xe7NE&l\x05>", "\v\xc7\xe6W\x91\x13}\x01\x1f\\7\xe7");
  turret setscriptablepartstate("\x8f\xf9&\x13\xd4\xeb", "O\x8c-\x87\xb3`\x14", 0);
  turret.colmodel show();
  turret.colmodel.angles = turret.angles;
  turret.colmodel.origin = turret.origin;
  turret.colmodel linkTo(turret);
  turreticon = bundle.minimapicon;

  if(utility::issharedfuncdefined(#"game", #"createobjective")) {
    turret.minimapid = turret.colmodel[[utility::getsharedfunc(#"game", #"createobjective")]](turreticon, turret.team, undefined, 1, 1);
  }

  turretcount = self.placedsentries[turret.turrettype].size;

  if(turretcount + 1 > 1) {
    self.placedsentries[turret.turrettype][0] notify("(@\xe6\x83\x86\x1b\x19\xbaK\x1es", 0, 0);
  }

  headiconoffset = 70;

  if(utility::issharedfuncdefined(#"killstreak", #"addtoactivekillstreaklist")) {
    turret[[utility::getsharedfunc(#"killstreak", #"addtoactivekillstreaklist")]](turret.turrettype, "Z\xd2\x8d6\xdct'+\x85m\xebG\xe4\xdbu\xb9F", self, 0, 1, headiconoffset, "S\x9c\xe1\x10\x06\xea\x1e");
  }

  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeon);
  hinttag = "\x8cd\xdc\x11\xeat\x82\xf8\x87%l\x03\x1d";
  hintpos = turret gettagorigin(hinttag);

  if(!isDefined(turret.useownerobj)) {
    if(utility::issharedfuncdefined(#"remote_turret", #"createhintobject")) {
      turret.useownerobj = [[utility::getsharedfunc(#"remote_turret", #"createhintobject")]](hintpos, "\xb2\xd3\xaffR\xcf\xddI1\xc0o", undefined, config.ownerusehintstring, undefined, undefined, "\xf1\xba\x8f\x9d");
    }
  } else {
    hintpos = turret gettagorigin(hinttag);
    turret.useownerobj function_adbe50b70b740c89(1);
    turret.useownerobj dontinterpolate();
    turret.useownerobj.origin = hintpos;
  }

  turret.useownerobj linkTo(turret, hinttag);

  foreach(guy in level.players) {
    if(guy != turret.owner) {
      turret.useownerobj disableplayeruse(guy);
    }
  }

  turret killstreak_utility::function_4d1113bf25a8a59b(turret.streakinfo.streakname, self, &"killstreaks_hints/remote_turret_use", 1);
  turret thread function_68cc62690f3e1750();

  if(utility::issharedfuncdefined(#"game", #"handlemovingplatforms")) {
    data = spawnStruct();
    data.deathoverridecallback = &function_29d11b3f112bf406;

    if(isDefined(turret.moving_platform)) {
      data.linkparent = turret.moving_platform;
      data.linkoffset = turret.moving_platform_offset;
      data.angleoffset = turret.moving_platform_angles_offset;

      if(isDefined(level.wztrain_info) && train_utility::is_train_ent(turret.moving_platform)) {
        data.plantedontrain = 1;
      }
    }

    turret thread[[utility::getsharedfunc(#"game", #"handlemovingplatforms")]](data);
  }

  turret emp_debuff::allow_emp(1);

  if(utility::issharedfuncdefined(#"game", #"registersentient")) {
    turret[[utility::getsharedfunc(#"game", #"registersentient")]]("\xe4\x169\"\xc7\xefQ\x0e\xce\x8dt\xc8\xb2a\x97\xca\x15", self);
  }

  if(!istrue(turret.owner.ksempd)) {
    turret remoteturret_empupdate();
    turret thread remoteturret_attacktargets(undefined, self);
  }

  turret thread function_699c77cf97fe3888();

  turret thread remoteturret_beepsounds();
  function_409faf88af4e7264(killstreak_utility::function_fa41958bc16a88a3("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd"));
  function_f74f3d18f79a358a();
  thread remoteturret_delaydeletemarker(turret, marker);
  thread remoteturret_watchpickup(turret);
  thread remoteturret_disableplayeruseonconnect(turret, turret.useownerobj);

  if(!istrue(turret.owner.ksempd)) {
    thread function_d2691b3bc103a08a(turret);
  }

  turret thread remoteturret_watchownerdeath(self);

  if(!istrue(turret.damagemonitored)) {
    thread remoteturret_watchdamage(turret);
  }

  thread remoteturret_watchdeath(turret);
  thread remoteturret_watchtimeout(turret);
  thread remoteturret_watchdisown(turret);
  thread remoteturret_watchgameend(turret);
  turret function_cc649f2bff7a786f(self);
  turret.isplaced = 1;
  self.placedsentries[turret.turrettype][turretcount] = turret;
  turret notify("\x02\x9d\v\xf1\xb1|%_\x9b{)\xbb\xa3V\xfc\x80\x03\xe3o7K\xcd\xd6");
  turret killstreak_utility::function_e52af787f6d545ce(#"hash_eafb9a6b88def4ca", turret.origin, turret.team, turret.owner);
}

function function_409faf88af4e7264(killstreakid) {
  assert(isDefined(killstreakid), "<dev string:x24>");

  if(killstreakid == 0) {
    self setclientomnvar("N\xb8\x9f\xb7\x9c\xe0vttb\xf2\x8e\xb6\x87e\x95\xce\x8e54\xcf\xd6yd", killstreakid);
    self.parkedwidgetid = undefined;
    return;
  }

  self setclientomnvar("N\xb8\x9f\xb7\x9c\xe0vttb\xf2\x8e\xb6\x87e\x95\xce\x8e54\xcf\xd6yd", killstreakid);
  self.parkedwidgetid = killstreakid;
}

function function_68cc62690f3e1750() {
  self notify("\x99\xe2\xd7c\xa9\x0e\xfed\x10\xbb\x7f(\x10\xe3\x82\x99\x04n");
  self endon("\x99\xe2\xd7c\xa9\x0e\xfed\x10\xbb\x7f(\x10\xe3\x82\x99\x04n");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  self endon("S\x9c\xe1\x10\x06\xea\x1e");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self.useobj enableplayeruse(self.owner);
  self.useobj setuseholdduration(500);
  useobjdisabled = 0;

  while(true) {
    if(istrue(self.owner utility::isusingremote()) && !useobjdisabled && self.owner.usingremote != "\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd") {
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

function function_d2691b3bc103a08a(turret) {
  self endon("\x9cV\xb6{\xa3e}\xd1\xba'9\xca\x1d\xf5V[\xe0\xc8");
  turret endon("\x18\x12\x05\x90w\x16\xa0\xd4\xd3_|:(\xbe\x99\x05/%\x14");
  turret endon("C\x84\"[P\xd9TTC9\xbaG\xff\xbb\x89\xd3\xf2w\xb5\xad\xd3Br\xf3");
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  turret.useobj waittill("\x91`\xb1\xe7T\x97>", player);

  if(!function_89fde055c308989c()) {
    thread function_d2691b3bc103a08a(turret);
    return;
  }

  if(istrue(turret.isplaced) && !istrue(turret.owner.ksempd) && !istrue(utility::isusingremote()) && function_89fde055c308989c()) {
    self.deployingremoteturret = 1;
    self disableweaponswitch();

    if(istrue(turret.isbarrelspinning)) {
      turret stopbarrelspin();
      turret.isbarrelspinning = undefined;
    }

    val::set("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xd56a\x9b\xba$Do]uE\xb6\x9b1", 0);
    val::set("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "`\x16\xae\xa2\xe4t\x187\xe7", 0);
    val::set("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xe1P+\x1a \xe4\xd7-\xeel]", 0);
    val::set("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xaf\xd7\xe5h\xeb+", 0);
    val::set("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xc9\xca\x1boX\x8c", 0);
    val::set("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", 0);
    val::set("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "mV\x8d+e", 0);
    self notify("C0J\xc0\\8D\xd8\xf8I\x8e\xfc");
    turret setscriptablepartstate("vr-\x88\x9a9_NW9\x1b", "M\xac}q\xbaLDn\xc0\x12J\xc0vZ?\xd6\x8bAm\x04\xba\xff");
    turret remoteturret_spindown();
    turret thread remoteturret_burstfirestop();
    turret thread function_cc649f2bff7a786f(self);
    thread function_f74f3d18f79a358a();
    turret setmode("\xda\x13\x17\xa2q\xf0\xfb\xf8w\xe6\xe5qh\xe9");
    turret notify("o\xab\x19\xd7\xed\xf5\xb4$,\xf0\t");
    turret thread function_f51b6a446a1764a(self);
    thread function_31a85154b47922b6(turret, turret.var_6e232adf75ffe7b9);

    function_b7a1b1b524b363a8("<dev string:x7f>");

    remoteturret_deploytablet(turret);

    function_b7a1b1b524b363a8("<dev string:x9b>");

    if(!istrue(turret.var_6e232adf75ffe7b9)) {
      wait 2;
      turret.var_6e232adf75ffe7b9 = 1;
    } else {
      wait 1;
    }

    if(getdvarint(@ "hash_81827f5873d8d4c3", 0) == 1) {
      thread function_ad92d1401c649166(turret);
    }

    function_b7a1b1b524b363a8("<dev string:xbc>");

    thread function_47d88d77d03dc801(turret);
    self waittill("\xc4\xd2\xb2sr\n\xfe\t\t\xb5\r\xdc\x9c?\x1c\x0e\xa4q\xeb\x93{5\xb3$");
    killstreak_shared::function_ef8c27946fcd4535();
    turret.var_e7e2b0b7ab3fd788 = 1;
    self.usingremote = "\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd";
    turret notify("\xdc\x1e(\x83\xd6\xda\xdb\xd1\x8c\x8d7\xf4");

    if(istrue(self.isjuggernaut)) {
      self notify("\xdc\x1e(\x83\xd6\xda\xdb\xd1\x8c\x8d7\xf4");
    }

    turret setscriptablepartstate("vr-\x88\x9a9_NW9\x1b", "\x9b\xba=\xa2\n9~XEkZy\xcdT\x8a\xe2\xbfT");
    turret setscriptablepartstate("\x8f\xf9&\x13\xd4\xeb", "\xd1u\xdc\xba;w~", 0);
    turret remoteturret_applyoverlay(self);

    if(function_89fde055c308989c()) {
      self remotecontrolturret(turret);
      thread function_bc2a989d384dd707(turret);
      val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xd56a\x9b\xba$Do]uE\xb6\x9b1");
      self.deployingremoteturret = undefined;
      return;
    }

    if(istrue(turret.isplaced)) {
      turret stopbarrelspin();
      turret setmode(" v\x05\xf1\".");
      turret.var_e7e2b0b7ab3fd788 = undefined;
      self.usingremote = undefined;
      turret notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");

      if(istrue(self.isjuggernaut)) {
        self notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");
      }

      turret setscriptablepartstate("vr-\x88\x9a9_NW9\x1b", "\x99\x94+-\x97\x98[\xd5\x97\xfa8\xe6w\x97\x99\x99\x19\x93");
      turret setscriptablepartstate("\x8f\xf9&\x13\xd4\xeb", "O\x8c-\x87\xb3`\x14", 0);
      turret function_cc649f2bff7a786f(self);
      turret remoteturret_removeoverlay(self);
      inventory_utility::_switchtoweapon(self.primaryweaponobj);
      self enableweaponswitch();
      turret thread remoteturret_attacktargets(undefined, self);
      wait 1;

      if(isDefined(turret.tabletweaponobj)) {
        self takeweapon(turret.tabletweaponobj);
        turret.tabletweaponobj = undefined;
      }

      val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xd56a\x9b\xba$Do]uE\xb6\x9b1");
      val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "`\x16\xae\xa2\xe4t\x187\xe7");
      val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xe1P+\x1a \xe4\xd7-\xeel]");
      val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xaf\xd7\xe5h\xeb+");
      val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xc9\xca\x1boX\x8c");
      val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w");
      val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "mV\x8d+e");
      self.deployingremoteturret = undefined;
      thread function_d2691b3bc103a08a(turret);
    }
  }
}

function function_31a85154b47922b6(turret, var_6e232adf75ffe7b9) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  hasendedearly = 0;
  result = utility::waittill_any_ents_return(self, "'\x16\x9b\x1d1\xcd\xcf\xa2GV\xaf\xad\xaf\xbf\xaa\"\xc3\xb5\x81\xf3)\xf9~\x8aazu\x06\xfej\x8b\xa2\x04", self, "\x9cV\xb6{\xa3e}\xd1\xba'9\xca\x1d\xf5V[\xe0\xc8", turret, "\x18\x12\x05\x90w\x16\xa0\xd4\xd3_|:(\xbe\x99\x05/%\x14", turret, "(@\xe6\x83\x86\x1b\x19\xbaK\x1es", turret, "S\x9c\xe1\x10\x06\xea\x1e");
  hasendedearly = !isDefined(result) || result != "'\x16\x9b\x1d1\xcd\xcf\xa2GV\xaf\xad\xaf\xbf\xaa\"\xc3\xb5\x81\xf3)\xf9~\x8aazu\x06\xfej\x8b\xa2\x04";

  if(!hasendedearly) {
    timeout = istrue(var_6e232adf75ffe7b9) ? 1 : 2;
    result = utility::waittill_any_ents_or_timeout_return(timeout, self, "\x9cV\xb6{\xa3e}\xd1\xba'9\xca\x1d\xf5V[\xe0\xc8", turret, "\x18\x12\x05\x90w\x16\xa0\xd4\xd3_|:(\xbe\x99\x05/%\x14", turret, "(@\xe6\x83\x86\x1b\x19\xbaK\x1es", turret, "S\x9c\xe1\x10\x06\xea\x1e");
    hasendedearly = !isDefined(result) || result != "\xb5B\xd7\x904}\x11";
  }

  if(!hasendedearly) {
    self waittill("\xc4\xd2\xb2sr\n\xfe\t\t\xb5\r\xdc\x9c?\x1c\x0e\xa4q\xeb\x93{5\xb3$", issuccess);
    hasendedearly = !issuccess;
  }

  if(hasendedearly) {
    function_b7a1b1b524b363a8("<dev string:xd5>");

    killstreak_shared::function_ef8c27946fcd4535();
    currentweapon = self getcurrentweapon().basename;

    if(currentweapon == "\x8a!\x03\x7fr\xcc\x96y\x93\xe4p\x95s\x1d/\x87\\\xc1\xdc") {
      inventory_utility::_switchtoweapon(self.primaryweaponobj);
    }

    self enableweaponswitch();

    if(isDefined(turret.tabletweaponobj)) {
      self takeweapon(turret.tabletweaponobj);
      turret.tabletweaponobj = undefined;
    }

    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xd56a\x9b\xba$Do]uE\xb6\x9b1");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "`\x16\xae\xa2\xe4t\x187\xe7");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xe1P+\x1a \xe4\xd7-\xeel]");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xaf\xd7\xe5h\xeb+");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xc9\xca\x1boX\x8c");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "mV\x8d+e");
    self.usingremote = undefined;
  }
}

#using_animtree("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6");

function remoteturret_deploytablet(turret) {
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  turret endon("\x18\x12\x05\x90w\x16\xa0\xd4\xd3_|:(\xbe\x99\x05/%\x14");
  weaponobj = makeweapon("\x8a!\x03\x7fr\xcc\x96y\x93\xe4p\x95s\x1d/\x87\\\xc1\xdc");
  deployanim = % P;\
  xe9\x1cJ\x83\x97\xe8\xf6\xab\xd0kC$\xaeNU\f\x92\x01\xfe\xbd;
  inventory_utility::_giveweapon(weaponobj, 0, 0, 1);
  turret.tabletweaponobj = weaponobj;
  switchresult = inventory_utility::domonitoredweaponswitch(weaponobj, 0);
  killstreak_shared::starttabletscreen(turret.streakinfo.streakname, 0);
  killstreak_shared::function_ef8c27946fcd4535();
  self notify("'\x16\x9b\x1d1\xcd\xcf\xa2GV\xaf\xad\xaf\xbf\xaa\"\xc3\xb5\x81\xf3)\xf9~\x8aazu\x06\xfej\x8b\xa2\x04");
}

function function_47d88d77d03dc801(turret) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  if(player_utility::_isalive()) {
    turretmodepartstate = turret getscriptablepartstate("vr-\x88\x9a9_NW9\x1b");

    if(turretmodepartstate == "\x9b\xba=\xa2\n9~XEkZy\xcdT\x8a\xe2\xbfT") {
      turret setscriptablepartstate("\x1e\x18+0 I\x9dk\x03\f\xc7\xf3\x1c\xb1\x03\xec", "\xe8u\xc9r\xca\x8e\xd7m\xb7\xc8Y_ka\xdcW\xb0\x1b\xa3\xf6s\xcas\x1dr\xbc\xd7\x99\v\x91\xca\xb9\xd1\xc2r\x1d");
    } else {
      turret setscriptablepartstate("\x1e\x18+0 I\x9dk\x03\f\xc7\xf3\x1c\xb1\x03\xec", "\x86\a\xb7u\x95\x92\x04\xaf\xda\x1b\x18\t\xc9\xa0\x11\xbd\x9e\xe0\x9d\xfcYw\xe2\xf7\xb9\xe1z\x9a\x94\xe4H\xf4\xdc\x8c\xd5\x1f");
    }

    level thread game_utility::fadetoblackforplayer(self, 1, 0.3);
    result = utility::waittill_any_ents_or_timeout_return(0.7, self, "\x9cV\xb6{\xa3e}\xd1\xba'9\xca\x1d\xf5V[\xe0\xc8", turret, "\x18\x12\x05\x90w\x16\xa0\xd4\xd3_|:(\xbe\x99\x05/%\x14", self, "\x1e\xfd\xd1\xa2\a", turret, "(@\xe6\x83\x86\x1b\x19\xbaK\x1es", turret, "S\x9c\xe1\x10\x06\xea\x1e");
    issuccess = isDefined(result) && result == "\xb5B\xd7\x904}\x11";

    if(!issuccess) {
      turret utility::function_64d4c2d2dace59ac("\x1e\x18+0 I\x9dk\x03\f\xc7\xf3\x1c\xb1\x03\xec", "\n\xcd\f\xc6,\xd9g\xc0\xfbj}\x9f\xe3\xc1;\x04\xef\xb3\xd3\xb9\x03\xeb\xd5\n]\xeb\x18\xc0:\xcd\xe9\xe0b^^\x15\x8fw\xb5\xde|A");
    }

    level thread game_utility::fadetoblackforplayer(self, 0, 0.3);
    self notify("\xc4\xd2\xb2sr\n\xfe\t\t\xb5\r\xdc\x9c?\x1c\x0e\xa4q\xeb\x93{5\xb3$", issuccess);
  }
}

function function_89fde055c308989c() {
  if(self isswimming() || istrue(self.isridingvehicle) || self isjumping() || self isinfreefall() || self ishanging() || self isparachuting()) {
    if(utility::issharedfuncdefined(#"hud", #"showerrormessage")) {
      self[[utility::getsharedfunc(#"hud", #"showerrormessage")]]("\xa4\x80\x89\fN\x92\xcat\xfdLoE\xc2\xad\xe2\x83\xb1[\x8c\x16\xb32Uo\x95X\bo:\xb1\x17'\xfc\x06En\xd0\x9c\x9b");
    }

    return false;
  }

  return true;
}

function function_bc2a989d384dd707(turret) {
  self endon("\x9cV\xb6{\xa3e}\xd1\xba'9\xca\x1d\xf5V[\xe0\xc8");
  turret endon("\x18\x12\x05\x90w\x16\xa0\xd4\xd3_|:(\xbe\x99\x05/%\x14");
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  turret endon("C\x84\"[P\xd9TTC9\xbaG\xff\xbb\x89\xd3\xf2w\xb5\xad\xd3Br\xf3");
  turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  childthread function_df261174b0c2f70(turret, 0.75);
  self waittill("\xe2\xb5\x1b\xc6i\xd6v\xa2\xbaz\xecS\xf0");

  if(istrue(turret.isplaced)) {
    turret stopbarrelspin();

    if(getdvarint(@ "hash_8cb86e86af6483b0", 0) == 1) {
      thread function_ad92d1401c649166(turret);
    }

    thread function_47d88d77d03dc801(turret);
    self waittill("\xc4\xd2\xb2sr\n\xfe\t\t\xb5\r\xdc\x9c?\x1c\x0e\xa4q\xeb\x93{5\xb3$");
    self remotecontrolturretoff(turret);
    turret setmode(" v\x05\xf1\".");
    turret.var_e7e2b0b7ab3fd788 = undefined;
    self.usingremote = undefined;
    turret notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");

    if(istrue(self.isjuggernaut)) {
      self notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");
    }

    turret setscriptablepartstate("vr-\x88\x9a9_NW9\x1b", "\x99\x94+-\x97\x98[\xd5\x97\xfa8\xe6w\x97\x99\x99\x19\x93");
    turret setscriptablepartstate("\x8f\xf9&\x13\xd4\xeb", "O\x8c-\x87\xb3`\x14", 0);
    turret function_cc649f2bff7a786f(self);
    turret remoteturret_removeoverlay(self);
    inventory_utility::_switchtoweapon(self.primaryweaponobj);
    self enableweaponswitch();
    turret thread remoteturret_attacktargets(undefined, self);
    wait 1;

    if(isDefined(turret.tabletweaponobj)) {
      self takeweapon(turret.tabletweaponobj);
      turret.tabletweaponobj = undefined;
    }

    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xd56a\x9b\xba$Do]uE\xb6\x9b1");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "`\x16\xae\xa2\xe4t\x187\xe7");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xe1P+\x1a \xe4\xd7-\xeel]");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xaf\xd7\xe5h\xeb+");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xc9\xca\x1boX\x8c");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "mV\x8d+e");
    thread function_d2691b3bc103a08a(turret);
  }
}

function private function_df261174b0c2f70(turret, overrideholdtime) {
  if(!(isDefined(self) && isDefined(turret))) {
    return;
  }

  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\xde\xed\xdbT=\xdc\x92x\x03\xd2");
  self endon("`\xa8\x9dt;\xb4\xbd[:\xae\x04\x1fPF");
  turret endon("\x1e\xfd\xd1\xa2\a");

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
      self setclientomnvar("\xb4h\\\xfc\xa2p\x8c\x86\x91\xa9\x12\xdeCg\xaeu", 0);
      timerdirty = 0;
    }

    while(self useButtonPressed()) {
      if(!self usinggamepad() && !self getuseholdkbmprofile()) {
        self notify("\xe2\xb5\x1b\xc6i\xd6v\xa2\xbaz\xecS\xf0");
        return;
      }

      timeused += updaterate;
      timerdirty = 1;
      self setclientomnvar("\xb4h\\\xfc\xa2p\x8c\x86\x91\xa9\x12\xdeCg\xaeu", timeused / holdtime);

      if(timeused > holdtime) {
        self notify("\xe2\xb5\x1b\xc6i\xd6v\xa2\xbaz\xecS\xf0");
        return;
      }

      wait updaterate;
    }

    wait updaterate;
  }
}

function function_7c9d3893e8bdfd6e(turret) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self waittill("\xc4\xd2\xb2sr\n\xfe\t\t\xb5\r\xdc\x9c?\x1c\x0e\xa4q\xeb\x93{5\xb3$", issuccess);

  if(issuccess) {}
}

function remoteturret_setcarried(turret) {
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  if(isDefined(turret.moving_platform)) {
    turret.moving_platform = undefined;
    turret.moving_platform_offset = undefined;
    turret.moving_platform_angles_offset = undefined;
    turret unlink();
  }

  turret emp_debuff::allow_emp(0);

  if(utility::issharedfuncdefined(#"game", #"unregistersentient")) {
    turret[[utility::getsharedfunc(#"game", #"unregistersentient")]](turret.sentientpool, turret.sentientpoolindex);
  }

  linkedchildren = turret getlinkedchildren();

  foreach(child in linkedchildren) {
    if(isDefined(child)) {
      child unlink();
    }
  }

  if(isDefined(turret.minimapid)) {
    if(utility::issharedfuncdefined(#"game", #"returnobjectiveid")) {
      [[utility::getsharedfunc(#"game", #"returnobjectiveid")]](turret.minimapid);
    }

    turret.minimapid = undefined;
  }

  turret.colmodel unlink();
  turret.colmodel hide();
  remoteturret_setinactive(turret);
  turret hide();
  function_409faf88af4e7264(0);
  turret function_3f0c0252a31bb1af(self);
  turret.carriedby = self;
  turret notify("S\x9c\xe1\x10\x06\xea\x1e");
  self playSound("\xbf\xea`\x10\x98\xbf:\xc5\x1a\x0e\a\x03\xc0k\x92x|\xa5g5\\wn\x06");
  turret setscriptablepartstate("WX\xaa\th\r\x87.\xbfR\xa5\xe7NE&l\x05>", "\xe2[\xb8$P\xe1%\xf1}U\"\xd1$");
  turret function_f51b6a446a1764a(self);
  thread function_f74f3d18f79a358a();
  weapon_utility::saveweaponstates();
  turret killstreak_utility::function_459b121985e46d0c();
  endonnotify = "%_#\xff\xab\xf3\x04d$\xa6\x12\xd2\x0f\x98\xefU\xc7\x7f\xd4\xceZr\xf6";

  if(utility::issharedfuncdefined(#"weapons", #"watchforplacementfirestate")) {
    self thread[[utility::getsharedfunc(#"weapons", #"watchforplacementfirestate")]](turret.streakinfo, endonnotify);
  }

  inventory_utility::_giveweapon("\xf60\x1a\xe1\xa8^i}sX\xaf *\xfa1\xe7P\xefe\x86\x16B\xfe");
  switchsuccess = inventory_utility::domonitoredweaponswitch("\xf60\x1a\xe1\xa8^i}sX\xaf *\xfa1\xe7P\xefe\x86\x16B\xfe", 1);

  if(!istrue(switchsuccess)) {
    return 0;
  }

  manual_turret::manualturret_toggleallowplacementactions(0);
  marker = remoteturret_watchplacement(turret, turret.streakinfo, 1, 2);
  manual_turret::manualturret_toggleallowplacementactions(1);

  if(!isDefined(marker)) {
    return 0;
  }

  remoteturret_setplaced(turret, marker);
}

function remoteturret_switchbacklastweapon(immediateswitch) {
  if(istrue(immediateswitch)) {
    inventory_utility::_switchtoweaponimmediate(self.lastdroppableweaponobj);
  } else {
    inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);
  }

  inventory_utility::_takeweapon("\xf60\x1a\xe1\xa8^i}sX\xaf *\xfa1\xe7P\xefe\x86\x16B\xfe");
}

function remoteturret_setinactive(turret) {
  turret.isplaced = undefined;
  turret setdefaultdroppitch(30);
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
  turret.useownerobj function_adbe50b70b740c89(0);
  turret.useownerobj unlink();
}

function remoteturret_delaydeletemarker(turret, marker) {
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  wait 0.25;

  if(isDefined(marker.visual)) {
    marker.visual delete();
  }
}

function remoteturret_disableplayeruseonconnect(turret, useobj) {
  if(isDefined(turret)) {
    turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
    turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  }

  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    level waittill("Z\xc4\x9eQ\xd37_m%", player);
    useobj disableplayeruse(player);
  }
}

function remoteturret_watchpickup(turret) {
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    turret.useownerobj waittill("\x91`\xb1\xe7T\x97>", player);

    if(player != turret.owner) {
      continue;
    }

    if(istrue(self.ishaywire)) {
      continue;
    }

    if(utility::issharedfuncdefined(#"remote_turret", #"allowpickupofturret")) {
      if(!player[[utility::getsharedfunc(#"remote_turret", #"allowpickupofturret")]]()) {
        continue;
      }
    }

    turret.useownerobj function_adbe50b70b740c89(0);
    turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
    turret.owner.placedsentries[turret.turrettype] = arrayremove(turret.owner.placedsentries[turret.turrettype], turret);
    turret.owner thread remoteturret_setcarried(turret);
    waitframe();
  }
}

function remoteturret_disableplayerpickuponconnect(turret) {
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    level waittill("Z\xc4\x9eQ\xd37_m%", player);
    player waittill("N\xf8\xfc\xc5\x90A\xa3\t\x06d\b\x9d\x94\xd1");
    turret.useownerobj disableplayeruse(player);
  }
}

function remoteturret_watchdismantle(turret) {
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

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
    turret.dismantleobj waittill("\x91`\xb1\xe7T\x97>", player);
    turret notify("(@\xe6\x83\x86\x1b\x19\xbaK\x1es", 0, 1);
    break;
  }
}

function remoteturret_watchdamage(turret) {
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  if(utility::issharedfuncdefined(#"remote_turret", #"monitordamage")) {
    self[[utility::getsharedfunc(#"remote_turret", #"monitordamage")]](turret);
  }

  turret.damagemonitored = 1;
}

function remoteturret_disableplayerdismantleonconnect(turret) {
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    level waittill("Z\xc4\x9eQ\xd37_m%", player);
    player waittill("N\xf8\xfc\xc5\x90A\xa3\t\x06d\b\x9d\x94\xd1");

    if(level.teambased) {
      if(player.team != self.team) {
        continue;
      }
    }
  }
}

function remoteturret_empstarted(data) {
  if(isDefined(data.attacker)) {
    if(utility::issharedfuncdefined(#"player", #"doScoreEvent")) {
      data.attacker thread[[utility::getsharedfunc(#"player", #"doScoreEvent")]]("5\xfcd3l\xeb1vK\xb1\x8e\xf4\xe7L\x88\xce6\xcb\f");
    }

    if(utility::issharedfuncdefined(#"remote_turret", #"empstarted")) {
      self[[utility::getsharedfunc(#"remote_turret", #"empstarted")]]();
    }
  }

  remoteturret_empupdate();
}

function remoteturret_empcleared(isdeath) {
  if(isdeath) {
    return;
  }

  if(utility::issharedfuncdefined(#"remote_turret", #"empstarted")) {
    self[[utility::getsharedfunc(#"remote_turret", #"empcleared")]]();
  }

  remoteturret_empupdate();
}

function function_23627b606a0e4a96(data) {
  if(isDefined(data.attacker)) {
    if(utility::issharedfuncdefined(#"player", #"doScoreEvent")) {
      data.attacker thread[[utility::getsharedfunc(#"player", #"doScoreEvent")]]("5\xfcd3l\xeb1vK\xb1\x8e\xf4\xe7L\x88\xce6\xcb\f", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    }

    if(utility::issharedfuncdefined(#"remote_turret", #"empstarted")) {
      self[[utility::getsharedfunc(#"remote_turret", #"empstarted")]]();
    }
  }

  if(isDefined(self.useobj)) {
    self.useobj disableplayeruse(self.useobj.owner);
    self.useobj.activeuseobject = 0;
  }

  self.owner notify("\x81\r\x8d\xdb6\x01\x99\x80\x80\t\x10p\x8b\x96");
  self.owner notify("\x9cV\xb6{\xa3e}\xd1\xba'9\xca\x1d\xf5V[\xe0\xc8");

  if(istrue(self.isbarrelspinning)) {
    self stopbarrelspin();
    self.isbarrelspinning = undefined;
  }

  self setmode("\xda\x13\x17\xa2q\xf0\xfb\xf8w\xe6\xe5qh\xe9");
  self setscriptablepartstate("vr-\x88\x9a9_NW9\x1b", "\x99\x94+-\x97\x98[\xd5\x97\xfa8\xe6w\x97\x99\x99\x19\x93");

  if(istrue(self.var_e7e2b0b7ab3fd788)) {
    self.owner remotecontrolturretoff(self);
    self.var_e7e2b0b7ab3fd788 = undefined;
    self.owner.usingremote = undefined;
    self notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");

    if(istrue(self.owner.isjuggernaut)) {
      self.owner notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");
    }

    self setscriptablepartstate("\x8f\xf9&\x13\xd4\xeb", "O\x8c-\x87\xb3`\x14", 0);
    function_f51b6a446a1764a(self.owner);
    remoteturret_removeoverlay(self.owner);

    if(isDefined(self.owner)) {
      self.owner inventory_utility::_switchtoweapon(self.owner.primaryweaponobj);
      self.owner enableweaponswitch();
      wait 1;
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "`\x16\xae\xa2\xe4t\x187\xe7");
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xe1P+\x1a \xe4\xd7-\xeel]");
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xaf\xd7\xe5h\xeb+");
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xc9\xca\x1boX\x8c");
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w");
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "mV\x8d+e");
    }
  }
}

function function_8f902c79295c9943(data) {
  if(utility::issharedfuncdefined(#"remote_turret", #"empstarted")) {
    self[[utility::getsharedfunc(#"remote_turret", #"empcleared")]]();
  }

  if(isDefined(self.useobj)) {
    self.useobj enableplayeruse(self.useobj.owner);
    self.useobj.activeuseobject = 1;
  }

  if(istrue(self.isplaced)) {
    self setmode(" v\x05\xf1\".");
    self.owner thread function_d2691b3bc103a08a(self);
    thread remoteturret_attacktargets(undefined, self.owner);
  }
}

function private function_ad92d1401c649166(turret) {
  level endon("<dev string:xf4>");
  self endon("<dev string:x102>");
  turret endon("<dev string:x110>");
  wait 0.3;
  fakedata = spawnStruct();
  turret function_23627b606a0e4a96(fakedata);
  wait 4;
  turret function_8f902c79295c9943(fakedata);
}

function function_9fb0366cbcfa5df(data) {
  if(!istrue(self.ishaywire)) {
    self.ishaywire = 1;

    if(isDefined(data.attacker)) {
      if(utility::issharedfuncdefined(#"remote_turret", #"empstarted")) {
        self[[utility::getsharedfunc(#"remote_turret", #"empstarted")]]();
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

    self.owner notify("\x81\r\x8d\xdb6\x01\x99\x80\x80\t\x10p\x8b\x96");
    self.owner notify("\x9cV\xb6{\xa3e}\xd1\xba'9\xca\x1d\xf5V[\xe0\xc8");

    if(istrue(self.isbarrelspinning)) {
      self stopbarrelspin();
      self.isbarrelspinning = undefined;
    }

    self setmode("\xda\x13\x17\xa2q\xf0\xfb\xf8w\xe6\xe5qh\xe9");
    self setscriptablepartstate("vr-\x88\x9a9_NW9\x1b", "\x99\x94+-\x97\x98[\xd5\x97\xfa8\xe6w\x97\x99\x99\x19\x93");

    if(istrue(self.var_e7e2b0b7ab3fd788)) {
      self.owner remotecontrolturretoff(self);
      self.var_e7e2b0b7ab3fd788 = undefined;
      self.owner.usingremote = undefined;
      self notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");

      if(istrue(self.owner.isjuggernaut)) {
        self.owner notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");
      }

      self setscriptablepartstate("\x8f\xf9&\x13\xd4\xeb", "O\x8c-\x87\xb3`\x14", 0);
      function_f51b6a446a1764a(self.owner);
      remoteturret_removeoverlay(self.owner);
      self.owner inventory_utility::_switchtoweapon(self.owner.primaryweaponobj);
      self.owner enableweaponswitch();
      wait 1;
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "`\x16\xae\xa2\xe4t\x187\xe7");
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xe1P+\x1a \xe4\xd7-\xeel]");
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xaf\xd7\xe5h\xeb+");
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xc9\xca\x1boX\x8c");
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w");
      self.owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "mV\x8d+e");
    }
  }
}

function function_4ec6891d54df345a(data) {
  if(utility::issharedfuncdefined(#"remote_turret", #"empstarted")) {
    self[[utility::getsharedfunc(#"remote_turret", #"empcleared")]]();
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
    self setmode(" v\x05\xf1\".");
    self.owner thread function_d2691b3bc103a08a(self);
    thread remoteturret_attacktargets(undefined, self.owner);
  }

  self.ishaywire = undefined;
}

function remoteturret_empupdate() {
  if(emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    return;
  }

  self turretfireenable();
  self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
}

function function_ab492117264b6a7f(owner) {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    if(owner player_utility::_isalive()) {
      self.ownerdied = undefined;
      break;
    }

    wait 0.1;
  }
}

function remoteturret_watchownerdeath(owner) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("S\x9c\xe1\x10\x06\xea\x1e");

  while(true) {
    if(!owner player_utility::_isalive()) {
      if(!istrue(self.ownerdied)) {
        self notify("C\x84\"[P\xd9TTC9\xbaG\xff\xbb\x89\xd3\xf2w\xb5\xad\xd3Br\xf3");
        self.ownerdied = 1;
        thread function_ab492117264b6a7f(owner);

        if(istrue(self.var_e7e2b0b7ab3fd788) && istrue(self.isplaced) || istrue(owner.deployingremoteturret)) {
          owner remotecontrolturretoff(self);
          self setmode(" v\x05\xf1\".");
          self.var_e7e2b0b7ab3fd788 = undefined;
          owner.usingremote = undefined;
          self notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");

          if(istrue(self.isjuggernaut)) {
            owner notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");
          }

          self.overheated = 0;
          self setscriptablepartstate("vr-\x88\x9a9_NW9\x1b", "\x99\x94+-\x97\x98[\xd5\x97\xfa8\xe6w\x97\x99\x99\x19\x93");
          self setscriptablepartstate("\x8f\xf9&\x13\xd4\xeb", "O\x8c-\x87\xb3`\x14", 0);
          function_cc649f2bff7a786f(owner);
          remoteturret_removeoverlay(owner);
          owner inventory_utility::_switchtoweapon(owner.primaryweaponobj);
          owner enableweaponswitch();
          owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xd56a\x9b\xba$Do]uE\xb6\x9b1");
          owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "`\x16\xae\xa2\xe4t\x187\xe7");
          owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xe1P+\x1a \xe4\xd7-\xeel]");
          owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xaf\xd7\xe5h\xeb+");
          owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xc9\xca\x1boX\x8c");
          owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w");
          owner val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "mV\x8d+e");
          thread remoteturret_attacktargets(undefined, owner);
        }

        owner thread function_d2691b3bc103a08a(self);
      }
    }

    wait 0.1;
  }
}

function remoteturret_watchdeath(turret) {
  turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  turret waittill("(@\xe6\x83\x86\x1b\x19\xbaK\x1es", skipshutdown, wasdestroyed);
  turret notify("\x18\x12\x05\x90w\x16\xa0\xd4\xd3_|:(\xbe\x99\x05/%\x14");
  turret notify("\x1e\xfd\xd1\xa2\a");
  waitframe();
  self.remoteturretactive = undefined;

  if(istrue(turret.var_e7e2b0b7ab3fd788)) {
    turret remoteturret_removeoverlay(self);
    self remotecontrolturretoff(turret);
    turret.var_e7e2b0b7ab3fd788 = undefined;
    self.usingremote = undefined;
    turret notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");

    if(istrue(self.isjuggernaut)) {
      self notify(":7\x90\xd4d\xc7\xbe\x9c\xe1\xf8\xbb");
    }

    turret.overheated = 0;
    turret setscriptablepartstate("vr-\x88\x9a9_NW9\x1b", "\x99\x94+-\x97\x98[\xd5\x97\xfa8\xe6w\x97\x99\x99\x19\x93");
    turret setscriptablepartstate("\x8f\xf9&\x13\xd4\xeb", "O\x8c-\x87\xb3`\x14", 0);
  }

  if(isDefined(self)) {
    inventory_utility::_switchtoweapon(self.primaryweaponobj);
    self enableweaponswitch();
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xd56a\x9b\xba$Do]uE\xb6\x9b1");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "`\x16\xae\xa2\xe4t\x187\xe7");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xe1P+\x1a \xe4\xd7-\xeel]");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xaf\xd7\xe5h\xeb+");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "\xc9\xca\x1boX\x8c");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w");
    val::reset("\xcf^eI\xcd\x8d\xe0U\x16\xf0\x1c\xe5\xcd", "mV\x8d+e");
    self.placedsentries[turret.turrettype] = arrayremove(self.placedsentries[turret.turrettype], turret);
    remoteturret_setinactive(turret);
    turret thread function_f51b6a446a1764a(self);
    function_409faf88af4e7264(0);

    if(utility::issharedfuncdefined(#"player", #"printgameaction")) {
      self[[utility::getsharedfunc(#"player", #"printgameaction")]]("\xce\xd6\xd98\xf8\xf8\xa4KC\x96P\xb4<\xc9\xce\xd0X^A:\xfc\xcc\xaaCY\xfe\xf8\xf4\x04\xe5\xce\xf0", self);
    }

    turret.streakinfo.expiredbydeath = istrue(wasdestroyed);
    killstreak_utility::recordkillstreakendstats(turret.streakinfo);
  }

  if(istrue(wasdestroyed)) {
    killstreak_utility::playkillstreakteamleaderdialog(turret.streakinfo, turret.streakinfo.streakname + "GP}U:\xc4\x17\xdc\x96\x97\xc5\f\xf1=p\x11\x01\xb8\x93\xd2[", #"destroyed");
  }

  turret remoteturret_setturretmodel("\xf0Q~F\xfc\xae\x7f\xca\xb9");
  turret setturretowner(undefined);

  if(!istrue(skipshutdown)) {
    turret setscriptablepartstate("t;o \xa2\xc3\x9d\xc6", "\xb8\"");
    turret setscriptablepartstate("WX\xaa\th\r\x87.\xbfR\xa5\xe7NE&l\x05>", "\xf8\x88m");
    hostmigration::hostmigration_waitlongdurationwithpause(2);
    turret setscriptablepartstate("*\x83\xc10XI\x1e", "X\xf4\xe1\x82\xb7\x7f\x8f");
  } else {
    turret setscriptablepartstate("*\x83\xc10XI\x1e", "\x15\xa6\xcc\xb7:\x80}");
  }

  level callback::callback(#"killstreak_finish_use", {
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
    if(utility::issharedfuncdefined(#"game", #"returnobjectiveid")) {
      [[utility::getsharedfunc(#"game", #"returnobjectiveid")]](turret.minimapid);
    }

    turret.minimapid = undefined;
  }

  wait 0.2;
  turret delete();
}

function function_29d11b3f112bf406(data) {
  self notify("(@\xe6\x83\x86\x1b\x19\xbaK\x1es", 1, 1);
}

function remoteturret_delayscriptabledelete() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

function remoteturret_watchtimeout(turret) {
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(turret.timeout > 0) {
    if(istrue(turret.isbarrelspinning)) {
      turret stopbarrelspin();
      turret.isbarrelspinning = undefined;
    }

    timeoutpercentage = int(100 * turret.timeout / turret.maxtimeout);
    self setclientomnvar("\xc7\xaa\xb8\xa8o\x85t)\xe1\x8d\x9c\xb2\xd0Td\x1a\x0f\xeb\xe7\xc10Yv", timeoutpercentage);
    turret.timeout -= 0.05;
    hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  killstreak_utility::playkillstreakteamleaderdialog(turret.streakinfo, turret.streakinfo.streakname + "\xc2\xec\x84s5 \xeb\x8c\xbd\xbf\xfc\x19\x86R\x8c\x89\xb3\xa7s", #"leave");
  turret notify("(@\xe6\x83\x86\x1b\x19\xbaK\x1es", 0, 0);
}

function remoteturret_watchdisown(turret) {
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  utility::waittill_any("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16", "Ah\x1d{\xc5+\x80\x80\xaf.\xae", "\xfaO\x88\x1a-\a\xf9\xb5\xfc\x8a;^\xd8\xdb}\xa6\xfd");
  turret notify("(@\xe6\x83\x86\x1b\x19\xbaK\x1es", 0, 0);
}

function remoteturret_watchgameend(turret) {
  turret endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  turret endon("S\x9c\xe1\x10\x06\xea\x1e");
  level waittill("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  turret notify("(@\xe6\x83\x86\x1b\x19\xbaK\x1es", 0, 0);
}

function remoteturret_setturretmodel(type) {
  turretmodel = undefined;

  if(type == "& 7\xf7r\x8f3") {
    turretmodel = level.sentrysettings[self.turrettype].modelbaseground;
  } else {
    turretmodel = level.sentrysettings[self.turrettype].modeldestroyedground;
  }

  modeltype = getdvarint(@ "hash_e19e5d308effeda3", 1);

  if(!modeltype) {
    turretmodel = "<dev string:x119>";
  }

  assert(isDefined(turretmodel), "<dev string:x137>");
  self setModel(turretmodel);
}

function remoteturret_attacktargets(configoverride, player) {
  self.owner endon("<dev string:x17f>");

  self endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  self endon("S\x9c\xe1\x10\x06\xea\x1e");
  self endon("o\xab\x19\xd7\xed\xf5\xb4$,\xf0\t");
  self.owner endon("\x81\r\x8d\xdb6\x01\x99\x80\x80\t\x10p\x8b\x96");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread turret_heatmonitor();
  thread turret_coolmonitor();

  while(true) {
    self waittill("\xa7\xedfBu\xe0\xfd.\xfc7w\x16\xbeB\r\x8b\xa7");

    if(self isfiringturret()) {
      player thread function_42ad99f09e1bba3();
      thread function_4f2ad8d106d159c4(player);
      thread remoteturret_burstfirestart(configoverride);
      continue;
    }

    self.heatlevel = 0;
    remoteturret_spindown();
    thread remoteturret_burstfirestop();
    thread function_cc649f2bff7a786f(player);
    player thread function_f74f3d18f79a358a();
    self setscriptablepartstate("\xc0\xd8wj\xd6G\xffc\xd6\xb8G\xa5\xbd\xe1\xc5\x04\xb5\xf2F", "\xf8\x88m");
  }
}

function function_699c77cf97fe3888(configoverride) {
  self endon("<dev string:x199>");
  self endon("<dev string:x1a8>");
  level endon("<dev string:xf4>");
  self.turrettarget = spawn("<dev string:x1b3>", self gettagorigin("<dev string:x1c3>") + anglesToForward(self gettagangles("<dev string:x1c3>") * 300));
  self.turrettarget.targeton = 0;
  self.turrettarget dontinterpolate();
  self.turrettarget thread function_838970709f0a97c7(self);
  self.turrettarget thread function_9ae572756afccbaf(self);
  turretconfig = undefined;

  if(isDefined(configoverride)) {
    turretconfig = configoverride;
  } else {
    turretconfig = level.sentrysettings[self.turrettype];
  }

  sentrymode = turretconfig.sentrymodeon;
  manualmode = "<dev string:x1d0>";
  turretmode = sentrymode;
  notifyon = 0;

  while(true) {
    if(getdvarint(@ "hash_c9bd691ce96079ac", 0) == 1) {
      if(!istrue(notifyon)) {
        self.owner notifyonplayercommand("<dev string:x17f>", "<dev string:x1e1>");
        notifyon = 1;
      }

      self.owner waittill("<dev string:x17f>");

      if(turretmode != manualmode) {
        self setmode(manualmode);
        turretmode = manualmode;
        starttrace = self.owner getvieworigin();
        endtrace = starttrace + anglesToForward(self.owner getplayerangles()) * 50000;
        trace = trace::ray_trace(starttrace, endtrace, self.owner);
        endpos = undefined;

        if(isDefined(trace["<dev string:x1f1>"]) && trace["<dev string:x1f1>"] != "<dev string:x1fc>") {
          endpos = trace["<dev string:x20c>"];
        }

        if(isDefined(endpos)) {
          thread function_2e00772d6a31dc75(endpos);
        }
      } else {
        function_922523c71d18ce61();
        turretmode = sentrymode;
        self setmode(turretmode);
        thread remoteturret_attacktargets();
      }

      continue;
    }

    notifyon = 0;

    if(turretmode != sentrymode) {
      self.owner notifyonplayercommandremove("<dev string:x17f>", "<dev string:x1e1>");
      function_922523c71d18ce61();
      turretmode = sentrymode;
      self setmode(turretmode);
      thread remoteturret_attacktargets();
    }

    waitframe();
  }
}

function function_2e00772d6a31dc75(firepos) {
  self.owner endon("<dev string:x218>");
  self.owner endon("<dev string:x17f>");
  self endon("<dev string:x199>");
  self endon("<dev string:x1a8>");
  level endon("<dev string:xf4>");
  thread remoteturret_burstfirestop();
  self.turrettarget.origin = firepos;
  self settargetentity(self.turrettarget);
  self.turrettarget.targeton = 1;
  starttag = "<dev string:x22e>";

  if(self.streakinfo.streakname == "<dev string:x242>") {
    starttag = "<dev string:x250>";
  }

  endtag = "<dev string:x1c3>";
  wait 1;

  while(true) {
    var_8024ecfac55758d2 = self gettagorigin(starttag);
    var_d40db6a1ac7c50fc = self gettagangles(starttag);
    thread debug_utility::drawsphere(var_8024ecfac55758d2, 2, 1, (0, 1, 1));
    thread debug_utility::drawline(var_8024ecfac55758d2, var_8024ecfac55758d2 + anglesToForward(var_d40db6a1ac7c50fc) * 1800, 1, (0, 1, 1));
    flashtagorigin = self gettagorigin(endtag);
    flashtagangles = self gettagangles(endtag);
    thread debug_utility::drawsphere(flashtagorigin, 2, 1, (1, 1, 0));
    thread debug_utility::drawline(flashtagorigin, flashtagorigin + anglesToForward(flashtagangles) * 1800, 1, (1, 1, 0));
    remoteturret_burstfirestart(undefined, undefined, 1);
    wait 1;
  }
}

function function_922523c71d18ce61() {
  self cleartargetentity();
  thread remoteturret_burstfirestop();
  self.turrettarget.targeton = 0;
  self.owner notify("<dev string:x218>");
}

function function_838970709f0a97c7(turret) {
  turret endon("<dev string:x199>");
  turret endon("<dev string:x1a8>");
  self endon("<dev string:x110>");
  level endon("<dev string:xf4>");

  while(true) {
    if(istrue(self.targeton)) {
      sphere(self.origin, 20, (1, 1, 0), 0, 1);
    }

    waitframe();
  }
}

function function_9ae572756afccbaf(turret) {
  turret endon("<dev string:x199>");
  turret endon("<dev string:x1a8>");
  self endon("<dev string:x110>");
  level endon("<dev string:xf4>");
  turret waittill("<dev string:x110>");
  self delete();
}

function remoteturret_targetlocksound() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self setscriptablepartstate("\xc0\xd8wj\xd6G\xffc\xd6\xb8G\xa5\xbd\xe1\xc5\x04\xb5\xf2F", "k\x11\x1b\x0f\xbc\rD\x04\x18\x9c\xc4\xb8");
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

function remoteturret_burstfirestart(configoverride, maxroundsoverride, var_b22e2ed96c8c9485) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  self endon("S\x9c\xe1\x10\x06\xea\x1e");
  self endon("o\xab\x19\xd7\xed\xf5\xb4$,\xf0\t");
  self endon("\xf6\xc3\x1c\x84\xf6\xba\x01\x96[\xee\\\xe7|");
  self.owner endon("\x81\r\x8d\xdb6\x01\x99\x80\x80\t\x10p\x8b\x96");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
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
      self shootturret("\xfd\xef\xc3\r\xb4\xad\x84p\x84", lockstrength);
      self.streakinfo.shots_fired++;
      wait firetime;
    }

    if(istrue(var_b22e2ed96c8c9485)) {
      break;
    }

    wait randomfloatrange(minpause, maxpause);
  }
}

function remoteturret_burstfirestop() {
  self notify("\xf6\xc3\x1c\x84\xf6\xba\x01\x96[\xee\\\xe7|");
}

function function_fb540808e92325aa() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  self endon("S\x9c\xe1\x10\x06\xea\x1e");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    if(istrue(self.overheated)) {} else if(self.heatlevel > 0) {}

    wait 0.1;
  }
}

function turret_heatmonitor() {
  self.owner endon("<dev string:x17f>");

  self endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  self endon("S\x9c\xe1\x10\x06\xea\x1e");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  overheattime = level.sentrysettings[self.turrettype].overheattime;

  while(true) {
    if(self.heatlevel > overheattime) {
      self.overheated = 1;

      while(self.heatlevel) {
        wait 0.1;
      }

      self.overheated = 0;
      self notify("\xb4o\x03\xc7g\xf4\x12\x0e\x93z\xc9u}U");
    }

    wait 0.05;
  }
}

function playheatfx() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xb4o\x03\xc7g\xf4\x12\x0e\x93z\xc9u}U");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self notify("8\xd8\xb0\xf2\xd27;\xebC\x95a\x8e\xd7\xcc<");
  self endon("8\xd8\xb0\xf2\xd27;\xebC\x95a\x8e\xd7\xcc<");

  for(;;) {
    playFXOnTag(utility::getfx("\xfcMc\xf8\xa2\xf4I\x1fE<\b\xb3/\x1c|a\x82("), self, "\xfd\xef\xc3\r\xb4\xad\x84p\x84");
    wait level.sentrysettings[self.turrettype].fxtime;
  }
}

function turret_coolmonitor() {
  self.owner endon("<dev string:x17f>");

  self endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  self endon("S\x9c\xe1\x10\x06\xea\x1e");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    if(self.heatlevel > 0) {
      if(self.cooldownwaittime <= 0) {
        self.heatlevel = max(0, self.heatlevel - 0.05);
      } else {
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
      }
    }

    wait 0.05;
  }
}

function remoteturret_beepsounds() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("S\x9c\xe1\x10\x06\xea\x1e");
  self endon("(@\xe6\x83\x86\x1b\x19\xbaK\x1es");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    wait 3;

    if(self isfiringturret()) {
      waitframe();
      continue;
    }
  }
}

function function_b5fea418aea141d2() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self.owner endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xb2\xdc:\xca\xe4\xb4s\xec");
  entmask = function_46b9be1a90c37243(["x\xbd\xdc\xdcp\x8e@T \x86)c", "1\x8b\x80\xe5\xca\xd2\xaf\xd8"]);

  while(true) {
    targetarray = function_131693b1e162f074(self.origin, 1575, entmask);

    foreach(ent in targetarray) {
      if(!isDefined(ent)) {
        continue;
      }

      if(isPlayer(ent) || isbot(ent)) {
        if(utility::issharedfuncdefined(#"player", #"isreallyalive")) {
          if(![[utility::getsharedfunc(#"player", #"isreallyalive")]](ent)) {
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

      if(emp_debuff::is_empd()) {
        continue;
      }

      targetinfo = function_7bf474b6e9f57d1f(ent);

      if(!targetinfo.isinrange || !targetinfo.isvisible || !targetinfo.isindetectrange || !targetinfo.var_70494ae7c0944b86) {
        continue;
      }

      if(self.owner function_6f1a1427eb3e7346(ent)) {
        continue;
      }

      if(istrue(self.markingtarget)) {
        continue;
      }

      params = function_b2ceb8e298cee061(self.cameratype);
      function_465ba3655dc4a07d(ent, 3, "\xd4\xa5&\xe5\xdc\xa3D\xaf\xff\x06\xde\xab\xc3\xa7M\x86");
    }
  }
}

function function_7bf474b6e9f57d1f(target) {
  info = spawnStruct();
  info.isvisible = function_a8a366474e6c91d1(target);
  info.var_70494ae7c0944b86 = function_8933840bae1d8d78(target);
  info.isinrange = remoteturret_isinmarkingrange(target);
  info.isindetectrange = remoteturret_isindetectrange(target);

  if(isDefined(self.pilot)) {}

  return info;
}

function private remoteturret_istargetinreticle(scantarget, scanfov, var_9631306cb818363) {
  if(!isDefined(scantarget)) {
    return 0;
  }

  inreticle = 0;
  targetorigin = scantarget.origin;
  scanpoints = [targetorigin];
  var_ded87c1d68953d1d = distancesquared(self getvieworigin(), scantarget.origin);
  isusingextrapoints = 0;

  if(var_ded87c1d68953d1d <= 2) {
    var_9631306cb818363 *= getdvarfloat(@ "hash_20c9852b3129de04", 2.5);
    isusingextrapoints = 1;
  }

  if(isPlayer(scantarget)) {
    istargethanging = scantarget ishanging();
    headpos = scantarget utility::function_43a6da81dcbf98b0();
    centerpos = scantarget utility::function_ea67fa739e7c7752();
    scanpoints = [headpos, centerpos];

    if(!istargethanging) {
      scanpoints[scanpoints.size] = targetorigin;
    }

    if(isusingextrapoints) {
      var_eaad368fd4d0add5 = (headpos + centerpos) / 2;
      extrapoints = [var_eaad368fd4d0add5];

      if(!istargethanging) {
        var_ab054d6f9e9b295b = (centerpos + targetorigin) / 2;
        extrapoints[extrapoints.size] = var_ab054d6f9e9b295b;
      }

      scanpoints = utility::array_combine(scanpoints, extrapoints);
    }
  } else if(isagent(scantarget)) {
    centerpos = scantarget utility::function_ea67fa739e7c7752();
    headpos = scantarget utility::function_43a6da81dcbf98b0();
    scanpoints = [targetorigin + (0, 0, 1), centerpos, headpos];

    if(isusingextrapoints) {
      var_ab054d6f9e9b295b = (centerpos + targetorigin) / 2;
      var_eaad368fd4d0add5 = (headpos + centerpos) / 2;
      extrapoints = [var_ab054d6f9e9b295b, var_eaad368fd4d0add5];
      scanpoints = utility::array_combine(scanpoints, extrapoints);
    }
  }

  foreach(point in scanpoints) {
    if(self worldpointinreticle_circle(point, scanfov, var_9631306cb818363)) {
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

  params = function_b2ceb8e298cee061(self.cameratype);
  detectrangesq = 2480625;

  if(istrue(self.isunderwater) || istrue(target player_utility::isswimmingunderwater())) {
    detectrangesq = 619369;
  }

  return distancesquared(self.origin, target.origin) < detectrangesq;
}

function remoteturret_isindetectrange(target) {
  if(!isDefined(target)) {
    return false;
  }

  params = function_b2ceb8e298cee061(self.cameratype);
  detectrangesq = 2480625;

  if(istrue(self.isunderwater) || istrue(target player_utility::isswimmingunderwater())) {
    detectrangesq = 619369;
  }

  return distancesquared(self.origin, target.origin) < detectrangesq;
}

function function_a8a366474e6c91d1(target) {
  if(!isDefined(target)) {
    return 0;
  }

  icansee = 0;
  tracecontents = physics_createcontents(["\r\xd8\x949\x81\t\xee\xe3\xd3\xba\t7\xd68\xcc\xca\x16\xc0\x99\x86\x8b\x90=O", "\x96)?\xdbyq7\xde\x80 \x99\xfc\x9e-\xfe\xa7\xcd\r\x13\xba", "f$\xa6\xed\x03\xf1\xd9p*\x10\xc0\xae!\xd6\xdep?\x81\x9f\xcc\xa9\t`\x87", "\x998b\x97\xb6Y\xbb\x05\x82\x19\xfb7\xb3\xfb\x9b\\\xdbx3\x14\xc6zp\a\xe4\xfe9", "\xa3?\a\nru\xf2\xe6\x96\xb7\xd0\xcc\x97]4\x12n\xd3\xd3)\xcb\xae.", "\xa0\x0f\xab\x82\xa6\xcc\x04JAxI/\xacl\x19ww7t\x96vY\x86Vx"]);
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

    if(utility::issharedfuncdefined(#"player", #"isreallyalive")) {
      headpos = target utility::function_43a6da81dcbf98b0();
    }

    centerpos = (0, 0, 0);

    if(utility::issharedfuncdefined(#"player", #"isreallyalive")) {
      centerpos = target utility::function_ea67fa739e7c7752();
    }

    tracepoints = [headpos, centerpos, defaultorigin];
  } else if(isagent(target)) {
    tracepoints = [defaultorigin + (0, 0, 1)];
  }

  ignorelist = [self, target];
  vehicle = target vehicle::get_vehicle();

  if(isDefined(vehicle)) {
    ignorelist[ignorelist.size] = vehicle;
    vehiclechildren = vehicle getlinkedchildren(1);

    foreach(child in vehiclechildren) {
      ignorelist[ignorelist.size] = vehicle;
    }
  }

  icansee = 0;

  for(i = 0; i < tracepoints.size; i++) {
    trace = trace::ray_trace(camorigin, tracepoints[i], ignorelist, tracecontents, 1);

    if(trace[")\x9a\x94]\xee}s"] == "\x90\x17\x030\x83m\x0f}D\x02f\xd9") {
      icansee = 1;
      break;
    }
  }

  return icansee;
}

function function_8933840bae1d8d78(target) {
  if(!isDefined(target)) {
    return 0;
  }

  camangles = self gettagangles("\xf6\xfc\xad\x9di\xb9)\xac/K");
  var_7e1c8399482447a3 = self gettagorigin("\xf6\xfc\xad\x9di\xb9)\xac/K");

  if(isDefined(self.pilot)) {
    camangles = self.pilot getplayerangles();
    var_7e1c8399482447a3 = self.pilot getvieworigin();
  }

  camfwdvec = anglesToForward(camangles);
  defaultorigin = target.origin;
  headpos = (0, 0, 0);

  if(utility::issharedfuncdefined(#"player", #"isreallyalive")) {
    headpos = target utility::function_43a6da81dcbf98b0();
  }

  centerpos = (0, 0, 0);

  if(utility::issharedfuncdefined(#"player", #"isreallyalive")) {
    centerpos = target utility::function_ea67fa739e7c7752();
  }

  tracepoints = [headpos, centerpos, defaultorigin];
  var_70494ae7c0944b86 = 0;

  foreach(point in tracepoints) {
    cam2targetvec = point - var_7e1c8399482447a3;
    dotangle = math::anglebetweenvectors(camfwdvec, cam2targetvec);
    var_7b409f55997cd7c7 = math::anglebetweenvectors(camfwdvec, (0, 0, 1));
    var_1a6832d070a8acd3 = math::anglebetweenvectors(cam2targetvec, (0, 0, 1));

    if(isDefined(self.pilot)) {
      var_6f1bbc93d7cf9979 = distancesquared(var_7e1c8399482447a3, point);

      if(var_6f1bbc93d7cf9979 > 10) {
        if(abs(abs(var_7b409f55997cd7c7) - abs(var_1a6832d070a8acd3)) > getdvarfloat(@ "hash_77f60c1216fca977", 19)) {
          return var_70494ae7c0944b86;
        }
      }
    }

    if(dotangle <= getdvarfloat(@ "hash_a20d9fbeab627f6", 31)) {
      var_70494ae7c0944b86 = 1;
    }
  }

  return var_70494ae7c0944b86;
}

function private function_6f1a1427eb3e7346(target) {
  if(!isDefined(target)) {
    return false;
  }

  markcluster = function_86acf5d1d0afa87a(self);

  if(!isDefined(markcluster)) {
    return false;
  }

  markdata = markcluster[target getentitynumber()];

  if(!isDefined(markdata)) {
    return false;
  }

  return istrue(markdata.reconmarked);
}

function function_86acf5d1d0afa87a(player) {
  if(!isDefined(player)) {
    return;
  }

  if(level.teambased) {
    if(!(isDefined(level.teammarkedents) && isDefined(level.teammarkedents[player.team]))) {
      return;
    }

    if(squad_utility::shouldmodesetsquads()) {
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

function function_b2ceb8e298cee061(cameratype) {
  params = level.var_ef72f24cdcf668a2[cameratype];
  assert(isDefined(params), "<dev string:x266>" + cameratype);
  return params;
}

function private function_465ba3655dc4a07d(target, sensorduration, supername) {
  sensordata = function_92434c1768403e27(target);

  if(!isDefined(sensordata)) {
    return;
  }

  self playsoundtoplayer(#"ui_camera_proximity_alert", self.owner, self);
  function_b39f6ce5cdc92478(supername);
  self.owner thread function_aff2ea331ab9c6e5(self, self.ownerindex, 2, undefined, 3.25);
  thread function_eff3847be880432c(sensordata, sensorduration, supername);
}

function private function_92434c1768403e27(target) {
  if(!isDefined(self.var_e3d59bc9e485899d)) {
    self.var_e3d59bc9e485899d = [];
  }

  if(isDefined(self.var_e3d59bc9e485899d[target getentitynumber()])) {
    return;
  }

  sensordata = spawnStruct();
  sensordata.target = target;
  sensordata.entnum = target getentitynumber();
  self.var_e3d59bc9e485899d[target getentitynumber()] = sensordata;
  return sensordata;
}

function private function_b39f6ce5cdc92478(supername) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }

    function_240c2d8f43cfd8c7(player, undefined, supername);
  }
}

function function_30ca9f4456ec9394() {
  params = function_b2ceb8e298cee061("\xb8?\xc8\x11\xf6l");
  self.headiconbox = entityheadicons::setheadicon_singleimage([], "X\xd1,\xd96\xe1\xa8q\xf6\x94\x1a\x8c\xdb\xd3\xa1{\x15\x95:\xf6\"\xf9-3+\xbc\t\x01\xbf\xd9\xf3\xdf\x15\xf3A\xac\xb3\x17", 5, 1, 1000, 100, undefined, 1);
  self.headiconfaction = entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, undefined, 1);
  self.headiconalert = entityheadicons::setheadicon_singleimage([], "h\x13\x12\x95\x8fc\xa5bu\x13\x16\v\ts\xa1\xfbt", 5, 1, 1000, 100, undefined, 1);
  function_b39f6ce5cdc92478("\xb8?\xc8\x11\xf6l");
}

function function_240c2d8f43cfd8c7(player, unset, supername) {
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

  isfriendly = player_utility::isfriendly(self.owner.team, player);
  usingcamerasuper = function_77c5cfb0d00107d(player, supername);

  if(isfriendly) {
    if(istrue(unset)) {
      function_f0c7d1006a29e5ca(player);
      return;
    }

    if(function_217dde4aa0096e78()) {
      function_4f2ad8d106d159c4(player);
      return;
    }

    if(usingcamerasuper) {
      if(istrue(player.isusingcamera)) {
        function_f51b6a446a1764a(player);
        return;
      }

      function_cc649f2bff7a786f(player);
      return;
    } else {
      function_f0c7d1006a29e5ca(player);
    }

    return;
  }

  function_f51b6a446a1764a(player);
}

function private function_77c5cfb0d00107d(player, supername) {
  if(isDefined(player.super) && player.super.staticdata.ref == supername) {
    return 1;
  }

  return 0;
}

function private function_217dde4aa0096e78() {
  if(!isDefined(self.var_e3d59bc9e485899d)) {
    return false;
  }

  if(self.var_e3d59bc9e485899d.size > 0) {
    return true;
  }

  return false;
}

function private function_4f2ad8d106d159c4(player) {
  entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  entityheadicons::setheadicon_addclienttomask(self.headiconalert, player);
}

function private function_f51b6a446a1764a(player) {
  entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  entityheadicons::setheadicon_removeclientfrommask(self.headiconalert, player);
}

function private function_cc649f2bff7a786f(player) {
  entityheadicons::setheadicon_addclienttomask(self.headiconbox, player);
  entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  entityheadicons::setheadicon_removeclientfrommask(self.headiconalert, player);
}

function private function_f0c7d1006a29e5ca(player) {
  entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  entityheadicons::setheadicon_addclienttomask(self.headiconfaction, player);
  entityheadicons::setheadicon_removeclientfrommask(self.headiconalert, player);
}

function function_aff2ea331ab9c6e5(camera, index, status, forcestate, var_714f2bb063ff2231) {
  if(!isDefined(self.var_62286f077d2cf602)) {
    self.var_62286f077d2cf602 = [];
  }

  struct = spawnStruct();
  struct.camera = camera;
  struct.index = index;
  struct.status = status;
  struct.forcestate = istrue(forcestate);
  struct.var_714f2bb063ff2231 = var_714f2bb063ff2231 ?? 0;
  self.var_62286f077d2cf602[self.var_62286f077d2cf602.size] = struct;
  thread function_f2eed163f5ef3c18();
}

function function_f2eed163f5ef3c18() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\xaa\x11\xff\xfe]M\x92tb*\xef\xb7\xf3Ox\xab\a2q\b\xb9<\xb4\x11n\x91yf\x1d\xfb\x94\xda");
  self notify("!Tx\tz\xc0NB\xba\xadF\xb6\x8a+vQ7B\xe2\xbeU\xb0x\xe5");
  self endon("!Tx\tz\xc0NB\xba\xadF\xb6\x8a+vQ7B\xe2\xbeU\xb0x\xe5");

  if(istrue(level.gameended) || !isDefined(self)) {
    return;
  }

  while(isDefined(self.var_62286f077d2cf602) && self.var_62286f077d2cf602.size > 0) {
    waitframe();
    struct = utility::array_get_first_item(self.var_62286f077d2cf602);
    self notify("vl\xdf4]l\t\xbdu\x8f,\xdd\xbe\xdfM\xfd\xf6\b\x1b\xf4\xdb\xa8\x84\xff\xb2H\xac\x9b\xb1Z", struct.camera, struct.index, struct.status, struct.forcestate, struct.var_714f2bb063ff2231);
    self.var_62286f077d2cf602 = arrayremove(self.var_62286f077d2cf602, struct);
  }
}

function private function_eff3847be880432c(sensordata, sensorduration, supername) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self.owner endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x1e\xfd\xd1\xa2\a");
  wait sensorduration;
  function_79e0b1c3a348be0a(sensordata);
  function_b39f6ce5cdc92478(supername);
}

function private function_79e0b1c3a348be0a(sensordata) {
  if(isDefined(self.var_e3d59bc9e485899d[sensordata.entnum])) {
    self.var_e3d59bc9e485899d[sensordata.entnum] = undefined;
  }
}

function function_42ad99f09e1bba3() {
  self setclientomnvar("\xdb\x7f1z\xb7l\x124\xc4/\x0e8v\xf2\xd0Hr\x18U\b\xcdxL", 2);
}

function function_f74f3d18f79a358a() {
  self setclientomnvar("\xdb\x7f1z\xb7l\x124\xc4/\x0e8v\xf2\xd0Hr\x18U\b\xcdxL", 1);
}

function remoteturret_applyoverlay(player) {
  player killstreak_utility::function_2430b5441db58b83(self.streakinfo.streakname, "\xb8\"");
  player setclientomnvar("\xba\x96\xbem\xb4\xc6\xb17t9e\x85\xb5_\xa1\xca\xc2lt\xa1", 0);
}

function remoteturret_removeoverlay(player) {
  player killstreak_utility::function_2430b5441db58b83(self.streakinfo.streakname, "\xf8\x88m");
}

function function_b7a1b1b524b363a8(printmsg) {
  if(getdvarint(@ "hash_2da6e96d161f55bc", 0) == 1) {
    print("<dev string:x298>" + printmsg);
  }
}

# /