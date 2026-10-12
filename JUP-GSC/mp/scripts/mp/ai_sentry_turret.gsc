/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\ai_sentry_turret.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\poi;
#using scripts\mp\utility\points;
#using scripts\stealth\debug;
#namespace ai_sentry_turret;

function init() {
  if(getdvarint(@ "hash_70d8cba45c5014ec", 1) == 0) {
    return;
  }

  level.aisentryturrets = spawnStruct();
  level.aisentryturrets.maxtotal = getdvarint(@ "hash_e2a4ecaa972fb581", 15);
  level.aisentryturrets.var_a4186f089a36d2f0 = getdvarint(@ "hash_6a8c234b065d124c", 3);
  level.aisentryturrets.spawnedturrets = [];
  level.aisentryturrets.var_325f9f15252b4928 = &function_2d24ee630d6c37e2;
  level.sentrysettings["ai_sentry_turret"] = spawnStruct();
  level.sentrysettings["ai_sentry_turret"].health = 999999;
  level.sentrysettings["ai_sentry_turret"].maxhealth = 650;
  level.sentrysettings["ai_sentry_turret"].burstmin = 20;
  level.sentrysettings["ai_sentry_turret"].burstmax = 120;
  level.sentrysettings["ai_sentry_turret"].pausemin = 0.15;
  level.sentrysettings["ai_sentry_turret"].pausemax = 0.35;
  level.sentrysettings["ai_sentry_turret"].lockstrength = 6;
  level.sentrysettings["ai_sentry_turret"].sentrymodeon = "sentry";
  level.sentrysettings["ai_sentry_turret"].var_7c46d96a6fedd4cd = "manual";
  level.sentrysettings["ai_sentry_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["ai_sentry_turret"].spinuptime = 1.5;
  level.sentrysettings["ai_sentry_turret"].overheattime = 8;
  level.sentrysettings["ai_sentry_turret"].cooldowntime = 0.3;
  level.sentrysettings["ai_sentry_turret"].burstmaxtime = 4;
  level.sentrysettings["ai_sentry_turret"].var_6265b628c3ed1103 = 3;
  level.sentrysettings["ai_sentry_turret"].var_87d927a08cbfdf3f = 1;
  level.sentrysettings["ai_sentry_turret"].leftarc = 80;
  level.sentrysettings["ai_sentry_turret"].rightarc = 80;
  level.sentrysettings["ai_sentry_turret"].fxtime = 0.3;
  level.sentrysettings["ai_sentry_turret"].targetrange = 1024;
  level.sentrysettings["ai_sentry_turret"].weaponinfo = "sentry_turret_mp";
  level.sentrysettings["ai_sentry_turret"].playerweaponinfo = "sentry_turret_mp";
  level.sentrysettings["ai_sentry_turret"].modelbaseground = "wpn_wm_p45_mg_auto_sentry_v0_mp";
  level.sentrysettings["ai_sentry_turret"].modeldestroyedground = "wpn_wm_p45_mg_auto_sentry_v0_mp";
  level.sentrysettings["ai_sentry_turret"].bullettag = "tag_flash";
  level.sentrysettings["ai_sentry_turret"].scorepopup = "destroyed_sentry";
  level.sentrysettings["ai_sentry_turret"].lightfxtag = "tag_fx";

  if(scripts\mp\poi::poi_issystemactive()) {
    scripts\mp\poi::function_44739fe1cf82e29a("aiSentryTurrets");
  }
}

function function_2d24ee630d6c37e2() {
  while(!flag_exist("create_script_initialized")) {
    if(!flag_exist("poi_initialized")) {
      waitframe();
      continue;
    }

    break;
  }

  while(!flag_exist("poi_initialized")) {
    flag_wait("create_script_initialized");
  }

  level thread function_fc46b0f912ca62f();

  var_76bc16f4e15dec1c = scripts\mp\poi::poi_issystemactive();
  poiname = undefined;
  level.aisentryturrets.var_fd5ea9cb37c309d3 = array_randomize(getStructArray("aiSentryTurret", "script_noteworthy"));

  foreach(spawnloc in level.aisentryturrets.var_fd5ea9cb37c309d3) {
    var_de58ca0235ee107b = 1;

    if(level.aisentryturrets.spawnedturrets.size >= level.aisentryturrets.maxtotal) {
      var_de58ca0235ee107b = 0;
    } else if(var_76bc16f4e15dec1c) {
      if(!isDefined(spawnloc.poi)) {
        spawnloc.poi = scripts\mp\poi::poi_findpoioriginisin(spawnloc.origin);
      }

      if(!isDefined(spawnloc.poi) || !scripts\mp\poi::poi_ispoiactive(spawnloc.poi)) {
        var_de58ca0235ee107b = 0;
      } else if(level.poi[spawnloc.poi]["aiSentryTurrets"].size >= level.aisentryturrets.var_a4186f089a36d2f0) {
        var_de58ca0235ee107b = 0;
      }
    }

    if(var_de58ca0235ee107b) {
      if(scripts\engine\utility::issharedfuncdefined("ai_sentry_turret", "additionalApproveSpawn")) {
        var_de58ca0235ee107b = [[scripts\engine\utility::getsharedfunc("ai_sentry_turret", "additionalApproveSpawn")]](spawnloc);
      }
    }

    if(var_de58ca0235ee107b) {
      spawnloc.var_1b096843a2175f92 = 1;
      turret = turret_spawn(spawnloc);
      level.aisentryturrets.spawnedturrets[level.aisentryturrets.spawnedturrets.size] = turret;

      if(var_76bc16f4e15dec1c && isDefined(spawnloc.poi)) {
        level.poi[spawnloc.poi]["aiSentryTurrets"][level.poi[spawnloc.poi]["aiSentryTurrets"].size] = turret;
        scripts\mp\poi::function_d0e7647e5538eb9d(spawnloc.poi, "aiSentryTurrets", turret);
      }
    }
  }
}

function function_2dd8dd0ebc078f25() {
  wait 10;
  config = level.sentrysettings["ai_sentry_turret"];
  turretstruct = spawnStruct();
  turretstruct.origin = (2644, -4359, 10);
  turretstruct.angles = (0, 180, 0);

  if(isDefined(turretstruct)) {
    turret = turret_spawn(turretstruct);
  }
}

function turret_spawn(turretstruct, team) {
  if(getdvarint(@ "hash_70d8cba45c5014ec", 1) == 0) {
    return;
  }

  if(!isDefined(team)) {
    team = "team_hundred_ninety_five";
  }

  config = level.sentrysettings["ai_sentry_turret"];

  if(!isDefined(turretstruct.angles)) {
    turretstruct.angles = (0, 0, 0);
  }

  turret = spawnturret("misc_turret", turretstruct.origin, config.weaponinfo);
  turret.angles = turretstruct.angles;
  turret.health = 9999;
  turret.maxhealth = config.maxhealth;
  turret.ammocount = config.ammo;
  turret.timeout = config.timeout;
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 0.1;
  turret.sentrytype = "ai_sentry_turret";
  turret.owningteam = team;
  turret.team = team;
  turret setModel(config.modelbaseground);
  turret setturretteam(turret.owningteam);
  turret setCanDamage(1);
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret setautorotationdelay(0.5);
  turret maketurretinoperable();
  leftarc = float(ter_op(isDefined(turretstruct.leftarc), turretstruct.leftarc, config.leftarc));
  turret.leftarc = leftarc;
  turret setleftarc(leftarc);
  rightarc = float(ter_op(isDefined(turretstruct.rightarc), turretstruct.rightarc, config.rightarc));
  turret.rightarc = rightarc;
  turret setrightarc(rightarc);
  turret setbottomarc(50);
  turret settoparc(60);
  turret setconvergencetime(1, "pitch");
  turret setconvergencetime(1, "yaw");
  turret setconvergenceheightpercent(0.9);
  turret setdefaultdroppitch(-89);
  turret setturretmodechangewait(1);
  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(&function_76189206d67bd21c);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(&function_1ef2976b1357c651);
  turret laseron();
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel hide();
  turret thread scripts\mp\damage::monitordamage(turret.maxhealth, "hitequip", &turret_handledeathdamage, &turret_modifydamage, 1);
  turret thread turret_watchdeath(turret);
  turret thread function_f9dcbe0ab7aac5f6();
  turret thread function_9e099b94cb9fc336();
  turret thread function_352e4c58083275a4();
  turret.turreton = 1;
  turret setmode(config.sentrymodeon);
  return turret;
}

function turret_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level.sentrysettings[self.sentrytype];
  explosivedamage = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH") {
    explosivedamage = 1;
  }

  if(isDefined(attacker)) {
    guy = ter_op(isDefined(attacker.owner), attacker.owner, attacker);

    if(isPlayer(guy)) {
      eventinfo = spawnStruct();
      eventinfo.isdestroyedkillstreak = 1;
      guy thread scripts\mp\utility\points::doscoreevent(#"hash_2b5885666af24123", objweapon, undefined, undefined, self, undefined, undefined, 0, eventinfo, 1);
    }
  }

  self.var_1e0eb63ecb3f1e2 = 0;
  self.stopfiring = 1;
  self laseroff();
  self notify("kill_turret", explosivedamage, 1);
}

