/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_payload_path_mp_br_mechanics_2.gsc
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
  var_3.origin = (92.5261, -3286.25, -2.32518);
  var_3.script_index = var_0;
  var_3.initchallengeandeventglobals = var_2;
  var_3.nodes[0] = var_3;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-492.835, -3443.4, -2.23642);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-786.029, -3522.11, -2.25059);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1079.51, -3600.9, -2.40771);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1374.59, -3680.12, -2.6099);
  var_3.nodes[var_4].obstacle = spawnStruct();
  var_3.nodes[var_4].obstacle.origin = (-1787.51, -3916.91, 0);
  var_3.nodes[var_4].obstacle.angles = (270, 209.832, 0);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1643.31, -3834.22, -3.30633);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1859.49, -4042.8, -2.92593);
  var_3.nodes[var_4].checkpoint = 1;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1999.13, -4311.33, -3.06441);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-2097.14, -4599.27, -2.89895);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1838.67, -4801.82, 0);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1566.19, -4943, 0.0000038147);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-1266.59, -5063.03, 0.0000038147);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-983.885, -5119, -2.24976);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-677.525, -5101.83, -2.24974);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-371.419, -5084.71, -2.44941);
  var_3.nodes[var_4].checkpoint = 1;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (-77.3279, -4987.86, -2.37326);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (203.071, -4867.83, -2.5201);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (483.202, -4747.43, -2.61689);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (763.835, -4626.62, -2.58065);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1043.52, -4506.27, -2.56375);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1323.75, -4384.02, -2.68962);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1538.91, -4169.25, -2.42254);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1597.83, -3866.6, -2.40892);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1476.02, -3587.22, -2.40248);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1217.26, -3429.94, -2.40533);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (912.936, -3420.58, -2.39017);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (607.926, -3424.74, -2.21128);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (336.61, -3554.4, -2.34044);
  _encstr_8C912D2646BB4B9BE447FA10B347B193926F1DAB1AA20728DA6B7148DF2D89E17BD21D20725ADB888F3FB01ADF6B81::_id_1318D(var_0, var_2);
  level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var_3;
}