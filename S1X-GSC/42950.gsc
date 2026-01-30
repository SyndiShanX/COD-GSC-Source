/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42950.gsc
**************************************/

init() {
  setdvar("missileRemoteSteerPitchRange", "60 87");
  level._missile_strike_setting = [];
  level._missile_strike_setting["Particle_FX"] = spawnStruct();
  level._missile_strike_setting["Particle_FX"].gas = loadfx("vfx/unique/vfx_killstreak_missilestrike_dna");
  level._missile_strike_setting["Particle_FX"].gasfriendly = loadfx("vfx/unique/vfx_killstreak_missilestrike_dna_friendly");
  level._missile_strike_setting["Audio"] = spawnStruct();
  level._missile_strike_setting["Launch_Value"] = spawnStruct();
  var_0 = getdvar("mapname");

  if(var_0 == "mp_suburbia") {
    level._missile_strike_setting["Launch_Value"].vert = 7000;
    level._missile_strike_setting["Launch_Value"].horz = 10000;
    level._missile_strike_setting["Launch_Value"].targetdest = 2000;
  } else if(var_0 == "mp_mainstreet") {
    level._missile_strike_setting["Launch_Value"].vert = 7000;
    level._missile_strike_setting["Launch_Value"].horz = 10000;
    level._missile_strike_setting["Launch_Value"].targetdest = 2000;
  } else {
    level._missile_strike_setting["Launch_Value"].vert = 24000;
    level._missile_strike_setting["Launch_Value"].horz = 7000;
    level._missile_strike_setting["Launch_Value"].targetdest = 1500;
  }

  level.rockets = [];
  level.missile_strike_gas_clouds = [];
  level.killstreakfuncs["missile_strike"] = ::tryusemissilestrike;
  level.killstreakwieldweapons["remotemissile_projectile_mp"] = "missile_strike";
  level.killstreakwieldweapons["remotemissile_projectile_gas_mp"] = "missile_strike";
  level.killstreakwieldweapons["remotemissile_projectile_cluster_parent_mp"] = "missile_strike";
  level.killstreakwieldweapons["remotemissile_projectile_cluster_child_mp"] = "missile_strike";
  level.killstreakwieldweapons["remotemissile_projectile_cluster_child_hellfire_mp"] = "missile_strike";
  level.killstreakwieldweapons["remotemissile_projectile_secondary_mp"] = "missile_strike";
  level.killstreakwieldweapons["killstreak_strike_missile_gas_mp"] = "missile_strike";
  level.remotemissile_fx["explode"] = loadfx("vfx/explosion/rocket_explosion_airburst");
  thread onplayerconnect();
}

tryusemissilestrike(var_0, var_1) {
  var_2 = maps\mp\killstreaks\_killstreaks::initridekillstreak("missile_strike");

  if(var_2 != "success") {
    return 0;
  }

  maps\mp\_utility::playersaveangles();
  maps\mp\_utility::setusingremote("missile_strike");
  var_3 = buildweaponsettings(var_1);

  if(isDefined(level.ishorde) && level.ishorde) {
    self.missileweapon = var_3;

    if(self.killstreakindexweapon == 1) {
      self notify("used_horde_missile_strike");
    }
  }

  level thread _fire(var_0, self, var_3);
  return 1;
}

buildweaponsettings(var_0) {
  var_1 = spawnStruct();
  var_1.modules = var_0;
  var_1.name = "remotemissile_projectile_mp";
  var_1.gasmissile = 0;
  var_1.clustermissile = 0;
  var_1.clusterhellfire = 0;
  var_1.clusterspiral = 0;

  if(common_scripts\utility::array_contains(var_1.modules, "missile_strike_hellfire")) {
    var_1.name = "remotemissile_projectile_cluster_parent_mp";
    var_1.clustermissile = 1;
    var_1.clusterhellfire = 1;
  }

  if(common_scripts\utility::array_contains(var_1.modules, "missile_strike_cluster")) {
    var_1.name = "remotemissile_projectile_cluster_parent_mp";
    var_1.clustermissile = 1;
    var_1.clusterspiral = 1;
    thread prespawnclusterrotationentities(var_1);
  } else if(common_scripts\utility::array_contains(var_1.modules, "missile_strike_chem")) {
    var_1.name = "remotemissile_projectile_gas_mp";
    var_1.gasmissile = 1;
  }

  var_1.rocketammo = 1;

  if(common_scripts\utility::array_contains(var_1.modules, "missile_strike_extra_1")) {
    var_1.rocketammo++;
  }

  if(common_scripts\utility::array_contains(var_1.modules, "missile_strike_extra_2")) {
    var_1.rocketammo++;
  }

  return var_1;
}

prespawnclusterrotationentities(var_0) {
  var_1 = (0, 0, -1000);
  var_0.prespawnedkillcament = spawn("script_model", var_1);
  var_0.prespawnedkillcament setcontents(0);
  var_0.prespawnedkillcament setscriptmoverkillcam("large explosive");
  waitframe();
  var_0.prespawnedrotationents = [];
  var_0.prespawnedindex = 0;

  for(var_2 = 0; var_2 < 12; var_2++) {
    var_3 = spawn("script_origin", var_1);
    var_0.prespawnedrotationents[var_0.prespawnedrotationents.size] = var_3;
    waitframe();
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread waitingforspawnduringstreak();
  }
}

