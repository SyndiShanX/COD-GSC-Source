/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\chopper_support.gsc
*********************************************************/



#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\sentientpoolmanager;
#namespace chopper_support;

function init() {
  if(issharedfuncdefined("chopper_support", "init")) {
    [[getsharedfunc("chopper_support", "init")]]();
  }

  level.choppersupports = [];

  setdevdvarifuninitialized(@ "hash_d992ce3d83291d98", 45);
  setdevdvarifuninitialized(@ "hash_189e3806377f69dc", 0);
  setdevdvarifuninitialized(@ "hash_f91acea7f6a68742", 0);
  setdevdvarifuninitialized(@ "hash_90c9f37b614bae4a", 0);

  init_chopper_support_vo();
  level.incomingallchoppersupports = 0;
  level.incomingchoppersupports["allies"] = 0;
  level.incomingchoppersupports["axis"] = 0;
}

function init_chopper_support_vo() {
  game["dialog"]["chopper_support_light_damage"] = "chopper_support_health_high";
  game["dialog"]["chopper_support_med_damage"] = "chopper_support_health_med";
  game["dialog"]["chopper_support_heavy_damage"] = "chopper_support_health_low";
  game["dialog"]["chopper_support_engage_target"] = "chopper_support_engage";
  game["dialog"]["chopper_support_patrol"] = "chopper_support_patrol";
  game["dialog"]["chopper_support_flares"] = "chopper_support_flares";
  game["dialog"]["chopper_support_crash"] = "chopper_support_crash";
}

function tryusechoppersupport(streakname) {
  streakinfo = createstreakinfo(streakname, self);
  return tryusechoppersupportfromstruct(streakinfo);
}

function tryusechoppersupportfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return 0;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return 0;
  }

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_generic_mp"));

  if(!istrue(deployresult)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  level.incomingallchoppersupports++;
  var_9c8d568f8760e50 = 1;

  if(islargemap()) {
    var_9c8d568f8760e50 = 2;
  }

  if(level.choppersupports.size >= var_9c8d568f8760e50 || level.choppersupports.size + level.incomingallchoppersupports > var_9c8d568f8760e50) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    level.incomingallchoppersupports--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(islargemap() && level.teambased) {
    var_abdb6af6e3ca3893 = 1;
    level.incomingchoppersupports[self.team]++;

    if(getnumactivekillstreakperteam(self.team, level.choppersupports) + level.incomingchoppersupports[self.team] > var_abdb6af6e3ca3893) {
      level.incomingallchoppersupports--;
      level.incomingchoppersupports[self.team]--;

      if(issharedfuncdefined("hud", "showErrorMessage")) {
        [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_SUPPORT_HELO");
      }

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

  useresult = usechoppersupport(self, streakinfo);

  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]]("chopper_support", self.origin);
  }

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_chopper_support", self);
  }

  return useresult;
}

function usechoppersupport(player, streakinfo) {
  chopper = spawnchopper(player, streakinfo);
  level.incomingallchoppersupports--;

  if(islargemap() && level.teambased) {
    level.incomingchoppersupports[player.team]--;
  }

  if(!isDefined(chopper)) {
    return false;
  }

  chopper thread startchopper(player, streakinfo);
  level callback::callback("killstreak_finish_use", {
    #streakinfo: streakinfo
  });
  return true;
}

function spawnchopper(owner, streakinfo) {
  heightoffset = (0, 0, 1750);

  var_ae257a52192fe977 = getdvarint(@ "hash_90c9f37b614bae4a", 0);
  heightoffset += (0, 0, var_ae257a52192fe977);

  pathstart = owner.origin - anglesToForward(owner.angles) * 15000 + heightoffset;
  pathgoal = owner.origin + anglesToForward(owner.angles) * 2000 + heightoffset;
  angles = owner.angles;
  modifiedlifetime = getdvarint(@ "hash_d992ce3d83291d98", 45);

  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    modifiedlifetime = 9999;
  }

  goalstruct = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_8013278937ff2600 = randomint(level.heli_structs_entrances.size);
    entrancestruct = level.heli_structs_entrances[var_8013278937ff2600];
    goalstruct = choppersupport_findtargetStruct(entrancestruct.script_linkto, level.heli_structs_goals);

    if(isDefined(goalstruct)) {
      var_a168db747b0d79ac = entrancestruct.origin * (1, 1, 0) + heightoffset;
      var_c32e33b4d51be12f = goalstruct.origin * (1, 1, 0) + heightoffset;
      entranceforward = vectorNormalize(var_c32e33b4d51be12f - var_a168db747b0d79ac);
      pathstart = var_c32e33b4d51be12f - entranceforward * 15000;
      pathgoal = var_c32e33b4d51be12f;
      angles = vectortoangles(entranceforward);

      debugpathing = getdvarint(@ "hash_189e3806377f69dc", 0);

      if(debugpathing) {
        pathstructs = array_combine(level.heli_structs_goals, level.heli_structs_paths);

        foreach(struct in pathstructs) {
          targetstruct = choppersupport_findtargetStruct(struct.script_linkto, pathstructs);
          sphere(struct.origin, 20, (0, 1, 1), 0, modifiedlifetime * 30);
          line(struct.origin, targetstruct.origin, (1, 1, 1), 1, 0, modifiedlifetime * 30);
        }

        sphere(var_a168db747b0d79ac, 50, (1, 1, 0), 0, 1000);
        sphere(var_c32e33b4d51be12f, 50, (1, 1, 0), 0, 1000);
        line(pathgoal, pathstart, (1, 1, 1), 1, 0, 1000);
      }
    } else {
      owner iprintlnbold("<dev string:x1c>" + entrancestruct.script_linkto + "<dev string:x2c>");
    }
  } else {
    if(level.gametype != "<dev string:x3b>" && level.gametype != "<dev string:x3f>" && !scripts\cp_mp\utility\game_utility::isbrstylegametype() && !istrue(level.leanthread)) {
      owner iprintlnbold("<dev string:x48>");
    }
  }

  var_d8af13d53a9c00a0 = "veh8_mil_air_palfa";

  if(getplayersuperfaction(owner)) {
    var_d8af13d53a9c00a0 = "veh8_mil_air_palfa_east";
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  chopper = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, pathstart, angles, "veh_chopper_support_mp", var_d8af13d53a9c00a0);

  if(!isDefined(chopper)) {
    return undefined;
  }

  chopper.speed = 100;
  chopper.accel = 50;
  chopper.lifetime = modifiedlifetime;
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
  chopper function_f60fc20e14bd9b6f(streakinfo.streakname);
  level.choppersupports[level.choppersupports.size] = chopper;

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    chopper[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);
  }

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
  var_9ebe5c9daec0c8c2 = "veh9_mil_air_heli_ahotel64_turret";

  if(getplayersuperfaction(owner)) {
    var_9ebe5c9daec0c8c2 = "veh9_mil_air_heli_ahotel64_turret";
  }

  chopper.frontturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  chopper.frontturret setModel(var_9ebe5c9daec0c8c2);
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
  chopper.rearturret setModel(var_9ebe5c9daec0c8c2);
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

