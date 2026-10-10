/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\killstreaks\cruise_predator.gsc
************************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace cruise_predator;

function init() {
  if(issharedfuncdefined("cruise_predator", "init")) {
    [[getsharedfunc("cruise_predator", "init")]]();
  }

  level function_eb11a8dfbd2505a0();
  level function_10865a43b7b1243e();
  level function_ce236b9143b76125();
  level function_f0b48909aba12866();
  level function_f06e9c09ab54c2bf();
  level function_328fd4c30cafcce0();
}

function function_eb11a8dfbd2505a0() {
  registervisibilityomnvarforkillstreak("cruise_predator", "invisible", 7);
  registervisibilityomnvarforkillstreak("cruise_predator", "on", 8);
}

function function_10865a43b7b1243e() {
  val::group_register("cruisePredator", ["allow_movement", "allow_jump", "fire", "weapon_switch", "melee", "usability", "shellshock", "offhand_weapons", "killstreaks"]);
}

function function_ce236b9143b76125() {}

function function_f0b48909aba12866() {
  if(issharedfuncdefined("cruise_predator", "registerVO")) {
    [[getsharedfunc("cruise_predator", "registerVO")]]();
  }
}

function function_f06e9c09ab54c2bf() {
  level._effect["predator_pod_break"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion.vfx");
}

function function_328fd4c30cafcce0() {
  if(isDefined(level.var_638c653eda9d1cd3)) {
    function_c0b0a582ff9e4d57(level.var_638c653eda9d1cd3);
  }

  function_c0b0a582ff9e4d57("cruise_color_mp");
  function_c0b0a582ff9e4d57("cruise_color_fog_mp");
  function_c0b0a582ff9e4d57("cruise_intro_shipment");
  function_c0b0a582ff9e4d57(level.mapname + "_cruise_intro");
}

function weapongivencruisepredator(streakinfo) {
  return true;
}

function tryusecruisepredator() {
  streakinfo = createstreakinfo("cruise_predator", self);
  return tryusecruisepredatorfromstruct(streakinfo);
}

function tryusecruisepredatorfromstruct(streakinfo) {
  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, &weapongivencruisepredator);

  if(!istrue(deployresult)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  if(level.gameended) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  thirdperson = getdvarint(@ "hash_b3b0df534800e4d5", 0);

  if(istrue(thirdperson)) {
    streakinfo notify("<dev string:x1c>");
  }

  result = runcruisepredator(streakinfo.streakname, streakinfo, thirdperson);

  if(!istrue(result)) {
    return false;
  }

  return true;
}

function runcruisepredator(streakname, streakinfo, thirdperson) {
  if(isDefined(level.var_b67b5f9dfe488c2f)) {
    thread[[level.var_b67b5f9dfe488c2f]](streakinfo);
  }

  bundle = level.streakglobals.streakbundles["cruise_predator"];
  self disablephysicaldepthoffieldscripting();
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  heightoffset = bundle.var_3d67ec8c5eb61306;

  if(isDefined(heightent)) {
    heightoffset = heightent.origin[2] + bundle.var_c96b6fecdc57b792;
  }

  spawncenterpos = level.mapcenter;
  var_82a6786725452f17 = getdvarint(@ "hash_a2e7d8fdf5d91dd9", bundle.var_8e37beb3647ea7d9);

  if(islargemap() || utility::iscp() || istrue(var_82a6786725452f17)) {
    spawncenterpos = self.origin;
  }

  allenemies = [];
  sumvectors = (0, 0, 0);
  forwardvector = undefined;
  character_array = level.players;

  if(utility::iscp()) {
    character_array = level.characters;

    if(issharedfuncdefined("player", "disable_backpack_inventory")) {
      self[[getsharedfunc("player", "disable_backpack_inventory")]](1);
    }
  }

  foreach(player in character_array) {
    if(player == self) {
      continue;
    }

    if(level.teambased && player.team == self.team) {
      continue;
    }

    sumvectors += player.origin - spawncenterpos;
    allenemies[allenemies.size] = player;
  }

  if(isDefined(sumvectors) && allenemies.size > 0) {
    forwardvector = vectorNormalize(sumvectors / allenemies.size);
    forwardvector *= (1, 1, 0);
  } else {
    randy = randomint(360);
    forwardvector = anglesToForward((0, randy, 0));
  }

  if(issharedfuncdefined("cruise_predator", "directionOverride")) {
    forwardvector = self[[getsharedfunc("cruise_predator", "directionOverride")]](forwardvector);
  }

  missileoffset = spawncenterpos + (0, 0, heightoffset);
  startpos = missileoffset - forwardvector * 3000;
  targetpos = spawncenterpos + (0, 0, int(heightoffset * 0.5));
  missilepod = spawn("script_model", startpos);
  missilepod setModel(bundle.var_2ed8b1bc1fe90ef5);
  missilepod.owner = self;
  missilepod.origin = startpos;
  missilepod.angles = vectortoangles(targetpos - startpos);
  missilepod.type = "remote";
  missilepod.team = self.team;
  missilepod.entitynumber = missilepod getentitynumber();
  missilepod.streakinfo = streakinfo;
  missilepod.duration = 30;
  missilepod.animstate = "pod_flying";
  self.restoreangles = self.angles;

  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]](streakname, missilepod.origin);
  }

  level.rockets[missilepod.entitynumber] = missilepod;
  level.remotemissileinprogress = 1;
  thread playkillstreakoperatordialog(streakname, streakname + "_use", 1, 1.5);

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    [[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_cruise_predator", self);
  }

  result = cruisepredator_followmissilepod(missilepod, targetpos, thirdperson, streakinfo, bundle);

  if(isDefined(result) && !result) {
    function_8b676f496920e2ab();
  }

  return result;
}

