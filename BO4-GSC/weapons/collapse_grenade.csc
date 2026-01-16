/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\collapse_grenade.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace collapsegrenade;

autoexec __init__system__() {
  system::register(#"collapsegrenade", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "collapsesphereflag", 1, 1, "int", &function_fe37390, 0, 0);
  clientfield::register("toplayer", "playerincollapsegrenade", 1, 1, "int", &function_6f48ad35, 0, 0);
}

function_fe37390(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  self playrenderoverridebundle(#"hash_75168376918f5ab7");
  self function_78233d29(#"hash_75168376918f5ab7", "", "Scale", 1);
}

function_6f48ad35(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue == 1) {
    self codeplaypostfxbundle(#"hash_7c7ea03189fe65d8");
    self.var_d8c2003e = playfxoncamera(localclientnum, "wz/fx8_plyr_pstfx_barrier_lvl_01_wz", (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self.var_7b79495b = function_239993de(localclientnum, "wz/fx8_player_outside_circle", self, "tag_origin");
    return;
  }

  self codestoppostfxbundle(#"hash_7c7ea03189fe65d8");

  if(isDefined(self.var_d8c2003e)) {
    deletefx(localclientnum, self.var_d8c2003e, 1);
    self.var_d8c2003e = undefined;
  }

  if(isDefined(self.var_7b79495b)) {
    killfx(localclientnum, self.var_7b79495b);
    self.var_7b79495b = undefined;
  }
}