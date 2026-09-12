/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\pill.gsc
***********************************************/

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_pill_bankTime", getmatchrulesdata("pillData", "bankTime"));
  setdynamicdvar("scr_pill_bankRate", getmatchrulesdata("pillData", "bankRate"));
  setdynamicdvar("scr_pill_bankCaptureTime", getmatchrulesdata("pillData", "bankCaptureTime"));
  setdynamicdvar("scr_pill_megaBankLimit", getmatchrulesdata("pillData", "megaBankLimit"));
  setdynamicdvar("scr_pill_bankBonus", getmatchrulesdata("pillData", "megaBankBonus"));
  setdynamicdvar("scr_pill_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("grind", 0);
  setdynamicdvar("scr_pill_promode", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  scripts\mp\utility\game::setobjectivetext("allies", &"OBJECTIVES/WAR");
  scripts\mp\utility\game::setobjectivetext("axis", &"OBJECTIVES/WAR");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/WAR");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/WAR");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/WAR_SCORE");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/WAR_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext("allies", &"OBJECTIVES/WAR_HINT");
  scripts\mp\utility\game::setobjectivehinttext("axis", &"OBJECTIVES/WAR_HINT");
  initspawns();
  createtags();
  level.dogtagallyonusecb = &dogtagallyonusecb;
  scripts\mp\gametypes\br_pickups::initarrays();
  scripts\mp\gametypes\br_pickups::initpickupusability();
  spawnlootcaches();
  thread removetagsongameended();
  thread bankthink();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.banktime = scripts\mp\utility\dvars::dvarfloatvalue("bankTime", 2, 0, 10);
  level.bankrate = scripts\mp\utility\dvars::dvarintvalue("bankRate", 1, 1, 1000);
  level.bankcapturetime = scripts\mp\utility\dvars::dvarintvalue("bankCaptureTime", 0, 0, 10);
  level.megabanklimit = scripts\mp\utility\dvars::dvarintvalue("megaBankLimit", 5, 5, 15);
  level.megabankbonus = scripts\mp\utility\dvars::dvarintvalue("megaBankBonus", 150, 0, 750);
}

function onspawnplayer() {
  if(isDefined(self.tagscarried)) {
    self setclientomnvar("ui_pillage_currency", self.tagscarried);
    return;
  }
}

function createtags() {
  level.dogtags = [];

  for(var_0 = 0; var_0 < 30; var_0++) {
    var_1 = spawn("script_model", (0, 0, 0));
    var_1[0] setModel("military_dogtags_iw8_orange");
    var_1 = spawn("script_model", (0, 0, 0));
    var_1[1] setModel("military_dogtags_iw8_blue");
    var_1[0] scriptmodelplayanim("mp_dogtag_spin");
    var_1[1] scriptmodelplayanim("mp_dogtag_spin");
    var_1[0] hide();
    var_1[1] hide();
    var_1[0] setasgametypeobjective();
    var_1[1] setasgametypeobjective();
    var_2 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    var_2.targetname = "trigger_dogtag";
    var_2 hide();
    var_3 = spawnStruct();
    var_3.type = "useObject";
    var_3.curorigin = var_2.origin;
    var_3.entnum = var_2 getentitynumber();
    var_3.lastusedtime = 0;
    var_3.visuals = var_1;
    var_3.offset3d = (0, 0, 16);
    var_3.trigger = var_2;
    var_3.triggertype = "proximity";
    var_3 scripts\mp\gameobjects::allowuse("none");
    level.dogtags[level.dogtags.size] = var_3;
  }
}

function gettag() {
  var_0 = level.dogtags[0];
  var_1 = gettime();

  foreach(var_3 in level.dogtags) {
    if(!isDefined(var_3.lastusedtime)) {
      continue;
    }

    if(var_3.interactteam == "none") {
      var_0 = var_3;
      break;
    }

    if(var_3.lastusedtime < var_1) {
      var_1 = var_3.lastusedtime;
      var_0 = var_3;
    }
  }

  var_0 notify("reset");
  var_0 scripts\mp\gameobjects::initializetagpathvariables();
  var_0.lastusedtime = gettime();
  return var_0;
}

