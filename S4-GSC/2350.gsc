/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2350.gsc
*************************************************/

init() {
  level._id_3E13 = spawnStruct();
  level._id_3E13._id_8B20 = [];
  _id_2CC5();
  _id_80A4();
  _id_092F::init();
  _id_0931::init();
  _id_0930::init();
  _id_0932::init();
  scripts\cp\item\cp_item_armor::init();
  scripts\cp\item\cp_item_self_revive::init();
  scripts\cp\item\cp_item_killstreak::init();
  _id_07A1::_id_CECB(::_id_8B2F);
  _id_07A1::_id_CEC6(::_id_8B2F);
  level.weapon_drop_exclude_list = [];
  level.weapon_drop_exclude_list[0] = "s4_me_rindigoww_mp";
  level.weapon_drop_exclude_list[1] = "s4_ar_tgun_mp";
}

_id_C1F0(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level._id_3E13._id_8B20[var_0])) {
    return;
  }
  var_5 = spawnStruct();
  var_5._id_B07D = var_1;
  var_5._id_30DA = var_2;
  var_5.should_auto_pickup_func = var_3;
  var_5.can_drop_func = var_4;
  level._id_3E13._id_8B20[var_0] = var_5;
}

check_item_can_drop(var_0) {
  if(_id_8613(var_0)) {
    var_1 = level._id_3E13._id_4355[var_0];
    var_2 = level._id_3E13._id_8B20[var_1._id_8B2D];

    if(isDefined(var_2.can_drop_func)) {
      return [[var_2.can_drop_func]](var_1);
    }
  }

  if(isDefined(level.weapon_drop_exclude_list) && scripts\engine\utility::array_contains(level.weapon_drop_exclude_list, var_0)) {
    return 0;
  }

  if(isDefined(level.oasis_wonder_weapons) && scripts\engine\utility::array_contains(level.oasis_wonder_weapons, var_0) && isDefined(level.oasis_check_wonder_weapon_drop)) {
    return [[level.oasis_check_wonder_weapon_drop]](var_0);
  }

  if(isDefined(level.wonder_weapon_name) && var_0 == level.wonder_weapon_name && !istrue(level.can_drop_wonder_weapon)) {
    return 0;
  }

  if(isDefined(level.can_drop_wonder_weapon_func)) {
    return [[level.can_drop_wonder_weapon_func]](var_0);
  }

  return 1;
}

_id_E178(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!istrue(var_5)) {
    _id_3907();
  }

  var_8 = _func_03C5(var_0, var_1, var_2, var_3);

  if(!istrue(var_5)) {
    _id_C216(var_8);
  }

  if(var_4) {
    var_8 setscriptablepartstate(var_0, "dropped");
  }

  if(!istrue(var_5)) {
    var_9 = scripts\cp\utility::_id_459B(var_7, 180);
    _id_4745(var_8, var_9);
  }

  var_10 = level._id_3E13._id_4355[var_0];

  if(isDefined(var_10._id_BE99)) {
    var_8._id_BE99 = var_10._id_BE99;
  }

  var_8.is_externally_managed = var_5;
  var_8._id_332F = var_6;
  return var_8;
}

_id_E24D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!istrue(var_6)) {
    _id_3907();

    if(_func_0107(level.item_drop_permanent_weapon_list) && isDefined(var_0.basename)) {
      var_6 = scripts\engine\utility::array_contains(level.item_drop_permanent_weapon_list, var_0.basename);
    }
  }

  if(isDefined(var_7)) {
    var_8 = var_7;
  } else if(isDefined(var_0.type) && var_0.type == "riotshield") {
    if(isDefined(var_0.basename) && var_0.basename == "s4_me_rindigoww_mp") {
      var_8 = level._id_3E13.wonder_shield_scriptable_name;
    } else {
      var_8 = level._id_3E13.shield_scriptable_name;
    }
  } else if(isDefined(var_0.basename) && (var_0.basename == "s4_pi_raygun_mp" || var_0.basename == "s4_ar_tgun_mp"))
    var_8 = level._id_3E13.wonder_gun_scriptable_name;
  else {
    var_8 = level._id_3E13.weapon_scriptable_names[var_4];
  }

  var_9 = _func_03F1(var_8, var_1, var_2, var_3, var_0);
  var_9.weapon_name = getcompleteweaponname(var_0);

  if(!istrue(var_6)) {
    _id_C216(var_9);
  }

  var_9.pap_level = var_4;

  if(var_5) {
    var_9 setscriptablepartstate(var_8, "dropped");
  }

  if(!istrue(var_6)) {
    _id_4745(var_9, 180);
  }

  var_9.is_externally_managed = var_6;
  return var_9;
}

