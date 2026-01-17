/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_elemental_bow_wolf_howl.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_elemental_bow;
#using scripts\zm\_zm_weapons;
#namespace _zm_weap_elemental_bow_wolf_howl;

function autoexec __init__sytem__() {
  system::register("_zm_weap_elemental_bow_wolf_howl", &__init__, &__main__, undefined);
}

function __init__() {
  level.var_e93874ed = getweapon("elemental_bow_wolf_howl");
  level.var_30611368 = getweapon("elemental_bow_wolf_howl4");
  clientfield::register("toplayer", "elemental_bow_wolf_howl" + "_ambient_bow_fx", 5000, 1, "int");
  clientfield::register("missile", "elemental_bow_wolf_howl" + "_arrow_impact_fx", 5000, 1, "int");
  clientfield::register("scriptmover", "elemental_bow_wolf_howl4" + "_arrow_impact_fx", 5000, 1, "int");
  clientfield::register("toplayer", "wolf_howl_muzzle_flash", 5000, 1, "int");
  clientfield::register("scriptmover", "wolf_howl_arrow_charged_trail", 5000, 1, "int");
  clientfield::register("scriptmover", "wolf_howl_arrow_charged_spiral", 5000, 1, "int");
  clientfield::register("actor", "wolf_howl_slow_snow_fx", 5000, 1, "int");
  clientfield::register("actor", "zombie_hit_by_wolf_howl_charge", 5000, 1, "int");
  clientfield::register("actor", "wolf_howl_zombie_explode_fx", 8000, 1, "counter");
  callback::on_connect(&function_b1b2ffc8);
  zm_spawner::register_zombie_damage_callback(&function_5fded2aa);
}

function __main__() {}

function function_b1b2ffc8() {
  self endon("disconnect");
  self thread zm_weap_elemental_bow::function_982419bb("elemental_bow_wolf_howl");
  self thread zm_weap_elemental_bow::function_ececa597("elemental_bow_wolf_howl", "elemental_bow_wolf_howl4", &function_9b74f1f4);
  self thread zm_weap_elemental_bow::function_7bc6b9d("elemental_bow_wolf_howl", "elemental_bow_wolf_howl4", &function_dd4f7cba);
  while(true) {
    self waittill("weapon_change", newweapon);
    if(newweapon.name === "elemental_bow_wolf_howl") {
      break;
    }
  }
  function_71ad33d4();
}

function function_9b74f1f4(projectile, weapon) {
  if(weapon.name == "elemental_bow_wolf_howl4") {
    var_307bab92 = (projectile.origin + (0, 0, 0)) + (anglesToForward(projectile.angles) * 64);
    projectile thread function_f9c890ed();
    self thread function_27bcaea1(var_307bab92);
  }
}

function function_dd4f7cba(weapon, position, radius, attacker, normal) {
  if(weapon.name != "elemental_bow_wolf_howl4") {
    attacker clientfield::set("elemental_bow_wolf_howl" + "_arrow_impact_fx", 1);
  }
}

function function_f9c890ed() {
  self endon("death");
  util::wait_network_frame();
  self delete();
}

function function_27bcaea1(var_307bab92) {
  var_c807e383 = anglesToForward(self getplayerangles());
  v_up = anglestoup(self getplayerangles());
  var_f35778e8 = length(var_307bab92 - self getEye());
  a_trace = bulletTrace(self getEye(), var_307bab92, 0, self);
  if(a_trace["fraction"] < 1) {
    var_8f0f462c = self function_4f87899e(a_trace["position"], var_c807e383, v_up, 1);
    util::wait_network_frame();
    if(isDefined(var_8f0f462c)) {
      function_6b3aa15a(a_trace["position"], var_8f0f462c);
    }
  } else {
    function_a2209df2(self, var_307bab92, var_c807e383, v_up, 1);
  }
}

