/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_bigmap\mp_jup_bigmap.gsc
**************************************************************/

#using script_147448f3f080c636;
#using script_1c88d328faa3d14f;
#using script_1d1428a3b7b402b0;
#using script_1fd613cd0dd414ab;
#using script_248ec5040062d3ce;
#using script_261f1b574c15eab1;
#using script_2d3fead1b9e1d7e5;
#using script_2d4b9c58ed0e3d91;
#using script_36967ce8ee2ea745;
#using script_386b1e00067e9ef3;
#using script_3a535b44f9ecc6df;
#using script_3b9cd620dfbf096b;
#using script_48e346d60cda7a1f;
#using script_49314540c657d352;
#using script_4a0d1f5f6be0f8c7;
#using script_550d4afc42895693;
#using script_55bc5525a33f6acf;
#using script_5c7bb8a12ccbe71f;
#using script_66e0e331f9783820;
#using script_69a61780e1cc21a9;
#using script_72af5a878a9d3397;
#using script_77cf57049c85d0df;
#using script_7abaa04d5f9fc22e;
#using scripts\common\anim;
#using scripts\common\create_script_utility;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\compass;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_anims;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_bigmap\gen\mp_jup_bigmap_art;
#using scripts\mp\maps\mp_jup_bigmap\mp_jup_bigmap_fx;
#using scripts\mp\maps\mp_jup_bigmap\mp_jup_bigmap_lighting;
#using scripts\mp\poi;
#using scripts\mp\utility\game;
#namespace mp_jup_bigmap;

