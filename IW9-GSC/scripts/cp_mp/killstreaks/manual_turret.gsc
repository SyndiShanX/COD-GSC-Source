/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\manual_turret.gsc
*******************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "init")]]();

  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("manual_turret", "on", 10);
}

weaponcleanupmanualturret(streakinfo, _id_41BF9BF4918115AC, weaponobj) {
  if(!istrue(_id_41BF9BF4918115AC))
    scripts\cp_mp\killstreaks\killstreakdeploy::getridofkillstreakdeployweapon(weaponobj);
}

tryusemanualturret(streakname) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, self);
  return tryusemanualturretfromstruct(streakinfo);
}

tryusemanualturretfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, makeweapon("deploy_manual_turret_mp"), 1, undefined, undefined, ::weaponcleanupmanualturret);

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  manualturret_toggleallowplacementactions(0);
  turret = manualturret_create("manual_turret", streakinfo);

  if(!isDefined(turret)) {
    manualturret_toggleallowplacementactions(1);
    return 0;
  }

  marker = manualturret_watchplacement(turret, streakinfo, 0, 1.25);

  if(!isDefined(marker)) {
    manualturret_toggleallowplacementactions(1);
    turret delete();
    return 0;
  }

  manualturret_toggleallowplacementactions(1);
  manualturret_setplaced(turret, marker);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "munitionUsed"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "munitionUsed")]]();

  return 1;
}

manualturret_watchplacement(turret, streakinfo, _id_6152D24062D26039, _id_290B1442271AB369) {
  thread manualturret_delayplacementinstructions(_id_290B1442271AB369);
  marker = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "watchForPlayerEnteringLastStand"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "watchForPlayerEnteringLastStand")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "getTargetMarker"))
    marker = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "getTargetMarker")]](streakinfo, _id_6152D24062D26039);

  self notify("turret_placement_finished");

  if(!isDefined(marker) || !isDefined(marker.location)) {
    if(istrue(self.inlaststand))
      scripts\cp_mp\utility\inventory_utility::_takeweapon("deploy_manual_turret_mp");
    else if(scripts\cp_mp\utility\player_utility::_isalive())
      manualturret_switchbacklastweapon("deploy_manual_turret_mp");

    return undefined;
  }

  turret thread manualturret_disablefire(self, 1, 1);

  if(self hasweapon("deploy_manual_turret_mp"))
    thread manualturret_switchbacklastweapon("deploy_manual_turret_mp", 1, 1);

  _id_85CDA42514DC11D2 = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_85CDA42514DC11D2);
  return marker;
}

manualturret_delayplacementinstructions(_id_74B5B12BB6514385) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);
  self setclientomnvar("ui_turret_placement", 1);
  thread manualturret_clearplacementinstructions("death");
  thread manualturret_clearplacementinstructions("turret_placement_finished");
}

manualturret_clearplacementinstructions(_id_C1948D1EEDABF26C) {
  self endon("cleared_placement");
  self endon("disconnect");
  level endon("game_ended");
  self waittill(_id_C1948D1EEDABF26C);
  self setclientomnvar("ui_turret_placement", 0);
  self notify("cleared_placement");
}

manualturret_create(turrettype, streakinfo) {
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
  turret.carriedby = self;
  turret manualturret_setturretmodel("placed");
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret hide();
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
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
  turret.colmodel.moverdoesnotkill = 1;
  turret.colmodel.turretparent = turret;
  return turret;
}

