/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_pop_shocks.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_pop_shocks;

function autoexec __init__sytem__() {
  system::register("zm_bgb_pop_shocks", &__init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_pop_shocks", "event", &event, undefined, undefined, undefined);
  bgb::register_actor_damage_override("zm_bgb_pop_shocks", &actor_damage_override);
  bgb::register_vehicle_damage_override("zm_bgb_pop_shocks", &vehicle_damage_override);
}

function event() {
  self endon("disconnect");
  self endon("death");
  self endon("bgb_update");
  self.var_69d5dd7c = 5;
  while(self.var_69d5dd7c > 0) {
    wait(0.1);
  }
}

function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(meansofdeath === "MOD_MELEE") {
    attacker function_e0e68a99(self);
  }
  return damage;
}

function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(smeansofdeath === "MOD_MELEE") {
    eattacker function_e0e68a99(self);
  }
  return idamage;
}

function function_e0e68a99(target) {
  if(isDefined(self.beastmode) && self.beastmode) {
    return;
  }
  self bgb::do_one_shot_use();
  self.var_69d5dd7c = self.var_69d5dd7c - 1;
  self bgb::set_timer(self.var_69d5dd7c, 5);
  self playSound("zmb_bgb_popshocks_impact");
  zombie_list = getaiteamarray(level.zombie_team);
  foreach(ai in zombie_list) {
    if(!isDefined(ai) || !isalive(ai)) {
      continue;
    }
    test_origin = ai getcentroid();
    dist_sq = distancesquared(target.origin, test_origin);
    if(dist_sq < 16384) {
      self thread electrocute_actor(ai);
    }
  }
}

function electrocute_actor(ai) {
  self endon("disconnect");
  if(!isDefined(ai) || !isalive(ai)) {
    return;
  }
  ai notify("bhtn_action_notify", "electrocute");
  if(!isDefined(self.tesla_enemies_hit)) {
    self.tesla_enemies_hit = 1;
  }
  create_lightning_params();
  ai.tesla_death = 0;
  ai thread arc_damage_init(self);
  ai thread tesla_death();
}

function create_lightning_params() {
  level.zm_bgb_pop_shocks_lightning_params = lightning_chain::create_lightning_chain_params(5);
  level.zm_bgb_pop_shocks_lightning_params.head_gib_chance = 100;
  level.zm_bgb_pop_shocks_lightning_params.network_death_choke = 4;
  level.zm_bgb_pop_shocks_lightning_params.should_kill_enemies = 0;
}

function arc_damage_init(player) {
  player endon("disconnect");
  if(isDefined(self.zombie_tesla_hit) && self.zombie_tesla_hit) {
    return;
  }
  self lightning_chain::arc_damage_ent(player, 1, level.zm_bgb_pop_shocks_lightning_params);
}

function tesla_death() {
  self endon("death");
  self thread function_862aadab(1);
  wait(2);
  self dodamage(self.health + 1, self.origin);
}

function function_862aadab(random_gibs) {
  self waittill("death");
  if(isDefined(self) && isactor(self)) {
    if(!random_gibs || randomint(100) < 50) {
      gibserverutils::gibhead(self);
    }
    if(!random_gibs || randomint(100) < 50) {
      gibserverutils::gibleftarm(self);
    }
    if(!random_gibs || randomint(100) < 50) {
      gibserverutils::gibrightarm(self);
    }
    if(!random_gibs || randomint(100) < 50) {
      gibserverutils::giblegs(self);
    }
  }
}