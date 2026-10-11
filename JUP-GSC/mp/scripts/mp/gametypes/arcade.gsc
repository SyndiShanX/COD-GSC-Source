/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\arcade.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#namespace arcade;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
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
  level.blockweapondrops = 1;
  level.denyclasschoice = 1;
  level.bypassclasschoicefunc = &scripts\mp\class::alwaysgamemodeclass;
  function_e88d9ec1d5270bad();
  setDvar(@ "r_identifyoldmaterial", 0);
  setDvar(@ "scr_starsystem", 0);
  scripts\mp\ai_mp_controller::init();
  level.supportsai = 1;

  if(getdvarint(@ "hash_cd7a289c3a33ceda", 0) != 0) {
    level.onplayerkilled = &onhotfootplayerkilled;
  }

  game["dialog"]["gametype"] = "iw9_mtdm_mode_uktl_name";
  game["dialog"]["boost"] = "iw9_mtdm_mode_uktl_bost";
  game["dialog"]["offense_obj"] = "iw9_mtdm_mode_uktl_bost";
  game["dialog"]["defense_obj"] = "iw9_mtdm_mode_uktl_bost";
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

  level.reinitspawns = &reinitspawns;
}

function private function_e88d9ec1d5270bad() {
  assertex(!isDefined(level.aonloadout), "<dev string:x1c>");
  level.aonloadout = [];
  level.aonloadout["loadoutArchetype"] = "archetype_assault";
  level.aonloadout["loadoutPrimary"] = "iw9_me_knife_mp";
  level.aonloadout["loadoutPrimaryAttachment"] = "none";
  level.aonloadout["loadoutPrimaryAttachment2"] = "none";
  level.aonloadout["loadoutPrimaryCamo"] = "none";
  level.aonloadout["loadoutPrimaryReticle"] = "none";
  level.aonloadout["loadoutPrimaryVariantID"] = 0;
  level.aonloadout["loadoutSecondary"] = "iw9_pi_golf17_mp";
  level.aonloadout["loadoutSecondaryAttachment"] = "none";
  level.aonloadout["loadoutSecondaryAttachment2"] = "none";
  level.aonloadout["loadoutSecondaryCamo"] = "none";
  level.aonloadout["loadoutSecondaryReticle"] = "none";
  level.aonloadout["loadoutSecondaryVariantID"] = 0;
  level.aonloadout["loadoutEquipmentPrimary"] = "equip_throwing_knife";
  level.aonloadout["loadoutEquipmentSecondary"] = "none";
  level.aonloadout["loadoutSuper"] = "none";
  level.aonloadout["loadoutStreakType"] = "assault";
  level.aonloadout["loadoutKillstreak1"] = "none";
  level.aonloadout["loadoutKillstreak2"] = "none";
  level.aonloadout["loadoutKillstreak3"] = "none";
  level.aonloadout["loadoutUsingSpecialist"] = 1;
  level.aonloadout["loadoutPerks"] = ["specialty_null"];
  level.aonloadout["loadoutExtraPerks"] = ["specialty_null"];
  level.aonloadout["loadoutGesture"] = "playerData";
  level.aonloadout["loadoutFieldUpgrade1"] = "none";
  level.aonloadout["loadoutFieldUpgrade2"] = "none";
}

function spawn_aliens(player) {
  player endon("death");
  player endon("disconnect");

  while(true) {
    wait 2;
    team = player.pers["team"];

    if(!isDefined(team)) {
      continue;
    }

    ai_team = getotherteam(team)[0];

    if(!isDefined(ai_team)) {
      continue;
    }

    safeorigin = function_ca817bf862167332();

    if(abs(safeorigin[2] - level.player.origin[2]) > 90) {
      wait 1;
      continue;
    }

    angles = flat_angle(vectortoangles(safeorigin - level.player.origin));
    ai = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent("jup_enemy_mp_arcade_alien_01", safeorigin, (0, randomint(360), 0), "high", "everybody", undefined, undefined, ai_team);

    if(isagent(ai)) {
      ai thread find_player();
    }
  }
}

function find_player() {
  ai = self;
  ai endon("death");
  setDvar(@ "ragdoll_max_simulating", 0);

  while(true) {
    ai setgoalpos(getclosestpointonnavmesh(level.player.origin), 16);
    ai.bhasnopath = 0;
    ai.goalradius = 16;
    ai.stealth_enabled = 0;
    ai.pathenemyfightdist = 0;
    ai.noragdoll = 1;
    ai.script_noragdoll = 1;
    ai.liveragdoll = 0;

    if(distance(ai.origin, level.player.origin) < 140) {
      ai kill();
    }

    wait 0.2;
  }
}

