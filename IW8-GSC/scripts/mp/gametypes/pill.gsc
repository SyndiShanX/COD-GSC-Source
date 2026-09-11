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

  for(var0 = 0; var0 < 30; var0++) {
    var1 = spawn("script_model", (0, 0, 0));
    var1[0] setModel("military_dogtags_iw8_orange");
    var1 = spawn("script_model", (0, 0, 0));
    var1[1] setModel("military_dogtags_iw8_blue");
    var1[0] scriptmodelplayanim("mp_dogtag_spin");
    var1[1] scriptmodelplayanim("mp_dogtag_spin");
    var1[0] hide();
    var1[1] hide();
    var1[0] setasgametypeobjective();
    var1[1] setasgametypeobjective();
    var2 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    var2.targetname = "trigger_dogtag";
    var2 hide();
    var3 = spawnStruct();
    var3.type = "useObject";
    var3.curorigin = var2.origin;
    var3.entnum = var2 getentitynumber();
    var3.lastusedtime = 0;
    var3.visuals = var1;
    var3.offset3d = (0, 0, 16);
    var3.trigger = var2;
    var3.triggertype = "proximity";
    var3 scripts\mp\gameobjects::allowuse("none");
    level.dogtags[level.dogtags.size] = var3;
  }
}

function gettag() {
  var0 = level.dogtags[0];
  var1 = gettime();

  foreach(var3 in level.dogtags) {
    if(!isDefined(var3.lastusedtime)) {
      continue;
    }

    if(var3.interactteam == "none") {
      var0 = var3;
      break;
    }

    if(var3.lastusedtime < var1) {
      var1 = var3.lastusedtime;
      var0 = var3;
    }
  }

  var0 notify("reset");
  var0 scripts\mp\gameobjects::initializetagpathvariables();
  var0.lastusedtime = gettime();
  return var0;
}

function spawntag(var0, var1) {
  var2 = var0 + (0, 0, 14);
  var3 = (0, randomfloat(360), 0);
  var4 = anglesToForward(var3);
  var5 = randomfloatrange(30, 150);
  var6 = var2 + var5 * var4;
  var2 = playerphysicstrace(var2, var6);
  var7 = gettag();
  var7.curorigin = var2;
  var7.trigger.origin = var2;
  var7.visuals[0].origin = var2;
  var7.visuals[1].origin = var2;
  var7.trigger show();
  var7 scripts\mp\gameobjects::allowuse("any");
  thread showtoteam(var7.visuals[0], var7);
  thread showtoteam(var7.visuals[1], var7);
  var7.visuals[0] setasgametypeobjective();
  var7.visuals[1] setasgametypeobjective();
  playsoundatpos(var2, "mp_grind_token_drop");
  return var7;
}

function showtoteam(var0, var1) {
  var0 endon("death");
  var0 endon("reset");
  self hide();

  foreach(var3 in level.players) {
    if(playercanusetags(var3)) {
      if(var3.team == var1) {
        self showtoplayer(var3);
      }

      if(var3.team == "spectator" && var1 == "allies") {
        self showtoplayer(var3);
      }
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var3 in level.players) {
      if(playercanusetags(var3)) {
        if(var3.team == var1) {
          self showtoplayer(var3);
        }
      }

      if(var3.team == "spectator" && var1 == "allies") {
        self showtoplayer(var3);
      }

      if(var0.victimteam == var3.team && var3 == var0.attacker) {
        scripts\mp\objidpoolmanager::update_objective_state(var0.objid, "invisible");
      }
    }
  }
}

function playercanusetags(var0) {
  return true;
}

function monitortaguse(var0) {
  level endon("game_ended");
  var0 endon("deleted");
  var0 endon("reset");

  for(;;) {
    var0.trigger waittill("trigger", var1);

    if(!scripts\mp\utility\player::isreallyalive(var1)) {
      continue;
    }

    if(var1 scripts\mp\utility\player::isusingremote() || isDefined(var1.spawningafterremotedeath)) {
      continue;
    }

    if(isDefined(var1.classname) && var1.classname == "script_vehicle") {
      continue;
    }

    if(isagent(var1) && isDefined(var1.owner)) {
      var1 = var1.owner;
    }

    var0.visuals[0] hide();
    var0.visuals[1] hide();
    var0.trigger hide();
    var0.curorigin = (0, 0, 1000);
    var0.trigger.origin = (0, 0, 1000);
    var0.visuals[0].origin = (0, 0, 1000);
    var0.visuals[1].origin = (0, 0, 1000);
    var0 scripts\mp\gameobjects::allowuse("none");

    if(var0.team != var1.team) {
      playersettagcount(var1, var1.tagscarried + 1);
      var1 thread scripts\mp\utility\points::giveunifiedpoints("tag_collected");
    }

    var1 playSound("mp_killconfirm_tags_pickup");

    if(isDefined(level.supportcranked) && level.supportcranked) {
      if(isDefined(var1.cranked) && var1.cranked) {
        var1 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
      } else {
        var1 scripts\mp\cranked::oncranked(undefined, var1);
      }
    }

    playsoundatpos(var1.origin, "mp_grind_token_pickup");
    break;
  }
}

