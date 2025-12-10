/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_staff_water.gsc
*************************************************/

#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_weap_staff_common;
#using scripts\zm\zm_tomb_utility;
#namespace zm_weap_staff_water;

function autoexec __init__sytem__() {
  system::register("zm_weap_staff_water", &__init__, undefined, undefined);
}

function __init__() {
  level._effect["staff_water_blizzard"] = "weapon/zmb_staff/fx_zmb_staff_ice_ug_impact_hit";
  level._effect["staff_water_ice_shard"] = "weapon/zmb_staff/fx_zmb_staff_ice_trail_bolt";
  level._effect["staff_water_shatter"] = "weapon/zmb_staff/fx_zmb_staff_ice_exp";
  clientfield::register("scriptmover", "staff_blizzard_fx", 21000, 1, "int");
  clientfield::register("actor", "anim_rate", 21000, 2, "float");
  clientfield::register("actor", "attach_bullet_model", 21000, 1, "int");
  clientfield::register("actor", "staff_shatter_fx", 21000, 1, "int");
  callback::on_spawned(&onplayerspawned);
  level flag::init("blizzard_active");
  init_tag_array();
  level thread water_dart_cleanup();
  zm_spawner::register_zombie_death_event_callback(&staff_water_death_event);
  zm_spawner::add_custom_zombie_spawn_logic(&staff_water_on_zombie_spawned);
}

function init_tag_array() {
  level.zombie_water_icicle_tag = [];
  level.zombie_water_icicle_tag[0] = "j_hip_le";
  level.zombie_water_icicle_tag[1] = "j_hip_ri";
  level.zombie_water_icicle_tag[2] = "j_spine4";
  level.zombie_water_icicle_tag[3] = "j_elbow_le";
  level.zombie_water_icicle_tag[4] = "j_elbow_ri";
  level.zombie_water_icicle_tag[5] = "j_clavicle_le";
  level.zombie_water_icicle_tag[6] = "j_clavicle_ri";
}

function water_dart_cleanup() {
  while(true) {
    a_grenades = getEntArray("grenade", "classname");
    foreach(e_grenade in a_grenades) {
      if(isDefined(e_grenade.model) && e_grenade.model == "p6_zm_tm_staff_projectile_ice") {
        time = gettime();
        if((time - e_grenade.birthtime) >= 1000) {
          e_grenade delete();
        }
      }
    }
    wait(0.1);
  }
}

function onplayerspawned() {
  self endon("disconnect");
  self thread watch_staff_water_fired();
  self thread watch_staff_water_impact();
  self thread zm_tomb_utility::watch_staff_usage();
}

function watch_staff_water_fired() {
  self endon("disconnect");
  while(true) {
    self waittill("missile_fire", e_projectile, str_weapon);
    if(str_weapon.name == "staff_water" || str_weapon.name == "staff_water_upgraded") {
      util::wait_network_frame();
      _icicle_locate_target(str_weapon);
      util::wait_network_frame();
      _icicle_locate_target(str_weapon);
      util::wait_network_frame();
      _icicle_locate_target(str_weapon);
    }
  }
}

function watch_staff_water_impact() {
  self endon("disconnect");
  while(true) {
    self waittill("projectile_impact", str_weapon, v_explode_point, n_radius, str_name, n_impact);
    if(str_weapon.name == "staff_water_upgraded2" || str_weapon.name == "staff_water_upgraded3") {
      n_lifetime = 6;
      if(str_weapon.name == "staff_water_upgraded3") {
        n_lifetime = 9;
      }
      self thread staff_water_position_source(v_explode_point, n_lifetime, str_weapon);
    }
  }
}

function staff_water_kill_zombie(player, str_weapon) {
  self freeze_zombie();
  self zm_tomb_utility::do_damage_network_safe(player, self.health, str_weapon, "MOD_RIFLE_BULLET");
  if(isDefined(self.deathanim)) {
    self waittillmatch("death_anim");
  }
  if(isDefined(self)) {
    self thread frozen_zombie_shatter();
  }
  player zm_score::player_add_points("death", "", "");
}

