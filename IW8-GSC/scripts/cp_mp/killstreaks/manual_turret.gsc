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

function weaponcleanupmanualturret(var0, var1, var2) {
  if(!istrue(var1)) {
    scripts\cp_mp\killstreaks\killstreakdeploy::rocket_fuel(var2);
    return;
  }
}

function tryusemanualturret(var0) {
  var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var0, self);
  return tryusemanualturretfromstruct(var1);
}

function tryusemanualturretfromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return false;
    }
  }

  scripts\cp_mp\utility\weapon_utility::ref_12eb2();
  var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var0, getcompleteweaponname("deploy_manual_turret_mp"), 1, undefined, undefined, &weaponcleanupmanualturret);

  if(!istrue(var1)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      return false;
    }
  }

  ref_11acc(0);
  var2 = manualturret_create("manual_turret", var0);

  if(!isDefined(var2)) {
    ref_11acc(1);
    return false;
  }

  var3 = manualturret_watchplacement(var2, var0, 0, 1.25);

  if(!isDefined(var3)) {
    ref_11acc(1);
    var2 delete();
    return false;
  }

  ref_11acc(1);
  manualturret_setplaced(var2, var3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "munitionUsed")]]();
  }

  return true;
}

function manualturret_watchplacement(var0, var1, var2, var3) {
  thread manualturret_delayplacementinstructions(var3);
  var4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "watchForPlayerEnteringLastStand")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "watchForPlayerEnteringLastStand")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "getTargetMarker")) {
    var4 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "getTargetMarker")]](var1, var2);
  }

  self notify("turret_placement_finished");

  if(!isDefined(var4) || !isDefined(var4.location)) {
    if(istrue(self.inlaststand)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon("deploy_manual_turret_mp");
    } else if(scripts\cp_mp\utility\player_utility::_isalive()) {
      manualturret_switchbacklastweapon("deploy_manual_turret_mp");
    }

    return undefined;
  }

  thread manualturret_disablefire(var0, self, 1);

  if(self hasweapon("deploy_manual_turret_mp")) {
    thread manualturret_switchbacklastweapon("deploy_manual_turret_mp", 1, 1);
  }

  var5 = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var5);
  return var4;
}

function manualturret_delayplacementinstructions(var0) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  self setclientomnvar("ui_turret_placement", 1);
  thread ref_11ac6("death");
  thread ref_11ac6("turret_placement_finished");
}

function ref_11ac6(var0) {
  self endon("cleared_placement");
  self endon("disconnect");
  level endon("game_ended");
  self waittill(var0);
  self setclientomnvar("ui_turret_placement", 0);
  self notify("cleared_placement");
}

function manualturret_create(var0, var1) {
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
  var3.reticlestate = "reticle_on";
  var3.timeout = var2.timeout;
  var3.carriedby = self;
  manualturret_setturretmodel(var3, "placed");
  var3 makeunusable();
  var3 setnodeploy(1);
  var3 setdefaultdroppitch(0);
  var3 hide();
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
  var3.helperdrone_isbeingpingedbydrone.moverdoesnotkill = 1;
  var3.helperdrone_isbeingpingedbydrone.ref_13e8d = var3;
  return var3;
}

