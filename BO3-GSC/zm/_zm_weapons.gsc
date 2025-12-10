/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weapons.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#using scripts\zm\_bb;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_placeable_mine;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_ballistic_knife;
#using scripts\zm\gametypes\_weapons;
#namespace zm_weapons;

function init() {
  if(!isDefined(level.pack_a_punch_camo_index)) {
    level.pack_a_punch_camo_index = 42;
  }
  if(!isDefined(level.weapon_cost_client_filled)) {
    level.weapon_cost_client_filled = 1;
  }
  if(!isDefined(level.obsolete_prompt_format_needed)) {
    level.obsolete_prompt_format_needed = 0;
  }
  init_weapons();
  init_weapon_upgrade();
  level._weaponobjects_on_player_connect_override = &weaponobjects_on_player_connect_override;
  level._zombiemode_check_firesale_loc_valid_func = &default_check_firesale_loc_valid_func;
  level.missileentities = [];
  level thread onplayerconnect();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread onplayerspawned();
  }
}

function onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    self thread watchforgrenadeduds();
    self thread watchforgrenadelauncherduds();
    self.staticweaponsstarttime = gettime();
  }
}

function watchforgrenadeduds() {
  self endon("spawned_player");
  self endon("disconnect");
  while(true) {
    self waittill("grenade_fire", grenade, weapon);
    if(!zm_equipment::is_equipment(weapon) && !zm_utility::is_placeable_mine(weapon)) {
      grenade thread checkgrenadefordud(weapon, 1, self);
      grenade thread watchforscriptexplosion(weapon, 1, self);
    }
  }
}

function watchforgrenadelauncherduds() {
  self endon("spawned_player");
  self endon("disconnect");
  while(true) {
    self waittill("grenade_launcher_fire", grenade, weapon);
    grenade thread checkgrenadefordud(weapon, 0, self);
    grenade thread watchforscriptexplosion(weapon, 0, self);
  }
}

function grenade_safe_to_throw(player, weapon) {
  if(isDefined(level.grenade_safe_to_throw)) {
    return self[[level.grenade_safe_to_throw]](player, weapon);
  }
  return 1;
}

function grenade_safe_to_bounce(player, weapon) {
  if(isDefined(level.grenade_safe_to_bounce)) {
    return self[[level.grenade_safe_to_bounce]](player, weapon);
  }
  return 1;
}

function makegrenadedudanddestroy() {
  self endon("death");
  self notify("grenade_dud");
  self makegrenadedud();
  wait(3);
  if(isDefined(self)) {
    self delete();
  }
}

function checkgrenadefordud(weapon, isthrowngrenade, player) {
  self endon("death");
  player endon("zombify");
  if(!isDefined(self)) {
    return;
  }
  if(!self grenade_safe_to_throw(player, weapon)) {
    self thread makegrenadedudanddestroy();
    return;
  }
  for(;;) {
    self util::waittill_any_ex(0.25, "grenade_bounce", "stationary", "death", player, "zombify");
    if(!self grenade_safe_to_bounce(player, weapon)) {
      self thread makegrenadedudanddestroy();
      return;
    }
  }
}

function wait_explode() {
  self endon("grenade_dud");
  self endon("done");
  self waittill("explode", position);
  level.explode_position = position;
  level.explode_position_valid = 1;
  self notify("done");
}

function wait_timeout(time) {
  self endon("grenade_dud");
  self endon("done");
  self endon("explode");
  wait(time);
  if(isDefined(self)) {
    self notify("done");
  }
}

function wait_for_explosion(time) {
  level.explode_position = (0, 0, 0);
  level.explode_position_valid = 0;
  self thread wait_explode();
  self thread wait_timeout(time);
  self waittill("done");
  self notify("death_or_explode", level.explode_position_valid, level.explode_position);
}

function watchforscriptexplosion(weapon, isthrowngrenade, player) {
  self endon("grenade_dud");
  if(zm_utility::is_lethal_grenade(weapon) || weapon.islauncher) {
    self thread wait_for_explosion(20);
    self waittill("death_or_explode", exploded, position);
    if(exploded) {
      level notify("grenade_exploded", position, 256, 300, 75);
    }
  }
}

function get_nonalternate_weapon(weapon) {
  if(weapon.isaltmode) {
    return weapon.altweapon;
  }
  return weapon;
}

function switch_from_alt_weapon(weapon) {
  if(weapon.ischargeshot) {
    return weapon;
  }
  alt = get_nonalternate_weapon(weapon);
  if(alt != weapon) {
    if(!weaponhasattachment(weapon, "dualoptic")) {
      self switchtoweaponimmediate(alt);
      self util::waittill_any_timeout(1, "weapon_change_complete");
    }
    return alt;
  }
  return weapon;
}

function give_start_weapons(takeallweapons, alreadyspawned) {
  self giveweapon(level.weaponbasemelee);
  self zm_utility::give_start_weapon(1);
}

function give_fallback_weapon(immediate = 0) {
  zm_melee_weapon::give_fallback_weapon(immediate);
}

function take_fallback_weapon() {
  zm_melee_weapon::take_fallback_weapon();
}

function switch_back_primary_weapon(oldprimary, immediate = 0) {
  if(isDefined(self.laststand) && self.laststand) {
    return;
  }
  if(!isDefined(oldprimary) || oldprimary == level.weaponnone || oldprimary.isflourishweapon || zm_utility::is_melee_weapon(oldprimary) || zm_utility::is_placeable_mine(oldprimary) || zm_utility::is_lethal_grenade(oldprimary) || zm_utility::is_tactical_grenade(oldprimary) || !self hasweapon(oldprimary)) {
    oldprimary = undefined;
  } else if(oldprimary.isheroweapon || oldprimary.isgadget && (!isDefined(self.hero_power) || self.hero_power <= 0)) {
    oldprimary = undefined;
  }
  primaryweapons = self getweaponslistprimaries();
  if(isDefined(oldprimary) && isinarray(primaryweapons, oldprimary)) {
    if(immediate) {
      self switchtoweaponimmediate(oldprimary);
    } else {
      self switchtoweapon(oldprimary);
    }
  } else {
    if(primaryweapons.size > 0) {
      if(immediate) {
        self switchtoweaponimmediate();
      } else {
        self switchtoweapon();
      }
    } else {
      give_fallback_weapon(immediate);
    }
  }
}

function add_retrievable_knife_init_name(name) {
  if(!isDefined(level.retrievable_knife_init_names)) {
    level.retrievable_knife_init_names = [];
  }
  level.retrievable_knife_init_names[level.retrievable_knife_init_names.size] = name;
}

function watchweaponusagezm() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("weapon_fired", curweapon);
    self.lastfiretime = gettime();
    self.hasdonecombat = 1;
    switch (curweapon.weapclass) {
      case "mg":
      case "pistol":
      case "pistol spread":
      case "pistolspread":
      case "rifle":
      case "smg":
      case "spread": {
        self weapons::trackweaponfire(curweapon);
        level.globalshotsfired++;
        break;
      }
      case "grenade":
      case "rocketlauncher": {
        self addweaponstat(curweapon, "shots", 1);
        break;
      }
      default: {
        break;
      }
    }
  }
}

function trackweaponzm() {
  self.currentweapon = self getcurrentweapon();
  self.currenttime = gettime();
  spawnid = getplayerspawnid(self);
  while(true) {
    event = self util::waittill_any_return("weapon_change", "death", "disconnect", "bled_out");
    newtime = gettime();
    if(event == "weapon_change") {
      newweapon = self getcurrentweapon();
      if(newweapon != level.weaponnone && newweapon != self.currentweapon) {
        updatelastheldweapontimingszm(newtime);
        self.currentweapon = newweapon;
        self.currenttime = newtime;
      }
    } else {
      if(event != "death" && event != "disconnect") {
        updateweapontimingszm(newtime);
      }
      return;
    }
  }
}

function updatelastheldweapontimingszm(newtime) {
  if(isDefined(self.currentweapon) && isDefined(self.currenttime)) {
    curweapon = self.currentweapon;
    totaltime = int((newtime - self.currenttime) / 1000);
    if(totaltime > 0) {
      self addweaponstat(curweapon, "timeUsed", totaltime);
    }
  }
}

function updateweapontimingszm(newtime) {
  if(self util::is_bot()) {
    return;
  }
  updatelastheldweapontimingszm(newtime);
  if(!isDefined(self.staticweaponsstarttime)) {
    return;
  }
  totaltime = int((newtime - self.staticweaponsstarttime) / 1000);
  if(totaltime < 0) {
    return;
  }
  self.staticweaponsstarttime = newtime;
}

function watchweaponchangezm() {
  self endon("death");
  self endon("disconnect");
  self.lastdroppableweapon = self getcurrentweapon();
  self.hitsthismag = [];
  weapon = self getcurrentweapon();
  while(true) {
    previous_weapon = self getcurrentweapon();
    self waittill("weapon_change", newweapon);
    if(weapons::maydropweapon(newweapon)) {
      self.lastdroppableweapon = newweapon;
    }
  }
}

function weaponobjects_on_player_connect_override_internal() {
  self weaponobjects::createbasewatchers();
  self zm_placeable_mine::setup_watchers();
  for(i = 0; i < level.retrievable_knife_init_names.size; i++) {
    self createballisticknifewatcher_zm(level.retrievable_knife_init_names[i]);
  }
  self weaponobjects::setupretrievablewatcher();
  if(!isDefined(self.weaponobjectwatcherarray)) {
    self.weaponobjectwatcherarray = [];
  }
  self.concussionendtime = 0;
  self.hasdonecombat = 0;
  self.lastfiretime = 0;
  self thread watchweaponusagezm();
  self thread weapons::watchgrenadeusage();
  self thread weapons::watchmissileusage();
  self thread watchweaponchangezm();
  self thread trackweaponzm();
  self notify("weapon_watchers_created");
}

function weaponobjects_on_player_connect_override() {
  add_retrievable_knife_init_name("knife_ballistic");
  add_retrievable_knife_init_name("knife_ballistic_upgraded");
  callback::on_connect(&weaponobjects_on_player_connect_override_internal);
}

function createballisticknifewatcher_zm(weaponname) {
  watcher = self weaponobjects::createuseweaponobjectwatcher(weaponname, self.team);
  watcher.onspawn = &_zm_weap_ballistic_knife::on_spawn;
  watcher.onspawnretrievetriggers = &_zm_weap_ballistic_knife::on_spawn_retrieve_trigger;
  watcher.storedifferentobject = 1;
  watcher.headicon = 0;
}

function default_check_firesale_loc_valid_func() {
  return true;
}