function freeze_zombie() {
  if(isDefined(self.is_mechz) && self.is_mechz) {
    return;
  }
  self.var_93022f09 = 1;
}

function _network_safe_play_fx(fx, v_origin) {
  playFX(fx, v_origin, (0, 0, 1), (1, 0, 0));
}

function network_safe_play_fx(id, max, fx, v_origin) {
  zm_net::network_safe_init(id, max);
  zm_net::network_choke_action(id, &_network_safe_play_fx, fx, v_origin);
}

function frozen_zombie_shatter() {
  if(isDefined(self.is_mechz) && self.is_mechz) {
    return;
  }
  if(isDefined(self)) {
    if(1) {
      v_fx = self gettagorigin("J_SpineLower");
      level thread network_safe_play_fx("frozen_shatter", 2, level._effect["staff_water_shatter"], v_fx);
      self thread frozen_zombie_gib("normal");
    } else {
      self startragdoll();
    }
  }
}

function frozen_zombie_gib(gib_type) {
  gibarray = [];
  gibarray[gibarray.size] = level._zombie_gib_piece_index_all;
  self gib(gib_type, gibarray);
  self ghost();
  wait(0.4);
  if(isDefined(self)) {
    self delete();
  }
}

function staff_water_position_source(v_detonate, n_lifetime_sec, str_weapon) {
  self endon("disconnect");
  if(isDefined(v_detonate)) {
    level notify("blizzard_shot");
    e_fx = spawn("script_model", v_detonate + vectorscale((0, 0, 1), 33));
    e_fx setModel("tag_origin");
    e_fx clientfield::set("staff_blizzard_fx", 1);
    e_fx thread zm_tomb_utility::puzzle_debug_position("X", (0, 64, 255));
    wait(1);
    level flag::set("blizzard_active");
    e_fx thread ice_staff_blizzard_do_kills(self, str_weapon);
    e_fx thread zm_tomb_utility::whirlwind_rumble_nearby_players("blizzard_active");
    e_fx thread ice_staff_blizzard_timeout(n_lifetime_sec);
    e_fx thread ice_staff_blizzard_off();
    e_fx waittill("blizzard_off");
    level flag::clear("blizzard_active");
    e_fx notify("stop_debug_position");
    wait(0.1);
    e_fx clientfield::set("staff_blizzard_fx", 0);
    wait(0.1);
    e_fx delete();
  }
}

function ice_staff_blizzard_do_kills(player, str_weapon) {
  player endon("disconnect");
  self endon("blizzard_off");
  while(true) {
    a_zombies = getaiarray();
    foreach(zombie in a_zombies) {
      if(!(isDefined(zombie.is_on_ice) && zombie.is_on_ice)) {
        if(distancesquared(self.origin, zombie.origin) <= 30625) {
          if(isDefined(zombie.is_mechz) && zombie.is_mechz) {
            zombie thread ice_affect_mechz(player, 1);
            continue;
          }
          if(isalive(zombie)) {
            zombie thread ice_affect_zombie(str_weapon, player, 1);
          }
        }
      }
    }
    wait(0.1);
  }
}

function ice_staff_blizzard_timeout(n_time) {
  self endon("death");
  self endon("blizzard_off");
  wait(n_time);
  self notify("blizzard_off");
}

function ice_staff_blizzard_off() {
  self endon("death");
  self endon("blizzard_off");
  level waittill("blizzard_shot");
  self notify("blizzard_off");
}

function get_ice_blast_range(n_charge) {
  switch (n_charge) {
    case 0:
    case 1: {
      n_range = 250000;
      break;
    }
    case 2: {
      n_range = 640000;
      break;
    }
    case 3: {
      n_range = 1000000;
      break;
    }
  }
  return n_range;
}

