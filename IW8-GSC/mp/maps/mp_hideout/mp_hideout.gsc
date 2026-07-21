/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_hideout\mp_hideout.gsc
***********************************************/

main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  _encstr_B4D233B9364EB438E86E796B83BCAD8583E65E6B1CEB0DA53295EDEA1D5EB507FA865A1956DE5747D7079359D82CC6D0B2B83B378D::main();
  _encstr_8B6A322E3EB680E81BFB88C16B2EA53327E320F72B4E53CBC263B783B3023409BBB6BF088191E1056D6503A3D191E2C596EF9AD8::main();
  _encstr_8E822DD7BF1383B8349AA8F8424718CF8B57F7630B29DB487C77A8F36BBFC0FF11A3F389F7721D68AF8F32A057CBF8::main();
  _encstr_8C6B33ABF20B0B38ABC3F77BE845E8C7AB6BA8902B6733B8C7AD6F73F4AD20176F72F839C2CFF588D18C6B5F682358D0276EB143CA::main();
  scripts\mp\load::main();
  setDvar("_encstr_A7341BF848750358B597CF3FC543279965B24AEF507891A0884BC32748", 1);
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_AF9C1707702D11C2073BE85B8918912840671494301F6FAFC5", "_encstr_86F8218DBD46D80BCDA32BC9AFD8DE6B07169BE6BEB558C1FAB6837D86D22359EDBAA3");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_9633091DA95FFA11C78DC8", 0.9);
  setDvar("_encstr_82BC0B6CF3A5694AD1CB999527", 5000);
  thread lb_pitch_roll_dmg_threshold("_encstr_81921431E7B360FE9B5F313363324D917D3F19885A59", "_encstr_B4F81A499FBB68F68357093B7B3AB5894537118052417925EA5F1317", "_encstr_83471E6F858FDBBBBBD7B3D046ACEF0FF80B505E78F3F81BD277578E072A1313");
  thread lb_pitch_roll_dmg_threshold("_encstr_AD9214633B56AB9A48B1CB9489D8D5912541FFD3395E", "_encstr_BD9F1AA355BB8DBD93D3E030EBA890C93D226FE6AA0A3FD84FE92A4E", "_encstr_B1DD1E9BC3BE43725099F3BC91B0AD891D69173B1146B95D23E1AF022E88E333");
  thread lb_pitch_roll_dmg_threshold("_encstr_82AF14B41B48CB136589AB62B131870F2BFF203709F2", "_encstr_A1271AD8AA22E94BDF732DAB4A8391C10F5230F8972A0761739FBD9E", "_encstr_A7E31E571D63F3A3C5A6750BC6FC1DC1F3D2483042626028404FAB8FF1C9822C");
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level thread managegate();
  level battle_tracks_vehicleoccupancyenter();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

