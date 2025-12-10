/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_electric_cherry.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_pers_upgrades_system;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_perk_electric_cherry;

function autoexec __init__sytem__() {
  system::register("zm_perk_electric_cherry", &__init__, undefined, undefined);
}

function __init__() {
  enable_electric_cherry_perk_for_level();
}

function enable_electric_cherry_perk_for_level() {
  zm_perks::register_perk_basic_info("specialty_electriccherry", "electric_cherry", 10, &"ZOMBIE_PERK_WIDOWSWINE", getweapon("zombie_perk_bottle_cherry"));
  zm_perks::register_perk_precache_func("specialty_electriccherry", &electric_cherry_precache);
  zm_perks::register_perk_clientfields("specialty_electriccherry", &electric_cherry_register_clientfield, &electric_cherry_set_clientfield);
  zm_perks::register_perk_machine("specialty_electriccherry", &electric_cherry_perk_machine_setup);
  zm_perks::register_perk_host_migration_params("specialty_electriccherry", "vending_electriccherry", "electric_cherry_light");
  zm_perks::register_perk_threads("specialty_electriccherry", &electric_cherry_reload_attack, &electric_cherry_perk_lost);
  if(isDefined(level.custom_electric_cherry_perk_threads) && level.custom_electric_cherry_perk_threads) {
    level thread[[level.custom_electric_cherry_perk_threads]]();
  }
  init_electric_cherry();
}

function electric_cherry_precache() {
  if(isDefined(level.electric_cherry_precache_override_func)) {
    [[level.electric_cherry_precache_override_func]]();
    return;
  }
  level._effect["electric_cherry_light"] = "_t6/misc/fx_zombie_cola_revive_on";
  level.machine_assets["specialty_electriccherry"] = spawnStruct();
  level.machine_assets["specialty_electriccherry"].weapon = getweapon("zombie_perk_bottle_cherry");
  level.machine_assets["specialty_electriccherry"].off_model = "p7_zm_vending_nuke";
  level.machine_assets["specialty_electriccherry"].on_model = "p7_zm_vending_nuke";
}

function electric_cherry_register_clientfield() {
  clientfield::register("clientuimodel", "hudItems.perks.electric_cherry", 1, 2, "int");
}

function electric_cherry_set_clientfield(state) {
  self clientfield::set_player_uimodel("hudItems.perks.electric_cherry", state);
}

function electric_cherry_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  use_trigger.script_sound = "mus_perks_stamin_jingle";
  use_trigger.script_string = "marathon_perk";
  use_trigger.script_label = "mus_perks_stamin_sting";
  use_trigger.target = "vending_marathon";
  perk_machine.script_string = "marathon_perk";
  perk_machine.targetname = "vending_marathon";
  if(isDefined(bump_trigger)) {
    bump_trigger.script_string = "marathon_perk";
  }
}

function init_electric_cherry() {
  level._effect["electric_cherry_explode"] = "dlc1/castle/fx_castle_electric_cherry_down";
  level.custom_laststand_func = &electric_cherry_laststand;
  zombie_utility::set_zombie_var("tesla_head_gib_chance", 50);
  clientfield::register("allplayers", "electric_cherry_reload_fx", 1, 2, "int");
  clientfield::register("actor", "tesla_death_fx", 1, 1, "int");
  clientfield::register("vehicle", "tesla_death_fx_veh", 10000, 1, "int");
  clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int");
  clientfield::register("vehicle", "tesla_shock_eyes_fx_veh", 10000, 1, "int");
}

function electric_cherry_perk_machine_think() {
  init_electric_cherry();
  while(true) {
    machine = getEntArray("vendingelectric_cherry", "targetname");
    machine_triggers = getEntArray("vending_electriccherry", "target");
    for(i = 0; i < machine.size; i++) {
      machine[i] setModel("p7_zm_vending_nuke");
    }
    level thread zm_perks::do_initial_power_off_callback(machine, "electriccherry");
    array::thread_all(machine_triggers, &zm_perks::set_power_on, 0);
    level waittill("electric_cherry_on");
    for(i = 0; i < machine.size; i++) {
      machine[i] setModel("p7_zm_vending_nuke");
      machine[i] vibrate(vectorscale((0, -1, 0), 100), 0.3, 0.4, 3);
      machine[i] playSound("zmb_perks_power_on");
      machine[i] thread zm_perks::perk_fx("electriccherry");
      machine[i] thread zm_perks::play_loop_on_machine();
    }
    level notify("specialty_grenadepulldeath_power_on");
    array::thread_all(machine_triggers, &zm_perks::set_power_on, 1);
    level waittill("electric_cherry_off");
    array::thread_all(machine_triggers, &zm_perks::turn_perk_off);
  }
}