function staff_water_zombie_range(v_source, n_range) {
  a_enemies = [];
  a_zombies = getaiarray();
  a_zombies = util::get_array_of_closest(v_source, a_zombies);
  if(isDefined(a_zombies)) {
    for(i = 0; i < a_zombies.size; i++) {
      if(!isDefined(a_zombies[i])) {
        continue;
      }
      v_zombie_pos = a_zombies[i] gettagorigin("j_head");
      if(distancesquared(v_source, v_zombie_pos) > n_range) {
        continue;
      }
      if(!zm_tomb_utility::bullet_trace_throttled(v_source, v_zombie_pos, undefined)) {
        continue;
      }
      if(isDefined(a_zombies[i]) && isalive(a_zombies[i])) {
        a_enemies[a_enemies.size] = a_zombies[i];
      }
    }
  }
  return a_enemies;
}

function is_staff_water_damage(weapon) {
  return isDefined(weapon) && (weapon.name == "staff_water" || weapon.name == "staff_water_upgraded" || weapon.name == "staff_water_fake_dart_zm") && (!(isDefined(self.set_beacon_damage) && self.set_beacon_damage));
}

function ice_affect_mechz(e_player, is_upgraded) {
  if(isDefined(self.is_on_ice) && self.is_on_ice) {
    return;
  }
  self.is_on_ice = 1;
  if(is_upgraded) {
    self zm_tomb_utility::do_damage_network_safe(e_player, 3300, "staff_water_upgraded", "MOD_RIFLE_BULLET");
  } else {
    self zm_tomb_utility::do_damage_network_safe(e_player, 2050, "staff_water", "MOD_RIFLE_BULLET");
  }
  wait(1);
  self.is_on_ice = 0;
}

function ice_affect_zombie(str_weapon = "staff_water", e_player, always_kill = 0, n_mod = 1) {
  self endon("death");
  instakill_on = e_player zm_powerups::is_insta_kill_active();
  if(str_weapon.name == "staff_water") {
    n_damage = 2050;
  } else {
    if(str_weapon.name == "staff_water_upgraded" || str_weapon.name == "staff_water_upgraded2" || str_weapon.name == "staff_water_upgraded3") {
      n_damage = 3300;
    } else if(str_weapon.name == "one_inch_punch_ice") {
      n_damage = 11275;
    }
  }
  if(isDefined(self.is_on_ice) && self.is_on_ice) {
    return;
  }
  self.is_on_ice = 1;
  self clientfield::set("attach_bullet_model", 1);
  self thread function_de3654ba(1);
  n_speed = 0.3;
  self asmsetanimationrate(0.3);
  if(instakill_on || always_kill) {
    wait(randomfloatrange(0.5, 0.7));
  } else {
    wait(randomfloatrange(1.8, 2.3));
  }
  if(self.health < n_damage || instakill_on || always_kill) {
    self asmsetanimationrate(1);
    util::wait_network_frame();
    if(str_weapon.name != "one_inch_punch_ice") {
      staff_water_kill_zombie(e_player, str_weapon);
    }
  } else {
    self zm_tomb_utility::do_damage_network_safe(e_player, n_damage, str_weapon, "MOD_RIFLE_BULLET");
    self.deathanim = undefined;
    self clientfield::set("attach_bullet_model", 0);
    wait(0.5);
    self thread function_de3654ba(0);
    self asmsetanimationrate(1);
    self.is_on_ice = 0;
  }
}

function set_anim_rate(n_speed) {
  self clientfield::set("anim_rate", n_speed);
  n_rate = self clientfield::get("anim_rate");
  self setentityanimrate(n_rate);
  if(n_speed != 1) {
    self.preserve_asd_substates = 1;
  }
  util::wait_network_frame();
  if(!(isDefined(self.is_traversing) && self.is_traversing)) {
    self.needs_run_update = 1;
    self notify("needs_run_update");
  }
  util::wait_network_frame();
  if(n_speed == 1) {
    self.preserve_asd_substates = 0;
  }
}

