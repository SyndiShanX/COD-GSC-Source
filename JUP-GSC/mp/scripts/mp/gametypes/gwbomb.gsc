/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\gwbomb.gsc
***********************************************/

#using script_1d4b01c1ec829364;
#using script_2f4866552f0ba818;
#using script_640cf1641c03e2a0;
#using scripts\common\utility;
#using scripts\cp_mp\cash;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\nuke;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rally_point;
#using scripts\mp\rank;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;
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
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace gwbomb;

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
    registertimelimitdvar(getgametype(), 300);
    registerscorelimitdvar(getgametype(), 3);
    registerroundlimitdvar(getgametype(), 1);
    registerwinlimitdvar(getgametype(), 1);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
  }

  setDvar(@ "hash_405e7e20d91344cc", 0);
  setDvar(@ "scr_allow_technicals", 1);
  setDvar(@ "scr_runlean_max_technicals", 30);
  setDvar(@ "hash_cbc195ec2129279", 0);
  setomnvar("ui_num_dom_flags", 6);
  enablegroundwarspawnlogic(400, 1200);
  updategametypedvars();
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&onjoinedteam);
  level.scoreperplayer = undefined;
  level.onstartgametype = &onstartgametype;
  level.onplayerconnect = &onplayerconnect;
  level.getspawnpoint = &getspawnpoint;
  level.modeonspawnplayer = &onspawnplayer;
  level.onplayerkilled = &onplayerkilled;
  level.onrespawndelay = &getrespawndelay;
  level.onnormaldeath = &onnormaldeath;
  level.onobjectivecomplete = &onobjectivecomplete;
  level.updatefobspawnselection = &updatefobspawnselection;

  level.var_e3a2a0c2e544728e = &function_e3a2a0c2e544728e;

  level.domflag_setneutral = &scripts\mp\gametypes\obj_dom::domflag_setneutral;
  level.dompoint_setcaptured = &scripts\mp\gametypes\obj_dom::dompoint_setcaptured;
  level.requiredplayercountoveride = 1;
  level.requiredplayercount["allies"] = 24;
  level.requiredplayercount["axis"] = 24;
  level.var_e637d49948a038d3 = &getmissedinfilcamerapositions;
  level.var_3c89983e2030dfff = &calculatecameraoffset;
  game["dialog"]["gametype"] = "iw9_gwbm_mode_uktl_name";

  if(getdvarint(@ "hash_4a2b3d01a81655a6")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint(hashcat(@ "scr_", getgametype(), "_promode"))) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "iw9_gwbm_mode_uktl_gbbs";
  game["dialog"]["defense_obj"] = "iw9_gwbm_mode_uktl_gbbs";
  game["dialog"]["lead_taken"] = "iw9_gwbm_mode_uktl_gblg";
  game["dialog"]["lead_lost"] = "iw9_gwbm_mode_uktl_gbll";
  game["dialog"]["lead_tied"] = "iw9_gwbm_mode_uktl_gblt";
  game["dialog"]["gwbomb_progress_defense"] = "iw9_gwbm_mode_uktl_gbpd";
  game["dialog"]["gwbomb_progress_offense"] = "iw9_gwbm_mode_uktl_gbpa";
  game["dialog"]["gwbomb_last_site_defense"] = "iw9_gwbm_mode_uktl_gbld";
  game["dialog"]["gwbomb_last_site_offense"] = "iw9_gwbm_mode_uktl_gblo";
  game["dialog"]["bomb_planting_a"] = "iw9_gwbm_mode_uktl_gbxa";
  game["dialog"]["bomb_planted_a"] = "iw9_gwbm_mode_uktl_gpoa";
  game["dialog"]["enemy_bomb_a"] = "iw9_gwbm_mode_uktl_gpda";
  game["dialog"]["bomb_defused_a"] = "iw9_gwbm_mode_uktl_gdda";
  game["dialog"]["enemy_bomb_defused_a"] = "iw9_gwbm_mode_uktl_gdoa";
  game["dialog"]["site_destroyed_a"] = "iw9_gwbm_mode_uktl_gxda";
  game["dialog"]["enemy_site_destroyed_a"] = "iw9_gwbm_mode_uktl_gxoa";
  game["dialog"]["bomb_planting_b"] = "iw9_gwbm_mode_uktl_gbxb";
  game["dialog"]["bomb_planted_b"] = "iw9_gwbm_mode_uktl_gpob";
  game["dialog"]["enemy_bomb_b"] = "iw9_gwbm_mode_uktl_gpdb";
  game["dialog"]["bomb_defused_b"] = "iw9_gwbm_mode_uktl_gddb";
  game["dialog"]["enemy_bomb_defused_b"] = "iw9_gwbm_mode_uktl_gdob";
  game["dialog"]["site_destroyed_b"] = "iw9_gwbm_mode_uktl_gxdb";
  game["dialog"]["enemy_site_destroyed_b"] = "iw9_gwbm_mode_uktl_gxob";
  game["dialog"]["bomb_planting_c"] = "iw9_gwbm_mode_uktl_gbxc";
  game["dialog"]["bomb_planted_c"] = "iw9_gwbm_mode_uktl_gpoc";
  game["dialog"]["enemy_bomb_c"] = "iw9_gwbm_mode_uktl_gpdc";
  game["dialog"]["bomb_defused_c"] = "iw9_gwbm_mode_uktl_gddc";
  game["dialog"]["enemy_bomb_defused_c"] = "iw9_gwbm_mode_uktl_gdoc";
  game["dialog"]["site_destroyed_c"] = "iw9_gwbm_mode_uktl_gxdc";
  game["dialog"]["enemy_site_destroyed_c"] = "iw9_gwbm_mode_uktl_gxoc";
  game["dialog"]["bomb_planting_d"] = "iw9_gwbm_mode_uktl_gbxd";
  game["dialog"]["bomb_planted_d"] = "iw9_gwbm_mode_uktl_gpod";
  game["dialog"]["enemy_bomb_d"] = "iw9_gwbm_mode_uktl_gpdd";
  game["dialog"]["bomb_defused_d"] = "iw9_gwbm_mode_uktl_gddd";
  game["dialog"]["enemy_bomb_defused_d"] = "iw9_gwbm_mode_uktl_gdod";
  game["dialog"]["site_destroyed_d"] = "iw9_gwbm_mode_uktl_gxdd";
  game["dialog"]["enemy_site_destroyed_d"] = "iw9_gwbm_mode_uktl_gxod";
  game["dialog"]["bomb_planting_e"] = "iw9_gwbm_mode_uktl_gbxe";
  game["dialog"]["bomb_planted_e"] = "iw9_gwbm_mode_uktl_gpoe";
  game["dialog"]["enemy_bomb_e"] = "iw9_gwbm_mode_uktl_gpde";
  game["dialog"]["bomb_defused_e"] = "iw9_gwbm_mode_uktl_gdde";
  game["dialog"]["enemy_bomb_defused_e"] = "iw9_gwbm_mode_uktl_gdoe";
  game["dialog"]["site_destroyed_e"] = "iw9_gwbm_mode_uktl_gxde";
  game["dialog"]["enemy_site_destroyed_e"] = "iw9_gwbm_mode_uktl_gxoe";
  game["dialog"]["bomb_planting_f"] = "iw9_gwbm_mode_uktl_gbxf";
  game["dialog"]["bomb_planted_f"] = "iw9_gwbm_mode_uktl_gpof";
  game["dialog"]["enemy_bomb_f"] = "iw9_gwbm_mode_uktl_gpdf";
  game["dialog"]["bomb_defused_f"] = "iw9_gwbm_mode_uktl_gddf";
  game["dialog"]["enemy_bomb_defused_f"] = "iw9_gwbm_mode_uktl_gdof";
  game["dialog"]["site_destroyed_f"] = "iw9_gwbm_mode_uktl_gxdf";
  game["dialog"]["enemy_site_destroyed_f"] = "iw9_gwbm_mode_uktl_gxof";
  game["dialog"]["bomb_planting_g"] = "iw9_gwbm_mode_uktl_gbxg";
  game["dialog"]["bomb_planted_g"] = "iw9_gwbm_mode_uktl_gpog";
  game["dialog"]["enemy_bomb_g"] = "iw9_gwbm_mode_uktl_gpdg";
  game["dialog"]["bomb_defused_g"] = "iw9_gwbm_mode_uktl_gddg";
  game["dialog"]["enemy_bomb_defused_g"] = "iw9_gwbm_mode_uktl_gdog";
  game["dialog"]["site_destroyed_g"] = "iw9_gwbm_mode_uktl_gxdg";
  game["dialog"]["enemy_site_destroyed_g"] = "iw9_gwbm_mode_uktl_gxog";
  game["dialog"]["bomb_planting_h"] = "iw9_gwbm_mode_uktl_gbxh";
  game["dialog"]["bomb_planted_h"] = "iw9_gwbm_mode_uktl_gpoh";
  game["dialog"]["enemy_bomb_h"] = "iw9_gwbm_mode_uktl_gpdh";
  game["dialog"]["bomb_defused_h"] = "iw9_gwbm_mode_uktl_gddh";
  game["dialog"]["enemy_bomb_defused_h"] = "iw9_gwbm_mode_uktl_gdoh";
  game["dialog"]["site_destroyed_h"] = "iw9_gwbm_mode_uktl_gxdh";
  game["dialog"]["enemy_site_destroyed_h"] = "iw9_gwbm_mode_uktl_gxoh";
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_snatch_ac130_clouds"] = loadfx("vfx/iw8_mp/gamemode/vfx_snatch_ac130_clouds.vfx");
  level._effect["vfx_br_infil_cloud_scroll"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_br_infil_omni_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_omni_light.vfx");
  level._effect["vfx_br_infil_spot_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_spot_light.vfx");
  level.var_39a48a5896d2b3e8 = 1;
  level.bombsplanted = 0;
  level.ddbombmodel = [];
  level.aplanted = 0;
  level.bplanted = 0;
  level.nukeselectactive = getdvarint(@ "hash_720c7a325f31f44b", 0);
  level.killstoearnnukeselect = getdvarint(@ "hash_b081c1dd5ea0af33", 7);
  level.useobjectives = getdvarint(@ "hash_f487c553b2ae0bdb", 1);
  level.userallypointvehicles = getdvarint(@ "hash_9381d93d96c2f50b", 1);
  level.hideenemyhq = getdvarint(@ "hash_5309488dd7832413", 0);
  level.hideenemyfobs = getdvarint(@ "hash_7aefd938edd32dcc", 0);
  level.completelyremovelittlebird = getdvarint(@ "hash_e39e476d418a5b03", 0);
  level.usec130spawn = getdvarint(@ "hash_9d9bb5a2f8144fb0", 0);
  level.usec130spawnfirstonly = getdvarint(@ "hash_930ce0bf448dadaa", 0);
  level.c130movementmethod = getdvarint(@ "hash_2a34ac7d0124085e", 0);
  level.c130flightdist = getdvarfloat(@ "hash_2d511cfd4eb77221", 4000);
  level.c130distapart = getdvarfloat(@ "hash_ef46594cd3335bd3", 5000);
  level.c130alignedtolocale = getdvarfloat(@ "hash_f4da32c36b5dcd26", 1);
  level.var_67a7732487fb9242 = getdvarint(@ "hash_e4a8296b521a6dee", 1) == 1;
  level.var_90f4dc933b674184 = getdvarfloat(@ "hash_91d950c33d45ae50", 60);
  level.var_1a505675f3ef1197 = getdvarfloat(@ "hash_58c456ebd6371a4b", 60);
  level.var_8e9daba162280a8e = getdvarint(@ "hash_19e5cada53ccf044", 0) == 1;
  level.var_eaa760f325371803 = getdvarint(@ "hash_67a32114ce80b58f", 0) == 1;
  level.var_7f5be0207e7457b1 = getdvarint(@ "hash_27abaa55d7ec8eb9", 1) == 1;
  level.var_d23c7c1add9fb181 = &function_d23c7c1add9fb181;
  level.var_4de8052758f986f3 = &function_4de8052758f986f3;
  level.var_3ce1055115edcbbb = &function_3ce1055115edcbbb;
  level.skydiveredeploy = &skydiveredeploy;
  level.dropbrloot = getdvarint(@ "hash_1d196605f8a290e3", 0);
  level.br_plunder_enabled = getdvarint(@ "scr_game_cash", 0);

  if(level.br_plunder_enabled) {
    scripts\cp_mp\utility\loot::init();
    level.var_e247454ac2869696 = 0;
  }

  level.var_1e17e3480b1d264d = getdvarint(@ "hash_644f043f54d141f5", 0);
  level.var_1f42dab41eff5cb2 = getdvarint(@ "hash_8fd67e929af907eb", 0);

  if(level.var_1e17e3480b1d264d) {
    level.var_9c1e3c18b99409e9 = &function_9c1e3c18b99409e9;
  }

  level.spawnselectionshowenemy = getdvarint(@ "hash_3f0db83ea7503667", 0);
  level.spawnselectionshowfriendly = getdvarint(@ "hash_4134532f274e5dfa", 0);
  level.forcetopickafob = getdvarint(@ "scr_arm_forcespawning", 0);
  level.maxhqtanks = getdvarint(@ "scr_arm_maxhqtanks", 2);
  level.tankrespawntime = getdvarint(@ "hash_b624863894a18f21", 120);
  level.apcrespawntime = getdvarint(@ "hash_ba2474692378b203", 120);
  level.longdialoguecooldown = getdvarint(@ "hash_e01953fcf34a5d51", 1);
  level.mercymatchending_nuke = getdvarint(@ "hash_647cfd0a848d6ed6", 1);
  level.mercymatchending_time = getdvarint(@ "scr_arm_mercyendingtime", 30);
  level.numnonrallyvehicles = getdvarint(@ "scr_arm_numnonrallyvehicles", 25);
  level.disablepersonalnuke = getdvarint(@ "hash_f271257bddc28c95", 0);
  level.personalnukecostoverride = getdvarint(@ "hash_d9455f252fccdb97", 30);
  level.showteamtanks = getdvarint(@ "hash_236401104966b535", 1);
  level.spawnselectionafktime = getdvarint(@ "hash_da4e1d4c2111a1bc", 120);
  level.manualadjustlittlebirdlocs = getdvarint(@ "hash_1d04716268113cb5", 1);
  level.var_b307135dbcef5a38 = getdvarint(@ "hash_8f147ae2cd92aca", 1);

  if(istrue(level.showteamtanks)) {
    level.trackedtanks = [];
    level.trackedtanks["axis"] = [];
    level.trackedtanks["allies"] = [];
  }

  if(level.useobjectives || level.userallypointvehicles || level.usesquadspawnselection) {
    setDvar(@ "scr_game_usespawnselection", 1);
    setDvar(@ "scr_game_disablespawncamera", 0);
    setDvar(@ "scr_game_disablespawncamera", 0);
    setDvar(@ "hash_1a2c3b67392b6657", 1);
  } else {
    setDvar(@ "scr_game_usespawnselection", 0);
    setDvar(@ "scr_game_disablespawncamera", 1);
    setDvar(@ "hash_1a2c3b67392b6657", 1);
  }

  if(level.c130movementmethod == 1) {
    level.c130pathkilltracker = [];
    level.c130pathkilltracker["axis"] = 0;
    level.c130pathkilltracker["allies"] = 0;
  }

  level.modecontrolledvehiclespawningonly = 1;
  level.disableteamstartspawns = 1;
  level.spawnprotectionexception = &spawnprotectionexception;
  thread function_658c8f668d2cd83c();

  if(getdvarint(@ "hash_60a5cd40eb9c3192", 0) == 1) {
    level thread function_5a426c120b990e2c();
  }

  flag_init("stealth_enabled");
  flag_init("level_stealth_initialized");
  flag_init("stealth_spotted");
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_874f7df517d43f9b", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar(@ "hash_50e0e257239ad03b", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar(@ "hash_a4357008fe46fe87", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar(@ "hash_529e04e79248d1d2", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar(@ "hash_5673ef1fd6c167c7", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar(@ "hash_bfb4b2b0a0e6e509", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar(@ "hash_97df2d78c43bcb98", getmatchrulesdata("tdefData", "spawnDelay"));
  registerhalftimedvar("arm", 0);
}

