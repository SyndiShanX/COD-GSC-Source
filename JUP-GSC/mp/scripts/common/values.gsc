/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\values.gsc
***********************************************/

#using script_4a6760982b403bad;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\string;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\utility;
#namespace val;

function private autoexec __init__system__() {
  system::register(#"val", undefined, &pre_main, undefined);
}

function pre_main() {
  if(isDefined(level.var_750a82cea28f2f13)) {
    return;
  }

  level.var_750a82cea28f2f13 = 1;
  register("breath_system", 1, 0, "$self", &function_ff6d5864f8680d5e, "$value");
  register("damage", 1, 0, "$self", &function_a49123f94edb0267, "$value");
  register("death", 1, 0, "$self", &function_613f82ecdf9b56b8, "$value");
  register("damageshield", 0, 1, "$self", &function_8aba0b6af3dcb0ef, "$value");
  register("ignoresuppression", 0, 1, "$self", &function_9e8589036c3fd37e, "$value");
  register("whizby", 1, 0);
  register("ignoreme", 0, 1, "$self", &function_2553e8f1e80d32a9, "$value");
  register("ignoreall", 0, 1, "$self", &function_d3eeff01d5db508a, "$value");
  register("take_weapons", 0, 1, "$self", &set_takeweapons, "$value");
  register("weapon", 1, 0, "$self", &function_945a9012be94d89b, "$value");
  register("weapon_switch", 1, 0, "$self", &function_271781b97a830b8f, "$value");
  register("weapon_switch_clip", 1, 0, "$self", &function_cbbbe022b06a2d09, "$value");
  register("script_weapon_switch", 0, 1);
  register("reload", 1, 0, "$self", &function_6a7974bc3033866f, "$value");
  register("weapon_pickup", 1, 0, "$self", &function_ac139cd4bd7d232e, "$value");
  register("fire", 1, 0, "$self", &function_cda8ef3bebb4e3ee, "$value");
  register("autoreload", 1, 0, "$self", &function_1155b13235411eec, "$value");
  register("weapon_first_raise_anims", 1, 0, "$self", &function_782c9cfc7f78e416, "$value");
  register("offhand_weapons", 1, 0, "$self", &function_8fdf6df702996fa7, "$value");

  if(!isDefined(level.ismp) || level.ismp == 0) {
    link("offhand_weapons", "offhand_shield_weapons");
  }

  register("offhand_primary_weapons", 1, 0, "$self", &function_47279b5d7e2bcef3, "$value");
  register("offhand_secondary_weapons", 1, 0, "$self", &function_c8f662a90251117, "$value");
  link("offhand_secondary_weapons", "offhand_shield_weapons");
  register("offhand_shield_weapons", 1, 0, "$self", &function_f61d010ff82a69da, "$value");
  register("offhand_throwback", 1, 0, "$self", &function_54a3481116d62f02, "$value");
  register("allow_offhand_special", 1, 0, "$self", &function_8493479decad7dea, "$value");
  register("allow_aim_assist", 1, 0, "$self", &function_4e24d3eb9687a667, "$value");
  register("usability", 1, 0, "$self", &function_586996315a6703b0, "$value");
  register("freezecontrols", 0, 1, "$self", &function_15cc9bfda3c4adee, "$value");
  register("freezecontrols_allowlook", 0, 1, "$self", &function_9a6ef6fcc3e3c652, "$value");
  register("hide", 0, 1, "$self", &set_hide, "$value");
  register("health_regen", 1, 0, "$self", &set_health_regen, "$value");
  register("allow_health_regen_delay", 1, 0, "$self", &function_1140c973aa64c8d6, "$value");
  register("ignore_health_regen_delay", 0, 1, "$self", &set_ignore_health_regen_delay, "$value");
  register("stealth_social_reveal", 0, 1, "$self", &function_d4513b1bc21601, "$value");
  register("show_hud", 1, 0, "$self", &function_688748c7477e93dc, "$value");
  register("show_weapon_hud", 1, 0, "$self", &function_8b2fc23241e6448b, "$value");
  register("show_dpad_hud", 1, 0, "$self", &function_147fe8bda5949cf2, "$value");
  register("allow_jump", 1, 0, "$self", &set_allowjump, "$value");
  register("allow_double_jump", 1, 0, "$self", &function_5d8c973a5b6b05d8, "$value");
  register("crouch", 1, 0, "$self", &set_allowcrouch, "$value");
  register("prone", 1, 0, "$self", &set_allowprone, "$value");
  register("stance_change", 1, 0, "$self", &function_c8e47b79550e4319, "$value");
  register("melee", 1, 0, "$self", &set_allowmelee, "$value");
  register("lean", 1, 0, "$self", &function_1e949110ce628e51, "$value");
  register("allow_melee_victim", 1, 0, "$self", &allow_melee_victim, "$value");
  register("mantle", 1, 0, "$self", &function_b3870b9ec763d70a, "$value");
  register("ledgehang", 1, 0, "$self", &function_97182ebc175cd93a, "$value");
  register("mount_top", 1, 0, "$self", &function_9b5befbb13ad7651, "$value");
  register("mount_side", 1, 0, "$self", &function_aac726af48296365, "$value");
  register("sprint", 1, 0, "$self", &set_allowsprint, "$value");
  register("jog", 1, 0, "$self", &function_2a827539b0ee61b7, "$value");
  register("ads", 1, 0, "$self", &set_allowads, "$value");
  register("stand", 1, 0, "$self", &set_allowstand, "$value");
  register("allow_movement", 1, 0, "$self", &set_allowmovement, "$value");
  register("ladder", 1, 0, "$self", &function_f3b4bc17c87adba5, "$value");
  register("swimming_underwater", 1, 0, "$self", &function_880120db350a6425, "$value");
  register("dtp", 1, 0, "$self", &function_d13b7a396eab0463, "$value");
  register("move_speed_scale", 1, 1, "$self", &function_46eda303c0fa6322, "$value");
  register("desired_speed", 0, 0, "$self", &set_desiredspeed, "$value");
  register("goalradius", 2048, 2048, "$self", &function_a93b95cf50f8c3c9, "$value");
  register("push_player", 0, 1, "$self", &set_pushplayer, "$value");
  register("skip_death", 0, 1, "$self", &function_397bdae9676d99b2, "$value");
  register("skip_scene_death", 0, 1, "$self", &function_c7cacbe604c9200d, "$value");
  register("supers", 1, 0, "$self", &function_ee3a42d7c6b37fe, "$value");
  register("wallrun", 1, 0, "$self", &function_98e071a6cc904543, "$value");
  register("doublejump", 1, 0, "$self", &function_156a6ef9e8bb6f63, "$value");
  register("slide", 1, 0, "$self", &function_60e7c22bac17f22f, "$value");
  register("execution_attack", 1, 0, "$self", &function_5e4e727a591c079d, "$value");
  register("execution_victim", 1, 0, "$self", &function_eb0398e7c2c3c055, "$value");
  register("vehicle_use", 1, 0, "$self", &function_e62e9efd7d1bf0da, "$value");
  register("vehicle_lean_out", 1, 0, "$self", &function_798a407672c35e3c, "$value");
  register("vehicle_seat_switch", 1, 0, "$self", &function_2a5481b1da502117, "$value");
  register("nvg", 1, 0, "$self", &function_7edde3ba90d9a36, "$value");
  register("spotter_scope", 1, 0, "$self", &function_2a4de4fe3103d24c, "$value");
  register("supersprint", 1, 0, "$self", &function_65fb0f9b12a90f29, "$value");
  register("shellshock", 1, 0, "$self", &function_3368e1d4052b1596, "$value");
  register("cinematic_motion", 1, 0, "$self", &function_ea01b65c909b99d2, "$value");
  register("armor", 1, 0, "$self", &function_293669b3b38c7221, "$value");
  register("door_frozen", 0, 1, "$self", &function_2937a757c6689fb3, "$value");
  register("interactions", 1, 0, "$self", &function_cbdfe6762b367d1b, "$value");
  register("action_slot_weapon", 1, 0, "$self", &function_dc9ce02e5a3bd6da, "$value");
  register("equipment_primary", 1, 0, "$self", &function_dd8e7fdce5f0dcff, "$value");
  register("equipment_secondary", 1, 0, "$self", &function_2b70e9743c9a71b, "$value");
  register("overlord_locked_priority", 0, 0, "$self", &function_f8b197beec8e9945, "$value");
  register("backpack_inventory", 1, 0, "$self", &function_4a0c36c985cc4a03, "$value");
  register("tacmap_scoreboard", 1, 0, "$self", &function_d093a1b1e1c340a3, "$value");
  register("demeanor", "", "", "$self", &set_demeanor, "$value");
  register("pain", 1, 0, "$self", &function_e839d0e33e07c756, "$value");
  register("infinite_ammo", 0, 1, "$self", &function_15b077dbaf3b063f, "$value");
  register("kill_on_damage", 0, 0, "$self", &function_7f308a0cfa036a48, "$value");
  register("hide_operator_backpack", 0, 1, "$self", &function_cfb80f3b8aad230, "$value");
  register("show_operator_pet", 1, 0, "$self", &function_9c9b518e967a4514, "$value");
  register("allow_give_super_point", 1, 1, "$self", &function_fc93ada8ce1701fe, "$value");
  register("pause_zombie_spawning", 0, 0, "$self", &function_3718505d535c6113, "$value");
  register("show_healthbar", 1, 1, "$self", &function_10613d0755b1655, "$value");
  register("attackeraccuracy", 1, 1, "$self", &function_ff795a8bf33046c1, "$value");
  register("ascender_use", 1, 0);
  register("crate_use", 1, 0);
  register("cough_gesture", 1, 0);
  register("ladder_placement", 1, 0);
  register("killstreaks", 1, 0);
  register("cp_munitions", 1, 0);
  register("cp_munitions_pickup", 1, 0);
  register("cp_supers_pickup", 1, 0);
  register("one_hit_melee_victim", 1, 0);
  register("flashed", 1, 0);
  register("stunned", 1, 0);
  register("stick_kill", 1, 0);
  register("unresolved_collisions", 1, 0);
  register("third_person_toggle", 1, 0);
  register("equipment_wheel", 1, 0, "$self", &function_1bc52d1afc4d1b95, ["equipment_wheel", "$value"]);
  register("disallow_knockdown", 0, 1, "$self", &function_4c8f023af26b4a8a, "$value");
  register("disallow_stun", 0, 1, "$self", &function_db2848cc88d5a336, "$value");
  register("ignore_ai_collision", 0, 1, "$self", &function_b0146ba0c8f08192, "$value");
  register("spy_cam", 1, 0, "$self", &function_1bc52d1afc4d1b95, ["spy_cam", "$value"]);
  register("ammomod_immune", 0, 1, "$self", &function_d549cfeb2ed5d5e2, "$value");
  register("allow_dismember", 1, 0, "$self", &function_b010672d21d0fdb1, "$value");
  register("cinematics_participant", 0, 1, "$self", &function_83f16f4f6bc886b2, "$value");
  register("overlord_speaker", "", "", "$self", &function_a93741c78d1d215b, "$value");
  register("ks_dont_forget", 0, 0, "$self", &function_13da7718a3ccfc98, "$value");
  register("ai_eventlist", "", "", "$self", &function_fd241a7be9d82fa5, "$value");
  register("stealth_ttlt_lkp", 8000, 8000, "$self", &function_f185596cc8242d28, "$value");
  register("stealth_ttlt_not_lkp", 3000, 3000, "$self", &function_4ef8b4df5173b05a, "$value");
  register("default_time_to_drop_threat_sight", 10000, 10000, "$self", &function_f1e27a27436441b4, "$value");
  register("global_esc_total_combat_time", -1, -1, "$self", &function_48cd47326fc3f73b, "$value");
  register("global_esc_percent_threshold", 0.8, 0.8, "$self", &function_dbb2149dbfbea743, "$value");
  register("vehicle_disallow_lockon", 0, 1, "$self", &function_69bc203e1b8c4e63, "$value");

  level thread debug_values();
  validate("<dev string:x1c>", "<dev string:x26>", &function_1d19c0b0f63836bf);
  validate("<dev string:x2f>", "<dev string:x26>", &function_c4d1d331dd972e60);
  validate("<dev string:x38>", "<dev string:x26>", &function_b07da66c065f9ef7);
}

function register(str_name, default_value, var_8f2a3de49e1f0527, call_on, func, args) {
  assert(isstring(str_name));

  if(!isDefined(level.values)) {
    level.values = [];
  }

  if(isDefined(level.values[str_name])) {
    assertmsg("<dev string:x48>" + str_name + "<dev string:x53>");
    return;
  }

  if(isDefined(args)) {
    if(!isarray(args)) {
      args = [args];
    }
  } else {
    args = [];
  }

  level.values[str_name] = {
    #a_args: args, #var_8f2a3de49e1f0527: var_8f2a3de49e1f0527, #default_value: default_value, #func: func, #call_on: call_on, #str_name: str_name
  };
}

function unregister(str_name) {
  if(isDefined(level.values)) {
    level.values[str_name] = undefined;
  }
}

function group_register(group_name, value_names) {
  thread function_15421e5286d72ec3(value_names);

  if(!isDefined(level.value_groups)) {
    level.value_groups = [];
  }

  level.value_groups[group_name] = value_names;
}

function private function_15421e5286d72ec3(value_names) {
  waitframe();

  foreach(val_name in value_names) {
    assert_registered(val_name);
  }
}

function group_set(group_name, value) {
  assertex(isDefined(level.value_groups[group_name]), "<dev string:x6c>" + group_name + "<dev string:x9c>");
  str_id = "_group_" + group_name;
  set_array(str_id, level.value_groups[group_name], value);
}

function group_reset(group_name) {
  str_id = "_group_" + group_name;
  reset_all(str_id);
}

function private assert_registered(str_name) {
  if(!isDefined(level.values[str_name])) {
    assertmsg("<dev string:x48>" + str_name + "<dev string:xa1>");
    return false;
  }

  return true;
}

function default_func(str_name, call_on, value, args) {
  if(assert_registered(str_name)) {
    if(isDefined(args) && !isarray(args)) {
      args = [args];
    }

    if(!isDefined(args)) {
      args = [];
    }

    s_value = level.values[str_name];
    s_value.default_call_on = call_on;
    s_value.default_value = value;
    s_value.default_args = args;
  }
}

function link(str_name, var_4d81048fd967e05, func) {
  if(assert_registered(str_name)) {
    s_value = level.values[str_name];
    new_link = spawnStruct();
    new_link.name = var_4d81048fd967e05;
    new_link.func = func;

    if(!isDefined(new_link.func)) {
      new_link.func = &simple_link;
    }

    s_value.links[var_4d81048fd967e05] = new_link;
  }
}

function private simple_link(b_value) {
  return b_value;
}

function set(str_id, str_name, value) {
  if(assert_registered(str_name)) {
    if(!isDefined(value)) {
      value = level.values[str_name].var_8f2a3de49e1f0527;
    }

    push_value(str_id, str_name, value);
    set_value(str_name, value);
  }

  if(isarray(level.values[str_name].links)) {
    foreach(s_link in level.values[str_name].links) {
      set(str_id, s_link.name, [[s_link.func]](value));
    }
  }
}

function set_array(str_id, var_d1450ef5ee023044, value) {
  foreach(str_name in var_d1450ef5ee023044) {
    set(str_id, str_name, value);
  }
}

function reset_array(str_id, var_d1450ef5ee023044) {
  foreach(str_name in var_d1450ef5ee023044) {
    reset(str_id, str_name);
  }
}

function get(str_name) {
  if(assert_registered(str_name)) {
    if(isDefined(self.values) && isDefined(self.values[str_name])) {
      n_index = self.values[str_name].size - 1;

      if(n_index >= 0 && isDefined(self.values[str_name][n_index].value)) {
        return self.values[str_name][n_index].value;
      }
    }

    return get_default(str_name);
  }
}

function get_last(str_name) {
  if(assert_registered(str_name)) {
    if(isDefined(self.values) && isDefined(self.values[str_name])) {
      n_index = 0;

      if(isDefined(self.values[str_name][n_index].value)) {
        return self.values[str_name][n_index].value;
      }
    }

    return get_default(str_name);
  }
}

function set_radiant(str_name, value) {
  set("radiant", str_name, value);
}

function set_for_time(n_time, str_id, str_name, value) {
  self endon("death");
  set(str_id, str_name, value);
  wait n_time;
  reset(str_id, str_name);
}

function reset(str_id, str_name) {
  n_index = remove_value(str_id, str_name);

  if(!n_index) {
    if(isDefined(self.values) && isDefined(self.values[str_name]) && self.values[str_name].size > 0) {
      set_value(str_name, self.values[str_name][0].value);
    } else {
      set_default(str_name);
    }
  }

  if(isarray(level.values[str_name].links)) {
    foreach(s_link in level.values[str_name].links) {
      reset(str_id, s_link.name);
    }
  }
}

function reset_all(str_id) {
  if(!isDefined(self.values)) {
    return;
  }

  valuescopy = arraycopy(self.values);

  foreach(valuekey, valuestates in valuescopy) {
    foreach(state in valuestates) {
      if(isDefined(state.str_id) && state.str_id == str_id) {
        reset(str_id, valuekey);
      }
    }
  }
}

function reset_radiant(str_name) {
  reset("radiant", str_name);
}

function nuke(str_name) {
  self.values[str_name] = [];
  set_default(str_name);
}

function nuke_all() {
  if(!isDefined(self.values)) {
    return;
  }

  var_9c45b28e12994e8f = [];

  foreach(str_name, value in self.values) {
    var_9c45b28e12994e8f[var_9c45b28e12994e8f.size] = str_name;
  }

  foreach(str_name in var_9c45b28e12994e8f) {
    nuke(str_name);
  }
}

function private push_value(str_id, str_name, value) {
  assert(isstring(str_id));
  remove_value(str_id, str_name);

  if(!isDefined(self.values)) {
    self.values = [];
  }

  if(!isDefined(self.values[str_name])) {
    self.values[str_name] = [];
  }

  new_value = spawnStruct();
  new_value.str_id = str_id;
  new_value.value = value;
  self.values[str_name] = utility::array_insert(self.values[str_name], new_value, 0);
}

function private remove_value(str_id, str_name) {
  if(!isDefined(self)) {
    return -1;
  }

  n_index = undefined;

  if(isDefined(self.values) && isDefined(self.values[str_name])) {
    for(n_index = self.values[str_name].size - 1; n_index >= 0; n_index--) {
      if(self.values[str_name][n_index].str_id == str_id) {
        self.values[str_name] = utility::array_remove_index(self.values[str_name], n_index);
        break;
      }
    }

    if(!self.values[str_name].size) {
      self.values[str_name] = undefined;

      if(!self.values.size) {
        self.values = undefined;
      }
    }
  }

  return utility::ter_op(isDefined(n_index), n_index, -1);
}

function private set_value(str_name, value) {
  s_value = level.values[str_name];

  if(isDefined(s_value)) {
    s_value.value = value;

    if(isDefined(s_value.func)) {
      call_on = utility::ter_op(isstring(s_value.call_on) && s_value.call_on == "$self", self, s_value.call_on);
      utility::single_func_argarray(call_on, s_value.func, replace_values(s_value.a_args, value));
    }
  }
}

function private get_default(str_name) {
  default_value = undefined;
  s_value = level.values[str_name];

  if(isDefined(s_value) && isDefined(s_value.default_value)) {
    if(isfunction(s_value.default_value)) {
      call_on = utility::ter_op(isstring(s_value.default_call_on) && s_value.default_call_on == "$self", self, s_value.default_call_on);
      default_value = utility::single_func_argarray(call_on, s_value.default_value, replace_values(s_value.default_args));
    } else {
      default_value = s_value.default_value;
    }
  }

  return default_value;
}

function private set_default(str_name) {
  default_value = get_default(str_name);

  if(isDefined(default_value)) {
    set_value(str_name, default_value);
  }
}

function private function_32efb357c319abf0(array, str_value, replacement) {
  foreach(i, val in array) {
    if(isstring(val) && val == str_value) {
      array[i] = replacement;
    }
  }

  return array;
}

function private replace_values(a_args, value) {
  if(isDefined(a_args)) {
    a_args = function_32efb357c319abf0(a_args, "$self", self);
    a_args = function_32efb357c319abf0(a_args, "$value", value);
  }

  return a_args;
}

function private function_a49123f94edb0267(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(isPlayer(self)) {
    if(utility::issp()) {
      if(b_value) {
        self disableinvulnerability();
      } else {
        self enableinvulnerability();
      }
    } else if(istrue(level.var_a12c755dc79cd6f3)) {
      self.takedamage = b_value;
    } else {
      iprintln("<dev string:xb6>");
    }

    return;
  }

  self setCanDamage(b_value);
}

function private function_1d19c0b0f63836bf() {
  if(isPlayer(self)) {
    return !self isinvulnerable();
  }

  return self function_89db472b36958666();
}

function private function_613f82ecdf9b56b8(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(isDefined(self.deathshieldfunc)) {
    self[[self.deathshieldfunc]](!b_value);
  }

  self.allowdeath = b_value;
}

function private function_c4d1d331dd972e60() {
  return self.allowdeath;
}

function private function_8aba0b6af3dcb0ef(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self.damageshield = b_value;
}

function private function_b07da66c065f9ef7() {
  return self.damageshield;
}

function private function_564dce69848aceaa() {
  return self islookcontrolsfrozen();
}

function private function_9e8589036c3fd37e(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self.ignoresuppression = b_value;
}

function private set_takeweapons_thread(b_value) {
  self notify("set_takeweapons_thread");
  self endon("set_takeweapons_thread");
  self endon("death_or_disconnect");
  wait level.framedurationseconds * 3;

  if(b_value) {
    if(!isDefined(self.val_takeweapons)) {
      self.val_takeweapons = spawnStruct();
      self.val_takeweapons.weapons = self getweaponslistall();
      self.val_takeweapons.current = self getcurrentweapon();
    }

    self takeallweapons();
    return;
  }

  if(isDefined(self.val_takeweapons)) {
    weaponselect = self.val_takeweapons.current;
    fallbackprimary = undefined;

    foreach(weapon in self.val_takeweapons.weapons) {
      self giveweapon(weapon);

      if(!isDefined(fallbackprimary) && weapon.type == "bullet") {
        fallbackprimary = weapon;
      }
    }

    if(isDefined(fallbackprimary) && weaponselect.basename == "none") {
      weaponselect = fallbackprimary;
    }

    self switchtoweaponimmediate(weaponselect);
    self.val_takeweapons = undefined;
  }
}

function private set_takeweapons(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(isPlayer(self)) {
    thread set_takeweapons_thread(b_value);
    return;
  }

  if(b_value) {
    ai::gun_remove();

    if(isDefined(anim.var_c65f21298ce83c9c)) {
      self[[anim.var_c65f21298ce83c9c]]();
    }

    return;
  }

  ai::gun_recall();

  if(isDefined(anim.var_f240ef0c84eac2b2)) {
    self[[anim.var_f240ef0c84eac2b2]]();
  }
}

function private function_945a9012be94d89b(value) {
  if(!isDefined(value)) {
    value = 0;
  }

  if(value != 1) {
    self disableweapons(isnumber(value) && value == -1 ? 1 : 0);

    if(isDefined(level.allow_weapon_mp)) {
      self[[level.allow_weapon_mp]](0);
    }

    return;
  }

  self enableweapons();

  if(isDefined(level.allow_weapon_mp)) {
    self[[level.allow_weapon_mp]](1);
  }
}

function private function_271781b97a830b8f(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self enableweaponswitch();
    return;
  }

  self disableweaponswitch();
}

