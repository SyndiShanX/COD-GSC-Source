/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\sab.gsc
********************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();
  level.objectivebased = 1;
  level.teambased = 1;

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [
      [level.initializematchrules]
    ]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 0);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
    setdynamicdvar("scr_killcount_persists", 0);
  }

  maps\mp\_utility::setcarrierloadouts();
  level.classicgamemode = 1;

  if(!intiebreaker()) {
    level.onprecachegametype = ::onprecachegametype;
    level.onstartgametype = ::onstartgametype;
    level.getspawnpoint = ::getspawnpoint;
    level.onspawnplayer = ::onspawnplayer;
    level.ononeleftevent = ::ononeleftevent;
    level.ontimelimit = ::ontimelimit;
    level.ondeadevent = ::ondeadevent;
    level.onnormaldeath = ::onnormaldeath;
    level.overridewasonlyround = ::wasonlyroundsab;
    game["dialog"]["gametype"] = "sabotage";
    game["dialog"]["offense_obj"] = "capture_objs";
    game["dialog"]["defense_obj"] = "capture_objs";
  } else {
    level.onstartgametype = ::onstartgametype;
    level.getspawnpoint = ::getspawnpoint;
    level.onspawnplayer = ::onspawnplayer;
    game["dialog"]["gametype"] = "sabotage";
    game["dialog"]["offense_obj"] = "boost";
    game["dialog"]["defense_obj"] = "boost";
    maps\mp\_utility::setoverridewatchdvar("numlives", 1);
    maps\mp\_utility::setoverridewatchdvar("timeLimit", 0);
  }

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

  var_0 = getent("sab_bomb_defuse_allies", "targetname");

  if(isdefined(var_0))
    var_0 delete();

  var_0 = getent("sab_bomb_defuse_axis", "targetname");

  if(isdefined(var_0))
    var_0 delete();

  setomnvar("ui_bomb_timer_endtime", 0);
}

wasonlyroundsab() {
  if(maps\mp\_utility::getwatcheddvar("roundlimit") == 0 && maps\mp\_utility::getwatcheddvar("winlimit") == 1)
    return 1;

  return 0;
}

