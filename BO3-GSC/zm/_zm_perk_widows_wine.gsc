/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_widows_wine.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_pers_upgrades_system;
#using scripts\zm\_zm_powerup_ww_grenade;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_perk_widows_wine;

function autoexec __init__sytem__() {
  system::register("zm_perk_widows_wine", &__init__, undefined, undefined);
}

function __init__() {
  enable_widows_wine_perk_for_level();
}

function enable_widows_wine_perk_for_level() {
  zm_perks::register_perk_basic_info("specialty_widowswine", "widows_wine", 4000, &"ZOMBIE_PERK_WIDOWSWINE", getweapon("zombie_perk_bottle_widows_wine"));
  zm_perks::register_perk_precache_func("specialty_widowswine", &widows_wine_precache);
  zm_perks::register_perk_clientfields("specialty_widowswine", &widows_wine_register_clientfield, &widows_wine_set_clientfield);
  zm_perks::register_perk_machine("specialty_widowswine", &widows_wine_perk_machine_setup);
  zm_perks::register_perk_host_migration_params("specialty_widowswine", "vending_widowswine", "widow_light");
  zm_perks::register_perk_threads("specialty_widowswine", &widows_wine_perk_activate, &widows_wine_perk_lost);
  if(isDefined(level.custom_widows_wine_perk_threads) && level.custom_widows_wine_perk_threads) {
    level thread[[level.custom_widows_wine_perk_threads]]();
  }
  clientfield::register("toplayer", "widows_wine_1p_contact_explosion", 1, 1, "counter");
  init_widows_wine();
}

function widows_wine_precache() {
  if(isDefined(level.widows_wine_precache_override_func)) {
    [[level.widows_wine_precache_override_func]]();
    return;
  }
  level._effect["widow_light"] = "zombie/fx_perk_widows_wine_zmb";
  level._effect["widows_wine_wrap"] = "zombie/fx_widows_wrap_torso_zmb";
  level.machine_assets["specialty_widowswine"] = spawnStruct();
  level.machine_assets["specialty_widowswine"].weapon = getweapon("zombie_perk_bottle_widows_wine");
  level.machine_assets["specialty_widowswine"].off_model = "p7_zm_vending_widows_wine";
  level.machine_assets["specialty_widowswine"].on_model = "p7_zm_vending_widows_wine";
}

function widows_wine_register_clientfield() {
  clientfield::register("clientuimodel", "hudItems.perks.widows_wine", 1, 2, "int");
  clientfield::register("actor", "widows_wine_wrapping", 1, 1, "int");
  clientfield::register("vehicle", "widows_wine_wrapping", 1, 1, "int");
}

function widows_wine_set_clientfield(state) {
  self clientfield::set_player_uimodel("hudItems.perks.widows_wine", state);
}

function widows_wine_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  use_trigger.script_sound = "mus_perks_widow_jingle";
  use_trigger.script_string = "widowswine_perk";
  use_trigger.script_label = "mus_perks_widow_sting";
  use_trigger.target = "vending_widowswine";
  perk_machine.script_string = "widowswine_perk";
  perk_machine.targetname = "vending_widowswine";
  if(isDefined(bump_trigger)) {
    bump_trigger.script_string = "widowswine_perk";
  }
}

function init_widows_wine() {
  zm_utility::register_lethal_grenade_for_level("sticky_grenade_widows_wine");
  zm_spawner::register_zombie_damage_callback(&widows_wine_zombie_damage_response);
  zm_spawner::register_zombie_death_event_callback(&widows_wine_zombie_death_watch);
  zm::register_vehicle_damage_callback(&widows_wine_vehicle_damage_response);
  zm_perks::register_perk_damage_override_func(&widows_wine_damage_callback);
  level.w_widows_wine_grenade = getweapon("sticky_grenade_widows_wine");
  zm_utility::register_melee_weapon_for_level("knife_widows_wine");
  level.w_widows_wine_knife = getweapon("knife_widows_wine");
  zm_utility::register_melee_weapon_for_level("bowie_knife_widows_wine");
  level.w_widows_wine_bowie_knife = getweapon("bowie_knife_widows_wine");
  zm_utility::register_melee_weapon_for_level("sickle_knife_widows_wine");
  level.w_widows_wine_sickle_knife = getweapon("sickle_knife_widows_wine");
}

