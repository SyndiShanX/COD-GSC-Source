/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\manual_turret.gsc
*******************************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "init")]]();
  }

  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("manual_turret", "on", 10);
}

function weaponcleanupmanualturret(var_0, var_1, var_2) {
  if(!istrue(var_1)) {
    scripts\cp_mp\killstreaks\killstreakdeploy::rocket_fuel(var_2);
    return;
  }
}

function tryusemanualturret(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryusemanualturretfromstruct(var_1);
}

function tryusemanualturretfromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  scripts\cp_mp\utility\weapon_utility::ref_12EB2();
  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, getcompleteweaponname("deploy_manual_turret_mp"), 1, undefined, undefined, &weaponcleanupmanualturret);

  if(!istrue(var_1)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  ref_11ACC(0);
  var_2 = manualturret_create("manual_turret", var_0);

  if(!isDefined(var_2)) {
    ref_11ACC(1);
    return false;
  }

  var_3 = manualturret_watchplacement(var_2, var_0, 0, 1.25);

  if(!isDefined(var_3)) {
    ref_11ACC(1);
    var_2 delete();
    return false;
  }

  ref_11ACC(1);
  manualturret_setplaced(var_2, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "munitionUsed")]]();
  }

  return true;
}

function manualturret_watchplacement(var_0, var_1, var_2, var_3) {
  thread manualturret_delayplacementinstructions(var_3);
  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "watchForPlayerEnteringLastStand")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "watchForPlayerEnteringLastStand")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "getTargetMarker")) {
    var_4 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "getTargetMarker")]](var_1, var_2);
  }

  self notify("turret_placement_finished");

  if(!isDefined(var_4) || !isDefined(var_4.location)) {
    if(istrue(self.inlaststand)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon("deploy_manual_turret_mp");
    } else if(scripts\cp_mp\utility\player_utility::_isalive()) {
      manualturret_switchbacklastweapon("deploy_manual_turret_mp");
    }

    return undefined;
  }

  thread manualturret_disablefire(var_0, self, 1);

  if(self hasweapon("deploy_manual_turret_mp")) {
    thread manualturret_switchbacklastweapon("deploy_manual_turret_mp", 1, 1);
  }

  var_5 = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_5);
  return var_4;
}

function manualturret_delayplacementinstructions(var_0) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setclientomnvar("ui_turret_placement", 1);
  thread ref_11AC6("death");
  thread ref_11AC6("turret_placement_finished");
}

function ref_11AC6(var_0) {
  self endon("cleared_placement");
  self endon("disconnect");
  level endon("game_ended");
  self waittill(var_0);
  self setclientomnvar("ui_turret_placement", 0);
  self notify("cleared_placement");
}

function manualturret_create(var_0, var_1) {
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
  var_3.reticlestate = "reticle_on";
  var_3.timeout = var_2.timeout;
  var_3.carriedby = self;
  manualturret_setturretmodel(var_3, "placed");
  var_3 makeunusable();
  var_3 setnodeploy(1);
  var_3 setdefaultdroppitch(0);
  var_3 hide();
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
  var_3.helperdrone_isbeingpingedbydrone.moverdoesnotkill = 1;
  var_3.helperdrone_isbeingpingedbydrone.ref_13E8D = var_3;
  return var_3;
}

