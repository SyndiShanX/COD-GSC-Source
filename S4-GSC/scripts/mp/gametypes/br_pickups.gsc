/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_pickups.gsc
*************************************************/

_id_2A96() {
  level._id_2A95 = spawnStruct();
  _id_8141();
  _id_8284();
}

_id_8141() {
  level._id_2BEB = getDvar("#x367002091f348e34d", "mp/loot_item_defs_s3.csv");

  if(!isDefined(level._id_2A95)) {
    level._id_2A95 = spawnStruct();
  }

  level._id_2A95._id_5047 = [];
  level._id_2A95._id_2A42 = [];
  level._id_2A95._id_E503 = [];
  level._id_2A95._id_9C60 = [];
  level._id_2A95._id_3DAB = [];
  level._id_2A95._id_2A67 = [];
  level._id_2A95._id_2A66 = [];
  level._id_2A95._id_2A65 = [];
  level._id_2A95._id_2A43 = [];
  level._id_2A95._id_2AD2 = [];
  level._id_2A95._id_2A97 = [];
  level._id_2A95._id_2A69 = [];
  level._id_2A95._id_2A6A = [];
  level._id_2A95._id_2ABF = [];
  level._id_2A95._id_2A57 = [];
  level._id_2A95._id_29F5 = [];
  level._id_2A95._id_2A76 = [];
  level._id_2A95._id_2A2F = [];
  level._id_2A95._id_2A30 = [];
  level._id_2A95._id_2A55 = [];
  level._id_2A77 = [];
  level._id_2AD0 = [];
  level._id_2AD1 = [];
  level._id_2AC2 = [];
  level._id_2AC7 = [];
  var_0 = [];
  var_1 = 0;
  var_2 = "+";

  if(scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::_id_60FA()) {
    var_3 = tablelookupgetnumrows(level._id_2BEB);

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = tablelookupbyrow(level._id_2BEB, var_4, 0);

      if(!isDefined(var_5)) {
        continue;
      }
      if(var_5 == "item") {
        var_6 = tablelookupbyrow(level._id_2BEB, var_4, 2);

        if(!isDefined(var_6)) {
          continue;
        }
        if(var_6 == "weapon") {
          var_7 = tablelookupbyrow(level._id_2BEB, var_4, 1);
          var_8 = tablelookupbyrow(level._id_2BEB, var_4, 3);
          var_9 = tablelookupbyrow(level._id_2BEB, var_4, 5);
          var_10 = tablelookupbyrow(level._id_2BEB, var_4, 15);

          if(isDefined(var_9) && var_9.size > 0) {
            var_11 = int(var_9);
            var_12 = _func_0222("loot/weapon_ids.csv", 0, var_11, 1);
            var_13 = _func_0222("loot/weapon_ids.csv", 0, var_11, 9);
            var_14 = scripts\mp\utility\weapon::_id_6E93(var_12);
            var_15 = int(_func_0222(var_14, 1, var_13, 0));
            var_16 = tablelookupbyrow(level._id_2BEB, var_4, 10);
            var_17 = [];
            var_18 = [];

            if(isDefined(var_16) && var_16.size) {
              var_17 = strtok(var_16, var_2);
            }

            if(isDefined(var_17)) {
              foreach(var_20 in var_17) {
                var_21 = strtok(var_20, "|");

                if(var_21.size > 1) {
                  var_18[var_21[0]] = int(var_21[1]);
                  continue;
                }

                var_18[var_21[0]] = 0;
              }
            }

            var_23 = var_12;
            var_24 = scripts\mp\class::_id_2D15(var_12, var_18, undefined, undefined, var_15);
            var_25 = getcompleteweaponname(var_24);
          } else {
            var_23 = tablelookupbyrow(level._id_2BEB, var_4, 8);
            var_16 = tablelookupbyrow(level._id_2BEB, var_4, 10);
            var_17 = [];

            if(isDefined(var_16) && var_16.size) {
              var_17 = strtok(var_16, var_2);
            }

            var_24 = scripts\mp\class::buildweapon(var_23, var_17, "none", "none", -1);
            var_25 = getcompleteweaponname(var_24);
          }

          level._id_2A95._id_2A67[var_7] = var_6;
          level._id_2A95._id_2A97[var_7] = var_10;
          level._id_2A95._id_2A65[var_7] = int(var_8);
          level._id_2A95._id_2A76[level._id_2A95._id_2A76.size] = var_7;
          level._id_2A77[var_7] = spawnStruct();
          level._id_2A77[var_7]._id_232D = var_23;
          level._id_2A77[var_7]._id_5FFA = var_25;
          level._id_2A77[var_7]._id_5FFB = var_24;

          if(int(var_8) != 5) {
            level._id_2A95._id_2AD2[var_25] = var_7;
          }
        } else {
          var_7 = tablelookupbyrow(level._id_2BEB, var_4, 1);
          level._id_2A95._id_2A66[var_7] = int(var_4);
          var_37 = tablelookupbyrow(level._id_2BEB, var_4, 8);

          if(isDefined(var_37) && var_37.size > 0) {
            var_37 = tolower(var_37);
            level._id_2A95._id_2A42[var_7] = var_37;
            level._id_2A95._id_2A43[var_37] = var_7;
          }

          level._id_2A95._id_2A57[var_7] = int(tablelookupbyrow(level._id_2BEB, var_4, 24));
          var_38 = tablelookupbyrow(level._id_2BEB, var_4, 16);

          if(var_38 != "") {
            switch (var_38) {
              case "1":
                if(isDefined(var_37) && var_37.size > 0) {
                  level.equipment._id_EC5C[var_37]._id_45C7 = "primary";
                }

                level._id_2AC2[level._id_2AC2.size] = var_7;
                break;
              case "2":
                if(isDefined(var_37) && var_37.size > 0) {
                  level.equipment._id_EC5C[var_37]._id_45C7 = "secondary";
                }

                level._id_2AC7[level._id_2AC7.size] = var_7;
                break;
              case "3":
                if(isDefined(var_37) && var_37.size > 0) {
                  level.equipment._id_EC5C[var_37]._id_45C7 = "health";
                }

                break;
              case "4":
                if(isDefined(var_37) && var_37.size > 0) {
                  level.equipment._id_EC5C[var_37]._id_45C7 = "super";
                }

                break;
              default:
                break;
            }
          }

          if(var_6 == "killstreak") {
            var_39 = tablelookupbyrow(level._id_2BEB, var_4, 19);
            level._id_2A95._id_2A69[var_7] = var_39;
            level._id_2A95._id_2A6A[var_39] = var_7;
          } else if(var_6 == "super") {
            var_40 = tablelookupbyrow(level._id_2BEB, var_4, 19);
            level._id_2A95._id_2ABF[var_7] = var_40;
          }

          var_41 = int(tablelookupbyrow(level._id_2BEB, var_4, 4));
          var_42 = int(tablelookupbyrow(level._id_2BEB, var_4, 18));

          if(var_6 == "ammo") {
            level._id_29FD[var_7] = var_42;
          }

          level._id_2A95._id_9C60[var_7] = var_42;
          level._id_2A95._id_E503[var_7] = var_42 > 1;
          level._id_2A95._id_3DAB[var_7] = var_41;
          var_6 = tolower(var_6);
          level._id_2A95._id_2A67[var_7] = var_6;
          level._id_2A95._id_2A97[var_7] = tablelookupbyrow(level._id_2BEB, var_4, 15);
          var_43 = tablelookupbyrow(level._id_2BEB, var_4, 3);
          level._id_2A95._id_2A65[var_7] = int(var_43);
        }

        continue;
      }

      if(var_5 == "crate") {
        var_7 = tablelookupbyrow(level._id_2BEB, var_4, 1);
        var_44 = int(tablelookupbyrow(level._id_2BEB, var_4, 2));

        if(var_44 > 0) {
          if(isDefined(level._id_2A77[var_7]) && isDefined(level._id_2A77[var_7]._id_232D)) {
            for(var_45 = 0; var_45 < var_44; var_45++) {
              level._id_2A95._id_2A2F[level._id_2A95._id_2A2F.size] = var_7;
              level._id_2A95._id_29F5[level._id_2A95._id_29F5.size] = var_7;
            }
          } else {
            for(var_45 = 0; var_45 < var_44; var_45++) {
              level._id_2A95._id_2A30[level._id_2A95._id_2A30.size] = var_7;
            }
          }
        }

        continue;
      }

      if(var_5 == "gulag") {
        var_7 = tablelookupbyrow(level._id_2BEB, var_4, 1);
        var_46 = tablelookupbyrow(level._id_2BEB, var_4, 2);

        if(!isDefined(level._id_2A95._id_2A55[var_46])) {
          level._id_2A95._id_2A55[var_46] = [];
        }

        var_47 = level._id_2A95._id_2A55[var_46].size;
        level._id_2A95._id_2A55[var_46][var_47] = var_7;
      }
    }
  }

  setdvarifuninitialized("#x3b40675df95de7ac3", 0);
  level._id_2A95._id_2A8D = "MP/BR_AMMO_DENY_NO_ROOM";
  level._id_2A95._id_2A90 = "MP/BR_EQUIP_DENY_NO_ROOM";
  level._id_2A95._id_2A8C = "MP/BR_WEAPON_DENY_ALREADY_HAVE";
  level._id_2A95._id_2A8F = "MP/BR_ARMOR_DENY_NOT_BETTER";
  level._id_2A95._id_2A88 = "MP/BR_KILLSTREAK_DENY_ALREADY_HAVE";
  level._id_2A95._id_2A8B = "MP_BR_INGAME/ALREADY_HAVE_RESPAWN_TOKEN";
  level._id_2A95._id_2A8A = "MP_BR_INGAME/ALREADY_HAVE_SELF_REVIVE_ITEM";
  level._id_2A95._id_2A8E = "MP/BR_ARMOR_DENY_ARMOR_FULL";
  level._id_2A95._id_2A91 = "MP/BR_PICKUP_DENY_PARACHUTING";
  level._id_2A95._id_2A89 = "MP_BR_INGAME/TABLET_PICKUP_FAILURE";
  level._id_2A95._id_2A92 = "MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED";
  level._id_2A95._id_2A93 = "MP_BR_INGAME/ARMOR_INSERT_IN_PROGRESS";
  level._id_2A95._id_2A3A = [(24, 24, 6), (-24, -24, 6), (24, -24, 6), (-24, 24, 6), (48, 0, 6), (-48, 0, 6), (0, -48, 6), (0, 48, 6), (72, 0, 6), (-72, 0, 6), (0, -72, 6), (0, 72, 6), (72, -72, 6), (-72, 72, 6), (-72, -72, 6), (72, 72, 6)];
  level._id_2A95._id_C6C8 = getdvarint("#x3a50c03fff9835370", 1);
  level._id_2A95._id_C6C6 = getdvarint("#x3e563d5287490113f", 0);
  _id_07A1::_id_CECB(::_id_989B);
  _id_07A1::_id_CEC6(::_id_989B);
}

