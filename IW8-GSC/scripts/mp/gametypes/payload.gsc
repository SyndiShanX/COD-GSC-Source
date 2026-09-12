/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\payload.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_payload_waverespawndelay", 5);
}

function onstartgametype(var_0) {
  var_1 = scripts\mp\utility\game::istimetobeatvalid();

  if(game["roundsPlayed"] == 0) {
    setomnvar("ui_round_hint_override_attackers", 1);
    setomnvar("ui_round_hint_override_defenders", 1);
  } else if(var_1) {
    setomnvar("ui_round_hint_override_attackers", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["attackers"], 2, 3));
    setomnvar("ui_round_hint_override_defenders", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["defenders"], 2, 3));
  } else {
    setomnvar("ui_round_hint_override_attackers", 4);
    setomnvar("ui_round_hint_override_defenders", 4);
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_2 = game["attackers"];
    var_3 = game["defenders"];
    game["attackers"] = var_3;
    game["defenders"] = var_2;
  }

  foreach(var_5 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_5, &"OBJECTIVES/KOTH");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_5, &"OBJECTIVES/KOTH");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_5, &"OBJECTIVES/KOTH_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_5, &"OBJECTIVES/KOTH_HINT");
  }

  setclientnamemode("auto_change");
  initspawns();
  seticonnames();
  createpatharray(level);
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_payload_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_payload_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_payload_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_payload_spawn_axis");
  level.payloadspawnsets = [];
  level.payloadspawnsets["allies"] = "allies";
  level.payloadspawnsets["axis"] = "axis";
  scripts\mp\spawnlogic::registerspawnset("allies", "mp_payload_spawn_allies");
  scripts\mp\spawnlogic::registerspawnset("axis", "mp_payload_spawn_axis");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_payload_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_2 = scripts\mp\spawnscoring::getspawnpoint(self, var_2, level.payloadspawnsets[var_2]);
  }

  return var_2;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function ontimelimit() {
  level scripts\mp\gamescore::giveteamscoreforobjective(scripts\mp\utility\game::getotherteam(level.tank.team)[0], 1, 0);
  thread scripts\mp\gamelogic::endgame(scripts\mp\utility\game::getotherteam(level.tank.team)[0], game["end_reason"]["time_limit_reached"]);
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

function onspawnplayer() {}

function spawnbradleypayload() {
  var_0 = level.players[0];
  var_1 = game["attackers"];
  var_2 = spawn("script_model", level.tankmovetopath.origin);
  var_2.angles = level.tankmovetopath.angles;
  var_2.team = var_1;
  var_2 setModel("veh8_mil_lnd_bromeo_allies_mp_to");
  var_2 setentityowner(var_0);
  var_2 setotherent(var_0);
  var_3 = undefined;

  if(isDefined(var_0)) {
    var_3 = var_0 getentitynumber();
  }

  var_4 = (-532.957, -3351.52, 312.255);
  var_5 = (0, 90, 0);
  var_2.owner = var_0;
  var_2.ownerid = var_3;
  var_2.team = var_1;
  var_2 setCanDamage(0);
  var_6 = var_2 gettagorigin("tag_turret");
  var_7 = spawnturret("misc_turret", var_6, "tur_bradley_mp", 0);
  var_7 linkTo(var_2, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_7 setModel("veh8_mil_lnd_bromeo_turret_allies_mp");
  var_7.owner = var_0;
  var_7.team = var_1;
  var_7 setmode("sentry_offline");
  var_7 setsentryowner(undefined);
  var_7 makeunusable();
  var_7 setdefaultdroppitch(0);
  var_7 setCanDamage(0);
  var_7 setturretmodechangewait(1);
  var_2.turret = var_7;
  var_2.isbradley = 1;
  var_7.vehicle = var_2;
  var_7.damageshakeexplosivenum = 0;
  var_7.damageshakebulletnum = 0;
  var_8 = [];
  var_9 = spawn("trigger_radius", var_2.origin, 0, 300, 192);
  var_9 enablelinkTo();
  var_9 linkTo(var_2);
  var_10 = scripts\mp\gameobjects::createuseobject(var_1, var_9, var_8, (0, 0, 90));
  var_10 scripts\mp\gameobjects::allowuse("friendly");
  var_10 scripts\mp\gameobjects::setusetime(0);
  var_10 scripts\mp\gameobjects::cancontestclaim(1);
  var_10 scripts\mp\gameobjects::mustmaintainclaim(1);
  var_10.onuse = &tank_onuse;
  var_10.onunoccupied = &tank_onunoccupied;
  var_10.oncontested = &tank_oncontested;
  var_10.onuncontested = &tank_onuncontested;
  var_2.useobj = var_10;
  var_2.damaged = 0;
  var_2.trackedobject = var_2 scripts\mp\gameobjects::createtrackedobject(var_2, (0, 0, 64));
  var_2.trackedobject.objidpingfriendly = 0;
  var_2.trackedobject.objidpingenemy = 1;
  var_2.trackedobject.objpingdelay = 0.05;
  var_2.trackedobject.visibleteam = "any";
  var_2.invulnerable = 1;
  var_2.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget, level.icontarget);
  level.tank = var_2;
}

function bradley_handletacopsdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(var_3 == "MOD_MELEE") {
    return 0;
  }

  var_4 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_2, var_3, var_4, 3000, 8, 12, 16);
  return var_4;
}

