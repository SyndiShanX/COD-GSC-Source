/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1562.gsc
**************************************/

loot_preload() {
  for(var_0 = 0; var_0 <= 20; var_0++) {
    var_1 = get_loot_ref_by_index(var_0);

    if(isDefined(var_1) && get_loot_type(var_1) == "weapon") {
      maps/_so_survival_code::precache_loadout_item(var_1);
    }
  }

  for(var_0 = 100; var_0 <= 199; var_0++) {
    var_2 = get_loot_version_by_index(var_0);

    if(isDefined(var_2)) {
      maps/_so_survival_code::precache_loadout_item(var_2);
    }
  }
}

loot_postload() {}

loot_init() {
  loot_populate(0, 20, 100, 199);
}

loot_populate(var_0, var_1, var_2, var_3) {
  level.loot_version_array = [];

  for(var_4 = var_2; var_4 <= var_3; var_4++) {
    var_5 = get_loot_version_by_index(var_4);

    if(isDefined(var_5) && var_5 != "") {
      level.loot_version_array[level.loot_version_array.size] = var_5;
    }
  }

  level.loot_info_array = [];

  for(var_4 = var_0; var_4 <= var_1; var_4++) {
    var_6 = get_loot_ref_by_index(var_4);

    if(!isDefined(var_6) || var_6 == "") {
      continue;
    }
    var_7 = get_loot_type(var_6);

    if(!isDefined(level.loot_info_array[var_7])) {
      level.loot_info_array[var_7] = [];
    }
    var_8 = spawnStruct();
    var_8.index = var_4;
    var_8.ref = var_6;
    var_8.type = var_7;
    var_8.name = get_loot_name(var_6);
    var_8.desc = get_loot_desc(var_6);
    var_8.chance = get_loot_chance(var_6);
    var_8.wave_unlock = get_loot_wave_unlock(var_6);
    var_8.wave_lock = get_loot_wave_lock(var_6);
    var_8.wave_dropped = -999;
    var_8.rank = get_loot_rank(var_6);
    var_8.versions = get_loot_versions(var_6);
    level.loot_info_array[var_7][var_6] = var_8;
  }
}

loot_roll(var_0) {
  if(!isDefined(level.loot_info_array) || !isDefined(level.loot_info_array["weapon"])) {
    return 0;
  }
  var_1 = [];

  foreach(var_3 in level.loot_info_array["weapon"]) {
    if(level.current_wave >= var_3.wave_unlock && level.current_wave < var_3.wave_lock && level.current_wave - var_3.wave_dropped >= 2 && maps/_so_survival_code::highest_player_rank() >= var_3.rank) {
      var_1[var_1.size] = var_3;
    }
  }

  if(!var_1.size) {
    return 0;
  }
  var_1 = maps/_utility_joec::exchange_sort_by_handler(var_1, ::loot_roll_compare_type_wave_dropped);
  var_5 = undefined;

  foreach(var_3 in var_1) {
    var_7 = common_scripts\utility::ter_op(isDefined(var_0), var_0, var_3.chance);

    if(var_7 > randomfloatrange(0.0, 1.0)) {
      var_5 = var_3.versions[randomint(var_3.versions.size)];
      var_3.wave_dropped = level.current_wave;
      break;
    }
  }

  if(isDefined(var_5)) {
    var_9 = var_5;
    var_10 = getweaponmodel(var_9);
    self.dropweapon = 0;
    thread loot_drop_on_death("weapon_" + var_9, var_9, "weapon", var_10, "tag_stowed_back");
    return 1;
  }

  return 0;
}

loot_roll_compare_type_wave_dropped() {
  var_0 = common_scripts\utility::ter_op(isDefined(self) && isDefined(self.wave_dropped), self.wave_dropped, -999);
  return var_0;
}

loot_drop_on_death(var_0, var_1, var_2, var_3, var_4) {
  level endon("special_op_terminated");
  var_5 = spawn("script_model", self gettagorigin(var_4));
  var_5 setModel(var_3);
  var_5 linkTo(self, var_4, (0, 0, 0), (0, 0, 0));
  common_scripts\utility::waittill_any("death", "long_death");

  if(!isDefined(self)) {
    return;
  }
  var_6 = spawn(var_0, self gettagorigin(var_4));

  if(isDefined(var_2) && var_2 == "weapon") {
    var_7 = int(max(1, 0.4 * weaponclipsize(var_1)));
    var_8 = int(max(1, 0.5 * weaponmaxammo(var_1)));
    var_6 itemweaponsetammo(var_7, var_8);
    var_9 = weaponaltweaponname(var_1);

    if(var_9 != "none") {
      var_10 = int(max(1, 0.5 * weaponclipsize(var_9)));
      var_11 = int(max(1, 0.5 * weaponmaxammo(var_9)));
      var_6 itemweaponsetammo(var_10, var_11, var_10, 1);
    }
  }

  var_5 unlink();
  wait 0.05;
  var_5 delete();
}

loot_item_exist(var_0) {
  return isDefined(level.loot_info_array) && isDefined(level.loot_info_array[var_0]);
}

get_loot_ref_by_index(var_0) {
  return get_ref_by_index(var_0);
}

get_ref_by_index(var_0) {
  return tablelookup("sp/survival_loot.csv", 0, var_0, 1);
}

get_loot_type(var_0) {
  if(loot_item_exist(var_0)) {
    return level.loot_info_array[var_0].type;
  }
  return tablelookup("sp/survival_loot.csv", 1, var_0, 2);
}

get_loot_name(var_0) {
  if(loot_item_exist(var_0)) {
    return level.loot_info_array[var_0].name;
  }
  return tablelookup("sp/survival_loot.csv", 1, var_0, 3);
}

get_loot_desc(var_0) {
  if(loot_item_exist(var_0)) {
    return level.loot_info_array[var_0].desc;
  }
  return tablelookup("sp/survival_loot.csv", 1, var_0, 4);
}

get_loot_chance(var_0) {
  if(loot_item_exist(var_0)) {
    return level.loot_info_array[var_0].chance;
  }
  return float(tablelookup("sp/survival_loot.csv", 1, var_0, 5));
}

get_loot_wave_unlock(var_0) {
  if(loot_item_exist(var_0)) {
    return level.loot_info_array[var_0].wave_unlock;
  }
  return int(tablelookup("sp/survival_loot.csv", 1, var_0, 6));
}

get_loot_wave_lock(var_0) {
  if(loot_item_exist(var_0)) {
    return level.loot_info_array[var_0].wave_lock;
  }
  return int(tablelookup("sp/survival_loot.csv", 1, var_0, 7));
}

get_loot_rank(var_0) {
  if(loot_item_exist(var_0)) {
    return level.loot_info_array[var_0].rank;
  }
  return int(tablelookup("sp/survival_loot.csv", 1, var_0, 8));
}

get_loot_version_by_index(var_0) {
  return get_ref_by_index(var_0);
}

get_loot_versions(var_0) {
  if(loot_item_exist(var_0)) {
    return level.loot_info_array[var_0].versions;
  }
  var_1 = "joe";
  var_2 = [];
  var_3 = var_0;

  if(get_loot_type(var_0) == "weapon") {
    var_3 = getsubstr(var_0, 0, var_0.size - 3);
  }
  foreach(var_5 in level.loot_version_array) {
    if(issubstr(var_5, var_3)) {
      var_2[var_2.size] = var_5;
    }
  }

  if(!var_2.size) {
    var_2[var_2.size] = var_0;
  }
  return var_2;
}