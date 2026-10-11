/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\killstreaks\sentry_gun.gsc
*******************************************************/

#using script_16ea1b94f0f381b3;
#using script_608c50392df8c7d1;
#using scripts\common\callbacks;
#using scripts\common\damage_tuning;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\killstreaks\manual_turret;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\sentientpoolmanager;
#namespace sentry_gun;

function init() {
  if(issharedfuncdefined("sentry_gun", "init")) {
    [[getsharedfunc("sentry_gun", "init")]]();
  }

  if(issharedfuncdefined("sentry_gun", "initSentrySettings")) {
    [[getsharedfunc("sentry_gun", "initSentrySettings")]]();
  }

  bundle = level.streakglobals.streakbundles["sentry_gun"];

  if(isDefined(bundle) && isDefined(bundle.spawnweapon)) {
    registerkillstreakdamagedealingweaponsharedfunc("sentry_gun", bundle.spawnweapon, #"large");
  }

  setdevdvarifuninitialized(@ "hash_c9bd691ce96079ac", 0);
  setdevdvarifuninitialized(@ "hash_e19e5d308effeda3", 1);
  setdevdvarifuninitialized(@ "hash_8b57c69d6f7ca720", 0);
}

function weaponcleanupsentryturret(streakinfo, switchresult, weaponobj) {
  if(!istrue(switchresult)) {
    scripts\cp_mp\killstreaks\killstreakdeploy::getridofkillstreakdeployweapon(weaponobj);
  }
}

function tryusesentryturret(streakname) {
  streakinfo = createstreakinfo(streakname, self);
  return tryusesentryturretfromstruct(streakinfo);
}

function tryusesentryturretfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      self.bgivensentry = 0;
      return false;
    }
  }

  scripts\cp_mp\utility\weapon_utility::saveweaponstates();

  if(!istrue(function_8fbbc6a868621dd5())) {
    return false;
  }

  forceenemyturret = getdvarint(@ "hash_8b57c69d6f7ca720", 0);

  if(forceenemyturret) {
    if(level.teambased) {
      turretteam = ter_op(self.team == "<dev string:x1c>", "<dev string:x23>", "<dev string:x1c>");

      if(level.teamdata[turretteam]["<dev string:x28>"].size == 0) {
        assertmsg("<dev string:x30>");
        return false;
      }
    } else if(level.teamdata[self.team]["<dev string:x28>"].size == 1) {
      assertmsg("<dev string:x30>");
      return false;
    }
  }

  switchresult = function_6633c7714fc94777(streakinfo);

  if(!istrue(switchresult)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      self.bgivensentry = 0;
      return false;
    }
  }

  turret = sentryturret_create("sentry_turret", streakinfo);

  if(!isDefined(turret)) {
    self.bgivensentry = 0;
    return false;
  }

  marker = sentryturret_watchplacement(turret, streakinfo, 0, 1.25);

  if(!isDefined(marker)) {
    turret delete();
    self.bgivensentry = 0;
    return false;
  }

  turret function_641996b5e113c5c6(turret, &sentryturret_empapplied, &sentryturret_empstarted, &sentryturret_empcleared);

  if(issharedfuncdefined(#"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672")) {
    turret[[getsharedfunc(#"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672")]](turret, &function_4b9ae5f8bf842050, &function_4b9ae5f8bf842050);
  }

  sentryturret_setplaced(turret, marker);

  if(issharedfuncdefined("sentry_gun", "munitionUsed")) {
    self[[getsharedfunc("sentry_gun", "munitionUsed")]]();
  }

  return true;
}

function sentryturret_watchplacement(turret, streakinfo, ignorecancel, var_290b1442271ab369) {
  self.bgivensentry = 1;
  turret laseroff();
  thread sentryturret_delayplacementinstructions(var_290b1442271ab369);
  var_498a2226e5aa47ee = 0;

  if(scripts\engine\utility::issharedfuncdefined("game", "getGameType")) {
    var_498a2226e5aa47ee = [[scripts\engine\utility::getsharedfunc("game", "getGameType")]]() == "br";
  }

  if(var_498a2226e5aa47ee) {
    thread function_5c005d2b1101bc78();
  }

  marker = undefined;

  if(issharedfuncdefined("sentry_gun", "watchForPlayerEnteringLastStand")) {
    self thread[[getsharedfunc("sentry_gun", "watchForPlayerEnteringLastStand")]]();
  }

  if(issharedfuncdefined("sentry_gun", "getTargetMarker")) {
    marker = self[[getsharedfunc("sentry_gun", "getTargetMarker")]](streakinfo, ignorecancel);
  }

  self notify("turret_placement_finished");
  self playSound("sentry_gun_plant_foley");
  scripts\common\values::set("sentry", "armor", 1);
  bundle = level.streakglobals.streakbundles["sentry_gun"];
  deployweaponname = default_to(bundle.deployweapon, "deploy_sentry_mp");

  if(!isDefined(marker) || !isDefined(marker.location)) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      killstreak_switchbacklastweapon(deployweaponname);
    }

    return undefined;
  }

  turret thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(self, 1, 1);

  if(self hasweapon(deployweaponname)) {
    thread killstreak_switchbacklastweapon(deployweaponname, 1, 1);
  }

  if(issharedfuncdefined("sentry_gun", "setActionSets")) {
    self[[getsharedfunc("sentry_gun", "setActionSets")]](0);
  }

  delayspawntime = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delayspawntime);

  if(issharedfuncdefined("sentry_gun", "setActionSets")) {
    self[[getsharedfunc("sentry_gun", "setActionSets")]](1);
  }

  return marker;
}

