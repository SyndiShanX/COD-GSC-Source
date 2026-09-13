/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arena.gsc
***********************************************/

main() {
  game["isLaunchChunk"] = getdvarint("fastfilealtlaunch", 0) != 0;

  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  level._id_B5538188C80D8AF6 = [];
  _id_58553518A66CEBE9 = getEntArray("cyber_emp_pickup_trig", "targetname");

  foreach(trig in _id_58553518A66CEBE9)
  level._id_B5538188C80D8AF6[level._id_B5538188C80D8AF6.size] = trig.origin;

  level._id_CE291B847F8E2AB7 = (0, 0, 0);
  primaryflags = getEntArray("flag_primary", "targetname");

  foreach(flag in primaryflags) {
    if(flag.script_label == "_b") {
      level._id_CE291B847F8E2AB7 = flag.origin;
      break;
    }
  }

  if(level._id_B5538188C80D8AF6.size == 0)
    level._id_B5538188C80D8AF6[level._id_B5538188C80D8AF6.size] = level._id_CE291B847F8E2AB7;

  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[1] = "dom";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(game["isLaunchChunk"]) {
    _id_03D918DD819F36DF::main();
    return;
  }

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 24);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 30);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 19);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 6);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinbytwoenableddvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinbytwomaxroundsdvar(scripts\mp\utility\game::getgametype(), 4);
  }

  updategametypedvars();
  level.teambased = 1;
  level.objectivebased = 1;
  level.overridetimelimitclock = 10;
  level.ontimelimit = ::ontimelimit;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerdamaged = ::onplayerdamaged;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerkilled = ::onplayerkilled;
  level.modeonspawnplayer = ::onspawnplayer;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimitot = ::ontimelimitot;
  level.allowlatecomers = 0;
  level.removekilleventsplash = 1;

  if(scripts\mp\utility\game::matchmakinggame()) {
    _id_0774C9CA5D1D6221 = getdvarint("party_maxplayers", 4) / 2;
    level.requiredplayercountoveride = 1;
    level.requiredplayercount["allies"] = _id_0774C9CA5D1D6221;
    level.requiredplayercount["axis"] = _id_0774C9CA5D1D6221;
  }

  if(!scripts\mp\utility\game::iswinbytworulegametype())
    level.skipdefendersadvantage = 1;

  if(!_id_18F22ECED61C5F6F()) {
    level.disablecopycatloadout = 1;
    setomnvar("ui_killcam_copycat", 0);
    level.bypassclasschoicefunc = scripts\mp\class::alwaysgamemodeclass;
  } else
    level.disablecopycatloadout = undefined;

  level.arenaknivesout = getknivesoutsetting();

  if(level.arenaknivesout) {
    level.gamemodeoverridemeleeviewkickscale = 0.5;
    level.gamemodeoverriderestockrechargeperupdate = 0.05;
  }

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_m_overwinter") {
    level.snowballfight = 1;
    level.alwayssnowfight = getdvarint("scr_always_snowfight", 0);

    if(level.alwayssnowfight)
      level.practiceround = 0;
    else
      level.practiceround = 1;
  }

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_gnft_mode_uktl_gft1";
  else
    game["dialog"]["gametype"] = "iw9_gnft_mode_uktl_gfnm";

  if(ispickuploadouts() && !isDefined(game["roundsPlayed"])) {
    game["dialog"]["offense_obj"] = "boost_arena_pickups";
    game["dialog"]["defense_obj"] = "boost_arena_pickups";
  } else if(_id_444E57E02C02BEE6() && !isDefined(game["roundsPlayed"])) {
    game["dialog"]["offense_obj"] = "boost_arena_objective";
    game["dialog"]["defense_obj"] = "boost_arena_objective";
  } else {
    game["dialog"]["offense_obj"] = "iw9_gnft_mode_uktl_gfbo";
    game["dialog"]["defense_obj"] = "iw9_gnft_mode_uktl_gfbo";
  }

  game["dialog"]["obj_indepth"] = "boost_arena_indepth";
  game["dialog"]["securing_a"] = "iw9_gnft_mode_uktl_gfsg";
  game["dialog"]["secured_a"] = "iw9_gnft_mode_uktl_gfsd";
  game["dialog"]["losing_a"] = "iw9_gnft_mode_uktl_gflg";
  game["dialog"]["lost_a"] = "iw9_gnft_mode_uktl_gflt";
  game["dialog"]["round_success"] = "round_win";
  game["dialog"]["round_failure"] = "round_lose";
  game["dialog"]["mission_success"] = "gamestate_win";
  game["dialog"]["mission_failure"] = "gamestate_lost";
  level.allieshealth = 0;
  level.alliesmaxhealth = 0;
  level.axishealth = 0;
  level.axismaxhealth = 0;
  level.usedspawnposone["allies"] = 0;
  level.usedspawnpostwo["allies"] = 0;
  level.usedspawnposthree["allies"] = 0;
  level.usedspawnposone["axis"] = 0;
  level.usedspawnpostwo["axis"] = 0;
  level.usedspawnposthree["axis"] = 0;
  setomnvar("ui_arena_allies_health", 0);
  setomnvar("ui_arena_axis_health", 0);
  setomnvar("ui_arena_allies_health_max", 100);
  setomnvar("ui_arena_axis_health_max", 100);
  setomnvar("ui_arena_primaryVariantID", -1);
  setomnvar("ui_arena_secondaryVariantID", -1);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_arena_arenaloadouts", getmatchrulesdata("arenaData", "arenaLoadouts"));
  setdynamicdvar("scr_arena_loadoutchangeround", getmatchrulesdata("arenaData", "loadoutChangeRound"));
  setdynamicdvar("scr_arena_switchspawns", getmatchrulesdata("arenaData", "switchSpawns"));
  setdynamicdvar("scr_arena_winCondition", getmatchrulesdata("arenaData", "winCondition"));
  setdynamicdvar("scr_arena_objmodifier", getmatchrulesdata("arenaData", "objModifier"));
  setdynamicdvar("dvar_C4DD1397DA8407BE", getmatchrulesdata("arenaData", "overtimeFlag"));
  setdynamicdvar("scr_arena_flagcapturetime", getmatchrulesdata("arenaData", "flagCaptureTime"));
  setdynamicdvar("dvar_CA4CDFBC3778ABED", getmatchrulesdata("arenaData", "flagHoldTimer"));
  setdynamicdvar("dvar_BC7F17452D7D2BC4", getmatchrulesdata("arenaData", "flagActivationDelay"));
  setdynamicdvar("scr_arena_tacticaltimemod", getmatchrulesdata("arenaData", "tacticalTimeMod"));
  setdynamicdvar("scr_arena_blastshieldmod", getmatchrulesdata("arenaData", "blastShieldMod"));
  setdynamicdvar("scr_arena_blastshieldclamp", getmatchrulesdata("arenaData", "blastShieldClamp"));
  setdynamicdvar("scr_arena_startWeapon", getmatchrulesdata("arenaData", "startWeapon"));
  setdynamicdvar("scr_arena_weapontier1", getmatchrulesdata("arenaData", "weaponTier1"));
  setdynamicdvar("scr_arena_weapontier2", getmatchrulesdata("arenaData", "weaponTier2"));
  setdynamicdvar("scr_arena_weapontier3", getmatchrulesdata("arenaData", "weaponTier3"));
  setdynamicdvar("scr_arena_weapontier4", getmatchrulesdata("arenaData", "weaponTier4"));
  setdynamicdvar("scr_arena_weapontier5", getmatchrulesdata("arenaData", "weaponTier5"));
  setdynamicdvar("scr_arena_weapontier6", getmatchrulesdata("arenaData", "weaponTier6"));
  setdynamicdvar("scr_arena_weapontier7", getmatchrulesdata("arenaData", "weaponTier7"));
  setdynamicdvar("scr_arena_weapontier8", getmatchrulesdata("arenaData", "weaponTier8"));
  setdynamicdvar("dvar_CE087F3B0E67C668", getmatchrulesdata("arenaData", "arenaAttachments"));
  setdynamicdvar("dvar_193CC5A02EE3D815", getmatchrulesdata("arenaData", "arenaSuper"));
  setdynamicdvar("dvar_0C110A01FB151DA3", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
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

  if(game[game["attackers"]] == "SAS")
    game["dialog"]["offense_obj"] = "iw9_gwtd_mode_uktl_gtbs";
  else if(game[game["defenders"]] == "SAS")
    game["dialog"]["defense_obj"] = "iw9_gwtd_mode_uktl_gtbs";

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/WAR");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/WAR_HINT");
  }

  initspawns();
  _id_10CEA0880B71973A();
  _id_B7C18DED2347456C();
  _id_DE46980D57F0C37A();

  if(game["roundsPlayed"] == 0)
    level thread setroundwinstreakarray();

  thread adjustroundendtimer();
  thread waittooverridegraceperiod();
  _id_5ABEE6062A481F8C = 1;

  if(istrue(level.snowballfight)) {
    if(!level.alwayssnowfight && game["roundsPlayed"] == 0 && istrue(game["practiceRound"])) {
      level.extratime = 30;
      game["didSnowFight"] = 1;
      level.arenaloadouts = 3;
      _id_5ABEE6062A481F8C = 0;
    } else if(level.alwayssnowfight) {
      level.arenaloadouts = 3;
      _id_5ABEE6062A481F8C = 0;
    }

    level.snowfx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
    level.snowfx["screen"] = loadfx("vfx/iw8/weap/_impact/snowball/vfx_imp_snowball_scrn.vfx");
    snowballfight();
  }

  if(_id_5ABEE6062A481F8C) {
    if(israndomloadouts())
      thread updaterandomloadout();
    else if(ispickuploadouts()) {
      if(!isDefined(game["roundsPlayed"]) || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        level.startweapon.weapon = getrandomweaponforweapontier(level.startweapon.weapon);
        level.arenaweapont1.weapon = getrandomweaponforweapontier(level.arenaweapont1.weapon);
        level.arenaweapont2.weapon = getrandomweaponforweapontier(level.arenaweapont2.weapon);
        level.arenaweapont3.weapon = getrandomweaponforweapontier(level.arenaweapont3.weapon);
        level.arenaweapont4.weapon = getrandomweaponforweapontier(level.arenaweapont4.weapon);
        level.arenaweapont5.weapon = getrandomweaponforweapontier(level.arenaweapont5.weapon);
        level.arenaweapont6.weapon = getrandomweaponforweapontier(level.arenaweapont6.weapon);
        level.arenaweapont7.weapon = getrandomweaponforweapontier(level.arenaweapont7.weapon);
        level.arenaweapont8.weapon = getrandomweaponforweapontier(level.arenaweapont8.weapon);
        level.startweapon.variantid = _id_11A6A3EC5C206652(level.startweapon.weapon);
        level.arenaweapont1.variantid = _id_11A6A3EC5C206652(level.arenaweapont1.weapon);
        level.arenaweapont2.variantid = _id_11A6A3EC5C206652(level.arenaweapont2.weapon);
        level.arenaweapont3.variantid = _id_11A6A3EC5C206652(level.arenaweapont3.weapon);
        level.arenaweapont4.variantid = _id_11A6A3EC5C206652(level.arenaweapont4.weapon);
        level.arenaweapont5.variantid = _id_11A6A3EC5C206652(level.arenaweapont5.weapon);
        level.arenaweapont6.variantid = _id_11A6A3EC5C206652(level.arenaweapont6.weapon);
        level.arenaweapont7.variantid = _id_11A6A3EC5C206652(level.arenaweapont7.weapon);
        level.arenaweapont8.variantid = _id_11A6A3EC5C206652(level.arenaweapont8.weapon);
      } else if(level.loadoutchangeround == 0 || game["roundsPlayed"] % level.loadoutchangeround != 0) {
        level.startweapon.weapon = game["startWeapon"]["weapon"];
        level.arenaweapont1.weapon = game["arenaWeaponT1"]["weapon"];
        level.arenaweapont2.weapon = game["arenaWeaponT2"]["weapon"];
        level.arenaweapont3.weapon = game["arenaWeaponT3"]["weapon"];
        level.arenaweapont4.weapon = game["arenaWeaponT4"]["weapon"];
        level.arenaweapont5.weapon = game["arenaWeaponT5"]["weapon"];
        level.arenaweapont6.weapon = game["arenaWeaponT6"]["weapon"];
        level.arenaweapont7.weapon = game["arenaWeaponT7"]["weapon"];
        level.arenaweapont8.weapon = game["arenaWeaponT8"]["weapon"];
        level.startweapon.variantid = game["startWeapon"]["variantID"];
        level.arenaweapont1.variantid = game["arenaWeaponT1"]["variantID"];
        level.arenaweapont2.variantid = game["arenaWeaponT2"]["variantID"];
        level.arenaweapont3.variantid = game["arenaWeaponT3"]["variantID"];
        level.arenaweapont4.variantid = game["arenaWeaponT4"]["variantID"];
        level.arenaweapont5.variantid = game["arenaWeaponT5"]["variantID"];
        level.arenaweapont6.variantid = game["arenaWeaponT6"]["variantID"];
        level.arenaweapont7.variantid = game["arenaWeaponT7"]["variantID"];
        level.arenaweapont8.variantid = game["arenaWeaponT8"]["variantID"];
      } else if(game["roundsPlayed"] % level.loadoutchangeround == 0) {
        level.startweapon.weapon = getrandomweaponforweapontier(level.startweapon.weapon);
        level.arenaweapont1.weapon = getrandomweaponforweapontier(level.arenaweapont1.weapon);
        level.arenaweapont2.weapon = getrandomweaponforweapontier(level.arenaweapont2.weapon);
        level.arenaweapont3.weapon = getrandomweaponforweapontier(level.arenaweapont3.weapon);
        level.arenaweapont4.weapon = getrandomweaponforweapontier(level.arenaweapont4.weapon);
        level.arenaweapont5.weapon = getrandomweaponforweapontier(level.arenaweapont5.weapon);
        level.arenaweapont6.weapon = getrandomweaponforweapontier(level.arenaweapont6.weapon);
        level.arenaweapont7.weapon = getrandomweaponforweapontier(level.arenaweapont7.weapon);
        level.arenaweapont8.weapon = getrandomweaponforweapontier(level.arenaweapont8.weapon);
        level.startweapon.variantid = _id_11A6A3EC5C206652(level.startweapon.weapon);
        level.arenaweapont1.variantid = _id_11A6A3EC5C206652(level.arenaweapont1.weapon);
        level.arenaweapont2.variantid = _id_11A6A3EC5C206652(level.arenaweapont2.weapon);
        level.arenaweapont3.variantid = _id_11A6A3EC5C206652(level.arenaweapont3.weapon);
        level.arenaweapont4.variantid = _id_11A6A3EC5C206652(level.arenaweapont4.weapon);
        level.arenaweapont5.variantid = _id_11A6A3EC5C206652(level.arenaweapont5.weapon);
        level.arenaweapont6.variantid = _id_11A6A3EC5C206652(level.arenaweapont6.weapon);
        level.arenaweapont7.variantid = _id_11A6A3EC5C206652(level.arenaweapont7.weapon);
        level.arenaweapont8.variantid = _id_11A6A3EC5C206652(level.arenaweapont8.weapon);
      }

      game["startWeapon"]["weapon"] = level.startweapon.weapon;
      game["arenaWeaponT1"]["weapon"] = level.arenaweapont1.weapon;
      game["arenaWeaponT2"]["weapon"] = level.arenaweapont2.weapon;
      game["arenaWeaponT3"]["weapon"] = level.arenaweapont3.weapon;
      game["arenaWeaponT4"]["weapon"] = level.arenaweapont4.weapon;
      game["arenaWeaponT5"]["weapon"] = level.arenaweapont5.weapon;
      game["arenaWeaponT6"]["weapon"] = level.arenaweapont6.weapon;
      game["arenaWeaponT7"]["weapon"] = level.arenaweapont7.weapon;
      game["arenaWeaponT8"]["weapon"] = level.arenaweapont8.weapon;
      game["startWeapon"]["variantID"] = level.startweapon.variantid;
      game["arenaWeaponT1"]["variantID"] = level.arenaweapont1.variantid;
      game["arenaWeaponT2"]["variantID"] = level.arenaweapont2.variantid;
      game["arenaWeaponT3"]["variantID"] = level.arenaweapont3.variantid;
      game["arenaWeaponT4"]["variantID"] = level.arenaweapont4.variantid;
      game["arenaWeaponT5"]["variantID"] = level.arenaweapont5.variantid;
      game["arenaWeaponT6"]["variantID"] = level.arenaweapont6.variantid;
      game["arenaWeaponT7"]["variantID"] = level.arenaweapont7.variantid;
      game["arenaWeaponT8"]["variantID"] = level.arenaweapont8.variantid;
      level.lethaldelay = 0;
      defineplayerloadout();

      if(!istrue(level.snowballfight)) {
        initweaponmap();
        thread setupweapons();
      }
    } else if(isgungameloadouts()) {
      level.blockweapondrops = 1;
      thread updatearenagungameloadout(0);
    } else if(isrvsgungameloadouts()) {
      level.blockweapondrops = 1;
      thread updatearenagungameloadout(1);
    }
  }

  if(!_id_18F22ECED61C5F6F())
    buildloadoutsforweaponstreaming();

  setupwaypointicons();
  seticonnames();

  switch (level.objmodifier) {
    case 1:
      level setupendzones();
      break;
    case 2:
      level _id_5BBA7F02DBB91B52();
      break;
    default:
      break;
  }

  if(level._id_E940D922CA35FCD4 > 0 && !_id_2EDA32F1D16DED2C())
    level thread spawngameendflagzone();

  updatetournamentroundtime(scripts\mp\gamelogic::gettimeremaining(), 0);

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level thread outlineenemyplayers();
    level thread removeenemyoutlines();
  }
}

waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.overrideingraceperiod = 1;
  level.ingraceperiod = 5;
}

adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 4.0;
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();

  if(level.dogtagsenabled) {
    level.dogtagallyonusecb = ::dogtagallyonusecb;
    level.dogtagenemyonusecb = ::dogtagenemyonusecb;
  }

  level.arenaloadouts = scripts\mp\utility\dvars::dvarintvalue("arenaLoadouts", 1, 1, 16);
  level.loadoutchangeround = scripts\mp\utility\dvars::dvarintvalue("loadoutChangeRound", 3, 0, 5);
  level.switchspawns = scripts\mp\utility\dvars::dvarintvalue("switchSpawns", 1, 0, 1);
  level.wincondition = scripts\mp\utility\dvars::dvarintvalue("winCondition", 1, 0, 2);
  level._id_56E1B10AF8966681 = scripts\mp\utility\dvars::dvarintvalue("winStreakCamos", 0, 0, 1);
  setomnvar("ui_arena_loadout_type", level.arenaloadouts);
  setomnvar("ui_wincondition", level.wincondition);
  level.objmodifier = scripts\mp\utility\dvars::dvarintvalue("objModifier", 0, 0, 4);

  if(!_id_2EDA32F1D16DED2C())
    setomnvar("ui_single_flag_loc", -3);

  level._id_E940D922CA35FCD4 = scripts\mp\utility\dvars::dvarfloatvalue("overtimeFlag", 10, 0, 30);

  if(level._id_E940D922CA35FCD4 > 0) {
    level.ontimelimitgraceperiod = level._id_E940D922CA35FCD4;
    level.currenttimelimitdelay = 0.0;
    level.canprocessot = 1;
  }

  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 3, 0, 30);
  level._id_300E0902DDC99C1B = scripts\mp\utility\dvars::dvarfloatvalue("flagHoldTimer", 5, 0, 30);
  level.flagactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("flagActivationDelay", 15, 0, 30);
  level.tacticaltimemod = scripts\mp\utility\dvars::dvarfloatvalue("tacticalTimeMod", 2.5, 0.5, 5);
  level.startweapon = spawnStruct();
  level.arenaweapont1 = spawnStruct();
  level.arenaweapont2 = spawnStruct();
  level.arenaweapont3 = spawnStruct();
  level.arenaweapont4 = spawnStruct();
  level.arenaweapont5 = spawnStruct();
  level.arenaweapont6 = spawnStruct();
  level.arenaweapont7 = spawnStruct();
  level.arenaweapont8 = spawnStruct();
  level.startweapon.weapon = getDvar("scr_arena_startWeapon", "none");
  level.arenaweapont1.weapon = getDvar("scr_arena_weapontier1", "iw9_pi_golf17");
  level.arenaweapont2.weapon = getDvar("scr_arena_weapontier2", "iw9_sh_mike1014");
  level.arenaweapont3.weapon = getDvar("scr_arena_weapontier3", "iw9_sm_mpapa5");
  level.arenaweapont4.weapon = getDvar("scr_arena_weapontier4", "iw9_ar_mike4");
  level.arenaweapont5.weapon = getDvar("scr_arena_weapontier5", "iw9_sn_alpha50");
  level.arenaweapont6.weapon = getDvar("scr_arena_weapontier6", "equip_frag");
  level.arenaweapont7.weapon = getDvar("scr_arena_weapontier7", "equip_concussion");
  level.arenaweapont8.weapon = getDvar("scr_arena_weapontier8", "equip_adrenaline");
  level.arenapickupattachments = getdvarint("dvar_CE087F3B0E67C668", 0);

  if(level.arenaloadouts == 1) {
    setDvar("dvar_3C357661CD222B4D", 1);
    level.allowperks = 1;
  }

  level._id_10E2EBD08FAC3FAF = getDvar("dvar_193CC5A02EE3D815", "none");

  if(level._id_10E2EBD08FAC3FAF == "none")
    setomnvar("ui_disable_fieldupgrades", 1);

  level._id_320BE3D1AF4EF493 = getdvarint("dvar_3F64B5787462CD52", 1);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  _id_1CF8BE03FB3C42DE = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_allies_start");
  _id_68C73806E24FF493 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_axis_start");
  _id_EBB5693CE8D3A200 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn");

  if(_id_1CF8BE03FB3C42DE.size > 0 || _id_68C73806E24FF493.size > 0) {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_arena_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_arena_spawn_axis_start");
    level.alliesstartspawn = "mp_arena_spawn_allies_start";
    level.axisstartspawn = "mp_arena_spawn_axis_start";
  } else {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
    level.alliesstartspawn = "mp_sd_spawn_attacker";
    level.axisstartspawn = "mp_sd_spawn_defender";
  }

  if(_id_EBB5693CE8D3A200.size > 0) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_arena_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_arena_spawn");
    level.spawntype = "mp_arena_spawn";
  } else {
    _id_EBB5693CE8D3A200 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

    if(_id_EBB5693CE8D3A200.size > 0) {
      scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
      scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
      level.spawntype = "mp_tdm_spawn";
    } else
      level.alwaysusestartspawns = 1;
  }

  primary = scripts\mp\spawnlogic::getspawnpointarray(level.spawntype);
  _id_EFDC2688D5BFF83F = scripts\mp\spawnlogic::getspawnpointarray(level.spawntype);
  scripts\mp\spawnlogic::registerspawnset("normal", primary);
  scripts\mp\spawnlogic::registerspawnset("fallback", _id_EFDC2688D5BFF83F);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