waitingforspawnduringstreak() {
  self waittill("spawned_player");
  self.missilestrikegastime = 0;
  thread creategastrackingoverlay();
  thread waitforgasdamage();
}

getbestspawnpoint(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3.validplayers = [];
    var_3.spawnscore = 0;
  }

  foreach(var_6 in level.players) {
    if(!maps\mp\_utility::isreallyalive(var_6)) {
      continue;
    }
    if(var_6.team == self.team) {
      continue;
    }
    if(var_6.team == "spectator") {
      continue;
    }
    var_7 = 999999999;
    var_8 = undefined;

    foreach(var_3 in var_0) {
      var_3.validplayers[var_3.validplayers.size] = var_6;
      var_10 = distance2d(var_3.targetent.origin, var_6.origin);

      if(var_10 <= var_7) {
        var_7 = var_10;
        var_8 = var_3;
      }
    }

    var_8.spawnscore = var_8.spawnscore + 2;
  }

  var_13 = var_0[0];

  foreach(var_3 in var_0) {
    foreach(var_6 in var_3.validplayers) {
      var_3.spawnscore = var_3.spawnscore + 1;

      if(bullettracepassed(var_6.origin + (0, 0, 32), var_3.origin, 0, var_6)) {
        var_3.spawnscore = var_3.spawnscore + 3;
      }

      if(var_3.spawnscore > var_13.spawnscore) {
        var_13 = var_3;
        continue;
      }

      if(var_3.spawnscore == var_13.spawnscore) {
        if(common_scripts\utility::cointoss()) {
          var_13 = var_3;
        }
      }
    }
  }

  return var_13;
}

_fire(var_0, var_1, var_2) {
  var_3 = var_2.name;
  var_1 playeraddnotifycommands();
  var_4 = fireorbitalmissile(var_1, var_3);

  if(isDefined(level.ishorde) && level.ishorde) {
    var_1.rocket = var_4;
  }

  var_2.rocketammo--;

  if(var_2.rocketammo > 0 || var_2.clustermissile) {
    var_4 disablemissileboosting();
  }

  var_4.owner = var_1;
  var_4.team = var_1.team;
  var_4.lifeid = var_0;
  var_4.type = "remote";
  level.remotemissileinprogress = 1;
  var_4 thread maps\mp\gametypes\_damage::setentitydamagecallback(10, undefined, ::missilestrikeondeath, undefined, 1);

  if(isDefined(level.ishorde) && level.ishorde) {
    var_4 thread rocketimpact_dronekillcheck(var_1);
  }

  var_4 setmissileminimapvisible(1);
  var_4 playsoundtoteam("mstrike_entry_npc", maps\mp\_utility::getotherteam(var_4.team));
  var_4 playsoundtoteam("mstrike_entry_npc", var_4.team, var_1);
  missileeyes(var_1, var_4, var_2);
}

rocketimpact_dronekillcheck(var_0) {
  self waittill("death");

  if(isDefined(level.flying_attack_drones)) {
    foreach(var_2 in level.flying_attack_drones) {
      if(var_2.origin[2] > self.origin[2] && var_2.origin[2] < self.origin[2] + 1200 && distance2dsquared(var_2.origin, self.origin) < 40000) {
        var_2 dodamage(350, self.origin, var_0, var_0, "MOD_PROJECTILE_SPLASH", "remotemissile_projectile_mp");
      }
    }
  }
}

missilestrikeondeath(var_0, var_1, var_2, var_3) {
  if(isDefined(level.ishorde) && level.ishorde) {
    if(isDefined(self.owner)) {
      self.owner.missileweapon = undefined;
      self.owner.rocket = undefined;
    }
  }

  playFX(level.remotemissile_fx["explode"], self.origin);
  maps\mp\gametypes\_damage::onkillstreakkilled(var_0, var_1, var_2, var_3, "missile_strike_destroyed", undefined, undefined, 0);
  self delete();
}

fireorbitalmissile(var_0, var_1) {
  var_2 = maps\mp\killstreaks\_aerial_utility::getentorstructarray("remoteMissileSpawn", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.target)) {
      var_4.targetent = getent(var_4.target, "targetname");
    }
  }

  if(var_2.size > 0) {
    var_6 = var_0 getbestspawnpoint(var_2);
  } else {
    var_6 = undefined;
  }

  var_7 = undefined;
  var_8 = undefined;

  if(isDefined(var_6)) {
    var_7 = var_6.origin;
    var_8 = var_6.targetent.origin;
    var_9 = 24000;

    if(isDefined(level.remote_missile_height_override)) {
      var_9 = level.remote_missile_height_override;
    }

    var_10 = vectornormalize(var_7 - var_8);
    var_7 = var_10 * var_9 + var_8;
  } else {
    var_11 = (0, 0, level._missile_strike_setting["Launch_Value"].vert);
    var_9 = level._missile_strike_setting["Launch_Value"].horz;
    var_12 = level._missile_strike_setting["Launch_Value"].targetdest;
    var_13 = anglesToForward(var_0.angles);
    var_7 = var_0.origin + var_11 + var_13 * var_9 * -1;
    var_8 = var_0.origin + var_13 * var_12;
  }

  return magicbullet(var_1, var_7, var_8, var_0);
}

