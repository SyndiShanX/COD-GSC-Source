/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_staff_fire.gsc
*************************************************/

#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_weap_staff_common;
#using scripts\zm\zm_tomb_utility;
#namespace zm_weap_staff_fire;

function autoexec __init__sytem__() {
  system::register("zm_weap_staff_fire", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("actor", "fire_char_fx", 21000, 1, "int");
  clientfield::register("toplayer", "fire_muzzle_fx", 21000, 1, "counter");
  callback::on_spawned(&onplayerspawned);
  zm_spawner::register_zombie_damage_callback(&staff_fire_zombie_damage_response);
  zm_spawner::register_zombie_death_event_callback(&staff_fire_death_event);
  level.w_staff_fire = getweapon("staff_fire");
  level.w_staff_fire_upgraded = getweapon("staff_fire_upgraded");
}

function onplayerspawned() {
  self endon("disconnect");
  self thread watch_staff_fire_upgrade_fired();
  self thread watch_staff_fire_fired();
  self thread zm_tomb_utility::watch_staff_usage();
}

function watch_staff_fire_fired() {
  self notify("watch_staff_fired");
  self endon("disconnect");
  self endon("watch_staff_fired");
  while(true) {
    self waittill("missile_fire", e_projectile, w_weapon);
    if(isDefined(e_projectile.additional_shot) && e_projectile.additional_shot) {
      continue;
    }
    if(w_weapon.name == "staff_fire" || w_weapon.name == "staff_fire_upgraded") {
      self fire_spread_shots(w_weapon);
    }
  }
}

function watch_staff_fire_upgrade_fired() {
  self notify("watch_staff_upgrade_fired");
  self endon("disconnect");
  self endon("watch_staff_upgrade_fired");
  while(true) {
    self waittill("grenade_fire", e_projectile, w_weapon);
    if(isDefined(e_projectile.additional_shot) && e_projectile.additional_shot) {
      continue;
    }
    if(w_weapon.name == "staff_fire_upgraded2" || w_weapon.name == "staff_fire_upgraded3") {
      e_projectile thread fire_staff_update_grenade_fuse();
      e_projectile thread fire_staff_area_of_effect(self, w_weapon);
      self fire_additional_shots(w_weapon);
    }
  }
}

function fire_spread_shots(w_weapon) {
  self clientfield::increment_to_player("fire_muzzle_fx", 1);
  util::wait_network_frame();
  util::wait_network_frame();
  v_fwd = self getweaponforwarddir();
  fire_angles = vectortoangles(v_fwd);
  fire_origin = self getweaponmuzzlepoint();
  trace = bulletTrace(fire_origin, fire_origin + (v_fwd * 100), 0, undefined);
  if(trace["fraction"] != 1) {
    return;
  }
  v_left_angles = (fire_angles[0], fire_angles[1] - 15, fire_angles[2]);
  v_left = anglesToForward(v_left_angles);
  e_proj = magicbullet(w_weapon, fire_origin + (v_fwd * 50), fire_origin + (v_left * 100), self);
  e_proj.additional_shot = 1;
  util::wait_network_frame();
  util::wait_network_frame();
  v_fwd = self getweaponforwarddir();
  fire_angles = vectortoangles(v_fwd);
  fire_origin = self getweaponmuzzlepoint();
  v_right_angles = (fire_angles[0], fire_angles[1] + 15, fire_angles[2]);
  v_right = anglesToForward(v_right_angles);
  e_proj = magicbullet(w_weapon, fire_origin + (v_fwd * 50), fire_origin + (v_right * 100), self);
  e_proj.additional_shot = 1;
}

function fire_staff_area_of_effect(e_attacker, w_weapon) {
  self waittill("explode", v_pos);
  ent = spawn("script_origin", v_pos);
  ent playLoopSound("wpn_firestaff_grenade_loop", 1);
  level thread zm_tomb_utility::puzzle_debug_position("", vectorscale((1, 0, 0), 255), v_pos, undefined, 5);
  n_alive_time = 5;
  aoe_radius = 80;
  if(w_weapon.name == "staff_fire_upgraded3") {
    aoe_radius = 100;
  }
  n_step_size = 0.2;
  while(n_alive_time > 0) {
    if((n_alive_time - n_step_size) <= 0) {
      aoe_radius = aoe_radius * 2;
    }
    a_targets = getaiarray();
    a_targets = util::get_array_of_closest(v_pos, a_targets, undefined, undefined, aoe_radius);
    wait(n_step_size);
    n_alive_time = n_alive_time - n_step_size;
    foreach(e_target in a_targets) {
      if(isDefined(e_target) && isalive(e_target)) {
        if(!(isDefined(e_target.is_on_fire) && e_target.is_on_fire)) {
          e_target thread flame_damage_fx(w_weapon, e_attacker);
        }
      }
    }
  }
  ent playSound("wpn_firestaff_proj_impact");
  ent delete();
}

function grenade_waittill_still_or_bounce() {
  self endon("death");
  self endon("grenade_bounce");
  wait(0.5);
  do {
    prev_origin = self.origin;
    util::wait_network_frame();
    util::wait_network_frame();
  }
  while(prev_origin != self.origin);
}

function fire_staff_update_grenade_fuse() {
  self endon("death");
  self grenade_waittill_still_or_bounce();
  self notify("fire_aoe_start", self.origin);
  self resetmissiledetonationtime(0);
}

function fire_additional_shots(w_weapon) {
  self endon("disconnect");
  self endon("weapon_change");
  n_shots = 1;
  if(w_weapon.name == "staff_fire_upgraded3") {
    n_shots = 2;
  }
  for(i = 1; i <= n_shots; i++) {
    wait(0.35);
    if(isDefined(self) && self getcurrentweapon() == level.w_staff_fire_upgraded) {
      v_player_angles = vectortoangles(self getweaponforwarddir());
      n_player_pitch = v_player_angles[0];
      n_player_pitch = n_player_pitch + (5 * i);
      n_player_yaw = v_player_angles[1] + (randomfloatrange(-15, 15));
      v_shot_angles = (n_player_pitch, n_player_yaw, v_player_angles[2]);
      v_shot_start = self getweaponmuzzlepoint();
      v_shot_end = v_shot_start + anglesToForward(v_shot_angles);
      e_proj = magicbullet(w_weapon, v_shot_start, v_shot_end, self);
      e_proj.additional_shot = 1;
      e_proj thread fire_staff_update_grenade_fuse();
      e_proj thread fire_staff_area_of_effect(self, w_weapon);
      self clientfield::increment_to_player("fire_muzzle_fx", 1);
    }
  }
}

function staff_fire_zombie_damage_response(mod, hit_location, hit_origin, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
  if(self is_staff_fire_damage(self.damageweapon) && mod != "MOD_MELEE") {
    self thread staff_fire_zombie_hit_response_internal(mod, self.damageweapon, player, amount);
    return true;
  }
  return false;
}

function is_staff_fire_damage(weapon) {
  return isDefined(weapon) && (weapon.name == "staff_fire" || weapon.name == "staff_fire_upgraded" || weapon.name == "staff_fire_upgraded2" || weapon.name == "staff_fire_upgraded3") && (!(isDefined(self.set_beacon_damage) && self.set_beacon_damage));
}

function staff_fire_zombie_hit_response_internal(mod, damageweapon, player, amount) {
  player endon("disconnect");
  if(!isalive(self)) {
    return;
  }
  if(mod != "MOD_BURNED" && mod != "MOD_GRENADE_SPLASH") {
    pct_from_center = (amount - 1) / 10;
    pct_damage = 0.5 + (0.5 * pct_from_center);
    if(isDefined(self.is_mechz) && self.is_mechz) {
      self thread mechz_flame_damage(damageweapon, player, pct_damage);
      return;
    }
    self thread flame_damage_fx(damageweapon, player, pct_damage);
  }
}

function staff_fire_death_event(attacker) {
  if(is_staff_fire_damage(self.damageweapon) && self.damagemod != "MOD_MELEE") {
    self.var_1339189a = 1;
    self clientfield::set("fire_char_fx", 1);
    self thread function_50814f21(1);
    self thread zombie_utility::zombie_eye_glow_stop();
  }
}

function on_fire_timeout(n_duration) {
  self endon("death");
  wait(n_duration);
  self.is_on_fire = 0;
  self notify("stop_flame_damage");
}

function flame_damage_fx(damageweapon, e_attacker, pct_damage = 1) {
  was_on_fire = isDefined(self.is_on_fire) && self.is_on_fire;
  n_initial_dmg = get_impact_damage(damageweapon) * pct_damage;
  is_upgraded = damageweapon.name == "staff_fire_upgraded" || damageweapon.name == "staff_fire_upgraded2" || damageweapon.name == "staff_fire_upgraded3";
  if(is_upgraded && pct_damage > 0.5 && n_initial_dmg > self.health && math::cointoss()) {
    self zm_tomb_utility::do_damage_network_safe(e_attacker, self.health, damageweapon, "MOD_BURNED");
    if(math::cointoss()) {
      self thread zm_tomb_utility::zombie_gib_all();
    } else {
      self thread zm_tomb_utility::zombie_gib_guts();
    }
    return;
  }
  self endon("death");
  if(!was_on_fire) {
    self.is_on_fire = 1;
    self thread zombie_set_and_restore_flame_state();
    wait(0.5);
    self thread flame_damage_over_time(e_attacker, damageweapon, pct_damage);
  }
  if(n_initial_dmg > 0) {
    self zm_tomb_utility::do_damage_network_safe(e_attacker, n_initial_dmg, damageweapon, "MOD_BURNED");
  }
}

function _fire_stun_zombie_internal(do_stun, run_cycle) {
  if(!isalive(self)) {
    return;
  }
  if(!(isDefined(self.missinglegs) && self.missinglegs)) {
    self zombie_utility::set_zombie_run_cycle(run_cycle);
  }
  self.var_262d5062 = do_stun;
}

function zombie_set_and_restore_flame_state() {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.is_mechz) && self.is_mechz) {
    return;
  }
  self clientfield::set("fire_char_fx", 1);
  self thread function_50814f21(1);
  self.disablemelee = 1;
  prev_run_cycle = self.zombie_move_speed;
  if(!(isDefined(self.missinglegs) && self.missinglegs)) {
    self.deathanim = "zm_death_fire";
  }
  if(self.ai_state == "find_flesh") {
    self.ignoremelee = 1;
    self _fire_stun_zombie_internal(1, "burned");
  }
  self waittill("stop_flame_damage");
  self.deathanim = undefined;
  self.disablemelee = undefined;
  if(self.ai_state == "find_flesh") {
    self.ignoremelee = undefined;
    self _fire_stun_zombie_internal(0, prev_run_cycle);
  }
  self clientfield::set("fire_char_fx", 0);
}

