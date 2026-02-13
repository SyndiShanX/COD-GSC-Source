/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1852.gsc
*************************************************/

init() {
  level._id_1F8C = [];
  level._id_B3DE = [];
  level._id_A201 = ::_id_FCCC;
  level._id_C29A = ::_id_C299;
  _id_7F36();

  if(!isDefined(level.loadoutsgroup)) {
    level.loadoutsgroup = scripts\cp\utility::getplayerdataloadoutgroup();
  }

  if(!isDefined(level._id_3803)) {
    level._id_3803 = [];
  }

  level._id_3803["class0"] = 0;
  level._id_3803["class1"] = 1;
  level._id_3803["class2"] = 2;
  level._id_3803["custom1"] = 0;
  level._id_3803["custom2"] = 1;
  level._id_3803["custom3"] = 2;
  level._id_3803["custom4"] = 3;
  level._id_3803["custom5"] = 4;
  level._id_3803["custom6"] = 5;
  level._id_3803["custom7"] = 6;
  level._id_3803["custom8"] = 7;
  level._id_3803["custom9"] = 8;
  level._id_3803["custom10"] = 9;
  level._id_3803["axis_recipe1"] = 0;
  level._id_3803["axis_recipe2"] = 1;
  level._id_3803["axis_recipe3"] = 2;
  level._id_3803["axis_recipe4"] = 3;
  level._id_3803["axis_recipe5"] = 4;
  level._id_3803["axis_recipe6"] = 5;
  level._id_3803["allies_recipe1"] = 0;
  level._id_3803["allies_recipe2"] = 1;
  level._id_3803["allies_recipe3"] = 2;
  level._id_3803["allies_recipe4"] = 3;
  level._id_3803["allies_recipe5"] = 4;
  level._id_3803["allies_recipe6"] = 5;
  level._id_3803["gamemode"] = 0;
  level._id_3803["callback"] = 0;
  level._id_3803["default1"] = 0;
  level._id_3803["default2"] = 1;
  level._id_3803["default3"] = 2;
  level._id_3803["default4"] = 3;
  level._id_3803["default5"] = 4;
  level._id_3803["default6"] = 5;
  level._id_3803["default7"] = 6;
  level._id_3803["default8"] = 7;
  level._id_3803["default9"] = 8;
  level._id_3803["default10"] = 9;
  level._id_3803["default11"] = 10;
  level._id_3803["juggernaut"] = 0;
  level._id_45A8 = "CLASS_ASSAULT";

  if(getdvarint("#x38475eca840c2144b", 0)) {
    level._id_3809 = "mp/classtable_test.csv";
  } else if(scripts\cp\utility::_id_872D()) {
    level._id_3809 = "cp/classtable.csv";
  } else {
    level._id_3809 = "mp/classtable.csv";
  }
}

get_weapon_from_selected_loadout(var_0, var_1, var_2, var_3) {
  var_4 = 10;
  var_5 = 0;

  if(isDefined(var_1)) {
    if(var_2) {
      var_6 = var_0 _id_2E8D(var_1, var_5);

      if(isDefined(var_6)) {
        var_7 = [];
        var_8 = [];

        for(var_9 = 0; var_9 < var_4; var_9++) {
          var_10 = var_0 _id_2E8E(var_1, 0, var_9);
          var_11 = var_0 _id_2E8F(var_1, 0, var_9);

          if(_func_0107(level.filtered_attachment_types)) {
            var_12 = scripts\cp\utility::_id_1DA9(var_10, var_6);
            var_13 = scripts\cp\utility::_id_68E5(var_12);

            if(scripts\engine\utility::array_contains(level.filtered_attachment_types, var_13)) {
              var_10 = "none";
              var_11 = 0;
            }
          }

          var_7[var_9] = var_10;
          var_8[var_9] = var_11;
        }

        var_14 = var_0 _id_2E90(var_1, 0);
        var_15 = var_0 _id_2E93(var_1, 0);
        var_16 = var_0 _id_2E91(var_1, 0);
        var_17 = var_0 _id_2E95(var_1, 0);
        var_18 = [];

        for(var_19 = 0; var_19 < 4; var_19++) {
          var_18[var_19] = var_0 _id_2E94(var_1, 0, var_19);
        }

        return scripts\cp\cp_weapon::buildweapon(var_6, var_7, var_14, var_15, var_17, var_8, var_16, var_18);
      }
    } else {
      var_20 = _id_EC6D(level._id_3809, var_1, 0);

      if(isDefined(var_20)) {
        var_21 = [];

        for(var_9 = 0; var_9 < var_4; var_9++) {
          var_21[var_9] = _id_EC6E(level._id_3809, var_1, 0, var_9);
        }

        var_14 = _id_EC6F(level._id_3809, var_1, 0);
        var_15 = _id_EC70(level._id_3809, var_1, 0);
        return scripts\cp\cp_weapon::buildweapon(var_20, var_21, var_14, var_15);
      }
    }
  }

  return var_3;
}

give_player_accessory(var_0, var_1) {
  var_2 = var_0 _id_2E7B();
  var_3 = var_0 _id_2E7D();
  var_4 = var_0 _id_2E7C();

  if(isDefined(var_3) && var_3 != "none") {
    var_0 _id_06F9::_id_6FC8(var_2, var_3, var_4, var_1);
  }
}

