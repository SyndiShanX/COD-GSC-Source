/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\spawnlogic.gsc
***********************************************/

init() {
  level.spawnglobals = spawnStruct();

  if(scripts\mp\utility\game::isanymlgmatch())
    level.killstreakspawnshielddelayms = 0;
  else
    level.killstreakspawnshielddelayms = 4000;

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
  level.spawnglobals.lowerlimitfullsights = getdvarfloat("_encstr_AC0A19573F9318D8AF1B619BCD81984B4B03C3E1FB69DBB8F0B3AB");
  level.spawnglobals.lowerlimitcornersights = getdvarfloat("_encstr_BDF51B4B1146FF9DF07FFDD231F8E56FED8D0223D895F39A28B7F8DC27");
  level.spawnglobals.lastteamspawnpoints = [];
  level.spawnglobals.lastbadspawntime = [];
  level.spawnglobals.influencenodealloccounts = [];
  level.spawnglobals.spawnsets = [];
  level.spawnglobals.activespawnsets = [];
  level.spawnglobals.spawnsetlists = [];
  level.spawnglobals.spawnpointscriptdata = [];
  level thread spawnpointupdate();
  level thread trackgrenades();
  level thread trackmissiles();
  level thread trackhostmigrationend();
  level thread trackcarepackages();
  thread printstartupdebugmessages();
  level thread logextraspawninfothink();

  for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
    level.teamspawnpoints[level.teamnamelist[var_0]] = [];
    level.teamfallbackspawnpoints[level.teamnamelist[var_0]] = [];
  }

  scripts\mp\spawnfactor::init_spawn_factors();
  loadspawnlogicweights();
  var_1 = getEntArray("_encstr_820A1F2865B43CB1CDA5BFC32B43D133CFE4AD81497849933061F728FF1AE3D6A7", "_encstr_AC110A7F14873B5B3D073009");
  level.spawnglobals.lanetriggers = var_1;

  foreach(var_4, var_3 in level.spawnglobals.lanetriggers) {
    var_3.index = var_4;
    var_3.indexflag = 1 << var_4;
  }

  var_5 = getEntArray("_encstr_848B211C8D20B7EFC533715A3BA97BEC400985AFDB90F1F777490B7246737F6560DD3D", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_7 in var_5)
  scripts\mp\utility\trigger::makeenterexittrigger(var_7, ::ignoretriggerenter, ::ignoretriggerexit);
}

codecallbackhandler_spawnpointprecalc(var_0) {}

codecallbackhandler_spawnpointscore(var_0, var_1) {
  var_2 = level.spawnglobals.activespawncontext;
  var_3 = level.spawnglobals;
  var_4 = 0.0;
  var_0.scriptdata = level.spawnglobals.spawnpointscriptdata[var_0.index];

  foreach(var_8, var_6 in var_3.activescriptfactors) {
    var_7 = 0.0;

    if(isDefined(var_6.paramreflist)) {}

    var_7 = [[var_6.func]](var_0);
    var_4 = var_4 + var_7 * var_6.weight;
  }

  return var_4;
}

codecallbackhandler_spawnpointcritscore(var_0, var_1) {
  var_2 = scripts\mp\spawnscoring::criticalfactors_callback(var_0);
  return var_2;
}

getspawnpoint(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = createspawnquerycontext(var_0, var_1, var_5);
  setactivespawnquerycontext(var_6);

  if(level.forcebuddyspawn) {
    var_7 = scripts\mp\spawnscoring::findbuddyspawn();

    if(isDefined(var_7))
      return var_7;
  }

  if(!isDefined(var_4))
    var_4 = "_encstr_85E20626BA8C8CCB";

  if(getdvarint("_encstr_95F020032FD22157F09D8D07A8C483E9E67BCF50AA33DF61E31E0BE0CFD8B8A39DDF", 0) == 1) {
    if(var_4 == "_encstr_85E20626BA8C8CCB")
      var_4 = "_encstr_8F1904CA1729";
  }

  var_8 = getspawnbucketfromstring(var_4);

  if(isDefined(var_2))
    activatespawnset(var_2, 1);

  var_9 = getspawnpointfromcode();
  var_9._id_140AD = 0;
  var_10 = var_9._id_140AD;
  var_11 = var_9.threatsight;
  var_12 = var_9.damagemod;

  if(isDefined(var_3) && getspawnsetsize(var_3) > 0 && var_9.bucket >= 2) {
    activatespawnset(var_3, 1);
    var_13 = getspawnpointfromcode();

    if(isDefined(var_13) && (var_13.bucket < var_9.bucket || var_13.totalscore > var_9.totalscore)) {
      var_9 = var_13;
      var_9._id_140AD = 1;
      var_10 = var_9._id_140AD;
      var_11 = var_9.threatsight;
      var_12 = var_9.damagemod;
    }
  }

  if(var_9.bucket > var_8)
    return undefined;

  if(var_9.bucket >= 2) {
    if(var_8 >= 3) {
      var_7 = scripts\mp\spawnscoring::findbuddyspawn();

      if(isDefined(var_7)) {
        scripts\mp\spawnscoring::logbadspawn("_encstr_994712112A7370BC12A95D296868EEF3F3339090", var_0);
        var_7.bucket = 3;
        var_7._id_140AD = var_10;
        var_7.threatsight = var_11;
        var_7.damagemod = var_12;
        return var_7;
      }

      scripts\mp\spawnscoring::logbadspawn("_encstr_AC8329E1E86D9DEC5B3036B56C2316098261793970EEF9672F91389460D35959A6FA90287A46979B3F9730", var_0);
    }
  }

  if(!istrue(level.loadoutdefaultfiresalediscount) && !istrue(var_0.skipspawncamera) && var_9.bucket >= 2 && var_9.threatsight < 300)
    var_0._id_132FF = 1;

  return var_9;
}

createspawnquerycontext(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.player = var_0;
  var_3.team = var_1;
  var_3.time = gettime();
  var_3.factorparams = var_2;

  if(level.teambased)
    var_3.enemyteam = scripts\mp\utility\teams::getenemyteams(var_1)[0];
  else
    var_3.enemyteam = "_encstr_8BBA05185F8B99";

  return var_3;
}

setactivespawnquerycontext(var_0) {
  level.spawnglobals.activespawncontext = var_0;
}

getactivespawnquerycontext() {
  return level.spawnglobals.activespawncontext;
}

clearactivespawnquerycontext() {
  level.spawnglobals.activespawncontext = undefined;
}

