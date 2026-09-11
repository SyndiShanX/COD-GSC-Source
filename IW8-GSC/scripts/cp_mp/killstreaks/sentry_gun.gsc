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

function weaponcleanupsentryturret(var0, var1, var2) {
  if(!istrue(var1)) {
    scripts\cp_mp\killstreaks\killstreakdeploy::rocket_fuel(var2);
    return;
  }
}

function tryusesentryturret(var0) {
  var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var0, self);
  return tryusesentryturretfromstruct(var1);
}

function tryusesentryturretfromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      self.bgivensentry = 0;
      return false;
    }
  }

  scripts\cp_mp\utility\weapon_utility::ref_12eb2();
  var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var0, getcompleteweaponname("deploy_sentry_mp"), 1, undefined, undefined, &weaponcleanupsentryturret);

  if(!istrue(var1)) {
    self.bgivensentry = 0;
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      self.bgivensentry = 0;
      return false;
    }
  }

  scripts\cp_mp\killstreaks\manual_turret::ref_11acc(0);
  var2 = sentryturret_create("sentry_turret", var0);

  if(!isDefined(var2)) {
    scripts\cp_mp\killstreaks\manual_turret::ref_11acc(1);
    self.bgivensentry = 0;
    return false;
  }

  var3 = sentryturret_watchplacement(var2, var0, 0, 1.25);

  if(!isDefined(var3)) {
    scripts\cp_mp\killstreaks\manual_turret::ref_11acc(1);
    var2 delete();
    self.bgivensentry = 0;
    return false;
  }

  var2 scripts\cp_mp\emp_debuff::set_start_emp_callback(&sentryturret_empstarted);
  var2 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&sentryturret_empcleared);
  scripts\cp_mp\killstreaks\manual_turret::ref_11acc(1);
  sentryturret_setplaced(var2, var3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "munitionUsed")]]();
  }

  return true;
}

function sentryturret_watchplacement(var0, var1, var2, var3) {
  self.bgivensentry = 1;
  var0 laseroff();
  thread sentryturret_delayplacementinstructions(var3);
  var4 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  }

  if(var4) {
    thread ref_13029();
  }

  var5 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "watchForPlayerEnteringLastStand")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "watchForPlayerEnteringLastStand")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "getTargetMarker")) {
    var5 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "getTargetMarker")]](var1, var2);
  }

  self notify("turret_placement_finished");

  if(!isDefined(var5) || !isDefined(var5.location)) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("deploy_sentry_mp");
    }

    return undefined;
  }

  var0 thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(self, 1, 1);

  if(self hasweapon("deploy_sentry_mp")) {
    thread scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("deploy_sentry_mp", 1, 1);
  }

  var6 = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var6);
  return var5;
}

function ref_13029() {
  self endon("turret_placement_finished");
  self endon("death_or_disconnect");
  self waittill("last_stand_start");
  self notify("equip_deploy_cancel");
}

function sentryturret_delayplacementinstructions(var0) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  self setclientomnvar("ui_turret_placement", 1);
  thread scripts\cp_mp\killstreaks\manual_turret::ref_11ac6("death");
  thread scripts\cp_mp\killstreaks\manual_turret::ref_11ac6("turret_placement_finished");
}