function main() {
  level thread scripts\mp\poi::poi_init();
  scripts\mp\maps\mp_jup_bigmap\gen\mp_jup_bigmap_art::main();
  scripts\mp\maps\mp_jup_bigmap\mp_jup_bigmap_fx::main();
  scripts\mp\maps\mp_jup_bigmap\mp_jup_bigmap_lighting::main();
  initvehicles();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    scripts\mp\gametypes\br_anims::init();
    level.outofboundstriggersplanetrace = getEntArray("OutOfBounds", "targetname");
    level thread namespace_47431acb1419bed7::main();
    level thread namespace_a7074a12ed8cb3cf::main();
    level thread namespace_c05f1e879b7dd6a3::main();
    level thread namespace_1a1c54306fee9573::main();
    level thread namespace_a5edacb4e0415bcf::main();
    level thread namespace_2b5068fbec01a917::main();
    level thread namespace_1cf8ccfcb88ef3a3::main();
    level thread namespace_767ecc6f463d2d63::main();
    level thread namespace_ca4e5ac2a7fe2887::main();
    level.var_bbd8a18655d9495b = &namespace_2b520709cc9e7442::function_405bf7cde917b70e;
    level.var_f29702ddc09d1002 = &namespace_2b520709cc9e7442::function_384465a3a8aa24f7;
    level.var_ffa48a6a79a7224 = &namespace_2b520709cc9e7442::getclosestplayer;
  }

  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  }

  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  level.var_63a70ff2d38d8bee = getdvarint(@ "hash_433fa7ca2836c6f1", 0);
  level.var_f0872e42daf6d4d5 = getclosestpointonnavmesh((554, 979, -5349));
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  setDvar(@ "hash_71fe8b216d50a24c", 1);
  setDvar(@ "hash_402173c7dbee15d9", 4);
  setDvar(@ "hash_656131a98e0d2c9d", 50);
  setDvar(@ "hash_6a4705943fd574b8", 0.7);
  setDvar(@ "hash_d0658156fb7f2311", 2);
  setDvar(@ "hash_595f2292597ec0c7", (1, 0, 0));
  setDvar(@ "hash_da8fd34f1f588a6b", 3000);
  setDvar(@ "hash_f750bb7a6b8915f0", 1500);
  setDvar(@ "hash_646ca256ecff2627", "-65504 -65504 0");
  setDvar(@ "hash_a734a8dc8ef7627e", "131008 131008");
  setDvar(@ "hash_23bb35bbc2d79a8", 3000);
  setDvar(@ "hash_27fa9f4c8976e565", 10000);
  setDvar(@ "hash_bf2f16bd0028f6e3", "0.90 0.80 0.55");
  setDvar(@ "hash_33a035c99cb048b1", 5e-05);
  setDvar(@ "hash_99863fd36f21e4", 0.15);
  setDvar(@ "hash_43b1bfe24b9db3c5", 0.05);
  setDvar(@ "hash_70640ce906e6d9c2", 0.05);
  setDvar(@ "hash_5bb234e77e6e8500", 1);
  setDvar(@ "hash_248d3e2385cacb9b", 1);
  setDvar(@ "hash_2f948c271d3b0e2e", 2);
  setDvar(@ "hash_7623bd064c30088c", 0);
  setDvar(@ "hash_446ed387d5a2467b", 300);
  setDvar(@ "hash_d5be9cf5305a87c0", 0.99);
  setDvar(@ "hash_383eb0dc42a487be", 20);
  setDvar(@ "hash_6587b19cde46756e", "1.0 0.5 0.5");
  setDvar(@ "hash_198bc49639574b81", 600);
  setDvar(@ "hash_b7ba2258818c9f3d", 1);
  setDvar(@ "hash_b7972c5881666d83", 0);
  setDvar(@ "hash_9e9f4b1cab77df95", 0.03038);
  setDvar(@ "hash_9ad4ff0067a34902", 0.15);
  setDvar(@ "hash_6a4a2521dfc436d3", 14.1421);
  setDvar(@ "hash_bd8a970582340989", "clouds_mp_saba_section_1");
  setDvar(@ "hash_66bdfcbe954f0f83", "vol_clouds_noise_midway_32");
  setDvar(@ "hash_fcad48046518ef67", 0.2);
  setDvar(@ "hash_173fd72936a4128a", 3.42214);
  setDvar(@ "hash_a51fe16d9e863ec3", 0.5);
  setDvar(@ "hash_10c2ad088dc85d91", 0.5);
  scripts\mp\compass::setupminimap("compass_map_mp_jup_bigmap_ob", undefined, 16);

  if(getsubgametype() == "dmz") {
    scripts\mp\gametypes\br_gametype_dmz::function_dd432354af4c9024();
  }

  scripts\cp_mp\utility\game_utility::function_35f5b4e643757db7();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  if(getgametype() == "br") {
    if(getsubgametype() == "dmz") {
      function_eb7f544259415a09("mp_jup_bigmap_dmz");
    } else {
      function_eb7f544259415a09("mp_jup_bigmap_br");
    }
  } else if(getgametype() == "ob") {
    function_eb7f544259415a09("mp_jup_bigmap_ob");
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    brinit();
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    tile = getDvar(@ "hash_7a9791e29aa436af", "<dev string:x1c>");

    if(tile != "<dev string:x1c>" && getdvarint(@ "hash_2d0860b4e6eefba5", 0)) {
      level thread function_6eda5db03e992d7b(tile);
    }
  }

  level thread function_ef079ee3d6b651ad();

  if(istrue(level.supportsai)) {
    level thread scripts\mp\ai_mp_controller::function_c8393014dd7f8ab6();
  }

  level thread scripts\common\elevators::initelevators();

  if(getsubgametype() != "ob") {
    mdl_clip = getEnt("clip_subbase", "targetname");

    if(isDefined(mdl_clip)) {
      mdl_clip delete();
    }

    var_607fd6c265fe2a0 = getEntArray("clip_zombie_breach", "targetname");

    foreach(mdl_clip in var_607fd6c265fe2a0) {
      if(isDefined(mdl_clip)) {
        mdl_clip connectpaths();
      }

      waitframe();

      if(isDefined(mdl_clip)) {
        mdl_clip delete();
      }
    }
  }

  function_691203aeee9e9cf2();

  namespace_92443376a63aa4bd::function_f6c977ad89f51b9c(level.script, level.mapcorners);
  thread function_f7000b82b2f33765();
}

