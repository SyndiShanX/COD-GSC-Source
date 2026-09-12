/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spawnlogic.gsc
***********************************************/

function init() {
  level.spawnglobals = spawnStruct();

  if(scripts\mp\utility\game::isanymlgmatch()) {
    level.killstreakspawnshielddelayms = 0;
  } else {
    level.killstreakspawnshielddelayms = 4000;
  }

  level.forcebuddyspawn = 0;
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
  level.numplayerswaitingtospawn = 0;
  level.numplayerswaitingtoenterkillcam = 0;
  level.players = [];
  level.playersbyentitynumber = [];
  level.participants = [];
  level.characters = [];
  level.spawnpointarray = [];
  level.grenades = [];
  level.missiles = [];
  level.carepackages = [];
  level.helis = [];
  level.turrets = [];
  level.tanks = [];
  level.scramblers = [];
  level.ugvs = [];
  level.playerkillstreaks = [];
  level.spawnglobals.lowerlimitfullsights = getdvarfloat("scr_lowerLimitFullSights");
  level.spawnglobals.lowerlimitcornersights = getdvarfloat("scr_lowerLimitCornerSights");
  level.spawnglobals.lastteamspawnpoints = [];
  level.spawnglobals.lastbadspawntime = [];
  level.spawnglobals.influencenodealloccounts = [];
  level.spawnglobals.spawnsets = [];
  level.spawnglobals.activespawnsets = [];
  level.spawnglobals.spawnsetlists = [];
  level.spawnglobals.spawnpointscriptdata = [];
  thread spawnpointupdate();
  thread trackgrenades();
  thread trackmissiles();
  thread trackhostmigrationend();
  thread trackcarepackages();
  thread printstartupdebugmessages();
  thread logextraspawninfothink();

  for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
    level.teamspawnpoints[level.teamnamelist[var_0]] = [];
    level.teamfallbackspawnpoints[level.teamnamelist[var_0]] = [];
  }

  scripts\mp\spawnfactor::init_spawn_factors();
  loadspawnlogicweights();
  var_1 = getEntArray("trigger_multiple_mp_spawn_lane", "classname");
  level.spawnglobals.lanetriggers = var_1;

  foreach(var_3 in level.spawnglobals.lanetriggers) {
    var_3.index = var_4;
    var_3.indexflag = 1 << var_4;
  }

  var_5 = getEntArray("trigger_multiple_mp_spawn_ignore", "classname");

  foreach(var_7 in var_5) {
    scripts\mp\utility\trigger::makeenterexittrigger(var_7, &ignoretriggerenter, &ignoretriggerexit);
  }
}

function codecallbackhandler_spawnpointprecalc(var_0) {}

function codecallbackhandler_spawnpointscore(var_0, var_1) {
  var_2 = level.spawnglobals.activespawncontext;
  var_3 = level.spawnglobals;
  var_4 = 0;
  var_0.scriptdata = level.spawnglobals.spawnpointscriptdata[var_0.index];

  foreach(var_6 in var_3.activescriptfactors) {
    var_7 = 0;

    if(isDefined(var_6.paramreflist)) {}

    var_7 = [[var_6.func]](var_0);
    var_4 += var_7 * var_6.weight;
  }

  return var_4;
}

function codecallbackhandler_spawnpointcritscore(var_0, var_1) {
  var_2 = scripts\mp\spawnscoring::criticalfactors_callback(var_0);
  return var_2;
}

function getspawnpoint(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = createspawnquerycontext(var_0, var_1, var_5);
  setactivespawnquerycontext(var_6);

  if(level.forcebuddyspawn) {
    var_7 = scripts\mp\spawnscoring::findbuddyspawn();

    if(isDefined(var_7)) {
      return var_7;
    }
  }

  if(!isDefined(var_4)) {
    var_4 = "buddy";
  }

  if(getdvarint("scr_game_disable_buddy_spawning", 0) == 1) {
    if(var_4 == "buddy") {
      var_4 = "bad";
    }
  }

  var_8 = getspawnbucketfromstring(var_4);

  if(isDefined(var_2)) {
    activatespawnset(var_2, 1);
  }

  var_9 = getspawnpointfromcode();
  var_9.ref_140ad = 0;
  var_10 = var_9.ref_140ad;
  var_11 = var_9.threatsight;
  var_12 = var_9.damagemod;

  if(isDefined(var_3) && getspawnsetsize(var_3) > 0 && var_9.bucket >= 2) {
    activatespawnset(var_3, 1);
    var_13 = getspawnpointfromcode();

    if(isDefined(var_13) && (var_13.bucket < var_9.bucket || var_13.totalscore > var_9.totalscore)) {
      var_9 = var_13;
      var_9.ref_140ad = 1;
      var_10 = var_9.ref_140ad;
      var_11 = var_9.threatsight;
      var_12 = var_9.damagemod;
    }
  }

  if(var_9.bucket > var_8) {
    return undefined;
  }

  if(var_9.bucket >= 2) {
    if(var_8 >= 3) {
      var_7 = scripts\mp\spawnscoring::findbuddyspawn();

      if(isDefined(var_7)) {
        scripts\mp\spawnscoring::logbadspawn("Using buddy spawn", var_0);
        var_7.bucket = 3;
        var_7.ref_140ad = var_10;
        var_7.threatsight = var_11;
        var_7.damagemod = var_12;
        return var_7;
      }

      scripts\mp\spawnscoring::logbadspawn("CANNOT BUDDY SPAWN! Using bad code spawn", var_0);
    }
  }

  if(!istrue(level.loadoutdefaultfiresalediscount) && !istrue(var_0.skipspawncamera) && var_9.bucket >= 2 && var_9.threatsight < 300) {
    var_0.ref_132ff = 1;
  }

  return var_9;
}

function createspawnquerycontext(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.player = var_0;
  var_3.team = var_1;
  var_3.time = gettime();
  var_3.factorparams = var_2;

  if(level.teambased) {
    var_3.enemyteam = scripts\mp\utility\teams::getenemyteams(var_1)[0];
  } else {
    var_3.enemyteam = "none";
  }

  return var_3;
}

function setactivespawnquerycontext(var_0) {
  level.spawnglobals.activespawncontext = var_0;
}

function getactivespawnquerycontext() {
  return level.spawnglobals.activespawncontext;
}

function clearactivespawnquerycontext() {
  level.spawnglobals.activespawncontext = undefined;
}

function trackhostmigrationend() {
  for(;;) {
    self waittill("host_migration_end");
    deactivateallspawnsets();
  }
}

function clearcodefactors() {
  foreach(var_1 in level.spawnglobals.factors) {
    enablefrontlinecriticalfactor(var_2, 0);
  }
}