manualturret_setplaced(turret, marker) {
  config = level.sentrysettings[turret.turrettype];
  turret manualturret_setturretmodel("placed");

  if(!isDefined(self.placedsentries))
    self.placedsentries = [];

  if(!isDefined(self.placedsentries[turret.turrettype]))
    self.placedsentries[turret.turrettype] = [];

  if(istrue(turret.shouldsplash)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, turret.streakinfo.streakname);

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
  }

  if(isDefined(self.hideammoindex)) {
    for(_id_AF6FA51A19E513FC = self.hideammoindex; _id_AF6FA51A19E513FC >= 1; _id_AF6FA51A19E513FC--)
      turret setscriptablepartstate("hide_ammo_" + _id_AF6FA51A19E513FC, "on", 0);
  }

  _id_AA127492F0104D8C = "off";

  if(turret.reticlestate == "reticle_off")
    _id_AA127492F0104D8C = "on";

  turret setscriptablepartstate("hide_reticle", _id_AA127492F0104D8C, 0);
  turret.origin = marker.location;
  turret playSound("sentry_gun_plant");
  turret.colmodel show();
  turret.colmodel.angles = turret.angles;
  turret.colmodel.origin = turret.origin;
  turret.colmodel linkTo(turret, "tag_aim_pivot");
  _id_E005D4B70D6F2611 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]();

  if(!_id_E005D4B70D6F2611) {
    _id_F96E4256F03C5F42 = "icon_minimap_mobileturret";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
      turret.minimapid = turret.colmodel[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](_id_F96E4256F03C5F42, turret.team, undefined, 1, 1);
  }

  _id_11D7F05662DF0482 = self.placedsentries[turret.turrettype].size;
  self.placedsentries[turret.turrettype][_id_11D7F05662DF0482] = turret;

  if(_id_11D7F05662DF0482 + 1 > 1)
    self.placedsentries[turret.turrettype][0] notify("kill_turret", 0, 0);

  headiconoffset = 70;

  if(turret.model == level.sentrysettings[turret.turrettype].modelbasecover)
    headiconoffset = 35;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    turret[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](turret.turrettype, "Killstreak_Ground", self, 0, 1, headiconoffset, "carried_turret");

  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeon);
  _id_7613CDEEF31BE333 = getdvarint("dvar_475BDCF02A7C5C6E", 17);
  hintfov = getdvarint("dvar_1FAF82C0894746BC", 160);
  usefov = getdvarint("dvar_955590189ADC87C8", 120);
  _id_5E8EB3C31F9C265C = "j_trigger";

  if(!isDefined(turret.useownerobj)) {
    _id_963953C3478BF4FE = turret gettagorigin(_id_5E8EB3C31F9C265C);
    _id_EFE526BF6A23D275 = undefined;

    if(self _meth_C6CB3E654225077A())
      _id_EFE526BF6A23D275 = "hud_icon_killstreak_turret";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "createHintObject"))
      turret.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "createHintObject")]](_id_963953C3478BF4FE, "HINT_BUTTON", _id_EFE526BF6A23D275, config.ownerusehintstring, -1, "duration_none", undefined, _id_7613CDEEF31BE333, hintfov, _id_7613CDEEF31BE333, usefov);
  } else {
    _id_963953C3478BF4FE = turret gettagorigin(_id_5E8EB3C31F9C265C);
    turret.useownerobj _meth_DFB78B3E724AD620(1);
    turret.useownerobj dontinterpolate();
    turret.useownerobj.origin = _id_963953C3478BF4FE;
  }

  turret.useownerobj linkTo(turret, _id_5E8EB3C31F9C265C);

  if(!isDefined(turret.useotherobj)) {
    _id_963953C3478BF4FE = turret gettagorigin(_id_5E8EB3C31F9C265C);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "createHintObject"))
      turret.useotherobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "createHintObject")]](_id_963953C3478BF4FE, "HINT_BUTTON", undefined, config.otherusehintstring, -1, "duration_none", undefined, _id_7613CDEEF31BE333, hintfov, _id_7613CDEEF31BE333, usefov);
  } else {
    _id_963953C3478BF4FE = turret gettagorigin(_id_5E8EB3C31F9C265C);
    turret.useotherobj _meth_DFB78B3E724AD620(1);
    turret.useotherobj dontinterpolate();
    turret.useotherobj.origin = _id_963953C3478BF4FE;
  }

  turret.useotherobj linkTo(turret, _id_5E8EB3C31F9C265C);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "handleMovingPlatform"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "handleMovingPlatform")]](turret);

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

  if(isDefined(level.wztrain_info) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "handlemovingplatforms")) {
    data = spawnStruct();
    data.deathoverridecallback = ::_id_2A4EBBD9D0E941A2;
    turret thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "handlemovingplatforms")]](data);
  }
}

_id_2A4EBBD9D0E941A2(data) {
  _id_834C12B34EA6616F = scripts\cp_mp\utility\train_utility::_id_00D6B0A591AC99BD();

  if(!isDefined(_id_834C12B34EA6616F)) {
    return;
  }
  if(scripts\engine\utility::is_equal(data.lasttouchedplatform, _id_834C12B34EA6616F))
    self notify("kill_turret", 1);
  else {
    data = spawnStruct();
    data.deathoverridecallback = ::_id_2A4EBBD9D0E941A2;
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "handlemovingplatforms")]](data);
  }
}

