/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\dd.gsc
********************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [
      [level.initializematchrules]
    ]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 1, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 3);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 3);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 2);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  maps\mp\_utility::setovertimelimitdvar(3);
  level.objectivebased = 1;
  level.teambased = 1;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onspawnplayer = ::onspawnplayer;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimit = ::ontimelimit;
  level.onnormaldeath = ::onnormaldeath;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

  level.dd = 1;
  level.bombsplanted = 0;
  level.ddbombmodel = [] setbombtimerdvar();
  setuibombtimer("_a", 0);
  setuibombtimer("_b", 0);
  game["dialog"]["gametype"] = "dmo_intro";
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  var_0 = getmatchrulesdata("demData", "roundLength");
  setdynamicdvar("scr_dd_timelimit", var_0);
  maps\mp\_utility::registertimelimitdvar("dd", var_0);
  var_1 = getmatchrulesdata("demData", "roundSwitch");
  setdynamicdvar("scr_dd_roundswitch", var_1);
  maps\mp\_utility::registerroundswitchdvar("dd", var_1, 0, 9);
  setdynamicdvar("scr_dd_bombtimer", getmatchrulesdata("demData", "bombTimer"));
  setdynamicdvar("scr_dd_planttime", getmatchrulesdata("demData", "plantTime"));
  setdynamicdvar("scr_dd_defusetime", getmatchrulesdata("demData", "defuseTime"));
  setdynamicdvar("scr_dd_silentplant", getmatchrulesdata("demData", "silentPlant"));
  level.ddtimetoadd = getmatchrulesdata("demData", "extraTime");
  setdynamicdvar("scr_dd_addtime", level.ddtimetoadd);
  setdynamicdvar("scr_dd_roundlimit", 3);
  maps\mp\_utility::registerroundlimitdvar("dd", 3);
  setdynamicdvar("scr_dd_winlimit", 2);
  maps\mp\_utility::registerwinlimitdvar("dd", 2);
  setdynamicdvar("scr_dd_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("dd", 0);
}

onprecachegametype() {
  maps\mp\gametypes\common_bomb_gameobject::onprecachegametype();
}