function onstartgametype() {
  setomnvar("ui_victory_condition_completed", 0);

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  foreach(team in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivehinttext(team, &"OBJECTIVES/GWBOMB_HINT");
  }

  setclientnamemode("auto_change");
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  level.multibomb = 1;
  level._effect["bomb_explosion"] = loadfx("vfx/iw9/dmz/bombsite/vfx_dmz_bombsite_expl.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.objectives = [];
  level.uncapturableobjectives = [];
  initspawns();
  seticonnames();
  level.usedomflag = 0;
  level.killstreakqueue = [];
  level.teamkillstreakqueue = [];
  level.teamkillstreakqueue["allies"] = [];
  level.teamkillstreakqueue["axis"] = [];
  level.killstreaklist = [];
  level.killstreaklist[4] = ["cruise_predator", "scrambler_drone_guard"];
  level.killstreaklist[3] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level.killstreaklist[2] = ["toma_strike", "chopper_gunner", "pac_sentry", "gunship"];
  level.teamkillstreakqueue["allies"] = ["cruise_predator", "precision_airstrike", "cruise_predator"];
  level.teamkillstreakqueue["axis"] = ["cruise_predator", "precision_airstrike", "cruise_predator"];
  level thread setupwaypointicons();
  debug_setupmatchdata();
  setuphqs();
  calculatehqmidpoint();

  if(istrue(level.useobjectives)) {
    level thread setupobjectives();
  }

  level thread runobjectives();

  if(level.usec130spawn) {
    level thread managec130spawns();
  }

  level thread function_9c513c5e546a4f52();

  if(istrue(level.userallypointvehicles)) {
    scripts\mp\rally_point::init();
    level thread init_rallyvehicles();
  }

  thread init_groundwarvehicles();
  level thread scripts\mp\spawnselection::updatefobindanger();
  scripts\mp\utility\dialog::initstatusdialog();
  emergency_cleanupents();
  scripts\cp_mp\parachute::initparachutedvars();

  if(getdvarint(@ "scr_br_armory_kiosk", 0) == 1) {
    level thread namespace_885300a47c2b51e6::function_ca39a413ace3c168();
    level thread scripts\mp\ai_heli_reinforce::function_d0ffcd08e0870cf2();
    scripts\mp\gametypes\br_armory_kiosk::function_b38f5ffe645943c3("gw_basic");
    level thread function_1629419647b0f862();
  }

  if(level.br_plunder_enabled && getdvarint(@ "hash_cdbbb44046b62549", 1) == 1) {
    level thread function_5a1699b27399a21e();
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.bombtimer = dvarintvalue("bombtimer", 45, 1, 300);
  level.planttime = dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = dvarfloatvalue("defusetime", 5, 0, 20);
  level.resetprogress = dvarintvalue("resetProgress", 1, 0, 1);
  level.var_a09dce2c531d0bab = dvarintvalue("allowPlantedSites", 1, 0, 1);
  level.var_47e84d3946482b9f = dvarintvalue("gainPlantedSites", 0, 0, 1);
  level.var_85faaaced1b1d39c = dvarintvalue("loseDestroyedSites", 1, 0, 1);
  level.var_3b3a02f94873e48a = dvarintvalue("gainDestroyedSites", 0, 0, 1);
  level.pausescoring = dvarintvalue("pauseTime", 1, 0, 1);
  level.spawndelay = dvarfloatvalue("spawnDelay", 5, 0, 30);
  level.flagcapturetime = dvarfloatvalue("flagCaptureTime", 30, 0, 30);
  level.flagsrequiredtoscore = dvarintvalue("flagsRequiredToScore", 1, 1, 3);
  level.pointsperflag = dvarintvalue("pointsPerFlag", 1, 1, 300);
  level.flagneutralization = dvarintvalue("flagNeutralization", 0, 0, 1);
  level.precappoints = dvarintvalue("preCapPoints", 0, 0, 1);
  level.capturedecay = dvarintvalue("captureDecay", 1, 0, 1);
  level.capturetype = dvarintvalue("captureType", 1, 0, 3);
  level.numflagsscoreonkill = dvarintvalue("numFlagsScoreOnKill", 0, 0, 3);
  level.objectivescaler = dvarfloatvalue("objScalar", 4, 1, 10);
}

function seticonnames() {}

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

function debug_setupmatchdata() {
  level.var_6121d66ffc5b8ec9 = [];
  level.var_6121d66ffc5b8ec9["axis"] = "gw_fob_axisHQ";
  level.var_6121d66ffc5b8ec9["allies"] = "gw_fob_alliesHQ";
  level.startingfobnames_axis = ["_a", "_b", "_c"];
  level.startingfobnames_allies = ["_d", "_e", "_f"];
  level.startingfobnames_neutral = [];
}

function setupwaypointicons() {
  while(!isDefined(game["killstreakTable"])) {
    waitframe();
  }

  foreach(var_dfbd7318ef3cc9bd, data in game["killstreakTable"].tabledatabyref) {
    level.waypointcolors[var_dfbd7318ef3cc9bd + "_incoming"] = "neutral";
    level.waypointbgtype[var_dfbd7318ef3cc9bd + "_incoming"] = 1;
    level.waypointstring[var_dfbd7318ef3cc9bd + "_incoming"] = "";
    level.waypointshader[var_dfbd7318ef3cc9bd + "_incoming"] = data.hudicon;
    level.waypointpulses[var_dfbd7318ef3cc9bd + "_incoming"] = 0;
    level.waypointcolors[var_dfbd7318ef3cc9bd] = "neutral";
    level.waypointbgtype[var_dfbd7318ef3cc9bd] = 1;
    level.waypointstring[var_dfbd7318ef3cc9bd] = "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS";
    level.waypointshader[var_dfbd7318ef3cc9bd] = data.hudicon;
  }
}

function setuphqs() {
  level.gw_objstruct = spawnStruct();
  level.gw_objstruct.axishqloc = spawnStruct();
  level.gw_objstruct.axishqloc.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(level.var_6121d66ffc5b8ec9["axis"]);

  if(!isDefined(level.gw_objstruct.axishqloc)) {
    assert(0, "<dev string:x1c>");
  }

  level.gw_objstruct.allieshqloc = spawnStruct();
  level.gw_objstruct.allieshqloc.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(level.var_6121d66ffc5b8ec9["allies"]);

  if(!isDefined(level.gw_objstruct.allieshqloc)) {
    assert(0, "<dev string:x40>");
  }
}

function setupobjectives() {
  level.gw_objstruct.startingfobs_allies = [];
  level.gw_objstruct.startingfobs_axis = [];
  level.gw_objstruct.startingfobs_neutral = [];
  bombzones = getEntArray("gwbombzone", "targetname");

  foreach(var_d83e5fa8f6ce891f in level.startingfobnames_allies) {
    foreach(bomb in bombzones) {
      if(bomb.script_label == var_d83e5fa8f6ce891f) {
        trigger = bomb;

        if(isDefined(trigger)) {
          fob = spawnStruct();
          fob.name = var_d83e5fa8f6ce891f;
          fob.trigger = trigger;
          fob.trigger.objkey = var_d83e5fa8f6ce891f;
          level.gw_objstruct.startingfobs_allies[level.gw_objstruct.startingfobs_allies.size] = fob;
        }
      }
    }
  }

  foreach(var_d83e5fa8f6ce891f in level.startingfobnames_axis) {
    foreach(bomb in bombzones) {
      if(bomb.script_label == var_d83e5fa8f6ce891f) {
        trigger = bomb;

        if(isDefined(trigger)) {
          fob = spawnStruct();
          fob.name = var_d83e5fa8f6ce891f;
          fob.trigger = trigger;
          fob.trigger.objkey = var_d83e5fa8f6ce891f;
          level.gw_objstruct.startingfobs_axis[level.gw_objstruct.startingfobs_axis.size] = fob;
        }
      }
    }
  }

  foreach(var_d83e5fa8f6ce891f in level.startingfobnames_neutral) {
    foreach(bomb in bombzones) {
      if(bomb.script_label == var_d83e5fa8f6ce891f) {
        trigger = bomb;

        if(isDefined(trigger)) {
          fob = spawnStruct();
          fob.name = var_d83e5fa8f6ce891f;
          fob.trigger = trigger;
          fob.trigger.objkey = var_d83e5fa8f6ce891f;
          level.gw_objstruct.startingfobs_neutral[level.gw_objstruct.startingfobs_neutral.size] = fob;
        }
      }
    }
  }

  level.objectivessetup = 1;
}

function updatedomscores() {
  level endon("game_ended");
  teamscore = undefined;
  otherteamscore = undefined;
  level waittill("prematch_done");
  level thread scripts\mp\spawnselection::updatefobindanger();

  while(!level.gameended) {
    wait 10;
    scripts\mp\hostmigration::waittillhostmigrationdone();
    domflags = getowneddomflags();

    if(!isDefined(level.scoretick)) {
      level.scoretick = [];
    }

    foreach(entry in level.teamnamelist) {
      level.scoretick[entry] = 0;
    }

    if(domflags.size) {
      for(i = 1; i < domflags.size; i++) {
        domflag = domflags[i];
        flagscore = gettime() - domflag.capturetime;

        for(j = i - 1; j >= 0 && flagscore > gettime() - domflags[j].capturetime; j--) {
          domflags[j + 1] = domflags[j];
        }

        domflags[j + 1] = domflag;
      }

      foreach(domflag in domflags) {
        team = domflag scripts\mp\gameobjects::getownerteam();
        assert(isgameplayteam(team));
        teamscore = getteamscore(team);
        var_fee716687dd29378 = scripts\mp\gametypes\obj_dom::getteamflagcount(team);

        if(var_fee716687dd29378 >= level.flagsrequiredtoscore) {
          level.scoretick[team] += level.pointsperflag;
        }
      }
    }

    updatescores();
  }
}

function updatescores() {
  teamshitscorelimit = [];

  foreach(entry in level.teamnamelist) {
    targetscore = game["teamScores"][entry] + level.scoretick[entry];

    if(targetscore >= level.roundscorelimit) {
      teamshitscorelimit[teamshitscorelimit.size] = entry;
    }
  }

  if(teamshitscorelimit.size == 1) {
    level.scoretick[teamshitscorelimit[0]] = level.roundscorelimit - game["teamScores"][teamshitscorelimit[0]];
  }

  var_e80dc2f88d61c61c = scripts\mp\gamescore::calculatewinningteam();

  foreach(entry in level.teamnamelist) {
    if(level.scoretick[entry] > 0) {
      scripts\mp\gamescore::giveteamscoreforobjective(entry, level.scoretick[entry], 1, undefined, 1);
    }
  }

  var_3397acf8985dbd01 = scripts\mp\gamescore::calculatewinningteam();

  if(var_e80dc2f88d61c61c != var_3397acf8985dbd01) {
    scripts\mp\gamescore::playscorestatusdialog(var_3397acf8985dbd01, 1, var_e80dc2f88d61c61c);
  }
}

function runobjectives(numobjs) {
  while(!istrue(level.objectivessetup)) {
    waitframe();
  }

  level.spawnareas = [];
  level.var_694388259afb589b = [];

  foreach(entry in level.teamnamelist) {
    level.spawnareas[entry] = [level.var_6121d66ffc5b8ec9[entry]];
    level.var_694388259afb589b[entry] = [];
  }

  level.allfobs = [];

  if(istrue(level.useobjectives)) {
    foreach(fob in level.gw_objstruct.startingfobs_axis) {
      var_ddca7869b65236b6 = function_a3d78465df2753f3(fob.trigger, "axis");
      level.allfobs[level.allfobs.size] = fob;
      level.spawnareas["axis"][level.spawnareas["axis"].size] = fob.name;
      level.var_694388259afb589b["axis"][level.var_694388259afb589b["axis"].size] = fob.name;
      level.var_694388259afb589b["allies"][level.var_694388259afb589b["allies"].size] = fob.name;
    }

    foreach(fob in level.gw_objstruct.startingfobs_allies) {
      var_ddca7869b65236b6 = function_a3d78465df2753f3(fob.trigger, "allies");
      level.allfobs[level.allfobs.size] = fob;
      level.spawnareas["allies"][level.spawnareas["allies"].size] = fob.name;
      level.var_694388259afb589b["allies"][level.var_694388259afb589b["allies"].size] = fob.name;
      level.var_694388259afb589b["axis"][level.var_694388259afb589b["axis"].size] = fob.name;
    }

    foreach(fob in level.gw_objstruct.startingfobs_neutral) {
      var_ddca7869b65236b6 = function_a3d78465df2753f3(fob.trigger, "neutral");
      level.allfobs[level.allfobs.size] = fob;
      level.var_694388259afb589b["axis"][level.var_694388259afb589b["axis"].size] = fob.name;
      level.var_694388259afb589b["allies"][level.var_694388259afb589b["allies"].size] = fob.name;
    }

    foreach(fob in level.allfobs) {
      if(istrue(level.var_dd7af80c3eb2c1e0)) {
        fob.var_5261f4479b04f834 = &scripts\mp\gametypes\obj_dom::function_5261f4479b04f834;
      }

      level.objectives[fob.trigger.gameobject.objectivekey] = fob.trigger.gameobject;

      if(isDefined(level.spawnselectionlocations[fob.name]["allies"])) {
        level.spawnselectionlocations[fob.name]["allies"].objectivekey = fob.trigger.gameobject.objectivekey;
      }

      if(isDefined(level.spawnselectionlocations[fob.name]["axis"])) {
        level.spawnselectionlocations[fob.name]["axis"].objectivekey = fob.trigger.gameobject.objectivekey;
      }

      if(isDefined(level.spawnselectionlocations[fob.name]["allies"].anchorentity)) {
        level.spawnselectionlocations[fob.name]["allies"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
      }

      if(isDefined(level.spawnselectionlocations[fob.name]["axis"].anchorentity)) {
        level.spawnselectionlocations[fob.name]["axis"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
      }
    }
  }

  level.var_6453d74d269b087e = getdvarint(@ "hash_15bed23553aa71e4", 1) == 1;

  if(level.var_6453d74d269b087e) {
    level.var_306b010a8a081a57 = getdvarint(@ "hash_9cb1c06efe33ebf1", 1) == 1;
    allies = [];
    axis = [];
    allies[0] = strtok(getDvar(@ "hash_4eefa769cd185940", "_d"), " ");
    axis[0] = strtok(getDvar(@ "hash_c40b0e26158d885b", "_c"), " ");
    allies[1] = strtok(getDvar(@ "hash_6acf684caf26d595", "_e _f"), " ");
    axis[1] = strtok(getDvar(@ "hash_acad4dd64982c63a", "_a _b"), " ");
    allies[2] = strtok(getDvar(@ "hash_42aaefc5b1e75dee", ""), " ");
    axis[2] = strtok(getDvar(@ "hash_247b839a052b5299", ""), " ");
    level.var_60422b96dc1c7a05 = [];
    level.var_60422b96dc1c7a05["allies"] = allies;
    level.var_60422b96dc1c7a05["axis"] = axis;
    level.var_26f4462ae3073abc = [];
    level.var_26f4462ae3073abc["allies"] = 0;
    level.var_26f4462ae3073abc["axis"] = 0;

    foreach(objective in level.objectives) {
      if(!array_contains(level.var_60422b96dc1c7a05[objective.ownerteam][0], objective.objectivekey)) {
        objective.inactive = 1;
        objective scripts\mp\gameobjects::setobjectivestatusicons("waypoint_locked", "waypoint_locked");
        objective scripts\mp\gameobjects::allowuse("none");

        if(level.var_306b010a8a081a57) {
          objective scripts\mp\gameobjects::setvisibleteam("friendly");
        }

        if(istrue(level.var_b307135dbcef5a38)) {
          otherteam = getenemyteams(objective.ownerteam)[0];
          level.var_694388259afb589b[otherteam] = array_remove(level.var_694388259afb589b[otherteam], objective.objectivekey);
        }
      }
    }
  }

  if(level.usespawnselection) {
    if(istrue(level.var_b307135dbcef5a38)) {
      scripts\mp\spawnselection::setspawnlocations(level.var_694388259afb589b["axis"], "axis");
      scripts\mp\spawnselection::setspawnlocations(level.var_694388259afb589b["allies"], "allies");
    } else {
      scripts\mp\spawnselection::setspawnlocations(level.spawnareas["axis"], "axis");
      scripts\mp\spawnselection::setspawnlocations(level.spawnareas["allies"], "allies");
    }

    sethqmarkerobjective();

    while(!isDefined(level.spawnselectionlocations)) {
      waitframe();
    }

    waitframe();

    if(isDefined(level.spawnselectionlocations[level.var_6121d66ffc5b8ec9["axis"]]["axis"].anchorentity)) {
      level.spawnselectionlocations[level.var_6121d66ffc5b8ec9["axis"]]["axis"].anchorentity.origin = level.gw_objstruct.axishqloc.trigger.origin;
    }

    if(isDefined(level.spawnselectionlocations[level.var_6121d66ffc5b8ec9["allies"]]["allies"].anchorentity)) {
      level.spawnselectionlocations[level.var_6121d66ffc5b8ec9["allies"]]["allies"].anchorentity.origin = level.gw_objstruct.allieshqloc.trigger.origin;
    }
  }

  level thread objective_manageobjectivesintrovisibility();
  hackfixcameras();
  level thread allowobjectiveuseaftermatchstart();
}

function allowobjectiveuseaftermatchstart() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(fob in level.allfobs) {
    if(istrue(fob.trigger.gameobject.inactive)) {
      continue;
    }

    fob.trigger.gameobject scripts\mp\gameobjects::allowuse("enemy");
  }
}

function objective_manageobjectivesintrovisibility() {
  wait 1;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.enemymarker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.enemymarker.objidnum);

  foreach(fob in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(fob.trigger.gameobject.objidnum);
  }

  if(isDefined(level.rallypointvehicles)) {
    foreach(rallypoint in level.rallypointvehicles) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(rallypoint.marker.objidnum);
    }
  }

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.axishqloc.marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.allieshqloc.marker.objidnum, "allies");

  foreach(fob in level.allfobs) {
    if(istrue(level.var_306b010a8a081a57) && istrue(fob.trigger.gameobject.inactive)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(fob.trigger.gameobject.objidnum, fob.trigger.gameobject.ownerteam);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_showtoall(fob.trigger.gameobject.objidnum);
  }

  if(isDefined(level.rallypointvehicles)) {
    foreach(rallypoint in level.rallypointvehicles) {
      if(isDefined(rallypoint)) {
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(rallypoint.marker.objidnum, rallypoint.team);
      }
    }
  }
}

function hackfixcameras() {
  if(istrue(level.usestaticspawnselectioncamera)) {
    return;
  }

  while(!istrue(level.var_1091b5d43ba7a905)) {
    waitframe();
  }

  team = "allies";
  forward = level.spawnselectionteamforward[team];

  if(istrue(level.var_b307135dbcef5a38)) {
    keys = ["gw_fob_alliesHQ", "_a", "_b", "_c", "_d", "_e", "_f"];
  } else {
    keys = ["gw_fob_alliesHQ", "_d", "_e", "_f"];
  }

  scripts\mp\spawncamera::function_71a2a6a6f52ab30b(keys, team, forward, -8500, 7000);
  team = "axis";
  forward = level.spawnselectionteamforward[team];

  if(istrue(level.var_b307135dbcef5a38)) {
    keys = ["gw_fob_axisHQ", "_a", "_b", "_c", "_d", "_e", "_f"];
  } else {
    keys = ["gw_fob_axisHQ", "_a", "_b", "_c"];
  }

  scripts\mp\spawncamera::function_71a2a6a6f52ab30b(keys, team, forward, -8500, 7000);
}

function updatefobspawnselection() {
  level.spawnareas = [];

  foreach(entry in level.teamnamelist) {
    level.spawnareas[entry] = [level.var_6121d66ffc5b8ec9[entry]];
  }

  foreach(fob in level.allfobs) {
    gameobject = fob.trigger.gameobject;

    if(gameobject.ownerteam == "axis") {
      level.spawnareas["axis"][level.spawnareas["axis"].size] = fob.name;

      if(isDefined(level.spawnselectionlocations[fob.name]["axis"].anchorentity)) {
        level.spawnselectionlocations[fob.name]["axis"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
      }

      continue;
    }

    if(gameobject.ownerteam == "allies") {
      level.spawnareas["allies"][level.spawnareas["allies"].size] = fob.name;

      if(isDefined(level.spawnselectionlocations[fob.name]["allies"].anchorentity)) {
        level.spawnselectionlocations[fob.name]["allies"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
      }
    }
  }

  if(istrue(level.var_b307135dbcef5a38)) {
    scripts\mp\spawnselection::setspawnlocations(level.var_694388259afb589b["axis"], "axis");
    scripts\mp\spawnselection::setspawnlocations(level.var_694388259afb589b["allies"], "allies");
    return;
  }

  scripts\mp\spawnselection::setspawnlocations(level.spawnareas["axis"], "axis");
  scripts\mp\spawnselection::setspawnlocations(level.spawnareas["allies"], "allies");
}

function sethqmarkerobjective() {
  visibility = "any";
  origin = level.gw_objstruct.axishqloc.trigger.origin;
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, visibility, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 6);
  marker.lockupdatingicons = 1;
  level.gw_objstruct.axishqloc.marker = marker;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = marker;
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, visibility, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 7);
  marker.lockupdatingicons = 1;
  level.gw_objstruct.axishqloc.enemymarker = marker;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = marker;
  origin = level.gw_objstruct.allieshqloc.trigger.origin;
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, visibility, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 6);
  marker.lockupdatingicons = 1;
  level.gw_objstruct.allieshqloc.marker = marker;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = marker;
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, visibility, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 7);
  marker.lockupdatingicons = 1;
  level.gw_objstruct.allieshqloc.enemymarker = marker;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = marker;
  level.spawnselectionteamforward = [];
  level.spawnselectionteamforward["allies"] = vectorNormalize(level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin);
  level.spawnselectionteamforward["axis"] = vectorNormalize(level.gw_objstruct.allieshqloc.trigger.origin - level.gw_objstruct.axishqloc.trigger.origin);
}