function function_a2209df2(e_player, var_307bab92, var_c807e383, v_up, var_5c44718b, var_8f0f462c = undefined) {
  if(!zm_utility::is_player_valid(e_player)) {
    return;
  }
  if(var_5c44718b) {
    var_8f0f462c = e_player function_4f87899e(var_307bab92, var_c807e383, v_up, var_5c44718b);
    if(isDefined(var_8f0f462c)) {
      function_cc1bf02e(var_8f0f462c, 1);
    }
  }
  if(isDefined(var_8f0f462c)) {
    var_28388a90 = var_8f0f462c[0];
    var_9259c91b = var_8f0f462c[1];
    var_205259e0 = var_8f0f462c[2];
    var_28388a90.v_start_pos = var_307bab92;
    var_9b1b7a83 = 2560 - var_28388a90.var_76a58ed1;
    var_307bab92 = (var_5c44718b ? var_307bab92 - (0, 0, 0) : var_307bab92 - ((0, 0, 0) * 2));
    a_trace = bulletTrace(var_307bab92, var_307bab92 + (var_c807e383 * var_9b1b7a83), 0, e_player);
    var_20d031ed = a_trace["fraction"] * var_9b1b7a83;
    if(var_20d031ed > 32) {
      var_28388a90.var_76a58ed1 = var_28388a90.var_76a58ed1 + var_20d031ed;
      var_69a783ad = a_trace["position"] - (var_c807e383 * 32);
      var_72027ac3 = var_20d031ed / 1920;
      str_return = "none";
      if(var_72027ac3 > 0) {
        var_28388a90 moveto(var_69a783ad, var_72027ac3, var_72027ac3 * 0.3, 0);
        level thread function_2abb74b7(e_player, var_8f0f462c, var_c807e383);
        level thread function_a6220124(var_8f0f462c);
        if(var_5c44718b) {
          level thread function_b7d621a1(e_player, var_8f0f462c);
        }
        str_return = var_28388a90 util::waittill_any_return("movedone", "mechz_impact");
      }
      if(str_return != "mechz_impact" && var_5c44718b) {
        var_307bab92 = var_28388a90.origin;
        v_surface_normal = getnavmeshfacenormal(var_28388a90.origin, 2560);
        if(isDefined(v_surface_normal)) {
          v_up = v_surface_normal;
          var_c807e383 = vectorcross(v_up, anglestoright(var_9259c91b.angles));
          level thread function_a2209df2(e_player, var_307bab92, var_c807e383, v_up, 0, var_8f0f462c);
          return;
        }
      }
    }
    function_6b3aa15a(var_28388a90.origin, var_8f0f462c);
  }
}

function function_71ad33d4() {
  if(!isDefined(self.var_ce6323c7)) {
    for(i = 0; i < 2; i++) {
      self.var_ce6323c7[i] = zm_net::network_safe_spawn("wolf_howl_charge_base", 2, "script_model", (100, 300, -200));
      self.var_ce6323c7[i] setModel("tag_origin");
      self.var_ce6323c7[i].in_use = 0;
    }
    for(i = 0; i < 2; i++) {
      self.var_7222627b[i] = zm_net::network_safe_spawn("wolf_howl_charge_viz_wolf01", 2, "script_model", (100, 300, -200));
      self.var_7222627b[i] setModel("tag_origin");
    }
    for(i = 0; i < 2; i++) {
      self.var_1af340[i] = zm_net::network_safe_spawn("wolf_howl_charge_viz_wolf02", 2, "script_model", (100, 300, -200));
      self.var_1af340[i] setModel("tag_origin");
    }
  }
}

function function_4f87899e(var_307bab92, var_c807e383, v_up, var_5c44718b) {
  var_43fbd2aa = vectortoangles(var_c807e383);
  var_7918daf0 = v_up * -24;
  v_spawn_pos = var_307bab92;
  var_3c9168a7 = undefined;
  if(!isDefined(self.var_ce6323c7)) {
    function_71ad33d4();
  }
  if(var_5c44718b) {
    foreach(n_index, var_3c5572a7 in self.var_ce6323c7) {
      if(!var_3c5572a7.in_use) {
        var_3c5572a7.in_use = 1;
        var_3c5572a7.var_76a58ed1 = 0;
        var_3c9168a7 = n_index;
        break;
      }
    }
  }
  if(isDefined(var_3c9168a7)) {
    self.var_ce6323c7[var_3c9168a7].origin = v_spawn_pos;
    self.var_ce6323c7[var_3c9168a7].angles = (var_43fbd2aa[0], var_43fbd2aa[1], 0);
    if(var_5c44718b) {
      self.var_7222627b[var_3c9168a7].origin = v_spawn_pos + var_7918daf0;
      self.var_7222627b[var_3c9168a7].angles = var_43fbd2aa;
      self.var_1af340[var_3c9168a7].origin = v_spawn_pos - var_7918daf0;
      self.var_1af340[var_3c9168a7].angles = var_43fbd2aa;
    }
    return array(self.var_ce6323c7[var_3c9168a7], self.var_7222627b[var_3c9168a7], self.var_1af340[var_3c9168a7]);
  }
  return undefined;
}

