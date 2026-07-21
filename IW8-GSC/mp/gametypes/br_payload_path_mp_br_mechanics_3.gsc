/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_payload_path_mp_br_mechanics_3.gsc
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
  var_3.origin = (1230.03, -2493.29, -2.32313);
  var_3.script_index = var_0;
  var_3.initchallengeandeventglobals = var_2;
  var_3.nodes[0] = var_3;
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1420.3, -2329.11, -2.28926);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (1880.23, -2130.14, -2.3435);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2381.53, -2139.1, -2.36388);
  var_4 = var_3.nodes.size;
  var_3.nodes[var_4] = spawnStruct();
  var_3.nodes[var_4].origin = (2477.3, -2159.69, -2.34202);
  _encstr_8C912D2646BB4B9BE447FA10B347B193926F1DAB1AA20728DA6B7148DF2D89E17BD21D20725ADB888F3FB01ADF6B81::_id_1318D(var_0, var_2);
  level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var_3;
}