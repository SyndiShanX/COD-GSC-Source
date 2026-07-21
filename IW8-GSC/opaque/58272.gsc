/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58272.gsc
***********************************************/

init() {
  if(isDefined(level._id_119F9)) {
    return;
  }
  test_bag_pickup();
  level._effect["_encstr_BA722020BDFB7E3B82FB281885E1B46F589B07519BBB1D7DAB2B028379B7E43F280F"] = loadfx("_encstr_BEC6342377888A438BE2B7D5D3D69C30250F6BF8DEE1D284B20BBFD78F8A55A8CE695010C53499352B1321FF87E228B8A7BFD8A92A8D");
  level._effect["_encstr_889C1BB3CC0F7D314EEB362BB395E6192CC9977D1BB77BA37D9D36DE77"] = loadfx("_encstr_AC7A2CC0EB0888BB1350F87EDACEFF09759F78885FB1504DEA68F076B2E121F1B51B98203F431011E259D409CD9B");
}

test_bag_pickup() {
  if(!isDefined(level._id_119F9)) {
    level._id_119F9 = spawnStruct();
    level._id_119F9._encstr_83D30B67B56F305FFB7B70D033 = [];
    level._id_119F9._encstr_83D30B67B56F305FFB7B70D033["_encstr_965306392D3336B2"] = "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD";
    level._id_119F9._encstr_83D30B67B56F305FFB7B70D033["_encstr_BE0703A54C"] = "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD";
    level._id_119F9._encstr_83D30B67B56F305FFB7B70D033["_encstr_8D940738966ED1DB8D"] = "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9";
    level._id_119F9._encstr_83D30B67B56F305FFB7B70D033["_encstr_BE1904DCDA9D"] = "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9";
    level._id_119F9._encstr_83D30B67B56F305FFB7B70D033["_encstr_850707F7E5833355B8"] = "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6";
    level._id_119F9._encstr_83D30B67B56F305FFB7B70D033["_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0"] = "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014";
    level._id_119F9._encstr_83D30B67B56F305FFB7B70D033["_encstr_A1100738A33A638123"] = "_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18";
  }

  level._id_119F9._id_12148 = [];
  level._id_119F9._id_119FD = [];
}

_id_11A45(var_0, var_1) {
  if(!isDefined(level._id_119F9)) {
    return;
  }
  if(!scripts\engine\utility::array_contains_key(level._id_119F9._id_119FD, var_0))
    level._id_119F9._id_119FD[var_0] = allow_hotjoining(var_0, var_1);
  else {}
}

_id_11A47(var_0, var_1) {
  if(cargo_truck_mg_cp_spawncallback(var_0)) {
    return;
  }
  if(scripts\engine\utility::array_contains_key(level._id_119F9._id_119FD, var_0))
    level._id_119F9._id_119FD[var_0] = var_1;
}

_id_11A44(var_0, var_1, var_2) {
  if(cargo_truck_mg_cp_spawncallback(var_0)) {
    return;
  }
  var_3 = level._id_119F9._id_119FD[var_0];

  if(!scripts\engine\utility::array_contains_key(var_3, var_1)) {
    level._id_119F9._id_12148[var_0][var_1] = var_2;
    level._id_119F9._id_119FD[var_0] = allow_hotjoining(var_0, level._id_119F9._id_12148[var_0]);
  } else {}
}

_id_11A46(var_0, var_1) {
  if(cargo_truck_mg_cp_spawncallback(var_0)) {
    return;
  }
  var_2 = level._id_119F9._id_119FD[var_0];

  if(scripts\engine\utility::array_contains_key(var_2, var_1)) {
    level._id_119F9._id_12148[var_0] = scripts\engine\utility::array_remove_key(level._id_119F9._id_12148[var_0], var_1);
    level._id_119F9._id_119FD[var_0] = allow_hotjoining(var_0, level._id_119F9._id_12148[var_0]);
  } else {}
}

