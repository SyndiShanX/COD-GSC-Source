/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\ko.gsc
***********************************************/

#using script_4a6760982b403bad;
#using script_548072087c9fd504;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arm;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\ko;
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
#using scripts\mp\teamrevive;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace ko;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  level.var_904f766b5267e332 = 0;
  matchmakingmatch = getdvarint(@ "onlinegame") && !getdvarint(@ "xblive_privatematch");

  if(matchmakingmatch) {
    level.var_904f766b5267e332 = getdvarint(@ "hash_2c1108728124dd3", 0);
  }

  level.var_904f766b5267e332 = getdvarint(@ "hash_2c1108728124dd3", 0);

  level.allowmodestructs = [];

  if(level.var_904f766b5267e332) {
    level.allowmodestructs[level.allowmodestructs.size] = "arm";
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();

  if(istrue(level.var_904f766b5267e332)) {
    allowed[allowed.size] = "arm";
  }

  level.var_82bd227d5fb7e96f = [];

  if(istrue(level.var_904f766b5267e332)) {
    possibleents = getEntArray("gw_fob_03", "targetname");
    level.var_82bd227d5fb7e96f = possibleents[0].origin;
  } else {
    var_58553518a66cebe9 = getEntArray("cyber_emp_pickup_trig", "targetname");

    foreach(trig in var_58553518a66cebe9) {
      level.var_82bd227d5fb7e96f[level.var_82bd227d5fb7e96f.size] = trig.origin;
    }

    if(level.var_82bd227d5fb7e96f.size == 0) {
      level.var_82bd227d5fb7e96f[0] = (0, 0, 0);
      primaryflags = getEntArray("flag_primary", "targetname");

      foreach(flag in primaryflags) {
        if(flag.script_label == "_b") {
          level.var_82bd227d5fb7e96f[0] = flag.origin;
          break;
        }
      }
    }
  }

  for(i = 0; i < level.var_82bd227d5fb7e96f.size; i++) {
    level.var_82bd227d5fb7e96f[i] = scripts\mp\gametypes\ko::function_593bf7ddbfe1739f(level.var_82bd227d5fb7e96f[i]);
  }

  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 2, 0, 12);
    registertimelimitdvar(getgametype(), 90);
    registerscorelimitdvar(getgametype(), 1);
    registerroundlimitdvar(getgametype(), 0);
    registerwinlimitdvar(getgametype(), 5);
    registernumlivesdvar(getgametype(), 1);
    registerhalftimedvar(getgametype(), 0);
    registerwinbytwoenableddvar(getgametype(), 1);
    registerwinbytwomaxroundsdvar(getgametype(), 4);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  println("<dev string:x1c>" + gettime());
  level.nobuddyspawns = 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.modeonspawnplayer = &onspawnplayer;
  level.onplayerconnect = &onplayerconnect;
  level.onplayerkilled = &onplayerkilled;
  level.ondeadevent = &ondeadevent;
  level.ononeleftevent = &ononeleftevent;
  level.ontimelimit = &ontimelimit;
  level.onnormaldeath = &onnormaldeath;
  level.onobjectivecomplete = &function_983348e55e3f3e5;
  level.onmaprestart = &function_ba7699d705fb8850;
  level.var_ca4e08767cbdae12 = &function_bd59438ee37ccc48;
  level.allowlatecomers = 0;
  game["canScoreOnTie"] = 0;

  if(level.var_904f766b5267e332) {
    level.requiredplayercountoveride = 1;
    level.requiredplayercount["allies"] = 12;
    level.requiredplayercount["axis"] = 12;
    level.modecontrolledvehiclespawningonly = 1;
    level.maxhqtanks = 0;
    level.numnonrallyvehicles = getdvarint(@ "hash_f2200f106d1b98be", 25);
    level.skipplaybodycountsound = 1;
    mapname = scripts\cp_mp\utility\game_utility::getmapname();

    switch (mapname) {
      case #"hash_12f3765ef24b4037":
      case #"hash_1bc93b88575e82eb":
      case #"hash_32eaa112f8caa7e4":
      case #"hash_3a8b050ff58578ad":
      case #"hash_50de71be6e7469ff":
      case #"hash_7a28db3c5928c489":
      case #"hash_863773b8960b3944":
      case #"hash_924a3fbe9fbe15c6":
      case #"hash_e4ca6b73b5022b26":
        scripts\cp_mp\parachute::initparachutedvars();
        break;
      default:
        break;
    }

    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (mapname) {
        case #"hash_32eaa112f8caa7e4":
          setDvar(@ "hash_6beec004cdf37c0", 6);
          break;
        case #"hash_7a28db3c5928c489":
          setDvar(@ "hash_6beec004cdf37c0", 5);
          break;
        case #"hash_50de71be6e7469ff":
        case #"hash_863773b8960b3944":
          setDvar(@ "hash_6beec004cdf37c0", 9);
          break;
        case #"hash_12f3765ef24b4037":
          setDvar(@ "hash_6beec004cdf37c0", 3);
          break;
        case #"hash_924a3fbe9fbe15c6":
          setDvar(@ "hash_6beec004cdf37c0", 4);
          break;
        case #"hash_a8b272dba33a4aed":
          setDvar(@ "hash_6beec004cdf37c0", 17);
          break;
        case #"hash_1bc93b88575e82eb":
          setDvar(@ "hash_6beec004cdf37c0", 18);
          break;
        case #"hash_e4ca6b73b5022b26":
          setDvar(@ "hash_6beec004cdf37c0", 10);
          break;
        case #"hash_3a8b050ff58578ad":
          setDvar(@ "hash_6beec004cdf37c0", 19);
          break;
        default:
          setDvar(@ "hash_6beec004cdf37c0", 0);
          break;
      }
    }
  }

  if(getdvarint(@ "hash_a317fbbcde464162", 1) == 1) {
    if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
      game["dialog"]["gametype"] = "iw9_kout_mode_uktl_kot1";
    } else {
      game["dialog"]["gametype"] = "iw9_kout_mode_uktl_name";
    }

    if(!isDefined(game["roundsPlayed"])) {
      boostvo = "iw9_kout_mode_uktl_bost";
    } else {
      boostvo = "iw9_kout_mode_uktl_bosh";
    }

    game["dialog"]["offense_obj"] = boostvo;
    game["dialog"]["defense_obj"] = boostvo;
  }

  game["dialog"]["ko_flag_returned"] = "iw9_kout_mode_uktl_kffr";
  game["dialog"]["ko_flag_get_nag"] = "iw9_kout_mode_uktl_kfgn";
  game["dialog"]["ko_we_got_flag"] = "iw9_kout_mode_uktl_kfft";
  game["dialog"]["ko_we_dropped_flag"] = "iw9_kout_mode_uktl_kffd";
  game["dialog"]["ko_you_got_flag"] = "iw9_kout_mode_uktl_kffy";
  game["dialog"]["ko_enemy_got_flag"] = "iw9_kout_mode_uktl_kfet";
  game["dialog"]["ko_enemy_dropped_flag"] = "iw9_kout_mode_uktl_kfed";
  setomnvar("ui_single_flag_loc", -3);
  function_423b7147b1256abd();

  if(getgametypenumlives() == 1) {
    setDvar(@ "scr_player_laststand", 2);
  }

  level.reinitspawns = &reinitspawns;
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_265155622cfa46da", getmatchrulesdata("koData", "flagHoldTimer"));
  setdynamicdvar(@ "hash_678896df033b3202", getmatchrulesdata("koData", "flagHoldReward"));
  setdynamicdvar(@ "hash_a3ff29a46a657a08", getmatchrulesdata("koData", "flagForceTimer"));
  setdynamicdvar(@ "hash_c37decc9e0687c6f", getmatchrulesdata("koData", "flagActivationDelay"));
  setdynamicdvar(@ "hash_ee5e8807905fa36b", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar(@ "hash_bdcd309276a56476", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar(@ "hash_25905f240af754f6", getmatchrulesdata("carryData", "manualDropEnabled"));
  setdynamicdvar(@ "hash_e3d6ccc4d0424812", 0);
  registerhalftimedvar(getgametype(), 0);
  setdynamicdvar(@ "hash_9e0793789dcb8c02", 0);
}

function private function_593bf7ddbfe1739f(position) {
  switch (level.mapname) {
    case #"hash_d5e3eef5b3e1d004":
      if(distance(position, (-391, 6685, 310)) < 10) {
        position += (0, 36, 0);
      } else if(distance(position, (-387, 4569, 373)) < 10) {
        position += (-7, -77, 0);
      } else if(distance(position, (-356, 5432, 375)) < 10) {
        position += (2, 65, 0);
      }

      break;
    default:
      break;
  }

  return position;
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

  setomnvar("ui_obj_timer_stopped", 1);
  setomnvar("ui_obj_timer", 0);
  setomnvar("ui_obj_progress", 0);

  if(level.var_904f766b5267e332) {
    thread adjustroundendtimer();
    thread scripts\mp\gametypes\arm_vehicles::init_groundwarvehicles();
    thread initvehicles();
    scripts\mp\gametypes\arm::emergency_cleanupents();
  }

  function_e4cc1e6807cb2252();
  scripts\mp\gametypes\bradley_spawner::inittankspawns();

  if(false) {
    function_bf2918399f1800b1();
  }
}

function function_4963c847ffc21a21(objective, waittime) {
  level endon("game_ended");
  objective endon("death");
  objective scripts\mp\objidpoolmanager::objective_set_pulsate(objective.objidnum, 1);
  wait waittime;
  objective scripts\mp\objidpoolmanager::objective_set_pulsate(objective.objidnum, 0);
}

function adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 8;
}

function waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!level.var_904f766b5267e332) {
    level.overrideingraceperiod = 1;
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.flagholdtimer = dvarfloatvalue("flagHoldTimer", 0, 0, 120);
  level.flagholdreward = dvarfloatvalue("flagHoldReward", 0, 0, 1);
  level.flagforcetimer = dvarfloatvalue("flagForceTimer", 0, 0, 120);
  level.flagactivationdelay = dvarfloatvalue("flagActivationDelay", 10, 0, 30);
  level.showenemycarrier = dvarintvalue("showEnemyCarrier", 5, 0, 6);
  level.idleresettime = dvarfloatvalue("idleResetTime", 15, 0, 60);
  level.drawsuntilbothscore = dvarintvalue("drawsUntilBothScore", 3, 0, 5);
}

function function_423b7147b1256abd() {
  delaytime = getdvarint(@ "hash_6e2a3ed599309faa", 15);

  if(delaytime > 0) {
    level.var_423b7147b1256abd = 1;
    level waittill("prematch_done");
    level endon("game_ended");
    wait delaytime;
    level.var_423b7147b1256abd = 0;
  }
}

function initspawns() {
  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    level.gamemodestartspawnpointnames = [];
    var_48501209a3e177a7 = "mp_gw_spawn_allies_start";
    var_ae7d0107ad485428 = "mp_gw_spawn_axis_start";
    level.gamemodestartspawnpointnames["allies"] = var_48501209a3e177a7;
    level.gamemodestartspawnpointnames["axis"] = var_ae7d0107ad485428;
    level.gamemodespawnpointnames = [];
    level.gamemodespawnpointnames["allies"] = "mp_tdm_spawn";
    level.gamemodespawnpointnames["axis"] = "mp_tdm_spawn";
    level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
    level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

    if(function_bff229a11ecd1e34()) {
      scripts\mp\spawnlogic::setactivespawnlogic(#"default");
    } else if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_aniyah") {
      scripts\mp\spawnlogic::setactivespawnlogic("GroundWarTTLOS", "Crit_Default");
    } else if(scripts\cp_mp\utility\game_utility::islargemap()) {
      scripts\mp\spawnlogic::setactivespawnlogic("GroundWar", "Crit_Default");
    } else {
      scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
    }

    scripts\mp\spawnlogic::addstartspawnpoints("mp_gw_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_gw_spawn_axis_start");
    scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_gw_spawn_allies_start");
    scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_gw_spawn_axis_start");
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start");
    defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start");
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
  } else {
    level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
    level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

    if(function_bff229a11ecd1e34()) {
      scripts\mp\spawnlogic::setactivespawnlogic(#"default");
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
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function reinitspawns() {
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x43>");
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x4d>");
  spawns = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x59>");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x69>");
  scripts\mp\spawnlogic::registerspawnset("<dev string:x43>", spawns);
  scripts\mp\spawnlogic::registerspawnset("<dev string:x4d>", spawnssecondary);
}

function getspawnpoint() {
  if(level.var_904f766b5267e332) {
    spawnteam = self.pers["team"];

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
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

    if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
      spectatingteammate = self getspectatingplayer();

      if(isDefined(spectatingteammate) && isDefined(self.sessionsquadid) && self.team == spectatingteammate.team && self.sessionsquadid == spectatingteammate.sessionsquadid) {
        spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(spectatingteammate);
      }
    }

    return spawnpoint;
  }

  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"start");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
  }

  spawnteam = self.pers["team"];

  if(getgametypenumlives() != 1) {
    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
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
  } else if(spawnteam == game["attackers"]) {
    scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
  } else {
    scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
  }

  return spawnpoint;
}

function function_e4cc1e6807cb2252() {
  level._effect["vfx_br_cashBag"] = loadfx("vfx/iw8_br/gameplay/vfx_br_money_vip_burst.vfx");
  level.var_59a1f917fb3131a6 = "neutral";
  level.flagmodel["allies"] = "parts_backpack_duffle_knockout_ground";
  level.flagbase["allies"] = "ctf_game_flag_base";
  level.carryflag["allies"] = "parts_backpack_duffle_knockout";
  level.flagmodel["axis"] = "parts_backpack_duffle_knockout_ground";
  level.flagbase["axis"] = "ctf_game_flag_base";
  level.carryflag["axis"] = "parts_backpack_duffle_knockout";
  setupwaypointicons();
  level.iconescort = "waypoint_escort_flag";
  level.iconkill = "waypoint_ctf_kill";
  level.iconcaptureflag = "waypoint_take_flag";
  level.icondefendflag = "waypoint_defend_flag";
  level.iconreturnflag = "waypoint_recover_flag";
  level.mlgiconemptyflag = "waypoint_mlg_empty_flag";
  level.mlgiconfullflag = "waypoint_mlg_full_flag";
  level.icontarget = "waypoint_target";
  createflagstart();
}

function setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_recover_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_cash_bag", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cash_bag", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_take_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_cash_bag", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cash_bag", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0, undefined);
}

function createflagstart() {
  if(level.var_82bd227d5fb7e96f.size > 1) {
    if(!isDefined(game["koFlagOrigins"])) {
      game["koFlagOrigins"] = level.var_82bd227d5fb7e96f;
    }

    koflagspawnorigin = game["koFlagOrigins"][0];

    if(isDefined(game["koFlagSpawnOrigin"])) {
      if(game["koFlagOrigins"].size > 1) {
        game["koFlagOrigins"] = array_remove(game["koFlagOrigins"], game["koFlagSpawnOrigin"]);
        koflagspawnorigin = random(game["koFlagOrigins"]);
        game["koFlagSpawnOrigin"] = koflagspawnorigin;
      } else {
        game["koFlagSpawnOrigin"] = game["koFlagOrigins"][0];
      }
    } else if(isDefined(game["koFlagLastOrigin"])) {
      game["koFlagOrigins"] = array_remove(game["koFlagOrigins"], game["koFlagLastOrigin"]);
      game["koFlagSpawnOrigin"] = random(game["koFlagOrigins"]);
      game["koFlagOrigins"] = array_add(game["koFlagOrigins"], game["koFlagLastOrigin"]);
      game["koFlagLastOrigin"] = undefined;
    } else {
      game["koFlagSpawnOrigin"] = random(game["koFlagOrigins"]);
      game["koFlagOrigins"] = array_remove(game["koFlagOrigins"], game["koFlagSpawnOrigin"]);
    }
  } else {
    game["koFlagOrigins"] = level.var_82bd227d5fb7e96f;
    game["koFlagSpawnOrigin"] = game["koFlagOrigins"][0];
  }

  level.var_3e4b06ad7cc2cc65 = game["koFlagSpawnOrigin"];
  tracestart = level.var_3e4b06ad7cc2cc65 + (0, 0, 64);
  traceend = level.var_3e4b06ad7cc2cc65 + (0, 0, -64);
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, undefined, scripts\engine\trace::create_default_contents(1));
  level.var_3e4b06ad7cc2cc65 = trace["position"];
  level.var_d63f297a45dd1f87 = function_e9d3abcf077fb817("allies");
  level thread flaglockedtimer();

  if(game["koFlagOrigins"].size == 1) {
    game["koFlagLastOrigin"] = game["koFlagSpawnOrigin"];
    game["koFlagOrigins"] = undefined;
    game["koFlagSpawnOrigin"] = undefined;
  }
}