function function_ca817bf862167332() {
  dist = 1600;
  x = randomint(dist) * pow(-1, randomint(2));
  y = randomint(dist) * pow(-1, randomint(2));
  safeorigin = getclosestpointonnavmesh(level.player.origin + (x, y, 0));
  return safeorigin;
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_6e7da31aae47b8e0", 0);
  registerhalftimedvar(getgametype(), 0);
  setdynamicdvar(@ "hash_bb6e8f8d9be104f4", 0);
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

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function initspawns() {
  if(getdvarint(@ "hash_742caa13b3c2e685")) {
    return;
  }

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
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x49>");
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x53>");
  spawns = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x5f>");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x6f>");
  scripts\mp\spawnlogic::registerspawnset("<dev string:x49>", spawns);
  scripts\mp\spawnlogic::registerspawnset("<dev string:x53>", spawnssecondary);
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

  spawnpoint.angles = (0, 0, 0);
  return spawnpoint;
}

function onspawnplayer(revivespawn) {
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");
  thread function_c97e11b8cda0d02a();
  level thread spawn_aliens(self);

  if(!istrue(level.testtdmanywhere)) {
    return;
  }

  self setplayerangles(vectortoangles(level.mapcenter - self.origin));
  model = spawn("script_model", self.origin);
}

function function_c97e11b8cda0d02a() {
  upposition = self.origin + (0, 0, 500);
  cament = spawn("script_model", upposition);
  cament setModel("tag_origin");
  cament.angles = vectortoangles(self.origin - upposition);
  self cameralinkTo(cament, "tag_origin");
  cament linkTo(self);
  self freezelookcontrols(1);
  self.plotarmor = 1;
  self setmovespeedscale(3);
  thread run_barrels();
}

function run_barrels() {
  dist = 64;
  num = 3;
  baseangle = 360 / num;

  if(istrue(self.arcade_barrels)) {
    return;
  }

  self.arcade_barrels = 1;
  ent = spawn("script_model", self.origin);
  ent setModel("tag_origin");
  ent thread alwaysrotate();
  ent thread followplayer(self);

  for(i = 0; i < num; i++) {
    angle = i * baseangle;
    offsetx = dist * cos(angle);
    offsety = dist * sin(angle);
    model = spawn("script_model", self.origin + (offsetx, offsety, 0));
    model setModel("me_decor_barrels_01_yellow_black_01");
    model linkTo(ent);
  }
}

function alwaysrotate() {
  while(true) {
    self rotateYaw(360, 3);
    wait 3;
    level.player setclientomnvar("ui_hide_hud", 1);
    level.player thread dropgrenade();
  }
}

function dropgrenade() {
  gren = magicgrenademanual("frag_grenade_mp", level.player.origin + (0, 0, 9), (randomint(30) - 30, randomint(30) - 30, 45));
  wait 0.75;
  gren detonate(level.player);
}

function followplayer(player) {
  while(true) {
    self.origin = player.origin;
    waitframe();
  }
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
    println("<dev string:x89>" + scriptspawnpoint.index + "<dev string:xa4>" + scriptspawnpoint.totalscore);

    if(scriptspawnpoint.index == spawnpoint.index) {
      level.var_2dc7108159dc1da3++;
      iprintlnbold("<dev string:xba>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xd9>" + "<dev string:xe7>" + level.var_2dc7108159dc1da3 + "<dev string:xec>" + level.var_3d292942d52b104a);
    } else {
      level.var_a065445ba781ddf6++;
      iprintlnbold("<dev string:xf1>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xd9>" + "<dev string:xe7>" + level.var_2dc7108159dc1da3 + "<dev string:xec>" + level.var_3d292942d52b104a);
    }

    return scriptspawnpoint;
  }
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
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
  self endon("<dev string:x121>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      points = getdvarint(@ "hash_46a6b424af6acbc2");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x12f>", points, 0);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      points = getdvarint(@ "hash_86e14326e43c0115");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x139>", points, 0);
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
  ents = getEntArray("<dev string:x141>", "<dev string:x14f>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  ents = getEntArray("<dev string:x164>", "<dev string:x14f>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x141>", "<dev string:x14f>");

  foreach(struct in structs) {
    thread scripts\mp\utility\debug::drawsphere(struct.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x164>", "<dev string:x14f>");

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
            player iprintlnbold("<dev string:x17a>");
          } else {
            player iprintlnbold("<dev string:x18a>");
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