/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\killstreaks\white_phosphorus.gsc
*************************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace white_phosphorus;

function init() {
  if(issharedfuncdefined("white_phosphorus", "init")) {
    [[getsharedfunc("white_phosphorus", "init")]]();
  }

  level.activewpzones = [];
  level.activewpinnerzones = [];
  level.white_phosphorus_damage_area = getEnt("white_phosphorus_damage", "targetname");

  setdevdvarifuninitialized(@ "hash_b72a0bb47130fb8e", 0);
  setdevdvarifuninitialized(@ "hash_e33914719b665fca", 30);
  setdevdvarifuninitialized(@ "hash_51c63714caa01867", 0);
  setdevdvarifuninitialized(@ "hash_1aff95d5bc69c60f", 0);
}

function weapongivenwp(streakinfo) {
  if(istrue(level.wpinprogress)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/WP_ACTIVE");
    }

    return false;
  }

  if(issharedfuncdefined("white_phosphorus", "startMapSelectSequence")) {
    self[[getsharedfunc("white_phosphorus", "startMapSelectSequence")]](0, 1, "long_arrow");
  }

  return true;
}

function tryusewp() {
  streakinfo = createstreakinfo("white_phosphorus", self);
  return tryusewpfromstruct(streakinfo);
}

function tryusewpfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  deployweaponobj = makeweapon("ks_remote_map_mp");
  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, deployweaponobj, 1, &weapongivenwp);

  if(!istrue(deployresult)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  mappointinfo = wp_getmapselectioninfo(streakinfo, 1, 1);

  if(!isDefined(mappointinfo)) {
    return false;
  }

  thread wp_startdeploy(mappointinfo, streakinfo);
  var_52a5be2e2f91d710 = undefined;

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    var_52a5be2e2f91d710 = 2;
  }

  thread playkillstreakoperatordialog("white_phosphorus", "use_" + streakinfo.streakname, 1, var_52a5be2e2f91d710);

  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]]("white_phosphorus", self.origin);
  }

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_white_phosphorus", self);
  }

  return true;
}

function wp_getmapselectioninfo(streakinfo, numselection, directionalselection) {
  val::set("map_selection", "weapon_switch", 0);
  self setsoundsubmix("mp_killstreak_overlay");
  mappointinfo = undefined;

  if(issharedfuncdefined("white_phosphorus", "getSelectMapPoint")) {
    mappointinfo = self[[getsharedfunc("white_phosphorus", "getSelectMapPoint")]](streakinfo, numselection, directionalselection);
  }

  if(!isDefined(mappointinfo)) {
    val::reset_all("map_selection");
    self clearsoundsubmix("mp_killstreak_overlay");
    return undefined;
  }

  val::reset_all("map_selection");
  self clearsoundsubmix("mp_killstreak_overlay");
  return mappointinfo;
}

function wp_startdeploy(mappointinfo, streakinfo) {
  self endon("disconnect");
  level endon("game_ended");

  if(istrue(level.wpinprogress)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/WP_ACTIVE");
    }

    return 0;
  }

  level.wpinprogress = 1;

  foreach(pointinfo in mappointinfo) {
    mappoint = pointinfo.location;
    directionyaw = pointinfo.angles;
    wp_finishdeployment(mappoint, directionyaw, streakinfo);

    if(mappointinfo.size > 1 && deployindex < mappointinfo.size - 1) {
      wait randomfloatrange(1, 3);
    }
  }
}

function wp_finishdeployment(droplocation, dropdirection, streakinfo) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  thread wp_watchdisownaction("disconnect");
  thread wp_watchdisownaction("joined_team");
  thread wp_watchdisownaction("joined_spectator");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  deployplane = wp_createplane(droplocation, dropdirection, streakinfo);

  if(!isDefined(deployplane)) {
    assertmsg("White Phosphorus ( wp_finishDeployment ): Could not create plane.This should not happen!");
    return 0;
  }

  deployplane thread wp_watchplanedisowned();
  deployplane thread wp_deliverpayloads(streakinfo);
}

function wp_createplane(droppointorigin, planedirectionyaw, streakinfo) {
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  planehalfdistance = 28000;
  planeflyspeed = 5000;
  planeflyheight = 2500;
  var_361663d437db22f5 = 1500;
  planedirection = (0, planedirectionyaw, 0);

  if(!isDefined(heightent)) {
    assertmsg("NO DEFINED AIRSTRIKE HEIGHT SCRIPT_ORIGIN IN LEVEL");
    planeflyheight += 3000;
  } else {
    planeflyheight = heightent.origin[2] + 3000;
    var_361663d437db22f5 = scripts\cp_mp\killstreaks\airstrike::getexplodedistance(planeflyheight);
  }

  flightpath = scripts\cp_mp\killstreaks\airstrike::getflightpath(droppointorigin, planedirection, planehalfdistance, heightent, planeflyheight, planeflyspeed, var_361663d437db22f5);
  plane = spawn("script_model", flightpath["startPoint"]);
  plane.angles = planedirection;
  plane.flightpath = flightpath;
  plane.owner = self;
  plane.team = self.team;
  plane.streakinfo = streakinfo;
  plane.speed = planeflyspeed;
  planemodel = "veh9_mil_air_suniform25_mp";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(self)) {
    planemodel = "veh9_mil_air_suniform25_mp";
  }

  plane setModel(planemodel);
  minimapid = undefined;
  createfunc = undefined;

  if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
    createfunc = scripts\engine\utility::getsharedfunc("game", "createObjective");
  }

  if(isDefined(createfunc)) {
    minimapid = plane[[createfunc]]("icon_minimap_wp", plane.team, 1, 1, 1);
    plane.minimapid = minimapid;
  }

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    plane[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](plane.streakinfo.streakname, "Killstreak_Air", self);
  }

  return plane;
}

function wp_watchdisownaction(action, deployplane) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  self waittill(action);
  level.wpinprogress = undefined;
  level notify("white_phosphorus_end");
}