function private function_cbbbe022b06a2d09(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self disableemptyclipweaponswitch(0);
    return;
  }

  self disableemptyclipweaponswitch(1);
}

function private function_cda8ef3bebb4e3ee(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self allowfire(1);
    return;
  }

  self allowfire(0);
}

function private function_6a7974bc3033866f(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value != 1) {
    self allowreload(0);

    if(b_value != -1) {
      self cancelreload();
      var_5814d27874b48e54 = spawnStruct();
      var_5814d27874b48e54.player = self;
      var_5814d27874b48e54.cancelreason = "ENTER_VEHICLE";
      var_5814d27874b48e54.reloadcanceltime = getsystemtimeinmicroseconds();
      namespace_c45ac99c4997e722::function_80820d6d364c1836("callback_on_reload_cancel", var_5814d27874b48e54);
    }

    return;
  }

  self allowreload(1);
}

function private function_ac139cd4bd7d232e(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self enableweaponpickup();
    return;
  }

  self disableweaponpickup();
}

function private function_1155b13235411eec(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self enableautoreload();
    return;
  }

  self disableautoreload();
}

function private function_8fdf6df702996fa7(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self enableoffhandweapons();
    return;
  }

  self disableoffhandweapons();
}

function private function_47279b5d7e2bcef3(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self enableoffhandprimaryweapons();
    return;
  }

  self disableoffhandprimaryweapons();
}

