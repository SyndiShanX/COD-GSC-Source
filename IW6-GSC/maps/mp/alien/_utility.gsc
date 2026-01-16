/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_utility.gsc
**************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

HEALTH_PACK_MODEL = "paris_chase_pharmacie_sign_02";

player_healthbar_update() {
  self endon("death");

  waittillframeend;

  while(true) {
    player_health_ratio = self.health / self.maxhealth;

    SetDvar("alien_player_health", self.health / self.maxhealth);

    while(player_health_ratio == (self.health / self.maxhealth))
      wait 0.1;

  }
}

enable_alien_scripted() {
  self.alien_scripted = true;
  self notify("alien_main_loop_restart");
}

disable_alien_scripted() {
  self.alien_scripted = false;
}

set_alien_emissive(blend_duration, intensity) {
  if(GetDvarInt("scr_useMaxEmissive", 0) == 1) {
    self EmissiveBlend(0.1, 1.0);
    return;
  }

  valid_range = self.maxEmissive - self.defaultEmissive;
  actual_intensity = intensity * valid_range + self.defaultEmissive;
  self EmissiveBlend(blend_duration, actual_intensity);
}

set_alien_emissive_default(blend_duration) {
  if(GetDvarInt("scr_useMaxEmissive", 0) == 1) {
    self EmissiveBlend(0.1, 1.0);
    return;
  }

  assert(isDefined(self.defaultEmissive));
  self EmissiveBlend(blend_duration, self.defaultEmissive);
}

get_players() {
  return level.players;
}

any_player_nearby(origin, dist_sqr) {
  foreach(player in level.players) {
    if(DistanceSquared(player.origin, origin) < dist_sqr) {
      return true;
    }
  }
  return false;
}

min_dist_from_all_locations(ent, location_array, min_dist) {
  min_dist_sqr = min_dist * min_dist;
  foreach(location in location_array) {
    if(Distance2DSquared(ent.origin, location.origin) < min_dist_sqr) {
      return false;
    }
  }

  return true;
}

set_vision_set_player(visionset, transition_time) {
  if(init_vision_set(visionset)) {
    return;
  }
  Assert(isDefined(self));
  Assert(level != self);

  if(!isDefined(transition_time))
    transition_time = 1;
  self VisionSetNakedForPlayer(visionset, transition_time);
}

init_vision_set(visionset) {
  level.lvl_visionset = visionset;

  if(!isDefined(level.vision_cheat_enabled))
    level.vision_cheat_enabled = false;

  return level.vision_cheat_enabled;
}

restore_client_fog(transition_time) {
  if(!isDefined(level.restore_fog_setting)) {
    return;
  }
  ent = level.restore_fog_setting;

  self PlayerSetExpFog(
    ent.startDist,
    ent.halfwayDist,
    ent.red,
    ent.green,
    ent.blue,
    ent.HDRColorIntensity,
    ent.maxOpacity,
    transition_time,
    ent.sunRed,
    ent.sunGreen,
    ent.sunBlue,
    ent.HDRSunColorIntensity,
    ent.sunDir,
    ent.sunBeginFadeAngle,
    ent.sunEndFadeAngle,
    ent.normalFogScale,
    ent.skyFogIntensity,
    ent.skyFogMinAngle,
    ent.skyFogMaxAngle);
}

ent_flag_wait(msg) {
  if(isplayer(self))
    self endon("disconnect");

  AssertEx((!IsSentient(self) && isDefined(self)) || IsAlive(self), "Attempt to check a flag on entity that is not alive or removed");

  while(isDefined(self) && !self.ent_flag[msg])
    self waittill(msg);
}

ent_flag_wait_either(flag1, flag2) {
  if(isplayer(self))
    self endon("disconnect");

  AssertEx((!IsSentient(self) && isDefined(self)) || IsAlive(self), "Attempt to check a flag on entity that is not alive or removed");

  while(isDefined(self)) {
    if(ent_flag(flag1))
      return;
    if(ent_flag(flag2)) {
      return;
    }
    self waittill_either(flag1, flag2);
  }
}

ent_flag_wait_or_timeout(flagname, timer) {
  if(isplayer(self))
    self endon("disconnect");

  AssertEx((!IsSentient(self) && isDefined(self)) || IsAlive(self), "Attempt to check a flag on entity that is not alive or removed");

  start_time = GetTime();
  while(isDefined(self)) {
    if(self.ent_flag[flagname]) {
      break;
    }

    if(GetTime() >= start_time + timer * 1000) {
      break;
    }

    self ent_wait_for_flag_or_time_elapses(flagname, timer);
  }
}

ent_wait_for_flag_or_time_elapses(flagname, timer) {
  self endon(flagname);
  wait(timer);
}

ent_flag_waitopen(msg) {
  AssertEx((!IsSentient(self) && isDefined(self)) || IsAlive(self), "Attempt to check a flag on entity that is not alive or removed");

  while(isDefined(self) && self.ent_flag[msg])
    self waittill(msg);
}

ent_flag_assert(msg) {
  AssertEx(!self ent_flag(msg), "Flag " + msg + " set too soon on entity");
}

ent_flag_waitopen_either(flag1, flag2) {
  AssertEx((!IsSentient(self) && isDefined(self)) || IsAlive(self), "Attempt to check a flag on entity that is not alive or removed");

  while(isDefined(self)) {
    if(!ent_flag(flag1))
      return;
    if(!ent_flag(flag2)) {
      return;
    }
    self waittill_either(flag1, flag2);
  }
}

ent_flag_init(message) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }

  if(isDefined(level.first_frame) && level.first_frame == -1)
    AssertEx(!isDefined(self.ent_flag[message]), "Attempt to reinitialize existing message: " + message + " on entity.");

  self.ent_flag[message] = false;

  self.ent_flags_lock[message] = false;
}

ent_flag_exist(message) {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag[message]))
    return true;
  return false;
}

ent_flag_set(message) {
  AssertEx(isDefined(self), "Attempt to set a flag on entity that is not defined");
  AssertEx(isDefined(self.ent_flag[message]), "Attempt to set a flag before calling flag_init: " + message + " on entity.");
  Assert(self.ent_flag[message] == self.ent_flags_lock[message]);
  self.ent_flags_lock[message] = true;

  self.ent_flag[message] = true;
  self notify(message);
}

ent_flag_clear(message, remove) {
  AssertEx(isDefined(self), "Attempt to clear a flag on entity that is not defined");
  AssertEx(isDefined(self.ent_flag[message]), "Attempt to set a flag before calling flag_init: " + message + " on entity.");
  Assert(self.ent_flag[message] == self.ent_flags_lock[message]);
  self.ent_flags_lock[message] = false;

  if(self.ent_flag[message]) {
    self.ent_flag[message] = false;
    self notify(message);
  }

  if(isDefined(remove) && remove)
    self.ent_flag[message] = undefined;
}

ent_flag(message) {
  AssertEx(isDefined(message), "Tried to check flag but the flag was not defined.");
  AssertEx(isDefined(self.ent_flag[message]), "Tried to check flag " + message + " but the flag was not initialized.");

  return self.ent_flag[message];
}

alien_mode_has(feature_str) {
  feature_str = toLower(feature_str);

  if(!isDefined(level.alien_mode_feature))
    return false;

  if(!isDefined(level.alien_mode_feature[feature_str]))
    return false;

  return level.alien_mode_feature[feature_str];
}

alien_mode_enable(str_1, str_2, str_3, str_4, str_5, str_6, str_7, str_8, str_9, str_10) {
  assertex(isDefined(str_1), "alien_mode_enable() called without parameters!");

  if(!isDefined(level.alien_mode_feature))
    level.alien_mode_feature = [];

  if(!isDefined(level.alien_mode_feature_strings))
    level.alien_mode_feature_strings = ["kill_resource", "nogame", "airdrop", "loot", "wave", "lurker", "collectible", "mist", "pillage", "challenge", "outline", "scenes"];

  if(str_1 == "all") {
    foreach(param in level.alien_mode_feature_strings)
    alien_mode_enable_raw(param);

    return;
  }

  combined_param = [];

  if(isDefined(str_1))
    combined_param[combined_param.size] = toLower(str_1);

  if(isDefined(str_2))
    combined_param[combined_param.size] = toLower(str_2);

  if(isDefined(str_3))
    combined_param[combined_param.size] = toLower(str_3);

  if(isDefined(str_4))
    combined_param[combined_param.size] = toLower(str_4);

  if(isDefined(str_5))
    combined_param[combined_param.size] = toLower(str_5);

  if(isDefined(str_6))
    combined_param[combined_param.size] = toLower(str_6);

  if(isDefined(str_7))
    combined_param[combined_param.size] = toLower(str_7);

  if(isDefined(str_8))
    combined_param[combined_param.size] = toLower(str_8);

  if(isDefined(str_9))
    combined_param[combined_param.size] = toLower(str_9);

  if(isDefined(str_10))
    combined_param[combined_param.size] = toLower(str_10);

  check_feature_dependencies(combined_param);

  foreach(param in combined_param)
  alien_mode_enable_raw(param);
}