function registercodefactors(var_0) {
  foreach(var_2 in var_0) {
    enablefrontlinecriticalfactor(var_3, var_2);
  }

  enablefrontlinecriticalfactor("script", 1);
}

function setactivespawnlogic(var_0, var_1) {
  var_2 = level.spawnglobals;
  var_2.logicvariantid = 0;
  var_2.activespawnlogic = var_0;
  var_2.activescriptfactors = [];

  foreach(var_6, var_4 in var_2.spawnfactorweights[var_0]) {
    if(scripts\mp\spawnfactor::isfactorregistered(var_6) && scripts\mp\spawnfactor::isfactorscriptonly(var_6)) {
      var_5 = spawnStruct();
      var_5.func = scripts\mp\spawnfactor::getfactorfunction(var_6);
      var_5.paramreflist = scripts\mp\spawnfactor::getfactorparamreflist(var_6);
      var_5.weight = var_4;
      var_2.activescriptfactors[var_6] = var_5;
    }
  }

  clearcodefactors();
  registercodefactors(var_2.spawnfactorweights[var_0]);

  if(istrue(var_2.criticalfactortypes[var_1]["frontline"])) {
    var_7 = scripts\mp\spawnfactor::getglobalfrontlineinfo();

    if(isDefined(var_7) && isDefined(var_7.anchordir) && isDefined(var_7.primaryanchorpos)) {
      registerspawnteamsmode(var_7.anchordir, var_7.primaryanchorpos);
    } else {
      registerspawnteamsmode();
    }
  }

  if(level.teambased) {
    createspawninfluencepoint(1);
    return;
  }

  createspawninfluencepoint(0);
}

function loadspawnlogicweights() {
  level.spawnglobals.spawnfactorweights = [];
  level.spawnglobals.criticalfactortypes = [];
  var_0 = -1;

  for(;;) {
    var_0++;
    var_1 = tablelookupbyrow("mp/spawnweights.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/spawnweights.csv", var_0, 2);
    var_3 = tablelookupbyrow("mp/spawnweights.csv", var_0, 1);

    if(var_3 == "Normal") {
      if(!isDefined(level.spawnglobals.spawnfactorweights[var_1])) {
        level.spawnglobals.spawnfactorweights[var_1] = [];
      }

      var_4 = tablelookupbyrow("mp/spawnweights.csv", var_0, 3);
      var_4 = float(var_4);
      level.spawnglobals.spawnfactorweights[var_1][var_2] = var_4;
      continue;
    }

    if(!isDefined(level.spawnglobals.criticalfactortypes[var_1])) {
      level.spawnglobals.criticalfactortypes[var_1] = [];
    }

    level.spawnglobals.criticalfactortypes[var_1][var_2] = 1;
  }
}

function scorespawnpoint(var_0) {
  foreach(var_2 in level.spawnglobals.spawnfactorweights[level.spawnglobals.activespawnlogic]) {
    scripts\mp\spawnfactor::calculatefactorscore(var_0, var_3, var_2);
  }
}

function isfactorinuse(var_0) {
  return isDefined(level.spawnglobals.spawnfactorweights[level.spawnglobals.activespawnlogic][var_0]);
}

function addstartspawnpoints(var_0, var_1, var_2) {
  var_3 = getspawnpointarray(var_0);
  var_4 = [];

  if(isDefined(level.modifiedspawnpoints)) {
    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      if(ref_12cc8(var_3[var_5])) {
        continue;
      }

      if(checkmodifiedspawnpoint(var_3[var_5])) {
        continue;
      }

      var_4 = var_3[var_5];
    }
  } else {
    var_4 = var_3;
  }

  if(!var_4.size) {
    if(istrue(var_1)) {}

    return;
  }

  if(!isDefined(level.startspawnpoints)) {
    level.startspawnpoints = [];
  }

  if(isDefined(var_2)) {
    if(!isDefined(level.teamstartspawnpoints)) {
      level.teamstartspawnpoints = [];
    }

    if(!isDefined(level.teamstartspawnpoints[var_2])) {
      level.teamstartspawnpoints[var_2] = [];
    }
  }

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    spawnpointinit(var_4[var_5]);
    var_4[var_5].selected = 0;
    var_4[var_5].infront = 0;
    level.startspawnpoints[level.startspawnpoints.size] = var_4[var_5];

    if(isDefined(var_2)) {
      level.teamstartspawnpoints[var_2][level.teamstartspawnpoints[var_2].size] = var_4[var_5];
    }
  }

  if(level.teambased) {
    foreach(var_7 in var_4) {
      var_7.infront = 1;
      var_8 = anglesToForward(var_7.angles);

      foreach(var_10 in var_4) {
        if(var_7 == var_10) {
          continue;
        }

        var_11 = vectorNormalize(var_10.origin - var_7.origin);
        var_12 = vectordot(var_8, var_11);

        if(var_12 > 0.86) {
          var_7.infront = 0;
          break;
        }
      }
    }

    return;
  }
}

function addspawnpoints(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = getspawnpointarray(var_1);

  if(!var_4.size) {
    if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {}

    return;
  }

  registerspawnpoints(var_0, var_4, var_3);
}

function registerspawnpoints(var_0, var_1, var_2) {
  if(!isDefined(level.spawnpoints)) {
    level.spawnpoints = [];
  }

  if(!isDefined(level.teamspawnpoints[var_0])) {
    level.teamspawnpoints[var_0] = [];
  }

  if(!isDefined(level.teamfallbackspawnpoints[var_0])) {
    level.teamfallbackspawnpoints[var_0] = [];
  }

  foreach(var_4 in var_1) {
    if(ref_12cc8(var_4)) {
      continue;
    }

    if(checkmodifiedspawnpoint(var_4)) {
      continue;
    }

    if(!isDefined(var_4.inited)) {
      spawnpointinit(var_4);
      level.spawnpoints[level.spawnpoints.size] = var_4;
    }

    if(istrue(var_2)) {
      level.teamfallbackspawnpoints[var_0][level.teamfallbackspawnpoints[var_0].size] = var_4;
      var_4.isfallback = 1;
      continue;
    }

    level.teamspawnpoints[var_0][level.teamspawnpoints[var_0].size] = var_4;
  }
}

