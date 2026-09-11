/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\hvt.gsc
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
  setdynamicdvar("scr_hvt_maxTargets", getmatchrulesdata("hvtData", "hvtMaxTargets"));
  setdynamicdvar("scr_hvt_captureValue", getmatchrulesdata("hvtData", "hvtCaptureValue"));
  setdynamicdvar("scr_war_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("scr_war_promode", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/WAR");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/WAR_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"OBJECTIVES/WAR_HINT");
  }

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  initspawns();
  scripts\mp\gametypes\bradley_spawner::inittankspawns();
  level.activehvts = [];
  thread watchhvts();
}

function resethvtstatus() {
  if(scripts\engine\utility::array_contains(level.activehvts, self)) {
    level.activehvts = scripts\engine\utility::array_remove(level.activehvts, self);
    return;
  }
}

function laststand_hack() {
  returnheadicons();
  level.activehvts = scripts\engine\utility::array_remove(level.activehvts, self);
  self setclientomnvar("ui_hvt_status", 0);
  thread showvalueincreasesplash("hvt_rank_demoted");
  scripts\mp\rank::scoreeventpopup("hvt_demoted");
}

function ref_134d4(var_0, var_1) {
  if(var_0.tagscarried == var_1.tagscarried) {
    var_2 = scripts\engine\utility::array_contains(level.activehvts, var_0);
    return var_2;
  }

  return var_1.tagscarried > var_2.tagscarried;
}

function ref_13a27() {
  self setclientomnvar("ui_hvt_value", self.tagscarried);
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(var_3.team == "allies") {
      var_0 += var_3.tagscarried;
      continue;
    }

    if(var_3.team == "axis") {
      var_1 += var_3.tagscarried;
    }
  }

  scripts\mp\gamescore::_setteamscore("allies", var_0);
  scripts\mp\gamescore::_setteamscore("axis", var_1);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.hvtcapturevalue = scripts\mp\utility\dvars::dvarintvalue("hvtCaptureValue", 5, 0, 50);
  level.hvtmaxtargets = scripts\mp\utility\dvars::dvarintvalue("hvtMaxTargets", 3, 1, 10);

  if(getmaxclients() < 21) {
    level.hvtmaxtargets = 1;
    return;
  }
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(isDefined(level.localeid)) {
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var_0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var_1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var_2);
  scripts\mp\spawnlogic::registerspawnset("fallback", var_3);
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
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal");
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_2, undefined, "fallback");
  }

  return var_2;
}

function showvalueincreasesplash(var_0, var_1) {
  self endon("disconnect");

  if(self.team == "spectator") {
    return;
  }

  thread scripts\mp\hud_message::showsplash(var_0, var_1);
}

function ishvt() {
  if(!isDefined(level.activehvts)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(level.activehvts, self);
}

function becomehvt() {
  if(!isDefined(self.objidnumfriend)) {
    addhvtheadicons();
  }

  thread showvalueincreasesplash("hvt_rank_up_1", 1);
  scripts\mp\rank::scoreeventpopup("hvt_status");
  self setclientomnvar("ui_hvt_status", 1);
  scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_nodepth_orange", 0);
  level.activehvts[level.activehvts.size] = self;
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(ishvt()) {
    var_1 scripts\mp\rank::scoreeventpopup("hvt_kill");
  }

  var_10 = self getentitynumber();

  if(isDefined(level.outlinedplayers[var_10])) {
    scripts\mp\utility\outline::outlinedisable(self.outlineidfriend, self);
    scripts\mp\utility\outline::outlinedisable(self.outlineidenemy, self);
    self.outlineidfriend = undefined;
    self.outlineidenemy = undefined;
    level.outlinedplayers[var_10] = undefined;
  }

  if(self.team == "allies" || self.team == "axis") {
    scripts\mp\gamescore::giveteamscoreforobjective(self.team, self.tagscarried * -1);
    return;
  }
}

function returnheadicons() {
  if(isDefined(self.objidnumfriend)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnumfriend);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnumenemy);
    self.objidnumfriend = undefined;
    self.objidnumenemy = undefined;
    scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
    return;
  }
}

function ontimelimit() {
  var_0 = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if("tie") {
    var_0 = "overtime";
  }

  thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["time_limit_reached"]);
}

function onplayerspawned() {
  self.tagscarried = 0;

  foreach(var_1 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(var_1 != self && isDefined(var_1.objidnumfriend)) {
      objective_addclienttomask(var_1.objidnumfriend, self);
    }
  }

  if(ishvt()) {
    laststand_hack();
    return;
  }
}