function electric_cherry_host_migration_func() {
  a_electric_cherry_perk_machines = getEntArray("vending_electriccherry", "targetname");
  foreach(perk_machine in a_electric_cherry_perk_machines) {
    if(isDefined(perk_machine.model) && perk_machine.model == "p7_zm_vending_nuke") {
      perk_machine zm_perks::perk_fx(undefined, 1);
      perk_machine thread zm_perks::perk_fx("electriccherry");
    }
  }
}

function electric_cherry_laststand() {
  visionsetlaststand("zombie_last_stand", 1);
  if(isDefined(self)) {
    playFX(level._effect["electric_cherry_explode"], self.origin);
    self playSound("zmb_cherry_explode");
    self notify("electric_cherry_start");
    wait(0.05);
    a_zombies = zombie_utility::get_round_enemy_array();
    a_zombies = util::get_array_of_closest(self.origin, a_zombies, undefined, undefined, 500);
    for(i = 0; i < a_zombies.size; i++) {
      if(isalive(self) && isalive(a_zombies[i])) {
        if(a_zombies[i].health <= 1000) {
          a_zombies[i] thread electric_cherry_death_fx();
          if(isDefined(self.cherry_kills)) {
            self.cherry_kills++;
          }
          self zm_score::add_to_player_score(40);
        } else {
          a_zombies[i] thread electric_cherry_stun();
          a_zombies[i] thread electric_cherry_shock_fx();
        }
        wait(0.1);
        a_zombies[i] dodamage(1000, self.origin, self, self, "none");
      }
    }
    self notify("electric_cherry_end");
  }
}

function electric_cherry_death_fx() {
  self endon("death");
  self playSound("zmb_elec_jib_zombie");
  if(!(isDefined(self.head_gibbed) && self.head_gibbed)) {
    if(isvehicle(self)) {
      self clientfield::set("tesla_shock_eyes_fx_veh", 1);
    } else {
      self clientfield::set("tesla_shock_eyes_fx", 1);
    }
  } else {
    if(isvehicle(self)) {
      self clientfield::set("tesla_death_fx_veh", 1);
    } else {
      self clientfield::set("tesla_death_fx", 1);
    }
  }
}

function electric_cherry_shock_fx() {
  self endon("death");
  if(isvehicle(self)) {
    self clientfield::set("tesla_shock_eyes_fx_veh", 1);
  } else {
    self clientfield::set("tesla_shock_eyes_fx", 1);
  }
  self playSound("zmb_elec_jib_zombie");
  self waittill("stun_fx_end");
  if(isvehicle(self)) {
    self clientfield::set("tesla_shock_eyes_fx_veh", 0);
  } else {
    self clientfield::set("tesla_shock_eyes_fx", 0);
  }
}

function electric_cherry_stun() {
  self endon("death");
  self notify("stun_zombie");
  self endon("stun_zombie");
  if(self.health <= 0) {
    iprintln("");
    return;
  }
  if(self.ai_state !== "zombie_think") {
    return;
  }
  self.zombie_tesla_hit = 1;
  self.ignoreall = 1;
  wait(4);
  if(isDefined(self)) {
    self.zombie_tesla_hit = 0;
    self.ignoreall = 0;
    self notify("stun_fx_end");
  }
}