function function_2abb74b7(e_player, var_8f0f462c, var_c807e383) {
  var_28388a90 = var_8f0f462c[0];
  var_28388a90 endon("movedone");
  var_28388a90 endon("mechz_impact");
  var_7839cab3 = 409600;
  var_a90ad319 = vectortoangles(var_c807e383);
  var_200ee8c9 = (1920 * 0.1) * 2;
  var_67da22f = 32;
  while(true) {
    var_ae2cfcc2 = getaiteamarray(level.zombie_team);
    var_7478bee7 = array::get_all_closest(var_28388a90.origin, var_ae2cfcc2, undefined, undefined, var_200ee8c9);
    var_7478bee7 = array::filter(var_7478bee7, 0, &zm_weap_elemental_bow::function_5aec3adc);
    var_7478bee7 = array::filter(var_7478bee7, 0, &function_e02cfeee);
    if(var_7478bee7.size) {
      var_718ba60a = var_28388a90.origin;
      var_a2b66881 = var_718ba60a + (var_c807e383 * var_200ee8c9);
      var_2685316e = distance(var_28388a90.origin, var_28388a90.v_start_pos);
      if(var_2685316e < 256) {
        var_fc3596dd = var_2685316e / 256;
        var_ccc78552 = 64 - (var_67da22f * var_fc3596dd);
      } else {
        var_ccc78552 = 32;
      }
      foreach(ai_enemy in var_7478bee7) {
        v_enemy_origin = ai_enemy getcentroid();
        var_32769d76 = pointonsegmentnearesttopoint(var_718ba60a, var_a2b66881, v_enemy_origin);
        var_4ff095c6 = var_32769d76 - v_enemy_origin;
        if(abs(var_4ff095c6[2]) > 72) {
          continue;
        }
        var_4ff095c6 = (var_4ff095c6[0], var_4ff095c6[1], 0);
        n_length = length(var_4ff095c6);
        if(n_length > var_ccc78552) {
          continue;
        }
        ai_enemy.var_a4557598 = 1;
        if(ai_enemy.archetype === "mechz") {
          if(n_length < 24) {
            level thread function_cd61021a(e_player, ai_enemy, var_28388a90);
          } else {
            ai_enemy.var_a4557598 = 0;
          }
          continue;
        }
        if(zm_utility::is_player_valid(e_player) && (level.round_number < 26 || (level.round_number >= 26 && distancesquared(e_player.origin, ai_enemy.origin) < var_7839cab3))) {
          ai_enemy.var_98056717 = 1;
          var_a5d28b3d = 75 * (n_length / var_ccc78552);
          var_ffc350c5 = vectortoangles(ai_enemy.origin - var_28388a90.origin);
          var_f6fb36f8 = ((var_ffc350c5[1] - var_a90ad319[1]) > 0 ? 1 : -1);
          var_a5d28b3d = var_a5d28b3d * var_f6fb36f8;
          v_launch = vectornormalize(anglesToForward((0, var_a90ad319[1] + var_a5d28b3d, 0)));
          level thread function_3af108ec(e_player, ai_enemy, v_launch);
          continue;
        }
        ai_enemy thread function_720f6454(var_32769d76);
      }
    }
    wait(0.1);
  }
}

function function_e02cfeee(ai_enemy) {
  return !(isDefined(ai_enemy.var_a4557598) && ai_enemy.var_a4557598);
}

function function_3af108ec(e_player, ai_enemy, v_launch) {
  if(ai_enemy.archetype === "zombie") {
    var_f5cc78c2 = 45;
    var_a5211278 = 90;
    ai_enemy startragdoll();
    ai_enemy launchragdoll((90 * v_launch) + (0, 0, randomfloatrange(var_f5cc78c2, var_a5211278)));
    ai_enemy thread function_49dba034();
    wait(0.1);
    ai_enemy clientfield::set("zombie_hit_by_wolf_howl_charge", 1);
  }
  ai_enemy dodamage(ai_enemy.health, ai_enemy.origin, e_player, e_player, undefined, "MOD_UNKNOWN", 0, level.var_30611368);
  ai_enemy.var_a4557598 = 0;
  ai_enemy.var_98056717 = 0;
}

