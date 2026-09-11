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

function onstartgametype(var0) {
  var1 = scripts\mp\utility\game::istimetobeatvalid();

  if(game["roundsPlayed"] == 0) {
    setomnvar("ui_round_hint_override_attackers", 1);
    setomnvar("ui_round_hint_override_defenders", 1);
  } else if(var1) {
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
    var2 = game["attackers"];
    var3 = game["defenders"];
    game["attackers"] = var3;
    game["defenders"] = var2;
  }

  foreach(var5 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var5, &"OBJECTIVES/KOTH");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var5, &"OBJECTIVES/KOTH");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var5, &"OBJECTIVES/KOTH_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var5, &"OBJECTIVES/KOTH_HINT");
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
  var0 = self.pers["team"];

  if(game["switchedsides"]) {
    var0 = scripts\mp\utility\game::getotherteam(var0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_payload_spawn_" + var0 + "_start");
    var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
  } else {
    var2 = scripts\mp\spawnscoring::getspawnpoint(self, var2, level.payloadspawnsets[var2]);
  }

  return var2;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function ontimelimit() {
  level scripts\mp\gamescore::giveteamscoreforobjective(scripts\mp\utility\game::getotherteam(level.tank.team)[0], 1, 0);
  thread scripts\mp\gamelogic::endgame(scripts\mp\utility\game::getotherteam(level.tank.team)[0], game["end_reason"]["time_limit_reached"]);
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
}

function onspawnplayer() {}

function spawnbradleypayload() {
  var0 = level.players[0];
  var1 = game["attackers"];
  var2 = spawn("script_model", level.tankmovetopath.origin);
  var2.angles = level.tankmovetopath.angles;
  var2.team = var1;
  var2 setModel("veh8_mil_lnd_bromeo_allies_mp_to");
  var2 setentityowner(var0);
  var2 setotherent(var0);
  var3 = undefined;

  if(isDefined(var0)) {
    var3 = var0 getentitynumber();
  }

  var4 = (-532.957, -3351.52, 312.255);
  var5 = (0, 90, 0);
  var2.owner = var0;
  var2.ownerid = var3;
  var2.team = var1;
  var2 setCanDamage(0);
  var6 = var2 gettagorigin("tag_turret");
  var7 = spawnturret("misc_turret", var6, "tur_bradley_mp", 0);
  var7 linkTo(var2, "tag_turret", (0, 0, 0), (0, 0, 0));
  var7 setModel("veh8_mil_lnd_bromeo_turret_allies_mp");
  var7.owner = var0;
  var7.team = var1;
  var7 setmode("sentry_offline");
  var7 setsentryowner(undefined);
  var7 makeunusable();
  var7 setdefaultdroppitch(0);
  var7 setCanDamage(0);
  var7 setturretmodechangewait(1);
  var2.turret = var7;
  var2.isbradley = 1;
  var7.vehicle = var2;
  var7.damageshakeexplosivenum = 0;
  var7.damageshakebulletnum = 0;
  var8 = [];
  var9 = spawn("trigger_radius", var2.origin, 0, 300, 192);
  var9 enablelinkTo();
  var9 linkTo(var2);
  var10 = scripts\mp\gameobjects::createuseobject(var1, var9, var8, (0, 0, 90));
  var10 scripts\mp\gameobjects::allowuse("friendly");
  var10 scripts\mp\gameobjects::setusetime(0);
  var10 scripts\mp\gameobjects::cancontestclaim(1);
  var10 scripts\mp\gameobjects::mustmaintainclaim(1);
  var10.onuse = &tank_onuse;
  var10.onunoccupied = &tank_onunoccupied;
  var10.oncontested = &tank_oncontested;
  var10.onuncontested = &tank_onuncontested;
  var2.useobj = var10;
  var2.damaged = 0;
  var2.trackedobject = var2 scripts\mp\gameobjects::createtrackedobject(var2, (0, 0, 64));
  var2.trackedobject.objidpingfriendly = 0;
  var2.trackedobject.objidpingenemy = 1;
  var2.trackedobject.objpingdelay = 0.05;
  var2.trackedobject.visibleteam = "any";
  var2.invulnerable = 1;
  var2.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget, level.icontarget);
  level.tank = var2;
}

function bradley_handletacopsdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;

  if(var3 == "MOD_MELEE") {
    return 0;
  }

  var4 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var1, var2, var3, var4, 3000, 8, 12, 16);
  return var4;
}

