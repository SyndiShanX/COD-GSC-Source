/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_microwavegun.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_weap_microwavegun;

function autoexec __init__sytem__() {
  system::register("zm_weap_microwavegun", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("actor", "toggle_microwavegun_hit_response", 21000, 1, "int");
  clientfield::register("actor", "toggle_microwavegun_expand_response", 21000, 1, "int");
  clientfield::register("clientuimodel", "hudItems.showDpadLeft_WaveGun", 21000, 1, "int");
  clientfield::register("clientuimodel", "hudItems.dpadLeftAmmo", 21000, 5, "int");
  zm_spawner::register_zombie_damage_callback(&microwavegun_zombie_damage_response);
  zm_spawner::register_zombie_death_animscript_callback(&microwavegun_zombie_death_response);
  zombie_utility::set_zombie_var("microwavegun_cylinder_radius", 180);
  zombie_utility::set_zombie_var("microwavegun_sizzle_range", 480);
  level._effect["microwavegun_zap_shock_dw"] = "dlc5/zmb_weapon/fx_zap_shock_dw";
  level._effect["microwavegun_zap_shock_eyes_dw"] = "dlc5/zmb_weapon/fx_zap_shock_eyes_dw";
  level._effect["microwavegun_zap_shock_lh"] = "dlc5/zmb_weapon/fx_zap_shock_lh";
  level._effect["microwavegun_zap_shock_eyes_lh"] = "dlc5/zmb_weapon/fx_zap_shock_eyes_lh";
  level._effect["microwavegun_zap_shock_ug"] = "dlc5/zmb_weapon/fx_zap_shock_ug";
  level._effect["microwavegun_zap_shock_eyes_ug"] = "dlc5/zmb_weapon/fx_zap_shock_eyes_ug";
  animationstatenetwork::registernotetrackhandlerfunction("expand", &function_5c6b11a6);
  animationstatenetwork::registernotetrackhandlerfunction("explode", &function_f8d8850f);
  level thread microwavegun_on_player_connect();
  level._microwaveable_objects = [];
  level.w_microwavegun = getweapon("microwavegun");
  level.w_microwavegun_upgraded = getweapon("microwavegun_upgraded");
  level.w_microwavegundw = getweapon("microwavegundw");
  level.w_microwavegundw_upgraded = getweapon("microwavegundw_upgraded");
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned() {
  self thread function_8f95fde5();
}

function function_8f95fde5() {
  self notify("hash_8f95fde5");
  self endon("hash_8f95fde5");
  self endon("disconnect");
  while(true) {
    self waittill("weapon_give", weapon);
    weapon = zm_weapons::get_nonalternate_weapon(weapon);
    if(weapon == level.w_microwavegundw || weapon == level.w_microwavegundw_upgraded) {
      self clientfield::set_player_uimodel("hudItems.showDpadLeft_WaveGun", 1);
      self.var_59dcbbd4 = zm_weapons::is_weapon_upgraded(weapon);
      self thread function_1402f75f();
    } else if(!self zm_weapons::has_weapon_or_upgrade(level.w_microwavegundw)) {
      self clientfield::set_player_uimodel("hudItems.showDpadLeft_WaveGun", 0);
      self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", 0);
      self notify("hash_e3517683");
      self.var_59dcbbd4 = undefined;
    }
  }
}

function function_1402f75f() {
  self notify("hash_1402f75f");
  self endon("hash_1402f75f");
  self endon("hash_e3517683");
  self endon("disconnect");
  self.var_db2418ce = 1;
  while(true) {
    if(isDefined(self.var_59dcbbd4)) {
      if(self.var_59dcbbd4) {
        ammocount = self getammocount(level.w_microwavegun_upgraded);
      } else {
        ammocount = self getammocount(level.w_microwavegun);
      }
      self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", ammocount);
    } else {
      self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", 0);
    }
    wait(0.05);
  }
}

function add_microwaveable_object(ent) {
  array::add(level._microwaveable_objects, ent, 0);
}

function remove_microwaveable_object(ent) {
  arrayremovevalue(level._microwaveable_objects, ent);
}

function microwavegun_on_player_connect() {
  for(;;) {
    level waittill("connecting", player);
    player thread wait_for_microwavegun_fired();
  }
}

function wait_for_microwavegun_fired() {
  self endon("disconnect");
  self waittill("spawned_player");
  for(;;) {
    self waittill("weapon_fired");
    currentweapon = self getcurrentweapon();
    if(currentweapon == level.w_microwavegun || currentweapon == level.w_microwavegun_upgraded) {
      self thread microwavegun_fired(currentweapon == level.w_microwavegun_upgraded);
    }
  }
}

function microwavegun_network_choke() {
  level.microwavegun_network_choke_count++;
  if(!level.microwavegun_network_choke_count % 10) {
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
  }
}

function microwavegun_fired(upgraded) {
  if(!isDefined(level.microwavegun_sizzle_enemies)) {
    level.microwavegun_sizzle_enemies = [];
    level.microwavegun_sizzle_vecs = [];
  }
  self microwavegun_get_enemies_in_range(upgraded, 0);
  self microwavegun_get_enemies_in_range(upgraded, 1);
  level.microwavegun_network_choke_count = 0;
  for(i = 0; i < level.microwavegun_sizzle_enemies.size; i++) {
    microwavegun_network_choke();
    level.microwavegun_sizzle_enemies[i] thread microwavegun_sizzle_zombie(self, level.microwavegun_sizzle_vecs[i], i);
  }
  level.microwavegun_sizzle_enemies = [];
  level.microwavegun_sizzle_vecs = [];
}

function microwavegun_get_enemies_in_range(upgraded, microwaveable_objects) {
  view_pos = self getweaponmuzzlepoint();
  test_list = [];
  range = level.zombie_vars["microwavegun_sizzle_range"];
  cylinder_radius = level.zombie_vars["microwavegun_cylinder_radius"];
  if(microwaveable_objects) {
    test_list = level._microwaveable_objects;
    range = range * 10;
    cylinder_radius = cylinder_radius * 10;
  } else {
    test_list = zombie_utility::get_round_enemy_array();
  }
  zombies = util::get_array_of_closest(view_pos, test_list, undefined, undefined, range);
  if(!isDefined(zombies)) {
    return;
  }
  sizzle_range_squared = range * range;
  cylinder_radius_squared = cylinder_radius * cylinder_radius;
  forward_view_angles = self getweaponforwarddir();
  end_pos = view_pos + vectorscale(forward_view_angles, range);
  if(2 == getdvarint("")) {
    near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
    circle(near_circle_pos, cylinder_radius, (1, 0, 0), 0, 0, 100);
    line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
    circle(end_pos, cylinder_radius, (1, 0, 0), 0, 0, 100);
  }
  for(i = 0; i < zombies.size; i++) {
    if(!isDefined(zombies[i]) || (isai(zombies[i]) && !isalive(zombies[i]))) {
      continue;
    }
    test_origin = zombies[i] getcentroid();
    test_range_squared = distancesquared(view_pos, test_origin);
    if(test_range_squared > sizzle_range_squared) {
      zombies[i] microwavegun_debug_print("range", (1, 0, 0));
      return;
    }
    normal = vectornormalize(test_origin - view_pos);
    dot = vectordot(forward_view_angles, normal);
    if(0 > dot) {
      zombies[i] microwavegun_debug_print("dot", (1, 0, 0));
      continue;
    }
    radial_origin = pointonsegmentnearesttopoint(view_pos, end_pos, test_origin);
    if(distancesquared(test_origin, radial_origin) > cylinder_radius_squared) {
      zombies[i] microwavegun_debug_print("cylinder", (1, 0, 0));
      continue;
    }
    if(0 == zombies[i] damageconetrace(view_pos, self)) {
      zombies[i] microwavegun_debug_print("cone", (1, 0, 0));
      continue;
    }
    if(isai(zombies[i])) {
      level.microwavegun_sizzle_enemies[level.microwavegun_sizzle_enemies.size] = zombies[i];
      dist_mult = (sizzle_range_squared - test_range_squared) / sizzle_range_squared;
      sizzle_vec = vectornormalize(test_origin - view_pos);
      if(5000 < test_range_squared) {
        sizzle_vec = sizzle_vec + (vectornormalize(test_origin - radial_origin));
      }
      sizzle_vec = (sizzle_vec[0], sizzle_vec[1], abs(sizzle_vec[2]));
      sizzle_vec = vectorscale(sizzle_vec, 100 + (100 * dist_mult));
      level.microwavegun_sizzle_vecs[level.microwavegun_sizzle_vecs.size] = sizzle_vec;
      continue;
    }
    zombies[i] notify("microwaved", self);
  }
}

function microwavegun_debug_print(msg, color) {
  if(!getdvarint("")) {
    return;
  }
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  print3d(self.origin + vectorscale((0, 0, 1), 60), msg, color, 1, 1, 40);
}

function microwavegun_sizzle_zombie(player, sizzle_vec, index) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.microwavegun_sizzle_func)) {
    self[[self.microwavegun_sizzle_func]](player);
    return;
  }
  self.no_gib = 1;
  self.gibbed = 1;
  self.skipautoragdoll = 1;
  self.microwavegun_death = 1;
  self dodamage(self.health + 666, player.origin, player);
  if(self.health <= 0) {
    points = 10;
    if(!index) {
      points = zm_score::get_zombie_death_player_points();
    } else if(1 == index) {
      points = 30;
    }
    player zm_score::player_add_points("thundergun_fling", points);
    instant_explode = 0;
    if(self.isdog) {
      self.a.nodeath = undefined;
      instant_explode = 1;
    }
    if(isDefined(self.is_traversing) && self.is_traversing || (isDefined(self.in_the_ceiling) && self.in_the_ceiling)) {
      self.deathanim = undefined;
      instant_explode = 1;
    }
    if(instant_explode) {
      if(isDefined(self.animname) && self.animname != "astro_zombie") {
        self thread setup_microwavegun_vox(player);
      }
      self clientfield::set("toggle_microwavegun_expand_response", 1);
      self thread microwavegun_sizzle_death_ending();
    } else {
      if(isDefined(self.animname) && self.animname != "astro_zombie") {
        self thread setup_microwavegun_vox(player, 6);
      }
      self clientfield::set("toggle_microwavegun_hit_response", 1);
      self.nodeathragdoll = 1;
      self.handle_death_notetracks = &microwavegun_handle_death_notetracks;
    }
  }
}

