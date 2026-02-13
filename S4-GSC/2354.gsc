/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2354.gsc
*************************************************/

init() {
  _id_092E::_id_C1F0("weapon", ::_id_B0A7);
}

_id_B0A7(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(!isDefined(var_2.weapon_name)) {
    return;
  }
  var_4 = spawnStruct();
  var_4.player = var_0;
  var_4.origin = scripts\engine\utility::ter_op(isDefined(var_2._id_C558), var_2._id_C558, var_2.origin);
  var_4.triggeringweapon = var_2.weapon_name;
  var_5 = scripts\cp\utility::_id_6CE3(var_2.weapon_name);
  var_6 = 1;

  if(isDefined(var_2.pap_level)) {
    var_6 = var_2.pap_level + 1;
  }

  var_7 = scripts\cp\utility::_id_459B(var_2.current_attachments, []);
  var_8 = scripts\cp\utility::_id_459B(var_2.current_attachmentids, []);
  [var_7, var_8] = _id_0774::strip_pap_attachments(var_7, var_8);
  var_10 = var_0 scripts\cp\cp_weapon::buildweapon(var_2.weapon_name, var_7, var_2._id_00D2, var_2._id_0373, var_2._id_04CC, var_8, undefined, var_2._id_E840, undefined, var_6 - 1);

  if(isDefined(var_10)) {
    drop_relevant_weapon(var_4);
  } else {
    return;
  }

  if(isDefined(var_0._id_AE0A[var_5])) {
    var_0._id_AE0A[var_5]._id_991E = var_6;
  }

  if(!isDefined(var_10)) {
    return;
  }
  var_0 scripts\cp\utility::_giveweapon(var_10, var_2._id_04CC, undefined, 0);
  var_0 playsoundtoplayer("zmb_pickup_weapon", var_0);
  var_11 = randomintrange(0, 100);

  if(var_11 < 50) {
    var_0 _id_0720::_id_BEC0("weapon_pickup_any");
  } else {
    var_0 _id_0720::queue_weapon_pickup_dialogue(scripts\cp\utility::getweaponrootname(var_10) + "_mp");
  }

  if(isDefined(var_2._id_16D1)) {
    var_0 setweaponammoclip(var_10, var_2._id_16D1);
  }

  if(isDefined(var_2._id_16D9)) {
    var_0 setweaponammostock(var_10, var_2._id_16D9);
  }

  var_0 switchtoweaponimmediate(var_10);
  var_0 setclientomnvar("ui_pap_current_level", var_6);

  if(isDefined(var_2.weapon_name)) {
    if(istrue(var_2.is_magic_box_weapon)) {
      if(!isDefined(var_0.magic_box_weapons)) {
        var_0.magic_box_weapons = [];
      }

      var_0.magic_box_weapons = scripts\engine\utility::array_add(var_0.magic_box_weapons, var_10.basename);
    }

    if(istrue(var_2.is_chest_weapon)) {
      if(!isDefined(var_0.chest_weapons)) {
        var_0.chest_weapons = [];
      }

      var_0.chest_weapons = scripts\engine\utility::array_add(var_0.chest_weapons, var_10.basename);
    }
  }

  if(!isDefined(var_0.pers["telemetry"].first_weapon_in_round_base_name)) {
    var_12 = getweaponbasename(var_10);
    var_0.pers["telemetry"].first_weapon_in_round_base_name = var_12;
    var_0.pers["telemetry"].first_weapon_in_round_start_time = _func_00D7();
  }

  var_13 = "cploot";

  if(isDefined(var_1._id_CF0C)) {
    var_14 = strtok(var_1._id_CF0C, "_");

    if(var_14.size > 0) {
      var_13 = var_14[0];
    }
  }

  scripts\cp\telemetry_cp::logevent_weaponacquired(var_0, getweaponbasename(var_10), var_6, var_13);
  level notify("weapon_picked_up", var_10, var_2, var_0);
  var_0 notify("weapon_picked_up", var_10, var_2);
}