onstartgametype() {
  if(game["roundsPlayed"] == 2)
    game["status"] = "overtime";

  if(!isdefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  level.usestartspawns = 1;
  setclientnamemode("manual_change");

  if(maps\mp\_utility::inovertime())
    game["dialog"]["defense_obj"] = "obj_destroy";

  maps\mp\gametypes\common_bomb_gameobject::loadbombfx();
  maps\mp\_utility::setobjectivetext(game["attackers"], & "OBJECTIVES_DD_ATTACKER");
  maps\mp\_utility::setobjectivetext(game["defenders"], & "OBJECTIVES_DD_DEFENDER");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], & "OBJECTIVES_DD_ATTACKER");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], & "OBJECTIVES_DD_DEFENDER");
  } else {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], & "OBJECTIVES_DD_ATTACKER_SCORE");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], & "OBJECTIVES_DD_DEFENDER_SCORE");
  }

  if(maps\mp\_utility::inovertime()) {
    maps\mp\_utility::setobjectivehinttext(game["attackers"], & "OBJECTIVES_DD_OVERTIME_HINT");
    maps\mp\_utility::setobjectivehinttext(game["defenders"], & "OBJECTIVES_DD_OVERTIME_HINT");
  } else {
    maps\mp\_utility::setobjectivehinttext(game["attackers"], & "OBJECTIVES_DD_ATTACKER_HINT");
    maps\mp\_utility::setobjectivehinttext(game["defenders"], & "OBJECTIVES_DD_DEFENDER_HINT");
  }

  initspawns();
  thread updategametypedvars();
  thread waittoprocess();
  var_2 = maps\mp\_utility::getwatcheddvar("winlimit");
  var_3[0] = "dd";
  var_3[1] = "dd_bombzone";
  var_3[2] = "blocker";
  maps\mp\gametypes\_gameobjects::main(var_3);
  thread bombs();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn");
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dd_spawn_defender_start");
  maps\mp\gametypes\_spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn");
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dd_spawn_attacker_start");
  level.spawn_defenders = [];
  level.spawn_defenders_a = [];
  level.spawn_defenders_a = [];
  level.spawn_defenders_b = [];
  level.spawn_defenders_b = [];
  level.spawn_attackers = [];
  level.spawn_attackers_a = [];
  level.spawn_attackers_a = [];
  level.spawn_attackers_b = [];
  level.spawn_attackers_b = [];
  var_0 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn");

  foreach(var_2 in var_0) {
    if(!isdefined(var_2.script_noteworthy)) {
      spawnpointerror(var_2);
      continue;
    }

    switch (var_2.script_noteworthy) {
      case "defender":
        level.spawn_defenders[level.spawn_defenders.size] = var_2;
        level.spawn_defenders_a[level.spawn_defenders_a.size] = var_2;
        level.spawn_defenders_b[level.spawn_defenders_b.size] = var_2;
        break;
      case "defender_a":
        level.spawn_defenders_a[level.spawn_defenders_a.size] = var_2;
        break;
      case "defender_b":
        level.spawn_defenders_b[level.spawn_defenders_b.size] = var_2;
        break;
      case "attacker":
        level.spawn_attackers[level.spawn_attackers.size] = var_2;
        level.spawn_attackers_a[level.spawn_attackers_a.size] = var_2;
        level.spawn_attackers_b[level.spawn_attackers_b.size] = var_2;
        break;
      case "attacker_a":
        level.spawn_attackers_a[level.spawn_attackers_a.size] = var_2;
        break;
      case "attacker_b":
        level.spawn_attackers_b[level.spawn_attackers_b.size] = var_2;
        break;
      default:
        spawnpointerror(var_2);
        break;
    }
  }

  if(maps\mp\_utility::is_true(level.dd_flip_respawns)) {
    var_4 = level.spawn_defenders;
    level.spawn_defenders = level.spawn_attackers;
    level.spawn_attackers = var_4;
    var_4 = level.spawn_defenders_a;
    level.spawn_defenders_a = level.spawn_attackers_a;
    level.spawn_attackers_a = var_4;
    var_4 = level.spawn_defenders_b;
    level.spawn_defenders_b = level.spawn_attackers_b;
    level.spawn_attackers_b = var_4;
  }

  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  level.aplanted = 0;
  level.bplanted = 0;
  setmapcenter(level.mapcenter);
}

spawnpointerror(var_0) {}

waittoprocess() {
  level endon("game_end");

  for (;;) {
    if(level.ingraceperiod == 0) {
      break;
    }

    wait 0.05;
  }

  level.usestartspawns = 0;
}

getspawnpoint() {
  var_0 = self.pers["team"];

  if(level.usestartspawns) {
    if(var_0 == game["attackers"])
      var_1 = maps\mp\gametypes\_spawnlogic::getrandomstartspawn("mp_dd_spawn_attacker_start");
    else
      var_1 = maps\mp\gametypes\_spawnlogic::getrandomstartspawn("mp_dd_spawn_defender_start");
  } else if(var_0 == game["attackers"]) {
    if(maps\mp\_utility::inovertime())
      var_2 = level.spawn_attackers;
    else if(!level.aplanted && !level.bplanted)
      var_2 = level.spawn_attackers;
    else if(level.aplanted && !level.bplanted)
      var_2 = level.spawn_attackers_a;
    else if(level.bplanted && !level.aplanted)
      var_2 = level.spawn_attackers_b;
    else
      var_2 = level.spawn_attackers;

    var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(var_2);
  } else {
    if(maps\mp\_utility::inovertime())
      var_2 = level.spawn_defenders;
    else if(!level.aplanted && !level.bplanted)
      var_2 = level.spawn_defenders;
    else if(level.aplanted && !level.bplanted)
      var_2 = level.spawn_defenders_a;
    else if(level.bplanted && !level.aplanted)
      var_2 = level.spawn_defenders_b;
    else
      var_2 = level.spawn_defenders;

    var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(var_2);
  }

  return var_1;
}

onspawnplayer() {
  if(maps\mp\_utility::inovertime() || self.pers["team"] == game["attackers"]) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 1;
  } else {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
  }

  self setclientomnvar("ui_carrying_bomb", self.isbombcarrier);
  maps\mp\_utility::setextrascore0(0);

  if(isdefined(self.pers["plants"]))
    maps\mp\_utility::setextrascore0(self.pers["plants"]);

  maps\mp\_utility::setextrascore1(0);

  if(isdefined(self.pers["defuses"]))
    maps\mp\_utility::setextrascore1(self.pers["defuses"]);

  level notify("spawned_player");
}