manualturret_setcarried(owner) {
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
  _id_E478AC91AF0E92CB = self getlinkedchildren();

  foreach(child in _id_E478AC91AF0E92CB) {
    if(isDefined(child))
      child unlink();
  }

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);

    self.minimapid = undefined;
  }

  self.colmodel hide();
  owner manualturret_setinactive(self);
  self hide();
  self.carriedby = owner;
  self notify("carried_turret");
  self playSound("sentry_pickup");
  owner scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  owner scripts\cp_mp\utility\inventory_utility::_giveweapon("deploy_manual_turret_mp");
  owner scripts\cp_mp\utility\inventory_utility::_switchtoweapon("deploy_manual_turret_mp");
  owner manualturret_toggleallowplacementactions(0);
  marker = owner manualturret_watchplacement(self, self.streakinfo, 1, 2);

  if(!isDefined(marker)) {
    owner manualturret_toggleallowplacementactions(1);
    return 0;
  }

  owner manualturret_toggleallowplacementactions(1);
  owner manualturret_setplaced(self, marker);
}

manualturret_switchbacklastweapon(_id_8881166E57766E3A, _id_EAF9953FB1B05AC6, _id_829A6CB8A7DE0CAB) {
  if(isDefined(_id_829A6CB8A7DE0CAB) && _id_829A6CB8A7DE0CAB > 0) {
    self endon("death_or_disconnect");
    level endon("game_ended");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_829A6CB8A7DE0CAB);
  }

  lastweaponobj = scripts\cp_mp\utility\weapon_utility::restoreweaponstates(self.lastdroppableweaponobj);

  if(!isDefined(lastweaponobj) || !self hasweapon(lastweaponobj)) {
    if(isDefined(self.lastnormalweaponobj))
      lastweaponobj = self.lastnormalweaponobj;
    else
      lastweaponobj = makeweapon("iw9_fists_mp");
  }

  if(istrue(_id_EAF9953FB1B05AC6))
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(lastweaponobj);
  else
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(lastweaponobj);

  scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_8881166E57766E3A);
}

manualturret_setinactive(turret) {
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
  turret setturretminimapvisible(0);
  turret manualturret_makealltriggersusable(0);
  turret.useownerobj unlink();
  turret.useotherobj unlink();
}

manualturret_delaydeletemarker(owner, marker) {
  self endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(marker.visual))
    marker.visual delete();
}

manualturret_watchuse(owner, _id_C0A76805FFB5D8FC) {
  self endon("kill_turret");
  self endon("carried_turret");
  owner endon("disconnect");
  level endon("game_ended");

  foreach(player in level.players) {
    _id_C0A76805FFB5D8FC enableplayeruse(player);

    if(_id_C0A76805FFB5D8FC == self.useownerobj) {
      if(player == owner)
        continue;
    } else if(level.teambased && player.team == owner.team && player != owner) {
      continue;
    }
    _id_C0A76805FFB5D8FC disableplayeruse(player);
  }

  thread manualturret_disableplayeruseonconnect(owner, _id_C0A76805FFB5D8FC);

  for(;;) {
    _id_C0A76805FFB5D8FC waittill("trigger", player);

    if(istrue(self.inuse)) {
      continue;
    }
    if(istrue(self.stopinteract)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TURRET_DYING");

      continue;
    }

    if(player isonladder() || !player isonground() || player ismantling()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");

      continue;
    }

    if(istrue(player.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "allowPickupOfTurret")) {
      if(!player[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "allowPickupOfTurret")]]())
        continue;
    }

    self.inuse = 1;
    player manualturret_toggleallowuseactions(0);
    player disableturretdismount();

    if(player == owner) {
      for(_id_8B07FA3892A3A8A4 = 0; player useButtonPressed() && _id_8B07FA3892A3A8A4 < 0.25; _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds)
        waitframe();

      if(_id_8B07FA3892A3A8A4 >= 0.25) {
        player enableturretdismount();
        continue;
      }
    }

    player notify("start_turret_use");
    self.playerusingturret = player;
    manualturret_makealltriggersusable(0);
    player scripts\cp_mp\utility\weapon_utility::saveweaponstates();
    player.useweapon = level.sentrysettings[self.turrettype].playerweaponinfo;
    player scripts\cp_mp\utility\inventory_utility::_giveweapon(player.useweapon, undefined, undefined, 1);
    _id_B80592D1B570A193 = gettime();
    result = undefined;

    while(gettime() - _id_B80592D1B570A193 < 1000.0) {
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
        if(player scripts\cp_mp\utility\player_utility::_isalive()) {
          player manualturret_toggleallowuseactions(1);
          lastweaponobj = player scripts\cp_mp\utility\weapon_utility::restoreweaponstates(player.lastdroppableweaponobj);
          player switchtoweaponimmediate(lastweaponobj);
        }

        player clearhighpriorityweapon(player.useweapon);
        player scripts\cp_mp\utility\inventory_utility::_takeweapon(player.useweapon);
      }

      continue;
    }

    player.currentturret = self;
    player controlturreton(self);

    if(scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4())
      player _id_3B64EB40368C1450::set("nightmap_check", "nvg", 0);

    manualturret_applyoverlay(player);
    thread manualturret_disablefire(player, 0.5, 1);
    thread manualturret_watchammotracker(player);
    thread manualturret_endturretuseonexecution(player);
    thread manualturret_endturretuseonpush(player);
    thread manualturret_endturretusewatch(player);
    thread manualturret_endturretonplayer(player);
    thread manualturret_watchplayerangles(player);
  }
}

