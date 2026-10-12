/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rescue.gsc
***********************************************/

#using script_4a6760982b403bad;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\teamrevive;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace rescue;

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
    registerroundswitchdvar(getgametype(), 3, 0, 12);
    registertimelimitdvar(getgametype(), 150);
    registerscorelimitdvar(getgametype(), 200);
    registerroundlimitdvar(getgametype(), 0);
    registerwinlimitdvar(getgametype(), 500);
    registernumlivesdvar(getgametype(), 1);
    registerhalftimedvar(getgametype(), 0);
    registerwinbytwoenableddvar(getgametype(), 1);
    registerwinbytwomaxroundsdvar(getgametype(), 4);
    registernumrevivesdvar(getgametype(), 0);
    setDvar(@ "scr_player_laststand", 2);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;
  level.onplayerconnect = &onplayerconnect;
  level.onobjectivecomplete = &onflagcapture;
  level.ondeadevent = &ondeadevent;
  level.ontimelimit = &ontimelimit;
  level.endgame = &function_f6e1c54f449c2c6f;
  level.onteamscore = &function_e462b877cedea7f7;
  level.var_a12ec32a24e1a367 = &function_a12ec32a24e1a367;
  level.onmaprestart = &function_cf8b96b6503d9f31;
  level.gamemodemaydropweapon = &function_824aadc5e0a8e202;
  level.var_ca4e08767cbdae12 = &function_c95d2a5f442a6bfe;
  level.returnon = getdvarint(@ "hash_7798be18e3f3ad91", 0);
  level.var_e181fdcc8e4e5173 = getdvarint(@ "hash_71c04cb18cad67cd", 0);
  level.var_f224e09983ef4b2a = getdvarint(@ "hash_20103d7a5a56aac8", 20);
  level.var_681eabe436c0029d = getdvarint(@ "hash_7e0c25f71d807534", 1);
  function_f21c2225770dca31();
  level.var_4f4f5beac3bccc69 = 1;
  level.flagcapturetime = 0;
  level.scoreoverride = 0;
  level.var_319544f76c37154b["axis"] = 0;
  level.var_319544f76c37154b["allies"] = 0;
  level.var_9a8e3eb5bc672807 = 1;
  level.var_37baab13a0cf00e3 = getdvarint(@ "hash_bbbbf0150d760b11", 1);
  level.allowlatecomers = 0;
  game["canScoreOnTie"] = 1;

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    game["dialog"]["gametype"] = "iw9_rscu_mode_uktl_rnt1";
  } else {
    game["dialog"]["gametype"] = "iw9_rscu_mode_uktl_name";
  }

  if(!isDefined(game["roundsPlayed"])) {
    var_20ee2c907dd89357 = "iw9_rscu_mode_uktl_bstd";
    var_9016b7d396ffbdbb = "iw9_rscu_mode_uktl_bsta";
  } else {
    var_20ee2c907dd89357 = "iw9_rscu_mode_uktl_bstd";
    var_9016b7d396ffbdbb = "iw9_rscu_mode_uktl_bsta";
  }

  game["dialog"]["offense_obj"] = var_20ee2c907dd89357;
  game["dialog"]["defense_obj"] = var_9016b7d396ffbdbb;
  game["dialog"]["dropped_hostage_defend"] = "iw9_rscu_mode_uktl_rsde";
  game["dialog"]["dropped_hostage_retrieve"] = "iw9_rscu_mode_uktl_rsdh";
  game["dialog"]["hostage_taken_friendly"] = "iw9_rscu_mode_uktl_rseh";
  game["dialog"]["hostage_taken_enemy"] = "iw9_rscu_mode_uktl_rset";
  game["dialog"]["hostage_extraected_friendly"] = "iw9_rscu_mode_uktl_rsex";
  game["dialog"]["hostage_extracted_enemy"] = "iw9_rscu_mode_uktl_rsee";
  game["dialog"]["lead_lost"] = "gamestate_leadlost";
  game["dialog"]["lead_taken"] = "gamestate_leadtaken";
  scripts\mp\outofbounds::registeroobentercallback("rescue", &function_b9962c5a08fd9ab7);
  scripts\mp\outofbounds::registeroobexitcallback("rescue", &function_d50cce29bbb9d457);

  thread function_e100ac66c6f43c39();
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_c44109000ed1922d", getmatchrulesdata("carryData", "manualDropEnabled"));
  setdynamicdvar(@ "hash_b68209d1c9d3b09f", 0);
  registerhalftimedvar("rescue", 0);
}

function function_f21c2225770dca31() {
  switch (level.var_e181fdcc8e4e5173) {
    case 0:
      level.numhostages = 2;
      level.var_385bb8fdab525e2b = 0;
      level.numextractions = 1;
      level.showenemycarrier = 0;
      break;
    case 1:
      level.numhostages = 1;
      level.var_385bb8fdab525e2b = 0;
      level.numextractions = 1;
      level.showenemycarrier = 0;
      break;
    case 2:
      level.numhostages = 1;
      level.var_385bb8fdab525e2b = 1;
      level.numextractions = 2;
      level.showenemycarrier = 0;
      break;
    case 3:
      level.numhostages = 2;
      level.var_385bb8fdab525e2b = 1;
      level.numextractions = 2;
      level.showenemycarrier = 0;
      break;
    case 4:
      level.numhostages = 2;
      level.var_385bb8fdab525e2b = 0;
      level.numextractions = 1;
      level.showenemycarrier = 0;
      break;
    default:
      break;
  }
}

function onstartgametype() {
  level.var_974e9f26a695cd24 = 200;
  level.var_d2574c87ee723d10 = 100;

  if(level.numhostages == 1) {
    scripts\mp\utility\dvars::setoverridewatchdvar("scorelimit", 100);
    level.scorelimit = 100;
    level.scorelimitoverride = 100;
    level.roundscorelimit = 100 * (game["roundsPlayed"] + 1);
    level.var_974e9f26a695cd24 = 100;
    level.var_d2574c87ee723d10 = 50;
    scripts\mp\utility\dvars::setoverridewatchdvar("winlimit", 250);
    level.winlimit = 250;
  }

  level.winlimit = 500;

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  setclientnamemode("manual_change");
  setobjectivetext(game["attackers"], &"OBJECTIVES/RESCUE_DEFENDERS");
  setobjectivetext(game["defenders"], &"OBJECTIVES/RESCUE_ATTACKERS");

  if(level.splitscreen) {
    setobjectivescoretext(game["attackers"], &"OBJECTIVES/RESCUE_DEFENDERS");
    setobjectivescoretext(game["defenders"], &"OBJECTIVES/RESCUE_ATTACKERS");
  } else {
    setobjectivescoretext(game["attackers"], &"OBJECTIVES/RESCUE_SCORE_DEFENDERS");
    setobjectivescoretext(game["defenders"], &"OBJECTIVES/RESCUE_SCORE_ATTACKERS");
  }

  setobjectivehinttext(game["attackers"], &"OBJECTIVES/RESCUE_SCORE_DEFENDERS");
  setobjectivehinttext(game["defenders"], &"OBJECTIVES/RESCUE_SCORE_ATTACKERS");
  initanims();
  seticonnames();
  function_65ddee84a30aca2a();
  function_f8c926cdeb59f116();
  function_b924ba876ae5b152();
  thread function_e94cf520d98ce0e1();
  initspawns();
  level.var_319544f76c37154b["axis"] = 0;
  level.var_319544f76c37154b["allies"] = 0;
  level thread function_189d41172d946149();
  var_1010c350abcc5fec = ter_op(game["defenders"] == "axis", 1, 0);

  foreach(player in level.players) {
    player setclientomnvar("ui_rescue_hostage_active", 0);
  }

  setomnvar("ui_rescue_axis_attacking", var_1010c350abcc5fec);
  scripts\mp\teamrevive::function_5343ecb486b66bf1("rescue", &onspawnrevivetrigger);
}

function seticonnames() {
  level.iconrecover = "rescue_recover";
  level.iconescort = "rescue_escort";
  level.iconreturn = "rescue_escort_return";
  level.iconextract = "rescue_taking_extract";
  level.icondefendextract = "rescue_defend_extract";
  level.iconcaptureextract = "rescue_capture_extract";
  level.iconlosing = "rescue_defend_extract";
  level.icontaking = "rescue_taking_extract";
  level.iconneutral = "rescue_capture_extract";
  level.iconcapture = "rescue_capture_extract";
  level.icondefending = "rescue_defend_extract";
  level.iconcontested = "rescue_stopping_extract";
  level.icondefend = "rescue_defend_extract";
}

function function_65ddee84a30aca2a() {
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_recover", 0, "friendly", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_hostage_captive", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_escort", 0, "enemy", &"MP_INGAME_ONLY/OBJ_RESCUE_CAPS", "icon_waypoint_hostage", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_escort_return", 0, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_hostage", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_RESCUE_CAPS", "icon_waypoint_hostage", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_RESCUE_CAPS", "icon_waypoint_hostage", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_c", 0, "enemy", &"MP_INGAME_ONLY/OBJ_RESCUE_CAPS", "icon_waypoint_hostage", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hostage_captive", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hostage_captive", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hostage_captive", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_kill", 0, "friendly", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_kill_carrier", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_taking_extract", 1, "friendly", &"MP_INGAME_ONLY/OBJ_EXTRACT_CAPS", "ui_map_icon_extraction", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_defend_extract", 1, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "ui_map_icon_extraction", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_capture_extract", 0, "neutral", "MP_INGAME_ONLY/OBJ_NEXT_CAPS", "icon_waypoint_hostage", 0);
}

