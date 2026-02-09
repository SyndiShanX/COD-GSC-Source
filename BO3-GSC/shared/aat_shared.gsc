/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\aat_shared.gsc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#namespace aat;

function autoexec __init__sytem__() {
  system::register("aat", &__init__, &__main__, undefined);
}

function private __init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }
  level.aat_initializing = 1;
  level.aat = [];
  level.aat["none"] = spawnStruct();
  level.aat["none"].name = "none";
  level.aat_reroll = [];
  callback::on_connect(&on_player_connect);
  spawners = getspawnerarray();
  foreach(spawner in spawners) {
    spawner spawner::add_spawn_function(&aat_cooldown_init);
  }
  level.aat_exemptions = [];
  zm::register_vehicle_damage_callback(&aat_vehicle_damage_monitor);
  callback::on_finalize_initialization(&finalize_clientfields);
  level thread setup_devgui();
}

function __main__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }
  zm::register_zombie_damage_override_callback(&aat_response);
}

function private on_player_connect() {
  self.aat = [];
  self.aat_cooldown_start = [];
  keys = getarraykeys(level.aat);
  foreach(key in keys) {
    self.aat_cooldown_start[key] = 0;
  }
  self thread watch_weapon_changes();
}

function private setup_devgui() {
  waittillframeend();
  setDvar("", "");
  aat_devgui_base = "";
  keys = getarraykeys(level.aat);
  foreach(key in keys) {
    if(key != "") {
      adddebugcommand((((((aat_devgui_base + key) + "") + "") + "") + key) + "");
    }
  }
  adddebugcommand(((((aat_devgui_base + "") + "") + "") + "") + "");
  level thread aat_devgui_think();
}

function private aat_devgui_think() {
  for(;;) {
    aat_name = getdvarstring("");
    if(aat_name != "") {
      for(i = 0; i < level.players.size; i++) {
        if(aat_name == "") {
          level.players[i] thread remove(level.players[i] getcurrentweapon());
        } else {
          level.players[i] thread acquire(level.players[i] getcurrentweapon(), aat_name);
        }
        level.players[i] thread aat_set_debug_text(aat_name, 0, 0, 0);
      }
    }
    setDvar("", "");
    wait(0.5);
  }
}

function private aat_debug_text_display_init() {
  self.aat_debug_text = newclienthudelem(self);
  self.aat_debug_text.elemtype = "";
  self.aat_debug_text.font = "";
  self.aat_debug_text.fontscale = 1.8;
  self.aat_debug_text.horzalign = "";
  self.aat_debug_text.vertalign = "";
  self.aat_debug_text.alignx = "";
  self.aat_debug_text.aligny = "";
  self.aat_debug_text.x = 15;
  self.aat_debug_text.y = 15;
  self.aat_debug_text.sort = 2;
  self.aat_debug_text.color = (1, 1, 1);
  self.aat_debug_text.alpha = 1;
  self.aat_debug_text.hidewheninmenu = 1;
  self thread aat_debug_text_display_monitor();
}

function private aat_debug_text_display_monitor() {
  self endon("disconnect");
  while(true) {
    self waittill("weapon_change", weapon);
    name = "";
    if(isDefined(self.aat[weapon])) {
      name = self.aat[weapon];
    }
    self thread aat_set_debug_text(name, 0, 0, 0);
  }
}

function private aat_set_debug_text(name, success, success_reroll, fail) {
  self notify("aat_set_debug_text_thread");
  self endon("aat_set_debug_text_thread");
  self endon("disconnect");
  if(!isDefined(self.aat_debug_text)) {
    return;
  }
  percentage = "";
  if(isDefined(level.aat[name]) && name != "") {
    percentage = level.aat[name].percentage;
  }
  self.aat_debug_text fadeovertime(0.05);
  self.aat_debug_text.alpha = 1;
  self.aat_debug_text settext((("" + name) + "") + percentage);
  if(success) {
    self.aat_debug_text.color = (0, 1, 0);
  } else {
    if(success_reroll) {
      self.aat_debug_text.color = vectorscale((1, 0, 1), 0.8);
    } else {
      if(fail) {
        self.aat_debug_text.color = (1, 0, 0);
      } else {
        self.aat_debug_text.color = (1, 1, 1);
      }
    }
  }
  wait(1);
  self.aat_debug_text fadeovertime(1);
  self.aat_debug_text.color = (1, 1, 1);
  if("" == name) {
    self.aat_debug_text.alpha = 0;
  }
}

function aat_cooldown_init() {
  self.aat_cooldown_start = [];
  keys = getarraykeys(level.aat);
  foreach(key in keys) {
    self.aat_cooldown_start[key] = 0;
  }
}

function private aat_vehicle_damage_monitor(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  willbekilled = (self.health - idamage) <= 0;
  if(isDefined(level.aat_in_use) && level.aat_in_use) {
    self thread aat_response(willbekilled, einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, vsurfacenormal);
  }
  return idamage;
}

