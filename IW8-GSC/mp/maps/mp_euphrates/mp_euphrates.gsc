/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_euphrates\mp_euphrates.gsc
*************************************************/

main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  _startragdollwithvehiclefeature::keypad_check_levelinput();
  _start_spawn_modules::keypad_check_levelinput();
  _encstr_ADC637833682B8CFBBCF57CBDBD69930388A80D89AC78005D34BE5DBE31ADEFACDA23651433020BEBA0333C73773A6E09B7E3988EFC620F6B2::main();
  _encstr_A579369FF75BCB83FC527030BA9FD077D32FAFDBD3D185E0106CC389A3BD68985ADFB5D71FCB40384D4288E38E742BEE713705F9FA021EC0::main();
  _encstr_AC92318F42F2E083C82626A5B0D8A879B303683817FF45336BEB7B0AAC60BB98DDC27142BBB390D3D913C5AF07F710366AC72F::main();
  setDvar("_encstr_83920A488F414D730D6721C8", 3.5);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 512);
  scripts\mp\load::main();
  setDvar("_encstr_846619C2B76BE35FC67FE9F90BD89B0797F07225731F6381C9E8DF", 1);
  setDvar("_encstr_9A400AEB2390F1FD098F0AC5", 0);
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 0.5);
  setDvar("_encstr_994D0BE8B1B5B26797B05B5AD6", 2);
  setDvar("_encstr_B4F00B9C51C42D9CC43982265A", 4);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setDvar("_encstr_B6B020078D09C06067CB8B1183672DB0520DB5FF206E23B82780E038DB175E4BB577", 1);
  setDvar("_encstr_838A290EED417740C56308B847F3D9A169130886041A3108A7A3E8E8A33D73F3E23F611798418391910730", 4);
  setDvar("_encstr_95060BA9A2A045A57214A87A2D", 3);
  setDvar("_encstr_87F50B71398D854C077F1F1906", 3);
  setDvar("_encstr_843D0BF7516E708C19BFBAF5D7", 0.5);
  thread _id_12F8E();
  level thread player_exfil_struct();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_BD96191BED5BE016DC6EAF5B8538FADA387D2BD5380D9C85A3B26E", "_encstr_8FBE233AE03D9F4E80C94D42875895EF5F59B3A34E014FC209D350679BC09A0386F1BB4A53");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_121F5();
  var_0 = scripts\mp\utility\game::getgametype();

  if(var_0 == "_encstr_B807035284" || var_0 == "_encstr_B60703EACA") {
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_9A8507BA4040188D08";
    game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_8E8405EA382B2A";
  } else {
    game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  }

  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_837707192BE62BE4E8";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_837707192BE62BE4E8";
  level.modifiedspawnpoints["_encstr_AD2010A5C886996810C4A6701B02D2138DE0"]["_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A"]["_encstr_97FE07DE392D76D2CD"] = (-2260, 1592, -168);
  level.modifiedspawnpoints["_encstr_AD2010A5C886996810C4A6701B02D2138DE0"]["_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511"]["_encstr_97FE07DE392D76D2CD"] = (-2260, 1592, -168);
  level.modifiedspawnpoints["_encstr_B4AD10CDC322B31F6713BE82295F96099A1A"]["_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B"]["_encstr_97FE07DE392D76D2CD"] = (-2260, 1592, -168);
  level.modifiedspawnpoints["_encstr_A9FA10A9B27F5F7310EE8AD2DA28589387D8"]["_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0"]["_encstr_97FE07DE392D76D2CD"] = (-2260, 1592, -168);
  level.modifiedspawnpoints["_encstr_8C371051FA1A0BBDDECF522AD7F65333FA08"]["_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A"]["_encstr_97FE07DE392D76D2CD"] = (-2424, 1296, -158);
  level.modifiedspawnpoints["_encstr_8C371051FA1A0BBDDECF522AD7F65333FA08"]["_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511"]["_encstr_97FE07DE392D76D2CD"] = (-2424, 1296, -158);
  level.modifiedspawnpoints["_encstr_86191069C81AD81C4062C6701A4069C4B183"]["_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B"]["_encstr_97FE07DE392D76D2CD"] = (-2424, 1296, -158);
  level.modifiedspawnpoints["_encstr_AB86104B6486C6430413D81C0E08B4626CC1"]["_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0"]["_encstr_97FE07DE392D76D2CD"] = (-2424, 1296, -158);
  level.modifiedspawnpoints["_encstr_8778102E0A4B927FEEDB8CB2A386F949B7C2"]["_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A"]["_encstr_97FE07DE392D76D2CD"] = (-2176, 1448, -168);
  level.modifiedspawnpoints["_encstr_8778102E0A4B927FEEDB8CB2A386F949B7C2"]["_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511"]["_encstr_97FE07DE392D76D2CD"] = (-2176, 1448, -168);
  level.modifiedspawnpoints["_encstr_AB831076E33E7622B2DBF6FBBDDAAD36E40A"]["_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B"]["_encstr_97FE07DE392D76D2CD"] = (-2176, 1448, -168);
  level.modifiedspawnpoints["_encstr_AF01103A9A638B3946722C352A1E4B23CE0A"]["_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0"]["_encstr_97FE07DE392D76D2CD"] = (-2176, 1448, -168);
  level.modifiedspawnpoints["_encstr_9969100ED2A7325B62438472A1BE18739C82"]["_encstr_82591CB5837DC9ABD989CBAF9B0E16BB73FA0BC636D2956EF59B8E589C3A"]["_encstr_97FE07DE392D76D2CD"] = (-2408, 1056, -178);
  level.modifiedspawnpoints["_encstr_9969100ED2A7325B62438472A1BE18739C82"]["_encstr_812F1A60D28FC8EDBA9F0F117F7338E1492DC8783F0B7126F34F0511"]["_encstr_97FE07DE392D76D2CD"] = (-2408, 1056, -178);
  level.modifiedspawnpoints["_encstr_953B10E8A225618D0183FA7A6209FAD37B62"]["_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B"]["_encstr_97FE07DE392D76D2CD"] = (-2408, 1056, -178);
  level.modifiedspawnpoints["_encstr_91CD1078127B1F6F729F467ADDE15E4AEBBA"]["_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0"]["_encstr_97FE07DE392D76D2CD"] = (-2408, 1056, -178);
}

