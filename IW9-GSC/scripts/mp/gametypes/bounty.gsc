/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\bounty.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);
  level._id_DC401F458E995072 = spawnStruct();

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
    scripts\mp\utility\game::_id_704789086C9AD943(scripts\mp\utility\game::getgametype(), 1);
  }

  level._id_DC401F458E995072 = spawnStruct();
  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;

  if(getdvarint("dvar_CD7A289C3A33CEDA", 0) != 0)
    level.onplayerkilled = ::onhotfootplayerkilled;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_bnty_mode_uktl_bnt1";
  else
    game["dialog"]["gametype"] = "iw9_bnty_mode_uktl_bynm";

  game["dialog"]["offense_obj"] = "iw9_bnty_mode_uktl_bybo";
  game["dialog"]["defense_obj"] = "iw9_bnty_mode_uktl_bybo";
  game["dialog"]["bounty_new_targets_warning"] = "iw9_bnty_mode_uktl_bytw";
  game["dialog"]["bounty_new_target"] = "iw9_bnty_mode_uktl_bynt";
  game["dialog"]["bounty_become_target"] = "iw9_bnty_mode_uktl_bybt";

  if(!isDefined(level.waypointcolors) || !isDefined(level.waypointcolors["bounty_enemy"]))
    scripts\mp\gamelogic::setwaypointiconinfo("bounty_enemy", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_hvt_enemy", 0, undefined);

  if(!isDefined(level.waypointcolors) || !isDefined(level.waypointcolors["bounty_friendly"]))
    scripts\mp\gamelogic::setwaypointiconinfo("bounty_friendly", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hvt_friendly", 0, 12);

  if(scripts\mp\utility\game::matchmakinggame())
    level.shouldgamelobbyremainintact = ::shouldgamelobbyremainintact;

  level thread _id_C422D0209D63D82C();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_war_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("scr_war_promode", 0);
  setdynamicdvar("dvar_5D63372846C76438", getmatchrulesdata("bountyData", "hvtsPerTeam"));
  setdynamicdvar("dvar_DD0CFB059EB759F1", getmatchrulesdata("bountyData", "pointsPerHVTKill"));
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
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/BOUNTY");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/BOUNTY");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/BOUNTY_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/BOUNTY_HINT");
  }

  if(isDefined(level.initspawnsoverridefunc))
    [[level.initspawnsoverridefunc]]();
  else
    initspawns();

  _id_641E4E9B12A99632::inittankspawns();

  if(getdvarint("dvar_CD7A289C3A33CEDA", 0) != 0)
    thread monitorhotfoot();
}