function manualturret_setplaced(var_0, var_1) {
  var_2 = level.sentrysettings[var_0.turrettype];
  manualturret_setturretmodel(var_0, "placed");

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

    var_3 = var_2.teamsplash;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var_3, self);
    }

    var_0.shouldsplash = 0;
  }

  var_0 show();
  var_0 dontinterpolate();
  var_0.angles = var_1.angles;
  var_0.carriedby = undefined;

  if(isDefined(var_1.moving_platform)) {
    var_0.moving_platform = var_1.moving_platform;
    var_0.ref_11DBE = var_1.ref_11DBE;
    var_0.ref_11DBD = var_1.ref_11DBD;
  }

  if(isDefined(self.hideammoindex)) {
    for(var_4 = self.hideammoindex; var_4 >= 1; var_4--) {
      var_0 setscriptablepartstate("hide_ammo_" + var_4, "on", 0);
    }
  }

  var_5 = "off";

  if(var_0.reticlestate == "reticle_off") {
    var_5 = "on";
  }

  var_0 setscriptablepartstate("hide_reticle", var_5, 0);
  var_0.origin = var_1.location;
  var_0 playSound("sentry_gun_plant");
  var_0.helperdrone_isbeingpingedbydrone show();
  var_0.helperdrone_isbeingpingedbydrone.angles = var_0.angles;
  var_0.helperdrone_isbeingpingedbydrone.origin = var_0.origin;
  var_0.helperdrone_isbeingpingedbydrone linkTo(var_0, "tag_aim_pivot");
  var_6 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";

  if(!var_6) {
    var_7 = "icon_minimap_mobileturret";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
      var_0.minimapid = var_0.helperdrone_isbeingpingedbydrone[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](var_7, var_0.team, undefined, 1, 1);
    }
  }

  var_8 = self.placedsentries[var_0.turrettype].size;
  self.placedsentries[var_0.turrettype][var_8] = var_0;

  if(var_8 + 1 > 1) {
    self.placedsentries[var_0.turrettype][0] notify("kill_turret", 0, 0);
  }

  var_9 = 70;

  if(var_0.model == level.sentrysettings[var_0.turrettype].modelbasecover) {
    var_9 = 35;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_0.turrettype, "Killstreak_Ground", self, 0, 1, var_9, "carried_turret");
  }

  var_0 setmode(level.sentrysettings[var_0.turrettype].sentrymodeon);
  var_10 = "j_trigger";

  if(!isDefined(var_0.useownerobj)) {
    var_11 = var_0 gettagorigin(var_10);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "createHintObject")) {
      var_0.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "createHintObject")]](var_11, "HINT_BUTTON", undefined, var_2.ownerusehintstring, -1, "duration_none", undefined, 17, undefined, 17);
    }
  } else {
    var_11 = var_1 gettagorigin(var_11);
    var_1.useownerobj makeusable();
    var_1.useownerobj dontinterpolate();
    var_1.useownerobj.origin = var_11;
  }

  var_1.useownerobj linkTo(var_1, var_11);

  if(!isDefined(var_1.useotherobj)) {
    var_11 = var_1 gettagorigin(var_11);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "createHintObject")) {
      var_1.useotherobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "createHintObject")]](var_11, "HINT_BUTTON", undefined, var_5.otherusehintstring, -1, "duration_none", undefined, 17, undefined, 17);
    }
  } else {
    var_11 = var_1 gettagorigin(var_11);
    var_1.useotherobj makeusable();
    var_1.useotherobj dontinterpolate();
    var_1.useotherobj.origin = var_11;
  }

  var_1.useotherobj linkTo(var_1, var_11);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "handleMovingPlatform")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "handleMovingPlatform")]](var_1);
  }

  var_1 scripts\cp_mp\emp_debuff::allow_emp(1);
  var_1 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Static", self);
  thread manualturret_delaydeletemarker(var_1, self);
  thread manualturret_watchuse(var_1, self);
  thread manualturret_watchuse(var_1, self);
  thread manualturret_watchpickup(var_1);
  thread manualturret_watchdamage(var_1);
  thread manualturret_watchdeath(var_1);
  thread ref_11ACE();
  thread manualturret_watchtimeout(var_1);
  thread manualturret_watchdisown(var_1);
}

function manualturret_setcarried(var_0) {
  self endon("kill_turret");
  var_0 endon("death_or_disconnect");
  var_0 endon("start_turret_use");
  level endon("game_ended");

  if(istrue(self.inuse)) {
    self.inuse = undefined;
    ref_11ACD(var_0, 1);
  }

  if(isDefined(self.moving_platform)) {
    self.moving_platform = undefined;
    self.ref_11DBE = undefined;
    self.ref_11DBD = undefined;
    self unlink();
  }

  scripts\cp_mp\emp_debuff::allow_emp(0);
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  var_1 = self getlinkedchildren();

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 unlink();
    }
  }

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  self.helperdrone_isbeingpingedbydrone hide();
  manualturret_setinactive(var_0, self);
  self hide();
  self.carriedby = var_0;
  self notify("carried_turret");
  self playSound("sentry_pickup");
  var_0 scripts\cp_mp\utility\weapon_utility::ref_12EB2();
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("deploy_manual_turret_mp");
  var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweapon("deploy_manual_turret_mp");
  ref_11ACC(var_0, 0);
  var_5 = manualturret_watchplacement(var_0, self, self.streakinfo, 1, 2);

  if(!isDefined(var_5)) {
    ref_11ACC(var_0, 1);
    return 0;
  }

  ref_11ACC(var_0, 1);
  manualturret_setplaced(var_0, self, var_5);
}