trackhostmigrationend() {
  for(;;) {
    self waittill("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");
    deactivateallspawnsets();
  }
}

clearcodefactors() {
  foreach(var_2, var_1 in level.spawnglobals.factors)
  enablefrontlinecriticalfactor(var_2, 0.0);
}

registercodefactors(var_0) {
  foreach(var_3, var_2 in var_0)
  enablefrontlinecriticalfactor(var_3, var_2);

  enablefrontlinecriticalfactor("_encstr_AC29077FFB0AD8B75B", 1.0);
}

setactivespawnlogic(var_0, var_1) {
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

  if(istrue(var_2.criticalfactortypes[var_1]["_encstr_9BE50A3AC887CD83C0F32E5D"])) {
    var_7 = scripts\mp\spawnfactor::getglobalfrontlineinfo();

    if(isDefined(var_7) && isDefined(var_7.anchordir) && isDefined(var_7.primaryanchorpos))
      registerspawnteamsmode(var_7.anchordir, var_7.primaryanchorpos);
    else
      registerspawnteamsmode();
  } else {}

  if(level.teambased)
    createspawninfluencepoint(1);
  else
    createspawninfluencepoint(0);
}

loadspawnlogicweights() {
  level.spawnglobals.spawnfactorweights = [];
  level.spawnglobals.criticalfactortypes = [];
  var_0 = -1;

  for(;;) {
    var_0++;
    var_1 = tablelookupbyrow("_encstr_B19D145BE05EDC83C2DDB9DD954B76A13A9B178DDC9D", var_0, 0);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tablelookupbyrow("_encstr_B19D145BE05EDC83C2DDB9DD954B76A13A9B178DDC9D", var_0, 2);
    var_3 = tablelookupbyrow("_encstr_B19D145BE05EDC83C2DDB9DD954B76A13A9B178DDC9D", var_0, 1);

    if(var_3 == "_encstr_820E07F8E8780B3A4C") {
      if(!isDefined(level.spawnglobals.spawnfactorweights[var_1]))
        level.spawnglobals.spawnfactorweights[var_1] = [];

      var_4 = tablelookupbyrow("_encstr_B19D145BE05EDC83C2DDB9DD954B76A13A9B178DDC9D", var_0, 3);
      var_4 = float(var_4);
      level.spawnglobals.spawnfactorweights[var_1][var_2] = var_4;
      continue;
    }

    if(!isDefined(level.spawnglobals.criticalfactortypes[var_1]))
      level.spawnglobals.criticalfactortypes[var_1] = [];

    level.spawnglobals.criticalfactortypes[var_1][var_2] = 1;
  }
}

scorespawnpoint(var_0) {
  foreach(var_3, var_2 in level.spawnglobals.spawnfactorweights[level.spawnglobals.activespawnlogic])
  scripts\mp\spawnfactor::calculatefactorscore(var_0, var_3, var_2);
}

isfactorinuse(var_0) {
  return isDefined(level.spawnglobals.spawnfactorweights[level.spawnglobals.activespawnlogic][var_0]);
}

addstartspawnpoints(var_0, var_1, var_2) {
  var_3 = getspawnpointarray(var_0);
  var_4 = [];

  if(isDefined(level.modifiedspawnpoints)) {
    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      if(_id_12CC8(var_3[var_5])) {
        continue;
      }
      if(checkmodifiedspawnpoint(var_3[var_5])) {
        continue;
      }
      var_4[var_4.size] = var_3[var_5];
    }
  } else
    var_4 = var_3;

  if(!var_4.size) {
    if(!istrue(var_1)) {}

    return;
  }

  if(!isDefined(level.startspawnpoints))
    level.startspawnpoints = [];

  if(isDefined(var_2)) {
    if(!isDefined(level.teamstartspawnpoints))
      level.teamstartspawnpoints = [];

    if(!isDefined(level.teamstartspawnpoints[var_2]))
      level.teamstartspawnpoints[var_2] = [];
  }

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_4[var_5] spawnpointinit();
    var_4[var_5].selected = 0;
    var_4[var_5].infront = 0;
    level.startspawnpoints[level.startspawnpoints.size] = var_4[var_5];

    if(isDefined(var_2))
      level.teamstartspawnpoints[var_2][level.teamstartspawnpoints[var_2].size] = var_4[var_5];
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
  }
}