function function_5c005d2b1101bc78() {
  self endon("turret_placement_finished");
  self endon("death_or_disconnect");
  self waittill("last_stand_start");
  scripts\common\values::set("sentry", "armor", 1);
  self notify("equip_deploy_cancel");
}

function sentryturret_delayplacementinstructions(delaytime) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  self setclientomnvar("ui_turret_placement", 2);
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("death");
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("turret_placement_finished");
}

function sentryturret_create(turrettype, streakinfo) {
  config = level.sentrysettings[turrettype];
  turret = spawnturret("misc_turret", self.origin, level.sentrysettings[turrettype].weaponinfo);
  turret.owner = self;
  turret.team = self.team;
  turret.isdisabled = 0;

  forceenemyteam = getdvarint(@ "hash_8b57c69d6f7ca720", 0);

  if(forceenemyteam) {
    if(level.teambased) {
      turret.team = ter_op(self.team == "<dev string:x1c>", "<dev string:x23>", "<dev string:x1c>");
      turret.owner = level.teamdata[turret.team]["<dev string:x28>"][0];
    } else {
      foreach(player in level.players) {
        if(player != self) {
          turret.owner = player;
          turret.team = player.team;
          break;
        }
      }
    }
  }

  turret.angles = self.angles;
  turret.health = 9999;
  turret.maxhealth = config.maxhealth;
  turret.streakinfo = streakinfo;
  turret.turrettype = turrettype;
  turret.shouldsplash = 1;
  turret.ammocount = config.ammo;
  turret.timeout = config.timeout;

  if(issharedfuncdefined("sentry_gun", "attachXRays")) {
    turret = [[getsharedfunc("sentry_gun", "attachXRays")]](turret);
  }

  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    turret.timeout = 9999;
  }

  if(!isDefined(turret.timeout)) {
    turret.timeout = 120;
  }

  turret.carriedby = self;
  turret sentryturret_setturretmodel("placed");
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
    case #"hash_fa4536bde6f7ad9":
    default:
      turret maketurretinoperable();
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
  turret function_49197cd063a740ea(&elevator_turretcallback);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      elevators thread scripts\common\elevators::isentitytouchingdoortrigger(turret);
    }
  }

  if(iscp()) {
    turret makeentitysentient(turret.team);
  }

  killcamforward = anglesToForward(turret.angles);
  killcampos = turret gettagorigin("tag_laser") + (0, 0, 10);
  killcampos -= killcamforward * 20;
  killcament = spawn("script_model", killcampos);
  killcament linkTo(turret);
  turret.killcament = killcament;
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel.turretowner = turret;
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel hide();

  if(isDefined(config.hitbyvehiclefunc)) {
    turret.hitbyvehiclefunc = config.hitbyvehiclefunc;
  }

  return turret;
}

