/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\chopper_support.gsc
*********************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_support", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_support", "init")]]();

  level.choppersupports = [];
  init_chopper_support_vo();
  level.incomingallchoppersupports = 0;
  level.incomingchoppersupports["allies"] = 0;
  level.incomingchoppersupports["axis"] = 0;
}

init_chopper_support_vo() {
  game["dialog"]["chopper_support_light_damage"] = "chopper_support_health_high";
  game["dialog"]["chopper_support_med_damage"] = "chopper_support_health_med";
  game["dialog"]["chopper_support_heavy_damage"] = "chopper_support_health_low";
  game["dialog"]["chopper_support_engage_target"] = "chopper_support_engage";
  game["dialog"]["chopper_support_patrol"] = "chopper_support_patrol";
  game["dialog"]["chopper_support_flares"] = "chopper_support_flares";
  game["dialog"]["chopper_support_crash"] = "chopper_support_crash";
}

tryusechoppersupport(streakname) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, self);
  return tryusechoppersupportfromstruct(streakinfo);
}

tryusechoppersupportfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
    return 0;

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_generic_mp"));

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  level.incomingallchoppersupports++;
  _id_09C8D568F8760E50 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    _id_09C8D568F8760E50 = 2;

  if(level.choppersupports.size >= _id_09C8D568F8760E50 || level.choppersupports.size + level.incomingallchoppersupports > _id_09C8D568F8760E50) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

    level.incomingallchoppersupports--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    _id_ABDB6AF6E3CA3893 = 1;
    level.incomingchoppersupports[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.choppersupports) + level.incomingchoppersupports[self.team] > _id_ABDB6AF6E3CA3893) {
      level.incomingallchoppersupports--;
      level.incomingchoppersupports[self.team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_SUPPORT_HELO");

      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  _id_79710492B71B9E81 = usechoppersupport(self, streakinfo);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("chopper_support", self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_chopper_support", self);

  return _id_79710492B71B9E81;
}

usechoppersupport(player, streakinfo) {
  chopper = spawnchopper(player, streakinfo);
  level.incomingallchoppersupports--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased)
    level.incomingchoppersupports[player.team]--;

  if(!isDefined(chopper))
    return 0;

  chopper thread startchopper(player, streakinfo);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](streakinfo);

  return 1;
}

spawnchopper(owner, streakinfo) {
  heightoffset = (0, 0, 1750);
  pathstart = owner.origin - anglesToForward(owner.angles) * 15000 + heightoffset;
  pathgoal = owner.origin + anglesToForward(owner.angles) * 2000 + heightoffset;
  angles = owner.angles;
  _id_EBBE5C4D79905B3D = getdvarint("dvar_D992CE3D83291D98", 45);
  goalstruct = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    _id_8013278937FF2600 = randomint(level.heli_structs_entrances.size);
    _id_B2F2CBEB5539EFA6 = level.heli_structs_entrances[_id_8013278937FF2600];
    goalstruct = choppersupport_findtargetStruct(_id_B2F2CBEB5539EFA6.script_linkto, level.heli_structs_goals);

    if(isDefined(goalstruct)) {
      _id_A168DB747B0D79AC = _id_B2F2CBEB5539EFA6.origin * (1, 1, 0) + heightoffset;
      _id_C32E33B4D51BE12F = goalstruct.origin * (1, 1, 0) + heightoffset;
      _id_8577D255D1A9BD14 = vectorNormalize(_id_C32E33B4D51BE12F - _id_A168DB747B0D79AC);
      pathstart = _id_C32E33B4D51BE12F - _id_8577D255D1A9BD14 * 15000;
      pathgoal = _id_C32E33B4D51BE12F;
      angles = vectortoangles(_id_8577D255D1A9BD14);
    } else {}
  } else {}

  _id_D8AF13D53A9C00A0 = "veh8_mil_air_palfa";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(owner))
    _id_D8AF13D53A9C00A0 = "veh8_mil_air_palfa_east";

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  chopper = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, pathstart, angles, "veh_chopper_support_mp", _id_D8AF13D53A9C00A0);

  if(!isDefined(chopper))
    return undefined;

  chopper.speed = 100;
  chopper.accel = 50;
  chopper.lifetime = _id_EBBE5C4D79905B3D;
  chopper.team = owner.team;
  chopper.owner = owner;
  chopper.angles = angles;
  chopper.streakinfo = streakinfo;
  chopper.streakname = streakinfo.streakname;
  chopper.flaresreservecount = 1;
  chopper.pathstart = pathstart;
  chopper.pathgoal = pathgoal;
  chopper.currentaction = "patrol";
  chopper.currenttarget = undefined;
  chopper.currentpatrolstruct = goalstruct;
  chopper.heightoffset = heightoffset;
  chopper.crashoffset = heightoffset[2] - 750;
  chopper.stage1accradius = 50;
  chopper.stage2accradius = 25;
  chopper.stage3accradius = undefined;
  chopper.minshotstostage2acc = 7;
  chopper.minshotstostage3acc = 12;
  chopper setvehicleteam(chopper.team);
  chopper.health = 3500;
  chopper.maxhealth = 3500;
  chopper.currenthealth = 3500;
  chopper scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);
  chopper _id_F60FC20E14BD9B6F(streakinfo.streakname);
  level.choppersupports[level.choppersupports.size] = chopper;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    chopper[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);

  chopper setmaxpitchroll(15, 15);
  chopper vehicle_setspeed(chopper.speed, chopper.accel);
  chopper sethoverparams(50, 5, 2.5);
  chopper setturningability(0.5);
  chopper setyawspeed(100, 25, 25, 0.1);
  chopper setotherent(owner);
  chopper setCanDamage(1);
  chopper setneargoalnotifydist(768);
  chopper setscriptablepartstate("blinking_lights", "on", 0);
  chopper setscriptablepartstate("engine", "on", 0);
  _id_9EBE5C9DAEC0C8C2 = "veh9_mil_air_heli_ahotel64_turret";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(owner))
    _id_9EBE5C9DAEC0C8C2 = "veh9_mil_air_heli_ahotel64_turret";

  chopper.frontturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  chopper.frontturret setModel(_id_9EBE5C9DAEC0C8C2);
  chopper.frontturret.owner = owner;
  chopper.frontturret.team = owner.team;
  chopper.frontturret.angles = chopper.angles;
  chopper.frontturret.streakinfo = streakinfo;
  chopper.frontturret.turreton = 1;
  chopper.frontturret.name = "front_turret";
  chopper.frontturret.attackingtarget = undefined;
  chopper.frontturret linkTo(chopper);
  chopper.frontturret setturretteam(owner.team);
  chopper.frontturret setturretmodechangewait(0);
  chopper.frontturret setmode("manual");
  chopper.frontturret setotherent(owner);
  chopper.frontturret setdefaultdroppitch(45);
  chopper.frontturret.groundtargetent = spawn("script_model", self.origin);
  chopper.frontturret.groundtargetent setModel("tag_origin");
  chopper.frontturret.groundtargetent dontinterpolate();
  chopper.rearturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  chopper.rearturret setModel(_id_9EBE5C9DAEC0C8C2);
  chopper.rearturret.owner = owner;
  chopper.rearturret.team = owner.team;
  chopper.rearturret.angles = chopper.angles;
  chopper.rearturret.streakinfo = streakinfo;
  chopper.rearturret.turreton = 1;
  chopper.rearturret.name = "rear_turret";
  chopper.rearturret.attackingtarget = undefined;
  chopper.rearturret linkTo(chopper);
  chopper.rearturret setturretteam(owner.team);
  chopper.rearturret setturretmodechangewait(0);
  chopper.rearturret setmode("manual");
  chopper.rearturret setotherent(owner);
  chopper.rearturret setdefaultdroppitch(45);
  chopper.rearturret.groundtargetent = spawn("script_model", self.origin);
  chopper.rearturret.groundtargetent setModel("tag_origin");
  chopper.rearturret.groundtargetent dontinterpolate();
  chopper.killcament = spawn("script_model", chopper gettagorigin("tag_ground"));
  chopper.killcament linkTo(chopper, "tag_ground", (-600, 0, 1000), (0, 0, 0));
  chopper.frontturret.killcament = chopper.killcament;
  chopper.rearturret.killcament = chopper.killcament;
  level notify("matchrecording_chopper", chopper);
  return chopper;
}

