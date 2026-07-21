/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_wz_island\mp_wz_island.gsc
*************************************************/

main() {
  _encstr_BD9A379B6C9CD2071D6E975BC1976BC238CD79B538EBDDE9FAB46E1B0B9B32CB6B1CBEBB4F7D4B6E63B0E6C8EBC1932B8D58C634ACC5B36EB1::main();
  _encstr_83A036FFF716BA588073DD550B829DF2EF2F061F7928031AB118C21DC1A0DC6ECCABFB9EDBE749EFA0A67C2258A0EE12883B034B358433B3::main();
  _encstr_8A15311BD62BC742B1C8BE92B86F7D9F0346DF8DF75677083F2063FA28D5F76E18AF272F0AFE57127188BA72F12DA832B19663::main();
  _encstr_993337BFD77BEBE01CB290D09ABFF017B30F8F3B33F1ACF81F0C0308C6D6F078DAEBF78763597B687466A801618C4084E243132DBFB6342093::main();
  scripts\cp_mp\utility\game_utility::_id_12B26();
  level._encstr_B46C21E108B199271B7BD59877BA4829DF2B3973757A037B9D0FABB60FC940DDF56026 = ::play_nag_players_hvt_callouts;
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("_encstr_A3C21936EDB50716CD6EAF5BC21CD7AD0EAFEE9EFA96CDC658E6C8", undefined, 16);
  level thread scripts\engine\scriptable_door::system_init();
  level thread _encstr_8D572A7B7EAEA26339BBC80BEF6FC4DA319F4BC818CB5B50E9BDFF7EF297181EB77DDB60FC2D8BDE8E178881::init();
  level thread _encstr_A99F256E1B4EB4C1E8E697DA38CBB30BD6AC3ABC0E569B7931E4BE5BC2E0865ACD1DB917B3DCB1::init();
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_8C6A0AAFE187993125FC3337", 1.0);
  setDvar("_encstr_B8BC0A9479731E693A7ABB81", 1);

  if(!isDefined(game["_encstr_991C0AB9ED5B57161FE89B83"]))
    game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_8E8405EA382B2A";

  if(!isDefined(game["_encstr_B6A70A23CA6659DC91CAE4DC"]))
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_9A8507BA4040188D08";

  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level thread _id_12F90();
  level.flashpoint_usebigmapsettings = 1;
  level.c130spacing_usebigmapsettings = 1;
  level.groundspawning_usebigmapsettings = 1;
  level.mapsafecorners = [];
  level.mapsafecorners[0] = (43079, 41673, 200);
  level.mapsafecorners[1] = (-28589, -34322, 430);

  if(getdvarint("_encstr_8FC913B98DE4F526E4BEF6AB8E7A9984ED573746E6", 1) != 0) {
    level._id_12165 = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    _encstr_8D511FB3E35F83E09AAB7932112FC1C8534B6DCDA230AB5D485383858738A75022();
    level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  var_0 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB";

  if(var_0) {
    if(getdvarint("_encstr_B2672462E6939F397B1FE7D7AFA36FD1A670B01DCFD0891638CAC2FB697845DC45A0DA54E9B2", 0) == 1)
      level.decoyassists = ::groundz;

    brinit();
    level._id_12056 = ::_id_12056;
    last_weapon_fired_time();
  }

  scripts\cp_mp\utility\game_utility::registerlargemap();
  _encstr_B8AB0D7B133A9560D72569418E94E0();

  if(var_0 && getdvarint("_encstr_83A5159B36E4AF4C93FA435A91CAAF33F0FACD16D62BB9", 0) == 0)
    level thread logequipmentuse();

  level.disable_oob_immunity_on_riders = 1;
  level thread _encstr_B19133DC8DC9961CD1CD5E5B1CF2B5851CB9F2B51C7DDD3DF5A5E61BC2B9C8F2DA07AF77F47D5ACDB185DC23BEEAD12D368B766E6C::_id_1326B();
  var_1 = getdvarint("_encstr_9A0E22D05EF26F8AA2EE6389D6EEB009F430C143522F281BE661CB9589517EB9AB29F0EF", 0);

  if(var_1 > 0)
    level thread _id_13AF0(var_1);

  var_2 = getdvarint("_encstr_BA6322EB26DBEF166D795A3391874ACFD3187F79C806171E55D0832BA9F38587A9F1CDEC", 0);

  if(var_2 > 0)
    level thread _id_13AEF(var_2);

  level.br_latejoininfilready = getdvarint("_encstr_AB8F2473297E37D6C0E7010195F89D17A801498A71DED7CFD18D2D1E4FA3E467C039F2C2FB2B", 0);

  if(level.br_latejoininfilready) {
    level.delete_script_object = [];
    level._id_12864 = [];
    level.prematchspawnoriginsforteams = undefined;
    level.delete_script_object = [_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-17471, -17362, 5000), 0, 1100), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-24676, -22933, 5000), 0, 1100)];
    level.prematchspawnorigins = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::getprematchlocationspawnorigins();

    for(var_3 = 0; var_3 < level.delete_script_object.size; var_3++)
      level._id_12864[level._id_12864.size] = 0;
  }

  setdvarifuninitialized("_encstr_8B380D5AE910DF5A4ECFB3F7BDF612", "_encstr_BD1904CF572A");

  if(getDvar("_encstr_8B380D5AE910DF5A4ECFB3F7BDF612") == "_encstr_B8330708F7A1DAABA8") {
    setdvarifuninitialized("_encstr_AA8D178EEE138F01449360A8777659394A16891D492AB3C920", 1);
    setdvarifuninitialized("_encstr_82AC1C8231C807427991FFE78F1C4A784899FD8F2E10C1BAD885F7EBD3C6", 1);
    setdvarifuninitialized("_encstr_A1C2169E4BE3C6F32DFA38F0A1C3A37827F3A91D9F576B15", 1);
    setdvarifuninitialized("_encstr_B63C1ED6B64BD7490CEB28F03F4E81F182DEC15501F273D3EFCFA1E0E365990F", 1);
    setdvarifuninitialized("_encstr_91E61EB96CE47D168D8D7BDDBECEB21AD236362BD78D2D47A31BCAFA4C2D4EC8", 1);
    setdvarifuninitialized("_encstr_8FD01DCDB14EF5B0B1B1BDBBD73BCAA1A536C6CAD7DAF6A37B39D85E368DCA", 1);
    setdvarifuninitialized("_encstr_837E230AB9408FDAF119076F17A4C2E030014517D63079235C07BF7B75CD6A2BD96BBB1AAB", 0);
    setdvarifuninitialized("_encstr_BD3526CD3639FA0BC6D8BDEE7D67B21A966C1B56BE8D2CE4B3F6D7A3E457C6B5D7DC5DCD1CAF8558", 0);
    setdvarifuninitialized("_encstr_84371C0AB9408FDAF119076F17A4C2E030014517D6506852D8676B3F5B4F", 0);
    setdvarifuninitialized("_encstr_82B11CA31740015FE9681A83163C870460FF243DD7C8D70318E1F7FFD91D", 1);
    setdvarifuninitialized("_encstr_A71819F05AF2CF59CBEC3034C77B01699CE280D8F18BE3302F0A45", 0);
    setdvarifuninitialized("_encstr_A56E13EBAFD915984AA2E9C38A3F4040921B797B53", 1);
  } else {
    setdvarifuninitialized("_encstr_AA8D178EEE138F01449360A8777659394A16891D492AB3C920", 0);
    setdvarifuninitialized("_encstr_82AC1C8231C807427991FFE78F1C4A784899FD8F2E10C1BAD885F7EBD3C6", 0);
    setdvarifuninitialized("_encstr_A1C2169E4BE3C6F32DFA38F0A1C3A37827F3A91D9F576B15", 0);
    setdvarifuninitialized("_encstr_B63C1ED6B64BD7490CEB28F03F4E81F182DEC15501F273D3EFCFA1E0E365990F", 0);
    setdvarifuninitialized("_encstr_91E61EB96CE47D168D8D7BDDBECEB21AD236362BD78D2D47A31BCAFA4C2D4EC8", 0);
    setdvarifuninitialized("_encstr_8FD01DCDB14EF5B0B1B1BDBBD73BCAA1A536C6CAD7DAF6A37B39D85E368DCA", 0);
    setdvarifuninitialized("_encstr_837E230AB9408FDAF119076F17A4C2E030014517D63079235C07BF7B75CD6A2BD96BBB1AAB", 1);
    setdvarifuninitialized("_encstr_BD3526CD3639FA0BC6D8BDEE7D67B21A966C1B56BE8D2CE4B3F6D7A3E457C6B5D7DC5DCD1CAF8558", 1);
    setdvarifuninitialized("_encstr_84371C0AB9408FDAF119076F17A4C2E030014517D6506852D8676B3F5B4F", 1);
    setdvarifuninitialized("_encstr_82B11CA31740015FE9681A83163C870460FF243DD7C8D70318E1F7FFD91D", 1);
    setdvarifuninitialized("_encstr_A71819F05AF2CF59CBEC3034C77B01699CE280D8F18BE3302F0A45", 1);
    setdvarifuninitialized("_encstr_A56E13EBAFD915984AA2E9C38A3F4040921B797B53", 1);
  }

  level thread scripts\cp_mp\utility\scriptable_door_utility::arenaballs();
  level thread _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::init();
  level thread _encstr_B61624E6867B8B5B24873A50F307F1D3D2AFDD6BDAE247681AABB108A76E69176AD678FCF23A::unuseweapon();
  _calloutmarkerping_scriptableisusable::init();
  _computerrebootsequence_start::init();

  if(getdvarint("_encstr_ABAF14CD3693BE773D999118AF854B7D2B6759E6D16E", 0) == 1) {
    _testing_ending::teamplunderexfiltimer();
    ac130_flight_path::registerscriptedagent();
    level thread _tryusehoverjetfromstructinternal::bot_allowed_to_try_last_loadout();
  }

  if(getdvarint("_encstr_9B1D1AD397CB68D31316D2CA63275281EBB0C0BB9F8D9EF78BF2C513", 0) == 1)
    level thread scripts\mp\subway\fast_travel_subway_car::init();

  if(getdvarint("_encstr_9A0E1BD05EF26F8AA2EE6B9FD0E1B3ABFFE04C40522F98166F6A481D47", 0) == 1) {
    _testing_ending::teamplunderexfiltimer();
    ac130_flight_path::registerscriptedagent();
    _encstr_8F9B2D92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FE798ADADA3F3276789C879D29A2010CF3A90BB63::_encstr_862B100468B3230C8008CF4F28B9D43A67F0();
  }

  level thread _encstr_8E931D26EBE6B4C3BBA34F6B727E29FF2BCA556A5B776F6E34A9BBD017C84F::init();
  setdvarifuninitialized("_encstr_8E2E133B10EDD1DFB258849A6F78B7E76DA8B24258", 0);

  if(getdvarint("_encstr_97A91CFF760E87D3BBA528BA521F174A63E10ADC4F02790621FB126F4052", 1) == 1)
    level thread _encstr_B19133DC8DC9961CD1CD5E5B1CF2B5851CB9F2B51C7DDD3DF5A5E61BC2B9C8F2DA07AF77F47D5ACDB185DC23BEEAD12D368B766E6C::_id_14510();

  level thread _encstr_93FD2A1B30CD7CE393AE3F65C71077860BE8F333104BB2E609164767504023CFA5A11A4B880FEF5BA8F4539B::init();
  level thread _encstr_A6C811DCACD1EAC1B9B5BDB52BC6DE36D5D6CD();
  level thread _encstr_A57115FB93BA158057252961CD0FD8C3B3377F6D0F82DD();
  level thread _encstr_8BE61D036B42EDA08CBEA3D8E76DA0AB1B9F9785A72AB5D8CE97ABB34C5460();
  lastascenderusetime();

  if(getdvarint("_encstr_9B94206E6C27FA4BCDC6C2B9917D632CCEB0EB8E9396ECD9564E9BAF59E62C988D95", 1) == 1)
    level thread _encstr_8F9B2D92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FE798ADADA3F3276789C879D29A2010CF3A90BB63::_encstr_A60B125BC155A76A1843FEF17130F4277479C3C3();
}

