/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\hstg.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;

  if(getdvarint("dvar_CD7A289C3A33CEDA", 0) != 0)
    level.onplayerkilled = ::onhotfootplayerkilled;

  game["dialog"]["gametype"] = "gametype_tdm";
  game["dialog"]["boost"] = "boost_tdm";
  game["dialog"]["offense_obj"] = "boost_tdm";
  game["dialog"]["defense_obj"] = "boost_tdm";
  level.testtdmanywhere = getdvarint("scr_tdmanywhere", 0);
  level.tdmanywhere_dropheight = getdvarfloat("dvar_0C692D2A11DD6615", 1000);
  level.tdmanywhere_perpenoffset = getdvarfloat("dvar_631C58033F43C2DC", 2048);
  level.tdmanywhere_distoffset = getdvarfloat("dvar_F314048C87AE28AA", 4092);

  if(istrue(level.testtdmanywhere))
    scripts\cp_mp\parachute::initparachutedvars();

  if(scripts\mp\utility\game::matchmakinggame())
    level.shouldgamelobbyremainintact = ::shouldgamelobbyremainintact;
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_war_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("scr_war_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/WAR");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/WAR_HINT");
  }

  if(isDefined(level.initspawnsoverridefunc))
    [[level.initspawnsoverridefunc]]();
  else
    initspawns();

  _id_641E4E9B12A99632::inittankspawns();

  if(getdvarint("dvar_CD7A289C3A33CEDA", 0) != 0)
    thread monitorhotfoot();
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  else
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");

  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);

  if(istrue(level.testtdmanywhere)) {
    x = getdvarfloat("scr_tdmanywhere_centerx", randomfloatrange(-4096, 4096));
    y = getdvarfloat("scr_tdmanywhere_centery", randomfloatrange(-4096, 4096));
    z = getdvarfloat("scr_tdmanywhere_centerz", randomfloatrange(0, 512));
    level.mapcenter = (x, y, z);
    tdmanywhere_debugshowlocs();
  } else {
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
  }
}

getspawnpoint() {
  spawnteam = self.pers["team"];
  spawnpoint = undefined;

  if(istrue(level.testtdmanywhere)) {
    _id_4A31BBF837FE3389 = level.tdmanywherefrontline.anchorrt * randomfloatrange(level.tdmanywhere_perpenoffset * -1.0, level.tdmanywhere_perpenoffset);
    _id_FC4E89BC101F9A57 = undefined;

    if(spawnteam == "axis")
      _id_FC4E89BC101F9A57 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset * -1.0;
    else
      _id_FC4E89BC101F9A57 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;

    spawnpoint = spawnStruct();
    spawnpoint.origin = level.mapcenter + _id_4A31BBF837FE3389 + _id_FC4E89BC101F9A57 + (0, 0, level.tdmanywhere_dropheight);
    spawnpoint.angles = (0, 0, 0);
    spawnpoint.index = 1;
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "fallback");
  }

  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("kill");

  if(!istrue(level.testtdmanywhere)) {
    return;
  }
  self setplayerangles(vectortoangles(level.mapcenter - self.origin));
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

ontimelimit() {
  winner = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime")
    winner = "forfeit";
  else if("tie")
    winner = "overtime";

  thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
}

tdmanywhere_debugshowlocs() {
  thread scripts\mp\utility\debug::drawsphere(level.mapcenter, 128, 100, (0, 1, 0));

  if(!isDefined(level.tdmanywherefrontline))
    waitframe();

  _id_CC015915D647FBDF = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
  _id_C1D9D45C8845EB82 = level.tdmanywherefrontline.anchorrt * level.tdmanywhere_perpenoffset;
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter + _id_CC015915D647FBDF, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter - _id_CC015915D647FBDF, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + _id_CC015915D647FBDF, level.mapcenter + _id_CC015915D647FBDF + _id_C1D9D45C8845EB82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + _id_CC015915D647FBDF, level.mapcenter + _id_CC015915D647FBDF - _id_C1D9D45C8845EB82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - _id_CC015915D647FBDF, level.mapcenter - _id_CC015915D647FBDF + _id_C1D9D45C8845EB82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - _id_CC015915D647FBDF, level.mapcenter - _id_CC015915D647FBDF - _id_C1D9D45C8845EB82, 1000, (0, 0, 1));
}

