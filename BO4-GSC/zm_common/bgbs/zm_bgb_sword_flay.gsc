/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_sword_flay.gsc
************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_stats;

#namespace zm_bgb_sword_flay;

autoexec __init__system__() {
  system::register(#"zm_bgb_sword_flay", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_sword_flay", "time", 60, &enable, &disable, undefined);
  bgb::register_actor_damage_override(#"zm_bgb_sword_flay", &actor_damage_override);
  bgb::register_vehicle_damage_override(#"zm_bgb_sword_flay", &vehicle_damage_override);
}

enable() {}

disable() {}

actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(meansofdeath === "MOD_MELEE" && weapon != level.weaponnone) {
    if(isalive(self)) {
      switch (self.zm_ai_category) {
        case #"popcorn":
        case #"basic":
        case #"enhanced":
          damage = self.health + damage * 5;
          break;
        default:
          damage *= 5;
          break;
      }
    }
  }

  return damage;
}

vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(smeansofdeath === "MOD_MELEE") {
    idamage *= 5;
  }

  return idamage;
}