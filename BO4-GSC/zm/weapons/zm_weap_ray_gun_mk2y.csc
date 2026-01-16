/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_ray_gun_mk2y.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_ray_gun_mk2y;

autoexec __init__system__() {
  system::register(#"ray_gun_mk2y", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"hash_7772ff2676425bfb"] = #"hash_1993197e5796e1a3";
  level._effect[#"hash_776cf326763ddbe9"] = #"hash_198c2d7e5790e4f1";
  clientfield::register("allplayers", "" + #"ray_gun_mk2y_charged", 20000, 1, "int", &function_e1fdbb4b, 0, 0);
}

function_e1fdbb4b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_92a2b5f2)) {
    killfx(localclientnum, self.var_92a2b5f2);
    self.var_92a2b5f2 = undefined;
  }

  if(newval == 1) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      self.var_92a2b5f2 = playviewmodelfx(localclientnum, level._effect[#"hash_7772ff2676425bfb"], "tag_flash");
      return;
    }

    self.var_92a2b5f2 = util::playFXOnTag(localclientnum, level._effect[#"hash_776cf326763ddbe9"], self, "tag_flash");
  }
}