function add_zombie_weapon(weapon_name, upgrade_name, hint, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, is_wonder_weapon, force_attachments) {
  weapon = getweapon(weapon_name);
  upgrade = undefined;
  if(isDefined(upgrade_name)) {
    upgrade = getweapon(upgrade_name);
  }
  if(isDefined(level.zombie_include_weapons) && !isDefined(level.zombie_include_weapons[weapon])) {
    return;
  }
  struct = spawnStruct();
  if(!isDefined(level.zombie_weapons)) {
    level.zombie_weapons = [];
  }
  if(!isDefined(level.zombie_weapons_upgraded)) {
    level.zombie_weapons_upgraded = [];
  }
  if(isDefined(upgrade_name)) {
    level.zombie_weapons_upgraded[upgrade] = weapon;
  }
  struct.weapon = weapon;
  struct.upgrade = upgrade;
  struct.weapon_classname = ("weapon_" + weapon_name) + "_zm";
  if(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled) {
    struct.hint = &"ZOMBIE_WEAPONCOSTONLY_CFILL";
  } else {
    struct.hint = &"ZOMBIE_WEAPONCOSTONLYFILL";
  }
  struct.cost = cost;
  struct.vox = weaponvo;
  struct.vox_response = weaponvoresp;
  struct.is_wonder_weapon = is_wonder_weapon;
  struct.force_attachments = [];
  if("" != force_attachments) {
    force_attachments_list = strtok(force_attachments, " ");
    assert(6 >= force_attachments_list.size, weapon_name + "");
    foreach(attachment in force_attachments_list) {
      struct.force_attachments[struct.force_attachments.size] = attachment;
    }
  }
  println("" + weapon_name);
  struct.is_in_box = level.zombie_include_weapons[weapon];
  if(!isDefined(ammo_cost)) {
    ammo_cost = zm_utility::round_up_to_ten(int(cost * 0.5));
  }
  struct.ammo_cost = ammo_cost;
  if(weapon.isemp || (isDefined(upgrade) && upgrade.isemp)) {
    level.should_watch_for_emp = 1;
  }
  level.zombie_weapons[weapon] = struct;
  if(zm_pap_util::can_swap_attachments() && isDefined(upgrade_name)) {
    add_attachments(weapon_name, upgrade_name);
  }
  if(isDefined(create_vox)) {
    level.vox zm_audio::zmbvoxadd("player", "weapon_pickup", weapon, weaponvo, undefined);
  }
  if(isDefined(level.devgui_add_weapon)) {
    [[level.devgui_add_weapon]](weapon, upgrade, hint, cost, weaponvo, weaponvoresp, ammo_cost);
  }
}

function add_attachments(weapon, upgrade) {
  table = "gamedata/weapons/zm/pap_attach.csv";
  if(isDefined(level.weapon_attachment_table)) {
    table = level.weapon_attachment_table;
  }
  row = tablelookuprownum(table, 0, upgrade);
  if(row > -1) {
    level.zombie_weapons[weapon].default_attachment = tablelookup(table, 0, upgrade.name, 1);
    level.zombie_weapons[weapon].addon_attachments = [];
    index = 2;
    next_addon = tablelookup(table, 0, upgrade.name, index);
    while(isDefined(next_addon) && next_addon.size > 0) {
      level.zombie_weapons[weapon].addon_attachments[level.zombie_weapons[weapon].addon_attachments.size] = next_addon;
      index++;
      next_addon = tablelookup(table, 0, upgrade.name, index);
    }
  }
}

function is_weapon_included(weapon) {
  if(!isDefined(level.zombie_weapons)) {
    return 0;
  }
  weapon = get_nonalternate_weapon(weapon);
  return isDefined(level.zombie_weapons[weapon.rootweapon]);
}

function is_weapon_or_base_included(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  return isDefined(level.zombie_weapons[weapon.rootweapon]) || isDefined(level.zombie_weapons[get_base_weapon(weapon)]);
}

function include_zombie_weapon(weapon_name, in_box) {
  if(!isDefined(level.zombie_include_weapons)) {
    level.zombie_include_weapons = [];
  }
  if(!isDefined(in_box)) {
    in_box = 1;
  }
  println("" + weapon_name);
  level.zombie_include_weapons[getweapon(weapon_name)] = in_box;
}

function init_weapons() {
  if(isDefined(level._zombie_custom_add_weapons)) {
    [[level._zombie_custom_add_weapons]]();
  }
}

function add_limited_weapon(weapon_name, amount) {
  if(!isDefined(level.limited_weapons)) {
    level.limited_weapons = [];
  }
  level.limited_weapons[getweapon(weapon_name)] = amount;
}

function limited_weapon_below_quota(weapon, ignore_player, pap_triggers) {
  if(isDefined(level.limited_weapons[weapon])) {
    if(!isDefined(pap_triggers)) {
      pap_triggers = zm_pap_util::get_triggers();
    }
    if(isDefined(level.no_limited_weapons) && level.no_limited_weapons) {
      return false;
    }
    upgradedweapon = weapon;
    if(isDefined(level.zombie_weapons[weapon]) && isDefined(level.zombie_weapons[weapon].upgrade)) {
      upgradedweapon = level.zombie_weapons[weapon].upgrade;
    }
    players = getplayers();
    count = 0;
    limit = level.limited_weapons[weapon];
    for(i = 0; i < players.size; i++) {
      if(isDefined(ignore_player) && ignore_player == players[i]) {
        continue;
      }
      if(players[i] has_weapon_or_upgrade(weapon)) {
        count++;
        if(count >= limit) {
          return false;
        }
      }
    }
    for(k = 0; k < pap_triggers.size; k++) {
      if(isDefined(pap_triggers[k].current_weapon) && (pap_triggers[k].current_weapon == weapon || pap_triggers[k].current_weapon == upgradedweapon)) {
        count++;
        if(count >= limit) {
          return false;
        }
      }
    }
    for(chestindex = 0; chestindex < level.chests.size; chestindex++) {
      if(isDefined(level.chests[chestindex].zbarrier.weapon) && level.chests[chestindex].zbarrier.weapon == weapon) {
        count++;
        if(count >= limit) {
          return false;
        }
      }
    }
    if(isDefined(level.custom_limited_weapon_checks)) {
      foreach(check in level.custom_limited_weapon_checks) {
        count = count + [
          [check]
        ](weapon);
      }
      if(count >= limit) {
        return false;
      }
    }
    if(isDefined(level.random_weapon_powerups)) {
      for(powerupindex = 0; powerupindex < level.random_weapon_powerups.size; powerupindex++) {
        if(isDefined(level.random_weapon_powerups[powerupindex]) && level.random_weapon_powerups[powerupindex].base_weapon == weapon) {
          count++;
          if(count >= limit) {
            return false;
          }
        }
      }
    }
  }
  return true;
}

function add_custom_limited_weapon_check(callback) {
  if(!isDefined(level.custom_limited_weapon_checks)) {
    level.custom_limited_weapon_checks = [];
  }
  level.custom_limited_weapon_checks[level.custom_limited_weapon_checks.size] = callback;
}

function add_weapon_to_content(weapon_name, package) {
  if(!isDefined(level.content_weapons)) {
    level.content_weapons = [];
  }
  level.content_weapons[getweapon(weapon_name)] = package;
}

function player_can_use_content(weapon) {
  if(isDefined(level.content_weapons)) {
    if(isDefined(level.content_weapons[weapon])) {
      return self hasdlcavailable(level.content_weapons[weapon]);
    }
  }
  return 1;
}

function init_spawnable_weapon_upgrade() {
  spawn_list = [];
  spawnable_weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("bowie_upgrade", "targetname"), 1, 0);
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("sickle_upgrade", "targetname"), 1, 0);
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("tazer_upgrade", "targetname"), 1, 0);
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);
  if(isDefined(level.use_autofill_wallbuy) && level.use_autofill_wallbuy) {
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0);
  }
  if(!(isDefined(level.headshots_only) && level.headshots_only)) {
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("claymore_purchase", "targetname"), 1, 0);
  }
  location = level.scr_zm_map_start_location;
  if(location == "default" || location == "" && isDefined(level.default_start_location)) {
    location = level.default_start_location;
  }
  match_string = level.scr_zm_ui_gametype;
  if("" != location) {
    match_string = (match_string + "_") + location;
  }
  match_string_plus_space = " " + match_string;
  for(i = 0; i < spawnable_weapon_spawns.size; i++) {
    spawnable_weapon = spawnable_weapon_spawns[i];
    spawnable_weapon.weapon = getweapon(spawnable_weapon.zombie_weapon_upgrade);
    if(isDefined(spawnable_weapon.zombie_weapon_upgrade) && spawnable_weapon.weapon.isgrenadeweapon && (isDefined(level.headshots_only) && level.headshots_only)) {
      continue;
    }
    if(!isDefined(spawnable_weapon.script_noteworthy) || spawnable_weapon.script_noteworthy == "") {
      spawn_list[spawn_list.size] = spawnable_weapon;
      continue;
    }
    matches = strtok(spawnable_weapon.script_noteworthy, ",");
    for(j = 0; j < matches.size; j++) {
      if(matches[j] == match_string || matches[j] == match_string_plus_space) {
        spawn_list[spawn_list.size] = spawnable_weapon;
      }
    }
  }
  tempmodel = spawn("script_model", (0, 0, 0));
  for(i = 0; i < spawn_list.size; i++) {
    clientfieldname = (spawn_list[i].zombie_weapon_upgrade + "_") + spawn_list[i].origin;
    numbits = 2;
    if(isDefined(level._wallbuy_override_num_bits)) {
      numbits = level._wallbuy_override_num_bits;
    }
    clientfield::register("world", clientfieldname, 1, numbits, "int");
    target_struct = struct::get(spawn_list[i].target, "targetname");
    if(spawn_list[i].targetname == "buildable_wallbuy") {
      bits = 4;
      if(isDefined(level.buildable_wallbuy_weapons)) {
        bits = getminbitcountfornum(level.buildable_wallbuy_weapons.size + 1);
      }
      clientfield::register("world", clientfieldname + "_idx", 1, bits, "int");
      spawn_list[i].clientfieldname = clientfieldname;
      continue;
    }
    unitrigger_stub = spawnStruct();
    unitrigger_stub.origin = spawn_list[i].origin;
    unitrigger_stub.angles = spawn_list[i].angles;
    tempmodel.origin = spawn_list[i].origin;
    tempmodel.angles = spawn_list[i].angles;
    mins = undefined;
    maxs = undefined;
    absmins = undefined;
    absmaxs = undefined;
    tempmodel setModel(target_struct.model);
    tempmodel useweaponhidetags(spawn_list[i].weapon);
    mins = tempmodel getmins();
    maxs = tempmodel getmaxs();
    absmins = tempmodel getabsmins();
    absmaxs = tempmodel getabsmaxs();
    bounds = absmaxs - absmins;
    unitrigger_stub.script_length = bounds[0] * 0.25;
    unitrigger_stub.script_width = bounds[1];
    unitrigger_stub.script_height = bounds[2];
    unitrigger_stub.origin = unitrigger_stub.origin - (anglestoright(unitrigger_stub.angles) * (unitrigger_stub.script_length * 0.4));
    unitrigger_stub.target = spawn_list[i].target;
    unitrigger_stub.targetname = spawn_list[i].targetname;
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    if(spawn_list[i].targetname == "weapon_upgrade") {
      unitrigger_stub.cost = get_weapon_cost(spawn_list[i].weapon);
      unitrigger_stub.hint_string = get_weapon_hint(spawn_list[i].weapon);
      if(!(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)) {
        unitrigger_stub.hint_parm1 = unitrigger_stub.cost;
      }
      unitrigger_stub.cursor_hint = "HINT_WEAPON";
      unitrigger_stub.cursor_hint_weapon = spawn_list[i].weapon;
    }
    unitrigger_stub.weapon = spawn_list[i].weapon;
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    if(isDefined(spawn_list[i].script_string) && (isDefined(int(spawn_list[i].script_string)) && int(spawn_list[i].script_string))) {
      unitrigger_stub.require_look_toward = 0;
      unitrigger_stub.require_look_at = 0;
      unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
      unitrigger_stub.script_length = bounds[0] * 0.4;
      unitrigger_stub.script_width = bounds[1] * 2;
      unitrigger_stub.script_height = bounds[2];
    } else {
      unitrigger_stub.require_look_at = 1;
    }
    if(isDefined(spawn_list[i].require_look_from) && spawn_list[i].require_look_from) {
      unitrigger_stub.require_look_from = 1;
    }
    unitrigger_stub.clientfieldname = clientfieldname;
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    if(unitrigger_stub.weapon.ismeleeweapon || unitrigger_stub.weapon.isgrenadeweapon) {
      if(unitrigger_stub.weapon.name == "tazer_knuckles" && isDefined(level.taser_trig_adjustment)) {
        unitrigger_stub.origin = unitrigger_stub.origin + level.taser_trig_adjustment;
      }
      zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
    } else {
      unitrigger_stub.prompt_and_visibility_func = &wall_weapon_update_prompt;
      zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
    }
    spawn_list[i].trigger_stub = unitrigger_stub;
  }
  level._spawned_wallbuys = spawn_list;
  tempmodel delete();
}