function widows_wine_perk_activate() {
  if(level.w_widows_wine_grenade == self zm_utility::get_player_lethal_grenade()) {
    return;
  }
  self.w_widows_wine_prev_grenade = self zm_utility::get_player_lethal_grenade();
  self takeweapon(self.w_widows_wine_prev_grenade);
  self giveweapon(level.w_widows_wine_grenade);
  self zm_utility::set_player_lethal_grenade(level.w_widows_wine_grenade);
  self.w_widows_wine_prev_knife = self zm_utility::get_player_melee_weapon();
  if(isDefined(self.widows_wine_knife_override)) {
    self[[self.widows_wine_knife_override]]();
  } else {
    self takeweapon(self.w_widows_wine_prev_knife);
    if(self.w_widows_wine_prev_knife.name == "bowie_knife") {
      self giveweapon(level.w_widows_wine_bowie_knife);
      self zm_utility::set_player_melee_weapon(level.w_widows_wine_bowie_knife);
    } else {
      if(self.w_widows_wine_prev_knife.name == "sickle_knife") {
        self giveweapon(level.w_widows_wine_sickle_knife);
        self zm_utility::set_player_melee_weapon(level.w_widows_wine_sickle_knife);
      } else {
        self giveweapon(level.w_widows_wine_knife);
        self zm_utility::set_player_melee_weapon(level.w_widows_wine_knife);
      }
    }
  }
  assert(!isDefined(self.check_override_wallbuy_purchase) || self.check_override_wallbuy_purchase == (&widows_wine_override_wallbuy_purchase));
  assert(!isDefined(self.check_override_melee_wallbuy_purchase) || self.check_override_melee_wallbuy_purchase == (&widows_wine_override_melee_wallbuy_purchase));
  self.check_override_wallbuy_purchase = &widows_wine_override_wallbuy_purchase;
  self.check_override_melee_wallbuy_purchase = &widows_wine_override_melee_wallbuy_purchase;
  self thread grenade_bounce_monitor();
}

function widows_wine_contact_explosion() {
  self magicgrenadetype(self.current_lethal_grenade, self.origin + vectorscale((0, 0, 1), 48), (0, 0, 0), 0);
  self setweaponammoclip(self.current_lethal_grenade, self getweaponammoclip(self.current_lethal_grenade) - 1);
  self clientfield::increment_to_player("widows_wine_1p_contact_explosion", 1);
}

function widows_wine_zombie_damage_response(str_mod, str_hit_location, v_hit_origin, e_player, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
  if(isDefined(self.damageweapon) && self.damageweapon == level.w_widows_wine_grenade || (str_mod === "MOD_MELEE" && isDefined(e_player) && isplayer(e_player) && e_player hasperk("specialty_widowswine") && randomfloat(1) <= 0.5)) {
    if(!(isDefined(self.no_widows_wine) && self.no_widows_wine)) {
      self thread zm_powerups::check_for_instakill(e_player, str_mod, str_hit_location);
      n_dist_sq = distancesquared(self.origin, v_hit_origin);
      if(n_dist_sq <= 10000) {
        self thread widows_wine_cocoon_zombie(e_player);
      } else {
        self thread widows_wine_slow_zombie(e_player);
      }
      if(!(isDefined(self.no_damage_points) && self.no_damage_points) && isDefined(e_player)) {
        damage_type = "damage";
        e_player zm_score::player_add_points(damage_type, str_mod, str_hit_location, 0, undefined, w_weapon);
      }
      return true;
    }
  }
  return false;
}

function widows_wine_vehicle_damage_response(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(isDefined(weapon) && weapon == level.w_widows_wine_grenade && (!(isDefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon))) {
    if(self.archetype === "parasite") {
      self thread vehicle_stuck_grenade_monitor();
    }
    self thread widows_wine_vehicle_behavior(eattacker, weapon);
    if(!(isDefined(self.no_damage_points) && self.no_damage_points) && isDefined(eattacker)) {
      damage_type = "damage";
      eattacker zm_score::player_add_points(damage_type, smeansofdeath, shitloc, 0, undefined, weapon);
    }
    return 0;
  }
  return idamage;
}

function widows_wine_damage_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
  if(sweapon == level.w_widows_wine_grenade) {
    return 0;
  }
  if(self.current_lethal_grenade == level.w_widows_wine_grenade && self getweaponammoclip(self.current_lethal_grenade) > 0 && !self bgb::is_enabled("zm_bgb_burned_out")) {
    if(smeansofdeath == "MOD_MELEE" && isai(eattacker) || (smeansofdeath == "MOD_EXPLOSIVE" && isvehicle(eattacker))) {
      self thread widows_wine_contact_explosion();
      return idamage;
    }
  }
}

function widows_wine_zombie_death_watch(attacker) {
  if(isDefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon || (isDefined(self.b_widows_wine_slow) && self.b_widows_wine_slow) && (!(isDefined(self.b_widows_wine_no_powerup) && self.b_widows_wine_no_powerup))) {
    if(isDefined(self.attacker) && isplayer(self.attacker) && self.attacker hasperk("specialty_widowswine")) {
      chance = 0.2;
      if(isDefined(self.damageweapon) && self.damageweapon == level.w_widows_wine_grenade) {
        chance = 0.15;
      } else if(isDefined(self.damageweapon) && (self.damageweapon == level.w_widows_wine_knife || self.damageweapon == level.w_widows_wine_bowie_knife || self.damageweapon == level.w_widows_wine_sickle_knife)) {
        chance = 0.25;
      }
      if(randomfloat(1) <= chance) {
        self.no_powerups = 1;
        level._powerup_timeout_override = &powerup_widows_wine_timeout;
        level thread zm_powerups::specific_powerup_drop("ww_grenade", self.origin, undefined, undefined, undefined, self.attacker);
        level._powerup_timeout_override = undefined;
      }
    }
  }
}