managegate() {
  var_0 = getEnt("_encstr_910210BA835A239C714867CC7A90772C8DEB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 notsolid();
  waittillframeend;
  var_0 connectpaths();
  level waittill("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");

  if(!scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  level.scr_animtree["_encstr_A3460A8C2193E9F7550268C0"] = #animtree;
  level.scr_anim["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_88950636C6DE9B59"] = % _encstr_8DC9195BF0A9D84EF7FAA87242830DC9FF79E1338401D89927B3C1;
  level.scr_animname["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_88950636C6DE9B59"] = "_encstr_8DC9195BF0A9D84EF7FAA87242830DC9FF79E133A401D89927B3C1";
  level.scr_anim["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_ADB405071B8AE8"] = % _encstr_BD0A18933891E006BFA2E00A0ADB35013781390BDC49F04FF7AA;
  level.scr_animname["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_ADB405071B8AE8"] = "_encstr_BD0A18933891E006BFA2E00A0ADB35013781390BFC49F04FF7AA";
  level.scr_animtree["_encstr_AAA60B178003F5617D2B7FB48D"] = #animtree;
  level.scr_anim["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_88950636C6DE9B59"] = % _encstr_8AEE19D683BE47C90BB4DCBC2C9C23BEB385472B4E7DC6637B6EAC;
  level.scr_animname["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_88950636C6DE9B59"] = "_encstr_8AEE19D683BE47C90BB4DCBC2C9C23BEB385472B4A7DC6637B6EAC";
  level.scr_anim["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_ADB405071B8AE8"] = % _encstr_81F518D749E1FC635E9418C1DB6DA2B9A7B26350503F07E3D9B8;
  level.scr_animname["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_ADB405071B8AE8"] = "_encstr_81F518D749E1FC635E9418C1DB6DA2B9A7B26350513F07E3D9B8";
  var_1 = getEnt("_encstr_AA3B1041F518748398B1B2BA1BF0DB2FB079", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_ADC31109BD503CDBC0F98A72C3386BF48019AC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_9AE61160934E08F9E90FB8B062012FD0B167C0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1.animname = "_encstr_A3460A8C2193E9F7550268C0";
  var_1 scripts\common\anim::setanimtree();
  var_2.animname = "_encstr_AAA60B178003F5617D2B7FB48D";
  var_2 scripts\common\anim::setanimtree();
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "_encstr_ADB405071B8AE8");
  var_2 thread scripts\common\anim::anim_single_solo(var_2, "_encstr_ADB405071B8AE8");
  var_3 hide();
  var_4 = getEnt("_encstr_82C70A0F53B5DABAE1D1EF73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = getEnt("_encstr_9B9F0B075BADC2A219A8A76CE3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = getEntArray("_encstr_B8920E9D2C1DCA8CC4CA663A2496E837", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_8 in var_6)
  var_8 linkTo(var_4);

  var_10 = getEntArray("_encstr_8BCC0FC0EAE3CB434379A42B5C3B10A18A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_8 in var_10)
  var_8 linkTo(var_5);

  var_4.heli_isleaving = var_4.origin;
  var_13 = scripts\engine\utility::getStruct("_encstr_83F10EC7AFC9721AA418A393315B058A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4._id_1212B = var_13.origin;
  var_5.heli_isleaving = var_5.origin;
  var_14 = scripts\engine\utility::getStruct("_encstr_8B380F5FA920E55F5EA3F7C3B1E8435D58", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5._id_1212B = var_14.origin;
  var_15 = 4;
  var_16 = 8;
  var_5 moveTo(var_5._id_1212B, var_15, var_15 * 0.1, var_15 * 0.1);
  var_4 moveTo(var_4._id_1212B, var_15, var_15 * 0.1, var_15 * 0.1);
  level waittill("_encstr_8C7513227310552215EF8367D7B0AB9E40591D6B68");
  var_0 solid();
  waittillframeend;
  var_0 disconnectPaths();
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "_encstr_88950636C6DE9B59");
  var_2 thread scripts\common\anim::anim_single_solo(var_2, "_encstr_88950636C6DE9B59");
  var_17[0] = "_encstr_84850667C1A57264";
  var_17[1] = "_encstr_B61007BECA31606B23";
  var_18 = randomint(2);

  if(var_18 > 1)
    var_18 = 1;

  if(var_17[var_18] == "_encstr_84850667C1A57264") {} else {}

  wait 1.0;
  var_5 moveTo(var_5.heli_isleaving, var_16, var_16 * 0.1, var_16 * 0.1);
  var_4 moveTo(var_4.heli_isleaving, var_16, var_16 * 0.1, var_16 * 0.1);
  var_3 show();
}

lb_pitch_roll_dmg_threshold(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5;
  var_3 = getscriptablearray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = getEnt(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = getEnt(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 hide();

  if(isDefined(var_3) && isDefined(var_3[0])) {
    var_6 = var_3[0];
    var_7 = 1;

    while(var_7) {
      var_6 waittill("_encstr_937017E68D399638E816988DAC93BDE8B43396D82CD1A57BDC", var_8, var_9);

      switch (var_8) {
        case "_encstr_99220EEC59A15AD81B95EB91CA853AD0":
        case "_encstr_866307EDCD995AC9AC":
        case "_encstr_86390885FB5A76782D42":
          var_7 = 0;
          var_5 show();
          var_4 hide();
          return;
        case "_encstr_AF790FF05D41D931214052FCA0E06102C6":
          var_7 = 0;
          var_5 show();
          var_4 hide();
          return;
      }
    }
  }
}

battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_B60703EACA":
      if(isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 2) {
        level.modifiedspawnpoints["_encstr_8FC60B96D06253025A64239927"]["_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_99C30BB566731728A882DEC6A2"]["_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_9BED0B253FC3A3F6ED166A264B"]["_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_A6DA0BCE7B06C62E425509792B"]["_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_A1B00BFB9E880B715EA3C22E17"]["_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_93480B96236CA9409619264E89"]["_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_AA840B312A87CB99B55A1A1A9E"]["_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_AFF60B0693CF1ED68A8DC1C163"]["_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_9A9A0B66C3CB8211A5D61A5F4E"]["_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C"]["_encstr_A353071677FAF7EB45"] = 1;
        level.modifiedspawnpoints["_encstr_8FA00B267A97236A40C6E9E95F"]["_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C"]["_encstr_A353071677FAF7EB45"] = 1;
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C", (-389, -1455, 59), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C", (-456, -1439, 61), (0, 80, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C", (-535, -1423, 63), (0, 80, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C", (-593, -1410, 61), (0, 75, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C", (-355, -1503, 59), (0, 95, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C", (-421, -1504, 61), (0, 85, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C", (-499, -1496, 63), (0, 85, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C", (-587, -1484, 60), (0, 80, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C", (-371, -1574, 61), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C", (-438, -1577, 63), (0, 90, 0));
        break;
      }
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}