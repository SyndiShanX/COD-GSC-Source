/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\arena.gsc
***********************************************/

#using script_3bdadfff7554ceba;
#using script_4a6760982b403bad;
#using script_548072087c9fd504;
#using scripts\common\utility;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arena;
#using scripts\mp\gametypes\arena_alt;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spectating;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace arena;

function main() {
  game["isLaunchChunk"] = getdvarint(@ "hash_61939eb22f175afa", 0) != 0;

  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  level.var_b5538188c80d8af6 = [];
  var_58553518a66cebe9 = getEntArray("cyber_emp_pickup_trig", "targetname");

  foreach(trig in var_58553518a66cebe9) {
    level.var_b5538188c80d8af6[level.var_b5538188c80d8af6.size] = trig.origin;
  }

  level.var_ce291b847f8e2ab7 = (0, 0, 0);
  primaryflags = getEntArray("flag_primary", "targetname");

  foreach(flag in primaryflags) {
    if(flag.script_label == "_b") {
      level.var_ce291b847f8e2ab7 = flag.origin;
      break;
    }
  }

  if(level.var_b5538188c80d8af6.size == 0) {
    level.var_b5538188c80d8af6[level.var_b5538188c80d8af6.size] = level.var_ce291b847f8e2ab7;
  }

  allowed[0] = getgametype();
  allowed[1] = "dom";
  scripts\mp\gameobjects::main(allowed);

  if(game["isLaunchChunk"]) {
    scripts\mp\gametypes\arena_alt::main();
    return;
  }

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 0, 0, 24);
    registertimelimitdvar(getgametype(), 30);
    registerscorelimitdvar(getgametype(), 75);
    registerroundlimitdvar(getgametype(), 19);
    registerwinlimitdvar(getgametype(), 6);
    registernumlivesdvar(getgametype(), 1);
    registerhalftimedvar(getgametype(), 0);
    registerwinbytwoenableddvar(getgametype(), 0);
    registerwinbytwomaxroundsdvar(getgametype(), 4);
  }

  updategametypedvars();
  level.teambased = 1;
  level.objectivebased = 1;
  level.overridetimelimitclock = 10;
  level.ontimelimit = &ontimelimit;
  level.onstartgametype = &onstartgametype;
  level.onplayerconnect = &onplayerconnect;
  level.getspawnpoint = &getspawnpoint;
  level.onplayerdamaged = &onplayerdamaged;
  level.onnormaldeath = &onnormaldeath;
  level.onplayerkilled = &onplayerkilled;
  level.modeonspawnplayer = &onspawnplayer;
  level.ondeadevent = &ondeadevent;
  level.ontimelimitot = &ontimelimitot;
  level.snowballfight = getdvarint(@ "hash_6c1b43f9065ddf4d", 0);
  level.allowlatecomers = 0;
  level.removekilleventsplash = 1;

  if(matchmakinggame()) {
    teamsize = getdvarint(@ "party_maxplayers", 4) / 2;
    level.requiredplayercountoveride = 1;
    level.requiredplayercount["allies"] = teamsize;
    level.requiredplayercount["axis"] = teamsize;
  }

  if(!iswinbytworulegametype()) {
    level.skipdefendersadvantage = 1;
  }

  if(!isnormalloadouts()) {
    level.disablecopycatloadout = 1;
    setomnvar("ui_killcam_copycat", 0);
    level.bypassclasschoicefunc = &scripts\mp\class::alwaysgamemodeclass;
  } else {
    level.disablecopycatloadout = undefined;
  }

  level.arenaknivesout = getknivesoutsetting();

  if(level.arenaknivesout) {
    level.gamemodeoverridemeleeviewkickscale = 0.5;
    level.gamemodeoverriderestockrechargeperupdate = 0.05;
  }

  if(istrue(level.snowballfight)) {
    level.alwayssnowfight = getdvarint(@ "hash_f9511aeb46157a2", 0);
    setdvarifuninitialized(@ "hash_10d9bf7945521aa4", 1);
    setdvarifuninitialized(@ "hash_525526c06343abd1", "loadscreenhintoverlay_snowball_gunfight");

    if(level.alwayssnowfight) {
      level.practiceround = 0;
    } else {
      level.practiceround = 1;
    }
  }

  if(istrue(level.teambased)) {
    setdvarifuninitialized(@ "hash_525526c06343abd1", "loadscreenhintoverlay_teamgunfight");
  }

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    game["dialog"]["gametype"] = "dx_mp_gunf_game_t141_gfnm";
  } else {
    game["dialog"]["gametype"] = "dx_mp_gunf_game_t141_gfnm";
  }

  if(ispickuploadouts() && !isDefined(game["roundsPlayed"])) {
    game["dialog"]["offense_obj"] = "dx_mp_gunf_game_t141_gfbo";
    game["dialog"]["defense_obj"] = "dx_mp_gunf_game_t141_gfbo";
  } else if(function_444e57e02c02bee6() && !isDefined(game["roundsPlayed"])) {
    game["dialog"]["offense_obj"] = "dx_mp_gunf_game_t141_gfbo";
    game["dialog"]["defense_obj"] = "dx_mp_gunf_game_t141_gfbo";
  } else {
    game["dialog"]["offense_obj"] = "dx_mp_gunf_game_t141_gfbo";
    game["dialog"]["defense_obj"] = "dx_mp_gunf_game_t141_gfbo";
  }

  game["dialog"]["obj_indepth"] = "boost_arena_indepth";
  game["dialog"]["securing_a"] = "dx_mp_gunf_game_t141_gfsg";
  game["dialog"]["secured_a"] = "dx_mp_gunf_game_t141_gfsd";
  game["dialog"]["losing_a"] = "dx_mp_gunf_game_t141_gflg";
  game["dialog"]["lost_a"] = "dx_mp_gunf_game_t141_gflt";
  game["dialog"]["round_success"] = "dx_mp_gmst_anno_t141_gsrs";
  game["dialog"]["round_failure"] = "dx_mp_gmst_anno_t141_gsrf";
  game["dialog"]["mission_success"] = "dx_mp_gmst_anno_t141_gsms";
  game["dialog"]["mission_failure"] = "dx_mp_gmst_anno_t141_gsmf";
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

  level thread scripts\mp\gametypes\arena::function_ee47e658f5b6314e();

  if(!getdvarint(@ "hash_2167cbfc86b6839", 0)) {
    namespace_2c19af30dc7a566c::function_4a18dd73a966821e(2);
    return;
  }

  namespace_2c19af30dc7a566c::function_4a18dd73a966821e(6);
}

function function_955eeef49ba8fef9() {
  locs = getStructArray("weapon_pickup", "targetname");

  foreach(loc in locs) {
    if(is_equal(loc.script_label, "pball")) {
      level.var_ace80cd98b8b31cc = loc;
      break;
    }
  }
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_f3cb432a241a7ea3", getmatchrulesdata("arenaData", "arenaLoadouts"));
  setdynamicdvar(@ "hash_b2d6a287c0521607", getmatchrulesdata("arenaData", "loadoutChangeRound"));
  setdynamicdvar(@ "hash_9555be126d6bdcab", getmatchrulesdata("arenaData", "switchSpawns"));
  setdynamicdvar(@ "hash_a4a7060aad657090", getmatchrulesdata("arenaData", "winCondition"));
  setdynamicdvar(@ "hash_1b3b0369b76395a5", getmatchrulesdata("arenaData", "objModifier"));
  setdynamicdvar(@ "hash_c4dd1397da8407be", getmatchrulesdata("arenaData", "overtimeFlag"));
  setdynamicdvar(@ "hash_385f68623c04c6dc", getmatchrulesdata("arenaData", "flagCaptureTime"));
  setdynamicdvar(@ "hash_ca4cdfbc3778abed", getmatchrulesdata("arenaData", "flagHoldTimer"));
  setdynamicdvar(@ "hash_bc7f17452d7d2bc4", getmatchrulesdata("arenaData", "flagActivationDelay"));
  setdynamicdvar(@ "hash_f86716e8c7f46afd", getmatchrulesdata("arenaData", "tacticalTimeMod"));
  setdynamicdvar(@ "hash_44fc747f238c17da", getmatchrulesdata("arenaData", "blastShieldMod"));
  setdynamicdvar(@ "hash_4dcb3bff6478bb0d", getmatchrulesdata("arenaData", "blastShieldClamp"));
  setdynamicdvar(@ "hash_84ab96fa2f04c271", getmatchrulesdata("arenaData", "startWeapon"));
  setdynamicdvar(@ "hash_54f31afe6345346a", getmatchrulesdata("arenaData", "weaponTier1"));
  setdynamicdvar(@ "hash_54f319fe63453237", getmatchrulesdata("arenaData", "weaponTier2"));
  setdynamicdvar(@ "hash_54f318fe63453004", getmatchrulesdata("arenaData", "weaponTier3"));
  setdynamicdvar(@ "hash_54f317fe63452dd1", getmatchrulesdata("arenaData", "weaponTier4"));
  setdynamicdvar(@ "hash_54f316fe63452b9e", getmatchrulesdata("arenaData", "weaponTier5"));
  setdynamicdvar(@ "hash_54f315fe6345296b", getmatchrulesdata("arenaData", "weaponTier6"));
  setdynamicdvar(@ "hash_54f314fe63452738", getmatchrulesdata("arenaData", "weaponTier7"));
  setdynamicdvar(@ "hash_54f313fe63452505", getmatchrulesdata("arenaData", "weaponTier8"));
  setdynamicdvar(@ "hash_ce087f3b0e67c668", getmatchrulesdata("arenaData", "arenaAttachments"));
  setdynamicdvar(@ "hash_193cc5a02ee3d815", getmatchrulesdata("arenaData", "arenaSuper"));
  setdynamicdvar(@ "hash_c110a01fb151da3", 0);
  registerhalftimedvar(getgametype(), 0);
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

  if(game[game["attackers"]] == "SAS") {
    game["dialog"]["offense_obj"] = "iw9_gwtd_mode_uktl_gtbs";
  } else if(game[game["defenders"]] == "SAS") {
    game["dialog"]["defense_obj"] = "iw9_gwtd_mode_uktl_gtbs";
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

  initspawns();
  scripts\mp\gametypes\arena::function_10cea0880b71973a();
  scripts\mp\gametypes\arena::function_b7c18ded2347456c();
  scripts\mp\gametypes\arena::function_de46980d57f0c37a();

  if(game["roundsPlayed"] == 0) {
    level thread setroundwinstreakarray();
  }

  thread adjustroundendtimer();
  thread waittooverridegraceperiod();
  var_5abee6062a481f8c = 1;

  if(istrue(level.snowballfight)) {
    if(!level.alwayssnowfight && game["roundsPlayed"] == 0 && istrue(game["practiceRound"])) {
      level.extratime = 30;
      game["didSnowFight"] = 1;
      level.arenaloadouts = 3;
      var_5abee6062a481f8c = 0;
    } else if(level.alwayssnowfight) {
      level.arenaloadouts = 3;
      var_5abee6062a481f8c = 0;
    }

    level.snowfx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
    level.snowfx["screen"] = loadfx("vfx/iw8/weap/_impact/snowball/vfx_imp_snowball_scrn.vfx");
    snowballfight();
  }

  if(var_5abee6062a481f8c) {
    if(scripts\mp\gametypes\arena::israndomloadouts()) {
      thread updaterandomloadout();
    } else if(ispickuploadouts()) {
      if(!isDefined(game["roundsPlayed"]) || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        level.startweapon.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.startweapon.weapon);
        level.arenaweapont1.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont1.weapon);
        level.arenaweapont2.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont2.weapon);
        level.arenaweapont3.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont3.weapon);
        level.arenaweapont4.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont4.weapon);
        level.arenaweapont5.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont5.weapon);
        level.arenaweapont6.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont6.weapon);
        level.arenaweapont7.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont7.weapon);
        level.arenaweapont8.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont8.weapon);
        level.startweapon.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.startweapon.weapon);
        level.arenaweapont1.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont1.weapon);
        level.arenaweapont2.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont2.weapon);
        level.arenaweapont3.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont3.weapon);
        level.arenaweapont4.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont4.weapon);
        level.arenaweapont5.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont5.weapon);
        level.arenaweapont6.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont6.weapon);
        level.arenaweapont7.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont7.weapon);
        level.arenaweapont8.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont8.weapon);
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
        level.startweapon.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.startweapon.weapon);
        level.arenaweapont1.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont1.weapon);
        level.arenaweapont2.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont2.weapon);
        level.arenaweapont3.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont3.weapon);
        level.arenaweapont4.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont4.weapon);
        level.arenaweapont5.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont5.weapon);
        level.arenaweapont6.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont6.weapon);
        level.arenaweapont7.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont7.weapon);
        level.arenaweapont8.weapon = scripts\mp\gametypes\arena::getrandomweaponforweapontier(level.arenaweapont8.weapon);
        level.startweapon.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.startweapon.weapon);
        level.arenaweapont1.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont1.weapon);
        level.arenaweapont2.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont2.weapon);
        level.arenaweapont3.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont3.weapon);
        level.arenaweapont4.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont4.weapon);
        level.arenaweapont5.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont5.weapon);
        level.arenaweapont6.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont6.weapon);
        level.arenaweapont7.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont7.weapon);
        level.arenaweapont8.variantid = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(level.arenaweapont8.weapon);
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

  if(!isnormalloadouts()) {
    buildloadoutsforweaponstreaming();
  }

  setupwaypointicons();
  seticonnames();

  switch (level.objmodifier) {
    case 1:
      level setupendzones();
      break;
    case 2:
      level function_5bba7f02dbb91b52();
      break;
    default:
      break;
  }

  if(level.overtimeflag > 0 && !function_2eda32f1d16ded2c()) {
    level thread scripts\mp\gametypes\arena::spawngameendflagzone();
  }

  updatetournamentroundtime(scripts\mp\gamelogic::gettimeremaining(), 0);

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level thread outlineenemyplayers();
    level thread removeenemyoutlines();
  }
}

function waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.overrideingraceperiod = 1;
  level.ingraceperiod = 5;
}

function adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 4;
}

function updategametypedvars() {
  updatecommongametypedvars();

  if(level.dogtagsenabled) {
    level.dogtagallyonusecb = &dogtagallyonusecb;
    level.dogtagenemyonusecb = &dogtagenemyonusecb;
  }

  level.arenaloadouts = dvarintvalue("arenaLoadouts", 1, 1, 16);
  level.loadoutchangeround = dvarintvalue("loadoutChangeRound", 3, 0, 5);
  level.switchspawns = dvarintvalue("switchSpawns", 1, 0, 1);
  level.wincondition = dvarintvalue("winCondition", 1, 0, 2);
  level.var_56e1b10af8966681 = dvarintvalue("winStreakCamos", 0, 0, 1);
  setomnvar("ui_arena_loadout_type", level.arenaloadouts);
  setomnvar("ui_wincondition", level.wincondition);
  level.objmodifier = dvarintvalue("objModifier", 0, 0, 4);

  if(!function_2eda32f1d16ded2c()) {
    setomnvar("ui_single_flag_loc", -3);
  }

  level.overtimeflag = dvarfloatvalue("overtimeFlag", 10, 0, 30);

  if(level.overtimeflag > 0) {
    level.ontimelimitgraceperiod = level.overtimeflag;
    level.currenttimelimitdelay = 0;
    level.canprocessot = 1;
  }

  level.flagcapturetime = dvarfloatvalue("flagCaptureTime", 3, 0, 30);
  level.flagholdtimer = dvarfloatvalue("flagHoldTimer", 5, 0, 30);
  level.flagactivationdelay = dvarfloatvalue("flagActivationDelay", 15, 0, 30);
  level.tacticaltimemod = dvarfloatvalue("tacticalTimeMod", 2.5, 0.5, 5);
  level.startweapon = spawnStruct();
  level.arenaweapont1 = spawnStruct();
  level.arenaweapont2 = spawnStruct();
  level.arenaweapont3 = spawnStruct();
  level.arenaweapont4 = spawnStruct();
  level.arenaweapont5 = spawnStruct();
  level.arenaweapont6 = spawnStruct();
  level.arenaweapont7 = spawnStruct();
  level.arenaweapont8 = spawnStruct();
  level.startweapon.weapon = getDvar(@ "hash_84ab96fa2f04c271", "none");
  level.arenaweapont1.weapon = getDvar(@ "hash_54f31afe6345346a", "iw9_pi_golf17");
  level.arenaweapont2.weapon = getDvar(@ "hash_54f319fe63453237", "iw9_sh_mike1014");
  level.arenaweapont3.weapon = getDvar(@ "hash_54f318fe63453004", "iw9_sm_mpapa5");
  level.arenaweapont4.weapon = getDvar(@ "hash_54f317fe63452dd1", "iw9_ar_mike4");
  level.arenaweapont5.weapon = getDvar(@ "hash_54f316fe63452b9e", "iw9_sn_alpha50");
  level.arenaweapont6.weapon = getDvar(@ "hash_54f315fe6345296b", "equip_frag");
  level.arenaweapont7.weapon = getDvar(@ "hash_54f314fe63452738", "equip_concussion");
  level.arenaweapont8.weapon = getDvar(@ "hash_54f313fe63452505", "equip_adrenaline");
  level.arenapickupattachments = getdvarint(@ "hash_ce087f3b0e67c668", 0);

  if(level.arenaloadouts == 1) {
    setDvar(@ "hash_3c357661cd222b4d", 1);
    level.allowperks = 1;
  }

  level.arenasuper = getDvar(@ "hash_193cc5a02ee3d815", "none");

  if(level.arenasuper == "none") {
    setomnvar("ui_disable_fieldupgrades", 1);
  }

  level.var_320be3d1af4ef493 = getdvarint(@ "hash_3f64b5787462cd52", 1);
}

function initspawns() {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
  var_1cf8be03fb3c42de = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_allies_start");
  var_68c73806e24ff493 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_axis_start");
  arenaspawns = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn");

  if(var_1cf8be03fb3c42de.size > 0 || var_68c73806e24ff493.size > 0) {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_arena_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_arena_spawn_axis_start");
    level.alliesstartspawn = "mp_arena_spawn_allies_start";
    level.axisstartspawn = "mp_arena_spawn_axis_start";

    validatespawns("<dev string:x1c>");
    validatespawns("<dev string:x3b>");
  } else {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
    level.alliesstartspawn = "mp_sd_spawn_attacker";
    level.axisstartspawn = "mp_sd_spawn_defender";

    validatespawns("<dev string:x58>");
    validatespawns("<dev string:x70>");
  }

  if(arenaspawns.size > 0) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_arena_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_arena_spawn");
    level.spawntype = "mp_arena_spawn";
  } else {
    arenaspawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

    if(arenaspawns.size > 0) {
      scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
      scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
      level.spawntype = "mp_tdm_spawn";
    } else {
      level.alwaysusestartspawns = 1;
    }
  }

  primary = scripts\mp\spawnlogic::getspawnpointarray(level.spawntype);
  fallback = scripts\mp\spawnlogic::getspawnpointarray(level.spawntype);
  scripts\mp\spawnlogic::registerspawnset("normal", primary);
  scripts\mp\spawnlogic::registerspawnset("fallback", fallback);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function validatespawns(spawnpointname) {
  found_1 = 0;
  found_2 = 0;
  found_3 = 0;
  assign_noteworthy = 0;
  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(spawnpointname);

  foreach(s in spawnpoints) {
    if(isDefined(s.script_noteworthy)) {
      if(!found_1) {
        found_1 = s.script_noteworthy == "1";
      } else {
        assertex(s.script_noteworthy != "<dev string:x88>", "<dev string:x8d>");
      }

      if(!found_2) {
        found_2 = s.script_noteworthy == "2";
      } else {
        assertex(s.script_noteworthy != "<dev string:xce>", "<dev string:xd3>");
      }

      if(!found_3) {
        found_3 = s.script_noteworthy == "3";
        level.hasthreespawns = 1;
      } else {
        assertex(s.script_noteworthy != "<dev string:x114>", "<dev string:x119>");
      }

      continue;
    }

    if(assign_noteworthy == 0) {
      s.script_noteworthy = "1";
      assign_noteworthy++;
      continue;
    }

    if(assign_noteworthy == 1) {
      s.script_noteworthy = "2";
      assign_noteworthy++;
      continue;
    }

    if(assign_noteworthy == 2) {
      s.script_noteworthy = "3";
      assign_noteworthy++;
      level.hasthreespawns = 1;
    }
  }
}

