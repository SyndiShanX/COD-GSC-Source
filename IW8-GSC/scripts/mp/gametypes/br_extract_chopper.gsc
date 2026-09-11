/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_extract_chopper.gsc
*******************************************************/

function spawnextractchopper(var0, var1, var2, var3) {
  var4 = var0.origin;
  var5 = var4;
  var6 = (0, 0, 0);
  var7 = 24000;
  var8 = getEnt("airstrikeheight", "targetname");
  var9 = var8.origin[2];
  var10 = "jackal";
  var11 = level.mapcenter - var0.origin;
  var11 = (var11[0], var11[1], 0);
  var12 = vectorNormalize(var11);
  var13 = var12 * -10000 + (0, 0, 1) * var9;
  var14 = (var4[0], var4[1], var9);
  var15 = fakestreakinfo();
  var16 = spawn("trigger_radius", var4, 0, 90, 128);
  var16.angles = (0, 0, 0);
  var16.team = self.team;
  var16.ownerteam = self.team;
  var16.visibleteam = "any";
  var16.offset3d = (0, 0, 16);
  var16.location = var4;
  var17 = beginlittlebird(0, var13, var14, var15, var16, var1, self.team, var3);
  var17.onhelikilled = var2;
  var17.zone = var0;
  return var17;
}

function fakestreakinfo() {
  var0 = spawnStruct();
  var0.available = 1;
  var0.firednotify = "offhand_fired";
  var0.isgimme = 1;
  var0.kid = 5;
  var0.lifeid = 0;
  var0.madeavailabletime = gettime();
  var0.scriptuseagetype = "gesture_script_weapon";
  var0.streakname = "jackal";
  var0.streaksetupinfo = undefined;
  var0.variantid = -1;
  var0.weaponname = "ks_gesture_generic_mp";
  var0.objweapon = getcompleteweaponname(var0.weaponname);
  return var0;
}

function beginlittlebird(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = undefined;

  if(isDefined(var4)) {
    var8 = var4.marker;

    if(!isDefined(var8)) {
      var8 = spawnStruct();

      if(isDefined(var5)) {
        var8.location = var5;
      } else if(isDefined(var4.location)) {
        var8.location = var4.location;
      } else {
        var8.location = var4.trigger.origin;
      }

      var8.angles = (0, 0, 0);
      var8.string = "equip_deploy_succeeded";
      var8.visual = spawn("script_model", var8.location);
      var8.visual setModel("ks_marker_mp");
      var8.visual setotherent(self);
    }

    if(!isDefined(var8.location)) {
      self notify("cancel_littlebird");
      return 0;
    }
  }

  self notify("called_in_littlebird");
  var9 = getEnt("airstrikeheight", "targetname");

  if(isDefined(var9)) {
    var10 = var9.origin[2] + 500;
  } else {
    var10 = 1300;
  }

  if(isDefined(var9) && isDefined(var9.location)) {
    var3 = var9.location;
  }

  var3 *= (1, 1, 0);
  var11 = var3 + (0, 0, var10);
  var12 = spawnlittlebird(var1, self, var2, var11, var4, var5);
  var12.lz = var5;
  var12.pathgoal = var11;
  thread monitorarriveoverdestination(var12, var9, var7, var8);
  return var12;
}

function spawnlittlebird(var0, var1, var2, var3, var4, var5) {
  var6 = vectortoangles(var3 - var2);

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var7 = 99;
    var8 = 10000;
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    var7 = 99;
    var8 = 99999;
  } else {
    var7 = 1;
    var8 = 10000;
  }

  var9 = "veh8_mil_air_lbravo";
  var10 = spawnhelicopter(var5, var6, var8, "lbravo_infil_mp", var9);

  if(!isDefined(var10)) {
    return;
  }

  if(isDefined(var7)) {
    var10.lz = var7;
  }

  thread handledestroydamage();
  var10.damagecallback = &callback_vehicledamage;
  var10.speed = 50;
  var10.accel = 125;
  var10.health = var8;
  var10.maxhealth = var10.health;
  var10.team = var5.team;
  var10.owner = var5;
  var10 setCanDamage(1);
  var10.defendloc = var7;
  var10.lifeid = var4;
  var10.jackal = 1;
  var10.streakinfo = var8;
  var10.streakname = var8.streakname;
  var10.streakinfo = var8;
  var10.flaresreservecount = var7;
  var10 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var8.streakname, "Killstreak_Air", var5, 0, 1, 100);
  var10 setmaxpitchroll(0, 90);
  var10 vehicle_setspeed(var10.speed, var10.accel);
  var10 sethoverparams(50, 100, 50);
  var10 setturningability(0.05);
  var10 setyawspeed(45, 25, 25, 0.5);
  var10 setotherent(var5);
  var10.useobj = spawn("script_model", var10 gettagorigin("tag_origin"));
  var10.useobj linkTo(var10, "tag_origin");

  if(!isDefined(level.jackals)) {
    level.jackals = [];
  }

  level.jackals[level.jackals.size] = var10;
  level.jackals = scripts\engine\utility::array_removeundefined(level.jackals);
  var10 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  thread littlebirddestroyed();
  thread delay_jackal_arrive_sfx();
  return var10;
}

function delay_jackal_arrive_sfx() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
}

function delayjackalloopsfx(var0, var1) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);
  self playLoopSound(var1);
}

function littlebirddestroyed() {
  self endon("jackal_gone");
  var0 = self.owner;
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

  foreach(var1 in level.carepackagedropnodes) {
    var1.free = undefined;
  }

  self delete();
}