function microwavegun_handle_death_notetracks(note) {
  if(note == "expand") {
    self clientfield::set("toggle_microwavegun_expand_response", 1);
  } else if(note == "explode") {
    self clientfield::set("toggle_microwavegun_expand_response", 0);
    self thread microwavegun_sizzle_death_ending();
  }
}

function microwavegun_sizzle_death_ending() {
  if(!isDefined(self)) {
    return;
  }
  self ghost();
  wait(0.1);
  self zm_utility::self_delete();
}

function microwavegun_dw_zombie_hit_response_internal(mod, damageweapon, player) {
  player endon("disconnect");
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(self.isdog) {
    self.a.nodeath = undefined;
  }
  if(isDefined(self.is_traversing) && self.is_traversing) {
    self.deathanim = undefined;
  }
  self.skipautoragdoll = 1;
  self.microwavegun_dw_death = 1;
  self thread microwavegun_zap_death_fx(damageweapon);
  if(isDefined(self.microwavegun_zap_damage_func)) {
    self[[self.microwavegun_zap_damage_func]](player);
    return;
  }
  self dodamage(self.health + 666, self.origin, player);
  player zm_score::player_add_points("death", "", "");
  if(randomintrange(0, 101) >= 75) {
    player thread zm_audio::create_and_play_dialog("kill", "micro_dual");
  }
}