validatespawns(_id_700A871A46435669) {
  _id_ECBE28103D8BA707 = 0;
  _id_ECBE29103D8BA93A = 0;
  _id_ECBE2A103D8BAB6D = 0;
  _id_E89636DADEA5A56A = 0;
  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(_id_700A871A46435669);

  foreach(s in spawnpoints) {
    if(isDefined(s.script_noteworthy)) {
      if(!_id_ECBE28103D8BA707)
        _id_ECBE28103D8BA707 = s.script_noteworthy == "1";
      else {}

      if(!_id_ECBE29103D8BA93A)
        _id_ECBE29103D8BA93A = s.script_noteworthy == "2";
      else {}

      if(!_id_ECBE2A103D8BAB6D) {
        _id_ECBE2A103D8BAB6D = s.script_noteworthy == "3";
        level.hasthreespawns = 1;
      } else {}

      continue;
    }

    if(_id_E89636DADEA5A56A == 0) {
      s.script_noteworthy = "1";
      _id_E89636DADEA5A56A++;
      continue;
    }

    if(_id_E89636DADEA5A56A == 1) {
      s.script_noteworthy = "2";
      _id_E89636DADEA5A56A++;
      continue;
    }

    if(_id_E89636DADEA5A56A == 2) {
      s.script_noteworthy = "3";
      _id_E89636DADEA5A56A++;
      level.hasthreespawns = 1;
    }
  }
}

getspawnpoint() {
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  spawnpoint = undefined;
  _id_700A871A46435669 = level.axisstartspawn;
  _id_AA57738EDF8A8169 = 0;

  if(self.pers["team"] == game["attackers"])
    _id_700A871A46435669 = level.alliesstartspawn;

  if(getdvarint("scr_arena_force_spawn_noteworthy", 0) > 0) {
    scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(_id_700A871A46435669);
    spawnpoint = _id_E77A290B26C3E849(spawnpoints, scripts\engine\utility::string(getdvarint("scr_arena_force_spawn_noteworthy", 0)));
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn() || istrue(level.alwaysusestartspawns) || isintournament()) {
    scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(_id_700A871A46435669);

    if(istrue(level.switchspawns) && game["roundsPlayed"] > 0) {
      _id_49ED3F681FAF7163 = scripts\mp\utility\teams::getteamcount(self.pers["team"]);

      if(_id_49ED3F681FAF7163 > 3) {
        foreach(player in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
          if(isDefined(player.pers["arena_spawn_pos"]))
            player.pers["arena_spawn_pos"] = "0";
        }

        _id_AA57738EDF8A8169 = 1;
      }
    }

    if(istrue(level.switchspawns) && game["roundsPlayed"] > 0 && !_id_AA57738EDF8A8169) {
      if(self.pers["arena_spawn_pos"] == "1")
        self.pers["arena_spawn_pos"] = "2";
      else if(scripts\mp\utility\teams::getteamcount(self.pers["team"], 0) == 3 && istrue(level.hasthreespawns) && self.pers["arena_spawn_pos"] == "2")
        self.pers["arena_spawn_pos"] = "3";
      else if(self.pers["arena_spawn_pos"] == "3")
        self.pers["arena_spawn_pos"] = "1";
      else
        self.pers["arena_spawn_pos"] = "1";

      spawnpoint = getswitchside_spawnpoint(spawnpoints, self.pers["arena_spawn_pos"]);
    }

    if(!isDefined(spawnpoint)) {
      if(istrue(self.switching_teams_arena) && isDefined(self.pers["arena_spawn_pos"])) {
        cleanupspawn_scriptnoteworthy();
        spawnpoint = getspawnpoint_startspawn(spawnpoints);
        self.switching_teams_arena = undefined;

        if(isDefined(spawnpoint))
          self.spawnpointangles = spawnpoint.angles;
      } else {
        spawnpoint = getspawnpoint_startspawn(spawnpoints);

        if(isDefined(spawnpoint))
          self.spawnpointangles = spawnpoint.angles;
      }

      if(!isDefined(spawnpoint)) {
        _id_49ED3F681FAF7163 = scripts\mp\utility\teams::getteamcount(self.pers["team"]);

        if(_id_49ED3F681FAF7163 > 3) {
          buddyspawnplayer = undefined;
          _id_836289E1016F3C1B = 0;

          foreach(player in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
            if(istrue(player.buddyspawnplayer)) {
              _id_836289E1016F3C1B++;
              continue;
            }

            break;
          }

          foreach(player in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
            if(player == self) {
              continue;
            }
            if(istrue(player.buddyspawnplayer)) {
              continue;
            }
            if(!istrue(player.hasspawned)) {
              continue;
            }
            if(isDefined(player.pers["arena_spawn_pos"])) {
              if(level.usedspawnposone[self.pers["team"]] == 1 && level.usedspawnpostwo[self.pers["team"]] == 1 && level.usedspawnposthree[self.pers["team"]] == 1) {
                level.usedspawnposone[self.pers["team"]] = 0;
                level.usedspawnpostwo[self.pers["team"]] = 0;
                level.usedspawnposthree[self.pers["team"]] = 0;
              }

              if(player.pers["arena_spawn_pos"] == "1" && level.usedspawnposone[self.pers["team"]] == 0) {
                level.usedspawnposone[self.pers["team"]]++;
                player.buddyspawnplayer = 1;
                buddyspawnplayer = player;
                break;
              } else if(player.pers["arena_spawn_pos"] == "2" && level.usedspawnpostwo[self.pers["team"]] == 0) {
                level.usedspawnpostwo[self.pers["team"]]++;
                player.buddyspawnplayer = 1;
                buddyspawnplayer = player;
                break;
              } else if(player.pers["arena_spawn_pos"] == "3" && level.usedspawnposthree[self.pers["team"]] == 0) {
                level.usedspawnposthree[self.pers["team"]]++;
                player.buddyspawnplayer = 1;
                buddyspawnplayer = player;
                break;
              } else {
                level.usedspawnposone[self.pers["team"]]++;
                player.buddyspawnplayer = 1;
                buddyspawnplayer = player;
                break;
              }
            }
          }

          if(isDefined(buddyspawnplayer)) {
            spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(buddyspawnplayer);

            if(isDefined(buddyspawnplayer.spawnpointangles))
              spawnpoint.angles = buddyspawnplayer.spawnpointangles;
          }
        }
      }

      if(!isDefined(spawnpoint)) {
        scripts\mp\spawnlogic::activatespawnset("normal");
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], "normal", "fallback");
      }

      if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "" && istrue(level.switchspawns) && game["roundsPlayed"] == 0)
        self.pers["arena_spawn_pos"] = spawnpoint.script_noteworthy;
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], "normal", "fallback");
  }

  return spawnpoint;
}

cleanupspawn_scriptnoteworthy() {
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];

  if(otherteam == game["attackers"]) {
    _id_700A871A46435669 = level.alliesstartspawn;
    _id_55AF954984FC6A2A = level.axisstartspawn;
  } else {
    _id_700A871A46435669 = level.axisstartspawn;
    _id_55AF954984FC6A2A = level.alliesstartspawn;
  }

  _id_CB5363AB35B26AEA = scripts\mp\spawnlogic::getspawnpointarray(_id_700A871A46435669);

  foreach(s in _id_CB5363AB35B26AEA) {
    if(s.script_noteworthy == self.pers["arena_spawn_pos"])
      s.selected = 0;
  }

  _id_CB5363AB35B26AEA = scripts\mp\spawnlogic::getspawnpointarray(_id_55AF954984FC6A2A);

  foreach(s in _id_CB5363AB35B26AEA) {
    foreach(player in scripts\mp\utility\teams::getteamdata(self.pers["team"], "players")) {
      if(player != self && isDefined(player.pers["arena_spawn_pos"]) && s.script_noteworthy != player.pers["arena_spawn_pos"])
        s.selected = 0;
    }
  }
}

getspawnpoint_startspawn(spawnpoints, _id_728D3544BA462895) {
  if(!isDefined(spawnpoints))
    return undefined;

  _id_B8D119D2C9609296 = undefined;
  spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns(spawnpoints);

  foreach(spawnpoint in spawnpoints) {
    if(!isDefined(spawnpoint.selected)) {
      continue;
    }
    if(spawnpoint.selected) {
      continue;
    }
    if(spawnpoint.script_noteworthy == "1") {
      _id_B8D119D2C9609296 = spawnpoint;
      break;
    } else if(spawnpoint.script_noteworthy == "2") {
      _id_B8D119D2C9609296 = spawnpoint;
      break;
    }

    _id_B8D119D2C9609296 = spawnpoint;
  }

  if(isDefined(_id_B8D119D2C9609296))
    _id_B8D119D2C9609296.selected = 1;

  return _id_B8D119D2C9609296;
}

getswitchside_spawnpoint(spawnpoints, _id_2B71CDD2F02EB67B) {
  if(!isDefined(spawnpoints))
    return undefined;

  _id_CEE9D4C5101C6EAD = 0;

  foreach(spawnpoint in spawnpoints) {
    if(spawnpoint.script_noteworthy == _id_2B71CDD2F02EB67B) {
      if(istrue(spawnpoint.selected)) {
        _id_CEE9D4C5101C6EAD = 1;
        continue;
      }

      spawnpoint.selected = 1;
      return spawnpoint;
    }
  }

  return undefined;
}

_id_E77A290B26C3E849(spawnpoints, _id_2B71CDD2F02EB67B) {
  if(!isDefined(spawnpoints))
    return undefined;

  _id_CEE9D4C5101C6EAD = 0;

  foreach(spawnpoint in spawnpoints) {
    if(spawnpoint.script_noteworthy == _id_2B71CDD2F02EB67B)
      return spawnpoint;
  }
}

_id_403DCA95AD44DB03(spawnpoints) {
  color = (0, 0, 0);

  foreach(s in spawnpoints) {
    if(isDefined(s.script_noteworthy)) {
      if(s.script_noteworthy == "1")
        color = (1, 0, 0);
      else if(s.script_noteworthy == "2")
        color = (0, 1, 0);
      else if(s.script_noteworthy == "3")
        color = (0, 0, 1);
      else
        color = (1, 1, 1);

      thread scripts\cp_mp\utility\debug_utility::drawsphere(s.origin, 32, 20, color);
    }
  }
}

onplayerconnect(player) {
  if(istrue(level.allowkillstreaks))
    level.allowkillstreaks = 0;

  player.arenadamage = 0;
  player scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(player.pers["damage"]))
    player scripts\mp\utility\stats::setextrascore0(player.pers["damage"]);

  if(!_id_18F22ECED61C5F6F()) {
    level.denyclasschoice = 1;
    player scripts\mp\class::_id_A16868D4DCD81A4B();

    if(israndomloadouts())
      player.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
    else if(ispickuploadouts())
      player.pers["gamemodeLoadout"] = level._id_B128EFAE25AC7CC6;
    else if(isgungameloadouts() || isrvsgungameloadouts()) {
      player.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][getgungameloadoutindex(player)];

      if(game["roundsPlayed"] == 0)
        player setenemyloadoutomnvars();
    }
  }

  if(istrue(level.switchspawns) && !isDefined(player.pers["arena_spawn_pos"]))
    player.pers["arena_spawn_pos"] = "0";

  player thread onjoinedteam();

  if(!_id_18F22ECED61C5F6F())
    player _id_0FD32F08E72B657F::updatehighpriorityweapons();

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
}

onplayerdisconnect(player) {
  setteamhealthhud(1);
}

onjoinedteam() {
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
    setteamhealthhud();
  }
}

onspawnplayer(_id_9156B53BCF7CE573) {
  thread onspawnfinished();
  level notify("spawned_player");
  thread updatematchstatushintonspawn();
  _id_76CC264B397DB9CB::updatesquadomnvars(self.team, self._id_0FF97225579DE16A);
}

onspawnfinished() {
  self endon("death_or_disconnect");

  if(istrue(game["practiceRound"]) || istrue(level.alwayssnowfight))
    thread snowballmeleewatcher();

  thread damagewatcher();

  if(!_id_18F22ECED61C5F6F()) {
    self waittill("giveLoadout");
    runarenaloadoutrulesonplayer(self);
  }

  thread modifyblastshieldperk();

  if(level.arenaknivesout)
    scripts\mp\utility\perk::giveperk("specialty_quickswap");

  wait 0.1;
  self.hasarenaspawned = 1;
  wait 0.15;

  if(!scripts\mp\flags::gameflag("prematch_done") && game["roundsPlayed"] == 0) {
    if(level._id_E940D922CA35FCD4 > 0 && isDefined(level.matchcountdowntime) && level.matchcountdowntime > 5) {
      if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
        scripts\mp\utility\dialog::leaderdialogonplayer("obj_indepth", "introboost");
    }

    level scripts\engine\utility::waittill_any_2("prematch_done", "removeArenaOutlines");
  }

  self setclientomnvar("ui_player_notify_loadout", gettime());
}

setteamhealthhud(_id_051C0C03BB238C17) {
  _id_586DC9DC0CF668AD = getdvarint("scr_player_maxhealth", 100);
  _id_2005D12681400473 = scripts\mp\utility\teams::getteamdata("allies", "teamCount");

  if(_id_2005D12681400473) {
    level.alliesmaxhealth = scripts\mp\utility\teams::getteamdata("allies", "teamCount") * _id_586DC9DC0CF668AD;
    setomnvar("ui_arena_allies_health_max", level.alliesmaxhealth);

    if(!istrue(_id_051C0C03BB238C17) && !scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn())
      self waittill("spawned_player");

    allieshealth = 0;

    foreach(player in scripts\mp\utility\teams::getteamdata("allies", "players"))
    allieshealth = allieshealth + player.health;

    level.allieshealth = allieshealth;

    if(level.allieshealth < 0)
      level.allieshealth = 0;

    setomnvar("ui_arena_allies_health", level.allieshealth);
  } else
    setomnvar("ui_arena_allies_health", 0);

  _id_650728BA49299C62 = scripts\mp\utility\teams::getteamdata("axis", "teamCount");

  if(_id_650728BA49299C62) {
    level.axismaxhealth = scripts\mp\utility\teams::getteamdata("axis", "teamCount") * _id_586DC9DC0CF668AD;
    setomnvar("ui_arena_axis_health_max", level.axismaxhealth);

    if(!istrue(_id_051C0C03BB238C17) && !scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::mayspawn())
      self waittill("spawned_player");

    axishealth = 0;

    foreach(player in scripts\mp\utility\teams::getteamdata("axis", "players"))
    axishealth = axishealth + player.health;

    level.axishealth = axishealth;

    if(level.axishealth < 0)
      level.axishealth = 0;

    setomnvar("ui_arena_axis_health", level.axishealth);
  } else
    setomnvar("ui_arena_axis_health", 0);
}

modifyblastshieldperk() {
  if(scripts\mp\utility\perk::_hasperk("specialty_blastshield")) {
    blastshieldmod = scripts\mp\utility\dvars::dvarintvalue("blastShieldMod", 0.65, 0, 1.0);

    if(blastshieldmod == 0)
      scripts\mp\utility\perk::removeperk("specialty_blastshield");
  }
}

onplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, _id_FCDF19E3CDD29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  if(isDefined(eattacker) && eattacker != victim && isPlayer(eattacker)) {
    if(istrue(level.snowballfight) && (objweapon.basename == "snowball_mp" || objweapon.basename == "pball_mp"))
      playfxontagforclients(level.snowfx["screen"], victim, "tag_eye", victim);

    if(idamage >= _id_FCDF19E3CDD29669)
      idamage = _id_FCDF19E3CDD29669;

    eattacker.arenadamage = eattacker.arenadamage + idamage;
    eattacker scripts\mp\persistence::statsetchild("round", "damage", eattacker.pers["damage"]);
    eattacker scripts\mp\utility\stats::setextrascore0(eattacker.pers["damage"]);
  }
}

damagewatcher() {
  self notify("startDamageWatcher");
  self endon("startDamageWatcher");
  level endon("game_ended");
  self endon("disconnect");
  self.totaldamagetaken = 0;

  for(;;) {
    scripts\engine\utility::waittill_any_7("damage", "force_regeneration", "removeAdrenaline", "healed", "naturalHealthRegen", "vampirism", "spawned_player");

    if(self.team == "allies") {
      allieshealth = 0;

      foreach(player in scripts\mp\utility\teams::getteamdata("allies", "players"))
      allieshealth = allieshealth + player.health;

      level.allieshealth = allieshealth;

      if(level.allieshealth < 0)
        level.allieshealth = 0;

      setomnvar("ui_arena_allies_health", level.allieshealth);
    } else {
      axishealth = 0;

      foreach(player in scripts\mp\utility\teams::getteamdata("axis", "players"))
      axishealth = axishealth + player.health;

      level.axishealth = axishealth;

      if(level.axishealth < 0)
        level.axishealth = 0;

      setomnvar("ui_arena_axis_health", level.axishealth);
    }

    if(istrue(self.iscapturing)) {
      _id_D3AE4CB68808AAA8 = undefined;

      if(_id_444E57E02C02BEE6()) {
        if(self.team == game["defenders"]) {
          level.attackerendzone.curprogress = 50;
          level.attackerendzone.teamprogress[self.team] = 50;
          _id_D3AE4CB68808AAA8 = level.attackerendzone;
        } else if(self.team == game["attackers"]) {
          level.defenderendzone.curprogress = 50;
          level.defenderendzone.teamprogress[self.team] = 50;
          _id_D3AE4CB68808AAA8 = level.defenderendzone;
        }

        scripts\mp\objidpoolmanager::objective_set_progress(_id_D3AE4CB68808AAA8.objidnum, _id_D3AE4CB68808AAA8.curprogress / _id_D3AE4CB68808AAA8.usetime);
      }
    }
  }
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  if(!_id_18F22ECED61C5F6F()) {
    if(isbot(victim))
      victim.classcallback = "gamemode";
  }

  if(game["state"] == "postgame")
    attacker.finalkill = 1;
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  _id_76CC264B397DB9CB::updatesquadomnvars(self.team, self._id_0FF97225579DE16A);

  if(!_id_18F22ECED61C5F6F()) {
    if(isbot(self))
      self.classcallback = "gamemode";
  }

  if(isDefined(attacker) && (objweapon.basename == "snowball_mp" || objweapon.basename == "pball_mp"))
    attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_1A706E2BEEB19324");

  thread checkallowspectating();
}

checkallowspectating() {
  waitframe();
  update = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    update = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    update = 1;
  }

  if(update)
    scripts\mp\spectating::updatespectatesettings();
}