function getspawnpoint() {
  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  spawnpoint = undefined;
  spawnpointname = level.axisstartspawn;
  var_aa57738edf8a8169 = 0;

  if(self.pers["team"] == game["attackers"]) {
    spawnpointname = level.alliesstartspawn;
  }

  if(getdvarint(@ "scr_arena_force_spawn_noteworthy", 0) > 0) {
    if(function_bff229a11ecd1e34()) {
      scripts\mp\spawnlogic::setactivespawnlogic(#"start");
    } else {
      scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
    }

    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(spawnpointname);
    spawnpoint = function_e77a290b26c3e849(spawnpoints, string(getdvarint(@ "scr_arena_force_spawn_noteworthy", 0)));

    thread function_403dca95ad44db03(spawnpoints);
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn() || istrue(level.alwaysusestartspawns) || isintournament()) {
    if(function_bff229a11ecd1e34()) {
      scripts\mp\spawnlogic::setactivespawnlogic(#"start");
    } else {
      scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
    }

    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(spawnpointname);
    assert(spawnpoints.size);

    if(istrue(level.switchspawns) && game["roundsPlayed"] > 0) {
      var_49ed3f681faf7163 = getteamcount(self.pers["team"]);

      if(var_49ed3f681faf7163 > 3) {
        foreach(player in getteamdata(self.pers["team"], "players")) {
          if(isDefined(player.pers["arena_spawn_pos"])) {
            player.pers["arena_spawn_pos"] = "0";
          }
        }

        var_aa57738edf8a8169 = 1;
      }
    }

    if(istrue(level.switchspawns) && game["roundsPlayed"] > 0 && !var_aa57738edf8a8169) {
      if(self.pers["arena_spawn_pos"] == "1") {
        self.pers["arena_spawn_pos"] = "2";
      } else if(getteamcount(self.pers["team"], 0) == 3 && istrue(level.hasthreespawns) && self.pers["arena_spawn_pos"] == "2") {
        self.pers["arena_spawn_pos"] = "3";
      } else if(self.pers["arena_spawn_pos"] == "3") {
        self.pers["arena_spawn_pos"] = "1";
      } else {
        self.pers["arena_spawn_pos"] = "1";
      }

      spawnpoint = getswitchside_spawnpoint(spawnpoints, self.pers["arena_spawn_pos"]);
    }

    if(!isDefined(spawnpoint)) {
      if(istrue(self.switching_teams_arena) && isDefined(self.pers["arena_spawn_pos"])) {
        cleanupspawn_scriptnoteworthy();
        spawnpoint = getspawnpoint_startspawn(spawnpoints);
        self.switching_teams_arena = undefined;

        if(isDefined(spawnpoint)) {
          self.spawnpointangles = spawnpoint.angles;
        }
      } else {
        spawnpoint = getspawnpoint_startspawn(spawnpoints);

        if(isDefined(spawnpoint)) {
          self.spawnpointangles = spawnpoint.angles;
        }
      }

      if(!isDefined(spawnpoint)) {
        var_49ed3f681faf7163 = getteamcount(self.pers["team"]);

        if(var_49ed3f681faf7163 > 3) {
          buddyspawnplayer = undefined;
          var_836289e1016f3c1b = 0;

          foreach(player in getteamdata(self.pers["team"], "players")) {
            if(istrue(player.buddyspawnplayer)) {
              var_836289e1016f3c1b++;
              continue;
            }

            break;
          }

          foreach(player in getteamdata(self.pers["team"], "players")) {
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
              }

              if(player.pers["arena_spawn_pos"] == "2" && level.usedspawnpostwo[self.pers["team"]] == 0) {
                level.usedspawnpostwo[self.pers["team"]]++;
                player.buddyspawnplayer = 1;
                buddyspawnplayer = player;
                break;
              }

              if(player.pers["arena_spawn_pos"] == "3" && level.usedspawnposthree[self.pers["team"]] == 0) {
                level.usedspawnposthree[self.pers["team"]]++;
                player.buddyspawnplayer = 1;
                buddyspawnplayer = player;
                break;
              }

              level.usedspawnposone[self.pers["team"]]++;
              player.buddyspawnplayer = 1;
              buddyspawnplayer = player;
              break;
            }
          }

          if(isDefined(buddyspawnplayer)) {
            spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(buddyspawnplayer);

            if(isDefined(spawnpoint) && isDefined(buddyspawnplayer.spawnpointangles)) {
              spawnpoint.angles = buddyspawnplayer.spawnpointangles;
            }
          }
        }
      }

      if(!isDefined(spawnpoint)) {
        scripts\mp\spawnlogic::activatespawnset("normal");
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], "normal", "fallback");
      }

      if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "" && istrue(level.switchspawns) && game["roundsPlayed"] == 0) {
        assertex(spawnpoint.script_noteworthy == "<dev string:x88>" || spawnpoint.script_noteworthy == "<dev string:xce>" || spawnpoint.script_noteworthy == "<dev string:x114>" || spawnpoint.script_noteworthy == "<dev string:x15a>");
        self.pers["arena_spawn_pos"] = spawnpoint.script_noteworthy;
      }
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], "normal", "fallback");
  }

  return spawnpoint;
}

function cleanupspawn_scriptnoteworthy() {
  otherteam = getotherteam(self.pers["team"])[0];

  if(otherteam == game["attackers"]) {
    spawnpointname = level.alliesstartspawn;
    var_55af954984fc6a2a = level.axisstartspawn;
  } else {
    spawnpointname = level.axisstartspawn;
    var_55af954984fc6a2a = level.alliesstartspawn;
  }

  var_cb5363ab35b26aea = scripts\mp\spawnlogic::getspawnpointarray(spawnpointname);
  assert(var_cb5363ab35b26aea.size);

  foreach(s in var_cb5363ab35b26aea) {
    if(s.script_noteworthy == self.pers["arena_spawn_pos"]) {
      s.selected = 0;
    }
  }

  var_cb5363ab35b26aea = scripts\mp\spawnlogic::getspawnpointarray(var_55af954984fc6a2a);
  assert(var_cb5363ab35b26aea.size);

  foreach(s in var_cb5363ab35b26aea) {
    foreach(player in getteamdata(self.pers["team"], "players")) {
      if(player != self && isDefined(player.pers["arena_spawn_pos"]) && s.script_noteworthy != player.pers["arena_spawn_pos"]) {
        s.selected = 0;
      }
    }
  }
}

function getspawnpoint_startspawn(spawnpoints, onlyunselected) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }

  bestspawn = undefined;
  spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns(spawnpoints);

  foreach(spawnpoint in spawnpoints) {
    if(!isDefined(spawnpoint.selected)) {
      continue;
    }

    if(spawnpoint.selected) {
      continue;
    }

    if(spawnpoint.script_noteworthy == "1") {
      bestspawn = spawnpoint;
      break;
    } else if(spawnpoint.script_noteworthy == "2") {
      bestspawn = spawnpoint;
      break;
    }

    bestspawn = spawnpoint;
  }

  if(isDefined(bestspawn)) {
    bestspawn.selected = 1;
  }

  return bestspawn;
}

function getswitchside_spawnpoint(spawnpoints, spawnnoteworthy) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }

  var_cee9d4c5101c6ead = 0;

  foreach(spawnpoint in spawnpoints) {
    if(spawnpoint.script_noteworthy == spawnnoteworthy) {
      if(istrue(spawnpoint.selected)) {
        var_cee9d4c5101c6ead = 1;
        continue;
      }

      spawnpoint.selected = 1;
      return spawnpoint;
    }
  }

  assertex(var_cee9d4c5101c6ead == 1, "<dev string:x15f>");
  return undefined;
}

function function_e77a290b26c3e849(spawnpoints, spawnnoteworthy) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }

  var_cee9d4c5101c6ead = 0;

  foreach(spawnpoint in spawnpoints) {
    if(spawnpoint.script_noteworthy == spawnnoteworthy) {
      return spawnpoint;
    }
  }
}

function function_403dca95ad44db03(spawnpoints) {
  color = (0, 0, 0);

  foreach(s in spawnpoints) {
    if(isDefined(s.script_noteworthy)) {
      if(s.script_noteworthy == "1") {
        color = (1, 0, 0);
      } else if(s.script_noteworthy == "2") {
        color = (0, 1, 0);
      } else if(s.script_noteworthy == "3") {
        color = (0, 0, 1);
      } else {
        color = (1, 1, 1);
      }

      thread scripts\cp_mp\utility\debug_utility::drawsphere(s.origin, 32, 20, color);
    }
  }
}

function onplayerconnect(player) {
  if(istrue(level.allowkillstreaks)) {
    level.allowkillstreaks = 0;
  }

  player.arenadamage = 0;
  player setextrascore0(0);

  if(isDefined(player.pers["damage"])) {
    player setextrascore0(player.pers["damage"]);
  }

  if(!isnormalloadouts()) {
    level.denyclasschoice = 1;
    player scripts\mp\class::function_a16868d4dcd81a4b();

    if(scripts\mp\gametypes\arena::israndomloadouts()) {
      player.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
    } else if(ispickuploadouts()) {
      player.pers["gamemodeLoadout"] = level.var_b128efae25ac7cc6;
    } else if(isgungameloadouts() || isrvsgungameloadouts()) {
      player.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][getgungameloadoutindex(player)];

      if(game["roundsPlayed"] == 0) {
        player setenemyloadoutomnvars();
      }
    }
  }

  if(istrue(level.switchspawns) && !isDefined(player.pers["arena_spawn_pos"])) {
    player.pers["arena_spawn_pos"] = "0";
  }

  player thread scripts\mp\gametypes\arena::onjoinedteam();

  if(!isnormalloadouts()) {
    player updatehighpriorityweapons();
  }

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
}

function onplayerdisconnect(player) {
  setteamhealthhud(1);
}

function onjoinedteam() {
  level endon("game_ended");

  for(;;) {
    waittill_any_2("joined_team", "joined_spectators");
    setteamhealthhud();
  }
}

function onspawnplayer(revivespawn) {
  thread onspawnfinished();
  level notify("spawned_player");
  thread updatematchstatushintonspawn();

  if(istrue(level.alwayssnowfight)) {
    perk::giveperk("specialty_fastoffhand");
    perk::giveperk("specialty_pitcher");
  }

  scripts\cp_mp\squads::updatesquadomnvars(self.team, self.sessionsquadid);
}

function onspawnfinished() {
  self endon("death_or_disconnect");

  if(istrue(game["practiceRound"]) || istrue(level.alwayssnowfight)) {
    thread snowballmeleewatcher();
  }

  thread damagewatcher();

  if(!isnormalloadouts()) {
    self waittill("giveLoadout");
    scripts\mp\gametypes\arena::runarenaloadoutrulesonplayer(self);
  }

  thread modifyblastshieldperk();

  if(level.arenaknivesout) {
    giveperk("specialty_quickswap");
  }

  wait 0.1;
  self.hasarenaspawned = 1;
  wait 0.15;

  if(!scripts\mp\flags::gameflag("prematch_done") && game["roundsPlayed"] == 0) {
    if(level.overtimeflag > 0 && isDefined(level.matchcountdowntime) && level.matchcountdowntime > 5) {
      if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
        scripts\mp\utility\dialog::leaderdialogonplayer("obj_indepth", "introboost");
      }
    }

    level waittill_any_2("prematch_done", "removeArenaOutlines");
  }

  self setclientomnvar("ui_player_notify_loadout", gettime());
  function_8cbda65b25d7573c();
}

function setteamhealthhud(isdisconnect) {
  var_586dc9dc0cf668ad = getdvarint(@ "scr_player_maxhealth", 100);
  alliesplayers = getteamdata("allies", "teamCount");

  if(alliesplayers) {
    level.alliesmaxhealth = getteamdata("allies", "teamCount") * var_586dc9dc0cf668ad;
    setomnvar("ui_arena_allies_health_max", level.alliesmaxhealth);

    if(!istrue(isdisconnect) && !isreallyalive(self) && scripts\mp\playerlogic::mayspawn()) {
      self waittill("spawned_player");
    }

    allieshealth = 0;

    foreach(player in getteamdata("allies", "players")) {
      allieshealth += player.health;
    }

    level.allieshealth = allieshealth;

    if(level.allieshealth < 0) {
      level.allieshealth = 0;
    }

    setomnvar("ui_arena_allies_health", level.allieshealth);
  } else {
    setomnvar("ui_arena_allies_health", 0);
  }

  axisplayers = getteamdata("axis", "teamCount");

  if(axisplayers) {
    level.axismaxhealth = getteamdata("axis", "teamCount") * var_586dc9dc0cf668ad;
    setomnvar("ui_arena_axis_health_max", level.axismaxhealth);

    if(!istrue(isdisconnect) && !isreallyalive(self) && scripts\mp\playerlogic::mayspawn()) {
      self waittill("spawned_player");
    }

    axishealth = 0;

    foreach(player in getteamdata("axis", "players")) {
      axishealth += player.health;
    }

    level.axishealth = axishealth;

    if(level.axishealth < 0) {
      level.axishealth = 0;
    }

    setomnvar("ui_arena_axis_health", level.axishealth);
    return;
  }

  setomnvar("ui_arena_axis_health", 0);
}

function modifyblastshieldperk() {
  if(scripts\mp\utility\perk::_hasperk("specialty_blastshield")) {
    blastshieldmod = dvarintvalue("blastShieldMod", 0.65, 0, 1);

    if(blastshieldmod == 0) {
      removeperk("specialty_blastshield");
    }
  }
}

function onplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_fcdf19e3cdd29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage) {
  if(isDefined(eattacker) && eattacker != victim && isPlayer(eattacker)) {
    if(istrue(level.snowballfight) && (objweapon.basename == "snowball_mp" || objweapon.basename == "pball_mp")) {
      playfxontagforclients(level.snowfx["screen"], victim, "tag_eye", victim);
    }

    if(idamage >= var_fcdf19e3cdd29669) {
      idamage = var_fcdf19e3cdd29669;
    }

    eattacker.arenadamage += idamage;
    eattacker scripts\mp\persistence::statsetchild("round", "damage", eattacker.pers["damage"]);
    eattacker setextrascore0(eattacker.pers["damage"]);
  }
}