function onplayerdisconnect(var_0) {
  resethvtstatus(var_0);
  returnheadicons(var_0);
}

function watchhvts() {
  level endon("game_ended");
  level.outlinedplayers = [];

  for(;;) {
    var_0 = scripts\engine\utility::array_sort_with_func(level.players, &ref_134d4);
    var_1 = int(min(var_0.size, level.hvtmaxtargets));
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];

      if(!ishvt(var_4) && var_4.team != "spectator" && var_4.tagscarried >= 10) {
        becomehvt(var_4);
        var_4.vehicle_occupancy_mp_showcashbag = 1;
      }

      var_2++;

      if(var_2 == level.hvtmaxtargets) {
        break;
      }
    }

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];

      if(ishvt(var_4)) {
        if(isDefined(var_4.vehicle_occupancy_mp_showcashbag)) {
          var_4.vehicle_occupancy_mp_showcashbag = undefined;
          var_1--;
          continue;
        }

        if(var_1 > 0) {
          var_1--;
          continue;
        }

        laststand_hack(var_4);
      }
    }

    foreach(var_6 in level.players) {
      var_7 = var_6 getentitynumber();
      var_8 = var_6.pers["team"];

      if(var_8 == "allies") {
        var_9 = "axis";
      } else {
        var_9 = "allies";
      }

      if(isalive(var_6) && istrue(ishvt(var_6))) {
        if(!isDefined(level.outlinedplayers[var_7])) {
          level.outlinedplayers[var_7] = var_6;
          var_6.outlineidfriend = scripts\mp\utility\outline::outlineenableforteam(var_6, var_8, "outline_nodepth_green", "level_script");
          var_6.outlineidenemy = scripts\mp\utility\outline::outlineenableforteam(var_6, var_9, "outline_nodepth_red", "level_script");
        }

        continue;
      }

      if(isDefined(level.outlinedplayers[var_7])) {
        scripts\mp\utility\outline::outlinedisable(var_6.outlineidfriend, var_6);
        scripts\mp\utility\outline::outlinedisable(var_6.outlineidenemy, var_6);
        var_6.outlineidfriend = undefined;
        var_6.outlineidenemy = undefined;
        level.outlinedplayers[var_7] = undefined;
      }
    }

    waitframe();
  }
}

function addhvtheadicons() {
  self.curorigin = self.origin;
  self.offset3d = (0, 0, 24);
  self.objidnumfriend = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var_0 = self.objidnumfriend;
  objective_setzoffset(var_0, 90);
  objective_icon(var_0, "hud_icon_frontline_shield_hvt");
  objective_setplayintro(var_0, 1);
  objective_removeallfrommask(var_0);

  foreach(var_2 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(var_2 != self) {
      objective_addclienttomask(var_0, var_2);
    }
  }

  objective_showtoplayersinmask(var_0);
  objective_setbackground(var_0, 0);
  objective_position(var_0, self getEye() + self.offset3d);
  objective_state(var_0, "current");
  objective_setownerteam(var_0, self.team);
  self.objidnumenemy = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var_0 = self.objidnumenemy;
  objective_setzoffset(var_0, 90);
  objective_icon(var_0, "hud_icon_death_spawn");
  objective_setplayintro(var_0, 1);
  scripts\mp\objidpoolmanager::objective_teammask_single(var_0, scripts\mp\utility\game::getotherteam(self.team)[0]);
  objective_setownerteam(var_0, self.team);
  objective_setbackground(var_0, 0);
  objective_position(var_0, self getEye() + self.offset3d);
  objective_state(var_0, "current");
  thread updatetargetlocation();
}

function updatetargetlocation() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("endUpdateHVTObjPos");
  self endon("endUpdateHVTObjPos");

  if(!isDefined(level.objpingdelay)) {
    level.objpingdelay = 3;
  }

  for(;;) {
    if(!isDefined(self.objidnumfriend)) {
      return;
    }

    if(self.health > 0) {
      var_0 = self getEye() + self.offset3d;
      scripts\mp\objidpoolmanager::update_objective_position(self.objidnumfriend, var_0);
      scripts\mp\objidpoolmanager::update_objective_position(self.objidnumenemy, var_0);
      objective_ping(self.objidnumfriend);
      objective_ping(self.objidnumenemy);
    } else {
      returnheadicons();
    }

    waitframe();
  }
}

function revivetriggerspawned() {}