function sentryturret_create(var0, var1) {
  var2 = level.sentrysettings[var0];
  var3 = spawnturret("misc_turret", self.origin, level.sentrysettings[var0].weaponinfo);
  var3.owner = self;
  var3.team = self.team;
  var3.angles = self.angles;
  var3.health = 9999;
  var3.maxhealth = var2.maxhealth;
  var3.streakinfo = var1;
  var3.turrettype = var0;
  var3.shouldsplash = 1;
  var3.ammocount = var2.ammo;
  var3.timeout = var2.timeout;
  var3.carriedby = self;
  sentryturret_setturretmodel(var3, "placed");
  var3 setturretowner(var3.owner);
  var3 setturretteam(var3.team);
  var3 makeunusable();
  var3 setnodeploy(1);
  var3 setdefaultdroppitch(0);
  var3 hide();
  var3 setautorotationdelay(0.2);
  var3.momentum = 0;
  var3.heatlevel = 0;
  var3.overheated = 0;
  var3.cooldownwaittime = 0.1;

  switch (var0) {
    case "sentry_turret":
    default:
      var3 maketurretinoperable();
      var3 setleftarc(80);
      var3 setrightarc(80);
      var3 setbottomarc(50);
      var3 settoparc(60);
      var3 setconvergencetime(0.6, "pitch");
      var3 setconvergencetime(0.6, "yaw");
      var3 setconvergenceheightpercent(0.65);
      var3 setdefaultdroppitch(-89);
      break;
  }

  var3 setturretmodechangewait(1);
  var3 scripts\cp_mp\emp_debuff::allow_emp(0);
  var5 = anglesToForward(var3.angles);
  var6 = var3 gettagorigin("tag_laser") + (0, 0, 10);
  var6 -= var5 * 20;
  var7 = spawn("script_model", var6);
  var7 linkTo(var3);
  var3.killcament = var7;
  var3.helperdrone_isbeingpingedbydrone = spawn("script_model", var3.origin);
  var3.helperdrone_isbeingpingedbydrone.team = var3.team;
  var3.helperdrone_isbeingpingedbydrone.owner = var3.owner;
  var3.helperdrone_isbeingpingedbydrone setModel("weapon_vm_mg_sentry_turret_invis_base");
  var3.helperdrone_isbeingpingedbydrone dontinterpolate();
  var3.helperdrone_isbeingpingedbydrone hide();
  var8 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  }

  if(var8) {
    var3.helperdrone_monitorcollision = spawn("script_model", var3.origin);
    var3.helperdrone_monitorcollision.team = var3.team;
    var3.helperdrone_monitorcollision.owner = var3.owner;
    var3.helperdrone_monitorcollision setModel("weapon_vm_mg_sentry_turret_invis_base_vehicle");
    var3.helperdrone_monitorcollision dontinterpolate();
    var3.helperdrone_monitorcollision hide();
  }

  return var3;
}