startchopper(player, streakinfo) {
  self endon("death");
  self setvehgoalpos(self.pathgoal, 1);
  _id_52A5BE2E2F91D710 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](player, streakinfo.streakname);
    _id_52A5BE2E2F91D710 = 2.0;
  }

  player thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(streakinfo.streakname, "use_" + streakinfo.streakname, 1, _id_52A5BE2E2F91D710);
  thread choppersupport_monitorowner();
  thread choppersupport_neargoalsettings();
  self playsoundonmovingent("ks_chopper_support_approach");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](::choppersupport_handlemissiledetection);
}

choppersupport_monitorowner() {
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread choppersupport_leave();
    return;
  }

  self.owner scripts\engine\utility::waittill_any_2("joined_team", "disconnect");
  thread choppersupport_leave();
}

choppersupport_neargoalsettings() {
  self endon("leaving");
  self endon("death");
  self waittill("near_goal");
  self vehicle_setspeed(int(self.speed / 2), int(self.accel / 3));
  thread choppersupport_watchlifetime();
  thread choppersupport_watchdestoyed();
  thread choppersupport_watchgameendleave();
  thread choppersupport_watchleash();
  thread choppersupport_patrolfield(1);
  thread choppersupport_engageturrettarget(self.frontturret);

  if(isDefined(self.rearturret))
    thread choppersupport_engageturrettarget(self.rearturret);
}