missileeyes(var_0, var_1, var_2) {
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  var_2 endon("missile_strike_complete");
  var_0 endon("disconnect");
  var_1 thread rocket_cleanupondeath();
  var_0 thread player_cleanupongameended(var_1, var_2);
  var_0 thread player_cleanuponteamchange(var_1, var_2);
  var_0.clusterdeployed = 0;
  var_0.missileboostused = 0;
  var_0 cameralinkto(var_1, "tag_origin");
  var_0 controlslinkto(var_1);

  if(getdvarint("camera_thirdPerson")) {
    var_0 maps\mp\_utility::setthirdpersondof(0);
  }

  var_0 thread init_hud(var_1, var_2);
  var_0 thread playerwaitreset(var_2);

  if(var_2.clustermissile) {
    var_0 thread watchforclustersplit(var_1, var_2);
  }

  if(var_2.rocketammo <= 0 && !var_2.clustermissile) {
    var_1 enablemissileboosting();
    var_0 thread hud_watch_for_boost_active(var_1, var_2);
  } else {
    var_0 thread watchforextramissilefire(var_1, var_2);
  }

  var_0 thread playerwatchforearlyexit(var_2);
  var_1 waittill("death");

  if(var_2.gasmissile) {
    if(isDefined(var_1)) {
      var_0 thread releasegas(var_1.origin);
    }
  }

  if(isDefined(var_1)) {
    var_0 maps\mp\_matchdata::logkillstreakevent("missile_strike", var_1.origin);
  }

  var_2 notify("missile_strike_complete");
}

playerwatchforearlyexit(var_0) {
  level endon("game_ended");
  var_0 endon("missile_strike_complete");
  self endon("disconnect");

  for(;;) {
    var_1 = 0;

    while(self usebuttonpressed()) {
      var_1 = var_1 + 0.05;

      if(var_1 > 0.5) {
        var_0 notify("ms_early_exit");
        return;
      }

      waitframe();
    }

    waitframe();
  }
}

playerwaitreset(var_0) {
  var_0 common_scripts\utility::waittill_either("missile_strike_complete", "ms_early_exit");
  playerreset();
}

playerreset() {
  self endon("disconnect");
  self controlsunlink();
  maps\mp\_utility::freezecontrolswrapper(1);
  playerremovenotifycommands();
  stopmissileboostsounds();

  if(!level.gameended || isDefined(self.finalkill)) {
    maps\mp\killstreaks\_aerial_utility::playershowfullstatic();
  }

  wait 0.5;
  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  remove_hud();
  self cameraunlink();
  maps\mp\_utility::freezecontrolswrapper(0);

  if(maps\mp\_utility::isusingremote()) {
    maps\mp\_utility::clearusingremote();
  }

  if(getdvarint("camera_thirdPerson")) {
    maps\mp\_utility::setthirdpersondof(1);
  }

  maps\mp\_utility::playerrestoreangles();

  if(isDefined(level.script)) {
    self visionsetnakedforplayer(level.script, 0.0);
  }

  maps\mp\_utility::revertvisionsetforplayer(0.02);
}

stopmissileboostsounds() {
  self stoplocalsound("mstrike_boost_shot");
  self stoplocalsound("mstrike_boost_boom");
  self stoplocalsound("mstrike_boost_swoop");
  self stoplocalsound("mstrike_boost_jet");
  self stoplocalsound("mstrike_boost_roar");
}

watchforextramissilefire(var_0, var_1) {
  var_0 endon("death");
  wait 0.5;

  for(;;) {
    self waittill("FireButtonPressed");

    if(var_1.rocketammo > 0) {
      thread firebabymissile(var_0, var_1);
    } else {
      break;
    }

    wait 0.1;
  }
}

enableboost(var_0) {
  wait 0.5;
  var_0 enablemissileboosting();
}

firebabymissile(var_0, var_1) {
  var_2 = var_1.name;
  var_3 = (0, 32, 0);
  var_4 = var_1.rocketammo % 2;

  if(var_4 == 0) {
    var_3 = (0, -64, 0);
  }

  var_5 = var_0.origin + anglesToForward(var_0.angles) * 32000;
  var_6 = bulletTrace(var_0.origin, var_5, 0, var_0, 0, 0, 0, 1, 0);
  var_7 = var_0.origin + var_3 + anglesToForward(var_0.angles) * 750;
  var_8 = var_6["position"];
  var_9 = magicbullet("remotemissile_projectile_secondary_mp", var_7, var_8, self);

  if(!isDefined(var_9)) {
    return;
  }
  var_1.rocketammo--;

  if(var_1.rocketammo <= 0 && !var_1.clustermissile) {
    hud_update_fire_text(var_9, var_1);
    thread hud_watch_for_boost_active(var_0, var_1);
    thread enableboost(var_0);
  }

  if(isDefined(var_2)) {
    if(isDefined(var_0.targets) && var_0.targets.size) {
      var_9 missile_settargetent(var_0.targets[0]);
    }
  }

  var_9.team = self.team;
  var_9 setmissileminimapvisible(1);
  self playrumbleonentity("sniper_fire");
  earthquake(0.2, 0.2, var_0.origin, 200);
  var_9 thread maps\mp\gametypes\_damage::setentitydamagecallback(10, undefined, ::missilestrikeondeath, undefined, 1);
}

watchforclustersplit(var_0, var_1) {
  var_1 endon("missile_strike_complete");
  self endon("spawned_player");
  var_0 endon("death");

  while(var_1.rocketammo > 0) {
    self waittill("FireButtonPressed");
  }

  wait 0.25;
  self waittill("FireButtonPressed");
  self.clusterdeployed = 1;
  hud_update_fire_text(var_0, var_1);
  thread split_rocket(var_0, var_1);
}