spawn_killstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!istrue(var_5)) {
    _id_3907();
  }

  var_8 = level._id_3E13.specific_killstreak_scriptable_names["none"];
  var_9 = 1;

  if(isDefined(var_7)) {
    var_8 = var_7;
  } else if(isDefined(level._id_3E13.specific_killstreak_scriptable_names[var_0])) {
    var_8 = level._id_3E13.specific_killstreak_scriptable_names[var_0];
    var_9 = 0;
  }

  if(istrue(var_9)) {
    var_10 = scripts\cp\cp_killstreaks::get_killstreak_weapon_from_ref(var_0);
    var_11 = makeweapon(var_10);
    var_12 = _func_03F1(var_8, var_1, var_2, var_3, var_11);
    var_12.weapon_name = var_10;
  } else
    var_12 = _func_03C5(var_8, var_1, var_2, var_3);

  var_12.streak_name = var_0;
  var_12._id_AE4A = var_6;

  if(!istrue(var_5)) {
    _id_C216(var_12);
  }

  if(var_4) {
    var_12 setscriptablepartstate(var_8, "dropped");
  }

  if(!istrue(var_5)) {
    _id_4745(var_12, 180);
  }

  var_12.is_externally_managed = var_5;
  return var_12;
}

_id_8B2F(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0.type;

  if(_id_8613(var_6)) {
    var_7 = level._id_3E13._id_4355[var_6];
    var_8 = level._id_3E13._id_8B20[var_7._id_8B2D];
    var_9 = !isDefined(var_0.usable_player) || var_0.usable_player == var_3;

    if(istrue(var_9) && isDefined(var_8._id_30DA)) {
      var_9 = [[var_8._id_30DA]](var_3, var_7, var_0);
    }

    if(var_9) {
      var_10 = 1;

      if(istrue(var_4) && isDefined(var_3.nextautotime) && gettime() < var_3.nextautotime) {
        var_10 = 0;
      }

      if(istrue(var_10) && istrue(var_4) && isDefined(var_8.should_auto_pickup_func)) {
        var_10 = [[var_8.should_auto_pickup_func]](var_3, var_7, var_0);
      }

      if(!istrue(var_4) || var_10) {
        level thread[[var_8._id_B07D]](var_3, var_7, var_0, var_4);

        if(isDefined(var_0)) {
          if(var_0 _meth_86FB()) {
            _id_4744(var_0);
          } else {
            var_0 setscriptablepartstate(var_1, "hidden");
          }
        }

        var_3.nextautotime = gettime() + 100.0;
      }
    }
  }
}

_id_46F7() {
  var_0 = _id_6737();

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    _id_4744(var_2);
  }
}

_id_8613(var_0) {
  return isDefined(level._id_3E13._id_4355[var_0]);
}

_id_2CC5() {
  level._id_3E13._id_4355 = [];
  level._id_3E13.weapon_scriptable_names = [];
  level._id_3E13.specific_killstreak_scriptable_names = [];
  level._id_3E13.weapon_wall_buy_scriptable_name = "";
  var_0 = getDvar("#x367002091f348e34d");

  if(!isDefined(var_0) || var_0 == "") {
    return;
  }
  var_1 = tablelookupgetnumrows(var_0);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = tablelookupbyrow(var_0, var_2, 0);

    if(!isDefined(var_3) || var_3 != "item") {
      continue;
    }
    var_4 = spawnStruct();
    var_4._id_CF0C = tablelookupbyrow(var_0, var_2, 1);
    var_4._id_8B2D = tablelookupbyrow(var_0, var_2, 2);
    var_4._id_22AC = tablelookupbyrow(var_0, var_2, 8);
    var_5 = tablelookupbyrow(var_0, var_2, 7);

    if(var_5 != "") {
      var_4.pickup_sound = var_5;
    }

    var_6 = tablelookupbyrow(var_0, var_2, 4);

    if(var_6 != "") {
      var_4._id_BE99 = int(var_6);
    }

    var_7 = int(tablelookupbyrow(var_0, var_2, 6));

    if(var_4._id_8B2D == "weapon") {
      if(istrue(var_7)) {
        var_4._id_8B2D = "killstreak";

        if(var_4._id_22AC == "") {
          level._id_3E13.specific_killstreak_scriptable_names["none"] = var_4._id_CF0C;
        } else {
          level._id_3E13.specific_killstreak_scriptable_names[var_4._id_22AC] = var_4._id_CF0C;
        }
      } else if(var_4._id_CF0C == "cploot_weapon_riotshield")
        level._id_3E13.shield_scriptable_name = var_4._id_CF0C;
      else if(var_4._id_CF0C == "cploot_weapon_wonder_shield") {
        level._id_3E13.wonder_shield_scriptable_name = var_4._id_CF0C;
      } else if(var_4._id_CF0C == "cploot_weapon_wonder_gun") {
        level._id_3E13.wonder_gun_scriptable_name = var_4._id_CF0C;
      } else if(var_4._id_CF0C == "cploot_weapon_wall_buy_base") {
        level._id_3E13.weapon_wall_buy_scriptable_name = var_4._id_CF0C;
      } else {
        var_8 = strtok(var_4._id_CF0C, "_");
        var_9 = int(var_8[var_8.size - 1]);
        level._id_3E13.weapon_scriptable_names[var_9] = var_4._id_CF0C;
      }
    }

    level._id_3E13._id_4355[var_4._id_CF0C] = var_4;
  }
}

