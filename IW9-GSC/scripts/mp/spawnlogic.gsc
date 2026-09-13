/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spawnlogic.gsc
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
  level.spawnglobals.lowerlimitfullsights = getdvarfloat("scr_lowerlimitfullsights");
  level.spawnglobals.lowerlimitcornersights = getdvarfloat("scr_lowerlimitcornersights");
  level.spawnglobals.lastteamspawnpoints = [];
  level.spawnglobals.lastbadspawntime = [];
  level.spawnglobals.influencenodealloccounts = [];
  level.spawnglobals.spawnsets = [];
  level.spawnglobals.activespawnsets = [];
  level.spawnglobals.spawnsetlists = [];
  level.spawnglobals.spawnpointscriptdata = [];
  level._id_DEC2781E0B09018C = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_use_safe_fallback_spawns"), 0) == 1;
  level thread spawnpointupdate();
  level thread scripts\cp_mp\utility\game_utility::_id_E8D365DE417A3E14();
  level thread trackhostmigrationend();
  level thread trackcarepackages();
  thread printstartupdebugmessages();
  level thread logextraspawninfothink();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.teamnamelist.size; _id_AC0E594AC96AA3A8++) {
    level.teamspawnpoints[level.teamnamelist[_id_AC0E594AC96AA3A8]] = [];
    level.teamfallbackspawnpoints[level.teamnamelist[_id_AC0E594AC96AA3A8]] = [];
  }

  scripts\mp\spawnfactor::init_spawn_factors();
  loadspawnlogicweights();
  lanetriggers = getEntArray("trigger_multiple_mp_spawn_lane", "classname");
  level.spawnglobals.lanetriggers = lanetriggers;

  foreach(index, _id_8E574DAE649F764D in level.spawnglobals.lanetriggers) {
    _id_8E574DAE649F764D.index = index;
    _id_8E574DAE649F764D.indexflag = 1 << index;
  }

  ignoretriggers = getEntArray("trigger_multiple_mp_spawn_ignore", "classname");

  foreach(_id_E05174EB75E5F721 in ignoretriggers)
  scripts\mp\utility\trigger::makeenterexittrigger(_id_E05174EB75E5F721, ::ignoretriggerenter, ::ignoretriggerexit);
}

codecallbackhandler_spawnpointprecalc(team) {}

codecallbackhandler_spawnpointscore(spawnpoint, team) {
  _id_4DB3CFD2EA2D7B8F = level.spawnglobals.activespawncontext;
  _id_584994FAB4A8712B = level.spawnglobals;
  _id_638D9CD5C072165C = 0.0;
  spawnpoint.scriptdata = level.spawnglobals.spawnpointscriptdata[spawnpoint.index];

  foreach(_id_C05389572BACDE83, _id_265D3F5274B6106F in _id_584994FAB4A8712B.activescriptfactors) {
    _id_4F72E56648B22650 = 0.0;

    if(isDefined(_id_265D3F5274B6106F.paramreflist)) {}

    _id_4F72E56648B22650 = [[_id_265D3F5274B6106F.func]](spawnpoint);
    _id_638D9CD5C072165C = _id_638D9CD5C072165C + _id_4F72E56648B22650 * _id_265D3F5274B6106F.weight;
  }

  return _id_638D9CD5C072165C;
}

codecallbackhandler_spawnpointcritscore(spawnpoint, team) {
  bucket = scripts\mp\spawnscoring::criticalfactors_callback(spawnpoint);
  return bucket;
}

getspawnpoint(_id_1A329A914F290661, spawnteam, _id_566FA37091337572, fallbackspawnset, _id_FF442511A7E55813, _id_629E5FE2F6B337FA) {
  _id_4DB3CFD2EA2D7B8F = createspawnquerycontext(_id_1A329A914F290661, spawnteam, _id_629E5FE2F6B337FA);
  setactivespawnquerycontext(_id_4DB3CFD2EA2D7B8F);

  if(!isDefined(_id_FF442511A7E55813))
    _id_FF442511A7E55813 = "buddy";

  if(getdvarint("dvar_32E4DC28CDFF8AD3", 0) == 1) {
    if(_id_FF442511A7E55813 == "buddy")
      _id_FF442511A7E55813 = "bad";
  }

  _id_A22BAD5FE6FBF86D = getspawnbucketfromstring(_id_FF442511A7E55813);

  if(isDefined(_id_566FA37091337572))
    activatespawnset(_id_566FA37091337572, 1);

  _id_821EB9EE5D4CB048 = getspawnpointfromcode();
  _id_821EB9EE5D4CB048.usingfallback = 0;
  usingfallback = _id_821EB9EE5D4CB048.usingfallback;
  _id_29AED5DB4BB4C839 = _id_821EB9EE5D4CB048.threatsight;
  _id_C4DC16CC4CC64978 = _id_821EB9EE5D4CB048.damagemod;

  if(getdvarint("dvar_6A75D12A6AC65FB3", 0) == 1 || istrue(level._id_E886C825DC0634C0))
    fallbackspawnset = undefined;

  if(isDefined(fallbackspawnset) && getspawnsetsize(fallbackspawnset) > 0 && _id_821EB9EE5D4CB048.bucket >= 2) {
    activatespawnset(fallbackspawnset, 1);
    _id_CDCF9F48FA2D305A = getspawnpointfromcode();

    if(isDefined(_id_CDCF9F48FA2D305A) && (_id_CDCF9F48FA2D305A.bucket < _id_821EB9EE5D4CB048.bucket || _id_CDCF9F48FA2D305A.totalscore > _id_821EB9EE5D4CB048.totalscore)) {
      _id_821EB9EE5D4CB048 = _id_CDCF9F48FA2D305A;
      _id_821EB9EE5D4CB048.usingfallback = 1;
      usingfallback = _id_821EB9EE5D4CB048.usingfallback;
      _id_29AED5DB4BB4C839 = _id_821EB9EE5D4CB048.threatsight;
      _id_C4DC16CC4CC64978 = _id_821EB9EE5D4CB048.damagemod;
    }
  }

  if(level.forcebuddyspawn) {
    _id_C242207EF2F146CC = scripts\mp\spawnscoring::findbuddyspawn();

    if(isDefined(_id_C242207EF2F146CC)) {
      _id_C242207EF2F146CC.bucket = 3;
      _id_C242207EF2F146CC.usingfallback = usingfallback;
      _id_C242207EF2F146CC.threatsight = _id_29AED5DB4BB4C839;
      _id_C242207EF2F146CC.damagemod = _id_C4DC16CC4CC64978;
      return _id_C242207EF2F146CC;
    }
  }

  if(_id_821EB9EE5D4CB048.bucket > _id_A22BAD5FE6FBF86D)
    return undefined;

  if(_id_821EB9EE5D4CB048.bucket >= 2) {
    if(istrue(level._id_DEC2781E0B09018C) && !istrue(_id_1A329A914F290661._id_5849BDD2AD415EEC)) {
      _id_1A329A914F290661._id_5849BDD2AD415EEC = 1;
      _id_C42B8FF1D20C40FA = level.spawnglobals.activespawnlogic;
      _id_81169AB9145E4C70 = level.spawnglobals._id_EC3926D151BC9B3D;
      _id_5D44BB0D0E2C6C7A = getDvar("dvar_C2E2232E83D7F64F", "AwayFromEnemies");
      _id_138964EAB0E4F2F0 = getDvar("dvar_F8B577D6D5572673", "Crit_Default");
      setactivespawnlogic(_id_5D44BB0D0E2C6C7A, _id_138964EAB0E4F2F0);
      _id_821EB9EE5D4CB048 = getspawnpoint(_id_1A329A914F290661, spawnteam, _id_566FA37091337572, fallbackspawnset, _id_FF442511A7E55813, _id_629E5FE2F6B337FA);
      setactivespawnlogic(_id_C42B8FF1D20C40FA, _id_81169AB9145E4C70);
      _id_1A329A914F290661._id_5849BDD2AD415EEC = undefined;
    }

    if(_id_A22BAD5FE6FBF86D >= 3) {
      _id_C242207EF2F146CC = scripts\mp\spawnscoring::findbuddyspawn();

      if(isDefined(_id_C242207EF2F146CC)) {
        scripts\mp\spawnscoring::logbadspawn("Using buddy spawn", _id_1A329A914F290661);
        _id_C242207EF2F146CC.bucket = 3;
        _id_C242207EF2F146CC.usingfallback = usingfallback;
        _id_C242207EF2F146CC.threatsight = _id_29AED5DB4BB4C839;
        _id_C242207EF2F146CC.damagemod = _id_C4DC16CC4CC64978;
        return _id_C242207EF2F146CC;
      }

      scripts\mp\spawnscoring::logbadspawn("CANNOT BUDDY SPAWN! Using bad code spawn", _id_1A329A914F290661);
    }
  }

  if(!istrue(level.disablespawncamera) && !istrue(_id_1A329A914F290661.skipspawncamera) && _id_821EB9EE5D4CB048.bucket >= 2 && _id_821EB9EE5D4CB048.threatsight < 300)
    _id_1A329A914F290661.shouldgetnewspawnpoint = 1;

  return _id_821EB9EE5D4CB048;
}

createspawnquerycontext(_id_1A329A914F290661, team, factorparams) {
  _id_4DB3CFD2EA2D7B8F = spawnStruct();
  _id_4DB3CFD2EA2D7B8F.player = _id_1A329A914F290661;
  _id_4DB3CFD2EA2D7B8F.team = team;
  _id_4DB3CFD2EA2D7B8F.time = gettime();
  _id_4DB3CFD2EA2D7B8F.factorparams = factorparams;

  if(level.teambased)
    _id_4DB3CFD2EA2D7B8F.enemyteam = scripts\mp\utility\teams::getenemyteams(team)[0];
  else
    _id_4DB3CFD2EA2D7B8F.enemyteam = "none";

  return _id_4DB3CFD2EA2D7B8F;
}

setactivespawnquerycontext(_id_4DB3CFD2EA2D7B8F) {
  level.spawnglobals.activespawncontext = _id_4DB3CFD2EA2D7B8F;
}

getactivespawnquerycontext() {
  return level.spawnglobals.activespawncontext;
}