function flaglockedtimer() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level.var_94e80e94b14782b0.objectiveicon scripts\mp\gameobjects::setvisibleteam("none");
    level waittill_any_2("prematch_done", "start_mode_setup");
    level.var_94e80e94b14782b0.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");
  }

  if(level.flagactivationdelay) {
    scripts\mp\flags::gameflagwait("prematch_done");
    var_60ba653f45d3f4c8 = int(gettime() + level.flagactivationdelay * 1000);
    setomnvar("ui_obj_timer", var_60ba653f45d3f4c8);
    setomnvar("ui_obj_progress", 1);
    setomnvar("ui_objective_timer_stopped", 0);
    setomnvar("ui_single_flag_loc", -2);
    level.var_94e80e94b14782b0.objectiveicon thread scripts\mp\gameobjects::function_d36dcacac1708708(level.flagactivationdelay);
    level.var_94e80e94b14782b0 thread function_731aff3c7fe66e9f(level.flagactivationdelay);
    wait level.flagactivationdelay;
    setomnvar("ui_obj_timer_stopped", 1);
    setomnvar("ui_obj_timer", 0);
    setomnvar("ui_obj_progress", 0);
    setomnvar("ui_objective_timer_stopped", 1);
    setomnvar("ui_single_flag_loc", -1);
    level.var_94e80e94b14782b0.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag);
    level.var_94e80e94b14782b0.objectiveicon scripts\mp\objidpoolmanager::objective_show_progress(level.var_94e80e94b14782b0.objectiveicon.objidnum, 0);
    thread function_4963c847ffc21a21(level.var_94e80e94b14782b0.objectiveicon, getdvarfloat(@ "hash_e23e7531523cd429", 3));
    level.var_d63f297a45dd1f87.trigger scripts\engine\utility::trigger_on();

    foreach(team in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("obj_generic_capture", team);
    }
  }
}

function function_e9d3abcf077fb817(team) {
  level.pickuptime = 0;
  level.returntime = 0;
  radius = 32;
  trigger = spawn("trigger_radius", level.var_3e4b06ad7cc2cc65, 0, radius, 128);
  visuals = [];
  visuals[0] = spawn("script_model", level.var_3e4b06ad7cc2cc65 + (0, 0, 1));
  visuals[0] setModel(level.flagmodel[team]);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(team);
  carryteam = "neutral";
  teamflag = scripts\mp\gameobjects::createcarryobject(carryteam, trigger, visuals, (0, 0, 16));
  teamflag scripts\mp\gameobjects::allowcarry("any");
  teamflag scripts\mp\gameobjects::setteamusetime("friendly", level.pickuptime);
  teamflag scripts\mp\gameobjects::setteamusetime("enemy", level.returntime);
  teamflag scripts\mp\gameobjects::setvisibleteam("none");
  teamflag scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);
  teamflag scripts\mp\objidpoolmanager::objective_set_play_intro(teamflag.objidnum, 0);
  teamflag scripts\mp\objidpoolmanager::objective_set_play_outro(teamflag.objidnum, 0);
  teamflag scripts\mp\gameobjects::registercarryobjectpickupcheck(&flagpickupchecks);
  teamflag.allowweapons = 1;
  teamflag.requireslos = 1;
  teamflag.firstpickup = 1;
  teamflag.onpickup = &onpickup;
  teamflag.onpickupfailed = &onpickupfailed;
  teamflag.ondrop = &ondrop;
  teamflag.onreset = &onreset;
  teamflag.visualgroundoffset = (0, 0, 1);

  if(getdvarint(@ "hash_25905f240af754f6") != 0) {
    teamflag scripts\mp\gameobjects::create_manual_drop_data_struct([visuals[0]], trigger, 1, 80, 0);
  }

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

  level.var_94e80e94b14782b0 = createteamdefenderflagbase(team, teamflag);
  return teamflag;
}

function createteamdefenderflagbase(team, teamflag) {
  flagbaseorigin = teamflag.visuals[0].origin;
  teamflagbase = spawn("script_model", flagbaseorigin);
  teamflagbase.ownerteam = "neutral";
  teamflagbase setasgametypeobjective();
  teamflagbase setteaminhuddatafromteamname(team);
  teamflagbase.objectiveicon = scripts\mp\gameobjects::createobjidobject(flagbaseorigin, "neutral", (0, 0, 16), undefined, "any", 0);
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

function onpickupfailed(player) {}

function onpickup(player, playervo, defused) {
  self notify("picked_up");
  player notify("obj_picked_up");

  if(isDefined(player.musicpack) && player.musicpack == 1) {
    ko_carry_music = function_17ee301cf0b5ba85("ko_carry_music_classic");
    player setplayermusicstate(ko_carry_music);
  } else {
    ko_carry_music = function_17ee301cf0b5ba85("ko_carry_music");
    player setplayermusicstate(ko_carry_music);
  }

  self.offset3d = (0, 0, 85);
  level.var_94e80e94b14782b0.objectiveicon scripts\mp\gameobjects::setvisibleteam("none");
  level.var_d63f297a45dd1f87.currentcarrier = player;
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
      scripts\mp\objidpoolmanager::objective_set_pulsate(self.pingobjidnum, 1);
    }
  }

  scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);
  scripts\mp\objidpoolmanager::objective_set_pulsate(self.objidnum, 1);
  player incpersstat("captures", 1);
  player scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);
  player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
  player setextrascore0(player.pers["captures"]);
  thread function_7bc240fc69ea5205(player);
  thread scripts\mp\hud_util::function_7b2653a588f28e29(player, "callout_ko_pickup_owner", "callout_ko_pickup_friendly", "callout_ko_pickup_enemy");
  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.player = player;
  var_7e2c53b0bcf117d9.eventname = "pickup";
  var_7e2c53b0bcf117d9.position = player.origin;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
  self.previouscarrier = player;

  if(level.codcasterenabled) {
    player setgametypevip(1);
  }

  thread function_9962a01f46dd3b58(team);

  if(level.flagforcetimer > 0) {
    level thread function_cf40f9e06e5439ee(team);
  }
}

function private function_7bc240fc69ea5205(player) {
  self notify("ko_trigger_pickup_sound");
  self endon("ko_trigger_pickup_sound");
  self endon("ko_trigger_drop_sound");
  level endon("game_ended");

  if(isDefined(player)) {
    team = player.pers["team"];
    otherteam = scripts\mp\utility\game::getotherteam(team)[0];
    printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", player);
    waittime = getdvarfloat(@ "hash_c07d9c63c722352b", 0.5);

    if(waittime > 0) {
      wait waittime;
    }

    if(!istrue(level.gameended)) {
      excludelist = [];

      if(isDefined(player)) {
        excludelist = [player];
        player scripts\mp\utility\dialog::leaderdialogonplayer("ko_you_got_flag", "status");
      }

      if(isDefined(team)) {
        scripts\mp\utility\dialog::leaderdialog("ko_we_got_flag", team, "status", excludelist);
      }

      if(isDefined(otherteam)) {
        scripts\mp\utility\dialog::leaderdialog("ko_enemy_got_flag", otherteam);
      }
    }
  }
}

