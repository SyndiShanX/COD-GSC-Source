/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2467.gsc
*************************************************/

_id_11050() {
  if(level.gametype == "cp_pvpve") {
    level._id_F382 = 55;
  } else {
    level._id_F382 = 48;
  }

  scripts\engine\utility::_id_5C11("spawn_point_score_data_init_done");
  level._id_11087 = ::_id_6770;
  level._id_6918 = ::_id_6918;
  level._id_1121 = ::_id_1121;
  level._id_5901 = [];
  level thread _id_8290();
}

_id_8290() {
  level endon("game_ended");

  if(!scripts\engine\utility::_id_5C0C("init_spawn_volumes_done")) {
    scripts\engine\utility::_id_5C11("init_spawn_volumes_done");
  }

  if(!scripts\engine\utility::_id_5C00("init_spawn_volumes_done")) {
    scripts\engine\utility::_id_5C24("init_spawn_volumes_done");
  }

  _id_6EA4(level._id_0F32);
  level thread _id_E1C3();
}

_id_6918(var_0) {
  if(isDefined(var_0)) {
    var_1 = scripts\cp\utility::_id_1BD5(scripts\engine\utility::_id_1BBD(var_0), ::_id_6D45);
    return var_1[var_1.size - 1];
  } else {
    var_1 = scripts\cp\utility::_id_1BD5(scripts\engine\utility::_id_1BBD(level._id_0F32), ::_id_6D45);
    return var_1[var_1.size - 1];
  }
}

_id_6D45() {
  if(isDefined(self._id_0497)) {
    return self._id_0497;
  } else {
    return 0;
  }
}

_id_6770(var_0) {
  if(isDefined(var_0)) {
    return _id_6EA4(var_0);
  }

  return _id_6EA4(level._id_0F32);
}

_id_11066(var_0) {
  if(!_id_09A2::_id_408A(_id_09A2::_id_1FAE, var_0)) {
    return "secondary";
  }

  if(!_id_09A2::_id_408A(_id_09A2::_id_1FB2, var_0)) {
    return "secondary";
  }

  if(!_id_09A2::_id_408A(_id_09A2::_id_1FBD, var_0)) {
    return "secondary";
  }

  return "primary";
}

_id_8282(var_0) {
  var_0._id_0497 = 0;
  var_0._id_F37D = 0;
  var_0._id_A774 = 0;
  var_0._id_2C93 = 0;
  var_0._id_903B = [];
  var_0._id_903B["allies"] = 0;
  var_0._id_903B["axis"] = 0;
}

_id_88D5(var_0) {
  if(isDefined(var_0._id_106A1) && var_0._id_106A1._id_0026) {
    return 1;
  }

  return 0;
}

_id_6EA4(var_0) {
  if(!isDefined(level._id_418F)) {
    level._id_418F = 0;
  } else {
    level._id_418F = _id_6429(level._id_418F);
  }

  var_1 = level._id_418F;
  var_2 = [];

  foreach(var_4 in var_0) {
    _id_8282(var_4);

    if(_id_11066(var_4) == "primary") {
      var_2[var_2.size] = var_4;
    }
  }

  if(var_2.size) {
    var_6 = _id_CC19(var_2, var_1);
  } else {
    var_6 = scripts\engine\utility::random(var_0);
  }

  scripts\engine\utility::_id_5C1B("spawn_point_score_data_init_done");
  return var_6;
}

_id_6429(var_0) {
  var_1 = level.players.size;

  if(var_1 == 1) {
    return 0;
  }

  var_2 = 0;
  var_3 = _id_65E3(var_0);

  while(!var_2) {
    if(var_3 == var_0) {
      break;
    }

    var_4 = level.players[var_3];

    if(!istrue(var_4._id_E3E5) && !istrue(var_4._id_85CC) && !istrue(var_4.inlaststand)) {
      var_2 = 1;
    }

    if(!var_2) {
      var_3 = _id_65E3(var_3);
    }
  }

  return var_3;
}

_id_65E3(var_0) {
  var_1 = var_0 + 1;

  if(isDefined(level.players[var_1])) {
    return var_1;
  } else {
    var_1++;

    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      if(isDefined(level.players[var_1])) {
        return var_1;
      }

      if(var_1 >= level.players.size) {
        var_1 = 0;
        continue;
      }

      var_1++;
    }

    return 0;
  }
}

