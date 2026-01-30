/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42960.gsc
**************************************/

init() {
  level._effect["uav_explode"] = loadfx("vfx/explosion/vehicle_uav_explosion");
  level._effect["uav_exit"] = loadfx("vfx/trail/smoketrail_uav");
  level._effect["uav_trail"] = loadfx("vfx/trail/smoketrail_uav");
  level.killstreakfuncs["uav"] = ::tryuseuav;
  level.killstreakfuncs["uav_support"] = ::tryuseuav;
  level.killstreakfuncs["counter_uav"] = ::tryuseuav;
  var_0 = getEntArray("minimap_corner", "targetname");

  if(var_0.size) {
    var_1 = maps\mp\gametypes\_spawnlogic::findboxcenter(var_0[0].origin, var_0[1].origin);
  } else {
    var_1 = (0, 0, 0);
  }

  level.uavrig = spawn("script_model", var_1);
  level.uavrig setModel("c130_zoomrig");
  level.uavrig.angles = (0, 115, 0);
  level.uavrig hide();
  level.uavrig.targetname = "uavrig_script_model";
  level.uavrig thread rotateuavrig();

  if(level.teambased) {
    level.radarmode["allies"] = "normal_radar";
    level.radarmode["axis"] = "normal_radar";
    level.activeuavs["allies"] = 0;
    level.activeuavs["axis"] = 0;
    level.activecounteruavs["allies"] = 0;
    level.activecounteruavs["axis"] = 0;
    level.uavmodels["allies"] = [];
    level.uavmodels["axis"] = [];
  } else {
    level.radarmode = [];
    level.activeuavs = [];
    level.activecounteruavs = [];
    level.uavmodels = [];
  }

  level thread onplayerconnect();
  level thread uavtracker();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!level.teambased) {
      level.activeuavs[var_0.guid] = 0;
      level.activeuavs[var_0.guid + "_radarStrength"] = 0;
      level.activecounteruavs[var_0.guid] = 0;
      level.radarmode[var_0.guid] = "normal_radar";
    }

    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    level notify("uav_update");
  }
}

rotateuavrig() {
  for(;;) {
    self rotateyaw(-360, 60);
    wait 60;
  }
}

playtrailfx() {
  self endon("death");
  level endon("game_ended");
  playFXOnTag(level._effect["uav_trail"], self, "tag_origin");
}

launchuav(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", level.uavrig gettagorigin("tag_origin"));
  var_4.modules = var_3;
  var_4.value = 1;

  if(common_scripts\utility::array_contains(var_4.modules, "uav_advanced_updates")) {
    var_4.value = 2;
  }

  if(common_scripts\utility::array_contains(var_4.modules, "uav_enemy_direction")) {
    var_4.value = 3;
  }

  if(common_scripts\utility::array_contains(var_4.modules, "uav_scrambler")) {
    var_5 = 1;
  } else {
    var_5 = 0;
  }

  var_4 setModel("uav_drone_static");
  var_4 thread playtrailfx();
  var_4 thread maps\mp\gametypes\_damage::setentitydamagecallback(1000, undefined, ::uavondeath, undefined, 1);
  var_4.team = var_1;
  var_4.owner = var_0;
  var_4.timetoadd = 0;
  var_4.orbit = common_scripts\utility::array_contains(var_4.modules, "uav_orbit");
  var_4.paintoutline = common_scripts\utility::array_contains(var_4.modules, "uav_paint_outline");
  var_4.assistpoints = common_scripts\utility::array_contains(var_4.modules, "uav_assist_points");
  var_4 common_scripts\utility::make_entity_sentient_mp(var_1);
  var_4 thread handleincomingstinger();
  var_4.streakcustomization = var_0.streakcustomization;
  var_4 adduavmodel();
  thread flyin(var_4);
  var_4 thread updateuavmodelvisibility();
  var_4 thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
  var_4 addactiveuav();

  if(var_5) {
    var_4 addactivecounteruav();
  }

  if(isDefined(level.activeuavs[var_1])) {
    foreach(var_7 in level.uavmodels[var_1]) {
      if(var_7 == var_4) {
        continue;
      }
      if(var_5) {
        var_7.timetoadd = var_7.timetoadd + 5;
        continue;
      }

      if(!var_5) {
        var_7.timetoadd = var_7.timetoadd + 5;
      }
    }
  }

  waitframe();
  level notify("uav_update");
  var_9 = 30;

  if(common_scripts\utility::array_contains(var_4.modules, "uav_increased_time")) {
    var_9 = var_9 + 15;
  }

  var_4 waittill_notify_or_timeout_hostmigration_pause("death", var_9);

  if(var_4.damagetaken < var_4.maxhealth) {
    var_4 unlink();
    var_10 = var_4.origin + anglesToForward(var_4.angles) * 20000;
    var_4 moveto(var_10, 60);
    playFXOnTag(common_scripts\utility::getfx("uav_exit"), var_4, "tag_origin");
    var_4 waittill_notify_or_timeout_hostmigration_pause("death", 3);

    if(var_4.damagetaken < var_4.maxhealth) {
      var_4 notify("leaving");
      var_4.isleaving = 1;
      var_4 moveto(var_10, 4, 4, 0.0);
    }

    var_4 waittill_notify_or_timeout_hostmigration_pause("death", 4 + var_4.timetoadd);
  }

  if(var_5) {
    var_4 removeactivecounteruav();
  }

  var_4 removeactiveuav();
  var_4 delete();
  var_4 removeuavmodel();
  level notify("uav_update");
}