clearactivespawnquerycontext() {
  level.spawnglobals.activespawncontext = undefined;
}

trackhostmigrationend() {
  for(;;) {
    self waittill("host_migration_end");
    deactivateallspawnsets();
  }
}

clearcodefactors() {
  foreach(_id_C05389572BACDE83, _id_036247CED4A30872 in level.spawnglobals.factors)
  registerspawnfactor(_id_C05389572BACDE83, 0.0);
}

registercodefactors(_id_A9E383F55738B673) {
  foreach(_id_CCBBA16287668F0A, weight in _id_A9E383F55738B673)
  registerspawnfactor(_id_CCBBA16287668F0A, weight);

  registerspawnfactor("script", 1.0);
}

setactivespawnlogic(_id_AB190EBA6C313055, _id_64FEC856BC253947, _id_7D25B12691EE7CC1) {
  if(!istrue(_id_7D25B12691EE7CC1)) {
    _id_94534B11BBBCFCB5 = getDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_spawnlogic_override"), "");

    if(isDefined(_id_94534B11BBBCFCB5) && _id_94534B11BBBCFCB5 != "")
      _id_AB190EBA6C313055 = _id_94534B11BBBCFCB5;

    _id_F7B8F7147B718401 = getDvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_spawnlogic_crit_override"), "");

    if(isDefined(_id_F7B8F7147B718401) && _id_F7B8F7147B718401 != "")
      _id_64FEC856BC253947 = _id_F7B8F7147B718401;
  }

  _id_584994FAB4A8712B = level.spawnglobals;
  _id_584994FAB4A8712B.logicvariantid = 0;
  _id_584994FAB4A8712B.activespawnlogic = _id_AB190EBA6C313055;
  _id_584994FAB4A8712B._id_EC3926D151BC9B3D = _id_64FEC856BC253947;
  _id_584994FAB4A8712B.activescriptfactors = [];

  foreach(_id_C05389572BACDE83, weight in _id_584994FAB4A8712B.spawnfactorweights[_id_AB190EBA6C313055]) {
    if(scripts\mp\spawnfactor::isfactorregistered(_id_C05389572BACDE83) && scripts\mp\spawnfactor::isfactorscriptonly(_id_C05389572BACDE83)) {
      _id_265D3F5274B6106F = spawnStruct();
      _id_265D3F5274B6106F.func = scripts\mp\spawnfactor::getfactorfunction(_id_C05389572BACDE83);
      _id_265D3F5274B6106F.paramreflist = scripts\mp\spawnfactor::getfactorparamreflist(_id_C05389572BACDE83);
      _id_265D3F5274B6106F.weight = weight;
      _id_584994FAB4A8712B.activescriptfactors[_id_C05389572BACDE83] = _id_265D3F5274B6106F;
    }
  }

  clearcodefactors();
  registercodefactors(_id_584994FAB4A8712B.spawnfactorweights[_id_AB190EBA6C313055]);

  if(istrue(_id_584994FAB4A8712B.criticalfactortypes[_id_64FEC856BC253947]["frontline"])) {
    frontlineinfo = scripts\mp\spawnfactor::getglobalfrontlineinfo();

    if(isDefined(frontlineinfo) && isDefined(frontlineinfo.anchordir) && isDefined(frontlineinfo.primaryanchorpos))
      enablefrontlinecriticalfactor(frontlineinfo.anchordir, frontlineinfo.primaryanchorpos);
    else
      enablefrontlinecriticalfactor();
  } else {}

  if(level.teambased)
    registerspawnteamsmode(1);
  else
    registerspawnteamsmode(0);
}

loadspawnlogicweights() {
  level.spawnglobals.spawnfactorweights = [];
  level.spawnglobals.criticalfactortypes = [];

  if(getdvarint("t10", 0) > 0)
    _id_10554CC50F831D91 = "mp/spawnweights_t10.csv";
  else
    _id_10554CC50F831D91 = "mp/spawnweights.csv";

  _id_CB89110314447B2F = -1;

  for(;;) {
    _id_CB89110314447B2F++;
    _id_0883B09C13233FEB = tablelookupbyrow(_id_10554CC50F831D91, _id_CB89110314447B2F, 0);

    if(!isDefined(_id_0883B09C13233FEB) || _id_0883B09C13233FEB == "") {
      break;
    }

    _id_CCBBA16287668F0A = tablelookupbyrow(_id_10554CC50F831D91, _id_CB89110314447B2F, 2);
    _id_368B494836D546EA = tablelookupbyrow(_id_10554CC50F831D91, _id_CB89110314447B2F, 1);

    if(_id_368B494836D546EA == "Normal") {
      if(!isDefined(level.spawnglobals.spawnfactorweights[_id_0883B09C13233FEB]))
        level.spawnglobals.spawnfactorweights[_id_0883B09C13233FEB] = [];

      weight = tablelookupbyrow(_id_10554CC50F831D91, _id_CB89110314447B2F, 3);
      weight = float(weight);
      level.spawnglobals.spawnfactorweights[_id_0883B09C13233FEB][_id_CCBBA16287668F0A] = weight;
      continue;
    }

    if(!isDefined(level.spawnglobals.criticalfactortypes[_id_0883B09C13233FEB]))
      level.spawnglobals.criticalfactortypes[_id_0883B09C13233FEB] = [];

    level.spawnglobals.criticalfactortypes[_id_0883B09C13233FEB][_id_CCBBA16287668F0A] = 1;
  }
}

scorespawnpoint(spawnpoint) {
  foreach(_id_CCBBA16287668F0A, weight in level.spawnglobals.spawnfactorweights[level.spawnglobals.activespawnlogic])
  scripts\mp\spawnfactor::calculatefactorscore(spawnpoint, _id_CCBBA16287668F0A, weight);
}

isfactorinuse(_id_7BE5A2E10A013091) {
  return isDefined(level.spawnglobals.spawnfactorweights[level.spawnglobals.activespawnlogic][_id_7BE5A2E10A013091]);
}

addstartspawnpoints(_id_700A871A46435669, _id_0E88E1BE231EB03B, team) {
  _id_FF1AA7A587AEA124 = getspawnpointarray(_id_700A871A46435669);
  spawnpoints = [];

  if(isDefined(level.modifiedspawnpoints)) {
    for(index = 0; index < _id_FF1AA7A587AEA124.size; index++) {
      if(_id_8CCE218650BB227C(_id_FF1AA7A587AEA124[index])) {
        continue;
      }
      if(checkmodifiedspawnpoint(_id_FF1AA7A587AEA124[index])) {
        continue;
      }
      spawnpoints[spawnpoints.size] = _id_FF1AA7A587AEA124[index];
    }
  } else
    spawnpoints = _id_FF1AA7A587AEA124;

  if(!spawnpoints.size) {
    if(!istrue(_id_0E88E1BE231EB03B)) {}

    return;
  }

  if(!isDefined(level.startspawnpoints))
    level.startspawnpoints = [];

  if(isDefined(team)) {
    if(!isDefined(level.teamstartspawnpoints))
      level.teamstartspawnpoints = [];

    if(!isDefined(level.teamstartspawnpoints[team]))
      level.teamstartspawnpoints[team] = [];
  }

  for(index = 0; index < spawnpoints.size; index++) {
    spawnpoints[index] spawnpointinit();
    spawnpoints[index].selected = 0;
    spawnpoints[index].infront = 0;
    level.startspawnpoints[level.startspawnpoints.size] = spawnpoints[index];

    if(isDefined(team))
      level.teamstartspawnpoints[team][level.teamstartspawnpoints[team].size] = spawnpoints[index];
  }

  if(level.teambased) {
    foreach(spawnpoint in spawnpoints) {
      spawnpoint.infront = 1;
      _id_68FD30DB511477F5 = anglesToForward(spawnpoint.angles);

      foreach(_id_CF29AFF039BC8ABE in spawnpoints) {
        if(spawnpoint == _id_CF29AFF039BC8ABE) {
          continue;
        }
        _id_A4237DCA130AB969 = vectorNormalize(_id_CF29AFF039BC8ABE.origin - spawnpoint.origin);
        _id_3D7C180940DF1BEF = vectordot(_id_68FD30DB511477F5, _id_A4237DCA130AB969);

        if(_id_3D7C180940DF1BEF > 0.86) {
          spawnpoint.infront = 0;
          break;
        }
      }
    }
  }
}

addspawnpoints(team, _id_700A871A46435669, _id_0D5690AC669BF0FF, isfallback, _id_DF08A16A5E6579C3) {
  if(!isDefined(_id_0D5690AC669BF0FF))
    _id_0D5690AC669BF0FF = 0;

  _id_EFA35DED043E4A0F = getspawnpointarray(_id_700A871A46435669, undefined, _id_DF08A16A5E6579C3);

  if(!_id_EFA35DED043E4A0F.size) {
    if(!scripts\cp_mp\utility\game_utility::isdonetskmap()) {}

    return;
  }

  registerspawnpoints(team, _id_EFA35DED043E4A0F, isfallback);
}

registerspawnpoints(team, _id_EFA35DED043E4A0F, isfallback) {
  if(!isDefined(level.spawnpoints))
    level.spawnpoints = [];

  if(!isDefined(level.teamspawnpoints[team]))
    level.teamspawnpoints[team] = [];

  if(!isDefined(level.teamfallbackspawnpoints[team]))
    level.teamfallbackspawnpoints[team] = [];

  foreach(spawnpoint in _id_EFA35DED043E4A0F) {
    if(_id_8CCE218650BB227C(spawnpoint)) {
      continue;
    }
    if(checkmodifiedspawnpoint(spawnpoint)) {
      continue;
    }
    if(!isDefined(spawnpoint.inited)) {
      spawnpoint spawnpointinit();
      level.spawnpoints[level.spawnpoints.size] = spawnpoint;
    }

    if(istrue(isfallback)) {
      level.teamfallbackspawnpoints[team][level.teamfallbackspawnpoints[team].size] = spawnpoint;
      spawnpoint.isfallback = 1;
      continue;
    }

    level.teamspawnpoints[team][level.teamspawnpoints[team].size] = spawnpoint;
  }
}

