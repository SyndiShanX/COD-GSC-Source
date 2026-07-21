/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_payload_path_mp_br_mechanics_1.gsc
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
  var_3.origin = (405.034, -2843.48, -2.3219);
  var_3.script_index = var_0;
  var_3.initchallengeandeventglobals = var_2;
  var_3.nodes[0] = var_3;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1016.57, -2866.57, -2.26046);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1322.46, -2870.62, -2.23185);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1629.64, -2870.7, -2.37269);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1935.16, -2870.95, -2.68389);
  var_3.nodes[var_4].obstacle = spawnStruct();
  var_3.nodes[var_4].obstacle.origin = (2191.16, -2871.14, 1);
  var_3.nodes[var_4].obstacle.angles = (270, 359.957, 0);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2240.69, -2871.18, -2.74402);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2546.57, -2871.41, -2.34593);
  var_3.nodes[var_4].checkpoint = 1;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2848.09, -2871.63, -2.38066);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (3155.19, -2871.86, -2.28605);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (3461.52, -2872.09, -2.23866);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (4281.53, -2810.75, 0.0000038147);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (4541.3, -2557.66, 0);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (4173.64, -2266.6, 0);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (3728.81, -2150.91, -2.13237);
  var_3.nodes[var_4].checkpoint = 1;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (3426.56, -2107.91, -2.28282);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (3122.72, -2089.52, -2.39752);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2821.93, -2084.86, -2.54239);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2516.85, -2078.34, -2.4824);
  _encstr_8C912D2646BB4B9BE447FA10B347B193926F1DAB1AA20728DA6B7148DF2D89E17BD21D20725ADB888F3FB01ADF6B81::_id_1318D(var_0, var_2);
  level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var_3;
}