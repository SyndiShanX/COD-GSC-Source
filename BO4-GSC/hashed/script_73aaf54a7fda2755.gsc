/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_73aaf54a7fda2755.gsc
***********************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_devgui;

#namespace namespace_1d05befd;

autoexec __init__system__() {
  system::register(#"hash_831eacd382054cc", &__init__, &__main__, undefined);
}

__init__() {
  spawner::add_archetype_spawn_function(#"zombie", &function_65089f84);
  clientfield::register("actor", "zm_ai/zombie_electric_fx_clientfield", 21000, 1, "int");
  clientfield::register("actor", "zombie_electric_burst_clientfield", 21000, 1, "counter");
  clientfield::register("actor", "zombie_electric_water_aoe_clientfield", 21000, 1, "counter");
  clientfield::register("actor", "zombie_electric_burst_stun_friendly_clientfield", 21000, 1, "int");
  clientfield::register("toplayer", "zombie_electric_burst_postfx_clientfield", 21000, 1, "counter");
  callback::on_player_damage(&function_4639701a);
  level.var_f8eb6737 = getstatuseffect(#"avogadro_shock_slowed");

  zm_devgui::function_c7dd7a17("<dev string:x38>", "<dev string:x41>");

}

__main__() {}

private function_65089f84() {
  if(isDefined(self.subarchetype) && self.subarchetype == #"zombie_electric") {
    zm_behavior::function_57d3b5eb();
    self thread clientfield::set("zm_ai/zombie_electric_fx_clientfield", 1);
    self.actor_killed_override = &function_1a47fb39;
  }
}

private function_4639701a(params) {
  if(isDefined(params.eattacker) && isDefined(params.eattacker.subarchetype) && isDefined(params.smeansofdeath) && params.eattacker.subarchetype == #"zombie_electric" && params.smeansofdeath == "MOD_MELEE") {
    self status_effect::status_effect_apply(level.var_f8eb6737, undefined, self, 0);
  }
}

private function_1a47fb39(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self thread clientfield::set("zm_ai/zombie_electric_fx_clientfield", 0);

  if(!(isDefined(self.water_damage) && self.water_damage)) {
    self thread zombie_utility::zombie_gib(idamage, attacker, vdir, self gettagorigin("j_spine4"), smeansofdeath, shitloc, undefined, undefined, weapon);
    var_e98404d8 = self getcentroid();
    gibserverutils::annihilate(self);
    function_25c6cba0(self, var_e98404d8);

    if(isDefined(self.b_in_water) && self.b_in_water) {
      self clientfield::increment("zombie_electric_water_aoe_clientfield");
      level thread function_79e38cc4(var_e98404d8);
    }
  }
}

private function_25c6cba0(entity, origin) {
  entity clientfield::increment("zombie_electric_burst_clientfield");
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    distance_sq = distancesquared(origin, players[i] getcentroid());

    if(isDefined(entity.b_in_water) && entity.b_in_water && isDefined(players[i].b_in_water) && players[i].b_in_water && distance_sq <= 250000) {
      players[i] status_effect::status_effect_apply(level.var_f8eb6737, undefined, players[i], 0);
      continue;
    }

    if(distance_sq <= 32400) {
      players[i] clientfield::increment_to_player("zombie_electric_burst_postfx_clientfield");
    }
  }

  zombies = getaiteamarray(level.zombie_team);

  foreach(zombie in zombies) {
    if(zombie.archetype == #"zombie" && (!isDefined(zombie.subarchetype) || zombie.subarchetype != #"zombie_electric") && isDefined(entity.b_in_water) && entity.b_in_water && isDefined(zombie.b_in_water) && zombie.b_in_water && distancesquared(origin, zombie.origin) <= 250000) {
      zombie clientfield::set("zombie_electric_burst_stun_friendly_clientfield", 1);
      zombie ai::stun(5);
      zombie thread function_ef1b9d42();
    }
  }
}

private function_ef1b9d42() {
  self endon(#"death");
  wait 5;
  self clientfield::set("zombie_electric_burst_stun_friendly_clientfield", 0);
}

private function_79e38cc4(origin) {
  var_74d136f5 = 0;
  time_step = 0.5;

  while(var_74d136f5 <= 1.5) {
    players = getplayers();

    for(i = 0; i < players.size; i++) {
      distance_sq = distancesquared(origin, players[i] getcentroid());

      if(isDefined(players[i].b_in_water) && players[i].b_in_water && distance_sq <= 40000) {
        players[i] status_effect::status_effect_apply(level.var_f8eb6737, undefined, players[i], 0);
      }
    }

    wait time_step;
    var_74d136f5 += time_step;
  }
}