function damagewatcher() {
  self notify("startDamageWatcher");
  self endon("startDamageWatcher");
  level endon("game_ended");
  self endon("disconnect");
  self.totaldamagetaken = 0;

  while(true) {
    waittill_any_7("damage", "force_regeneration", "removeAdrenaline", "healed", "naturalHealthRegen", "vampirism", "spawned_player");

    if(self.team == "allies") {
      allieshealth = 0;

      foreach(player in getteamdata("allies", "players")) {
        allieshealth += player.health;
      }

      level.allieshealth = allieshealth;

      if(level.allieshealth < 0) {
        level.allieshealth = 0;
      }

      setomnvar("ui_arena_allies_health", level.allieshealth);
    } else {
      axishealth = 0;

      foreach(player in getteamdata("axis", "players")) {
        axishealth += player.health;
      }

      level.axishealth = axishealth;

      if(level.axishealth < 0) {
        level.axishealth = 0;
      }

      setomnvar("ui_arena_axis_health", level.axishealth);
    }

    if(istrue(self.iscapturing)) {
      objflag = undefined;

      if(function_444e57e02c02bee6()) {
        if(self.team == game["defenders"]) {
          level.attackerendzone.curprogress = 50;
          level.attackerendzone.teamprogress[self.team] = 50;
          objflag = level.attackerendzone;
        } else if(self.team == game["attackers"]) {
          level.defenderendzone.curprogress = 50;
          level.defenderendzone.teamprogress[self.team] = 50;
          objflag = level.defenderendzone;
        }

        scripts\mp\objidpoolmanager::objective_set_progress(objflag.objidnum, objflag.curprogress / objflag.usetime);
      }
    }
  }
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  if(!isnormalloadouts()) {
    if(isbot(victim)) {
      victim.classcallback = "gamemode";
    }
  }

  if(game["state"] == "postgame") {
    attacker.finalkill = 1;
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  scripts\cp_mp\squads::updatesquadomnvars(self.team, self.sessionsquadid);

  if(!isnormalloadouts()) {
    if(isbot(self)) {
      self.classcallback = "gamemode";
    }
  }

  if(isDefined(attacker) && (objweapon.basename == "snowball_mp" || objweapon.basename == "pball_mp")) {
    attacker thread scripts\mp\utility\points::function_e3e3e81453fd788b(#"snowball_kill");
  }

  thread checkallowspectating();
}

function checkallowspectating() {
  waitframe();
  update = 0;

  if(!getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    update = 1;
  }

  if(!getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    update = 1;
  }

  if(update) {
    scripts\mp\spectating::updatespectatesettings();
  }
}

function ontimelimit() {
  if(level.gameended) {
    return;
  }

  updatetournamentroundtime(scripts\mp\gamelogic::gettimeremaining(), 3);

  if(function_2eda32f1d16ded2c()) {
    if(level.var_59a1f917fb3131a6 != "neutral") {
      level thread scripts\mp\gamelogic::endgame(level.var_59a1f917fb3131a6, game["end_reason"]["ko_flag_win"], game["end_reason"]["ko_flag_loss"]);
    } else if(level.wincondition == 1) {
      checkliveswinner();
    } else if(level.wincondition == 2) {
      checkhealthwinner();
    } else {
      checkhealthwinner();
    }

    return;
  }

  if(level.wincondition == 1) {
    checkliveswinner();
    return;
  }

  if(level.wincondition == 2) {
    checkhealthwinner();
    return;
  }

  checkhealthwinner();
}

function ontimelimitot() {
  if(function_2eda32f1d16ded2c()) {
    if(level.var_59a1f917fb3131a6 != "neutral") {
      level thread scripts\mp\gamelogic::endgame(level.var_59a1f917fb3131a6, game["end_reason"]["ko_flag_win"], game["end_reason"]["ko_flag_loss"]);
    }
  }

  updatetournamentroundtime(scripts\mp\gamelogic::gettimeremaining(), 1);
  level thread startotmechanics();
}

function checkliveswinner() {
  if(getteamdata("allies", "aliveCount") > getteamdata("axis", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("allies", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
    return;
  }

  if(getteamdata("axis", "aliveCount") > getteamdata("allies", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("axis", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
    return;
  }

  checkhealthwinner();
}

function checkhealthwinner() {
  if(level.axishealth < level.allieshealth) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("allies", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
    return;
  }

  if(level.allieshealth < level.axishealth) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame("axis", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
    return;
  }

  if(matchmakinggame()) {
    if(isintournament()) {
      game["canScoreOnTie"] = 1;

      if(game["finalRound"] == 1) {
        game["canScoreOnTie"] = 0;

        if(!isDefined(game["roundsTied"])) {
          game["roundsTied"] = 1;
        } else {
          game["roundsTied"]++;
        }

        if(game["roundsTied"] >= 2) {
          betterteam = scripts\mp\gamelogic::getbetterteam();
          thread scripts\mp\gamelogic::endgame(betterteam, game["end_reason"]["arena_tournament_tie_win"], game["end_reason"]["arena_tournament_tie_loss"]);
        } else {
          thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
        }
      } else {
        thread arena_endgame("tie", game["end_reason"]["cyber_tie"]);
      }
    } else {
      if(!isDefined(game["roundsTied"])) {
        game["roundsTied"] = 1;
      } else {
        game["roundsTied"]++;
      }

      game["canScoreOnTie"] = game["roundsTied"] >= 2;

      if(game["canScoreOnTie"]) {
        thread arena_endgame("tie", game["end_reason"]["cyber_tie"]);
      } else {
        thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
      }
    }

    return;
  }

  thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
}

function ondeadevent(team) {
  if(istrue(level.ingraceperiod)) {
    return;
  }

  if(team == game["attackers"]) {
    level thread arena_endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
    return;
  }

  if(team == game["defenders"]) {
    level thread arena_endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
    return;
  }

  if(team == "all") {
    thread arena_endgame("tie", game["end_reason"]["all_eliminated"]);
  }
}

function ontimelimitdeadevent(team) {}

function checkshouldallowtradekilltie(winningteam) {
  livescount = [];

  foreach(entry in level.teamnamelist) {
    livescount[entry] = 0;
  }

  foreach(player in level.players) {
    if(!istrue(player.hasspawned) || player.team == "spectator" || player.team == "codcaster") {
      continue;
    }

    livescount[player.team] += player.pers["lives"];
  }

  var_4351d3695cbe4fd7 = 0;

  foreach(entry in level.teamnamelist) {
    if(getteamdata(entry, "aliveCount")) {
      var_4351d3695cbe4fd7 = 1;
      break;
    }
  }

  haslivescount = 0;

  foreach(count in livescount) {
    if(count) {
      haslivescount = 1;
      break;
    }
  }

  if(!var_4351d3695cbe4fd7 && !haslivescount) {
    return "tie";
  }

  foreach(entry in level.teamnamelist) {
    println("<dev string:x1c2>" + entry + "<dev string:x1cb>" + getteamdata(entry, "<dev string:x1dd>"));

    if(!getteamdata(entry, "aliveCount") && !livescount[entry]) {
      println("<dev string:x1eb>" + entry);

      if(level.multiteambased) {
        if(!getteamdata(entry, "deathEvent") && getteamdata(entry, "hasSpawned")) {
          setteamdata(entry, "deathEvent", 1);
          return winningteam;
        }

        continue;
      }

      return winningteam;
    }
  }

  foreach(entry in level.teamnamelist) {
    oneleft = getteamdata(entry, "aliveCount") == 1;

    if(oneleft) {
      teammatelives = 0;
      return_val = undefined;
      players = getteamdata(entry, "players");

      foreach(player in players) {
        if(!isalive(player)) {
          teammatelives += player.pers["lives"];
        }
      }

      if(teammatelives == 0) {
        if(!getteamdata(entry, "oneLeft") && gettime() > getteamdata(entry, "oneLeftTime") + 5000) {
          setteamdata(entry, "oneLeftTime", gettime());
          setteamdata(entry, "oneLeft", 1);

          if(players.size > 1) {
            return winningteam;
          }
        }
      }

      continue;
    }

    setteamdata(entry, "oneLeft", 0);
  }

  return winningteam;
}

function arena_endgame(winningteam, endreasontext, endreasontextloss, nukedetonated, var_8e4a26ed257a393b) {
  if(winningteam != "tie") {
    if(istrue(level.nukeinfo.incoming)) {
      return;
    }

    waittillframeend();
    winningteam = checkshouldallowtradekilltie(winningteam);
  }

  if(isgungameloadouts() || isrvsgungameloadouts()) {
    level setenemyloadoutomnvarsatmatchend(winningteam);
  }

  if(winningteam != "tie") {
    game["roundsTied"] = 0;
    game["previousWinningTeam"] = winningteam;

    foreach(entry in level.teamnamelist) {
      if(entry == winningteam) {
        game["roundWinStreak"][winningteam]++;
        continue;
      }

      game["roundWinStreak"][entry] = 0;
    }

    if(!iswinbytworulegametype()) {
      switch (game["roundWinStreak"][winningteam]) {
        case 2:
          game["dialog"]["round_success"] = "dx_mp_gmst_anno_t141_gsrs";
          break;
        case 3:
          game["dialog"]["round_success"] = "dx_mp_gmst_anno_t141_gsrs";
          break;
        case 4:
          game["dialog"]["round_success"] = "dx_mp_gmst_anno_t141_gsrs";
          break;
        case 5:
          roundswon = getroundswon(winningteam);
          winlimit = getwatcheddvar("winlimit");

          if(winlimit == 6 && roundswon != winlimit - 1) {
            game["dialog"]["round_success"] = "dx_mp_gmst_anno_t141_gsrs";
          }

          break;
        default:
          break;
      }
    }

    if(game["finalRound"] == 1) {
      if(game["roundWinStreak"][winningteam] > 3) {
        game["dialog"]["mission_success"] = "gamestate_win_comeback";
      }
    }
  } else {
    game["previousWinningTeam"] = "";
  }

  scripts\cp_mp\pet_watch::update2v2progress();
  thread scripts\mp\gamelogic::endgame(winningteam, endreasontext, endreasontextloss, nukedetonated, var_8e4a26ed257a393b);
}

function setroundwinstreakarray() {
  foreach(entry in level.teamnamelist) {
    game["roundWinStreak"][entry] = 0;
  }
}

function runarenaloadoutrulesonplayer(player) {
  swaploadout = 0;

  if(ispickuploadouts()) {
    if(game["roundsPlayed"] == 0) {
      wait 0.1;
    } else {
      wait 0.25;
    }
  } else if(israndomarloadouts() || israndomsmgloadouts() || israndompistolloadouts() || israndomshotgunloadouts() || israndomsniperloadouts() || israndomlmgloadouts()) {
    if(getdvarint(@ "hash_cc279143b9185777", 0) == 0) {
      player.pers["gamemodeLoadout"]["loadoutSecondary"] = "none";
      swaploadout = 1;
    }
  }

  if(istrue(level.var_56e1b10af8966681)) {
    player.pers["gamemodeLoadout"]["loadoutPrimaryCamo"] = scripts\mp\gametypes\arena::function_3dd5b16653c57b45(player.pers["team"]);
    player.pers["gamemodeLoadout"]["loadoutSecondaryCamo"] = scripts\mp\gametypes\arena::function_3dd5b16653c57b45(player.pers["team"]);
    swaploadout = 1;
  }

  if(istrue(swaploadout)) {
    player scripts\mp\class::swaploadout();
  }
}

function buildloadoutsforweaponstreaming() {
  level.loadweapons = [];

  if(ispickuploadouts()) {
    if(level.startweapon.weapon == "none" || issubstr(level.startweapon.weapon, "equip")) {
      newweapon = "iw9_me_fists_mp";
      newweaponobj = makeweapon(newweapon);
      newweapon = getcompleteweaponname(newweaponobj);
    } else {
      rootname = getweaponrootname(level.startweapon.weapon);
      attachments = [];
      camoname = "none";
      reticleindex = "none";
      variantid = undefined;
      attachmentids = undefined;
      cosmeticattachment = undefined;
      stickers = undefined;

      if(ispickupblueprintloadouts()) {
        newweaponobj = scripts\cp_mp\weapon::buildweapon_blueprint(rootname, camoname, reticleindex, level.startweapon.variantid, attachmentids, cosmeticattachment, stickers);
      } else {
        newweaponobj = scripts\cp_mp\weapon::buildweapon(rootname, attachments, camoname, reticleindex, variantid, attachmentids, cosmeticattachment, stickers);
      }

      newweapon = getcompleteweaponname(newweaponobj);
    }

    level.loadweapons[level.loadweapons.size] = newweaponobj;
    return;
  }

  primaries = [];
  secondaries = [];
  loadout = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
  primary = loadout["loadoutPrimary"];
  secondary = loadout["loadoutSecondary"];

  if(primary != "none") {
    primaries[primaries.size] = function_ceaf8a81ff311f20(primary, loadout);
  }

  if(secondary != "none") {
    secondaries[secondaries.size] = function_ceaf8a81ff311f20(secondary, loadout);
  }

  if(level.loadoutchangeround != 0) {
    nextloadoutindex = game["arenaRandomLoadoutIndex"] + 1;

    if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size - 1) {
      nextloadoutindex = 0;
    }

    nextloadout = game["arenaRandomLoadout"][nextloadoutindex];
    nextprimary = nextloadout["loadoutPrimary"];
    nextsecondary = nextloadout["loadoutSecondary"];

    if(nextprimary != "none") {
      primaries[primaries.size] = function_ceaf8a81ff311f20(nextprimary, nextloadout);
    }

    if(nextsecondary != "none") {
      secondaries[secondaries.size] = function_ceaf8a81ff311f20(nextsecondary, nextloadout);
    }
  }

  level.loadweapons = array_combine(primaries, secondaries);
}

function private function_ceaf8a81ff311f20(weaponname, loadout) {
  slotstring = undefined;

  if(weaponname == loadout["loadoutPrimary"]) {
    slotstring = "loadoutPrimary";
  } else if(weaponname == loadout["loadoutSecondary"]) {
    slotstring = "loadoutSecondary";
  }

  assertex(isDefined(slotstring), "<dev string:x238>" + weaponname + "<dev string:x252>");
  rootname = getweaponrootname(loadout[slotstring]);
  variantid = loadout[slotstring + "VariantID"];

  if(function_c0c1519b5cfb9bd5()) {
    weaponobject = scripts\cp_mp\weapon::buildweapon_blueprint(rootname, undefined, undefined, variantid);
    return getcompleteweaponname(weaponobject);
  }

  attachments = [];

  for(i = 1; i <= 5; i++) {
    concat = i;

    if(i == 1) {
      concat = "";
    }

    attachment = loadout[slotstring + "Attachment" + concat];

    if(attachment != "none") {
      attachments[attachments.size] = attachment;
    }
  }

  camoname = loadout[slotstring + "Camo"];
  reticleindex = loadout[slotstring + "Reticle"];
  weaponobject = scripts\cp_mp\weapon::buildweapon(rootname, attachments, camoname, reticleindex, variantid);
  return getcompleteweaponname(weaponobject);
}

function setupblueprintpickupweapons() {
  level.arenaweapont1 = buildblueprintpickupweapon(level.arenaweapont1);
  level.arenaweapont2 = buildblueprintpickupweapon(level.arenaweapont2);
  level.arenaweapont3 = buildblueprintpickupweapon(level.arenaweapont3);
  level.arenaweapont4 = buildblueprintpickupweapon(level.arenaweapont4);
  level.arenaweapont5 = buildblueprintpickupweapon(level.arenaweapont5);
  level.arenaweapont6 = buildblueprintpickupweapon(level.arenaweapont6);
  level.arenaweapont7 = buildblueprintpickupweapon(level.arenaweapont7);
  level.arenaweapont8 = buildblueprintpickupweapon(level.arenaweapont8);
}

function buildblueprintpickupweapon(var_d44eb44714e9fb44) {
  var_d44eb44714e9fb44.weapon = var_d44eb44714e9fb44.weapon;

  if(!issubstr(var_d44eb44714e9fb44.weapon, "equip") && var_d44eb44714e9fb44.weapon != "none") {
    attachments = [];
    camoname = "none";
    reticleindex = "none";
    variantid = var_d44eb44714e9fb44.variantid;
    attachmentids = undefined;
    cosmeticattachment = undefined;
    stickers = [];
    stickers[0] = "none";
    stickers[1] = "none";
    stickers[2] = "none";
    stickers[3] = "none";
    stickers[4] = "none";
    rootname = getweaponrootname(var_d44eb44714e9fb44.weapon);
    var_d44eb44714e9fb44.weaponobj = scripts\cp_mp\weapon::buildweapon_blueprint(rootname, undefined, undefined, variantid, undefined, undefined, scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4());
  }

  return var_d44eb44714e9fb44;
}

function setupstartweaponsattachments() {
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

function setupweaponattachmentoverrides(var_d44eb44714e9fb44) {
  var_d44eb44714e9fb44.weapon = var_d44eb44714e9fb44.weapon;

  if(!issubstr(var_d44eb44714e9fb44.weapon, "equip") && var_d44eb44714e9fb44.weapon != "none") {
    attachments = [];
    camoname = "none";
    reticleindex = "none";
    variantid = undefined;
    rootname = getweaponrootname(var_d44eb44714e9fb44.weapon);
    attachments = getarenapickupattachmentoverrides(rootname + "_mp");
    var_d44eb44714e9fb44.weaponobj = scripts\cp_mp\weapon::buildweapon(rootname, attachments, camoname, reticleindex, variantid);
  }

  return var_d44eb44714e9fb44;
}

function getattachmentoverride(weapon) {
  rootname = getweaponrootname(weapon);
  attachments = getarenapickupattachmentoverrides(rootname + "_mp");
  return attachments[0];
}

function defineplayerloadout() {
  attachments = [];
  attachments[0] = "none";
  attachments[1] = "none";
  attachments[2] = "none";
  attachments[3] = "none";
  attachments[4] = "none";
  camoname = "none";
  reticleindex = "none";
  variantid = 0;
  attachmentids = undefined;
  cosmeticattachment = undefined;
  stickers = [];
  stickers[0] = "none";
  stickers[1] = "none";
  stickers[2] = "none";
  stickers[3] = "none";
  stickers[4] = "none";
  perks = ["specialty_blastshield"];
  primaryequipment = "none";
  secondaryequipment = "none";

  if(isDefined(level.startweapon.weapon) && level.startweapon.weapon != "none" && !issubstr(level.startweapon.weapon, "equip")) {
    primary = getweaponrootname(level.startweapon.weapon);

    if(ispickupblueprintloadouts()) {
      variantid = level.startweapon.variantid;
    }

    if(level.arenapickupattachments > 0) {
      attachments[0] = getattachmentoverride(level.startweapon.weapon);
    }
  } else {
    primary = "none";

    if(issubstr(level.startweapon.weapon, "equip")) {
      if(isthrowingknifeequipment(level.startweapon.weapon)) {
        perks[perks.size] = "specialty_extra_deadly";

        if(level.arenaknivesout) {
          perks[perks.size] = "specialty_restock";

          if(level.arenaknivesout == 2) {
            primary = "iw9_knife";
          }
        }
      }

      slot = scripts\mp\equipment::getdefaultslot(level.startweapon.weapon);

      if(slot == "primary") {
        primaryequipment = level.startweapon.weapon;
      } else {
        secondaryequipment = level.startweapon.weapon;
      }
    }
  }

  if(level.allowsupers) {
    mapname = scripts\cp_mp\utility\game_utility::getmapname();

    if(issubstr(mapname, "mp_m_") && mapname != "mp_m_speed") {
      level.arenasuper = fixupsupersandtacticalsforgunfightmaps();
    }
  } else {
    level.arenasuper = "none";
    setomnvar("ui_disable_fieldupgrades", 1);
  }

  level.var_b128efae25ac7cc6["loadoutArchetype"] = "archetype_assault";
  level.var_b128efae25ac7cc6["loadoutPrimary"] = primary;
  level.var_b128efae25ac7cc6["loadoutPrimaryAttachment"] = attachments[0];
  level.var_b128efae25ac7cc6["loadoutPrimaryAttachment2"] = attachments[1];
  level.var_b128efae25ac7cc6["loadoutPrimaryAttachment3"] = attachments[2];
  level.var_b128efae25ac7cc6["loadoutPrimaryAttachment4"] = attachments[3];
  level.var_b128efae25ac7cc6["loadoutPrimaryAttachment5"] = attachments[4];
  level.var_b128efae25ac7cc6["loadoutPrimaryCamo"] = camoname;
  level.var_b128efae25ac7cc6["loadoutPrimaryCosmeticAttachment"] = cosmeticattachment;
  level.var_b128efae25ac7cc6["loadoutPrimaryReticle"] = reticleindex;
  level.var_b128efae25ac7cc6["loadoutPrimarySticker2"] = stickers[2];
  level.var_b128efae25ac7cc6["loadoutPrimarySticker"] = stickers[0];
  level.var_b128efae25ac7cc6["loadoutPrimarySticker1"] = stickers[1];
  level.var_b128efae25ac7cc6["loadoutPrimarySticker3"] = stickers[3];
  level.var_b128efae25ac7cc6["loadoutPrimarySticker4"] = stickers[4];
  level.var_b128efae25ac7cc6["loadoutPrimaryVariantID"] = variantid;
  level.var_b128efae25ac7cc6["loadoutSecondary"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondaryAttachment"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondaryAttachment2"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondaryAttachment3"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondaryAttachment4"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondaryAttachment5"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondaryCamo"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondaryReticle"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondarySticker"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondarySticker1"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondarySticker2"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondarySticker3"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondarySticker4"] = "none";
  level.var_b128efae25ac7cc6["loadoutSecondaryVariantID"] = -1;
  level.var_b128efae25ac7cc6["loadoutMeleeSlot"] = "none";
  level.var_b128efae25ac7cc6["loadoutEquipmentPrimary"] = primaryequipment;
  level.var_b128efae25ac7cc6["loadoutEquipmentSecondary"] = secondaryequipment;
  level.var_b128efae25ac7cc6["loadoutStreakType"] = "assault";
  level.var_b128efae25ac7cc6["loadoutKillstreak1"] = "none";
  level.var_b128efae25ac7cc6["loadoutKillstreak2"] = "none";
  level.var_b128efae25ac7cc6["loadoutKillstreak3"] = "none";
  level.var_b128efae25ac7cc6["loadoutSuper"] = "none";
  level.var_b128efae25ac7cc6["loadoutFieldUpgrade1"] = level.arenasuper;
  level.var_b128efae25ac7cc6["loadoutFieldUpgrade2"] = "none";
  level.var_b128efae25ac7cc6["loadoutPerks"] = perks;
  level.var_b128efae25ac7cc6["loadoutGesture"] = "playerData";
  level.var_b128efae25ac7cc6["loadoutExecution"] = "playerData";
}

function function_3dd5b16653c57b45(teamname) {
  camoname = "none";

  if(!isDefined(teamname) || teamname != "allies" && teamname != "axis") {
    return camoname;
  }

  camos = ["camo_a_01", "camo_b_01", "camo_c_01", "camo_d_01", "camo_e_01", "camo_f_01", "camo_g_01", "camo_h_01", "camo_i_01", "camo_j_01", "camo_k_01", "camo_l_01", "camo_m_01", "camo_n_01", "camo_o_01", "camo_p_01", "camo_r_01", "camo_comp_01", "camo_a_02", "camo_b_02", "camo_c_02", "camo_d_02", "camo_e_02", "camo_f_02", "camo_g_02", "camo_h_02", "camo_i_02", "camo_j_02", "camo_k_02", "camo_l_02", "camo_m_02", "camo_n_02", "camo_o_02", "camo_p_02", "camo_r_02", "camo_comp_02", "camo_a_03", "camo_b_03", "camo_c_03", "camo_d_03", "camo_e_03", "camo_f_03", "camo_g_03", "camo_h_03", "camo_i_03", "camo_j_03", "camo_k_03", "camo_l_03", "camo_m_03", "camo_n_03", "camo_o_03", "camo_p_03", "camo_comp_03", "camo_a_04", "camo_b_04", "camo_c_04", "camo_d_04", "camo_e_04", "camo_f_04", "camo_g_04", "camo_h_04", "camo_i_04", "camo_j_04", "camo_k_04", "camo_l_04", "camo_m_04", "camo_n_04", "camo_o_04", "camo_p_04", "camo_comp_04", "camo_a_05", "camo_b_05", "camo_c_05", "camo_d_05", "camo_e_05", "camo_f_05", "camo_g_05", "camo_h_05", "camo_i_05", "camo_j_05", "camo_k_05", "camo_l_05", "camo_m_05", "camo_n_05", "camo_o_05", "camo_p_05", "camo_a_06", "camo_b_06", "camo_c_06", "camo_d_06", "camo_e_06", "camo_f_06", "camo_g_06", "camo_h_06", "camo_i_06", "camo_j_06", "camo_k_06", "camo_l_06", "camo_m_06", "camo_n_06", "camo_o_06", "camo_p_06", "camo_a_07", "camo_b_07", "camo_c_07", "camo_d_07", "camo_e_07", "camo_f_07", "camo_g_07", "camo_h_07", "camo_i_07", "camo_j_07", "camo_k_07", "camo_l_07", "camo_m_07", "camo_n_07", "camo_o_07", "camo_p_07", "camo_a_08", "camo_b_08", "camo_c_08", "camo_d_08", "camo_e_08", "camo_f_08", "camo_g_08", "camo_h_08", "camo_i_08", "camo_j_08", "camo_k_08", "camo_l_08", "camo_m_08", "camo_n_08", "camo_o_08", "camo_p_08", "camo_a_09", "camo_b_09", "camo_c_09", "camo_d_09", "camo_e_09", "camo_f_09", "camo_g_09", "camo_h_09", "camo_i_09", "camo_j_09", "camo_k_09", "camo_l_09", "camo_m_09", "camo_n_09", "camo_o_09", "camo_a_10", "camo_b_10", "camo_c_10", "camo_d_10", "camo_e_10", "camo_f_10", "camo_g_10", "camo_h_10", "camo_i_10", "camo_j_10", "camo_k_10", "camo_l_10", "camo_m_10", "camo_n_10", "camo_o_10", "camo_a_11", "camo_b_11", "camo_c_11", "camo_d_11", "camo_e_11", "camo_f_11", "camo_g_11", "camo_h_11", "camo_i_11", "camo_j_11", "camo_k_11", "camo_l_11", "camo_m_11", "camo_n_11", "camo_o_11", "camo_a_12", "camo_b_12", "camo_c_12", "camo_d_12", "camo_e_12", "camo_f_12", "camo_g_12", "camo_h_12", "camo_i_12", "camo_j_12", "camo_k_12", "camo_l_12", "camo_m_12", "camo_n_12", "camo_o_12", "camo_a_13", "camo_b_13", "camo_c_13", "camo_d_13", "camo_e_13", "camo_f_13", "camo_g_13", "camo_h_13", "camo_i_13", "camo_j_13", "camo_k_13", "camo_l_13", "camo_m_13", "camo_n_13", "camo_o_13", "camo_a_14", "camo_b_14", "camo_c_14", "camo_d_14", "camo_e_14", "camo_f_14", "camo_g_14", "camo_h_14", "camo_i_14", "camo_j_14", "camo_k_14", "camo_l_14", "camo_m_14", "camo_n_14", "camo_o_14", "camo_a_15", "camo_b_15", "camo_c_15", "camo_d_15", "camo_e_15", "camo_f_15", "camo_g_15", "camo_h_15", "camo_i_15", "camo_j_15", "camo_k_15", "camo_l_15", "camo_m_15", "camo_n_15"];

  if(game["roundWinStreak"][teamname] > 5) {
    camoname = "camo_comp_04";
  } else {
    switch (game["roundWinStreak"][teamname]) {
      case 1:
        camoname = random(camos);
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

function updaterandomloadout() {
  if(scripts\mp\gametypes\arena::israndomloadouts()) {
    if(getdvarint(@ "hash_b665ceb14dabc0ed", -1) != -1) {
      game["<dev string:x289>"] = array_randomize(game["<dev string:x29f>"]);
      game["<dev string:x2b0>"] = 0;
      return;
    }

    if(game["roundsPlayed"] == 0) {
      if(istrue(game["practiceRound"])) {
        game["arenaRandomLoadout"] = array_randomize(game["arenaLoadouts"]);
        game["arenaRandomLoadoutIndex"] = 0;
      } else if(!isDefined(game["practiceRound"]) || istrue(game["didSnowFight"])) {
        if(istrue(game["didSnowFight"])) {
          game["didSnowFight"] = undefined;
        }

        game["arenaRandomLoadout"] = array_randomize(game["arenaLoadouts"]);
        game["arenaRandomLoadoutIndex"] = 0;
      }

      return;
    }

    if(level.loadoutchangeround != 0) {
      if(game["roundsPlayed"] % level.loadoutchangeround == 0) {
        game["arenaRandomLoadoutIndex"]++;
      }

      if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size) {
        game["arenaRandomLoadoutIndex"] = 0;
      }

      return;
    }

    game["arenaRandomLoadoutIndex"] = 0;
  }
}

function function_3187496929140714(var_6caf1a8ca6008020, var_171342d97570f634, var_a049f07e0f11dc31) {
  classtables = [];
  loadouttypes = ter_op(isDefined(var_6caf1a8ca6008020), var_6caf1a8ca6008020, []);
  weapontypes = ter_op(isDefined(var_171342d97570f634), var_171342d97570f634, []);
  projects = ter_op(isDefined(var_a049f07e0f11dc31), var_a049f07e0f11dc31, []);

  if(loadouttypes.size == 0) {
    if(israndomblueprintsloadouts()) {
      loadouttypes[loadouttypes.size] = "arena_blueprints_class_table";
    } else if(scripts\cp_mp\utility\game_utility::isinfectedgametype()) {
      loadouttypes[loadouttypes.size] = "arena_infect_class_table";
    } else {
      loadouttypes[loadouttypes.size] = "arena_class_table";
    }
  }

  if(weapontypes.size == 0) {
    var_d63e7120d2b583fe = !israndomarloadouts() && !israndomsmgloadouts() && !israndomlmgloadouts() && !israndompistolloadouts() && !israndomshotgunloadouts() && !israndomsniperloadouts();

    if(var_d63e7120d2b583fe || israndomarloadouts()) {
      weapontypes[weapontypes.size] = "ar";
    }

    if(var_d63e7120d2b583fe || israndomsmgloadouts()) {
      weapontypes[weapontypes.size] = "smg";
    }

    if(var_d63e7120d2b583fe || israndomlmgloadouts()) {
      weapontypes[weapontypes.size] = "lmg";
    }

    if(var_d63e7120d2b583fe || israndompistolloadouts()) {
      weapontypes[weapontypes.size] = "pistol";
    }

    if(var_d63e7120d2b583fe || israndomshotgunloadouts()) {
      weapontypes[weapontypes.size] = "shotgun";
    }

    if(var_d63e7120d2b583fe || israndomsniperloadouts()) {
      weapontypes[weapontypes.size] = "sniper";
    }
  }

  if(projects.size == 0) {
    projects[projects.size] = "iw9_mp";
  }

  foreach(loadouttype in loadouttypes) {
    foreach(weapontype in weapontypes) {
      foreach(project in projects) {
        classtablename = scripts\engine\utility::string_join([loadouttype, weapontype, project], "_");
        classtablename = scripts\engine\utility::string_join(["classtable", classtablename], ":");
        var_6ab15b7ea89d055d = getscriptbundle(classtablename);
        classtables[classtables.size] = var_6ab15b7ea89d055d;
        assertex(isDefined(var_6ab15b7ea89d055d), "<dev string:x2cb>");
      }
    }
  }

  return classtables;
}

function function_443c6629449aa6ed() {
  classtables = [];
  var_d63e7120d2b583fe = isnormalloadouts() || israndomloadouts();
  weapontypes[#"ar"] = israndomarloadouts();
  weapontypes[#"smg"] = israndomsmgloadouts();
  weapontypes[#"lmg"] = israndomlmgloadouts();
  weapontypes[#"pistol"] = israndompistolloadouts();
  weapontypes[#"shotgun"] = israndomshotgunloadouts();
  weapontypes[#"sniper"] = israndomsniperloadouts();
  var_26df59236cef45ce = level.gametypebundle.var_23180664a9429bdb;

  foreach(loadoutentry in var_26df59236cef45ce) {
    if(!isDefined(loadoutentry.bundle)) {
      continue;
    }

    if(!istrue(weapontypes[loadoutentry.weapon_type]) && !istrue(var_d63e7120d2b583fe)) {
      continue;
    }

    var_e84f572e5ccd786f = hashcat(%"classtable:", loadoutentry.bundle);
    var_6ab15b7ea89d055d = getscriptbundle(var_e84f572e5ccd786f);
    assertex(isDefined(var_6ab15b7ea89d055d), "<dev string:x2cb>");
    classtables[classtables.size] = var_6ab15b7ea89d055d;
  }

  return classtables;
}

function function_37f8be8199814f97(loadoutstruct) {
  loadoutscriptbundle = getscriptbundle("classtableentry:" + loadoutstruct.entry);
  loadout = [];
  loadout["loadoutPrimary"] = loadoutscriptbundle.primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = ter_op(!israndomnoattachmentloadouts(), loadoutscriptbundle.primaryweapon.attachment1, "none");
  loadout["loadoutPrimaryAttachment1"] = ter_op(!israndomnoattachmentloadouts(), loadoutscriptbundle.primaryweapon.attachment2, "none");
  loadout["loadoutPrimaryAttachment2"] = ter_op(!israndomnoattachmentloadouts(), loadoutscriptbundle.primaryweapon.attachment3, "none");
  loadout["loadoutPrimaryAttachment3"] = ter_op(!israndomnoattachmentloadouts(), loadoutscriptbundle.primaryweapon.attachment4, "none");
  loadout["loadoutPrimaryAttachment4"] = ter_op(!israndomnoattachmentloadouts(), loadoutscriptbundle.primaryweapon.attachment5, "none");
  loadout["loadoutPrimaryAttachment5"] = ter_op(!israndomnoattachmentloadouts(), loadoutscriptbundle.primaryweapon.attachment6, "none");
  loadout["loadoutPrimaryCamo"] = loadoutscriptbundle.primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = loadoutscriptbundle.primaryweapon.reticle;
  loadout["loadoutPrimaryVariantID"] = ter_op(israndomblueprintsloadouts() || israndomcustomblueprintsloadouts(), loadoutscriptbundle.primaryweapon.variantid, 0);
  loadout["loadoutPrimaryAddBlueprintAttachments"] = loadoutscriptbundle.primaryweapon.addblueprintattachments;
  loadout["loadoutSecondary"] = loadoutscriptbundle.secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = ter_op(!israndomnoattachmentloadouts(), loadoutscriptbundle.secondaryweapon.attachment1, "none");
  loadout["loadoutSecondaryAttachment1"] = ter_op(!israndomnoattachmentloadouts(), loadoutscriptbundle.secondaryweapon.attachment2, "none");
  loadout["loadoutSecondaryAttachment2"] = ter_op(!israndomnoattachmentloadouts(), loadoutscriptbundle.secondaryweapon.attachment3, "none");
  loadout["loadoutSecondaryAttachment3"] = ter_op(!israndomnoattachmentloadouts(), loadoutscriptbundle.secondaryweapon.attachment4, "none");
  loadout["loadoutSecondaryAttachment4"] = ter_op(!israndomnoattachmentloadouts(), loadoutscriptbundle.secondaryweapon.attachment5, "none");
  loadout["loadoutSecondaryCamo"] = loadoutscriptbundle.secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = loadoutscriptbundle.secondaryweapon.reticle;
  loadout["loadoutSecondaryVariantID"] = ter_op(israndomblueprintsloadouts() || israndomcustomblueprintsloadouts(), loadoutscriptbundle.primaryweapon.variantid, 0);
  loadout["loadoutSecondaryAddBlueprintAttachments"] = loadoutscriptbundle.secondaryweapon.addblueprintattachments;
  loadout["loadoutEquipmentPrimary"] = loadoutscriptbundle.equipment.primary;
  loadout["loadoutEquipmentSecondary"] = loadoutscriptbundle.equipment.secondary;
  loadout["loadoutExtraEquipmentPrimary"] = loadoutscriptbundle.extrapower.primary;
  loadout["loadoutExtraEquipmentSecondary"] = loadoutscriptbundle.extrapower.secondary;

  if(level.allowsupers) {
    mapname = scripts\cp_mp\utility\game_utility::getmapname();

    if(issubstr(mapname, "mp_m_") && mapname != "mp_m_speed") {
      fixupsupersandtacticalsforgunfightmaps();
    }
  }

  loadout["loadoutFieldUpgrade1"] = level.arenasuper;
  loadout["loadoutFieldUpgrade2"] = "none";
  loadout["loadoutPerks"] = [];
  loadout["loadoutPerks"][0] = scripts\engine\utility::ter_op(loadoutscriptbundle.perks.perk1 != "specialty_null", loadoutscriptbundle.perks.perk1, "none");
  loadout["loadoutPerks"][1] = scripts\engine\utility::ter_op(loadoutscriptbundle.perks.perk2 != "specialty_null", loadoutscriptbundle.perks.perk2, "none");
  loadout["loadoutPerks"][2] = scripts\engine\utility::ter_op(loadoutscriptbundle.perks.perk3 != "specialty_null", loadoutscriptbundle.perks.perk3, "none");
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutExecution"] = "playerData";

  if(getgametype() == "arena") {
    if(loadout["loadoutPrimaryVariantID"] != 0) {
      setomnvar("ui_arena_primaryVariantID", loadout["loadoutPrimaryVariantID"]);
    }

    if(loadout["loadoutSecondaryVariantID"] != 0) {
      setomnvar("ui_arena_secondaryVariantID", loadout["loadoutPrimaryVariantID"]);
    }
  }

  return loadout;
}

function initweaponmap() {
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

function getblueprintforpickupweapon(weapon) {
  if(ispickupblueprintloadouts() && !issubstr(weapon, "equip") && weapon != "none") {
    table = "classtable:classtable_arena_blueprints";
    classidx = 0;
    tablerootname = "";
    rootname = getweaponrootname(weapon);
    numloadouts = scripts\mp\class::function_df2933f96d726d71(table);

    while(classidx < numloadouts) {
      tablerootname = scripts\mp\class::table_getweapon(table, classidx, 0);

      if(rootname == tablerootname) {
        break;
      }

      classidx++;
    }

    if(rootname != "") {
      variantid = scripts\mp\class::table_getweaponvariantid("classtable:classtable_arena_blueprints", classidx, 0, rootname);
      return variantid;
    }

    return 0;
  }

  return 0;
}

function setupweapons() {
  locs = getStructArray("weapon_pickup", "targetname");
  assertex(locs.size > 0, "<dev string:x30f>");

  if(level.arenapickupattachments != 0) {
    setupstartweaponsattachments();
  } else if(ispickupblueprintloadouts()) {
    setupblueprintpickupweapons();
  }

  foreach(loc in locs) {
    debugspawnweapon = getDvar(@ "hash_e7ea6273ed7f950f", "<dev string:x36e>");

    if(debugspawnweapon != "<dev string:x36e>") {
      var_8f6a2537b224ce5a = spawnStruct();
      var_8f6a2537b224ce5a.weapon = debugspawnweapon;
      var_8f6a2537b224ce5a.variantid = -1;
      spawnweapon(loc, var_8f6a2537b224ce5a);
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

    if(loc.script_label == "8") {
      spawnweapon(loc, level.arenaweapont8);
    }
  }
}

function getrandomspawnweapon() {
  weaponlist = level.allweapons;

  if(isDefined(weaponlist) && weaponlist.size > 0) {
    newweapon = "";
    data = undefined;

    for(loopcount = 0; true; loopcount++) {
      weapon = random(weaponlist);

      if(!issubstr(weapon, "equip")) {
        rootname = getweaponrootname(weapon);
      } else {
        rootname = weapon;
      }

      if(loopcount > weaponlist.size) {
        level.selectedweapons[rootname] = 1;
        newweapon = weapon;

        for(i = 0; i < level.allweapons.size; i++) {
          if(level.allweapons[weapon] == newweapon) {
            break;
          }
        }

        break;
      }
    }

    return newweapon;
  }

  assertmsg("<dev string:x372>");
  return "none";
}

function getarenapickupattachmentoverrides(weapon) {
  attachments = [];

  if(level.arenapickupattachments == 1) {
    if(weaponclass(weapon) == "sniper" || weaponclass(weapon) == "dmr") {
      attachments[attachments.size] = "scope";
    }
  }

  if(attachments.size == 0) {
    attachments[attachments.size] = "none";
  }

  return attachments;
}

function spawnweapon(loc, weaponstruct, var_5f3b26e2789a42c0) {
  if(isDefined(var_5f3b26e2789a42c0)) {
    weapontier = weaponstruct;
  } else {
    weapontier = weaponstruct.weapon;
  }

  if(weapontier == "none") {
    return;
  }

  loc = scripts\mp\gametypes\arena::function_355f5b20c3c22114(loc);
  loc = scripts\mp\gametypes\arena::function_c1d47107cd83fcaa(loc, weapontier);

  if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall") {} else {
    tracestart = loc.origin + (0, 0, 16);
    traceend = loc.origin + (0, 0, -16);
    trace = scripts\engine\trace::ray_trace(tracestart, traceend, undefined, scripts\engine\trace::create_default_contents(1));

    if(trace["fraction"] < 1) {
      snappos = trace["position"] + (0, 0, 2);
    }
  }

  equipmentinfo = scripts\mp\gametypes\arena::function_5a0a68144c7a97fd(weapontier);

  if(isDefined(equipmentinfo)) {
    if(istrue(level.snowballfight)) {
      snowtype = "pyramid";

      if(!isPlayer(loc)) {
        switch (loc.script_label) {
          case #"hash_66c094dee1aed032":
            level.pickedpball = 1;
            weapontier = "equip_pball";
            snowtype = "pball";
            break;
          default:
            snowtype = "pyramid";
            break;
        }
      }

      equipmentinfo = scripts\mp\gametypes\arena::function_5a0a68144c7a97fd(weapontier);

      if(!isDefined(snappos)) {
        snappos = loc.origin;
      } else {
        snappos += (0, 0, -1);
      }

      equipment = spawn("script_model", snappos);
      equipment setModel(equipmentinfo.worldmodel);

      if(is_equal(weapontier, "<dev string:x389>")) {
        level thread function_a9b5870805221f3d(equipment);
      }
    } else {
      equipment = spawn("script_model", loc.origin);
      equipment setModel(equipmentinfo.worldmodel);
    }

    userange = 96;
    hintdisplayrange = 96;

    if(getdvarint(@ "hash_16a5fe0ac78e7780", 0) == 1) {
      hintdisplayrange = 128;
    }

    equipmenthinticon = equipment getequipmenthinticon(weapontier);
    equipment.equipment = weapontier;
    equipment.equiptype = equipmentinfo.equiptype;
    equipment.angles = loc.angles;

    if(istrue(level.snowballfight) && isDefined(snowtype) && snowtype == "pyramid") {} else {
      equipment.angles += (0, 0, 90);
    }

    equipment makeusable();
    equipment sethinttag("tag_origin");
    equipment setCursorHint("HINT_BUTTON");
    equipment sethinticon(equipmentinfo.icon);
    equipment setuseholdduration("duration_short");
    equipment setusehideprogressbar(1);
    equipment setHintString(equipmentinfo.pickupstring);
    equipment setusepriority(0);
    equipment sethintdisplayrange(hintdisplayrange);
    equipment sethintdisplayfov(120);
    equipment setuserange(userange);
    equipment setusefov(210);
    equipment sethintonobstruction("hide");
    equipment thread outlineequipmentwatchplayerprox(weapontier);
    equipment.proxtrigger = spawn("trigger_radius", equipment.origin, 0, 32, 32);

    if(istrue(level.snowballfight) && isDefined(snowtype)) {
      equipment thread watchsnowballpickup(loc, snowtype);
    } else {
      equipment thread itemproxtriggerthink();
      equipment thread watchequipmentpickup();
    }

    equipment.targetname = "dropped_equipment";
    return;
  }

  if(ispickupblueprintloadouts()) {
    objweapon = weaponstruct.weaponobj;
  } else {
    rootname = getweaponrootname(weapontier);
    attachments = getarenapickupattachmentoverrides(rootname + "_mp");
    objweapon = scripts\cp_mp\weapon::buildweapon(rootname, attachments, "none", "none", -1);
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
    delta = vectorNormalize(forward) * 30;
    tracestart = loc.origin + delta + (0, 0, 16);
    traceend = loc.origin + delta + (0, 0, -100);
    trace = scripts\engine\trace::ray_trace(tracestart, traceend, undefined, scripts\engine\trace::create_default_contents(1));
    tracepos = loc.origin;

    if(trace["fraction"] < 1) {
      tracepos = trace["position"];
    }

    weapon.bot_pickup_origin = tracepos;
  }

  manageweaponstartingammo(weapon, weaponname);
  weapon thread outlinewatchplayerprox();
  weapon thread watchpickup();
}

function function_a9b5870805221f3d(model) {
  model endon("<dev string:x398>");

  while(!isDefined(level.player)) {
    waitframe();
  }

  while(true) {
    line(model.origin, level.player.origin, (1, 1, 1), 1, 0, 1);
    waitframe();
  }
}

function private function_c1d47107cd83fcaa(loc, weaponname) {
  assert(isDefined(loc));
  assert(isDefined(weaponname) && weaponname != "<dev string:x36e>");

  switch (weaponname) {
    case #"hash_25ac81b822cf0c9f":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc.var_3770f35956a8212c) && loc.var_3770f35956a8212c == "wall") {
        loc.angles += (0, 90, 0);
      } else {
        loc.angles += (90, 0, 0);
      }

      break;
    case #"hash_3995658e01f4fac1":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc.var_3770f35956a8212c) && loc.var_3770f35956a8212c == "wall") {
        loc.angles += (270, 0, 0);
      } else {
        loc.angles += (0, 0, 90);
      }

      break;
    case #"hash_4320d77f90725183":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc.var_3770f35956a8212c) && loc.var_3770f35956a8212c == "wall") {
        loc.angles += (0, 90, 0);
      } else {
        loc.angles += (180, 180, 0);
      }

      break;
    case #"hash_2354208d9af64220":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc.var_3770f35956a8212c) && loc.var_3770f35956a8212c == "wall") {
        loc.angles += (0, 180, 0);
      } else {
        loc.angles += (0, 0, 90);
      }

      break;
    case #"hash_4b4a6458f00d9319":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc.var_3770f35956a8212c) && loc.var_3770f35956a8212c == "wall") {
        loc.angles += (270, 270, 0);
      } else {
        loc.angles += (0, 0, 90);
      }

      break;
    case #"hash_9ba0a6ff6081954e":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc.var_3770f35956a8212c) && loc.var_3770f35956a8212c == "wall") {
        loc.angles += (0, 90, 0);
      }

      break;
    case #"hash_8d9ae5e5dd390b4b":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc.var_3770f35956a8212c) && loc.var_3770f35956a8212c == "wall") {
        loc.angles += (0, 0, 90);
      } else {
        loc.angles += (0, 0, 90);
      }

      break;
    case #"hash_f85c7f2de2371beb":
      if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "wall" || isDefined(loc.var_3770f35956a8212c) && loc.var_3770f35956a8212c == "wall") {
        loc.angles += (0, -90, 0);
      } else {
        loc.angles += (-90, 0, 0);
      }

      break;
    default:
      break;
  }

  return loc;
}

function private function_355f5b20c3c22114(loc) {
  assert(isDefined(loc));

  switch (level.mapname) {
    case #"hash_564958ec86b5937":
      if(loc.script_label == "1") {
        if(distance(loc.origin, (-11, -889, 32)) < 10) {
          loc.origin += (15, 0, 0);
        } else if(distance(loc.origin, (125, 1158, 49)) < 10) {
          loc.origin += (7, 0, 0);
        } else if(distance(loc.origin, (-181, 1159, 34)) < 10) {
          loc.origin += (7, 0, 0);
        } else if(distance(loc.origin, (545, 379, 53)) < 10) {
          loc.origin += (0, -0.5, 0);
        }
      } else if(loc.script_label == "2") {
        if(distance(loc.origin, (-412, -618, 52)) < 10) {
          loc.origin += (-10, 0, 1);
        }
      } else if(loc.script_label == "6" && distance(loc.origin, (-313.261, 486, 54.9829)) < 10) {
        loc.origin += (0, 0, -1);
      } else if(loc.script_label == "7") {
        if(distance(loc.origin, (-47, -637, 48)) < 10) {
          loc.angles += (0, 180, 0);
        } else if(distance(loc.origin, (112, -516, 63)) < 10) {
          loc.angles += (0, 90, 0);
        } else if(distance(loc.origin, (-89, -371, 56)) < 10) {
          loc.origin += (0, 0, -1);
        }
      } else if(loc.script_label == "8" && distance(loc.origin, (328, -1078, 52)) < 10) {
        loc.angles += (0, 270, 0);
      }

      break;
    case #"hash_61f7356a42e47c76":
      if(loc.script_label == "6") {
        if(distance(loc.origin, (-256, -1152, -62)) < 10) {
          loc.origin += (0, 0, -2);
        } else if(distance(loc.origin, (128, 128, -62)) < 10) {
          loc.origin += (0, 0, -2);
        }
      }

      break;
    case #"hash_f7a3e0a896bc04b":
      if(loc.script_label == "1") {
        if(distance(loc.origin, (-72, -737, -141.5)) < 10) {
          loc.origin += (10, 0, 1);
        } else if(distance(loc.origin, (-49, -715, -141.5)) < 10) {
          loc.origin += (-15, -5, 1);
        } else if(distance(loc.origin, (-894, 273, -141.5)) < 10) {
          loc.origin += (15, -25, -1);
        } else if(distance(loc.origin, (-911, 243, -141.5)) < 10) {
          loc.origin += (30, -20, -1);
        }
      } else if(loc.script_label == "6") {
        if(distance(loc.origin, (-223.5, -588, -145)) < 10) {
          loc.origin += (0, 0, 2);
        } else if(distance(loc.origin, (-606.5, 156, -145)) < 10) {
          loc.origin += (3, -25, -1);
        }
      } else if(loc.script_label == "7") {
        if(distance(loc.origin, (-229.5, 152, -145)) < 10) {
          loc.origin += (0, -5, -1);
        } else if(distance(loc.origin, (-740.5, -561, -147)) < 10) {
          loc.origin += (0, 0, 1);
        }
      }

      break;
    default:
      break;
  }

  return loc;
}

function getequipmenthinticon(weapon) {
  table = "mp/arenaGGWeapons.csv";
  icon = tablelookup(table, 0, weapon, 3);
  return icon;
}

function manageweaponstartingammo(weapon, weaponname) {
  mag = weaponclipsize(weaponname);
  var_6f592a5fb739460 = 0;

  if(level.magcount != 3) {
    noammo = !level.magcount;

    if(noammo) {
      mag = 0;
      var_6f592a5fb739460 = 0;
    } else {
      var_6f592a5fb739460 = level.magcount - 1;
    }

    if(level.magcount == 7) {
      var_6f592a5fb739460 = weaponmaxammo(weaponname);
    } else {
      var_6f592a5fb739460 = mag * var_6f592a5fb739460;
    }
  } else {
    var_6f592a5fb739460 = mag * 2;
  }

  weapon itemweaponsetammo(mag, var_6f592a5fb739460);
}

function watchequipmentpickup() {
  self endon("death");
  self waittill("trigger", player, droppeditem);
  hasmaxammo = 0;
  issameequip = checkissameequip(player);
  equipammo = checkpickupequiptypeammocount(player);
  var_8b9ab3abae98d973 = player scripts\mp\equipment::getequipmentmaxammo(self.equipment);
  var_b64209459da65860 = checkcurrentequiptypeammocount(player);

  if(issameequip) {
    if(equipammo == var_8b9ab3abae98d973) {
      hasmaxammo = 1;
    }
  }

  if(issameequip && !hasmaxammo) {
    player scripts\mp\equipment::incrementequipmentammo(self.equipment, 1);
  } else if(var_b64209459da65860 && !issameequip) {
    player dropoldequipinplace(player scripts\mp\equipment::getcurrentequipment(self.equiptype));
  }

  if(!issameequip) {
    player scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);
  }

  if(issameequip && hasmaxammo) {
    player iprintlnbold(&"MP_INGAME_ONLY/EQUIPMENT_MAXED");
    thread watchequipmentpickup();
    return;
  }

  player playlocalsound("scavenger_pack_pickup");
  clearweaponoutlines();
  self makeunusable();
  self delete();
}

function checkpickupequiptypeammocount(player) {
  return player scripts\mp\equipment::getequipmentammo(self.equipment);
}

function checkcurrentequiptypeammocount(player) {
  equipref = player scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(equipref)) {
    return player scripts\mp\equipment::getequipmentammo(equipref);
  }

  return 0;
}

function checkissameequip(player) {
  equipref = player scripts\mp\equipment::getcurrentequipment(self.equiptype);

  if(isDefined(equipref)) {
    return (self.equipment == equipref);
  }

  return 0;
}

function dropoldequipinplace(equipment) {
  spawnweapon(self, equipment, 1);
}

function watchpickup() {
  self endon("death");
  self waittill("trigger", player, droppeditem);
  clearweaponoutlines();

  if(isDefined(droppeditem)) {
    droppeditem sethintdisplayrange(96);
    droppeditem setuserange(96);
    droppeditem setuseholdduration("duration_short");
    droppeditem thread outlinewatchplayerprox();
    droppeditem thread watchpickup();
  }
}

function itemproxtriggerthink() {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");
  equipref = undefined;

  while(true) {
    wait 0.05;
    self.proxtrigger waittill("trigger", player);

    if(!isreallyalive(player)) {
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

    equipref = player scripts\mp\equipment::getcurrentequipment(self.equiptype);
    hasmaxammo = 0;
    issameequip = checkissameequip(player);
    var_b64209459da65860 = checkcurrentequiptypeammocount(player);
    equipref = player scripts\mp\equipment::getcurrentequipment(self.equiptype);

    if(isDefined(equipref) && !issameequip && var_b64209459da65860 > 0) {
      continue;
    }

    equipammo = checkpickupequiptypeammocount(player);
    var_8b9ab3abae98d973 = player scripts\mp\equipment::getequipmentmaxammo(self.equipment);

    if(issameequip) {
      if(equipammo == var_8b9ab3abae98d973) {
        hasmaxammo = 1;
      }
    }

    if(issameequip && !hasmaxammo) {
      player scripts\mp\equipment::incrementequipmentammo(self.equipment, 1);
    }

    if(issameequip && hasmaxammo) {
      continue;
    }

    if(!isDefined(equipref) || isDefined(equipref) && !issameequip && var_b64209459da65860 == 0) {
      player scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);
    }

    if(istrue(level.snowballfight)) {
      player playlocalsound("weap_snowball_pickup");
    } else {
      player playlocalsound("scavenger_pack_pickup");
    }

    clearweaponoutlines();
    self makeunusable();
    self delete();
  }
}

function updatearenagungameloadout(reversegg) {
  if(game["roundsPlayed"] == 0) {
    cachearenagungameloadouts(reversegg);
    game["arenaRandomLoadoutIndex"] = 0;
  }
}

function cachearenagungameloadouts(reversegg) {
  loadouts = [];
  classtables = [];

  if(istrue(level.gametypebundle.var_535d5c90db8b1a9f)) {
    classtables = function_443c6629449aa6ed();
  } else {
    classtables = function_3187496929140714();
  }

  foreach(classtable in classtables) {
    foreach(loadout in classtable.classlist) {
      loadouts[loadouts.size] = function_37f8be8199814f97(loadout);
    }
  }

  game["arenaRandomLoadout"] = scripts\engine\utility::ter_op(reversegg, scripts\engine\utility::array_reverse(loadouts), loadouts);
}

function setenemyloadoutomnvars() {
  enemyplayer = undefined;

  if(!isDefined(self.pers["team"])) {
    otherteam = "allies";
  } else {
    otherteam = getotherteam(self.pers["team"])[0];
  }

  foreach(player in level.players) {
    if(player.team == otherteam) {
      enemyplayer = player;
      break;
    }
  }

  if(!isDefined(enemyplayer)) {
    enemyplayer = self;
  }

  table = "mp/arenaGGWeapons.csv";
  self setclientomnvar("ui_arena_en_primary", -1);
  self setclientomnvar("ui_arena_en_secondary", -1);
  self setclientomnvar("ui_arena_en_lethal", -1);
  self setclientomnvar("ui_arena_en_tactical", -1);
  primary = int(tablelookup(table, 0, enemyplayer.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
  self setclientomnvar("ui_arena_en_primary", primary);
  secondary = int(tablelookup(table, 0, enemyplayer.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
  self setclientomnvar("ui_arena_en_secondary", secondary);
  lethal = int(tablelookup(table, 0, enemyplayer.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
  self setclientomnvar("ui_arena_en_lethal", lethal);
  tactical = int(tablelookup(table, 0, enemyplayer.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
  self setclientomnvar("ui_arena_en_tactical", tactical);
}

function getgungameloadoutindex(player) {
  playerloadoutindex = 0;

  if(game["roundsPlayed"] == 0) {
    playerloadoutindex = 0;
  } else if(isgungameloadouts()) {
    playerloadoutindex = game["roundsWon"][player.pers["team"]];
  } else {
    playerloadoutindex = game["roundsWon"][getotherteam(player.pers["team"])[0]];
  }

  return playerloadoutindex;
}

function getgungameloadoutomnvarindex(player, winningteam) {
  playerloadoutindex = 0;

  if(isgungameloadouts()) {
    playerloadoutindex = game["roundsWon"][player.pers["team"]];

    if(isDefined(winningteam) && winningteam == player.pers["team"]) {
      playerloadoutindex += 1;
    }
  } else {
    playerloadoutindex = game["roundsWon"][getotherteam(player.pers["team"])[0]];

    if(isDefined(winningteam) && winningteam == getotherteam(player.pers["team"])[0]) {
      playerloadoutindex += 1;
    }
  }

  return playerloadoutindex;
}

function setenemyloadoutomnvarsatmatchend(winningteam) {
  foreach(player in level.players) {
    enemyplayer = undefined;

    if(!isDefined(player.pers["team"])) {
      otherteam = "allies";
    } else {
      otherteam = getotherteam(player.pers["team"])[0];
    }

    foreach(p in level.players) {
      if(p.team == otherteam) {
        enemyplayer = p;
        break;
      }
    }

    if(!isDefined(enemyplayer)) {
      enemyplayer = player;
    }

    enemyplayer.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][getgungameloadoutomnvarindex(enemyplayer, winningteam)];
    table = "mp/arenaGGWeapons.csv";
    player setclientomnvar("ui_arena_en_primary", -1);
    player setclientomnvar("ui_arena_en_secondary", -1);
    player setclientomnvar("ui_arena_en_lethal", -1);
    player setclientomnvar("ui_arena_en_tactical", -1);
    primary = int(tablelookup(table, 0, enemyplayer.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
    player setclientomnvar("ui_arena_en_primary", primary);
    secondary = int(tablelookup(table, 0, enemyplayer.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
    player setclientomnvar("ui_arena_en_secondary", secondary);
    lethal = int(tablelookup(table, 0, enemyplayer.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
    player setclientomnvar("ui_arena_en_lethal", lethal);
    tactical = int(tablelookup(table, 0, enemyplayer.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
    player setclientomnvar("ui_arena_en_tactical", tactical);
  }
}

function spawngameendflagzone() {
  arenaflag = getEntArray("flag_arena", "targetname");

  if(!isDefined(arenaflag[0]) && getdvarint(@ "hash_2e5cbfbbbbae7cc", 0)) {
    arenaflag = function_bc9d94a7417733df();
  }

  if(!isDefined(arenaflag[0])) {
    assertmsg("<dev string:x3a9>");
    return;
  }

  level.arenaflag = arenaflag[0];
  trigger = arenaflag[0];

  if(isDefined(trigger.target)) {
    visuals[0] = getEnt(trigger.target, "targetname");
  } else {
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0].angles = trigger.angles;
  }

  trigger.objectivekey = "_a";
  trigger.iconname = "_a";
  arenaflag = scripts\mp\gametypes\obj_dom::setupobjective(trigger, "neutral", undefined, 1);
  arenaflag.onuse = &arenaflag_onuse;
  arenaflag.onbeginuse = &arenaflag_onusebegin;
  arenaflag.onenduse = &arenaflag_onuseend;
  arenaflag.onuseupdate = &arenaflag_onuseupdate;
  arenaflag.oncontested = &arenaflag_oncontested;
  arenaflag.onuncontested = &arenaflag_onuncontested;
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
    level.arenaflag thread scripts\mp\gametypes\arena::deleteotpreview();
    level thread scripts\mp\gametypes\arena::showflagoutline();
    return;
  }

  level.arenaflag scripts\mp\gametypes\arena::disableotflag();
}

function function_bc9d94a7417733df() {
  arenaflags = getEntArray("flag_primary", "targetname");

  foreach(ent in arenaflags) {
    if(is_equal(ent.script_label, "_b")) {
      return [ent];
    }
  }

  return undefined;
}

function showflagoutline() {
  waitframe();

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel)) {
    level.arenaflag.flagmodel.outlinedid = outlineenableforall(level.arenaflag.flagmodel, "outline_nodepth_orange", "level_script");
  }

  level thread removeflagoutlineongameend();
}

function arenaflag_onusebegin(player) {
  player.iscapturing = 1;
  level.canprocessot = 0;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    if(scripts\mp\gameobjects::function_21f4c6f630b17fc4(player)) {
      player.owner setclientomnvar("ui_objective_pinned_text_param", 1);
    } else {
      player setclientomnvar("ui_objective_pinned_text_param", 1);
    }
  }

  self.neutralizing = istrue(level.flagneutralization) && ownerteam != "neutral";
  self.playertouching = 1;

  if(!istrue(self.neutralized)) {
    self.didstatusnotify = 0;
  }

  usetime = ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(usetime);

  if(istrue(level.capturedecay)) {
    thread scripts\mp\gameobjects::useobjectdecay(player.team);
  }

  if(usetime > 0) {
    self.prevownerteam = getotherteam(player.team)[0];
    scripts\mp\gametypes\obj_dom::updateflagcapturestate(player.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icontaking, level.iconlosing);
  }
}

function arenaflag_onuseupdate(team, progress, change, capplayer) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(progress > 0.05 && change && !self.didstatusnotify) {
    if(ownerteam == "neutral") {
      if(level.flagcapturetime > 0.05) {
        scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, team);
        otherteam = getotherteam(team)[0];
        scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, otherteam);
      }
    } else if(level.flagcapturetime > 0.05) {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, ownerteam);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, team);
    }

    self.didstatusnotify = 1;
  }

  if(!istrue(self.stalemate) && !istrue(self.capblocked) && progress < 1 && !level.gameended && !isanymlgmatch()) {
    function_57688e4a9f64765a(progress, team);
  }
}

function arenaflag_onuseend(team, player, success) {
  level.canprocessot = 1;
  self.didstatusnotify = 0;

  if(success) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    thread scripts\mp\gametypes\obj_dom::updateflagstate(ownerteam, 0);
  }

  if(!success) {
    self.neutralized = 0;
  }
}

function arenaflag_onuse(credit_player) {
  level.canprocessot = 1;
  team = credit_player.team;
  oldteam = scripts\mp\gameobjects::getownerteam();
  otherteam = getotherteam(team)[0];
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;
  scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, otherteam);
  scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, team);
  thread printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", credit_player);
  scripts\mp\gametypes\obj_dom::dompoint_setcaptured(team, credit_player);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, credit_player, team, oldteam, self);
    }

    self.firstcapture = 0;
  }

  game["dialog"]["round_success"] = "dx_mp_gunf_game_t141_gfsd";
  game["dialog"]["round_failure"] = "dx_mp_gunf_game_t141_gflt";
  level thread arena_endgame(credit_player.team, game["end_reason"]["arena_otflag_completed"], game["end_reason"]["arena_otflag_failed"]);
}

function arenaflag_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread scripts\mp\gametypes\obj_dom::updateflagstate("contested", 0);
  level thread forcegameendcontesttimeout();
  level.arenaflag thread function_da1f3979f22bb288(level.arenaflag.flagmodel.origin, "jup_shared_zone_contested", 3);
}

function arenaflag_onuncontested(lastclaimteam) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    if(lastclaimteam != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, lastclaimteam);
    } else if(isDefined(self.lastprogressteam)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, self.lastprogressteam);
    }
  } else {
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, getotherteam(ownerteam)[0]);
  }

  if(lastclaimteam == "none" || ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  level.arenaflag thread function_82b6a3e1bcda539b(level.arenaflag.flagmodel.origin, "jup_shared_zone_uncontested", 3);
}

