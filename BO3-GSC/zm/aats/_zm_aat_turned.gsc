/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\aats\_zm_aat_turned.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\table_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_aat_turned;

function autoexec __init__sytem__() {
  system::register("zm_aat_turned", & __init__, undefined, "aat");
}

function __init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }
  aat::register("zm_aat_turned", 0.15, 0, 15, 8, 0, & result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", & turned_zombie_validation);
  clientfield::register("actor", "zm_aat_turned", 1, 1, "int");
}

function result(death, attacker, mod, weapon) {
  self thread clientfield::set("zm_aat_turned", 1);
  self thread zombie_death_time_limit(attacker);
  self.team = "allies";
  self.aat_turned = 1;
  self.n_aat_turned_zombie_kills = 0;
  self.allowdeath = 0;
  self.allowpain = 0;
  self.no_gib = 1;
  self zombie_utility::set_zombie_run_cycle("sprint");
  if(math::cointoss()) {
    if(self.zombie_arms_position == "up") {
      self.variant_type = 6;
    } else {
      self.variant_type = 7;
    }
  } else {
    if(self.zombie_arms_position == "up") {
      self.variant_type = 7;
    } else {
      self.variant_type = 8;
    }
  }
  if(isDefined(attacker) && isplayer(attacker)) {
    attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_TURNED");
  }
  self thread turned_local_blast(attacker);
  self thread zombie_kill_tracker(attacker);
}

function turned_local_blast(attacker) {
  v_turned_blast_pos = self.origin;
  a_ai_zombies = array::get_all_closest(v_turned_blast_pos, getaiteamarray("axis"), undefined, undefined, 90);
  if(!isDefined(a_ai_zombies)) {
    return;
  }
  f_turned_range_sq = 8100;
  n_flung_zombies = 0;
  for(i = 0; i < a_ai_zombies.size; i++) {
    if(!isDefined(a_ai_zombies[i]) || !isalive(a_ai_zombies[i])) {
      continue;
    }
    if(isDefined(level.aat["zm_aat_turned"].immune_result_indirect[a_ai_zombies[i].archetype]) && level.aat["zm_aat_turned"].immune_result_indirect[a_ai_zombies[i].archetype]) {
      continue;
    }
    if(a_ai_zombies[i] == self) {
      continue;
    }
    v_curr_zombie_origin = a_ai_zombies[i] getcentroid();
    if(distancesquared(v_turned_blast_pos, v_curr_zombie_origin) > f_turned_range_sq) {
      continue;
    }
    a_ai_zombies[i] dodamage(a_ai_zombies[i].health, v_curr_zombie_origin, attacker, attacker, "none", "MOD_IMPACT");
    n_random_x = randomfloatrange(-3, 3);
    n_random_y = randomfloatrange(-3, 3);
    a_ai_zombies[i] startragdoll(1);
    a_ai_zombies[i] launchragdoll(60 * (vectornormalize((v_curr_zombie_origin - v_turned_blast_pos) + (n_random_x, n_random_y, 10))), "torso_lower");
    n_flung_zombies++;
    if(-1 && n_flung_zombies >= 3) {
      break;
    }
  }
}

function turned_zombie_validation() {
  if(isDefined(level.aat["zm_aat_turned"].immune_result_direct[self.archetype]) && level.aat["zm_aat_turned"].immune_result_direct[self.archetype]) {
    return false;
  }
  if(isDefined(self.barricade_enter) && self.barricade_enter) {
    return false;
  }
  if(isDefined(self.is_traversing) && self.is_traversing) {
    return false;
  }
  if(!(isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
    return false;
  }
  if(isDefined(self.is_leaping) && self.is_leaping) {
    return false;
  }
  if(isDefined(level.zm_aat_turned_validation_override) && !self[[level.zm_aat_turned_validation_override]]()) {
    return false;
  }
  return true;
}

function zombie_death_time_limit(e_attacker) {
  self endon("death");
  self endon("entityshutdown");
  wait(20);
  self clientfield::set("zm_aat_turned", 0);
  self.allowdeath = 1;
  self zombie_death_gib(e_attacker);
}

function zombie_kill_tracker(e_attacker) {
  self endon("death");
  self endon("entityshutdown");
  while(self.n_aat_turned_zombie_kills < 12) {
    wait(0.05);
  }
  wait(0.5);
  self clientfield::set("zm_aat_turned", 0);
  self.allowdeath = 1;
  self zombie_death_gib(e_attacker);
}

function zombie_death_gib(e_attacker) {
  gibserverutils::gibhead(self);
  if(math::cointoss()) {
    gibserverutils::gibleftarm(self);
  } else {
    gibserverutils::gibrightarm(self);
  }
  gibserverutils::giblegs(self);
  self dodamage(self.health, self.origin);
}