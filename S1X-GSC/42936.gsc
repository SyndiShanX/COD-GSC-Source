/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42936.gsc
**************************************/

init() {
  level._effect["airstrike_ground"] = loadfx("vfx/explosion/clusterbomb_explode");
  level._effect["airstrike_bombs"] = loadfx("vfx/explosion/vfx_clusterbomb");
  level._effect["airstrike_death"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
  level._effect["airstrike_engine"] = loadfx("vfx/fire/jet_afterburner");
  level._effect["airstrike_wingtip"] = loadfx("vfx/trail/jet_contrail");
  level.harriers = [];
  level.planes = [];
  level.artillerydangercenters = [];
  level.dangermaxradius["strafing_run_airstrike"] = 900;
  level.dangerminradius["strafing_run_airstrike"] = 750;
  level.dangerforwardpush["strafing_run_airstrike"] = 1;
  level.dangerovalscale["strafing_run_airstrike"] = 6.0;
  level.killstreakfuncs["strafing_run_airstrike"] = ::tryusestrafingrunairstrike;
  level.killstreakwieldweapons["stealth_bomb_mp"] = "strafing_run_airstrike";
  level.killstreakwieldweapons["airstrike_missile_mp"] = "strafing_run_airstrike";
  level.killstreakwieldweapons["orbital_carepackage_pod_plane_mp"] = "strafing_run_airstrike";
}

tryusestrafingrunairstrike(var_0, var_1) {
  return tryuseairstrike(var_0, "strafing_run_airstrike", var_1);
}

tryuseairstrike(var_0, var_1, var_2) {
  if(isDefined(level.strafing_run_airstrike)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_3 = selectairstrikelocation(var_0, var_1, var_2);

  if(!isDefined(var_3) || !var_3) {
    return 0;
  }

  return 1;
}

doairstrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level.airstrikeinprogress)) {
    while(isDefined(level.airstrikeinprogress)) {
      level waittill("begin_airstrike");
    }

    level.airstrikeinprogress = 1;
    wait 2.0;
  }

  if(!isDefined(var_3)) {
    return;
  }
  level.airstrikeinprogress = 1;
  var_7 = dropsitetrace(var_1, var_3);
  var_8 = spawnStruct();
  var_8.origin = var_7;
  var_8.forward = anglesToForward((0, var_2, 0));
  var_8.streakname = var_5;
  var_8.team = var_4;
  level.artillerydangercenters[level.artillerydangercenters.size] = var_8;
  var_9 = callstrike(var_0, var_3, var_7, var_2, var_5, var_6);
  wait 1.0;
  level.airstrikeinprogress = undefined;
  var_3 notify("begin_airstrike");
  level notify("begin_airstrike");
  wait 7.5;
  var_10 = 0;
  var_11 = [];

  for(var_12 = 0; var_12 < level.artillerydangercenters.size; var_12++) {
    if(!var_10 && level.artillerydangercenters[var_12].origin == var_7) {
      var_10 = 1;
      continue;
    }

    var_11[var_11.size] = level.artillerydangercenters[var_12];
  }

  level.artillerydangercenters = var_11;
}

clearprogress(var_0) {
  wait 2.0;
  level.airstrikeinprogress = undefined;
}

getairstrikedanger(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level.artillerydangercenters.size; var_2++) {
    var_3 = level.artillerydangercenters[var_2].origin;
    var_4 = level.artillerydangercenters[var_2].forward;
    var_5 = level.artillerydangercenters[var_2].streakname;
    var_1 = var_1 + getsingleairstrikedanger(var_0, var_3, var_4, var_5);
  }

  return var_1;
}

getsingleairstrikedanger(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + level.dangerforwardpush[var_3] * level.dangermaxradius[var_3] * var_2;
  var_5 = var_0 - var_4;
  var_5 = (var_5[0], var_5[1], 0);
  var_6 = vectordot(var_5, var_2) * var_2;
  var_7 = var_5 - var_6;
  var_8 = var_7 + var_6 / level.dangerovalscale[var_3];
  var_9 = lengthsquared(var_8);

  if(var_9 > level.dangermaxradius[var_3] * level.dangermaxradius[var_3]) {
    return 0;
  }

  if(var_9 < level.dangerminradius[var_3] * level.dangerminradius[var_3]) {
    return 1;
  }

  var_10 = sqrt(var_9);
  var_11 = (var_10 - level.dangerminradius[var_3]) / (level.dangermaxradius[var_3] - level.dangerminradius[var_3]);
  return 1 - var_11;
}

