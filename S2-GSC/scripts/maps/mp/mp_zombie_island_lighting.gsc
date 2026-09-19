/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_lighting.gsc
*********************************************************/

main() {
  _id_84F8();

  if(level._id_01D4 && getDvar("2695") != "true")
    xbox_optimizations();

  if(level._id_0149 && getDvar("3957") != "true")
    neo_optimizations();

  level thread maps\mp\_utility::_id_6F74(::onplayerspawned);
}

onplayerspawned() {
  var_0 = self;
  var_0 endon("disconnect");
  wait 0.5;
  var_0 _meth_806B(0.25, 1.7, 1.2, 1.2, 0);
}

_id_84F8() {
  setDvar("2973", 0);
  setDvar("2664", 0);
  setDvar("4230", 500);
  setDvar("2387", 1);
  setDvar("1578", 3);
  setDvar("5156", 1);
  setDvar("935", 1);
  setDvar("2893", 2);
}

neo_optimizations() {
  setDvar("1578", 2);
}

xbox_optimizations() {
  setDvar("1578", 0);
  setDvar("5156", 0);
}

main_off() {
  var_0 = spawnStruct();
  var_0._id_9C83 = 2;
  var_0._id_1103 = 1;
  var_0._id_1128 = (0.687426, 0.828278, 1);
  var_0._id_1108 = (0.826306, 0.773848, 0.422946);
  var_0._id_110A = 0.173616;
  var_0._id_1109 = 0.118084;
  var_0._id_1106 = 1;
  var_0._id_1105 = 0.472503;
  var_0._id_1110 = 19.5715;
  var_0._id_1107 = 67391.6;
  var_0._id_1126 = -1000;
  var_0._id_1102 = 2.45955;
  var_0._id_1112 = 45612;
  var_0._id_1111 = 1;
  var_0._id_1114 = 16.5631;
  var_0._id_1113 = 219.708;
  var_0._id_1127 = (0.629852, -0.752156, 0.193774);
  var_0._id_110C = 1;
  var_0._id_110B = 554.428;
  var_0._id_110D = 140.001;
  var_0._id_110E = 596.118;
  var_0._id_110F = 0.646403;
  var_0._id_1104 = 1;
  var_0._id_10FF = 0;
  var_0._id_1100 = 1;
  var_0._id_1101 = 0;
  var_0._id_111F = 1;
  var_0._id_1115 = 3564.58;
  var_0._id_1116 = 12745.2;
  var_0._id_1117 = 69106.2;
  var_0._id_1120 = 69106.2;
  var_0._id_111C = 0.00404669;
  var_0._id_111D = 0.119998;
  var_0._id_111E = 0.753736;
  var_0._id_1122 = 0.9411;
  var_0._id_1125 = 0;
  var_0._id_1123 = (0, 0, 0);
  var_0._id_111B = 0;
  var_0._id_1124 = 0;
  var_0._id_1118 = 0;
  var_0._id_1119 = 0;
  var_0._id_111A = 0;
  var_0._id_1121 = 0;
  level.island_fog_off = var_0;
}

main_on() {
  var_0 = spawnStruct();
  var_0._id_9C83 = 2;
  var_0._id_1103 = 1;
  var_0._id_1128 = (0.859647, 0.926756, 1);
  var_0._id_1108 = (0.754224, 0.754224, 0.754224);
  var_0._id_110A = 0.3258;
  var_0._id_1109 = 0.592218;
  var_0._id_1106 = 1;
  var_0._id_1105 = 0.472503;
  var_0._id_1110 = 18.363;
  var_0._id_1107 = 127780;
  var_0._id_1126 = 176.675;
  var_0._id_1102 = 2.45955;
  var_0._id_1112 = 70760;
  var_0._id_1111 = 1;
  var_0._id_1114 = 40.7579;
  var_0._id_1113 = 425.773;
  var_0._id_1127 = (0.629852, -0.752156, 0.193774);
  var_0._id_110C = 1;
  var_0._id_110B = 5413.97;
  var_0._id_110D = 416.519;
  var_0._id_110E = 1860.54;
  var_0._id_110F = 0.307481;
  var_0._id_1104 = 1;
  var_0._id_10FF = 0;
  var_0._id_1100 = 1;
  var_0._id_1101 = 0;
  var_0._id_111F = 1;
  var_0._id_1115 = 2049.48;
  var_0._id_1116 = 12167.7;
  var_0._id_1117 = 30606.5;
  var_0._id_1120 = 0;
  var_0._id_111C = 0.0992995;
  var_0._id_111D = 0.707615;
  var_0._id_111E = 1;
  var_0._id_1122 = 1;
  var_0._id_1125 = 0;
  var_0._id_1123 = (0, 0, 0);
  var_0._id_111B = 0;
  var_0._id_1124 = 0;
  var_0._id_1118 = 0;
  var_0._id_1119 = 0;
  var_0._id_111A = 0;
  var_0._id_1121 = 0;
  level.island_fog_on = var_0;
}