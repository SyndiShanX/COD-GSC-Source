/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\aats\zm_aat_kill_o_watt.csc
*************************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\zm_utility;

#namespace zm_aat_kill_o_watt;

autoexec __init__system__() {
  system::register("zm_aat_kill_o_watt", &__init__, undefined, undefined);
}

__init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }

  aat::register("zm_aat_kill_o_watt", #"hash_17fd44c733f7c66b", "t7_icon_zm_aat_dead_wire");
  clientfield::register("actor", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter", &function_d2ca081b, 0, 0);
  clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter", &function_d2ca081b, 0, 0);
  clientfield::register("actor", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int", &function_846837f, 0, 0);
  clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int", &function_846837f, 0, 0);
}

function_846837f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    str_fx_tag = self zm_utility::function_467efa7b(1);

    if(!isDefined(str_fx_tag)) {
      str_fx_tag = "tag_origin";
    }

    self.var_548620a = util::playFXOnTag(localclientnum, "zm_weapons/fx8_aat_elec_torso", self, str_fx_tag);
    self.var_9fddda59 = util::playFXOnTag(localclientnum, "zm_weapons/fx8_aat_elec_eye", self, "j_eyeball_le");

    if(!isDefined(self.var_6a8124b)) {
      self.var_6a8124b = self playLoopSound("zmb_aat_kilowatt_stunned_lp");
    }

    return;
  }

  if(isDefined(self.var_548620a)) {
    stopfx(localclientnum, self.var_548620a);
    self.var_548620a = undefined;
    stopfx(localclientnum, self.var_9fddda59);
    self.var_9fddda59 = undefined;

    if(isDefined(self.var_6a8124b)) {
      self stoploopsound(self.var_6a8124b);
      self.var_6a8124b = undefined;
    }
  }
}

function_d2ca081b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    v_fx_origin = self gettagorigin(self zm_utility::function_467efa7b(1));

    if(!isDefined(v_fx_origin)) {
      v_fx_origin = self.origin;
    }

    playFX(localclientnum, "zm_weapons/fx8_aat_elec_exp", v_fx_origin);
    self playSound(localclientnum, #"zmb_aat_kilowatt_explode");
  }
}