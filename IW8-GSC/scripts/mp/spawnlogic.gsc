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

  for(var0 = 0; var0 < level.teamnamelist.size; var0++) {
    level.teamspawnpoints[level.teamnamelist[var0]] = [];
    level.teamfallbackspawnpoints[level.teamnamelist[var0]] = [];
  }

  scripts\mp\spawnfactor::init_spawn_factors();
  loadspawnlogicweights();
  var1 = getEntArray("trigger_multiple_mp_spawn_lane", "classname");
  level.spawnglobals.lanetriggers = var1;

  foreach(var3 in level.spawnglobals.lanetriggers) {
    var3.index = var4;
    var3.indexflag = 1 << var4;
  }

  var5 = getEntArray("trigger_multiple_mp_spawn_ignore", "classname");

  foreach(var7 in var5) {
    scripts\mp\utility\trigger::makeenterexittrigger(var7, &ignoretriggerenter, &ignoretriggerexit);
  }
}

function codecallbackhandler_spawnpointprecalc(var0) {}

function codecallbackhandler_spawnpointscore(var0, var1) {
  var2 = level.spawnglobals.activespawncontext;
  var3 = level.spawnglobals;
  var4 = 0;
  var0.scriptdata = level.spawnglobals.spawnpointscriptdata[var0.index];

  foreach(var6 in var3.activescriptfactors) {
    var7 = 0;

    if(isDefined(var6.paramreflist)) {}

    var7 = [[var6.func]](var0);
    var4 += var7 * var6.weight;
  }

  return var4;
}

function codecallbackhandler_spawnpointcritscore(var0, var1) {
  var2 = scripts\mp\spawnscoring::criticalfactors_callback(var0);
  return var2;
}

function getspawnpoint(var0, var1, var2, var3, var4, var5) {
  var6 = createspawnquerycontext(var0, var1, var5);
  setactivespawnquerycontext(var6);

  if(level.forcebuddyspawn) {
    var7 = scripts\mp\spawnscoring::findbuddyspawn();

    if(isDefined(var7)) {
      return var7;
    }
  }

  if(!isDefined(var4)) {
    var4 = "buddy";
  }

  if(getdvarint("scr_game_disable_buddy_spawning", 0) == 1) {
    if(var4 == "buddy") {
      var4 = "bad";
    }
  }

  var8 = getspawnbucketfromstring(var4);

  if(isDefined(var2)) {
    activatespawnset(var2, 1);
  }

  var9 = getspawnpointfromcode();
  var9.ref_140ad = 0;
  var10 = var9.ref_140ad;
  var11 = var9.threatsight;
  var12 = var9.damagemod;

  if(isDefined(var3) && getspawnsetsize(var3) > 0 && var9.bucket >= 2) {
    activatespawnset(var3, 1);
    var13 = getspawnpointfromcode();

    if(isDefined(var13) && (var13.bucket < var9.bucket || var13.totalscore > var9.totalscore)) {
      var9 = var13;
      var9.ref_140ad = 1;
      var10 = var9.ref_140ad;
      var11 = var9.threatsight;
      var12 = var9.damagemod;
    }
  }

  if(var9.bucket > var8) {
    return undefined;
  }

  if(var9.bucket >= 2) {
    if(var8 >= 3) {
      var7 = scripts\mp\spawnscoring::findbuddyspawn();

      if(isDefined(var7)) {
        scripts\mp\spawnscoring::logbadspawn("Using buddy spawn", var0);
        var7.bucket = 3;
        var7.ref_140ad = var10;
        var7.threatsight = var11;
        var7.damagemod = var12;
        return var7;
      }

      scripts\mp\spawnscoring::logbadspawn("CANNOT BUDDY SPAWN! Using bad code spawn", var0);
    }
  }

  if(!istrue(level.loadoutdefaultfiresalediscount) && !istrue(var0.skipspawncamera) && var9.bucket >= 2 && var9.threatsight < 300) {
    var0.ref_132ff = 1;
  }

  return var9;
}

function createspawnquerycontext(var0, var1, var2) {
  var3 = spawnStruct();
  var3.player = var0;
  var3.team = var1;
  var3.time = gettime();
  var3.factorparams = var2;

  if(level.teambased) {
    var3.enemyteam = scripts\mp\utility\teams::getenemyteams(var1)[0];
  } else {
    var3.enemyteam = "none";
  }

  return var3;
}

function setactivespawnquerycontext(var0) {
  level.spawnglobals.activespawncontext = var0;
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
  foreach(var1 in level.spawnglobals.factors) {
    enablefrontlinecriticalfactor(var2, 0);
  }
}

function registercodefactors(var0) {
  foreach(var2 in var0) {
    enablefrontlinecriticalfactor(var3, var2);
  }

  enablefrontlinecriticalfactor("script", 1);
}

