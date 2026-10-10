/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\war.gsc
***********************************************/

#using script_3d2770dc09c1243;
#using script_4b31b900d74d8e46;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\cranked;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\mgl_mp;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#namespace war;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e()) {
    allowed = scripts\mp\gametypes\mgl_mp::function_e6cabfefe9db5685();
  } else {
    allowed[0] = getgametype();
  }

  scripts\mp\gameobjects::main(allowed);

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

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;
  level.onplayerconnect = &onplayerconnect;

  if(getdvarint(@ "hash_cd7a289c3a33ceda", 0) != 0) {
    level.onplayerkilled = &onhotfootplayerkilled;
  }

  if(function_22ba3797e41fc607()) {
    game["dialog"]["gametype"] = "dx_mp_mmfd_mode_t141_name";
    setdvarifuninitialized(@ "hash_f378eaa0e2c019fa", 8);
    setdvarifuninitialized(@ "hash_225e942096726fc0", 1);
  } else if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    game["dialog"]["gametype"] = "dx_mp_tdmh_mode_t141_name";
  } else {
    game["dialog"]["gametype"] = "dx_mp_tdth_game_uktl_name";
  }

  game["dialog"]["boost"] = "dx_mp_tdth_game_uktl_bost";
  game["dialog"]["offense_obj"] = "dx_mp_tdth_game_uktl_bost";
  game["dialog"]["defense_obj"] = "dx_mp_tdth_game_uktl_bost";
  level.testtdmanywhere = getdvarint(@ "scr_tdmanywhere", 0);
  level.tdmanywhere_dropheight = getdvarfloat(@ "hash_c692d2a11dd6615", 1000);
  level.tdmanywhere_perpenoffset = getdvarfloat(@ "hash_631c58033f43c2dc", 2048);
  level.tdmanywhere_distoffset = getdvarfloat(@ "hash_f314048c87ae28aa", 4092);

  if(istrue(level.testtdmanywhere)) {
    scripts\cp_mp\parachute::initparachutedvars();
  }

  if(matchmakinggame()) {
    level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
  }

  if(namespace_ef54497d29a56093::function_5a60778277d6ae4b()) {
    namespace_ef54497d29a56093::function_d4cc0fe3bc1557bf();
  } else if(scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587() || scripts\cp_mp\utility\game_utility::function_6493ec89ae923684()) {
    scripts\mp\gametypes\mgl_mp::function_ce76a0f1345b7f4f();

    if(scripts\cp_mp\utility\game_utility::function_6493ec89ae923684()) {
      level thread namespace_42d2620e5c90a424::function_5688f09df31647c();
    }
  }

  if(function_2898a9c3d425a919()) {
    function_f3bb4f4911a1beb2("slam", "init");
  }

  level.reinitspawns = &reinitspawns;
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_6e7da31aae47b8e0", 0);
  registerhalftimedvar(getgametype(), 0);
  setdynamicdvar(@ "hash_bb6e8f8d9be104f4", 0);

  if(function_2898a9c3d425a919()) {
    function_f3bb4f4911a1beb2("slam", "initializeMatchRules");
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
    setobjectivetext(entry, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/WAR");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/WAR_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/WAR_HINT");
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

function onplayerconnect(player) {
  if(function_2898a9c3d425a919()) {
    player function_f3bb4f4911a1beb2("slam", "onPlayerConnect");
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function initspawns() {
  if(getdvarint(@ "hash_742caa13b3c2e685")) {
    return;
  }

  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

  if(spawnlogic::function_bff229a11ecd1e34()) {
    spawnlogic::setactivespawnlogic(#"default");
  } else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  } else {
    spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  spawnkey = "tdm";

  if(spawnlogic::function_b17bf43316b9fb08(spawnkey)) {
    spawnlogic::function_afe4709b818e7c9e(spawnkey);
  } else {
    spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
    spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
    spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
    spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
    attackers = spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
    defenders = spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
    spawnlogic::registerspawnset("start_attackers", attackers);
    spawnlogic::registerspawnset("start_defenders", defenders);
    spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn");
    spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn");
    spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_secondary", 1, 1);
    spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_secondary", 1, 1);
    spawns = spawnlogic::getspawnpointarray("mp_tdm_spawn");
    spawnssecondary = spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    spawnlogic::registerspawnset("primary", spawns);
    spawnlogic::registerspawnset("fallback", spawnssecondary);
    spawnlogic::function_48ed29b53fd72775();
  }

  if(istrue(level.testtdmanywhere)) {
    x = getdvarfloat(@ "hash_b6294c84c04e377b", randomfloatrange(-4096, 4096));
    y = getdvarfloat(@ "hash_b6294b84c04e3548", randomfloatrange(-4096, 4096));
    z = getdvarfloat(@ "hash_b6294e84c04e3be1", randomfloatrange(0, 512));
    level.mapcenter = (x, y, z);
    tdmanywhere_debugshowlocs();
    return;
  }

  level.mapcenter = spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function reinitspawns() {
  spawnlogic::function_8390bf8c3b74466a("<dev string:x1c>");
  spawnlogic::function_8390bf8c3b74466a("<dev string:x27>");
  spawns = spawnlogic::getspawnpointarray("<dev string:x33>");
  spawnssecondary = spawnlogic::getspawnpointarray("<dev string:x43>");
  spawnlogic::registerspawnset("<dev string:x1c>", spawns);
  spawnlogic::registerspawnset("<dev string:x27>", spawnssecondary);
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
  } else {
    spawnpoint = spawnlogic::getspawnpointforplayer(self);

    if(!spawnlogic::shoulduseteamstartspawn()) {
      spawncompare(spawnpoint, spawnteam);
    }
  }

  return spawnpoint;
}

function onspawnplayer(revivespawn) {
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");

  if(scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587()) {
    thread scripts\mp\gametypes\mgl_mp::function_f9ae07213a0af3de();
  }

  if(function_2898a9c3d425a919()) {
    function_f3bb4f4911a1beb2("slam", "onSpawnPlayer", revivespawn);
  }

  thread onspawnfinished();

  if(!istrue(level.testtdmanywhere)) {
    return;
  }

  self setplayerangles(vectortoangles(level.mapcenter - self.origin));
}

function onspawnfinished() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(function_d7731b03489e8384() && getdvarint(@ "hash_2f9efd529fe0e6a9", 1)) {
    if(!isDefined(level.var_8e6f4b60841f52f)) {
      level.var_8e6f4b60841f52f = level.crankedbombtimer;
    }

    level.crankedbombtimer = getdvarint(hashcat(@ "hash_3660f6ae7ad12fc9", getDvar(@ "g_mapname")), level.var_8e6f4b60841f52f);
    scripts\mp\cranked::oncranked(undefined, self);
  }
}

function spawncompare(spawnpoint, spawnteam) {
  if(getdvarint(@ "hash_b5ceec3e3cb419be") != 0) {
    spawnpoints = spawnlogic::getteamspawnpoints(spawnteam);
    fallbackspawnpoints = [];
    scriptspawnpoint = scripts\mp\spawnscoring::getspawnpoint_legacy(spawnpoints, fallbackspawnpoints);

    if(!isDefined(level.var_3d292942d52b104a)) {
      level.var_3d292942d52b104a = 0;
      level.var_2dc7108159dc1da3 = 0;
      level.var_a065445ba781ddf6 = 0;
    }

    level.var_3d292942d52b104a++;
    println("<dev string:x5d>" + scriptspawnpoint.index + "<dev string:x78>" + scriptspawnpoint.totalscore);

    if(scriptspawnpoint.index == spawnpoint.index) {
      level.var_2dc7108159dc1da3++;
      iprintlnbold("<dev string:x8e>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xad>" + "<dev string:xbb>" + level.var_2dc7108159dc1da3 + "<dev string:xc0>" + level.var_3d292942d52b104a);
    } else {
      level.var_a065445ba781ddf6++;
      iprintlnbold("<dev string:xc5>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xad>" + "<dev string:xbb>" + level.var_2dc7108159dc1da3 + "<dev string:xc0>" + level.var_3d292942d52b104a);
    }

    return scriptspawnpoint;
  }
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(function_22ba3797e41fc607()) {
    mine = attacker launchgrenade("at_mine_mp", victim.origin + (0, 0, 8), (0, 0, 0));
    attacker playsoundtoplayer("jup_minefield_kill", attacker);
  }

  if(function_2898a9c3d425a919()) {
    function_f3bb4f4911a1beb2("slam", "onNormalDeath", victim, attacker, meansofdeath);
  }

  scripts\mp\gametypes\common::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
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
  self endon("<dev string:xf5>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      points = getdvarint(@ "hash_46a6b424af6acbc2");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x103>", points, 0);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      points = getdvarint(@ "hash_86e14326e43c0115");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x10d>", points, 0);
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
  ents = getEntArray("<dev string:x115>", "<dev string:x123>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  ents = getEntArray("<dev string:x138>", "<dev string:x123>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x115>", "<dev string:x123>");

  foreach(struct in structs) {
    thread scripts\mp\utility\debug::drawsphere(struct.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x138>", "<dev string:x123>");

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
            player iprintlnbold("<dev string:x14e>");
          } else {
            player iprintlnbold("<dev string:x15e>");
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

function function_22ba3797e41fc607() {
  return getDvar(@ "ui_gametype", "war") == "mines";
}

function function_d7731b03489e8384() {
  return getDvar(@ "ui_gametype", "war") == "war_cranked";
}

function function_2898a9c3d425a919() {
  return getDvar(@ "ui_gametype", "war") == "slam";
}