/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_equipment.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_equipment;

function autoexec __init__sytem__() {
  system::register("zm_equipment", &__init__, &__main__, undefined);
}

function __init__() {
  level.buildable_piece_count = 24;
  level._equipment_disappear_fx = "_t6/maps/zombie/fx_zmb_tranzit_electrap_explo";
  level.placeable_equipment_destroy_fn = [];
  if(!(isDefined(level._no_equipment_activated_clientfield) && level._no_equipment_activated_clientfield)) {
    clientfield::register("scriptmover", "equipment_activated", 1, 4, "int");
  }
  level thread function_f30ee99e();
}

function __main__() {
  init_upgrade();
}

function signal_activated(val = 1) {
  if(isDefined(level._no_equipment_activated_clientfield) && level._no_equipment_activated_clientfield) {
    return;
  }
  self endon("death");
  self clientfield::set("equipment_activated", val);
  for(i = 0; i < 2; i++) {
    util::wait_network_frame();
  }
  self clientfield::set("equipment_activated", 0);
}

function register(equipment_name, hint, howto_hint, hint_icon, equipmentvo) {
  equipment = getweapon(equipment_name);
  struct = spawnStruct();
  if(!isDefined(level.zombie_equipment)) {
    level.zombie_equipment = [];
  }
  struct.equipment = equipment;
  struct.hint = hint;
  struct.howto_hint = howto_hint;
  struct.hint_icon = hint_icon;
  struct.vox = equipmentvo;
  struct.triggers = [];
  struct.models = [];
  struct.notify_strings = spawnStruct();
  struct.notify_strings.activate = equipment.name + "_activate";
  struct.notify_strings.deactivate = equipment.name + "_deactivate";
  struct.notify_strings.taken = equipment.name + "_taken";
  struct.notify_strings.pickup = equipment.name + "_pickup";
  level.zombie_equipment[equipment] = struct;
  level thread function_de79cac6(equipment);
}

function register_slot_watcher_override(str_equipment, func_slot_watcher_override) {
  level.a_func_equipment_slot_watcher_override[str_equipment] = func_slot_watcher_override;
}

function is_included(equipment) {
  if(!isDefined(level.zombie_include_equipment)) {
    return 0;
  }
  if(isstring(equipment)) {
    equipment = getweapon(equipment);
  }
  return isDefined(level.zombie_include_equipment[equipment.rootweapon]);
}

function include(equipment_name) {
  if(!isDefined(level.zombie_include_equipment)) {
    level.zombie_include_equipment = [];
  }
  level.zombie_include_equipment[getweapon(equipment_name)] = 1;
}

function set_ammo_driven(equipment_name, start, refill_max_ammo = 0) {
  level.zombie_equipment[getweapon(equipment_name)].notake = 1;
  level.zombie_equipment[getweapon(equipment_name)].start_ammo = start;
  level.zombie_equipment[getweapon(equipment_name)].refill_max_ammo = refill_max_ammo;
}

function limit(equipment_name, limited) {
  if(!isDefined(level._limited_equipment)) {
    level._limited_equipment = [];
  }
  if(limited) {
    level._limited_equipment[level._limited_equipment.size] = getweapon(equipment_name);
  } else {
    arrayremovevalue(level._limited_equipment, getweapon(equipment_name), 0);
  }
}

function init_upgrade() {
  equipment_spawns = [];
  equipment_spawns = getEntArray("zombie_equipment_upgrade", "targetname");
  for(i = 0; i < equipment_spawns.size; i++) {
    equipment_spawns[i].equipment = getweapon(equipment_spawns[i].zombie_equipment_upgrade);
    hint_string = get_hint(equipment_spawns[i].equipment);
    equipment_spawns[i] sethintstring(hint_string);
    equipment_spawns[i] setcursorhint("HINT_NOICON");
    equipment_spawns[i] usetriggerrequirelookat();
    equipment_spawns[i] add_to_trigger_list(equipment_spawns[i].equipment);
    equipment_spawns[i] thread equipment_spawn_think();
  }
}

function get_hint(equipment) {
  assert(isDefined(level.zombie_equipment[equipment]), equipment.name + "");
  return level.zombie_equipment[equipment].hint;
}

function get_howto_hint(equipment) {
  assert(isDefined(level.zombie_equipment[equipment]), equipment.name + "");
  return level.zombie_equipment[equipment].howto_hint;
}

function get_icon(equipment) {
  assert(isDefined(level.zombie_equipment[equipment]), equipment.name + "");
  return level.zombie_equipment[equipment].hint_icon;
}

function get_notify_strings(equipment) {
  assert(isDefined(level.zombie_equipment[equipment]), equipment.name + "");
  return level.zombie_equipment[equipment].notify_strings;
}

