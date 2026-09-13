/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\sentry_gun.gsc
****************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "init")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "initSentrySettings"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "initSentrySettings")]]();
}

weaponcleanupsentryturret(streakinfo, _id_41BF9BF4918115AC, weaponobj) {
  if(!istrue(_id_41BF9BF4918115AC))
    scripts\cp_mp\killstreaks\killstreakdeploy::getridofkillstreakdeployweapon(weaponobj);
}

tryusesentryturret(streakname) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, self);
  return tryusesentryturretfromstruct(streakinfo);
}

tryusesentryturretfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      self.bgivensentry = 0;
      return 0;
    }
  }

  scripts\cp_mp\utility\weapon_utility::saveweaponstates();

  if(!istrue(_id_8FBBC6A868621DD5()))
    return 0;

  _id_41BF9BF4918115AC = _id_6633C7714FC94777(streakinfo);

  if(!istrue(_id_41BF9BF4918115AC))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      self.bgivensentry = 0;
      return 0;
    }
  }

  turret = sentryturret_create("sentry_turret", streakinfo);

  if(!isDefined(turret)) {
    self.bgivensentry = 0;
    return 0;
  }

  marker = sentryturret_watchplacement(turret, streakinfo, 0, 1.25);

  if(!isDefined(marker)) {
    turret delete();
    self.bgivensentry = 0;
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("killstreak", "refundKillstreak", "sentry", 1, 1, 0, 1);
    return 0;
  }

  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(::sentryturret_empstarted);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(::sentryturret_empcleared);
  sentryturret_setplaced(turret, marker);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "munitionUsed"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "munitionUsed")]]();

  return 1;
}

sentryturret_watchplacement(turret, streakinfo, _id_6152D24062D26039, _id_290B1442271AB369) {
  self.bgivensentry = 1;
  turret laseroff();
  thread sentryturret_delayplacementinstructions(_id_290B1442271AB369);
  _id_498A2226E5AA47EE = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType"))
    _id_498A2226E5AA47EE = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";

  if(_id_498A2226E5AA47EE)
    thread _id_5C005D2B1101BC78();

  marker = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "watchForPlayerEnteringLastStand"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "watchForPlayerEnteringLastStand")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "getTargetMarker"))
    marker = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "getTargetMarker")]](streakinfo, _id_6152D24062D26039);

  self notify("turret_placement_finished");
  self playSound("sentry_gun_plant_foley");
  _id_3B64EB40368C1450::set("sentry", "armor", 1);

  if(!isDefined(marker) || !isDefined(marker.location)) {
    if(scripts\cp_mp\utility\player_utility::_isalive())
      scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("deploy_sentry_mp");

    return undefined;
  }

  turret thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(self, 1, 1);

  if(self hasweapon("deploy_sentry_mp"))
    thread scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("deploy_sentry_mp", 1, 1);

  _id_85CDA42514DC11D2 = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_85CDA42514DC11D2);
  return marker;
}

_id_5C005D2B1101BC78() {
  self endon("turret_placement_finished");
  self endon("death_or_disconnect");
  self waittill("last_stand_start");
  _id_3B64EB40368C1450::set("sentry", "armor", 1);
  self notify("equip_deploy_cancel");
}

sentryturret_delayplacementinstructions(_id_74B5B12BB6514385) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);
  self setclientomnvar("ui_turret_placement", 2);
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("death");
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("turret_placement_finished");
}

