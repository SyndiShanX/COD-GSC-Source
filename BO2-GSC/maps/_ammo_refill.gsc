/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ammo_refill.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  a_ammo_crates = getentarray("trigger_ammo_refill", "targetname");
  array_thread(a_ammo_crates, ::_ammo_refill_think_old);
  thread place_player_loadout_old();
  a_ammo_crates = getentarray("sys_ammo_cache", "targetname");
  array_thread(a_ammo_crates, ::_setup_ammo_cache);
  a_weapon_crates = getentarray("sys_weapon_cache", "targetname");
  array_thread(a_weapon_crates, ::_setup_weapon_cache);
}

_ammo_refill_think_old() {
  self sethintstring(&"SCRIPT_AMMO_REFILL");
  self setcursorhint("HINT_NOICON");

  while(true) {
    self waittill("trigger", e_player);
    e_player disableweapons();
    e_player playsound("fly_ammo_crate_refill");
    wait 2;
    a_str_weapons = e_player getweaponslist();

    foreach(str_weapon in a_str_weapons) {
      if(!_is_banned_refill_weapon(str_weapon)) {
        e_player givemaxammo(str_weapon);
        e_player setweaponammoclip(str_weapon, weaponclipsize(str_weapon));
      }
    }

    e_player enableweapons();
  }
}

place_player_loadout_old() {
  str_primary_weapon = getloadoutweapon("primary");
  str_secondary_weapon = getloadoutweapon("secondary");
  primary_weapon_pos_array = getentarray("ammo_refill_primary_weapon", "targetname");

  foreach(primary_pos in primary_weapon_pos_array) {
    if(!issubstr(str_primary_weapon, "null")) {
      m_weapon_script_model = spawn("weapon_" + str_primary_weapon, primary_pos.origin);
      m_weapon_script_model.angles = primary_pos.angles;
      level thread place_player_loadout_old_camo(m_weapon_script_model, "primarycamo");
    }
  }

  secondary_weapon_pos_array = getentarray("ammo_refill_secondary_weapon", "targetname");

  foreach(secondary_pos in secondary_weapon_pos_array) {
    if(!issubstr(str_primary_weapon, "null")) {
      m_weapon_script_model = spawn("weapon_" + str_secondary_weapon, secondary_pos.origin);
      m_weapon_script_model.angles = secondary_pos.angles;
      level thread place_player_loadout_old_camo(m_weapon_script_model, "secondarycamo");
    }
  }
}

place_player_loadout_old_camo(m_weapon_script_model, camo_type) {
  wait_for_first_player();

  if(camo_type == "primarycamo") {
    primarycamoindex = getloadoutitemindex("primarycamo");
    primaryweaponoptions = get_players()[0] calcweaponoptions(primarycamoindex);
    m_weapon_script_model itemweaponsetoptions(primaryweaponoptions);
  } else if(camo_type == "secondarycamo") {
    secondarycamoindex = getloadoutitemindex("secondarycamo");
    secondaryweaponoptions = get_players()[0] calcweaponoptions(secondarycamoindex);
    m_weapon_script_model itemweaponsetoptions(secondaryweaponoptions);
  }
}

_setup_ammo_cache() {
  waittill_asset_loaded("xmodel", self.model);
  self ignorecheapentityflag(1);
  self thread _ammo_refill_think();

  if(self.model != "p6_ammo_resupply_future_01" && self.model != "p6_ammo_resupply_80s_final_01") {
    self thread _place_player_loadout();
    self thread _check_extra_slots();
  }

  if(isDefined(level._ammo_refill_think_alt))
    self thread[[level._ammo_refill_think_alt]]();
}

_setup_weapon_cache() {
  waittill_asset_loaded("xmodel", self.model);
  self ignorecheapentityflag(1);
  self thread _place_player_loadout();
  self thread _check_extra_slots();
}

_ammo_refill_think() {
  self endon("disable_ammo_cache");
  t_ammo_cache = self _get_closest_ammo_trigger();
  t_ammo_cache sethintstring(&"SCRIPT_AMMO_REFILL");
  t_ammo_cache setcursorhint("HINT_NOICON");

  while(true) {
    t_ammo_cache waittill("trigger", e_player);
    e_player disableweapons();
    e_player playsound("fly_ammo_crate_refill");
    wait 2;
    a_str_weapons = e_player getweaponslist();

    foreach(str_weapon in a_str_weapons) {
      if(!_is_banned_refill_weapon(str_weapon)) {
        e_player givemaxammo(str_weapon);
        e_player setweaponammoclip(str_weapon, weaponclipsize(str_weapon));
      }
    }

    e_player enableweapons();
    e_player notify("ammo_refilled");
  }
}