removepickup(var_0) {
  if(cargo_truck_mg_cp_spawncallback(var_0)) {
    return;
  }
  return level._id_119F9._id_119FD[var_0];
}

_encstr_8D010F1BDBBDA3D15831B159CA874BE61D(var_0) {
  return scripts\engine\utility::array_contains_key(level._id_119F9._id_119FD, var_0);
}

_id_13673(var_0, var_1, var_2, var_3, var_4) {
  if(cargo_truck_mg_cp_spawncallback(var_0)) {
    return;
  }
  var_5 = removepickup(var_0);
  var_6 = spawnStruct();
  var_6.ml_p3_to_safehouse_transition = randomintrange(1, 10);
  var_6.heightoffset = 0;
  var_6.origin = var_1;

  if(isstring(var_3)) {} else if(var_3)
    playFX(scripts\engine\utility::getfx("_encstr_BA722020BDFB7E3B82FB281885E1B46F589B07519BBB1D7DAB2B028379B7E43F280F"), var_1);

  for(var_7 = 0; var_7 < var_2; var_7++) {
    var_8 = randomfloat(1.0);

    foreach(var_15, var_10 in var_5) {
      var_11 = var_10[2];
      var_12 = var_10[3];

      if(var_8 >= var_11 && var_8 <= var_12) {
        switch (var_15) {
          case "_encstr_8DDE08CDF61D434BB9B3":
            continue;
          case "_encstr_83D8191DAACDA8781B3191187A1F38D0241CB99B32F908B73F8A49":
            if(!isDefined(var_4)) {
              continue;
            }
            if(!isDefined(var_4["_encstr_97BD0AB214A31D85D8AD594E"])) {
              continue;
            }
            var_13 = var_4["_encstr_97BD0AB214A31D85D8AD594E"];
            var_14 = undefined;

            if(isPlayer(var_13) || isbot(var_13) || isagent(var_13))
              var_14 = weaponclass(var_4["_encstr_97BD0AB214A31D85D8AD594E"] getcurrentweapon());

            if(!isDefined(var_14)) {
              continue;
            }
            var_6.item = level._id_119F9._encstr_83D30B67B56F305FFB7B70D033[var_14];

            if(!isDefined(var_6.item)) {
              continue;
            }
            break;
          default:
            var_6.item = var_15;
            break;
        }

        var_6.ml_p3_to_safehouse_transition = var_6.ml_p3_to_safehouse_transition + 2;
        thread _id_13672(var_6);
        waitframe();
      }
    }
  }
}

cargo_truck_mg_cp_spawncallback(var_0) {
  if(!scripts\engine\utility::array_contains_key(level._id_119F9._id_119FD, var_0))
    return 1;

  return 0;
}

_id_13672(var_0) {
  var_0.legendary = issubstr(var_0.item, "_encstr_A2AD058D56B3CA");
  var_1 = var_0.item;
  var_2 = var_0.origin + (0, 0, var_0.heightoffset);
  var_3 = (0, 0, 0);
  var_4 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_1, var_0, var_2, var_3, 0, var_0.legendary, 0);
  var_0.heightoffset = var_0.heightoffset + 3;
}

allow_hotjoining(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_1)
  var_3 = var_3 + var_5;

  var_7 = 0;
  var_8 = getarraykeys(var_1);
  var_9 = undefined;

  foreach(var_14, var_5 in var_1) {
    var_2[var_14] = [];
    var_11 = var_5 / var_3;

    if(var_7 == 0) {
      var_12 = 0;
      var_13 = var_11;
    } else {
      var_12 = var_9[3];
      var_13 = var_12 + var_11;
    }

    var_2[var_14] = [var_5, var_11, var_12, var_13];
    var_9 = var_2[var_14];
    var_7++;
  }

  level._id_119F9._id_12148[var_0] = var_1;
  return var_2;
}