intiebreaker() {
  return maps\mp\_utility::is_true(game["tiebreaker"]);
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_sab_bombtimer", getmatchrulesdata("sabData", "bombTimer"));
  setdynamicdvar("scr_sab_planttime", getmatchrulesdata("sabData", "plantTime"));
  setdynamicdvar("scr_sab_defusetime", getmatchrulesdata("sabData", "defuseTime"));
  setdynamicdvar("scr_sab_hotpotato", getmatchrulesdata("sabData", "sharedBombTimer"));
  setdynamicdvar("scr_sab_silentplant", getmatchrulesdata("sabData", "silentPlant"));
  var_0 = getmatchrulesdata("sabData", "roundSwitch");
  setdynamicdvar("scr_sab_roundswitch", var_0);
  maps\mp\_utility::registerroundswitchdvar("sab", var_0, 0, 9);
  setdynamicdvar("scr_sab_roundlimit", 0);
  maps\mp\_utility::registerroundlimitdvar("sab", 0);
  var_1 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_sab_winlimit", var_1);
  maps\mp\_utility::registerwinlimitdvar("sab", var_1);
  setdynamicdvar("scr_sab_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("sab", 0);
}

onprecachegametype() {
  maps\mp\gametypes\common_bomb_gameobject::onprecachegametype();
}

onstartgametype() {
  if(!isdefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  setclientnamemode("auto_change");

  if(!intiebreaker()) {
    maps\mp\_utility::setobjectivetext("allies", & "OBJECTIVES_SAB");
    maps\mp\_utility::setobjectivetext("axis", & "OBJECTIVES_SAB");

    if(level.splitscreen) {
      maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_SAB");
      maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_SAB");
    } else {
      maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_SAB_SCORE");
      maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_SAB_SCORE");
    }

    maps\mp\_utility::setobjectivehinttext("allies", & "OBJECTIVES_SAB_HINT");
    maps\mp\_utility::setobjectivehinttext("axis", & "OBJECTIVES_SAB_HINT");
  } else {
    maps\mp\_utility::setobjectivetext("allies", & "OBJECTIVES_WAR");
    maps\mp\_utility::setobjectivetext("axis", & "OBJECTIVES_WAR");

    if(level.splitscreen) {
      maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_WAR");
      maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_WAR");
    } else {
      maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_WAR_SCORE");
      maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_WAR_SCORE");
    }

    maps\mp\_utility::setobjectivehinttext("allies", & "OBJECTIVES_WAR_HINT");
    maps\mp\_utility::setobjectivehinttext("axis", & "OBJECTIVES_WAR_HINT");
  }

  initspawns();

  if(intiebreaker()) {
    setdvar("bg_compassShowEnemies", 1);
    var_0[0] = "war";
    maps\mp\gametypes\_gameobjects::main(var_0);
    return;
  }

  var_0[0] = "sab";
  maps\mp\gametypes\_gameobjects::main(var_0);
  thread updategametypedvars();
  thread sabotage();
  thread maps\mp\gametypes\_spectating::allowallyteamspectating();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sab_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sab_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_sab_spawn");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_sab_spawn");
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.spawn_axis = [];
  level.spawn_axis_planted = [];
  level.spawn_axis_planted = [];
  level.spawn_axis_planted = [];
  level.spawn_allies = [];
  level.spawn_allies_planted = [];
  level.spawn_allies_planted = [];
  level.spawn_allies_planted = [];
  var_0 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn");

  foreach(var_2 in var_0) {
    if(!isdefined(var_2.script_noteworthy)) {
      spawnpointerror(var_2);
      continue;
    }

    switch (var_2.script_noteworthy) {
      case "axis":
        level.spawn_axis[level.spawn_axis.size] = var_2;
      case "axis_planted":
        level.spawn_axis_planted[level.spawn_axis_planted.size] = var_2;
        break;
      case "allies":
        level.spawn_allies[level.spawn_allies.size] = var_2;
      case "allies_planted":
        level.spawn_allies_planted[level.spawn_allies_planted.size] = var_2;
        break;
      default:
        spawnpointerror(var_2);
        break;
    }
  }
}

spawnpointerror(var_0) {}

getspawnpoint() {
  var_0 = self.pers["team"];

  if(game["switchedsides"])
    var_0 = maps\mp\_utility::getotherteam(var_0);

  if(level.usestartspawns)
    var_1 = maps\mp\gametypes\_spawnlogic::getrandomstartspawn("mp_sab_spawn_" + var_0 + "_start");
  else if(isdefined(level.bombplanted) && level.bombplanted && (isdefined(level.bombowner) && var_0 == level.bombowner.team)) {
    if(var_0 == "axis")
      var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_axis_planted);
    else
      var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_allies_planted);
  } else if(var_0 == "axis")
    var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_axis);
  else
    var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_allies);

  return var_1;
}

onspawnplayer() {
  self.isplanting = 0;
  self.isdefusing = 0;
  self.isbombcarrier = 0;
  self setclientomnvar("ui_carrying_bomb", self.isbombcarrier);

  if(intiebreaker())
    thread setplayersuddendeathvalues();
}

updategametypedvars() {
  level.planttime = maps\mp\_utility::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer", 45, 1, 300);
  level.hotpotato = maps\mp\_utility::dvarintvalue("hotpotato", 1, 0, 1);
  level.silentplant = maps\mp\_utility::dvarintvalue("silentplant", 0, 0, 1);
}