function manualturret_switchbacklastweapon(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 > 0) {
    self endon("death_or_disconnect");
    level endon("game_ended");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  }

  var_3 = scripts\cp_mp\utility\weapon_utility::ref_12CC7(self.lastdroppableweaponobj);

  if(istrue(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_3);
  } else {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
}

function manualturret_setinactive(var_0) {
  var_0 setmode(level.sentrysettings[var_0.turrettype].sentrymodeoff);
  var_0 setturretminimapvisible(0);
  manualturret_makealltriggersusable(var_0, 0);
  var_0.useownerobj unlink();
  var_0.useotherobj unlink();
}

function manualturret_delaydeletemarker(var_0, var_1) {
  self endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(var_1.visual)) {
    var_1.visual delete();
    return;
  }
}

function manualturret_watchuse(var_0, var_1) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("disconnect");
  level endon("game_ended");

  foreach(var_3 in level.players) {
    var_1 enableplayeruse(var_3);

    if(var_1 == self.useownerobj) {
      if(var_3 == var_0) {
        continue;
      }
    } else if(level.teambased && var_3.team == var_0.team && var_3 != var_0) {
      continue;
    }

    var_1 disableplayeruse(var_3);
  }

  thread manualturret_disableplayeruseonconnect(var_0, var_1);

  for(;;) {
    var_1 waittill("trigger", var_3);

    if(istrue(self.inuse)) {
      continue;
    }

    if(istrue(self.ref_138E0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TURRET_DYING");
      }

      continue;
    }

    if(var_3 isonladder() || !var_3 isonground() || var_3 ismantling()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
      }

      continue;
    }

    if(istrue(var_3.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
      }

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "allowPickupOfTurret")) {
      if(!var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    self.inuse = 1;
    ref_11ACD(var_3, 0);
    var_3 disableturretdismount();

    if(var_3 == var_0) {
      var_5 = 0;

      while(isDefined(var_3) && var_3 useButtonPressed() && var_5 < 0.25) {
        waitframe();
        var_5 += level.framedurationseconds;
      }

      if(var_5 >= 0.25) {
        self.inuse = undefined;

        if(isDefined(var_3)) {
          var_3 enableturretdismount();

          if(var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
            ref_11ACD(var_3, 1);
          }
        }

        continue;
      }
    }

    var_3 notify("start_turret_use");
    self.ref_126E2 = var_3;
    manualturret_makealltriggersusable(0);
    var_3 scripts\cp_mp\utility\weapon_utility::ref_12EB2();
    var_3.useweapon = level.sentrysettings[self.turrettype].playerweaponinfo;
    var_3 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3.useweapon, undefined, undefined, 1);
    var_6 = gettime();
    var_7 = undefined;

    while(gettime() - var_6 < 1000) {
      var_7 = ref_11AC8(var_3, var_3.useweapon);

      if(!isDefined(var_7) || istrue(var_7)) {
        break;
      }

      waitframe();
    }

    if(!istrue(var_7)) {
      self.inuse = undefined;
      self.ref_126E2 = undefined;
      manualturret_makealltriggersusable(1);

      if(isDefined(var_3)) {
        if(var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
          ref_11ACD(var_3, 1);
          var_8 = var_3 scripts\cp_mp\utility\weapon_utility::ref_12CC7(var_3.lastdroppableweaponobj);
          var_3 switchtoweaponimmediate(var_8);
        }

        var_3 clearhighpriorityweapon(var_3.useweapon);
        var_3 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3.useweapon);
      }

      continue;
    }

    var_3.currentturret = self;
    var_3 controlturreton(self);

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      var_3 scripts\common\utility::brjugg_oncrateuse(0);
    }

    manualturret_applyoverlay(var_3);
    thread manualturret_disablefire(var_3, 0.5, 1);
    thread manualturret_watchammotracker(var_3);
    thread ref_11AC9(var_3);
    thread ref_11ACA(var_3);
    thread manualturret_endturretusewatch(var_3);
    thread manualturret_endturretonplayer(var_3);
    thread manualturret_watchplayerangles(var_3);
  }
}