check_feature_dependencies(combined_param) {
  foreach(param in combined_param) {
    if(param == "loot" && !array_contains(combined_param, "collectible"))
      assertmsg("Feature [loot] requires [collectible]");

    if(param == "airdrop" && !array_contains(combined_param, "wave"))
      assertmsg("Feature [airdrop] requires feature [wave]");

    if(param == "lurker" && !array_contains(combined_param, "wave"))
      assertmsg("Feature [lurker] requires feature [wave]");

    if(param == "mist" && !array_contains(combined_param, "wave"))
      assertmsg("Feature [mist] requires feature [wave]");
  }
}

alien_mode_enable_raw(feature_str) {
  if(!array_contains(level.alien_mode_feature_strings, feature_str)) {
    supported_mode_strings = "";
    foreach(feature in level.alien_mode_feature_strings)
    supported_mode_strings = supported_mode_strings + feature + " ";

    assertmsg(feature_str + " is not a supported feature. [ " + supported_mode_strings + "]");
  }

  level.alien_mode_feature[feature_str] = true;
}

alien_area_init(area_array) {
  AssertEx(!isDefined(level.world_areas), "alien_area_init() is called multiple times in the same level");

  level.world_areas = [];
  level.area_array = area_array;
  level.current_area_index = 0;

  foreach(area in area_array) {
    area_volume = GetEnt(area, "targetname");
    assert(isDefined(area_volume));

    level.world_areas[area] = area_volume;
  }
}

get_current_area_name() {
  return level.area_array[level.current_area_index];
}

inc_current_area_index() {
  level.current_area_index++;
}

store_weapons_status(weapons_excluded) {
  self.copy_fullweaponlist = self GetWeaponsListAll();
  self.copy_weapon_current = self GetCurrentWeapon();

  foreach(weapon in self.copy_fullweaponlist) {
    self.copy_weapon_ammo_clip[weapon] = self GetWeaponAmmoClip(weapon);
    self.copy_weapon_ammo_stock[weapon] = self GetWeaponAmmoStock(weapon);
  }

  if(isDefined(weapons_excluded)) {
    allowed_fullweaponlist = [];
    foreach(weapon in self.copy_fullweaponlist) {
      skip = false;
      foreach(not_allowed_weapon in weapons_excluded) {
        if(weapon == not_allowed_weapon) {
          skip = true;
          break;
        }
      }

      if(skip) {
        continue;
      }
      allowed_fullweaponlist[allowed_fullweaponlist.size] = weapon;
    }
    self.copy_fullweaponlist = allowed_fullweaponlist;

    foreach(not_allowed_weapon in weapons_excluded) {
      if(self.copy_weapon_current == not_allowed_weapon) {
        self.copy_weapon_current = "none";
        break;
      }
    }
  }
}

restore_weapons_status(inclusion_list) {
  if(!isDefined(self.copy_fullweaponlist) ||
    !isDefined(self.copy_weapon_current) ||
    !isDefined(self.copy_weapon_ammo_clip) ||
    !isDefined(self.copy_weapon_ammo_stock)
  )
    AssertMsg("Call store_weapons_status() before restore_weapons_status()");

  myWeapons = self GetWeaponsListAll();
  foreach(weapon in myWeapons) {
    if(!array_contains(self.copy_fullweaponlist, weapon) && !in_inclusion_list(inclusion_list, weapon)) {
      self TakeWeapon(weapon);
    }
  }

  foreach(weapon in self.copy_fullweaponlist) {
    if(!(self HasWeapon(weapon))) {
      self GiveWeapon(weapon);
    }

    self SetWeaponAmmoClip(weapon, self.copy_weapon_ammo_clip[weapon]);
    self SetWeaponAmmoStock(weapon, self.copy_weapon_ammo_stock[weapon]);
  }

  WeaponToSwitch = self.copy_weapon_current;

  if(!isDefined(weaponToSwitch) || WeaponToSwitch == "none")
    WeaponToSwitch = self.copy_fullweaponlist[0];

  self SwitchToWeapon(WeaponToSwitch);

  self.copy_fullweaponlist = undefined;
  self.copy_weapon_current = undefined;
  self.copy_weapon_ammo_clip = undefined;
  self.copy_weapon_ammo_stock = undefined;
}

in_inclusion_list(inclusion_list, item_name) {
  if(!isDefined(inclusion_list))
    return false;

  return array_contains(inclusion_list, item_name);
}

remove_weapons() {
  weaponlist = self GetWeaponsListPrimaries();

  foreach(weapon in weaponlist) {
    weaponTokens = StrTok(weapon, "_");

    if(weaponTokens[0] == "alt") {
      continue;
    }
    self TakeWeapon(weapon);
  }
}

get_alien_type() {
  AssertEx(isDefined(self.alien_type), "self.alien_type is not defined");

  return self.alien_type;
}

should_explode() {
  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "minion":
      return true;
    default:
      return false;
  }
}

is_normal_upright(normal) {
  UPRIGHT_VECTOR = (0, 0, 1);
  UPRIGHT_DOT = 0.85;
  return (VectorDot(normal, UPRIGHT_VECTOR) > UPRIGHT_DOT);
}

always_play_pain_sound(anime) {
  if(!AnimHasNotetrack(anime, "alien_pain_light") && !AnimHasNoteTrack(anime, "alien_pain_heavy")) {
    self PlaySoundOnMovingEnt("alien_pain_light");
  }

}

register_pain(anim_entry) {
  /# AssertEx( !isDefined( self.pain_registered ) || !self.pain_registered, "Shouldn't be able to register a pain when one already registered!" );
  self.pain_registered = true;
  self thread pain_interval_monitor(anim_entry);
}

pain_interval_monitor(anim_entry) {
  self endon("death");

  alienType = self get_alien_type();
  painInterval = level.alien_types[alienType].attributes["pain_interval"];
  wait painInterval + GetAnimLength(anim_entry);
  self.pain_registered = false;
}

is_pain_available(attacker, sMeansOfDeath) {
  if(isDefined(self.pain_registered) && self.pain_registered)
    return false;

  if(isDefined(self.oriented) && self.oriented)
    return false;

  if(sMeansOfDeath == "MOD_MELEE")
    return true;

  if(isDefined(attacker) && isPlayer(attacker) && attacker has_stun_ammo())
    return true;

  return true;
}

mp_ents_clean_up() {
  wait 0.5;

  heli_start_nodes = getEntArray("heli_start", "targetname");
  foreach(start_node in heli_start_nodes)
  get_linked_nodes_and_delete(start_node);

  heli_loop_nodes = getEntArray("heli_loop_start", "targetname");
  foreach(loop_node in heli_loop_nodes)
  get_linked_nodes_and_delete(loop_node);

  heli_crash_nodes = getEntArray("heli_crash_start", "targetname");
  foreach(crash_node in heli_crash_nodes)
  get_linked_nodes_and_delete(crash_node);
}

get_linked_nodes_and_delete(start_node) {
  cur_node = start_node;

  while(isDefined(cur_node.target)) {
    next_node = getent(cur_node.target, "targetname");
    if(isDefined(next_node)) {
      cur_node delete();
      cur_node = next_node;
    } else {
      break;
    }
  }

  if(isDefined(cur_node))
    cur_node delete();
}

is_holding_deployable() {
  return self.is_holding_deployable;
}

has_special_weapon() {
  return self.has_special_weapon;
}
type_has_head_armor(type) {
  switch (type) {
    case "brute1":
    case "brute2":
    case "brute3":
    case "brute4":
      return true;
    default:
      return false;
  }

  return false;
}

get_closest_living_player() {
  closest_distance_sqr = 1073741824;
  closest_player = undefined;

  foreach(player in level.players) {
    dist_sqr = DistanceSquared(self.origin, player.origin);
    if(IsReallyAlive(player) && dist_sqr < closest_distance_sqr) {
      closest_player = player;
      closest_distance_sqr = dist_sqr;
    }
  }

  return closest_player;
}