function updategametypedvars() {
  setdvarifuninitialized(@ "hash_5ad4b38eb8b556f1", 0);
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

#using_animtree("script_model");

function initanims() {
  level.scr_animtree["player_pickup_hostage"] = #animtree;
  level.scr_anim["player_pickup_hostage"]["pickup_front_crouch"] = % iw9_mp_hostage_pickup_crouch_8;
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_crouch"] = % "pickup_front_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_front_stand"] = % iw9_mp_hostage_pickup_stand_8;
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_stand"] = % "pickup_front_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_back_crouch"] = % iw9_mp_hostage_pickup_crouch_2;
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_crouch"] = % "pickup_back_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_back_stand"] = % iw9_mp_hostage_pickup_stand_2;
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_stand"] = % "pickup_back_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_right_crouch"] = % iw9_mp_hostage_pickup_crouch_6;
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_crouch"] = % "pickup_right_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_right_stand"] = % iw9_mp_hostage_pickup_stand_6;
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_stand"] = % "pickup_right_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_left_crouch"] = % iw9_mp_hostage_pickup_crouch_4;
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_crouch"] = % "pickup_left_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_left_stand"] = % iw9_mp_hostage_pickup_stand_4;
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_stand"] = % "pickup_left_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_front_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_8;
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_crouch_vm"] = % "pickup_front_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_front_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_8;
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_stand_vm"] = % "pickup_front_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_back_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_2;
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_crouch_vm"] = % "pickup_back_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_back_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_2;
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_stand_vm"] = % "pickup_back_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_right_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_6;
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_crouch_vm"] = % "pickup_right_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_right_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_6;
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_stand_vm"] = % "pickup_right_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_left_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_4;
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_crouch_vm"] = % "pickup_left_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_left_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_4;
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_stand_vm"] = % "pickup_left_stand_vm";
  level.scr_animtree["hostage_pickup"] = #animtree;
  level.scr_anim["hostage_pickup"]["pickup_front_crouch"] = % iw9_mp_hostage_pickedup_crouch_8;
  level.scr_eventanim["hostage_pickup"]["pickup_front_crouch"] = % "hash_67f23cafd452eaf";
  level.scr_anim["hostage_pickup"]["pickup_front_stand"] = % iw9_mp_hostage_pickedup_stand_8;
  level.scr_eventanim["hostage_pickup"]["pickup_front_stand"] = % "hash_76c3c19b5cdc4957";
  level.scr_anim["hostage_pickup"]["pickup_back_crouch"] = % iw9_mp_hostage_pickedup_crouch_2;
  level.scr_eventanim["hostage_pickup"]["pickup_back_crouch"] = % "hash_5b9b71e89b7aff69";
  level.scr_anim["hostage_pickup"]["pickup_back_stand"] = % iw9_mp_hostage_pickedup_stand_2;
  level.scr_eventanim["hostage_pickup"]["pickup_back_stand"] = % "hash_6a3ae844da15c55d";
  level.scr_anim["hostage_pickup"]["pickup_right_crouch"] = % iw9_mp_hostage_pickedup_crouch_6;
  level.scr_eventanim["hostage_pickup"]["pickup_right_crouch"] = % "hash_17c61661c4ba6d68";
  level.scr_anim["hostage_pickup"]["pickup_right_stand"] = % iw9_mp_hostage_pickedup_stand_6;
  level.scr_eventanim["hostage_pickup"]["pickup_right_stand"] = % "hash_2c87d17e444be8d6";
  level.scr_anim["hostage_pickup"]["pickup_left_crouch"] = % iw9_mp_hostage_pickedup_crouch_4;
  level.scr_eventanim["hostage_pickup"]["pickup_left_crouch"] = % "hash_763bf8b46b8f6ff";
  level.scr_anim["hostage_pickup"]["pickup_left_stand"] = % iw9_mp_hostage_pickedup_stand_4;
  level.scr_eventanim["hostage_pickup"]["pickup_left_stand"] = % "hash_3c9d606392a88b87";
  level.scr_anim["hostage_pickup"]["pickup_front_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_8;
  level.scr_eventanim["hostage_pickup"]["pickup_front_crouch_vm"] = % "hash_2dfeef0aebdfeecd";
  level.scr_anim["hostage_pickup"]["pickup_front_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_8;
  level.scr_eventanim["hostage_pickup"]["pickup_front_stand_vm"] = % "hash_7e016dd39eca5fe5";
  level.scr_anim["hostage_pickup"]["pickup_back_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_2;
  level.scr_eventanim["hostage_pickup"]["pickup_back_crouch_vm"] = % "hash_1a414b9d05f157c3";
  level.scr_anim["hostage_pickup"]["pickup_back_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_2;
  level.scr_eventanim["hostage_pickup"]["pickup_back_stand_vm"] = % "hash_242c761811d89107";
  level.scr_anim["hostage_pickup"]["pickup_right_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_6;
  level.scr_eventanim["hostage_pickup"]["pickup_right_crouch_vm"] = % "hash_716be6cc83bf81c";
  level.scr_anim["hostage_pickup"]["pickup_right_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_6;
  level.scr_eventanim["hostage_pickup"]["pickup_right_stand_vm"] = % "hash_4590693be6e310be";
  level.scr_anim["hostage_pickup"]["pickup_left_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_4;
  level.scr_eventanim["hostage_pickup"]["pickup_left_crouch_vm"] = % "hash_1897e7f4cbc945fd";
  level.scr_anim["hostage_pickup"]["pickup_left_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_4;
  level.scr_eventanim["hostage_pickup"]["pickup_left_stand_vm"] = % "hash_39404f4bc2930c35";
}

function function_d527fa212314e504() {
  if(isDefined(level.mapname) && getdvarint(@ "hash_bf1b18b4b2448e99", 1)) {
    switch (level.mapname) {
      case #"hash_f7a3e0a896bc04b":
      case #"hash_66b7bcbc2686771f":
        return [game["attackers"], game["defenders"]];
      default:
        return [game["defenders"], game["attackers"]];
    }
  }

  return [game["defenders"], game["attackers"]];
}

function initspawns() {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
  [attack, defend] = function_d527fa212314e504();
  scripts\mp\spawnlogic::addstartspawnpoints("mp_rescue_spawn_attacker");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_rescue_spawn_defender");
  scripts\mp\spawnlogic::addspawnpoints(attack, "mp_rescue_spawn_attacker");
  scripts\mp\spawnlogic::addspawnpoints(defend, "mp_rescue_spawn_defender");

  if(level.mapname == "mp_m_speedball" || level.mapname == "mp_m_overunder" || level.mapname == "mp_m_overwinter") {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_defender");
    defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_attacker");
  } else if(level.mapname == "mp_petrograd") {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_attacker");
    defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_defender", 1);
  } else if(istrue(level.var_f1c340dae77ca15d)) {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_attacker", 1);
    defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_defender", 1);
  } else {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_attacker");
    defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_defender");
  }

  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"start");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
  }

  spawnteam = self.pers["team"];
  spawnpoint = undefined;
  [attack, defend] = function_d527fa212314e504();
  var_5d57963b098879cf = defend;
  var_997b6614f3b296b7 = attack;

  if(level.var_385bb8fdab525e2b) {
    var_5d57963b098879cf = attack;
    var_997b6614f3b296b7 = defend;
  }

  if(spawnteam == var_997b6614f3b296b7) {
    scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
  } else {
    scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
  }

  return spawnpoint;
}

function function_45f0bd1189ba467c(mapname) {
  overrideorigins = [];

  switch (mapname) {
    case #"hash_81b84d832a53ee33":
      overrideorigins[0] = (-935, 588, 12);
      overrideorigins[1] = (664, 840, 8);
      return overrideorigins;
    case #"hash_7783d431a1b0c821":
      overrideorigins[0] = (98, -1, 2);
      overrideorigins[1] = (-1709, 285, 48);
      return overrideorigins;
    case #"hash_afcbd31dbcac0848":
      overrideorigins[0] = (-567, 1822, 2);
      overrideorigins[1] = (1633, 1632, 80);
      return overrideorigins;
    case #"hash_8b054465d9648555":
      overrideorigins[0] = (-390, 1992, 546);
      overrideorigins[1] = (-2089, 1093, 570);
      return overrideorigins;
    case #"hash_1373c0a36e3cab54":
      overrideorigins[0] = (28969, -28273, 3174);
      overrideorigins[1] = (29413, -30139, 3174);
      return overrideorigins;
    case #"hash_c860b74f2269590c":
      overrideorigins[0] = (17728, -54048, 1025);
      overrideorigins[1] = (15968, -53632, 1136);
      return overrideorigins;
    case #"hash_bfec720c737b7425":
      overrideorigins[0] = (-9394.5, 7968.5, 304);
      overrideorigins[1] = (-10280, 8656, 344);
      return overrideorigins;
    case #"hash_dfa04d97b4cc9b44":
      overrideorigins[0] = (-9901.26, 43167.5, 234.159);
      overrideorigins[1] = (-7713.92, 44422.1, 241.991);
      return overrideorigins;
    case #"hash_3e552e81b4a21fff":
    case #"hash_3e6dceebd27fedec":
    case #"hash_5586b38644ed9b26":
    case #"hash_6210b3e419ba7028":
    case #"hash_62644ed2dea5cf54":
    case #"hash_7709127773d7af61":
    case #"hash_7e7b98f5c7f2b9a0":
    case #"hash_a11e6e81ea219453":
    case #"hash_a9b94844236a7fd8":
    case #"hash_c8b70146f0c8a9cd":
    case #"hash_d707e2cfc340c376":
    case #"hash_decd2e8ff1f996d7":
    case #"hash_ec2ebc1298ef7373":
      if(isDefined(level.var_d27f667e6320d465)) {
        hostagea = getStruct(level.var_d27f667e6320d465.var_7fdcf3bd51650cf2, "script_noteworthy");
        hostageb = getStruct(level.var_d27f667e6320d465.var_7fdcf2bd51650abf, "script_noteworthy");
      } else {
        hostagea = getStruct("hostage_a", "script_noteworthy");
        hostageb = getStruct("hostage_b", "script_noteworthy");
      }

      if(isDefined(hostagea) && isDefined(hostageb)) {
        return [drop_to_ground(hostagea.origin, 10, -10), drop_to_ground(hostageb.origin, 10, -10)];
      }

      break;
    default:
      break;
  }

  return undefined;
}

function function_f8c926cdeb59f116() {
  hostages = getEntArray("hostage_group_01", "target");
  var_6085a8df9c0e33eb = [];

  if(hostages.size > 0) {
    var_6085a8df9c0e33eb = hostages;

    if(level.numhostages == 1) {
      var_6085a8df9c0e33eb = array_randomize(var_6085a8df9c0e33eb);
    }
  } else {
    var_6085a8df9c0e33eb = getEntArray("hostage_trigger", "targetname");
  }

  level.scriptedtriggers = 0;

  if(var_6085a8df9c0e33eb.size == 0) {
    level.scriptedtriggers = 1;
    level.var_ca4e08767cbdae12 = &function_15a66746e75cc48a;
    hostagea = getStruct("hostage_a", "script_noteworthy");

    if(isDefined(hostagea)) {
      trigger = spawn("script_model", drop_to_ground(hostagea.origin, 10, -20));
      trigger.angles = hostagea.angles;
      trigger.objectivekey = "_a";
      trigger.iconname = "_a";
      var_6085a8df9c0e33eb[var_6085a8df9c0e33eb.size] = trigger;
    }

    hostageb = getStruct("hostage_b", "script_noteworthy");

    if(isDefined(hostageb)) {
      trigger = spawn("script_model", drop_to_ground(hostageb.origin, 10, -20));
      trigger.angles = hostageb.angles;
      trigger.objectivekey = "_b";
      trigger.iconname = "_b";
      var_6085a8df9c0e33eb[var_6085a8df9c0e33eb.size] = trigger;
    }
  }

  overrideorigins = undefined;

  if(getdvarint(@ "hash_9f5fa1a2bee6620e", 1) && !istrue(level.scriptedtriggers)) {
    overrideorigins = function_45f0bd1189ba467c(level.mapname);
  }

  level.planttime = 5;
  var_3800a132040816d1 = 0;

  foreach(trigger in var_6085a8df9c0e33eb) {
    if(var_3800a132040816d1 >= level.numhostages) {
      break;
    }

    if(isDefined(overrideorigins)) {
      trigger.origin = overrideorigins[var_3800a132040816d1];
    }

    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0] setModel("body_civ_me_male_1_1");
    visuals[0] setasgametypeobjective();
    head = spawn("script_model", visuals[0].origin);

    if(istrue(level.scriptedtriggers)) {
      visuals[0].angles = trigger.angles;
      head.linktoenabledflag = 1;
      head makeusable();
      head.var_2768447445db282 = 1;
      hostage = scripts\mp\gameobjects::createcarryobject(game["attackers"], head, visuals, (0, 0, 16), undefined, 1);
    } else {
      hostage = scripts\mp\gameobjects::createcarryobject(game["attackers"], trigger, visuals, (0, 0, 16), undefined, 1);
    }

    head setModel("head_hostage_hood_01");
    head linkTo(visuals[0], "j_neck", (-9, 1, 0), (0, 0, 0));
    hostage.head = head;
    hostage.body = visuals[0];
    hostage.body solid();
    hostage.head solid();
    tracestart = visuals[0].origin + (0, 0, 32);
    traceend = visuals[0].origin + (0, 0, -100);
    contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);
    ignoreents = [visuals[0], trigger];
    trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);

    if(trace["fraction"] < 1) {
      visuals[0].origin = trace["position"] + (0, 0, 2);
    }

    hostage.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
    hostage scripts\mp\gameobjects::requestid(1, 1);
    hostage scripts\mp\gameobjects::allowuse("enemy");
    hostage.cancontestclaim = 0;
    hostage.stalemate = 0;
    hostage.wasstalemate = 1;
    hostage.currprogress = 0;
    hostage.usetime = 0;
    hostage.userate = 1;
    hostage.id = "care_package";
    hostage.exclusiveuse = 0;
    hostage.skiptouching = 1;
    hostage.skipminimapids = 1;
    hostage.curorigin = hostage.body.origin;
    hostage.offset3d = (0, 0, 30);

    if(istrue(level.scriptedtriggers)) {
      head setHintString(&"MP/HOLD_TO_ESCORT_HOSTAGE");
      head setusepriority(-1 - 1 - 1 - 1);
    } else {
      hostage.trigger setHintString(&"MP/HOLD_TO_ESCORT_HOSTAGE");
      hostage.trigger setusepriority(-1 - 1 - 1 - 1);
    }

    hostage scripts\mp\gameobjects::setusetime(0);
    hostage scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
    hostage.allowweapons = 1;
    hostage.onpickup = &function_dc87fdd9e74e945e;
    hostage.ondrop = &function_13db2131b3f0851f;
    hostage.onreset = &function_3cac51c950d63e5d;
    hostage.pickupchecks = [ &function_6201c84e805ab787, &function_a4beda038141b8f8, &function_fda15d11f6baf729, &function_5c8cf2eee42128c8, &function_ed073d24cd8ed3c5];
    hostage.onpickupfailed = &function_23456bcbf6dd329f;
    hostage.var_4bcc694316c44d94 = &function_5c749561016bc2b2;
    hostage.carryobjectasset = "hostage_rescue";

    if(getdvarint(@ "hash_c44109000ed1922d") != 0) {
      hostage scripts\mp\gameobjects::create_manual_drop_data_struct([visuals[0], hostage.head], undefined, undefined, 32, 180, undefined, 0);
    }

    if(isDefined(trigger.objectivekey)) {
      hostage.objectivekey = trigger.objectivekey;
    } else {
      hostage.objectivekey = trigger.script_label;
    }

    hostage scripts\mp\gameobjects::setvisibleteam("none");
    hostage.manualdropdata.pickupchecks[hostage.manualdropdata.pickupchecks.size] = &function_adcec6d9047e4e62;
    hostage.objidpingfriendly = 0;
    hostage.objidpingenemy = 0;
    hostage.objpingdelay = 0.05;
    pingobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    hostage.var_81121fb99d0a00b = pingobjid;
    scripts\mp\objidpoolmanager::objective_add_objective(pingobjid, "done", hostage.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(pingobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(pingobjid, 0);
    hostage scripts\mp\gameobjects::setvisibleteam("none", pingobjid);
    objective_setownerteam(pingobjid, game["defenders"]);
    hostage.objidpingfriendly = 0;
    hostage.objidpingenemy = 0;
    hostage.objpingdelay = 0.05;
    pingobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    hostage.var_bd657a84755765de = pingobjid;
    scripts\mp\objidpoolmanager::objective_add_objective(pingobjid, "done", hostage.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(pingobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(pingobjid, 0);
    hostage scripts\mp\gameobjects::setvisibleteam("none", pingobjid);
    objective_setownerteam(pingobjid, game["attackers"]);
    hostage thread function_a5b7c34a5c2d56d2();

    if(!isDefined(level.hostages)) {
      level.hostages = [];
    }

    level.hostages[hostage.objidnum] = hostage;

    if(level.returnon) {
      function_7d3dbbb99ee466e0(trigger, hostage);
    }

    var_3800a132040816d1++;
  }

  if(getdvarint(@ "hash_7c946185726fb8b", 1)) {
    level thread function_eed7800933a86a6d();
  }
}

function private function_adcec6d9047e4e62(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(scripts\mp\outofbounds::isoob(player)) {
    return false;
  }

  return true;
}

function function_5c749561016bc2b2(hostage) {
  if(getgametype() == "wm") {
    iconfriendly = "waypoint_defend";
    iconenemy = "waypoint_capture";
  } else {
    iconfriendly = "waypoint_defend" + hostage.objectivekey;
    iconenemy = "waypoint_capture" + hostage.objectivekey;
  }

  hostage scripts\mp\gameobjects::setobjectivestatusicons(iconfriendly, iconenemy);
  hostage scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(hostage.var_81121fb99d0a00b, "current");
  hostage scripts\mp\gameobjects::updatecompassicon("enemy", hostage.var_81121fb99d0a00b);
  objective_icon(hostage.var_81121fb99d0a00b, "icon_waypoint_hostage");
}

function function_e94cf520d98ce0e1() {
  level endon("game_ended");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level waittill_any_2("prematch_done", "start_mode_setup");
  }

  if(game["switchedsides"]) {
    setomnvar("ui_rescue_swapped_sides", 1);
  } else {
    setomnvar("ui_rescue_swapped_sides", 0);
  }

  foreach(hostage in level.hostages) {
    function_5c749561016bc2b2(hostage);
    hostage scripts\mp\objidpoolmanager::objective_set_play_intro(hostage.objidnum, 0);
    hostage scripts\mp\objidpoolmanager::objective_set_play_outro(hostage.objidnum, 0);
    hostage scripts\mp\objidpoolmanager::objective_set_pulsate(hostage.objidnum, 1);
  }

  if(level.var_385bb8fdab525e2b) {
    foreach(extract in level.extractzones) {
      extract scripts\mp\gameobjects::allowuse("none");
      extract scripts\mp\gameobjects::setvisibleteam("enemy");
      extract scripts\mp\gameobjects::setobjectivestatusicons(level.iconextract, level.icondefendextract);
      extract scripts\mp\objidpoolmanager::objective_set_play_intro(extract.objidnum, 0);
      extract scripts\mp\objidpoolmanager::objective_set_play_outro(extract.objidnum, 0);
      extract scripts\mp\objidpoolmanager::objective_set_pulsate(extract.objidnum, 1);
    }
  }

  waittime = ter_op(isDefined(level.prematchperiodend), level.prematchperiodend, 10);
  wait waittime;

  foreach(hostage in level.hostages) {
    hostage scripts\mp\objidpoolmanager::objective_set_pulsate(hostage.objidnum, 0);
  }

  if(level.var_385bb8fdab525e2b) {
    foreach(extract in level.extractzones) {
      extract scripts\mp\objidpoolmanager::objective_set_pulsate(extract.objidnum, 0);
    }
  }
}

function function_47c4dd8e0c76b446() {
  switch (level.mapname) {
    case #"hash_766ae2ad3c19d974":
      var_f57a35b32e66c62f = spawnStruct();
      var_f57a36b32e66c862 = spawnStruct();
      var_f57a35b32e66c62f.origin = (-10275, 12623, 523);
      var_f57a36b32e66c862.origin = (-6126, 12958, 482);
      return [var_f57a35b32e66c62f, var_f57a36b32e66c862];
    case #"hash_63d9283f04bd6309":
      var_f57a35b32e66c62f = spawnStruct();
      var_f57a35b32e66c62f.origin = (-402, 114, 0);
      return [var_f57a35b32e66c62f];
    case #"hash_3e552e81b4a21fff":
    case #"hash_3e6dceebd27fedec":
    case #"hash_5586b38644ed9b26":
    case #"hash_6210b3e419ba7028":
    case #"hash_62644ed2dea5cf54":
    case #"hash_7709127773d7af61":
    case #"hash_7e7b98f5c7f2b9a0":
    case #"hash_a11e6e81ea219453":
    case #"hash_a9b94844236a7fd8":
    case #"hash_c8b70146f0c8a9cd":
    case #"hash_d707e2cfc340c376":
    case #"hash_decd2e8ff1f996d7":
    case #"hash_ec2ebc1298ef7373":
      if(isDefined(level.var_d27f667e6320d465)) {
        var_4293650f0c1037d2 = getStruct(level.var_d27f667e6320d465.var_4cb3562e52dd45b8, "script_noteworthy");
      } else {
        var_4293650f0c1037d2 = getStruct("hr_extraction_zone", "script_noteworthy");
      }

      if(isDefined(var_4293650f0c1037d2)) {
        var_f57a35b32e66c62f = spawnStruct();
        var_f57a35b32e66c62f.origin = drop_to_ground(var_4293650f0c1037d2.origin, 10, -20);
        return [var_f57a35b32e66c62f];
      }

      break;
    default:
      break;
  }

  return undefined;
}

function function_7d7b80b0dab99ae0(mapname) {
  switch (mapname) {
    case #"hash_7783d431a1b0c821":
      extract = spawnStruct();
      extract.origin = (-1178, 3116, 4);
      return [extract];
    case #"hash_1373c0a36e3cab54":
      extract = spawnStruct();
      extract.origin = (26840, -30893, 3124);
      return [extract];
    case #"hash_dfa04d97b4cc9b44":
      extract = spawnStruct();
      extract.origin = (-6708, 42009, 209);
      return [extract];
    default:
      return undefined;
  }

  return undefined;
}

function function_b924ba876ae5b152() {
  triggers = undefined;

  if(getdvarint(@ "hash_9f5fa1a2bee6620e", 1)) {
    triggers = function_7d7b80b0dab99ae0(level.mapname);
  }

  if(getdvarint(@ "hash_f41985dc2241f4a", 1) && !isDefined(triggers)) {
    triggers = function_47c4dd8e0c76b446();
  }

  if(!isDefined(triggers)) {
    triggers = getEntArray("hostage_extract", "targetname");
  }

  objectivekeys = ["_a", "_b", "_c"];
  objectivecount = 0;

  foreach(trigger in triggers) {
    var_c8a41ae10dd3b1d2 = game["defenders"];
    visuals[0] = spawn("script_model", trigger.origin);
    exfilgoaltrigger = spawn("trigger_radius", trigger.origin, 0, 120, 60);
    droppoint = exfilgoaltrigger.origin;
    contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
    ignoreents = [];
    trace = scripts\engine\trace::ray_trace(visuals[0].origin + (0, 0, 20), visuals[0].origin - (0, 0, 4000), ignoreents, contentoverride, 0);

    if(isPlayer(trace["entity"])) {
      trace["entity"] = undefined;
    }

    extractscriptable = undefined;

    if(isDefined(trace)) {
      droporigin = trace["position"];

      if(isDefined(self.visualgroundoffset)) {
        droporigin += self.visualgroundoffset;
      }

      extractscriptable = spawnscriptable("rescue_extract", droporigin);
      upangles = vectortoangles(trace["normal"]);
      baseeffectforward = anglesToForward(upangles);
      extractscriptable.angles = generateaxisanglesfromforwardvector(baseeffectforward, extractscriptable.angles);
    }

    exfilgoaltrigger.objectivekey = objectivekeys[objectivecount];
    level.flagmodelhidden = 1;
    extractzone = scripts\mp\gametypes\obj_dom::setupobjective(exfilgoaltrigger, var_c8a41ae10dd3b1d2, 1, 1, 1);
    extractzone scripts\mp\gameobjects::requestid(1, 1);
    extractzone scripts\mp\gameobjects::setownerteam(game["defenders"]);
    extractzone scripts\mp\gameobjects::allowuse("none");
    extractzone.pinobj = 0;
    extractzone.onuse = &extractzone_onuse;
    extractzone.onbeginuse = &extractzone_onusebegin;
    extractzone.usecondition = &function_76ba7e56087a12fd;
    extractzone.var_f56edb5df74ae868 = &function_846b74ec142bdc18;

    if(isDefined(extractscriptable)) {
      extractzone.extractscriptable = extractscriptable;
    }

    if(!isDefined(level.extractzones)) {
      level.extractzones = [];
    }

    level.extractzones[level.extractzones.size] = extractzone;
    objectivecount++;

    if(objectivecount >= level.var_681eabe436c0029d) {
      break;
    }
  }
}

function function_7d3dbbb99ee466e0(trigger, hostage) {
  returntrigger = spawn("trigger_radius", trigger.origin, 0, 120, 80);
  returnzone = scripts\mp\gameobjects::createuseobject(game["defenders"], returntrigger, [], undefined, undefined, 1);
  returnzone.onuse = &function_ccf456cd84b96382;
  returnzone.usetime = 0;
  returnzone scripts\mp\gameobjects::requestid(1, 1);
  returnzone scripts\mp\gameobjects::setownerteam(game["defenders"]);
  returnzone scripts\mp\gameobjects::allowuse("none");
  returnzone scripts\mp\gameobjects::setvisibleteam("none");

  if(!isDefined(level.returnzones)) {
    level.returnzones = [];
  }

  level.returnzones[hostage.objidnum] = returnzone;
}

function function_8c59ada73fb15ed7(player, pingwalk) {
  self notify("head_icon_watch");
  self endon("head_icon_watch");
  self endon("hostage_extracted");
  self endon("dropped");
  player endon("death");
  iconset = 0;
  pingtime = getdvarfloat(@ "hash_4a679c3fea6cccf", 4);

  if(!isalive(player) || isinlaststand(player) || !istrue(player.hashostage)) {
    return;
  }

  self.offset3d = (0, 0, 0);
  self.origin = self.curorigin;
  trackedobject = scripts\mp\gameobjects::createtrackedobject(player, (0, 0, 100));
  scripts\mp\objidpoolmanager::objective_set_play_intro(trackedobject.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(trackedobject.objidnum, 0);
  trackedobject.objidpingfriendly = 1;
  trackedobject.objidpingenemy = 0;
  trackedobject.objpingdelay = pingtime;
  trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconreturn);
  trackedobject scripts\mp\gameobjects::setvisibleteam("friendly");
  self.trackedobject = trackedobject;

  if(level.showenemycarrier) {
    trackedobject.pingobjidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    scripts\mp\objidpoolmanager::objective_add_objective(trackedobject.pingobjidnum, "current", player.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(trackedobject.pingobjidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(trackedobject.pingobjidnum, 0);
    objective_setownerteam(trackedobject.pingobjidnum, player.team);
    trackedobject scripts\mp\gameobjects::updatecompassicon("enemy", trackedobject.pingobjidnum);
    objective_icon(trackedobject.pingobjidnum, level.waypointshader["rescue_kill_carrier"]);
    scripts\mp\objidpoolmanager::update_objective_setenemylabel(trackedobject.pingobjidnum, level.waypointstring["rescue_kill_carrier"]);
    objective_state(trackedobject.pingobjidnum, "current");
  }

  thread function_da3da0004950e970(trackedobject, 2);
}

function function_8277f49f79bff530(animname, spawnpos, spawnang) {
  self.animname = animname;

  if(!isDefined(spawnpos)) {
    spawnpos = (0, 0, 0);
  }

  if(!isDefined(spawnang)) {
    spawnang = (0, 0, 0);
  }

  if(isPlayer(self)) {
    self function_b88c89bb7cd1ab8e(spawnpos);
  }

  var_e3bda5be1db297f = spawn("script_arms", spawnpos, 0, 0, self);
  var_e3bda5be1db297f.angles = spawnang;
  var_e3bda5be1db297f.player = self;
  self.var_e3bda5be1db297f = var_e3bda5be1db297f;
  self.var_e3bda5be1db297f.animname = animname;
  self.var_e3bda5be1db297f useanimtree(#animtree);
  self.var_e3bda5be1db297f.updatedversion = 1;
  self playerlinktoabsolute(self.var_e3bda5be1db297f, "tag_player");
  self notify("rig_created");
  waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(self)) {
    self unlink();
    function_5471a04faad16a00();
    thread scripts\cp_mp\utility\inventory_utility::takegunlessweapon();
  }

  if(isDefined(var_e3bda5be1db297f)) {
    var_e3bda5be1db297f delete();
  }
}

function function_a3a4a2cdca554483(animname, spawnpos, spawnang) {
  self.animname = animname;

  if(!isDefined(spawnpos)) {
    spawnpos = (0, 0, 0);
  }

  if(!isDefined(spawnang)) {
    spawnang = (0, 0, 0);
  }

  if(isPlayer(self)) {
    self function_b88c89bb7cd1ab8e(spawnpos);
  }

  var_54d7b76a2a71e284 = spawn("script_arms", spawnpos, 0, 0, self);
  var_54d7b76a2a71e284.angles = spawnang;
  var_54d7b76a2a71e284.player = self;
  self.var_54d7b76a2a71e284 = var_54d7b76a2a71e284;
  self.var_54d7b76a2a71e284.animname = animname;
  self.var_54d7b76a2a71e284 useanimtree(#animtree);
  self.var_54d7b76a2a71e284.updatedversion = 1;
  self playerlinktoblend(self.var_54d7b76a2a71e284, "tag_player", 0.5, 0, 0.25);
  self notify("rig_created");
  waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(self)) {
    self unlink();
    function_5471a04faad16a00();
    thread scripts\cp_mp\utility\inventory_utility::takegunlessweapon();
  }

  if(isDefined(var_54d7b76a2a71e284)) {
    var_54d7b76a2a71e284 delete();
  }
}

function function_8f65ac94aafe5d3e(animname, spawnpos, spawnang) {
  self.animname = animname;

  if(!isDefined(spawnpos)) {
    spawnpos = (0, 0, 0);
  }

  if(!isDefined(spawnang)) {
    spawnang = (0, 0, 0);
  }

  var_fc77a3ee1c3e72b5 = spawn("script_model", spawnpos);
  var_fc77a3ee1c3e72b5.angles = spawnang;
  var_fc77a3ee1c3e72b5 setModel("body_civ_me_male_1_1");
  self.var_fc77a3ee1c3e72b5 = var_fc77a3ee1c3e72b5;
  self.var_fc77a3ee1c3e72b5.animname = animname;
  self.var_fc77a3ee1c3e72b5 useanimtree(#animtree);
  self.var_fc77a3ee1c3e72b5.updatedversion = 1;
  head = spawn("script_model", spawnpos);
  head setModel("head_hostage_hood_01");
  self.var_fc77a3ee1c3e72b5.head = head;
  self notify("rig_created");
  waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(head)) {
    head unlink();
    head delete();
  }

  if(isDefined(var_fc77a3ee1c3e72b5)) {
    var_fc77a3ee1c3e72b5 delete();
  }
}

function function_3b8913dc82881267(player) {
  animlength = 0;
  stance = player getstance();

  if(stance == "prone") {
    player setstance("crouch", 1, 1);
    stance = "crouch";
  }

  player.switchweapon = player getcurrentweapon();
  fists = makeweapon("iw9_gunless_mp");
  player giveweapon(fists);
  player.var_73f4b954751a8643 = fists;
  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(fists, 1, 1);
  tmporigin = (self.body.origin[0], self.body.origin[1], player.origin[2]);
  directionvector = vectorNormalize(player.origin - tmporigin);
  var_82b4f01ce94ed444 = vectordot(directionvector, anglesToForward(self.body.angles));
  var_8288e81ce91e5c46 = vectordot(directionvector, anglestoright(self.body.angles));
  self.body scriptmodelclearanim();
  var_14aea8523fa938ba = (player.origin[0], player.origin[1], self.body.origin[2]);
  var_f514603feaf5c1e2 = player getmovingplatformparent();
  var_8a9148be19028afa = isDefined(var_f514603feaf5c1e2) && scripts\cp_mp\utility\killstreak_utility::function_63bdc8c411a85475(var_f514603feaf5c1e2);

  if(var_8a9148be19028afa) {
    var_14aea8523fa938ba = (player.origin[0], player.origin[1], player.origin[2]);
  }

  self.body.origin = var_14aea8523fa938ba + anglesToForward(player.angles) * 34.672;
  anime = "pickup_back_stand";
  var_cf13edffb05efcd8 = "pickup_back_stand_vm";

  if(var_82b4f01ce94ed444 >= 0.707) {
    anime = "pickup_front_" + stance;
    var_cf13edffb05efcd8 = "pickup_front_" + stance + "_vm";
    directiontoplayer = vectorNormalize(player.origin - self.body.origin);
    var_318eea579595b65e = scripts\mp\utility\script::vectortoanglessafe(directiontoplayer, anglestoup(self.body.angles));
    self.body.angles = var_318eea579595b65e;
  } else if(var_82b4f01ce94ed444 <= -0.707) {
    anime = "pickup_back_" + stance;
    var_cf13edffb05efcd8 = "pickup_back_" + stance + "_vm";
    var_81554c014ce7839c = vectorNormalize(self.body.origin - player.origin);
    var_318eea579595b65e = scripts\mp\utility\script::vectortoanglessafe(var_81554c014ce7839c, anglestoup(self.body.angles));
    self.body.angles = var_318eea579595b65e;
  } else if(var_8288e81ce91e5c46 >= 0.707) {
    anime = "pickup_right_" + stance;
    var_cf13edffb05efcd8 = "pickup_right_" + stance + "_vm";
    var_81554c014ce7839c = vectorcross(vectorNormalize(self.body.origin - player.origin), anglestoup(self.body.angles));
    var_318eea579595b65e = scripts\mp\utility\script::vectortoanglessafe(var_81554c014ce7839c, anglestoup(self.body.angles));
    self.body.angles = var_318eea579595b65e;
  } else if(var_8288e81ce91e5c46 <= -0.707) {
    anime = "pickup_left_" + stance;
    var_cf13edffb05efcd8 = "pickup_left_" + stance + "_vm";
    directiontoplayer = vectorcross(vectorNormalize(player.origin - self.body.origin), anglestoup(self.body.angles));
    var_318eea579595b65e = scripts\mp\utility\script::vectortoanglessafe(directiontoplayer, anglestoup(self.body.angles));
    self.body.angles = var_318eea579595b65e;
  }

  player thread function_8277f49f79bff530("player_pickup_hostage", player.origin, player.angles);
  player.var_e3bda5be1db297f hide();
  player thread function_a3a4a2cdca554483("player_pickup_hostage", player.origin, player.angles);

  if(player getcamerathirdperson()) {
    player.var_54d7b76a2a71e284 hide();
  } else {
    player.var_54d7b76a2a71e284 showonlytoplayer(player);
  }

  thread function_8f65ac94aafe5d3e("hostage_pickup", self.body.origin, self.body.angles);
  self.var_fc77a3ee1c3e72b5 hide();
  self.var_fc77a3ee1c3e72b5 showonlytoplayer(player);

  if(isDefined(self.var_fc77a3ee1c3e72b5.head)) {
    self.var_fc77a3ee1c3e72b5.head hide();
    self.var_fc77a3ee1c3e72b5.head showonlytoplayer(player);
    self.var_fc77a3ee1c3e72b5.head linkTo(self.var_fc77a3ee1c3e72b5, "j_neck", (-9, 1, 0), (0, 0, 0));
  }

  self.body.animname = "hostage_pickup";
  self.body useanimtree(level.scr_animtree["hostage_pickup"]);
  self.body.hasanimtree = 1;
  self.body hidefromplayer(player);
  self.head hidefromplayer(player);
  animstruct = spawnStruct();
  animstruct.origin = player.origin;
  animstruct.angles = player.angles;

  if(var_8a9148be19028afa) {
    self.var_fc77a3ee1c3e72b5 linkTo(var_f514603feaf5c1e2);
    player.var_54d7b76a2a71e284 linkTo(var_f514603feaf5c1e2);
    player playerlinkedoffsetenable();
  }

  animstruct thread scripts\mp\anim::anim_player_solo(player, player.var_e3bda5be1db297f, anime);
  animstruct thread scripts\common\anim::anim_single_solo(player.var_54d7b76a2a71e284, var_cf13edffb05efcd8);
  self.body thread scripts\common\anim::anim_single_solo(self.body, anime);
  self.var_fc77a3ee1c3e72b5 thread scripts\common\anim::anim_single_solo(self.var_fc77a3ee1c3e72b5, var_cf13edffb05efcd8);
  wait getanimlength(level.scr_anim["player_pickup_hostage"][var_cf13edffb05efcd8]);

  if(var_8a9148be19028afa) {
    self.var_fc77a3ee1c3e72b5 unlink();
    player.var_54d7b76a2a71e284 unlink();
    player playerlinkedoffsetdisable();
  }

  player notify("remove_rig");
  self notify("remove_rig");
  self.body stopuseanimtree();
  self.body.hasanimtree = undefined;
  player.var_73f4b954751a8643 = undefined;
  player takeweapon(fists);
}

function function_dc87fdd9e74e945e(player, playervo, defused) {
  player.startedpickup = 1;
  thread function_d2ee5ef1475dc79b(player, playervo, defused);
}

function function_d2ee5ef1475dc79b(player, playervo, defused) {
  self notify("hostage_pickup");
  player endon("death_or_disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("hostage_pickup");
  player.hashostage = 1;
  self.carrier = player;
  player setclientomnvar("ui_rescue_carrying_hostage", 1);

  if(!isDefined(level.var_7fcc5417218ad4c8)) {
    level.var_7fcc5417218ad4c8 = [];
  }

  if(level.var_7fcc5417218ad4c8.size == 0) {
    foreach(person in level.players) {
      if(person.team == player.team) {
        person setclientomnvar("ui_rescue_hostage_active", 1);
        continue;
      }

      person setclientomnvar("ui_rescue_hostage_active", 2);
    }
  }

  level.var_7fcc5417218ad4c8[self.objidnum] = self;
  self.body show();
  self.head show();
  player val::reset_all("carry");
  player val::set("carry", "equipment_secondary", 0);
  player val::set("carry", "equipment_primary", 0);
  player val::set("carry", "supers", 0);
  player val::set("carry", "killstreaks", 0);
  player val::set("carry", "melee", 0);
  player val::set("carry", "prone", 0);
  player val::set("carry", "slide", 0);
  player val::set("carry", "supersprint", 0);
  player val::set("carry", "mount_side", 0);
  player val::set("carry", "mount_top", 0);
  player val::set("carry", "mantle", 0);
  player val::set("carry", "swimming_underwater", 0);
  player val::set("carry", "dtp", 0);
  player val::set("carry", "ladder", 0);
  player val::set("carry", "weapon_pickup", 0);
  player val::set("carry", "weapon_switch", 0);
  player val::set("carry", "weapon_switch_clip", 0);
  player val::set("carry", "execution_victim", 0);
  player val::set("carry", "ads", 1);
  self.var_44206360497f15c2 = 1;
  function_3b8913dc82881267(player);
  self.var_44206360497f15c2 = undefined;

  foreach(hostage in level.hostages) {
    if(hostage.objectivekey != self.objectivekey) {
      hostage.trigger disableplayeruse(player);
    }
  }

  self.body scriptmodelclearanim();
  self.body hide();
  self.head hide();
  function_83dfc273b8e7efed(player);
  player setcarryobject(self.carryobjectasset);
  team = player.pers["team"];
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setvisibleteam("none", self.var_81121fb99d0a00b);
  scripts\mp\gameobjects::setownerteam(player.team);
  pingwalk = getdvarint(@ "hash_4cb6c41a033baba9", 0);
  thread function_8c59ada73fb15ed7(player, pingwalk);

  if(isDefined(level.revivetriggers)) {
    foreach(revivetrigger in level.revivetriggers) {
      revivetrigger disablescriptableplayeruse(player);
    }
  }

  if(!player scripts\mp\utility\killstreak::isjuggernaut()) {
    player.playerstreakspeedscale = -0.15;
    player setmovespeedscale(0.85);
  }

  thread function_7bc240fc69ea5205(player);
  thread scripts\mp\hud_util::function_7b2653a588f28e29(player, "rescue_player_hostage", "rescue_team_hostage", "rescue_took_hostage");

  if(team == game["defenders"] && level.returnon) {
    level.var_8f21d2090cbc3b2a = 0;

    foreach(extract in level.extractzones) {
      if(isDefined(extract.var_53d907bf6d19394e) && isDefined(extract.var_53d907bf6d19394e[self.objidnum])) {
        extract.var_53d907bf6d19394e[self.objidnum] = undefined;
        extract.numtouching[game["attackers"]]--;

        if(extract.var_53d907bf6d19394e.size <= 0) {
          extract scripts\mp\gameobjects::allowuse("none");
          extract scripts\mp\gameobjects::setvisibleteam("none");
        }

        break;
      }
    }

    level.returnzones[self.objidnum] scripts\mp\objidpoolmanager::objective_set_play_intro(level.returnzones[self.objidnum].objidnum, 0);
    level.returnzones[self.objidnum] scripts\mp\objidpoolmanager::objective_set_play_outro(level.returnzones[self.objidnum].objidnum, 0);
    level.returnzones[self.objidnum] scripts\mp\gameobjects::setvisibleteam("friendly");
    level.returnzones[self.objidnum] scripts\mp\gameobjects::allowuse("friendly");
    level.returnzones[self.objidnum] scripts\mp\gameobjects::setobjectivestatusicons(level.iconreturn);
    return;
  }

  foreach(extract in level.extractzones) {
    if(!istrue(level.var_7f1c1334377daad5)) {
      extract scripts\mp\objidpoolmanager::objective_set_play_intro(extract.objidnum, 1);
      extract scripts\mp\objidpoolmanager::objective_set_play_outro(extract.objidnum, 1);
    } else {
      extract scripts\mp\objidpoolmanager::objective_set_play_intro(extract.objidnum, 0);
      extract scripts\mp\objidpoolmanager::objective_set_play_outro(extract.objidnum, 0);
    }

    extract scripts\mp\gameobjects::allowuse("friendly");
    extract scripts\mp\gameobjects::setvisibleteam("any");
    extract scripts\mp\gameobjects::setobjectivestatusicons(level.iconextract, level.icondefendextract);
    extract.extractscriptable setscriptablepartstate("rescue_extract", "idle");
    thread function_da3da0004950e970(extract, 2);
  }

  level.var_7f1c1334377daad5 = 1;

  if(getdvarint(@ "hash_a75075ff09347a5a", 1)) {
    thread function_6d799e269b621800(player);
  }

  player.startedpickup = undefined;
}

function function_23456bcbf6dd329f(player) {
  player scripts\mp\hud_message::showerrormessage("MP/DENY_CARRY_OBJECT");
}

function private function_7bc240fc69ea5205(player) {
  self notify("rescue_trigger_pickup_sound");
  self endon("rescue_trigger_pickup_sound");
  self endon("dropped");
  level endon("game_ended");

  if(isDefined(player)) {
    team = player.pers["team"];
    otherteam = scripts\mp\utility\game::getotherteam(team)[0];
    printandsoundoneveryone(team, otherteam, undefined, undefined, "iw9_mp_prisoner_pickup", "iw9_mp_prisoner_taken", player);
    waittime = getdvarfloat(@ "hash_9ae09c23fdc10452", 0.5);

    if(waittime > 0) {
      wait waittime;
    }

    if(!istrue(level.gameended)) {
      if(isDefined(team)) {
        scripts\mp\utility\dialog::leaderdialog("hostage_taken_friendly", team);
      }

      if(isDefined(otherteam)) {
        scripts\mp\utility\dialog::leaderdialog("hostage_taken_enemy", otherteam);
      }
    }
  }
}

function function_6d799e269b621800(carryplayer) {
  carryplayer endon("death_or_disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("hostage_pickup");
  self endon("hostage_extracted");
  sweepcount = getdvarint(@ "hash_8c20d20855246445", 2);
  var_460d919302cea625 = getdvarint(@ "hash_397db1642965b6ef", 0);
  var_5621f114739b01b9 = getdvarint(@ "hash_85dfe5454ef66256", 1);

  if(var_460d919302cea625) {
    foreach(player in level.players) {
      if(player.pers["team"] == carryplayer.team) {
        player.radarshowenemydirection = 1;
      }
    }
  }

  while(sweepcount > 0 || var_5621f114739b01b9) {
    if(getdvarint(@ "hash_f45c0a46b4a12087", 1)) {
      triggerportableradarpingteam(carryplayer.origin, carryplayer.team, 1000);
    } else {
      triggerportableradarping(carryplayer.origin, carryplayer, 1000);
    }

    sweepcount--;
    wait 2;
  }

  if(var_460d919302cea625) {
    foreach(player in level.players) {
      if(player.pers["team"] == carryplayer.team) {
        player.radarshowenemydirection = 0;
      }
    }
  }
}

function function_83dfc273b8e7efed(player) {
  currentweapons = player getweaponslistprimaries();
  pistol = undefined;

  foreach(weap in currentweapons) {
    if(scripts\mp\utility\weapon::getweapongroup(weap) == "weapon_pistol" && !scripts\mp\utility\weapon::isakimbo(weap)) {
      pistol = weap;
      break;
    }
  }

  if(isDefined(pistol)) {
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(pistol, undefined, 1);
    player.switchweapon = pistol;
    return;
  }

  if(!player hasweapon("iw9_me_fists_mp")) {
    fistweapon = makeweapon("iw9_me_fists_mp");
    player giveweapon(fistweapon);
    player.givenweapon = fistweapon;
  } else {
    fistweapon = "iw9_me_fists_mp";
  }

  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(fistweapon, undefined, 1);
  scripts\cp_mp\weapon::fixupplayerweapons(player, fistweapon);
}

function function_524f22fe698eeb0f(player) {
  player endon("death_or_disconnect");
  player val::set("carry", "weapon_switch", 1);
  player forceplaygestureviewmodel("iw9_ges_hostage_pickup_out", undefined, 0, undefined, 1, 1);
  player resetcarryobject();

  while(istrue(player.ishaywire)) {
    waitframe();
  }

  gunless = makeweapon("iw9_gunless_mp");
  player giveweapon(gunless);
  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, undefined, 1);

  if(isDefined(player.givenweapon)) {
    player takeweapon(player.givenweapon);
    player.givenweapon = undefined;
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player.switchweapon);
  } else {
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player.switchweapon);
  }

  if(isDefined(player.switchweapon)) {
    player.switchweapon = undefined;
  }

  player scripts\common\values::reset_all("carry");
  player takeweapon(gunless);
}

function function_13db2131b3f0851f(player, var_20034b7333f48b8c, manualdrop) {
  player.startedpickup = undefined;
  thread function_3d86750123dc1f90(player, var_20034b7333f48b8c, istrue(self.manualdrop));
}

function function_3d86750123dc1f90(player, var_20034b7333f48b8c, manualdrop) {
  self notify("prompt_cleanup");
  player notify("remove_rig");
  self notify("remove_rig");
  self notify("hostage_pickup");
  self endon("death");
  self endon("hostage_extracted");
  level endon("game_ended");

  if(isDefined(player) && !player scripts\mp\utility\killstreak::isjuggernaut()) {
    player.playerstreakspeedscale = 0;
    player setmovespeedscale(1);
  }

  if(!istrue(manualdrop) && !istrue(var_20034b7333f48b8c)) {
    scripts\mp\utility\dialog::leaderdialog("dropped_hostage_defend", game["attackers"]);
    scripts\mp\utility\dialog::leaderdialog("dropped_hostage_retrieve", game["defenders"]);
  }

  scripts\mp\gameobjects::setownerteam(game["attackers"]);
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setvisibleteam("none", self.var_81121fb99d0a00b);

  if(isDefined(self.trackedobject)) {
    if(isDefined(self.trackedobject.pingobjidnum)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(self.trackedobject.pingobjidnum);
      self.trackedobject.pingobjidnum = undefined;
    }

    self.trackedobject scripts\mp\gameobjects::deletetrackedobject();
    self.trackedobject = undefined;
  }

  if(isDefined(player)) {
    foreach(hostage in level.hostages) {
      hostage.trigger enableplayeruse(player);
    }
  }

  if(isDefined(player)) {
    if(isreallyalive(player)) {
      thread function_524f22fe698eeb0f(player);
    } else {
      player val::reset_all("carry");

      if(isDefined(player.givenweapon)) {
        player takeweapon(player.givenweapon);
        player.givenweapon = undefined;
      }

      if(isDefined(player.switchweapon)) {
        player.switchweapon = undefined;
      }

      player resetcarryobject();
    }

    player.hashostage = undefined;
    player setclientomnvar("ui_rescue_carrying_hostage", 0);

    if(isDefined(level.revivetriggers)) {
      foreach(revivetrigger in level.revivetriggers) {
        if(isDefined(revivetrigger.ownerteam) && revivetrigger.ownerteam == player.team) {
          revivetrigger enablescriptableplayeruse(player);
        }
      }
    }
  }

  if(isDefined(level.var_7fcc5417218ad4c8) && isDefined(level.var_7fcc5417218ad4c8[self.objidnum])) {
    level.var_7fcc5417218ad4c8[self.objidnum] = undefined;
  }

  if(isDefined(level.var_7fcc5417218ad4c8) && level.var_7fcc5417218ad4c8.size <= 0) {
    foreach(person in level.players) {
      person setclientomnvar("ui_rescue_hostage_active", 0);
    }

    foreach(extract in level.extractzones) {
      extract scripts\mp\gameobjects::allowuse("none");

      if(level.var_385bb8fdab525e2b) {
        extract scripts\mp\gameobjects::setvisibleteam("enemy");
        level thread function_da3da0004950e970(extract, 2);
        continue;
      }

      extract scripts\mp\gameobjects::setvisibleteam("none");
      extract.extractscriptable setscriptablepartstate("rescue_extract", "off");
    }
  }

  thread function_a5b7c34a5c2d56d2();

  if(istrue(self.var_44206360497f15c2) || !isDefined(player)) {
    self.var_44206360497f15c2 = undefined;
    self.body scriptmodelclearanim();
    scripts\mp\gameobjects::allowuse("enemy");
    function_5c749561016bc2b2(self);

    if(isDefined(player) && isDefined(player.var_73f4b954751a8643)) {
      player takeweapon(player.var_73f4b954751a8643);
    }

    waitframe();

    if(!istrue(self.var_1d85141d8703f5d4)) {
      self.head show();

      if(istrue(self.body.hasanimtree)) {
        self.body stopuseanimtree();
        self.body.hasanimtree = undefined;
      }

      self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
    }

    return;
  }

  animlength = undefined;

  if(!istrue(self.var_1d85141d8703f5d4)) {
    movingplatform = player getmovingplatformparent();

    if(isDefined(player) && scripts\cp_mp\utility\killstreak_utility::function_3c5c5d86ef14420e(movingplatform)) {
      self.var_90758efde9b783b7 = spawn("script_origin", self.body.origin);
      self.var_90758efde9b783b7 linkTo(movingplatform);
      self.body linkTo(self.var_90758efde9b783b7);
      thread function_333f22ba123f0470(player);
    }

    self.body.angles = player.angles;
    self.body.origin = player.origin;

    if(istrue(level.scriptedtriggers)) {
      self.head linkTo(self.body, "j_neck", (-9, 1, 0), (0, 0, 0));
    }

    self.head show();
    self.body scriptmodelclearanim();

    if(player getstance() == "stand") {
      if(istrue(self.body.hasanimtree)) {
        self.body stopuseanimtree();
        self.body.hasanimtree = undefined;
      }

      self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_dropped_stand");
      animlength = getanimlength(%iw9_mp_hostage_dropped_stand) - 1;
    } else if(player getstance() == "crouch") {
      if(istrue(self.body.hasanimtree)) {
        self.body stopuseanimtree();
        self.body.hasanimtree = undefined;
      }

      self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_dropped_crouch");
      animlength = getanimlength(%iw9_mp_hostage_dropped_crouch) - 1;
    }
  }

  if(isDefined(animlength)) {
    wait animlength;
  }

  self.curorigin = self.body.origin;
  self.offset3d = (0, 0, 30);
  scripts\mp\gameobjects::allowuse("enemy");
  function_5c749561016bc2b2(self);
  self.head show();

  if(istrue(self.body.hasanimtree)) {
    self.body stopuseanimtree();
    self.body.hasanimtree = undefined;
  }

  self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
}

function function_333f22ba123f0470(player) {
  self endon("hostage_pickup");
  thread function_a29878fb7affbc16(player);

  while(true) {
    self.trigger.origin = self.var_90758efde9b783b7.origin;
    wait 0.01;
  }
}

function function_a29878fb7affbc16(player) {
  level endon("disconnect");
  self waittill("hostage_pickup");
  self.var_90758efde9b783b7 unlink();
  self.body unlink();
  self.var_90758efde9b783b7 delete();
}

function function_4988b37643f2672f(player) {
  self notify("prompt_cleanup");
  player notify("remove_rig");
  self notify("remove_rig");
  self notify("hostage_pickup");
  isoob = undefined;

  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers) {
      if(istrue(self.allowedintrigger)) {
        break;
      }

      if(!self.visuals[0] istouching(trigger)) {
        continue;
      }

      self.body scriptmodelclearanim();
      isoob = 1;
      break;
    }
  }

  foreach(trigger in level.hurttriggers) {
    if(!self.visuals[0] istouching(trigger)) {
      continue;
    }

    isoob = 1;
    break;
  }

  if(isDefined(player) && !player scripts\mp\utility\killstreak::isjuggernaut()) {
    player.playerstreakspeedscale = 0;
    player setmovespeedscale(1);
  }

  if(istrue(isoob) && getdvarint(@ "hash_6e4b1f8aaddcc6f5", 1) == 1) {
    self.head show();
    self.body show();
    neworigin = getclosestpointonnavmesh(self.visuals[0].origin);
    self.body.origin = neworigin;
    self.body.angles = (0, self.body.angles[1], 0);
    self.body scriptmodelclearanim();

    if(istrue(self.body.hasanimtree)) {
      self.body stopuseanimtree();
      self.body.hasanimtree = undefined;
    }

    self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
  }

  scripts\mp\gameobjects::setownerteam(game["attackers"]);
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setvisibleteam("none", self.var_81121fb99d0a00b);

  if(isDefined(self.trackedobject)) {
    if(isDefined(self.trackedobject.pingobjidnum)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(self.trackedobject.pingobjidnum);
      self.trackedobject.pingobjidnum = undefined;
    }

    self.trackedobject scripts\mp\gameobjects::deletetrackedobject();
    self.trackedobject = undefined;
  }

  if(isDefined(player)) {
    foreach(hostage in level.hostages) {
      hostage.trigger enableplayeruse(player);
    }
  }

  if(isDefined(player)) {
    if(isreallyalive(player)) {
      thread function_524f22fe698eeb0f(player);
    } else {
      player val::reset_all("carry");

      if(isDefined(player.givenweapon)) {
        player takeweapon(player.givenweapon);
        player.givenweapon = undefined;
      }

      if(isDefined(player.switchweapon)) {
        player.switchweapon = undefined;
      }

      player resetcarryobject();
    }

    player.hashostage = undefined;
    player setclientomnvar("ui_rescue_carrying_hostage", 0);

    if(isDefined(level.revivetriggers)) {
      foreach(revivetrigger in level.revivetriggers) {
        revivetrigger enablescriptableplayeruse(player);
      }
    }
  }

  if(isDefined(level.var_7fcc5417218ad4c8) && isDefined(level.var_7fcc5417218ad4c8[self.objidnum])) {
    level.var_7fcc5417218ad4c8[self.objidnum] = undefined;
  }

  if(isDefined(level.var_7fcc5417218ad4c8) && level.var_7fcc5417218ad4c8.size <= 0) {
    foreach(person in level.players) {
      person setclientomnvar("ui_rescue_hostage_active", 0);
    }

    foreach(extract in level.extractzones) {
      extract scripts\mp\gameobjects::allowuse("none");

      if(level.var_385bb8fdab525e2b) {
        extract scripts\mp\gameobjects::setvisibleteam("enemy");
        level thread function_da3da0004950e970(extract, 2);
        continue;
      }

      extract scripts\mp\gameobjects::setvisibleteam("none");
      extract.extractscriptable setscriptablepartstate("rescue_extract", "off");
    }
  }

  thread function_a5b7c34a5c2d56d2();

  if(istrue(self.var_44206360497f15c2) || !isDefined(player)) {
    self.var_44206360497f15c2 = undefined;
    self.body scriptmodelclearanim();
    self.curorigin = self.body.origin;
    self.offset3d = (0, 0, 30);
    scripts\mp\gameobjects::allowuse("enemy");
    function_5c749561016bc2b2(self);

    if(isDefined(player) && isDefined(player.var_73f4b954751a8643)) {
      player takeweapon(player.var_73f4b954751a8643);
    }

    waitframe();

    if(!istrue(isoob)) {
      self.head show();

      if(istrue(self.body.hasanimtree)) {
        self.body stopuseanimtree();
        self.body.hasanimtree = undefined;
      }

      self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
    }

    return;
  }

  movingplatform = player getmovingplatformparent();

  if(isDefined(player) && scripts\cp_mp\utility\killstreak_utility::function_3c5c5d86ef14420e(movingplatform)) {
    self.var_90758efde9b783b7 = spawn("script_origin", self.body.origin);
    self.var_90758efde9b783b7 linkTo(movingplatform);
    self.body linkTo(self.var_90758efde9b783b7);
    thread function_333f22ba123f0470(player);
  }

  self.curorigin = self.body.origin;
  self.offset3d = (0, 0, 30);
  scripts\mp\gameobjects::allowuse("enemy");
  function_5c749561016bc2b2(self);

  if(!istrue(isoob)) {
    self.head show();

    if(istrue(self.body.hasanimtree)) {
      self.body stopuseanimtree();
      self.body.hasanimtree = undefined;
    }

    self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
  }
}

function function_c7edff9e8aebcc86(player, manualdropdata) {
  offsetangle = manualdropdata.var_5338ab800fa9b63a;
  dropdist = manualdropdata.dropdist;
  ignoreents = [];

  if(isDefined(manualdropdata.ignoreents)) {
    ignoreents = manualdropdata.ignoreents;
  }

  ignoreents[ignoreents.size] = player;
  trace = undefined;
  height = player getEye()[2] - player.origin[2];
  end = player.origin + (0, 0, height / 2);
  forward = anglesToForward(player getplayerangles());
  x = forward[0] * cos(offsetangle) - forward[1] * sin(offsetangle);
  y = forward[0] * sin(offsetangle) + forward[1] * cos(offsetangle);
  newforward = (x, y, 0);
  endvector = dropdist * vectorNormalize(newforward);
  height = player getEye()[2] - player.origin[2];
  start = player.origin + (0, 0, height / 2);
  end = start + endvector;
  trace = scripts\engine\trace::sphere_trace(start, end, height / 2 - 1, ignoreents);

  if(!isDefined(trace)) {
    return false;
  }

  if(trace["fraction"] < 1) {
    return false;
  }

  secondtrace = scripts\engine\trace::ray_trace(end, end - (0, 0, height), ignoreents);

  if(isDefined(secondtrace["position"]) && scripts\mp\outofbounds::ispointinoutofbounds(secondtrace["position"])) {
    return false;
  }

  if(vectordot(secondtrace["normal"], (0, 0, 1)) > 0.8) {
    return true;
  }

  return false;
}

function function_3cac51c950d63e5d() {
  self.head show();
  self.body show();

  if(istrue(self.body.hasanimtree)) {
    self.body stopuseanimtree();
    self.body.hasanimtree = undefined;
  }

  self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
}

function function_846b74ec142bdc18() {
  assert(self.claimteam != "<dev string:x1c>");
  team = self.claimteam;
  defaultplayer = self.claimplayer;

  if(self.touchlist[team].size > 0) {
    players = getarraykeys(self.touchlist[team]);

    for(index = 0; index < players.size; index++) {
      touchdata = self.touchlist[team][players[index]];

      if(isDefined(touchdata.player) && isreallyalive(touchdata.player) && istrue(touchdata.player.hashostage)) {
        return touchdata.player;
      }
    }
  }

  return defaultplayer;
}

function extractzone_onuse(credit_player, team) {
  if(!isDefined(credit_player) || !isreallyalive(credit_player) || !istrue(credit_player.hashostage)) {
    return;
  }

  if(!isDefined(team)) {
    team = credit_player.team;
  }

  credit_player notify("manual_drop_cleanup");
  hostage = credit_player.carryobject;
  hostage notify("hostage_extracted");
  hostage notify("manual_drop_cleanup");
  thread function_524f22fe698eeb0f(credit_player);

  if(isDefined(hostage.trackedobject)) {
    if(isDefined(hostage.trackedobject.pingobjidnum)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(hostage.trackedobject.pingobjidnum);
      hostage.trackedobject.pingobjidnum = undefined;
    }

    hostage.trackedobject scripts\mp\gameobjects::deletetrackedobject();
    hostage.trackedobject = undefined;
  }

  hostage notify("prompt_cleanup");
  credit_player val::reset_all("carry");

  if(!credit_player scripts\mp\utility\killstreak::isjuggernaut()) {
    credit_player.playerstreakspeedscale = 0;
    credit_player setmovespeedscale(1);
  }

  objective_state(hostage.var_bd657a84755765de, "done");
  objective_state(hostage.var_81121fb99d0a00b, "done");
  credit_player.hashostage = 0;
  level.hostages[hostage.objidnum] = undefined;
  level.var_7fcc5417218ad4c8[hostage.objidnum] = undefined;
  level.hostageextracted = 1;
  hostage.body delete();
  hostage.head delete();
  hostage scripts\mp\gameobjects::deletetrackedobject();
  credit_player.carryobject = undefined;
  level.scoreoverride += 100;
  level.var_319544f76c37154b[team] += 100;
  credit_player setclientomnvar("ui_rescue_carrying_hostage", 0);

  if(isDefined(level.var_7fcc5417218ad4c8) && level.var_7fcc5417218ad4c8.size <= 0) {
    foreach(player in level.players) {
      player setclientomnvar("ui_rescue_hostage_active", 0);
    }
  }

  if(isDefined(level.revivetriggers)) {
    foreach(revivetrigger in level.revivetriggers) {
      if(isDefined(revivetrigger.ownerteam) && revivetrigger.ownerteam == credit_player.team) {
        revivetrigger enablescriptableplayeruse(credit_player);
      }
    }
  }

  scoringteam = credit_player.team;
  otherteam = undefined;

  if(team == "allies") {
    otherteam = "axis";
  } else {
    otherteam = "allies";
  }

  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.player = credit_player;
  var_7e2c53b0bcf117d9.eventname = "capture";
  var_7e2c53b0bcf117d9.position = credit_player.origin;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
  printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_prisoner_extracted_sfx", "mp_prisoner_lost_sfx", credit_player);
  credit_player incpersstat("captures", 1);
  credit_player scripts\mp\persistence::statsetchild("round", "captures", credit_player.pers["captures"]);
  credit_player scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);
  thread scripts\mp\hud_util::function_7b2653a588f28e29(credit_player, "rescue_cap_hostage", "rescue_cap_hostage", "rescue_enemy_cap_hostage");
  credit_player thread scripts\mp\rank::scoreeventpopup(#"hash_32c5f215f3ec3b3");
  credit_player thread scripts\mp\utility\points::doscoreevent(#"hash_2d6568e59815732d");

  if(level.hostages.size <= 0) {
    level.var_4817bac75a8b9eff = "all_hostage_extracted";
  }

  winningteam = function_cbe00caa24da0f0e();
  scripts\mp\gamescore::giveteamscoreforobjective(team, 100, 0, undefined, 1, winningteam);
  level.var_4817bac75a8b9eff = undefined;

  if(level.hostages.size <= 0) {
    if(!function_808d5c4aafed7f2e(game["defenders"]) && getdvarint(@ "hash_5ad4b38eb8b556f1", 0)) {
      level.forceend = 1;
    }

    level.scoreoverride = level.var_974e9f26a695cd24;
    thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["all_hostage_extracted"]);
    level.var_d0b7dfa3e29555a1 = undefined;
  } else if(game["teamScores"][team] < level.roundscorelimit) {
    scripts\mp\utility\dialog::leaderdialog("hostage_extraected_friendly", scoringteam);
    scripts\mp\utility\dialog::leaderdialog("hostage_extraected_enemy", otherteam);
    level thread function_52cbcdf9241fd4bf();
  }

  if(level.var_7fcc5417218ad4c8.size > 0) {
    foreach(hostage in level.var_7fcc5417218ad4c8) {
      if(hostage.carrier.team != game["attackers"]) {
        foreach(extract in level.extractzones) {
          extract scripts\mp\gameobjects::allowuse("friendly");
          extract scripts\mp\gameobjects::setvisibleteam("any");
          extract.extractscriptable setscriptablepartstate("rescue_extract", "idle");
        }

        return;
      }
    }
  }

  foreach(extract in level.extractzones) {
    extract scripts\mp\gameobjects::allowuse("none");
    extract scripts\mp\gameobjects::setvisibleteam("none");
    extract.extractscriptable setscriptablepartstate("rescue_extract", "off");
  }

  foreach(hostage in level.hostages) {
    hostage.trigger enableplayeruse(credit_player);
  }
}

function function_52cbcdf9241fd4bf() {
  level endon("game_ended");

  if(!isDefined(level.var_d0b7dfa3e29555a1)) {
    wait 2;

    foreach(player in level.players) {
      if(isDefined(player.musicpack) && player.musicpack == 1) {
        prisoner_carry_music = function_17ee301cf0b5ba85("prisoner_carry_music_classic");
        player setplayermusicstate(prisoner_carry_music);
        continue;
      }

      prisoner_carry_music = function_17ee301cf0b5ba85("prisoner_carry_music");
      player setplayermusicstate(prisoner_carry_music);
    }

    level.var_d0b7dfa3e29555a1 = 1;
  }
}

function extractzone_onusebegin(player) {
  if(!istrue(player.hashostage)) {
    return;
  }

  if(level.flagcapturetime <= 0) {
    return;
  }

  if(!isDefined(self.var_53d907bf6d19394e)) {
    self.var_53d907bf6d19394e = [];
  }

  hostage = player.carryobject;
  self.var_53d907bf6d19394e[hostage.objidnum] = hostage;
  self.numtouching[player.team]++;
  player.hashostage = 0;
  self.carrier = undefined;
  level.var_7fcc5417218ad4c8[hostage.objidnum] = undefined;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == player.team) {
    objectivestate = 1;
  } else {
    objectivestate = 0;
  }

  if(isPlayer(player)) {
    player setclientomnvar("ui_objective_pinned_text_param", objectivestate);
  }

  if(!isDefined(self.statusnotifytime)) {
    self.statusnotifytime = gettime();
  }

  if(self.statusnotifytime > self.statusnotifytime + 5000) {
    self.didstatusnotify = 0;
    self.statusnotifytime = gettime();
  }

  usetime = level.flagcapturetime;

  if(usetime > 0) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icontaking, level.icontaking);
  }

  hostage.safeorigin = self.trigger.origin;
  hostage thread scripts\mp\gameobjects::setdropped(0);
  hostage.head show();

  if(istrue(hostage.body.hasanimtree)) {
    hostage.body stopuseanimtree();
    hostage.body.hasanimtree = undefined;
  }

  hostage.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
  hostage scripts\mp\gameobjects::setownerteam(player.team);
  hostage scripts\mp\gameobjects::allowuse("enemy");
  hostage scripts\mp\gameobjects::setvisibleteam("enemy");

  foreach(hostage in level.hostages) {
    hostage.trigger enableplayeruse(player);
  }

  player val::reset_all("carry");

  if(!player scripts\mp\utility\killstreak::isjuggernaut()) {
    player.playerstreakspeedscale = 0;
    player setmovespeedscale(1);
  }
}

function function_76ba7e56087a12fd(player) {
  if(player.team == game["attackers"]) {
    return false;
  }

  if(!isDefined(level.var_7fcc5417218ad4c8)) {
    return false;
  }

  if(level.var_7fcc5417218ad4c8.size <= 0) {
    return false;
  }

  return true;
}

function function_ccf456cd84b96382(player, team) {
  if(!istrue(level.var_8f21d2090cbc3b2a) && isDefined(player.carryobject)) {
    level.var_8f21d2090cbc3b2a = 1;
    hostage = player.carryobject;
    level.returnzones[hostage.objidnum] scripts\mp\gameobjects::setvisibleteam("none");
    level.returnzones[hostage.objidnum] scripts\mp\gameobjects::allowuse("none");
    hostage = player.carryobject;
    hostage.safeorigin = self.trigger.origin;
    hostage thread scripts\mp\gameobjects::setdropped(0);
    hostage function_13db2131b3f0851f(player, 1);
  }
}

function function_6201c84e805ab787(player) {
  if(player isthrowingbackgrenade() || player isthrowinggrenade()) {
    return false;
  }

  return true;
}

function function_a4beda038141b8f8(player) {
  if(istrue(player.ishaywire)) {
    return false;
  }

  return true;
}

function function_fda15d11f6baf729(player) {
  currentweap = player getcurrentweapon();

  if(!scripts\mp\utility\weapon::isprimaryweapon(currentweap)) {
    return false;
  }

  return true;
}

function function_5c8cf2eee42128c8(player) {
  return !player isreloading();
}

function function_ed073d24cd8ed3c5(player) {
  if(self.body islinked()) {
    return (abs(player.origin[2] - self.var_90758efde9b783b7.origin[2]) < level.var_f224e09983ef4b2a);
  }

  carl = abs(player.origin[2] - self.body.origin[2]);
  tim = level.var_f224e09983ef4b2a;
  bobby = abs(player.origin[2] - self.body.origin[2]) < level.var_f224e09983ef4b2a;
  return abs(player.origin[2] - self.body.origin[2]) < level.var_f224e09983ef4b2a;
}

function onspawnplayer(revivespawn) {
  if(istrue(self.var_f44aa740d81a25da)) {
    self notify("last_stand_finished");
  }

  if(level.scriptedtriggers && isDefined(self.team)) {
    if(self.team == game["attackers"]) {
      foreach(hostage in level.hostages) {
        hostage.trigger disableplayeruse(self);
      }

      return;
    }

    foreach(hostage in level.hostages) {
      hostage.trigger enableplayeruse(self);
    }
  }
}

function private onplayerconnect(player) {
  if(!isDefined(player)) {
    return;
  }

  scripts\mp\outofbounds::registerentforoob(player, "rescue");
}

function private function_b9962c5a08fd9ab7(exitnotify, clearnotify, triggertype) {
  if(!isDefined(self)) {
    return;
  }

  self.var_1d85141d8703f5d4 = 1;
  self notify("force_manual_drop");
}

function private function_d50cce29bbb9d457(fromdeath, fromclear, clearnotify) {
  if(!isDefined(self)) {
    return;
  }

  self.var_1d85141d8703f5d4 = undefined;
}

function function_a12ec32a24e1a367(victim) {
  if(!istrue(victim.hashostage)) {
    return;
  }

  if(!isDefined(victim.givenweapon)) {
    return;
  }

  victim takeweapon(victim.givenweapon);
  self.lastcacweaponobj = victim.switchweapon;
  victim.givenweapon = undefined;
}

function function_824aadc5e0a8e202(objweapon) {
  if(isDefined(level.hostages)) {
    foreach(hostage in level.hostages) {
      if(self istouching(hostage.trigger)) {
        return false;
      }
    }
  }

  return true;
}

function function_c95d2a5f442a6bfe(point) {
  if(isDefined(level.hostages)) {
    foreach(hostage in level.hostages) {
      if(isDefined(point)) {
        if(ispointinsidecircle(point, hostage.curorigin, 40)) {
          return false;
        }

        continue;
      }

      if(self istouching(hostage.trigger)) {
        return false;
      }
    }
  }

  return true;
}

function function_15a66746e75cc48a(point) {
  if(isDefined(level.hostages)) {
    foreach(hostage in level.hostages) {
      distsqrd = distancesquared(hostage.trigger.origin, self.origin);

      if(3600 >= distsqrd) {
        return false;
      }
    }
  }

  return true;
}

function function_189d41172d946149() {
  level endon("game_ended");

  if(!getdvarint(@ "hash_38c9581a2665c1aa", 1)) {
    return;
  }

  while(true) {
    validplayers = [];

    foreach(player in level.players) {
      if(isDefined(player.team) && player.team == game["defenders"]) {
        validplayers[validplayers.size] = player;
      }
    }

    level.var_fcbb998d4a3f2da = create_partition(validplayers, 700);
    wait 1;
  }
}

function function_a5b7c34a5c2d56d2() {
  self notify("watch_mines");
  self endon("death");
  self endon("watch_mines");
  self endon("hostage_pickup");

  if(!getdvarint(@ "hash_38c9581a2665c1aa", 1)) {
    return;
  }

  while(true) {
    if(getdvarint(@ "hash_df9beaaeade3f5bf", 0)) {
      thread draw_circle(self.curorigin, 400, (1, 0, 0), 1, 0, 1);
      thread draw_circle(self.curorigin, 700, (0, 0, 1), 1, 0, 1);
    }

    if(!isDefined(level.var_fcbb998d4a3f2da)) {
      waitframe();
      continue;
    }

    var_83451e7f85547ee0 = [];

    foreach(playerarray in level.var_fcbb998d4a3f2da function_df633f460888a47(self.curorigin)) {
      foreach(player in playerarray) {
        if(!isalive(player)) {
          continue;
        }

        var_83451e7f85547ee0[var_83451e7f85547ee0.size] = player;
      }
    }

    if(var_83451e7f85547ee0.size == 0) {
      waitframe();
      continue;
    }

    scripts\cp_mp\utility\game_utility::createprojectilepartition();

    foreach(targetarray in level.projectilepartition function_df633f460888a47(self.curorigin)) {
      foreach(target in targetarray) {
        if(!isDefined(target)) {
          continue;
        }

        if(!isDefined(target.team)) {
          continue;
        }

        if(target.team == game["defenders"] && !getdvarint(@ "hash_8d4d3e5a116ea626", 0)) {
          continue;
        }

        if(!function_391d759d20be6374(target.equipmentref)) {
          continue;
        }

        if(scripts\mp\weapons::isplantedequipment(target) && distance2dsquared(target.origin, self.curorigin) < 160000) {
          voice = 1;

          if(self.objectivekey == "_b") {
            voice = 2;
          }

          soundtoplay = "dx_mp_rscu_mode_cvm" + voice + "_rhda";

          foreach(player in var_83451e7f85547ee0) {
            self.head playsoundtoplayer(soundtoplay, player, self.head);
          }

          sound_length = lookupsoundlength(soundtoplay, 1);
          wait sound_length / 1000 + 25;
        }
      }
    }

    waitframe();
  }
}

function function_391d759d20be6374(targetref) {
  if(!isDefined(targetref)) {
    return false;
  }

  return targetref == "equip_at_mine" || targetref == "equip_c4" || targetref == "equip_claymore";
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  scripts\mp\gametypes\common::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
  score = scripts\mp\rank::getscoreinfovalue(#"kill");
  assert(isDefined(score));

  if(isDefined(attacker.laststanding) && attacker.laststanding) {
    attacker thread function_e3e3e81453fd788b(#"hash_4bc4aed7d23221b3");
  }

  if(istrue(victim.hashostage)) {
    attacker incpersstat("defends", 1);
    attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
    attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
    attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
  }

  if(isDefined(level.var_7fcc5417218ad4c8) && level.var_7fcc5417218ad4c8.size > 0) {
    if(isDefined(attacker) && isPlayer(attacker) && attacker.pers["team"] != victim.pers["team"]) {
      foreach(hostage in level.var_7fcc5417218ad4c8) {
        if(attacker.pers["team"] == hostage.carrier.team && attacker != hostage.carrier) {
          var_db36f135f40e7940 = distancesquared(hostage.carrier.origin, attacker.origin);

          if(var_db36f135f40e7940 < 105625) {
            attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
            attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
            attacker incpersstat("defends", 1);
            attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
            thread utility::trycall(level.matchdata_logvictimkillevent, lifeid, "defending");
          }
        }
      }
    }
  }
}

function onspawnrevivetrigger() {
  if(isDefined(level.var_7fcc5417218ad4c8)) {
    foreach(hostage in level.var_7fcc5417218ad4c8) {
      self disablescriptableplayeruse(hostage.carrier);
    }
  }
}

function onflagcapture(objectivetype, label, credit_player, team, oldteam, flagobj) {}

function gettimelimitresult(var_3fb18bf245471d0b, scoredefenders) {
  var_adbdcd3370cc708d = game["roundsWon"][game["attackers"]] + var_3fb18bf245471d0b;
  var_e92034aef3a4b991 = game["roundsWon"][game["defenders"]] + scoredefenders;

  if(var_adbdcd3370cc708d < level.winlimit) {
    return 0;
  }

  if(var_e92034aef3a4b991 < level.winlimit) {
    return 0;
  }

  if(var_adbdcd3370cc708d != var_e92034aef3a4b991) {
    if(var_adbdcd3370cc708d > var_e92034aef3a4b991) {
      return 1;
    }

    return 2;
  }

  return 3;
}

function ontimelimit() {
  winningteam = "tie";
  scoredefenders = 0;
  var_7fcc5417218ad4c8 = 0;

  if(isDefined(level.var_7fcc5417218ad4c8)) {
    var_7fcc5417218ad4c8 = level.var_7fcc5417218ad4c8.size;
    scoredefenders = 100 * var_7fcc5417218ad4c8;
    level.var_319544f76c37154b[game["defenders"]] = level.var_319544f76c37154b[game["defenders"]] + 100 * var_7fcc5417218ad4c8;
  }

  var_ddd6e7cac66011ba = 50 * (level.hostages.size - var_7fcc5417218ad4c8);
  level.var_319544f76c37154b[game["attackers"]] = level.var_319544f76c37154b[game["attackers"]] + 50 * (level.hostages.size - var_7fcc5417218ad4c8);
  level.var_fb257bafbf772e21 = [];
  level.var_fb257bafbf772e21[game["attackers"]] = var_ddd6e7cac66011ba;
  level.var_fb257bafbf772e21[game["defenders"]] = scoredefenders;
  result = gettimelimitresult(var_ddd6e7cac66011ba, scoredefenders);

  if(result == 1) {
    winningteam = game["attackers"];
    scripts\mp\gamescore::giveteamscoreforobjective(game["attackers"], var_ddd6e7cac66011ba, 1, undefined, 1, winningteam);
    scripts\mp\gamescore::giveteamscoreforobjective(game["defenders"], scoredefenders, 1, undefined, 1, winningteam);
  } else if(result == 2) {
    winningteam = game["defenders"];
    scripts\mp\gamescore::giveteamscoreforobjective(game["defenders"], scoredefenders, 1, undefined, 1, winningteam);
    scripts\mp\gamescore::giveteamscoreforobjective(game["attackers"], var_ddd6e7cac66011ba, 1, undefined, 1, winningteam);
  } else if(result == 3) {
    winningteam = "tie";
    scripts\mp\gamescore::giveteamscoreforobjective(game["defenders"], scoredefenders, 1, undefined, 1, winningteam);
    scripts\mp\gamescore::giveteamscoreforobjective(game["attackers"], var_ddd6e7cac66011ba, 1, undefined, 1, winningteam);
  } else {
    scripts\mp\gamescore::giveteamscoreforobjective(game["defenders"], scoredefenders, 1, undefined, 1, winningteam);
    scripts\mp\gamescore::giveteamscoreforobjective(game["attackers"], var_ddd6e7cac66011ba, 1, undefined, 1, winningteam);
  }

  thread scripts\mp\gamelogic::endgame(winningteam, game["end_reason"]["time_limit_reached"]);
}

function ondeadevent(team) {
  if(team == "all") {
    winningteam = "tie";

    if(!function_808d5c4aafed7f2e(game["attackers"]) && getdvarint(@ "hash_5ad4b38eb8b556f1", 0)) {
      level.forcedend = 1;
      winningteam = game["defenders"];
    }

    if(!function_808d5c4aafed7f2e(game["defenders"]) && getdvarint(@ "hash_5ad4b38eb8b556f1", 0)) {
      level.forcedend = 1;
      winningteam = game["attackers"];
    }

    level.scoreoverride = 0;
    winningteam = function_cbe00caa24da0f0e();
    level thread scripts\mp\gamelogic::endgame(winningteam, game["end_reason"]["tie"]);
    return;
  }

  if(team == game["attackers"]) {
    score = 50;

    if(isDefined(level.var_7fcc5417218ad4c8) && level.var_7fcc5417218ad4c8.size > 0) {
      roundpoints = level.var_7fcc5417218ad4c8.size * 100;
      score = int(clamp(roundpoints + 50, 50, level.var_974e9f26a695cd24));
    }

    if(score + level.var_319544f76c37154b[game["defenders"]] >= level.var_974e9f26a695cd24) {
      score = level.var_974e9f26a695cd24 - level.var_319544f76c37154b[game["defenders"]];
    }

    level.scoreoverride = score;
    level.var_319544f76c37154b[game["defenders"]] = level.var_319544f76c37154b[game["defenders"]] + score;
    winningteam = function_cbe00caa24da0f0e();
    scripts\mp\gamescore::giveteamscoreforobjective(game["defenders"], score, 0, undefined, 1, winningteam);

    if(!function_808d5c4aafed7f2e(game["attackers"]) && getdvarint(@ "hash_5ad4b38eb8b556f1", 0)) {
      level.forcedend = 1;
    }

    level thread scripts\mp\gamelogic::endgame(winningteam, game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
    return;
  }

  if(team == game["defenders"]) {
    level.scoreoverride = 50 * level.hostages.size;
    level.var_319544f76c37154b[game["attackers"]] = level.var_319544f76c37154b[game["attackers"]] + level.scoreoverride;
    winningteam = function_cbe00caa24da0f0e();
    scripts\mp\gamescore::giveteamscoreforobjective(game["attackers"], level.scoreoverride, 0, undefined, 1, winningteam);

    if(!function_808d5c4aafed7f2e(game["defenders"]) && getdvarint(@ "hash_5ad4b38eb8b556f1", 0)) {
      level.forcedend = 1;
    }

    level thread scripts\mp\gamelogic::endgame(winningteam, game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
  }
}

function function_f6e1c54f449c2c6f(winner, endreasontext, nukedetonated) {
  var_fb257bafbf772e21 = undefined;

  if(isDefined(level.var_fb257bafbf772e21)) {
    var_fb257bafbf772e21 = level.var_fb257bafbf772e21;
  }

  level thread scripts\mp\gamelogic::endgame_regularmp(winner, endreasontext, undefined, nukedetonated, level.scoreoverride, var_fb257bafbf772e21);
}

function function_e462b877cedea7f7(team, score, scoreevent) {
  if(score >= level.winlimit) {
    level.forcedend = 1;
    function_f6e1c54f449c2c6f(team, game["end_reason"]["score_limit_reached"]);
  }
}

function function_cbe00caa24da0f0e() {
  if(level.var_319544f76c37154b["axis"] == level.var_319544f76c37154b["allies"]) {
    debugroundwinner("<dev string:x24>");

    return "tie";
  }

  winningteam = ter_op(level.var_319544f76c37154b["axis"] > level.var_319544f76c37154b["allies"], "axis", "allies");

  debugroundwinner(winningteam);

  return winningteam;
}

function function_808d5c4aafed7f2e(team) {
  if(!isDefined(game["roundsPlayed"])) {
    return 1;
  }

  if(game["roundsPlayed"] == level.roundlimit - 1) {
    return 1;
  }

  if(level.roundlimit == 0) {
    return 1;
  }

  roundsleft = level.roundlimit - game["roundsPlayed"] + 1;
  roundsmod = floor(float(roundsleft) / 2);

  if(roundsleft % 2 != 0) {
    if(team == game["attackers"]) {
      maxscore = level.var_d2574c87ee723d10 * (1 + roundsmod) + level.var_974e9f26a695cd24 * roundsmod;

      if(maxscore < game["teamScores"][game["defenders"]]) {
        return 0;
      }

      return 1;
    }

    maxscore = level.var_974e9f26a695cd24 * (1 + roundsmod) + level.var_d2574c87ee723d10 * roundsmod;

    if(maxscore < game["teamScores"][game["attackers"]]) {
      return 0;
    }

    return 1;
  }

  maxscore = level.var_d2574c87ee723d10 * roundsmod + level.var_974e9f26a695cd24 * roundsmod;

  if(team == game["attackers"]) {
    if(maxscore < game["teamScores"][game["defenders"]]) {
      return 0;
    }

    return 1;
  }

  if(maxscore < game["teamScores"][game["attackers"]]) {
    return 0;
  }

  return 1;
}

function function_da3da0004950e970(objective, time) {
  objective notify("pulsing");
  objective endon("pulsing");
  objective endon("death");
  objective endon("gameobject_deleted");
  level endon("game_ended");
  objective scripts\mp\objidpoolmanager::objective_set_pulsate(objective.objidnum, 1);
  wait time;
  objective scripts\mp\objidpoolmanager::objective_set_pulsate(objective.objidnum, 0);
}

function function_e100ac66c6f43c39() {
  level endon("<dev string:x2b>");

  while(true) {
    function_8e671b51737c992e();
    debugendround();
    waitframe();
  }
}

function function_8e671b51737c992e() {
  score = getdvarint(@ "hash_f214714304d21d8c", 0);

  if(score) {
    setDvar(@ "hash_f214714304d21d8c", 0);

    if(isDefined(level.players) && isDefined(level.players[0])) {
      level.scoreoverride = score;
      level.var_319544f76c37154b[level.players[0].team] += score;
      winningteam = function_cbe00caa24da0f0e();
      scripts\mp\gamescore::giveteamscoreforobjective(level.players[0].team, score, 0, undefined, 1, winningteam);
    }
  }
}

function debugendround() {
  result = getdvarint(@ "hash_3419845bbfd82e24", 0);

  if(result) {
    setDvar(@ "hash_3419845bbfd82e24", 0);

    if(!isDefined(level.players) || !isDefined(level.players[0])) {
      return;
    }

    switch (result) {
      case 1:
        level thread scripts\mp\gamelogic::endgame(level.players[0].team, game["<dev string:x39>"]["<dev string:x47>"]);
        break;
      case 2:
        team = undefined;

        if(level.players[0].team == game["<dev string:x5c>"]) {
          team = game["<dev string:x69>"];
        } else {
          team = game["<dev string:x5c>"];
        }

        level thread scripts\mp\gamelogic::endgame(team, game["<dev string:x39>"]["<dev string:x47>"]);
        break;
      case 3:
        level thread scripts\mp\gamelogic::endgame("<dev string:x24>", game["<dev string:x39>"]["<dev string:x47>"]);
        break;
    }
  }
}

function debugroundwinner(team) {
  println("<dev string:x76>" + team);
}

function function_eed7800933a86a6d() {
  level endon("<dev string:x2b>");
  var_345653ec713a050e = getEntArray("<dev string:x97>", "<dev string:xab>");
  var_345652ec713a02db = getEntArray("<dev string:xb5>", "<dev string:xab>");
  var_345651ec713a00a8 = getEntArray("<dev string:xc9>", "<dev string:xab>");

  while(true) {
    foreach(trigger in var_345653ec713a050e) {
      sphere(trigger.origin, 60, (1, 0, 0));
    }

    foreach(trigger in var_345652ec713a02db) {
      sphere(trigger.origin, 60, (0, 1, 0));
    }

    foreach(trigger in var_345651ec713a00a8) {
      sphere(trigger.origin, 60, (0, 0, 1));
    }

    waitframe();
  }
}

function function_cf8b96b6503d9f31() {
  scripts\mp\codcasterclientmatchdata::function_edba1ee7c2375a5();
}