_id_6ACD(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 1;
  var_7 = 1;
  var_8 = getdvarint("#x363945c9fc783b63d", 0);
  var_9 = 13;
  var_10 = 50.0;
  var_11 = 40.0;
  var_12 = -5.0;
  var_13 = 5.0;
  var_14 = 10.0;
  var_15 = 360.0 / var_9;
  var_16 = -5.0;
  var_17 = 5.0;
  var_18 = 40.0;
  var_19 = 20.0;
  var_20 = 60.0;
  var_21 = -6.0;
  var_22 = 16.0;
  var_23 = -18.0;
  var_24 = 0;
  var_25 = 0;
  var_26 = int(var_0 / var_9);
  var_27 = var_0 - var_26 * var_9;
  var_28 = var_2[1] + (var_27 * var_15 + var_26 * var_14) + randomfloatrange(var_16, var_17);
  var_29 = var_10 + var_26 * var_11 + randomfloatrange(var_12, var_13);

  if(isDefined(var_4)) {
    var_28 = var_2[1] + var_4;
  }

  if(isDefined(var_5)) {
    var_29 = var_5;
  }

  var_30 = (0.0, var_28, 0.0);
  var_31 = anglesToForward(var_30);
  var_32 = var_1 + var_31 * var_29;

  if(var_7) {
    var_33 = _func_0425(var_32, 500, 500);

    if(isDefined(var_3)) {
      var_33[var_33.size] = var_3;
    }

    var_34 = var_1 + (0.0, 0.0, var_19);
    var_35 = var_32 + (0.0, 0.0, var_19);
    var_36 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 1, 0, 1);
    var_37 = scripts\engine\trace::ray_trace(var_34, var_35, var_33, var_36);

    if(var_37["fraction"] < 1.0) {
      var_32 = var_37["position"];
      var_32 = var_32 + var_31 * var_23;
    } else
      var_32 = var_35;

    var_34 = var_32;
    var_35 = var_32 + (0.0, 0.0, var_20);
    var_37 = scripts\engine\trace::ray_trace(var_34, var_35, var_33, var_36);

    if(var_37["fraction"] < 1.0) {
      var_32 = var_37["position"] + (0.0, 0.0, var_21);
    } else {
      var_32 = var_35;
    }

    var_34 = var_32;
    var_38 = -1 * getdvarfloat("#x3e197f242f560b6aa", 2000.0);
    var_35 = var_32 + (0.0, 0.0, var_38);
    var_37 = scripts\engine\trace::ray_trace(var_34, var_35, var_33, var_36);

    if(var_37["fraction"] < 1.0) {
      var_32 = var_37["position"] + (0.0, 0.0, var_22);
    } else {
      var_32 = (0, 0, 0);
      var_24 = 1;
    }
  } else
    var_32 = var_32 + (0, 0, var_22);

  if(var_6 && !var_24) {
    var_25 = _func_03EB(var_1 + (0, 0, var_18), var_32);
  }

  return [var_32, var_30, var_25];
}

_id_6A5E(var_0, var_1) {
  if(isDefined(var_0) && isDefined(level._id_2A77[var_0]) && isDefined(level._id_2A77[var_0]._id_5FFB)) {
    if(isDefined(var_1) && isDefined(level._id_10D10)) {
      return [[level._id_10D10]](var_1, level._id_2A77[var_0]._id_5FFB);
    }

    return level._id_2A77[var_0]._id_5FFB;
  }

  return undefined;
}

_id_6A5D(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0._id_CF22)) {
    return _id_6A5E(var_0._id_CF22, var_1);
  }

  return undefined;
}

_id_6A84(var_0) {
  var_1 = ["none"];

  if(isDefined(var_0) && isDefined(level._id_2A95._id_2A55[var_0])) {
    var_1 = level._id_2A95._id_2A55[var_0];
  }

  return var_1;
}

_id_989B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 _meth_86FA() && var_0.type != "br_plunder_box" && !issubstr(var_0.type, "arena_evo_plunder_box")) {
    var_6 = spawnStruct();
    var_6._id_CF22 = var_0.type;
    var_6.origin = var_0.origin;
    var_6._id_011A = var_0._id_011A;
    var_6._id_82FC = var_0;
    var_6._id_427F = var_0._id_427F;
    var_6._id_9C5F = level._id_2A95._id_9C60[var_6._id_CF22];
    var_6._id_E503 = level._id_2A95._id_E503[var_6._id_CF22];

    if(!var_6._id_011A && isDefined(level._id_2A95._id_3DAB[var_6._id_CF22])) {
      var_6._id_011A = level._id_2A95._id_3DAB[var_6._id_CF22];
    }

    var_6._id_8B06 = var_0._id_8B06;
    var_6._id_8773 = var_4;
    var_7 = var_3 _id_31F1(var_6);

    if(var_7 == 1) {
      var_8 = var_3 _id_ABCF(var_6, undefined, var_4);

      if(isDefined(var_0) && var_8) {
        var_0._id_011A = var_6._id_011A;
      }

      if(!isDefined(var_0) || var_8) {
        return;
      }
      _id_9885(var_0);
    } else {
      var_9 = 1;
      var_10 = level._id_2A95._id_2A57[var_6._id_CF22];

      if(istrue(var_10) && var_2 == "visible") {
        var_9 = 0;
      }

      if(var_9) {
        var_3 _id_DCFB(var_7);
      }
    }
  }
}

_id_9885(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0.type;
  }

  if(_id_89D1(var_0.type)) {
    scripts\mp\gametypes\br_quest_util::_id_AB83(var_0);
  }

  if(var_0 _meth_86FB() && !istrue(var_0._id_8CC6)) {
    _id_4806(var_0);
    var_0 _meth_86BE();
  } else
    var_0 setscriptablepartstate(var_1, "hidden");
}

_id_2A46(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5._id_CF22 = var_1;
  var_5.origin = var_0.origin;
  var_5._id_011A = 0;
  var_5._id_9C5F = level._id_2A95._id_9C60[var_5._id_CF22];
  var_5._id_E503 = level._id_2A95._id_E503[var_5._id_CF22];

  if(isDefined(var_3)) {
    var_5._id_011A = var_3;
  }

  if(!var_5._id_011A && isDefined(level._id_2A95._id_3DAB[var_5._id_CF22])) {
    var_5._id_011A = level._id_2A95._id_3DAB[var_5._id_CF22];
  }

  var_6 = var_0 _id_31F1(var_5);

  if(var_6 == 1) {
    var_0 _id_ABCF(var_5, var_2, undefined, var_4);
    return 1;
  }

  return 0;
}

_id_C632(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  wait(var_0);
  _id_C631(var_1);
}

_id_C631(var_0) {
  self._id_2A62 = [];
  scripts\mp\gametypes\br_armor::_id_2B95();
  _id_2B97();

  if(isDefined(self._id_E9FF)) {
    scripts\mp\killstreaks\killstreaks::_id_394F();
  }

  if(!level._id_15D8) {
    _id_C649();
  }

  if(!istrue(var_0)) {
    scripts\mp\gametypes\br_weapons::_id_EA65();
    scripts\mp\equipment::_id_EDBD("primary");
    scripts\mp\equipment::_id_EDBD("secondary");
    self._id_8FC2 = makeweapon("s4_me_fists_mp");
  }

  if(scripts\mp\gametypes\br_public::_id_75AF()) {
    _id_C519();
  }
}

_id_C649() {
  scripts\mp\supers::_id_3987();
  self setclientomnvar("ui_perk_package_state", 0);
  self setclientomnvar("ui_super_progress", 0);
}

_id_C60F(var_0) {
  var_1 = self getweaponslistall();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = 0;

    if(var_3._id_0241 == "primary") {
      if(isDefined(var_0)) {
        var_5 = var_3._id_00EB;
        var_4 = var_5 * (var_0 - 1);
      } else if(level._id_992A > 0) {
        var_5 = var_3._id_00EB;
        var_4 = var_5 * (level._id_992A - 1);
      } else
        var_5 = 0;

      self setweaponammoclip(var_3, var_5);
    }
  }
}

_id_825B(var_0) {
  scripts\mp\gametypes\br_weapons::_id_29FF();
  _id_C631(var_0);
}

_id_E294(var_0) {
  foreach(var_2 in level.players) {
    if(!isbot(var_2) && isalive(var_2)) {
      var_3 = var_2.origin + anglesToForward(var_2.angles) * 20 + (0, 0, 12);
      var_4 = 0;

      if(isDefined(level._id_2A95._id_3DAB[var_0])) {
        var_4 = level._id_2A95._id_3DAB[var_0];
      }

      _id_E336(var_0, var_3, (0, 0, 0), var_4);
    }
  }
}

_id_8B0B(var_0) {
  return isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "weapon";
}