_id_6F90(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_4._id_33EF = undefined;
  var_4 takeallweapons();
  var_4 thread _id_46D8(var_4);
  var_4 scripts\cp\utility::_id_0BBC();
  var_4._id_E334 = 0;

  if(isDefined(var_4._id_7611)) {
    var_4._id_7611 = undefined;
  }

  var_5 = _id_6C48();
  var_4 thread _id_D5FC(var_5);
  var_4 thread give_player_accessory(var_4, var_5[0]);
  var_6 = _id_6C56();
  var_7 = var_4 _id_6C4C(var_6);

  if(isDefined(var_7) && var_7 != "") {
    var_4 _meth_8300(var_7);
  } else {
    var_4 thread _id_84F9(var_6);
  }

  var_4._id_105F0 = "p2_";
  scripts\cp\utility\player::_id_D1C1();
  scripts\engine\utility::_id_5C24("introscreen_over");

  if(isDefined(level._id_A201)) {
    self[[level._id_A201]]();
  } else {
    _id_FCCC();
  }

  var_4._id_034C = _func_0375();

  if(isDefined(level._id_D8E7)) {
    var_4 thread[[level._id_D8E7]]();
  }

  var_4 notify("giveLoadout");
  var_4 scripts\cp\utility::_id_6FC2("specialty_pistoldeath");
  var_4 thread scripts\cp_mp\utility\player_utility::monitorammoregen();

  if(getdvarint("#x3dee089cb49164e4e", 0) != 1) {
    _id_0707::_id_1B55(var_4);
  }

  if(isDefined(var_0) && var_0) {
    return;
  }
  var_8 = isbot(var_4) || _func_03DA(var_4);

  if(!var_8 && !isDefined(var_2)) {
    if(!isDefined(var_4._id_45A9)) {
      var_2 = var_4 cac_getfavoriteloadoutindex();
      var_3 = 1;
      var_4._id_45A9 = var_2;
      var_4.usecustomclass = var_3;
    } else {
      var_2 = var_4._id_45A9;
      var_3 = var_4.usecustomclass;
    }
  }

  if(!_func_0376(var_4._id_E6C8)) {
    var_4._id_458F = var_4._id_E6C8;
  } else if(isDefined(level._id_459D)) {
    var_4._id_458F = scripts\cp\cp_weapon::buildweapon(level._id_459D);
  } else {
    var_4._id_458F = scripts\cp\cp_weapon::buildweapon("iw8_sm_augolf_mp");
  }

  var_9 = get_weapon_from_selected_loadout(var_4, var_2, var_3, var_4._id_458F);

  if(!_func_0376(var_9)) {
    var_4._id_458F = var_9;
  }

  var_10 = scripts\cp\utility::_id_6CE3(var_4._id_458F);
  var_4._id_458F = _id_C78D(var_4, var_10, var_4._id_458F);
  scripts\cp\utility::_id_FC9F(var_4._id_458F);
  var_11 = _func_02F7(var_4._id_458F);
  var_12 = scripts\cp\utility::_id_6CE3(var_4._id_458F);
  var_4 scripts\cp\utility::_giveweapon(var_4._id_458F, var_11, undefined, 1);

  if(!isDefined(var_4.pers["telemetry"].first_weapon_in_round_base_name)) {
    var_4.pers["telemetry"].first_weapon_in_round_base_name = var_12;
    var_4.pers["telemetry"].first_weapon_in_round_start_time = _func_00D7();
  }

  var_4[[level._id_A201]]();
  _id_0774::_id_8115(var_4);
  var_4 update_super(var_2, var_3);

  if(_func_011F()) {
    var_4 thread _id_106C7(var_4._id_458F);
  } else {
    var_4 setspawnweapon(var_4._id_458F, 1);
  }

  var_4 _id_D345();
  var_4 notify("loadout_given");

  if(!isDefined(var_4.pers["telemetry"].selectedlodout)) {
    var_4.pers["telemetry"].selectedlodout = 1;
    var_4 thread selectedloadout();
  }

  var_4.pers["telemetry"].loadoutselectedweapon = var_12;
  var_13 = "";
  var_14 = getweaponattachments(var_4._id_458F);

  if(isDefined(var_14) && var_14.size > 0) {
    foreach(var_16 in var_14) {
      var_13 = var_13 + (var_16 + ",");
    }
  }

  var_4.pers["telemetry"].loadoutselectedattachments = var_13;
}

selectedloadout() {
  wait 20;
  scripts\cp\telemetry_cp::logevent_loadout_info(self);
}

update_super(var_0, var_1) {
  var_2 = cac_getartifact(var_0, var_1);
  _id_0766::givesuper(var_2, 0, 0);
  self.pers["telemetry"].loadoutselectedfieldupgrade = var_2;
}

update_instant_loadout_swap() {
  self endon("death_or_disconnect");
  self.instantloadoutswapallowed = 1;
  var_0 = 15;

  if(istrue(self.on_first_spawn)) {
    self.on_first_spawn = undefined;
    var_0 = 30;
  }

  wait(var_0);
  self.instantloadoutswapallowed = 0;

  if(!istrue(self.has_selected_loadout)) {
    self.has_selected_loadout = 1;
    _id_072E::close_all_menus();
    thread play_match_start_narration();
  }
}

_id_84F9(var_0) {
  var_1 = "Invalid body index: " + var_0 + " check mp/cac/bodies.csv";

  if(isDefined(self) && isPlayer(self)) {
    if(getdvarint("#x3decf448ab3afab5f", 0) == 1) {
      self iprintlnbold(var_1);
    } else {}
  }
}

_id_6C43() {
  return [];
}

_id_C78D(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");

  if(!istrue(var_0._id_10DA7)) {
    var_0 waittill("player_weapon_build_kit_initialized");
  }

  if(isDefined(var_1) && isDefined(var_0._id_10CEA[var_1])) {
    return makeweaponfromstring(var_0._id_10CEA[var_1]);
  } else {
    return var_2;
  }
}

_id_46D8(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  wait 1;

  if(istrue(var_0._id_8CBA)) {
    if(isDefined(var_0._id_11086)) {
      var_1 = getarraykeys(var_0._id_11086);

      foreach(var_3 in var_1) {
        if(isDefined(level._id_3D1E) && isDefined(level._id_3D1E[var_3]) && isDefined(level._id_3D1E[var_3]._id_D12B)) {
          var_0[[level._id_3D1E[var_3]._id_D12B]]();
        }
      }
    }

    var_0._id_8CBA = undefined;
  }
}

_id_C2F4(var_0) {
  var_1 = var_0._id_B3DF;

  if(isDefined(var_1) && !scripts\engine\utility::array_contains(level._id_1F8C, var_1) && var_1 != 5) {
    level._id_1F8C = scripts\engine\utility::array_add(level._id_1F8C, var_1);
  }
}

_id_6C48() {
  var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", 0);
  self.operatorid = int(_func_0222("loot/operator_ids.csv", 1, var_0, 0));
  self.operatorfaveweap = _func_0222("operators.csv", 1, var_0, 28);
  var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_0, "skin");
  var_2 = _func_0222("loot/operator_skin_ids.csv", 0, var_1, 1);
  var_3 = undefined;
  var_4 = undefined;

  if(getdvarint("#x3d26e55a89fd9c8fd")) {
    var_3 = _func_0222("loot/operator_skin_ids.csv", 1, var_2, 13);
    var_4 = _func_0222("loot/operator_skin_ids.csv", 1, var_2, 12);
  } else {
    var_3 = _func_0222("operatorskins.csv", 1, var_2, 4);
    var_4 = _func_0222("operatorskins.csv", 1, var_2, 5);
  }

  if(var_3 == "" || var_4 == "") {
    var_3 = "c_s4_mp_ger_roland_01_larger";
    var_4 = "head_mp_j_kostrey_01";
  }

  var_5 = [var_3, var_4];
  return var_5;
}

_id_D5FC(var_0) {
  level endon("game_ended");
  wait 0.05;
  self _meth_8526(var_0[0], var_0[1]);
  _id_D4BE(self _meth_8128(), self _meth_8129(), self _meth_812C());
}

_id_6666() {
  if(isDefined(self._id_B3DF)) {
    return self._id_B3DF;
  }

  var_1 = scripts\engine\utility::random(level._id_1F8C);
  self._id_B3DF = var_1;
  return var_1;
}

_id_6398(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case 3:
      var_1._id_252E = 11;
      var_1._id_252D = 10;
      var_1._id_252C = 9;
      break;
    case 2:
      var_1._id_252E = 8;
      var_1._id_252D = 7;
      var_1._id_252C = 6;
      break;
    case 1:
      var_1._id_252E = 5;
      var_1._id_252D = 4;
      var_1._id_252C = 3;
      break;
    case 0:
      var_1._id_252E = 2;
      var_1._id_252D = 1;
      var_1._id_252C = 0;
      break;
  }

  return var_1;
}

_id_63C0(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case 0:
      var_1._id_252E = 0;
      var_1._id_252D = 0;
      var_1._id_252C = 0;
      break;
    case 1:
      var_1._id_252E = 0;
      var_1._id_252D = 0;
      var_1._id_252C = 1;
      break;
    case 2:
      var_1._id_252E = 0;
      var_1._id_252D = 1;
      var_1._id_252C = 0;
      break;
    case 3:
      var_1._id_252E = 0;
      var_1._id_252D = 1;
      var_1._id_252C = 1;
      break;
    case 4:
      var_1._id_252E = 1;
      var_1._id_252D = 0;
      var_1._id_252C = 0;
      break;
  }

  return var_1;
}