function onplayerconnect(var0) {
  var0.isscoring = 0;
  thread monitorjointeam();
}

function playersettagcount(var0) {
  self.tagscarried = var0;
  self.game_extrainfo = var0;
  self setclientomnvar("ui_pillage_currency", var0);
}

function monitorjointeam() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
    playersettagcount(0);
  }
}

function hidehudelementongameend(var0) {
  level waittill("game_ended");

  if(isDefined(var0)) {
    var0.alpha = 0;
    return;
  }
}

function createzones() {
  var0 = getEntArray("grind_location", "targetname");

  foreach(var2 in var0) {
    var3 = scripts\mp\gametypes\obj_grindzone::setupobjective(var2);
    thread runzonethink();
    level.objectives[var3.objectivekey] = var3;
  }
}

function isinzone(var0, var1) {
  if(scripts\mp\utility\player::isreallyalive(var0) && var0 istouching(var1.trigger) && var1.ownerteam == var0.team) {
    return true;
  }

  return false;
}

function runzonethink() {
  level endon("game_ended");

  for(;;) {
    self.trigger waittill("trigger", var0);

    if(self.stalemate) {
      continue;
    }

    if(isagent(var0)) {
      continue;
    }

    if(!isPlayer(var0)) {
      continue;
    }

    if(var0.isscoring) {
      continue;
    }

    var0.isscoring = 1;
    thread processscoring(level, var0);
  }
}

function removetagsongameended() {
  level waittill("game_ended");

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    if(!isDefined(var1.tagscarried)) {
      continue;
    }

    var1.tagscarried = 0;
  }
}

function processscoring(var0, var1) {
  while(var0.tagscarried && isinzone(var0, var1) && !var1.stalemate) {
    var0 playsoundtoplayer("mp_grind_token_banked", var0);
    var2 = level.bankrate;

    if(var2 > var0.tagscarried) {
      var2 = var0.tagscarried;
    }

    scoreamount(var0, var2);

    for(var3 = 0; var3 < var2; var3++) {
      var0 thread scripts\mp\utility\points::giveunifiedpoints("tag_score");
    }

    if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var0.cranked) && var0.cranked) {
      var0 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
    }

    wait level.banktime;
  }

  var1 scripts\mp\gametypes\obj_grindzone::setneutralicons();
  var0.isscoring = 0;
}

function scoreamount(var0, var1) {
  playersettagcount(var0, var0.tagscarried - var1);
  scripts\mp\gamescore::giveteamscoreforobjective(var0.team, var1, 0);
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
  var0 = self.pers["team"];

  if(game["switchedsides"]) {
    var0 = scripts\mp\utility\game::getotherteam(var0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var0 + "_start");
    var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
  } else if(var2 == "allies") {
    var2 = scripts\mp\spawnlogic::getspawnpoint(self, var2, "normal_allies", "fallback");
  } else {
    var2 = scripts\mp\spawnlogic::getspawnpoint(self, var2, "normal_axis", "fallback");
  }

  return var2;
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  if(istrue(level.flashpointactive)) {
    scripts\mp\flashpoint::flashpoint_processnewevent(var1, var0, gettime(), "kill_by_" + var1.team);
  }

  var0 scripts\mp\gametypes\plunder::playersettagcount(var0.tagscarried + 1000);
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
}

function droptags(var0, var1) {
  if(isagent(var0)) {
    return;
  }

  if(var0.tagscarried > 9) {
    var2 = 10;
  } else if(var1.tagscarried > 0) {
    var2 = var1.tagscarried;
  } else {
    var2 = 0;
  }

  for(var3 = 0; var3 < var2; var3++) {
    var4 = spawntag(var2.origin, var2.team);
    var4.team = var2.team;
    var4.victim = var2;
    var4.attacker = var2;
    level notify("new_tag_spawned", var4);
    thread monitortaguse(level);
  }

  var5 = var2.tagscarried - var2;
  var5 = int(max(0, var5));
  playersettagcount(var2, var5);
}