function objective_oncontested() {
  scripts\mp\gametypes\obj_dom::dompoint_oncontested();

  if(!istrue(self.updatedoncontestedspawnselection)) {
    updatefobspawnselection();
    self.updatedoncontestedspawnselection = 1;
  }
}

function objective_onuncontested(lastclaimteam) {
  scripts\mp\gametypes\obj_dom::dompoint_onuncontested(lastclaimteam);

  if(istrue(self.updatedoncontestedspawnselection)) {
    updatefobspawnselection();
    self.updatedoncontestedspawnselection = 0;
  }
}

function objective_onusebegin(player) {
  scripts\mp\gametypes\obj_dom::dompoint_onusebegin(player);
  updatefobspawnselection();
}

function objective_onuseend(team, player, success) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(team, player, success);
  updatefobspawnselection();
}

function objective_onuse(claim_player) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(claim_player);
  updatefobspawnselection();
  otherteam = getotherteam(claim_player.team)[0];
  function_666a2979def5d705(otherteam, self.objectivekey);
  function_8d03978a31faba3a(self.objectivekey, otherteam);
  function_e8a6e840ef663c81(self.objectivekey, self.ownerteam);
}

function objective_onpinnedstate(player) {
  updatefobspawnselection();
  scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate(player);
}