function ref_11AC8(var_0, var_1) {
  self endon("kill_turret");
  self endon("turret_switch_weapon_timeout");
  var_0 endon("death_or_disconnect");
  level endon("game_ended");
  thread ref_11ACF(1);
  var_2 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 1);
  self notify("turret_switch_weapon_ended");
  return var_2;
}

function ref_11ACF(var_0) {
  self endon("kill_turret");
  self endon("turret_switch_weapon_ended");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self notify("turret_switch_weapon_timeout");
}

function manualturret_watchdismantle(var_0, var_1) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("disconnect");
  level endon("game_ended");

  foreach(var_3 in level.players) {
    var_1 enableplayeruse(var_3);

    if(level.teambased && var_3.team != var_0.team) {
      continue;
    } else if(!level.teambased) {
      if(var_3 != var_0) {
        continue;
      }
    }

    var_1 disableplayeruse(var_3);
  }

  thread manualturret_disableplayerdismantleonconnect(var_0);

  for(;;) {
    var_1 waittill("trigger", var_3);
    self notify("kill_turret", 0, 1);
    break;
  }
}

function manualturret_applyoverlay(var_0) {
  var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
  var_0 setclientomnvar("ui_mobile_turret_controls", 1);
  var_0 setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);
}

function manualturret_removeoverlay(var_0) {
  var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
  var_0 setclientomnvar("ui_mobile_turret_controls", 0);
}

function manualturret_disablefire(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    var_0 endon("death_or_disconnect");
    level endon("game_ended");
  }

  if(isDefined(var_0) && scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 freezecontrols(1);
  } else {
    return;
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var_0) && scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 freezecontrols(0);
    return;
  }
}

function manualturret_enableenemyoutlines(var_0) {
  if(!isDefined(self.enemyoutlineinfos)) {
    self.enemyoutlineinfos = [];
  }

  thread manualturret_enableenemyoutlinesonconnect(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "getEnemyPlayers")) {
    foreach(var_2 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "getEnemyPlayers")]](var_0.team)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
            thread manualturret_enableenemyoutlineafterprotection(var_0, var_2, 1);
          } else if(isDefined(var_2.avoidkillstreakonspawntimer) && var_2.avoidkillstreakonspawntimer > 0) {
            thread manualturret_enableenemyoutlineafterprotection(var_0, var_2);
          }

          continue;
        }
      }

      manualturret_addtooutlinelist(var_0, var_2);
    }

    return;
  }
}

function manualturret_enableenemyoutlinesonconnect(var_0) {
  self endon("kill_turret");
  var_0 endon("end_turret_use");

  for(;;) {
    level waittill("connected", var_1);
    thread manualturret_enableenemyoutlineafterprotection(var_0, var_1, 1);
  }
}

function manualturret_removeoutlineondeath(var_0, var_1, var_2) {
  self endon("kill_turret");
  var_0 endon("end_turret_use");
  var_1 waittill("death_or_disconnect");
  manualturret_removefromoutlinelist(var_1, var_2);

  if(isDefined(var_1)) {
    thread manualturret_restoreoutlineonspawn(var_0, var_1);
    return;
  }
}

function manualturret_restoreoutlineonspawn(var_0, var_1) {
  self endon("kill_turret");
  var_0 endon("end_turret_use");
  var_1 endon("disconnect");

  for(;;) {
    level waittill("player_spawned", var_2);

    if(var_2 != var_1) {
      continue;
    }

    thread manualturret_enableenemyoutlineafterprotection(var_0, var_2);
  }
}

