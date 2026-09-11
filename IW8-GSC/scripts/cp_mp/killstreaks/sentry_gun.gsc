/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\sentry_gun.gsc
****************************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "init")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "initSentrySettings")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "initSentrySettings")]]();
    return;
  }
}

function weaponcleanupsentryturret(var_0, var_1, var_2) {
  if(!istrue(var_1)) {
    scripts\cp_mp\killstreaks\killstreakdeploy::rocket_fuel(var_2);
    return;
  }
}

function tryusesentryturret(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryusesentryturretfromstruct(var_1);
}

function tryusesentryturretfromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      self.bgivensentry = 0;
      return false;
    }
  }

  scripts\cp_mp\utility\weapon_utility::ref_12eb2();
  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, getcompleteweaponname("deploy_sentry_mp"), 1, undefined, undefined, &weaponcleanupsentryturret);

  if(!istrue(var_1)) {
    self.bgivensentry = 0;
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      self.bgivensentry = 0;
      return false;
    }
  }

  scripts\cp_mp\killstreaks\manual_turret::ref_11acc(0);
  var_2 = sentryturret_create("sentry_turret", var_0);

  if(!isDefined(var_2)) {
    scripts\cp_mp\killstreaks\manual_turret::ref_11acc(1);
    self.bgivensentry = 0;
    return false;
  }

  var_3 = sentryturret_watchplacement(var_2, var_0, 0, 1.25);

  if(!isDefined(var_3)) {
    scripts\cp_mp\killstreaks\manual_turret::ref_11acc(1);
    var_2 delete();
    self.bgivensentry = 0;
    return false;
  }

  var_2 scripts\cp_mp\emp_debuff::set_start_emp_callback(&sentryturret_empstarted);
  var_2 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&sentryturret_empcleared);
  scripts\cp_mp\killstreaks\manual_turret::ref_11acc(1);
  sentryturret_setplaced(var_2, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "munitionUsed")]]();
  }

  return true;
}

function sentryturret_watchplacement(var_0, var_1, var_2, var_3) {
  self.bgivensentry = 1;
  var_0 laseroff();
  thread sentryturret_delayplacementinstructions(var_3);
  var_4 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  }

  if(var_4) {
    thread ref_13029();
  }

  var_5 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "watchForPlayerEnteringLastStand")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "watchForPlayerEnteringLastStand")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "getTargetMarker")) {
    var_5 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "getTargetMarker")]](var_1, var_2);
  }

  self notify("turret_placement_finished");

  if(!isDefined(var_5) || !isDefined(var_5.location)) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("deploy_sentry_mp");
    }

    return undefined;
  }

  var_0 thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(self, 1, 1);

  if(self hasweapon("deploy_sentry_mp")) {
    thread scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("deploy_sentry_mp", 1, 1);
  }

  var_6 = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6);
  return var_5;
}

function ref_13029() {
  self endon("turret_placement_finished");
  self endon("death_or_disconnect");
  self waittill("last_stand_start");
  self notify("equip_deploy_cancel");
}

function sentryturret_delayplacementinstructions(var_0) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setclientomnvar("ui_turret_placement", 1);
  thread scripts\cp_mp\killstreaks\manual_turret::ref_11ac6("death");
  thread scripts\cp_mp\killstreaks\manual_turret::ref_11ac6("turret_placement_finished");
}

