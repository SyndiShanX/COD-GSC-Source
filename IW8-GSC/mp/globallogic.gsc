/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\globallogic.gsc
***********************************************/

init() {
  level.leanthread = getdvarint("_encstr_AC801F60CA62BF4BDF7E21AD498BD6A94D72B8A8B3BB698377993D8823E7DB4DB3", 0) == 1;
  level.script = tolower(getDvar("_encstr_9570084B1793A090CDFF"));
  level.gametype = tolower(getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB"));
  level.codcasterenabled = getdvarint("_encstr_B4CC0B9A3D9A9CE915A03DA99A", 0) == 1;
  level.systemlink = getdvarint("_encstr_95B00B1305A628A6159AC9282A", 0) == 1;
  level.splitscreen = issplitscreen();
  var_0 = getdvarint("_encstr_85960BF47CD1C72C799F5B4BBB", 0) == 1 || !isgamebattlematch();
  level.onlinegame = getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7");
  level.rankedmatch = level.onlinegame && !getdvarint("_encstr_93390B136AA2628AA8A93529D4") && var_0 || getdvarint("_encstr_AD460A97B91F0DAE3BDBEF88");
  level.matchmakingmatch = level.onlinegame && !getdvarint("_encstr_93390B136AA2628AA8A93529D4");
  level.playerxpenabled = level.matchmakingmatch && var_0 || getdvarint("_encstr_AD460A97B91F0DAE3BDBEF88");
  level.weaponxpenabled = level.playerxpenabled;
  level.challengesallowed = level.playerxpenabled || getdvarint("_encstr_8C27111AF16EB7BF91B710E151F0C7130469E3");
  level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
  level.onlinestatsenabled = level.rankedmatch;
  level.starttimeutcseconds = getsystemtime();
  scripts\mp\utility\stats::setplayerdatagroups();
  level.framedurationseconds = level.frameduration / 1000;
  level._id_11AD3 = getdvarint("_encstr_A76C1C9BD827AFB6B007FAD53756C4C067C4C0F5DE26D459C6D1963B56E6", 0);
  level.teambased = 0;
  level.objectivebased = 0;
  level.endgameontimelimit = 1;
  level.showingfinalkillcam = 0;
  level.tispawndelay = getdvarint("_encstr_858011CD1B9CEB47A5CD0EB0BBB919591BB05E");
  level.halftimetype = "_encstr_AADE09481E247875C2EFAB";
  level.lastscorestatustime = 0;
  level.waswinning = "_encstr_8BBA05185F8B99";
  level.lastslowprocessframe = 0;
  level.postroundtime = 4.5;
  level.weaponrootcache = [];
  registerdvars();
  level.grenadeinitialize = scripts\mp\weapons::grenadeinitialize;

  if(scripts\mp\utility\game::unset_relic_grounded())
    _id_131CF();

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_1 = "_encstr_8AE709802684EB5305057D" + getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");
    var_2 = "_encstr_B40101";
    var_3 = "_encstr_B40101";
    var_3 = "_encstr_BE957BA825C06FE68129C7C41BC1B8FB68FDA1F68C3657EF41D7D4D719C1F56337D698399999EBD111D527F75B81CA37D72FD6C07DC8875EF99739E647E145C3DF846879252E2F4491B924E347499B5A013D31602D18270CD19133E789C9CE135E3648B816FFCFF6215519839B69AE3BC7CC90D1BDA6773D015B148DE7";
    var_2 = "_encstr_975108042690FAA39A7D" + level.gametype;

    if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
      var_2 = var_2 + "_encstr_871A04FA420D";

    precacheleaderboards(var_3 + var_2 + var_1);
  }
}

_id_131CF() {
  level.isaxeweapon = scripts\mp\utility\weapon::isaxeweapon;
  level.long_death_manager = scripts\mp\damagefeedback::hudicontype;
  level.fixupplayerweapons = scripts\mp\weapons::fixupplayerweapons;
  level.watchweaponpickup = scripts\mp\weapons::watchpickup;
  level.hostmigrationwait = scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause;
}