function turret_modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  return damage;
}

function function_f9dcbe0ab7aac5f6() {
  self endon("death");
  self endon("kill_turret");
  config = level.sentrysettings[self.sentrytype];

  while(true) {
    if(!istrue(self.turreton) || istrue(self.turretdisabled)) {
      waitframe();
      continue;
    }

    besttarget = turret_getbesttarget();
    var_1b951c4e47ba5c35 = 1;

    if(isDefined(besttarget)) {
      if(issharedfuncdefined("player", "isReallyAlive")) {
        if(![[getsharedfunc("player", "isReallyAlive")]](besttarget)) {
          var_1b951c4e47ba5c35 = 0;
        }
      }

      if(var_1b951c4e47ba5c35) {
        thread scripts\cp_mp\utility\debug_utility::drawline(besttarget.origin, self.origin, 5, (0, 0, 1));
        function_eb48fdf891a4e9ee(besttarget);
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(config.cooldowntime);
      }
    }

    waitframe();
  }
}

function function_eb48fdf891a4e9ee(besttarget) {
  config = level.sentrysettings[self.sentrytype];

  while(istrue(self.turreton) && !istrue(self.stopfiring) && function_c5754fdac13fc2a5(besttarget)) {
    self settargetentity(besttarget);

    if(isPlayer(besttarget)) {
      pauseinterval = config.var_6265b628c3ed1103;
    } else {
      pauseinterval = config.var_87d927a08cbfdf3f;
    }

    function_ba7df6eeacb835f6(config.burstmaxtime, besttarget);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(pauseinterval);
    self cleartargetentity(besttarget);
  }
}