function returnflag() {
  self.offset3d = (0, 0, 16);
  scripts\mp\gameobjects::returnhome();
}

function ondrop(player) {
  if(isDefined(player) && isDefined(player.leaving_team)) {
    self.droppedteam = player.leaving_team;
    player.leaving_team = undefined;
  } else if(!isDefined(player)) {
    self.droppedteam = self.ownerteam;
  } else {
    self.droppedteam = player.team;
  }

  self.offset3d = (0, 0, 16);
  level.var_d63f297a45dd1f87.currentcarrier = undefined;
  level.var_59a1f917fb3131a6 = "neutral";
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "ko_obj_capture", "ko_obj_capture");
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

  thread function_4963c847ffc21a21(self, 2);

  if(self.ownerteam == "allies") {
    setomnvar("ui_single_flag_loc", -1);
  } else {
    setomnvar("ui_single_flag_loc", -1);
  }

  if(isDefined(player)) {
    player setplayermusicstate("");
    player setclientomnvar("ui_flag_player_hud_icon", 0);

    if(!isreallyalive(player)) {
      player.carryobject.previouscarrier = undefined;
    }

    if(isDefined(player.carryflag)) {
      player detachflag();
    }

    if(level.codcasterenabled) {
      player setgametypevip(0);
    }
  }

  thread function_8d6269bb8e0916de(player);
  setomnvar("ui_obj_timer_stopped", 1);
  setomnvar("ui_obj_timer", 0);
  setomnvar("ui_obj_progress", 0);
}

function private function_8d6269bb8e0916de(player) {
  self notify("ko_trigger_drop_sound");
  self endon("ko_trigger_drop_sound");
  self endon("ko_trigger_pickup_sound");
  level endon("game_ended");
  team = self.droppedteam;
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];

  if(isDefined(player)) {
    printandsoundoneveryone(otherteam, "none", undefined, undefined, "iw9_mp_ui_objective_lost", "", player);
  } else {
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);
  }

  waittime = getdvarfloat(@ "hash_c07d9c63c722352b", 0.5);

  if(waittime > 0) {
    wait waittime;
  }

  if(!istrue(level.gameended)) {
    if(isDefined(team)) {
      scripts\mp\utility\dialog::leaderdialog("ko_we_dropped_flag", team, "status");
    }

    if(isDefined(otherteam)) {
      scripts\mp\utility\dialog::leaderdialog("ko_enemy_dropped_flag", otherteam, "status");
    }
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
  level.var_d63f297a45dd1f87.currentcarrier = undefined;

  if(isDefined(level.var_d63f297a45dd1f87.portable_radar)) {
    level.var_d63f297a45dd1f87.portable_radar clearportableradar();
    level.var_d63f297a45dd1f87.portable_radar delete();
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

  thread function_4963c847ffc21a21(self, 2);

  if(!level.gameended) {
    foreach(team in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("ko_flag_returned", team, "status");
    }
  }

  self.droppedteam = undefined;

  if(self.ownerteam == "allies") {
    setomnvar("ui_single_flag_loc", -1);
  } else {
    setomnvar("ui_single_flag_loc", -1);
  }

  self.previouscarrier = undefined;
}

function attachflag() {
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(self.team, "ko_obj_hold", "ko_obj_kill");
  otherteam = getotherteam(self.pers["team"])[0];

  if(function_f6b7b661e990152(self)) {
    self attach(level.carryflag[otherteam], "tag_stowed_back3", 1);
  }

  self.carryflag = level.carryflag[otherteam];

  if(self tagexists("j_bag_left")) {
    playFXOnTag(level._effect["vfx_br_cashBag"], self, "j_bag_left");
  }
}

function detachflag() {
  if(self tagexists("j_bag_left")) {
    stopFXOnTag(level._effect["vfx_br_cashBag"], self, "j_bag_left");
  }

  if(function_f6b7b661e990152(self)) {
    self detach(self.carryflag, "tag_stowed_back3");
  }

  self.carryflag = undefined;
}

function private function_f6b7b661e990152(player) {
  canattach = 1;

  if(player scripts\mp\utility\killstreak::isjuggernaut()) {
    canattach = 0;
  }

  return canattach;
}

function awardobjtimeforcarrier(team) {
  level endon("game_ended");
  level.var_d63f297a45dd1f87 endon("dropped");
  level.var_d63f297a45dd1f87 endon("reset");
  level notify("objTimePointsRunning");
  level endon("objTimePointsRunning");

  while(!level.gameended) {
    wait 1;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!level.gameended) {
      level.var_d63f297a45dd1f87.carrier scripts\mp\gamescore::giveplayerscore(#"hash_98bfd8d29c56bc08", 10);
    }
  }
}

function function_9962a01f46dd3b58(team) {
  level.var_3a00bb035dbcf5ad = (gettimelimit() * 1000 - gettimepassed()) / 1000;

  if(level.flagholdtimer > 0 && level.flagholdtimer <= level.var_3a00bb035dbcf5ad) {
    level.var_3a00bb035dbcf5ad = level.flagholdtimer;
  }

  if(gettimelimit() == 0 && level.var_3a00bb035dbcf5ad <= 0) {
    flagholdtimer = int(gettime() + 1000000);
    setomnvar("<dev string:x83>", flagholdtimer);
    setomnvar("<dev string:x93>", 1);
    setomnvar("<dev string:xa6>", 0);

    return;
  }

  flagholdtimer = int(gettime() + level.var_3a00bb035dbcf5ad * 1000);
  setomnvar("ui_obj_timer", flagholdtimer);
  setomnvar("ui_obj_progress", 1);
  setomnvar("ui_objective_timer_stopped", 0);

  if(function_a64d63a207acdfe7()) {
    level thread scripts\mp\hud_message::notifyteam("ko_force_hold_fr", "ko_force_hold_en", team);
  }

  thread function_731aff3c7fe66e9f(level.var_3a00bb035dbcf5ad);

  if(function_a64d63a207acdfe7()) {
    thread function_8028646f3cc80ac4();
    return;
  }

  if(function_4d9dbf9e2aa4c0a6()) {
    thread function_20c16ddef8ce58e();
  }
}

function function_731aff3c7fe66e9f(flagholdtimer) {
  level.var_d63f297a45dd1f87 endon("dropped");
  currentprogress = flagholdtimer;

  while(!level.gameended && currentprogress > 0) {
    setomnvar("ui_obj_progress", currentprogress / flagholdtimer);
    currentprogress -= level.framedurationseconds;
    wait level.framedurationseconds;
  }

  setomnvar("ui_obj_timer", 0);
  setomnvar("ui_obj_progress", 0);
}

function function_8028646f3cc80ac4() {
  level endon("game_ended");
  self endon("dropped");
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.var_3a00bb035dbcf5ad);
  level function_ef6c12412261af73(level.var_d63f297a45dd1f87 scripts\mp\gameobjects::getownerteam(), game["end_reason"]["ko_flag_hold_win"], game["end_reason"]["ko_flag_hold_loss"]);
}

function function_20c16ddef8ce58e() {
  level endon("game_ended");
  self endon("dropped");
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.var_3a00bb035dbcf5ad);
  teamrespawn(level.var_d63f297a45dd1f87 scripts\mp\gameobjects::getownerteam(), level.var_d63f297a45dd1f87.currentcarrier);
}

function function_a64d63a207acdfe7() {
  return level.flagholdtimer != 0 && level.flagholdreward == 0;
}

function function_4d9dbf9e2aa4c0a6() {
  return level.flagholdtimer != 0 && level.flagholdreward == 1;
}