choppersupport_handlemissiledetection(player, _id_82FD3EE8FBACE30E, _id_6D87867F43E1D612, _id_5991F0E5DA9F9BD5) {
  self endon("death");

  for(;;) {
    if(!isDefined(_id_6D87867F43E1D612)) {
      break;
    }

    center = _id_6D87867F43E1D612 getpointinbounds(0, 0, 0);
    _id_6B40B4C28ABE0A05 = distance(self.origin, center);

    if(_id_6B40B4C28ABE0A05 < 4000 && _id_6D87867F43E1D612.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](_id_6D87867F43E1D612);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx"))
        _id_6D87867F43E1D612 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, _id_5991F0E5DA9F9BD5);

      if(isDefined(_id_6D87867F43E1D612.streakinfo))
        _id_6D87867F43E1D612 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_flares");

      newtarget = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy"))
        newtarget = _id_6D87867F43E1D612[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit"))
        _id_6D87867F43E1D612[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](player);

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

choppersupport_engageturrettarget(turret) {
  self endon("leaving");
  self endon("death");

  for(;;) {
    if(!istrue(turret.turreton) || istrue(turret.turretdisabled)) {
      waitframe();
      continue;
    }

    targets = choppersupport_gettargets(turret, 6000, 1, 1);

    if(isDefined(targets) && targets.size > 0) {
      result = choppersupport_acquireturrettarget(turret, targets);

      if(isDefined(result) && result == "stopped_firing")
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

      if(!choppersupport_checkifactivetargets())
        thread choppersupport_patrolfield();
    }

    wait 0.05;
  }
}

choppersupport_acquireturrettarget(turret, targets) {
  self notify("engaging_target");
  result = undefined;
  [besttarget, searchfortarget, targetvehicle] = choppersupport_getbesttarget(turret, targets);

  if(isDefined(besttarget)) {
    _id_F14A9B1E9835AEAF = undefined;

    if(istrue(targetvehicle))
      _id_F14A9B1E9835AEAF = besttarget scripts\cp_mp\utility\player_utility::getvehicle();

    choppersupport_setcurrenttarget(turret, besttarget);

    if(istrue(searchfortarget) && self.currenttarget == besttarget)
      thread choppersupport_movetolocation(besttarget, 1);

    choppersupport_fireonturrettarget(turret, besttarget, _id_F14A9B1E9835AEAF, 1, searchfortarget);
    result = "stopped_firing";
  } else
    result = "continue_searching";

  return result;
}

choppersupport_setcurrenttarget(turret, target) {
  turret settargetentity(turret.groundtargetent);
  turret.attackingtarget = target;

  if(!isDefined(self.currenttarget)) {
    self.currenttarget = target;
    self setlookatent(self.currenttarget);
  }
}

choppersupport_clearcurrenttarget(turret) {
  if(isDefined(self.currenttarget) && self.currenttarget == turret.attackingtarget)
    self.currenttarget = undefined;

  if(istrue(turret.targetbrokelos))
    turret.targetbrokelos = undefined;

  turret.attackingtarget = undefined;
  turret cleartargetentity();
  turret.groundtargetent unlink();
  _id_89EE7EBA7B1862CF = choppersupport_getactivetargets();

  if(self.currentaction != "patrol") {
    if(_id_89EE7EBA7B1862CF.size == 0)
      self clearlookatent();
  }

  turret notify("lost_target");
}

choppersupport_fireonturrettarget(turret, turrettarget, _id_4CEADF87059CA7E4, _id_8A61C99BBF018323, _id_7D1F0F4095D78597) {
  if(self.currentaction != "attacking")
    self.currentaction = "attacking";

  if(istrue(_id_8A61C99BBF018323) && isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::_isalive() && (!isDefined(self.lastfiretime) || self.lastfiretime + 15000 <= gettime())) {
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_engage_target");
    self.lastfiretime = gettime();
  }

  choppersupport_watchforlosttarget(turret);
  thread choppersupport_watchleashrange(turret);
  thread choppersupport_watchtargetlos(turret, _id_4CEADF87059CA7E4);
  thread choppersupport_watchtargettimeout(turret);
  thread choppersupport_watchforlaststand(turret);
  firetime = weaponfiretime("chopper_support_turret_mp");

  if(isDefined(self.firetime))
    firetime = self.firetime;

  _id_DBC5AEB90480B355 = 0;
  _id_B0B68854AE03B4D7 = 100;

  if(isDefined(self.stage1accradius))
    _id_B0B68854AE03B4D7 = self.stage1accradius;

  _id_B7F1B7D94522544F = 20;

  if(isDefined(self.minshotstostage2acc))
    _id_B7F1B7D94522544F = self.minshotstostage2acc;

  _id_C3D3F6560F48AEA6 = 40;

  if(isDefined(self.minshotstostage3acc))
    _id_C3D3F6560F48AEA6 = self.minshotstostage3acc;

  if(istrue(_id_7D1F0F4095D78597)) {
    _id_7479DF798E99A702 = 3750;

    while(istrue(choppersupport_canattackactivetarget(turret, turrettarget))) {
      if(distance2dsquared(self.origin, turrettarget.origin) < _id_7479DF798E99A702 * _id_7479DF798E99A702) {
        break;
      }

      waitframe();
    }
  }

  thread choppersupport_watchtargetrange(turret);

  while(istrue(choppersupport_canattackactivetarget(turret, turrettarget))) {
    if(istrue(turret.targetbrokelos)) {
      if(isDefined(self.currenttarget) && turrettarget == self.currenttarget)
        choppersupport_movetolocation(self.currenttarget, 1);
      else
        turret notify("chopperSupport_targetBrokeLOS");
    } else if(turret choppersupport_turretlookingattarget()) {
      _id_DE95D26A97999B92 = undefined;

      if(isDefined(_id_4CEADF87059CA7E4))
        _id_DE95D26A97999B92 = turrettarget.origin;
      else
        _id_DE95D26A97999B92 = turrettarget gettagorigin("j_mainroot");

      choppersupport_setattackpoint(turret, turrettarget, _id_DE95D26A97999B92, _id_B0B68854AE03B4D7);

      if(_id_DBC5AEB90480B355 == _id_B7F1B7D94522544F) {
        _id_B0B68854AE03B4D7 = 50;

        if(isDefined(self.stage2accradius))
          _id_B0B68854AE03B4D7 = self.stage2accradius;
      } else if(_id_DBC5AEB90480B355 == _id_C3D3F6560F48AEA6) {
        _id_B0B68854AE03B4D7 = undefined;

        if(isDefined(self.stage3accradius))
          _id_B0B68854AE03B4D7 = self.stage3accradius;
      }

      if(isDefined(self._id_2F0BA5B5F3FFA416))
        self[[self._id_2F0BA5B5F3FFA416]]();

      turret shootturret("tag_flash");
      _id_DBC5AEB90480B355++;

      if(isDefined(turret.streakinfo))
        turret.streakinfo.shots_fired++;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(firetime);
  }
}

choppersupport_canattackactivetarget(turret, turrettarget) {
  return isDefined(self) && isDefined(turret) && isDefined(turrettarget) && !isDefined(self.iscrashing) && !isDefined(self.isleaving) && isDefined(turret.attackingtarget);
}

choppersupport_setattackpoint(turret, turrettarget, _id_01E2777328B6B536, _id_B0B68854AE03B4D7) {
  point = _id_01E2777328B6B536;

  if(isDefined(_id_B0B68854AE03B4D7)) {
    ignorelist = [self, turret];
    _id_A0A41BA05E16FFE6 = randomint(_id_B0B68854AE03B4D7);
    _id_9E5D403038E4C071 = randomint(360);
    x = _id_01E2777328B6B536[0] + _id_A0A41BA05E16FFE6 * cos(_id_9E5D403038E4C071);
    y = _id_01E2777328B6B536[1] + _id_A0A41BA05E16FFE6 * sin(_id_9E5D403038E4C071);
    z = _id_01E2777328B6B536[2];
    point = (x, y, z);
    turret.groundtargetent.origin = point;
  } else if(!turret.groundtargetent islinked())
    turret.groundtargetent linkTo(turrettarget, "tag_origin", (0, 0, 30), (0, 0, 0));
}

choppersupport_turretlookingattarget() {
  _id_97F0985016AA48CB = 0.992;
  _id_929AD65D451FFC68 = anglesToForward(self gettagangles("tag_flash"));
  _id_EFA57ADC48838F9B = vectorNormalize(self.groundtargetent.origin - self.origin);
  _id_FF53E400DD536B82 = vectordot(_id_929AD65D451FFC68, _id_EFA57ADC48838F9B);

  if(isDefined(self gettargetentity(1)) && _id_FF53E400DD536B82 >= _id_97F0985016AA48CB)
    return 1;

  return 0;
}

choppersupport_watchforlosttarget(turret) {
  thread choppersupport_watchforlosttargetaction(turret, "death_or_disconnect");
  thread choppersupport_watchforlosttargetaction(turret, "chopperSupport_maxAggroRange");
  thread choppersupport_watchforlosttargetaction(turret, "chopperSupport_targetLeftRange");
  thread choppersupport_watchforlosttargetaction(turret, "chopperSupport_targetBrokeLOS");
  thread choppersupport_watchforlosttargetaction(turret, "chopperSupport_targetTimeout");
  thread choppersupport_watchforlosttargetaction(turret, "chopperSupport_targetLastStand");
}

choppersupport_watchforlosttargetaction(turret, action) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("crashing");
  turret endon("lost_target");
  _id_54B45F8D03409402 = turret;

  if(action == "death_or_disconnect")
    _id_54B45F8D03409402 = turret.attackingtarget;

  _id_54B45F8D03409402 waittill(action);
  choppersupport_clearcurrenttarget(turret);
}

choppersupport_watchleashrange(turret) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret endon("lost_target");

  if(!scripts\cp_mp\utility\game_utility::islargebrmap()) {
    return;
  }
  _id_40130BD790669C04 = self.pathgoal;

  for(;;) {
    if(isDefined(turret.attackingtarget)) {
      if(distance2dsquared(_id_40130BD790669C04, self.origin) > 100000000) {
        if(!istrue(self.hitleashrange))
          self.hitleashrange = 1;

        turret notify("chopperSupport_maxAggroRange");
        break;
      }
    }

    waitframe();
  }
}

choppersupport_watchtargetrange(turret) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret endon("lost_target");

  for(;;) {
    if(isDefined(turret.attackingtarget)) {
      targetent = turret.attackingtarget;

      if(distance2dsquared(turret.origin, targetent.origin) > 20250000) {
        wait 2;
        turret notify("chopperSupport_targetLeftRange");
        break;
      }
    }

    waitframe();
  }
}

