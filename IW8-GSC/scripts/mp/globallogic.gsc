/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\globallogic.gsc
***********************************************/

function init() {
  level.leanthread = getdvarint("scr_runlean_playerthread_count", 0) == 1;
  level.script = tolower(getDvar("mapname"));
  level.gametype = tolower(getDvar("g_gametype"));
  level.codcasterenabled = getdvarint("com_codcasterEnabled", 0) == 1;
  level.systemlink = getdvarint("systemlink", 0) == 1;
  level.splitscreen = issplitscreen();
  var_0 = getdvarint("mlg_gamebattles_enable_xp", 0) == 1 || !isgamebattlematch();
  level.onlinegame = getdvarint("onlinegame");
  level.rankedmatch = level.onlinegame && !getdvarint("xblive_privatematch") && var_0 || getdvarint("force_ranking");
  level.matchmakingmatch = level.onlinegame && !getdvarint("xblive_privatematch");
  level.playerxpenabled = level.matchmakingmatch && var_0 || getdvarint("force_ranking");
  level.weaponxpenabled = level.playerxpenabled;
  level.challengesallowed = level.playerxpenabled || getdvarint("debug_challenges");
  level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
  level.onlinestatsenabled = level.rankedmatch;
  level.starttimeutcseconds = getsystemtime();
  scripts\mp\utility\stats::setplayerdatagroups();
  level.framedurationseconds = level.frameduration / 1000;
  level.ref_11AD3 = getdvarint("scr_map_use10v10_objectives", 0);
  level.teambased = 0;
  level.objectivebased = 0;
  level.endgameontimelimit = 1;
  level.showingfinalkillcam = 0;
  level.tispawndelay = getdvarint("scr_tispawndelay");
  level.halftimetype = "halftime";
  level.lastscorestatustime = 0;
  level.waswinning = "none";
  level.lastslowprocessframe = 0;
  level.postroundtime = 4.5;
  level.weaponrootcache = [];
  registerdvars();
  level.grenadeinitialize = &scripts\mp\weapons::grenadeinitialize;

  if(scripts\mp\utility\game::unset_relic_grounded()) {
    ref_131CF();
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_1 = " LB_MAP_" + getDvar("ui_mapname");
    var_2 = "";
    var_3 = "";
    var_3 = "LB_GB_TOTALXP_AT LB_GB_TOTALXP_LT LB_GB_WINS_AT LB_GB_WINS_LT LB_GB_KILLS_AT LB_GB_KILLS_LT LB_GB_ACCURACY_AT LB_ACCOLADES";
    var_2 = " LB_GM_" + level.gametype;

    if(getdvarint("g_hardcore")) {
      var_2 += "_HC";
    }

    precacheleaderboards(var_3 + var_2 + var_1);
    return;
  }
}

function ref_131CF() {
  level.isaxeweapon = &scripts\mp\utility\weapon::isaxeweapon;
  level.long_death_manager = &scripts\mp\damagefeedback::hudicontype;
  level.fixupplayerweapons = &scripts\mp\weapons::fixupplayerweapons;
  level.watchweaponpickup = &scripts\mp\weapons::watchpickup;
  level.hostmigrationwait = &scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause;
}

function endmatchonhostdisconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);

    if(var_0 ishost()) {
      var_1 = var_0;
      break;
    }
  }

  var_1 waittill("disconnect");
  thread scripts\mp\gamelogic::endgame("draw", game["end_reason"]["host_ended_game"]);
}

function registerdvars() {
  if(getDvar("r_reflectionProbeGenerate") != "1") {
    setomnvar("ui_nuke_end_milliseconds", 0);
  }

  setDvar("ui_danger_team", "");
  setDvar("ui_inhostmigration", 0);
  setDvar("ui_override_halftime", 0);
  setDvar("camera_thirdPerson", getdvarint("scr_thirdPerson"));
  setDvar("compassMaxRange", 1750);
  ref_12B1F();
  ref_12B3E();
}

