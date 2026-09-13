/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\mtmc.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = "mtmc";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.disablebuddyspawn = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onobjectivecomplete = ::onflagcapture;
  level.ondeadevent = ::ondeadevent;
  level.lastcaptime = gettime();
  game["dialog"]["gametype"] = "gametype_domination";
  game["dialog"]["offense_obj"] = "capture_objs";
  game["dialog"]["defense_obj"] = "capture_objs";
  game["dialog"]["securing_a"] = "securing_a";
  game["dialog"]["securing_b"] = "securing_b";
  game["dialog"]["securing_c"] = "securing_c";
  game["dialog"]["secured_a"] = "secure_a";
  game["dialog"]["secured_b"] = "secure_b";
  game["dialog"]["secured_c"] = "secure_c";
  game["dialog"]["losing_a"] = "losing_a";
  game["dialog"]["losing_b"] = "losing_b";
  game["dialog"]["losing_c"] = "losing_c";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_DCEB221C25AECC14", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("dvar_893144FA8142F154", getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar("dvar_347FFD1B942E9310", getmatchrulesdata("domData", "objScalar"));
  setdynamicdvar("dvar_2B790C4F6834B087", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar("dvar_C0AFFFC882CF1C47", getmatchrulesdata("captureData", "captureType"));
  setdynamicdvar("dvar_6B9C2F7D2ECE6E97", getmatchrulesdata("captureData", "captureDecay"));
  setdynamicdvar("dvar_A132F0CB12C4EB3B", 0);
  scripts\mp\utility\game::registerhalftimedvar("mtmc", 0);
}

seticonnames() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
  level.icontarget = "icon_waypoint_target";
}

onstartgametype() {
  seticonnames();

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/DOM");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DOM");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DOM_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/DOM_HINT");
  }

  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(!isDefined(game["remainingTeams"]))
    game["remainingTeams"] = level.teamnamelist;

  initspawns();
  thread setupflags();
  thread startgame();
}

startgame() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 15.0;

  foreach(obj in level.objectives) {
    obj scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    obj scripts\mp\gameobjects::enableobject();
    obj scripts\mp\gameobjects::setvisibleteam("any");
    obj scripts\mp\gameobjects::allowuse("any");
  }
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 30, 0, 30);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("flagNeutralization", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("preCapPoints", 0, 0, 1);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("captureDecay", 1, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("captureType", 1, 0, 3);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("objScalar", 4, 1, 10);
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("MTMC", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_mtmc_spawn_start");

  foreach(_id_F90358454413407F in game["remainingTeams"])
  scripts\mp\spawnlogic::registerspawnpoints(_id_F90358454413407F, _id_29D9D2428185616D);

  level.startlocations = [];

  foreach(s in _id_29D9D2428185616D) {
    if(!isDefined(s.target) || s.target == "") {
      continue;
    }
    if(!isDefined(s.script_noteworthy) || s.script_noteworthy == "") {}

    if(int(s.script_noteworthy) != game["remainingTeams"].size) {
      continue;
    }
    loc = level.startlocations[s.target];

    if(isDefined(loc)) {
      loc.spawnpoints[loc.spawnpoints.size] = s;
      continue;
    }

    target = scripts\engine\utility::getStruct(s.target, "targetname");
    struct = spawnStruct();
    struct.origin = target.origin;
    struct.angles = target.angles;
    struct.spawnpoints = [];
    struct.spawnpoints[0] = s;
    struct.inuse = 0;
    level.startlocations[s.target] = struct;
  }

  foreach(key, loc in level.startlocations) {
    scripts\mp\spawnlogic::registerspawnset(key, loc.spawnpoints);
    scripts\mp\spawnlogic::activatespawnset(key);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  scripts\mp\spawnlogic::deactivateallspawnsets();

  if(!isDefined(level.teamspawnlocations))
    level.teamspawnlocations = [];

  key = level.teamspawnlocations[self.team];

  if(isDefined(key)) {
    scripts\mp\spawnlogic::activatespawnset(key);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
    return spawnpoint;
  }

  foreach(key, loc in level.startlocations) {
    if(loc.inuse) {
      continue;
    }
    scripts\mp\spawnlogic::activatespawnset(key);
  }

  spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
  level.startlocations[spawnpoint.target].inuse = 1;
  level.teamspawnlocations[self.team] = spawnpoint.target;
  return spawnpoint;
}

setupflags() {
  triggers = getEntArray("mtmc_dom", "targetname");

  if(!triggers.size) {
    return;
  }
  foreach(trigger in triggers) {
    if(!isDefined(trigger.script_noteworthy) || trigger.script_noteworthy == "") {}

    if(int(trigger.script_noteworthy) != game["remainingTeams"].size) {
      continue;
    }
    domflag = _id_6663215F917210AE::setupobjective(trigger, 1);
    domflag scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    domflag scripts\mp\gameobjects::disableobject();
    domflag scripts\mp\gameobjects::setvisibleteam("any");
    domflag scripts\mp\gameobjects::allowuse("none");
    level.objectives[domflag.objectivekey] = domflag;
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }
  if(isDefined(objweapon) && _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename)) {
    return;
  }
  _id_6663215F917210AE::awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);
}

onspawnplayer(_id_9156B53BCF7CE573) {}

onplayerconnect(player) {
  player thread onplayerspawned();
}

onplayerspawned(player) {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["captures"]))
      scripts\mp\utility\stats::setextrascore0(self.pers["captures"]);

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["defends"]))
      scripts\mp\utility\stats::setextrascore1(self.pers["defends"]);
  }
}