function cruisepredator_watchintropoddisown(streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup) {
  self endon("death");
  level endon("game_ended");
  self waittill("disowned");

  if(isDefined(self)) {
    cruisepredator_detachplayerfromintro(streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup);
    self delete();
  }
}

function cruisepredator_detachplayerfromintro(streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup) {
  missileowner = self.owner;

  if(isDefined(missileowner)) {
    missileowner disablephysicaldepthoffieldscripting();
    missileowner visionsetnakedforplayer("", 0);
    missileowner cameraunlink();
    missileowner val::reset_all("cruisePredator");
    missileowner _setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
    missileowner setclientomnvar("ui_predator_missile", 0);
    missileowner painvisionon();
    missileowner killstreak_restorenvgstate();
    missileowner killstreak_setmainvision("");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(missileowner, 0, 0);
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");

  if(isDefined(enemytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(enemytargetmarkergroup);
  }

  if(isDefined(friendlytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(friendlytargetmarkergroup);
  }
}

#using_animtree("script_model");

function cruisepredator_followmissilepod(pod, breakpos, thirdperson, streakinfo, bundle) {
  var_7b7bc27e7e8b05e2 = get_notetrack_time(%mp_cruise_missile_move_intro, "wingtrails");
  var_2cf1418bd3474069 = get_notetrack_time(%mp_cruise_missile_move_intro, "shell_break");
  var_9e0fa77c44b24bf9 = get_notetrack_time(%mp_cruise_missile_move_intro, "second_missile_thruster");
  var_6431d9c900610f5b = get_notetrack_time(%mp_cruise_missile_move_intro, "anim_end");
  stage1delay = var_7b7bc27e7e8b05e2;
  stage2delay = var_2cf1418bd3474069 - var_7b7bc27e7e8b05e2;
  stage3delay = var_9e0fa77c44b24bf9 - var_2cf1418bd3474069;
  stage4delay = var_6431d9c900610f5b - var_9e0fa77c44b24bf9;
  enemytargetmarkergroup = undefined;
  friendlytargetmarkergroup = undefined;

  if(!istrue(thirdperson)) {
    _stopshellshock();
    val::group_set("cruisePredator", 0);
    _setvisibiilityomnvarforkillstreak(streakinfo.streakname, "invisible");
    self setclientomnvar("ui_predator_missile", 1);
    var_2cd52bbc2a67b7cf = [];
    var_ff93381949523976 = [];
    var_2af53266405cd5bc = undefined;

    if(issharedfuncdefined("cruise_predator", "assignTargetMarkers")) {
      var_2af53266405cd5bc = self thread[[getsharedfunc("cruise_predator", "assignTargetMarkers")]](self);
    }

    if(isDefined(var_2af53266405cd5bc.enemytargetmarkergroup)) {
      var_2cd52bbc2a67b7cf = var_2af53266405cd5bc.enemytargetmarkergroup;
    }

    if(isDefined(var_2af53266405cd5bc.friendlytargetmarkergroup)) {
      var_ff93381949523976 = var_2af53266405cd5bc.friendlytargetmarkergroup;
    }

    enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self, var_2cd52bbc2a67b7cf, self, 0, 1, 1);
    friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerfriendly", self, var_ff93381949523976, self, 1, 1);
    thread function_d13d2a81214fbfb8("80_instant_noscale", 1);

    if(isDefined(level.mapname) && issubstr(level.mapname, "mp_shipment")) {
      self visionsetnakedforplayer("cruise_intro_shipment", 0);
    }

    if(function_b039d607d9f90f1a(level.mapname + "_cruise_intro")) {
      self visionsetnakedforplayer(level.mapname + "_cruise_intro", 0);
    }

    self cameralinkTo(pod, "tag_player", 1, 1);
    pod thread cruisepredator_playdofsequence(var_9e0fa77c44b24bf9);
    self painvisionoff();
    killstreak_savenvgstate();
    pod thread cruisepredator_watchintropoddisown(streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup);
    pod thread cruisepredator_watchownerdisownaction("disconnect");
    pod thread cruisepredator_watchownerdisownaction("joined_team");
    pod thread cruisepredator_watchownerdisownaction("joined_spectators");
  }

  podmoveanim = "mp_cruise_missile_move_intro";
  pod scriptmodelplayanimdeltamotion(podmoveanim);
  pod setscriptablepartstate("main_thruster", "on", 0);

  if(!istrue(thirdperson)) {
    pod playsoundtoplayer("iw9_cruise_missile_plr_intro", self);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(stage1delay);

  if(!isDefined(pod)) {
    return false;
  }

  pod setscriptablepartstate("wing_trails", "on");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(stage2delay);

  if(!isDefined(pod)) {
    return false;
  }

  pod.animstate = "pod_break";
  pod setscriptablepartstate("wing_trails", "off");
  pod setscriptablepartstate("main_thruster", "off", 0);
  playFXOnTag(getfx("predator_pod_break"), pod, "tag_missile");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(stage3delay);

  if(!isDefined(pod)) {
    return false;
  }

  pod.animstate = "missile_thrusters";
  pod setscriptablepartstate("sub_thruster", "on", 0);

  if(!isDefined(pod) || !isDefined(self)) {
    return false;
  }

  thread cruisepredator_delayplayslamzoom(stage4delay - 0.15, thirdperson);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(stage4delay - 0.05);

  if(!isDefined(pod) || !isDefined(self)) {
    return false;
  }

  thread cruisepredator_takecontrol(pod, streakinfo, thirdperson, enemytargetmarkergroup, friendlytargetmarkergroup, bundle);
  return true;
}

function cruisepredator_playdofsequence(var_c21a2b0040f7613c) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  self.owner enablephysicaldepthoffieldscripting();
  self.owner setphysicaldepthoffield(1.4, 85, 1000, 1000);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_c21a2b0040f7613c);
  self.owner setphysicaldepthoffield(0.5, 1024, 50, 50);
}

function cruisepredator_takecontrol(pod, streakinfo, thirdperson, enemytargetmarkergroup, friendlytargetmarkergroup, bundle) {
  pod endon("death");
  self endon("disconnect");
  level endon("game_ended");
  pod setscriptablepartstate("sub_thruster", "off", 0);
  val::set("cruisePredatorUse", "allow_movement", 1);
  val::set("cruisePredatorUse", "fire", 1);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  spawndata = spawnStruct();
  spawndata.origin = pod gettagorigin("tag_missile");
  spawndata.angles = pod.angles;
  spawndata.modelname = bundle.var_7d0d5f441724f854;
  spawndata.vehicletype = bundle.deployedvehicle;
  spawndata.targetname = "rcplane";
  spawndata.cannotbesuspended = 1;

  if(iscp()) {
    playerusinggamepad = self usinggamepad();
    spawndata.vehicletype = ter_op(playerusinggamepad, "veh_cruise_predator_cp_jup", "veh_cruise_predator_cp_jup_kbm");
  }

  faildata = spawnStruct();
  missile = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, faildata);

  if(!isDefined(missile)) {
    thread scripts\engine\utility::error("<dev string:x43>");

    return;
  }

  if(issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    missile[[getsharedfunc("killstreak", "killstreakMakeVehicle")]](streakinfo.streakname);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(missile);
  streakinfo.shots_fired++;
  missile setCanDamage(0);
  missile setotherent(self);
  missile setentityowner(self);
  missile.angles = spawndata.angles;
  missile.team = self.team;
  missile.owner = self;
  missile.streakinfo = streakinfo;
  missile.lifetime = bundle.var_9c82b96f3edb0742;
  missile.weapon_name = bundle.projectileweapon;
  missile.enemytargetmarkergroup = enemytargetmarkergroup;
  missile.friendlytargetmarkergroup = friendlytargetmarkergroup;
  missile setscriptablepartstate("warhead_thruster", "on", 0);
  level thread function_ee93617532d8a679(missile, self, undefined, undefined, 1);
  missile setvehicleteam(missile.team);

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    missile[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", self, 0, 1, 50);
  }

  missile.killcament = spawn("script_model", missile gettagorigin("tag_player"));
  missile.killcament setModel("tag_origin");
  missile.killcament linkTo(missile, "tag_player");
  missile endon("death");
  missile scripts\cp_mp\emp_debuff::set_apply_emp_callback(&cruisepredator_empapplied);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    missile[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&cruisepredator_empapplied);
  }

  fxent = spawn("script_model", missile gettagorigin("tag_fx"));
  fxent setModel(bundle.var_41977faa6601cc3c);
  fxent.angles = missile gettagangles("tag_fx");
  fxent.team = missile.team;
  fxent.owner = missile.owner;
  fxent.streakinfo = missile.streakinfo;
  fxent linkTo(missile, "tag_fx");
  fxent setscriptablepartstate("fake_trail", "on", 0);
  fxent setotherent(self);
  fxent thread cruisepredator_watchgameend(missile, thirdperson, streakinfo);
  fxent thread cruisepredator_watchmissileinfo(missile);
  fxent thread cruisepredator_watchmissileexplosion(missile, self, missile.killcament, thirdperson, enemytargetmarkergroup, friendlytargetmarkergroup, bundle);
  missile thread cruisepredator_watchownerdisownaction("disconnect");
  missile thread cruisepredator_watchownerdisownaction("joined_team");
  missile thread cruisepredator_watchownerdisownaction("joined_spectators");

  if(!istrue(thirdperson)) {
    self visionsetnakedforplayer("", 0);
    killstreak_setmainvision("");
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(!istrue(thirdperson)) {
    self disablephysicaldepthoffieldscripting();
    self cameraunlink();
    thread function_d13d2a81214fbfb8("default");
    self cameralinkTo(missile, "tag_player", 1);
    self usevehicle(missile, 0);
    missilevisionset = "cruise_color_mp";

    if(isDefined(level.mapname) && (issubstr(level.mapname, "mp_shipment") || issubstr(level.mapname, "mp_skerries"))) {
      missilevisionset = "cruise_color_fog_mp";
    }

    killstreak_setmainvision(missilevisionset);

    if(isDefined(level.var_638c653eda9d1cd3)) {
      self.currentvisionset = level.var_638c653eda9d1cd3;
    } else {
      self.currentvisionset = "cruise_color_mp";
    }

    killstreak_setmainvision(self.currentvisionset);
    self.soundent = spawn("script_origin", missile.origin);
    self.soundent showonlytoplayer(self);
    self.soundent playLoopSound("iw9_cruise_missile_plr");
    _shellshock("killstreak_veh_camera_mp", "top", missile.lifetime, 0);
    _setvisibiilityomnvarforkillstreak(streakinfo.streakname, "on");
    self setclientomnvar("ui_predator_missile", 2);
    self setclientomnvar("ui_killstreak_health", 1);
    self setclientomnvar("ui_killstreak_countdown", gettime() + int(10000));
    self setclientomnvar("ui_predator_missiles_left", -1);

    if(function_ecc973ad47944e1e()) {
      var_e8bedfce1e0c7d2 = function_44e0bd95b98288ab();
      killstreak_setmainvision(var_e8bedfce1e0c7d2);
      setthermalvision(1, 12, 1500);
      _shellshock("killstreak_veh_camera_flir_mp", "top", missile.lifetime, 0);
    }
  }

  missile thread cruisepredator_delaymissilecollision();
  randomindex = randomintrange(1, 3);
  missile thread cruisepredator_watchtimer(self, bundle.var_9c82b96f3edb0742);

  if(issharedfuncdefined("killstreak", "makePlayerVulnerableOnCruisePredatorDetonate")) {
    self thread[[getsharedfunc("killstreak", "makePlayerVulnerableOnCruisePredatorDetonate")]](missile);
  }

  waitframe();

  if(isDefined(pod)) {
    pod delete();
  }
}

function cruisepredator_watchkillborder() {
  if(!isDefined(level.kill_border_triggers)) {
    self.owner iprintln("<dev string:x95>");

    return;
  }

  self endon("death");
  self endon("cruise_missile_explode");

  while(true) {
    if(cruisepredator_istouchingkillborder(level.kill_border_triggers)) {
      self notify("explode");
      break;
    }

    waitframe();
  }
}

function cruisepredator_istouchingkillborder(triggerlist) {
  touchingtrigger = 0;

  foreach(trigger in triggerlist) {
    if(self istouching(trigger)) {
      touchingtrigger = 1;
      break;
    }
  }

  return touchingtrigger;
}

function cruisepredator_delaymissilecollision() {
  self endon("death");
  self endon("cruise_missile_explode");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.75);
  self vehphys_enablecollisioncallback(1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.25);
  thread cruisepredator_watchkillborder();
}