_id_CC19(var_0, var_1) {
  var_2 = var_0[0];
  var_0 = scripts\engine\utility::array_randomize(var_0);
  level notify("debug_spawner_score_reset");

  foreach(var_4 in var_0) {
    _id_CC03(var_4, var_1);

    if(!isDefined(var_2) || var_4._id_0497 > var_2._id_0497) {
      var_2 = var_4;
    }
  }

  return var_2;
}

_id_7B33(var_0, var_1, var_2) {
  if(var_2) {
    var_3 = (1, 1, 1);

    switch (var_1) {
      case 0:
        var_3 = (1, 0, 0);
        break;
      case 1:
        var_3 = (1, 1, 0);
        break;
      case 2:
        var_3 = (0, 1, 0);
        break;
      case 3:
        var_3 = (0, 1, 1);
        break;
    }

    thread scripts\cp\utility::_id_4F48(var_0.origin, 20, 10, var_3);
  }
}

_id_CC03(var_0, var_1) {
  var_2 = level._id_F382;
  var_3 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 5, 5);
  var_4 = _id_CBEB(var_3 / var_2, ::_id_BB8B, var_0, var_1);
  var_0._id_0497 = var_0._id_0497 + var_4;
  var_3 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 10, 20);
  var_4 = _id_CBEB(var_3 / var_2, ::_id_1FB7, var_0);
  var_0._id_C0FA = var_4;
  var_0._id_0497 = var_0._id_0497 + var_4;
  var_3 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 10, 1);
  var_4 = _id_CBEB(var_3 / var_2, ::_id_BB85, var_0, var_1);
  var_0._id_0497 = var_0._id_0497 + var_4;
  var_3 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 0, 2);
  var_4 = _id_CBEB(var_3 / var_2, ::_id_1FA9, var_0);
  var_0._id_0497 = var_0._id_0497 + var_4;
  var_3 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 10, 15);
  var_4 = _id_CBEB(var_3 / var_2, ::_id_1FB3, var_0, var_1);
  var_0._id_0497 = var_0._id_0497 + var_4;
  var_3 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 20, 5);
  var_4 = _id_CBEB(var_3 / var_2, ::_id_1FB4, var_0, var_1);
  var_0._id_0497 = var_0._id_0497 + var_4;
  var_0._id_0497 = int(var_0._id_0497);
}

_id_1FB4(var_0, var_1) {
  var_2 = 1000;
  var_3 = 0;

  if(istrue(var_0._id_43F5)) {
    return var_3;
  } else {
    return var_2;
  }
}

_id_1FB3(var_0, var_1) {
  var_2 = level.players[var_1];
  var_3 = 1000;

  if(istrue(var_2.ignoreme)) {
    return var_3;
  }

  var_4 = var_2 getEye();
  var_5 = var_2 getplayerangles();
  var_6 = scripts\engine\math::_id_645E(var_2.origin, var_5, var_0.origin);

  if(var_6 >= 0.573576 && _func_0202(var_4, var_0.origin + (0, 0, 32), 0, var_2, 0)) {
    return 0;
  } else if(var_6 >= 0) {
    return var_3 * var_6;
  } else {
    return -1 * (var_3 * var_6);
  }
}

_id_BB8B(var_0, var_1) {
  if(!isDefined(var_0._id_106A1)) {
    return 1000;
  }

  var_2 = level.players[var_1];

  if(istrue(var_2.ignoreme)) {
    return 1000;
  }

  var_3 = 0;
  var_4 = 0.5;
  var_5 = 1000;
  var_6 = 0;
  var_7 = 20;
  var_3 = 0.9;
  var_8 = istrue(level.gametype == "cp_pvpve");

  if(_id_6BAF(var_0._id_106A1, var_2)) {
    var_3 = 1;
  } else if(isDefined(var_0._id_106A1._id_118A)) {
    foreach(var_10 in var_0._id_106A1._id_118A) {
      if(_id_6BAF(var_10)) {
        var_3 = 0.5;
        break;
      }
    }
  }

  if(var_3 == 0) {
    return 0;
  } else {
    var_12 = distance(var_2.origin, var_0.origin);
    var_13 = var_12 * var_12;
    var_14 = getdvarint("#x3596d9ac0beaaf80d", 0);

    if(var_8) {
      if(isDefined(level._id_41B3) && level._id_41B3 == "pvpveSpawning") {
        var_15 = 122500;
        var_16 = 384;
        var_17 = 3062500;
        var_18 = 1280;
        var_19 = 16000000;
      } else {
        var_15 = 122500;
        var_16 = 384;
        var_17 = 3062500;
        var_18 = 512;
        var_19 = 16000000;
      }
    } else {
      var_15 = 122500;
      var_16 = 350;
      var_17 = 3062500;
      var_18 = 1750;
      var_19 = 16000000;
    }

    if(var_14 != 0) {
      var_20 = var_14;
      var_21 = var_14 * var_14;
    } else {
      var_20 = (var_18 + var_16) / 2;
      var_21 = var_20 * var_20;
    }

    if(var_13 <= var_17 && var_13 >= var_15) {
      if(var_13 < var_21) {
        var_20 = var_20 - var_16;
      } else {
        var_20 = var_18 - var_20;
      }

      var_22 = abs(var_12 - var_20);
      var_23 = (var_20 - var_22) / var_20;
      var_24 = var_5 * var_23 * var_3;
      return var_24;
    } else if(var_13 >= var_19)
      return var_6;
    else if(var_13 >= var_17) {
      var_23 = 1 + var_13 / var_17;
      var_24 = var_7 / var_23 * var_3;
      return var_24;
    } else if(var_13 <= var_15)
      return var_6;
    else {
      var_24 = var_5 * var_4 * var_3;
      return var_24;
    }
  }
}