ontimelimit() {
  if(level.gameended) {
    return;
  }
  updatetournamentroundtime(scripts\mp\gamelogic::gettimeremaining(), 3);

  if(_id_2EDA32F1D16DED2C()) {
    if(level._id_59A1F917FB3131A6 != "neutral")
      level thread scripts\mp\gamelogic::endgame(level._id_59A1F917FB3131A6, game["end_reason"]["ko_flag_win"], game["end_reason"]["ko_flag_loss"]);
    else if(level.wincondition == 1)
      checkliveswinner();
    else if(level.wincondition == 2)
      checkhealthwinner();
    else
      checkhealthwinner();
  } else if(level.wincondition == 1)
    checkliveswinner();
  else if(level.wincondition == 2)
    checkhealthwinner();
  else
    checkhealthwinner();
}

ontimelimitot() {
  if(_id_2EDA32F1D16DED2C()) {
    if(level._id_59A1F917FB3131A6 != "neutral")
      level thread scripts\mp\gamelogic::endgame(level._id_59A1F917FB3131A6, game["end_reason"]["ko_flag_win"], game["end_reason"]["ko_flag_loss"]);
  }

  updatetournamentroundtime(scripts\mp\gamelogic::gettimeremaining(), 1);
  level thread startotmechanics();
}

checkliveswinner() {
  if(scripts\mp\utility\teams::getteamdata("allies", "aliveCount") > scripts\mp\utility\teams::getteamdata("axis", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("allies", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
  } else if(scripts\mp\utility\teams::getteamdata("axis", "aliveCount") > scripts\mp\utility\teams::getteamdata("allies", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("axis", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
  } else
    checkhealthwinner();
}

checkhealthwinner() {
  if(level.axishealth < level.allieshealth) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("allies", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
  } else if(level.allieshealth < level.axishealth) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("axis", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
  } else if(scripts\mp\utility\game::matchmakinggame()) {
    if(isintournament()) {
      game["canScoreOnTie"] = 1;

      if(game["finalRound"] == 1) {
        game["canScoreOnTie"] = 0;

        if(!isDefined(game["roundsTied"]))
          game["roundsTied"] = 1;
        else
          game["roundsTied"]++;

        if(game["roundsTied"] >= 2) {
          _id_D1C52BD1768483B2 = scripts\mp\gamelogic::getbetterteam();
          thread scripts\mp\gamelogic::endgame(_id_D1C52BD1768483B2, game["end_reason"]["arena_tournament_tie_win"], game["end_reason"]["arena_tournament_tie_loss"]);
        } else
          thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
      } else
        thread arena_endgame("tie", game["end_reason"]["cyber_tie"]);
    } else {
      if(!isDefined(game["roundsTied"]))
        game["roundsTied"] = 1;
      else
        game["roundsTied"]++;

      game["canScoreOnTie"] = game["roundsTied"] >= 2;

      if(game["canScoreOnTie"])
        thread arena_endgame("tie", game["end_reason"]["cyber_tie"]);
      else
        thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
    }
  } else
    thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
}

ondeadevent(team) {
  if(istrue(level.ingraceperiod)) {
    return;
  }
  if(team == game["attackers"])
    level thread arena_endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  else if(team == game["defenders"])
    level thread arena_endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
}

ontimelimitdeadevent(team) {}

checkshouldallowtradekilltie(_id_EC15CE3E7A9D1D86) {
  livescount = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  livescount[_id_F90358454413407F] = 0;

  foreach(player in level.players) {
    if(!istrue(player.hasspawned) || player.team == "spectator" || player.team == "codcaster") {
      continue;
    }
    livescount[player.team] = livescount[player.team] + player.pers["lives"];
  }

  _id_4351D3695CBE4FD7 = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount")) {
      _id_4351D3695CBE4FD7 = 1;
      break;
    }
  }

  _id_3ED276C562480671 = 0;

  foreach(count in livescount) {
    if(count) {
      _id_3ED276C562480671 = 1;
      break;
    }
  }

  if(!_id_4351D3695CBE4FD7 && !_id_3ED276C562480671)
    return "tie";

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(!scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount") && !livescount[_id_F90358454413407F]) {
      if(level.multiteambased) {
        if(!scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "deathEvent") && scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "hasSpawned")) {
          scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "deathEvent", 1);
          return _id_EC15CE3E7A9D1D86;
        }
      } else
        return _id_EC15CE3E7A9D1D86;
    }
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_80E6B407B360EC22 = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount") == 1;

    if(_id_80E6B407B360EC22) {
      _id_91595DB4CCF80384 = 0;
      _id_43E4262D6EA97013 = undefined;
      players = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players");

      foreach(player in players) {
        if(!isalive(player))
          _id_91595DB4CCF80384 = _id_91595DB4CCF80384 + player.pers["lives"];
      }

      if(_id_91595DB4CCF80384 == 0) {
        if(!scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "oneLeft") && gettime() > scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "oneLeftTime") + 5000) {
          scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "oneLeftTime", gettime());
          scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "oneLeft", 1);

          if(players.size > 1)
            return _id_EC15CE3E7A9D1D86;
        }
      }

      continue;
    }

    scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "oneLeft", 0);
  }

  return _id_EC15CE3E7A9D1D86;
}

arena_endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_8E4A26ED257A393B) {
  if(_id_EC15CE3E7A9D1D86 != "tie") {
    if(istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
      return;
    }
    waittillframeend;
    _id_EC15CE3E7A9D1D86 = checkshouldallowtradekilltie(_id_EC15CE3E7A9D1D86);
  }

  if(isgungameloadouts() || isrvsgungameloadouts())
    level setenemyloadoutomnvarsatmatchend(_id_EC15CE3E7A9D1D86);

  if(_id_EC15CE3E7A9D1D86 != "tie") {
    game["roundsTied"] = 0;
    game["previousWinningTeam"] = _id_EC15CE3E7A9D1D86;

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(_id_F90358454413407F == _id_EC15CE3E7A9D1D86) {
        game["roundWinStreak"][_id_EC15CE3E7A9D1D86]++;
        continue;
      }

      game["roundWinStreak"][_id_F90358454413407F] = 0;
    }

    if(!scripts\mp\utility\game::iswinbytworulegametype()) {
      switch (game["roundWinStreak"][_id_EC15CE3E7A9D1D86]) {
        case 2:
          game["dialog"]["round_success"] = "round_win_streak_2";
          break;
        case 3:
          game["dialog"]["round_success"] = "round_win_streak_3";
          break;
        case 4:
          game["dialog"]["round_success"] = "round_win_streak_4";
          break;
        case 5:
          _id_C077C467A67F3354 = scripts\mp\utility\game::getroundswon(_id_EC15CE3E7A9D1D86);
          winlimit = scripts\mp\utility\dvars::getwatcheddvar("winlimit");

          if(winlimit == 6 && _id_C077C467A67F3354 != winlimit - 1)
            game["dialog"]["round_success"] = "round_win_streak_5";

          break;
        default:
          break;
      }
    }

    if(game["finalRound"] == 1) {
      if(game["roundWinStreak"][_id_EC15CE3E7A9D1D86] > 3)
        game["dialog"]["mission_success"] = "gamestate_win_comeback";
    }
  } else
    game["previousWinningTeam"] = "";

  scripts\cp_mp\pet_watch::update2v2progress();
  thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_8E4A26ED257A393B);
}

setroundwinstreakarray() {
  foreach(_id_F90358454413407F in level.teamnamelist)
  game["roundWinStreak"][_id_F90358454413407F] = 0;
}

runarenaloadoutrulesonplayer(player) {
  swaploadout = 0;

  if(ispickuploadouts()) {
    if(game["roundsPlayed"] == 0)
      wait 0.1;
    else
      wait 0.25;
  } else if(israndomarloadouts() || israndomsmgloadouts() || israndompistolloadouts() || israndomshotgunloadouts() || israndomsniperloadouts() || israndomlmgloadouts()) {
    if(getdvarint("dvar_CC279143B9185777", 0) == 0) {
      player.pers["gamemodeLoadout"]["loadoutSecondary"] = "none";
      swaploadout = 1;
    }
  }

  if(istrue(level._id_56E1B10AF8966681)) {
    player.pers["gamemodeLoadout"]["loadoutPrimaryCamo"] = _id_3DD5B16653C57B45(player.pers["team"]);
    player.pers["gamemodeLoadout"]["loadoutSecondaryCamo"] = _id_3DD5B16653C57B45(player.pers["team"]);
    swaploadout = 1;
  }

  if(istrue(swaploadout))
    player scripts\mp\class::swaploadout();
}

buildloadoutsforweaponstreaming() {
  level.loadweapons = [];

  if(ispickuploadouts()) {
    if(level.startweapon.weapon == "none" || issubstr(level.startweapon.weapon, "equip")) {
      _id_DD515FCF025B2E79 = "iw9_me_fists_mp";
      _id_66B3DB972AC1531E = makeweapon(_id_DD515FCF025B2E79);
      _id_DD515FCF025B2E79 = getcompleteweaponname(_id_66B3DB972AC1531E);
    } else {
      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(level.startweapon.weapon);
      attachments = [];
      camoname = "none";
      _id_6A42D475DFB96A31 = "none";
      variantid = undefined;
      _id_F3464D71F01F614E = undefined;
      cosmeticattachment = undefined;
      stickers = undefined;

      if(ispickupblueprintloadouts())
        _id_66B3DB972AC1531E = _id_2669878CF5A1B6BC::buildweapon_blueprint(_id_AB501F397D3CD312, camoname, _id_6A42D475DFB96A31, level.startweapon.variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers);
      else
        _id_66B3DB972AC1531E = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, camoname, _id_6A42D475DFB96A31, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers);

      _id_DD515FCF025B2E79 = getcompleteweaponname(_id_66B3DB972AC1531E);
    }

    level.loadweapons[level.loadweapons.size] = _id_66B3DB972AC1531E;
  } else {
    _id_BC002676438672C9 = [];
    _id_2AEE5A9B1A165F09 = [];
    loadout = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
    primary = loadout["loadoutPrimary"];
    _id_D7B9856A19F9B6B5 = loadout["loadoutSecondary"];

    if(primary != "none")
      _id_BC002676438672C9[_id_BC002676438672C9.size] = _id_CEAF8A81FF311F20(primary, loadout);

    if(_id_D7B9856A19F9B6B5 != "none")
      _id_2AEE5A9B1A165F09[_id_2AEE5A9B1A165F09.size] = _id_CEAF8A81FF311F20(_id_D7B9856A19F9B6B5, loadout);

    if(level.loadoutchangeround != 0) {
      _id_A9C56228C41ECDA0 = game["arenaRandomLoadoutIndex"] + 1;

      if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size - 1)
        _id_A9C56228C41ECDA0 = 0;

      _id_C3D433AF5F864E84 = game["arenaRandomLoadout"][_id_A9C56228C41ECDA0];
      _id_C03D6DD4BFB14C5A = _id_C3D433AF5F864E84["loadoutPrimary"];
      _id_FCCB1D1573E7F2A6 = _id_C3D433AF5F864E84["loadoutSecondary"];

      if(_id_C03D6DD4BFB14C5A != "none")
        _id_BC002676438672C9[_id_BC002676438672C9.size] = _id_CEAF8A81FF311F20(_id_C03D6DD4BFB14C5A, _id_C3D433AF5F864E84);

      if(_id_FCCB1D1573E7F2A6 != "none")
        _id_2AEE5A9B1A165F09[_id_2AEE5A9B1A165F09.size] = _id_CEAF8A81FF311F20(_id_FCCB1D1573E7F2A6, _id_C3D433AF5F864E84);
    }

    level.loadweapons = scripts\engine\utility::array_combine(_id_BC002676438672C9, _id_2AEE5A9B1A165F09);
  }
}

_id_CEAF8A81FF311F20(weaponname, loadout) {
  _id_E38B4E99059A1F48 = undefined;

  if(weaponname == loadout["loadoutPrimary"])
    _id_E38B4E99059A1F48 = "loadoutPrimary";
  else if(weaponname == loadout["loadoutSecondary"])
    _id_E38B4E99059A1F48 = "loadoutSecondary";

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(loadout[_id_E38B4E99059A1F48]);
  variantid = loadout[_id_E38B4E99059A1F48 + "VariantID"];

  if(_id_C0C1519B5CFB9BD5()) {
    _id_06B62DB6EEC868E2 = _id_2669878CF5A1B6BC::buildweapon_blueprint(_id_AB501F397D3CD312, undefined, undefined, variantid);
    return getcompleteweaponname(_id_06B62DB6EEC868E2);
  }

  attachments = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 5; _id_AC0E594AC96AA3A8++) {
    _id_AB0F600188412CF1 = _id_AC0E594AC96AA3A8;

    if(_id_AC0E594AC96AA3A8 == 1)
      _id_AB0F600188412CF1 = "";

    attachment = loadout[_id_E38B4E99059A1F48 + "Attachment" + _id_AB0F600188412CF1];

    if(attachment != "none")
      attachments[attachments.size] = attachment;
  }

  camoname = loadout[_id_E38B4E99059A1F48 + "Camo"];
  _id_6A42D475DFB96A31 = loadout[_id_E38B4E99059A1F48 + "Reticle"];
  _id_06B62DB6EEC868E2 = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, camoname, _id_6A42D475DFB96A31, variantid);
  return getcompleteweaponname(_id_06B62DB6EEC868E2);
}

setupblueprintpickupweapons() {
  level.arenaweapont1 = buildblueprintpickupweapon(level.arenaweapont1);
  level.arenaweapont2 = buildblueprintpickupweapon(level.arenaweapont2);
  level.arenaweapont3 = buildblueprintpickupweapon(level.arenaweapont3);
  level.arenaweapont4 = buildblueprintpickupweapon(level.arenaweapont4);
  level.arenaweapont5 = buildblueprintpickupweapon(level.arenaweapont5);
  level.arenaweapont6 = buildblueprintpickupweapon(level.arenaweapont6);
  level.arenaweapont7 = buildblueprintpickupweapon(level.arenaweapont7);
  level.arenaweapont8 = buildblueprintpickupweapon(level.arenaweapont8);
}

buildblueprintpickupweapon(_id_D44EB44714E9FB44) {
  _id_D44EB44714E9FB44.weapon = _id_D44EB44714E9FB44.weapon;

  if(!issubstr(_id_D44EB44714E9FB44.weapon, "equip") && _id_D44EB44714E9FB44.weapon != "none") {
    attachments = [];
    camoname = "none";
    _id_6A42D475DFB96A31 = "none";
    variantid = _id_D44EB44714E9FB44.variantid;
    _id_F3464D71F01F614E = undefined;
    cosmeticattachment = undefined;
    stickers = [];
    stickers[0] = "none";
    stickers[1] = "none";
    stickers[2] = "none";
    stickers[3] = "none";
    stickers[4] = "none";
    _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_D44EB44714E9FB44.weapon);
    _id_D44EB44714E9FB44.weaponobj = _id_2669878CF5A1B6BC::buildweapon_blueprint(_id_AB501F397D3CD312, undefined, undefined, variantid, undefined, undefined, scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4());
  }

  return _id_D44EB44714E9FB44;
}

setupstartweaponsattachments() {
  level.startweapon = setupweaponattachmentoverrides(level.startweapon);
  level.arenaweapont1 = setupweaponattachmentoverrides(level.arenaweapont1);
  level.arenaweapont2 = setupweaponattachmentoverrides(level.arenaweapont2);
  level.arenaweapont3 = setupweaponattachmentoverrides(level.arenaweapont3);
  level.arenaweapont4 = setupweaponattachmentoverrides(level.arenaweapont4);
  level.arenaweapont5 = setupweaponattachmentoverrides(level.arenaweapont5);
  level.arenaweapont6 = setupweaponattachmentoverrides(level.arenaweapont6);
  level.arenaweapont7 = setupweaponattachmentoverrides(level.arenaweapont7);
  level.arenaweapont8 = setupweaponattachmentoverrides(level.arenaweapont8);
}

setupweaponattachmentoverrides(_id_D44EB44714E9FB44) {
  _id_D44EB44714E9FB44.weapon = _id_D44EB44714E9FB44.weapon;

  if(!issubstr(_id_D44EB44714E9FB44.weapon, "equip") && _id_D44EB44714E9FB44.weapon != "none") {
    attachments = [];
    camoname = "none";
    _id_6A42D475DFB96A31 = "none";
    variantid = undefined;
    _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_D44EB44714E9FB44.weapon);
    attachments = getarenapickupattachmentoverrides(_id_AB501F397D3CD312 + "_mp");
    _id_D44EB44714E9FB44.weaponobj = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, camoname, _id_6A42D475DFB96A31, variantid);
  }

  return _id_D44EB44714E9FB44;
}

getattachmentoverride(weapon) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  attachments = getarenapickupattachmentoverrides(_id_AB501F397D3CD312 + "_mp");
  return attachments[0];
}

