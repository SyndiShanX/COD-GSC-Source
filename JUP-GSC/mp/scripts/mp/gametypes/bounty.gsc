/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\bounty.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace bounty;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);
  level.bounty = spawnStruct();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 0, 0, 9);
    registertimelimitdvar(getgametype(), 600);
    registerscorelimitdvar(getgametype(), 75);
    registerroundlimitdvar(getgametype(), 1);
    registerwinlimitdvar(getgametype(), 1);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
    function_704789086c9ad943(getgametype(), 1);
  }

  level.bounty = spawnStruct();
  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;

  if(getdvarint(@ "hash_cd7a289c3a33ceda", 0) != 0) {
    level.onplayerkilled = &onhotfootplayerkilled;
  }

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    game["dialog"]["gametype"] = "dx_mp_boun_game_uktl_bnt1";
  } else {
    game["dialog"]["gametype"] = "dx_mp_boun_game_uktl_bynm";
  }

  game["dialog"]["offense_obj"] = "dx_mp_boun_game_uktl_bybo";
  game["dialog"]["defense_obj"] = "dx_mp_boun_game_uktl_bybo";
  game["dialog"]["bounty_new_targets_warning"] = "dx_mp_boun_game_uktl_bytw";
  game["dialog"]["bounty_new_target"] = "dx_mp_boun_game_uktl_bynt";
  game["dialog"]["bounty_become_target"] = "dx_mp_boun_game_uktl_bybt";

  if(!isDefined(level.waypointcolors) || !isDefined(level.waypointcolors["bounty_enemy"])) {
    scripts\mp\gamelogic::setwaypointiconinfo("bounty_enemy", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_hvt_enemy", 0, undefined);
  }

  if(!isDefined(level.waypointcolors) || !isDefined(level.waypointcolors["bounty_friendly"])) {
    scripts\mp\gamelogic::setwaypointiconinfo("bounty_friendly", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hvt_friendly", 0, 12);
  }

  if(matchmakinggame()) {
    level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
  }

  level.reinitspawns = &reinitspawns;

  level thread function_c422d0209d63d82c();
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_6e7da31aae47b8e0", 0);
  registerhalftimedvar(getgametype(), 0);
  setdynamicdvar(@ "hash_bb6e8f8d9be104f4", 0);
  setdynamicdvar(@ "hash_5d63372846c76438", getmatchrulesdata("bountyData", "hvtsPerTeam"));
  setdynamicdvar(@ "hash_dd0cfb059eb759f1", getmatchrulesdata("bountyData", "pointsPerHVTKill"));

  if(getdvarint(@ "jup", 0)) {
    setdynamicdvar(@ "hash_5d63372846c76438", 1);
    setdynamicdvar(@ "hash_dd0cfb059eb759f1", 5);
  }
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/BOUNTY");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/BOUNTY");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/BOUNTY_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/BOUNTY_HINT");
  }

  if(isDefined(level.initspawnsoverridefunc)) {
    [[level.initspawnsoverridefunc]]();
  } else {
    initspawns();
  }

  scripts\mp\gametypes\bradley_spawner::inittankspawns();

  if(getdvarint(@ "hash_cd7a289c3a33ceda", 0) != 0) {
    thread monitorhotfoot();
  }

  thread function_8469a5927d069db7();

  if(false) {
    function_bf2918399f1800b1();
  }
}

function private function_c422d0209d63d82c() {
  level waittill("prematch_over");
  level.bounty.hvts = [];

  if(isDefined(level.scoremod) && isDefined(level.scoremod["kill"])) {
    level.bounty.pointsperhvtkill -= level.scoremod["kill"];

    if(level.bounty.pointsperhvtkill < 0) {
      level.bounty.pointsperhvtkill = 0;
    }
  }

  foreach(teamname in level.teamnamelist) {
    level.bounty.hvts[teamname] = [];
  }

  wait 10;
  level thread function_daa7ba85dff31c58();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawn);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.bounty.hvtsperteam = dvarintvalue("hvtsPerTeam", 1, 1, 6);
  level.bounty.pointsperhvtkill = dvarintvalue("pointsPerHVTKill", 5, 1, 25);
  level.bounty.warnteamhvtchange = dvarintvalue("warnTeamHVTChange", 0, 0, 1);
  level.bounty.hvtrefreshinterval = dvarintvalue("hvtRefreshInterval", 30, 0, 120);
  level.bounty.hvtrefreshwarntime = dvarintvalue("hvtRefreshWarnTime", 10, 0, 30);
  level.bounty.hvtmarkerpingenabled = dvarintvalue("hvtMarkerPingEnabled", 0, 0, 1);
  level.bounty.hvtmarkerpinginterval = dvarfloatvalue("hvtMarkerPingInterval", 5, 0, 60);
  level.bounty.hvtmaxdeaths = dvarintvalue("hvtMaxDeaths", 3, 1, 99);
  level.bounty.hvtmaxdeathsenabled = dvarintvalue("hvtMaxDeathsEnabled", 1, 0, 1);
}