function spawnpointinit() {
  var_0 = self;
  var_0.scriptdata = spawnStruct();
  level.spawnglobals.spawnpointscriptdata[var_0.index] = var_0.scriptdata;
  level.spawnmins = expandmins(level.spawnmins, var_0.origin);
  level.spawnmaxs = expandmaxs(level.spawnmaxs, var_0.origin);
  var_0.forward = anglesToForward(var_0.angles);
  var_0.sighttracepoint = var_0.origin + (0, 0, 50);
  var_0.lastspawntime = gettime();
  var_0.outside = 1;
  var_0.inited = 1;
  var_0.alternates = [];
  var_0.lastscore = [];
  var_1 = physics_createcontents(["physicscontents_solid", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_2 = physics_raycast(var_0.sighttracepoint, var_0.sighttracepoint + (0, 0, 1024), var_1, [], 0, "physicsquery_any");

  if(var_2 > 0) {
    var_3 = var_0.sighttracepoint + var_0.forward * 100;
    var_2 = physics_raycast(var_3, var_0.sighttracepoint + (0, 0, 1024), var_1, [], 0, "physicsquery_any");

    if(var_2 > 0) {
      var_0.outside = 0;
    }
  }

  if(shoulduseprecomputedlos() || generatinglosdata()) {
    var_0.radiuspathnodes = getradiuspathsighttestnodes(var_0.origin);

    if(var_0.radiuspathnodes.size <= 0) {}
  }

  var_0.lanemask = 0;
  var_0.lanes = [];

  foreach(var_5 in level.spawnglobals.lanetriggers) {
    if(ispointinvolume(var_0.origin, var_5)) {
      var_0.lanemask |= var_5.indexflag;
      var_0.lanes[var_0.lanes.size] = var_5.index;
    }
  }

  initspawnpointvalues(var_0);
  loginitialspawnposition(var_0);
}

function getspawnpointarray(var_0, var_1) {
  if(!isDefined(level.spawnpointarray)) {
    level.spawnpointarray = [];
  }

  if(!isDefined(level.spawnpointarray[var_0])) {
    level.spawnpointarray[var_0] = [];

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      var_2 = getspawnarray(var_0);

      foreach(var_4 in var_2) {
        if(ref_12cc8(var_4)) {
          continue;
        }

        if(checkmodifiedspawnpoint(var_4)) {
          continue;
        }

        if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == level.localeid) {
          level.spawnpointarray[var_0][level.spawnpointarray[var_0].size] = var_4;
        }
      }

      if(level.spawnpointarray[var_0].size == 0) {
        level.spawnpointarray[var_0] = var_2;
      }
    } else {
      var_2 = getspawnarray(var_2);

      foreach(var_4 in var_2) {
        if(ref_12cc8(var_4)) {
          continue;
        }

        if(checkmodifiedspawnpoint(var_4)) {
          continue;
        }

        if(isDefined(var_4.script_noteworthy) && issubstr(var_4.script_noteworthy, "locale")) {
          continue;
        }

        level.spawnpointarray[var_2][level.spawnpointarray[var_2].size] = var_4;
      }
    }
  }

  var_8 = level.spawnpointarray[var_2];

  if(istrue(var_4)) {
    level.spawnpointarray[var_2] = level.ref_12f8c[var_2];
    return level.spawnpointarray[var_2];
  }

  if(isDefined(level.ref_12f8c) && isDefined(level.ref_12f8c[var_2])) {
    var_8 = scripts\engine\utility::array_combine(var_8, level.ref_12f8c[var_2]);
  }

  return var_8;
}

function getspawnpointfromcode() {
  var_0 = self getspawnpointforplayer();
  getentitylessscriptablearray("mp_spawn_event", ["score", var_0.score, "threatsight", var_0.threatsight, "totalscore", var_0.totalscore, "spawnx", var_0.origin[0], "spawny", var_0.origin[1], "spawnz", var_0.origin[2]]);
  var_0.bucket = getspawnbucketfromstring(var_0.score);
  var_0.isbadspawn = var_0.score == "bad";
  logcodefrontlineupdate(var_0);
  return var_0;
}

function logcodefrontlineupdate(var_0) {
  if(scripts\mp\matchrecording::matchrecording_isenabled()) {
    if(istrue(var_0.frontlineenabled)) {
      var_1 = scripts\engine\utility::ter_op(self.team == "allies", var_0.frontlineused, 1);
      var_2 = scripts\engine\utility::ter_op(self.team == "axis", var_0.frontlineused, 1);
      var_3 = rotatevector(var_0.frontlinedir, (0, 90, 0));
      scripts\mp\spawnfactor::logfrontlinetomatchrecording(var_0.frontlinepos, var_3, var_1, var_2);
      return;
    }

    return;
  }
}

function getspawnpoint_random(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = undefined;
  var_0 = scripts\mp\spawnscoring::checkdynamicspawns(var_0);
  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_3 in var_0) {
    var_1 = var_3;

    if(canspawn(var_1.origin) && !positionwouldtelefrag(var_1.origin)) {
      break;
    }
  }

  return var_1;
}

function getspawnpoint_startspawn(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_2 = undefined;
  var_0 = scripts\mp\spawnscoring::checkdynamicspawns(var_0);

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.selected)) {
      continue;
    }

    if(var_4.selected) {
      continue;
    }

    if(var_4.infront) {
      var_2 = var_4;
      break;
    }

    var_2 = var_4;
  }

  if(!isDefined(var_2)) {
    if(istrue(var_1)) {
      return undefined;
    }

    var_2 = getspawnpoint_random(var_0);
  }

  if(isDefined(var_2)) {
    var_2.selected = 1;
  }

  return var_2;
}

function trackgrenades() {
  for(;;) {
    level.grenades = getEntArray("grenade", "classname");
    wait 0.05;
  }
}

function trackmissiles() {
  for(;;) {
    level.missiles = getEntArray("rocket", "classname");
    wait 0.05;
  }
}

function trackcarepackages() {
  for(;;) {
    level.carepackages = getEntArray("care_package", "targetname");
    wait 0.05;
  }
}

function getteamspawnpoints(var_0) {
  return level.teamspawnpoints[var_0];
}

function getteamfallbackspawnpoints(var_0) {
  return level.teamfallbackspawnpoints[var_0];
}

function ispathdataavailable() {
  if(!isDefined(level.pathdataavailable)) {
    level.pathdataavailable = getsentientcounts() > 150;
  }

  return level.pathdataavailable;
}

function addtoparticipantsarray() {
  level.participants[level.participants.size] = self;
}

function removefromparticipantsarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.participants.size; var_1++) {
    if(level.participants[var_1] == self) {
      var_0 = 1;

      while(var_1 < level.participants.size - 1) {
        level.participants[var_1] = level.participants[var_1 + 1];
        var_1++;
      }

      level.participants[var_1] = undefined;
      break;
    }
  }
}

function addtocharactersarray() {
  level.characters[level.characters.size] = self;
}

function removefromcharactersarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.characters.size; var_1++) {
    if(level.characters[var_1] == self) {
      var_0 = 1;

      while(var_1 < level.characters.size - 1) {
        level.characters[var_1] = level.characters[var_1 + 1];
        var_1++;
      }

      level.characters[var_1] = undefined;
      break;
    }
  }
}