flyin(var_0) {
  var_0 hide();
  var_1 = randomintrange(3000, 5000);

  if(isDefined(level.spawnpoints)) {
    var_2 = level.spawnpoints;
  } else {
    var_2 = level.startspawnpoints;
  }

  var_3 = var_2[0];

  foreach(var_5 in var_2) {
    if(var_5.origin[2] < var_3.origin[2]) {
      var_3 = var_5;
    }
  }

  var_7 = var_3.origin[2];
  var_8 = level.uavrig.origin[2];

  if(var_7 < 0) {
    var_8 = var_8 + var_7 * -1;
    var_7 = 0;
  }

  var_9 = var_8 - var_7;

  if(var_9 + var_1 > 8100.0) {
    var_1 = var_1 - (var_9 + var_1 - 8100.0);
  }

  var_10 = randomint(360);
  var_11 = randomint(2000) + 5000;
  var_12 = cos(var_10) * var_11;
  var_13 = sin(var_10) * var_11;
  var_14 = vectornormalize((var_12, var_13, var_1));
  var_14 = var_14 * randomintrange(6000, 7000);
  var_0 linkto(level.uavrig, "tag_origin", var_14, (0, var_10 - 90, 135));
  waitframe();
  var_15 = var_0.origin;
  var_0 unlink();
  var_0.origin = var_15 + anglesToForward(var_0.angles) * -20000;
  var_0 moveto(var_15, 4, 0, 2);
  wait 4;

  if(isDefined(var_0)) {
    var_0 linkto(level.uavrig, "tag_origin");
  }
}

waittill_notify_or_timeout_hostmigration_pause(var_0, var_1) {
  self endon(var_0);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_1);
}

updateuavmodelvisibility() {
  self endon("death");

  for(;;) {
    level common_scripts\utility::waittill_either("joined_team", "uav_update");
    self hide();

    foreach(var_1 in level.players) {
      if(level.teambased) {
        if(var_1.team != self.team && !self.orbit) {
          self showtoplayer(var_1);
        }

        continue;
      }

      if(isDefined(self.owner) && var_1 == self.owner || self.orbit) {
        continue;
      }
      self showtoplayer(var_1);
    }
  }
}

uavondeath(var_0, var_1, var_2, var_3) {
  self hide();
  self notify("death");
  var_4 = anglestoright(self.angles) * 200;
  playFX(common_scripts\utility::getfx("uav_explode"), self.origin, var_4);
  playsoundatpos(self.origin, "uav_air_death");
  maps\mp\gametypes\_damage::onkillstreakkilled(var_0, var_1, var_2, var_3, "uav_destroyed", undefined, "callout_destroyed_uav", 1);
}

tryuseuav(var_0, var_1) {
  if(isDefined(self.pers["killstreaks"][self.killstreakindexweapon].streakname)) {
    var_2 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
  } else {
    var_2 = "uav_support";
  }

  if(isDefined(level.ishorde) && level.ishorde && self.killstreakindexweapon == 1) {
    self notify("used_horde_uav");
  }

  return useuav(var_2, var_1);
}

useuav(var_0, var_1) {
  maps\mp\_matchdata::logkillstreakevent(var_0, self.origin);
  var_2 = self.pers["team"];
  level thread launchuav(self, var_2, var_0, var_1);
  return 1;
}