function powerup_widows_wine_timeout() {
  self endon("powerup_grabbed");
  self endon("death");
  self endon("powerup_reset");
  self zm_powerups::powerup_show(1);
  wait_time = 1;
  if(isDefined(level._powerup_timeout_custom_time)) {
    time = [[level._powerup_timeout_custom_time]](self);
    if(time == 0) {
      return;
    }
    wait_time = time;
  }
  wait(wait_time);
  for(i = 20; i > 0; i--) {
    if(i % 2) {
      self zm_powerups::powerup_show(0);
    } else {
      self zm_powerups::powerup_show(1);
    }
    if(i > 15) {
      wait(0.3);
    }
    if(i > 10) {
      wait(0.25);
      continue;
    }
    if(i > 5) {
      wait(0.15);
      continue;
    }
    wait(0.1);
  }
  self notify("powerup_timedout");
  self zm_powerups::powerup_delete();
}

function widows_wine_cocoon_zombie_score(e_player, duration, max_score) {
  self notify("widows_wine_cocoon_zombie_score");
  self endon("widows_wine_cocoon_zombie_score");
  self endon("death");
  if(!isDefined(self.ww_points_given)) {
    self.ww_points_given = 0;
  }
  start_time = gettime();
  end_time = start_time + (duration * 1000);
  while(gettime() < end_time && self.ww_points_given < max_score) {
    e_player zm_score::add_to_player_score(10);
    wait(duration / max_score);
  }
}

function widows_wine_cocoon_zombie(e_player) {
  self notify("widows_wine_cocoon");
  self endon("widows_wine_cocoon");
  if(isDefined(self.kill_on_wine_coccon) && self.kill_on_wine_coccon) {
    self kill();
  }
  if(!(isDefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon)) {
    self.b_widows_wine_cocoon = 1;
    self.e_widows_wine_player = e_player;
    if(isDefined(self.widows_wine_cocoon_fraction_rate)) {
      widows_wine_cocoon_fraction_rate = self.widows_wine_cocoon_fraction_rate;
    } else {
      widows_wine_cocoon_fraction_rate = 0.1;
    }
    self asmsetanimationrate(widows_wine_cocoon_fraction_rate);
    self clientfield::set("widows_wine_wrapping", 1);
  }
  if(isDefined(e_player)) {
    self thread widows_wine_cocoon_zombie_score(e_player, 16, 10);
  }
  self util::waittill_any_timeout(16, "death", "widows_wine_cocoon");
  if(!isDefined(self)) {
    return;
  }
  self asmsetanimationrate(1);
  self clientfield::set("widows_wine_wrapping", 0);
  if(isalive(self)) {
    self.b_widows_wine_cocoon = 0;
  }
}

function widows_wine_slow_zombie(e_player) {
  self notify("widows_wine_slow");
  self endon("widows_wine_slow");
  if(isDefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon) {
    self thread widows_wine_cocoon_zombie(e_player);
    return;
  }
  if(isDefined(e_player)) {
    self thread widows_wine_cocoon_zombie_score(e_player, 12, 6);
  }
  if(!(isDefined(self.b_widows_wine_slow) && self.b_widows_wine_slow)) {
    if(isDefined(self.widows_wine_slow_fraction_rate)) {
      widows_wine_slow_fraction_rate = self.widows_wine_slow_fraction_rate;
    } else {
      widows_wine_slow_fraction_rate = 0.7;
    }
    self.b_widows_wine_slow = 1;
    self asmsetanimationrate(widows_wine_slow_fraction_rate);
    self clientfield::set("widows_wine_wrapping", 1);
  }
  self util::waittill_any_timeout(12, "death", "widows_wine_slow");
  if(!isDefined(self)) {
    return;
  }
  self asmsetanimationrate(1);
  self clientfield::set("widows_wine_wrapping", 0);
  if(isalive(self)) {
    self.b_widows_wine_slow = 0;
  }
}

function vehicle_stuck_grenade_monitor() {
  self endon("death");
  self waittill("grenade_stuck", e_grenade);
  e_grenade detonate();
}

function grenade_bounce_monitor() {
  self endon("disconnect");
  self endon("stop_widows_wine");
  while(true) {
    self waittill("grenade_fire", e_grenade);
    e_grenade thread grenade_bounces();
  }
}