sentryturret_create(turrettype, streakinfo) {
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

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "attachXRays"))
    turret = [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "attachXRays")]](turret);

  if(!isDefined(turret.timeout))
    turret.timeout = 120;

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
    case "sentry_turret":
    default:
      turret maketurretinoperable();
      turret setleftarc(80);
      turret setrightarc(80);
      turret setbottomarc(50);
      turret settoparc(60);
      turret setconvergencetime(0.6, "pitch");
      turret setconvergencetime(0.6, "yaw");
      turret setconvergenceheightpercent(0.65);
      turret setdefaultdroppitch(-89.0);
      break;
  }

  turret setturretmodechangewait(1);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  turret _id_49197CD063A740EA(::_id_3267046817E6A131);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(turret);
  }

  _id_0D3DC97C59992D51 = anglesToForward(turret.angles);
  _id_A8AE5E047A5B6CB6 = turret gettagorigin("tag_laser") + (0, 0, 10);
  _id_A8AE5E047A5B6CB6 = _id_A8AE5E047A5B6CB6 - _id_0D3DC97C59992D51 * 20;
  killcament = spawn("script_model", _id_A8AE5E047A5B6CB6);
  killcament linkTo(turret);
  turret.killcament = killcament;
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel hide();
  return turret;
}

sentryturret_setplaced(turret, marker) {
  config = level.sentrysettings[turret.turrettype];
  turret sentryturret_setturretmodel("placed");

  if(!isDefined(self.placedsentries))
    self.placedsentries = [];

  if(!isDefined(self.placedsentries[turret.turrettype]))
    self.placedsentries[turret.turrettype] = [];

  if(istrue(turret.shouldsplash)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, turret.streakinfo.streakname);

    scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(self, self.team, 2000, turret.streakinfo.streakname);
    splashname = config.teamsplash;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](splashname, self);

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

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("turret", "movingPlatformOnPlaced"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("turret", "movingPlatformOnPlaced")]](turret, marker);
  }

  self.bgivensentry = 0;
  turret.origin = marker.location;
  turret playSound("sentry_gun_plant");
  turret setscriptablepartstate("lights", "daytime", 0);
  turret.colmodel show();
  turret.colmodel.angles = turret.angles;
  turret.colmodel.origin = turret.origin;
  turret.colmodel linkTo(turret);
  _id_F96E4256F03C5F42 = "hud_icon_minimap_killstreak_sentry";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    turret.minimapid = turret.colmodel[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](_id_F96E4256F03C5F42, turret.team, undefined, 1, 1);

  _id_11D7F05662DF0482 = self.placedsentries[turret.turrettype].size;
  self.placedsentries[turret.turrettype][_id_11D7F05662DF0482] = turret;

  if(_id_11D7F05662DF0482 + 1 > 2)
    self.placedsentries[turret.turrettype][0] notify("kill_turret", 0, 0);

  headiconoffset = 70;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    turret[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](turret.turrettype, "Killstreak_Ground", self, 0, 1, headiconoffset, "carried");

  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeon);
  _id_5E8EB3C31F9C265C = "tag_aim_pivot";

  if(!isDefined(turret.useownerobj)) {
    _id_963953C3478BF4FE = turret gettagorigin(_id_5E8EB3C31F9C265C);
    _id_EFE526BF6A23D275 = undefined;
    _id_7D52B05C966F0D1C = undefined;
    hintdist = undefined;
    usedist = undefined;

    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
      _id_EFE526BF6A23D275 = "hud_icon_killstreak_sentry";
      _id_7D52B05C966F0D1C = "duration_none";
      hintdist = 50;
      usedist = 50;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "createHintObject"))
      turret.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "createHintObject")]](_id_963953C3478BF4FE, "HINT_BUTTON", _id_EFE526BF6A23D275, config.ownerusehintstring, undefined, _id_7D52B05C966F0D1C, "show", hintdist, undefined, usedist, undefined);
  } else {
    _id_963953C3478BF4FE = turret gettagorigin(_id_5E8EB3C31F9C265C);
    turret.useownerobj _meth_DFB78B3E724AD620(1);
    turret.useownerobj dontinterpolate();
    turret.useownerobj.origin = _id_963953C3478BF4FE;
  }

  turret.useownerobj linkTo(turret, _id_5E8EB3C31F9C265C);

  foreach(guy in level.players) {
    if(guy != turret.owner)
      turret.useownerobj disableplayeruse(guy);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "handleMovingPlatform"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "handleMovingPlatform")]](turret);

  turret scripts\cp_mp\emp_debuff::allow_emp(1);
  turret scripts\mp\sentientpoolmanager::registersentient("Killstreak_Static", self);
  turret sentryturret_empupdate();
  turret thread sentry_attacktargets();
  thread sentryturret_delaydeletemarker(turret, marker);
  thread sentryturret_watchpickup(turret);
  thread sentryturret_watchdamage(turret);
  thread sentryturret_watchdeath(turret);
  thread sentryturret_watchtimeout(turret);
  thread sentryturret_watchdisown(turret);
  thread sentryturret_watchgameend(turret);
  turret notify("turret_place_successful");
}