_id_1FB7(var_0) {
  var_1 = 1000;

  if(isDefined(var_0._id_904F)) {
    var_2 = gettime() - var_0._id_904F;

    if(var_2 > 10000) {
      return var_1;
    }

    return int(var_2 / 10000 * var_1);
  }

  return var_1;
}

_id_1FA9(var_0) {
  var_1 = 1000;
  var_2 = 250000;

  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0.origin) > var_2) {
      continue;
    }
    if(scripts\engine\utility::_id_6369(var_4.origin, level._id_E2A4, undefined, 5, 500, 1).size >= 5) {
      var_1 = var_1 - 1;
    }
  }

  return var_1;
}

_id_BB85(var_0, var_1) {
  if(!isDefined(var_0._id_106A1)) {
    return 1000;
  }

  if(level.players.size == 1) {
    return 1000;
  }

  var_2 = level.players[var_1];

  if(istrue(var_2.ignoreme)) {
    return 1000;
  }

  var_3 = _id_06FE::_id_6884(var_2.team);
  var_4 = [];

  foreach(var_6 in level.players) {
    if(var_2 == var_6) {
      continue;
    }
    if(var_2.team != var_6.team) {
      var_4[var_4.size] = var_6;
    }
  }

  var_8 = scripts\engine\utility::array_combine(var_3, var_4);
  var_9 = scripts\engine\utility::_id_6369(var_2.origin, var_8, undefined, 10, 512);

  if(var_9.size > 10) {
    return 0;
  }

  if(var_9.size < 1) {
    return 1000;
  }

  var_10 = 1000;
  return var_10 * (1 - (var_9.size - 1) * 0.1);
}

_id_CBEB(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = [[var_1]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    var_5 = [[var_1]](var_2, var_3);
  } else {
    var_5 = [[var_1]](var_2);
  }

  var_6 = 1000 * var_0;
  var_5 = clamp(var_5 * var_0, 0, var_6);
  return var_5;
}

_id_6BAF(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1)) {
    if(istrue(var_1._id_E3E5) || istrue(var_1.inlaststand)) {
      return var_2;
    } else if(_func_011A(var_1.origin, var_0)) {
      var_2++;
    }
  } else {
    foreach(var_1 in level.players) {
      if(istrue(var_1._id_E3E5)) {
        continue;
      }
      if(istrue(var_1._id_85CC)) {
        continue;
      }
      if(istrue(var_1.inlaststand)) {
        continue;
      }
      if(_func_011A(var_1.origin, var_0)) {
        var_2++;
      }
    }
  }

  return var_2;
}

_id_6BB0(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = 0;

  foreach(var_5 in level.players) {
    if(distancesquared(var_5.origin, var_0.origin) < var_2) {
      var_3++;
    }
  }

  return var_3;
}