_id_8B0C(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_0._id_04F6)) {
    return istrue(var_0._id_04F6._id_87E1);
  } else if(isDefined(var_0._id_CF22)) {
    return _id_8B0B(var_0._id_CF22);
  }

  return 0;
}

_id_EDA8(var_0) {
  var_1 = level._id_2A95._id_2A42[var_0._id_CF22];
  var_2 = scripts\mp\gametypes\br_armor::_id_8762(var_1);

  if(var_2) {
    _id_F741(var_0);
  }
}

_id_EDBE(var_0, var_1) {
  var_2 = level._id_2A95._id_2A42[var_0._id_CF22];
  var_3 = level.equipment._id_EC5C[var_2]._id_45C7;
  var_4 = 0;

  if(_id_B0AF(var_2, var_3)) {
    if(_id_558A(var_0._id_CF22, var_3)) {
      if(var_3 != "health") {
        _id_07C4::_id_7B6B("br_ammo");
      }

      var_5 = scripts\mp\equipment::_id_6A15(var_3);
      var_6 = level._id_2A95._id_9C60[var_0._id_CF22];

      if(var_5 + var_0._id_011A > var_6) {
        var_7 = var_6 - var_5;
        scripts\mp\equipment::_id_D543(var_2, var_6);
        var_0._id_011A = var_0._id_011A - var_7;
        var_4 = 1;
      } else
        scripts\mp\equipment::_id_7DEE(var_3, var_0._id_011A);
    } else if(!getdvarint("#x37cbb0fd1da5c320a", 1))
      _id_F752(var_0._id_CF22, var_0._id_011A);
  } else if(!isDefined(self.equipment[var_3]) || scripts\mp\equipment::_id_6A15(var_3) == 0) {
    scripts\mp\equipment::giveequipment(var_2, var_3);
    scripts\mp\equipment::_id_D543(var_2, var_0._id_011A);
  } else if(!getdvarint("#x37cbb0fd1da5c320a", 1)) {
    var_8 = 1;

    if(isDefined(var_0._id_011A)) {
      var_8 = var_0._id_011A;
    }

    _id_F752(var_0._id_CF22, var_8);
  } else {
    _id_502D(var_3, var_1);
    scripts\mp\equipment::giveequipment(var_2, var_3);
    scripts\mp\equipment::_id_D543(var_2, var_0._id_011A);
  }

  if(var_3 == "health" && getdvarint("#x319d0418d7f12962d", 0)) {}

  return var_4;
}

_id_502D(var_0, var_1) {
  var_2 = scripts\mp\equipment::_id_6A15(var_0);
  var_3 = scripts\engine\utility::_id_1BAB(level._id_2A95._id_2A42, self.equipment[var_0]);

  if(isDefined(var_3)) {
    var_4 = undefined;

    if(istrue(var_1)) {
      var_4 = scripts\mp\gametypes\br_armory_kiosk::_id_6AEF();
    }

    [var_6, var_7, var_8] = _id_6ACD(0, self.origin, self.angles, self, var_4);
    _id_E336(var_3, var_6, var_7, var_2, 1, var_8);
  }
}

_id_B0AF(var_0, var_1) {
  if(isDefined(self.equipment[var_1]) && self.equipment[var_1] == var_0) {
    return 1;
  }

  return 0;
}

_id_558A(var_0, var_1) {
  if(scripts\mp\equipment::_id_6A15(var_1) < level._id_2A95._id_9C60[var_0]) {
    return 1;
  }

  return 0;
}

_id_EDD6(var_0) {
  if(!_id_C6C7() && !scripts\mp\gametypes\br_public::_id_75A4()) {
    _id_1122();
    return 1;
  }

  return 0;
}

_id_1122(var_0) {
  var_1 = self;
  var_1._id_75A4 = 1;
  var_1 scripts\mp\gametypes\br_public::_id_FC1A("hasRespawnToken", 1);

  if(!istrue(var_0)) {
    var_1 thread scripts\mp\hud_message::showsplash("br_respawn_token_pickup");
  }
}

_id_C514() {
  var_0 = self;
  var_0._id_75A4 = 0;
  var_0 scripts\mp\gametypes\br_public::_id_FC1A("hasRespawnToken", 0);
}

_id_EDD7(var_0) {
  if(!scripts\mp\gametypes\br_public::_id_75AF()) {
    _id_1129();
    return 1;
  }

  return 0;
}

_id_1129(var_0) {
  var_1 = self;
  var_1._id_75AF = 1;
  var_1 scripts\mp\gametypes\br_public::_id_FC1A("hasSelfReviveToken", 1);

  if(!istrue(var_0)) {
    var_1 thread scripts\mp\hud_message::showsplash("br_self_revive_token_pickup");
  }

  var_2 = level.maxteamsize == 1;

  if(var_2 && !var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    var_1 scripts\mp\utility\perk::_id_6FC2("specialty_pistoldeath");
  }
}

_id_C519() {
  var_0 = self;
  var_0._id_75AF = 0;
  var_0 scripts\mp\gametypes\br_public::_id_FC1A("hasSelfReviveToken", 0);
  var_1 = level.maxteamsize == 1;

  if(var_1 && var_0 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    var_0 scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
  }
}

_id_C6C7() {
  return getdvarint("#x32aa91d1834bc79f8", 0) || !istrue(level._id_2A95._id_C6C8) || istrue(level._id_2A95._id_C6C6) && isDefined(level._id_7262) && istrue(level._id_7262._id_DD08);
}

_id_5EA6(var_0, var_1, var_2) {
  self notify("cancel_all_killstreak_deployments");

  if(istrue(var_1)) {
    _id_501B(var_2);
  } else {
    scripts\mp\killstreaks\killstreaks::_id_394F();
  }

  scripts\mp\killstreaks\killstreaks::_id_1FC8(var_0, self, undefined, undefined, undefined, 1);
}

_id_EDC7(var_0, var_1) {
  var_2 = level._id_2A95._id_2A69[var_0._id_CF22];
  _id_5EA6(var_2, 1, var_1);
}

_id_7538() {
  if(isDefined(self._id_E9FF) && isDefined(self._id_E9FF._id_EA14) && self._id_E9FF._id_EA14.size > 0) {
    return isDefined(self._id_E9FF._id_EA14[1]);
  }

  return 0;
}

_id_757A(var_0) {
  return _id_7538() && self._id_E9FF._id_EA14[1].streakname == var_0;
}

_id_5ED4(var_0) {
  if(_id_7538()) {
    scripts\mp\killstreaks\killstreaks::_id_C4DC(1);
  }

  scripts\mp\killstreaks\killstreaks::_id_1FC8(var_0, self);
  var_1 = scripts\mp\killstreaks\killstreaks::_id_6AE4(1);
  var_2 = scripts\mp\killstreaks\killstreaks::_id_F62A(var_1, 1);

  if(!var_2) {
    scripts\mp\killstreaks\killstreaks::_id_C4DC(1);
  }

  return var_2;
}

_id_0C11(var_0, var_1, var_2) {
  if(level._id_15D8) {
    _id_0A6C::_id_AFDF(var_1);
  } else {
    _id_0A6C::_id_AFDE(var_1);
    self setclientomnvar("ui_perk_package_state", 3);
    self setclientomnvar("ui_perk_package_super1", scripts\mp\supers::_id_6DA1(var_1));
    self setclientomnvar("ui_super_progress", 1);
  }

  scripts\mp\equipment::giveequipment(var_0, "super");
  scripts\mp\equipment::_id_D543(var_0, var_2);
}

_id_EDD9(var_0, var_1) {
  var_2 = level._id_2A95._id_2A42[var_0._id_CF22];
  var_3 = level._id_2A95._id_2ABF[var_0._id_CF22];

  if(isDefined(self.equipment["super"]) && scripts\mp\equipment::_id_6A15("super") > 0) {
    _id_502D("super", var_1);
  }

  _id_0C11(var_2, var_3, var_0._id_011A);

  if(level._id_15D8) {
    scripts\mp\supers::_id_6FF9(scripts\mp\supers::_id_6DA3());
  }
}

_id_5EA7(var_0, var_1, var_2) {
  var_3 = undefined;

  foreach(var_6, var_5 in level._id_2A95._id_2ABF) {
    if(var_5 == var_0) {
      var_3 = var_6;
      break;
    }
  }

  var_7 = level._id_2A95._id_2A42[var_3];

  if(istrue(var_1)) {
    if(isDefined(self.equipment["super"]) && scripts\mp\equipment::_id_6A15("super") > 0) {
      _id_502D("super", var_2);
    }
  }

  _id_0C11(var_7, var_0, 1);
}

_id_EDC0(var_0, var_1) {
  if(_id_0792::_id_7567(self)) {
    var_2 = undefined;

    if(istrue(var_1)) {
      var_2 = scripts\mp\gametypes\br_armory_kiosk::_id_6AEF();
    }

    [var_4, var_5, var_6] = _id_6ACD(0, self.origin, self.angles, self, var_2);
    _id_E336("brloot_equip_gasmask", var_4, var_5, int(self._id_61D5), 1, var_6);
  }

  _id_0792::init(var_0._id_011A);
  thread _id_75E8();
}

_id_75E8() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("toggle_gasmask");

    if(istrue(self._id_61D9)) {
      continue;
    }
    if(!istrue(self._id_61D4)) {
      thread _id_5550();
      continue;
    }

    thread _id_C4C7();
  }
}

_id_31AF() {
  var_0 = self;
  return !(var_0 scripts\cp_mp\utility\player_utility::isinvehicle(1) || var_0 _meth_86B7() || var_0 _meth_86B8() || var_0 _meth_87AF());
}