spawnpointinit() {
  spawnpoint = self;
  spawnpoint.scriptdata = spawnStruct();
  level.spawnglobals.spawnpointscriptdata[spawnpoint.index] = spawnpoint.scriptdata;
  level.spawnmins = expandmins(level.spawnmins, spawnpoint.origin);
  level.spawnmaxs = expandmaxs(level.spawnmaxs, spawnpoint.origin);
  spawnpoint.forward = anglesToForward(spawnpoint.angles);
  spawnpoint.sighttracepoint = spawnpoint.origin + (0, 0, 50);
  spawnpoint.lastspawntime = gettime();
  spawnpoint.outside = 1;
  spawnpoint.inited = 1;
  spawnpoint.alternates = [];
  spawnpoint.lastscore = [];
  _id_FBCABD62B8F66EB8 = physics_createcontents(["physicscontents_missileclip", "physicscontents_clipshot"]);
  hits = physics_raycast(spawnpoint.sighttracepoint, spawnpoint.sighttracepoint + (0, 0, 1024), _id_FBCABD62B8F66EB8, [], 0, "physicsquery_any");

  if(hits > 0) {
    startpoint = spawnpoint.sighttracepoint + spawnpoint.forward * 100;
    hits = physics_raycast(startpoint, spawnpoint.sighttracepoint + (0, 0, 1024), _id_FBCABD62B8F66EB8, [], 0, "physicsquery_any");

    if(hits > 0)
      spawnpoint.outside = 0;
  }

  if(shoulduseprecomputedlos() || generatinglosdata()) {
    spawnpoint.radiuspathnodes = getradiuspathsighttestnodes(spawnpoint.origin);

    if(spawnpoint.radiuspathnodes.size <= 0) {}
  }

  spawnpoint.lanemask = 0;
  spawnpoint.lanes = [];

  foreach(_id_8E574DAE649F764D in level.spawnglobals.lanetriggers) {
    if(ispointinvolume(spawnpoint.origin, _id_8E574DAE649F764D)) {
      spawnpoint.lanemask = spawnpoint.lanemask | _id_8E574DAE649F764D.indexflag;
      spawnpoint.lanes[spawnpoint.lanes.size] = _id_8E574DAE649F764D.index;
    }
  }

  initspawnpointvalues(spawnpoint);
  loginitialspawnposition(spawnpoint);
}

getspawnpointarray(classname, _id_4EC6CB5A61D6335B, _id_DF08A16A5E6579C3) {
  if(!isDefined(level.spawnpointarray))
    level.spawnpointarray = [];

  _id_7DB5085F244DC313 = isDefined(_id_DF08A16A5E6579C3);
  _id_FB1F805FFA028960 = level.spawnpointarray[classname];

  if(!isDefined(_id_FB1F805FFA028960) || _id_7DB5085F244DC313) {
    _id_FB1F805FFA028960 = [];

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      _id_FC32063C5B6BD8A8 = getspawnarray(classname);
      _id_DF08A16A5E6579C3 = scripts\engine\utility::_id_53C4C53197386572(_id_DF08A16A5E6579C3, level.localeid);

      foreach(spawnpoint in _id_FC32063C5B6BD8A8) {
        if(_id_8CCE218650BB227C(spawnpoint)) {
          continue;
        }
        if(checkmodifiedspawnpoint(spawnpoint)) {
          continue;
        }
        if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy == _id_DF08A16A5E6579C3)
          _id_FB1F805FFA028960[_id_FB1F805FFA028960.size] = spawnpoint;
      }

      if(_id_FB1F805FFA028960.size == 0)
        _id_FB1F805FFA028960 = _id_FC32063C5B6BD8A8;
    } else {
      _id_FC32063C5B6BD8A8 = getspawnarray(classname);

      foreach(spawnpoint in _id_FC32063C5B6BD8A8) {
        if(_id_8CCE218650BB227C(spawnpoint)) {
          continue;
        }
        if(checkmodifiedspawnpoint(spawnpoint)) {
          continue;
        }
        if(isDefined(spawnpoint.script_noteworthy)) {
          if(isDefined(_id_DF08A16A5E6579C3)) {
            if(spawnpoint.script_noteworthy != _id_DF08A16A5E6579C3)
              continue;
          } else if(issubstr(spawnpoint.script_noteworthy, "locale"))
            continue;
        }

        _id_FB1F805FFA028960[_id_FB1F805FFA028960.size] = spawnpoint;
      }
    }

    if(!_id_7DB5085F244DC313)
      level.spawnpointarray[classname] = _id_FB1F805FFA028960;
  }

  if(istrue(_id_4EC6CB5A61D6335B)) {
    if(_id_7DB5085F244DC313)
      return level.scriptedspawnpointarray[classname];

    level.spawnpointarray[classname] = level.scriptedspawnpointarray[classname];
    return level.spawnpointarray[classname];
  }

  return _id_FB1F805FFA028960;
}

getspawnpointfromcode() {
  spawnpoint = self getspawnpointforplayer();
  dlog_recordevent("mp_spawn_event", ["score", spawnpoint.score, "threatsight", spawnpoint.threatsight, "totalscore", spawnpoint.totalscore, "spawnx", spawnpoint.origin[0], "spawny", spawnpoint.origin[1], "spawnz", spawnpoint.origin[2]]);
  spawnpoint.bucket = getspawnbucketfromstring(spawnpoint.score);
  spawnpoint.isbadspawn = spawnpoint.score == "bad";
  logcodefrontlineupdate(spawnpoint);
  return spawnpoint;
}

logcodefrontlineupdate(spawnpoint) {
  if(scripts\mp\matchrecording::matchrecording_isenabled()) {
    if(istrue(spawnpoint.frontlineenabled)) {
      _id_86AF21BA2C8D7509 = scripts\engine\utility::ter_op(self.team == "allies", spawnpoint.frontlineused, 1);
      _id_53360EE7221C1A96 = scripts\engine\utility::ter_op(self.team == "axis", spawnpoint.frontlineused, 1);
      frontlinedir = rotatevector(spawnpoint.frontlinedir, (0, 90, 0));
      scripts\mp\spawnfactor::logfrontlinetomatchrecording(spawnpoint.frontlinepos, frontlinedir, _id_86AF21BA2C8D7509, _id_53360EE7221C1A96);
    }
  }
}

getspawnpoint_random(spawnpoints) {
  if(!isDefined(spawnpoints))
    return undefined;

  _id_3299C5EBF747A6B9 = undefined;
  spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns(spawnpoints);
  spawnpoints = scripts\engine\utility::array_randomize(spawnpoints);

  foreach(spawnpoint in spawnpoints) {
    _id_3299C5EBF747A6B9 = spawnpoint;

    if(canspawn(_id_3299C5EBF747A6B9.origin) && !positionwouldtelefrag(_id_3299C5EBF747A6B9.origin)) {
      break;
    }
  }

  return _id_3299C5EBF747A6B9;
}

getspawnpoint_startspawn(spawnpoints, _id_728D3544BA462895) {
  if(!isDefined(spawnpoints))
    return undefined;

  _id_B8D119D2C9609296 = undefined;
  spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns(spawnpoints);

  foreach(spawnpoint in spawnpoints) {
    if(!isDefined(spawnpoint.selected)) {
      continue;
    }
    if(spawnpoint.selected) {
      continue;
    }
    if(spawnpoint.infront) {
      _id_B8D119D2C9609296 = spawnpoint;
      break;
    }

    _id_B8D119D2C9609296 = spawnpoint;
  }

  if(!isDefined(_id_B8D119D2C9609296)) {
    if(istrue(_id_728D3544BA462895))
      return undefined;

    _id_B8D119D2C9609296 = getspawnpoint_random(spawnpoints);
  }

  if(isDefined(_id_B8D119D2C9609296))
    _id_B8D119D2C9609296.selected = 1;

  return _id_B8D119D2C9609296;
}

trackcarepackages() {
  for(;;) {
    level.carepackages = getEntArray("care_package", "targetname");
    wait 0.05;
  }
}

getteamspawnpoints(team) {
  return level.teamspawnpoints[team];
}

getteamfallbackspawnpoints(team) {
  return level.teamfallbackspawnpoints[team];
}

ispathdataavailable() {
  if(!isDefined(level.pathdataavailable))
    level.pathdataavailable = getnodecount() > 150;

  return level.pathdataavailable;
}

spawnpointupdate() {
  while(!isDefined(level.spawnpoints) || level.spawnpoints.size == 0)
    waitframe();

  _id_E26A5C5B0C618E49 = generatinglosdata();

  if(shoulduseprecomputedlos() || _id_E26A5C5B0C618E49) {
    if(_id_E26A5C5B0C618E49) {
      wait 1.0;
      _id_0FB40C4D99EBC953 = getEntArray();

      foreach(entity in _id_0FB40C4D99EBC953) {
        if(isDefined(entity.classname) && entity.classname == "script_brushmodel" && entity.spawnflags & 1)
          entity connectpaths();

        if(isDefined(entity.targetname) && entity.targetname == "dynamic_door")
          entity delete();
      }

      waitframe();
    }

    _id_26B37E5AE3600917 = [];

    if(level.spawnpoints.size == 0)
      scripts\engine\utility::error("Spawn System Failure. No Spawnpoints found.");

    for(index = 0; index < level.spawnpoints.size; index++) {
      for(_id_2E10A637EA6E7779 = 0; _id_2E10A637EA6E7779 < level.spawnpoints[index].radiuspathnodes.size; _id_2E10A637EA6E7779++)
        _id_26B37E5AE3600917[_id_26B37E5AE3600917.size] = level.spawnpoints[index].radiuspathnodes[_id_2E10A637EA6E7779];
    }

    cachespawnpathnodesincode(_id_26B37E5AE3600917);
  }
}