function add_dynamic_wallbuy(weapon, wallbuy, pristine) {
  spawned_wallbuy = undefined;
  for(i = 0; i < level._spawned_wallbuys.size; i++) {
    if(level._spawned_wallbuys[i].target == wallbuy) {
      spawned_wallbuy = level._spawned_wallbuys[i];
      break;
    }
  }
  if(!isDefined(spawned_wallbuy)) {
    assertmsg("");
    return;
  }
  if(isDefined(spawned_wallbuy.trigger_stub)) {
    assertmsg("");
    return;
  }
  target_struct = struct::get(wallbuy, "targetname");
  wallmodel = zm_utility::spawn_weapon_model(weapon, undefined, target_struct.origin, target_struct.angles, undefined);
  clientfieldname = spawned_wallbuy.clientfieldname;
  model = weapon.worldmodel;
  unitrigger_stub = spawnStruct();
  unitrigger_stub.origin = target_struct.origin;
  unitrigger_stub.angles = target_struct.angles;
  wallmodel.origin = target_struct.origin;
  wallmodel.angles = target_struct.angles;
  mins = undefined;
  maxs = undefined;
  absmins = undefined;
  absmaxs = undefined;
  wallmodel setModel(model);
  wallmodel useweaponhidetags(weapon);
  mins = wallmodel getmins();
  maxs = wallmodel getmaxs();
  absmins = wallmodel getabsmins();
  absmaxs = wallmodel getabsmaxs();
  bounds = absmaxs - absmins;
  unitrigger_stub.script_length = bounds[0] * 0.25;
  unitrigger_stub.script_width = bounds[1];
  unitrigger_stub.script_height = bounds[2];
  unitrigger_stub.origin = unitrigger_stub.origin - (anglestoright(unitrigger_stub.angles) * (unitrigger_stub.script_length * 0.4));
  unitrigger_stub.target = spawned_wallbuy.target;
  unitrigger_stub.targetname = "weapon_upgrade";
  unitrigger_stub.cursor_hint = "HINT_NOICON";
  unitrigger_stub.first_time_triggered = !pristine;
  if(!weapon.ismeleeweapon) {
    if(pristine || zm_utility::is_placeable_mine(weapon)) {
      unitrigger_stub.hint_string = get_weapon_hint(weapon);
    } else {
      unitrigger_stub.hint_string = get_weapon_hint_ammo();
    }
    unitrigger_stub.cost = get_weapon_cost(weapon);
    if(!(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)) {
      unitrigger_stub.hint_parm1 = unitrigger_stub.cost;
    }
  }
  unitrigger_stub.weapon = weapon;
  unitrigger_stub.weapon_upgrade = weapon;
  unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  unitrigger_stub.require_look_at = 1;
  unitrigger_stub.clientfieldname = clientfieldname;
  zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
  if(weapon.ismeleeweapon) {
    if(weapon == "tazer_knuckles" && isDefined(level.taser_trig_adjustment)) {
      unitrigger_stub.origin = unitrigger_stub.origin + level.taser_trig_adjustment;
    }
    zm_melee_weapon::add_stub(unitrigger_stub, weapon);
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &zm_melee_weapon::melee_weapon_think);
  } else {
    unitrigger_stub.prompt_and_visibility_func = &wall_weapon_update_prompt;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
  }
  spawned_wallbuy.trigger_stub = unitrigger_stub;
  weaponidx = undefined;
  if(isDefined(level.buildable_wallbuy_weapons)) {
    for(i = 0; i < level.buildable_wallbuy_weapons.size; i++) {
      if(weapon == level.buildable_wallbuy_weapons[i]) {
        weaponidx = i;
        break;
      }
    }
  }
  if(isDefined(weaponidx)) {
    level clientfield::set(clientfieldname + "_idx", weaponidx + 1);
    wallmodel delete();
    if(!pristine) {
      level clientfield::set(clientfieldname, 1);
    }
  } else {
    level clientfield::set(clientfieldname, 1);
    wallmodel show();
  }
}

function wall_weapon_update_prompt(player) {
  weapon = self.stub.weapon;
  player_has_weapon = player has_weapon_or_upgrade(weapon);
  if(!player_has_weapon && (isDefined(level.weapons_using_ammo_sharing) && level.weapons_using_ammo_sharing)) {
    shared_ammo_weapon = player get_shared_ammo_weapon(self.zombie_weapon_upgrade);
    if(isDefined(shared_ammo_weapon)) {
      weapon = shared_ammo_weapon;
      player_has_weapon = 1;
    }
  }
  if(isDefined(level.func_override_wallbuy_prompt)) {
    if(!self[[level.func_override_wallbuy_prompt]](player)) {
      return false;
    }
  }
  if(!player_has_weapon) {
    self.stub.cursor_hint = "HINT_WEAPON";
    cost = get_weapon_cost(weapon);
    if(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled) {
      if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
        self.stub.hint_string = &"ZOMBIE_WEAPONCOSTONLY_CFILL_BGB_SECRET_SHOPPER";
        self sethintstring(self.stub.hint_string);
      } else {
        self.stub.hint_string = &"ZOMBIE_WEAPONCOSTONLY_CFILL";
        self sethintstring(self.stub.hint_string);
      }
    } else {
      if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
        self.stub.hint_string = &"ZOMBIE_WEAPONCOSTONLYFILL_BGB_SECRET_SHOPPER";
        n_bgb_cost = player get_ammo_cost_for_weapon(player.currentweapon);
        self sethintstring(self.stub.hint_string, cost, n_bgb_cost);
      } else {
        self.stub.hint_string = &"ZOMBIE_WEAPONCOSTONLYFILL";
        self sethintstring(self.stub.hint_string, cost);
      }
    }
  } else {
    if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
      ammo_cost = player get_ammo_cost_for_weapon(weapon);
    } else {
      if(player has_upgrade(weapon) && self.stub.hacked !== 1) {
        ammo_cost = get_upgraded_ammo_cost(weapon);
      } else {
        ammo_cost = get_ammo_cost(weapon);
      }
    }
    if(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled) {
      if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
        if(isDefined(self.stub.hacked) && self.stub.hacked) {
          self.stub.hint_string = &"ZOMBIE_WEAPONAMMOHACKED_CFILL_BGB_SECRET_SHOPPER";
        } else {
          self.stub.hint_string = &"ZOMBIE_WEAPONAMMOONLY_CFILL_BGB_SECRET_SHOPPER";
        }
        self sethintstring(self.stub.hint_string);
      } else {
        if(isDefined(self.stub.hacked) && self.stub.hacked) {
          self.stub.hint_string = &"ZOMBIE_WEAPONAMMOHACKED_CFILL";
        } else {
          self.stub.hint_string = &"ZOMBIE_WEAPONAMMOONLY_CFILL";
        }
        self sethintstring(self.stub.hint_string);
      }
    } else {
      if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
        self.stub.hint_string = &"ZOMBIE_WEAPONAMMOONLY_BGB_SECRET_SHOPPER";
        n_bgb_cost = player get_ammo_cost_for_weapon(player.currentweapon);
        self sethintstring(self.stub.hint_string, ammo_cost, n_bgb_cost);
      } else {
        self.stub.hint_string = &"ZOMBIE_WEAPONAMMOONLY";
        self sethintstring(self.stub.hint_string, ammo_cost);
      }
    }
  }
  self.stub.cursor_hint = "HINT_WEAPON";
  self.stub.cursor_hint_weapon = weapon;
  self setcursorhint(self.stub.cursor_hint, self.stub.cursor_hint_weapon);
  return true;
}

function reset_wallbuy_internal(set_hint_string) {
  if(isDefined(self.first_time_triggered) && self.first_time_triggered) {
    self.first_time_triggered = 0;
    if(isDefined(self.clientfieldname)) {
      level clientfield::set(self.clientfieldname, 0);
    }
    if(set_hint_string) {
      hint_string = get_weapon_hint(self.weapon);
      cost = get_weapon_cost(self.weapon);
      if(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled) {
        self sethintstring(hint_string);
      } else {
        self sethintstring(hint_string, cost);
      }
    }
  }
}

