/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\plane.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#namespace plane;

function init() {
  if(!isDefined(level.planes)) {
    level.planes = [];
  }

  if(!isDefined(level.planeconfigs)) {
    level.planeconfigs = [];
  }

  level.fighter_deathfx = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_afterburner = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_contrail = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_wingtip_light_green = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_wingtip_light_red = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

function getflightpath(coord, directionvector, planehalfdistance, absoluteheight, planeflyheight, planeflyspeed, attackdistance, streakname) {
  startpoint = coord + directionvector * -1 * planehalfdistance;
  endpoint = coord + directionvector * planehalfdistance;

  if(absoluteheight) {
    startpoint *= (1, 1, 0);
    endpoint *= (1, 1, 0);
  }

  startpoint += (0, 0, planeflyheight);
  endpoint += (0, 0, planeflyheight);
  d = length(startpoint - endpoint);
  flytime = d / planeflyspeed;
  d = abs(0.5 * d + attackdistance);
  attacktime = d / planeflyspeed;
  assert(flytime > attacktime);
  flightpath["startPoint"] = startpoint;
  flightpath["endPoint"] = endpoint;
  flightpath["attackTime"] = attacktime;
  flightpath["flyTime"] = flytime;
  return flightpath;
}

function doflyby(lifeid, owner, requireddeathcount, startpoint, endpoint, attacktime, flytime, directionvector, streakname) {
  plane = planespawn(lifeid, owner, startpoint, directionvector, streakname);
  plane endon("death");
  endpathrandomness = 150;
  pathend = endpoint + ((randomfloat(2) - 1) * endpathrandomness, (randomfloat(2) - 1) * endpathrandomness, 0);
  plane planemove(pathend, flytime, attacktime, streakname);
  plane planecleanup();
}

function planespawn(lifeid, owner, startpoint, directionvector, streakname) {
  if(!isDefined(owner)) {
    return;
  }

  startpathrandomness = 100;
  pathstart = startpoint + ((randomfloat(2) - 1) * startpathrandomness, (randomfloat(2) - 1) * startpathrandomness, 0);
  configdata = level.planeconfigs[streakname];
  plane = undefined;
  plane = spawn("script_model", pathstart);
  plane.team = owner.team;
  plane.origin = pathstart;
  plane.angles = vectortoangles(directionvector);
  plane.lifeid = lifeid;
  plane.streakname = streakname;
  plane.owner = owner;
  plane setModel(configdata.modelnames[owner.team]);

  if(isDefined(configdata.compassiconfriendly)) {
    plane setobjectiveicons(configdata.compassiconfriendly, configdata.compassiconenemy);
  }

  plane thread handledamage();
  plane thread handledeath();
  starttrackingplane(plane);

  if(!isDefined(configdata.nolightfx)) {
    plane thread playplanefx();
  }

  plane playLoopSound(configdata.inboundsfx);
  plane createkillcam(streakname);
  return plane;
}

function planemove(destination, flytime, attacktime, streakname) {
  configdata = level.planeconfigs[streakname];
  self moveTo(destination, flytime, 0, 0);

  if(isDefined(configdata.onattackdelegate)) {
    self thread[[configdata.onattackdelegate]](destination, flytime, attacktime, self.owner, streakname);
  }

  if(isDefined(configdata.sonicboomsfx)) {
    thread playsonicboom(configdata.sonicboomsfx, 0.5 * flytime);
  }

  wait 0.65 * flytime;

  if(isDefined(configdata.outboundsfx)) {
    self stoploopsound();
    self playLoopSound(configdata.outboundsfx);
  }

  if(isDefined(configdata.outboundflightanim)) {
    self scriptmodelplayanimdeltamotion(configdata.outboundflightanim);
  }

  wait 0.35 * flytime;
}

function planecleanup() {
  configdata = level.planeconfigs[self.streakname];

  if(isDefined(configdata.onflybycompletedelegate)) {
    thread[[configdata.onflybycompletedelegate]](self.owner, self, self.streakname);
  }

  if(isDefined(self.friendlyteamid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.friendlyteamid);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.enemyteamid);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  stoptrackingplane(self);
  self notify("delete");
  self delete();
}

function handledeath() {
  level endon("game_ended");
  self endon("delete");
  self waittill("death");
  forward = anglesToForward(self.angles) * 200;
  playFX(level.fighter_deathfx, self.origin, forward);
  thread planecleanup();
}

function handledamage() {
  self endon("end_remote");
  scripts\mp\damage::monitordamage(800, "helicopter", &handledeathdamage, &modifydamage, 1);
}

function modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;
  modifieddamage = scripts\mp\damage::handlemissiledamage(objweapon, type, modifieddamage);
  modifieddamage = scripts\mp\damage::handleapdamage(objweapon, type, modifieddamage, attacker);
  return modifieddamage;
}

function handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  config = level.planeconfigs[self.streakname];
  scripts\mp\damage::onkillstreakkilled(self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo, config.callout);
}

function playplanefx() {
  self endon("death");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_wingtip_light_red, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_wingtip_light_green, self, "tag_left_wingtip");
}

function getplaneflyheight() {
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

  if(isDefined(heightent)) {
    return heightent.origin[2];
  }

  println("<dev string:x1c>");
  planeflyheight = 950;
  return planeflyheight;
}

function getplaneflightplan(distfromplayer) {
  result = spawnStruct();
  result.height = getplaneflyheight();
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

  if(isDefined(heightent) && isDefined(heightent.script_noteworthy) && heightent.script_noteworthy == "fixedposition") {
    result.targetpos = heightent.origin;
    result.flightdir = anglesToForward(heightent.angles);

    if(randomint(2) == 0) {
      result.flightdir *= -1;
    }
  } else {
    forwardvec = anglesToForward(self.angles);
    rightvec = anglestoright(self.angles);
    result.targetpos = self.origin + distfromplayer * forwardvec;
    result.flightdir = -1 * rightvec;
  }

  return result;
}

function getexplodedistance(height) {
  standardheight = 850;
  standarddistance = 1500;
  distancefrac = standardheight / height;
  newdistance = distancefrac * standarddistance;
  return newdistance;
}

function starttrackingplane(obj) {
  entnum = obj getentitynumber();
  level.planes[entnum] = obj;
}

function stoptrackingplane(obj) {
  entnum = obj getentitynumber();
  level.planes[entnum] = undefined;
}

function selectairstrikelocation(lifeid, streakname, var_9dd357e6fee9854e) {
  targetsize = level.mapsize / 6.46875;

  if(level.splitscreen) {
    targetsize *= 1.5;
  }

  config = level.planeconfigs[streakname];

  if(isDefined(config.selectlocationvo)) {
    self playlocalsound(game["voice"][self.team] + config.selectlocationvo);
  }

  _beginlocationselection(streakname, "map_artillery_selector", config.choosedirection, targetsize);
  self endon("stop_location_selection");
  self waittill("confirm_location", location, directionyaw);

  if(!config.choosedirection) {
    directionyaw = randomint(360);
  }

  self setblurforplayer(0, 0.3);

  if(isDefined(config.inboundvo)) {
    self playlocalsound(game["voice"][self.team] + config.inboundvo);
  }

  self thread[[var_9dd357e6fee9854e]](lifeid, location, directionyaw, streakname);
  return true;
}

function setobjectiveicons(friendlyicon, enemyicon) {
  friendlyteamid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(friendlyteamid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(friendlyteamid, "active", (0, 0, 0), friendlyicon);
    scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(friendlyteamid, self);
  }

  self.friendlyteamid = friendlyteamid;
  enemyteamid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(enemyteamid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(enemyteamid, "active", (0, 0, 0), enemyicon);
    scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(enemyteamid, self);
  }

  self.enemyteamid = enemyteamid;

  if(level.teambased) {
    if(friendlyteamid != -1) {
      scripts\mp\objidpoolmanager::objective_teammask_single(friendlyteamid, self.team);
    }

    if(enemyteamid != -1) {
      scripts\mp\objidpoolmanager::objective_teammask_single(enemyteamid, getotherteam(self.team)[0]);
    }

    return;
  }

  if(friendlyteamid != -1) {
    scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(friendlyteamid, self.owner);
  }

  if(enemyteamid != -1) {
    scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(enemyteamid, self.owner);
  }
}

function playsonicboom(soundname, delay) {
  self endon("death");
  wait delay;
  self playsoundonmovingent(soundname);
}

function createkillcam(streakname) {
  configdata = level.planeconfigs[streakname];

  if(isDefined(configdata.killcamoffset)) {
    planedir = anglesToForward(self.angles);
    killcament = spawn("script_model", self.origin + (0, 0, 100) - planedir * 200);
    killcament.starttime = gettime();
    killcament setscriptmoverkillcam("airstrike");
    killcament linkTo(self, "tag_origin", configdata.killcamoffset, (0, 0, 0));
    self.killcament = killcament;
  }
}