function forcegameendcontesttimeout() {
  level notify("start_overtime_timeout");
  level endon("start_overtime_timeout");
  level endon("game_ended");

  if(!isDefined(level.ottimecontested)) {
    level.ottimecontested = 0;
  }

  while(level.ottimecontested < 5000) {
    wait level.framedurationseconds;
    level.ottimecontested += level.frameduration;
  }

  level.canprocessot = 1;
}

function disableotflag() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();

  if(isDefined(self.scriptable)) {
    self.scriptable delete();
  }

  self.flagmodel hide();
}

function removeflagoutlineongameend() {
  level waittill("game_ended");

  if(isDefined(level.arenaflag) && isDefined(level.arenaflag.flagmodel.outlinedid)) {
    outlinedisable(level.arenaflag.flagmodel.outlinedid, level.arenaflag.flagmodel);
  }
}

function deleteotpreview() {
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\gametypes\arena::disableotflag();
}

function setupendzones() {
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

function createendzone(team) {
  if(isDefined(self.target)) {
    visuals[0] = getEnt(self.target, "targetname");
  } else {
    visuals[0] = spawn("script_model", self.origin);
    visuals[0].angles = self.angles;
  }

  if(isDefined(self.objectivekey)) {
    objectivekey = self.objectivekey;
  } else if(self.targetname == "flag_goal_attacker") {
    objectivekey = "_b";
  } else {
    objectivekey = "_c";
  }

  iconname = undefined;
  endzone = scripts\mp\gameobjects::createuseobject(team, self, visuals, (0, 0, 100));
  endzone.team = team;
  endzone.ownerteam = team;
  endzone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  endzone scripts\mp\gameobjects::allowuse("enemy");
  endzone scripts\mp\gameobjects::cancontestclaim(1);
  endzone scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  endzone.onuse = &endzone_onuse;
  endzone.onbeginuse = &endzone_onusebegin;
  endzone.onenduse = &endzone_onuseend;
  endzone.oncontested = &endzone_oncontested;
  endzone.onuncontested = &endzone_onuncontested;
  endzone.isarena = 1;
  endzone.firstcapture = 1;
  endzone scripts\mp\gameobjects::pinobjiconontriggertouch();
  endzone.id = "domFlag";

  if(isDefined(level.capturetype)) {
    endzone scripts\mp\gameobjects::setcapturebehavior(getcapturetype());
  }

  endzone.objectivekey = objectivekey;
  endzone.iconname = iconname;
  endzone scripts\mp\gameobjects::setvisibleteam("any");
  endzone.stompprogressreward = &endzone_stompprogressreward;
  endzone.nousebar = 1;
  endzone.claimgracetime = level.flagcapturetime * 1000;
  tracestart = visuals[0].origin + (0, 0, 32);
  traceend = visuals[0].origin + (0, 0, -32);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
  endzone.baseeffectpos = trace["position"];
  upangles = vectortoangles(trace["normal"]);
  endzone.baseeffectforward = anglesToForward(upangles);
  scriptable = spawn("script_model", endzone.baseeffectpos);
  scriptable setModel("dom_flag_scriptable");
  scriptable.angles = generateaxisanglesfromforwardvector(endzone.baseeffectforward, scriptable.angles);
  endzone.scriptable = scriptable;
  endzone.vfxnamemod = "";

  if(isDefined(endzone.trigger.radius)) {
    if(endzone.trigger.radius == 160) {
      endzone.vfxnamemod = "_160";
    } else if(endzone.trigger.radius == 90) {
      endzone.vfxnamemod = "_90";
    } else if(endzone.trigger.radius == 315) {
      endzone.vfxnamemod = "_300";
    } else if(endzone.trigger.radius != 120) {
      endzone.noscriptable = 1;
    }
  }

  endzone.flagmodel = spawn("script_model", endzone.baseeffectpos);
  endzone.flagmodel setModel("military_dom_flag_neutral");
  endzone.outlineent = endzone.flagmodel;
  return endzone;
}

function endzone_onusebegin(player) {
  player.iscapturing = 1;
  level.canprocessot = 0;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    player setclientomnvar("ui_objective_pinned_text_param", 1);
  }

  self.neutralizing = istrue(level.flagneutralization) && ownerteam != "neutral";

  if(!istrue(self.neutralized)) {
    self.didstatusnotify = 0;
  }

  usetime = ter_op(istrue(level.flagneutralization), level.flagcapturetime * 0.5, level.flagcapturetime);
  scripts\mp\gameobjects::setusetime(usetime);

  if(istrue(level.capturedecay)) {
    thread scripts\mp\gameobjects::useobjectdecay(player.team);
  }

  if(usetime > 0) {
    self.prevownerteam = getotherteam(player.team)[0];
    scripts\mp\gametypes\obj_dom::updateflagcapturestate(player.team);
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingendzone, level.icontakingendzone);
  }
}