function reset_wallbuys() {
  weapon_spawns = [];
  weapon_spawns = getEntArray("weapon_upgrade", "targetname");
  melee_and_grenade_spawns = [];
  melee_and_grenade_spawns = getEntArray("bowie_upgrade", "targetname");
  melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getEntArray("sickle_upgrade", "targetname"), 1, 0);
  melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getEntArray("tazer_upgrade", "targetname"), 1, 0);
  if(!(isDefined(level.headshots_only) && level.headshots_only)) {
    melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getEntArray("claymore_purchase", "targetname"), 1, 0);
  }
  for(i = 0; i < weapon_spawns.size; i++) {
    weapon_spawns[i].weapon = getweapon(weapon_spawns[i].zombie_weapon_upgrade);
    weapon_spawns[i] reset_wallbuy_internal(1);
  }
  for(i = 0; i < melee_and_grenade_spawns.size; i++) {
    melee_and_grenade_spawns[i].weapon = getweapon(melee_and_grenade_spawns[i].zombie_weapon_upgrade);
    melee_and_grenade_spawns[i] reset_wallbuy_internal(0);
  }
  if(isDefined(level._unitriggers)) {
    candidates = [];
    for(i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
      stub = level._unitriggers.trigger_stubs[i];
      tn = stub.targetname;
      if(tn == "weapon_upgrade" || tn == "bowie_upgrade" || tn == "sickle_upgrade" || tn == "tazer_upgrade" || tn == "claymore_purchase") {
        stub.first_time_triggered = 0;
        if(isDefined(stub.clientfieldname)) {
          level clientfield::set(stub.clientfieldname, 0);
        }
        if(tn == "weapon_upgrade") {
          stub.hint_string = get_weapon_hint(stub.weapon);
          stub.cost = get_weapon_cost(stub.weapon);
          if(!(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)) {
            stub.hint_parm1 = stub.cost;
          }
        }
      }
    }
  }
}

function init_weapon_upgrade() {
  init_spawnable_weapon_upgrade();
  weapon_spawns = [];
  weapon_spawns = getEntArray("weapon_upgrade", "targetname");
  for(i = 0; i < weapon_spawns.size; i++) {
    weapon_spawns[i].weapon = getweapon(weapon_spawns[i].zombie_weapon_upgrade);
    hint_string = get_weapon_hint(weapon_spawns[i].weapon);
    cost = get_weapon_cost(weapon_spawns[i].weapon);
    if(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled) {
      weapon_spawns[i] sethintstring(hint_string);
    } else {
      weapon_spawns[i] sethintstring(hint_string, cost);
    }
    weapon_spawns[i] setcursorhint("HINT_NOICON");
    weapon_spawns[i] usetriggerrequirelookat();
    weapon_spawns[i] thread weapon_spawn_think();
    model = getent(weapon_spawns[i].target, "targetname");
    if(isDefined(model)) {
      model useweaponhidetags(weapon_spawns[i].weapon);
      model hide();
    }
  }
}

function get_weapon_hint(weapon) {
  assert(isDefined(level.zombie_weapons[weapon]), weapon.name + "");
  return level.zombie_weapons[weapon].hint;
}

function get_weapon_cost(weapon) {
  assert(isDefined(level.zombie_weapons[weapon]), weapon.name + "");
  return level.zombie_weapons[weapon].cost;
}

function get_ammo_cost(weapon) {
  assert(isDefined(level.zombie_weapons[weapon]), weapon.name + "");
  return level.zombie_weapons[weapon].ammo_cost;
}

function get_upgraded_ammo_cost(weapon) {
  assert(isDefined(level.zombie_weapons[weapon]), weapon.name + "");
  if(isDefined(level.zombie_weapons[weapon].upgraded_ammo_cost)) {
    return level.zombie_weapons[weapon].upgraded_ammo_cost;
  }
  return 4500;
}

function get_ammo_cost_for_weapon(w_current, n_base_non_wallbuy_cost = 750, n_upgraded_non_wallbuy_cost = 5000) {
  w_root = w_current.rootweapon;
  if(is_weapon_upgraded(w_root)) {
    w_root = get_base_weapon(w_root);
  }
  if(self has_upgrade(w_root)) {
    if(is_wallbuy(w_root)) {
      n_ammo_cost = 4000;
    } else {
      n_ammo_cost = n_upgraded_non_wallbuy_cost;
    }
  } else {
    if(is_wallbuy(w_root)) {
      n_ammo_cost = get_ammo_cost(w_root);
      n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
    } else {
      n_ammo_cost = n_base_non_wallbuy_cost;
    }
  }
  return n_ammo_cost;
}

function get_is_in_box(weapon) {
  assert(isDefined(level.zombie_weapons[weapon]), weapon.name + "");
  return level.zombie_weapons[weapon].is_in_box;
}

function get_force_attachments(weapon) {
  assert(isDefined(level.zombie_weapons[weapon]), weapon.name + "");
  return level.zombie_weapons[weapon].force_attachments;
}

function weapon_supports_default_attachment(weapon) {
  weapon = get_base_weapon(weapon);
  attachment = level.zombie_weapons[weapon].default_attachment;
  return isDefined(attachment);
}

function default_attachment(weapon) {
  weapon = get_base_weapon(weapon);
  attachment = level.zombie_weapons[weapon].default_attachment;
  if(isDefined(attachment)) {
    return attachment;
  }
  return "none";
}

function weapon_supports_attachments(weapon) {
  weapon = get_base_weapon(weapon);
  attachments = level.zombie_weapons[weapon].addon_attachments;
  return isDefined(attachments) && attachments.size > 1;
}

function random_attachment(weapon, exclude) {
  lo = 0;
  if(isDefined(level.zombie_weapons[weapon].addon_attachments) && level.zombie_weapons[weapon].addon_attachments.size > 0) {
    attachments = level.zombie_weapons[weapon].addon_attachments;
  } else {
    attachments = weapon.supportedattachments;
    lo = 1;
  }
  minatt = lo;
  if(isDefined(exclude) && exclude != "none") {
    minatt = lo + 1;
  }
  if(attachments.size > minatt) {
    while(true) {
      idx = (randomint(attachments.size - lo)) + lo;
      if(!isDefined(exclude) || attachments[idx] != exclude) {
        return attachments[idx];
      }
    }
  }
  return "none";
}

function get_attachment_index(weapon) {
  attachments = weapon.attachments;
  if(!attachments.size) {
    return -1;
  }
  weapon = get_nonalternate_weapon(weapon);
  base = weapon.rootweapon;
  if(attachments[0] == level.zombie_weapons[base].default_attachment) {
    return 0;
  }
  if(isDefined(level.zombie_weapons[base].addon_attachments)) {
    for(i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++) {
      if(level.zombie_weapons[base].addon_attachments[i] == attachments[0]) {
        return i + 1;
      }
    }
  }
  println("" + weapon.name);
  return -1;
}

function weapon_supports_this_attachment(weapon, att) {
  weapon = get_nonalternate_weapon(weapon);
  base = weapon.rootweapon;
  if(att == level.zombie_weapons[base].default_attachment) {
    return true;
  }
  if(isDefined(level.zombie_weapons[base].addon_attachments)) {
    for(i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++) {
      if(level.zombie_weapons[base].addon_attachments[i] == att) {
        return true;
      }
    }
  }
  return false;
}

function get_base_weapon(upgradedweapon) {
  upgradedweapon = get_nonalternate_weapon(upgradedweapon);
  upgradedweapon = upgradedweapon.rootweapon;
  if(isDefined(level.zombie_weapons_upgraded[upgradedweapon])) {
    return level.zombie_weapons_upgraded[upgradedweapon];
  }
  return upgradedweapon;
}

function get_upgrade_weapon(weapon, add_attachment) {
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = weapon.rootweapon;
  newweapon = rootweapon;
  baseweapon = get_base_weapon(weapon);
  if(!is_weapon_upgraded(rootweapon)) {
    newweapon = level.zombie_weapons[rootweapon].upgrade;
  }
  if(isDefined(add_attachment) && add_attachment && zm_pap_util::can_swap_attachments()) {
    oldatt = "none";
    if(weapon.attachments.size) {
      oldatt = weapon.attachments[0];
    }
    att = random_attachment(baseweapon, oldatt);
    newweapon = getweapon(newweapon.name, att);
  } else if(isDefined(level.zombie_weapons[rootweapon]) && isDefined(level.zombie_weapons[rootweapon].default_attachment)) {
    att = level.zombie_weapons[rootweapon].default_attachment;
    newweapon = getweapon(newweapon.name, att);
  }
  return newweapon;
}

function can_upgrade_weapon(weapon) {
  if(weapon == level.weaponnone || weapon == level.weaponzmfists || !is_weapon_included(weapon)) {
    return 0;
  }
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = weapon.rootweapon;
  if(!is_weapon_upgraded(rootweapon)) {
    return isDefined(level.zombie_weapons[rootweapon].upgrade);
  }
  if(zm_pap_util::can_swap_attachments() && weapon_supports_attachments(rootweapon)) {
    return 1;
  }
  return 0;
}

function weapon_supports_aat(weapon) {
  if(weapon == level.weaponnone || weapon == level.weaponzmfists) {
    return false;
  }
  weapontopack = get_nonalternate_weapon(weapon);
  rootweapon = weapontopack.rootweapon;
  if(!is_weapon_upgraded(rootweapon)) {
    return false;
  }
  if(!aat::is_exempt_weapon(weapontopack)) {
    return true;
  }
  return false;
}

function is_weapon_upgraded(weapon) {
  if(weapon == level.weaponnone || weapon == level.weaponzmfists) {
    return false;
  }
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = weapon.rootweapon;
  if(isDefined(level.zombie_weapons_upgraded[rootweapon])) {
    return true;
  }
  return false;
}

function get_weapon_with_attachments(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  if(self hasweapon(weapon.rootweapon, 1)) {
    upgraded = is_weapon_upgraded(weapon);
    if(is_weapon_included(weapon) || upgraded) {
      if(upgraded) {
        base_weapon = get_base_weapon(weapon);
        force_attachments = get_force_attachments(base_weapon.rootweapon);
      } else {
        force_attachments = get_force_attachments(weapon.rootweapon);
      }
    }
    if(isDefined(force_attachments) && force_attachments.size) {
      if(upgraded) {
        packed_attachments = [];
        packed_attachments[packed_attachments.size] = "extclip";
        packed_attachments[packed_attachments.size] = "fmj";
        force_attachments = arraycombine(force_attachments, packed_attachments, 0, 0);
      }
      return getweapon(weapon.rootweapon.name, force_attachments);
    }
    return self getbuildkitweapon(weapon.rootweapon, upgraded);
  }
  return undefined;
}

function has_weapon_or_attachments(weapon) {
  if(self hasweapon(weapon, 1)) {
    return true;
  }
  if(zm_pap_util::can_swap_attachments()) {
    rootweapon = weapon.rootweapon;
    weapons = self getweaponslist(1);
    foreach(w in weapons) {
      if(rootweapon == w.rootweapon) {
        return true;
      }
    }
  }
  return false;
}

function has_upgrade(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = weapon.rootweapon;
  has_upgrade = 0;
  if(isDefined(level.zombie_weapons[rootweapon]) && isDefined(level.zombie_weapons[rootweapon].upgrade)) {
    has_upgrade = self has_weapon_or_attachments(level.zombie_weapons[rootweapon].upgrade);
  }
  if(!has_upgrade && rootweapon.isballisticknife) {
    has_weapon = self zm_melee_weapon::has_upgraded_ballistic_knife();
  }
  return has_upgrade;
}