addspawnpoints(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = getspawnpointarray(var_1);

  if(!var_4.size) {
    if(!scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {}

    return;
  }

  registerspawnpoints(var_0, var_4, var_3);
}

registerspawnpoints(var_0, var_1, var_2) {
  if(!isDefined(level.spawnpoints))
    level.spawnpoints = [];

  if(!isDefined(level.teamspawnpoints[var_0]))
    level.teamspawnpoints[var_0] = [];

  if(!isDefined(level.teamfallbackspawnpoints[var_0]))
    level.teamfallbackspawnpoints[var_0] = [];

  foreach(var_4 in var_1) {
    if(_id_12CC8(var_4)) {
      continue;
    }
    if(checkmodifiedspawnpoint(var_4)) {
      continue;
    }
    if(!isDefined(var_4.inited)) {
      var_4 spawnpointinit();
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

spawnpointinit() {
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
  var_1 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4"]);
  var_2 = physics_raycast(var_0.sighttracepoint, var_0.sighttracepoint + (0, 0, 1024), var_1, [], 0, "_encstr_93C411AA834B8BA9A950170FC8A381F1D32870");

  if(var_2 > 0) {
    var_3 = var_0.sighttracepoint + var_0.forward * 100;
    var_2 = physics_raycast(var_3, var_0.sighttracepoint + (0, 0, 1024), var_1, [], 0, "_encstr_93C411AA834B8BA9A950170FC8A381F1D32870");

    if(var_2 > 0)
      var_0.outside = 0;
  }

  if(shoulduseprecomputedlos() || generatinglosdata()) {
    var_0.radiuspathnodes = getradiuspathsighttestnodes(var_0.origin);

    if(var_0.radiuspathnodes.size <= 0) {}
  }

  var_0.lanemask = 0;
  var_0.lanes = [];

  foreach(var_5 in level.spawnglobals.lanetriggers) {
    if(ispointinvolume(var_0.origin, var_5)) {
      var_0.lanemask = var_0.lanemask | var_5.indexflag;
      var_0.lanes[var_0.lanes.size] = var_5.index;
    }
  }

  initspawnpointvalues(var_0);
  loginitialspawnposition(var_0);
}

getspawnpointarray(var_0, var_1) {
  if(!isDefined(level.spawnpointarray))
    level.spawnpointarray = [];

  if(!isDefined(level.spawnpointarray[var_0])) {
    level.spawnpointarray[var_0] = [];

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      var_2 = getspawnarray(var_0);

      foreach(var_4 in var_2) {
        if(_id_12CC8(var_4)) {
          continue;
        }
        if(checkmodifiedspawnpoint(var_4)) {
          continue;
        }
        if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == level.localeid)
          level.spawnpointarray[var_0][level.spawnpointarray[var_0].size] = var_4;
      }

      if(level.spawnpointarray[var_0].size == 0)
        level.spawnpointarray[var_0] = var_2;
    } else {
      var_2 = getspawnarray(var_0);

      foreach(var_4 in var_2) {
        if(_id_12CC8(var_4)) {
          continue;
        }
        if(checkmodifiedspawnpoint(var_4)) {
          continue;
        }
        if(isDefined(var_4.script_noteworthy) && issubstr(var_4.script_noteworthy, "_encstr_82E007C2104628C1CF")) {
          continue;
        }
        level.spawnpointarray[var_0][level.spawnpointarray[var_0].size] = var_4;
      }
    }
  }

  var_8 = level.spawnpointarray[var_0];

  if(istrue(var_1)) {
    level.spawnpointarray[var_0] = level._id_12F8C[var_0];
    return level.spawnpointarray[var_0];
  }

  if(isDefined(level._id_12F8C) && isDefined(level._id_12F8C[var_0]))
    var_8 = scripts\engine\utility::array_combine(var_8, level._id_12F8C[var_0]);

  return var_8;
}

getspawnpointfromcode() {
  var_0 = self getspawnpointforplayer();
  getentitylessscriptablearray("_encstr_8DFA0FC290AFD2CB294496AF5513475D51", ["_encstr_82FB06EB26785BD7", var_0.score, "_encstr_85C40CDBD29BFD405B33EBFF4003", var_0.threatsight, "_encstr_A3670BAC605B57D52FD84A9380", var_0.totalscore, "_encstr_B8AC074F6BBA14C0C0", var_0.origin[0], "_encstr_ACAC07CF3BC04F6E5A", var_0.origin[1], "_encstr_91AC0726828A7758EA", var_0.origin[2]]);
  var_0.bucket = getspawnbucketfromstring(var_0.score);
  var_0.isbadspawn = var_0.score == "_encstr_8F1904CA1729";
  logcodefrontlineupdate(var_0);
  return var_0;
}

logcodefrontlineupdate(var_0) {
  if(scripts\mp\matchrecording::matchrecording_isenabled()) {
    if(istrue(var_0.frontlineenabled)) {
      var_1 = scripts\engine\utility::ter_op(self.team == "_encstr_9A8507BA4040188D08", var_0.frontlineused, 1);
      var_2 = scripts\engine\utility::ter_op(self.team == "_encstr_8E8405EA382B2A", var_0.frontlineused, 1);
      var_3 = rotatevector(var_0.frontlinedir, (0, 90, 0));
      scripts\mp\spawnfactor::logfrontlinetomatchrecording(var_0.frontlinepos, var_3, var_1, var_2);
    }
  }
}

getspawnpoint_random(var_0) {
  if(!isDefined(var_0))
    return undefined;

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

getspawnpoint_startspawn(var_0, var_1) {
  if(!isDefined(var_0))
    return undefined;

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
    if(istrue(var_1))
      return undefined;

    var_2 = getspawnpoint_random(var_0);
  }

  if(isDefined(var_2))
    var_2.selected = 1;

  return var_2;
}

trackgrenades() {
  for(;;) {
    level.grenades = getEntArray("_encstr_8C8D08671D451291C849", "_encstr_AC110A7F14873B5B3D073009");
    wait 0.05;
  }
}

trackmissiles() {
  for(;;) {
    level.missiles = getEntArray("_encstr_8D8A07F05F6987BF4B", "_encstr_AC110A7F14873B5B3D073009");
    wait 0.05;
  }
}

trackcarepackages() {
  for(;;) {
    level.carepackages = getEntArray("_encstr_BAE50DE60E739BA638C72068AF47B9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    wait 0.05;
  }
}

getteamspawnpoints(var_0) {
  return level.teamspawnpoints[var_0];
}

getteamfallbackspawnpoints(var_0) {
  return level.teamfallbackspawnpoints[var_0];
}

ispathdataavailable() {
  if(!isDefined(level.pathdataavailable))
    level.pathdataavailable = getsentientcounts() > 150;

  return level.pathdataavailable;
}

addtoparticipantsarray() {
  level.participants[level.participants.size] = self;
}

removefromparticipantsarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.participants.size; var_1++) {
    if(level.participants[var_1] == self) {
      for(var_0 = 1; var_1 < level.participants.size - 1; var_1++)
        level.participants[var_1] = level.participants[var_1 + 1];

      level.participants[var_1] = undefined;
      break;
    }
  }
}

addtocharactersarray() {
  level.characters[level.characters.size] = self;
}

removefromcharactersarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.characters.size; var_1++) {
    if(level.characters[var_1] == self) {
      for(var_0 = 1; var_1 < level.characters.size - 1; var_1++)
        level.characters[var_1] = level.characters[var_1 + 1];

      level.characters[var_1] = undefined;
      break;
    }
  }
}