manualturret_domonitoredweaponswitch(_id_7F214A58689204E8, _id_D5E9925A20479492) {
  self endon("kill_turret");
  self endon("turret_switch_weapon_timeout");
  _id_7F214A58689204E8 endon("death_or_disconnect");
  level endon("game_ended");
  thread manualturret_watchturretusetimeout(1.0);
  result = _id_7F214A58689204E8 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_D5E9925A20479492, 1);
  self notify("turret_switch_weapon_ended");
  return result;
}

manualturret_watchturretusetimeout(timeout) {
  self endon("kill_turret");
  self endon("turret_switch_weapon_ended");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(timeout);
  self notify("turret_switch_weapon_timeout");
}

manualturret_watchdismantle(owner, dismantleobj) {
  self endon("kill_turret");
  self endon("carried_turret");
  owner endon("disconnect");
  level endon("game_ended");

  foreach(player in level.players) {
    dismantleobj enableplayeruse(player);

    if(level.teambased && player.team != owner.team)
      continue;
    else if(!level.teambased) {
      if(player != owner)
        continue;
    }

    dismantleobj disableplayeruse(player);
  }

  thread manualturret_disableplayerdismantleonconnect(owner);

  for(;;) {
    dismantleobj waittill("trigger", player);
    self notify("kill_turret", 0, 1);
    break;
  }
}

manualturret_applyoverlay(_id_EEE718E33217DC9E) {
  _id_EEE718E33217DC9E scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
  _id_EEE718E33217DC9E setclientomnvar("ui_mobile_turret_controls", 1);
  _id_EEE718E33217DC9E setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);
}

manualturret_removeoverlay(_id_EEE718E33217DC9E) {
  _id_EEE718E33217DC9E scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
  _id_EEE718E33217DC9E setclientomnvar("ui_mobile_turret_controls", 0);
}

manualturret_disablefire(_id_EEE718E33217DC9E, _id_C3C4590965030E9E, _id_FDB0C27120DDEF03) {
  if(istrue(_id_FDB0C27120DDEF03)) {
    _id_EEE718E33217DC9E endon("death_or_disconnect");
    level endon("game_ended");
  }

  if(isDefined(_id_EEE718E33217DC9E) && scripts\cp_mp\utility\player_utility::_isalive())
    _id_EEE718E33217DC9E freezecontrols(1);
  else
    return;

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_C3C4590965030E9E);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(_id_EEE718E33217DC9E) && scripts\cp_mp\utility\player_utility::_isalive())
    _id_EEE718E33217DC9E freezecontrols(0);
  else
    return;
}

manualturret_enableenemyoutlines(_id_EEE718E33217DC9E) {
  if(!isDefined(self.enemyoutlineinfos))
    self.enemyoutlineinfos = [];

  thread manualturret_enableenemyoutlinesonconnect(_id_EEE718E33217DC9E);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "getEnemyPlayers")) {
    foreach(enemy in [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "getEnemyPlayers")]](_id_EEE718E33217DC9E.team)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(enemy[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          if(!enemy scripts\cp_mp\utility\player_utility::_isalive())
            thread manualturret_enableenemyoutlineafterprotection(_id_EEE718E33217DC9E, enemy, 1);
          else if(isDefined(enemy.avoidkillstreakonspawntimer) && enemy.avoidkillstreakonspawntimer > 0)
            thread manualturret_enableenemyoutlineafterprotection(_id_EEE718E33217DC9E, enemy);

          continue;
        }
      }

      manualturret_addtooutlinelist(_id_EEE718E33217DC9E, enemy);
    }
  }
}