sabotage() {
  level.bombplanted = 0;
  level.bombexploded = 0;
  maps\mp\gametypes\common_bomb_gameobject::loadbombfx();
  var_0 = getent("sab_bomb_pickup_trig", "targetname");

  if(!isdefined(var_0))
    common_scripts\utility::error("No sab_bomb_pickup_trig trigger found in map.");
  else {
    var_1 = maps\mp\gametypes\common_bomb_gameobject::getcarrybombvisuals("sab_bomb");

    if(!isdefined(var_1)) {
      common_scripts\utility::error("No sab_bomb script_model found in map.");
      return;
    }

    level.sabbomb = maps\mp\gametypes\common_bomb_gameobject::createbombcarryobject("neutral", "any", var_0, var_1);
    thread maps\mp\_utility::streamcarrierweaponstoplayers(level.sabbomb, ["allies", "axis"], ::shouldstreamcarrierclasstoplayer);
    level.sabbomb.objidpingenemy = 1;
    level.sabbomb.onpickup = ::onpickup;
    level.sabbomb.ondrop = ::ondrop;
    level.sabbomb.objpoints["allies"].archived = 1;
    level.sabbomb.objpoints["axis"].archived = 1;
    level.sabbomb.autoresettime = 60.0;
    maps\mp\_utility::setmlgicons(level.sabbomb, "waypoint_bomb");

    if(!isdefined(getent("sab_bomb_axis", "targetname"))) {
      common_scripts\utility::error("No sab_bomb_axis trigger found in map.");
      return;
    }

    if(!isdefined(getent("sab_bomb_allies", "targetname"))) {
      common_scripts\utility::error("No sab_bomb_allies trigger found in map.");
      return;
    }

    if(game["switchedsides"]) {
      level.bombzones["allies"] = createbombzone("allies", getent("sab_bomb_axis", "targetname"));
      level.bombzones["axis"] = createbombzone("axis", getent("sab_bomb_allies", "targetname"));
      return;
    }

    level.bombzones["allies"] = createbombzone("allies", getent("sab_bomb_allies", "targetname"));
    level.bombzones["axis"] = createbombzone("axis", getent("sab_bomb_axis", "targetname"));
  }
}

shouldstreamcarrierclasstoplayer(var_0, var_1) {
  if(var_1.team == var_0 maps\mp\gametypes\_gameobjects::getownerteam())
    return 0;

  return 1;
}

createbombzone(var_0, var_1) {
  var_2 = getentarray(var_1.target, "targetname");
  var_3 = maps\mp\gametypes\common_bomb_gameobject::createbombzoneobject(var_0, "enemy", "none", var_1, level.sabbomb, 0);
  maps\mp\_utility::setmlgicons(var_3, "waypoint_esports_sab_target" + var_3.label);
  var_3.onuse = ::onuse;
  var_3.onbeginuse = ::onbeginuse;
  var_3.onenduse = ::onenduse;
  var_3.oncantuse = ::oncantuse;
  return var_3;
}

onbeginuse(var_0) {
  if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(var_0.pers["team"]))
    maps\mp\gametypes\common_bomb_gameobject::onbeginplantbomb(var_0);
  else
    maps\mp\gametypes\common_bomb_gameobject::onbegindefusebomb(var_0, level.sabbombmodel);
}

onenduse(var_0, var_1, var_2) {
  var_3 = isdefined(var_1) && var_1.isdefusing;
  maps\mp\gametypes\common_bomb_gameobject::onendusebomb(var_1, var_3);
}

onpickup(var_0) {
  self.autoresettime = 60.0;
  level.usestartspawns = 0;
  var_1 = var_0.pers["team"];

  if(var_1 == "allies")
    var_2 = "axis";
  else
    var_2 = "allies";

  var_3 = undefined;

  if(var_1 == maps\mp\gametypes\_gameobjects::getownerteam())
    var_3 = var_1;

  maps\mp\gametypes\common_bomb_gameobject::oncarrybombpickup(var_0, var_3);
  var_0 maps\mp\_utility::leaderdialogonplayer("obj_destroy", "bomb");
  var_4[0] = var_0;
  maps\mp\_utility::leaderdialog("bomb_taken", var_1, "bomb", var_4);

  if(!level.splitscreen) {
    maps\mp\_utility::leaderdialog("bomb_lost", var_2, "bomb");
    maps\mp\_utility::leaderdialog("obj_defend", var_2, "bomb");
  }

  if(isdefined(level.carrierloadouts) && isdefined(level.carrierloadouts[var_1]))
    var_0 thread maps\mp\_utility::applycarrierclass();

  maps\mp\gametypes\_gameobjects::setownerteam(var_1);
  maps\mp\gametypes\_gameobjects::setvisibleteam("any");
  maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_target");
  maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_kill");
  maps\mp\_utility::setmlgicons(self, "waypoint_bomb");
  level.bombzones[var_1] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
  level.bombzones[var_2] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
}

