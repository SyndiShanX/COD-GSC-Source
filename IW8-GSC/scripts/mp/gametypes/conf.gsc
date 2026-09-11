/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\conf.gsc
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
  setdynamicdvar("scr_conf_pointsPerConfirm", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("scr_conf_pointsPerDeny", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("scr_conf_killstreakConfirmed", getmatchrulesdata("confData", "killstreakConfirmed"));
  setdynamicdvar("scr_conf_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("conf", 0);
  setdynamicdvar("scr_conf_promode", 0);
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
    scripts\mp\utility\game::setobjectivetext(var3, &"OBJECTIVES/CONF");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/CONF");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/CONF_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var3, &"OBJECTIVES/CONF_HINT");
  }

  initspawns();
  level.dogtagallyonusecb = &dogtagallyonusecb;
  level.dogtagenemyonusecb = &dogtagenemyonusecb;
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
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

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.scoreconfirm = scripts\mp\utility\dvars::dvarintvalue("pointsPerConfirm", 1, 0, 25);
  level.scoredeny = scripts\mp\utility\dvars::dvarintvalue("pointsPerDeny", 0, 0, 25);
  level.vocalloutstring = scripts\mp\utility\dvars::dvarintvalue("killstreakConfirmed", 0, 0, 1);
}

function getspawnpoint() {
  var0 = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var0 == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      var1 = scripts\mp\spawnlogic::getspawnpoint(self, var0, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      var1 = scripts\mp\spawnlogic::getspawnpoint(self, var1, undefined, "start_defenders");
    }
  } else {
    var1 = scripts\mp\spawnlogic::getspawnpoint(self, var1, "normal", "fallback");
  }

  return var1;
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
}

function onspawnplayer() {
  self setclientomnvar("ui_match_status_hint_text", 33);
}

function dogtagallyonusecb(var0) {
  if(isPlayer(var0)) {
    var0 scripts\mp\utility\stats::setextrascore1(var0.pers["denied"]);
    var0 scripts\mp\gamescore::giveteamscoreforobjective(var0.pers["team"], level.scoredeny, 0);
    return;
  }
}

function dogtagenemyonusecb(var0) {
  if(isPlayer(var0)) {
    var0 scripts\mp\utility\dialog::leaderdialogonplayer("kill_confirmed", undefined, undefined, undefined, 4);
    var0 scripts\mp\utility\stats::setextrascore0(var0.pers["confirmed"]);

    if(istrue(level.vocalloutstring)) {
      if(!var0 scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak")) {
        var0 scripts\mp\killstreaks\killstreaks::givestreakpoints("capture", 1, 0);
      } else {
        var0 scripts\mp\killstreaks\killstreaks::givestreakpoints("capture", 1, 150);
      }
    }
  }

  var0 scripts\mp\gamescore::giveteamscoreforobjective(var0.pers["team"], level.scoreconfirm, 0);
}