_encstr_B42B145BA4A027B5EC23E89932607261872B984ACF96(var_0, var_1) {
  if(!isDefined(level._encstr_8EB41B8F237F8AC228802363E8C0B1D2294DD2029FAFB21B31581F4758[var_0]))
    level._encstr_8EB41B8F237F8AC228802363E8C0B1D2294DD2029FAFB21B31581F4758[var_0] = [];

  var_2 = level._encstr_8EB41B8F237F8AC228802363E8C0B1D2294DD2029FAFB21B31581F4758[var_0].size;
  level._encstr_8EB41B8F237F8AC228802363E8C0B1D2294DD2029FAFB21B31581F4758[var_0][var_2] = var_1;
}

_encstr_8D511FB3E35F83E09AAB7932112FC1C8534B6DCDA230AB5D485383858738A75022() {
  if(getdvarint("_encstr_A3BA2743F642C9061B3FA99BDFD2C0F8E7CC4E589BAC91CC3097AB85E3BB089889E5905383E9A3766A", 0) == 0)
    _id_13679((7200, 11850, -2000), 1500, 4000, 1);
}

_id_13679(var_0, var_1, var_2, var_3) {
  if(getdvarint("_encstr_A7DD1A0F078649DA20467A82B930EE80C0DD679FF1213387904B768C", 0) == 1) {
    return;
  }
  if(!isDefined(level._id_12166))
    level._id_12166 = [];

  var_4 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, var_1, var_2);
  var_4.targetname = "_encstr_8A720C48B3AB7729A26778B853CB";
  var_4.radius = var_1;
  level._id_12166[level._id_12166.size] = var_4;

  if(istrue(var_3)) {
    if(!isDefined(level._encstr_B4101A538B0FDB1DE5AABB80D567B52D7D8648274450533777FF0EDB))
      level._encstr_B4101A538B0FDB1DE5AABB80D567B52D7D8648274450533777FF0EDB = [];

    level._encstr_B4101A538B0FDB1DE5AABB80D567B52D7D8648274450533777FF0EDB[level._encstr_B4101A538B0FDB1DE5AABB80D567B52D7D8648274450533777FF0EDB.size] = var_4;
  }
}