function manualturret_enableenemyoutlineafterprotection(var_0, var_1, var_2) {
  self endon("kill_turret");
  var_0 endon("end_turret_use");

  if(istrue(var_2)) {
    var_1 waittill("spawned_player");
  }

  if(isDefined(var_1.avoidkillstreakonspawntimer) && var_1.avoidkillstreakonspawntimer > 0) {
    var_1 waittill("removed_spawn_perks");
  }

  if(level.teambased && var_1.team == var_0.team) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
      return;
    }
  }

  manualturret_addtooutlinelist(var_0, var_1);
}

function manualturret_addtooutlinelist(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.ent = var_1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForPlayer")) {
    var_2.entoutlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForPlayer")]](var_1, var_0, "outline_nodepth_orange", "level_script");
  }

  self.enemyoutlineinfos[self.enemyoutlineinfos.size] = var_2;
  thread manualturret_removeoutlineondeath(var_0, var_1, var_2.entoutlineid);
  return var_2;
}

function manualturret_removefromoutlinelist(var_0, var_1) {
  if(!isDefined(self.enemyoutlineinfos)) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_1, var_0);
  }

  var_2 = [];

  foreach(var_4 in self.enemyoutlineinfos) {
    if(var_4.ent == var_0) {
      continue;
    }

    var_2 = var_4;
  }

  self.enemyoutlineinfos = var_2;
}

function manualturret_disableenemyoutlines(var_0) {
  if(!isDefined(self.enemyoutlineinfos)) {
    return;
  }

  foreach(var_2 in self.enemyoutlineinfos) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_2.entoutlineid, var_2.ent);
    }
  }

  self.enemyoutlineinfos = undefined;
}

function manualturret_endplayeruse(var_0) {
  if(isDefined(var_0)) {
    var_0.inuse = undefined;
    var_0.ref_126E2 = undefined;
    manualturret_makealltriggersusable(var_0, 1);
  }

  if(isDefined(self)) {
    if(!self usinggamepad()) {
      self enableturretdismount();
    }

    if(isDefined(var_0)) {
      if(isDefined(self.currentturret) && self.currentturret != var_0) {
        return;
      }

      self controlturretoff(var_0);
      manualturret_removeoverlay(var_0, self);

      if(!istrue(var_0.usedropspawn)) {
        thread manualturret_watchpickup(var_0);
      }
    }

    self.currentturret = undefined;
    ref_11ACD(1);

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      scripts\common\utility::brjugg_oncrateuse(1);
    }

    if(level.gametype != "br" || level.gametype == "br" && !istrue(self.inlaststand)) {
      var_1 = scripts\cp_mp\utility\weapon_utility::ref_12CC7(self.lastdroppableweaponobj);
      self switchtoweaponimmediate(var_1);
    }

    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.useweapon);
    thread ref_11AC7();

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self setOrigin(var_0.lastuserpos, 1);
      self setplayerangles(var_0.lastuserangles);
    }

    self notify("end_turret_use");
    return;
  }
}

function ref_11AC7() {
  self endon("death_or_disconnect");
  scripts\common\utility::allow_crouch(0, "manual_turret");
  scripts\common\utility::allow_prone(0, "manual_turret");
  scripts\common\utility::allow_mantle(0, "manual_turret");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  scripts\common\utility::allow_crouch(1, "manual_turret");
  scripts\common\utility::allow_prone(1, "manual_turret");
  scripts\common\utility::allow_mantle(1, "manual_turret");
}

function manualturret_disableplayeruseonconnect(var_0, var_1) {
  if(isDefined(self)) {
    self endon("kill_turret");
    self endon("carried_turret");
  }

  var_0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_2);
    var_1 disableplayeruse(var_2);
  }
}

function ref_11AC9(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("end_turret_use");
  var_0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(var_0 isinexecutionvictim()) {
      manualturret_endplayeruse(var_0, self);
      break;
    }

    waitframe();
  }
}

function ref_11ACA(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("end_turret_use");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 = 2500;

  if(isDefined(self.moving_platform)) {
    var_1 = 10000;
  }

  for(;;) {
    if(distancesquared(self.origin, var_0.origin) >= var_1) {
      manualturret_endplayeruse(var_0, self);
      break;
    }

    waitframe();
  }
}