pointisinairstrikearea(var_0, var_1, var_2, var_3) {
  return distance2d(var_0, var_1) <= level.dangermaxradius[var_3] * 1.25;
}

radiusartilleryshellshock(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.players;

  foreach(var_7 in level.players) {
    if(!isalive(var_7)) {
      continue;
    }
    if(var_7.team == var_4 || var_7.team == "spectator") {
      continue;
    }
    var_8 = var_7.origin + (0, 0, 32);
    var_9 = distance(var_0, var_8);

    if(var_9 > var_1) {
      continue;
    }
    var_10 = int(var_2 + (var_3 - var_2) * var_9 / var_1);
    var_7 thread artilleryshellshock("default", var_10);
  }
}

artilleryshellshock(var_0, var_1) {
  self endon("disconnect");

  if(isDefined(self.beingartilleryshellshocked) && self.beingartilleryshellshocked) {
    return;
  }
  self.beingartilleryshellshocked = 1;
  self shellshock(var_0, var_1);
  wait(var_1 + 1);
  self.beingartilleryshellshocked = 0;
}

bomberdropcarepackges(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("crashing");
  var_2 = spawnStruct();
  var_2.usednodes = [];
  var_2.cratetypes = [];
  waitillairstrikeoverbombingarea(var_0);
  wait 0.1;
  var_3 = gettime();
  var_2.cratetypes[0] = shootdowncarepackage(var_0, var_1, var_2);
  var_4 = gettime();
  var_5 = 0.1 - (var_4 - var_3) / 1000;

  if(var_5 > 0) {
    wait(var_5);
  }

  var_3 = gettime();
  var_2.cratetypes[1] = shootdowncarepackage(var_0, var_1, var_2);
  var_4 = gettime();
  var_5 = 0.1 - (var_4 - var_3) / 1000;

  if(var_5 > 0) {
    wait(var_5);
  }

  var_2.cratetypes[2] = shootdowncarepackage(var_0, var_1, var_2);
}

shootdowncarepackage(var_0, var_1, var_2) {
  var_3 = dropsitetrace(var_0.origin, var_0);
  var_4 = findclosenode(var_3, var_0, var_2, var_0.dropsite, var_1);

  if(!isDefined(var_4)) {
    var_4 = spawnStruct();
    var_4.origin = var_3;
  }

  var_5 = var_0.origin + (0, 0, -5);
  return maps\mp\killstreaks\_orbital_carepackage::firepod("orbital_carepackage_pod_plane_mp", var_1, var_4, "airdrop_assault", [], undefined, var_5, var_2.cratetypes, 0);
}

dropsitetrace(var_0, var_1) {
  var_2 = var_0;
  var_3 = var_2 + (0, 0, -1000000.0);
  var_4 = bulletTrace(var_2, var_3, 0, var_1);

  for(var_5 = var_4["entity"]; isDefined(var_5) && isDefined(var_5.vehicletype); var_5 = var_4["entity"]) {
    waitframe();
    var_2 = var_4["position"];
    var_4 = bulletTrace(var_2, var_3, 0, var_5);
  }

  return var_4["position"];
}

withinothercarepackagenodes(var_0, var_1) {
  var_2 = 26;
  var_3 = var_2 * 2;
  var_4 = var_3 * var_3;

  foreach(var_6 in var_1.usednodes) {
    var_7 = distance2dsquared(var_6.origin, var_0);

    if(var_7 < var_4) {
      return 1;
    }
  }

  return 0;
}

findclosenode(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 4;
  var_6 = 5;
  var_7 = var_1.origin;
  var_8 = getnodesinradiussorted(var_3, 300, 0, 1000);
  var_9 = undefined;

  foreach(var_11 in var_8) {
    if(var_5 <= 0) {
      break;
    }

    if(!nodeexposedtosky(var_11, 1)) {
      continue;
    }
    if(common_scripts\utility::array_contains(var_2.usednodes, var_11)) {
      continue;
    }
    if(withinothercarepackagenodes(var_11.origin, var_2)) {
      continue;
    }
    var_12 = var_11.origin + (0, 0, 5);
    var_13 = var_4;

    if(!isDefined(var_13)) {
      var_13 = var_1;
    }

    var_2.usednodes[var_2.usednodes.size] = var_11;

    if(bullettracepassed(var_7, var_12, 0, var_1) && maps\mp\killstreaks\_orbital_util::carepackagetrace(var_11.origin, var_13, "carepackage")) {
      var_9 = var_11;
      break;
    }

    var_6--;

    if(var_6 <= 0) {
      var_5--;
      var_6 = 5;
      waitframe();
    }
  }

  return var_9;
}

dobomberstrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!common_scripts\utility::array_contains(var_6, "strafing_run_airstrike_two")) {
    thread spawnairstrikeplane(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);
  } else {
    var_7 = spawnStruct();
    getadditionalbomberplanestarts(var_3, var_4, var_7);
    thread spawnairstrikeplane(var_0, var_1, var_2, var_7.startpoint1, var_4, var_5, var_6, 1);
    wait 1;
    thread spawnairstrikeplane(var_0, var_1, var_2, var_7.startpoint2, var_4, var_5, var_6, 0);
  }
}

getadditionalbomberplanestarts(var_0, var_1, var_2) {
  var_3 = anglestoright(var_1);
  var_2.startpoint1 = var_0 + var_3 * 500;
  var_2.startpoint2 = var_0 + var_3 * -1 * 500;
}

spawnairstrikeplane(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = "compass_objpoint_airstrike_busy";

  if(common_scripts\utility::array_contains(var_6, "strafing_run_airstrike_stealth")) {
    var_8 = "compass_objpoint_b2_airstrike_enemy";
  }

  var_9 = spawn("script_model", var_3);
  var_9.angles = var_4;
  var_9 setModel("vehicle_airplane_shrike");
  var_9.minimapicon = spawnplane(var_1, "script_model", var_3, "compass_objpoint_airstrike_friendly", var_8);
  var_9.minimapicon setModel("tag_origin");
  var_9.minimapicon linktosynchronizedparent(var_9, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_9.modules = var_6;
  var_9.vehicletype = "strafing_run";
  addplanetolist(var_9);
  var_9 setCanDamage(1);
  var_9 setCanRadiusDamage(1);
  var_9 thread maps\mp\gametypes\_damage::setentitydamagecallback(1000, undefined, ::onairstrikedeath, maps\mp\killstreaks\_aerial_utility::heli_modifydamage, 1);

  if(common_scripts\utility::array_contains(var_9.modules, "strafing_run_airstrike_flares")) {
    var_9 thread airstrike_flares_monitor();
  }

  var_9 thread handledeath();
  var_9 playLoopSound("bombrun_jet_dist_loop");
  var_9.lifeid = var_0;
  var_9.owner = var_1;
  var_9.team = var_1.team;
  var_9.dropsite = var_2;
  var_9.enteringbombingarea = 1;
  var_9 thread planeanimatepath(var_2);
  var_9 thread planeplayeffects();
  thread stealthbomber_killcam(var_9, var_5);

  if(common_scripts\utility::array_contains(var_9.modules, "strafing_run_airstrike_package")) {
    thread bomberdropcarepackges(var_9, var_1);
  } else {
    thread bomberdropbombs(var_9, var_1);
  }

  if(level.teambased && var_7) {
    level thread handlecoopjoining(var_9, var_1);
  }

  var_9 endon("death");
  var_9 endon("crashing");
  waitillairstrikeoverbombingarea(var_9);
  var_9.enteringbombingarea = 0;
  var_9 waittill("pathComplete");
  level.strafing_run_airstrike = undefined;
  var_9 notify("airstrike_complete");
  removeplanefromlist(var_9);
  var_9 waittillmatch("airstrike", "end");
  var_9 notify("delete");

  if(isDefined(var_9.minimapicon)) {
    var_9.minimapicon delete();
  }

  var_9 delete();
}

planehandlehostmigration() {
  self endon("airstrike_complete");
  self endon("pathComplete");

  for(;;) {
    level waittill("host_migration_begin");
    self scriptmodelpauseanim(1);
    level waittill("host_migration_end");
    self scriptmodelpauseanim(0);
  }
}

planeanimatepath(var_0) {
  self endon("airstrike_complete");
  self scriptmodelplayanimdeltamotion("strafing_run_ks_flyby", "airstrike");
  thread planehandlehostmigration();
  self.status = "flying_in";
  self.flyingspeed = 3333.33;
  wait 3;
  self.status = "strike";
  self.flyingspeed = 1000.0;
  wait 10;
  self.status = "flying_out";
  self.flyingspeed = 3333.33;
  wait 2.9;
  self notify("pathComplete");
}

airstrike_flares_monitor() {
  self.numflares = 4;
  thread maps\mp\killstreaks\_aerial_utility::handleincomingstinger();
}

onairstrikedeath(var_0, var_1, var_2, var_3) {
  thread crashplane();
  maps\mp\gametypes\_damage::onkillstreakkilled(var_0, var_1, var_2, var_3, "strafing_run_destroyed", undefined, "callout_destroyed_airstrike", 1);
}

crashplane() {
  self notify("crashing");
  self.crashed = 1;
}

bomberdropbombs(var_0, var_1) {
  var_0 endon("airstrike_complete");

  while(!targetisclose(var_0, var_0.dropsite, 5000)) {
    wait 0.05;
  }

  var_2 = 1;
  var_3 = 0;
  var_0 notify("start_bombing");
  var_0 thread playbombfx();

  for(var_4 = targetgetdist(var_0, var_0.dropsite); var_4 < 5000; var_4 = targetgetdist(var_0, var_0.dropsite)) {
    if(var_4 < 1500 && !var_3) {
      var_3 = 1;
    }

    var_2 = !var_2;

    if(var_4 < 4500) {
      var_0 thread callstrike_bomb(var_0.origin, var_1, (0, 0, 0), var_2);
    }

    wait 0.1;
  }

  var_0 notify("stop_bombing");
  level.strafing_run_airstrike = undefined;
}

playbombfx() {
  self endon("stop_bombing");
  self endon("airstrike_complete");
  self.bomb_tag_left = spawn("script_model", (0, 0, 0));
  self.bomb_tag_left setModel("tag_origin");
  self.bomb_tag_left linkto(self, "bombaydoor_left_jnt", (0, 0, 0), (0, -90, 0));
  self.bomb_tag_right = spawn("script_model", (0, 0, 0));
  self.bomb_tag_right setModel("tag_origin");
  self.bomb_tag_right linkto(self, "bombaydoor_right_jnt", (0, 0, 0), (0, -90, 0));

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("airstrike_bombs"), self.bomb_tag_left, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("airstrike_bombs"), self.bomb_tag_right, "tag_origin");
    wait 0.5;
  }
}