function cruisepredator_watchgameend(missile, thirdperson, streakinfo) {
  missile endon("death");
  missile endon("cruise_missile_explode");
  self endon("death");
  self.owner endon("disconnect");
  level waittill_any_2("start_game_ended", "game_ended");
  missile notify("cruise_missile_force_eject");
  rider = self.owner;

  if(isDefined(missile.enemytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(missile.enemytargetmarkergroup);
  }

  if(isDefined(missile.friendlytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(missile.friendlytargetmarkergroup);
  }

  if(issharedfuncdefined("cruise_predator", "CPUnMarkEnemies")) {
    [[getsharedfunc("cruise_predator", "CPUnMarkEnemies")]](rider);
  }

  if(isDefined(rider)) {
    if(!istrue(thirdperson)) {
      rider cameraunlink();
      rider leavevehicle();

      if(isDefined(rider.soundent)) {
        rider.soundent stoploopsound("iw9_cruise_missile_plr");
        rider.soundent delete();
      }
    }

    rider _setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
    rider setclientomnvar("ui_predator_missile", 0);
    rider thread cruisepredator_returnplayer(streakinfo);

    if(issharedfuncdefined("cruise_predator", "removeItemFromSlot")) {
      [[getsharedfunc("cruise_predator", "removeItemFromSlot")]](rider);
    }
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(missile);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(missile);
}

function cruisepredator_watchmissileinfo(missile) {
  self endon("death");

  while(true) {
    self.missilelastpos = missile.origin;
    self.missilelastangle = missile.angles;
    waitframe();
  }
}

function cruisepredator_watchmissileexplosion(missile, rider, killcament, thirdperson, enemytargetmarkergroup, friendlytargetmarkergroup, bundle) {
  missile endon("cruise_missile_force_eject");
  missilekillcament = killcament;
  explodepos = undefined;
  missileangles = undefined;
  streakinfo = missile.streakinfo;
  explodeinfo = undefined;

  while(true) {
    explodeinfo = missile function_51afe751c1e36723("collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked");

    if(isDefined(explodeinfo.msg) && explodeinfo.msg == "collision") {
      surface = physics_getsurfacetypefromflags(explodeinfo.param4);
      surfacetype = getsubstr(surface["name"], 9);
      collisiondebug = getdvarint(@ "hash_c2491ce0fa8bc62", 0);

      if(collisiondebug) {
        iprintln("<dev string:xb8>" + surfacetype);
        continue;
      }

      if(surfacetype == "glass_pane") {
        continue;
      }
    }

    break;
  }

  if(isDefined(missile)) {
    missile setscriptablepartstate("warhead_thruster", "off", 0);
    missile notify("cruise_missile_explode");
  }

  if(isDefined(enemytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(enemytargetmarkergroup);
  }

  if(isDefined(friendlytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(friendlytargetmarkergroup);
  }

  if(issharedfuncdefined("cruise_predator", "CPUnMarkEnemies")) {
    [[getsharedfunc("cruise_predator", "CPUnMarkEnemies")]](rider);
  }

  if(isDefined(self)) {
    self setscriptablepartstate("fake_trail", "off", 0);
    thread function_1a20d385b2f41e0e();
    explodepos = self.missilelastpos;
    missileangles = self.missilelastangle;

    if(isDefined(rider) && !istrue(thirdperson)) {
      rider cameraunlink();
      rider leavevehicle();
    }

    if(isDefined(missile)) {
      scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(missile);
      scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(missile);
    }

    if(!isDefined(explodeinfo) || explodeinfo.msg != "emp_defused" && explodeinfo.msg != "trophy_blocked") {
      explosionradius = bundle.var_b62ab6436ce0bb7a;
      var_5d28f39073721e59 = "MOD_EXPLOSIVE";
      var_23f8c678bd9d023e = bundle.projectileweapon;

      if(isDefined(rider)) {
        skipdamage = isDefined(explodeinfo) && explodeinfo.msg == "disowned";

        if(!istrue(skipdamage)) {
          self radiusdamage(explodepos, explosionradius, bundle.var_560307d157b4b4f2, bundle.var_55dff1d1578e3cd8, rider, var_5d28f39073721e59, var_23f8c678bd9d023e);
        }

        players = utility::playersinsphere(explodepos, explosionradius);

        foreach(player in players) {
          if(player _isalive() && playersareenemies(player, rider)) {
            if(issharedfuncdefined("sound", "trySayLocalSound")) {
              level thread[[getsharedfunc("sound", "trySayLocalSound")]](player, #"bc_flavor_player_closecall", undefined, 1);
            }
          }
        }
      }

      if(isDefined(level.var_ca1a76fbc0ba0bef)) {
        thread[[level.var_ca1a76fbc0ba0bef]](self.streakinfo, self.origin, 0);
      }
    }

    if(issharedfuncdefined("shellshock", "artillery_earthQuake")) {
      [[getsharedfunc("shellshock", "artillery_earthQuake")]](explodepos);
    }

    thread cruisepredator_handlevfxstates(explodeinfo);
  }

  if(issharedfuncdefined("cruise_predator", "eventRecord")) {
    [[getsharedfunc("cruise_predator", "eventRecord")]](explodepos);
  }

  if(isDefined(rider)) {
    rider thread cruisepredator_watchkills(explodeinfo);

    if(!istrue(thirdperson)) {
      assertex(isDefined(explodepos) && isDefined(missileangles), "cruisePredator_watchMissileExplosion: Either the explodePos or missileAngles are undefined.This shouldn't be possible.");

      if(isDefined(rider.soundent)) {
        rider.soundent stoploopsound("iw9_cruise_missile_plr");
        rider.soundent delete();
      }

      rider _setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
      rider setclientomnvar("ui_predator_missile", 0);

      if(function_ecc973ad47944e1e()) {
        rider setthermalvision(0);
      }

      if(isDefined(level.var_f56a88761038798b)) {
        thread[[level.var_f56a88761038798b]](streakinfo);
      }

      visionset = "killstreak_static";
      rider thread cruisepredator_startfadecamtransition(0.4, 0.6, 0.05, visionset);
      rider playlocalsound("iw9_cruise_missile_exp_static");
      rider earthquakeforplayer(0.3, 3.5, rider.origin, 100);
      rider setclientomnvar("ui_hud_shake", 1);
      rider playrumbleonpositionforclient("artillery_rumble", rider.origin);
      rider thread cruisepredator_returnplayer(streakinfo, 1);
    }
  }

  if(issharedfuncdefined("cruise_predator", "removeItemFromSlot")) {
    [[getsharedfunc("cruise_predator", "removeItemFromSlot")]](rider);
  }

  wait 1.5;
}

function function_1a20d385b2f41e0e() {
  level endon("game_ended");
  minimapid = undefined;

  if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
    minimapid = self[[scripts\engine\utility::getsharedfunc("game", "createObjective")]]("icon_minimap_cruisemissile", self.team, undefined, 1, undefined, "icon_large");
  }

  wait 2;

  if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
    [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](minimapid);
  }
}

function cruisepredator_cameramove(targetpos, startpos) {
  self moveTo(targetpos, 0.2, 0, 0.05);
  wait 0.15;
  self moveTo(targetpos + vectorNormalize(startpos - targetpos) * 24, 2);
}

function cruisepredator_returnplayer(streakinfo, exploded) {
  self endon("disconnect");
  level callback::callback("killstreak_finish_use", {
    #streakinfo: streakinfo
  });

  if(issharedfuncdefined("player", "disable_backpack_inventory")) {
    self[[getsharedfunc("player", "disable_backpack_inventory")]](0);
  }

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](streakinfo);
  }

  level thread restorekillstreakplayerangles(self);

  if(istrue(exploded)) {
    wait 0.5;
  }

  function_8b676f496920e2ab();
  killstreak_setmainvision("");
  self painvisionon();
  killstreak_restorenvgstate();
  val::group_reset("cruisePredator");
  val::reset_all("cruisePredatorUse");
  streakinfo notify("killstreak_finished_with_deploy_weapon");
  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

function cruisepredator_watchtimer(rider, lifetime) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(lifetime);
  self notify("explode", self.origin);
}

function cruisepredator_watchownerdisownaction(action) {
  self endon("death");
  self endon("disowned");
  level endon("game_ended");
  missileowner = self.owner;
  missileowner waittill(action);
  self notify("disowned");
}

function cruisepredator_startexplodecamtransition() {
  killstreak_setmainvision("killstreak_slamzoom");
  wait 0.1;
  killstreak_setmainvision("");
}

function cruisepredator_startfadecamtransition(fadeintime, fadedelay, fadeouttime, var_2007ede6118d6b9f) {
  self endon("disconnect");

  if(!isDefined(fadeintime)) {
    fadeintime = 0.5;
  }

  if(!isDefined(fadedelay)) {
    fadedelay = 0.5;
  }

  if(!isDefined(fadeouttime)) {
    fadeouttime = 0.05;
  }

  if(isDefined(var_2007ede6118d6b9f)) {
    killstreak_setmainvision(var_2007ede6118d6b9f);
    wait fadedelay;
    killstreak_setmainvision("");
    return;
  }

  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, fadeintime);
  wait fadedelay;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, fadeouttime);
}