function bradley_handlefataltacopsdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(level.teambased) {
    var_6 = "";

    if(isDefined(var_1) && isDefined(var_1.team)) {
      var_6 = var_1.team;
    }

    if(var_6 != self.team) {}
  } else if(isDefined(var_1) && (!isDefined(self.owner) || self.owner != var_1)) {}

  thread bradley_vehicledestroy(var_1, var_2, var_3, 0);
}

function bradley_vehicledestroy(var_0, var_1, var_2, var_3) {
  self.damaged = 1;
  self notify("bradley_disabled");
  var_3 = istrue(var_3);
  self.isdestroyed = 1;
  self setCanDamage(0);
  self.turret setCanDamage(0);
  scripts\mp\utility\print::printboldonteam("Bradley is badly damaged, stay near it to repair it", "allies");
  thread bradley_restorehealth();
}

function watchdamagecycle() {
  level endon("game_ended");
  self endon("bradley_disabled");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(istrue(self.isrepairing)) {
      continue;
    }

    scripts\engine\utility::ref_143B9(3, "damage");
    self.allowpartialrepairs = 1;
  }
}

function bradley_restorehealth() {
  if(!isDefined(self.damagetaken) || self.damagetaken == 0) {
    return;
  }

  if(istrue(self.isrepairing) || !istrue(self.allowpartialrepairs)) {
    return;
  }

  level endon("game_ended");

  if(!istrue(self.damaged)) {
    self endon("damage");
    self.allowpartialrepairs = 0;
    var_0 = 0;
    var_1 = 0.2;
    var_2 = 10;
  } else {
    self.isrepairing = 1;
    var_0 = 10;
    var_1 = 0.1;
    var_2 = 100;
  }

  wait var_0;
  scripts\mp\utility\print::printboldonteam("Repairing Bradley", "allies");

  while(self.damagetaken != 0) {
    self.damagetaken = max(self.damagetaken - var_2, 0);
    wait var_1;
  }

  scripts\mp\utility\print::printboldonteam("Bradley Repaired", "allies");
  self.isrepairing = 0;
  self setCanDamage(1);
  self.turret setCanDamage(1);
  self.damaged = 0;
  self.isdestroyed = 0;
  thread scripts\mp\damage::monitordamage(3000, "", &bradley_handlefataltacopsdamage, &bradley_handletacopsdamage, 1);
  self.movementdisabled = 0;
}