play_nag_players_hvt_callouts(var_0, var_1) {
  if(!getdvarint("_encstr_952B1CE6867BE71B35FF3888A77751D34221DFE19E526B660BA34088A373", 1)) {
    return;
  }
  if(!isDefined(level._encstr_8EB41B8F237F8AC228802363E8C0B1D2294DD2029FAFB21B31581F4758)) {
    level._encstr_8EB41B8F237F8AC228802363E8C0B1D2294DD2029FAFB21B31581F4758 = [];
    _encstr_B42B145BA4A027B5EC23E89932607261872B984ACF96("_encstr_BDC80A5437EAD749519A6068", (16807.7, -30381.7, 5585.12));
  }

  var_2 = level._encstr_8EB41B8F237F8AC228802363E8C0B1D2294DD2029FAFB21B31581F4758[var_0];

  if(isDefined(var_2)) {
    var_3 = [];
    var_4 = squared(12.0);

    foreach(var_6 in var_1) {
      var_7 = 0;

      if(isDefined(var_6.origin)) {
        foreach(var_9 in var_2) {
          if(distancesquared(var_9, var_6.origin) < var_4)
            var_7 = 1;
        }
      }

      if(var_7) {
        continue;
      }
      var_3[var_3.size] = var_6;
    }

    return var_3;
  }

  return var_1;
}

last_weapon_fired_time() {
  if(getdvarint("_encstr_AAE41D38923A17E17BE78D75BC4F6B3B293B6080DA57DFD93FC98DF58DCB73", 1) == 0) {
    return;
  }
  var_0 = getEntArray("_encstr_BEEF1AFB41D0C71B9D46834A6BF84B3190D37E458F680DCF451BFAE3", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_2 in var_0)
  var_2 delete();
}