sentryturret_setcarried(turret) {
  turret endon("kill_turret");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
    self notify("switched_from_minigun");

    while(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp")
      waitframe();
  }

  if(isDefined(turret.moving_platform)) {
    turret.moving_platform = undefined;
    turret.moving_platform_offset = undefined;
    turret.moving_platform_angles_offset = undefined;
    turret unlink();
  }

  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  turret scripts\mp\sentientpoolmanager::unregistersentient(turret.sentientpool, turret.sentientpoolindex);
  _id_E478AC91AF0E92CB = turret getlinkedchildren();

  foreach(child in _id_E478AC91AF0E92CB) {
    if(isDefined(child))
      child unlink();
  }

  if(isDefined(turret.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](turret.minimapid);

    turret.minimapid = undefined;
  }

  turret.colmodel unlink();
  turret.colmodel hide();
  sentryturret_setinactive(turret);
  turret hide();
  turret.carriedby = self;
  turret notify("carried");
  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  _id_41BF9BF4918115AC = _id_6633C7714FC94777(turret.streakinfo, turret);

  if(!istrue(_id_41BF9BF4918115AC)) {
    return;
  }
  marker = sentryturret_watchplacement(turret, turret.streakinfo, 1, 2);

  if(!isDefined(marker)) {
    return;
  }
  sentryturret_setplaced(turret, marker);
}

sentryturret_switchbacklastweapon(_id_EAF9953FB1B05AC6) {
  if(istrue(_id_EAF9953FB1B05AC6))
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(self.lastdroppableweaponobj);
  else
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);

  scripts\cp_mp\utility\inventory_utility::_takeweapon("deploy_sentry_mp");
}

sentryturret_setinactive(turret) {
  turret setdefaultdroppitch(30);
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
  turret.useownerobj _meth_DFB78B3E724AD620(0);
  turret.useownerobj unlink();
}

sentryturret_delaydeletemarker(turret, marker) {
  turret endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(marker.visual))
    marker.visual delete();
}

sentryturret_disableplayeruseonconnect(turret, useobj) {
  if(isDefined(turret)) {
    turret endon("kill_turret");
    turret endon("carried");
  }

  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    useobj disableplayeruse(player);
  }
}

sentryturret_watchpickup(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    turret.useownerobj waittill("trigger", player);

    if(player != self) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "allowPickupOfTurret")) {
      if(!player[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "allowPickupOfTurret")]]())
        continue;
    }

    if(!istrue(_id_8FBBC6A868621DD5(turret))) {
      continue;
    }
    turret.useownerobj _meth_DFB78B3E724AD620(0);
    turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
    self.placedsentries[turret.turrettype] = scripts\engine\utility::array_remove(self.placedsentries[turret.turrettype], turret);
    thread sentryturret_setcarried(turret);
  }
}

sentryturret_disableplayerpickuponconnect(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    player waittill("spawned_player");
    turret.useownerobj disableplayeruse(player);
  }
}

sentryturret_watchdismantle(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  foreach(player in level.players) {
    if(level.teambased) {
      if(player.team != self.team)
        continue;
    } else if(player != self)
      continue;
  }

  thread sentryturret_disableplayerdismantleonconnect(turret);

  for(;;) {
    turret.dismantleobj waittill("trigger", player);
    turret notify("kill_turret", 0, 1);
    break;
  }
}