function endzone_onuseend(team, player, success) {
  level.canprocessot = 1;

  if(success) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);

  if(!success) {
    self.neutralized = 0;
  }
}

function endzone_onuse(credit_player) {
  level.canprocessot = 1;
  team = credit_player.team;
  oldteam = scripts\mp\gameobjects::getownerteam();
  otherteam = getotherteam(team)[0];
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;
  thread printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", credit_player);
  endzone_setcaptured(team, credit_player);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, credit_player, team, oldteam, self);
    }
  }

  level thread arena_endgame(credit_player.team, game["end_reason"]["objective_completed"], undefined, 0, 2);
}

function endzone_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestendzone);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

function endzone_onuncontested(lastclaimteam) {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.processot = 1;
}

function endzone_setcaptured(team, credit_player) {
  scripts\mp\gameobjects::setownerteam(team);
  self notify("capture", credit_player);
  self notify("assault", credit_player);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendendzone, level.iconcaptureendzone);
  self.neutralized = 0;

  if(self.touchlist[team].size == 0) {
    self.touchlist = self.oldtouchlist;
  }

  thread giveflagcapturexp(self.touchlist[team], credit_player);

  if(isDefined(level.matchrecording_logevent)) {
    [[level.matchrecording_logevent]](self.logid, undefined, self.logeventflag, self.visuals[0].origin[0], self.visuals[0].origin[1], gettime(), ter_op(team == "allies", 1, 2));
  }

  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + team);
}

