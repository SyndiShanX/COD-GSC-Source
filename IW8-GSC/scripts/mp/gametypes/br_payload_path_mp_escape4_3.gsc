/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_payload_path_mp_escape4_3.gsc
*****************************************************************/

function toggle_farah_lights(var0, var1, var2) {
  if(level.mapname != "mp_escape4") {
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
  var3.origin = (3194.14, -6904.6, 597.43);
  var3.script_index = var0;
  var3.initchallengeandeventglobals = var2;
  var3.nodes[0] = var3;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (2814.76, -7225.53, 664.159);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (2338.96, -7388.76, 697.539);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (1836.79, -7426.27, 697.146);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (1335.49, -7438.24, 697.711);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (834.223, -7448.66, 699.006);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (329.423, -7427.97, 702.458);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-168.202, -7372.47, 706.857);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-650.716, -7229.83, 707.378);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1104.69, -7017.54, 705.67);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1522.02, -6735.06, 707.673);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-1899.65, -6406.61, 708.078);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2234.41, -6034.4, 708.001);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2573.07, -5664.64, 699.007);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2918.68, -5300.51, 695.981);
  var3.nodes[var4].checkpoint = 1;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3288.61, -4957.32, 671.21);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3678.23, -4642.29, 627.202);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3881.38, -4181.18, 590.995);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3963.98, -3687.7, 599.457);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3992.62, -3187.95, 616.176);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4002.29, -2687.57, 635.225);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4011.21, -2187.29, 654.243);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4051.07, -1691.61, 676.348);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4096.28, -1196.91, 694.302);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (-4148.16, -921.789, 700.159);
  var3.nodes[var4].obstacle.angles = (360.984, 100.679, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4187.8, -711.576, 701.546);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4357.47, -240.259, 708.763);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4525.99, 231.7, 711.354);
  var3.nodes[var4].checkpoint = 1;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4659.15, 717.093, 712.435);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4571.74, 1209.79, 712.286);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4337.59, 1653.45, 701.639);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4169.37, 1886.04, 696.325);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-4014.56, 2143.93, 689.23);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3933.38, 2558.01, 675.521);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3862.26, 3051.81, 634.363);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3789.86, 3550.7, 613.297);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3660.42, 4034.12, 612.896);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3444.27, 4486.75, 600.526);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3280.34, 4961.93, 575.892);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3161.48, 5449.75, 531.087);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (-3090.73, 5720.66, 530.044);
  var3.nodes[var4].obstacle.angles = (360.234, 75.3636, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-3034.58, 5935.66, 528.776);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2907.92, 6420.71, 529.013);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2781.2, 6905.86, 527.924);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (-2736.73, 7076.12, 527.323);
  scripts\mp\gametypes\br_gametype_payload::ref_1318d(var0, var2);
  level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var3;
}