getactiveplayerlist() {
  _id_D4D7A55BC1E8F68E = [];

  foreach(_id_7DC3241E7F3C6B24 in level.characters) {
    if(!scripts\mp\utility\player::isreallyalive(_id_7DC3241E7F3C6B24)) {
      continue;
    }
    if(isPlayer(_id_7DC3241E7F3C6B24)) {
      if(_id_7DC3241E7F3C6B24.sessionstate != "playing") {
        continue;
      }
      if(!_id_7DC3241E7F3C6B24 _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("player_for_spawn_logic"))
        continue;
    }

    _id_7DC3241E7F3C6B24.spawnlogicteam = getspawnteam(_id_7DC3241E7F3C6B24);

    if(_id_7DC3241E7F3C6B24.spawnlogicteam == "spectator") {
      continue;
    }
    if(isagent(_id_7DC3241E7F3C6B24) && _id_7DC3241E7F3C6B24.agent_type == "seeker") {
      continue;
    }
    spawnlogictraceheight = getplayertraceheight(_id_7DC3241E7F3C6B24);
    spawntracelocation = _id_7DC3241E7F3C6B24 getEye();
    spawntracelocation = (spawntracelocation[0], spawntracelocation[1], _id_7DC3241E7F3C6B24.origin[2] + spawnlogictraceheight);
    _id_7DC3241E7F3C6B24.spawnlogictraceheight = spawnlogictraceheight;
    _id_7DC3241E7F3C6B24.spawntracelocation = spawntracelocation;
    _id_D4D7A55BC1E8F68E[_id_D4D7A55BC1E8F68E.size] = _id_7DC3241E7F3C6B24;
  }

  return _id_D4D7A55BC1E8F68E;
}

addspawnviewer(entity) {
  entity registerentityspawnviewer();
}

removespawnviewer(entity) {
  entity clearentityspawnviewer();
}

addspawndangerzone(pos, radius, height, _id_AC6CA28A64718193, lifetime, playerowner, _id_D4A6ACE0DEC22BAE, _id_539C2DCC0A467746, _id_41171640C23AE1C1, _id_E5AAF9C36F430309) {
  return influencepoint_add(pos, radius, height, _id_AC6CA28A64718193, lifetime, playerowner, _id_D4A6ACE0DEC22BAE, _id_539C2DCC0A467746, _id_41171640C23AE1C1, _id_E5AAF9C36F430309);
}

removespawndangerzone(_id_975009C7B696FB3F) {
  influencepoint_remove(_id_975009C7B696FB3F);
}

isspawndangerzonealive(_id_975009C7B696FB3F) {
  return influencepoint_isscripthandlevalid(_id_975009C7B696FB3F);
}

getdefaultminedangerzoneradiussize() {
  return 350;
}

influencepoint_add(pos, radius, height, _id_AC6CA28A64718193, lifetime, playerowner, _id_F0022422DC721463, _id_539C2DCC0A467746, _id_41171640C23AE1C1, _id_E5AAF9C36F430309) {
  if(!isDefined(_id_AC6CA28A64718193) && isDefined(playerowner))
    _id_AC6CA28A64718193 = playerowner.team;

  _id_4C1C66D3CC3C8ACE = undefined;

  if(isDefined(playerowner)) {
    if(isDefined(_id_F0022422DC721463))
      _id_4C1C66D3CC3C8ACE = createspawninfluencepoint(pos, radius, height, _id_AC6CA28A64718193, playerowner, _id_F0022422DC721463);
    else
      _id_4C1C66D3CC3C8ACE = createspawninfluencepoint(pos, radius, height, _id_AC6CA28A64718193, playerowner);
  } else
    _id_4C1C66D3CC3C8ACE = createspawninfluencepoint(pos, radius, height, _id_AC6CA28A64718193);

  if(!isDefined(_id_4C1C66D3CC3C8ACE)) {
    return;
  }
  _id_CD3F75CF2CD67808 = influencepoint_getnewscripthandle(_id_4C1C66D3CC3C8ACE);

  if(!istrue(_id_E5AAF9C36F430309))
    thread influencepoint_cleanupthink(_id_CD3F75CF2CD67808, ::removespawndangerzone, _id_539C2DCC0A467746, lifetime, _id_41171640C23AE1C1);

  return _id_CD3F75CF2CD67808;
}

influencepoint_remove(_id_CD3F75CF2CD67808) {
  _id_4C1C66D3CC3C8ACE = influencepoint_getcodehandlefromscripthandle(_id_CD3F75CF2CD67808);
  destroyspawninfluencepoint(_id_4C1C66D3CC3C8ACE);
  influencepoint_invalidatescripthandlesforcodehandle(_id_4C1C66D3CC3C8ACE);
}

influencepoint_getnewscripthandle(_id_4C1C66D3CC3C8ACE) {
  spawnglobals = level.spawnglobals;

  if(!isDefined(spawnglobals.influencenodealloccounts[_id_4C1C66D3CC3C8ACE]))
    spawnglobals.influencenodealloccounts[_id_4C1C66D3CC3C8ACE] = 0;

  _id_B20E482710BF4419 = spawnglobals.influencenodealloccounts[_id_4C1C66D3CC3C8ACE];
  _id_CD3F75CF2CD67808 = _id_B20E482710BF4419 << 16 | _id_4C1C66D3CC3C8ACE;
  return _id_CD3F75CF2CD67808;
}

influencepoint_invalidatescripthandlesforcodehandle(_id_4C1C66D3CC3C8ACE) {
  spawnglobals = level.spawnglobals;
  spawnglobals.influencenodealloccounts[_id_4C1C66D3CC3C8ACE]++;
  _id_B20E482710BF4419 = spawnglobals.influencenodealloccounts[_id_4C1C66D3CC3C8ACE];

  if(_id_B20E482710BF4419 >= 65535) {
    _id_B20E482710BF4419 = 0;
    spawnglobals.influencenodealloccounts[_id_4C1C66D3CC3C8ACE] = 0;
  }
}

influencepoint_getcodehandlefromscripthandle(_id_CD3F75CF2CD67808) {
  return _id_CD3F75CF2CD67808 & 65535;
}

influencepoint_getalloccountfromscripthandle(_id_CD3F75CF2CD67808) {
  return _id_CD3F75CF2CD67808 >> 16;
}

influencepoint_isscripthandlevalid(_id_CD3F75CF2CD67808) {
  spawnglobals = level.spawnglobals;
  _id_80420BE8A5B2F86B = influencepoint_getalloccountfromscripthandle(_id_CD3F75CF2CD67808);
  _id_4C1C66D3CC3C8ACE = influencepoint_getcodehandlefromscripthandle(_id_CD3F75CF2CD67808);
  _id_B20E482710BF4419 = spawnglobals.influencenodealloccounts[_id_4C1C66D3CC3C8ACE];
  return isDefined(_id_B20E482710BF4419) && _id_80420BE8A5B2F86B == _id_B20E482710BF4419;
}

influencepoint_cleanupthink(_id_975009C7B696FB3F, _id_3BA354CEA9BB25D9, owner, lifetime, removeondeath) {
  level endon("game_ended");
  _id_BA7E8AD2868EF874 = [];

  if(isDefined(removeondeath))
    _id_BA7E8AD2868EF874[_id_BA7E8AD2868EF874.size] = "death";

  if(isDefined(lifetime)) {
    if(_id_BA7E8AD2868EF874.size > 0)
      owner scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(_id_BA7E8AD2868EF874, lifetime);
    else
      wait(lifetime);
  } else if(isDefined(owner))
    owner scripts\engine\utility::waittill_any_in_array_return(_id_BA7E8AD2868EF874);

  if(!influencepoint_isscripthandlevalid(_id_975009C7B696FB3F)) {
    return;
  }
  [[_id_3BA354CEA9BB25D9]](_id_975009C7B696FB3F);
}

updatespawnviewers() {
  level.spawnviewers = getactiveplayerlist();

  foreach(_id_FF3FE241243B175B in level.spawnviewers)
  _id_FF3FE241243B175B.spawnviewpathnodes = undefined;

  foreach(turret in level.turrets) {
    if(!isDefined(turret)) {
      continue;
    }
    turret.spawnlogicteam = getspawnteam(turret);
    level.spawnviewers[level.spawnviewers.size] = turret;
    turret.spawnviewpathnodes = undefined;
  }

  foreach(_id_DC473B03215BF865 in level.ugvs) {
    if(!isDefined(_id_DC473B03215BF865)) {
      continue;
    }
    _id_DC473B03215BF865.spawnlogicteam = getspawnteam(_id_DC473B03215BF865);
    level.spawnviewers[level.spawnviewers.size] = _id_DC473B03215BF865;
    _id_DC473B03215BF865.spawnviewpathnodes = undefined;
  }
}

arespawnviewersvalid() {
  return isDefined(level.spawnviewersupdatetime) && level.spawnviewersupdatetime == gettime();
}

logspawnpointsightupdate(spawnpoint, team) {
  if(istrue(spawnpoint.buddyspawn) || istrue(spawnpoint.isdynamicspawn)) {
    return;
  }
  if(isDefined(level.matchrecording_logevent)) {
    if(isDefined(level.matchrecording_generateid) && !isDefined(spawnpoint.logid))
      spawnpoint.logid = [[level.matchrecording_generateid]]();

    if(isDefined(spawnpoint.logid)) {
      _id_9FABC939F9E112AB = 3;

      if(level.teambased) {
        _id_2784AEA6E45300DE = 1;
        _id_17111B33F4F70359 = 1;

        if(team == "allies") {
          _id_2784AEA6E45300DE = spawnpoint.logspawndisabled["allies"] == 0;
          _id_A0804401F03BE2F4 = isDefined(spawnpoint.loggedstate) && (spawnpoint.loggedstate == 0 || spawnpoint.loggedstate == 2);
          _id_17111B33F4F70359 = scripts\engine\utility::ter_op(isDefined(spawnpoint.loggedstate), _id_A0804401F03BE2F4, 0);
        } else {
          _id_17111B33F4F70359 = spawnpoint.logspawndisabled["axis"] == 0;
          _id_9C34CF8271074603 = isDefined(spawnpoint.loggedstate) && (spawnpoint.loggedstate == 0 || spawnpoint.loggedstate == 1);
          _id_2784AEA6E45300DE = scripts\engine\utility::ter_op(isDefined(spawnpoint.loggedstate), _id_9C34CF8271074603, 0);
        }

        if(_id_2784AEA6E45300DE && _id_17111B33F4F70359)
          _id_9FABC939F9E112AB = 0;
        else if(_id_2784AEA6E45300DE)
          _id_9FABC939F9E112AB = 1;
        else if(_id_17111B33F4F70359)
          _id_9FABC939F9E112AB = 2;
      } else
        _id_9FABC939F9E112AB = scripts\engine\utility::ter_op(spawnpoint.fullsights["all"] == 0, 0, 3);

      if(!isDefined(spawnpoint.loggedstate) || spawnpoint.loggedstate != _id_9FABC939F9E112AB) {
        [[level.matchrecording_logevent]](spawnpoint.logid, "allies", "SPAWN_ENTITY", spawnpoint.origin[0], spawnpoint.origin[1], gettime(), _id_9FABC939F9E112AB);
        spawnpoint.loggedstate = _id_9FABC939F9E112AB;
      }
    }
  }
}