should_store_ammo_check(exclude_type, special_ammo_weapon) {
  should_store_ammo = true;
  switch (exclude_type) {
    case "explosive":
      if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[special_ammo_weapon]) && self.special_ammocount[special_ammo_weapon] > 0) {
        self.special_ammocount[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_bulletdamage");
        return false;
      } else if(isDefined(self.special_ammocount_ap) && isDefined(self.special_ammocount_ap[special_ammo_weapon]) && self.special_ammocount_ap[special_ammo_weapon] > 0) {
        self.special_ammocount_ap[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_armorpiercing");
        return false;
      } else if(isDefined(self.special_ammocount_in) && isDefined(self.special_ammocount_in[special_ammo_weapon]) && self.special_ammocount_in[special_ammo_weapon] > 0) {
        self.has_incendiary_ammo = undefined;
        self.special_ammocount_in[special_ammo_weapon] = 0;
        return false;
      } else if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[special_ammo_weapon]) && self.special_ammocount_comb[special_ammo_weapon] > 0) {
        self.special_ammocount_comb[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_explosivebullets");
        self _unsetPerk("specialty_armorpiercing");
        self _unsetPerk("specialty_bulletdamage");
        self.has_incendiary_ammo = undefined;
        return false;
      }
      return true;

    case "ap":
    case "piercing":
      if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[special_ammo_weapon]) && self.special_ammocount[special_ammo_weapon] > 0) {
        self.special_ammocount[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_bulletdamage");
        return false;
      } else if(isDefined(self.special_ammocount_explo) && isDefined(self.special_ammocount_explo[special_ammo_weapon]) && self.special_ammocount_explo[special_ammo_weapon] > 0) {
        self.special_ammocount_explo[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_explosivebullets");
        return false;
      } else if(isDefined(self.special_ammocount_in) && isDefined(self.special_ammocount_in[special_ammo_weapon]) && self.special_ammocount_in[special_ammo_weapon] > 0) {
        self.has_incendiary_ammo = undefined;
        self.special_ammocount_in[special_ammo_weapon] = 0;
        return false;
      } else if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[special_ammo_weapon]) && self.special_ammocount_comb[special_ammo_weapon] > 0) {
        self.special_ammocount_comb[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_explosivebullets");
        self _unsetPerk("specialty_armorpiercing");
        self _unsetPerk("specialty_bulletdamage");
        self.has_incendiary_ammo = undefined;
        return false;
      }
      return true;

    case "stun":
      if(isDefined(self.special_ammocount_explo) && isDefined(self.special_ammocount_explo[special_ammo_weapon]) && self.special_ammocount_explo[special_ammo_weapon] > 0) {
        self.special_ammocount_explo[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_explosivebullets");
        return false;
      } else if(isDefined(self.special_ammocount_ap) && isDefined(self.special_ammocount_ap[special_ammo_weapon]) && self.special_ammocount_ap[special_ammo_weapon] > 0) {
        self.special_ammocount_ap[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_armorpiercing");
        return false;
      } else if(isDefined(self.special_ammocount_in) && isDefined(self.special_ammocount_in[special_ammo_weapon]) && self.special_ammocount_in[special_ammo_weapon] > 0) {
        self.has_incendiary_ammo = undefined;
        self.special_ammocount_in[special_ammo_weapon] = 0;
        return false;
      } else if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[special_ammo_weapon]) && self.special_ammocount_comb[special_ammo_weapon] > 0) {
        self.special_ammocount_comb[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_explosivebullets");
        self _unsetPerk("specialty_armorpiercing");
        self _unsetPerk("specialty_bulletdamage");
        self.has_incendiary_ammo = undefined;
        return false;
      }
      return true;

    case "incendiary":
      if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[special_ammo_weapon]) && self.special_ammocount[special_ammo_weapon] > 0) {
        self.special_ammocount[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_bulletdamage");
        return false;
      } else if(isDefined(self.special_ammocount_ap) && isDefined(self.special_ammocount_ap[special_ammo_weapon]) && self.special_ammocount_ap[special_ammo_weapon] > 0) {
        self.special_ammocount_ap[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_armorpiercing");
        return false;
      } else if(isDefined(self.special_ammocount_explo) && isDefined(self.special_ammocount_explo[special_ammo_weapon]) && self.special_ammocount_explo[special_ammo_weapon] > 0) {
        self.special_ammocount_explo[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_explosivebullets");
        return false;
      } else if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[special_ammo_weapon]) && self.special_ammocount_comb[special_ammo_weapon] > 0) {
        self.special_ammocount_comb[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_explosivebullets");
        self _unsetPerk("specialty_armorpiercing");
        self _unsetPerk("specialty_bulletdamage");
        self.has_incendiary_ammo = undefined;
        return false;
      }
      return true;

    case "combined":
      if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[special_ammo_weapon]) && self.special_ammocount[special_ammo_weapon] > 0) {
        self.special_ammocount[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_bulletdamage");
        return false;
      } else if(isDefined(self.special_ammocount_ap) && isDefined(self.special_ammocount_ap[special_ammo_weapon]) && self.special_ammocount_ap[special_ammo_weapon] > 0) {
        self.special_ammocount_ap[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_armorpiercing");
        return false;
      } else if(isDefined(self.special_ammocount_explo) && isDefined(self.special_ammocount_explo[special_ammo_weapon]) && self.special_ammocount_explo[special_ammo_weapon] > 0) {
        self.special_ammocount_explo[special_ammo_weapon] = 0;
        self _unsetPerk("specialty_explosivebullets");
        return false;
      } else if(isDefined(self.special_ammocount_in) && isDefined(self.special_ammocount_in[special_ammo_weapon]) && self.special_ammocount_in[special_ammo_weapon] > 0) {
        self.has_incendiary_ammo = undefined;
        self.special_ammocount_in[special_ammo_weapon] = 0;
        return false;
      }
      return true;
  }

}

is_ammo_already_stored(weaponName) {
  if(isDefined(self.stored_ammo[weaponName])) {
    return (isDefined(self.stored_ammo[weaponName].clipammo) && isDefined(self.stored_ammo[weaponName].ammoStock));
  }
  return false;
}

give_special_ammo_by_weaponclass(boxent, primary_weapon, pillage) {
  if(!isDefined(primary_weapon)) {
    primary_weapon = self GetCurrentPrimaryWeapon();
  }
  class = getWeaponClass(primary_weapon);

  ratio = 0;
  if(isDefined(boxent)) {
    if(boxent.boxtype != "deployable_specialammo_comb") {
      switch (boxent.upgrade_rank) {
        case 0:
          ratio = .3;
          break;
        case 1:
          ratio = .4;
          break;
        case 2:
          ratio = .5;
          break;
        case 3:
          ratio = .6;
          break;
        case 4:
          ratio = .7;
          break;
      }
    } else {
      switch (boxEnt.upgrade_rank) {
        case 0:
          ratio = 0.4;
          break;
        case 1:
          ratio = 0.7;
          break;
        case 2:
          ratio = 1.0;
          break;
        case 3:
          ratio = 1.0;
          self maps\mp\alien\_deployablebox_functions::addFullCombinedClipToAllWeapons();
          break;
        case 4:
          ratio = 1.0;
          self maps\mp\alien\_deployablebox_functions::addFullCombinedClipToAllWeapons();
          break;
      }
    }
  }

  nerf_min_ammo_scalar = self maps\mp\alien\_deployablebox_functions::check_for_nerf_min_ammo();
  if(nerf_min_ammo_scalar != 1.0) {
    ratio = nerf_min_ammo_scalar;
  }

  switch (class) {
    case "weapon_smg":
    case "weapon_assault":
    case "weapon_shotgun":
    case "weapon_pistol":
    case "weapon_sniper":
    case "weapon_lmg":
    case "weapon_dmr":

      if(isDefined(pillage) && pillage) {
        if(level.use_alternate_specialammo_pillage_amounts) {
          clip = WeaponClipSize(primary_weapon);
          return (int(clip * 2));
        }

        return (int(WeaponMaxAmmo(primary_weapon) * 0.2));

      } else {
        return (int(WeaponMaxAmmo(primary_weapon) * ratio));
      }

    default:
      return 0;
  }

}

player_has_specialized_ammo(special_ammo_weapon) {
  has_special_ammo = false;

  if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[special_ammo_weapon]) && self.special_ammocount[special_ammo_weapon] > 0) {
    has_special_ammo = true;
  }

  if(isDefined(self.special_ammocount_ap) && isDefined(self.special_ammocount_ap[special_ammo_weapon]) && self.special_ammocount_ap[special_ammo_weapon] > 0) {
    has_special_ammo = true;
  }

  if(isDefined(self.special_ammocount_in) && isDefined(self.special_ammocount_in[special_ammo_weapon]) && self.special_ammocount_in[special_ammo_weapon] > 0) {
    has_special_ammo = true;
  }

  if(isDefined(self.special_ammocount_explo) && isDefined(self.special_ammocount_explo[special_ammo_weapon]) && self.special_ammocount_explo[special_ammo_weapon] > 0) {
    has_special_ammo = true;
  }

  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[special_ammo_weapon]) && self.special_ammocount_comb[special_ammo_weapon] > 0) {
    has_special_ammo = true;
  }

  return has_special_ammo;
}

has_stun_ammo(weapon_to_check) {
  if(!isDefined(weapon_to_check))
    weapon = self GetCurrentWeapon();
  else
    weapon = weapon_to_check;

  if(weapon == "none") {
    weapon = self GetWeaponsListPrimaries()[0];
  }

  base_weapon = getRawBaseWeaponName(weapon);

  if(is_chaos_mode() && self HasPerk("specialty_bulletdamage", true))
    return true;

  if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[base_weapon]) && self.special_ammocount[base_weapon] > 0)
    return true;

  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[base_weapon]) && self.special_ammocount_comb[base_weapon] > 0)
    return true;

  return false;
}

has_ap_ammo(weapon_to_check) {
  if(!isDefined(weapon_to_check))
    weapon = self GetCurrentWeapon();
  else
    weapon = weapon_to_check;

  if(weapon == "none") {
    weapon = self GetWeaponsListPrimaries()[0];
  }

  base_weapon = getRawBaseWeaponName(weapon);
  if(isDefined(self.special_ammocount_ap) && isDefined(self.special_ammocount_ap[base_weapon]) && self.special_ammocount_ap[base_weapon] > 0)
    return true;

  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[base_weapon]) && self.special_ammocount_comb[base_weapon] > 0)
    return true;

  return false;
}