function initspawns() {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else if(getdvarint(@ "t10", 0) > 0) {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  } else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  spawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", spawns);
  scripts\mp\spawnlogic::registerspawnset("fallback", spawnssecondary);

  if(istrue(level.testtdmanywhere)) {
    x = getdvarfloat(@ "hash_b6294c84c04e377b", randomfloatrange(-4096, 4096));
    y = getdvarfloat(@ "hash_b6294b84c04e3548", randomfloatrange(-4096, 4096));
    z = getdvarfloat(@ "hash_b6294e84c04e3be1", randomfloatrange(0, 512));
    level.mapcenter = (x, y, z);
    tdmanywhere_debugshowlocs();
    return;
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function reinitspawns() {
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x1c>");
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x26>");
  spawns = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x32>");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x42>");
  scripts\mp\spawnlogic::registerspawnset("<dev string:x1c>", spawns);
  scripts\mp\spawnlogic::registerspawnset("<dev string:x26>", spawnssecondary);
}

function getspawnpoint() {
  spawnteam = self.pers["team"];
  spawnpoint = undefined;

  if(istrue(level.testtdmanywhere)) {
    var_4a31bbf837fe3389 = level.tdmanywherefrontline.anchorrt * randomfloatrange(level.tdmanywhere_perpenoffset * -1, level.tdmanywhere_perpenoffset);
    var_fc4e89bc101f9a57 = undefined;

    if(spawnteam == "axis") {
      var_fc4e89bc101f9a57 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset * -1;
    } else {
      var_fc4e89bc101f9a57 = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
    }

    spawnpoint = spawnStruct();
    spawnpoint.origin = level.mapcenter + var_4a31bbf837fe3389 + var_fc4e89bc101f9a57 + (0, 0, level.tdmanywhere_dropheight);
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

    spawncompare(spawnpoint, spawnteam);
  }

  return spawnpoint;
}

function onspawnplayer(revivespawn) {
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");

  if(!istrue(level.testtdmanywhere)) {
    return;
  }

  self setplayerangles(vectortoangles(level.mapcenter - self.origin));
}

function spawncompare(spawnpoint, spawnteam) {
  if(getdvarint(@ "hash_b5ceec3e3cb419be") != 0) {
    spawnpoints = scripts\mp\spawnlogic::getteamspawnpoints(spawnteam);
    fallbackspawnpoints = [];
    scriptspawnpoint = scripts\mp\spawnscoring::getspawnpoint_legacy(spawnpoints, fallbackspawnpoints);

    if(!isDefined(level.var_3d292942d52b104a)) {
      level.var_3d292942d52b104a = 0;
      level.var_2dc7108159dc1da3 = 0;
      level.var_a065445ba781ddf6 = 0;
    }

    level.var_3d292942d52b104a++;
    println("<dev string:x5c>" + scriptspawnpoint.index + "<dev string:x77>" + scriptspawnpoint.totalscore);

    if(scriptspawnpoint.index == spawnpoint.index) {
      level.var_2dc7108159dc1da3++;
      iprintlnbold("<dev string:x8d>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xac>" + "<dev string:xba>" + level.var_2dc7108159dc1da3 + "<dev string:xbf>" + level.var_3d292942d52b104a);
    } else {
      level.var_a065445ba781ddf6++;
      iprintlnbold("<dev string:xc4>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xac>" + "<dev string:xba>" + level.var_2dc7108159dc1da3 + "<dev string:xbf>" + level.var_3d292942d52b104a);
    }

    return scriptspawnpoint;
  }
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  scripts\mp\gametypes\common::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  if(isDefined(victim.trackedobject)) {
    scripts\mp\objidpoolmanager::update_objective_state(victim.trackedobject.pingobjidnum, "invisible");
  }

  attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);

  if(isDefined(victim) && scripts\engine\utility::array_contains(level.bounty.hvts[victim.team], victim)) {
    attacker scripts\mp\utility\stats::incpersstat("hvtKills", 1);
    attacker scripts\mp\utility\stats::setextrascore0(attacker.pers["hvtKills"]);
    attacker thread scripts\mp\utility\points::function_e3e3e81453fd788b(#"hvt_kill", objweapon, victim);
    attacker playlocalsound("jup_bounty_hvt_killed_positive_player");

    if(level.bounty.pointsperhvtkill > 0) {
      scripts\mp\gamescore::giveteamscoreforobjective(attacker.team, level.bounty.pointsperhvtkill, 0);
      attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, level.bounty.pointsperhvtkill);
    }

    victim playsoundtoteam("jup_bounty_hvt_killed_negative", victim.team, undefined, victim);
    victim playsoundtoteam("jup_bounty_hvt_killed_positive", getotherteam(victim.team)[0], attacker, victim);

    if(level.bounty.hvtmaxdeathsenabled) {
      level function_129e9903526b5cc4(victim);
    }

    if(victim isusingremote()) {
      level notify("bountyDiedUsingRemoteKillstreak", victim.pers["team"]);
    }
  }
}