_get_closest_ammo_trigger() {
  a_ammo_cache = getentarray("trigger_ammo_cache", "targetname");
  t_ammo_cache = getclosest(self.origin, a_ammo_cache);
  return t_ammo_cache;
}

_place_player_loadout() {
  str_primary_weapon = getloadoutweapon("primary");
  str_secondary_weapon = getloadoutweapon("secondary");
  v_basic_offset = (-5, 0, 15);
  v_full_offset = (-10, 0, 15);
  v_model_offset = vectorscale((0, 0, 1), 15.0);
  n_offset_multiplier = 0;

  switch (self.model) {
    case "p6_weapon_resupply_80s_01":
    case "p6_weapon_resupply_80s_02":
      n_offset_multiplier = -4;
      break;
  }

  if(!issubstr(str_primary_weapon, "+"))
    str_primary_weapon_base = str_primary_weapon;
  else
    str_primary_weapon_base = strtok(str_primary_weapon, "+")[0];

  if(!issubstr(str_primary_weapon_base, "null") && isassetloaded("weapon", str_primary_weapon_base)) {
    primary_weapon_pos = self gettagorigin("loadOut_B");
    tmp_offset = anglestoright(self gettagangles("loadOut_B")) * n_offset_multiplier;
    m_weapon_script_model = spawn("weapon_" + str_primary_weapon, primary_weapon_pos + (tmp_offset + v_model_offset), 8);
    m_weapon_script_model.angles = self gettagangles("loadOut_B") + vectorscale((0, -1, 0), 90.0);
    level thread place_player_loadout_camo(m_weapon_script_model, "primarycamo");
  }

  switch (self.model) {
    case "p6_weapon_resupply_80s_01":
    case "p6_weapon_resupply_80s_02":
      n_offset_multiplier = -7;
      break;
    case "p6_weapon_resupply_future_01":
    case "p6_weapon_resupply_future_02":
      n_offset_multiplier = -3;
      break;
    default:
      n_offset_multiplier = -4;
      break;
  }

  if(!issubstr(str_secondary_weapon, "+"))
    str_secondary_weapon_base = str_secondary_weapon;
  else
    str_secondary_weapon_base = strtok(str_secondary_weapon, "+")[0];

  if(!issubstr(str_secondary_weapon_base, "null") && isassetloaded("weapon", str_secondary_weapon_base)) {
    secondary_weapon_pos = self gettagorigin("loadOut_A");
    tmp_offset = anglestoright(self gettagangles("loadOut_A")) * n_offset_multiplier;
    m_weapon_script_model = spawn("weapon_" + str_secondary_weapon, secondary_weapon_pos + (tmp_offset + v_model_offset), 8);
    m_weapon_script_model.angles = self gettagangles("loadOut_A") + vectorscale((0, -1, 0), 90.0);
    level thread place_player_loadout_camo(m_weapon_script_model, "secondarycamo");
  }
}

place_player_loadout_camo(m_weapon_script_model, camo_type) {
  wait_for_first_player();

  if(camo_type == "primarycamo") {
    primarycamoindex = getloadoutitemindex("primarycamo");
    primaryweaponoptions = get_players()[0] calcweaponoptions(primarycamoindex);
    m_weapon_script_model itemweaponsetoptions(primaryweaponoptions);
  } else if(camo_type == "secondarycamo") {
    secondarycamoindex = getloadoutitemindex("secondarycamo");
    secondaryweaponoptions = get_players()[0] calcweaponoptions(secondarycamoindex);
    m_weapon_script_model itemweaponsetoptions(secondaryweaponoptions);
  }
}

_check_extra_slots() {
  if(isDefined(self.ac_slot1)) {
    auxilary_weapon_pos = self gettagorigin("auxilary_A");
    assert(isDefined(auxilary_weapon_pos), "Please use the ammo_refill_crate_future_full prefab to use this slot");

    switch (self.model) {
      default:
        tmp_offset = anglestoright(self gettagangles("auxilary_A")) * 5;
        break;
    }

    m_weapon_script_model = spawn("weapon_" + self.ac_slot1, auxilary_weapon_pos + (tmp_offset + vectorscale((0, 0, 1), 10.0)), 8);
    m_weapon_script_model.angles = self gettagangles("auxilary_A") + vectorscale((0, -1, 0), 90.0);
    m_weapon_script_model itemweaponsetammo(9999, 9999);
  }

  if(isDefined(self.ac_slot2)) {
    auxilary_weapon_pos = self gettagorigin("secondary_A");
    assert(isDefined(auxilary_weapon_pos), "Please use the ammo_refill_crate_future_full prefab to use this slot");
    tmp_offset = anglestoforward(self gettagangles("secondary_A")) * 10;
    m_weapon_script_model = spawn("weapon_" + self.ac_slot2, auxilary_weapon_pos + (tmp_offset + vectorscale((0, 0, 1), 10.0)), 8);
    m_weapon_script_model.angles = self gettagangles("secondary_A");
    m_weapon_script_model itemweaponsetammo(9999, 9999);
  }
}

