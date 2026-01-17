/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\aats\_zm_aat_fire_works.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_aat_fire_works;

function autoexec __init__sytem__() {
  system::register("zm_aat_fire_works", &__init__, undefined, "aat");
}

function __init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }
  aat::register("zm_aat_fire_works", 0.1, 0, 20, 10, 1, &result, "t7_hud_zm_aat_fireworks", "wpn_aat_fire_works_plr", &fire_works_zombie_validation);
  clientfield::register("scriptmover", "zm_aat_fire_works", 1, 1, "int");
  zm_spawner::register_zombie_damage_callback(&zm_aat_fire_works_zombie_damage_response);
  zm_spawner::register_zombie_death_event_callback(&zm_aat_fire_works_death_callback);
}

function result(death, attacker, mod, weapon) {
  self fire_works_summon(attacker, weapon);
}

function fire_works_zombie_validation() {
  if(isDefined(self.barricade_enter) && self.barricade_enter) {
    return false;
  }
  if(isDefined(self.is_traversing) && self.is_traversing) {
    return false;
  }
  if(!(isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area) && !isDefined(self.first_node)) {
    return false;
  }
  if(isDefined(self.is_leaping) && self.is_leaping) {
    return false;
  }
  return true;
}

function fire_works_summon(e_player, w_weapon) {
  w_summoned_weapon = e_player getcurrentweapon();
  v_target_zombie_origin = self.origin;
  if(!(isDefined(level.aat["zm_aat_fire_works"].immune_result_direct[self.archetype]) && level.aat["zm_aat_fire_works"].immune_result_direct[self.archetype])) {
    self thread zombie_death_gib(e_player, w_weapon, e_player);
  }
  v_firing_pos = v_target_zombie_origin + vectorscale((0, 0, 1), 56);
  v_start_yaw = vectortoangles(v_firing_pos - v_target_zombie_origin);
  v_start_yaw = (0, v_start_yaw[1], 0);
  mdl_weapon = zm_utility::spawn_weapon_model(w_summoned_weapon, undefined, v_target_zombie_origin, v_start_yaw);
  mdl_weapon.owner = e_player;
  mdl_weapon.b_aat_fire_works_weapon = 1;
  mdl_weapon.allow_zombie_to_target_ai = 1;
  mdl_weapon thread clientfield::set("zm_aat_fire_works", 1);
  mdl_weapon moveto(v_firing_pos, 0.5);
  mdl_weapon waittill("movedone");
  for(i = 0; i < 10; i++) {
    zombie = mdl_weapon zm_aat_fire_works_get_target();
    if(!isDefined(zombie)) {
      v_curr_yaw = (0, randomintrange(0, 360), 0);
      v_target_pos = mdl_weapon.origin + vectorscale(anglesToForward(v_curr_yaw), 40);
    } else {
      v_target_pos = zombie getcentroid();
    }
    mdl_weapon.angles = vectortoangles(v_target_pos - mdl_weapon.origin);
    v_flash_pos = mdl_weapon gettagorigin("tag_flash");
    mdl_weapon dontinterpolate();
    magicbullet(w_summoned_weapon, v_flash_pos, v_target_pos, mdl_weapon);
    util::wait_network_frame();
  }
  mdl_weapon moveto(v_target_zombie_origin, 0.5);
  mdl_weapon waittill("movedone");
  mdl_weapon clientfield::set("zm_aat_fire_works", 0);
  util::wait_network_frame();
  util::wait_network_frame();
  util::wait_network_frame();
  mdl_weapon delete();
  wait(0.25);
}

function zm_aat_fire_works_get_target() {
  a_ai_zombies = array::randomize(getaiteamarray("axis"));
  los_checks = 0;
  for(i = 0; i < a_ai_zombies.size; i++) {
    zombie = a_ai_zombies[i];
    test_origin = zombie getcentroid();
    if(distancesquared(self.origin, test_origin) > 360000) {
      continue;
    }
    if(los_checks < 3 && !zombie damageconetrace(self.origin)) {
      los_checks++;
      continue;
    }
    return zombie;
  }
  if(a_ai_zombies.size) {
    return a_ai_zombies[0];
  }
  return undefined;
}

function zm_aat_fire_works_zombie_damage_response(str_mod, str_hit_location, v_hit_origin, e_attacker, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
  if(isDefined(level.aat["zm_aat_fire_works"].immune_result_indirect[self.archetype]) && level.aat["zm_aat_fire_works"].immune_result_indirect[self.archetype]) {
    return false;
  }
  if(isDefined(e_attacker.b_aat_fire_works_weapon) && e_attacker.b_aat_fire_works_weapon) {
    self thread zombie_death_gib(e_attacker, w_weapon, e_attacker.owner);
    return true;
  }
  return false;
}

function zm_aat_fire_works_death_callback(attacker) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.b_aat_fire_works_weapon) && attacker.b_aat_fire_works_weapon) {
      if(isDefined(attacker.owner)) {
        e_attacking_player = attacker.owner;
      }
    }
  }
}

function zombie_death_gib(e_attacker, w_weapon, e_owner) {
  gibserverutils::gibhead(self);
  if(math::cointoss()) {
    gibserverutils::gibleftarm(self);
  } else {
    gibserverutils::gibrightarm(self);
  }
  gibserverutils::giblegs(self);
  self dodamage(self.health, self.origin, e_attacker, w_weapon, "torso_upper");
  if(isDefined(e_owner) && isplayer(e_owner)) {
    e_owner zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_FIRE_WORKS");
  }
}