ondrop(var_0) {
  if(!level.bombplanted) {
    var_1 = maps\mp\gametypes\_gameobjects::getownerteam();
    maps\mp\gametypes\common_bomb_gameobject::oncarrybombdrop(var_1, level.otherteam[var_1]);
    maps\mp\gametypes\_gameobjects::setownerteam("neutral");
    maps\mp\gametypes\_gameobjects::setvisibleteam("any");
    maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_bomb");
    maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_bomb");
    maps\mp\_utility::setmlgicons(self, "waypoint_bomb");
    level.bombzones["allies"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
    level.bombzones["axis"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
  }
}

onuse(var_0) {
  var_1 = var_0.pers["team"];
  var_2 = level.otherteam[var_1];

  if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(var_0.pers["team"])) {
    var_0 maps\mp\gametypes\common_bomb_gameobject::onplayerplantbomb(1, var_1, var_2);
    var_3 = maps\mp\gametypes\_gameobjects::getlabel();
    maps\mp\_utility::setmlgicons(self, "waypoint_esports_sab_planted" + var_3);
    level thread bombplanted(self, var_0);

    if(isdefined(level.carrierloadouts) && isdefined(level.carrierloadouts[var_1])) {
      var_0 thread maps\mp\_utility::removecarrierclass();
      return;
    }
  } else {
    var_0 maps\mp\gametypes\common_bomb_gameobject::onplayerdefusebomb(getdefusetype(var_0), var_1, var_2);
    level thread bombdefused(self, var_0, var_1);
  }
}

getdefusetype(var_0) {
  var_1 = "defuse";

  if(isdefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && maps\mp\_utility::isreallyalive(level.bombowner))
    var_1 = "ninja_defuse";

  return var_1;
}

oncantuse(var_0) {
  var_0 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

bombplanted(var_0, var_1) {
  level endon("overtime");
  level.bombplanted = 1;
  var_2 = var_1.pers["team"];
  var_0 maps\mp\gametypes\common_bomb_gameobject::setupzonefordefusing(0);
  level.bombplantedby = var_2;
  level.sabbomb.autoresettime = undefined;
  level.sabbomb maps\mp\gametypes\_gameobjects::allowcarry("none");
  level.sabbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
  maps\mp\_utility::setmlgicons(level.sabbomb, undefined);
  level.sabbomb maps\mp\gametypes\_gameobjects::setdropped();
  level.sabbombmodel = level.sabbomb.visuals[0];
  setomnvar("ui_bomb_timer", 1);
  level.defuseendtime = int(gettime() + level.bombtimer * 1000);
  setgameendtime(level.defuseendtime);
  var_0 maps\mp\gametypes\common_bomb_gameobject::onbombplanted(level.sabbombmodel.origin + (0, 0, 1));
  var_3 = var_0 maps\mp\gametypes\_gameobjects::getlabel();

  if(var_3 == "_allies")
    setomnvar("ui_mlg_game_mode_status_1", 1);
  else if(var_3 == "_axis")
    setomnvar("ui_mlg_game_mode_status_1", 2);

  bombtimerwait();
  setomnvar("ui_bomb_timer", 0);
  setomnvar("ui_bomb_timer_endtime", 0);
  var_0.tickingobject maps\mp\gametypes\common_bomb_gameobject::stoptickingsound();

  if(level.gameended) {
    return;
  }
  if(!level.bombplanted && level.hotpotato) {
    var_4 = (gettime() - level.timepausestart) / 1000;
    level.bombtimer = level.bombtimer - var_4;
  }

  if(!level.bombplanted) {
    return;
  }
  var_5 = level.sabbomb.visuals[0].origin;
  level.bombexploded = 1;
  setdvar("ui_danger_team", "BombExploded");
  setomnvar("ui_mlg_game_mode_status_1", 0);
  var_0 maps\mp\gametypes\common_bomb_gameobject::onbombexploded(var_5, 200, var_1);
  level.sabbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
  level.bombzones["allies"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
  level.bombzones["axis"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
  var_0 maps\mp\gametypes\_gameobjects::disableobject();

  if(level.gameended) {
    return;
  }
  setgameendtime(0);
  maps\mp\gametypes\_gamescore::_setteamscore(var_2, 1);
  maps\mp\gametypes\_gamescore::updateteamscore(var_2);
  wait 3;
  level.finalkillcam_winner = var_2;
  thread maps\mp\gametypes\_gamelogic::endgame(var_2, game["end_reason"]["target_destroyed"]);
}

bombtimerwait() {
  level endon("bomb_defused");
  level endon("overtime_ended");
  level endon("game_ended");
  var_0 = int(level.bombtimer * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime", var_0);
  level thread handlehostmigration(var_0);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

handlehostmigration(var_0) {
  level endon("bomb_defused");
  level endon("overtime_ended");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  var_1 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(var_1 > 0)
    setomnvar("ui_bomb_timer_endtime", var_0 + var_1);
}

givelastonteamwarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::waittillrecoveredhealth(3);
  var_0 = maps\mp\_utility::getotherteam(self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, var_0);
  level notify("last_alive", self);
}

ontimelimit() {
  if(maps\mp\_utility::is_true(level.insuddendeath)) {
    return;
  }
  thread suddendeaththread();
}

suddendeaththread() {
  level endon("game_ended");
  level.timelimitoverride = 1;
  level.insuddendeath = 1;

  for (var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] thread sabforcerespawn();
    level.players[var_0] thread setplayersuddendeathvalues();
  }

  setdvar("bg_compassShowEnemies", 1);
  maps\mp\_utility::setoverridewatchdvar("numlives", 1);
  level.sabsuddendeathtime = 90;
  var_1 = 0;

  while (var_1 < level.sabsuddendeathtime) {
    if(!level.bombplanted) {
      var_1 = var_1 + 1;
      setgameendtime(gettime() + (level.sabsuddendeathtime - var_1) * 1000);
    }

    wait 1.0;
  }

  level.finalkillcam_winner = "none";
  thread maps\mp\gametypes\_gamelogic::endgame("tie", game["end_reason"]["tie"]);
}

sabforcerespawn() {
  self endon("spawned_player");
  self endon("spawn");
  self endon("disconnect");

  if(!self.hasspawned) {
    return;
  }
  self notify("force_spawn");
  wait 0.05;

  if(self.sessionstate != "playing" || self.health <= 0) {
    while (self.health <= 0) {
      self notify("force_spawn");

      if(maps\mp\_utility::isinkillcam()) {
        self.cancelkillcam = 1;
        maps\mp\_utility::clearkillcamstate();
      } else if(self.sessionstate == "spectator" && !self.waitingtospawn && !maps\mp\_utility::is_true(self.waitingtospawnamortize))
        thread sabwaitandspawnclient();

      wait 0.25;
    }
  }
}

sabwaitandspawnclient() {
  self endon("disconnect");
  self.waitingtospawn = 1;
  maps\mp\gametypes\_playerlogic::waitandspawnclient();

  if(isdefined(self))
    self.waitingtospawn = 0;
}

setplayersuddendeathvalues() {
  self endon("disconnect");
  self setclientdvars("cg_deadChatWithDead", 1, "cg_deadChatWithTeam", 0, "cg_deadHearTeamLiving", 0, "cg_deadHearAllLiving", 0, "cg_everyoneHearsEveryone", 0);
  maps\mp\_utility::gameflagwait("prematch_done");

  while (self.sessionstate != "playing" || self.health <= 0)
    wait 0.05;

  thread maps\mp\gametypes\_hud_message::splashnotify("sab_overtime");
}

ondeadevent(var_0) {
  level.finalkillcam_winner = "none";

  if(level.bombexploded) {
    return;
  }
  if(var_0 == "all") {
    if(level.bombplanted) {
      level.finalkillcam_winner = level.bombplantedby;
      maps\mp\gametypes\_gamescore::_setteamscore(level.bombplantedby, 1);
      maps\mp\gametypes\_gamescore::updateteamscore(level.bombplantedby);
      thread maps\mp\gametypes\_gamelogic::endgame(level.bombplantedby, game["end_reason"][level.bombplantedby + "_mission_accomplished"]);
    } else
      thread maps\mp\gametypes\_gamelogic::endgame("tie", game["end_reason"]["tie"]);
  } else if(level.bombplanted) {
    if(var_0 == level.bombplantedby) {
      level.plantingteamdead = 1;
      return;
    }

    level.finalkillcam_winner = level.bombplantedby;
    maps\mp\gametypes\_gamescore::_setteamscore(level.bombplantedby, 1);
    maps\mp\gametypes\_gamescore::updateteamscore(level.bombplantedby);
    thread maps\mp\gametypes\_gamelogic::endgame(level.bombplantedby, game["end_reason"][level.otherteam[level.bombplantedby] + "_eliminated"]);
  } else {
    level.finalkillcam_winner = level.otherteam[var_0];
    maps\mp\gametypes\_gamescore::_setteamscore(level.otherteam[var_0], 1);
    maps\mp\gametypes\_gamescore::updateteamscore(level.otherteam[var_0]);
    thread maps\mp\gametypes\_gamelogic::endgame(level.otherteam[var_0], game["end_reason"][var_0 + "_eliminated"]);
  }
}

bombdefused(var_0, var_1, var_2) {
  var_0.bombplantedon = 0;

  if(maps\mp\_utility::is_true(level.insuddendeath) && isdefined(level.plantingteamdead)) {
    maps\mp\gametypes\_gamescore::_setteamscore(var_2, 1);
    maps\mp\gametypes\_gamescore::updateteamscore(var_2);
    level.finalkillcam_winner = var_2;
    thread maps\mp\gametypes\_gamelogic::endgame(var_2, game["end_reason"]["bomb_defused"]);
    return;
  }

  setomnvar("ui_bomb_timer", 0);
  setomnvar("ui_bomb_timer_endtime", 0);
  maps\mp\gametypes\_gamelogic::resumetimer();
  level.bombplanted = 0;

  if(!maps\mp\_utility::is_true(level.insuddendeath))
    level.timelimitoverride = 0;

  level notify("bomb_defused");
  var_0 maps\mp\gametypes\common_bomb_gameobject::resetbombzone(level.sabbomb, "enemy", "none", 0);
  maps\mp\_utility::setmlgicons(var_0, "waypoint_esports_sab_target" + var_0.label);
  level.sabbomb maps\mp\gametypes\_gameobjects::allowcarry("any");
  level.sabbomb maps\mp\gametypes\_gameobjects::setpickedup(var_1);
}

ononeleftevent(var_0) {
  if(level.bombexploded) {
    return;
  }
  var_1 = maps\mp\_utility::getlastlivingplayer(var_0);
  var_1 thread givelastonteamwarning();
}

onnormaldeath(var_0, var_1, var_2, var_2) {
  if(var_0.isplanting) {
    thread maps\mp\_matchdata::logkillevent(var_2, "planting");
    var_1 thread maps\mp\_events::defendobjectiveevent(var_0, var_2);
  } else if(var_0.isbombcarrier)
    thread maps\mp\_matchdata::logkillevent(var_2, "carrying");
  else if(var_0.isdefusing) {
    thread maps\mp\_matchdata::logkillevent(var_2, "defusing");
    var_1 thread maps\mp\_events::defendobjectiveevent(var_0, var_2);
  }
}