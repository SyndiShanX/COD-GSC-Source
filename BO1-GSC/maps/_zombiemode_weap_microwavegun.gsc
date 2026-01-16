/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_weap_microwavegun.gsc
**************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_net;
#using_animtree("generic_human");
init() {
  if(!maps\_zombiemode_weapons::is_weapon_included("microwavegundw_zm")) {
    return;
  }
  PrecacheModel(GetWeaponModel("microwavegunlh_zm"));
  PrecacheModel(GetWeaponModel("microwavegunlh_upgraded_zm"));
  level._ZOMBIE_ACTOR_FLAG_MICROWAVEGUN_INITIAL_HIT_RESPONSE = 6;
  level._ZOMBIE_ACTOR_FLAG_MICROWAVEGUN_EXPAND_RESPONSE = 9;
  maps\_zombiemode_spawner::register_zombie_damage_callback(::microwavegun_zombie_damage_response);
  maps\_zombiemode_spawner::register_zombie_death_animscript_callback(::microwavegun_zombie_death_response);
  set_zombie_var("microwavegun_cylinder_radius", 180);
  set_zombie_var("microwavegun_sizzle_range", 480);
  level._effect["microwavegun_zap_shock_dw"] = loadfx("weapon/microwavegun/fx_zap_shock_dw");
  level._effect["microwavegun_zap_shock_eyes_dw"] = loadfx("weapon/microwavegun/fx_zap_shock_eyes_dw");
  level._effect["microwavegun_zap_shock_lh"] = loadfx("weapon/microwavegun/fx_zap_shock_lh");
  level._effect["microwavegun_zap_shock_eyes_lh"] = loadfx("weapon/microwavegun/fx_zap_shock_eyes_lh");
  level._effect["microwavegun_zap_shock_ug"] = loadfx("weapon/microwavegun/fx_zap_shock_ug");
  level._effect["microwavegun_zap_shock_eyes_ug"] = loadfx("weapon/microwavegun/fx_zap_shock_eyes_ug");
  level._effect["microwavegun_sizzle_blood_eyes"] = loadfx("weapon/microwavegun/fx_sizzle_blood_eyes");
  level._effect["microwavegun_sizzle_death_mist"] = loadfx("weapon/microwavegun/fx_sizzle_mist");
  level._effect["microwavegun_sizzle_death_mist_low_g"] = loadfx("weapon/microwavegun/fx_sizzle_mist_low_g");
  if(!isDefined(level._zombie_microwavegun_zap_death)) {
    level._zombie_microwavegun_zap_death = [];
  }
  level._zombie_microwavegun_zap_death["zombie"] = [];
  level._zombie_microwavegun_zap_death["zombie"][0] = % ai_zombie_tesla_death_a;
  level._zombie_microwavegun_zap_death["zombie"][1] = % ai_zombie_tesla_death_b;
  level._zombie_microwavegun_zap_death["zombie"][2] = % ai_zombie_tesla_death_c;
  level._zombie_microwavegun_zap_death["zombie"][3] = % ai_zombie_tesla_death_d;
  level._zombie_microwavegun_zap_death["zombie"][4] = % ai_zombie_tesla_death_e;
  level._zombie_microwavegun_zap_death["quad_zombie"] = [];
  level._zombie_microwavegun_zap_death["quad_zombie"][0] = % ai_zombie_quad_death_tesla;
  level._zombie_microwavegun_zap_death["quad_zombie"][1] = % ai_zombie_quad_death_tesla_2;
  level._zombie_microwavegun_zap_death["quad_zombie"][2] = % ai_zombie_quad_death_tesla_3;
  level._zombie_microwavegun_zap_death["quad_zombie"][3] = % ai_zombie_quad_death_tesla_4;
  if(!isDefined(level._zombie_microwavegun_zap_crawl_death)) {
    level._zombie_microwavegun_zap_crawl_death = [];
  }
  level._zombie_microwavegun_zap_crawl_death["zombie"] = [];
  level._zombie_microwavegun_zap_crawl_death["zombie"][0] = % ai_zombie_tesla_crawl_death_a;
  level._zombie_microwavegun_zap_crawl_death["zombie"][1] = % ai_zombie_tesla_crawl_death_b;
  level._zombie_microwavegun_zap_crawl_death["quad_zombie"] = [];
  level._zombie_microwavegun_zap_crawl_death["quad_zombie"][0] = % ai_zombie_tesla_crawl_death_a;
  level._zombie_microwavegun_zap_crawl_death["quad_zombie"][1] = % ai_zombie_tesla_crawl_death_b;
  if(!isDefined(level._zombie_microwavegun_sizzle_death)) {
    level._zombie_microwavegun_sizzle_death = [];
  }
  level._zombie_microwavegun_sizzle_death["zombie"] = [];
  level._zombie_microwavegun_sizzle_death["zombie"][0] = % ai_zombie_microwave_death_a;
  level._zombie_microwavegun_sizzle_death["zombie"][1] = % ai_zombie_microwave_death_b;
  level._zombie_microwavegun_sizzle_death["zombie"][2] = % ai_zombie_microwave_death_c;
  level._zombie_microwavegun_sizzle_death["zombie"][3] = % ai_zombie_microwave_death_walking_a;
  level._zombie_microwavegun_sizzle_death["zombie"][4] = % ai_zombie_microwave_death_walking_b;
  level._zombie_microwavegun_sizzle_death["zombie"][5] = % ai_zombie_microwave_death_walking_c;
  level._zombie_microwavegun_sizzle_death["quad_zombie"] = [];
  level._zombie_microwavegun_sizzle_death["quad_zombie"][0] = % ai_zombie_quad_microwave_death_a;
  level._zombie_microwavegun_sizzle_death["quad_zombie"][1] = % ai_zombie_quad_microwave_death_b;
  level._zombie_microwavegun_sizzle_death["quad_zombie"][2] = % ai_zombie_quad_microwave_death_c;
  if(!isDefined(level._zombie_microwavegun_sizzle_crawl_death)) {
    level._zombie_microwavegun_sizzle_crawl_death = [];
  }
  level._zombie_microwavegun_sizzle_crawl_death["zombie"] = [];
  level._zombie_microwavegun_sizzle_crawl_death["zombie"][0] = % ai_zombie_crawl_microwave_death_a;
  level._zombie_microwavegun_sizzle_crawl_death["zombie"][1] = % ai_zombie_crawl_microwave_death_b;
  level._zombie_microwavegun_sizzle_crawl_death["zombie"][2] = % ai_zombie_crawl_microwave_death_c;
  level._zombie_microwavegun_sizzle_crawl_death["zombie"][3] = % ai_zombie_crawl_microwave_death_walking_a;
  level._zombie_microwavegun_sizzle_crawl_death["zombie"][4] = % ai_zombie_crawl_microwave_death_walking_b;
  level._zombie_microwavegun_sizzle_crawl_death["zombie"][5] = % ai_zombie_crawl_microwave_death_walking_c;
  level thread microwavegun_on_player_connect();
  level._microwaveable_objects = [];
}