split_rocket(var_0, var_1) {
  if(var_1.clusterhellfire) {
    thread split_rocket_hellfire(var_0, var_1);
  } else {
    thread split_rocket_spiral(var_0, var_1);
  }
}

split_rocket_hellfire(var_0, var_1) {
  var_2 = 2;
  var_3 = [];

  if(isDefined(var_0.targets) && var_0.targets.size) {
    var_3 = var_0.targets;
  }

  thread fire_straight_bomblet(var_0, 0, var_1);

  foreach(var_5 in var_3) {
    thread fire_targeted_bomblet(var_0, var_5, var_2, var_1);
    var_2++;
  }

  for(var_7 = var_3.size; var_7 <= 8; var_7++) {
    thread fire_random_bomblet(var_0, var_7 % 6, var_2, var_1);
    var_2++;
  }

  self playrumbleonentity("sniper_fire");
  earthquake(0.2, 0.2, var_0.origin, 200);
  var_0 setmissilecoasting(1);
  thread fade_to_white();
  thread bomblet_camera_waiter(var_0, var_1);
}

split_rocket_spiral(var_0, var_1) {
  var_1 endon("missile_strike_complete");
  self endon("spawned_player");
  var_0 endon("death");
  thread fade_to_white();
  self waittill("full_white");
  thread maps\mp\_utility::freezecontrolswrapper(1);

  if(!isDefined(var_0)) {
    return;
  }
  self.strikerocketstoredposition = var_0.origin;
  self.strikerocketstoredangles = var_0.angles;
  var_2 = distance(var_0.origin, self.origin) + 10000;
  var_3 = var_0.origin + anglesToForward(var_0.angles) * var_2;
  var_4 = self.strikerocketstoredposition;
  var_5 = var_0.origin + anglesToForward(var_0.angles) * 3250;
  var_0 setmissilecoasting(1);
  thread bomblet_camera_waiter(var_0, var_1);
  thread spawnclusterchildren(var_3, self.strikerocketstoredposition, var_5, var_1);
  self waittill("fade_white_over");
  wait 9;
  maps\mp\_utility::freezecontrolswrapper(0);
}

fire_straight_bomblet(var_0, var_1, var_2) {
  var_2 endon("missile_strike_complete");
  var_3 = var_0.origin;
  var_4 = var_0.angles;
  var_5 = var_0.owner;

  if(var_1 > 0) {
    wait(var_1 * 0.05);
  }

  var_6 = magicbullet("remotemissile_projectile_cluster_child_hellfire_mp", var_3, var_3 + anglesToForward(var_4) * 1000, self);
  var_6.team = self.team;
  var_6.killcament = self;
  var_6 setmissileminimapvisible(1);
  var_6 thread bomblet_explosion_waiter(self, var_2);
}

fire_targeted_bomblet(var_0, var_1, var_2, var_3) {
  var_3 endon("missile_strike_complete");
  var_4 = var_0.origin;
  var_5 = var_0.angles;
  var_6 = var_0.owner;
  var_7 = var_1.origin;
  wait(var_2 * 0.05);

  if(isDefined(var_1) && distance2dsquared(var_1.origin, var_7) < 57600.0) {
    var_7 = var_1.origin;
  }

  var_8 = magicbullet("remotemissile_projectile_cluster_child_hellfire_mp", var_4, var_7, self);
  var_8.team = self.team;
  var_8.killcament = self;

  if(isDefined(var_1)) {
    var_8 missile_settargetent(var_1);
  }

  var_8 setmissileminimapvisible(1);
  var_8 thread bomblet_explosion_waiter(self, var_3);
}

fire_random_bomblet(var_0, var_1, var_2, var_3) {
  var_3 endon("missile_strike_complete");
  var_4 = 600;
  var_5 = var_0.origin;
  var_6 = var_0.angles;
  var_7 = var_0.owner;
  var_8 = var_0.aimtarget;
  wait(var_2 * 0.05);
  var_9 = randomintrange(10 + 60 * var_1, 50 + 60 * var_1);
  var_10 = randomintrange(200, var_4 + 100);
  var_11 = min(var_10, var_4 - 50) * cos(var_9);
  var_12 = min(var_10, var_4 - 50) * sin(var_9);
  var_13 = magicbullet("remotemissile_projectile_cluster_child_hellfire_mp", var_5, var_8 + (var_11, var_12, 0), self);
  var_13.team = self.team;
  var_13.killcament = self;
  var_13 setmissileminimapvisible(1);
  var_13 thread bomblet_explosion_waiter(self, var_3);
}

bomblet_explosion_waiter(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("ms_early_exit");
  var_1 endon("missile_strike_complete");
  level endon("game_ended");
  self waittill("death");
  var_1 notify("bomblet_exploded");
}

bomblet_camera_waiter(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("ms_early_exit");
  var_1 endon("missile_strike_complete");
  var_0 endon("death");
  level endon("game_ended");
  var_1 waittill("bomblet_exploded");
  wait 1.0;
  thread bomblet_camera_waiter_complete(var_0, var_1);
}

bomblet_camera_waiter_complete(var_0, var_1) {
  var_0 notify("death");
  var_1 notify("missile_strike_complete");
}

