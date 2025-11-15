/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_tundragun.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm\zm_orange_water;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_powerups;

#namespace zm_weap_tundragun;

autoexec __init__system__() {
  system::register(#"zm_weap_tundragun", &__init__, &__main__, undefined);
}

__init__() {
  level.w_tundragun = getweapon(#"tundragun");
  level.w_tundragun_upgraded = getweapon(#"tundragun_upgraded");
}

__main__() {
  zm::function_84d343d(#"tundragun", &actor_damage_override);
  zm::function_84d343d(#"tundragun_upgraded", &actor_damage_override);
}

actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(self.zm_ai_category === #"basic" || self.zm_ai_category === #"popcorn") {
    self.water_damage = 1;
    return (self.health + 666);
  }

  return damage;
}

private function_4baa4ca1() {
  var_648864c9 = 0;

  if(isDefined(self)) {
    var_648864c9 = self.no_gib;
    self.no_gib = 1;
  }

  wait 0.1;

  if(isDefined(self)) {
    self.no_gib = var_648864c9;
  }
}