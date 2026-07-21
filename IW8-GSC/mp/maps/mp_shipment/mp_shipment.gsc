/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_shipment\mp_shipment.gsc
***********************************************/

main() {
  _start_rooftop_raid_heli::keypad_check_levelinput();
  level.music_style = "_encstr_BAFB08CA7376C616B932";
  _encstr_8D58357B7EAEA26339BBC80BEF6FC1DABF1A266818BF5BB888B9377F823B4A1D9171D763E138F7D58A5BE9E3FB1246D1276480FAC91B57::main();
  _encstr_8E4634CD6CE45A388E37BCD607795BC283DC5E5B0EF5B9A1D2E0B656E647CBB3AC9BE56BE0D7371A9607DAB2B9A3BE0B4EE85CB3DCD8::main();
  _encstr_B6D02F37B14E9683D1E6CBDA38CBB516389BBCAD38FA9B1A2D076BCAB9D15E6B38FAE61AD2385B56B9477D661E17B39B1B::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_8E3518C090EA7FB19B68AFEA7E91D7230F571FC05B2FAFBAA05B", "_encstr_A5252239482CCE66188B42A3816EB81AF31EFBB22142335861206BB79B446B70F0C96009");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = level _id_132AA();
  level.kill_border_triggers = scripts\engine\utility::array_combine(level.kill_border_triggers, var_0);
  scripts\cp_mp\utility\game_utility::_id_12B3B();
  setDvar("_encstr_A608184B8659D7AF3869CFE24B80FF03779922A28FACBF66088F", 1);
  setDvar("_encstr_BDCA1556B9AABB89088B69D8E75C04FD535FC05E8C8343", 1.33);
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 0.32);
  setDvar("_encstr_9A400AEB2390F1FD098F0AC5", 0);
  setDvar("_encstr_994D0BE8B1B5B26797B05B5AD6", 2);
  setDvar("_encstr_B4F00B9C51C42D9CC43982265A", 2);
  setDvar("_encstr_846619C2B76BE35FC67FE9F90BD89B0797F07225731F6381C9E8DF", 1);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 4);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 6);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level.usetdmspawns = 1;
  level.binoculars_clearuidata = 1;

  if(getdvarint("_encstr_B4191E9B8D93BE9BA15A83B556E61DD7DC1C2CEE37B5BDD9AC7D2BE6584C8DB2", 0) == 1)
    level thread binoculars_addtolosqueue();

  level battle_tracks_vehicleoccupancyenter();
  level.loadoutdefaultfiresalediscount = 1;
  level._id_133D1 = 1;
}

binoculars_addtolosqueue() {
  wait 1;

  if(level.teambased)
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8E12096F82A7C790AF9E01", "_encstr_829A0D0F1AF8FB5ED127855073F940");
}

battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_8E65062BD0CFB4EC":
    case "_encstr_8E9E088D9C58E65B2B19":
    case "_encstr_AAE507E8423F63C163":
    case "_encstr_85EF050CB150E7":
    case "_encstr_9A7205B39CB919":
    case "_encstr_A7290676E4D2378C":
    case "_encstr_959105B99040BD":
    case "_encstr_B41904BB8593":
    case "_encstr_9B0703CD93":
      level.modifiedspawnpoints["_encstr_995B0A6989132340C86C0CC1"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A35509913BEE09759B1FE2"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A95E094C1C86046463810E"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B1460922AF32818312E0CB"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8E6D0AD10B1725390AEAAAE2"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A1EF0AAA1AF57BF99723BF83"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AFAE0AD2B9868640646C811C"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A6370A5A1C6C0D0146B1136C"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A7D50A962783A108648D621B"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BE4F0A8ED3831916B1E25FC9"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_87F80A4B6C9AC64089D0891B"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BEFC0A93FFC862AF7E876BA3"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AABA0A3AC7583159A65B746B"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_84E50A7AD6248B4917F3EFF7"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_84DE099E8B55D21AC20B5A"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B4D5081B430498996A46"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AA7F0A150A3A15EE8ED2550A"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;

      if(getdvarint("_encstr_B4191E9B8D93BE9BA15A83B556E61DD7DC1C2CEE37B5BDD9AC7D2BE6584C8DB2", 0) == 1) {
        level.modifiedspawnpoints["_encstr_A1720AC6530ECA16AA5B080C"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_88FE0945D32EDE7A90628D"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_AABD0A3A679A3559AA58F36C"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_A9BD0AD6639ED206827D111E"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_A2980AA5EAAE0C4EEA8B97AF"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_A3760AD223A9B102269A7291"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_AF970AB9401F4CA9315F9BA2"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_B47F0A95DA4AECD6D6A91662"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_923A0AAE7D0C57309A83F2F8"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_AC170A95D13AB042DE4BD75F"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_A65409620D860164810760"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_867809CF9E0C2FDF32325A"]["_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318"]["_encstr_A353071677FAF7EB45"] = 1;
      }

      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-112, 2544, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-39, 2544, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (184, 2544, 40), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (312, 2556, 40), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-536, 2516.2, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-650.8, 2519.4, 40), (0, 255, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-828.6, 2541.5, 40), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-932.6, 2541.5, 40), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-560, 1464, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-656, 1480, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-784, 1472, 40), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-952, 1560, 40), (0, 30, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-55.2, 1343.4, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (114.1, 1342.6, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (208.1, 1348.6, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (307, 1338.6, 40), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (307, 1498, 40), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (324, 1680, 40), (0, 180, 0));
      break;
    case "_encstr_8218041DF5FA":
      level.modifiedspawnpoints["_encstr_995B0A6989132340C86C0CC1"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_ACEB0AE639544E68D2FB3A20"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A95E094C1C86046463810E"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B1460922AF32818312E0CB"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8E6D0AD10B1725390AEAAAE2"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A1EF0AAA1AF57BF99723BF83"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AFAE0AD2B9868640646C811C"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A6370A5A1C6C0D0146B1136C"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A7D50A962783A108648D621B"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BE4F0A8ED3831916B1E25FC9"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_87F80A4B6C9AC64089D0891B"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BEFC0A93FFC862AF7E876BA3"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AABA0A3AC7583159A65B746B"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_84E50A7AD6248B4917F3EFF7"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_84DE099E8B55D21AC20B5A"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B4D5081B430498996A46"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AA7F0A150A3A15EE8ED2550A"]["_encstr_92A00D235071922868E7FBEB2148FB"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-112, 2544, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-46, 2544, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (184, 2544, 40), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (312, 2556, 40), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-536, 2516.2, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-650.8, 2519.4, 40), (0, 255, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-755.6, 2479.6, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-828.6, 2541.5, 40), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-932.6, 2541.5, 40), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-560, 1464, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-656, 1480, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-784, 1472, 40), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-952, 1560, 40), (0, 30, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (-55.2, 1343.4, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (23.5, 1342, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (114.1, 1342.6, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (208.1, 1348.6, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_92A00D235071922868E7FBEB2148FB", (307, 1338.6, 40), (0, 135, 0));
      break;
    case "_encstr_8E1904B3F501":
      level.modifiedspawnpoints["_encstr_995B0A6989132340C86C0CC1"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_86830A56E31D0A8602F59090"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A95E094C1C86046463810E"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B1460922AF32818312E0CB"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8E6D0AD10B1725390AEAAAE2"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A1EF0AAA1AF57BF99723BF83"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AFAE0AD2B9868640646C811C"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A6370A5A1C6C0D0146B1136C"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A7D50A962783A108648D621B"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BE4F0A8ED3831916B1E25FC9"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_87F80A4B6C9AC64089D0891B"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BEFC0A93FFC862AF7E876BA3"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AABA0A3AC7583159A65B746B"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_84E50A7AD6248B4917F3EFF7"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_84DE099E8B55D21AC20B5A"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B4D5081B430498996A46"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AA7F0A150A3A15EE8ED2550A"]["_encstr_8EE60D40EB97564047873729A16BD8"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-112, 2544, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-35, 2544, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (184, 2544, 40), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (312, 2556, 40), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-536, 2516.2, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-650.8, 2519.4, 40), (0, 255, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-755.6, 2479.6, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-828.6, 2541.5, 40), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-932.6, 2541.5, 40), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-528, 1464, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-656, 1480, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-784, 1472, 40), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-984, 1560, 40), (0, 30, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (-55.2, 1343.4, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (23.5, 1342, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (114.1, 1342.6, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (208.1, 1348.6, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_8EE60D40EB97564047873729A16BD8", (307, 1338.6, 40), (0, 135, 0));
      break;
    case "_encstr_BDD705AD7BD143":
    case "_encstr_8E07030349":
      level.modifiedspawnpoints["_encstr_995B0A6989132340C86C0CC1"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_842A0A16FE4AA927366E2AAB"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A95E094C1C86046463810E"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B1460922AF32818312E0CB"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8E6D0AD10B1725390AEAAAE2"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A1EF0AAA1AF57BF99723BF83"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AFAE0AD2B9868640646C811C"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A6370A5A1C6C0D0146B1136C"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A7D50A962783A108648D621B"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BE4F0A8ED3831916B1E25FC9"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_87F80A4B6C9AC64089D0891B"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BEFC0A93FFC862AF7E876BA3"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_97480A9662DD8246DA3F5650"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_84E50A7AD6248B4917F3EFF7"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_84DE099E8B55D21AC20B5A"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B4D5081B430498996A46"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AA7F0A150A3A15EE8ED2550A"]["_encstr_97BF0EB607FADABD1DA1D76E8316BB9B"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-112, 2544, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-35, 2544, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (184, 2544, 40), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (312, 2556, 40), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-536, 2516.2, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-650.8, 2519.4, 40), (0, 255, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-755.6, 2479.6, 40), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-828.6, 2541.5, 40), (0, 300, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-932.6, 2541.5, 40), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-560, 1464, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-656, 1480, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-784, 1472, 40), (0, 60, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-952, 1560, 40), (0, 30, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (-55.2, 1343.4, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (23.5, 1342, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (114.1, 1342.6, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (208.1, 1348.6, 40), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", (307, 1338.6, 40), (0, 135, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}

_id_132AA() {
  var_0 = [];
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (5704, 1456, -176), 0, 24000, 25);
  var_0[var_0.size] = var_1;
  return var_0;
}