function get_impact_damage(damageweapon) {
  str_name = damageweapon.name;
  switch (str_name) {
    case "staff_fire": {
      return 2050;
    }
    case "staff_fire_upgraded": {
      return 3300;
    }
    case "staff_fire_upgraded2": {
      return 11500;
    }
    case "staff_fire_upgraded3": {
      return 20000;
    }
    case "one_inch_punch_fire": {
      return 0;
    }
    default: {
      return 0;
    }
  }
}

function get_damage_per_second(damageweapon) {
  str_name = damageweapon.name;
  switch (str_name) {
    case "staff_fire": {
      return 75;
    }
    case "staff_fire_upgraded": {
      return 150;
    }
    case "staff_fire_upgraded2": {
      return 300;
    }
    case "staff_fire_upgraded3": {
      return 450;
    }
    case "one_inch_punch_fire": {
      return 250;
    }
    default: {
      return self.health;
    }
  }
}

function get_damage_duration(damageweapon) {
  str_name = damageweapon.name;
  switch (str_name) {
    case "staff_fire": {
      return 8;
    }
    case "staff_fire_upgraded": {
      return 8;
    }
    case "staff_fire_upgraded2": {
      return 8;
    }
    case "staff_fire_upgraded3": {
      return 8;
    }
    case "one_inch_punch_fire": {
      return 8;
    }
    default: {
      return 8;
    }
  }
}