function function_f7000b82b2f33765() {
  scripts\engine\utility::flag_wait("scriptables_ready");

  if(getdvarint(@ "hash_1f4f051da27b03ef", 1) == 0) {
    return;
  }

  level.var_df4936f02271e7b0 = [];
  function_35b6cb2bac93917e((10351, -35894, 2705), (358.619, 203.006, -0.586181));
  function_35b6cb2bac93917e((-1561, -4153, 1591), (0, 68.5979, 0));

  if(getdvarint(@ "hash_55cc1d2c54897f07", 1) == 0) {
    return;
  }

  function_35b6cb2bac93917e((23939.3, -41819.8, 3530.9), (1.76039, 202.981, 3.78769));
  function_35b6cb2bac93917e((22245.4, -25143.7, 3059.63), (0.229846, 229.78, -1.89647));
  function_35b6cb2bac93917e((-1621, -4042, 1591), (0, 299.498, 0));
  function_35b6cb2bac93917e((37724, -3162, 2940), (0, 0, -1.3));
  function_35b6cb2bac93917e((14755, 2813, 1902), (0, 35.598, 0));
  function_35b6cb2bac93917e((10313, -35756, 2709), (0, 202.999, 0));
  function_35b6cb2bac93917e((-1724, -4091, 1591), (0, 107.399, 0));
  function_35b6cb2bac93917e((10227, -35839, 2706), (0, 0, 0));
}

function function_35b6cb2bac93917e(origin, angles) {
  dirt = spawnscriptable("bridge_dirt_pile_01_patch", origin, angles);
  dirt setscriptablepartstate("mp_tvstation_common", "on");
  level.var_df4936f02271e7b0[level.var_df4936f02271e7b0.size] = dirt;
}

function initvehicles() {
  level.var_1b4da6b781c9dfbd = 1;
  namespace_8db7d778efdc3d65::main();
  namespace_15896d40cab0d429::main();
  namespace_a8c01726524388f5::main();
  namespace_d8c2d739478db8bb::main();
  namespace_a8b2611e1c2c0f9c::main();
  namespace_65ad5249b19d5d41::main();
  namespace_9972b4aee3d673ca::main();
  namespace_a5c3c313b4f6886a::main();
  namespace_3568ab3cfd523b38::main();
  namespace_405c71940c7ec9ea::main();
  namespace_8624e3257d13b029::main();
}

function function_691203aeee9e9cf2() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x20>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x2d>", "<dev string:x37>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x51>", "<dev string:x5c>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x76>", "<dev string:x89>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xa1>", "<dev string:xb2>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xcb>", "<dev string:xd4>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xed>", "<dev string:xf8>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x111>", "<dev string:x11a>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x132>", "<dev string:x13b>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x155>", "<dev string:x162>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x17c>", "<dev string:x187>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x1a0>", "<dev string:x1a8>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x1c3>", "<dev string:x1cd>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x1e6>", "<dev string:x1ef>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x208>", "<dev string:x214>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x22d>", "<dev string:x239>", &function_ae5f5802b8c421c2);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_ae5f5802b8c421c2(param) {
  level.players[0] setOrigin(stringtovec3(param[0]));
}