_id_678D(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case "healthy":
      var_1._id_252E = 0;
      var_1._id_252D = 0;
      var_1._id_252C = 0;
      break;
    case "damaged":
      var_1._id_252E = 0;
      var_1._id_252D = 0;
      var_1._id_252C = 1;
      break;
    case "laststand":
      var_1._id_252E = 0;
      var_1._id_252D = 1;
      var_1._id_252C = 0;
      break;
    case "afterlife":
      var_1._id_252E = 0;
      var_1._id_252D = 1;
      var_1._id_252C = 1;
      break;
  }

  return var_1;
}

_id_D4BE(var_0, var_1, var_2) {
  if(isDefined(self._id_7611)) {
    self detach(self._id_7611);
  }

  _id_0766::detachsupermodel();
  self._id_25E4 = var_0;
  self setModel(var_0);
  self _meth_83AB(var_2);

  if(isDefined(var_1)) {
    self attach(var_1, "", 1);
    self._id_7611 = var_1;
  }

  thread _id_0766::attachsupermodel();
}

_id_6C56() {
  return 0;
}

_id_6C4C(var_0) {
  return _func_0222("mp/cac/bodies.csv", 0, var_0, 5);
}

_id_FCCC() {
  var_0 = undefined;

  if(isDefined(self._id_B7E4)) {
    var_0 = 1.0;
    var_0 = var_0 + self._id_B7E4;
  } else {
    var_0 = _id_6C62(self);

    if(isDefined(self._id_3410)) {
      var_0 = self._id_3410;
    } else if(isDefined(self._id_DD2A)) {
      var_0 = self._id_DD2A;
    }

    var_0 = var_0 + scripts\cp\utility::_id_459B(_id_0945::_id_664E("move_speed_increase"), 0);
    var_1 = self._id_3582;

    if(isDefined(var_1) && isDefined(var_1._id_E3F9)) {
      var_0 = var_0 + var_1._id_E3F9;
    }

    if(isDefined(self._id_E3FD)) {
      var_0 = var_0 + self._id_E3FD;
    }

    if(isDefined(self._id_B035)) {
      var_0 = var_0 + self._id_B035;
    }

    if(isDefined(self._id_10D5C)) {
      var_0 = var_0 + self._id_10D5C;
    }

    if(isDefined(self._id_10DBB)) {
      var_0 = var_0 + self._id_10DBB;
    }

    if(isDefined(self._id_10DBC)) {
      var_0 = var_0 + self._id_10DBC;
    }

    if(isDefined(self._id_4EB2)) {
      var_0 = var_0 + self._id_4EB2;
    }

    var_0 = min(2, var_0);
  }

  self._id_10DD9 = var_0;

  if(!isDefined(self._id_3AC4)) {
    self._id_3AC4 = 1;
  }

  _id_06E5::_id_D12B("loadout_default", "move_speed_scale", var_0 * self._id_A25F * self._id_3AC4);
}

_id_6C62(var_0) {
  var_1 = 1.0;
  self.weaponlist = self getweaponslistprimaries();

  if(getDvar("#x38868d980059ae421", "on") == "on") {
    return 1.0;
  }

  if(!self.weaponlist.size) {
    var_1 = 0.9;
  } else {
    var_2 = self getcurrentweapon();

    if(scripts\cp\utility::_id_8A7D(var_2)) {
      var_1 = _id_0766::_id_6B69(var_2);
    } else {
      var_3 = _func_0276(var_2);

      if(var_3 != "primary" && var_3 != "altmode") {
        if(isDefined(self._id_CB44)) {
          var_2 = self._id_CB44;
        } else {
          var_2 = undefined;
        }
      }

      if(!isDefined(var_2) || !self hasweapon(var_2)) {
        var_1 = _id_6E8D();
      } else {
        var_1 = _id_6E8C(var_2);
      }
    }
  }

  var_1 = _id_37FB(var_1);
  return var_1;
}

_id_6E8C(var_0) {
  var_1 = scripts\cp\utility::_id_6902(var_0);
  var_2 = level._id_10DB0[var_1].speed;
  return var_2;
}

_id_6E8D() {
  var_0 = 2.0;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      if(scripts\cp\utility::_id_8A7D(var_2)) {
        var_3 = _id_0766::_id_6B69(var_2);
      } else {
        var_3 = _id_6E8C(var_2);
      }

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0) {
        var_0 = var_3;
      }
    }
  } else
    var_0 = 0.9;

  var_0 = _id_37FB(var_0);
  return var_0;
}

_id_37FB(var_0) {
  return clamp(var_0, 0.0, 1.0);
}

_id_6E78() {
  var_0 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = _id_6E94(var_2);

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0) {
        var_0 = var_3;
      }
    }
  } else
    var_0 = 8;

  var_0 = _id_37FC(var_0);
  return var_0;
}

_id_6E94(var_0) {
  var_1 = undefined;
  var_2 = scripts\cp\utility::_id_6902(var_0);
  var_1 = float(_func_0222("mp/statstable.csv", 4, var_2, 8));

  if(!isDefined(var_1) || var_1 < 1) {
    var_1 = float(_func_0222(level._id_60AE, 4, var_2, 8));
  }

  if(!isDefined(var_1) || var_1 < 1) {
    var_1 = 10;
  }

  return var_1;
}

_id_37FC(var_0) {
  return clamp(var_0, 0.0, 11.0);
}

_id_106C7(var_0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 0.5;

  if(!self hasweapon(var_0)) {
    var_0 = self getweaponslistprimaries()[0];
  }

  self setspawnweapon(var_0);
}

_id_7F36() {
  level._id_AFFB = [];
  level._id_CF95 = [];
  level._id_B000 = [];
  level._id_CF95["specialty_falldamage"] = 1;
  level._id_CF95["specialty_armorpiercing"] = 1;
  level._id_CF95["specialty_gung_ho"] = 1;
  level._id_CF95["specialty_momentum"] = 1;
  level._id_AFFB["specialty_momentum"] = ::_id_D5FF;
  level._id_B000["specialty_momentum"] = ::_id_FABF;
  level._id_AFFB["specialty_falldamage"] = ::_id_D56C;
  level._id_B000["specialty_falldamage"] = ::_id_FA96;
  level._id_AFFB["specialty_lightweight"] = ::_id_D5E3;
  level._id_B000["specialty_lightweight"] = ::_id_FAB7;
}

_id_D5FF() {
  thread _id_CA50();
}

_id_CA50() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(self issprinting()) {
      _id_7119();
      self._id_A25F = 1;
      _id_FCCC();
    }

    wait 0.1;
  }
}

_id_7119() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread _id_A0B5();
  thread _id_A0B4();

  for(var_0 = 0; var_0 < 0.08; var_0 = var_0 + 0.01) {
    self._id_A25F = self._id_A25F + 0.01;
    _id_FCCC();
    wait 0.4375;
  }

  self playlocalsound("ftl_phase_in");
  self notify("momentum_max_speed");
  thread _id_A0B3();
  self waittill("momentum_reset");
}

_id_A0B3() {
  self endon("momentum_unset");
  self waittill("momentum_reset");
  self playlocalsound("ftl_phase_out");
}

