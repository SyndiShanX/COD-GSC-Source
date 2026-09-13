/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\globallogic.gsc
***********************************************/

init() {
  _id_32BF85F7059300D9();
  _id_1A99A9DA2860E4F9();

  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 1) {
    _id_60DD02BEC5783ECD::_id_3433FF82F51BCE6D();

    if(isDefined(game["gameStateRestore"]) && game["gameStateRestore"].gametime == 0)
      game["gameStateRestore"].enabled = 0;

    _id_60DD02BEC5783ECD::setupcallbacks();
  }

  level.leanthread = getdvarint("scr_runlean_playerthread_count", 0) == 1;
  level.script = tolower(getDvar("g_mapname"));
  level.gametype = tolower(getDvar("g_gametype"));
  level.codcasterenabled = getdvarint("com_codcasterenabled", 0) == 1;
  level.systemlink = getdvarint("systemlink", 0) == 1;
  level.playermaxhealth = getdvarint("scr_player_maxhealth");
  level.splitscreen = issplitscreen();
  level.onlinegame = getdvarint("onlinegame");
  level._id_FC96A942BE145B56 = getdvarint("force_ranking", 0) == 1;
  level.rankedmatch = level.onlinegame && !getdvarint("xblive_privatematch") || level._id_FC96A942BE145B56;
  level.matchmakingmatch = level.onlinegame && !getdvarint("xblive_privatematch");
  level.playerxpenabled = level.matchmakingmatch || getdvarint("force_challenges");
  level.weaponxpenabled = level.playerxpenabled;
  level.challengesallowed = level.playerxpenabled || getdvarint("force_challenges");
  level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
  level.onlinestatsenabled = level.rankedmatch;
  level._id_EC2FB549B15AD827 = level.rankedmatch && getdvarint("dvar_5DBEC0FB7158C834");
  level._id_77907D733ABE8B63 = level.rankedmatch && getdvarint("dvar_BEAAC6D270585321");
  level.starttimeutcseconds = getsystemtime();
  scripts\mp\utility\stats::setplayerdatagroups();
  level.framedurationseconds = level.frameduration / 1000;
  level._id_89296580B2860A1F = getdvarint("dvar_34DF621525811B4A", 0);
  level.teambased = 0;
  level.objectivebased = 0;
  level.endgameontimelimit = 1;
  level.showingfinalkillcam = 0;
  level.tispawndelay = getdvarint("scr_tispawndelay", 5);
  level.halftimetype = "halftime";
  level.lastscorestatustime = 0;
  level.waswinning = "none";
  level.lastslowprocessframe = 0;
  level.postroundtime = 4.5;
  registerdvars();
  _id_32E2D220EBF5A876();

  if(scripts\mp\utility\game::matchmakinggame()) {
    _id_D6C112F12A466CA4 = " LB_MAP_" + getDvar("ui_mapname");
    _id_6ECA32E363C48ABB = "";
    _id_5F7B13C1185BC170 = "";
    _id_5F7B13C1185BC170 = "LB_GB_TOTALXP_AT LB_GB_TOTALXP_LT LB_GB_WINS_AT LB_GB_WINS_LT LB_GB_KILLS_AT LB_GB_KILLS_LT LB_GB_ACCURACY_AT LB_ACCOLADES";
    _id_6ECA32E363C48ABB = " LB_GM_" + level.gametype;

    if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19())
      _id_6ECA32E363C48ABB = _id_6ECA32E363C48ABB + "_HC";

    precacheleaderboards(_id_5F7B13C1185BC170 + _id_6ECA32E363C48ABB + _id_D6C112F12A466CA4);
  }

  if(getdvarint("dvar_E6FD98993195C73E", 0) == 1)
    _id_560D1A043E5B1AB2::_id_654D758C46E09DEE();
}

_id_32BF85F7059300D9() {
  level._id_21E8A7768C0260F2 = _func_811510B694DDD963();
  level._id_1A2B600A06EC21F4 = _func_1E231FC15FDAB31D();
  level._id_62F6F7640E4431E3 = _func_90B5B6E99AEF29D6();
  level._id_55F7EC9F66F3468D = _func_79404C2FCCA1C184();
}

