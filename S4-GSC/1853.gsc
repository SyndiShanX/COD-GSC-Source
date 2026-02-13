/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1853.gsc
*************************************************/

init() {
  level._id_9860 = [];
  level._id_125E = [];
  level.cache_drop_table_names = [];

  if(getdvarint("#x3dee089cb49164e4e", 0) && isDefined(level.rbz_register_ai_drop_table)) {
    [[level.rbz_register_ai_drop_table]]();
  } else {
    var_0 = "zm_loot_normal_enemies_";
    var_1 = "zm_loot_special_enemies_";
    var_2 = 10;

    for(var_3 = 1; var_3 <= var_2; var_3++) {
      _id_C1C5("normal", var_3, var_0 + var_3);
    }

    for(var_3 = 1; var_3 <= var_2; var_3++) {
      _id_C1C5("special", var_3, var_1 + var_3);
    }

    _id_C1C5("elite", 10, var_1 + "10");
  }

  register_cache_drop_table("syphoncore", 1, "zm_loot_syphoncore_level_1");
  register_cache_drop_table("syphoncore", 2, "zm_loot_syphoncore_level_2");
  register_cache_drop_table("syphoncore", 3, "zm_loot_syphoncore_level_3");
  register_cache_drop_table("syphoncore", 4, "zm_loot_syphoncore_level_4");
  register_cache_drop_table("syphoncore", 5, "zm_loot_syphoncore_level_5");
  register_cache_drop_table("syphoncore", 6, "zm_loot_syphoncore_level_6");
  register_cache_drop_table("syphoncore", 7, "zm_loot_syphoncore_level_7");
  register_cache_drop_table("syphoncore", 8, "zm_loot_syphoncore_level_8");
  register_cache_drop_table("syphoncore", 9, "zm_loot_syphoncore_level_9");
  register_cache_drop_table("syphoncore", 10, "zm_loot_syphoncore_level_10");
  register_cache_drop_table("syphoncore", 11, "zm_loot_syphoncore_level_11");
  register_cache_drop_table("syphoncore", 12, "zm_loot_syphoncore_level_12");
  register_cache_drop_table("syphoncore", 13, "zm_loot_syphoncore_level_13");
  register_cache_drop_table("syphoncore", 14, "zm_loot_syphoncore_level_14");
  register_cache_drop_table("syphoncore", 15, "zm_loot_syphoncore_level_15");
  register_cache_drop_table("syphoncore", 16, "zm_loot_syphoncore_level_16");
  register_cache_drop_table("zm_loot_chest", 1, "zm_loot_chest_level_1");
  register_cache_drop_table("zm_loot_chest", 2, "zm_loot_chest_level_2");
  register_cache_drop_table("zm_loot_chest", 3, "zm_loot_chest_level_3");
  register_cache_drop_table("zm_loot_chest", 4, "zm_loot_chest_level_4");
  register_cache_drop_table("zm_loot_chest", 5, "zm_loot_chest_level_5");
  register_cache_drop_table("zm_loot_chest", 6, "zm_loot_chest_level_6");
  register_cache_drop_table("zm_loot_chest", 7, "zm_loot_chest_level_7");
  register_cache_drop_table("zm_loot_chest", 8, "zm_loot_chest_level_8");
  register_cache_drop_table("zm_loot_chest", 9, "zm_loot_chest_level_9");
  register_cache_drop_table("zm_loot_chest", 10, "zm_loot_chest_level_10");
  register_cache_drop_table("s4_zm_loot_crystal", 1, "zm_loot_crystal_level_1");
  register_cache_drop_table("s4_zm_loot_crystal", 2, "zm_loot_crystal_level_2");
  register_cache_drop_table("s4_zm_loot_crystal", 3, "zm_loot_crystal_level_3");
  register_cache_drop_table("s4_zm_loot_crystal", 4, "zm_loot_crystal_level_4");
  register_cache_drop_table("s4_zm_loot_crystal", 5, "zm_loot_crystal_level_5");
  register_cache_drop_table("s4_zm_loot_crystal", 6, "zm_loot_crystal_level_6");
  register_cache_drop_table("s4_zm_loot_crystal", 7, "zm_loot_crystal_level_7");
  register_cache_drop_table("s4_zm_loot_crystal", 8, "zm_loot_crystal_level_8");
  register_cache_drop_table("s4_zm_loot_crystal", 9, "zm_loot_crystal_level_9");
  register_cache_drop_table("s4_zm_loot_crystal", 10, "zm_loot_crystal_level_10");

  if(!getdvarint("#x3dee089cb49164e4e", 0)) {
    register_loot_table("magicbox", 1, "zm_loot_magicbox_level_1");
    register_loot_table("magicbox", 2, "zm_loot_magicbox_level_2");
    register_loot_table("magicbox", 3, "zm_loot_magicbox_level_3");
    register_loot_table("magicbox", 4, "zm_loot_magicbox_level_4");
    register_loot_table("magicbox", 5, "zm_loot_magicbox_level_5");
    register_loot_table("magicbox", 6, "zm_loot_magicbox_level_6");
    register_loot_table("magicbox", 7, "zm_loot_magicbox_level_7");
    register_loot_table("magicbox", 8, "zm_loot_magicbox_level_8");
    register_loot_table("magicbox", 9, "zm_loot_magicbox_level_9");
    register_loot_table("magicbox", 10, "zm_loot_magicbox_level_10");
    register_loot_table("magicbox", 11, "zm_loot_magicbox_level_11");
    register_loot_table("magicbox", 12, "zm_loot_magicbox_level_12");
    register_loot_table("magicbox", 13, "zm_loot_magicbox_level_13");
    register_loot_table("magicbox", 14, "zm_loot_magicbox_level_14");
    register_loot_table("magicbox", 15, "zm_loot_magicbox_level_15");
    register_loot_table("magicbox", 16, "zm_loot_magicbox_level_16");
  }

  register_loot_table("magicbox", undefined, "zm_loot_magicbox_s2_mq_complete");

  if(getdvarint("#x36ca14263dbaa1beb", 0)) {
    register_loot_table("dark_aether_anemone", 1, "zm_dark_aether_anemone");
    register_loot_table("dark_aether_crystal", 1, "zm_dark_aether_crystal");
  }

  register_loot_table("aether_pocket_crystal_loot", 1, "zm_loot_crystal_oasis");
  _id_06CB::_id_AA4A(::_id_AA4A);
  _id_06CB::on_ai_spawned(::on_ai_spawned);
  _id_07A1::_id_CECC("zm_loot_chest", ::activate_loot_chest);
  level.cache_type_to_name_map = [];
  level.cache_type_to_name_map["chest"] = "zm_loot_chest";
  level.cache_type_to_name_map["crystal"] = "s4_zm_loot_crystal";
  level.managed_loot_weapons = [];
}