has_explosive_ammo(weapon_to_check) {
  if(!isDefined(weapon_to_check))
    weapon = self GetCurrentWeapon();
  else
    weapon = weapon_to_check;

  if(weapon == "none") {
    weapon = self GetWeaponsListPrimaries()[0];
  }

  base_weapon = getRawBaseWeaponName(weapon);
  if(isDefined(self.special_ammocount_explo) && isDefined(self.special_ammocount_explo[base_weapon]) && self.special_ammocount_explo[base_weapon] > 0)
    return true;

  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[base_weapon]) && self.special_ammocount_comb[base_weapon] > 0)
    return true;

  return false;
}

has_incendiary_ammo(weapon_to_check) {
  if(!isDefined(weapon_to_check))
    weapon = self GetCurrentWeapon();
  else
    weapon = weapon_to_check;

  if(weapon == "none") {
    weapon = self GetWeaponsListPrimaries()[0];
  }

  base_weapon = getRawBaseWeaponName(weapon);
  if(isDefined(self.special_ammocount_in) && isDefined(self.special_ammocount_in[base_weapon]) && self.special_ammocount_in[base_weapon] > 0)
    return true;

  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[base_weapon]) && self.special_ammocount_comb[base_weapon] > 0)
    return true;

  return false;
}

has_combined_ammo(weapon_to_check) {
  if(!isDefined(weapon_to_check))
    weapon = self GetCurrentWeapon();
  else
    weapon = weapon_to_check;

  if(weapon == "none") {
    weapon = self GetWeaponsListPrimaries()[0];
  }

  base_weapon = getRawBaseWeaponName(weapon);
  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[base_weapon]) && self.special_ammocount_comb[base_weapon] > 0)
    return true;

  return false;
}

remove_specialized_ammo(special_ammo_weapon) {
  has_special_ammo = false;

  if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[special_ammo_weapon]) && self.special_ammocount[special_ammo_weapon] > 0) {
    self.special_ammocount[special_ammo_weapon] = 0;
  }

  if(isDefined(self.special_ammocount_ap) && isDefined(self.special_ammocount_ap[special_ammo_weapon]) && self.special_ammocount_ap[special_ammo_weapon] > 0) {
    self.special_ammocount_ap[special_ammo_weapon] = 0;
  }

  if(isDefined(self.special_ammocount_in) && isDefined(self.special_ammocount_in[special_ammo_weapon]) && self.special_ammocount_in[special_ammo_weapon] > 0) {
    self.special_ammocount_in[special_ammo_weapon] = 0;
  }

  if(isDefined(self.special_ammocount_explo) && isDefined(self.special_ammocount_explo[special_ammo_weapon]) && self.special_ammocount_explo[special_ammo_weapon] > 0) {
    self.special_ammocount_explo[special_ammo_weapon] = 0;
  }

  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[special_ammo_weapon]) && self.special_ammocount_comb[special_ammo_weapon] > 0) {
    self.special_ammocount_comb[special_ammo_weapon] = 0;
  }
}

get_specialized_ammo_type() {
  weapon = self GetCurrentWeapon();

  if(weapon == "none") {
    weapon = self GetWeaponsListPrimaries()[0];
  }

  base_weapon = getRawBaseWeaponName(weapon);

  has_special_ammo = false;

  if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[base_weapon]) && self.special_ammocount[base_weapon] > 0) {
    return "stun_ammo";
  }

  if(isDefined(self.special_ammocount_ap) && isDefined(self.special_ammocount_ap[base_weapon]) && self.special_ammocount_ap[base_weapon] > 0) {
    return "ap_ammo";
  }

  if(isDefined(self.special_ammocount_in) && isDefined(self.special_ammocount_in[base_weapon]) && self.special_ammocount_in[base_weapon] > 0) {
    return "incendiary_ammo";
  }

  if(isDefined(self.special_ammocount_explo) && isDefined(self.special_ammocount_explo[base_weapon]) && self.special_ammocount_explo[base_weapon] > 0) {
    return "explosive_ammo";
  }

  return "none";
}

mark_dangerous_nodes(dangerous_origin, radius, duration) {
  MarkDangerousNodes(dangerous_origin, radius, true);
  wait duration;
  MarkDangerousNodes(dangerous_origin, radius, false);
}

is_in_laststand() {
  return self.inLastStand;
}

is_hardcore_mode() {
  return (level.hardcoreMode);
}

is_ricochet_damage() {
  return (level.ricochetDamage);
}

is_chaos_mode() {
  return (level.isChaosMode == 1);
}

is_casual_mode() {
  return (level.casualMode == 1);
}

get_chaos_area() {
  return level.chaos_area;
}

deployable_box_onuse_message(boxent) {
  msg_text = "";
  if(isDefined(boxEnt) && isDefined(boxEnt.boxType) && isDefined(level.boxSettings[boxEnt.boxtype].eventString))
    msg_text = level.boxSettings[boxEnt.boxtype].eventString;

  self thread setLowerMessage("deployable_use", msg_text, 3);
}

set_attack_sync_direction(offset_direction, enter_anim, looping_anim, exit_anim, attacker_anim_state, attacker_anim_label) {
  attack_sync = [];

  attack_sync["enterAnim"] = enter_anim;
  attack_sync["loopAnim"] = looping_anim;
  attack_sync["exitAnim"] = exit_anim;
  attack_sync["attackerAnimState"] = attacker_anim_state;
  attack_sync["attackerAnimLabel"] = attacker_anim_label;
  attack_sync["offset_direction"] = offset_direction;

  return attack_sync;
}

set_synch_attack_setup(synch_directions, type_specific, end_notifies, can_synch_attack_func, begin_attack_func, loop_attack_func, end_attack_func, identifier) {
  attackSetup = spawnStruct();

  attackSetup.synch_directions = synch_directions;
  attackSetup.type_specific = type_specific;
  attackSetup.primary_attacker = undefined;
  attackSetup.can_synch_attack_func = can_synch_attack_func;
  attackSetup.begin_attack_func = begin_attack_func;
  attackSetup.end_attack_func = end_attack_func;
  attackSetup.loop_attack_func = loop_attack_func;
  attackSetup.end_notifies = end_notifies;
  attackSetup.identifier = identifier;

  self.synch_attack_setup = attackSetup;
}

get_synch_direction_list(synch_enemy) {
  if(!isDefined(self.synch_attack_setup))
    return [];

  if(!isDefined(self.synch_attack_setup.synch_directions))
    return [];

  if(!self.synch_attack_setup.type_specific)
    return self.synch_attack_setup.synch_directions;

  alienType = synch_enemy get_alien_type();

  if(!isDefined(self.synch_attack_setup.synch_directions[alienType])) {
    msg = "Synch attack on " + self.synch_attack_setup.identifier + " doesn't handle type: " + alienType;
    AssertMsg(msg);
  }

  return self.synch_attack_setup.synch_directions[alienType];
}

is_alien_agent() {
  return IsAgent(self) && isDefined(self.alien_type);
}

isPlayingSolo() {
  if(getDvarInt("sv_maxclients") == 1)
    return true;

  return false;
}

riotShieldName() {
  weapons = self GetWeaponsList("primary");

  if(!self.hasRiotShield) {
    return;
  }
  foreach(weapon in weapons) {
    if(WeaponType(weapon) == "riotshield") {
      return weapon;
    }
  }
}

get_array_of_valid_players(sort_by_closest, sort_by_closest_org) {
  valid_players = [];

  foreach(player in level.players) {
    if(player is_valid_player())
      valid_players[valid_players.size] = player;
  }

  if(!isDefined(sort_by_closest) || !sort_by_closest)
    return valid_players;

  return get_array_of_closest(sort_by_closest_org, valid_players);
}

is_valid_player() {
  if(!isDefined(self))
    return false;

  if(self maps\mp\alien\_utility::is_in_laststand())
    return false;

  if(!isAlive(self))
    return false;

  if(self.sessionstate == "spectator")
    return false;

  return true;
}

getRawBaseWeaponName(weaponName) {
  tokens = strTok(weaponName, "_");

  if(tokens[0] == "iw5" || tokens[0] == "iw6") {
    weaponName = tokens[1];
  } else if(tokens[0] == "alt") {
    weaponName = tokens[1] + "_" + tokens[2];
  }

  return weaponName;
}

get_in_world_area() {
  assertEx(isDefined(level.world_areas), "Register world area with alien_area_init()");

  foreach(area_name, area_volumn in level.world_areas) {
    if(self isTouching(area_volumn))
      return area_name;
  }

  return "none";
}

is_true(arg) {
  if(isDefined(arg) && arg)
    return true;

  return false;
}

is_akimbo_weapon(weapon) {
  switch (weapon) {
    case "iw5_alienp226_mp_akimbo_barrelrange02_xmags":
    case "iw5_alienmagnum_mp_akimbo_barrelrange02_xmags":
    case "iw5_alienm9a1_mp_akimbo_barrelrange02_xmags":
    case "iw5_alienmp443_mp_akimbo_barrelrange02_xmags":
      return true;
  }

  if(getWeaponClass(weapon) == "weapon_pistol")
    return issubstr(weapon, "akimbo");

  return false;
}