function tank_onuse(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = scripts\mp\utility\game::getotherteam(var_1)[0];
  var_4 = gettime();

  if(istrue(self.allowpartialrepairs)) {
    thread bradley_restorehealth();
  }

  thread startmove(level);
  level.usestartspawns = 0;
  var_5 = 0;
  level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  if(!isDefined(level.lastcaptureteam) || level.lastcaptureteam != var_1) {
    var_6 = [];
    var_7 = getarraykeys(self.touchlist[var_1]);

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      var_6 = self.touchlist[var_1][var_7[var_8]];
    }
  }

  level.hpcapteam = var_1;
  scripts\mp\gameobjects::setownerteam(var_1);
  level.lastcaptureteam = var_1;
}

function tank_onunoccupied() {
  level notify("zone_destroyed");
  level.hpcapteam = "neutral";
  var_0 = 1;

  foreach(var_2 in level.teamnamelist) {
    if(self.numtouching[var_2] > 0) {
      var_0 = 0;
      break;
    }
  }

  if(var_0) {
    level.tank.useobj.wasleftunoccupied = 1;
    level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  }

  self notify("payload_stopped");
  level.tank moveTo(level.tank.origin, 0.05, 0, 0);
  level.tank rotateTo(level.tank.angles, 1, 0, 0);
}

function tank_oncontested() {
  var_0 = level.tank.useobj scripts\mp\gameobjects::getownerteam();
  level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);

  if(var_0 == "neutral") {
    var_1 = self.claimteam;
  } else {
    var_1 = var_1;
  }

  self notify("payload_stopped");
  level.tank moveTo(level.tank.origin, 0.05, 0, 0);
}

function tank_onuncontested(var_0) {
  var_1 = level.tank.useobj scripts\mp\gameobjects::getownerteam();

  if(var_0 == "none" || var_1 == "neutral") {
    level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    return;
  }

  level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function startmove(var_0) {
  level endon("game_ended");
  moveonpath(var_0, level.tankmovetopath);
}

function createpatharray() {
  level.tankmovetopath = scripts\engine\utility::getStruct("tank_path", "targetname");
  thread spawnbradleypayload();
}

function getpathstart(var_0, var_1) {
  var_2 = 100;
  var_3 = 150;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4) * -1 * var_3;
  var_5 += ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

function moveonpath(var_0) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("hostage_scored");
  self endon("hostage_stopped");
  self endon("payload_stopped");
  self.speed = 100;
  level.tankspeed = self.speed;

  if(istrue(self.damaged)) {
    level.tank moveTo(level.tank.origin, 0.05, 0, 0);
    self notify("payload_stopped");
    return;
  }

  var_1 = level.tankmovetopath.origin;
  var_2 = getphysicspointaboutnavmesh(var_1);
  var_3 = distance(self.origin, var_2);

  if(var_3 < 10 && !level.gameended) {
    if(isDefined(level.tankmovetopath.target)) {
      level scripts\mp\gamescore::giveteamscoreforobjective(level.tank.team, 1, 0);
      level.tankmovetopath = scripts\engine\utility::getStruct(level.tankmovetopath.target, "targetname");
      return;
    }

    game["status"] = "recordTTB";
    level scripts\mp\gamescore::giveteamscoreforobjective(level.tank.team, 1, 0);
    thread scripts\mp\gamelogic::endgame(level.tank.team, game["end_reason"]["objective_completed"]);
    return;
  }

  var_4 = var_3 / self.speed;
  self moveTo(var_2, var_4, 0, 0);
  self rotateTo((level.tankmovetopath.angles[0], level.tankmovetopath.angles[1], self.angles[2]), 1);
  wait var_4;
}

function getphysicspointaboutnavmesh(var_0) {
  var_1 = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var_2 = physics_raycast(var_0 + (0, 0, 48), var_0 - (0, 0, 48), var_1, undefined, 0, "physicsquery_closest");
  var_3 = isDefined(var_2) && var_2.size > 0;

  if(var_3) {
    var_4 = var_2[0]["position"];
    return var_4;
  }

  return var_1;
}

function seticonnames() {
  level.icontarget = "waypoint_hardpoint_target";
  level.iconcapture = "waypoint_capture_kill";
  level.icondefend = "waypoint_escort";
  level.iconcontested = "waypoint_hardpoint_contested";
}