defineplayerloadout() {
  attachments = [];
  attachments[0] = "none";
  attachments[1] = "none";
  attachments[2] = "none";
  attachments[3] = "none";
  attachments[4] = "none";
  camoname = "none";
  _id_6A42D475DFB96A31 = "none";
  variantid = 0;
  _id_F3464D71F01F614E = undefined;
  cosmeticattachment = undefined;
  stickers = [];
  stickers[0] = "none";
  stickers[1] = "none";
  stickers[2] = "none";
  stickers[3] = "none";
  stickers[4] = "none";
  perks = ["specialty_blastshield"];
  _id_BB7A7034F796AF47 = "none";
  _id_79A42E6A2F51CF87 = "none";

  if(isDefined(level.startweapon.weapon) && level.startweapon.weapon != "none" && !issubstr(level.startweapon.weapon, "equip")) {
    primary = _id_2669878CF5A1B6BC::getweaponrootname(level.startweapon.weapon);

    if(ispickupblueprintloadouts())
      variantid = level.startweapon.variantid;

    if(level.arenapickupattachments > 0)
      attachments[0] = getattachmentoverride(level.startweapon.weapon);
  } else {
    primary = "none";

    if(issubstr(level.startweapon.weapon, "equip")) {
      if(isthrowingknifeequipment(level.startweapon.weapon)) {
        perks[perks.size] = "specialty_extra_deadly";

        if(level.arenaknivesout) {
          perks[perks.size] = "specialty_restock";

          if(level.arenaknivesout == 2)
            primary = "iw9_knife";
        }
      }

      slot = scripts\mp\equipment::getdefaultslot(level.startweapon.weapon);

      if(slot == "primary")
        _id_BB7A7034F796AF47 = level.startweapon.weapon;
      else
        _id_79A42E6A2F51CF87 = level.startweapon.weapon;
    }
  }

  if(level.allowsupers) {
    mapname = scripts\cp_mp\utility\game_utility::getmapname();

    if(issubstr(mapname, "mp_m_") && mapname != "mp_m_speed")
      level._id_10E2EBD08FAC3FAF = fixupsupersandtacticalsforgunfightmaps();
  } else {
    level._id_10E2EBD08FAC3FAF = "none";
    setomnvar("ui_disable_fieldupgrades", 1);
  }

  level._id_B128EFAE25AC7CC6["loadoutArchetype"] = "archetype_assault";
  level._id_B128EFAE25AC7CC6["loadoutPrimary"] = primary;
  level._id_B128EFAE25AC7CC6["loadoutPrimaryAttachment"] = attachments[0];
  level._id_B128EFAE25AC7CC6["loadoutPrimaryAttachment2"] = attachments[1];
  level._id_B128EFAE25AC7CC6["loadoutPrimaryAttachment3"] = attachments[2];
  level._id_B128EFAE25AC7CC6["loadoutPrimaryAttachment4"] = attachments[3];
  level._id_B128EFAE25AC7CC6["loadoutPrimaryAttachment5"] = attachments[4];
  level._id_B128EFAE25AC7CC6["loadoutPrimaryCamo"] = camoname;
  level._id_B128EFAE25AC7CC6["loadoutPrimaryCosmeticAttachment"] = cosmeticattachment;
  level._id_B128EFAE25AC7CC6["loadoutPrimaryReticle"] = _id_6A42D475DFB96A31;
  level._id_B128EFAE25AC7CC6["loadoutPrimarySticker2"] = stickers[2];
  level._id_B128EFAE25AC7CC6["loadoutPrimarySticker"] = stickers[0];
  level._id_B128EFAE25AC7CC6["loadoutPrimarySticker1"] = stickers[1];
  level._id_B128EFAE25AC7CC6["loadoutPrimarySticker3"] = stickers[3];
  level._id_B128EFAE25AC7CC6["loadoutPrimarySticker4"] = stickers[4];
  level._id_B128EFAE25AC7CC6["loadoutPrimaryVariantID"] = variantid;
  level._id_B128EFAE25AC7CC6["loadoutSecondary"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondaryAttachment"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondaryAttachment2"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondaryAttachment3"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondaryAttachment4"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondaryAttachment5"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondaryCamo"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondaryReticle"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondarySticker"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondarySticker1"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondarySticker2"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondarySticker3"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondarySticker4"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSecondaryVariantID"] = -1;
  level._id_B128EFAE25AC7CC6["loadoutMeleeSlot"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutEquipmentPrimary"] = _id_BB7A7034F796AF47;
  level._id_B128EFAE25AC7CC6["loadoutEquipmentSecondary"] = _id_79A42E6A2F51CF87;
  level._id_B128EFAE25AC7CC6["loadoutStreakType"] = "assault";
  level._id_B128EFAE25AC7CC6["loadoutKillstreak1"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutKillstreak2"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutKillstreak3"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutSuper"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutFieldUpgrade1"] = level._id_10E2EBD08FAC3FAF;
  level._id_B128EFAE25AC7CC6["loadoutFieldUpgrade2"] = "none";
  level._id_B128EFAE25AC7CC6["loadoutPerks"] = perks;
  level._id_B128EFAE25AC7CC6["loadoutGesture"] = "playerData";
  level._id_B128EFAE25AC7CC6["loadoutExecution"] = "playerData";
}

_id_3DD5B16653C57B45(_id_FABF84450735DD93) {
  camoname = "none";

  if(!isDefined(_id_FABF84450735DD93) || _id_FABF84450735DD93 != "allies" && _id_FABF84450735DD93 != "axis")
    return camoname;

  _id_C9C92192A039D262 = ["camo_a_01", "camo_b_01", "camo_c_01", "camo_d_01", "camo_e_01", "camo_f_01", "camo_g_01", "camo_h_01", "camo_i_01", "camo_j_01", "camo_k_01", "camo_l_01", "camo_m_01", "camo_n_01", "camo_o_01", "camo_p_01", "camo_r_01", "camo_comp_01", "camo_a_02", "camo_b_02", "camo_c_02", "camo_d_02", "camo_e_02", "camo_f_02", "camo_g_02", "camo_h_02", "camo_i_02", "camo_j_02", "camo_k_02", "camo_l_02", "camo_m_02", "camo_n_02", "camo_o_02", "camo_p_02", "camo_r_02", "camo_comp_02", "camo_a_03", "camo_b_03", "camo_c_03", "camo_d_03", "camo_e_03", "camo_f_03", "camo_g_03", "camo_h_03", "camo_i_03", "camo_j_03", "camo_k_03", "camo_l_03", "camo_m_03", "camo_n_03", "camo_o_03", "camo_p_03", "camo_comp_03", "camo_a_04", "camo_b_04", "camo_c_04", "camo_d_04", "camo_e_04", "camo_f_04", "camo_g_04", "camo_h_04", "camo_i_04", "camo_j_04", "camo_k_04", "camo_l_04", "camo_m_04", "camo_n_04", "camo_o_04", "camo_p_04", "camo_comp_04", "camo_a_05", "camo_b_05", "camo_c_05", "camo_d_05", "camo_e_05", "camo_f_05", "camo_g_05", "camo_h_05", "camo_i_05", "camo_j_05", "camo_k_05", "camo_l_05", "camo_m_05", "camo_n_05", "camo_o_05", "camo_p_05", "camo_a_06", "camo_b_06", "camo_c_06", "camo_d_06", "camo_e_06", "camo_f_06", "camo_g_06", "camo_h_06", "camo_i_06", "camo_j_06", "camo_k_06", "camo_l_06", "camo_m_06", "camo_n_06", "camo_o_06", "camo_p_06", "camo_a_07", "camo_b_07", "camo_c_07", "camo_d_07", "camo_e_07", "camo_f_07", "camo_g_07", "camo_h_07", "camo_i_07", "camo_j_07", "camo_k_07", "camo_l_07", "camo_m_07", "camo_n_07", "camo_o_07", "camo_p_07", "camo_a_08", "camo_b_08", "camo_c_08", "camo_d_08", "camo_e_08", "camo_f_08", "camo_g_08", "camo_h_08", "camo_i_08", "camo_j_08", "camo_k_08", "camo_l_08", "camo_m_08", "camo_n_08", "camo_o_08", "camo_p_08", "camo_a_09", "camo_b_09", "camo_c_09", "camo_d_09", "camo_e_09", "camo_f_09", "camo_g_09", "camo_h_09", "camo_i_09", "camo_j_09", "camo_k_09", "camo_l_09", "camo_m_09", "camo_n_09", "camo_o_09", "camo_a_10", "camo_b_10", "camo_c_10", "camo_d_10", "camo_e_10", "camo_f_10", "camo_g_10", "camo_h_10", "camo_i_10", "camo_j_10", "camo_k_10", "camo_l_10", "camo_m_10", "camo_n_10", "camo_o_10", "camo_a_11", "camo_b_11", "camo_c_11", "camo_d_11", "camo_e_11", "camo_f_11", "camo_g_11", "camo_h_11", "camo_i_11", "camo_j_11", "camo_k_11", "camo_l_11", "camo_m_11", "camo_n_11", "camo_o_11", "camo_a_12", "camo_b_12", "camo_c_12", "camo_d_12", "camo_e_12", "camo_f_12", "camo_g_12", "camo_h_12", "camo_i_12", "camo_j_12", "camo_k_12", "camo_l_12", "camo_m_12", "camo_n_12", "camo_o_12", "camo_a_13", "camo_b_13", "camo_c_13", "camo_d_13", "camo_e_13", "camo_f_13", "camo_g_13", "camo_h_13", "camo_i_13", "camo_j_13", "camo_k_13", "camo_l_13", "camo_m_13", "camo_n_13", "camo_o_13", "camo_a_14", "camo_b_14", "camo_c_14", "camo_d_14", "camo_e_14", "camo_f_14", "camo_g_14", "camo_h_14", "camo_i_14", "camo_j_14", "camo_k_14", "camo_l_14", "camo_m_14", "camo_n_14", "camo_o_14", "camo_a_15", "camo_b_15", "camo_c_15", "camo_d_15", "camo_e_15", "camo_f_15", "camo_g_15", "camo_h_15", "camo_i_15", "camo_j_15", "camo_k_15", "camo_l_15", "camo_m_15", "camo_n_15"];

  if(game["roundWinStreak"][_id_FABF84450735DD93] > 5)
    camoname = "camo_comp_04";
  else {
    switch (game["roundWinStreak"][_id_FABF84450735DD93]) {
      case 1:
        camoname = scripts\engine\utility::random(_id_C9C92192A039D262);
        break;
      case 2:
        camoname = "camo_comp_01";
        break;
      case 3:
        camoname = "camo_comp_02";
        break;
      case 4:
        camoname = "camo_comp_03";
        break;
      case 5:
        camoname = "camo_comp_04";
        break;
      default:
        break;
    }
  }

  return camoname;
}

updaterandomloadout() {
  if(israndomloadouts()) {
    if(game["roundsPlayed"] == 0) {
      if(istrue(game["practiceRound"])) {
        game["arenaRandomLoadout"] = scripts\engine\utility::array_randomize(game["arenaLoadouts"]);
        game["arenaRandomLoadoutIndex"] = 0;
      } else if(!isDefined(game["practiceRound"]) || istrue(game["didSnowFight"])) {
        if(istrue(game["didSnowFight"]))
          game["didSnowFight"] = undefined;

        game["arenaRandomLoadout"] = scripts\engine\utility::array_randomize(game["arenaLoadouts"]);
        game["arenaRandomLoadoutIndex"] = 0;
      }
    } else if(level.loadoutchangeround != 0) {
      if(game["roundsPlayed"] % level.loadoutchangeround == 0)
        game["arenaRandomLoadoutIndex"]++;

      if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size)
        game["arenaRandomLoadoutIndex"] = 0;
    } else
      game["arenaRandomLoadoutIndex"] = 0;
  }
}

_id_3187496929140714(_id_6CAF1A8CA6008020, _id_171342D97570F634, _id_A049F07E0F11DC31) {
  _id_57C2FBE37E0787EA = [];
  _id_FDDB8D504937A284 = scripts\engine\utility::ter_op(isDefined(_id_6CAF1A8CA6008020), _id_6CAF1A8CA6008020, []);
  _id_7BB993CAF9F54322 = scripts\engine\utility::ter_op(isDefined(_id_171342D97570F634), _id_171342D97570F634, []);
  _id_61726FD00A4B456B = scripts\engine\utility::ter_op(isDefined(_id_A049F07E0F11DC31), _id_A049F07E0F11DC31, []);

  if(_id_FDDB8D504937A284.size == 0) {
    if(israndomblueprintsloadouts())
      _id_FDDB8D504937A284[_id_FDDB8D504937A284.size] = "arena_blueprints_class_table";
    else if(scripts\mp\utility\game::getgametype() == "infect")
      _id_FDDB8D504937A284[_id_FDDB8D504937A284.size] = "arena_infect_class_table";
    else
      _id_FDDB8D504937A284[_id_FDDB8D504937A284.size] = "arena_class_table";
  }

  if(_id_7BB993CAF9F54322.size == 0) {
    _id_D63E7120D2B583FE = !israndomarloadouts() && !israndomsmgloadouts() && !israndomlmgloadouts() && !israndompistolloadouts() && !israndomshotgunloadouts() && !israndomsniperloadouts();

    if(_id_D63E7120D2B583FE || israndomarloadouts())
      _id_7BB993CAF9F54322[_id_7BB993CAF9F54322.size] = "ar";

    if(_id_D63E7120D2B583FE || israndomsmgloadouts())
      _id_7BB993CAF9F54322[_id_7BB993CAF9F54322.size] = "smg";

    if(_id_D63E7120D2B583FE || israndomlmgloadouts())
      _id_7BB993CAF9F54322[_id_7BB993CAF9F54322.size] = "lmg";

    if(_id_D63E7120D2B583FE || israndompistolloadouts())
      _id_7BB993CAF9F54322[_id_7BB993CAF9F54322.size] = "pistol";

    if(_id_D63E7120D2B583FE || israndomshotgunloadouts())
      _id_7BB993CAF9F54322[_id_7BB993CAF9F54322.size] = "shotgun";

    if(_id_D63E7120D2B583FE || israndomsniperloadouts())
      _id_7BB993CAF9F54322[_id_7BB993CAF9F54322.size] = "sniper";
  }

  if(_id_61726FD00A4B456B.size == 0)
    _id_61726FD00A4B456B[_id_61726FD00A4B456B.size] = "iw9_mp";

  foreach(_id_8691AF1F100B771F in _id_FDDB8D504937A284) {
    foreach(weapontype in _id_7BB993CAF9F54322) {
      foreach(project in _id_61726FD00A4B456B) {
        classtablename = scripts\engine\utility::_id_996B01CD49D0128D([_id_8691AF1F100B771F, weapontype, project], "_");
        classtablename = scripts\engine\utility::_id_996B01CD49D0128D(["classtable", classtablename], ":");
        _id_6AB15B7EA89D055D = getscriptbundle(classtablename);
        _id_57C2FBE37E0787EA[_id_57C2FBE37E0787EA.size] = _id_6AB15B7EA89D055D;
      }
    }
  }

  return _id_57C2FBE37E0787EA;
}

_id_37F8BE8199814F97(_id_B45E94B269AE0A46) {
  _id_051DD516E025FD78 = getscriptbundle("classtableentry:" + _id_B45E94B269AE0A46._id_F90358454413407F);
  loadout = [];
  loadout["loadoutPrimary"] = _id_051DD516E025FD78.primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = scripts\engine\utility::ter_op(!israndomnoattachmentloadouts(), _id_051DD516E025FD78.primaryweapon._id_59F68715C04CE28F, "none");
  loadout["loadoutPrimaryAttachment1"] = scripts\engine\utility::ter_op(!israndomnoattachmentloadouts(), _id_051DD516E025FD78.primaryweapon._id_59F68815C04CE4C2, "none");
  loadout["loadoutPrimaryAttachment2"] = scripts\engine\utility::ter_op(!israndomnoattachmentloadouts(), _id_051DD516E025FD78.primaryweapon._id_59F68915C04CE6F5, "none");
  loadout["loadoutPrimaryAttachment3"] = scripts\engine\utility::ter_op(!israndomnoattachmentloadouts(), _id_051DD516E025FD78.primaryweapon._id_59F68215C04CD790, "none");
  loadout["loadoutPrimaryAttachment4"] = scripts\engine\utility::ter_op(!israndomnoattachmentloadouts(), _id_051DD516E025FD78.primaryweapon._id_59F68315C04CD9C3, "none");
  loadout["loadoutPrimaryAttachment5"] = scripts\engine\utility::ter_op(!israndomnoattachmentloadouts(), _id_051DD516E025FD78.primaryweapon._id_59F68415C04CDBF6, "none");
  loadout["loadoutPrimaryCamo"] = _id_051DD516E025FD78.primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = _id_051DD516E025FD78.primaryweapon.reticle;
  loadout["loadoutPrimaryVariantID"] = scripts\engine\utility::ter_op(israndomblueprintsloadouts() || israndomcustomblueprintsloadouts(), _id_051DD516E025FD78.primaryweapon.variantid, 0);
  loadout["loadoutPrimaryAddBlueprintAttachments"] = _id_051DD516E025FD78.primaryweapon._id_8886D83D8D183347;
  loadout["loadoutSecondary"] = _id_051DD516E025FD78.secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = scripts\engine\utility::ter_op(!israndomnoattachmentloadouts(), _id_051DD516E025FD78.secondaryweapon._id_59F68715C04CE28F, "none");
  loadout["loadoutSecondaryAttachment1"] = scripts\engine\utility::ter_op(!israndomnoattachmentloadouts(), _id_051DD516E025FD78.secondaryweapon._id_59F68815C04CE4C2, "none");
  loadout["loadoutSecondaryAttachment2"] = scripts\engine\utility::ter_op(!israndomnoattachmentloadouts(), _id_051DD516E025FD78.secondaryweapon._id_59F68915C04CE6F5, "none");
  loadout["loadoutSecondaryAttachment3"] = scripts\engine\utility::ter_op(!israndomnoattachmentloadouts(), _id_051DD516E025FD78.secondaryweapon._id_59F68215C04CD790, "none");
  loadout["loadoutSecondaryAttachment4"] = scripts\engine\utility::ter_op(!israndomnoattachmentloadouts(), _id_051DD516E025FD78.secondaryweapon._id_59F68315C04CD9C3, "none");
  loadout["loadoutSecondaryCamo"] = _id_051DD516E025FD78.secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = _id_051DD516E025FD78.secondaryweapon.reticle;
  loadout["loadoutSecondaryVariantID"] = scripts\engine\utility::ter_op(israndomblueprintsloadouts() || israndomcustomblueprintsloadouts(), _id_051DD516E025FD78.primaryweapon.variantid, 0);
  loadout["loadoutSecondaryAddBlueprintAttachments"] = _id_051DD516E025FD78.secondaryweapon._id_8886D83D8D183347;
  loadout["loadoutEquipmentPrimary"] = _id_051DD516E025FD78.equipment.primary;
  loadout["loadoutEquipmentSecondary"] = _id_051DD516E025FD78.equipment._id_D7B9856A19F9B6B5;
  loadout["loadoutExtraEquipmentPrimary"] = _id_051DD516E025FD78._id_AD6972268C86A2BE.primary;
  loadout["loadoutExtraEquipmentSecondary"] = _id_051DD516E025FD78._id_AD6972268C86A2BE._id_D7B9856A19F9B6B5;

  if(level.allowsupers) {
    mapname = scripts\cp_mp\utility\game_utility::getmapname();

    if(issubstr(mapname, "mp_m_") && mapname != "mp_m_speed")
      fixupsupersandtacticalsforgunfightmaps();
  }

  loadout["loadoutFieldUpgrade1"] = level._id_10E2EBD08FAC3FAF;
  loadout["loadoutFieldUpgrade2"] = "none";
  loadout["loadoutPerks"] = [];
  loadout["loadoutPerks"][0] = scripts\engine\utility::ter_op(_id_051DD516E025FD78.perks._id_16680ABD1742C050 != "specialty_null", _id_051DD516E025FD78.perks._id_16680ABD1742C050, "none");
  loadout["loadoutPerks"][1] = scripts\engine\utility::ter_op(_id_051DD516E025FD78.perks._id_16680DBD1742C6E9 != "specialty_null", _id_051DD516E025FD78.perks._id_16680DBD1742C6E9, "none");
  loadout["loadoutPerks"][2] = scripts\engine\utility::ter_op(_id_051DD516E025FD78.perks._id_16680CBD1742C4B6 != "specialty_null", _id_051DD516E025FD78.perks._id_16680CBD1742C4B6, "none");
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutExecution"] = "playerData";

  if(scripts\mp\utility\game::getgametype() == "arena") {
    if(loadout["loadoutPrimaryVariantID"] != 0)
      setomnvar("ui_arena_primaryVariantID", loadout["loadoutPrimaryVariantID"]);

    if(loadout["loadoutSecondaryVariantID"] != 0)
      setomnvar("ui_arena_secondaryVariantID", loadout["loadoutPrimaryVariantID"]);
  }

  return loadout;
}

initweaponmap() {
  level.baseraritymap = [];
  level.baseraritymap[level.arenaweapont1.weapon] = 0;
  level.baseraritymap[level.arenaweapont2.weapon] = 1;
  level.baseraritymap[level.arenaweapont3.weapon] = 2;
  level.baseraritymap[level.arenaweapont4.weapon] = 3;
  level.baseraritymap[level.arenaweapont5.weapon] = 4;
  level.baseraritymap[level.arenaweapont6.weapon] = 5;
  level.baseraritymap[level.arenaweapont7.weapon] = 6;
  level.baseraritymap[level.arenaweapont8.weapon] = 0;
}

getblueprintforpickupweapon(weapon) {
  if(ispickupblueprintloadouts() && !issubstr(weapon, "equip") && weapon != "none") {
    table = "classtable:classtable_arena_blueprints";
    _id_D6F262BBEC7B0CAA = 0;
    _id_66A903FC1D9B6B64 = "";
    _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);

    for(_id_A300FA75277719EE = scripts\mp\class::_id_DF2933F96D726D71(table); _id_D6F262BBEC7B0CAA < _id_A300FA75277719EE; _id_D6F262BBEC7B0CAA++) {
      _id_66A903FC1D9B6B64 = scripts\mp\class::table_getweapon(table, _id_D6F262BBEC7B0CAA, 0);

      if(_id_AB501F397D3CD312 == _id_66A903FC1D9B6B64) {
        break;
      }
    }

    if(_id_AB501F397D3CD312 != "") {
      variantid = scripts\mp\class::table_getweaponvariantid("classtable:classtable_arena_blueprints", _id_D6F262BBEC7B0CAA, 0, _id_AB501F397D3CD312);
      return variantid;
    }

    return 0;
  } else
    return 0;
}

setupweapons() {
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("weapon_pickup", "targetname");

  if(_id_9577902B42FBD7F6.size == 0 && isDefined(level._id_2D0D358424732272))
    _id_9577902B42FBD7F6 = level._id_2D0D358424732272;

  if(level.arenapickupattachments != 0)
    setupstartweaponsattachments();
  else if(ispickupblueprintloadouts())
    setupblueprintpickupweapons();

  foreach(loc in _id_9577902B42FBD7F6) {
    if(loc.script_label == "1") {
      spawnweapon(loc, level.arenaweapont1);
      continue;
    }

    if(loc.script_label == "2") {
      spawnweapon(loc, level.arenaweapont2);
      continue;
    }

    if(loc.script_label == "3") {
      spawnweapon(loc, level.arenaweapont3);
      continue;
    }

    if(loc.script_label == "4") {
      spawnweapon(loc, level.arenaweapont4);
      continue;
    }

    if(loc.script_label == "5") {
      spawnweapon(loc, level.arenaweapont5);
      continue;
    }

    if(loc.script_label == "6") {
      spawnweapon(loc, level.arenaweapont6);
      continue;
    }

    if(loc.script_label == "7") {
      spawnweapon(loc, level.arenaweapont7);
      continue;
    }

    if(loc.script_label == "8")
      spawnweapon(loc, level.arenaweapont8);
  }
}

getrandomspawnweapon() {
  weaponlist = level.allweapons;

  if(isDefined(weaponlist) && weaponlist.size > 0) {
    _id_DD515FCF025B2E79 = "";
    data = undefined;
    loopcount = 0;

    for(;;) {
      weapon = scripts\engine\utility::random(weaponlist);

      if(!issubstr(weapon, "equip"))
        _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
      else
        _id_AB501F397D3CD312 = weapon;

      if(loopcount > weaponlist.size) {
        level.selectedweapons[_id_AB501F397D3CD312] = 1;
        _id_DD515FCF025B2E79 = weapon;

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.allweapons.size; _id_AC0E594AC96AA3A8++) {
          if(level.allweapons[weapon] == _id_DD515FCF025B2E79) {
            break;
          }
        }

        break;
      }

      loopcount++;
    }

    return _id_DD515FCF025B2E79;
  } else
    return "none";
}