uavtracker() {
  level endon("game_ended");

  for(;;) {
    level waittill("uav_update");

    if(level.teambased) {
      updateteamuavstatus("allies");
      updateteamuavstatus("axis");
      continue;
    }

    updateplayersuavstatus();
  }
}

_getradarstrength(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in level.uavmodels[var_0]) {
    var_3 = var_3 + var_6.value;
  }

  foreach(var_6 in level.uavmodels[level.otherteam[var_0]]) {
    if(var_6.uavtype != "counter") {
      continue;
    }
    var_4 = var_4 + var_6.value;
  }

  if(var_4 > 0) {
    var_10 = -3;
  } else {
    var_10 = var_3;
  }

  var_11 = getuavstrengthmin();
  var_12 = getuavstrengthmax();

  if(var_10 <= var_11) {
    var_10 = var_11;
  } else if(var_10 >= var_12) {
    var_10 = var_12;
  }

  return var_10;
}

_getteampaintoutline(var_0) {
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.uavmodels[var_0]) {
    if(var_4.paintoutline) {
      var_1 = var_1 + var_4.value;
    }
  }

  if(var_1 > 0) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  return var_2;
}

_getpaintoutline(var_0) {
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.uavmodels) {
    if(isDefined(var_4.owner) && var_4.owner == var_0 && var_4.paintoutline) {
      var_1 = var_1 + var_4.value;
    }
  }

  if(var_1 > 0) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  return var_2;
}

updateteamuavstatus(var_0) {
  var_1 = _getradarstrength(var_0);
  var_2 = _getteampaintoutline(var_0);
  updateteampaintoutline(var_0, var_2);
  setteamradarstrength(var_0, var_1);

  if(var_1 >= getuavstrengthlevelneutral()) {
    updateteamradarblocked(var_0, 0);
    unblockteamradar(var_0);
  } else {
    updateteamradarblocked(var_0, 1);
    blockteamradar(var_0);
  }

  if(var_1 <= getuavstrengthlevelneutral()) {
    setteamradarwrapper(var_0, 0);
    updateteamuavtype(var_0);
    return;
  }

  if(var_1 >= getuavstrengthlevelshowenemyfastsweep()) {
    level.radarmode[var_0] = "fast_radar";
  } else {
    level.radarmode[var_0] = "normal_radar";
  }

  updateteamuavtype(var_0);
  setteamradarwrapper(var_0, 1);
}

updateplayersuavstatus() {
  var_0 = getuavstrengthmin();
  var_1 = getuavstrengthmax();
  var_2 = getuavstrengthlevelshowenemydirectional();

  foreach(var_4 in level.players) {
    var_5 = level.activeuavs[var_4.guid + "_radarStrength"];
    var_6 = _getpaintoutline(var_4);
    updatepaintoutline(var_4, var_6);

    foreach(var_8 in level.players) {
      if(var_8 == var_4) {
        continue;
      }
      var_9 = level.activecounteruavs[var_8.guid];

      if(var_9 > 0) {
        var_5 = -3;
        break;
      }
    }

    if(var_5 <= var_0) {
      var_5 = var_0;
    } else if(var_5 >= var_1) {
      var_5 = var_1;
    }

    var_4.radarstrength = var_5;

    if(var_5 >= getuavstrengthlevelneutral()) {
      updateplayerradarblocked(var_4, 0);
      var_4.isradarblocked = 0;
    } else {
      updateplayerradarblocked(var_4, 1);
      var_4.isradarblocked = 1;
    }

    if(var_5 <= getuavstrengthlevelneutral()) {
      var_4.hasradar = 0;
      var_4.radarshowenemydirection = 0;
      continue;
    }

    if(var_5 >= getuavstrengthlevelshowenemyfastsweep()) {
      var_4.radarmode = "fast_radar";
    } else {
      var_4.radarmode = "normal_radar";
    }

    var_4.radarshowenemydirection = var_5 >= var_2;
    var_4.hasradar = 1;
  }
}

updateteamuavtype(var_0, var_1) {
  var_2 = _getradarstrength(var_0) >= getuavstrengthlevelshowenemydirectional();

  foreach(var_4 in level.players) {
    if(var_4.team == "spectator") {
      continue;
    }
    var_5 = maps\mp\gametypes\_gameobjects::getenemyteam(var_4.team);
    var_4.radarmode = level.radarmode[var_4.team];
    var_4.enemyradarmode = level.radarmode[var_5];

    if(var_4.team == var_0) {
      var_4.radarshowenemydirection = var_2;
    }
  }
}

