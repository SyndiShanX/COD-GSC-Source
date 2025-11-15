/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_blundergat.gsc
***********************************************/

#include script_24c32478acf44108;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\weaponobjects;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_lockdown_util;
#include scripts\zm_common\zm_net;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_blundergat;

autoexec __init__system__() {
  system::register(#"zm_weap_blundergat", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("missile", "blundergat_dart_blink", 1, 1, "int");
  clientfield::register("scriptmover", "blundergat_dart_blink", 1, 1, "int");
  clientfield::register("scriptmover", "magma_gat_blob_fx", 1, 2, "int");
  clientfield::register("actor", "zombie_magma_fire_explosion", 1, 1, "int");
  n_bits = getminbitcountfornum(6);
  clientfield::register("actor", "positional_zombie_fire_fx", 1, n_bits, "int");
  zm::register_zombie_damage_override_callback(&function_efefda46);
  callback::on_connect(&function_eaa9c593);
  level flag::init(#"hash_72c4671390c83158");
  level flag::init(#"hash_634424410f574c1c");
  weaponobjects::function_e6400478(#"ww_blundergat_fire_t8_unfinished", &function_38eaed4c, 0);
  weaponobjects::function_e6400478(#"ww_blundergat_fire_t8", &function_38eaed4c, 0);
  weaponobjects::function_e6400478(#"ww_blundergat_fire_t8_upgraded", &function_38eaed4c, 0);
  namespace_9ff9f642::register_slowdown(#"hash_716657b9842cfd1b", 0.6, 1);

  if(!isDefined(level.var_214f6204)) {
    level.var_214f6204 = new throttle();
    [[level.var_214f6204]] - > initialize(2, 0.1);
  }

  level.var_ee565b3f = &function_89bde454;
  level.var_bb2323e4 = &function_bd27d397;
}

__main__() {
  level.var_5fcf49dc = [];
  level.var_56f299e3 = [];
  level thread function_f2ef907f();
}

function_40e83b36(n_spread) {
  n_x = randomintrange(n_spread * -1, n_spread);
  n_y = randomintrange(n_spread * -1, n_spread);
  n_z = randomintrange(n_spread * -1, n_spread);
  return (n_x, n_y, n_z);
}

function_845f2546() {
  self endon(#"death");
  self.titusmarked = 1;
  wait 1;
  self.titusmarked = undefined;
}

function_9ef27f88(n_fuse_timer, attacker, weapon) {
  self endon(#"death", #"titus_target_timeout");
  self thread titus_target_timeout(n_fuse_timer);

  if(self.zm_ai_category == #"miniboss" || self.zm_ai_category == #"boss") {
    wait n_fuse_timer;
    self.var_c541eedd = undefined;
    return;
  }

  self thread function_8882e03(attacker);
  self ai::stun(n_fuse_timer);
  wait n_fuse_timer;
  self notify(#"hash_1c822785c3e778b5", {
    #attacker: attacker
  });
  self dodamage(self.health + 1000, self.origin, attacker, attacker, "none", "MOD_GRENADE", 0, weapon);
}

function_2b03f05f() {
  self endon(#"death", #"titus_target_timeout");

  while(true) {
    s_result = self waittill(#"damage");

    if(s_result.weapon === getweapon(#"hash_3de0926b89369160") || s_result.weapon === getweapon(#"hash_127bb24f68b5df27")) {
      a_grenades = getEntArray("grenade", "classname");

      foreach(e_grenade in a_grenades) {
        if(isDefined(e_grenade.model) && e_grenade.model == #"wpn_t8_zm_blundergat_acid_projectile") {
          if(e_grenade islinkedto(self)) {
            e_grenade thread function_971df325(self);
          }
        }
      }
    }
  }
}

titus_target_timeout(n_fuse_timer) {
  self endon(#"death");
  wait n_fuse_timer;
  self notify(#"titus_target_timeout");
}

function_8882e03(attacker) {
  self waittill(#"death");
  self notify(#"hash_1c822785c3e778b5", {
    #attacker: attacker
  });
}

function_971df325(target) {
  self endon(#"death");
  target endon(#"titus_target_timeout");
  target waittill(#"hash_1c822785c3e778b5", #"death");

  if(self clientfield::get("blundergat_dart_blink")) {
    self clientfield::set("blundergat_dart_blink", 0);
  }

  self.var_66570d1b = 1;
  self resetmissiledetonationtime(0.05);
}

function_efefda46(willbekilled, einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  var_7bf9705c = getweapon(#"hash_3de0926b89369160");
  var_6d65656c = getweapon(#"hash_494f5501b3f8e1e9");

  if(weapon === var_7bf9705c) {
    if(!(isDefined(self.var_c541eedd) && self.var_c541eedd)) {
      a_grenades = getEntArray("grenade", "classname");
      self.var_c541eedd = 1;

      foreach(e_grenade in a_grenades) {
        if(isDefined(e_grenade) && isDefined(e_grenade.model) && e_grenade.model == #"wpn_t8_zm_blundergat_acid_projectile") {
          if(e_grenade islinkedto(self)) {
            while(isDefined(e_grenade)) {
              if(!isDefined(e_grenade.n_fuse_time)) {
                waitframe(1);
                continue;
              }

              break;
            }

            if(isDefined(e_grenade)) {
              n_fuse_timer = e_grenade.n_fuse_time;
              e_grenade thread function_971df325(self);
            }
          }
        }
      }

      if(!isDefined(n_fuse_timer)) {
        n_fuse_timer = randomfloatrange(1, 1.5);
      }

      self thread function_9ef27f88(n_fuse_timer, eattacker, weapon);
      self thread function_2b03f05f();
    }

    return idamage;
  } else if(weapon === var_6d65656c) {
    if(self.zm_ai_category == #"miniboss" || self.zm_ai_category == #"boss") {
      return (idamage * 0.1);
    }

    return idamage;
  }

  w_blundergat_fire = getweapon(#"ww_blundergat_fire_t8");
  w_blundergat_fire_upgraded = getweapon(#"ww_blundergat_fire_t8_upgraded");
  var_e97d8c2c = getweapon(#"ww_blundergat_fire_t8_unfinished");

  if(weapon == w_blundergat_fire || weapon == w_blundergat_fire_upgraded || weapon == var_e97d8c2c) {
    if(self.zm_ai_category == #"basic" || self.zm_ai_category == #"popcorn" || self.zm_ai_category == #"enhanced") {
      if(meansofdeath == "MOD_IMPACT") {
        self thread function_dc3470c5(shitloc, vpoint, eattacker, weapon);
        return 0;
      } else if(isDefined(self.var_4bfa8f6c) || isDefined(self.var_becfae27) && self.var_becfae27) {
        if(isDefined(willbekilled) && willbekilled) {
          self thread function_209c8c45(eattacker, weapon);

          if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
            self.no_gib = 1;
          }

          if(!(isDefined(self.no_gib) && self.no_gib)) {
            gibserverutils::annihilate(self);
          }

          self clientfield::set("zombie_magma_fire_explosion", 1);
        }
      }
    } else if(self.zm_ai_category == #"miniboss" || self.zm_ai_category == #"boss") {
      if(meansofdeath == "MOD_IMPACT") {
        self thread function_dc3470c5(shitloc, vpoint, eattacker, weapon);
        return 0;
      }
    }

    return idamage;
  }

  w_blundergat = getweapon(#"ww_blundergat_t8");
  w_blundergat_upgraded = getweapon(#"ww_blundergat_t8_upgraded");

  if(weapon == w_blundergat || weapon == w_blundergat_upgraded) {
    if((self.zm_ai_category == #"basic" || self.zm_ai_category == #"enhanced") && self.archetype !== #"ghost") {
      if(isDefined(level.no_gib_in_wolf_area) && [
          [level.no_gib_in_wolf_area]
        ]()) {
        return idamage;
      }

      self zombie_utility::derive_damage_refs(vpoint);
    }

    return idamage;
  }

  return idamage;
}

private function_eaa9c593() {
  self endon(#"disconnect");

  while(true) {
    waitresult = self waittill(#"weapon_change");
    wpn_cur = waitresult.weapon;
    wpn_prev = waitresult.last_weapon;

    if(wpn_cur == getweapon(#"ww_blundergat_acid_t8") || wpn_cur == getweapon(#"ww_blundergat_acid_t8_upgraded")) {
      self thread function_d72c4a61();
      continue;
    }

    if(wpn_prev == getweapon(#"ww_blundergat_acid_t8") || wpn_prev == getweapon(#"ww_blundergat_acid_t8_upgraded")) {
      self notify(#"hash_20e403096a8af3b7");
    }
  }
}

private function_d72c4a61() {
  self notify(#"hash_20e403096a8af3b7");
  self endon(#"disconnect", #"hash_20e403096a8af3b7");

  while(true) {
    s_result = self waittill(#"weapon_fired");

    if(s_result.weapon == getweapon(#"ww_blundergat_acid_t8") || s_result.weapon == getweapon(#"ww_blundergat_acid_t8_upgraded")) {
      util::wait_network_frame();
      function_d82e684c(1);
      util::wait_network_frame();
      function_d82e684c(1);
      util::wait_network_frame();
      function_d82e684c(1);
    }

    wait 0.5;
  }
}

function_d82e684c(is_not_upgraded = 1) {
  var_d571151f = self getplayerangles();
  var_d0407533 = self getplayercamerapos();
  a_ai_targets = getaiteamarray(level.zombie_team);
  a_vh_targets = getvehicleteamarray(level.zombie_team);
  a_targets = arraycombine(a_ai_targets, a_vh_targets, 0, 0);
  a_targets = util::get_array_of_closest(self.origin, a_targets, undefined, undefined, 1500);

  if(is_not_upgraded) {
    n_fuse_timer = randomfloatrange(1, 2.5);
  } else {
    n_fuse_timer = randomfloatrange(3, 4);
  }

  foreach(target in a_targets) {
    if(util::within_fov(var_d0407533, var_d571151f, target.origin, cos(30))) {
      if(isai(target)) {
        if(!isDefined(target.titusmarked)) {
          a_tags = [];

          if(target.archetype == #"zombie_dog") {
            a_tags[0] = "j_hip_le";
            a_tags[1] = "j_hip_ri";
            a_tags[2] = "j_spine4";
            a_tags[3] = "j_neck";
            a_tags[4] = "j_shoulder_le";
            a_tags[5] = "j_shoulder_ri";
          } else {
            a_tags[0] = "j_hip_le";
            a_tags[1] = "j_hip_ri";
            a_tags[2] = "j_spine4";
            a_tags[3] = "j_elbow_le";
            a_tags[4] = "j_elbow_ri";
            a_tags[5] = "j_clavicle_le";
            a_tags[6] = "j_clavicle_ri";
          }

          str_tag = a_tags[randomint(a_tags.size)];
          b_trace_pass = bullettracepassed(var_d0407533, target gettagorigin(str_tag), 1, self, target);

          if(b_trace_pass) {
            target thread function_845f2546();
            e_dart = magicbullet(getweapon(#"hash_3de0926b89369160"), var_d0407533, target gettagorigin(str_tag), self);
            e_dart thread function_49cfb951(n_fuse_timer, is_not_upgraded, target);
            return;
          }
        }
      }
    }
  }

  vec = anglesToForward(var_d571151f);
  trace_end = var_d0407533 + vec * 20000;
  trace = bulletTrace(var_d0407533, trace_end, 1, self);
  var_7a29db08 = trace[#"position"] + function_40e83b36(55);
  e_dart = magicbullet(getweapon(#"hash_3de0926b89369160"), var_d0407533, var_7a29db08, self);
  e_dart thread function_49cfb951(n_fuse_timer);
}

function_49cfb951(n_fuse_timer = randomfloatrange(1, 1.5), is_not_upgraded = 1, ai_target, var_c1dd1629 = 1) {
  s_result = self waittill(#"death");
  a_grenades = getEntArray("grenade", "classname");

  foreach(e_grenade in a_grenades) {
    if(isDefined(e_grenade.model) && !(isDefined(e_grenade.var_66570d1b) && e_grenade.var_66570d1b) && e_grenade.model == #"wpn_t8_zm_blundergat_acid_projectile") {
      e_grenade clientfield::set("blundergat_dart_blink", 1);
      e_grenade.var_66570d1b = 1;
      e_grenade.n_fuse_time = n_fuse_timer;
      e_grenade resetmissiledetonationtime(n_fuse_timer);
      e_grenade thread wait_for_grenade_explode(n_fuse_timer, ai_target, e_grenade.owner);

      if(var_c1dd1629) {
        e_grenade thread function_7b25328b(e_grenade.owner);
      }

      return;
    }
  }
}

wait_for_grenade_explode(n_fuse_timer, ai_target, e_attacker) {
  util::waittill_any_ents(self, "death", ai_target, #"titus_target_timeout", ai_target, "death");

  if(isDefined(ai_target)) {
    if(isDefined(self.weapon)) {
      w_grenade = self.weapon;
    } else {
      w_grenade = undefined;
    }

    if(ai_target.zm_ai_category == #"miniboss" || ai_target.zm_ai_category == #"boss") {
      ai_target dodamage(ai_target.maxhealth * 0.1, ai_target.origin, e_attacker, e_attacker, "none", "MOD_GRENADE", 0, w_grenade);
      return;
    }

    if(isDefined(level.no_gib_in_wolf_area) && isDefined(ai_target[[level.no_gib_in_wolf_area]]()) && ai_target[[level.no_gib_in_wolf_area]]()) {
      ai_target.no_gib = 1;
    }

    if(!(isDefined(ai_target.no_gib) && ai_target.no_gib)) {
      gibserverutils::annihilate(ai_target);
    }

    ai_target dodamage(ai_target.health + 1000, ai_target.origin, e_attacker, e_attacker, "none", "MOD_GRENADE", 0, w_grenade);
  }
}

function_38eaed4c(watcher) {
  watcher.onspawn = &function_482c54d5;
  watcher.watchforfire = 1;
  watcher.hackable = 0;
  watcher.activatefx = 1;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.immediatedetonation = 1;
  watcher.detectiongraceperiod = 0;
  watcher.detonateradius = 64;
  watcher.onstun = &weaponobjects::weaponstun;
  watcher.stuntime = 0;
  watcher.activationdelay = 1;
  watcher.activatesound = #"wpn_gelgun_blob_burst";
  watcher.deleteonplayerspawn = 1;
  watcher.timeout = 5;
  watcher.ignorevehicles = 0;
  watcher.ignoreai = 0;
}

function_482c54d5(watcher, owner) {
  self endon(#"death");
  a_ai_zombies = getaiteamarray(level.zombie_team);

  foreach(ai_zombie in a_ai_zombies) {
    ai_zombie thread function_aa1b44dc(self);
  }

  s_result = self waittilltimeout(5, #"stationary", #"hash_14fd7b6a20ac8f44");
  waitframe(1);

  if(isplayer(s_result.target)) {
    v_pos = groundtrace(self.origin + (0, 0, 32) + (0, 0, 8), self.origin + (0, 0, 32) + (0, 0, -100000), 0, self)[#"position"];

    if(isDefined(v_pos)) {
      self ghost();
      mdl_magma = util::spawn_model(self.model, v_pos, s_result.target.angles);
    } else {
      mdl_magma = util::spawn_model(self.model, s_result.target.origin, s_result.target.angles);
    }
  } else {
    mdl_magma = util::spawn_model(self.model, self.origin, self.angles);
  }

  mdl_magma.owner = owner;
  a_ai_zombies = array::remove_undefined(a_ai_zombies, 0);

  foreach(ai_zombie in a_ai_zombies) {
    if(ai_zombie.var_4bfa8f6c === self) {
      if(ai_zombie.archetype == "zombie_dog") {
        str_tag = "j_spine1";
      } else {
        str_tag = ai_zombie get_closest_tag(self.origin);
      }

      mdl_magma clientfield::set("magma_gat_blob_fx", 2);
      mdl_magma linkto(ai_zombie, str_tag);
      ai_zombie.var_becfae27 = 1;
      ai_zombie thread function_5f305489(mdl_magma);
      self delete();
      return;
    }
  }

  mdl_magma clientfield::set("magma_gat_blob_fx", 1);
  self thread function_bf2a4486(mdl_magma, owner, watcher.weapon);
}

private function_bf2a4486(mdl_magma, owner, weapon) {
  self delete();

  if(!isDefined(level.var_56f299e3)) {
    level.var_56f299e3 = [];
  } else if(!isarray(level.var_56f299e3)) {
    level.var_56f299e3 = array(level.var_56f299e3);
  }

  if(!isinarray(level.var_56f299e3, mdl_magma)) {
    level.var_56f299e3[level.var_56f299e3.size] = mdl_magma;
  }

  if(level.var_56f299e3.size > 2) {
    level.var_56f299e3[0] notify(#"hash_39da21c99d3cf743");
  }

  mdl_magma.trigger = spawn("trigger_radius_new", mdl_magma.origin, (512 | 1) + 2, 64, 32);

  if(abs(mdl_magma.angles[2]) > 160) {
    mdl_magma.trigger.origin = mdl_magma.origin + anglestoup(mdl_magma.angles) * 32;
  }

  mdl_magma thread function_c74dfed4(weapon);
  mdl_magma thread function_7b25328b(owner);
  mdl_magma waittilltimeout(5, #"hash_39da21c99d3cf743");

  if(isDefined(mdl_magma)) {
    mdl_magma function_19b9fb04();
  }
}

private function_7b25328b(e_player) {
  if(isDefined(e_player)) {
    w_current = e_player getcurrentweapon();
  }

  v_ground_pos = groundtrace(self.origin, self.origin + (0, 0, -1000), 0, self)[#"position"];

  if(!isDefined(v_ground_pos) || distance(v_ground_pos, self.origin) > 64) {
    return;
  }

  v_point = getclosestpointonnavmesh(v_ground_pos, 128, 16);

  if(!isDefined(v_point) || distance(self.origin, v_point) > 64) {
    return;
  }

  var_dd239d21 = spawn("script_origin", v_point);

  if(!(isDefined(var_dd239d21 zm_utility::in_playable_area()) && var_dd239d21 zm_utility::in_playable_area())) {
    var_dd239d21 delete();
    return;
  }

  if(isDefined(w_current) && (w_current === getweapon(#"ww_blundergat_fire_t8_upgraded") || w_current === getweapon(#"ww_blundergat_acid_t8_upgraded"))) {
    var_dd239d21 zm_utility::create_zombie_point_of_interest(256, 6, 10000);
    var_dd239d21 zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 128);
  } else {
    var_dd239d21 zm_utility::create_zombie_point_of_interest(128, 3, 10000);
    var_dd239d21 zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 128);
  }

  a_ai_zombies = getaiteamarray(level.zombie_team);

  foreach(ai_zombie in a_ai_zombies) {
    if(ai_zombie.zm_ai_category == #"miniboss" || ai_zombie.zm_ai_category == #"boss") {
      ai_zombie thread zm_utility::add_poi_to_ignore_list(var_dd239d21);
    }
  }

  self waittill(#"death");
  var_dd239d21 delete();
}

private function_aa1b44dc(e_grenade) {
  self endon(#"death");
  e_grenade endon(#"death");
  s_result = self waittilltimeout(5, #"grenade_stuck");

  if(s_result.projectile === e_grenade) {
    self.var_4bfa8f6c = e_grenade;
    e_grenade notify(#"hash_14fd7b6a20ac8f44");
  }
}

private function_5f305489(mdl_magma) {
  mdl_magma endon(#"death");

  if(self.zm_ai_category == #"basic" || self.zm_ai_category == #"enhanced" || self.zm_ai_category == #"popcorn") {
    self waittill(#"death");
  } else if(self.zm_ai_category == #"miniboss" || self.zm_ai_category == #"boss") {
    self waittilltimeout(5, #"death");
    self notify(#"hash_556bad125b55e1a9");
  }

  mdl_magma function_19b9fb04();
}

private function_c74dfed4(weapon) {
  self endon(#"death");
  self.trigger endon(#"death");

  while(true) {
    s_result = self.trigger waittill(#"trigger");

    if(isDefined(s_result.activator)) {
      if(isplayer(s_result.activator) && s_result.activator == self.owner) {
        s_result.activator thread function_b1abe6ab(self.trigger, weapon);
        continue;
      }

      if(isinarray(getaiteamarray(level.zombie_team), s_result.activator)) {
        if(s_result.activator.zm_ai_category == #"popcorn" && !(isDefined(s_result.activator.is_on_fire) && s_result.activator.is_on_fire)) {
          s_result.activator dodamage(s_result.activator.health + 100, self.origin, self.owner, self.owner, undefined, "MOD_BURNED", 0, weapon);
          continue;
        }

        if(!(isDefined(s_result.activator.is_on_fire) && s_result.activator.is_on_fire) && !(isDefined(s_result.activator.var_cde645df) && s_result.activator.var_cde645df)) {
          s_result.activator thread function_ba9e077b(self.owner, self.origin, s_result.activator.health * 0.1, weapon);
        }
      }
    }
  }
}

private function_19b9fb04() {
  if(self clientfield::get("magma_gat_blob_fx")) {
    self clientfield::set("magma_gat_blob_fx", 0);
  }

  if(isinarray(level.var_56f299e3, self)) {
    arrayremovevalue(level.var_56f299e3, self);
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

private get_closest_tag(v_pos) {
  if(!isDefined(level.gib_tags)) {
    zombie_utility::init_gib_tags();
  }

  tag_closest = undefined;
  var_9aabd9de = arraycopy(level.gib_tags);

  if(!isDefined(var_9aabd9de)) {
    var_9aabd9de = [];
  } else if(!isarray(var_9aabd9de)) {
    var_9aabd9de = array(var_9aabd9de);
  }

  if(!isinarray(var_9aabd9de, "j_head")) {
    var_9aabd9de[var_9aabd9de.size] = "j_head";
  }

  for(i = 0; i < var_9aabd9de.size; i++) {
    if(!isDefined(tag_closest)) {
      tag_closest = var_9aabd9de[i];
      continue;
    }

    if(distancesquared(v_pos, self gettagorigin(var_9aabd9de[i])) < distancesquared(v_pos, self gettagorigin(tag_closest))) {
      tag_closest = var_9aabd9de[i];
    }
  }

  return tolower(tag_closest);
}

function_89bde454(weapon) {
  var_e97d8c2c = getweapon(#"ww_blundergat_fire_t8_unfinished");
  w_blundergat = getweapon(#"ww_blundergat_t8");
  w_blundergat_upg = getweapon(#"ww_blundergat_t8_upgraded");
  w_blundergat_acid = getweapon(#"ww_blundergat_acid_t8");
  w_blundergat_acid_upg = getweapon(#"ww_blundergat_acid_t8_upgraded");
  w_blundergat_fire = getweapon(#"ww_blundergat_fire_t8");
  w_blundergat_fire_upg = getweapon(#"ww_blundergat_fire_t8_upgraded");
  a_w_blundergat = array(var_e97d8c2c, w_blundergat, w_blundergat_upg, w_blundergat_acid, w_blundergat_acid_upg, w_blundergat_fire, w_blundergat_fire_upg);

  if(isinarray(a_w_blundergat, weapon)) {
    foreach(w_blundergat in a_w_blundergat) {
      if(self hasweapon(w_blundergat, 1)) {
        return w_blundergat;
      }
    }
  }
}

function_bd27d397(oldweapondata, newweapondata) {
  var_e97d8c2c = getweapon(#"ww_blundergat_fire_t8_unfinished");
  w_blundergat = getweapon(#"ww_blundergat_t8");
  w_blundergat_upg = getweapon(#"ww_blundergat_t8_upgraded");
  w_blundergat_acid = getweapon(#"ww_blundergat_acid_t8");
  w_blundergat_acid_upg = getweapon(#"ww_blundergat_acid_t8_upgraded");
  w_blundergat_fire = getweapon(#"ww_blundergat_fire_t8");
  w_blundergat_fire_upg = getweapon(#"ww_blundergat_fire_t8_upgraded");

  if((oldweapondata[#"weapon"] === var_e97d8c2c || oldweapondata[#"weapon"] === w_blundergat || oldweapondata[#"weapon"] === w_blundergat_upg || oldweapondata[#"weapon"] === w_blundergat_acid || oldweapondata[#"weapon"] === w_blundergat_acid_upg || oldweapondata[#"weapon"] === w_blundergat_fire || oldweapondata[#"weapon"] === w_blundergat_fire_upg) && (newweapondata[#"weapon"] === var_e97d8c2c || newweapondata[#"weapon"] === w_blundergat || newweapondata[#"weapon"] === w_blundergat_upg || newweapondata[#"weapon"] === w_blundergat_acid || newweapondata[#"weapon"] === w_blundergat_acid_upg || newweapondata[#"weapon"] === w_blundergat_fire || newweapondata[#"weapon"] === w_blundergat_fire_upg)) {
    weapondata = [];

    if(oldweapondata[#"weapon"] === w_blundergat_fire_upg || newweapondata[#"weapon"] === w_blundergat_fire_upg) {
      weapondata[#"weapon"] = w_blundergat_fire_upg;
    } else if(oldweapondata[#"weapon"] === w_blundergat_acid_upg || newweapondata[#"weapon"] === w_blundergat_acid_upg) {
      weapondata[#"weapon"] = w_blundergat_acid_upg;
    } else if(oldweapondata[#"weapon"] === w_blundergat_fire || newweapondata[#"weapon"] === w_blundergat_fire) {
      weapondata[#"weapon"] = w_blundergat_fire;
    } else if(oldweapondata[#"weapon"] === w_blundergat_acid || newweapondata[#"weapon"] === w_blundergat_acid) {
      weapondata[#"weapon"] = w_blundergat_acid;
    } else if(oldweapondata[#"weapon"] === w_blundergat_upg || newweapondata[#"weapon"] === w_blundergat_upg) {
      weapondata[#"weapon"] = w_blundergat_upg;
    } else if(oldweapondata[#"weapon"] === var_e97d8c2c) {
      weapondata[#"weapon"] = newweapondata[#"weapon"];
    } else if(newweapondata[#"weapon"] === var_e97d8c2c) {
      weapondata[#"weapon"] = oldweapondata[#"weapon"];
    } else {
      weapondata[#"weapon"] = w_blundergat;
    }

    weapon = weapondata[#"weapon"];
    weapondata[#"clip"] = newweapondata[#"clip"] + oldweapondata[#"clip"];
    weapondata[#"stock"] = newweapondata[#"stock"] + oldweapondata[#"stock"];
    weapondata[#"fuel"] = newweapondata[#"fuel"] + oldweapondata[#"fuel"];
    weapondata[#"clip"] = int(min(weapondata[#"clip"], weapon.clipsize));
    weapondata[#"stock"] = int(min(weapondata[#"stock"], weapon.maxammo));
    weapondata[#"fuel"] = int(min(weapondata[#"fuel"], weapon.fuellife));
    weapondata[#"heat"] = int(min(newweapondata[#"heat"], oldweapondata[#"heat"]));
    weapondata[#"overheat"] = int(min(newweapondata[#"overheat"], oldweapondata[#"overheat"]));
    weapondata[#"power"] = int(max(isDefined(newweapondata[#"power"]) ? newweapondata[#"power"] : 0, isDefined(oldweapondata[#"power"]) ? oldweapondata[#"power"] : 0));
    return weapondata;
  }
}

private function_b1abe6ab(t_damage, weapon) {
  self endon(#"disconnect");

  if(isDefined(self.var_bfe9b833) && self.var_bfe9b833) {
    return;
  }

  self.var_bfe9b833 = 1;

  while(isDefined(t_damage) && self istouching(t_damage)) {
    self dodamage(1, t_damage.origin, undefined, undefined, "torso_lower", "MOD_BURNED", 0, weapon);
    self playrumbleonentity("damage_light");
    wait 0.4;
  }

  self.var_bfe9b833 = undefined;
}

private function_209c8c45(eattacker, weapon) {
  v_pos = self.origin;
  var_223fc6f5 = self getcentroid();
  a_ai_zombies = getaiteamarray(level.zombie_team);
  a_ai_targets = array::get_all_closest(v_pos, a_ai_zombies, self, undefined, 128);

  foreach(ai_target in a_ai_targets) {
    if(!isDefined(ai_target) || ai_target === self) {
      continue;
    }

    if(isDefined(ai_target.var_d3bcc6f9) && ai_target.var_d3bcc6f9 || isDefined(ai_target.var_cde645df) && ai_target.var_cde645df || isDefined(ai_target.is_on_fire) && ai_target.is_on_fire) {
      continue;
    }

    if(ai_target.zm_ai_category === #"basic" || ai_target.zm_ai_category === #"enhanced") {
      ai_target thread function_b826901d(eattacker, var_223fc6f5, weapon);
      continue;
    }

    ai_target thread function_ba9e077b(eattacker, var_223fc6f5, 20, weapon);
  }
}

function_b826901d(eattacker, var_223fc6f5, weapon) {
  self endon(#"death");
  [[level.var_214f6204]] - > waitinqueue(self);

  if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
    var_a14286a7 = 1;
  }

  if(!(isDefined(self.no_gib) && self.no_gib) || isDefined(var_a14286a7) && var_a14286a7) {
    self zombie_utility::gib_random_parts();
  }

  self thread function_ba9e077b(eattacker, var_223fc6f5, undefined, weapon);
  self dodamage(400, var_223fc6f5, eattacker, eattacker, "torso_lower", "MOD_EXPLOSIVE", 0, weapon);
}

private function_dc3470c5(shitloc, vpoint, eattacker, weapon) {
  self endon(#"death");
  wait 0.5;

  if(self.zm_ai_category == #"miniboss" || self.zm_ai_category == #"boss") {
    self thread function_ba9e077b(eattacker, vpoint, 100, weapon);
    self thread function_78f754f7(eattacker, weapon);
    return;
  }

  if(self.zm_ai_category == #"popcorn") {
    self thread function_209c8c45(eattacker, weapon);
    self dodamage(self.health + 100, vpoint, eattacker, eattacker, shitloc, "MOD_BURNED", 0, weapon);
    return;
  }

  if(self.health <= 1000) {
    if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
      self.no_gib = 1;
    }

    if(!(isDefined(self.no_gib) && self.no_gib)) {
      gibserverutils::annihilate(self);
    }

    self clientfield::set("zombie_magma_fire_explosion", 1);
    self dodamage(self.health + 100, vpoint, eattacker, eattacker, shitloc, "MOD_BURNED", 0, weapon);
    return;
  }

  self thread function_ba9e077b(eattacker, vpoint, 1000, weapon);
  self thread function_7f95d262(eattacker, weapon);
}

private function_78f754f7(eattacker, weapon) {
  self endon(#"death", #"hash_556bad125b55e1a9");

  while(true) {
    if(level.round_number < 15) {
      n_dmg = self.maxhealth * randomfloatrange(0.1, 0.2);
    } else {
      n_dmg = self.maxhealth * randomfloatrange(0.05, 0.1);
    }

    if(isDefined(eattacker) && isalive(eattacker)) {
      self dodamage(n_dmg, self.origin, eattacker, eattacker, undefined, "MOD_BURNED", 0, weapon);
    } else {
      self dodamage(n_dmg, self.origin, undefined, undefined, undefined, "MOD_BURNED", 0, weapon);
    }

    wait 1;
  }
}

private function_ba9e077b(eattacker, v_hit_pos, n_damage, weapon) {
  self endon(#"death");
  self.var_d3bcc6f9 = 1;

  if(isDefined(n_damage)) {
    self dodamage(n_damage, self getcentroid(), eattacker, eattacker, "torso_lower", "MOD_BURNED", 0, weapon);
  }

  if(self.zm_ai_category == #"basic" || self.zm_ai_category == #"enhanced") {
    if(!(isDefined(self.var_cde645df) && self.var_cde645df)) {
      self thread function_faa2e2e5(eattacker, weapon);
    }
  } else if(!(isDefined(self.is_on_fire) && self.is_on_fire)) {
    zm_spawner::damage_on_fire(eattacker);
  }

  if(level.var_5fcf49dc.size < 12) {
    if(self.zm_ai_category == #"basic" || self.zm_ai_category == #"enhanced") {
      self thread function_6901bb20(v_hit_pos);
    } else {
      self thread zombie_death::flame_death_fx();
    }

    self thread function_20905835();
  }
}

private function_6901bb20(v_hit_pos) {
  self endon(#"death");

  if(isDefined(self.var_cde645df) && self.var_cde645df) {
    return;
  }

  if(isDefined(self.is_on_fire) && self.is_on_fire) {
    self.is_on_fire = undefined;
  }

  if(isDefined(self.disable_flame_fx) && self.disable_flame_fx) {
    return;
  }

  self.var_cde645df = 1;

  if(!isDefined(v_hit_pos)) {
    v_hit_pos = "torso_upper";
  }

  str_tag = get_closest_tag(v_hit_pos);
  self thread zombie_death::on_fire_timeout();

  switch (str_tag) {
    case #"j_head":
      n_fx_pos = 1;
      break;
    case #"j_spinelower":
    case #"j_spine4":
    case #"j_spineupper":
      n_fx_pos = 2;
      break;
    case #"j_elbow_le":
    case #"j_wrist_le":
    case #"j_shoulder_le":
      n_fx_pos = 3;
      break;
    case #"j_elbow_ri":
    case #"j_wrist_ri":
    case #"j_shoulder_ri":
      n_fx_pos = 4;
      break;
    case #"j_ankle_le":
    case #"j_knee_le":
    case #"j_hip_le":
      n_fx_pos = 5;
      break;
    case #"j_ankle_ri":
    case #"j_knee_ri":
    case #"j_hip_ri":
      n_fx_pos = 6;
      break;
    default:
      n_fx_pos = 1;
      break;
  }

  self clientfield::set("positional_zombie_fire_fx", n_fx_pos);
  self waittill(#"stop_flame_damage");
  self clientfield::set("positional_zombie_fire_fx", 0);
}

private function_faa2e2e5(eattacker, weapon) {
  self endon(#"death", #"stop_flame_damage");
  waitframe(1);

  while(isDefined(self.var_cde645df) && self.var_cde645df) {
    [[level.var_214f6204]] - > waitinqueue(self);

    if(level.round_number < 9) {
      n_dmg = self.maxhealth * randomfloatrange(0.6, 0.9);
    } else if(level.round_number < 16) {
      n_dmg = self.maxhealth * randomfloatrange(0.3, 0.5);
    } else if(level.round_number < 29) {
      n_dmg = self.maxhealth * randomfloatrange(0.2, 0.3);
    } else {
      n_dmg = self.maxhealth * randomfloatrange(0.15, 0.2);
    }

    if(isDefined(eattacker) && isalive(eattacker)) {
      self dodamage(n_dmg, self.origin, eattacker, eattacker, undefined, "MOD_BURNED", 0, weapon);
    } else {
      self dodamage(n_dmg, self.origin, undefined, undefined, undefined, "MOD_BURNED", 0, weapon);
    }

    wait 1;
  }
}

private function_20905835() {
  if(!isDefined(level.var_5fcf49dc)) {
    level.var_5fcf49dc = [];
  } else if(!isarray(level.var_5fcf49dc)) {
    level.var_5fcf49dc = array(level.var_5fcf49dc);
  }

  if(!isinarray(level.var_5fcf49dc, self)) {
    level.var_5fcf49dc[level.var_5fcf49dc.size] = self;
  }

  self waittill(#"death");
  arrayremovevalue(level.var_5fcf49dc, self);
}

private function_7f95d262(eattacker, weapon) {
  self endon(#"death");

  if(self.zm_ai_category !== #"basic" && self.zm_ai_category !== #"enhanced") {
    return;
  }

  n_start_time = gettime();

  for(n_total_time = 0; n_total_time < 4; n_total_time = (n_current_time - n_start_time) / 1000) {
    self thread namespace_9ff9f642::slowdown(#"hash_716657b9842cfd1b");
    wait 1;
    n_current_time = gettime();
  }

  self dodamage(self.health + 100, self getcentroid(), eattacker, eattacker, "torso_lower", "MOD_BURNED", 0, weapon);
}

function_f2ef907f() {
  level.var_acbfec33 = struct::get_array("blundergat_upgrade_acid");

  foreach(var_17022e1e in level.var_acbfec33) {
    var_17022e1e.unitrigger_stub = var_17022e1e zm_unitrigger::create(&function_e33adfe0, 64, &function_b1347a6);
    zm_unitrigger::unitrigger_force_per_player_triggers(var_17022e1e.unitrigger_stub, 1);
    var_17022e1e.unitrigger_stub flag::init(#"hash_56b99393c357db0f");
    var_17022e1e.var_13202c94 = getent(var_17022e1e.target, "targetname");
    var_17022e1e.var_13202c94 ghost();
  }

  level thread function_c95282e3();
}

private function_c95282e3() {
  level endon(#"hash_209ec855e7a13ef3");

  while(true) {
    s_result = level waittill(#"crafting_started");

    if(isDefined(s_result.unitrigger)) {
      s_result.unitrigger thread crafting_table_watcher();
    }
  }
}

crafting_table_watcher() {
  if(isDefined(self.stub.blueprint) && self.stub.blueprint.name == #"zblueprint_acid_gat_build_kit") {
    v_pos = self.stub.origin;
    s_progress = self waittill(#"death", #"hash_6db03c91467a21f5");

    if(isDefined(s_progress.b_completed) && s_progress.b_completed) {
      var_17022e1e = arraygetclosest(v_pos, level.var_acbfec33);
      var_17022e1e.unitrigger_stub flag::set(#"hash_56b99393c357db0f");
      zm_lockdown_util::function_d67bafb5(var_17022e1e.unitrigger_stub, "lockdown_stub_type_crafting_tables");
      var_17022e1e.var_13202c94 show();
      level notify(#"hash_209ec855e7a13ef3");
    }
  }
}

function_e33adfe0(player) {
  if(!self.stub flag::get(#"hash_56b99393c357db0f")) {
    return 0;
  }

  if(level flag::get(#"hash_72c4671390c83158")) {
    return 0;
  }

  if(!level flag::get(#"hash_634424410f574c1c")) {
    if(player hasweapon(getweapon(#"ww_blundergat_t8"))) {
      if(function_8b1a219a()) {
        self sethintstring(#"hash_3c3c5ffcb73ae1e3");
      } else {
        self sethintstring(#"hash_79cd3712c39cdffd");
      }

      return 1;
    } else if(player hasweapon(getweapon(#"ww_blundergat_t8_upgraded"))) {
      if(function_8b1a219a()) {
        self sethintstring(#"hash_7a5c526af7853272");
      } else {
        self sethintstring(#"hash_59f25a380adc99d6");
      }

      return 1;
    } else if(player hasweapon(getweapon(#"ww_blundergat_fire_t8"))) {
      if(function_8b1a219a()) {
        self sethintstring(#"hash_615644af00de83b0");
      } else {
        self sethintstring(#"hash_133ee13be8566c3c");
      }

      return 1;
    } else if(player hasweapon(getweapon(#"ww_blundergat_fire_t8_upgraded"))) {
      if(function_8b1a219a()) {
        self sethintstring(#"hash_768453c6e1ea01fb");
      } else {
        self sethintstring(#"hash_5facc77dd98e8ac5");
      }

      return 1;
    }

    return 0;
  }

  if(!level flag::get(#"hash_72c4671390c83158") && level flag::get(#"hash_634424410f574c1c")) {
    if(!(isDefined(player.var_393e2617) && player.var_393e2617)) {
      return 0;
    }

    if(isDefined(player.is_pack_splatting) && player.is_pack_splatting) {
      if(function_8b1a219a()) {
        self sethintstring(#"hash_3adbdf42b7a8fd09");
      } else {
        self sethintstring(#"hash_48bcf6ab597a5e63");
      }
    } else if(function_8b1a219a()) {
      self sethintstring(#"hash_4114449b7507fd46");
    } else {
      self sethintstring(#"hash_41dc872d8c9fd072");
    }

    return 1;
  }

  return 0;
}

function_b1347a6() {
  var_13202c94 = getent(self.stub.related_parent.target, "targetname");
  assert(isDefined(var_13202c94), "<dev string:x38>");

  if(!isDefined(var_13202c94)) {
    return;
  }

  v_angles = var_13202c94 gettagangles("tag_origin");

  if(!isDefined(v_angles)) {
    return;
  }

  v_weapon_origin_offset = anglesToForward(v_angles) * 2 + anglestoright(v_angles) * 21 + anglestoup(v_angles) * 1.75;
  v_weapon_angles_offset = (0, 90, -90);
  var_13202c94.v_weapon_origin = var_13202c94 gettagorigin("tag_origin") + v_weapon_origin_offset;
  var_13202c94.v_weapon_angles = v_angles + v_weapon_angles_offset;

  while(true) {
    s_result = self waittill(#"trigger");
    e_player = s_result.activator;

    if(!level flag::get(#"hash_72c4671390c83158") && !level flag::get(#"hash_634424410f574c1c")) {
      var_fc074136 = undefined;

      if(e_player hasweapon(getweapon(#"ww_blundergat_t8"))) {
        var_fc074136 = #"ww_blundergat_t8";
        var_87cbf0eb = 0;
      } else if(e_player hasweapon(getweapon(#"ww_blundergat_t8_upgraded"))) {
        var_fc074136 = #"ww_blundergat_t8_upgraded";
        var_87cbf0eb = 1;
      } else if(e_player hasweapon(getweapon(#"ww_blundergat_fire_t8"))) {
        var_fc074136 = #"ww_blundergat_fire_t8";
        var_87cbf0eb = 0;
        var_da887cb9 = getweapon(#"ww_blundergat_fire_t8");
      } else if(e_player hasweapon(getweapon(#"ww_blundergat_fire_t8_upgraded"))) {
        var_fc074136 = #"ww_blundergat_fire_t8_upgraded";
        var_87cbf0eb = 1;
        var_da887cb9 = getweapon(#"ww_blundergat_fire_t8_upgraded");
      }

      if(isDefined(var_da887cb9)) {
        e_player.var_452feb6c = e_player getweaponammostock(var_da887cb9);
      }

      if(isDefined(var_fc074136)) {
        e_player takeweapon(getweapon(var_fc074136));
        e_player.var_393e2617 = 1;

        if(!(isDefined(e_player.intermission) && e_player.intermission) && !(isDefined(e_player.is_drinking) && e_player.is_drinking)) {
          e_player zm_weapons::switch_back_primary_weapon();
        }

        if(isDefined(var_87cbf0eb) && var_87cbf0eb) {
          e_player.is_pack_splatting = 1;
        } else {
          e_player.is_pack_splatting = undefined;
        }

        var_13202c94.worldgun = zm_utility::spawn_weapon_model(getweapon(var_fc074136), undefined, var_13202c94.v_weapon_origin, var_13202c94.v_weapon_angles);
        var_13202c94 thread blundergat_upgrade_station_inject(var_fc074136, e_player);
      }

      continue;
    }

    if(level flag::get(#"hash_634424410f574c1c")) {
      if(zm_utility::is_player_valid(e_player) && !e_player zm_utility::is_drinking() && !zm_loadout::is_placeable_mine(e_player.currentweapon) && !zm_equipment::is_equipment(e_player.currentweapon) && e_player.currentweapon.name != "none") {
        e_player notify(#"acid_taken");
        var_287a8343 = zm_utility::get_player_weapon_limit(e_player);
        a_primaries = e_player getweaponslistprimaries();

        if(isDefined(a_primaries) && a_primaries.size >= var_287a8343) {
          e_player takeweapon(e_player.currentweapon);
        }

        if(e_player hasweapon(getweapon(#"ww_blundergat_acid_t8"))) {
          e_player givemaxammo(getweapon(#"ww_blundergat_acid_t8"));
        } else if(e_player hasweapon(getweapon(#"ww_blundergat_acid_t8_upgraded"))) {
          e_player givemaxammo(getweapon(#"ww_blundergat_acid_t8_upgraded"));
        } else {
          if(isDefined(var_13202c94.worldgun)) {
            var_f2fae71a = var_13202c94.worldgun.item;
          } else {
            var_f2fae71a = getweapon(#"ww_blundergat_acid_t8");
          }

          e_player giveweapon(var_f2fae71a);
          e_player switchtoweapon(var_f2fae71a);

          if(isDefined(e_player.var_452feb6c)) {
            e_player setweaponammostock(var_f2fae71a, math::clamp(e_player.var_452feb6c, 0, var_f2fae71a.maxammo));
            e_player.var_452feb6c = undefined;
          }

          e_player thread zm_audio::create_and_play_dialog(#"weapon_pickup", #"acidgat");
        }

        e_player notify(#"player_obtained_acidgat");
      }

      if(isDefined(var_13202c94.worldgun)) {
        var_13202c94.worldgun delete();
      }

      wait 0.5;
      e_player.is_pack_splatting = undefined;
      e_player.var_393e2617 = undefined;
      level flag::clear(#"hash_634424410f574c1c");
      level flag::clear(#"hash_72c4671390c83158");
    }
  }
}

wait_for_timeout(var_607f49de) {
  self endon(#"disconnect", #"acid_taken", #"player_obtained_acidgat");
  wait 15;
  level flag::clear(#"hash_634424410f574c1c");

  if(isDefined(self)) {
    self.is_pack_splatting = undefined;
    self.var_393e2617 = undefined;
  }

  if(isDefined(var_607f49de)) {
    var_607f49de delete();
  }
}

blundergat_upgrade_station_inject(var_f2528cbc, e_player) {
  level flag::set(#"hash_72c4671390c83158");
  wait 0.5;
  self playSound(#"zmb_acidgat_upgrade_machine");
  self thread scene::init(#"p8_fxanim_zm_esc_packasplat_bundle", self);
  wait 5;

  if(isDefined(self.worldgun)) {
    self.worldgun delete();
  }

  if(var_f2528cbc == #"ww_blundergat_t8" || var_f2528cbc == #"ww_blundergat_fire_t8") {
    self.worldgun = zm_utility::spawn_weapon_model(getweapon(#"ww_blundergat_acid_t8"), undefined, self.v_weapon_origin, self.v_weapon_angles);
  } else {
    self.worldgun = zm_utility::spawn_weapon_model(getweapon(#"ww_blundergat_acid_t8_upgraded"), undefined, self.v_weapon_origin, self.v_weapon_angles);
  }

  self thread scene::play(#"p8_fxanim_zm_esc_packasplat_bundle", self);
  wait 1;
  level flag::clear(#"hash_72c4671390c83158");
  level flag::set(#"hash_634424410f574c1c");

  if(isDefined(e_player)) {
    e_player thread wait_for_timeout(self.worldgun);
  }
}