add_microwaveable_object(ent) {
  level._microwaveable_objects = add_to_array(level._microwaveable_objects, ent, false);
}

remove_microwaveable_object(ent) {
  level._microwaveable_objects = array_remove(level._microwaveable_objects, ent);
}

microwavegun_on_player_connect() {
  for(;;) {
    level waittill("connecting", player);
    player thread wait_for_microwavegun_fired();
  }
}

wait_for_microwavegun_fired() {
  self endon("disconnect");
  self waittill("spawned_player");
  for(;;) {
    self waittill("weapon_fired");
    currentweapon = self GetCurrentWeapon();
    if((currentweapon == "microwavegun_zm") || (currentweapon == "microwavegun_upgraded_zm")) {
      self thread microwavegun_fired(currentweapon == "microwavegun_upgraded_zm");
    }
  }
}

microwavegun_network_choke() {
  level.microwavegun_network_choke_count++;
  if(!(level.microwavegun_network_choke_count % 10)) {
    wait_network_frame();
    wait_network_frame();
    wait_network_frame();
  }
}

microwavegun_fired(upgraded) {
  if(!isDefined(level.microwavegun_sizzle_enemies)) {
    level.microwavegun_sizzle_enemies = [];
    level.microwavegun_sizzle_vecs = [];
  }
  self microwavegun_get_enemies_in_range(upgraded, false);
  self microwavegun_get_enemies_in_range(upgraded, true);
  level.microwavegun_network_choke_count = 0;
  for(i = 0; i < level.microwavegun_sizzle_enemies.size; i++) {
    microwavegun_network_choke();
    level.microwavegun_sizzle_enemies[i] thread microwavegun_sizzle_zombie(self, level.microwavegun_sizzle_vecs[i], i);
  }
  level.microwavegun_sizzle_enemies = [];
  level.microwavegun_sizzle_vecs = [];
}