function startchopper(player, streakinfo) {
  self endon("death");
  assert(isDefined(self));
  self setvehgoalpos(self.pathgoal, 1);
  var_52a5be2e2f91d710 = undefined;

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](player, streakinfo.streakname);
    var_52a5be2e2f91d710 = 2;
  }

  player thread playkillstreakoperatordialog(streakinfo.streakname, "use_" + streakinfo.streakname, 1, var_52a5be2e2f91d710);
  thread choppersupport_monitorowner();
  thread choppersupport_neargoalsettings();
  self playsoundonmovingent("ks_chopper_support_approach");

  debugtargeting = getdvarint(@ "hash_f91acea7f6a68742", 0);

  if(istrue(debugtargeting)) {
    thread function_9480f8b8d48d0f59(player);
  }

  if(issharedfuncdefined("flares", "handleIncomingStinger")) {
    self thread[[getsharedfunc("flares", "handleIncomingStinger")]](&choppersupport_handlemissiledetection);
  }
}

function choppersupport_monitorowner() {
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread choppersupport_leave();
    return;
  }

  self.owner waittill_any_2("joined_team", "disconnect");
  thread choppersupport_leave();
}

function choppersupport_neargoalsettings() {
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

  if(isDefined(self.rearturret)) {
    thread choppersupport_engageturrettarget(self.rearturret);
  }
}