sentryturret_watchdamage(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "monitorDamage"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "monitorDamage")]](turret);
}

sentryturret_disableplayerdismantleonconnect(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    player waittill("spawned_player");

    if(level.teambased) {
      if(player.team != self.team)
        continue;
    }
  }
}

sentryturret_empstarted(data) {
  if(isDefined(data.attacker)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      data.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("disabled_sentry_gun");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "empStarted"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "empStarted")]]();
  }

  sentryturret_empupdate();
}

sentryturret_empcleared(_id_B3990D56E2779F79) {
  if(_id_B3990D56E2779F79) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "empStarted"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "empCleared")]]();

  sentryturret_empupdate();
}

sentryturret_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    self laseroff();
  } else {
    self turretfireenable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
  }
}

sentryturret_watchdeath(turret) {
  turret endon("carried");
  turret waittill("kill_turret", _id_0B2797481A55C620, _id_4FAC8B8CE36E09F1);

  if(isDefined(self)) {
    self.placedsentries[turret.turrettype] = scripts\engine\utility::array_remove(self.placedsentries[turret.turrettype], turret);
    sentryturret_setinactive(turret);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", self);

    turret.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);
    scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(turret.streakinfo);
  }

  if(istrue(_id_4FAC8B8CE36E09F1))
    scripts\cp_mp\utility\killstreak_utility::_id_08959C1606F65E65(turret.streakinfo.streakname, turret.streakinfo.streakname + "_teamleader_destroyed");

  turret sentryturret_setturretmodel("destroyed");
  turret setturretowner(undefined);

  if(!istrue(_id_0B2797481A55C620)) {
    turret playSound("sentry_explode_smoke");
    turret setscriptablepartstate("shutdown", "on");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    turret setscriptablepartstate("explode", "regular");
  } else
    turret setscriptablepartstate("explode", "violent");

  turret playSound("mp_equip_destroyed");

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](turret.streakinfo);

  if(isDefined(turret.killcament))
    turret.killcament delete();

  if(isDefined(turret.useownerobj))
    turret.useownerobj delete();

  if(isDefined(turret.useotherobj))
    turret.useotherobj delete();

  if(isDefined(turret.colmodel))
    turret.colmodel delete();

  if(isDefined(turret.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](turret.minimapid);

    turret.minimapid = undefined;
  }

  wait 0.2;
  turret delete();
}

sentryturret_delayscriptabledelete() {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

sentryturret_watchtimeout(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(turret.timeout > 0) {
    turret.timeout = turret.timeout - 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  scripts\cp_mp\utility\killstreak_utility::_id_08959C1606F65E65(turret.streakinfo.streakname, turret.streakinfo.streakname + "_teamleader_timeout");
  turret notify("kill_turret", 0, 0);
}

sentryturret_watchdisown(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  turret notify("kill_turret", 0, 0);
}

sentryturret_watchgameend(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  level waittill("game_ended");
  turret notify("kill_turret", 0, 0);
}

sentryturret_setturretmodel(type) {
  turretmodel = undefined;

  if(type == "placed")
    turretmodel = level.sentrysettings[self.turrettype].modelbaseground;
  else
    turretmodel = level.sentrysettings[self.turrettype].modeldestroyedground;

  self setModel(turretmodel);
}

_id_6633C7714FC94777(streakinfo, _id_3389369DF8BF82D2) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_374D7614ECBD032A = "sentry_placement_failed";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "watchForPlacementFireState"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "watchForPlacementFireState")]](streakinfo, _id_374D7614ECBD032A);

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, makeweapon("deploy_sentry_mp"), 1, undefined, undefined, ::weaponcleanupsentryturret);

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    self notify(_id_374D7614ECBD032A);
    self.bgivensentry = 0;
    return 0;
  }

  self playSound("sentry_pickup");
  _id_3B64EB40368C1450::set("sentry", "armor", 0);
  return 1;
}