function get_nonalternate_weapon(weapon) {
  if(isDefined(weapon) && weapon.isaltmode) {
    return weapon.altweapon;
  }
  return weapon;
}

function aat_response(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!isPlayer(attacker)) {
    return;
  }
  if(mod != "MOD_PISTOL_BULLET" && mod != "MOD_RIFLE_BULLET" && mod != "MOD_GRENADE" && mod != "MOD_PROJECTILE" && mod != "MOD_EXPLOSIVE" && mod != "MOD_IMPACT") {
    return;
  }
  weapon = get_nonalternate_weapon(weapon);
  name = attacker.aat[weapon];
  if(!isDefined(name)) {
    return;
  }
  if(death && !level.aat[name].occurs_on_death) {
    return;
  }
  if(!isDefined(self.archetype)) {
    return;
  }
  if(isDefined(level.aat[name].immune_trigger[self.archetype]) && level.aat[name].immune_trigger[self.archetype]) {
    return;
  }
  now = gettime() / 1000;
  if(now <= (self.aat_cooldown_start[name] + level.aat[name].cooldown_time_entity)) {
    return;
  }
  if(now <= (attacker.aat_cooldown_start[name] + level.aat[name].cooldown_time_attacker)) {
    return;
  }
  if(now <= (level.aat[name].cooldown_time_global_start + level.aat[name].cooldown_time_global)) {
    return;
  }
  if(isDefined(level.aat[name].validation_func)) {
    if(!self[[level.aat[name].validation_func]]()) {
      return;
    }
  }
  success = 0;
  reroll_icon = undefined;
  percentage = level.aat[name].percentage;
  aat_percentage_override = getdvarfloat("");
  if(aat_percentage_override > 0) {
    percentage = aat_percentage_override;
  }
  if(percentage >= randomfloat(1)) {
    success = 1;
    attacker thread aat_set_debug_text(name, 1, 0, 0);
  }
  if(!success) {
    keys = getarraykeys(level.aat_reroll);
    keys = array::randomize(keys);
    foreach(key in keys) {
      if(attacker[[level.aat_reroll[key].active_func]]()) {
        for(i = 0; i < level.aat_reroll[key].count; i++) {
          if(percentage >= randomfloat(1)) {
            success = 1;
            reroll_icon = level.aat_reroll[key].damage_feedback_icon;
            attacker thread aat_set_debug_text(name, 0, 1, 0);
            break;
          }
        }
      }
      if(success) {
        break;
      }
    }
  }
  if(!success) {
    attacker thread aat_set_debug_text(name, 0, 0, 1);
    return;
  }
  level.aat[name].cooldown_time_global_start = now;
  attacker.aat_cooldown_start[name] = now;
  self thread[[level.aat[name].result_func]](death, attacker, mod, weapon);
  attacker thread damagefeedback::update_override(level.aat[name].damage_feedback_icon, level.aat[name].damage_feedback_sound, reroll_icon);
}

function register(name, percentage, cooldown_time_entity, cooldown_time_attacker, cooldown_time_global, occurs_on_death, result_func, damage_feedback_icon, damage_feedback_sound, validation_func) {
  assert(isDefined(level.aat_initializing) && level.aat_initializing, "");
  assert(isDefined(name), "");
  assert("" != name, ("" + "") + "");
  assert(!isDefined(level.aat[name]), ("" + name) + "");
  assert(isDefined(percentage), ("" + name) + "");
  assert(0 <= percentage && 1 > percentage, ("" + name) + "");
  assert(isDefined(cooldown_time_entity), ("" + name) + "");
  assert(0 <= cooldown_time_entity, ("" + name) + "");
  assert(isDefined(cooldown_time_entity), ("" + name) + "");
  assert(0 <= cooldown_time_entity, ("" + name) + "");
  assert(isDefined(cooldown_time_global), ("" + name) + "");
  assert(0 <= cooldown_time_global, ("" + name) + "");
  assert(isDefined(occurs_on_death), ("" + name) + "");
  assert(isDefined(result_func), ("" + name) + "");
  assert(isDefined(damage_feedback_icon), ("" + name) + "");
  assert(isstring(damage_feedback_icon), ("" + name) + "");
  assert(isDefined(damage_feedback_sound), ("" + name) + "");
  assert(isstring(damage_feedback_sound), ("" + name) + "");
  level.aat[name] = spawnStruct();
  level.aat[name].name = name;
  level.aat[name].var_2c8ee667 = hashstring(name);
  level.aat[name].percentage = percentage;
  level.aat[name].cooldown_time_entity = cooldown_time_entity;
  level.aat[name].cooldown_time_attacker = cooldown_time_attacker;
  level.aat[name].cooldown_time_global = cooldown_time_global;
  level.aat[name].cooldown_time_global_start = 0;
  level.aat[name].occurs_on_death = occurs_on_death;
  level.aat[name].result_func = result_func;
  level.aat[name].damage_feedback_icon = damage_feedback_icon;
  level.aat[name].damage_feedback_sound = damage_feedback_sound;
  level.aat[name].validation_func = validation_func;
  level.aat[name].immune_trigger = [];
  level.aat[name].immune_result_direct = [];
  level.aat[name].immune_result_indirect = [];
}