function grenade_bounces() {
  self endon("explode");
  self waittill("grenade_bounce", pos, normal, e_target);
  if(isDefined(e_target)) {
    if(e_target.archetype === "parasite" || e_target.archetype === "raps") {
      self detonate();
    }
  }
}

function widows_wine_vehicle_behavior(attacker, weapon) {
  self endon("death");
  self.b_widows_wine_cocoon = 1;
  if(isDefined(self.archetype)) {
    if(self.archetype == "raps") {
      self clientfield::set("widows_wine_wrapping", 1);
      self._override_raps_combat_speed = 5;
      wait(6);
      self dodamage(self.health + 1000, self.origin, attacker, undefined, "none", "MOD_EXPLOSIVE", 0, weapon);
    } else if(self.archetype == "parasite") {
      wait(0.05);
      self dodamage(self.maxhealth, self.origin);
    }
  }
}

function widows_wine_perk_lost(b_pause, str_perk, str_result) {
  self notify("stop_widows_wine");
  self endon("death");
  if(self laststand::player_is_in_laststand()) {
    self waittill("player_revived");
    if(self hasperk("specialty_widowswine")) {
      return;
    }
  }
  self.check_override_wallbuy_purchase = undefined;
  self takeweapon(level.w_widows_wine_grenade);
  if(isDefined(self.w_widows_wine_prev_grenade)) {
    self.lsgsar_lethal = self.w_widows_wine_prev_grenade;
    self giveweapon(self.w_widows_wine_prev_grenade);
    self zm_utility::set_player_lethal_grenade(self.w_widows_wine_prev_grenade);
  } else {
    self zm_utility::init_player_lethal_grenade();
  }
  grenade = self zm_utility::get_player_lethal_grenade();
  self givestartammo(grenade);
  if(isDefined(self.current_melee_weapon) && !issubstr(self.current_melee_weapon.name, "widows_wine")) {
    self.w_widows_wine_prev_knife = self.current_melee_weapon;
  } else {
    if(self.w_widows_wine_prev_knife.name == "bowie_knife") {
      self takeweapon(level.w_widows_wine_bowie_knife);
    } else {
      if(self.w_widows_wine_prev_knife.name == "sickle_knife") {
        self takeweapon(level.w_widows_wine_sickle_knife);
      } else {
        self takeweapon(level.w_widows_wine_knife);
      }
    }
  }
  if(isDefined(self.w_widows_wine_prev_knife)) {
    self giveweapon(self.w_widows_wine_prev_knife);
    self zm_utility::set_player_melee_weapon(self.w_widows_wine_prev_knife);
  } else {
    self zm_utility::init_player_melee_weapon();
  }
}

function widows_wine_override_wallbuy_purchase(weapon, wallbuy) {
  if(zm_utility::is_lethal_grenade(weapon)) {
    wallbuy zm_utility::play_sound_on_ent("no_purchase");
    if(isDefined(level.custom_generic_deny_vo_func)) {
      self[[level.custom_generic_deny_vo_func]]();
    } else {
      self zm_audio::create_and_play_dialog("general", "sigh");
    }
    return true;
  }
  return false;
}

function widows_wine_override_melee_wallbuy_purchase(vo_dialog_id, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon, flourish_fn, wallbuy) {
  if(zm_utility::is_melee_weapon(weapon)) {
    if(self.w_widows_wine_prev_knife != weapon) {
      cost = wallbuy.stub.cost;
      if(self zm_score::can_player_purchase(cost)) {
        if(wallbuy.first_time_triggered == 0) {
          model = getent(wallbuy.target, "targetname");
          if(isDefined(model)) {
            model thread zm_melee_weapon::melee_weapon_show(self);
          } else if(isDefined(wallbuy.clientfieldname)) {
            level clientfield::set(wallbuy.clientfieldname, 1);
          }
          wallbuy.first_time_triggered = 1;
          if(isDefined(wallbuy.stub)) {
            wallbuy.stub.first_time_triggered = 1;
          }
        }
        self zm_score::minus_to_player_score(cost);
        assert(weapon.name == "" || weapon.name == "");
        self.w_widows_wine_prev_knife = weapon;
        if(self.w_widows_wine_prev_knife.name == "bowie_knife") {
          self thread zm_melee_weapon::give_melee_weapon(vo_dialog_id, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon, flourish_fn, wallbuy);
        } else if(self.w_widows_wine_prev_knife.name == "sickle_knife") {
          self thread zm_melee_weapon::give_melee_weapon(vo_dialog_id, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon, flourish_fn, wallbuy);
        }
      } else {
        zm_utility::play_sound_on_ent("no_purchase");
        self zm_audio::create_and_play_dialog("general", "outofmoney", 1);
      }
    }
    return true;
  }
  return false;
}