_id_8FBBC6A868621DD5(_id_3389369DF8BF82D2) {
  _id_0E85BB71774631A2 = self getstance();

  if(_id_0E85BB71774631A2 == "stand" || _id_0E85BB71774631A2 == "crouch")
    return 1;

  _id_1C0AE1D2606CB0CC = self _meth_29C14C6E321B9789("crouch");

  if(istrue(_id_1C0AE1D2606CB0CC)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");

    return 0;
  }

  return 1;
}

sentry_attacktargets(_id_630AF5192659DD3B) {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  self.momentum = 0;

  for(;;) {
    self waittill("turretstatechange");

    if(self isfiringturret()) {
      self laseron();
      thread sentry_burstfirestart(_id_630AF5192659DD3B);
      continue;
    }

    self laseroff();
    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_target_lock_beep");
}

sentry_spinup(_id_630AF5192659DD3B) {
  thread sentry_targetlocksound();

  while(self.momentum < _id_630AF5192659DD3B.spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

sentry_spindown() {
  self.momentum = 0;
}

sentry_burstfirestart(_id_630AF5192659DD3B, _id_EBED6E83EB956D18, _id_7A4F7BD11952E7BC) {
  self endon("death");
  self endon("kill_turret");
  self endon("carried");
  self endon("stop_shooting");
  level endon("game_ended");
  _id_50651DF7C1EF6241 = undefined;

  if(isDefined(_id_630AF5192659DD3B))
    _id_50651DF7C1EF6241 = _id_630AF5192659DD3B;
  else
    _id_50651DF7C1EF6241 = level.sentrysettings[self.turrettype];

  sentry_spinup(_id_50651DF7C1EF6241);
  firetime = weaponfiretime(_id_50651DF7C1EF6241.weaponinfo);
  _id_3746EC1BEFD86AE8 = _id_50651DF7C1EF6241.burstmin;
  _id_3E92CD336A99CE02 = _id_50651DF7C1EF6241.burstmax;
  _id_5F622C39D6661B23 = _id_50651DF7C1EF6241.pausemin;
  _id_42AE243CD994C3BD = _id_50651DF7C1EF6241.pausemax;
  lockstrength = _id_50651DF7C1EF6241.lockstrength;

  for(;;) {
    _id_89F949A75D92E1A4 = randomintrange(_id_3746EC1BEFD86AE8, _id_3E92CD336A99CE02 + 1);

    if(isDefined(_id_EBED6E83EB956D18))
      _id_89F949A75D92E1A4 = _id_EBED6E83EB956D18;

    _id_7BFD8851DD6393EF = self _meth_BFE38F2FB8999E70();

    if(_id_7BFD8851DD6393EF > 0)
      wait(_id_7BFD8851DD6393EF);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_89F949A75D92E1A4 && !self.overheated; _id_AC0E594AC96AA3A8++) {
      self shootturret("tag_flash", lockstrength);
      self.streakinfo.shots_fired++;
      wait(firetime);
    }

    if(istrue(_id_7A4F7BD11952E7BC)) {
      break;
    }

    wait(randomfloatrange(_id_5F622C39D6661B23, _id_42AE243CD994C3BD));
  }
}

sentry_burstfirestop() {
  self notify("stop_shooting");
}

turret_heatmonitor() {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  overheattime = level.sentrysettings[self.turrettype].overheattime;

  for(;;) {
    if(self.heatlevel > overheattime) {
      self.overheated = 1;

      while(self.heatlevel)
        wait 0.1;

      self.overheated = 0;
      self notify("not_overheated");
    }

    wait 0.05;
  }
}

playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait(level.sentrysettings[self.turrettype].fxtime);
  }
}

turret_coolmonitor() {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");

  for(;;) {
    if(self.heatlevel > 0) {
      if(self.cooldownwaittime <= 0)
        self.heatlevel = max(0, self.heatlevel - 0.05);
      else
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
    }

    wait 0.05;
  }
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}

_id_3267046817E6A131() {
  self notify("kill_turret", 1, 0);
}