_id_C422D0209D63D82C() {
  level waittill("prematch_over");
  level._id_DC401F458E995072.hvts = [];

  if(isDefined(level.scoremod) && isDefined(level.scoremod["kill"])) {
    level._id_DC401F458E995072._id_461A9F979B5EF725 = level._id_DC401F458E995072._id_461A9F979B5EF725 - level.scoremod["kill"];

    if(level._id_DC401F458E995072._id_461A9F979B5EF725 < 0)
      level._id_DC401F458E995072._id_461A9F979B5EF725 = 0;
  }

  foreach(_id_FABF84450735DD93 in level.teamnamelist)
  level._id_DC401F458E995072.hvts[_id_FABF84450735DD93] = [];

  wait 10.0;
  level thread _id_DAA7BA85DFF31C58();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawn);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level._id_DC401F458E995072._id_21B14ABD06A8E094 = scripts\mp\utility\dvars::dvarintvalue("hvtsPerTeam", 1, 1, 6);
  level._id_DC401F458E995072._id_461A9F979B5EF725 = scripts\mp\utility\dvars::dvarintvalue("pointsPerHVTKill", 5, 1, 25);
  level._id_DC401F458E995072._id_95BF620ED45AFAA2 = scripts\mp\utility\dvars::dvarintvalue("warnTeamHVTChange", 0, 0, 1);
  level._id_DC401F458E995072._id_A94B2CF6E16726F1 = scripts\mp\utility\dvars::dvarintvalue("hvtRefreshInterval", 30, 0, 120);
  level._id_DC401F458E995072._id_EF5B040DF00B52C5 = scripts\mp\utility\dvars::dvarintvalue("hvtRefreshWarnTime", 10, 0, 30);
  level._id_DC401F458E995072._id_F6764A25DB170294 = scripts\mp\utility\dvars::dvarintvalue("hvtMarkerPingEnabled", 0, 0, 1);
  level._id_DC401F458E995072._id_07ADA166AFEB7FCE = scripts\mp\utility\dvars::dvarfloatvalue("hvtMarkerPingInterval", 5.0, 0.0, 60.0);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(getdvarint("dvar_A464CB031C16EE87", 0) > 0)
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
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
    x = getdvarfloat("dvar_B6294C84C04E377B", randomfloatrange(-4096, 4096));
    y = getdvarfloat("dvar_B6294B84C04E3548", randomfloatrange(-4096, 4096));
    z = getdvarfloat("dvar_B6294E84C04E3BE1", randomfloatrange(0, 512));
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

  if(isDefined(victim.trackedobject))
    scripts\mp\objidpoolmanager::update_objective_state(victim.trackedobject.pingobjidnum, "invisible");

  attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);

  if(isDefined(victim) && scripts\engine\utility::array_contains(level._id_DC401F458E995072.hvts[victim.team], victim)) {
    attacker scripts\mp\utility\stats::incpersstat("hvtKills", 1);
    attacker scripts\mp\utility\stats::setextrascore0(attacker.pers["hvtKills"]);
    attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_4B89B1D2E95E2012", objweapon, victim);

    if(level._id_DC401F458E995072._id_461A9F979B5EF725 > 0) {
      scripts\mp\gamescore::giveteamscoreforobjective(attacker.team, level._id_DC401F458E995072._id_461A9F979B5EF725, 0);
      attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, level._id_DC401F458E995072._id_461A9F979B5EF725);
    }
  }
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

_id_DAA7BA85DFF31C58() {
  self endon("game_ended");

  if(!istrue(level._id_DC401F458E995072._id_6CEC5F1BA131A4B8))
    level._id_DC401F458E995072._id_6CEC5F1BA131A4B8 = 1;
  else
    return;

  for(;;) {
    foreach(_id_FABF84450735DD93 in level.teamnamelist)
    _id_73F4370F1B27931F(_id_FABF84450735DD93);

    if(istrue(level._id_DC401F458E995072._id_95BF620ED45AFAA2)) {
      wait(level._id_DC401F458E995072._id_A94B2CF6E16726F1 - level._id_DC401F458E995072._id_EF5B040DF00B52C5);

      foreach(_id_FABF84450735DD93 in level.teamnamelist) {
        scripts\mp\utility\dialog::statusdialog("bounty_new_targets_warning", _id_FABF84450735DD93);

        foreach(player in scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "alivePlayers")) {
          player scripts\mp\hud_message::showsplash("bounty_hvt_warn_change");
          player playlocalsound("uin_splash_bounty_new_targets");
        }
      }

      wait(level._id_DC401F458E995072._id_EF5B040DF00B52C5);
      continue;
    }

    wait(level._id_DC401F458E995072._id_A94B2CF6E16726F1);
  }
}

