/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\gwai.gsc
***********************************************/

#using script_1d4b01c1ec829364;
#using script_2d9d24f7c63ac143;
#using script_640cf1641c03e2a0;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\cash;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\uav_tower;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\dmz_ai;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\rally_point;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\utility\connect_event_aggregator;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\game_utility_mp;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace gwai;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  allowed[1] = "arm";
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registertimelimitdvar(getgametype(), 150);
    registerscorelimitdvar(getgametype(), 1);
    registerroundlimitdvar(getgametype(), 0);
    registerwinlimitdvar(getgametype(), 3);
    registernumlivesdvar(getgametype(), 1);
    registerhalftimedvar(getgametype(), 0);
    registerroundswitchdvar(getgametype(), 1, 0, 9);
  }

  setDvar(@ "hash_405e7e20d91344cc", 0);
  setDvar(@ "scr_allow_technicals", 1);
  setDvar(@ "scr_runlean_max_technicals", 30);
  setDvar(@ "hash_cbc195ec2129279", 0);
  setomnvar("ui_num_dom_flags", 1);
  enablegroundwarspawnlogic(400, 1200);
  updategametypedvars();
  setdefaultclass();
  scripts\mp\utility\connect_event_aggregator::registeronconnectcallback(&onplayerconnect);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&onjoinedteam);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  level.objectivebased = 1;
  level.teambased = 1;
  level.var_11525426feeb297a = 1;
  level.var_d040719163e20394 = 1;
  level.var_a0f41ec8e5268d15 = getdvarint(@ "hash_c3babb46fe3fd12b", 1) == 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.modeonspawnplayer = &modeonspawnplayer;
  level.onplayerkilled = &onplayerkilled;
  level.onnormaldeath = &onnormaldeath;
  level.ontimelimit = &ontimelimit;
  level.onscorelimit = &onscorelimit;
  level.var_947925f5fc6939a3 = &function_947925f5fc6939a3;
  level.var_3e175c0b6527751f = &function_3e175c0b6527751f;

  if(getdvarint(@ "hash_78653010d584aa6e", 0) == 0) {
    csvdefault = int(tablelookup("mp/gametypesTable.csv", 0, "gwai", 5));
    level.allowclasschoice = getdvarint(@ "hash_72cc643f082b112b", csvdefault) == 1;
  } else {
    level.allowclasschoice = level.gametypebundle.allowclasschoice;
  }

  if(!level.allowclasschoice) {
    level.bypassclasschoicefunc = &scripts\mp\class::alwaysgamemodeclass;
  }

  level.allowclasschoicefunc = &allowclasschoicefunc;
  level.domflag_setneutral = &scripts\mp\gametypes\obj_dom::domflag_setneutral;
  level.dompoint_setcaptured = &scripts\mp\gametypes\obj_dom::dompoint_setcaptured;
  level.var_e637d49948a038d3 = &getmissedinfilcamerapositions;
  game["dialog"]["gametype"] = "gametype_groundwar";

  if(getdvarint(@ "hash_4a2b3d01a81655a6")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint(hashcat(@ "scr_", getgametype(), "_promode"))) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "boost_groundwar";
  game["dialog"]["defense_obj"] = "boost_groundwar";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  game["dialog"]["securing_a"] = "securing_a";
  game["dialog"]["securing_b"] = "securing_b";
  game["dialog"]["securing_c"] = "securing_c";
  game["dialog"]["securing_d"] = "securing_d";
  game["dialog"]["securing_e"] = "securing_e";
  game["dialog"]["secured_a"] = "secured_a";
  game["dialog"]["secured_b"] = "secured_b";
  game["dialog"]["secured_c"] = "secured_c";
  game["dialog"]["secured_d"] = "secured_d";
  game["dialog"]["secured_e"] = "secured_e";
  game["dialog"]["losing_a"] = "losing_a";
  game["dialog"]["losing_b"] = "losing_b";
  game["dialog"]["losing_c"] = "losing_c";
  game["dialog"]["losing_d"] = "losing_d";
  game["dialog"]["losing_e"] = "losing_e";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";
  game["dialog"]["lost_d"] = "lost_d";
  game["dialog"]["lost_e"] = "lost_e";
  game["dialog"]["lost_all"] = "gamestate_domlosing";
  game["dialog"]["secure_all"] = "gamestate_domwinning";
  game["dialog"]["hp_new_location"] = "iw9_mphq_mode_uktl_hqnl";
  game["dialog"]["hp_active"] = "iw9_mphq_mode_uktl_hqoa";
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_snatch_ac130_clouds"] = loadfx("vfx/iw8_mp/gamemode/vfx_snatch_ac130_clouds.vfx");
  level._effect["vfx_br_infil_cloud_scroll"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_br_infil_omni_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_omni_light.vfx");
  level._effect["vfx_br_infil_spot_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_spot_light.vfx");
  level.var_8e9daba162280a8e = getdvarint(@ "hash_19e5cada53ccf044", 0) == 1;
  level.var_eaa760f325371803 = getdvarint(@ "hash_1db3f1f01240e877", 0) == 1;
  level.var_7f5be0207e7457b1 = getdvarint(@ "hash_27abaa55d7ec8eb9", 1) == 1;
  level.dropbrloot = getdvarint(@ "hash_1d196605f8a290e3", 0);
  level.br_plunder_enabled = getdvarint(@ "scr_game_cash", 0);
  level.noinventory = getdvarint(@ "hash_19fae1aad58e8c50", 1);

  if(level.br_plunder_enabled) {
    scripts\cp_mp\utility\loot::init();
    level.var_e247454ac2869696 = 0;
    namespace_aead94004cf4c147::function_e0948a1e98e82ae1();
  }

  level.var_1e17e3480b1d264d = getdvarint(@ "hash_644f043f54d141f5", 0);

  if(level.var_1e17e3480b1d264d) {
    level.var_9c1e3c18b99409e9 = &function_9c1e3c18b99409e9;
  }

  level.numnonrallyvehicles = getdvarint(@ "scr_arm_numnonrallyvehicles", 25);
  level.disablepersonalnuke = getdvarint(@ "hash_f271257bddc28c95", 0);
  level.personalnukecostoverride = getdvarint(@ "hash_d9455f252fccdb97", 30);
  thread function_658c8f668d2cd83c();
  level.ignoreteamoob = 1;
  flag_init("stealth_enabled");
  flag_init("level_stealth_initialized");
  flag_init("stealth_spotted");
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_99046b3d56cd3649", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar(@ "hash_f51b36fcf02b3f31", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar(@ "hash_6f7aef0c521c9fad", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar(@ "hash_ed7d0e7c3005f22c", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar(@ "hash_e67ffae5a4bb4a1d", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar(@ "hash_9f670bfb474fab3f", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar(@ "hash_fcd65660beaed272", getmatchrulesdata("tdefData", "spawnDelay"));
  registerhalftimedvar("gwai", 0);
}

function onstartgametype() {
  level.requiredplayercountoveride = 1;

  foreach(team in level.teamnamelist) {
    level.requiredplayercount[team] = int(level.maxteamsize * 0.75);
  }

  if(!level.multiteambased) {
    if(!isDefined(game["switchedsides"])) {
      game["switchedsides"] = 0;
    }

    if(game["switchedsides"]) {
      oldattackers = game["attackers"];
      olddefenders = game["defenders"];
      game["attackers"] = olddefenders;
      game["defenders"] = oldattackers;
    }
  }

  setclientnamemode("auto_change");
  level.objectives = [];
  level.uncapturableobjectives = [];
  initspawns();
  seticonnames();
  level.usedomflag = 0;
  level.killstreakqueue = [];
  level thread setupwaypointicons();
  setupobjectives();
  level thread runobjectives();
  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;
  level.maxhqtanks = 0;
  thread init_groundwarvehicles();
  scripts\mp\utility\dialog::initstatusdialog();
  emergency_cleanupents();
  scripts\cp_mp\parachute::initparachutedvars();

  if(getdvarint(@ "scr_br_armory_kiosk", 0) == 1) {
    scripts\mp\gametypes\br_armory_kiosk::init();
    scripts\mp\gametypes\br_armory_kiosk::function_b38f5ffe645943c3("personalOnly");
  }

  level thread spawnai();
  level thread scripts\cp_mp\uav_tower::init();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.var_47e0745baff5b43f = dvarintvalue("newObjectiveRoundCount", 2, 0, 10);
  level.zonehidetime = dvarfloatvalue("zoneHideTime", 120, 0, 300);
  level.zonelockedtime = dvarfloatvalue("zoneLockedTime", 120, 0, 300);
  level.zonecapturetime = dvarfloatvalue("zoneCaptureTime", 15, 0, 60);
  level.objectivescaler = dvarfloatvalue("objScalar", 1, 1, 10);
  level.pausemodetimer = 0;
}