updateteampaintoutline(var_0, var_1) {
  level endon("game_ended");

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && var_3.team == var_0) {
      var_3 playersetupuavpaintoutline(var_1);
    }
  }
}

updatepaintoutline(var_0, var_1) {
  level endon("game_ended");
  var_0 playersetupuavpaintoutline(var_1);
}

playersetupuavpaintoutline(var_0) {
  if(var_0) {
    if(!isDefined(self.uav_paint_effect)) {
      self.uav_paint_effect = maps\mp\_threatdetection::detection_highlight_hud_effect_on(self, -1);
    }

    self setperk("specialty_uav_paint", 1, 0);
  } else {
    if(isDefined(self.uav_paint_effect)) {
      maps\mp\_threatdetection::detection_highlight_hud_effect_off(self.uav_paint_effect);
      self.uav_paint_effect = undefined;
    }

    self unsetperk("specialty_uav_paint", 1);
  }
}

updateteamradarblocked(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3) && var_3.team == var_0) {
      updateplayerradarblocked(var_3, var_1);
    }
  }
}

updateplayerradarblocked(var_0, var_1) {
  if(!var_1 || !var_0 maps\mp\_utility::_hasperk("specialty_class_hardwired")) {
    var_0 setclientomnvar("ui_uav_scrambler_on", var_1);
  }
}

setteamradarwrapper(var_0, var_1) {
  setteamradar(var_0, var_1);
  level notify("radar_status_change", var_0);
}

handleincomingstinger() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("stinger_fired", var_0, var_1);

    if(!maps\mp\_stingerm7::anystingermissilelockedon(var_1, self)) {
      continue;
    }
    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_3 thread stingerproximitydetonate(var_3.lockedstingertarget, var_0);
    }
  }
}

stingerproximitydetonate(var_0, var_1) {
  self endon("death");
  var_2 = distance(self.origin, var_0 getpointinbounds(0, 0, 0));
  var_3 = var_0 getpointinbounds(0, 0, 0);

  for(;;) {
    if(!isDefined(var_0)) {
      var_4 = var_3;
    } else {
      var_4 = var_0 getpointinbounds(0, 0, 0);
    }

    var_3 = var_4;
    var_5 = distance(self.origin, var_4);

    if(var_5 < var_2) {
      var_2 = var_5;
    }

    if(var_5 > var_2) {
      if(var_5 > 1536) {
        return;
      }
      radiusdamage(self.origin, 1536, 600, 600, var_1, "MOD_EXPLOSIVE", "stinger_mp");
      playFX(level.stingerfxid, self.origin);
      self hide();
      self notify("deleted");
      wait 0.05;
      self delete();
      var_1 notify("killstreak_destroyed");
    }

    wait 0.05;
  }
}

adduavmodel() {
  if(level.teambased) {
    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
  } else {
    level.uavmodels[self.owner.guid + "_" + gettime()] = self;
  }
}

removeuavmodel() {
  var_0 = [];

  if(level.teambased) {
    var_1 = self.team;

    foreach(var_3 in level.uavmodels[var_1]) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }

    level.uavmodels[var_1] = var_0;
  } else {
    foreach(var_3 in level.uavmodels) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }

    level.uavmodels = var_0;
  }
}

addactiveuav() {
  self.uavtype = "standard";

  if(level.teambased) {
    level.activeuavs[self.team]++;
  } else {
    level.activeuavs[self.owner.guid]++;
    level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] + self.value;
  }
}

addactivecounteruav() {
  self.uavtype = "counter";

  if(level.teambased) {
    level.activecounteruavs[self.team]++;
  } else {
    level.activecounteruavs[self.owner.guid]++;
  }
}

removeactiveuav() {
  if(level.teambased) {
    level.activeuavs[self.team]--;

    if(!level.activeuavs[self.team]) {
      return;
    }
  } else if(isDefined(self.owner)) {
    level.activeuavs[self.owner.guid]--;
    level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] - self.value;
  }
}

removeactivecounteruav() {
  if(level.teambased) {
    level.activecounteruavs[self.team]--;

    if(!level.activecounteruavs[self.team]) {
      return;
    }
  } else if(isDefined(self.owner)) {
    level.activecounteruavs[self.owner.guid]--;
  }
}