stealthbomber_killcam(var_0, var_1) {
  var_0 endon("airstrike_complete");
  var_0 waittill("start_bombing");
  var_2 = anglesToForward(var_0.angles);
  var_3 = spawn("script_model", var_0.origin + (0, 0, 100) - var_2 * 200);
  var_0.killcament = var_3;
  var_0.killcament setscriptmoverkillcam("airstrike");
  var_0.airstriketype = var_1;
  var_3.starttime = gettime();
  var_3 thread deleteaftertime(16.0);
  var_3 linkto(var_0, "tag_origin", (-256, 768, 768), (0, 0, 0));
}

callstrike_bomb(var_0, var_1, var_2, var_3) {
  self endon("airstrike_complete");

  if(!isDefined(var_1) || var_1 maps\mp\_utility::isemped() || var_1 maps\mp\_utility::isairdenied()) {
    self notify("stop_bombing");
    return;
  }

  var_4 = 512;
  var_5 = (0, randomint(360), 0);
  var_6 = var_0 + anglesToForward(var_5) * randomfloat(var_4);
  var_7 = bulletTrace(var_6, var_6 + (0, 0, -10000), 0, self);
  var_6 = var_7["position"];
  var_8 = distance(var_0, var_6);

  if(var_8 > 10000) {
    return;
  }
  wait(0.85 * (var_8 / 2000));

  if(!isDefined(var_1) || var_1 maps\mp\_utility::isemped() || var_1 maps\mp\_utility::isairdenied()) {
    self notify("stop_bombing");
    return;
  }

  if(var_3) {
    playFX(common_scripts\utility::getfx("airstrike_ground"), var_6);
    level thread maps\mp\gametypes\_shellshock::stealthairstrike_earthquake(var_6);
  }

  thread maps\mp\_utility::playsoundinspace("bombrun_snap", var_6);
  radiusartilleryshellshock(var_6, 512, 8, 4, var_1.team);
  self radiusdamage(var_6 + (0, 0, 16), 896, 300, 50, var_1, "MOD_EXPLOSIVE", "stealth_bomb_mp");

  if(isDefined(level.ishorde) && level.ishorde && isDefined(level.flying_attack_drones)) {
    foreach(var_10 in level.flying_attack_drones) {
      if(var_10.origin[2] > var_6[2] - 24 && var_10.origin[2] < var_6[2] + 1000 && distance2dsquared(var_10.origin, var_6) < 90000) {
        var_10 dodamage(randomintrange(50, 300), var_6 + (0, 0, 16), var_1, var_1, "MOD_EXPLOSIVE", "stealth_bomb_mp");
      }
    }
  }
}