getarenapickupattachmentoverrides(weapon) {
  attachments = [];

  if(level.arenapickupattachments == 1) {
    if(weaponclass(weapon) == "sniper" || weaponclass(weapon) == "dmr")
      attachments[attachments.size] = "scope";
  }

  if(attachments.size == 0)
    attachments[attachments.size] = "none";

  return attachments;
}

spawnweapon(loc, _id_558774275543A708, _id_5F3B26E2789A42C0) {
  if(isDefined(_id_5F3B26E2789A42C0))
    _id_63573DFB900DD221 = _id_558774275543A708;
  else
    _id_63573DFB900DD221 = _id_558774275543A708.weapon;

  if(_id_63573DFB900DD221 == "none") {
    return;
  }
  loc = _id_355F5B20C3C22114(loc);
  loc = _id_C1D47107CD83FCAA(loc, _id_63573DFB900DD221);

  if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall") {} else {
    tracestart = loc.origin + (0, 0, 16);
    _id_8B39E5984DA1FFAF = loc.origin + (0, 0, -16);
    trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, scripts\engine\trace::create_default_contents(1));

    if(trace["fraction"] < 1.0)
      _id_1F9238CE81EA0D85 = trace["position"] + (0, 0, 2);
  }

  _id_9B83EFBA8BFECC3F = _id_5A0A68144C7A97FD(_id_63573DFB900DD221);

  if(isDefined(_id_9B83EFBA8BFECC3F)) {
    userange = 96;
    _id_4AFE4F5482B5A827 = 96;
    equipment = spawn("script_model", loc.origin);
    _id_36E496CDBC979837 = equipment getequipmenthinticon(_id_63573DFB900DD221);
    equipment.equipment = _id_63573DFB900DD221;
    equipment.equiptype = _id_9B83EFBA8BFECC3F.equiptype;
    equipment.angles = loc.angles;
    equipment setModel(_id_9B83EFBA8BFECC3F.worldmodel);
    equipment makeusable();
    equipment sethinttag("tag_origin");
    equipment setCursorHint("HINT_BUTTON");
    equipment sethinticon(_id_9B83EFBA8BFECC3F.icon);
    equipment setuseholdduration("duration_short");
    equipment setusehideprogressbar(1);
    equipment setHintString(_id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4);
    equipment setusepriority(0);
    equipment sethintdisplayrange(_id_4AFE4F5482B5A827);
    equipment sethintdisplayfov(120);
    equipment setuserange(userange);
    equipment setusefov(210);
    equipment sethintonobstruction("hide");
    equipment thread outlineequipmentwatchplayerprox(_id_63573DFB900DD221);
    equipment.proxtrigger = spawn("trigger_radius", equipment.origin, 0, 32, 32);
    equipment thread itemproxtriggerthink();
    equipment thread watchequipmentpickup();
    equipment.targetname = "dropped_equipment";
  } else {
    if(ispickupblueprintloadouts())
      objweapon = _id_558774275543A708.weaponobj;
    else {
      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_63573DFB900DD221);
      attachments = getarenapickupattachmentoverrides(_id_AB501F397D3CD312 + "_mp");
      objweapon = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, "none", "none", -1);
    }

    weaponname = getcompleteweaponname(objweapon);
    weapon = spawn("weapon_" + weaponname, loc.origin, 17);
    weapon.targetname = "dropped_weapon";
    weapon.objweapon = objweapon;
    weapon.angles = loc.angles;
    weapon sethintdisplayrange(96);
    weapon setuserange(96);
    weapon setuseholdduration("duration_short");
    weapon setusefov(210);

    if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall") {
      forward = anglestoright(loc.angles);
      _id_3777ECE6A73EADA5 = vectorNormalize(forward) * 30;
      tracestart = loc.origin + _id_3777ECE6A73EADA5 + (0, 0, 16);
      _id_8B39E5984DA1FFAF = loc.origin + _id_3777ECE6A73EADA5 + (0, 0, -100);
      trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, scripts\engine\trace::create_default_contents(1));
      _id_29AEA598C15F22F8 = loc.origin;

      if(trace["fraction"] < 1.0)
        _id_29AEA598C15F22F8 = trace["position"];

      weapon.bot_pickup_origin = _id_29AEA598C15F22F8;
    }

    manageweaponstartingammo(weapon, weaponname);
    weapon thread outlinewatchplayerprox();
    weapon thread watchpickup();
  }
}

_id_C1D47107CD83FCAA(loc, weaponname) {
  switch (weaponname) {
    case "equip_adrenaline":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc._id_3770F35956A8212C) && loc._id_3770F35956A8212C == "wall")
        loc.angles = loc.angles + (0, 90, 0);
      else
        loc.angles = loc.angles + (90, 0, 0);

      break;
    case "equip_at_mine":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc._id_3770F35956A8212C) && loc._id_3770F35956A8212C == "wall")
        loc.angles = loc.angles + (270, 0, 0);
      else
        loc.angles = loc.angles + (0, 0, 90);

      break;
    case "equip_c4":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc._id_3770F35956A8212C) && loc._id_3770F35956A8212C == "wall")
        loc.angles = loc.angles + (0, 90, 0);
      else
        loc.angles = loc.angles + (180, 180, 0);

      break;
    case "equip_claymore":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc._id_3770F35956A8212C) && loc._id_3770F35956A8212C == "wall")
        loc.angles = loc.angles + (0, 180, 0);
      else
        loc.angles = loc.angles + (0, 0, 90);

      break;
    case "equip_hb_sensor":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc._id_3770F35956A8212C) && loc._id_3770F35956A8212C == "wall")
        loc.angles = loc.angles + (270, 270, 0);
      else
        loc.angles = loc.angles + (0, 0, 90);

      break;
    case "equip_throwing_knife":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc._id_3770F35956A8212C) && loc._id_3770F35956A8212C == "wall")
        loc.angles = loc.angles + (0, 90, 0);

      break;
    case "iw9_dm_crossbow":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc._id_3770F35956A8212C) && loc._id_3770F35956A8212C == "wall")
        loc.angles = loc.angles + (0, 0, 90);
      else
        loc.angles = loc.angles + (0, 0, 90);

      break;
    case "iw9_me_riotshield":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc._id_3770F35956A8212C) && loc._id_3770F35956A8212C == "wall")
        loc.angles = loc.angles + (0, -90, 0);
      else
        loc.angles = loc.angles + (-90, 0, 0);

      break;
    default:
      break;
  }

  return loc;
}

_id_355F5B20C3C22114(loc) {
  switch (level.mapname) {
    case "mp_m_blacksite2":
      if(loc.script_label == "1") {
        if(distance(loc.origin, (-11, -889, 32)) < 10)
          loc.origin = loc.origin + (15, 0, 0);
        else if(distance(loc.origin, (125, 1158, 49)) < 10)
          loc.origin = loc.origin + (7, 0, 0);
        else if(distance(loc.origin, (-181, 1159, 34)) < 10)
          loc.origin = loc.origin + (7, 0, 0);
        else if(distance(loc.origin, (545, 379, 53)) < 10)
          loc.origin = loc.origin + (0, -0.5, 0);
      } else if(loc.script_label == "2") {
        if(distance(loc.origin, (-412, -618, 52)) < 10)
          loc.origin = loc.origin + (-10, 0, 1);
      } else if(loc.script_label == "6" && distance(loc.origin, (-313.261, 486, 54.9829)) < 10)
        loc.origin = loc.origin + (0, 0, -1);
      else if(loc.script_label == "7") {
        if(distance(loc.origin, (-47, -637, 48)) < 10)
          loc.angles = loc.angles + (0, 180, 0);
        else if(distance(loc.origin, (112, -516, 63)) < 10)
          loc.angles = loc.angles + (0, 90, 0);
        else if(distance(loc.origin, (-89, -371, 56)) < 10)
          loc.origin = loc.origin + (0, 0, -1);
      } else if(loc.script_label == "8" && distance(loc.origin, (328, -1078, 52)) < 10)
        loc.angles = loc.angles + (0, 270, 0);

      break;
    case "mp_m_canal":
      if(loc.script_label == "1" && distance(loc.origin, (-456, -2, 48)) < 10)
        loc.origin = loc.origin + (0, -1, 0);

      break;
    case "mp_m_exhibit":
      if(loc.script_label == "6") {
        if(distance(loc.origin, (-256, -1152, -62)) < 10)
          loc.origin = loc.origin + (0, 0, -2);
        else if(distance(loc.origin, (128, 128, -62)) < 10)
          loc.origin = loc.origin + (0, 0, -2);
      }

      break;
    case "mp_shipment_iw9":
      if(loc.script_label == "1") {
        if(distance(loc.origin, (-72, -737, -141.5)) < 10)
          loc.origin = loc.origin + (10, 0, 1);
        else if(distance(loc.origin, (-49, -715, -141.5)) < 10)
          loc.origin = loc.origin + (-15, -5, 1);
        else if(distance(loc.origin, (-894, 273, -141.5)) < 10)
          loc.origin = loc.origin + (15, -25, -1);
        else if(distance(loc.origin, (-911, 243, -141.5)) < 10)
          loc.origin = loc.origin + (30, -20, -1);
      } else if(loc.script_label == "6") {
        if(distance(loc.origin, (-223.5, -588, -145)) < 10)
          loc.origin = loc.origin + (0, 0, 2);
        else if(distance(loc.origin, (-606.5, 156, -145)) < 10)
          loc.origin = loc.origin + (3, -25, -1);
      } else if(loc.script_label == "7") {
        if(distance(loc.origin, (-229.5, 152, -145)) < 10)
          loc.origin = loc.origin + (0, -5, -1);
        else if(distance(loc.origin, (-740.5, -561, -147)) < 10)
          loc.origin = loc.origin + (0, 0, 1);
      }

      break;
    default:
      break;
  }

  return loc;
}

getequipmenthinticon(weapon) {
  table = "mp/arenaGGWeapons.csv";
  icon = tablelookup(table, 0, weapon, 3);
  return icon;
}

manageweaponstartingammo(weapon, weaponname) {
  mag = weaponclipsize(weaponname);
  _id_06F592A5FB739460 = 0;

  if(level.magcount != 3) {
    _id_640C8B74FC979400 = !level.magcount;

    if(_id_640C8B74FC979400) {
      mag = 0;
      _id_06F592A5FB739460 = 0;
    } else
      _id_06F592A5FB739460 = level.magcount - 1;

    if(level.magcount == 7)
      _id_06F592A5FB739460 = weaponmaxammo(weaponname);
    else
      _id_06F592A5FB739460 = mag * _id_06F592A5FB739460;
  } else
    _id_06F592A5FB739460 = mag * 2;

  weapon itemweaponsetammo(mag, _id_06F592A5FB739460);
}

watchequipmentpickup() {
  self endon("death");
  self waittill("trigger", player, _id_76F4143215683892);
  hasmaxammo = 0;
  _id_F23035E6F6B69F91 = checkissameequip(player);
  _id_0C89F07DA007FF0D = checkpickupequiptypeammocount(player);
  _id_8B9AB3ABAE98D973 = player scripts\mp\equipment::getequipmentmaxammo(self.equipment);
  _id_B64209459DA65860 = checkcurrentequiptypeammocount(player);

  if(_id_F23035E6F6B69F91) {
    if(_id_0C89F07DA007FF0D == _id_8B9AB3ABAE98D973)
      hasmaxammo = 1;
  }

  if(_id_F23035E6F6B69F91 && !hasmaxammo)
    player scripts\mp\equipment::incrementequipmentammo(self.equipment, 1);
  else if(_id_B64209459DA65860 && !_id_F23035E6F6B69F91)
    player dropoldequipinplace(player scripts\mp\equipment::getcurrentequipment(self.equiptype));

  if(!_id_F23035E6F6B69F91)
    player scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);

  if(_id_F23035E6F6B69F91 && hasmaxammo) {
    player iprintlnbold(&"MP_INGAME_ONLY/EQUIPMENT_MAXED");
    thread watchequipmentpickup();
  } else {
    player playlocalsound("scavenger_pack_pickup");
    clearweaponoutlines();
    self makeunusable();
    self delete();
  }
}

checkpickupequiptypeammocount(player) {
  return player scripts\mp\equipment::getequipmentammo(self.equipment);
}

checkcurrentequiptypeammocount(player) {
  _id_1189BD7FBE2861F8 = player scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(_id_1189BD7FBE2861F8))
    return player scripts\mp\equipment::getequipmentammo(_id_1189BD7FBE2861F8);
  else
    return 0;
}

checkissameequip(player) {
  _id_1189BD7FBE2861F8 = player scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(_id_1189BD7FBE2861F8))
    return self.equipment == _id_1189BD7FBE2861F8;
  else
    return 0;
}

dropoldequipinplace(equipment) {
  spawnweapon(self, equipment, 1);
}

watchpickup() {
  self endon("death");
  self waittill("trigger", player, _id_76F4143215683892);
  clearweaponoutlines();

  if(isDefined(_id_76F4143215683892)) {
    _id_76F4143215683892 sethintdisplayrange(96);
    _id_76F4143215683892 setuserange(96);
    _id_76F4143215683892 setuseholdduration("duration_short");
    _id_76F4143215683892 thread outlinewatchplayerprox();
    _id_76F4143215683892 thread watchpickup();
  }
}

itemproxtriggerthink() {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");
  _id_1189BD7FBE2861F8 = undefined;

  for(;;) {
    wait 0.05;
    self.proxtrigger waittill("trigger", player);

    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(istrue(player.inlaststand)) {
      continue;
    }
    if(!isDefined(player.initialized_gameobject_vars)) {
      continue;
    }
    if(!scripts\mp\gameobjects::proxtriggerlos(player)) {
      continue;
    }
    _id_1189BD7FBE2861F8 = player scripts\mp\equipment::getcurrentequipment(self.equiptype);
    hasmaxammo = 0;
    _id_F23035E6F6B69F91 = checkissameequip(player);
    _id_B64209459DA65860 = checkcurrentequiptypeammocount(player);
    _id_1189BD7FBE2861F8 = player scripts\mp\equipment::getcurrentequipment(self.equiptype);

    if(isDefined(_id_1189BD7FBE2861F8) && !_id_F23035E6F6B69F91 && _id_B64209459DA65860 > 0) {
      continue;
    }
    _id_0C89F07DA007FF0D = checkpickupequiptypeammocount(player);
    _id_8B9AB3ABAE98D973 = player scripts\mp\equipment::getequipmentmaxammo(self.equipment);

    if(_id_F23035E6F6B69F91) {
      if(_id_0C89F07DA007FF0D == _id_8B9AB3ABAE98D973)
        hasmaxammo = 1;
    }

    if(_id_F23035E6F6B69F91 && !hasmaxammo)
      player scripts\mp\equipment::incrementequipmentammo(self.equipment, 1);

    if(_id_F23035E6F6B69F91 && hasmaxammo) {
      continue;
    }
    if(!isDefined(_id_1189BD7FBE2861F8) || isDefined(_id_1189BD7FBE2861F8) && !_id_F23035E6F6B69F91 && _id_B64209459DA65860 == 0)
      player scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);

    player playlocalsound("scavenger_pack_pickup");
    clearweaponoutlines();
    self makeunusable();
    self delete();
  }
}

updatearenagungameloadout(_id_2429CF7C00AC6E67) {
  if(game["roundsPlayed"] == 0) {
    cachearenagungameloadouts(_id_2429CF7C00AC6E67);
    game["arenaRandomLoadoutIndex"] = 0;
  }
}

cachearenagungameloadouts(_id_2429CF7C00AC6E67) {
  loadouts = [];
  _id_57C2FBE37E0787EA = _id_3187496929140714();

  foreach(_id_09DDC180A1A5121D in _id_57C2FBE37E0787EA) {
    foreach(loadout in _id_09DDC180A1A5121D._id_8D5460BE7DB831C3)
    loadouts[loadouts.size] = _id_37F8BE8199814F97(loadout);
  }

  game["arenaRandomLoadout"] = scripts\engine\utility::ter_op(_id_2429CF7C00AC6E67, scripts\engine\utility::array_reverse(loadouts), loadouts);
}

setenemyloadoutomnvars() {
  _id_AA74D78F1A2354AE = undefined;

  if(!isDefined(self.pers["team"]))
    otherteam = "allies";
  else
    otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];

  foreach(player in level.players) {
    if(player.team == otherteam) {
      _id_AA74D78F1A2354AE = player;
      break;
    }
  }

  if(!isDefined(_id_AA74D78F1A2354AE))
    _id_AA74D78F1A2354AE = self;

  table = "mp/arenaGGWeapons.csv";
  self setclientomnvar("ui_arena_en_primary", -1);
  self setclientomnvar("ui_arena_en_secondary", -1);
  self setclientomnvar("ui_arena_en_lethal", -1);
  self setclientomnvar("ui_arena_en_tactical", -1);
  primary = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
  self setclientomnvar("ui_arena_en_primary", primary);
  _id_D7B9856A19F9B6B5 = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
  self setclientomnvar("ui_arena_en_secondary", _id_D7B9856A19F9B6B5);
  _id_0E8F6FDB8F100FF7 = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
  self setclientomnvar("ui_arena_en_lethal", _id_0E8F6FDB8F100FF7);
  tactical = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
  self setclientomnvar("ui_arena_en_tactical", tactical);
}

getgungameloadoutindex(player) {
  _id_627FA174D00EF780 = 0;

  if(game["roundsPlayed"] == 0)
    _id_627FA174D00EF780 = 0;
  else if(isgungameloadouts())
    _id_627FA174D00EF780 = game["roundsWon"][player.pers["team"]];
  else
    _id_627FA174D00EF780 = game["roundsWon"][scripts\mp\utility\game::getotherteam(player.pers["team"])[0]];

  return _id_627FA174D00EF780;
}

getgungameloadoutomnvarindex(player, _id_EC15CE3E7A9D1D86) {
  _id_627FA174D00EF780 = 0;

  if(isgungameloadouts()) {
    _id_627FA174D00EF780 = game["roundsWon"][player.pers["team"]];

    if(isDefined(_id_EC15CE3E7A9D1D86) && _id_EC15CE3E7A9D1D86 == player.pers["team"])
      _id_627FA174D00EF780 = _id_627FA174D00EF780 + 1;
  } else {
    _id_627FA174D00EF780 = game["roundsWon"][scripts\mp\utility\game::getotherteam(player.pers["team"])[0]];

    if(isDefined(_id_EC15CE3E7A9D1D86) && _id_EC15CE3E7A9D1D86 == scripts\mp\utility\game::getotherteam(player.pers["team"])[0])
      _id_627FA174D00EF780 = _id_627FA174D00EF780 + 1;
  }

  return _id_627FA174D00EF780;
}

setenemyloadoutomnvarsatmatchend(_id_EC15CE3E7A9D1D86) {
  foreach(player in level.players) {
    _id_AA74D78F1A2354AE = undefined;

    if(!isDefined(player.pers["team"]))
      otherteam = "allies";
    else
      otherteam = scripts\mp\utility\game::getotherteam(player.pers["team"])[0];

    foreach(_id_AC0E424AC96A7113 in level.players) {
      if(_id_AC0E424AC96A7113.team == otherteam) {
        _id_AA74D78F1A2354AE = _id_AC0E424AC96A7113;
        break;
      }
    }

    if(!isDefined(_id_AA74D78F1A2354AE))
      _id_AA74D78F1A2354AE = player;

    _id_AA74D78F1A2354AE.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][getgungameloadoutomnvarindex(_id_AA74D78F1A2354AE, _id_EC15CE3E7A9D1D86)];
    table = "mp/arenaGGWeapons.csv";
    player setclientomnvar("ui_arena_en_primary", -1);
    player setclientomnvar("ui_arena_en_secondary", -1);
    player setclientomnvar("ui_arena_en_lethal", -1);
    player setclientomnvar("ui_arena_en_tactical", -1);
    primary = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
    player setclientomnvar("ui_arena_en_primary", primary);
    _id_D7B9856A19F9B6B5 = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
    player setclientomnvar("ui_arena_en_secondary", _id_D7B9856A19F9B6B5);
    _id_0E8F6FDB8F100FF7 = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
    player setclientomnvar("ui_arena_en_lethal", _id_0E8F6FDB8F100FF7);
    tactical = int(tablelookup(table, 0, _id_AA74D78F1A2354AE.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
    player setclientomnvar("ui_arena_en_tactical", tactical);
  }
}

spawngameendflagzone() {
  arenaflag = getEntArray("flag_arena", "targetname");

  if(!isDefined(arenaflag[0])) {
    return;
  }
  level.arenaflag = arenaflag[0];
  trigger = arenaflag[0];

  if(isDefined(trigger.target))
    visuals[0] = getEnt(trigger.target, "targetname");
  else {
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0].angles = trigger.angles;
  }

  trigger.objectivekey = "_a";
  trigger.iconname = "_a";
  arenaflag = _id_6663215F917210AE::setupobjective(trigger, "neutral", undefined, 1);
  arenaflag.onuse = ::arenaflag_onuse;
  arenaflag.onbeginuse = ::arenaflag_onusebegin;
  arenaflag.onenduse = ::arenaflag_onuseend;
  arenaflag.onuseupdate = ::arenaflag_onuseupdate;
  arenaflag.oncontested = ::arenaflag_oncontested;
  arenaflag.onuncontested = ::arenaflag_onuncontested;
  arenaflag.isarena = 1;
  arenaflag scripts\mp\gameobjects::pinobjiconontriggertouch();
  arenaflag.id = "domFlag";
  arenaflag.scriptable delete();
  arenaflag scripts\mp\gameobjects::setcapturebehavior("persistent");
  arenaflag.ignorestomp = 1;
  level.objectives[arenaflag.objectivekey] = arenaflag;
  level.arenaflag = arenaflag;
  waitframe();
  level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);
  level.arenaflag.visibleteam = "any";
  level.arenaflag scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_ot");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level.arenaflag thread deleteotpreview();
    level thread showflagoutline();
  } else
    level.arenaflag disableotflag();
}