onflagcapture(_id_3985F515E9F06D2C, label, _id_22282E7D48CA3400, team, _id_8A04AA0E0755E7E3, _id_579DA7B2997DEC60) {
  scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, team, 1);
  _id_D44B7B1A5D0E8F39 = scripts\mp\utility\game::getotherteam(team);

  foreach(_id_F90358454413407F in _id_D44B7B1A5D0E8F39)
  scripts\mp\utility\dialog::statusdialog("lost_" + self.objectivekey, _id_F90358454413407F, 1);

  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::allowuse("none");

  if(isDefined(self.flagmodel))
    self.flagmodel hide();

  if(!isDefined(level.remainingflags))
    level.remainingflags = level.objectives.size;

  level.remainingflags--;

  if(level.remainingflags == 0)
    setremainingteams();
}

ondeadevent(team) {
  if(team == "all")
    setremainingteams();
  else {
    _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(team);
    livescount = [];

    foreach(_id_F90358454413407F in _id_B0C33D224B825287)
    livescount[_id_F90358454413407F] = 0;

    if(!istrue(level.disablespawning)) {
      foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
        foreach(player in scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players")) {
          if(!istrue(player.hasspawned)) {
            continue;
          }
          livescount[_id_F90358454413407F] = livescount[_id_F90358454413407F] + player.pers["lives"];
        }
      }
    }

    _id_A9CEB9B39C78FB07 = [];

    foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
      if(scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount") || livescount[_id_F90358454413407F])
        _id_A9CEB9B39C78FB07[_id_A9CEB9B39C78FB07.size] = _id_F90358454413407F;
    }

    if(_id_A9CEB9B39C78FB07.size == 1)
      setremainingteams(_id_A9CEB9B39C78FB07[0]);
  }
}

setremainingteams(team) {
  if(istrue(level.remainingteamsset)) {
    return;
  }
  level.remainingteamsset = 1;
  game["remainingTeams"] = [];

  foreach(objective in level.objectives) {
    if(objective.ownerteam == "neutral") {
      continue;
    }
    if(!scripts\engine\utility::array_contains(game["remainingTeams"], objective.ownerteam))
      game["remainingTeams"][game["remainingTeams"].size] = objective.ownerteam;
  }

  if(isDefined(team) && !scripts\engine\utility::array_contains(game["remainingTeams"], team) && game["remainingTeams"].size < level.objectives.size)
    game["remainingTeams"][game["remainingTeams"].size] = team;

  foreach(player in level.players) {
    if(scripts\engine\utility::array_contains(level.teamnamelist, player.team)) {
      if(!scripts\engine\utility::array_contains(game["remainingTeams"], player.team))
        player scripts\mp\menus::addtoteam("spectator");
    }
  }

  if(game["remainingTeams"].size == 1) {
    scripts\mp\gamescore::giveteamscoreforobjective(game["remainingTeams"][0], 1, 0);
    thread scripts\mp\gamelogic::endgame(game["remainingTeams"][0], game["end_reason"]["enemies_eliminated"]);
  } else
    thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["objective_completed"]);
}