function seticonnames() {
  level.icontarget = "hq_target";
  level.iconneutral = "hq_neutral";
  level.iconcapture = "hq_destroy";
  level.icondefend = "hq_defend";
  level.iconcontested = "hq_contested";
  level.icontaking = "hq_taking";
  level.iconlosing = "hq_losing";
  level.icondefending = "hq_defending";
}

function emergency_cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("vehicle_volume", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("vehicle_volume_simplified", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("super", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("militarybase", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("location_volume", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("locale_area_trigger", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("bank_entry_detector", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("shadow_blocker", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("veh8_mil_air_acharlie130", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bycodeclassname("light");
  scripts\cp_mp\utility\game_utility::removematchingents_bycodeclassname("trigger_use_touch");

  if(isDefined(level.localeid) && level.localeid == "locale_6") {
    scripts\cp_mp\utility\game_utility::removematchingents_bykey("locale_8", "script_noteworthy");
  }

  var_a48ba5ee7fe7c64c = [];
  var_a48ba5ee7fe7c64c[0] = (-22592, 27367, 1000);
  var_a48ba5ee7fe7c64c[1] = (-22592, 27303, -448);
  var_a48ba5ee7fe7c64c[2] = (7837, -9674, 1154);
  var_a48ba5ee7fe7c64c[3] = (7637, -9674, 1154);
  var_a48ba5ee7fe7c64c[4] = (7901, -9674, -270);
  var_a48ba5ee7fe7c64c[5] = (7701, -9674, -270);
  var_a48ba5ee7fe7c64c[6] = (10366, -11606, 66);
  var_a48ba5ee7fe7c64c[7] = (10366, -11813, 66);
  var_a48ba5ee7fe7c64c[6] = (10366, -11670, -270);
  var_a48ba5ee7fe7c64c[7] = (10366, -11877, -270);
  var_a48ba5ee7fe7c64c[8] = (7498, -11716, 66);
  var_a48ba5ee7fe7c64c[9] = (7498, -11652, -270);
  var_a48ba5ee7fe7c64c[10] = (-1200, -18954, -242);
  var_a48ba5ee7fe7c64c[11] = (-1215, -19016, 774);
  ents = getEntArray();

  foreach(ent in ents) {
    if(isDefined(ent.model) && ent.model == "tag_origin") {
      var_e24c6c7277a83762 = 0;

      foreach(badtagorigin in var_a48ba5ee7fe7c64c) {
        if(var_e24c6c7277a83762) {
          break;
        }

        if(distancesquared(ent.origin, badtagorigin) < 144) {
          var_e24c6c7277a83762 = 1;
        }
      }

      if(var_e24c6c7277a83762) {
        ent delete();
      }
    }
  }
}

function removepatchablecollision_delayed() {
  wait 5;
  var_5c2c9d034ebe9dcd = [];
  var_5c2c9d034ebe9dcd[0] = "tactical_cover_col";
  var_5c2c9d034ebe9dcd[1] = "tactical_ladder_col";
  var_5c2c9d034ebe9dcd[2] = "clip8x8x256";
  var_5c2c9d034ebe9dcd[3] = "player8x8x256";
  var_5c2c9d034ebe9dcd[4] = "ladderMetal264";
  var_5c2c9d034ebe9dcd[5] = "ladderWood192";
  var_5c2c9d034ebe9dcd[6] = "ladderMetal192";
  var_5c2c9d034ebe9dcd[7] = "mount128";
  var_5c2c9d034ebe9dcd[8] = "mount64";
  var_5c2c9d034ebe9dcd[9] = "mount32";
  var_5c2c9d034ebe9dcd[10] = "mount256";
  var_5c2c9d034ebe9dcd[11] = "ladderWood264";
  var_5c2c9d034ebe9dcd[12] = "nosight256x256x8";
  var_5c2c9d034ebe9dcd[13] = "nosight128x128x8";
  var_5c2c9d034ebe9dcd[14] = "mountCorner128";
  var_5c2c9d034ebe9dcd[15] = "mantle256";
  var_5c2c9d034ebe9dcd[16] = "mantle128";
  var_5c2c9d034ebe9dcd[17] = "mantle64";
  var_5c2c9d034ebe9dcd[18] = "mantle32";
  var_5c2c9d034ebe9dcd[19] = "stairsHalfFlight128";
  var_5c2c9d034ebe9dcd[20] = "stairsFullFlight128";

  foreach(name in var_5c2c9d034ebe9dcd) {
    scripts\cp_mp\utility\game_utility::removematchingents_bykey(name, "targetname");
  }
}

function onjoinedteam(player) {
  player namespace_18dd16563a37da34::function_6ed651811c936a22();
}

function setupwaypointicons() {
  while(!isDefined(level.streakglobals) || !isDefined(level.streakglobals.streakbundles)) {
    waitframe();
  }

  foreach(var_dfbd7318ef3cc9bd, bundle in level.streakglobals.streakbundles) {
    level.waypointcolors[var_dfbd7318ef3cc9bd + "_incoming"] = "neutral";
    level.waypointbgtype[var_dfbd7318ef3cc9bd + "_incoming"] = 1;
    level.waypointstring[var_dfbd7318ef3cc9bd + "_incoming"] = "";
    level.waypointshader[var_dfbd7318ef3cc9bd + "_incoming"] = ter_op(isDefined(bundle.hudicon), bundle.hudicon, "");
    level.waypointpulses[var_dfbd7318ef3cc9bd + "_incoming"] = 0;
    level.waypointcolors[var_dfbd7318ef3cc9bd] = "neutral";
    level.waypointbgtype[var_dfbd7318ef3cc9bd] = 1;
    level.waypointstring[var_dfbd7318ef3cc9bd] = "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS";
    level.waypointshader[var_dfbd7318ef3cc9bd] = ter_op(isDefined(bundle.hudicon), bundle.hudicon, "");
  }
}

function setupobjectives() {
  level.startingfobnames_neutral = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05", "gw_fob_06", "gw_fob_07", "gw_fob_08", "gw_fob_09"];
  level.gw_objstruct = spawnStruct();
  level.gw_objstruct.startingfobs_neutral = [];

  if(!isDefined(game["gwai_possible_objective_keys"])) {
    game["gwai_possible_objective_keys"] = [];
  }

  var_a9b909bac20ba503 = 0;
  [level.gw_objstruct.startingfobs_neutral, var_a9b909bac20ba503] = function_760badbc47a3e856(level.startingfobnames_neutral, var_a9b909bac20ba503);

  if(!isDefined(game["current_objective_key"]) || level.var_47e0745baff5b43f > 0 && game["roundsPlayed"] % level.var_47e0745baff5b43f == 0) {
    possiblelocations = [];

    foreach(key, used in game["gwai_possible_objective_keys"]) {
      dvarkeys = getDvar(@ "hash_d781fe69411c87bc", "");

      if(dvarkeys != "") {
        dvarkeys = strtok(dvarkeys, " ");

        if(!array_contains(dvarkeys, key)) {
          continue;
        }
      }

      if(!used) {
        possiblelocations[possiblelocations.size] = key;
      }
    }

    if(possiblelocations.size == 0) {
      foreach(key, entry in game["gwai_possible_objective_keys"]) {
        game["gwai_possible_objective_keys"][key] = 0;
      }

      foreach(key, used in game["gwai_possible_objective_keys"]) {
        dvarkeys = getDvar(@ "hash_d781fe69411c87bc", "");

        if(dvarkeys != "") {
          dvarkeys = strtok(dvarkeys, " ");

          if(!array_contains(dvarkeys, key)) {
            continue;
          }
        }

        if(!used) {
          possiblelocations[possiblelocations.size] = key;
        }
      }
    }

    var_50fb98c8e0d441f8 = possiblelocations[randomint(possiblelocations.size)];
    game["current_objective_key"] = var_50fb98c8e0d441f8;
    game["gwai_possible_objective_keys"][var_50fb98c8e0d441f8] = 1;
  }
}

function function_760badbc47a3e856(var_a682e84261a6b971, currentindex) {
  targetarray = [];

  if(!isDefined(var_a682e84261a6b971) || var_a682e84261a6b971.size == 0) {
    return [targetarray, currentindex];
  }

  var_f6ddbb71b889a0be = ["_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i"];
  var_a9b909bac20ba503 = currentindex;

  foreach(var_d83e5fa8f6ce891f in var_a682e84261a6b971) {
    trigger = scripts\cp_mp\utility\game_utility::getlocaleent(var_d83e5fa8f6ce891f);

    if(isDefined(trigger)) {
      fob = spawnStruct();
      fob.name = var_d83e5fa8f6ce891f;
      fob.trigger = trigger;
      fob.trigger.objkey = var_f6ddbb71b889a0be[var_a9b909bac20ba503];
      var_a9b909bac20ba503++;
      targetarray[targetarray.size] = fob;

      if(!isDefined(game["gwai_possible_objective_keys"][fob.trigger.objkey])) {
        game["gwai_possible_objective_keys"][fob.trigger.objkey] = 0;
      }
    }
  }

  return [targetarray, var_a9b909bac20ba503];
}

function runobjectives() {
  level.allfobs = [];

  foreach(fob in level.gw_objstruct.startingfobs_neutral) {
    if(fob.trigger.objkey == game["current_objective_key"]) {
      fob.trigger.objkey = "_a";
      var_ddca7869b65236b6 = function_2d95972fced27791(fob.trigger, "neutral");
      level.allfobs[level.allfobs.size] = fob;
    }
  }

  aivolumes = getEntArray("gw_ai_base", "targetname");

  foreach(fob in level.allfobs) {
    fob.trigger.gameobject.onuse = &zone_onuse;
    fob.trigger.gameobject.onbeginuse = &scripts\mp\gametypes\obj_zonecapture::zone_onusebegin;
    fob.trigger.gameobject.onuseupdate = &scripts\mp\gametypes\obj_zonecapture::zone_onuseupdate;
    fob.trigger.gameobject.onenduse = &scripts\mp\gametypes\obj_zonecapture::zone_onuseend;
    fob.trigger.gameobject.onunoccupied = &scripts\mp\gametypes\obj_zonecapture::zone_onunoccupied;
    fob.trigger.gameobject.oncontested = &scripts\mp\gametypes\obj_zonecapture::zone_oncontested;
    fob.trigger.gameobject.onuncontested = &scripts\mp\gametypes\obj_zonecapture::zone_onuncontested;
    fob.trigger.gameobject.stompprogressreward = &scripts\mp\gametypes\obj_zonecapture::zone_stompprogressreward;
    fob.trigger.gameobject.onpinnedstate = &scripts\mp\gametypes\obj_zonecapture::zone_onpinnedstate;
    fob.trigger.gameobject.onunpinnedstate = &scripts\mp\gametypes\obj_zonecapture::zone_onunpinnedstate;

    if(istrue(level.var_dd7af80c3eb2c1e0)) {
      fob.var_5261f4479b04f834 = &scripts\mp\gametypes\obj_dom::function_5261f4479b04f834;
    }

    foreach(aivolume in aivolumes) {
      if(fob.trigger.targetname == aivolume.script_label) {
        fob.trigger.gameobject.aivolume = aivolume;
        break;
      }
    }

    level.objectives[fob.trigger.gameobject.objectivekey] = fob.trigger.gameobject;
  }

  setomnvar("ui_num_dom_flags", level.allfobs.size);

  if(level.zonehidetime == 0) {
    level thread objective_manageobjectivesintrovisibility();
  }

  level thread function_f73cab6ec2fe1638();
  level thread allowobjectiveuseaftermatchstart();
  level.var_aa5583d4cbbfd72e = 1;
}

function function_f73cab6ec2fe1638() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(level.zonehidetime > 0) {
    wait level.zonehidetime;
  }

  foreach(fob in level.allfobs) {
    fob.trigger.gameobject scripts\mp\gameobjects::setvisibleteam("any");
  }

  foreach(entry in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_new_location", entry);
  }
}

function allowobjectiveuseaftermatchstart() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(level.zonelockedtime > 0) {
    foreach(fob in level.allfobs) {}

    activetime = int(gettime() + level.zonelockedtime * 1000);
    setomnvar("ui_hardpoint_timer", activetime);
    setomnvar("ui_hq_status", 1);
    setomnvar("ui_hq_ownerteam", -1);
    wait level.zonelockedtime;
  }

  setomnvar("ui_hardpoint_timer", 0);
  setomnvar("ui_hq_status", -1);

  foreach(fob in level.allfobs) {
    fob.trigger.gameobject scripts\mp\gameobjects::allowuse("enemy");
    fob.trigger.gameobject scripts\mp\gameobjects::enableobject();
    fob.trigger.gameobject scripts\mp\gameobjects::setusetime(level.zonecapturetime);
  }

  foreach(entry in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_active", entry);
  }
}

function objective_manageobjectivesintrovisibility() {
  wait 1;

  foreach(fob in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(fob.trigger.gameobject.objidnum);
  }

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  foreach(fob in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(fob.trigger.gameobject.objidnum);
  }
}

function function_2d95972fced27791(objective, startingteam) {
  level endon("game_ended");
  objective.script_label = objective.objkey;
  domflag = scripts\mp\gametypes\obj_zonecapture::setupobjective(objective);
  domflag.origin = objective.origin;
  domflag scripts\mp\gameobjects::allowuse("none");
  domflag.didstatusnotify = 0;
  domflag scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  return domflag;
}

function dropcrate(killstreakname, droplocation, team) {
  crate = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(team, killstreakname, droplocation.origin, (0, randomint(360), 0), undefined);
  return crate;
}

function docratedropsmoke(crate, droplocation, duration) {
  var_e0d03a39e88dff15 = droplocation.origin + (0, 0, 2000);
  spawnpos = utility::groundpos(var_e0d03a39e88dff15, (0, 0, 1));
  droplocation.vfxent = spawn("script_model", spawnpos);
  droplocation.vfxent setModel("tag_origin");
  droplocation.vfxent.angles = (0, 0, 0);
  droplocation.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  wait 1;
  playFXOnTag(getfx("vfx_smk_signal_gr"), droplocation.vfxent, "tag_origin");

  if(isDefined(crate)) {
    crate waittill_any_timeout_1(duration, "crate_dropped");
  } else {
    wait duration;
  }

  stopFXOnTag(getfx("vfx_smk_signal_gr"), droplocation.vfxent, "tag_origin");
  droplocation.vfxent delete();
}

function registervaliddroplocations() {
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  level.validdroplocationstruct = spawnStruct();
  level.validdroplocationstruct.clusters = getStructArray("dropBagCluterNode", "script_noteworthy");
  potentialdroplocations = getStructArray("dropBagLocation", "script_noteworthy");

  foreach(location in potentialdroplocations) {
    location.inuse = 0;

    foreach(cluster in level.validdroplocationstruct.clusters) {
      if(location.target == cluster.targetname) {
        if(!isDefined(cluster.droplocations)) {
          cluster.droplocations = [];
        }

        cluster.droplocations[cluster.droplocations.size] = location;
      }
    }
  }

  level.nextkillstreakgoal = 100;

  if(false) {
    thread debug_testcratedroplocationpicker();
  }
}

function debug_testcratedroplocationpicker() {
  while(true) {
    choosecratelocation();
    wait 1;
  }
}

function checkkillstreakcratedrop(team) {
  if(game["teamScores"][team] >= level.nextkillstreakgoal) {
    level.nextkillstreakgoal += 100;
    dropkillstreakcrates(2);
  }
}

function dropkillstreakcrates(var_fd2fee325481dc7f) {
  owningplayer = undefined;

  foreach(player in level.players) {
    if(isDefined(player)) {
      owningplayer = player;
      break;
    }
  }

  for(i = 0; i < var_fd2fee325481dc7f; i++) {
    location = choosecratelocation();
    thread runkillstreakreward(location, owningplayer, getkillstreak(1));
    wait 5;
  }
}

function choosecratelocation() {
  randfrac = randomfloatrange(0, 1);
  var_1b090db7ad64072d = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, randfrac);
  var_1b090ab7ad640094 = vectorlerp(level.c130pathstruct_b.endpt, level.c130pathstruct_b.startpt, randfrac);
  var_92459ae9b006b9f7 = vectorlerp(var_1b090db7ad64072d, var_1b090ab7ad640094, 0.5);
  trace = ray_trace(var_92459ae9b006b9f7, var_92459ae9b006b9f7 - (0, 0, 100000));
  var_92459ae9b006b9f7 = trace["position"];
  var_794937a10118f0d9 = findclosestdroplocation(var_92459ae9b006b9f7);

  if(false) {
    thread drawsphere(var_1b090db7ad64072d, 1000, 100, (0, 0, 1));
    thread drawsphere(var_1b090ab7ad640094, 1000, 100, (0, 0, 1));
    thread drawsphere(var_92459ae9b006b9f7, 1000, 100, (1, 0, 0));
    thread drawsphere(var_794937a10118f0d9.origin, 1000, 100, (0, 1, 0));
    thread drawline(var_92459ae9b006b9f7, var_794937a10118f0d9.origin, 3, (0, 1, 0));
  }

  return var_794937a10118f0d9;
}

function findclosestdroplocation(origin) {
  startlocation = spawnStruct();
  startlocation.origin = origin;
  var_206c7349dd628bc8 = startlocation array_sort_with_func(level.validdroplocationstruct.clusters, &sortlocationsbydistance);

  foreach(cluster in var_206c7349dd628bc8) {
    var_d6d0d0ab47b5b334 = array_randomize(cluster.droplocations);

    if(false) {
      return var_d6d0d0ab47b5b334[0];
    }

    foreach(location in var_d6d0d0ab47b5b334) {
      if(!location.inuse) {
        location.inuse = 1;
        return location;
      }
    }
  }

  return undefined;
}

function runkillstreakreward(location, creditplayer, streakname) {
  level endon("game_ended");
  crate = undefined;
  object = scripts\mp\gameobjects::createobjidobject(location.origin, "neutral", (0, 0, 72), undefined, "any");
  object.origin = location.origin;
  object.angles = location.angles;
  thread docratedropsmoke(undefined, location, 16);
  object.iconname = "_incoming";
  object.lockupdatingicons = 0;
  object scripts\mp\gameobjects::setobjectivestatusicons(streakname);
  object.lockupdatingicons = 1;
  wait 4;
  crate = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(creditplayer.team, streakname, location.origin, (0, randomint(360), 0), undefined);
  crate.skipminimapicon = 1;
  crate.nevertimeout = 0;
  crate.waitforobjectiveactivate = 1;
  crate.killminimapicon = 0;
  crate.disallowheadiconid = 1;
  crate.isarmcrate = 1;
  crate waittill("crate_dropped");
  object.useobj = crate;
  object.origin = crate.origin;
  currentwait = 0;
  interval = 0.1;
  wait 1;
  crate notify("objective_activate");
  scripts\mp\objidpoolmanager::update_objective_onentity(object.objidnum, crate);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(object.objidnum, 72);
  object.iconname = "";
  object.lockupdatingicons = 0;
  object scripts\mp\gameobjects::setobjectivestatusicons(streakname);
  object.lockupdatingicons = 1;
  objective_setlabel(object.objidnum, "");
  crate waittill("death");
  object scripts\mp\gameobjects::setvisibleteam("none");
  object scripts\mp\gameobjects::releaseid();
  object.visibleteam = "none";
}

function getkillstreak(tier) {
  if(!isDefined(level.killstreaktierlist)) {
    processkillstreaksintotiers();
  }

  level.killstreaktierlist[tier] = array_randomize(level.killstreaktierlist[tier]);
  return level.killstreaktierlist[tier][0];
}

function processkillstreaksintotiers() {
  level.killstreaktierlist = [];
  level.killstreaktierlist[3] = ["cruise_predator", "scrambler_drone_guard", "uav"];
  level.killstreaktierlist[2] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level.killstreaktierlist[1] = ["toma_strike", "uav", "pac_sentry", "white_phosphorus"];
  level.killstreaktierlist[0] = ["uav"];
}

function initspawns(var_4c3936c2c179fab3) {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

  if(!level.multiteambased) {
    var_48501209a3e177a7 = "mp_gw_spawn_allies_start";
    var_ae7d0107ad485428 = "mp_gw_spawn_axis_start";
    scripts\mp\spawnlogic::addspawnpoints(game["attackers"], var_48501209a3e177a7);
    scripts\mp\spawnlogic::addspawnpoints(game["defenders"], var_ae7d0107ad485428);
    attackers = scripts\mp\spawnlogic::getspawnpointarray(var_48501209a3e177a7);
    defenders = scripts\mp\spawnlogic::getspawnpointarray(var_ae7d0107ad485428);
    scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
    scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
  } else {
    level.startlocs = [];

    switch (level.mapname) {
      case #"hash_a11e6e81ea219453":
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-37117, -14519, 260);
        startloc.angles = (0, 302, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-29272, -15643, 350);
        startloc.angles = (0, 236, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-27343, -24666, 260);
        startloc.angles = (0, 154, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-35216, -29197, 320);
        startloc.angles = (0, 96, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-42555, -20407, 260);
        startloc.angles = (0, 335, 0);
        level.startlocs[level.startlocs.size] = startloc;
        break;
      case #"hash_3e552e81b4a21fff":
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-21036, 39417, -30);
        startloc.angles = (0, 333, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-12069, 51876, 194);
        startloc.angles = (0, 271, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (1983, 43672, 479);
        startloc.angles = (0, 178, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-1061, 29444, 406);
        startloc.angles = (0, 124, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-15203, 31037, 266);
        startloc.angles = (0, 67, 0);
        level.startlocs[level.startlocs.size] = startloc;
        break;
      case #"hash_5586b38644ed9b26":
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-16014, -51700, 322);
        startloc.angles = (0, 30, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-12154, -40440, 586);
        startloc.angles = (0, 354, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-3034, -33855, 997);
        startloc.angles = (0, 274, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (12220, -36424, 677);
        startloc.angles = (0, 202, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (1979, -51789, 252);
        startloc.angles = (0, 109, 0);
        level.startlocs[level.startlocs.size] = startloc;
        break;
      default:
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-37117, -14519, 260);
        startloc.angles = (0, 302, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-29272, -15643, 350);
        startloc.angles = (0, 236, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-27343, -24666, 260);
        startloc.angles = (0, 154, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-35216, -29197, 320);
        startloc.angles = (0, 96, 0);
        level.startlocs[level.startlocs.size] = startloc;
        startloc = spawnStruct();
        startloc.team = undefined;
        startloc.origin = (-42555, -20407, 260);
        startloc.angles = (0, 335, 0);
        level.startlocs[level.startlocs.size] = startloc;
        break;
    }

    level.startlocs = array_randomize(level.startlocs);
  }

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

  if(!level.multiteambased) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }
  } else {
    aliveplayers = getteamdata(spawnteam, "alivePlayers");

    if(aliveplayers.size > 0) {
      spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(aliveplayers[0]);
    } else {
      foreach(startloc in level.startlocs) {
        if(!isDefined(startloc.team) || startloc.team == spawnteam) {
          startloc.team = spawnteam;
          spawnpoint = spawnStruct();
          spawnpoint.origin = startloc.origin;
          spawnpoint.angles = startloc.angles;
          spawnpoint.index = -1;
          break;
        }
      }
    }
  }

  return spawnpoint;
}

function onplayerconnect() {
  if(isDefined(level.rallypointvehicles)) {
    thread scripts\mp\rally_point::rallypoint_showtoplayer(self);
  }

  thread scripts\mp\gametypes\br_weapons::br_ammo_player_init();
  scripts\mp\class::function_a16868d4dcd81a4b();

  if(!isDefined(self.pers["gamemodeLoadout"])) {
    self.pers["gamemodeLoadout"] = level.gamemodeloadout;
  }
}

function onplayerdisconnect(player) {}

function modeonspawnplayer(revivespawn) {
  self notify("br_spawned");
  scripts\mp\hud_message::function_f004ef4606b9efdc("dom_cap_defend");
  scripts\cp_mp\cash::function_6da8b65579348d0b();
  scripts\cp_mp\squads::updatesquadomnvars(self.team, self.sessionsquadid);

  if(isDefined(self.pers["gamemodeLoadout"]) && isDefined(self.pers["gamemodeLoadout"]["armorPlates"])) {
    self.var_d0205933322679a9 = self.pers["gamemodeLoadout"]["armorPlates"];
    self.pers["gamemodeLoadout"]["armorPlates"] = 0;
  }
}

function onplayerspawned() {
  scripts\mp\gametypes\br_pickups::resetplayerinventory(1, 1);

  if(level.multiteambased) {
    scripts\mp\outofbounds::enableoobimmunity(self);
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  scripts\cp_mp\squads::updatesquadomnvars(self.team, self.sessionsquadid);
  scripts\mp\gametypes\obj_dom::awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid);

  if(level.dropbrloot) {
    scripts\mp\gametypes\br_pickups::droponplayerdeath(attacker);
  }
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  scripts\mp\gametypes\common::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

function setdefaultclass() {
  level.gamemodeloadout["loadoutArchetype"] = "archetype_assault";
  level.gamemodeloadout["loadoutPrimary"] = "iw9_pi_golf17";
  level.gamemodeloadout["loadoutPrimaryAttachment"] = "none";
  level.gamemodeloadout["loadoutPrimaryAttachment2"] = "none";
  level.gamemodeloadout["loadoutPrimaryCamo"] = "none";
  level.gamemodeloadout["loadoutPrimaryReticle"] = "none";
  level.gamemodeloadout["loadoutPrimaryVariantID"] = 0;
  level.gamemodeloadout["loadoutSecondary"] = "none";
  level.gamemodeloadout["loadoutSecondaryAttachment"] = "none";
  level.gamemodeloadout["loadoutSecondaryAttachment2"] = "none";
  level.gamemodeloadout["loadoutSecondaryCamo"] = "none";
  level.gamemodeloadout["loadoutSecondaryReticle"] = "none";
  level.gamemodeloadout["loadoutSecondaryVariantID"] = 0;
  level.gamemodeloadout["loadoutEquipmentPrimary"] = "none";
  level.gamemodeloadout["loadoutEquipmentSecondary"] = "none";
  level.gamemodeloadout["loadoutFieldUpgrade1"] = "none";
  level.gamemodeloadout["loadoutFieldUpgrade2"] = "none";
  level.gamemodeloadout["loadoutStreakType"] = "assault";
  level.gamemodeloadout["loadoutKillstreak1"] = "none";
  level.gamemodeloadout["loadoutKillstreak2"] = "none";
  level.gamemodeloadout["loadoutKillstreak3"] = "none";
  level.gamemodeloadout["loadoutPerks"] = [];
  level.gamemodeloadout["loadoutGesture"] = "playerData";
}

function arm_initoutofbounds() {
  level.outofboundstriggers = [];
  potentialoobtriggers = getEntArray("OutOfBounds", "targetname");

  foreach(trigger in potentialoobtriggers) {
    if(isDefined(trigger.script_team)) {
      trigger delete();
      continue;
    }

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == level.localeid && scripts\mp\utility\game_utility_mp::modeusesgroundwarteamoobtriggers(trigger)) {
      level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
      continue;
    }

    trigger delete();
  }
}

function sortlocationsbydistance(location1, location2) {
  return distancesquared(location1.origin, self.origin) < distancesquared(location2.origin, self.origin);
}

function getmissedinfilcamerapositions(team) {
  assert(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()), "<dev string:x1c>");
  var_b379bc48dc371726 = spawnStruct();
  var_b379bc48dc371726.startorigin = undefined;
  var_b379bc48dc371726.endpos = undefined;

  if(level.mapname == "mp_locale_test") {
    switch (level.localeid) {
      case #"hash_369d88655b32bac0":
      case #"hash_369d96655b32d0ca":
        if(team == "axis") {
          var_b379bc48dc371726.startorigin = (2094, -1804, 2763);
          var_b379bc48dc371726.startangles = (54, 40, 0);
          var_b379bc48dc371726.endorigin = (2094, -1804, 2763);
          var_b379bc48dc371726.endangles = (54, 40, 0);
        } else {
          var_b379bc48dc371726.startorigin = (2315, 1956, 2763);
          var_b379bc48dc371726.startangles = (54, 296, 0);
          var_b379bc48dc371726.endorigin = (2094, -1804, 2763);
          var_b379bc48dc371726.endangles = (54, 40, 0);
        }

        break;
      default:
        var_b379bc48dc371726.startorigin = (0, 0, 0);
        var_b379bc48dc371726.startangles = (0, 0, 0);
        var_b379bc48dc371726.endorigin = (0, 0, 0);
        var_b379bc48dc371726.endangles = (0, 0, 0);
        break;
    }
  } else {
    switch (level.localeid) {
      case #"hash_369d93655b32cc11":
        if(team == "axis") {
          var_b379bc48dc371726.startorigin = (38864, -14018, -396);
          var_b379bc48dc371726.startangles = (3, 250, 0);
          var_b379bc48dc371726.endorigin = (38473, -14077, 401);
          var_b379bc48dc371726.endangles = (15, 252, 0);
        } else {
          var_b379bc48dc371726.startorigin = (30526, -38262, -483);
          var_b379bc48dc371726.startangles = (0, 72, 0);
          var_b379bc48dc371726.endorigin = (30024, -38403, 560);
          var_b379bc48dc371726.endangles = (19, 67, 0);
        }

        break;
      case #"hash_369d96655b32d0ca":
        if(team == "axis") {
          var_b379bc48dc371726.startorigin = (16977, -23256, 169);
          var_b379bc48dc371726.startangles = (9, 69, 0);
          var_b379bc48dc371726.endorigin = (16899, -23467, 683);
          var_b379bc48dc371726.endangles = (15, 68, 0);
        } else {
          var_b379bc48dc371726.startorigin = (18607, 1423, -355);
          var_b379bc48dc371726.startangles = (8, 289, 0);
          var_b379bc48dc371726.endorigin = (18100, 1083, 503);
          var_b379bc48dc371726.endangles = (22, 302, 0);
        }

        break;
      case #"hash_369d88655b32bac0":
        if(team == "axis") {
          var_b379bc48dc371726.startorigin = (18672, -26836, -129);
          var_b379bc48dc371726.startangles = (359, 76, 0);
          var_b379bc48dc371726.endorigin = (18518, -26909, 314);
          var_b379bc48dc371726.endangles = (14, 69, 0);
        } else {
          var_b379bc48dc371726.startorigin = (18607, 1423, -355);
          var_b379bc48dc371726.startangles = (8, 289, 0);
          var_b379bc48dc371726.endorigin = (18100, 1083, 503);
          var_b379bc48dc371726.endangles = (22, 302, 0);
        }

        break;
      case #"hash_2cd4bf8e90f233e7":
      case #"hash_369d95655b32cf37":
        if(team == "axis") {
          var_b379bc48dc371726.startorigin = (24893, 28349, 1408);
          var_b379bc48dc371726.startangles = (15, 54, 0);
          var_b379bc48dc371726.endorigin = (25613, 29274, 1255);
          var_b379bc48dc371726.endangles = (19, 53, 0);
        } else {
          var_b379bc48dc371726.startorigin = (39490, 48919, 2302);
          var_b379bc48dc371726.startangles = (17, 235, 0);
          var_b379bc48dc371726.endorigin = (39254, 48584, 1542);
          var_b379bc48dc371726.endangles = (18, 245, 0);
        }

        break;
      case #"hash_369d89655b32bc53":
        if(team == "axis") {
          var_b379bc48dc371726.startorigin = (48331, -24822, 514);
          var_b379bc48dc371726.startangles = (12, 77, 0);
          var_b379bc48dc371726.endorigin = (48424, -24421, -240);
          var_b379bc48dc371726.endangles = (2, 77, 0);
        } else {
          var_b379bc48dc371726.startorigin = (46188, 2520, 49);
          var_b379bc48dc371726.startangles = (7, 295, 0);
          var_b379bc48dc371726.endorigin = (46571, 2664, 526);
          var_b379bc48dc371726.endangles = (16, 276, 0);
        }

        break;
      case #"hash_2cd4bd8e90f230c1":
        if(team == "axis") {
          var_b379bc48dc371726.startorigin = (-11083, 22197, 381);
          var_b379bc48dc371726.startangles = (10, 181, 0);
          var_b379bc48dc371726.endorigin = (-12112, 23761, 381);
          var_b379bc48dc371726.endangles = (11, 201, 0);
        } else {
          var_b379bc48dc371726.startorigin = (-31134, 11924, -116);
          var_b379bc48dc371726.startangles = (0, 36, 0);
          var_b379bc48dc371726.endorigin = (-31134, 11924, 434);
          var_b379bc48dc371726.endangles = (11, 36, 0);
        }

        break;
      case #"hash_2cd4be8e90f23254":
        if(team == "axis") {
          var_b379bc48dc371726.startorigin = (9215, 984, 325);
          var_b379bc48dc371726.startangles = (357, 186, 0);
          var_b379bc48dc371726.endorigin = (9107, 628, 1144);
          var_b379bc48dc371726.endangles = (19, 182, 0);
        } else {
          var_b379bc48dc371726.startorigin = (-5351, 641, 408);
          var_b379bc48dc371726.startangles = (2, 352, 0);
          var_b379bc48dc371726.endorigin = (-5282, 996, 1103);
          var_b379bc48dc371726.endangles = (11, 347, 0);
        }

        break;
      case #"hash_2cd4b58e90f22429":
        if(team == "axis") {
          var_b379bc48dc371726.startorigin = (-22847, -28632, 34);
          var_b379bc48dc371726.startangles = (12, 42, 0);
          var_b379bc48dc371726.endorigin = (-22694, -28429, 356);
          var_b379bc48dc371726.endangles = (12, 40, 0);
        } else {
          var_b379bc48dc371726.startorigin = (-8084, -20649, 72);
          var_b379bc48dc371726.startangles = (10, 185, 0);
          var_b379bc48dc371726.endorigin = (-9092, -20635, 224);
          var_b379bc48dc371726.endangles = (12, 184, 0);
        }

        break;
      default:
        var_b379bc48dc371726.startorigin = (0, 0, 0);
        var_b379bc48dc371726.startangles = (0, 0, 0);
        var_b379bc48dc371726.endorigin = (0, 0, 0);
        var_b379bc48dc371726.endangles = (0, 0, 0);
        break;
    }
  }

  return var_b379bc48dc371726;
}

function function_658c8f668d2cd83c() {
  wait 5;
  function_f1aed36ab4598ea("mp_gamemode_gw");
}

function spawnai() {
  if(!isDefined(level.difficultytype)) {
    level scripts\mp\ai_mp_controller::function_c8393014dd7f8ab6();
  }

  level thread scripts\mp\gametypes\dmz_ai::init();
  scripts\mp\ai_mp_controller::init();
  function_ba4022744dce59f6("everybody", 100);
  level thread namespace_885300a47c2b51e6::function_ca39a413ace3c168();
  level thread scripts\mp\ai_heli_reinforce::function_d0ffcd08e0870cf2();

  while(!istrue(level.var_aa5583d4cbbfd72e)) {
    waitframe();
  }

  level thread function_848d0782943b416d();
  function_2fc80954fa70d153();

  foreach(obj in level.objectives) {
    groupname = function_78759441c259f58a(obj.trigger.origin);
    cqbstruct = function_2e33f8e46f95167c(obj.trigger.origin, 1024, 1);
    cqbnodes = array_combine(cqbstruct.var_e67f0b2ea7ae69ed, cqbstruct.var_8a055a821dda7da0, cqbstruct.var_3288c473e8336ab4);
    numagents = getdvarint(@ "hash_347125fd6d3e5b8b", 15);

    if(numagents > 0) {
      for(i = 0; i < numagents; i++) {
        aitype = function_d5bc07eabf352abb(undefined, undefined, groupname, undefined, 3);
        var_ef178bb38661ff1b = undefined;

        if(cqbnodes.size > 0) {
          potentialnodes = function_3a17f0ccddc999b4(obj.trigger.origin, cqbnodes, cqbnodes.size, 256, 0);
          potentialnodes = array_randomize(potentialnodes);

          if(potentialnodes.size > 0) {
            var_ef178bb38661ff1b = potentialnodes[0];
          }
        }

        spawnorigin = obj.trigger.origin;

        if(isDefined(var_ef178bb38661ff1b)) {
          spawnorigin = var_ef178bb38661ff1b.origin;
        }

        agent = ai_mp_requestspawnagent(aitype, spawnorigin, (0, 0, 0), "medium", "everybody", "captureAgents", groupname, undefined, undefined, undefined, 1, 1);

        if(isDefined(agent)) {
          scripts\mp\gametypes\common::function_35c195df2ba46725(agent, "team_hundred_ninety_five");

          if(isDefined(var_ef178bb38661ff1b)) {
            function_2b26d000f2ccfc11(agent, var_ef178bb38661ff1b);
          } else {
            agent thread scripts\mp\ai_behavior::function_9bbf1713a14fa580(agent, 256, 256);
          }

          if(isDefined(obj.aivolume)) {
            agent setgoalvolumeauto(obj.aivolume);
          }
        }
      }
    }

    var_40e875a042b82875 = getdvarint(@ "hash_6bd0ae2b33a87d23", 0);

    if(var_40e875a042b82875 > 0) {
      for(i = 0; i < var_40e875a042b82875; i++) {
        var_ef178bb38661ff1b = undefined;

        if(cqbnodes.size > 0) {
          potentialnodes = function_3a17f0ccddc999b4(obj.trigger.origin, cqbnodes, cqbnodes.size, 256, 0);
          potentialnodes = array_randomize(potentialnodes);

          if(potentialnodes.size > 0) {
            var_ef178bb38661ff1b = potentialnodes[0];
          }
        }

        spawnorigin = obj.trigger.origin;

        if(isDefined(var_ef178bb38661ff1b)) {
          spawnorigin = var_ef178bb38661ff1b.origin;
        }

        agent = ai_mp_requestspawnagent("actor_enemy_mp_jugg_aq", spawnorigin, (0, 0, 0), "absolute", "everybody", "jugg", groupname, undefined, undefined, undefined, 1, 1);

        if(isDefined(agent)) {
          scripts\mp\gametypes\common::function_35c195df2ba46725(agent, "team_hundred_ninety_five");
          scripts\cp_mp\agents\agent_utils::function_1828f1e20e52b418(agent);
          scripts\mp\gametypes\common::function_35c195df2ba46725(agent, "team_hundred_ninety_five");

          if(isDefined(var_ef178bb38661ff1b)) {
            function_2b26d000f2ccfc11(agent, var_ef178bb38661ff1b);
          } else {
            agent thread scripts\mp\ai_behavior::function_9bbf1713a14fa580(agent, 256, 256);
          }

          if(isDefined(obj.aivolume)) {
            agent setgoalvolumeauto(obj.aivolume);
          }
        }
      }
    }
  }

  if(getdvarint(@ "hash_8d1f02f0286bc046", 1) == 1) {
    level thread function_d4ed75580b9194a4();
  }
}

function function_d4ed75580b9194a4() {
  gridmin = (-38000, -22000, 250);
  stepx = 512;
  stepy = 512;
  var_d3abc028986e8adc = 12;
  var_d3abc128986e8d0f = 7;
  gridyaw = (0, 25, 0);
  gridfwd = anglesToForward(gridyaw);
  gridright = anglestoright(gridyaw);
  spawnpoints = [];

  for(x = 2; x < var_d3abc028986e8adc; x++) {
    for(y = 2; y < var_d3abc128986e8d0f; y++) {
      spawnpoints[spawnpoints.size] = gridmin + gridfwd * x * stepx + gridright * y * stepy;
    }
  }

  foreach(origin in spawnpoints) {
    nodearray = getnodesinradiussorted(origin, 512, 0, 512, "Path", 1);

    if(isDefined(nodearray[0])) {
      spawnorigin = nodearray[0].origin;
      groupname = function_78759441c259f58a(spawnorigin);
      aitype = function_d5bc07eabf352abb();
      agent = ai_mp_requestspawnagent(aitype, spawnorigin, (0, 0, 0), "medium", "everybody", "captureAgents", groupname, undefined, undefined, undefined, 1, 1);

      if(isDefined(agent)) {
        scripts\mp\gametypes\common::function_35c195df2ba46725(agent, "team_hundred_ninety_five");
        agent thread scripts\mp\ai_behavior::function_9bbf1713a14fa580(agent, 1024, 512);
      }
    }
  }

  text = 0;
}

function function_a30a48f0c1a403ec(objectivekey, team, numagents, var_40e875a042b82875) {
  if(!istrue(level.var_eaa760f325371803)) {
    return;
  }

  obj = level.objectives[objectivekey];
  groupname = function_78759441c259f58a(obj.trigger.origin);
  cqbstruct = function_2e33f8e46f95167c(obj.trigger.origin, 1024, 1);
  cqbnodes = array_combine(cqbstruct.var_e67f0b2ea7ae69ed, cqbstruct.var_8a055a821dda7da0, cqbstruct.var_3288c473e8336ab4);

  if(!isDefined(numagents)) {
    numagents = getdvarint(@ "hash_9e91a52d9df515a0", 5);
  }

  if(numagents > 0) {
    for(i = 0; i < numagents; i++) {
      aitype = function_d5bc07eabf352abb();
      agent = ai_mp_requestspawnagent(aitype, obj.trigger.origin, (0, 0, 0), "medium", "everybody", "captureAgents", groupname, team, undefined, undefined, 1, 1);

      if(isDefined(agent)) {
        scripts\mp\gametypes\common::function_35c195df2ba46725(agent, "team_hundred_ninety_five");

        if(cqbnodes.size > 0) {
          potentialnodes = function_3a17f0ccddc999b4(agent.origin, cqbnodes, cqbnodes.size, 256, 0);
          potentialnodes = array_randomize(potentialnodes);

          if(potentialnodes.size > 0) {
            agent.balwayscoverexposed = 1;
            function_2b26d000f2ccfc11(agent, potentialnodes[0]);
          } else {
            agent thread scripts\mp\ai_behavior::function_9bbf1713a14fa580(agent, 256, 256);
          }
        } else {
          agent thread scripts\mp\ai_behavior::function_9bbf1713a14fa580(agent, 256, 256);
        }

        agent setgoalvolumeauto(obj.aivolume);
        agent.objectivekey = objectivekey;
        level.objectivereinforcements[objectivekey][team].agents[level.objectivereinforcements[objectivekey][team].agents.size] = agent;
      }
    }
  }

  if(!isDefined(var_40e875a042b82875)) {
    var_40e875a042b82875 = getdvarint(@ "hash_b191b8b0b5527c26", 0);
  }

  if(var_40e875a042b82875 > 0) {
    for(i = 0; i < var_40e875a042b82875; i++) {
      agent = ai_mp_requestspawnagent("actor_enemy_mp_jugg_aq", obj.trigger.origin, (0, 0, 0), "absolute", "everybody", "jugg", groupname, undefined, undefined, undefined, 1, 1);

      if(isDefined(agent)) {
        scripts\mp\gametypes\common::function_35c195df2ba46725(agent, "team_hundred_ninety_five");
        scripts\cp_mp\agents\agent_utils::function_1828f1e20e52b418(agent);

        if(cqbnodes.size > 0) {
          potentialnodes = function_3a17f0ccddc999b4(agent.origin, cqbnodes, cqbnodes.size, 256, 0);
          potentialnodes = array_randomize(potentialnodes);

          if(potentialnodes.size > 0) {
            agent.balwayscoverexposed = 1;
            function_2b26d000f2ccfc11(agent, potentialnodes[0]);
          } else {
            agent thread scripts\mp\ai_behavior::function_9bbf1713a14fa580(agent, 256, 256);
          }
        } else {
          agent thread scripts\mp\ai_behavior::function_9bbf1713a14fa580(agent, 256, 256);
        }

        agent setgoalvolumeauto(obj.aivolume);
      }
    }
  }
}

function function_3b97b97e14948c02(desired_origin, var_93390a6953905fef) {
  org_struct = spawnStruct();
  org_struct.origin = desired_origin;
  unload_locs = sortbydistance(level.helireinforcestruct.unload_locs, org_struct.origin);
  pathnode = scripts\mp\ai_heli_reinforce::function_321665dcdcbf401e(unload_locs, desired_origin);

  if(isDefined(pathnode)) {
    return pathnode;
  }

  return undefined;
}

function function_5cd456d9b2cdc538(agent, killer) {
  if(!isDefined(agent.objectivekey) || !isgameplayteam(agent.team)) {
    return;
  }

  level.objectivereinforcements[agent.objectivekey][agent.team].agents = array_remove(level.objectivereinforcements[agent.objectivekey][agent.team].agents, agent);
}

function function_848d0782943b416d() {
  scripts\mp\ai_mp_controller::function_93add0b65db9f722(&function_5cd456d9b2cdc538, level);
  desiredcount = getdvarint(@ "hash_9e91a52d9df515a0", 5);
  var_fde40312bd18ae9e = getdvarint(@ "hash_ebadb231161de9d", 2);
  var_68299821ad1626e0 = getdvarint(@ "hash_84f9bf19eb2301e", 30) * 1000;
  level.objectivereinforcements = [];

  foreach(key, obj in level.objectives) {
    level.objectivereinforcements[key] = [];

    foreach(team in level.teamnamelist) {
      data = spawnStruct();
      data.agents = [];
      data.var_8e55c5943a080a2e = 0;
      level.objectivereinforcements[key][team] = data;
    }
  }

  while(level.objectives.size) {
    foreach(key, obj in level.objectives) {
      wait 1;
      team = obj.ownerteam;

      if(team == "neutral") {
        continue;
      }

      currenttime = gettime();

      if(currenttime < level.objectivereinforcements[key][team].var_8e55c5943a080a2e + var_68299821ad1626e0) {
        continue;
      }

      var_9cc5be111b6fa65c = [];

      foreach(agent in level.objectivereinforcements[key][team].agents) {
        if(agent.health > 0) {
          var_9cc5be111b6fa65c[var_9cc5be111b6fa65c.size] = agent;
        }
      }

      level.objectivereinforcements[key][team].agents = var_9cc5be111b6fa65c;
      currentcount = level.objectivereinforcements[key][team].agents.size;

      if(currentcount <= var_fde40312bd18ae9e) {
        level thread function_a30a48f0c1a403ec(key, team, desiredcount - currentcount, 0);
        level.objectivereinforcements[key][team].var_8e55c5943a080a2e = currenttime;
      }
    }
  }
}

function snapshotinventory() {
  items = [];
  inventoryweapons = namespace_aead94004cf4c147::getinventoryweapons(self);

  foreach(weapon in inventoryweapons) {
    variantid = weapon.variantid;

    if(!isDefined(weapon.variantid)) {
      variantid = 0;
    }

    rootname = scripts\cp_mp\weapon::getweaponrootname(weapon);
    lootid = scripts\cp_mp\weapon::function_79d6e6c22245687a(rootname, variantid);

    if(isDefined(lootid) && lootid > 0) {
      item = spawnStruct();
      item.lootid = lootid;
      item.ref = rootname;
      item.attachments = weapon.attachments;
      item.camo = weapon.camo;
      item.reticle = weapon.reticle;
      item.variantid = variantid;
      item.quantity = 1;

      if(!isDefined(items["loadoutPrimary"])) {
        items["loadoutPrimary"] = item;
        continue;
      }

      if(!isDefined(items["loadoutSecondary"])) {
        items["loadoutSecondary"] = item;
      }
    }
  }

  self.pers["br_ammo"] = self.br_ammo;
  ref = scripts\mp\equipment::getcurrentequipment("primary");
  equipmentammo = scripts\mp\equipment::getequipmentslotammo("primary");
  lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);

  if(isDefined(lootid) && equipmentammo > 0) {
    item = spawnStruct();
    item.lootid = lootid;
    item.ref = ref;
    item.quantity = 1;
    items["loadoutEquipmentPrimary"] = item;
  }

  ref = scripts\mp\equipment::getcurrentequipment("secondary");
  equipmentammo = scripts\mp\equipment::getequipmentslotammo("secondary");
  lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);

  if(isDefined(lootid) && equipmentammo > 0) {
    item = spawnStruct();
    item.lootid = lootid;
    item.ref = ref;
    item.quantity = 1;
    items["loadoutEquipmentSecondary"] = item;
  }

  ref = scripts\mp\equipment::getcurrentequipment("super");
  ref = scripts\cp_mp\utility\loot::function_151b82e1257f4cde(ref);
  equipmentammo = scripts\mp\gametypes\br::getsuperweapondisabledammobr();
  lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);

  if(isDefined(lootid) && equipmentammo > 0) {
    item = spawnStruct();
    item.lootid = lootid;
    item.ref = ref;
    item.quantity = 1;
    items["loadoutFieldUpgrade1"] = item;
  }

  ref = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1);

  if(isDefined(ref)) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref.streakname);

    if(isDefined(lootid)) {
      item = spawnStruct();
      item.lootid = lootid;
      item.ref = ref;
      item.quantity = 1;
      items["loadoutKillstreak1"] = item;
    }
  }

  if(scripts\mp\gametypes\br_public::hasplatepouch()) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref("armor_satchel");

    if(isDefined(lootid)) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items["armorSatchel"] = item;
    }
  }

  itemname = self.equipment["health"];
  itemcount = scripts\mp\equipment::getequipmentslotammo("health");

  if(isDefined(itemname) && isDefined(itemcount) && itemcount > 0) {
    item = spawnStruct();
    item.lootid = scripts\cp_mp\utility\loot::getlootidfromref("armor_plate");
    item.quantity = itemcount;
    items["armorPlates"] = item;
  }

  return items;
}

