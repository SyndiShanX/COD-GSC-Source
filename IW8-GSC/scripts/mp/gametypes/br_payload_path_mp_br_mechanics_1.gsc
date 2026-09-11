/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_payload_path_mp_br_mechanics_1.gsc
**********************************************************************/

function toggle_farah_lights(var0, var1, var2) {
  if(level.mapname != "mp_br_mechanics") {
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
  var3.origin = (405.034, -2843.48, -2.3219);
  var3.script_index = var0;
  var3.initchallengeandeventglobals = var2;
  var3.nodes[0] = var3;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (1016.57, -2866.57, -2.26046);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (1322.46, -2870.62, -2.23185);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (1629.64, -2870.7, -2.37269);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (1935.16, -2870.95, -2.68389);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (2191.16, -2871.14, 1);
  var3.nodes[var4].obstacle.angles = (270, 359.957, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (2240.69, -2871.18, -2.74402);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (2546.57, -2871.41, -2.34593);
  var3.nodes[var4].checkpoint = 1;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (2848.09, -2871.63, -2.38066);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (3155.19, -2871.86, -2.28605);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (3461.52, -2872.09, -2.23866);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (4281.53, -2810.75, 3.8147e-06);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (4541.3, -2557.66, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (4173.64, -2266.6, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (3728.81, -2150.91, -2.13237);
  var3.nodes[var4].checkpoint = 1;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (3426.56, -2107.91, -2.28282);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (3122.72, -2089.52, -2.39752);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (2821.93, -2084.86, -2.54239);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (2516.85, -2078.34, -2.4824);
  scripts\mp\gametypes\br_gametype_payload::ref_1318d(var0, var2);
  level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var3;
}