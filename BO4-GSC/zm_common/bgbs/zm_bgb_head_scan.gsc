/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_head_scan.gsc
***********************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_stats;

#namespace zm_bgb_head_scan;

autoexec __init__system__() {
  system::register(#"zm_bgb_head_scan", &__init__, undefined, "bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_head_scan", "time", 120, &enable, &disable, undefined, undefined);
  bgb::register_actor_damage_override(#"zm_bgb_head_scan", &function_ce76fa9f);
}

enable() {}

disable() {}

function_ce76fa9f(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!isDefined(self.zm_ai_category)) {
    return damage;
  }

  switch (shitloc) {
    case #"head":
    case #"helmet":
    case #"neck":
      switch (self.zm_ai_category) {
        case #"popcorn":
        case #"basic":
        case #"enhanced":
          if(math::cointoss(11)) {
            gibserverutils::gibhead(self);
            attacker zm_stats::increment_challenge_stat(#"hash_5d098efca02f7c99");
            return self.health;
          }

          break;
      }

      break;
    default:
      return damage;
  }

  return damage;
}