drop_relevant_weapon(var_0) {
  var_1 = var_0.player;
  var_2 = undefined;

  if(var_1 scripts\cp\cp_weapon::_id_752E(var_0.triggeringweapon)) {
    var_2 = var_1 scripts\cp\cp_weapon::_id_685A(var_0.triggeringweapon)[0];
  } else if(_id_0777::_id_DAE4(var_1)) {
    var_2 = var_1 scripts\cp\utility::_id_6E34();
  }

  if(scripts\cp\utility::_id_8774(var_2) && var_1 getweaponammoclip(var_2) == 0) {
    var_1 takeweapon(var_2);
    return 0;
  }

  if(isDefined(var_2) && isweapon(var_2)) {
    if(!isDefined(var_0.origin)) {
      var_3 = anglesToForward(var_1 getplayerangles());
      var_4 = var_1.origin + var_3 * 10.0;
      var_4 = scripts\engine\utility::_id_5000(var_4);
      var_0.origin = var_4;

      if(!isDefined(var_0.shouldoffset)) {
        var_0.shouldoffset = 1;
      }
    }

    var_0.weapobj = var_2;
    _id_5003(var_0);
    return 1;
  }

  return 0;
}

_id_5003(var_0) {
  var_1 = var_0.weapobj;
  var_2 = var_0.player;
  var_3 = var_0.origin;

  if(istrue(var_0.shouldoffset)) {
    var_3 = var_3 + (0, 0, 5);
  }

  var_4 = scripts\cp\utility::_id_6CE3(var_1);
  var_5 = var_2 scripts\cp\cp_weapon::_id_683D(var_1) - 1;
  var_6 = var_1._id_0070;
  var_7 = var_1._id_0071;
  var_8 = _func_00ED(var_1);
  var_9 = _func_00F3(var_1);

  if(issubstr(var_9, "scope")) {
    var_9 = int(_func_0440(var_9, "scope"));

    if(var_9 == 0) {
      var_9 = undefined;
    }
  } else if(!isDefined(scripts\cp\cp_weapon::_id_6CF2(var_9)))
    var_9 = undefined;

  var_10 = _func_02F7(var_1);
  var_11 = [];
  var_11 = scripts\engine\utility::array_add(var_11, var_1._id_0409);
  var_11 = scripts\engine\utility::array_add(var_11, var_1._id_040A);
  var_11 = scripts\engine\utility::array_add(var_11, var_1._id_040B);
  var_11 = scripts\engine\utility::array_add(var_11, var_1._id_040C);
  var_12 = var_3 - var_2.origin;
  var_13 = _func_0261(var_12);
  var_14 = 0;
  var_15 = (var_14, var_13, 0);
  var_16 = _id_092E::_id_E24D(var_1, var_3, var_15, undefined, var_5);
  var_16._id_16D1 = var_2 getweaponammoclip(var_1);
  var_16._id_16D9 = var_2 getweaponammostock(var_1);
  var_16.current_attachments = var_6;
  var_16.current_attachmentids = var_7;
  var_16._id_00D2 = var_8;
  var_16._id_0373 = var_9;
  var_16._id_04CC = var_10;
  var_16._id_E840 = var_11;

  if(isDefined(var_2.magic_box_weapons) && scripts\engine\utility::array_contains(var_2.magic_box_weapons, var_1.basename)) {
    var_16.is_magic_box_weapon = 1;
    var_2.magic_box_weapons = scripts\engine\utility::array_remove(var_2.magic_box_weapons, var_1.basename);
  }

  if(isDefined(var_2.chest_weapons) && scripts\engine\utility::array_contains(var_2.chest_weapons, var_1.basename)) {
    var_16.is_chest_weapon = 1;
    var_2.chest_weapons = scripts\engine\utility::array_remove(var_2.chest_weapons, var_1.basename);
  }

  if(isDefined(var_2._id_AE0A[var_4])) {
    var_2._id_AE0A[var_4]._id_991E = 1;
  }

  var_2 takeweapon(var_1);
  var_2 notify("weapon_level_changed");
  var_2 notify("weapon_dropped", var_16, var_1);
}