function private function_c8f662a90251117(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self enableoffhandsecondaryweapons();
    return;
  }

  self disableoffhandsecondaryweapons();
}

function private function_f61d010ff82a69da(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self allowoffhandshieldweapons(b_value);
}

function private function_54a3481116d62f02(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(b_value) {
    self enableoffhandthrowback();
    return;
  }

  self disableoffhandthrowback();
}

function private function_8493479decad7dea(b_value) {
  assertmsg("<dev string:x12d>");
}

function private function_4e24d3eb9687a667(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  assert(!isDefined(level.ismp) || level.ismp == 0);
  setsaveddvar(@ "aim_assist_script_disable", !b_value);
}

function private function_586996315a6703b0(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self enableusability();
    return;
  }

  self disableusability();
}

function private function_2553e8f1e80d32a9(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self.ignoreme = b_value;
}

function private function_d3eeff01d5db508a(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self.ignoreall = b_value;
}

function private function_ae5bbceb3d29efe6(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  assert(isPlayer(self));

  if(b_value) {
    self.nohitmarkers = undefined;
    return;
  }

  self.nohitmarkers = 1;
}

function private set_hide(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(b_value) {
    if(b_value == 1) {
      self hide();
    } else {
      self hide();
    }

    return;
  }

  self show();
}

