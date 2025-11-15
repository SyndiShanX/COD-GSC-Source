/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_tesla.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_tesla;
#using scripts\zm\_zm_weapons;
#namespace _zm_weap_tesla;

function init() {
  level.weaponzmteslagun = getweapon("tesla_gun");
  level.weaponzmteslagunupgraded = getweapon("tesla_gun_upgraded");
  if(!zm_weapons::is_weapon_included(level.weaponzmteslagun) && (!(isDefined(level.uses_tesla_powerup) && level.uses_tesla_powerup))) {
    return;
  }
  level._effect["tesla_viewmodel_rail"] = "zombie/fx_tesla_rail_view_zmb";
  level._effect["tesla_viewmodel_tube"] = "zombie/fx_tesla_tube_view_zmb";
  level._effect["tesla_viewmodel_tube2"] = "zombie/fx_tesla_tube_view2_zmb";
  level._effect["tesla_viewmodel_tube3"] = "zombie/fx_tesla_tube_view3_zmb";
  level._effect["tesla_viewmodel_rail_upgraded"] = "zombie/fx_tesla_rail_view_ug_zmb";
  level._effect["tesla_viewmodel_tube_upgraded"] = "zombie/fx_tesla_tube_view_ug_zmb";
  level._effect["tesla_viewmodel_tube2_upgraded"] = "zombie/fx_tesla_tube_view2_ug_zmb";
  level._effect["tesla_viewmodel_tube3_upgraded"] = "zombie/fx_tesla_tube_view3_ug_zmb";
  level._effect["tesla_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
  zm::register_zombie_damage_override_callback( & tesla_zombie_damage_response);
  zm_spawner::register_zombie_death_animscript_callback( & tesla_zombie_death_response);
  zombie_utility::set_zombie_var("tesla_max_arcs", 5);
  zombie_utility::set_zombie_var("tesla_max_enemies_killed", 10);
  zombie_utility::set_zombie_var("tesla_radius_start", 300);
  zombie_utility::set_zombie_var("tesla_radius_decay", 20);
  zombie_utility::set_zombie_var("tesla_head_gib_chance", 75);
  zombie_utility::set_zombie_var("tesla_arc_travel_time", 0.11, 1);
  zombie_utility::set_zombie_var("tesla_kills_for_powerup", 10);
  zombie_utility::set_zombie_var("tesla_min_fx_distance", 128);
  zombie_utility::set_zombie_var("tesla_network_death_choke", 4);
  level.tesla_lightning_params = lightning_chain::create_lightning_chain_params(level.zombie_vars["tesla_max_arcs"], level.zombie_vars["tesla_max_enemies_killed"], level.zombie_vars["tesla_radius_start"], level.zombie_vars["tesla_radius_decay"], level.zombie_vars["tesla_head_gib_chance"], level.zombie_vars["tesla_arc_travel_time"], level.zombie_vars["tesla_kills_for_powerup"], level.zombie_vars["tesla_min_fx_distance"], level.zombie_vars["tesla_network_death_choke"], undefined, undefined, "wpn_tesla_bounce");
  level thread tesla_devgui_dvar_think();
  callback::on_spawned( & on_player_spawned);
}

function tesla_devgui_dvar_think() {
  if(!zm_weapons::is_weapon_included(level.weaponzmteslagun)) {
    return;
  }
  setdvar("", level.zombie_vars[""]);
  setdvar("", level.zombie_vars[""]);
  setdvar("", level.zombie_vars[""]);
  setdvar("", level.zombie_vars[""]);
  setdvar("", level.zombie_vars[""]);
  setdvar("", level.zombie_vars[""]);
  for(;;) {
    level.zombie_vars[""] = getdvarint("");
    level.zombie_vars[""] = getdvarint("");
    level.zombie_vars[""] = getdvarint("");
    level.zombie_vars[""] = getdvarint("");
    level.zombie_vars[""] = getdvarint("");
    level.zombie_vars[""] = getdvarfloat("");
    wait(0.5);
  }
}

function tesla_damage_init(hit_location, hit_origin, player) {
  player endon("disconnect");
  if(isDefined(player.tesla_firing) && player.tesla_firing) {
    zm_utility::debug_print(("TESLA: Player: '" + player.name) + "' currently processing tesla damage");
    return;
  }
  if(isDefined(self.zombie_tesla_hit) && self.zombie_tesla_hit) {
    return;
  }
  zm_utility::debug_print(("TESLA: Player: '" + player.name) + "' hit with the tesla gun");
  player.tesla_enemies = undefined;
  player.tesla_enemies_hit = 1;
  player.tesla_powerup_dropped = 0;
  player.tesla_arc_count = 0;
  player.tesla_firing = 1;
  self lightning_chain::arc_damage(self, player, 1, level.tesla_lightning_params);
  if(player.tesla_enemies_hit >= 4) {
    player thread tesla_killstreak_sound();
  }
  player.tesla_enemies_hit = 0;
  player.tesla_firing = 0;
}

function is_tesla_damage(mod, weapon) {
  return weapon == level.weaponzmteslagun || weapon == level.weaponzmteslagunupgraded && (mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH");
}

function enemy_killed_by_tesla() {
  return isDefined(self.tesla_death) && self.tesla_death;
}

function on_player_spawned() {
  self thread tesla_sound_thread();
  self thread tesla_pvp_thread();
  self thread tesla_network_choke();
}

function tesla_sound_thread() {
  self endon("disconnect");
  for(;;) {
    result = self util::waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback", "disconnect");
    if(!isDefined(result)) {
      continue;
    }
    if(result == "weapon_change" || result == "grenade_fire" && (self getcurrentweapon() == level.weaponzmteslagun || self getcurrentweapon() == level.weaponzmteslagunupgraded)) {
      if(!isDefined(self.tesla_loop_sound)) {
        self.tesla_loop_sound = spawn("script_origin", self.origin);
        self.tesla_loop_sound linkto(self);
        self thread cleanup_loop_sound(self.tesla_loop_sound);
      }
      self.tesla_loop_sound playLoopSound("wpn_tesla_idle", 0.25);
      self thread tesla_engine_sweets();
      continue;
    }
    self notify("weap_away");
    if(isDefined(self.tesla_loop_sound)) {
      self.tesla_loop_sound stoploopsound(0.25);
    }
  }
}

function cleanup_loop_sound(loop_sound) {
  self waittill("disconnect");
  if(isDefined(loop_sound)) {
    loop_sound delete();
  }
}

function tesla_engine_sweets() {
  self endon("disconnect");
  self endon("weap_away");
  while(true) {
    wait(randomintrange(7, 15));
    self play_tesla_sound("wpn_tesla_sweeps_idle");
  }
}

function tesla_pvp_thread() {
  self endon("disconnect");
  self endon("death");
  for(;;) {
    self waittill("weapon_pvp_attack", attacker, weapon, damage, mod);
    if(self laststand::player_is_in_laststand()) {
      continue;
    }
    if(weapon != level.weaponzmteslagun && weapon != level.weaponzmteslagunupgraded) {
      continue;
    }
    if(mod != "MOD_PROJECTILE" && mod != "MOD_PROJECTILE_SPLASH") {
      continue;
    }
    if(self == attacker) {
      damage = int(self.maxhealth * 0.25);
      if(damage < 25) {
        damage = 25;
      }
      if((self.health - damage) < 1) {
        self.health = 1;
      } else {
        self.health = self.health - damage;
      }
    }
    self setelectrified(1);
    self shellshock("electrocution", 1);
    self playSound("wpn_tesla_bounce");
  }
}

function play_tesla_sound(emotion) {
  self endon("disconnect");
  if(!isDefined(level.one_emo_at_a_time)) {
    level.one_emo_at_a_time = 0;
    level.var_9533aed = 0;
  }
  if(level.one_emo_at_a_time == 0) {
    level.var_9533aed++;
    level.one_emo_at_a_time = 1;
    org = spawn("script_origin", self.origin);
    org linkto(self);
    org playsoundwithnotify(emotion, ("sound_complete" + "_") + level.var_9533aed);
    org waittill(("sound_complete" + "_") + level.var_9533aed);
    org delete();
    level.one_emo_at_a_time = 0;
  }
}

function tesla_killstreak_sound() {
  self endon("disconnect");
  self zm_audio::create_and_play_dialog("kill", "tesla");
  wait(3.5);
  level util::clientnotify("TGH");
}

function tesla_network_choke() {
  self endon("disconnect");
  self endon("death");
  self.tesla_network_death_choke = 0;
  for(;;) {
    util::wait_network_frame();
    util::wait_network_frame();
    self.tesla_network_death_choke = 0;
  }
}

function tesla_zombie_death_response() {
  if(self enemy_killed_by_tesla()) {
    return true;
  }
  return false;
}

function tesla_zombie_damage_response(willbekilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(self is_tesla_damage(meansofdeath, weapon)) {
    self thread tesla_damage_init(shitloc, vpoint, attacker);
    return true;
  }
  return false;
}