function add_to_trigger_list(equipment) {
  assert(isDefined(level.zombie_equipment[equipment]), equipment.name + "");
  level.zombie_equipment[equipment].triggers[level.zombie_equipment[equipment].triggers.size] = self;
  level.zombie_equipment[equipment].models[level.zombie_equipment[equipment].models.size] = getent(self.target, "targetname");
}

function equipment_spawn_think() {
  for(;;) {
    self waittill("trigger", player);
    if(player zm_utility::in_revive_trigger() || player.is_drinking > 0) {
      wait(0.1);
      continue;
    }
    if(!is_limited(self.equipment) || !limited_in_use(self.equipment)) {
      if(is_limited(self.equipment)) {
        player setup_limited(self.equipment);
        if(isDefined(level.hacker_tool_positions)) {
          new_pos = array::random(level.hacker_tool_positions);
          self.origin = new_pos.trigger_org;
          model = getent(self.target, "targetname");
          model.origin = new_pos.model_org;
          model.angles = new_pos.model_ang;
        }
      }
      player give(self.equipment);
      continue;
    }
    wait(0.1);
  }
}

function set_equipment_invisibility_to_player(equipment, invisible) {
  triggers = level.zombie_equipment[equipment].triggers;
  for(i = 0; i < triggers.size; i++) {
    if(isDefined(triggers[i])) {
      triggers[i] setinvisibletoplayer(self, invisible);
    }
  }
  models = level.zombie_equipment[equipment].models;
  for(i = 0; i < models.size; i++) {
    if(isDefined(models[i])) {
      models[i] setinvisibletoplayer(self, invisible);
    }
  }
}

function take(equipment = self get_player_equipment()) {
  if(!isDefined(equipment)) {
    return;
  }
  if(equipment == level.weaponnone) {
    return;
  }
  if(!self has_player_equipment(equipment)) {
    return;
  }
  current = 0;
  current_weapon = 0;
  if(isDefined(self get_player_equipment()) && equipment == self get_player_equipment()) {
    current = 1;
  }
  if(equipment == self getcurrentweapon()) {
    current_weapon = 1;
  }
  println(((("" + self.name) + "") + equipment.name) + "");
  notify_strings = get_notify_strings(equipment);
  if(isDefined(self.current_equipment_active[equipment]) && self.current_equipment_active[equipment]) {
    self.current_equipment_active[equipment] = 0;
    self notify(notify_strings.deactivate);
  }
  self notify(notify_strings.taken);
  self takeweapon(equipment);
  if(!is_limited(equipment) || (is_limited(equipment) && !limited_in_use(equipment))) {
    self set_equipment_invisibility_to_player(equipment, 0);
  }
  if(current) {
    self set_player_equipment(level.weaponnone);
    self setactionslot(2, "");
  } else {
    arrayremovevalue(self.deployed_equipment, equipment);
  }
  if(current_weapon) {
    self zm_weapons::switch_back_primary_weapon();
  }
}

function give(equipment) {
  if(!isDefined(equipment)) {
    return;
  }
  if(!isDefined(level.zombie_equipment[equipment])) {
    return;
  }
  if(self has_player_equipment(equipment)) {
    return;
  }
  println(((("" + self.name) + "") + equipment.name) + "");
  curr_weapon = self getcurrentweapon();
  curr_weapon_was_curr_equipment = self is_player_equipment(curr_weapon);
  self take();
  self set_player_equipment(equipment);
  self giveweapon(equipment);
  self start_ammo(equipment);
  self thread show_hint(equipment);
  self set_equipment_invisibility_to_player(equipment, 1);
  self setactionslot(2, "weapon", equipment);
  self thread slot_watcher(equipment);
  self zm_audio::create_and_play_dialog("weapon_pickup", level.zombie_equipment[equipment].vox);
  self notify("player_given", equipment);
}

function buy(equipment) {
  if(isstring(equipment)) {
    equipment = getweapon(equipment);
  }
  println(((("" + self.name) + "") + equipment.name) + "");
  if(isDefined(self.current_equipment) && equipment != self.current_equipment && self.current_equipment != level.weaponnone) {
    self take(self.current_equipment);
  }
  self notify("player_bought", equipment);
  self give(equipment);
  if(equipment.isriotshield && isDefined(self.player_shield_reset_health)) {
    self[[self.player_shield_reset_health]]();
  }
}

