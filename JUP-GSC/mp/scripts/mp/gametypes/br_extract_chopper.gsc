/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_extract_chopper.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\gametypes\br_extract_chopper;
#using scripts\mp\hostmigration;
#using scripts\mp\killstreaks\flares;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\print;
#using scripts\mp\utility\weapon;
#namespace br_extract_chopper;

function spawnextractchopper(zone, positionoverride, onhelikilled, helitimeoffset) {
  extractpos = zone.origin;
  coord = extractpos;
  direction = (0, 0, 0);
  planehalfdistance = 24000;
  heightent = getEnt("airstrikeheight", "targetname");
  planeflyheight = heightent.origin[2];
  streakname = "jackal";
  entervec = level.mapcenter - zone.origin;
  entervec = (entervec[0], entervec[1], 0);
  enterdir = vectorNormalize(entervec);
  enterstartpoint = enterdir * -10000 + (0, 0, 1) * planeflyheight;
  exitpoint = (extractpos[0], extractpos[1], planeflyheight);
  streakinfo = fakestreakinfo();
  newlz = spawn("trigger_radius", extractpos, 0, 90, 128);
  newlz.angles = (0, 0, 0);
  newlz.team = self.team;
  newlz.ownerteam = self.team;
  newlz.visibleteam = "any";
  newlz.offset3d = (0, 0, 16);
  newlz.location = extractpos;
  bird = scripts\mp\gametypes\br_extract_chopper::beginlittlebird(0, enterstartpoint, exitpoint, streakinfo, newlz, positionoverride, self.team, helitimeoffset);
  bird.onhelikilled = onhelikilled;
  bird.zone = zone;
  return bird;
}

function fakestreakinfo() {
  streakinfo = spawnStruct();
  streakinfo.available = 1;
  streakinfo.firednotify = "offhand_fired";
  streakinfo.isgimme = 1;
  streakinfo.kid = 5;
  streakinfo.lifeid = 0;
  streakinfo.madeavailabletime = gettime();
  streakinfo.scriptuseagetype = "gesture_script_weapon";
  streakinfo.streakname = "jackal";
  streakinfo.streaksetupinfo = undefined;
  streakinfo.variantid = -1;
  streakinfo.weaponname = "ks_gesture_generic_mp";
  streakinfo.objweapon = makeweapon(streakinfo.weaponname);
  return streakinfo;
}

function beginlittlebird(lifeid, startpoint, endpoint, streakinfo, lz, positionoverride, team, helitimeoffset) {
  marker = undefined;

  if(isDefined(lz)) {
    marker = lz.marker;

    if(!isDefined(marker)) {
      marker = spawnStruct();

      if(isDefined(positionoverride)) {
        marker.location = positionoverride;
      } else if(isDefined(lz.location)) {
        marker.location = lz.location;
      } else {
        marker.location = lz.trigger.origin;
      }

      marker.angles = (0, 0, 0);
      marker.string = "equip_deploy_succeeded";
      marker.visual = spawn("script_model", marker.location);
      marker.visual setModel("ks_marker_mp");
      marker.visual setotherent(self);
    }

    if(!isDefined(marker.location)) {
      self notify("cancel_littlebird");
      return 0;
    }
  }

  self notify("called_in_littlebird");
  heightent = getEnt("airstrikeheight", "targetname");

  if(isDefined(heightent)) {
    trueheight = heightent.origin[2] + 500;
  } else {
    trueheight = 1300;
  }

  if(isDefined(marker) && isDefined(marker.location)) {
    endpoint = marker.location;
  }

  endpoint *= (1, 1, 0);
  pathgoal = endpoint + (0, 0, trueheight);
  bird = spawnlittlebird(lifeid, self, startpoint, pathgoal, streakinfo, lz);
  bird.lz = lz;
  bird.pathgoal = pathgoal;
  thread monitorarriveoverdestination(bird, marker, team, helitimeoffset);
  return bird;
}