function function_a17ce79209ceccfc() {
  if(istrue(level.var_b543c0a24964346e)) {
    return;
  }

  foreach(player in level.players) {
    player.pers["gamemodeLoadout"] = level.gamemodeloadout;

    if(isreallyalive(player)) {
      inventory = player snapshotinventory();

      if(isDefined(inventory["loadoutPrimary"])) {
        player.pers["gamemodeLoadout"]["loadoutPrimary"] = inventory["loadoutPrimary"].ref;

        for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
          attachstring = scripts\mp\class::getattachmentloadoutstring(attachmentindex, #"primary");
          player.pers["gamemodeLoadout"][attachstring] = inventory["loadoutPrimary"].attachments[attachmentindex];
        }

        player.pers["gamemodeLoadout"]["loadoutPrimaryCamo"] = inventory["loadoutPrimary"].camo;
        player.pers["gamemodeLoadout"]["loadoutPrimaryReticle"] = inventory["loadoutPrimary"].reticle;
        player.pers["gamemodeLoadout"]["loadoutPrimaryVariantID"] = inventory["loadoutPrimary"].variantid;
      }

      if(isDefined(inventory["loadoutSecondary"])) {
        player.pers["gamemodeLoadout"]["loadoutSecondary"] = inventory["loadoutSecondary"].ref;

        for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
          attachstring = scripts\mp\class::getattachmentloadoutstring(attachmentindex, #"secondary");
          player.pers["gamemodeLoadout"][attachstring] = inventory["loadoutSecondary"].attachments[attachmentindex];
        }

        player.pers["gamemodeLoadout"]["loadoutSecondaryCamo"] = inventory["loadoutSecondary"].camo;
        player.pers["gamemodeLoadout"]["loadoutSecondaryReticle"] = inventory["loadoutSecondary"].reticle;
        player.pers["gamemodeLoadout"]["loadoutSecondaryVariantID"] = inventory["loadoutSecondary"].variantid;
      }

      if(isDefined(inventory["loadoutEquipmentPrimary"])) {
        player.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"] = inventory["loadoutEquipmentPrimary"].ref;
      }

      if(isDefined(inventory["loadoutEquipmentSecondary"])) {
        player.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"] = inventory["loadoutEquipmentSecondary"].ref;
      }

      if(isDefined(inventory["loadoutFieldUpgrade1"])) {
        player.pers["gamemodeLoadout"]["loadoutFieldUpgrade1"] = inventory["loadoutFieldUpgrade1"].ref;
      }

      if(isDefined(inventory["loadoutKillstreak1"])) {
        player.pers["gamemodeLoadout"]["loadoutKillstreak1"] = inventory["loadoutKillstreak1"].ref;
      }

      if(isDefined(inventory["armorSatchel"])) {
        player.pers["gamemodeLoadout"]["armorSatchel"] = inventory["armorSatchel"];
      }

      if(isDefined(inventory["armorPlates"])) {
        player.pers["gamemodeLoadout"]["armorPlates"] = inventory["armorPlates"].quantity;
      }
    }
  }

  level.var_b543c0a24964346e = 1;
}