_id_73F4370F1B27931F(_id_FABF84450735DD93, _id_404CF37133AB102D) {
  _id_FDCA194965CD644A = [];
  players = _id_4632DA5FC05BA940(_id_FABF84450735DD93);

  foreach(player in players) {
    if(_id_FDCA194965CD644A.size < level._id_DC401F458E995072._id_21B14ABD06A8E094) {
      if(!scripts\engine\utility::array_contains(level._id_DC401F458E995072.hvts[_id_FABF84450735DD93], player)) {
        _id_FDCA194965CD644A[_id_FDCA194965CD644A.size] = player;
        continue;
      }
    }
  }

  scripts\mp\utility\dialog::statusdialog("bounty_new_target", _id_FABF84450735DD93, undefined, _id_FDCA194965CD644A);

  foreach(player in level._id_DC401F458E995072.hvts[_id_FABF84450735DD93]) {
    if(isDefined(player) && !scripts\engine\utility::array_contains(_id_FDCA194965CD644A, player))
      player thread _id_AD9BEB8E6A905599();
  }

  foreach(player in _id_FDCA194965CD644A) {
    if(isDefined(player) && !scripts\engine\utility::array_contains(level._id_DC401F458E995072.hvts[_id_FABF84450735DD93], player))
      player thread _id_00AC2690AB2DA6FA();
  }

  level._id_DC401F458E995072.hvts[_id_FABF84450735DD93] = _id_FDCA194965CD644A;

  if(!istrue(_id_404CF37133AB102D))
    level._id_DC401F458E995072._id_B9D8ABC30E8B40B8 = gettime();
}

_id_00AC2690AB2DA6FA() {
  self endon("disconnect");
  self endon("bounty_unmarked");
  self notify("bounty_marked");

  if(!scripts\mp\utility\player::isreallyalive(self))
    self waittill("spawned_player");

  self.nosuspensemusic = 1;

  if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1)
    self setplayermusicstate("mp_sd_bombplanted_30_playlist_classic");
  else
    self setplayermusicstate("mp_sd_bombplanted_30_playlist");

  _id_2C66AE09A0A7C438();
  scripts\mp\hud_message::showsplash("bounty_hvt_marked");
  self playlocalsound("uin_splash_bounty_marked");
  scripts\mp\utility\dialog::leaderdialogonplayer("bounty_become_target");
}

_id_AD9BEB8E6A905599() {
  self endon("disconnect");
  self endon("bounty_marked");
  self notify("bounty_unmarked");
  self.nosuspensemusic = undefined;
  self setplayermusicstate("");
  _id_605BBE56B2CE817A();
  waitframe();

  if(isPlayer(self) && !_func_96D228FA8E72A818(self)) {
    if(!scripts\mp\utility\player::isreallyalive(self))
      self waittill("spawned_player");

    scripts\mp\hud_message::showsplash("bounty_hvt_unmarked");
    self playlocalsound("uin_splash_bounty_unmarked");
  }
}