register_cache_drop_table(var_0, var_1, var_2) {
  _id_95C8(var_2);
  level.cache_drop_table_names[var_0][var_1] = var_2;
}

_id_C1C5(var_0, var_1, var_2) {
  _id_95C8(var_2);
  level._id_125E[var_0][var_1] = var_2;
}

register_loot_table(var_0, var_1, var_2) {
  _id_95C8(var_2);

  if(isDefined(var_1)) {
    level.loot_table_names[var_0][var_1] = var_2;
  }
}

_id_95C8(var_0) {
  if(isDefined(level._id_9860[var_0])) {
    return;
  }
  var_1 = [];
  var_2 = _func_0393("itemspawnlist:" + var_0);

  foreach(var_4 in var_2._id_8B33) {
    var_5 = spawnStruct();
    var_5._id_9EAE = scripts\cp\utility::_id_459B(var_4.minweight, 0);
    var_5._id_9C43 = scripts\cp\utility::_id_459B(var_4.maxweight, 0);
    var_5._id_E109 = scripts\cp\utility::_id_459B(var_4._id_E28F, 1);
    var_6 = scripts\cp\utility::_id_459B(var_4.istable, 0);

    if(var_6) {
      _id_95C8(var_4._id_8B34);
    }

    var_1[var_4._id_8B34] = var_5;
  }

  level._id_9860[var_0] = var_1;
}