function sentryturret_setplaced(var0, var1) {
  var2 = level.sentrysettings[var0.turrettype];
  sentryturret_setturretmodel(var0, "placed");

  if(!isDefined(self.placedsentries)) {
    self.placedsentries = [];
  }

  if(!isDefined(self.placedsentries[var0.turrettype])) {
    self.placedsentries[var0.turrettype] = [];
  }

  if(istrue(var0.shouldsplash)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var0.streakinfo.streakname);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var0.origin, 2048, var0.streakinfo.streakname);
    }

    var3 = var2.teamsplash;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var3, self);
    }

    var0.shouldsplash = 0;
  }

  var4 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  }

  var0 show();
  var0 dontinterpolate();
  var0.angles = var1.angles;
  var0.carriedby = undefined;

  if(isDefined(var1.moving_platform)) {
    var0.moving_platform = var1.moving_platform;
    var0.ref_11dbe = var1.ref_11dbe;
    var0.ref_11dbd = var1.ref_11dbd;
  }

  self.bgivensentry = 0;
  var0.origin = var1.location;
  var0 playSound("sentry_gun_plant");
  var0.helperdrone_isbeingpingedbydrone show();
  var0.helperdrone_isbeingpingedbydrone.angles = var0.angles;
  var0.helperdrone_isbeingpingedbydrone.origin = var0.origin;
  var5 = var0.helperdrone_isbeingpingedbydrone;

  if(var4) {
    var0.helperdrone_monitorcollision show();
    var0.helperdrone_monitorcollision.angles = var0.angles;
    var0.helperdrone_monitorcollision.origin = var0.origin;
    var0.helperdrone_isbeingpingedbydrone linkTo(var0, "tag_turret");
    var0.helperdrone_monitorcollision linkTo(var0, "tag_turret");
    var0.helperdrone_monitorcollision linkTo(var0, "tag_aim_pivot");
    var5 = var0.helperdrone_monitorcollision;
  } else {
    var0.helperdrone_isbeingpingedbydrone linkTo(var0, "tag_aim_pivot");
  }

  thread ref_13023(var0, var0);
  var6 = self.placedsentries[var0.turrettype].size;
  self.placedsentries[var0.turrettype][var6] = var0;

  if(var6 + 1 > 2) {
    self.placedsentries[var0.turrettype][0] notify("kill_turret", 0, 0);
  }

  var7 = 70;

  if(var0.model == level.sentrysettings[var0.turrettype].modelbasecover) {
    var7 = 35;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var0.turrettype, "Killstreak_Ground", self, 0, 1, var7, "carried");
  }

  var0 setmode(level.sentrysettings[var0.turrettype].sentrymodeon);
  var8 = "bi_base";

  if(!isDefined(var0.useownerobj)) {
    var9 = var0 gettagorigin(var8);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "createHintObject")) {
      var0.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "createHintObject")]](var9, "HINT_BUTTON", undefined, var2.ownerusehintstring);
    }
  } else {
    var9 = var1 gettagorigin(var9);
    var1.useownerobj makeusable();
    var1.useownerobj dontinterpolate();
    var1.useownerobj.origin = var9;
  }

  var1.useownerobj linkTo(var1, var9);

  foreach(var11 in level.players) {
    if(var11 != var1.owner) {
      var1.useownerobj disableplayeruse(var11);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "handleMovingPlatform")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "handleMovingPlatform")]](var1);
  }

  var1 scripts\cp_mp\emp_debuff::allow_emp(1);
  var1 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Static", self);
  sentryturret_empupdate(var1);
  ref_13020(var1);
  thread sentry_attacktargets();
  thread sentry_beepsounds();
  thread sentryturret_delaydeletemarker(var1, var2);
  thread sentryturret_watchpickup(var1);
  thread sentryturret_watchdamage(var1);
  thread sentryturret_watchdeath(var1);
  thread sentryturret_watchtimeout(var1);
  thread sentryturret_watchdisown(var1);
  thread ref_13028(var1);
  var1 notify("turret_place_successful");
}

function sentryturret_setcarried(var0) {
  var0 endon("kill_turret");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(createheadicon(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
    self notify("switched_from_minigun");

    while(createheadicon(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
      waitframe();
    }
  }

  if(isDefined(var0.moving_platform)) {
    var0.moving_platform = undefined;
    var0.ref_11dbe = undefined;
    var0.ref_11dbd = undefined;
    var0 unlink();
  }

  var0 scripts\cp_mp\emp_debuff::allow_emp(0);
  var0 scripts\mp\sentientpoolmanager::unregistersentient(var0.sentientpool, var0.sentientpoolindex);
  var1 = var0 getlinkedchildren();

  foreach(var3 in var1) {
    if(isDefined(var3)) {
      var3 unlink();
    }
  }

  if(isDefined(var0.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var0.minimapid);
    }

    var0.minimapid = undefined;
  }

  var5 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  }

  var0.helperdrone_isbeingpingedbydrone unlink();
  var0.helperdrone_isbeingpingedbydrone hide();

  if(var5) {
    var0.helperdrone_monitorcollision unlink();
    var0.helperdrone_monitorcollision hide();
  }

  sentryturret_setinactive(var0);
  var0 hide();
  var0.carriedby = self;
  var0 notify("carried");
  var0 playSound("sentry_pickup");
  scripts\cp_mp\utility\weapon_utility::ref_12eb2();
  scripts\cp_mp\utility\inventory_utility::_giveweapon("deploy_sentry_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon("deploy_sentry_mp");
  scripts\cp_mp\killstreaks\manual_turret::ref_11acc(0);
  var6 = sentryturret_watchplacement(var0, var0.streakinfo, 1, 2);

  if(!isDefined(var6)) {
    scripts\cp_mp\killstreaks\manual_turret::ref_11acc(1);
    return 0;
  }

  scripts\cp_mp\killstreaks\manual_turret::ref_11acc(1);
  sentryturret_setplaced(var0, var6);
}

function sentryturret_switchbacklastweapon(var0) {
  if(istrue(var0)) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(self.lastdroppableweaponobj);
  } else {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon("deploy_sentry_mp");
}

function sentryturret_setinactive(var0) {
  var0 setdefaultdroppitch(30);
  var0 setmode(level.sentrysettings[var0.turrettype].sentrymodeoff);
  var0.useownerobj makeunusable();
  var0.useownerobj unlink();
}

function sentryturret_delaydeletemarker(var0, var1) {
  var0 endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(var1.visual)) {
    var1.visual delete();
    return;
  }
}