manualturret_enableenemyoutlinesonconnect(_id_EEE718E33217DC9E) {
  self endon("kill_turret");
  _id_EEE718E33217DC9E endon("end_turret_use");

  for(;;) {
    level waittill("connected", player);
    thread manualturret_enableenemyoutlineafterprotection(_id_EEE718E33217DC9E, player, 1);
  }
}

manualturret_removeoutlineondeath(_id_EEE718E33217DC9E, _id_990E778233DC8CF4, outlineid) {
  self endon("kill_turret");
  _id_EEE718E33217DC9E endon("end_turret_use");
  _id_990E778233DC8CF4 waittill("death_or_disconnect");
  manualturret_removefromoutlinelist(_id_990E778233DC8CF4, outlineid);

  if(isDefined(_id_990E778233DC8CF4))
    thread manualturret_restoreoutlineonspawn(_id_EEE718E33217DC9E, _id_990E778233DC8CF4);
}

manualturret_restoreoutlineonspawn(_id_EEE718E33217DC9E, _id_990E778233DC8CF4) {
  self endon("kill_turret");
  _id_EEE718E33217DC9E endon("end_turret_use");
  _id_990E778233DC8CF4 endon("disconnect");

  for(;;) {
    level waittill("player_spawned", player);

    if(player != _id_990E778233DC8CF4) {
      continue;
    }
    thread manualturret_enableenemyoutlineafterprotection(_id_EEE718E33217DC9E, player);
  }
}

manualturret_enableenemyoutlineafterprotection(_id_EEE718E33217DC9E, _id_990E778233DC8CF4, waitforspawn) {
  self endon("kill_turret");
  _id_EEE718E33217DC9E endon("end_turret_use");

  if(istrue(waitforspawn))
    _id_990E778233DC8CF4 waittill("spawned_player");

  if(isDefined(_id_990E778233DC8CF4.avoidkillstreakonspawntimer) && _id_990E778233DC8CF4.avoidkillstreakonspawntimer > 0)
    _id_990E778233DC8CF4 waittill("removed_spawn_perks");

  if(level.teambased && _id_990E778233DC8CF4.team == _id_EEE718E33217DC9E.team) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(_id_990E778233DC8CF4[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline"))
      return;
  }

  manualturret_addtooutlinelist(_id_EEE718E33217DC9E, _id_990E778233DC8CF4);
}

manualturret_addtooutlinelist(_id_C9A4579B227233F3, _id_E69B22A24070EC44) {
  _id_6E7692ABF5F96AD9 = spawnStruct();
  _id_6E7692ABF5F96AD9.ent = _id_E69B22A24070EC44;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForPlayer"))
    _id_6E7692ABF5F96AD9.entoutlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForPlayer")]](_id_E69B22A24070EC44, _id_C9A4579B227233F3, "outline_nodepth_orange", "level_script");

  self.enemyoutlineinfos[self.enemyoutlineinfos.size] = _id_6E7692ABF5F96AD9;
  thread manualturret_removeoutlineondeath(_id_C9A4579B227233F3, _id_E69B22A24070EC44, _id_6E7692ABF5F96AD9.entoutlineid);
  return _id_6E7692ABF5F96AD9;
}

manualturret_removefromoutlinelist(_id_9D90C26327E3EACD, outlineid) {
  if(!isDefined(self.enemyoutlineinfos)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](outlineid, _id_9D90C26327E3EACD);

  _id_4F484C103C832786 = [];

  foreach(_id_6E7692ABF5F96AD9 in self.enemyoutlineinfos) {
    if(_id_6E7692ABF5F96AD9.ent == _id_9D90C26327E3EACD) {
      continue;
    }
    _id_4F484C103C832786[_id_4F484C103C832786.size] = _id_6E7692ABF5F96AD9;
  }

  self.enemyoutlineinfos = _id_4F484C103C832786;
}

manualturret_disableenemyoutlines(_id_EEE718E33217DC9E) {
  if(!isDefined(self.enemyoutlineinfos)) {
    return;
  }
  foreach(_id_6E7692ABF5F96AD9 in self.enemyoutlineinfos) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](_id_6E7692ABF5F96AD9.entoutlineid, _id_6E7692ABF5F96AD9.ent);
  }

  self.enemyoutlineinfos = undefined;
}