getprespawnedclusterrotationent(var_0, var_1) {
  while(var_0.prespawnedrotationents.size < var_0.prespawnedindex + 1) {
    waitframe();
  }

  var_2 = var_0.prespawnedrotationents[var_0.prespawnedindex];
  var_0.prespawnedindex++;

  if(isDefined(var_1)) {
    var_2.origin = var_1;
  }

  return var_2;
}

spawnclusterchildren(var_0, var_1, var_2, var_3) {
  var_4 = randomintrange(16, 64);

  if(randomint(100) > 50) {
    var_4 = var_4 * -1;
  }

  var_5 = randomintrange(16, 64);

  if(randomint(100) > 50) {
    var_5 = var_5 * -1;
  }

  var_6 = var_1 + (var_4, var_5, 0);
  var_7 = var_2 + (var_4, var_5, 0);
  var_8 = getprespawnedclusterrotationent(var_3, var_2);
  var_8.rotatinglinkarray = [];
  var_8.rotatinglinkarray[0] = getprespawnedclusterrotationent(var_3, var_7);
  var_8.rotatinglinkarray[0] linktosynchronizedparent(var_8);
  var_9 = magicbullet("remotemissile_projectile_cluster_child_mp", var_6, var_7, self);
  var_9 missile_settargetent(var_8.rotatinglinkarray[0]);
  var_9 missile_setflightmodedirect();
  var_9.owner = self;
  var_9.team = self.team;
  var_9 setmissileminimapvisible(1);
  var_9 thread bomblet_explosion_waiter(self, var_3);
  var_10 = var_7 - var_6;
  var_10 = vectornormalize((var_10[0], var_10[1], 0));
  var_10 = var_10 * -30;
  var_10 = var_10 + (0, 0, 200);
  var_11 = var_3.prespawnedkillcament;
  var_11.origin = var_6 + var_10;
  var_11.killcamstarttime = gettime();
  var_11 linkto(var_9);
  var_11 thread killcamrocketdeath(var_9);
  var_9.killcament = var_11;
  var_12 = 10;
  var_3.rotatinglinkarrayindex = var_8.rotatinglinkarray.size;

  for(var_13 = 0; var_13 < var_12; var_13++) {
    var_14 = var_8.rotatinglinkarray.size;
    var_8.rotatinglinkarray[var_14] = getprespawnedclusterrotationent(var_3);
  }

  var_9 endon("death");
  thread deleterotationents(var_8, var_9);
  thread rotatetargets(var_8, var_9);
  thread movetargets(var_8, var_9);
  waitframe();

  for(var_13 = 1; var_13 <= var_12; var_13++) {
    var_15 = getmissileposition(var_1, var_2, var_8, var_3);
    var_7 = var_15.origin;
    var_6 = var_15.randomposition;
    var_16 = magicbullet("remotemissile_projectile_cluster_child_mp", var_6, var_7, self);
    var_16 missile_settargetent(var_8.rotatinglinkarray[var_13]);
    var_16 missile_setflightmodedirect();
    var_16.owner = self;
    var_16.team = self.team;
    var_16.killcament = var_11;
    var_16 setmissileminimapvisible(1);
    var_16 thread bomblet_explosion_waiter(self, var_3);
    waitframe();
  }
}

getmissileposition(var_0, var_1, var_2, var_3) {
  var_4 = var_2.rotatinglinkarray[var_3.rotatinglinkarrayindex];
  var_3.rotatinglinkarrayindex++;
  var_5 = var_2.origin - var_1;
  var_0 = var_0 + var_5;
  var_6 = randomintrange(64, 500);
  var_7 = var_6 + 0;

  if(randomint(100) > 50) {
    var_6 = var_6 * -1;
    var_7 = var_6 - 0;
  }

  var_8 = randomintrange(64, 500);
  var_9 = var_8 + 0;

  if(randomint(100) > 50) {
    var_8 = var_8 * -1;
    var_9 = var_8 - 0;
  }

  var_10 = var_0 + (var_6, var_8, 0);
  var_11 = var_2.origin + (var_7, var_9, 0);
  var_4.origin = var_11;
  var_4.randomposition = var_10;
  var_4 linktosynchronizedparent(var_2);
  return var_4;
}

killcamrocketdeath(var_0) {
  self endon("death");
  var_0 waittill("death");
  self unlink();
  self.origin = self.origin + (0, 0, 50);
  wait 3;
  self delete();
}

rotatetargets(var_0, var_1) {
  var_1 endon("death");
  var_2 = 10;

  for(;;) {
    var_0 rotatevelocity((0, 120, 0), var_2);
    wait(var_2);
  }
}

movetargets(var_0, var_1) {
  var_1 endon("death");
  var_2 = var_1.origin;
  var_3 = distance(var_1.origin, var_0.origin);
  var_4 = self.strikerocketstoredangles;
  var_5 = self.strikerocketstoredposition;

  for(;;) {
    var_6 = distance(var_1.origin, var_2);
    var_7 = var_5 + anglesToForward(var_4) * (var_3 + var_6);
    var_0.origin = var_7;
    waitframe();
  }
}

deleterotationents(var_0, var_1) {
  var_1 waittill("death");

  if(isDefined(var_0)) {
    foreach(var_3 in var_0.rotatinglinkarray) {
      var_3 delete();
    }

    var_0 delete();
  }
}