_id_4FF0(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_loot_table(var_0);

  if(!isDefined(var_5)) {
    return undefined;
  }

  select_and_spawn_items_from_table(var_5, var_1, var_2, var_3, var_0, undefined, undefined, undefined, undefined, undefined, var_4);
}

get_loot_table(var_0) {
  if(istrue(level.b_s2_mq_complete)) {
    return level._id_9860["zm_loot_magicbox_s2_mq_complete"];
  } else {
    var_1 = level.loot_table_names[var_0];

    if(!isDefined(var_1)) {
      return undefined;
    }

    return get_highest_round_loot_table(var_1, scripts\cp\utility::_id_6871());
  }
}

get_possible_loot_item_names(var_0) {
  var_1 = get_loot_table(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  return get_item_names_from_table(var_1);
}

get_item_names_from_table(var_0) {
  var_1 = [];

  foreach(var_5, var_3 in var_0) {
    if(var_3._id_9EAE != 0) {
      var_4 = level._id_9860[var_5];

      if(isDefined(var_4)) {
        var_1 = scripts\engine\utility::_id_1B9D(var_1, get_item_names_from_table(var_4));
      } else {
        var_1 = scripts\cp\utility::_id_1B8C(var_1, var_5);
      }
    }
  }

  return var_1;
}

_id_125D(var_0, var_1, var_2, var_3) {
  var_4 = getdvarint("#x3d53fb400bcd1e48a", 0);
  var_5 = 1;

  if(isDefined(level.check_in_playable_area_func)) {
    var_5 = [[level.check_in_playable_area_func]](self);
  }

  if(!isPlayer(var_3) || istrue(self._id_4A75) || istrue(var_4) || !istrue(var_5)) {
    remove_potential_weapon_source(var_0);
    return;
  }

  var_6 = _id_6308(var_0, scripts\cp\utility::_id_6871());

  if(!isDefined(var_6)) {
    return;
  }
  select_and_spawn_items_from_table(var_6, var_1, var_2, var_3, var_0);
}

select_and_spawn_items_from_table(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = 0.0;
  var_12 = undefined;
  var_13 = undefined;

  if(isPlayer(var_3)) {
    var_11 = scripts\cp\utility::_id_459B(var_3 _id_0945::_id_664E("ammo_drop_increase"), 0);

    if(isDefined(var_4) && (var_4 == "special" || var_4 == "elite")) {
      if(isDefined(level.special_ai_weapon_drop_multiplier)) {
        var_12 = level.special_ai_weapon_drop_multiplier;
      }

      if(isDefined(level.special_ai_raygun_drop_multiplier)) {
        var_13 = level.special_ai_raygun_drop_multiplier;
      }
    }
  }

  var_14 = _id_D040(var_0, var_11, undefined, var_12, var_13);
  remove_potential_weapon_source(var_4);
  var_15 = 0;

  foreach(var_17 in var_14) {
    if(var_17 != "EMPTY") {
      [var_19, var_20, var_21] = _id_6531(var_15, var_1, var_2, undefined, var_5);

      if(scripts\cp\cp_killstreaks::is_killstreak_name(var_17)) {
        var_22 = spawnStruct();
        var_22._id_5BD9 = 1;
        _id_092E::spawn_killstreak(var_17, var_19, var_20, var_21, undefined, undefined, var_22);
      } else if(_id_0777::_id_8720(var_17)) {
        var_23 = get_weapon_for_category(var_4, var_17, var_19, var_20, var_21);

        if(isDefined(var_6) && isDefined(var_6.type) && var_6.type == "s4_zm_loot_chest") {
          var_23.is_chest_weapon = 1;
        }

        if(isDefined(var_6) && isDefined(var_6.type) && var_6.type == "s4_zm_loot_chest") {
          var_23.is_chest_weapon = 1;
        }
      } else
        _id_092E::_id_E178(var_17, var_19, var_20, var_21, undefined, undefined, var_4, var_10);

      var_15++;

      if(isDefined(var_7)) {
        if(isDefined(var_8) && isent(var_9)) {
          var_9 playSound(var_8);
        }

        wait(var_7);
      }
    }
  }
}

get_weapon_for_category(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(level.managed_loot_weapons[var_0]) && _func_0107(level.managed_loot_weapons[var_0].weapons) && level.managed_loot_weapons[var_0].weapons.size > 0) {
    var_6 = level.managed_loot_weapons[var_0].weapons[0];
    level.managed_loot_weapons[var_0].weapons = scripts\engine\utility::array_remove(level.managed_loot_weapons[var_0].weapons, var_6);
    var_7 = var_6.current_attachments;
    var_8 = scripts\cp\utility::_id_6CE3(var_6.weapon_name);
    var_9 = scripts\cp\cp_weapon::_id_663A(var_6.pap_level + 1, var_8, "");
    var_10 = scripts\cp\cp_weapon::buildweapon(var_6.weapon_name, var_7, var_9, undefined, undefined, undefined, undefined, undefined, undefined, var_6.pap_level);
    var_5 = _id_092E::_id_E24D(var_10, var_2, var_3, var_4, var_6.pap_level);
    var_5.current_attachments = var_6.current_attachments;
    _id_092E::_id_4744(var_6);
    add_managed_weapon_for_category(var_0, var_1, var_2, var_3, var_4);
  }

  if(!isDefined(var_5)) {
    var_5 = spawn_loot_weapon(var_1, var_2, var_3, var_4);
  }

  return var_5;
}