function teamrespawn(team, credit_player) {
  teamsize = scripts\mp\utility\teams::getteamdata(credit_player.team, "teamCount");

  if(!isDefined(credit_player.rescuedplayers)) {
    credit_player.rescuedplayers = [];
  }

  foreach(player in level.participants) {
    if(isDefined(player) && player.team == team && !isreallyalive(player) && !array_contains(scripts\mp\utility\teams::getfriendlyplayers(player.team, 1), player) && (!isDefined(player.waitingtoselectclass) || !player.waitingtoselectclass)) {
      if(isDefined(player.siegelatecomer) && player.siegelatecomer) {
        player.siegelatecomer = 0;
      }

      if(!istrue(player.pers["teamKillPunish"])) {
        if(istrue(player.wasflagspawned)) {
          continue;
        }

        player.wasflagspawned = 1;

        if(isDefined(level.revivetriggers[player.guid])) {
          level.revivetriggers[player.guid] scripts\mp\teamrevive::revivetriggerholdonuse(credit_player);
        } else {
          player thread scripts\mp\playerlogic::waittillcanspawnclient(0);
          player thread scripts\mp\rank::scoreeventpopup(#"revived");
          level notify("player_respawned", player);
          player scripts\mp\utility\dialog::leaderdialogonplayer("revived");
        }
      }

      credit_player.rescuedplayers[player.guid] = 1;
    }
  }

  self.playersrevived = credit_player.rescuedplayers.size;
}

function function_cf40f9e06e5439ee(team) {
  level notify("flagForceTimer");
  level endon("flagForceTimer");
  level endon("game_ended");
  level thread scripts\mp\hud_message::notifyteam("ko_force_timer", "ko_force_timer", team);
  level.timelimitoverride = 1;
  function_e132900ca2c350be();
}

function function_e132900ca2c350be() {
  level endon("flagForceTimer");
  level endon("game_ended");
  var_468d05f737005458 = int(gettime() + level.flagforcetimer * 1000);
  setgameendtime(var_468d05f737005458);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.flagforcetimer);

  if(isDefined(level.onobjectivecomplete)) {
    [[level.onobjectivecomplete]]("koFlag");
  }
}

function function_983348e55e3f3e5(objectivetype) {
  if(istrue(level.nukeinfo.incoming)) {
    return;
  }

  setgameendtime(0);
  winner = level.var_59a1f917fb3131a6;

  if(winner != "neutral") {
    function_ef6c12412261af73(winner, game["end_reason"]["ko_flag_win"], game["end_reason"]["ko_flag_loss"]);
    return;
  }

  if(!breaktie()) {
    function_ef6c12412261af73("tie", game["end_reason"]["tie"]);
  }
}

function onspawnplayer(revivespawn) {
  thread updatematchstatushintonspawn();
  self setclientomnvar("ui_flag_player_hud_icon", 0);

  if(isDefined(self.pers["captures"])) {
    setextrascore0(self.pers["captures"]);
  }

  if(isDefined(self.pers["rescues"])) {
    setextrascore1(self.pers["rescues"]);
  }
}

function updatematchstatushintonspawn() {
  if(isDefined(level.var_d63f297a45dd1f87.currentcarrier)) {
    if(level.var_d63f297a45dd1f87.currentcarrier.team == self.team) {
      scripts\mp\hud_message::function_f004ef4606b9efdc("ko_obj_hold");
    } else {
      scripts\mp\hud_message::function_f004ef4606b9efdc("ko_obj_kill");
    }

    return;
  }

  scripts\mp\hud_message::function_f004ef4606b9efdc("ko_obj_capture");
}

function onplayerconnect(player) {}

