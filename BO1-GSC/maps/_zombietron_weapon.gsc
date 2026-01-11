/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_weapon.gsc
***************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombietron_utility;

main() {
  init_tesla();
}
#using_animtree("generic_human");
init_tesla() {
  level._effect["tesla_bolt"] = loadfx("maps/zombie/fx_zombie_tesla_bolt_secondary");
  level._effect["tesla_shock"] = loadfx("maps/zombie/fx_zombie_tesla_shock");
  level._effect["tesla_shock_secondary"] = loadfx("maps/zombie/fx_zombie_tesla_shock_secondary");
  level._effect["tesla_shock_eyes"] = loadfx("maps/zombie/fx_zombie_tesla_shock_eyes");
  level._effect["tesla_head_light"] = LoadFX("maps/zombie/fx_zombie_tesla_neck_spurt");
  level._effect["tesla_contact"] = LoadFX("env/electrical/fx_elec_burst_shower_lg_os");
  if(!isDefined(level._zombie_tesla_death)) {
    level._zombie_tesla_death = [];
  }
  level._zombie_tesla_death["zombie"] = [];
  level._zombie_tesla_death["zombie"][0] = % ai_zombie_tesla_death_a;
  level._zombie_tesla_death["zombie"][1] = % ai_zombie_tesla_death_b;
  level._zombie_tesla_death["zombie"][2] = % ai_zombie_tesla_death_c;
  level._zombie_tesla_death["zombie"][3] = % ai_zombie_tesla_death_d;
  level._zombie_tesla_death["zombie"][4] = % ai_zombie_tesla_death_e;
  if(!isDefined(level._zombie_tesla_crawl_death)) {
    level._zombie_tesla_crawl_death = [];
  }
  level._zombie_tesla_crawl_death["zombie"] = [];
  level._zombie_tesla_crawl_death["zombie"][0] = % ai_zombie_tesla_crawl_death_a;
  level._zombie_tesla_crawl_death["zombie"][1] = % ai_zombie_tesla_crawl_death_b;
  set_zombie_var("tesla_max_arcs", 5);
  set_zombie_var("tesla_max_enemies_killed", 20);
  set_zombie_var("tesla_radius_start", 300);
  set_zombie_var("tesla_radius_decay", 20);
  set_zombie_var("tesla_head_gib_chance", 50);
  set_zombie_var("tesla_arc_travel_time", 0.5, true);
  set_zombie_var("tesla_kills_for_powerup", 15);
  set_zombie_var("tesla_min_fx_distance", 128);
  set_zombie_var("tesla_network_death_choke", 4);
  level thread on_player_connect();
}
on_player_connect() {
  for(;;) {
    level waittill("connecting", player);
    player thread tesla_network_choke();
    player thread tesla_discharge_mechanic();
  }
}
tesla_discharge_mechanic() {
  self endon("disconnect");
  while(1) {
    self.tesla_discharge = 1;
    self waittill("tesla_discharged");
    self.tesla_discharge = 0;
    wait 2;
  }
}
tesla_ok_to_discharge(player) {
  if(!isDefined(player.tesla_discharge)) {
    return true;
  }
  if(player.tesla_discharge == 0) {
    return false;
  }
  return true;
}
tesla_damage_init(player) {
  player endon("disconnect");
  player endon("death");
  if(!tesla_ok_to_discharge(player)) {
    return;
  }
  if(isDefined(self.zombie_tesla_hit) && self.zombie_tesla_hit) {
    return;
  }
  player.tesla_enemies = undefined;
  player.tesla_enemies_hit = 1;
  player.tesla_powerup_dropped = false;
  player.tesla_arc_count = 0;
  player notify("tesla_discharged");
  playFXOnTag(level._effect["tesla_contact"], self, "j_head");
  if(isDefined(self.boss) && self.boss == true) {} else {
    self tesla_arc_damage(self, player, 1);
  }
  player.tesla_enemies_hit = 0;
}
tesla_arc_damage(source_enemy, player, arc_num) {
  player endon("disconnect");
  player endon("death");
  tesla_flag_hit(self, true);
  wait_network_frame();
  radius_decay = level.zombie_vars["tesla_radius_decay"] * arc_num;
  enemies = tesla_get_enemies_in_area(self GetTagOrigin("j_head"), level.zombie_vars["tesla_radius_start"] - radius_decay, player);
  tesla_flag_hit(enemies, true);
  self thread tesla_do_damage(source_enemy, arc_num, player);
  for(i = 0; i < enemies.size; i++) {
    if(enemies[i] == self) {
      continue;
    }
    if(isDefined(enemies[i].boss) && enemies[i].boss == true) {
      continue;
    }
    if(tesla_end_arc_damage(arc_num + 1, player.tesla_enemies_hit)) {
      tesla_flag_hit(enemies[i], false);
      continue;
    }
    player.tesla_enemies_hit++;
    enemies[i] tesla_arc_damage(self, player, arc_num + 1);
  }
}
tesla_end_arc_damage(arc_num, enemies_hit_num) {
  if(arc_num >= level.zombie_vars["tesla_max_arcs"]) {
    return true;
  }
  if(enemies_hit_num >= level.zombie_vars["tesla_max_enemies_killed"]) {
    return true;
  }
  radius_decay = level.zombie_vars["tesla_radius_decay"] * arc_num;
  if(level.zombie_vars["tesla_radius_start"] - radius_decay <= 0) {
    return true;
  }
  return false;
}
tesla_get_enemies_in_area(origin, distance, player) {
  distance_squared = distance * distance;
  enemies = [];
  if(!isDefined(player.tesla_enemies)) {
    player.tesla_enemies = GetAiSpeciesArray("axis", "all");
    player.tesla_enemies = get_array_of_closest(origin, player.tesla_enemies);
  }
  zombies = player.tesla_enemies;
  if(isDefined(zombies)) {
    for(i = 0; i < zombies.size; i++) {
      if(!isDefined(zombies[i])) {
        continue;
      }
      test_origin = zombies[i] GetTagOrigin("j_head");
      if(isDefined(zombies[i].zombie_tesla_hit) && zombies[i].zombie_tesla_hit == true) {
        continue;
      }
      if(DistanceSquared(origin, test_origin) > distance_squared) {
        continue;
      }
      if(!BulletTracePassed(origin, test_origin, false, undefined)) {
        continue;
      }
      enemies[enemies.size] = zombies[i];
    }
  }
  return enemies;
}
tesla_flag_hit(enemy, hit) {
  if(!isDefined(enemy)) {
    return;
  }
  if(IsArray(enemy)) {
    for(i = 0; i < enemy.size; i++) {
      enemy[i].zombie_tesla_hit = hit;
    }
  } else {
    enemy.zombie_tesla_hit = hit;
  }
}
tesla_do_damage(source_enemy, arc_num, player) {
  player endon("disconnect");
  if(arc_num > 1) {
    wait(RandomFloat(0.2, 0.6) * arc_num);
  }
  if(!isDefined(self) || !IsAlive(self)) {
    return;
  }
  if(!self.isdog) {
    if(self.has_legs) {
      self.deathanim = random(level._zombie_tesla_death[self.animname]);
    } else {
      self.deathanim = random(level._zombie_tesla_crawl_death[self.animname]);
    }
  } else {
    self.a.nodeath = undefined;
  }
  if(source_enemy != self) {
    if(player.tesla_arc_count > 3) {
      wait_network_frame();
      player.tesla_arc_count = 0;
    }
    player.tesla_arc_count++;
    source_enemy tesla_play_arc_fx(self);
  }
  if(!isDefined(self) || !IsAlive(self)) {
    return;
  }
  self.tesla_death = true;
  self tesla_play_death_fx(arc_num);
  origin = source_enemy.origin;
  if(source_enemy == self || !isDefined(origin)) {
    origin = player.origin;
  }
  if(!isDefined(self) || !IsAlive(self)) {
    return;
  }
  if(isDefined(self.tesla_damage_func)) {
    self[[self.tesla_damage_func]](origin, player);
  } else {
    self DoDamage(self.health + 666, origin, player);
  }
}
tesla_play_death_fx(arc_num) {
  tag = "J_SpineUpper";
  fx = "tesla_shock";
  if(self.isdog) {
    tag = "J_Spine1";
  }
  if(arc_num > 1) {
    fx = "tesla_shock_secondary";
  }
  network_safe_play_fx_on_tag("tesla_death_fx", 2, level._effect[fx], self, tag);
  self playSound("zmb_pwup_coco_impact");
  if(isDefined(self.tesla_head_gib_func)) {
    [[self.tesla_head_gib_func]]();
  }
}
tesla_play_arc_fx(target) {
  if(!isDefined(self) || !isDefined(target)) {
    wait(level.zombie_vars["tesla_arc_travel_time"]);
    return;
  }
  tag = "J_SpineUpper";
  if(self.isdog) {
    tag = "J_Spine1";
  }
  target_tag = "J_SpineUpper";
  if(target.isdog) {
    target_tag = "J_Spine1";
  }
  origin = self GetTagOrigin(tag);
  target_origin = target GetTagOrigin(target_tag);
  distance_squared = level.zombie_vars["tesla_min_fx_distance"] * level.zombie_vars["tesla_min_fx_distance"];
  if(DistanceSquared(origin, target_origin) < distance_squared) {
    return;
  }
  fxOrg = spawn("script_model", origin);
  fxOrg setModel("tag_origin");
  fx = playFXOnTag(level._effect["tesla_bolt"], fxOrg, "tag_origin");
  playsoundatposition("zmb_pwup_coco_bounce", fxOrg.origin);
  fxOrg MoveTo(target_origin, level.zombie_vars["tesla_arc_travel_time"]);
  fxOrg waittill("movedone");
  fxOrg delete();
}
tesla_gun_exists() {
  return 1;
}
tesla_debug_arc(origin, distance) {}
enemy_killed_by_tesla() {
  return (isDefined(self.tesla_death) && self.tesla_death == true);
}
tesla_pvp_thread() {
  self endon("disconnect");
  self endon("death");
  self waittill("spawned_player");
  for(;;) {
    self waittill("weapon_pvp_attack", attacker, weapon, damage, mod);
    if(self maps\_laststand::player_is_in_laststand()) {
      continue;
    }
    if(weapon != "tesla_gun_zm" && weapon != "tesla_gun_upgraded_zm") {
      continue;
    }
    if(mod != "MOD_PROJECTILE" && mod != "MOD_PROJECTILE_SPLASH") {
      continue;
    }
    if(self == attacker) {
      damage = int(self.maxhealth * .25);
      if(damage < 25) {
        damage = 25;
      }
      if(self.health - damage < 1) {
        self.health = 1;
      } else {
        self.health -= damage;
      }
    }
    self setelectrified(1.0);
    self shellshock("electrocution", 1.0);
    self playSound("zmb_pwup_coco_bounce");
  }
}
tesla_network_choke() {
  self endon("disconnect");
  self endon("death");
  self waittill("spawned_player");
  self.tesla_network_death_choke = 0;
  for(;;) {
    wait_network_frame();
    wait_network_frame();
    self.tesla_network_death_choke = 0;
  }
}