function sentryturret_create(var_0, var_1) {
  var_2 = level.sentrysettings[var_0];
  var_3 = spawnturret("misc_turret", self.origin, level.sentrysettings[var_0].weaponinfo);
  var_3.owner = self;
  var_3.team = self.team;
  var_3.angles = self.angles;
  var_3.health = 9999;
  var_3.maxhealth = var_2.maxhealth;
  var_3.streakinfo = var_1;
  var_3.turrettype = var_0;
  var_3.shouldsplash = 1;
  var_3.ammocount = var_2.ammo;
  var_3.timeout = var_2.timeout;
  var_3.carriedby = self;
  sentryturret_setturretmodel(var_3, "placed");
  var_3 setturretowner(var_3.owner);
  var_3 setturretteam(var_3.team);
  var_3 makeunusable();
  var_3 setnodeploy(1);
  var_3 setdefaultdroppitch(0);
  var_3 hide();
  var_3 setautorotationdelay(0.2);
  var_3.momentum = 0;
  var_3.heatlevel = 0;
  var_3.overheated = 0;
  var_3.cooldownwaittime = 0.1;

  switch (var_0) {
    case "sentry_turret":
    default:
      var_3 maketurretinoperable();
      var_3 setleftarc(80);
      var_3 setrightarc(80);
      var_3 setbottomarc(50);
      var_3 settoparc(60);
      var_3 setconvergencetime(0.6, "pitch");
      var_3 setconvergencetime(0.6, "yaw");
      var_3 setconvergenceheightpercent(0.65);
      var_3 setdefaultdroppitch(-89);
      break;
  }

  var_3 setturretmodechangewait(1);
  var_3 scripts\cp_mp\emp_debuff::allow_emp(0);
  var_5 = anglesToForward(var_3.angles);
  var_6 = var_3 gettagorigin("tag_laser") + (0, 0, 10);
  var_6 -= var_5 * 20;
  var_7 = spawn("script_model", var_6);
  var_7 linkTo(var_3);
  var_3.killcament = var_7;
  var_3.helperdrone_isbeingpingedbydrone = spawn("script_model", var_3.origin);
  var_3.helperdrone_isbeingpingedbydrone.team = var_3.team;
  var_3.helperdrone_isbeingpingedbydrone.owner = var_3.owner;
  var_3.helperdrone_isbeingpingedbydrone setModel("weapon_vm_mg_sentry_turret_invis_base");
  var_3.helperdrone_isbeingpingedbydrone dontinterpolate();
  var_3.helperdrone_isbeingpingedbydrone hide();
  var_8 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  }

  if(var_8) {
    var_3.helperdrone_monitorcollision = spawn("script_model", var_3.origin);
    var_3.helperdrone_monitorcollision.team = var_3.team;
    var_3.helperdrone_monitorcollision.owner = var_3.owner;
    var_3.helperdrone_monitorcollision setModel("weapon_vm_mg_sentry_turret_invis_base_vehicle");
    var_3.helperdrone_monitorcollision dontinterpolate();
    var_3.helperdrone_monitorcollision hide();
  }

  return var_3;
}

function sentryturret_setplaced(var_0, var_1) {
  var_2 = level.sentrysettings[var_0.turrettype];
  sentryturret_setturretmodel(var_0, "placed");

  if(!isDefined(self.placedsentries)) {
    self.placedsentries = [];
  }

  if(!isDefined(self.placedsentries[var_0.turrettype])) {
    self.placedsentries[var_0.turrettype] = [];
  }

  if(istrue(var_0.shouldsplash)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakinfo.streakname);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var_0.origin, 2048, var_0.streakinfo.streakname);
    }

    var_3 = var_2.teamsplash;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var_3, self);
    }

    var_0.shouldsplash = 0;
  }

  var_4 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  }

  var_0 show();
  var_0 dontinterpolate();
  var_0.angles = var_1.angles;
  var_0.carriedby = undefined;

  if(isDefined(var_1.moving_platform)) {
    var_0.moving_platform = var_1.moving_platform;
    var_0.ref_11dbe = var_1.ref_11dbe;
    var_0.ref_11dbd = var_1.ref_11dbd;
  }

  self.bgivensentry = 0;
  var_0.origin = var_1.location;
  var_0 playSound("sentry_gun_plant");
  var_0.helperdrone_isbeingpingedbydrone show();
  var_0.helperdrone_isbeingpingedbydrone.angles = var_0.angles;
  var_0.helperdrone_isbeingpingedbydrone.origin = var_0.origin;
  var_5 = var_0.helperdrone_isbeingpingedbydrone;

  if(var_4) {
    var_0.helperdrone_monitorcollision show();
    var_0.helperdrone_monitorcollision.angles = var_0.angles;
    var_0.helperdrone_monitorcollision.origin = var_0.origin;
    var_0.helperdrone_isbeingpingedbydrone linkTo(var_0, "tag_turret");
    var_0.helperdrone_monitorcollision linkTo(var_0, "tag_turret");
    var_0.helperdrone_monitorcollision linkTo(var_0, "tag_aim_pivot");
    var_5 = var_0.helperdrone_monitorcollision;
  } else {
    var_0.helperdrone_isbeingpingedbydrone linkTo(var_0, "tag_aim_pivot");
  }

  thread ref_13023(var_0, var_0);
  var_6 = self.placedsentries[var_0.turrettype].size;
  self.placedsentries[var_0.turrettype][var_6] = var_0;

  if(var_6 + 1 > 2) {
    self.placedsentries[var_0.turrettype][0] notify("kill_turret", 0, 0);
  }

  var_7 = 70;

  if(var_0.model == level.sentrysettings[var_0.turrettype].modelbasecover) {
    var_7 = 35;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_0.turrettype, "Killstreak_Ground", self, 0, 1, var_7, "carried");
  }

  var_0 setmode(level.sentrysettings[var_0.turrettype].sentrymodeon);
  var_8 = "bi_base";

  if(!isDefined(var_0.useownerobj)) {
    var_9 = var_0 gettagorigin(var_8);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "createHintObject")) {
      var_0.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "createHintObject")]](var_9, "HINT_BUTTON", undefined, var_2.ownerusehintstring);
    }
  } else {
    var_9 = var_1 gettagorigin(var_9);
    var_1.useownerobj makeusable();
    var_1.useownerobj dontinterpolate();
    var_1.useownerobj.origin = var_9;
  }

  var_1.useownerobj linkTo(var_1, var_9);

  foreach(var_11 in level.players) {
    if(var_11 != var_1.owner) {
      var_1.useownerobj disableplayeruse(var_11);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "handleMovingPlatform")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "handleMovingPlatform")]](var_1);
  }

  var_1 scripts\cp_mp\emp_debuff::allow_emp(1);
  var_1 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Static", self);
  sentryturret_empupdate(var_1);
  ref_13020(var_1);
  thread sentry_attacktargets();
  thread sentry_beepsounds();
  thread sentryturret_delaydeletemarker(var_1, var_2);
  thread sentryturret_watchpickup(var_1);
  thread sentryturret_watchdamage(var_1);
  thread sentryturret_watchdeath(var_1);
  thread sentryturret_watchtimeout(var_1);
  thread sentryturret_watchdisown(var_1);
  thread ref_13028(var_1);
  var_1 notify("turret_place_successful");
}