function staff_water_on_zombie_spawned() {
  self clientfield::set("anim_rate", 1);
  n_rate = self clientfield::get("anim_rate");
  self setentityanimrate(n_rate);
}

function staff_water_death_event(attacker) {
  if(is_staff_water_damage(self.damageweapon) && self.damagemod != "MOD_MELEE") {
    self.no_gib = 1;
    self.nodeathragdoll = 1;
    self freeze_zombie();
    if(isDefined(self.deathanim)) {
      self waittillmatch("death_anim");
    }
    self thread frozen_zombie_shatter();
  }
}

function _icicle_locate_target(str_weapon) {
  is_upgraded = str_weapon.name == "staff_water_upgraded";
  fire_angles = self getplayerangles();
  fire_origin = self getplayercamerapos();
  a_targets = getaiarray();
  a_targets = util::get_array_of_closest(self.origin, a_targets, undefined, undefined, 600);
  foreach(target in a_targets) {
    if(isDefined(target.is_on_ice) && target.is_on_ice) {
      continue;
    }
    if(util::within_fov(fire_origin, fire_angles, target gettagorigin("j_spine4"), cos(25))) {
      if(isai(target)) {
        a_tags = [];
        a_tags[0] = "j_hip_le";
        a_tags[1] = "j_hip_ri";
        a_tags[2] = "j_spine4";
        a_tags[3] = "j_elbow_le";
        a_tags[4] = "j_elbow_ri";
        a_tags[5] = "j_clavicle_le";
        a_tags[6] = "j_clavicle_ri";
        str_tag = a_tags[randomint(a_tags.size)];
        b_trace_pass = zm_tomb_utility::bullet_trace_throttled(fire_origin, target gettagorigin(str_tag), target);
        if(b_trace_pass && isDefined(target) && isalive(target)) {
          if(isDefined(target.is_mechz) && target.is_mechz) {
            target thread ice_affect_mechz(self, is_upgraded);
          } else {
            target thread ice_affect_zombie(str_weapon, self);
          }
          return;
        }
      }
    }
  }
}

function _icicle_get_spread(n_spread) {
  n_x = randomintrange(n_spread * -1, n_spread);
  n_y = randomintrange(n_spread * -1, n_spread);
  n_z = randomintrange(n_spread * -1, n_spread);
  return (n_x, n_y, n_z);
}

function function_de3654ba(is_frozen) {
  if(self.archetype !== "zombie") {
    return;
  }
  if(is_frozen && !issubstr(self.model, "_ice")) {
    self.no_gib = 1;
    if(!isDefined(self.old_model)) {
      self.old_model = self.model;
      self.var_f08c601 = self.head;
      self.var_7cff9f25 = self.hatmodel;
    }
    self setModel(self.old_model + "_ice");
    if(isDefined(self.var_f08c601) && (!(isDefined(self.head_gibbed) && self.head_gibbed))) {
      self detach(self.head);
      self attach(self.var_f08c601 + "_ice");
      self.head = self.var_f08c601 + "_ice";
    }
    if(isDefined(self.var_7cff9f25) && (!(isDefined(self.hat_gibbed) && self.hat_gibbed))) {
      self detach(self.hatmodel);
      self attach(self.var_7cff9f25 + "_ice");
      self.hatmodel = self.var_7cff9f25 + "_ice";
    }
  } else if(!is_frozen && isDefined(self.old_model)) {
    self.no_gib = undefined;
    self setModel(self.old_model);
    self.old_model = undefined;
    if(isDefined(self.var_f08c601) && (!(isDefined(self.head_gibbed) && self.head_gibbed))) {
      self detach(self.head);
      self attach(self.var_f08c601);
      self.var_f08c601 = undefined;
    }
    if(isDefined(self.var_7cff9f25) && (!(isDefined(self.hat_gibbed) && self.hat_gibbed))) {
      self detach(self.hatmodel);
      self attach(self.var_7cff9f25);
      self.var_7cff9f25 = undefined;
    }
  }
}