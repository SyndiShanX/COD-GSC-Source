/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_payload_path_mp_don4_4.gsc
**************************************************************/

function toggle_farah_lights(var0, var1, var2) {
  if(level.mapname != "mp_don4") {
    return;
  }

  if(level.disable_super_in_turret.ref_1226a != var1 && !isDefined(level.disable_super_in_turret.ref_121fd)) {
    return;
  }

  if(!isDefined(level.disable_super_in_turret.paths)) {
    level.disable_super_in_turret.paths = [];
  }

  var3 = spawnStruct();
  var3.nodes = [];
  var3.origin = (-23409.8, -29035.3, -124.347);
  var3.script_index = var0;
  var3.initchallengeandeventglobals = var2;
  var3.nodes[0] = var3;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-23008, -28736.9, -124.214);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-22610.7, -28431, -124.868);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-22199.9, -28144, -128.476);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-21780.7, -27871.5, -136.555);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-21349.6, -27616.7, -145.37);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-20924.1, -27353.6, -148.346);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-20498.9, -27089.8, -149.418);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-20073.1, -26827.3, -157.885);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (-19649.9, -26561.3, -171.123);
  var3.nodes[var4].obstacle.angles = (361.715, 32.1592, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-19648.6, -26560.4, -172.237);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-19233.4, -26281.6, -188.021);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-18813, -26010.7, -202.103);
  var3.nodes[var4].checkpoint = 1;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-18385.5, -25751, -216.147);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-17954.9, -25495.7, -231.798);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-17515.2, -25257.7, -248.685);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-17069.1, -25030, -266.414);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-16614.6, -24821, -276.177);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (-16153.2, -24628.4, -274.14);
  var3.nodes[var4].obstacle.angles = (360.533, 22.6585, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-16151.8, -24627.8, -276.976);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-15666.6, -24486.4, -282.375);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-15208.8, -24290.2, -285.173);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-14766.2, -24057.5, -285.237);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-14324.2, -23820.3, -285.445);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (-13884.3, -23582.5, -283.156);
  var3.nodes[var4].obstacle.angles = (360.015, 28.3969, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-13883.6, -23582.1, -285.461);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-13446.4, -23336.7, -285.016);
  var3.nodes[var4].checkpoint = 1;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-13013.3, -23083.9, -285.518);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-12586.6, -22821.5, -288.03);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-12163.4, -22554.9, -317.229);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-11740.4, -22288.5, -359.06);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-11314.7, -22024.3, -363.122);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-10851.2, -21833.7, -352.17);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-10357, -21762, -321.426);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-9857.89, -21757.2, -281.936);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (-9472.07, -21814.1, -283.044);
  var3.nodes[var4].obstacle.angles = (360.628, 351.604, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-9326.71, -21835.6, -283.641);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-8796.53, -21822.8, -287.253);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-8368.1, -21819.8, -288.495);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-7856.09, -21731.9, -292.09);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (-7357.14, -21699.5, -290.001);
  var3.nodes[var4].obstacle.angles = (360, 3.72055, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-7356.3, -21699.4, -292.453);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-6856.2, -21660.7, -292.418);
  scripts\mp\gametypes\br_gametype_payload::ref_1318d(var0, var2);
  level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var3;
}