function ondeadevent(team) {
  if(team == "all") {
    function_ef6c12412261af73("tie", game["end_reason"]["tie"]);
    return;
  }

  if(team == game["attackers"]) {
    level function_ef6c12412261af73(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
    return;
  }

  level function_ef6c12412261af73(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
}

function ononeleftevent(team) {
  lastplayer = getlastlivingplayer(team);

  if(isDefined(lastplayer)) {
    lastplayer.laststanding = 1;
    lastplayer thread givelastonteamwarning();
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  if(!isPlayer(attacker) || attacker == self) {
    if(isDefined(self.carryflag)) {
      detachflag();
    }

    return;
  }

  if(isDefined(level.var_d63f297a45dd1f87) && level.var_d63f297a45dd1f87 scripts\mp\gameobjects::getownerteam() == attacker.pers["team"]) {} else if(isDefined(self.carryflag)) {}

  var_aec2e5e01f424119 = 0;
  attackerpos = attacker.origin;
  attackerisinflictor = 0;

  if(isDefined(einflictor)) {
    attackerpos = einflictor.origin;
    attackerisinflictor = einflictor == attacker;
  }

  if(isDefined(attacker) && isPlayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
    if(isDefined(attacker.carryflag) && attackerisinflictor) {
      attacker thread scripts\mp\rank::scoreeventpopup(#"carrier_kill");
      attacker thread scripts\mp\utility\points::doscoreevent(#"hash_f735b92839c5a687");
      var_aec2e5e01f424119 = 1;
    }

    if(isDefined(self.carryflag)) {
      attacker thread scripts\mp\utility\points::doscoreevent(#"hash_5311f153a7fee40c");
      attacker incpersstat("carrierKills", 1);
      attacker thread scripts\mp\hud_message::showsplash("ko_killed_carrier");
      attacker incpersstat("defends", 1);
      attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);
      attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
      thread utility::trycall(level.matchdata_logvictimkillevent, killid, "carrying");
      namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(20, attacker.team, attacker getentitynumber());
      var_aec2e5e01f424119 = 1;
    }

    if(!var_aec2e5e01f424119) {
      var_3cd1af2851f12ab5 = 0;
      awarddefense = 0;
      flagcheck = distsquaredcheck(attackerpos, self.origin, level.var_d63f297a45dd1f87.curorigin);

      if(flagcheck) {
        if(level.var_d63f297a45dd1f87.ownerteam == self.team) {
          var_3cd1af2851f12ab5 = 1;
        } else {
          awarddefense = 1;
        }
      }

      if(var_3cd1af2851f12ab5) {
        attacker thread scripts\mp\rank::scoreeventpopup(#"assault");
        attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
        thread utility::trycall(level.matchdata_logvictimkillevent, killid, "defending");
        attacker incpersstat("assaults", 1);
      } else if(awarddefense) {
        attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
        attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
        attacker incpersstat("defends", 1);
        attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);
        attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
        thread utility::trycall(level.matchdata_logvictimkillevent, killid, "assaulting");
      }
    }
  }

  if(isDefined(self.carryflag)) {
    detachflag();
  }
}

function distsquaredcheck(attackerpos, victimpos, checkpos) {
  attackerdistsq = distancesquared(checkpos, attackerpos);
  victimdistsq = distancesquared(checkpos, victimpos);

  if(attackerdistsq < 90000 || victimdistsq < 90000) {
    return 1;
  }

  return 0;
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  scripts\mp\gametypes\common::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

function givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_status_inform_last_one");
  otherteam = getotherteam(self.pers["team"])[0];
  level thread teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread teamplayercardsplash("callout_lastenemyalive", self, otherteam);
  level notify("last_alive", self);
}

function ontimelimit() {
  winner = level.var_59a1f917fb3131a6;

  if(winner != "neutral") {
    function_ef6c12412261af73(winner, game["end_reason"]["ko_flag_win"], game["end_reason"]["ko_flag_loss"]);
    return;
  }

  if(!breaktie()) {
    function_ef6c12412261af73("tie", game["end_reason"]["time_limit_reached"]);
  }
}

function private function_ef6c12412261af73(winner, endreasontext, endreasontextloss, nukedetonated, var_8e4a26ed257a393b) {
  if(winner == "tie") {
    if(!isDefined(game["roundsTied"])) {
      game["roundsTied"] = 0;
    }

    game["roundsTied"]++;

    if(game["roundsTied"] > level.drawsuntilbothscore) {
      game["canScoreOnTie"] = 1;
    }

    if(istrue(game["canScoreOnTie"])) {
      endreasontext = game["end_reason"]["ko_draw_award_point"];
    }
  }

  thread scripts\mp\gamelogic::endgame(winner, endreasontext, endreasontextloss, nukedetonated, var_8e4a26ed257a393b);
}

function breaktie() {
  alliesalive = 0;
  axisalive = 0;

  foreach(player in level.teamdata["allies"]["players"]) {
    if(scripts\mp\utility\player::isreallyalive(player)) {
      alliesalive++;
    }
  }

  foreach(player in level.teamdata["axis"]["players"]) {
    if(scripts\mp\utility\player::isreallyalive(player)) {
      axisalive++;
    }
  }

  if(alliesalive > axisalive) {
    function_ef6c12412261af73("allies", game["end_reason"]["ko_alive_count_win"], game["end_reason"]["ko_alive_count_loss"]);
    return true;
  } else if(alliesalive < axisalive) {
    function_ef6c12412261af73("axis", game["end_reason"]["ko_alive_count_win"], game["end_reason"]["ko_alive_count_loss"]);
    return true;
  }

  return false;
}

function function_bf2918399f1800b1() {
  wait 5;
  ents = getEntArray("<dev string:xc4>", "<dev string:xd2>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  ents = getEntArray("<dev string:xe7>", "<dev string:xd2>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:xc4>", "<dev string:xd2>");

  foreach(struct in structs) {
    thread scripts\mp\utility\debug::drawsphere(struct.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:xe7>", "<dev string:xd2>");

  foreach(struct in structs) {
    thread scripts\mp\utility\debug::drawsphere(struct.origin, 64, 1000, (0, 1, 0));
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
    println("<dev string:xfd>" + scriptspawnpoint.index + "<dev string:x118>" + scriptspawnpoint.totalscore);

    if(scriptspawnpoint.index == spawnpoint.index) {
      level.var_2dc7108159dc1da3++;
      iprintlnbold("<dev string:x12e>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:x14d>" + "<dev string:x15b>" + level.var_2dc7108159dc1da3 + "<dev string:x160>" + level.var_3d292942d52b104a);
    } else {
      level.var_a065445ba781ddf6++;
      iprintlnbold("<dev string:x165>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:x14d>" + "<dev string:x15b>" + level.var_2dc7108159dc1da3 + "<dev string:x160>" + level.var_3d292942d52b104a);
    }

    return scriptspawnpoint;
  }
}

function vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  return spawndata;
}

function registervehicletype(refname, spawnvehiclecallback) {
  assert(isDefined(refname));
  vehicleinfo = spawnStruct();
  vehicleinfo.refname = refname;
  vehicleinfo.spawncallback = spawnvehiclecallback;
  vehicleinfo.vehiclespawns = function_b08e7e3a0b14f76f(refname);
  assert(isDefined(vehicleinfo.vehiclespawns));
  level.vehicleinfo[refname] = vehicleinfo;
}

function initvehicles() {
  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;

  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  registervehicletype("little_bird", &vehiclespawn_littlebird);
  registervehicletype("atv", &vehiclespawn_atv);
  registervehicletype("tac_rover", &vehiclespawn_tacrover);
  level.vehiclespawnlocs = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    switch (vehicleinfo.refname) {
      case #"hash_9d4e22a00fc630b5":
        vehicleinfo.vehiclespawns = getvehiclespawns("little_bird", "veh9_mil_air_heli_medium_physics_mp");
        break;
      case #"hash_c93466c10cc10ba":
        vehicleinfo.vehiclespawns = getvehiclespawns("atv", "veh9_mil_lnd_atv_physics_mp");
        break;
      case #"hash_21e1eaa9138f512c":
        vehicleinfo.vehiclespawns = getvehiclespawns("tac_rover", "tromeo_physics_mp");
        break;
    }

    foreach(spawnpoint in vehicleinfo.vehiclespawns) {
      index = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[index] = spawnpoint;
      level.vehiclespawnlocs[index].refname = vehicleinfo.refname;
    }
  }

  if(false) {
    foreach(loc in level.vehiclespawnlocs) {
      thread drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level.vehiclespawnlocs = array_randomize(level.vehiclespawnlocs);
  numtospawn = level.numnonrallyvehicles;

  if(!isDefined(level.numnonrallyvehicles)) {
    numtospawn = 25;
  }

  if(false) {
    for(i = 0; i < numtospawn; i++) {
      loc = level.vehiclespawnlocs[i];
      thread drawline(loc.origin + (0, 0, 1500), loc.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(i = 0; i < numtospawn; i++) {
    loc = level.vehiclespawnlocs[i];

    if(isDefined(loc)) {
      vehicleinfo = level.vehicleinfo[loc.refname];
      [[vehicleinfo.spawncallback]](loc);
    }
  }
}

function getvehiclespawns(vehicleref, vehicletype) {
  spawns = [];
  mapname = scripts\cp_mp\utility\game_utility::getmapname();
  atvoriginsarray = [];
  atvanglesarray = [];
  var_380b98510b5d0765 = [];
  var_fb7e5f19efd9d046 = [];

  switch (mapname) {
    case #"hash_32eaa112f8caa7e4":
      if(vehicleref == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (21843.8, -4640.11, -476.961);
        atvoriginsarray[atvoriginsarray.size] = (20375.9, -3612.78, -454);
        atvoriginsarray[atvoriginsarray.size] = (20728.8, -3309.36, -456);
        atvanglesarray[atvanglesarray.size] = (0, 255, 0);
        atvanglesarray[atvanglesarray.size] = (0, 330, 0);
        atvanglesarray[atvanglesarray.size] = (0, 292, 0);
        atvoriginsarray[atvoriginsarray.size] = (20937.2, -9029.28, -379.674);
        atvoriginsarray[atvoriginsarray.size] = (23097.1, -9966.89, -344);
        atvanglesarray[atvanglesarray.size] = (356.825, 240, 0);
        atvanglesarray[atvanglesarray.size] = (0, 0, 0);
        atvoriginsarray[atvoriginsarray.size] = (17471, -23211.4, -204);
        atvoriginsarray[atvoriginsarray.size] = (15960.1, -22768.1, -204);
        atvoriginsarray[atvoriginsarray.size] = (15821.3, -23568, -208.461);
        atvanglesarray[atvanglesarray.size] = (0, 90, 0);
        atvanglesarray[atvanglesarray.size] = (0, 45, 0);
        atvanglesarray[atvanglesarray.size] = (0, 90, 0);
        atvoriginsarray[atvoriginsarray.size] = (22994.3, -15304.5, -216);
        atvanglesarray[atvanglesarray.size] = (0, 105, 0);
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (20120.2, -3287.71, -456);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (21339.9, -4787.55, -450.176);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 345, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (357.831, 255.032, -1.25312);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (17449, -22190.1, -208.116);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (16651.1, -22178.2, -207.908);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 60, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 60, 0);
      }

      break;
    case #"hash_7a28db3c5928c489":
      if(vehicleref == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (26335.7, 30412.6, 655.471);
        atvoriginsarray[atvoriginsarray.size] = (27099.5, 30567.5, 639.236);
        atvoriginsarray[atvoriginsarray.size] = (27315.5, 30525.5, 639.236);
        atvanglesarray[atvanglesarray.size] = (0.0728273, 119, 0.843973);
        atvanglesarray[atvanglesarray.size] = (2.67817, 77.0718, 1.59551);
        atvanglesarray[atvanglesarray.size] = (2.67817, 77.0718, 1.59551);
        atvoriginsarray[atvoriginsarray.size] = (29610.4, 38228.5, 698.883);
        atvoriginsarray[atvoriginsarray.size] = (29465.5, 38973.6, 701);
        atvanglesarray[atvanglesarray.size] = (0, 315, 0);
        atvanglesarray[atvanglesarray.size] = (0, 88.9989, 0);
        atvoriginsarray[atvoriginsarray.size] = (39153, 46431.8, 932.749);
        atvoriginsarray[atvoriginsarray.size] = (38876.4, 46106.9, 925.771);
        atvoriginsarray[atvoriginsarray.size] = (37923.7, 47136.4, 949.247);
        atvanglesarray[atvanglesarray.size] = (1.88064, 180.047, 0.333796);
        atvanglesarray[atvanglesarray.size] = (1.47639, 180.039, 1.17305);
        atvanglesarray[atvanglesarray.size] = (359.077, 185.712, 7.76991);
        atvoriginsarray[atvoriginsarray.size] = (33628.2, 40971.6, 653.047);
        atvoriginsarray[atvoriginsarray.size] = (32104.4, 41719.8, 708.773);
        atvanglesarray[atvanglesarray.size] = (349.991, 186.286, -2.23687);
        atvanglesarray[atvanglesarray.size] = (3.95499, 211.371, 4.41818);
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (26310.8, 30168.4, 659.426);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (26954, 29794.1, 651.013);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (358.195, 118.006, -2.71651);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 89.9998, 0);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (38573.2, 47052.8, 950.28);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (39660.3, 45949.9, 952.362);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (359.669, 194.507, -0.439539);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (11.7511, 162.518, 0.102679);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (33138.2, 41498.6, 707.349);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (357.81, 284.768, 1.14713);
      }

      break;
    case #"hash_50de71be6e7469ff":
    case #"hash_863773b8960b3944":
      if(vehicleref == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (49063.3, -22654.9, -385.662);
        atvoriginsarray[atvoriginsarray.size] = (47332.9, -23070.6, -374.497);
        atvoriginsarray[atvoriginsarray.size] = (48281.3, -22202.5, -371.375);
        atvanglesarray[atvanglesarray.size] = (0.0275984, 103.998, 0.280605);
        atvanglesarray[atvanglesarray.size] = (357.226, 88.8435, 4.3294);
        atvanglesarray[atvanglesarray.size] = (3.93534, 89.3527, 4.34541);
        atvoriginsarray[atvoriginsarray.size] = (49720, -18492, -387.562);
        atvoriginsarray[atvoriginsarray.size] = (48107.4, -18052.3, -312.859);
        atvanglesarray[atvanglesarray.size] = (0, 73.9972, 0);
        atvanglesarray[atvanglesarray.size] = (352.657, 118.56, -10.3306);
        atvoriginsarray[atvoriginsarray.size] = (46431.3, -92.3425, -52.4549);
        atvoriginsarray[atvoriginsarray.size] = (47471, -192.634, -43.7394);
        atvoriginsarray[atvoriginsarray.size] = (48085.6, -358.42, 9.73944);
        atvanglesarray[atvanglesarray.size] = (359.802, 240.821, -3.32839);
        atvanglesarray[atvanglesarray.size] = (0.975088, 240.828, 0.322594);
        atvanglesarray[atvanglesarray.size] = (6.15886, 241.028, 2.20885);
        atvoriginsarray[atvoriginsarray.size] = (44528.7, -5376.79, 283.824);
        atvoriginsarray[atvoriginsarray.size] = (43628, -5846.41, 346.636);
        atvanglesarray[atvanglesarray.size] = (357.74, 256.16, -1.56165);
        atvanglesarray[atvanglesarray.size] = (0.506229, 241.181, 0.438595);
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (47872.6, -22645.4, -385.49);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (48501.7, -22505, -382.243);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (1.68464, 109.9, -3.26246);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (359.897, 89.9842, 8.71393);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (46034.5, -59.925, -29.8834);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (47108.8, -498.535, -35.0573);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (2.33612, 243.444, -0.141863);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (355.135, 243.112, 2.65064);
      }

      break;
    case #"hash_12f3765ef24b4037":
      if(vehicleref == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (31381.3, -35260.4, -566.754);
        atvoriginsarray[atvoriginsarray.size] = (31087.5, -35307.9, -566.206);
        atvanglesarray[atvanglesarray.size] = (0, 106, 0);
        atvanglesarray[atvanglesarray.size] = (0, 91, 0);
        atvoriginsarray[atvoriginsarray.size] = (37273.8, -22647.6, -566);
        atvoriginsarray[atvoriginsarray.size] = (38224.6, -23864.4, -566);
        atvanglesarray[atvanglesarray.size] = (0, 225, 0);
        atvanglesarray[atvanglesarray.size] = (0, 225, 0);
        atvoriginsarray[atvoriginsarray.size] = (37183.4, -15816, -558.929);
        atvoriginsarray[atvoriginsarray.size] = (36704.9, -15941.1, -558);
        atvoriginsarray[atvoriginsarray.size] = (37630.9, -15950.5, -564);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvoriginsarray[atvoriginsarray.size] = (34323.3, -25831.8, -566);
        atvanglesarray[atvanglesarray.size] = (0, 45, 0);
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (31412.5, -34658.3, -564.862);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (31042.3, -16171.6, -565.383);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 105, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 75, 0);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (36937.6, -15836.1, -559.8);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (37369.7, -16171.6, -562);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 270, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 270, 0);
      }

      break;
    case #"hash_924a3fbe9fbe15c6":
      if(vehicleref == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (-28937.7, -17197.8, -246.637);
        atvoriginsarray[atvoriginsarray.size] = (-29175.8, -17121.9, -247.909);
        atvoriginsarray[atvoriginsarray.size] = (-28096.5, -16918.8, -246.085);
        atvanglesarray[atvanglesarray.size] = (1.203, 90, 0.12);
        atvanglesarray[atvanglesarray.size] = (0.597, 90, 0.15);
        atvanglesarray[atvanglesarray.size] = (358.68, 90.0277, -0.8);
        atvoriginsarray[atvoriginsarray.size] = (-25926, -12688.6, -89.5073);
        atvoriginsarray[atvoriginsarray.size] = (-24872.9, -12661.3, -65.0808);
        atvanglesarray[atvanglesarray.size] = (5.13576, 104.619, 0.240957);
        atvanglesarray[atvanglesarray.size] = (358.169, 15, -3.49767);
        atvoriginsarray[atvoriginsarray.size] = (-28315.5, -3152.67, -311.293);
        atvoriginsarray[atvoriginsarray.size] = (-28107.5, -3152.67, -311.293);
        atvoriginsarray[atvoriginsarray.size] = (-27778.8, -3591.73, -310.621);
        atvanglesarray[atvanglesarray.size] = (0.061, 270, 7.355);
        atvanglesarray[atvanglesarray.size] = (0.061, 270, 7.355);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvoriginsarray[atvoriginsarray.size] = (-25666, -8411.14, -47.9997);
        atvoriginsarray[atvoriginsarray.size] = (-26998.2, -9004.54, -40);
        atvanglesarray[atvanglesarray.size] = (358.715, 15.233, -10.279);
        atvanglesarray[atvanglesarray.size] = (0, 285, 0);
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-28683.3, -16741.2, -249.16);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-29128.7, -16577.6, -229.266);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (359.734, 90.0021, -0.454);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (353.195, 90.3463, -3.01942);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-27985.4, -3613.97, -315.978);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-28449.8, -3645.92, -312.247);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 270.003, 5.684);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 270.004, -3.208);
      }

      break;
    case #"hash_a8b272dba33a4aed":
      break;
    case #"hash_1bc93b88575e82eb":
      if(vehicleref == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (-9606.95, -21527.2, -279.043);
        atvoriginsarray[atvoriginsarray.size] = (-10288.2, -20891.9, -356.989);
        atvoriginsarray[atvoriginsarray.size] = (-11011.4, -19877, -368.358);
        atvanglesarray[atvanglesarray.size] = (0, 200, 0);
        atvanglesarray[atvanglesarray.size] = (0, 222, 0);
        atvanglesarray[atvanglesarray.size] = (359.526, 210.007, -0.952);
        atvoriginsarray[atvoriginsarray.size] = (-13835.9, -23127.9, -278.639);
        atvoriginsarray[atvoriginsarray.size] = (-14327.9, -22160.8, -266.586);
        atvanglesarray[atvanglesarray.size] = (2.373, 210, 0);
        atvanglesarray[atvanglesarray.size] = (0.806, 194.929, 2.603);
        atvoriginsarray[atvoriginsarray.size] = (-21725.2, -26511, -152);
        atvoriginsarray[atvoriginsarray.size] = (-21577.7, -26755.1, -151.997);
        atvoriginsarray[atvoriginsarray.size] = (-21065.3, -27199.1, -148.746);
        atvanglesarray[atvanglesarray.size] = (0, 30, 0);
        atvanglesarray[atvanglesarray.size] = (0, 60, 0);
        atvanglesarray[atvanglesarray.size] = (5.079, 0.128, 1.453);
        atvoriginsarray[atvoriginsarray.size] = (-18873.3, -25796.5, -199.784);
        atvanglesarray[atvanglesarray.size] = (0, 30, 0);
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-10912.6, -20079.6, -367);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-10108.5, -21861.4, -287.271);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 196.996, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (7.93172, 180.719, 4.15911);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-22036.5, -25881.6, -147.198);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-21144.5, -27447.1, -151.145);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 345, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 30, 0);
      }

      break;
    case #"hash_e4ca6b73b5022b26":
      if(vehicleref == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (-3749, 16980, -262);
        atvoriginsarray[atvoriginsarray.size] = (-2971.9, 18898, -262);
        atvoriginsarray[atvoriginsarray.size] = (-2735.8, 16203, -262);
        atvanglesarray[atvanglesarray.size] = (0, 218, 0);
        atvanglesarray[atvanglesarray.size] = (0, 174, 0);
        atvanglesarray[atvanglesarray.size] = (0, 208, 0);
        atvoriginsarray[atvoriginsarray.size] = (-11894, 16161, -266);
        atvoriginsarray[atvoriginsarray.size] = (-11841, 15884, -266);
        atvanglesarray[atvanglesarray.size] = (0, 162, 0);
        atvanglesarray[atvanglesarray.size] = (0, 248, 0);
        atvoriginsarray[atvoriginsarray.size] = (-29137, 12868, -244);
        atvoriginsarray[atvoriginsarray.size] = (-29539, 12883, -252);
        atvoriginsarray[atvoriginsarray.size] = (-29040, 13706, -497);
        atvanglesarray[atvanglesarray.size] = (0, 0, 0);
        atvanglesarray[atvanglesarray.size] = (0, 0, 0);
        atvanglesarray[atvanglesarray.size] = (0, 5, 0);
        atvoriginsarray[atvoriginsarray.size] = (-19181, 16384, -263);
        atvoriginsarray[atvoriginsarray.size] = (-19650, 17253, 54);
        atvoriginsarray[atvoriginsarray.size] = (-19937, 16123, -261);
        atvanglesarray[atvanglesarray.size] = (0, 310, 0);
        atvanglesarray[atvanglesarray.size] = (0, 357, 0);
        atvanglesarray[atvanglesarray.size] = (0, 35, 0);
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-3520, 17805, -262);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-3892, 18566, -262);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 165, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 194, 0);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-29131, 13010, -244);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-28676, 13724, -518);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 0, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 355, 0);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-19622, 17422, 54);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 357, 0);
      }

      break;
    case #"hash_3a8b050ff58578ad":
      if(vehicleref == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (4103, 26076, 57);
        atvoriginsarray[atvoriginsarray.size] = (4247, 25021, -38);
        atvoriginsarray[atvoriginsarray.size] = (3517, 25981, 47);
        atvanglesarray[atvanglesarray.size] = (0, 143, 0);
        atvanglesarray[atvanglesarray.size] = (0, 189, 0);
        atvanglesarray[atvanglesarray.size] = (0, 103, 0);
        atvoriginsarray[atvoriginsarray.size] = (4989, 29842, 253);
        atvoriginsarray[atvoriginsarray.size] = (1725, 28703, 51);
        atvanglesarray[atvanglesarray.size] = (0, 162, 0);
        atvanglesarray[atvanglesarray.size] = (0, 141, 0);
        atvoriginsarray[atvoriginsarray.size] = (-6826, 33623, -46);
        atvoriginsarray[atvoriginsarray.size] = (-7642, 32168, -188);
        atvoriginsarray[atvoriginsarray.size] = (-6589, 32564, -82);
        atvanglesarray[atvanglesarray.size] = (3, 337, 0);
        atvanglesarray[atvanglesarray.size] = (0, 357, 0);
        atvanglesarray[atvanglesarray.size] = (0, 320, 0);
        atvoriginsarray[atvoriginsarray.size] = (-3326, 32657, 238);
        atvoriginsarray[atvoriginsarray.size] = (-2149, 33264, 253);
        atvanglesarray[atvanglesarray.size] = (0, 325, 0);
        atvanglesarray[atvanglesarray.size] = (0, 287, 0);
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (4157, 26465, 65);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (4628, 26545, 63);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 143, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 63, 0);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-7337, 32683, -77);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-6671, 32948, -67);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 320, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 36, 0);
      }

      break;
    default:
      break;
  }

  level.atvoriginsarray = atvoriginsarray;
  level.atvanglesarray = atvanglesarray;

  if(vehicleref == "atv") {
    for(i = 0; i < atvoriginsarray.size; i++) {
      if(i <= atvoriginsarray.size - 1) {
        atvorigin = atvoriginsarray[i];
        atvangles = atvanglesarray[i];
        vehicle = spawnStruct();
        vehicle.origin = atvorigin;
        vehicle.angles = atvangles;
        vehicle.targetname = vehicleref;
        vehicle.vehicletype = vehicletype;
        spawns[spawns.size] = vehicle;
      }
    }
  } else if(vehicleref == "tac_rover") {
    for(i = 0; i < var_380b98510b5d0765.size; i++) {
      if(i <= var_380b98510b5d0765.size - 1) {
        var_d82a9436eee389cb = var_380b98510b5d0765[i];
        var_17085fd4c01a3645 = var_fb7e5f19efd9d046[i];
        vehicle = spawnStruct();
        vehicle.origin = var_d82a9436eee389cb;
        vehicle.angles = var_17085fd4c01a3645;
        vehicle.targetname = vehicleref;
        vehicle.vehicletype = vehicletype;
        spawns[spawns.size] = vehicle;
      }
    }
  }

  dvarstring = hashcat(@ "hash_ad95d7262a11119e", vehicleref);

  for(index = 0; true; index++) {
    origindvarstring = hashcat(dvarstring, "_origin_", index);
    angledvarstring = hashcat(dvarstring, "_angles_", index);
    defaultorigin = (0, 0, 0);
    origin = getdvarvector(origindvarstring, defaultorigin);

    if(origin == (0, 0, 0)) {
      break;
    }

    vehicle = spawnStruct();
    vehicle.origin = origin;
    var_7224bacab3f8ee26 = (0, 0, 0);
    vehicle.angles = getdvarvector(angledvarstring, var_7224bacab3f8ee26);
    vehicle.targetname = vehicleref;
    vehicle.vehicletype = vehicletype;
    spawns[spawns.size] = vehicle;
  }

  return spawns;
}