function objective_onunpinnedstate(player) {
  updatefobspawnselection();
  scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate(player);
}

function runobjflag(objective, startingteam) {
  level endon("game_ended");

  while(!isDefined(level.spawnselectionlocations)) {
    waitframe();
  }

  objective.script_label = objective.objkey;
  domflag = scripts\mp\gametypes\obj_dom::setupobjective(objective, undefined, undefined, undefined, 0);
  domflag.origin = objective.origin;
  domflag scripts\mp\gameobjects::allowuse("none");
  domflag.didstatusnotify = 0;
  domflag scripts\mp\gameobjects::setownerteam(startingteam);
  visibility = "any";

  if(startingteam != "neutral") {
    if(level.hideenemyfobs) {
      visibility = "friendly";
    }

    domflag.capturetime = gettime();
  }

  domflag scripts\mp\gameobjects::setvisibleteam(visibility);
  return domflag;
}

function function_a3d78465df2753f3(objective, ownerteam) {
  level endon("game_ended");

  while(!isDefined(level.spawnselectionlocations)) {
    waitframe();
  }

  objective.script_label = objective.objkey;
  bombzone = scripts\mp\gametypes\obj_bombzone::setupobjective(objective);

  if(isDefined(bombzone)) {
    bombzone.onbeginuse = &onbeginuse;
    bombzone.onenduse = &onenduse;
    bombzone.onuse = &onuseplantobject;
    bombzone scripts\mp\gameobjects::setownerteam(ownerteam);
    bombzone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    bombzone scripts\mp\gameobjects::setvisibleteam("any");
  }

  return bombzone;
}

