/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\war.gsc
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

  if(isDefined(level.totalapacheresponses)) {
    [[level.totalapacheresponses]]();
  } else {
    initspawns();
  }

  scripts\mp\gametypes\bradley_spawner::inittankspawns();

  if(getdvarint("scr_hotfoot", 0) != 0) {
    thread ref_11D09();
    return;
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
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

  if(istrue(level.testtdmanywhere)) {
    var_4 = getdvarfloat("scr_tdmAnywhere_centerX", randomfloatrange(-4096, 4096));
    var_5 = getdvarfloat("scr_tdmAnywhere_centerY", randomfloatrange(-4096, 4096));
    var_6 = getdvarfloat("scr_tdmAnywhere_centerZ", randomfloatrange(0, 512));
    level.mapcenter = (var_4, var_5, var_6);
    tdmanywhere_debugshowlocs();
    return;
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var_0 = self.pers["team"];
  var_1 = undefined;

  if(istrue(level.testtdmanywhere)) {
    var_2 = level.tdmanywherefrontline.anchorrt * randomfloatrange(level.tdmanywhere_perpenoffset * -1, level.tdmanywhere_perpenoffset);
    var_3 = undefined;

    if(var_0 == "axis") {
      var_3 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset * -1;
    } else {
      var_3 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
    }

    var_1 = spawnStruct();
    var_1.origin = level.mapcenter + var_2 + var_3 + (0, 0, level.tdmanywhere_dropheight);
    var_1.angles = (0, 0, 0);
    var_1.index = 1;
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var_0 == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "start_defenders");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "fallback");
  }

  return var_1;
}

function onspawnplayer() {
  self setclientomnvar("ui_match_status_hint_text", 0);

  if(!istrue(level.testtdmanywhere)) {
    return;
  }

  self setplayerangles(vectortoangles(level.mapcenter - self.origin));
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
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

function tdmanywhere_debugshowlocs() {
  thread scripts\mp\utility\debug::drawsphere(level.mapcenter, 128, 100, (0, 1, 0));

  if(!isDefined(level.tdmanywherefrontline)) {
    waitframe();
  }

  var_0 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
  var_1 = level.tdmanywherefrontline.anchorrt * level.tdmanywhere_perpenoffset;
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter + var_0, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter - var_0, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var_0, level.mapcenter + var_0 + var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var_0, level.mapcenter + var_0 - var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var_0, level.mapcenter - var_0 + var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var_0, level.mapcenter - var_0 - var_1, 1000, (0, 0, 1));
}

function ref_11D09() {
  level endon("game_ended");
  level.outlinedplayers = [];
  level.spawn_player_vehicle = 0;
  var_0 = 0;
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2.spawn_race_dogtags)) {
        var_2.spawn_queue_think = 0;
        var_2.spawn_race_dogtags = var_2.origin;
        var_2.armorbox_used = var_2.origin;
      }

      var_2.spawn_queue_think += distancesquared(var_2.spawn_race_dogtags, var_2.origin);
      var_2.spawn_race_dogtags = var_2.origin;
    }

    var_0 += level.framedurationseconds;

    if(var_0 > 3) {
      if(level.spawn_player_vehicle >= 2) {
        level.spawn_player_vehicle = 0;

        foreach(var_2 in level.players) {
          if(!isDefined(var_2.armorbox_used)) {
            var_2.armorbox_used = var_2.origin;
          }

          var_2.playeriscinematiclayeron = distancesquared(var_2.armorbox_used, var_2.origin) < 4225;
          var_2.armorbox_used = var_2.origin;
        }
      }

      foreach(var_2 in level.players) {
        var_7 = var_2 getentitynumber();
        var_8 = var_2.pers["team"];

        if(var_8 == "allies") {
          var_9 = "axis";
        } else {
          var_9 = "allies";
        }

        if(isalive(var_2) && (istrue(var_2.playeriscinematiclayeron) || var_2.spawn_queue_think < 4225 && !istrue(var_2.spawn_real_letter))) {
          var_2.playeriscinematiclayeron = 0;

          if(!isDefined(level.outlinedplayers[var_7])) {
            level.outlinedplayers[var_7] = var_2;
            var_2.outlineidfriend = scripts\mp\utility\outline::outlineenableforteam(var_2, var_8, "outline_nodepth_orange", "level_script");
            var_2.outlineidenemy = scripts\mp\utility\outline::outlineenableforteam(var_2, var_9, "outline_nodepth_red", "level_script");
            var_2 scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_nodepth_orange", 0);
          }
        } else {
          if(isalive(var_2)) {
            var_2.spawn_real_letter = 0;
          }

          var_2.playeriscinematiclayeron = 0;

          if(isDefined(level.outlinedplayers[var_7])) {
            scripts\mp\utility\outline::outlinedisable(var_2.outlineidfriend, var_2);
            scripts\mp\utility\outline::outlinedisable(var_2.outlineidenemy, var_2);
            var_2 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
            var_2.outlineidfriend = undefined;
            var_2.outlineidenemy = undefined;
            level.outlinedplayers[var_7] = undefined;
          }
        }

        var_2.spawn_queue_think = 0;
      }

      var_0 = 0;
    }

    level.spawn_player_vehicle++;
    waitframe();
  }
}

function ref_12040(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self getentitynumber();

  if(isDefined(level.outlinedplayers[var_10])) {
    scripts\mp\utility\outline::outlinedisable(self.outlineidfriend, self);
    scripts\mp\utility\outline::outlinedisable(self.outlineidenemy, self);
    self.outlineidfriend = undefined;
    self.outlineidenemy = undefined;
    level.outlinedplayers[var_10] = undefined;
  }

  self.spawn_real_letter = 1;
}

function ref_132FE() {
  var_0 = int(game["teamScores"]["axis"]);
  var_1 = int(game["teamScores"]["allies"]);
  var_2 = var_0 - var_1;
  return var_2 < 10;
}