function slot_watcher(equipment) {
  self notify("kill_equipment_slot_watcher");
  self endon("kill_equipment_slot_watcher");
  self endon("disconnect");
  notify_strings = get_notify_strings(equipment);
  while(true) {
    self waittill("weapon_change", curr_weapon, prev_weapon);
    if(self.sessionstate != "spectator") {
      self.prev_weapon_before_equipment_change = undefined;
      if(isDefined(prev_weapon) && level.weaponnone != prev_weapon) {
        prev_weapon_type = prev_weapon.inventorytype;
        if("primary" == prev_weapon_type || "altmode" == prev_weapon_type) {
          self.prev_weapon_before_equipment_change = prev_weapon;
        }
      }
      if(!isDefined(level.a_func_equipment_slot_watcher_override)) {
        level.a_func_equipment_slot_watcher_override = [];
      }
      if(isDefined(level.a_func_equipment_slot_watcher_override[equipment.name])) {
        self[[level.a_func_equipment_slot_watcher_override[equipment.name]]](equipment, curr_weapon, prev_weapon, notify_strings);
      } else {
        if(curr_weapon == equipment && !self.current_equipment_active[equipment]) {
          self notify(notify_strings.activate);
          self.current_equipment_active[equipment] = 1;
        } else if(curr_weapon != equipment && self.current_equipment_active[equipment]) {
          self notify(notify_strings.deactivate);
          self.current_equipment_active[equipment] = 0;
        }
      }
    }
  }
}

function is_limited(equipment) {
  if(isDefined(level._limited_equipment)) {
    for(i = 0; i < level._limited_equipment.size; i++) {
      if(level._limited_equipment[i] == equipment) {
        return true;
      }
    }
  }
  return false;
}

function limited_in_use(equipment) {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    current_equipment = players[i] get_player_equipment();
    if(isDefined(current_equipment) && current_equipment == equipment) {
      return true;
    }
  }
  if(isDefined(level.dropped_equipment) && isDefined(level.dropped_equipment[equipment])) {
    return true;
  }
  return false;
}

function setup_limited(equipment) {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] set_equipment_invisibility_to_player(equipment, 1);
  }
  self thread release_limited_on_disconnect(equipment);
  self thread release_limited_on_taken(equipment);
}

function release_limited_on_taken(equipment) {
  self endon("disconnect");
  notify_strings = get_notify_strings(equipment);
  self util::waittill_either(notify_strings.taken, "spawned_spectator");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] set_equipment_invisibility_to_player(equipment, 0);
  }
}

function release_limited_on_disconnect(equipment) {
  notify_strings = get_notify_strings(equipment);
  self endon(notify_strings.taken);
  self waittill("disconnect");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(isalive(players[i])) {
      players[i] set_equipment_invisibility_to_player(equipment, 0);
    }
  }
}

function is_active(equipment) {
  if(!isDefined(self.current_equipment_active) || !isDefined(self.current_equipment_active[equipment])) {
    return 0;
  }
  return self.current_equipment_active[equipment];
}

function init_hint_hudelem(x, y, alignx, aligny, fontscale, alpha) {
  self.x = x;
  self.y = y;
  self.alignx = alignx;
  self.aligny = aligny;
  self.fontscale = fontscale;
  self.alpha = alpha;
  self.sort = 20;
}

function setup_client_hintelem(ypos = 220, font_scale = 1.25) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(self.hintelem)) {
    self.hintelem = newclienthudelem(self);
  }
  if(self issplitscreen()) {
    if(getdvarint("splitscreen_playerCount") >= 3) {
      self.hintelem init_hint_hudelem(160, 90, "center", "middle", font_scale * 0.8, 1);
    } else {
      self.hintelem init_hint_hudelem(160, 90, "center", "middle", font_scale, 1);
    }
  } else {
    self.hintelem init_hint_hudelem(320, ypos, "center", "bottom", font_scale, 1);
  }
}

function show_hint(equipment) {
  self notify("kill_previous_show_equipment_hint_thread");
  self endon("kill_previous_show_equipment_hint_thread");
  self endon("death");
  self endon("disconnect");
  if(isDefined(self.do_not_display_equipment_pickup_hint) && self.do_not_display_equipment_pickup_hint) {
    return;
  }
  wait(0.5);
  text = get_howto_hint(equipment);
  self show_hint_text(text);
}

function show_hint_text(text, show_for_time = 3.2, font_scale = 1.25, ypos = 220) {
  self notify("hide_equipment_hint_text");
  wait(0.05);
  self setup_client_hintelem(ypos, font_scale);
  self.hintelem settext(text);
  self.hintelem.alpha = 1;
  self.hintelem.font = "small";
  self.hintelem.hidewheninmenu = 1;
  time = self util::waittill_any_timeout(show_for_time, "hide_equipment_hint_text", "death", "disconnect");
  if(isDefined(time) && isDefined(self) && isDefined(self.hintelem)) {
    self.hintelem fadeovertime(0.25);
    self.hintelem.alpha = 0;
    self util::waittill_any_timeout(0.25, "hide_equipment_hint_text");
  }
  if(isDefined(self) && isDefined(self.hintelem)) {
    self.hintelem settext("");
    self.hintelem destroy();
  }
}