manualturret_endplayeruse(turret) {
  if(isDefined(turret)) {
    turret.inuse = undefined;
    turret.playerusingturret = undefined;
    turret manualturret_makealltriggersusable(1);
  }

  if(isDefined(self)) {
    if(!self usinggamepad())
      self enableturretdismount();

    if(isDefined(turret)) {
      if(isDefined(self.currentturret) && self.currentturret != turret) {
        return;
      }
      self controlturretoff(turret);
      turret manualturret_removeoverlay(self);

      if(!istrue(turret.isshuttingdown))
        turret thread manualturret_watchpickup(turret.owner);
    }

    self.currentturret = undefined;
    manualturret_toggleallowuseactions(1);

    if(scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4())
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("nightmap_check");

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !istrue(self.inlaststand)) {
      lastweaponobj = scripts\cp_mp\utility\weapon_utility::restoreweaponstates(self.lastdroppableweaponobj);
      self switchtoweaponimmediate(lastweaponobj);
    }

    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.useweapon);
    thread manualturret_disablecrouchpronemantle();

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self setOrigin(turret.lastuserpos, 1);
      self setplayerangles(turret.lastuserangles);
    }

    self notify("end_turret_use");
  }
}

manualturret_disablecrouchpronemantle() {
  self endon("death_or_disconnect");
  _id_3B64EB40368C1450::set("manual_turret", "crouch", 0);
  _id_3B64EB40368C1450::set("manual_turret", "prone", 0);
  _id_3B64EB40368C1450::set("manual_turret", "mantle", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("manual_turret");
}

manualturret_disableplayeruseonconnect(owner, useobj) {
  if(isDefined(self)) {
    self endon("kill_turret");
    self endon("carried_turret");
  }

  owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    useobj disableplayeruse(player);
  }
}

manualturret_endturretuseonexecution(_id_EEE718E33217DC9E) {
  self endon("kill_turret");
  self endon("carried_turret");
  _id_EEE718E33217DC9E endon("end_turret_use");
  _id_EEE718E33217DC9E endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(_id_EEE718E33217DC9E isinexecutionvictim()) {
      _id_EEE718E33217DC9E manualturret_endplayeruse(self);
      break;
    }

    waitframe();
  }
}

manualturret_endturretuseonpush(_id_EEE718E33217DC9E) {
  self endon("kill_turret");
  self endon("carried_turret");
  _id_EEE718E33217DC9E endon("end_turret_use");
  _id_EEE718E33217DC9E endon("disconnect");
  level endon("game_ended");
  _id_71982E9B7E15C211 = 2500;

  if(isDefined(self.moving_platform))
    _id_71982E9B7E15C211 = 10000;

  for(;;) {
    if(distancesquared(self.origin, _id_EEE718E33217DC9E.origin) >= _id_71982E9B7E15C211) {
      _id_EEE718E33217DC9E manualturret_endplayeruse(self);
      break;
    }

    waitframe();
  }
}

manualturret_endturretusewatch(_id_EEE718E33217DC9E) {
  self endon("kill_turret");
  self endon("carried_turret");
  _id_EEE718E33217DC9E endon("end_turret_use");
  _id_EEE718E33217DC9E endon("disconnect");
  level endon("game_ended");

  while(_id_EEE718E33217DC9E useButtonPressed())
    waitframe();

  for(;;) {
    if(_id_EEE718E33217DC9E useButtonPressed()) {
      _id_EEE718E33217DC9E manualturret_endplayeruse(self);
      break;
    }

    waitframe();
  }
}

manualturret_endturretonplayer(_id_EEE718E33217DC9E) {
  _id_EEE718E33217DC9E endon("end_turret_use");
  level endon("game_ended");
  _id_EEE718E33217DC9E scripts\engine\utility::waittill_any_2("death_or_disconnect", "last_stand_start");
  _id_EEE718E33217DC9E manualturret_endplayeruse(self);
}

manualturret_watchplayerangles(_id_EEE718E33217DC9E) {
  self endon("kill_turret");
  _id_EEE718E33217DC9E endon("end_turret_use");
  _id_EEE718E33217DC9E endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self.lastuserpos = _id_EEE718E33217DC9E.origin;
    self.lastuserangles = _id_EEE718E33217DC9E getplayerangles();
    waitframe();
  }
}

