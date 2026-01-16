/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red_oracle_boons.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;

#namespace zm_red_oracle_boons;

autoexec __init__system__() {
  system::register(#"zm_red_oracle_boons", &__init__, undefined, undefined);
}

__init__() {
  n_bits = getminbitcountfornum(4);
  clientfield::register("item", "" + #"hash_7e5c581ade235dfc", 16000, n_bits, "int", &function_c0d2e1a2, 0, 0);
  clientfield::register("toplayer", "" + #"hash_403e80cafccc207c", 16000, 1, "int", &function_e634058b, 0, 0);
}

function_c0d2e1a2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval > 0) {
    e_player = getentbynum(localclientnum, newval - 1);
    a_e_players = getlocalplayers();

    if(array::contains(a_e_players, e_player)) {
      self thread function_cd5f9803(localclientnum);
      self playrenderoverridebundle(#"hash_46a64e44ebfa3078");
    }

    return;
  }

  level notify(#"hash_5a7453176272efff");
}

private function_cd5f9803(localclientnum) {
  self waittill(#"hash_5a7453176272efff", #"death");

  if(isDefined(self)) {
    self stoprenderoverridebundle(#"hash_46a64e44ebfa3078");
  }
}

private function_e634058b(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    self thread postfx::playpostfxbundle(#"hash_2b92b9e84c59cfe4");
    return;
  }

  self thread postfx::exitpostfxbundle(#"hash_2b92b9e84c59cfe4");
}