endmatchonhostdisconnect() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(var_0 ishost()) {
      var_1 = var_0;
      break;
    }
  }

  var_1 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  thread scripts\mp\gamelogic::endgame("_encstr_AF660584E6F107", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B84D100B771EE3FFB05897DFF1890F4AF98B"]);
}

registerdvars() {
  if(getDvar("_encstr_8F7A0BD1E5E15304B8CF7989FF") != "_encstr_A34C02BB")
    setomnvar("_encstr_9BA519C8C73F90B3E217E88DAD6A9FB8614B889007DDC94F9A7FF6", 0);

  setDvar("_encstr_8CBA0F5DBC1129F1B64FE050C7C4095B5A", "_encstr_B40101");
  setDvar("_encstr_A9E413E3C01707FE01A0B31317DF99C3336B2B2788", 0);
  setDvar("_encstr_88F615F34B379803A955865A6D455F48EB18957397B8FA", 0);
  setDvar("_encstr_82570B397A4D3192935192A562", getdvarint("_encstr_88C210F3A9FEB7D3900B928C51D09ADFA8E0"));
  setDvar("_encstr_BA3D0B5DAA0743D2A78910C999", 1750);
  _id_12B1F();
  _id_12B3E();
}

_id_12B1F() {
  if((scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" || scripts\mp\utility\game::unset_relic_landlocked() || scripts\mp\utility\game::vcloseangles()) && getdvarint("_encstr_A9812050C790BF47E2512747CE3A3BD7FF9DA7914EC3129CCD1768825BD2F409E313", 0) != 1) {
    setDvar("_encstr_8EB10B48F101F2EBF4BEDDDCD6", getdvarint("_encstr_A71C1FF05AF2CF1BAFE2213FE8DF617BDD12C1F8D24EE791670148B3D56F09D103", 560));
    setDvar("_encstr_B8610BC5BCB99F08E167979F37", getdvarint("_encstr_BAEE1F4E9B3316E75B2A791023F9F569E30C4DCFFD2759038DE2C8616A0CBF807B", 561));
    setDvar("_encstr_B6A30B7A9AC413984596A2D429", getdvarint("_encstr_A609205B01560FAAD045C5F179597207F45B20E2C8258FA568F3E9F621E0BC9F2BB3", 560));
    setDvar("_encstr_91210B8D31359451D7313824D9", getdvarint("_encstr_B41A209B8D93BE9BD5986A8507F5DCDB991D892C3791A5B9EC350B8712AC2DB3431D", 561));
  } else {
    setDvar("_encstr_8EB10B48F101F2EBF4BEDDDCD6", 200);
    setDvar("_encstr_B8610BC5BCB99F08E167979F37", 375);
    setDvar("_encstr_B6A30B7A9AC413984596A2D429", 200);
    setDvar("_encstr_91210B8D31359451D7313824D9", 375);
  }
}

_id_12B3E() {
  setDvar("_encstr_85500AB58A2803BFDCBF01F9", 1);

  if(scripts\mp\utility\game::unset_relic_grounded())
    setDvar("_encstr_8C610AD4A415D3280AA92A15", 0);
  else
    setDvar("_encstr_8C610AD4A415D3280AA92A15", 1);
}

setupcallbacks() {
  setdefaultcallbacks();
  scripts\mp\callbacksetup::setupdamageflags();
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::setupcommoncallbacks();
  level.getspawnpoint = ::blank;
  level.onspawnplayer = _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::onspawnplayercommon;
  level.onplayerkilledcommon = _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::onplayerkilledcommon;
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
  level.addtocharactersarray = scripts\mp\spawnlogic::addtocharactersarray;
  level.prematchallowfunc = scripts\mp\playerlogic::playerprematchallow;
  level.updategameevents = scripts\mp\gamelogic::updategameevents;
  scripts\mp\subway\fast_travel_subway_station::register_ai_damage_callbacks();
}

setdefaultcallbacks() {
  level.callbackstartgametype = scripts\mp\gamelogic::callback_startgametype;
  level.frontend4 = scripts\mp\playerlogic::friendlystatuschangedcallback;
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
}

blank(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

debugline(var_0, var_1) {
  for(var_2 = 0; var_2 < 50; var_2++)
    wait 0.05;
}