function function_49dba034() {
  self endon("actor_corpse");
  self thread function_7f218268();
  wait(0.7 + randomfloat(0.5));
  self notify("hash_251ee66c");
  self thread do_zombie_explode();
}

function function_7f218268() {
  self endon("hash_251ee66c");
  self waittill("actor_corpse", e_corpse);
  e_corpse thread do_zombie_explode();
}

function do_zombie_explode() {
  self zombie_utility::zombie_eye_glow_stop();
  self clientfield::increment("wolf_howl_zombie_explode_fx");
  self ghost();
  self util::delay(0.25, undefined, &zm_utility::self_delete);
}

function function_720f6454(var_63f884ec) {
  self endon("death");
  if(isDefined(self.isdog) && self.isdog) {
    n_damage = level.zombie_health;
  } else {
    if(self.archetype === "zombie") {
      n_damage = level.zombie_health * 0.5;
    } else {
      n_damage = 0;
    }
  }
  if(n_damage > 0) {
    self thread zm_weap_elemental_bow::function_d1e69389(var_63f884ec);
    self dodamage(n_damage, self.origin, self, self, undefined, "MOD_UNKNOWN", 0, level.var_30611368);
    wait(2.5);
    self.var_a4557598 = 0;
  }
}

function function_cd61021a(e_player, ai_mechz, var_28388a90) {
  wait(0.1);
  if(isDefined(ai_mechz) && isalive(ai_mechz)) {
    var_3bb42832 = level.mechz_health;
    if(isDefined(level.var_f4dc2834)) {
      var_3bb42832 = math::clamp(var_3bb42832, 0, level.var_f4dc2834);
    }
    n_damage = (var_3bb42832 * 0.4) / 0.2;
    ai_mechz dodamage(n_damage, ai_mechz getcentroid(), e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, level.var_30611368);
    var_e1664ef3 = ai_mechz getcentroid() - (anglesToForward(var_28388a90.angles) * 96);
    var_28388a90.origin = var_e1664ef3;
    wait(0.05);
    var_28388a90 notify("mechz_impact");
    ai_mechz.var_a4557598 = 0;
  }
}

function function_6b3aa15a(v_hit_pos, var_8f0f462c) {
  var_3c5572a7 = var_8f0f462c[0];
  var_9259c91b = var_8f0f462c[1];
  var_205259e0 = var_8f0f462c[2];
  var_3c5572a7 clientfield::set("elemental_bow_wolf_howl4" + "_arrow_impact_fx", 1);
  var_3c5572a7 notify("hash_6fd14a64");
  var_ae2cfcc2 = getaiteamarray(level.zombie_team);
  var_7478bee7 = array::get_all_closest(v_hit_pos, var_ae2cfcc2, undefined, undefined, 256);
  var_7478bee7 = array::filter(var_7478bee7, 0, &zm_weap_elemental_bow::function_5aec3adc);
  var_7478bee7 = array::filter(var_7478bee7, 0, &function_e02cfeee);
  foreach(ai_enemy in var_7478bee7) {
    ai_enemy thread function_720f6454(v_hit_pos);
  }
  var_3c5572a7 clientfield::set("wolf_howl_arrow_charged_trail", 0);
  var_9259c91b clientfield::set("wolf_howl_arrow_charged_spiral", 0);
  var_205259e0 clientfield::set("wolf_howl_arrow_charged_spiral", 0);
  function_cc1bf02e(var_8f0f462c, 0);
  var_3c5572a7.in_use = 0;
  util::wait_network_frame();
  var_3c5572a7 clientfield::set("elemental_bow_wolf_howl4" + "_arrow_impact_fx", 0);
}

function function_cc1bf02e(var_8f0f462c, b_show) {
  if(b_show) {
    array::run_all(var_8f0f462c, &show);
  } else {
    array::run_all(var_8f0f462c, &ghost);
  }
}

