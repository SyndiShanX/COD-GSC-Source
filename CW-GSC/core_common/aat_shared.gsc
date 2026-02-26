/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\aat_shared.gsc
***********************************************/

#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace aat;

function private autoexec __init__system__() {
  system::register(#"aat", &preinit, &finalize_clientfields, undefined, undefined);
}

function private preinit() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  if(!isDefined(level.aat)) {
    level.aat = [];
  }

  clientfield::register("toplayer", "rob_ammo_mod_ready", 1, 1, "int");
  clientfield::register_clientuimodel("hud_items.gibDismembermentType", 16000, 5, "int", 0);
  level.aat[#"none"] = spawnStruct();
  level.aat[#"none"].name = "none";
  level.aat_reroll = [];
  level.var_bdba6ee8 = [];
  callback::on_connect(&on_player_connect);
  callback::on_ai_damage(&on_ai_damage);
  callback::function_33f0ddd3(&function_33f0ddd3);
  spawners = getspawnerarray();

  foreach(spawner in spawners) {
    spawner spawner::add_spawn_function(&aat_cooldown_init);
  }

  level.aat_exemptions = [];

  level thread setup_devgui();
}

function function_2b3bcce0() {
  if(!isDefined(level.var_e44e90d6)) {
    return;
  }

  foreach(call in level.var_e44e90d6) {
    [[call]]();
  }
}

function function_571fceb(aat_name, main) {
  if(!isDefined(level.var_e44e90d6)) {
    level.var_e44e90d6 = [];
  }

  if(isDefined(level.var_e44e90d6[aat_name])) {
    println("<dev string:x38>" + aat_name + "<dev string:x64>");
  }

  level.var_e44e90d6[aat_name] = main;
}

function private on_player_connect() {
  self.aat = [];
  self.aat_cooldown_start = [];

  foreach(key, v in level.aat) {
    self.aat_cooldown_start[key] = 0;
  }

  self thread watch_weapon_changes();
}

function private function_33f0ddd3(s_event) {
  if(s_event.event === "take_weapon" && isDefined(s_event.weapon)) {
    if(isPlayer(self) && isDefined(s_event.weapon)) {
      weapon = function_702fb333(s_event.weapon);

      if(isDefined(self.aat[weapon])) {
        self remove(weapon);
      }
    }
  }
}

function setup_devgui(var_e73fddff) {
  if(!isDefined(var_e73fddff)) {
    var_e73fddff = "<dev string:x91>";
  }

  waittillframeend();
  setDvar(#"aat_acquire_devgui", "<dev string:xac>");
  aat_devgui_base = var_e73fddff;

  foreach(key, v in level.aat) {
    if(key != "<dev string:xb0>") {
      name = function_9e72a96(key);
      util::add_debug_command(aat_devgui_base + name + "<dev string:xb8>" + "<dev string:xc3>" + "<dev string:xd9>" + name + "<dev string:xde>");
    }
  }

  util::add_debug_command(aat_devgui_base + "<dev string:xe5>" + "<dev string:xc3>" + "<dev string:xd9>" + "<dev string:xb0>" + "<dev string:xde>");
  level thread aat_devgui_think();
}

function private aat_devgui_think() {
  self notify("<dev string:xfd>");
  self endon("<dev string:xfd>");

  for(;;) {
    aat_name = getdvarstring(#"aat_acquire_devgui");

    if(aat_name != "<dev string:xac>") {
      for(i = 0; i < level.players.size; i++) {
        if(aat_name == "<dev string:xb0>") {
          if(sessionmodeiszombiesgame()) {
            weapon = level.players[i] getcurrentweapon();
            item = level.players[i] item_inventory::function_230ceec4(weapon);

            if(isDefined(item.aat)) {
              item.aat = undefined;
            }
          }

          level.players[i] thread remove(level.players[i] getcurrentweapon());
        } else {
          if(sessionmodeiszombiesgame()) {
            weapon = level.players[i] getcurrentweapon();
            item = level.players[i] item_inventory::function_230ceec4(weapon);

            if(isDefined(item)) {
              item.aat = aat_name;
            }
          }

          level.players[i] thread acquire(level.players[i] getcurrentweapon(), aat_name);
        }

        level.players[i] thread aat_set_debug_text(aat_name, 0, 0, 0);
      }
    }

    setDvar(#"aat_acquire_devgui", "<dev string:xac>");
    wait 0.5;
  }
}

function private aat_set_debug_text(name, success, success_reroll, fail) {
  self notify(#"aat_set_debug_text_thread");
  self endon(#"aat_set_debug_text_thread", #"disconnect");

  if(!isDefined(self.aat_debug_text)) {
    return;
  }

  percentage = "<dev string:x111>";

  if(isDefined(level.aat[name]) && name != "<dev string:xb0>") {
    percentage = level.aat[name].percentage;
  }

  self.aat_debug_text fadeovertime(0.05);
  self.aat_debug_text.alpha = 1;
  self.aat_debug_text settext("<dev string:x118>" + name + "<dev string:x121>" + percentage);

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

  if("<dev string:xb0>" == name) {
    self.aat_debug_text.alpha = 0;
  }
}

function private aat_cooldown_init() {
  self.aat_cooldown_start = [];

  foreach(key, v in level.aat) {
    self.aat_cooldown_start[key] = 0;
  }
}

function aat_vehicle_damage_monitor(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  willbekilled = self.health - weapon <= 0;

  if(is_true(level.aat_in_use)) {
    self thread aat_response(willbekilled, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  }

  return weapon;
}

function function_3895d220(weapon) {
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

function function_42918474(entity) {
  if(isDefined(entity) && (isPlayer(entity) || is_true(entity.var_42918474))) {
    return true;
  }

  return false;
}

function on_ai_damage(params) {
  b_death = params.idamage > self.health;
  aat_response(b_death, params.einflictor, params.eattacker, params.idamage, params.idflags, params.smeansofdeath, params.weapon, params.var_fd90b0bb, params.vpoint, params.vdir, params.shitloc, params.psoffsettime, params.boneindex, params.surfacetype);
  name = params.eattacker.aat[function_702fb333(params.weapon)];

  if(isDefined(name) && b_death) {
    if(isDefined(level.aat[name].var_de81baf2) && b_death) {
      self thread[[level.aat[name].var_de81baf2]](params.idamage, params.eattacker, params.weapon);
    }
  }
}

function aat_response(death, inflictor, attacker, damage, flags, mod, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!function_42918474(var_fd90b0bb) || !isDefined(var_fd90b0bb.aat) || !isDefined(vdir)) {
    return;
  }

  if(vdir.weapclass !== # "rocketlauncher" && vpoint != "MOD_PISTOL_BULLET" && vpoint != "MOD_RIFLE_BULLET" && vpoint != "MOD_GRENADE" && vpoint != "MOD_PROJECTILE" && vpoint != "MOD_EXPLOSIVE" && vpoint != "MOD_IMPACT" && (vpoint != "MOD_MELEE" || !is_true(level.var_9d1d502c))) {
    return;
  }

  if(is_true(level.var_9d1d502c) && isDefined(level.var_37c36b82) && vpoint == "MOD_MELEE") {
    if(![[level.var_37c36b82]](vdir)) {
      return;
    }
  }

  name = var_fd90b0bb.aat[function_702fb333(vdir)];

  if(!isDefined(name)) {
    return;
  }

  if(is_true(weapon) && !is_true(level.aat[name].occurs_on_death)) {
    return;
  }

  if(!isDefined(self.archetype)) {
    return;
  }

  if(is_true(self.var_dd6fe31f)) {
    return;
  }

  if(is_true(self.var_69a981e6)) {
    return;
  }

  if(is_true(self.aat_turned)) {
    return;
  }

  if(is_true(level.aat[name].immune_trigger[self.archetype])) {
    return;
  }

  now = float(gettime()) / 1000;

  if(isDefined(level.var_a839c34d)) {
    if(self[[level.var_a839c34d]](name, now, var_fd90b0bb)) {
      return;
    }
  } else {
    if(isDefined(self.aat_cooldown_start) && now <= self.aat_cooldown_start[name] + level.aat[name].cooldown_time_entity) {
      return;
    }

    if(now <= var_fd90b0bb.aat_cooldown_start[name] + level.aat[name].cooldown_time_attacker) {
      return;
    }

    if(now <= level.aat[name].cooldown_time_global_start + level.aat[name].cooldown_time_global) {
      return;
    }
  }

  if(isDefined(level.aat[name].validation_func)) {
    if(![[level.aat[name].validation_func]]()) {
      return;
    }
  }

  success = 0;
  reroll_icon = undefined;
  percentage = level.aat[name].percentage;

  if(isDefined(level.var_bdba6ee8[vdir])) {
    if(level.var_bdba6ee8[vdir] < percentage) {
      percentage = level.var_bdba6ee8[vdir];
    }
  }

  if(isDefined(var_fd90b0bb.var_2defbefd)) {
    percentage = var_fd90b0bb.var_2defbefd;
  }

  aat_percentage_override = getdvarfloat(#"scr_aat_percentage_override", 0);

  if(aat_percentage_override > 0) {
    percentage = aat_percentage_override;
  }

  if(percentage >= randomfloat(1)) {
    success = 1;

    var_fd90b0bb thread aat_set_debug_text(name, 1, 0, 0);
  }

  if(!success) {
    keys = getarraykeys(level.aat_reroll);
    keys = array::randomize(keys);

    foreach(key in keys) {
      if(var_fd90b0bb[[level.aat_reroll[key].active_func]]()) {
        for(i = 0; i < level.aat_reroll[key].count; i++) {
          if(percentage >= randomfloat(1)) {
            success = 1;
            reroll_icon = level.aat_reroll[key].damage_feedback_icon;

            var_fd90b0bb thread aat_set_debug_text(name, 0, 1, 0);

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
    var_fd90b0bb thread aat_set_debug_text(name, 0, 0, 1);

    return;
  }

  level.aat[name].cooldown_time_global_start = now;
  var_fd90b0bb.aat_cooldown_start[name] = now;
  self thread[[level.aat[name].result_func]](weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);

  if(isPlayer(var_fd90b0bb)) {
    var_fd90b0bb clientfield::set_to_player("rob_ammo_mod_ready", 0);
    var_fd90b0bb thread function_45db1b8a(name);
    var_fd90b0bb playlocalsound(level.aat[name].damage_feedback_sound);
  }
}

function function_45db1b8a(name) {
  self notify("5cc8d10e5693e31f");
  self endon("5cc8d10e5693e31f");
  self endon(#"death");

  while(true) {
    now = float(gettime()) / 1000;

    if(now >= self.aat_cooldown_start[name] + level.aat[name].cooldown_time_attacker) {
      self clientfield::set_to_player("rob_ammo_mod_ready", 1);
      return;
    }

    wait 1;
  }
}

function register(name, percentage, cooldown_time_entity, cooldown_time_attacker, cooldown_time_global, occurs_on_death, result_func, damage_feedback_icon, damage_feedback_sound, validation_func, element, var_de81baf2, var_68a3f665) {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  if(!isDefined(level.aat)) {
    level.aat = [];
  }

  assert(!is_false(level.aat_initializing), "<dev string:x12b>");
  assert(isDefined(name), "<dev string:x199>");
  assert("<dev string:xb0>" != name, "<dev string:x1c2>" + "<dev string:xb0>" + "<dev string:x1e7>");
  assert(!isDefined(level.aat[name]), "<dev string:x221>" + name + "<dev string:x23b>");
  assert(isDefined(percentage), "<dev string:x221>" + name + "<dev string:x25c>");
  assert(0 <= percentage && 1 > percentage, "<dev string:x221>" + name + "<dev string:x27d>");
  assert(isDefined(cooldown_time_entity), "<dev string:x221>" + name + "<dev string:x2c9>");
  assert(0 <= cooldown_time_entity, "<dev string:x221>" + name + "<dev string:x2f4>");
  assert(isDefined(cooldown_time_entity), "<dev string:x221>" + name + "<dev string:x33a>");
  assert(0 <= cooldown_time_entity, "<dev string:x221>" + name + "<dev string:x367>");
  assert(isDefined(cooldown_time_global), "<dev string:x221>" + name + "<dev string:x3af>");
  assert(0 <= cooldown_time_global, "<dev string:x221>" + name + "<dev string:x3da>");
  assert(isDefined(occurs_on_death), "<dev string:x221>" + name + "<dev string:x420>");
  assert(isDefined(result_func), "<dev string:x221>" + name + "<dev string:x446>");
  assert(isDefined(damage_feedback_icon), "<dev string:x221>" + name + "<dev string:x468>");
  assert(isstring(damage_feedback_icon), "<dev string:x221>" + name + "<dev string:x493>");
  assert(isDefined(damage_feedback_sound), "<dev string:x221>" + name + "<dev string:x4bf>");
  assert(isstring(damage_feedback_sound), "<dev string:x221>" + name + "<dev string:x4eb>");
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
  level.aat[name].var_de81baf2 = var_de81baf2;
  level.aat[name].var_68a3f665 = var_68a3f665;

  if(!isDefined(level.var_7c5fd6a4)) {
    level.var_7c5fd6a4 = [];
  }

  level.var_7c5fd6a4[hash(name)] = name;

  if(isDefined(element)) {
    level.aat[name].element = element;
  }
}

function register_immunity(name, archetype, immune_trigger, immune_result_direct, immune_result_indirect) {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  while(level.aat_initializing !== 0) {
    waitframe(1);
  }

  assert(isDefined(name), "<dev string:x199>");
  assert(isDefined(archetype), "<dev string:x518>");
  assert(isDefined(immune_trigger), "<dev string:x546>");
  assert(isDefined(immune_result_direct), "<dev string:x579>");
  assert(isDefined(immune_result_indirect), "<dev string:x5b2>");

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
  println("<dev string:x5ed>");

  if(!is_true(level.aat_in_use)) {
    return;
  }

  if(isDefined(level.aat) && level.aat.size > 1) {
    array::alphabetize(level.aat);
    i = 0;

    foreach(aat in level.aat) {
      aat.clientfield_index = i;
      i++;
      println("<dev string:x60a>" + aat.name);
    }

    n_bits = getminbitcountfornum(level.aat.size - 1);
    clientfield::register("toplayer", "aat_current", 1, n_bits, "int");
  }

  level.aat_initializing = 0;
}

function register_aat_exemption(weapon) {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  weapon = function_702fb333(weapon);
  level.aat_exemptions[weapon] = 1;
}

function is_exempt_weapon(weapon) {
  if(!is_true(level.aat_in_use)) {
    return false;
  }

  weapon = function_702fb333(weapon);
  return isDefined(level.aat_exemptions[weapon]);
}

function register_reroll(name, count, active_func, damage_feedback_icon) {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  assert(isDefined(name), "<dev string:x612>");
  assert("<dev string:xb0>" != name, "<dev string:x643>" + "<dev string:xb0>" + "<dev string:x1e7>");
  assert(!isDefined(level.aat[name]), "<dev string:x66f>" + name + "<dev string:x23b>");
  assert(isDefined(count), "<dev string:x696>" + name + "<dev string:x6be>");
  assert(0 < count, "<dev string:x696>" + name + "<dev string:x6da>");
  assert(isDefined(active_func), "<dev string:x696>" + name + "<dev string:x6fd>");
  assert(isDefined(damage_feedback_icon), "<dev string:x696>" + name + "<dev string:x468>");
  assert(isstring(damage_feedback_icon), "<dev string:x696>" + name + "<dev string:x493>");
  level.aat_reroll[name] = spawnStruct();
  level.aat_reroll[name].name = name;
  level.aat_reroll[name].count = count;
  level.aat_reroll[name].active_func = active_func;
  level.aat_reroll[name].damage_feedback_icon = damage_feedback_icon;
}

function function_702fb333(weapon) {
  if(!is_true(level.aat_in_use)) {
    return undefined;
  }

  if(isDefined(level.var_ee5c0b6e)) {
    weapon = self[[level.var_ee5c0b6e]](weapon);
    return weapon;
  }

  weapon = function_3895d220(weapon);
  return weapon;
}

function getaatonweapon(weapon, var_a217d0c1 = 0) {
  weapon = function_702fb333(weapon);

  if(!isDefined(weapon) || weapon == level.weaponnone || !is_true(level.aat_in_use) || is_exempt_weapon(weapon) || !isDefined(self.aat) || !isDefined(self.aat[weapon]) || !isDefined(level.aat[self.aat[weapon]])) {
    return undefined;
  }

  if(var_a217d0c1) {
    return self.aat[weapon];
  }

  return level.aat[self.aat[weapon]];
}

function acquire(weapon, name, var_77cf85b7) {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  assert(isDefined(weapon), "<dev string:x71f>");
  assert(weapon != level.weaponnone, "<dev string:x749>");
  weapon_instance = weapon;
  weapon = function_702fb333(weapon);

  if(is_exempt_weapon(weapon)) {
    return;
  }

  if(isDefined(name)) {
    assert("<dev string:xb0>" != name, "<dev string:x780>" + "<dev string:xb0>" + "<dev string:x1e7>");
    assert(isDefined(level.aat[name]), "<dev string:x7a4>" + name + "<dev string:x7bd>");
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

    if(keys.size) {
      rand = randomint(keys.size);
      name = keys[rand];
      self.aat[weapon] = name;
    }
  }

  if(weapon == function_702fb333(self getcurrentweapon())) {
    self clientfield::set_to_player("aat_current", level.aat[self.aat[weapon]].clientfield_index);
  }

  self clientfield::set_to_player("rob_ammo_mod_ready", 1);
  self notify(#"aat_acquired");
}

function remove(weapon) {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  assert(isDefined(weapon), "<dev string:x7d7>");
  assert(weapon != level.weaponnone, "<dev string:x800>");
  weapon_instance = weapon;
  weapon = function_702fb333(weapon);
  self.aat[weapon] = undefined;
  self function_bf3044dc(weapon_instance, 0);
}

function watch_weapon_changes() {
  self endon(#"disconnect");

  while(isDefined(self)) {
    waitresult = self waittill(#"weapon_change");
    weapon = waitresult.weapon;

    if(sessionmodeiszombiesgame()) {
      item = item_inventory::function_230ceec4(weapon);

      if(isDefined(item.aat)) {
        name = item.aat;
      } else {
        name = "none";
      }

      self clientfield::set_player_uimodel("hud_items.gibDismembermentType", gibserverutils::function_de4d9d(weapon, item.var_e91aba42));
    } else {
      weapon = function_702fb333(weapon);
      name = "none";

      if(isDefined(self.aat[weapon])) {
        name = self.aat[weapon];
      }
    }

    self clientfield::set_to_player("aat_current", level.aat[name].clientfield_index);
  }
}

function has_aat(w_current) {
  if(!is_true(level.aat_in_use)) {
    return false;
  }

  w_current = function_702fb333(w_current);

  if(isDefined(self.aat) && isDefined(self.aat[w_current])) {
    return true;
  }

  return false;
}

function function_7a12b737(stat_name, amount = 1) {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  assert(ishash(stat_name), "<dev string:x836>");

  if(!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  self stats::function_dad108fa(stat_name, amount);

  var_ba1fb8c1 = self stats::get_stat_global(stat_name);

  if(isDefined(var_ba1fb8c1)) {
    if(isDefined(self.entity_num)) {
      println("<dev string:x853>" + self.entity_num + "<dev string:xd9>" + function_9e72a96(stat_name) + "<dev string:x85e>" + var_ba1fb8c1);
    } else {
      println("<dev string:x853>" + function_9e72a96(stat_name) + "<dev string:x85e>" + var_ba1fb8c1);
    }
  }

  if(!isDefined(var_ba1fb8c1)) {
    println("<dev string:x853>" + self.entity_num + "<dev string:xd9>" + function_9e72a96(stat_name) + "<dev string:x870>");
  }
}