function onbeginuse(player) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onbeginuse(player);
}

function onenduse(team, player, result) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onenduse(team, player, result);
}

function onuseplantobject(player) {
  skipplayers = [];
  skipplayers[skipplayers.size] = player;
  level thread scripts\mp\hud_message::notifyteam("emp_planted", "emp_planted_enemy", player.team, skipplayers);
  player thread scripts\mp\hud_message::showsplash("emp_planted", scripts\mp\rank::getscoreinfovalue(#"plant"));
  scripts\mp\gametypes\obj_bombzone::bombzone_onuseplantobject(player);

  if(level.var_47e84d3946482b9f) {
    if(!istrue(level.var_b307135dbcef5a38)) {
      level.spawnareas[player.team][level.spawnareas[player.team].size] = self.objectivekey;
      scripts\mp\spawnselection::setspawnlocations(level.spawnareas[player.team], player.team);
    }
  }
}

function function_c0e928deb12cfa4f(bombzone) {
  otherteam = getotherteam(bombzone.ownerteam)[0];
  scripts\mp\gamescore::giveteamscoreforobjective(otherteam, 1, 0, undefined, 1);
  bombzone.id = "destroyed_site";
  otherteamscore = getteamscore(otherteam);

  if(otherteamscore == level.roundscorelimit - 1) {
    scripts\mp\utility\dialog::statusdialog("gwbomb_last_site_offense", otherteam, 1);
    scripts\mp\utility\dialog::statusdialog("gwbomb_last_site_defense", bombzone.ownerteam, 1);
    return;
  }

  scripts\mp\utility\dialog::statusdialog("enemy_site_destroyed" + bombzone.objectivekey, otherteam, 1);
  scripts\mp\utility\dialog::statusdialog("site_destroyed" + bombzone.objectivekey, bombzone.ownerteam, 1);
}

function onobjectivecomplete(objectivetype, objectivekey, credit_player, team, oldteam, obj) {
  otherteam = getotherteam(self.ownerteam)[0];

  if(self.id != "destroyed_site") {
    if(level.var_47e84d3946482b9f) {
      if(!istrue(level.var_b307135dbcef5a38)) {
        level.spawnareas[otherteam] = array_remove(level.spawnareas[otherteam], self.objectivekey);
        scripts\mp\spawnselection::setspawnlocations(level.spawnareas[otherteam], otherteam);
      }
    }

    return;
  }

  if(istrue(level.var_b307135dbcef5a38)) {
    level.var_694388259afb589b[self.ownerteam] = array_remove(level.spawnareas[self.ownerteam], self.objectivekey);
    scripts\mp\spawnselection::setspawnlocations(level.spawnareas[self.ownerteam], self.ownerteam);
    level.var_694388259afb589b[otherteam] = array_remove(level.spawnareas[otherteam], self.objectivekey);
    scripts\mp\spawnselection::setspawnlocations(level.spawnareas[otherteam], otherteam);
  }

  if(level.var_85faaaced1b1d39c) {
    if(!istrue(level.var_b307135dbcef5a38)) {
      level.spawnareas[self.ownerteam] = array_remove(level.spawnareas[self.ownerteam], self.objectivekey);
      scripts\mp\spawnselection::setspawnlocations(level.spawnareas[self.ownerteam], self.ownerteam);
    }
  }

  if(level.var_3b3a02f94873e48a) {
    if(!istrue(level.var_b307135dbcef5a38)) {
      level.spawnareas[otherteam][level.spawnareas[otherteam].size] = self.objectivekey;
      scripts\mp\spawnselection::setspawnlocations(level.spawnareas[otherteam], otherteam);
    }

    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    scripts\mp\gameobjects::setownerteam(otherteam);
    scripts\mp\gameobjects::setvisibleteam("friendly");
  } else if(level.var_47e84d3946482b9f) {
    if(!istrue(level.var_b307135dbcef5a38)) {
      level.spawnareas[otherteam] = array_remove(level.spawnareas[otherteam], self.objectivekey);
      scripts\mp\spawnselection::setspawnlocations(level.spawnareas[otherteam], otherteam);
    }
  }

  if(level.var_6453d74d269b087e) {
    canprogress = 1;

    foreach(key in level.var_60422b96dc1c7a05[self.ownerteam][level.var_26f4462ae3073abc[self.ownerteam]]) {
      if(level.objectives[key].id != "destroyed_site") {
        canprogress = 0;
        break;
      }
    }

    if(canprogress) {
      level.var_26f4462ae3073abc[self.ownerteam]++;

      foreach(key in level.var_60422b96dc1c7a05[self.ownerteam][level.var_26f4462ae3073abc[self.ownerteam]]) {
        objective = level.objectives[key];
        objective.inactive = 0;
        objective scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
        objective scripts\mp\gameobjects::setvisibleteam("any");
        objective scripts\mp\gameobjects::allowuse("enemy");

        if(istrue(level.var_b307135dbcef5a38)) {
          otherteam = getenemyteams(objective.ownerteam)[0];
          level.var_694388259afb589b[otherteam][level.var_694388259afb589b[otherteam].size] = key;
          scripts\mp\spawnselection::setspawnlocations(level.var_694388259afb589b[otherteam], otherteam);
        }
      }

      level thread function_570695099cdccb10(self.ownerteam, otherteam);
    }
  }
}

function function_570695099cdccb10(ownerteam, otherteam) {
  level endon("game_ended");
  wait 5;
  scripts\mp\utility\dialog::statusdialog("gwbomb_progress_defense", ownerteam, 1);
  scripts\mp\utility\dialog::statusdialog("gwbomb_progress_offense", otherteam, 1);
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

function choosenukecratelocation() {
  randx = randomfloatrange(level.mapsafecorners[1][0], level.mapsafecorners[0][0]);
  randy = randomfloatrange(level.mapsafecorners[1][1], level.mapsafecorners[0][1]);
  var_92459ae9b006b9f7 = (randx, randy, 100000);
  trace = ray_trace(var_92459ae9b006b9f7, var_92459ae9b006b9f7 - (0, 0, 100000));
  var_92459ae9b006b9f7 = trace["position"];
  var_794937a10118f0d9 = findclosestdroplocation(var_92459ae9b006b9f7);

  if(false) {
    thread drawsphere(var_92459ae9b006b9f7, 1000, 100, (1, 0, 0));
    thread drawsphere(var_794937a10118f0d9, 1000, 100, (0, 1, 0));
    thread drawline(var_92459ae9b006b9f7, var_794937a10118f0d9.origin, 3, (0, 1, 0));
  }

  return var_794937a10118f0d9;
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

function br_getrewardicon(streakname) {
  return level.killstreakglobals.streaktable.tabledatabyref[streakname].hudicon;
}

function nuke_mercyending_init() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(istrue(level.useobjectives)) {
    level thread nuke_mercyending_think();
  }
}

function nuke_mercyending_think() {
  level endon("game_ended");
  level endon("mercy_ending_timer_started");

  while(true) {
    if(calculateobjectivesheld("axis") == level.objectives.size) {
      level thread nuke_startmercycountdown("axis");
    } else if(calculateobjectivesheld("allies") == level.objectives.size) {
      level thread nuke_startmercycountdown("allies");
    }

    waitframe();
  }
}

function nuke_startmercycountdown(team) {
  level notify("mercy_ending_timer_started");
  level endon("mercy_ending_triggered");
  setomnvar("ui_nuke_timer_type", 1);
  setomnvar("ui_arm_dominatingTeam", ter_op(team == "axis", 1, 2));
  setomnvar("ui_nuke_timer_time", level.mercymatchending_time);
  setomnvar("ui_nuke_countdown_active", 1);
  var_d984aaafbb3f49e0 = 0;
  starttime = gettime();
  endtime = level.mercymatchending_time * 1000 + starttime;
  setomnvar("ui_nuke_end_milliseconds", level.mercymatchending_time * 1000 + starttime);

  while(calculateobjectivesheld(team) == level.objectives.size) {
    waitframe();

    if(gettime() > endtime) {
      nuke_triggermercywin(team);
      level notify("mercy_ending_triggered");
    }
  }

  setomnvar("ui_nuke_countdown_active", 0);
  level thread nuke_mercyending_think();
}

function nuke_triggermercywin(team) {
  level endon("game_ended");
  level.mercywintriggered = 1;
  level.blocknukekills = 1;

  foreach(objective in level.objectives) {
    objective scripts\mp\gameobjects::allowuse("none");
  }

  setomnvar("ui_nuke_countdown_active", 0);

  foreach(player in level.players) {
    if(isDefined(player) && !isbot(player) && istrue(player.inspawnselection)) {
      if(isDefined(player.operatorsfx)) {
        player clearsoundsubmix("iw8_mp_spawn_camera");
        player.operatorsfx stoploopsound(player.operatorsfxalias);
        player.operatorsfx delete();
        player.operatorsfx = undefined;
        player.operatorsfxalias = undefined;
      }
    }
  }

  if(isDefined(level.teamdata[team]["alivePlayers"][0])) {
    var_39e8f33513c716cd = level.teamdata[team]["alivePlayers"][0];
    var_39e8f33513c716cd scripts\cp_mp\killstreaks\nuke::tryusenuke();
    return;
  }

  level thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 0, 1);
}

function nukeselectgimmewatcher(killer) {
  if(!istrue(killer.hasnukeselectks)) {
    remainder = killer.killcountthislife % level.killstoearnnukeselect;

    if(remainder >= 0 && killer.killcountthislife >= level.killstoearnnukeselect) {
      killer.hasnukeselectks = 1;
      killer thread scripts\mp\killstreaks\killstreaks::givekillstreak("nuke_select_location", 0, 0);
      killer scripts\mp\hud_message::showkillstreaksplash("nuke_select_location", undefined, 1);
    }
  }
}

function initspawns(var_4c3936c2c179fab3) {
  level.gamemodestartspawnpointnames = [];

  if(istrue(var_4c3936c2c179fab3)) {
    var_48501209a3e177a7 = "mp_gw_spawn_allies_start";
    var_ae7d0107ad485428 = "mp_gw_spawn_axis_start";
    var_e77fe17f16335f61 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start_mod");

    if(var_e77fe17f16335f61.size > 0) {
      var_48501209a3e177a7 = "mp_gw_spawn_allies_start_mod";
    }

    var_202c2c36d99ada78 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start_mod");

    if(var_202c2c36d99ada78.size > 0) {
      var_ae7d0107ad485428 = "mp_gw_spawn_axis_start_mod";
    }
  } else {
    var_48501209a3e177a7 = "mp_gw_spawn_allies_start";
    var_ae7d0107ad485428 = "mp_gw_spawn_axis_start";
  }

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

  scripts\mp\spawnlogic::addstartspawnpoints(var_48501209a3e177a7);
  scripts\mp\spawnlogic::addstartspawnpoints(var_ae7d0107ad485428);
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], var_48501209a3e177a7);
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], var_ae7d0107ad485428);
  attackers = scripts\mp\spawnlogic::getspawnpointarray(var_48501209a3e177a7);
  defenders = scripts\mp\spawnlogic::getspawnpointarray(var_ae7d0107ad485428);
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
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.spawnpoints = spawns;
}