function bradley_handlefataltacopsdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;

  if(level.teambased) {
    var6 = "";

    if(isDefined(var1) && isDefined(var1.team)) {
      var6 = var1.team;
    }

    if(var6 != self.team) {}
  } else if(isDefined(var1) && (!isDefined(self.owner) || self.owner != var1)) {}

  thread bradley_vehicledestroy(var1, var2, var3, 0);
}

function bradley_vehicledestroy(var0, var1, var2, var3) {
  self.damaged = 1;
  self notify("bradley_disabled");
  var3 = istrue(var3);
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
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);

    if(istrue(self.isrepairing)) {
      continue;
    }

    scripts\engine\utility::ref_143b9(3, "damage");
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
    var0 = 0;
    var1 = 0.2;
    var2 = 10;
  } else {
    self.isrepairing = 1;
    var0 = 10;
    var1 = 0.1;
    var2 = 100;
  }

  wait var0;
  scripts\mp\utility\print::printboldonteam("Repairing Bradley", "allies");

  while(self.damagetaken != 0) {
    self.damagetaken = max(self.damagetaken - var2, 0);
    wait var1;
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

function tank_onuse(var0) {
  var1 = var0.team;
  var2 = scripts\mp\gameobjects::getownerteam();
  var3 = scripts\mp\utility\game::getotherteam(var1)[0];
  var4 = gettime();

  if(istrue(self.allowpartialrepairs)) {
    thread bradley_restorehealth();
  }

  thread startmove(level);
  level.usestartspawns = 0;
  var5 = 0;
  level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  if(!isDefined(level.lastcaptureteam) || level.lastcaptureteam != var1) {
    var6 = [];
    var7 = getarraykeys(self.touchlist[var1]);

    for(var8 = 0; var8 < var7.size; var8++) {
      var6 = self.touchlist[var1][var7[var8]];
    }
  }

  level.hpcapteam = var1;
  scripts\mp\gameobjects::setownerteam(var1);
  level.lastcaptureteam = var1;
}

function tank_onunoccupied() {
  level notify("zone_destroyed");
  level.hpcapteam = "neutral";
  var0 = 1;

  foreach(var2 in level.teamnamelist) {
    if(self.numtouching[var2] > 0) {
      var0 = 0;
      break;
    }
  }

  if(var0) {
    level.tank.useobj.wasleftunoccupied = 1;
    level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  }

  self notify("payload_stopped");
  level.tank moveTo(level.tank.origin, 0.05, 0, 0);
  level.tank rotateTo(level.tank.angles, 1, 0, 0);
}

function tank_oncontested() {
  var0 = level.tank.useobj scripts\mp\gameobjects::getownerteam();
  level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);

  if(var0 == "neutral") {
    var1 = self.claimteam;
  } else {
    var1 = var1;
  }

  self notify("payload_stopped");
  level.tank moveTo(level.tank.origin, 0.05, 0, 0);
}

function tank_onuncontested(var0) {
  var1 = level.tank.useobj scripts\mp\gameobjects::getownerteam();

  if(var0 == "none" || var1 == "neutral") {
    level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    return;
  }

  level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function startmove(var0) {
  level endon("game_ended");
  moveonpath(var0, level.tankmovetopath);
}

function createpatharray() {
  level.tankmovetopath = scripts\engine\utility::getStruct("tank_path", "targetname");
  thread spawnbradleypayload();
}

function getpathstart(var0, var1) {
  var2 = 100;
  var3 = 150;
  var4 = (0, var1, 0);
  var5 = var0 + anglesToForward(var4) * -1 * var3;
  var5 += ((randomfloat(2) - 1) * var2, (randomfloat(2) - 1) * var2, 0);
  return var5;
}

function moveonpath(var0) {
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

  var1 = level.tankmovetopath.origin;
  var2 = getphysicspointaboutnavmesh(var1);
  var3 = distance(self.origin, var2);

  if(var3 < 10 && !level.gameended) {
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

  var4 = var3 / self.speed;
  self moveTo(var2, var4, 0, 0);
  self rotateTo((level.tankmovetopath.angles[0], level.tankmovetopath.angles[1], self.angles[2]), 1);
  wait var4;
}

function getphysicspointaboutnavmesh(var0) {
  var1 = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var2 = physics_raycast(var0 + (0, 0, 48), var0 - (0, 0, 48), var1, undefined, 0, "physicsquery_closest");
  var3 = isDefined(var2) && var2.size > 0;

  if(var3) {
    var4 = var2[0]["position"];
    return var4;
  }

  return var1;
}

function seticonnames() {
  level.icontarget = "waypoint_hardpoint_target";
  level.iconcapture = "waypoint_capture_kill";
  level.icondefend = "waypoint_escort";
  level.iconcontested = "waypoint_hardpoint_contested";
}