function private set_health_regen(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(b_value) {
    self.disable_health_regen = undefined;
    return;
  }

  self.disable_health_regen = 1;
}

function private function_1140c973aa64c8d6(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self.disable_health_regen_delay = undefined;
    return;
  }

  self.disable_health_regen_delay = 1;
}

function private set_ignore_health_regen_delay(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(b_value) {
    self.ignore_health_regen_delay = 1;
    return;
  }

  self.ignore_health_regen_delay = 0;
}

function private function_a93b95cf50f8c3c9(val) {
  if(isDefined(val)) {
    self.goalradius = val;
    return;
  }

  if(isDefined(self.radius)) {
    self.goalradius = float(self.radius);
    return;
  }

  if(isDefined(self.spawner.radius)) {
    self.goalradius = float(self.spawner.radius);
    return;
  }

  self.goalradius = 2048;
}

function private function_397bdae9676d99b2(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self.skipdeath = utility::ter_op(b_value, 1, 0);
}

function private function_c7cacbe604c9200d(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self.skipscenedeath = utility::ter_op(b_value, 1, undefined);
}

function private function_ff6d5864f8680d5e(b_allow) {
  self enableplayerbreathsystem(b_allow);
}

function private function_15cc9bfda3c4adee(b_freeze) {
  self freezecontrols(b_freeze);
}

