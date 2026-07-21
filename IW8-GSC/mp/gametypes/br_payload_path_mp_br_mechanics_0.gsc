/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_payload_path_mp_br_mechanics_0.gsc
**************************************************************/

toggle_farah_lights(var_0, var_1, var_2) {
  if(level.mapname != "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE") {
    return;
  }
  if(level.disable_super_in_turret._id_1226A != var_1 && !isDefined(level.disable_super_in_turret._id_121FD)) {
    return;
  }
  if(!isDefined(level.disable_super_in_turret.paths))
    level.disable_super_in_turret.paths = [];

  var_3 = spawnStruct();
  var_3.nodes = [];
  var_3.origin = (-467.284, -2946.14, 29.7635);
  var_3.script_index = var_0;
  var_3.initchallengeandeventglobals = var_2;
  var_3.nodes[0] = var_3;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-869.335, -2986.2, 29.7344);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1071.19, -3006.04, 29.618);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1278.88, -2979.64, 29.5339);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1479.9, -2952.47, -2.37007);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1684.66, -2922.75, -2.55707);
  var_3.nodes[var_4].obstacle = spawnStruct();
  var_3.nodes[var_4].obstacle.origin = (-1936.48, -2876.78, 0);
  var_3.nodes[var_4].obstacle.angles = (270, 169.655, 0);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1888.07, -2885.62, 0.188496);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2088.88, -2836.17, 3.23592);
  var_3.nodes[var_4].checkpoint = 1;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2285.83, -2780.81, 7.08702);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2473.76, -2692.29, -3.92537);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2646.73, -2583.15, -2.36688);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2764.22, -2415.91, -3.44456);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2819.54, -2220.43, -3.58483);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2799.23, -2017.73, -3.2049);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2756.85, -1816.35, -2.7474);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2646.36, -1645.33, -3.6145);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2482.53, -1525.01, -3.58001);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2286.49, -1470.12, -3.05423);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2081.43, -1478.68, -2.99345);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1874.62, -1489.46, -2.94819);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1672.88, -1537.34, -3.0913);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1473.85, -1594.46, -2.93045);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1292.39, -1694.24, -3.12648);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1126.07, -1817.22, -2.98512);
  var_3.nodes[var_4].checkpoint = 1;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-950.744, -1926.04, -3.04264);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-758.891, -1995.2, -3.13394);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-555.526, -2031.23, -2.89565);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-351.57, -2057.19, -2.91715);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-144.864, -2055.92, -2.98288);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (62.069, -2057.35, -2.92873);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (268.766, -2059.42, -2.21953);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (475.379, -2061.37, -2.3129);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (678.752, -2063.31, -2.51254);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (878.993, -2065.21, -2.50003);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (931.286, -2065.71, -2.34224);
  _encstr_8C912D2646BB4B9BE447FA10B347B193926F1DAB1AA20728DA6B7148DF2D89E17BD21D20725ADB888F3FB01ADF6B81::_id_1318D(var_0, var_2);
  level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var_3;
}