dd_endgame(var_0, var_1) {
  if(var_0 == "tie")
    level.finalkillcam_winner = "none";
  else
    level.finalkillcam_winner = var_0;

  thread maps\mp\gametypes\_gamelogic::endgame(var_0, var_1);
}

ondeadevent(var_0) {
  if(level.bombexploded || level.bombdefused) {
    return;
  }
  if(var_0 == "all") {
    if(level.bombplanted)
      dd_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
    else
      dd_endgame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
  } else if(var_0 == game["attackers"]) {
    if(level.bombplanted) {
      return;
    }
    level thread dd_endgame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
  } else if(var_0 == game["defenders"])
    level thread dd_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
}

onnormaldeath(var_0, var_1, var_2) {
  var_3 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
  var_4 = var_0.team;

  if(game["state"] == "postgame" && (var_0.team == game["defenders"] || !level.bombplanted))
    var_1.finalkill = 1;

  if(var_0.isplanting || var_0.isdefusing) {
    var_1 thread maps\mp\_events::defendobjectiveevent(var_0, var_2);

    if(var_0.isplanting)
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_interrupt");

    if(var_0.isdefusing)
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_protector");
  }
}

ontimelimit() {
  if(maps\mp\_utility::inovertime())
    dd_endgame("tie", game["end_reason"]["time_limit_reached"]);
  else
    dd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
}

updategametypedvars() {
  level.planttime = maps\mp\_utility::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = maps\mp\_utility::dvarintvalue("bombtimer", 45, 1, 300);
  level.ddtimetoadd = maps\mp\_utility::dvarfloatvalue("addtime", 2, 0, 5);
  level.silentplant = maps\mp\_utility::dvarintvalue("silentplant", 0, 0, 1);
}

verifybombzones(var_0) {
  var_1 = "";

  if(var_0.size != 3) {
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(issubstr(tolower(var_6.script_label), "a")) {
        var_2 = 1;
        continue;
      }

      if(issubstr(tolower(var_6.script_label), "b")) {
        var_3 = 1;
        continue;
      }

      if(issubstr(tolower(var_6.script_label), "c"))
        var_4 = 1;
    }

    if(!var_2)
      var_1 = var_1 + " A ";

    if(!var_3)
      var_1 = var_1 + " B ";

    if(!var_4)
      var_1 = var_1 + " C ";
  }

  if(var_1 != "")
    return;
}

bombs() {
  waittillframeend;
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  level.bombzones = [];
  var_0 = getentarray("dd_bombzone", "targetname");
  verifybombzones(var_0);

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_3 = getentarray(var_2.target, "targetname");
    var_4 = getent(var_3[0].target, "targetname");
    var_5 = var_2.script_label;
    var_6 = getent("dd_bombzone_clip" + var_5, "targetname");

    if(maps\mp\_utility::inovertime()) {
      if(var_5 == "_a" || var_5 == "_b") {
        var_2 delete();
        var_3[0] delete();
        var_4 delete();
        var_6 delete();
        continue;
      }

      var_2.script_label = "_a";
      var_7 = maps\mp\gametypes\common_bomb_gameobject::createbombzoneobject("neutral", "any", "any", var_2, level.ddbomb, 0);
      maps\mp\_utility::setmlgicons(var_7, "waypoint_targetneutral");
    } else {
      if(var_5 == "_c") {
        var_2 delete();
        var_3[0] delete();
        var_4 delete();
        var_6 delete();
        continue;
      }

      var_7 = maps\mp\gametypes\common_bomb_gameobject::createbombzoneobject(game["defenders"], "enemy", "any", var_2, level.ddbomb, 1);

      if(game["defenders"] == "allies")
        maps\mp\_utility::setmlgicons(var_7, "waypoint_esports_sab_target_axis");
      else
        maps\mp\_utility::setmlgicons(var_7, "waypoint_esports_sab_target_allies");
    }

    var_7.onbeginuse = ::onbeginuse;
    var_7.onenduse = ::onenduse;
    var_7.onuse = ::onuseobject;
    var_7.oncantuse = ::oncantuse;
    level.bombzones[level.bombzones.size] = var_7;
  }
}