function vehiclespawn_littlebird(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata, faildata);
}

function vehiclespawn_atv(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata, faildata);
}

function vehiclespawn_tacrover(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("tac_rover", spawndata, faildata);
}

function filtervehiclespawnstructs(structs) {
  filtered = [];

  if(getdvarint(@ "scr_brtdm_disable_radiant_vehicles", level.brtdm_config.locale_defaults["scr_brtdm_disable_radiant_vehicles"]) == 1) {
    return filtered;
  }

  foreach(struct in structs) {
    if(distance2dsquared(struct.origin, level.brtdm_config.circlecenter) < level.brtdm_config.circleradius * level.brtdm_config.circleradius) {
      filtered[filtered.size] = struct;
    }
  }

  return filtered;
}

function function_ba7699d705fb8850() {
  scripts\mp\codcasterclientmatchdata::function_edba1ee7c2375a5();
}

function function_bd59438ee37ccc48(point) {
  if(isDefined(level.var_d63f297a45dd1f87)) {
    if(isDefined(point)) {
      if(ispointinsidecircle(point, level.var_d63f297a45dd1f87.curorigin, 40)) {
        return false;
      }
    } else if(self istouching(level.var_d63f297a45dd1f87.trigger)) {
      return false;
    }
  }

  return true;
}