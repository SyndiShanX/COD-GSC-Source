/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_flamethrower.gsc
***********************************************/

#include script_24c32478acf44108;
#include scripts\abilities\ability_player;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_armor;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_flamethrower;

autoexec __init__system__() {
  system::register(#"zm_weap_flamethrower", &__init__, undefined, undefined);
}

__init__() {
  level.hero_weapon[#"flamethrower"][0] = getweapon(#"hero_flamethrower_t8_lv1");
  level.hero_weapon[#"flamethrower"][1] = getweapon(#"hero_flamethrower_t8_lv2");
  level.hero_weapon[#"flamethrower"][2] = getweapon(#"hero_flamethrower_t8_lv3");
  zm_loadout::register_hero_weapon_for_level(#"hero_flamethrower_t8_lv1");
  zm_loadout::register_hero_weapon_for_level(#"hero_flamethrower_t8_lv2");
  zm_loadout::register_hero_weapon_for_level(#"hero_flamethrower_t8_lv3");
  clientfield::register("scriptmover", "flamethrower_tornado_fx", 1, 1, "int");
  clientfield::register("toplayer", "hero_flamethrower_vigor_postfx", 1, 1, "counter");
  clientfield::register("toplayer", "flamethrower_wind_blast_flash", -1, 1, "counter");
  clientfield::register("allplayers", "flamethrower_wind_blast_tu16", 16000, 1, "counter");
  clientfield::register("toplayer", "flamethrower_tornado_blast_flash", 1, 1, "counter");
  callback::on_connect(&function_f5430720);
  zm::function_84d343d(#"hero_flamethrower_t8_lv1", &function_f63feeb6);
  zm::function_84d343d(#"hero_flamethrower_t8_lv2", &function_f63feeb6);
  zm::function_84d343d(#"hero_flamethrower_t8_lv3", &function_f63feeb6);
  namespace_9ff9f642::register_slowdown(#"hash_6ff4731de876ab68", 0.6, 1);
  namespace_9ff9f642::register_slowdown(#"hash_6a420a16118789e1", 0.6, 3);
  namespace_9ff9f642::register_burn(#"hero_flamethrower_t8_lv1", 16, 6);
  namespace_9ff9f642::register_burn(#"hero_flamethrower_t8_lv2", 16, 6);
  namespace_9ff9f642::register_burn(#"hero_flamethrower_t8_lv3", 16, 6);
  level.n_zombies_lifted_for_ragdoll = 0;

  if(!isDefined(level.var_f2f67d17)) {
    level.var_f2f67d17 = new throttle();
    [[level.var_f2f67d17]] - > initialize(5, 0.1);
  }
}

is_flamethrower_weapon(weapon, var_e7c11b0c = 1) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(weapon == level.hero_weapon[#"flamethrower"][2]) {
    return true;
  }

  if(weapon == level.hero_weapon[#"flamethrower"][1] && var_e7c11b0c < 3) {
    return true;
  }

  if(weapon == level.hero_weapon[#"flamethrower"][0] && var_e7c11b0c < 2) {
    return true;
  }

  return false;
}

private function_f5430720() {
  self endon(#"disconnect");
  self thread function_82f451d4();

  while(true) {
    waitresult = self waittill(#"weapon_change");
    wpn_cur = waitresult.weapon;
    wpn_prev = waitresult.last_weapon;

    if(isinarray(level.hero_weapon[#"flamethrower"], wpn_cur)) {
      self clientfield::increment_to_player("hero_flamethrower_vigor_postfx");
      self function_8cbc7c8f(1);
      self thread function_58bc825e(wpn_cur);
      level callback::on_ai_killed(&on_armor_kill);
    } else if(isinarray(level.hero_weapon[#"flamethrower"], wpn_prev)) {
      self function_8cbc7c8f(0);
      self notify(#"hero_flamethrower_expired");
      level callback::remove_on_ai_killed(&on_armor_kill);
    }

    if(wpn_cur == level.hero_weapon[#"flamethrower"][0]) {
      zm_hero_weapon::show_hint(wpn_cur, #"hash_258f60f733c7a181");
      continue;
    }

    if(wpn_cur == level.hero_weapon[#"flamethrower"][1]) {
      zm_hero_weapon::show_hint(wpn_cur, #"hash_4c83bb6fd69bf1ea");
      self thread function_16f31337(wpn_cur);
      self thread function_478a4910(wpn_cur);
      continue;
    }

    if(wpn_cur == level.hero_weapon[#"flamethrower"][2]) {
      if(!self gamepadusedlast()) {
        self zm_hero_weapon::show_hint(wpn_cur, #"hash_1a1e29920a655055");
      } else {
        self zm_hero_weapon::show_hint(wpn_cur, #"hash_43cbc37ab728289b");
      }

      self thread function_16f31337(wpn_cur);
      self thread function_29bbc43a(wpn_cur);
      self thread function_68ff89f7(wpn_cur);
    }
  }
}

private function_82f451d4() {
  self endon(#"disconnect");

  while(true) {
    waitresult = self waittill(#"hero_weapon_give");
    var_cad4df8e = waitresult.weapon;

    if(is_flamethrower_weapon(var_cad4df8e, 2)) {
      self clientfield::increment_to_player("hero_flamethrower_vigor_postfx");
    }
  }
}

on_armor_kill(s_params) {
  if(isplayer(s_params.eattacker) && is_flamethrower_weapon(s_params.weapon, 1) && !(isDefined(self.var_d9e7a08a) && self.var_d9e7a08a) && s_params.smeansofdeath == "MOD_BURNED") {
    e_player = s_params.eattacker;
    var_d695a618 = 50 - e_player zm_armor::get(#"hero_weapon_armor");

    if(var_d695a618 >= 5) {
      var_20694322 = 5;
    } else {
      var_20694322 = var_d695a618;
    }

    e_player thread zm_armor::add(#"hero_weapon_armor", var_20694322, 50);
  }
}

function_f63feeb6(einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isplayer(einflictor) && !(isDefined(self.var_95468c43) && self.var_95468c43) && meansofdeath === "MOD_BURNED") {
    self thread function_d8ee4d6a(eattacker);
  }

  if(meansofdeath === "MOD_BURNED" && self.health <= idamage && self.zm_ai_category == #"basic") {
    self.var_b364c165 = 1;
  }

  if(isplayer(einflictor) && meansofdeath === "MOD_BURNED" && !(isDefined(self.is_on_fire) && self.is_on_fire)) {
    var_bb6709b6 = zm_equipment::function_379f6b5d(16);
    self namespace_9ff9f642::burn(weapon.name, eattacker, weapon, var_bb6709b6);
  }

  if(isplayer(einflictor) && !(isDefined(self.var_d9e7a08a) && self.var_d9e7a08a) && meansofdeath === "MOD_BURNED") {
    if(self.zm_ai_category == #"basic" || self.zm_ai_category == #"popcorn" || self.zm_ai_category == #"enhanced") {
      return self.health;
    }
  }

  return idamage;
}

private function_d8ee4d6a(eattacker) {
  self endon(#"death");
  self.var_95468c43 = 1;

  if(self.zm_ai_category == #"miniboss" || self.zm_ai_category == #"popcorn") {
    self thread namespace_9ff9f642::slowdown(#"hash_6ff4731de876ab68");
    wait 1;
  } else if(self.zm_ai_category == #"boss") {
    wait 1;
  } else if(self.zm_ai_category == #"basic" || self.zm_ai_category == #"enhanced") {
    if(self zombie_utility::function_33da7a07() !== "walk") {
      self thread function_c95fe16();
    }

    while(isDefined(self.is_on_fire) && self.is_on_fire) {
      self thread namespace_9ff9f642::slowdown(#"hash_6a420a16118789e1");
      wait 3;
    }
  }

  self.var_95468c43 = undefined;
}

private function_c95fe16() {
  self endon(#"death");
  self zombie_utility::set_zombie_run_cycle_override_value("walk");

  while(isDefined(self.is_on_fire) && self.is_on_fire) {
    wait 0.1;
  }

  self zombie_utility::set_zombie_run_cycle_restore_from_override();
}

private function_d8e7e308(v_position) {
  self endon(#"death");

  if(self.zm_ai_category !== #"basic" || self.zm_ai_category !== #"enhanced" || isDefined(self.knockdown) && self.knockdown) {
    return;
  }

  [[level.var_f2f67d17]] - > waitinqueue(self);

  if(isDefined(self.knockdown) && self.knockdown) {
    return;
  }

  self zombie_utility::setup_zombie_knockdown(v_position);
}

function_58bc825e(w_flamethrower) {
  self endon(#"bled_out", #"death", #"hero_flamethrower_expired");

  while(true) {
    s_result = self waittill(#"weapon_fired");

    if(s_result.weapon == w_flamethrower) {
      self thread function_aa93af91(w_flamethrower);
    }
  }
}

private function_aa93af91(w_flamethrower) {
  a_e_targets = zm_hero_weapon::function_7c3681f7();
  var_560ef51 = [];
  v_start_pos = self getEye();
  v_forward_angles = self getweaponforwarddir();
  a_ai_zombies = util::get_array_of_closest(self.origin, a_e_targets, undefined, undefined, 64);

  foreach(ai_zombie in a_ai_zombies) {
    if(isDefined(ai_zombie sightconetrace(v_start_pos, self, v_forward_angles, 29)) && ai_zombie sightconetrace(v_start_pos, self, v_forward_angles, 29)) {
      if(!isDefined(var_560ef51)) {
        var_560ef51 = [];
      } else if(!isarray(var_560ef51)) {
        var_560ef51 = array(var_560ef51);
      }

      if(!isinarray(var_560ef51, ai_zombie)) {
        var_560ef51[var_560ef51.size] = ai_zombie;
      }
    }
  }

  array::thread_all(var_560ef51, &function_e296efef, w_flamethrower, self);
  array::thread_all(var_560ef51, &function_d8e7e308, self.origin);
}

private function_e296efef(w_flamethrower, e_player) {
  self endon(#"death");
  [[level.var_f2f67d17]] - > waitinqueue(self);

  if(!(isDefined(self.is_on_fire) && self.is_on_fire)) {
    var_bb6709b6 = zm_equipment::function_379f6b5d(16);
    self namespace_9ff9f642::burn(w_flamethrower.name, e_player, w_flamethrower, var_bb6709b6);
  }
}

function_31a142a2(w_flamethrower) {
  switch (w_flamethrower.name) {
    case #"hero_flamethrower_t8_lv2":
      var_c4d00e65 = 0.75;
      break;
    case #"hero_flamethrower_t8_lv3":
      var_c4d00e65 = 1;
      break;
    default:
      var_c4d00e65 = 0.5;
      break;
  }

  if(!isDefined(self.maxhealth)) {
    self.maxhealth = self.health;
  }

  n_percent_health = var_c4d00e65 * self.maxhealth;
  return max(n_percent_health, w_flamethrower.maxdamage);
}

function_16f31337(w_flamethrower) {
  self endon(#"bled_out", #"death", #"hero_flamethrower_expired");

  while(true) {
    s_result = self waittill(#"weapon_melee_power_left");

    if(s_result.weapon == w_flamethrower) {
      self clientfield::increment("flamethrower_wind_blast_tu16");
      self thread function_99207e4d(w_flamethrower);
    }
  }
}

function_99207e4d(w_flamethrower) {
  var_a092956c = [];
  var_560ef51 = [];
  var_2ed6f142 = self getweaponmuzzlepoint();
  v_forward_angles = self getweaponforwarddir();
  self playrumbleonentity("grenade_rumble");
  a_ai_zombies = util::get_array_of_closest(var_2ed6f142, getaispeciesarray(level.zombie_team), undefined, undefined, 614);

  foreach(ai_zombie in a_ai_zombies) {
    if(!isDefined(ai_zombie.zm_ai_category)) {

      if(isDefined(ai_zombie.targetname)) {
        iprintlnbold("<dev string:x38>" + ai_zombie.targetname);
      }

        continue;
    }

    if(distance(ai_zombie.origin, self.origin) <= 161) {
      if(!isDefined(var_a092956c)) {
        var_a092956c = [];
      } else if(!isarray(var_a092956c)) {
        var_a092956c = array(var_a092956c);
      }

      if(!isinarray(var_a092956c, ai_zombie)) {
        var_a092956c[var_a092956c.size] = ai_zombie;
      }

      self.var_1374cdc6 = 1;
    }

    if(isDefined(ai_zombie sightconetrace(var_2ed6f142, self, v_forward_angles, 29)) && ai_zombie sightconetrace(var_2ed6f142, self, v_forward_angles, 29)) {
      if(distance(ai_zombie.origin, self.origin) <= 296) {
        if(!isDefined(var_a092956c)) {
          var_a092956c = [];
        } else if(!isarray(var_a092956c)) {
          var_a092956c = array(var_a092956c);
        }

        if(!isinarray(var_a092956c, ai_zombie)) {
          var_a092956c[var_a092956c.size] = ai_zombie;
        }

        self.var_1374cdc6 = 1;
        continue;
      }

      if(!isDefined(var_560ef51)) {
        var_560ef51 = [];
      } else if(!isarray(var_560ef51)) {
        var_560ef51 = array(var_560ef51);
      }

      if(!isinarray(var_560ef51, ai_zombie)) {
        var_560ef51[var_560ef51.size] = ai_zombie;
      }
    }
  }

  array::thread_all(var_a092956c, &function_ea906434, self, w_flamethrower);
  array::thread_all(var_560ef51, &function_d8e7e308, self.origin);
}

function_ea906434(e_player, w_flamethrower) {
  self endon(#"death");
  assert(isDefined(self.zm_ai_category), "<dev string:x76>");

  if(!isDefined(self.zm_ai_category)) {
    return;
  }

  if(self.zm_ai_category == #"miniboss" || self.zm_ai_category == #"boss") {
    self thread function_d8ee4d6a(e_player);
    [[level.var_f2f67d17]] - > waitinqueue(self);
    self dodamage(self.maxhealth * 0.18, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, w_flamethrower);
  }

  if(self.zm_ai_category == #"heavy") {
    self thread function_d8ee4d6a(e_player);
    [[level.var_f2f67d17]] - > waitinqueue(self);
    self dodamage(self.maxhealth * 0.2, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, w_flamethrower);
    return;
  }

  if(self.zm_ai_category == #"basic" || self.zm_ai_category == #"enhanced") {
    [[level.var_f2f67d17]] - > waitinqueue(self);
    n_dist = distance2d(self.origin, e_player.origin);

    if(n_dist <= 64) {
      if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
        self.no_gib = 1;
      }

      if(!(isDefined(self.no_gib) && self.no_gib)) {
        gibserverutils::annihilate(self);
        self playSound(#"zmb_zombie_head_gib");
      }

      self dodamage(self.health + 100, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, w_flamethrower);
      return;
    } else if(math::cointoss()) {
      if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
        self.no_gib = 1;
      }

      if(!(isDefined(self.no_gib) && self.no_gib)) {
        self playSound(#"zmb_zombie_head_gib");
        self zombie_utility::gib_random_parts();
      }
    }

    if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
      self dodamage(self.health + 100, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, w_flamethrower);
      return;
    }

    v_dir = self.origin - e_player.origin;
    var_eb0d0f20 = 75 * vectornormalize(v_dir);
    var_eb0d0f20 = (var_eb0d0f20[0], var_eb0d0f20[1], 20);
    self startragdoll();
    self launchragdoll(var_eb0d0f20);
    self dodamage(self.health + 100, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, w_flamethrower);
    return;
  }

  if(self.zm_ai_category == #"popcorn") {
    [[level.var_f2f67d17]] - > waitinqueue(self);
    self dodamage(self.health + 100, e_player.origin, e_player, e_player, undefined, "MOD_IMPACT", 0, w_flamethrower);
  }
}

function_29bbc43a(w_flamethrower) {
  self endon(#"bled_out", #"death", #"hero_flamethrower_expired");

  while(true) {
    s_result = self waittill(#"weapon_melee");

    if(s_result.weapon == w_flamethrower) {
      self clientfield::increment_to_player("flamethrower_tornado_blast_flash");
      self function_3be93b07(w_flamethrower);
    }
  }
}

function_3be93b07(w_flamethrower) {
  self notify(#"hash_2ca901b5ada4f20f");
  self endon(#"bled_out", #"death", #"hero_flamethrower_expired", #"hash_2ca901b5ada4f20f");
  var_a85d39a2 = [];
  var_2ed6f142 = self getweaponmuzzlepoint();
  v_forward_angles = self getweaponforwarddir();
  var_a812a69b = var_2ed6f142 + v_forward_angles * 40;
  var_a812a69b = getclosestpointonnavmesh(var_a812a69b, 128, 16);

  if(!isDefined(var_a812a69b)) {
    var_a812a69b = var_2ed6f142;
  }

  s_trace = groundtrace(var_a812a69b + (0, 0, 100), var_a812a69b + (0, 0, -1000), 0, undefined, 0);

  if(!isDefined(self.var_be72e7c2)) {
    self.var_be72e7c2 = util::spawn_model("tag_origin");
    util::wait_network_frame();
  }

  self.var_be72e7c2.origin = s_trace[#"position"];
  self.var_be72e7c2.angles = self.angles;
  self.var_be72e7c2.v_start = self.var_be72e7c2.origin;

  if(!isDefined(self.var_be72e7c2.t_damage)) {
    self.var_be72e7c2.t_damage = spawn("trigger_radius_new", self.var_be72e7c2.origin, 512 | 1, 80, 128);
    self.var_be72e7c2.t_damage enablelinkto();
    self.var_be72e7c2.t_damage linkto(self.var_be72e7c2);
  }

  self thread function_10c91a46();

  if(self.var_be72e7c2 clientfield::get("flamethrower_tornado_fx")) {
    self.var_be72e7c2 clientfield::set("flamethrower_tornado_fx", 0);
    util::wait_network_frame();
  }

  self.var_be72e7c2 clientfield::set("flamethrower_tornado_fx", 1);
  a_ai_zombies = util::get_array_of_closest(var_a812a69b, getaispeciesarray(level.zombie_team), undefined, undefined, 400);

  foreach(ai_zombie in a_ai_zombies) {
    if(isDefined(ai_zombie sightconetrace(var_2ed6f142, self, v_forward_angles, 29)) && ai_zombie sightconetrace(var_2ed6f142, self, v_forward_angles, 29)) {
      if(!isDefined(var_a85d39a2)) {
        var_a85d39a2 = [];
      } else if(!isarray(var_a85d39a2)) {
        var_a85d39a2 = array(var_a85d39a2);
      }

      if(!isinarray(var_a85d39a2, ai_zombie)) {
        var_a85d39a2[var_a85d39a2.size] = ai_zombie;
      }
    }
  }

  self.var_be72e7c2 thread function_6c891578(v_forward_angles, var_a85d39a2);
  self thread function_95195ac0();
}

function_95195ac0() {
  self endon(#"hash_2ca901b5ada4f20f");

  if(!isDefined(self.var_be72e7c2)) {
    return;
  }

  var_be72e7c2 = self.var_be72e7c2;
  var_be72e7c2 endon(#"death");
  self waittill(#"death", #"hero_flamethrower_expired");

  if(isDefined(self)) {
    self notify(#"hash_751e0293eed9a1cf");
  }

  var_be72e7c2 clientfield::set("flamethrower_tornado_fx", 0);
  var_be72e7c2 notify(#"hash_751e0293eed9a1cf");
  waitframe(1);

  if(isDefined(var_be72e7c2.t_damage)) {
    if(isDefined(var_be72e7c2.t_damage)) {
      var_be72e7c2.t_damage delete();
    }

    var_be72e7c2 delete();
  }
}

function_6c891578(v_forward_angles, var_a85d39a2) {
  self endon(#"death", #"hash_2ca901b5ada4f20f");
  var_2ddb51af = self.v_start + (0, 0, 16);
  var_d825e9dd = 1;
  v_start_pos = self.v_start + (0, 0, 16);

  while(true) {
    if(isDefined(var_d825e9dd) && var_d825e9dd) {
      var_d825e9dd = undefined;
      var_94a175c3 = 200;

      if(var_a85d39a2.size) {
        ai_zombie = array::random(var_a85d39a2);
        v_target_pos = ai_zombie.origin;
        arrayremovevalue(var_a85d39a2, ai_zombie);
      } else if(isDefined(bullettracepassed(var_2ddb51af, var_2ddb51af + v_forward_angles * var_94a175c3, 0, self)) && bullettracepassed(var_2ddb51af, var_2ddb51af + v_forward_angles * var_94a175c3, 0, self)) {
        v_target_pos = var_2ddb51af + v_forward_angles * var_94a175c3;
      } else {
        v_target_pos = bulletTrace(var_2ddb51af, var_2ddb51af + v_forward_angles * var_94a175c3, 0, self)[#"position"];
      }
    } else if(var_a85d39a2.size) {
      ai_zombie = array::random(var_a85d39a2);
      v_target_pos = ai_zombie.origin;
      arrayremovevalue(var_a85d39a2, ai_zombie);
    } else {
      v_target_pos = self function_5adaf171(var_2ddb51af);
    }

    var_6fba13f1 = getclosestpointonnavmesh(v_target_pos, 512, 16);

    if(isDefined(var_6fba13f1)) {
      v_target_pos = var_6fba13f1;
    }

    var_6fba13f1 = groundtrace(v_target_pos + (0, 0, 100), v_target_pos + (0, 0, -1000), 0, undefined, 0)[#"position"];

    if(isDefined(var_6fba13f1)) {
      v_target_pos = var_6fba13f1;
    }

    n_dist = distance(v_start_pos, v_target_pos);
    n_time = n_dist / 100;

    if(n_time <= 0) {
      n_time = 0.5;
    }

    self moveto(v_target_pos, n_time);

    if(isDefined(ai_zombie)) {
      level util::waittill_any_ents(self, "movedone", ai_zombie, "death");
      ai_zombie = undefined;
    } else {
      self waittill(#"movedone");
    }

    v_start_pos = self.origin + (0, 0, 16);

    if(var_a85d39a2.size) {
      foreach(ai in var_a85d39a2) {
        if(isvehicle(ai) && !(isDefined(bullettracepassed(v_start_pos, ai.origin, 0, self)) && bullettracepassed(v_start_pos, ai.origin, 0, self))) {
          arrayremovevalue(var_a85d39a2, ai, 1);
          continue;
        }

        if(issentient(ai) && isalive(ai) && !(isDefined(bullettracepassed(v_start_pos, ai getEye(), 0, self)) && bullettracepassed(v_start_pos, ai getEye(), 0, self))) {
          arrayremovevalue(var_a85d39a2, ai, 1);
        }
      }

      var_a85d39a2 = array::remove_undefined(var_a85d39a2);
    }

    if(!var_a85d39a2.size) {
      var_a85d39a2 = util::get_array_of_closest(self.v_start, getaiteamarray(level.zombie_team), undefined, undefined, 400);

      foreach(ai in var_a85d39a2) {
        if(isvehicle(ai) && !(isDefined(bullettracepassed(v_start_pos, ai.origin, 0, self)) && bullettracepassed(v_start_pos, ai.origin, 0, self))) {
          arrayremovevalue(var_a85d39a2, ai, 1);
          continue;
        }

        if(!(isDefined(bullettracepassed(v_start_pos, ai getEye(), 0, self)) && bullettracepassed(v_start_pos, ai getEye(), 0, self))) {
          arrayremovevalue(var_a85d39a2, ai, 1);
        }
      }

      var_a85d39a2 = array::remove_undefined(var_a85d39a2);
    }
  }
}

function_5adaf171(var_2ddb51af) {
  self endon(#"death");

  for(var_dc9e1b43 = 0; var_dc9e1b43 < 4; var_dc9e1b43++) {
    v_target_pos = (var_2ddb51af[0] + randomfloat(400), var_2ddb51af[1] + randomfloat(400), var_2ddb51af[2]);
    s_trace = bulletTrace(self.origin + (0, 0, 16), v_target_pos, 0, self);

    if(isDefined(s_trace[#"position"])) {
      if(sighttracepassed(s_trace[#"position"], v_target_pos, 0, self)) {
        return s_trace[#"position"];
      }

      continue;
    }

    if(bullettracepassed(self.origin + (0, 0, 16), v_target_pos, 0, self) && sighttracepassed(self.origin + (0, 0, 16), v_target_pos, 0, self)) {
      return v_target_pos;
    }
  }

  return var_2ddb51af;
}

function_10c91a46() {
  self endon(#"disconnect", #"hash_2ca901b5ada4f20f");
  self.var_be72e7c2 endon(#"death");
  self.var_be72e7c2.t_damage endon(#"death");

  while(true) {
    s_result = self.var_be72e7c2.t_damage waittill(#"trigger");

    if(isDefined(s_result.activator.var_d9e7a08a) && s_result.activator.var_d9e7a08a) {
      continue;
    }

    if(isinarray(getaiteamarray(level.zombie_team), s_result.activator)) {
      s_result.activator thread function_72601dd2(self, self.var_be72e7c2, 128, randomintrange(128, 200), randomintrange(150, 200));
    }

    waitframe(1);
  }
}

function_103fae4e(t_damage) {
  self endon(#"disconnect");
  self.var_d9e7a08a = 1;
  self clientfield::set("burn", 1);

  while(isDefined(t_damage) && self istouching(t_damage)) {
    waitframe(1);
  }

  self clientfield::set("burn", 0);
  self.var_d9e7a08a = undefined;
}

private function_72601dd2(e_player, var_ab287846, n_push_away, n_lift_height, n_lift_speed) {
  w_flamethrower = e_player.var_fd05e363;
  self.var_d9e7a08a = 1;
  v_origin = var_ab287846.origin;

  if(self.zm_ai_category == #"popcorn") {
    self.no_powerups = 1;
    self dodamage(self.health + 100, v_origin, e_player, e_player, undefined, "MOD_BURNED", 0, w_flamethrower);
    return;
  }

  if(self.zm_ai_category == #"miniboss" || self.zm_ai_category == #"boss" || self.zm_ai_category == #"heavy") {
    self endon(#"death");
    [[level.var_f2f67d17]] - > waitinqueue(self);

    if(var_ab287846 function_58942bba(self) && self.zm_ai_category == #"miniboss") {
      var_ab287846 thread scene::init(#"p8_zm_flame_tornado_miniboss_scene", self);
      self dodamage(self.maxhealth * 0.18, v_origin, e_player, e_player, "none", "MOD_BURNED", 0, w_flamethrower);
      self.var_42d5176d = 1;
      self val::set(#"trap_ignore", "ignoreall", 1);
      v_pos = groundtrace(self.origin + (0, 0, 100), self.origin + (0, 0, -1000), 0, self)[#"position"];

      if(!isDefined(v_pos)) {
        v_pos = self.origin;
      }

      self.var_68f4c9de = util::spawn_model("tag_origin", v_pos, self.angles);
      self.var_68f4c9de thread scene::init(#"p8_zm_flame_tornado_miniboss_scene", self);
      self thread function_e6f0a2c7(var_ab287846);
      var_ab287846 waittill(#"death", #"hash_751e0293eed9a1cf", #"hash_124840b260697eb9");

      if(isDefined(self) && isDefined(self.var_68f4c9de)) {
        self.var_68f4c9de scene::play(#"p8_zm_flame_tornado_miniboss_scene", self);
      }

      if(isDefined(self) && isDefined(self.var_68f4c9de)) {
        self.var_42d5176d = undefined;
        self val::reset(#"trap_ignore", "ignoreall");
        self.var_d9e7a08a = undefined;
        self.var_68f4c9de delete();
      }
    } else if(self.zm_ai_category == #"heavy") {
      self zombie_utility::setup_zombie_knockdown(e_player);
      self dodamage(self.maxhealth * 0.2, v_origin, e_player, e_player, "none", "MOD_BURNED", 0, w_flamethrower);
      wait 1;
      self.var_d9e7a08a = undefined;
    } else {
      self thread function_d8ee4d6a(e_player);
      self dodamage(self.maxhealth * 0.16, v_origin, e_player, e_player, "none", "MOD_BURNED", 0, w_flamethrower);
      wait 1;
      self.var_d9e7a08a = undefined;
    }

    return;
  }

  self endon(#"death");
  [[level.var_f2f67d17]] - > waitinqueue(self);

  if(level.n_zombies_lifted_for_ragdoll < 9) {
    self thread track_lifted_for_ragdoll_count();
    self setplayercollision(0);
    self zm_spawner::zombie_flame_damage("MOD_BURNED", e_player);

    if(isDefined(var_ab287846) && var_ab287846 function_58942bba(self)) {
      var_ab287846 thread scene::play(#"aib_vign_zm_mnsn_tornado_zombie", self);
      var_ab287846 thread function_943cd1e3(e_player, self);
      var_c74251a4 = scene::function_8582657c(#"aib_vign_zm_mnsn_tornado_zombie", "Shot 1");
      n_time = randomfloatrange(2, var_c74251a4);
      e_player waittilltimeout(n_time, #"hash_20d02a4b6d08596d", #"hash_2ca901b5ada4f20f", #"hash_751e0293eed9a1cf");

      if(!isDefined(self)) {
        return;
      }

      self thread scene::stop(#"aib_vign_zm_mnsn_tornado_zombie");
    }

    if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
      self dodamage(self.health + 100, v_origin, e_player, e_player, "torso_lower", "MOD_BURNED", 0, w_flamethrower);
      return;
    }

    self playSound(#"zmb_zombie_head_gib");
    self zombie_utility::gib_random_parts();
    v_away_from_source = vectornormalize(self.origin - v_origin);
    v_away_from_source *= n_push_away;
    v_away_from_source = (v_away_from_source[0], v_away_from_source[1], n_lift_height);

    if(!(isDefined(level.ignore_gravityspikes_ragdoll) && level.ignore_gravityspikes_ragdoll)) {
      self startragdoll();
      self launchragdoll(100 * anglestoup(self.angles) + (v_away_from_source[0], v_away_from_source[1], 0));
    }

    self clientfield::set("ragdoll_impact_watch", 1);
  } else {
    if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
      self.no_gib = 1;
    }

    if(!(isDefined(self.no_gib) && self.no_gib)) {
      gibserverutils::annihilate(self);
      self playSound(#"zmb_zombie_head_gib");
    }
  }

  self dodamage(self.health + 100, v_origin, e_player, e_player, "torso_lower", "MOD_BURNED", 0, w_flamethrower);
}

private function_e6f0a2c7(var_ab287846) {
  if(!isDefined(var_ab287846) || !isDefined(var_ab287846.t_damage)) {
    return;
  }

  var_ab287846 endon(#"death", #"hash_751e0293eed9a1cf");
  var_ab287846.t_damage endon(#"death");

  while(isDefined(self) && self istouching(var_ab287846.t_damage)) {
    waitframe(1);
  }

  var_ab287846 notify(#"hash_124840b260697eb9");
}

private track_lifted_for_ragdoll_count() {
  level.n_zombies_lifted_for_ragdoll++;
  self waittill(#"death");
  level.n_zombies_lifted_for_ragdoll--;
}

private function_943cd1e3(e_player, ai_zombie) {
  while(isDefined(self) && isalive(ai_zombie)) {
    if(!self function_58942bba(ai_zombie)) {
      e_player notify(#"hash_20d02a4b6d08596d");
      return;
    }

    wait 0.5;
  }
}

private function_58942bba(e_ignore) {
  if(!isDefined(self)) {
    return false;
  }

  v_start_pos = self.origin + (0, 0, 16);

  if(!bullettracepassed(self.origin + (0, 0, 5), self.origin + (0, 0, 128), 0, e_ignore)) {
    return false;
  }

  if(!bullettracepassed(v_start_pos, v_start_pos + anglesToForward(self.angles) * 50, 0, e_ignore)) {
    return false;
  }

  if(!bullettracepassed(v_start_pos, v_start_pos + anglesToForward(self.angles) * 50 * -1, 0, e_ignore)) {
    return false;
  }

  if(!bullettracepassed(v_start_pos, v_start_pos + anglestoright(self.angles) * 50, 0, e_ignore)) {
    return false;
  }

  if(!bullettracepassed(v_start_pos, v_start_pos + anglestoright(self.angles) * 50 * -1, 0, e_ignore)) {
    return false;
  }

  return true;
}

function_8cbc7c8f(var_2fb75486) {
  self.var_2fb75486 = var_2fb75486;
}

function_478a4910(w_flamethrower) {
  self endon(#"bled_out", #"death", #"hero_flamethrower_expired");
  s_result = self waittill(#"weapon_melee_power_left");

  if(s_result.weapon == w_flamethrower) {
    self thread zm_audio::create_and_play_dialog(#"hero_level_2", #"flamethrower");
  }
}

function_68ff89f7(w_flamethrower) {
  self endon(#"bled_out", #"death", #"hero_flamethrower_expired");
  s_result = self waittill(#"weapon_melee");

  if(s_result.weapon == w_flamethrower) {
    self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"flamethrower");
  }
}