/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_near_death_experience.csc
***********************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_near_death_experience;

autoexec __init__system__() {
  system::register(#"zm_bgb_near_death_experience", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  clientfield::register("allplayers", "zm_bgb_near_death_experience_3p_fx", 1, 1, "int", &function_f177aa9f, 0, 0);
  clientfield::register("toplayer", "zm_bgb_near_death_experience_1p_fx", 1, 1, "int", &function_70565a6d, 0, 1);
  bgb::register(#"zm_bgb_near_death_experience", "time");
  level.var_d066b29d = [];
}

function_f177aa9f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_local_player = function_5c10bd79(localclientnum);

  if(newval) {
    if(e_local_player != self) {
      if(!isDefined(self.var_5dacba16)) {
        self.var_5dacba16 = [];
      }

      if(isDefined(self.var_5dacba16[localclientnum])) {
        return;
      }

      self.var_5dacba16[localclientnum] = util::playFXOnTag(localclientnum, "zombie/fx_bgb_near_death_3p", self, "j_spine4");
    }

    return;
  }

  if(isDefined(self.var_5dacba16) && isDefined(self.var_5dacba16[localclientnum])) {
    stopfx(localclientnum, self.var_5dacba16[localclientnum]);
    self.var_5dacba16[localclientnum] = undefined;
  }
}

function_70565a6d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(level.var_d066b29d[localclientnum])) {
      deletefx(localclientnum, level.var_d066b29d[localclientnum]);
    }

    level.var_d066b29d[localclientnum] = playfxoncamera(localclientnum, "zombie/fx_bgb_near_death_1p", (0, 0, 0), (1, 0, 0));
    return;
  }

  if(isDefined(level.var_d066b29d[localclientnum])) {
    stopfx(localclientnum, level.var_d066b29d[localclientnum]);
    level.var_d066b29d[localclientnum] = undefined;
  }
}