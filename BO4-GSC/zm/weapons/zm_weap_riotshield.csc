/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_riotshield.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_weapons;

#namespace zm_equip_shield;

autoexec __init__system__() {
  system::register(#"zm_equip_shield", &__init__, undefined, undefined);
}

__init__() {
  callback::on_spawned(&player_on_spawned);
  clientfield::register("toplayer", "zm_shield_damage_rumble", 1, 1, "counter", &zm_shield_damage_rumble, 0, 0);
  clientfield::register("toplayer", "zm_shield_break_rumble", 1, 1, "counter", &zm_shield_break_rumble, 0, 0);
  clientfield::register("clientuimodel", "ZMInventoryPersonal.shield_health", 1, 4, "float", undefined, 0, 0);
}

player_on_spawned(localclientnum) {
  self thread watch_weapon_changes(localclientnum);
}

watch_weapon_changes(localclientnum) {
  self endon(#"death");

  while(isDefined(self)) {
    waitresult = self waittill(#"weapon_change");
    w_current = waitresult.weapon;
    w_previous = waitresult.last_weapon;

    if(w_current.isriotshield) {
      for(i = 0; i < w_current.var_21329beb.size; i++) {
        util::lock_model(w_current.var_21329beb[i]);
      }

      continue;
    }

    if(w_previous.isriotshield) {
      for(i = 0; i < w_previous.var_21329beb.size; i++) {
        util::unlock_model(w_previous.var_21329beb[i]);
      }
    }
  }
}

zm_shield_damage_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrumbleonentity(localclientnum, "zm_shield_damage");
  }
}

zm_shield_break_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrumbleonentity(localclientnum, "zm_shield_break");
  }
}