function sentryturret_setcarried(var_0) {
  var_0 endon("kill_turret");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(createheadicon(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
    self notify("switched_from_minigun");

    while(createheadicon(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
      waitframe();
    }
  }

  if(isDefined(var_0.moving_platform)) {
    var_0.moving_platform = undefined;
    var_0.ref_11dbe = undefined;
    var_0.ref_11dbd = undefined;
    var_0 unlink();
  }

  var_0 scripts\cp_mp\emp_debuff::allow_emp(0);
  var_0 scripts\mp\sentientpoolmanager::unregistersentient(var_0.sentientpool, var_0.sentientpoolindex);
  var_1 = var_0 getlinkedchildren();

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 unlink();
    }
  }

  if(isDefined(var_0.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0.minimapid);
    }

    var_0.minimapid = undefined;
  }

  var_5 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  }

  var_0.helperdrone_isbeingpingedbydrone unlink();
  var_0.helperdrone_isbeingpingedbydrone hide();

  if(var_5) {
    var_0.helperdrone_monitorcollision unlink();
    var_0.helperdrone_monitorcollision hide();
  }

  sentryturret_setinactive(var_0);
  var_0 hide();
  var_0.carriedby = self;
  var_0 notify("carried");
  var_0 playSound("sentry_pickup");
  scripts\cp_mp\utility\weapon_utility::ref_12eb2();
  scripts\cp_mp\utility\inventory_utility::_giveweapon("deploy_sentry_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon("deploy_sentry_mp");
  scripts\cp_mp\killstreaks\manual_turret::ref_11acc(0);
  var_6 = sentryturret_watchplacement(var_0, var_0.streakinfo, 1, 2);

  if(!isDefined(var_6)) {
    scripts\cp_mp\killstreaks\manual_turret::ref_11acc(1);
    return 0;
  }

  scripts\cp_mp\killstreaks\manual_turret::ref_11acc(1);
  sentryturret_setplaced(var_0, var_6);
}

function sentryturret_switchbacklastweapon(var_0) {
  if(istrue(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(self.lastdroppableweaponobj);
  } else {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon("deploy_sentry_mp");
}

function sentryturret_setinactive(var_0) {
  var_0 setdefaultdroppitch(30);
  var_0 setmode(level.sentrysettings[var_0.turrettype].sentrymodeoff);
  var_0.useownerobj makeunusable();
  var_0.useownerobj unlink();
}

function sentryturret_delaydeletemarker(var_0, var_1) {
  var_0 endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(var_1.visual)) {
    var_1.visual delete();
    return;
  }
}

function sentryturret_disableplayeruseonconnect(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 endon("kill_turret");
    var_0 endon("carried");
  }

  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_2);
    var_1 disableplayeruse(var_2);
  }
}