function spawnpointupdate() {
  while(!isDefined(level.spawnpoints) || level.spawnpoints.size == 0) {
    waitframe();
  }

  var_0 = generatinglosdata();

  if(shoulduseprecomputedlos() || var_0) {
    if(var_0) {
      wait 1;
      var_1 = getEntArray();

      foreach(var_3 in var_1) {
        if(isDefined(var_3.classname) && var_3.classname == "script_brushmodel" && var_3.spawnflags & 1) {
          var_3 connectpaths();
        }

        if(isDefined(var_3.targetname) && var_3.targetname == "dynamic_door") {
          var_3 delete();
        }
      }

      waitframe();
    }

    var_5 = [];

    if(level.spawnpoints.size == 0) {
      scripts\engine\utility::error("Spawn System Failure. No Spawnpoints found.");
    }

    for(var_6 = 0; var_6 < level.spawnpoints.size; var_6++) {
      for(var_7 = 0; var_7 < level.spawnpoints[var_6].radiuspathnodes.size; var_7++) {
        var_5 = level.spawnpoints[var_6].radiuspathnodes[var_7];
      }
    }

    if(var_5.size > 0) {
      cachespawnpathnodesincode(var_5);
      return;
    }

    if(!istrue(level.nopathnodes) && !istrue(level.largemap)) {
      scripts\engine\utility::error("Spawn System Failure. There are no pathnodes near any spawnpoints.");
      return;
    }

    return;
  }
}

function getactiveplayerlist() {
  var_0 = [];

  foreach(var_2 in level.characters) {
    if(!scripts\mp\utility\player::isreallyalive(var_2)) {
      continue;
    }

    if(isPlayer(var_2)) {
      if(var_2.sessionstate != "playing") {
        continue;
      }

      if(!var_2 scripts\mp\utility\player::isplayerallowedforspawnlogic()) {
        continue;
      }
    }

    var_2.spawnlogicteam = getspawnteam(var_2);

    if(var_2.spawnlogicteam == "spectator") {
      continue;
    }

    if(isagent(var_2) && var_2.agent_type == "seeker") {
      continue;
    }

    var_3 = getplayertraceheight(var_2);
    var_4 = var_2 getEye();
    var_4 = (var_4[0], var_4[1], var_2.origin[2] + var_3);
    var_2.spawnlogictraceheight = var_3;
    var_2.spawntracelocation = var_4;
    var_0 = var_2;
  }

  return var_0;
}

function addspawnviewer(var_0) {
  var_0 registerentityspawnviewer();
}

function removespawnviewer(var_0) {
  var_0 clearentityspawnviewer();
}

function addspawndangerzone(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return influencepoint_add(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

function removespawndangerzone(var_0) {
  influencepoint_remove(var_0);
}

function isspawndangerzonealive(var_0) {
  return influencepoint_isscripthandlevalid(var_0);
}

function getdefaultminedangerzoneradiussize() {
  return 350;
}

function influencepoint_add(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_3) && isDefined(var_5)) {
    var_3 = var_5.team;
  }

  var_10 = undefined;

  if(isDefined(var_5) && isPlayer(var_5)) {
    if(isDefined(var_6)) {
      var_10 = destroyspawninfluencepoint(var_0, var_1, var_2, var_3, var_5, var_6);
    } else {
      var_10 = destroyspawninfluencepoint(var_0, var_1, var_2, var_3, var_5);
    }
  } else {
    var_10 = destroyspawninfluencepoint(var_0, var_1, var_2, var_3);
  }

  if(!isDefined(var_10)) {
    return;
  }

  var_11 = influencepoint_getnewscripthandle(var_10);

  if(!istrue(var_9)) {
    thread influencepoint_cleanupthink(var_11, &removespawndangerzone, var_7, var_4, var_8);
  }

  return var_11;
}

function influencepoint_remove(var_0) {
  var_1 = influencepoint_getcodehandlefromscripthandle(var_0);
  animsetgetanimfromindex(var_1);
  influencepoint_invalidatescripthandlesforcodehandle(var_1);
}

function influencepoint_getnewscripthandle(var_0) {
  var_1 = level.spawnglobals;

  if(!isDefined(var_1.influencenodealloccounts[var_0])) {
    var_1.influencenodealloccounts[var_0] = 0;
  }

  var_2 = var_1.influencenodealloccounts[var_0];
  var_3 = var_2 << 16 | var_0;
  return var_3;
}

function influencepoint_invalidatescripthandlesforcodehandle(var_0) {
  var_1 = level.spawnglobals;
  var_1.influencenodealloccounts[var_0]++;
  var_2 = var_1.influencenodealloccounts[var_0];

  if(var_2 >= 65535) {
    var_2 = 0;
    var_1.influencenodealloccounts[var_0] = 0;
    return;
  }
}

function influencepoint_getcodehandlefromscripthandle(var_0) {
  return var_0 & 65535;
}

function influencepoint_getalloccountfromscripthandle(var_0) {
  return var_0 >> 16;
}

function influencepoint_isscripthandlevalid(var_0) {
  var_1 = level.spawnglobals;
  var_2 = influencepoint_getalloccountfromscripthandle(var_0);
  var_3 = influencepoint_getcodehandlefromscripthandle(var_0);
  var_4 = var_1.influencenodealloccounts[var_3];
  return isDefined(var_4) && var_2 == var_4;
}

function influencepoint_cleanupthink(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_5 = [];

  if(isDefined(var_4)) {
    GscBinSkip0(0x2e, var_5.size, "death");
  }

  if(isDefined(var_3)) {
    if(var_5.size > 0) {
      var_2 scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(var_5, var_3);
    } else {
      wait var_3;
    }
  } else if(isDefined(var_2)) {
    var_2 scripts\engine\utility::waittill_any_in_array_return(var_5);
  }

  if(!influencepoint_isscripthandlevalid(var_0)) {
    return;
  }

  [[var_1]](var_0);
}

function updatespawnviewers() {
  level.spawnviewers = getactiveplayerlist();

  foreach(var_1 in level.spawnviewers) {
    var_1.spawnviewpathnodes = undefined;
  }

  foreach(var_4 in level.turrets) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4.spawnlogicteam = getspawnteam(var_4);
    level.spawnviewers[level.spawnviewers.size] = var_4;
    var_4.spawnviewpathnodes = undefined;
  }

  foreach(var_7 in level.ugvs) {
    if(!isDefined(var_7)) {
      continue;
    }

    var_7.spawnlogicteam = getspawnteam(var_7);
    level.spawnviewers[level.spawnviewers.size] = var_7;
    var_7.spawnviewpathnodes = undefined;
  }
}

function arespawnviewersvalid() {
  return isDefined(level.spawnviewersupdatetime) && level.spawnviewersupdatetime == gettime();
}