_id_5550() {
  self endon("death_or_disconnect");
  self playsoundtoplayer("br_gas_mask_on_plr", self);
  self._id_61D9 = 1;
  thread _id_46BA(0.2);
  var_0 = self _meth_8495("ges_magma_gas_mask_on");

  if(_id_31AF()) {
    thread scripts\mp\gametypes\br_public::_id_B741("iw8_ges_plyr_gasmask_on", var_0);
  }

  thread _id_0792::_id_4029(0.1, 0.5);
  wait(var_0);
  self._id_61D9 = 0;
  self._id_61D4 = 1;
  _id_09BE::_id_525B();

  if(isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
    self _meth_84A8("gender", "gasmask_female", 0.1);
  } else {
    self _meth_84A8("gender", "gasmask_male", 0.1);
  }

  if(self._id_61D5 <= 0) {
    _id_2B97();
  }
}

_id_C4C7() {
  self endon("death_or_disconnect");

  if(!istrue(self._id_61D4)) {
    return;
  }
  self playsoundtoplayer("br_gas_mask_off_plr", self);
  var_0 = self _meth_8495("ges_magma_gas_mask_off");
  thread _id_46BB(1.3);

  if(_id_31AF()) {
    thread scripts\mp\gametypes\br_public::_id_B741("iw8_ges_plyr_gasmask_off", var_0);
  }

  self._id_61D9 = 1;
  thread _id_0792::_id_485F(0.1, 0.55);
  wait(var_0);
  self._id_61D9 = 0;
  _id_09BE::_id_4ACB();

  if(isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
    self _meth_84A8("gender", "female", 0.1);
  } else {
    self _meth_84A8("gender", "", 0.1);
  }
}

_id_2B97() {
  if(!istrue(self._id_61D4)) {
    return;
  }
  self playsoundtoplayer("br_gas_mask_crack_plr", self);
  thread _id_46BC(0.6);

  if(isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
    self _meth_84A8("gender", "female", 0.1);
  } else {
    self _meth_84A8("gender", "", 0.1);
  }

  self playsoundtoplayer("br_gas_mask_depleted_plr", self);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
  self._id_61D5 = undefined;
  var_0 = self _meth_8495("ges_magma_gas_mask_break");
  thread scripts\mp\gametypes\br_public::_id_B741("iw8_ges_plyr_gasmask_break", var_0);
  self._id_61D9 = 1;
  _id_0792::_id_D4A7();
  thread _id_0792::_id_485F(0.1, 0.36);
  wait(var_0);
  self._id_61D9 = 0;
}

_id_46BA(var_0) {
  self endon("death_or_disconnect");

  if(isDefined(var_0) && var_0 > 0.0) {
    wait(var_0);
  }

  self attach("hat_child_hadir_gas_mask_wm_br", "j_head");
}

_id_46BB(var_0) {
  self endon("death_or_disconnect");

  if(isDefined(var_0) && var_0 > 0.0) {
    wait(var_0);
  }

  if(self._id_61D4) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self._id_61D4 = 0;
  }
}

_id_46BC(var_0) {
  self endon("death_or_disconnect");

  if(isDefined(var_0) && var_0 > 0.1) {
    wait(var_0 - 0.1);
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_gas_mask_break"), self, "tag_weapon_left");
  wait 0.1;

  if(self._id_61D4) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self._id_61D4 = 0;
  }
}

_id_3189(var_0) {
  if(!isDefined(self._id_29F9[var_0])) {
    return 1;
  }

  return !scripts\mp\gametypes\br_weapons::_id_2A08(self, var_0);
}

_id_8AFB(var_0) {
  return isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "armor" && issubstr(var_0, "vest");
}

_id_8879(var_0) {
  return isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "gear" && issubstr(var_0, "gasmask");
}

_id_89AF(var_0) {
  return isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "plunder";
}

_id_89D1(var_0) {
  return isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "tablet";
}

_id_897C(var_0) {
  return isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "perkpoint";
}

_id_8AA5(var_0) {
  return isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "token";
}

_id_8A05(var_0) {
  return isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "revive";
}

_id_88E9(var_0) {
  return isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "killstreak";
}

_id_8A7A(var_0) {
  return !_id_894B(var_0) && (isDefined(level._id_2A95._id_2A67[var_0]) && level._id_2A95._id_2A67[var_0] == "super");
}

_id_89B0(var_0) {
  return var_0 == "brloot_plunder_extract";
}

_id_894B(var_0) {
  return var_0 == "br_loot_cache" || _id_89D1(var_0);
}

_id_31F1(var_0) {
  if(self isskydiving()) {
    return 9;
  }

  if(scripts\mp\gametypes\br_public::_id_8750(var_0._id_CF22)) {
    if(!_id_3189(var_0._id_CF22)) {
      return 3;
    } else {
      return 1;
    }
  }

  if(_id_8B0C(var_0)) {
    if(istrue(self._id_82E8)) {
      return 13;
    }

    return 1;
  }

  if(scripts\mp\gametypes\br_public::_id_8835(var_0._id_CF22)) {
    var_1 = level._id_2A95._id_2A42[var_0._id_CF22];
    var_2 = level.equipment._id_EC5C[var_1]._id_45C7;
    var_3 = istrue(var_0._id_8773);
    var_4 = 1;

    if(isDefined(var_0._id_011A)) {
      var_4 = var_0._id_011A;
    }

    if(var_3 && (var_2 == "primary" || var_2 == "secondary")) {
      if(isDefined(self.equipment[var_2]) && _id_B0AF(var_1, var_2) && _id_558A(var_0._id_CF22, var_2)) {
        return 1;
      }

      return 12;
    }

    if(!isDefined(self.equipment[var_2]) || scripts\mp\equipment::_id_6A15(var_2) == 0) {
      return 1;
    }

    if(_id_B0AF(var_1, var_2)) {
      if(_id_558A(var_0._id_CF22, var_2)) {
        return 1;
      } else if(getdvarint("#x37cbb0fd1da5c320a", 1)) {
        return 4;
      }
    }

    if(getdvarint("#x37cbb0fd1da5c320a", 1)) {
      return 1;
    }

    if(!_id_31D9(var_0._id_CF22, var_4)) {
      return 4;
    } else {
      return 1;
    }
  }

  if(_id_89AF(var_0._id_CF22)) {
    if(self._id_B956 >= level._id_2A9B._id_B967) {
      return 11;
    }

    return 1;
  }

  if(_id_8879(var_0._id_CF22)) {
    return 1;
  }

  if(_id_89D1(var_0._id_CF22)) {
    if(scripts\engine\utility::array_contains(level._id_BEAF._id_EFA9, self.team)) {
      return 10;
    } else {
      return 1;
    }
  }

  if(_id_897C(var_0._id_CF22)) {
    return 1;
  }

  if(_id_8AA5(var_0._id_CF22)) {
    if(var_0._id_CF22 == "brloot_respawn_token") {
      if(scripts\mp\gametypes\br_public::_id_75A4()) {
        return 8;
      } else {
        return 1;
      }
    }

    return 1;
  }

  if(_id_8A05(var_0._id_CF22)) {
    if(var_0._id_CF22 == "brloot_self_revive") {
      if(scripts\mp\gametypes\br_public::_id_75AF()) {
        return 14;
      } else {
        return 1;
      }
    }

    return 1;
  }

  if(_id_88E9(var_0._id_CF22)) {
    if(isDefined(self._id_E9FF) && isDefined(self._id_E9FF._id_EA14) && self._id_E9FF._id_EA14.size > 0 && self._id_E9FF._id_EA14[1].streakname == level._id_2A95._id_2A69[var_0._id_CF22]) {
      return 7;
    } else {
      return 1;
    }
  }

  if(_id_8A7A(var_0._id_CF22)) {
    if(scripts\mp\supers::_id_8A79()) {
      return 4;
    }

    return 1;
  }

  if(scripts\mp\gametypes\br_public::_id_8761(var_0._id_CF22)) {
    if(scripts\mp\gametypes\br_armor::_id_8762(level._id_2A95._id_2A42[var_0._id_CF22])) {
      return 1;
    } else {
      return 6;
    }
  }

  if(var_0._id_CF22 == "brloot_ammo_grenade") {
    var_5 = scripts\mp\equipment::_id_6A15("primary");
    var_6 = scripts\mp\equipment::_id_6A15("secondary");

    if(isDefined(var_5) && var_5 < 2 || isDefined(var_6) && var_6 < 2) {
      return 1;
    } else {
      return 3;
    }
  }

  if(var_0._id_CF22 == "Pillage_Cache") {
    return 1;
  }

  return 2;
}

_id_8812(var_0) {
  if(scripts\mp\weapons::_id_885E(var_0) || scripts\mp\utility\weapon::_id_8888(var_0)) {
    return 0;
  }

  return 1;
}