function ref_12B1F() {
  if((scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::unset_relic_landlocked() || scripts\mp\utility\game::vcloseangles()) && getdvarint("scr_game_forceDefaultFallHeight", 0) != 1) {
    setDvar("bg_fallDamageMinHeight", getdvarint("scr_subMap_fallDamageMinHeight", 560));
    setDvar("bg_fallDamageMaxHeight", getdvarint("scr_subMap_fallDamageMaxHeight", 561));
    setDvar("bg_softLandingMinHeight", getdvarint("scr_subMap_softLandingMinHeight", 560));
    setDvar("bg_softLandingMaxHeight", getdvarint("scr_subMap_softLandingMaxHeight", 561));
    return;
  }

  setDvar("bg_fallDamageMinHeight", 200);
  setDvar("bg_fallDamageMaxHeight", 375);
  setDvar("bg_softLandingMinHeight", 200);
  setDvar("bg_softLandingMaxHeight", 375);
}

function ref_12B3E() {
  setDvar("TPKMQLMPP", 1);

  if(scripts\mp\utility\game::unset_relic_grounded()) {
    setDvar("MRQOPPSTQ", 0);
    return;
  }

  setDvar("MRQOPPSTQ", 1);
}

function setupcallbacks() {
  setdefaultcallbacks();
  scripts\mp\callbacksetup::setupdamageflags();
  scripts\mp\gametypes\common::setupcommoncallbacks();
  level.getspawnpoint = &blank;
  level.onspawnplayer = &scripts\mp\gametypes\common::onspawnplayercommon;
  level.onplayerkilledcommon = &scripts\mp\gametypes\common::onplayerkilledcommon;
  level.onrespawndelay = &blank;
  level.ontimelimit = &scripts\mp\gamelogic::default_ontimelimit;
  level.onhalftime = &scripts\mp\gamelogic::default_onhalftime;
  level.ondeadevent = &scripts\mp\gamelogic::default_ondeadevent;
  level.ononeleftevent = &scripts\mp\gamelogic::default_ononeleftevent;
  level.onprecachegametype = &blank;
  level.onstartgametype = &blank;
  level.onplayerkilled = &blank;

  if(!scripts\mp\utility\game::lpcfeaturegated()) {
    level.matchrecording_init = &scripts\mp\matchrecording::init;
  }

  level.weaponmapfunc = &scripts\mp\utility\weapon::mapweapon;
  level.initagentscriptvariables = &scripts\mp\agents\agent_utility::initagentscriptvariables;
  level.setagentteam = &scripts\mp\agents\agent_utility::set_agent_team;
  level.agentvalidateattacker = &scripts\mp\utility\damage::_validateattacker;
  level.agentfunc = &scripts\mp\agents\agent_utility::agentfunc;
  level.getfreeagent = &scripts\mp\agents\agent_utility::getfreeagent;
  level.addtocharactersarray = &scripts\mp\spawnlogic::addtocharactersarray;
  level.prematchallowfunc = &scripts\mp\playerlogic::playerprematchallow;
  level.updategameevents = &scripts\mp\gamelogic::updategameevents;
  scripts\mp\subway_fast_travel\subway_station::register_ai_damage_callbacks();
}

function setdefaultcallbacks() {
  level.callbackstartgametype = &scripts\mp\gamelogic::callback_startgametype;
  level.frontend4 = &scripts\mp\playerlogic::friendlystatuschangedcallback;
  level.callbackplayerconnect = &scripts\mp\playerlogic::callback_playerconnect;
  level.callbackplayerdisconnect = &scripts\mp\playerlogic::callback_playerdisconnect;
  level.callbackplayerdamage = &scripts\mp\damage::callback_playerdamage;
  level.callbackplayerimpaled = &scripts\mp\damage::callback_playerimpaled;
  level.callbackplayerkilled = &scripts\mp\damage::callback_playerkilled;
  level.callbackplayerlaststand = &scripts\mp\damage::callback_playerlaststand;
  level.callbackplayermigrated = &scripts\mp\playerlogic::callback_playermigrated;
  level.callbackhostmigration = &scripts\mp\hostmigration::callback_hostmigration;
  level.callbackfinishweaponchange = &scripts\mp\weapons::callback_finishweaponchange;
  level.callbackspawnpointprecalc = &scripts\mp\spawnlogic::codecallbackhandler_spawnpointprecalc;
  level.callbackspawnpointscore = &scripts\mp\spawnlogic::codecallbackhandler_spawnpointscore;
  level.callbackspawnpointcritscore = &scripts\mp\spawnlogic::codecallbackhandler_spawnpointcritscore;
}

function blank(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

function debugline(var_0, var_1) {
  for(var_2 = 0; var_2 < 50; var_2++) {
    wait 0.05;
  }
}