_id_A0B5() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self _meth_8498()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self _meth_8498()) {
        self notify("momentum_reset");
        break;
      }
    }

    waitframe();
  }
}

_id_A0B4() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("momentum_reset");
}

_id_FABF() {
  self notify("momentum_unset");
}

_id_D56C() {}

_id_FA96() {}

_id_D5E3() {
  self._id_A25F = _id_94CA();
  self[[level._id_A201]]();
}

_id_FAB7() {
  self._id_A25F = 1;
  self[[level._id_A201]]();
}

_id_94CA() {
  return 1.12;
}

_id_D345() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("force_bleed_out");
  self endon("last_stand");
  self endon("death");
  self endon("revive_success");
  self endon("self_revive_success");

  if(game["state"] != "postgame") {
    wait 0.1;
    var_0 = 4;
    var_1 = 0;
    var_2 = 0;
    var_2 = var_0;
    self allowdoublejump(0);
    self allowslide(var_2 &var_0);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowmantle(1);

  if(!scripts\cp\utility::_id_8580("grenade_cooldown")) {
    if(isDefined(level._id_BAB5)) {
      self[[level._id_BAB5]](0.0);
    }
  }

  self disableoffhandthrowback();
  self setscriptablepartstate("CompassIcon", "defaultIcon");
  self notify("set_player_perks");
}

_id_C299(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  var_17 = spawnStruct();
  var_17._id_25D7 = var_2;
  var_17._id_103CE = var_3;
  var_17._id_75E1 = var_4;
  var_17._id_73B5 = var_5;
  var_17._id_105F0 = var_6;
  var_17._id_10643 = var_7;
  var_17._id_AE0F = var_8;
  var_17._id_C7C2 = var_9;
  var_17._id_B042 = var_10;
  var_17._id_59D7 = var_11;
  var_17._id_8482 = var_12;
  var_17._id_8463 = var_13;
  var_17._id_9D61 = makeweaponfromstring(var_14);
  var_17._id_E6C8 = makeweaponfromstring(var_16);
  var_17._id_BA3D = var_15;
  level._id_B3DE[var_0] = var_17;

  if(!isDefined(level._id_1F8C)) {
    level._id_1F8C = [];
  }

  if(var_1 == "yes") {
    level._id_1F8C[level._id_1F8C.size] = var_0;
  }
}

_id_963C(var_0, var_1) {
  var_2 = var_1;
  self._id_37FF = var_2;
  var_0._id_9683 = _id_2E8D(var_2, 0);

  for(var_3 = 0; var_3 < 7; var_3++) {
    var_0._id_9685[var_3] = _id_2E8E(var_2, 0, var_3);
    var_0._id_9684[var_3] = _id_2E8F(var_2, 0, var_3);
  }

  var_0._id_9686 = _id_2E90(var_2, 0);
  var_0._id_968C = _id_2E93(var_2, 0);
  var_0._id_9689 = _id_2E92(var_2, 0);
  var_0._id_968E = _id_2E95(var_2, 0);
  var_0._id_9687 = _id_2E91(var_2, 0);

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_0._id_968D[var_4] = _id_2E94(var_2, 0, var_4);
  }

  var_0._id_9692 = _id_2E8D(var_2, 1);

  for(var_3 = 0; var_3 < 7; var_3++) {
    var_0._id_9694[var_3] = _id_2E8E(var_2, 1, var_3);
    var_0._id_9693[var_3] = _id_2E8F(var_2, 1, var_3);
  }

  var_0._id_9695 = _id_2E90(var_2, 1);
  var_0._id_969A = _id_2E93(var_2, 1);
  var_0._id_9698 = _id_2E92(var_2, 1);
  var_0._id_969C = _id_2E95(var_2, 1);
  var_0._id_9696 = _id_2E91(var_2, 1);

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_0._id_969B[var_4] = _id_2E94(var_2, 1, var_4);
  }

  var_0._id_966A = _id_2E7F(var_2);
  var_0._id_966E = _id_2E82(var_2);
  var_0._id_966B = _id_2E80(var_2);
  var_0._id_966F = _id_2E83(var_2);
  var_0._id_9676 = _id_2E85();
  var_0._id_966C = _id_2E81();
  var_0._id_965E = _id_2E7D();
  var_0._id_965C = _id_2E7B();
  var_0._id_965D = _id_2E7C();
  _id_FF4B(var_0);
  return var_0;
}

_id_6962(var_0) {
  return level._id_3803[var_0];
}

_id_FF4B(var_0) {
  var_1 = scripts\cp\utility::_id_10DB4(var_0._id_9683);
  var_2 = 0;

  if(!isDefined(var_1)) {
    var_2 = 1;
  } else if(_id_8B0E(var_0._id_9683)) {
    var_2 = 1;
  }

  if(_func_0417(var_0._id_9683)) {
    var_2 = 1;
    var_3 = 1;
  }

  if(var_2) {
    var_0._id_9683 = "iw8_ar_mike4";
    var_0._id_9685 = [];
    var_0._id_9686 = "none";
    var_0._id_968C = "none";
    var_0._id_968E = -1;
    var_0._id_9684 = [];
    var_0._id_9687 = "none";
    var_0._id_968D[0] = "none";
    var_0._id_968D[1] = "none";
    var_0._id_968D[2] = "none";
    var_0._id_968D[3] = "none";
  } else {
    if(_id_8B0F(var_0._id_9683, var_0._id_968E)) {
      var_0._id_968E = -1;
    }

    for(var_4 = 0; var_4 < var_0._id_9685.size; var_4++) {
      var_5 = var_0._id_9685[var_4];
      var_6 = var_0._id_9684[var_4];

      if(_id_876F(var_0._id_9683, var_5, var_6)) {
        var_0._id_9684[var_4] = 0;
      }

      if(var_5 != "none" && (_func_0418(var_5, var_0._id_9683) || !_id_8ADD(var_0._id_9683, var_5))) {
        var_0._id_9685[var_4] = "none";
        var_7 = 1;
      }
    }
  }

  var_1 = scripts\cp\utility::_id_10DB4(var_0._id_9692);
  var_2 = 0;

  if(!isDefined(var_1)) {
    var_2 = 1;
  } else if(_id_8B0E(var_0._id_9692)) {
    var_2 = 1;
  }

  if(_func_0417(var_0._id_9692)) {
    var_2 = 1;
    var_3 = 1;
  }

  if(var_2) {
    var_0._id_9692 = "iw8_pi_mike1911";
    var_0._id_9694 = [];
    var_0._id_9695 = "none";
    var_0._id_969A = "none";
    var_0._id_969C = -1;
    var_0._id_9693 = [];
    var_0._id_9696 = "none";
    var_0._id_969B[0] = "none";
    var_0._id_969B[1] = "none";
    var_0._id_969B[2] = "none";
    var_0._id_969B[3] = "none";
  } else {
    if(_id_8B0F(var_0._id_9692, var_0._id_969C)) {
      var_0._id_969C = -1;
    }

    for(var_4 = 0; var_4 < var_0._id_9694.size; var_4++) {
      var_5 = var_0._id_9694[var_4];
      var_6 = var_0._id_9693[var_4];

      if(_id_876F(var_0._id_9692, var_5, var_6)) {
        var_0._id_9693[var_4] = 0;
      }

      if(var_5 != "none" && (_func_0418(var_5, var_0._id_9692) || !_id_8ADD(var_0._id_9692, var_5))) {
        var_0._id_9694[var_4] = "none";
        var_7 = 1;
      }
    }
  }

  return var_0;
}