lastascenderusetime() {
  if(getdvarint("_encstr_8E041C976EF2B6FBCEEFF03380F38BB1373821D5F3A7ABF84D37349DA4EA", 1)) {
    var_0 = getEntArray("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_AC110A7F14873B5B3D073009");

    foreach(var_2 in var_0) {
      if(isDefined(var_2.model)) {
        switch (var_2.model) {
          case "_encstr_ACC42CE1DBB3344123114153606AF3B70A7893EAA545F2377353A7D27FF025C0BCE36801678F7988BBAC50276252":
          case "_encstr_919F2D89AE2DB191EAC1F5C8A5271DEB0EB116CDA3CA93EB8189AF3323F5599B8CE0A5B2B195BE4E2DEC1A8EBE9964":
          case "_encstr_B4451B4D631FF1194B0827B183CB6DE9907B9F37A3B7E67781FF07AECB":
          case "_encstr_8F0B15A81A190BB847BFD45D968FA1A7BA626870917AED":
          case "_encstr_A30B15BB779951DC10A92CE5765AA5B1BA87C715B99F23":
            lastapproachinstruct(var_2);
            break;
          default:
            break;
        }
      }
    }
  }

  if(getdvarint("_encstr_844822DCC639F5134EAF46B2D82B1DAC7D6E1B93D21C47FA98E4AB9BD0BEB6DE192BB19B", 1)) {
    var_4 = getEntArray("_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C", "_encstr_AC110A7F14873B5B3D073009");

    foreach(var_2 in var_4) {
      if(!isDefined(var_2.targetname) && !isDefined(var_2.script_noteworthy) && !isDefined(var_2.script_linkname))
        lastapproachinstruct(var_2);
    }
  }
}

lastapproachinstruct(var_0) {
  var_0 delete();
}