player_exfil_struct() {
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-4320, 2176, -160), 0, 576, 576);
  var_0.targetname = "_encstr_8A720C48B3AB7729A26778B853CB";
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

_id_12F8E() {
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
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2102, -1369, -134), (0, 153, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1050, 737, -249), (0, 228, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (314, -1340, -216), (0, 152, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (426, -1757, -178), (0, 149, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1339, -1759, -66), (0, 175, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2518, -3019, -14), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1384, 508, -170), (0, 326, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-1958, 730, -145), (0, 299, 0));
      level.modifiedspawnpoints["_encstr_B4410BD21AA22E16996DDA3299"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A5900BC70B50EF12125B27BBC2"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_87C50B6683C0C140694CE49168"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8D6A0B6626626C01A5CCCC4618"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_82010B1A5ABA05FA483704EC1B"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_84E70B82F6226B49D6726F73A8"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BA680BE6AA43A2CA218720201F"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BD4E0BED3EDB8F88B12A060662"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B4A80BCDE33AB27F6715BEAE35"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_A7F10B563B1E390E66E65E0890"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_AC140B95DF1A7316D7EBD7CF83"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_96450A2E325112EB317F9AAA"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_B85A0B4B994C46DC804689039C"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_978F0AFEB24F6AF2190D273B"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BA0608C24B0AA856E60B"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8ED60A991ECB9AE2D398F29F"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8BC00B4D07A26BEAF9530FC70B"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_BA3B09FFE6F279E343F01A"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_920D0AB327A1F7E8681A3E2A"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      level.modifiedspawnpoints["_encstr_8AE20AC5921D3EAD22194082"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (3876, -2624, -48), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (3504, -3028, -64), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (3808, -1924, -60), (0, 165, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (3116, -3320, -72), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2912, -2660, -40), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (2923, -2199, -72), (0, 150, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3928, 1800, -136), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3928, 2136, -136), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3720, 2536, -120), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3645, 1388, -144), (0, 44, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3475, 1013, -144), (0, 330, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3491, 821, -128), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3127, 2109, -112), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3314, 473, -144), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-160, -39, -256), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-560, -983, -240), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-384, -1744, -224), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (352, -984, -264), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (4103, -992, -72), (0, 180, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-3672, 808, -136), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (2509, -906, -168), (0, 165, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (2119, -1626, -172), (0, 150, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (2295, -1034, -196), (0, 150, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1906, -2101, -96), (0, 90, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1434, -1544, -108), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1575, -1490, -204), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (2645, -826, -224), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (2311, -1474, -180), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (2119, -1370, -188), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1320, 720, -208), (0, 225, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-720, 632, -212), (0, 330, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-1864, 1584, -188), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-2072, 1384, -188), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-2072, 656, -188), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-1504, 552, -188), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-1392, 360, -228), (0, 0, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-1017, -1194, -220), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-1928, 1376, -188), (0, 315, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-1136, 576, -212), (0, 360, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (3117, -1162, -144), (0, 195, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (1776, -1930, -100), (0, 135, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (3261, -1698, -56), (0, 195, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD", (-2144, -1277, -167), (0, 42, 0));
      break;
    case "_encstr_8218041DF5FA":
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (271, 631, 74), (0, 270, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (379, 149, 74), (0, 256, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (197, -1873, 74), (0, 110, 0));
      var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", (356, -1818, 74), (0, 82, 0));
      break;
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}

_id_121F5() {
  if(!isDefined(level.outofboundstriggers))
    level.outofboundstriggers = [];

  var_0 = [(-72, 200, 32), (-4044, 2360, -100)];

  foreach(var_2 in var_0) {
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, 128, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, 96, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
  }
}