releasegas(var_0) {
  var_1 = var_0 + (0, 0, 40);
  var_2 = spawn("script_model", var_1);
  var_2 setModel("tag_origin");
  var_3 = spawn("script_model", var_2.origin);
  var_2.killcament = var_3;
  var_2.killcament setscriptmoverkillcam("explosive");
  var_2.killcament linktosynchronizedparent(var_2);
  var_4 = spawnStruct();
  var_4.origin = var_1;
  var_4.team = self.team;
  level.missile_strike_gas_clouds[level.missile_strike_gas_clouds.size] = var_4;
  var_2 thread showgascloud(self);
  var_2.objidenemy = maps\mp\gametypes\_gameobjects::getnextobjid();
  objective_add(var_2.objidenemy, "active", var_2.origin, "hud_gas_enemy");
  objective_playerenemyteam(var_2.objidenemy, self getentitynumber());
  var_2.objidfriendly = maps\mp\gametypes\_gameobjects::getnextobjid();
  objective_add(var_2.objidfriendly, "active", var_2.origin, "hud_gas_friendly");
  objective_playerteam(var_2.objidfriendly, self getentitynumber());
  thread chemdamagethink(var_2, var_1, self);
  common_scripts\utility::waittill_any_timeout_no_endon_death(20, "joined_team", "joined_spectators", "disconnect");
  maps\mp\_utility::_objective_delete(var_2.objidenemy);
  maps\mp\_utility::_objective_delete(var_2.objidfriendly);
  wait 2;
  var_2 friendlyenemyeffectsstop();
  var_2.killcament delete();
  var_2 delete();
  var_5 = 0;
  var_6 = [];

  for(var_7 = 0; var_7 < level.missile_strike_gas_clouds.size; var_7++) {
    if(!var_5 && level.missile_strike_gas_clouds[var_7].origin == var_1) {
      var_5 = 1;
      continue;
    }

    var_6[var_6.size] = level.missile_strike_gas_clouds[var_7];
  }

  level.missile_strike_gas_clouds = var_6;
}

showgascloud(var_0) {
  var_1 = level._missile_strike_setting["Particle_FX"].gasfriendly;
  var_2 = level._missile_strike_setting["Particle_FX"].gas;
  var_3 = self gettagorigin("tag_origin");
  var_4 = (1, 0, 0);
  self.friendlyfx = maps\mp\_utility::spawnfxshowtoteam(var_1, var_0.team, var_3, var_4);
  self.enemyfx = maps\mp\_utility::spawnfxshowtoteam(var_2, maps\mp\_utility::getotherteam(var_0.team), var_3, var_4);
}

friendlyenemyeffectsstop() {
  if(isDefined(self.friendlyfx)) {
    self.friendlyfx delete();
  }

  if(isDefined(self.enemyfx)) {
    self.enemyfx delete();
  }
}

creategastrackingoverlay() {
  if(!isDefined(self.strikegastrackingoverlay)) {
    self.strikegastrackingoverlay = newclienthudelem(self);
    self.strikegastrackingoverlay.x = 0;
    self.strikegastrackingoverlay.y = 0;
    self.strikegastrackingoverlay setshader("lab_gas_overlay", 640, 480);
    self.strikegastrackingoverlay.alignx = "left";
    self.strikegastrackingoverlay.aligny = "top";
    self.strikegastrackingoverlay.horzalign = "fullscreen";
    self.strikegastrackingoverlay.vertalign = "fullscreen";
    self.strikegastrackingoverlay.alpha = 0;
  }
}

chemdamagethink(var_0, var_1, var_2) {
  var_0 endon("death");
  var_2 endon("joined_team");
  var_2 endon("joined_spectators");
  var_2 endon("disconnect");
  var_3 = 200;
  var_4 = 20;

  for(;;) {
    if(!isDefined(var_2)) {
      return;
    }
    var_0.killcament radiusdamage(var_1, var_3, var_4, var_4, var_2, "MOD_TRIGGER_HURT", "killstreak_strike_missile_gas_mp", 0);
    wait 1;
  }
}

waitforgasdamage() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && self == var_1) {
      continue;
    }
    if(maps\mp\_utility::_hasperk("specialty_stun_resistance")) {
      continue;
    }
    if(isDefined(var_9) && var_9 == "killstreak_strike_missile_gas_mp") {
      thread shockthink();
    }
  }
}

shockthink() {
  if(self.missilestrikegastime <= 0) {
    thread fadeinoutgastrackingoverlay();
    thread removeoverlaydeath();
  }

  self.missilestrikegastime = 2;
  self shellshock("mp_lab_gas", 1);

  while(self.missilestrikegastime > 0) {
    self.missilestrikegastime--;
    wait 1;
  }

  self notify("missile_strike_gas_end");
  endgastrackingoverlay();
}

fadeinoutgastrackingoverlay() {
  level endon("game_ended");
  self endon("missile_strike_gas_end");
  self endon("death");

  if(isDefined(self.strikegastrackingoverlay)) {
    for(;;) {
      self.strikegastrackingoverlay fadeovertime(0.4);
      self.strikegastrackingoverlay.alpha = 1;
      wait 0.5;
      self.strikegastrackingoverlay fadeovertime(0.4);
      self.strikegastrackingoverlay.alpha = 0.5;
      wait 0.5;
    }
  }
}

endgastrackingoverlay() {
  if(isDefined(self.strikegastrackingoverlay)) {
    self.strikegastrackingoverlay fadeovertime(0.2);
    self.strikegastrackingoverlay.alpha = 0.0;
  }
}

endgastrackingoverlaydeath() {
  if(isDefined(self.strikegastrackingoverlay)) {
    self.strikegastrackingoverlay.alpha = 0.0;
  }
}