function endzone_stompprogressreward(player) {
  player thread scripts\mp\rank::scoreeventpopup(#"defend");
  player thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
}

function getcapturetype() {
  capturetype = "normal";

  if(level.capturetype == 2) {
    capturetype = "neutralize";
  } else if(level.capturetype == 3) {
    capturetype = "persistent";
  }

  return capturetype;
}

function giveflagcapturexp(touchlist, credit_player) {
  level endon("game_ended");
  first_player = credit_player;

  if(isDefined(first_player.owner)) {
    first_player = first_player.owner;
  }

  level.lastcaptime = gettime();

  if(isPlayer(first_player)) {
    level thread teamplayercardsplash("callout_securedposition", first_player);
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = first_player;
    var_7e2c53b0bcf117d9.eventname = "capture";
    var_7e2c53b0bcf117d9.position = first_player.origin;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
  }

  players_touching = getarraykeys(touchlist);

  for(index = 0; index < players_touching.size; index++) {
    player = touchlist[players_touching[index]].player;

    if(isDefined(player.owner)) {
      player = player.owner;
    }

    if(!isPlayer(player)) {
      continue;
    }

    player incpersstat("captures", 1);
    player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
    player thread scripts\mp\rank::scoreeventpopup(#"capture");
    player thread scripts\mp\utility\points::doscoreevent(#"mode_dom_secure");
    wait 0.05;
  }
}

function startotmechanics() {
  if(function_444e57e02c02bee6()) {
    foreach(objective in level.objectives) {
      if(objective.objectivekey != "_a") {
        objective deleteendzone();
      }
    }
  }

  level.canprocessot = 1;

  if(isDefined(level.arenaflag)) {
    if(!isDefined(level.arenaflag.objidnum)) {
      level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);
    }

    level.arenaflag scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    level.arenaflag scripts\mp\gameobjects::enableobject();
    level.arenaflag scripts\mp\gameobjects::allowuse("enemy");
    level.arenaflag.flagmodel show();
    level thread showflagoutline();
    level.arenaflag.flagmodel playSound("flag_spawned");
  }

  if(level.overtimeflag > 0 && !function_2eda32f1d16ded2c()) {
    game["dialog"]["overtime"] = "gamestate_overtime_flagspawn";
  }

  level thread shouldplayerovertimedialog();
  namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(10, "free");

  if(istrue(level.snowballfight)) {
    foreach(player in level.players) {
      if(isalive(player)) {
        equipment = player scripts\mp\equipment::getcurrentequipment("primary");

        if(isDefined(equipment) && equipment == "equip_snowball") {
          player scripts\mp\equipment::incrementequipmentammo("equip_snowball", 10);
          continue;
        }

        if(!isDefined(equipment)) {
          player scripts\mp\equipment::giveequipment("equip_snowball", "primary");
          player scripts\mp\equipment::incrementequipmentammo("equip_snowball", 10);
        }
      }
    }
  }
}

function shouldplayerovertimedialog() {
  wait 0.15;

  if(isDefined(level.arenaflag)) {
    if(istrue(level.arenaflag.playertouching)) {
      return;
    }
  }

  foreach(player in level.players) {
    if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
      continue;
    }

    player scripts\mp\utility\dialog::leaderdialogonplayer("overtime");
  }
}

function deleteendzone() {
  self notify("monitor_flag_control");
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::releaseid();
  self.trigger = undefined;
  self notify("deleted");
  self.visibleteam = "none";

  if(isDefined(self.scriptable)) {
    self.scriptable delete();
  }

  self.flagmodel delete();
}

function function_5bba7f02dbb91b52() {
  level.var_59a1f917fb3131a6 = "neutral";
  level.flagmodel["allies"] = "ctf_game_flag_west";
  level.flagbase["allies"] = "ctf_game_flag_base";
  level.carryflag["allies"] = "prop_ctf_game_flag_west";
  level.flagmodel["axis"] = "ctf_game_flag_east";
  level.flagbase["axis"] = "ctf_game_flag_base";
  level.carryflag["axis"] = "prop_ctf_game_flag_east";
  createflagstart();
}

function createflagstart() {
  level.var_b5538188c80d8af6 = array_randomize(level.var_b5538188c80d8af6);
  tracestart = level.var_b5538188c80d8af6[0] + (0, 0, 64);
  traceend = level.var_b5538188c80d8af6[0] + (0, 0, -64);
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, undefined, scripts\engine\trace::create_default_contents(1));
  level.var_b5538188c80d8af6[0] = trace["position"];
  level.var_21997fbea8438765 = function_7077c9e2d480fab5("allies");
  level thread flaglockedtimer();
}

function flaglockedtimer() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level.var_50a07cda9851d4b8.objectiveicon scripts\mp\gameobjects::setvisibleteam("none");
    level waittill_any_2("prematch_done", "start_mode_setup");
    level.var_50a07cda9851d4b8.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");
  }

  if(level.flagactivationdelay) {
    scripts\mp\flags::gameflagwait("prematch_done");
    level.var_50a07cda9851d4b8.objectiveicon thread scripts\mp\gameobjects::function_d36dcacac1708708(level.flagactivationdelay);
    wait level.flagactivationdelay;
    level.var_50a07cda9851d4b8.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag);
    level.var_21997fbea8438765.trigger scripts\engine\utility::trigger_on();

    foreach(team in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("obj_generic_capture", team);
    }
  }
}

function function_7077c9e2d480fab5(team) {
  level.pickuptime = 0;
  level.returntime = 0;
  radius = 32;
  trigger = spawn("trigger_radius", level.var_b5538188c80d8af6[0], 0, radius, 128);
  visuals = [];
  visuals[0] = spawn("script_model", level.var_b5538188c80d8af6[0]);
  visuals[0] setModel(level.flagmodel[team]);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(team);
  carryteam = "neutral";
  teamflag = scripts\mp\gameobjects::createcarryobject(carryteam, trigger, visuals, (0, 0, 85));
  teamflag scripts\mp\gameobjects::allowcarry("any");
  teamflag scripts\mp\gameobjects::setteamusetime("friendly", level.pickuptime);
  teamflag scripts\mp\gameobjects::setteamusetime("enemy", level.returntime);
  teamflag scripts\mp\gameobjects::setvisibleteam("none");
  teamflag scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);
  teamflag scripts\mp\objidpoolmanager::objective_set_play_intro(teamflag.objidnum, 0);
  teamflag scripts\mp\objidpoolmanager::objective_set_play_outro(teamflag.objidnum, 0);
  teamflag scripts\mp\gameobjects::registercarryobjectpickupcheck(&flagpickupchecks);
  teamflag.allowweapons = 1;
  teamflag.firstpickup = 1;
  teamflag.onpickup = &onpickup;
  teamflag.onpickupfailed = &onpickup;
  teamflag.ondrop = &ondrop;
  teamflag.onreset = &onreset;

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 60;
        break;
      case 1:
        teamflag.objidpingfriendly = 0;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 0.05;
        break;
      case 2:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 1;
        break;
      case 3:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 1.5;
        break;
      case 4:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 2;
        break;
      case 5:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 3;
        break;
      case 6:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 4;
        break;
    }

    pingobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    teamflag.pingobjidnum = pingobjid;
    scripts\mp\objidpoolmanager::objective_add_objective(pingobjid, "done", teamflag.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(pingobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(pingobjid, 0);
    teamflag scripts\mp\gameobjects::setvisibleteam("none", pingobjid);
    objective_setownerteam(pingobjid, team);
    teamflag scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag, pingobjid);
  } else {
    teamflag.objidpingfriendly = 1;
    teamflag.objidpingenemy = 0;
    teamflag.objpingdelay = 3;
  }

  level.var_50a07cda9851d4b8 = function_8be5d726c39eced3(team, teamflag);
  return teamflag;
}

function function_8be5d726c39eced3(team, teamflag) {
  flagbaseorigin = teamflag.visuals[0].origin;
  teamflagbase = spawn("script_model", flagbaseorigin);
  teamflagbase setModel(level.flagbase[team]);
  teamflagbase.ownerteam = "neutral";
  teamflagbase setasgametypeobjective();
  teamflagbase setteaminhuddatafromteamname(team);
  teamflagbase.objectiveicon = scripts\mp\gameobjects::createobjidobject(flagbaseorigin, "neutral", (0, 0, 85), undefined, "any", 0);
  teamflagbase.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");

  if(level.flagactivationdelay) {
    teamflag.trigger scripts\engine\utility::trigger_off();
    teamflagbase.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.icontarget, level.icontarget, level.mlgiconfullflag);
  } else {
    teamflagbase.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag);
  }

  return teamflagbase;
}

function setteaminhuddatafromteamname(teamname) {
  if(teamname == "axis") {
    self setteaminhuddata(1);
    return;
  }

  if(teamname == "allies") {
    self setteaminhuddata(2);
    return;
  }

  self setteaminhuddata(0);
}

function flagpickupchecks(player) {
  return !player scripts\cp_mp\utility\player_utility::isinvehicle();
}

function onpickup(player, playervo, defused) {
  self notify("picked_up");
  player notify("obj_picked_up");
  level.var_50a07cda9851d4b8.objectiveicon scripts\mp\gameobjects::setvisibleteam("none");
  level.var_21997fbea8438765.currentcarrier = player;
  player thread awardobjtimeforcarrier();
  ownerteam = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setownerteam(player.team);
  team = player.pers["team"];
  level.var_59a1f917fb3131a6 = team;

  if(team == "allies") {
    otherteam = "axis";
  } else {
    otherteam = "allies";
  }

  player attachflag();
  player incpersstat("pickups", 1);

  if(self.ownerteam == "allies") {
    setomnvar("ui_single_flag_loc", player getentitynumber());
  } else {
    setomnvar("ui_single_flag_loc", player getentitynumber());
  }

  player setclientomnvar("ui_flag_player_hud_icon", 1);

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0) {
      scripts\mp\gameobjects::setvisibleteam("none");
    } else {
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
  printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", player);

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_taken", team);
    scripts\mp\utility\dialog::leaderdialog("flag_getback", otherteam);
  }

  thread teamplayercardsplash("callout_flagpickup", player);
  player thread scripts\mp\hud_message::showsplash("flagpickup");

  if(!isDefined(self.previouscarrier) || self.previouscarrier != player) {
    player thread scripts\mp\utility\points::doscoreevent(#"flag_grab");
  }

  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.player = player;
  var_7e2c53b0bcf117d9.eventname = "pickup";
  var_7e2c53b0bcf117d9.position = player.origin;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
  self.previouscarrier = player;

  if(level.codcasterenabled) {
    player setgametypevip(1);
  }

  if(level.flagholdtimer > 0) {
    thread function_9962a01f46dd3b58(team);
  }
}

function returnflag() {
  scripts\mp\gameobjects::returnhome();
}

function ondrop(player) {
  if(isDefined(player.leaving_team)) {
    self.droppedteam = player.leaving_team;
    player.leaving_team = undefined;
  } else if(!isDefined(player)) {
    self.droppedteam = self.ownerteam;
  } else {
    self.droppedteam = player.team;
  }

  level.var_21997fbea8438765.currentcarrier = undefined;
  level.var_59a1f917fb3131a6 = "neutral";

  if(isDefined(player)) {
    player updatematchstatushintonnoflag();
  }

  scripts\mp\gameobjects::setownerteam("neutral");
  team = self.droppedteam;
  otherteam = getotherteam(self.droppedteam)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(self.pingobjidnum, "done");

  if(level.returntime >= 0) {
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag);
  } else {
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag);
    scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.objidnum, 1);
  }

  if(self.ownerteam == "allies") {
    setomnvar("ui_single_flag_loc", -1);
  } else {
    setomnvar("ui_single_flag_loc", -1);
  }

  if(isDefined(player)) {
    player setclientomnvar("ui_flag_player_hud_icon", 0);
  }

  if(isDefined(player)) {
    if(!isreallyalive(player)) {
      player.carryobject.previouscarrier = undefined;
    }

    if(isDefined(player.carryflag)) {
      player detachflag();
    }

    printandsoundoneveryone(otherteam, "none", undefined, undefined, "iw9_mp_ui_objective_lost", "", player);

    if(level.codcasterenabled) {
      player setgametypevip(0);
    }
  } else {
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);
  }

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_dropped", getotherteam(self.droppedteam)[0], "status");
    scripts\mp\utility\dialog::leaderdialog("flag_dropped", self.droppedteam, "status");
  }

  if(level.idleresettime > 0) {
    thread returnaftertime();
  }

  if(level.flagholdtimer > 0) {
    setomnvar("ui_obj_timer_stopped", 1);
    setomnvar("ui_obj_timer", 0);
    setomnvar("ui_obj_progress", 0);
  }
}

function returnaftertime() {
  self endon("picked_up");
  currentwaittime = 0;

  while(currentwaittime < level.idleresettime) {
    waitframe();

    if(self.claimteam == "none") {
      currentwaittime += level.framedurationseconds;
    }
  }

  foreach(team in level.teamnamelist) {
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", team);
  }

  scripts\mp\gameobjects::returnhome();
}

function onreset() {
  level.var_21997fbea8438765.currentcarrier = undefined;

  if(isDefined(level.var_21997fbea8438765.portable_radar)) {
    level.var_21997fbea8438765.portable_radar clearportableradar();
    level.var_21997fbea8438765.portable_radar delete();
  }

  if(isDefined(self.droppedteam)) {
    scripts\mp\gameobjects::setownerteam(self.droppedteam);
  }

  team = scripts\mp\gameobjects::getownerteam();
  otherteam = getotherteam(team)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);
  level.var_50a07cda9851d4b8.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", getotherteam(self.droppedteam)[0], "status");
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", self.droppedteam, "status");
  }

  self.droppedteam = undefined;

  if(self.ownerteam == "allies") {
    setomnvar("ui_single_flag_loc", -2);
  } else {
    setomnvar("ui_single_flag_loc", -2);
  }

  self.previouscarrier = undefined;
}

function attachflag() {
  updatematchstatushintonhasflag();
  otherteam = getotherteam(self.pers["team"])[0];
  self attach(level.carryflag[otherteam], "tag_stowed_back3", 1);
  self.carryflag = level.carryflag[otherteam];
}

function detachflag() {
  self detach(self.carryflag, "tag_stowed_back3");
  self.carryflag = undefined;
}

function updatematchstatushintonnoflag() {
  scripts\mp\hud_message::function_f004ef4606b9efdc("single_flag_cap");
}

function updatematchstatushintonhasflag() {
  scripts\mp\hud_message::function_f004ef4606b9efdc("single_flag_cap");
}

function awardobjtimeforcarrier(team) {
  level endon("game_ended");
  level.var_21997fbea8438765 endon("dropped");
  level.var_21997fbea8438765 endon("reset");
  level notify("objTimePointsRunning");
  level endon("objTimePointsRunning");

  while(!level.gameended) {
    wait 1;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!level.gameended) {
      level.var_21997fbea8438765.carrier incpersstat("objTime", 1);
      level.var_21997fbea8438765.carrier scripts\mp\persistence::statsetchild("round", "objTime", level.var_21997fbea8438765.carrier.pers["objTime"]);
      level.var_21997fbea8438765.carrier setextrascore0(level.var_21997fbea8438765.carrier.pers["objTime"]);
      level.var_21997fbea8438765.carrier scripts\mp\gamescore::giveplayerscore(#"hash_98bfd8d29c56bc08", 10);
    }
  }
}

function function_9962a01f46dd3b58(team) {
  flagholdtimer = int(gettime() + level.flagholdtimer * 1000);
  setomnvar("ui_obj_timer", flagholdtimer);
  setomnvar("ui_obj_progress", 1);
  setomnvar("ui_objective_timer_stopped", 0);
  level thread scripts\mp\hud_message::notifyteam("flag_force_hold_fr", "flag_force_hold_en", team);
  thread function_4d2db447ddf43e1(level.flagholdtimer);
  thread function_8028646f3cc80ac4();
}

function function_4d2db447ddf43e1(flagholdtimer) {
  level.var_21997fbea8438765 endon("dropped");
  currentprogress = flagholdtimer;

  while(!level.gameended) {
    setomnvar("ui_obj_progress", currentprogress / flagholdtimer);
    currentprogress -= level.framedurationseconds;
    wait level.framedurationseconds;
  }
}

function function_8028646f3cc80ac4() {
  level endon("game_ended");
  self endon("dropped");
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.flagholdtimer);
  level thread scripts\mp\gamelogic::endgame(level.var_21997fbea8438765 scripts\mp\gameobjects::getownerteam(), game["end_reason"]["ko_flag_hold_win"], game["end_reason"]["ko_flag_hold_loss"]);
}

function dogtagallyonusecb(player) {
  player.health = player.maxhealth;
  player notify("healed");
}