_id_E336(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 0;
  var_9 = undefined;

  if(isDefined(level._id_2A95._id_2AD2[var_0])) {
    var_9 = level._id_2A95._id_2AD2[var_0];
  } else if(scripts\mp\gametypes\br_weapons::_id_8AE2(var_6)) {
    if(scripts\mp\utility\game::_id_875D()) {
      var_10 = getcompleteweaponname(var_6 _meth_8625());
      var_10 = scripts\mp\utility\script::_id_EA63(var_10, "_mp");
      var_11 = scripts\mp\gametypes\arena_evo_tourney_weapon_util::arenatournament_get_weapon_level_from_name(var_0);
      var_12 = scripts\mp\gametypes\arena_evo_tourney_weapon_util::arenatournament_get_weapon_rarity_from_level(var_10, var_11);
      var_9 = scripts\mp\gametypes\arena_evo_tourney_loot::_id_6739(var_10, var_12);
    } else {
      var_13 = _func_00D6(var_6.basename, 4, 6);

      if(var_13 != "me" && var_13 != "pi" && var_13 != "sh" && var_13 != "sm" && var_13 != "ar" && var_13 != "lm" && var_13 != "dm" && var_13 != "sn" && var_13 != "la" && var_13 != "kn") {
        return;
      }
      var_8 = 1;
      var_9 = "brloot_weapon_generic_" + var_13;
    }
  } else if(_id_8812(var_0))
    var_9 = var_0;

  if(var_1 == (0, 0, 0)) {
    return;
  }
  if(!isDefined(var_9)) {
    return;
  }
  _id_3980();

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(var_8) {
    var_14 = _func_03F1(var_9, var_1, var_2, var_5, var_6);

    if(isDefined(var_14)) {
      var_14._id_427F = getcompleteweaponname(var_6);
    }
  } else
    var_14 = _func_03C5(var_9, var_1, var_2, var_5);

  if(!isDefined(var_14)) {
    return;
  }
  _id_C2AE(var_14);

  if(isDefined(var_3)) {
    var_14._id_011A = var_3;
  } else {
    var_14._id_011A = 0;
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(!istrue(level._id_2A95._id_2A57[var_9])) {
    var_7 = 1;
  }

  if(!getdvarint("#x3b40675df95de7ac3")) {
    if(istrue(var_4)) {
      if(var_7) {
        var_14 setscriptablepartstate(var_9, "dropped");
      } else {
        var_14 setscriptablepartstate(var_9, "droppedNoAuto");
      }
    }
  }

  if(var_9 == "brloot_equip_gasmask") {
    level._id_2A95._id_5047[level._id_2A95._id_5047.size] = var_14;
  }

  return var_14;
}

_id_DCFB(var_0) {
  switch (var_0) {
    case 5:
      scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A8C);
      return;
    case 3:
      scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A8D);
      return;
    case 4:
      scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A90);
      return;
    case 6:
      scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A8F);
      return;
    case 7:
      scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A88);
      return;
    case 8:
      scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A8B);
      return;
    case 14:
      scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A8A);
      return;
    case 9:
      scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A91);
      return;
    case 10:
      scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A89);
      return;
    case 11:
      scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A92);
      return;
    case 13:
      scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A93);
      return;
    case 2:
      break;
  }
}

_id_0CB9(var_0, var_1) {
  var_0 notify("reset_cash_wait");
  var_0 endon("reset_cash_wait");
  wait(var_1);
  var_0._id_2A17 = undefined;
  var_0._id_2A18 = undefined;
}

_id_694F(var_0, var_1) {
  var_2 = "br_pickup_cash";
  var_3 = 5000.0;
  var_4 = var_3 / 1000.0;
  var_5 = gettime();

  if(isPlayer(var_0)) {
    if(!isDefined(var_0._id_2A17)) {
      var_0._id_2A17 = 0;
    }

    if(!isDefined(var_0._id_2A18)) {
      var_0._id_2A18 = var_5;
    }

    var_6 = var_5 - var_0._id_2A18;
    var_0._id_2A18 = var_5;

    if(var_6 < var_3) {
      var_0._id_2A17 = var_0._id_2A17 + 1;
    }

    var_0 thread _id_0CB9(var_0, var_4);

    switch (var_1) {
      case "brloot_plunder_cash_uncommon_2":
      case "brloot_plunder_cash_uncommon_1":
      case "brloot_plunder_cash_common_1":
      default:
        switch (var_0._id_2A17) {
          case 1:
          case 0:
            var_2 = "br_pickup_cash_01";
            break;
          case 2:
            var_2 = "br_pickup_cash_02";
            break;
          case 3:
            var_2 = "br_pickup_cash_03";
            break;
          case 4:
            var_2 = "br_pickup_cash_04";
            break;
          case 5:
          default:
            var_2 = "br_pickup_cash_05";
            break;
        }

        break;
      case "brloot_plunder_cash_rare_1":
      case "brloot_plunder_cash_uncommon_3":
        switch (var_0._id_2A17) {
          case 1:
          case 0:
            var_2 = "br_pickup_cash_med_01";
            break;
          case 2:
            var_2 = "br_pickup_cash_med_02";
            break;
          case 3:
            var_2 = "br_pickup_cash_med_03";
            break;
          case 4:
            var_2 = "br_pickup_cash_med_04";
            break;
          case 5:
          default:
            var_2 = "br_pickup_cash_med_05";
            break;
        }

        break;
      case "brloot_plunder_cash_epic_2":
      case "brloot_plunder_cash_epic_1":
      case "brloot_plunder_cash_rare_2":
        switch (var_0._id_2A17) {
          case 1:
          case 0:
            var_2 = "br_pickup_cash_lrg_01";
            break;
          case 2:
            var_2 = "br_pickup_cash_lrg_02";
            break;
          case 3:
            var_2 = "br_pickup_cash_lrg_03";
            break;
          case 4:
            var_2 = "br_pickup_cash_lrg_04";
            break;
          case 5:
          default:
            var_2 = "br_pickup_cash_lrg_05";
            break;
        }

        break;
      case "brloot_plunder_cash_legendary_1":
        switch (var_0._id_2A17) {
          case 1:
          case 0:
            var_2 = "br_pickup_cash_vlrg_01";
            break;
          case 2:
            var_2 = "br_pickup_cash_vlrg_02";
            break;
          case 3:
            var_2 = "br_pickup_cash_vlrg_03";
            break;
          case 4:
            var_2 = "br_pickup_cash_vlrg_04";
            break;
          case 5:
          default:
            var_2 = "br_pickup_cash_vlrg_05";
            break;
        }

        break;
    }
  }

  return var_2;
}

_id_ABCF(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("disconnect");
  var_4 = 0;

  if(!isDefined(var_0._id_011A)) {
    var_0._id_011A = 0;
  }

  if(!istrue(var_1)) {
    var_5 = "br_pickup_generic";
    var_6 = undefined;

    if(isDefined(var_0._id_CF22)) {
      if(_id_89AF(var_0._id_CF22)) {
        var_5 = _id_694F(self, var_0._id_CF22);
      } else if(isDefined(level._id_2A95._id_2A97[var_0._id_CF22]) && level._id_2A95._id_2A97[var_0._id_CF22].size > 0) {
        var_5 = level._id_2A95._id_2A97[var_0._id_CF22];
      } else if(_id_8B0C(var_0)) {
        var_5 = "br_pickup_weap";
      } else {
        var_5 = "br_pickup_ammo";
      }

      if(_id_89AF(var_0._id_CF22)) {
        var_6 = "br_plunder";
      } else if(scripts\mp\gametypes\br_public::_id_8750(var_0._id_CF22)) {
        var_6 = "br_ammo";
      } else if(scripts\mp\gametypes\br_public::_id_8763(var_0._id_CF22)) {
        var_6 = "br_armor";
      }
    }

    if(!scripts\mp\utility\game::_id_875D() && !scripts\mp\utility\game::isbasegametype()) {
      if(!getdvarint("#x319d0418d7f12962d", 0)) {
        self playsoundtoplayer(var_5, self);
      }
    }

    if(isDefined(var_6)) {
      _id_07C4::_id_7B6B(var_6);
    }

    if(!istrue(var_2) && !getdvarint("#x319d0418d7f12962d", 0)) {
      thread _id_B744(var_0);
    }
  }

  level notify("pickedupweapon_kill_callout_" + var_0._id_CF22 + var_0.origin);

  if(_id_89AF(var_0._id_CF22)) {
    self notify("self_pickedupitem_plunder");
  } else {
    self notify("self_pickedupitem_" + var_0._id_CF22);
  }

  if(_id_8B0C(var_0)) {
    scripts\mp\gametypes\br_weapons::_id_EDDC(var_0);
    _id_07BC::_id_AB51("weapon");
  } else if(scripts\mp\gametypes\br_public::_id_8750(var_0._id_CF22))
    var_4 = scripts\mp\gametypes\br_weapons::_id_EDA7(var_0);
  else if(scripts\mp\gametypes\br_public::_id_8835(var_0._id_CF22)) {
    var_4 = _id_EDBE(var_0, var_3);
  } else if(scripts\mp\gametypes\br_public::_id_8761(var_0._id_CF22)) {
    _id_EDA8(var_0);
  } else if(var_0._id_CF22 == "Pillage_Cache") {
    scripts\mp\gametypes\pill::_id_6FFD();
  } else if(_id_89AF(var_0._id_CF22)) {
    scripts\mp\gametypes\br_plunder::_id_EDD2(var_0);
    _id_07BC::_id_AB51("plunder");
  } else if(_id_8AA5(var_0._id_CF22))
    _id_EDD6(var_0);
  else if(_id_8A05(var_0._id_CF22)) {
    _id_EDD7(var_0);
  } else if(_id_88E9(var_0._id_CF22)) {
    _id_EDC7(var_0, var_3);
  } else if(_id_8A7A(var_0._id_CF22)) {
    _id_EDD9(var_0, var_3);
  } else if(_id_8879(var_0._id_CF22)) {
    _id_EDC0(var_0, var_3);
  } else if(_id_89D1(var_0._id_CF22)) {
    scripts\mp\gametypes\br_quest_util::_id_EDD4(var_0._id_82FC);
  } else if(var_0._id_CF22 == "brloot_ammo_grenade") {
    _id_EDC1(var_0);
  } else {
    var_7 = 1;

    if(isDefined(var_0._id_011A)) {
      var_7 = var_0._id_011A;
    }

    _id_F752(var_0._id_CF22, var_7);
  }

  var_7 = 1;

  if(isDefined(var_0._id_011A)) {
    var_7 = var_0._id_011A;
  }

  scripts\mp\gametypes\br_analytics::_id_2AFD(self, var_0._id_CF22, var_7);
  return var_4;
}

_id_B744(var_0) {
  self notify("playerPlayPickupAnim");
  self endon("playerPlayPickupAnim");
  self endon("death");
  self endon("disconnect");

  if(_id_8B0C(var_0) || !scripts\mp\gametypes\br_public::_id_B66F()) {
    return;
  }
  var_1 = makeweapon("iw8_ges_plyr_loot_pickup");

  if(self hasweapon(var_1)) {
    if(self _meth_84B7("iw8_ges_pickup_br")) {
      self _meth_8494("iw8_ges_pickup_br", 0, 1);
    }

    self takeweapon(var_1);
    waitframe();
  }

  scripts\mp\gametypes\br_public::_id_B741("iw8_ges_plyr_loot_pickup", 1.17);
}