_id_80A4() {
  var_0 = level._id_3E13;
  var_0._id_CF26 = [];
  var_0._id_CF2B = 0;
  var_0._id_CF29 = 0;
  var_0._id_CF2A = getdvarint("#x36957e79907e84a46", 750);
  var_0._id_CF28 = getdvarint("#x3c5fd4304ced5f555", 10);
  var_0.weaponscriptablesmax = getdvarint("#x3da519925bc64bc71", 10);
  var_0.weaponscriptables = [];
}

_id_6737() {
  return level._id_3E13._id_CF26;
}

_id_C216(var_0) {
  var_1 = level._id_3E13._id_CF29;
  var_0._id_3E25 = var_1;
  level._id_3E13._id_CF26[var_1] = var_0;
  level._id_3E13._id_CF29++;

  if(isDefined(var_0.weapon_name)) {
    level._id_3E13.weaponscriptables = scripts\engine\utility::array_add(level._id_3E13.weaponscriptables, var_0);
  }
}

_id_47FF(var_0) {
  if(!isDefined(level.soak_testing)) {
    if(isDefined(var_0._id_3E25)) {
      level._id_3E13._id_CF26[var_0._id_3E25] = undefined;
    }
  } else if(isDefined(var_0._id_3E25) && level._id_3E13._id_CF26.size >= var_0._id_3E25)
    level._id_3E13._id_CF26[var_0._id_3E25] = undefined;

  if(isDefined(var_0.weapon_name)) {
    level._id_3E13.weaponscriptables = scripts\engine\utility::array_remove(level._id_3E13.weaponscriptables, var_0);
  }

  var_0._id_3E25 = undefined;
  var_0 notify("deregister");
}

_id_3907() {
  var_0 = level._id_3E13;

  if(var_0._id_CF26.size >= var_0._id_CF2A) {
    var_1 = 0;

    for(var_2 = var_0._id_CF2B; var_2 < var_0._id_CF29; var_2++) {
      if(var_1 == var_0._id_CF28) {
        break;
      }

      var_3 = var_0._id_CF26[var_2];

      if(isDefined(var_3)) {
        if(isDefined(var_3.weapon_name)) {
          level._id_3E13.weaponscriptables = scripts\engine\utility::array_remove(level._id_3E13.weaponscriptables, var_3);
        }

        var_0._id_CF26[var_2] = undefined;
        var_3 notify("death");

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

  if(var_0.weaponscriptables.size >= var_0.weaponscriptablesmax) {
    var_3 = var_0.weaponscriptables[0];

    if(isDefined(var_3)) {
      level._id_3E13.weaponscriptables = scripts\engine\utility::array_remove(level._id_3E13.weaponscriptables, var_3);
      var_0._id_CF26[var_3._id_3E25] = undefined;
      var_3 notify("death");

      if(isent(var_3)) {
        var_3 delete();
      } else {
        var_3 _meth_86BE();
      }
    }
  }
}

_id_4744(var_0) {
  if(!istrue(var_0.is_externally_managed)) {
    _id_47FF(var_0);
  }

  if(isDefined(level.soak_testing)) {
    if(isent(var_0)) {
      var_0 delete();
    } else {
      var_0 notify("death");

      if(!_func_0458(var_0)) {
        var_0 _meth_86BE();
      }
    }
  } else if(isent(var_0))
    var_0 delete();
  else {
    var_0 notify("death");

    if(isDefined(var_0)) {
      var_0 _meth_86BE();
    }
  }
}

_id_4745(var_0, var_1) {
  var_0 thread _id_4746(var_1);
}

_id_4746(var_0) {
  level endon("game_ended");
  self endon("death");
  wait(var_0);

  if(isDefined(self)) {
    self notify("time_out_cleanup");
    thread _id_4744(self);
  }
}

show_pickup_notification(var_0, var_1, var_2) {
  self setclientomnvar("ui_zm_item_pickup_equipment_type", var_2);
  self setclientomnvar("ui_zm_item_pickup_amount", int(var_1));
  self setclientomnvar("ui_zm_item_pickup_type", var_0);
}