function function_129e9903526b5cc4(player) {
  if(!isDefined(player.var_3675d0d805c111b9)) {
    player.var_3675d0d805c111b9 = 0;
  }

  player.var_3675d0d805c111b9++;

  if(player.var_3675d0d805c111b9 >= level.bounty.hvtmaxdeaths) {
    player.var_3675d0d805c111b9 = undefined;
    level notify("bountyMaxDeaths", player.pers["team"]);
  }
}

function ontimelimit() {
  winner = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime") {
    winner = "forfeit";
  } else if("tie") {
    winner = "overtime";
  }

  thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
}

function function_8469a5927d069db7() {
  self endon("<dev string:xf4>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      points = getdvarint(@ "hash_46a6b424af6acbc2");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x102>", points, 0);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      points = getdvarint(@ "hash_86e14326e43c0115");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x10c>", points, 0);
      break;
    }

    wait 1;
  }

  setdevdvar(@ "hash_46a6b424af6acbc2", 0);
  setdevdvar(@ "hash_86e14326e43c0115", 0);
  thread function_8469a5927d069db7();
}

function function_bf2918399f1800b1() {
  wait 5;
  ents = getEntArray("<dev string:x114>", "<dev string:x122>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  ents = getEntArray("<dev string:x137>", "<dev string:x122>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x114>", "<dev string:x122>");

  foreach(struct in structs) {
    thread scripts\mp\utility\debug::drawsphere(struct.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x137>", "<dev string:x122>");

  foreach(struct in structs) {
    thread scripts\mp\utility\debug::drawsphere(struct.origin, 64, 1000, (0, 1, 0));
  }
}

function tdmanywhere_debugshowlocs() {
  thread scripts\mp\utility\debug::drawsphere(level.mapcenter, 128, 100, (0, 1, 0));

  if(!isDefined(level.tdmanywherefrontline)) {
    waitframe();
  }

  var_cc015915d647fbdf = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
  var_c1d9d45c8845eb82 = level.tdmanywherefrontline.anchorrt * level.tdmanywhere_perpenoffset;
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter + var_cc015915d647fbdf, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter - var_cc015915d647fbdf, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var_cc015915d647fbdf, level.mapcenter + var_cc015915d647fbdf + var_c1d9d45c8845eb82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var_cc015915d647fbdf, level.mapcenter + var_cc015915d647fbdf - var_c1d9d45c8845eb82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var_cc015915d647fbdf, level.mapcenter - var_cc015915d647fbdf + var_c1d9d45c8845eb82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var_cc015915d647fbdf, level.mapcenter - var_cc015915d647fbdf - var_c1d9d45c8845eb82, 1000, (0, 0, 1));
}

function monitorhotfoot() {
  level endon("game_ended");
  level.outlinedplayers = [];
  level.hotfootabsloops = 0;
  timepassed = 0;
  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player.hotfootlastposition)) {
        player.hotfootdisttraveledsq = 0;
        player.hotfootlastposition = player.origin;
        player.abshotfootlastposition = player.origin;
      }

      player.hotfootdisttraveledsq += distancesquared(player.hotfootlastposition, player.origin);
      player.hotfootlastposition = player.origin;
    }

    timepassed += level.framedurationseconds;

    if(timepassed > 3) {
      if(level.hotfootabsloops >= 2) {
        level.hotfootabsloops = 0;

        foreach(player in level.players) {
          if(!isDefined(player.abshotfootlastposition)) {
            player.abshotfootlastposition = player.origin;
          }

          player.forceabshotfoot = distancesquared(player.abshotfootlastposition, player.origin) < 4225;
          player.abshotfootlastposition = player.origin;
        }
      }

      foreach(player in level.players) {
        entnum = player getentitynumber();
        friendlyteam = player.pers["team"];

        if(friendlyteam == "allies") {
          enemyteam = "axis";
        } else {
          enemyteam = "allies";
        }

        if(isalive(player) && (istrue(player.forceabshotfoot) || player.hotfootdisttraveledsq < 4225 && !istrue(player.hotfootreset))) {
          if(istrue(player.forceabshotfoot)) {
            player iprintlnbold("<dev string:x14d>");
          } else {
            player iprintlnbold("<dev string:x15d>");
          }

          player.forceabshotfoot = 0;

          if(!isDefined(level.outlinedplayers[entnum])) {
            level.outlinedplayers[entnum] = player;
            player.outlineidfriend = outlineenableforteam(player, friendlyteam, "outline_nodepth_orange", "level_script");
            player.outlineidenemy = outlineenableforteam(player, enemyteam, "outline_nodepth_red", "level_script");
            player scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_nodepth_orange", 0);
          }
        } else {
          if(isalive(player)) {
            player.hotfootreset = 0;
          }

          player.forceabshotfoot = 0;

          if(isDefined(level.outlinedplayers[entnum])) {
            outlinedisable(player.outlineidfriend, player);
            outlinedisable(player.outlineidenemy, player);
            player scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
            player.outlineidfriend = undefined;
            player.outlineidenemy = undefined;
            level.outlinedplayers[entnum] = undefined;
          }
        }

        player.hotfootdisttraveledsq = 0;
      }

      timepassed = 0;
    }

    level.hotfootabsloops++;
    waitframe();
  }
}

function onhotfootplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  entnum = self getentitynumber();

  if(isDefined(level.outlinedplayers[entnum])) {
    outlinedisable(self.outlineidfriend, self);
    outlinedisable(self.outlineidenemy, self);
    self.outlineidfriend = undefined;
    self.outlineidenemy = undefined;
    level.outlinedplayers[entnum] = undefined;
  }

  self.hotfootreset = 1;
}

function shouldgamelobbyremainintact() {
  axisscore = int(game["teamScores"]["axis"]);
  alliesscore = int(game["teamScores"]["allies"]);
  differential = axisscore - alliesscore;
  return differential < 10;
}

function private function_daa7ba85dff31c58() {
  self endon("game_ended");

  if(!istrue(level.bounty.var_6cec5f1ba131a4b8)) {
    level.bounty.var_6cec5f1ba131a4b8 = 1;
  } else {
    return;
  }

  for(result = undefined; true; result = function_baf79a20f89626fc(level.bounty.hvtrefreshinterval)) {
    teams = level.teamnamelist;

    if(isDefined(result)) {
      teams = [result];

      foreach(player in level.teamdata[result]["players"]) {
        player.var_3675d0d805c111b9 = undefined;
      }
    }

    foreach(teamname in teams) {
      function_73f4370f1b27931f(teamname);
    }

    if(istrue(level.bounty.warnteamhvtchange)) {
      assertex(level.bounty.hvtrefreshinterval > level.bounty.hvtrefreshwarntime, "<dev string:x169>");
      wait level.bounty.hvtrefreshinterval - level.bounty.hvtrefreshwarntime;

      foreach(teamname in level.teamnamelist) {
        scripts\mp\utility\dialog::statusdialog("bounty_new_targets_warning", teamname);

        foreach(player in getteamdata(teamname, "alivePlayers")) {
          player scripts\mp\hud_message::showsplash("bounty_hvt_warn_change");
          player playlocalsound("jup_bounty_hvt_new_target_splash");
        }
      }

      result = function_baf79a20f89626fc(level.bounty.hvtrefreshwarntime);
      continue;
    }
  }
}