function logspawnpointsightupdate(var_0, var_1) {
  if(istrue(var_0.buddyspawn) || istrue(var_0.isdynamicspawn)) {
    return;
  }

  if(isDefined(level.matchrecording_logevent)) {
    if(isDefined(level.matchrecording_generateid) && !isDefined(var_0.logid)) {
      var_0.logid = [[level.matchrecording_generateid]]();
    }

    if(isDefined(var_0.logid)) {
      var_2 = 3;

      if(level.teambased) {
        var_3 = 1;
        var_4 = 1;

        if(var_1 == "allies") {
          var_3 = var_0.logspawndisabled["allies"] == 0;
          var_5 = isDefined(var_0.loggedstate) && (var_0.loggedstate == 0 || var_0.loggedstate == 2);
          var_4 = scripts\engine\utility::ter_op(isDefined(var_0.loggedstate), var_5, 0);
        } else {
          var_4 = var_0.logspawndisabled["axis"] == 0;
          var_6 = isDefined(var_0.loggedstate) && (var_0.loggedstate == 0 || var_0.loggedstate == 1);
          var_3 = scripts\engine\utility::ter_op(isDefined(var_0.loggedstate), var_6, 0);
        }

        if(var_3 && var_4) {
          var_2 = 0;
        } else if(var_3) {
          var_2 = 1;
        } else if(var_4) {
          var_2 = 2;
        }
      } else {
        var_2 = scripts\engine\utility::ter_op(var_0.fullsights["all"] == 0, 0, 3);
      }

      if(!isDefined(var_0.loggedstate) || var_0.loggedstate != var_2) {
        [[level.matchrecording_logevent]](var_0.logid, "allies", "SPAWN_ENTITY", var_0.origin[0], var_0.origin[1], gettime(), var_2);
        var_0.loggedstate = var_2;
        return;
      }

      return;
    }

    return;
  }
}

function loginitialspawnposition(var_0) {
  if(istrue(var_0.buddyspawn) || istrue(var_0.isdynamicspawn)) {
    return;
  }

  if(isDefined(level.matchrecording_logevent)) {
    if(isDefined(level.matchrecording_generateid) && !isDefined(var_0.logid)) {
      var_0.logid = [[level.matchrecording_generateid]]();
    }

    if(isDefined(var_0.logid) && !isDefined(var_0.didinitiallog)) {
      [[level.matchrecording_logevent]](var_0.logid, "allies", "SPAWN_ENTITY", var_0.origin[0], var_0.origin[1], gettime(), 0);
      var_0.didinitiallog = 1;
      return;
    }

    return;
  }
}

function spawnpointdistanceupdate(var_0) {
  foreach(var_2 in level.spawnviewers) {
    var_3 = distancesquared(var_2.origin, var_0.origin);

    if(var_3 < var_0.mindistsquared[var_2.spawnlogicteam]) {
      var_0.mindistsquared[var_2.spawnlogicteam] = var_3;
    }

    if(var_2.spawnlogicteam == "spectator") {
      continue;
    }

    var_0.distsumsquared[var_2.spawnlogicteam] += var_3;
    var_0.distsumsquaredcapped[var_2.spawnlogicteam] += min(var_3, scripts\mp\spawnfactor::maxplayerspawninfluencedistsquared());
    var_0.totalplayers[var_2.spawnlogicteam]++;
  }

  var_0.hasdistdata = 1;
}

function getspawnteam(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = var_0.team;
  }

  return var_1;
}

function initspawnpointvalues(var_0) {
  clearspawnpointsightdata(var_0);
  clearspawnpointdistancedata(var_0);
}

function clearspawnpointsightdata(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.teamnamelist) {
      clearteamspawnpointsightdata(var_0, var_2);
    }

    return;
  }

  clearteamspawnpointsightdata(var_0, "all");
}

function setupplayerspawnsightdata(var_0) {}

function clearspawnpointdistancedata(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.teamnamelist) {
      clearteamspawnpointdistancedata(var_0, var_2);
    }

    return;
  }

  clearteamspawnpointdistancedata(var_0, "all");
}

function clearteamspawnpointsightdata(var_0, var_1) {
  var_0.hassightdata[var_1] = 0;
  var_0.fullsights[var_1] = 0;
  var_0.cornersights[var_1] = 0;
  var_0.logspawndisabled[var_1] = 0;
  var_0.maxsightvalue[var_1] = 0;
  var_0.maxjumpsightvalue[var_1] = 0;
}

function clearteamspawnpointdistancedata(var_0, var_1) {
  var_0.hasdistdata = 0;
  var_0.distsumsquared[var_1] = 0;
  var_0.distsumsquaredcapped[var_1] = 0;
  var_0.mindistsquared[var_1] = 9999999;
  var_0.totalplayers[var_1] = 0;
}

function getplayertraceheight(var_0, var_1) {
  if(isDefined(var_1) && var_1) {
    return 64;
  }

  var_2 = var_0 getstance();

  if(var_2 == "stand") {
    return 64;
  }

  if(var_2 == "crouch") {
    return 44;
  }

  return 32;
}

function additionalsighttraceentities(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = getspawnteam(var_3);

    if(var_0.fullsights[var_4]) {
      continue;
    }

    var_0.hassightdata[var_4] = 1;
    var_5 = var_3.origin + (0, 0, 50);
    var_6 = 0;

    if(!var_6) {
      var_6 = spawnsighttrace(var_0, var_0.sighttracepoint, var_5);
    }

    if(!var_6) {
      continue;
    }

    if(var_6 > 0.95) {
      var_0.fullsights[var_4]++;
      continue;
    }

    var_0.cornersights[var_4]++;
  }
}

function finalizespawnpointchoice(var_0) {
  if(!isPlayer(self)) {
    return;
  }

  var_1 = gettime();
  self.lastspawnpoint = var_0;
  self.lastspawntime = var_1;
  var_0.lastspawntime = var_1;
  var_0.lastspawnteam = self.team;

  if(!isDefined(var_0.bucket)) {
    self finalizespawnpointchoiceforplayer(var_0.index);
  } else {
    if(!isDefined(var_0.ref_140ad)) {
      var_0.ref_140ad = 0;
    }

    if(!isDefined(var_0.threatsight)) {
      var_0.threatsight = -1;
    }

    if(!isDefined(var_0.damagemod)) {
      var_0.damagemod = -1;
    }

    self finalizespawnpointchoiceforplayer(var_0.index, var_0.bucket, var_0.ref_140ad, var_0.threatsight, var_0.damagemod);
  }

  var_2 = level.spawnglobals.spawnpointscriptdata[var_0.index];

  if(isDefined(var_2)) {
    var_2.used = 1;
  }

  level.spawnglobals.lastteamspawnpoints[self.team] = var_0;
}