function flame_damage_over_time(e_attacker, damageweapon, pct_damage) {
  e_attacker endon("disconnect");
  self endon("death");
  self endon("stop_flame_damage");
  n_damage = get_damage_per_second(damageweapon);
  n_duration = get_damage_duration(damageweapon);
  n_damage = n_damage * pct_damage;
  self thread on_fire_timeout(n_duration);
  while(true) {
    if(isDefined(e_attacker) && isplayer(e_attacker)) {
      if(e_attacker zm_powerups::is_insta_kill_active()) {
        n_damage = self.health;
      }
    }
    self zm_tomb_utility::do_damage_network_safe(e_attacker, n_damage, damageweapon, "MOD_BURNED");
    wait(1);
  }
}

function mechz_flame_damage(damageweapon, e_attacker, pct_damage) {
  self endon("death");
  n_initial_dmg = get_impact_damage(damageweapon);
  if(n_initial_dmg > 0) {
    self zm_tomb_utility::do_damage_network_safe(e_attacker, n_initial_dmg, damageweapon, "MOD_BURNED");
  }
}

function stop_zombie() {
  e_linker = spawn("script_origin", (0, 0, 0));
  e_linker.origin = self.origin;
  e_linker.angles = self.angles;
  self linkto(e_linker);
  self waittill("death");
  e_linker delete();
}

function function_50814f21(is_on_fire) {
  if(self.archetype !== "zombie") {
    return;
  }
  if(is_on_fire && !issubstr(self.model, "_fire")) {
    self.no_gib = 1;
    if(!isDefined(self.old_model)) {
      self.old_model = self.model;
      self.var_f08c601 = self.head;
      self.var_7cff9f25 = self.hatmodel;
    }
    self setModel(self.old_model + "_fire");
    if(isDefined(self.var_f08c601) && (!(isDefined(self.head_gibbed) && self.head_gibbed))) {
      self detach(self.head);
      self attach(self.var_f08c601 + "_fire");
      self.head = self.var_f08c601 + "_fire";
    }
    if(isDefined(self.var_7cff9f25) && (!(isDefined(self.hat_gibbed) && self.hat_gibbed))) {
      self detach(self.hatmodel);
      self attach(self.var_7cff9f25 + "_fire");
      self.hatmodel = self.var_7cff9f25 + "_fire";
    }
  } else if(!is_on_fire && isDefined(self.old_model)) {
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