spawn_loot_weapon(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_pap_from_item_name(var_0);
  var_6 = strip_pap_level_from_item_name(var_0);
  var_7 = scripts\cp\cp_weapon::get_num_random_attachments_by_weapon_level(var_5);
  var_8 = scripts\cp\utility::_id_2D08(var_6, var_7, undefined);
  var_9 = scripts\cp\cp_weapon::_id_663A(var_5 + 1, var_6, "");
  var_10 = scripts\cp\cp_weapon::buildweapon(var_6, var_8, var_9, undefined, undefined, undefined, undefined, undefined, undefined, var_5);
  var_11 = _id_092E::_id_E24D(var_10, var_1, var_2, var_3, var_5, 0, var_4);
  var_11.current_attachments = var_8;
  return var_11;
}

get_pap_from_item_name(var_0) {
  var_1 = 0;
  var_2 = strtok(var_0, "_");

  if(var_2.size >= 6) {
    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(var_2[var_3] == "lvl") {
        if(var_3 + 1 < var_2.size) {
          var_1 = int(var_2[var_3 + 1]);
          break;
        }
      }
    }
  }

  return var_1;
}

strip_pap_level_from_item_name(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = "";

  if(scripts\engine\utility::array_contains(var_1, "lvl")) {
    var_3 = scripts\engine\utility::_id_1BAB(var_1, "lvl");

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      if(var_4 != var_3 && var_4 != var_3 + 1) {
        var_2 = scripts\engine\utility::ter_op(scripts\cp\utility::_id_85B5(var_2), var_1[var_4], var_2 + "_" + var_1[var_4]);
      }
    }
  } else
    var_2 = var_0;

  return var_2;
}

_id_6308(var_0, var_1) {
  var_2 = level._id_125E[var_0];

  if(!isDefined(var_2)) {
    return undefined;
  }

  return get_highest_round_loot_table(var_2, var_1);
}

get_highest_round_loot_table(var_0, var_1) {
  var_2 = var_0[var_1];

  if(!isDefined(var_2)) {
    var_3 = -1;

    foreach(var_6, var_5 in var_0) {
      if(var_6 > var_3 && var_6 < var_1) {
        var_3 = var_6;
        var_2 = var_5;
      }
    }
  }

  if(!isDefined(var_2)) {
    return undefined;
  }

  return level._id_9860[var_2];
}