handledeath(var_0) {
  level endon("game_ended");
  self endon("delete");
  common_scripts\utility::waittill_either("death", "crashing");
  var_1 = anglesToForward(self.angles);
  playFX(common_scripts\utility::getfx("airstrike_death"), self.origin, var_1);
  maps\mp\_utility::playsoundinspace("bombrun_air_death", self.origin);
  self notify("airstrike_complete");
  removeplanefromlist(self);
  level.strafing_run_airstrike = undefined;

  if(isDefined(self.minimapicon)) {
    self.minimapicon delete();
  }

  self delete();
}

addplanetolist(var_0) {
  level.planes[level.planes.size] = var_0;
}

removeplanefromlist(var_0) {
  level.planes = common_scripts\utility::array_remove(level.planes, var_0);
}

deleteaftertime(var_0) {
  self endon("death");
  wait(var_0);
  self delete();
}

planeplayeffects() {
  self endon("airstrike_complete");
  waitframe();
  playFXOnTag(common_scripts\utility::getfx("airstrike_engine"), self, "tag_engine_right");
  playFXOnTag(common_scripts\utility::getfx("airstrike_engine"), self, "tag_engine_left");
  playFXOnTag(common_scripts\utility::getfx("airstrike_wingtip"), self, "tag_right_wingtip");
  playFXOnTag(common_scripts\utility::getfx("airstrike_wingtip"), self, "tag_left_wingtip");
}

callstrike(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread maps\mp\_utility::teamplayercardsplash("used_strafing_run_airstrike", var_1, var_1.team);
  var_6 = getplaneflyheight();
  var_1 endon("disconnect");
  var_7 = (0, var_3, 0);
  var_8 = getflightpath(var_2, var_7, var_6);
  level thread dobomberstrike(var_0, var_1, var_2, var_8, var_7, var_4, var_5);
}

getplaneflyheight() {
  var_0 = 0;

  if(isDefined(level.airstrikeoverrides) && isDefined(level.airstrikeoverrides.spawnheight)) {
    var_0 = level.airstrikeoverrides.spawnheight;
  }

  var_1 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
  return var_1.origin[2] + 750 + var_0;
}

getflightpath(var_0, var_1, var_2) {
  var_3 = getflightdistance() / 2;
  var_4 = var_0 + anglesToForward(var_1) * (-1 * var_3);
  var_4 = var_4 * (1, 1, 0);
  var_4 = var_4 + (0, 0, var_2);
  return var_4;
}

getflightdistance() {
  return 30000;
}

targetgetdist(var_0, var_1) {
  var_2 = targetisinfront(var_0, var_1);

  if(var_2) {
    var_3 = 1;
  } else {
    var_3 = -1;
  }

  var_4 = common_scripts\utility::flat_origin(var_0.origin);
  var_5 = var_4 + anglesToForward(common_scripts\utility::flat_angle(var_0.angles)) * (var_3 * 100000);
  var_6 = pointonsegmentnearesttopoint(var_4, var_5, var_1);
  var_7 = distance(var_4, var_6);
  return var_7;
}

targetisclose(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 3000;
  }

  var_3 = targetisinfront(var_0, var_1);

  if(var_3) {
    var_4 = 1;
  } else {
    var_4 = -1;
  }

  var_5 = common_scripts\utility::flat_origin(var_0.origin);
  var_6 = var_5 + anglesToForward(common_scripts\utility::flat_angle(var_0.angles)) * (var_4 * 100000);
  var_7 = pointonsegmentnearesttopoint(var_5, var_6, var_1);
  var_8 = distance(var_5, var_7);

  if(var_8 < var_2) {
    return 1;
  } else {
    return 0;
  }
}

targetisinfront(var_0, var_1) {
  var_2 = anglesToForward(common_scripts\utility::flat_angle(var_0.angles));
  var_3 = vectornormalize(common_scripts\utility::flat_origin(var_1) - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0) {
    return 1;
  } else {
    return 0;
  }
}

waitforairstrikecancel() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self waittill("stop_location_selection");
  self setblurforplayer(0, 0.3);
  self setclientomnvar("ui_map_location_blocked", 0);

  if(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone() > 0) {
    self switchtoweapon(common_scripts\utility::getlastweapon());
  }

  level.strafing_run_airstrike = undefined;
}

