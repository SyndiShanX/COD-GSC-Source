/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_weapons.gsc
****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_audio;

init() {
  init_weapons();
  init_weapon_upgrade();
  init_weapon_toggle();
  init_pay_turret();
  treasure_chest_init();
  level thread add_limited_tesla_gun();
  PreCacheShader("minimap_icon_mystery_box");
  PrecacheShader("specialty_instakill_zombies");
  PrecacheShader("specialty_firesale_zombies");
  level._zombiemode_check_firesale_loc_valid_func = ::default_check_firesale_loc_valid_func;
}
default_check_firesale_loc_valid_func() {
  return true;
}
add_zombie_weapon(weapon_name, upgrade_name, hint, cost, weaponVO, weaponVOresp, ammo_cost) {
  if(isDefined(level.zombie_include_weapons) && !isDefined(level.zombie_include_weapons[weapon_name])) {
    return;
  }
  table = "mp/zombiemode.csv";
  table_cost = TableLookUp(table, 0, weapon_name, 1);
  table_ammo_cost = TableLookUp(table, 0, weapon_name, 2);
  if(isDefined(table_cost) && table_cost != "") {
    cost = round_up_to_ten(int(table_cost));
  }
  if(isDefined(table_ammo_cost) && table_ammo_cost != "") {
    ammo_cost = round_up_to_ten(int(table_ammo_cost));
  }
  PrecacheString(hint);
  struct = spawnStruct();
  if(!isDefined(level.zombie_weapons)) {
    level.zombie_weapons = [];
  }
  struct.weapon_name = weapon_name;
  struct.upgrade_name = upgrade_name;
  struct.weapon_classname = "weapon_" + weapon_name;
  struct.hint = hint;
  struct.cost = cost;
  struct.vox = weaponVO;
  struct.vox_response = weaponVOresp;
  struct.is_in_box = level.zombie_include_weapons[weapon_name];
  if(!isDefined(ammo_cost)) {
    ammo_cost = round_up_to_ten(int(cost * 0.5));
  }
  struct.ammo_cost = ammo_cost;
  level.zombie_weapons[weapon_name] = struct;
}
default_weighting_func() {
  return 1;
}
default_tesla_weighting_func() {
  num_to_add = 1;
  if(isDefined(level.pulls_since_last_tesla_gun)) {
    if(isDefined(level.player_drops_tesla_gun) && level.player_drops_tesla_gun == true) {
      num_to_add += int(.2 * level.zombie_include_weapons.size);
    }
    if(!isDefined(level.player_seen_tesla_gun) || level.player_seen_tesla_gun == false) {
      if(level.round_number > 10) {
        num_to_add += int(.2 * level.zombie_include_weapons.size);
      } else if(level.round_number > 5) {
        num_to_add += int(.15 * level.zombie_include_weapons.size);
      }
    }
  }
  return num_to_add;
}
default_1st_move_weighting_func() {
  if(level.chest_moves > 0) {
    num_to_add = 1;
    return num_to_add;
  } else {
    return 0;
  }
}
default_upgrade_weapon_weighting_func() {
  if(level.chest_moves > 1) {
    return 1;
  } else {
    return 0;
  }
}
default_cymbal_monkey_weighting_func() {
  players = get_players();
  count = 0;
  for(i = 0; i < players.size; i++) {
    if(players[i] has_weapon_or_upgrade("zombie_cymbal_monkey")) {
      count++;
    }
  }
  if(count > 0) {
    return 1;
  } else {
    if(level.round_number < 10) {
      return 3;
    } else {
      return 5;
    }
  }
}
is_weapon_included(weapon_name) {
  if(!isDefined(level.zombie_weapons)) {
    return false;
  }
  return isDefined(level.zombie_weapons[weapon_name]);
}
#include_zombie_weapon(weapon_name, in_box, collector, weighting_func) {
  if(!isDefined(level.zombie_include_weapons)) {
    level.zombie_include_weapons = [];
    level.collector_achievement_weapons = [];
  }
  if(!isDefined(in_box)) {
    in_box = true;
  }
  if(isDefined(collector) && collector) {
    level.collector_achievement_weapons = array_add(level.collector_achievement_weapons, weapon_name);
  }
  level.zombie_include_weapons[weapon_name] = in_box;
  PrecacheItem(weapon_name);
  if(!isDefined(weighting_func)) {
    level.weapon_weighting_funcs[weapon_name] = maps\_zombiemode_weapons::default_weighting_func;
  } else {
    level.weapon_weighting_funcs[weapon_name] = weighting_func;
  }
}
init_weapons() {
  add_zombie_weapon("m1911_zm", "m1911_upgraded_zm", &"ZOMBIE_WEAPON_M1911", 50, "pistol", "", undefined);
  add_zombie_weapon("python_zm", "python_upgraded_zm", &"ZOMBIE_WEAPON_PYTHON", 2200, "pistol", "", undefined);
  add_zombie_weapon("cz75_zm", "cz75_upgraded_zm", &"ZOMBIE_WEAPON_CZ75", 50, "pistol", "", undefined);
  add_zombie_weapon("ak74u_zm", "ak74u_upgraded_zm", &"ZOMBIE_WEAPON_AK74U", 1200, "smg", "", undefined);
  add_zombie_weapon("mp5k_zm", "mp5k_upgraded_zm", &"ZOMBIE_WEAPON_MP5K", 1000, "smg", "", undefined);
  add_zombie_weapon("mp40_zm", "mp40_upgraded_zm", &"ZOMBIE_WEAPON_MP40", 1000, "smg", "", undefined);
  add_zombie_weapon("mpl_zm", "mpl_upgraded_zm", &"ZOMBIE_WEAPON_MPL", 1000, "smg", "", undefined);
  add_zombie_weapon("pm63_zm", "pm63_upgraded_zm", &"ZOMBIE_WEAPON_PM63", 1000, "smg", "", undefined);
  add_zombie_weapon("spectre_zm", "spectre_upgraded_zm", &"ZOMBIE_WEAPON_SPECTRE", 50, "smg", "", undefined);
  add_zombie_weapon("cz75dw_zm", "cz75dw_upgraded_zm", &"ZOMBIE_WEAPON_CZ75DW", 50, "dualwield", "", undefined);
  add_zombie_weapon("ithaca_zm", "ithaca_upgraded_zm", &"ZOMBIE_WEAPON_ITHACA", 1500, "shotgun", "", undefined);
  add_zombie_weapon("spas_zm", "spas_upgraded_zm", &"ZOMBIE_WEAPON_SPAS", 2000, "shotgun", "", undefined);
  add_zombie_weapon("rottweil72_zm", "rottweil72_upgraded_zm", &"ZOMBIE_WEAPON_ROTTWEIL72", 500, "shotgun", "", undefined);
  add_zombie_weapon("hs10_zm", "hs10_upgraded_zm", &"ZOMBIE_WEAPON_HS10", 50, "shotgun", "", undefined);
  add_zombie_weapon("m14_zm", "m14_upgraded_zm", &"ZOMBIE_WEAPON_M14", 500, "rifle", "", undefined);
  add_zombie_weapon("m16_zm", "m16_gl_upgraded_zm", &"ZOMBIE_WEAPON_M16", 1200, "burstrifle", "", undefined);
  add_zombie_weapon("g11_lps_zm", "g11_lps_upgraded_zm", &"ZOMBIE_WEAPON_G11", 900, "burstrifle", "", undefined);
  add_zombie_weapon("famas_zm", "famas_upgraded_zm", &"ZOMBIE_WEAPON_FAMAS", 50, "burstrifle", "", undefined);
  add_zombie_weapon("aug_acog_zm", "aug_acog_mk_upgraded_zm", &"ZOMBIE_WEAPON_AUG", 1200, "assault", "", undefined);
  add_zombie_weapon("galil_zm", "galil_upgraded_zm", &"ZOMBIE_WEAPON_GALIL", 100, "assault", "", undefined);
  add_zombie_weapon("commando_zm", "commando_upgraded_zm", &"ZOMBIE_WEAPON_COMMANDO", 100, "assault", "", undefined);
  add_zombie_weapon("fnfal_zm", "fnfal_upgraded_zm", &"ZOMBIE_WEAPON_FNFAL", 100, "burstrifle", "", undefined);
  add_zombie_weapon("dragunov_zm", "dragunov_upgraded_zm", &"ZOMBIE_WEAPON_DRAGUNOV", 2500, "sniper", "", undefined);
  add_zombie_weapon("l96a1_zm", "l96a1_upgraded_zm", &"ZOMBIE_WEAPON_L96A1", 50, "sniper", "", undefined);
  add_zombie_weapon("rpk_zm", "rpk_upgraded_zm", &"ZOMBIE_WEAPON_RPK", 4000, "mg", "", undefined);
  add_zombie_weapon("hk21_zm", "hk21_upgraded_zm", &"ZOMBIE_WEAPON_HK21", 50, "mg", "", undefined);
  add_zombie_weapon("frag_grenade_zm", undefined, &"ZOMBIE_WEAPON_FRAG_GRENADE", 250, "grenade", "", undefined);
  add_zombie_weapon("sticky_grenade_zm", undefined, &"ZOMBIE_WEAPON_STICKY_GRENADE", 250, "grenade", "", undefined);
  add_zombie_weapon("claymore_zm", undefined, &"ZOMBIE_WEAPON_CLAYMORE", 1000, "grenade", "", undefined);
  add_zombie_weapon("m72_law_zm", "m72_law_upgraded_zm", &"ZOMBIE_WEAPON_M72_LAW", 2000, "launcher", "", undefined);
  add_zombie_weapon("china_lake_zm", "china_lake_upgraded_zm", &"ZOMBIE_WEAPON_CHINA_LAKE", 2000, "launcher", "", undefined);
  add_zombie_weapon("zombie_cymbal_monkey", undefined, &"ZOMBIE_WEAPON_SATCHEL_2000", 2000, "monkey", "", undefined);
  add_zombie_weapon("ray_gun_zm", "ray_gun_upgraded_zm", &"ZOMBIE_WEAPON_RAYGUN", 10000, "raygun", "", undefined);
  add_zombie_weapon("tesla_gun_zm", "tesla_gun_upgraded_zm", &"ZOMBIE_WEAPON_TESLA", 10, "tesla", "", undefined);
  add_zombie_weapon("thundergun_zm", "thundergun_upgraded_zm", &"ZOMBIE_WEAPON_THUNDERGUN", 10, "thunder", "", undefined);
  add_zombie_weapon("crossbow_explosive_zm", "crossbow_explosive_upgraded_zm", &"ZOMBIE_WEAPON_CROSSBOW_EXPOLOSIVE", 10, "crossbow", "", undefined);
  add_zombie_weapon("knife_ballistic_zm", "knife_ballistic_upgraded_zm", &"ZOMBIE_WEAPON_KNIFE_BALLISTIC", 10, "bowie", "", undefined);
  add_zombie_weapon("knife_ballistic_bowie_zm", "knife_ballistic_bowie_upgraded_zm", &"ZOMBIE_WEAPON_KNIFE_BALLISTIC", 10, "bowie", "", undefined);
  add_zombie_weapon("knife_ballistic_sickle_zm", "knife_ballistic_sickle_upgraded_zm", &"ZOMBIE_WEAPON_KNIFE_BALLISTIC", 10, "sickle", "", undefined);
  add_zombie_weapon("freezegun_zm", "freezegun_upgraded_zm", &"ZOMBIE_WEAPON_FREEZEGUN", 10, "freezegun", "", undefined);
  add_zombie_weapon("zombie_black_hole_bomb", undefined, &"ZOMBIE_WEAPON_SATCHEL_2000", 2000, "gersh", "", undefined);
  add_zombie_weapon("zombie_nesting_dolls", undefined, &"ZOMBIE_WEAPON_NESTING_DOLLS", 2000, "dolls", "", undefined);
  if(isDefined(level._zombie_custom_add_weapons)) {
    [[level._zombie_custom_add_weapons]]();
  }
  Precachemodel("zombie_teddybear");
}
add_limited_tesla_gun() {
  weapon_spawns = getEntArray("weapon_upgrade", "targetname");
  for(i = 0; i < weapon_spawns.size; i++) {
    hint_string = weapon_spawns[i].zombie_weapon_upgrade;
    if(hint_string == "tesla_gun_zm") {
      weapon_spawns[i] waittill("trigger");
      weapon_spawns[i] disable_trigger();
      break;
    }
  }
}
add_limited_weapon(weapon_name, amount) {
  if(!isDefined(level.limited_weapons)) {
    level.limited_weapons = [];
  }
  level.limited_weapons[weapon_name] = amount;
}
init_pay_turret() {
  pay_turrets = [];
  pay_turrets = getEntArray("pay_turret", "targetname");
  for(i = 0; i < pay_turrets.size; i++) {
    cost = level.pay_turret_cost;
    if(!isDefined(cost)) {
      cost = 1000;
    }
    pay_turrets[i] SetHintString(&"ZOMBIE_PAY_TURRET", cost);
    pay_turrets[i] SetCursorHint("HINT_NOICON");
    pay_turrets[i] UseTriggerRequireLookAt();
    pay_turrets[i] thread pay_turret_think(cost);
  }
}
init_weapon_upgrade() {
  weapon_spawns = [];
  weapon_spawns = getEntArray("weapon_upgrade", "targetname");
  for(i = 0; i < weapon_spawns.size; i++) {
    hint_string = get_weapon_hint(weapon_spawns[i].zombie_weapon_upgrade);
    cost = get_weapon_cost(weapon_spawns[i].zombie_weapon_upgrade);
    weapon_spawns[i] SetHintString(hint_string, cost);
    weapon_spawns[i] setCursorHint("HINT_NOICON");
    weapon_spawns[i] UseTriggerRequireLookAt();
    weapon_spawns[i] thread weapon_spawn_think();
    model = getent(weapon_spawns[i].target, "targetname");
    model useweaponhidetags(weapon_spawns[i].zombie_weapon_upgrade);
    model hide();
  }
}
init_weapon_toggle() {
  if(!isDefined(level.magic_box_weapon_toggle_init_callback)) {
    return;
  }
  level.zombie_weapon_toggles = [];
  level.zombie_weapon_toggle_max_active_count = 0;
  level.zombie_weapon_toggle_active_count = 0;
  PrecacheString(&"ZOMBIE_WEAPON_TOGGLE_DISABLED");
  PrecacheString(&"ZOMBIE_WEAPON_TOGGLE_ACTIVATE");
  PrecacheString(&"ZOMBIE_WEAPON_TOGGLE_DEACTIVATE");
  PrecacheString(&"ZOMBIE_WEAPON_TOGGLE_ACQUIRED");
  level.zombie_weapon_toggle_disabled_hint = &"ZOMBIE_WEAPON_TOGGLE_DISABLED";
  level.zombie_weapon_toggle_activate_hint = &"ZOMBIE_WEAPON_TOGGLE_ACTIVATE";
  level.zombie_weapon_toggle_deactivate_hint = &"ZOMBIE_WEAPON_TOGGLE_DEACTIVATE";
  level.zombie_weapon_toggle_acquired_hint = &"ZOMBIE_WEAPON_TOGGLE_ACQUIRED";
  PrecacheModel("zombie_zapper_cagelight");
  PrecacheModel("zombie_zapper_cagelight_green");
  PrecacheModel("zombie_zapper_cagelight_red");
  PrecacheModel("zombie_zapper_cagelight_on");
  level.zombie_weapon_toggle_disabled_light = "zombie_zapper_cagelight";
  level.zombie_weapon_toggle_active_light = "zombie_zapper_cagelight_green";
  level.zombie_weapon_toggle_inactive_light = "zombie_zapper_cagelight_red";
  level.zombie_weapon_toggle_acquired_light = "zombie_zapper_cagelight_on";
  weapon_toggle_ents = [];
  weapon_toggle_ents = getEntArray("magic_box_weapon_toggle", "targetname");
  for(i = 0; i < weapon_toggle_ents.size; i++) {
    struct = spawnStruct();
    struct.trigger = weapon_toggle_ents[i];
    struct.weapon_name = struct.trigger.script_string;
    struct.upgrade_name = level.zombie_weapons[struct.trigger.script_string].upgrade_name;
    struct.enabled = false;
    struct.active = false;
    struct.acquired = false;
    target_array = [];
    target_array = getEntArray(struct.trigger.target, "targetname");
    for(j = 0; j < target_array.size; j++) {
      switch (target_array[j].script_string) {
        case "light":
          struct.light = target_array[j];
          struct.light setModel(level.zombie_weapon_toggle_disabled_light);
          break;
        case "weapon":
          struct.weapon_model = target_array[j];
          struct.weapon_model hide();
          break;
      }
    }
    struct.trigger SetHintString(level.zombie_weapon_toggle_disabled_hint);
    struct.trigger setCursorHint("HINT_NOICON");
    struct.trigger UseTriggerRequireLookAt();
    struct thread weapon_toggle_think();
    level.zombie_weapon_toggles[struct.weapon_name] = struct;
  }
  level thread[[level.magic_box_weapon_toggle_init_callback]]();
}
get_weapon_toggle(weapon_name) {
  if(!isDefined(level.zombie_weapon_toggles)) {
    return undefined;
  }
  if(isDefined(level.zombie_weapon_toggles[weapon_name])) {
    return level.zombie_weapon_toggles[weapon_name];
  }
  keys = GetArrayKeys(level.zombie_weapon_toggles);
  for(i = 0; i < keys.size; i++) {
    if(weapon_name == level.zombie_weapon_toggles[keys[i]].upgrade_name) {
      return level.zombie_weapon_toggles[keys[i]];
    }
  }
  return undefined;
}
is_weapon_toggle(weapon_name) {
  return isDefined(get_weapon_toggle(weapon_name));
}
disable_weapon_toggle(weapon_name) {
  toggle = get_weapon_toggle(weapon_name);
  if(!isDefined(toggle)) {
    return;
  }
  if(toggle.active) {
    level.zombie_weapon_toggle_active_count--;
  }
  toggle.enabled = false;
  toggle.active = false;
  toggle.light setModel(level.zombie_weapon_toggle_disabled_light);
  toggle.weapon_model hide();
  toggle.trigger SetHintString(level.zombie_weapon_toggle_disabled_hint);
}
enable_weapon_toggle(weapon_name) {
  toggle = get_weapon_toggle(weapon_name);
  if(!isDefined(toggle)) {
    return;
  }
  toggle.enabled = true;
  toggle.weapon_model show();
  toggle.weapon_model useweaponhidetags(weapon_name);
  deactivate_weapon_toggle(weapon_name);
}
activate_weapon_toggle(weapon_name, trig_for_vox) {
  if(level.zombie_weapon_toggle_active_count >= level.zombie_weapon_toggle_max_active_count) {
    if(isDefined(trig_for_vox)) {
      trig_for_vox thread maps\_zombiemode_audio::weapon_toggle_vox("max");
    }
    return;
  }
  toggle = get_weapon_toggle(weapon_name);
  if(!isDefined(toggle)) {
    return;
  }
  if(isDefined(trig_for_vox)) {
    trig_for_vox thread maps\_zombiemode_audio::weapon_toggle_vox("activate", weapon_name);
  }
  level.zombie_weapon_toggle_active_count++;
  toggle.active = true;
  toggle.light setModel(level.zombie_weapon_toggle_active_light);
  toggle.trigger SetHintString(level.zombie_weapon_toggle_deactivate_hint);
}
deactivate_weapon_toggle(weapon_name, trig_for_vox) {
  toggle = get_weapon_toggle(weapon_name);
  if(!isDefined(toggle)) {
    return;
  }
  if(isDefined(trig_for_vox)) {
    trig_for_vox thread maps\_zombiemode_audio::weapon_toggle_vox("deactivate", weapon_name);
  }
  if(toggle.active) {
    level.zombie_weapon_toggle_active_count--;
  }
  toggle.active = false;
  toggle.light setModel(level.zombie_weapon_toggle_inactive_light);
  toggle.trigger SetHintString(level.zombie_weapon_toggle_activate_hint);
}
acquire_weapon_toggle(weapon_name, player) {
  toggle = get_weapon_toggle(weapon_name);
  if(!isDefined(toggle)) {
    return;
  }
  if(!toggle.active || toggle.acquired) {
    return;
  }
  toggle.acquired = true;
  toggle.light setModel(level.zombie_weapon_toggle_acquired_light);
  toggle.trigger SetHintString(level.zombie_weapon_toggle_acquired_hint);
  toggle thread unacquire_weapon_toggle_on_death_or_disconnect_thread(player);
}
unacquire_weapon_toggle_on_death_or_disconnect_thread(player) {
  self notify("end_unacquire_weapon_thread");
  self endon("end_unacquire_weapon_thread");
  player waittill_any("spawned_spectator", "disconnect");
  unacquire_weapon_toggle(self.weapon_name);
}
unacquire_weapon_toggle(weapon_name) {
  toggle = get_weapon_toggle(weapon_name);
  if(!isDefined(toggle)) {
    return;
  }
  if(!toggle.active || !toggle.acquired) {
    return;
  }
  toggle.acquired = false;
  toggle.light setModel(level.zombie_weapon_toggle_active_light);
  toggle.trigger SetHintString(level.zombie_weapon_toggle_deactivate_hint);
  toggle notify("end_unacquire_weapon_thread");
}
weapon_toggle_think() {
  for(;;) {
    self.trigger waittill("trigger", player);
    if(!is_player_valid(player)) {
      player thread ignore_triggers(0.5);
      continue;
    }
    if(!self.enabled || self.acquired) {
      self.trigger thread maps\_zombiemode_audio::weapon_toggle_vox("max");
    } else if(!self.active) {
      activate_weapon_toggle(self.weapon_name, self.trigger);
    } else {
      deactivate_weapon_toggle(self.weapon_name, self.trigger);
    }
  }
}
init_weapon_cabinet() {
  weapon_cabs = getEntArray("weapon_cabinet_use", "targetname");
  for(i = 0; i < weapon_cabs.size; i++) {
    weapon_cabs[i] SetHintString(&"ZOMBIE_CABINET_OPEN_1500");
    weapon_cabs[i] setCursorHint("HINT_NOICON");
    weapon_cabs[i] UseTriggerRequireLookAt();
  }
}
get_weapon_hint(weapon_name) {
  AssertEx(isDefined(level.zombie_weapons[weapon_name]), weapon_name + " was not included or is not part of the zombie weapon list.");
  return level.zombie_weapons[weapon_name].hint;
}
get_weapon_cost(weapon_name) {
  AssertEx(isDefined(level.zombie_weapons[weapon_name]), weapon_name + " was not included or is not part of the zombie weapon list.");
  return level.zombie_weapons[weapon_name].cost;
}
get_ammo_cost(weapon_name) {
  AssertEx(isDefined(level.zombie_weapons[weapon_name]), weapon_name + " was not included or is not part of the zombie weapon list.");
  return level.zombie_weapons[weapon_name].ammo_cost;
}
get_is_in_box(weapon_name) {
  AssertEx(isDefined(level.zombie_weapons[weapon_name]), weapon_name + " was not included or is not part of the zombie weapon list.");
  return level.zombie_weapons[weapon_name].is_in_box;
}
is_weapon_upgraded(weaponname) {
  if(!isDefined(weaponname) || weaponname == "") {
    return false;
  }
  weaponname = ToLower(weaponname);
  ziw_keys = GetArrayKeys(level.zombie_weapons);
  for(i = 0; i < level.zombie_weapons.size; i++) {
    if(isDefined(level.zombie_weapons[ziw_keys[i]].upgrade_name) &&
      level.zombie_weapons[ziw_keys[i]].upgrade_name == weaponname) {
      return true;
    }
  }
  return false;
}
has_upgrade(weaponname) {
  has_upgrade = false;
  if(isDefined(level.zombie_weapons[weaponname]) && isDefined(level.zombie_weapons[weaponname].upgrade_name)) {
    has_upgrade = self HasWeapon(level.zombie_weapons[weaponname].upgrade_name);
  }
  if(!has_upgrade && "knife_ballistic_zm" == weaponname) {
    has_upgrade = has_upgrade("knife_ballistic_bowie_zm") || has_upgrade("knife_ballistic_sickle_zm");
  }
  return has_upgrade;
}
has_weapon_or_upgrade(weaponname) {
  upgradedweaponname = weaponname;
  if(isDefined(level.zombie_weapons[weaponname]) && isDefined(level.zombie_weapons[weaponname].upgrade_name)) {
    upgradedweaponname = level.zombie_weapons[weaponname].upgrade_name;
  }
  has_weapon = false;
  if(isDefined(level.zombie_weapons[weaponname])) {
    has_weapon = self HasWeapon(weaponname) || self has_upgrade(weaponname);
  }
  if(!has_weapon && "knife_ballistic_zm" == weaponname) {
    has_weapon = has_weapon_or_upgrade("knife_ballistic_bowie_zm") || has_weapon_or_upgrade("knife_ballistic_sickle_zm");
  }
  return has_weapon;
}
treasure_chest_init() {
  if(level.mutators["mutator_noMagicBox"]) {
    chests = getEntArray("treasure_chest_use", "targetname");
    for(i = 0; i < chests.size; i++) {
      chests[i] get_chest_pieces();
      chests[i] hide_chest();
    }
    return;
  }
  flag_init("moving_chest_enabled");
  flag_init("moving_chest_now");
  flag_init("chest_has_been_used");
  level.chest_moves = 0;
  level.chest_level = 0;
  level.chests = getEntArray("treasure_chest_use", "targetname");
  for(i = 0; i < level.chests.size; i++) {
    level.chests[i].box_hacks = [];
    level.chests[i].orig_origin = level.chests[i].origin;
    level.chests[i] get_chest_pieces();
    if(isDefined(level.chests[i].zombie_cost)) {
      level.chests[i].old_cost = level.chests[i].zombie_cost;
    } else {
      level.chests[i].old_cost = 950;
    }
  }
  level.chest_accessed = 0;
  if(level.chests.size > 1) {
    flag_set("moving_chest_enabled");
    level.chests = array_randomize(level.chests);
    init_starting_chest_location();
  } else {
    level.chest_index = 0;
  }
  array_thread(level.chests, ::treasure_chest_think);
}
init_starting_chest_location() {
  level.chest_index = 0;
  start_chest_found = false;
  for(i = 0; i < level.chests.size; i++) {
    if(isDefined(level.random_pandora_box_start) && level.random_pandora_box_start == true) {
      if(start_chest_found || (isDefined(level.chests[i].start_exclude) && level.chests[i].start_exclude == 1)) {
        level.chests[i] hide_chest();
      } else {
        level.chest_index = i;
        level.chests[level.chest_index] hide_rubble();
        level.chests[level.chest_index].hidden = false;
        start_chest_found = true;
      }
    } else {
      if(start_chest_found || !isDefined(level.chests[i].script_noteworthy) || (!IsSubStr(level.chests[i].script_noteworthy, "start_chest"))) {
        level.chests[i] hide_chest();
      } else {
        level.chest_index = i;
        level.chests[level.chest_index] hide_rubble();
        level.chests[level.chest_index].hidden = false;
        start_chest_found = true;
      }
    }
  }
  if(!isDefined(level.pandora_show_func)) {
    level.pandora_show_func = ::default_pandora_show_func;
  }
  level.chests[level.chest_index] thread[[level.pandora_show_func]]();
}
hide_rubble() {
  rubble = getEntArray(self.script_noteworthy + "_rubble", "script_noteworthy");
  if(isDefined(rubble)) {
    for(x = 0; x < rubble.size; x++) {
      rubble[x] hide();
    }
  } else {
    println("^3Warning: No rubble found for magic box");
  }
}
show_rubble() {
  if(isDefined(self.chest_rubble)) {
    for(x = 0; x < self.chest_rubble.size; x++) {
      self.chest_rubble[x] show();
    }
  } else {
    println("^3Warning: No rubble found for magic box");
  }
}
set_treasure_chest_cost(cost) {
  level.zombie_treasure_chest_cost = cost;
}
get_chest_pieces() {
  self.chest_lid = GetEnt(self.target, "targetname");
  self.chest_origin = GetEnt(self.chest_lid.target, "targetname");
  self.chest_box = GetEnt(self.chest_origin.target, "targetname");
  self.chest_rubble = [];
  rubble = getEntArray(self.script_noteworthy + "_rubble", "script_noteworthy");
  for(i = 0; i < rubble.size; i++) {
    if(DistanceSquared(self.origin, rubble[i].origin) < 10000) {
      self.chest_rubble[self.chest_rubble.size] = rubble[i];
    }
  }
}
play_crazi_sound() {
  if(is_true(level.player_4_vox_override)) {
    self playlocalsound("zmb_laugh_rich");
  } else {
    self playlocalsound("zmb_laugh_child");
  }
}
show_chest() {
  self thread[[level.pandora_show_func]]();
  self enable_trigger();
  self.chest_lid show();
  self.chest_box show();
  self.chest_lid playSound("zmb_box_poof_land");
  self.chest_lid playSound("zmb_couch_slam");
  self.hidden = false;
  if(isDefined(self.box_hacks["summon_box"])) {
    self[[self.box_hacks["summon_box"]]](false);
  }
}
hide_chest() {
  self disable_trigger();
  self.chest_lid hide();
  self.chest_box hide();
  if(isDefined(self.pandora_light)) {
    self.pandora_light delete();
  }
  self.hidden = true;
  if(isDefined(self.box_hacks["summon_box"])) {
    self[[self.box_hacks["summon_box"]]](true);
  }
}
default_pandora_fx_func() {
  self.pandora_light = spawn("script_model", self.chest_origin.origin);
  self.pandora_light.angles = self.chest_origin.angles + (-90, 0, 0);
  self.pandora_light setModel("tag_origin");
  playFXOnTag(level._effect["lght_marker"], self.pandora_light, "tag_origin");
}
default_pandora_show_func(anchor, anchorTarget, pieces) {
  if(!isDefined(self.pandora_light)) {
    if(!isDefined(level.pandora_fx_func)) {
      level.pandora_fx_func = ::default_pandora_fx_func;
    }
    self thread[[level.pandora_fx_func]]();
  }
  playsoundatposition("zmb_box_poof", self.chest_lid.origin);
  wait(0.5);
  playFX(level._effect["lght_marker_flare"], self.pandora_light.origin);
}
treasure_chest_think() {
  self endon("kill_chest_think");
  if(isDefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"] && self[[level._zombiemode_check_firesale_loc_valid_func]]()) {
    self set_hint_string(self, "powerup_fire_sale_cost");
  } else {
    self set_hint_string(self, "default_treasure_chest_" + self.zombie_cost);
  }
  self setCursorHint("HINT_NOICON");
  user = undefined;
  user_cost = undefined;
  self.box_rerespun = undefined;
  self.weapon_out = undefined;
  while(1) {
    if(!isDefined(self.forced_user)) {
      self waittill("trigger", user);
    } else {
      user = self.forced_user;
    }
    if(user in_revive_trigger()) {
      wait(0.1);
      continue;
    }
    if(user is_drinking()) {
      wait(0.1);
      continue;
    }
    if(is_true(self.disabled)) {
      wait(0.1);
      continue;
    }
    if(user GetCurrentWeapon() == "none") {
      wait(0.1);
      continue;
    }
    if(isDefined(self.auto_open) && is_player_valid(user)) {
      if(!isDefined(self.no_charge)) {
        user maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);
        user_cost = self.zombie_cost;
      } else {
        user_cost = 0;
      }
      self.chest_user = user;
      break;
    } else if(is_player_valid(user) && user.score >= self.zombie_cost) {
      user maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);
      user_cost = self.zombie_cost;
      self.chest_user = user;
      break;
    } else if(user.score < self.zombie_cost) {
      user maps\_zombiemode_audio::create_and_play_dialog("general", "no_money", undefined, 2);
      continue;
    }
    wait 0.05;
  }
  flag_set("chest_has_been_used");
  self._box_open = true;
  self._box_opened_by_fire_sale = false;
  if(is_true(level.zombie_vars["zombie_powerup_fire_sale_on"]) && !isDefined(self.auto_open) && self[[level._zombiemode_check_firesale_loc_valid_func]]()) {
    self._box_opened_by_fire_sale = true;
  }
  self.chest_lid thread treasure_chest_lid_open();
  self.timedOut = false;
  self.weapon_out = true;
  self.chest_origin thread treasure_chest_weapon_spawn(self, user);
  self.chest_origin thread treasure_chest_glowfx();
  self disable_trigger();
  self.chest_origin waittill("randomization_done");
  if(flag("moving_chest_now") && !self._box_opened_by_fire_sale && isDefined(user_cost)) {
    user maps\_zombiemode_score::add_to_player_score(user_cost, false);
  }
  if(flag("moving_chest_now") && !level.zombie_vars["zombie_powerup_fire_sale_on"]) {
    self thread treasure_chest_move(self.chest_user);
  } else {
    self.grab_weapon_hint = true;
    self.chest_user = user;
    self sethintstring(&"ZOMBIE_TRADE_WEAPONS");
    self setCursorHint("HINT_NOICON");
    self thread decide_hide_show_hint("weapon_grabbed");
    self enable_trigger();
    self thread treasure_chest_timeout();
    while(1) {
      self waittill("trigger", grabber);
      self.weapon_out = undefined;
      if(isDefined(grabber.is_drinking) && grabber is_drinking()) {
        wait(0.1);
        continue;
      }
      if(grabber == user && user GetCurrentWeapon() == "none") {
        wait(0.1);
        continue;
      }
      if(grabber != level && (isDefined(self.box_rerespun) && self.box_rerespun)) {
        user = grabber;
      }
      if(grabber == user || grabber == level) {
        self.box_rerespun = undefined;
        current_weapon = "none";
        if(is_player_valid(user)) {
          current_weapon = user GetCurrentWeapon();
        }
        if(grabber == user && is_player_valid(user) && !user is_drinking() && !is_placeable_mine(current_weapon) && !is_equipment(current_weapon) && "syrette_sp" != current_weapon) {
          bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type magic_accept", user.playername, user.score, level.team_pool[user.team_num].score, level.round_number, self.zombie_cost, self.chest_origin.weapon_string, self.origin);
          self notify("user_grabbed_weapon");
          user thread treasure_chest_give_weapon(self.chest_origin.weapon_string);
          break;
        } else if(grabber == level) {
          unacquire_weapon_toggle(self.chest_origin.weapon_string);
          self.timedOut = true;
          if(is_player_valid(user)) {
            bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type magic_reject", user.playername, user.score, level.team_pool[user.team_num].score, level.round_number, self.zombie_cost, self.chest_origin.weapon_string, self.origin);
          }
          break;
        }
      }
      wait 0.05;
    }
    self.grab_weapon_hint = false;
    self.chest_origin notify("weapon_grabbed");
    if(!is_true(self._box_opened_by_fire_sale)) {
      level.chest_accessed += 1;
    }
    if(level.chest_moves > 0 && isDefined(level.pulls_since_last_ray_gun)) {
      level.pulls_since_last_ray_gun += 1;
    }
    if(isDefined(level.pulls_since_last_tesla_gun)) {
      level.pulls_since_last_tesla_gun += 1;
    }
    self disable_trigger();
    self.chest_lid thread treasure_chest_lid_close(self.timedOut);
    wait 3;
    if((is_true(level.zombie_vars["zombie_powerup_fire_sale_on"]) && self[[level._zombiemode_check_firesale_loc_valid_func]]()) || self == level.chests[level.chest_index]) {
      self enable_trigger();
      self setvisibletoall();
    }
  }
  self._box_open = false;
  self._box_opened_by_fire_sale = false;
  self.chest_user = undefined;
  self notify("chest_accessed");
  self thread treasure_chest_think();
}
decide_hide_show_chest_hint(endon_notify) {
  if(isDefined(endon_notify)) {
    self endon(endon_notify);
  }
  while(true) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if((isDefined(self.chest_user) && players[i] != self.chest_user) || !players[i] can_buy_weapon()) {
        self SetInvisibleToPlayer(players[i], true);
      } else {
        self SetInvisibleToPlayer(players[i], false);
      }
    }
    wait(0.1);
  }
}
weapon_show_hint_choke() {
  level._weapon_show_hint_choke = 0;
  while(1) {
    wait(0.05);
    level._weapon_show_hint_choke = 0;
  }
}
decide_hide_show_hint(endon_notify) {
  if(isDefined(endon_notify)) {
    self endon(endon_notify);
  }
  if(!isDefined(level._weapon_show_hint_choke)) {
    level thread weapon_show_hint_choke();
  }
  use_choke = false;
  if(isDefined(level._use_choke_weapon_hints) && level._use_choke_weapon_hints == 1) {
    use_choke = true;
  }
  while(true) {
    last_update = GetTime();
    if(isDefined(self.chest_user) && !isDefined(self.box_rerespun)) {
      if(is_placeable_mine(self.chest_user GetCurrentWeapon()) || self.chest_user hacker_active()) {
        self SetInvisibleToPlayer(self.chest_user);
      } else {
        self SetVisibleToPlayer(self.chest_user);
      }
    } else {
      players = get_players();
      for(i = 0; i < players.size; i++) {
        if(players[i] can_buy_weapon()) {
          self SetInvisibleToPlayer(players[i], false);
        } else {
          self SetInvisibleToPlayer(players[i], true);
        }
      }
    }
    if(use_choke) {
      while((level._weapon_show_hint_choke > 4) && (GetTime() < (last_update + 150))) {
        wait 0.05;
      }
    } else {
      wait(0.1);
    }
    level._weapon_show_hint_choke++;
  }
}
can_buy_weapon() {
  if(isDefined(self.is_drinking) && self is_drinking()) {
    return false;
  }
  if(self hacker_active()) {
    return false;
  }
  current_weapon = self GetCurrentWeapon();
  if(is_placeable_mine(current_weapon) || is_equipment(current_weapon)) {
    return false;
  }
  if(self in_revive_trigger()) {
    return false;
  }
  if(current_weapon == "none") {
    return false;
  }
  return true;
}
default_box_move_logic() {
  index = -1;
  for(i = 0; i < level.chests.size; i++) {
    if(IsSubStr(level.chests[i].script_noteworthy, ("move" + (level.chest_moves + 1))) &&
      i != level.chest_index) {
      index = i;
      break;
    }
  }
  if(index != -1) {
    level.chest_index = index;
  } else {
    level.chest_index++;
  }
  if(level.chest_index >= level.chests.size) {
    temp_chest_name = level.chests[level.chest_index - 1].script_noteworthy;
    level.chest_index = 0;
    level.chests = array_randomize(level.chests);
    if(temp_chest_name == level.chests[level.chest_index].script_noteworthy) {
      level.chest_index++;
    }
  }
}
treasure_chest_move(player_vox) {
  level waittill("weapon_fly_away_start");
  players = get_players();
  array_thread(players, ::play_crazi_sound);
  level waittill("weapon_fly_away_end");
  self.chest_lid thread treasure_chest_lid_close(false);
  self setvisibletoall();
  self hide_chest();
  fake_pieces = [];
  fake_pieces[0] = spawn("script_model", self.chest_lid.origin);
  fake_pieces[0].angles = self.chest_lid.angles;
  fake_pieces[0] setModel(self.chest_lid.model);
  fake_pieces[1] = spawn("script_model", self.chest_box.origin);
  fake_pieces[1].angles = self.chest_box.angles;
  fake_pieces[1] setModel(self.chest_box.model);
  anchor = spawn("script_origin", fake_pieces[0].origin);
  soundpoint = spawn("script_origin", self.chest_origin.origin);
  anchor playSound("zmb_box_move");
  for(i = 0; i < fake_pieces.size; i++) {
    fake_pieces[i] linkto(anchor);
  }
  playsoundatposition("zmb_whoosh", soundpoint.origin);
  if(is_true(level.player_4_vox_override)) {
    playsoundatposition("zmb_vox_rich_magicbox", soundpoint.origin);
  } else {
    playsoundatposition("zmb_vox_ann_magicbox", soundpoint.origin);
  }
  anchor moveto(anchor.origin + (0, 0, 50), 5);
  if(isDefined(level.custom_vibrate_func)) {
    [[level.custom_vibrate_func]](anchor);
  } else {
    direction = self.chest_box.origin - self.chest_lid.origin;
    direction = (direction[1], direction[0], 0);
    if(direction[1] < 0 || (direction[0] > 0 && direction[1] > 0)) {
      direction = (direction[0], direction[1] * -1, 0);
    } else if(direction[0] < 0) {
      direction = (direction[0] * -1, direction[1], 0);
    }
    anchor Vibrate(direction, 10, 0.5, 5);
  }
  anchor waittill("movedone");
  playFX(level._effect["poltergeist"], self.chest_origin.origin);
  playsoundatposition("zmb_box_poof", soundpoint.origin);
  for(i = 0; i < fake_pieces.size; i++) {
    fake_pieces[i] delete();
  }
  self show_rubble();
  wait(0.1);
  anchor delete();
  soundpoint delete();
  post_selection_wait_duration = 7;
  if(isDefined(player_vox)) {
    player_vox maps\_zombiemode_audio::create_and_play_dialog("general", "box_move");
  }
  if(level.zombie_vars["zombie_powerup_fire_sale_on"] == true && self[[level._zombiemode_check_firesale_loc_valid_func]]()) {
    current_sale_time = level.zombie_vars["zombie_powerup_fire_sale_time"];
    wait_network_frame();
    self thread fire_sale_fix();
    level.zombie_vars["zombie_powerup_fire_sale_time"] = current_sale_time;
    while(level.zombie_vars["zombie_powerup_fire_sale_time"] > 0) {
      wait(0.1);
    }
  } else {
    post_selection_wait_duration += 5;
  }
  level.verify_chest = false;
  if(isDefined(level._zombiemode_custom_box_move_logic)) {
    [[level._zombiemode_custom_box_move_logic]]();
  } else {
    default_box_move_logic();
  }
  if(isDefined(level.chests[level.chest_index].box_hacks["summon_box"])) {
    level.chests[level.chest_index][[level.chests[level.chest_index].box_hacks["summon_box"]]](false);
  }
  wait(post_selection_wait_duration);
  playFX(level._effect["poltergeist"], level.chests[level.chest_index].chest_origin.origin);
  level.chests[level.chest_index] show_chest();
  level.chests[level.chest_index] hide_rubble();
  flag_clear("moving_chest_now");
  self.chest_origin.chest_moving = false;
}
fire_sale_fix() {
  if(!isDefined(level.zombie_vars["zombie_powerup_fire_sale_on"])) {
    return;
  }
  if(level.zombie_vars["zombie_powerup_fire_sale_on"]) {
    self.old_cost = 950;
    self thread show_chest();
    self thread hide_rubble();
    self.zombie_cost = 10;
    self set_hint_string(self, "powerup_fire_sale_cost");
    wait_network_frame();
    level waittill("fire_sale_off");
    while(is_true(self._box_open)) {
      wait(.1);
    }
    playFX(level._effect["poltergeist"], self.origin);
    self playSound("zmb_box_poof_land");
    self playSound("zmb_couch_slam");
    self thread hide_chest();
    self thread show_rubble();
    self.zombie_cost = self.old_cost;
    self set_hint_string(self, "default_treasure_chest_" + self.zombie_cost);
  }
}
check_for_desirable_chest_location() {
  if(!isDefined(level.desirable_chest_location)) {
    return level.chest_index;
  }
  if(level.chests[level.chest_index].script_noteworthy == level.desirable_chest_location) {
    level.desirable_chest_location = undefined;
    return level.chest_index;
  }
  for(i = 0; i < level.chests.size; i++) {
    if(level.chests[i].script_noteworthy == level.desirable_chest_location) {
      level.desirable_chest_location = undefined;
      return i;
    }
  }
  level.desirable_chest_location = undefined;
  return level.chest_index;
}
rotateroll_box() {
  angles = 40;
  angles2 = 0;
  while(isDefined(self)) {
    self RotateRoll(angles + angles2, 0.5);
    wait(0.7);
    angles2 = 40;
    self RotateRoll(angles * -2, 0.5);
    wait(0.7);
  }
}
verify_chest_is_open() {
  for(i = 0; i < level.open_chest_location.size; i++) {
    if(isDefined(level.open_chest_location[i])) {
      if(level.open_chest_location[i] == level.chests[level.chest_index].script_noteworthy) {
        level.verify_chest = true;
        return;
      }
    }
  }
  level.verify_chest = false;
}
treasure_chest_timeout() {
  self endon("user_grabbed_weapon");
  self.chest_origin endon("box_hacked_respin");
  self.chest_origin endon("box_hacked_rerespin");
  wait(12);
  self notify("trigger", level);
}
treasure_chest_lid_open() {
  openRoll = 105;
  openTime = 0.5;
  self RotateRoll(105, openTime, (openTime * 0.5));
  play_sound_at_pos("open_chest", self.origin);
  play_sound_at_pos("music_chest", self.origin);
}
treasure_chest_lid_close(timedOut) {
  closeRoll = -105;
  closeTime = 0.5;
  self RotateRoll(closeRoll, closeTime, (closeTime * 0.5));
  play_sound_at_pos("close_chest", self.origin);
  self notify("lid_closed");
}
treasure_chest_ChooseRandomWeapon(player) {
  keys = GetArrayKeys(level.zombie_weapons);
  return keys[RandomInt(keys.size)];
}
treasure_chest_ChooseWeightedRandomWeapon(player) {
  keys = GetArrayKeys(level.zombie_weapons);
  toggle_weapons_in_use = 0;
  filtered = [];
  for(i = 0; i < keys.size; i++) {
    if(!get_is_in_box(keys[i])) {
      continue;
    }
    if(isDefined(player) && is_player_valid(player) && player has_weapon_or_upgrade(keys[i])) {
      if(is_weapon_toggle(keys[i])) {
        toggle_weapons_in_use++;
      }
      continue;
    }
    if(!isDefined(keys[i])) {
      continue;
    }
    num_entries = [[level.weapon_weighting_funcs[keys[i]]]]();
    for(j = 0; j < num_entries; j++) {
      filtered[filtered.size] = keys[i];
    }
  }
  if(isDefined(level.limited_weapons)) {
    keys2 = GetArrayKeys(level.limited_weapons);
    players = get_players();
    pap_triggers = getEntArray("zombie_vending_upgrade", "targetname");
    for(q = 0; q < keys2.size; q++) {
      count = 0;
      for(i = 0; i < players.size; i++) {
        if(players[i] has_weapon_or_upgrade(keys2[q])) {
          count++;
        }
      }
      for(k = 0; k < pap_triggers.size; k++) {
        if(isDefined(pap_triggers[k].current_weapon) && pap_triggers[k].current_weapon == keys2[q]) {
          count++;
        }
      }
      for(chestIndex = 0; chestIndex < level.chests.size; chestIndex++) {
        if(isDefined(level.chests[chestIndex].chest_origin.weapon_string) && level.chests[chestIndex].chest_origin.weapon_string == keys2[q]) {
          count++;
        }
      }
      if(isDefined(level.random_weapon_powerups)) {
        for(powerupIndex = 0; powerupIndex < level.random_weapon_powerups.size; powerupIndex++) {
          if(isDefined(level.random_weapon_powerups[powerupIndex]) && level.random_weapon_powerups[powerupIndex].base_weapon == keys2[q]) {
            count++;
          }
        }
      }
      if(is_weapon_toggle(keys2[q])) {
        toggle_weapons_in_use += count;
      }
      if(count >= level.limited_weapons[keys2[q]]) {
        filtered = array_remove(filtered, keys2[q]);
      }
    }
  }
  if(isDefined(level.zombie_weapon_toggles)) {
    keys2 = GetArrayKeys(level.zombie_weapon_toggles);
    for(q = 0; q < keys2.size; q++) {
      if(level.zombie_weapon_toggles[keys2[q]].active) {
        if(toggle_weapons_in_use < level.zombie_weapon_toggle_max_active_count) {
          continue;
        }
      }
      filtered = array_remove(filtered, keys2[q]);
    }
  }
  filtered = array_randomize(filtered);
  return filtered[RandomInt(filtered.size)];
}
weapon_is_dual_wield(name) {
  switch (name) {
    case "cz75dw_zm":
    case "cz75dw_upgraded_zm":
    case "m1911_upgraded_zm":
    case "hs10_upgraded_zm":
    case "pm63_upgraded_zm":
    case "microwavegundw_zm":
    case "microwavegundw_upgraded_zm":
      return true;
    default:
      return false;
  }
}
get_left_hand_weapon_model_name(name) {
  switch (name) {
    case "microwavegundw_zm":
      return GetWeaponModel("microwavegunlh_zm");
    case "microwavegundw_upgraded_zm":
      return GetWeaponModel("microwavegunlh_upgraded_zm");
    default:
      return GetWeaponModel(name);
  }
}
clean_up_hacked_box() {
  self waittill("box_hacked_respin");
  self endon("box_spin_done");
  if(isDefined(self.weapon_model)) {
    self.weapon_model Delete();
    self.weapon_model = undefined;
  }
  if(isDefined(self.weapon_model_dw)) {
    self.weapon_model_dw Delete();
    self.weapon_model_dw = undefined;
  }
}
treasure_chest_weapon_spawn(chest, player, respin) {
  self endon("box_hacked_respin");
  self thread clean_up_hacked_box();
  assert(isDefined(player));
  self.weapon_string = undefined;
  modelname = undefined;
  rand = undefined;
  number_cycles = 40;
  chest.chest_box setclientflag(level._ZOMBIE_SCRIPTMOVER_FLAG_BOX_RANDOM);
  for(i = 0; i < number_cycles; i++) {
    if(i < 20) {
      wait(0.05);
    } else if(i < 30) {
      wait(0.1);
    } else if(i < 35) {
      wait(0.2);
    } else if(i < 38) {
      wait(0.3);
    }
    if(i + 1 < number_cycles) {
      rand = treasure_chest_ChooseRandomWeapon(player);
    } else {
      rand = treasure_chest_ChooseWeightedRandomWeapon(player);
    }
  }
  self.weapon_string = rand;
  chest.chest_box clearclientflag(level._ZOMBIE_SCRIPTMOVER_FLAG_BOX_RANDOM);
  wait_network_frame();
  floatHeight = 40;
  self.model_dw = undefined;
  self.weapon_model = spawn("script_model", self.origin + (0, 0, floatHeight));
  self.weapon_model.angles = self.angles + (0, 90, 0);
  modelname = GetWeaponModel(rand);
  self.weapon_model setModel(modelname);
  self.weapon_model useweaponhidetags(rand);
  if(weapon_is_dual_wield(rand)) {
    self.weapon_model_dw = spawn("script_model", self.weapon_model.origin - (3, 3, 3));
    self.weapon_model_dw.angles = self.angles + (0, 90, 0);
    self.weapon_model_dw setModel(get_left_hand_weapon_model_name(rand));
    self.weapon_model_dw useweaponhidetags(rand);
  }
  if((getDvar(#"magic_chest_movable") == "1") && !is_true(chest._box_opened_by_fire_sale) && !(is_true(level.zombie_vars["zombie_powerup_fire_sale_on"]) && self[[level._zombiemode_check_firesale_loc_valid_func]]())) {
    random = Randomint(100);
    if(!isDefined(level.chest_min_move_usage)) {
      level.chest_min_move_usage = 4;
    }
    if(level.chest_accessed < level.chest_min_move_usage) {
      chance_of_joker = -1;
    } else {
      chance_of_joker = level.chest_accessed + 20;
      if(level.chest_moves == 0 && level.chest_accessed >= 8) {
        chance_of_joker = 100;
      }
      if(level.chest_accessed >= 4 && level.chest_accessed < 8) {
        if(random < 15) {
          chance_of_joker = 100;
        } else {
          chance_of_joker = -1;
        }
      }
      if(level.chest_moves > 0) {
        if(level.chest_accessed >= 8 && level.chest_accessed < 13) {
          if(random < 30) {
            chance_of_joker = 100;
          } else {
            chance_of_joker = -1;
          }
        }
        if(level.chest_accessed >= 13) {
          if(random < 50) {
            chance_of_joker = 100;
          } else {
            chance_of_joker = -1;
          }
        }
      }
    }
    if(isDefined(chest.no_fly_away)) {
      chance_of_joker = -1;
    }
    if(isDefined(level._zombiemode_chest_joker_chance_mutator_func)) {
      chance_of_joker = [[level._zombiemode_chest_joker_chance_mutator_func]](chance_of_joker);
    }
    if(chance_of_joker > random) {
      self.weapon_string = undefined;
      self.weapon_model setModel("zombie_teddybear");
      self.weapon_model.angles = self.angles;
      if(isDefined(self.weapon_model_dw)) {
        self.weapon_model_dw Delete();
        self.weapon_model_dw = undefined;
      }
      self.chest_moving = true;
      flag_set("moving_chest_now");
      level.chest_accessed = 0;
      level.chest_moves++;
    }
  }
  self notify("randomization_done");
  if(flag("moving_chest_now") && !(level.zombie_vars["zombie_powerup_fire_sale_on"] && self[[level._zombiemode_check_firesale_loc_valid_func]]())) {
    wait .5;
    level notify("weapon_fly_away_start");
    wait 2;
    self.weapon_model MoveZ(500, 4, 3);
    if(isDefined(self.weapon_model_dw)) {
      self.weapon_model_dw MoveZ(500, 4, 3);
    }
    self.weapon_model waittill("movedone");
    self.weapon_model delete();
    if(isDefined(self.weapon_model_dw)) {
      self.weapon_model_dw Delete();
      self.weapon_model_dw = undefined;
    }
    self notify("box_moving");
    level notify("weapon_fly_away_end");
  } else {
    acquire_weapon_toggle(rand, player);
    if(rand == "tesla_gun_zm" || rand == "ray_gun_zm") {
      if(rand == "ray_gun_zm") {
        level.pulls_since_last_ray_gun = 0;
      }
      if(rand == "tesla_gun_zm") {
        level.pulls_since_last_tesla_gun = 0;
        level.player_seen_tesla_gun = true;
      }
    }
    if(!isDefined(respin)) {
      if(isDefined(chest.box_hacks["respin"])) {
        self[[chest.box_hacks["respin"]]](chest, player);
      }
    } else {
      if(isDefined(chest.box_hacks["respin_respin"])) {
        self[[chest.box_hacks["respin_respin"]]](chest, player);
      }
    }
    self.weapon_model thread timer_til_despawn(floatHeight);
    if(isDefined(self.weapon_model_dw)) {
      self.weapon_model_dw thread timer_til_despawn(floatHeight);
    }
    self waittill("weapon_grabbed");
    if(!chest.timedOut) {
      if(isDefined(self.weapon_model)) {
        self.weapon_model Delete();
      }
      if(isDefined(self.weapon_model_dw)) {
        self.weapon_model_dw Delete();
      }
    }
  }
  self.weapon_string = undefined;
  self notify("box_spin_done");
}
chest_get_min_usage() {
  min_usage = 4;
  return (min_usage);
}
chest_get_max_usage() {
  max_usage = 6;
  players = get_players();
  if(level.chest_moves == 0) {
    if(players.size == 1) {
      max_usage = 3;
    } else if(players.size == 2) {
      max_usage = 4;
    } else if(players.size == 3) {
      max_usage = 5;
    } else {
      max_usage = 6;
    }
  } else {
    if(players.size == 1) {
      max_usage = 4;
    } else if(players.size == 2) {
      max_usage = 4;
    } else if(players.size == 3) {
      max_usage = 5;
    } else {
      max_usage = 7;
    }
  }
  return (max_usage);
}
timer_til_despawn(floatHeight) {
  self endon("kill_weapon_movement");
  putBackTime = 12;
  self MoveTo(self.origin - (0, 0, floatHeight), putBackTime, (putBackTime * 0.5));
  wait(putBackTime);
  if(isDefined(self)) {
    self Delete();
  }
}
treasure_chest_glowfx() {
  fxObj = spawn("script_model", self.origin + (0, 0, 0));
  fxobj setModel("tag_origin");
  fxobj.angles = self.angles + (90, 0, 0);
  playFXOnTag(level._effect["chest_light"], fxObj, "tag_origin");
  self waittill_any("weapon_grabbed", "box_moving");
  fxobj delete();
}
treasure_chest_give_weapon(weapon_string) {
  self.last_box_weapon = GetTime();
  primaryWeapons = self GetWeaponsListPrimaries();
  current_weapon = undefined;
  weapon_limit = 2;
  if(self HasWeapon(weapon_string)) {
    if(issubstr(weapon_string, "knife_ballistic_")) {
      self notify("zmb_lost_knife");
    }
    self GiveStartAmmo(weapon_string);
    self SwitchToWeapon(weapon_string);
    return;
  }
  if(self HasPerk("specialty_additionalprimaryweapon")) {
    weapon_limit = 3;
  }
  if(primaryWeapons.size >= weapon_limit) {
    current_weapon = self getCurrentWeapon();
    if(is_placeable_mine(current_weapon) || is_equipment(current_weapon)) {
      current_weapon = undefined;
    }
    if(isDefined(current_weapon)) {
      if(!is_offhand_weapon(weapon_string)) {
        if(current_weapon == "tesla_gun_zm") {
          level.player_drops_tesla_gun = true;
        }
        if(issubstr(current_weapon, "knife_ballistic_")) {
          self notify("zmb_lost_knife");
        }
        self TakeWeapon(current_weapon);
        unacquire_weapon_toggle(current_weapon);
        if(current_weapon == "m1911_zm") {
          self.last_pistol_swap = GetTime();
        }
      }
    }
  }
  self play_sound_on_ent("purchase");
  if(isDefined(level.zombiemode_offhand_weapon_give_override)) {
    self[[level.zombiemode_offhand_weapon_give_override]](weapon_string);
  }
  if(weapon_string == "zombie_cymbal_monkey") {
    self maps\_zombiemode_weap_cymbal_monkey::player_give_cymbal_monkey();
    self play_weapon_vo(weapon_string);
    return;
  } else if(weapon_string == "knife_ballistic_zm" && self HasWeapon("bowie_knife_zm")) {
    weapon_string = "knife_ballistic_bowie_zm";
  } else if(weapon_string == "knife_ballistic_zm" && self HasWeapon("sickle_knife_zm")) {
    weapon_string = "knife_ballistic_sickle_zm";
  }
  if(weapon_string == "ray_gun_zm") {
    playsoundatposition("mus_raygun_stinger", (0, 0, 0));
  }
  self GiveWeapon(weapon_string, 0);
  self GiveStartAmmo(weapon_string);
  self SwitchToWeapon(weapon_string);
  self play_weapon_vo(weapon_string);
}
pay_turret_think(cost) {
  if(!isDefined(self.target)) {
    return;
  }
  turret = GetEnt(self.target, "targetname");
  if(!isDefined(turret)) {
    return;
  }
  turret makeTurretUnusable();
  zone_name = turret get_current_zone();
  if(!isDefined(zone_name)) {
    zone_name = "";
  }
  while(true) {
    self waittill("trigger", player);
    if(!is_player_valid(player)) {
      player thread ignore_triggers(0.5);
      continue;
    }
    if(player in_revive_trigger()) {
      wait(0.1);
      continue;
    }
    if(player is_drinking()) {
      wait(0.1);
      continue;
    }
    if(player.score >= cost) {
      player maps\_zombiemode_score::minus_to_player_score(cost);
      bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type turret", player.playername, player.score, level.team_pool[player.team_num].score, level.round_number, cost, zone_name, self.origin);
      turret makeTurretUsable();
      turret UseBy(player);
      self disable_trigger();
      player maps\_zombiemode_audio::create_and_play_dialog("weapon_pickup", "mg");
      player.curr_pay_turret = turret;
      turret thread watch_for_laststand(player);
      turret thread watch_for_fake_death(player);
      if(isDefined(level.turret_timer)) {
        turret thread watch_for_timeout(player, level.turret_timer);
      }
      while(isDefined(turret getTurretOwner()) && turret getTurretOwner() == player) {
        wait(0.05);
      }
      turret notify("stop watching");
      player.curr_pay_turret = undefined;
      turret makeTurretUnusable();
      self enable_trigger();
    } else {
      play_sound_on_ent("no_purchase");
      player maps\_zombiemode_audio::create_and_play_dialog("general", "no_money", undefined, 0);
    }
  }
}
watch_for_laststand(player) {
  self endon("stop watching");
  while(!player maps\_laststand::player_is_in_laststand()) {
    if(isDefined(level.intermission) && level.intermission) {
      intermission = true;
    }
    wait(0.05);
  }
  if(isDefined(self getTurretOwner()) && self getTurretOwner() == player) {
    self UseBy(player);
  }
}
watch_for_fake_death(player) {
  self endon("stop watching");
  player waittill("fake_death");
  if(isDefined(self getTurretOwner()) && self getTurretOwner() == player) {
    self UseBy(player);
  }
}
watch_for_timeout(player, time) {
  self endon("stop watching");
  self thread cancel_timer_on_end(player);
  wait(time);
  if(isDefined(self getTurretOwner()) && self getTurretOwner() == player) {
    self UseBy(player);
  }
}
cancel_timer_on_end(player) {
  self waittill("stop watching");
  player notify("stop watching");
}
weapon_cabinet_door_open(left_or_right) {
  if(left_or_right == "left") {
    self rotateyaw(120, 0.3, 0.2, 0.1);
  } else if(left_or_right == "right") {
    self rotateyaw(-120, 0.3, 0.2, 0.1);
  }
}
check_collector_achievement(bought_weapon) {
  if(!isDefined(self.bought_weapons)) {
    self.bought_weapons = [];
    self.bought_weapons = array_add(self.bought_weapons, bought_weapon);
  } else if(!is_in_array(self.bought_weapons, bought_weapon)) {
    self.bought_weapons = array_add(self.bought_weapons, bought_weapon);
  } else {
    return;
  }
  for(i = 0; i < level.collector_achievement_weapons.size; i++) {
    if(!is_in_array(self.bought_weapons, level.collector_achievement_weapons[i])) {
      return;
    }
  }
  self giveachievement_wrapper("SP_ZOM_COLLECTOR");
}
weapon_set_first_time_hint(cost, ammo_cost) {
  if(isDefined(level.has_pack_a_punch) && !level.has_pack_a_punch) {
    self SetHintString(&"ZOMBIE_WEAPONCOSTAMMO", cost, ammo_cost);
  } else {
    self SetHintString(&"ZOMBIE_WEAPONCOSTAMMO_UPGRADE", cost, ammo_cost);
  }
}
weapon_spawn_think() {
  cost = get_weapon_cost(self.zombie_weapon_upgrade);
  ammo_cost = get_ammo_cost(self.zombie_weapon_upgrade);
  is_grenade = (WeaponType(self.zombie_weapon_upgrade) == "grenade");
  self thread decide_hide_show_hint();
  self.first_time_triggered = false;
  for(;;) {
    self waittill("trigger", player);
    if(!is_player_valid(player)) {
      player thread ignore_triggers(0.5);
      continue;
    }
    if(!player can_buy_weapon()) {
      wait(0.1);
      continue;
    }
    if(player has_powerup_weapon()) {
      wait(0.1);
      continue;
    }
    player_has_weapon = player has_weapon_or_upgrade(self.zombie_weapon_upgrade);
    if(!player_has_weapon) {
      if(player.score >= cost) {
        if(self.first_time_triggered == false) {
          model = getent(self.target, "targetname");
          model thread weapon_show(player);
          self.first_time_triggered = true;
          if(!is_grenade) {
            self weapon_set_first_time_hint(cost, ammo_cost);
          }
        }
        player maps\_zombiemode_score::minus_to_player_score(cost);
        bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type weapon", player.playername, player.score, level.team_pool[player.team_num].score, level.round_number, cost, self.zombie_weapon_upgrade, self.origin);
        if(is_lethal_grenade(self.zombie_weapon_upgrade)) {
          player takeweapon(player get_player_lethal_grenade());
          player set_player_lethal_grenade(self.zombie_weapon_upgrade);
        }
        player weapon_give(self.zombie_weapon_upgrade);
        player check_collector_achievement(self.zombie_weapon_upgrade);
      } else {
        play_sound_on_ent("no_purchase");
        player maps\_zombiemode_audio::create_and_play_dialog("general", "no_money", undefined, 1);
      }
    } else {
      if(isDefined(self.hacked) && self.hacked) {
        if(!player has_upgrade(self.zombie_weapon_upgrade)) {
          ammo_cost = 4500;
        } else {
          ammo_cost = get_ammo_cost(self.zombie_weapon_upgrade);
        }
      } else {
        if(player has_upgrade(self.zombie_weapon_upgrade)) {
          ammo_cost = 4500;
        } else {
          ammo_cost = get_ammo_cost(self.zombie_weapon_upgrade);
        }
      }
      if(player.score >= ammo_cost) {
        if(self.first_time_triggered == false) {
          model = getent(self.target, "targetname");
          model thread weapon_show(player);
          self.first_time_triggered = true;
          if(!is_grenade) {
            self weapon_set_first_time_hint(cost, get_ammo_cost(self.zombie_weapon_upgrade));
          }
        }
        player check_collector_achievement(self.zombie_weapon_upgrade);
        if(player has_upgrade(self.zombie_weapon_upgrade)) {
          ammo_given = player ammo_give(level.zombie_weapons[self.zombie_weapon_upgrade].upgrade_name);
        } else {
          ammo_given = player ammo_give(self.zombie_weapon_upgrade);
        }
        if(ammo_given) {
          player maps\_zombiemode_score::minus_to_player_score(ammo_cost);
          bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type ammo", player.playername, player.score, level.team_pool[player.team_num].score, level.round_number, ammo_cost, self.zombie_weapon_upgrade, self.origin);
        }
      } else {
        play_sound_on_ent("no_purchase");
        player maps\_zombiemode_audio::create_and_play_dialog("general", "no_money", undefined, 0);
      }
    }
  }
}
weapon_show(player) {
  player_angles = VectorToAngles(player.origin - self.origin);
  player_yaw = player_angles[1];
  weapon_yaw = self.angles[1];
  if(isDefined(self.script_int)) {
    weapon_yaw -= self.script_int;
  }
  yaw_diff = AngleClamp180(player_yaw - weapon_yaw);
  if(yaw_diff > 0) {
    yaw = weapon_yaw - 90;
  } else {
    yaw = weapon_yaw + 90;
  }
  self.og_origin = self.origin;
  self.origin = self.origin + (anglesToForward((0, yaw, 0)) * 8);
  wait(0.05);
  self Show();
  play_sound_at_pos("weapon_show", self.origin, self);
  time = 1;
  self MoveTo(self.og_origin, time);
}
get_pack_a_punch_weapon_options(weapon) {
  if(!isDefined(self.pack_a_punch_weapon_options)) {
    self.pack_a_punch_weapon_options = [];
  }
  if(!is_weapon_upgraded(weapon)) {
    return self CalcWeaponOptions(0);
  }
  if(isDefined(self.pack_a_punch_weapon_options[weapon])) {
    return self.pack_a_punch_weapon_options[weapon];
  }
  smiley_face_reticle_index = 21;
  camo_index = 15;
  lens_index = randomIntRange(0, 6);
  reticle_index = randomIntRange(0, smiley_face_reticle_index);
  reticle_color_index = randomIntRange(0, 6);
  if("famas_upgraded_zm" == weapon) {
    reticle_index = smiley_face_reticle_index;
  }
  scary_eyes_reticle_index = 8;
  purple_reticle_color_index = 3;
  if(reticle_index == scary_eyes_reticle_index) {
    reticle_color_index = purple_reticle_color_index;
  }
  letter_a_reticle_index = 2;
  pink_reticle_color_index = 6;
  if(reticle_index == letter_a_reticle_index) {
    reticle_color_index = pink_reticle_color_index;
  }
  letter_e_reticle_index = 7;
  green_reticle_color_index = 1;
  if(reticle_index == letter_e_reticle_index) {
    reticle_color_index = green_reticle_color_index;
  }
  self.pack_a_punch_weapon_options[weapon] = self CalcWeaponOptions(camo_index, lens_index, reticle_index, reticle_color_index);
  return self.pack_a_punch_weapon_options[weapon];
}
weapon_give(weapon, is_upgrade) {
  primaryWeapons = self GetWeaponsListPrimaries();
  current_weapon = undefined;
  weapon_limit = 2;
  if(!isDefined(is_upgrade)) {
    is_upgrade = false;
  }
  if(self HasPerk("specialty_additionalprimaryweapon")) {
    weapon_limit = 3;
  }
  if(primaryWeapons.size >= weapon_limit) {
    current_weapon = self getCurrentWeapon();
    if(is_placeable_mine(current_weapon) || is_equipment(current_weapon)) {
      current_weapon = undefined;
    }
    if(isDefined(current_weapon)) {
      if(!is_offhand_weapon(weapon)) {
        if(issubstr(current_weapon, "knife_ballistic_")) {
          self notify("zmb_lost_knife");
        }
        self TakeWeapon(current_weapon);
        unacquire_weapon_toggle(current_weapon);
        if(current_weapon == "m1911_zm") {
          self.last_pistol_swap = GetTime();
        }
      }
    }
  }
  if(isDefined(level.zombiemode_offhand_weapon_give_override)) {
    if(self[[level.zombiemode_offhand_weapon_give_override]](weapon)) {
      return;
    }
  }
  if(weapon == "zombie_cymbal_monkey") {
    self maps\_zombiemode_weap_cymbal_monkey::player_give_cymbal_monkey();
    self play_weapon_vo(weapon);
    return;
  }
  self play_sound_on_ent("purchase");
  if(!is_weapon_upgraded(weapon)) {
    self GiveWeapon(weapon);
  } else {
    self GiveWeapon(weapon, 0, self get_pack_a_punch_weapon_options(weapon));
  }
  acquire_weapon_toggle(weapon, self);
  self GiveStartAmmo(weapon);
  self SwitchToWeapon(weapon);
  self play_weapon_vo(weapon);
}
play_weapon_vo(weapon) {
  if(isDefined(level._audio_custom_weapon_check)) {
    type = self[[level._audio_custom_weapon_check]](weapon);
  } else {
    type = self weapon_type_check(weapon);
  }
  self maps\_zombiemode_audio::create_and_play_dialog("weapon_pickup", type);
}
weapon_type_check(weapon) {
  if(!isDefined(self.entity_num)) {
    return "crappy";
  }
  switch (self.entity_num) {
    case 0:
      if(weapon == "m16_zm") {
        return "favorite";
      } else if(weapon == "rottweil72_upgraded_zm") {
        return "favorite_upgrade";
      }
      break;
    case 1:
      if(weapon == "fnfal_zm") {
        return "favorite";
      } else if(weapon == "hk21_upgraded_zm") {
        return "favorite_upgrade";
      }
      break;
    case 2:
      if(weapon == "china_lake_zm") {
        return "favorite";
      } else if(weapon == "thundergun_upgraded_zm") {
        return "favorite_upgrade";
      }
      break;
    case 3:
      if(weapon == "mp40_zm") {
        return "favorite";
      } else if(weapon == "crossbow_explosive_upgraded_zm") {
        return "favorite_upgrade";
      }
      break;
  }
  if(IsSubStr(weapon, "upgraded")) {
    return "upgrade";
  } else {
    return level.zombie_weapons[weapon].vox;
  }
}
get_player_index(player) {
  assert(isPlayer(player));
  assert(isDefined(player.entity_num));
  return player.entity_num;
}
ammo_give(weapon) {
  give_ammo = false;
  if(!is_offhand_weapon(weapon)) {
    if(isDefined(weapon)) {
      stockMax = 0;
      stockMax = WeaponStartAmmo(weapon);
      clipCount = self GetWeaponAmmoClip(weapon);
      currStock = self GetAmmoCount(weapon);
      if((currStock - clipcount) >= stockMax) {
        give_ammo = false;
      } else {
        give_ammo = true;
      }
    }
  } else {
    if(self has_weapon_or_upgrade(weapon)) {
      if(self getammocount(weapon) < WeaponMaxAmmo(weapon)) {
        give_ammo = true;
      }
    }
  }
  if(give_ammo) {
    self play_sound_on_ent("purchase");
    self GiveStartAmmo(weapon);
    return true;
  }
  if(!give_ammo) {
    return false;
  }
}