_id_8ADD(var_0, var_1) {
  var_2 = getdvarint("#x32fabf9b0576c3e2", 0) == 1;

  if(var_2) {
    return _id_1D9C(var_0, var_1);
  }

  return 1;
}

_id_1D9C(var_0, var_1) {
  var_2 = level._id_10D64[var_0];
  return isDefined(var_2) && isDefined(var_2[var_1]);
}

_id_8B0E(var_0) {
  return isDefined(level._id_10DB0[var_0]) && istrue(level._id_10DB0[var_0]._id_F91D);
}

_id_8B0F(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    return 0;
  }

  var_2 = var_0 + "|" + var_1;
  return isDefined(level._id_10DAC[var_2]) && istrue(level._id_10DAC[var_2]._id_8912);
}

_id_876F(var_0, var_1, var_2) {
  if(!isDefined(var_2) || var_2 == 0 || var_1 == "none") {
    return 0;
  }

  var_3 = 0;
  var_4 = 1;

  for(;;) {
    var_5 = var_0 + "|" + var_4;

    if(!isDefined(level._id_10DAC[var_5])) {
      break;
    }

    if(!level._id_10DAC[var_5]._id_8912) {
      if(isDefined(level._id_10DAC[var_5]._id_1D78)) {
        foreach(var_8, var_7 in level._id_10DAC[var_5]._id_1D78) {
          if(var_2 == var_7 && var_1 == var_8) {
            var_3 = 1;
            break;
          }
        }
      }

      if(var_3) {
        break;
      }
    }

    var_4++;
  }

  return !var_3;
}

_id_963D(var_0, var_1) {
  self._id_37FF = var_1;
  var_0._id_9683 = _id_EC6D(level._id_3809, var_1, 0);

  for(var_2 = 0; var_2 < 7; var_2++) {
    var_0._id_9685[var_2] = _id_EC6E(level._id_3809, var_1, 0, var_2);
  }

  var_0._id_9686 = _id_EC6F(level._id_3809, var_1, 0);
  var_0._id_968C = _id_EC70(level._id_3809, var_1, 0);
  var_0._id_9692 = _id_EC6D(level._id_3809, var_1, 1);

  for(var_2 = 0; var_2 < 7; var_2++) {
    var_0._id_9694[var_2] = _id_EC6E(level._id_3809, var_1, 1, var_2);
  }

  var_0._id_9695 = _id_EC6F(level._id_3809, var_1, 1);
  var_0._id_969A = _id_EC70(level._id_3809, var_1, 1);
  var_0._id_966A = _id_EC60(level._id_3809, var_1);
  var_0._id_966E = _id_EC63(level._id_3809, var_1);
  var_0._id_966B = _id_EC61(level._id_3809, var_1);
  var_0._id_966F = _id_EC64(level._id_3809, var_1);
  var_0._id_9676 = _id_EC66(level._id_3809, var_1);
  var_0._id_966C = _id_2E81();
  var_0._id_965E = _id_2E7D();
  var_0._id_965C = _id_2E7B();
  var_0._id_965D = _id_2E7C();

  if(getdvarint("#x3510e61cf3518ba9d", 0)) {
    var_0._id_96A2 = "super_bradley";
  }

  return var_0;
}

_id_2E85() {
  var_0 = "none";

  if(isDefined(self._id_33DA)) {
    var_1 = level._id_1A39[self._id_33DA._id_1A35];
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", var_1, "gesture");
  } else
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "gesture");

  return _id_0793::_id_6A6A(var_0);
}

_id_2E7D() {
  var_0 = undefined;

  if(scripts\cp\utility::_id_871A()) {
    var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  } else {
    var_0 = self getplayerdata("zmloadouts", "customizationSetup", "operatorWatch");
  }

  return _id_06F9::_id_687C(var_0);
}

_id_2E7B() {
  var_0 = undefined;

  if(scripts\cp\utility::_id_871A()) {
    var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  } else {
    var_0 = self getplayerdata("zmloadouts", "customizationSetup", "operatorWatch");
  }

  return _id_06F9::_id_6878(var_0);
}

_id_2E7C() {
  var_0 = undefined;

  if(scripts\cp\utility::_id_871A()) {
    var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  } else {
    var_0 = self getplayerdata("zmloadouts", "customizationSetup", "operatorWatch");
  }

  return _id_06F9::_id_687A(var_0);
}

_id_2E81() {
  return "neck_stab";
}

_id_2E94(var_0, var_1, var_2) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "sticker", var_2);
  } else {
    return self getplayerdata("zmloadouts", "zmLoadoutsData", "loadouts", var_0, "weaponSetups", var_1, "sticker", var_2);
  }
}

_id_962A() {
  var_0 = spawnStruct();
  var_0._id_965F = "none";
  var_0._id_9683 = "none";
  var_0._id_9685 = [];
  var_0._id_9684 = [];

  for(var_1 = 0; var_1 < 7; var_1++) {
    var_0._id_9685[var_1] = "none";
    var_0._id_9684[var_1] = 0;
  }

  var_0._id_9686 = "none";
  var_0._id_968C = "none";
  var_0._id_9689 = 0;
  var_0._id_968E = -1;
  var_0._id_9687 = "none";
  var_0._id_968F = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_0._id_968D[var_2] = "none";
  }

  var_0._id_9692 = "none";
  var_0._id_9694 = [];
  var_0._id_9693 = [];

  for(var_1 = 0; var_1 < 7; var_1++) {
    var_0._id_9694[var_1] = "none";
    var_0._id_9693[var_1] = 0;
  }

  var_0._id_9695 = "none";
  var_0._id_969A = "none";
  var_0._id_9698 = 0;
  var_0._id_969C = -1;
  var_0._id_9696 = "none";
  var_0._id_969D = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_0._id_969D[var_2] = "none";
  }

  var_0._id_967D = "none";
  var_0._id_9680 = 0;
  var_0._id_967F = [];
  var_0._id_969F = [];
  var_0._id_9670 = [];
  var_0._id_9690 = "specialty_null";
  var_0._id_966A = "none";
  var_0._id_966E = 0;
  var_0._id_966B = "none";
  var_0._id_966F = 0;
  var_0._id_96A2 = "none";
  var_0._id_9674 = "none";
  var_0._id_9675 = "none";
  var_0._id_9676 = "none";
  var_0._id_965C = "none";
  var_0._id_965E = "none";
  var_0._id_966C = "none";
  var_0._id_96A0 = 0;
  var_0._id_96A1 = "streaktype_assault";
  var_0._id_9679 = "none";
  var_0._id_967A = "none";
  var_0._id_967B = "none";
  return var_0;
}