function has_weapon_or_upgrade(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = weapon.rootweapon;
  upgradedweaponname = rootweapon;
  if(isDefined(level.zombie_weapons[rootweapon]) && isDefined(level.zombie_weapons[rootweapon].upgrade)) {
    upgradedweaponname = level.zombie_weapons[rootweapon].upgrade;
  }
  has_weapon = 0;
  if(isDefined(level.zombie_weapons[rootweapon])) {
    has_weapon = self has_weapon_or_attachments(rootweapon) || self has_upgrade(rootweapon);
  }
  if(!has_weapon && level.weaponballisticknife == rootweapon) {
    has_weapon = self zm_melee_weapon::has_any_ballistic_knife();
  }
  if(!has_weapon && zm_equipment::is_equipment(rootweapon)) {
    has_weapon = self zm_equipment::is_active(rootweapon);
  }
  return has_weapon;
}

function add_shared_ammo_weapon(weapon, base_weapon) {
  level.zombie_weapons[weapon].shared_ammo_weapon = base_weapon;
}

function get_shared_ammo_weapon(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = weapon.rootweapon;
  weapons = self getweaponslist(1);
  foreach(w in weapons) {
    w = w.rootweapon;
    if(!isDefined(level.zombie_weapons[w]) && isDefined(level.zombie_weapons_upgraded[w])) {
      w = level.zombie_weapons_upgraded[w];
    }
    if(isDefined(level.zombie_weapons[w]) && isDefined(level.zombie_weapons[w].shared_ammo_weapon) && level.zombie_weapons[w].shared_ammo_weapon == rootweapon) {
      return w;
    }
  }
  return undefined;
}

function get_player_weapon_with_same_base(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = weapon.rootweapon;
  retweapon = self get_weapon_with_attachments(rootweapon);
  if(!isDefined(retweapon)) {
    if(isDefined(level.zombie_weapons[rootweapon])) {
      if(isDefined(level.zombie_weapons[rootweapon].upgrade)) {
        retweapon = self get_weapon_with_attachments(level.zombie_weapons[rootweapon].upgrade);
      }
    } else if(isDefined(level.zombie_weapons_upgraded[rootweapon])) {
      retweapon = self get_weapon_with_attachments(level.zombie_weapons_upgraded[rootweapon]);
    }
  }
  return retweapon;
}

function get_weapon_hint_ammo() {
  if(!(isDefined(level.obsolete_prompt_format_needed) && level.obsolete_prompt_format_needed)) {
    if(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled) {
      return &"ZOMBIE_WEAPONCOSTONLY_CFILL";
    }
    return &"ZOMBIE_WEAPONCOSTONLYFILL";
  }
  if(isDefined(level.has_pack_a_punch) && !level.has_pack_a_punch) {
    return &"ZOMBIE_WEAPONCOSTAMMO";
  }
  return &"ZOMBIE_WEAPONCOSTAMMO_UPGRADE";
}

function weapon_set_first_time_hint(cost, ammo_cost) {
  if(!(isDefined(level.obsolete_prompt_format_needed) && level.obsolete_prompt_format_needed)) {
    if(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled) {
      self sethintstring(get_weapon_hint_ammo());
    } else {
      self sethintstring(get_weapon_hint_ammo(), cost, ammo_cost);
    }
  } else {
    self sethintstring(get_weapon_hint_ammo(), cost, ammo_cost);
  }
}

function placeable_mine_can_buy_weapon_extra_check_func(w_weapon) {
  if(isDefined(w_weapon) && w_weapon == self zm_utility::get_player_placeable_mine()) {
    return false;
  }
  return true;
}

function weapon_spawn_think() {
  cost = get_weapon_cost(self.weapon);
  ammo_cost = get_ammo_cost(self.weapon);
  is_grenade = self.weapon.isgrenadeweapon;
  shared_ammo_weapon = undefined;
  if(isDefined(self.parent_player) && !is_grenade) {
    self.parent_player notify("zm_bgb_secret_shopper", self);
  }
  second_endon = undefined;
  if(isDefined(self.stub)) {
    second_endon = "kill_trigger";
    self.first_time_triggered = self.stub.first_time_triggered;
  }
  onlyplayer = undefined;
  can_buy_weapon_extra_check_func = undefined;
  if(isDefined(self.stub) && (isDefined(self.stub.trigger_per_player) && self.stub.trigger_per_player)) {
    onlyplayer = self.parent_player;
    if(zm_utility::is_placeable_mine(self.weapon)) {
      can_buy_weapon_extra_check_func = &placeable_mine_can_buy_weapon_extra_check_func;
    }
  }
  self thread zm_magicbox::decide_hide_show_hint("stop_hint_logic", second_endon, onlyplayer, can_buy_weapon_extra_check_func);
  if(is_grenade || zm_utility::is_melee_weapon(self.weapon)) {
    self.first_time_triggered = 0;
    hint = get_weapon_hint(self.weapon);
    if(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled) {
      self sethintstring(hint);
    } else {
      self sethintstring(hint, cost);
    }
    cursor_hint = "HINT_WEAPON";
    cursor_hint_weapon = self.weapon;
    self setcursorhint(cursor_hint, cursor_hint_weapon);
  } else if(!isDefined(self.first_time_triggered)) {
    self.first_time_triggered = 0;
    if(isDefined(self.stub)) {
      self.stub.first_time_triggered = 0;
    }
  }
  for(;;) {
    self waittill("trigger", player);
    if(!zm_utility::is_player_valid(player)) {
      player thread zm_utility::ignore_triggers(0.5);
      continue;
    }
    if(!player zm_magicbox::can_buy_weapon()) {
      wait(0.1);
      continue;
    }
    if(isDefined(self.stub) && (isDefined(self.stub.require_look_from) && self.stub.require_look_from)) {
      toplayer = player util::get_eye() - self.origin;
      forward = -1 * anglestoright(self.angles);
      dot = vectordot(toplayer, forward);
      if(dot < 0) {
        continue;
      }
    }
    if(player zm_utility::has_powerup_weapon()) {
      wait(0.1);
      continue;
    }
    player_has_weapon = player has_weapon_or_upgrade(self.weapon);
    if(!player_has_weapon && (isDefined(level.weapons_using_ammo_sharing) && level.weapons_using_ammo_sharing)) {
      shared_ammo_weapon = player get_shared_ammo_weapon(self.weapon);
      if(isDefined(shared_ammo_weapon)) {
        player_has_weapon = 1;
      }
    }
    if(isDefined(level.pers_upgrade_nube) && level.pers_upgrade_nube) {
      player_has_weapon = zm_pers_upgrades_functions::pers_nube_should_we_give_raygun(player_has_weapon, player, self.weapon);
    }
    cost = get_weapon_cost(self.weapon);
    if(player zm_pers_upgrades_functions::is_pers_double_points_active()) {
      cost = int(cost / 2);
    }
    if(isDefined(player.check_override_wallbuy_purchase)) {
      if(player[[player.check_override_wallbuy_purchase]](self.weapon, self)) {
        continue;
      }
    }
    if(!player_has_weapon) {
      if(player zm_score::can_player_purchase(cost)) {
        if(self.first_time_triggered == 0) {
          self show_all_weapon_buys(player, cost, ammo_cost, is_grenade);
        }
        player zm_score::minus_to_player_score(cost);
        level notify("weapon_bought", player, self.weapon);
        player zm_stats::increment_challenge_stat("SURVIVALIST_BUY_WALLBUY");
        if(self.weapon.isriotshield) {
          player zm_equipment::give(self.weapon);
          if(isDefined(player.player_shield_reset_health)) {
            player[[player.player_shield_reset_health]]();
          }
        } else {
          if(zm_utility::is_lethal_grenade(self.weapon)) {
            player weapon_take(player zm_utility::get_player_lethal_grenade());
            player zm_utility::set_player_lethal_grenade(self.weapon);
          }
          weapon = self.weapon;
          if(isDefined(level.pers_upgrade_nube) && level.pers_upgrade_nube) {
            weapon = zm_pers_upgrades_functions::pers_nube_weapon_upgrade_check(player, weapon);
          }
          if(should_upgrade_weapon(player)) {
            if(player can_upgrade_weapon(weapon)) {
              weapon = get_upgrade_weapon(weapon);
              player notify("zm_bgb_wall_power_used");
            }
          }
          weapon = player weapon_give(weapon);
          if(isDefined(weapon)) {
            player thread aat::remove(weapon);
          }
        }
        if(isDefined(weapon)) {
          player zm_stats::increment_client_stat("wallbuy_weapons_purchased");
          player zm_stats::increment_player_stat("wallbuy_weapons_purchased");
          bb::logpurchaseevent(player, self, cost, weapon.name, player has_upgrade(weapon), "_weapon", "_purchase");
          weaponindex = undefined;
          if(isDefined(weaponindex)) {
            weaponindex = matchrecordgetweaponindex(weapon);
          }
          if(isDefined(weaponindex)) {
            player recordmapevent(6, gettime(), player.origin, level.round_number, weaponindex, cost);
          }
        }
      } else {
        zm_utility::play_sound_on_ent("no_purchase");
        player zm_audio::create_and_play_dialog("general", "outofmoney");
      }
    } else {
      weapon = self.weapon;
      if(isDefined(shared_ammo_weapon)) {
        weapon = shared_ammo_weapon;
      }
      if(isDefined(level.pers_upgrade_nube) && level.pers_upgrade_nube) {
        weapon = zm_pers_upgrades_functions::pers_nube_weapon_ammo_check(player, weapon);
      }
      if(isDefined(self.stub.hacked) && self.stub.hacked) {
        if(!player has_upgrade(weapon)) {
          ammo_cost = 4500;
        } else {
          ammo_cost = get_ammo_cost(weapon);
        }
      } else {
        if(player has_upgrade(weapon)) {
          ammo_cost = 4500;
        } else {
          ammo_cost = get_ammo_cost(weapon);
        }
      }
      if(isDefined(player.pers_upgrades_awarded["nube"]) && player.pers_upgrades_awarded["nube"]) {
        ammo_cost = zm_pers_upgrades_functions::pers_nube_override_ammo_cost(player, self.weapon, ammo_cost);
      }
      if(player zm_pers_upgrades_functions::is_pers_double_points_active()) {
        ammo_cost = int(ammo_cost / 2);
      }
      if(player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(weapon)) {
        ammo_cost = player get_ammo_cost_for_weapon(weapon);
      }
      if(weapon.isriotshield) {
        zm_utility::play_sound_on_ent("no_purchase");
      } else {
        if(player zm_score::can_player_purchase(ammo_cost)) {
          if(self.first_time_triggered == 0) {
            self show_all_weapon_buys(player, cost, ammo_cost, is_grenade);
          }
          if(player has_upgrade(weapon)) {
            player zm_stats::increment_client_stat("upgraded_ammo_purchased");
            player zm_stats::increment_player_stat("upgraded_ammo_purchased");
          } else {
            player zm_stats::increment_client_stat("ammo_purchased");
            player zm_stats::increment_player_stat("ammo_purchased");
          }
          if(player has_upgrade(weapon)) {
            ammo_given = player ammo_give(level.zombie_weapons[weapon].upgrade);
          } else {
            ammo_given = player ammo_give(weapon);
          }
          if(ammo_given) {
            player zm_score::minus_to_player_score(ammo_cost);
          }
          bb::logpurchaseevent(player, self, ammo_cost, weapon.name, player has_upgrade(weapon), "_ammo", "_purchase");
          weaponindex = undefined;
          if(isDefined(weapon)) {
            weaponindex = matchrecordgetweaponindex(weapon);
          }
          if(isDefined(weaponindex)) {
            player recordmapevent(7, gettime(), player.origin, level.round_number, weaponindex, cost);
          }
        } else {
          zm_utility::play_sound_on_ent("no_purchase");
          if(isDefined(level.custom_generic_deny_vo_func)) {
            player[[level.custom_generic_deny_vo_func]]();
          } else {
            player zm_audio::create_and_play_dialog("general", "outofmoney");
          }
        }
      }
    }
    if(isDefined(self.stub) && isDefined(self.stub.prompt_and_visibility_func)) {
      self[[self.stub.prompt_and_visibility_func]](player);
    }
  }
}

