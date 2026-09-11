/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_extract_chopper.gsc
*******************************************************/

function spawnextractchopper(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;
  var_5 = var_4;
  var_6 = (0, 0, 0);
  var_7 = 24000;
  var_8 = getEnt("airstrikeheight", "targetname");
  var_9 = var_8.origin[2];
  var_10 = "jackal";
  var_11 = level.mapcenter - var_0.origin;
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = vectorNormalize(var_11);
  var_13 = var_12 * -10000 + (0, 0, 1) * var_9;
  var_14 = (var_4[0], var_4[1], var_9);
  var_15 = fakestreakinfo();
  var_16 = spawn("trigger_radius", var_4, 0, 90, 128);
  var_16.angles = (0, 0, 0);
  var_16.team = self.team;
  var_16.ownerteam = self.team;
  var_16.visibleteam = "any";
  var_16.offset3d = (0, 0, 16);
  var_16.location = var_4;
  var_17 = beginlittlebird(0, var_13, var_14, var_15, var_16, var_1, self.team, var_3);
  var_17.onhelikilled = var_2;
  var_17.zone = var_0;
  return var_17;
}

function fakestreakinfo() {
  var_0 = spawnStruct();
  var_0.available = 1;
  var_0.firednotify = "offhand_fired";
  var_0.isgimme = 1;
  var_0.kid = 5;
  var_0.lifeid = 0;
  var_0.madeavailabletime = gettime();
  var_0.scriptuseagetype = "gesture_script_weapon";
  var_0.streakname = "jackal";
  var_0.streaksetupinfo = undefined;
  var_0.variantid = -1;
  var_0.weaponname = "ks_gesture_generic_mp";
  var_0.objweapon = getcompleteweaponname(var_0.weaponname);
  return var_0;
}

function beginlittlebird(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = undefined;

  if(isDefined(var_4)) {
    var_8 = var_4.marker;

    if(!isDefined(var_8)) {
      var_8 = spawnStruct();

      if(isDefined(var_5)) {
        var_8.location = var_5;
      } else if(isDefined(var_4.location)) {
        var_8.location = var_4.location;
      } else {
        var_8.location = var_4.trigger.origin;
      }

      var_8.angles = (0, 0, 0);
      var_8.string = "equip_deploy_succeeded";
      var_8.visual = spawn("script_model", var_8.location);
      var_8.visual setModel("ks_marker_mp");
      var_8.visual setotherent(self);
    }

    if(!isDefined(var_8.location)) {
      self notify("cancel_littlebird");
      return 0;
    }
  }

  self notify("called_in_littlebird");
  var_9 = getEnt("airstrikeheight", "targetname");

  if(isDefined(var_9)) {
    var_10 = var_9.origin[2] + 500;
  } else {
    var_10 = 1300;
  }

  if(isDefined(var_9) && isDefined(var_9.location)) {
    var_3 = var_9.location;
  }

  var_3 *= (1, 1, 0);
  var_11 = var_3 + (0, 0, var_10);
  var_12 = spawnlittlebird(var_1, self, var_2, var_11, var_4, var_5);
  var_12.lz = var_5;
  var_12.pathgoal = var_11;
  thread monitorarriveoverdestination(var_12, var_9, var_7, var_8);
  return var_12;
}

function spawnlittlebird(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_3 - var_2);

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var_7 = 99;
    var_8 = 10000;
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    var_7 = 99;
    var_8 = 99999;
  } else {
    var_7 = 1;
    var_8 = 10000;
  }

  var_9 = "veh8_mil_air_lbravo";
  var_10 = spawnhelicopter(var_5, var_6, var_8, "lbravo_infil_mp", var_9);

  if(!isDefined(var_10)) {
    return;
  }

  if(isDefined(var_7)) {
    var_10.lz = var_7;
  }

  thread handledestroydamage();
  var_10.damagecallback = &callback_vehicledamage;
  var_10.speed = 50;
  var_10.accel = 125;
  var_10.health = var_8;
  var_10.maxhealth = var_10.health;
  var_10.team = var_5.team;
  var_10.owner = var_5;
  var_10 setCanDamage(1);
  var_10.defendloc = var_7;
  var_10.lifeid = var_4;
  var_10.jackal = 1;
  var_10.streakinfo = var_8;
  var_10.streakname = var_8.streakname;
  var_10.streakinfo = var_8;
  var_10.flaresreservecount = var_7;
  var_10 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var_8.streakname, "Killstreak_Air", var_5, 0, 1, 100);
  var_10 setmaxpitchroll(0, 90);
  var_10 vehicle_setspeed(var_10.speed, var_10.accel);
  var_10 sethoverparams(50, 100, 50);
  var_10 setturningability(0.05);
  var_10 setyawspeed(45, 25, 25, 0.5);
  var_10 setotherent(var_5);
  var_10.useobj = spawn("script_model", var_10 gettagorigin("tag_origin"));
  var_10.useobj linkTo(var_10, "tag_origin");

  if(!isDefined(level.jackals)) {
    level.jackals = [];
  }

  level.jackals[level.jackals.size] = var_10;
  level.jackals = scripts\engine\utility::array_removeundefined(level.jackals);
  var_10 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  thread littlebirddestroyed();
  thread delay_jackal_arrive_sfx();
  return var_10;
}

function delay_jackal_arrive_sfx() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
}

function delayjackalloopsfx(var_0, var_1) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self playLoopSound(var_1);
}

function littlebirddestroyed() {
  self endon("jackal_gone");
  var_0 = self.owner;
  self waittill("death");

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline)) {
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);
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
    playFXOnTag(scripts\engine\utility::getfx("jackal_explosion"), self, "tag_origin");
  }

  wait 0.35;
  thread littlebirddelete();
}