loginitialspawnposition(spawnpoint) {
  if(istrue(spawnpoint.buddyspawn) || istrue(spawnpoint.isdynamicspawn)) {
    return;
  }
  if(isDefined(level.matchrecording_logevent)) {
    if(isDefined(level.matchrecording_generateid) && !isDefined(spawnpoint.logid))
      spawnpoint.logid = [[level.matchrecording_generateid]]();

    if(isDefined(spawnpoint.logid) && !isDefined(spawnpoint.didinitiallog)) {
      [[level.matchrecording_logevent]](spawnpoint.logid, "allies", "SPAWN_ENTITY", spawnpoint.origin[0], spawnpoint.origin[1], gettime(), 0);
      spawnpoint.didinitiallog = 1;
    }
  }
}

spawnpointdistanceupdate(spawnpoint) {
  foreach(player in level.spawnviewers) {
    _id_8336F113929858A6 = distancesquared(player.origin, spawnpoint.origin);

    if(_id_8336F113929858A6 < spawnpoint.mindistsquared[player.spawnlogicteam])
      spawnpoint.mindistsquared[player.spawnlogicteam] = _id_8336F113929858A6;

    if(player.spawnlogicteam == "spectator") {
      continue;
    }
    spawnpoint.distsumsquared[player.spawnlogicteam] = spawnpoint.distsumsquared[player.spawnlogicteam] + _id_8336F113929858A6;
    spawnpoint.distsumsquaredcapped[player.spawnlogicteam] = spawnpoint.distsumsquaredcapped[player.spawnlogicteam] + min(_id_8336F113929858A6, scripts\mp\spawnfactor::maxplayerspawninfluencedistsquared());
    spawnpoint.totalplayers[player.spawnlogicteam]++;
  }

  spawnpoint.hasdistdata = 1;
}

getspawnteam(ent) {
  team = "all";

  if(level.teambased)
    team = ent.team;

  return team;
}

initspawnpointvalues(spawnpoint) {
  clearspawnpointsightdata(spawnpoint);
  clearspawnpointdistancedata(spawnpoint);
}

clearspawnpointsightdata(spawnpoint) {
  if(level.teambased) {
    foreach(_id_FABF84450735DD93 in level.teamnamelist)
    clearteamspawnpointsightdata(spawnpoint, _id_FABF84450735DD93);
  } else
    clearteamspawnpointsightdata(spawnpoint, "all");
}

setupplayerspawnsightdata(player) {}

clearspawnpointdistancedata(spawnpoint) {
  if(level.teambased) {
    foreach(_id_FABF84450735DD93 in level.teamnamelist)
    clearteamspawnpointdistancedata(spawnpoint, _id_FABF84450735DD93);
  } else
    clearteamspawnpointdistancedata(spawnpoint, "all");
}

clearteamspawnpointsightdata(spawnpoint, team) {
  spawnpoint.hassightdata[team] = 0;
  spawnpoint.fullsights[team] = 0;
  spawnpoint.cornersights[team] = 0;
  spawnpoint.logspawndisabled[team] = 0;
  spawnpoint.maxsightvalue[team] = 0.0;
  spawnpoint.maxjumpsightvalue[team] = 0.0;
}

clearteamspawnpointdistancedata(spawnpoint, team) {
  spawnpoint.hasdistdata = 0;
  spawnpoint.distsumsquared[team] = 0;
  spawnpoint.distsumsquaredcapped[team] = 0;
  spawnpoint.mindistsquared[team] = 9999999;
  spawnpoint.totalplayers[team] = 0;
}

getplayertraceheight(player, _id_DE6E84BCD0DD9094) {
  if(isDefined(_id_DE6E84BCD0DD9094) && _id_DE6E84BCD0DD9094)
    return 64;

  stance = player getstance();

  if(stance == "stand")
    return 64;

  if(stance == "crouch")
    return 44;

  return 32;
}

additionalsighttraceentities(spawnpoint, _id_1D2BE7531AAF82AF) {
  foreach(ent in _id_1D2BE7531AAF82AF) {
    if(!isDefined(ent)) {
      continue;
    }
    team = getspawnteam(ent);

    if(spawnpoint.fullsights[team]) {
      continue;
    }
    spawnpoint.hassightdata[team] = 1;
    _id_D9B5BDD7CA5A54A3 = ent.origin + (0, 0, 50);
    _id_B800AB5AA521D39B = 0.0;

    if(!_id_B800AB5AA521D39B)
      _id_B800AB5AA521D39B = spawnsighttrace(spawnpoint, spawnpoint.sighttracepoint, _id_D9B5BDD7CA5A54A3);

    if(!_id_B800AB5AA521D39B) {
      continue;
    }
    if(_id_B800AB5AA521D39B > 0.95) {
      spawnpoint.fullsights[team]++;
      continue;
    }

    spawnpoint.cornersights[team]++;
  }
}

finalizespawnpointchoice(spawnpoint) {
  if(!isPlayer(self)) {
    return;
  }
  time = gettime();
  self.lastspawnpoint = spawnpoint;
  self.lastspawntime = time;
  spawnpoint.lastspawntime = time;
  spawnpoint.lastspawnteam = self.team;

  if(!isDefined(spawnpoint.bucket))
    self finalizespawnpointchoiceforplayer(spawnpoint.index);
  else {
    if(!isDefined(spawnpoint.usingfallback))
      spawnpoint.usingfallback = 0;

    if(!isDefined(spawnpoint.threatsight))
      spawnpoint.threatsight = -1.0;

    if(!isDefined(spawnpoint.damagemod))
      spawnpoint.damagemod = -1;

    self finalizespawnpointchoiceforplayer(spawnpoint.index, spawnpoint.bucket, spawnpoint.usingfallback, spawnpoint.threatsight, spawnpoint.damagemod);
  }

  scriptdata = level.spawnglobals.spawnpointscriptdata[spawnpoint.index];

  if(isDefined(scriptdata))
    scriptdata.used = 1;

  level.spawnglobals.lastteamspawnpoints[self.team] = spawnpoint;
}

expandspawnpointbounds(classname) {
  spawnpoints = getspawnpointarray(classname);

  for(index = 0; index < spawnpoints.size; index++) {
    level.spawnmins = expandmins(level.spawnmins, spawnpoints[index].origin);
    level.spawnmaxs = expandmaxs(level.spawnmaxs, spawnpoints[index].origin);
  }
}

expandmins(_id_3C59120EE220BF08, point) {
  if(_id_3C59120EE220BF08 == (0, 0, 0) && isDefined(point))
    _id_3C59120EE220BF08 = point;
  else {
    if(_id_3C59120EE220BF08[0] > point[0])
      _id_3C59120EE220BF08 = (point[0], _id_3C59120EE220BF08[1], _id_3C59120EE220BF08[2]);

    if(_id_3C59120EE220BF08[1] > point[1])
      _id_3C59120EE220BF08 = (_id_3C59120EE220BF08[0], point[1], _id_3C59120EE220BF08[2]);

    if(_id_3C59120EE220BF08[2] > point[2])
      _id_3C59120EE220BF08 = (_id_3C59120EE220BF08[0], _id_3C59120EE220BF08[1], point[2]);
  }

  return _id_3C59120EE220BF08;
}

expandmaxs(_id_C978C20E8E5AA292, point) {
  if(_id_C978C20E8E5AA292[0] < point[0])
    _id_C978C20E8E5AA292 = (point[0], _id_C978C20E8E5AA292[1], _id_C978C20E8E5AA292[2]);

  if(_id_C978C20E8E5AA292[1] < point[1])
    _id_C978C20E8E5AA292 = (_id_C978C20E8E5AA292[0], point[1], _id_C978C20E8E5AA292[2]);

  if(_id_C978C20E8E5AA292[2] < point[2])
    _id_C978C20E8E5AA292 = (_id_C978C20E8E5AA292[0], _id_C978C20E8E5AA292[1], point[2]);

  return _id_C978C20E8E5AA292;
}

findboxcenter(_id_3C59120EE220BF08, _id_C978C20E8E5AA292) {
  center = (0, 0, 0);
  _id_53453E9C96325450 = scripts\engine\utility::getStruct("map_center_override", "targetname");

  if(isDefined(_id_53453E9C96325450))
    center = _id_53453E9C96325450.origin;
  else {
    center = _id_C978C20E8E5AA292 - _id_3C59120EE220BF08;
    center = (center[0] / 2, center[1] / 2, center[2] / 2) + _id_3C59120EE220BF08;
  }

  return center;
}

setmapcenterfordev() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  expandspawnpointbounds("mp_tdm_spawn_allies_start");
  expandspawnpointbounds("mp_tdm_spawn_axis_start");
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

shoulduseteamstartspawn() {
  if(getdvarint("scr_forcestartspawns", 0) == 1)
    return 1;

  if(!scripts\mp\flags::gameflag("prematch_done") && isDefined(game["infil"]) && !scripts\mp\flags::gameflag("infil_started"))
    return 1;

  if(istrue(level.disableteamstartspawns))
    return 0;

  return level.ingraceperiod && (!isDefined(level.numkills) || level.numkills == 0);
}

getpathsighttestnodes(pos, _id_87F843AA78393347) {
  if(_id_87F843AA78393347) {
    _id_636C8575D7A7768B = 0;
    maxdist = getclosenoderadiusdist();
  } else {
    _id_636C8575D7A7768B = getclosenoderadiusdist();
    maxdist = 250;
  }

  return getnodesinradius(pos, maxdist, _id_636C8575D7A7768B, 512, "path");
}