function ontimelimit() {
  if(level.gameended) {
    return;
  }

  foreach(obj in level.objectives) {
    if(obj.claimteam != "none" || obj.stalemate) {
      return;
    }
  }

  if(getdvarint(@ "hash_8f25cefeaed5250d", 1) == 1) {
    function_354ebff91b3c29ca();
  }

  function_a17ce79209ceccfc();
  scripts\mp\gamelogic::default_ontimelimit();
}

function onscorelimit(winner) {
  if(level.gameended) {
    return;
  }

  if(getdvarint(@ "hash_8f25cefeaed5250d", 1) == 1) {
    function_354ebff91b3c29ca();
  }

  function_a17ce79209ceccfc();
}

function function_947925f5fc6939a3() {
  if(level.gameended) {
    return;
  }

  if(getdvarint(@ "hash_8f25cefeaed5250d", 1) == 1) {
    function_354ebff91b3c29ca();
  }

  function_a17ce79209ceccfc();
  return 1;
}

function function_354ebff91b3c29ca() {
  var_2704eda0a8d8ea7a = scripts\mp\agents\agent_utility::getactiveagentsoftype("all");

  foreach(agent in var_2704eda0a8d8ea7a) {
    scripts\mp\agents\agent_utility::killagent(agent);
  }
}