spawnpointupdate() {
  while(!isDefined(level.spawnpoints) || level.spawnpoints.size == 0)
    waitframe();

  var_0 = generatinglosdata();

  if(shoulduseprecomputedlos() || var_0) {
    if(var_0) {
      wait 1.0;
      var_1 = getEntArray();

      foreach(var_3 in var_1) {
        if(isDefined(var_3.classname) && var_3.classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C" && var_3.spawnflags & 1)
          var_3 connectpaths();

        if(isDefined(var_3.targetname) && var_3.targetname == "_encstr_964E0D322F73B0B6961BBE19BDDB27")
          var_3 delete();
      }

      waitframe();
    }

    var_5 = [];

    if(level.spawnpoints.size == 0)
      scripts\engine\utility::error("_encstr_81AB2C5B3F29DF65B9697BD3781B9D3A652FF9ECD513DFBD617902DE5949D6AF980F7791E03B5F668558AB3288DD");

    for(var_6 = 0; var_6 < level.spawnpoints.size; var_6++) {
      for(var_7 = 0; var_7 < level.spawnpoints[var_6].radiuspathnodes.size; var_7++)
        var_5[var_5.size] = level.spawnpoints[var_6].radiuspathnodes[var_7];
    }

    if(var_5.size > 0)
      cachespawnpathnodesincode(var_5);
    else if(!istrue(level.nopathnodes) && !istrue(level.largemap))
      scripts\engine\utility::error("_encstr_A10943B9833F4F0D9A07D1C351E8955AC4D992D28B0EDFD57221C8DD35C00EA706F17E7A50CFC37EE8A1F6AF2138E2EAA069E203513703B022BFE0A9EF486A0F5BE02B9B28");
  }
}

getactiveplayerlist() {
  var_0 = [];

  foreach(var_2 in level.characters) {
    if(!scripts\mp\utility\player::isreallyalive(var_2)) {
      continue;
    }
    if(isPlayer(var_2)) {
      if(var_2.sessionstate != "_encstr_877508C1D8C22F2DDC3B") {
        continue;
      }
      if(!var_2 scripts\mp\utility\player::isplayerallowedforspawnlogic())
        continue;
    }

    var_2.spawnlogicteam = getspawnteam(var_2);

    if(var_2.spawnlogicteam == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    if(isagent(var_2) && var_2.agent_type == "_encstr_ABBE07B995566D569C") {
      continue;
    }
    var_3 = getplayertraceheight(var_2);
    var_4 = var_2 getEye();
    var_4 = (var_4[0], var_4[1], var_2.origin[2] + var_3);
    var_2.spawnlogictraceheight = var_3;
    var_2.spawntracelocation = var_4;
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

addspawnviewer(var_0) {
  var_0 registerentityspawnviewer();
}

removespawnviewer(var_0) {
  var_0 clearentityspawnviewer();
}

addspawndangerzone(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return influencepoint_add(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

removespawndangerzone(var_0) {
  influencepoint_remove(var_0);
}

isspawndangerzonealive(var_0) {
  return influencepoint_isscripthandlevalid(var_0);
}

getdefaultminedangerzoneradiussize() {
  return 350;
}

influencepoint_add(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_3) && isDefined(var_5))
    var_3 = var_5.team;

  var_10 = undefined;

  if(isDefined(var_5) && isPlayer(var_5)) {
    if(isDefined(var_6))
      var_10 = destroyspawninfluencepoint(var_0, var_1, var_2, var_3, var_5, var_6);
    else
      var_10 = destroyspawninfluencepoint(var_0, var_1, var_2, var_3, var_5);
  } else
    var_10 = destroyspawninfluencepoint(var_0, var_1, var_2, var_3);

  if(!isDefined(var_10)) {
    return;
  }
  var_11 = influencepoint_getnewscripthandle(var_10);

  if(!istrue(var_9))
    thread influencepoint_cleanupthink(var_11, ::removespawndangerzone, var_7, var_4, var_8);

  return var_11;
}

influencepoint_remove(var_0) {
  var_1 = influencepoint_getcodehandlefromscripthandle(var_0);
  animsetgetanimfromindex(var_1);
  influencepoint_invalidatescripthandlesforcodehandle(var_1);
}

influencepoint_getnewscripthandle(var_0) {
  var_1 = level.spawnglobals;

  if(!isDefined(var_1.influencenodealloccounts[var_0]))
    var_1.influencenodealloccounts[var_0] = 0;

  var_2 = var_1.influencenodealloccounts[var_0];
  var_3 = var_2 << 16 | var_0;
  return var_3;
}

influencepoint_invalidatescripthandlesforcodehandle(var_0) {
  var_1 = level.spawnglobals;
  var_1.influencenodealloccounts[var_0]++;
  var_2 = var_1.influencenodealloccounts[var_0];

  if(var_2 >= 65535) {
    var_2 = 0;
    var_1.influencenodealloccounts[var_0] = 0;
  }
}

influencepoint_getcodehandlefromscripthandle(var_0) {
  return var_0 & 65535;
}

influencepoint_getalloccountfromscripthandle(var_0) {
  return var_0 >> 16;
}

influencepoint_isscripthandlevalid(var_0) {
  var_1 = level.spawnglobals;
  var_2 = influencepoint_getalloccountfromscripthandle(var_0);
  var_3 = influencepoint_getcodehandlefromscripthandle(var_0);
  var_4 = var_1.influencenodealloccounts[var_3];
  return isDefined(var_4) && var_2 == var_4;
}

influencepoint_cleanupthink(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_5 = [];

  if(isDefined(var_4))
    var_5[var_5.size] = "_encstr_AD75063D571AE108";

  if(isDefined(var_3)) {
    if(var_5.size > 0)
      var_2 scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(var_5, var_3);
    else
      wait(var_3);
  } else if(isDefined(var_2))
    var_2 scripts\engine\utility::waittill_any_in_array_return(var_5);

  if(!influencepoint_isscripthandlevalid(var_0)) {
    return;
  }
  [[var_1]](var_0);
}

updatespawnviewers() {
  level.spawnviewers = getactiveplayerlist();

  foreach(var_1 in level.spawnviewers)
  var_1.spawnviewpathnodes = undefined;

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

arespawnviewersvalid() {
  return isDefined(level.spawnviewersupdatetime) && level.spawnviewersupdatetime == gettime();
}

logspawnpointsightupdate(var_0, var_1) {
  if(istrue(var_0.buddyspawn) || istrue(var_0.isdynamicspawn)) {
    return;
  }
  if(isDefined(level.matchrecording_logevent)) {
    if(isDefined(level.matchrecording_generateid) && !isDefined(var_0.logid))
      var_0.logid = [[level.matchrecording_generateid]]();

    if(isDefined(var_0.logid)) {
      var_2 = 3;

      if(level.teambased) {
        var_3 = 1;
        var_4 = 1;

        if(var_1 == "_encstr_9A8507BA4040188D08") {
          var_3 = var_0.logspawndisabled["_encstr_9A8507BA4040188D08"] == 0;
          var_5 = isDefined(var_0.loggedstate) && (var_0.loggedstate == 0 || var_0.loggedstate == 2);
          var_4 = scripts\engine\utility::ter_op(isDefined(var_0.loggedstate), var_5, 0);
        } else {
          var_4 = var_0.logspawndisabled["_encstr_8E8405EA382B2A"] == 0;
          var_6 = isDefined(var_0.loggedstate) && (var_0.loggedstate == 0 || var_0.loggedstate == 1);
          var_3 = scripts\engine\utility::ter_op(isDefined(var_0.loggedstate), var_6, 0);
        }

        if(var_3 && var_4)
          var_2 = 0;
        else if(var_3)
          var_2 = 1;
        else if(var_4)
          var_2 = 2;
      } else
        var_2 = scripts\engine\utility::ter_op(var_0.fullsights["_encstr_AF1904A7F929"] == 0, 0, 3);

      if(!isDefined(var_0.loggedstate) || var_0.loggedstate != var_2) {
        [[level.matchrecording_logevent]](var_0.logid, "_encstr_9A8507BA4040188D08", "_encstr_97C20D2ED88F670D41C8D10920AB7B", var_0.origin[0], var_0.origin[1], gettime(), var_2);
        var_0.loggedstate = var_2;
      }
    }
  }
}

loginitialspawnposition(var_0) {
  if(istrue(var_0.buddyspawn) || istrue(var_0.isdynamicspawn)) {
    return;
  }
  if(isDefined(level.matchrecording_logevent)) {
    if(isDefined(level.matchrecording_generateid) && !isDefined(var_0.logid))
      var_0.logid = [[level.matchrecording_generateid]]();

    if(isDefined(var_0.logid) && !isDefined(var_0.didinitiallog)) {
      [[level.matchrecording_logevent]](var_0.logid, "_encstr_9A8507BA4040188D08", "_encstr_97C20D2ED88F670D41C8D10920AB7B", var_0.origin[0], var_0.origin[1], gettime(), 0);
      var_0.didinitiallog = 1;
    }
  }
}

spawnpointdistanceupdate(var_0) {
  foreach(var_2 in level.spawnviewers) {
    var_3 = distancesquared(var_2.origin, var_0.origin);

    if(var_3 < var_0.mindistsquared[var_2.spawnlogicteam])
      var_0.mindistsquared[var_2.spawnlogicteam] = var_3;

    if(var_2.spawnlogicteam == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    var_0.distsumsquared[var_2.spawnlogicteam] = var_0.distsumsquared[var_2.spawnlogicteam] + var_3;
    var_0.distsumsquaredcapped[var_2.spawnlogicteam] = var_0.distsumsquaredcapped[var_2.spawnlogicteam] + min(var_3, scripts\mp\spawnfactor::maxplayerspawninfluencedistsquared());
    var_0.totalplayers[var_2.spawnlogicteam]++;
  }

  var_0.hasdistdata = 1;
}

getspawnteam(var_0) {
  var_1 = "_encstr_AF1904A7F929";

  if(level.teambased)
    var_1 = var_0.team;

  return var_1;
}

initspawnpointvalues(var_0) {
  clearspawnpointsightdata(var_0);
  clearspawnpointdistancedata(var_0);
}

clearspawnpointsightdata(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.teamnamelist)
    clearteamspawnpointsightdata(var_0, var_2);
  } else
    clearteamspawnpointsightdata(var_0, "_encstr_AF1904A7F929");
}

setupplayerspawnsightdata(var_0) {}

clearspawnpointdistancedata(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.teamnamelist)
    clearteamspawnpointdistancedata(var_0, var_2);
  } else
    clearteamspawnpointdistancedata(var_0, "_encstr_AF1904A7F929");
}

clearteamspawnpointsightdata(var_0, var_1) {
  var_0.hassightdata[var_1] = 0;
  var_0.fullsights[var_1] = 0;
  var_0.cornersights[var_1] = 0;
  var_0.logspawndisabled[var_1] = 0;
  var_0.maxsightvalue[var_1] = 0.0;
  var_0.maxjumpsightvalue[var_1] = 0.0;
}

clearteamspawnpointdistancedata(var_0, var_1) {
  var_0.hasdistdata = 0;
  var_0.distsumsquared[var_1] = 0;
  var_0.distsumsquaredcapped[var_1] = 0;
  var_0.mindistsquared[var_1] = 9999999;
  var_0.totalplayers[var_1] = 0;
}

getplayertraceheight(var_0, var_1) {
  if(isDefined(var_1) && var_1)
    return 64;

  var_2 = var_0 getstance();

  if(var_2 == "_encstr_A5AD069B231F0BAF")
    return 64;

  if(var_2 == "_encstr_B13D076BED70539F23")
    return 44;

  return 32;
}

additionalsighttraceentities(var_0, var_1) {
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
    var_6 = 0.0;

    if(!var_6)
      var_6 = spawnsighttrace(var_0, var_0.sighttracepoint, var_5);

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

finalizespawnpointchoice(var_0) {
  if(!isPlayer(self)) {
    return;
  }
  var_1 = gettime();
  self.lastspawnpoint = var_0;
  self.lastspawntime = var_1;
  var_0.lastspawntime = var_1;
  var_0.lastspawnteam = self.team;

  if(!isDefined(var_0.bucket))
    self finalizespawnpointchoiceforplayer(var_0.index);
  else {
    if(!isDefined(var_0._id_140AD))
      var_0._id_140AD = 0;

    if(!isDefined(var_0.threatsight))
      var_0.threatsight = -1.0;

    if(!isDefined(var_0.damagemod))
      var_0.damagemod = -1;

    self finalizespawnpointchoiceforplayer(var_0.index, var_0.bucket, var_0._id_140AD, var_0.threatsight, var_0.damagemod);
  }

  var_2 = level.spawnglobals.spawnpointscriptdata[var_0.index];

  if(isDefined(var_2))
    var_2.used = 1;

  level.spawnglobals.lastteamspawnpoints[self.team] = var_0;
}

expandspawnpointbounds(var_0) {
  var_1 = getspawnpointarray(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    level.spawnmins = expandmins(level.spawnmins, var_1[var_2].origin);
    level.spawnmaxs = expandmaxs(level.spawnmaxs, var_1[var_2].origin);
  }
}

expandmins(var_0, var_1) {
  if(var_0[0] > var_1[0])
    var_0 = (var_1[0], var_0[1], var_0[2]);

  if(var_0[1] > var_1[1])
    var_0 = (var_0[0], var_1[1], var_0[2]);

  if(var_0[2] > var_1[2])
    var_0 = (var_0[0], var_0[1], var_1[2]);

  return var_0;
}

expandmaxs(var_0, var_1) {
  if(var_0[0] < var_1[0])
    var_0 = (var_1[0], var_0[1], var_0[2]);

  if(var_0[1] < var_1[1])
    var_0 = (var_0[0], var_1[1], var_0[2]);

  if(var_0[2] < var_1[2])
    var_0 = (var_0[0], var_0[1], var_1[2]);

  return var_0;
}

findboxcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

setmapcenterfordev() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  expandspawnpointbounds("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  expandspawnpointbounds("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

shoulduseteamstartspawn() {
  if(getdvarint("_encstr_B84915676F9E51C6E0DB56DF17D0097B75E7F3A7FFC8DB", 0) == 1)
    return 1;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && isDefined(game["_encstr_9B8F06A38D72C380"]) && !scripts\mp\flags::gameflag("_encstr_8C0D0E8410E8B112602F133F559DCAF4"))
    return 1;

  if(istrue(level.disableteamstartspawns))
    return 0;

  return level.ingraceperiod && (!isDefined(level.numkills) || level.numkills == 0);
}

getpathsighttestnodes(var_0, var_1) {
  if(var_1) {
    var_2 = 0;
    var_3 = getclosenoderadiusdist();
  } else {
    var_2 = getclosenoderadiusdist();
    var_3 = 250;
  }

  return getnodesinradius(var_0, var_3, var_2, 512, "_encstr_8F0D0583C21D43");
}

getradiuspathsighttestnodes(var_0) {
  var_1 = [];
  var_2 = getclosestnodeinsight(var_0);

  if(isDefined(var_2))
    var_1[0] = var_2;

  if(!isDefined(var_2)) {
    var_1 = getnodesinradius(var_0, getclosenoderadiusdist(), 0, 256, "_encstr_8F0D0583C21D43");

    if(var_1.size == 0)
      var_1 = getnodesinradius(var_0, 250, 0, 256, "_encstr_8F0D0583C21D43");
  }

  return var_1;
}

evaluateprecomputedlos(var_0, var_1) {
  checkttlosloaded();
  var_2 = "_encstr_AF1904A7F929";

  if(level.teambased)
    var_2 = scripts\mp\utility\teams::getenemyteams(var_1)[0];

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
            [[level.matchrecording_logeventmsg]]("_encstr_96BD144C30DF1081E7FE2305D15E79D17F692715580F", gettime(), "_encstr_95D22EABDF2560C144A97222B158B50A11F76DDD2D696B23C97AC3FBA134AB16F9FF73D6BF1D026A39E03B3710A9425E" + var_8.name);
            var_8.lastpathnodewarningtime = gettime();
          }
        }
      }
    }

    if(isDefined(var_8.spawnviewpathnodes) && var_8.spawnviewpathnodes.size > 0) {
      var_9 = _precomputedlosdatatest(var_8, var_0);
      var_5 = var_9[0];
      var_6 = var_9[1];
    }

    if(!isDefined(var_5)) {
      var_10 = undefined;

      if(isPlayer(var_8))
        var_10 = var_8 getEye();
      else
        var_10 = var_8.origin + (0, 0, 50);

      var_5 = directlineofsighttest(var_0, var_8, var_10);
      var_6 = var_5;
    }

    if(!isDefined(var_0.maxsightvalue[var_8.spawnlogicteam]) || var_5 > var_0.maxsightvalue[var_8.spawnlogicteam])
      var_0.maxsightvalue[var_8.spawnlogicteam] = var_5;

    if(isDefined(var_6) && isPlayer(var_8)) {
      if(!isDefined(var_0.maxjumpsightvalue[var_8.spawnlogicteam]) || var_6 > var_0.maxjumpsightvalue[var_8.spawnlogicteam])
        var_0.maxjumpsightvalue[var_8.spawnlogicteam] = var_6;
    }

    if(var_5 > var_3) {
      var_0.fullsights[var_8.spawnlogicteam]++;
      var_0.logspawndisabled[var_8.spawnlogicteam]++;
      continue;
    }

    if(var_5 > var_4)
      var_0.cornersights[var_8.spawnlogicteam]++;
  }

  var_0.hassightdata[var_2] = 1;
  logspawnpointsightupdate(var_0, var_2);
}