function start_ammo(equipment) {
  if(self hasweapon(equipment)) {
    maxammo = 1;
    if(isDefined(level.zombie_equipment[equipment].notake) && level.zombie_equipment[equipment].notake) {
      maxammo = level.zombie_equipment[equipment].start_ammo;
    }
    self setweaponammoclip(equipment, maxammo);
    self notify("equipment_ammo_changed", equipment);
    return maxammo;
  }
  return 0;
}

function change_ammo(equipment, change) {
  if(self hasweapon(equipment)) {
    oldammo = self getweaponammoclip(equipment);
    maxammo = 1;
    if(isDefined(level.zombie_equipment[equipment].notake) && level.zombie_equipment[equipment].notake) {
      maxammo = level.zombie_equipment[equipment].start_ammo;
    }
    newammo = int(min(maxammo, max(0, oldammo + change)));
    self setweaponammoclip(equipment, newammo);
    self notify("equipment_ammo_changed", equipment);
    return newammo;
  }
  return 0;
}

function disappear_fx(origin, fx, angles) {
  effect = level._equipment_disappear_fx;
  if(isDefined(fx)) {
    effect = fx;
  }
  if(isDefined(angles)) {
    playFX(effect, origin, anglesToForward(angles));
  } else {
    playFX(effect, origin);
  }
  wait(1.1);
}

function register_for_level(weaponname) {
  weapon = getweapon(weaponname);
  if(is_equipment(weapon)) {
    return;
  }
  if(!isDefined(level.zombie_equipment_list)) {
    level.zombie_equipment_list = [];
  }
  level.zombie_equipment_list[weapon] = weapon;
}

function is_equipment(weapon) {
  if(!isDefined(weapon) || !isDefined(level.zombie_equipment_list)) {
    return 0;
  }
  return isDefined(level.zombie_equipment_list[weapon]);
}

function is_equipment_that_blocks_purchase(weapon) {
  return is_equipment(weapon);
}

function is_player_equipment(weapon) {
  if(!isDefined(weapon) || !isDefined(self.current_equipment)) {
    return 0;
  }
  return self.current_equipment == weapon;
}

function has_deployed_equipment(weapon) {
  if(!isDefined(weapon) || !isDefined(self.deployed_equipment) || self.deployed_equipment.size < 1) {
    return false;
  }
  for(i = 0; i < self.deployed_equipment.size; i++) {
    if(self.deployed_equipment[i] == weapon) {
      return true;
    }
  }
  return false;
}

function has_player_equipment(weapon) {
  return self is_player_equipment(weapon) || self has_deployed_equipment(weapon);
}

function get_player_equipment() {
  equipment = level.weaponnone;
  if(isDefined(self.current_equipment)) {
    equipment = self.current_equipment;
  }
  return equipment;
}

function hacker_active() {
  return self is_active(getweapon("equip_hacker"));
}

function set_player_equipment(weapon) {
  if(!isDefined(self.current_equipment_active)) {
    self.current_equipment_active = [];
  }
  if(isDefined(weapon)) {
    self.current_equipment_active[weapon] = 0;
  }
  if(!isDefined(self.equipment_got_in_round)) {
    self.equipment_got_in_round = [];
  }
  if(isDefined(weapon)) {
    self.equipment_got_in_round[weapon] = level.round_number;
  }
  self notify("new_equipment", weapon);
  self.current_equipment = weapon;
}

function init_player_equipment() {
  self set_player_equipment(level.zombie_equipment_player_init);
}

function function_f30ee99e() {
  setDvar("", "");
  wait(0.05);
  level flag::wait_till("");
  wait(0.05);
  str_cmd = ("" + "") + "";
  adddebugcommand(str_cmd);
  while(true) {
    equipment_id = getdvarstring("");
    if(equipment_id != "") {
      foreach(player in getplayers()) {
        if(equipment_id == "") {
          player take();
          continue;
        }
        if(is_included(equipment_id)) {
          player buy(equipment_id);
        }
      }
      setDvar("", "");
    }
    wait(0.05);
  }
}

function function_de79cac6(equipment) {
  wait(0.05);
  level flag::wait_till("");
  wait(0.05);
  if(isDefined(equipment)) {
    equipment_id = equipment.name;
    str_cmd = ((("" + equipment_id) + "") + equipment_id) + "";
    adddebugcommand(str_cmd);
  }
}