_id_1A99A9DA2860E4F9() {
  if(isDefined(level._id_62F6F7640E4431E3) && scripts\engine\utility::_id_53C4C53197386572(level._id_62F6F7640E4431E3._id_0BEFF479639E6508, 0)) {
    if(isDefined(level._id_62F6F7640E4431E3._id_9F2FEDDFE7ED94D3) && level._id_62F6F7640E4431E3._id_9F2FEDDFE7ED94D3 != "")
      setDvar("dvar_7611A2790A0BF7FE", level._id_62F6F7640E4431E3._id_9F2FEDDFE7ED94D3);
  }
}

endmatchonhostdisconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);

    if(player ishost()) {
      _id_50BBC2CAB314EDAB = player;
      break;
    }
  }

  _id_50BBC2CAB314EDAB waittill("disconnect");
  thread scripts\mp\gamelogic::endgame("draw", game["end_reason"]["host_ended_game"]);
}

registerdvars() {
  if(getDvar("r_reflectionprobegenerate") != "1")
    setomnvar("ui_nuke_end_milliseconds", 0);

  setDvar("ui_danger_team", "");
  setDvar("ui_inhostmigration", 0);
  setDvar("ui_override_halftime", 0);
  setDvar("compassMaxRange", 1750);
  setDvar("dvar_687F6FE472201DF1", 1);
  setDvar("dvar_4E5B353BF84974A9", 1);
  _id_CA395A3D2156B928 = getdvarint("dvar_FF21D0D18916F3A1", 0);

  switch (_id_CA395A3D2156B928) {
    case 3:
    case 2:
    case 0:
      setDvar("camera_thirdPerson", 0);
      break;
    case 1:
      setDvar("camera_thirdPerson", 1);
      break;
  }

  registerfalldamagedvars();
  _id_D62A31437E2D4568();
}

registerfalldamagedvars() {
  if(scripts\mp\utility\game::_id_E417D8EF1C70CBCB()) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(getdvarint("dvar_12CA000DD2976EBC", 0)) {
        setDvar("bg_fallDamageMinHeight", 100000000);
        setDvar("bg_fallDamageMaxHeight", 100000001);
        setDvar("bg_softLandingMinHeight", 100000000);
        setDvar("bg_softLandingMaxHeight", 100000001);
      } else {
        setDvar("bg_fallDamageMinHeight", getdvarint("dvar_94069A337A93A89B", 225));
        setDvar("bg_fallDamageMaxHeight", getdvarint("dvar_D11490616A51A529", 560));
        setDvar("bg_softLandingMinHeight", getdvarint("dvar_99D9497632F068BA", 225));
        setDvar("bg_softLandingMaxHeight", getdvarint("dvar_93F558C7BADC14DC", 560));
      }
    } else {
      setDvar("bg_fallDamageMinHeight", getdvarint("dvar_94069A337A93A89B", 225));
      setDvar("bg_fallDamageMaxHeight", getdvarint("dvar_D11490616A51A529", 560));
      setDvar("bg_softLandingMinHeight", getdvarint("dvar_99D9497632F068BA", 225));
      setDvar("bg_softLandingMaxHeight", getdvarint("dvar_93F558C7BADC14DC", 560));
    }
  } else {
    setDvar("bg_fallDamageMinHeight", 225);
    setDvar("bg_fallDamageMaxHeight", 375);
    setDvar("bg_softLandingMinHeight", 225);
    setDvar("bg_softLandingMaxHeight", 375);
  }
}

_id_D62A31437E2D4568() {
  setDvar("dvar_A1EBE22197CB5CC0", 1);
  setDvar("dvar_569C1F8E8857B817", 1);
}

_id_32E2D220EBF5A876() {
  if(isDefined(level.playermaxhealth) && level.playermaxhealth > 100)
    scripts\cp_mp\utility\game_utility::_id_7F8A6A1772BD6F5F();
}