_id_6F76(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = spawnStruct();
  var_4 = var_0 _id_2E8A();

  if(isDefined(var_1)) {
    var_3 = _id_963D(var_2, var_1);
  } else {
    var_3 = _id_963C(var_2, var_4);
  }

  self._id_3808 = var_3;
  _id_1D03(var_0, var_3);
  var_5 = _id_65FC(var_0, "primary");
  var_6 = _id_64CD(var_3._id_966A);

  if(!scripts\engine\utility::_id_1BA1(level._id_BADE, var_6)) {
    var_6 = "none";
  }

  var_7 = _id_65FC(var_0, "secondary");
  var_8 = _id_64CD(var_3._id_966B);

  if(!scripts\engine\utility::_id_1BA1(level._id_BADE, var_8)) {
    var_8 = "none";
  }

  var_9 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  if(!istrue(self._id_33EC)) {
    var_0 _id_0745::_id_C5C8(self, var_9);
    var_0 _id_0745::_id_1D04();
  }

  var_0 thread _id_0753::_id_6FD3(var_6, "primary", undefined, undefined, undefined, undefined, 1, var_5);
  var_0 thread _id_0753::_id_6FD3(var_8, "secondary", undefined, undefined, undefined, undefined, 1, var_7);
}

_id_65FC(var_0, var_1) {
  if(isDefined(level._id_65FC)) {
    return [[level._id_65FC]](var_0);
  }

  if(scripts\cp\utility::_hasperk("specialty_extra_deadly") && var_1 == "primary") {
    return 2;
  }

  if(isDefined(self._id_AFAA["offhand_count"])) {
    return self._id_AFAA["offhand_count"];
  }

  return 1;
}

_id_643F() {
  return 1;
}

_id_6EE5(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = var_0 _id_2E8A();

  if(isDefined(var_2)) {
    var_5 = _id_963D(var_3, var_2);
  } else {
    var_5 = _id_963C(var_3, var_4);
  }

  var_6 = _id_65FC(var_0, "primary");
  var_7 = _id_64CD(var_5._id_966A);

  if(!scripts\engine\utility::_id_1BA1(level._id_BADE, var_7)) {
    var_7 = "none";
  }

  var_8 = _id_65FC(var_0, "secondary");
  var_9 = _id_64CD(var_5._id_966B);

  if(!scripts\engine\utility::_id_1BA1(level._id_BADE, var_9)) {
    var_9 = "none";
  }

  if(!isDefined(var_1)) {
    var_0 thread _id_0753::_id_6FD3(var_7, "primary", undefined, undefined, undefined, undefined, 1, var_6);
    var_0 thread _id_0753::_id_6FD3(var_9, "secondary", undefined, undefined, undefined, undefined, 1, var_8);
  } else if(var_1 == 0)
    var_0 thread _id_0753::_id_6FD3(var_7, "primary", undefined, undefined, undefined, undefined, 1, var_6);
  else if(var_1 == 1) {
    var_0 thread _id_0753::_id_6FD3(var_9, "secondary", undefined, undefined, undefined, undefined, 1, var_8);
  }
}

_id_6EC6(var_0) {
  var_1 = spawnStruct();
  var_2 = var_0 _id_2E8A();
  var_3 = _id_963C(var_1, var_2);
  var_3._id_968A = var_0 _id_6F3E(var_0, var_3);
  var_4 = weaponclipsize(var_1._id_968A);
  var_5 = weaponmaxammo(var_1._id_968A);
  var_0 giveweapon(var_1._id_968A);
  var_0 setweaponammoclip(var_1._id_968A, var_4);
  var_0 setweaponammostock(var_1._id_968A, var_5);
  var_0 switchtoweapon(var_1._id_968A);
}

_id_6F3D(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = var_0 _id_2E8A();
  var_5 = _id_963C(var_3, var_4);
  var_5._id_968A = var_0 _id_6F3E(var_0, var_5);
  var_0 giveweapon(var_3._id_968A);
  var_0 setweaponammoclip(var_3._id_968A, var_1);
  var_0 setweaponammostock(var_3._id_968A, var_2);
  var_0 switchtoweapon(var_3._id_968A);
}

_id_6EC7(var_0, var_1) {
  var_1 = spawnStruct();
  var_2 = var_0 _id_2E8A();
  var_3 = _id_963C(var_1, var_2);
  var_3._id_9699 = var_0 _id_6F4A(var_0, var_3);
  var_4 = weaponclipsize(var_3._id_9699);
  var_5 = weaponmaxammo(var_3._id_9699);
  var_0 giveweapon(var_3._id_9699);
  var_0 setweaponammoclip(var_3._id_9699, var_4);
  var_0 setweaponammostock(var_3._id_9699, var_5);
  var_0 switchtoweaponimmediate(var_3._id_9699);
}

_id_6F49(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = var_0 _id_2E8A();
  var_5 = _id_963C(var_3, var_4);
  var_5._id_9699 = var_0 _id_6F4A(var_0, var_5);
  var_0 giveweapon(var_3._id_9699);
  var_0 setweaponammoclip(var_3._id_9699, var_1);
  var_0 setweaponammostock(var_3._id_9699, var_2);
  var_0 switchtoweapon(var_3._id_9699);
}

_id_33C8(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0.on_first_spawn = 1;

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "class_select" || var_1 == "class_edit" || var_1 == "class_menu_closed") {
      if(_id_8668()) {
        self notify("switched_from_core");
      }

      if(var_1 == "class_select") {
        var_3 = 1;

        if(var_2 >= 100) {
          var_4 = var_2 - 100;
          var_3 = 0;
        } else
          var_4 = var_2;

        if(istrue(var_0.instantloadoutswapallowed)) {
          var_0.has_selected_loadout = 1;
          var_0._id_33EC = 1;
          var_0._id_45A9 = var_4;
          var_0.usecustomclass = var_3;
          var_0 thread play_match_start_narration();
          var_0[[level._id_4249]](0, undefined, var_4, var_3);
        } else {
          var_0.respawnclassindex = var_4;
          var_0.respawncustomclass = var_3;
          var_5 = cac_getartifact(var_4, var_3);

          if(!isDefined(var_0._id_EB09._id_E76B._id_C189) || var_0._id_EB09._id_E76B._id_C189 != var_5) {
            var_0 update_super(var_4, var_3);
          }
        }

        _id_072E::close_all_menus();
      }

      if(var_1 == "class_menu_closed") {
        self notify("loadout_menu_closed");

        if(scripts\cp\utility::_id_871A()) {
          thread _id_2DDF();
        }
      }

      continue;
    }

    if(var_1 == "update_super") {
      continue;
    }
    if(var_1 == "munitions_updated") {
      var_6 = self getplayerdata("cp", "inventorySlots", "totalSlots");
      _id_0745::_id_C5C8(self, var_6);

      if(scripts\cp\utility::_id_871A()) {
        _id_EC42();
        thread _id_2DDF();
      }

      continue;
    }

    if(var_1 == "weapon_purchased" && scripts\cp\utility::_id_871A()) {
      _id_EC42();

      if(self getweaponslistprimaries().size > 1) {
        var_7 = scripts\cp\utility::_id_6E34();
        self takeweapon(var_7);
      }

      if(self._id_ABFA == 0) {
        _id_6EC6(self);
      } else if(self._id_ABFA == 1) {
        _id_6EC7(self);
      }

      continue;
    }

    if(var_1 == "attachment_purchased" && scripts\cp\utility::_id_871A()) {
      _id_EC42();
      var_7 = scripts\cp\utility::_id_6E34();
      var_8 = self getweaponammoclip(var_7);
      var_9 = self getweaponammostock(var_7);
      self takeweapon(var_7);

      if(self._id_ABFA == 0) {
        _id_6F3D(self, var_8, var_9);
      } else if(self._id_ABFA == 1) {
        _id_6F49(self, var_8, var_9);
      }

      continue;
    }

    if(var_1 == "tactical_purchased" && scripts\cp\utility::_id_871A()) {
      _id_EC42();
      _id_6EE5(self, 1, undefined);
      continue;
    }

    if(var_1 == "lethal_purchased" && scripts\cp\utility::_id_871A()) {
      _id_EC42();
      _id_6EE5(self, 0, undefined);
      continue;
    }

    if(var_1 == "ammo_purchased" && scripts\cp\utility::_id_871A()) {
      var_7 = scripts\cp\utility::_id_6E34();
      _id_EC42();
      self givemaxammo(var_7);
    }
  }
}