function should_upgrade_weapon(player) {
  if(isDefined(level.wallbuy_should_upgrade_weapon_override)) {
    return [[level.wallbuy_should_upgrade_weapon_override]]();
  }
  if(player bgb::is_enabled("zm_bgb_wall_power")) {
    return 1;
  }
  return 0;
}

function show_all_weapon_buys(player, cost, ammo_cost, is_grenade) {
  model = getent(self.target, "targetname");
  is_melee = zm_utility::is_melee_weapon(self.weapon);
  if(isDefined(model)) {
    model thread weapon_show(player);
  } else if(isDefined(self.clientfieldname)) {
    level clientfield::set(self.clientfieldname, 1);
  }
  self.first_time_triggered = 1;
  if(isDefined(self.stub)) {
    self.stub.first_time_triggered = 1;
  }
  if(!is_grenade && !is_melee) {
    self weapon_set_first_time_hint(cost, ammo_cost);
  }
  if(!(isDefined(level.dont_link_common_wallbuys) && level.dont_link_common_wallbuys) && isDefined(level._spawned_wallbuys)) {
    for(i = 0; i < level._spawned_wallbuys.size; i++) {
      wallbuy = level._spawned_wallbuys[i];
      if(isDefined(self.stub) && isDefined(wallbuy.trigger_stub) && self.stub.clientfieldname == wallbuy.trigger_stub.clientfieldname) {
        continue;
      }
      if(self.weapon == wallbuy.weapon) {
        if(isDefined(wallbuy.trigger_stub) && isDefined(wallbuy.trigger_stub.clientfieldname)) {
          level clientfield::set(wallbuy.trigger_stub.clientfieldname, 1);
        } else if(isDefined(wallbuy.target)) {
          model = getent(wallbuy.target, "targetname");
          if(isDefined(model)) {
            model thread weapon_show(player);
          }
        }
        if(isDefined(wallbuy.trigger_stub)) {
          wallbuy.trigger_stub.first_time_triggered = 1;
          if(isDefined(wallbuy.trigger_stub.trigger)) {
            wallbuy.trigger_stub.trigger.first_time_triggered = 1;
            if(!is_grenade && !is_melee) {
              wallbuy.trigger_stub.trigger weapon_set_first_time_hint(cost, ammo_cost);
            }
          }
          continue;
        }
        if(!is_grenade && !is_melee) {
          wallbuy weapon_set_first_time_hint(cost, ammo_cost);
        }
      }
    }
  }
}

function weapon_show(player) {
  player_angles = vectortoangles(player.origin - self.origin);
  player_yaw = player_angles[1];
  weapon_yaw = self.angles[1];
  if(isDefined(self.script_int)) {
    weapon_yaw = weapon_yaw - self.script_int;
  }
  yaw_diff = angleclamp180(player_yaw - weapon_yaw);
  if(yaw_diff > 0) {
    yaw = weapon_yaw - 90;
  } else {
    yaw = weapon_yaw + 90;
  }
  self.og_origin = self.origin;
  self.origin = self.origin + (anglesToForward((0, yaw, 0)) * 8);
  wait(0.05);
  self show();
  zm_utility::play_sound_at_pos("weapon_show", self.origin, self);
  time = 1;
  if(!isDefined(self._linked_ent)) {
    self moveto(self.og_origin, time);
  }
}

function get_pack_a_punch_camo_index(prev_pap_index) {
  if(isDefined(level.pack_a_punch_camo_index_number_variants)) {
    if(isDefined(prev_pap_index)) {
      camo_variant = prev_pap_index + 1;
      if(camo_variant >= (level.pack_a_punch_camo_index + level.pack_a_punch_camo_index_number_variants)) {
        camo_variant = level.pack_a_punch_camo_index;
      }
      return camo_variant;
    }
    camo_variant = randomintrange(0, level.pack_a_punch_camo_index_number_variants);
    return level.pack_a_punch_camo_index + camo_variant;
  }
  return level.pack_a_punch_camo_index;
}

function get_pack_a_punch_weapon_options(weapon) {
  if(!isDefined(self.pack_a_punch_weapon_options)) {
    self.pack_a_punch_weapon_options = [];
  }
  if(!is_weapon_upgraded(weapon)) {
    return self calcweaponoptions(0, 0, 0, 0, 0);
  }
  if(isDefined(self.pack_a_punch_weapon_options[weapon])) {
    return self.pack_a_punch_weapon_options[weapon];
  }
  smiley_face_reticle_index = 1;
  camo_index = get_pack_a_punch_camo_index(undefined);
  lens_index = randomintrange(0, 6);
  reticle_index = randomintrange(0, 16);
  reticle_color_index = randomintrange(0, 6);
  plain_reticle_index = 16;
  use_plain = randomint(10) < 1;
  if("saritch_upgraded" == weapon.rootweapon.name) {
    reticle_index = smiley_face_reticle_index;
  } else if(use_plain) {
    reticle_index = plain_reticle_index;
  }
  if(getdvarint("") >= 0) {
    reticle_index = getdvarint("");
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
  self.pack_a_punch_weapon_options[weapon] = self calcweaponoptions(camo_index, lens_index, reticle_index, reticle_color_index);
  return self.pack_a_punch_weapon_options[weapon];
}

function give_build_kit_weapon(weapon) {
  upgraded = 0;
  camo = undefined;
  base_weapon = weapon;
  if(is_weapon_upgraded(weapon)) {
    if(isDefined(weapon.pap_camo_to_use)) {
      camo = weapon.pap_camo_to_use;
    } else {
      camo = get_pack_a_punch_camo_index(undefined);
    }
    upgraded = 1;
    base_weapon = get_base_weapon(weapon);
  }
  if(is_weapon_included(base_weapon)) {
    force_attachments = get_force_attachments(base_weapon.rootweapon);
  }
  if(isDefined(force_attachments) && force_attachments.size) {
    if(upgraded) {
      packed_attachments = [];
      packed_attachments[packed_attachments.size] = "extclip";
      packed_attachments[packed_attachments.size] = "fmj";
      force_attachments = arraycombine(force_attachments, packed_attachments, 0, 0);
    }
    weapon = getweapon(weapon.rootweapon.name, force_attachments);
    if(!isDefined(camo)) {
      camo = 0;
    }
    weapon_options = self calcweaponoptions(camo, 0, 0);
    acvi = 0;
  } else {
    weapon = self getbuildkitweapon(weapon, upgraded);
    weapon_options = self getbuildkitweaponoptions(weapon, camo);
    acvi = self getbuildkitattachmentcosmeticvariantindexes(weapon, upgraded);
  }
  self giveweapon(weapon, weapon_options, acvi);
  return weapon;
}

function weapon_give(weapon, is_upgrade = 0, magic_box = 0, nosound = 0, b_switch_weapon = 1) {
  primaryweapons = self getweaponslistprimaries();
  initial_current_weapon = self getcurrentweapon();
  current_weapon = self switch_from_alt_weapon(initial_current_weapon);
  assert(self player_can_use_content(weapon));
  if(!isDefined(is_upgrade)) {
    is_upgrade = 0;
  }
  weapon_limit = zm_utility::get_player_weapon_limit(self);
  if(zm_equipment::is_equipment(weapon)) {
    self zm_equipment::give(weapon);
  }
  if(weapon.isriotshield) {
    if(isDefined(self.player_shield_reset_health)) {
      self[[self.player_shield_reset_health]]();
    }
  }
  if(self hasweapon(weapon)) {
    if(weapon.isballisticknife) {
      self notify("zmb_lost_knife");
    }
    self givestartammo(weapon);
    if(!zm_utility::is_offhand_weapon(weapon)) {
      self switchtoweapon(weapon);
    }
    self notify("weapon_give", weapon);
    return weapon;
  }
  if(weapon.name == "ray_gun" || weapon.name == "raygun_mark2") {
    if(self has_weapon_or_upgrade(getweapon("raygun_mark2")) && weapon.name == "ray_gun") {
      for(i = 0; i < primaryweapons.size; i++) {
        if(issubstr(primaryweapons[i].name, "raygun_mark2")) {
          self givestartammo(primaryweapons[i]);
          break;
        }
      }
      self notify("weapon_give", weapon);
      return weapon;
    }
    if(self has_weapon_or_upgrade(getweapon("ray_gun")) && weapon.name == "raygun_mark2") {
      for(i = 0; i < primaryweapons.size; i++) {
        if(issubstr(primaryweapons[i].name, "ray_gun")) {
          self weapon_take(primaryweapons[i]);
          break;
        }
      }
      weapon = self give_build_kit_weapon(weapon);
      self notify("weapon_give", weapon);
      self givestartammo(weapon);
      self switchtoweapon(weapon);
      return weapon;
    }
  }
  if(zm_utility::is_melee_weapon(weapon)) {
    current_weapon = zm_melee_weapon::change_melee_weapon(weapon, current_weapon);
  } else {
    if(zm_utility::is_hero_weapon(weapon)) {
      old_hero = self zm_utility::get_player_hero_weapon();
      if(old_hero != level.weaponnone) {
        self weapon_take(old_hero);
      }
      self zm_utility::set_player_hero_weapon(weapon);
    } else {
      if(zm_utility::is_lethal_grenade(weapon)) {
        old_lethal = self zm_utility::get_player_lethal_grenade();
        if(old_lethal != level.weaponnone) {
          self weapon_take(old_lethal);
        }
        self zm_utility::set_player_lethal_grenade(weapon);
      } else {
        if(zm_utility::is_tactical_grenade(weapon)) {
          old_tactical = self zm_utility::get_player_tactical_grenade();
          if(old_tactical != level.weaponnone) {
            self weapon_take(old_tactical);
          }
          self zm_utility::set_player_tactical_grenade(weapon);
        } else if(zm_utility::is_placeable_mine(weapon)) {
          old_mine = self zm_utility::get_player_placeable_mine();
          if(old_mine != level.weaponnone) {
            self weapon_take(old_mine);
          }
          self zm_utility::set_player_placeable_mine(weapon);
        }
      }
    }
  }
  if(!zm_utility::is_offhand_weapon(weapon)) {
    self take_fallback_weapon();
  }
  if(primaryweapons.size >= weapon_limit) {
    if(zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon)) {
      current_weapon = undefined;
    }
    if(isDefined(current_weapon)) {
      if(!zm_utility::is_offhand_weapon(weapon)) {
        if(current_weapon.isballisticknife) {
          self notify("zmb_lost_knife");
        }
        self weapon_take(current_weapon);
        if(isDefined(initial_current_weapon) && issubstr(initial_current_weapon.name, "dualoptic")) {
          self weapon_take(initial_current_weapon);
        }
      }
    }
  }
  if(isDefined(level.zombiemode_offhand_weapon_give_override)) {
    if(self[[level.zombiemode_offhand_weapon_give_override]](weapon)) {
      self notify("weapon_give", weapon);
      self zm_utility::play_sound_on_ent("purchase");
      return weapon;
    }
  }
  if(weapon.isballisticknife) {
    weapon = self zm_melee_weapon::give_ballistic_knife(weapon, is_weapon_upgraded(weapon));
  } else if(zm_utility::is_placeable_mine(weapon)) {
    self thread zm_placeable_mine::setup_for_player(weapon);
    self play_weapon_vo(weapon, magic_box);
    self notify("weapon_give", weapon);
    return weapon;
  }
  if(isDefined(level.zombie_weapons_callbacks) && isDefined(level.zombie_weapons_callbacks[weapon])) {
    self thread[[level.zombie_weapons_callbacks[weapon]]]();
    play_weapon_vo(weapon, magic_box);
    self notify("weapon_give", weapon);
    return weapon;
  }
  if(!(isDefined(nosound) && nosound)) {
    self zm_utility::play_sound_on_ent("purchase");
  }
  weapon = self give_build_kit_weapon(weapon);
  self notify("weapon_give", weapon);
  self givestartammo(weapon);
  if(b_switch_weapon && !zm_utility::is_offhand_weapon(weapon)) {
    if(!zm_utility::is_melee_weapon(weapon)) {
      self switchtoweapon(weapon);
    } else {
      self switchtoweapon(current_weapon);
    }
  }
  if(!(isDefined(nosound) && nosound)) {
    self play_weapon_vo(weapon, magic_box);
  }
  return weapon;
}