function getspawnpoint() {
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

function onspawnplayer(revivespawn) {
  self.forcespawnnearteammates = undefined;
  thread updatematchstatushintonspawn();
  scripts\cp_mp\cash::function_6da8b65579348d0b();
  scripts\cp_mp\squads::updatesquadomnvars(self.team, self.sessionsquadid);

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(self)) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 1;
    self setclientomnvar("ui_carrying_bomb", 0);
  }
}

function updatematchstatushintonspawn() {
  level endon("game_ended");

  if(isDefined(level.nukeprogress)) {
    scripts\mp\hud_message::function_f004ef4606b9efdc("nuke_capture");
    return;
  }

  scripts\mp\hud_message::function_f004ef4606b9efdc("dom_cap_defend");
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  scripts\cp_mp\squads::updatesquadomnvars(self.team, self.sessionsquadid);

  if(level.dropbrloot) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    dropstruct.dropidx = 14;
    scripts\mp\gametypes\br_pickups::dropbrhealthpack(dropstruct);
    scripts\mp\gametypes\br_plunder::playerdropplunderondeath(dropstruct, attacker, 1);
  }

  if(level.nukeselectactive && isPlayer(attacker) && smeansofdeath != "MOD_SUICIDE") {
    if(!isDefined(attacker.killcountthislife)) {
      attacker.killcountthislife = 0;
    }

    if(!istrue(attacker.hasnukeselectks)) {
      attacker.killcountthislife++;
    }

    nukeselectgimmewatcher(attacker);
  }

  if(!isDefined(level.c130pathkilltracker) || level.c130movementmethod != 1) {
    return;
  }

  level.c130pathkilltracker[self.team] += 1;
}

function managedroppedents(droppedents) {
  if(!isDefined(level.br_droppedloot)) {
    level.br_droppedloot = [];
  }

  if(level.br_droppedloot.size > 64) {
    for(i = 0; i < 16; i++) {
      if(isDefined(level.br_droppedloot[i])) {
        level.br_droppedloot[i] delete();
        level.br_droppedloot[i] = undefined;
      }
    }

    temparray = [];

    for(i = 16; i < level.br_droppedloot.size; i++) {
      temparray[i - 16] = level.br_droppedloot[i];
    }

    level.br_droppedloot = temparray;
  }

  foreach(ent in droppedents) {
    level.br_droppedloot[level.br_droppedloot.size] = ent;
  }

  if(!isDefined(level.br_pickups.droppeditems)) {
    level.br_pickups.droppeditems = [];
  }

  if(level.br_pickups.droppeditems.size > 64) {
    for(i = 0; i < 16; i++) {
      if(isDefined(level.br_pickups.droppeditems[i])) {
        level.br_pickups.droppeditems[i] delete();
        level.br_pickups.droppeditems[i] = undefined;
      }
    }

    temparray = [];

    for(i = 16; i < level.br_pickups.droppeditems.size; i++) {
      temparray[i - 16] = level.br_pickups.droppeditems[i];
    }

    level.br_pickups.droppeditems = temparray;
  }
}

function onplayerconnect(player) {
  if(isDefined(level.rallypointvehicles)) {
    thread scripts\mp\rally_point::rallypoint_showtoplayer(player);
  }

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
}

function onplayerdisconnect(player) {}

function updategamemodespawncamera() {
  activezonename = "lane02_4";

  if(isDefined(level.activezone)) {
    activezonename = level.activezone.zonetrigger.script_label;
  }

  scripts\mp\spawncamera::setgamemodecamera("allies", level.spawncameras[activezonename]["allies"]);
  scripts\mp\spawncamera::setgamemodecamera("axis", level.spawncameras[activezonename]["axis"]);
}

function debugdrawtocameras() {
  while(true) {
    wait 0.25;

    if(!isDefined(level.players[0])) {
      continue;
    }

    foreach(teamarray in level.spawncameras) {
      foreach(team, camera in teamarray) {
        thread drawangles(camera.origin, camera.angles, 0.25, 50);
        thread drawsphere(camera.origin, 50, 0.25, ter_op(team == "allies", (0, 0, 1), (1, 0, 0)));
      }
    }
  }
}

function onplayerspawned(player) {
  while(true) {
    player waittill("spawned");
  }
}