function function_5be2524e8daf7546(turret) {
  if(!isDefined(self.placedsentries)) {
    self.placedsentries = [];
  }

  if(!isDefined(self.placedsentries[turret.turrettype])) {
    self.placedsentries[turret.turrettype] = [];
  }

  self.placedsentries[turret.turrettype][self.placedsentries.size] = turret;
}

function function_a06fbf5fc1e4a4ef(turret) {
  self.placedsentries[turret.turrettype] = array_remove(self.placedsentries[turret.turrettype], turret);
}

function sentryturret_setplaced(turret, marker) {
  config = level.sentrysettings[turret.turrettype];
  turret sentryturret_setturretmodel("placed");

  if(istrue(level.var_9696753a29908c90)) {
    function_5be2524e8daf7546(turret);
  }

  if(istrue(turret.shouldsplash)) {
    if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, turret.streakinfo.streakname);
    }

    killstreak_dangernotifyplayersinrange(self, self.team, 2000, turret.streakinfo.streakname);
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

    if(issharedfuncdefined("turret", "movingPlatformOnPlaced")) {
      level thread[[getsharedfunc("turret", "movingPlatformOnPlaced")]](turret, marker);
    }
  }

  self.bgivensentry = 0;
  turret.origin = marker.location;
  turret playSound("sentry_gun_plant");
  turret setscriptablepartstate("lights", "daytime", 0);
  deploystatus = getdvarint(@ "hash_6f41bda368c6075f", 0);

  if(isDefined(marker.moving_platform) && deploystatus) {
    if(marker.moving_platform.classname == "script_vehicle") {
      turret linkTo(marker.moving_platform);

      if(!isDefined(marker.moving_platform.linkedturrets)) {
        marker.moving_platform.linkedturrets = [];
      }

      marker.moving_platform.linkedturrets[marker.moving_platform.linkedturrets.size] = turret;
    }
  }

  turret.colmodel show();
  turret.colmodel.angles = turret.angles;
  turret.colmodel.origin = turret.origin;
  turret.colmodel linkTo(turret);
  turreticon = "hud_icon_minimap_killstreak_sentry";

  if(issharedfuncdefined("game", "createObjective")) {
    turret.minimapid = turret.colmodel[[getsharedfunc("game", "createObjective")]](turreticon, turret.team, undefined, 1, 1);
  }

  headiconoffset = 70;

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    turret[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](turret.turrettype, "Killstreak_Ground", self, 0, 1, headiconoffset, "carried");
  }

  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeon);
  function_5c49802fcf1a63ed(turret, config);

  if(scripts\engine\utility::issharedfuncdefined("sentry_gun", "handleMovingPlatform")) {
    [[scripts\engine\utility::getsharedfunc("sentry_gun", "handleMovingPlatform")]](turret);
  }

  turret scripts\cp_mp\emp_debuff::allow_emp(1);
  turret scripts\mp\sentientpoolmanager::registersentient("Killstreak_Static", self);
  turret function_4b9ae5f8bf842050(turret, 1);
  turret thread sentry_attacktargets();

  turret thread function_c057f52574c94670();

  thread sentryturret_delaydeletemarker(turret, marker);
  thread sentryturret_watchpickup(turret);
  thread sentryturret_watchdamage(turret);
  thread sentryturret_watchdeath(turret);
  thread sentryturret_watchtimeout(turret);
  thread sentryturret_watchdisown(turret);
  thread sentryturret_watchgameend(turret);
  turret notify("turret_place_successful");
}