selectairstrikelocation(var_0, var_1, var_2) {
  if(!isDefined(level.mapsize)) {
    level.mapsize = 1024;
  }

  var_3 = level.mapsize / 6.46875;

  if(level.splitscreen) {
    var_3 = var_3 * 1.5;
  }

  level.strafing_run_airstrike = 1;
  var_4 = 1;
  var_5 = 1;

  if(common_scripts\utility::array_contains(var_2, "strafing_run_airstrike_two")) {
    var_5 = 2;
  }

  self setclientomnvar("ui_map_location_use_carepackages", common_scripts\utility::array_contains(var_2, "strafing_run_airstrike_package"));
  self setclientomnvar("ui_map_location_num_planes", var_5);
  self setclientomnvar("ui_map_location_height", getplaneflyheight());
  maps\mp\_utility::_beginlocationselection(var_1, "map_artillery_selector", var_4, var_3);
  thread waitforairstrikecancel();
  self endon("stop_location_selection");
  self endon("disconnect");
  var_6 = undefined;
  var_7 = undefined;
  var_8 = 0;

  while(!var_8) {
    self waittill("confirm_location", var_9, var_10);

    if(!var_4) {
      var_10 = 0;
    }

    if(validateflightlocationanddirection(var_9, var_10, var_2, self)) {
      var_6 = var_9;
      var_7 = var_10;
      self setclientomnvar("ui_map_location_use_carepackages", 0);
      self setclientomnvar("ui_map_location_num_planes", 0);
      self setclientomnvar("ui_map_location_height", 0);
      break;
    } else {
      thread showblockedhud();
    }
  }

  self setblurforplayer(0, 0.3);
  self notify("location_selection_complete");
  self setclientomnvar("ui_map_location_blocked", 0);
  maps\mp\_matchdata::logkillstreakevent(var_1, var_6);
  thread finishairstrikeusage(var_0, [var_6], [var_7], var_1, var_2);
  return 1;
}

showblockedhud() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self endon("stop_location_selection");
  self notify("airstrikeShowBlockedHUD");
  self endon("airstrikeShowBlockedHUD");

  if(self getclientomnvar("ui_map_location_blocked") == 0) {
    self playlocalsound("recon_drn_cloak_notready");
  }

  self setclientomnvar("ui_map_location_blocked", 1);
  wait 1.5;
  self setclientomnvar("ui_map_location_blocked", 0);
}

validateflightlocationanddirection(var_0, var_1, var_2, var_3) {
  var_4 = getplaneflyheight();
  var_5 = 1;

  if(common_scripts\utility::array_contains(var_2, "strafing_run_airstrike_two")) {
    var_5 = 2;
  }

  return bombingruntracepassed(var_0, var_4, var_1, var_5);
}

finishairstrikeusage(var_0, var_1, var_2, var_3, var_4) {
  self notify("used");

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = var_1[var_5];
    var_7 = var_2[var_5];
    var_8 = bulletTrace(level.mapcenter + (0, 0, 1000000.0), level.mapcenter, 0, undefined);
    var_6 = (var_6[0], var_6[1], var_8["position"][2] - 514);
    thread doairstrike(var_0, var_6, var_7, self, self.pers["team"], var_3, var_4);
  }
}

waitillairstrikeoverbombingarea(var_0) {
  var_0 endon("airstrike_complete");

  while(!targetisclose(var_0, var_0.dropsite, 200)) {
    waitframe();
  }
}

playerdelaycontrol() {
  self endon("disconnect");
  maps\mp\_utility::freezecontrolswrapper(1);
  wait 0.5;
  maps\mp\_utility::freezecontrolswrapper(0);
}

playerdoridekillstreak(var_0) {
  var_1 = maps\mp\killstreaks\_killstreaks::initridekillstreak("coop", 0, 0.5);

  if(var_1 != "success" || !isDefined(var_0)) {
    if(var_1 != "disconnect") {
      if(!isDefined(var_0)) {
        thread maps\mp\_utility::playerremotekillstreakshowhud();
      }

      playerreset(0);
      maps\mp\killstreaks\_coop_util::playerresetaftercoopstreak();
    }

    self notify("initRideKillstreak_complete", 0);
    return;
  }

  self notify("initRideKillstreak_complete", 1);
}