_id_5041(var_0) {
  if(istrue(level._id_FE76) && scripts\mp\gametypes\br_public::_id_8990()) {
    return;
  }
  _id_5013();

  if(!istrue(level._id_DDCC)) {
    _id_5020();
  }

  if(!istrue(level._id_DDAD)) {
    _id_5018();
  }

  _id_501A();
  scripts\mp\gametypes\br_plunder::_id_B69D(13, var_0);
  _id_5019();
  _id_501B();
  _id_5021();
  var_0 = self._id_8FFD;

  if(isDefined(var_0)) {
    _id_5014(var_0);
  }

  self notify("canSpawnAsSpectator");
}

_id_5013() {
  var_0 = 0;
  var_1 = 4;

  foreach(var_3 in level._id_2A09) {
    if(var_0 > var_1) {
      var_0 = var_0 + 12;
      var_1 = var_1 + 12;
    }

    if(self._id_29F9[var_3] > 0 && isDefined(level._id_2A95._id_2A66[var_3])) {
      var_4 = var_3;
      [var_6, var_7, var_8] = _id_6ACD(var_0, self.origin, self.angles, self);
      _id_E336(var_4, var_6, var_7, self._id_29F9[var_3], 1, var_8);
      var_0++;
    }
  }
}

_id_5020() {
  var_0 = 5;
  var_1 = 6;

  foreach(var_3 in self._id_019F) {
    if(var_0 > var_1) {
      var_0 = var_0 + 12;
      var_1 = var_1 + 12;
    }

    if(_id_DB4A(var_3)) {
      [var_5, var_6, var_7] = _id_6ACD(var_0, self.origin, self.angles, self);
      var_8 = self getweaponammoclip(var_3);
      var_9 = scripts\mp\gametypes\br_weapons::_id_3FC1(var_3, var_5, var_6, 0, 1, var_7);

      if(isDefined(var_9)) {
        var_9._id_011A = var_8;
        var_0++;
      }
    }
  }
}

_id_DB4A(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  if(var_1 == "s4_me_fists" || var_1 == "iw8_knifestab" || var_1 == "s4_gunless") {
    return 0;
  }

  if(!isweapon(var_0)) {
    return 0;
  }

  if(var_0._id_0241 != "primary") {
    return 0;
  }

  return 1;
}

_id_5018(var_0) {
  var_1 = 7;

  if(isDefined(self.equipment["primary"])) {
    var_2 = scripts\mp\equipment::_id_6A15("primary");

    if(var_2 < 1) {
      return;
    }
    var_3 = scripts\engine\utility::_id_1BAB(level._id_2A95._id_2A42, self.equipment["primary"]);

    if(isDefined(var_3)) {
      [var_5, var_6, var_7] = _id_6ACD(var_1, self.origin, self.angles, self);
      _id_E336(var_3, var_5, var_6, var_2, 1, var_7);
    }
  }

  var_1++;

  if(isDefined(self.equipment["secondary"])) {
    var_2 = scripts\mp\equipment::_id_6A15("secondary");

    if(var_2 < 1) {
      return;
    }
    var_3 = scripts\engine\utility::_id_1BAB(level._id_2A95._id_2A42, self.equipment["secondary"]);

    if(isDefined(var_3)) {
      [var_5, var_6, var_7] = _id_6ACD(var_1, self.origin, self.angles, self);
      _id_E336(var_3, var_5, var_6, var_2, 1, var_7);
    }
  }
}

_id_5021() {
  if(isDefined(self.equipment["super"]) && istrue(level._id_15B8)) {
    var_0 = scripts\mp\supers::_id_69B0();

    if(!isDefined(var_0) || var_0 != "super_fulton") {
      return;
    }
    var_1 = scripts\mp\equipment::_id_6A15("super");

    if(var_1 < 1) {
      return;
    }
    var_2 = scripts\engine\utility::_id_1BAB(level._id_2A95._id_2A42, self.equipment["super"]);

    if(isDefined(var_2)) {
      [var_4, var_5, var_6] = _id_6ACD(12, self.origin, self.angles, self);
      _id_E336(var_2, var_4, var_5, var_1, 1, var_6);
    }
  }
}

_id_501A() {
  var_0 = 0;
  var_1 = undefined;

  if(isDefined(self.equipment["health"])) {
    var_1 = level._id_2A95._id_2A43[self.equipment["health"]];
    var_0 = scripts\mp\equipment::_id_6A15("health");
  } else if(getDvar("#x3f59526763711edc4", "") == "dmz" && istrue(level._id_5E79)) {
    var_1 = level._id_2A95._id_2A43["equip_armorplate"];
    var_0 = 1;
  }

  if(var_0 > 0 && isDefined(var_1)) {
    [var_3, var_4, var_5] = _id_6ACD(9, self.origin, self.angles, self);
    _id_E336(var_1, var_3, var_4, var_0, 1, var_5);
  }
}

_id_5019() {
  if(_id_0792::_id_7567(self)) {
    var_0 = 10;
    [var_2, var_3, var_4] = _id_6ACD(var_0, self.origin, self.angles, self);
    _id_E336("brloot_equip_gasmask", var_2, var_3, int(self._id_61D5), 1, var_4);
    _id_0792::_id_485F();
    self._id_61D5 = undefined;
    self setclientomnvar("ui_head_equip_class", 0);
    self setclientomnvar("ui_gasmask_damage", 0);
  }
}

_id_501B(var_0) {
  if(_id_7538()) {
    var_1 = undefined;

    if(istrue(var_0)) {
      var_1 = scripts\mp\gametypes\br_armory_kiosk::_id_6AEF();
    }

    [var_3, var_4, var_5] = _id_6ACD(0, self.origin, self.angles, self, var_1);
    _id_E336(level._id_2A95._id_2A6A[self._id_E9FF._id_EA14[1].streakname], var_3, var_4);
    scripts\mp\killstreaks\killstreaks::_id_C4DC(1);
  }
}

_id_5014(var_0) {
  var_1 = 11;

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_br_ammoscavenger")) {
    var_2 = scripts\mp\gametypes\br_weapons::_id_2A07(var_0._id_0133);
    [var_4, var_5, var_6] = _id_6ACD(var_1, self.origin, self.angles, self);
    _id_E336(var_2, var_4, var_5, var_0._id_0133._id_0404, 1, var_6);
    var_1 = var_1 + 12;
  }

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_br_armorscavenger")) {
    [var_4, var_5, var_6] = _id_6ACD(var_1, self.origin, self.angles, self);
    _id_E336("Armor_Plate", var_4, var_5, 1, 1, var_6);
    var_1 = var_1 + 12;
  }

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_br_medicscavenger")) {
    [var_4, var_5, var_6] = _id_6ACD(var_1, self.origin, self.angles, self);
    _id_E336("First_Aid", var_4, var_5, 1, 1, var_6);
    var_1 = var_1 + 12;
  }

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_br_plunderscavenger")) {
    scripts\mp\gametypes\br_plunder::_id_5052(50, var_1);
  }
}

_id_8980(var_0) {
  return level._id_2A95._id_E503[var_0];
}

_id_88DB() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    if(!isDefined(self._id_2A62[var_0])) {
      return 1;
    }
  }

  return 0;
}

_id_88DA(var_0, var_1) {
  return var_1 + var_0._id_011A > var_0._id_9C5F;
}