function manualturret_setplaced(var0, var1) {
  var2 = level.sentrysettings[var0.turrettype];
  manualturret_setturretmodel(var0, "placed");

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

    var3 = var2.teamsplash;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var3, self);
    }

    var0.shouldsplash = 0;
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

  if(isDefined(self.hideammoindex)) {
    for(var4 = self.hideammoindex; var4 >= 1; var4--) {
      var0 setscriptablepartstate("hide_ammo_" + var4, "on", 0);
    }
  }

  var5 = "off";

  if(var0.reticlestate == "reticle_off") {
    var5 = "on";
  }

  var0 setscriptablepartstate("hide_reticle", var5, 0);
  var0.origin = var1.location;
  var0 playSound("sentry_gun_plant");
  var0.helperdrone_isbeingpingedbydrone show();
  var0.helperdrone_isbeingpingedbydrone.angles = var0.angles;
  var0.helperdrone_isbeingpingedbydrone.origin = var0.origin;
  var0.helperdrone_isbeingpingedbydrone linkTo(var0, "tag_aim_pivot");
  var6 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";

  if(!var6) {
    var7 = "icon_minimap_mobileturret";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
      var0.minimapid = var0.helperdrone_isbeingpingedbydrone[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](var7, var0.team, undefined, 1, 1);
    }
  }

  var8 = self.placedsentries[var0.turrettype].size;
  self.placedsentries[var0.turrettype][var8] = var0;

  if(var8 + 1 > 1) {
    self.placedsentries[var0.turrettype][0] notify("kill_turret", 0, 0);
  }

  var9 = 70;

  if(var0.model == level.sentrysettings[var0.turrettype].modelbasecover) {
    var9 = 35;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var0.turrettype, "Killstreak_Ground", self, 0, 1, var9, "carried_turret");
  }

  var0 setmode(level.sentrysettings[var0.turrettype].sentrymodeon);
  var10 = "j_trigger";

  if(!isDefined(var0.useownerobj)) {
    var11 = var0 gettagorigin(var10);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "createHintObject")) {
      var0.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "createHintObject")]](var11, "HINT_BUTTON", undefined, var2.ownerusehintstring, -1, "duration_none", undefined, 17, undefined, 17);
    }
  } else {
    var11 = var1 gettagorigin(var11);
    var1.useownerobj makeusable();
    var1.useownerobj dontinterpolate();
    var1.useownerobj.origin = var11;
  }

  var1.useownerobj linkTo(var1, var11);

  if(!isDefined(var1.useotherobj)) {
    var11 = var1 gettagorigin(var11);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "createHintObject")) {
      var1.useotherobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "createHintObject")]](var11, "HINT_BUTTON", undefined, var5.otherusehintstring, -1, "duration_none", undefined, 17, undefined, 17);
    }
  } else {
    var11 = var1 gettagorigin(var11);
    var1.useotherobj makeusable();
    var1.useotherobj dontinterpolate();
    var1.useotherobj.origin = var11;
  }

  var1.useotherobj linkTo(var1, var11);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "handleMovingPlatform")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "handleMovingPlatform")]](var1);
  }

  var1 scripts\cp_mp\emp_debuff::allow_emp(1);
  var1 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Static", self);
  thread manualturret_delaydeletemarker(var1, self);
  thread manualturret_watchuse(var1, self);
  thread manualturret_watchuse(var1, self);
  thread manualturret_watchpickup(var1);
  thread manualturret_watchdamage(var1);
  thread manualturret_watchdeath(var1);
  thread ref_11ace();
  thread manualturret_watchtimeout(var1);
  thread manualturret_watchdisown(var1);
}

function manualturret_setcarried(var0) {
  self endon("kill_turret");
  var0 endon("death_or_disconnect");
  var0 endon("start_turret_use");
  level endon("game_ended");

  if(istrue(self.inuse)) {
    self.inuse = undefined;
    ref_11acd(var0, 1);
  }

  if(isDefined(self.moving_platform)) {
    self.moving_platform = undefined;
    self.ref_11dbe = undefined;
    self.ref_11dbd = undefined;
    self unlink();
  }

  scripts\cp_mp\emp_debuff::allow_emp(0);
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  var1 = self getlinkedchildren();

  foreach(var3 in var1) {
    if(isDefined(var3)) {
      var3 unlink();
    }
  }

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  self.helperdrone_isbeingpingedbydrone hide();
  manualturret_setinactive(var0, self);
  self hide();
  self.carriedby = var0;
  self notify("carried_turret");
  self playSound("sentry_pickup");
  var0 scripts\cp_mp\utility\weapon_utility::ref_12eb2();
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon("deploy_manual_turret_mp");
  var0 scripts\cp_mp\utility\inventory_utility::_switchtoweapon("deploy_manual_turret_mp");
  ref_11acc(var0, 0);
  var5 = manualturret_watchplacement(var0, self, self.streakinfo, 1, 2);

  if(!isDefined(var5)) {
    ref_11acc(var0, 1);
    return 0;
  }

  ref_11acc(var0, 1);
  manualturret_setplaced(var0, self, var5);
}