function private function_9a6ef6fcc3e3c652(b_freeze) {
  self freezelookcontrols(b_freeze);
}

function private function_d4513b1bc21601(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(!utility::ent_flag_exist("stealth_social_reveal")) {
    utility::ent_flag_init("stealth_social_reveal");
  }

  if(b_value) {
    utility::ent_flag_set("stealth_social_reveal");
    return;
  }

  utility::ent_flag_clear("stealth_social_reveal");
}

function private function_688748c7477e93dc(b_value) {
  if(b_value) {
    b_value = 0;
  } else {
    b_value = 1;
  }

  self setclientomnvar("ui_hide_hud", b_value);
}

function private function_8b2fc23241e6448b(b_value) {
  if(b_value) {
    b_value = 0;
  } else {
    b_value = 1;
  }

  self setclientomnvar("ui_hide_weapon_info", b_value);
}

function private function_147fe8bda5949cf2(b_value) {
  if(b_value) {
    b_value = 0;
  } else {
    b_value = 1;
  }

  self setclientomnvar("ui_hide_dpad_hud", b_value);
}

function private allow_melee_victim(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self.canbemeleed = utility::ter_op(b_value, 1, 0);
}

function private set_allowjump(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowjump(b_value);
}

function private function_5d8c973a5b6b05d8(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowdoublejump(b_value);
}

function private set_allowcrouch(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowcrouch(b_value);
}

function private set_allowprone(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self.var_6900f3419d3c4dd0 = b_value;
  self allowprone(b_value);
}

function private function_c8e47b79550e4319(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(b_value) {
    self allowstand(1);
    self allowcrouch(1);
    self allowprone(1);
    return;
  }

  current = self getstance();

  foreach(stance in array_remove(["stand", "crouch", "prone"], current)) {
    switch (stance) {
      case #"hash_c6775c88e38f7803":
        self allowstand(0);
        break;
      case #"hash_3fed0cbd303639eb":
        self allowcrouch(0);
        break;
      case #"hash_d91940431ed7c605":
        self allowprone(0);
        break;
    }
  }
}

function private set_allowmelee(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowmelee(b_value);
}

function private function_1e949110ce628e51(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self allowlean(b_value);
}

function private function_b3870b9ec763d70a(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowmantle(b_value);
}

function private function_97182ebc175cd93a(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self function_217a2afa4a512d2b(b_value);
}

function private function_9b5befbb13ad7651(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self allowmounttop(b_value);
}

function private function_aac726af48296365(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self allowmountside(b_value);
}

function private set_allowsprint(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowsprint(b_value);
}

function private function_2a827539b0ee61b7(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowjog(b_value);
}

function private set_allowstand(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowstand(b_value);
}

function private set_allowmovement(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowmovement(b_value);
}

function private function_f3b4bc17c87adba5(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowladder(b_value);
}