_id_31E2(var_0, var_1) {
  foreach(var_3 in self._id_2A62) {
    if(isDefined(var_3._id_CF22) && var_3._id_CF22 == var_0) {
      if(!_id_88DA(var_3, var_1)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_31D9(var_0, var_1) {
  if(_id_8980(var_0)) {
    if(_id_31E2(var_0, var_1)) {
      return 1;
    }
  }

  return _id_88DB();
}

_id_6A3E() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    if(!isDefined(self._id_2A62[var_0])) {
      return var_0;
    }
  }

  return -1;
}

_id_B0B0(var_0) {
  if(_id_8980(var_0._id_CF22)) {
    if(_id_31E2(var_0._id_CF22, var_0._id_011A)) {
      foreach(var_3, var_2 in self._id_2A62) {
        if(isDefined(var_2._id_CF22) && var_2._id_CF22 == var_0._id_CF22) {
          if(!_id_88DA(var_2, var_0._id_011A)) {
            var_2._id_011A = var_2._id_011A + var_0._id_011A;
            var_2._id_011A = int(min(var_2._id_011A, var_0._id_9C5F));
            return;
          }
        }
      }
    }
  }

  var_4 = _id_6A3E();

  if(var_4 == -1) {
    return;
  }
  self._id_2A62[var_4] = var_0;
}

_id_5035(var_0) {
  if(isDefined(self._id_2A62[var_0])) {
    var_1 = self._id_2A62[var_0];
    var_2 = _id_E336(var_1._id_CF22, self.origin + level._id_2A95._id_2A3A[0], self.angles, var_1._id_011A);

    if(isDefined(var_1._id_1B53)) {
      var_2._id_1B53 = var_1._id_1B53;
    } else if(isDefined(var_1._id_780A)) {
      var_2._id_780A = var_1._id_780A;
    } else if(isDefined(var_1._id_61D5)) {
      var_2._id_61D5 = var_1._id_61D5;
    }

    scripts\mp\gametypes\br_analytics::_id_2AFC(self, var_1._id_CF22);
    scripts\mp\gametypes\br_public::_id_C4D7(var_0);
  }
}

_id_FE86(var_0) {
  if(isDefined(self._id_2A62[var_0])) {
    _id_F78D(self._id_2A62[var_0], var_0);
  } else {}
}

_id_B80C(var_0) {
  self endon("disconnect");
  self notify("try_use_heal_slot");

  if(!isalive(self) || scripts\mp\utility\player::_id_8ACE() || istrue(self._id_87F8) || self._id_2A0E >= self._id_2A7D) {
    return;
  }
  var_1 = self.equipment["health"];
  var_2 = scripts\mp\equipment::_id_6A15("health");
  var_3 = self._id_2A7D;
  var_4 = 1;

  if(isDefined(var_3) && var_0) {
    var_4 = var_3;
  }

  if(istrue(self._id_82E8)) {
    if(isDefined(self._id_1B63) && _id_31B8()) {
      self._id_1B63 = self._id_1B63 + var_4;
    }
  } else {
    self._id_1B63 = var_4;

    if(isDefined(var_1) && isDefined(var_2) && var_2 > 0) {
      thread _id_0A03::_id_FEAD(var_1, var_2);
    }
  }
}

_id_31B8() {
  return !scripts\engine\utility::is_player_gamepad_enabled();
}

_id_EDC1(var_0) {
  var_1 = scripts\mp\equipment::_id_6A15("primary");

  if(isDefined(var_1) && var_1 < 2) {
    scripts\mp\equipment::_id_7DEE("primary");
  }

  var_1 = scripts\mp\equipment::_id_6A15("secondary");

  if(isDefined(var_1) && var_1 < 2) {
    scripts\mp\equipment::_id_7DEE("secondary");
  }
}

_id_F753(var_0) {
  if(_id_31D9(var_0._id_CF22, var_0._id_011A)) {
    _id_B0B0(var_0);
  } else {
    self iprintlnbold("No room in inventory");
    self playlocalsound("br_pickup_deny");
  }
}

_id_F752(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(level._id_2A95._id_9C60[var_0]) || !isDefined(level._id_2A95._id_E503[var_0])) {
    return;
  }
  var_2 = spawnStruct();
  var_2._id_CF22 = var_0;
  var_2._id_011A = var_1;
  var_2._id_9C5F = level._id_2A95._id_9C60[var_0];
  var_2._id_E503 = level._id_2A95._id_E503[var_0];
  var_2._id_8B3D = level._id_2A95._id_2A67[var_0];

  if(_id_31D9(var_2._id_CF22, var_2._id_011A)) {
    _id_B0B0(var_2);
  } else {
    self iprintlnbold("No room in inventory");
    self playlocalsound("br_pickup_deny");
  }
}

_id_F742(var_0, var_1) {
  var_2 = level._id_2A95._id_2A42[var_0._id_CF22];
  var_3 = level.equipment._id_EC5C[var_2]._id_45C7;

  if(isDefined(self.equipment[var_3]) && self.equipment[var_3] == var_2) {
    if(_id_558A(var_0._id_CF22, var_3)) {
      scripts\mp\equipment::_id_7DEE(var_3, level._id_2A95._id_3DAB[var_0._id_CF22]);
      self._id_2A62[var_1] = undefined;
    }
  } else if(!isDefined(self.equipment[var_3]) || scripts\mp\equipment::_id_6A15(var_3) == 0) {
    scripts\mp\equipment::giveequipment(var_2, var_3);
    scripts\mp\equipment::_id_D545(var_3, var_0._id_011A);
    self._id_2A62[var_1] = undefined;
  } else {
    var_4 = self.equipment[var_3];
    var_5 = scripts\mp\equipment::_id_6A15(var_3);
    scripts\mp\equipment::giveequipment(var_2, var_3);
    scripts\mp\equipment::_id_D545(var_3, var_0._id_011A);
    self._id_2A62[var_1] = undefined;
    var_6 = level._id_2A95._id_2A43[var_4];
    _id_F752(var_6, var_5);
  }
}

_id_500D(var_0, var_1) {
  var_2 = _id_E336(var_0, self.origin + level._id_2A95._id_2A3A[0], self.angles);
  var_2._id_011A = 1;
  var_2._id_780A = 0;
  var_2._id_1B53 = 0;
  var_2._id_61D5 = 0;

  if(issubstr(var_0, "helmet")) {
    var_2._id_780A = var_1;

    if(var_0 == "brloot_armor_helmet_3") {
      scripts\mp\utility\perk::removeperk("specialty_stun_resistance");
    }
  }

  scripts\mp\gametypes\br_analytics::_id_2AFC(self, var_0);
}

_id_F740(var_0) {
  if(scripts\mp\gametypes\br_public::_id_889B(var_0)) {
    if(isDefined(self._id_2A5A)) {
      var_1 = scripts\mp\gametypes\br_armor::_id_780B(self._id_2A5A);

      if(isDefined(var_1)) {
        _id_500D(var_1, self._id_2A59);
      }
    }
  }
}

_id_F741(var_0, var_1) {
  if(isDefined(var_1)) {
    self._id_2A62[var_1] = undefined;
  }

  _id_F740(var_0._id_CF22);

  if(var_0._id_CF22 == "brloot_armor_helmet_1") {
    scripts\mp\gametypes\br_armor::_id_EDC5(var_0, 1);
  } else if(var_0._id_CF22 == "brloot_armor_helmet_2") {
    scripts\mp\gametypes\br_armor::_id_EDC5(var_0, 2);
  } else if(var_0._id_CF22 == "brloot_armor_helmet_3") {
    scripts\mp\gametypes\br_armor::_id_EDC5(var_0, 3);
  }
}

_id_F78D(var_0, var_1) {
  if(scripts\mp\gametypes\br_public::_id_8835(var_0._id_CF22)) {
    _id_F742(var_0, var_1);
  }
}

_id_825A() {
  scripts\common\interactive::_id_8397(::_id_2C2D, "br_pickups");
}

_id_2C2D(var_0, var_1) {
  var_2 = var_1 _id_31F1(var_0);
  var_1 _id_DCFB(var_2);

  if(var_2 != 1) {
    return;
  }
  var_1 _id_ABCF(var_0);
  _id_4806(var_0);

  if(var_0 _meth_86EE()) {
    var_0 _meth_86BE();
  } else {
    var_0 delete();
  }
}

_id_7446(var_0, var_1) {
  if(isDefined(self.equipment[var_1]) && scripts\mp\equipment::_id_6A15(var_1) > 0) {
    _id_502D(var_1);
  }

  scripts\mp\equipment::giveequipment(var_0, var_1);
  scripts\mp\equipment::_id_D543(var_0, 1);
}

_id_EB46(var_0) {
  if(scripts\mp\utility\game::getgametype() == "br" && !level._id_15D8) {
    var_0 scripts\mp\equipment::_id_EDBD("super");
  }
}

_id_6CB1(var_0) {
  var_1 = "brloot_armor_plate";
  var_2 = level._id_2A95._id_2A42[var_1];
  var_3 = level.equipment._id_EC5C[var_2]._id_45C7;

  if(isDefined(self.equipment[var_3])) {
    var_4 = scripts\mp\equipment::_id_6A15(var_3);

    if(var_4 > 0) {
      if(istrue(var_0)) {
        return var_4;
      } else {
        return 1;
      }
    }
  }

  return 0;
}

_id_6CAF(var_0, var_1) {
  var_2 = self._id_29F9[var_0];
  var_3 = level._id_29FA[var_0];

  if(!isDefined(var_2) || !isDefined(var_3)) {
    return 0;
  }

  if(istrue(var_1)) {
    return int(var_2);
  }

  return int(min(var_3, var_2));
}

_id_6CB3(var_0) {
  var_1 = 5;

  if(istrue(var_0)) {
    return int(self._id_B956);
  }

  return int(min(self._id_B956, var_1));
}

_id_6CB0(var_0) {
  switch (var_0) {
    case 3:
      return "brloot_ammo_762";
    case 5:
      return "brloot_ammo_919";
    case 7:
      return "brloot_ammo_50cal";
    case 4:
      return "brloot_ammo_12g";
    case 6:
      return "brloot_ammo_rocket";
    default:
  }
}

_id_6CB2(var_0, var_1) {
  switch (var_0) {
    case 2:
      return _id_6CB1(var_1);
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
      var_2 = _id_6CB0(var_0);
      return _id_6CAF(var_2, var_1);
    case 0:
      return _id_6CB3(var_1);
    case 1:
      return 1;
    case 8:
      return 1;
    default:
      return 0;
  }
}

_id_BEEF(var_0, var_1) {
  var_2 = "brloot_armor_plate";
  var_3 = level._id_2A95._id_2A42[var_2];
  var_4 = level.equipment._id_EC5C[var_3]._id_45C7;
  scripts\mp\equipment::_id_4559(var_4, var_1);
}

_id_BEEE(var_0, var_1) {
  var_2 = _id_6CB0(var_0);
  scripts\mp\gametypes\br_weapons::_id_2A06(self, var_2, var_1);
}

_id_BEF1(var_0, var_1) {
  scripts\mp\gametypes\br_plunder::_id_B74C(var_1);
}

_id_BEF2(var_0, var_1) {
  _id_C514();
}

_id_BEF3(var_0, var_1) {
  _id_C519();
}

_id_BEF0(var_0, var_1) {
  switch (var_0) {
    case 2:
      _id_BEEF(var_0, var_1);
      break;
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
      _id_BEEE(var_0, var_1);
      break;
    case 0:
      _id_BEF1(var_0, var_1);
      break;
    case 1:
      _id_BEF2(var_0, var_1);
      break;
    case 8:
      _id_BEF3(var_0, var_1);
      break;
    default:
      return 0;
  }
}

_id_BEEA(var_0, var_1) {
  switch (var_0) {
    case 2:
      return "brloot_armor_plate";
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
      return _id_6CB0(var_0);
    case 0:
      for(var_2 = level._id_2A9B._id_BE99.size - 1; var_2 >= 0; var_2--) {
        if(var_1 > level._id_2A9B._id_BE99[var_2]) {
          return level._id_2A9B._id_A3D1[var_2];
        }
      }

      return level._id_2A9B._id_A3D1[0];
    case 8:
      return "brloot_self_revive";
    case 1:
      return "brloot_respawn_token";
    default:
  }
}

_id_BEE8() {
  var_0 = 120;
  self notify("quickDropCleanupCache");
  self endon("quickDropCleanupCache");
  wait(var_0);
  self._id_BEE5 = undefined;
}

_id_BEE2(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self._id_BEE5)) {
    self._id_BEE5 = [];
  }

  var_6 = spawnStruct();
  var_6._id_8B3B = var_0;
  var_6._id_DDEF = var_2;
  var_6._id_5469 = var_3;
  var_6._id_5042 = var_4;
  var_6._id_500A = var_5;
  var_6._id_B72D = self.origin;
  var_6._id_B825 = self.angles[1];
  self._id_BEE5[self._id_BEE5.size] = var_6;
  thread _id_BEE8();
}

