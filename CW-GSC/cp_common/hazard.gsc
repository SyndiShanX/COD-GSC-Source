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
  function_1df189ec("heat", 500, 50, 1, &function_34e51510);
  function_1df189ec("filter", 500, 50, 2);
  function_1df189ec("o2", 500, 60, 3, &function_4a55b624);
  function_1df189ec("radiation", 500, 50, 4);
  function_1df189ec("biohazard", 500, 50, 5);
  function_1df189ec("gas", 500, 50, 6, &function_6c8414c8);
  callback::on_spawned(&on_player_spawned);
  callback::on_player_killed(&on_player_killed);
  callback::on_connect(&on_player_connect);
  level.var_c1e49fd1 = [];
  level.var_c1e49fd1[# "huditems.hess1"] = "hudItems.hess1";
  level.var_c1e49fd1[# "huditems.hess2"] = "hudItems.hess2";
}

function function_1df189ec(str_name, var_43c0c72, n_regen_rate, n_type, var_c7b7ca32) {
  if(!isDefined(level.var_f9c9c0)) {
    level.var_f9c9c0 = [];
  }

  if(!isDefined(level.var_f9c9c0[str_name])) {
    level.var_f9c9c0[str_name] = spawnStruct();
  }

  level.var_f9c9c0[str_name].var_43c0c72 = var_43c0c72;
  level.var_f9c9c0[str_name].n_regen_rate = n_regen_rate;
  level.var_f9c9c0[str_name].n_type = n_type;
  level.var_f9c9c0[str_name].var_c7b7ca32 = var_c7b7ca32;
  level.var_f9c9c0[str_name].var_13b85955 = [];
}

function on_player_spawned() {
  self reset(1);
}

function function_5795b52b(ent = self, var_393cf5b7, var_3551e3b9 = 250000, var_c6ab6ff5 = 10) {
  if(!isinarray(level.var_f9c9c0[var_393cf5b7].var_13b85955, ent)) {
    array::add(level.var_f9c9c0[var_393cf5b7].var_13b85955, ent, 0);
    ent.var_11019442 = {
      #var_3551e3b9: var_3551e3b9, #var_c6ab6ff5: var_c6ab6ff5
    };
  }
}

function function_38603984(ent = self, var_393cf5b7) {
  if(isinarray(level.var_f9c9c0[var_393cf5b7].var_13b85955, ent)) {
    arrayremovevalue(level.var_f9c9c0[var_393cf5b7].var_13b85955, ent);
    ent.var_11019442 = undefined;
  }
}

function function_551f9f75(var_393cf5b7) {
  if(isDefined(var_393cf5b7)) {
    if(isinarray(level.var_f9c9c0[var_393cf5b7], self) && isDefined(self.var_11019442)) {
      return true;
    }
  } else {
    foreach(var_4db43f60 in level.var_f9c9c0) {
      if(isinarray(var_4db43f60.var_13b85955, self) && isDefined(self.var_11019442)) {
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
  var_65e6708b = 1 - mapfloat(0, ent.var_11019442.var_3551e3b9, 0, 1, n_dist_sq);
  return var_65e6708b;
}

function function_32b2e015(ent) {
  if(!ent function_551f9f75()) {
    return 0;
  }

  n_dist_sq = distancesquared(self.origin, ent.origin);
  var_65e6708b = 1 - mapfloat(0, ent.var_11019442.var_3551e3b9, 0, 1, n_dist_sq);
  n_damage = ent.var_11019442.var_c6ab6ff5 * var_65e6708b;
  return n_damage;
}

function function_d63819fe() {
  self endon(#"death");

  if(isbot(self)) {
    return;
  }

  while(true) {
    foreach(str_name, var_4db43f60 in level.var_f9c9c0) {
      foreach(ent in var_4db43f60.var_13b85955) {
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
  foreach(str_name, _ in level.var_f9c9c0) {
    self.var_e3ab1888[str_name] = 0;
    self.var_faa7fdee[str_name] = 1;
  }

  self.var_afb10e8b = [];
  self.var_afb10e8b[# "huditems.hess1"] = 0;
  self.var_afb10e8b[# "huditems.hess2"] = 0;

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
  a_players = getplayers();
  array::thread_all(a_players, &function_c370832e);
  callback::on_spawned(&function_c370832e);
}

function function_6faef2d1() {
  callback::remove_on_spawned(&function_c370832e);
  level.var_a51b5712 = undefined;
  level notify(#"hash_440299874a982aae");

  foreach(player in getplayers()) {
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
  self.var_e3ab1888[# "gas"] = 0;

  while(true) {
    if(is_true(level.var_a51b5712)) {
      if(is_true(self.var_59d09950)) {
        if(self function_838a3ba4("gas") >= 0.75) {
          self.var_e3ab1888[# "gas"] = level.var_f9c9c0[# "gas"].var_43c0c72 * 0.75;
          self thread function_7a5f3e98("gas", undefined, 0);
        }
      } else if(self function_838a3ba4("gas") < 0.25) {
        self.var_e3ab1888[# "gas"] = level.var_f9c9c0[# "gas"].var_43c0c72 * 0.25;
        self thread function_7a5f3e98("gas", undefined, 0);
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

    var_908e6259 = getarraykeys(level.var_f9c9c0);

    foreach(str_name in var_908e6259) {
      self do_damage(str_name, 3, undefined);
      wait 0.1;
    }
  }
}

function function_66980cf3() {
  self endon(#"disconnect");

  while(true) {
    self waittill(#"player_revived");

    foreach(str_name, _ in level.var_f9c9c0) {
      if(function_838a3ba4(str_name) >= 1) {
        function_de8dda88(str_name);
      }
    }
  }
}

function function_de8dda88(str_name) {
  assert(isDefined(level.var_f9c9c0[str_name]), "<dev string:x38>" + str_name + "<dev string:x51>");
  self.var_e3ab1888[str_name] = 0;
}

function do_damage(str_name, n_damage, e_ent, disable_ui) {
  assert(isDefined(level.var_f9c9c0[str_name]), "<dev string:x38>" + str_name + "<dev string:x51>");

  if(!isDefined(disable_ui)) {
    disable_ui = 0;
  }

  if(self scene::is_igc_active()) {
    return false;
  }

  var_4db43f60 = level.var_f9c9c0[str_name];
  self.var_e3ab1888[str_name] = min(self.var_e3ab1888[str_name] + n_damage, var_4db43f60.var_43c0c72);

  if(str_name == "gas") {
    if(is_true(self.var_59d09950)) {
      if(self.var_e3ab1888[# "gas"] >= var_4db43f60.var_43c0c72 * 0.75) {
        self.var_e3ab1888[# "gas"] = var_4db43f60.var_43c0c72 * 0.75;
      }
    } else {
      self.var_e3ab1888[# "gas"] *= 1.1;
    }
  }

  if(self.var_e3ab1888[str_name] < var_4db43f60.var_43c0c72) {
    self thread function_7a5f3e98(str_name, e_ent, disable_ui);
    return true;
  }

  switch (str_name) {
    case # "o2":
      str_mod = "MOD_DROWN";
      break;
    case # "heat":
      str_mod = "MOD_BURNED";
      break;
    case # "gas":
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

  if(self.var_e3ab1888[var_36fe5e98] < level.var_f9c9c0[var_36fe5e98].var_43c0c72) {
    self notify(#"hash_146502ffd81b5e00");
  } else if(var_36fe5e98 === "gas") {
    self dodamage(self.health / 2, self.origin, undefined, undefined, undefined, str_mod);
    wait 3;
  }

  self.var_b6364cf6 = undefined;

  if(self.var_e3ab1888[var_36fe5e98] >= level.var_f9c9c0[var_36fe5e98].var_43c0c72) {
    self dodamage(self.health, self.origin, undefined, undefined, undefined, str_mod);
  }
}

function function_c64631b9(str_notify) {
  self.var_b6364cf6 = undefined;
}

function function_a4d2293(str_name) {
  assert(isDefined(self.var_e3ab1888[str_name]), "<dev string:x38>" + str_name + "<dev string:x51>");
  return self.var_e3ab1888[str_name];
}

function function_838a3ba4(str_name) {
  assert(isDefined(self.var_e3ab1888[str_name]), "<dev string:x38>" + str_name + "<dev string:x51>");
  assert(isDefined(level.var_f9c9c0[str_name]), "<dev string:x62>" + str_name + "<dev string:x51>");
  assert(isDefined(level.var_f9c9c0[str_name].var_43c0c72), "<dev string:x82>" + str_name + "<dev string:xbe>");
  assert(level.var_f9c9c0[str_name].var_43c0c72 != 0, "<dev string:xc4>" + str_name + "<dev string:xbe>");
  return self.var_e3ab1888[str_name] / level.var_f9c9c0[str_name].var_43c0c72;
}

function function_e9b38487(str_name, var_e7cbf6d7 = 1) {
  assert(isDefined(self.var_faa7fdee[str_name]), "<dev string:x38>" + str_name + "<dev string:x51>");
  self.var_faa7fdee[str_name] = var_e7cbf6d7;
}

function private function_7a5f3e98(str_name, e_ent, disable_ui) {
  self notify("_hazard_protection_" + str_name);
  self endon("_hazard_protection_" + str_name, #"death");
  var_4db43f60 = level.var_f9c9c0[str_name];
  var_cf8dfdc = "";

  foreach(model, type in self.var_afb10e8b) {
    if(type == var_4db43f60.n_type) {
      var_cf8dfdc = model;
      break;
    }
  }

  if(var_cf8dfdc == "") {
    foreach(model, type in self.var_afb10e8b) {
      if(type == 0) {
        var_cf8dfdc = model;
        break;
      }
    }
  }

  if(var_cf8dfdc != "") {
    if(disable_ui) {}

    self.var_afb10e8b[var_cf8dfdc] = var_4db43f60.n_type;
  }

  do {
    n_frac = mapfloat(0, var_4db43f60.var_43c0c72, 1, 0, self.var_e3ab1888[str_name]);

    if(var_cf8dfdc != "" && !disable_ui) {}

    if(isDefined(var_4db43f60.var_c7b7ca32)) {
      [[var_4db43f60.var_c7b7ca32]](n_frac, e_ent);
    }

    waitframe(1);

    if(self.var_faa7fdee[str_name] == 1) {
      self.var_e3ab1888[str_name] -= var_4db43f60.n_regen_rate * float(function_60d95f53()) / 1000;
    }
  }
  while(self.var_e3ab1888[str_name] >= 0);

  self function_b9699173();

  if(var_cf8dfdc != "") {
    if(disable_ui) {}

    self.var_afb10e8b[var_cf8dfdc] = 0;
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

function function_6c8414c8(var_57d16334, e_ent) {
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
    if(self function_838a3ba4("gas") < 0.25) {
      self allowsprint(1);
      self allowslide(1);
    }

    if(self function_838a3ba4("gas") >= 0.25) {
      self allowsprint(0);
      self allowslide(0);
    }

    if(self function_838a3ba4("gas") < 0.5) {
      self allowjump(1);
    }

    if(self function_838a3ba4("gas") >= 0.5) {
      self allowjump(0);
    }

    if(self function_838a3ba4("gas") > 0.75) {
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

function function_34e51510(var_57d16334, e_ent) {
  if(!isDefined(e_ent) || scene::is_igc_active()) {
    self.var_fa3bf1f = undefined;
    self clientfield::set("burn", 0);
    return;
  }

  if(!is_true(self.var_fa3bf1f) && self istouching(e_ent)) {
    self clientfield::set("burn", 1);
    return;
  }

  self.var_fa3bf1f = undefined;
  self clientfield::set("burn", 0);
}

function function_d9a95517() {
  self endon(#"death");
  self clientfield::set_to_player("player_cam_bubbles", 1);
  wait 4;
  self clientfield::set_to_player("player_cam_bubbles", 0);
}

function function_4a55b624(var_3543da4, e_ent) {
  if(!isDefined(self.var_92ad1a5c)) {
    self.var_92ad1a5c = 0;
  }

  if(e_ent <= 0.2) {
    if(self.var_92ad1a5c > 0.2) {
      self thread function_d9a95517();
    }
  } else if(e_ent <= 0.1) {
    if(self.var_92ad1a5c > 0.1) {
      self thread function_d9a95517();
    }
  }

  var_7b926b32 = array(0.5, 0.3, 0.2, 0.15, 0.1, 0.5);

  foreach(num in var_7b926b32) {
    if(e_ent != 0 && e_ent <= num) {
      if(self.var_92ad1a5c > num) {
        self playSound(#"hash_1a34cdbf42c44d1d");

        if(num < 0.4) {
          self thread function_c3bcd54a("vox_plyr_uw_emerge_gasp");
        } else {
          self thread function_c3bcd54a("vox_plyr_uw_emerge");
        }

        break;
      }
    }
  }

  self.var_92ad1a5c = e_ent;
}

function function_c3bcd54a(alias) {
  self notify(#"hash_715de5af996bbe35");
  self endon(#"hash_715de5af996bbe35", #"death");
  level endon(#"save_restore");

  while(self isplayerunderwater()) {
    wait 0.1;
  }

  self playSound(alias);
}

function function_a80c4c4f(n_time, var_a64e984c = 1) {
  self thread function_54b9a44e("o2", 4, n_time, var_a64e984c);
}

function function_54b9a44e(str_hazard, var_25dc3e31, n_time, var_a64e984c) {
  assert(isDefined(level.var_f9c9c0[str_hazard]), "<dev string:x38>" + str_hazard + "<dev string:x51>");
  self notify("stop_hazard_dot_" + str_hazard);
  self endon("stop_hazard_dot_" + str_hazard, #"death");
  self function_e9b38487(str_hazard, 0);
  var_9ec8f5ba = 1;
  var_4db43f60 = level.var_f9c9c0[str_hazard];
  n_damage = var_25dc3e31;

  if(isDefined(n_time)) {
    var_c946aac = self function_a4d2293(str_hazard);
    var_bb7cc5e4 = var_4db43f60.var_43c0c72;
    var_8a801a72 = var_a64e984c * var_bb7cc5e4;
    var_235cc8af = var_8a801a72 - var_c946aac;

    if(var_235cc8af > 0) {}
  }

  for(n_damage = var_235cc8af / n_time; true; n_damage = var_25dc3e31) {
    wait 1;
    var_9ec8f5ba = self do_damage(str_hazard, n_damage);
    var_6afe1e1a = self function_838a3ba4(str_hazard);

    if(n_damage > var_25dc3e31 && var_6afe1e1a >= var_a64e984c) {}
  }
}

function function_87eaefa2(str_hazard) {
  self notify("stop_hazard_dot_" + str_hazard);
  self function_e9b38487(str_hazard, 1);
}