_precomputedlosdatatest(var_0, var_1) {
  var_2 = checkttlosoverrides(var_0, var_1);

  if(!isDefined(var_2)) {
    if(checkttlosdeverrors(var_0, var_1))
      return [1.0, 1.0];

    var_2 = precomputedlosdatatest(var_0.spawnviewpathnodes, var_1.radiuspathnodes);
  }

  return var_2;
}

checkttlosdeverrors(var_0, var_1) {
  return 0;
}

checkttlosoverrides(var_0, var_1) {
  if(!isDefined(level.spawnglobals.ttlosoverrides)) {
    return;
  }
  foreach(var_3 in var_0.spawnviewpathnodes) {
    var_4 = var_3 getnodenumber();

    if(isDefined(level.spawnglobals.ttlosoverrides[var_4])) {
      foreach(var_6 in var_1.radiuspathnodes) {
        var_7 = var_6 getnodenumber();

        if(isDefined(level.spawnglobals.ttlosoverrides[var_4][var_7]))
          return level.spawnglobals.ttlosoverrides[var_4][var_7];
      }
    }
  }
}

addttlosoverride(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(isDefined(level.spawnglobals)) {
      break;
    }

    waitframe();
  }

  if(!isDefined(level.spawnglobals.ttlosoverrides))
    level.spawnglobals.ttlosoverrides = [];

  if(!isDefined(level.spawnglobals.ttlosoverrides[var_0]))
    level.spawnglobals.ttlosoverrides[var_0] = [];

  level.spawnglobals.ttlosoverrides[var_0][var_1] = [var_2, var_3];

  if(!isDefined(level.spawnglobals.ttlosoverrides[var_1]))
    level.spawnglobals.ttlosoverrides[var_1] = [];

  level.spawnglobals.ttlosoverrides[var_1][var_0] = [var_2, var_3];
}