function function_5c49802fcf1a63ed(turret, config) {
  hinttag = "tag_aim_pivot";
  hintpos = turret gettagorigin(hinttag);

  if(!isDefined(turret.useownerobj)) {
    hinticon = undefined;
    hintduration = undefined;
    hintdist = undefined;
    usedist = undefined;

    if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
      hinticon = "hud_icon_killstreak_sentry";
      hintduration = "duration_none";
      hintdist = 50;
      usedist = 50;
    }

    if(scripts\engine\utility::issharedfuncdefined("sentry_gun", "createHintObject")) {
      turret.useownerobj = [[scripts\engine\utility::getsharedfunc("sentry_gun", "createHintObject")]](hintpos, "HINT_BUTTON", hinticon, config.ownerusehintstring, undefined, hintduration, "show", hintdist, undefined, usedist, undefined);
    }
  } else {
    turret.useownerobj function_dfb78b3e724ad620(1);
    turret.useownerobj dontinterpolate();
    turret.useownerobj.origin = hintpos;
  }

  foreach(guy in level.players) {
    if(guy != turret.owner) {
      turret.useownerobj disableplayeruse(guy);
      continue;
    }

    turret.useownerobj enableplayeruse(guy);
  }

  turret.useownerobj linkTo(turret, hinttag);
}

function sentryturret_setcarried(turret) {
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
  turret scripts\mp\sentientpoolmanager::unregistersentient(turret.sentientpool, turret.sentientpoolindex);
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
  sentryturret_setinactive(turret);
  turret hide();
  turret.carriedby = self;
  turret notify("carried");

  if(istrue(self.var_81fcf56aaed3e005)) {
    if(isDefined(level.var_b67b5f9dfe488c2f)) {
      thread[[level.var_f56a88761038798b]](self.streakinfo);
      self.var_81fcf56aaed3e005 = 0;
    }
  }

  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  switchresult = function_6633c7714fc94777(turret.streakinfo, turret);

  if(!istrue(switchresult)) {
    callsharedfunc("killstreak", "refundKillstreak", "sentry", 1, 0, 0, 1);
    return;
  }

  marker = sentryturret_watchplacement(turret, turret.streakinfo, 1, 2);

  if(!isDefined(marker)) {
    turret delete();
    self.bgivensentry = 0;
    callsharedfunc("killstreak", "refundKillstreak", "sentry", 1, 0, 0, 1);
    return;
  }

  sentryturret_setplaced(turret, marker);
}

function sentryturret_switchbacklastweapon(immediateswitch) {
  if(istrue(immediateswitch)) {
    _switchtoweaponimmediate(self.lastdroppableweaponobj);
  } else {
    _switchtoweapon(self.lastdroppableweaponobj);
  }

  bundle = level.streakglobals.streakbundles["sentry_gun"];
  deployweaponname = default_to(bundle.deployweapon, "deploy_sentry_mp");
  _takeweapon(deployweaponname);
}

function sentryturret_setinactive(turret) {
  turret setdefaultdroppitch(30);
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
  turret.useownerobj function_dfb78b3e724ad620(0);
  turret.useownerobj unlink();
}

function sentryturret_delaydeletemarker(turret, marker) {
  turret endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(marker.visual)) {
    marker.visual delete();
  }
}

