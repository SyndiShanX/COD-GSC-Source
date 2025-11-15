/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_respin_cycle.gsc
**************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_bgb_respin_cycle;

autoexec __init__system__() {
  system::register(#"zm_bgb_respin_cycle", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_respin_cycle", "activated", 1, undefined, undefined, &validation, &activation);
  clientfield::register("zbarrier", "zm_bgb_respin_cycle", 1, 1, "counter");
}

validation() {
  for(i = 0; i < level.chests.size; i++) {
    chest = level.chests[i];

    if(isDefined(chest.zbarrier.weapon_model) && isDefined(chest.chest_user) && self == chest.chest_user) {
      return true;
    }
  }

  return false;
}

activation() {
  self endon(#"disconnect");

  for(i = 0; i < level.chests.size; i++) {
    chest = level.chests[i];

    if(isDefined(chest.zbarrier.weapon_model) && isDefined(chest.chest_user) && self == chest.chest_user) {
      chest thread function_80b33681(self);
    }
  }
}

function_80b33681(player) {
  self.zbarrier clientfield::increment("zm_bgb_respin_cycle");

  if(isDefined(self.zbarrier.weapon_model)) {
    self.zbarrier.weapon_model notify(#"kill_respin_think_thread");
  }

  self.no_fly_away = 1;
  self.zbarrier notify(#"box_hacked_respin");
  self.zbarrier playSound(#"zmb_bgb_powerup_respin");
  self thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
  self.zbarrier thread zm_magicbox::treasure_chest_weapon_spawn(self, player);
  self.zbarrier waittill(#"randomization_done");
  self.no_fly_away = undefined;

  if(!level flag::get("moving_chest_now")) {
    self.grab_weapon_hint = 1;
    self.grab_weapon = self.zbarrier.weapon;
    self thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
    self thread zm_magicbox::treasure_chest_timeout();
  }
}