showflagoutline() {
  waitframe();

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel))
    level.arenaflag.flagmodel.outlinedid = scripts\mp\utility\outline::outlineenableforall(level.arenaflag.flagmodel, "outline_nodepth_orange", "level_script");

  level thread removeflagoutlineongameend();
}

arenaflag_onusebegin(player) {
  player.iscapturing = 1;
  level.canprocessot = 0;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral")
    player setclientomnvar("ui_objective_pinned_text_param", 1);

  self.neutralizing = istrue(level.flagneutralization) && ownerteam != "neutral";
  self.playertouching = 1;

  if(!istrue(self.neutralized))
    self.didstatusnotify = 0;

  usetime = scripts\engine\utility::ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(usetime);

  if(istrue(level.capturedecay))
    thread scripts\mp\gameobjects::useobjectdecay(player.team);

  if(usetime > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(player.team)[0];
    _id_6663215F917210AE::updateflagcapturestate(player.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icontaking, level.iconlosing);
  }
}

arenaflag_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(progress > 0.05 && _id_301D62DA1A0738F1 && !self.didstatusnotify) {
    if(ownerteam == "neutral") {
      if(level.flagcapturetime > 0.05) {
        scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, team);
        otherteam = scripts\mp\utility\game::getotherteam(team)[0];
        scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, otherteam);
      }
    } else if(level.flagcapturetime > 0.05) {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, ownerteam);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, team);
    }

    self.didstatusnotify = 1;
  }
}

arenaflag_onuseend(team, player, success) {
  level.canprocessot = 1;
  self.didstatusnotify = 0;

  if(success)
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    thread _id_6663215F917210AE::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    thread _id_6663215F917210AE::updateflagstate(ownerteam, 0);
  }

  if(!success)
    self.neutralized = 0;
}

arenaflag_onuse(_id_22282E7D48CA3400) {
  level.canprocessot = 1;
  team = _id_22282E7D48CA3400.team;
  _id_8A04AA0E0755E7E3 = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;
  scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, otherteam);
  scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, team);
  thread scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", _id_22282E7D48CA3400);
  _id_6663215F917210AE::dompoint_setcaptured(team, _id_22282E7D48CA3400);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete))
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, _id_22282E7D48CA3400, team, _id_8A04AA0E0755E7E3, self);

    self.firstcapture = 0;
  }

  game["dialog"]["round_success"] = "gamestate_win_capture";
  game["dialog"]["round_failure"] = "gamestate_lost_capture";
  level thread arena_endgame(_id_22282E7D48CA3400.team, game["end_reason"]["arena_otflag_completed"], game["end_reason"]["arena_otflag_failed"]);
}

arenaflag_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread _id_6663215F917210AE::updateflagstate("contested", 0);
  level thread forcegameendcontesttimeout();
}

arenaflag_onuncontested(lastclaimteam) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    if(lastclaimteam != "none")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, lastclaimteam);
    else if(isDefined(self.lastprogressteam))
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, self.lastprogressteam);
  } else
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(ownerteam)[0]);

  if(lastclaimteam == "none" || ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

forcegameendcontesttimeout() {
  level notify("start_overtime_timeout");
  level endon("start_overtime_timeout");
  level endon("game_ended");

  if(!isDefined(level.ottimecontested))
    level.ottimecontested = 0;

  while(level.ottimecontested < 5000) {
    wait(level.framedurationseconds);
    level.ottimecontested = level.ottimecontested + level.frameduration;
  }

  level.canprocessot = 1;
}

disableotflag() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();

  if(isDefined(self.scriptable))
    self.scriptable delete();

  self.flagmodel hide();
}

removeflagoutlineongameend() {
  level waittill("game_ended");

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel.outlinedid))
    scripts\mp\utility\outline::outlinedisable(level.arenaflag.flagmodel.outlinedid, level.arenaflag.flagmodel);
}

deleteotpreview() {
  scripts\mp\flags::gameflagwait("prematch_done");
  disableotflag();
}

setupendzones() {
  if(level.mapname == "mp_shipment") {
    level.attackerendzone = getEntArray("flag_goal_defender", "targetname");
    level.defenderendzone = getEntArray("flag_goal_attackers", "targetname");
  } else {
    level.attackerendzone = getEntArray("flag_goal_attacker", "targetname");
    level.defenderendzone = getEntArray("flag_goal_defender", "targetname");
  }

  level.attackerendzone = level.attackerendzone[0] createendzone(game["attackers"]);
  level.defenderendzone = level.defenderendzone[0] createendzone(game["defenders"]);
  level.objectives["_b"] = level.attackerendzone;
  level.objectives["_c"] = level.defenderendzone;
}

createendzone(team) {
  if(isDefined(self.target))
    visuals[0] = getEnt(self.target, "targetname");
  else {
    visuals[0] = spawn("script_model", self.origin);
    visuals[0].angles = self.angles;
  }

  if(isDefined(self.objectivekey))
    objectivekey = self.objectivekey;
  else if(self.targetname == "flag_goal_attacker")
    objectivekey = "_b";
  else
    objectivekey = "_c";

  iconname = undefined;
  _id_54B003CE5D016238 = scripts\mp\gameobjects::createuseobject(team, self, visuals, (0, 0, 100));
  _id_54B003CE5D016238.team = team;
  _id_54B003CE5D016238.ownerteam = team;
  _id_54B003CE5D016238 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  _id_54B003CE5D016238 scripts\mp\gameobjects::allowuse("enemy");
  _id_54B003CE5D016238 scripts\mp\gameobjects::cancontestclaim(1);
  _id_54B003CE5D016238 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  _id_54B003CE5D016238.onuse = ::endzone_onuse;
  _id_54B003CE5D016238.onbeginuse = ::endzone_onusebegin;
  _id_54B003CE5D016238.onenduse = ::endzone_onuseend;
  _id_54B003CE5D016238.oncontested = ::endzone_oncontested;
  _id_54B003CE5D016238.onuncontested = ::endzone_onuncontested;
  _id_54B003CE5D016238.isarena = 1;
  _id_54B003CE5D016238.firstcapture = 1;
  _id_54B003CE5D016238 scripts\mp\gameobjects::pinobjiconontriggertouch();
  _id_54B003CE5D016238.id = "domFlag";

  if(isDefined(level.capturetype))
    _id_54B003CE5D016238 scripts\mp\gameobjects::setcapturebehavior(getcapturetype());

  _id_54B003CE5D016238.objectivekey = objectivekey;
  _id_54B003CE5D016238.iconname = iconname;
  _id_54B003CE5D016238 scripts\mp\gameobjects::setvisibleteam("any");
  _id_54B003CE5D016238.stompprogressreward = ::endzone_stompprogressreward;
  _id_54B003CE5D016238.nousebar = 1;
  _id_54B003CE5D016238.claimgracetime = level.flagcapturetime * 1000;
  tracestart = visuals[0].origin + (0, 0, 32);
  _id_8B39E5984DA1FFAF = visuals[0].origin + (0, 0, -32);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
  _id_54B003CE5D016238.baseeffectpos = trace["position"];
  upangles = vectortoangles(trace["normal"]);
  _id_54B003CE5D016238.baseeffectforward = anglesToForward(upangles);
  scriptable = spawn("script_model", _id_54B003CE5D016238.baseeffectpos);
  scriptable setModel("dom_flag_scriptable");
  scriptable.angles = generateaxisanglesfromforwardvector(_id_54B003CE5D016238.baseeffectforward, scriptable.angles);
  _id_54B003CE5D016238.scriptable = scriptable;
  _id_54B003CE5D016238.vfxnamemod = "";

  if(isDefined(_id_54B003CE5D016238.trigger.radius)) {
    if(_id_54B003CE5D016238.trigger.radius == 160)
      _id_54B003CE5D016238.vfxnamemod = "_160";
    else if(_id_54B003CE5D016238.trigger.radius == 90)
      _id_54B003CE5D016238.vfxnamemod = "_90";
    else if(_id_54B003CE5D016238.trigger.radius == 315)
      _id_54B003CE5D016238.vfxnamemod = "_300";
    else if(_id_54B003CE5D016238.trigger.radius != 120)
      _id_54B003CE5D016238.noscriptable = 1;
  }

  _id_54B003CE5D016238.flagmodel = spawn("script_model", _id_54B003CE5D016238.baseeffectpos);
  _id_54B003CE5D016238.flagmodel setModel("military_dom_flag_neutral");
  _id_54B003CE5D016238.outlineent = _id_54B003CE5D016238.flagmodel;
  return _id_54B003CE5D016238;
}

endzone_onusebegin(player) {
  player.iscapturing = 1;
  level.canprocessot = 0;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral")
    player setclientomnvar("ui_objective_pinned_text_param", 1);

  self.neutralizing = istrue(level.flagneutralization) && ownerteam != "neutral";

  if(!istrue(self.neutralized))
    self.didstatusnotify = 0;

  usetime = scripts\engine\utility::ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(usetime);

  if(istrue(level.capturedecay))
    thread scripts\mp\gameobjects::useobjectdecay(player.team);

  if(usetime > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(player.team)[0];
    _id_6663215F917210AE::updateflagcapturestate(player.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingendzone, level.icontakingendzone);
  }
}

endzone_onuseend(team, player, success) {
  level.canprocessot = 1;

  if(success)
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);

  if(!success)
    self.neutralized = 0;
}

endzone_onuse(_id_22282E7D48CA3400) {
  level.canprocessot = 1;
  team = _id_22282E7D48CA3400.team;
  _id_8A04AA0E0755E7E3 = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;
  thread scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", _id_22282E7D48CA3400);
  endzone_setcaptured(team, _id_22282E7D48CA3400);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete))
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, _id_22282E7D48CA3400, team, _id_8A04AA0E0755E7E3, self);
  }

  level thread arena_endgame(_id_22282E7D48CA3400.team, game["end_reason"]["objective_completed"], undefined, 0, 2);
}

endzone_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestendzone);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

endzone_onuncontested(lastclaimteam) {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.processot = 1;
}

endzone_setcaptured(team, _id_22282E7D48CA3400) {
  scripts\mp\gameobjects::setownerteam(team);
  self notify("capture", _id_22282E7D48CA3400);
  self notify("assault", _id_22282E7D48CA3400);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.neutralized = 0;

  if(self.touchlist[team].size == 0)
    self.touchlist = self.oldtouchlist;

  thread giveflagcapturexp(self.touchlist[team], _id_22282E7D48CA3400);

  if(isDefined(level.matchrecording_logevent))
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), scripts\engine\utility::ter_op(team == "allies", 1, 2));

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + team);
}

endzone_stompprogressreward(player) {
  player thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
}

getcapturetype() {
  capturetype = "normal";

  if(level.capturetype == 2)
    capturetype = "neutralize";
  else if(level.capturetype == 3)
    capturetype = "persistent";

  return capturetype;
}

giveflagcapturexp(touchlist, _id_22282E7D48CA3400) {
  level endon("game_ended");
  _id_0666D6B1872868D7 = _id_22282E7D48CA3400;

  if(isDefined(_id_0666D6B1872868D7.owner))
    _id_0666D6B1872868D7 = _id_0666D6B1872868D7.owner;

  level.lastcaptime = gettime();

  if(isPlayer(_id_0666D6B1872868D7)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition", _id_0666D6B1872868D7);
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = _id_0666D6B1872868D7;
    _id_7E2C53B0BCF117D9.eventname = "capture";
    _id_7E2C53B0BCF117D9.position = _id_0666D6B1872868D7.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  }

  _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

  for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
    player = touchlist[_id_59DB5D0F4E3000A7[index]].player;

    if(isDefined(player.owner))
      player = player.owner;

    if(!isPlayer(player)) {
      continue;
    }
    player scripts\mp\utility\stats::incpersstat("captures", 1);
    player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
    player thread scripts\mp\rank::scoreeventpopup("stat_F4CD65EB4AA3FD61");
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A7B15A24E10A93B");
    wait 0.05;
  }
}

startotmechanics() {
  if(_id_444E57E02C02BEE6()) {
    foreach(objective in level.objectives) {
      if(objective.objectivekey != "_a")
        objective deleteendzone();
    }
  }

  level.canprocessot = 1;

  if(isDefined(level.arenaflag)) {
    if(!isDefined(level.arenaflag.objidnum))
      level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);

    level.arenaflag scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    level.arenaflag scripts\mp\gameobjects::enableobject();
    level.arenaflag scripts\mp\gameobjects::allowuse("enemy");
    level.arenaflag.flagmodel show();
    level thread showflagoutline();
    level.arenaflag.flagmodel playSound("flag_spawned");
  }

  if(level._id_E940D922CA35FCD4 > 0 && !_id_2EDA32F1D16DED2C())
    game["dialog"]["overtime"] = "gamestate_overtime_flagspawn";

  level thread shouldplayerovertimedialog();
  _id_548072087C9FD504::_id_7D42D3F8DD68280C(10, "free");

  if(istrue(level.snowballfight)) {
    foreach(player in level.players) {
      if(isalive(player)) {
        equipment = player scripts\mp\equipment::getcurrentequipment("primary");

        if(isDefined(equipment) && equipment == "equip_snowball")
          player scripts\mp\equipment::incrementequipmentammo("equip_snowball", 10);
        else if(!isDefined(equipment)) {
          player scripts\mp\equipment::giveequipment("equip_snowball", "primary");
          player scripts\mp\equipment::incrementequipmentammo("equip_snowball", 10);
        }
      }
    }
  }
}

shouldplayerovertimedialog() {
  wait 0.15;

  if(isDefined(level.arenaflag)) {
    if(istrue(level.arenaflag.playertouching))
      return;
  }

  foreach(player in level.players) {
    if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
      continue;
    }
    player scripts\mp\utility\dialog::leaderdialogonplayer("overtime");
  }
}

deleteendzone() {
  self notify("monitor_flag_control");
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::releaseid();
  self.trigger = undefined;
  self notify("deleted");
  self.visibleteam = "none";

  if(isDefined(self.scriptable))
    self.scriptable delete();

  self.flagmodel delete();
}

_id_5BBA7F02DBB91B52() {
  level._id_59A1F917FB3131A6 = "neutral";
  level.flagmodel["allies"] = "ctf_game_flag_west";
  level.flagbase["allies"] = "ctf_game_flag_base";
  level.carryflag["allies"] = "prop_ctf_game_flag_west";
  level.flagmodel["axis"] = "ctf_game_flag_east";
  level.flagbase["axis"] = "ctf_game_flag_base";
  level.carryflag["axis"] = "prop_ctf_game_flag_east";
  createflagstart();
}

createflagstart() {
  level._id_B5538188C80D8AF6 = scripts\engine\utility::array_randomize(level._id_B5538188C80D8AF6);
  tracestart = level._id_B5538188C80D8AF6[0] + (0, 0, 64);
  _id_8B39E5984DA1FFAF = level._id_B5538188C80D8AF6[0] + (0, 0, -64);
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, scripts\engine\trace::create_default_contents(1));
  level._id_B5538188C80D8AF6[0] = trace["position"];
  level._id_21997FBEA8438765 = _id_7077C9E2D480FAB5("allies");
  level thread flaglockedtimer();
}

flaglockedtimer() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level._id_50A07CDA9851D4B8.objectiveicon scripts\mp\gameobjects::setvisibleteam("none");
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
    level._id_50A07CDA9851D4B8.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");
  }

  if(level.flagactivationdelay) {
    scripts\mp\flags::gameflagwait("prematch_done");
    level._id_50A07CDA9851D4B8.objectiveicon thread scripts\mp\gameobjects::_id_D36DCACAC1708708(level.flagactivationdelay);
    wait(level.flagactivationdelay);
    level._id_50A07CDA9851D4B8.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag);
    level._id_21997FBEA8438765.trigger scripts\engine\utility::trigger_on();

    foreach(team in level.teamnamelist)
    scripts\mp\utility\dialog::leaderdialog("obj_generic_capture", team);
  }
}

_id_7077C9E2D480FAB5(team) {
  level.pickuptime = 0;
  level.returntime = 0;
  radius = 32;
  trigger = spawn("trigger_radius", level._id_B5538188C80D8AF6[0], 0, radius, 128);
  visuals = [];
  visuals[0] = spawn("script_model", level._id_B5538188C80D8AF6[0]);
  visuals[0] setModel(level.flagmodel[team]);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(team);
  _id_4E86579DC7E39505 = "neutral";
  _id_3BC2B88A59B6D062 = scripts\mp\gameobjects::createcarryobject(_id_4E86579DC7E39505, trigger, visuals, (0, 0, 85));
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::allowcarry("any");
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setteamusetime("friendly", level.pickuptime);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setteamusetime("enemy", level.returntime);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setvisibleteam("none");
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);
  _id_3BC2B88A59B6D062 scripts\mp\objidpoolmanager::objective_set_play_intro(_id_3BC2B88A59B6D062.objidnum, 0);
  _id_3BC2B88A59B6D062 scripts\mp\objidpoolmanager::objective_set_play_outro(_id_3BC2B88A59B6D062.objidnum, 0);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::registercarryobjectpickupcheck(::flagpickupchecks);
  _id_3BC2B88A59B6D062.allowweapons = 1;
  _id_3BC2B88A59B6D062.firstpickup = 1;
  _id_3BC2B88A59B6D062.onpickup = ::onpickup;
  _id_3BC2B88A59B6D062.onpickupfailed = ::onpickup;
  _id_3BC2B88A59B6D062.ondrop = ::ondrop;
  _id_3BC2B88A59B6D062.onreset = ::onreset;

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 60.0;
        break;
      case 1:
        _id_3BC2B88A59B6D062.objidpingfriendly = 0;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 0.05;
        break;
      case 2:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 1.0;
        break;
      case 3:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 1.5;
        break;
      case 4:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 2.0;
        break;
      case 5:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 3.0;
        break;
      case 6:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 4.0;
        break;
    }

    _id_220BE32C83520117 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    _id_3BC2B88A59B6D062.pingobjidnum = _id_220BE32C83520117;
    scripts\mp\objidpoolmanager::objective_add_objective(_id_220BE32C83520117, "done", _id_3BC2B88A59B6D062.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(_id_220BE32C83520117, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(_id_220BE32C83520117, 0);
    _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setvisibleteam("none", _id_220BE32C83520117);
    objective_setownerteam(_id_220BE32C83520117, team);
    _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag, _id_220BE32C83520117);
  } else {
    _id_3BC2B88A59B6D062.objidpingfriendly = 1;
    _id_3BC2B88A59B6D062.objidpingenemy = 0;
    _id_3BC2B88A59B6D062.objpingdelay = 3.0;
  }

  level._id_50A07CDA9851D4B8 = _id_8BE5D726C39ECED3(team, _id_3BC2B88A59B6D062);
  return _id_3BC2B88A59B6D062;
}

_id_8BE5D726C39ECED3(team, _id_3BC2B88A59B6D062) {
  _id_D9CA1813B9DE5E20 = _id_3BC2B88A59B6D062.visuals[0].origin;
  _id_0FD8B4C619F5E9FF = spawn("script_model", _id_D9CA1813B9DE5E20);
  _id_0FD8B4C619F5E9FF setModel(level.flagbase[team]);
  _id_0FD8B4C619F5E9FF.ownerteam = "neutral";
  _id_0FD8B4C619F5E9FF setasgametypeobjective();
  _id_0FD8B4C619F5E9FF setteaminhuddatafromteamname(team);
  _id_0FD8B4C619F5E9FF.objectiveicon = scripts\mp\gameobjects::createobjidobject(_id_D9CA1813B9DE5E20, "neutral", (0, 0, 85), undefined, "any", 0);
  _id_0FD8B4C619F5E9FF.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");

  if(level.flagactivationdelay) {
    _id_3BC2B88A59B6D062.trigger scripts\engine\utility::trigger_off();
    _id_0FD8B4C619F5E9FF.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.icontarget, level.icontarget, level.mlgiconfullflag);
  } else
    _id_0FD8B4C619F5E9FF.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag);

  return _id_0FD8B4C619F5E9FF;
}