manualturret_watchpickup(owner) {
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

    for(_id_8B07FA3892A3A8A4 = 0; owner useButtonPressed() && _id_8B07FA3892A3A8A4 < 0.25; _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds)
      waitframe();

    if(!isDefined(player)) {
      continue;
    }
    if(_id_8B07FA3892A3A8A4 < 0.25) {
      continue;
    }
    if(istrue(self.stopinteract)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TURRET_DYING");

      continue;
    }

    if(istrue(player.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "allowPickupOfTurret")) {
      if(!player[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "allowPickupOfTurret")]]())
        continue;
    }

    manualturret_makealltriggersusable(0);
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    owner.placedsentries[self.turrettype] = scripts\engine\utility::array_remove(owner.placedsentries[self.turrettype], self);
    thread manualturret_setcarried(owner);
  }
}

manualturret_watchdelayedpickup(owner) {
  self endon("kill_turret");
  owner endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  thread manualturret_watchpickup(owner);
}

manualturret_disableplayerpickuponconnect(turret) {
  turret endon("kill_turret");
  turret endon("carried_turret");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    turret.useownerobj disableplayeruse(player);
  }
}

manualturret_watchdamage(owner) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "monitorDamage"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "monitorDamage")]](self.maxhealth, "hitequip", ::manualturret_handledeathdamage, ::manualturret_modifydamage, 1);
}

manualturret_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level.sentrysettings[self.turrettype];
  _id_3737240CEFE2C793 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled"))
    _id_3737240CEFE2C793 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash);

  if(_id_3737240CEFE2C793)
    attacker notify("destroyed_equipment");

  _id_A93F9D30441FFED1 = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH")
    _id_A93F9D30441FFED1 = 1;

  self notify("kill_turret", _id_A93F9D30441FFED1, 1);
}

manualturret_modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage"))
    _id_702BFC08FABD86CB = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, type, _id_702BFC08FABD86CB, self.maxhealth, 1, 1, 2, 7, 5);

  return _id_702BFC08FABD86CB;
}

manualturret_disableplayerdismantleonconnect(owner) {
  self endon("kill_turret");
  self endon("carried_turret");
  owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    player waittill("spawned_player");

    if(level.teambased) {
      if(player.team != owner.team)
        continue;
    }

    self.dismantleobj disableplayeruse(player);
  }
}

manualturret_watchdeath(owner) {
  self endon("carried_turret");
  self waittill("kill_turret", _id_0B2797481A55C620, _id_4FAC8B8CE36E09F1);
  self.isshuttingdown = 1;

  if(isDefined(owner)) {
    owner.placedsentries[self.turrettype] = scripts\engine\utility::array_remove(owner.placedsentries[self.turrettype], self);
    owner manualturret_setinactive(self);
    manualturret_disableenemyoutlines(owner);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
      owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", owner);

    self.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);
    owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  if(isDefined(self.playerusingturret))
    self.playerusingturret manualturret_endplayeruse(self);

  if(isDefined(self.useownerobj))
    self.useownerobj delete();

  if(isDefined(self.useotherobj))
    self.useotherobj delete();

  if(!istrue(_id_0B2797481A55C620)) {
    self playSound("sentry_explode_smoke");
    self setscriptablepartstate("shutdown", "on");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    self setscriptablepartstate("explode", "regular");
  } else
    self setscriptablepartstate("explode", "violent");

  self playSound("mp_equip_destroyed");

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);

  if(isDefined(self.killcament))
    self.killcament delete();

  if(isDefined(self.colmodel))
    self.colmodel delete();

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);

    self.minimapid = undefined;
  }

  wait 0.2;
  self delete();
}

manualturret_watchdeathongameend() {
  self endon("kill_turret");
  self endon("carried_turret");
  level waittill("game_ended");
  self notify("kill_turret", 0, 0);
}

