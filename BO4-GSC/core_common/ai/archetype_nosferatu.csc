/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_nosferatu.csc
**************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace archetype_nosferatu;

autoexec __init__system__() {
  system::register(#"nosferatu", &__init__, undefined, undefined);
}

autoexec

__init__() {
  clientfield::register("actor", "nfrtu_leap_melee_rumb", 8000, 1, "counter", &function_5b1f1713, 0, 0);
}

function_5b1f1713(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  e_player = function_5c10bd79(localclientnum);
  n_dist = distancesquared(self.origin, e_player.origin);
  var_56cb57e3 = 200 * 200;
  n_scale = (var_56cb57e3 - n_dist) / var_56cb57e3;
  n_scale *= 0.75;

  if(n_scale > 0.01) {
    earthquake(localclientnum, n_scale, 0.1, self.origin, n_dist);

    if(n_scale >= 0.5) {
      function_36e4ebd4(localclientnum, "damage_heavy");
      return;
    }

    function_36e4ebd4(localclientnum, "damage_light");
  }
}