_id_BEE7(var_0) {
  var_1 = 60.0;
  var_2 = _func_0219(var_1);
  var_3 = 45.0;
  var_4 = distancesquared(self.origin, var_0._id_B72D);

  if(var_4 > var_2) {
    return 0;
  }

  var_5 = abs(self.angles[1] - var_0._id_B825);

  if(var_5 > var_3) {
    return 0;
  }

  return 1;
}

_id_BEE9(var_0) {
  if(!isDefined(self._id_BEE5)) {
    return;
  }
  foreach(var_2 in self._id_BEE5) {
    if(isDefined(var_2._id_5469) && var_2._id_8B3B == var_0) {
      if(!_id_BEE7(var_2)) {
        continue;
      }
      return var_2;
    }
  }
}

_id_BEE6() {
  if(!isDefined(self._id_BEE5)) {
    return 0;
  }

  var_0 = [];

  foreach(var_2 in self._id_BEE5) {
    if(isDefined(var_2._id_5469)) {
      if(!_id_BEE7(var_2)) {
        continue;
      }
      var_0[var_2._id_DDEF] = 1;
    }
  }

  var_4 = undefined;
  var_5 = 0;
  var_6 = 0;
  var_7 = [0, 12, 1];

  for(;;) {
    var_4 = var_6 * 13 + var_7[var_5];

    if(!istrue(var_0[var_4])) {
      break;
    }

    var_5++;

    if(var_5 >= var_7.size) {
      var_5 = 0;
      var_6++;
    }
  }

  return var_4;
}

_id_BEED(var_0, var_1, var_2) {
  var_3 = undefined;

  switch (var_0) {
    case 2:
      var_3 = "br_inventory_drop_armor";
      break;
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
      var_3 = "br_inventory_drop_ammo";
      break;
    case 0:
      if(var_2 == "brloot_plunder_cash_uncommon_1") {
        var_3 = "br_inventory_drop_plunder_sm";
      } else if(var_2 == "brloot_plunder_cash_uncommon_2") {
        var_3 = "br_inventory_drop_plunder_sm";
      } else if(var_2 == "brloot_plunder_cash_uncommon_3") {
        var_3 = "br_inventory_drop_plunder_sm";
      } else if(var_2 == "brloot_plunder_cash_rare_1") {
        var_3 = "br_inventory_drop_plunder_med";
      } else if(var_2 == "brloot_plunder_cash_rare_2") {
        var_3 = "br_inventory_drop_plunder_med";
      } else if(var_2 == "brloot_plunder_cash_epic_1") {
        var_3 = "br_inventory_drop_plunder_lrg";
      } else if(var_2 == "brloot_plunder_cash_epic_2") {
        var_3 = "br_inventory_drop_plunder_lrg";
      } else if(var_2 == "brloot_plunder_cash_legendary_1") {
        var_3 = "br_inventory_drop_plunder_extra_lrg";
      } else {
        var_3 = "br_inventory_drop_plunder";
      }

      break;
    case 1:
      break;
    case 8:
      var_3 = "br_inventory_drop_self_revive";
      break;
    default:
  }

  if(isDefined(var_3)) {
    playsoundatpos(var_1, var_3);
  }
}

_id_BEE3(var_0, var_1) {
  var_2 = _id_BEE9(var_0);

  if(isDefined(var_2)) {
    var_3 = var_2._id_5469;
    var_4 = var_2._id_5042;
    var_5 = var_2._id_500A;
    var_6 = var_3._id_011A;

    if(!_id_8980(var_2._id_5469.type) && !issubstr(var_2._id_5469.type, "_cash")) {
      return 0;
    }

    var_7 = var_6 + var_1;
    var_8 = _id_BEEA(var_0, var_7);
    var_9 = _func_03EB(var_4 + (0, 0, 12), var_4);
    var_10 = _id_E336(var_8, var_4, var_5, var_7, 1, var_9, undefined, 0);
    scripts\mp\gametypes\br_analytics::_id_2AFC(self, var_8, undefined, var_1);
    _id_BEED(var_0, var_4, var_8);
    var_2._id_5469 = var_10;
    thread _id_BEE8();
    _id_4806(var_3);

    if(isent(var_3)) {
      var_3 delete();
    } else {
      var_3 _meth_86BE();
    }

    return 1;
  }

  return 0;
}

_id_BEEC(var_0, var_1) {
  var_2 = _id_BEEA(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = _id_BEE6();
  [var_5, var_6, var_7] = _id_6ACD(var_3, self.origin, self.angles, self);
  var_8 = _id_E336(var_2, var_5, var_6, var_1, 1, var_7, undefined, 0);
  _id_BEE2(var_0, var_1, var_3, var_8, var_5, var_6);
  scripts\mp\gametypes\br_analytics::_id_2AFC(self, var_2, undefined, var_1);
  _id_BEED(var_0, var_5, var_2);
}

_id_BEEB(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  _id_74B3(var_0);
  var_1 = _id_6CB2(var_0);

  if(var_1 == 0) {
    return;
  }
  _id_BEF0(var_0, var_1);
  var_2 = _id_BEE3(var_0, var_1);

  if(var_2) {
    return;
  }
  _id_BEEC(var_0, var_1);
}

_id_BEE4(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  _id_74B3(var_0);
  var_1 = 1;
  var_2 = _id_6CB2(var_0, var_1);

  if(var_2 == 0) {
    return;
  }
  _id_BEF0(var_0, var_2);
  var_3 = _id_BEE3(var_0, var_2);

  if(!var_3) {
    _id_BEEC(var_0, var_2);
  }
}

_id_3501(var_0) {
  switch (var_0) {
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
      return 1;
    default:
      return 0;
  }
}

_id_74B3(var_0) {
  if(_id_3501(var_0)) {
    var_1 = undefined;

    while(self _meth_81E0()) {
      if(!istrue(var_1)) {
        var_1 = 1;
        self disableautoreload();
      }

      self cancelreload();
      waitframe();
    }

    if(istrue(var_1)) {
      self enableautoreload();
    }

    waitframe();
  }
}

_id_433F(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = level._id_2A1B._id_372F;

  if(var_3 > level._id_2A1B._id_4330.size - 1) {
    var_3 = level._id_2A1B._id_4330.size - 1;
  }

  var_4 = level._id_2A1B._id_4330[var_3];

  if(isDefined(level._id_3728)) {
    var_4 = var_4 * level._id_3728;
  }

  level._id_2A95._id_5047 = scripts\engine\utility::_id_1BD1(level._id_2A95._id_5047);

  for(var_5 = level._id_2A95._id_5047.size - 1; var_5 >= 0; var_5--) {
    var_6 = level._id_2A95._id_5047[var_5];

    if(distancesquared(var_6.origin, var_0) > var_2) {
      var_7 = var_6._id_011A;
      var_8 = int(var_7 - var_4);

      if(var_8 <= 0) {
        var_6 setscriptablepartstate("brloot_equip_gasmask", "death");
        var_6 _id_478C(1.0);
        level thread _id_4802(var_5);
      } else if(_id_0792::_id_4970(var_7, var_8)) {
        var_9 = _func_03EB(var_6.origin + (0, 0, 12), var_6.origin);
        var_10 = _id_E336("brloot_equip_gasmask", var_6.origin, var_6.angles, var_8, 1, var_9, undefined, 0);
        var_6 _id_478B();
      } else {
        var_6 setscriptablepartstate("brloot_equip_gasmask", "damage");
        var_6._id_011A = var_8;
      }
    }
  }
}

_id_4802(var_0) {
  waittillframeend;

  if(isDefined(level._id_2A95._id_5047)) {
    level._id_2A95._id_5047[var_0] = undefined;
  }
}

_id_8284() {
  var_0 = level._id_2A95;
  var_0._id_CF26 = [];
  var_0._id_CF2B = 0;
  var_0._id_CF29 = 0;
  var_0._id_CF2A = getdvarint("#x3dd680e119686c690", 750);
  var_0._id_CF28 = getdvarint("#x329d380be31a59963", 10);
}

_id_C2AE(var_0) {
  var_1 = level._id_2A95._id_CF29;
  var_0._id_2C2C = var_1;
  level._id_2A95._id_CF26[var_1] = var_0;
  level._id_2A95._id_CF29++;
}

_id_4806(var_0) {
  level._id_2A95._id_CF26[var_0._id_2C2C] = undefined;
  var_0._id_2C2C = undefined;
}

_id_3980() {
  var_0 = level._id_2A95;

  if(var_0._id_CF26.size < var_0._id_CF2A) {
    return;
  }
  var_1 = 0;

  for(var_2 = var_0._id_CF2B; var_2 < var_0._id_CF29; var_2++) {
    if(var_1 == var_0._id_CF28) {
      break;
    }

    var_3 = var_0._id_CF26[var_2];

    if(isDefined(var_3)) {
      var_0._id_CF26[var_2] = undefined;

      if(isent(var_3)) {
        var_3 delete();
      } else {
        var_3 _meth_86BE();
      }

      var_1++;
    } else
      var_0._id_CF26[var_2] = undefined;

    var_0._id_CF2B++;
  }
}

_id_478B() {
  _id_4806(self);

  if(isent(self)) {
    self delete();
  } else {
    self _meth_86BE();
  }
}

_id_478C(var_0) {
  thread _id_478D(var_0);
}

_id_478D(var_0) {
  wait(var_0);
  _id_478B();
}