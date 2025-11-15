/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_refresh_mint.gsc
**************************************************/

#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_stats;

#namespace zm_bgb_refresh_mint;

autoexec __init__system__() {
  system::register(#"zm_bgb_refresh_mint", &__init__, undefined, "bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_refresh_mint", "activated", 1, undefined, undefined, undefined, &activation);
}

activation() {
  a_players = util::get_players();

  foreach(player in a_players) {
    w_lethal = player zm_loadout::get_player_lethal_grenade();

    if(w_lethal.isgadget) {
      n_slot = player gadgetgetslot(w_lethal);

      if(w_lethal == getweapon(#"tomahawk_t8") || w_lethal == getweapon(#"tomahawk_t8_upgraded")) {
        if(!player function_36dfc05f(n_slot)) {
          player notify(#"hash_3d73720d4588203c");
          player gadgetpowerset(n_slot, 100);
        }
      } else {
        player gadgetpowerreset(n_slot, 0);
      }
    }

    player thread function_556e219();

    for(i = 0; i < 4; i++) {
      player zm_perks::function_9b641809(i);
    }

    for(i = 0; i < player.var_67ba1237.size; i++) {
      player zm_perks::function_9829d4a9(i);
    }
  }
}

function_556e219() {
  self endon(#"death");

  if(isDefined(self.var_1f23fe79) && self.var_1f23fe79) {
    self waittill(#"hash_3eaa776332738598");
  }

  self gadgetpowerset(level.var_a53a05b5, 100);
}