getradiuspathsighttestnodes(pos) {
  _id_D76B59299A263FE5 = [];
  _id_495808766414483D = getclosestnodeinsight(pos);

  if(isDefined(_id_495808766414483D))
    _id_D76B59299A263FE5[0] = _id_495808766414483D;

  if(!isDefined(_id_495808766414483D)) {
    _id_D76B59299A263FE5 = getnodesinradius(pos, getclosenoderadiusdist(), 0, 256, "path");

    if(_id_D76B59299A263FE5.size == 0)
      _id_D76B59299A263FE5 = getnodesinradius(pos, 250, 0, 256, "path");
  }

  return _id_D76B59299A263FE5;
}

evaluateprecomputedlos(spawnpoint, team) {
  checkttlosloaded();
  enemyteam = "all";

  if(level.teambased)
    enemyteam = scripts\mp\utility\teams::getenemyteams(team)[0];

  if(!shoulduseprecomputedlos()) {
    spawnpoint.hassightdata[enemyteam] = 1;
    return;
  }

  lowerlimitfullsights = 0.95;
  lowerlimitcornersights = 0;
  _id_B800AB5AA521D39B = undefined;
  _id_8AD95653A95EA1C3 = undefined;
  lowerlimitfullsights = level.spawnglobals.lowerlimitfullsights;
  lowerlimitcornersights = level.spawnglobals.lowerlimitcornersights;

  foreach(_id_FF3FE241243B175B in level.spawnviewers) {
    if(level.teambased && _id_FF3FE241243B175B.spawnlogicteam != enemyteam) {
      continue;
    }
    if(spawnpoint.fullsights[_id_FF3FE241243B175B.spawnlogicteam]) {
      break;
    }

    if(!isDefined(_id_FF3FE241243B175B.spawnviewpathnodes)) {
      _id_FF3FE241243B175B.spawnviewpathnodes = _id_FF3FE241243B175B getnearnodelistforspawncheck(getfarnoderadiusdist());

      if(!isDefined(_id_FF3FE241243B175B.spawnviewpathnodes) || _id_FF3FE241243B175B.spawnviewpathnodes.size == 0) {
        if(isDefined(level.matchrecording_logeventmsg) && isPlayer(_id_FF3FE241243B175B)) {
          if(!isDefined(_id_FF3FE241243B175B.lastpathnodewarningtime) || _id_FF3FE241243B175B.lastpathnodewarningtime != gettime()) {
            [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "WARNING: Could not use TTLOS data for player " + _id_FF3FE241243B175B.name);
            _id_FF3FE241243B175B.lastpathnodewarningtime = gettime();
          }
        }
      }
    }

    if(isDefined(_id_FF3FE241243B175B.spawnviewpathnodes) && _id_FF3FE241243B175B.spawnviewpathnodes.size > 0) {
      _id_CB4CC05929650738 = _precomputedlosdatatest(_id_FF3FE241243B175B, spawnpoint);
      _id_B800AB5AA521D39B = _id_CB4CC05929650738[0];
      _id_8AD95653A95EA1C3 = _id_CB4CC05929650738[1];
    }

    if(!isDefined(_id_B800AB5AA521D39B)) {
      _id_29AEA598C15F22F8 = undefined;

      if(isPlayer(_id_FF3FE241243B175B))
        _id_29AEA598C15F22F8 = _id_FF3FE241243B175B getEye();
      else
        _id_29AEA598C15F22F8 = _id_FF3FE241243B175B.origin + (0, 0, 50);

      _id_B800AB5AA521D39B = directlineofsighttest(spawnpoint, _id_FF3FE241243B175B, _id_29AEA598C15F22F8);
      _id_8AD95653A95EA1C3 = _id_B800AB5AA521D39B;
    }

    if(!isDefined(spawnpoint.maxsightvalue[_id_FF3FE241243B175B.spawnlogicteam]) || _id_B800AB5AA521D39B > spawnpoint.maxsightvalue[_id_FF3FE241243B175B.spawnlogicteam])
      spawnpoint.maxsightvalue[_id_FF3FE241243B175B.spawnlogicteam] = _id_B800AB5AA521D39B;

    if(isDefined(_id_8AD95653A95EA1C3) && isPlayer(_id_FF3FE241243B175B)) {
      if(!isDefined(spawnpoint.maxjumpsightvalue[_id_FF3FE241243B175B.spawnlogicteam]) || _id_8AD95653A95EA1C3 > spawnpoint.maxjumpsightvalue[_id_FF3FE241243B175B.spawnlogicteam])
        spawnpoint.maxjumpsightvalue[_id_FF3FE241243B175B.spawnlogicteam] = _id_8AD95653A95EA1C3;
    }

    if(_id_B800AB5AA521D39B > lowerlimitfullsights) {
      spawnpoint.fullsights[_id_FF3FE241243B175B.spawnlogicteam]++;
      spawnpoint.logspawndisabled[_id_FF3FE241243B175B.spawnlogicteam]++;
      continue;
    }

    if(_id_B800AB5AA521D39B > lowerlimitcornersights)
      spawnpoint.cornersights[_id_FF3FE241243B175B.spawnlogicteam]++;
  }

  spawnpoint.hassightdata[enemyteam] = 1;
  logspawnpointsightupdate(spawnpoint, enemyteam);
}

_precomputedlosdatatest(_id_FF3FE241243B175B, spawnpoint) {
  _id_CB4CC05929650738 = checkttlosoverrides(_id_FF3FE241243B175B, spawnpoint);

  if(!isDefined(_id_CB4CC05929650738)) {
    if(checkttlosdeverrors(_id_FF3FE241243B175B, spawnpoint))
      return [1.0, 1.0];

    _id_CB4CC05929650738 = precomputedlosdatatest(_id_FF3FE241243B175B.spawnviewpathnodes, spawnpoint.radiuspathnodes);
  }

  return _id_CB4CC05929650738;
}

checkttlosdeverrors(_id_FF3FE241243B175B, spawnpoint) {
  return 0;
}

checkttlosoverrides(_id_FF3FE241243B175B, spawnpoint) {
  if(!isDefined(level.spawnglobals.ttlosoverrides)) {
    return;
  }
  foreach(_id_865D8E40722512EB in _id_FF3FE241243B175B.spawnviewpathnodes) {
    _id_024ED8518F6FC6E6 = _id_865D8E40722512EB getnodenumber();

    if(isDefined(level.spawnglobals.ttlosoverrides[_id_024ED8518F6FC6E6])) {
      foreach(_id_C229D93C0BB4F8E8 in spawnpoint.radiuspathnodes) {
        _id_7643B53B09BBF1D5 = _id_C229D93C0BB4F8E8 getnodenumber();

        if(isDefined(level.spawnglobals.ttlosoverrides[_id_024ED8518F6FC6E6][_id_7643B53B09BBF1D5]))
          return level.spawnglobals.ttlosoverrides[_id_024ED8518F6FC6E6][_id_7643B53B09BBF1D5];
      }
    }
  }
}

addttlosoverride(_id_61EE54CD86F22F08, _id_61EE57CD86F235A1, _id_48C0BD41CC10DFD8, _id_84C277514873A859) {
  level endon("game_ended");

  for(;;) {
    if(isDefined(level.spawnglobals)) {
      break;
    }

    waitframe();
  }

  if(!isDefined(level.spawnglobals.ttlosoverrides))
    level.spawnglobals.ttlosoverrides = [];

  if(!isDefined(level.spawnglobals.ttlosoverrides[_id_61EE54CD86F22F08]))
    level.spawnglobals.ttlosoverrides[_id_61EE54CD86F22F08] = [];

  level.spawnglobals.ttlosoverrides[_id_61EE54CD86F22F08][_id_61EE57CD86F235A1] = [_id_48C0BD41CC10DFD8, _id_84C277514873A859];

  if(!isDefined(level.spawnglobals.ttlosoverrides[_id_61EE57CD86F235A1]))
    level.spawnglobals.ttlosoverrides[_id_61EE57CD86F235A1] = [];

  level.spawnglobals.ttlosoverrides[_id_61EE57CD86F235A1][_id_61EE54CD86F22F08] = [_id_48C0BD41CC10DFD8, _id_84C277514873A859];
}

getclosenoderadiusdist() {
  return 130;
}

getfarnoderadiusdist() {
  return 250;
}

directlineofsighttest(spawnpoint, _id_FF3FE241243B175B, _id_29AEA598C15F22F8) {
  _id_E880AF5898EC6FD1 = spawnpoint.sighttracepoint;
  _id_4E18BF6F5EEEE2F0 = _id_29AEA598C15F22F8;
  contents = physics_createcontents(["physicscontents_ainosight"]);
  _id_AA517194E54F048B = physics_raycast(_id_E880AF5898EC6FD1, _id_4E18BF6F5EEEE2F0, contents, _id_FF3FE241243B175B, 0, "physicsquery_any");
  return scripts\engine\utility::ter_op(_id_AA517194E54F048B, 0.0, 1.0);
}

getmaxdistancetolos() {
  return 2550;
}

checkttlosloaded() {
  if(shoulduseprecomputedlos() && !isttlosdataavailable()) {
    if(isDefined(level.matchrecording_logeventmsg))
      [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "ERROR: TTLOS System disabled! Could not access visDistData");

    if(!isDefined(level.hasshownvisdistdataerror))
      level.hasshownvisdistdataerror = 1;

    level.disableprecomputedlos = 1;
  }
}

shoulduseprecomputedlos() {
  return getdvarint("sv_usePrecomputedLOSData", 0) == 1 && !isDefined(level.disableprecomputedlos) && !generatinglosdata();
}

generatinglosdata() {
  return getdvarint("sv_generatelosdata", 0) > 0;
}

isttlosdataavailable() {
  return getislosdatafileloaded();
}

printstartupdebugmessages() {
  level waittill("prematch_done");

  if(getdvarint("scr_playtest", 0) == 1 && isDefined(level.players)) {
    foreach(player in level.players) {
      if(player ishost()) {
        if(!shoulduseprecomputedlos())
          player iprintlnbold("TTLOS FAILED TO LOAD!");

        break;
      }
    }
  }

  if(isDefined(level.matchrecording_logeventmsg)) {
    [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "Spawn Script Version #6");

    if(shoulduseprecomputedlos())
      [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "Attempting to use TTLOS Spawning Data...");
    else
      [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "No TTLOS Data! Not using TTLOS");

    [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "CODE spawn logic enabled");

    if(isDefined(level.spawnglobals.activespawnlogic))
      [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "Spawn Logic: " + level.spawnglobals.activespawnlogic);
    else
      [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "Spawn Logic: None");
  }
}