function manualturret_switchbacklastweapon(var0, var1, var2) {
  if(isDefined(var2) && var2 > 0) {
    self endon("death_or_disconnect");
    level endon("game_ended");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var2);
  }

  var3 = scripts\cp_mp\utility\weapon_utility::ref_12cc7(self.lastdroppableweaponobj);

  if(istrue(var1)) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var3);
  } else {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var3);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
}

function manualturret_setinactive(var0) {
  var0 setmode(level.sentrysettings[var0.turrettype].sentrymodeoff);
  var0 setturretminimapvisible(0);
  manualturret_makealltriggersusable(var0, 0);
  var0.useownerobj unlink();
  var0.useotherobj unlink();
}

function manualturret_delaydeletemarker(var0, var1) {
  self endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(var1.visual)) {
    var1.visual delete();
    return;
  }
}

function manualturret_watchuse(var0, var1) {
  self endon("kill_turret");
  self endon("carried_turret");
  var0 endon("disconnect");
  level endon("game_ended");

  foreach(var3 in level.players) {
    var1 enableplayeruse(var3);

    if(var1 == self.useownerobj) {
      if(var3 == var0) {
        continue;
      }
    } else if(level.teambased && var3.team == var0.team && var3 != var0) {
      continue;
    }

    var1 disableplayeruse(var3);
  }

  thread manualturret_disableplayeruseonconnect(var0, var1);

  for(;;) {
    var1 waittill("trigger", var3);

    if(istrue(self.inuse)) {
      continue;
    }

    if(istrue(self.ref_138e0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var3[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TURRET_DYING");
      }

      continue;
    }

    if(var3 isonladder() || !var3 isonground() || var3 ismantling()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var3[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
      }

      continue;
    }

    if(istrue(var3.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var3[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
      }

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "allowPickupOfTurret")) {
      if(!var3[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    self.inuse = 1;
    ref_11acd(var3, 0);
    var3 disableturretdismount();

    if(var3 == var0) {
      var5 = 0;

      while(isDefined(var3) && var3 useButtonPressed() && var5 < 0.25) {
        waitframe();
        var5 += level.framedurationseconds;
      }

      if(var5 >= 0.25) {
        self.inuse = undefined;

        if(isDefined(var3)) {
          var3 enableturretdismount();

          if(var3 scripts\cp_mp\utility\player_utility::_isalive()) {
            ref_11acd(var3, 1);
          }
        }

        continue;
      }
    }

    var3 notify("start_turret_use");
    self.ref_126e2 = var3;
    manualturret_makealltriggersusable(0);
    var3 scripts\cp_mp\utility\weapon_utility::ref_12eb2();
    var3.useweapon = level.sentrysettings[self.turrettype].playerweaponinfo;
    var3 scripts\cp_mp\utility\inventory_utility::_giveweapon(var3.useweapon, undefined, undefined, 1);
    var6 = gettime();
    var7 = undefined;

    while(gettime() - var6 < 1000) {
      var7 = ref_11ac8(var3, var3.useweapon);

      if(!isDefined(var7) || istrue(var7)) {
        break;
      }

      waitframe();
    }

    if(!istrue(var7)) {
      self.inuse = undefined;
      self.ref_126e2 = undefined;
      manualturret_makealltriggersusable(1);

      if(isDefined(var3)) {
        if(var3 scripts\cp_mp\utility\player_utility::_isalive()) {
          ref_11acd(var3, 1);
          var8 = var3 scripts\cp_mp\utility\weapon_utility::ref_12cc7(var3.lastdroppableweaponobj);
          var3 switchtoweaponimmediate(var8);
        }

        var3 clearhighpriorityweapon(var3.useweapon);
        var3 scripts\cp_mp\utility\inventory_utility::_takeweapon(var3.useweapon);
      }

      continue;
    }

    var3.currentturret = self;
    var3 controlturreton(self);

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      var3 scripts\common\utility::brjugg_oncrateuse(0);
    }

    manualturret_applyoverlay(var3);
    thread manualturret_disablefire(var3, 0.5, 1);
    thread manualturret_watchammotracker(var3);
    thread ref_11ac9(var3);
    thread ref_11aca(var3);
    thread manualturret_endturretusewatch(var3);
    thread manualturret_endturretonplayer(var3);
    thread manualturret_watchplayerangles(var3);
  }
}

function ref_11ac8(var0, var1) {
  self endon("kill_turret");
  self endon("turret_switch_weapon_timeout");
  var0 endon("death_or_disconnect");
  level endon("game_ended");
  thread ref_11acf(1);
  var2 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var1, 1);
  self notify("turret_switch_weapon_ended");
  return var2;
}

function ref_11acf(var0) {
  self endon("kill_turret");
  self endon("turret_switch_weapon_ended");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  self notify("turret_switch_weapon_timeout");
}

function manualturret_watchdismantle(var0, var1) {
  self endon("kill_turret");
  self endon("carried_turret");
  var0 endon("disconnect");
  level endon("game_ended");

  foreach(var3 in level.players) {
    var1 enableplayeruse(var3);

    if(level.teambased && var3.team != var0.team) {
      continue;
    } else if(!level.teambased) {
      if(var3 != var0) {
        continue;
      }
    }

    var1 disableplayeruse(var3);
  }

  thread manualturret_disableplayerdismantleonconnect(var0);

  for(;;) {
    var1 waittill("trigger", var3);
    self notify("kill_turret", 0, 1);
    break;
  }
}

function manualturret_applyoverlay(var0) {
  var0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
  var0 setclientomnvar("ui_mobile_turret_controls", 1);
  var0 setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);
}

function manualturret_removeoverlay(var0) {
  var0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
  var0 setclientomnvar("ui_mobile_turret_controls", 0);
}

function manualturret_disablefire(var0, var1, var2) {
  if(istrue(var2)) {
    var0 endon("death_or_disconnect");
    level endon("game_ended");
  }

  if(isDefined(var0) && scripts\cp_mp\utility\player_utility::_isalive()) {
    var0 freezecontrols(1);
  } else {
    return;
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var0) && scripts\cp_mp\utility\player_utility::_isalive()) {
    var0 freezecontrols(0);
    return;
  }
}