_id_D040(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = [];
  var_7 = 0;

  foreach(var_11, var_9 in var_0) {
    var_10 = var_9._id_9EAE;

    if(!_id_092E::check_item_can_drop(var_11)) {
      continue;
    }
    if(var_10 < 0) {
      var_5 = scripts\engine\utility::array_combine(var_5, _id_6532(var_11, var_9._id_E109));
      continue;
    }

    if(var_10 != 0) {
      if(var_9._id_9EAE != var_9._id_9C43) {
        var_10 = randomintrange(var_9._id_9EAE, var_9._id_9C43 + 1);
      }

      if(isDefined(var_3) && issubstr(var_11, "zm_loot_weapon_drops")) {
        var_10 = int(var_10 * var_3);
      }

      if(isDefined(var_4) && issubstr(var_11, "s4_pi_raygun_mp")) {
        var_10 = int(var_10 * var_4);
      }

      var_6[var_11] = var_10;
      var_7 = var_7 + var_10;
    }
  }

  if(var_6.size > 0) {
    if(isDefined(var_6["cploot_ammo"]) && isDefined(var_1) && var_1 != 0) {
      var_12 = var_6["cploot_ammo"] / var_7;
      var_13 = var_12 + var_1;

      if(var_13 < 1) {
        var_14 = int(_func_0438((var_6["cploot_ammo"] - var_13 * var_7) / (var_13 - 1)));
        var_6["cploot_ammo"] = var_6["cploot_ammo"] + var_14;
        var_7 = var_7 + var_14;
      } else {
        var_5 = scripts\engine\utility::array_combine(var_5, _id_6532("cploot_ammo", 1));
        return var_5;
      }
    }

    var_2 = scripts\cp\utility::_id_459B(var_2, 1);

    for(var_15 = 0; var_15 < var_2; var_15++) {
      var_16 = randomint(var_7);

      foreach(var_11, var_10 in var_6) {
        if(var_16 < var_10) {
          var_5 = scripts\engine\utility::array_combine(var_5, _id_6532(var_11, var_0[var_11]._id_E109));
          break;
        }

        var_16 = var_16 - var_10;
      }
    }
  }

  return var_5;
}

_id_6532(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = level._id_9860[var_0];

    if(isDefined(var_4)) {
      var_2 = scripts\engine\utility::array_combine(var_2, _id_D040(var_4));
      continue;
    }

    if(_id_092E::check_item_can_drop(var_0)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_0);
    }
  }

  return var_2;
}

_id_AA4A(var_0) {
  _id_125D(self.zm_ai_category, self.origin, self.angles, var_0._id_50FF);
}

on_ai_spawned() {
  add_ai_weapon_loot_source(self);
}

_id_6531(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getdvarint("#x3b45c64e525a8bc4", 0);
  var_7 = 0;
  var_8 = 0;
  var_9 = scripts\cp\utility::_id_459B(var_2[1], 0);
  var_10 = int(var_0 / 13);
  var_11 = var_0 - var_10 * 13;
  var_12 = var_9 + (var_11 * 27.6923 + var_10 * 10.0) + randomfloatrange(-5.0, 5.0);
  var_13 = 50.0 + var_10 * 40.0 + randomfloatrange(-5.0, 5.0) - -18.0;

  if(isDefined(var_4)) {
    if(var_0 % 2 == 0) {
      var_4 = var_4 * -1;
    }

    var_12 = var_9 + var_4 * var_0;
  }

  if(isDefined(var_5)) {
    var_13 = var_5;
  }

  var_14 = (0.0, var_12, 0.0);
  var_15 = anglesToForward(var_14);
  var_16 = var_1 + var_15 * var_13;

  if(1) {
    var_17 = _func_0425(var_16, 500, 500);

    if(isDefined(var_3)) {
      var_17[var_17.size] = var_3;
    }

    var_18 = var_1 + (0, 0, 20);
    var_19 = var_16 + (0, 0, 20);
    var_20 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0, 0, 1);
    var_21 = scripts\engine\trace::ray_trace(var_18, var_19, var_17, var_20);

    if(var_21["fraction"] < 1.0) {
      var_16 = var_21["position"];
    } else {
      var_16 = var_19;
    }

    var_16 = var_16 + var_15 * -18.0;
    var_18 = var_16;
    var_19 = var_16 + (0, 0, 60);
    var_21 = scripts\engine\trace::ray_trace(var_18, var_19, var_17, var_20);

    if(var_21["fraction"] < 1.0) {
      var_16 = var_21["position"] + (0, 0, -6);
    } else {
      var_16 = var_19;
    }

    var_18 = var_16;
    var_22 = -1 * getdvarfloat("#x3e197f242f560b6aa", 2000.0);
    var_19 = var_16 + (0.0, 0.0, var_22);
    var_21 = scripts\engine\trace::ray_trace(var_18, var_19, var_17, var_20);

    if(var_21["fraction"] < 1.0) {
      var_16 = var_21["position"] + (0, 0, 16);
    } else {
      var_16 = (0, 0, 0);
      var_7 = 1;
    }
  } else
    var_16 = var_16 + (0, 0, 16);

  if(1 && !var_7) {
    var_8 = _func_03EB(var_1 + (0, 0, 40), var_16);
  }

  return [var_16, var_14, var_8];
}