choppersupport_watchtargetlos(turret, _id_9CB7C709F17E1C56) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret endon("lost_target");
  _id_FA2A5BDD4208DF6E = undefined;
  tolerance = 500;
  _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  ignorelist = [turret];

  if(isDefined(_id_9CB7C709F17E1C56)) {
    ignorelist[ignorelist.size] = _id_9CB7C709F17E1C56;
    _id_53023FDA76FA64FE = _id_9CB7C709F17E1C56 getlinkedchildren();

    if(isDefined(_id_53023FDA76FA64FE) && _id_53023FDA76FA64FE.size > 0)
      ignorelist = scripts\engine\utility::array_combine(ignorelist, _id_53023FDA76FA64FE);
  }

  for(;;) {
    if(!istrue(turret.targetbrokelos) && isDefined(turret.attackingtarget)) {
      canseetarget = scripts\engine\trace::ray_trace_passed(turret gettagorigin("tag_barrel"), turret.attackingtarget gettagorigin("j_head"), ignorelist, _id_C3FBB6661B91750F);

      if(!istrue(canseetarget)) {
        if(!isDefined(_id_FA2A5BDD4208DF6E))
          _id_FA2A5BDD4208DF6E = gettime();

        if(gettime() - _id_FA2A5BDD4208DF6E > tolerance)
          turret.targetbrokelos = 1;
      } else
        _id_FA2A5BDD4208DF6E = undefined;
    }

    wait 0.25;
  }
}

choppersupport_watchtargettimeout(turret) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret endon("lost_target");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  turret notify("chopperSupport_targetTimeout");
}

choppersupport_watchforlaststand(turret) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret endon("lost_target");

  for(;;) {
    if(isDefined(turret.attackingtarget) && istrue(turret.attackingtarget.inlaststand)) {
      turret notify("chopperSupport_targetLastStand");
      break;
    }

    waitframe();
  }
}

choppersupport_isactivetarget(target) {
  _id_9ACD3989A7189886 = 0;

  if(!isDefined(target))
    return 0;

  if(isDefined(self.frontturret.attackingtarget)) {
    if(self.frontturret.attackingtarget == target)
      _id_9ACD3989A7189886 = 1;
  }

  if(isDefined(self.rearturret) && isDefined(self.rearturret.attackingtarget)) {
    if(self.rearturret.attackingtarget == target)
      _id_9ACD3989A7189886 = 1;
  }

  return _id_9ACD3989A7189886;
}

choppersupport_checkifactivetargets() {
  return isDefined(self.frontturret.attackingtarget) || isDefined(self.rearturret) && isDefined(self.rearturret.attackingtarget);
}

choppersupport_getactivetargets() {
  _id_89EE7EBA7B1862CF = [];

  if(isDefined(self.frontturret.attackingtarget))
    _id_89EE7EBA7B1862CF[_id_89EE7EBA7B1862CF.size] = self.frontturret.attackingtarget;

  if(isDefined(self.rearturret) && isDefined(self.rearturret.attackingtarget))
    _id_89EE7EBA7B1862CF[_id_89EE7EBA7B1862CF.size] = self.rearturret.attackingtarget;

  return _id_89EE7EBA7B1862CF;
}

choppersupport_patrolfield(_id_0CE938A4EA8A54D5) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("engaging_target");

  if(isDefined(self.owner))
    self.owner endon("disconnect");

  if(isDefined(self.patrolfunc))
    self[[self.patrolfunc]](_id_0CE938A4EA8A54D5);
  else {
    if(self.currentaction != "patrol")
      self.currentaction = "patrol";
    else if(self.currentaction == "patrol" && !istrue(_id_0CE938A4EA8A54D5)) {
      return;
    }
    self clearlookatent();
    _id_8EB9FFBC96939B01 = 500;

    if(choppersupport_issmallpatrolmap())
      _id_8EB9FFBC96939B01 = 50;

    self setneargoalnotifydist(_id_8EB9FFBC96939B01);
    _id_65AF68838583C396 = 0;

    for(;;) {
      if(self.currentaction == "attacking") {
        if(!istrue(_id_65AF68838583C396))
          _id_65AF68838583C396 = 1;

        waitframe();
        continue;
      }

      if(!istrue(_id_0CE938A4EA8A54D5) && istrue(_id_65AF68838583C396)) {
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_patrol");
        _id_65AF68838583C396 = 0;
      }

      _id_E0C08758EB0006BE = choppersupport_findclosestpatrolstruct();

      if(isDefined(_id_E0C08758EB0006BE))
        choppersupport_movetolocation(_id_E0C08758EB0006BE, 1);
      else {
        _id_2DBC7C5305828A30 = [];
        _id_05E57C125BA3E9B8 = (0, 0, 0);
        _id_D38145343175DDE9 = self.pathgoal;

        foreach(player in level.players) {
          if(player == self.owner) {
            continue;
          }
          if(level.teambased && player.team == self.owner.team) {
            continue;
          }
          if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
            continue;
          }
          _id_05E57C125BA3E9B8 = _id_05E57C125BA3E9B8 + player.origin;
          _id_2DBC7C5305828A30[_id_2DBC7C5305828A30.size] = player;
        }

        if(isDefined(_id_05E57C125BA3E9B8) && _id_2DBC7C5305828A30.size > 0) {
          _id_565CDE9E77EA668E = _id_05E57C125BA3E9B8 / _id_2DBC7C5305828A30.size;
          choppersupport_movetolocation(_id_565CDE9E77EA668E);
        }
      }

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    }
  }
}

choppersupport_findclosestpatrolstruct() {
  _id_D7BAAFC9B07F5094 = scripts\engine\utility::array_combine(level.heli_structs_goals, level.heli_structs_paths);
  _id_CED0426E7E729ED5 = undefined;
  _id_824EBAB3E990A6BA = undefined;
  _id_FDB9974A1CCCE54C = undefined;

  foreach(struct in _id_D7BAAFC9B07F5094) {
    if(isDefined(self.currentpatrolstruct) && struct == self.currentpatrolstruct) {
      continue;
    }
    _id_6B40B4C28ABE0A05 = distance2dsquared(struct.origin, self.origin);

    if(!isDefined(_id_FDB9974A1CCCE54C) || _id_6B40B4C28ABE0A05 < _id_FDB9974A1CCCE54C) {
      _id_FDB9974A1CCCE54C = _id_6B40B4C28ABE0A05;
      _id_824EBAB3E990A6BA = struct;
    }
  }

  if(isDefined(_id_824EBAB3E990A6BA)) {
    _id_CED0426E7E729ED5 = choppersupport_findtargetStruct(_id_824EBAB3E990A6BA.script_linkto, _id_D7BAAFC9B07F5094);
    self.currentpatrolstruct = _id_824EBAB3E990A6BA;
  }

  return _id_CED0426E7E729ED5;
}