_is_banned_refill_weapon(str_weapon) {
  return false;
}

_debug_tags() {
  tag_array = [];
  tag_array[tag_array.size] = "ammo_A";
  tag_array[tag_array.size] = "ammo_B";
  tag_array[tag_array.size] = "auxilary_A";
  tag_array[tag_array.size] = "auxilary_B";
  tag_array[tag_array.size] = "grenade";
  tag_array[tag_array.size] = "loadOut_A";
  tag_array[tag_array.size] = "loadOut_B";
  tag_array[tag_array.size] = "secondary_A";

  foreach(tag in tag_array)
  self thread _loop_text(tag);
}

_loop_text(tag) {
  while(true) {
    if(isDefined(self gettagorigin(tag)))
      print3d(self gettagorigin(tag), tag, (1, 1, 1), 1, 0.15);

    wait 0.05;
  }

}

disable_ammo_cache(str_ammo_cache_id) {
  a_ammo_cache = getentarray(str_ammo_cache_id, "script_noteworthy");
  assert(isDefined(a_ammo_cache), "There is no ammo cache with the script_noteworthy '" + str_ammo_cache_id + "'. Please double check the names used");

  if(a_ammo_cache.size > 1) {
    assertmsg("There is more than one ammo cache with the script_noteworthy '" + str_ammo_cache_id + "'. Please give each a unique name");

  }

  a_ammo_cache[0] notify("disable_ammo_cache");
  t_ammo_cache = a_ammo_cache[0] _get_closest_ammo_trigger();
  t_ammo_cache trigger_off();
}

activate_extra_slot(n_slot_number, str_weapon) {
  if(n_slot_number < 1 || n_slot_number > 2) {
    assertmsg("Only values of 1 or 2 are valid slot positions");

  }

  assert(isDefined(str_weapon), "Weapon is not defined");

  if(n_slot_number == 1) {
    auxilary_weapon_pos = self gettagorigin("auxilary_A");
    assert(isDefined(auxilary_weapon_pos), "Please use the ammo_refill_crate_future_full prefab to use this slot");
    tmp_offset = anglestoright(self gettagangles("auxilary_A")) * 5;
    m_weapon_script_model = spawn("weapon_" + str_weapon, auxilary_weapon_pos + (tmp_offset + vectorscale((0, 0, 1), 10.0)), 8);
    m_weapon_script_model.angles = self gettagangles("auxilary_A") + vectorscale((0, -1, 0), 90.0);
    m_weapon_script_model itemweaponsetammo(9999, 9999);
  }

  if(n_slot_number == 2) {
    auxilary_weapon_pos = self gettagorigin("secondary_A");
    assert(isDefined(auxilary_weapon_pos), "Please use the ammo_refill_crate_*_full prefab to use this slot");
    tmp_offset = anglestoforward(self gettagangles("secondary_A")) * 7;
    m_weapon_script_model = spawn("weapon_" + str_weapon, auxilary_weapon_pos + (tmp_offset + vectorscale((0, 0, 1), 10.0)), 8);
    m_weapon_script_model.angles = self gettagangles("secondary_A");
    m_weapon_script_model itemweaponsetammo(9999, 9999);
  }
}

cleanup_cache() {
  if(issubstr(self.model, "p6_weapon_")) {
    a_weapons_list = [];
    a_item_list = getitemarray();

    foreach(item in a_item_list) {
      if(issubstr(item.classname, "weapon_"))
        a_weapons_list[a_weapons_list.size] = item;
    }

    n_weapon_counter = 2;

    if(isDefined(self.ac_slot1))
      n_weapon_counter++;

    if(isDefined(self.ac_slot2))
      n_weapon_counter++;

    for(x = 0; x < n_weapon_counter; x++) {
      e_closest_weapon = getclosest(self.origin, a_weapons_list, 50);

      if(isDefined(e_closest_weapon))
        e_closest_weapon delete();

      a_weapons_list = remove_undefined_from_array(a_weapons_list);
    }

    self delete();
  } else {
    self notify("disable_ammo_cache");
    t_ammo_trigger = _get_closest_ammo_trigger();

    if(isDefined(t_ammo_trigger))
      t_ammo_trigger delete();

    self delete();
  }
}