function dogtagallyonusecb(var0) {}

function removepoint() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devRemoveDomFlag", "") != "") {
      var0 = getDvar("scr_devRemoveDomFlag", "");

      foreach(var2 in level.objectives) {
        if(isDefined(var2.objectivekey) && var2.objectivekey == var0) {
          var2 notify("stop_trigger" + var2.objectivekey);
          var2 scripts\mp\gameobjects::allowuse("none");
          var2.trigger = undefined;
          var2 notify("deleted");
          var2.visibleteam = "none";
          var2 scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
          var3 = [];

          foreach(var5 in level.objectives) {
            if(var5.objectivekey != var0) {
              var3 = var5;
            }
          }

          level.objectives = var3;
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
      var0 = getDvar("scr_devPlaceDomFlag", "");
      var1 = undefined;
      var2 = getEntArray("grind_location", "targetname");

      foreach(var4 in var2) {
        if("_" + var4.script_label == var0) {
          var1 = var4;
        }
      }

      var1.origin = level.players[0].origin;
      var1.ownerteam = "neutral";
      var6 = var1.origin + (0, 0, 32);
      var7 = var1.origin + (0, 0, -32);
      var8 = scripts\engine\trace::ray_trace(var6, var7, undefined, scripts\engine\trace::create_default_contents(1));
      var1.origin = var8["position"];
      var1.upangles = vectortoangles(var8["normal"]);
      var1.forward = anglesToForward(var1.upangles);
      var1.right = anglestoright(var1.upangles);
      GscBinSkip1(0x45, 0, spawn("script_model", var1.origin));
    }

    wait 1;
  }
}

function spawnlootcaches() {
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  var0 = scripts\engine\utility::getStructArray("pillage_cache_spawn", "targetname");
  var1 = int(100 * var0.size / 100);
  var0 = scripts\engine\utility::array_randomize(var0);
  level.currencycaches = [];

  for(var2 = 0; var2 < var1; var2++) {
    spawnlootcache(var0[var2]);
  }
}

function spawnlootcache(var0) {
  var1 = scripts\mp\gametypes\br_pickups::spawnpickup("Pillage_Cache", var0.origin + level.br_pickups.br_dropoffsets[0], (0, 0, 0));
}

function givetagsfromcache() {
  scripts\mp\gametypes\plunder::playersettagcount(self.tagscarried + 1000);
}

function bankthink() {
  self endon("game_ended");
  var0 = getEntArray("grind_location", "targetname");
  wait 5;
  var1 = [];
  var2 = [];

  for(;;) {
    var0 = scripts\engine\utility::array_randomize(var0);
    var3 = 0;
    var4 = 0;

    while(var3 < 1) {
      foreach(var4, var6 in var0) {
        if(var3 == 1) {
          break;
        }

        if((!isDefined(var6.inuse) || !var6.inuse) && (!isDefined(var6.usedlastphase) || !var6.usedlastphase)) {
          var7 = scripts\mp\gametypes\obj_grindzone::setupobjective(var0[var4]);
          var7 scripts\mp\gameobjects::allowuse("any");
          var7 scripts\mp\gameobjects::setvisibleteam("any");
          scripts\mp\objidpoolmanager::objective_set_play_intro(var7.objidnum, 0);
          var7.lockupdatingicons = 0;
          var7 scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_generic");
          var7.lockupdatingicons = 1;
          objective_setlabel(var7.objidnum, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          objective_setneutrallabel(var7.objidnum, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          objective_setfriendlylabel(var7.objidnum, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          objective_setenemylabel(var7.objidnum, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          thread runzonethink();
          var1 = var7;
          var7.sourcetrigger = var6;
          var6.inuse = 1;
          var3++;
        }
      }

      if(var3 < 1) {
        foreach(var6 in var0) {
          var6.usedlastphase = 0;
        }
      }
    }

    wait 5;

    foreach(var6 in var1) {
      var6 scripts\mp\gameobjects::allowuse("none");
      var6 scripts\mp\gameobjects::setvisibleteam("none");
      var6 scripts\mp\gameobjects::releaseid();
      var6.visibleteam = "none";
      var6.scriptable delete();
      var6.sourcetrigger.usedlastphase = 1;
      var6.sourcetrigger.inuse = 0;
    }

    var1 = [];
    wait 5;
  }
}