function cruisepredator_shakerider(shaketime) {
  self endon("disconnect");
  counter = 0;

  while(counter < shaketime) {
    self playrumbleonpositionforclient("damage_light", self.origin);
    counter += 0.05;
    wait 0.05;
  }
}

function cruisepredator_handlevfxstates(explodeinfo) {
  self endon("death");
  self unlink();

  if(!isDefined(explodeinfo) || explodeinfo.msg == "explode" || explodeinfo.msg == "disowned" || explodeinfo.msg == "emp_defused" || explodeinfo.msg == "trophy_blocked") {
    self setscriptablepartstate("air_explosion", "on", 0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.2);
    self delete();
  }

  worldup = (0, 0, 1);
  surfacenormal = explodeinfo.param6;
  self.angles = vectortoangles(surfacenormal);
  angledirection = vectordot(surfacenormal, worldup);

  if(angledirection >= 0.7) {
    self setscriptablepartstate("ground_explosion", "on", 0);
  } else {
    self setscriptablepartstate("air_explosion", "on", 0);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self delete();
}

function cruisepredator_watchkills(explodeinfo) {
  self endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(isDefined(self) && isDefined(self.recentkillcount)) {
    if(self.recentkillcount >= 1) {
      playkillstreakoperatordialog("cruise_predator", "cruise_predator" + "_hit_target", 1);
      return;
    }

    playkillstreakoperatordialog("cruise_predator", "cruise_predator" + "_miss_target", 1);
  }
}

function cruisepredator_delayplayslamzoom(delaytime, thirdperson) {
  self endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);

  if(!istrue(thirdperson)) {
    killstreak_setmainvision("killstreak_slamzoom");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.2);
    wait 0.2;
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0);
  }
}

function cruisepredator_empapplied(data) {
  if(isDefined(self)) {
    self notify("emp_defused");
  }
}

function function_ecc973ad47944e1e() {
  return isnightmap() || level.mapname == "mp_jup_grandprix_pm_2";
}