function dogtagenemyonusecb(player) {
  player.health = player.maxhealth;
  player notify("healed");
}

function outlineenemyplayers() {
  level endon("prematch_done");
  level endon("removeArenaOutlines");

  while(true) {
    level waittill("spawned_player");
    waitframe();

    foreach(player in level.players) {
      entnum = player getentitynumber();

      if(!isDefined(player.outlinedenemies)) {
        if(!isDefined(level.activeoutlines)) {
          level.activeoutlines = 1;
        } else {
          level.activeoutlines++;
        }
      }

      foreach(p in level.players) {
        if(p != player && p.team != player.team) {
          if(isDefined(player.outlinedenemies)) {
            outlinedisable(player.outlinedenemies, player);
          }

          player.outlinedenemies = outlineenableforteam(player, p.team, "outline_nodepth_orange", "level_script");
          break;
        }
      }
    }
  }
}

function removeenemyoutlines() {
  thread notifyremoveoutlines();
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(player in level.players) {
    entnum = player getentitynumber();

    if(isDefined(player.outlinedenemies)) {
      level.activeoutlines--;
      outlinedisable(player.outlinedenemies, player);
      player.outlinedenemies = undefined;
    }
  }
}

function notifyremoveoutlines() {
  level endon("prematch_done");
  level waittill("match_start_real_countdown");

  if(level.prematchperiodend > 5) {
    time = int(max(level.prematchperiodend - 5, 5));
  } else {
    time = int(max(level.prematchperiodend - 2, 2));
  }

  wait time;
  level notify("removeArenaOutlines");
}

function outlineequipmentwatchplayerprox(equipname) {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];
  basescore = level.baseraritymap[equipname];
  outlineasset = getoutlineasset(basescore, equipname);

  while(true) {
    foreach(player in level.players) {
      if(isDefined(player.hasarenaspawned)) {
        dist = distance2dsquared(self.origin, player.origin);
        entnum = player getentitynumber();

        if(dist < 490000) {
          if(!isDefined(self.outlinedplayers[entnum])) {
            if(!isDefined(level.activeoutlines)) {
              level.activeoutlines = 1;
            } else {
              level.activeoutlines++;
            }

            self.outlinedplayers[entnum] = outlineenableforplayer(self, player, outlineasset, "level_script");
          }

          continue;
        }

        if(isDefined(self.outlinedplayers[entnum])) {
          level.activeoutlines--;
          outlinedisable(self.outlinedplayers[entnum], self);
          self.outlinedplayers[entnum] = undefined;
        }
      }
    }

    waitframe();
  }
}

function outlinewatchplayerprox() {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];
  weapname = scripts\mp\weapons::getitemweaponname();
  rootname = getweaponrootname(weapname);
  basescore = level.baseraritymap[rootname + "_mp"];
  outlineasset = getoutlineasset(basescore);

  while(true) {
    foreach(player in level.players) {
      if(isDefined(player.hasarenaspawned)) {
        dist = distance2dsquared(self.origin, player.origin);
        entnum = player getentitynumber();

        if(dist < 490000) {
          if(!isDefined(self.outlinedplayers[entnum])) {
            if(!isDefined(level.activeoutlines)) {
              level.activeoutlines = 1;
            } else {
              level.activeoutlines++;
            }

            self.outlinedplayers[entnum] = outlineenableforplayer(self, player, outlineasset, "level_script");
          }

          continue;
        }

        if(isDefined(self.outlinedplayers[entnum])) {
          level.activeoutlines--;
          outlinedisable(self.outlinedplayers[entnum], self);
          self.outlinedplayers[entnum] = undefined;
        }
      }
    }

    waitframe();
  }
}

function getoutlineasset(basescore, equipname) {
  if(!isDefined(basescore)) {
    basescore = 0;
  }

  outlineasset = "white";
  score = int(min(basescore, 8));

  switch (score) {
    case 0:
      outlineasset = "outline_depth_white";
      break;
    case 1:
      outlineasset = "outline_depth_green";
      break;
    case 2:
      outlineasset = "outline_depth_cyan";
      break;
    case 3:
      outlineasset = "outline_depth_red";
      break;
    case 4:
      outlineasset = "outline_depth_orange";
      break;
    case 5:
      outlineasset = "outline_depth_yellow";
      break;
    case 6:
      outlineasset = "outline_depth_blue";
      break;
    case 7:
      outlineasset = "outline_depth_green";
      break;
    case 8:
      outlineasset = "outline_depth_red";
      break;
  }

  if(istrue(level.snowballfight) && isDefined(equipname) && equipname == "equip_pball") {
    outlineasset = "outline_depth_yellow";
  }

  return outlineasset;
}

function clearweaponoutlines() {
  foreach(value in self.outlinedplayers) {
    level.activeoutlines--;
    outlinedisable(value, self);
    value = undefined;
  }
}

function updatematchstatushintonspawn() {
  level endon("game_ended");
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");
}

function seticonnames() {
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

function setupwaypointicons() {
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

function isnormalloadouts() {
  return level.arenaloadouts == 1;
}

function israndomloadouts() {
  return level.arenaloadouts == 2 || scripts\mp\gametypes\arena::israndomarloadouts() || scripts\mp\gametypes\arena::israndomsmgloadouts() || scripts\mp\gametypes\arena::israndompistolloadouts() || scripts\mp\gametypes\arena::israndomshotgunloadouts() || scripts\mp\gametypes\arena::israndomsniperloadouts() || scripts\mp\gametypes\arena::israndomlmgloadouts() || scripts\mp\gametypes\arena::israndomblueprintsloadouts() || scripts\mp\gametypes\arena::israndomcustomblueprintsloadouts() || scripts\mp\gametypes\arena::israndomnoattachmentloadouts();
}

function ispickuploadouts() {
  return level.arenaloadouts == 3 || level.arenaloadouts == 14;
}

function isgungameloadouts() {
  return level.arenaloadouts == 4;
}

function isrvsgungameloadouts() {
  return level.arenaloadouts == 5;
}

function israndomarloadouts() {
  return level.arenaloadouts == 7;
}

function israndomsmgloadouts() {
  return level.arenaloadouts == 8;
}

function israndompistolloadouts() {
  return level.arenaloadouts == 9;
}

function israndomshotgunloadouts() {
  return level.arenaloadouts == 10;
}

function israndomsniperloadouts() {
  return level.arenaloadouts == 11;
}

function israndomlmgloadouts() {
  return level.arenaloadouts == 12;
}

function israndomblueprintsloadouts() {
  return level.arenaloadouts == 13;
}

function ispickupblueprintloadouts() {
  return level.arenaloadouts == 14;
}

function israndomcustomblueprintsloadouts() {
  return level.arenaloadouts == 15;
}

function israndomnoattachmentloadouts() {
  return level.arenaloadouts == 16;
}

function function_c0c1519b5cfb9bd5() {
  return scripts\mp\gametypes\arena::israndomblueprintsloadouts() || scripts\mp\gametypes\arena::ispickupblueprintloadouts() || scripts\mp\gametypes\arena::israndomcustomblueprintsloadouts();
}

function function_46a9ae30a3b356a8() {
  return level.objmodifier == 0;
}

function function_444e57e02c02bee6() {
  return level.objmodifier == 1;
}

function function_2eda32f1d16ded2c() {
  return level.objmodifier == 2;
}

function snowballfight() {
  if(istrue(game["practiceRound"]) || istrue(level.alwayssnowfight)) {
    level.lethaldelay = 0;
    defineplayerloadout();
  }

  initweaponmap();
  thread setupsnowballs();
}

function setupsnowballs() {
  level.arenaweapont1.weapon = "equip_snowball";

  if(!istrue(level.alwayssnowfight) && !istrue(game["practiceRound"])) {
    level.arenaweapont1.weapon = ter_op(cointoss(), level.arenaweapont1.weapon, "equip_snowball");
    level.arenaweapont2.weapon = ter_op(cointoss(), level.arenaweapont2.weapon, "equip_snowball");
    level.arenaweapont3.weapon = ter_op(cointoss(), level.arenaweapont3.weapon, "equip_snowball");
    level.arenaweapont4.weapon = ter_op(cointoss(), level.arenaweapont4.weapon, "equip_snowball");
    level.arenaweapont5.weapon = ter_op(cointoss(), level.arenaweapont5.weapon, "equip_snowball");
    level.arenaweapont6.weapon = ter_op(cointoss(), level.arenaweapont6.weapon, "equip_snowball");
    level.arenaweapont7.weapon = ter_op(cointoss(), level.arenaweapont7.weapon, "equip_snowball");
    level.arenaweapont8.weapon = ter_op(cointoss(), level.arenaweapont8.weapon, "equip_snowball");
  }

  level.pickedpball = 0;
  locs = getStructArray("weapon_pickup", "targetname");
  assertex(locs.size > 0, "<dev string:x30f>");

  foreach(loc in locs) {
    if(loc.script_label == "snowball" || loc.script_label == "pball" || istrue(game["practiceRound"]) || level.arenaloadouts != 3) {
      spawnweapon(loc, level.arenaweapont1);
    }
  }
}

function watchsnowballpickup(loc, snowtype) {
  self endon("death");
  self waittill("trigger", player, droppeditem);
  hasmaxammo = 0;
  issameequip = checkissameequip(player);
  equipammo = checkpickupequiptypeammocount(player);

  if(self.equipment == "equip_snowball") {
    var_8b9ab3abae98d973 = 9;
  } else {
    var_8b9ab3abae98d973 = 1;
  }

  var_b64209459da65860 = checkcurrentequiptypeammocount(player);
  var_d9f8a2bc44267f00 = 1;

  switch (snowtype) {
    case #"hash_8c759484936e9b6d":
      var_d9f8a2bc44267f00 = 10;
      break;
    case #"hash_b8a39a6acfe440c7":
      var_d9f8a2bc44267f00 = 5;
      break;
    case #"hash_66c094dee1aed032":
      var_d9f8a2bc44267f00 = 1;
      break;
    default:
      var_d9f8a2bc44267f00 = 1;
      break;
  }

  if(issameequip) {
    if(equipammo == var_8b9ab3abae98d973) {
      hasmaxammo = 1;
    }
  }

  if(issameequip && !hasmaxammo) {
    player scripts\mp\equipment::incrementequipmentammo(self.equipment, var_d9f8a2bc44267f00);
  } else if(var_b64209459da65860 && !issameequip && !isPlayer(loc)) {
    player dropoldequipinplace(player scripts\mp\equipment::getcurrentequipment(self.equiptype));
  }

  if(!issameequip) {
    player scripts\mp\equipment::giveequipment(self.equipment, self.equiptype);

    if(self.equipment == "equip_snowball" && !hasmaxammo) {
      player scripts\mp\equipment::incrementequipmentammo(self.equipment, var_d9f8a2bc44267f00);
    } else if(self.equipment == "equip_pball") {
      player scripts\mp\equipment::setequipmentammo(self.equipment, var_d9f8a2bc44267f00);
    }
  }

  if(issameequip && hasmaxammo) {
    player iprintlnbold(&"MP_INGAME_ONLY/EQUIPMENT_MAXED");
    thread watchsnowballpickup(loc, snowtype);
    return;
  }

  player playlocalsound("weap_snowball_pickup");
  playFX(level.snowfx["vanish"], self.origin);
  clearweaponoutlines();

  if(!isPlayer(loc) && snowtype != "pball") {
    level thread waitthenrespawnsnowballs(loc);
  }

  self makeunusable();
  self delete();
}

function waitthenrespawnsnowballs(loc) {
  level endon("game_ended");
  wait 15;
  playFX(level.snowfx["vanish"], loc.origin);
  spawnweapon(loc, level.arenaweapont1);
}

function snowballmeleewatcher() {
  level scripts\mp\flags::gameflagwait("prematch_done");
  wait 1;
  self allowmelee(0);
}

function getknivesoutsetting() {
  if(matchmakinggame()) {
    return getdvarint(@ "scr_arena_knivesout", 0);
  } else if(isthrowingknifeequipment(level.arenaweapont1.weapon) && isthrowingknifeequipment(level.arenaweapont2.weapon) && isthrowingknifeequipment(level.arenaweapont3.weapon) && isthrowingknifeequipment(level.arenaweapont4.weapon) && isthrowingknifeequipment(level.arenaweapont5.weapon) && isthrowingknifeequipment(level.arenaweapont6.weapon) && isthrowingknifeequipment(level.arenaweapont7.weapon) && isthrowingknifeequipment(level.arenaweapont8.weapon)) {
    if(isthrowingknifeequipment(level.startweapon.weapon)) {
      return 2;
    } else {
      return 1;
    }
  }

  return 0;
}

function isthrowingknifeequipment(weapon) {
  if(weapon == "equip_throwing_knife" || weapon == "equip_throwing_knife_fire" || weapon == "equip_throwing_knife_electric") {
    return 1;
  }

  return 0;
}

function fixupsupersandtacticalsforgunfightmaps() {
  switch (level.arenasuper) {
    case #"hash_699e6c3e460adde4":
    case #"hash_7266a252f51150e9":
    case #"hash_ac520bae8aaba66b":
      level.arenasuper = "super_ammo_drop";
      break;
    default:
      level.arenasuper = "none";
      break;
  }

  return level.arenasuper;
}

function function_57688e4a9f64765a(progress, team) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_c3ddfb0eaa8f761c = "";
    progress = int(floor(progress * 10));
    var_c3ddfb0eaa8f761c = "mp_dom_capturing_tick_0" + progress;
    self.visuals[0] playsoundtoteam(var_c3ddfb0eaa8f761c, team);
  }
}

function function_8cbda65b25d7573c() {
  if(game["roundsPlayed"] > 0) {
    self playlocalsound("jup_mode_gunfight_newloadout_fade_in");
    wait 4;
    self playlocalsound("jup_mode_gunfight_newloadout_fade_out");
    return;
  }

  return;
}

function function_da1f3979f22bb288(posorigin, alias, timer) {
  if(!isDefined(self.var_4efd1a215d3e63d6)) {
    playsoundatpos(posorigin, alias);
    self.var_4efd1a215d3e63d6 = 1;
    wait timer;
    self.var_4efd1a215d3e63d6 = undefined;
    return;
  }

  return;
}

function function_82b6a3e1bcda539b(posorigin, alias, timer) {
  if(!isDefined(self.var_e264252f7f1f6def)) {
    playsoundatpos(posorigin, alias);
    self.var_e264252f7f1f6def = 1;
    wait timer;
    self.var_e264252f7f1f6def = undefined;
    return;
  }

  return;
}

function private function_5a0a68144c7a97fd(equipmentname) {
  if(isDefined(equipmentname)) {
    switch (equipmentname) {
      case #"hash_25ac81b822cf0c9f":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_STIM";
        equipmentinfo.icon = "hud_icon_equipment_stim";
        equipmentinfo.worldmodel = "offhand_1h_wm_stim_v0";
        equipmentinfo.equiptype = "secondary";
        return equipmentinfo;
      case #"hash_3995658e01f4fac1":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_ATMINE";
        equipmentinfo.icon = "hud_icon_equipment_at_mine";
        equipmentinfo.worldmodel = "offhand_2h_wm_proximity_mine_v0";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
      case #"hash_e156752cb79526e8":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_BUNKERBUSTER";
        equipmentinfo.icon = "hud_icon_equipment_bunker_buster";
        equipmentinfo.worldmodel = "offhand_2h_wm_bunker_buster_v0";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
      case #"hash_4320d77f90725183":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_C4";
        equipmentinfo.icon = "hud_icon_equipment_c4";
        equipmentinfo.worldmodel = "offhand_2h_wm_c4_v0";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
      case #"hash_2354208d9af64220":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_CLAYMORE";
        equipmentinfo.icon = "hud_icon_equipment_claymore";
        equipmentinfo.worldmodel = "offhand_2h_wm_claymore_v0";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
      case #"hash_5fca4943a78ace9c":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_STUN";
        equipmentinfo.icon = "hud_icon_equipment_stun";
        equipmentinfo.worldmodel = "offhand_1h_wm_grenade_concussion_v0";
        equipmentinfo.equiptype = "secondary";
        return equipmentinfo;
      case #"hash_15d06a7d7efafe8":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_DECOY";
        equipmentinfo.icon = "hud_icon_equipment_decoy";
        equipmentinfo.worldmodel = "offhand_1h_wm_grenade_decoy_v0";
        equipmentinfo.equiptype = "secondary";
        return equipmentinfo;
      case #"hash_5a562592c930b7d6":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_FLASH";
        equipmentinfo.icon = "hud_icon_equipment_flash";
        equipmentinfo.worldmodel = "offhand_1h_wm_grenade_flash_v0";
        equipmentinfo.equiptype = "secondary";
        return equipmentinfo;
      case #"hash_8c7819f0a3fbd1e0":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_FRAG";
        equipmentinfo.icon = "hud_icon_equipment_frag";
        equipmentinfo.worldmodel = "offhand_2h_wm_grenade_frag_v0";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
      case #"hash_4b4a6458f00d9319":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_HB_SENSOR";
        equipmentinfo.icon = "hud_icon_equipment_hb_sensor";
        equipmentinfo.worldmodel = "offhand_1h_wm_tablet_v0";
        equipmentinfo.equiptype = "secondary";
        return equipmentinfo;
      case #"hash_142a787e36d7d7ce":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_MOLOTOV";
        equipmentinfo.icon = "hud_icon_equipment_molotov";
        equipmentinfo.worldmodel = "offhand_2h_wm_molotov_v0";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
      case #"hash_f0907f858c134cb4":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_SEMTEX";
        equipmentinfo.icon = "hud_icon_equipment_semtex";
        equipmentinfo.worldmodel = "offhand_2h_wm_grenade_semtex_v0";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
      case #"hash_8df9cfc147eb2d86":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_SHOCK_STICK";
        equipmentinfo.icon = "hud_icon_equipment_shock_stick";
        equipmentinfo.worldmodel = "offhand_1h_wm_shock_stick_v0";
        equipmentinfo.equiptype = "secondary";
        return equipmentinfo;
      case #"hash_fb6b649176cec75d":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_SMOKE";
        equipmentinfo.icon = "hud_icon_equipment_smoke";
        equipmentinfo.worldmodel = "offhand_1h_wm_grenade_smoke_v0";
        equipmentinfo.equiptype = "secondary";
        return equipmentinfo;
      case #"hash_4f62b5fa00ecd075":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_SNAPSHOT";
        equipmentinfo.icon = "hud_icon_equipment_snapshot";
        equipmentinfo.worldmodel = "offhand_1h_wm_grenade_snapshot_v0";
        equipmentinfo.equiptype = "secondary";
        return equipmentinfo;
      case #"hash_de4641ddbc44a7ba":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_THERMITE";
        equipmentinfo.icon = "hud_icon_equipment_thermite";
        equipmentinfo.worldmodel = "offhand_2h_wm_grenade_thermite_v0";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
      case #"hash_9ba0a6ff6081954e":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_TKNIFE";
        equipmentinfo.icon = "hud_icon_equipment_throwing_knife";
        equipmentinfo.worldmodel = "offhand_2h_wm_throwing_knife_v0";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
      case #"hash_61206775eae1c854":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PICKUP_TSTAR";
        equipmentinfo.icon = "hud_icon_equipment_shuriken";
        equipmentinfo.worldmodel = "offhand_2h_wm_throw_star_v0";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
      case #"hash_3923e5c5f4d1f90a":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/SNOWBALL_PICKUP";
        equipmentinfo.icon = "hud_icon_equipment_snowball";
        equipmentinfo.worldmodel = "decor_snowball_pyramid_01";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
      case #"hash_3e0c07b5bc9dac1":
        equipmentinfo = spawnStruct();
        equipmentinfo.pickupstring = &"MP_INGAME_ONLY/PBALL_PICKUP";
        equipmentinfo.icon = "hud_icon_equipment_snowball_pball";
        equipmentinfo.worldmodel = "weapon_wm_snowball_urine";
        equipmentinfo.equiptype = "primary";
        return equipmentinfo;
    }
  }

  return undefined;
}

function private getweaponcategories() {
  return ["ar", "br", "dm", "lm", "pi", "sh", "sm", "sn"];
}

