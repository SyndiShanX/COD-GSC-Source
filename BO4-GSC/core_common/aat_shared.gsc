/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\aat_shared.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;

#namespace aat;

autoexec __init__system__() {
  system::register(#"aat", &__init__, undefined, undefined);
}

private __init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }

  level.aat_initializing = 1;
  level.aat = [];
  level.aat[#"none"] = spawnStruct();
  level.aat[#"none"].name = "none";
  level.aat_reroll = [];
  level.var_bdba6ee8 = [];
  callback::on_connect(&on_player_connect);
  callback::function_33f0ddd3(&function_33f0ddd3);
  spawners = getspawnerarray();

  foreach(spawner in spawners) {
    spawner spawner::add_spawn_function(&aat_cooldown_init);
  }

  level.aat_exemptions = [];
  callback::on_finalize_initialization(&finalize_clientfields);

  level thread setup_devgui();
}

private on_player_connect() {
  self.aat = [];
  self.aat_cooldown_start = [];

  if(!isDefined(self.var_b01de37)) {
    self.var_b01de37 = [];
  } else if(!isarray(self.var_b01de37)) {
    self.var_b01de37 = array(self.var_b01de37);
  }

  foreach(key, v in level.aat) {
    self.aat_cooldown_start[key] = 0;
  }

  self thread watch_weapon_changes();
}

private function_33f0ddd3(s_event) {
  if(s_event.event === "take_weapon" && isDefined(s_event.weapon)) {
    weapon = function_702fb333(s_event.weapon);

    if(isDefined(self.aat[weapon])) {
      self remove(weapon);
    }
  }
}

private setup_devgui() {
  waittillframeend();
  setdvar(#"aat_acquire_devgui", "<dev string:x38>");
  aat_devgui_base = "<dev string:x3b>";

  foreach(key, v in level.aat) {
    if(key != "<dev string:x55>") {
      name = function_9e72a96(key);
      adddebugcommand(aat_devgui_base + name + "<dev string:x5c>" + "<dev string:x66>" + "<dev string:x7b>" + name + "<dev string:x7f>");
    }
  }

  adddebugcommand(aat_devgui_base + "<dev string:x85>" + "<dev string:x66>" + "<dev string:x7b>" + "<dev string:x55>" + "<dev string:x7f>");
  level thread aat_devgui_think();
}

private aat_devgui_think() {
  for(;;) {
    aat_name = getdvarstring(#"aat_acquire_devgui");

    if(aat_name != "<dev string:x38>") {
      for(i = 0; i < level.players.size; i++) {
        if(aat_name == "<dev string:x55>") {
          level.players[i] thread remove(level.players[i] getcurrentweapon());
        } else {
          level.players[i] thread acquire(level.players[i] getcurrentweapon(), aat_name);
        }

        level.players[i] thread aat_set_debug_text(aat_name, 0, 0, 0);
      }
    }

    setdvar(#"aat_acquire_devgui", "<dev string:x38>");
    wait 0.5;
  }
}

private aat_set_debug_text(name, success, success_reroll, fail) {
  self notify(#"aat_set_debug_text_thread");
  self endon(#"aat_set_debug_text_thread", #"disconnect");

  if(!isDefined(self.aat_debug_text)) {
    return;
  }

  percentage = "<dev string:x9c>";

  if(isDefined(level.aat[name]) && name != "<dev string:x55>") {
    percentage = level.aat[name].percentage;
  }

  self.aat_debug_text fadeovertime(0.05);
  self.aat_debug_text.alpha = 1;
  self.aat_debug_text settext("<dev string:xa2>" + name + "<dev string:xaa>" + percentage);

  if(success) {
    self.aat_debug_text.color = (0, 1, 0);
  } else if(success_reroll) {
    self.aat_debug_text.color = (0.8, 0, 0.8);
  } else if(fail) {
    self.aat_debug_text.color = (1, 0, 0);
  } else {
    self.aat_debug_text.color = (1, 1, 1);
  }

  wait 1;
  self.aat_debug_text fadeovertime(1);
  self.aat_debug_text.color = (1, 1, 1);

  if("<dev string:x55>" == name) {
    self.aat_debug_text.alpha = 0;
  }
}

private aat_cooldown_init() {
  self.aat_cooldown_start = [];

  foreach(key, v in level.aat) {
    self.aat_cooldown_start[key] = 0;
  }
}

aat_vehicle_damage_monitor(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  willbekilled = self.health - idamage <= 0;

  if(isDefined(level.aat_in_use) && level.aat_in_use) {
    self thread aat_response(willbekilled, einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, vsurfacenormal);
  }

  return idamage;
}

function_3895d220(weapon) {
  if(isDefined(weapon)) {
    if(weapon.isaltmode) {
      weapon = weapon.altweapon;
    }

    if(weapon.inventorytype == "dwlefthand") {
      weapon = weapon.dualwieldweapon;
    }

    weapon = weapon.rootweapon;
  }

  return weapon;
}

aat_response(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!isplayer(attacker) || !isDefined(attacker.aat) || !isDefined(weapon)) {
    return;
  }

  if(mod != "MOD_PISTOL_BULLET" && mod != "MOD_RIFLE_BULLET" && mod != "MOD_GRENADE" && mod != "MOD_PROJECTILE" && mod != "MOD_EXPLOSIVE" && mod != "MOD_IMPACT" && (mod != "MOD_MELEE" || !(isDefined(level.var_9d1d502c) && level.var_9d1d502c))) {
    return;
  }

  name = attacker.aat[function_702fb333(weapon)];

  if(!isDefined(name)) {
    return;
  }

  if(isDefined(death) && death && !level.aat[name].occurs_on_death) {
    return;
  }

  if(!isDefined(self.archetype)) {
    return;
  }

  if(isDefined(self.var_dd6fe31f) && self.var_dd6fe31f) {
    return;
  }

  if(isDefined(self.var_69a981e6) && self.var_69a981e6) {
    return;
  }

  if(isDefined(self.aat_turned) && self.aat_turned) {
    return;
  }

  if(isDefined(level.aat[name].immune_trigger[self.archetype]) && level.aat[name].immune_trigger[self.archetype]) {
    return;
  }

  now = float(gettime()) / 1000;

  if(isDefined(self.aat_cooldown_start) && now <= self.aat_cooldown_start[name] + level.aat[name].cooldown_time_entity) {
    return;
  }

  if(now <= attacker.aat_cooldown_start[name] + level.aat[name].cooldown_time_attacker) {
    return;
  }

  if(now <= level.aat[name].cooldown_time_global_start + level.aat[name].cooldown_time_global) {
    return;
  }

  if(isDefined(level.aat[name].validation_func)) {
    if(![
        [level.aat[name].validation_func]
      ]()) {
      return;
    }
  }

  success = 0;
  reroll_icon = undefined;
  percentage = level.aat[name].percentage;

  if(isDefined(level.var_bdba6ee8[weapon])) {
    if(level.var_bdba6ee8[weapon] < percentage) {
      percentage = level.var_bdba6ee8[weapon];
    }
  }

  aat_percentage_override = getdvarfloat(#"scr_aat_percentage_override", 0);

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

  if(isplayer(attacker)) {
    attacker playlocalsound(level.aat[name].damage_feedback_sound);
  }
}

register(name, percentage, cooldown_time_entity, cooldown_time_attacker, cooldown_time_global, occurs_on_death, result_func, damage_feedback_icon, damage_feedback_sound, validation_func, catalyst) {
  assert(isDefined(level.aat_initializing) && level.aat_initializing, "<dev string:xb3>");
  assert(isDefined(name), "<dev string:x120>");
  assert("<dev string:x55>" != name, "<dev string:x148>" + "<dev string:x55>" + "<dev string:x16c>");
  assert(!isDefined(level.aat[name]), "<dev string:x1a5>" + name + "<dev string:x1be>");
  assert(isDefined(percentage), "<dev string:x1a5>" + name + "<dev string:x1de>");
  assert(0 <= percentage && 1 > percentage, "<dev string:x1a5>" + name + "<dev string:x1fe>");
  assert(isDefined(cooldown_time_entity), "<dev string:x1a5>" + name + "<dev string:x249>");
  assert(0 <= cooldown_time_entity, "<dev string:x1a5>" + name + "<dev string:x273>");
  assert(isDefined(cooldown_time_entity), "<dev string:x1a5>" + name + "<dev string:x2b8>");
  assert(0 <= cooldown_time_entity, "<dev string:x1a5>" + name + "<dev string:x2e4>");
  assert(isDefined(cooldown_time_global), "<dev string:x1a5>" + name + "<dev string:x32b>");
  assert(0 <= cooldown_time_global, "<dev string:x1a5>" + name + "<dev string:x355>");
  assert(isDefined(occurs_on_death), "<dev string:x1a5>" + name + "<dev string:x39a>");
  assert(isDefined(result_func), "<dev string:x1a5>" + name + "<dev string:x3bf>");
  assert(isDefined(damage_feedback_icon), "<dev string:x1a5>" + name + "<dev string:x3e0>");
  assert(isstring(damage_feedback_icon), "<dev string:x1a5>" + name + "<dev string:x40a>");
  assert(isDefined(damage_feedback_sound), "<dev string:x1a5>" + name + "<dev string:x435>");
  assert(isstring(damage_feedback_sound), "<dev string:x1a5>" + name + "<dev string:x460>");
  level.aat[name] = spawnStruct();
  level.aat[name].name = name;
  level.aat[name].hash_id = stathash(name);
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

  if(isDefined(catalyst)) {
    level.aat[name].catalyst = catalyst;
  }
}

register_immunity(name, archetype, immune_trigger, immune_result_direct, immune_result_indirect) {
  while(level.aat_initializing !== 0) {
    waitframe(1);
  }

  assert(isDefined(name), "<dev string:x120>");
  assert(isDefined(archetype), "<dev string:x48c>");
  assert(isDefined(immune_trigger), "<dev string:x4b9>");
  assert(isDefined(immune_result_direct), "<dev string:x4eb>");
  assert(isDefined(immune_result_indirect), "<dev string:x523>");

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

finalize_clientfields() {
  println("<dev string:x55d>");

  if(level.aat.size > 1) {
    array::alphabetize(level.aat);
    i = 0;

    foreach(aat in level.aat) {
      aat.clientfield_index = i;
      i++;
      println("<dev string:x579>" + aat.name);
    }

    n_bits = getminbitcountfornum(level.aat.size - 1);
    clientfield::register("toplayer", "aat_current", 1, n_bits, "int");
  }

  level.aat_initializing = 0;
}

register_aat_exemption(weapon) {
  weapon = function_702fb333(weapon);
  level.aat_exemptions[weapon] = 1;
}

is_exempt_weapon(weapon) {
  weapon = function_702fb333(weapon);
  return isDefined(level.aat_exemptions[weapon]);
}

register_reroll(name, count, active_func, damage_feedback_icon) {
  assert(isDefined(name), "<dev string:x580>");
  assert("<dev string:x55>" != name, "<dev string:x5b0>" + "<dev string:x55>" + "<dev string:x16c>");
  assert(!isDefined(level.aat[name]), "<dev string:x5db>" + name + "<dev string:x1be>");
  assert(isDefined(count), "<dev string:x601>" + name + "<dev string:x628>");
  assert(0 < count, "<dev string:x601>" + name + "<dev string:x643>");
  assert(isDefined(active_func), "<dev string:x601>" + name + "<dev string:x665>");
  assert(isDefined(damage_feedback_icon), "<dev string:x601>" + name + "<dev string:x3e0>");
  assert(isstring(damage_feedback_icon), "<dev string:x601>" + name + "<dev string:x40a>");
  level.aat_reroll[name] = spawnStruct();
  level.aat_reroll[name].name = name;
  level.aat_reroll[name].count = count;
  level.aat_reroll[name].active_func = active_func;
  level.aat_reroll[name].damage_feedback_icon = damage_feedback_icon;
}

function_702fb333(weapon) {
  if(isDefined(level.var_ee5c0b6e)) {
    weapon = self[[level.var_ee5c0b6e]](weapon);
    return weapon;
  }

  weapon = function_3895d220(weapon);
  return weapon;
}

getaatonweapon(weapon, var_a217d0c1 = 0) {
  weapon = function_702fb333(weapon);

  if(weapon == level.weaponnone || !(isDefined(level.aat_in_use) && level.aat_in_use) || is_exempt_weapon(weapon) || !isDefined(self.aat) || !isDefined(self.aat[weapon]) || !isDefined(level.aat[self.aat[weapon]])) {
    return undefined;
  }

  if(var_a217d0c1) {
    return self.aat[weapon];
  }

  return level.aat[self.aat[weapon]];
}

acquire(weapon, name, var_77cf85b7) {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }

  assert(isDefined(weapon), "<dev string:x686>");
  assert(weapon != level.weaponnone, "<dev string:x6af>");
  weapon = function_702fb333(weapon);

  if(is_exempt_weapon(weapon)) {
    return;
  }

  if(isDefined(name)) {
    assert("<dev string:x55>" != name, "<dev string:x6e5>" + "<dev string:x55>" + "<dev string:x16c>");
    assert(isDefined(level.aat[name]), "<dev string:x708>" + name + "<dev string:x720>");
    self.aat[weapon] = name;
  } else {
    keys = getarraykeys(level.aat);
    arrayremovevalue(keys, hash("none"));

    if(isDefined(self.aat[weapon])) {
      arrayremovevalue(keys, self.aat[weapon]);
    }

    if(isDefined(var_77cf85b7)) {
      arrayremovevalue(keys, hash(var_77cf85b7));
    }

    rand = randomint(keys.size);
    name = keys[rand];
    self.aat[weapon] = name;
  }

  if(weapon == function_702fb333(self getcurrentweapon())) {
    self clientfield::set_to_player("aat_current", level.aat[self.aat[weapon]].clientfield_index);
  }

  switch (name) {
    case #"zm_aat_brain_decay":
      self.var_b01de37[weapon] = 2;
      break;
    case #"zm_aat_plasmatic_burst":
      self.var_b01de37[weapon] = 3;
      break;
    case #"zm_aat_kill_o_watt":
      self.var_b01de37[weapon] = 4;
      break;
    case #"zm_aat_frostbite":
      self.var_b01de37[weapon] = 1;
      break;
    default:
      break;
  }
}

remove(weapon) {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }

  assert(isDefined(weapon), "<dev string:x739>");
  assert(weapon != level.weaponnone, "<dev string:x761>");
  weapon = function_702fb333(weapon);
  self.aat[weapon] = undefined;
  self.var_b01de37[weapon] = undefined;
}

watch_weapon_changes() {
  self endon(#"disconnect");

  while(isDefined(self)) {
    waitresult = self waittill(#"weapon_change");
    weapon = waitresult.weapon;
    weapon = function_702fb333(weapon);
    name = "none";

    if(isDefined(self.aat[weapon])) {
      name = self.aat[weapon];
    }

    self clientfield::set_to_player("aat_current", level.aat[name].clientfield_index);
  }
}

has_aat(w_current) {
  w_current = function_702fb333(w_current);

  if(isDefined(self.aat) && isDefined(self.aat[w_current])) {
    return true;
  }

  return false;
}