function brinit() {
  scripts\mp\gametypes\br_gametypes::enablefeature("circleSnapToNavMesh");
  level.onlowpopstart = &function_865dd7703c23c87;
  level.br_level = spawnStruct();
  c130height = 16000;
  var_47c567a3b8b1e5e0 = getdvarint(@ "scr_game_c130heightoverride", -1);

  if(var_47c567a3b8b1e5e0 != -1) {
    c130height = var_47c567a3b8b1e5e0;
  }

  scripts\mp\gametypes\br_c130::setc130heightoverrides(c130height);
  boundsscale = getdvarfloat(@ "scr_bounds_scale_mp_saba", 0.8);
  minx = level.mapcorners[0].origin[0] * boundsscale;
  maxx = level.mapcorners[1].origin[0] * boundsscale;
  miny = level.mapcorners[1].origin[1] * boundsscale;
  maxy = level.mapcorners[0].origin[1] * boundsscale;
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (maxx, maxy, 0);
  level.br_level.br_mapbounds[1] = (minx, miny, 0);
  minx = level.mapcorners[0].origin[0];
  maxx = level.mapcorners[1].origin[0];
  miny = level.mapcorners[1].origin[1];
  maxy = level.mapcorners[0].origin[1];
  level.br_level.br_mapboundsfull = [];
  level.br_level.br_mapboundsfull[0] = (maxx, maxy, 0);
  level.br_level.br_mapboundsfull[1] = (minx, miny, 0);
  level.br_level.br_mapcenter = ((minx + maxx) / 2, (miny + maxy) / 2, 0);
  c130height = scripts\cp_mp\parachute::getc130height();
  c130sealevel = scripts\cp_mp\parachute::getc130sealevel();
  level.br_level.br_mapsize = (abs(maxx - minx), abs(maxy - miny), abs(c130height - c130sealevel));
  level.br_level.var_257dee2bbc2480f5 = getDvar(@ "hash_6484277e4bb431cd", "mp/jup_bigmap_br_locations.csv");

  if(isDefined(level.var_e486acb8f70c45a2)) {
    level.br_level.br_circleclosetimes = [level.var_e486acb8f70c45a2.circleclosetime, 3000, 3000];
    level.br_level.br_circledelaytimes = [level.var_e486acb8f70c45a2.delaytime, 3000, 3000];
    level.br_level.br_circleshowdelaydanger = [level.var_e486acb8f70c45a2.delaytime, 0, 0];
  } else if(getsubgametype() == "mini" || getsubgametype() == "mini_mgl") {
    level.br_level.br_circleclosetimes = [1, 200, 130, 90, 50, 100];
    level.br_level.br_circledelaytimes = [1, 120, 75, 60, 45, 0];
    level.br_level.br_circleshowdelaydanger = [1, 0, 0, 0, 0, 0];
  } else if(getsubgametype() == "resurgence") {
    level.br_level.br_circleclosetimes = [1, 110, 90, 75, 75, 120];
    level.br_level.br_circledelaytimes = [1, 150, 110, 75, 60, 0];
    level.br_level.br_circleshowdelaydanger = [1, 0, 0, 0, 0, 0];
  } else {
    level.br_level.br_circleclosetimes = [270, 220, 170, 110, 70, 50, 50, 100];
    level.br_level.br_circledelaytimes = [150, 75, 60, 60, 45, 30, 30, 0];
    level.br_level.br_circleshowdelaydanger = [150, 0, 0, 0, 0, 0, 0, 0];
  }

  if(isDefined(level.var_e486acb8f70c45a2)) {
    level.br_level.br_circleshowdelaysafe = [level.var_e486acb8f70c45a2.delaytime, 3000, 3000];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500];
    level.br_level.br_circleradii = [81600, level.var_e486acb8f70c45a2.circleradius, 200, 0];
  } else if(getsubgametype() == "mini" || getsubgametype() == "mini_mgl") {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 5500];

    if(istrue(level.var_63a70ff2d38d8bee)) {
      level.br_level.br_circleradii = [19000, 12500, 7500, 3500, 1000, 250, 0];
    } else {
      level.br_level.br_circleradii = [75000, 45000, 20000, 7000, 3500, 1500, 0];
    }
  } else if(getsubgametype() == "resurgence") {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [7500, 7500, 6500, 5500, 5000, 4500];
    level.br_level.br_circleradii = [22000, 22000, 12000, 8000, 4500, 1500, 0];
  } else {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 10500, 10500, 9000, 8000, 5500];
    level.br_level.br_circleradii = [81600, 57300, 37500, 22200, 12300, 6000, 3000, 1500, 0];
  }

  if(isDefined(level.br_circle_init_func)) {
    [[level.br_circle_init_func]]();
  }

  scripts\mp\gametypes\br_circle::applycirclesettings();
  level.br_prematchspawnlocations = [scripts\mp\gametypes\br::createspawnlocation((-31536, 30148, 1500), 0, 7000), scripts\mp\gametypes\br::createspawnlocation((1632, 25644, 1500), 0, 700), scripts\mp\gametypes\br::createspawnlocation((30752, 27476, 1515), 0, 7500), scripts\mp\gametypes\br::createspawnlocation((-31312, 4964, 1000), 0, 7000), scripts\mp\gametypes\br::createspawnlocation((-11568, 7116, 1056), 0, 7000), scripts\mp\gametypes\br::createspawnlocation((2588, 12, 2020), 0, 9000), scripts\mp\gametypes\br::createspawnlocation((16812, -5728, 1648), 0, 7000), scripts\mp\gametypes\br::createspawnlocation((38704, -5896, 2964), 0, 7000), scripts\mp\gametypes\br::createspawnlocation((-16336, -25180, 1748), 0, 17000), scripts\mp\gametypes\br::createspawnlocation((7492, -32964, 2000), 0, 9000), scripts\mp\gametypes\br::createspawnlocation((26040, -28664, 3504), 0, 7000)];
  level.br_badcircleareas = [scripts\mp\gametypes\br_circle::createinvalidcirclearea((-33022, -37501, 2622), 5000), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-29550, -41060, 2903), 5000), scripts\mp\gametypes\br_circle::createinvalidcirclearea((41433, -35444, 3408), 3300), scripts\mp\gametypes\br_circle::createinvalidcirclearea((19990, -40209, 3187), 3300), scripts\mp\gametypes\br_circle::createinvalidcirclearea((45891, 16077, 3048), 3300)];

  if(scripts\cp_mp\utility\game_utility::function_6493ec89ae923684()) {
    function_3574f80a3eb07f0d();
    var_9f4a3632d9f75d32 = (-38486, 45758, 2022);
    namespace_bd131dfa920d03b9::function_7e904ff184e6794c(var_9f4a3632d9f75d32, -10000);
  }
}