function sentryturret_disableplayeruseonconnect(var0, var1) {
  if(isDefined(var0)) {
    var0 endon("kill_turret");
    var0 endon("carried");
  }

  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var2);
    var1 disableplayeruse(var2);
  }
}

function sentryturret_watchpickup(var0) {
  var0 endon("kill_turret");
  var0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var0.useownerobj waittill("trigger", var1);

    if(var1 != self) {
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "allowPickupOfTurret")) {
      if(!var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    if(istrue(var1.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
      }

      continue;
    }

    ref_13021(var0);
    var0.useownerobj makeunusable();
    var0 setmode(level.sentrysettings[var0.turrettype].sentrymodeoff);
    self.placedsentries[var0.turrettype] = scripts\engine\utility::array_remove(self.placedsentries[var0.turrettype], var0);
    thread sentryturret_setcarried(var0);
  }
}

function sentryturret_disableplayerpickuponconnect(var0) {
  var0 endon("kill_turret");
  var0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var1);
    var1 waittill("spawned_player");
    var0.useownerobj disableplayeruse(var1);
  }
}

function sentryturret_watchdismantle(var0) {
  var0 endon("kill_turret");
  var0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  foreach(var2 in level.players) {
    if(level.teambased) {
      if(var2.team != self.team) {
        continue;
      }

      continue;
    }

    if(var2 != self) {}
  }

  thread sentryturret_disableplayerdismantleonconnect(var0);

  for(;;) {
    var0.dismantleobj waittill("trigger", var2);
    var0 notify("kill_turret", 0, 1);
    break;
  }
}

function sentryturret_watchdamage(var0) {
  var0 endon("kill_turret");
  var0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "monitorDamage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "monitorDamage")]](var0);
    return;
  }
}

function sentryturret_disableplayerdismantleonconnect(var0) {
  var0 endon("kill_turret");
  var0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var1);
    var1 waittill("spawned_player");

    if(level.teambased) {
      if(var1.team != self.team) {}
    }
  }
}

function sentryturret_empstarted(var0) {
  sentryturret_empupdate();
}

function sentryturret_empcleared(var0) {
  if(var0) {
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

function sentryturret_watchdeath(var0) {
  var0 endon("carried");
  var0 waittill("kill_turret", var1, var2);

  if(isDefined(self)) {
    self.placedsentries[var0.turrettype] = scripts\engine\utility::array_remove(self.placedsentries[var0.turrettype], var0);
    sentryturret_setinactive(var0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", self);
    }

    var0.streakinfo.onspray = istrue(var2);
    scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var0.streakinfo);
  }

  sentryturret_setturretmodel(var0, "destroyed");
  ref_13021(var0);
  var0 setturretowner(undefined);

  if(!istrue(var1)) {
    var0 playSound("sentry_explode_smoke");
    var0 setscriptablepartstate("shutdown", "on");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    var0 setscriptablepartstate("explode", "regular");
  } else {
    var0 setscriptablepartstate("explode", "violent");
  }

  var0 playSound("mp_equip_destroyed");

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var0.streakinfo);
  }

  if(isDefined(var0.killcament)) {
    var0.killcament delete();
  }

  if(isDefined(var0.useownerobj)) {
    var0.useownerobj delete();
  }

  if(isDefined(var0.useotherobj)) {
    var0.useotherobj delete();
  }

  if(isDefined(var0.helperdrone_isbeingpingedbydrone)) {
    var0.helperdrone_isbeingpingedbydrone delete();
  }

  if(isDefined(var0.helperdrone_monitorcollision)) {
    var0.helperdrone_monitorcollision delete();
  }

  if(isDefined(var0.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var0.minimapid);
    }

    var0.minimapid = undefined;
  }

  wait 0.2;
  var0 delete();
}