function manualturret_enableenemyoutlines(var0) {
  if(!isDefined(self.enemyoutlineinfos)) {
    self.enemyoutlineinfos = [];
  }

  thread manualturret_enableenemyoutlinesonconnect(var0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "getEnemyPlayers")) {
    foreach(var2 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "getEnemyPlayers")]](var0.team)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          if(!var2 scripts\cp_mp\utility\player_utility::_isalive()) {
            thread manualturret_enableenemyoutlineafterprotection(var0, var2, 1);
          } else if(isDefined(var2.avoidkillstreakonspawntimer) && var2.avoidkillstreakonspawntimer > 0) {
            thread manualturret_enableenemyoutlineafterprotection(var0, var2);
          }

          continue;
        }
      }

      manualturret_addtooutlinelist(var0, var2);
    }

    return;
  }
}

function manualturret_enableenemyoutlinesonconnect(var0) {
  self endon("kill_turret");
  var0 endon("end_turret_use");

  for(;;) {
    level waittill("connected", var1);
    thread manualturret_enableenemyoutlineafterprotection(var0, var1, 1);
  }
}

function manualturret_removeoutlineondeath(var0, var1, var2) {
  self endon("kill_turret");
  var0 endon("end_turret_use");
  var1 waittill("death_or_disconnect");
  manualturret_removefromoutlinelist(var1, var2);

  if(isDefined(var1)) {
    thread manualturret_restoreoutlineonspawn(var0, var1);
    return;
  }
}

function manualturret_restoreoutlineonspawn(var0, var1) {
  self endon("kill_turret");
  var0 endon("end_turret_use");
  var1 endon("disconnect");

  for(;;) {
    level waittill("player_spawned", var2);

    if(var2 != var1) {
      continue;
    }

    thread manualturret_enableenemyoutlineafterprotection(var0, var2);
  }
}