function function_865dd7703c23c87() {
  if(!scripts\mp\gametypes\br::lowpopallowtweaks()) {
    return;
  }

  if(getsubgametype() == "mini" || getsubgametype() == "mini_mgl") {
    if(istrue(level.var_63a70ff2d38d8bee)) {
      level.br_level.br_circleradii = [22500, 12000, 7500, 4000, 1500, 500, 0];
    } else {
      level.br_level.br_circleradii = [57000, 27500, 12500, 6500, 3000, 1250, 0];
    }

    level.br_level.br_circleclosetimes = [1, 190, 120, 80, 40, 90];
    level.br_level.br_circledelaytimes = [1, 110, 65, 50, 35, 0];
  } else {
    level.br_level.br_circleradii = [81000, 50000, 30000, 15000, 7500, 3750, 1500, 0];
    level.br_level.br_circleclosetimes = [270, 180, 150, 60, 60, 45, 90];
    level.br_level.br_circledelaytimes = [150, 60, 60, 60, 45, 30, 0];
  }

  scripts\mp\gametypes\br_circle::applycirclesettings();
}

function function_ef079ee3d6b651ad() {
  if(getdvarint(@ "hash_6979a78a1820ac18", 0) != 0) {
    return;
  }

  level waittill("prematch_started");

  while(!isDefined(level.br_ac130)) {
    wait 0.1;
  }

  fwd_ang = level.br_ac130.angles;
  fwd_ang += (0, -90, 0);
  level.name_fx = [];
  function_fd2dbeae371f9614("airport", (-31536, 30148, 4500), fwd_ang);
  function_fd2dbeae371f9614("coastaltown", (1632, 25644, 4500), fwd_ang);
  function_fd2dbeae371f9614("fishingvillage", (30752, 27476, 4550), fwd_ang);
  function_fd2dbeae371f9614("hydraulic", (-31312, 4964, 4500), fwd_ang);
  function_fd2dbeae371f9614("lighthouse", (-11568, 7116, 4556), fwd_ang);
  function_fd2dbeae371f9614("marshlands", (2588, 12, 4800), fwd_ang);
  function_fd2dbeae371f9614("moderncity", (16812, -5728, 4600), fwd_ang);
  function_fd2dbeae371f9614("mountaintown", (-16336, -25180, 5028), fwd_ang);
  function_fd2dbeae371f9614("observatory", (26040, -28664, 5004), fwd_ang);
  level thread function_5adc69197de334c3();
}

function function_fd2dbeae371f9614(scriptablestate, loc, fwd_ang) {
  if(istrue(level.isx1ops)) {
    function_6482feb0b7568914(scriptablestate + "_re", loc, fwd_ang, "name_fx_re");
    return;
  }

  function_6482feb0b7568914(scriptablestate, loc, fwd_ang, "name_fx");
}