special_ammo_weapon_change_monitor(special_ammo_type) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("special_weapons_monitor");
  self endon("special_weapons_monitor");

  while(1) {
    self waittill("weapon_change", newWeapon);

    if(newWeapon == "none") {
      continue;
    }
    baseweapon = getRawBaseWeaponName(newWeapon);

    has_special_ammo = false;
    perk = undefined;
    icon_index = undefined;

    switch (special_ammo_type) {
      case "stun":
        has_special_ammo = self has_stun_ammo(baseweapon);
        perk = "specialty_bulletdamage";
        icon_index = 1;
        break;

      case "piercing":
        has_special_ammo = self has_ap_ammo(baseweapon);
        perk = "specialty_armorpiercing";
        icon_index = 4;
        break;

      case "incendiary":
        has_special_ammo = self has_incendiary_ammo(baseweapon);
        icon_index = 2;
        break;

      case "explosive":
        has_special_ammo = self has_explosive_ammo(baseweapon);
        perk = "specialty_explosivebullets";
        icon_index = 3;
        break;

      case "combined":
        has_special_ammo = self has_combined_ammo(baseweapon);
        icon_index = 5;
        break;
    }

    if(is_true(has_special_ammo)) {
      if(isDefined(perk))
        self givePerk(perk, false);

      if(special_ammo_type == "combined") {
        self.has_incendiary_ammo = true;
        self giveperk("specialty_bulletdamage", false);
        self giveperk("specialty_armorpiercing", false);
        self giveperk("specialty_explosivebullets", false);
      }

      if(special_ammo_type == "incendiary")
        self.has_incendiary_ammo = true;

      self SetClientOmnvar("ui_alien_specialammo", icon_index);
    } else {
      if(isDefined(perk)) {
        if(self _hasPerk(perk))
          self _unsetPerk(perk);
      }

      if(special_ammo_type == "combined") {
        self.has_incendiary_ammo = undefined;
        if(self _hasPerk("specialty_bulletdamage"))
          self _unsetPerk("specialty_bulletdamage");
        if(self _hasPerk("specialty_armorpiercing"))
          self _unsetPerk("specialty_armorpiercing");
        if(self _hasPerk("specialty_explosivebullets"))
          self _unsetPerk("specialty_explosivebullets");
      }

      if(special_ammo_type == "incendiary")
        self.has_incendiary_ammo = undefined;

      self SetClientOmnvar("ui_alien_specialammo", -1);
    }
  }
}

special_ammo_weapon_fire_monitor(special_ammo_type) {
  self notify("weaponfire_monitor");
  self endon("weaponfire_monitor");

  while(1) {
    self waittill("weapon_fired", wpnName);
    baseweaponName = getRawBaseWeaponName(wpnName);

    has_special_ammo = false;
    perk = undefined;

    switch (special_ammo_type) {
      case "stun":
        has_special_ammo = self has_stun_ammo(baseweaponName);
        perk = "specialty_bulletdamage";
        ammo_array = self.special_ammocount;
        break;

      case "piercing":
        has_special_ammo = self has_ap_ammo(baseweaponName);
        perk = "specialty_armorpiercing";
        ammo_array = self.special_ammocount_ap;
        break;

      case "incendiary":
        has_special_ammo = self has_incendiary_ammo(baseweaponName);
        ammo_array = self.special_ammocount_in;
        break;

      case "explosive":
        has_special_ammo = self has_explosive_ammo(baseweaponName);
        perk = "specialty_explosivebullets";
        ammo_array = self.special_ammocount_explo;
        break;
      case "combined":
        has_special_ammo = self has_combined_ammo(baseweaponName);
        ammo_array = self.special_ammocount_comb;
        break;
    }

    if(is_true(has_special_ammo)) {
      weapon_clip = self GetWeaponAmmoClip(wpnName);
      weapon_stock = self GetWeaponAmmoStock(wpnName);

      if(is_akimbo_weapon(wpnname)) {
        weapon_clip_left = self GetWeaponAmmoClip(wpnName, "left");
        weapon_clip_right = self GetWeaponAmmoClip(wpnname, "right");
        weapon_clip = weapon_clip_left + weapon_clip_right;
      }

      switch (special_ammo_type) {
        case "stun":
          self.special_ammocount[baseweaponName] = weapon_clip + weapon_stock;
          break;

        case "piercing":
          self.special_ammocount_ap[baseweaponName] = weapon_clip + weapon_stock;
          break;

        case "incendiary":
          self.special_ammocount_in[baseweaponName] = weapon_clip + weapon_stock;
          break;

        case "explosive":
          self.special_ammocount_explo[baseweaponName] = weapon_clip + weapon_stock;
          break;
        case "combined":
          self.special_ammocount_comb[baseweaponName] = weapon_clip + weapon_stock;
          break;
      }

      if(weapon_clip + weapon_stock < 1) {
        self SetClientOmnvar("ui_alien_specialammo", -1);

        if(isDefined(perk)) {
          if(self _hasPerk(perk))
            self _unsetPerk(perk);
        }

        if(special_ammo_type == "combined") {
          self.has_incendiary_ammo = undefined;
          if(self _hasPerk("specialty_bulletdamage"))
            self _unsetPerk("specialty_bulletdamage");
          if(self _hasPerk("specialty_armorpiercing"))
            self _unsetPerk("specialty_armorpiercing");
          if(self _hasPerk("specialty_explosivebullets"))
            self _unsetPerk("specialty_explosivebullets");
        }

        if(special_ammo_type == "incendiary")
          self.has_incendiary_ammo = undefined;

        if(isDefined(self.stored_ammo[baseweaponName])) {
          self.stored_ammo[baseweaponName].ammoStock += self.stored_ammo[baseweaponName].clipammo;
          self setweaponammoclip(wpnName, 0);
          self setweaponammostock(wpnName, self.stored_ammo[baseweaponName].ammoStock);
          self.stored_ammo[baseweaponName] = undefined;
          self SwitchToWeapon(wpnName);
        }
        continue;
      }
    }
  }

}

disable_special_ammo() {
  self endon("disconnect");

  primaries = self GetWeaponsListPrimaries();
  foreach(weapon in primaries) {
    baseweapon = getRawBaseWeaponName(weapon);

    special_ammo_type = undefined;
    perk = undefined;
    icon_index = undefined;

    if(self has_stun_ammo(baseweapon)) {
      perk = "specialty_bulletdamage";
      icon_index = 1;
      special_ammo_type = "stun";
    } else if(self has_ap_ammo(baseweapon)) {
      perk = "specialty_armorpiercing";
      icon_index = 4;
      special_ammo_type = "piercing";
    } else if(self has_incendiary_ammo(baseweapon)) {
      special_ammo_type = "incendiary";
      icon_index = 2;
    } else if(self has_explosive_ammo(baseweapon)) {
      special_ammo_type = "explosive";
      perk = "specialty_explosivebullets";
      icon_index = 3;
    } else if(self has_combined_ammo(baseweapon)) {
      special_ammo_type = "combined";
      icon_index = 5;
    }

    if(isDefined(special_ammo_type)) {
      if(isDefined(perk)) {
        if(self _hasPerk(perk))
          self _unsetPerk(perk);
      }

      if(special_ammo_type == "combined") {
        self.has_incendiary_ammo = undefined;
        if(self _hasPerk("specialty_bulletdamage"))
          self _unsetPerk("specialty_bulletdamage");
        if(self _hasPerk("specialty_armorpiercing"))
          self _unsetPerk("specialty_armorpiercing");
        if(self _hasPerk("specialty_explosivebullets"))
          self _unsetPerk("specialty_explosivebullets");
      }

      if(special_ammo_type == "incendiary")
        self.has_incendiary_ammo = undefined;

      self SetClientOmnvar("ui_alien_specialammo", -1);

      return;
    }
  }
}

enable_special_ammo() {
  self endon("disconnect");

  weapon = self GetCurrentPrimaryWeapon();
  baseweapon = getRawBaseWeaponName(weapon);

  special_ammo_type = undefined;
  perk = undefined;
  icon_index = undefined;

  if(self has_stun_ammo(baseweapon)) {
    perk = "specialty_bulletdamage";
    icon_index = 1;
    special_ammo_type = "stun";
  } else if(self has_ap_ammo(baseweapon)) {
    perk = "specialty_armorpiercing";
    icon_index = 4;
    special_ammo_type = "piercing";
  } else if(self has_incendiary_ammo(baseweapon)) {
    special_ammo_type = "incendiary";
    icon_index = 2;
  } else if(self has_explosive_ammo(baseweapon)) {
    special_ammo_type = "explosive";
    perk = "specialty_explosivebullets";
    icon_index = 3;
  } else if(self has_combined_ammo(baseweapon)) {
    special_ammo_type = "combined";
    icon_index = 5;
  }

  if(isDefined(special_ammo_type)) {
    if(isDefined(perk))
      self givePerk(perk, false);

    if(special_ammo_type == "combined") {
      self.has_incendiary_ammo = true;
      self giveperk("specialty_bulletdamage", false);
      self giveperk("specialty_armorpiercing", false);
      self giveperk("specialty_explosivebullets", false);
    }

    if(special_ammo_type == "incendiary")
      self.has_incendiary_ammo = true;

    self SetClientOmnvar("ui_alien_specialammo", icon_index);

  }

}