function expandspawnpointbounds(var_0) {
  var_1 = getspawnpointarray(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    level.spawnmins = expandmins(level.spawnmins, var_1[var_2].origin);
    level.spawnmaxs = expandmaxs(level.spawnmaxs, var_1[var_2].origin);
  }
}

function expandmins(var_0, var_1) {
  if(var_0[0] > var_1[0]) {
    var_0 = (var_1[0], var_0[1], var_0[2]);
  }

  if(var_0[1] > var_1[1]) {
    var_0 = (var_0[0], var_1[1], var_0[2]);
  }

  if(var_0[2] > var_1[2]) {
    var_0 = (var_0[0], var_0[1], var_1[2]);
  }

  return var_0;
}

function expandmaxs(var_0, var_1) {
  if(var_0[0] < var_1[0]) {
    var_0 = (var_1[0], var_0[1], var_0[2]);
  }

  if(var_0[1] < var_1[1]) {
    var_0 = (var_0[0], var_1[1], var_0[2]);
  }

  if(var_0[2] < var_1[2]) {
    var_0 = (var_0[0], var_0[1], var_1[2]);
  }

  return var_0;
}

function findboxcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

function setmapcenterfordev() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  expandspawnpointbounds("mp_tdm_spawn_allies_start");
  expandspawnpointbounds("mp_tdm_spawn_axis_start");
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function shoulduseteamstartspawn() {
  if(getdvarint("scr_forceStartSpawns", 0) == 1) {
    return true;
  }

  if(!scripts\mp\flags::gameflag("prematch_done") && isDefined(game["infil"]) && !scripts\mp\flags::gameflag("infil_started")) {
    return true;
  }

  if(istrue(level.disableteamstartspawns)) {
    return false;
  }

  return level.ingraceperiod && (!isDefined(level.numkills) || level.numkills == 0);
}

function getpathsighttestnodes(var_0, var_1) {
  if(var_1) {
    var_2 = 0;
    var_3 = getclosenoderadiusdist();
  } else {
    var_2 = getclosenoderadiusdist();
    var_3 = 250;
  }

  return getnodesinradius(var_2, var_3, var_2, 512, "path");
}

function getradiuspathsighttestnodes(var_0) {
  var_1 = [];
  var_2 = getclosestnodeinsight(var_0);

  if(isDefined(var_2)) {
    var_1 = var_2;
  }

  if(!isDefined(var_2)) {
    var_1 = getnodesinradius(var_0, getclosenoderadiusdist(), 0, 256, "path");

    if(var_1.size == 0) {
      var_1 = getnodesinradius(var_0, 250, 0, 256, "path");
    }
  }

  return var_1;
}

function evaluateprecomputedlos(var_0, var_1) {
  checkttlosloaded();
  var_2 = "all";

  if(level.teambased) {
    var_2 = scripts\mp\utility\teams::getenemyteams(var_1)[0];
  }

  if(!shoulduseprecomputedlos()) {
    var_0.hassightdata[var_2] = 1;
    return;
  }

  var_3 = 0.95;
  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;
  var_3 = level.spawnglobals.lowerlimitfullsights;
  var_4 = level.spawnglobals.lowerlimitcornersights;

  foreach(var_8 in level.spawnviewers) {
    if(level.teambased && var_8.spawnlogicteam != var_2) {
      continue;
    }

    if(var_0.fullsights[var_8.spawnlogicteam]) {
      break;
    }

    if(!isDefined(var_8.spawnviewpathnodes)) {
      var_8.spawnviewpathnodes = var_8 getnearnodelistforspawncheck(getfarnoderadiusdist());

      if(!isDefined(var_8.spawnviewpathnodes) || var_8.spawnviewpathnodes.size == 0) {
        if(isDefined(level.matchrecording_logeventmsg) && isPlayer(var_8)) {
          if(!isDefined(var_8.lastpathnodewarningtime) || var_8.lastpathnodewarningtime != gettime()) {
            [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "WARNING: Could not use TTLOS data for player " + var_8.name);
            var_8.lastpathnodewarningtime = gettime();
          }
        }
      }
    }

    if(isDefined(var_8.spawnviewpathnodes) && var_8.spawnviewpathnodes.size > 0) {
      [var_5] = _precomputedlosdatatest(var_8, var_0);
      var_6 = var_9[1];
    }

    if(!isDefined(var_5)) {
      var_10 = undefined;

      if(isPlayer(var_8)) {
        var_10 = var_8 getEye();
      } else {
        var_10 = var_8.origin + (0, 0, 50);
      }

      var_5 = directlineofsighttest(var_0, var_8, var_10);
      var_6 = var_5;
    }

    if(!isDefined(var_0.maxsightvalue[var_8.spawnlogicteam]) || var_5 > var_0.maxsightvalue[var_8.spawnlogicteam]) {
      var_0.maxsightvalue[var_8.spawnlogicteam] = var_5;
    }

    if(isDefined(var_6) && isPlayer(var_8)) {
      if(!isDefined(var_0.maxjumpsightvalue[var_8.spawnlogicteam]) || var_6 > var_0.maxjumpsightvalue[var_8.spawnlogicteam]) {
        var_0.maxjumpsightvalue[var_8.spawnlogicteam] = var_6;
      }
    }

    if(var_5 > var_3) {
      var_0.fullsights[var_8.spawnlogicteam]++;
      var_0.logspawndisabled[var_8.spawnlogicteam]++;
      continue;
    }

    if(var_5 > var_4) {
      var_0.cornersights[var_8.spawnlogicteam]++;
    }
  }

  var_0.hassightdata[var_2] = 1;
  logspawnpointsightupdate(var_0, var_2);
}

function _precomputedlosdatatest(var_0, var_1) {
  var_2 = checkttlosoverrides(var_0, var_1);

  if(!isDefined(var_2)) {
    if(checkttlosdeverrors(var_0, var_1)) {
      return [1, 1];
    }

    var_2 = precomputedlosdatatest(var_0.spawnviewpathnodes, var_1.radiuspathnodes);
  }

  return var_2;
}

function checkttlosdeverrors(var_0, var_1) {
  return false;
}

function checkttlosoverrides(var_0, var_1) {
  if(!isDefined(level.spawnglobals.ttlosoverrides)) {
    return;
  }

  foreach(var_3 in var_0.spawnviewpathnodes) {
    var_4 = var_3 getnodenumber();

    if(isDefined(level.spawnglobals.ttlosoverrides[var_4])) {
      foreach(var_6 in var_1.radiuspathnodes) {
        var_7 = var_6 getnodenumber();

        if(isDefined(level.spawnglobals.ttlosoverrides[var_4][var_7])) {
          return level.spawnglobals.ttlosoverrides[var_4][var_7];
        }
      }
    }
  }
}