function sentryturret_watchpickup(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0.useownerobj waittill("trigger", var_1);

    if(var_1 != self) {
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "allowPickupOfTurret")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    if(istrue(var_1.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
      }

      continue;
    }

    ref_13021(var_0);
    var_0.useownerobj makeunusable();
    var_0 setmode(level.sentrysettings[var_0.turrettype].sentrymodeoff);
    self.placedsentries[var_0.turrettype] = scripts\engine\utility::array_remove(self.placedsentries[var_0.turrettype], var_0);
    thread sentryturret_setcarried(var_0);
  }
}

function sentryturret_disableplayerpickuponconnect(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_1);
    var_1 waittill("spawned_player");
    var_0.useownerobj disableplayeruse(var_1);
  }
}

function sentryturret_watchdismantle(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  foreach(var_2 in level.players) {
    if(level.teambased) {
      if(var_2.team != self.team) {
        continue;
      }

      continue;
    }

    if(var_2 != self) {}
  }

  thread sentryturret_disableplayerdismantleonconnect(var_0);

  for(;;) {
    var_0.dismantleobj waittill("trigger", var_2);
    var_0 notify("kill_turret", 0, 1);
    break;
  }
}

function sentryturret_watchdamage(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "monitorDamage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "monitorDamage")]](var_0);
    return;
  }
}

function sentryturret_disableplayerdismantleonconnect(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_1);
    var_1 waittill("spawned_player");

    if(level.teambased) {
      if(var_1.team != self.team) {}
    }
  }
}

function sentryturret_empstarted(var_0) {
  sentryturret_empupdate();
}

function sentryturret_empcleared(var_0) {
  if(var_0) {
    return;
  }

  sentryturret_empupdate();
}

function sentryturret_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    self laseroff();
    return;
  }

  self turretfireenable();
  self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
}

function sentryturret_watchdeath(var_0) {
  var_0 endon("carried");
  var_0 waittill("kill_turret", var_1, var_2);

  if(isDefined(self)) {
    self.placedsentries[var_0.turrettype] = scripts\engine\utility::array_remove(self.placedsentries[var_0.turrettype], var_0);
    sentryturret_setinactive(var_0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", self);
    }

    var_0.streakinfo.onspray = istrue(var_2);
    scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_0.streakinfo);
  }

  sentryturret_setturretmodel(var_0, "destroyed");
  ref_13021(var_0);
  var_0 setturretowner(undefined);

  if(!istrue(var_1)) {
    var_0 playSound("sentry_explode_smoke");
    var_0 setscriptablepartstate("shutdown", "on");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    var_0 setscriptablepartstate("explode", "regular");
  } else {
    var_0 setscriptablepartstate("explode", "violent");
  }

  var_0 playSound("mp_equip_destroyed");

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_0.streakinfo);
  }

  if(isDefined(var_0.killcament)) {
    var_0.killcament delete();
  }

  if(isDefined(var_0.useownerobj)) {
    var_0.useownerobj delete();
  }

  if(isDefined(var_0.useotherobj)) {
    var_0.useotherobj delete();
  }

  if(isDefined(var_0.helperdrone_isbeingpingedbydrone)) {
    var_0.helperdrone_isbeingpingedbydrone delete();
  }

  if(isDefined(var_0.helperdrone_monitorcollision)) {
    var_0.helperdrone_monitorcollision delete();
  }

  if(isDefined(var_0.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0.minimapid);
    }

    var_0.minimapid = undefined;
  }

  wait 0.2;
  var_0 delete();
}

function sentryturret_delayscriptabledelete() {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

function sentryturret_watchtimeout(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(var_0.timeout > 0) {
    var_0.timeout -= 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDialogOnPlayer")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDialogOnPlayer")]]("destroyed_" + var_0.streakinfo.streakname, undefined, undefined, self.origin);
  }

  var_0 notify("kill_turret", 0, 0);
}

function sentryturret_watchdisown(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  scripts\engine\utility::ref_143a6("disconnect", "joined_team", "joined_spectators");
  var_0 notify("kill_turret", 0, 0);
}