play_match_start_narration() {
  level endon("objective_triggered");
  level endon("game_ended");

  if(scripts\engine\utility::_id_5C00("match_start_vo_done")) {
    return;
  }
  if(istrue(level.is_playing_match_start_vo)) {
    return;
  }
  level.is_playing_match_start_vo = 1;

  if(scripts\cp\utility::_id_6871() == 1 && !isDefined(level._id_3BE9._id_0F51)) {
    wait 5.0;

    if(getdvarint("#x32499d9dc5db0430e", 0)) {
      thread _id_0720::play_narration("zm_cmcp_cann_zann_ahst");
      level waittill("dialogue_finished");
    }

    if(level.mapname == "cp_zm_skorpion") {
      thread _id_0720::play_narration("zm_zohs_hbsk_krft_hsaa");
      level waittill("dialogue_finished");
      var_0 = _id_0720::build_demon_chatter_alias("zm_{demon}_dmns");
      var_1 = _id_0720::build_demon_chatter_alias("zm_{demon-skorpion}_hsba");
      thread _id_0720::play_narration([var_0, var_1]);
      level waittill("dialogue_finished");
    } else if(level.mapname == "cp_sumpf") {
      if(getdvarint("#x33ad41eaa5a9a3eec", 0)) {
        var_2 = ["zm_cpm4_rbm4_krft_mg1a", "zm_cpm4_rbm4_blkr_mg1b", "zm_cpm4_rbm4_krft_mg1c"];
        var_3 = ["zm_cpm4_rbm4_krft_mg1d", "zm_cpm4_rbm4_blkr_mg1e", "zm_cpm4_rbm4_krft_mg1f"];
        var_4 = ["zm_cpm4_rbm4_krft_mg1g", "zm_cpm4_rbm4_blkr_mg1h", "zm_cpm4_rbm4_krft_mg1i"];
        var_5 = ["zm_cpm4_rbm4_krft_mg1j", "zm_cpm4_rbm4_blkr_mg1k", "zm_cpm4_rbm4_krft_mg1l"];
        var_6 = scripts\engine\utility::random([var_2, var_3, var_4, var_5]);
        level thread _id_0720::play_narrations(var_6, 1, 0, "force_quit_current_dialogue");
        level waittill("dialogue_finished");
        level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
      }
    } else if(level.mapname == "cp_zm_oasis") {
      if(getdvarint("#x3a165e78de6483fc8", 0)) {
        var_7 = ["zm_cpm5_rbm5_vlst_miaa", "zm_cpm5_rbm5_vlst_miab", "zm_cpm5_rbm5_krft_miac"];
        var_8 = ["zm_cpm5_rbm5_vlst_miad", "zm_cpm5_rbm5_vlst_miae", "zm_cpm5_rbm5_krft_miaf"];
        var_9 = ["zm_cpm5_rbm5_vlst_miag", "zm_cpm5_rbm5_vlst_miah", "zm_cpm5_rbm5_krft_miai"];
        var_10 = ["zm_cpm5_rbm5_vlst_miaj", "zm_cpm5_rbm5_vlst_miak", "zm_cpm5_rbm5_krft_mial"];
        var_11 = scripts\engine\utility::random([var_7, var_8, var_9, var_10]);
        level thread _id_0720::play_narrations(var_11, 1, 0, "force_quit_current_dialogue");
        level waittill("dialogue_finished");
        level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
      }
    } else {
      thread _id_0720::play_narration("zm_cmcp_obhb_krft_hust");
      level waittill("dialogue_finished");
      var_0 = _id_0720::build_demon_chatter_alias("zm_{demon}_dmns");
      var_1 = _id_0720::build_demon_hub_alias("hin");
      thread _id_0720::play_narration([var_0, var_1]);
      level waittill("dialogue_finished");
      thread _id_0720::play_narration("zm_cmcp_obhb_krft_huin");
      level waittill("dialogue_finished");
    }

    level.is_playing_match_start_vo = 0;
    scripts\engine\utility::_id_5C1B("match_start_vo_done");

    if(getdvarint("#x3dee089cb49164e4e", 0) == 0) {
      _id_0987::update_portal_nag();
    }
  }
}

_id_2DDF() {
  self _meth_8680("cp_store_duck", 1);
}

_id_EC42() {
  var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "currencyWaveMode");
  _id_074E::_id_D337(var_0);
}

_id_64CD(var_0) {
  switch (var_0) {
    case "equip_semtex":
      return "power_semtex";
    case "equip_smoke":
      return "power_smokeGrenade";
    case "equip_frag":
      return "power_frag";
    case "equip_molotov":
      return "power_molotov";
    case "equip_claymore":
      return "power_claymore";
    case "equip_gas_grenade":
      return "equip_gas_grenade";
    case "equip_throwing_knife":
      return "power_throwingKnife";
    case "equip_c4":
      return "power_c4";
    case "equip_hb_sensor":
      return "equip_hb_sensor";
    case "equip_thermite":
      return "power_thermite";
    case "equip_at_mine":
      return "power_atMine";
    case "equip_flash":
      return "power_flash";
    case "equip_concussion":
      return "power_concussionGrenade";
    case "equip_trophy":
      return "power_trophy";
    case "equip_snapshot_grenade":
      return "power_snapshotGrenade";
    case "equip_adrenaline":
      return "equip_adrenaline";
    case "equip_decoy":
      return "equip_decoy";
    default:
      return "none";
  }
}

_id_2E8A() {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "cpLoadoutSel");
}

cac_getfavoriteloadoutindex() {
  return self getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");
}

_id_2E89(var_0, var_1) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "loadoutPerks", var_1);
  } else {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "loadoutPerks", var_1);
  }
}

_id_2E88(var_0, var_1) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "extraPerks", var_1);
  } else {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "extraPerks", var_1);
  }
}

_id_2E8D(var_0, var_1) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "weapon");
  } else {
    return self getplayerdata("zmloadouts", "zmLoadoutsData", "loadouts", var_0, "weaponSetups", var_1, "weapon");
  }
}

_id_2E8E(var_0, var_1, var_2) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "attachmentSetup", var_2, "attachment");
  } else {
    return self getplayerdata("zmloadouts", "zmLoadoutsData", "loadouts", var_0, "weaponSetups", var_1, "attachmentSetup", var_2, "attachment");
  }
}

_id_2E8F(var_0, var_1, var_2) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "attachmentSetup", var_2, "variantID");
  } else {
    return self getplayerdata("zmloadouts", "zmLoadoutsData", "loadouts", var_0, "weaponSetups", var_1, "attachmentSetup", var_2, "variantID");
  }
}

_id_2E92(var_0, var_1) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "lootItemID");
  } else {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "lootItemID");
  }
}