function addttlosoverride(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  for(;;) {
    if(isDefined(level.spawnglobals)) {
      break;
    }

    waitframe();
  }

  if(!isDefined(level.spawnglobals.ttlosoverrides)) {
    level.spawnglobals.ttlosoverrides = [];
  }

  if(!isDefined(level.spawnglobals.ttlosoverrides[var_0])) {
    level.spawnglobals.ttlosoverrides[var_0] = [];
  }

  level.spawnglobals.ttlosoverrides[var_0][var_1] = [var_2, var_3];

  if(!isDefined(level.spawnglobals.ttlosoverrides[var_1])) {
    level.spawnglobals.ttlosoverrides[var_1] = [];
  }

  level.spawnglobals.ttlosoverrides[var_1][var_0] = [var_2, var_3];
}

function getclosenoderadiusdist() {
  return 130;
}

function getfarnoderadiusdist() {
  return 250;
}

function directlineofsighttest(var_0, var_1, var_2) {
  var_3 = var_0.sighttracepoint;
  var_4 = var_2;
  var_5 = physics_createcontents(["physicscontents_solid", "physicscontents_ainosight"]);
  var_6 = physics_raycast(var_3, var_4, var_5, var_1, 0, "physicsquery_any");
  return scripts\engine\utility::ter_op(var_6, 0, 1);
}

function getmaxdistancetolos() {
  return 2550;
}

function checkttlosloaded() {
  if(shoulduseprecomputedlos() && !isttlosdataavailable()) {
    if(isDefined(level.matchrecording_logeventmsg)) {
      [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "ERROR: TTLOS System disabled! Could not access visDistData");
    }

    if(!isDefined(level.hasshownvisdistdataerror)) {
      level.hasshownvisdistdataerror = 1;
    }

    level.disableprecomputedlos = 1;
    return;
  }
}

function shoulduseprecomputedlos() {
  return getdvarint("sv_usePrecomputedLOSData", 0) == 1 && !isDefined(level.disableprecomputedlos) && !generatinglosdata();
}

function generatinglosdata() {
  return getdvarint("sv_generateLOSData", 0) > 0;
}

function isttlosdataavailable() {
  return getislosdatafileloaded();
}

function printstartupdebugmessages() {
  level waittill("prematch_done");

  if(getdvarint("scr_playtest", 0) == 1 && isDefined(level.players)) {
    foreach(var_1 in level.players) {
      if(var_1 ishost()) {
        if(!shoulduseprecomputedlos()) {
          var_1 iprintlnbold("TTLOS FAILED TO LOAD!");
        }

        break;
      }
    }
  }

  if(isDefined(level.matchrecording_logeventmsg)) {
    [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "Spawn Script Version #6");

    if(shoulduseprecomputedlos()) {
      [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "Attempting to use TTLOS Spawning Data...");
    } else {
      [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "No TTLOS Data! Not using TTLOS");
    }

    [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "CODE spawn logic enabled");

    if(isDefined(level.spawnglobals.activespawnlogic)) {
      [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "Spawn Logic: " + level.spawnglobals.activespawnlogic);
      return;
    }

    [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "Spawn Logic: None");
    return;
  }
}

function isfallbackspawn(var_0) {
  return istrue(var_0.isfallback);
}

function logextraspawninfothink() {
  if(getdvarint("scr_extra_spawn_logging", 0) != 1) {
    return;
  }

  level waittill("prematch_done");
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(level.matchrecording_generateid)) {
    var_0 = [[level.matchrecording_generateid]]();
    var_1 = [[level.matchrecording_generateid]]();
  }

  for(;;) {
    if(!shoulduseprecomputedlos()) {
      break;
    }

    logextraspawn("allies", var_0);
    wait 0.5;
    logextraspawn("axis", var_1);
    wait 0.5;
  }
}

function logextraspawn(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.team = var_0;
  var_2.pers = [];
  var_2.pers["team"] = var_0;
  var_2.disablespawnwarnings = 1;
  var_2.isdynamicspawn = 1;
  var_3 = var_2[[level.getspawnpoint]]();

  if(isDefined(level.matchrecording_logevent) && isDefined(var_3) && isDefined(var_1)) {
    var_4 = scripts\engine\utility::ter_op(var_0 == "allies", "BEST_SPAWN_ALLIES", "BEST_SPAWN_AXIS");
    [[level.matchrecording_logevent]](var_1, var_0, var_4, var_3.origin[0], var_3.origin[1], gettime());
    return;
  }
}

function clearlastteamspawns() {
  level.spawnglobals.lastteamspawnpoints = [];
}

function getoriginidentifierstring(var_0) {
  return int(var_0.origin[0]) + " " + int(var_0.origin[1]) + " " + int(var_0.origin[2]);
}

function respawn_delay(var_0) {
  return int(var_0.origin[0]) + " " + int(var_0.origin[1]);
}

function checkmodifiedspawnpoint(var_0) {
  if(!isDefined(level.modifiedspawnpoints)) {
    return false;
  }

  var_1 = undefined;
  var_2 = getoriginidentifierstring(var_0);

  if(isDefined(level.modifiedspawnpoints[var_2])) {
    var_1 = level.modifiedspawnpoints[var_2][var_0.classname];
  }

  if(!isDefined(var_1)) {
    var_2 = respawn_delay(var_0);

    if(isDefined(level.modifiedspawnpoints[var_2])) {
      var_1 = level.modifiedspawnpoints[var_2][var_0.classname];
    }

    if(!isDefined(var_1)) {
      return false;
    }
  }

  if(istrue(var_1["remove"])) {
    return true;
  }

  if(isDefined(var_1["origin"])) {
    var_0.origin = var_1["origin"];
  }

  if(isDefined(var_1["angles"])) {
    var_0.angles = var_1["angles"];
  }

  if(istrue(var_1["no_alternates"])) {
    var_0.noalternates = 1;
  }

  return false;
}

function ref_12cc8(var_0) {
  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy != "") {
    var_1 = strtok(var_0.script_noteworthy, " ");

    foreach(var_3 in var_1) {
      if(level.ref_11ad3 == 1) {
        if(var_3 == "6v6") {
          return true;
        }

        continue;
      }

      if(var_3 == "10v10") {
        return true;
      }
    }
  }

  return false;
}

function calculateteamclusters(var_0) {
  var_1 = spawnStruct();
  var_1.clusterlist = [];

  foreach(var_3 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_3) || var_3.team != var_0 || !var_3 scripts\mp\utility\player::isplayerallowedforspawnlogic()) {
      continue;
    }

    var_4 = createcluster(var_3);
    var_1.clusterlist[var_1.clusterlist.size] = var_4;
  }

  mergeclusterlist(var_1);
  return var_1;
}