show_turret_icon(value) {
  self SetClientOmnvar("ui_alien_turret", value);
}

hide_turret_icon() {
  self SetClientOmnvar("ui_alien_turret", -1);
  self SetClientOmnvar("ui_alien_turret_ammo", -1);
}

set_turret_ammocount(ammo) {
  self SetClientOmnvar("ui_alien_turret_ammo", ammo);
}

add_hive_dependencies(hive, dependent_hives) {
  if(!isDefined(level.hive_dependencies))
    level.hive_dependencies = [];

  level.hive_dependencies[hive] = dependent_hives;
}

should_snare(player) {
  if(!self is_alien_agent() || is_chaos_mode())
    return false;

  if(player maps\mp\alien\_persistence::is_upgrade_enabled("no_snare_upgrade"))
    return false;

  type = self get_alien_type();
  if(type == "brute" || type == "minion")
    return true;
  else
    return false;
}

buildAlienWeaponName(baseName, attachment1, attachment2, attachment3, attachment4, camo, reticle) {
  if(isDefined(reticle) && reticle != 0 && getAttachmentType(attachment1) != "rail" && getAttachmentType(attachment2) != "rail" && getAttachmentType(attachment3) != "rail" && getAttachmentType(attachment4) != "rail") {
    reticle = undefined;
  }

  if(attachment1 == "alienvksscope")
    attachment1 = "scope";
  else if(attachment1 == "alienl115a3vzscope")
    attachment1 = "vzscope";
  if(attachment2 == "alienvksscope")
    attachment2 = "scope";
  else if(attachment2 == "alienl115a3vzscope")
    attachment2 = "vzscope";
  if(attachment3 == "alienvksscope")
    attachment3 = "scope";
  else if(attachment3 == "alienl115a3vzscope")
    attachment3 = "vzscope";
  if(attachment4 == "alienvksscope")
    attachment4 = "scope";
  else if(attachment4 == "alienl115a3vzscope")
    attachment4 = "vzscope";

  attachment1 = attachmentMap_toUnique(attachment1, baseName);
  attachment2 = attachmentMap_toUnique(attachment2, baseName);
  attachment3 = attachmentMap_toUnique(attachment3, baseName);
  attachment4 = attachmentMap_toUnique(attachment4, baseName);

  bareWeaponName = "";

  if(IsSubStr(baseName, "iw5") || IsSubStr(baseName, "iw6")) {
    weaponName = baseName + "_mp";
    endIndex = baseName.size;
    bareWeaponName = GetSubStr(baseName, 4, endIndex);
  } else {
    weaponName = baseName;
  }

  weapClass = getWeaponClass(baseName);
  needScope = weapClass == "weapon_sniper" || baseName == "aliendlc23";

  attachments = [];

  if(attachment1 != "none")
    attachments[attachments.size] = attachment1;

  if(attachment2 != "none")
    attachments[attachments.size] = attachment2;

  if(attachment3 != "none")
    attachments[attachments.size] = attachment3;

  if(attachment4 != "none")
    attachments[attachments.size] = attachment4;

  if(needScope) {
    hasAttachRail = false;
    foreach(attachment in attachments) {
      if(getAttachmentType(attachment) == "rail") {
        hasAttachRail = true;
        break;
      }
    }

    if(!hasAttachRail) {
      attachments[attachments.size] = bareWeaponName + "scope";
    }
  }

  if(isDefined(attachments.size) && attachments.size) {
    attachments = alphabetize(attachments);
  }

  foreach(attachment in attachments) {
    weaponName += "_" + attachment;
  }

  if(IsSubStr(weaponName, "iw5") || IsSubStr(weaponName, "iw6")) {
    weaponName = buildAlienWeaponNameCamo(weaponName, camo);
    weaponName = buildAlienWeaponNameReticle(weaponName, reticle);
  } else if(!isValidAlienWeapon(weaponName + "_mp")) {
    weaponName = baseName + "_mp";
  } else {
    weaponName = buildALienWeaponNameCamo(weaponName, camo);
    weaponName = buildAlienWeaponNameReticle(weaponName, reticle);
    weaponName += "_mp";
  }

  return weaponName;
}

buildALienWeaponNameCamo(weaponName, camo) {
  if(!isDefined(camo))
    return weaponName;
  if(camo <= 0)
    return weaponName;

  if(camo < 10)
    weaponName += "_camo0";
  else
    weaponName += "_camo";
  weaponName += camo;

  return weaponName;
}

buildAlienWeaponNameReticle(weaponName, reticle) {
  if(!isDefined(reticle)) {
    return weaponName;
  }

  if(reticle <= 1) {
    return weaponName;
  }

  reticle--;

  weaponName += "_scope";
  weaponName += reticle;

  return weaponName;
}

isValidAlienWeapon(refString) {
  if(!isDefined(level.weaponRefs)) {
    level.weaponRefs = [];

    foreach(weaponRef in level.weaponList)
    level.weaponRefs[weaponRef] = true;
  }

  if(isDefined(level.weaponRefs[refString]))
    return true;

  assertMsg("Replacing invalid weapon/attachment combo: " + refString);

  return false;
}

_detachAll() {
  if(isDefined(self.hasRiotShield) && self.hasRiotShield) {
    if(self.hasRiotShieldEquipped) {
      self DetachShieldModel("weapon_riot_shield_iw6", "tag_weapon_right");
      self.hasRiotShieldEquipped = false;
    } else {
      self DetachShieldModel("weapon_riot_shield_iw6", "tag_shield_back");
    }

    self.hasRiotShield = false;
  }

  self detachAll();
}

hasRiotShield() {
  result = false;

  weaponList = self GetWeaponsListPrimaries();
  foreach(weapon in weaponList) {
    if(maps\mp\gametypes\_weapons::isRiotShield(weapon)) {
      result = true;
      break;
    }
  }
  return result;
}

trackRiotShield() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  self.hasRiotShield = self hasRiotShield();
  curweapon = self GetCurrentWeapon();
  self.hasRiotShieldEquipped = maps\mp\gametypes\_weapons::isRiotShield(curweapon);

  if(self.hasRiotShield) {
    if(maps\mp\gametypes\_weapons::isRiotShield(self.primaryWeapon) && maps\mp\gametypes\_weapons::isRiotShield(self.secondaryWeapon)) {
      self AttachShieldModel("weapon_riot_shield_iw6", "tag_weapon_right");
      self AttachShieldModel("weapon_riot_shield_iw6", "tag_shield_back");
    } else if(self.hasRiotShieldEquipped) {
      self AttachShieldModel("weapon_riot_shield_iw6", "tag_weapon_right");
    } else {
      self AttachShieldModel("weapon_riot_shield_iw6", "tag_shield_back");
    }
  }

  for(;;) {
    self waittill("weapon_change", newWeapon);

    if(maps\mp\gametypes\_weapons::isRiotShield(newWeapon)) {
      if(self.hasRiotShieldEquipped) {
        continue;
      }
      if(maps\mp\gametypes\_weapons::isRiotShield(self.primaryWeapon) && maps\mp\gametypes\_weapons::isRiotShield(self.secondaryWeapon)) {
        continue;
      } else if(self.hasRiotShield) {
        self MoveShieldModel("weapon_riot_shield_iw6", "tag_shield_back", "tag_weapon_right");
      } else {
        self AttachShieldModel("weapon_riot_shield_iw6", "tag_weapon_right");
      }

      self.hasRiotShield = true;
      self.hasRiotShieldEquipped = true;
    } else if((self IsMantling()) && (newWeapon == "none")) {} else if(self.hasRiotShieldEquipped) {
      Assert(self.hasRiotShield);
      self.hasRiotShield = self hasRiotShield();

      if(self.hasRiotShield)
        self MoveShieldModel("weapon_riot_shield_iw6", "tag_weapon_right", "tag_shield_back");
      else
        self DetachShieldModel("weapon_riot_shield_iw6", "tag_weapon_right");

      self.hasRiotShieldEquipped = false;
    } else if(self.hasRiotShield && !self hasRiotShield()) {
      self DetachShieldModel("weapon_riot_shield_iw6", "tag_shield_back");
      self.hasRiotShield = false;
    } else if(!self.hasRiotShield && self hasRiotShield()) {
      self AttachShieldModel("weapon_riot_shield_iw6", "tag_shield_back");
      self.hasRiotShield = true;
    }
  }
}

tryAttach(placement) {
  if(!isDefined(placement) || placement != "back")
    tag = "tag_inhand";
  else
    tag = "tag_shield_back";

  attachSize = self getAttachSize();

  for(i = 0; i < attachSize; i++) {
    attachedTag = self getAttachTagName(i);
    if(attachedTag == tag && self getAttachModelName(i) == "weapon_riot_shield_iw6") {
      return;
    }
  }

  self AttachShieldModel("weapon_riot_shield_iw6", tag);
}