function weapon_take(weapon) {
  self notify("weapon_take", weapon);
  if(self hasweapon(weapon)) {
    self takeweapon(weapon);
  }
}

function play_weapon_vo(weapon, magic_box) {
  if(isDefined(level._audio_custom_weapon_check)) {
    type = self[[level._audio_custom_weapon_check]](weapon, magic_box);
  } else {
    type = self weapon_type_check(weapon);
  }
  if(!isDefined(type)) {
    return;
  }
  if(isDefined(level.sndweaponpickupoverride)) {
    foreach(override in level.sndweaponpickupoverride) {
      if(weapon.name === override) {
        self zm_audio::create_and_play_dialog("weapon_pickup", override);
        return;
      }
    }
  }
  if(isDefined(magic_box) && magic_box) {
    self zm_audio::create_and_play_dialog("box_pickup", type);
  } else {
    if(type == "upgrade") {
      self zm_audio::create_and_play_dialog("weapon_pickup", "upgrade");
    } else {
      if(randomintrange(0, 100) <= 50) {
        self zm_audio::create_and_play_dialog("weapon_pickup", type);
      } else {
        self zm_audio::create_and_play_dialog("weapon_pickup", "generic");
      }
    }
  }
}

function weapon_type_check(weapon) {
  if(weapon.name == "zombie_beast_grapple_dwr" || weapon.name == "zombie_beast_lightning_dwl" || weapon.name == "zombie_beast_lightning_dwl2" || weapon.name == "zombie_beast_lightning_dwl3") {
    return undefined;
  }
  if(!isDefined(self.entity_num)) {
    return "crappy";
  }
  weapon = get_nonalternate_weapon(weapon);
  weapon = weapon.rootweapon;
  if(is_weapon_upgraded(weapon)) {
    return "upgrade";
  }
  if(isDefined(level.zombie_weapons[weapon])) {
    return level.zombie_weapons[weapon].vox;
  }
  return "crappy";
}

function ammo_give(weapon) {
  give_ammo = 0;
  if(!zm_utility::is_offhand_weapon(weapon)) {
    weapon = self get_weapon_with_attachments(weapon);
    if(isDefined(weapon)) {
      stockmax = 0;
      stockmax = weapon.maxammo;
      clipcount = self getweaponammoclip(weapon);
      dw_clipcount = self getweaponammoclip(weapon.dualwieldweapon);
      currstock = self getammocount(weapon);
      if(((currstock - clipcount) + dw_clipcount) >= stockmax) {
        give_ammo = 0;
      } else {
        give_ammo = 1;
      }
    }
  } else if(self has_weapon_or_upgrade(weapon)) {
    if(self getammocount(weapon) < weapon.maxammo) {
      give_ammo = 1;
    }
  }
  if(give_ammo) {
    self zm_utility::play_sound_on_ent("purchase");
    self givemaxammo(weapon);
    alt_weap = weapon.altweapon;
    if(level.weaponnone != alt_weap) {
      self givemaxammo(alt_weap);
    }
    return true;
  }
  if(!give_ammo) {
    return false;
  }
}

function get_default_weapondata(weapon) {
  weapondata = [];
  weapondata["weapon"] = weapon;
  dw_weapon = weapon.dualwieldweapon;
  alt_weapon = weapon.altweapon;
  weaponnone = getweapon("none");
  if(isDefined(level.weaponnone)) {
    weaponnone = level.weaponnone;
  }
  if(weapon != weaponnone) {
    weapondata["clip"] = weapon.clipsize;
    weapondata["stock"] = weapon.maxammo;
    weapondata["fuel"] = weapon.fuellife;
    weapondata["heat"] = 0;
    weapondata["overheat"] = 0;
  }
  if(dw_weapon != weaponnone) {
    weapondata["lh_clip"] = dw_weapon.clipsize;
  } else {
    weapondata["lh_clip"] = 0;
  }
  if(alt_weapon != weaponnone) {
    weapondata["alt_clip"] = alt_weapon.clipsize;
    weapondata["alt_stock"] = alt_weapon.maxammo;
  } else {
    weapondata["alt_clip"] = 0;
    weapondata["alt_stock"] = 0;
  }
  return weapondata;
}

function get_player_weapondata(player, weapon) {
  weapondata = [];
  if(!isDefined(weapon)) {
    weapon = player getcurrentweapon();
  }
  weapondata["weapon"] = weapon;
  if(weapondata["weapon"] != level.weaponnone) {
    weapondata["clip"] = player getweaponammoclip(weapon);
    weapondata["stock"] = player getweaponammostock(weapon);
    weapondata["fuel"] = player getweaponammofuel(weapon);
    weapondata["heat"] = player isweaponoverheating(1, weapon);
    weapondata["overheat"] = player isweaponoverheating(0, weapon);
  } else {
    weapondata["clip"] = 0;
    weapondata["stock"] = 0;
    weapondata["fuel"] = 0;
    weapondata["heat"] = 0;
    weapondata["overheat"] = 0;
  }
  dw_weapon = weapon.dualwieldweapon;
  if(dw_weapon != level.weaponnone) {
    weapondata["lh_clip"] = player getweaponammoclip(dw_weapon);
  } else {
    weapondata["lh_clip"] = 0;
  }
  alt_weapon = weapon.altweapon;
  if(alt_weapon != level.weaponnone) {
    weapondata["alt_clip"] = player getweaponammoclip(alt_weapon);
    weapondata["alt_stock"] = player getweaponammostock(alt_weapon);
  } else {
    weapondata["alt_clip"] = 0;
    weapondata["alt_stock"] = 0;
  }
  return weapondata;
}

function weapon_is_better(left, right) {
  if(left != right) {
    left_upgraded = !isDefined(level.zombie_weapons[left]);
    right_upgraded = !isDefined(level.zombie_weapons[right]);
    if(left_upgraded && right_upgraded) {
      leftatt = get_attachment_index(left);
      rightatt = get_attachment_index(right);
      return leftatt > rightatt;
    }
    if(left_upgraded) {
      return 1;
    }
  }
  return 0;
}

function merge_weapons(oldweapondata, newweapondata) {
  weapondata = [];
  if(weapon_is_better(oldweapondata["weapon"], newweapondata["weapon"])) {
    weapondata["weapon"] = oldweapondata["weapon"];
  } else {
    weapondata["weapon"] = newweapondata["weapon"];
  }
  weapon = weapondata["weapon"];
  dw_weapon = weapon.dualwieldweapon;
  alt_weapon = weapon.altweapon;
  if(weapon != level.weaponnone) {
    weapondata["clip"] = newweapondata["clip"] + oldweapondata["clip"];
    weapondata["clip"] = int(min(weapondata["clip"], weapon.clipsize));
    weapondata["stock"] = newweapondata["stock"] + oldweapondata["stock"];
    weapondata["stock"] = int(min(weapondata["stock"], weapon.maxammo));
    weapondata["fuel"] = newweapondata["fuel"] + oldweapondata["fuel"];
    weapondata["fuel"] = int(min(weapondata["fuel"], weapon.fuellife));
    weapondata["heat"] = int(min(newweapondata["heat"], oldweapondata["heat"]));
    weapondata["overheat"] = int(min(newweapondata["overheat"], oldweapondata["overheat"]));
  }
  if(dw_weapon != level.weaponnone) {
    weapondata["lh_clip"] = newweapondata["lh_clip"] + oldweapondata["lh_clip"];
    weapondata["lh_clip"] = int(min(weapondata["lh_clip"], dw_weapon.clipsize));
  }
  if(alt_weapon != level.weaponnone) {
    weapondata["alt_clip"] = newweapondata["alt_clip"] + oldweapondata["alt_clip"];
    weapondata["alt_clip"] = int(min(weapondata["alt_clip"], alt_weapon.clipsize));
    weapondata["alt_stock"] = newweapondata["alt_stock"] + oldweapondata["alt_stock"];
    weapondata["alt_stock"] = int(min(weapondata["alt_stock"], alt_weapon.maxammo));
  }
  return weapondata;
}

