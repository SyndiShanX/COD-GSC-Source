/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\killstreaks\manual_turret.gsc
**********************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\sentientpoolmanager;
#namespace manual_turret;

function init() {
  if(issharedfuncdefined("manual_turret", "init")) {
    [[getsharedfunc("manual_turret", "init")]]();
  }

  registervisibilityomnvarforkillstreak("manual_turret", "on", 10);
}

function weaponcleanupmanualturret(streakinfo, switchresult, weaponobj) {
  if(!istrue(switchresult)) {
    scripts\cp_mp\killstreaks\killstreakdeploy::getridofkillstreakdeployweapon(weaponobj);
  }
}

function tryusemanualturret(streakname) {
  streakinfo = createstreakinfo(streakname, self);
  return tryusemanualturretfromstruct(streakinfo);
}

function tryusemanualturretfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, makeweapon("deploy_manual_turret_mp"), 1, undefined, undefined, &weaponcleanupmanualturret);

  if(!istrue(deployresult)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  manualturret_toggleallowplacementactions(0);
  turret = manualturret_create("manual_turret", streakinfo);

  if(!isDefined(turret)) {
    manualturret_toggleallowplacementactions(1);
    return false;
  }

  marker = manualturret_watchplacement(turret, streakinfo, 0, 1.25);

  if(!isDefined(marker)) {
    manualturret_toggleallowplacementactions(1);
    turret delete();
    return false;
  }

  manualturret_toggleallowplacementactions(1);
  manualturret_setplaced(turret, marker);

  if(issharedfuncdefined("manual_turret", "munitionUsed")) {
    self[[getsharedfunc("manual_turret", "munitionUsed")]]();
  }

  return true;
}

function manualturret_watchplacement(turret, streakinfo, ignorecancel, var_290b1442271ab369) {
  thread manualturret_delayplacementinstructions(var_290b1442271ab369);
  marker = undefined;

  if(issharedfuncdefined("manual_turret", "watchForPlayerEnteringLastStand")) {
    self thread[[getsharedfunc("manual_turret", "watchForPlayerEnteringLastStand")]]();
  }

  if(scripts\engine\utility::issharedfuncdefined("manual_turret", "getTargetMarker")) {
    marker = self[[scripts\engine\utility::getsharedfunc("manual_turret", "getTargetMarker")]](streakinfo, ignorecancel);
  }

  self notify("turret_placement_finished");

  if(!isDefined(marker) || !isDefined(marker.location)) {
    if(istrue(self.inlaststand)) {
      _takeweapon("deploy_manual_turret_mp");
    } else if(scripts\cp_mp\utility\player_utility::_isalive()) {
      killstreak_switchbacklastweapon("deploy_manual_turret_mp");
    }

    return undefined;
  }

  turret thread manualturret_disablefire(self, 1, 1);

  if(self hasweapon("deploy_manual_turret_mp")) {
    thread killstreak_switchbacklastweapon("deploy_manual_turret_mp", 1, 1);
  }

  delayspawntime = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delayspawntime);
  return marker;
}

function manualturret_delayplacementinstructions(delaytime) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  self setclientomnvar("ui_turret_placement", 1);
  thread manualturret_clearplacementinstructions("death");
  thread manualturret_clearplacementinstructions("turret_placement_finished");
}

function manualturret_clearplacementinstructions(clearaction) {
  self endon("cleared_placement");
  self endon("disconnect");
  level endon("game_ended");
  self waittill(clearaction);
  self setclientomnvar("ui_turret_placement", 0);
  self notify("cleared_placement");
}

function manualturret_create(turrettype, streakinfo) {
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
  turret.reticlestate = "reticle_on";
  turret.timeout = config.timeout;

  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    turret.timeout = 9999;
  }

  turret.carriedby = self;
  turret manualturret_setturretmodel("placed");
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret hide();
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  killcamforward = anglesToForward(turret.angles);
  killcampos = turret gettagorigin("tag_laser") + (0, 0, 10);
  killcampos -= killcamforward * 20;
  killcament = spawn("script_model", killcampos);
  killcament linkTo(turret);
  turret.killcament = killcament;
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel hide();
  turret.colmodel.moverdoesnotkill = 1;
  turret.colmodel.turretparent = turret;
  return turret;
}