weapon_change_monitor() {
  self endon("disconnect");
  self.has_special_weapon = false;
  self.is_holding_deployable = false;
  self.is_holding_crate_marker = false;
  self.should_track_weapon_fired = true;

  while(1) {
    self waittill("weapon_change", wpn);

    switch (wpn) {
      case "none":
      case "alienbomb_mp":
      case "mortar_detonator_mp":
      case "switchblade_laptop_mp":
      case "aliendeployable_crate_marker_mp":
      case "iw5_alienriotshield_mp":
      case "iw5_alienriotshield1_mp":
      case "iw5_alienriotshield2_mp":
      case "iw5_alienriotshield3_mp":
      case "iw5_alienriotshield4_mp":
        self.should_track_weapon_fired = false;
        break;

      default:
        self.should_track_weapon_fired = true;
        break;
    }

    if(wpn == "none") {
      continue;
    }
    self.has_special_weapon = false;
    self.is_holding_deployable = false;
    self.is_holding_crate_marker = false;

    switch (wpn) {
      case "iw6_alienminigun_mp":
      case "iw6_alienminigun1_mp":
      case "iw6_alienminigun2_mp":
      case "iw6_alienminigun3_mp":
      case "iw6_alienminigun4_mp":
      case "iw6_alienmk32_mp":
      case "iw6_alienmk321_mp":
      case "iw6_alienmk322_mp":
      case "iw6_alienmk323_mp":
      case "iw6_alienmk324_mp":
      case "iw6_alienmaaws_mp":
        self.has_special_weapon = true;
        break;

      case "alienbomb_mp":
      case "alienclaymore_mp":
      case "bouncingbetty_mp":
      case "alientrophy_mp":
      case "deployable_vest_marker_mp":
      case "alienpropanetank_mp":
      case "alien_turret_marker_mp":
      case "switchblade_laptop_mp":
      case "mortar_detonator_mp":
        self.is_holding_deployable = true;
        break;

      case "aliendeployable_crate_marker_mp":
        self.is_holding_deployable = true;
        self.is_holding_crate_marker = true;
        break;
    }

    if(!self.has_special_weapon) {
      primaries = self GetWeaponsListPrimaries();
      foreach(weapon in primaries) {
        switch (weapon) {
          case "iw6_alienminigun_mp":
          case "iw6_alienminigun1_mp":
          case "iw6_alienminigun2_mp":
          case "iw6_alienminigun3_mp":
          case "iw6_alienminigun4_mp":
          case "iw6_alienmk32_mp":
          case "iw6_alienmk321_mp":
          case "iw6_alienmk322_mp":
          case "iw6_alienmk323_mp":
          case "iw6_alienmk324_mp":
          case "iw6_alienmaaws_mp":
            self.has_special_weapon = true;
        }
        if(self.has_special_weapon) {
          break;
        }
      }
    }

  }

}

is_trap(ent) {
  if(!isDefined(ent))
    return false;

  if(isDefined(ent.tesla_type))
    return true;

  if(!isDefined(ent.script_noteworthy) && !isDefined(ent.targetname))
    return false;

  if(isDefined(ent.targetname) && (ent.targetname == "fence_generator" || ent.targetname == "puddle_generator"))
    return true;

  if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "fire_trap")
    return true;

  return false;
}

zero_out_specialammo_clip(weapon) {
  if(is_akimbo_weapon(weapon)) {
    self SetWeaponAmmoClip(weapon, 0, "left");
    self SetWeaponAmmoClip(weapon, 0, "right");
  } else {
    self SetWeaponAmmoClip(weapon, 0);
  }
}

handle_existing_ammo(special_ammo_weapon, weapon, ammo_type) {
  if(!isDefined(self.stored_ammo))
    self.stored_ammo = [];

  if(!isDefined(self.stored_ammo[special_ammo_weapon])) {
    self.stored_ammo[special_ammo_weapon] = spawnStruct();
  }

  should_store_ammo = should_store_ammo_check(ammo_type, special_ammo_weapon);

  if(should_store_ammo && !is_ammo_already_stored(special_ammo_weapon)) {
    clipAmmo_stored = self GetWeaponAmmoClip(weapon);
    ammoStock_stored = self GetWeaponAmmoStock(weapon);

    if(is_akimbo_weapon(weapon)) {
      weapon_clip_left = self GetWeaponAmmoClip(weapon, "left");
      weapon_clip_right = self GetWeaponAmmoClip(weapon, "right");
      clipAmmo_stored = weapon_clip_left + weapon_clip_right;
    }

    self.stored_ammo[special_ammo_weapon].clipammo = clipAmmo_stored;
    self.stored_ammo[special_ammo_weapon].ammoStock = ammoStock_stored;
  }
}

wait_for_player_to_dismount_turret() {
  self endon("death");
  self endon("disconnect");

  self setLowerMessage("disengage_turret", & "ALIEN_COLLECTIBLES_DISENGAGE_TURRET", 0);
  while(self IsUsingTurret())
    wait .5;

  self clearLowerMessage("disengage_turret");
}

disable_weapon_timeout(timeout, notify_msg) {
  assert(isDefined(timeout) && isDefined(notify_msg));

  self thread enable_weapon_after_timeout(timeout, notify_msg);
  self _disableWeapon();
}

enable_weapon_after_timeout(timeout, notify_msg) {
  self endon("death");
  self endon(notify_msg);

  wait timeout;

  IPrintLnBold("^1[WARNING] Disable weapon timed out!");

  self _enableWeapon();
}

enable_weapon_wrapper(notify_msg) {
  assert(isDefined(notify_msg));

  self notify(notify_msg);
  self _enableWeapon();
}

GetMultipleRandomIndex(weights, numOfIndex) {
  Assert(weights.size >= numOfIndex);
  result = [];

  for(i = 0; i < numOfIndex; i++) {
    randomIndex = GetRandomIndex(weights);
    result[result.size] = randomIndex;

    weights = array_remove_index(weights, randomIndex, true);
  }

  return result;
}

array_remove_index(array, index, keepOriginalIndex) {
  newArray = [];

  foreach(arrayIndex, value in array) {
    if(arrayIndex == index) {
      continue;
    }
    if(is_true(keepOriginalIndex))
      newArray_index = arrayIndex;
    else
      newArray_index = newArray.size;

    newArray[newArray_index] = value;
  }

  return newArray;
}

GetRandomIndex(weights) {
  weightSum = 0;
  foreach(weight in weights)
  weightSum += weight;
  randIndex = RandomIntRange(0, weightSum);
  weightSum = 0;
  foreach(i, weight in weights) {
    weightSum += weight;
    if(randIndex <= weightSum)
      return i;
  }
  assertmsg("should not get here.");
  return 0;
}

_enableAdditionalPrimaryWeapon() {
  if(!isDefined(self.numAdditionalPrimaries)) {
    self.numAdditionalPrimaries = 0;
  }

  self.numAdditionalPrimaries++;
}

is_incompatible_weapon(weapon) {
  if(isDefined(level.ammoIncompatibleWeaponsList)) {
    if(array_contains(level.ammoIncompatibleWeaponsList, weapon))
      return true;
  }

  return false;
}

is_door() {
  return self.targetname == "stronghold_door_loc";
}

is_door_hive() {
  return is_true(level.hive_is_really_a_door);
}

has_tag(model, tag) {
  partCount = GetNumParts(model);
  for(i = 0; i < partCount; i++) {
    if(toLower(GetPartName(model, i)) == toLower(tag))
      return true;
  }
  return false;
}

level_uses_MAAWS() {
  switch (level.script) {
    case "mp_alien_beacon":
      return true;

    default:
      break;
  }
  return false;
}

is_flaming_stowed_riotshield_damage(sMeansOfDeath, sWeapon, eInflictor) {
  if(isDefined(einflictor) && is_trap(eInflictor))
    return false;

  if(sMeansOfDeath == "MOD_UNKNOWN" && sWeapon != "none")
    return true;
  else
    return false;
}