function weapondata_give(weapondata) {
  current = self get_player_weapon_with_same_base(weapondata["weapon"]);
  if(isDefined(current)) {
    curweapondata = get_player_weapondata(self, current);
    self weapon_take(current);
    weapondata = merge_weapons(curweapondata, weapondata);
  }
  weapon = weapondata["weapon"];
  weapon_give(weapon, undefined, undefined, 1);
  if(weapon != level.weaponnone) {
    self setweaponammoclip(weapon, weapondata["clip"]);
    self setweaponammostock(weapon, weapondata["stock"]);
    if(isDefined(weapondata["fuel"])) {
      self setweaponammofuel(weapon, weapondata["fuel"]);
    }
    if(isDefined(weapondata["heat"]) && isDefined(weapondata["overheat"])) {
      self setweaponoverheating(weapondata["overheat"], weapondata["heat"], weapon);
    }
  }
  dw_weapon = weapon.dualwieldweapon;
  if(dw_weapon != level.weaponnone) {
    if(!self hasweapon(dw_weapon)) {
      self giveweapon(dw_weapon);
    }
    self setweaponammoclip(dw_weapon, weapondata["lh_clip"]);
  }
  alt_weapon = weapon.altweapon;
  if(alt_weapon != level.weaponnone && alt_weapon.altweapon == weapon) {
    if(!self hasweapon(alt_weapon)) {
      self giveweapon(alt_weapon);
    }
    self setweaponammoclip(alt_weapon, weapondata["alt_clip"]);
    self setweaponammostock(alt_weapon, weapondata["alt_stock"]);
  }
}

function weapondata_take(weapondata) {
  weapon = weapondata["weapon"];
  if(weapon != level.weaponnone) {
    if(self hasweapon(weapon)) {
      self weapon_take(weapon);
    }
  }
  dw_weapon = weapon.dualwieldweapon;
  if(dw_weapon != level.weaponnone) {
    if(self hasweapon(dw_weapon)) {
      self weapon_take(dw_weapon);
    }
  }
  alt_weapon = weapon.altweapon;
  while(alt_weapon != level.weaponnone) {
    if(self hasweapon(alt_weapon)) {
      self weapon_take(alt_weapon);
    }
    alt_weapon = alt_weapon.altweapon;
  }
}

function create_loadout(weapons) {
  weaponnone = getweapon("none");
  if(isDefined(level.weaponnone)) {
    weaponnone = level.weaponnone;
  }
  loadout = spawnStruct();
  loadout.weapons = [];
  foreach(weapon in weapons) {
    if(isstring(weapon)) {
      weapon = getweapon(weapon);
    }
    if(weapon == weaponnone) {
      println("" + weapon.name);
    }
    loadout.weapons[weapon.name] = get_default_weapondata(weapon);
    if(!isDefined(loadout.current)) {
      loadout.current = weapon;
    }
  }
  return loadout;
}

function player_get_loadout() {
  loadout = spawnStruct();
  loadout.current = self getcurrentweapon();
  loadout.stowed = self getstowedweapon();
  loadout.weapons = [];
  foreach(weapon in self getweaponslist()) {
    loadout.weapons[weapon.name] = get_player_weapondata(self, weapon);
  }
  return loadout;
}

function player_give_loadout(loadout, replace_existing = 1, immediate_switch = 0) {
  if(isDefined(replace_existing) && replace_existing) {
    self takeallweapons();
  }
  foreach(weapondata in loadout.weapons) {
    self weapondata_give(weapondata);
  }
  if(!zm_utility::is_offhand_weapon(loadout.current)) {
    if(immediate_switch) {
      self switchtoweaponimmediate(loadout.current);
    } else {
      self switchtoweapon(loadout.current);
    }
  } else {
    if(immediate_switch) {
      self switchtoweaponimmediate();
    } else {
      self switchtoweapon();
    }
  }
  if(isDefined(loadout.stowed)) {
    self setstowedweapon(loadout.stowed);
  }
}

function player_take_loadout(loadout) {
  foreach(weapondata in loadout.weapons) {
    self weapondata_take(weapondata);
  }
}

function register_zombie_weapon_callback(weapon, func) {
  if(!isDefined(level.zombie_weapons_callbacks)) {
    level.zombie_weapons_callbacks = [];
  }
  if(!isDefined(level.zombie_weapons_callbacks[weapon])) {
    level.zombie_weapons_callbacks[weapon] = func;
  }
}

function set_stowed_weapon(weapon) {
  self.weapon_stowed = weapon;
  if(!(isDefined(self.stowed_weapon_suppressed) && self.stowed_weapon_suppressed)) {
    self setstowedweapon(self.weapon_stowed);
  }
}

function clear_stowed_weapon() {
  self.weapon_stowed = undefined;
  self clearstowedweapon();
}

function suppress_stowed_weapon(onoff) {
  self.stowed_weapon_suppressed = onoff;
  if(onoff || !isDefined(self.weapon_stowed)) {
    self clearstowedweapon();
  } else {
    self setstowedweapon(self.weapon_stowed);
  }
}

function checkstringvalid(str) {
  if(str != "") {
    return str;
  }
  return undefined;
}

function load_weapon_spec_from_table(table, first_row) {
  gametype = getdvarstring("ui_gametype");
  index = 1;
  row = tablelookuprow(table, index);
  while(isDefined(row)) {
    weapon_name = checkstringvalid(row[0]);
    upgrade_name = checkstringvalid(row[1]);
    hint = checkstringvalid(row[2]);
    cost = int(row[3]);
    weaponvo = checkstringvalid(row[4]);
    weaponvoresp = checkstringvalid(row[5]);
    ammo_cost = undefined;
    if("" != row[6]) {
      ammo_cost = int(row[6]);
    }
    create_vox = checkstringvalid(row[7]);
    is_zcleansed = tolower(row[8]) == "true";
    in_box = tolower(row[9]) == "true";
    upgrade_in_box = tolower(row[10]) == "true";
    is_limited = tolower(row[11]) == "true";
    is_aat_exempt = tolower(row[17]) == "true";
    limit = int(row[12]);
    upgrade_limit = int(row[13]);
    content_restrict = row[14];
    wallbuy_autospawn = tolower(row[15]) == "true";
    weapon_class = checkstringvalid(row[16]);
    is_wonder_weapon = tolower(row[18]) == "true";
    force_attachments = tolower(row[19]);
    zm_utility::include_weapon(weapon_name, in_box);
    if(isDefined(upgrade_name)) {
      zm_utility::include_weapon(upgrade_name, upgrade_in_box);
    }
    add_zombie_weapon(weapon_name, upgrade_name, hint, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, is_wonder_weapon, force_attachments);
    if(is_limited) {
      if(isDefined(limit)) {
        add_limited_weapon(weapon_name, limit);
      }
      if(isDefined(upgrade_limit) && isDefined(upgrade_name)) {
        add_limited_weapon(upgrade_name, upgrade_limit);
      }
    }
    if(is_aat_exempt && isDefined(upgrade_name)) {
      aat::register_aat_exemption(getweapon(upgrade_name));
    }
    index++;
    row = tablelookuprow(table, index);
  }
}

function autofill_wallbuys_init() {
  wallbuys = struct::get_array("wallbuy_autofill", "targetname");
  if(!isDefined(wallbuys) || wallbuys.size == 0 || !isDefined(level.wallbuy_autofill_weapons) || level.wallbuy_autofill_weapons.size == 0) {
    return;
  }
  level.use_autofill_wallbuy = 1;
  level.active_autofill_wallbuys = [];
  array_keys["all"] = getarraykeys(level.wallbuy_autofill_weapons["all"]);
  class_all = [];
  index = 0;
  foreach(wallbuy in wallbuys) {
    weapon_class = wallbuy.script_string;
    weapon = undefined;
    if(isDefined(weapon_class) && weapon_class != "") {
      if(!isDefined(array_keys[weapon_class]) && isDefined(level.wallbuy_autofill_weapons[weapon_class])) {
        array_keys[weapon_class] = getarraykeys(level.wallbuy_autofill_weapons[weapon_class]);
      }
      if(isDefined(array_keys[weapon_class])) {
        for(i = 0; i < array_keys[weapon_class].size; i++) {
          if(level.wallbuy_autofill_weapons["all"][array_keys[weapon_class][i]]) {
            weapon = array_keys[weapon_class][i];
            level.wallbuy_autofill_weapons["all"][weapon] = 0;
            break;
          }
        }
      } else {
        continue;
      }
    } else {
      class_all[class_all.size] = wallbuy;
      continue;
    }
    if(!isDefined(weapon)) {
      continue;
    }
    wallbuy.zombie_weapon_upgrade = weapon.name;
    wallbuy.weapon = weapon;
    right = anglestoright(wallbuy.angles);
    wallbuy.origin = wallbuy.origin - (right * 2);
    wallbuy.target = "autofill_wallbuy_" + index;
    target_struct = spawnStruct();
    target_struct.targetname = wallbuy.target;
    target_struct.angles = wallbuy.angles;
    target_struct.origin = wallbuy.origin;
    model = wallbuy.weapon.worldmodel;
    target_struct.model = model;
    target_struct struct::init();
    level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
    index++;
  }
  foreach(wallbuy in class_all) {
    weapon = undefined;
    for(i = 0; i < array_keys["all"].size; i++) {
      if(level.wallbuy_autofill_weapons["all"][array_keys["all"][i]]) {
        weapon = array_keys["all"][i];
        level.wallbuy_autofill_weapons["all"][weapon] = 0;
        break;
      }
    }
    if(!isDefined(weapon)) {
      break;
    }
    wallbuy.zombie_weapon_upgrade = weapon.name;
    wallbuy.weapon = weapon;
    right = anglestoright(wallbuy.angles);
    wallbuy.origin = wallbuy.origin - (right * 2);
    wallbuy.target = "autofill_wallbuy_" + index;
    target_struct = spawnStruct();
    target_struct.targetname = wallbuy.target;
    target_struct.angles = wallbuy.angles;
    target_struct.origin = wallbuy.origin;
    model = wallbuy.weapon.worldmodel;
    target_struct.model = model;
    target_struct struct::init();
    level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
    index++;
  }
}

function is_wallbuy(w_to_check) {
  w_base = get_base_weapon(w_to_check);
  foreach(s_wallbuy in level._spawned_wallbuys) {
    if(s_wallbuy.weapon == w_base) {
      return true;
    }
  }
  return false;
}

function is_wonder_weapon(w_to_check) {
  w_base = get_base_weapon(w_to_check);
  if(isDefined(level.zombie_weapons[w_base]) && level.zombie_weapons[w_base].is_wonder_weapon) {
    return true;
  }
  return false;
}