function manualturret_enableenemyoutlineafterprotection(var0, var1, var2) {
  self endon("kill_turret");
  var0 endon("end_turret_use");

  if(istrue(var2)) {
    var1 waittill("spawned_player");
  }

  if(isDefined(var1.avoidkillstreakonspawntimer) && var1.avoidkillstreakonspawntimer > 0) {
    var1 waittill("removed_spawn_perks");
  }

  if(level.teambased && var1.team == var0.team) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
      return;
    }
  }

  manualturret_addtooutlinelist(var0, var1);
}

function manualturret_addtooutlinelist(var0, var1) {
  var2 = spawnStruct();
  var2.ent = var1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForPlayer")) {
    var2.entoutlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForPlayer")]](var1, var0, "outline_nodepth_orange", "level_script");
  }

  self.enemyoutlineinfos[self.enemyoutlineinfos.size] = var2;
  thread manualturret_removeoutlineondeath(var0, var1, var2.entoutlineid);
  return var2;
}

function manualturret_removefromoutlinelist(var0, var1) {
  if(!isDefined(self.enemyoutlineinfos)) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var1, var0);
  }

  var2 = [];

  foreach(var4 in self.enemyoutlineinfos) {
    if(var4.ent == var0) {
      continue;
    }

    var2 = var4;
  }

  self.enemyoutlineinfos = var2;
}

function manualturret_disableenemyoutlines(var0) {
  if(!isDefined(self.enemyoutlineinfos)) {
    return;
  }

  foreach(var2 in self.enemyoutlineinfos) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var2.entoutlineid, var2.ent);
    }
  }

  self.enemyoutlineinfos = undefined;
}

function manualturret_endplayeruse(var0) {
  if(isDefined(var0)) {
    var0.inuse = undefined;
    var0.ref_126e2 = undefined;
    manualturret_makealltriggersusable(var0, 1);
  }

  if(isDefined(self)) {
    if(!self usinggamepad()) {
      self enableturretdismount();
    }

    if(isDefined(var0)) {
      if(isDefined(self.currentturret) && self.currentturret != var0) {
        return;
      }

      self controlturretoff(var0);
      manualturret_removeoverlay(var0, self);

      if(!istrue(var0.usedropspawn)) {
        thread manualturret_watchpickup(var0);
      }
    }

    self.currentturret = undefined;
    ref_11acd(1);

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      scripts\common\utility::brjugg_oncrateuse(1);
    }

    if(level.gametype != "br" || level.gametype == "br" && !istrue(self.inlaststand)) {
      var1 = scripts\cp_mp\utility\weapon_utility::ref_12cc7(self.lastdroppableweaponobj);
      self switchtoweaponimmediate(var1);
    }

    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.useweapon);
    thread ref_11ac7();

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self setOrigin(var0.lastuserpos, 1);
      self setplayerangles(var0.lastuserangles);
    }

    self notify("end_turret_use");
    return;
  }
}

function ref_11ac7() {
  self endon("death_or_disconnect");
  scripts\common\utility::allow_crouch(0, "manual_turret");
  scripts\common\utility::allow_prone(0, "manual_turret");
  scripts\common\utility::allow_mantle(0, "manual_turret");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  scripts\common\utility::allow_crouch(1, "manual_turret");
  scripts\common\utility::allow_prone(1, "manual_turret");
  scripts\common\utility::allow_mantle(1, "manual_turret");
}

function manualturret_disableplayeruseonconnect(var0, var1) {
  if(isDefined(self)) {
    self endon("kill_turret");
    self endon("carried_turret");
  }

  var0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var2);
    var1 disableplayeruse(var2);
  }
}

function ref_11ac9(var0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var0 endon("end_turret_use");
  var0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(var0 isinexecutionvictim()) {
      manualturret_endplayeruse(var0, self);
      break;
    }

    waitframe();
  }
}

function ref_11aca(var0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var0 endon("end_turret_use");
  var0 endon("disconnect");
  level endon("game_ended");
  var1 = 2500;

  if(isDefined(self.moving_platform)) {
    var1 = 10000;
  }

  for(;;) {
    if(distancesquared(self.origin, var0.origin) >= var1) {
      manualturret_endplayeruse(var0, self);
      break;
    }

    waitframe();
  }
}