getclosenoderadiusdist() {
  return 130;
}

getfarnoderadiusdist() {
  return 250;
}

directlineofsighttest(var_0, var_1, var_2) {
  var_3 = var_0.sighttracepoint;
  var_4 = var_2;
  var_5 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_990C1A3886E537A5B1CD1BBDB98EACB91DCDFA85D2CDDE9BA5EC1A8E"]);
  var_6 = physics_raycast(var_3, var_4, var_5, var_1, 0, "_encstr_93C411AA834B8BA9A950170FC8A381F1D32870");
  return scripts\engine\utility::ter_op(var_6, 0.0, 1.0);
}

getmaxdistancetolos() {
  return 2550;
}

checkttlosloaded() {
  if(shoulduseprecomputedlos() && !isttlosdataavailable()) {
    if(isDefined(level.matchrecording_logeventmsg))
      [[level.matchrecording_logeventmsg]]("_encstr_96BD144C30DF1081E7FE2305D15E79D17F692715580F", gettime(), "_encstr_A55A3BD9D16267B7EA28253D6C175F019ACBF0D8DAC5F1497F83B72E54C7E1CBAEF098A8E25F29400FACEF9733F70937222EE8C08BFFF33B5B84471509");

    if(!isDefined(level.hasshownvisdistdataerror))
      level.hasshownvisdistdataerror = 1;

    level.disableprecomputedlos = 1;
  }
}