activate_loot_cache(var_0, var_1, var_2, var_3) {
  var_4 = level.cache_drop_table_names[var_1];

  if(!isDefined(var_4)) {
    return undefined;
  }

  if(isDefined(var_0.override_round_reward)) {
    var_5 = get_highest_round_loot_table(var_4, var_0.override_round_reward);
  } else {
    var_5 = get_highest_round_loot_table(var_4, scripts\cp\utility::_id_6871());
  }

  if(!isDefined(var_5)) {
    return;
  }
  select_and_spawn_items_from_table(var_5, var_0.origin, var_0.angles, var_2, var_3, 20, var_0);
}

activate_loot_chest(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");

  if(isDefined(var_0.markerlabel) && isDefined(var_0.instanceindex)) {
    _id_0987::remove_instanced_objective_marker(var_0.markerlabel, var_0.instanceindex);
    var_0.markerlabel = undefined;
    var_0.instanceindex = undefined;
    waitframe();
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.objectiveiconlocation)) {
    var_0.objectiveiconlocation delete();
  }

  var_0 setscriptablepartstate("zm_loot_chest", "opened");
  var_0 setscriptablepartstate("fx", "opened");
  activate_loot_cache(var_0, "zm_loot_chest", var_3, "chest");
  var_3 _id_0752::_id_7003("essence_chest");
  _id_070F::createopenchestevent(var_3);
}

activate_loot_crystal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isPlayer(var_2) || !isDefined(var_0) || !var_0 _meth_8679("zm_loot_crystal") || var_0 _meth_8575("zm_loot_crystal", 1) == "dead") {
    return;
  }
  var_0 setscriptablepartstate("zm_loot_crystal", "dead");
  var_0 setscriptablepartstate("fx", "destroyed");

  if(isDefined(var_0.markerlabel) && isDefined(var_0.instanceindex)) {
    _id_0987::remove_instanced_objective_marker(var_0.markerlabel, var_0.instanceindex);
    var_0.markerlabel = undefined;
    var_0.instanceindex = undefined;
    waitframe();
  }

  if(isDefined(var_0.objectiveiconlocation)) {
    var_0.objectiveiconlocation delete();
  }

  waitframe();

  if(isDefined(var_0) && isDefined(var_2)) {
    activate_loot_cache(var_0, "s4_zm_loot_crystal", var_2, "crystal");
    var_2 _id_0752::_id_7003("essence_crystal");
    _id_070F::createdestroycrystalevent(var_2);
  }
}

add_loot_cache_weapon_source(var_0) {
  if(!isDefined(level.cache_type_to_name_map[var_0.type])) {
    return;
  }
  var_1 = level.cache_type_to_name_map[var_0.type];
  var_2 = level.cache_drop_table_names[var_1];

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = get_highest_round_loot_table(var_2, scripts\cp\utility::_id_6871());

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = _id_D040(var_3, undefined, 5);
  add_potential_weapon_source(var_0.type, var_4, var_0);
}

