/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_pop_shocks.gsc
************************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\trials\zm_trial_headshots_only;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_stats;

#namespace zm_bgb_pop_shocks;

autoexec __init__system__() {
  system::register(#"zm_bgb_pop_shocks", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_pop_shocks", "event", &event, undefined, undefined, undefined);
  bgb::register_actor_damage_override(#"zm_bgb_pop_shocks", &actor_damage_override);
  bgb::register_vehicle_damage_override(#"zm_bgb_pop_shocks", &vehicle_damage_override);
  bgb::function_1fee6b3(#"zm_bgb_pop_shocks", 31);
}

event() {
  self endon(#"disconnect", #"death", #"bgb_update");
  self.var_727695ba = 5;

  while(self.var_727695ba > 0) {
    wait 0.1;
  }
}

actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(meansofdeath === "MOD_MELEE" && !zm_trial_headshots_only::is_active() && !zm_loadout::is_hero_weapon(weapon) && weapon != level.weaponnone) {
    attacker function_40383770(self);
  }

  return damage;
}

vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(smeansofdeath === "MOD_MELEE" && !zm_loadout::is_hero_weapon(weapon)) {
    eattacker function_40383770(self);
  }

  return idamage;
}

function_40383770(target) {
  if(isDefined(self.beastmode) && self.beastmode) {
    return;
  }

  self bgb::do_one_shot_use();
  self.var_727695ba -= 1;
  self bgb::set_timer(self.var_727695ba, 5);
  self playSound(#"zmb_bgb_popshocks_impact");
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

electrocute_actor(ai) {
  self endon(#"disconnect");

  if(!isDefined(ai) || !isalive(ai)) {
    return;
  }

  if(!isDefined(ai.zm_ai_category)) {
    return;
  }

  bhtnactionstartevent(ai, "electrocute");
  ai notify(#"bhtn_action_notify", {
    #action: "electrocute"
  });

  if(!isDefined(self.tesla_enemies_hit)) {
    self.tesla_enemies_hit = 1;
  }

  create_lightning_params();
  ai.tesla_death = 0;
  ai thread arc_damage_init(self);

  switch (ai.zm_ai_category) {
    case #"popcorn":
    case #"basic":
    case #"enhanced":
      ai thread tesla_death(self);
      break;
  }
}

create_lightning_params() {
  level.zm_bgb_pop_shocks_lightning_params = lightning_chain::create_lightning_chain_params(5);
  level.zm_bgb_pop_shocks_lightning_params.head_gib_chance = 100;
  level.zm_bgb_pop_shocks_lightning_params.network_death_choke = 4;
  level.zm_bgb_pop_shocks_lightning_params.should_kill_enemies = 0;
}

arc_damage_init(player) {
  player endon(#"disconnect");

  if(self ai::is_stunned()) {
    return;
  }

  self lightning_chain::arc_damage_ent(player, 1, level.zm_bgb_pop_shocks_lightning_params);
}

tesla_death(player) {
  self endon(#"death");
  player endon(#"disconnect");
  self thread function_f724a242(1);
  wait 2;
  player zm_stats::increment_challenge_stat(#"hash_133575f669ffc55c");

  foreach(weapon in player getweaponslist()) {
    if(weapon.statname == #"bowie_knife") {
      player stats::function_e24eec31(weapon, #"hash_657e22dcdd18da77", 1);
      player stats::inc_stat(#"item_stats", weapon.name, #"hash_657e22dcdd18da77", #"statvalue", 1);
    }
  }

  self dodamage(self.health + 1, self.origin, player, undefined, undefined, "MOD_ELECTROCUTED", 0, level.weapondefault);
}

function_f724a242(random_gibs) {
  self waittill(#"death");

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