function manualturret_setplaced(turret, marker) {
  config = level.sentrysettings[turret.turrettype];
  turret manualturret_setturretmodel("placed");

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

  if(isDefined(self.hideammoindex)) {
    for(var_af6fa51a19e513fc = self.hideammoindex; var_af6fa51a19e513fc >= 1; var_af6fa51a19e513fc--) {
      turret setscriptablepartstate("hide_ammo_" + var_af6fa51a19e513fc, "on", 0);
    }
  }

  var_aa127492f0104d8c = "off";

  if(turret.reticlestate == "reticle_off") {
    var_aa127492f0104d8c = "on";
  }

  turret setscriptablepartstate("hide_reticle", var_aa127492f0104d8c, 0);
  turret.origin = marker.location;
  turret playSound("sentry_gun_plant");
  turret.colmodel show();
  turret.colmodel.angles = turret.angles;
  turret.colmodel.origin = turret.origin;
  turret.colmodel linkTo(turret, "tag_aim_pivot");
  isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();

  if(!isbr) {
    turreticon = "icon_minimap_mobileturret";

    if(issharedfuncdefined("game", "createObjective")) {
      turret.minimapid = turret.colmodel[[getsharedfunc("game", "createObjective")]](turreticon, turret.team, undefined, 1, 1);
    }
  }

  turretcount = self.placedsentries[turret.turrettype].size;
  self.placedsentries[turret.turrettype][turretcount] = turret;

  if(turretcount + 1 > 1) {
    self.placedsentries[turret.turrettype][0] notify("kill_turret", 0, 0);
  }

  headiconoffset = 70;

  if(turret.model == level.sentrysettings[turret.turrettype].modelbasecover) {
    headiconoffset = 35;
  }

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    turret[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](turret.turrettype, "Killstreak_Ground", self, 0, 1, headiconoffset, "carried_turret");
  }

  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeon);
  usedistance = getdvarint(@ "hash_475bdcf02a7c5c6e", 17);
  hintfov = getdvarint(@ "hash_1faf82c0894746bc", 160);
  usefov = getdvarint(@ "hash_955590189adc87c8", 120);
  hinttag = "j_trigger";

  if(!isDefined(turret.useownerobj)) {
    hintpos = turret gettagorigin(hinttag);
    hinticon = undefined;

    if(self usingtouch()) {
      hinticon = "hud_icon_killstreak_turret";
    }

    if(scripts\engine\utility::issharedfuncdefined("manual_turret", "createHintObject")) {
      turret.useownerobj = [[scripts\engine\utility::getsharedfunc("manual_turret", "createHintObject")]](hintpos, "HINT_BUTTON", hinticon, config.ownerusehintstring, -1, "duration_none", undefined, usedistance, hintfov, usedistance, usefov);
    }
  } else {
    hintpos = turret gettagorigin(hinttag);
    turret.useownerobj function_dfb78b3e724ad620(1);
    turret.useownerobj dontinterpolate();
    turret.useownerobj.origin = hintpos;
  }

  turret.useownerobj linkTo(turret, hinttag);

  if(!isDefined(turret.useotherobj)) {
    hintpos = turret gettagorigin(hinttag);

    if(scripts\engine\utility::issharedfuncdefined("manual_turret", "createHintObject")) {
      turret.useotherobj = [[scripts\engine\utility::getsharedfunc("manual_turret", "createHintObject")]](hintpos, "HINT_BUTTON", undefined, config.otherusehintstring, -1, "duration_none", undefined, usedistance, hintfov, usedistance, usefov);
    }
  } else {
    hintpos = turret gettagorigin(hinttag);
    turret.useotherobj function_dfb78b3e724ad620(1);
    turret.useotherobj dontinterpolate();
    turret.useotherobj.origin = hintpos;
  }

  turret.useotherobj linkTo(turret, hinttag);

  if(scripts\engine\utility::issharedfuncdefined("manual_turret", "handleMovingPlatform")) {
    [[scripts\engine\utility::getsharedfunc("manual_turret", "handleMovingPlatform")]](turret);
  }

  turret scripts\cp_mp\emp_debuff::allow_emp(1);
  turret scripts\mp\sentientpoolmanager::registersentient("Killstreak_Static", self);
  turret thread manualturret_delaydeletemarker(self, marker);
  turret thread manualturret_watchuse(self, turret.useownerobj);
  turret thread manualturret_watchuse(self, turret.useotherobj);
  turret thread manualturret_watchpickup(self);
  turret thread manualturret_watchdamage(self);
  turret thread manualturret_watchdeath(self);
  turret thread manualturret_watchdeathongameend();
  turret thread manualturret_watchtimeout(self);
  turret thread manualturret_watchdisown(self);

  if(isDefined(level.wztrain_info) && issharedfuncdefined("game", "handlemovingplatforms")) {
    data = spawnStruct();
    data.deathoverridecallback = &function_2a4ebbd9d0e941a2;
    turret thread[[getsharedfunc("game", "handlemovingplatforms")]](data);
  }
}