function turret_getbesttarget() {
  config = level.sentrysettings[self.sentrytype];
  targetrange = config.targetrange;
  var_52edc18a611b938d = targetrange * targetrange;
  potentialtargetlist = utility::playersinsphere(self.origin, targetrange);
  besttarget = undefined;
  bestrange = undefined;

  foreach(potentialtarget in potentialtargetlist) {
    validtarget = function_10f997ed68f4fcef(potentialtarget);

    if(!istrue(validtarget)) {
      continue;
    }

    startpoint = self gettagorigin("tag_flash");
    endpoint = potentialtarget.origin;
    currentrange = distancesquared(startpoint, endpoint);

    if(currentrange <= var_52edc18a611b938d) {
      if(!isDefined(besttarget) && !isDefined(bestrange) || currentrange < bestrange) {
        besttarget = potentialtarget;
        bestrange = currentrange;
      }
    }
  }

  return besttarget;
}

function function_10f997ed68f4fcef(potentialtarget) {
  if(issharedfuncdefined("player", "isReallyAlive")) {
    if(![[getsharedfunc("player", "isReallyAlive")]](potentialtarget)) {
      return false;
    }
  }

  if(potentialtarget.team == self.team) {
    return false;
  }

  if(istrue(potentialtarget.notarget)) {
    return false;
  }

  if(istrue(potentialtarget.var_f6f8549c6fd27e85)) {
    return false;
  }

  if(!function_bc0708b3cc5719c9(potentialtarget)) {
    return false;
  }

  if(!turret_canseetarget(potentialtarget)) {
    return false;
  }

  return true;
}