function register_immunity(name, archetype, immune_trigger, immune_result_direct, immune_result_indirect) {
  while(level.aat_initializing !== 0) {
    wait(0.05);
  }
  assert(isDefined(name), "");
  assert(isDefined(archetype), "");
  assert(isDefined(immune_trigger), "");
  assert(isDefined(immune_result_direct), "");
  assert(isDefined(immune_result_indirect), "");
  if(!isDefined(level.aat[name].immune_trigger)) {
    level.aat[name].immune_trigger = [];
  }
  if(!isDefined(level.aat[name].immune_result_direct)) {
    level.aat[name].immune_result_direct = [];
  }
  if(!isDefined(level.aat[name].immune_result_indirect)) {
    level.aat[name].immune_result_indirect = [];
  }
  level.aat[name].immune_trigger[archetype] = immune_trigger;
  level.aat[name].immune_result_direct[archetype] = immune_result_direct;
  level.aat[name].immune_result_indirect[archetype] = immune_result_indirect;
}

function finalize_clientfields() {
  println("");
  if(level.aat.size > 1) {
    array::alphabetize(level.aat);
    i = 0;
    foreach(aat in level.aat) {
      aat.clientfield_index = i;
      i++;
      println("" + aat.name);
    }
    n_bits = getminbitcountfornum(level.aat.size - 1);
    clientfield::register("toplayer", "aat_current", 1, n_bits, "int");
  }
  level.aat_initializing = 0;
}

function register_aat_exemption(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  level.aat_exemptions[weapon] = 1;
}

function is_exempt_weapon(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  return isDefined(level.aat_exemptions[weapon]);
}

function register_reroll(name, count, active_func, damage_feedback_icon) {
  assert(isDefined(name), "");
  assert("" != name, ("" + "") + "");
  assert(!isDefined(level.aat[name]), ("" + name) + "");
  assert(isDefined(count), ("" + name) + "");
  assert(0 < count, ("" + name) + "");
  assert(isDefined(active_func), ("" + name) + "");
  assert(isDefined(damage_feedback_icon), ("" + name) + "");
  assert(isstring(damage_feedback_icon), ("" + name) + "");
  level.aat_reroll[name] = spawnStruct();
  level.aat_reroll[name].name = name;
  level.aat_reroll[name].count = count;
  level.aat_reroll[name].active_func = active_func;
  level.aat_reroll[name].damage_feedback_icon = damage_feedback_icon;
}

function getaatonweapon(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  if(weapon == level.weaponnone || (!(isDefined(level.aat_in_use) && level.aat_in_use)) || is_exempt_weapon(weapon) || (!isDefined(self.aat) || !isDefined(self.aat[weapon])) || !isDefined(level.aat[self.aat[weapon]])) {
    return undefined;
  }
  return level.aat[self.aat[weapon]];
}

function acquire(weapon, name) {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }
  assert(isDefined(weapon), "");
  assert(weapon != level.weaponnone, "");
  weapon = get_nonalternate_weapon(weapon);
  if(is_exempt_weapon(weapon)) {
    return;
  }
  if(isDefined(name)) {
    assert("" != name, ("" + "") + "");
    assert(isDefined(level.aat[name]), ("" + name) + "");
    self.aat[weapon] = name;
  } else {
    keys = getarraykeys(level.aat);
    arrayremovevalue(keys, "none");
    if(isDefined(self.aat[weapon])) {
      arrayremovevalue(keys, self.aat[weapon]);
    }
    rand = randomint(keys.size);
    self.aat[weapon] = keys[rand];
  }
  if(weapon == self getcurrentweapon()) {
    self clientfield::set_to_player("aat_current", level.aat[self.aat[weapon]].clientfield_index);
  }
}

function remove(weapon) {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }
  assert(isDefined(weapon), "");
  assert(weapon != level.weaponnone, "");
  weapon = get_nonalternate_weapon(weapon);
  self.aat[weapon] = undefined;
}

function watch_weapon_changes() {
  self endon("disconnect");
  self endon("entityshutdown");
  while(isDefined(self)) {
    self waittill("weapon_change", weapon);
    weapon = get_nonalternate_weapon(weapon);
    name = "none";
    if(isDefined(self.aat[weapon])) {
      name = self.aat[weapon];
    }
    self clientfield::set_to_player("aat_current", level.aat[name].clientfield_index);
  }
}