function manualturret_endturretusewatch(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("end_turret_use");
  var_0 endon("disconnect");
  level endon("game_ended");

  while(var_0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var_0 useButtonPressed()) {
      manualturret_endplayeruse(var_0, self);
      break;
    }

    waitframe();
  }
}

function manualturret_endturretonplayer(var_0) {
  var_0 endon("end_turret_use");
  level endon("game_ended");
  var_0 scripts\engine\utility::ref_143A5("death_or_disconnect", "last_stand_start");
  manualturret_endplayeruse(var_0, self);
}

function manualturret_watchplayerangles(var_0) {
  self endon("kill_turret");
  var_0 endon("end_turret_use");
  var_0 endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self.lastuserpos = var_0.origin;
    self.lastuserangles = var_0 getplayerangles();
    waitframe();
  }
}

function manualturret_watchpickup(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("disconnect");
  var_0 endon("start_turret_use");
  level endon("game_ended");

  while(isDefined(self) && isDefined(self.useownerobj)) {
    self.useownerobj waittill("trigger_progress", var_1);
    var_2 = 0;

    while(var_0 useButtonPressed() && var_2 < 0.25) {
      waitframe();
      var_2 += level.framedurationseconds;
    }

    if(!isDefined(var_1)) {
      continue;
    }

    if(var_2 < 0.25) {
      continue;
    }

    if(istrue(self.ref_138E0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TURRET_DYING");
      }

      continue;
    }

    if(istrue(var_1.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
      }

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "allowPickupOfTurret")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    manualturret_makealltriggersusable(0);
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    var_0.placedsentries[self.turrettype] = scripts\engine\utility::array_remove(var_0.placedsentries[self.turrettype], self);
    thread manualturret_setcarried(var_0);
  }
}

function manualturret_watchdelayedpickup(var_0) {
  self endon("kill_turret");
  var_0 endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  thread manualturret_watchpickup(var_0);
}

function manualturret_disableplayerpickuponconnect(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried_turret");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_1);
    var_0.useownerobj disableplayeruse(var_1);
  }
}

function manualturret_watchdamage(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "monitorDamage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "monitorDamage")]](self.maxhealth, "hitequip", &manualturret_handledeathdamage, &manualturret_modifydamage, 1);
    return;
  }
}

function manualturret_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = level.sentrysettings[self.turrettype];
  var_7 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
    var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](var_6.streakname, var_1, var_2, var_3, var_4, var_6.scorepopup, var_6.vodestroyed, var_6.destroyedsplash);
  }

  if(var_7) {
    var_1 notify("destroyed_equipment");
  }

  var_8 = 0;

  if(var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_GRENADE_SPLASH") {
    var_8 = 1;
  }

  self notify("kill_turret", var_8, 1);
}

function manualturret_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    var_6 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var_1, var_2, var_3, var_6, self.maxhealth, 1, 1, 2, 7, 5);
  }

  return var_6;
}

function manualturret_disableplayerdismantleonconnect(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_1);
    var_1 waittill("spawned_player");

    if(level.teambased) {
      if(var_1.team != var_0.team) {
        continue;
      }
    }

    self.dismantleobj disableplayeruse(var_1);
  }
}

function manualturret_watchdeath(var_0) {
  self endon("carried_turret");
  self waittill("kill_turret", var_1, var_2);
  self.usedropspawn = 1;

  if(isDefined(var_0)) {
    var_0.placedsentries[self.turrettype] = scripts\engine\utility::array_remove(var_0.placedsentries[self.turrettype], self);
    manualturret_setinactive(var_0, self);
    manualturret_disableenemyoutlines(var_0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", var_0);
    }

    self.streakinfo.onspray = istrue(var_2);
    var_0 scripts\cp_mp\utility\killstreak_utility::ref_12AA7(self.streakinfo);
  }

  if(isDefined(self.ref_126E2)) {
    manualturret_endplayeruse(self.ref_126E2, self);
  }

  if(isDefined(self.useownerobj)) {
    self.useownerobj delete();
  }

  if(isDefined(self.useotherobj)) {
    self.useotherobj delete();
  }

  if(!istrue(var_1)) {
    self playSound("sentry_explode_smoke");
    self setscriptablepartstate("shutdown", "on");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    self setscriptablepartstate("explode", "regular");
  } else {
    self setscriptablepartstate("explode", "violent");
  }

  self playSound("mp_equip_destroyed");

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self.helperdrone_isbeingpingedbydrone)) {
    self.helperdrone_isbeingpingedbydrone delete();
  }

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  wait 0.2;
  self delete();
}