_id_13AF0(var_0) {
  if(var_0 == 1) {
    level._id_1217D = [];
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-29968, -27286, 970), (0, 315, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-30175, -28169, 980), (0, 7, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-29015, -26309, 965), (0, 342, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-25294, -26515, 960), (0, 76, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-28066, -25367, 970), (0, 311, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-15512, -17501, 1000), (0, 165, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-27171, -28550, 980), (0, 79, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-22806, -24406, 980), (0, 61, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-18698, -20588, 980), (0, 184, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-19435, -17604, 960), (0, 237, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((12532, 16142, 9385), (0, 8, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-2035, 10825, 3846), (0, 82, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((16733, -30340, 5574), (0, 35, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((44514, 43533, 257), (0, 301, 0));
  } else if(var_0 == 2) {
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-2053, 10406, 3846), (0, 84, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((16733, -30340, 5574), (0, 35, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-25294, -26515, 960), (0, 76, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-27534, -28757, 980), (0, 69, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-15512, -17501, 1000), (0, 165, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((-22806, -24406, 980), (0, 61, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((12532, 16142, 9385), (0, 8, 0));
    level._id_1217D[level._id_1217D.size] = init_relic_laststand((44514, 43533, 257), (0, 301, 0));
  }
}

_id_13AEF(var_0) {
  if(var_0 == 1) {
    level._id_1218A = [];
    level._id_1218A[level._id_1218A.size] = init_reach_wind_room((-30276, -29396, 980), (0, 45, 0));
    level._id_1218A[level._id_1218A.size] = init_reach_wind_room((-29981, -30330, 994), (0, 47, 0));
    level._id_1218A[level._id_1218A.size] = init_reach_wind_room((-14423, -14554, 975), (0, 222, 0));
    level._id_1218A[level._id_1218A.size] = init_reach_wind_room((-15479, -14382, 975), (0, 235, 0));
    level._id_1218A[level._id_1218A.size] = init_reach_wind_room((-22591, -20810, 980), (0, 23, 0));
    level._id_1218A[level._id_1218A.size] = init_reach_wind_room((-20066, -21723, 980), (0, 69, 0));
  } else if(var_0 == 2) {
    level._id_1218A = [];
    level._id_1218A[level._id_1218A.size] = init_reach_wind_room((-30055, -30266, 994), (0, 47, 0));
    level._id_1218A[level._id_1218A.size] = init_reach_wind_room((-14865, -14223, 980), (0, 225, 0));
    level._id_1218A[level._id_1218A.size] = init_reach_wind_room((-22591, -20810, 980), (0, 23, 0));
  }
}

init_relic_laststand(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;

  if(isDefined(var_1))
    var_2.angles = var_1;
  else
    var_2.angles = (0, 0, 0);

  var_2.targetname = "_encstr_BDC80A5437EAD749519A6068";
  return var_2;
}

init_reach_wind_room(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;

  if(isDefined(var_1))
    var_2.angles = var_1;
  else
    var_2.angles = (0, 0, 0);

  var_2.targetname = "_encstr_83F40783ADF1D14AA3";
  return var_2;
}

brinit() {
  level.br_level = spawnStruct();
  level.br_level.br_corners = [];
  level.br_level.br_corners[0] = (44259, -45371, 353);
  level.br_level.br_corners[1] = (-31516, 33428, 644);
  var_0 = scripts\mp\utility\game::round_vehicle_logic();
  var_1 = 19000;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    var_2 = -1;
    level thread init_locations();

    if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9")
      var_2 = getdvarint("_encstr_A1FF1B9B1B93EB32B53D7DB1C499064259B43B1A47F4EC9593E44B8C56", 18000);
    else
      var_2 = getdvarint("_encstr_A1FF1B9B1B93EB32B53D7DB1C499064259B43B1A47F4EC9593E44B8C56", -1);

    if(var_2 != -1)
      var_1 = var_2;

    if(var_0 == "_encstr_A254085207A6B7334B5A" || var_0 == "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8" || var_0 == "_encstr_AD300C932B4C969CD1D0AF911346" || var_0 == "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95")
      level.br_level.c130_speedoverride = 3500;
  }

  _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::setc130heightoverrides(var_1, 150);
  var_3 = getdvarfloat("_encstr_A12123274FE368F8A5CD500E7697A8385AE787AFD77A49B8F7E5DB06DB5AC1E34323730D63", 0.98);
  var_4 = level.mapcorners[0].origin[0] * var_3;
  var_5 = level.mapcorners[1].origin[0] * var_3;
  var_6 = level.mapcorners[1].origin[1] * var_3;
  var_7 = level.mapcorners[0].origin[1] * var_3;
  level.br_level.delay_set_bomber_traversals = [];
  level.br_level.delay_set_bomber_traversals[0] = (var_5, var_7, 0);
  level.br_level.delay_set_bomber_traversals[1] = (var_4, var_6, 0);
  var_3 = getdvarfloat("_encstr_A3131EDBF60BE1E280C7CE391899F3E1AF028B8E394BAFF78239B847FD20E8A8", 0.9);
  var_4 = level.mapcorners[0].origin[0] * var_3;
  var_5 = level.mapcorners[1].origin[0] * var_3;
  var_6 = level.mapcorners[1].origin[1] * var_3;
  var_7 = level.mapcorners[0].origin[1] * var_3;
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (var_5, var_7, 0);
  level.br_level.br_mapbounds[1] = (var_4, var_6, 0);
  level.br_level.br_mapcenter = ((var_4 + var_5) / 2, (var_6 + var_7) / 2, 0);
  level.br_level.br_mapsize = (abs(var_5 - var_4), abs(var_7 - var_6), abs(level.br_level.c130_heightoverride - level.br_level.c130_sealeveloverride));
  level.br_level._id_11A5B = -312;
  level.br_level.spawn_exfil_enemies = 10353;
  level.br_level.br_circleclosetimes = [270, 220, 170, 110, 70, 50, 50, 100];
  level.br_level.br_circledelaytimes = [220, 90, 75, 60, 60, 45, 30, 0];
  level.br_level.default_player_connect_black_screen = [220, 0, 0, 0, 0, 0, 0, 0];
  var_8 = getDvar("_encstr_8B380D5AE910DF5A4ECFB3F7BDF612", "_encstr_B40101");

  if(var_8 == "_encstr_B8330708F7A1DAABA8") {
    level.br_level.br_circleclosetimes = [270, 220, 170, 140, 110, 100, 90, 100];
    level.br_level.br_circledelaytimes = [150, 60, 60, 45, 45, 30, 30, 0];
    level.br_level.default_player_connect_black_screen = [150, 0, 0, 0, 0, 0, 0, 0];
  } else if(var_8 == "_encstr_BD1904CF572A") {
    level.br_level.br_circleclosetimes = [270, 140, 130, 110, 110, 80, 80, 70];
    level.br_level.br_circledelaytimes = [210, 90, 60, 60, 30, 30, 30, 30];
    level.br_level.default_player_connect_black_screen = [210, 0, 0, 0, 0, 0, 0, 0];
  }

  if(var_0 == "_encstr_A254085207A6B7334B5A" || var_0 == "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8" || var_0 == "_encstr_AD300C932B4C969CD1D0AF911346" || var_0 == "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95") {
    if(getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0) != 0) {
      level.br_level.br_circleclosetimes = [1, 90, 75, 60, 60, 30, 30];
      level.br_level.br_circledelaytimes = [1, 150, 120, 75, 60, 30, 0];
      level.br_level.default_player_connect_black_screen = [1, 0, 0, 0, 0, 0, 0];
    } else {
      level.br_level.br_circleclosetimes = [180, 200, 160, 105, 50, 30, 25];
      level.br_level.br_circledelaytimes = [1, 60, 60, 60, 45, 30, 0];
      level.br_level.default_player_connect_black_screen = [1, 0, 0, 0, 0, 0, 0];
    }
  } else if(var_0 == "_encstr_87A205AF50D049") {
    level.br_level.br_circleclosetimes = [1, 200, 130, 90, 50, 100];
    level.br_level.br_circledelaytimes = [1, 120, 75, 60, 45, 0];
    level.br_level.default_player_connect_black_screen = [1, 0, 0, 0, 0, 0];
  }

  level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.br_circleminimapradii = [10500, 10500, 10500, 10500, 10500, 9000, 8000, 5500];
  level.br_level.br_circleradii = [81600, 57300, 37500, 22200, 12300, 6000, 3000, 1500, 0];

  if(var_8 == "_encstr_B8330708F7A1DAABA8")
    level.br_level.br_circleradii = [81600, 57300, 37500, 22200, 12300, 6000, 3000, 1500, 0];
  else if(var_8 == "_encstr_BD1904CF572A")
    level.br_level.br_circleradii = [80000, 65000, 50000, 35000, 20000, 10000, 5000, 2000, 0];

  if(var_0 == "_encstr_A254085207A6B7334B5A" || var_0 == "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8" || var_0 == "_encstr_AD300C932B4C969CD1D0AF911346" || var_0 == "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95") {
    level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 10500, 9000, 8000, 5500];

    if(getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0) != 0)
      level.br_level.br_circleradii = [32000, 21000, 14000, 9000, 4500, 2000, 500, 0];
    else
      level.br_level.br_circleradii = [70000, 50000, 27000, 12000, 5000, 1500, 0];
  } else if(var_0 == "_encstr_87A205AF50D049") {
    level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 5500];
    var_9 = getdvarint("_encstr_9B601A9B2F78397BCE5092EA38B0A76CD0970C153F08FF6BF5C81A62", 0);

    if(var_9 == 1)
      level.br_level.br_circleradii = [75000, 45000, 20000, 7000, 3500, 1500, 0];
    else
      level.br_level.br_circleradii = [60000, 30000, 15000, 7000, 3500, 1500, 0];
  }

  if(isDefined(level.decoyassists))
    [[level.decoyassists]]();

  _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::cacheentity();
  level.delete_script_object = [_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-22000, 45000, 386), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((14000, 50000, 386), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((43000, 39000, 386), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-41800, 11300, 1000), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-38000, 23800, 1000), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-7000, 15000, 2000), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((11800, 13000, 8615), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((45000, 20000, 386), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-42000, -17000, 386), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-21000, -24000, 1000), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((9000, -11000, 2000), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((44600, -22000, 350), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-9000, -37000, 2000), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((21000, -50000, 500), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((40000, -42000, 350), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-27595, 5273, 4000), 0, 6000)];
  level.debug_vault_assault_retrieve_saw_obj_start = [_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::init_safehouse_gunshop((-48230, 44787, 0), 18000), _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::init_safehouse_gunshop((-44417, -43743, 0), 18000)];

  if(getdvarint("_encstr_B2E919B0A75ACEE53BC1393DA5010171B10F985907EE419D827725", 0))
    level thread _encstr_B8380BD328297B5AD72347FE9A();
}

_id_12056() {
  if(!_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11A5C()) {
    return;
  }
  if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_87A205AF50D049") {
    level.br_level.br_circleradii = [57000, 27500, 12500, 6500, 3000, 1250, 0];
    level.br_level.br_circleclosetimes = [1, 190, 120, 80, 40, 90];
    level.br_level.br_circledelaytimes = [1, 110, 65, 50, 35, 0];
  } else {
    level.br_level.br_circleradii = [81000, 50000, 30000, 15000, 7500, 3750, 1500, 0];
    level.br_level.br_circleclosetimes = [270, 180, 150, 60, 60, 45, 90];
    level.br_level.br_circledelaytimes = [210, 60, 60, 60, 45, 30, 0];
  }

  _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::cacheentity();
}

_encstr_848C160FA3C8B6CFC033C2BB5928632FA023899EF568BDAF(var_0, var_1, var_2) {
  var_3 = int(tablelookupbyrow(var_0, var_1, var_2));
  var_4 = int(tablelookupbyrow(var_0, var_1, var_2 + 1));
  var_5 = int(tablelookupbyrow(var_0, var_1, var_2 + 2));
  return (var_3, var_4, var_5);
}

_encstr_9948105A2BC1FEA790217F7DC5D853C71BC3(var_0, var_1) {
  if(isDefined(var_0._encstr_BD340BA5E6322BC326F2C9CA99[var_1]))
    return var_0._encstr_BD340BA5E6322BC326F2C9CA99[var_1];

  return -1;
}

_encstr_A78B114CD52D631936588DC6BD5747912C1D85() {
  var_0 = "_encstr_A5512A10BB0601B8B2F7675BFC9D7BD5B363A098236F443801A94F4919C5608887FA40207ABF7DB875BB5765";
  var_1 = 0;
  var_2 = 1;
  var_3 = spawnStruct();
  var_3._encstr_BD340BA5E6322BC326F2C9CA99 = [];

  for(var_4 = 0; var_4 < tablelookupgetnumrows(var_0); var_4++) {
    var_5 = int(tablelookupbyrow(var_0, var_4, var_1));
    var_6 = tablelookupbyrow(var_0, var_4, var_2);
    var_3._encstr_BD340BA5E6322BC326F2C9CA99[var_6] = var_5;
  }

  return var_3;
}

_encstr_BABD0FC4D55A638C66635EA53723C2E8C2() {
  var_0 = "_encstr_87222CBDDFB73A91FB018F8F70904763A9F69535472FD3C226A837A320880489558188A420A54AED09504A97D8A3";
  var_1 = getDvar("_encstr_8410184CE4AFEED3FA5AE6D858B9C8BE33D85EA57337C2B659E6", var_0);

  if(var_1 == "_encstr_B40101")
    var_1 = var_0;

  var_2 = 0;
  var_3 = 1;
  var_4 = 2;
  var_5 = 3;
  var_6 = 4;
  level.player_waitforlanded = spawnStruct();
  level.player_waitforlanded.data = [];
  level.player_waitforlanded._id_14729 = [];
  level.player_waitforlanded._id_127D9 = [];
  var_7 = "_encstr_B40101";

  for(var_8 = 0; var_8 < tablelookupgetnumrows(var_1); var_8++) {
    var_9 = int(tablelookupbyrow(var_1, var_8, var_2));
    var_9 = level.player_waitforlanded.data.size;
    var_10 = spawnStruct();
    var_10._id_11A4A = tablelookupbyrow(var_1, var_8, var_3);
    var_10._id_127D8 = tablelookupbyrow(var_1, var_8, var_4);
    var_10.player_parachute_watcher = tablelookupbyrow(var_1, var_8, var_5);
    var_10.ignore_spawn_scoring_pois = _encstr_848C160FA3C8B6CFC033C2BB5928632FA023899EF568BDAF(var_1, var_8, var_6);
    var_10._id_11E2A = var_10._id_127D8;
    level.player_waitforlanded.data[var_9] = var_10;
    level.player_waitforlanded._id_14729[var_10._id_11A4A] = var_8;

    if(var_7 != var_10._id_127D8) {
      level.player_waitforlanded._id_127D9[var_10._id_127D8] = var_8;
      var_7 = var_10._id_127D8;
    }
  }
}

_encstr_83F61426AE4B1B8C99C6B09B0D07F6D2CD1D1916A385() {
  if(getdvarint("_encstr_BA7B0A699C09D3CC10739151", 0) != 0) {
    var_0 = _func_043A();
    var_1 = _encstr_A78B114CD52D631936588DC6BD5747912C1D85();
    var_2 = [];
    var_3 = 0;

    foreach(var_5 in var_0) {
      var_6 = _func_043B(var_5);
      var_7 = level.player_waitforlanded._id_14729[var_6];
      var_8 = level.player_waitforlanded.data[var_7]._id_127D8;
      var_9 = level.player_waitforlanded._id_127D9[var_8];
      var_10 = level.player_waitforlanded.data[var_9];
      var_11 = _encstr_9948105A2BC1FEA790217F7DC5D853C71BC3(var_1, var_8);

      if(var_11 >= 0 && var_11 % 2 == 0 && !isDefined(var_2[var_11])) {
        var_2[var_11] = 1;
        var_3 = var_3 + int(pow(2, int(var_11 / 2)));
      }

      var_12 = _func_043C(var_5);
      level.player_waitforlanded.data[var_9]._id_11E2A = var_10.player_parachute_watcher;
      level.player_waitforlanded.data[var_9].ignore_spawn_scoring_pois = (var_12.origin[0], var_12.origin[1], var_10.ignore_spawn_scoring_pois[2]);
    }

    setomnvar("_encstr_B6C51613FBEF722AB650DBF7E088E06A7B80DB01571D5A41", var_3);
  }
}

_encstr_B8AB0D7B133A9560D72569418E94E0() {
  _encstr_BABD0FC4D55A638C66635EA53723C2E8C2();
  _encstr_83F61426AE4B1B8C99C6B09B0D07F6D2CD1D1916A385();
}

logequipmentuse() {
  level waittill("_encstr_8B7A1187533F0D1369DFC88EF81BD79B148B8D");

  while(!isDefined(level.br_ac130))
    wait 0.1;

  var_0 = level.br_ac130.angles;
  var_0 = var_0 + (0, -90, 0);
  level._id_11E26 = [];

  foreach(var_3, var_2 in level.player_waitforlanded._id_127D9) {
    var_2 = level.player_waitforlanded._id_127D9[var_3];
    init_gasmask(level.player_waitforlanded.data[var_2]._id_11E2A, level.player_waitforlanded.data[var_2].ignore_spawn_scoring_pois, var_0);
  }

  level thread laser_shut_down_interact_monitor();
}

init_gasmask(var_0, var_1, var_2) {
  init_gastrap(var_0, var_1, var_2, "_encstr_A5C00840674D227EF209");
}

init_gastrap(var_0, var_1, var_2, var_3) {
  var_1 = var_1 + (0, 0, 500);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_4 setModel("_encstr_B63B1AE80B3BD7DE39B4765ADCD7CD85DACAEB66F07D4BDC8DB03723");
  var_4.angles = var_2;
  level._id_11E26[level._id_11E26.size] = var_4;
  var_4 setscriptablepartstate(var_3, var_0);
  var_4 unmarkkeyframedmover(1);
}

laser_shut_down_interact_monitor() {
  level thread spawn_bomb_hostage();

  while(isDefined(level.br_ac130))
    wait 0.1;

  wait 90;
  level notify("_encstr_B20A12F34590BBA1BDA891DA1881674FE9AD669B");

  foreach(var_1 in level._id_11E26)
  var_1 delete();
}

spawn_bomb_hostage() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B20A12F34590BBA1BDA891DA1881674FE9AD669B");
  var_0 = 10;
  var_1 = 0.25;

  while(level._id_11E26.size > 0) {
    var_2 = level.players;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];

      if(isDefined(var_4) && isalive(var_4)) {
        if(isDefined(var_4.vehicle)) {
          for(var_5 = 0; var_5 < level._id_11E26.size; var_5++)
            level._id_11E26[var_5] hidefromplayer(var_4);
        }
      }

      if(var_3 % var_0 == 0)
        wait(var_1);
    }

    wait 0.1;
  }
}