function getownerteamplayer(ownerteam) {
  ownerplayer = undefined;

  foreach(player in level.players) {
    if(player.team == ownerteam) {
      ownerplayer = player;
      break;
    }
  }

  return ownerplayer;
}

function getrespawndelay() {
  self.spawncameraskipthermal = 0;
  return undefined;
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  scripts\mp\gametypes\common::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

function initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "cop_2";
  var_84286554864313cb = getStructArray("tac_ops_map_config", "targetname");

  foreach(var_48380029fbb1007a in var_84286554864313cb) {
    var_ca2c833762e5466c = var_48380029fbb1007a.script_noteworthy;
    childstructs = getStructArray(var_48380029fbb1007a.target, "targetname");

    foreach(childstruct in childstructs) {
      switch (childstruct.script_label) {
        case #"hash_11e1630c6c429f23":
          setteammapposition(var_ca2c833762e5466c, "allies", childstruct);
          break;
        case #"hash_e66f1db565904926":
          setteammapposition(var_ca2c833762e5466c, "axis", childstruct);
          break;
      }
    }
  }
}

function setteammapposition(var_ca2c833762e5466c, team, posinfo) {
  if(!isDefined(level.spectatorcameras[var_ca2c833762e5466c])) {
    level.spectatorcameras[var_ca2c833762e5466c] = [];
  }

  level.spectatorcameras[var_ca2c833762e5466c][team] = posinfo;
}

function applythermal() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self thermalvisionon();
}

function removethermal() {
  self thermalvisionoff();
}

function startspectatorview() {
  if(isteamreviveenabled()) {
    return;
  }

  waitframe();
  updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles)) {
    self setplayerangles(self.lastdeathangles);
  }

  wait 0.1;
  setdof_default();
  var_26ee0f3f89450d97 = 0;
  bestflag = undefined;
  camorigin = (0, 0, 0);
  zoffset = 1000;
  var_dead2082432cecc = self.origin + (0, 0, zoffset);
  var_6788dc28320974a = self.angles;
  self.deathspectatepos = var_dead2082432cecc;
  self.deathspectateangles = var_6788dc28320974a;
  cameraent = spawn("script_model", self getvieworigin());
  cameraent setModel("tag_origin");
  cameraent.angles = var_6788dc28320974a;
  self.spectatorcament = cameraent;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(cameraent, "tag_origin", 1);
  thread dohalfwayflash();
  cameraent movecameratomappos(self, var_dead2082432cecc, var_6788dc28320974a);
}

function dohalfwayflash() {
  wait 0.4;
  thread playslamzoomflash();
  applythermal();
}

function endspectatorview() {
  if(!isDefined(self.spectatorcament)) {
    return;
  }

  removethermal();
  thread runslamzoomonspawn();
}

function movecameratomappos(player, var_9813182985677b23, finalangles) {
  player endon("spawned_player");
  movetime = 1;
  rotatetime = 1;
  self moveTo(var_9813182985677b23, 2, 1, 1);
  player playlocalsound("mp_cmd_camera_zoom_out");
  player setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(finalangles, 2, 1, 1);
  wait 1.1;
  var_ae753108f3dff053 = anglesToForward(finalangles) * 300;
  var_ae753108f3dff053 *= (1, 1, 0);

  if(isDefined(player) && isDefined(player.spectatorcament)) {
    self moveTo(var_9813182985677b23 + var_ae753108f3dff053, 15, 1, 1);
    player earthquakeforplayer(0.03, 15, var_9813182985677b23 + var_ae753108f3dff053, 1000);
  }
}

function runslamzoomonspawn() {
  self waittill("spawned_player");
  targetpos = self getEye();
  targetangles = self.angles;
  updatesessionstate("spectator");
  self cameralinkTo(self.spectatorcament, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self.spectatorcament moveTo(targetpos, 0.5);
  self playlocalsound("mp_cmd_camera_zoom_in");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(targetangles, 0.5, 0.5);
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }

  self visionsetnakedforplayer("", 0);
  thread playslamzoomflash();
  updatesessionstate("playing");
  self cameraunlink();
  self.spectatorcament delete();
}

function playslamzoomflash() {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 1;
  overlay.foreground = 1;
  overlay setshader("white", 640, 480);
  overlay fadeovertime(0.4);
  overlay.alpha = 0;
  wait 0.4;
  overlay destroy();
}

function arm_playstatusdialog(soundname, team) {
  soundalias = "dx_mpa_ustl_" + soundname;
  soundalias = tolower(soundalias);
  players = undefined;

  if(team == "bothTeams") {
    axisplayers = getteamdata("axis", "players");
    alliesplayers = getteamdata("allies", "players");
    players = array_combine(axisplayers, alliesplayers);
  } else if(team == "axis" || team == "allies") {
    players = getteamdata(team, "players");
  }

  foreach(player in players) {
    if(!isbot(player)) {
      player arm_leaderdialogonplayer_internal(soundalias, soundname);
    }
  }
}

function arm_playstatusdialogonplayer(soundname) {
  soundalias = "dx_mpa_ustl_announcer_" + soundname;
  soundalias = tolower(soundalias);
  arm_leaderdialogonplayer_internal(soundalias, soundname);
}

function arm_leaderdialogonplayer_internal(soundalias, dialog) {
  if(isDefined(self.playerlastdialogstatus)) {
    time = 5000;

    if(gettime() < self.playerlastdialogstatus["time"] + time && self.playerlastdialogstatus["dialog"] == dialog) {
      return;
    }

    self.playerlastdialogstatus["time"] = gettime();
    self.playerlastdialogstatus["dialog"] = dialog;
  }

  if(soundexists(soundalias)) {
    self queuedialogforplayer(soundalias, dialog, 2);
  }
}

function arm_initoutofbounds() {
  level.outofboundstriggers = [];
  potentialoobtriggers = getEntArray("OutOfBounds", "targetname");

  foreach(trigger in potentialoobtriggers) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == level.localeid && scripts\mp\utility\game_utility_mp::modeusesgroundwarteamoobtriggers(trigger)) {
      level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
      continue;
    }

    trigger delete();
  }
}

function debugprint(text) {
  if(false) {
    println(text);
  }
}

function isobjectivecontested(gameobject) {
  if(gameobject.ownerteam == "axis") {
    return (gameobject.numtouching["allies"] > 0);
  }

  if(gameobject.ownerteam == "allies") {
    return (gameobject.numtouching["axis"] > 0);
  }
}

function calculateobjectivesheld(team) {
  var_ae82e8f18ca8e0fe = 0;

  foreach(objective in level.objectives) {
    if(objective.ownerteam == team) {
      var_ae82e8f18ca8e0fe++;
    }
  }

  return var_ae82e8f18ca8e0fe;
}

function createhintobject(org, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, useent) {
  hintobj = undefined;

  if(isDefined(useent)) {
    hintobj = useent;
  } else {
    hintobj = spawn("script_model", org);
  }

  hintobj makeusable();

  if(isDefined(useent) && isDefined(org)) {
    assertex(isstring(org), "<dev string:x66>");
    hintobj sethinttag(org);
  }

  if(isDefined(type)) {
    hintobj setCursorHint(type);
  } else {
    hintobj setCursorHint("HINT_NOICON");
  }

  if(isDefined(icon)) {
    hintobj sethinticon(icon);
  }

  if(isDefined(hintstring)) {
    hintobj setHintString(hintstring);
  }

  if(isDefined(priority)) {
    hintobj setusepriority(priority);
  } else {
    hintobj setusepriority(0);
  }

  if(isDefined(duration)) {
    hintobj setuseholdduration(duration);
  } else {
    hintobj setuseholdduration("duration_short");
  }

  if(isDefined(onobstruction)) {
    hintobj sethintonobstruction(onobstruction);
  } else {
    hintobj sethintonobstruction("hide");
  }

  if(isDefined(hintdist)) {
    hintobj sethintdisplayrange(hintdist);
  } else {
    hintobj sethintdisplayrange(200);
  }

  if(isDefined(hintfov)) {
    hintobj sethintdisplayfov(hintfov);
  } else {
    hintobj sethintdisplayfov(160);
  }

  if(isDefined(usedist)) {
    hintobj setuserange(usedist);
  } else {
    hintobj setuserange(50);
  }

  if(isDefined(usefov)) {
    hintobj setusefov(usefov);
  } else {
    hintobj setusefov(120);
  }

  if(!isDefined(useent)) {
    return hintobj;
  }
}

function function_9c513c5e546a4f52() {
  setdevdvar(@ "hash_24d9f7f9324e9c61", 0);

  while(true) {
    if(getDvar(@ "hash_24d9f7f9324e9c61") != "<dev string:xc6>") {
      if(isDefined(level.lane_1_obj_struct)) {
        foreach(cluster in level.lane_1_obj_struct.clustertriggers) {
          foreach(objective in cluster.domobjectives) {
            thread drawsphere(objective.origin, 20, 1, (1, 1, 1));
          }
        }
      }

      if(isDefined(level.lane_2_obj_struct)) {
        foreach(cluster in level.lane_2_obj_struct.clustertriggers) {
          foreach(objective in cluster.domobjectives) {
            thread drawsphere(objective.origin, 20, 1, (1, 1, 1));
          }
        }
      }

      if(isDefined(level.lane_3_obj_struct)) {
        foreach(cluster in level.lane_3_obj_struct.clustertriggers) {
          foreach(objective in cluster.domobjectives) {
            thread drawsphere(objective.origin, 20, 1, (1, 1, 1));
          }
        }
      }

      if(isDefined(level.tdmzones["<dev string:xcb>"])) {
        foreach(objective in level.tdmzones["<dev string:xcb>"]) {
          thread drawsphere(objective.origin, 20, 1, (1, 1, 1));
        }
      }

      if(isDefined(level.tdmzones["<dev string:xd1>"])) {
        foreach(objective in level.tdmzones["<dev string:xd1>"]) {
          thread drawsphere(objective.origin, 20, 1, (1, 1, 1));
        }
      }

      if(isDefined(level.tdmzones["<dev string:xd7>"])) {
        foreach(objective in level.tdmzones["<dev string:xd7>"]) {
          thread drawsphere(objective.origin, 20, 1, (1, 1, 1));
        }
      }
    }

    wait 1;
  }
}

