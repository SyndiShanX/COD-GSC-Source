/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_cymbal_monkey.csc
************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_cymbal_monkey;

autoexec __init__system__() {
  system::register(#"zm_weap_cymbal_monkey", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "" + #"hash_60a7e5b79e8064a5", 1, 1, "int", &monkey_spawns, 0, 0);

  if(isDefined(level.legacy_cymbal_monkey) && level.legacy_cymbal_monkey) {
    level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
  } else {
    level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
  }

  if(!zm_weapons::is_weapon_included(getweapon(#"cymbal_monkey"))) {
    return;
  }
}

monkey_spawns(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    waitframe(1);
    v_up = (360, 0, 0);
    v_forward = (0, 0, 360);

    if(isDefined(self)) {
      playFX(localclientnum, "maps/zm_white/fx8_monkey_bomb_reveal", self.origin, v_forward, v_up);
      self playSound(localclientnum, #"hash_21206f1b7fb27f81");
    }
  }
}