choppersupport_canseeenemy(enemy) {
  _id_027B697504D9397D = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);
  _id_D895C679F6A927E5 = [enemy gettagorigin("j_head"), enemy gettagorigin("j_mainroot"), enemy gettagorigin("tag_origin")];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], self, contents)) {
      continue;
    }
    _id_027B697504D9397D = 1;
    break;
  }

  return _id_027B697504D9397D;
}

choppersupport_movetolocation(target, _id_6C814CEE8D2BD65E) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  _id_6C53D859D582A421 = undefined;
  _id_4E6DF96D95BF50BC = target;

  if(!isvector(target))
    _id_4E6DF96D95BF50BC = target.origin;

  ignorelist = [self, self.frontturret, self.rearturret];
  ignorelist = scripts\engine\utility::array_removeundefined(ignorelist);

  for(;;) {
    _id_0454EBDDE3D9DCF4 = self.origin;
    _id_2ECA7B12D2EE27BA = _id_4E6DF96D95BF50BC * (1, 1, 0) + (0, 0, self.origin[2]);
    _id_691AA1D5DA533612 = scripts\engine\trace::sphere_trace(_id_0454EBDDE3D9DCF4, _id_2ECA7B12D2EE27BA, 256, ignorelist);
    _id_158F8E4D0E511638 = 0;
    _id_81954D580B24281B = _id_4E6DF96D95BF50BC[0];
    _id_E4F34F3A01C6FFF2 = _id_4E6DF96D95BF50BC[1];

    if(isDefined(_id_691AA1D5DA533612)) {
      if(_id_691AA1D5DA533612["hittype"] != "hittype_none") {
        _id_81954D580B24281B = _id_691AA1D5DA533612["position"][0];
        _id_E4F34F3A01C6FFF2 = _id_691AA1D5DA533612["position"][1];
        _id_158F8E4D0E511638 = 1;
      }
    }

    if(istrue(self.evasivemaneuvers)) {
      _id_F7CD955C75C5D1BF = _id_81954D580B24281B + randomintrange(-500, 500);
      _id_F7CD945C75C5CF8C = _id_E4F34F3A01C6FFF2 + randomintrange(-500, 500);
      _id_7504C8791E34DC73 = getcorrectheight(_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, 350);
      _id_6C53D859D582A421 = (_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, _id_7504C8791E34DC73);
    } else {
      _id_7504C8791E34DC73 = getcorrectheight(_id_81954D580B24281B, _id_E4F34F3A01C6FFF2, 20);
      _id_6C53D859D582A421 = (_id_81954D580B24281B, _id_E4F34F3A01C6FFF2, _id_7504C8791E34DC73);
    }

    _id_E1F26216DAE25CB7 = 0;

    if(istrue(_id_6C814CEE8D2BD65E) && !istrue(_id_158F8E4D0E511638))
      _id_E1F26216DAE25CB7 = _id_6C814CEE8D2BD65E;

    self setvehgoalpos(_id_6C53D859D582A421, _id_E1F26216DAE25CB7);
    scripts\engine\utility::waittill_any_2("near_goal", "begin_evasive_maneuvers");

    if(!istrue(_id_158F8E4D0E511638)) {
      break;
    }
  }
}

choppersupport_leave() {
  self endon("death");
  self playsoundonmovingent("ks_chopper_support_leave");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.isleaving = 1;
  self clearlookatent();
  pathgoal = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  pathgoal = pathgoal + (0, 0, 1000);
  self setvehgoalpos(pathgoal, 1);
  self setneargoalnotifydist(100);
  self waittill("near_goal");
  _id_8B79D0E3AD3FB617 = getpathend();
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(_id_8B79D0E3AD3FB617, 1);
  self waittill("goal");
  self stoploopsound();
  self notify("chopperSupport_gone");
  thread choppersupport_cleanup();
}

choppersupport_cleanup(_id_4FAC8B8CE36E09F1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - jackal", self.owner);

  if(isDefined(self.frontturret)) {
    self.frontturret setentityowner(undefined);
    self.frontturret.groundtargetent delete();
    self.frontturret delete();
  }

  if(isDefined(self.rearturret)) {
    self.rearturret setentityowner(undefined);
    self.rearturret.groundtargetent delete();
    self.rearturret delete();
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  if(isDefined(self.cleanupfunc))
    self[[self.cleanupfunc]]();

  if(isDefined(self.streakinfo))
    self.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);

  if(!istrue(self.recordedgameendstats)) {
    if(isDefined(self.streakinfo))
      self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  if(isDefined(level.choppersupports))
    level.choppersupports = scripts\engine\utility::array_remove(level.choppersupports, self);

  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

choppersupport_watchlifetime() {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self.lifetime);
  thread choppersupport_leave();
}

choppersupport_watchgameendleave() {
  if(isDefined(self.owner))
    self.owner endon("disconnect");

  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  self.recordedgameendstats = 1;

  if(isDefined(self.streakinfo))
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);

  thread choppersupport_leave();
}

