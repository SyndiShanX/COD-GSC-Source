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
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
  }

  foreach(var3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var3, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/WAR");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/WAR_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var3, &"OBJECTIVES/WAR_HINT");
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

function ref_134d4(var0, var1) {
  if(var0.tagscarried == var1.tagscarried) {
    var2 = scripts\engine\utility::array_contains(level.activehvts, var0);
    return var2;
  }

  return var1.tagscarried > var2.tagscarried;
}

function ref_13a27() {
  self setclientomnvar("ui_hvt_value", self.tagscarried);
  var0 = 0;
  var1 = 0;

  foreach(var3 in level.players) {
    if(var3.team == "allies") {
      var0 += var3.tagscarried;
      continue;
    }

    if(var3.team == "axis") {
      var1 += var3.tagscarried;
    }
  }

  scripts\mp\gamescore::_setteamscore("allies", var0);
  scripts\mp\gamescore::_setteamscore("axis", var1);
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  var3 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var2);
  scripts\mp\spawnlogic::registerspawnset("fallback", var3);
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
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal");
    var2 = scripts\mp\spawnlogic::getspawnpoint(self, var2, undefined, "fallback");
  }

  return var2;
}

function showvalueincreasesplash(var0, var1) {
  self endon("disconnect");

  if(self.team == "spectator") {
    return;
  }

  thread scripts\mp\hud_message::showsplash(var0, var1);
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

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(ishvt()) {
    var1 scripts\mp\rank::scoreeventpopup("hvt_kill");
  }

  var10 = self getentitynumber();

  if(isDefined(level.outlinedplayers[var10])) {
    scripts\mp\utility\outline::outlinedisable(self.outlineidfriend, self);
    scripts\mp\utility\outline::outlinedisable(self.outlineidenemy, self);
    self.outlineidfriend = undefined;
    self.outlineidenemy = undefined;
    level.outlinedplayers[var10] = undefined;
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
  var0 = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime") {
    var0 = "forfeit";
  } else if("tie") {
    var0 = "overtime";
  }

  thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["time_limit_reached"]);
}

function onplayerspawned() {
  self.tagscarried = 0;

  foreach(var1 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(var1 != self && isDefined(var1.objidnumfriend)) {
      objective_addclienttomask(var1.objidnumfriend, self);
    }
  }

  if(ishvt()) {
    laststand_hack();
    return;
  }
}

function onplayerdisconnect(var0) {
  resethvtstatus(var0);
  returnheadicons(var0);
}

function watchhvts() {
  level endon("game_ended");
  level.outlinedplayers = [];

  for(;;) {
    var0 = scripts\engine\utility::array_sort_with_func(level.players, &ref_134d4);
    var1 = int(min(var0.size, level.hvtmaxtargets));
    var2 = 0;

    for(var3 = 0; var3 < var0.size; var3++) {
      var4 = var0[var3];

      if(!ishvt(var4) && var4.team != "spectator" && var4.tagscarried >= 10) {
        becomehvt(var4);
        var4.vehicle_occupancy_mp_showcashbag = 1;
      }

      var2++;

      if(var2 == level.hvtmaxtargets) {
        break;
      }
    }

    for(var3 = 0; var3 < var0.size; var3++) {
      var4 = var0[var3];

      if(ishvt(var4)) {
        if(isDefined(var4.vehicle_occupancy_mp_showcashbag)) {
          var4.vehicle_occupancy_mp_showcashbag = undefined;
          var1--;
          continue;
        }

        if(var1 > 0) {
          var1--;
          continue;
        }

        laststand_hack(var4);
      }
    }

    foreach(var6 in level.players) {
      var7 = var6 getentitynumber();
      var8 = var6.pers["team"];

      if(var8 == "allies") {
        var9 = "axis";
      } else {
        var9 = "allies";
      }

      if(isalive(var6) && istrue(ishvt(var6))) {
        if(!isDefined(level.outlinedplayers[var7])) {
          level.outlinedplayers[var7] = var6;
          var6.outlineidfriend = scripts\mp\utility\outline::outlineenableforteam(var6, var8, "outline_nodepth_green", "level_script");
          var6.outlineidenemy = scripts\mp\utility\outline::outlineenableforteam(var6, var9, "outline_nodepth_red", "level_script");
        }

        continue;
      }

      if(isDefined(level.outlinedplayers[var7])) {
        scripts\mp\utility\outline::outlinedisable(var6.outlineidfriend, var6);
        scripts\mp\utility\outline::outlinedisable(var6.outlineidenemy, var6);
        var6.outlineidfriend = undefined;
        var6.outlineidenemy = undefined;
        level.outlinedplayers[var7] = undefined;
      }
    }

    waitframe();
  }
}

function addhvtheadicons() {
  self.curorigin = self.origin;
  self.offset3d = (0, 0, 24);
  self.objidnumfriend = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var0 = self.objidnumfriend;
  objective_setzoffset(var0, 90);
  objective_icon(var0, "hud_icon_frontline_shield_hvt");
  objective_setplayintro(var0, 1);
  objective_removeallfrommask(var0);

  foreach(var2 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(var2 != self) {
      objective_addclienttomask(var0, var2);
    }
  }

  objective_showtoplayersinmask(var0);
  objective_setbackground(var0, 0);
  objective_position(var0, self getEye() + self.offset3d);
  objective_state(var0, "current");
  objective_setownerteam(var0, self.team);
  self.objidnumenemy = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var0 = self.objidnumenemy;
  objective_setzoffset(var0, 90);
  objective_icon(var0, "hud_icon_death_spawn");
  objective_setplayintro(var0, 1);
  scripts\mp\objidpoolmanager::objective_teammask_single(var0, scripts\mp\utility\game::getotherteam(self.team)[0]);
  objective_setownerteam(var0, self.team);
  objective_setbackground(var0, 0);
  objective_position(var0, self getEye() + self.offset3d);
  objective_state(var0, "current");
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
      var0 = self getEye() + self.offset3d;
      scripts\mp\objidpoolmanager::update_objective_position(self.objidnumfriend, var0);
      scripts\mp\objidpoolmanager::update_objective_position(self.objidnumenemy, var0);
      objective_ping(self.objidnumfriend);
      objective_ping(self.objidnumenemy);
    } else {
      returnheadicons();
    }

    waitframe();
  }
}

function revivetriggerspawned() {}