microwavegun_get_enemies_in_range(upgraded, microwaveable_objects) {
  view_pos = self GetWeaponMuzzlePoint();
  test_list = undefined;
  range = level.zombie_vars["microwavegun_sizzle_range"];
  cylinder_radius = level.zombie_vars["microwavegun_cylinder_radius"];
  if(microwaveable_objects) {
    test_list = level._microwaveable_objects;
    range *= 10;
    cylinder_radius *= 10;
  } else {
    test_list = GetAISpeciesArray("axis", "all");
  }
  zombies = get_array_of_closest(view_pos, test_list, undefined, undefined, range);
  if(!isDefined(zombies)) {
    return;
  }
  sizzle_range_squared = range * range;
  cylinder_radius_squared = cylinder_radius * cylinder_radius;
  forward_view_angles = self GetWeaponForwardDir();
  end_pos = view_pos + vector_scale(forward_view_angles, range);
  for(i = 0; i < zombies.size; i++) {
    if(!isDefined(zombies[i]) || (IsAI(zombies[i]) && !IsAlive(zombies[i]))) {
      continue;
    }
    test_origin = zombies[i] getcentroid();
    test_range_squared = distanceSquared(view_pos, test_origin);
    if(test_range_squared > sizzle_range_squared) {
      zombies[i] microwavegun_debug_print("range", (1, 0, 0));
      return;
    }
    normal = VectorNormalize(test_origin - view_pos);
    dot = VectorDot(forward_view_angles, normal);
    if(0 > dot) {
      zombies[i] microwavegun_debug_print("dot", (1, 0, 0));
      continue;
    }
    radial_origin = PointOnSegmentNearestToPoint(view_pos, end_pos, test_origin);
    if(distanceSquared(test_origin, radial_origin) > cylinder_radius_squared) {
      zombies[i] microwavegun_debug_print("cylinder", (1, 0, 0));
      continue;
    }
    if(0 == zombies[i] DamageConeTrace(view_pos, self)) {
      zombies[i] microwavegun_debug_print("cone", (1, 0, 0));
      continue;
    }
    if(IsAI(zombies[i])) {
      level.microwavegun_sizzle_enemies[level.microwavegun_sizzle_enemies.size] = zombies[i];
      dist_mult = (sizzle_range_squared - test_range_squared) / sizzle_range_squared;
      sizzle_vec = VectorNormalize(test_origin - view_pos);
      if(5000 < test_range_squared) {
        sizzle_vec = sizzle_vec + VectorNormalize(test_origin - radial_origin);
      }
      sizzle_vec = (sizzle_vec[0], sizzle_vec[1], abs(sizzle_vec[2]));
      sizzle_vec = vector_scale(sizzle_vec, 100 + 100 * dist_mult);
      level.microwavegun_sizzle_vecs[level.microwavegun_sizzle_vecs.size] = sizzle_vec;
    } else {
      zombies[i] notify("microwaved", self);
    }
  }
}