choppersupport_watchleash() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(!scripts\cp_mp\utility\game_utility::islargebrmap()) {
    return;
  }
  for(;;) {
    if(istrue(self.hitleashrange)) {
      self.frontturret.turreton = 0;

      if(isDefined(self.rearturret))
        self.rearturret.turreton = 0;

      _id_3EB886ACC54A7065 = 8000;

      for(;;) {
        if(distance2dsquared(self.origin, self.pathgoal) <= _id_3EB886ACC54A7065 * _id_3EB886ACC54A7065) {
          self.hitleashrange = undefined;
          self.frontturret.turreton = 1;

          if(isDefined(self.rearturret))
            self.rearturret.turreton = 1;

          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

choppersupport_gettargets(turret, _id_F0885A4B1F9CC49E, _id_F8C5D9BA90C73623, _id_F537B27C366F06C9) {
  self endon("death");
  self endon("leaving");
  targets = [];
  players = level.players;
  agents = [];

  if(isDefined(level.agentarray)) {
    foreach(agent in level.agentarray) {
      if(istrue(agent.isactive) && !issubstr(agent.agent_type, "civilian"))
        agents[agents.size] = agent;
    }
  }

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    _id_397EB484DFDDD2DA = 4500;

    if(isDefined(_id_F0885A4B1F9CC49E))
      _id_397EB484DFDDD2DA = _id_F0885A4B1F9CC49E;

    if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "dmz" || scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "exgm")
      players = scripts\common\utility::_id_2D7FD59D039FA69B(self.origin, _id_397EB484DFDDD2DA, undefined);
    else
      players = scripts\common\utility::_id_2D7FD59D039FA69B(self.origin, _id_397EB484DFDDD2DA, 1);
  } else
    players scripts\engine\utility::array_combine(players, agents);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    _id_BD73C7ACC56CD20C = players[_id_AC0E594AC96AA3A8];
    [_id_42266A7FD7932C50, _id_4631FDFCABB28E61, invehicle] = choppersupport_istarget(turret, _id_BD73C7ACC56CD20C, _id_F8C5D9BA90C73623, _id_F537B27C366F06C9);

    if(istrue(_id_42266A7FD7932C50)) {
      newtarget = spawnStruct();
      newtarget.player = _id_BD73C7ACC56CD20C;
      newtarget.searchfortarget = _id_4631FDFCABB28E61;
      newtarget.targetvehicle = invehicle;
      targets[targets.size] = newtarget;
    } else
      continue;

    wait 0.05;
  }

  return targets;
}

choppersupport_istarget(turret, _id_BD73C7ACC56CD20C, _id_F8C5D9BA90C73623, _id_F537B27C366F06C9) {
  self endon("death");
  self endon("leaving");

  if(!choppersupport_isplayeractive(_id_BD73C7ACC56CD20C))
    return [0, 0, 0];

  if(isDefined(self.owner) && _id_BD73C7ACC56CD20C == self.owner)
    return [0, 0, 0];

  if(!isDefined(_id_BD73C7ACC56CD20C.pers["team"]))
    return [0, 0, 0];

  if(level.teambased && _id_BD73C7ACC56CD20C.pers["team"] == self.team)
    return [0, 0, 0];

  if(_id_BD73C7ACC56CD20C.pers["team"] == "spectator")
    return [0, 0, 0];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(_id_BD73C7ACC56CD20C[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye"))
      return [0, 0, 0];
  }

  if(istrue(_id_BD73C7ACC56CD20C.inlaststand))
    return [0, 0, 0];

  if(scripts\cp_mp\parachute::isparachutegametype() && (_id_BD73C7ACC56CD20C isparachuting() || _id_BD73C7ACC56CD20C isskydiving()))
    return [0, 0, 0];

  _id_E5FEDFF34DEB3853 = 0;

  if(istrue(_id_F8C5D9BA90C73623)) {
    if(distance2dsquared(self.origin, _id_BD73C7ACC56CD20C.origin) > 20250000) {
      if(distance2dsquared(self.origin, _id_BD73C7ACC56CD20C.origin) > 36000000)
        return [0, 0, 0];

      _id_E5FEDFF34DEB3853 = 1;
    }
  }

  _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  _id_B9D5783A4F34EFBC = [turret];
  _id_15C3C1D963654F89 = 0;

  if(istrue(_id_F537B27C366F06C9)) {
    _id_15C3C1D963654F89 = _id_BD73C7ACC56CD20C scripts\cp_mp\utility\player_utility::isinvehicle();

    if(istrue(_id_15C3C1D963654F89)) {
      _id_281DEDD57C723E4F = _id_BD73C7ACC56CD20C scripts\cp_mp\utility\player_utility::getvehicle();
      _id_B9D5783A4F34EFBC[_id_B9D5783A4F34EFBC.size] = _id_281DEDD57C723E4F;
      _id_53023FDA76FA64FE = _id_281DEDD57C723E4F getlinkedchildren();

      if(isDefined(_id_53023FDA76FA64FE) && _id_53023FDA76FA64FE.size > 0)
        _id_B9D5783A4F34EFBC = scripts\engine\utility::array_combine(_id_B9D5783A4F34EFBC, _id_53023FDA76FA64FE);
    }
  }

  canseetarget = scripts\engine\trace::ray_trace_passed(turret gettagorigin("tag_barrel"), _id_BD73C7ACC56CD20C gettagorigin("j_head"), _id_B9D5783A4F34EFBC, _id_C3FBB6661B91750F);

  if(!istrue(canseetarget))
    return [0, 0, 0];

  return [1, _id_E5FEDFF34DEB3853, _id_15C3C1D963654F89];
}

choppersupport_isplayeractive(player) {
  return isDefined(player) && !player.notarget && player scripts\cp_mp\utility\player_utility::_isalive() && player.sessionstate == "playing";
}

choppersupport_getbesttarget(turret, targets) {
  _id_88C2B48BA3714B8E = undefined;
  besttarget = undefined;
  _id_F6227B830478253F = undefined;
  _id_79594FB5961C597A = undefined;

  foreach(_id_B8E70FF71A02E32D in targets) {
    if(!choppersupport_isplayeractive(_id_B8E70FF71A02E32D.player)) {
      continue;
    }
    if(choppersupport_isactivetarget(_id_B8E70FF71A02E32D.player) && !istrue(_id_B8E70FF71A02E32D.targetvehicle)) {
      continue;
    }
    searchfortarget = 0;
    targetvehicle = 0;
    angle = abs(vectortoangles(_id_B8E70FF71A02E32D.player.origin - self.origin)[1]);
    _id_A6F54781E7E6CB25 = 0;

    if(self tagexists("tag_flash"))
      _id_A6F54781E7E6CB25 = abs(self gettagangles("tag_flash")[1]);

    angle = abs(angle - _id_A6F54781E7E6CB25);
    _id_D6E9347C3618A5BB = _id_B8E70FF71A02E32D.player getweaponslistitems();

    foreach(weapon in _id_D6E9347C3618A5BB) {
      _id_C0B9C9A4FA4EEF84 = weaponclass(weapon);

      if(_id_C0B9C9A4FA4EEF84 == "rocketlauncher")
        angle = angle - 40;
    }

    if(istrue(_id_B8E70FF71A02E32D.searchfortarget)) {
      searchfortarget = 1;
      angle = angle + 40;
    }

    if(istrue(_id_B8E70FF71A02E32D.targetvehicle)) {
      targetvehicle = 1;
      angle = angle + 20;
    }

    if(!isDefined(_id_88C2B48BA3714B8E) || _id_88C2B48BA3714B8E > angle) {
      _id_88C2B48BA3714B8E = angle;
      besttarget = _id_B8E70FF71A02E32D.player;
      _id_79594FB5961C597A = targetvehicle;
      _id_F6227B830478253F = searchfortarget;
    }
  }

  return [besttarget, _id_F6227B830478253F, _id_79594FB5961C597A];
}

getcorrectheight(x, y, _id_83694BF9778D85EE, _id_1D3A4B020AE79012) {
  _id_DC8BB6300463CF1E = self.heightoffset[2];
  _id_E7A7D619F927D791 = tracegroundpoint(x, y, _id_1D3A4B020AE79012);
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  _id_1DC672CFE0F0128E = _id_1DC672CFE0F0128E + randomint(_id_83694BF9778D85EE);
  return _id_1DC672CFE0F0128E;
}

choppersupport_watchdestoyed() {
  level endon("game_ended");
  self endon("chopperSupport_gone");
  owner = self.owner;
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](self.killedbyweapon))
      choppersupport_crash(100);
  }

  choppersupport_explode();
}