function createcluster(var_0) {
  var_1 = spawnStruct();
  var_1.center = var_0.origin;
  var_1.players = [var_0];
  return var_1;
}

function mergeclusterlist(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = -1;

  for(var_5 = 0; var_5 < var_0.clusterlist.size; var_5++) {
    var_6 = var_0.clusterlist[var_5];

    for(var_7 = var_5 + 1; var_7 < var_0.clusterlist.size; var_7++) {
      var_8 = var_0.clusterlist[var_7];
      var_9 = distance2dsquared(var_6.center, var_8.center);

      if(var_9 > 640000) {
        continue;
      }

      if(var_4 < 0 || var_9 < var_4) {
        var_4 = var_9;
        var_1 = var_6;
        var_2 = var_8;
        var_3 = var_7;
      }
    }
  }

  if(isDefined(var_1) && isDefined(var_2)) {
    foreach(var_11 in var_2.players) {
      var_1.players[var_1.players.size] = var_11;
    }

    var_13 = (0, 0, 0);

    foreach(var_11 in var_1.players) {
      var_13 += var_11.origin;
    }

    var_13 /= var_1.players.size;
    var_1.center = var_13;
    var_16 = var_0.clusterlist.size - 1;
    var_0.clusterlist[var_3] = var_0.clusterlist[var_16];
    var_0.clusterlist[var_16] = undefined;
    mergeclusterlist(var_0);
    return;
  }
}

function ignoretriggerenter(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_0 scripts\mp\utility\player::enableplayerforspawnlogic(0, "spawnIgnoreTrigger");
}

function ignoretriggerexit(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_0 scripts\mp\utility\player::enableplayerforspawnlogic(1, "spawnIgnoreTrigger");
}

function getspawnbucketfromstring(var_0) {
  switch (var_0) {
    case "good":
      return 0;
    case "ok":
      return 1;
    case "bad":
      return 2;
    case "buddy":
      return 3;
  }

  return 2;
}

function enablespawnpointlist(var_0) {
  foreach(var_2 in var_0) {
    registerspawnfactor(var_2.index);
  }
}

function disablespawnpointlist(var_0) {
  foreach(var_2 in var_0) {
    enablespawnpoints(var_2.index);
  }
}

function registerspawnset(var_0, var_1) {
  var_2 = level.spawnglobals;
  var_2.spawnsets[var_0] = var_1;

  if(isarray(var_1)) {
    var_2.spawnsetlists[var_0] = var_1;
  } else {
    var_2.spawnsetlists[var_0] = getspawnpointarray(var_1);
  }

  return var_0;
}

function activatespawnset(var_0, var_1) {
  var_2 = level.spawnglobals;

  if(istrue(var_1)) {
    if(var_2.activespawnsets.size == 1 && isDefined(var_2.activespawnsets[var_0])) {
      return;
    }

    deactivateallspawnsets();
  } else if(isDefined(var_2.activespawnsets[var_0])) {
    return;
  }

  var_3 = var_2.spawnsets[var_0];

  if(isarray(var_3)) {
    enablespawnpointlist(var_3);
  } else {
    enablespawnpointbyindex(var_3);
  }

  var_2.activespawnsets[var_0] = 1;
}

function deactivatespawnset(var_0) {
  var_1 = level.spawnglobals;
  var_2 = [];

  foreach(var_4 in var_1.activespawnsets) {
    if(var_6 != var_0) {
      var_2 = 1;
      continue;
    }

    var_5 = var_1.spawnsets[var_0];

    if(isarray(var_5)) {
      disablespawnpointlist(var_5);
    } else {
      disablespawnpointbyindex(var_5);
    }
  }

  var_1.activespawnsets = var_2;
}

function deactivateallspawnsets() {
  level.spawnglobals.activespawnsets = [];
  disablespawnpointsbyclassname();
}

function getspawnsetsize(var_0) {
  return level.spawnglobals.spawnsetlists[var_0].size;
}

function getrandomspawnpointfromset(var_0) {
  var_1 = level.spawnglobals;
  return var_1.spawnsetlists[var_0][randomint(var_1.spawnsetlists[var_0].size)];
}

function getrandomspawnpointfromactivesets() {
  var_0 = getarraykeys(level.spawnglobals.activespawnsets);

  for(var_1 = undefined; !isDefined(var_1) && var_0.size > 0; var_1 = undefined) {
    var_1 = scripts\engine\utility::random(var_0);

    if(getspawnsetsize(var_1) <= 0) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_1);
    }
  }

  return level.spawnglobals.spawnsetlists[var_1][randomint(level.spawnglobals.spawnsetlists[var_1].size)];
}

function init_trap_room_doors(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.classname = var_0;
  var_5.origin = var_1;
  var_5.angles = var_2;
  var_5.target = var_3;
  var_5.script_noteworthy = var_4;
  return var_5;
}

function bdiedonce(var_0) {
  if(!isDefined(level.ref_12f8c)) {
    level.ref_12f8c = [];
  }

  foreach(var_2 in var_0) {
    var_3 = var_2.classname;
    var_4 = var_2.origin;
    var_5 = var_2.angles;

    if(isDefined(var_2.target)) {
      var_6 = var_2.target;
    } else {
      var_6 = "";
    }

    if(isDefined(var_2.script_noteworthy)) {
      var_7 = var_2.script_noteworthy;
    } else {
      var_7 = "";
    }

    if(!isDefined(level.ref_12f8c[var_3])) {
      level.ref_12f8c[var_3] = [];
    }

    var_8 = spawnStruct();
    var_8.classname = var_3;
    var_8.origin = var_4;
    var_8.angles = var_5;
    var_9 = getoriginforanimtime(var_3, var_4, var_5, var_6, var_7);

    if(!isDefined(var_9) || var_9 < 0) {
      continue;
    }

    var_8.index = var_9;

    if(var_6 != "") {
      var_8.target = var_6;
    }

    if(var_7 != "") {
      var_8.script_noteworthy = var_7;
    }

    level.ref_12f8c[var_3][level.ref_12f8c[var_3].size] = var_8;
  }

  thread ref_12f8d();
}

function ref_12f8d() {
  level notify("scriptedSpawnpointsOnMigration");
  level endon("scriptedSpawnpointsOnMigration");

  for(;;) {
    level waittill("host_migration_begin");

    foreach(var_1 in level.ref_12f8c) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.target)) {
          var_4 = var_3.target;
        } else {
          var_4 = "";
        }

        if(isDefined(var_3.script_noteworthy)) {
          var_5 = var_3.script_noteworthy;
        } else {
          var_5 = "";
        }

        var_6 = getoriginforanimtime(var_3.classname, var_3.origin, var_3.angles, var_4, var_5);
      }
    }
  }
}