function microwavegun_zap_get_shock_fx(weapon) {
  if(weapon == getweapon("microwavegundw")) {
    return level._effect["microwavegun_zap_shock_dw"];
  }
  if(weapon == getweapon("microwavegunlh")) {
    return level._effect["microwavegun_zap_shock_lh"];
  }
  return level._effect["microwavegun_zap_shock_ug"];
}

function microwavegun_zap_get_shock_eyes_fx(weapon) {
  if(weapon == getweapon("microwavegundw")) {
    return level._effect["microwavegun_zap_shock_eyes_dw"];
  }
  if(weapon == getweapon("microwavegunlh")) {
    return level._effect["microwavegun_zap_shock_eyes_lh"];
  }
  return level._effect["microwavegun_zap_shock_eyes_ug"];
}

function microwavegun_zap_head_gib(weapon) {
  self endon("death");
  zm_net::network_safe_play_fx_on_tag("microwavegun_zap_death_fx", 2, microwavegun_zap_get_shock_eyes_fx(weapon), self, "J_Eyeball_LE");
}

function microwavegun_zap_death_fx(weapon) {
  tag = "J_SpineUpper";
  if(self.isdog) {
    tag = "J_Spine1";
  }
  zm_net::network_safe_play_fx_on_tag("microwavegun_zap_death_fx", 2, microwavegun_zap_get_shock_fx(weapon), self, tag);
  self playSound("wpn_imp_tesla");
  if(isDefined(self.head_gibbed) && self.head_gibbed) {
    return;
  }
  if(isDefined(self.microwavegun_zap_head_gib_func)) {
    self thread[[self.microwavegun_zap_head_gib_func]](weapon);
  } else if("quad_zombie" != self.animname) {
    self thread microwavegun_zap_head_gib(weapon);
  }
}