function wp_watchplanedisowned() {
  self endon("death");
  level waittill("white_phosphorus_end");
  wp_removeplane(self);
}

function wp_watchforsmokedisowned() {
  self endon("death");
  level waittill("white_phosphorus_end");

  if(wp_isactivewpzone("smoke", self)) {
    level wp_removefromactivewplist("smoke", self);
    return;
  }

  wpspawntype = 0;

  wpspawntype = getdvarint(@ "hash_1aff95d5bc69c60f", 0);

  if(wpspawntype) {
    self freescriptable();
    return;
  }

  self delete();
}

function wp_watchforflaredisowned(effecttype) {
  self endon("death");
  level waittill("white_phosphorus_end");

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(wp_isactivewpzone("inner", self)) {
    level wp_removefromactivewplist("inner", self, effecttype, 1);
  }

  self notify("stop_wp_status_effect");
  wpspawntype = 0;

  wpspawntype = getdvarint(@ "hash_1aff95d5bc69c60f", 0);

  if(wpspawntype) {
    self freescriptable();
    return;
  }

  self delete();
}

function wp_deliverpayloads(streakinfo) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  flightstart = self.flightpath["startPoint"];
  flightgoal = self.flightpath["endPoint"];
  flighttime = self.flightpath["flyTime"];
  var_924d800be62c4e51 = flightstart + anglesToForward(self.angles) * 12500;
  var_aad5bb2395b29d70 = flightgoal - anglesToForward(self.angles) * 12500;
  var_c2deffe4aba8fa7c = length(var_924d800be62c4e51 - var_aad5bb2395b29d70);
  payloadlifetime = 30;

  payloadlifetime = getdvarint(@ "hash_e33914719b665fca", 30);
  debugpayload = getdvarint(@ "hash_b72a0bb47130fb8e", 0);

  if(debugpayload) {
    line(flightstart, flightgoal, (1, 1, 1), 1, 0, payloadlifetime * 30);
  }

  self.owner thread wp_watchend(streakinfo, payloadlifetime);
  self.owner thread wp_watchgameend(streakinfo);
  self moveTo(flightgoal, flighttime);
  self setscriptablepartstate("bodyFX", "on", 0);
  self scriptmodelplayanim("mp_suniform25_flyin");
  thread wp_enterpayloadaudio();
  thread wp_exitpayloadaudio(flightgoal, flighttime);
  var_e9727e658ca8dfd2 = 3;

  var_d37001da25f53f68 = getdvarint(@ "hash_51c63714caa01867", 0);

  if(var_d37001da25f53f68) {
    var_e9727e658ca8dfd2 = 1;
  }

  wp_handlepayloadtyperelease(&wp_fireairburst, flightstart, var_924d800be62c4e51, var_c2deffe4aba8fa7c, payloadlifetime, 4000, var_e9727e658ca8dfd2, 1);
  wp_handlepayloadtyperelease(&wp_firesmoke, flightstart, var_924d800be62c4e51, var_c2deffe4aba8fa7c, payloadlifetime, 4000, 3, 1);
  wp_handlepayloadtyperelease(&wp_fireflaregroup, flightstart, var_924d800be62c4e51, var_c2deffe4aba8fa7c, payloadlifetime, 2000, 6, 2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(flighttime);
  self stopsounds();
  self scriptmodelplayanimdeltamotion("mp_suniform25_exit");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5.33);
  wp_removeplane(self);
}