setupcallbacks() {
  setdefaultcallbacks();
  scripts\mp\callbacksetup::setupdamageflags();
  _id_0FD32F08E72B657F::setupcommoncallbacks();
  level.getspawnpoint = ::blank;
  level.onspawnplayer = _id_0FD32F08E72B657F::onspawnplayercommon;
  level.onplayerkilledcommon = _id_0FD32F08E72B657F::onplayerkilledcommon;
  level.onrespawndelay = ::blank;
  level.ontimelimit = scripts\mp\gamelogic::default_ontimelimit;
  level.onhalftime = scripts\mp\gamelogic::default_onhalftime;
  level.ondeadevent = scripts\mp\gamelogic::default_ondeadevent;
  level.ononeleftevent = scripts\mp\gamelogic::default_ononeleftevent;
  level.onprecachegametype = ::blank;
  level.onstartgametype = ::blank;
  level.onplayerkilled = ::blank;

  if(!scripts\mp\utility\game::lpcfeaturegated())
    level.matchrecording_init = scripts\mp\matchrecording::init;

  level.weaponmapfunc = scripts\mp\utility\weapon::mapweapon;
  level.initagentscriptvariables = scripts\mp\agents\agent_utility::initagentscriptvariables;
  level.setagentteam = scripts\mp\agents\agent_utility::set_agent_team;
  level.agentvalidateattacker = scripts\mp\utility\damage::_validateattacker;
  level.agentfunc = scripts\mp\agents\agent_utility::agentfunc;
  level.getfreeagent = scripts\mp\agents\agent_utility::getfreeagent;
  level.addtocharactersarray = scripts\cp_mp\utility\game_utility::addtocharactersarray;
  level.prematchallowfunc = scripts\mp\playerlogic::playerprematchallow;
  level.updategameevents = scripts\mp\gamelogic::updategameevents;
  scripts\engine\utility::create_func_ref("area_swap_begin", _id_4F59428932BB980E::_id_BADA8F1445D6B954);
  scripts\engine\utility::create_func_ref("delete_entity_in_swap", _id_4F59428932BB980E::_id_B682BB16078995E0);
  scripts\engine\utility::create_func_ref("delete_scriptable_in_swap", _id_4F59428932BB980E::_id_E437148FB4069430);
  scripts\engine\utility::create_func_ref("area_swap_complete", _id_4F59428932BB980E::_id_6C99988DD1C91950);
  scripts\mp\mp_agent_damage::register_ai_damage_callbacks();
  _id_6489B5B0C90138D7::setupcallbacks();
  _id_0A96D7B74342A88F::setupcallbacks();
}

setdefaultcallbacks() {
  level.callbackstartgametype = scripts\mp\gamelogic::callback_startgametype;
  level.callbackplayeractive = scripts\mp\playerlogic::callback_playeractive;
  level.callbackplayerconnect = scripts\mp\playerlogic::callback_playerconnect;
  level.callbackplayerdisconnect = scripts\mp\playerlogic::callback_playerdisconnect;
  level.callbackplayerdamage = scripts\mp\damage::callback_playerdamage;
  level.callbackplayerimpaled = scripts\mp\damage::callback_playerimpaled;
  level.callbackplayerkilled = scripts\mp\damage::callback_playerkilled;
  level.callbackplayerlaststand = scripts\mp\damage::callback_playerlaststand;
  level.callbackplayermigrated = scripts\mp\playerlogic::callback_playermigrated;
  level.callbackhostmigration = scripts\mp\hostmigration::callback_hostmigration;
  level.callbackfinishweaponchange = scripts\mp\weapons::callback_finishweaponchange;
  level.callbackspawnpointprecalc = scripts\mp\spawnlogic::codecallbackhandler_spawnpointprecalc;
  level.callbackspawnpointscore = scripts\mp\spawnlogic::codecallbackhandler_spawnpointscore;
  level.callbackspawnpointcritscore = scripts\mp\spawnlogic::codecallbackhandler_spawnpointcritscore;
  level._id_42D9B617BBCA6A42 = scripts\mp\playerlogic::_id_556228E50FF920D9;
  level._id_935C97AA3757676F = scripts\mp\playerlogic::_id_5C9544EF10CB9E0C;
  level._id_CDA3AF1F73639C7C = scripts\mp\playerlogic::_id_2A643088582C8BE3;
}

blank(_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_434849FD34BB4BA0, _id_434850FD34BB5B05, _id_43484FFD34BB58D2, _id_43484EFD34BB569F, _id_43484DFD34BB546C, _id_434854FD34BB63D1, _id_434853FD34BB619E, _id_B34F53DAF7F166C2) {}

debugline(start, end) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 50; _id_AC0E594AC96AA3A8++)
    wait 0.05;
}