function spawntag(var_0, var_1) {
  var_2 = var_0 + (0, 0, 14);
  var_3 = (0, randomfloat(360), 0);
  var_4 = anglesToForward(var_3);
  var_5 = randomfloatrange(30, 150);
  var_6 = var_2 + var_5 * var_4;
  var_2 = playerphysicstrace(var_2, var_6);
  var_7 = gettag();
  var_7.curorigin = var_2;
  var_7.trigger.origin = var_2;
  var_7.visuals[0].origin = var_2;
  var_7.visuals[1].origin = var_2;
  var_7.trigger show();
  var_7 scripts\mp\gameobjects::allowuse("any");
  thread showtoteam(var_7.visuals[0], var_7);
  thread showtoteam(var_7.visuals[1], var_7);
  var_7.visuals[0] setasgametypeobjective();
  var_7.visuals[1] setasgametypeobjective();
  playsoundatpos(var_2, "mp_grind_token_drop");
  return var_7;
}

function showtoteam(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("reset");
  self hide();

  foreach(var_3 in level.players) {
    if(playercanusetags(var_3)) {
      if(var_3.team == var_1) {
        self showtoplayer(var_3);
      }

      if(var_3.team == "spectator" && var_1 == "allies") {
        self showtoplayer(var_3);
      }
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_3 in level.players) {
      if(playercanusetags(var_3)) {
        if(var_3.team == var_1) {
          self showtoplayer(var_3);
        }
      }

      if(var_3.team == "spectator" && var_1 == "allies") {
        self showtoplayer(var_3);
      }

      if(var_0.victimteam == var_3.team && var_3 == var_0.attacker) {
        scripts\mp\objidpoolmanager::update_objective_state(var_0.objid, "invisible");
      }
    }
  }
}

function playercanusetags(var_0) {
  return true;
}

function monitortaguse(var_0) {
  level endon("game_ended");
  var_0 endon("deleted");
  var_0 endon("reset");

  for(;;) {
    var_0.trigger waittill("trigger", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }

    if(var_1 scripts\mp\utility\player::isusingremote() || isDefined(var_1.spawningafterremotedeath)) {
      continue;
    }

    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }

    if(isagent(var_1) && isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }

    var_0.visuals[0] hide();
    var_0.visuals[1] hide();
    var_0.trigger hide();
    var_0.curorigin = (0, 0, 1000);
    var_0.trigger.origin = (0, 0, 1000);
    var_0.visuals[0].origin = (0, 0, 1000);
    var_0.visuals[1].origin = (0, 0, 1000);
    var_0 scripts\mp\gameobjects::allowuse("none");

    if(var_0.team != var_1.team) {
      playersettagcount(var_1, var_1.tagscarried + 1);
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("tag_collected");
    }

    var_1 playSound("mp_killconfirm_tags_pickup");

    if(isDefined(level.supportcranked) && level.supportcranked) {
      if(isDefined(var_1.cranked) && var_1.cranked) {
        var_1 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
      } else {
        var_1 scripts\mp\cranked::oncranked(undefined, var_1);
      }
    }

    playsoundatpos(var_1.origin, "mp_grind_token_pickup");
    break;
  }
}

function onplayerconnect(var_0) {
  var_0.isscoring = 0;
  thread monitorjointeam();
}

function playersettagcount(var_0) {
  self.tagscarried = var_0;
  self.game_extrainfo = var_0;
  self setclientomnvar("ui_pillage_currency", var_0);
}

function monitorjointeam() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::ref_143A5("joined_team", "joined_spectators");
    playersettagcount(0);
  }
}