function spawnlittlebird(lifeid, owner, pathstart, pathgoal, streakinfo, lz) {
  forward = vectortoangles(pathgoal - pathstart);

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") {
    numflares = 99;
    maxhealth = 10000;
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    numflares = 99;
    maxhealth = 99999;
  } else {
    numflares = 1;
    maxhealth = 10000;
  }

  var_1abfbb19b71bccf8 = "veh9_mil_air_heli_medium";
  jackal = spawnhelicopter(owner, pathstart, forward, "lbravo_infil_mp", var_1abfbb19b71bccf8);

  if(!isDefined(jackal)) {
    return;
  }

  if(isDefined(lz)) {
    jackal.lz = lz;
  }

  jackal thread handledestroydamage();
  jackal.damagecallback = &callback_vehicledamage;
  jackal.speed = 50;
  jackal.accel = 125;
  jackal.health = maxhealth;
  jackal.maxhealth = jackal.health;
  jackal.team = owner.team;
  jackal.owner = owner;
  jackal setCanDamage(1);
  jackal.defendloc = pathgoal;
  jackal.lifeid = lifeid;
  jackal.jackal = 1;
  jackal.streakinfo = streakinfo;
  jackal.streakname = streakinfo.streakname;
  jackal.streakinfo = streakinfo;
  jackal.flaresreservecount = numflares;
  jackal addtoactivekillstreaklist(streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);
  jackal setmaxpitchroll(0, 90);
  jackal vehicle_setspeed(jackal.speed, jackal.accel);
  jackal sethoverparams(50, 100, 50);
  jackal setturningability(0.05);
  jackal setyawspeed(45, 25, 25, 0.5);
  jackal setotherent(owner);
  jackal.useobj = spawn("script_model", jackal gettagorigin("tag_origin"));
  jackal.useobj linkTo(jackal, "tag_origin");

  if(!isDefined(level.jackals)) {
    level.jackals = [];
  }

  level.jackals[level.jackals.size] = jackal;
  level.jackals = array_removeundefined(level.jackals);
  jackal thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  jackal thread littlebirddestroyed();
  jackal thread delay_jackal_arrive_sfx();
  return jackal;
}

function delay_jackal_arrive_sfx() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
}

function delayjackalloopsfx(delaytime, alias) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(delaytime);
  self playLoopSound(alias);
}

function littlebirddestroyed() {
  self endon("jackal_gone");
  owner = self.owner;
  self waittill("death");

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline)) {
    outlinedisable(self.targetoutline, self.turrettarget);
  }

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.largeprojectiledamage)) {
    self vehicle_setspeed(25, 5);
    thread littlebirdcrash(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  if(isDefined(self.lz)) {
    self.lz notify("extraction_destroyed");
  }

  littlebirdexplode();
}

function littlebirdexplode() {
  self playSound("dropship_explode_mp");
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("explode");

  if(isDefined(self.lz)) {
    playFXOnTag(getfx("jackal_explosion"), self, "tag_origin");
  }

  wait 0.35;
  thread littlebirddelete();
}

function littlebirddelete() {
  printgameaction("killstreak ended - jackal", self.owner);

  if(isDefined(self.turret)) {
    self.turret delete();
  }

  if(isDefined(self.cannon)) {
    self.cannon delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  foreach(loc in level.carepackagedropnodes) {
    loc.free = undefined;
  }

  self delete();
}

function littlebirdcrash(speed) {
  self endon("explode");
  self clearlookatent();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(speed, speed, speed);
  self settargetyaw(self.angles[1] + speed * 2.5);
}

function handledestroydamage() {
  self endon("death");
  self endon("leaving");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = mapweapon(objweapon, inflictor);

    if((objweapon.basename == "aamissile_projectile_mp" || objweapon.basename == "nuke_mp") && meansofdeath == "MOD_EXPLOSIVE" && damage >= self.health) {
      if(isDefined(self.onhelikilled)) {
        [[self.onhelikilled]](self.team);
      }

      callback_vehicledamage(attacker, attacker, 9001, 0, meansofdeath, objweapon, point, direction_vec, point, 0, 0, partname);
    }
  }
}

function callback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner)) {
      attacker = attacker.owner;
    }
  }

  if((attacker == self || isDefined(attacker.pers) && attacker.pers["team"] == self.team && !level.friendlyfire && level.teambased) && attacker != self.owner) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  damage = getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(attacker, objweapon, self, meansofdeath, damage);
  attacker updatedamagefeedback("");
  scripts\mp\damage::logattackerkillstreak(self, damage, attacker, dir, point, meansofdeath, modelindex, undefined, partname, dflags, getcompleteweaponname(objweapon));

  if(self.health <= damage) {
    if(isPlayer(attacker) && (!isDefined(self.owner) || attacker != self.owner)) {
      scripts\mp\damage::onkillstreakkilled("jackal", attacker, objweapon, meansofdeath, damage, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier");
    }
  }

  if(self.health - damage <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

function monitorarriveoverdestination(littlebird, marker, team, helitimeoffset) {
  littlebird endon("death");
  littlebird endon("leaving");
  assert(isDefined(littlebird));
  littlebird setvehgoalpos(littlebird.pathgoal, 1);
  littlebird thread changemaxpitchrollwhenclosetogoal(littlebird.pathgoal);
  littlebird waittill("goal");
  littlebird thread watchgameendleave();

  if(isDefined(helitimeoffset)) {
    setspeed = littlebird.speed;
    acceleration = littlebird.accel;
  } else {
    setspeed = littlebird.speed / 4;
    acceleration = littlebird.accel / 6;
  }

  littlebird vehicle_setspeed(setspeed, acceleration);
  littlebird littlebirddescendtoextraction(marker.location, littlebird.zone, team);
}

function littlebirdleave() {
  self endon("death");
  speedoverride = self.speed;
  acceloverride = self.accel;
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.leaving = 1;
  self clearlookatent();

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline)) {
    outlinedisable(self.targetoutline, self.turrettarget);
  }

  var_f751b396e9b232e6 = int(self.speed / 14);
  var_a001268025a19c55 = int(self.accel / 16);

  if(isDefined(speedoverride)) {
    var_f751b396e9b232e6 = speedoverride;
  }

  if(isDefined(acceloverride)) {
    var_a001268025a19c55 = acceloverride;
  }

  self vehicle_setspeed(var_f751b396e9b232e6, var_a001268025a19c55);
  pathgoal = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  pathgoal += (0, 0, 1000);
  self setvehgoalpos(pathgoal, 1);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self waittill("goal");
  pathend = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(pathend, 1);
  self waittill("goal");
  self stoploopsound();
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("jackal_gone");

  if(scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "conflict") {
    littlebirddelete();
  }
}