function wp_watchend(streakinfo, payloadlifetime) {
  self endon("disconnect");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(payloadlifetime);
  self notify("white_phosphorus_finished");
  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

function wp_watchgameend(streakinfo) {
  self endon("disconnect");
  self endon("white_phosphorus_finished");
  level endon("white_phosphorus_end");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

function wp_enterpayloadaudio() {
  self endon("death");
  level endon("white_phosphorus_end");
  waitframe();
  self playsoundonmovingent("iw8_mp_white_phos_su25_flyby");
}

function wp_exitpayloadaudio(flightgoal, flighttime) {
  self endon("death");
  level endon("white_phosphorus_end");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(flighttime);
  playsoundatpos(flightgoal, "iw8_mp_white_phos_su25_exit");
}

function wp_watchunsuccessfulzones(var_eb34677262fed134) {
  level endon("wp_zone_succeeded");
  level endon("game_ended");

  for(var_cf6d87d10fa26355 = 0; var_cf6d87d10fa26355 < var_eb34677262fed134; var_cf6d87d10fa26355++) {
    level waittill("wp_zone_failed");
  }

  level.wpinprogress = undefined;
}

function wp_handlepayloadtyperelease(var_fab341cde0f5a8a4, var_3e69f8d86497745d, var_ec975df40affb201, var_985ed30dff21f18c, payloadlifetime, var_624c6f581e3a3784, var_f5c59be7baf53b36, var_3c6798c87677a9c3) {
  var_bebe0d78a71db256 = int(var_985ed30dff21f18c / var_624c6f581e3a3784);
  var_d0bb190b577957f4 = 0;

  if(!isDefined(var_f5c59be7baf53b36)) {
    var_f5c59be7baf53b36 = var_bebe0d78a71db256;
  } else {
    payloaddiff = var_bebe0d78a71db256 - var_f5c59be7baf53b36;
    var_d0bb190b577957f4 = int(payloaddiff / 2);
  }

  if(isDefined(var_3c6798c87677a9c3)) {
    var_d0bb190b577957f4 += var_3c6798c87677a9c3;
  }

  payloadforward = anglesToForward(self.angles);
  var_6622bf241e83cb33 = var_ec975df40affb201;
  var_b75ca07ccc1468b5 = 0;

  for(i = 0; i < var_bebe0d78a71db256; i++) {
    var_b540fedd1d9812f4 = length(var_3e69f8d86497745d - var_6622bf241e83cb33) / self.speed;

    if(i < var_d0bb190b577957f4) {
      var_6622bf241e83cb33 += payloadforward * var_624c6f581e3a3784;
      continue;
    }

    var_5e4b11a3dbe28124 = var_6622bf241e83cb33 - (0, 0, 2000);

    if(var_fab341cde0f5a8a4 == &wp_fireflaregroup) {
      killcament = spawn("script_model", var_3e69f8d86497745d + (0, 0, 1500));
      killcament thread wp_movekillcam(var_b540fedd1d9812f4, var_5e4b11a3dbe28124, payloadforward, payloadlifetime);
      self thread[[var_fab341cde0f5a8a4]](var_5e4b11a3dbe28124, payloadforward, var_b540fedd1d9812f4, killcament);
    } else if(var_fab341cde0f5a8a4 == &wp_firesmoke) {
      self thread[[var_fab341cde0f5a8a4]](var_5e4b11a3dbe28124, payloadforward, var_b540fedd1d9812f4, i);
    } else {
      self thread[[var_fab341cde0f5a8a4]](var_5e4b11a3dbe28124, payloadforward, var_b540fedd1d9812f4);
    }

    var_6622bf241e83cb33 += payloadforward * var_624c6f581e3a3784;
    var_b75ca07ccc1468b5++;

    if(var_b75ca07ccc1468b5 == var_f5c59be7baf53b36) {
      break;
    }
  }
}

function wp_movekillcam(movetime, endpos, killcamforward, payloadlifetime) {
  self endon("death");
  endpos -= killcamforward * 3500;
  var_1f67f5e7a912ee6d = endpos - killcamforward * 1000;
  self moveTo(endpos, movetime + 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(movetime + 2);
  self moveTo(var_1f67f5e7a912ee6d, 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(payloadlifetime);
  self delete();
}

function wp_testpayloads(testpos, testangles, testdelaytime) {
  self endon("death");

  payloadlifetime = getdvarint(@ "hash_e33914719b665fca", 30);
  debugpayload = getdvarint(@ "hash_b72a0bb47130fb8e", 0);

  if(debugpayload) {
    sphere(testpos, 50, (1, 1, 1), 0, payloadlifetime * 30);
    line(testpos, testpos - (0, 0, 5000), (1, 1, 1), 1, 0, payloadlifetime * 30);
  }
}

function wp_fireairburst(var_2d7a2733c414e4df, var_db855e6ae67f1a7f, var_854bddfcc12bbc97) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_89c07a70b638fdd = var_2d7a2733c414e4df - var_db855e6ae67f1a7f * 3000;
  soundorigin = var_2d7a2733c414e4df - var_db855e6ae67f1a7f * 2000;
  payloadlifetime = 30;

  payloadlifetime = getdvarint(@ "hash_e33914719b665fca", 30);
  debugpayload = getdvarint(@ "hash_b72a0bb47130fb8e", 0);

  if(debugpayload) {
    sphere(var_89c07a70b638fdd, 100, (0, 1, 1), 0, payloadlifetime * 30);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_854bddfcc12bbc97);
  playFX(getfx("white_phosphorus_inair_explosion"), var_89c07a70b638fdd, var_db855e6ae67f1a7f);
  playsoundatpos(soundorigin, "iw8_mp_white_phos_midair_explo");
}

function wp_firesmoke(smokelaunchpos, var_29c782c334f31ff1, smokedelaytime, smokezoneindex) {
  level endon("white_phosphorus_end");
  level endon("game_ended");

  if(!isDefined(self.playersininitialsmokerange)) {
    self.playersininitialsmokerange = [];
  }

  if(!isDefined(self.playersoutsideinitialsmokerange)) {
    self.playersoutsideinitialsmokerange = [];
  }

  var_d1e8f547be452b54 = 1;

  if(islargemap() && level.gametype != "arm" && level.gametype != "conflict") {
    var_d1e8f547be452b54 = 0;
  }

  if(issharedfuncdefined("white_phosphorus", "fullMapCoverageOverride")) {
    var_d1e8f547be452b54 = [[getsharedfunc("white_phosphorus", "fullMapCoverageOverride")]]();
  }

  shottrace = ray_trace(smokelaunchpos, smokelaunchpos - (0, 0, 10000));
  var_34d5e8b89a1586d3 = shottrace["position"];
  payloadlifetime = 30;

  payloadlifetime = getdvarint(@ "hash_e33914719b665fca", 30);
  debugpayload = getdvarint(@ "hash_b72a0bb47130fb8e", 0);

  if(debugpayload) {
    sphere(smokelaunchpos, 200, (1, 1, 0), 0, payloadlifetime * 30);
  }

  if(issharedfuncdefined("white_phosphorus", "getPayloadLifetimeOverride")) {
    payloadlifetime = [[getsharedfunc("white_phosphorus", "getPayloadLifetimeOverride")]]();
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(smokedelaytime);
  wpspawntype = 0;

  wpspawntype = getdvarint(@ "hash_1aff95d5bc69c60f", 0);

  if(issharedfuncdefined("white_phosphorus", "getWpSpawnType")) {
    wpspawntype = [[getsharedfunc("white_phosphorus", "getWpSpawnTypeOverride")]]();
  }

  if(wpspawntype) {
    var_6b5d366f98ba252b = spawnscriptable("ks_white_phosphorus_mp_p", var_34d5e8b89a1586d3, self.angles);
  } else {
    var_6b5d366f98ba252b = spawn("script_model", var_34d5e8b89a1586d3);
    var_6b5d366f98ba252b setModel("ks_white_phosphorus_mp");
    var_6b5d366f98ba252b setentityowner(self.owner);
  }

  var_6b5d366f98ba252b.team = self.team;
  var_6b5d366f98ba252b.owner = self.owner;
  var_6b5d366f98ba252b.streakinfo = self.streakinfo;
  var_6b5d366f98ba252b thread wp_watchforsmokedisowned();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  level thread wp_playimpactsound(var_6b5d366f98ba252b);

  if(istrue(var_d1e8f547be452b54)) {
    var_f43a453571b50e3d = isDefined(smokezoneindex) && smokezoneindex == 3;

    if(istrue(var_f43a453571b50e3d)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
      self.playersininitialsmokerange = utility::playersincylinder(var_34d5e8b89a1586d3, 2000);
      self.playersoutsideinitialsmokerange = array_difference(level.players, self.playersininitialsmokerange);
      var_6b5d366f98ba252b thread wp_watchdisorienteffect(2000, self.playersininitialsmokerange, self.playersoutsideinitialsmokerange);
    }
  } else {
    if(isnightmap()) {
      var_6b5d366f98ba252b setscriptablepartstate("smoke_night", "on", 0);
    } else {
      var_6b5d366f98ba252b setscriptablepartstate("smoke", "on", 0);
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
    var_6b5d366f98ba252b thread wp_watchdisorienteffect(2000, var_d1e8f547be452b54);

    debugpayload = getdvarint(@ "hash_b72a0bb47130fb8e", 0);

    if(debugpayload) {
      sphere(var_6b5d366f98ba252b.origin, 2000, (1, 1, 0), 0, payloadlifetime * 24);
    }
  }

  level wp_addtoactivewplist("smoke", var_6b5d366f98ba252b);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(payloadlifetime);
  level wp_removefromactivewplist("smoke", var_6b5d366f98ba252b);
}

function wp_fireflaregroup(flarelaunchpos, var_47aae5e47f9b546c, flaredelaytime, killcament) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  flareowner = self.owner;
  flareteam = self.team;
  var_d2ddc5d6ab4565e2 = self.angles;
  shottrace = ray_trace(flarelaunchpos, flarelaunchpos - (0, 0, 10000), self, undefined, 1, 1);
  var_34d5e8b89a1586d3 = shottrace["position"];
  shotsurface = shottrace["surfacetype"];
  damageareaexists = isDefined(level.white_phosphorus_damage_area);

  if(istrue(damageareaexists)) {
    level.white_phosphorus_damage_area dontinterpolate();
    level.white_phosphorus_damage_area.owner = flareowner;
    level.white_phosphorus_damage_area.team = flareteam;
    level.white_phosphorus_damage_area.streakinfo = self.streakinfo;
  }

  payloadlifetime = 30;

  payloadlifetime = getdvarint(@ "hash_e33914719b665fca", 30);

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(flaredelaytime);
  flarepositions = wp_getflarepositions(flarelaunchpos, var_34d5e8b89a1586d3, 4, int(250));

  foreach(struct in flarepositions) {
    wpspawntype = 0;

    wpspawntype = getdvarint(@ "hash_1aff95d5bc69c60f", 0);

    if(wpspawntype) {
      flare = spawnscriptable("ks_white_phosphorus_mp_p", struct.flareorigin, var_d2ddc5d6ab4565e2);
    } else {
      flare = spawn("script_model", struct.flareorigin);
      flare setModel("ks_white_phosphorus_mp");
      flare setentityowner(flareowner);
      flare.angles = var_d2ddc5d6ab4565e2;
    }

    flare.owner = flareowner;
    flare.team = flareteam;
    flare.streakinfo = self.streakinfo;
    flare.struct = struct;
    flare.weapon_name = "white_phosphorus_proj_mp";
    flare.killcament = killcament;
    flare thread wp_watchforflaredisowned("burn");
    flare thread wp_projwatchimpact(payloadlifetime, "burn", shotsurface);
    wait randomfloatrange(0.1, 0.4);
  }

  if(istrue(damageareaexists)) {
    level.white_phosphorus_damage_area.origin = (0, 0, 50000);
  }
}

function wp_getflarepositions(launchpos, impactcenterpos, numpoints, var_fcdcc201ce6e652e) {
  flarepoints = [];
  var_6f680ee249f67b0d = self.angles * (0, 1, 0);
  planeforward = anglesToForward(var_6f680ee249f67b0d);
  planeright = anglestoright(var_6f680ee249f67b0d);
  contents = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  contentoverride = physics_createcontents(contents);
  var_7ba409015d76660f = -2000;
  var_bca221bd88841350 = 0;

  for(i = 0; i < numpoints; i++) {
    shotoffset = planeforward * var_7ba409015d76660f + planeright * var_bca221bd88841350;
    var_11c8174cf2c79029 = impactcenterpos + planeforward * var_7ba409015d76660f;
    var_a18d8b24190a4ad7 = impactcenterpos + shotoffset;
    flaretrace = scripts\engine\trace::ray_trace(var_a18d8b24190a4ad7 + (0, 0, launchpos[2]), var_a18d8b24190a4ad7 - (0, 0, 10000), level.characters, contentoverride);
    flareorigin = flaretrace["position"];
    damageorigin = impactcenterpos * (1, 1, 0) + (0, 0, flareorigin[2]) + planeforward * var_7ba409015d76660f;
    flareinfo = spawnStruct();
    flareinfo.damageorigin = damageorigin;
    flareinfo.flareorigin = flareorigin;
    flarepoints[flarepoints.size] = flareinfo;
    var_7ba409015d76660f += 500;
    var_bca221bd88841350 = randomintrange(-750, 750);
  }

  return flarepoints;
}

function wp_projwatchimpact(payloadlifetime, effecttype, shotsurface) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2.5);
  self.projimpacted = 1;
  level wp_addtoactivewplist("inner", self);
  self setscriptablepartstate("impact", "on", 0);

  if(isDefined(shotsurface) && shotsurface == "surftype_water") {
    self setscriptablepartstate("flare_death_water", "on", 0);
  } else {
    self setscriptablepartstate("flare", "on", 0);
  }

  var_420dc592a2640a78 = self.struct.damageorigin + (0, 0, 10);

  if(isDefined(self.owner)) {
    self radiusdamage(var_420dc592a2640a78, 512, 500, 500, self.owner, "MOD_EXPLOSIVE", "white_phosphorus_proj_mp");

    debugpayload = getdvarint(@ "hash_b72a0bb47130fb8e", 0);

    if(debugpayload) {
      sphere(var_420dc592a2640a78, 512, (1, 1, 0), 0, payloadlifetime * 30);
    }
  }

  if(isDefined(shotsurface) && shotsurface != "surftype_water") {
    if(isDefined(effecttype)) {
      self.killcament = spawn("script_model", self.origin + (0, 0, 100));

      if(effecttype == "burn") {
        thread wp_watchburneffect(300);
      } else {
        thread wp_watchblindeffect(300);
      }

      if(!iscp()) {
        killstreak_createdangerzone(self.origin, 300, 300, payloadlifetime, self.owner, self.team);
        thread wp_deletedangerzoneondeath();
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(payloadlifetime);
    level wp_removefromactivewplist("inner", self, effecttype, 1);
    self notify("stop_wp_status_effect");
    self setscriptablepartstate("flare", "off", 0);
    self setscriptablepartstate("flare_death", "on", 0);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  thread wp_delayzonedelete(15);
}

function wp_deletedangerzoneondeath() {
  level endon("game_ended");
  dangerzoneid = self.dangerzoneid;
  self waittill("death");
  killstreak_destroydangerzone(dangerzoneid);
}

function wp_delayzonedelete(timedelay) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  wpspawntype = 0;

  wpspawntype = getdvarint(@ "hash_1aff95d5bc69c60f", 0);

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(timedelay);

  if(wpspawntype) {
    self freescriptable();
    return;
  }

  self delete();
}

function wp_watchdisorienteffect(disorientradius, var_73798c47bd1e4e64, var_1f86b15faeb68186) {
  self endon("death");
  self.playersindisorientradius = [];

  if(isDefined(var_73798c47bd1e4e64) && isDefined(var_1f86b15faeb68186)) {
    thread wp_delaydisorientplayersinrange(0.15, 2000, var_73798c47bd1e4e64);
    thread wp_delaydisorientplayersinrange(0.25, undefined, var_1f86b15faeb68186);
    return;
  }

  while(true) {
    var_9eab05d07992eb78 = utility::playersincylinder(self.origin, disorientradius);
    var_75837944482f9ece = array_difference(level.players, var_9eab05d07992eb78);

    foreach(player in var_9eab05d07992eb78) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(!wp_isinwpzone("smoke", player, self)) {
        wp_addplayertostatusradiuslist("smoke", player);
      }

      if(!istrue(player.wpdisorient)) {
        player thread wp_startdisorientplayer(self);
      }
    }

    foreach(player in var_75837944482f9ece) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(istrue(player.wpdisorient) && wp_isinwpzone("smoke", player, self)) {
        player thread wp_stopdisorientplayer(self);
      }
    }

    waitframe();
  }
}

function wp_getplayerswithinrange(var_fe16f116477f0084, range) {
  playersinrange = [];

  foreach(player in var_fe16f116477f0084) {
    if(distance2dsquared(self.origin, player.origin) <= range * range) {
      playersinrange[playersinrange.size] = player;
    }
  }

  return playersinrange;
}

function wp_delaydisorientplayersinrange(delaytime, range, initialtargetarray) {
  self endon("death");

  if(isDefined(delaytime) && delaytime > 0) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  }

  targetsinrange = initialtargetarray;

  if(isDefined(range) && range > 0) {
    targetsinrange = wp_getplayerswithinrange(initialtargetarray, range);
  }

  foreach(player in targetsinrange) {
    if(player scripts\cp_mp\utility\player_utility::_isalive()) {
      wp_addplayertostatusradiuslist("smoke", player);

      if(!istrue(player.wpdisorient)) {
        player thread wp_startdisorientplayer(self);
      }
    }

    player thread wp_startdisorientplayeronspawn(self);
  }
}

function wp_watchburneffect(burnradius) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self.playersininnerradius = [];

  while(true) {
    foreach(player in level.players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(distance2d(self.origin, player.origin) <= burnradius && scripts\engine\trace::ray_trace_passed(player getEye(), self.origin + (0, 0, 30), player)) {
        if(!istrue(player.wpburning)) {
          player thread wp_startburnplayer(self, self.owner);
        }

        continue;
      }

      if(istrue(player.wpburning) && wp_isinwpzone("inner", player, self)) {
        player wp_stopburnplayer(self);
      }
    }

    waitframe();
  }
}

