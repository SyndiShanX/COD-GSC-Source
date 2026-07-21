/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_blitz.gsc
***********************************************/

init() {
  level.computer_animation_off = spawnStruct();
  var_0 = getdvarint("_encstr_A9991EDE0BA386B56DEA205861467BFB4FBC6D406487A8FB1091D8D87A9F5FDB", 0);
  var_1 = getdvarint("_encstr_A2991ECB508E676ABD2D432B99AACF4312395F51B3DA8D59C7D70B48A89F2F3F", 45);
  var_2 = getdvarint("_encstr_B1991E485FA2260D02E48D9271AA43CB1BDB70B1AB4D98C37B018513D522E75B", 20);
  var_3 = getdvarint("_encstr_AF991E961B1B272D6C5A53F07FE2181EE044452FB75D28FB7FF14482E02750D3", 20);
  var_4 = getdvarint("_encstr_8D991EA68603413DBC7C134D9F63689B971825E104CF608F139FEDA8519FC0EA", 15);
  var_5 = getdvarint("_encstr_8C991E371B39F59863961DF4BE6C5A9CC6632BBEC8CA6316F2BE8E5A5BACF563", 15);
  var_6 = getdvarint("_encstr_9A991E1F67DA1995F57B5CCD99076AE8B3C0DD09D1E3A5AAC019E540A55DA7CF", 10);
  var_7 = getdvarint("_encstr_8B991EDC369CD7981BD2474FFA6C9639B11B957D23566385BCD71D2D5BACBEE0", 5);
  var_8 = getdvarint("_encstr_A24A1E8F9E96B70129FF9BDA4F3824162ED02716E82A1522E9E71BBF35AF3909", 120);
  var_9 = getdvarint("_encstr_A94A1E371B9CAF8963B4E8A77DC69627B11BACBE6C637B9B56FAE8A5ADACD719", 200);
  var_10 = getdvarint("_encstr_BA4A1EF347105103B9B8DB0346066752C0319D57DF48E59FD596D33A686D87DA", 180);
  var_11 = getdvarint("_encstr_B64A1E53E01AB1826B13737AA81F3CEBE72837319EB2B0F63F4FFBD8B7356F0A", 140);
  var_12 = getdvarint("_encstr_A64A1E43F642C906FAE7A1A52752DBE8EB8D095E1EB490464257A98BC7DA086A", 110);
  var_13 = getdvarint("_encstr_954A1E37B14ED7981BB41DE9BE8D4B27C6C6ACEBD81BDBE62BFAE8D2DA95AF1B", 70);
  var_14 = getdvarint("_encstr_B44A1E2B9FC889EB514033DB6E3E3F3AA819B5BF3760CDE78DBE2B123005AF23", 50);
  var_15 = getdvarint("_encstr_864A1E6FEB1A794ECBE2E32AA9DFF3A8F64CDBBF93C5B00E3779FB7092BFA032", 90);

  switch (getdvarint("_encstr_A98E17C8132B690623539CA2498EC90EE753A79682FADA8790", 1)) {
    case 0:
      level.computer_animation_off.groundentity = [210, 90, 75, 60, 60, 45, 30, 10];
      level.computer_animation_off.ground_spawners = [270, 210, 170, 110, 70, 50, 50, 30];
      break;
    case 1:
      level.computer_animation_off.groundentity = [0, 45, 20, 20, 15, 15, 10, 5];
      level.computer_animation_off.ground_spawners = [120, 200, 180, 140, 110, 70, 50, 90];
      break;
    case 2:
      level.computer_animation_off.groundentity = [0, 45, 20, 20, 15, 15, 10, 5];
      level.computer_animation_off.ground_spawners = [120, 300, 230, 190, 120, 80, 60, 90];
      break;
    case 3:
      level.computer_animation_off.groundentity = [var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7];
      level.computer_animation_off.ground_spawners = [var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15];
      break;
  }

  level.decoyassists = ::groundz;
}

groundz() {
  level.br_level.br_circledelaytimes = level.computer_animation_off.groundentity;
  level.br_level.br_circleclosetimes = level.computer_animation_off.ground_spawners;
  level.br_level.default_player_connect_black_screen = [0, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.br_circleradii = [100000, 72500, 50000, 32500, 17500, 10000, 5000, 2000, 0];
  level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 6500, 5500, 5500];
}