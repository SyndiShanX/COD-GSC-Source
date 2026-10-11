/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_11ef10bf1824d82b.gsc
*************************************************/

#using script_405d05c89e998922;
#using script_595089f78ef8e11b;
#using script_686729055b66c6e4;
#using scripts\aitypes\bt_util;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace zombie_base_abom_crawler;

function init_zombie_base_abom_crawler() {
  if(flag("init_zombie_base_abom_crawler")) {
    return;
  }

  flag_set("init_zombie_base_abom_crawler");
  callback::add("on_zombie_base_abom_crawler_spawned", &on_zombie_base_abom_crawler_spawned);
  callback::add("on_zombie_base_abom_crawler_hvt_spawned", &on_zombie_base_abom_crawler_spawned);
  callback::add("on_zombie_base_abom_crawler_nest_spawned", &on_zombie_base_abom_crawler_spawned);
  level._effect["zombie_base_abom_crawler_explode"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_megabomb_crawler_exp.vfx");
  level._effect["zombie_base_abom_crawler_aoe"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_megabomb_crawler_aoe.vfx");
}

function private on_zombie_base_abom_crawler_spawned(params) {
  thread_on_notify("bmeleestarted", &function_322d8cb834021eb0);
  thread_on_notify("explode_death", &function_ec481db6f0a4e653);
  callback::add("on_zombie_ai_damaged", &function_13da6f593406ec4d);
  self.var_fe9174386ff8b1f = 1;
  namespace_9e6ef02d993a7eba::set_crawling(1);
  thread wander_listener();
}

function private function_13da6f593406ec4d(dmg_struct) {
  if(isDefined(dmg_struct.smeansofdeath) && dmg_struct.smeansofdeath == "MOD_EXPLOSIVE" || dmg_struct.smeansofdeath == "MOD_EXPLOSIVE_BULLET" || dmg_struct.smeansofdeath == "MOD_GRENADE_SPLASH" || dmg_struct.smeansofdeath == "MOD_PROJECTILE_SPLASH") {
    function_ec481db6f0a4e653();
  }
}

function private function_322d8cb834021eb0() {
  self notify("ambientvoxshutdown");
  utility::function_3ab9164ef76940fd("explode", "charge");
  utility::function_3ab9164ef76940fd("audio_explode", "rise");
}

function private function_ec481db6f0a4e653() {
  self notify("ambientvoxshutdown");
  playFX(level._effect["zombie_base_abom_crawler_explode"], self.origin);
  playFX(level._effect["zombie_base_abom_crawler_aoe"], self.origin);
  utility::function_3ab9164ef76940fd("audio_explode", "explode");
  thread function_5b62af1eb5b04cc9(self.origin, self.team);
  wait 0.2;
  self.nocorpse = 1;
  self kill();
}

function private function_5b62af1eb5b04cc9(position, friendly_team) {
  damage_source = spawn_script_origin();
  time_interval = 0.5;
  var_4806892e9b0b79ef = 3.5;
  aoe_radius = self.zombieaisettings.var_e58a65b7a8f5973c.explosionradius;
  damage_tick = self.zombieaisettings.var_e58a65b7a8f5973c.damagetick;
  initial_damage = self.zombieaisettings.var_e58a65b7a8f5973c.var_7513f0bfecf33e43;
  time_counter = 0;

  while(time_counter <= var_4806892e9b0b79ef) {
    if(function_8320c7d13584d021()) {
      sphere(position, aoe_radius, (1, 0, 0));
    }

    target_query = physics_querypoint(position, aoe_radius, physics_createcontents(["physicscontents_characterproxy"]), [self], "physicsquery_all");

    foreach(potential_target in target_query) {
      target_ent = potential_target["entity"];

      if(!isalive(target_ent) || target_ent.team == friendly_team) {
        continue;
      }

      if(isai(potential_target)) {
        if(potential_target.type == "zombie") {
          potential_target namespace_ed7c38f3847343dc::stun_ai(time_interval);
        }
      }

      damage = ter_op(time_counter == 0, initial_damage, damage_tick);
      target_ent dodamage(damage, position, damage_source);
    }

    wait time_interval;
    time_counter += time_interval;
  }

  damage_source delete();
}

function private wander_listener() {
  self endon("death");

  while(true) {
    self waittill("wander_start");
    self._blackboard.zombiewanderorigin = self.origin;
    thread function_3ef8c54a29b98522();
    self waittill("wander_end");
  }
}

function private function_3ef8c54a29b98522() {
  self endon("death");
  self endon("wander_end");
  search_time = 10;
  wait search_time;

  if(isDefined(self.abom_parent)) {
    var_15ac5500f542090d = distance2dsquared(self.abom_parent.origin, self.origin);
    var_62733f9f4971379d = 1500;

    if(var_15ac5500f542090d > var_62733f9f4971379d * var_62733f9f4971379d) {
      self kill();
    }

    self._blackboard.zombiewanderorigin = self.abom_parent.origin;
  }
}

function private function_6e789d7df8701ad3() {
  ambient_cap = 3;
  self endon("death");
  self endon("ambientvoxshutdown");
  wait randomfloatrange(1, 3);
  played_vox = 0;

  while(true) {
    if(isDefined(self.movemode) && self.movemode == "stop") {
      wait 1;
      continue;
    }

    if(isDefined(level.zombie_ambient_count)) {
      level.zombie_ambient_count++;

      if(level.zombie_ambient_count < ambient_cap) {
        played_vox = 1;
        level thread play_vox(self, "ambient_normal", "vox_ai_abom_crawl_ambient", 1);
      }
    }

    if(played_vox) {
      played_vox = 0;
      wait randomfloatrange(0.1, 0.3);
      continue;
    }

    wait 0.1;
  }
}

function private function_8320c7d13584d021() {
  return getdvarint(@ "hash_1b61c9ce76ad3a4e", 0) > 0;
}

# /