isfallbackspawn(spawnpoint) {
  return istrue(spawnpoint.isfallback);
}

logextraspawninfothink() {
  if(getdvarint("scr_extra_spawn_logging", 0) != 1) {
    return;
  }
  level waittill("prematch_done");
  _id_527D4E1D1288232E = undefined;
  _id_9C8BBF6433E08EDF = undefined;

  if(isDefined(level.matchrecording_generateid)) {
    _id_527D4E1D1288232E = [[level.matchrecording_generateid]]();
    _id_9C8BBF6433E08EDF = [[level.matchrecording_generateid]]();
  }

  for(;;) {
    if(!shoulduseprecomputedlos()) {
      break;
    }

    logextraspawn("allies", _id_527D4E1D1288232E);
    wait 0.5;
    logextraspawn("axis", _id_9C8BBF6433E08EDF);
    wait 0.5;
  }
}

logextraspawn(team, logid) {
  _id_A02B612B94F6F669 = spawnStruct();
  _id_A02B612B94F6F669.team = team;
  _id_A02B612B94F6F669.pers = [];
  _id_A02B612B94F6F669.pers["team"] = team;
  _id_A02B612B94F6F669.disablespawnwarnings = 1;
  _id_A02B612B94F6F669.isdynamicspawn = 1;
  _id_B8D119D2C9609296 = _id_A02B612B94F6F669[[level.getspawnpoint]]();

  if(isDefined(level.matchrecording_logevent) && isDefined(_id_B8D119D2C9609296) && isDefined(logid)) {
    eventname = scripts\engine\utility::ter_op(team == "allies", "BEST_SPAWN_ALLIES", "BEST_SPAWN_AXIS");
    [[level.matchrecording_logevent]](logid, team, eventname, _id_B8D119D2C9609296.origin[0], _id_B8D119D2C9609296.origin[1], gettime());
  }
}

clearlastteamspawns() {
  level.spawnglobals.lastteamspawnpoints = [];
}

getoriginidentifierstring(spawnpoint) {
  return int(spawnpoint.origin[0]) + " " + int(spawnpoint.origin[1]) + " " + int(spawnpoint.origin[2]);
}

getoriginidentifierstringnoz(spawnpoint) {
  return int(spawnpoint.origin[0]) + " " + int(spawnpoint.origin[1]);
}

checkmodifiedspawnpoint(spawnpoint) {
  if(!isDefined(level.modifiedspawnpoints))
    return 0;

  _id_6D071BF9627C7F96 = undefined;
  _id_F2D96DD81CF63446 = getoriginidentifierstring(spawnpoint);

  if(isDefined(level.modifiedspawnpoints[_id_F2D96DD81CF63446]))
    _id_6D071BF9627C7F96 = level.modifiedspawnpoints[_id_F2D96DD81CF63446][spawnpoint.classname];

  if(!isDefined(_id_6D071BF9627C7F96)) {
    _id_F2D96DD81CF63446 = getoriginidentifierstringnoz(spawnpoint);

    if(isDefined(level.modifiedspawnpoints[_id_F2D96DD81CF63446]))
      _id_6D071BF9627C7F96 = level.modifiedspawnpoints[_id_F2D96DD81CF63446][spawnpoint.classname];
  }

  foreach(location, _id_FEA786092376EFC8 in level.modifiedspawnpoints) {
    foreach(classname, _id_44D182FF9A64635B in _id_FEA786092376EFC8) {
      if(spawnpoint.classname != classname) {
        continue;
      }
      foreach(_id_1E93F7232A9D345A, radius in _id_44D182FF9A64635B) {
        if(_id_1E93F7232A9D345A == "removeradius") {
          _id_8F3CECEFC2DE967C = strtok(location, " ");
          x = int(_id_8F3CECEFC2DE967C[0]);
          y = int(_id_8F3CECEFC2DE967C[1]);
          z = 0;

          if(isDefined(_id_8F3CECEFC2DE967C[2]))
            z = scripts\engine\utility::_id_53C4C53197386572(int(_id_8F3CECEFC2DE967C[2]), 0);

          origin = (x, y, z);

          if(isDefined(_id_8F3CECEFC2DE967C[2])) {
            if(distance(spawnpoint.origin, origin) < radius)
              return 1;
          } else if(distance2d(spawnpoint.origin, origin) < radius)
            return 1;
        }
      }
    }
  }

  if(!isDefined(_id_6D071BF9627C7F96))
    return 0;

  if(istrue(_id_6D071BF9627C7F96["remove"]))
    return 1;

  if(isDefined(_id_6D071BF9627C7F96["origin"]))
    spawnpoint.origin = _id_6D071BF9627C7F96["origin"];

  if(isDefined(_id_6D071BF9627C7F96["angles"]))
    spawnpoint.angles = _id_6D071BF9627C7F96["angles"];

  if(istrue(_id_6D071BF9627C7F96["no_alternates"]))
    spawnpoint.noalternates = 1;

  return 0;
}

_id_8CCE218650BB227C(spawnpoint) {
  if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "") {
    _id_D0B0DFB023F2B146 = strtok(spawnpoint.script_noteworthy, " ");

    foreach(n in _id_D0B0DFB023F2B146) {
      if(level._id_89296580B2860A1F == 1) {
        if(n == "6v6")
          return 1;
      } else if(n == "10v10")
        return 1;
    }
  }

  return 0;
}

calculateteamclusters(team) {
  _id_69E96A4CAA72D794 = spawnStruct();
  _id_69E96A4CAA72D794.clusterlist = [];

  foreach(player in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(player) || player.team != team || !player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("player_for_spawn_logic")) {
      continue;
    }
    _id_1C3554FBEC9A21E5 = createcluster(player);
    _id_69E96A4CAA72D794.clusterlist[_id_69E96A4CAA72D794.clusterlist.size] = _id_1C3554FBEC9A21E5;
  }

  mergeclusterlist(_id_69E96A4CAA72D794);
  return _id_69E96A4CAA72D794;
}

createcluster(player) {
  _id_3402D60C1EF6B931 = spawnStruct();
  _id_3402D60C1EF6B931.center = player.origin;
  _id_3402D60C1EF6B931.players = [player];
  return _id_3402D60C1EF6B931;
}

mergeclusterlist(_id_69E96A4CAA72D794) {
  _id_541B5A167C77648C = undefined;
  _id_541B5D167C776B25 = undefined;
  _id_14F82E0D331BCD8B = undefined;
  _id_445FFD719165EB75 = -1;

  for(_id_A7B44BD189368A72 = 0; _id_A7B44BD189368A72 < _id_69E96A4CAA72D794.clusterlist.size; _id_A7B44BD189368A72++) {
    _id_58F60CA818998AF0 = _id_69E96A4CAA72D794.clusterlist[_id_A7B44BD189368A72];

    for(_id_A7B44AD18936883F = _id_A7B44BD189368A72 + 1; _id_A7B44AD18936883F < _id_69E96A4CAA72D794.clusterlist.size; _id_A7B44AD18936883F++) {
      _id_58F60FA818999189 = _id_69E96A4CAA72D794.clusterlist[_id_A7B44AD18936883F];
      distsq = distance2dsquared(_id_58F60CA818998AF0.center, _id_58F60FA818999189.center);

      if(distsq > 640000) {
        continue;
      }
      if(_id_445FFD719165EB75 < 0 || distsq < _id_445FFD719165EB75) {
        _id_445FFD719165EB75 = distsq;
        _id_541B5A167C77648C = _id_58F60CA818998AF0;
        _id_541B5D167C776B25 = _id_58F60FA818999189;
        _id_14F82E0D331BCD8B = _id_A7B44AD18936883F;
      }
    }
  }

  if(isDefined(_id_541B5A167C77648C) && isDefined(_id_541B5D167C776B25)) {
    foreach(player in _id_541B5D167C776B25.players)
    _id_541B5A167C77648C.players[_id_541B5A167C77648C.players.size] = player;

    _id_B7E9316956E86D04 = (0, 0, 0);

    foreach(player in _id_541B5A167C77648C.players)
    _id_B7E9316956E86D04 = _id_B7E9316956E86D04 + player.origin;

    _id_B7E9316956E86D04 = _id_B7E9316956E86D04 / _id_541B5A167C77648C.players.size;
    _id_541B5A167C77648C.center = _id_B7E9316956E86D04;
    lastindex = _id_69E96A4CAA72D794.clusterlist.size - 1;
    _id_69E96A4CAA72D794.clusterlist[_id_14F82E0D331BCD8B] = _id_69E96A4CAA72D794.clusterlist[lastindex];
    _id_69E96A4CAA72D794.clusterlist[lastindex] = undefined;
    mergeclusterlist(_id_69E96A4CAA72D794);
  }
}

ignoretriggerenter(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
  player _id_3B64EB40368C1450::set("spawnIgnoreTrigger", "player_for_spawn_logic", 0);
}

ignoretriggerexit(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("spawnIgnoreTrigger");
}