function electric_cherry_reload_attack() {
  self endon("death");
  self endon("disconnect");
  self endon("specialty_electriccherry" + "_stop");
  self.wait_on_reload = [];
  self.consecutive_electric_cherry_attacks = 0;
  while(true) {
    self waittill("reload_start");
    current_weapon = self getcurrentweapon();
    if(isinarray(self.wait_on_reload, current_weapon)) {
      continue;
    }
    self.wait_on_reload[self.wait_on_reload.size] = current_weapon;
    self.consecutive_electric_cherry_attacks++;
    n_clip_current = 1;
    n_clip_max = 10;
    n_fraction = n_clip_current / n_clip_max;
    perk_radius = math::linear_map(n_fraction, 1, 0, 32, 128);
    perk_dmg = math::linear_map(n_fraction, 1, 0, 1, 1045);
    self thread check_for_reload_complete(current_weapon);
    if(isDefined(self)) {
      switch (self.consecutive_electric_cherry_attacks) {
        case 0:
        case 1: {
          n_zombie_limit = undefined;
          break;
        }
        case 2: {
          n_zombie_limit = 8;
          break;
        }
        case 3: {
          n_zombie_limit = 4;
          break;
        }
        case 4: {
          n_zombie_limit = 2;
          break;
        }
        default: {
          n_zombie_limit = 0;
        }
      }
      self thread electric_cherry_cooldown_timer(current_weapon);
      if(isDefined(n_zombie_limit) && n_zombie_limit == 0) {
        continue;
      }
      self thread electric_cherry_reload_fx(n_fraction);
      self notify("electric_cherry_start");
      self playSound("zmb_cherry_explode");
      a_zombies = zombie_utility::get_round_enemy_array();
      a_zombies = util::get_array_of_closest(self.origin, a_zombies, undefined, undefined, perk_radius);
      n_zombies_hit = 0;
      for(i = 0; i < a_zombies.size; i++) {
        if(isalive(self) && isalive(a_zombies[i])) {
          if(isDefined(n_zombie_limit)) {
            if(n_zombies_hit < n_zombie_limit) {
              n_zombies_hit++;
            } else {
              break;
            }
          }
          if(a_zombies[i].health <= perk_dmg) {
            a_zombies[i] thread electric_cherry_death_fx();
            if(isDefined(self.cherry_kills)) {
              self.cherry_kills++;
            }
            self zm_score::add_to_player_score(40);
          } else {
            if(!isDefined(a_zombies[i].is_brutus)) {
              a_zombies[i] thread electric_cherry_stun();
            }
            a_zombies[i] thread electric_cherry_shock_fx();
          }
          wait(0.1);
          if(isDefined(a_zombies[i]) && isalive(a_zombies[i])) {
            a_zombies[i] dodamage(perk_dmg, self.origin, self, self, "none");
          }
        }
      }
      self notify("electric_cherry_end");
    }
  }
}

function electric_cherry_cooldown_timer(current_weapon) {
  self notify("electric_cherry_cooldown_started");
  self endon("electric_cherry_cooldown_started");
  self endon("death");
  self endon("disconnect");
  n_reload_time = 0.25;
  if(self hasperk("specialty_fastreload")) {
    n_reload_time = n_reload_time * getdvarfloat("perk_weapReloadMultiplier");
  }
  n_cooldown_time = n_reload_time + 3;
  wait(n_cooldown_time);
  self.consecutive_electric_cherry_attacks = 0;
}

function check_for_reload_complete(weapon) {
  self endon("death");
  self endon("disconnect");
  self endon("player_lost_weapon_" + weapon.name);
  self thread weapon_replaced_monitor(weapon);
  while(true) {
    self waittill("reload");
    current_weapon = self getcurrentweapon();
    if(current_weapon == weapon) {
      arrayremovevalue(self.wait_on_reload, weapon);
      self notify("weapon_reload_complete_" + weapon.name);
      break;
    }
  }
}

function weapon_replaced_monitor(weapon) {
  self endon("death");
  self endon("disconnect");
  self endon("weapon_reload_complete_" + weapon.name);
  while(true) {
    self waittill("weapon_change");
    primaryweapons = self getweaponslistprimaries();
    if(!isinarray(primaryweapons, weapon)) {
      self notify("player_lost_weapon_" + weapon.name);
      arrayremovevalue(self.wait_on_reload, weapon);
      break;
    }
  }
}

function electric_cherry_reload_fx(n_fraction) {
  if(n_fraction >= 0.67) {
    codesetclientfield(self, "electric_cherry_reload_fx", 1);
  } else {
    if(n_fraction >= 0.33 && n_fraction < 0.67) {
      codesetclientfield(self, "electric_cherry_reload_fx", 2);
    } else {
      codesetclientfield(self, "electric_cherry_reload_fx", 3);
    }
  }
  wait(1);
  codesetclientfield(self, "electric_cherry_reload_fx", 0);
}

function electric_cherry_perk_lost(b_pause, str_perk, str_result) {
  self notify("specialty_electriccherry" + "_stop");
}