function choppersupport_handlemissiledetection(player, missileteam, missiletarget, fxtagoverride) {
  self endon("death");

  while(true) {
    if(!isDefined(missiletarget)) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < 4000 && missiletarget.flaresreservecount > 0) {
      if(issharedfuncdefined("flares", "reduceReserves")) {
        [[getsharedfunc("flares", "reduceReserves")]](missiletarget);
      }

      if(issharedfuncdefined("flares", "playFx")) {
        missiletarget thread[[getsharedfunc("flares", "playFx")]](undefined, fxtagoverride);
      }

      if(isDefined(missiletarget.streakinfo)) {
        missiletarget playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_flares");
      }

      newtarget = undefined;

      if(issharedfuncdefined("flares", "deploy")) {
        newtarget = missiletarget[[getsharedfunc("flares", "deploy")]]();
      }

      if(issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        missiletarget[[getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](player);
      }

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function choppersupport_engageturrettarget(turret) {
  self endon("leaving");
  self endon("death");

  while(true) {
    if(!istrue(turret.turreton) || istrue(turret.turretdisabled)) {
      waitframe();
      continue;
    }

    targets = choppersupport_gettargets(turret, 6000, 1, 1);

    if(isDefined(targets) && targets.size > 0) {
      result = choppersupport_acquireturrettarget(turret, targets);

      if(isDefined(result) && result == "stopped_firing") {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
      }

      if(!choppersupport_checkifactivetargets()) {
        thread choppersupport_patrolfield();
      }
    }

    wait 0.05;
  }
}

function choppersupport_acquireturrettarget(turret, targets) {
  self notify("engaging_target");
  result = undefined;
  [besttarget, searchfortarget, targetvehicle] = choppersupport_getbesttarget(turret, targets);

  if(isDefined(besttarget)) {
    var_f14a9b1e9835aeaf = undefined;

    if(istrue(targetvehicle)) {
      var_f14a9b1e9835aeaf = besttarget getvehicle();
    }

    choppersupport_setcurrenttarget(turret, besttarget);

    if(istrue(searchfortarget) && self.currenttarget == besttarget) {
      thread choppersupport_movetolocation(besttarget, 1);
    }

    choppersupport_fireonturrettarget(turret, besttarget, var_f14a9b1e9835aeaf, 1, searchfortarget);
    result = "stopped_firing";
  } else {
    result = "continue_searching";
  }

  return result;
}

function choppersupport_setcurrenttarget(turret, target) {
  turret settargetentity(turret.groundtargetent);
  turret.attackingtarget = target;

  if(!isDefined(self.currenttarget)) {
    self.currenttarget = target;
    self setlookatent(self.currenttarget);
  }
}

function choppersupport_clearcurrenttarget(turret) {
  if(isDefined(self.currenttarget) && self.currenttarget == turret.attackingtarget) {
    self.currenttarget = undefined;
  }

  if(istrue(turret.targetbrokelos)) {
    turret.targetbrokelos = undefined;
  }

  turret.attackingtarget = undefined;
  turret cleartargetentity();
  turret.groundtargetent unlink();
  activetargets = choppersupport_getactivetargets();

  if(self.currentaction != "patrol") {
    if(activetargets.size == 0) {
      self clearlookatent();
    }
  }

  turret notify("lost_target");
}

function choppersupport_fireonturrettarget(turret, turrettarget, turretvehicletarget, playdialog, var_7d1f0f4095d78597) {
  if(self.currentaction != "attacking") {
    self.currentaction = "attacking";
  }

  if(istrue(playdialog) && isDefined(self.owner) && self.owner _isalive() && (!isDefined(self.lastfiretime) || self.lastfiretime + 15000 <= gettime())) {
    playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_engage_target");
    self.lastfiretime = gettime();
  }

  choppersupport_watchforlosttarget(turret);
  thread choppersupport_watchleashrange(turret);
  thread choppersupport_watchtargetlos(turret, turretvehicletarget);
  thread choppersupport_watchtargettimeout(turret);
  thread choppersupport_watchforlaststand(turret);
  firetime = weaponfiretime("chopper_support_turret_mp");
  var_dbc5aeb90480b355 = 0;
  attackradius = 100;

  if(isDefined(self.stage1accradius)) {
    attackradius = self.stage1accradius;
  }

  var_b7f1b7d94522544f = 20;

  if(isDefined(self.minshotstostage2acc)) {
    var_b7f1b7d94522544f = self.minshotstostage2acc;
  }

  var_c3d3f6560f48aea6 = 40;

  if(isDefined(self.minshotstostage3acc)) {
    var_c3d3f6560f48aea6 = self.minshotstostage3acc;
  }

  if(istrue(var_7d1f0f4095d78597)) {
    firerange = 3750;

    while(istrue(choppersupport_canattackactivetarget(turret, turrettarget))) {
      if(distance2dsquared(self.origin, turrettarget.origin) < firerange * firerange) {
        break;
      }

      waitframe();
    }
  }

  thread choppersupport_watchtargetrange(turret);

  while(istrue(choppersupport_canattackactivetarget(turret, turrettarget))) {
    if(istrue(turret.targetbrokelos)) {
      if(isDefined(self.currenttarget) && turrettarget == self.currenttarget) {
        choppersupport_movetolocation(self.currenttarget, 1);
      } else {
        turret notify("chopperSupport_targetBrokeLOS");
      }
    } else if(turret choppersupport_turretlookingattarget()) {
      var_de95d26a97999b92 = undefined;

      if(isDefined(turretvehicletarget)) {
        var_de95d26a97999b92 = turrettarget.origin;
      } else {
        var_de95d26a97999b92 = turrettarget gettagorigin("j_mainroot");
      }

      choppersupport_setattackpoint(turret, turrettarget, var_de95d26a97999b92, attackradius);

      if(var_dbc5aeb90480b355 == var_b7f1b7d94522544f) {
        attackradius = 50;

        if(isDefined(self.stage2accradius)) {
          attackradius = self.stage2accradius;
        }
      } else if(var_dbc5aeb90480b355 == var_c3d3f6560f48aea6) {
        attackradius = undefined;

        if(isDefined(self.stage3accradius)) {
          attackradius = self.stage3accradius;
        }
      }

      turret shootturret("tag_flash");
      var_dbc5aeb90480b355++;

      if(isDefined(turret.streakinfo)) {
        turret.streakinfo.shots_fired++;
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(firetime);
  }
}

function function_189edc0c3e4cce61(turret) {
  turret endon("<dev string:x7b>");
  turret.groundtargetent endon("<dev string:x87>");

  while(true) {
    sphere(turret.groundtargetent.origin, 10, (1, 1, 1), 0, 1);
    waitframe();
  }
}

function choppersupport_canattackactivetarget(turret, turrettarget) {
  return isDefined(self) && isDefined(turret) && isDefined(turrettarget) && !isDefined(self.iscrashing) && !isDefined(self.isleaving) && isDefined(turret.attackingtarget);
}

function choppersupport_setattackpoint(turret, turrettarget, centerpoint, attackradius) {
  point = centerpoint;

  if(isDefined(attackradius)) {
    ignorelist = [self, turret];
    randdist = randomint(attackradius);
    randangle = randomint(360);
    x = centerpoint[0] + randdist * cos(randangle);
    y = centerpoint[1] + randdist * sin(randangle);
    z = centerpoint[2];
    point = (x, y, z);
    turret.groundtargetent.origin = point;
    return;
  }

  if(!turret.groundtargetent islinked()) {
    turret.groundtargetent linkTo(turrettarget, "tag_origin", (0, 0, 30), (0, 0, 0));
  }
}

function choppersupport_turretlookingattarget() {
  maxviewangle = 0.992;
  turretforward = anglesToForward(self gettagangles("tag_flash"));
  targetdisplace = vectorNormalize(self.groundtargetent.origin - self.origin);
  var_ff53e400dd536b82 = vectordot(turretforward, targetdisplace);

  if(isDefined(self gettargetentity(1)) && var_ff53e400dd536b82 >= maxviewangle) {
    return true;
  }

  return false;
}

function choppersupport_watchforlosttarget(turret) {
  thread choppersupport_watchforlosttargetaction(turret, "death_or_disconnect");
  thread choppersupport_watchforlosttargetaction(turret, "chopperSupport_maxAggroRange");
  thread choppersupport_watchforlosttargetaction(turret, "chopperSupport_targetLeftRange");
  thread choppersupport_watchforlosttargetaction(turret, "chopperSupport_targetBrokeLOS");
  thread choppersupport_watchforlosttargetaction(turret, "chopperSupport_targetTimeout");
  thread choppersupport_watchforlosttargetaction(turret, "chopperSupport_targetLastStand");
}

function choppersupport_watchforlosttargetaction(turret, action) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("crashing");
  turret endon("lost_target");
  var_54b45f8d03409402 = turret;

  if(action == "death_or_disconnect") {
    var_54b45f8d03409402 = turret.attackingtarget;
  }

  var_54b45f8d03409402 waittill(action);
  choppersupport_clearcurrenttarget(turret);
}

function choppersupport_watchleashrange(turret) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret endon("lost_target");

  if(!islargebrmap()) {
    return;
  }

  var_40130bd790669c04 = self.pathgoal;

  while(true) {
    if(isDefined(turret.attackingtarget)) {
      if(distance2dsquared(var_40130bd790669c04, self.origin) > 100000000) {
        if(!istrue(self.hitleashrange)) {
          self.hitleashrange = 1;
        }

        turret notify("chopperSupport_maxAggroRange");
        break;
      }
    }

    waitframe();
  }
}

function choppersupport_watchtargetrange(turret) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret endon("lost_target");

  while(true) {
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

function choppersupport_watchtargetlos(turret, vehicletarget) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret endon("lost_target");
  losttime = undefined;
  tolerance = 500;
  contentsoverride = create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  ignorelist = [turret];

  if(isDefined(vehicletarget)) {
    ignorelist[ignorelist.size] = vehicletarget;
    linkedmodels = vehicletarget getlinkedchildren();

    if(isDefined(linkedmodels) && linkedmodels.size > 0) {
      ignorelist = array_combine(ignorelist, linkedmodels);
    }
  }

  while(true) {
    if(!istrue(turret.targetbrokelos) && isDefined(turret.attackingtarget)) {
      canseetarget = ray_trace_passed(turret gettagorigin("tag_barrel"), turret.attackingtarget gettagorigin("j_head"), ignorelist, contentsoverride);

      if(!istrue(canseetarget)) {
        if(!isDefined(losttime)) {
          losttime = gettime();
        }

        if(gettime() - losttime > tolerance) {
          turret.targetbrokelos = 1;
        }
      } else {
        losttime = undefined;
      }
    }

    wait 0.25;
  }
}

function choppersupport_watchtargettimeout(turret) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret endon("lost_target");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  turret notify("chopperSupport_targetTimeout");
}

function choppersupport_watchforlaststand(turret) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret endon("lost_target");

  while(true) {
    if(isDefined(turret.attackingtarget) && istrue(turret.attackingtarget.inlaststand)) {
      turret notify("chopperSupport_targetLastStand");
      break;
    }

    waitframe();
  }
}

function choppersupport_isactivetarget(target) {
  activetarget = 0;

  if(!isDefined(target)) {
    return 0;
  }

  if(isDefined(self.frontturret.attackingtarget)) {
    if(self.frontturret.attackingtarget == target) {
      activetarget = 1;
    }
  }

  if(isDefined(self.rearturret) && isDefined(self.rearturret.attackingtarget)) {
    if(self.rearturret.attackingtarget == target) {
      activetarget = 1;
    }
  }

  return activetarget;
}

function choppersupport_checkifactivetargets() {
  return isDefined(self.frontturret.attackingtarget) || isDefined(self.rearturret) && isDefined(self.rearturret.attackingtarget);
}

function choppersupport_getactivetargets() {
  activetargets = [];

  if(isDefined(self.frontturret.attackingtarget)) {
    activetargets[activetargets.size] = self.frontturret.attackingtarget;
  }

  if(isDefined(self.rearturret) && isDefined(self.rearturret.attackingtarget)) {
    activetargets[activetargets.size] = self.rearturret.attackingtarget;
  }

  return activetargets;
}

function choppersupport_patrolfield(initialpatrol) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("engaging_target");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  if(isDefined(self.patrolfunc)) {
    self[[self.patrolfunc]](initialpatrol);
    return;
  }

  if(self.currentaction != "patrol") {
    self.currentaction = "patrol";
  } else if(self.currentaction == "patrol" && !istrue(initialpatrol)) {
    return;
  }

  self clearlookatent();
  neargoalnotifydist = 500;

  if(choppersupport_issmallpatrolmap()) {
    neargoalnotifydist = 50;
  }

  self setneargoalnotifydist(neargoalnotifydist);
  var_65af68838583c396 = 0;

  while(true) {
    if(self.currentaction == "attacking") {
      if(!istrue(var_65af68838583c396)) {
        var_65af68838583c396 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(initialpatrol) && istrue(var_65af68838583c396)) {
      playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_patrol");
      var_65af68838583c396 = 0;
    }

    patrolstruct = choppersupport_findclosestpatrolstruct();

    if(isDefined(patrolstruct)) {
      debugpathing = getdvarint(@ "hash_189e3806377f69dc", 0);

      if(debugpathing) {
        sphere(patrolstruct.origin, 100, (0, 1, 0), 0, 60);
      }

      choppersupport_movetolocation(patrolstruct, 1);
    } else {
      allenemies = [];
      sumvectors = (0, 0, 0);
      spawncenterpos = self.pathgoal;

      foreach(player in level.players) {
        if(player == self.owner) {
          continue;
        }

        if(level.teambased && player.team == self.owner.team) {
          continue;
        }

        if(!player _isalive()) {
          continue;
        }

        sumvectors += player.origin;
        allenemies[allenemies.size] = player;
      }

      if(isDefined(sumvectors) && allenemies.size > 0) {
        newlocation = sumvectors / allenemies.size;

        debugpathing = getdvarint(@ "hash_189e3806377f69dc", 0);

        if(debugpathing) {
          self.owner iprintlnbold("<dev string:x8d>");
          sphere(newlocation, 100, (0, 1, 0), 0, 120);
        }

        choppersupport_movetolocation(newlocation);
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

function choppersupport_findclosestpatrolstruct() {
  pathstructs = array_combine(level.heli_structs_goals, level.heli_structs_paths);
  targetstruct = undefined;
  beststruct = undefined;
  bestdistance = undefined;

  foreach(struct in pathstructs) {
    if(isDefined(self.currentpatrolstruct) && struct == self.currentpatrolstruct) {
      continue;
    }

    curdist = distance2dsquared(struct.origin, self.origin);

    if(!isDefined(bestdistance) || curdist < bestdistance) {
      bestdistance = curdist;
      beststruct = struct;
    }
  }

  if(isDefined(beststruct)) {
    targetstruct = choppersupport_findtargetStruct(beststruct.script_linkto, pathstructs);
    self.currentpatrolstruct = beststruct;
  }

  return targetstruct;
}

function choppersupport_canseeenemy(enemy) {
  icansee = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);
  tracepoints = [enemy gettagorigin("j_head"), enemy gettagorigin("j_mainroot"), enemy gettagorigin("tag_origin")];

  for(i = 0; i < tracepoints.size; i++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, tracepoints[i], self, contents)) {
      continue;
    }

    icansee = 1;
    break;
  }

  return icansee;
}

function choppersupport_movetolocation(target, forcestopatgoal) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  newpos = undefined;
  testtarget = target;

  if(!isvector(target)) {
    testtarget = target.origin;
  }

  ignorelist = [self, self.frontturret, self.rearturret];
  ignorelist = array_removeundefined(ignorelist);

  while(true) {
    currentpos = self.origin;
    initialgoalpos = testtarget * (1, 1, 0) + (0, 0, self.origin[2]);
    obstructiontrace = sphere_trace(currentpos, initialgoalpos, 256, ignorelist);
    obstructed = 0;
    xpos = testtarget[0];
    ypos = testtarget[1];

    if(isDefined(obstructiontrace)) {
      if(obstructiontrace["hittype"] != "hittype_none") {
        xpos = obstructiontrace["position"][0];
        ypos = obstructiontrace["position"][1];
        obstructed = 1;
      }
    }

    if(istrue(self.evasivemaneuvers)) {
      newx = xpos + randomintrange(-500, 500);
      newy = ypos + randomintrange(-500, 500);
      properz = getcorrectheight(newx, newy, 350);
      newpos = (newx, newy, properz);
    } else {
      properz = getcorrectheight(xpos, ypos, 20);
      newpos = (xpos, ypos, properz);
    }

    stopatgoal = 0;

    if(istrue(forcestopatgoal) && !istrue(obstructed)) {
      stopatgoal = forcestopatgoal;
    }

    self setvehgoalpos(newpos, stopatgoal);
    waittill_any_2("near_goal", "begin_evasive_maneuvers");

    if(!istrue(obstructed)) {
      break;
    }
  }
}

function choppersupport_leave() {
  self endon("death");
  self playsoundonmovingent("ks_chopper_support_leave");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.isleaving = 1;
  self clearlookatent();
  pathgoal = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  pathgoal += (0, 0, 1000);
  self setvehgoalpos(pathgoal, 1);
  self setneargoalnotifydist(100);
  self waittill("near_goal");
  pathend = getpathend();
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(pathend, 1);
  self waittill("goal");
  self stoploopsound();
  self notify("chopperSupport_gone");
  thread choppersupport_cleanup();
}

function choppersupport_cleanup(wasdestroyed) {
  if(issharedfuncdefined("player", "printGameAction")) {
    self[[getsharedfunc("player", "printGameAction")]]("killstreak ended - jackal", self.owner);
  }

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

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self.cleanupfunc)) {
    self[[self.cleanupfunc]]();
  }

  if(isDefined(self.streakinfo)) {
    self.streakinfo.expiredbydeath = istrue(wasdestroyed);
  }

  if(!istrue(self.recordedgameendstats)) {
    if(isDefined(self.streakinfo)) {
      self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
    }
  }

  if(isDefined(level.choppersupports)) {
    level.choppersupports = array_remove(level.choppersupports, self);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function choppersupport_watchlifetime() {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self.lifetime);
  thread choppersupport_leave();
}