getspawnbucketfromstring(_id_CBF572B044ED12E0) {
  switch (_id_CBF572B044ED12E0) {
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

enablespawnpointlist(spawnpoints) {
  foreach(spawnpoint in spawnpoints)
  enablespawnpointbyindex(spawnpoint.index);
}

disablespawnpointlist(spawnpoints) {
  foreach(spawnpoint in spawnpoints)
  disablespawnpointbyindex(spawnpoint.index);
}

registerspawnset(id, spawnpoints) {
  _id_584994FAB4A8712B = level.spawnglobals;
  _id_584994FAB4A8712B.spawnsets[id] = spawnpoints;

  if(isarray(spawnpoints))
    _id_584994FAB4A8712B.spawnsetlists[id] = spawnpoints;
  else
    _id_584994FAB4A8712B.spawnsetlists[id] = getspawnpointarray(spawnpoints);

  return id;
}

activatespawnset(id, exclusive) {
  _id_584994FAB4A8712B = level.spawnglobals;

  if(istrue(exclusive)) {
    if(_id_584994FAB4A8712B.activespawnsets.size == 1 && isDefined(_id_584994FAB4A8712B.activespawnsets[id])) {
      return;
    }
    deactivateallspawnsets();
  } else if(isDefined(_id_584994FAB4A8712B.activespawnsets[id])) {
    return;
  }
  spawnset = _id_584994FAB4A8712B.spawnsets[id];

  if(isarray(spawnset))
    enablespawnpointlist(spawnset);
  else
    enablespawnpointsbyclassname(spawnset);

  _id_584994FAB4A8712B.activespawnsets[id] = 1;
}

deactivatespawnset(id) {
  _id_584994FAB4A8712B = level.spawnglobals;
  _id_FECF52449F0D8583 = [];

  foreach(key, value in _id_584994FAB4A8712B.activespawnsets) {
    if(key != id) {
      _id_FECF52449F0D8583[key] = 1;
      continue;
    }

    spawnset = _id_584994FAB4A8712B.spawnsets[id];

    if(isarray(spawnset))
      disablespawnpointlist(spawnset);
    else
      disablespawnpointsbyclassname(spawnset);
  }

  _id_584994FAB4A8712B.activespawnsets = _id_FECF52449F0D8583;
}

deactivateallspawnsets() {
  level.spawnglobals.activespawnsets = [];
  disablespawnpoints();
}

getspawnsetsize(id) {
  return level.spawnglobals.spawnsetlists[id].size;
}

getrandomspawnpointfromset(id) {
  _id_584994FAB4A8712B = level.spawnglobals;
  return _id_584994FAB4A8712B.spawnsetlists[id][randomint(_id_584994FAB4A8712B.spawnsetlists[id].size)];
}

getrandomspawnpointfromactivesets() {
  _id_90BE334C1C37268A = getarraykeys(level.spawnglobals.activespawnsets);
  _id_FFED3098C31F4403 = undefined;

  while(!isDefined(_id_FFED3098C31F4403) && _id_90BE334C1C37268A.size > 0) {
    _id_FFED3098C31F4403 = scripts\engine\utility::random(_id_90BE334C1C37268A);

    if(getspawnsetsize(_id_FFED3098C31F4403) <= 0) {
      _id_90BE334C1C37268A = scripts\engine\utility::array_remove(_id_90BE334C1C37268A, _id_FFED3098C31F4403);
      _id_FFED3098C31F4403 = undefined;
    }
  }

  return level.spawnglobals.spawnsetlists[_id_FFED3098C31F4403][randomint(level.spawnglobals.spawnsetlists[_id_FFED3098C31F4403].size)];
}

createscriptedspawnpoint(classname, origin, angles, target, script_noteworthy) {
  spawnpoint = spawnStruct();
  spawnpoint.classname = classname;
  spawnpoint.origin = origin;
  spawnpoint.angles = angles;
  spawnpoint.target = target;
  spawnpoint.script_noteworthy = script_noteworthy;
  return spawnpoint;
}

addscriptedspawnpoints(_id_223764AD899D9FEE) {
  if(!isDefined(level.scriptedspawnpointarray))
    level.scriptedspawnpointarray = [];

  foreach(_id_CAA4C2F24C7B89AC in _id_223764AD899D9FEE) {
    classname = _id_CAA4C2F24C7B89AC.classname;
    origin = _id_CAA4C2F24C7B89AC.origin;
    angles = _id_CAA4C2F24C7B89AC.angles;

    if(isDefined(_id_CAA4C2F24C7B89AC.target))
      target = _id_CAA4C2F24C7B89AC.target;
    else
      target = "";

    if(isDefined(_id_CAA4C2F24C7B89AC.script_noteworthy))
      script_noteworthy = _id_CAA4C2F24C7B89AC.script_noteworthy;
    else
      script_noteworthy = "";

    if(!isDefined(level.scriptedspawnpointarray[classname]))
      level.scriptedspawnpointarray[classname] = [];

    _id_F1A1172ED4E53A5D = spawnStruct();
    _id_F1A1172ED4E53A5D.classname = classname;
    _id_F1A1172ED4E53A5D.origin = origin;
    _id_F1A1172ED4E53A5D.angles = angles;
    index = registerscriptedspawnpoints(classname, origin, angles, target, script_noteworthy);

    if(!isDefined(index) || index < 0) {
      continue;
    }
    _id_F1A1172ED4E53A5D.index = index;

    if(target != "")
      _id_F1A1172ED4E53A5D.target = target;

    if(script_noteworthy != "")
      _id_F1A1172ED4E53A5D.script_noteworthy = script_noteworthy;

    level.scriptedspawnpointarray[classname][level.scriptedspawnpointarray[classname].size] = _id_F1A1172ED4E53A5D;
  }

  level thread scriptedspawnpointsonmigration();
}

scriptedspawnpointsonmigration() {
  level notify("scriptedSpawnpointsOnMigration");
  level endon("scriptedSpawnpointsOnMigration");

  for(;;) {
    level waittill("host_migration_begin");

    foreach(_id_46A778B6F75C012C in level.scriptedspawnpointarray) {
      foreach(_id_CAA4C2F24C7B89AC in _id_46A778B6F75C012C) {
        if(isDefined(_id_CAA4C2F24C7B89AC.target))
          target = _id_CAA4C2F24C7B89AC.target;
        else
          target = "";

        if(isDefined(_id_CAA4C2F24C7B89AC.script_noteworthy))
          script_noteworthy = _id_CAA4C2F24C7B89AC.script_noteworthy;
        else
          script_noteworthy = "";

        index = registerscriptedspawnpoints(_id_CAA4C2F24C7B89AC.classname, _id_CAA4C2F24C7B89AC.origin, _id_CAA4C2F24C7B89AC.angles, target, script_noteworthy);
      }
    }
  }
}

_id_005D5267DAEDA595(_id_25FF9CCEFF399D80, _id_E1FAC4E807047E1C) {
  _id_87226A6B58A1AA22 = "";
  _id_40D7195435A4E5BE = "";

  switch (scripts\mp\utility\game::getgametype()) {
    case "rescue":
      _id_87226A6B58A1AA22 = "mp_rescue_spawn_attacker";
      _id_40D7195435A4E5BE = "mp_rescue_spawn_defender";
      break;
    case "sd":
      _id_87226A6B58A1AA22 = "mp_sd_spawn_attacker";
      _id_40D7195435A4E5BE = "mp_sd_spawn_defender";
      break;
    case "cyber":
      _id_87226A6B58A1AA22 = "mp_cyber_spawn_allies";
      _id_40D7195435A4E5BE = "mp_cyber_spawn_axis";
      break;
  }

  _id_29D9D2428185616D = [];
  _id_57407B8C8AF4084E = scripts\engine\utility::_id_CE51E08DCC037220(scripts\engine\utility::getStructArray(_id_25FF9CCEFF399D80, "script_noteworthy"), undefined, "Attacker Spawn was unable to find " + _id_25FF9CCEFF399D80 + " in the Battle Maps create script data");

  if(isDefined(_id_57407B8C8AF4084E)) {
    foreach(attacker in _id_57407B8C8AF4084E)
    _id_29D9D2428185616D[_id_29D9D2428185616D.size] = createscriptedspawnpoint(_id_87226A6B58A1AA22, attacker.origin, attacker.angles);
  }

  _id_232CF6A958A9F5CA = scripts\engine\utility::_id_CE51E08DCC037220(scripts\engine\utility::getStructArray(_id_E1FAC4E807047E1C, "script_noteworthy"), undefined, "Defender Spawn was unable to find " + _id_E1FAC4E807047E1C + " in the Battle Maps create script data");

  if(isDefined(_id_232CF6A958A9F5CA)) {
    foreach(_id_EE2753C1176F5C7E in _id_232CF6A958A9F5CA)
    _id_29D9D2428185616D[_id_29D9D2428185616D.size] = createscriptedspawnpoint(_id_40D7195435A4E5BE, _id_EE2753C1176F5C7E.origin, _id_EE2753C1176F5C7E.angles);
  }

  if(_id_29D9D2428185616D.size > 0)
    addscriptedspawnpoints(_id_29D9D2428185616D);
}

_id_9A3BEF3FFEF9C904(_id_A65640524CB6C8DD) {
  _id_25FF9CCEFF399D80 = "";
  _id_E1FAC4E807047E1C = "";
  level._id_F1C340DAE77CA15D = _id_A65640524CB6C8DD;

  switch (scripts\mp\utility\game::getgametype()) {
    case "rescue":
      if(isDefined(level._id_D27F667E6320D465)) {
        _id_25FF9CCEFF399D80 = level._id_D27F667E6320D465._id_A1DEE46F5965DAFB;
        _id_E1FAC4E807047E1C = level._id_D27F667E6320D465._id_199B24846B757EBD;
      } else {
        _id_25FF9CCEFF399D80 = "hr_allied_spawn";
        _id_E1FAC4E807047E1C = "hr_axis_spawn";
      }

      break;
    case "sd":
      if(isDefined(level._id_D27F667E6320D465)) {
        _id_25FF9CCEFF399D80 = level._id_D27F667E6320D465._id_8680EA7B41BDF4DC;
        _id_E1FAC4E807047E1C = level._id_D27F667E6320D465._id_388ABE281AFCD6F6;
      } else {
        _id_25FF9CCEFF399D80 = "sd_allied_spawn";
        _id_E1FAC4E807047E1C = "sd_axis_spawn";
      }

      break;
    case "cyber":
      if(isDefined(level._id_D27F667E6320D465)) {
        _id_25FF9CCEFF399D80 = level._id_D27F667E6320D465._id_EA715DA3CE810864;
        _id_E1FAC4E807047E1C = level._id_D27F667E6320D465._id_8907B8ECB4694AAE;
      } else {
        _id_25FF9CCEFF399D80 = "cyber_allied_spawn";
        _id_E1FAC4E807047E1C = "cyber_axis_spawn";
      }

      break;
  }

  _id_005D5267DAEDA595(_id_25FF9CCEFF399D80, _id_E1FAC4E807047E1C);
}