function manualturret_endturretusewatch(var0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var0 endon("end_turret_use");
  var0 endon("disconnect");
  level endon("game_ended");

  while(var0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var0 useButtonPressed()) {
      manualturret_endplayeruse(var0, self);
      break;
    }

    waitframe();
  }
}

function manualturret_endturretonplayer(var0) {
  var0 endon("end_turret_use");
  level endon("game_ended");
  var0 scripts\engine\utility::ref_143a5("death_or_disconnect", "last_stand_start");
  manualturret_endplayeruse(var0, self);
}

function manualturret_watchplayerangles(var0) {
  self endon("kill_turret");
  var0 endon("end_turret_use");
  var0 endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self.lastuserpos = var0.origin;
    self.lastuserangles = var0 getplayerangles();
    waitframe();
  }
}

function manualturret_watchpickup(var0) {
  if(!isDefined(var0)) {
    return;
  }

  self endon("kill_turret");
  self endon("carried_turret");
  var0 endon("disconnect");
  var0 endon("start_turret_use");
  level endon("game_ended");

  while(isDefined(self) && isDefined(self.useownerobj)) {
    self.useownerobj waittill("trigger_progress", var1);
    var2 = 0;

    while(var0 useButtonPressed() && var2 < 0.25) {
      waitframe();
      var2 += level.framedurationseconds;
    }

    if(!isDefined(var1)) {
      continue;
    }

    if(var2 < 0.25) {
      continue;
    }

    if(istrue(self.ref_138e0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TURRET_DYING");
      }

      continue;
    }

    if(istrue(var1.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
      }

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "allowPickupOfTurret")) {
      if(!var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    manualturret_makealltriggersusable(0);
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    var0.placedsentries[self.turrettype] = scripts\engine\utility::array_remove(var0.placedsentries[self.turrettype], self);
    thread manualturret_setcarried(var0);
  }
}

function manualturret_watchdelayedpickup(var0) {
  self endon("kill_turret");
  var0 endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  thread manualturret_watchpickup(var0);
}

function manualturret_disableplayerpickuponconnect(var0) {
  var0 endon("kill_turret");
  var0 endon("carried_turret");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var1);
    var0.useownerobj disableplayeruse(var1);
  }
}

function manualturret_watchdamage(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "monitorDamage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "monitorDamage")]](self.maxhealth, "hitequip", &manualturret_handledeathdamage, &manualturret_modifydamage, 1);
    return;
  }
}

function manualturret_handledeathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = level.sentrysettings[self.turrettype];
  var7 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
    var7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](var6.streakname, var1, var2, var3, var4, var6.scorepopup, var6.vodestroyed, var6.destroyedsplash);
  }

  if(var7) {
    var1 notify("destroyed_equipment");
  }

  var8 = 0;

  if(var3 == "MOD_EXPLOSIVE" || var3 == "MOD_PROJECTILE" || var3 == "MOD_PROJECTILE_SPLASH" || var3 == "MOD_GRENADE_SPLASH") {
    var8 = 1;
  }

  self notify("kill_turret", var8, 1);
}

function manualturret_modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    var6 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var1, var2, var3, var6, self.maxhealth, 1, 1, 2, 7, 5);
  }

  return var6;
}

function manualturret_disableplayerdismantleonconnect(var0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var1);
    var1 waittill("spawned_player");

    if(level.teambased) {
      if(var1.team != var0.team) {
        continue;
      }
    }

    self.dismantleobj disableplayeruse(var1);
  }
}