setteaminhuddatafromteamname(_id_FABF84450735DD93) {
  if(_id_FABF84450735DD93 == "axis")
    self setteaminhuddata(1);
  else if(_id_FABF84450735DD93 == "allies")
    self setteaminhuddata(2);
  else
    self setteaminhuddata(0);
}

flagpickupchecks(player) {
  return !player scripts\cp_mp\utility\player_utility::isinvehicle();
}

onpickup(player, _id_5760E0F038D1BAA3, defused) {
  self notify("picked_up");
  player notify("obj_picked_up");
  level._id_50A07CDA9851D4B8.objectiveicon scripts\mp\gameobjects::setvisibleteam("none");
  level._id_21997FBEA8438765.currentcarrier = player;
  player thread awardobjtimeforcarrier();
  ownerteam = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setownerteam(player.team);
  team = player.pers["team"];
  level._id_59A1F917FB3131A6 = team;

  if(team == "allies")
    otherteam = "axis";
  else
    otherteam = "allies";

  player attachflag();
  player scripts\mp\utility\stats::incpersstat("pickups", 1);

  if(self.ownerteam == "allies")
    setomnvar("ui_single_flag_loc", player getentitynumber());
  else
    setomnvar("ui_single_flag_loc", player getentitynumber());

  player setclientomnvar("ui_flag_player_hud_icon", 1);

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0)
      scripts\mp\gameobjects::setvisibleteam("none");
    else {
      scripts\mp\gameobjects::setvisibleteam("friendly");
      objective_state(self.pingobjidnum, "current");
      scripts\mp\gameobjects::updatecompassicon("enemy", self.pingobjidnum);
      objective_icon(self.pingobjidnum, "icon_waypoint_kill");
      objective_setbackground(self.pingobjidnum, 2);
      scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.pingobjidnum, 1);
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.pingobjidnum, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
      scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.pingobjidnum, "MP_INGAME_ONLY/OBJ_KILL_CAPS");
      objective_setownerteam(self.pingobjidnum, team);
    }
  }

  scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);
  scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", player);

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_taken", team);
    scripts\mp\utility\dialog::leaderdialog("flag_getback", otherteam);
  }

  thread scripts\mp\hud_util::teamplayercardsplash("callout_flagpickup", player);
  player thread scripts\mp\hud_message::showsplash("flagpickup");

  if(!isDefined(self.previouscarrier) || self.previouscarrier != player)
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_91372813B1BCAF92");

  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = player;
  _id_7E2C53B0BCF117D9.eventname = "pickup";
  _id_7E2C53B0BCF117D9.position = player.origin;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  self.previouscarrier = player;

  if(level.codcasterenabled)
    player setgametypevip(1);

  if(level._id_300E0902DDC99C1B > 0)
    thread _id_9962A01F46DD3B58(team);
}

returnflag() {
  scripts\mp\gameobjects::returnhome();
}

ondrop(player) {
  if(isDefined(player.leaving_team)) {
    self.droppedteam = player.leaving_team;
    player.leaving_team = undefined;
  } else if(!isDefined(player))
    self.droppedteam = self.ownerteam;
  else
    self.droppedteam = player.team;

  level._id_21997FBEA8438765.currentcarrier = undefined;
  level._id_59A1F917FB3131A6 = "neutral";

  if(isDefined(player))
    player updatematchstatushintonnoflag();

  scripts\mp\gameobjects::setownerteam("neutral");
  team = self.droppedteam;
  otherteam = scripts\mp\utility\game::getotherteam(self.droppedteam)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(self.pingobjidnum, "done");

  if(level.returntime >= 0)
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag);
  else {
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag);
    scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.objidnum, 1);
  }

  if(self.ownerteam == "allies")
    setomnvar("ui_single_flag_loc", -1);
  else
    setomnvar("ui_single_flag_loc", -1);

  if(isDefined(player))
    player setclientomnvar("ui_flag_player_hud_icon", 0);

  if(isDefined(player)) {
    if(!scripts\mp\utility\player::isreallyalive(player))
      player.carryobject.previouscarrier = undefined;

    if(isDefined(player.carryflag))
      player detachflag();

    scripts\mp\utility\print::printandsoundoneveryone(otherteam, "none", undefined, undefined, "iw9_mp_ui_objective_lost", "", player);

    if(level.codcasterenabled)
      player setgametypevip(0);
  } else
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_dropped", scripts\mp\utility\game::getotherteam(self.droppedteam)[0], "status");
    scripts\mp\utility\dialog::leaderdialog("flag_dropped", self.droppedteam, "status");
  }

  if(level.idleresettime > 0)
    thread returnaftertime();

  if(level._id_300E0902DDC99C1B > 0) {
    setomnvar("ui_obj_timer_stopped", 1);
    setomnvar("ui_obj_timer", 0);
    setomnvar("ui_obj_progress", 0);
  }
}

returnaftertime() {
  self endon("picked_up");
  _id_8E53D4CA3DE8531A = 0.0;

  while(_id_8E53D4CA3DE8531A < level.idleresettime) {
    waitframe();

    if(self.claimteam == "none")
      _id_8E53D4CA3DE8531A = _id_8E53D4CA3DE8531A + level.framedurationseconds;
  }

  foreach(team in level.teamnamelist)
  scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", team);

  scripts\mp\gameobjects::returnhome();
}

onreset() {
  level._id_21997FBEA8438765.currentcarrier = undefined;

  if(isDefined(level._id_21997FBEA8438765.portable_radar)) {
    level._id_21997FBEA8438765.portable_radar clearportableradar();
    level._id_21997FBEA8438765.portable_radar delete();
  }

  if(isDefined(self.droppedteam))
    scripts\mp\gameobjects::setownerteam(self.droppedteam);

  team = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);
  level._id_50A07CDA9851D4B8.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", scripts\mp\utility\game::getotherteam(self.droppedteam)[0], "status");
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", self.droppedteam, "status");
  }

  self.droppedteam = undefined;

  if(self.ownerteam == "allies")
    setomnvar("ui_single_flag_loc", -2);
  else
    setomnvar("ui_single_flag_loc", -2);

  self.previouscarrier = undefined;
}

attachflag() {
  updatematchstatushintonhasflag();
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  self attach(level.carryflag[otherteam], "tag_stowed_back3", 1);
  self.carryflag = level.carryflag[otherteam];
}

detachflag() {
  self detach(self.carryflag, "tag_stowed_back3");
  self.carryflag = undefined;
}

updatematchstatushintonnoflag() {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("single_flag_cap");
}

updatematchstatushintonhasflag() {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("single_flag_cap");
}

awardobjtimeforcarrier(team) {
  level endon("game_ended");
  level._id_21997FBEA8438765 endon("dropped");
  level._id_21997FBEA8438765 endon("reset");
  level notify("objTimePointsRunning");
  level endon("objTimePointsRunning");

  while(!level.gameended) {
    wait 1;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!level.gameended) {
      level._id_21997FBEA8438765.carrier scripts\mp\utility\stats::incpersstat("objTime", 1);
      level._id_21997FBEA8438765.carrier scripts\mp\persistence::statsetchild("round", "objTime", level._id_21997FBEA8438765.carrier.pers["objTime"]);
      level._id_21997FBEA8438765.carrier scripts\mp\utility\stats::setextrascore0(level._id_21997FBEA8438765.carrier.pers["objTime"]);
      level._id_21997FBEA8438765.carrier scripts\mp\gamescore::giveplayerscore("stat_98BFD8D29C56BC08", 10);
    }
  }
}

_id_9962A01F46DD3B58(team) {
  _id_300E0902DDC99C1B = int(gettime() + level._id_300E0902DDC99C1B * 1000);
  setomnvar("ui_obj_timer", _id_300E0902DDC99C1B);
  setomnvar("ui_obj_progress", 1);
  setomnvar("ui_objective_timer_stopped", 0);
  level thread scripts\mp\hud_message::notifyteam("flag_force_hold_fr", "flag_force_hold_en", team);
  thread _id_04D2DB447DDF43E1(level._id_300E0902DDC99C1B);
  thread _id_8028646F3CC80AC4();
}

_id_04D2DB447DDF43E1(_id_300E0902DDC99C1B) {
  level._id_21997FBEA8438765 endon("dropped");
  _id_4335B4D453C6E781 = _id_300E0902DDC99C1B;

  while(!level.gameended) {
    setomnvar("ui_obj_progress", _id_4335B4D453C6E781 / _id_300E0902DDC99C1B);
    _id_4335B4D453C6E781 = _id_4335B4D453C6E781 - level.framedurationseconds;
    wait(level.framedurationseconds);
  }
}

_id_8028646F3CC80AC4() {
  level endon("game_ended");
  self endon("dropped");
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level._id_300E0902DDC99C1B);
  level thread scripts\mp\gamelogic::endgame(level._id_21997FBEA8438765 scripts\mp\gameobjects::getownerteam(), game["end_reason"]["ko_flag_hold_win"], game["end_reason"]["ko_flag_hold_loss"]);
}

dogtagallyonusecb(player) {
  player.health = player.maxhealth;
  player notify("healed");
}

dogtagenemyonusecb(player) {
  player.health = player.maxhealth;
  player notify("healed");
}

outlineenemyplayers() {
  level endon("prematch_done");
  level endon("removeArenaOutlines");

  for(;;) {
    level waittill("spawned_player");
    waitframe();

    foreach(player in level.players) {
      entnum = player getentitynumber();

      if(!isDefined(player.outlinedenemies)) {
        if(!isDefined(level.activeoutlines))
          level.activeoutlines = 1;
        else
          level.activeoutlines++;
      }

      foreach(_id_AC0E424AC96A7113 in level.players) {
        if(_id_AC0E424AC96A7113 != player && _id_AC0E424AC96A7113.team != player.team) {
          if(isDefined(player.outlinedenemies))
            scripts\mp\utility\outline::outlinedisable(player.outlinedenemies, player);

          player.outlinedenemies = scripts\mp\utility\outline::outlineenableforteam(player, _id_AC0E424AC96A7113.team, "outline_nodepth_orange", "level_script");
          break;
        }
      }
    }
  }
}

removeenemyoutlines() {
  thread notifyremoveoutlines();
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(player in level.players) {
    entnum = player getentitynumber();

    if(isDefined(player.outlinedenemies)) {
      level.activeoutlines--;
      scripts\mp\utility\outline::outlinedisable(player.outlinedenemies, player);
      player.outlinedenemies = undefined;
    }
  }
}

notifyremoveoutlines() {
  level endon("prematch_done");
  level waittill("match_start_real_countdown");

  if(level.prematchperiodend > 5)
    time = int(max(level.prematchperiodend - 5, 5));
  else
    time = int(max(level.prematchperiodend - 2, 2));

  wait(time);
  level notify("removeArenaOutlines");
}

outlineequipmentwatchplayerprox(equipname) {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];
  basescore = level.baseraritymap[equipname];
  _id_4430B08D5A2D47BF = getoutlineasset(basescore, equipname);

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(player.hasarenaspawned)) {
        dist = distance2dsquared(self.origin, player.origin);
        entnum = player getentitynumber();

        if(dist < 490000) {
          if(!isDefined(self.outlinedplayers[entnum])) {
            if(!isDefined(level.activeoutlines))
              level.activeoutlines = 1;
            else
              level.activeoutlines++;

            self.outlinedplayers[entnum] = scripts\mp\utility\outline::outlineenableforplayer(self, player, _id_4430B08D5A2D47BF, "level_script");
          }
        } else if(isDefined(self.outlinedplayers[entnum])) {
          level.activeoutlines--;
          scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[entnum], self);
          self.outlinedplayers[entnum] = undefined;
        }
      }
    }

    waitframe();
  }
}

outlinewatchplayerprox() {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];
  _id_C27E2A04BAB78C1F = scripts\mp\weapons::getitemweaponname();
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_C27E2A04BAB78C1F);
  basescore = level.baseraritymap[_id_AB501F397D3CD312 + "_mp"];
  _id_4430B08D5A2D47BF = getoutlineasset(basescore);

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(player.hasarenaspawned)) {
        dist = distance2dsquared(self.origin, player.origin);
        entnum = player getentitynumber();

        if(dist < 490000) {
          if(!isDefined(self.outlinedplayers[entnum])) {
            if(!isDefined(level.activeoutlines))
              level.activeoutlines = 1;
            else
              level.activeoutlines++;

            self.outlinedplayers[entnum] = scripts\mp\utility\outline::outlineenableforplayer(self, player, _id_4430B08D5A2D47BF, "level_script");
          }
        } else if(isDefined(self.outlinedplayers[entnum])) {
          level.activeoutlines--;
          scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[entnum], self);
          self.outlinedplayers[entnum] = undefined;
        }
      }
    }

    waitframe();
  }
}

getoutlineasset(basescore, equipname) {
  if(!isDefined(basescore))
    basescore = 0;

  _id_4430B08D5A2D47BF = "white";
  score = int(min(basescore, 8));

  switch (score) {
    case 0:
      _id_4430B08D5A2D47BF = "outline_depth_white";
      break;
    case 1:
      _id_4430B08D5A2D47BF = "outline_depth_green";
      break;
    case 2:
      _id_4430B08D5A2D47BF = "outline_depth_cyan";
      break;
    case 3:
      _id_4430B08D5A2D47BF = "outline_depth_red";
      break;
    case 4:
      _id_4430B08D5A2D47BF = "outline_depth_orange";
      break;
    case 5:
      _id_4430B08D5A2D47BF = "outline_depth_yellow";
      break;
    case 6:
      _id_4430B08D5A2D47BF = "outline_depth_blue";
      break;
    case 7:
      _id_4430B08D5A2D47BF = "outline_depth_green";
      break;
    case 8:
      _id_4430B08D5A2D47BF = "outline_depth_red";
      break;
  }

  if(istrue(level.snowballfight) && isDefined(equipname) && equipname == "equip_pball")
    _id_4430B08D5A2D47BF = "outline_depth_yellow";

  return _id_4430B08D5A2D47BF;
}

clearweaponoutlines() {
  foreach(key, value in self.outlinedplayers) {
    level.activeoutlines--;
    scripts\mp\utility\outline::outlinedisable(value, self);
    value = undefined;
  }
}

updatematchstatushintonspawn() {
  level endon("game_ended");
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("kill");
}

seticonnames() {
  level.iconcaptureendzone = "waypoint_capture_endzone";
  level.icondefendendzone = "waypoint_defend_endzone";
  level.iconcontestendzone = "waypoint_contesting_endzone";
  level.icontakingendzone = "waypoint_taking_endzone";
  level.iconlosingendzone = "waypoint_losing_endzone";
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
  level.icondefending = "waypoint_defending";
  level.iconescort = "waypoint_escort_flag";
  level.iconkill = "waypoint_ctf_kill";
  level.iconcaptureflag = "waypoint_take_flag";
  level.icondefendflag = "waypoint_defend_flag";
  level.iconreturnflag = "waypoint_recover_flag";
  level.mlgiconemptyflag = "waypoint_mlg_empty_flag";
  level.mlgiconfullflag = "waypoint_mlg_full_flag";
  level.icontarget = "waypoint_target";
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_losing_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contesting_endzone", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_dom_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defending_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocked_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_losing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_captureneutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_a", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dom_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_ot_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags", 1, "enemy", "", "hud_icon_minimap_misc_dog_tag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags_friendly", 1, "friendly", "", "hud_icon_minimap_misc_dog_tag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_recover_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_take_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0);
}

_id_18F22ECED61C5F6F() {
  return level.arenaloadouts == 1;
}

israndomloadouts() {
  return level.arenaloadouts == 2 || israndomarloadouts() || israndomsmgloadouts() || israndompistolloadouts() || israndomshotgunloadouts() || israndomsniperloadouts() || israndomlmgloadouts() || israndomblueprintsloadouts() || israndomcustomblueprintsloadouts() || israndomnoattachmentloadouts();
}

ispickuploadouts() {
  return level.arenaloadouts == 3 || level.arenaloadouts == 14;
}

isgungameloadouts() {
  return level.arenaloadouts == 4;
}

isrvsgungameloadouts() {
  return level.arenaloadouts == 5;
}

israndomarloadouts() {
  return level.arenaloadouts == 7;
}

israndomsmgloadouts() {
  return level.arenaloadouts == 8;
}

israndompistolloadouts() {
  return level.arenaloadouts == 9;
}

israndomshotgunloadouts() {
  return level.arenaloadouts == 10;
}

israndomsniperloadouts() {
  return level.arenaloadouts == 11;
}

israndomlmgloadouts() {
  return level.arenaloadouts == 12;
}

israndomblueprintsloadouts() {
  return level.arenaloadouts == 13;
}

ispickupblueprintloadouts() {
  return level.arenaloadouts == 14;
}

israndomcustomblueprintsloadouts() {
  return level.arenaloadouts == 15;
}

israndomnoattachmentloadouts() {
  return level.arenaloadouts == 16;
}

_id_C0C1519B5CFB9BD5() {
  return israndomblueprintsloadouts() || ispickupblueprintloadouts() || israndomcustomblueprintsloadouts();
}

_id_46A9AE30A3B356A8() {
  return level.objmodifier == 0;
}

_id_444E57E02C02BEE6() {
  return level.objmodifier == 1;
}

_id_2EDA32F1D16DED2C() {
  return level.objmodifier == 2;
}

snowballfight() {
  if(istrue(game["practiceRound"]) || istrue(level.alwayssnowfight)) {
    level.lethaldelay = 0;
    defineplayerloadout();
  }

  initweaponmap();
  thread setupsnowballs();
}

setupsnowballs() {
  level.arenaweapont1.weapon = "equip_snowball";

  if(!istrue(level.alwayssnowfight) && !istrue(game["practiceRound"])) {
    level.arenaweapont1.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont1.weapon, "equip_snowball");
    level.arenaweapont2.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont2.weapon, "equip_snowball");
    level.arenaweapont3.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont3.weapon, "equip_snowball");
    level.arenaweapont4.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont4.weapon, "equip_snowball");
    level.arenaweapont5.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont5.weapon, "equip_snowball");
    level.arenaweapont6.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont6.weapon, "equip_snowball");
    level.arenaweapont7.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont7.weapon, "equip_snowball");
    level.arenaweapont8.weapon = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level.arenaweapont8.weapon, "equip_snowball");
  }

  level.pickedpball = 0;
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("weapon_pickup", "targetname");

  foreach(loc in _id_9577902B42FBD7F6) {
    if(istrue(level.alwayssnowfight) || istrue(game["practiceRound"]) || level.arenaloadouts != 3) {
      spawnweapon(loc, level.arenaweapont1);
      continue;
    }

    if(loc.script_label == "1") {
      spawnweapon(loc, level.arenaweapont1);
      continue;
    }

    if(loc.script_label == "2") {
      spawnweapon(loc, level.arenaweapont2);
      continue;
    }

    if(loc.script_label == "3") {
      spawnweapon(loc, level.arenaweapont3);
      continue;
    }

    if(loc.script_label == "4") {
      spawnweapon(loc, level.arenaweapont4);
      continue;
    }

    if(loc.script_label == "5") {
      spawnweapon(loc, level.arenaweapont5);
      continue;
    }

    if(loc.script_label == "6") {
      spawnweapon(loc, level.arenaweapont6);
      continue;
    }

    if(loc.script_label == "7") {
      spawnweapon(loc, level.arenaweapont7);
      continue;
    }

    if(loc.script_label == "8")
      spawnweapon(loc, level.arenaweapont8);
  }
}

watchsnowballpickup(loc, _id_AB5F95BA81A1A976) {
  self endon("death");
  self waittill("trigger", player, _id_76F4143215683892);
  hasmaxammo = 0;
  _id_F23035E6F6B69F91 = checkissameequip(player);
  _id_0C89F07DA007FF0D = checkpickupequiptypeammocount(player);

  if(self.equipment == "equip_snowball")
    _id_8B9AB3ABAE98D973 = 10;
  else
    _id_8B9AB3ABAE98D973 = 1;

  _id_B64209459DA65860 = checkcurrentequiptypeammocount(player);
  _id_D9F8A2BC44267F00 = 1;

  switch (_id_AB5F95BA81A1A976) {
    case "pile":
      _id_D9F8A2BC44267F00 = 10;
      break;
    case "pyramid":
      _id_D9F8A2BC44267F00 = 5;
      break;
    default:
      _id_D9F8A2BC44267F00 = 1;
      break;
  }

  if(_id_F23035E6F6B69F91) {
    if(_id_0C89F07DA007FF0D == _id_8B9AB3ABAE98D973)
      hasmaxammo = 1;
  }

  if(_id_F23035E6F6B69F91 && !hasmaxammo)
    player scripts\mp\equipment::incrementequipmentammo(self.equipment, _id_D9F8A2BC44267F00);
  else if(_id_B64209459DA65860 && !_id_F23035E6F6B69F91 && !isPlayer(loc))
    player dropoldequipinplace(player scripts\mp\equipment::getcurrentequipment(self.equiptype));

  if(!_id_F23035E6F6B69F91) {
    player scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);

    if(self.equipment == "equip_snowball" && !hasmaxammo)
      player scripts\mp\equipment::incrementequipmentammo(self.equipment, _id_D9F8A2BC44267F00);
  }

  if(_id_F23035E6F6B69F91 && hasmaxammo) {
    player iprintlnbold(&"MP_INGAME_ONLY/EQUIPMENT_MAXED");
    thread watchequipmentpickup();
  } else {
    player playlocalsound("scavenger_pack_pickup");
    playFX(level.snowfx["vanish"], self.origin);
    clearweaponoutlines();

    if(!isPlayer(loc))
      level thread waitthenrespawnsnowballs(loc);

    self makeunusable();
    self delete();
  }
}