onuseobject(var_0) {
  var_1 = var_0.pers["team"];
  var_2 = level.otherteam[var_1];

  if(maps\mp\_utility::inovertime() && self.bombplantedon == 0 || !maps\mp\_utility::inovertime() && !maps\mp\gametypes\_gameobjects::isfriendlyteam(var_0.pers["team"])) {
    var_0 maps\mp\gametypes\common_bomb_gameobject::onplayerplantbomb(0, var_1, var_2);

    if(game["defenders"] == "allies")
      maps\mp\_utility::setmlgicons(self, "waypoint_esports_sab_planted_axis");
    else
      maps\mp\_utility::setmlgicons(self, "waypoint_esports_sab_planted_allies");

    level thread bombplanted(self, var_0);
  } else {
    var_0 maps\mp\gametypes\common_bomb_gameobject::onplayerdefusebomb("defuse", var_1, var_2);

    if(game["defenders"] == "allies")
      maps\mp\_utility::setmlgicons(self, "waypoint_esports_sab_target_axis");
    else
      maps\mp\_utility::setmlgicons(self, "waypoint_esports_sab_target_allies");

    level thread bombdefused(self);
  }
}

onbeginuse(var_0) {
  if(maps\mp\_utility::inovertime() && self.bombplantedon == 1 || !maps\mp\_utility::inovertime() && maps\mp\gametypes\_gameobjects::isfriendlyteam(var_0.pers["team"])) {
    var_1 = var_0 getclosestbombmodel();
    maps\mp\gametypes\common_bomb_gameobject::onbegindefusebomb(var_0, var_1);
  } else
    maps\mp\gametypes\common_bomb_gameobject::onbeginplantbomb(var_0);
}