function hidehudelementongameend(var_0) {
  level waittill("game_ended");

  if(isDefined(var_0)) {
    var_0.alpha = 0;
    return;
  }
}

function createzones() {
  var_0 = getEntArray("grind_location", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\mp\gametypes\obj_grindzone::setupobjective(var_2);
    thread runzonethink();
    level.objectives[var_3.objectivekey] = var_3;
  }
}

function isinzone(var_0, var_1) {
  if(scripts\mp\utility\player::isreallyalive(var_0) && var_0 istouching(var_1.trigger) && var_1.ownerteam == var_0.team) {
    return true;
  }

  return false;
}

function runzonethink() {
  level endon("game_ended");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(self.stalemate) {
      continue;
    }

    if(isagent(var_0)) {
      continue;
    }

    if(!isPlayer(var_0)) {
      continue;
    }

    if(var_0.isscoring) {
      continue;
    }

    var_0.isscoring = 1;
    thread processscoring(level, var_0);
  }
}

function removetagsongameended() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(!isDefined(var_1.tagscarried)) {
      continue;
    }

    var_1.tagscarried = 0;
  }
}

function processscoring(var_0, var_1) {
  while(var_0.tagscarried && isinzone(var_0, var_1) && !var_1.stalemate) {
    var_0 playsoundtoplayer("mp_grind_token_banked", var_0);
    var_2 = level.bankrate;

    if(var_2 > var_0.tagscarried) {
      var_2 = var_0.tagscarried;
    }

    scoreamount(var_0, var_2);

    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_0 thread scripts\mp\utility\points::giveunifiedpoints("tag_score");
    }

    if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked) {
      var_0 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
    }

    wait level.banktime;
  }

  var_1 scripts\mp\gametypes\obj_grindzone::setneutralicons();
  var_0.isscoring = 0;
}

function scoreamount(var_0, var_1) {
  playersettagcount(var_0, var_0.tagscarried - var_1);
  scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, var_1, 0);
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("normal_allies", "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::registerspawnset("normal_axis", "mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("fallback", "mp_tdm_spawn_secondary");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else if(var_2 == "allies") {
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_2, "normal_allies", "fallback");
  } else {
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_2, "normal_axis", "fallback");
  }

  return var_2;
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(level.flashpointactive)) {
    scripts\mp\flashpoint::flashpoint_processnewevent(var_1, var_0, gettime(), "kill_by_" + var_1.team);
  }

  var_0 scripts\mp\gametypes\plunder::playersettagcount(var_0.tagscarried + 1000);
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

function droptags(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }

  if(var_0.tagscarried > 9) {
    var_2 = 10;
  } else if(var_1.tagscarried > 0) {
    var_2 = var_1.tagscarried;
  } else {
    var_2 = 0;
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = spawntag(var_2.origin, var_2.team);
    var_4.team = var_2.team;
    var_4.victim = var_2;
    var_4.attacker = var_2;
    level notify("new_tag_spawned", var_4);
    thread monitortaguse(level);
  }

  var_5 = var_2.tagscarried - var_2;
  var_5 = int(max(0, var_5));
  playersettagcount(var_2, var_5);
}

function dogtagallyonusecb(var_0) {}

function removepoint() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devRemoveDomFlag", "") != "") {
      var_0 = getDvar("scr_devRemoveDomFlag", "");

      foreach(var_2 in level.objectives) {
        if(isDefined(var_2.objectivekey) && var_2.objectivekey == var_0) {
          var_2 notify("stop_trigger" + var_2.objectivekey);
          var_2 scripts\mp\gameobjects::allowuse("none");
          var_2.trigger = undefined;
          var_2 notify("deleted");
          var_2.visibleteam = "none";
          var_2 scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
          var_3 = [];

          foreach(var_5 in level.objectives) {
            if(var_5.objectivekey != var_0) {
              var_3 = var_5;
            }
          }

          level.objectives = var_3;
          break;
        }
      }

      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait 1;
  }
}