function manualturret_watchdeath(var0) {
  self endon("carried_turret");
  self waittill("kill_turret", var1, var2);
  self.usedropspawn = 1;

  if(isDefined(var0)) {
    var0.placedsentries[self.turrettype] = scripts\engine\utility::array_remove(var0.placedsentries[self.turrettype], self);
    manualturret_setinactive(var0, self);
    manualturret_disableenemyoutlines(var0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", var0);
    }

    self.streakinfo.onspray = istrue(var2);
    var0 scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
  }

  if(isDefined(self.ref_126e2)) {
    manualturret_endplayeruse(self.ref_126e2, self);
  }

  if(isDefined(self.useownerobj)) {
    self.useownerobj delete();
  }

  if(isDefined(self.useotherobj)) {
    self.useotherobj delete();
  }

  if(!istrue(var1)) {
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

function ref_11ace() {
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

function manualturret_watchtimeout(var0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var0 endon("disconnect");
  level endon("game_ended");
  var1 = self.timeout;
  jumpiftrue(isDefined(self.timeelapsed)) LOC_00000035;
  self.timeelapsed = 0;

  while(self.timeelapsed < var1) {
    var2 = (var1 - self.timeelapsed) / var1;
    var2 = int(ceil(clamp(var2, 0, 1) * 100));

    if(isDefined(self.ref_126e2)) {
      self.ref_126e2 setclientomnvar("ui_killstreak_countdown", int(var2));
    }

    self.timeelapsed += level.framedurationseconds;

    if(self.timeelapsed >= var1 - 1.5 && !istrue(self.ref_138e0)) {
      self.ref_138e0 = 1;
    }

    waitframe();
  }

  var0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("timeout_" + self.streakinfo.streakname, 1);
  self notify("kill_turret", 0, 0);
}

function manualturret_watchammotracker(var0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var0 endon("end_turret_use");
  var0 endon("disconnect");
  level endon("game_ended");
  var1 = level.sentrysettings[self.turrettype];
  var2 = weaponfiretime(var1.weaponinfo);

  if(!isDefined(self.hideammoindex)) {
    self.hideammoindex = 1;
  }

  while(var0 isusingturret()) {
    while(var0 attackButtonPressed()) {
      self.streakinfo.shots_fired++;
      self.ammocount--;
      var0 setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);

      if(self.ammocount <= 12) {
        self setscriptablepartstate("hide_ammo_" + self.hideammoindex, "on", 0);
        self.hideammoindex++;
      }

      if(self.ammocount == 100) {
        var0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname + "_low_ammo");
      } else if(self.ammocount <= 0) {
        var0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname + "_no_ammo");
        self notify("kill_turret", 0, 0);
        break;
      }

      wait var2;
    }

    waitframe();
  }
}

function manualturret_watchdisown(var0) {
  self endon("kill_turret");
  self endon("carried_turret");
  thread manualturret_disownonaction(var0, self);
  thread manualturret_disownonaction(var0, self);
  thread manualturret_disownonaction(var0, self);
}

function manualturret_disownonaction(var0, var1) {
  var0 endon("kill_turret");
  self endon("carried_turret");
  self endon("disowned_turret");
  level endon("game_ended");
  self waittill(var1);
  var0 notify("kill_turret", 0, 0);
  self notify("disowned_turret");
}

function manualturret_setturretmodel(var0) {
  var1 = undefined;

  if(var0 == "placed") {
    var1 = level.sentrysettings[self.turrettype].modelbaseground;
  } else {
    var1 = level.sentrysettings[self.turrettype].modeldestroyedground;
  }

  self setModel(var1);
}

function manualturret_makealltriggersusable(var0) {
  if(!istrue(var0)) {
    self.useownerobj makeunusable();
    self.useotherobj makeunusable();
    return;
  }

  self.useownerobj makeusable();
  self.useotherobj makeusable();
}

function ref_11acc(var0) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::allow_sprint(var0);
    scripts\common\utility::allow_weapon_switch(var0);
    scripts\common\utility::allow_offhand_weapons(var0);
    scripts\common\utility::allow_melee(var0);
    scripts\common\utility::allow_execution_attack(var0);
    scripts\common\utility::allow_ladder_placement(var0);
    return;
  }
}

function ref_11acd(var0) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::allow_offhand_weapons(var0);
    scripts\common\utility::allow_melee(var0);
    scripts\common\utility::allow_supers(var0);
    scripts\common\utility::allow_movement(var0);
    return;
  }
}