function choppersupport_watchgameendleave() {
  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  self.recordedgameendstats = 1;

  if(isDefined(self.streakinfo)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  thread choppersupport_leave();
}

function choppersupport_watchleash() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(!islargebrmap()) {
    return;
  }

  while(true) {
    if(istrue(self.hitleashrange)) {
      self.frontturret.turreton = 0;

      if(isDefined(self.rearturret)) {
        self.rearturret.turreton = 0;
      }

      var_3eb886acc54a7065 = 8000;

      while(true) {
        if(distance2dsquared(self.origin, self.pathgoal) <= var_3eb886acc54a7065 * var_3eb886acc54a7065) {
          self.hitleashrange = undefined;
          self.frontturret.turreton = 1;

          if(isDefined(self.rearturret)) {
            self.rearturret.turreton = 1;
          }

          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

function choppersupport_gettargets(turret, rangeoverride, var_f8c5d9ba90c73623, var_f537b27c366f06c9) {
  self endon("death");
  self endon("leaving");
  targets = [];
  players = level.players;
  agents = [];

  if(isDefined(level.agentarray)) {
    foreach(agent in level.agentarray) {
      if(istrue(agent.isactive) && !issubstr(agent.agent_type, "civilian")) {
        agents[agents.size] = agent;
      }
    }
  }

  if(islargemap()) {
    radiustocheck = 4500;

    if(isDefined(rangeoverride)) {
      radiustocheck = rangeoverride;
    }

    if(function_6c1fce6f6b8779d5() == "dmz" || function_6c1fce6f6b8779d5() == "exgm") {
      players = utility::function_2d7fd59d039fa69b(self.origin, radiustocheck, undefined);
    } else {
      players = utility::function_2d7fd59d039fa69b(self.origin, radiustocheck, 0);
    }
  } else {
    players array_combine(players, agents);
  }

  for(i = 0; i < players.size; i++) {
    potentialtarget = players[i];
    [isvalidtarget, var_4631fdfcabb28e61, invehicle] = choppersupport_istarget(turret, potentialtarget, var_f8c5d9ba90c73623, var_f537b27c366f06c9);

    if(istrue(isvalidtarget)) {
      newtarget = spawnStruct();
      newtarget.player = potentialtarget;
      newtarget.searchfortarget = var_4631fdfcabb28e61;
      newtarget.targetvehicle = invehicle;
      targets[targets.size] = newtarget;
    } else {
      continue;
    }

    wait 0.05;
  }

  return targets;
}

function choppersupport_istarget(turret, potentialtarget, var_f8c5d9ba90c73623, var_f537b27c366f06c9) {
  self endon("death");
  self endon("leaving");

  if(!choppersupport_isplayeractive(potentialtarget)) {
    return [0, 0, 0];
  }

  if(isDefined(self.owner) && potentialtarget == self.owner) {
    var_4dbe11d3bda81e4a = getdvarint(@ "hash_48714771f0d0b941", 0);

    if(var_4dbe11d3bda81e4a) {
      var_e5fedff34deb3853 = 0;

      if(istrue(var_f8c5d9ba90c73623)) {
        if(distance2dsquared(self.origin, potentialtarget.origin) > 20250000) {
          if(distance2dsquared(self.origin, potentialtarget.origin) > 36000000) {
            return [0, 0, 0];
          }

          var_e5fedff34deb3853 = 1;
        }
      }

      contentsoverride = create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
      var_b9d5783a4f34efbc = [turret];
      var_15c3c1d963654f89 = 0;

      if(istrue(var_f537b27c366f06c9)) {
        var_15c3c1d963654f89 = potentialtarget isinvehicle();

        if(istrue(var_15c3c1d963654f89)) {
          occupiedvehicle = potentialtarget getvehicle();
          var_b9d5783a4f34efbc[var_b9d5783a4f34efbc.size] = occupiedvehicle;
          linkedmodels = occupiedvehicle getlinkedchildren();

          if(isDefined(linkedmodels) && linkedmodels.size > 0) {
            var_b9d5783a4f34efbc = array_combine(var_b9d5783a4f34efbc, linkedmodels);
          }
        }
      }

      canseetarget = ray_trace_passed(turret gettagorigin("<dev string:xea>"), potentialtarget gettagorigin("<dev string:xf5>"), var_b9d5783a4f34efbc, contentsoverride);

      if(!istrue(canseetarget)) {
        return [0, 0, 0];
      }

      return [1, var_e5fedff34deb3853, var_15c3c1d963654f89];
    }

    return [0, 0, 0];
  }

  if(!isDefined(potentialtarget.pers["team"])) {
    return [0, 0, 0];
  }

  if(level.teambased && potentialtarget.pers["team"] == self.team) {
    return [0, 0, 0];
  }

  if(potentialtarget.pers["team"] == "spectator") {
    return [0, 0, 0];
  }

  if(issharedfuncdefined("perk", "hasPerk")) {
    if(potentialtarget[[getsharedfunc("perk", "hasPerk")]]("specialty_blindeye")) {
      return [0, 0, 0];
    }
  }

  if(istrue(potentialtarget.inlaststand)) {
    return [0, 0, 0];
  }

  if(scripts\cp_mp\parachute::isparachutegametype() && (potentialtarget isparachuting() || potentialtarget isskydiving())) {
    return [0, 0, 0];
  }

  var_e5fedff34deb3853 = 0;

  if(istrue(var_f8c5d9ba90c73623)) {
    if(distance2dsquared(self.origin, potentialtarget.origin) > 20250000) {
      if(distance2dsquared(self.origin, potentialtarget.origin) > 36000000) {
        return [0, 0, 0];
      }

      var_e5fedff34deb3853 = 1;
    }
  }

  contentsoverride = create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_b9d5783a4f34efbc = [turret];
  var_15c3c1d963654f89 = 0;

  if(istrue(var_f537b27c366f06c9)) {
    var_15c3c1d963654f89 = potentialtarget isinvehicle();

    if(istrue(var_15c3c1d963654f89)) {
      occupiedvehicle = potentialtarget getvehicle();
      var_b9d5783a4f34efbc[var_b9d5783a4f34efbc.size] = occupiedvehicle;
      linkedmodels = occupiedvehicle getlinkedchildren();

      if(isDefined(linkedmodels) && linkedmodels.size > 0) {
        var_b9d5783a4f34efbc = array_combine(var_b9d5783a4f34efbc, linkedmodels);
      }
    }
  }

  canseetarget = ray_trace_passed(turret gettagorigin("tag_barrel"), potentialtarget gettagorigin("j_head"), var_b9d5783a4f34efbc, contentsoverride);

  if(!istrue(canseetarget)) {
    return [0, 0, 0];
  }

  return [1, var_e5fedff34deb3853, var_15c3c1d963654f89];
}

function choppersupport_isplayeractive(player) {
  return isDefined(player) && !player.notarget && player _isalive() && player.sessionstate == "playing";
}

function choppersupport_getbesttarget(turret, targets) {
  bestyaw = undefined;
  besttarget = undefined;
  var_f6227b830478253f = undefined;
  besttargetvehicle = undefined;

  foreach(targ in targets) {
    if(!choppersupport_isplayeractive(targ.player)) {
      continue;
    }

    if(choppersupport_isactivetarget(targ.player) && !istrue(targ.targetvehicle)) {
      continue;
    }

    searchfortarget = 0;
    targetvehicle = 0;
    angle = abs(vectortoangles(targ.player.origin - self.origin)[1]);
    var_a6f54781e7e6cb25 = 0;

    if(self tagexists("tag_flash")) {
      var_a6f54781e7e6cb25 = abs(self gettagangles("tag_flash")[1]);
    }

    angle = abs(angle - var_a6f54781e7e6cb25);
    weaponsarray = targ.player getweaponslistitems();

    foreach(weapon in weaponsarray) {
      weaponclassname = weaponclass(weapon);

      if(weaponclassname == "rocketlauncher") {
        angle -= 40;
      }
    }

    if(istrue(targ.searchfortarget)) {
      searchfortarget = 1;
      angle += 40;
    }

    if(istrue(targ.targetvehicle)) {
      targetvehicle = 1;
      angle += 20;
    }

    if(!isDefined(bestyaw) || bestyaw > angle) {
      bestyaw = angle;
      besttarget = targ.player;
      besttargetvehicle = targetvehicle;
      var_f6227b830478253f = searchfortarget;
    }
  }

  return [besttarget, var_f6227b830478253f, besttargetvehicle];
}

function getcorrectheight(x, y, randheightoffset, var_1d3a4b020ae79012) {
  offgroundheight = self.heightoffset[2];
  groundheight = tracegroundpoint(x, y, var_1d3a4b020ae79012);
  trueheight = groundheight + offgroundheight;
  trueheight += randomint(randheightoffset);
  return trueheight;
}

function choppersupport_watchdestoyed() {
  level endon("game_ended");
  self endon("chopperSupport_gone");
  owner = self.owner;
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  if(issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(![[getsharedfunc("killstreak", "isKillstreakWeapon")]](self.killedbyweapon)) {
      choppersupport_crash(100);
    }
  }

  choppersupport_explode();
}

function choppersupport_explode() {
  self notify("explode");
  self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_support_turret_mp");
  self setscriptablepartstate("explode", "on", 0);

  if(isbrstylegametype()) {
    self notsolid();
  }

  if(isDefined(self.lootfunc)) {
    self[[self.lootfunc]]();
  }

  wait 0.35;
  choppersupport_cleanup(1);
}

function choppersupport_crash(speed) {
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
  var_6847739e80fb4e81 = choppersupport_findcrashposition(3500, 500, 1000);

  if(!isDefined(var_6847739e80fb4e81)) {
    return;
  }

  if(isDefined(self.streakinfo)) {
    playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_crash", 1);
  }

  self setvehgoalpos(var_6847739e80fb4e81, 0);
  thread choppersupport_spinout(speed);
  self vehicle_turnengineoff();
  self waittill("near_goal");

  if(isDefined(self.streakinfo)) {
    function_5a9772411551e56e();
  }
}

function choppersupport_findcrashposition(crashdist, var_6c56ff5ecc704c48, var_6c7af55ecc98b102) {
  crashstart = self.origin;
  crashoffset = self.crashoffset;
  crashpos = undefined;
  jetforward = anglesToForward(self.angles);
  jetright = anglestoright(self.angles);
  crashend = crashstart + jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward + jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetright - jetforward) - (0, 0, crashoffset);
  crashtrace = ray_trace(crashstart, crashend, self);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (-1 * jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  return crashpos;
}

function choppersupport_spinout(speed) {
  self endon("death");
  self setyawspeed(speed, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.4);
    wait 0.5;
  }
}

function tracenewpoint(x, y, z) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");
  trc = sphere_trace(self.origin, (x, y, z), 256, self, undefined, 1);

  if(trc["surfacetype"] != "surftype_none") {
    return 0;
  }

  pathgoal = (x, y, z);
  return pathgoal;
}

function tracegroundpoint(x, y, var_1d3a4b020ae79012) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  z = -99999;
  currz = self.origin[2] + 2000;
  minz = level.averagealliesz;
  ignorelist = [self];

  if(isDefined(self.dropcrates)) {
    foreach(crate in self.dropcrates) {
      ignorelist[ignorelist.size] = crate;
    }
  }

  sphereradius = 800;

  if(isDefined(var_1d3a4b020ae79012)) {
    sphereradius = var_1d3a4b020ae79012;
  }

  trc = sphere_trace((x, y, currz), (x, y, z), sphereradius, ignorelist, undefined, 1);

  if(trc["position"][2] < minz) {
    hightrace = minz;
  } else {
    hightrace = trc["position"][2];
  }

  return hightrace;
}

function beginevasivemaneuvers() {
  self endon("death");
  self notify("begin_evasive_maneuvers");
  self endon("begin_evasive_maneuvers");
  self.evasivemaneuvers = 1;
  result = waittill_any_timeout_1(3, "death");

  if(result == "timeout") {
    self.evasivemaneuvers = 0;
  }
}

function getcorrectheightescort(x, y, rand, minheight) {
  offgroundheight = 200;

  if(isDefined(minheight)) {
    offgroundheight = minheight;
  }

  groundheight = tracegroundpoint(x, y);
  trueheight = groundheight + offgroundheight;
  trueheight += randomint(rand);
  return trueheight;
}

function function_f60fc20e14bd9b6f(streakname) {
  killstreakvehicle = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = undefined;
  destroyedsplash = "callout_destroyed_" + streakname;
  var_8dfc256103cce53e = &function_635f6112bf87d114;
  var_191284e2e2837328 = &function_6561cd64026004d8;
  premoddamagecallback = &function_cb514462a6399faa;
  postmoddamagecallback = &function_400022dabdb64055;
  deathcallback = &choppersupport_handledeathdamage;
  killstreak_setupvehicledamagefunctionality(streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  function_cfc5e3633ef950fd(1, 1500, &function_7d38d0927292ed9a);
  function_cfc5e3633ef950fd(2, 1000, &function_29d9f6678d3dd0cf);
  function_cfc5e3633ef950fd(3, 500, &function_5d99407a305345bf);
}

function function_635f6112bf87d114(streakname) {
  if(issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, 12);
  }
}

function function_6561cd64026004d8(streakname) {
  weaponname = "thermite_bolt_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 36;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "thermite_xmike109_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 100;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "semtex_bolt_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 13;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "semtex_xmike109_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 24;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }
}

function function_cb514462a6399faa(data) {
  damage = data.damage;
  attacker = data.attacker;
  return true;
}

function function_400022dabdb64055(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  self.currenthealth -= damage;
  killstreak_updatedamagestate(self.currenthealth);
  return true;
}

function function_7d38d0927292ed9a() {
  self setscriptablepartstate("body_damage_light", "on");
  self.owner playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_light_damage");
}

function function_29d9f6678d3dd0cf() {
  self setscriptablepartstate("body_damage_medium", "on");
  self.owner playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_med_damage");
}

function function_5d99407a305345bf() {
  self setscriptablepartstate("body_damage_heavy", "on");
  self.owner playkillstreakoperatordialog(self.streakinfo.streakname, "chopper_support_heavy_damage");
}

function choppersupport_handledeathdamage(data) {
  self.killedbyweapon = data.objweapon;
  thread scripts\cp_mp\challenges::vehiclekilled(self, data.attacker, data.damage, data.objweapon);
  return true;
}

function choppersipport_randommovement() {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self.lastaction = "randomMovement";
  pos = self.defendloc;
  newpos = getrandompoint(self.origin);
  self setvehgoalpos(newpos, 1);
  thread drawline(self.origin, newpos, 5, (1, 0, 1));
  self waittill("goal");
}

function getrandompoint(pos) {
  self clearlookatent();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    x = self.owner.origin[0];
    y = self.owner.origin[1];
    z = getcorrectheight(x, y, 20);
    centerpoint = (x, y, z);
    self setlookatent(self.owner);
    return centerpoint;
  }

  yaw = self.angles[1];
  yawmin = int(yaw - 60);
  yawmax = int(yaw + 60);
  randyaw = randomintrange(yawmin, yawmax);
  direction = (0, randyaw, 0);
  movetopoint = self.origin + anglesToForward(direction) * randomintrange(400, 800);
  pointx = movetopoint[0];
  pointy = movetopoint[1];
  newheight = getcorrectheight(pointx, pointy, 20);
  point = tracenewpoint(pointx, pointy, newheight);

  if(point != 0) {
    return point;
  }

  pointx = randomfloatrange(pos[0] - 1200, pos[0] + 1200);
  pointy = randomfloatrange(pos[1] - 1200, pos[1] + 1200);
  bspoint = (pointx, pointy, newheight);
  return bspoint;
}