function zone_onuse(credit_player) {
  scripts\mp\gameobjects::setownerteam(credit_player.team);
  scripts\mp\gamescore::giveteamscoreforobjective(credit_player.team, 1, 0);

  if(istrue(level.var_eaa760f325371803)) {
    level thread function_a30a48f0c1a403ec(self.objectivekey, self.ownerteam);
  }
}

function function_3e175c0b6527751f() {
  towerlocs = [];
  tower = spawnStruct();
  tower.origin = (-36817, -23834, 255);
  tower.angles = (0, 302, 0);
  towerlocs[towerlocs.size] = tower;
  tower = spawnStruct();
  tower.origin = (-33345, -24830, 256);
  tower.angles = (0, 236, 0);
  towerlocs[towerlocs.size] = tower;
  tower = spawnStruct();
  tower.origin = (-31695, -22035, 256);
  tower.angles = (0, 154, 0);
  towerlocs[towerlocs.size] = tower;
  tower = spawnStruct();
  tower.origin = (-32684, -20101, 261);
  tower.angles = (0, 96, 0);
  towerlocs[towerlocs.size] = tower;
  tower = spawnStruct();
  tower.origin = (-36176, -19765, 264);
  tower.angles = (0, 335, 0);
  towerlocs[towerlocs.size] = tower;
  count = getdvarint(@ "hash_a4708ad20d0d266e", 3);
  towerlocs = array_randomize(towerlocs);
  towerlocs = array_slice(towerlocs, 0, count);
  return towerlocs;
}

function allowclasschoicefunc() {
  return level.allowclasschoice;
}