function littlebirddelete() {
  scripts\mp\utility\print::printgameaction("killstreak ended - jackal", self.owner);

  if(isDefined(self.turret)) {
    self.turret delete();
  }

  if(isDefined(self.cannon)) {
    self.cannon delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  foreach(var_1 in level.carepackagedropnodes) {
    var_1.free = undefined;
  }

  self delete();
}

function littlebirdcrash(var_0) {
  self endon("explode");
  self clearlookatent();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

function handledestroydamage() {
  self endon("death");
  self endon("leaving");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::mapweapon(var_9, var_13);

    if((var_9.basename == "aamissile_projectile_mp" || var_9.basename == "nuke_mp") && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health) {
      if(isDefined(self.onhelikilled)) {
        [[self.onhelikilled]](self.team);
      }

      callback_vehicledamage(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
    }
  }
}

function callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level.friendlyfire && level.teambased) && var_1 != self.owner) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  var_2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self, var_4, var_2);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("");
  scripts\mp\damage::logattackerkillstreak(self, var_2, var_1, var_7, var_6, var_4, var_10, undefined, var_11, var_3, createheadicon(var_5));

  if(self.health <= var_2) {
    if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
      scripts\mp\damage::onkillstreakkilled("jackal", var_1, var_5, var_4, var_2, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier");
    }
  }

  if(self.health - var_2 <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

function monitorarriveoverdestination(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("leaving");
  var_0 setvehgoalpos(var_0.pathgoal, 1);
  thread changemaxpitchrollwhenclosetogoal(var_0);
  var_0 waittill("goal");
  thread watchgameendleave();

  if(isDefined(var_3)) {
    var_4 = var_0.speed;
    var_5 = var_0.accel;
  } else {
    var_4 = var_2.speed / 4;
    var_5 = var_2.accel / 6;
  }

  var_2 vehicle_setspeed(var_4, var_5);
  littlebirddescendtoextraction(var_2, var_3.location, var_2.zone, var_4);
}

function littlebirdleave() {
  self endon("death");
  var_0 = self.speed;
  var_1 = self.accel;
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.leaving = 1;
  self clearlookatent();

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline)) {
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);
  }

  var_2 = int(self.speed / 14);
  var_3 = int(self.accel / 16);

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  self vehicle_setspeed(var_2, var_3);
  var_4 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_4 += (0, 0, 1000);
  self setvehgoalpos(var_4, 1);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self waittill("goal");
  var_5 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_5, 1);
  self waittill("goal");
  self stoploopsound();
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("jackal_gone");

  if(scripts\mp\utility\game::getgametype() != "arm") {
    littlebirddelete();
    return;
  }
}

function getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

function littlebirddescendtoextraction(var_0, var_1, var_2) {
  descend(var_0, var_1);

  if(scripts\mp\utility\game::getgametype() != "vip" && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "btm") {
    var_1.teamsextracting = scripts\engine\utility::array_remove(var_1.teamsextracting, var_2 + self.squadindex);
    thread littlebirdleave();
    return;
  }
}

function descend(var_0, var_1) {
  self endon("bugOut");
  var_2 = undefined;
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = tracegroundheight(var_3, var_4, 20);
  var_2 = (var_3, var_4, var_5);

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var_5 = tracegroundheight(var_3, var_4, 5, 1);
    var_2 = (var_3, var_4, var_5 + 200);
  }

  self clearlookatent();
  self setvehgoalpos(var_2, 1);
  self waittill("goal");

  if(scripts\mp\utility\game::getgametype() == "vip") {
    self notify("esc_littlebird_arrive");
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "arm") {
    self vehicle_setspeed(self.speed / 8, self.accel / 12);
    var_5 = tracegroundheight(var_3, var_4, undefined, 1);
    var_2 = (var_3, var_4, var_5 + 120);
    self setvehgoalpos(var_2, 1);
    self notify("esc_littlebird_arrive");
    self waittill("goal");
    self vehicle_setspeed(self.speed / 3, self.accel / 4);
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "btm") {
    self notify("esc_littlebird_arrive");
    return;
  }
}

function tracegroundheight(var_0, var_1, var_2, var_3) {
  var_4 = 30;
  var_5 = tracegroundpoint(var_0, var_1, var_3);
  var_6 = var_5 + var_4;

  if(isDefined(var_2)) {
    var_6 += randomint(var_2);
  }

  return var_6;
}

function tracegroundpoint(var_0, var_1, var_2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_3 = -99999;
  var_4 = self.origin[2] + 2000;
  var_5 = level.averagealliesz;
  var_6 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var_8 in self.dropcrates) {
      var_6 = var_8;
    }
  }

  var_10 = 256;

  if(isDefined(var_2)) {
    var_11 = scripts\engine\trace::ray_trace((var_0, var_1, var_4), (var_0, var_1, var_3), var_6, undefined, undefined, 1);
  } else {
    var_11 = scripts\engine\trace::sphere_trace((var_1, var_2, var_5), (var_1, var_2, var_4), 256, var_10, undefined, 1);
  }

  if(var_11["position"][2] < var_6) {
    var_12 = var_6;
  } else {
    var_12 = var_12["position"][2];
  }

  return var_12;
}

function watchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread littlebirdleave();
}

function changemaxpitchrollwhenclosetogoal(var_0) {
  self endon("goal");
  self endon("death");
  self endon("leaving");

  for(;;) {
    if(distance2d(self.origin, var_0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

function abortextractpickup() {
  thread littlebirdleave();
}