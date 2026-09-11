/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_payload_path_mp_br_mechanics_0.gsc
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
  var3.origin = (-467.284, -2946.14, 29.7635);
  var3.script_index = var0;
  var3.initchallengeandeventglobals = var2;
  var3.nodes[0] = var3;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-869.335, -2986.2, 29.7344);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1071.19, -3006.04, 29.618);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1278.88, -2979.64, 29.5339);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1479.9, -2952.47, -2.37007);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1684.66, -2922.75, -2.55707);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (-1936.48, -2876.78, 0);
  var3.nodes[var4].obstacle.angles = (270, 169.655, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1888.07, -2885.62, 0.188496);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2088.88, -2836.17, 3.23592);
  var3.nodes[var4].checkpoint = 1;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2285.83, -2780.81, 7.08702);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2473.76, -2692.29, -3.92537);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2646.73, -2583.15, -2.36688);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2764.22, -2415.91, -3.44456);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2819.54, -2220.43, -3.58483);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2799.23, -2017.73, -3.2049);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2756.85, -1816.35, -2.7474);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2646.36, -1645.33, -3.6145);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2482.53, -1525.01, -3.58001);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2286.49, -1470.12, -3.05423);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2081.43, -1478.68, -2.99345);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1874.62, -1489.46, -2.94819);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1672.88, -1537.34, -3.0913);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1473.85, -1594.46, -2.93045);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1292.39, -1694.24, -3.12648);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1126.07, -1817.22, -2.98512);
  var3.nodes[var4].checkpoint = 1;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-950.744, -1926.04, -3.04264);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-758.891, -1995.2, -3.13394);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-555.526, -2031.23, -2.89565);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-351.57, -2057.19, -2.91715);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-144.864, -2055.92, -2.98288);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (62.069, -2057.35, -2.92873);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (268.766, -2059.42, -2.21953);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (475.379, -2061.37, -2.3129);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (678.752, -2063.31, -2.51254);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (878.993, -2065.21, -2.50003);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (931.286, -2065.71, -2.34224);
  scripts\mp\gametypes\br_gametype_payload::ref_1318d(var0, var2);
  level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var3;
}