function sentryturret_disableplayeruseonconnect(turret, useobj) {
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

function sentryturret_watchpickup(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  turret endon("turret_hacked");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    turret.useownerobj waittill("trigger", player);

    if(player != self) {
      continue;
    }

    if(issharedfuncdefined("sentry_gun", "allowPickupOfTurret")) {
      if(!player[[getsharedfunc("sentry_gun", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    if(!istrue(function_8fbbc6a868621dd5(turret))) {
      continue;
    }

    turret.useownerobj function_dfb78b3e724ad620(0);
    turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
    deploystatus = getdvarint(@ "hash_6f41bda368c6075f", 0);

    if(isDefined(turret.moving_platform) && isDefined(turret.moving_platform.linkedturrets) && deploystatus) {
      for(index = 0; index < turret.moving_platform.linkedturrets.size; index++) {
        veh_turret = turret.moving_platform.linkedturrets[index];

        if(isDefined(veh_turret) && veh_turret == turret) {
          turret.moving_platform.linkedturrets[index] = undefined;
          turret unlink();
          break;
        }
      }
    }

    if(istrue(level.var_9696753a29908c90)) {
      function_a06fbf5fc1e4a4ef(turret);
    }

    thread sentryturret_setcarried(turret);
  }
}

function sentryturret_disableplayerpickuponconnect(turret) {
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

function sentryturret_watchdismantle(turret) {
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

  thread sentryturret_disableplayerdismantleonconnect(turret);

  while(true) {
    turret.dismantleobj waittill("trigger", player);
    turret notify("kill_turret", 0, 1);
    break;
  }
}

function sentryturret_watchdamage(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\engine\utility::issharedfuncdefined("sentry_gun", "monitorDamage")) {
    self[[scripts\engine\utility::getsharedfunc("sentry_gun", "monitorDamage")]](turret);
  }
}

function sentryturret_disableplayerdismantleonconnect(turret) {
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

function sentryturret_empapplied(data) {
  bundle = level.streakglobals.streakbundles["sentry_gun"];
  var_e913079a5ffda56d = bundle.var_e913079a5ffda56d;

  if(function_8e610f938a53a07d() < function_4a2ecb33b6adeb85(data, var_e913079a5ffda56d)) {
    return;
  }

  turret = data.victim;
  turret notify("kill_turret", 1, 1);
  self notify("enemy_destroyed_equipment", data.attacker);
}

function sentryturret_empstarted(data) {
  if(isDefined(data.attacker)) {
    data.attacker thread callsharedfunc("player", "doScoreEvent", #"emp_disable");

    if(issharedfuncdefined("sentry_gun", "empStarted")) {
      self[[getsharedfunc("sentry_gun", "empStarted")]]();
    }
  }

  function_4b9ae5f8bf842050(self);
}

function sentryturret_empcleared(isdeath) {
  if(isdeath) {
    return;
  }

  if(issharedfuncdefined("sentry_gun", "empStarted")) {
    self[[getsharedfunc("sentry_gun", "empCleared")]]();
  }

  function_4b9ae5f8bf842050(self);
}

function private function_4b9ae5f8bf842050(turret, forceupdate) {
  isemped = isDefined(turret.empcount) && turret.empcount > 0;
  isjammed = istrue(turret.isjammed);
  var_3f49de7972a16b2b = isemped || isjammed;

  if(var_3f49de7972a16b2b && (!turret.isdisabled || istrue(forceupdate))) {
    turret.isdisabled = 1;
    function_60b382eee27f4f91(turret);
    return;
  }

  if(!var_3f49de7972a16b2b && (turret.isdisabled || istrue(forceupdate))) {
    turret.isdisabled = 0;
    function_46b8598cc2ff1a03(turret);
  }
}

function private function_60b382eee27f4f91(turret) {
  self turretfiredisable();
  self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
  self laseroff();
}

function private function_46b8598cc2ff1a03(turret) {
  self turretfireenable();
  self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
  self laseron();
}

function sentryturret_watchdeath(turret) {
  turret endon("carried");
  turret waittill("kill_turret", skipshutdown, wasdestroyed);

  if(isDefined(self)) {
    if(istrue(level.var_9696753a29908c90)) {
      function_a06fbf5fc1e4a4ef(turret);
    }

    sentryturret_setinactive(turret);

    if(issharedfuncdefined("player", "printGameAction")) {
      self[[getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", self);
    }

    turret.streakinfo.expiredbydeath = istrue(wasdestroyed);
    scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(turret.streakinfo);

    if(istrue(turret.var_81fcf56aaed3e005)) {
      if(isDefined(level.var_b67b5f9dfe488c2f)) {
        thread[[level.var_f56a88761038798b]](turret.streakinfo);
        self.var_81fcf56aaed3e005 = 0;
      }
    }
  }

  if(istrue(wasdestroyed)) {
    playkillstreakteamleaderdialog(turret.streakinfo.streakname, turret.streakinfo.streakname + "_teamleader_destroyed");
  }

  turret sentryturret_setturretmodel("destroyed");
  turret setturretowner(undefined);

  if(!istrue(skipshutdown)) {
    turret setscriptablepartstate("shutdown", "on");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    turret setscriptablepartstate("explode", "regular");
  } else {
    turret setscriptablepartstate("explode", "violent");
  }

  level callback::callback("killstreak_finish_use", {
    #streakinfo: turret.streakinfo
  });

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

  turret function_83cebe0ae5318a7f(turret);

  if(issharedfuncdefined(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")) {
    turret[[getsharedfunc(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")]](turret);
  }

  wait 0.2;
  turret delete();
}

function sentryturret_delayscriptabledelete() {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

function sentryturret_watchtimeout(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(turret.timeout > 0) {
    turret.timeout -= 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  playkillstreakteamleaderdialog(turret.streakinfo.streakname, turret.streakinfo.streakname + "_teamleader_timeout");
  turret notify("kill_turret", 0, 0);
}

function sentryturret_watchdisown(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  waittill_any_3("disconnect", "joined_team", "joined_spectators");
  turret notify("kill_turret", 0, 0);
}

function sentryturret_watchgameend(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  level waittill("game_ended");
  turret notify("kill_turret", 0, 0);
}

function sentryturret_setturretmodel(type) {
  turretmodel = undefined;

  if(type == "placed") {
    turretmodel = level.sentrysettings[self.turrettype].modelbaseground;
  } else {
    turretmodel = level.sentrysettings[self.turrettype].modeldestroyedground;
  }

  modeltype = getdvarint(@ "hash_e19e5d308effeda3", 1);

  if(!modeltype) {
    turretmodel = "<dev string:xb7>";
  }

  assertex(isDefined(turretmodel), "For some reason turretModel is not defined, this should never happen");
  self setModel(turretmodel);
}

function function_6633c7714fc94777(streakinfo, existingturret) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  endonnotify = "sentry_placement_failed";

  if(issharedfuncdefined("weapons", "watchForPlacementFireState")) {
    self thread[[getsharedfunc("weapons", "watchForPlacementFireState")]](streakinfo, endonnotify);
  }

  bundle = level.streakglobals.streakbundles["sentry_gun"];
  deployweaponname = default_to(bundle.deployweapon, "deploy_sentry_mp");
  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, makeweapon(deployweaponname), 1, undefined, undefined, &weaponcleanupsentryturret);

  if(!istrue(deployresult)) {
    self notify(endonnotify);
    self.bgivensentry = 0;
    return false;
  }

  self playSound("sentry_pickup");
  scripts\common\values::set("sentry", "armor", 0);
  return true;
}

function function_8fbbc6a868621dd5(existingturret) {
  currentstance = self getstance();

  if(currentstance == "stand" || currentstance == "crouch") {
    return true;
  }

  cannotcrouch = self getstanceblocked("crouch");

  if(istrue(cannotcrouch)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      if(iscp()) {
        self[[getsharedfunc("hud", "showErrorMessage")]]("EQUIPMENT/ARMAMENT_CANNOT_BE_USED");
      } else {
        self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
      }
    }

    return false;
  }

  return true;
}

function sentry_attacktargets(configoverride) {
  self.owner endon("<dev string:xd2>");

  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  self.momentum = 0;
  self.var_81fcf56aaed3e005 = 0;

  while(true) {
    self waittill("turretstatechange");

    if(self isfiringturret()) {
      self laseron();
      thread sentry_burstfirestart(configoverride);

      if(isDefined(level.var_b67b5f9dfe488c2f)) {
        thread[[level.var_b67b5f9dfe488c2f]](self.streakinfo);
        self.var_81fcf56aaed3e005 = 1;
      }

      continue;
    }

    self laseroff();
    sentry_spindown();
    thread sentry_burstfirestop();

    if(isDefined(level.var_b67b5f9dfe488c2f)) {
      thread[[level.var_f56a88761038798b]](self.streakinfo);
      self.var_81fcf56aaed3e005 = 0;
    }
  }
}

function function_c057f52574c94670(configoverride) {
  self endon("<dev string:xe9>");
  self endon("<dev string:xf5>");
  level endon("<dev string:xfd>");
  self.turrettarget = spawn("<dev string:x108>", self gettagorigin("<dev string:x115>") + anglesToForward(self gettagangles("<dev string:x115>") * 300));
  self.turrettarget.targeton = 0;
  self.turrettarget dontinterpolate();
  self.turrettarget thread function_e2a098b6c28a80cb(self);
  self.turrettarget thread function_2937914e0c4fb627(self);
  turretconfig = undefined;

  if(isDefined(configoverride)) {
    turretconfig = configoverride;
  } else {
    turretconfig = level.sentrysettings[self.turrettype];
  }

  sentrymode = turretconfig.sentrymodeon;
  manualmode = "<dev string:x11f>";
  turretmode = sentrymode;
  notifyon = 0;

  while(true) {
    if(getdvarint(@ "hash_c9bd691ce96079ac", 0) == 1) {
      if(!istrue(notifyon)) {
        self.owner notifyonplayercommand("<dev string:xd2>", "<dev string:x12d>");
        notifyon = 1;
      }

      self.owner waittill("<dev string:xd2>");

      if(turretmode != manualmode) {
        self setmode(manualmode);
        turretmode = manualmode;
        starttrace = self.owner getvieworigin();
        endtrace = starttrace + anglesToForward(self.owner getplayerangles()) * 50000;
        trace = scripts\engine\trace::ray_trace(starttrace, endtrace, self.owner);
        endpos = undefined;

        if(isDefined(trace["<dev string:x13a>"]) && trace["<dev string:x13a>"] != "<dev string:x142>") {
          endpos = trace["<dev string:x14f>"];
        }

        if(isDefined(endpos)) {
          thread function_9004e9c694f0db7b(endpos);
        }
      } else {
        function_c44bb0461339a1f1();
        turretmode = sentrymode;
        self setmode(turretmode);
        thread sentry_attacktargets();
      }

      continue;
    }

    notifyon = 0;

    if(turretmode != sentrymode) {
      self.owner notifyonplayercommandremove("<dev string:xd2>", "<dev string:x12d>");
      function_c44bb0461339a1f1();
      turretmode = sentrymode;
      self setmode(turretmode);
      thread sentry_attacktargets();
    }

    waitframe();
  }
}

function function_9004e9c694f0db7b(firepos) {
  self.owner endon("<dev string:x158>");
  self.owner endon("<dev string:xd2>");
  self endon("<dev string:xe9>");
  self endon("<dev string:xf5>");
  level endon("<dev string:xfd>");
  self laseroff();
  thread sentry_burstfirestop();
  self.turrettarget.origin = firepos;
  self settargetentity(self.turrettarget);
  self.turrettarget.targeton = 1;
  starttag = "<dev string:x16b>";

  if(self.streakinfo.streakname == "<dev string:x17c>") {
    starttag = "<dev string:x187>";
  }

  endtag = "<dev string:x115>";
  wait 1;
  self laseron();

  while(true) {
    var_30c9c9336ef2caaf = self gettagorigin(starttag);
    var_831cc1b8f4225351 = self gettagangles(starttag);
    thread drawsphere(var_30c9c9336ef2caaf, 2, 1, (0, 1, 1));
    thread drawline(var_30c9c9336ef2caaf, var_30c9c9336ef2caaf + anglesToForward(var_831cc1b8f4225351) * 1800, 1, (0, 1, 1));
    flashtagorigin = self gettagorigin(endtag);
    flashtagangles = self gettagangles(endtag);
    thread drawsphere(flashtagorigin, 2, 1, (1, 1, 0));
    thread drawline(flashtagorigin, flashtagorigin + anglesToForward(flashtagangles) * 1800, 1, (1, 1, 0));
    sentry_burstfirestart(undefined, undefined, 1);
    wait 1;
  }
}

function function_c44bb0461339a1f1() {
  self cleartargetentity();
  self laseroff();
  thread sentry_burstfirestop();
  self.turrettarget.targeton = 0;
  self.owner notify("<dev string:x158>");
}

function function_e2a098b6c28a80cb(turret) {
  turret endon("<dev string:xe9>");
  turret endon("<dev string:xf5>");
  self endon("<dev string:x19a>");
  level endon("<dev string:xfd>");

  while(true) {
    if(istrue(self.targeton)) {
      sphere(self.origin, 20, (1, 1, 0), 0, 1);
    }

    waitframe();
  }
}

function function_2937914e0c4fb627(turret) {
  turret endon("<dev string:xe9>");
  turret endon("<dev string:xf5>");
  self endon("<dev string:x19a>");
  level endon("<dev string:xfd>");
  turret waittill("<dev string:x19a>");
  self delete();
}

function sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_target_lock_beep");
}

function sentry_spinup(configoverride) {
  thread sentry_targetlocksound();

  while(self.momentum < configoverride.spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function sentry_spindown() {
  self.momentum = 0;
}

function sentry_burstfirestart(configoverride, maxroundsoverride, var_7a4f7bd11952e7bc) {
  self endon("death");
  self endon("kill_turret");
  self endon("carried");
  self endon("stop_shooting");
  level endon("game_ended");
  turretconfig = undefined;

  if(isDefined(configoverride)) {
    turretconfig = configoverride;
  } else {
    turretconfig = level.sentrysettings[self.turrettype];
  }

  sentry_spinup(turretconfig);
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

    prefiretime = self prefireturret();

    if(prefiretime > 0) {
      wait prefiretime;
    }

    for(i = 0; i < numshots && !self.overheated; i++) {
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

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function turret_heatmonitor() {
  self.owner endon("<dev string:xd2>");

  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  overheattime = level.sentrysettings[self.turrettype].overheattime;

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
  self.owner endon("<dev string:xd2>");

  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");

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

function sentryturret_hack(newowner, oldowner) {
  if(isDefined(newowner)) {
    self notify("turret_hacked");
    self setturretowner(newowner);
    self setturretteam(newowner.team);
    self.owner = newowner;
    self.team = newowner.team;

    if(isDefined(oldowner)) {
      oldowner.placedsentries[self.turrettype] = array_remove(oldowner.placedsentries[self.turrettype], self);
    }

    if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[getsharedfunc("sound", "playKillstreakDeployDialog")]](newowner, self.streakinfo.streakname);
    }

    killstreak_dangernotifyplayersinrange(newowner, newowner.team, 2000, self.streakinfo.streakname);
    newowner function_5c49802fcf1a63ed(self);
    newowner thread sentryturret_watchpickup(self);
    namespace_37987c2865e1a627::clearminimapid();

    if(issharedfuncdefined("game", "createObjective")) {
      self.minimapid = self[[getsharedfunc("game", "createObjective")]]("hud_icon_minimap_killstreak_sentry", newowner.team, undefined, 1, 1);
    }

    if(level.teambased) {
      self filteroutplayermarks(newowner.team);
      return;
    }

    self filteroutplayermarks(newowner);
  }
}

function function_49197cd063a740ea(callbackfunction) {
  self.elevatordoorsclosecallback = callbackfunction;
}

function elevator_turretcallback() {
  self notify("kill_turret", 1, 0);
}