function function_baf79a20f89626fc(time) {
  if(!level.bounty.hvtmaxdeathsenabled) {
    wait time;
    return;
  }

  level thread function_71e84653ff2e5194();
  level thread function_da75daeab167eef5(time);
  level thread function_11e8f1d468fb74c5();
  level waittill("waitForMaxDeathsResult", result);
  return result;
}

function function_da75daeab167eef5(time) {
  level endon("waitForMaxDeathsResult");
  wait time;
  level notify("waitForMaxDeathsResult");
}

function function_71e84653ff2e5194() {
  level endon("waitForMaxDeathsResult");
  level waittill("bountyMaxDeaths", team);
  level notify("waitForMaxDeathsResult", team);
}

function function_11e8f1d468fb74c5() {
  level endon("waitForMaxDeathsResult");
  level waittill("bountyDiedUsingRemoteKillstreak", team);
  level notify("waitForMaxDeathsResult", team);
}

function private function_73f4370f1b27931f(teamname, ignoretimestamp) {
  var_fdca194965cd644a = [];
  players = function_4632da5fc05ba940(teamname);

  if(level.bounty.hvts[teamname].size > 0 && scripts\mp\utility\teams::getteamdata(teamname, "players").size <= 1) {
    if(!istrue(ignoretimestamp)) {
      level.bounty.var_b9d8abc30e8b40b8 = gettime();
    }

    return;
  }

  foreach(player in players) {
    if(var_fdca194965cd644a.size < level.bounty.hvtsperteam) {
      if(!scripts\engine\utility::array_contains(level.bounty.hvts[teamname], player)) {
        var_fdca194965cd644a[var_fdca194965cd644a.size] = player;
        continue;
      }
    }

    player playlocalsound("jup_bounty_hvt_new_target_splash");
  }

  scripts\mp\utility\dialog::statusdialog("bounty_new_target", teamname, undefined, var_fdca194965cd644a);

  foreach(player in level.bounty.hvts[teamname]) {
    if(isDefined(player) && !scripts\engine\utility::array_contains(var_fdca194965cd644a, player)) {
      player thread function_ad9beb8e6a905599();
    }
  }

  foreach(player in var_fdca194965cd644a) {
    if(isDefined(player) && !scripts\engine\utility::array_contains(level.bounty.hvts[teamname], player)) {
      player thread function_ac2690ab2da6fa();
    }
  }

  level.bounty.hvts[teamname] = var_fdca194965cd644a;

  if(!istrue(ignoretimestamp)) {
    level.bounty.var_b9d8abc30e8b40b8 = gettime();
  }
}

function private function_ac2690ab2da6fa() {
  self endon("disconnect");
  self endon("bounty_unmarked");
  self notify("bounty_marked");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    self waittill("spawned_player");
  }

  self.nosuspensemusic = 1;

  if(isDefined(self.musicpack) && self.musicpack == 1) {
    self setplayermusicstate("mp_sd_bombplanted_30_playlist_classic");
  } else {
    self setplayermusicstate("mp_sd_bombplanted_30_playlist");
  }

  function_2c66ae09a0a7c438();
  scripts\mp\hud_message::showsplash("bounty_hvt_marked");
  scripts\mp\utility\dialog::leaderdialogonplayer("bounty_become_target");
  self playlocalsound("jup_bounty_hvt_marked_player");
  self playsoundtoteam("jup_bounty_hvt_marked_enemy", self.team, self, self);
  self playsoundtoteam("jup_bounty_hvt_marked_team", getotherteam(self.team)[0], undefined, self);
}