_id_2E95(var_0, var_1) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "variantID");
  } else {
    return self getplayerdata("zmloadouts", "zmLoadoutsData", "loadouts", var_0, "weaponSetups", var_1, "variantID");
  }
}

_id_2E90(var_0, var_1) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "camo");
  } else {
    return self getplayerdata("zmloadouts", "zmLoadoutsData", "loadouts", var_0, "weaponSetups", var_1, "camo");
  }
}

_id_2E93(var_0, var_1) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "reticle");
  } else {
    return self getplayerdata("zmloadouts", "zmLoadoutsData", "loadouts", var_0, "weaponSetups", var_1, "reticle");
  }
}

_id_2E91(var_0, var_1) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "cosmeticAttachment");
  } else {
    return self getplayerdata("zmloadouts", "zmLoadoutsData", "loadouts", var_0, "weaponSetups", var_1, "cosmeticAttachment");
  }
}

_id_2E7A(var_0) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "loadoutPerks", 0);
  } else {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "loadoutPerks", 0);
  }
}

_id_2E7F(var_0) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "equipment");
  } else {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 0, "equipment");
  }
}

_id_2E82(var_0) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "extraCharge");
  } else {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 0, "extraCharge");
  }
}

_id_2E80(var_0) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "equipment");
  } else {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 1, "equipment");
  }
}

_id_2E83(var_0) {
  if(scripts\cp\utility::_id_871A()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "extraCharge");
  } else {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 1, "extraCharge");
  }
}

cac_getartifact(var_0, var_1) {
  if(isDefined(var_0)) {
    if(var_1) {
      return self getplayerdata("zmloadouts", "zmLoadoutsData", "loadouts", var_0, "artifact");
    }

    return table_getartifact(level._id_3809, var_0);
  }

  return "field_upgrade_aether_shroud";
}

_id_1D03(var_0, var_1) {
  if(var_1._id_9683 == "none") {
    var_1._id_9688 = "none";
    var_1._id_968A = undefined;
  } else {
    var_1._id_968A = var_0 scripts\cp\cp_weapon::buildweapon(var_1._id_9683, var_1._id_9685, var_1._id_9686, var_1._id_968C, var_1._id_968E, var_1._id_9684, var_1._id_9687, var_1._id_968D, istrue(var_1._id_9677));
    var_1._id_968A = _id_6F73(var_0, var_1._id_968A);
    var_1._id_9688 = getcompleteweaponname(var_1._id_968A);
  }

  if(var_1._id_9692 == "none") {
    var_1._id_9697 = "none";
    var_1._id_9699 = undefined;
  } else {
    var_1._id_9699 = var_0 scripts\cp\cp_weapon::buildweapon(var_1._id_9692, var_1._id_9694, var_1._id_9695, var_1._id_969A, var_1._id_969C, var_1._id_9693, var_1._id_9696, var_1._id_969B, istrue(var_1._id_9677));
    var_1._id_9699 = _id_6F73(var_0, var_1._id_9699);
    var_1._id_9697 = getcompleteweaponname(var_1._id_9699);
  }

  var_0._id_E6C8 = var_1._id_968A;
  var_0.primaryweaponobj = var_0._id_E6C8;
  var_0._id_458F = var_1._id_9699;
  var_0.secondaryweaponobj = var_0._id_458F;
}

_id_6F3E(var_0, var_1) {
  return var_0 scripts\cp\cp_weapon::buildweapon(var_1._id_9683, var_1._id_9685);
}

_id_6F4A(var_0, var_1) {
  return var_0 scripts\cp\cp_weapon::buildweapon(var_1._id_9692, var_1._id_9694);
}

_id_6F73(var_0, var_1) {
  var_2 = var_1 getaltweapon();

  if(var_2.basename != "none") {
    var_3 = weaponclass(var_2);

    if(var_3 == "spread") {
      var_0 setweaponammoclip(var_2, weaponclipsize(var_2));
    }
  }

  return var_1;
}

_id_EC5F(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutArchetype", var_1 + 1);
}

_id_EC68(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutName", var_1 + 1);
}

_id_EC6D(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return _func_0222(var_0, 0, "loadoutPrimary", var_1 + 1);
  } else {
    return _func_0222(var_0, 0, "loadoutSecondary", var_1 + 1);
  }
}

_id_EC6E(var_0, var_1, var_2, var_3) {
  var_4 = "none";

  if(var_2 == 0) {
    var_4 = _func_0222(var_0, 0, "loadoutPrimaryAttachment" + (var_3 + 1), var_1 + 1);
  } else {
    var_4 = _func_0222(var_0, 0, "loadoutSecondaryAttachment" + (var_3 + 1), var_1 + 1);
  }

  if(var_4 == "" || var_4 == "none") {
    return "none";
  } else {
    return var_4;
  }
}

_id_EC6F(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return _func_0222(var_0, 0, "loadoutPrimaryCamo", var_1 + 1);
  } else {
    return _func_0222(var_0, 0, "loadoutSecondaryCamo", var_1 + 1);
  }
}

_id_EC70(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return _func_0222(var_0, 0, "loadoutPrimaryReticle", var_1 + 1);
  } else {
    return _func_0222(var_0, 0, "loadoutSecondaryReticle", var_1 + 1);
  }
}

_id_EC69(var_0, var_1, var_2) {
  return _func_0222(var_0, 0, "loadoutPerk" + (var_2 + 1), var_1 + 1);
}

_id_EC65(var_0, var_1, var_2) {
  return _func_0222(var_0, 0, "loadoutExtraPerk" + (var_2 + 1), var_1 + 1);
}

_id_EC60(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutEquipmentPrimary", var_1 + 1);
}

_id_EC63(var_0, var_1) {
  var_2 = _func_0222(var_0, 0, "loadoutExtraEquipmentPrimary", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

_id_EC61(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutEquipmentSecondary", var_1 + 1);
}

_id_EC64(var_0, var_1) {
  var_2 = _func_0222(var_0, 0, "loadoutExtraEquipmentSecondary", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

_id_EC6C(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutSuper", var_1 + 1);
}

table_getartifact(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutArtifact", var_1 + 1);
}

_id_EC6B(var_0, var_1) {
  var_2 = _func_0222(var_0, 0, "loadoutSpecialist", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

_id_EC66(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutGesture", var_1 + 1);
}

_id_EC5E(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutAccessory", var_1 + 1);
}

_id_EC62(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutExecution", var_1 + 1);
}

_id_EC67(var_0, var_1, var_2) {
  return _func_0222(var_0, 0, "loadoutStreak" + var_2, var_1 + 1);
}

_id_EC6A(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutRole", var_1 + 1);
}

_id_6960(var_0) {
  var_0++;
  var_1 = undefined;

  if(var_0 > 100) {
    var_2 = var_0 - 100;
    var_1 = "default" + var_2;
  } else
    var_1 = "custom" + var_0;

  return var_1;
}

_id_8668() {
  if(isDefined(level._id_A6DF) && level._id_A6DF == self) {
    return 1;
  } else if(scripts\cp\cp_weapon::_id_B4C8(self)) {
    return 1;
  } else {
    return 0;
  }
}

_id_4FFF() {
  if(scripts\cp\cp_weapon::_id_B4C8(self)) {
    scripts\cp\cp_weapon::_id_4FF4(self);
  }
}