function wp_watchblindeffect(blindradius) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self.playersininnerradius = [];

  while(true) {
    foreach(player in level.players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(distance2d(self.origin, player.origin) <= blindradius && scripts\engine\trace::ray_trace_passed(player getEye(), self.origin + (0, 0, 30), player)) {
        if(!istrue(player.wpblinding)) {
          player wp_startblindplayer(self);
        }

        continue;
      }

      if(istrue(player.wpblinding) && wp_isinwpzone("inner", player, self)) {
        player wp_stopblindplayer(self);
      }
    }

    waitframe();
  }
}

function wp_addtoactivewplist(type, var_fa00ab9d021cd558) {
  if(type == "smoke") {
    level.activewpzones[level.activewpzones.size] = var_fa00ab9d021cd558;
    return;
  }

  level.activewpinnerzones[level.activewpinnerzones.size] = var_fa00ab9d021cd558;
}

function wp_isactivewpzone(type, var_d0edab7a45b12083) {
  isactivezone = 0;

  if(type == "smoke") {
    foreach(zone in level.activewpzones) {
      if(zone == var_d0edab7a45b12083) {
        isactivezone = 1;
        break;
      }
    }
  } else {
    foreach(zone in level.activewpinnerzones) {
      if(zone == var_d0edab7a45b12083) {
        isactivezone = 1;
        break;
      }
    }
  }

  return isactivezone;
}