function function_2a4ebbd9d0e941a2(data) {
  engine = scripts\cp_mp\utility\train_utility::function_d6b0a591ac99bd();
  assert(isDefined(engine));

  if(!isDefined(engine)) {
    return;
  }

  if(is_equal(data.lasttouchedplatform, engine)) {
    self notify("kill_turret", 1);
    return;
  }

  data = spawnStruct();
  data.deathoverridecallback = &function_2a4ebbd9d0e941a2;
  self thread[[getsharedfunc("game", "handlemovingplatforms")]](data);
}

function manualturret_setcarried(owner) {
  self endon("kill_turret");
  owner endon("death_or_disconnect");
  owner endon("start_turret_use");
  level endon("game_ended");

  if(istrue(self.inuse)) {
    self.inuse = undefined;
    owner manualturret_toggleallowuseactions(1);
  }

  if(isDefined(self.moving_platform)) {
    self.moving_platform = undefined;
    self.moving_platform_offset = undefined;
    self.moving_platform_angles_offset = undefined;
    self unlink();
  }

  scripts\cp_mp\emp_debuff::allow_emp(0);
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  linkedchildren = self getlinkedchildren();

  foreach(child in linkedchildren) {
    if(isDefined(child)) {
      child unlink();
    }
  }

  if(isDefined(self.minimapid)) {
    if(issharedfuncdefined("game", "returnObjectiveID")) {
      [[getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  self.colmodel hide();
  owner manualturret_setinactive(self);
  self hide();
  self.carriedby = owner;
  self notify("carried_turret");
  self playSound("sentry_pickup");
  owner scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  owner _giveweapon("deploy_manual_turret_mp");
  owner _switchtoweapon("deploy_manual_turret_mp");
  owner manualturret_toggleallowplacementactions(0);
  marker = owner manualturret_watchplacement(self, self.streakinfo, 1, 2);

  if(!isDefined(marker)) {
    owner manualturret_toggleallowplacementactions(1);
    return 0;
  }

  owner manualturret_toggleallowplacementactions(1);
  owner manualturret_setplaced(self, marker);
}

function manualturret_setinactive(turret) {
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
  turret setturretminimapvisible(0);
  turret manualturret_makealltriggersusable(0);
  turret.useownerobj unlink();
  turret.useotherobj unlink();
}

function manualturret_delaydeletemarker(owner, marker) {
  self endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(marker.visual)) {
    marker.visual delete();
  }
}

function manualturret_watchuse(owner, triggerobj) {
  self endon("kill_turret");
  self endon("carried_turret");
  owner endon("disconnect");
  level endon("game_ended");

  foreach(player in level.players) {
    triggerobj enableplayeruse(player);

    if(triggerobj == self.useownerobj) {
      if(player == owner) {
        continue;
      }
    } else if(level.teambased && player.team == owner.team && player != owner) {
      continue;
    }

    triggerobj disableplayeruse(player);
  }

  thread manualturret_disableplayeruseonconnect(owner, triggerobj);

  while(true) {
    triggerobj waittill("trigger", player);

    if(istrue(self.inuse)) {
      continue;
    }

    if(istrue(self.stopinteract)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        player[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TURRET_DYING");
      }

      continue;
    }

    if(player isonladder() || !player isonground() || player ismantling()) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        player[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
      }

      continue;
    }

    if(istrue(player.isjuggernaut)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        player[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
      }

      continue;
    }

    if(issharedfuncdefined("manual_turret", "allowPickupOfTurret")) {
      if(!player[[getsharedfunc("manual_turret", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    self.inuse = 1;
    player manualturret_toggleallowuseactions(0);
    player disableturretdismount();

    if(player == owner) {
      buttontime = 0;

      while(player useButtonPressed() && buttontime < 0.25) {
        waitframe();
        buttontime += level.framedurationseconds;
      }

      if(buttontime >= 0.25) {
        player enableturretdismount();
        continue;
      }
    }

    player notify("start_turret_use");
    self.playerusingturret = player;
    manualturret_makealltriggersusable(0);
    player scripts\cp_mp\utility\weapon_utility::saveweaponstates();
    player.useweapon = level.sentrysettings[self.turrettype].playerweaponinfo;
    player _giveweapon(player.useweapon, undefined, undefined, 1);
    turretusetime = gettime();
    result = undefined;

    while(gettime() - turretusetime < 1000) {
      result = manualturret_domonitoredweaponswitch(player, player.useweapon);

      if(!isDefined(result) || istrue(result)) {
        break;
      }

      waitframe();
    }

    if(!istrue(result)) {
      self.inuse = undefined;
      self.playerusingturret = undefined;
      manualturret_makealltriggersusable(1);

      if(isDefined(player)) {
        if(player _isalive()) {
          player manualturret_toggleallowuseactions(1);
          var_cf06a44e7221edbb = getdvarint(@ "hash_dba4a054e67dd255", 0) == 1;
          lastweaponobj = player scripts\cp_mp\utility\weapon_utility::restoreweaponstates(player.lastdroppableweaponobj, var_cf06a44e7221edbb);
          player switchtoweaponimmediate(lastweaponobj);
        }

        player clearhighpriorityweapon(player.useweapon);
        player _takeweapon(player.useweapon);
      }

      continue;
    }

    player.currentturret = self;
    player controlturreton(self);

    if(scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4()) {
      player val::set("nightmap_check", "nvg", 0);
    }

    manualturret_applyoverlay(player);

    thread function_7af27da684141f1e(player);

    thread manualturret_disablefire(player, 0.5, 1);
    thread manualturret_watchammotracker(player);
    thread manualturret_endturretuseonexecution(player);
    thread manualturret_endturretuseonpush(player);
    thread manualturret_endturretusewatch(player);
    thread manualturret_endturretonplayer(player);
    thread manualturret_watchplayerangles(player);
  }
}

function manualturret_domonitoredweaponswitch(var_7f214a58689204e8, turretuseweapon) {
  self endon("kill_turret");
  self endon("turret_switch_weapon_timeout");
  var_7f214a58689204e8 endon("death_or_disconnect");
  level endon("game_ended");
  thread manualturret_watchturretusetimeout(1);
  result = var_7f214a58689204e8 domonitoredweaponswitch(turretuseweapon, 1);
  self notify("turret_switch_weapon_ended");
  return result;
}

function manualturret_watchturretusetimeout(timeout) {
  self endon("kill_turret");
  self endon("turret_switch_weapon_ended");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(timeout);
  self notify("turret_switch_weapon_timeout");
}

function manualturret_watchdismantle(owner, dismantleobj) {
  self endon("kill_turret");
  self endon("carried_turret");
  owner endon("disconnect");
  level endon("game_ended");

  foreach(player in level.players) {
    dismantleobj enableplayeruse(player);

    if(level.teambased && player.team != owner.team) {
      continue;
    } else if(!level.teambased) {
      if(player != owner) {
        continue;
      }
    }

    dismantleobj disableplayeruse(player);
  }

  thread manualturret_disableplayerdismantleonconnect(owner);

  while(true) {
    dismantleobj waittill("trigger", player);
    self notify("kill_turret", 0, 1);
    break;
  }
}

function manualturret_applyoverlay(user) {
  user _setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
  user setclientomnvar("ui_mobile_turret_controls", 1);
  user setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);
}

function manualturret_removeoverlay(user) {
  user _setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
  user setclientomnvar("ui_mobile_turret_controls", 0);
}

function function_7af27da684141f1e(user) {
  self endon("<dev string:x1c>");
  self endon("<dev string:x2b>");
  user endon("<dev string:x3d>");
  user endon("<dev string:x4f>");
  level endon("<dev string:x5d>");
  user notifyonplayercommand("<dev string:x6b>", "<dev string:x7d>");

  while(true) {
    user waittill("<dev string:x6b>");

    if(self.reticlestate == "<dev string:x8a>") {
      user iprintlnbold("<dev string:x98>");
      self setscriptablepartstate("<dev string:xb1>", "<dev string:xc1>", 0);
      self.reticlestate = "<dev string:xc7>";
      continue;
    }

    user iprintlnbold("<dev string:xd6>");
    self setscriptablepartstate("<dev string:xb1>", "<dev string:xee>", 0);
    self.reticlestate = "<dev string:x8a>";
  }
}

function manualturret_disablefire(user, disabletime, enableendons) {
  if(istrue(enableendons)) {
    user endon("death_or_disconnect");
    level endon("game_ended");
  }

  if(isDefined(user) && scripts\cp_mp\utility\player_utility::_isalive()) {
    user freezecontrols(1);
  } else {
    return;
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(disabletime);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(user) && scripts\cp_mp\utility\player_utility::_isalive()) {
    user freezecontrols(0);
    return;
  }

  return;
}

function manualturret_enableenemyoutlines(user) {
  if(!isDefined(self.enemyoutlineinfos)) {
    self.enemyoutlineinfos = [];
  }

  thread manualturret_enableenemyoutlinesonconnect(user);

  if(issharedfuncdefined("manual_turret", "getEnemyPlayers")) {
    foreach(enemy in [[getsharedfunc("manual_turret", "getEnemyPlayers")]](user.team)) {
      if(issharedfuncdefined("perk", "hasPerk")) {
        if(enemy[[getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          if(!enemy scripts\cp_mp\utility\player_utility::_isalive()) {
            thread manualturret_enableenemyoutlineafterprotection(user, enemy, 1);
          } else if(isDefined(enemy.avoidkillstreakonspawntimer) && enemy.avoidkillstreakonspawntimer > 0) {
            thread manualturret_enableenemyoutlineafterprotection(user, enemy);
          }

          continue;
        }
      }

      manualturret_addtooutlinelist(user, enemy);
    }
  }
}

function manualturret_enableenemyoutlinesonconnect(user) {
  self endon("kill_turret");
  user endon("end_turret_use");

  while(true) {
    level waittill("connected", player);
    thread manualturret_enableenemyoutlineafterprotection(user, player, 1);
  }
}

function manualturret_removeoutlineondeath(user, var_990e778233dc8cf4, outlineid) {
  self endon("kill_turret");
  user endon("end_turret_use");
  var_990e778233dc8cf4 waittill("death_or_disconnect");
  manualturret_removefromoutlinelist(var_990e778233dc8cf4, outlineid);

  if(isDefined(var_990e778233dc8cf4)) {
    thread manualturret_restoreoutlineonspawn(user, var_990e778233dc8cf4);
  }
}

function manualturret_restoreoutlineonspawn(user, var_990e778233dc8cf4) {
  self endon("kill_turret");
  user endon("end_turret_use");
  var_990e778233dc8cf4 endon("disconnect");

  while(true) {
    level waittill("player_spawned", player);

    if(player != var_990e778233dc8cf4) {
      continue;
    }

    thread manualturret_enableenemyoutlineafterprotection(user, player);
  }
}

function manualturret_enableenemyoutlineafterprotection(user, var_990e778233dc8cf4, waitforspawn) {
  self endon("kill_turret");
  user endon("end_turret_use");

  if(istrue(waitforspawn)) {
    var_990e778233dc8cf4 waittill("spawned_player");
  }

  if(isDefined(var_990e778233dc8cf4.avoidkillstreakonspawntimer) && var_990e778233dc8cf4.avoidkillstreakonspawntimer > 0) {
    var_990e778233dc8cf4 waittill("removed_spawn_perks");
  }

  if(level.teambased && var_990e778233dc8cf4.team == user.team) {
    return;
  }

  if(issharedfuncdefined("perk", "hasPerk")) {
    if(var_990e778233dc8cf4[[getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
      return;
    }
  }

  manualturret_addtooutlinelist(user, var_990e778233dc8cf4);
}

function manualturret_addtooutlinelist(var_c9a4579b227233f3, playertoadd) {
  outlineinfo = spawnStruct();
  outlineinfo.ent = playertoadd;

  if(scripts\engine\utility::issharedfuncdefined("outline", "outlineEnableForPlayer")) {
    outlineinfo.entoutlineid = [[scripts\engine\utility::getsharedfunc("outline", "outlineEnableForPlayer")]](playertoadd, var_c9a4579b227233f3, "outline_nodepth_orange", "level_script");
  }

  self.enemyoutlineinfos[self.enemyoutlineinfos.size] = outlineinfo;
  thread manualturret_removeoutlineondeath(var_c9a4579b227233f3, playertoadd, outlineinfo.entoutlineid);
  return outlineinfo;
}

function manualturret_removefromoutlinelist(var_9d90c26327e3eacd, outlineid) {
  if(!isDefined(self.enemyoutlineinfos)) {
    return;
  }

  if(scripts\engine\utility::issharedfuncdefined("outline", "outlineDisable")) {
    [[scripts\engine\utility::getsharedfunc("outline", "outlineDisable")]](outlineid, var_9d90c26327e3eacd);
  }

  var_4f484c103c832786 = [];

  foreach(outlineinfo in self.enemyoutlineinfos) {
    if(outlineinfo.ent == var_9d90c26327e3eacd) {
      continue;
    }

    var_4f484c103c832786[var_4f484c103c832786.size] = outlineinfo;
  }

  self.enemyoutlineinfos = var_4f484c103c832786;
}

function manualturret_disableenemyoutlines(user) {
  if(!isDefined(self.enemyoutlineinfos)) {
    return;
  }

  foreach(outlineinfo in self.enemyoutlineinfos) {
    if(scripts\engine\utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\engine\utility::getsharedfunc("outline", "outlineDisable")]](outlineinfo.entoutlineid, outlineinfo.ent);
    }
  }

  self.enemyoutlineinfos = undefined;
}

function manualturret_endplayeruse(turret) {
  if(isDefined(turret)) {
    turret.inuse = undefined;
    turret.playerusingturret = undefined;
    turret manualturret_makealltriggersusable(1);
  }

  if(isDefined(self)) {
    if(!self usinggamepad()) {
      self enableturretdismount();
    }

    if(isDefined(turret)) {
      if(isDefined(self.currentturret) && self.currentturret != turret) {
        return;
      }

      self controlturretoff(turret);
      turret manualturret_removeoverlay(self);

      if(!istrue(turret.isshuttingdown)) {
        turret thread manualturret_watchpickup(turret.owner);
      }
    }

    self.currentturret = undefined;
    manualturret_toggleallowuseactions(1);

    if(scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4()) {
      val::reset_all("nightmap_check");
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() || scripts\cp_mp\utility\game_utility::isbrstylegametype() && !istrue(self.inlaststand)) {
      var_cf06a44e7221edbb = getdvarint(@ "hash_dba4a054e67dd255", 0) == 1;
      lastweaponobj = scripts\cp_mp\utility\weapon_utility::restoreweaponstates(self.lastdroppableweaponobj, var_cf06a44e7221edbb);
      self switchtoweaponimmediate(lastweaponobj);
    }

    _takeweapon(self.useweapon);
    thread manualturret_disablecrouchpronemantle();

    if(_isalive()) {
      self setOrigin(turret.lastuserpos, 1);
      self setplayerangles(turret.lastuserangles);
    }

    self notify("end_turret_use");
  }
}

function manualturret_disablecrouchpronemantle() {
  self endon("death_or_disconnect");
  val::set("manual_turret", "crouch", 0);
  val::set("manual_turret", "prone", 0);
  val::set("manual_turret", "mantle", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  val::reset_all("manual_turret");
}

function manualturret_disableplayeruseonconnect(owner, useobj) {
  if(isDefined(self)) {
    self endon("kill_turret");
    self endon("carried_turret");
  }

  owner endon("disconnect");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    useobj disableplayeruse(player);
  }
}

function manualturret_endturretuseonexecution(user) {
  self endon("kill_turret");
  self endon("carried_turret");
  user endon("end_turret_use");
  user endon("disconnect");
  level endon("game_ended");

  while(true) {
    if(user isinexecutionvictim()) {
      user manualturret_endplayeruse(self);
      break;
    }

    waitframe();
  }
}

function manualturret_endturretuseonpush(user) {
  self endon("kill_turret");
  self endon("carried_turret");
  user endon("end_turret_use");
  user endon("disconnect");
  level endon("game_ended");
  detachdistancesq = 2500;

  if(isDefined(self.moving_platform)) {
    detachdistancesq = 10000;
  }

  while(true) {
    if(distancesquared(self.origin, user.origin) >= detachdistancesq) {
      user manualturret_endplayeruse(self);
      break;
    }

    waitframe();
  }
}

function manualturret_endturretusewatch(user) {
  self endon("kill_turret");
  self endon("carried_turret");
  user endon("end_turret_use");
  user endon("disconnect");
  level endon("game_ended");

  while(user useButtonPressed()) {
    waitframe();
  }

  while(true) {
    if(user useButtonPressed()) {
      user manualturret_endplayeruse(self);
      break;
    }

    waitframe();
  }
}

function manualturret_endturretonplayer(user) {
  user endon("end_turret_use");
  level endon("game_ended");
  user waittill_any_2("death_or_disconnect", "last_stand_start");
  user manualturret_endplayeruse(self);
}

function manualturret_watchplayerangles(user) {
  self endon("kill_turret");
  user endon("end_turret_use");
  user endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    self.lastuserpos = user.origin;
    self.lastuserangles = user getplayerangles();
    waitframe();
  }
}

function manualturret_watchpickup(owner) {
  if(!isDefined(owner)) {
    return;
  }

  self endon("kill_turret");
  self endon("carried_turret");
  owner endon("disconnect");
  owner endon("start_turret_use");
  level endon("game_ended");

  while(isDefined(self) && isDefined(self.useownerobj)) {
    self.useownerobj waittill("trigger_progress", player);
    buttontime = 0;

    while(owner useButtonPressed() && buttontime < 0.25) {
      waitframe();
      buttontime += level.framedurationseconds;
    }

    if(!isDefined(player)) {
      continue;
    }

    if(buttontime < 0.25) {
      continue;
    }

    if(istrue(self.stopinteract)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        player[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TURRET_DYING");
      }

      continue;
    }

    if(istrue(player.isjuggernaut)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        player[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
      }

      continue;
    }

    if(issharedfuncdefined("manual_turret", "allowPickupOfTurret")) {
      if(!player[[getsharedfunc("manual_turret", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    manualturret_makealltriggersusable(0);
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    owner.placedsentries[self.turrettype] = array_remove(owner.placedsentries[self.turrettype], self);
    thread manualturret_setcarried(owner);
  }
}

function manualturret_watchdelayedpickup(owner) {
  self endon("kill_turret");
  owner endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  thread manualturret_watchpickup(owner);
}

function manualturret_disableplayerpickuponconnect(turret) {
  turret endon("kill_turret");
  turret endon("carried_turret");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    turret.useownerobj disableplayeruse(player);
  }
}

function manualturret_watchdamage(owner) {
  if(scripts\engine\utility::issharedfuncdefined("manual_turret", "monitorDamage")) {
    self[[scripts\engine\utility::getsharedfunc("manual_turret", "monitorDamage")]](self.maxhealth, "hitequip", &manualturret_handledeathdamage, &manualturret_modifydamage, 1);
  }
}

function manualturret_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level.sentrysettings[self.turrettype];
  notifyattacker = 0;

  if(scripts\engine\utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
    notifyattacker = [[scripts\engine\utility::getsharedfunc("damage", "onKillstreakKilled")]](config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash);
  }

  if(notifyattacker) {
    attacker notify("destroyed_equipment");
  }

  explosivedamage = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH") {
    explosivedamage = 1;
  }

  self notify("kill_turret", explosivedamage, 1);
}

function manualturret_modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;

  if(issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    modifieddamage = self[[getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, type, modifieddamage, self.maxhealth, 1, 1, 2, 7, 5);
  }

  return modifieddamage;
}

function manualturret_disableplayerdismantleonconnect(owner) {
  self endon("kill_turret");
  self endon("carried_turret");
  owner endon("disconnect");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    player waittill("spawned_player");

    if(level.teambased) {
      if(player.team != owner.team) {
        continue;
      }
    }

    self.dismantleobj disableplayeruse(player);
  }
}

function manualturret_watchdeath(owner) {
  self endon("carried_turret");
  self waittill("kill_turret", skipshutdown, wasdestroyed);
  self.isshuttingdown = 1;

  if(isDefined(owner)) {
    owner.placedsentries[self.turrettype] = array_remove(owner.placedsentries[self.turrettype], self);
    owner manualturret_setinactive(self);
    manualturret_disableenemyoutlines(owner);

    if(issharedfuncdefined("player", "printGameAction")) {
      owner[[getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", owner);
    }

    self.streakinfo.expiredbydeath = istrue(wasdestroyed);
    owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  if(isDefined(self.playerusingturret)) {
    self.playerusingturret manualturret_endplayeruse(self);
  }

  if(isDefined(self.useownerobj)) {
    self.useownerobj delete();
  }

  if(isDefined(self.useotherobj)) {
    self.useotherobj delete();
  }

  if(!istrue(skipshutdown)) {
    self playSound("sentry_explode_smoke");
    self setscriptablepartstate("shutdown", "on");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    self setscriptablepartstate("explode", "regular");
  } else {
    self setscriptablepartstate("explode", "violent");
  }

  self playSound("mp_equip_destroyed");
  level callback::callback("killstreak_finish_use", {
    #streakinfo: self.streakinfo
  });

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self.colmodel)) {
    self.colmodel delete();
  }

  if(isDefined(self.minimapid)) {
    if(issharedfuncdefined("game", "returnObjectiveID")) {
      [[getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  wait 0.2;
  self delete();
}

function manualturret_watchdeathongameend() {
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

function manualturret_watchtimeout(owner) {
  self endon("kill_turret");
  self endon("carried_turret");
  owner endon("disconnect");
  level endon("game_ended");
  var_38e63990bd3d9ed4 = self.timeout;

  if(!isDefined(self.timeelapsed)) {
    self.timeelapsed = 0;
  }

  while(self.timeelapsed < var_38e63990bd3d9ed4) {
    timepercent = (var_38e63990bd3d9ed4 - self.timeelapsed) / var_38e63990bd3d9ed4;
    timepercent = int(ceil(clamp(timepercent, 0, 1) * 100));

    if(isDefined(self.playerusingturret)) {
      self.playerusingturret setclientomnvar("ui_killstreak_countdown", int(timepercent));
    }

    self.timeelapsed += level.framedurationseconds;

    if(self.timeelapsed >= var_38e63990bd3d9ed4 - 1.5 && !istrue(self.stopinteract)) {
      self.stopinteract = 1;
    }

    waitframe();
  }

  owner playkillstreakoperatordialog("manual_turret", "timeout_" + self.streakinfo.streakname, 1);
  self notify("kill_turret", 0, 0);
}

function manualturret_watchammotracker(user) {
  self endon("kill_turret");
  self endon("carried_turret");
  user endon("end_turret_use");
  user endon("disconnect");
  level endon("game_ended");
  config = level.sentrysettings[self.turrettype];
  var_83fb464c27e79a0e = weaponfiretime(config.weaponinfo);

  if(!isDefined(self.hideammoindex)) {
    self.hideammoindex = 1;
  }

  assertex(isDefined(var_83fb464c27e79a0e) && var_83fb464c27e79a0e > 0, "<dev string:xf5>");

  while(user isusingturret()) {
    while(user attackButtonPressed()) {
      self.streakinfo.shots_fired++;
      self.ammocount--;
      user setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);

      if(self.ammocount <= 12) {
        self setscriptablepartstate("hide_ammo_" + self.hideammoindex, "on", 0);
        self.hideammoindex++;
      }

      if(self.ammocount == 100) {
        user playkillstreakoperatordialog("manual_turret", self.streakinfo.streakname + "_low_ammo");
      } else if(self.ammocount <= 0) {
        user playkillstreakoperatordialog("manual_turret", self.streakinfo.streakname + "_no_ammo");
        self notify("kill_turret", 0, 0);
        break;
      }

      wait var_83fb464c27e79a0e;
    }

    waitframe();
  }
}

function manualturret_watchdisown(owner) {
  self endon("kill_turret");
  self endon("carried_turret");
  owner thread manualturret_disownonaction(self, "disconnect");
  owner thread manualturret_disownonaction(self, "joined_team");
  owner thread manualturret_disownonaction(self, "joined_spectators");
}

function manualturret_disownonaction(turret, action) {
  turret endon("kill_turret");
  self endon("carried_turret");
  self endon("disowned_turret");
  level endon("game_ended");
  self waittill(action);
  turret notify("kill_turret", 0, 0);
  self notify("disowned_turret");
}

function manualturret_setturretmodel(type) {
  turretmodel = undefined;

  if(type == "placed") {
    turretmodel = level.sentrysettings[self.turrettype].modelbaseground;
  } else {
    turretmodel = level.sentrysettings[self.turrettype].modeldestroyedground;
  }

  assertex(isDefined(turretmodel), "<dev string:x161>");
  self setModel(turretmodel);
}

function manualturret_makealltriggersusable(bool) {
  if(!istrue(bool)) {
    self.useownerobj function_dfb78b3e724ad620(0);
    self.useotherobj function_dfb78b3e724ad620(0);
    return;
  }

  self.useownerobj function_dfb78b3e724ad620(1);
  self.useotherobj function_dfb78b3e724ad620(1);
}

function manualturret_toggleallowplacementactions(bool) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    if(!bool) {
      val::set("manual_turret_placement", "sprint", 0);
      val::set("manual_turret_placement", "weapon_switch", 0);
      val::set("manual_turret_placement", "offhand_weapons", 0);
      val::set("manual_turret_placement", "melee", 0);
      val::set("manual_turret_placement", "execution_attack", 0);
      val::set("manual_turret_placement", "ladder_placement", 0);
      return;
    }

    val::reset_all("manual_turret_placement");
  }
}

function manualturret_toggleallowuseactions(bool) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    if(!bool) {
      val::set("manual_turret_use", "offhand_weapons", 0);
      val::set("manual_turret_use", "melee", 0);
      val::set("manual_turret_use", "supers", 0);
      val::set("manual_turret_use", "allow_movement", 0);
      return;
    }

    val::reset_all("manual_turret_use");
  }
}