choppersupport_explode() {
  self notify("explode");
  self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_support_turret_mp");
  self setscriptablepartstate("explode", "on", 0);
  _id_3AD17B785FE5ACEC = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587(), !istrue(self._id_85BF734167B68CA3), 1);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_3AD17B785FE5ACEC)
    self notsolid();

  if(isDefined(self.lootfunc))
    self[[self.lootfunc]]();

  wait 0.35;
  choppersupport_cleanup(1);
}

choppersupport_crash(speed) {
  self endon("explode");
  self setscriptablepartstate("crash", "on", 0);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament.origin = self.origin + (0, 0, 100);
  }

  self clearlookatent();
  self notify("crashing");
  self.iscrashing = 1;
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  _id_6847739E80FB4E81 = choppersupport_findcrashposition(3500, 500, 1000);

  if(!isDefined(_id_6847739E80FB4E81)) {
    return;
  }
  if(isDefined(self.streakinfo))
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_crash", 1);

  self setvehgoalpos(_id_6847739E80FB4E81, 0);
  thread choppersupport_spinout(speed);
  self vehicle_turnengineoff();
  self waittill("near_goal");

  if(isDefined(self.streakinfo))
    scripts\cp_mp\utility\killstreak_utility::_id_5A9772411551E56E();
}

choppersupport_findcrashposition(_id_6F8D59F68BD2B46C, _id_6C56FF5ECC704C48, _id_6C7AF55ECC98B102) {
  _id_B2B5F5510C5D94E0 = self.origin;
  crashoffset = self.crashoffset;
  _id_543F2191DDE2B7F6 = undefined;
  _id_6C5CEED9B00EB7D5 = anglesToForward(self.angles);
  _id_5CC1D6DD55C49E3A = anglestoright(self.angles);
  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + _id_6C5CEED9B00EB7D5 * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 - _id_6C5CEED9B00EB7D5 * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + _id_5CC1D6DD55C49E3A * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 - _id_5CC1D6DD55C49E3A * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_6C5CEED9B00EB7D5 + _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_6C5CEED9B00EB7D5 - _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_5CC1D6DD55C49E3A - _id_6C5CEED9B00EB7D5) - (0, 0, crashoffset);
  _id_4720F54E3EFF6E8D = scripts\engine\trace::ray_trace(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (-1 * _id_6C5CEED9B00EB7D5 - _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  return _id_543F2191DDE2B7F6;
}

choppersupport_spinout(speed) {
  self endon("death");
  self setyawspeed(speed, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.4);
    wait 0.5;
  }
}

tracenewpoint(x, y, z) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");
  _id_E96577032A7740FC = scripts\engine\trace::sphere_trace(self.origin, (x, y, z), 256, self, undefined, 1);

  if(_id_E96577032A7740FC["surfacetype"] != "surftype_none")
    return 0;

  pathgoal = (x, y, z);
  return pathgoal;
}

tracegroundpoint(x, y, _id_1D3A4B020AE79012) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  z = -99999;
  _id_E531AFBE1391F499 = self.origin[2] + 2000;
  _id_3C590B0EE220AFA3 = level.averagealliesz;
  ignorelist = [self];

  if(isDefined(self.dropcrates)) {
    foreach(crate in self.dropcrates)
    ignorelist[ignorelist.size] = crate;
  }

  _id_C77E7A25454430DA = 800;

  if(isDefined(_id_1D3A4B020AE79012))
    _id_C77E7A25454430DA = _id_1D3A4B020AE79012;

  _id_E96577032A7740FC = scripts\engine\trace::sphere_trace((x, y, _id_E531AFBE1391F499), (x, y, z), _id_C77E7A25454430DA, ignorelist, undefined, 1);

  if(_id_E96577032A7740FC["position"][2] < _id_3C590B0EE220AFA3)
    _id_0FA83E3A4C4E6902 = _id_3C590B0EE220AFA3;
  else
    _id_0FA83E3A4C4E6902 = _id_E96577032A7740FC["position"][2];

  return _id_0FA83E3A4C4E6902;
}

beginevasivemaneuvers() {
  self endon("death");
  self notify("begin_evasive_maneuvers");
  self endon("begin_evasive_maneuvers");
  self.evasivemaneuvers = 1;
  result = scripts\engine\utility::waittill_any_timeout_1(3.0, "death");

  if(result == "timeout")
    self.evasivemaneuvers = 0;
}

getcorrectheightescort(x, y, _id_00AE14C5A8B1B582, _id_F3F4EB55AED6E784) {
  _id_DC8BB6300463CF1E = 200;

  if(isDefined(_id_F3F4EB55AED6E784))
    _id_DC8BB6300463CF1E = _id_F3F4EB55AED6E784;

  _id_E7A7D619F927D791 = tracegroundpoint(x, y);
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  _id_1DC672CFE0F0128E = _id_1DC672CFE0F0128E + randomint(_id_00AE14C5A8B1B582);
  return _id_1DC672CFE0F0128E;
}

_id_F60FC20E14BD9B6F(streakname) {
  _id_E25F9B0DE2CC7B81 = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = undefined;
  destroyedsplash = "callout_destroyed_" + streakname;
  _id_8DFC256103CCE53E = ::_id_635F6112BF87D114;
  _id_191284E2E2837328 = ::_id_6561CD64026004D8;
  _id_BACC6DD14316758C = ::_id_CB514462A6399FAA;
  _id_7DA88D9C69433487 = ::_id_400022DABDB64055;
  deathcallback = ::choppersupport_handledeathdamage;
  scripts\cp_mp\utility\killstreak_utility::_id_836A81868136192D(streakname, _id_E25F9B0DE2CC7B81, scorepopup, vodestroyed, destroyedsplash, _id_8DFC256103CCE53E, _id_191284E2E2837328, _id_BACC6DD14316758C, _id_7DA88D9C69433487, deathcallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(1, 1500, ::_id_7D38D0927292ED9A);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(2, 1000, ::_id_29D9F6678D3DD0CF);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(3, 500, ::_id_5D99407A305345BF);
}

_id_635F6112BF87D114(streakname) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, 12);
}

