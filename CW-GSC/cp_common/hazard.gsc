/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\hazard.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace hazard;

function private autoexec __init__system__() {
  system::register(#"hazard", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "hazard_gas", 1, 1, "int");
  clientfield::register("toplayer", "hazard_gas_with_mask", 1, 1, "int");
  add_hazard("heat", 500, 50, 1, &update_heat);
  add_hazard("filter", 500, 50, 2);
  add_hazard("o2", 500, 60, 3, &update_o2);
  add_hazard("radiation", 500, 50, 4);
  add_hazard("biohazard", 500, 50, 5);
  add_hazard("gas", 500, 50, 6, &function_6c8414c8);
  callback::on_spawned(&on_player_spawned);
  callback::on_player_killed(&on_player_killed);
  callback::on_connect(&on_player_connect);
  level.var_c1e49fd1 = [];
  level.var_c1e49fd1[#"huditems.hess1"] = "hudItems.hess1";
  level.var_c1e49fd1[#"huditems.hess2"] = "hudItems.hess2";
}

function add_hazard(str_name, n_max_protection, n_regen_rate, n_type, func_update) {
  if(!isDefined(level.hazards)) {
    level.hazards = [];
  }

  if(!isDefined(level.hazards[str_name])) {
    level.hazards[str_name] = spawnStruct();
  }

  level.hazards[str_name].n_max_protection = n_max_protection;
  level.hazards[str_name].n_regen_rate = n_regen_rate;
  level.hazards[str_name].n_type = n_type;
  level.hazards[str_name].func_update = func_update;
  level.hazards[str_name].var_13b85955 = [];
}

function on_player_spawned() {
  self reset(1);
}

function function_5795b52b(ent = self, var_393cf5b7, n_max_dist_sq = 250000, var_c6ab6ff5 = 10) {
  if(!isinarray(level.hazards[var_393cf5b7].var_13b85955, ent)) {
    array::add(level.hazards[var_393cf5b7].var_13b85955, ent, 0);
    ent.var_11019442 = {
      #n_max_dist_sq: n_max_dist_sq, #var_c6ab6ff5: var_c6ab6ff5
    };
  }
}

function function_38603984(ent = self, var_393cf5b7) {
  if(isinarray(level.hazards[var_393cf5b7].var_13b85955, ent)) {
    arrayremovevalue(level.hazards[var_393cf5b7].var_13b85955, ent);
    ent.var_11019442 = undefined;
  }
}

function function_551f9f75(var_393cf5b7) {
  if(isDefined(var_393cf5b7)) {
    if(isinarray(level.hazards[var_393cf5b7], self) && isDefined(self.var_11019442)) {
      return true;
    }
  } else {
    foreach(s_hazard in level.hazards) {
      if(isinarray(s_hazard.var_13b85955, self) && isDefined(self.var_11019442)) {
        return true;
      }
    }
  }

  return false;
}

function function_cc876e01(ent) {
  if(self istouching(ent)) {
    return 1;
  }

  if(!ent function_551f9f75()) {
    return 0;
  }

  n_dist_sq = distancesquared(self.origin, ent.origin);
  n_dist_normalized = 1 - mapfloat(0, ent.var_11019442.n_max_dist_sq, 0, 1, n_dist_sq);
  return n_dist_normalized;
}

function function_32b2e015(ent) {
  if(!ent function_551f9f75()) {
    return 0;
  }

  n_dist_sq = distancesquared(self.origin, ent.origin);
  n_dist_normalized = 1 - mapfloat(0, ent.var_11019442.n_max_dist_sq, 0, 1, n_dist_sq);
  n_damage = ent.var_11019442.var_c6ab6ff5 * n_dist_normalized;
  return n_damage;
}

function function_d63819fe() {
  self endon(#"death");

  if(isbot(self)) {
    return;
  }

  while(true) {
    foreach(str_name, s_hazard in level.hazards) {
      foreach(ent in s_hazard.var_13b85955) {
        if(isDefined(ent) && self function_cc876e01(ent)) {
          n_damage = function_32b2e015(ent);
          self do_damage(str_name, n_damage, ent, 0);
        }
      }
    }

    waitframe(1);
  }
}

function on_player_connect() {
  self reset(0);
  self thread function_26752de1();
  self thread function_66980cf3();
}

function on_player_killed(params) {
  self reset(1);
  self function_b9699173();
}

function reset(var_f9b16c16) {
  foreach(str_name, _ in level.hazards) {
    self.hazard_damage[str_name] = 0;
    self.var_faa7fdee[str_name] = 1;
  }

  self.hazard_ui_models = [];
  self.hazard_ui_models[#"huditems.hess1"] = 0;
  self.hazard_ui_models[#"huditems.hess2"] = 0;

  if(var_f9b16c16) {}
}

function function_c370832e() {
  if(is_true(level.var_a51b5712)) {
    waitframe(1);

    if(is_true(self.var_59d09950)) {
      self allowsprint(1);
      self allowslide(1);
    } else {
      self.var_bbfa647a = 1;
      self allowsprint(0);
      self allowslide(0);
    }

    self allowjump(1);
    self thread function_ec94d4eb();
    return;
  }

  self allowsprint(1);
  self allowslide(1);
  self allowjump(1);
}

function function_81d8cdd8() {
  level.var_a51b5712 = 1;
  a_players = getPlayers();
  array::thread_all(a_players, &function_c370832e);
  callback::on_spawned(&function_c370832e);
}

function function_6faef2d1() {
  callback::remove_on_spawned(&function_c370832e);
  level.var_a51b5712 = undefined;
  level notify(#"hash_440299874a982aae");

  foreach(player in getPlayers()) {
    if(is_true(player.var_bbfa647a)) {
      player.var_bbfa647a = undefined;
      player allowsprint(1);
      player allowslide(1);
    }
  }
}

function function_c687b8bc() {
  return is_true(level.var_a51b5712);
}

function function_b52c674a() {
  self.var_59d09950 = 1;
}

function remove_gas_mask() {
  self.var_59d09950 = undefined;
}

function function_612d007d() {
  return is_true(self.var_59d09950);
}

function function_ec94d4eb() {
  self notify(#"hash_440299874a982aae");
  self endon(#"hash_440299874a982aae", #"death");
  level endon(#"hash_440299874a982aae");
  self.hazard_damage[#"gas"] = 0;

  while(true) {
    if(is_true(level.var_a51b5712)) {
      if(is_true(self.var_59d09950)) {
        if(self get_damage_fraction("gas") >= 0.75) {
          self.hazard_damage[#"gas"] = level.hazards[#"gas"].n_max_protection * 0.75;
          self thread _fill_hazard_protection("gas", undefined, 0);
        }
      } else if(self get_damage_fraction("gas") < 0.25) {
        self.hazard_damage[#"gas"] = level.hazards[#"gas"].n_max_protection * 0.25;
        self thread _fill_hazard_protection("gas", undefined, 0);
      }
    }

    waitframe(1);
  }
}

function function_26752de1() {
  self endon(#"disconnect");

  while(true) {
    level waittill(#"save_restore");

    if(is_true(self.var_ac0c25c9)) {
      continue;
    }

    hazard_names = getarraykeys(level.hazards);

    foreach(str_name in hazard_names) {
      self do_damage(str_name, 3, undefined);
      wait 0.1;
    }
  }
}

function function_66980cf3() {
  self endon(#"disconnect");

  while(true) {
    self waittill(#"player_revived");

    foreach(str_name, _ in level.hazards) {
      if(get_damage_fraction(str_name) >= 1) {
        reset_damage(str_name);
      }
    }
  }
}

function reset_damage(str_name) {
  assert(isDefined(level.hazards[str_name]), "<dev string:x38>" + str_name + "<dev string:x51>");
  self.hazard_damage[str_name] = 0;
}

function do_damage(str_name, n_damage, e_ent, disable_ui) {
  assert(isDefined(level.hazards[str_name]), "<dev string:x38>" + str_name + "<dev string:x51>");

  if(!isDefined(disable_ui)) {
    disable_ui = 0;
  }

  if(self scene::is_igc_active()) {
    return false;
  }

  s_hazard = level.hazards[str_name];
  self.hazard_damage[str_name] = min(self.hazard_damage[str_name] + n_damage, s_hazard.n_max_protection);

  if(str_name == "gas") {
    if(is_true(self.var_59d09950)) {
      if(self.hazard_damage[#"gas"] >= s_hazard.n_max_protection * 0.75) {
        self.hazard_damage[#"gas"] = s_hazard.n_max_protection * 0.75;
      }
    } else {
      self.hazard_damage[#"gas"] *= 1.1;
    }
  }

  if(self.hazard_damage[str_name] < s_hazard.n_max_protection) {
    self thread _fill_hazard_protection(str_name, e_ent, disable_ui);
    return true;
  }

  switch (str_name) {
    case #"o2":
      str_mod = "MOD_DROWN";
      break;
    case #"heat":
      str_mod = "MOD_BURNED";
      break;
    case #"gas":
      str_mod = "MOD_GAS";
      n_delay = 3.5;
      break;
    default:
      str_mod = "MOD_UNKNOWN";
      break;
  }

  if(!is_true(self.var_b6364cf6)) {
    self.var_b6364cf6 = 1;
    self thread function_df0660b4(str_name, str_mod, n_delay);
  }

  return false;
}

function function_df0660b4(var_36fe5e98, str_mod, n_delay) {
  self endoncallback(&function_c64631b9, #"hash_146502ffd81b5e00", #"death");

  if(isDefined(n_delay)) {
    wait n_delay;
  }

  if(self.hazard_damage[var_36fe5e98] < level.hazards[var_36fe5e98].n_max_protection) {
    self notify(#"hash_146502ffd81b5e00");
  } else if(var_36fe5e98 === "gas") {
    self dodamage(self.health / 2, self.origin, undefined, undefined, undefined, str_mod);
    wait 3;
  }

  self.var_b6364cf6 = undefined;

  if(self.hazard_damage[var_36fe5e98] >= level.hazards[var_36fe5e98].n_max_protection) {
    self dodamage(self.health, self.origin, undefined, undefined, undefined, str_mod);
  }
}

function function_c64631b9(str_notify) {
  self.var_b6364cf6 = undefined;
}

function get_damage(str_name) {
  assert(isDefined(self.hazard_damage[str_name]), "<dev string:x38>" + str_name + "<dev string:x51>");
  return self.hazard_damage[str_name];
}

function get_damage_fraction(str_name) {
  assert(isDefined(self.hazard_damage[str_name]), "<dev string:x38>" + str_name + "<dev string:x51>");
  assert(isDefined(level.hazards[str_name]), "<dev string:x62>" + str_name + "<dev string:x51>");
  assert(isDefined(level.hazards[str_name].n_max_protection), "<dev string:x82>" + str_name + "<dev string:xbe>");
  assert(level.hazards[str_name].n_max_protection != 0, "<dev string:xc4>" + str_name + "<dev string:xbe>");
  return self.hazard_damage[str_name] / level.hazards[str_name].n_max_protection;
}

function toggle_regen(str_name, b_regen = 1) {
  assert(isDefined(self.var_faa7fdee[str_name]), "<dev string:x38>" + str_name + "<dev string:x51>");
  self.var_faa7fdee[str_name] = b_regen;
}

function private _fill_hazard_protection(str_name, e_ent, disable_ui) {
  self notify("_hazard_protection_" + str_name);
  self endon("_hazard_protection_" + str_name, #"death");
  s_hazard = level.hazards[str_name];
  str_ui_model = "";

  foreach(model, type in self.hazard_ui_models) {
    if(type == s_hazard.n_type) {
      str_ui_model = model;
      break;
    }
  }

  if(str_ui_model == "") {
    foreach(model, type in self.hazard_ui_models) {
      if(type == 0) {
        str_ui_model = model;
        break;
      }
    }
  }

  if(str_ui_model != "") {
    if(disable_ui) {}

    self.hazard_ui_models[str_ui_model] = s_hazard.n_type;
  }

  do {
    n_frac = mapfloat(0, s_hazard.n_max_protection, 1, 0, self.hazard_damage[str_name]);

    if(str_ui_model != "" && !disable_ui) {}

    if(isDefined(s_hazard.func_update)) {
      [[s_hazard.func_update]](n_frac, e_ent);
    }

    waitframe(1);

    if(self.var_faa7fdee[str_name] == 1) {
      self.hazard_damage[str_name] -= s_hazard.n_regen_rate * float(function_60d95f53()) / 1000;
    }
  }
  while(self.hazard_damage[str_name] >= 0);

  self function_b9699173();

  if(str_ui_model != "") {
    if(disable_ui) {}

    self.hazard_ui_models[str_ui_model] = 0;
    return;
  }

  util::warning("Invalid UI model while running _fill_hazard_protection() in hazard.gsc");
}

function function_b9699173() {
  self clientfield::set("burn", 0);
  self clientfield::set_to_player("player_cam_bubbles", 0);
  self clientfield::set_to_player("hazard_gas", 0);
  self clientfield::set_to_player("hazard_gas_with_mask", 0);
  self.var_d3021168 = undefined;
}

function function_6c8414c8(n_damage_frac, e_ent) {
  if(!isDefined(e_ent) || self scene::is_igc_active()) {
    self.var_d3021168 = undefined;

    if(is_true(self.var_59d09950)) {
      self clientfield::set_to_player("hazard_gas_with_mask", 0);
      return;
    }

    self clientfield::set_to_player("hazard_gas", 0);
    return;
  }

  if(!is_true(self.var_d3021168) && self function_cc876e01(e_ent)) {
    self.var_d3021168 = 1;
    self thread function_f8b76be2(e_ent);

    if(is_true(self.var_59d09950)) {
      self clientfield::set_to_player("hazard_gas_with_mask", 1);
    } else {
      self clientfield::set_to_player("hazard_gas", 1);
      self thread function_706c6374(e_ent);
      self thread function_ec916448(e_ent);
    }

    return;
  }

  if(is_true(self.var_d3021168) && !self function_cc876e01(e_ent)) {
    self notify(#"hash_146502ffd81b5e00");
    self notify(#"hash_3f0b3437172b9a8");
    self.var_d3021168 = undefined;

    if(is_true(self.var_59d09950)) {
      self clientfield::set_to_player("hazard_gas_with_mask", 0);
      return;
    }

    self clientfield::set_to_player("hazard_gas", 0);
  }
}

function function_f8b76be2(var_4380761c) {
  self notify(#"entered_gas");
  self endon(#"death", #"entered_gas");
  var_c98d6d89 = self getmovespeedscale();

  while(isDefined(var_4380761c) && self function_cc876e01(var_4380761c)) {
    if(self get_damage_fraction("gas") < 0.25) {
      self allowsprint(1);
      self allowslide(1);
    }

    if(self get_damage_fraction("gas") >= 0.25) {
      self allowsprint(0);
      self allowslide(0);
    }

    if(self get_damage_fraction("gas") < 0.5) {
      self allowjump(1);
    }

    if(self get_damage_fraction("gas") >= 0.5) {
      self allowjump(0);
    }

    if(self get_damage_fraction("gas") > 0.75) {
      var_c98d6d89 -= 0.02;

      if(var_c98d6d89 < 0.25) {
        var_c98d6d89 = 0.25;
      }

      self setmovespeedscale(var_c98d6d89);
    }

    waitframe(1);
  }

  self thread function_fadc8777();
}

function function_fadc8777() {
  self notify(#"hash_6beb94844e993bc4");
  self endon(#"death", #"entered_gas", #"hash_6beb94844e993bc4");
  var_c98d6d89 = self getmovespeedscale();

  if(function_c687b8bc()) {
    if(self function_612d007d()) {
      self allowsprint(1);
      self allowslide(1);
    }

    self allowjump(1);
  } else {
    self allowsprint(1);
    self allowslide(1);
    self allowjump(1);
  }

  while(var_c98d6d89 < 1) {
    var_c98d6d89 += 0.02;
    var_c98d6d89 = math::clamp(var_c98d6d89, 0.25, 1);
    self setmovespeedscale(var_c98d6d89);
    waitframe(1);
  }
}

function function_706c6374(var_4380761c) {
  self endon(#"death", #"end_fan");
  var_46d77ca5 = getweapon(#"hash_dc178a25bd3f753");
  w_current = self getcurrentweapon();
  self disableweaponcycling();

  while(isDefined(var_4380761c) && self function_cc876e01(var_4380761c)) {
    self giveweapon(var_46d77ca5);
    self switchtoweapon(var_46d77ca5);
    wait 3;
    self takeweapon(var_46d77ca5);
    self switchtoweapon(w_current);
    wait 2;
  }
}

function function_ec916448(var_4380761c) {
  self endon(#"death");
  w_current = self getcurrentweapon();
  var_46d77ca5 = getweapon(#"hash_dc178a25bd3f753");

  while(isDefined(var_4380761c) && self function_cc876e01(var_4380761c)) {
    wait 0.1;
  }

  self notify(#"end_fan");
  self takeweapon(var_46d77ca5);
  self switchtoweapon(w_current);
  self enableweaponcycling();
}

function update_heat(n_damage_frac, e_ent) {
  if(!isDefined(e_ent) || scene::is_igc_active()) {
    self.b_hazard_burning = undefined;
    self clientfield::set("burn", 0);
    return;
  }

  if(!is_true(self.b_hazard_burning) && self istouching(e_ent)) {
    self clientfield::set("burn", 1);
    return;
  }

  self.b_hazard_burning = undefined;
  self clientfield::set("burn", 0);
}

function drown_warning() {
  self endon(#"death");
  self clientfield::set_to_player("player_cam_bubbles", 1);
  wait 4;
  self clientfield::set_to_player("player_cam_bubbles", 0);
}

function update_o2(n_drown_frac_curr, e_ent) {
  if(!isDefined(self.n_hazard_drown_frac_last)) {
    self.n_hazard_drown_frac_last = 0;
  }

  if(e_ent <= 0.2) {
    if(self.n_hazard_drown_frac_last > 0.2) {
      self thread drown_warning();
    }
  } else if(e_ent <= 0.1) {
    if(self.n_hazard_drown_frac_last > 0.1) {
      self thread drown_warning();
    }
  }

  sndarray = array(0.5, 0.3, 0.2, 0.15, 0.1, 0.5);

  foreach(num in sndarray) {
    if(e_ent != 0 && e_ent <= num) {
      if(self.n_hazard_drown_frac_last > num) {
        self playSound(#"vox_plyr_uw_gasp");

        if(num < 0.4) {
          self thread sndemerge("vox_plyr_uw_emerge_gasp");
        } else {
          self thread sndemerge("vox_plyr_uw_emerge");
        }

        break;
      }
    }
  }

  self.n_hazard_drown_frac_last = e_ent;
}

function sndemerge(alias) {
  self notify(#"sndemerge");
  self endon(#"sndemerge", #"death");
  level endon(#"save_restore");

  while(self isplayerunderwater()) {
    wait 0.1;
  }

  self playSound(alias);
}

function hazard_dot_o2(n_time, n_goal_frac = 1) {
  self thread hazard_dot("o2", 4, n_time, n_goal_frac);
}

function hazard_dot(str_hazard, n_hazard_damage, n_time, n_goal_frac) {
  assert(isDefined(level.hazards[str_hazard]), "<dev string:x38>" + str_hazard + "<dev string:x51>");
  self notify("stop_hazard_dot_" + str_hazard);
  self endon("stop_hazard_dot_" + str_hazard, #"death");
  self toggle_regen(str_hazard, 0);
  b_protected = 1;
  s_hazard = level.hazards[str_hazard];
  n_damage = n_hazard_damage;

  if(isDefined(n_time)) {
    n_curr_damage = self get_damage(str_hazard);
    n_max_protect = s_hazard.n_max_protection;
    n_goal_damage = n_goal_frac * n_max_protect;
    n_damage_diff = n_goal_damage - n_curr_damage;

    if(n_damage_diff > 0) {}
  }

  for(n_damage = n_damage_diff / n_time; true; n_damage = n_hazard_damage) {
    wait 1;
    b_protected = self do_damage(str_hazard, n_damage);
    n_damage_frac_curr = self get_damage_fraction(str_hazard);

    if(n_damage > n_hazard_damage && n_damage_frac_curr >= n_goal_frac) {}
  }
}

function stop_hazard_dot(str_hazard) {
  self notify("stop_hazard_dot_" + str_hazard);
  self toggle_regen(str_hazard, 1);
}