function littlebirdcrash(var0) {
  self endon("explode");
  self clearlookatent();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var0, var0, var0);
  self settargetyaw(self.angles[1] + var0 * 2.5);
}

function handledestroydamage() {
  self endon("death");
  self endon("leaving");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
    var9 = scripts\mp\utility\weapon::mapweapon(var9, var13);

    if((var9.basename == "aamissile_projectile_mp" || var9.basename == "nuke_mp") && var4 == "MOD_EXPLOSIVE" && var0 >= self.health) {
      if(isDefined(self.onhelikilled)) {
        [[self.onhelikilled]](self.team);
      }

      callback_vehicledamage(var1, var1, 9001, 0, var4, var9, var3, var2, var3, 0, 0, var7);
    }
  }
}

function callback_vehicledamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  if(isDefined(var1)) {
    if(isDefined(var1.owner)) {
      var1 = var1.owner;
    }
  }

  if((var1 == self || isDefined(var1.pers) && var1.pers["team"] == self.team && !level.friendlyfire && level.teambased) && var1 != self.owner) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  var2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var1, var5, var4, var2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var1, var5, self, var4, var2);
  var1 scripts\mp\damagefeedback::updatedamagefeedback("");
  scripts\mp\damage::logattackerkillstreak(self, var2, var1, var7, var6, var4, var10, undefined, var11, var3, createheadicon(var5));

  if(self.health <= var2) {
    if(isPlayer(var1) && (!isDefined(self.owner) || var1 != self.owner)) {
      scripts\mp\damage::onkillstreakkilled("jackal", var1, var5, var4, var2, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier");
    }
  }

  if(self.health - var2 <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
}

function monitorarriveoverdestination(var0, var1, var2, var3) {
  var0 endon("death");
  var0 endon("leaving");
  var0 setvehgoalpos(var0.pathgoal, 1);
  thread changemaxpitchrollwhenclosetogoal(var0);
  var0 waittill("goal");
  thread watchgameendleave();

  if(isDefined(var3)) {
    var4 = var0.speed;
    var5 = var0.accel;
  } else {
    var4 = var2.speed / 4;
    var5 = var2.accel / 6;
  }

  var2 vehicle_setspeed(var4, var5);
  littlebirddescendtoextraction(var2, var3.location, var2.zone, var4);
}

function littlebirdleave() {
  self endon("death");
  var0 = self.speed;
  var1 = self.accel;
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.leaving = 1;
  self clearlookatent();

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline)) {
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);
  }

  var2 = int(self.speed / 14);
  var3 = int(self.accel / 16);

  if(isDefined(var0)) {
    var2 = var0;
  }

  if(isDefined(var1)) {
    var3 = var1;
  }

  self vehicle_setspeed(var2, var3);
  var4 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var4 += (0, 0, 1000);
  self setvehgoalpos(var4, 1);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self waittill("goal");
  var5 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var5, 1);
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
  var0 = 150;
  var1 = 15000;
  var2 = self.angles[1];
  var3 = (0, var2, 0);
  var4 = self.origin + anglesToForward(var3) * var1;
  return var4;
}

function littlebirddescendtoextraction(var0, var1, var2) {
  descend(var0, var1);

  if(scripts\mp\utility\game::getgametype() != "vip" && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "btm") {
    var1.teamsextracting = scripts\engine\utility::array_remove(var1.teamsextracting, var2 + self.squadindex);
    thread littlebirdleave();
    return;
  }
}

function descend(var0, var1) {
  self endon("bugOut");
  var2 = undefined;
  var3 = var0[0];
  var4 = var0[1];
  var5 = tracegroundheight(var3, var4, 20);
  var2 = (var3, var4, var5);

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var5 = tracegroundheight(var3, var4, 5, 1);
    var2 = (var3, var4, var5 + 200);
  }

  self clearlookatent();
  self setvehgoalpos(var2, 1);
  self waittill("goal");

  if(scripts\mp\utility\game::getgametype() == "vip") {
    self notify("esc_littlebird_arrive");
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "arm") {
    self vehicle_setspeed(self.speed / 8, self.accel / 12);
    var5 = tracegroundheight(var3, var4, undefined, 1);
    var2 = (var3, var4, var5 + 120);
    self setvehgoalpos(var2, 1);
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

function tracegroundheight(var0, var1, var2, var3) {
  var4 = 30;
  var5 = tracegroundpoint(var0, var1, var3);
  var6 = var5 + var4;

  if(isDefined(var2)) {
    var6 += randomint(var2);
  }

  return var6;
}

function tracegroundpoint(var0, var1, var2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var3 = -99999;
  var4 = self.origin[2] + 2000;
  var5 = level.averagealliesz;
  var6 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var8 in self.dropcrates) {
      var6 = var8;
    }
  }

  var10 = 256;

  if(isDefined(var2)) {
    var11 = scripts\engine\trace::ray_trace((var0, var1, var4), (var0, var1, var3), var6, undefined, undefined, 1);
  } else {
    var11 = scripts\engine\trace::sphere_trace((var1, var2, var5), (var1, var2, var4), 256, var10, undefined, 1);
  }

  if(var11["position"][2] < var6) {
    var12 = var6;
  } else {
    var12 = var12["position"][2];
  }

  return var12;
}

function watchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread littlebirdleave();
}

function changemaxpitchrollwhenclosetogoal(var0) {
  self endon("goal");
  self endon("death");
  self endon("leaving");

  for(;;) {
    if(distance2d(self.origin, var0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

function abortextractpickup() {
  thread littlebirdleave();
}