_id_12F90() {
  level thread player_fired_gun_monitor();
  level thread _encstr_81E80B26B2C0A31758732FD5E8();
  level thread battle_tracks_stopbattletracksfromstandingonvehicle();
}

battle_tracks_stopbattletracksfromstandingonvehicle() {}

setlowermessageomnvarref(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, var_1, var_2);

  for(;;) {
    var_3 waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(isPlayer(var_4))
      var_4 dodamage(10000, var_4.origin, var_3, var_3, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3");
  }
}

player_fired_gun_monitor() {
  var_0 = [];
}

_id_13624(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_4.angles = var_2;
  var_4 clonebrushmodeltoscriptmodel(var_3);
  return var_4;
}

_encstr_81E80B26B2C0A31758732FD5E8() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (6460, 12457, 6822));
  var_0 setModel("_encstr_82CE3160022E2F168F64BB2446575B87951B08706A870FC30AAFB629579FC14171F2A09AD15DAB433787CC9D3CCBE93B62CAF8");
  var_0.angles = (0, 346, 0);
}

_encstr_B8380BD328297B5AD72347FE9A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  if(!isDefined(level.br_level.br_circledelaytimes) || !isDefined(level.br_circle.circleindex)) {
    return;
  }
  var_0 = getdvarfloat("_encstr_AFEC21835EA3977E0521128BA807B337B93E1D37EE48B7C4C3094A22085BED97102579", 0.4);
  var_1 = getdvarfloat("_encstr_8B36205AE910DF5A4ECFDBB383E0035D207357298398A9022D37E38FA5974B99A878", 2.0);
  var_2 = getdvarint("_encstr_83591EE68D93F54C4EF5B1D15BBEA39558B9CAFADC86586D56D79CC232A5ABB9", 75000);
  var_3 = getdvarfloat("_encstr_B8B022422682F7C61BDFFC439B51BCC99EEB1F8FC8439B762482393B48C7F956335B0F58", 1.0);
  var_4 = getdvarfloat("_encstr_B6711D6EC64EBE894EEBB13AB5F5D1ACB0DCB2D71C27BD262C13968D4BA35E", 1.0);

  while(level.br_level.br_circledelaytimes.size > level.br_circle.circleindex) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_5);
    var_6 = level.br_level.br_circledelaytimes[level.br_circle.circleindex];

    if(var_6 < var_1 || var_6 <= 1) {
      continue;
    }
    var_7 = var_6 * var_3;

    if(var_7 > 0) {
      var_8 = int(var_6 / var_7);

      for(var_9 = 0; var_9 < var_8; var_9++) {
        wait(var_7);

        if(randomfloat(1) <= var_4)
          _encstr_8F9B2D92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FE798ADADA3F3276789C879D29A2010CF3A90BB63::_encstr_87AC0B7BE10B92C3AE10329A99(var_0, var_1, 0, (8387, 15066, 8191), var_2);
      }
    }
  }
}