function placepoint() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devPlaceDomFlag", "") != "") {
      var_0 = getDvar("scr_devPlaceDomFlag", "");
      var_1 = undefined;
      var_2 = getEntArray("grind_location", "targetname");

      foreach(var_4 in var_2) {
        if("_" + var_4.script_label == var_0) {
          var_1 = var_4;
        }
      }

      var_1.origin = level.players[0].origin;
      var_1.ownerteam = "neutral";
      var_6 = var_1.origin + (0, 0, 32);
      var_7 = var_1.origin + (0, 0, -32);
      var_8 = scripts\engine\trace::ray_trace(var_6, var_7, undefined, scripts\engine\trace::create_default_contents(1));
      var_1.origin = var_8["position"];
      var_1.upangles = vectortoangles(var_8["normal"]);
      var_1.forward = anglesToForward(var_1.upangles);
      var_1.right = anglestoright(var_1.upangles);
      GscBinSkip1(0x45, 0, spawn("script_model", var_1.origin));
    }

    wait 1;
  }
}

function spawnlootcaches() {
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  var_0 = scripts\engine\utility::getStructArray("pillage_cache_spawn", "targetname");
  var_1 = int(100 * var_0.size / 100);
  var_0 = scripts\engine\utility::array_randomize(var_0);
  level.currencycaches = [];

  for(var_2 = 0; var_2 < var_1; var_2++) {
    spawnlootcache(var_0[var_2]);
  }
}

function spawnlootcache(var_0) {
  var_1 = scripts\mp\gametypes\br_pickups::spawnpickup("Pillage_Cache", var_0.origin + level.br_pickups.br_dropoffsets[0], (0, 0, 0));
}

function givetagsfromcache() {
  scripts\mp\gametypes\plunder::playersettagcount(self.tagscarried + 1000);
}

function bankthink() {
  self endon("game_ended");
  var_0 = getEntArray("grind_location", "targetname");
  wait 5;
  var_1 = [];
  var_2 = [];

  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_3 = 0;
    var_4 = 0;

    while(var_3 < 1) {
      foreach(var_4, var_6 in var_0) {
        if(var_3 == 1) {
          break;
        }

        if((!isDefined(var_6.inuse) || !var_6.inuse) && (!isDefined(var_6.usedlastphase) || !var_6.usedlastphase)) {
          var_7 = scripts\mp\gametypes\obj_grindzone::setupobjective(var_0[var_4]);
          var_7 scripts\mp\gameobjects::allowuse("any");
          var_7 scripts\mp\gameobjects::setvisibleteam("any");
          scripts\mp\objidpoolmanager::objective_set_play_intro(var_7.objidnum, 0);
          var_7.lockupdatingicons = 0;
          var_7 scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_generic");
          var_7.lockupdatingicons = 1;
          objective_setlabel(var_7.objidnum, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          objective_setneutrallabel(var_7.objidnum, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          objective_setfriendlylabel(var_7.objidnum, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          objective_setenemylabel(var_7.objidnum, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          thread runzonethink();
          var_1 = var_7;
          var_7.sourcetrigger = var_6;
          var_6.inuse = 1;
          var_3++;
        }
      }

      if(var_3 < 1) {
        foreach(var_6 in var_0) {
          var_6.usedlastphase = 0;
        }
      }
    }

    wait 5;

    foreach(var_6 in var_1) {
      var_6 scripts\mp\gameobjects::allowuse("none");
      var_6 scripts\mp\gameobjects::setvisibleteam("none");
      var_6 scripts\mp\gameobjects::releaseid();
      var_6.visibleteam = "none";
      var_6.scriptable delete();
      var_6.sourcetrigger.usedlastphase = 1;
      var_6.sourcetrigger.inuse = 0;
    }

    var_1 = [];
    wait 5;
  }
}