function wp_removefromactivewplist(type, var_e259cf0d8dcfa751, subeffecttype, dontdelete) {
  if(!isDefined(var_e259cf0d8dcfa751)) {
    return;
  }

  newlist = [];

  if(type == "smoke") {
    foreach(wpzone in level.activewpzones) {
      if(wpzone == var_e259cf0d8dcfa751) {
        continue;
      }

      newlist[newlist.size] = wpzone;
    }

    level.activewpzones = newlist;

    if(isDefined(var_e259cf0d8dcfa751.playersindisorientradius)) {
      foreach(player in var_e259cf0d8dcfa751.playersindisorientradius) {
        if(isDefined(player) && !wp_isinanywpzone("smoke", player)) {
          player thread wp_stopdisorientplayer(var_e259cf0d8dcfa751);
        }
      }
    }

    if(level.activewpzones.size <= 0) {
      level.wpinprogress = undefined;
    }
  } else {
    foreach(wpzone in level.activewpinnerzones) {
      if(wpzone == var_e259cf0d8dcfa751) {
        continue;
      }

      newlist[newlist.size] = wpzone;
    }

    level.activewpinnerzones = newlist;

    if(isDefined(var_e259cf0d8dcfa751.playersininnerradius)) {
      foreach(player in var_e259cf0d8dcfa751.playersininnerradius) {
        if(isDefined(player) && !wp_isinanywpzone("inner", player)) {
          if(subeffecttype == "burn") {
            player thread wp_stopburnplayer(var_e259cf0d8dcfa751);
            continue;
          }

          player thread wp_stopblindplayer(var_e259cf0d8dcfa751);
        }
      }
    }
  }

  if(istrue(dontdelete)) {
    return;
  }

  wpspawntype = 0;

  wpspawntype = getdvarint(@ "hash_1aff95d5bc69c60f", 0);

  if(wpspawntype) {
    var_e259cf0d8dcfa751 freescriptable();
    return;
  }

  var_e259cf0d8dcfa751 delete();
}