ark_attachment_transfer_to_locker_weapon(fullweaponname, current_attachments, should_take_weapon) {
  has_ark_attachment = undefined;

  weaponAttachments = getWeaponAttachmentsBaseNames(fullweaponname);
  if(isDefined(weaponAttachments[0]))
    attachment1 = weaponAttachments[0];
  else
    attachment1 = "none";
  if(isDefined(weaponAttachments[1]))
    attachment2 = weaponAttachments[1];
  else
    attachment2 = "none";
  if(isDefined(weaponAttachments[2]))
    attachment3 = weaponAttachments[2];
  else
    attachment3 = "none";
  if(isDefined(weaponAttachments[3]))
    attachment4 = weaponAttachments[3];
  else
    attachment4 = "none";

  if(is_true(should_take_weapon)) {
    foreach(piece in current_attachments) {
      piece = attachmentMap_toBase(piece);
      if(piece == "alienmuzzlebrake") {
        has_ark_attachment = true;
        break;
      }
    }
    if(is_true(has_ark_attachment)) {
      locker_weapon_attachments = getWeaponAttachments(fullweaponname);

      for(i = 0; i < locker_weapon_attachments.size; i++) {
        locker_weapon_attachments[i] = replace_barrelrange_with_ark(locker_weapon_attachments[i]);
        if(i == 0)
          attachment1 = attachmentMap_toBase(locker_weapon_attachments[i]);
        if(i == 1)
          attachment2 = attachmentMap_toBase(locker_weapon_attachments[i]);
        if(i == 2)
          attachment3 = attachmentMap_toBase(locker_weapon_attachments[i]);
        if(i == 3)
          attachment4 = attachmentMap_toBase(locker_weapon_attachments[i]);
      }
    }
  }

  baseweapon = GetWeaponBaseName(fullweaponname);
  weaponname = strip_suffix(baseweapon, "_mp");

  camo = RandomIntRange(1, 10);

  if(IsSubStr(baseweapon, "alienfp6") ||
    IsSubStr(baseweapon, "alienmts255") ||
    IsSubStr(baseweapon, "aliendlc12") ||
    IsSubStr(baseweapon, "aliendlc13") ||
    IsSubStr(baseweapon, "aliendlc14") ||
    IsSubStr(baseweapon, "aliendlc15") ||
    IsSubStr(baseweapon, "aliendlc23") ||
    IsSubStr(baseweapon, "altalienlsat") ||
    IsSubStr(baseweapon, "altaliensvu") ||
    IsSubStr(baseweapon, "altalienarx") ||
    IsSubStr(baseweapon, "arkalienr5rgp") ||
    IsSubStr(baseweapon, "arkaliendlc15") ||
    IsSubStr(baseweapon, "arkaliendlc23") ||
    IsSubStr(baseweapon, "arkalienk7") ||
    IsSubStr(baseweapon, "arkalienuts15") ||
    IsSubStr(baseweapon, "arkalienmaul") ||
    IsSubStr(baseweapon, "arkalienmk14") ||
    IsSubStr(baseweapon, "arkalienimbel") ||
    IsSubStr(baseweapon, "arkalienkac") ||
    IsSubStr(baseweapon, "arkalienameli"))
    camo = 0;

  reticle = RandomIntRange(1, 7);

  weapon_string = undefined;

  if(attachment1 != "thermal" &&
    attachment1 != "thermalsmg" &&
    attachment2 != "thermal" &&
    attachment2 != "thermalsmg" &&
    attachment3 != "thermal" &&
    attachment3 != "thermalsmg" &&
    attachment4 != "thermal" &&
    attachment4 != "thermalsmg" &&
    baseweapon != "iw6_aliendlc23_mp")
    fullweaponname = maps\mp\alien\_utility::buildAlienWeaponName(weaponname, attachment1, attachment2, attachment3, attachment4, camo, reticle);
  else
    fullweaponname = maps\mp\alien\_utility::buildAlienWeaponName(weaponname, attachment1, attachment2, attachment3, attachment4, camo);

  self.locker_weapon = fullweaponname;
  return fullweaponname;
}

replace_barrelrange_with_ark(attachment) {
  if(isDefined(attachment) && string_starts_with(attachment, "barrelrange"))
    return "alienmuzzlebrake";
  else
    return attachment;
}

return_weapon_with_like_attachments(fullweaponname, current_attachments) {
  baseweapon = GetWeaponBaseName(fullweaponname);
  player = self;
  attachment1 = "none";
  attachment2 = "none";
  attachment3 = "none";
  attachment4 = "none";
  weaponclass = getWeaponClass(baseweapon);
  possible_attachments = maps\mp\alien\_pillage::get_possible_attachments_by_weaponclass(weaponclass, baseweapon);

  valid_attachments = [];

  foreach(piece in current_attachments) {
    piece = attachmentMap_toBase(piece);

    if(array_contains(possible_attachments, piece)) {
      if(player maps\mp\alien\_persistence::is_upgrade_enabled("keep_attachments_upgrade"))
        valid_attachments = array_add(valid_attachments, piece);
      else if(piece == "alienmuzzlebrake")
        valid_attachments = array_add(valid_attachments, piece);
    }
  }

  if(valid_attachments.size > 0 && valid_attachments.size < 5) {
    for(i = 0; i < valid_attachments.size; i++) {
      if(i == 0)
        attachment1 = valid_attachments[i];
      if(i == 1)
        attachment2 = valid_attachments[i];
      if(i == 2)
        attachment3 = valid_attachments[i];
      if(i == 3)
        attachment4 = valid_attachments[i];
    }
  }

  weaponname = strip_suffix(baseweapon, "_mp");

  base_scope_attachment = base_scope_weapon_attachment(weaponname);

  if(isDefined(base_scope_attachment)) {
    switch (valid_attachments.size + 1) {
      case 1:
        attachment1 = base_scope_attachment;
        break;
      case 2:
        attachment2 = base_scope_attachment;
        break;
      case 3:
        attachment3 = base_scope_attachment;
        break;
      case 4:
        attachment4 = base_scope_attachment;
        break;
    }
  }

  newweapon = buildAlienWeaponName(weaponname, attachment1, attachment2, attachment3, attachment4);

  return newweapon;
}

base_scope_weapon_attachment(weaponname) {
  switch (weaponname) {
    case "iw6_arkalienvks":
    case "iw6_alienvks":
      return "alienvksscope";
    case "iw6_arkalienusr":
    case "iw6_alienusr":
      return "usrvzscope";
    case "iw6_arkaliendlc23":
    case "iw6_aliendlc23":
      return "dlcweap02scope";
    case "iw6_alienl115a3":
      return "alienl115a3scope";
    default:
      break;
  }

}

can_hypno(attacker, petTrapKill, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, inflictor) {
  if(isDefined(self.cannotHypno) && self.cannotHypno)
    return false;

  switch (self.alien_type) {
    case "goon":
    case "brute":
    case "spitter":
    case "locust":
    case "seeder":
      return true;
    case "elite":
      if(attacker maps\mp\alien\_persistence::is_upgrade_enabled("hypno_rhino_upgrade") || petTrapKill)
        return true;
    default:
      return false;
  }
}

has_fragile_relic_and_is_sprinting() {
  if(self maps\mp\alien\_prestige::prestige_getSlowHealthRegenScalar() != 1.0 && self IsSprinting())
    return true;
  else
    return false;
}

update_player_initial_spawn_info(coordinate, angles) {
  /#AssertEx( isDefined( coordinate) && isDefined( angles ), "Both coordinate and angles need to be defined" );

  level.playerInitialSpawnOriginOverride = coordinate;
  level.playerInitialSpawnAnglesOverride = angles;
}

get_player_initial_spawn_origin() {
  return level.playerInitialSpawnOriginOverride;
}

get_player_initial_spawn_angles() {
  return level.playerInitialSpawnAnglesOverride;
}

has_pistols_only_relic_and_no_deployables() {
  if(selfmaps\mp\alien\_prestige::prestige_getPistolsOnly() == 1 && self maps\mp\alien\_prestige::prestige_getNoDeployables() == 1)
    return true;
  else
    return false;
}

get_current_pistol() {
  primaries = self GetWeaponsListPrimaries();

  foreach(weapon in primaries) {
    weap_class = getWeaponClass(weapon);
    if(weap_class == "weapon_pistol") {
      return weapon;
    }
  }
}

is_idle_state_locked() {
  return (self.currentAnimState == "idle" && isDefined(self.idle_state_locked) && self.idle_state_locked);
}

return_nerf_scaled_ammo(new_weapon_string) {
  nerf_min_ammo_scalar = self maps\mp\alien\_deployablebox_functions::check_for_nerf_min_ammo();
  max_stock = WeaponMaxAmmo(new_weapon_string);
  return int(max_stock * nerf_min_ammo_scalar);
}

weapon_has_alien_attachment(weaponName, achievement_flag, eAttacker) {
  if(!isDefined(weaponName) ||
    weaponName == "none" ||
    WeaponInventoryType(weaponName) != "primary" ||
    weaponclass(weaponName) == "item" ||
    weaponclass(weaponName) == "rocketlauncher" ||
    weaponclass(weaponName) == "none"
  ) {
    return false;
  }

  if(is_true(achievement_flag) && self is_holding_pistol(eAttacker))
    return false;

  weaponAttachments = getWeaponAttachmentsBaseNames(weaponName);
  foreach(attachment in weaponAttachments) {
    if(attachment == "alienmuzzlebrake" || attachment == "alienmuzzlebrakesg" || attachment == "alienmuzzlebrakesn")
      return true;
  }
  return false;
}

is_holding_pistol(eAttacker) {
  cur_weapon = eAttacker GetCurrentPrimaryWeapon();
  if(getWeaponClass(cur_weapon) == "weapon_pistol")
    return true;
  else
    return false;
}

setup_class_nameplates() {
  perk = self maps\mp\alien\_persistence::get_selected_perk_0();
  material = undefined;
  switch (perk) {
    case "perk_bullet_damage":
      material = "player_name_bg_weapon_specialist";
      break;
    case "perk_health":
      material = "player_name_bg_tank";
      break;
    case "perk_rigger":
      material = "player_name_bg_engineer";
      break;
    case "perk_medic":
      material = "player_name_bg_medic";
      break;
    case "perk_none":
      material = "player_name_bg_mortal";
      break;
  }
  if(isDefined(material))
    self SetNameplateMaterial(material, material);
}