function ref_11ACE() {
  self endon("kill_turret");
  self endon("carried_turret");
  level waittill("game_ended");
  self notify("kill_turret", 0, 0);
}

function manualturret_delayscriptabledelete() {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

function manualturret_watchtimeout(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 = self.timeout;
  jumpiftrue(isDefined(self.timeelapsed)) LOC_00000035;
  self.timeelapsed = 0;

  while(self.timeelapsed < var_1) {
    var_2 = (var_1 - self.timeelapsed) / var_1;
    var_2 = int(ceil(clamp(var_2, 0, 1) * 100));

    if(isDefined(self.ref_126E2)) {
      self.ref_126E2 setclientomnvar("ui_killstreak_countdown", int(var_2));
    }

    self.timeelapsed += level.framedurationseconds;

    if(self.timeelapsed >= var_1 - 1.5 && !istrue(self.ref_138E0)) {
      self.ref_138E0 = 1;
    }

    waitframe();
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("timeout_" + self.streakinfo.streakname, 1);
  self notify("kill_turret", 0, 0);
}

function manualturret_watchammotracker(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("end_turret_use");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 = level.sentrysettings[self.turrettype];
  var_2 = weaponfiretime(var_1.weaponinfo);

  if(!isDefined(self.hideammoindex)) {
    self.hideammoindex = 1;
  }

  while(var_0 isusingturret()) {
    while(var_0 attackButtonPressed()) {
      self.streakinfo.shots_fired++;
      self.ammocount--;
      var_0 setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);

      if(self.ammocount <= 12) {
        self setscriptablepartstate("hide_ammo_" + self.hideammoindex, "on", 0);
        self.hideammoindex++;
      }

      if(self.ammocount == 100) {
        var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname + "_low_ammo");
      } else if(self.ammocount <= 0) {
        var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname + "_no_ammo");
        self notify("kill_turret", 0, 0);
        break;
      }

      wait var_2;
    }

    waitframe();
  }
}

function manualturret_watchdisown(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  thread manualturret_disownonaction(var_0, self);
  thread manualturret_disownonaction(var_0, self);
  thread manualturret_disownonaction(var_0, self);
}

function manualturret_disownonaction(var_0, var_1) {
  var_0 endon("kill_turret");
  self endon("carried_turret");
  self endon("disowned_turret");
  level endon("game_ended");
  self waittill(var_1);
  var_0 notify("kill_turret", 0, 0);
  self notify("disowned_turret");
}

function manualturret_setturretmodel(var_0) {
  var_1 = undefined;

  if(var_0 == "placed") {
    var_1 = level.sentrysettings[self.turrettype].modelbaseground;
  } else {
    var_1 = level.sentrysettings[self.turrettype].modeldestroyedground;
  }

  self setModel(var_1);
}

function manualturret_makealltriggersusable(var_0) {
  if(!istrue(var_0)) {
    self.useownerobj makeunusable();
    self.useotherobj makeunusable();
    return;
  }

  self.useownerobj makeusable();
  self.useotherobj makeusable();
}

function ref_11ACC(var_0) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::allow_sprint(var_0);
    scripts\common\utility::allow_weapon_switch(var_0);
    scripts\common\utility::allow_offhand_weapons(var_0);
    scripts\common\utility::allow_melee(var_0);
    scripts\common\utility::allow_execution_attack(var_0);
    scripts\common\utility::allow_ladder_placement(var_0);
    return;
  }
}

function ref_11ACD(var_0) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::allow_offhand_weapons(var_0);
    scripts\common\utility::allow_melee(var_0);
    scripts\common\utility::allow_supers(var_0);
    scripts\common\utility::allow_movement(var_0);
    return;
  }
}