handlecoopjoining(var_0, var_1) {
  var_2 = var_1.team;

  if(var_1.team == "allies") {
    var_3 = "SE_1mc_orbitalsupport_buddyrequest";
    var_4 = "SE_1mc_orbitalsupport_buddy";
  } else {
    var_3 = "AT_1mc_orbitalsupport_buddyrequest";
    var_4 = "AT_1mc_orbitalsupport_buddy";
  }

  waittilloverplayspace(var_0);

  if(!isDefined(var_0)) {
    return;
  }
  var_5 = maps\mp\killstreaks\_coop_util::promptforstreaksupport(var_2, &"MP_JOIN_STRAFING_RUN", "strafing_run_airstrike_coop_offensive", var_3, var_4, var_1);
  level thread watchforjoin(var_5, var_0, var_1);
  var_6 = waittillpromptcomplete(var_0, "buddyJoinedStreak");
  maps\mp\killstreaks\_coop_util::stoppromptforstreaksupport(var_5);

  if(!isDefined(var_6)) {
    return;
  }
  var_6 = waittillpromptcomplete(var_0, "airstrike_buddy_removed");

  if(!isDefined(var_6)) {
    return;
  }
}

notifycoopover(var_0) {
  var_0 endon("airstrike_complete");

  if(var_0.enteringbombingarea) {
    waitillairstrikeoverbombingarea(var_0);
  }

  waittillleftplayspace(var_0, 1.65);
  var_0 notify("coopJoinOver");
}

waittilloverplayspace(var_0) {
  var_1 = 1.65;
  var_2 = anglesToForward(var_0.angles);

  for(;;) {
    waitframe();

    if(!isDefined(var_0)) {
      return;
    }
    var_3 = var_0.flyingspeed * var_1;
    var_4 = var_0.origin + var_2 * var_3;
    var_5 = var_4 + (0, 0, -10000);
    var_6 = bulletTrace(var_4, var_5, 0, var_0);

    if(var_6["fraction"] == 1) {
      continue;
    }
    var_7 = var_6["position"];
    var_8 = getnodesinradius(var_7, 300, 0);

    if(var_8.size > 0) {
      break;
    }
  }
}

waittillleftplayspace(var_0, var_1) {
  var_0 endon("airstrike_complete");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  for(;;) {
    waitframe();
    var_2 = var_0.flyingspeed * var_1;
    var_3 = anglesToForward(var_0.angles);
    var_4 = var_0.origin + var_3 * var_2;
    var_5 = var_4 + (0, 0, -10000);
    var_6 = bulletTrace(var_4, var_5, 0, var_0);

    if(var_6["fraction"] == 1) {
      break;
    }

    var_7 = var_6["position"];
    var_8 = getnodesinradius(var_7, 300, 0);

    if(var_8.size == 0) {
      break;
    }
  }
}

waittillfiremissile(var_0, var_1) {
  var_1 endon("airstrike_fire");
  var_0 endon("airstrike_complete");

  if(var_0.enteringbombingarea) {
    waitillairstrikeoverbombingarea(var_0);
  }

  waittillleftplayspace(var_0);
}

waittillpromptcomplete(var_0, var_1) {
  var_0 endon("airstrike_complete");
  var_0 endon("coopJoinOver");
  var_0 waittill(var_1);
  return 1;
}

watchforjoin(var_0, var_1, var_2) {
  var_3 = waittillbuddyjoinedairstrike(var_0, var_1);

  if(!isDefined(var_3)) {
    return;
  }
  var_1 notify("buddyJoinedStreak");
  level notify("buddyGO");
  var_3 thread playerdoridekillstreak(var_1);
  var_3 waittill("initRideKillstreak_complete", var_4);

  if(!var_4) {
    return;
  }
  var_3 maps\mp\_utility::playersaveangles();
  var_3 maps\mp\_utility::setusingremote("strafing_run");
  var_3 notifyonplayercommand("airstrike_fire", "+attack");
  var_3 notifyonplayercommand("airstrike_fire", "+attack_akimbo_accessible");
  var_5 = spawnturret("misc_turret", var_1 gettagorigin("tag_origin"), "sentry_minigun_mp");
  var_5 turretfiredisable();
  var_5 setModel("tag_turret");
  var_5 linktosynchronizedparent(var_1, "tag_origin", (0, 0, 0), (70, 180, 0));
  var_3 playerlinkweaponviewtodelta(var_5, "tag_player", 0, 180, 180, 5, 15, 0);
  var_3 playerlinkedsetviewznear(0);
  var_3 playerlinkedsetusebaseangleforviewclamp(1);
  var_3 remotecontrolturret(var_5, 60, 45);
  var_6 = var_3 maps\mp\killstreaks\_missile_strike::buildweaponsettings([]);
  missileeyesinit(var_3, var_6, var_2);
  waittillfiremissile(var_1, var_3);

  if(isDefined(var_3)) {
    earthquake(0.4, 1, var_3 getvieworigin(), 300);
    firemissile(var_3, var_5, var_6);

    if(isDefined(var_3)) {
      var_3 maps\mp\killstreaks\_coop_util::playerresetaftercoopstreak();
      var_3 notifyonplayercommandremove("airstrike_fire", "+attack");
      var_3 notifyonplayercommandremove("airstrike_fire", "+attack_akimbo_accessible");
    }
  }

  var_5 delete();
}

