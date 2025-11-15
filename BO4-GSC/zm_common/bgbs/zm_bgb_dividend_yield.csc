/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_dividend_yield.csc
****************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_dividend_yield;

autoexec __init__system__() {
  system::register(#"zm_bgb_dividend_yield", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  clientfield::register("allplayers", "" + #"hash_11a25fb3db96fc2d", 1, 1, "int", &function_441dc042, 0, 0);
  clientfield::register("toplayer", "" + #"hash_31b61c511ced94d7", 1, 1, "int", &function_1e792793, 0, 1);
  bgb::register(#"zm_bgb_dividend_yield", "time");
  level.var_b28c30ba = [];
}

function_441dc042(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_local_player = function_5c10bd79(localclientnum);

  if(newval) {
    if(e_local_player != self) {
      if(!isDefined(self.var_4399fda6)) {
        self.var_4399fda6 = [];
      }

      if(isDefined(self.var_4399fda6[localclientnum])) {
        return;
      }

      self.var_4399fda6[localclientnum] = util::playFXOnTag(localclientnum, "zombie/fx_bgb_profit_3p", self, "j_spine4");
    }

    return;
  }

  if(isDefined(self.var_4399fda6) && isDefined(self.var_4399fda6[localclientnum])) {
    stopfx(localclientnum, self.var_4399fda6[localclientnum]);
    self.var_4399fda6[localclientnum] = undefined;
  }
}

function_1e792793(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(level.var_b28c30ba[localclientnum])) {
      deletefx(localclientnum, level.var_b28c30ba[localclientnum]);
    }

    level.var_b28c30ba[localclientnum] = playfxoncamera(localclientnum, "zombie/fx_bgb_profit_1p", (0, 0, 0), (1, 0, 0));
    return;
  }

  if(isDefined(level.var_b28c30ba[localclientnum])) {
    stopfx(localclientnum, level.var_b28c30ba[localclientnum]);
    level.var_b28c30ba[localclientnum] = undefined;
  }
}