function function_6482feb0b7568914(scriptablestate, loc, fwd_ang, scriptablepart) {
  loc += (0, 0, 500);
  var_b243306d75cc8719 = spawn("script_model", loc);
  var_b243306d75cc8719 setModel("jup_tag_origin_name_fx");
  var_b243306d75cc8719.angles = fwd_ang;
  level.name_fx[level.name_fx.size] = var_b243306d75cc8719;
  var_b243306d75cc8719 setscriptablepartstate(scriptablepart, scriptablestate);
  var_b243306d75cc8719 forcenetfieldhighlod(1);
}

function function_5adc69197de334c3() {
  level thread function_6a0decc2d8ffcaae();

  while(isDefined(level.br_ac130)) {
    wait 0.1;
  }

  wait 90;
  level notify("stop_fx_hide_func");

  foreach(element in level.name_fx) {
    element delete();
  }
}

function function_6a0decc2d8ffcaae() {
  level endon("game_ended");
  level endon("stop_fx_hide_func");
  throttle = 10;
  throttle_wait = 0.25;

  while(level.name_fx.size > 0) {
    player_list = level.players;

    for(i = 0; i < player_list.size; i++) {
      test_player = player_list[i];

      if(isDefined(test_player) && isalive(test_player)) {
        if(isDefined(test_player.vehicle)) {
          for(j = 0; j < level.name_fx.size; j++) {
            level.name_fx[j] hidefromplayer(test_player);
          }
        }
      }

      if(i % throttle == 0) {
        wait throttle_wait;
      }
    }

    wait 0.1;
  }
}

function function_6eda5db03e992d7b(var_1a12730b9392225) {
  var_f94237d8c14e730d = undefined;

  switch (var_1a12730b9392225) {
    case #"hash_343f1caa2dc07b2c":
      var_f94237d8c14e730d = (41065.4, 13217.8, 1686.36);
      break;
    case #"hash_343f23aa2dc08631":
      var_f94237d8c14e730d = (26564.4, -30964.7, 785.1);
      break;
    default:
      assertex(0, "<dev string:x265>");
      return;
  }

  level waittill("<dev string:x2f5>");
  scripts\mp\gametypes\br_circle_util::function_62c8ef916090a2c(var_f94237d8c14e730d);
}

function function_3574f80a3eb07f0d() {
  level.landingspots = [];
  spot1 = spawnStruct();
  spot1.target = "spot1";
  spot1.origin = (-25616, 32040, 1545);
  spot1.script_parameters = 1;
  level.landingspots[level.landingspots.size] = spot1;
  spot2 = spawnStruct();
  spot2.target = "spot2";
  spot2.origin = (1585, 33139, 1414);
  spot2.script_parameters = 1;
  level.landingspots[level.landingspots.size] = spot2;
  spot3 = spawnStruct();
  spot3.target = "spot3";
  spot3.origin = (32036, 30149, 1411);
  spot3.script_parameters = 1;
  level.landingspots[level.landingspots.size] = spot3;
  spot4 = spawnStruct();
  spot4.target = "spot4";
  spot4.origin = (-21167, 1461, 1469);
  spot4.script_parameters = 1;
  level.landingspots[level.landingspots.size] = spot4;
  spot5 = spawnStruct();
  spot5.target = "spot5";
  spot5.origin = (8369, -583, 2231);
  spot5.script_parameters = 1;
  level.landingspots[level.landingspots.size] = spot5;
  spot6 = spawnStruct();
  spot6.target = "spot6";
  spot6.origin = (34886, -735, 2643);
  spot6.script_parameters = 1;
  level.landingspots[level.landingspots.size] = spot6;
  spot7 = spawnStruct();
  spot7.target = "spot7";
  spot7.origin = (-13198, -21240, 2104);
  spot7.script_parameters = 1;
  level.landingspots[level.landingspots.size] = spot7;
  spot8 = spawnStruct();
  spot8.target = "spot8";
  spot8.origin = (4271, -28614, 2195);
  spot8.script_parameters = 1;
  level.landingspots[level.landingspots.size] = spot8;
  spot9 = spawnStruct();
  spot9.target = "spot9";
  spot9.origin = (26618, -30923, 3630);
  spot9.script_parameters = 1;
  level.landingspots[level.landingspots.size] = spot9;
}