_id_6561CD64026004D8(streakname) {
  weaponname = "thermite_bolt_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 36;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "thermite_xmike109_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 100;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "semtex_bolt_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 13;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "semtex_xmike109_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 24;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);
}

_id_CB514462A6399FAA(data) {
  damage = data.damage;
  attacker = data.attacker;
  return 1;
}

_id_400022DABDB64055(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  self.currenthealth = self.currenthealth - damage;
  scripts\cp_mp\utility\killstreak_utility::_id_DB9562064A4DD635(self.currenthealth);
  return 1;
}

_id_7D38D0927292ED9A() {
  self setscriptablepartstate("body_damage_light", "on");
  self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_light_damage");
}

_id_29D9F6678D3DD0CF() {
  self setscriptablepartstate("body_damage_medium", "on");
  self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_med_damage");
}

_id_5D99407A305345BF() {
  self setscriptablepartstate("body_damage_heavy", "on");
  self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_heavy_damage");
}

choppersupport_handledeathdamage(data) {
  self.killedbyweapon = data.objweapon;
  thread scripts\cp_mp\challenges::vehiclekilled(self, data.attacker, data.damage, data.objweapon);
  return 1;
}

choppersipport_randommovement() {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self.lastaction = "randomMovement";
  pos = self.defendloc;
  _id_6C53D859D582A421 = getrandompoint(self.origin);
  self setvehgoalpos(_id_6C53D859D582A421, 1);
  thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, _id_6C53D859D582A421, 5, (1, 0, 1));
  self waittill("goal");
}

getrandompoint(pos) {
  self clearlookatent();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    x = self.owner.origin[0];
    y = self.owner.origin[1];
    z = getcorrectheight(x, y, 20);
    _id_01E2777328B6B536 = (x, y, z);
    self setlookatent(self.owner);
    return _id_01E2777328B6B536;
  } else {
    yaw = self.angles[1];
    yawmin = int(yaw - 60);
    yawmax = int(yaw + 60);
    _id_DEE36AD33D9E9755 = randomintrange(yawmin, yawmax);
    direction = (0, _id_DEE36AD33D9E9755, 0);
    _id_7EBC0C4339BDFD35 = self.origin + anglesToForward(direction) * randomintrange(400, 800);
    _id_BF6A113C5A54166F = _id_7EBC0C4339BDFD35[0];
    _id_BF6A103C5A54143C = _id_7EBC0C4339BDFD35[1];
    _id_B42E60E1AC25640A = getcorrectheight(_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, 20);
    point = tracenewpoint(_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, _id_B42E60E1AC25640A);

    if(point != 0)
      return point;

    _id_BF6A113C5A54166F = randomfloatrange(pos[0] - 1200, pos[0] + 1200);
    _id_BF6A103C5A54143C = randomfloatrange(pos[1] - 1200, pos[1] + 1200);
    _id_1EDD9350013A11A0 = (_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, _id_B42E60E1AC25640A);
    return _id_1EDD9350013A11A0;
  }
}

getnewpoint(pos, _id_B8E70FF71A02E32D) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");

  if(!isDefined(_id_B8E70FF71A02E32D)) {
    return;
  }
  _id_8156649A5A358B7C = [];

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }
    if(!level.teambased || player.team != self.team)
      _id_8156649A5A358B7C[_id_8156649A5A358B7C.size] = player.origin;
  }

  if(_id_8156649A5A358B7C.size > 0) {
    _id_D6669BC3A02D67D4 = averagepoint(_id_8156649A5A358B7C);
    _id_BF6A113C5A54166F = _id_D6669BC3A02D67D4[0];
    _id_BF6A103C5A54143C = _id_D6669BC3A02D67D4[1];
  } else {
    center = level.mapcenter;
    _id_8444F490AB96C6D4 = level.mapsize / 4;
    _id_BF6A113C5A54166F = randomfloatrange(center[0] - _id_8444F490AB96C6D4, center[0] + _id_8444F490AB96C6D4);
    _id_BF6A103C5A54143C = randomfloatrange(center[1] - _id_8444F490AB96C6D4, center[1] + _id_8444F490AB96C6D4);
  }

  _id_B42E60E1AC25640A = getcorrectheight(_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, 20);
  point = tracenewpoint(_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, _id_B42E60E1AC25640A);

  if(point != 0)
    return point;

  _id_BF6A113C5A54166F = randomfloatrange(pos[0] - 1200, pos[0] + 1200);
  _id_BF6A103C5A54143C = randomfloatrange(pos[1] - 1200, pos[1] + 1200);
  _id_B42E60E1AC25640A = getcorrectheight(_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, 20);
  _id_1EDD9350013A11A0 = (_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, _id_B42E60E1AC25640A);
  return _id_1EDD9350013A11A0;
}

getpathstart(_id_6E7C70B904418DAA) {
  _id_CE2E2CFD0619F6CA = 100;
  _id_90783CCFB7B260FB = 15000;
  yaw = randomfloat(360);
  direction = (0, yaw, 0);
  startpoint = _id_6E7C70B904418DAA + anglesToForward(direction) * (-1 * _id_90783CCFB7B260FB);
  startpoint = startpoint + ((randomfloat(2) - 1) * _id_CE2E2CFD0619F6CA, (randomfloat(2) - 1) * _id_CE2E2CFD0619F6CA, 0);
  return startpoint;
}

getpathend() {
  _id_CE2E2CFD0619F6CA = 150;
  _id_90783CCFB7B260FB = 15000;
  yaw = self.angles[1];
  direction = (0, yaw, 0);
  endpoint = self.origin + anglesToForward(direction) * _id_90783CCFB7B260FB;
  return endpoint;
}

choppersupport_findtargetStruct(_id_8571897DAA3F69BF, _id_6E1E1E75FC237EB1) {
  _id_09827E05250FD6E2 = undefined;

  foreach(struct in _id_6E1E1E75FC237EB1) {
    if(struct.script_linkname == _id_8571897DAA3F69BF) {
      _id_09827E05250FD6E2 = struct;
      break;
    }
  }

  return _id_09827E05250FD6E2;
}

choppersupport_issmallpatrolmap() {
  _id_549F2CF299FE01B8 = 0;

  switch (level.mapname) {
    case "mp_m_speed":
    case "mp_shipment":
      _id_549F2CF299FE01B8 = 1;
      break;
  }

  return _id_549F2CF299FE01B8;
}