function private function_880120db350a6425(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self function_f484b2c51e0d6f5e(b_value);
}

function private function_d13b7a396eab0463(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowdive(b_value);
}

function private function_46eda303c0fa6322(val) {
  if(!isDefined(val)) {
    val = 1;
  }

  if(isai(self)) {
    asm::asm_setmoveplaybackrate(val);
    return;
  }

  if(isPlayer(self)) {
    self setmovespeedscale(val);
  }
}

function private set_desiredspeed(val) {
  if(!isDefined(val)) {
    val = 0;
  }

  if(!isai(self)) {
    assertmsg("<dev string:x15a>");
    return;
  }

  if(val > 0) {
    self aisetdesiredspeed(val);
    return;
  }

  self aiclearscriptdesiredspeed(val);
}

function private set_pushplayer(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self pushplayer(b_value);
}

function private function_ee3a42d7c6b37fe(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self enableoffhandspecialweapons();
    return;
  }

  self disableoffhandspecialweapons();
}

function private function_cfb80f3b8aad230(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    if(self tagexists("TAG_STOWED_BACKPACK_HIDE")) {
      if(!isDefined(self.operatorcustomization) || !isDefined(self.operatorcustomization.body) || self.operatorcustomization.body != "body_mp_gus_iw9_1_1") {
        self hidepart("TAG_STOWED_BACKPACK_HIDE");
      }
    }

    return;
  }

  if(self tagexists("TAG_STOWED_BACKPACK_HIDE")) {
    self showpart("TAG_STOWED_BACKPACK_HIDE");
  }
}

function private function_9c9b518e967a4514(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self function_360aa68e9d2fc8d3(!b_value, self);
}

function private function_98e071a6cc904543(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self allowwallrun(b_value);
}

function private function_156a6ef9e8bb6f63(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self energy_setenergy(0, self.doublejumpenergy);
    self energy_setrestorerate(0, self.doublejumpenergyrestorerate);
    self.doublejumpenergy = undefined;
    self.doublejumpenergyrestorerate = undefined;
    self allowdoublejump(1);
    return;
  }

  self.doublejumpenergy = self energy_getenergy(0);
  self.doublejumpenergyrestorerate = self energy_getrestorerate(0);
  self energy_setenergy(0, 0);
  self energy_setrestorerate(0, 0);
  self allowdoublejump(0);
}

function private function_60e7c22bac17f22f(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self allowslide(b_value);
}

function private function_5e4e727a591c079d(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self[[level.enableexecutionattackfunc]]();
    return;
  }

  self[[level.disableexecutionattackfunc]]();
}

function private function_eb0398e7c2c3c055(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self[[level.enableexecutionvictimfunc]]();
    return;
  }

  self[[level.disableexecutionvictimfunc]]();
}

function private function_e62e9efd7d1bf0da(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  vehicle_allowplayeruse(self, b_value);
}

function private function_798a407672c35e3c(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self function_681750c19a6216ca(b_value);
}

function private function_2a5481b1da502117(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self.var_ea02a8bfcfde7c4b = utility::ter_op(b_value, undefined, 1);
}

function private function_7edde3ba90d9a36(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(utility::iscp() && !isDefined(level.players[0].pers["useNVG"])) {
    return;
  }

  var_c7b3c8374684b876 = 2;

  if(b_value) {
    if(!isai(self)) {
      self setactionslot(var_c7b3c8374684b876, "nightvision");

      if(utility::iscp()) {
        self function_b1e64d364cf55b73(1);
      }
    }

    return;
  }

  if(!isai(self)) {
    self setactionslot(var_c7b3c8374684b876, "");

    if(utility::iscp()) {
      self function_b1e64d364cf55b73(0);
    }
  }
}

function private function_2a4de4fe3103d24c(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    if(!isai(self)) {
      self.var_24e9ac46ba2ec580 = undefined;
    }

    return;
  }

  if(!isai(self)) {
    self.var_24e9ac46ba2ec580 = 1;
  }
}

function private function_65fb0f9b12a90f29(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self allowsupersprint(b_value);
}

function private function_3368e1d4052b1596(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    if(isDefined(level.enableshellshockfunc)) {
      self[[level.enableshellshockfunc]]();
    }

    return;
  }

  if(isDefined(level.disableshellshockfunc)) {
    self[[level.disableshellshockfunc]]();
  }
}

function private function_ea01b65c909b99d2(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    if(isDefined(self.cinematicmotionoverride)) {
      self setcinematicmotionoverride(self.cinematicmotionoverride);
    } else {
      self clearcinematicmotionoverride();
    }

    return;
  }

  self setcinematicmotionoverride("disabled");
}

function private function_293669b3b38c7221(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(isDefined(self.armor) && isDefined(self.armor.toggleuifunc)) {
    self[[self.armor.toggleuifunc]](b_value);
  }
}

function private getequipmenttableinfo(ref) {
  if(isDefined(ref) && !isDefined(level.equipment.table[ref])) {
    assertmsg("<dev string:x18f>" + ref + "<dev string:x1e5>");
  }

  return level.equipment.table[ref];
}

function private getcurrentequipment(slot) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  return self.equipment[slot];
}

function private disableslotinternal(slot) {
  if(slot == "primary") {
    self clearoffhandprimary();
    return;
  }

  if(slot == "secondary") {
    self clearoffhandsecondary();
    return;
  }

  if(slot == "super") {
    self clearoffhandspecial();
  }
}