function wp_isinanywpzone(type, var_c4b81997f0120a97) {
  var_83ebb8884bb96f82 = 0;

  if(type == "smoke") {
    foreach(wpzone in level.activewpzones) {
      if(wp_isinwpzone(type, var_c4b81997f0120a97, wpzone)) {
        var_83ebb8884bb96f82 = 1;
        break;
      }
    }
  } else {
    foreach(wpzone in level.activewpinnerzones) {
      if(wp_isinwpzone(type, var_c4b81997f0120a97, wpzone)) {
        var_83ebb8884bb96f82 = 1;
        break;
      }
    }
  }

  return var_83ebb8884bb96f82;
}

function wp_isinwpzone(type, var_c4b81997f0120a97, wpzone) {
  isinzone = 0;
  var_2b3d4f72cf8ef276 = undefined;

  if(type == "smoke") {
    var_2b3d4f72cf8ef276 = wpzone.playersindisorientradius;
  } else {
    var_2b3d4f72cf8ef276 = wpzone.playersininnerradius;
  }

  if(isDefined(var_2b3d4f72cf8ef276)) {
    foreach(player in var_2b3d4f72cf8ef276) {
      if(player == var_c4b81997f0120a97) {
        isinzone = 1;
        break;
      }
    }
  }

  return isinzone;
}

function wp_addplayertostatusradiuslist(type, playertoadd) {
  if(type == "smoke") {
    self.playersindisorientradius[self.playersindisorientradius.size] = playertoadd;
    return;
  }

  self.playersininnerradius[self.playersininnerradius.size] = playertoadd;
}

function wp_removeplayerfromstatusradiuslist(type, var_9d90c26327e3eacd) {
  if(type == "smoke") {
    newlist = [];

    foreach(player in self.playersindisorientradius) {
      if(player == var_9d90c26327e3eacd) {
        continue;
      }

      newlist[newlist.size] = player;
    }

    self.playersindisorientradius = newlist;
    return;
  }

  newlist = [];

  foreach(player in self.playersininnerradius) {
    if(player == var_9d90c26327e3eacd) {
      continue;
    }

    newlist[newlist.size] = player;
  }

  self.playersininnerradius = newlist;
}

function wp_removeplayerfromallstatusradiuslists(type, var_9d90c26327e3eacd) {
  if(type == "smoke") {
    foreach(wpzone in level.activewpzones) {
      if(wp_isinwpzone(type, var_9d90c26327e3eacd, wpzone)) {
        wpzone wp_removeplayerfromstatusradiuslist(type, var_9d90c26327e3eacd);
      }
    }

    return;
  }

  foreach(wpzone in level.activewpinnerzones) {
    if(wp_isinwpzone(type, var_9d90c26327e3eacd, wpzone)) {
      wpzone wp_removeplayerfromstatusradiuslist(type, var_9d90c26327e3eacd);
    }
  }
}

function wp_startdisorientplayeronspawn(wpzone) {
  wpzone endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("spawned_player");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    wpzone wp_addplayertostatusradiuslist("smoke", self);
    thread wp_startdisorientplayer(wpzone);
  }
}