microwavegun_debug_print(msg, color) {}
microwavegun_sizzle_zombie(player, sizzle_vec, index) {
  if(!isDefined(self) || !IsAlive(self)) {
    return;
  }
  if(isDefined(self.microwavegun_sizzle_func)) {
    self[[self.microwavegun_sizzle_func]](player);
    return;
  }
  self.no_gib = true;
  self.gibbed = true;
  self DoDamage(self.health + 666, player.origin, player);
  if(self.health <= 0) {
    points = 10;
    if(!index) {
      points = maps\_zombiemode_score::get_zombie_death_player_points();
    } else if(1 == index) {
      points = 30;
    }
    player maps\_zombiemode_score::player_add_points("thundergun_fling", points);
    self.microwavegun_death = true;
    instant_explode = false;
    if(!self.isdog) {
      if(self.has_legs) {
        self.deathanim = random(level._zombie_microwavegun_sizzle_death[self.animname]);
      } else {
        self.deathanim = random(level._zombie_microwavegun_sizzle_crawl_death[self.animname]);
      }
    } else {
      self.a.nodeath = undefined;
      instant_explode = true;
    }
    if(is_true(self.is_traversing) || is_true(self.in_the_ceiling)) {
      self.deathanim = undefined;
      instant_explode = true;
    }
    if(instant_explode) {
      if(isDefined(self.animname) && self.animname != "astro_zombie") {
        self thread setup_microwavegun_vox(player);
      }
      self setclientflag(level._ZOMBIE_ACTOR_FLAG_MICROWAVEGUN_EXPAND_RESPONSE);
      self thread microwavegun_sizzle_death_ending();
    } else {
      if(isDefined(self.animname) && self.animname != "astro_zombie") {
        self thread setup_microwavegun_vox(player, 6);
      }
      self setclientflag(level._ZOMBIE_ACTOR_FLAG_MICROWAVEGUN_INITIAL_HIT_RESPONSE);
      self.nodeathragdoll = true;
      self.handle_death_notetracks = ::microwavegun_handle_death_notetracks;
    }
  }
}

microwavegun_handle_death_notetracks(note) {
  if(note == "expand") {
    self setclientflag(level._ZOMBIE_ACTOR_FLAG_MICROWAVEGUN_EXPAND_RESPONSE);
  } else if(note == "explode") {
    self clearclientflag(level._ZOMBIE_ACTOR_FLAG_MICROWAVEGUN_EXPAND_RESPONSE);
    self thread microwavegun_sizzle_death_ending();
  }
}

microwavegun_sizzle_death_ending() {
  if(!isDefined(self)) {
    return;
  }
  self hide();
  wait(0.1);
  self self_delete();
}

microwavegun_dw_zombie_hit_response_internal(mod, damageweapon, player) {
  player endon("disconnect");
  if(!isDefined(self) || !IsAlive(self)) {
    return;
  }
  if(!self.isdog) {
    if(self.has_legs) {
      self.deathanim = random(level._zombie_microwavegun_zap_death[self.animname]);
    } else {
      self.deathanim = random(level._zombie_microwavegun_zap_crawl_death[self.animname]);
    }
  } else {
    self.a.nodeath = undefined;
  }
  if(is_true(self.is_traversing)) {
    self.deathanim = undefined;
  }
  self.microwavegun_dw_death = true;
  self thread microwavegun_zap_death_fx(damageweapon);
  if(isDefined(self.microwavegun_zap_damage_func)) {
    self[[self.microwavegun_zap_damage_func]](player);
    return;
  } else {
    self DoDamage(self.health + 666, self.origin, player);
  }
  player maps\_zombiemode_score::player_add_points("death", "", "");
  if(randomintrange(0, 101) >= 75) {
    player thread maps\_zombiemode_audio::create_and_play_dialog("kill", "micro_dual");
  }
}