function function_c5754fdac13fc2a5(besttarget) {
  config = level.sentrysettings[self.sentrytype];
  maxrangesq = config.targetrange * config.targetrange;

  if(distancesquared(self gettagorigin("tag_flash"), besttarget.origin) > maxrangesq) {
    return false;
  }

  if(!function_10f997ed68f4fcef(besttarget)) {
    return false;
  }

  return true;
}

function function_bc0708b3cc5719c9(potentialtarget) {
  offset = vectorNormalize(self.origin - potentialtarget.origin);
  dotproduct = vectordot(anglesToForward(self.angles), offset);
  return dotproduct < 0;
}

function turret_canseetarget(potentialtarget) {
  contentsoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  targetpoints = ["j_mainroot", "tag_origin", "j_head"];
  canseetarget = 0;

  foreach(point in targetpoints) {
    canseetarget = scripts\engine\trace::ray_trace_passed(self gettagorigin("tag_flash"), potentialtarget gettagorigin(point), self, contentsoverride);

    if(istrue(canseetarget)) {
      break;
    }
  }

  return canseetarget;
}

function turret_watchdeath(turret) {
  turret waittill("kill_turret", skipshutdown, wasdestroyed);
  turret.killed = 1;
  turret turret_setturretmodel("destroyed");
  turret setturretowner(undefined);

  if(!istrue(skipshutdown)) {
    turret playSound("sentry_explode_smoke");
    turret setscriptablepartstate("shutdown", "on");
    turret.turreton = 0;
    turret.turretdisabled = 1;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    turret setscriptablepartstate("explode", "regular");
  } else {
    turret setscriptablepartstate("explode", "violent");
  }

  turret playSound("mp_equip_destroyed");

  if(isDefined(turret.colmodel)) {
    turret.colmodel delete();
  }

  wait 0.2;

  if(false) {
    level thread function_92fa86c7825c72e1(turret.origin, turret.angles, turret.leftarc, turret.rightarc, 4);
  }

  turret delete();
}

function function_92fa86c7825c72e1(origin, angles, leftarc, rightarc, var_68faa79e3e6058fb) {
  wait var_68faa79e3e6058fb;
  turretstruct = spawnStruct();
  turretstruct.origin = origin;
  turretstruct.angles = angles;
  turretstruct.leftarc = leftarc;
  turretstruct.rightarc = rightarc;
  turret = turret_spawn(turretstruct);
}

function turret_setturretmodel(type) {
  turretmodel = undefined;

  if(type == "destroyed") {
    turretmodel = level.sentrysettings[self.sentrytype].modeldestroyedground;
  }

  assertex(isDefined(turretmodel), "<dev string:x1c>");
  self setModel(turretmodel);
}

function function_9e099b94cb9fc336() {
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self)) {
    self.colmodel delete();
    self delete();
  }
}

function function_1279fb3b42ff8e1() {
  self endon("death");
  self endon("stop_shooting");
  self endon("kill_turret");
  level endon("game_ended");
  self playSound("sentry_gun_target_lock_beep");
  wait 0.19;
  self playSound("sentry_gun_target_lock_beep");
}