function private function_f8be37b178efc473(weaponcategory) {
  if(isDefined(weaponcategory)) {
    switch (weaponcategory) {
      case #"hash_d4f05e450448c3ec":
      case #"hash_fa18d2f6bd57925a":
        return "ar";
      case #"hash_747e7494f126391f":
      case #"hash_fa21c4f6bd5e3815":
        return "br";
      case #"hash_f4b0076c03d93738":
      case #"hash_fa0ed9f6bd4f4e9a":
        return "dm";
      case #"hash_339227cb650975db":
        return "lethal";
      case #"hash_2f2d546c2247838f":
      case #"hash_fa27b9f6bd62a3f2":
        return "lm";
      case #"hash_719417cb1de832b6":
      case #"hash_fa4dbdf6bd80bf52":
        return "pi";
      case #"hash_690c0d6a821b42e":
      case #"hash_fa50b4f6bd82efbe":
        return "sh";
      case #"hash_900cb96c552c5e8e":
      case #"hash_fa50b9f6bd82f79d":
        return "sm";
      case #"hash_6191aaef9f922f96":
      case #"hash_fa50b6f6bd82f2e4":
        return "sn";
      case #"hash_850999d7864fa3b4":
        return "tactical";
    }
  }

  return undefined;
}

function private getrandomweaponforweapontier(weapontier) {
  if(issubstr(weapontier, "rand")) {
    if(weapontier == "random") {
      return scripts\mp\gametypes\arena::getrandomweapon();
    }

    tokens = strtok(weapontier, "_", 1);
    assertex(isDefined(tokens) && tokens.size == 2 && tokens[0] == "<dev string:x3cc>", "<dev string:x3d4>" + weapontier);
    weaponcategory = scripts\mp\gametypes\arena::function_f8be37b178efc473(tokens[1]);
    assertex(isDefined(weaponcategory), "<dev string:x3f9>" + weaponcategory + "<dev string:x41d>" + weapontier);
    return scripts\mp\gametypes\arena::getrandomweaponfromcategory(weaponcategory);
  }

  return weapontier;
}

function private getrandomweapon() {
  weaponcategory = scripts\engine\utility::array_random(scripts\mp\gametypes\arena::getweaponcategories());
  return scripts\mp\gametypes\arena::getrandomweaponfromcategory(weaponcategory);
}

function private getrandomweaponfromcategory(weaponcategory) {
  if(!isDefined(game["arenaWeaponCategories"])) {
    return "none";
  }

  if(!isDefined(game["arenaWeaponCategories"][weaponcategory]) || game["arenaWeaponCategories"][weaponcategory].size == 0) {
    return "none";
  }

  return scripts\engine\utility::array_random(game["arenaWeaponCategories"][weaponcategory]);
}

function function_11a6a3ec5c206652(weaponname) {
  if(!isDefined(game["arenaWeapons"]) || !isDefined(game["arenaWeapons"][weaponname])) {
    return -1;
  }

  if(game["arenaWeapons"][weaponname].blueprints.size > 0) {
    randomblueprint = scripts\engine\utility::array_random(game["arenaWeapons"][weaponname].blueprints);
    return randomblueprint.id;
  }

  return -1;
}

function private function_10cea0880b71973a() {
  if(!isDefined(game["arenaWeaponCategories"])) {
    game["arenaWeaponCategories"] = [];
  }

  game["arenaWeaponCategories"]["lethal"] = [];
  game["arenaWeaponCategories"]["tactical"] = [];
  var_4fb2a4f952c69478 = "arena_equipment_table_lethal_iw9_mp";
  var_ab30739970abc53 = getscriptbundle(hashcat(%"hash_49799bd1f8bda011", var_4fb2a4f952c69478));
  assertex(isDefined(var_ab30739970abc53), "<dev string:x438>" + var_4fb2a4f952c69478);

  if(isDefined(var_ab30739970abc53)) {
    foreach(equipment in var_ab30739970abc53.equipmentlist) {
      game["arenaWeaponCategories"]["lethal"][game["arenaWeaponCategories"]["lethal"].size] = equipment.equipmentname;
    }
  }

  var_8ef2530a2b79d56f = "arena_equipment_table_tactical_iw9_mp";
  var_5cec6ca6494b24 = getscriptbundle(hashcat(%"hash_49799bd1f8bda011", var_8ef2530a2b79d56f));
  assertex(isDefined(var_5cec6ca6494b24), "<dev string:x438>" + var_8ef2530a2b79d56f);

  if(isDefined(var_5cec6ca6494b24)) {
    foreach(equipment in var_5cec6ca6494b24.equipmentlist) {
      game["arenaWeaponCategories"]["tactical"][game["arenaWeaponCategories"]["tactical"].size] = equipment.equipmentname;
    }
  }
}

function function_b7c18ded2347456c() {
  if(!isDefined(game["arenaWeaponCategories"])) {
    game["arenaWeaponCategories"] = [];
  }

  weaponcategories = scripts\mp\gametypes\arena::getweaponcategories();
  projectname = tolower(getprojectname()) + "_mp";

  foreach(weaponcategory in weaponcategories) {
    game["arenaWeaponCategories"][weaponcategory] = [];
    weapontablename = scripts\engine\utility::string_join(["arena_weapon_table", weaponcategory, projectname], "_");
    var_e1898741919f6aaf = getscriptbundle(hashcat(%"hash_6946961762bbe55b", weapontablename));
    assertex(isDefined(var_e1898741919f6aaf), "<dev string:x47a>" + weapontablename);

    if(!isDefined(var_e1898741919f6aaf)) {
      continue;
    }

    foreach(weapon in var_e1898741919f6aaf.weaponlist) {
      weaponrootname = scripts\mp\gametypes\arena::function_d0fb12b63980c3a4(weapon.var_a5e6a8a5e3c7b581);

      if(isDefined(weaponrootname) && weaponrootname != "none") {
        game["arenaWeaponCategories"][weaponcategory][game["arenaWeaponCategories"][weaponcategory].size] = weaponrootname;
      }
    }
  }
}

function private function_de46980d57f0c37a() {
  weaponcategories = [];
  var_6bbf329f0b15a970 = !scripts\mp\gametypes\arena::israndomarloadouts() && !scripts\mp\gametypes\arena::israndomsmgloadouts() && !scripts\mp\gametypes\arena::israndomlmgloadouts() && !scripts\mp\gametypes\arena::israndompistolloadouts() && !scripts\mp\gametypes\arena::israndomshotgunloadouts() && !scripts\mp\gametypes\arena::israndomsniperloadouts();

  if(istrue(var_6bbf329f0b15a970) || scripts\mp\gametypes\arena::israndomarloadouts()) {
    weaponcategories[weaponcategories.size] = "ar";
    weaponcategories[weaponcategories.size] = "br";
  }

  if(istrue(var_6bbf329f0b15a970) || scripts\mp\gametypes\arena::israndomsmgloadouts()) {
    weaponcategories[weaponcategories.size] = "sm";
  }

  if(istrue(var_6bbf329f0b15a970) || scripts\mp\gametypes\arena::israndomlmgloadouts()) {
    weaponcategories[weaponcategories.size] = "lm";
  }

  if(istrue(var_6bbf329f0b15a970) || scripts\mp\gametypes\arena::israndompistolloadouts()) {
    weaponcategories[weaponcategories.size] = "pi";
  }

  if(istrue(var_6bbf329f0b15a970) || scripts\mp\gametypes\arena::israndomshotgunloadouts()) {
    weaponcategories[weaponcategories.size] = "sh";
  }

  if(istrue(var_6bbf329f0b15a970) || scripts\mp\gametypes\arena::israndomsniperloadouts()) {
    weaponcategories[weaponcategories.size] = "sn";
    weaponcategories[weaponcategories.size] = "dm";
  }

  projectname = tolower(getprojectname()) + "_mp";

  foreach(weaponcategory in weaponcategories) {
    classtablename = scripts\engine\utility::string_join(["arena_class_table", weaponcategory, projectname], "_");
    var_6ab15b7ea89d055d = getscriptbundle(hashcat(%"hash_2e0802494805f439", classtablename));
    assertex(isDefined(var_6ab15b7ea89d055d), "<dev string:x4b9>" + classtablename);

    if(!isDefined(var_6ab15b7ea89d055d)) {
      continue;
    }

    foreach(class in var_6ab15b7ea89d055d.classlist) {
      scripts\mp\gametypes\arena::function_c20500181ea66dc8(class.classtableentry);
    }
  }
}

function private function_d0fb12b63980c3a4(var_a5e6a8a5e3c7b581) {
  assertex(isDefined(level.weaponmapdata), "<dev string:x4f7>");

  if(!isDefined(level.weaponmapdata)) {
    return "none";
  }

  if(!isDefined(var_a5e6a8a5e3c7b581) || var_a5e6a8a5e3c7b581 == "") {
    return "none";
  }

  var_ad06b30a27981c99 = getscriptbundle(hashcat(%"hash_318bec5c5fa0dd65", var_a5e6a8a5e3c7b581));
  assertex(isDefined(var_ad06b30a27981c99), "<dev string:x51e>" + var_a5e6a8a5e3c7b581);

  if(!isDefined(var_ad06b30a27981c99)) {
    return "none";
  }

  if(!isDefined(game["arenaWeapons"])) {
    game["arenaWeapons"] = [];
  } else if(isDefined(game["arenaWeapons"][var_ad06b30a27981c99.rootname])) {
    return var_ad06b30a27981c99.rootname;
  }

  game["arenaWeapons"][var_ad06b30a27981c99.rootname] = spawnStruct();
  game["arenaWeapons"][var_ad06b30a27981c99.rootname].rootname = var_ad06b30a27981c99.rootname;
  game["arenaWeapons"][var_ad06b30a27981c99.rootname].blueprints = [];

  if(scripts\mp\gametypes\arena::function_c0c1519b5cfb9bd5()) {
    blueprints = getweaponblueprintnames(level.weaponmapdata[var_ad06b30a27981c99.rootname].assetname);

    foreach(blueprintname, blueprintid in blueprints) {
      foreach(allowedblueprint in var_ad06b30a27981c99.blueprintlist) {
        if(allowedblueprint.blueprintname == blueprintname) {
          blueprintindex = game["arenaWeapons"][var_ad06b30a27981c99.rootname].blueprints.size;
          game["arenaWeapons"][var_ad06b30a27981c99.rootname].blueprints[blueprintindex] = spawnStruct();
          game["arenaWeapons"][var_ad06b30a27981c99.rootname].blueprints[blueprintindex].name = blueprintname;
          game["arenaWeapons"][var_ad06b30a27981c99.rootname].blueprints[blueprintindex].id = blueprintid;
        }
      }
    }
  }

  return var_ad06b30a27981c99.rootname;
}

function private function_c20500181ea66dc8(classtableentry) {
  if(!isDefined(classtableentry)) {
    return;
  }

  var_344c92bda1a2ddfb = getscriptbundle(hashcat(%"hash_7af4f547630fa97", classtableentry));
  assertex(isDefined(var_344c92bda1a2ddfb), "<dev string:x563>" + classtableentry);

  if(!isDefined(var_344c92bda1a2ddfb)) {
    return;
  }

  var_28abc316a4b48e40 = !scripts\mp\gametypes\arena::israndomnoattachmentloadouts();

  if(!isDefined(game["arenaLoadouts"])) {
    game["arenaLoadouts"] = [];
  }

  loadoutindex = game["arenaLoadouts"].size;
  var_cd5f58507f5977d2 = scripts\mp\gametypes\arena::function_d0fb12b63980c3a4(var_344c92bda1a2ddfb.primaryweapon.var_a5e6a8a5e3c7b581);

  if(!isDefined(var_cd5f58507f5977d2) || var_cd5f58507f5977d2 == "none") {
    return;
  }

  var_31fa4bcdedee4712 = scripts\mp\gametypes\arena::function_d0fb12b63980c3a4(var_344c92bda1a2ddfb.secondaryweapon.var_a5e6a8a5e3c7b581);

  if(!isDefined(var_31fa4bcdedee4712)) {
    return;
  }

  if(scripts\mp\gametypes\arena::function_c0c1519b5cfb9bd5()) {
    if(!isDefined(game["arenaWeapons"][var_cd5f58507f5977d2].blueprints) || game["arenaWeapons"][var_cd5f58507f5977d2].blueprints.size == 0) {
      return;
    }

    if(var_31fa4bcdedee4712 != "none" && (!isDefined(game["arenaWeapons"][var_31fa4bcdedee4712].blueprints) || game["arenaWeapons"][var_31fa4bcdedee4712].blueprints.size == 0)) {
      return;
    }
  }

  game["arenaLoadouts"][loadoutindex]["loadoutPrimary"] = var_cd5f58507f5977d2;
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.primaryweapon.attachment1, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment1"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.primaryweapon.attachment2, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment2"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.primaryweapon.attachment3, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment3"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.primaryweapon.attachment4, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment4"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.primaryweapon.attachment5, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAttachment5"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.primaryweapon.attachment6, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryCamo"] = var_344c92bda1a2ddfb.primaryweapon.camo;
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryReticle"] = var_344c92bda1a2ddfb.primaryweapon.reticle;
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryVariantID"] = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(var_cd5f58507f5977d2);
  game["arenaLoadouts"][loadoutindex]["loadoutPrimaryAddBlueprintAttachments"] = function_c0c1519b5cfb9bd5();
  game["arenaLoadouts"][loadoutindex]["loadoutSecondary"] = var_31fa4bcdedee4712;
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.secondaryweapon.attachment1, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment1"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.secondaryweapon.attachment2, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment2"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.secondaryweapon.attachment3, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment3"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.secondaryweapon.attachment4, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment4"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.secondaryweapon.attachment5, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAttachment5"] = scripts\engine\utility::ter_op(var_28abc316a4b48e40, var_344c92bda1a2ddfb.secondaryweapon.attachment6, "none");
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryCamo"] = var_344c92bda1a2ddfb.secondaryweapon.camo;
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryReticle"] = var_344c92bda1a2ddfb.secondaryweapon.reticle;
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryVariantID"] = scripts\mp\gametypes\arena::function_11a6a3ec5c206652(var_31fa4bcdedee4712);
  game["arenaLoadouts"][loadoutindex]["loadoutSecondaryAddBlueprintAttachments"] = function_c0c1519b5cfb9bd5();
  game["arenaLoadouts"][loadoutindex]["loadoutEquipmentPrimary"] = var_344c92bda1a2ddfb.equipment1;
  game["arenaLoadouts"][loadoutindex]["loadoutEquipmentSecondary"] = var_344c92bda1a2ddfb.equipment2;
  game["arenaLoadouts"][loadoutindex]["loadoutFieldUpgrade1"] = var_344c92bda1a2ddfb.fieldupgrade1;
  game["arenaLoadouts"][loadoutindex]["loadoutFieldUpgrade2"] = var_344c92bda1a2ddfb.fieldupgrade2;
  game["arenaLoadouts"][loadoutindex]["loadoutPerks"] = [];
  game["arenaLoadouts"][loadoutindex]["loadoutPerks"][0] = var_344c92bda1a2ddfb.perk1;
  game["arenaLoadouts"][loadoutindex]["loadoutPerks"][1] = var_344c92bda1a2ddfb.perk2;
  game["arenaLoadouts"][loadoutindex]["loadoutPerks"][2] = var_344c92bda1a2ddfb.perk3;
  game["arenaLoadouts"][loadoutindex]["loadoutPerks"][3] = var_344c92bda1a2ddfb.perk4;
  game["arenaLoadouts"][loadoutindex]["loadoutGesture"] = "playerdata";
  game["arenaLoadouts"][loadoutindex]["loadoutExecution"] = "playerdata";
}

function private function_ee47e658f5b6314e() {
  level endon("<dev string:x5a7>");
  setDvar(@ "hash_886f8f08dbf3df5f", "<dev string:x36e>");

  while(true) {
    waitframe();
    dvarvalue = getDvar(@ "hash_886f8f08dbf3df5f");

    if(dvarvalue == "<dev string:x36e>") {
      continue;
    }

    setDvar(@ "hash_886f8f08dbf3df5f", "<dev string:x36e>");
    tokens = strtok(dvarvalue, "<dev string:x5b5>");

    if(!isDefined(tokens) || tokens.size == 0) {
      continue;
    }

    command = tokens[0];
    arglist = scripts\engine\utility::array_slice(tokens, 1);
    player = level.players[0];

    if(!isDefined(player)) {
      continue;
    }

    switch (command) {
      case #"hash_358fc11dad418a55":
        if(arglist.size == 0) {
          player notify("<dev string:x5cf>");
        } else if(arglist.size < 1 || int(arglist[0]) < 1) {
          iprintlnbold("<dev string:x5ee>");
        } else {
          thread function_c452035f58a6ad0e(player, int(arglist[0]));
        }

        break;
      case #"hash_9d9755ce454b0010":
        if(arglist.size == 0) {
          player notify("<dev string:x635>");
          player notify("<dev string:x65a>");
        } else if(arglist.size < 1 || int(arglist[0]) < 1) {
          iprintlnbold("<dev string:x682>");
        } else {
          thread function_5dd6bdb4dfced5ba(player, int(arglist[0]));
        }

        break;
      case #"hash_4db5d4970492f541":
        if(arglist.size == 0) {
          player notify("<dev string:x65a>");
        } else if(arglist.size < 2 || arglist[0] == "<dev string:x36e>" || int(arglist[1]) < 1) {
          iprintlnbold("<dev string:x6d2>");
        } else {
          thread function_d70a085b24e94e4b(player, arglist[0], int(arglist[1]));
        }

        break;
      default:
        iprintlnbold("<dev string:x715>" + command);
        break;
    }
  }
}

function private function_c452035f58a6ad0e(player, timeinterval) {
  level endon("<dev string:x5a7>");
  player endon("<dev string:x72a>");
  player notify("<dev string:x5cf>");
  player endon("<dev string:x5cf>");

  if(!isDefined(game["<dev string:x29f>"])) {
    error("<dev string:x741>");
    return;
  }

  level.perks_suppressasserts = 1;
  thread function_bac839c909252aeb(player, "<dev string:x5cf>", player.pers["<dev string:x777>"]);

  for(i = 0; i < game["<dev string:x29f>"].size; i++) {
    player.pers["<dev string:x777>"] = game["<dev string:x29f>"][i];
    player scripts\mp\class::giveloadout(player.team, "<dev string:x78a>");
    wait timeinterval;
  }

  player notify("<dev string:x5cf>");
  level.perks_suppressasserts = 0;
}

function private function_5dd6bdb4dfced5ba(player, timeinterval) {
  level endon("<dev string:x5a7>");
  player endon("<dev string:x72a>");
  player notify("<dev string:x635>");
  player endon("<dev string:x635>");

  if(!isDefined(game["<dev string:x796>"])) {
    error("<dev string:x7a6>");
    return;
  }

  foreach(weapon in game["<dev string:x796>"]) {
    function_d70a085b24e94e4b(player, weapon.rootname, timeinterval);
  }
}

function private function_d70a085b24e94e4b(player, weaponname, timeinterval) {
  level endon("<dev string:x5a7>");
  player endon("<dev string:x72a>");
  player notify("<dev string:x65a>");
  player endon("<dev string:x65a>");

  if(!isDefined(game["<dev string:x796>"])) {
    error("<dev string:x7f7>");
    return;
  }

  weapon = game["<dev string:x796>"][weaponname];

  if(!isDefined(weapon)) {
    error("<dev string:x84b>");
    return;
  }

  primaryweaponobject = player.primaryweaponobj;
  player scripts\cp_mp\utility\inventory_utility::_takeweapon(primaryweaponobject);
  thread function_a554b9ddc3d15ec5(player, "<dev string:x65a>", primaryweaponobject);

  for(i = 0; i < weapon.blueprints.size; i++) {
    weaponobject = scripts\cp_mp\weapon::buildweapon_blueprint(weaponname, undefined, undefined, weapon.blueprints[i].id);
    player scripts\cp_mp\utility\inventory_utility::_giveweapon(weaponobject);
    player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weaponobject);
    wait timeinterval;
    player scripts\cp_mp\utility\inventory_utility::_takeweapon(weaponobject);
  }

  player notify("<dev string:x65a>");
}

function private function_bac839c909252aeb(player, notifystring, loadout) {
  level endon("<dev string:x5a7>");
  player endon("<dev string:x72a>");
  player waittill(notifystring);
  player.pers["<dev string:x777>"] = loadout;
  player scripts\mp\class::giveloadout(player.team, "<dev string:x78a>");
}

function private function_a554b9ddc3d15ec5(player, notifystring, weaponobject) {
  level endon("<dev string:x5a7>");
  player endon("<dev string:x72a>");
  player waittill(notifystring);
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(weaponobject);
  player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weaponobject);
}

# /