function function_e3a2a0c2e544728e(var_a4ab3e1ca5d220c4) {
  if(var_a4ab3e1ca5d220c4 <= 5) {
    key = "<dev string:xdd>" + var_a4ab3e1ca5d220c4;
    spawns_axis = level.spawnselectionlocations[key]["<dev string:xe9>"].spawnpoints;
    spawns_allies = level.spawnselectionlocations[key]["<dev string:xf1>"].spawnpoints;

    foreach(spawnpos in spawns_axis) {
      thread drawsphere(spawnpos.origin, 30, 60, (1, 0, 0));
      vect = anglesToForward(spawnpos.angles) * 30 + spawnpos.origin;
      thread drawline(spawnpos.origin, vect, 60, (0, 1, 0));
      thread drawline(spawnpos.origin, spawnpos.origin + (0, 0, 1000), 60, (1, 0, 0));
    }

    foreach(spawnpos in spawns_allies) {
      thread drawsphere(spawnpos.origin, 30, 60, (0, 0, 1));
      vect = anglesToForward(spawnpos.angles) * 30 + spawnpos.origin;
      thread drawline(spawnpos.origin, vect, 60, (0, 1, 0));
      thread drawline(spawnpos.origin, spawnpos.origin + (0, 0, 1000), 60, (0, 0, 1));
    }

    safekey = "<dev string:xdd>" + var_a4ab3e1ca5d220c4 + "<dev string:xfb>";
    var_eb7299174b67818d = undefined;
    var_fd81d96696f0490a = undefined;

    if(isDefined(level.spawnselectionlocations[safekey]) && isDefined(level.spawnselectionlocations[safekey]["<dev string:xe9>"])) {
      var_eb7299174b67818d = level.spawnselectionlocations[safekey]["<dev string:xe9>"].spawnpoints;
    }

    if(isDefined(level.spawnselectionlocations[safekey]) && isDefined(level.spawnselectionlocations[safekey]["<dev string:xf1>"])) {
      var_fd81d96696f0490a = level.spawnselectionlocations[safekey]["<dev string:xf1>"].spawnpoints;
    }

    if(!isDefined(var_eb7299174b67818d)) {
      var_eb7299174b67818d = spawns_axis;
    }

    if(!isDefined(var_fd81d96696f0490a)) {
      var_fd81d96696f0490a = spawns_allies;
    }

    foreach(spawnpos in var_eb7299174b67818d) {
      thread drawsphere(spawnpos.origin, 15, 60, (0.5, 0, 0));
      vect = anglesToForward(spawnpos.angles) * 30 + spawnpos.origin;
      thread drawline(spawnpos.origin, vect, 60, (0, 1, 0));
      thread drawline(spawnpos.origin, spawnpos.origin + (0, 0, 500), 60, (0.5, 0, 0));
    }

    foreach(spawnpos in var_fd81d96696f0490a) {
      thread drawsphere(spawnpos.origin, 15, 60, (0, 0, 0.5));
      vect = anglesToForward(spawnpos.angles) * 30 + spawnpos.origin;
      thread drawline(spawnpos.origin, vect, 60, (0, 1, 0));
      thread drawline(spawnpos.origin, spawnpos.origin + (0, 0, 500), 60, (0, 0, 0.5));
    }

    return;
  }

  if(var_a4ab3e1ca5d220c4 == 6) {
    key = "<dev string:x104>";
    spawns = level.spawnselectionlocations[key]["<dev string:xe9>"].spawnpoints;

    foreach(spawnpos in spawns) {
      thread drawsphere(spawnpos.origin, 30, 60, (1, 0, 0));
      vect = anglesToForward(spawnpos.angles) * 30 + spawnpos.origin;
      thread drawline(spawnpos.origin, vect, 60, (0, 1, 0));
    }

    return;
  }

  if(var_a4ab3e1ca5d220c4 == 7) {
    key = "<dev string:x115>";
    spawns = level.spawnselectionlocations[key]["<dev string:xf1>"].spawnpoints;

    foreach(spawnpos in spawns) {
      thread drawsphere(spawnpos.origin, 30, 60, (1, 0, 0));
      vect = anglesToForward(spawnpos.angles) * 30 + spawnpos.origin;
      thread drawline(spawnpos.origin, vect, 60, (0, 1, 0));
    }
  }
}

function sortlocationsbydistance(location1, location2) {
  return distancesquared(location1.origin, self.origin) < distancesquared(location2.origin, self.origin);
}

function calculatedroplocationnearlocation(location, mindist, maxdist) {
  pos = location.origin;
  x = undefined;
  y = undefined;
  diceroll = randomint(2);
  direction = ter_op(diceroll, -1, 1);

  if(direction > 0) {
    x = randomfloatrange(pos[0] + mindist * direction, pos[0] + maxdist * direction);

    if(x >= level.br_level.br_corners[0][0]) {
      x = level.br_level.br_corners[0][0] - 250;
    }
  } else {
    x = randomfloatrange(pos[0] + maxdist * direction, pos[0] + mindist * direction);

    if(x <= level.br_level.br_corners[1][0]) {
      x = level.br_level.br_corners[1][0] + 250;
    }
  }

  diceroll = randomint(2);
  direction = ter_op(diceroll, -1, 1);

  if(direction > 0) {
    y = randomfloatrange(pos[1] + mindist * direction, pos[1] + maxdist * direction);

    if(y >= level.br_level.br_corners[0][1]) {
      y = level.br_level.br_corners[0][1] - 250;
    }
  } else {
    y = randomfloatrange(pos[1] + maxdist * direction, pos[1] + mindist * direction);

    if(y >= level.br_level.br_corners[1][1]) {
      y = level.br_level.br_corners[1][1] + 250;
    }
  }

  droplocation = spawnStruct();
  droplocation.origin = (x, y, pos[2]);
  return droplocation;
}

function getmissedinfilcamerapositions(team) {
  assert(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()), "<dev string:x128>");
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

function calculatehqmidpoint() {
  level.hqmidpoint = (level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin) * 0.5;
  level.hqvecttomid_allies = level.gw_objstruct.axishqloc.trigger.origin - level.hqmidpoint;
  level.hqvecttomid_axis = level.gw_objstruct.allieshqloc.trigger.origin - level.hqmidpoint;
  level.hqdisttomid = length(level.hqvecttomid_axis);
}

function calculatecameraoffset(team, objectiveorigin) {
  switch (level.mapname) {
    case #"hash_7a28db3c5928c489":
      var_fc87d6fc10744d44 = 0.25;
      var_6e9b9701b439aeb7 = 0.35;
      break;
    case #"hash_863773b8960b3944":
      var_fc87d6fc10744d44 = 0.25;
      var_6e9b9701b439aeb7 = 0.8;
      break;
    case #"hash_a8b272dba33a4aed":
      var_fc87d6fc10744d44 = 0.5;
      var_6e9b9701b439aeb7 = 0.3;
      break;
    default:
      var_fc87d6fc10744d44 = 0;
      var_6e9b9701b439aeb7 = 0;
      break;
  }

  len = distance(objectiveorigin, level.hqmidpoint);

  if(len < 2048) {
    return (0, 0, 0);
  }

  if(team == "axis") {
    var_4881f7fe7fc2bae2 = distance(level.gw_objstruct.axishqloc.trigger.origin, objectiveorigin);
    fulloffset = level.hqvecttomid_axis;
  } else {
    var_4881f7fe7fc2bae2 = distance(level.gw_objstruct.allieshqloc.trigger.origin, objectiveorigin);
    fulloffset = level.hqvecttomid_allies;
  }

  if(var_4881f7fe7fc2bae2 < 2048) {
    return (fulloffset * var_fc87d6fc10744d44);
  }

  if(var_4881f7fe7fc2bae2 > level.hqdisttomid) {
    if(team == "axis") {
      var_4881f7fe7fc2bae2 = distance(level.gw_objstruct.allieshqloc.trigger.origin, objectiveorigin);
    } else {
      var_4881f7fe7fc2bae2 = distance(level.gw_objstruct.axishqloc.trigger.origin, objectiveorigin);
    }

    percentage = 100 - var_4881f7fe7fc2bae2 * 100 / level.hqdisttomid;
    offset = fulloffset * var_6e9b9701b439aeb7 * -1 * percentage / 100;
    return offset;
  }

  percentage = 100 - var_4881f7fe7fc2bae2 * 100 / level.hqdisttomid;
  offset = fulloffset * var_fc87d6fc10744d44 * percentage / 100;
  return offset;
}

function spawnprotectionexception() {
  if(isDefined(self.selectedspawnarea) && issubstr(self.selectedspawnarea, "HQ")) {
    return true;
  }

  return false;
}

function function_658c8f668d2cd83c() {
  wait 5;
  snd_transient_load("mp_gamemode_gw");
}