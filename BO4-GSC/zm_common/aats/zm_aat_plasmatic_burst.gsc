/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\aats\zm_aat_plasmatic_burst.gsc
*****************************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\trials\zm_trial_headshots_only;
#include scripts\zm_common\zm_stats;

#namespace zm_aat_plasmatic_burst;

autoexec __init__system__() {
  system::register("zm_aat_plasmatic_burst", &__init__, undefined, #"aat");
}

__init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }

  aat::register("zm_aat_plasmatic_burst", 0.15, 0, 30, 5, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, 2);
  clientfield::register("actor", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter");
  clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter");
  clientfield::register("actor", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int");
  clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int");
}

result(death, attacker, mod, weapon) {
  self thread function_988b8f91(attacker, weapon);
}

function_988b8f91(e_attacker, w_weapon) {
  if(self.birthtime == gettime()) {
    waitframe(1);

    if(!isalive(self)) {
      return;
    }
  }

  self thread clientfield::increment("zm_aat_plasmatic_burst" + "_explosion");
  level notify(#"plasmatic_burst", {
    #var_ac85a15f: self
  });
  a_e_blasted_zombies = array::get_all_closest(self.origin, getaiteamarray(#"axis"), undefined, undefined, 120);

  if(a_e_blasted_zombies.size > 0) {
    waitframe(1);

    for(i = 0; i < a_e_blasted_zombies.size; i++) {
      if(isalive(a_e_blasted_zombies[i])) {
        if(isDefined(level.aat[#"zm_aat_plasmatic_burst"].immune_result_indirect[a_e_blasted_zombies[i].archetype]) && level.aat[#"zm_aat_plasmatic_burst"].immune_result_indirect[a_e_blasted_zombies[i].archetype]) {
          arrayremovevalue(a_e_blasted_zombies, a_e_blasted_zombies[i]);
          continue;
        }

        if(a_e_blasted_zombies[i] == self && !(isDefined(level.aat[#"zm_aat_plasmatic_burst"].immune_result_direct[a_e_blasted_zombies[i].archetype]) && level.aat[#"zm_aat_plasmatic_burst"].immune_result_direct[a_e_blasted_zombies[i].archetype])) {
          self thread zombie_death_gib(e_attacker, w_weapon);
          arrayremovevalue(a_e_blasted_zombies, a_e_blasted_zombies[i]);
          continue;
        }

        a_e_blasted_zombies[i] thread clientfield::set("zm_aat_plasmatic_burst" + "_burn", 1);
        util::wait_network_frame();
      }
    }

    wait 0.25;
    a_e_blasted_zombies = array::remove_dead(a_e_blasted_zombies);
    a_e_blasted_zombies = array::remove_undefined(a_e_blasted_zombies);

    foreach(var_8eee7949 in a_e_blasted_zombies) {
      if(isDefined(var_8eee7949)) {
        var_8eee7949 thread function_cd252d6e(e_attacker, w_weapon);
        util::wait_network_frame(randomintrange(1, 3));
      }
    }
  }
}

function_cd252d6e(e_attacker, w_weapon) {
  self endon(#"death");
  self.var_1e7e5205 = 1;
  var_70ab6bc = int(0.5 * 3333.33);
  i = 0;

  while(i <= 6) {
    self dodamage(var_70ab6bc, self.origin, e_attacker, undefined, "none", "MOD_AAT", 0, w_weapon);

    if(!isalive(self) && isplayer(e_attacker)) {
      e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_plasmatic_burst");
    }

    i++;
    wait 0.5;
  }

  if(self ishidden()) {
    while(self ishidden()) {
      wait 0.5;
    }

    wait 0.5;
  }

  self.var_1e7e5205 = undefined;
  self thread clientfield::set("zm_aat_plasmatic_burst" + "_burn", 0);
}

zombie_death_gib(e_attacker, w_weapon) {
  if(isDefined(level.headshots_only) && level.headshots_only || zm_trial_headshots_only::is_active()) {
    return;
  }

  if(isDefined(self.var_ba1bd9b2) && self.var_ba1bd9b2) {
    return;
  }

  self clientfield::set("zm_aat_plasmatic_burst" + "_burn", 1);
  gibserverutils::gibhead(self);

  if(math::cointoss()) {
    gibserverutils::gibleftarm(self);
  } else {
    gibserverutils::gibrightarm(self);
  }

  gibserverutils::giblegs(self);
  self dodamage(self.health, self.origin, e_attacker, e_attacker, "none", "MOD_AAT", 0, w_weapon);

  if(isplayer(e_attacker)) {
    e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_plasmatic_burst");
  }
}