shoulduseprecomputedlos() {
  return getdvarint("_encstr_8AB40BBD590937719285E93AD7", 0) == 1 && !isDefined(level.disableprecomputedlos) && !generatinglosdata();
}

generatinglosdata() {
  return getdvarint("_encstr_92DD0B4859BFF9A4B17FE1695B", 0) > 0;
}

isttlosdataavailable() {
  return getislosdatafileloaded();
}

printstartupdebugmessages() {
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(getdvarint("_encstr_A90F0DE66C39AF1CC6B0E5A395CDE8", 0) == 1 && isDefined(level.players)) {
    foreach(var_1 in level.players) {
      if(var_1 ishost()) {
        if(!shoulduseprecomputedlos())
          var_1 iprintlnbold("_encstr_AC53169957F9DF32EA7DB94991390FAA1DAC56A09C278BE6");

        break;
      }
    }
  }

  if(isDefined(level.matchrecording_logeventmsg)) {
    [[level.matchrecording_logeventmsg]]("_encstr_96BD144C30DF1081E7FE2305D15E79D17F692715580F", gettime(), "_encstr_866918D4E0C2779B04356C932D388E80B2959CCDA5B7CD0246B1");

    if(shoulduseprecomputedlos())
      [[level.matchrecording_logeventmsg]]("_encstr_96BD144C30DF1081E7FE2305D15E79D17F692715580F", gettime(), "_encstr_8C3E2909431BC3A0D36CAB1057BACB8F563BE0A09EBB695CD753078638E79345EC32C812700E91B17AC618");
    else
      [[level.matchrecording_logeventmsg]]("_encstr_96BD144C30DF1081E7FE2305D15E79D17F692715580F", gettime(), "_encstr_B1621FEDCF765DD9CC55E7918FC9100FDE5A7527DB1E95D831F56999A38489A011");

    [[level.matchrecording_logeventmsg]]("_encstr_96BD144C30DF1081E7FE2305D15E79D17F692715580F", gettime(), "_encstr_B2B11916D491CFB8FE52872F2D998510F8938BDEDFC8D768080754");

    if(isDefined(level.spawnglobals.activespawnlogic))
      [[level.matchrecording_logeventmsg]]("_encstr_96BD144C30DF1081E7FE2305D15E79D17F692715580F", gettime(), "_encstr_BAA40E732731C78D5169F28AB82F5052" + level.spawnglobals.activespawnlogic);
    else
      [[level.matchrecording_logeventmsg]]("_encstr_96BD144C30DF1081E7FE2305D15E79D17F692715580F", gettime(), "_encstr_847412A60716EEDC1013B79D4BD8E810C9B7E659");
  }
}

isfallbackspawn(var_0) {
  return istrue(var_0.isfallback);
}

logextraspawninfothink() {
  if(getdvarint("_encstr_B69D1873C790D19F339B3B32C68E8316E0B527E447906777D011", 0) != 1) {
    return;
  }
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
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

    logextraspawn("_encstr_9A8507BA4040188D08", var_0);
    wait 0.5;
    logextraspawn("_encstr_8E8405EA382B2A", var_1);
    wait 0.5;
  }
}

logextraspawn(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.team = var_0;
  var_2.pers = [];
  var_2.pers["_encstr_8AEF05472BC2D6"] = var_0;
  var_2.disablespawnwarnings = 1;
  var_2.isdynamicspawn = 1;
  var_3 = var_2[[level.getspawnpoint]]();

  if(isDefined(level.matchrecording_logevent) && isDefined(var_3) && isDefined(var_1)) {
    var_4 = scripts\engine\utility::ter_op(var_0 == "_encstr_9A8507BA4040188D08", "_encstr_AD3D1221519AA2BE6AA01475277DA03189A48A4D", "_encstr_91AC10BECFA9317EC3CB89C14B3775E1D0E2");
    [[level.matchrecording_logevent]](var_1, var_0, var_4, var_3.origin[0], var_3.origin[1], gettime());
  }
}

clearlastteamspawns() {
  level.spawnglobals.lastteamspawnpoints = [];
}

getoriginidentifierstring(var_0) {
  return int(var_0.origin[0]) + "_encstr_974C0246" + int(var_0.origin[1]) + "_encstr_974C0246" + int(var_0.origin[2]);
}

respawn_delay(var_0) {
  return int(var_0.origin[0]) + "_encstr_974C0246" + int(var_0.origin[1]);
}

checkmodifiedspawnpoint(var_0) {
  if(!isDefined(level.modifiedspawnpoints))
    return 0;

  var_1 = undefined;
  var_2 = getoriginidentifierstring(var_0);

  if(isDefined(level.modifiedspawnpoints[var_2]))
    var_1 = level.modifiedspawnpoints[var_2][var_0.classname];

  if(!isDefined(var_1)) {
    var_2 = respawn_delay(var_0);

    if(isDefined(level.modifiedspawnpoints[var_2]))
      var_1 = level.modifiedspawnpoints[var_2][var_0.classname];

    if(!isDefined(var_1))
      return 0;
  }

  if(istrue(var_1["_encstr_A353071677FAF7EB45"]))
    return 1;

  if(isDefined(var_1["_encstr_97FE07DE392D76D2CD"]))
    var_0.origin = var_1["_encstr_97FE07DE392D76D2CD"];

  if(isDefined(var_1["_encstr_A7610758E6CED8569B"]))
    var_0.angles = var_1["_encstr_A7610758E6CED8569B"];

  if(istrue(var_1["_encstr_B2E60E58977709F95B4F3630A6B323B3"]))
    var_0.noalternates = 1;

  return 0;
}