monitorhotfoot() {
  level endon("game_ended");
  level.outlinedplayers = [];
  level.hotfootabsloops = 0;
  _id_3B5803E733581858 = 0;
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player.hotfootlastposition)) {
        player.hotfootdisttraveledsq = 0;
        player.hotfootlastposition = player.origin;
        player.abshotfootlastposition = player.origin;
      }

      player.hotfootdisttraveledsq = player.hotfootdisttraveledsq + distancesquared(player.hotfootlastposition, player.origin);
      player.hotfootlastposition = player.origin;
    }

    _id_3B5803E733581858 = _id_3B5803E733581858 + level.framedurationseconds;

    if(_id_3B5803E733581858 > 3.0) {
      if(level.hotfootabsloops >= 2) {
        level.hotfootabsloops = 0;

        foreach(player in level.players) {
          if(!isDefined(player.abshotfootlastposition))
            player.abshotfootlastposition = player.origin;

          player.forceabshotfoot = distancesquared(player.abshotfootlastposition, player.origin) < 4225;
          player.abshotfootlastposition = player.origin;
        }
      }

      foreach(player in level.players) {
        entnum = player getentitynumber();
        _id_AC6CA28A64718193 = player.pers["team"];

        if(_id_AC6CA28A64718193 == "allies")
          enemyteam = "axis";
        else
          enemyteam = "allies";

        if(isalive(player) && (istrue(player.forceabshotfoot) || player.hotfootdisttraveledsq < 4225 && !istrue(player.hotfootreset))) {
          player.forceabshotfoot = 0;

          if(!isDefined(level.outlinedplayers[entnum])) {
            level.outlinedplayers[entnum] = player;
            player.outlineidfriend = scripts\mp\utility\outline::outlineenableforteam(player, _id_AC6CA28A64718193, "outline_nodepth_orange", "level_script");
            player.outlineidenemy = scripts\mp\utility\outline::outlineenableforteam(player, enemyteam, "outline_nodepth_red", "level_script");
            player scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_nodepth_orange", 0);
          }
        } else {
          if(isalive(player))
            player.hotfootreset = 0;

          player.forceabshotfoot = 0;

          if(isDefined(level.outlinedplayers[entnum])) {
            scripts\mp\utility\outline::outlinedisable(player.outlineidfriend, player);
            scripts\mp\utility\outline::outlinedisable(player.outlineidenemy, player);
            player scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
            player.outlineidfriend = undefined;
            player.outlineidenemy = undefined;
            level.outlinedplayers[entnum] = undefined;
          }
        }

        player.hotfootdisttraveledsq = 0;
      }

      _id_3B5803E733581858 = 0;
    }

    level.hotfootabsloops++;
    waitframe();
  }
}

onhotfootplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  entnum = self getentitynumber();

  if(isDefined(level.outlinedplayers[entnum])) {
    scripts\mp\utility\outline::outlinedisable(self.outlineidfriend, self);
    scripts\mp\utility\outline::outlinedisable(self.outlineidenemy, self);
    self.outlineidfriend = undefined;
    self.outlineidenemy = undefined;
    level.outlinedplayers[entnum] = undefined;
  }

  self.hotfootreset = 1;
}

shouldgamelobbyremainintact() {
  _id_18A3FAB290E780C2 = int(game["teamScores"]["axis"]);
  _id_43A41488C3C487DF = int(game["teamScores"]["allies"]);
  _id_F9C7AAE8C6ACD600 = _id_18A3FAB290E780C2 - _id_43A41488C3C487DF;
  return _id_F9C7AAE8C6ACD600 < 10;
}