microwavegun_zap_get_shock_fx(weapon) {
  if(weapon == "microwavegundw_zm") {
    return level._effect["microwavegun_zap_shock_dw"];
  } else if(weapon == "microwavegunlh_zm") {
    return level._effect["microwavegun_zap_shock_lh"];
  } else {
    return level._effect["microwavegun_zap_shock_ug"];
  }
}

microwavegun_zap_get_shock_eyes_fx(weapon) {
  if(weapon == "microwavegundw_zm") {
    return level._effect["microwavegun_zap_shock_eyes_dw"];
  } else if(weapon == "microwavegunlh_zm") {
    return level._effect["microwavegun_zap_shock_eyes_lh"];
  } else {
    return level._effect["microwavegun_zap_shock_eyes_ug"];
  }
}

microwavegun_zap_head_gib(weapon) {
  self endon("death");
  network_safe_play_fx_on_tag("microwavegun_zap_death_fx", 2, microwavegun_zap_get_shock_eyes_fx(weapon), self, "J_Eyeball_LE");
}

microwavegun_zap_death_fx(weapon) {
  tag = "J_SpineUpper";
  if(self.isdog) {
    tag = "J_Spine1";
  }
  network_safe_play_fx_on_tag("microwavegun_zap_death_fx", 2, microwavegun_zap_get_shock_fx(weapon), self, tag);
  self playsound("wpn_imp_tesla");
  if(is_true(self.head_gibbed)) {
    return;
  }
  if(isDefined(self.microwavegun_zap_head_gib_func)) {
    self thread[[self.microwavegun_zap_head_gib_func]](weapon);
  } else if("quad_zombie" != self.animname) {
    self thread microwavegun_zap_head_gib(weapon);
  }
}

microwavegun_zombie_damage_response(mod, hit_location, hit_origin, player, amount) {
  if(self is_microwavegun_dw_damage()) {
    self thread microwavegun_dw_zombie_hit_response_internal(mod, self.damageweapon, player);
    return true;
  }
  return false;
}

microwavegun_zombie_death_response() {
  if(self enemy_killed_by_dw_microwavegun()) {
    return true;
  } else if(self enemy_killed_by_microwavegun()) {
    return true;
  }
  return false;
}

is_microwavegun_dw_damage() {
  return isDefined(self.damageweapon) && (self.damageweapon == "microwavegundw_zm" || self.damageweapon == "microwavegundw_upgraded_zm" || self.damageweapon == "microwavegunlh_zm" || self.damageweapon == "microwavegunlh_upgraded_zm") && (self.damagemod == "MOD_IMPACT");
}

enemy_killed_by_dw_microwavegun() {
  return is_true(self.microwavegun_dw_death);
}

is_microwavegun_damage() {
  return isDefined(self.damageweapon) && (self.damageweapon == "microwavegun_zm" || self.damageweapon == "microwavegun_upgraded_zm") && (self.damagemod != "MOD_GRENADE" && self.damagemod != "MOD_GRENADE_SPLASH");
}

enemy_killed_by_microwavegun() {
  return is_true(self.microwavegun_death);
}

microwavegun_sound_thread() {
  self endon("disconnect");
  self waittill("spawned_player");
  for(;;) {
    result = self waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback");
    if(!isDefined(result)) {
      continue;
    }
    if((result == "weapon_change" || result == "grenade_fire") && self GetCurrentWeapon() == "microwavegun_zm") {
      self playLoopSound("tesla_idle", 0.25);
    } else {
      self notify("weap_away");
      self stopLoopSound(0.25);
    }
  }
}

setup_microwavegun_vox(player, waittime) {
  level notify("force_end_microwave_vox");
  level endon("force_end_microwave_vox");
  if(!isDefined(waittime)) {
    waittime = .05;
  }
  wait(waittime);
  if(50 > RandomIntRange(1, 100) && isDefined(player)) {
    player thread maps\_zombiemode_audio::create_and_play_dialog("kill", "micro_single");
  }
}