removeoverlaydeath() {
  self endon("missile_strike_gas_end");
  self waittill("death");
  thread endgastrackingoverlaydeath();
}

player_cleanuponteamchange(var_0, var_1) {
  var_0 endon("death");
  self endon("disconnect");
  common_scripts\utility::waittill_any("joined_team", "joined_spectators");
  var_1 notify("missile_strike_complete");
  level.remotemissileinprogress = undefined;
}

rocket_cleanupondeath() {
  var_0 = self getentitynumber();
  level.rockets[var_0] = self;
  self waittill("death");
  level.rockets[var_0] = undefined;
  level.remotemissileinprogress = undefined;
}

player_cleanupongameended(var_0, var_1) {
  var_0 endon("death");
  self endon("disconnect");
  level waittill("game_ended");
  var_1 notify("missile_strike_complete");
}

player_is_valid_target(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isalliedsentient(var_0, self)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(var_0 maps\mp\_utility::_hasperk("specialty_blindeye")) {
    return 0;
  }

  if(isDefined(var_0.spawntime) && (gettime() - var_0.spawntime) / 1000 < 5) {
    return 0;
  }

  return 1;
}

getenemytargets() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!player_is_valid_target(var_2)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

getvalidtargetssorted(var_0, var_1, var_2) {
  var_3 = var_2.name;
  var_4 = 600;
  var_5 = var_4 * var_4;
  var_6 = [];
  var_7 = anglesToForward(var_0.angles);
  var_8 = var_0.origin[2];
  var_9 = level.mapcenter[2];
  var_10 = var_9 - var_8;
  var_11 = var_10 / var_7[2];
  var_12 = var_0.origin + var_7 * var_11;
  var_0.aimtarget = var_12;
  var_13 = 0;

  if(var_2.rocketammo > 0) {
    var_13 = 1;
  } else if(var_2.clustermissile && var_2.clusterhellfire && !self.clusterdeployed) {
    var_13 = 10;
  } else {
    return var_6;
  }

  var_14 = getenemytargets();

  foreach(var_16 in var_14) {
    if(distance2dsquared(var_16.origin, var_12) < var_5) {
      if(var_1) {
        if(bullettracepassed(var_16.origin + (0, 0, 60), var_16.origin + (0, 0, 180), 0, var_16)) {
          var_6[var_6.size] = var_16;
        }

        continue;
      }

      var_6[var_6.size] = var_16;
    }
  }

  var_18 = common_scripts\utility::get_array_of_closest(var_0.aimtarget, var_6, undefined, var_13);
  return var_18;
}

targeting_hud_init() {
  targeting_hud_destroy();
  var_0 = 10;
  self.missile_target_icons = [];

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = newclienthudelem(self);
    var_2.x = 0;
    var_2.y = 0;
    var_2.z = 0;
    var_2.alpha = 0;
    var_2.archived = 0;
    var_2.shader = "hud_fofbox_hostile";
    var_2 setshader("hud_fofbox_hostile", 450, 450);
    var_2 setwaypoint(0, 0, 0, 0);
    var_2 setwaypointiconfadeatcenter(0);
    var_2 setwaypointaerialtargeting(1);
    self.missile_target_icons[var_1] = var_2;
  }
}

targeting_hud_destroy() {
  if(!isDefined(self.missile_target_icons)) {
    return;
  }
  var_0 = 10;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(isDefined(self.missile_target_icons[var_1])) {
      self.missile_target_icons[var_1] destroy();
    }
  }

  self.missile_target_icons = undefined;
}

