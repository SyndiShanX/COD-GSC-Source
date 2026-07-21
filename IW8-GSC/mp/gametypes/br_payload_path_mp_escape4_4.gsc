/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_payload_path_mp_escape4_4.gsc
*********************************************************/

toggle_farah_lights(var_0, var_1, var_2) {
  if(level.mapname != "_encstr_AF690B8DE7364F0A17C0C3EA12") {
    return;
  }
  if(level.disable_super_in_turret._id_1226A != var_1 && !isDefined(level.disable_super_in_turret._id_121FD)) {
    return;
  }
  if(!isDefined(level.disable_super_in_turret.paths))
    level.disable_super_in_turret.paths = [];

  var_3 = spawnStruct();
  var_3.nodes = [];
  var_3.origin = (533.372, 7588.22, 830.809);
  var_3.script_index = var_0;
  var_3.initchallengeandeventglobals = var_2;
  var_3.nodes[0] = var_3;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (607.705, 7093.97, 809.362);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (697.658, 6606.02, 722.002);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (842.07, 6126.6, 656.718);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (978.021, 5803.01, 625.946);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (746.208, 5146.4, 780.296);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (701.064, 4666.46, 923.903);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (862.414, 4471.6, 936.414);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1106.07, 4031.42, 946.683);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1251.45, 3551.57, 946.233);
  var_3.nodes[var_4].checkpoint = 1;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1386.54, 3068.68, 944.929);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1477.78, 2576.34, 934.667);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1549.62, 2080.26, 904.98);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1630.23, 1584.35, 881.072);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1708.08, 1088.9, 862.632);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1857.55, 609.423, 842.214);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2157.02, 208.257, 834.272);
  var_3.nodes[var_4].obstacle = spawnStruct();
  var_3.nodes[var_4].obstacle.origin = (2296.19, -34.7079, 834.401);
  var_3.nodes[var_4].obstacle.angles = (360.337, 299.804, 0);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2406.63, -227.521, 833.296);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2518.92, -716, 835.823);
  var_3.nodes[var_4].checkpoint = 1;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2606.39, -1209.57, 835.358);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2684.43, -1704.46, 834.796);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2758.81, -2199.87, 833.207);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2757.67, -2704.85, 833.036);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2737.06, -3205.62, 832.968);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2711.79, -3706.92, 797.818);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2612.42, -4194.81, 728.432);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2390.57, -4646.47, 696.053);
  var_3.nodes[var_4].obstacle = spawnStruct();
  var_3.nodes[var_4].obstacle.origin = (2357.32, -4924.49, 695.29);
  var_3.nodes[var_4].obstacle.angles = (360.167, 263.18, 0);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2330.95, -5145.01, 694.093);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2134.34, -5606.4, 696.223);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1931.79, -5757.14, 695.755);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1354.95, -5837.96, 698.124);
  _encstr_8C912D2646BB4B9BE447FA10B347B193926F1DAB1AA20728DA6B7148DF2D89E17BD21D20725ADB888F3FB01ADF6B81::_id_1318D(var_0, var_2);
  level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var_3;
}