_id_12CC8(var_0) {
  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy != "_encstr_B40101") {
    var_1 = strtok(var_0.script_noteworthy, "_encstr_974C0246");

    foreach(var_3 in var_1) {
      if(level._id_11AD3 == 1) {
        if(var_3 == "_encstr_8A1804CF18C5")
          return 1;
      } else if(var_3 == "_encstr_B27706C1CF833659")
        return 1;
    }
  }

  return 0;
}

calculateteamclusters(var_0) {
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

createcluster(var_0) {
  var_1 = spawnStruct();
  var_1.center = var_0.origin;
  var_1.players = [var_0];
  return var_1;
}

mergeclusterlist(var_0) {
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
    foreach(var_11 in var_2.players)
    var_1.players[var_1.players.size] = var_11;

    var_13 = (0, 0, 0);

    foreach(var_11 in var_1.players)
    var_13 = var_13 + var_11.origin;

    var_13 = var_13 / var_1.players.size;
    var_1.center = var_13;
    var_16 = var_0.clusterlist.size - 1;
    var_0.clusterlist[var_3] = var_0.clusterlist[var_16];
    var_0.clusterlist[var_16] = undefined;
    mergeclusterlist(var_0);
  }
}

ignoretriggerenter(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 scripts\mp\utility\player::enableplayerforspawnlogic(0, "_encstr_AB8713DCE02CEEE62976B9B79C5951E4D23B3B9527");
}

ignoretriggerexit(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 scripts\mp\utility\player::enableplayerforspawnlogic(1, "_encstr_AB8713DCE02CEEE62976B9B79C5951E4D23B3B9527");
}

getspawnbucketfromstring(var_0) {
  switch (var_0) {
    case "_encstr_867205BF07A0C7":
      return 0;
    case "_encstr_860703DF6B":
      return 1;
    case "_encstr_8F1904CA1729":
      return 2;
    case "_encstr_85E20626BA8C8CCB":
      return 3;
  }

  return 2;
}

enablespawnpointlist(var_0) {
  foreach(var_2 in var_0)
  registerspawnfactor(var_2.index);
}

disablespawnpointlist(var_0) {
  foreach(var_2 in var_0)
  enablespawnpoints(var_2.index);
}

registerspawnset(var_0, var_1) {
  var_2 = level.spawnglobals;
  var_2.spawnsets[var_0] = var_1;

  if(isarray(var_1))
    var_2.spawnsetlists[var_0] = var_1;
  else
    var_2.spawnsetlists[var_0] = getspawnpointarray(var_1);

  return var_0;
}

activatespawnset(var_0, var_1) {
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

  if(isarray(var_3))
    enablespawnpointlist(var_3);
  else
    enablespawnpointbyindex(var_3);

  var_2.activespawnsets[var_0] = 1;
}

deactivatespawnset(var_0) {
  var_1 = level.spawnglobals;
  var_2 = [];

  foreach(var_6, var_4 in var_1.activespawnsets) {
    if(var_6 != var_0) {
      var_2[var_6] = 1;
      continue;
    }

    var_5 = var_1.spawnsets[var_0];

    if(isarray(var_5))
      disablespawnpointlist(var_5);
    else
      disablespawnpointbyindex(var_5);
  }

  var_1.activespawnsets = var_2;
}

deactivateallspawnsets() {
  level.spawnglobals.activespawnsets = [];
  disablespawnpointsbyclassname();
}

getspawnsetsize(var_0) {
  return level.spawnglobals.spawnsetlists[var_0].size;
}

getrandomspawnpointfromset(var_0) {
  var_1 = level.spawnglobals;
  return var_1.spawnsetlists[var_0][randomint(var_1.spawnsetlists[var_0].size)];
}

getrandomspawnpointfromactivesets() {
  var_0 = getarraykeys(level.spawnglobals.activespawnsets);
  var_1 = undefined;

  while(!isDefined(var_1) && var_0.size > 0) {
    var_1 = scripts\engine\utility::random(var_0);

    if(getspawnsetsize(var_1) <= 0) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_1);
      var_1 = undefined;
    }
  }

  return level.spawnglobals.spawnsetlists[var_1][randomint(level.spawnglobals.spawnsetlists[var_1].size)];
}

init_trap_room_doors(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.classname = var_0;
  var_5.origin = var_1;
  var_5.angles = var_2;
  var_5.target = var_3;
  var_5.script_noteworthy = var_4;
  return var_5;
}

bdiedonce(var_0) {
  if(!isDefined(level._id_12F8C))
    level._id_12F8C = [];

  foreach(var_2 in var_0) {
    var_3 = var_2.classname;
    var_4 = var_2.origin;
    var_5 = var_2.angles;

    if(isDefined(var_2.target))
      var_6 = var_2.target;
    else
      var_6 = "_encstr_B40101";

    if(isDefined(var_2.script_noteworthy))
      var_7 = var_2.script_noteworthy;
    else
      var_7 = "_encstr_B40101";

    if(!isDefined(level._id_12F8C[var_3]))
      level._id_12F8C[var_3] = [];

    var_8 = spawnStruct();
    var_8.classname = var_3;
    var_8.origin = var_4;
    var_8.angles = var_5;
    var_9 = getoriginforanimtime(var_3, var_4, var_5, var_6, var_7);

    if(!isDefined(var_9) || var_9 < 0) {
      continue;
    }
    var_8.index = var_9;

    if(var_6 != "_encstr_B40101")
      var_8.target = var_6;

    if(var_7 != "_encstr_B40101")
      var_8.script_noteworthy = var_7;

    level._id_12F8C[var_3][level._id_12F8C[var_3].size] = var_8;
  }

  level thread _id_12F8D();
}

_id_12F8D() {
  level notify("_encstr_A6371FE6B1E45A838E2B46A6832CDDDC38DE96E61D6ED3736AD2CE271647B4F6E6");
  level endon("_encstr_A6371FE6B1E45A838E2B46A6832CDDDC38DE96E61D6ED3736AD2CE271647B4F6E6");

  for(;;) {
    level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");

    foreach(var_1 in level._id_12F8C) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.target))
          var_4 = var_3.target;
        else
          var_4 = "_encstr_B40101";

        if(isDefined(var_3.script_noteworthy))
          var_5 = var_3.script_noteworthy;
        else
          var_5 = "_encstr_B40101";

        var_6 = getoriginforanimtime(var_3.classname, var_3.origin, var_3.angles, var_4, var_5);
      }
    }
  }
}