_id_448C(var_0, var_1) {
  level endon("debug_spawner_score_reset");
  var_2 = 0;
  var_3 = 150;
  var_4 = 350;
  var_5 = 500;
  var_6 = 600;
  var_7 = 750;
  var_8 = 900;

  if(var_0._id_0497 <= 0) {
    scripts\cp\utility::_id_4F48(var_0.origin, 20, var_1, (1, 0, 0));
  } else if(var_0._id_0497 <= var_3) {
    scripts\cp\utility::_id_4F48(var_0.origin, 20, var_1, (1, 1, 0));
  } else if(var_0._id_0497 < var_7) {
    scripts\cp\utility::_id_4F48(var_0.origin, 20, var_1, (0, 1, 0));
  } else if(var_0._id_0497 < var_5) {
    scripts\cp\utility::_id_4F48(var_0.origin, 20, var_1, (0, 1, 1));
  } else if(var_0._id_0497 >= var_7 && var_0._id_0497 < var_8) {
    scripts\cp\utility::_id_4F48(var_0.origin, 20, var_1, (0, 1, 1));
  } else if(var_0._id_0497 >= var_8) {
    scripts\cp\utility::_id_4F48(var_0.origin, 20, var_1, (1, 1, 1));
  }
}

_id_FD30(var_0) {
  var_1 = getdvarint("#x37f204ed740a1abb5", 0);
  var_2 = getdvarint("#x3b2f79848e28bf93b", 0);
  level._id_418F = _id_6429(level._id_418F);

  if(isDefined(level.players[level._id_418F])) {
    var_3 = level.players[level._id_418F];

    if(isDefined(var_3)) {
      _id_8282(var_0);
      _id_CC03(var_0, level._id_418F);
    }
  }
}

_id_E1C3() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("init_spawn_volumes_done");

  if(level._id_1479.size == 0) {
    return;
  }
  for(;;) {
    level._id_418F = _id_6429(level._id_418F);

    if(isDefined(level.players[level._id_418F])) {
      var_0 = level.players[level._id_418F];

      if(isDefined(var_0)) {
        var_1 = _func_0204(level._id_1479, var_0.origin);
        var_2 = 0;
        var_3 = getdvarint("#x37f204ed740a1abb5", 0);
        var_4 = getdvarint("#x3b2f79848e28bf93b", 0);
        var_2 = -1;

        foreach(var_6 in var_1) {
          if(var_4 > 0) {
            if(var_6._id_F91C != var_4) {
              continue;
            }
          }

          _id_8282(var_6);
          _id_CC03(var_6, level._id_418F);

          if(var_3 > 0) {
            if(isDefined(var_6._id_0497)) {
              if(var_2 >= 20) {
                continue;
              }
              switch (var_3) {
                case 1:
                  level thread _id_448C(var_6, 0.25);
                  var_2++;
                  break;
                case 3:
                  if(var_6._id_039B == "soldier") {
                    level thread _id_448C(var_6, 0.25);
                    var_2++;
                  }

                  break;
                case 2:
                  if(var_6._id_039B == "static") {
                    level thread _id_448C(var_6, 0.25);
                    var_2++;
                  }

                  break;
              }
            }

            continue;
          }

          var_2++;

          if(var_2 % 5 == 0) {
            waitframe();
          }
        }

        if(var_1.size >= 1) {
          wait 0.25;
          continue;
        }
      } else {
        wait 0.25;
        continue;
      }
    } else
      wait 0.25;
  }
}

_id_448D() {
  level endon("game_ended");

  while(!isDefined(level._id_0F32)) {
    wait 0.1;
  }

  for(;;) {
    if(getdvarint("#x37f204ed740a1abb5", 0) != 0 && isDefined(level.players[0])) {
      var_0 = _func_0204(level._id_1479, level.players[0].origin);
      var_1 = 0;

      foreach(var_3 in var_0) {
        _id_8282(var_3);
        _id_CC03(var_3, level._id_418F);

        if(isDefined(var_3._id_0497)) {
          level thread _id_448C(var_3, 0.1);
          var_1++;
        }

        if(var_1 >= 40) {
          break;
        }
      }
    }

    wait 0.1;
  }
}

_id_8291() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("interactions_initialized");
  var_0 = scripts\engine\utility::getstructarray("spawner_seed", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_E2DA = scripts\engine\utility::_id_6369(var_2.origin, level._id_1479, undefined, 50);
  }

  level._id_15EC = var_0;
}

_id_1121(var_0) {
  var_1 = scripts\engine\utility::_id_6369(var_0, level._id_1479, undefined, undefined, 512);

  foreach(var_3 in var_1) {
    thread _id_D473(var_3);
  }
}

_id_D473(var_0) {
  if(!isDefined(var_0._id_F91C)) {
    return;
  }
  level notify("setAndUnsetRecentDeathNearby_" + var_0._id_F91C);
  level endon("setAndUnsetRecentDeathNearby_" + var_0._id_F91C);
  var_0._id_43F5 = 1;
  wait 5;
  var_0._id_43F5 = undefined;
}