getclosestbombmodel() {
  var_0 = 9000000;
  var_1 = undefined;

  if(isdefined(level.ddbombmodel)) {
    foreach(var_3 in level.ddbombmodel) {
      if(!isdefined(var_3)) {
        continue;
      }
      var_4 = distancesquared(self.origin, var_3.origin);

      if(var_4 < var_0) {
        var_0 = var_4;
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

onenduse(var_0, var_1, var_2) {
  var_3 = isdefined(var_1) && var_1.isdefusing && !var_2;
  maps\mp\gametypes\common_bomb_gameobject::onendusebomb(var_1, var_3);
}

oncantuse(var_0) {
  var_0 iprintlnbold(&"MP_BOMBSITE_IN_USE");
}

onreset() {}

bombplanted(var_0, var_1) {
  var_0 endon("defused");
  level.bombsplanted = level.bombsplanted + 1;
  var_2 = var_1.team;
  setbombtimerdvar();
  level.bombplanted = 1;

  if(var_0.label == "_a")
    level.aplanted = 1;
  else
    level.bplanted = 1;

  dropbombmodel(var_1, var_0.label);

  if(maps\mp\_utility::inovertime())
    var_0 maps\mp\gametypes\_gameobjects::setownerteam(level.otherteam[var_1.team]);

  var_0 maps\mp\gametypes\common_bomb_gameobject::setupzonefordefusing(!maps\mp\_utility::inovertime());
  var_0 maps\mp\gametypes\common_bomb_gameobject::onbombplanted(level.ddbombmodel[var_0.label].origin + (0, 0, 1));
  var_0 bombtimerwait(var_0);
  maps\mp\_utility::setmlgicons(var_0, undefined);
  var_0.tickingobject maps\mp\gametypes\common_bomb_gameobject::stoptickingsound();
  level.bombsplanted = level.bombsplanted - 1;

  if(var_0.label == "_a")
    level.aplanted = 0;
  else
    level.bplanted = 0;

  var_0 restarttimer();
  var_0 setbombtimerdvar();
  setuibombtimer(var_0.label, 0);

  if(level.gameended) {
    return;
  }
  level notify("bomb_exploded" + var_0.label);
  level.bombexploded = level.bombexploded + 1;
  var_3 = var_0.curorigin;
  level.ddbombmodel[var_0.label] delete();
  var_0 maps\mp\gametypes\common_bomb_gameobject::onbombexploded(var_3, 200, var_1);
  var_0 maps\mp\gametypes\_gameobjects::disableobject();
  var_4 = 0;

  if(!maps\mp\_utility::inovertime() && level.bombexploded < 2 && level.ddtimetoadd > 0) {
    var_5 = maps\mp\_utility::gettimelimit();

    if(var_5 > 0) {
      maps\mp\_utility::setoverridewatchdvar("timelimit", maps\mp\_utility::getwatcheddvar("timelimit") + level.ddtimetoadd);

      foreach(var_7 in level.players)
      var_7 thread maps\mp\gametypes\_hud_message::splashnotify("time_added");

      var_4 = 1;
    }
  }

  var_9 = maps\mp\_utility::inovertime() || level.bombexploded > 1;

  if(var_9) {
    setgameendtime(0);
    level.timelimitoverride = 1;
  }

  wait 2;

  if(var_9)
    dd_endgame(var_2, game["end_reason"]["target_destroyed"]);
  else if(var_4)
    level thread maps\mp\_utility::teamplayercardsplash("callout_time_added", var_1);
}

setbombtimerdvar() {
  if(level.bombsplanted == 1)
    setomnvar("ui_bomb_timer", 2);
  else if(level.bombsplanted == 2)
    setomnvar("ui_bomb_timer", 3);
  else
    setomnvar("ui_bomb_timer", 0);
}

dropbombmodel(var_0, var_1) {
  var_2 = bullettrace(var_0.origin + (0, 0, 20), var_0.origin - (0, 0, 2000), 0, var_0);
  var_3 = randomfloat(360);
  var_4 = (cos(var_3), sin(var_3), 0);
  var_4 = vectornormalize(var_4 - var_2["normal"] * vectordot(var_4, var_2["normal"]));
  var_5 = vectortoangles(var_4);
  level.ddbombmodel[var_1] = spawn("script_model", var_2["position"]);
  level.ddbombmodel[var_1].angles = var_5;
  level.ddbombmodel[var_1] setmodel("wpn_h1_briefcase_bomb_npc");
}

restarttimer() {
  if(level.bombsplanted <= 0) {
    maps\mp\gametypes\_gamelogic::resumetimer();
    level.timepaused = gettime() - level.timepausestart;
    level.timelimitoverride = 0;
  }
}

bombtimerwait(var_0) {
  level endon("game_ended");
  level endon("bomb_defused" + var_0.label);

  if(maps\mp\_utility::inovertime())
    var_0.waittime = level.bombtimer;
  else
    var_0.waittime = level.bombtimer;

  level thread update_ui_timers(var_0);

  while (var_0.waittime >= 0) {
    var_0.waittime--;

    if(var_0.waittime >= 0)
      wait 1;

    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }
}

update_ui_timers(var_0) {
  level endon("game_ended");
  level endon("disconnect");
  level endon("bomb_defused" + var_0.label);
  level endon("bomb_exploded" + var_0.label);
  var_1 = var_0.waittime * 1000 + gettime();
  setuibombtimer(var_0.label, var_1);
  level waittill("host_migration_begin");
  var_2 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(var_2 > 0)
    setuibombtimer(var_0.label, var_1 + var_2);
}

bombdefused(var_0) {
  var_0.bombplantedon = 0;
  var_0 notify("defused");
  var_0.tickingobject maps\mp\gametypes\common_bomb_gameobject::stoptickingsound();
  level.bombsplanted = level.bombsplanted - 1;
  var_0 restarttimer();
  setbombtimerdvar();
  setuibombtimer(var_0.label, 0);
  level notify("bomb_defused" + var_0.label);
  level.ddbombmodel[var_0.label] delete();

  if(maps\mp\_utility::inovertime()) {
    var_0 maps\mp\gametypes\_gameobjects::setownerteam("neutral");
    var_0 maps\mp\gametypes\common_bomb_gameobject::resetbombzone(level.ddbomb, "any", "any", 0);
  } else
    var_0 maps\mp\gametypes\common_bomb_gameobject::resetbombzone(level.ddbomb, "enemy", "any", 1);
}

setuibombtimer(var_0, var_1) {
  if(var_0 == "_a")
    setomnvar("ui_bomb_timer_endtime", var_1);
  else
    setomnvar("ui_bomb_timer_endtime_2", var_1);
}