function function_ba7df6eeacb835f6(maxbursttime, potentialtarget) {
  turret_spinup();
  config = level.sentrysettings[self.sentrytype];
  firetime = weaponfiretime(config.weaponinfo);
  minshots = config.burstmin;
  maxshots = config.burstmax;
  minpause = config.pausemin;
  maxpause = config.pausemax;
  lockstrength = config.lockstrength;
  currenttime = 0;

  for(var_1b951c4e47ba5c35 = 1; istrue(self.turreton) && !istrue(self.stopfiring) && currenttime < maxbursttime && var_1b951c4e47ba5c35; var_1b951c4e47ba5c35 = [[getsharedfunc("player", "isReallyAlive")]](potentialtarget)) {
    numshots = randomintrange(minshots, maxshots + 1);

    for(i = 0; i < numshots && !self.overheated; i++) {
      if(!istrue(self.turreton) || istrue(self.stopfiring)) {
        break;
      }

      target = self getturrettarget(1);

      if(!isDefined(target)) {
        break;
      }

      self shootturret("tag_flash", lockstrength);
      wait firetime;
      currenttime += firetime;
    }

    if(!istrue(self.turreton) || istrue(self.stopfiring)) {
      break;
    }

    randwait = randomfloatrange(minpause, maxpause);
    wait randwait;
    currenttime += randwait;

    if(issharedfuncdefined("player", "isReallyAlive")) {}
  }

  function_e711849fbc474180();
}

function function_afe3c3af7cb5e39e() {
  function_e711849fbc474180();
}

function turret_spinup() {
  config = level.sentrysettings[self.sentrytype];
  thread function_1279fb3b42ff8e1();

  while(istrue(self.turreton) && self.momentum < config.spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function function_e711849fbc474180() {
  self.momentum = 0;
}

function function_352e4c58083275a4() {
  self endon("kill_turret");
  level endon("game_ended");

  while(true) {
    wait 3;

    if(self isfiringturret()) {
      waitframe();
      continue;
    }

    playsoundatpos(self.origin, "sentry_gun_beep");
  }
}

function function_704307eb2f1581ac(turrettrigger) {
  self endon("death");
  self endon("kill_turret");
  config = level.sentrysettings[self.sentrytype];
  self setmode(config.sentrymodeoff);
  self.turreton = 0;

  while(true) {
    turrettrigger waittill("trigger", player);

    if(!istrue(self.turreton)) {
      self.turreton = 1;
      self setmode(config.sentrymodeon);

      while(isalive(player) && player istouching(turrettrigger)) {
        waitframe();
      }

      self.turreton = 0;
      self setmode(config.sentrymodeoff);
      self notify("stop_shooting");
    }
  }
}

function function_76189206d67bd21c(data) {
  if(isDefined(data.attacker)) {
    if(issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[getsharedfunc("player", "doScoreEvent")]]("disabled_sentry_gun");
    }

    if(issharedfuncdefined("sentry_gun", "empStarted")) {
      self[[getsharedfunc("sentry_gun", "empStarted")]]();
    }
  }

  function_e3217606f8218ae();
}

function function_1ef2976b1357c651(isdeath) {
  if(isdeath) {
    return;
  }

  if(issharedfuncdefined("sentry_gun", "empStarted")) {
    self[[getsharedfunc("sentry_gun", "empCleared")]]();
  }

  function_e3217606f8218ae();
}

function function_e3217606f8218ae() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    self laseroff();
    return;
  }

  if(!istrue(self.killed)) {
    self turretfireenable();
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
    self laseron();
  }
}

function function_fc46b0f912ca62f() {
  level endon("<dev string:x64>");
  setdvarifuninitialized(@ "hash_46a2f7c9bc7efd38", 0);

  while(true) {
    if(getdvarint(@ "hash_46a2f7c9bc7efd38", 0) == 1) {
      foreach(loc in level.aisentryturrets.var_fd5ea9cb37c309d3) {
        color = (1, 0, 0);

        if(istrue(loc.var_1b096843a2175f92)) {
          color = (0, 1, 0);
          leftarc = level.sentrysettings["<dev string:x72>"].leftarc;
          rightarc = level.sentrysettings["<dev string:x72>"].rightarc;
          startpoint = loc.origin + (0, 0, 60);
          scripts\stealth\debug::draw_arc(startpoint, 0 - rightarc, leftarc, loc.angles, 100, 1, 5, color);
        }

        sphere(loc.origin, 64, color);
      }
    }

    waitframe();
  }
}

function debug_text(text, time) {
  stoptime = gettime() + time;

  while(gettime() < stoptime) {
    printtoscreen2d(750, 100, text, (0, 0, 1), 2.5);

    waitframe();
  }
}

# /