waittillbuddyjoinedairstrike(var_0, var_1) {
  var_1 endon("airstrike_complete");
  var_1 endon("coopJoinOver");
  thread notifycoopover(var_1);
  var_2 = maps\mp\killstreaks\_coop_util::waittillbuddyjoinedstreak(var_0);
  return var_2;
}

firemissile(var_0, var_1, var_2) {
  var_3 = var_1 gettagorigin("tag_player");
  var_4 = anglesToForward(var_1 gettagangles("tag_player"));
  var_5 = var_3 + var_4 * 10000;
  var_6 = magicbullet("airstrike_missile_mp", var_3, var_5, var_0);
  var_6.owner = var_0;
  waitframe();

  if(!isDefined(var_0)) {
    return;
  }
  var_0 unlink();
  var_0 remotecontrolturretoff(var_1);
  var_0 setclientomnvar("fov_scale", 4.33333);
  missileeyesgo(var_0, var_6, var_2);

  if(!isDefined(var_0)) {
    return;
  }
  var_0 setclientomnvar("fov_scale", 1.0);
}

missileeyesinit(var_0, var_1, var_2) {
  var_0 thread hudinit(var_1, var_2);
  var_0 thermalvisionfofoverlayon();

  if(getdvarint("camera_thirdPerson")) {
    var_0 maps\mp\_utility::setthirdpersondof(0);
  }
}

missileeyesgo(var_0, var_1, var_2) {
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  var_0 endon("player_control_strike_over");
  var_0 endon("disconnect");
  var_2 endon("ms_early_exit");
  var_1 thread maps\mp\killstreaks\_missile_strike::rocket_cleanupondeath();
  var_0 thread maps\mp\killstreaks\_missile_strike::player_cleanupongameended(var_1, var_2);
  var_0 thread maps\mp\killstreaks\_missile_strike::player_cleanuponteamchange(var_1, var_2);
  var_0 thread hudgo(var_1, var_2);
  var_0 thread playerwaitreset(var_2);
  var_0 cameralinkto(var_1, "tag_origin");
  var_0 controlslinkto(var_1);
  var_0 thread maps\mp\killstreaks\_missile_strike::playerwatchforearlyexit(var_2);
  var_1 common_scripts\utility::waittill_notify_or_timeout("death", 10);
  var_2 notify("missile_strike_complete");
}

playerwaitreset(var_0) {
  var_0 common_scripts\utility::waittill_either("missile_strike_complete", "ms_early_exit");
  playerreset();
}

playerreset(var_0) {
  self endon("disconnect");

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self controlsunlink();
  maps\mp\_utility::freezecontrolswrapper(1);
  self setclientomnvar("fov_scale", 1.0);
  stopmissileboostsounds();
  maps\mp\killstreaks\_missile_strike::stopmissileboostsounds();

  if(!level.gameended || isDefined(self.finalkill)) {
    maps\mp\killstreaks\_aerial_utility::playershowfullstatic();
  }

  if(var_0) {
    wait 0.5;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }

  maps\mp\killstreaks\_missile_strike::remove_hud();
  self thermalvisionfofoverlayoff();
  self cameraunlink();
  maps\mp\_utility::freezecontrolswrapper(0);

  if(maps\mp\_utility::isusingremote()) {
    maps\mp\_utility::clearusingremote();
  }

  maps\mp\_utility::playerrestoreangles();
}

stopmissileboostsounds() {
  self stoplocalsound("bombrun_support_mstrike_boost_shot");
  self stoplocalsound("bombrun_support_mstrike_boost_boom");
  self stoplocalsound("bombrun_support_mstrike_boost_jet");
}

hudinit(var_0, var_1) {
  self endon("disconnect");
  self setclientomnvar("ui_predator_missile", 2);
  self setclientomnvar("ui_coop_primary_num", var_1 getentitynumber());
  waitframe();
  maps\mp\killstreaks\_missile_strike::hud_update_fire_text(undefined, var_0);
  maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
}

hudgo(var_0, var_1) {
  thread maps\mp\killstreaks\_missile_strike::targeting_hud_init();
  thread maps\mp\killstreaks\_missile_strike::targeting_hud_think(var_0, var_1);
}