function ref_13028(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  level waittill("game_ended");
  var_0 notify("kill_turret", 0, 0);
}

function sentryturret_setturretmodel(var_0) {
  var_1 = undefined;

  if(var_0 == "placed") {
    var_1 = level.sentrysettings[self.turrettype].modelbaseground;
  } else {
    var_1 = level.sentrysettings[self.turrettype].modeldestroyedground;
  }

  self setModel(var_1);
}

function sentry_attacktargets() {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  self.momentum = 0;

  for(;;) {
    self waittill("turretstatechange");

    if(self isfiringturret()) {
      self laseron();
      thread sentry_burstfirestart();
      continue;
    }

    self laseroff();
    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

function sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_target_lock_beep");
  wait 0.19;
  self playSound("sentry_gun_target_lock_beep");
}

function sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.turrettype].spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function sentry_spindown() {
  self.momentum = 0;
}

function sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  sentry_spinup();
  var_0 = weaponfiretime(level.sentrysettings[self.turrettype].weaponinfo);
  var_1 = level.sentrysettings[self.turrettype].burstmin;
  var_2 = level.sentrysettings[self.turrettype].burstmax;
  var_3 = level.sentrysettings[self.turrettype].pausemin;
  var_4 = level.sentrysettings[self.turrettype].pausemax;
  var_5 = level.sentrysettings[self.turrettype].lockstrength;

  for(;;) {
    var_6 = randomintrange(var_1, var_2 + 1);

    for(var_7 = 0; var_7 < var_6 && !self.overheated; var_7++) {
      self shootturret("tag_flash", var_5);
      self.streakinfo.shots_fired++;
      wait var_0;
    }

    wait randomfloatrange(var_3, var_4);
  }
}

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function turret_heatmonitor() {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  var_0 = level.sentrysettings[self.turrettype].overheattime;

  for(;;) {
    if(self.heatlevel > var_0) {
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
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait level.sentrysettings[self.turrettype].fxtime;
  }
}

function turret_coolmonitor() {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");

  for(;;) {
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

function sentry_beepsounds() {
  self endon("death");
  self endon("carried");
  self endon("kill_turret");
  level endon("game_ended");

  for(;;) {
    wait 3;

    if(self isfiringturret()) {
      waitframe();
      continue;
    }

    self playSound("sentry_gun_beep");
  }
}

function ref_13023(var_0, var_1) {
  self.owner endon("disconnect");
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  var_2 = "icon_minimap_sentry";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_0.minimapid = var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](var_2, var_0.team, undefined, 1, 1);
  }

  scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var_0.minimapid, var_0.owner);
}

function ref_13020() {
  var_0 = _calloutmarkerping_handleluinotify_brinventoryslotrequest::ref_12f67(self.origin, 140, 20);
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_5 = distancesquared(var_4.origin, self.origin);

    if(isDefined(var_1) && var_2 <= var_5) {
      continue;
    }

    var_1 = var_4;
    var_2 = var_5;
  }

  if(isDefined(var_1)) {
    var_7 = var_1 scriptabledoorangle();
    var_8 = abs(var_7) > 25;
    var_9 = undefined;

    foreach(var_11 in var_0) {
      if(var_11 == var_1) {
        continue;
      }

      if(distancesquared(var_11.heli_intro_vo_done, var_1.heli_intro_vo_done) < 3600) {
        var_9 = var_11;
        break;
      }
    }

    var_13 = 1;

    if(isDefined(var_9)) {
      var_14 = var_9 scriptabledoorangle();
      var_13 = abs(var_14) > 25;
    }

    if(var_2 < 3600 && var_8) {
      var_1.tutonplayerkilled = 1;
      var_1 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "tac_cover_door");
      self.concussionused = var_1;

      if(isDefined(var_9) && var_13) {
        var_9.tutonplayerkilled = 1;
        var_9 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "tac_cover_door");
        self.concusspushstart = var_9;
      }
    }
  }

  return false;
}

function ref_13021() {
  if(isDefined(self.concussionused)) {
    self.concussionused _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(0, "tac_cover_door");
    self.concussionused.tutonplayerkilled = undefined;
    self.concussionused = undefined;
  }

  if(isDefined(self.concusspushstart)) {
    self.concusspushstart _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(0, "tac_cover_door");
    self.concusspushstart.tutonplayerkilled = undefined;
    self.concusspushstart = undefined;
    return;
  }
}