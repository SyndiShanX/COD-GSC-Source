/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_60ae97cf129e8a40.gsc
*************************************************/

#using script_4a0d1f5f6be0f8c7;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_ai_encounters;
#using scripts\mp\gametypes\br_anims;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_maphints;
#using scripts\mp\utility\game;
#namespace namespace_79e590f683734378;

function function_733b23bb49feb5c3() {
  level thread scripts\mp\gametypes\br_ai_encounters::init();
  level thread scripts\mp\gametypes\br_maphints::init();
  println("<dev string:x1c>");

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    function_a94c90dc6c858da4();

    if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      spawnorigin = (603, 2705, 1306);

      if(isDefined(level.circletest.playerspawnpoint)) {
        spawnorigin = level.circletest.playerspawnpoint;
      }

      var_9f4a3632d9f75d32 = (-15604, 6617, -1000);

      if(isDefined(level.circletest.botspawnorigin)) {
        var_9f4a3632d9f75d32 = level.circletest.botspawnorigin;
      }

      spawnangle = (0, 60, 0);
      namespace_bd131dfa920d03b9::function_7e904ff184e6794c(var_9f4a3632d9f75d32, undefined, undefined, spawnorigin, spawnangle);
    }

    function_eb7f544259415a09("mp_escape3");
  }
}