function function_a6220124(var_8f0f462c) {
  var_28388a90 = var_8f0f462c[0];
  var_9259c91b = var_8f0f462c[1];
  var_205259e0 = var_8f0f462c[2];
  var_28388a90 endon("movedone");
  var_28388a90 endon("mechz_impact");
  var_28388a90 thread function_81703066(var_9259c91b, 1);
  var_28388a90 thread function_81703066(var_205259e0, -1);
  while(true) {
    var_28388a90 rotateroll(360, 0.6);
    wait(0.6);
  }
}

function function_81703066(var_ea1975a2, var_dad28a75) {
  self endon("movedone");
  self endon("mechz_impact");
  while(true) {
    v_up = anglestoup(self.angles);
    v_offset = (v_up * 24) * var_dad28a75;
    var_ea1975a2.origin = self.origin + v_offset;
    wait(0.05);
  }
}

function function_b7d621a1(e_player, var_8f0f462c) {
  var_3c5572a7 = var_8f0f462c[0];
  var_9259c91b = var_8f0f462c[1];
  var_205259e0 = var_8f0f462c[2];
  var_3c5572a7 endon("hash_6fd14a64");
  if(zm_utility::is_player_valid(e_player)) {
    e_player clientfield::set_to_player("wolf_howl_muzzle_flash", 1);
  }
  var_3c5572a7 clientfield::set("wolf_howl_arrow_charged_trail", 1);
  var_9259c91b clientfield::set("wolf_howl_arrow_charged_spiral", 1);
  var_205259e0 clientfield::set("wolf_howl_arrow_charged_spiral", 1);
}

function function_5fded2aa(mod, hit_location, hit_origin, e_player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
  if(isalive(self) && (!(isDefined(self.isdog) && self.isdog)) && issubstr(weapon.name, "elemental_bow_wolf_howl") && mod !== "MOD_MELEE") {
    if(weapon.name != "elemental_bow_wolf_howl4") {
      self notify("hash_8985bb6f");
      self thread function_88bf0c4e(e_player, amount, hit_origin, weapon);
    }
    return true;
  }
  return false;
}

function function_88bf0c4e(e_player, n_damage, v_hit_origin, weapon) {
  self endon("death");
  self endon("hash_8985bb6f");
  self clientfield::set("wolf_howl_slow_snow_fx", 1);
  if(isDefined(level.zombie_vars[e_player.team]["zombie_insta_kill"]) && level.zombie_vars[e_player.team]["zombie_insta_kill"]) {
    if(self.archetype === "mechz") {
      self dodamage(n_damage, v_hit_origin, e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, level.var_e93874ed);
    } else {
      self dodamage(self.health, self.origin, e_player, e_player, undefined, "MOD_UNKNOWN", 0, level.var_e93874ed);
    }
  } else {
    self thread function_f4397d8f();
    if(distance2dsquared(v_hit_origin, self.origin) < 9216) {
      self zm_weap_elemental_bow::function_d1e69389(v_hit_origin);
    }
    n_timer = 0;
    var_55e8a42 = 1;
    if(!isDefined(self.var_ec71e17a)) {
      self.var_ec71e17a = 1;
    }
    while(var_55e8a42 > 0.7) {
      var_55e8a42 = var_55e8a42 - ((var_55e8a42 - 0.7) * 0.2);
      if(var_55e8a42 < 0.71) {
        var_55e8a42 = 0.7;
      }
      self.var_ec71e17a = (var_55e8a42 < self.var_ec71e17a ? var_55e8a42 : self.var_ec71e17a);
      self asmsetanimationrate(self.var_ec71e17a);
      n_timer = n_timer + 0.1;
      wait(0.1);
    }
    self asmsetanimationrate(0.7);
    wait(4);
    n_timer = 0;
    self.var_ec71e17a = 0.73;
    while(self.var_ec71e17a < 1) {
      self.var_ec71e17a = self.var_ec71e17a + ((self.var_ec71e17a - 0.7) * 0.05);
      if(self.var_ec71e17a > 1) {
        self.var_ec71e17a = 1;
      }
      self asmsetanimationrate(self.var_ec71e17a);
      n_timer = n_timer + 0.1;
      wait(0.1);
    }
    self clientfield::set("wolf_howl_slow_snow_fx", 0);
    self.var_ec71e17a = 1;
    self asmsetanimationrate(1);
  }
}

function function_f4397d8f() {
  self waittill("death");
  if(isDefined(self)) {
    self asmsetanimationrate(1);
  }
}