_id_2C66AE09A0A7C438() {
  if(!isDefined(self.trackedobject)) {
    trackedobject = scripts\mp\gameobjects::createtrackedobject(self, (0, 0, 100));
    scripts\mp\objidpoolmanager::objective_set_play_intro(trackedobject.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(trackedobject.objidnum, 0);
    trackedobject.objidpingfriendly = level._id_DC401F458E995072._id_F6764A25DB170294 != 0;
    trackedobject.objidpingenemy = 0;
    trackedobject.objpingdelay = level._id_DC401F458E995072._id_07ADA166AFEB7FCE;
    trackedobject scripts\mp\gameobjects::setobjectivestatusicons("bounty_friendly");
    trackedobject scripts\mp\gameobjects::setvisibleteam("friendly");
    self.trackedobject = trackedobject;
    trackedobject.pingobjidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    scripts\mp\objidpoolmanager::objective_add_objective(trackedobject.pingobjidnum, "current", self.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(trackedobject.pingobjidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(trackedobject.pingobjidnum, 0);
    scripts\mp\objidpoolmanager::update_objective_ownerteam(trackedobject.pingobjidnum, self.team);
    trackedobject scripts\mp\gameobjects::updatecompassicon("enemy", trackedobject.pingobjidnum);
    scripts\mp\objidpoolmanager::update_objective_icon(trackedobject.pingobjidnum, level.waypointshader["bounty_enemy"]);
    scripts\mp\objidpoolmanager::update_objective_setenemylabel(trackedobject.pingobjidnum, level.waypointstring["bounty_enemy"]);
    scripts\mp\objidpoolmanager::update_objective_state(trackedobject.pingobjidnum, "current");
    scripts\mp\objidpoolmanager::_id_79A1A16DE6B22B2D(trackedobject.pingobjidnum, 0);
  } else {
    self.trackedobject scripts\mp\gameobjects::setvisibleteam("friendly");
    scripts\mp\objidpoolmanager::update_objective_state(self.trackedobject.pingobjidnum, "current");
  }

  if(!isDefined(self._id_1EA3D23E8D49BB49)) {
    self._id_1EA3D23E8D49BB49 = "prop_king_game_flag";
    self attach(self._id_1EA3D23E8D49BB49, "tag_stowed_back3", 1);
  }
}

_id_605BBE56B2CE817A() {
  if(isDefined(self.trackedobject)) {
    if(isDefined(self.trackedobject.pingobjidnum)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(self.trackedobject.pingobjidnum);
      self.trackedobject.pingobjidnum = undefined;
    }

    self.trackedobject scripts\mp\gameobjects::deletetrackedobject();
    self.trackedobject = undefined;
  }

  if(isDefined(self._id_1EA3D23E8D49BB49)) {
    self detach(self._id_1EA3D23E8D49BB49, "tag_stowed_back3");
    self._id_1EA3D23E8D49BB49 = undefined;
  }
}

_id_7A2F8A385DA422FF() {
  if(isDefined(self._id_1EA3D23E8D49BB49)) {
    _id_076651B5D03AD861 = self getattachsize();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_076651B5D03AD861; _id_AC0E594AC96AA3A8++) {
      attached = self getattachmodelname(_id_AC0E594AC96AA3A8);

      if(attached == self._id_1EA3D23E8D49BB49)
        return 1;
    }
  }

  return 0;
}

onplayerspawn() {
  if(isDefined(self._id_1EA3D23E8D49BB49) && !_id_7A2F8A385DA422FF())
    self attach(self._id_1EA3D23E8D49BB49, "tag_stowed_back3", 1);

  if(isDefined(self.trackedobject))
    scripts\mp\objidpoolmanager::update_objective_state(self.trackedobject.pingobjidnum, "current");
}

onplayerdisconnect(player) {
  if(isDefined(level._id_DC401F458E995072._id_B9D8ABC30E8B40B8) && scripts\engine\utility::array_contains(level._id_DC401F458E995072.hvts[player.team], player)) {
    _id_29CA520A8694CD41 = level._id_DC401F458E995072._id_A94B2CF6E16726F1 * 1000;
    _id_EF5B040DF00B52C5 = level._id_DC401F458E995072._id_EF5B040DF00B52C5 * 1000 * level._id_DC401F458E995072._id_95BF620ED45AFAA2;
    _id_89E85C0815C992D6 = level._id_DC401F458E995072._id_B9D8ABC30E8B40B8 + _id_29CA520A8694CD41 - _id_EF5B040DF00B52C5 - gettime();

    if(_id_89E85C0815C992D6 > 5000)
      _id_73F4370F1B27931F(player.team, 1);
    else {
      player thread _id_AD9BEB8E6A905599();
      scripts\engine\utility::array_remove(level._id_DC401F458E995072.hvts[player.team], player);
    }
  }
}

getplayerkills(player) {
  if(!isDefined(player))
    player = self;

  return player.pers["kills"];
}

_id_4D84C1274F53342D(_id_472D4F042B732E8A, _id_CB730D03142C3F30) {
  return getplayerkills(_id_472D4F042B732E8A) > getplayerkills(_id_CB730D03142C3F30);
}

_id_4632DA5FC05BA940(_id_FABF84450735DD93) {
  players = level.teamdata[_id_FABF84450735DD93]["players"];
  return scripts\engine\utility::array_sort_with_func(players, ::_id_4D84C1274F53342D);
}