init_locations() {
  if(level.mapname == "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319") {
    _id_12ADF("_encstr_8D0308D858C14BD15836", 1, (21214, -50131, 0));
    _id_12ADF("_encstr_A3D00FB7303329038B798143D5AD9AE1FB", 1, (30340, -47645, 0));
    _id_12ADF("_encstr_A56206DAA57359E6", 1, (-6265, 17880, 0));
    _id_12ADF("_encstr_81AB066CB069AF22", 1, (16730, 53476, 0));
    _id_12ADF("_encstr_BA89073EAD46E7874A", 1, (44500, -21338, 0));
  } else
    _id_12ADF("_encstr_8B1608EC43B8D647A113", 1, (0, 0, 0));
}

_id_12ADF(var_0, var_1, var_2) {
  if(!isDefined(level.br_level.area_structs))
    level.br_level.area_structs = [];

  var_1 = getdvarint("_encstr_82391C27A3224106178BC910C2F74908BE39A1EB478DF9544F5241983B1F" + var_0, var_1);

  if(var_1 <= 0) {
    return;
  }
  var_3 = spawnStruct();
  var_3._id_13902 = var_0;
  var_3.spotlights = var_1;
  var_3._id_140B7 = var_2;
  level.br_level.area_structs[var_0] = var_3;
}

