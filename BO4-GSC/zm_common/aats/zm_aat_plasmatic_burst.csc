/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\aats\zm_aat_plasmatic_burst.csc
*****************************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_aat_plasmatic_burst;

autoexec __init__system__() {
  system::register("zm_aat_plasmatic_burst", &__init__, undefined, undefined);
}

__init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }

  aat::register("zm_aat_plasmatic_burst", #"hash_164d02d599d1fa8f", "t7_icon_zm_aat_blast_furnace");
  clientfield::register("actor", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter", &zm_aat_plasmatic_burst_explosion, 0, 0);
  clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter", &zm_aat_plasmatic_burst_explosion, 0, 0);
  clientfield::register("actor", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int", &function_7abfa551, 0, 0);
  clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int", &function_a98c42a3, 0, 0);
  level._effect[#"zm_aat_plasmatic_burst"] = "zm_weapons/fx8_aat_plasmatic_burst_torso";
}

zm_aat_plasmatic_burst_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    str_fx_tag = self zm_utility::function_467efa7b(1);

    if(!isDefined(str_fx_tag)) {
      str_fx_tag = "tag_origin";
    }

    self playSound(localclientnum, #"hash_6990e5a39e894c04");
    util::playFXOnTag(localclientnum, level._effect[#"zm_aat_plasmatic_burst"], self, str_fx_tag);
  }
}

function_7abfa551(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    str_tag = "j_spine4";
    v_tag = self gettagorigin(str_tag);

    if(!isDefined(v_tag)) {
      str_tag = "tag_origin";
    }

    self function_c36aebed(localclientnum, str_tag);
    return;
  }

  self function_b4d21494(localclientnum);
}

function_a98c42a3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    str_tag = "tag_body";
    v_tag = self gettagorigin(str_tag);

    if(!isDefined(v_tag)) {
      str_tag = "tag_origin";
    }

    self function_c36aebed(localclientnum, str_tag);
    return;
  }

  self function_b4d21494(localclientnum);
}

function_c36aebed(localclientnum, tag) {
  self.var_def62862 = util::playFXOnTag(localclientnum, "zm_weapons/fx8_aat_plasmatic_burst_torso_fire", self, tag);
  self.var_4a87444e = util::playFXOnTag(localclientnum, "zm_weapons/fx8_aat_plasmatic_burst_head", self, "j_head");

  if(!isDefined(self.var_fa3f8eb7)) {
    self.var_fa3f8eb7 = self playLoopSound(#"hash_645b60f29309dc9b");
  }
}

function_b4d21494(localclientnum) {
  if(isDefined(self.var_fa3f8eb7)) {
    self stoploopsound(self.var_fa3f8eb7);
  }

  if(isDefined(self.var_def62862)) {
    stopfx(localclientnum, self.var_def62862);
  }

  if(isDefined(self.var_4a87444e)) {
    stopfx(localclientnum, self.var_4a87444e);
  }
}