function private function_ad9beb8e6a905599() {
  self endon("disconnect");
  self endon("bounty_marked");
  self notify("bounty_unmarked");
  self.nosuspensemusic = undefined;
  self setplayermusicstate("");
  function_605bbe56b2ce817a();
  waitframe();

  if(isPlayer(self)) {
    if(!scripts\mp\utility\player::isreallyalive(self)) {
      self waittill("spawned_player");
    }

    scripts\mp\hud_message::showsplash("bounty_hvt_unmarked");
    self playlocalsound("uin_splash_bounty_unmarked");
  }
}

function private function_2c66ae09a0a7c438() {
  if(!isDefined(self.trackedobject)) {
    trackedobject = scripts\mp\gameobjects::createtrackedobject(self, (0, 0, 100));
    scripts\mp\objidpoolmanager::objective_set_play_intro(trackedobject.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(trackedobject.objidnum, 0);
    trackedobject.objidpingfriendly = level.bounty.hvtmarkerpingenabled != 0;
    trackedobject.objidpingenemy = 0;
    trackedobject.objpingdelay = level.bounty.hvtmarkerpinginterval;
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
    scripts\mp\objidpoolmanager::function_79a1a16de6b22b2d(trackedobject.pingobjidnum, 0);
  } else {
    self.trackedobject scripts\mp\gameobjects::setvisibleteam("friendly");
    scripts\mp\objidpoolmanager::update_objective_state(self.trackedobject.pingobjidnum, "current");
  }

  if(!isDefined(self.bountyobject)) {
    self.bountyobject = "prop_king_game_flag";
    self attach(self.bountyobject, "tag_stowed_back3", 1);
  }
}

function private function_605bbe56b2ce817a() {
  if(isDefined(self.trackedobject)) {
    if(isDefined(self.trackedobject.pingobjidnum)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(self.trackedobject.pingobjidnum);
      self.trackedobject.pingobjidnum = undefined;
    }

    self.trackedobject scripts\mp\gameobjects::deletetrackedobject();
    self.trackedobject = undefined;
  }

  if(isDefined(self.bountyobject)) {
    self detach(self.bountyobject, "tag_stowed_back3");
    self.bountyobject = undefined;
  }
}

function private function_7a2f8a385da422ff() {
  if(isDefined(self.bountyobject)) {
    attachsize = self getattachsize();

    for(i = 0; i < attachsize; i++) {
      attached = self getattachmodelname(i);

      if(attached == self.bountyobject) {
        return true;
      }
    }
  }

  return false;
}

function private onplayerspawn() {
  if(isDefined(self.bountyobject) && !function_7a2f8a385da422ff()) {
    self attach(self.bountyobject, "tag_stowed_back3", 1);
  }

  if(isDefined(self.trackedobject)) {
    scripts\mp\objidpoolmanager::update_objective_state(self.trackedobject.pingobjidnum, "current");
  }
}

function private onplayerdisconnect(player) {
  if(isDefined(level.bounty.var_b9d8abc30e8b40b8) && scripts\engine\utility::array_contains(level.bounty.hvts[player.team], player)) {
    var_29ca520a8694cd41 = level.bounty.hvtrefreshinterval * 1000;
    hvtrefreshwarntime = level.bounty.hvtrefreshwarntime * 1000 * level.bounty.warnteamhvtchange;
    var_89e85c0815c992d6 = level.bounty.var_b9d8abc30e8b40b8 + var_29ca520a8694cd41 - hvtrefreshwarntime - gettime();

    if(var_89e85c0815c992d6 > 5000) {
      function_73f4370f1b27931f(player.team, 1);
      return;
    }

    player thread function_ad9beb8e6a905599();
    scripts\engine\utility::array_remove(level.bounty.hvts[player.team], player);
  }
}

function private getplayerkills(player) {
  if(!isDefined(player)) {
    player = self;
  }

  return player.pers["kills"];
}

function private function_4d84c1274f53342d(lhs, rhs) {
  return getplayerkills(lhs) > getplayerkills(rhs);
}

function private function_4632da5fc05ba940(teamname) {
  players = level.teamdata[teamname]["players"];
  return array_sort_with_func(players, &function_4d84c1274f53342d);
}