targeting_hud_think(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("ms_early_exit");
  var_1 endon("missile_strike_complete");
  var_0 endon("death");
  level endon("game_ended");
  wait 1;
  var_2 = var_1.name;
  var_0.targets = getvalidtargetssorted(var_0, 1, var_1);
  var_3 = 10;
  var_4 = 5;
  var_5 = 0;
  var_6 = 47;

  for(;;) {
    foreach(var_8 in self.missile_target_icons) {
      var_8.alpha = 0;
    }

    var_5++;

    if(var_5 > var_4) {
      var_0.targets = getvalidtargetssorted(var_0, 1, var_1);
      var_5 = 0;
    }

    var_10 = self.missile_target_icons[0];
    var_10.x = self.origin[0];
    var_10.y = self.origin[1];
    var_10.z = self.origin[2];
    var_10.alpha = 1;

    if(var_10.shader != "hud_fofbox_self") {
      var_10.shader = "hud_fofbox_self";
      var_10 setshader("hud_fofbox_self", 450, 450);
      var_10 setwaypoint(0, 0, 0, 0);
      var_10 setwaypointiconfadeatcenter(0);
      var_10 setwaypointaerialtargeting(1);
    }

    var_11 = 1;
    var_12 = 0;
    var_13 = level.agentarray;

    if(!isDefined(var_13)) {
      var_13 = [];
    }

    var_14 = common_scripts\utility::array_combine(level.players, var_13);
    var_0.targets = common_scripts\utility::array_removeundefined(var_0.targets);
    var_15 = common_scripts\utility::array_remove_array(var_14, var_0.targets);
    var_16 = [];

    foreach(var_18 in var_15) {
      if(player_is_valid_target(var_18)) {
        var_16[var_16.size] = var_18;
      }
    }

    var_20 = common_scripts\utility::get_array_of_closest(var_0.aimtarget, var_16, undefined, undefined);
    var_14 = common_scripts\utility::array_combine(var_0.targets, var_20);

    foreach(var_22 in var_14) {
      if(!isDefined(var_22)) {
        continue;
      }
      var_10 = self.missile_target_icons[var_11];

      if(!isDefined(var_10)) {
        break;
      }

      if((isplayer(var_22) || isagent(var_22)) && player_is_valid_target(var_22)) {
        var_10.x = var_22.origin[0];
        var_10.y = var_22.origin[1];
        var_10.z = var_22.origin[2];
        var_10.alpha = 1;
        var_11++;

        if(common_scripts\utility::array_contains(var_0.targets, var_22) && var_10.shader == "hud_fofbox_hostile") {
          var_10.shader = "hud_fofbox_hostile_ms_target";
          var_10 setshader("hud_fofbox_hostile_ms_target", 450, 450);
          var_10 setwaypoint(0, 0, 0, 0, 0);
          var_10 fadeovertime(0.05);
          var_10 setwaypointiconfadeatcenter(0);
          var_10 setwaypointaerialtargeting(1);
          var_12++;
          continue;
        }

        if(!common_scripts\utility::array_contains(var_0.targets, var_22) && var_10.shader == "hud_fofbox_hostile_ms_target") {
          var_10.shader = "hud_fofbox_hostile";
          var_10 setshader("hud_fofbox_hostile", 450, 450);
          var_10 setwaypoint(0, 0, 0, 0);
          var_10 fadeovertime(0.05);
          var_10 setwaypointiconfadeatcenter(0);
          var_10 setwaypointaerialtargeting(1);
        }
      }
    }

    if(var_12 == 1) {
      var_0 playsoundtoplayer("mstrike_locked_on_single", var_0.owner);
    }

    if(var_12 > 1) {
      var_0 playsoundtoplayer("mstrike_locked_on_multiple", var_0.owner);
    }

    waitframe();
  }
}

init_hud(var_0, var_1) {
  self endon("disconnect");
  thread targeting_hud_init();
  thread targeting_hud_think(var_0, var_1);
  self setclientomnvar("ui_predator_missile", 1);
  self setclientomnvar("ui_predator_missile_count", var_1.rocketammo);
  var_2 = var_1.name;

  if(var_2 == "remotemissile_projectile_mp") {
    self setclientomnvar("ui_predator_missile_type", 1);
  } else if(var_2 == "remotemissile_projectile_gas_mp") {
    self setclientomnvar("ui_predator_missile_type", 2);
  } else if(var_2 == "remotemissile_projectile_cluster_parent_mp") {
    if(var_1.clusterhellfire) {
      self setclientomnvar("ui_predator_missile_type", 4);
    } else {
      self setclientomnvar("ui_predator_missile_type", 3);
    }
  }

  waitframe();
  hud_update_fire_text(var_0, var_1);
  maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
}

remove_hud() {
  self setclientomnvar("ui_predator_missile", 0);
  self setclientomnvar("ui_predator_missile_text", 0);
  self setclientomnvar("ui_predator_missile_type", 0);
  self setclientomnvar("ui_predator_missile_count", 0);
  targeting_hud_destroy();
  maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
}

hud_update_fire_text(var_0, var_1) {
  self setclientomnvar("ui_predator_missile_count", var_1.rocketammo);

  if(var_1.rocketammo > 0) {
    self setclientomnvar("ui_predator_missile_text", var_1.rocketammo);
  } else if(var_1.clustermissile) {
    if(!self.clusterdeployed) {
      self setclientomnvar("ui_predator_missile_text", 5);
    } else {
      self setclientomnvar("ui_predator_missile_text", 6);
    }
  } else if(!self.missileboostused) {
    self setclientomnvar("ui_predator_missile_text", 3);
  } else {
    self setclientomnvar("ui_predator_missile_text", 4);
  }
}

hud_watch_for_boost_active(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("missile_strike_complete");
  var_1 endon("ms_early_exit");
  self waittill("FireButtonPressed");
  self playrumbleonentity("sniper_fire");
  self.missileboostused = 1;
  hud_update_fire_text(var_0, var_1);
}

fade_to_white() {
  self endon("disconnect");

  if(!isDefined(self.strikewhitefade)) {
    self.strikewhitefade = newclienthudelem(self);
    self.strikewhitefade.x = 0;
    self.strikewhitefade.y = 0;
    self.strikewhitefade setshader("white", 640, 480);
    self.strikewhitefade.alignx = "left";
    self.strikewhitefade.aligny = "top";
    self.strikewhitefade.horzalign = "fullscreen";
    self.strikewhitefade.vertalign = "fullscreen";
    self.strikewhitefade.alpha = 0;
  }

  self.strikewhitefade fadeovertime(0.15);
  self.strikewhitefade.alpha = 1;
  wait 0.15;
  self notify("full_white");
  self.strikewhitefade fadeovertime(0.2);
  self.strikewhitefade.alpha = 0;
  wait 0.2;
  self notify("fade_white_over");
  self.strikewhitefade destroy();
}

playeraddnotifycommands() {
  self notifyonplayercommand("FireButtonPressed", "+attack");
  self notifyonplayercommand("FireButtonPressed", "+attack_akimbo_accessible");
}

playerremovenotifycommands() {
  self notifyonplayercommandremove("FireButtonPressed", "+attack");
  self notifyonplayercommandremove("FireButtonPressed", "+attack_akimbo_accessible");
}