waitthenrespawnsnowballs(loc) {
  level endon("game_ended");
  wait 15;
  playFX(level.snowfx["vanish"], loc.origin);
  spawnweapon(loc, level.arenaweapont1);
}

snowballmeleewatcher() {
  level scripts\mp\flags::gameflagwait("prematch_done");
  wait 1;
  self allowmelee(0);
}

getknivesoutsetting() {
  if(scripts\mp\utility\game::matchmakinggame())
    return getdvarint("scr_arena_knivesout", 0);
  else if(isthrowingknifeequipment(level.arenaweapont1.weapon) && isthrowingknifeequipment(level.arenaweapont2.weapon) && isthrowingknifeequipment(level.arenaweapont3.weapon) && isthrowingknifeequipment(level.arenaweapont4.weapon) && isthrowingknifeequipment(level.arenaweapont5.weapon) && isthrowingknifeequipment(level.arenaweapont6.weapon) && isthrowingknifeequipment(level.arenaweapont7.weapon) && isthrowingknifeequipment(level.arenaweapont8.weapon)) {
    if(isthrowingknifeequipment(level.startweapon.weapon))
      return 2;
    else
      return 1;
  }

  return 0;
}

isthrowingknifeequipment(weapon) {
  if(weapon == "equip_throwing_knife" || weapon == "equip_throwing_knife_fire" || weapon == "equip_throwing_knife_electric")
    return 1;
  else
    return 0;
}

fixupsupersandtacticalsforgunfightmaps() {
  switch (level._id_10E2EBD08FAC3FAF) {
    case "super_weapon_drop":
    case "super_emp_drone":
    case "super_recon_drone":
      level._id_10E2EBD08FAC3FAF = "super_ammo_drop";
      break;
    default:
      level._id_10E2EBD08FAC3FAF = "none";
      break;
  }

  return level._id_10E2EBD08FAC3FAF;
}

_id_5A0A68144C7A97FD(_id_F4692D0892428480) {
  if(isDefined(_id_F4692D0892428480)) {
    switch (_id_F4692D0892428480) {
      case "equip_adrenaline":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_STIM";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_stim";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_1h_wm_stim_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "secondary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_at_mine":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_ATMINE";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_at_mine";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_2h_wm_proximity_mine_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "primary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_bunkerbuster":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_BUNKERBUSTER";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_bunker_buster";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_2h_wm_bunker_buster_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "primary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_c4":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_C4";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_c4";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_2h_wm_c4_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "primary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_claymore":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_CLAYMORE";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_claymore";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_2h_wm_claymore_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "primary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_concussion":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_STUN";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_stun";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_1h_wm_grenade_concussion_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "secondary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_decoy":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_DECOY";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_decoy";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_1h_wm_grenade_decoy_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "secondary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_flash":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_FLASH";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_flash";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_1h_wm_grenade_flash_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "secondary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_frag":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_FRAG";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_frag";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_2h_wm_grenade_frag_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "primary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_hb_sensor":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_HB_SENSOR";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_hb_sensor";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_1h_wm_tablet_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "secondary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_molotov":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_MOLOTOV";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_molotov";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_2h_wm_molotov_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "primary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_semtex":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_SEMTEX";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_semtex";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_2h_wm_grenade_semtex_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "primary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_shockstick":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_SHOCK_STICK";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_shock_stick";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_1h_wm_shock_stick_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "secondary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_smoke":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_SMOKE";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_smoke";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_1h_wm_grenade_smoke_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "secondary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_snapshot_grenade":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_SNAPSHOT";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_snapshot";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_1h_wm_grenade_snapshot_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "secondary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_thermite":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_THERMITE";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_thermite";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_2h_wm_grenade_thermite_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "primary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_throwing_knife":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_TKNIFE";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_throwing_knife";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_2h_wm_throwing_knife_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "primary";
        return _id_9B83EFBA8BFECC3F;
      case "equip_throwstar":
        _id_9B83EFBA8BFECC3F = spawnStruct();
        _id_9B83EFBA8BFECC3F._id_646AE38B7851BEB4 = &"MP_INGAME_ONLY/PICKUP_TSTAR";
        _id_9B83EFBA8BFECC3F.icon = "hud_icon_equipment_shuriken";
        _id_9B83EFBA8BFECC3F.worldmodel = "offhand_2h_wm_throw_star_v0";
        _id_9B83EFBA8BFECC3F.equiptype = "primary";
        return _id_9B83EFBA8BFECC3F;
    }
  }

  return undefined;
}

_id_BCFD6092FB52494F() {
  return ["ar", "br", "dm", "lm", "pi", "sh", "sm", "sn"];
}

_id_F8BE37B178EFC473(_id_4930AED7DF4F9479) {
  if(isDefined(_id_4930AED7DF4F9479)) {
    switch (_id_4930AED7DF4F9479) {
      case "assault":
      case "ar":
        return "ar";
      case "battlerifle":
      case "br":
        return "br";
      case "dmr":
      case "dm":
        return "dm";
      case "lethal":
        return "lethal";
      case "lmg":
      case "lm":
        return "lm";
      case "pi":
      case "pistol":
        return "pi";
      case "sh":
      case "spread":
        return "sh";
      case "sm":
      case "smg":
        return "sm";
      case "sn":
      case "sniper":
        return "sn";
      case "tactical":
        return "tactical";
    }
  }

  return undefined;
}

getrandomweaponforweapontier(_id_63573DFB900DD221) {
  if(issubstr(_id_63573DFB900DD221, "rand")) {
    if(_id_63573DFB900DD221 == "random")
      return getrandomweapon();

    _id_67F14F8315CB0F2F = strtok(_id_63573DFB900DD221, "_", 1);
    _id_4930AED7DF4F9479 = _id_F8BE37B178EFC473(_id_67F14F8315CB0F2F[1]);
    return getrandomweaponfromcategory(_id_4930AED7DF4F9479);
  }

  return _id_63573DFB900DD221;
}

getrandomweapon() {
  _id_4930AED7DF4F9479 = scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_BCFD6092FB52494F());
  return getrandomweaponfromcategory(_id_4930AED7DF4F9479);
}

getrandomweaponfromcategory(_id_4930AED7DF4F9479) {
  if(!isDefined(game["arenaWeaponCategories"]))
    return "none";

  if(!isDefined(game["arenaWeaponCategories"][_id_4930AED7DF4F9479]) || game["arenaWeaponCategories"][_id_4930AED7DF4F9479].size == 0)
    return "none";

  return scripts\engine\utility::_id_7A2AAA4A09A4D250(game["arenaWeaponCategories"][_id_4930AED7DF4F9479]);
}

_id_11A6A3EC5C206652(weaponname) {
  if(!isDefined(game["arenaWeapons"]) || !isDefined(game["arenaWeapons"][weaponname]))
    return -1;

  if(game["arenaWeapons"][weaponname]._id_4F62FB945AD6AF8D.size > 0) {
    _id_5F01A4F51A4FD8D1 = scripts\engine\utility::_id_7A2AAA4A09A4D250(game["arenaWeapons"][weaponname]._id_4F62FB945AD6AF8D);
    return _id_5F01A4F51A4FD8D1.id;
  }

  return -1;
}

_id_10CEA0880B71973A() {
  if(!isDefined(game["arenaWeaponCategories"]))
    game["arenaWeaponCategories"] = [];

  game["arenaWeaponCategories"]["lethal"] = [];
  game["arenaWeaponCategories"]["tactical"] = [];
  _id_4FB2A4F952C69478 = "arena_equipment_table_lethal_iw9_mp";
  _id_0AB30739970ABC53 = getscriptbundle(_func_2EF675C13CA1C4AF("enum_49799BD1F8BDA011", _id_4FB2A4F952C69478));

  if(isDefined(_id_0AB30739970ABC53)) {
    foreach(equipment in _id_0AB30739970ABC53._id_A1A3722FB9707783)
    game["arenaWeaponCategories"]["lethal"][game["arenaWeaponCategories"]["lethal"].size] = equipment._id_F4692D0892428480;
  }

  _id_8EF2530A2B79D56F = "arena_equipment_table_tactical_iw9_mp";
  _id_005CEC6CA6494B24 = getscriptbundle(_func_2EF675C13CA1C4AF("enum_49799BD1F8BDA011", _id_8EF2530A2B79D56F));

  if(isDefined(_id_005CEC6CA6494B24)) {
    foreach(equipment in _id_005CEC6CA6494B24._id_A1A3722FB9707783)
    game["arenaWeaponCategories"]["tactical"][game["arenaWeaponCategories"]["tactical"].size] = equipment._id_F4692D0892428480;
  }
}

_id_B7C18DED2347456C() {
  if(!isDefined(game["arenaWeaponCategories"]))
    game["arenaWeaponCategories"] = [];

  weaponcategories = _id_BCFD6092FB52494F();

  foreach(_id_4930AED7DF4F9479 in weaponcategories) {
    game["arenaWeaponCategories"][_id_4930AED7DF4F9479] = [];
    _id_C67243A779C0E924 = scripts\engine\utility::_id_996B01CD49D0128D(["arena_weapon_table", _id_4930AED7DF4F9479, "iw9_mp"], "_");
    _id_E1898741919F6AAF = getscriptbundle(_func_2EF675C13CA1C4AF("enum_6946961762BBE55B", _id_C67243A779C0E924));

    if(!isDefined(_id_E1898741919F6AAF)) {
      continue;
    }
    foreach(weapon in _id_E1898741919F6AAF.weaponlist) {
      _id_49E6EF3EDADD524E = _id_D0FB12B63980C3A4(weapon._id_A5E6A8A5E3C7B581);

      if(isDefined(_id_49E6EF3EDADD524E) && _id_49E6EF3EDADD524E != "none")
        game["arenaWeaponCategories"][_id_4930AED7DF4F9479][game["arenaWeaponCategories"][_id_4930AED7DF4F9479].size] = _id_49E6EF3EDADD524E;
    }
  }
}

_id_DE46980D57F0C37A() {
  weaponcategories = [];
  _id_6BBF329F0B15A970 = !israndomarloadouts() && !israndomsmgloadouts() && !israndomlmgloadouts() && !israndompistolloadouts() && !israndomshotgunloadouts() && !israndomsniperloadouts();

  if(istrue(_id_6BBF329F0B15A970) || israndomarloadouts()) {
    weaponcategories[weaponcategories.size] = "ar";
    weaponcategories[weaponcategories.size] = "br";
  }

  if(istrue(_id_6BBF329F0B15A970) || israndomsmgloadouts())
    weaponcategories[weaponcategories.size] = "sm";

  if(istrue(_id_6BBF329F0B15A970) || israndomlmgloadouts())
    weaponcategories[weaponcategories.size] = "lm";

  if(istrue(_id_6BBF329F0B15A970) || israndompistolloadouts())
    weaponcategories[weaponcategories.size] = "pi";

  if(istrue(_id_6BBF329F0B15A970) || israndomshotgunloadouts())
    weaponcategories[weaponcategories.size] = "sh";

  if(istrue(_id_6BBF329F0B15A970) || israndomsniperloadouts()) {
    weaponcategories[weaponcategories.size] = "sn";
    weaponcategories[weaponcategories.size] = "dm";
  }

  foreach(_id_4930AED7DF4F9479 in weaponcategories) {
    classtablename = scripts\engine\utility::_id_996B01CD49D0128D(["arena_class_table", _id_4930AED7DF4F9479, "iw9_mp"], "_");
    _id_6AB15B7EA89D055D = getscriptbundle(_func_2EF675C13CA1C4AF("enum_2E0802494805F439", classtablename));

    if(!isDefined(_id_6AB15B7EA89D055D)) {
      continue;
    }
    foreach(class in _id_6AB15B7EA89D055D._id_8D5460BE7DB831C3)
    _id_C20500181EA66DC8(class._id_5FF608A2CF5C041B);
  }
}

_id_D0FB12B63980C3A4(_id_A5E6A8A5E3C7B581) {
  if(!isDefined(level.weaponmapdata))
    return "none";

  if(!isDefined(_id_A5E6A8A5E3C7B581))
    return "none";

  _id_AD06B30A27981C99 = getscriptbundle(_func_2EF675C13CA1C4AF("enum_318BEC5C5FA0DD65", _id_A5E6A8A5E3C7B581));

  if(!isDefined(_id_AD06B30A27981C99))
    return "none";

  if(!isDefined(game["arenaWeapons"]))
    game["arenaWeapons"] = [];
  else if(isDefined(game["arenaWeapons"][_id_AD06B30A27981C99._id_AB501F397D3CD312]))
    return _id_AD06B30A27981C99._id_AB501F397D3CD312;

  game["arenaWeapons"][_id_AD06B30A27981C99._id_AB501F397D3CD312] = spawnStruct();
  game["arenaWeapons"][_id_AD06B30A27981C99._id_AB501F397D3CD312]._id_AB501F397D3CD312 = _id_AD06B30A27981C99._id_AB501F397D3CD312;
  game["arenaWeapons"][_id_AD06B30A27981C99._id_AB501F397D3CD312]._id_4F62FB945AD6AF8D = [];

  if(_id_C0C1519B5CFB9BD5()) {
    _id_4F62FB945AD6AF8D = _func_BB92A5000082832A(level.weaponmapdata[_id_AD06B30A27981C99._id_AB501F397D3CD312].assetname);

    foreach(_id_2A169C65850E1A47, _id_6CEC5443C5A603C1 in _id_4F62FB945AD6AF8D) {
      foreach(_id_89A1BFD436D69E12 in _id_AD06B30A27981C99._id_E5D6E73468B763D4) {
        if(_id_89A1BFD436D69E12._id_2A169C65850E1A47 == _id_2A169C65850E1A47) {
          _id_12C0F53A71C9BCC8 = game["arenaWeapons"][_id_AD06B30A27981C99._id_AB501F397D3CD312]._id_4F62FB945AD6AF8D.size;
          game["arenaWeapons"][_id_AD06B30A27981C99._id_AB501F397D3CD312]._id_4F62FB945AD6AF8D[_id_12C0F53A71C9BCC8] = spawnStruct();
          game["arenaWeapons"][_id_AD06B30A27981C99._id_AB501F397D3CD312]._id_4F62FB945AD6AF8D[_id_12C0F53A71C9BCC8].name = _id_2A169C65850E1A47;
          game["arenaWeapons"][_id_AD06B30A27981C99._id_AB501F397D3CD312]._id_4F62FB945AD6AF8D[_id_12C0F53A71C9BCC8].id = _id_6CEC5443C5A603C1;
        }
      }
    }
  }

  return _id_AD06B30A27981C99._id_AB501F397D3CD312;
}

_id_C20500181EA66DC8(_id_5FF608A2CF5C041B) {
  if(!isDefined(_id_5FF608A2CF5C041B)) {
    return;
  }
  _id_344C92BDA1A2DDFB = getscriptbundle(_func_2EF675C13CA1C4AF("enum_07AF4F547630FA97", _id_5FF608A2CF5C041B));

  if(!isDefined(_id_344C92BDA1A2DDFB)) {
    return;
  }
  _id_28ABC316A4B48E40 = !israndomnoattachmentloadouts();

  if(!isDefined(game["arenaLoadouts"]))
    game["arenaLoadouts"] = [];

  loadoutindex = game["arenaLoadouts"].size;
  _id_CD5F58507F5977D2 = _id_D0FB12B63980C3A4(_id_344C92BDA1A2DDFB.primaryweapon._id_A5E6A8A5E3C7B581);

  if(!isDefined(_id_CD5F58507F5977D2) || _id_CD5F58507F5977D2 == "none") {
    return;
  }
  _id_31FA4BCDEDEE4712 = _id_D0FB12B63980C3A4(_id_344C92BDA1A2DDFB.secondaryweapon._id_A5E6A8A5E3C7B581);

  if(!isDefined(_id_31FA4BCDEDEE4712)) {
    return;
  }
  if(_id_C0C1519B5CFB9BD5()) {
    if(!isDefined(game["arenaWeapons"][_id_CD5F58507F5977D2]._id_4F62FB945AD6AF8D) || game["arenaWeapons"][_id_CD5F58507F5977D2]._id_4F62FB945AD6AF8D.size == 0) {
      return;
    }
    if(_id_31FA4BCDEDEE4712 != "none" && (!isDefined(game["arenaWeapons"][_id_31FA4BCDEDEE4712]._id_4F62FB945AD6AF8D) || game["arenaWeapons"][_id_31FA4BCDEDEE4712]._id_4F62FB945AD6AF8D.size == 0))
      return;
  }

  game["arenaLoadouts"][loadoutindex]["loadoutPrimary"] = _id_CD5F58507F5977D2;
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.primaryweapon._id_59F68715C04CE28F, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment1"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.primaryweapon._id_59F68815C04CE4C2, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment2"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.primaryweapon._id_59F68915C04CE6F5, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment3"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.primaryweapon._id_59F68215C04CD790, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment4"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.primaryweapon._id_59F68315C04CD9C3, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment5"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.primaryweapon._id_59F68415C04CDBF6, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryCamo"] = _id_344C92BDA1A2DDFB.primaryweapon.camo;
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryReticle"] = _id_344C92BDA1A2DDFB.primaryweapon.reticle;
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryVariantID"] = _id_11A6A3EC5C206652(_id_CD5F58507F5977D2);
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAddBlueprintAttachments"] = _id_C0C1519B5CFB9BD5();
  game["arenaLoadouts"][loadoutindex]["loadoutSecondary"] = _id_31FA4BCDEDEE4712;
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.secondaryweapon._id_59F68715C04CE28F, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment1"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.secondaryweapon._id_59F68815C04CE4C2, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment2"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.secondaryweapon._id_59F68915C04CE6F5, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment3"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.secondaryweapon._id_59F68215C04CD790, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment4"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.secondaryweapon._id_59F68315C04CD9C3, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment5"] = scripts\engine\utility::ter_op(_id_28ABC316A4B48E40, _id_344C92BDA1A2DDFB.secondaryweapon._id_59F68415C04CDBF6, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryCamo"] = _id_344C92BDA1A2DDFB.secondaryweapon.camo;
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryReticle"] = _id_344C92BDA1A2DDFB.secondaryweapon.reticle;
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryVariantID"] = _id_11A6A3EC5C206652(_id_31FA4BCDEDEE4712);
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAddBlueprintAttachments"] = _id_C0C1519B5CFB9BD5();
  game["arenaLoadouts"][loadoutindex]["loadoutEquipmentPrimary"] = _id_344C92BDA1A2DDFB._id_37241BE71FAF029E;
  game["arenaLoadouts"][loadoutindex]["loadoutEquipmentSecondary"] = _id_344C92BDA1A2DDFB._id_37241AE71FAF006B;
  game["arenaLoadouts"][loadoutindex]["loadoutFieldUpgrade1"] = _id_344C92BDA1A2DDFB._id_7E397F4CE66BFFD0;
  game["arenaLoadouts"][loadoutindex]["loadoutFieldUpgrade2"] = _id_344C92BDA1A2DDFB._id_7E39824CE66C0669;
  game["arenaLoadouts"][loadoutindex]["loadoutPerks"] = [];
  game["arenaLoadouts"][loadoutindex]["loadoutPerks"][0] = _id_344C92BDA1A2DDFB._id_16680ABD1742C050;
  game["arenaLoadouts"][loadoutindex]["loadoutPerks"][1] = _id_344C92BDA1A2DDFB._id_16680DBD1742C6E9;
  game["arenaLoadouts"][loadoutindex]["loadoutPerks"][2] = _id_344C92BDA1A2DDFB._id_16680CBD1742C4B6;
  game["arenaLoadouts"][loadoutindex]["loadoutPerks"][3] = _id_344C92BDA1A2DDFB._id_16680FBD1742CB4F;
  game["arenaLoadouts"][loadoutindex]["loadoutGesture"] = "playerdata";
  game["arenaLoadouts"][loadoutindex]["loadoutExecution"] = "playerdata";
}