function private enableslotinternal(slot) {
  ref = getcurrentequipment(slot);
  equipmentlist = self getweaponslistoffhands();
  weapon = undefined;
  variantid = undefined;

  if(!isDefined(ref)) {
    return;
  }

  found = 0;

  foreach(equip in equipmentlist) {
    equipref = undefined;

    foreach(tableinfo in level.equipment.table) {
      if(isDefined(tableinfo.objweapon.basename) && equip.basename == tableinfo.objweapon.basename) {
        equipref = tableinfo.ref;
        break;
      }
    }

    if(isDefined(equipref) && equipref == ref) {
      found = 1;

      if(isDefined(equip.variantid) && equip.variantid > 0) {
        variantid = equip.variantid;

        if(!isDefined(equip.basename)) {
          return undefined;
        }

        if(isDefined(variantid) && variantid > 0) {
          weapon = makeweapon(equip.basename, [], undefined, undefined, variantid);
          var_1092bc40c58c1c9a = equip.basename + "|" + string(variantid);
          attachments = level.equipmentblueprints[var_1092bc40c58c1c9a];

          foreach(attachment, variant in attachments) {
            weapon = weapon withattachment(attachment, variant);
          }
        } else {
          weapon = makeweapon(equip.basename);
        }
      } else {
        tableinfo = getequipmenttableinfo(ref);
        weapon = tableinfo.objweapon;
      }

      break;
    }
  }

  tableinfo = getequipmenttableinfo(ref);

  if(!istrue(found)) {
    weapon = tableinfo.objweapon;
  }

  if(isDefined(weapon)) {
    if(isDefined(weapon) && !tableinfo.ispassive) {
      if(slot == "primary") {
        self assignweaponoffhandprimary(weapon);
        return;
      }

      if(slot == "secondary") {
        self assignweaponoffhandsecondary(weapon);
        return;
      }

      if(slot == "super") {
        self assignweaponoffhandspecial(weapon);
      }
    }
  }
}

function private function_dd8e7fdce5f0dcff(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    enableslotinternal("primary");
    return;
  }

  disableslotinternal("primary");
}

function private function_2b70e9743c9a71b(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    enableslotinternal("secondary");
    return;
  }

  disableslotinternal("secondary");
}

function private function_782c9cfc7f78e416(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  setsaveddvar(@ "hash_4771e9353baf9732", !b_value);
}

function private function_2937a757c6689fb3(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self scriptabledoorfreeze(b_value);
}

function private function_cbdfe6762b367d1b(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self.interactions_disabled = undefined;
    return;
  }

  self.interactions_disabled = 1;
}

function private function_4a0c36c985cc4a03(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(utility::iscp()) {
    if(b_value) {
      self setclientomnvar("ui_disable_inventory", 0);
      return;
    }

    self setclientomnvar("ui_disable_inventory", 1);
  }
}

function private function_d093a1b1e1c340a3(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(iscp()) {
    if(b_value) {
      self setclientomnvar("ui_show_tac_map", 1);
    } else {
      self setclientomnvar("ui_show_tac_map", 0);
    }
  }
}

function private function_4e80f7e4ffe334e0(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    utility::flag_clear("weapon_scanning_off");
    return;
  }

  utility::flag_set("weapon_scanning_off");
}

function private function_dc9ce02e5a3bd6da(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value && isDefined(self.actionslotweapon)) {
    self setactionslot(1, "weapon", self.actionslotweapon);
    return;
  }

  self setactionslot(1, "");
}

function private set_demeanor(str_value) {
  if(isai(self)) {
    if(!isDefined(str_value) || str_value == "") {
      utility::clear_demeanor_override();
      return;
    }

    utility::demeanor_override(str_value);
  }
}

function private function_e839d0e33e07c756(b_value) {
  if(isai(self)) {
    self.allowpain = b_value;
  }
}

function private function_15b077dbaf3b063f(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(!isPlayer(self) && !isagent(self)) {
    assertmsg("<dev string:x1ea>");
  }

  self function_ae3021dcebd28be1(b_value);
}

function private function_f8b197beec8e9945(val) {
  if(isDefined(level.var_60fc087bc7deaadc)) {
    self[[level.var_60fc087bc7deaadc]](val);
  }
}

function private function_7f308a0cfa036a48(b_value) {
  if(isai(self)) {
    self.killondamage = istrue(b_value);
  }
}

function private function_fc93ada8ce1701fe(b_value) {
  if(isPlayer(self) || isai(self)) {
    if(istrue(b_value)) {
      self.var_f405191d4605c15c = 0;
      return;
    }

    self.var_f405191d4605c15c = 1;
  }
}

function private function_3718505d535c6113(b_value) {
  self.var_f62adc4cc32e37c7 = istrue(b_value);
}

function function_bee64cea73f1992b(str_id, value) {
  if(value) {
    set(str_id, "fire", !value);
    set(str_id, "offhand_weapons", !value);
    set(str_id, "allow_movement", !value);
    set(str_id, "allow_jump", !value);
    set(str_id, "melee", !value);
    set(str_id, "sprint", !value);
    set(str_id, "prone", !value);
    return;
  }

  reset(str_id, "fire");
  reset(str_id, "offhand_weapons");
  reset(str_id, "allow_movement");
  reset(str_id, "allow_jump");
  reset(str_id, "melee");
  reset(str_id, "sprint");
  reset(str_id, "prone");
}

function function_91558560b423d58e(str_id, value) {
  if(value) {
    set(str_id, "offhand_weapons", !value);
    set(str_id, "allow_movement", !value);
    set(str_id, "allow_jump", !value);
    set(str_id, "melee", !value);
    set(str_id, "sprint", !value);
    return;
  }

  reset(str_id, "offhand_weapons");
  reset(str_id, "allow_movement");
  reset(str_id, "allow_jump");
  reset(str_id, "melee");
  reset(str_id, "sprint");
}

function private set_allowads(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self allowads(b_value);
}

function private function_1bc52d1afc4d1b95(s_notify, b_value) {
  self notify(s_notify, b_value);
}

function private function_4c8f023af26b4a8a(b_value) {
  if(isai(self)) {
    self.disallow_knockdown = b_value;
  }
}

function private function_db2848cc88d5a336(b_value) {
  if(isai(self)) {
    self.disallow_stun = b_value;
  }
}

function private function_b0146ba0c8f08192(b_value) {
  if(isai(self)) {
    self enableavoidance(!b_value);
    self.var_3119604b74dfdbbd = !b_value;
  }
}

function private function_d549cfeb2ed5d5e2(b_value) {
  if(isai(self)) {
    self.var_b9527ed408c69385 = b_value;
  }
}

function private function_10613d0755b1655(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self.showhealthbar = b_value;
}

function private function_ff795a8bf33046c1(b_value) {
  self.attackeraccuracy = b_value;
}