function setactivespawnlogic(var0, var1) {
  var2 = level.spawnglobals;
  var2.logicvariantid = 0;
  var2.activespawnlogic = var0;
  var2.activescriptfactors = [];

  foreach(var6, var4 in var2.spawnfactorweights[var0]) {
    if(scripts\mp\spawnfactor::isfactorregistered(var6) && scripts\mp\spawnfactor::isfactorscriptonly(var6)) {
      var5 = spawnStruct();
      var5.func = scripts\mp\spawnfactor::getfactorfunction(var6);
      var5.paramreflist = scripts\mp\spawnfactor::getfactorparamreflist(var6);
      var5.weight = var4;
      var2.activescriptfactors[var6] = var5;
    }
  }

  clearcodefactors();
  registercodefactors(var2.spawnfactorweights[var0]);

  if(istrue(var2.criticalfactortypes[var1]["frontline"])) {
    var7 = scripts\mp\spawnfactor::getglobalfrontlineinfo();

    if(isDefined(var7) && isDefined(var7.anchordir) && isDefined(var7.primaryanchorpos)) {
      registerspawnteamsmode(var7.anchordir, var7.primaryanchorpos);
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
  var0 = -1;

  for(;;) {
    var0++;
    var1 = tablelookupbyrow("mp/spawnweights.csv", var0, 0);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var2 = tablelookupbyrow("mp/spawnweights.csv", var0, 2);
    var3 = tablelookupbyrow("mp/spawnweights.csv", var0, 1);

    if(var3 == "Normal") {
      if(!isDefined(level.spawnglobals.spawnfactorweights[var1])) {
        level.spawnglobals.spawnfactorweights[var1] = [];
      }

      var4 = tablelookupbyrow("mp/spawnweights.csv", var0, 3);
      var4 = float(var4);
      level.spawnglobals.spawnfactorweights[var1][var2] = var4;
      continue;
    }

    if(!isDefined(level.spawnglobals.criticalfactortypes[var1])) {
      level.spawnglobals.criticalfactortypes[var1] = [];
    }

    level.spawnglobals.criticalfactortypes[var1][var2] = 1;
  }
}

function scorespawnpoint(var0) {
  foreach(var2 in level.spawnglobals.spawnfactorweights[level.spawnglobals.activespawnlogic]) {
    scripts\mp\spawnfactor::calculatefactorscore(var0, var3, var2);
  }
}

function isfactorinuse(var0) {
  return isDefined(level.spawnglobals.spawnfactorweights[level.spawnglobals.activespawnlogic][var0]);
}

function addstartspawnpoints(var0, var1, var2) {
  var3 = getspawnpointarray(var0);
  var4 = [];

  if(isDefined(level.modifiedspawnpoints)) {
    for(var5 = 0; var5 < var3.size; var5++) {
      if(ref_12cc8(var3[var5])) {
        continue;
      }

      if(checkmodifiedspawnpoint(var3[var5])) {
        continue;
      }

      var4 = var3[var5];
    }
  } else {
    var4 = var3;
  }

  if(!var4.size) {
    if(istrue(var1)) {}

    return;
  }

  if(!isDefined(level.startspawnpoints)) {
    level.startspawnpoints = [];
  }

  if(isDefined(var2)) {
    if(!isDefined(level.teamstartspawnpoints)) {
      level.teamstartspawnpoints = [];
    }

    if(!isDefined(level.teamstartspawnpoints[var2])) {
      level.teamstartspawnpoints[var2] = [];
    }
  }

  for(var5 = 0; var5 < var4.size; var5++) {
    spawnpointinit(var4[var5]);
    var4[var5].selected = 0;
    var4[var5].infront = 0;
    level.startspawnpoints[level.startspawnpoints.size] = var4[var5];

    if(isDefined(var2)) {
      level.teamstartspawnpoints[var2][level.teamstartspawnpoints[var2].size] = var4[var5];
    }
  }

  if(level.teambased) {
    foreach(var7 in var4) {
      var7.infront = 1;
      var8 = anglesToForward(var7.angles);

      foreach(var10 in var4) {
        if(var7 == var10) {
          continue;
        }

        var11 = vectorNormalize(var10.origin - var7.origin);
        var12 = vectordot(var8, var11);

        if(var12 > 0.86) {
          var7.infront = 0;
          break;
        }
      }
    }

    return;
  }
}

function addspawnpoints(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  var4 = getspawnpointarray(var1);

  if(!var4.size) {
    if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {}

    return;
  }

  registerspawnpoints(var0, var4, var3);
}

function registerspawnpoints(var0, var1, var2) {
  if(!isDefined(level.spawnpoints)) {
    level.spawnpoints = [];
  }

  if(!isDefined(level.teamspawnpoints[var0])) {
    level.teamspawnpoints[var0] = [];
  }

  if(!isDefined(level.teamfallbackspawnpoints[var0])) {
    level.teamfallbackspawnpoints[var0] = [];
  }

  foreach(var4 in var1) {
    if(ref_12cc8(var4)) {
      continue;
    }

    if(checkmodifiedspawnpoint(var4)) {
      continue;
    }

    if(!isDefined(var4.inited)) {
      spawnpointinit(var4);
      level.spawnpoints[level.spawnpoints.size] = var4;
    }

    if(istrue(var2)) {
      level.teamfallbackspawnpoints[var0][level.teamfallbackspawnpoints[var0].size] = var4;
      var4.isfallback = 1;
      continue;
    }

    level.teamspawnpoints[var0][level.teamspawnpoints[var0].size] = var4;
  }
}

function spawnpointinit() {
  var0 = self;
  var0.scriptdata = spawnStruct();
  level.spawnglobals.spawnpointscriptdata[var0.index] = var0.scriptdata;
  level.spawnmins = expandmins(level.spawnmins, var0.origin);
  level.spawnmaxs = expandmaxs(level.spawnmaxs, var0.origin);
  var0.forward = anglesToForward(var0.angles);
  var0.sighttracepoint = var0.origin + (0, 0, 50);
  var0.lastspawntime = gettime();
  var0.outside = 1;
  var0.inited = 1;
  var0.alternates = [];
  var0.lastscore = [];
  var1 = physics_createcontents(["physicscontents_solid", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var2 = physics_raycast(var0.sighttracepoint, var0.sighttracepoint + (0, 0, 1024), var1, [], 0, "physicsquery_any");

  if(var2 > 0) {
    var3 = var0.sighttracepoint + var0.forward * 100;
    var2 = physics_raycast(var3, var0.sighttracepoint + (0, 0, 1024), var1, [], 0, "physicsquery_any");

    if(var2 > 0) {
      var0.outside = 0;
    }
  }

  if(shoulduseprecomputedlos() || generatinglosdata()) {
    var0.radiuspathnodes = getradiuspathsighttestnodes(var0.origin);

    if(var0.radiuspathnodes.size <= 0) {}
  }

  var0.lanemask = 0;
  var0.lanes = [];

  foreach(var5 in level.spawnglobals.lanetriggers) {
    if(ispointinvolume(var0.origin, var5)) {
      var0.lanemask |= var5.indexflag;
      var0.lanes[var0.lanes.size] = var5.index;
    }
  }

  initspawnpointvalues(var0);
  loginitialspawnposition(var0);
}

function getspawnpointarray(var0, var1) {
  if(!isDefined(level.spawnpointarray)) {
    level.spawnpointarray = [];
  }

  if(!isDefined(level.spawnpointarray[var0])) {
    level.spawnpointarray[var0] = [];

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      var2 = getspawnarray(var0);

      foreach(var4 in var2) {
        if(ref_12cc8(var4)) {
          continue;
        }

        if(checkmodifiedspawnpoint(var4)) {
          continue;
        }

        if(isDefined(var4.script_noteworthy) && var4.script_noteworthy == level.localeid) {
          level.spawnpointarray[var0][level.spawnpointarray[var0].size] = var4;
        }
      }

      if(level.spawnpointarray[var0].size == 0) {
        level.spawnpointarray[var0] = var2;
      }
    } else {
      var2 = getspawnarray(var2);

      foreach(var4 in var2) {
        if(ref_12cc8(var4)) {
          continue;
        }

        if(checkmodifiedspawnpoint(var4)) {
          continue;
        }

        if(isDefined(var4.script_noteworthy) && issubstr(var4.script_noteworthy, "locale")) {
          continue;
        }

        level.spawnpointarray[var2][level.spawnpointarray[var2].size] = var4;
      }
    }
  }

  var8 = level.spawnpointarray[var2];

  if(istrue(var4)) {
    level.spawnpointarray[var2] = level.ref_12f8c[var2];
    return level.spawnpointarray[var2];
  }

  if(isDefined(level.ref_12f8c) && isDefined(level.ref_12f8c[var2])) {
    var8 = scripts\engine\utility::array_combine(var8, level.ref_12f8c[var2]);
  }

  return var8;
}

function getspawnpointfromcode() {
  var0 = self getspawnpointforplayer();
  getentitylessscriptablearray("mp_spawn_event", ["score", var0.score, "threatsight", var0.threatsight, "totalscore", var0.totalscore, "spawnx", var0.origin[0], "spawny", var0.origin[1], "spawnz", var0.origin[2]]);
  var0.bucket = getspawnbucketfromstring(var0.score);
  var0.isbadspawn = var0.score == "bad";
  logcodefrontlineupdate(var0);
  return var0;
}

function logcodefrontlineupdate(var0) {
  if(scripts\mp\matchrecording::matchrecording_isenabled()) {
    if(istrue(var0.frontlineenabled)) {
      var1 = scripts\engine\utility::ter_op(self.team == "allies", var0.frontlineused, 1);
      var2 = scripts\engine\utility::ter_op(self.team == "axis", var0.frontlineused, 1);
      var3 = rotatevector(var0.frontlinedir, (0, 90, 0));
      scripts\mp\spawnfactor::logfrontlinetomatchrecording(var0.frontlinepos, var3, var1, var2);
      return;
    }

    return;
  }
}

function getspawnpoint_random(var0) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var1 = undefined;
  var0 = scripts\mp\spawnscoring::checkdynamicspawns(var0);
  var0 = scripts\engine\utility::array_randomize(var0);

  foreach(var3 in var0) {
    var1 = var3;

    if(canspawn(var1.origin) && !positionwouldtelefrag(var1.origin)) {
      break;
    }
  }

  return var1;
}

function getspawnpoint_startspawn(var0, var1) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var2 = undefined;
  var0 = scripts\mp\spawnscoring::checkdynamicspawns(var0);

  foreach(var4 in var0) {
    if(!isDefined(var4.selected)) {
      continue;
    }

    if(var4.selected) {
      continue;
    }

    if(var4.infront) {
      var2 = var4;
      break;
    }

    var2 = var4;
  }

  if(!isDefined(var2)) {
    if(istrue(var1)) {
      return undefined;
    }

    var2 = getspawnpoint_random(var0);
  }

  if(isDefined(var2)) {
    var2.selected = 1;
  }

  return var2;
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

function getteamspawnpoints(var0) {
  return level.teamspawnpoints[var0];
}

function getteamfallbackspawnpoints(var0) {
  return level.teamfallbackspawnpoints[var0];
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
  var0 = 0;

  for(var1 = 0; var1 < level.participants.size; var1++) {
    if(level.participants[var1] == self) {
      var0 = 1;

      while(var1 < level.participants.size - 1) {
        level.participants[var1] = level.participants[var1 + 1];
        var1++;
      }

      level.participants[var1] = undefined;
      break;
    }
  }
}

function addtocharactersarray() {
  level.characters[level.characters.size] = self;
}

function removefromcharactersarray() {
  var0 = 0;

  for(var1 = 0; var1 < level.characters.size; var1++) {
    if(level.characters[var1] == self) {
      var0 = 1;

      while(var1 < level.characters.size - 1) {
        level.characters[var1] = level.characters[var1 + 1];
        var1++;
      }

      level.characters[var1] = undefined;
      break;
    }
  }
}

function spawnpointupdate() {
  while(!isDefined(level.spawnpoints) || level.spawnpoints.size == 0) {
    waitframe();
  }

  var0 = generatinglosdata();

  if(shoulduseprecomputedlos() || var0) {
    if(var0) {
      wait 1;
      var1 = getEntArray();

      foreach(var3 in var1) {
        if(isDefined(var3.classname) && var3.classname == "script_brushmodel" && var3.spawnflags & 1) {
          var3 connectpaths();
        }

        if(isDefined(var3.targetname) && var3.targetname == "dynamic_door") {
          var3 delete();
        }
      }

      waitframe();
    }

    var5 = [];

    if(level.spawnpoints.size == 0) {
      scripts\engine\utility::error("Spawn System Failure. No Spawnpoints found.");
    }

    for(var6 = 0; var6 < level.spawnpoints.size; var6++) {
      for(var7 = 0; var7 < level.spawnpoints[var6].radiuspathnodes.size; var7++) {
        var5 = level.spawnpoints[var6].radiuspathnodes[var7];
      }
    }

    if(var5.size > 0) {
      cachespawnpathnodesincode(var5);
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
  var0 = [];

  foreach(var2 in level.characters) {
    if(!scripts\mp\utility\player::isreallyalive(var2)) {
      continue;
    }

    if(isPlayer(var2)) {
      if(var2.sessionstate != "playing") {
        continue;
      }

      if(!var2 scripts\mp\utility\player::isplayerallowedforspawnlogic()) {
        continue;
      }
    }

    var2.spawnlogicteam = getspawnteam(var2);

    if(var2.spawnlogicteam == "spectator") {
      continue;
    }

    if(isagent(var2) && var2.agent_type == "seeker") {
      continue;
    }

    var3 = getplayertraceheight(var2);
    var4 = var2 getEye();
    var4 = (var4[0], var4[1], var2.origin[2] + var3);
    var2.spawnlogictraceheight = var3;
    var2.spawntracelocation = var4;
    var0 = var2;
  }

  return var0;
}

function addspawnviewer(var0) {
  var0 registerentityspawnviewer();
}

function removespawnviewer(var0) {
  var0 clearentityspawnviewer();
}

function addspawndangerzone(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  return influencepoint_add(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function removespawndangerzone(var0) {
  influencepoint_remove(var0);
}

function isspawndangerzonealive(var0) {
  return influencepoint_isscripthandlevalid(var0);
}

function getdefaultminedangerzoneradiussize() {
  return 350;
}

function influencepoint_add(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var3) && isDefined(var5)) {
    var3 = var5.team;
  }

  var10 = undefined;

  if(isDefined(var5) && isPlayer(var5)) {
    if(isDefined(var6)) {
      var10 = destroyspawninfluencepoint(var0, var1, var2, var3, var5, var6);
    } else {
      var10 = destroyspawninfluencepoint(var0, var1, var2, var3, var5);
    }
  } else {
    var10 = destroyspawninfluencepoint(var0, var1, var2, var3);
  }

  if(!isDefined(var10)) {
    return;
  }

  var11 = influencepoint_getnewscripthandle(var10);

  if(!istrue(var9)) {
    thread influencepoint_cleanupthink(var11, &removespawndangerzone, var7, var4, var8);
  }

  return var11;
}

function influencepoint_remove(var0) {
  var1 = influencepoint_getcodehandlefromscripthandle(var0);
  animsetgetanimfromindex(var1);
  influencepoint_invalidatescripthandlesforcodehandle(var1);
}

function influencepoint_getnewscripthandle(var0) {
  var1 = level.spawnglobals;

  if(!isDefined(var1.influencenodealloccounts[var0])) {
    var1.influencenodealloccounts[var0] = 0;
  }

  var2 = var1.influencenodealloccounts[var0];
  var3 = var2 << 16 | var0;
  return var3;
}

function influencepoint_invalidatescripthandlesforcodehandle(var0) {
  var1 = level.spawnglobals;
  var1.influencenodealloccounts[var0]++;
  var2 = var1.influencenodealloccounts[var0];

  if(var2 >= 65535) {
    var2 = 0;
    var1.influencenodealloccounts[var0] = 0;
    return;
  }
}

function influencepoint_getcodehandlefromscripthandle(var0) {
  return var0 & 65535;
}

function influencepoint_getalloccountfromscripthandle(var0) {
  return var0 >> 16;
}

function influencepoint_isscripthandlevalid(var0) {
  var1 = level.spawnglobals;
  var2 = influencepoint_getalloccountfromscripthandle(var0);
  var3 = influencepoint_getcodehandlefromscripthandle(var0);
  var4 = var1.influencenodealloccounts[var3];
  return isDefined(var4) && var2 == var4;
}

function influencepoint_cleanupthink(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  var5 = [];

  if(isDefined(var4)) {
    GscBinSkip0(0x2e, var5.size, "death");
  }

  if(isDefined(var3)) {
    if(var5.size > 0) {
      var2 scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(var5, var3);
    } else {
      wait var3;
    }
  } else if(isDefined(var2)) {
    var2 scripts\engine\utility::waittill_any_in_array_return(var5);
  }

  if(!influencepoint_isscripthandlevalid(var0)) {
    return;
  }

  [[var1]](var0);
}

function updatespawnviewers() {
  level.spawnviewers = getactiveplayerlist();

  foreach(var1 in level.spawnviewers) {
    var1.spawnviewpathnodes = undefined;
  }

  foreach(var4 in level.turrets) {
    if(!isDefined(var4)) {
      continue;
    }

    var4.spawnlogicteam = getspawnteam(var4);
    level.spawnviewers[level.spawnviewers.size] = var4;
    var4.spawnviewpathnodes = undefined;
  }

  foreach(var7 in level.ugvs) {
    if(!isDefined(var7)) {
      continue;
    }

    var7.spawnlogicteam = getspawnteam(var7);
    level.spawnviewers[level.spawnviewers.size] = var7;
    var7.spawnviewpathnodes = undefined;
  }
}

function arespawnviewersvalid() {
  return isDefined(level.spawnviewersupdatetime) && level.spawnviewersupdatetime == gettime();
}

function logspawnpointsightupdate(var0, var1) {
  if(istrue(var0.buddyspawn) || istrue(var0.isdynamicspawn)) {
    return;
  }

  if(isDefined(level.matchrecording_logevent)) {
    if(isDefined(level.matchrecording_generateid) && !isDefined(var0.logid)) {
      var0.logid = [[level.matchrecording_generateid]]();
    }

    if(isDefined(var0.logid)) {
      var2 = 3;

      if(level.teambased) {
        var3 = 1;
        var4 = 1;

        if(var1 == "allies") {
          var3 = var0.logspawndisabled["allies"] == 0;
          var5 = isDefined(var0.loggedstate) && (var0.loggedstate == 0 || var0.loggedstate == 2);
          var4 = scripts\engine\utility::ter_op(isDefined(var0.loggedstate), var5, 0);
        } else {
          var4 = var0.logspawndisabled["axis"] == 0;
          var6 = isDefined(var0.loggedstate) && (var0.loggedstate == 0 || var0.loggedstate == 1);
          var3 = scripts\engine\utility::ter_op(isDefined(var0.loggedstate), var6, 0);
        }

        if(var3 && var4) {
          var2 = 0;
        } else if(var3) {
          var2 = 1;
        } else if(var4) {
          var2 = 2;
        }
      } else {
        var2 = scripts\engine\utility::ter_op(var0.fullsights["all"] == 0, 0, 3);
      }

      if(!isDefined(var0.loggedstate) || var0.loggedstate != var2) {
        [[level.matchrecording_logevent]](var0.logid, "allies", "SPAWN_ENTITY", var0.origin[0], var0.origin[1], gettime(), var2);
        var0.loggedstate = var2;
        return;
      }

      return;
    }

    return;
  }
}

function loginitialspawnposition(var0) {
  if(istrue(var0.buddyspawn) || istrue(var0.isdynamicspawn)) {
    return;
  }

  if(isDefined(level.matchrecording_logevent)) {
    if(isDefined(level.matchrecording_generateid) && !isDefined(var0.logid)) {
      var0.logid = [[level.matchrecording_generateid]]();
    }

    if(isDefined(var0.logid) && !isDefined(var0.didinitiallog)) {
      [[level.matchrecording_logevent]](var0.logid, "allies", "SPAWN_ENTITY", var0.origin[0], var0.origin[1], gettime(), 0);
      var0.didinitiallog = 1;
      return;
    }

    return;
  }
}

function spawnpointdistanceupdate(var0) {
  foreach(var2 in level.spawnviewers) {
    var3 = distancesquared(var2.origin, var0.origin);

    if(var3 < var0.mindistsquared[var2.spawnlogicteam]) {
      var0.mindistsquared[var2.spawnlogicteam] = var3;
    }

    if(var2.spawnlogicteam == "spectator") {
      continue;
    }

    var0.distsumsquared[var2.spawnlogicteam] += var3;
    var0.distsumsquaredcapped[var2.spawnlogicteam] += min(var3, scripts\mp\spawnfactor::maxplayerspawninfluencedistsquared());
    var0.totalplayers[var2.spawnlogicteam]++;
  }

  var0.hasdistdata = 1;
}

function getspawnteam(var0) {
  var1 = "all";

  if(level.teambased) {
    var1 = var0.team;
  }

  return var1;
}

function initspawnpointvalues(var0) {
  clearspawnpointsightdata(var0);
  clearspawnpointdistancedata(var0);
}

function clearspawnpointsightdata(var0) {
  if(level.teambased) {
    foreach(var2 in level.teamnamelist) {
      clearteamspawnpointsightdata(var0, var2);
    }

    return;
  }

  clearteamspawnpointsightdata(var0, "all");
}

function setupplayerspawnsightdata(var0) {}

function clearspawnpointdistancedata(var0) {
  if(level.teambased) {
    foreach(var2 in level.teamnamelist) {
      clearteamspawnpointdistancedata(var0, var2);
    }

    return;
  }

  clearteamspawnpointdistancedata(var0, "all");
}

function clearteamspawnpointsightdata(var0, var1) {
  var0.hassightdata[var1] = 0;
  var0.fullsights[var1] = 0;
  var0.cornersights[var1] = 0;
  var0.logspawndisabled[var1] = 0;
  var0.maxsightvalue[var1] = 0;
  var0.maxjumpsightvalue[var1] = 0;
}

function clearteamspawnpointdistancedata(var0, var1) {
  var0.hasdistdata = 0;
  var0.distsumsquared[var1] = 0;
  var0.distsumsquaredcapped[var1] = 0;
  var0.mindistsquared[var1] = 9999999;
  var0.totalplayers[var1] = 0;
}

function getplayertraceheight(var0, var1) {
  if(isDefined(var1) && var1) {
    return 64;
  }

  var2 = var0 getstance();

  if(var2 == "stand") {
    return 64;
  }

  if(var2 == "crouch") {
    return 44;
  }

  return 32;
}

function additionalsighttraceentities(var0, var1) {
  foreach(var3 in var1) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = getspawnteam(var3);

    if(var0.fullsights[var4]) {
      continue;
    }

    var0.hassightdata[var4] = 1;
    var5 = var3.origin + (0, 0, 50);
    var6 = 0;

    if(!var6) {
      var6 = spawnsighttrace(var0, var0.sighttracepoint, var5);
    }

    if(!var6) {
      continue;
    }

    if(var6 > 0.95) {
      var0.fullsights[var4]++;
      continue;
    }

    var0.cornersights[var4]++;
  }
}

function finalizespawnpointchoice(var0) {
  if(!isPlayer(self)) {
    return;
  }

  var1 = gettime();
  self.lastspawnpoint = var0;
  self.lastspawntime = var1;
  var0.lastspawntime = var1;
  var0.lastspawnteam = self.team;

  if(!isDefined(var0.bucket)) {
    self finalizespawnpointchoiceforplayer(var0.index);
  } else {
    if(!isDefined(var0.ref_140ad)) {
      var0.ref_140ad = 0;
    }

    if(!isDefined(var0.threatsight)) {
      var0.threatsight = -1;
    }

    if(!isDefined(var0.damagemod)) {
      var0.damagemod = -1;
    }

    self finalizespawnpointchoiceforplayer(var0.index, var0.bucket, var0.ref_140ad, var0.threatsight, var0.damagemod);
  }

  var2 = level.spawnglobals.spawnpointscriptdata[var0.index];

  if(isDefined(var2)) {
    var2.used = 1;
  }

  level.spawnglobals.lastteamspawnpoints[self.team] = var0;
}

function expandspawnpointbounds(var0) {
  var1 = getspawnpointarray(var0);

  for(var2 = 0; var2 < var1.size; var2++) {
    level.spawnmins = expandmins(level.spawnmins, var1[var2].origin);
    level.spawnmaxs = expandmaxs(level.spawnmaxs, var1[var2].origin);
  }
}

function expandmins(var0, var1) {
  if(var0[0] > var1[0]) {
    var0 = (var1[0], var0[1], var0[2]);
  }

  if(var0[1] > var1[1]) {
    var0 = (var0[0], var1[1], var0[2]);
  }

  if(var0[2] > var1[2]) {
    var0 = (var0[0], var0[1], var1[2]);
  }

  return var0;
}

function expandmaxs(var0, var1) {
  if(var0[0] < var1[0]) {
    var0 = (var1[0], var0[1], var0[2]);
  }

  if(var0[1] < var1[1]) {
    var0 = (var0[0], var1[1], var0[2]);
  }

  if(var0[2] < var1[2]) {
    var0 = (var0[0], var0[1], var1[2]);
  }

  return var0;
}

function findboxcenter(var0, var1) {
  var2 = (0, 0, 0);
  var2 = var1 - var0;
  var2 = (var2[0] / 2, var2[1] / 2, var2[2] / 2) + var0;
  return var2;
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

function getpathsighttestnodes(var0, var1) {
  if(var1) {
    var2 = 0;
    var3 = getclosenoderadiusdist();
  } else {
    var2 = getclosenoderadiusdist();
    var3 = 250;
  }

  return getnodesinradius(var2, var3, var2, 512, "path");
}

function getradiuspathsighttestnodes(var0) {
  var1 = [];
  var2 = getclosestnodeinsight(var0);

  if(isDefined(var2)) {
    var1 = var2;
  }

  if(!isDefined(var2)) {
    var1 = getnodesinradius(var0, getclosenoderadiusdist(), 0, 256, "path");

    if(var1.size == 0) {
      var1 = getnodesinradius(var0, 250, 0, 256, "path");
    }
  }

  return var1;
}

function evaluateprecomputedlos(var0, var1) {
  checkttlosloaded();
  var2 = "all";

  if(level.teambased) {
    var2 = scripts\mp\utility\teams::getenemyteams(var1)[0];
  }

  if(!shoulduseprecomputedlos()) {
    var0.hassightdata[var2] = 1;
    return;
  }

  var3 = 0.95;
  var4 = 0;
  var5 = undefined;
  var6 = undefined;
  var3 = level.spawnglobals.lowerlimitfullsights;
  var4 = level.spawnglobals.lowerlimitcornersights;

  foreach(var8 in level.spawnviewers) {
    if(level.teambased && var8.spawnlogicteam != var2) {
      continue;
    }

    if(var0.fullsights[var8.spawnlogicteam]) {
      break;
    }

    if(!isDefined(var8.spawnviewpathnodes)) {
      var8.spawnviewpathnodes = var8 getnearnodelistforspawncheck(getfarnoderadiusdist());

      if(!isDefined(var8.spawnviewpathnodes) || var8.spawnviewpathnodes.size == 0) {
        if(isDefined(level.matchrecording_logeventmsg) && isPlayer(var8)) {
          if(!isDefined(var8.lastpathnodewarningtime) || var8.lastpathnodewarningtime != gettime()) {
            [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "WARNING: Could not use TTLOS data for player " + var8.name);
            var8.lastpathnodewarningtime = gettime();
          }
        }
      }
    }

    if(isDefined(var8.spawnviewpathnodes) && var8.spawnviewpathnodes.size > 0) {
      [var5] = _precomputedlosdatatest(var8, var0);
      var6 = var9[1];
    }

    if(!isDefined(var5)) {
      var10 = undefined;

      if(isPlayer(var8)) {
        var10 = var8 getEye();
      } else {
        var10 = var8.origin + (0, 0, 50);
      }

      var5 = directlineofsighttest(var0, var8, var10);
      var6 = var5;
    }

    if(!isDefined(var0.maxsightvalue[var8.spawnlogicteam]) || var5 > var0.maxsightvalue[var8.spawnlogicteam]) {
      var0.maxsightvalue[var8.spawnlogicteam] = var5;
    }

    if(isDefined(var6) && isPlayer(var8)) {
      if(!isDefined(var0.maxjumpsightvalue[var8.spawnlogicteam]) || var6 > var0.maxjumpsightvalue[var8.spawnlogicteam]) {
        var0.maxjumpsightvalue[var8.spawnlogicteam] = var6;
      }
    }

    if(var5 > var3) {
      var0.fullsights[var8.spawnlogicteam]++;
      var0.logspawndisabled[var8.spawnlogicteam]++;
      continue;
    }

    if(var5 > var4) {
      var0.cornersights[var8.spawnlogicteam]++;
    }
  }

  var0.hassightdata[var2] = 1;
  logspawnpointsightupdate(var0, var2);
}

function _precomputedlosdatatest(var0, var1) {
  var2 = checkttlosoverrides(var0, var1);

  if(!isDefined(var2)) {
    if(checkttlosdeverrors(var0, var1)) {
      return [1, 1];
    }

    var2 = precomputedlosdatatest(var0.spawnviewpathnodes, var1.radiuspathnodes);
  }

  return var2;
}

function checkttlosdeverrors(var0, var1) {
  return false;
}

function checkttlosoverrides(var0, var1) {
  if(!isDefined(level.spawnglobals.ttlosoverrides)) {
    return;
  }

  foreach(var3 in var0.spawnviewpathnodes) {
    var4 = var3 getnodenumber();

    if(isDefined(level.spawnglobals.ttlosoverrides[var4])) {
      foreach(var6 in var1.radiuspathnodes) {
        var7 = var6 getnodenumber();

        if(isDefined(level.spawnglobals.ttlosoverrides[var4][var7])) {
          return level.spawnglobals.ttlosoverrides[var4][var7];
        }
      }
    }
  }
}

function addttlosoverride(var0, var1, var2, var3) {
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

  if(!isDefined(level.spawnglobals.ttlosoverrides[var0])) {
    level.spawnglobals.ttlosoverrides[var0] = [];
  }

  level.spawnglobals.ttlosoverrides[var0][var1] = [var2, var3];

  if(!isDefined(level.spawnglobals.ttlosoverrides[var1])) {
    level.spawnglobals.ttlosoverrides[var1] = [];
  }

  level.spawnglobals.ttlosoverrides[var1][var0] = [var2, var3];
}

function getclosenoderadiusdist() {
  return 130;
}

function getfarnoderadiusdist() {
  return 250;
}

function directlineofsighttest(var0, var1, var2) {
  var3 = var0.sighttracepoint;
  var4 = var2;
  var5 = physics_createcontents(["physicscontents_solid", "physicscontents_ainosight"]);
  var6 = physics_raycast(var3, var4, var5, var1, 0, "physicsquery_any");
  return scripts\engine\utility::ter_op(var6, 0, 1);
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
  return getdvarint("LSQOPROPRS", 0) == 1 && !isDefined(level.disableprecomputedlos) && !generatinglosdata();
}

function generatinglosdata() {
  return getdvarint("NLRMTTPMTQ", 0) > 0;
}

function isttlosdataavailable() {
  return getislosdatafileloaded();
}

function printstartupdebugmessages() {
  level waittill("prematch_done");

  if(getdvarint("scr_playtest", 0) == 1 && isDefined(level.players)) {
    foreach(var1 in level.players) {
      if(var1 ishost()) {
        if(!shoulduseprecomputedlos()) {
          var1 iprintlnbold("TTLOS FAILED TO LOAD!");
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

function isfallbackspawn(var0) {
  return istrue(var0.isfallback);
}

function logextraspawninfothink() {
  if(getdvarint("scr_extra_spawn_logging", 0) != 1) {
    return;
  }

  level waittill("prematch_done");
  var0 = undefined;
  var1 = undefined;

  if(isDefined(level.matchrecording_generateid)) {
    var0 = [[level.matchrecording_generateid]]();
    var1 = [[level.matchrecording_generateid]]();
  }

  for(;;) {
    if(!shoulduseprecomputedlos()) {
      break;
    }

    logextraspawn("allies", var0);
    wait 0.5;
    logextraspawn("axis", var1);
    wait 0.5;
  }
}

function logextraspawn(var0, var1) {
  var2 = spawnStruct();
  var2.team = var0;
  var2.pers = [];
  var2.pers["team"] = var0;
  var2.disablespawnwarnings = 1;
  var2.isdynamicspawn = 1;
  var3 = var2[[level.getspawnpoint]]();

  if(isDefined(level.matchrecording_logevent) && isDefined(var3) && isDefined(var1)) {
    var4 = scripts\engine\utility::ter_op(var0 == "allies", "BEST_SPAWN_ALLIES", "BEST_SPAWN_AXIS");
    [[level.matchrecording_logevent]](var1, var0, var4, var3.origin[0], var3.origin[1], gettime());
    return;
  }
}

function clearlastteamspawns() {
  level.spawnglobals.lastteamspawnpoints = [];
}

function getoriginidentifierstring(var0) {
  return int(var0.origin[0]) + " " + int(var0.origin[1]) + " " + int(var0.origin[2]);
}

function respawn_delay(var0) {
  return int(var0.origin[0]) + " " + int(var0.origin[1]);
}

function checkmodifiedspawnpoint(var0) {
  if(!isDefined(level.modifiedspawnpoints)) {
    return false;
  }

  var1 = undefined;
  var2 = getoriginidentifierstring(var0);

  if(isDefined(level.modifiedspawnpoints[var2])) {
    var1 = level.modifiedspawnpoints[var2][var0.classname];
  }

  if(!isDefined(var1)) {
    var2 = respawn_delay(var0);

    if(isDefined(level.modifiedspawnpoints[var2])) {
      var1 = level.modifiedspawnpoints[var2][var0.classname];
    }

    if(!isDefined(var1)) {
      return false;
    }
  }

  if(istrue(var1["remove"])) {
    return true;
  }

  if(isDefined(var1["origin"])) {
    var0.origin = var1["origin"];
  }

  if(isDefined(var1["angles"])) {
    var0.angles = var1["angles"];
  }

  if(istrue(var1["no_alternates"])) {
    var0.noalternates = 1;
  }

  return false;
}

function ref_12cc8(var0) {
  if(isDefined(var0.script_noteworthy) && var0.script_noteworthy != "") {
    var1 = strtok(var0.script_noteworthy, " ");

    foreach(var3 in var1) {
      if(level.ref_11ad3 == 1) {
        if(var3 == "6v6") {
          return true;
        }

        continue;
      }

      if(var3 == "10v10") {
        return true;
      }
    }
  }

  return false;
}

function calculateteamclusters(var0) {
  var1 = spawnStruct();
  var1.clusterlist = [];

  foreach(var3 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var3) || var3.team != var0 || !var3 scripts\mp\utility\player::isplayerallowedforspawnlogic()) {
      continue;
    }

    var4 = createcluster(var3);
    var1.clusterlist[var1.clusterlist.size] = var4;
  }

  mergeclusterlist(var1);
  return var1;
}

function createcluster(var0) {
  var1 = spawnStruct();
  var1.center = var0.origin;
  var1.players = [var0];
  return var1;
}

function mergeclusterlist(var0) {
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;
  var4 = -1;

  for(var5 = 0; var5 < var0.clusterlist.size; var5++) {
    var6 = var0.clusterlist[var5];

    for(var7 = var5 + 1; var7 < var0.clusterlist.size; var7++) {
      var8 = var0.clusterlist[var7];
      var9 = distance2dsquared(var6.center, var8.center);

      if(var9 > 640000) {
        continue;
      }

      if(var4 < 0 || var9 < var4) {
        var4 = var9;
        var1 = var6;
        var2 = var8;
        var3 = var7;
      }
    }
  }

  if(isDefined(var1) && isDefined(var2)) {
    foreach(var11 in var2.players) {
      var1.players[var1.players.size] = var11;
    }

    var13 = (0, 0, 0);

    foreach(var11 in var1.players) {
      var13 += var11.origin;
    }

    var13 /= var1.players.size;
    var1.center = var13;
    var16 = var0.clusterlist.size - 1;
    var0.clusterlist[var3] = var0.clusterlist[var16];
    var0.clusterlist[var16] = undefined;
    mergeclusterlist(var0);
    return;
  }
}

function ignoretriggerenter(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  var0 scripts\mp\utility\player::enableplayerforspawnlogic(0, "spawnIgnoreTrigger");
}

function ignoretriggerexit(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  var0 scripts\mp\utility\player::enableplayerforspawnlogic(1, "spawnIgnoreTrigger");
}

function getspawnbucketfromstring(var0) {
  switch (var0) {
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

function enablespawnpointlist(var0) {
  foreach(var2 in var0) {
    registerspawnfactor(var2.index);
  }
}

function disablespawnpointlist(var0) {
  foreach(var2 in var0) {
    enablespawnpoints(var2.index);
  }
}

function registerspawnset(var0, var1) {
  var2 = level.spawnglobals;
  var2.spawnsets[var0] = var1;

  if(isarray(var1)) {
    var2.spawnsetlists[var0] = var1;
  } else {
    var2.spawnsetlists[var0] = getspawnpointarray(var1);
  }

  return var0;
}

function activatespawnset(var0, var1) {
  var2 = level.spawnglobals;

  if(istrue(var1)) {
    if(var2.activespawnsets.size == 1 && isDefined(var2.activespawnsets[var0])) {
      return;
    }

    deactivateallspawnsets();
  } else if(isDefined(var2.activespawnsets[var0])) {
    return;
  }

  var3 = var2.spawnsets[var0];

  if(isarray(var3)) {
    enablespawnpointlist(var3);
  } else {
    enablespawnpointbyindex(var3);
  }

  var2.activespawnsets[var0] = 1;
}

function deactivatespawnset(var0) {
  var1 = level.spawnglobals;
  var2 = [];

  foreach(var4 in var1.activespawnsets) {
    if(var6 != var0) {
      var2 = 1;
      continue;
    }

    var5 = var1.spawnsets[var0];

    if(isarray(var5)) {
      disablespawnpointlist(var5);
    } else {
      disablespawnpointbyindex(var5);
    }
  }

  var1.activespawnsets = var2;
}

function deactivateallspawnsets() {
  level.spawnglobals.activespawnsets = [];
  disablespawnpointsbyclassname();
}

function getspawnsetsize(var0) {
  return level.spawnglobals.spawnsetlists[var0].size;
}

function getrandomspawnpointfromset(var0) {
  var1 = level.spawnglobals;
  return var1.spawnsetlists[var0][randomint(var1.spawnsetlists[var0].size)];
}

function getrandomspawnpointfromactivesets() {
  var0 = getarraykeys(level.spawnglobals.activespawnsets);

  for(var1 = undefined; !isDefined(var1) && var0.size > 0; var1 = undefined) {
    var1 = scripts\engine\utility::random(var0);

    if(getspawnsetsize(var1) <= 0) {
      var0 = scripts\engine\utility::array_remove(var0, var1);
    }
  }

  return level.spawnglobals.spawnsetlists[var1][randomint(level.spawnglobals.spawnsetlists[var1].size)];
}

function init_trap_room_doors(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var5.classname = var0;
  var5.origin = var1;
  var5.angles = var2;
  var5.target = var3;
  var5.script_noteworthy = var4;
  return var5;
}

function bdiedonce(var0) {
  if(!isDefined(level.ref_12f8c)) {
    level.ref_12f8c = [];
  }

  foreach(var2 in var0) {
    var3 = var2.classname;
    var4 = var2.origin;
    var5 = var2.angles;

    if(isDefined(var2.target)) {
      var6 = var2.target;
    } else {
      var6 = "";
    }

    if(isDefined(var2.script_noteworthy)) {
      var7 = var2.script_noteworthy;
    } else {
      var7 = "";
    }

    if(!isDefined(level.ref_12f8c[var3])) {
      level.ref_12f8c[var3] = [];
    }

    var8 = spawnStruct();
    var8.classname = var3;
    var8.origin = var4;
    var8.angles = var5;
    var9 = getoriginforanimtime(var3, var4, var5, var6, var7);

    if(!isDefined(var9) || var9 < 0) {
      continue;
    }

    var8.index = var9;

    if(var6 != "") {
      var8.target = var6;
    }

    if(var7 != "") {
      var8.script_noteworthy = var7;
    }

    level.ref_12f8c[var3][level.ref_12f8c[var3].size] = var8;
  }

  thread ref_12f8d();
}

function ref_12f8d() {
  level notify("scriptedSpawnpointsOnMigration");
  level endon("scriptedSpawnpointsOnMigration");

  for(;;) {
    level waittill("host_migration_begin");

    foreach(var1 in level.ref_12f8c) {
      foreach(var3 in var1) {
        if(isDefined(var3.target)) {
          var4 = var3.target;
        } else {
          var4 = "";
        }

        if(isDefined(var3.script_noteworthy)) {
          var5 = var3.script_noteworthy;
        } else {
          var5 = "";
        }

        var6 = getoriginforanimtime(var3.classname, var3.origin, var3.angles, var4, var5);
      }
    }
  }
}