function sentryturret_delayscriptabledelete() {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

function sentryturret_watchtimeout(var0) {
  var0 endon("kill_turret");
  var0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(var0.timeout > 0) {
    var0.timeout -= 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDialogOnPlayer")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDialogOnPlayer")]]("destroyed_" + var0.streakinfo.streakname, undefined, undefined, self.origin);
  }

  var0 notify("kill_turret", 0, 0);
}

function sentryturret_watchdisown(var0) {
  var0 endon("kill_turret");
  var0 endon("carried");
  scripts\engine\utility::ref_143a6("disconnect", "joined_team", "joined_spectators");
  var0 notify("kill_turret", 0, 0);
}

function ref_13028(var0) {
  var0 endon("kill_turret");
  var0 endon("carried");
  level waittill("game_ended");
  var0 notify("kill_turret", 0, 0);
}

function sentryturret_setturretmodel(var0) {
  var1 = undefined;

  if(var0 == "placed") {
    var1 = level.sentrysettings[self.turrettype].modelbaseground;
  } else {
    var1 = level.sentrysettings[self.turrettype].modeldestroyedground;
  }

  self setModel(var1);
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
  var0 = weaponfiretime(level.sentrysettings[self.turrettype].weaponinfo);
  var1 = level.sentrysettings[self.turrettype].burstmin;
  var2 = level.sentrysettings[self.turrettype].burstmax;
  var3 = level.sentrysettings[self.turrettype].pausemin;
  var4 = level.sentrysettings[self.turrettype].pausemax;
  var5 = level.sentrysettings[self.turrettype].lockstrength;

  for(;;) {
    var6 = randomintrange(var1, var2 + 1);

    for(var7 = 0; var7 < var6 && !self.overheated; var7++) {
      self shootturret("tag_flash", var5);
      self.streakinfo.shots_fired++;
      wait var0;
    }

    wait randomfloatrange(var3, var4);
  }
}

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function turret_heatmonitor() {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  var0 = level.sentrysettings[self.turrettype].overheattime;

  for(;;) {
    if(self.heatlevel > var0) {
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

function ref_13023(var0, var1) {
  self.owner endon("disconnect");
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  var2 = "icon_minimap_sentry";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var0.minimapid = var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](var2, var0.team, undefined, 1, 1);
  }

  scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var0.minimapid, var0.owner);
}

function ref_13020() {
  var0 = _calloutmarkerping_handleluinotify_brinventoryslotrequest::ref_12f67(self.origin, 140, 20);
  var1 = undefined;
  var2 = 0;

  foreach(var4 in var0) {
    var5 = distancesquared(var4.origin, self.origin);

    if(isDefined(var1) && var2 <= var5) {
      continue;
    }

    var1 = var4;
    var2 = var5;
  }

  if(isDefined(var1)) {
    var7 = var1 scriptabledoorangle();
    var8 = abs(var7) > 25;
    var9 = undefined;

    foreach(var11 in var0) {
      if(var11 == var1) {
        continue;
      }

      if(distancesquared(var11.heli_intro_vo_done, var1.heli_intro_vo_done) < 3600) {
        var9 = var11;
        break;
      }
    }

    var13 = 1;

    if(isDefined(var9)) {
      var14 = var9 scriptabledoorangle();
      var13 = abs(var14) > 25;
    }

    if(var2 < 3600 && var8) {
      var1.tutonplayerkilled = 1;
      var1 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "tac_cover_door");
      self.concussionused = var1;

      if(isDefined(var9) && var13) {
        var9.tutonplayerkilled = 1;
        var9 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "tac_cover_door");
        self.concusspushstart = var9;
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