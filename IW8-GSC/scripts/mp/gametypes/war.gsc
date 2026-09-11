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

  if(isDefined(level.totalapacheresponses)) {
    [[level.totalapacheresponses]]();
  } else {
    initspawns();
  }

  scripts\mp\gametypes\bradley_spawner::inittankspawns();

  if(getdvarint("scr_hotfoot", 0) != 0) {
    thread ref_11d09();
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

  if(istrue(level.testtdmanywhere)) {
    var4 = getdvarfloat("scr_tdmAnywhere_centerX", randomfloatrange(-4096, 4096));
    var5 = getdvarfloat("scr_tdmAnywhere_centerY", randomfloatrange(-4096, 4096));
    var6 = getdvarfloat("scr_tdmAnywhere_centerZ", randomfloatrange(0, 512));
    level.mapcenter = (var4, var5, var6);
    tdmanywhere_debugshowlocs();
    return;
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var0 = self.pers["team"];
  var1 = undefined;

  if(istrue(level.testtdmanywhere)) {
    var2 = level.tdmanywherefrontline.anchorrt * randomfloatrange(level.tdmanywhere_perpenoffset * -1, level.tdmanywhere_perpenoffset);
    var3 = undefined;

    if(var0 == "axis") {
      var3 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset * -1;
    } else {
      var3 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
    }

    var1 = spawnStruct();
    var1.origin = level.mapcenter + var2 + var3 + (0, 0, level.tdmanywhere_dropheight);
    var1.angles = (0, 0, 0);
    var1.index = 1;
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var0 == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      var1 = scripts\mp\spawnlogic::getspawnpoint(self, var0, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      var1 = scripts\mp\spawnlogic::getspawnpoint(self, var0, undefined, "start_defenders");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    var1 = scripts\mp\spawnlogic::getspawnpoint(self, var0, undefined, "fallback");
  }

  return var1;
}

function onspawnplayer() {
  self setclientomnvar("ui_match_status_hint_text", 0);

  if(!istrue(level.testtdmanywhere)) {
    return;
  }

  self setplayerangles(vectortoangles(level.mapcenter - self.origin));
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
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

function tdmanywhere_debugshowlocs() {
  thread scripts\mp\utility\debug::drawsphere(level.mapcenter, 128, 100, (0, 1, 0));

  if(!isDefined(level.tdmanywherefrontline)) {
    waitframe();
  }

  var0 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
  var1 = level.tdmanywherefrontline.anchorrt * level.tdmanywhere_perpenoffset;
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter + var0, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter - var0, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var0, level.mapcenter + var0 + var1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var0, level.mapcenter + var0 - var1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var0, level.mapcenter - var0 + var1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var0, level.mapcenter - var0 - var1, 1000, (0, 0, 1));
}

function ref_11d09() {
  level endon("game_ended");
  level.outlinedplayers = [];
  level.spawn_player_vehicle = 0;
  var0 = 0;
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    foreach(var2 in level.players) {
      if(!isDefined(var2.spawn_race_dogtags)) {
        var2.spawn_queue_think = 0;
        var2.spawn_race_dogtags = var2.origin;
        var2.armorbox_used = var2.origin;
      }

      var2.spawn_queue_think += distancesquared(var2.spawn_race_dogtags, var2.origin);
      var2.spawn_race_dogtags = var2.origin;
    }

    var0 += level.framedurationseconds;

    if(var0 > 3) {
      if(level.spawn_player_vehicle >= 2) {
        level.spawn_player_vehicle = 0;

        foreach(var2 in level.players) {
          if(!isDefined(var2.armorbox_used)) {
            var2.armorbox_used = var2.origin;
          }

          var2.playeriscinematiclayeron = distancesquared(var2.armorbox_used, var2.origin) < 4225;
          var2.armorbox_used = var2.origin;
        }
      }

      foreach(var2 in level.players) {
        var7 = var2 getentitynumber();
        var8 = var2.pers["team"];

        if(var8 == "allies") {
          var9 = "axis";
        } else {
          var9 = "allies";
        }

        if(isalive(var2) && (istrue(var2.playeriscinematiclayeron) || var2.spawn_queue_think < 4225 && !istrue(var2.spawn_real_letter))) {
          var2.playeriscinematiclayeron = 0;

          if(!isDefined(level.outlinedplayers[var7])) {
            level.outlinedplayers[var7] = var2;
            var2.outlineidfriend = scripts\mp\utility\outline::outlineenableforteam(var2, var8, "outline_nodepth_orange", "level_script");
            var2.outlineidenemy = scripts\mp\utility\outline::outlineenableforteam(var2, var9, "outline_nodepth_red", "level_script");
            var2 scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_nodepth_orange", 0);
          }
        } else {
          if(isalive(var2)) {
            var2.spawn_real_letter = 0;
          }

          var2.playeriscinematiclayeron = 0;

          if(isDefined(level.outlinedplayers[var7])) {
            scripts\mp\utility\outline::outlinedisable(var2.outlineidfriend, var2);
            scripts\mp\utility\outline::outlinedisable(var2.outlineidenemy, var2);
            var2 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
            var2.outlineidfriend = undefined;
            var2.outlineidenemy = undefined;
            level.outlinedplayers[var7] = undefined;
          }
        }

        var2.spawn_queue_think = 0;
      }

      var0 = 0;
    }

    level.spawn_player_vehicle++;
    waitframe();
  }
}

function ref_12040(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = self getentitynumber();

  if(isDefined(level.outlinedplayers[var10])) {
    scripts\mp\utility\outline::outlinedisable(self.outlineidfriend, self);
    scripts\mp\utility\outline::outlinedisable(self.outlineidenemy, self);
    self.outlineidfriend = undefined;
    self.outlineidenemy = undefined;
    level.outlinedplayers[var10] = undefined;
  }

  self.spawn_real_letter = 1;
}

function ref_132fe() {
  var0 = int(game["teamScores"]["axis"]);
  var1 = int(game["teamScores"]["allies"]);
  var2 = var0 - var1;
  return var2 < 10;
}