function getpathend() {
  pathrandomness = 150;
  halfdistance = 15000;
  yaw = self.angles[1];
  direction = (0, yaw, 0);
  endpoint = self.origin + anglesToForward(direction) * halfdistance;
  return endpoint;
}

function littlebirddescendtoextraction(location, zone, team) {
  descend(location, zone);

  if(scripts\mp\utility\game::getgametype() != "vip" && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "conflict" && scripts\mp\utility\game::getgametype() != "btm") {
    zone.teamsextracting = array_remove(zone.teamsextracting, team + self.sessionsquadid);
    thread littlebirdleave();
  }
}

function descend(location, zone) {
  self endon("bugOut");
  newpos = undefined;
  locationx = location[0];
  locationy = location[1];
  properz = tracegroundheight(locationx, locationy, 20);
  newpos = (locationx, locationy, properz);

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") {
    properz = tracegroundheight(locationx, locationy, 5, 1);
    newpos = (locationx, locationy, properz + 200);
  }

  self clearlookatent();
  self setvehgoalpos(newpos, 1);

  line(self.origin, newpos, (0, 1, 0), 1, 0, 250);
  sphere(newpos, 100, (0, 1, 0), 0, 250);

  self waittill("goal");

  if(scripts\mp\utility\game::getgametype() == "vip") {
    self notify("esc_littlebird_arrive");
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") {
    self vehicle_setspeed(self.speed / 8, self.accel / 12);
    properz = tracegroundheight(locationx, locationy, undefined, 1);
    newpos = (locationx, locationy, properz + 120);
    self setvehgoalpos(newpos, 1);
    self notify("esc_littlebird_arrive");
    self waittill("goal");
    self vehicle_setspeed(self.speed / 3, self.accel / 4);
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "btm") {
    self notify("esc_littlebird_arrive");
  }
}

function tracegroundheight(x, y, rand, var_ffa2f7672c0c1531) {
  offgroundheight = 30;
  groundheight = tracegroundpoint(x, y, var_ffa2f7672c0c1531);
  trueheight = groundheight + offgroundheight;

  if(isDefined(rand)) {
    trueheight += randomint(rand);
  }

  return trueheight;
}

function tracegroundpoint(x, y, var_ffa2f7672c0c1531) {
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

  var_8bc8bdb284860e7e = 256;

  if(isDefined(var_ffa2f7672c0c1531)) {
    trc = ray_trace((x, y, currz), (x, y, z), ignorelist, undefined, undefined, 1);
  } else {
    trc = sphere_trace((x, y, currz), (x, y, z), 256, ignorelist, undefined, 1);
  }

  if(trc["position"][2] < minz) {
    hightrace = minz;
  } else {
    hightrace = trc["position"][2];
  }

  return hightrace;
}

function watchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread littlebirdleave();
}

function changemaxpitchrollwhenclosetogoal(pathgoal) {
  self endon("goal");
  self endon("death");
  self endon("leaving");

  for(;;) {
    if(distance2d(self.origin, pathgoal) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

function abortextractpickup() {
  thread littlebirdleave();
}