groundz() {
  level.br_level._id_12E2C = _id_12D7F();
  level.grouptorewards = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(level.br_level._id_12E2C._id_140B7, 5300, 0.0, 1.0, 0, 0);
}

_id_12D7F() {
  level.br_level._id_13903 = getDvar("_encstr_9AB827B936E47D89E4FA6CEA9B1DF6DA7DB14BE4B1632BEBDE6756E49C2D8CCA7DB1F61BB0A3B4DE37", "_encstr_A31207CBF788523281");

  if(isDefined(level.br_level._id_13903) && level.br_level._id_13903 != "_encstr_A31207CBF788523281") {
    foreach(var_2, var_1 in level.br_level.area_structs) {
      if(level.br_level._id_13903 == var_2)
        return var_1;
    }
  }

  if(level.br_level.area_structs.size == 1)
    return level.br_level.area_structs[0];

  var_3 = 0;

  foreach(var_1 in level.br_level.area_structs)
  var_3 = var_3 + var_1.spotlights;

  var_6 = randomintrange(0, var_3);

  foreach(var_1 in level.br_level.area_structs) {
    if(var_6 < var_1.spotlights)
      return var_1;

    var_6 = var_6 - var_1.spotlights;
  }

  level.br_level.area_structs = scripts\engine\utility::array_randomize(level.br_level.area_structs);
  return level.br_level.area_structs[0];
}

_encstr_A6C811DCACD1EAC1B9B5BDB52BC6DE36D5D6CD() {
  level waittill("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  level._encstr_8E0A0C834B8B119D5F7B3820D237 = scripts\engine\utility::ter_op(getdvarint("_encstr_87E0253736C97D98E4D76C58D891CA93B0F5B3F61BD82C73BDFADE36854E5A4659D737B5F6DA2B", 0), "_encstr_AC9D1AED01FB1B29C9602F8318E01B924D287962793F426DF620EFFF", "_encstr_A68F1CDE1BB04ED28CCAEB9D7BB16CB037F6EB6E6B7BB695AFCDDA2CC6D8");
  scripts\engine\utility::exploder(level._encstr_8E0A0C834B8B119D5F7B3820D237);
}

_encstr_A57115FB93BA158057252961CD0FD8C3B3377F6D0F82DD() {
  level waittill("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  _func_0448((8333, 14999, 8851), "_encstr_925E1FE2B08FF3C3CEAB6B7CB73063313F4AEF59F8612D1F83804C6B5F187BC469", 3000, 800, 0);
}

_encstr_8BE61D036B42EDA08CBEA3D8E76DA0AB1B9F9785A72AB5D8CE97ABB34C5460() {
  level endon("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_AD51088015D1E2D47930") {
    for(;;) {
      level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
      var_0 thread _encstr_A547128578B5CA6848C9C305C407F888A64BAF23(0, "_encstr_912E0CE9DF20ABB7C2E34140EADF");
    }
  }
}

_encstr_A547128578B5CA6848C9C305C407F888A64BAF23(var_0, var_1) {
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self _meth_87E3(var_0, var_1);
}