function microwavegun_zombie_damage_response(str_mod, str_hit_location, v_hit_origin, e_attacker, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
  if(self is_microwavegun_dw_damage()) {
    self thread microwavegun_dw_zombie_hit_response_internal(str_mod, self.damageweapon, e_attacker);
    return true;
  }
  return false;
}

function microwavegun_zombie_death_response() {
  if(self enemy_killed_by_dw_microwavegun()) {
    if(isDefined(self.attacker) && isDefined(level.hero_power_update)) {
      level thread[[level.hero_power_update]](self.attacker, self);
    }
    return true;
  }
  if(self enemy_killed_by_microwavegun()) {
    if(isDefined(self.attacker) && isDefined(level.hero_power_update)) {
      level thread[[level.hero_power_update]](self.attacker, self);
    }
    return true;
  }
  return false;
}

function is_microwavegun_dw_damage() {
  return isDefined(self.damageweapon) && (self.damageweapon == getweapon("microwavegundw") || self.damageweapon == getweapon("microwavegundw_upgraded") || self.damageweapon == getweapon("microwavegunlh") || self.damageweapon == getweapon("microwavegunlh_upgraded")) && self.damagemod == "MOD_IMPACT";
}

function enemy_killed_by_dw_microwavegun() {
  return isDefined(self.microwavegun_dw_death) && self.microwavegun_dw_death;
}

function is_microwavegun_damage() {
  return isDefined(self.damageweapon) && (self.damageweapon == level.w_microwavegun || self.damageweapon == level.w_microwavegun_upgraded) && (self.damagemod != "MOD_GRENADE" && self.damagemod != "MOD_GRENADE_SPLASH");
}

function enemy_killed_by_microwavegun() {
  return isDefined(self.microwavegun_death) && self.microwavegun_death;
}

function microwavegun_sound_thread() {
  self endon("disconnect");
  self waittill("spawned_player");
  for(;;) {
    result = self util::waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback");
    if(!isDefined(result)) {
      continue;
    }
    if(result == "weapon_change" || result == "grenade_fire" && self getcurrentweapon() == level.w_microwavegun) {
      self playLoopSound("tesla_idle", 0.25);
      continue;
    }
    self notify("weap_away");
    self stoploopsound(0.25);
  }
}

function setup_microwavegun_vox(player, waittime) {
  level notify("force_end_microwave_vox");
  level endon("force_end_microwave_vox");
  if(!isDefined(waittime)) {
    waittime = 0.05;
  }
  wait(waittime);
  if(50 > randomintrange(1, 100) && isDefined(player)) {
    player thread zm_audio::create_and_play_dialog("kill", "micro_single");
  }
}

function function_5c6b11a6(entity) {
  self clientfield::set("toggle_microwavegun_expand_response", 1);
}

function function_f8d8850f(entity) {
  self clientfield::set("toggle_microwavegun_expand_response", 0);
  self thread microwavegun_sizzle_death_ending();
}