function wp_startdisorientplayer(wpzone) {
  wpzone endon("death");
  self endon("death_or_disconnect");
  self endon("stop_disorient");
  level endon("game_ended");
  self.wpdisorient = 1;

  while(isDefined(self.sessionstate) && self.sessionstate != "playing") {
    waitframe();
  }

  thread wp_stopdisorientonplayerdeath(wpzone);
  thread wp_monitorsmokevisionset(wpzone);
  playfxontagforclients(getfx("white_phosphorus_screen"), self, "tag_eye", self);

  if(level.teambased && self.team == wpzone.team || self == wpzone.owner) {
    skipplayer = 1;

    debugpayload = getdvarint(@ "hash_b72a0bb47130fb8e", 0);

    if(debugpayload) {
      skipplayer = 0;
    }

    if(istrue(skipplayer)) {
      return;
    }
  }

  self.wphealthblock = 1;

  if(issharedfuncdefined("perk", "givePerk")) {
    self[[getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");
  }

  if(self.health > 10) {
    healthdebuffamount = wp_gethealthdebuffamount();
    wp_degenhealth(healthdebuffamount, wpzone);
  }

  if(!wp_hasresistperk()) {
    enableloopingcoughaudio(wpzone);
  }
}

function wp_degenhealth(var_c3770dc539016800, wpzone) {
  if(istrue(self.gasmaskequipped)) {
    return;
  }

  if(!isDefined(self.wphealthblock)) {
    self.wphealthblock = 1;

    if(issharedfuncdefined("perk", "givePerk")) {
      self[[getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");
    }
  }

  self dodamage(var_c3770dc539016800, self.origin, wpzone.owner, wpzone, "MOD_EXPLOSIVE", "white_phosphorus_proj_mp");
}

function wp_startdofshiftforplayer(wpzone) {
  wpzone endon("death");
  self endon("death");
  level endon("game_ended");

  while(istrue(self.wpdisorient)) {
    wait randomfloatrange(1, 3);
  }
}

function wp_stopdisorientonplayerdeath(wpzone) {
  wpzone endon("death");
  self endon("stop_disorient");
  level endon("game_ended");
  self waittill("death");
  wp_stopdisorientplayer(wpzone, 1);
}

function wp_stopdisorientplayer(wpzone, var_fb8011c41299d291) {
  level endon("game_ended");

  if(istrue(var_fb8011c41299d291)) {
    level wp_removeplayerfromallstatusradiuslists("smoke", self);
  } else {
    wpzone wp_removeplayerfromstatusradiuslist("smoke", self);
  }

  if(!wp_isinanywpzone("smoke", self) || istrue(var_fb8011c41299d291)) {
    if(istrue(self.wpdisorient)) {
      self.wpdisorient = undefined;

      if(scripts\cp_mp\utility\player_utility::_isalive()) {
        self visionsetnakedforplayer("", 2);
      }

      stopfxontagforclients(getfx("white_phosphorus_screen"), self, "tag_eye", self);

      if(istrue(self.wphealthblock)) {
        if(issharedfuncdefined("perk", "removePerk")) {
          self[[getsharedfunc("perk", "removePerk")]]("specialty_block_health_regen");
        }

        self.wphealthblock = undefined;
      }

      disableloopingcoughaudio();
      self notify("stop_disorient");
    }
  }
}

function wp_startburnplayer(wpzone, attacker) {
  wpzone endon("death");
  self endon("stop_wp_burn");
  self endon("death");
  level endon("game_ended");

  if(level.teambased && self.team == wpzone.team && self != wpzone.owner) {
    skipplayer = 1;

    debugpayload = getdvarint(@ "hash_b72a0bb47130fb8e", 0);

    if(debugpayload) {
      skipplayer = 0;
    }

    if(istrue(skipplayer)) {
      return;
    }
  }

  wpzone wp_addplayertostatusradiuslist("inner", self);
  self.wpburning = 1;

  if(issharedfuncdefined("weapons", "enableBurnFX")) {
    self[[getsharedfunc("weapons", "enableBurnFX")]](undefined, "wp_active");
  }

  if(issharedfuncdefined("damage", "enqueueCorpsetableFunc")) {
    [[getsharedfunc("damage", "enqueueCorpsetableFunc")]]("white_phosphorus_burning", &wp_playcorpsetableburningfx);
  }

  thread wp_stopstatuseffectondeath(wpzone);
  damage = 10;

  while(true) {
    if(self.health <= damage) {
      self notify("stop_degen");
    }

    self dodamage(damage, self.origin, attacker, wpzone, "MOD_FIRE", wpzone.weapon_name);
    wait 0.5;
    damage++;

    if(damage >= 20) {
      damage = 20;
    }

    self.lastburntime = gettime();
  }
}

function wp_stopburnplayer(wpzone) {
  wpzone wp_removeplayerfromstatusradiuslist("inner", self);

  if(!wp_isinanywpzone("inner", self)) {
    wp_resetstatuseffect();
    self notify("stop_wp_burn");
  }
}

function wp_startblindplayer(wpzone) {
  if(level.teambased && self.team == wpzone.team || self == wpzone.owner) {
    skipplayer = 1;

    debugpayload = getdvarint(@ "hash_b72a0bb47130fb8e", 0);

    if(debugpayload) {
      skipplayer = 0;
    }

    if(istrue(skipplayer)) {
      return;
    }
  }

  wpzone wp_addplayertostatusradiuslist("inner", self);
  self.wpblinding = 1;
  thread wp_stopstatuseffectondeath(wpzone);
  self visionsetnakedforplayer("wp_flare", 1);
}

function wp_stopblindplayer(wpzone) {
  wpzone wp_removeplayerfromstatusradiuslist("inner", self);

  if(!wp_isinanywpzone("inner", self)) {
    wp_resetstatuseffect();
  }
}

function wp_stopstatuseffectondeath(wpzone) {
  wpzone endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  wp_resetstatuseffect(1);
}

function wp_resetstatuseffect(var_2e501fc7d257ce57) {
  if(istrue(self.wpburning)) {
    if(issharedfuncdefined("weapons", "disableBurnFX")) {
      self[[getsharedfunc("weapons", "disableBurnFX")]](undefined, "wp_active");
    }

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      if(issharedfuncdefined("damage", "dequeueCorpsetableFunc")) {
        self[[getsharedfunc("damage", "dequeueCorpsetableFunc")]]("white_phosphorus_burning");
      }
    }

    self.wpburning = undefined;
  }

  if(istrue(self.wpblinding)) {
    self.wpblinding = undefined;

    if(wp_isinanywpzone("smoke", self)) {
      self visionsetnakedforplayer(wp_getsmokevisionset(), 1);
    } else {
      self visionsetnakedforplayer("", 1);
    }
  }

  if(istrue(var_2e501fc7d257ce57)) {
    level wp_removeplayerfromallstatusradiuslists("inner", self);
  }
}

function wp_removeplane(plane) {
  assertex(isDefined(plane), "wp_removePlane - Plane was removed unexpectedly; this should never happen!");

  if(isDefined(plane.minimapid)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](plane.minimapid);
    }

    plane.minimapid = undefined;
  }

  plane delete();
}

function wp_getsmokevisionset() {
  dayvisionset = "wp_smoke";
  nightvisionset = "wp_smoke_night";
  smokevisionset = dayvisionset;

  if(isnightmap()) {
    smokevisionset = nightvisionset;
  }

  return smokevisionset;
}

function wp_monitorsmokevisionset(wpzone) {
  wpzone endon("death");
  self endon("disconnect");
  self endon("stop_disorient");
  self endon("death");
  level endon("game_ended");
  prevvision = undefined;

  while(true) {
    if(istrue(self.wpdisorient)) {
      currentvision = wp_getsmokevisionset();

      if(!isDefined(prevvision) || currentvision != prevvision) {
        prevvision = currentvision;
        self visionsetnakedforplayer(currentvision, 2);
      }
    }

    waitframe();
  }
}

function wp_gethealthdebuffamount() {
  healthdebuffamount = 50;

  if(wp_hasresistperk()) {
    healthdebuffamount *= 0.5;
  }

  targethealth = self.health;
  var_d6c240915742c3a9 = targethealth - healthdebuffamount;

  if(var_d6c240915742c3a9 < 10) {
    healthdebuffamount -= 10 - var_d6c240915742c3a9;
  }

  return healthdebuffamount;
}

function wp_playcorpsetableburningfx(corpsetable) {
  corpsetable setscriptablepartstate("wp_burning", "flareUp", 0);
}

function wp_hasresistperk() {
  return isDefined(self.perks) && isDefined(self.perks["specialty_tac_resist"]);
}

function enableloopingcoughaudio(wpzone) {
  if(!isDefined(self.loopingcoughaudio)) {
    self.loopingcoughaudio = 0;
  }

  self.loopingcoughaudio++;

  if(self.loopingcoughaudio == 1) {
    thread startloopingcoughaudio(wpzone);
  }
}

function disableloopingcoughaudio() {
  if(!isDefined(self.loopingcoughaudio)) {
    return;
  }

  self.loopingcoughaudio--;
  assertex(self.loopingcoughaudio >= 0, "disableLoopingCoughAudio called more times than enableLoopingCoughAudio.");

  if(self.loopingcoughaudio == 0) {
    thread stoploopingcoughaudio();
    self.loopingcoughaudio = undefined;
  }
}

function startloopingcoughaudio(wpzone) {
  self endon("death_or_disconnect");
  self endon("clearLoopingCoughAudio");
  level endon("game_ended");

  while(true) {
    waittime = randomfloatrange(5, 7);

    if(!loopingcoughaudioissupressed()) {
      soundalias = "generic_cough_3_enemy_1";

      if(isDefined(self.operatorcustomization)) {
        if(isDefined(wpzone)) {
          zoneteam = wpzone.team;
        } else {
          zoneteam = "allies";
        }

        if(self.team == zoneteam) {
          if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
            cough_amount = game["dialogue"]["allies_female_cough"].size;
            current_cough = randomint(cough_amount);
            soundalias = game["dialogue"]["allies_female_cough"][current_cough];
          } else {
            cough_amount = game["dialogue"]["allies_male_cough"].size;
            current_cough = randomint(cough_amount);
            soundalias = game["dialogue"]["allies_male_cough"][current_cough];
          }
        } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
          cough_amount = game["dialogue"]["axis_female_cough"].size;
          current_cough = randomint(cough_amount);
          soundalias = game["dialogue"]["axis_female_cough"][current_cough];
        } else {
          cough_amount = game["dialogue"]["axis_male_cough"].size;
          current_cough = randomint(cough_amount);
          soundalias = game["dialogue"]["axis_male_cough"][current_cough];
        }
      } else {
        cough_amount = game["dialogue"]["axis_male_cough"].size;
        current_cough = randomint(cough_amount);
        soundalias = game["dialogue"]["axis_male_cough"][current_cough];
      }

      if(!isai(self)) {
        self playlocalsound("gas_player_cough");
      }

      if(ismp() && !istrue(getgametype() == "ob")) {
        enemyteams = array_remove(level.teamnamelist, self.team);
        self playsoundtoteam(soundalias, self.team, self, self);
        self playsoundtoteam(soundalias, enemyteams[0], self, self);

        if(isDefined(enemyteams[1])) {
          self playsoundtoteam(soundalias, enemyteams[1], self, self);
        }
      } else if(iscp()) {
        if(isai(self)) {
          self playsoundonmovingent(soundalias);
        }
      }

      wait waittime;
      continue;
    }

    wait 1;
  }
}

function stoploopingcoughaudio() {
  self notify("clearLoopingCoughAudio");
}

function enableloopingcoughaudiosupression() {
  if(!isDefined(self.loopingcoughaudiosupression)) {
    self.loopingcoughaudiosupression = 0;
  }

  self.loopingcoughaudiosupression++;
}

function disableloopingcoughaudiosupression() {
  if(!isDefined(self.loopingcoughaudiosupression)) {
    return;
  }

  self.loopingcoughaudiosupression--;
  assertex(self.loopingcoughaudiosupression >= 0, "disableLoopingCoughAudioSupression called more times than enableLoopingCoughAudioSupression.");
}

function loopingcoughaudioissupressed() {
  return isDefined(self.loopingcoughaudiosupression) && self.loopingcoughaudiosupression > 0;
}

function clearloopingcoughaudio() {
  self notify("clearLoopingCoughAudio");
  self.loopingcoughaudio = undefined;
  self.loopingcoughaudiosupression = undefined;
}

function wp_playimpactsound(var_6b5d366f98ba252b) {
  var_6b5d366f98ba252b setscriptablepartstate("impact_center", "on", 0);
  waitframe();
  var_6b5d366f98ba252b setscriptablepartstate("impact_center", "off", 0);
}