function getnewpoint(pos, targ) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");

  if(!isDefined(targ)) {
    return;
  }

  enemypoints = [];

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }

    if(!level.teambased || player.team != self.team) {
      enemypoints[enemypoints.size] = player.origin;
    }
  }

  if(enemypoints.size > 0) {
    gotopoint = averagepoint(enemypoints);
    pointx = gotopoint[0];
    pointy = gotopoint[1];
  } else {
    center = level.mapcenter;
    movementdist = level.mapsize / 4;
    pointx = randomfloatrange(center[0] - movementdist, center[0] + movementdist);
    pointy = randomfloatrange(center[1] - movementdist, center[1] + movementdist);
  }

  newheight = getcorrectheight(pointx, pointy, 20);
  point = tracenewpoint(pointx, pointy, newheight);

  if(point != 0) {
    return point;
  }

  pointx = randomfloatrange(pos[0] - 1200, pos[0] + 1200);
  pointy = randomfloatrange(pos[1] - 1200, pos[1] + 1200);
  newheight = getcorrectheight(pointx, pointy, 20);
  bspoint = (pointx, pointy, newheight);
  return bspoint;
}

function getpathstart(coord) {
  pathrandomness = 100;
  halfdistance = 15000;
  yaw = randomfloat(360);
  direction = (0, yaw, 0);
  startpoint = coord + anglesToForward(direction) * -1 * halfdistance;
  startpoint += ((randomfloat(2) - 1) * pathrandomness, (randomfloat(2) - 1) * pathrandomness, 0);
  return startpoint;
}