manualturret_delayscriptabledelete() {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

manualturret_watchtimeout(owner) {
  self endon("kill_turret");
  self endon("carried_turret");
  owner endon("disconnect");
  level endon("game_ended");
  _id_38E63990BD3D9ED4 = self.timeout;

  if(!isDefined(self.timeelapsed))
    self.timeelapsed = 0;

  while(self.timeelapsed < _id_38E63990BD3D9ED4) {
    _id_77B3F0514A25C019 = (_id_38E63990BD3D9ED4 - self.timeelapsed) / _id_38E63990BD3D9ED4;
    _id_77B3F0514A25C019 = int(ceil(clamp(_id_77B3F0514A25C019, 0, 1) * 100));

    if(isDefined(self.playerusingturret))
      self.playerusingturret setclientomnvar("ui_killstreak_countdown", int(_id_77B3F0514A25C019));

    self.timeelapsed = self.timeelapsed + level.framedurationseconds;

    if(self.timeelapsed >= _id_38E63990BD3D9ED4 - 1.5 && !istrue(self.stopinteract))
      self.stopinteract = 1;

    waitframe();
  }

  owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("manual_turret", "timeout_" + self.streakinfo.streakname, 1);
  self notify("kill_turret", 0, 0);
}

manualturret_watchammotracker(_id_EEE718E33217DC9E) {
  self endon("kill_turret");
  self endon("carried_turret");
  _id_EEE718E33217DC9E endon("end_turret_use");
  _id_EEE718E33217DC9E endon("disconnect");
  level endon("game_ended");
  config = level.sentrysettings[self.turrettype];
  _id_83FB464C27E79A0E = weaponfiretime(config.weaponinfo);

  if(!isDefined(self.hideammoindex))
    self.hideammoindex = 1;

  while(_id_EEE718E33217DC9E isusingturret()) {
    while(_id_EEE718E33217DC9E attackButtonPressed()) {
      self.streakinfo.shots_fired++;
      self.ammocount--;
      _id_EEE718E33217DC9E setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);

      if(self.ammocount <= 12) {
        self setscriptablepartstate("hide_ammo_" + self.hideammoindex, "on", 0);
        self.hideammoindex++;
      }

      if(self.ammocount == 100)
        _id_EEE718E33217DC9E scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("manual_turret", self.streakinfo.streakname + "_low_ammo");
      else if(self.ammocount <= 0) {
        _id_EEE718E33217DC9E scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("manual_turret", self.streakinfo.streakname + "_no_ammo");
        self notify("kill_turret", 0, 0);
        break;
      }

      wait(_id_83FB464C27E79A0E);
    }

    waitframe();
  }
}

manualturret_watchdisown(owner) {
  self endon("kill_turret");
  self endon("carried_turret");
  owner thread manualturret_disownonaction(self, "disconnect");
  owner thread manualturret_disownonaction(self, "joined_team");
  owner thread manualturret_disownonaction(self, "joined_spectators");
}

manualturret_disownonaction(turret, action) {
  turret endon("kill_turret");
  self endon("carried_turret");
  self endon("disowned_turret");
  level endon("game_ended");
  self waittill(action);
  turret notify("kill_turret", 0, 0);
  self notify("disowned_turret");
}

manualturret_setturretmodel(type) {
  turretmodel = undefined;

  if(type == "placed")
    turretmodel = level.sentrysettings[self.turrettype].modelbaseground;
  else
    turretmodel = level.sentrysettings[self.turrettype].modeldestroyedground;

  self setModel(turretmodel);
}

manualturret_makealltriggersusable(_id_E3108E412AFB3811) {
  if(!istrue(_id_E3108E412AFB3811)) {
    self.useownerobj _meth_DFB78B3E724AD620(0);
    self.useotherobj _meth_DFB78B3E724AD620(0);
  } else {
    self.useownerobj _meth_DFB78B3E724AD620(1);
    self.useotherobj _meth_DFB78B3E724AD620(1);
  }
}

manualturret_toggleallowplacementactions(_id_E3108E412AFB3811) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    if(!_id_E3108E412AFB3811) {
      _id_3B64EB40368C1450::set("manual_turret_placement", "sprint", 0);
      _id_3B64EB40368C1450::set("manual_turret_placement", "weapon_switch", 0);
      _id_3B64EB40368C1450::set("manual_turret_placement", "offhand_weapons", 0);
      _id_3B64EB40368C1450::set("manual_turret_placement", "melee", 0);
      _id_3B64EB40368C1450::set("manual_turret_placement", "execution_attack", 0);
      _id_3B64EB40368C1450::set("manual_turret_placement", "ladder_placement", 0);
    } else
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("manual_turret_placement");
  }
}

manualturret_toggleallowuseactions(_id_E3108E412AFB3811) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    if(!_id_E3108E412AFB3811) {
      _id_3B64EB40368C1450::set("manual_turret_use", "offhand_weapons", 0);
      _id_3B64EB40368C1450::set("manual_turret_use", "melee", 0);
      _id_3B64EB40368C1450::set("manual_turret_use", "supers", 0);
      _id_3B64EB40368C1450::set("manual_turret_use", "allow_movement", 0);
    } else
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("manual_turret_use");
  }
}