function private function_b010672d21d0fdb1(b_value) {
  if(!utility::ent_flag_exist("allow_dismember")) {
    utility::ent_flag_init("allow_dismember");
  }

  if(b_value) {
    utility::ent_flag_set("allow_dismember");
    return;
  }

  utility::ent_flag_clear("allow_dismember");
}

function private function_83f16f4f6bc886b2(b_value) {
  self function_3671ec427c125cb(istrue(b_value));
}

function private function_a93741c78d1d215b(var_cf8b5ceaf91df155) {
  if(!isDefined(var_cf8b5ceaf91df155) || var_cf8b5ceaf91df155 == "") {
    if(isDefined(level.var_673320093d434d55)) {
      self[[level.var_673320093d434d55]]();
    }

    return;
  }

  if(isDefined(level.var_237eaf521a80c304)) {
    self[[level.var_237eaf521a80c304]](var_cf8b5ceaf91df155);
  }
}

function private function_69bc203e1b8c4e63(var_ce1774b1e0c60661) {
  if(scripts\common\vehicle::isvehicle()) {
    self.disablelockon = var_ce1774b1e0c60661;
  }
}

function function_13da7718a3ccfc98(value) {
  if(!isDefined(value)) {
    value = 0;
  }

  self.ksdontforget = value;
}

function function_fd241a7be9d82fa5(eventlist) {
  if(is_equal(eventlist, "")) {
    function_ba91b16ee30d37ae();
    return;
  }

  function_71a28a935629a941(eventlist);
}

function function_f185596cc8242d28(val) {
  function_a1c249d52179826c(val);
}

function function_4ef8b4df5173b05a(val) {
  function_e280f14a391474ef(val);
}

function function_f1e27a27436441b4(val) {
  function_129c37cc2498c0d5(val);
}

function function_48cd47326fc3f73b(val) {
  function_412d0fae58ba3904(val);
}

function function_dbb2149dbfbea743(val) {
  function_dde84eabe77d9e18(val);
}

function private validate(str_name, call_on, func) {
  if(!isDefined(level.values[str_name])) {
    assertmsg("<dev string:x48>" + str_name + "<dev string:xa1>");
    return;
  }

  s_value = level.values[str_name];
  s_value.b_validate = 1;
  s_value.func_validate = func;
  s_value.validate_call_on = call_on;
}

function private validate_value(str_name, value, b_assert) {
  if(!isDefined(b_assert)) {
    b_assert = 0;
  }

  s_value = level.values[str_name];
  current_value = undefined;

  if(isDefined(s_value.func_validate)) {
    call_on = utility::ter_op(isstring(s_value.validate_call_on) && s_value.validate_call_on == "<dev string:x26>", self, s_value.validate_call_on);

    if(isDefined(s_value.validate_args)) {
      current_value = utility::single_func_argarray(call_on, s_value.func_validate, replace_values(s_value.validate_args));
    } else {
      current_value = utility::single_func_argarray(call_on, s_value.func_validate, []);
    }
  } else {
    current_value = 0;
  }

  b_match = isDefined(current_value) && current_value == value;

  if(b_assert) {
    assert(b_match, "<dev string:x22c>" + str_name + "<dev string:x242>" + current_value + "<dev string:x24c>" + value + "<dev string:x261>");
  }

  return b_match;
}

function private debug_values() {
  setdvarifuninitialized(@ "scr_debug_values", 0);
  waitframe();
  scr_debug_values = 0;
  var_145377a3061eae2 = -1;

  while(true) {
    if(gettime() > var_145377a3061eae2) {
      scr_debug_values = getdvarint(@ "scr_debug_values");
      var_145377a3061eae2 = gettime() + 1000;
    }

    if(!scr_debug_values) {
      waitframe();
      continue;
    }

    str_debug_values_entity = string::to_string(getDvar(@ "scr_debug_values_entity", "<dev string:x267>"));

    if(str_debug_values_entity == "<dev string:x267>" || str_debug_values_entity == "<dev string:x26b>" || str_debug_values_entity == "<dev string:x271>") {
      hud_ent = level.host;

      if(!isDefined(hud_ent)) {
        hud_ent = level.player;
      }

      if(!isDefined(hud_ent)) {
        hud_ent = level.players[0];
      }

      str_label = "<dev string:x279>";
    } else {
      str_value = str_debug_values_entity;
      str_key = "<dev string:x288>";

      if(issubstr(str_value, "<dev string:x296>")) {
        a_toks = strtok(str_value, "<dev string:x296>");
        str_value = a_toks[0];
        str_key = a_toks[1];
      }

      hud_ent = getEnt(str_value, str_key, 1);
      str_label = str_value + "<dev string:x296>" + str_key;
    }

    printtoscreen2d(200, 100, str_label, (1, 1, 1), 2);
    a_all_ents = getEntArray();

    foreach(ent in a_all_ents) {
      if(isDefined(ent.values)) {
        i = 1;

        foreach(str_name, a_value in ent.values) {
          top_value = a_value[0];

          if(isDefined(top_value)) {
            b_valid = 1;

            if(istrue(level.values[str_name].b_validate)) {
              b_assert = getdvarint(@ "scr_debug_values", 0) > 1;
              b_valid = ent validate_value(str_name, top_value.value, b_assert);
            }

            ent display_value(i, str_name, top_value.str_id, top_value.value, isDefined(hud_ent) && b_valid, isDefined(hud_ent) && ent == hud_ent);
            i++;
          }
        }
      }
    }

    waitframe();
  }
}

function private display_value(index, str_name, str_id, value, b_valid, on_hud) {
  if(!isDefined(on_hud)) {
    on_hud = 0;
  }

  str_value = "<dev string:x267>";

  if(string::to_string(str_name) != "<dev string:x267>") {
    str_value = string::rjust(str_name, 20);

    if(isDefined(value)) {
      str_value += "<dev string:x29b>" + value;
    }

    str_value += "<dev string:x2a2>" + string::ljust("<dev string:x267>" + str_id + "<dev string:x2a8>", 30);
  }

  color = utility::ter_op(b_valid, (1, 1, 1), (1, 0, 0));

  if(on_hud) {
    printtoscreen2d(200, 100 + index * 25, str_value, color, 2);
  }

  print3d(self.origin - (0, 0, index * 8), str_value, color, 1, 0.3, 1);
}

# /