function getpathend() {
  pathrandomness = 150;
  halfdistance = 15000;
  yaw = self.angles[1];
  direction = (0, yaw, 0);
  endpoint = self.origin + anglesToForward(direction) * halfdistance;
  return endpoint;
}

function choppersupport_findtargetStruct(structlinkname, var_6e1e1e75fc237eb1) {
  foundstruct = undefined;

  foreach(struct in var_6e1e1e75fc237eb1) {
    if(struct.script_linkname == structlinkname) {
      foundstruct = struct;
      break;
    }
  }

  return foundstruct;
}

function choppersupport_issmallpatrolmap() {
  smallpatrolmap = 0;

  switch (level.mapname) {
    case #"hash_9de262a7132ec180":
    case #"hash_dd0468a72c625fe3":
      smallpatrolmap = 1;
      break;
  }

  return smallpatrolmap;
}

function function_9480f8b8d48d0f59(owner) {
  self endon("<dev string:x87>");
  self endon("<dev string:xfc>");

  while(true) {
    if(getdvarint(@ "hash_f91acea7f6a68742") == 0) {
      waitframe();
      continue;
    }

    fronttarget = "<dev string:x104>";

    if(isDefined(self.frontturret.attackingtarget)) {
      fronttarget = self.frontturret.attackingtarget.name;
    }

    reartarget = "<dev string:x104>";

    if(isDefined(self.rearturret) && isDefined(self.rearturret.attackingtarget)) {
      reartarget = self.rearturret.attackingtarget.name;
    }

    anglesforward = anglesToForward(owner.angles);
    scalar = (anglesforward[0] * 300, anglesforward[1] * 300, anglesforward[2]);
    print3d(level.players[0].origin + scalar, "<dev string:x10c>" + fronttarget, (1, 1, 0));
    print3d(level.players[0].origin + scalar - (0, 0, 20), "<dev string:x122>" + reartarget, (1, 1, 0));
    waitframe();
  }
}

# /