add_ai_weapon_loot_source(var_0) {
  var_1 = _id_6308(var_0.zm_ai_category, scripts\cp\utility::_id_6871());

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = _id_D040(var_1, undefined, 5);
  add_potential_weapon_source(var_0.zm_ai_category, var_2, var_0);
}

add_potential_weapon_source(var_0, var_1, var_2) {
  if(var_1.size == 0) {
    return;
  }
  init_category(var_0);
  level.managed_loot_weapons[var_0].source_count++;

  foreach(var_9, var_4 in var_1) {
    if(_id_0777::_id_8720(var_4)) {
      [var_6, var_7, var_8] = _id_6531(0, var_2.origin, var_2.angles);
      add_managed_weapon_for_category(var_0, var_4, var_6, var_7, var_8);
    }
  }
}

remove_loot_cache_weapon_source(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.type)) {
    var_1 = get_category_from_cache_type(var_0.type);
  }

  if(isDefined(var_1)) {
    remove_potential_weapon_source(var_1);
  }
}

get_category_from_cache_type(var_0) {
  foreach(var_3, var_2 in level.cache_type_to_name_map) {
    if(var_2 == var_0) {
      return var_3;
    }
  }

  return undefined;
}

remove_potential_weapon_source(var_0) {
  if(isDefined(level.managed_loot_weapons[var_0])) {
    level.managed_loot_weapons[var_0].source_count--;
  }
}

cleanup_empty_potential_weapon_category(var_0) {
  if(isDefined(level.managed_loot_weapons[var_0]) && level.managed_loot_weapons[var_0].source_count <= 0) {
    level thread cleanup_managed_loot_weapons_for_category(var_0);
  }
}

init_category(var_0) {
  if(!isDefined(level.managed_loot_weapons[var_0])) {
    level.managed_loot_weapons[var_0] = spawnStruct();
    level.managed_loot_weapons[var_0].source_count = 0;
    level.managed_loot_weapons[var_0].weapons = [];
  }
}

add_managed_weapon_for_category(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.managed_loot_weapons[var_0]) && _func_0107(level.managed_loot_weapons[var_0].weapons)) {
    while(istrue(level.managed_loot_weapons[var_0].is_cleaning_up)) {
      wait 0.2;
    }

    level.managed_loot_weapons[var_0].is_adding_weapon = 1;
    var_5 = min(level.managed_loot_weapons[var_0].source_count, 3);
    var_6 = max(0.5 * level.managed_loot_weapons[var_0].source_count, var_5);

    if(level.managed_loot_weapons[var_0].weapons.size < var_6) {
      var_7 = spawn_loot_weapon(var_1, var_2, var_3, var_4, 1);
      var_7 setscriptablepartstate(var_7.type, "hidden");
      level.managed_loot_weapons[var_0].weapons = scripts\engine\utility::array_add(level.managed_loot_weapons[var_0].weapons, var_7);
    }

    level.managed_loot_weapons[var_0].is_adding_weapon = undefined;
  }
}

cleanup_managed_loot_weapons() {
  foreach(var_2, var_1 in level.managed_loot_weapons) {
    thread cleanup_managed_loot_weapons_for_category(var_2);
  }
}

cleanup_managed_loot_weapons_for_category(var_0) {
  level endon("game_ended");
  waitframe();

  if(isDefined(level.managed_loot_weapons[var_0])) {
    while(istrue(level.managed_loot_weapons[var_0].is_adding_weapon)) {
      wait 0.2;
    }

    level.managed_loot_weapons[var_0].is_cleaning_up = 1;
    level.managed_loot_weapons[var_0].source_count = 0;

    foreach(var_2 in level.managed_loot_weapons[var_0].weapons) {
      if(!_func_0458(var_2)) {
        _id_092E::_id_4744(var_2);
      }
    }

    level.managed_loot_weapons[var_0].weapons = [];
    level.managed_loot_weapons[var_0].is_cleaning_up = undefined;
  }
}