function function_a94c90dc6c858da4() {
  scripts\mp\gametypes\br_anims::init();
  level.br_level = spawnStruct();
  level.br_level.br_corners = [];
  level.br_level.br_corners[0] = (5800, -12000, 200);
  level.br_level.br_corners[1] = (-7000, 14000, 200);
  heightoverride = 6000;

  if(getgametype() == "arm" || getgametype() == "conflict") {
    heightoverride = 8000;
  } else if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    var_b83c1c9cb27cc9d7 = -1;
    brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

    if(brgametype == "dmz" || brgametype == "plunder") {
      var_b83c1c9cb27cc9d7 = getdvarint(@ "hash_e432209cc5fbc970", 18000);
    } else {
      var_b83c1c9cb27cc9d7 = getdvarint(@ "hash_e432209cc5fbc970", -1);
    }

    if(var_b83c1c9cb27cc9d7 != -1) {
      heightoverride = var_b83c1c9cb27cc9d7;
    }
  }

  scripts\mp\gametypes\br_c130::setc130heightoverrides(heightoverride, 65);
  level.br_level.c130_speedoverride = 2000;
  minx = min(level.br_level.br_corners[0][0], level.br_level.br_corners[1][0]);
  maxx = max(level.br_level.br_corners[0][0], level.br_level.br_corners[1][0]);
  miny = min(level.br_level.br_corners[1][1], level.br_level.br_corners[0][1]);
  maxy = max(level.br_level.br_corners[1][1], level.br_level.br_corners[0][1]);
  level.br_level.br_mapboundsfull = [];
  level.br_level.br_mapboundsfull[0] = (maxx, maxy, 0);
  level.br_level.br_mapboundsfull[1] = (minx, miny, 0);
  minx = level.br_level.br_corners[0][0] * 0.8;
  maxx = level.br_level.br_corners[1][0] * 0.8;
  miny = level.br_level.br_corners[1][0] * 0.8;
  maxy = level.br_level.br_corners[1][1] * 0.8;
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (maxx, maxy, 0);
  level.br_level.br_mapbounds[1] = (minx, miny, 0);
  level.br_level.br_mapcenter = ((minx + maxx) / 2, (miny + maxy) / 2, 0);
  level.br_level.br_mapsize = (abs(maxx - minx), abs(maxy - miny), abs(level.br_level.c130_heightoverride - level.br_level.c130_sealeveloverride));

  if(getdvarint(@ "scr_br_alt_mode_nonstop", 0)) {
    level.br_level.br_circleclosetimes = [360, 270, 225, 135, 90, 60, 45, 90];
    level.br_level.br_circledelaytimes = [60, 0, 0, 0, 0, 0, 0, 0];
    level.br_level.br_circleshowdelaydanger = [60, 0, 0, 0, 0, 0, 0, 0];
  } else if(getdvarint(@ "scr_br_alt_mode_rlh", 0)) {
    level.br_level.br_circleclosetimes = [270, 150, 120, 90, 60, 45, 45, 90];
    level.br_level.br_circledelaytimes = [60, 10, 10, 10, 10, 10, 10, 0];
    level.br_level.br_circleshowdelaydanger = [60, 0, 0, 0, 0, 0, 0, 0];
  } else if(getsubgametype() == "mini" || getsubgametype() == "mini_mgl") {
    level.br_level.br_circleclosetimes = [1, 200, 130, 90, 50, 100];
    level.br_level.br_circledelaytimes = [1, 120, 75, 60, 45, 0];
    level.br_level.br_circleshowdelaydanger = [1, 0, 0, 0, 0, 0];
  } else if(getsubgametype() == "rebirth") {
    level.br_level.br_circleclosetimes = [90, 45, 45, 45, 105];
    level.br_level.br_circledelaytimes = [120, 90, 60, 60, 0];
    level.br_level.br_circleshowdelaydanger = [120, 0, 0, 0, 0];
  } else if(getsubgametype() == "vanilla") {
    level.br_level.br_circleclosetimes = [90, 60, 60, 30, 100];
    level.br_level.br_circledelaytimes = [75, 60, 60, 60, 30];
    level.br_level.br_circleshowdelaydanger = [75, 0, 0, 0, 0];
  } else {
    level.br_level.br_circleclosetimes = [135, 110, 85, 55, 35, 25, 25, 50];
    level.br_level.br_circledelaytimes = [110, 45, 37, 30, 30, 22, 15, 0];
    level.br_level.br_circleshowdelaydanger = [20, 0, 0, 0, 0, 0, 0, 0];
  }

  if(getsubgametype() == "mini" || getsubgametype() == "mini_mgl") {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 5500];
    circlesetting = getdvarint(@ "hash_e84ce12f7a01a55a", 0);

    if(circlesetting == 1) {
      level.br_level.br_circleradii = [75000, 45000, 20000, 7000, 3500, 1500, 0];
    } else {
      level.br_level.br_circleradii = [60000, 30000, 15000, 7000, 3500, 1500, 0];
    }
  } else if(getsubgametype() == "rebirth") {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 5500];
    level.br_level.br_circleradii = [12000, 10000, 8000, 5000, 1500, 0];
  } else if(getsubgametype() == "vanilla") {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [7500, 6500, 5500, 5000, 4500];
    level.br_level.br_circleradii = [16000, 11000, 7500, 4000, 1500, 0];
  } else {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 10500, 10500, 9000, 8000, 5500];
    level.br_level.br_circleradii = [9600, 5300, 2500, 1200, 800, 500, 200, 50, 0];
  }

  if(isDefined(level.br_circle_init_func)) {
    [[level.br_circle_init_func]]();
  }

  scripts\mp\gametypes\br_circle::applycirclesettings();
  level.br_prematchspawnlocations = [scripts\mp\gametypes\br::createspawnlocation((-1261, -10218.5, 519.66), 0, 500), scripts\mp\gametypes\br::createspawnlocation((301.573, -6134.04, 692.001), 0, 500), scripts\mp\gametypes\br::createspawnlocation((-3932.99, -2860.85, 622.534), 0, 500), scripts\mp\gametypes\br::createspawnlocation((3565.82, -6494.82, 497.727), 0, 500), scripts\mp\gametypes\br::createspawnlocation((2784.2, -1387.21, 839.998), 0, 500)];
  level.br_badcircleareas = [scripts\mp\gametypes\br_circle::createinvalidcirclearea((-18691, 12376, 200), 15000), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-19459, -12712, 200), 15000), scripts\mp\gametypes\br_circle::createinvalidcirclearea((19261, -12712, 200), 15000), scripts\mp\gametypes\br_circle::createinvalidcirclearea((18493, 12376, 200), 15000), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-707, 20888, 200), 8000), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-707, -22632, 200), 8000), scripts\mp\gametypes\br_circle::createinvalidcirclearea((5255, -15805, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((8323, -9836, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((8642, 3052, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((7015, 9413, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((4349, 13144, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-7087, 13998, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-8292, 8684, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-9920, 2816, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-8292, 8684, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-9088, -5312, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-7424, -12800, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-1600, -17344, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((9923, -2860, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-1859, 16600, 200), 4500), scripts\mp\gametypes\br_circle::createinvalidcirclearea((2388, -11256, 200), 2400), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-4140, -8184, 200), 2000), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-6085, 2857, 200), 1100), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-92, 12848, 200), 1100), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-4582, 10069, 200), 1100), scripts\mp\gametypes\br_circle::createinvalidcirclearea((4957, 4374, 200), 1100), scripts\mp\gametypes\br_circle::createinvalidcirclearea((4579, 6143, 200), 1100), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-6700, -824, 200), 1100), scripts\mp\gametypes\br_circle::createinvalidcirclearea((-3820, -9656, 200), 1100), scripts\mp\gametypes\br_circle::createinvalidcirclearea((1556, -13880, 200), 1100)];
  setDvar(@ "br_max_armory_kiosk", 10);
}